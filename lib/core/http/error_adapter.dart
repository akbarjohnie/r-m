import 'package:dio/dio.dart';
import 'package:retrofit/call_adapter.dart';
import 'package:rick_and_morty/core/core.dart';

class ErrorAdapter<T> extends CallAdapter<Future<T>, Future<T>> {
  @override
  Future<T> adapt(Future<T> Function() call) async {
    try {
      final response = await call();
      return response;
    } on DioException catch (e) {
      if (e.response == null) throw Exception();
      final restError = e.response!.data;
      throw Exception('RestError $restError');
    } catch (e) {
      log('ERROR - $e');
      log('Method: $call');

      throw Exception(e);
    }
  }
}
