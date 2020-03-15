class Consultor {
  String co_usuario;
  String no_usuario;
  bool selected;

  Consultor({ this.co_usuario, this.no_usuario, this.selected });

  factory Consultor.fromApi( Map<String, dynamic> json ){
    return new Consultor(
      co_usuario: json['co_usuario'],
      no_usuario: json['no_usuario'],
      selected: false
    );
  }


  Map<String, dynamic> toJSON() => {
    'co_usuario': co_usuario,
    'no_usuario': no_usuario
  };

}
