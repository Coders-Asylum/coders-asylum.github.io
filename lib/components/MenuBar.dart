import 'package:flutter/material.dart';

/// Menu bar that goes on the top of the
class MenuBar extends StatefulWidget {
  /// PageController for controlling the navigation of the pages when the menu tab is pressed.
  final PageController pageController;

  const MenuBar({Key? key, required this.pageController}) : super(key: key);

  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  /// The height of the menu bar.
  static const double _menuBarHeight = 52.0;

  /// The height of the tabs inside the menu bar.
  static const double _tabHeight = 30.0;

  /// The width of the tabs inside the menu bar.
  static const double _tabWidth = 130.0;

  /// List of [MenuTab]s that goes on to the menu bar.
  ///
  /// This should have the same sequence as the sequence of the page that it is intended to navigate to.
  static const List<MenuTab> _tabs = [
    MenuTab(title: 'Home', tabIcon: Icons.home_rounded),
    MenuTab(title: 'Flutter 101', imageIcon: AssetImage('lib/assets/res/flutterio-icon.png')),
    MenuTab(title: 'Python 101', imageIcon: AssetImage('lib/assets/res/python-icon.png')),
    MenuTab(title: 'Blog', tabIcon: Icons.book_rounded),
    MenuTab(title: 'Tutorials', tabIcon: Icons.code_rounded),
  ];

  /// Holds the index of the current page.
  late int page = 0;

  /// sets the index of the current page to [page]
  set _currentPage(int p) => setState(() => page = p);

  @override
  void initState() {
    page = widget.pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'menuBar',
      child: Container(
        height: _menuBarHeight,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // name place holder.
            Visibility(
              visible: widget.pageController.initialPage == page ? false : true,
              child: Container(
                width: 200.0,
                height: _tabHeight,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'CODERS', style: TextStyle(fontFamily: 'Gobold', color: Theme.of(context).primaryColor)),
                    TextSpan(text: ' ASYLUM', style: TextStyle(fontFamily: 'Orbitron', color: Theme.of(context).primaryColor)),
                  ])),
                ),
              ),
            ),
            // Menu tabs holder.
            Container(
              height: _menuBarHeight,
              width: _tabs.length * (_tabWidth + 16),
              child: MenuItems(tabs: _tabs, tabHeight: _tabHeight, tabWidth: _tabWidth, pageController: widget.pageController, currentPage: (page) => _currentPage = page),
            ),
          ],
        ),
      ),
    );
  }
}

/// A void function that passes the current page as a parameter
typedef CurrentPage = void Function(int p);

/// This class creates all the menu items.
///
/// Also handles the page change.
class MenuItems extends StatefulWidget {
  /// Tabs to create the menu items from.
  final List<MenuTab> tabs;

  /// The height of the menu tabs.
  final double tabHeight;

  /// The width of the menu tabs.
  final double tabWidth;

  /// [PageController] to change the pages when tabs are pressed.
  final PageController pageController;

  ///
  final CurrentPage currentPage;

  const MenuItems({Key? key, required this.tabs, this.tabHeight = 30.0, this.tabWidth = 100.0, required this.pageController, required this.currentPage}) : super(key: key);

  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  /// The initial menu tab.
  ///
  /// This is equal to the initial page of the [widget.pageController] on initialisation.
  /// Since the tabs are arranged to the same sequence as the pages,
  /// passing the index to the ```pageController.jumpToPage(index)```
  /// changes the page.
  late int _currentTabIndex;

  /// Index of the tab on which the mouse is hovered.
  ///
  /// Used to give the appropriate colour to the tab text.
  late int _hoverTabIndex = 0;

  /// Offset value, only inclusive of left and right  margins.
  ///
  /// This counteracts the displacement created due to ```margins```.
  /// This value is passed to the margin parameter.
  static const double _off = 16.0;

  /// On hover boolean to check if mouse is over any of the menu tabs.
  late bool _hover = false;

  /// Sets Text color according on Mouse Hover events.
  Color _tabItemColor(int i) {
    if (i == _currentTabIndex) {
      return Theme.of(context).accentColor;
    } else if (_hover && i == _hoverTabIndex) {
      return Theme.of(context).primaryColor;
    } else {
      return Theme.of(context).highlightColor;
    }
  }

  /// Changes the state of the [_hover] and [_hoverTabIndex] if mouse is over the tab/s.
  void _onHover(bool b, int i) {
    setState(() {
      _hover = b;
      _hoverTabIndex = i;
    });
  }

  @override
  void initState() {
    _currentTabIndex = widget.pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: (widget.tabWidth + _off) * widget.tabs.length,
          height: widget.tabHeight,
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: widget.tabs.length,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            controller: ScrollController(),
            itemBuilder: (BuildContext context, int i) => Container(
              width: widget.tabWidth,
              height: widget.tabHeight,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: _off / 2, right: _off / 2),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: _currentTabIndex == i ? true : false,
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: widget.tabs[i].imageIcon == null
                              ? Icon(widget.tabs[i].tabIcon, color: Theme.of(context).accentColor, size: 20.0)
                              : ImageIcon(widget.tabs[i].imageIcon, size: 16.0, color: Theme.of(context).accentColor),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: _off / 2),
                      child: MouseRegion(
                        onEnter: (_hEvent) => _onHover(true, i),
                        onExit: (_hEvent) => _onHover(false, i),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _currentTabIndex = i;
                              widget.pageController.jumpToPage(_currentTabIndex);
                              widget.currentPage(i);
                            });
                          },
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              widget.tabs[i].title,
                              style: TextStyle(
                                fontFamily: 'Source Code',
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: _tabItemColor(i),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // moving bar
        AnimatedPositioned(
          left: (widget.tabWidth * _currentTabIndex) + (_currentTabIndex == 0 ? _off / 2 : (1 / 2 + _currentTabIndex) * _off),
          top: widget.tabHeight + 14.0,
          duration: Duration(milliseconds: 200),
          child: Container(
            height: 3.0,
            width: widget.tabWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}

/// Class that handles the tabs that go inside the [MenuTab].
///
/// - [imageIcon] or [tabIcon] must be specified.
class MenuTab {
  /// Name of the menu tab.
  final String title;

  /// Image that can be added to leading of the menu name.
  final AssetImage? imageIcon;

  /// Icon that is added to the leading of menu name.
  final IconData? tabIcon;

  const MenuTab({this.imageIcon, this.tabIcon, required this.title}) : assert((imageIcon != null || tabIcon != null), ' Any one of the Icon should be provided');
}
