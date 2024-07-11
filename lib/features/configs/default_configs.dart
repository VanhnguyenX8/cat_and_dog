/// not change
const String dbName = String.fromEnvironment('dbName', defaultValue: 'caAndDog.db');
const String protocol = String.fromEnvironment('protocol', defaultValue: 'https');
const List<String> allowSchemaWebview = ['http', 'https', 'file', 'chrome', 'data', 'javascript', 'about'];
const int connectTimeout = int.fromEnvironment('connectTimeout', defaultValue: 60); // seconds
const int recieveTimeout = int.fromEnvironment('recieveTimeout', defaultValue: 60); // seconds
const int sendTimeout = int.fromEnvironment('sendTimeout', defaultValue: 60); // seconds

// config app
const String minVersion = String.fromEnvironment('minVersion', defaultValue: '0.0.0');
const String latestVersion = String.fromEnvironment('latestVersion', defaultValue: '0.0.0');
const bool forceUpdate = bool.fromEnvironment('forceUpdate', defaultValue: false);
const int popupRatingAfter = int.fromEnvironment('popupRatingAfter', defaultValue: 86400); // seconds
const bool showMoveApp = bool.fromEnvironment('showMoveApp', defaultValue: false);

/// store links, fanpage,..
/// TODO: import store links, fanpage
/// domain
const String domain = String.fromEnvironment('domain', defaultValue: 'xgamestudio.com');
const String apiBaseUrl = String.fromEnvironment('apiBaseUrl', defaultValue: '$protocol://$domain/api/v1');
const String authBaseUrl = String.fromEnvironment('authBaseUrl', defaultValue: '$protocol://$domain');
const String mainOrigin = String.fromEnvironment('mainOrigin', defaultValue: '$protocol://$domain');
const String webviewOrigin = String.fromEnvironment('webviewOrigin', defaultValue: '$protocol://$domain');