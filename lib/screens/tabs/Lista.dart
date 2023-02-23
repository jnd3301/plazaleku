import 'package:flutter/material.dart';
import 'package:plazaleku/models/Parking.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Conexion.obtenerXML(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return Card(
                  color: const Color(0xff2E4E5D),
                  child: ListTile(
                    // NOMBRE PARKING
                    title: Text(
                      item['properties']['nombre'].toString().toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Container(
                      padding: const EdgeInsets.all(25),
                      child: RichText(
                        text: TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.local_parking_outlined,
                            size: 18,
                            color: Colors.white,
                          )),
                          TextSpan(
                              text:
                                  " ${item['properties']['plazasRotatorias']}"),
                          const TextSpan(text: " / "),
                          TextSpan(children: [
                            if (item['properties']['libres'] == "0") ...[
                              TextSpan(
                                  text: item['properties']['libres'],
                                  style: const TextStyle(
                                      color: Color(0xFFED8363), fontSize: 16))
                            ] else ...[
                              TextSpan(
                                  text: item['properties']['libres'],
                                  style: const TextStyle(
                                      color: Color(0xff63ED84), fontSize: 16))
                            ]
                          ]),
                          const TextSpan(text: "\n"),
                          const WidgetSpan(
                              child: Icon(
                            Icons.emoji_transportation_outlined,
                            size: 18,
                            color: Colors.white,
                          )),
                          TextSpan(children: [
                            if (item['properties']['plazasResidentesLibres']
                                    .toString() ==
                                "0") ...[
                              TextSpan(
                                  text:
                                      " ${item['properties']['plazasResidentesLibres']}",
                                  style: const TextStyle(
                                      color: Color(0xFFED8363), fontSize: 16))
                            ] else ...[
                              TextSpan(
                                  text:
                                      " ${item['properties']['plazasResidentesLibres']}",
                                  style: const TextStyle(
                                      color: Color(0xff63ED84), fontSize: 16))
                            ]
                          ]),
                        ]),
                        softWrap: true,
                      ),
                    ),
                    isThreeLine: true,
                    onTap: () {},
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xff63ED84),
            ));
          }
        },
      ),
    );
  }
}
