import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtUtil {
  static encode(String bodyReq) {
    String token;
    {
      // Create a json web token
      final jwt = JWT(
        bodyReq,
        issuer: 'https://github.com/jonasroussel/jsonwebtoken',
      );
      token = jwt.sign(SecretKey('SECRETKEY'));

      return token;
    }
  }

  static decode(String token) {
    try {
      // Verify a token
      final jwt = JWT.verify(token, SecretKey('SECRETKEY'));

      print('Payload: ${jwt.payload}');
      return jwt.payload;
    } on JWTExpiredError {
      print('jwt expired');
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
    }
  }
}
