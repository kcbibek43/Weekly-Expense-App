import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Widget/out_list.dart';
import './Widget/transacrion_list.dart';
import './transaction.dart';
import 'Widget/chart.dart';
import 'dart:io';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown]
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
        // appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(headline6: TextStyle(
        //   fontFamily: 'OpenSans',
        //   fontSize: 18,
        //   fontWeight: FontWeight.bold,
        // )),)
      ),
      title: 'Weekly Transaction',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  final List<Transaction> _userTransactions = [
  ];
  @override
  void initState() {
   WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void didChangeAppLifeCycleState(AppLifecycleState state){
    print(state);
  }

  @override
  dispose(){
  WidgetsBinding.instance.removeObserver(this);
    super.dispose(); 
  }
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  bool _showChart = false;
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void action() {
    _startAddNewTransaction(context);
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,AppBar appBar,Widget txList,
  bool _showChart,Widget recent
  ) {
    return [Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ), _showChart ? recent : txList];
  }
  List<Widget> _buildPotraitContent(MediaQueryData mediaQuery,AppBar appBar,Widget txList) {
return  [Container(
                child: Chart(_recentTransactions),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
              ),txList];
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    late final appBar = AppBar(
      // backgroundColor: Color.fromARGB(255, 228, 120, 247),
      title: Text(
        'Weekly Transaction',
        style: TextStyle(color: Colors.yellowAccent, fontFamily: 'Quicksand'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => action(),
        ),
      ],
    );
    late final recent = Container(
      child: Chart(_recentTransactions),
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
    );
    late final txList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)  ..._buildLandscapeContent(mediaQuery,appBar,txList,_showChart,recent),
            if (!isLandscape) ..._buildPotraitContent(mediaQuery, appBar,txList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: const Icon(Icons.add),
              //   hoverColor: Color.fromARGB(255, 180, 59, 240),
              //   backgroundColor: Color.fromARGB(255, 227, 130, 244),
              //    focusColor: Color.fromARGB(255, 227, 130, 244),
              onPressed: () => _startAddNewTransaction(context),
            ),
    );
  }
}
