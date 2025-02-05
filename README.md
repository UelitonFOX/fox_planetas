# 🌍 Aplicativo - Planetas (CRUD com Flutter e SQLite)

## 💀 Sobre o Projeto
Este aplicativo foi desenvolvido como parte do programa **Talento Tech 12 - Desenvolvimento de Aplicativos Móveis**.  
Ele implementa um **CRUD (Create, Read, Update, Delete)** para gerenciar informações de planetas fictícios, utilizando **Flutter** e **SQLite**.  

🔹 **Objetivo:** Criar um app responsivo, com um design moderno e persistência de dados local.  
🔹 **Destaques:** Tela de Splash, interface intuitiva e armazenamento eficiente via banco de dados local.

---

## 🛠️ Tecnologias Utilizadas
- **📌 Linguagem:** Dart
- **📌 Framework:** Flutter
- **📌 Banco de Dados:** SQLite
- **📌 Arquitetura:** MVC (Model-View-Controller)
- **📌 IDE:** Visual Studio Code
- **📌 Emulador:** Android Studio

---

## 🔥 Funcionalidades do Aplicativo
✅ **Cadastrar** um novo planeta (Nome, Distância do Sol, Tamanho e Apelido opcional)  
✅ **Listar** planetas cadastrados  
✅ **Visualizar detalhes** de um planeta  
✅ **Editar** as informações do planeta  
✅ **Excluir** planetas com **confirmação antes da exclusão**  
✅ **Persistência** dos dados no SQLite  
✅ **Tela de Splash** personalizada  
✅ **Design moderno e responsivo**  

---

## 🎨 Interface do Usuário (UI)
- **Tela inicial:** Lista de planetas cadastrados.
- **Tela de Cadastro/Edição:** Formulário para adicionar ou modificar um planeta.
- **Tela de Detalhes:** Exibição completa das informações de um planeta.
- **Tela de Splash:** Animação e identidade visual do curso Talento Tech.
- **Design atualizado:** Estilo minimalista, animações suaves e experiência fluida.

---

## 🛠️ Como Executar o Projeto

### **2⃣ Instalar as dependências**
```bash
flutter pub get
```

### **3⃣ Rodar o aplicativo no emulador/dispositivo**
```bash
flutter run
```
💡 **Dica:** Certifique-se de que o emulador Android ou um dispositivo físico está conectado antes de rodar o app.

---

## 📚 Estrutura do Projeto
```r
app_planetas/
│── lib/
│   ├── main.dart                # Tela principal (lista de planetas)
│   ├── modelos/
│   │   ├── planeta.dart          # Modelo de dados do planeta
│   ├── controles/
│   │   ├── controle_planeta.dart # Lógica do CRUD (banco de dados)
│   ├── telas/
│   │   ├── tela_planeta.dart      # Tela de cadastro/edição
│   │   ├── tela_detalhes_planeta.dart # Tela de detalhes do planeta
│   │   ├── tela_splash.dart       # Tela de splash inicial
│── android/ (código nativo Android)
│── assets/ (imagens e ícones)
│── pubspec.yaml  # Dependências do Flutter
│── README.md  # Informações do projeto
```

---

## 🏆 Requisitos Atendidos
✔ **CRUD completo com validação de campos**  
✔ **Banco de Dados SQLite para persistência local**  
✔ **Código modular e organizado seguindo o padrão MVC**  
✔ **Confirmação antes de excluir um planeta**  
✔ **Tela de Splash personalizada**  
✔ **Design atualizado e responsivo**  
✔ **Comentários explicativos no código**  

---

## 🎦 Vídeo de Demonstração
📚 Assista ao vídeo de demonstração no YouTube: **[Clique aqui](https://youtube.com/seu-video)**

---

## 📎 Links
📚 **Repositório no GitHub:** [Clique aqui](https://github.com/seu-usuario/app_planetas)  
📚 **Vídeo de Demonstração:** [Clique aqui](https://youtube.com/seu-video)  

---

## 🤝 Contribuições
Quer contribuir com melhorias no projeto? Sinta-se à vontade!  
1. **Faça um Fork** do repositório  
2. **Crie uma branch** (`feature/melhoria-nova`)  
3. **Implemente suas melhorias**  
4. **Envie um Pull Request**  

---

## 📌 Autor
👨‍💻 Desenvolvido por **UelitonFOX**  
📧 Contato: [ueliton.talento.tech@gmail.com](mailto:seu-email@email.com)  
🚀 Projeto criado para o **Talento Tech 12 - Desenvolvimento de Aplicativos Móveis**  

---

🌟 **Se gostou do projeto, deixe uma estrela no repositório!** ⭐

