enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  detailed(
    path: 'detailed',
  ),
  create(
    path: 'create',
  ),

  chicken(
    path: 'chicken',
  ),
 task(
    path: 'task',
  ),
 history(
    path: 'history',
  ),

  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
