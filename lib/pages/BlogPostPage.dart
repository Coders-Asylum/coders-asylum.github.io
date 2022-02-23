import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      primaryColor: Color(0xffD3D3D3),
      highlightColor: Color(0xff727272),
      backgroundColor: Color(0xff1E1E1E),
      shadowColor: Color(0xff000000),
    );

    return MaterialApp(
      theme: appTheme.copyWith(colorScheme: appTheme.colorScheme.copyWith(secondary: Color(0xff1366C8))),
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.amber,
          child: Scrollbar(
            showTrackOnHover: true,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FeaturedPostImage(),
                  PostBodyWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturedPostImage extends StatefulWidget {
  @override
  _FeaturedPostImageState createState() => _FeaturedPostImageState();
}

class _FeaturedPostImageState extends State<FeaturedPostImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      ///todo: use widget dimensions.
      height: 506,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, -1.0),
          end: Alignment(1.0, 1.0),
          colors: [Color(0xffCD5D7D), Color(0xffEA9ABB), Color(0xffA6B1E1), Color(0xff424874)],
          stops: [0.0, 0.35, 0.65, 1.0],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [PostHeaderDetails()],
      ),
    );
  }
}

class PostHeaderDetails extends StatefulWidget {
  _PostHeaderDetailsState createState() => _PostHeaderDetailsState();
}

class _PostHeaderDetailsState extends State<PostHeaderDetails> {
  final String s = 'lkdasdlsad;lsdlsadl';
  final TextStyle ts = TextStyle(fontFamily: 'Gobold', fontSize: 96.0);

  ///todo: implement time data function in service file.
  String postDateTime(DateTime time) {
    final DateTime toLocal = time.toLocal();
    final DateTime currentInLocal = DateTime.now().toLocal();

    ///todo: write function to convert date to appropriate string definition.
    if (currentInLocal.difference(toLocal) <= Duration(hours: 23)) {}
    return 's';
  }

  late bool textSizeCheck;

  bool varyTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
    )..layout();

    if (textPainter.size.width > MediaQuery.of(context).size.width * 0.75) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.textSizeCheck = varyTextSize(s, ts);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.75,
      margin: EdgeInsets.fromLTRB(32.0, 16.0, 16.0, 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // category container.
          Container(height: 45.0, width: MediaQuery.of(context).size.width * 0.75, child: Text('Category', style: TextStyle(fontFamily: 'Orbitron', fontSize: 18.0))),
          // Post title container.
          Flexible(
            child: Text(s, style: TextStyle(fontFamily: 'Gobold', fontSize: this.textSizeCheck ? 56 : 96.0)),
          ),
          Container(height: 45.0, width: MediaQuery.of(context).size.width * 0.75, child: Text(DateTime.now().toString(), style: TextStyle(fontFamily: 'Orbitron', fontSize: 18.0))),
        ],
      ),
    );
  }
}

class BlogPageContent extends StatefulWidget {
  @override
  _BlogPageContentState createState() => _BlogPageContentState();
}

class _BlogPageContentState extends State<BlogPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

class PostBodyWidget extends StatefulWidget {
  _PostBodyWidgetState createState() => _PostBodyWidgetState();
}

class _PostBodyWidgetState extends State<PostBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(0xff1e1e1e)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LeftSidebar(),
          ArticleBody(),
          RightSideBar(),
        ],
      ),
    );
  }
}

class RightSideBar extends StatefulWidget {
  _RightSideBarState createState() => _RightSideBarState();
}

class _RightSideBarState extends State<RightSideBar> {
  List<CategorisedPostsWidget> topPosts = [];
  List<CategorisedPostsWidget> recentPosts = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Breadcrumbs(route: [BreadCrumbRoute(name: 'Home', url: ''), BreadCrumbRoute(name: 'Blog', url: ''), BreadCrumbRoute(name: 'Category', url: '')]),
          TagsLineWidget(),
          CategorisedPostsWidget(title: 'Top Posts', posts: [CategorisedPosts(title: 'New Google Feature Highlights the Search Results on External Websites.', author: 'test Author', link: '')]),
          CategorisedPostsWidget(title: 'Latest Posts', posts: [CategorisedPosts(title: 'New Google Feature Highlights the Search Results on External Websites.', author: 'test Author', link: '')]),
        ],
      ),
    );
  }
}

class LeftSidebar extends StatefulWidget {
  _LeftSidebarState createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArticleAuthor(),
          LikePostButtons(),
          SharePostButtons(),
        ],
      ),
    );
  }
}

/// To change the text color of a url on appropriate mouse action.
enum MouseActionOnText {
  /// When the mouse is not over the text.
  normal,

  /// When the mouse is hovered over the text.
  hover,

  /// When the link/text is clicked.
  active
}

/// Container for each route data and its properties.
class BreadCrumbRoute {
  final String name;
  final String url;
  MouseActionOnText action;

  BreadCrumbRoute({required this.name, required this.url, this.action = MouseActionOnText.normal});
}

/// Generated Breadcrumb Navigation Ui from the passed [BreadCrumbRoute] list.
class Breadcrumbs extends StatefulWidget {
  final List<BreadCrumbRoute> route;

  const Breadcrumbs({Key? key, required this.route}) : super(key: key);

  _BreadcrumbsState createState() => _BreadcrumbsState();
}

class _BreadcrumbsState extends State<Breadcrumbs> {
  /// Returns the color of the text according to the [action] on the text.
  Color setTextColor(MouseActionOnText action) {
    switch (action) {
      case MouseActionOnText.active:
        return Color(0xff1366C8);
      case MouseActionOnText.hover:
        return Color(0xffE8E8E8);
      case MouseActionOnText.normal:
        return Color(0xff9E9E9E);
      default:
        return Color(0xff9E9E9E);
    }
  }

  /// Generates the Breadcrumb nav UI element.
  List<TextSpan> generateBreadcrumbRoute() {
    late List<TextSpan> _l = [];

    widget.route.forEach((r) {
      if (widget.route.last == r) {
        r.action = MouseActionOnText.active;
        _l.add(TextSpan(
            text: "${r.name} ",
            style: TextStyle(color: setTextColor(r.action)),
            recognizer: TapGestureRecognizer()..onTap = () => setState(() => r.action = MouseActionOnText.active),
            onEnter: (m) => setState(() => r.action = MouseActionOnText.hover),
            onExit: (m) => setState(() => r.action = MouseActionOnText.normal)));
      } else {
        _l.add(TextSpan(
            text: "${r.name} ",
            style: TextStyle(color: setTextColor(r.action)),
            recognizer: TapGestureRecognizer()..onTap = () => setState(() => r.action = MouseActionOnText.active),
            onEnter: (m) => setState(() => r.action = MouseActionOnText.hover),
            onExit: (m) => setState(() => r.action = MouseActionOnText.normal)));
      }
      _l.add(TextSpan(text: ' /  ', style: TextStyle(color: Colors.white)));
    });
    return _l;
  }

  static const double margin = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.fromLTRB(margin * 3, margin * 2, margin * 2, margin),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2.0, color: Colors.blueAccent))),
      padding: EdgeInsets.only(right: 5.0, bottom: 6.0),
      alignment: Alignment.centerLeft,
      child: FittedBox(fit: BoxFit.contain, child: RichText(text: TextSpan(children: generateBreadcrumbRoute()))),
    );
  }
}

class ArticleBody extends StatefulWidget {
  _ArticleBodyState createState() => _ArticleBodyState();
}

class _ArticleBodyState extends State<ArticleBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Color(0xff343434)),
      child: RichText(softWrap: true, overflow: TextOverflow.visible, text: TextSpan(style: TextStyle(fontSize: 18.0, color: Color(0xffE8E8E8)), children: [TextSpan(text: testText)])),
    );
  }
}

String testText = '''
This comes after the Eric Yuan Zoom CEO’s meeting with the investors on Tuesday. Zoom says that end to end encryption won’t be provided to the free user’s which means law enforcement agencies can look into your video calls.

“Free users — for sure we don’t want to give [them] that, because we also want to work together with the FBI, with local law enforcement, in case some people use Zoom for a bad purpose.” – Eric Yuan, Zoom CEO.

Concern regarding the security and privacy provided by Zoom has increased after the usage of platform has heavily increased since the COVID19 Pandemic and many weak points were also revealed since then.

This won’t eradicate the abuse on the platform but will reduce it. Since Zoom’s Trust and Safety team can enter a meeting visibly and report it if it’s abusive. End to end encryption would not allow the trust and safety team to enter a meeting. Zoom also says that there is no backdoor where a user can enter a meeting and not been seen.

With the business and enterprise users getting the end to end encryption feature organization such as schools and few who are in the business plan but not paying will get the end to end encryption feature.

Zoom plans to provide end to end encryption to users who can be verified, Zoom says that free users log in using their email id which is not enough to verify an individual so end to end encryption is not provided to them.

Zoom hasn’t provided a release date for this update.

Advertisements
[
''';

class AuthorInfoPost extends StatefulWidget {
  ///todo: insert Author as required parameter.
  _AuthorInfoPostState createState() => _AuthorInfoPostState();
}

class _AuthorInfoPostState extends State<AuthorInfoPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.only(right: 8.0, left: 8.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 2.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Profile Image
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 110.0,
                width: 110.0,

                ///todo: add IconImage Widget if url found null.
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://avatars.githubusercontent.com/u/32545664?v=4'), fit: BoxFit.fill),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3.0)),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Author name
              Container(
                width: 120,
                height: 70.0,
                padding: EdgeInsets.all(4.0),
                child: Text('Adithya Shetty', maxLines: 2, softWrap: true, style: TextStyle(color: Colors.blueAccent, fontSize: 26, overflow: TextOverflow.ellipsis)),
              ),
              // user name
              Container(
                width: 120,
                height: 20.0,
                padding: EdgeInsets.all(2.0),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '@Maverick099',
                    style: TextStyle(color: Colors.grey, fontSize: 16.0, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LikePostButtons extends StatefulWidget {
  _LikePostButtonsState createState() => _LikePostButtonsState();
}

class _LikePostButtonsState extends State<LikePostButtons> {
  static const double radius = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width * 0.20,
      margin: EdgeInsets.fromLTRB(16.0, 8.0, 32.0, 8.0),
      padding: EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.9), width: 0.5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          // like
          Container(
            height: radius,
            width: radius,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 6.0, right: 6.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: IconButton(onPressed: () {}, color: Colors.black, icon: Icon(Icons.thumb_up_alt_rounded), iconSize: radius - 15),
          ),
          // dislike
          Container(
            height: radius,
            width: radius,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 6.0, right: 6.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: IconButton(onPressed: () {}, color: Colors.black, icon: Icon(Icons.thumb_down_alt_rounded), iconSize: radius - 15),
          ),
        ],
      ),
    );
  }
}

typedef SharePostFunction = VoidCallback Function(String post);

/// A Single SharePostButton to share the post to
class SharePostButton {
  final String? imageUrl;
  final String name;
  final IconData? icon;
  final double radius;
  final Color backgroundColor;
  final Color iconColor;
  final String? tooltip;
  final VoidCallback trigger;

  const SharePostButton(
      {required this.name, required this.trigger, this.imageUrl, this.icon, this.radius = 15.0, this.backgroundColor = const Color(0xff343434), this.iconColor = Colors.white, this.tooltip})
      : assert(imageUrl == null || icon == null, 'Specify either image url or icon for the share button'),
        assert((radius - 5) >= 5, 'Radius should be greater or equal to 10');

  Widget get widget {
    return Container(
      height: this.radius,
      width: this.radius,
      decoration: BoxDecoration(shape: BoxShape.circle, color: this.backgroundColor),
      margin: EdgeInsets.all(4.0),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {},
        child: this.icon == null
            ? Container(
                height: this.radius - 5,
                width: this.radius - 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(this.imageUrl!), fit: BoxFit.contain),
                ),
              )
            : Container(
                height: this.radius,
                width: this.radius,
                child: Icon(this.icon, color: this.iconColor, size: this.radius - 15),
              ),
      ),
    );
  }
}

class SharePostButtons extends StatefulWidget {
  const SharePostButtons({Key? key}) : super(key: key);

  _SharePostButtonsState createState() => _SharePostButtonsState();
}

class _SharePostButtonsState extends State<SharePostButtons> {
  final SharePostButton fbShareButton = SharePostButton(name: 'facebook', trigger: () {}, radius: 40.0, imageUrl: 'lib/assets/social/facebook.png', tooltip: 'Share on Facebook');
  final SharePostButton liShareButton = SharePostButton(name: 'linkedin', trigger: () {}, radius: 40.0, imageUrl: 'lib/assets/social/linkedin.png', tooltip: 'Share on LinkedIn');
  final SharePostButton twShareButton = SharePostButton(name: 'twitter', trigger: () {}, radius: 40.0, imageUrl: 'lib/assets/social/twitter.png', tooltip: 'Share on Twitter');
  final SharePostButton linkShareButton = SharePostButton(name: 'link', trigger: () {}, radius: 40.0, icon: Icons.link_rounded, tooltip: 'Get Link');

  static const double margin = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      margin: EdgeInsets.fromLTRB(margin * 2, margin, margin * 4, margin),
      padding: EdgeInsets.only(bottom: margin * 2),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.8), width: 0.5))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 15.0,
            margin: EdgeInsets.only(bottom: 6.0),
            //padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 6.0),
            child: Text('Share:', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [fbShareButton.widget, twShareButton.widget, liShareButton.widget, linkShareButton.widget],
          ),
        ],
      ),
    );
  }
}

class TagsLineWidget extends StatefulWidget {
  _TagsLineWidgetState createState() => _TagsLineWidgetState();
}

class _TagsLineWidgetState extends State<TagsLineWidget> {
  ///todo: add post parameter.
  List<String> tagList = ['tag1', 'tag2', 'tag3'];

  List<TextSpan> generateBreadcrumbRoute() {
    late List<TextSpan> _l = [];

    tagList.forEach((tag) {
      _l.add(TextSpan(text: "#$tag ", style: TextStyle(color: Colors.grey, fontSize: 16.0), recognizer: TapGestureRecognizer()..onTap = () => setState(() {})));
    });
    return _l;
  }

  static const double margin = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(margin * 3, margin * 4, margin * 2, margin),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.9), width: 0.5))),
      child: FittedBox(fit: BoxFit.contain, child: RichText(text: TextSpan(children: generateBreadcrumbRoute()))),
    );
  }
}

/// todo add Post and Author class as final fields.
class CategorisedPosts {
  final String title;
  final String author;
  final String link;

  const CategorisedPosts({required this.title, required this.author, required this.link});
}

/// todo: change to post and then extract only title and author name.
class TopPosts extends CategorisedPosts {
  final String title;
  final String author;
  final String link;

  TopPosts({required this.title, required this.author, this.link = ''}) : super(author: author, title: title, link: link);
}

class CategorisedPostsWidget extends StatefulWidget {
  final String title;
  final List<CategorisedPosts> posts;

  const CategorisedPostsWidget({Key? key, required this.title, required this.posts})
      : assert(posts.length <= 6, 'Only 6 post data should be passed in'),
        super(key: key);

  _CategorisedPostsWidgetState createState() => _CategorisedPostsWidgetState();
}

class _CategorisedPostsWidgetState extends State<CategorisedPostsWidget> {
  ///todo: add font style additional parameters.

  final TextStyle postTitleStyle = TextStyle(color: Colors.white);

  bool varyTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
    )..layout();

    if (textPainter.size.width > MediaQuery.of(context).size.width * 0.20) {
      return true;
    } else {
      return false;
    }
  }

  List<Widget> generateListWidget() {
    List<Widget> _l = [];
    final double margin = 8.0;
    _l.add(Container(
      height: 60.0,
      margin: EdgeInsets.fromLTRB(margin * 3, margin * 4, margin * 2, margin),
      padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 4.0))),
      child: FittedBox(fit: BoxFit.fitHeight, child: Text(widget.title, style: TextStyle(color: Colors.blueAccent, fontSize: 40), softWrap: true, overflow: TextOverflow.visible)),
    ));

    widget.posts.forEach((post) {
      bool _varyTextSize = varyTextSize(post.title, postTitleStyle);
      _l.add(Container(
        height: 70.0,
        margin: EdgeInsets.fromLTRB(margin * 3, 6.0, margin * 2, 5.0),
        padding: EdgeInsets.fromLTRB(0.0, 0.2, 0.0, 6.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: 40.0,
                child: RichText(
                  text: TextSpan(text: post.title, style: postTitleStyle..copyWith(fontSize: _varyTextSize ? 18 : 30), recognizer: TapGestureRecognizer()..onTap = () => print('open ${post.link}')),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                )),
            Container(height: 20, child: Text('by: ${post.author}', style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis, fontSize: 12.0))),
          ],
        ),
      ));
    });
    return _l;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: generateListWidget(),
      ),
    );
  }
}

class ArticleAuthor extends StatefulWidget {
  _ArticleAuthorState createState() => _ArticleAuthorState();
}

class _ArticleAuthorState extends State<ArticleAuthor> {
  static const double margin = 8.0;
  static const Duration closeDur = const Duration(milliseconds: 150);
  static const Duration openDur = const Duration(milliseconds: 200);

  final GlobalKey key = GlobalKey();

  Offset get position {
    final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    final Offset _pos = box.localToGlobal(Offset.zero);
    return _pos;
  }

  bool visible = false;
  bool authorDetailsVisible = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: visible ? openDur : closeDur,
      height: visible ? 250.0 : 70.0,
      margin: EdgeInsets.fromLTRB(margin * 2, margin, margin * 4, margin),
      padding: EdgeInsets.only(bottom: margin * 2),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.9), width: 0.5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(height: 20.0, alignment: Alignment.centerLeft, child: Text('Written By: ', style: TextStyle(color: Colors.grey, fontSize: 16.0))),
          Container(
            height: 30.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 2.0),
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.visible,
              softWrap: true,
              text: TextSpan(text: '@MavericK099', style: TextStyle(color: Colors.blue, fontSize: 22.0), onEnter: (m) => setState(() => visible = !visible)),
            ),
          ),
          AnimatedContainer(
            duration: visible ? openDur + Duration(milliseconds: 100) : closeDur - Duration(milliseconds: 50),
            height: visible ? 170 : 0.0,
            child: Visibility(
              visible: visible,
              child: CustomPaint(painter: ArticleAuthorCustomContainer(), child: MouseRegion(onExit: (m) => setState(() => visible = !visible), child: AuthorInfoPost())),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleAuthorCustomContainer extends CustomPainter {
  final Path path = Path();
  final Paint containerPaint = Paint()..color = Colors.white.withOpacity(0.8);

  @override
  void paint(Canvas canvas, Size size) {
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.15, 0);
    path.lineTo(size.width * 0.17, -5);
    path.lineTo(size.width * 0.19, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    canvas.drawPath(path, containerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
