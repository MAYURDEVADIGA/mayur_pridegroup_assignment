import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/cupertino.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<CurrencyPairBloc, CurrencyPairState>(
            builder: (context, state) {
          if (state is CurrencyPairLoaded) {
            if (state.currencyPairs[0].candles.length < 14) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    WhiteText(title: 'Populating Candle Sticks'),
                  ],
                ),
              );
            } else {
              return SafeArea(
                child: Center(
                  child: Stack(
                    children: [
                      Candlesticks(candles: state.currencyPairs[0].candles),
                      const Positioned(
                          top: 25,
                          child: Text(
                            'EURUSD, One Second',
                            style: TextStyle(color: Colors.green, fontSize: 25),
                          ))
                    ],
                  ),
                ),
              );
            }
          } else {
            return const Center(
                child: WhiteText(title: 'Something went wrong'));
          }
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.withOpacity(0.5),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
