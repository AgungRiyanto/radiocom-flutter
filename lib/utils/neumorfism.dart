import 'package:cuacfm/utils/radiocom_colors.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'custom_image.dart';

BoxDecoration neumorphicBox(RadiocomColorsConract _colors) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: _colors.neuPalidGrey,
      boxShadow: [
        BoxShadow(
          color: _colors.neuBlackOpacity,
          offset: Offset(10, 10),
          blurRadius: 10,
        ),
        BoxShadow(
          color: _colors.neuWhite,
          offset: Offset(-10, -10),
          blurRadius: 10,
        ),
      ]);
}

BoxDecoration neumorphicInverseBox(RadiocomColorsConract _colors) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: _colors.neuBlackOpacity,
      boxShadow: [
        BoxShadow(
            color: _colors.neuWhite,
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: -3),
      ]);
}


class NeumorphicView extends StatelessWidget {
  RadiocomColorsConract _colors;
  final Widget child;
  final bool isFullScreen;
  NeumorphicView({this.child, this.isFullScreen = false});
  @override
  Widget build(BuildContext context) {
    _colors = Injector.appInstance.getDependency<RadiocomColorsConract>();
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isFullScreen ? 0 : 25),
            color: _colors.neuPalidGrey,
            boxShadow: [
              BoxShadow(
                color: _colors.neuBlackOpacity,
                offset: Offset(2, 2),
                blurRadius: 2,
              ),
              BoxShadow(
                color: isFullScreen ? _colors.transparent : _colors.neuWhite,
                offset: Offset(-2, -2),
                blurRadius: 2,
              ),
            ]),
        child: child);
  }
}

class NeumorphicButton extends StatelessWidget {
  final bool down;
  final IconData icon;
  RadiocomColorsConract _colors;
  NeumorphicButton({this.down, this.icon});
  @override
  Widget build(BuildContext context) {
    _colors = Injector.appInstance.getDependency<RadiocomColorsConract>();
    return Container(
      width: 55,
      height: 55,
      decoration: down ? neumorphicInverseBox(_colors) : neumorphicBox(_colors),
      child: Icon(
        icon,
        color: down ? _colors.yellow : _colors.grey,
      ),
    );
  }
}

class NeumorphicCardVertical extends StatelessWidget {
  final bool active;
  final IconData icon;
  final String label;
  final String image;
  final bool imageOverLay;
  final String subtitle;
  RadiocomColorsConract _colors;
  NeumorphicCardVertical(
      {this.active,
      this.icon,
      this.label,
      this.image,
      this.subtitle,
      this.imageOverLay = false});
  @override
  Widget build(BuildContext context) {
    _colors = Injector.appInstance.getDependency<RadiocomColorsConract>();
    var queryData = MediaQuery.of(context);
    List<Widget> elements = [];
    Widget imageContent =
        CustomImage(resPath: image, fit: BoxFit.fitHeight, radius: 15.0);
    if (imageOverLay) {
      imageContent = Stack(fit: StackFit.passthrough, children: <Widget>[
        ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: <Color>[_colors.yellow, _colors.orange],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child:CustomImage(resPath: image, fit: BoxFit.fitHeight, radius: 15.0)),
         Center(child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _colors.fontWhite,
                  fontWeight: FontWeight.w900,
                  fontSize: 24),
            )),
      ]);
    }
    elements.add(Container(
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: _colors.transparent),
        decoration: neumorphicBox(_colors),
        width: imageOverLay ? 260.0 : 170.0,
        height: imageOverLay ? 180.0 : 170.0,
        child: imageContent));
    if (!imageOverLay) {
      elements.add(SizedBox(width: 15, height: 10.0));
      elements.add(Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: _colors.font,
            fontWeight: FontWeight.w700,
            fontSize: 15),
      ));
      elements.add(Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: _colors.font,
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ));
      elements.add(Spacer());
    }
    return Container(
      height: imageOverLay ? 200.0 : 250.0,
      width: imageOverLay ? 260.0 :queryData.size.width * 0.42,
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: elements),
    );
  }
}

class NeumorphicCardHorizontal extends StatelessWidget {
  final bool active;
  final IconData icon;
  final String label;
  final String image;
  final double size;
  final VoidCallback onElementClicked;
  RadiocomColorsConract _colors;
  NeumorphicCardHorizontal(
      {this.active, this.icon, this.label, this.image, this.size,this.onElementClicked});

  _onElementClicked() {
    if(onElementClicked !=null){
      onElementClicked();
    }
  }

  @override
  Widget build(BuildContext context) {
    _colors = Injector.appInstance.getDependency<RadiocomColorsConract>();

    Widget iconCard = Icon(icon, color: _colors.yellow, size: 40.0);
    if (image != null) {
      iconCard = new Container(
          width: 60.0,
          height: 60.0,
          child:
              CustomImage(resPath: image, fit: BoxFit.fitHeight, radius: 15.0));
    }
    return GestureDetector(child: Container(
      height: size == null ? 80.0 : size,
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: neumorphicBox(_colors),
      child: Row(
        children: <Widget>[
          iconCard,
          SizedBox(width: 15),
          Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: size == null
                  ? TextStyle(
                  color: _colors.font,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)
                  : TextStyle(
                  wordSpacing: 3.0,
                  color: _colors.font,
                  fontWeight: FontWeight.w700,
                  fontSize: 20)),
          Spacer(),
          image != null
              ? Icon(Icons.keyboard_arrow_right,
              color: _colors.yellow, size: 40.0)
              : Spacer(),
        ],
      ),
    ),onTap: (){
      _onElementClicked();
    });
  }
}
