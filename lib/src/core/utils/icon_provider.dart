enum IconProvider {
  error(imageName: 'error.png'),
  icon(imageName: 'icon.png'),
  appbar(imageName: 'appbar.png'),
  cback(imageName: 'cback.png'),
  ichic(imageName: 'ichic.svg'),
  bback(imageName: 'bback.png'),
  menu(imageName: 'menu.png'),
  logo(imageName: 'logo.png'),
  plus(imageName: 'plus.svg'),
  mask(imageName: 'mask.png'),
  top(imageName: 'top.png'),
  nop(imageName: 'nop.svg'),

  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
