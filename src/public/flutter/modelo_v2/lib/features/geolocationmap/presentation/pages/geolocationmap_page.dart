import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GeolocationMapPage extends StatefulWidget {
  const GeolocationMapPage({super.key});

  @override
  State<GeolocationMapPage> createState() => _GeolocationMapPageState();
}

class _GeolocationMapPageState extends State<GeolocationMapPage> {
  final MapController _mapController = MapController();
  LatLng _currentPosition = const LatLng(
    -15.7801,
    -47.9292,
  ); // Brasília como posição padrão
  bool _isLoading = true;
  bool _locationPermissionDenied = false;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    setState(() {
      _isLoading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    // Verificar se os serviços de localização estão habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
        _locationPermissionDenied = true;
      });

      return;
    }

    // Verificar permissão de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false;
          _locationPermissionDenied = true;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false;
        _locationPermissionDenied = true;
      });
      return;
    }

    // Obter posição atual
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      // ALERTA AO USUÁRIO
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sua localização:\nLat: ${position.latitude}, Lng: ${position.longitude}',
          ),
        ),
      );

      // Centralizar mapa na posição atual
      _mapController.move(_currentPosition, 15.0);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Localização'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _determinePosition,
            tooltip: 'Minha Localização',
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _locationPermissionDenied
              ? _buildPermissionDeniedWidget()
              : _buildMapWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.move(_currentPosition, 15.0);
        },
        child: const Icon(Icons.center_focus_strong),
        tooltip: 'Centralizar no meu local',
      ),
    );
  }

  Widget _buildPermissionDeniedWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Permissão de localização negada',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Para visualizar sua localização no mapa, é necessário permitir o acesso à sua localização.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: const Text('Abrir Configurações'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapWidget() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(initialCenter: _currentPosition, initialZoom: 15.0),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.modelo_v2',
          subdomains: const ['a', 'b', 'c'],
        ),
        // Camada para mostrar a localização atual
        MarkerLayer(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: _currentPosition,
              child: const Column(
                children: [
                  Icon(Icons.location_on, color: Colors.red, size: 40.0),
                ],
              ),
            ),
          ],
        ),
        // Controles de zoom
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
