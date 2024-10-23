import 'package:flutter/material.dart';
import 'package:placeholder/widget/address.dart';
import 'package:placeholder/widget/kopo_model.dart';

class RemediKopo extends StatefulWidget {
  final Function(KopoModel) callback;

  RemediKopo({required this.callback});

  @override
  _RemediKopoState createState() => _RemediKopoState();
}

class _RemediKopoState extends State<RemediKopo> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddressSearchPage(callback: widget.callback),
          ),
        );
      },
      tooltip: '주소 검색',
    );
  }
}
