import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/Providers/user_details_provider.dart';
//import 'package:flutter/rendering.dart';
import 'package:flutter_guide/Screens/sign_in_screen.dart';
import 'package:flutter_guide/Resources/resources_auth_method.dart';
import 'package:flutter_guide/layout/screen_layout.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBAPNOsiDPI22J7dhpN1Oiw4UsPxPHjKA8",
            authDomain: "clone-1c5f5.firebaseapp.com",
            projectId: "clone-1c5f5",
            storageBucket: "clone-1c5f5.appspot.com",
            messagingSenderId: "271650681383",
            appId: "1:271650681383:web:f2e529b8c25f7979f6d402"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}
class AmazonClone extends StatelessWidget {
  const AmazonClone({super.key});


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserDetailsProvider())
      ],
      child: MaterialApp(
        title: "Amazon Clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData
            .light(), //.copyWith(scaffoldBackgroundColor: backgroundColor)
    
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }else if (user.hasData){
                
                return ScreenLayout();
                  
              
              }//else{
                return const SignInScreen();
              //}
            }),
      ),
    );

    //);
  }
}
  
                                    
                                   
                                            
                                    