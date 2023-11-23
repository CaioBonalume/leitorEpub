import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

Future<void> openReader(BuildContext context, String epubPath) async {
  VocsyEpub.setConfig(
    themeColor: Theme.of(context).primaryColor,
    scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
    allowSharing: true,
    enableTts: true,
    nightMode: true,
  );

  return VocsyEpub.open(epubPath);
}
