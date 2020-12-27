import 'package:flutter/material.dart';
import 'package:whatsme/presentation/pages/calls_page.dart';
import 'package:whatsme/presentation/pages/camera_page.dart';
import 'package:whatsme/presentation/pages/chat_page.dart';
import 'package:whatsme/presentation/pages/status_page.dart';
import 'package:whatsme/presentation/widgets/custom_tab_bar.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearch = false;
  int _currentPageIndex = 1;
  PageController _pageViewController = PageController(initialPage: 1);
  List<Widget> _pages = [CameraPage(), ChatPage(), StatusPage(), CallsPage()];

  _buildSearch() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 50,
      //decoration: BoxDecoration(color: Colors.white, boxShadow: [
      // BoxShadow(
      //     color: Colors.black.withOpacity(.3),
      //     spreadRadius: 1,
      //     offset: Offset(0, 0.5))
      // ]),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: InkWell(
            onTap: () {
              _isSearch = false;
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _currentPageIndex!=0 ?AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor:
              _isSearch == false ? primaryColor : Colors.transparent,
          title: _isSearch == false
              ? Text("WhatsMe")
              : Container(
                  height: 0,
                  width: 0,
                ),
          flexibleSpace: _isSearch == false
              ? Container(
                  height: 0,
                  width: 0,
                )
              : _buildSearch(),
          actions: [
            InkWell(
              onTap: () {
                _isSearch = true;
                setState(() {});
              },
              child: Icon(Icons.search),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.more_vert)
          ],
        ):null,
        body: Column(
          children: [
            _isSearch == false
                ? _currentPageIndex != 0
                    ? CustomTabBar(index: _currentPageIndex)
                    : SizedBox()
                : SizedBox(),
            Expanded(
              child: PageView.builder(
                itemCount: _pages.length,
                controller: _pageViewController,
                onPageChanged: (index) {
                  _currentPageIndex = index;
                  setState(() {});
                },
                itemBuilder: (_, index) => _pages[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
