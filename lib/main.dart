import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:untitled/redux/actions.dart';
import 'package:untitled/redux/app_state.dart';
import 'package:untitled/redux/reducers.dart';

void main() {
  final Store<AppState> store = Store(reducer,
      initialState: AppState(counter: 0, counter2: 1, text: 'empty'));
  runApp(StoreProvider(
    store: store,
    child: MaterialApp(
      home: _Counter(),
    ),
  ));
}

String inputText = "";

class _Counter extends StatelessWidget {
  const _Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Redux',
        ),
        centerTitle: true,
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () => store.dispatch(DecrementAction()),
          child: Icon(Icons.exposure_minus_1),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: () => store.dispatch(AddAction()),
          child: Icon(Icons.plus_one),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: () => store.dispatch(MultiplyAction()),
          child: Text('*2'),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: () => store.dispatch(DivideAction()),
          child: Text('/2'),
        ),
      ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4)),
              Text(
                'You have pushed the button this many times:',
                style: TextStyle(fontSize: 17),
              ),
              StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) => Text(
                  state.counter.toString(),
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Text(
                'You have pushed the button this many times and multiply or divide:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) => Text(
                  state.counter2.toString(),
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(''),
                  Container(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Введи меня',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        inputText = value;
                        print(inputText);
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  TextButton(
                      onPressed: () {
                        print(inputText);
                        store.dispatch(SetTextAction(text: inputText));
                      },
                      child: Text('сюда ↓')),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, vm) => Text(vm.text)),
            ],
          ),
        ),
      ),
    );
  }
}
