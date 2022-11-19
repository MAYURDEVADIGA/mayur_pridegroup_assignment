import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mayur_pridegroup_assignment/models/currency_pair.dart';
import 'package:mayur_pridegroup_assignment/repositories/currency_pairs_repository.dart';

part 'currency_pair_event.dart';
part 'currency_pair_state.dart';

class CurrencyPairBloc extends Bloc<CurrencyPairEvent, CurrencyPairState> {
  CurrencyPairBloc() : super(CurrencyPairInitial()) {
    on<LoadCurrencyPairs>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(CurrencyPairLoaded(currencyPairs: currencyPairs));
    });

    on<ChangeBids>((event, emit) {
      if (state is CurrencyPairLoaded) {
        final state = this.state as CurrencyPairLoaded;
        final replacements = [
          CurrencyPair(
            icon: List.from(state.currencyPairs)[event.index].icon,
            title: List.from(state.currencyPairs)[event.index].title,
            bid1: event.bid1,
            bid2: event.bid2,
            bid3: event.bid3,
            ask1: List.from(state.currencyPairs)[event.index].ask1,
            ask2: List.from(state.currencyPairs)[event.index].ask2,
            ask3: List.from(state.currencyPairs)[event.index].ask3,
          )
        ];

        emit(CurrencyPairLoaded(
            currencyPairs: List.from(state.currencyPairs)
              ..replaceRange(event.index, event.index + 1, replacements)));
      }
    });

    on<ChangeAsks>((event, emit) {
      if (state is CurrencyPairLoaded) {
        final state = this.state as CurrencyPairLoaded;
        final replacements = [
          CurrencyPair(
            icon: List.from(state.currencyPairs)[event.index].icon,
            title: List.from(state.currencyPairs)[event.index].title,
            bid1: List.from(state.currencyPairs)[event.index].bid1,
            bid2: List.from(state.currencyPairs)[event.index].bid2,
            bid3: List.from(state.currencyPairs)[event.index].bid3,
            ask1: event.ask1,
            ask2: event.ask2,
            ask3: event.ask3,
          )
        ];

        emit(CurrencyPairLoaded(
            currencyPairs: List.from(state.currencyPairs)
              ..replaceRange(event.index, event.index + 1, replacements)));
      }
    });
  }
}
