import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayur_pridegroup_assignment/bloc/currency_pair_bloc.dart';

import '../constants.dart';

class CandleScreen extends StatefulWidget {
  const CandleScreen({Key? key}) : super(key: key);

  @override
  State<CandleScreen> createState() => _CandleScreenState();
}

class _CandleScreenState extends State<CandleScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        BlocBuilder<CurrencyPairBloc, CurrencyPairState>(
            builder: (context, state) {
          if (state is CurrencyPairLoaded) {
            while (state.currencyPairs[0].candles.length < 13) {
              return Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    WhiteText(title: 'Populating Candle Sticks'),
                  ],
                ),
              );
            }
            return SafeArea(
              child: Center(
                child: Stack(
                  children: [
                    Candlesticks(candles: state.currencyPairs[0].candles),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: WhiteText(title: 'Something went wrong'));
          }
        }),
        Positioned(
          bottom: 15,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.withOpacity(0.3),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
