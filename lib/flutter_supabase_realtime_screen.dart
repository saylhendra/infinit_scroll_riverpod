import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlutterSupabaseRealtimeScreen extends StatefulWidget {
  final String title;
  const FlutterSupabaseRealtimeScreen({super.key, required this.title});

  @override
  State<FlutterSupabaseRealtimeScreen> createState() => _FlutterSupabaseScreenState();
}

class _FlutterSupabaseScreenState extends State<FlutterSupabaseRealtimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.title)),
      floatingActionButton: //add
          FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () async {
          await Supabase.instance.client.from('products').insert({
            'product_name': 'Product ${DateTime.now().millisecondsSinceEpoch}',
            'product_description': 'Description ${DateTime.now().millisecondsSinceEpoch}',
            'published_at': DateTime.now().toUtc().toString(),
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: StreamBuilder(
                // stream: getRealtimeCount(),
                stream: getRealtimePaslonData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Chip(
                        label: Text('Total data: ${snapshot.data?.length}'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder(
                // stream: getRealtimeData(),
                stream: getRealtimePaslonData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data?[index];
                          return Card(
                            child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(data['image']),
                                ),
                                // title: Text(data['product_name']),
                                title: Text(data['paslon_name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(data['product_description']),
                                    Text(data['paslon_description']),
                                    Text(data['published_at'] ?? ''),
                                  ],
                                ),
                                trailing: //delete
                                    IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteProduct(data['id']);
                                  },
                                )),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //get realtime data from supabase
  Stream getRealtimeData() {
    return Supabase.instance.client.from('products').stream(primaryKey: ['id']).neq(
      'published_at',
      '2050-01-01 00:00:00.000000+00',
    );
  }

  Stream getRealtimePaslonData() {
    return Supabase.instance.client.from('paslons').stream(primaryKey: ['id']).neq(
      'published_at',
      '2050-01-01 00:00:00.000000+00',
    );
  }

  // delete product
  Future<void> deleteProduct(int idProduct) async {
    final future = await Supabase.instance.client.from('products').delete().eq('id', idProduct);
    return future;
  }

  Stream getRealtimeCount() {
    var x = Supabase.instance.client.from('products').stream(primaryKey: ['id']);
    return x;
  }
}
