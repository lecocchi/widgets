import 'dart:html';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Home();
  }
}

class _Home extends StatefulWidget {
  @override
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  String _urlImage;
  String _urlDocument;
  String _urlAudio;
  bool _isImageLoading;
  bool _isDocumentLoading;
  bool _isAudioLoading;
  bool _isPlay;
  AssetsAudioPlayer assetsAudioPlayer;

  @override
  void initState() {
    assetsAudioPlayer = new AssetsAudioPlayer();
    _isPlay = false;
    _isImageLoading = false;
    _isDocumentLoading = false;
    _isAudioLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POC Storage'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUploadImage(),
              SizedBox(height: 10),
              (_isImageLoading)
                  ? _uploading('Imagen')
                  : _urlImage != null
                      ? Image.network(
                          _urlImage,
                          width: 300,
                        )
                      : Container(),
              _buildDivider(),
              _buildUploadDocument(),
              SizedBox(height: 10),
              (_isDocumentLoading)
                  ? _uploading('Documento')
                  : _urlDocument != null
                      ? _buildDownloadDocument()
                      : Container(),
              _buildDivider(),
              _buildUploadAudio(),
              SizedBox(height: 10),
              (_isAudioLoading)
                  ? _uploading('Audio')
                  : _urlAudio != null ? _buildPlayAudio() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      width: 320,
      height: 2,
      color: Colors.black12,
      margin: EdgeInsets.symmetric(vertical: 15),
    );
  }

  Widget _buildUploadImage() {
    return MaterialButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.cloud_upload, color: Colors.white),
            SizedBox(width: 10),
            Text('Subir Imagen',
                style: TextStyle(color: Colors.white, fontSize: 18))
          ],
        ),
        color: Colors.pinkAccent,
        minWidth: 250,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        onPressed: () => _uploadImage());
  }

  void _uploadImage() {
    final accept = 'image/*';

    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.accept = accept;
    uploadInput.click();

    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files.first;

        final reader = FileReader();

        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (_) async {
            final url = await _uploadImageToStorage(file);

            setState(() {
              _urlImage = url.toString();
              _isImageLoading = false;
            });
          },
        );
      },
    );
  }

  Future<String> _uploadImageToStorage(File file) async {
    setState(() {
      _isImageLoading = true;
    });

    fb.UploadTaskSnapshot uploadTaskSnapshot = await fb
        .storage()
        .ref('images/${DateTime.now()}-${file.name}')
        .put(file)
        .future;

    Uri uri = await uploadTaskSnapshot.ref.getDownloadURL();
    return uri.toString();
  }

  Widget _buildUploadDocument() {
    return MaterialButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.cloud_upload, color: Colors.white),
            SizedBox(width: 10),
            Text('Subir Documento',
                style: TextStyle(color: Colors.white, fontSize: 18))
          ],
        ),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minWidth: 250,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        onPressed: () => _uploadDocument());
  }

  void _uploadDocument() {
    setState(() {
      _urlDocument = null;
    });

    final accept = '.doc, .docx,.txt';

    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.accept = accept;
    uploadInput.click();

    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files.first;

        final reader = FileReader();

        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (_) async {
            final url = await _uploadDocumentToStorage(file);

            setState(() {
              _urlDocument = url;
              _isDocumentLoading = false;
            });
          },
        );
      },
    );
  }

  Future<String> _uploadDocumentToStorage(File file) async {
    setState(() {
      _isDocumentLoading = true;
    });

    fb.UploadTaskSnapshot uploadTaskSnapshot = await fb
        .storage()
        .ref('documents/${DateTime.now()}-${file.name}')
        .put(file)
        .future;

    Uri uri = await uploadTaskSnapshot.ref.getDownloadURL();

    return uri.toString();
  }

  bool isValidTypeFile(String accept, String file) {
    return accept.split(",").any((type) => file.endsWith(type));
  }

  Widget _buildDownloadDocument() {
    return MaterialButton(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.cloud_download, color: Colors.white),
          SizedBox(width: 10),
          Text('Descargar Documento',
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ]),
        color: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        minWidth: 250,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () => _downloadDocument(_urlDocument));
  }

  void _downloadDocument(String url) {
    // window.open(url, 'PlaceholderName');

    AnchorElement anchorElement = new AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  Widget _buildUploadAudio() {
    return MaterialButton(
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.cloud_upload, color: Colors.white),
        SizedBox(width: 10),
        Text('Subir Audio',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ]),
      color: Colors.orange,
      minWidth: 250,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () => _uploadAudio(),
    );
  }

  void _uploadAudio() {
    setState(() {
      _urlAudio = null;
    });

    final accept = '.mp3';

    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.accept = accept;
    uploadInput.click();

    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files.first;

        final reader = FileReader();

        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (_) async {
            final url = await _uploadAudioToStorage(file);

            setState(() {
              _urlAudio = url;
              _isAudioLoading = false;
            });
          },
        );
      },
    );
  }

  Future<String> _uploadAudioToStorage(File file) async {
    setState(() {
      _isAudioLoading = true;
    });

    fb.UploadTaskSnapshot uploadTaskSnapshot = await fb
        .storage()
        .ref('audios/${DateTime.now()}-${file.name}')
        .put(file)
        .future;

    Uri uri = await uploadTaskSnapshot.ref.getDownloadURL();

    return uri.toString();
  }

  Widget _buildPlayAudio() {
    return AudioWidget.network(
      child: MaterialButton(
        child: Icon(
          _isPlay ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 50,
        ),
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.symmetric(vertical: 17),
        onPressed: () {
          setState(() {
            _isPlay = !_isPlay;
          });
        },
      ),
      url: _urlAudio,
      play: _isPlay,
      onFinished: () {
        print("termino la cancion");
        setState(() {
          _isPlay = !_isPlay;
        });
      },
    );
  }

  Widget _uploading(String type) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(),
          SizedBox(width: 15),
          Text('Subiendo $type...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ]),
      ),
    );
  }
}

// Stream that returns list of links docs
// Stream<List<Map<String, dynamic>>> userLinks(fs.Firestore firestore) {
//   return firestore
//       .collection('links')
//       .onSnapshot
//       .map((data) => data.docs.map((doc) => doc.data()).toList());
// }
