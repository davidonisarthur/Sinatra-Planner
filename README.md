# Planner Sinatra

Uma API REST simples e eficiente para gerenciar planos, construída com **Sinatra** e **MongoDB**.

## 📋 Sobre o Projeto

O Planner Sinatra é uma aplicação backend que fornece endpoints para criar, ler, atualizar e deletar planos. Cada plano possui um título (seguindo um padrão específico) e um status de ativação.

## 🛠️ Stack de Tecnologia

- **Ruby** 3.4.2
- **Sinatra** - Framework web minimalista
- **Sinatra-Contrib** - Extensões do Sinatra (namespace, etc)
- **MongoDB** 8.0 - Banco de dados NoSQL
- **Mongoid** ~9.0 - ODM (Object Document Mapper) para MongoDB
- **Puma** - Servidor web
- **Rackup** - Rack application server
- **Docker** & **Docker Compose** - Containerização

## 📦 Requisitos

### Local
- Ruby 3.4.2
- MongoDB 8.0
- Bundler

### Docker
- Docker
- Docker Compose

## 🚀 Instalação

### Com Docker (Recomendado)

1. Clone o repositório:
```bash
git clone <repository-url>
cd planner_sinatra
```

2. Configure as variáveis de ambiente:
```bash
cp .env.example .env
# Edite o arquivo .env com suas credenciais
```

3. Inicie os containers:
```bash
docker-compose up
```

A aplicação estará disponível em `http://localhost:4567`

### Localmente

1. Clone o repositório:
```bash
git clone <repository-url>
cd planner_sinatra
```

2. Instale as dependências:
```bash
bundle install
```

3. Configure o MongoDB:
```bash
# Certifique-se de que o MongoDB está rodando
mongodb --version
```

4. Configure as variáveis de ambiente:
```bash
export SINATRA_ENV=development
export MONGO_LOCATION=localhost
export MONGO_USER=seu_usuario
export MONGO_PASSWORD=sua_senha
```

5. Inicie a aplicação:
```bash
bundle exec rackup
```

A aplicação estará disponível em `http://localhost:9292`

## 📡 API Endpoints

Todos os endpoints utilizam JSON como formato de requisição e resposta.

### GET /plans
Retorna todos os planos cadastrados.

**Resposta (200):**
```json
{
  "data": "[{\"id\":\"...\",\"title\":\"0001-gold\",\"active\":true}]",
  "status": 200
}
```

---

### POST /plans
Cria um novo plano.

**Parâmetros (Body):**
```json
{
  "title": "0001-gold",
  "active": false
}
```

**Formato do título:** `NNNN-AAA` (4 dígitos + hífen + 3-20 letras)
- Exemplo válido: `0001-gold`, `1234-premium`

**Respostas:**
- 200: Plano criado com sucesso
- 422: Plano já existe ou formato inválido

---

### GET /plans/:id
Retorna um plano específico por ID.

**Parâmetros:**
- `id` (path) - ID do plano

**Resposta (200):**
```json
{
  "data": "[{\"id\":\"...\",\"title\":\"0001-gold\",\"active\":true}]",
  "status": 200
}
```

---

### PUT /plans/:id
Atualiza um plano existente.

**Parâmetros:**
- `id` (path) - ID do plano
- `title` (body) - Novo título (opcional)
- `active` (body) - Novo status (opcional)

**Body:**
```json
{
  "title": "0001-diamond",
  "active": true
}
```

**Respostas:**
- 200: Plano atualizado com sucesso
- 404: Plano não encontrado
- 422: Dados inválidos

---

### DELETE /plans/:id
Deleta um plano.

**Parâmetros:**
- `id` (path) - ID do plano

**Respostas:**
- 204: Plano deletado com sucesso
- 404: Plano não encontrado

---

## 📁 Estrutura do Projeto

```
planner_sinatra/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb    # Controlador base
│   │   └── plans_controller.rb          # Lógica dos planos
│   └── models/
│       ├── application_base_model.rb    # Modelo base
│       └── plan.rb                      # Modelo Plan
├── config/
│   ├── initializers/
│   │   ├── load_db.rb                   # Inicialização do banco
│   │   └── load_sinatra.rb              # Configuração do Sinatra
│   ├── mongoid.yml                      # Configuração MongoDB
│   └── routes.rb                        # Definição de rotas
├── docker-compose.yml                   # Orquestração Docker
├── Dockerfile                           # Imagem Docker
├── Gemfile                              # Dependências Ruby
├── config.ru                            # Rack config
└── README.md                            # Este arquivo
```

## 🗄️ Modelos de Dados

### Plan

| Campo | Tipo | Validação | Padrão |
|-------|------|-----------|--------|
| `id` | ObjectId | - | Auto-gerado |
| `title` | String | Regex: `NNNN-AAA` | - |
| `active` | Boolean | - | false |

**Validação de título:**
- Formato: `0000-aaaa` (4 dígitos + hífen + 3-20 letras)
- Regex: `/\A[0-9]{4}-[a-zA-Z]{3,20}\z/`

## 🔧 Variáveis de Ambiente

```bash
SINATRA_ENV=development        # Ambiente (development/production)
MONGO_LOCATION=mongodb         # Host do MongoDB
MONGO_USER=root               # Usuário MongoDB
MONGO_PASSWORD=password        # Senha MongoDB
TZ=America/Sao_Paulo          # Fuso horário
```

## 📝 Exemplos de Uso

### Usando cURL

**Criar um plano:**
```bash
curl -X POST http://localhost:4567/plans \
  -H "Content-Type: application/json" \
  -d '{"title":"0001-gold","active":false}'
```

**Listar todos os planos:**
```bash
curl http://localhost:4567/plans
```

**Obter um plano específico:**
```bash
curl http://localhost:4567/plans/PLAN_ID
```

**Atualizar um plano:**
```bash
curl -X PUT http://localhost:4567/plans/PLAN_ID \
  -H "Content-Type: application/json" \
  -d '{"active":true}'
```

**Deletar um plano:**
```bash
curl -X DELETE http://localhost:4567/plans/PLAN_ID
```

## 🐛 Troubleshooting

### Erro: "Connection refused"
- Certifique-se de que o MongoDB está rodando
- Verifique as variáveis de ambiente

### Erro: "Invalid BSON document"
- Verifique o formato do JSON enviado
- Certifique-se de que o título segue o padrão `NNNN-AAA`

## 📚 Referências

- [Sinatra Documentation](http://sinatrarb.com/)
- [Mongoid Documentation](https://mongoid.org/)
- [MongoDB Documentation](https://docs.mongodb.com/)

## 📄 Licença

Este projeto está disponível sob a licença MIT.

## 👤 Autor

Desenvolvido como uma aplicação de planejamento.
