import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  final Store<int> store = Store(reducer, initialState: 0);
  runApp(StoreProvider(
    store: store,
    child: MaterialApp(
      home: _Counter(),
    ),
  ));
}

class _Counter extends StatelessWidget {
  const _Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<int> store = StoreProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Redux',),
        centerTitle: true,
      ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
            ]
        ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3)),
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 17),
            ),
            StoreConnector<int, int>(
              converter: (store) => store.state,
              builder: (context, state) =>
              Text(
                state.toString(),
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAction{}
class DecrementAction{}

int reducer(int state, dynamic action){
if(action is AddAction){
  return state+1;
} else if (action is DecrementAction){
  return state-1;
}
return state;
}