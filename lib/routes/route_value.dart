enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  statistic(
    path: 'detailed',
  ),
  articles(
    path: '/articles',
  ),

  article(
    path: 'article',
  ),
  rituals(
    path: '/rituals',
  ),
  ritual(
    path: 'ritual',
  ),

  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
