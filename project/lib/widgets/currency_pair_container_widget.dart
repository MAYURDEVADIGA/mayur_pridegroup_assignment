import 'package:flutter/material.dart';
import 'package:mayur_pridegroup_assignment/widgets/white_text_widget.dart';

class CurrencyPairContainer extends StatelessWidget {
  const CurrencyPairContainer({
    Key? key,
    required this.i,
    required this.bidBgColor,
    required this.askBgColor,
    required this.icon,
    required this.title,
    required this.bid1,
    required this.bid2,
    required this.bid3,
    required this.ask1,
    required this.ask2,
    required this.ask3,
  }) : super(key: key);

  final int i;
  final List<Color> bidBgColor;
  final List<Color> askBgColor;
  final Widget icon;
  final String title;
  final double bid1;
  final double bid2;
  final double bid3;
  final double ask1;
  final double ask2;
  final double ask3;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: width,
      height: 70,
      color: Colors.grey[900],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                WhiteText(title: title, size: 20, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: bidBgColor[i],
                    width: 135,
                    height: 70,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          WhiteText(
                            title: bid1.toStringAsFixed(2),
                          ),
                          WhiteText(title: bid2.toStringAsFixed(0), size: 30),
                          WhiteText(
                            title: bid3.toStringAsFixed(0),
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Container(
                    color: askBgColor[i],
                    width: 135,
                    height: 70,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          WhiteText(
                            title: ask1.toStringAsFixed(2),
                          ),
                          WhiteText(title: ask2.toStringAsFixed(0), size: 30),
                          WhiteText(
                            title: ask3.toStringAsFixed(0),
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
