import 'package:flutter/material.dart';
import 'package:flutter_pokemons/instancias/carro.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  Carro carro;

  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _latLong(),
          zoom: 17,
        ),
        markers: Set.of([
          Marker(
              markerId: MarkerId("1"),
              position: _latLong(),
              infoWindow: InfoWindow(
                title: carro.nome,
                snippet: "Fabrica da ${carro.nome}",
                onTap: (){
                  print("clicou na janela");
                }
              ))
        ]),
      ),
    );
  }

  _latLong() {
    return LatLng(double.parse(carro.latitude), double.parse(carro.longitude));
  }
}
