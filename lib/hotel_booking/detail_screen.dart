import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:projectflutter/hotel_booking/detail/common/navigation/fade_route.dart';
import 'package:projectflutter/hotel_booking/detail/common/theme.dart';
import 'package:projectflutter/hotel_booking/detail/common/widget/blur_icon.dart';
import 'package:projectflutter/hotel_booking/detail/parallax_page_view.dart';
import 'package:projectflutter/hotel_booking/detail/sliding_bottom_sheet.dart';
import 'package:projectflutter/hotel_booking/hotel_app_theme.dart';
import 'package:rect_getter/rect_getter.dart';

class DetailScreen extends StatefulWidget {
  final String heroTag;
  final String imageAsset;

  DetailScreen({
    this.heroTag,
    this.imageAsset,
  });

  @override
  _DetailScreenState createState() =>
      _DetailScreenState(heroTag: heroTag, imageAsset: imageAsset);
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  final String heroTag;
  final String imageAsset;
  final double bottomSheetCornerRadius = 50;

  final Duration animationDuration = Duration(milliseconds: 600);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  _DetailScreenState({
    this.heroTag,
    this.imageAsset,
  });

  static double bookButtonBottomOffset = -60;
  double bookButtonBottom = bookButtonBottomOffset;
  AnimationController _bottomSheetController;

  void _onTap() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page:  null//*BookScreen()*//
        ))
        .then((_) => setState(() => rect = null));
  }

  @override
  void initState() {
    super.initState();
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    Future.delayed(Duration(milliseconds: 700)).then((v) {
      setState(() {
        bookButtonBottom = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = HotelConceptThemeProvider.get();
    final coverImageHeightCalc =
        MediaQuery.of(context).size.height / 2 + bottomSheetCornerRadius;
    return WillPopScope(
      onWillPop: () async {
        if (_bottomSheetController.value <= 0.5) {
          setState(() {
            bookButtonBottom = bookButtonBottomOffset;
          });
        }
        return true;
      },
      child: 
      Container(
      color: HotelAppTheme.buildLightTheme().backgroundColor,
      child:  Scaffold(
         backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(),
            Hero(
              createRectTween: ParallaxPageView.createRectTween,
              tag: heroTag,
              child: Container(
                height: coverImageHeightCalc,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: PageIndicatorContainer(
                      align: IndicatorAlign.bottom,
                      length: 3,
                      indicatorSpace: 12.0,
                      padding: EdgeInsets.only(bottom: 60),
                      indicatorColor: themeData.indicatorColor,
                      indicatorSelectorColor: Colors.white,
                      shape: IndicatorShape.circle(size: 12),
                      child: PageView(
                        children: <Widget>[
                          Image.asset(
                            imageAsset,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "img/hotel_2.jpg", // <- stubbed data
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "img/hotel_3.jpg", // <- stubbed data
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            // Positioned(
            //   top: 46,
            //   right: 24,
            //   child: Hero(
            //     tag: "${heroTag}heart",
            //     child: BlurIcon(
            //       icon: Icon(
            //         HotelBookingConcept.ic_heart_empty,
            //         color: Colors.white,
            //         size: 5.2,
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 46,
              left: 24,
              height: 45,
              width: 45,
              child: Hero(
                tag: "${heroTag}chevron",
                //tag: "<",
                child: GestureDetector(
                  onTap: () async {
                    await _bottomSheetController.animateTo(0,
                        duration: Duration(milliseconds: 150));
                    setState(() {
                      bookButtonBottom = bookButtonBottomOffset;
                    });
                    Navigator.pop(context);
                  },
                  child:  
                  BlurIcon(
                    icon: new Icon(const IconData(0xe5cb, fontFamily: 'MaterialIcons'), size: 40.0, color: Colors.white
                    )
                  ),
                ),
              ),
            ),
            SlidingBottomSheet(
              controller: _bottomSheetController,
              cornerRadius: bottomSheetCornerRadius,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Interval(
                0,
                0.5,
                curve: Curves.easeInOut,
              ),
              bottom: bookButtonBottom,
              right: 0,
              child: RectGetter(
                key: rectGetterKey,
                child: GestureDetector(
                  //onTap: _onTap,
                  onTap: _showDialog,
                  child: Container(
                    height: 60,
                    width: 172,
                    decoration: BoxDecoration(
                        color: themeData.accentColor,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Center(
                      child: Text(
                        "Reservar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _ripple(themeData),
          ],
        ),
      ),
    ));
  }

  Widget _ripple(ThemeData themeData) {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeData.accentColor,
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
 setState(() =>
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Datos de Reserva"),
          content: new Text("Datos de Reserva"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    )
 );

  }

}
