import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'interface.dart' as interfaces;

import 'data_structeres.dart';
import 'package:http/http.dart' as http;

String url_image = "https://picsum.photos/200/300?random=1";
String url =
    "https://gist.githubusercontent.com/nanotaboada/6396437/raw/855dd84436be2c86e192abae2ac605743fc3a127/books.json";
bool need_reload = false;

Future<Books> fetchAlbum(interfaces.ErrorCallBack callBack1,
    interfaces.ErrorCallBack callBack2) async {
  final response = await http.get(Uri.parse(url)).timeout(
    const Duration(seconds: 20),
    onTimeout: () {
      //print("sdfsdff");
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    },
  );
  if (response.statusCode == 200) {
    callBack2();
    return Books.fromJson(jsonDecode(response.body));
  } else {
    if (response.statusCode == 408) {
      callBack1();
    }
    return Books(books: []);
  }

  ////
  /*final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Books.fromJson(jsonDecode(response.body));
  } else {
    return Books(books: []);
  }*/
}

class PreviewVideoWidget extends StatefulWidget {
  String filename;
  double width;
  double height;
  double image_radius;
  PreviewVideoWidget(
      {Key? key,
      required this.filename,
      required this.width,
      required this.height,
      this.image_radius = -1})
      : super(key: key);
  @override
  _LoadImagesLocaly createState() => new _LoadImagesLocaly(
      this.filename, this.width, this.height, this.image_radius);
}

class _LoadImagesLocaly extends State<PreviewVideoWidget> {
  _LoadImagesLocaly(String filename, width, height, image_radius);

  String _filename = "";
  var _full_path = "";
  double _width = 0;
  double _height = 0;
  var _dataBytes;
  var _visible = false;
  double _image_radius = 0;
  last_state() {
    try {
      setState(() {
        _visible = true;
        if (widget.image_radius == -1) {
          _image_radius = interfaces.normal_list_image_width;
        } else {
          _image_radius = widget.image_radius;
        }
      });
    } on Exception catch (exception) {
      // globals.play_sound_effects_error = true;
      return 0;
      //.//.. // only executed if error is of type Exception
    } catch (error) {
      // globals.play_sound_effects_error = true;
      return 0;
      // ... // executed for errors of all types other than Exception
    }
  }

  setValue() {
    setState(() {
      _filename = widget.filename.toString();
      _width = widget.width;
      _height = widget.height;
      downloadImage().then((bytes) {
        setState(() {
          _dataBytes = bytes;
        });
        last_state();
      });
    });
  }

  void initState() {
    var _visible = false;
    setState(() {
      need_reload = false;
    });
    super.initState();

    setValue();
  }

  /*Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
*/
  /*Future<dynamic> readImageFromLocalStorage(String filename) async {
    String dir = await _localPath;
    File file = new File('$dir/$filename');
    print('$dir/$filename');
    print(file.existsSync().toString());
    if (file.existsSync()) {
      var image = await file.readAsBytes();
      return image;
    } else {
      return null;
    }
  }*/

  Future<dynamic> downloadImage() async {
    //var image = await readImageFromLocalStorage(_filename);
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(_filename)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();

    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /* return Container(
        color: Colors.blue,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Colors.yellow,
          ),
        ));*/
    if (_dataBytes != null) {
      return SizedBox(
        // color: Colors.yellow,
        //  height: _height,
        //  width: _width,
        height: 150, //_height,
        width: 150, //_width,

        child: ClipRRect(
          borderRadius: BorderRadius.circular(_image_radius),
          child: _dataBytes == ""
              ? Container(
                  color: interfaces.bg_dot_menu,
                  height: _height,
                  width: _width,

                  //  width: 100,
                  //  height: 100,
                )
              : Container(
                  // color: Colors.blue,

                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.memory(
                      _dataBytes,
                      //   height: _height,
                      //   width: _width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
        ),
      );
    } else
      return SizedBox(
        child: Container(),
        // height: 10.0,
        // width: 10.0,
      );
  }
}

Future<Uint8List> downloadImage1(String filename) async {
  //var image = await readImageFromLocalStorage(_filename);
  final ByteData imageData =
      await NetworkAssetBundle(Uri.parse(filename)).load("");
  final Uint8List bytes = imageData.buffer.asUint8List();

  return bytes;
}
