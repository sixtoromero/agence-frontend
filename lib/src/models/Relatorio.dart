class Relatorio {
  
  String co_usuario;
  String no_usuario;

  double receita_liquida;
  int custo_fijo;
  double comissao;
  double lucro;

  Relatorio({this.receita_liquida, this.custo_fijo, this.co_usuario, this.no_usuario, this.comissao, this.lucro});

  factory Relatorio.fromAPI( Map<String, dynamic> json, String coUsuario, String noUsuario ){
    return Relatorio(      
      comissao: json['COMISSAO'] ?? 0,
      custo_fijo: json['CUSTO_FIJO'] ?? 0,
      lucro: json['LUCRO'] ?? 0,
      receita_liquida: json['RECEITA_LIQUIDA'] ?? 0,
      co_usuario: coUsuario,
      no_usuario: noUsuario
    );
  }

  Map<String, dynamic> toJSON() => {
    'RECEITA_LIQUIDA': receita_liquida,
    'CUSTO_FIJO': custo_fijo,
    'COMISSAO': comissao,
    'LUCRO': lucro,
    'co_usuario': co_usuario,
    'no_usuario': no_usuario

  };
}