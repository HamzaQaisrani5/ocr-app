import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ocr_app/presentation/bloc/image_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ocr'.toString()),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          alertDialog(context, BlocProvider.of<ImageBloc>(context));
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<ImageBloc, ImageState>(
        builder: (_, state) {
          if (state is ImageInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('No Image yet. . . ', style: TextStyle(fontSize: 18)),
                  // SizedBox(height: ,)
                  Text('No result!', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          } else if (state is ImageFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_outlined,
                    color: Colors.redAccent,
                    size: 35,
                  ),
                  SizedBox(height: 6),
                  Text(state.errorMsg, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Reload'),
                  ),
                ],
              ),
            );
          } else if (state is ImageSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.file(state.image!, fit: BoxFit.contain),
                ),
                SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(state.recognizeText ?? 'Can\'t recognized'),
                ),
                // extractTextView(state)
              ],
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProgressIndicator(color: Colors.teal),
                CircularProgressIndicator(color: Colors.teal),
              ],
            ),
          );
        },
        listener: (_, state) {
          if (state is ImageFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Can\'t upload Image!'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ImageLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Uploading . . . '),
                backgroundColor: Colors.orange,
              ),
            );
          } else if (state is ImageSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Image Uploaded'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }
}

void alertDialog(BuildContext context, ImageBloc provider) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    provider.add(CameraImageRequest());
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.teal,
                    size: 50,
                  ),
                ),
                SizedBox(height: 3),
                Text('Camera', textAlign: TextAlign.center),
              ],
            ),
            SizedBox(width: 5),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<ImageBloc>().add(GalleryImageRequest());
                  },
                  icon: Icon(Icons.image, color: Colors.pink, size: 50),
                ),
                SizedBox(height: 3),
                Text('Gallery', textAlign: TextAlign.center),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// Widget extractTextView(ImageSuccess succes){
//   return Center( 
//     child: succes.image==null?Text('No Result'):Text(extractText(succes.image!).toString()),
//   );
// }

// Future<String?> extractText(File file) async {
//   try {
//   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//   final InputImage inputImage = InputImage.fromFile(file);
//   final RecognizedText processImage = await textRecognizer.processImage(inputImage);
//   return processImage.text;
//   } catch (e) {
//   log('ERROR: ${e.toString()}');
     
//   }
// }