import 'package:untitled/redux/app_state.dart';

import 'actions.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is AddAction) {
    return AppState(
        counter: state.counter + 1, counter2: state.counter2, text: state.text);
  } else if (action is DecrementAction) {
    return AppState(
        counter: state.counter - 1, counter2: state.counter2, text: state.text);
  } else if (action is MultiplyAction) {
    return AppState(
        counter: state.counter, counter2: state.counter2 * 2, text: state.text);
  } else if (action is DivideAction) {
    return AppState(
        counter: state.counter,
        counter2: (state.counter2 / 2).round(),
        text: state.text);
  } else if (action is SetTextAction) {
    return AppState(
        counter: state.counter, counter2: state.counter2, text: action.text);
  } else {
    return state;
  }
}
