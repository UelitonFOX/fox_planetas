# 🌍 Aplicativo - Planetas (CRUD com Flutter e SQLite)

## 📌 Sobre o Projeto

Este aplicativo foi desenvolvido como parte da atividade do **Talento Tech 12 - Desenvolvimento de Aplicativos Móveis**. Ele implementa um sistema **CRUD (Create, Read, Update, Delete)** para gerenciamento de informações sobre planetas, utilizando **Flutter** e **SQLite**.

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Dart
- **Framework:** Flutter
- **Banco de Dados:** SQLite
- **Arquitetura:** MVC (Model-View-Controller)
- **IDE:** Visual Studio Code

---

## 🔥 Funcionalidades do Aplicativo

✅ **Cadastrar** um novo planeta (Nome, Distância do Sol, Tamanho e Apelido opcional)  
✅ **Listar** planetas cadastrados  
✅ **Visualizar detalhes** de um planeta cadastrado  
✅ **Editar** as informações de um planeta  
✅ **Excluir** planetas com **confirmação antes da exclusão**  
✅ **Persistência** dos dados no banco SQLite

---

## 🎨 Interface do Usuário (UI)

- **Tela inicial:** Exibe a lista de planetas cadastrados.
- **Tela de Cadastro/Edição:** Permite adicionar ou modificar um planeta.
- **Tela de Detalhes:** Mostra todas as informações cadastradas do planeta.
- **Design Responsivo:** Layout adaptável para diferentes tamanhos de tela.
- **Estilo moderno:** Gradientes espaciais, animações e ícones temáticos. 🌌

---

## 🔧 Como Executar o Projeto

### **1️⃣ Clonar o repositório**

```bash
git clone https://github.com/UelitonFOX/fox_planetas
cd fox_planetas
```

### **2️⃣ Instalar as dependências**

```bash
flutter pub get
```

### **3️⃣ Rodar o aplicativo no emulador/dispositivo**

```bash
flutter run
```

💡 **Dica:** Certifique-se de que o emulador Android ou um dispositivo físico está conectado antes de rodar o app.

---

## 🏆 Requisitos Atendidos

✅ **CRUD completo** com validação dos campos  
✅ **Banco de Dados SQLite** para persistência  
✅ **Código modular e organizado seguindo o padrão MVC**  
✅ **Comentários explicativos no código**  
✅ **Confirmação antes de excluir um planeta**  
✅ **Deploy no GitHub + Vídeo de demonstração**

---

## 📂 Estrutura do Projeto

```
app_planetas/
│── lib/
│   ├── main.dart  # Tela principal (lista de planetas)
│   ├── modelos/
│   │   ├── planeta.dart  # Modelo de dados do planeta
│   ├── controles/
│   │   ├── controle_planeta.dart  # Lógica do CRUD
│   ├── telas/
│   │   ├── tela_planeta.dart  # Tela de cadastro/edição
│   │   ├── tela_detalhes_planeta.dart  # Tela de detalhes do planeta
│── android/ (código nativo Android)
│── assets/ (imagens e ícones)
│── pubspec.yaml  # Dependências do Flutter
│── README.md  # Informações do projeto
```

---

## 📺 Vídeo de Demonstração

🔗 Assista ao vídeo de demonstração do aplicativo no YouTube: **[Clique aqui](https://youtube.com/seu-video)**

---

## 📎 Links

🔗 **Repositório no GitHub:** [Clique aqui](https://github.com/UelitonFOX/fox_planetas)  
🔗 **Vídeo de Demonstração:** [Clique aqui](https://youtube.com/seu-video)

---

## 📌 Autor

👨‍💻 Desenvolvido por **Seu Nome**  
📧 Contato: [ueliton.talento.tech@gmail.com](ueliton.talento.tech@gmail.com)  
🚀 Projeto criado para o **Talento Tech 12 - Desenvolvimento de Aplicativos Móveis**

---

✨ **Se gostou do projeto, deixe uma estrela no repositório!** ⭐
