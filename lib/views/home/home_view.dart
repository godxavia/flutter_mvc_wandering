import 'package:flutter/material.dart'
    show
        Alignment,
        BoxDecoration,
        BoxFit,
        BuildContext,
        Color,
        Colors,
        Column,
        Container,
        CustomScrollView,
        DecoratedBox,
        EdgeInsets,
        Expanded,
        FlexibleSpaceBar,
        FloatingActionButton,
        Icon,
        Icons,
        Image,
        LinearGradient,
        LinearProgressIndicator,
        MainAxisSize,
        Padding,
        Scaffold,
        Shadow,
        SliverAppBar,
        SliverChildBuilderDelegate,
        SliverGrid,
        SliverGridDelegateWithMaxCrossAxisExtent,
        Stack,
        StackFit,
        StatelessWidget,
        StretchMode,
        Text,
        TextStyle,
        Widget;
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer;
// import model
import 'package:flutter_wandering/models/home/home_model.dart';
// import controller
import 'package:flutter_wandering/controllers/home/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController viewController = HomeController();
    return ChangeNotifierProvider<HomeModel>(
      create: (context) => HomeModel.instance(),
      child: Consumer<HomeModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            // appBar: AppBar(
            //   title: Text("MVC Wondering"),
            //   elevation: 0,
            // ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF046994),
              onPressed: () {
                viewController.getter(context);
              },
              child: Icon(Icons.refresh),
            ),
            body: Stack(
              children: <Widget>[
                (viewModel.status == HomeModelStatus.Loading)
                    ? LinearProgressIndicator()
                    : Container(),
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Color(0xFF046994),
                      pinned: true,
                      expandedHeight: 200.0,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: <StretchMode>[
                          StretchMode.zoomBackground,
                          StretchMode.blurBackground,
                          StretchMode.fadeTitle,
                        ],
                        title: Text(
                          'Members',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            new Image.asset(
                              'assets/images/bg01.jpg',
                              fit: BoxFit.cover,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.0, 0.5),
                                  end: Alignment(0.0, 0.0),
                                  colors: <Color>[
                                    Color(0x60000000),
                                    Color(0x00000000),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      viewModel.photos[index].avatar,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        viewModel.photos[index].username,
                                        style: TextStyle(
                                          color: Colors.white,
                                          shadows: <Shadow>[
                                            Shadow(
                                              blurRadius: 5.0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        childCount: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
