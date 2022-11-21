import 'package:flutter/material.dart';
import 'package:mayur_pridegroup_assignment/models/currency_pair.dart';
import 'package:mayur_pridegroup_assignment/widgets/white_text_widget.dart';

List<CurrencyPair> currencyPairs = <CurrencyPair>[
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'EURUSD',
    bid1: 1.16,
    bid2: 25,
    bid3: 8,
    ask1: 1.16,
    ask2: 29,
    ask3: 8,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'M',
      topColor: Colors.grey,
      bottomColor: Colors.blueGrey,
    ),
    title: 'XAGUSD',
    bid1: 22,
    bid2: 75,
    bid3: 3,
    ask1: 22,
    ask2: 77,
    ask3: 3,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'GBPUSD',
    bid1: 1.27,
    bid2: 90,
    bid3: 0,
    ask1: 1.27,
    ask2: 93,
    ask3: 0,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'USDJPY',
    bid1: 105,
    bid2: 37,
    bid3: 6,
    ask1: 105,
    ask2: 40,
    ask3: 0,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'LTCUSD',
    bid1: 46,
    bid2: 32,
    bid3: 0,
    ask1: 46,
    ask2: 33,
    ask3: 0,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'ETHUSD',
    bid1: 375,
    bid2: 54,
    bid3: 0,
    ask1: 375,
    ask2: 59,
    ask3: 0,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'EURUAD',
    bid1: 1.64,
    bid2: 99,
    bid3: 8,
    ask1: 1.65,
    ask2: 02,
    ask3: 6,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'EURCHF',
    bid1: 1.07,
    bid2: 98,
    bid3: 6,
    ask1: 1.08,
    ask2: 02,
    ask3: 0,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'EURGBP',
    bid1: 0.90,
    bid2: 89,
    bid3: 7,
    ask1: 0.90,
    ask2: 91,
    ask3: 0,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'EURJPY',
    bid1: 122,
    bid2: 54,
    bid3: 1,
    ask1: 122,
    ask2: 54,
    ask3: 5,
    candles: [],
  ),
  CurrencyPair(
    icon: const CurrencyIcon(
      text: 'C',
      topColor: Colors.lightGreen,
      bottomColor: Colors.green,
    ),
    title: 'GBPAUD',
    bid1: 1.81,
    bid2: 51,
    bid3: 9,
    ask1: 1.81,
    ask2: 53,
    ask3: 3,
    candles: [],
  ),
];

class CurrencyIcon extends StatelessWidget {
  const CurrencyIcon({
    required this.text,
    required this.bottomColor,
    required this.topColor,
    Key? key,
  }) : super(key: key);
  final String text;
  final Color topColor;
  final Color bottomColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [topColor, bottomColor],
        ),
      ),
      height: 20,
      width: 20,
      child: Center(
          child: WhiteText(
        title: text,
        size: 15,
      )),
    );
  }
}
