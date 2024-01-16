import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@Riverpod(keepAlive: true)
class GetDataPaginate extends _$GetDataPaginate {
  @override
  FutureOr<List?> build({required int page}) async {
    var dio = Dio();
    var response = await dio.get('https://jsonplaceholder.typicode.com/photos?_start=${page}&_limit=5');
    return response.data;
  }

  Future<List?> getProducts() async {
    var dio = Dio();
    var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    return response.data['data'];
  }
}
