part of 'currency_pair_bloc.dart';

abstract class CurrencyPairState extends Equatable {
  const CurrencyPairState();

  @override
  List<Object> get props => [];
}

class CurrencyPairInitial extends CurrencyPairState {}

class CurrencyPairLoaded extends CurrencyPairState {
  final List<CurrencyPair> currencyPairs;

  const CurrencyPairLoaded({required this.currencyPairs});

  @override
  List<Object> get props => [currencyPairs];
}
