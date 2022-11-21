import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayur_pridegroup_assignment/bloc/currency_pair_bloc.dart';
import 'package:mayur_pridegroup_assignment/pages/candle_screen.dart';
import 'package:mayur_pridegroup_assignment/repositories/currency_pairs_repository.dart';
import 'package:mayur_pridegroup_assignment/widgets/app_floating_action_button_widget.dart';
import 'package:mayur_pridegroup_assignment/widgets/currency_pair_container_widget.dart';
import 'package:mayur_pridegroup_assignment/widgets/custom_app_bar_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> bidBgColor = [];
  List<Color> askBgColor = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < currencyPairs.length; i++) {
      bidBgColor.add(Colors.transparent);
      askBgColor.add(Colors.transparent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: BlocBuilder<CurrencyPairBloc, CurrencyPairState>(
        builder: (context, state) {
          if (state is CurrencyPairInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is CurrencyPairLoaded) {
            for (int i = 0; i < state.currencyPairs.length; i++) {
              Timer.periodic(const Duration(seconds: 1), (timer) async {
                //call the isolate function
                double previousBid = state.currencyPairs[i].bid2;
                double previousAsk = state.currencyPairs[i].ask2;
                final receivePort = ReceivePort();
                await Isolate.spawn(randomizeValues, receivePort.sendPort);
                receivePort.listen((res) {
                  context.read<CurrencyPairBloc>().add(ChangeBids(
                        i,
                        res[0],
                        res[1],
                        res[2],
                        Candle(
                          date: DateTime.now(),
                          open: res[0],
                          close: res[5],
                          high: res[1],
                          low: res[4],
                          volume: 50,
                        ),
                      ));
                  context.read<CurrencyPairBloc>().add(ChangeAsks(
                        i,
                        res[3],
                        res[4],
                        res[5],
                      ));

                  setState(() {
                    bidBgColor[i] =
                        previousBid < res[1] ? Colors.green : Colors.red;
                    askBgColor[i] =
                        previousAsk < res[4] ? Colors.green : Colors.red;
                  });
                });
              });
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < state.currencyPairs.length; i++)
                    CurrencyPairContainer(
                      i: i,
                      bidBgColor: bidBgColor,
                      askBgColor: askBgColor,
                      icon: state.currencyPairs[i].icon,
                      title: state.currencyPairs[i].title,
                      bid1: state.currencyPairs[i].bid1,
                      bid2: state.currencyPairs[i].bid2,
                      bid3: state.currencyPairs[i].bid3,
                      ask1: state.currencyPairs[i].ask1,
                      ask2: state.currencyPairs[i].ask2,
                      ask3: state.currencyPairs[i].ask3,
                    ),
                ],
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        icon: const Icon(Icons.bar_chart, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CandleScreen()),
          );
        },
      ),
    );
  }
}

void randomizeValues(SendPort sendPort) {
  double bid1 = Random().nextDouble() * 100;
  double bid2 = Random().nextDouble() * 100;
  double bid3 = Random().nextDouble() * 100;
  double ask1 = Random().nextDouble() * 100;
  double ask2 = Random().nextDouble() * 100;
  double ask3 = Random().nextDouble() * 100;
  List res = [bid1, bid2, bid3, ask1, ask2, ask3];

  sendPort.send(res);
}
