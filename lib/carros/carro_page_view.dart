import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokemons/blocs/bloc_carro.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:flutter_pokemons/ultil/event_bus.dart';
import 'file:///C:/Users/flaviano.inacio/AndroidStudioProjects/flutter_pokemons/lib/carros/carro_listview.dart';
import 'package:provider/provider.dart';

class CarroPageView extends StatefulWidget {
  @override
  String tipoCarro;

  CarroPageView(this.tipoCarro);

  @override
  _CarroPageViewState createState() => _CarroPageViewState();
}

class _CarroPageViewState extends State<CarroPageView>
    with AutomaticKeepAliveClientMixin<CarroPageView> {
  final bloc = BlocCarro();

  StreamSubscription<String> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.loadData(widget.tipoCarro);

    final bus = Provider.of<EventBus>(context,listen: false);
    subscription = bus.stream.listen((String s){
      bloc.loadData(widget.tipoCarro);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: bloc.fetch,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Não foi possível exibir os dados"),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Carro> carros = snapshot.data;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CarroListView(carros),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
    subscription.cancel();
  }

  Future<void> _onRefresh() {
    return bloc.loadData(widget.tipoCarro);

  }
}
