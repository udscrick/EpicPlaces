import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage; //With the latest version of FLutter, null safety is introduced, so we must use late
  //to let flutter know that we will initialize it later
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
                _storedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : const Text('No Image Selected',textAlign: TextAlign.center,),
        alignment: Alignment.center,
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
          child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.camera),
        label: Text(
          'Take Picture',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ))
    ]);
  }
}
