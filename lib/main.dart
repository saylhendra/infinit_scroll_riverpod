import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'face_detector_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://odsimhzgsfegtywynnyt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9kc2ltaHpnc2ZlZ3R5d3lubnl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI3NjA0NzksImV4cCI6MjAxODMzNjQ3OX0.y442W_Ig6EH73Jpw8AzlMbuPlZpe7_B1wQU_j37RtIs',
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Strapi - Flutter'),
      // home: const FlutterSupabaseScreen(title: 'Supabase - Flutter'),
      // home: const FlutterSupabaseRealtimeScreen(title: 'Supabase - Flutter - Realtime'),
      home: FaceDetectorView(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: FutureBuilder(
            future: getProducts(),
            builder: (context, dataku) {
              if (dataku.connectionState == ConnectionState.done) {
                if (dataku.hasData) {
                  return ListView.builder(
                    itemCount: dataku.data?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(dataku.data?[index]['attributes']['product_name']),
                          subtitle: Text(dataku.data?[index]['attributes']['product_description']),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('Data Kosong');
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List> getProducts() async {
    var dio = Dio();
    var response = await dio.get('http://localhost:1337/api/products');
    debugPrint(response.data.toString());
    return response.data['data'];
  }
}
