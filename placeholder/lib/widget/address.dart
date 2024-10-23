import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'kopo_model.dart'; // KopoModel import

class AddressSearchPage extends StatefulWidget {
  final Function(KopoModel) callback;

  AddressSearchPage({required this.callback});

  @override
  _AddressSearchPageState createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {
  @override
  void initState() {
    super.initState();
    js.context.callMethod("aa");
    js.context['flutter_inappwebview'] = js.JsObject.jsify({
      'callHandler': (String handlerName, String address) {
        if (handlerName == 'onAddressSelected') {
          print('선택된 주소: $address');
          widget.callback(KopoModel(address: address, zonecode: ''));
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주소 검색"),
      ),
      body: Center(
        child: Text("주소 검색 중..."),
      ),
    );
  }
}
