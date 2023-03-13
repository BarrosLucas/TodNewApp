import 'package:tod/utils/commands.dart';
import 'package:tod/utils/exceptions/exceptions.dart';

class Compiler{

  String getCommands(String code){
    code = clearSpaces(code);
    String currentCode = "";
    String generatedCommand = "";
    int onBloc = 0;
    for(int i = 0; i < code.length; i++){
      if(currentCode == 'andarFrente' ||
          currentCode == 'girarEsquerda' ||
          currentCode == 'girarDireita'){
        if(code[i] == '('){
          int len = parameter(')', code, i+1);
          if(len == -1){
            throw InvalidParamException("Parametro inválido");
            //Parametro invalido
          }else if(len == 0){
            throw MissingParamException("Falta parametro");
            //Falta parametro
          }else if(len == -2){
            throw MissCloseParenthesesException("Faltou fechar parêntesis");
            //Faltou fechar parenteses
          }else{
            if(currentCode == 'andarFrente'){
              generatedCommand += '1'* int.parse(code.substring(i+1,i+1+len));
            }else if(currentCode == 'girarEsquerda'){
              generatedCommand += '2'* int.parse(code.substring(i+1,i+1+len));
            }else{
              generatedCommand += '3'* int.parse(code.substring(i+1, i+1+len));
            }
            currentCode = "";
            i = (i+1)+len;
            if(code[i+1] != ';'){
              throw MissSemicolonException("Faltou ponto-e-vírgula");
              //Faltou encerrar com ';'
            }else{
              i++;
            }
          }
        }else{
          throw MissOpenParenthesesException("Faltou abrir parentesis");
          //Deveria ser um '('
        }
      }else if(currentCode == 'pegar' ||
          currentCode == 'soltar'){
        if(code[i] == '('){
          //Tá ok
          int len = parameter(')',code, i+1, isInt: false);
          if(len == 0){
            //Tá ok
            if(currentCode == 'pegar'){
              generatedCommand += '4';
            }else{
              generatedCommand += '5';
            }
            currentCode = "";
            i = (i+1)+len;
            if(code[i+1] != ';'){
              throw MissSemicolonException("Faltou ponto-e-vírgula");
              //Faltou encerrar com ';'
            }else{
              i++;
            }

          }else if(len == -2) {
            //Faltou fechar parenteses
            throw MissCloseParenthesesException("Faltou fechar parêntesis");
          }else{
            //Não deveria ter parametro
            throw InvalidParamException("Parâmetro inválido");
          }
        }else{
          //Deveria ser um '('
          throw MissOpenParenthesesException("Faltou abrir parêntesis");
        }
      }else if(currentCode == 'se' && code[i] == '('){
        int length = parameter(')', code, i, isInt: false);
        if(length == 0){
          //Faltou parametro
          throw MissConditionException("Faltou a condição");
        }else if(length == -2){
          //Não encontrou o ')'
          throw MissCloseParenthesesException("Faltou fechar a condição");
        }else{
          String substring = code.substring(i+1,i+length);
          if(substring == 'vazioFrente'){
            generatedCommand += '6';
            currentCode = "";
            i = (i+1)+length;
            if(code[i] != '{'){
              //Faltou abrir '{'
              throw MissOpenBraceException("Faltou abrir chave");
            }else{
              generatedCommand += '{';
              onBloc ++;
            }
          }else if(substring == '!vazioFrente'){
            generatedCommand += '7';
            currentCode = "";
            i = (i+1)+length;
            if(code[i] != '{'){
              //Faltou abrir '{'
              throw MissOpenBraceException("Faltou abrir chave");
            }else{
              generatedCommand += '{';
              onBloc ++;
            }
          }else if(substring == 'maoOcupada'){
            generatedCommand += '8';
            currentCode = "";
            i = (i+1)+length;
            if(code[i] != '{'){
              throw MissOpenBraceException("Faltou abrir chave");
            }else{
              generatedCommand += '{';
              onBloc ++;
            }
          }else if(substring == '!maoOcupada'){
            generatedCommand += '9';
            currentCode = "";
            i = (i+1)+length;
            if(code[i] != '{'){
              throw MissOpenBraceException("Faltou abrir chave");
            }else{
              generatedCommand += '{';
              onBloc ++;
            }
          }else{
            //Condicao invalida
            throw InvalidConditionException("Condição inválida");
          }
        }

      }else if(currentCode == 'senao' && code[i] == '{'){
        if(isValidConditional(generatedCommand)) {
          generatedCommand += 'A{';
          currentCode = "";
          onBloc ++;
        }else{
          throw MissConditionalBlockException("Deveria vir após um \"se\" ou \"senao\"");
          //Tem que vir depois de um senao ou de um se
        }

      }else if(currentCode == 'senaose'){
        if(code[i] == '('){
          if(isValidConditional(generatedCommand)) {
            //Ta ok
            int length = parameter(')', code, i, isInt: false);
            if (length == 0) {
              throw MissConditionException("Faltou a condição");
              //Faltou parametro
            } else if (length == -2) {
              throw MissCloseParenthesesException("Faltou fechar parêntesis");
              //Não encontrou o ')'
            } else {
              String substring = code.substring(i + 1, i + length);
              if (substring == 'vazioFrente') {
                generatedCommand += 'B';
                currentCode = "";
                i = (i + 1) + length;
                if (code[i] != '{') {
                  //Faltou abrir '{'
                  throw MissOpenBraceException("Faltou abrir chave");
                } else {
                  generatedCommand += '{';
                  onBloc ++;
                }
              } else if (substring == '!vazioFrente') {
                generatedCommand += 'C';
                currentCode = "";
                i = (i + 1) + length;
                if (code[i] != '{') {
                  //Faltou abrir '{'
                  throw MissOpenBraceException("Faltou abrir chave");
                } else {
                  generatedCommand += '{';
                  onBloc ++;
                }
              } else if (substring == 'maoOcupada') {
                generatedCommand += 'D';
                currentCode = "";
                i = (i + 1) + length;
                if (code[i] != '{') {
                  //Faltou abrir '{'
                  throw MissOpenBraceException("Faltou abrir chave");
                } else {
                  generatedCommand += '{';
                  onBloc ++;
                }
              } else if (substring == '!maoOcupada') {
                generatedCommand += 'E';
                currentCode = "";
                i = (i + 1) + length;
                if (code[i] != '{') {
                  //Faltou abrir '{'
                  throw MissOpenBraceException("Faltou abrir chave");
                } else {
                  generatedCommand += '{';
                  onBloc ++;
                }
              } else {
                //Condicao invalida
                throw InvalidConditionException("Condição inválida");
              }
            }
          }else{
            throw MissConditionalBlockException("Deve vir após um \"se\" ou \"senao\"");
            //tem que vir depois de um "se" ou "senao"
          }
        }else{
          //Deveria ser '(';
          throw MissOpenParenthesesException("Faltou abrir parêntesis");
        }
      }else if(currentCode == 'enquanto'){
        if(code[i] == '('){
          //Ta ok
          int length = parameter(')', code, i, isInt: false);
          if(length == 0){
            throw MissConditionException("Faltou uma condição");
            //Faltou parametro
          }else if(length == -2){
            //Não encontrou o ')'
            throw MissCloseParenthesesException("Faltou fechar parentesis");

          }else {
            String substring = code.substring(i + 1, i + length);
            if (substring == 'vazioFrente') {
              generatedCommand += 'F';
              currentCode = "";
              i = (i + 1) + length;
              if (code[i] != '{') {
                //Faltou abrir '{'
                throw MissOpenBraceException("Faltou abrir chave");
              } else {
                generatedCommand += '{';
                onBloc ++;
              }
            } else if (substring == '!vazioFrente') {
              generatedCommand += 'G';
              currentCode = "";
              i = (i + 1) + length;
              if (code[i] != '{') {
                throw MissOpenBraceException("Faltou abrir chave");
              } else {
                generatedCommand += '{';
                onBloc ++;
              }
            } else if (substring == 'maoOcupada') {
              generatedCommand += 'H';
              currentCode = "";
              i = (i + 1) + length;
              if (code[i] != '{') {
                throw MissOpenBraceException("Faltou abrir chave");
              } else {
                generatedCommand += '{';
                onBloc ++;
              }
            } else if (substring == '!maoOcupada') {
              generatedCommand += 'I';
              currentCode = "";
              i = (i + 1) + length;
              if (code[i] != '{') {
                throw MissOpenBraceException("Faltou abrir chave");
              } else {
                generatedCommand += '{';
                onBloc ++;
              }
            } else {
              throw InvalidConditionException("Condição inválida");
            }
          }
        }else{
          throw MissOpenParenthesesException("Faltou abrir parêntesis");
        }
      }

      else{
        if(code[i] == '}'){
          if(onBloc > 0){
            onBloc --;
            generatedCommand += '}';
            currentCode = "";
          }else{
            throw UnexpectedCloseBraceException("Fechamento de chave inesperado");
          }
        }
        else if(code[i] == '\n' || code[i] == ' ' || code[i] == '\t'){
        }else {
          currentCode += code[i];
        }
      }
    }
    if(onBloc > 0){
      throw MissCloseParenthesesException("Faltou fechar parêntesis");
    }
    if(currentCode.isEmpty){
      return generatedCommand;
    }else{
      throw InvalidInstructionException("Instrução inválida");
    }

  }

  int parameter(String character, String code, int index, {bool isInt = true}){
    int length = 0;
    String value = "";

    for(int i = index; (code[i] != character[0] && (i < code.length)); i++){
      length ++;
      if(isInt){
        value += code[i];
      }
      if(code[i] != character && i == (code.length-1)){ //Não encontrou
        return -2;
      }
    }
    if(isInt) {
      int? number = int.tryParse(value);
      if (number != null) {
        return length;
      }
      return -1;
    }
    return length;
  }

  bool isValidConditional(String generated){
    if(generated[generated.length-1]!='}'){
      return false;
    }
    int bloc = 1;
    for(int i = generated.length-2; i > 0 && bloc != 0;i--){
      if(generated[i] == '{'){
        bloc --;
        if(bloc == 0){
          if(generated[i-1] == '6' ||
              generated[i-1] == '7' ||
              generated[i-1] == '8' ||
              generated[i-1] == '9' ||
              generated[i-1] == 'B' ||
              generated[i-1] == 'C' ||
              generated[i-1] == 'D' ||
              generated[i-1] == 'E'){
            return true;
          }
        }
      }else if(generated[i] == '}'){
        bloc ++;
      }
    }
    return false;
  }

  String clearSpaces(String text) {
    return text.replaceAll(RegExp(r'\s+'), '');
  }
}