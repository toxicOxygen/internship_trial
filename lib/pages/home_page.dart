import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  //a route name to help navigate to this screen
  static const route = "/";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //the dynamic link
  String _linkMessage;

  //to disable buttons when we are creating our dynamic links
  bool _isCreatingLink = false;


  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }


  void initDynamicLinks() async{
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final deepLink = data?.link;

    if(deepLink != null){
      Navigator.of(context).pushNamed(deepLink.path);
    }

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (dynamicLink)async{
        final deepLink = dynamicLink?.link;

        if(deepLink != null){
          Navigator.of(context).pushNamed(deepLink.path);
        }
      },
      onError: (e) async{
        print(e.message);
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: !_isCreatingLink
                    ? () => _createDynamicLink(false)
                    : null,
                child: const Text('Get Long Link'),
              ),
              RaisedButton(
                onPressed: !_isCreatingLink
                    ? () => _createDynamicLink(true)
                    : null,
                child: const Text('Get Short Link'),
              ),
            ],
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _linkMessage??'',
                style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            onLongPress: (){
              Clipboard.setData(ClipboardData(text: _linkMessage));
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Linked copied!'),
                duration: Duration(seconds: 5),
              ));
            },
          )
        ],
      ),
    );
  }



  Future<void> _createDynamicLink(bool isShort) async{
    setState(() => _isCreatingLink = true);

    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://kinstugidevs.page.link',
      link: Uri.parse('https://kinstugidevs.com/invitation-page'),
      androidParameters: AndroidParameters(
        packageName: 'www.kinstugidevs.com.internship_interview',
        minimumVersion: 16
      ),
      iosParameters: IosParameters(
        bundleId: 'www.kinstugidevs.com.internship_interview'
      )
    );

    Uri url;

    if(isShort){
      final shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    }else{
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      print(_linkMessage);
      _isCreatingLink = false;
    });
  }
}
