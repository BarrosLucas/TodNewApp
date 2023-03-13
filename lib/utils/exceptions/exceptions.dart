class InvalidParamException implements Exception{
  final String message;
  InvalidParamException(this.message);
  @override
  String toString() {
    return message;
  }
}
class MissingParamException implements Exception{
  final String message;
  MissingParamException(this.message);
  @override
  String toString() {
    return message;
  }
}
class MissSemicolonException implements Exception{
  final String message;
  MissSemicolonException(this.message);
  @override
  String toString(){
    return message;
  }
}
class MissOpenParenthesesException implements Exception{
  final String message;
  MissOpenParenthesesException(this.message);
  @override
  String toString(){
    return message;
  }
}
class MissCloseParenthesesException implements Exception{
  final String message;
  MissCloseParenthesesException(this.message);
  @override
  String toString(){
    return message;
  }
}
class MissConditionException implements Exception{
  final String message;
  MissConditionException(this.message);
  @override
  String toString(){
    return message;
  }
}
class MissOpenBraceException implements Exception{
  final String message;
  MissOpenBraceException(this.message);
  @override
  String toString(){
    return message;
  }
}
class InvalidConditionException implements Exception{
  final String message;
  InvalidConditionException(this.message);
  @override
  String toString(){
    return message;
  }
}
class MissConditionalBlockException implements Exception{
  final String message;
  MissConditionalBlockException(this.message);
  @override
  String toString(){
    return message;
  }
}
class UnexpectedCloseBraceException implements Exception{
  final String message;
  UnexpectedCloseBraceException(this.message);
  @override
  String toString(){
    return message;
  }
}
class InvalidInstructionException implements Exception{
  final String message;
  InvalidInstructionException(this.message);
  @override
  String toString(){
    return message;
  }
}