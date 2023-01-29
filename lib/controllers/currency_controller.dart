import "../repository/repository.dart";
import "package:mvc_pattern/mvc_pattern.dart";
class CurrencyController extends ControllerMVC{
  final Repository repository = new Repository();
CurrencyController();
var currentState = [];
void init() async {
try {
  final currencyList = await repository.fetchCurrenices();
  setState(() => currentState = currencyList);
}
catch (error) {
  throw Exception("Error while a currenices");
}
}
}