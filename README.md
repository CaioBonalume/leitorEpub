# Leitor de Epub

A new Flutter project.

## Getting Started

Essa é uma aplicação em FLutter desenvolvida para o desafio da Escribo.

Os pacotes utilizados foram:

- [vocsy_epub_viewer](https://pub.dev/packages/vocsy_epub_viewer)
- [http](https://pub.dev/packages/http)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [provider](https://pub.dev/packages/provider)
- [path_provider](https://pub.dev/packages/path_provider)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

### Tema
A aplicação funciona de acordo com o tema do aparelho do usuário, sendo Navegador, android ou iOS

### Icone da aplicação
Foi aplicado um icone em baixa resoulução em png da logo da Escribo. Para fácil identificação do usuário

### Modelo
Neste desafio foi necessário criar apenas 1 tipo de modelo que seria para receber os objetos da API. Você pode encontra-lo na pasta lib/model.

### Acesso a API
Foi escolhido a biblioteca http por se tratar de uma API simples logo tendo uma reposta mais rápida que outras bibliotecas.

### Construção de telas
As telas que recuperam as informações da API sendo elas ListView ou GridView foram criadas a partir de um FutureBuilder criado no arquivo book_page.dart que se encontra em lib/pages/Home. Um contrutor que recebe uma lista do modelo citado acima, verifica se teve resposta de informação(data) e prosegue carregando a widget, ou apresenta o erro, enquanto aguarda a resposta da API ele apresenta um indicador circular para que o usuário saiba que esta em processo de aguarde de respota.

A tela inicial da as boas-vindas com um widget simples de texto que recebe de forma dinâmica o nome do usuário.

Utilizado para uma apresentação mais agradável o Widget Stack para empilhamento de widgets e para que o Stack não ficasse pesado com uma imagem que é um botão optei por usar o widget IgnorePointer para que fosse considerado o InkWell atras da imagem.

### Função de toque ao livro
Para que o livro não precise ser baixado toda vez que o usuário toque no mesmo para ler, o livro é armazenado localmente e uma SnackBar aparece avisando o usuário que seu livro esta sendo baixado, após a primera vez e sempre que selecionado novamente, o mesmo apenas abre o livro já armazenado sendo assim mais rápida a respota da aplicação

### Favoritos
Foi iniciada a implementação do botão favoritos que salva localmente a informação e cria uma lista dinâmica com os novos objetos, porém não finalizada, se desejar acompanhar o avanço desta função ela será finalizada em breve.
E você pode testa-la atras da branch [ADD-Fav-Button](https://github.com/CaioBonalume/leitorEpub/tree/ADD-Fav-Button).

### Pretenções
- Implementação de armazenar localmente a lista de livros favoritos.
- Implementação de botão de delete.
- Implementação de barra de indicação de avanço do download.

## Autor

- [@CaioBonalume](https://github.com/CaioBonalume)


## 🔗 Links
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/caio-bonalume-87b1974b/)
