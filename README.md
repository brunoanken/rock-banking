# RockBanking

## Rodando localmente

Para inicializar o servidor Phoenix:

  * Instale as dependências com `mix deps.get`
  * Crie e rode as migrations do banco de dados com `mix ecto.create` e `mix ecto.migrate`
  * E inicialize o servidor Phoenix `mix phx.server`

A API estará disponível em [`localhost:4000`](http://localhost:4000)

## Rodando localmente com docker

- Realize o build rodando `docker-compose build`

- Suba toda a stack com `docker-compose up`

  A aplicação Phoenix estará disponível na porta `4000` e o banco de dados Postgres estará na porta `5432`.

## Testando

Simples: `mix test` na raíz do projeto.

## API

### Métodos sem autenticação

`/api/v1/users/sign_up` => cria um novo usuário

**Requisição**

```json
{
	"name": string,
	"email": string,
	"password": string
}
```

**Resposta**

```json
{
  "data": {
    "balance": float,
    "email": string,
    "id": int,
    "name": string
  }
}
```

### Métodos com autenticação

Todos os endpoints abaixo precisam do cabeçalho `Authorization: bearer token` para seu correto funcionamento.

`/api/v1/users/sign_in` => autentica um novo usuário

**Requisição**

```json
{
	"email": string,
	"password": string
}
```

**Resposta**

```json
{
  "data": {
    "balance": float,
    "email": string,
    "id": int,
    "name": string
  },
  "token": string
}
```

`/api/v1/operations/withdraw` => realiza uma operação de saque para o usuário autenticado

**Requisição**

```json
{
	"amount": float
}
```

**Resposta**

```json
{
  "data": {
    "amount": float
  }
}
```

`/api/v1/operations/transfer` => realiza uma operação de transferência do usuário autenticado para o usuário indicado no corpo da requisição

**Requisição**

```json
{
	"to_user_id": int,
	"amount": float
}
```

**Resposta**

```json
{
  "data": {
    "amount": float,
    "id": int
  }
}
```

## Deploy

Foi realizado o deploy da aplicação na plataforma Gigalixir. A mesma se encontra disponível no seguinte domínio: https://decent-steel-meadowhawk.gigalixirapp.com/

Não foi implementada nenhuma maneira automática de realizar deploys então o recomendado é seguir o fluxo de rodar as migrations através do próprio gigalixir sempre que alguma alteração no banco de dados for necessária. Isto pode ser realizado através do comando `gigalixir run mix ecto.migrate`*.

Para subir alterações da aplicação basta rodar `git push gigalixir master`*.

**Credenciais configuradas do Gigalixir são necessárias*.
