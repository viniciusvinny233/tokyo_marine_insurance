# 🌟 Tokyo Marine Insurance App 🌟

O Tokyo Marine Insurance é um aplicativo **Flutter moderno e responsivo**, projetado para o **gerenciamento intuitivo de seguros**. Ele oferece uma experiência de usuário **fluida e consistente**, tanto em **dispositivos móveis** quanto na **web**, focado em **alta performance** e um **design super clean**. 🚀

---

## 🚀 Instruções para Execução: Rápido e Fácil! 🚀

Quer ver o projeto rodando? É **super simples** e **rápido**! ⚡

### Como Executar o Projeto 💻

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/viniciusvinny233/tokyo_marine_insurance.git
    cd .\tokyo_marine_insurance\
    ```

2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Execute o aplicativo:**
    * **Para dispositivos móveis (Android/iOS):**
        ```bash
        flutter run
        ```
    * **Para web (no Chrome):**
        ```bash
        flutter run -d chrome
        ```

### 💡 Importante sobre o Firebase: Sem Complicações! 💡

**Não se preocupe com a configuração do Firebase!** O projeto já está **pré-configurado** para você executar diretamente, sem dores de cabeça:

* O arquivo `google-services.json` (essencial para Android) **já está incluído**.
* As configurações do Firebase para Web também estão **prontas para uso**.

Basta **clonar e executar!** ✨

---

## 🚀 Tecnologias e Arquitetura Impecável 🚀

Este projeto foi construído com as seguintes **tecnologias de ponta** e **padrões de arquitetura rigorosos**, refletindo as **melhores práticas de desenvolvimento** para garantir **escalabilidade e manutenibilidade**:

### 🔧 Tecnologias Utilizadas 🔧

* **Framework e Linguagem:**
    * **Flutter/Dart**
    * **Material Design**

* **Backend e Autenticação:**
    * **Firebase Authentication**
    * **Firebase Core**

* **Gerenciamento de Estado:**
    * **Flutter BLoC** (para um controle de estado robusto)
    * **Equatable** (para otimização de estados)
    * **BLoC Observer** (para monitoramento de estados)

* **Injeção de Dependências e Roteamento:**
    * **Flutter Modular** (para uma arquitetura modularizada)
    * **Route Guards** (para proteção inteligente de rotas)

### 🏗️ Arquitetura e Padrões de Design Aplicados 🏗️

O projeto segue um **design rigoroso** para garantir **escalabilidade** e **facilidade de manutenção**:

* **Clean Architecture:**
    * **Presentation**
    * **Domain**
    * **Data**

* **Organização Modular:**
    * **Core**
    * **Guards**
    * **Theme**
    * **Utils**
    * **Modules:**
        * **Login Module**
        * **Home Module**

* **Padrões de Design Aplicados:**
    * **Repository Pattern**
    * **Dependency Injection**
    * **BLoC Pattern**
    * **Guard Pattern**

---

## 📱 Como Usar o Aplicativo: Desbravando as Funcionalidades! 🧭

Depois de executar, é hora de explorar todas as funcionalidades! 🎉

1.  **Tela Inicial:** Você será recebido pela **tela de login/cadastro**.
2.  **Cadastro de Conta:**
    * Clique na aba "**Cadastro**".
    * Registre-se usando:
        * **CPF:** Qualquer CPF **válido** (ex: `123.456.789-00`). O sistema o converterá para o formato de e-mail internamente.
        * **Senha:** Mínimo de **6 caracteres**.
3.  **Login:** Use o **CPF** e a **senha** que você cadastrou para acessar.
4.  **Dashboard:** Explore as funcionalidades incríveis de **cotação**, **família** e **contratos**! 💼👨‍👩‍👧‍👦📄

---

## 🧪 Sistema de Testes: Qualidade Garantida! 💯

A **qualidade do código é fundamental**, e este projeto possui uma **suíte de testes abrangente** para garantir a estabilidade e o bom funcionamento.

### Ferramentas de Teste 🛠️

* **flutter_test:** O framework **base** para testes Flutter.
* **bloc_test:** Ferramenta **específica** para testar BLoCs de forma eficiente.
* **mockito:** Biblioteca **poderosa** para criação de mocks (simulando repositórios, serviços e navegação).

Para executar **todos os testes**, use:
```bash
flutter test test/all_tests.dart
```
---

## 🔐 Sistema de Autenticação

A **segurança é prioridade** neste projeto:

* **Fluxo de Autenticação:** Converte o CPF para um formato de e-mail para uso com o Firebase, armazena credenciais de forma segura e verifica o usuário atual para persistência da sessão.
* **Telas e Funcionalidades:** Inclui telas de Login e Registro com tratamento de erros (feedback visual para problemas de autenticação) e proteção de rotas via `Guard`.

---

## 🛠️ Solução de Problemas Comuns

Encontrou algum problema? Tente estas dicas:

* **Erro de compilação:** Execute `flutter clean` seguido de `flutter pub get`.
* **Problemas com o Firebase:** Verifique se sua conexão com a internet está ativa.
* **Erro de compatibilidade:** Certifique-se de que sua versão do Flutter é compatível (execute `flutter upgrade`).

---

Desenvolvido com ❤️ usando Flutter
