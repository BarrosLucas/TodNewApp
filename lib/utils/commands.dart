
class Commands{
  static const List<String> c = [
    "andarFrente",
    "girarEsquerda",
    "girarDireita",
    "pegar",
    "soltar",
    "se(vazioFrente)",
    "se(!vazioFrente)",
    "se(maoOcupada)",
    "se(!maoOcupada)",
    "senao",
    "senaose(vazioFrente)",
    "senaose(!vazioFrente)",
    "senaose(maoOcupada)",
    "senaose(!maoOcupada)",
    "enquanto(vazioFrente)",
    "enquanto(!vazioFrente)",
    "enquanto(maoOcupada)",
    "enquanto(!maoOcupada)",
  ];

  String name;
  String convert;

  Commands(this.name, this.convert);

  static Commands getCommandByName(String name){
    if(name == c.elementAt(0)){
      return Commands(c.elementAt(0),'1');
    }
    if(name == c.elementAt(1)){
      return Commands(c.elementAt(1),'2');
    }
    if(name == c.elementAt(2)){
      return Commands(c.elementAt(2),'3');
    }
    if(name == c.elementAt(3)){
      return Commands(c.elementAt(3),'4');
    }
    if(name == c.elementAt(4)){
      return Commands(c.elementAt(4),'5');
    }
    if(name == c.elementAt(5)){
      return Commands(c.elementAt(5),'6');
    }
    if(name == c.elementAt(6)){
      return Commands(c.elementAt(6),'7');
    }
    if(name == c.elementAt(7)){
      return Commands(c.elementAt(7),'8');
    }
    if(name == c.elementAt(8)){
      return Commands(c.elementAt(8),'9');
    }
    if(name == c.elementAt(9)){
      return Commands(c.elementAt(9),'A');
    }
    if(name == c.elementAt(10)){
      return Commands(c.elementAt(10),'B');
    }
    if(name == c.elementAt(11)){
      return Commands(c.elementAt(11),'C');
    }
    if(name == c.elementAt(12)){
      return Commands(c.elementAt(12),'D');
    }
    if(name == c.elementAt(13)){
      return Commands(c.elementAt(13),'E');
    }
    if(name == c.elementAt(14)){
      return Commands(c.elementAt(14),'F');
    }
    if(name == c.elementAt(15)){
      return Commands(c.elementAt(15),'G');
    }
    if(name == c.elementAt(16)){
      return Commands(c.elementAt(16),'H');
    }
    if(name == c.elementAt(17)){
      return Commands(c.elementAt(17),'I');
    }
    return Commands("",'0');
  }
  static bool existCommands(String name){
    for(String element in c){
      if(element.contains(name)){
        return true;
      }
    }
    return false;
  }
}