import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:bssc_app/utils/app_exceptions.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

typedef EitherResponse<T> = Future<Either<AppException, T>>;

class ApiService {
  static final _headers = {'Content-Type': 'application/json'};

  static EitherResponse<Map> postApi(String url, [var rawData]) async {
    Map fetchedData = {};

    final uri = Uri.parse(url);
    final body = rawData != null ? jsonEncode(rawData) : null;
    dev.log("jsonEncoded payload is $body");
    try {
      final response = await http.post(uri, body: body, headers: _headers);
      dev.log(response.statusCode.toString());
      // fetchedData = _getResponse(response);
      fetchedData = jsonDecode(response.body);

      // dev.log("fetched data is$fetchedData");
    } on SocketException {
      return Left(InternetException());
    } on http.ClientException {
      return Left(RequestTimeOUtException());
    } catch (e) {
      dev.log(e.toString());
      return Left(e as AppException);
    }
    return Right(fetchedData);
  }

  // static dynamic _getResponse(http.Response response) {
  //   switch (response.statusCode) {
  //     case 200:
  //       return (jsonDecode(response.body));
  //     case 400:
  //       throw BadRequestException();
  //     default:
  //       throw BadRequestException();
  //   }
  // }
}
