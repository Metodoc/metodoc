# Instalação
O projeto requer as tecnologias abaixo:

* Ruby 2.3.1
* Rails 5.0.1
* MySQL 5.* ou outro banco relacional como o PostgreSQL, por exemplo.

## Configuração

A após a instalação das tecnologias acima, faça os próximos passos:

1. Entre na pasta do projeto e execute:
`bundle install`

2. Configure o banco de dados:
* Entre no diretório `db/*` e edite as configurações do banco de dados, como nome de usuário, senha e nome do banco de dados.

3. Volte para o diretório principal e execute:
`rails db:create
rails db:migrate`

* Para criar o banco de dados e as tabelas do mesmo, repetivamente.

4. Execute o comando `rails server` para iniciar o servidor local.

## Atualização do framework Rails
Para atualizar o framework consulte a documentação do [Rails](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html), para verificar a diferença entre versões do framework pode utilizar o seguinte site: [RailsDiff](http://railsdiff.org/).
