# 🚀 Guia Rick and Morty

Aplicativo Flutter para explorar personagens e localizações do universo de Rick and Morty.

## 📖 Sobre

Este aplicativo consome a [Rick and Morty API](https://rickandmortyapi.com/) para exibir informações sobre personagens, locais e permite gerenciar favoritos. Desenvolvido como trabalho prático da pós-graduação na PUC Minas.

## ✨ Funcionalidades

- ✅ Listagem de personagens com scroll infinito
- ✅ Detalhes completos dos personagens
- ✅ Sistema de favoritos com persistência local
- ✅ Listagem de localizações do universo
- ✅ Visualização de residentes por localização
- ✅ Pull to refresh para atualizar dados
- ✅ Cache de imagens para melhor performance

## 🛠 Tecnologias

- **Flutter** - Framework multiplataforma
- **Provider** - Gerenciamento de estado
- **HTTP** - Requisições à API
- **SharedPreferences** - Persistência local
- **CachedNetworkImage** - Cache de imagens

## 📋 Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0 ou superior)
- [Git](https://git-scm.com/)
- Emulador Android/iOS ou dispositivo físico
- [Visual Studio Code](https://code.visualstudio.com/) (recomendado)

## 🚀 Instalação e Execução

### 1. Clone o repositório

git clone https://github.com/lucaslucindo/rick_and_morty_app.git
cd rick_and_morty_app


### 2. Instale as dependências

flutter pub get


### 3. Execute o aplicativo

flutter run


O app será iniciado no dispositivo/emulador conectado.

## 📱 Como Usar

1. **Tela Inicial**: Escolha entre Personagens, Locais ou Favoritos
2. **Personagens**: Navegue pela lista e toque para ver detalhes
3. **Favoritos**: Toque no ícone de coração para adicionar/remover favoritos
4. **Locais**: Explore as localizações e seus residentes