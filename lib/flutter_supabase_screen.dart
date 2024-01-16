import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlutterSupabaseScreen extends StatefulWidget {
  final String title;
  const FlutterSupabaseScreen({super.key, required this.title});

  @override
  State<FlutterSupabaseScreen> createState() => _FlutterSupabaseScreenState();
}

class _FlutterSupabaseScreenState extends State<FlutterSupabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: FutureBuilder(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data?[index];
                      return Card(
                        child: ListTile(
                            title: Text(data['product_name']),
                            subtitle: Text(data['product_description']),
                            trailing: //delete
                                IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await deleteProduct(data['id']);
                                setState(() {});
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
      ),
    );
  }

  Future<List> getProducts() async {
    final future = Supabase.instance.client.from('products').select();
    return future;
  }

  //get realtime data from supabase
  Stream getRealtimeData() {
    return Supabase.instance.client.from('products').stream(primaryKey: ['id']).neq(
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
