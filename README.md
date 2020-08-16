# RockBanking

## Rodando localmente

Para inicializar o servidor Phoenix:

  * Instale as dependências com `mix deps.get`
  * Crie e rode as migrations do banco de dados com `mix ecto.create` e `mix ecto.migrate`
  * E inicialize o servidor Phoenix `mix phx.server`

A API estará rodando em [`localhost:4000`](http://localhost:4000).



## Rodando localmente com docker

- Rode `docker build .` dentro da raíz do projeto

  Este método irá falhar caso nenhum banco de dados esteja rodando localmente na porta `5432`.



## API

