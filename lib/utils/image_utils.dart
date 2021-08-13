import 'package:flutter/cupertino.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class ImageUtils {
  static const pkm_loading = _Image("pkm_loading.gif");
  static const char_walking = _Image("char_walking.gif");
  static const dragon_swim = _Image("dragon_swim.gif");
  static const pika_surf = _Image("pika_surf.gif");
  static const pika_run = _Image("pika_run_font.gif");
  static const pika_smile = _Image("icon_pikachu.png");
  static const pokeball_logo = _Image("pokeball_2.png");
  static const pokeball_black = _Image("ic_pkball_item.png");
}
