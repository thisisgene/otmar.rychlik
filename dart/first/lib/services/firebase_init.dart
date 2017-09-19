import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

@Injectable()
class FirebaseService {




  FirebaseService() {
    fb.initializeApp(
        apiKey: "AIzaSyAr0Syw8nfvs79Yd6w42pX3ley3KFecDNs",
        authDomain: "otmar-rychlik.firebaseapp.com",
        databaseURL: "https://otmar-rychlik.firebaseio.com",
        storageBucket: "otmar-rychlik.appspot.com"
    );


  }
}