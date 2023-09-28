class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;
/*
* Às vezes você não quer permitir que um parâmetro seja nulo e não há uma variável padrão natural.
* Nesse caso, você pode adicionar a palavra-chave required na frente do nome do parâmetro:
* */
  Video(
      {required this.id,
        required this.title,
        required this.channel,
        required this.thumb});
  /*
  * Método responsável por realizar o mapeamento dos membros da classe para o objeto json.
  * Para isso precisamos criar um método factory.
  * Conforme a documentação da linguagem Dart usamos a palavra-chave factory para implementar um construtor
  * que não cria uma nova instância da sua classe (como um Singleton)
  * e é isso que precisamos.
  * */
  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id")) {
      return Video(
          id: json["id"]["videoId"],
          title: json["snippet"]["title"],
          thumb: json["snippet"]["thumbnails"]["high"]["url"],
          channel: json["snippet"]["channelTitle"]);
    } else {
      return Video(
          id: json["videoId"],
          title: json["title"],
          thumb: json["thumb"],
          channel: json["channel"]
      );
    }
  }
/*
* Os mapas são coleções de dados organizados em um formato chave-valor.
* Cada elemento inserido em um mapa no Dart possui uma chave a ele relacionado.
* Os mapas são estruturas muito úteis quando precisamos relacionar cada elemento com um identificador único.
* */

/*
* O método abaixo simula um JSON através de um Map
* */
  Map<String, dynamic> toJson() {
    return {
      "videoId": id,
      "title": title,
      "thumb": thumb,
      "channel": channel
    };
  }
}
