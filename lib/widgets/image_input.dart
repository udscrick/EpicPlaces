

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;


class ImageInput extends StatefulWidget {
  
  // const ImageInput({Key? key}) : super(key: key);
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage; //With the latest version of FLutter, null safety is introduced, so we must use ?
  //to let flutter know that we will initialize it later and the value can be null

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 600);
     if(imageFile==null){
       return;
     }
      setState(() {
        _storedImage = File(imageFile.path);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path); //Path where the image is currently stored in the temp directory
      final savedImage = await _storedImage.copy('${appDir.path}/$fileName');//Saving image to permanent device storage
      widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 200,
        height: 100,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.green)),
        child: _storedImage != null
            ? Image.file(
                _storedImage,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : const Text(
                'No Image Selected',
                textAlign: TextAlign.center,
              ),
        alignment: Alignment.center,
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
          child: TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera),
        label: Text(
          'Take Picture',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ))
    ]);
  }
}
