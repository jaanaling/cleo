enum IconProvider {
  add(imageName: 'add.png'),
  addRounded(imageName: 'add_rounded.png'),
  advice(imageName: 'advice.png'),
  arrow(imageName: 'arrow.png'),
  articleBack(imageName: 'article_back.webp'),
  articleButton(imageName: 'article_button.webp'),
  adviceBack(imageName: 'advice_back.webp'),
  articles(imageName: 'articles.png'),
  back(imageName: 'back.png'),
  background(imageName: 'background.webp'),
  blueButton(imageName: 'blue_button.png'),
  bluredBackground(imageName: 'blured_background.webp'),
  bottomBarBack(imageName: 'bottom_bar_back.png'),
  bottomBarSelected(imageName: 'bottom_bar_selected.png'),
  calories(imageName: 'calories.png'),
  chart(imageName: 'chart.png'),
  close(imageName: 'close.png'),
  closeRounded(imageName: 'close_rounded.png'),
  dailyRituals(imageName: 'daily_rituals.png'),
  day(imageName: 'day.png'),
  food(imageName: 'food.png'),
  foodBack(imageName: 'food_back.png'),
  greenButton(imageName: 'green_button.png'),
  home(imageName: 'home.png'),
  hygiene(imageName: 'hygiene.png'),
  loaderBack(imageName: 'loader_back.webp'),
  logo(imageName: 'logo.webp'),
  mascot(imageName: 'mascot.webp'),
  mentalHealth(imageName: 'mental_health.png'),
  month(imageName: 'month.png'),
  naturalPractices(imageName: 'natural_practices.png'),
  nutrition(imageName: 'nutrition.png'),
  physicalActivity(imageName: 'physical_activity.png'),
  privacy(imageName: 'privacy.png'),
  progress(imageName: 'progress.png'),
  progressBack(imageName: 'progress_back.png'),
  search(imageName: 'search.png'),
  searchPanel(imageName: 'search_panel.png'),
  selfCare(imageName: 'self_care.png'),
  sleep(imageName: 'sleep.png'),
  sleepBack(imageName: 'sleep_back.png'),
  sleepRest(imageName: 'sleep_rest.png'),
  socialConnections(imageName: 'social_connections.png'),
  splash(imageName: 'splash.webp'),
  startButton(imageName: 'start_button.png'),
  statistic(imageName: 'statistic.png'),
  switchBack(imageName: 'switch_back.png'),
  timeOfSleep(imageName: 'time_of_sleep.png'),
  water(imageName: 'water.png'),
  waterBack(imageName: 'water_back.png'),
  waterBalance(imageName: 'water_balance.png'),
  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
