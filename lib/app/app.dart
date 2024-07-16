import 'package:cat_and_dog/features/bloc/app_color_bloc.dart';
import 'package:cat_and_dog/features/bloc/storage_bloc.dart';
import 'package:cat_and_dog/features/cats/cats.dart';
import 'package:cat_and_dog/features/dogs/dogs.dart';
import 'package:cat_and_dog/features/repo/storage_repo.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cat_and_dog/app/page/move_app_page.dart';
import 'package:cat_and_dog/features/features.dart';
import 'package:cat_and_dog/features/splash/splash_page.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData base = ThemeData.light();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //TODO: bloc in main
      providers: [
        BlocProvider(create: (_) => StorageBLoc(GetIt.I.get<StorageRepo>())..add(StorageFetch())),
        BlocProvider(create: (_) => AppColorBLoc()),
        BlocProvider(create: (_) => CatBloc(GetIt.I.get<CatRepo>())..add(CatFetched())),
        BlocProvider(create: (_) => DogBloc(GetIt.I.get<DogRepo>())..add(DogFetched())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           scaffoldBackgroundColor: Colors.white,
        // Sử dụng Google Fonts cho toàn bộ ứng dụng
        textTheme: GoogleFonts.comicNeueTextTheme(),
          fontFamily: 'Quicksand',
          primarySwatch: Colors.blue,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {}
              ..addAll(base.pageTransitionsTheme.builders)
              ..addAll({TargetPlatform.android: const CupertinoPageTransitionsBuilder()}),
          ),
          appBarTheme: base.appBarTheme.copyWith(
            centerTitle: true,
            titleTextStyle: const TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
            elevation: 0,
          ),
          
          navigationBarTheme: base.navigationBarTheme.copyWith(
            height: 56,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          ),
          actionIconTheme: ActionIconThemeData(
            backButtonIconBuilder: (context) {
              return const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xff2FC4B1));
            },
          ),
        ),
        navigatorKey: navigatorKey,
        onGenerateRoute: generateRoute,
        navigatorObservers: [GetIt.I.get<FirebaseAnalyticsObserver>()],
        builder: (BuildContext context, Widget? child) {
          ErrorWidget.builder = (details) {
            Widget? error;
            final exception = details.exception;
            /// hotfix hide adwidget render when release
            if (!kDebugMode && exception is FlutterError) {
              final String message = exception.message;
              if (message.contains('This AdWidget is already in the Widget tree')) {
                error = const SizedBox.shrink();
              }
            }
            error ??= Center(
              child: Text(
                kDebugMode ? 'Error!\n$exception' : '...rendering error...',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),
            );

            if (child is Scaffold || child is Navigator) error = Scaffold(body: error);
            return error;
          };

          return child ?? Container();
        },
      ),
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case Routers.root:
        page = const SplashIntro();
        break;
      case Routers.splash:
        page = const SplashIntro();
      case Routers.moveApp:
        page = MoveAppPage(
          storeLink: "",
          onPopInvoked: (context) => Navigator.maybeOf(context)?.maybePop(),
        );
        break;
      case Routers.home:
        page = const HomePage();
      default:
        page = const SplashIntro();
        break;
    }
    return MaterialPageRoute(settings: settings, builder: (_) => page);
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final StorageBLoc bloc;
  @override
  void initState() {
    bloc = context.read<StorageBLoc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const content = SplashPage();
    return BlocConsumer<StorageBLoc, StorageState>(
      listener: ((context, state) {
        Navigator.pushNamed(context, Routers.splash);
        // if (state.status == StorageStatus.successNotIntro) {
        //   Navigator.pushNamed(context, Routers.home);
        // }
        // if (state.status == StorageStatus.successIntro) {
        //   Navigator.pushNamed(context, Routers.splash);
        // }
      }),
      builder: (context, state) {
        return content;
      },
    );
  }
}
