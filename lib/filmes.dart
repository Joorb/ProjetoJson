class Filmes {
  late String titulo;
  late int ano;
  late String descricao;
  late String img;

  Filmes()
  {
    titulo = "";
    ano = 0;
    descricao = "";
    img = "";
  }

Filmes.v(this.titulo, this.ano, this.descricao, this.img);




Filmes.fromJson(Map<String, dynamic> json)
  : titulo = json['title'] as String,
    ano = json['year'] as int,
    descricao = json['text'] as String,
    img = json['image'] as String;


  Map<String, dynamic> toJson() => {
    'title': titulo,
    'year': ano,
    'text': descricao,
    'image': img,
    };
}
