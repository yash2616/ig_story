class AppManager {

  AppManager._();

  static final AppManager _instance = AppManager._();

  factory AppManager() {
    return _instance;
  }

  late final String _userCollection;
  late final String _storyCollection;

  void setUserCollection(String collectionName) {
    _userCollection = collectionName;
  }

  void setStoryCollection(String collectionName) {
    _storyCollection = collectionName;
  }

  String getUserCollection() {
    return _userCollection;
  }

  String getStoryCollection() {
    return _storyCollection;
  }

}