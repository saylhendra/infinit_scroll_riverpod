import 'package:bootcamp_app/controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InfinityScrollScreen extends ConsumerStatefulWidget {
  const InfinityScrollScreen({super.key});
  @override
  ConsumerState<InfinityScrollScreen> createState() => _InfinityScrollScreenState();
}

class _InfinityScrollScreenState extends ConsumerState<InfinityScrollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Infinity Scroll Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final page = index ~/ 5; //constLimitGlobal;
                final indexPage = index % 5; //constLimitGlobal;
                final asyncValue = ref.watch(getDataPaginateProvider(page: (page)));
                return asyncValue.when(
                  data: (dataStreams) {
                    if (dataStreams?.isEmpty ?? true) return null;
                    var dataStream = (indexPage >= (dataStreams?.length.toInt() ?? 0)) ? null : dataStreams?[indexPage];
                    if (indexPage >= (dataStreams?.length.toInt() ?? 0)) return null;
                    // var data = dataStreams?[indexPage];
                    return ProviderScope(
                      child: Card(
                        elevation: 4.0,
                        child: ListTile(
                          title: Text(dataStream?['id'].toString() ?? ''),
                          subtitle: Text(dataStream?['title']),
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text('Error'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
