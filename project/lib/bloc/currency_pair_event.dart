part of 'currency_pair_bloc.dart';

abstract class CurrencyPairEvent extends Equatable {
  const CurrencyPairEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrencyPairs extends CurrencyPairEvent {}

class ChangeBids extends CurrencyPairEvent {
  final int index;
  final double bid1;
  final double bid2;
  final double bid3;
  final Candle candle;

  const ChangeBids(
    this.index,
    this.bid1,
    this.bid2,
    this.bid3,
    this.candle,
  );

  @override
  List<Object> get props => [index, bid1, bid2, bid3, candle];
}

class ChangeAsks extends CurrencyPairEvent {
  final int index;
  final double ask1;
  final double ask2;
  final double ask3;
  final Candle candle;

  const ChangeAsks(this.index, this.ask1, this.ask2, this.ask3, this.candle);

  @override
  List<Object> get props => [index, ask1, ask2, ask3, candle];
}
