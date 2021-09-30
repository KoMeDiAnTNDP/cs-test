import 'package:cs_test/pages/home/home_view_model.dart';
import 'package:cs_test/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/state.dart';

class HomePage extends StatefulWidget {
  final Store<GlobalAppState> store;
  HomePage({Key key, this.store}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalAppState, HomeViewModel>(
      distinct: true,
      converter: (Store<GlobalAppState> store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel viewModel) {
        return Scaffold(
          appBar: _buildAppBar(context, viewModel),
          body: SafeArea(
            child: Routes.buildHomeRouteWidget(
              viewModel.activePage,
              context,
              _tabController,
            )
          )
        );
      }
    );
  }

  Widget _buildAppBar(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.activePage == Routes.medications) {
      _tabController = TabController(length: 3, vsync: this);
      // _tabController.addListener(() {
      //   if (_tabController.indexIsChanging) {
      //    setState(() {
      //     // Rebuild when tab index changes 
      //    });
      //   }
      // });
      return AppBar(
        centerTitle: true,
        title: Text(viewModel.activePageTitle),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
            viewModel.logOut();
          })
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: 'TODAYS'),
            Tab(text: 'ACTIVE'),
            Tab(text: 'EXPIRED'),
          ],
        ),
      );
    } else {
      return AppBar(
        centerTitle: true,
        title: Text(viewModel.activePageTitle)
      );
    }
  }
}