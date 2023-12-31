import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WordSeeker/pages/home.dart';
// import 'package:WordSeeker/pages/home_page.dart';
import 'package:WordSeeker/providers/controller_5.dart';
// import 'package:WordSeeker/providers/controller_4.dart';
// import 'package:WordSeeker/pages/home_page.dart';
import 'package:WordSeeker/providers/theme_provider.dart';
import 'package:WordSeeker/utils/theme_preferences.dart';
import 'package:WordSeeker/constants/themes.dart';


void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> Controller_5()),
        // ChangeNotifierProvider(create: (_)=> Controller_4()),
        ChangeNotifierProvider(create: (_)=> ThemeProvider()),
      ],
      child: FutureBuilder(
        initialData: false,
        future: ThemePreferences.getTheme(),
        builder: (context, snapshot) {
         
          if(snapshot.hasData){
    
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
      Provider.of<ThemeProvider>(context, listen: false).setTheme(turnOn: 
            snapshot.data as bool);
            
          });
    
            
          }
    
    
          return Consumer <ThemeProvider>(
          builder:(_,notifier,__) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Word Seeker',
            theme: notifier.isDark ? darkTheme : lightTheme, 
            home: const  Home(),
          ),
        );
        },
      ),
    );
  }
}
