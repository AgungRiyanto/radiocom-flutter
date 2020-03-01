import 'package:cuacfm/injector/dependency_injector.dart';
import 'package:cuacfm/models/new.dart';
import 'package:cuacfm/utils/radiocom_colors.dart';
import 'package:cuacfm/utils/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:injector/injector.dart';
import 'new_detail_presenter.dart';

class NewDetail extends StatefulWidget {
  NewDetail({Key key, this.newItem}) : super(key: key);
  New newItem;
  @override
  State createState() => new NewDetailState();
}

class NewDetailState extends State<NewDetail> implements NewDetailView {
  MediaQueryData _queryData;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  NewDetailPresenter _presenter;
  RadiocomColorsConract _colors;

  NewDetailState() {
    DependencyInjector().injectByView(this);
  }

  @override
  Widget build(BuildContext context) {
    _queryData = MediaQuery.of(context);
    _colors = Injector.appInstance.getDependency<RadiocomColorsConract>();
    return Scaffold(
      key: scaffoldKey,
      appBar: TopBar(
          title: "",
          topBarOption: TopBarOption.NORMAL,
          rightIcon: Icons.share,
          onRightClicked: () {
            _presenter.onShareClicked(widget.newItem);
          }),
      backgroundColor: _colors.palidwhite,
      body: _getBodyLayout(),
    );
    ;
  }

  @override
  void initState() {
    super.initState();
    _presenter = Injector.appInstance.getDependency<NewDetailPresenter>();
  }

  @override
  void dispose() {
    Injector.appInstance.removeByKey<NewDetailView>();
    super.dispose();
  }

  //layout

  Widget _getBodyLayout() {
    return new Container(
        color: _colors.palidwhitedark,
        height: _queryData.size.height,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Container(
                child: Column(children: <Widget>[
                  SizedBox(height: 20),
              Padding(padding: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 0.0),child:
              Stack(children: <Widget>[
                Container(
                    color: _colors.blackgradient65,
                    width: _queryData.size.width,
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text(widget.newItem.title.toUpperCase(),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22.0,
                            letterSpacing: 2.0,
                            color: _colors.fontWhite,
                          )),
                      SizedBox(height: 5),
                      Text(widget.newItem.pubDate.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 2.0,
                            color: _colors.fontWhite,
                          )),
                    ]))
              ])),
              SizedBox(height: 20),
              ListTile(
                  title: Html(defaultTextStyle: TextStyle(color: _colors.font),
                useRichText: true,
                data: widget.newItem.description,
                linkStyle: const TextStyle(
                  color: Colors.grey,
                  decorationColor: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
                onLinkTap: (url) {
                  _presenter.onLinkClicked(url);
                },
              )),SizedBox(height: 20),
            ]))));
  }
}