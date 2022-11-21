import 'package:candlesticks/candlesticks.dart';
import 'package:equatable/equatable.dart';
import 'package:mayur_pridegroup_assignment/repositories/currency_pairs_repository.dart';

class CurrencyPair extends Equatable {
  final CurrencyIcon icon;
  final String title;
  final double bid1;
  final double bid2;
  final double bid3;
  final double ask1;
  final double ask2;
  final double ask3;
  List<Candle> candles;

  CurrencyPair({
    required this.icon,
    required this.title,
    required this.bid1,
    required this.bid2,
    required this.bid3,
    required this.ask1,
    required this.ask2,
    required this.ask3,
    required this.candles,
  });

  @override
  List<Object> get props => [
        icon,
        title,
        bid1,
        bid2,
        bid3,
        ask1,
        ask2,
        ask3,
        candles,
      ];
}
