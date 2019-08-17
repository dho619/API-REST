# API-REST
API REST criada para CRUD para um trabalho de Sistemas Distribuídos. É apenas uma api que simula um repositório de nome de animes

Passo a Passo que foi realizado para sua criação:

Programas a instalar:

Rails, ruby e mysql:  

https://gorails.com/setup/ubuntu/16.04

Atom:

https://atom.io/

Insomnia:

https://support.insomnia.rest/article/23-installation#ubuntu



Passo a Passo de criação do API REST com Rails para fazer crud usando minha API:



Primeiro, criar a API:

  rails new myAnimes --api -d mysql   


	# rails new: criando um novo programa em rails
	# --api: deixando apenas o necessário para uma API, sem parte visuais
	# -d mysql: dizendo que o banco usado, será mysql



Segundo, criar o banco para a aplicação:

  Dentro do mysql como root, usar o comando:
		
	create database Animes;
			
	passar o privilegio para o usuario desse banco, pois é recomendado não usar o root:
			
	   CREATE USER 'dho619'@'localhost' IDENTIFIED BY 'senhamuitodificil';
				
	   GRANT ALL PRIVILEGES ON ‘banco’.* TO 'novousuario'@'localhost';
	
	   FLUSH privileges; #nao esquecer de usar




Terceiro, alterar configurações no app, para colocar o login e senha do usuário:

No terminal: cd myAnimes #pasta da API
		
		  atom .  #abrir a pasta atual no atom
		

No atom, dentro do arquivo: 	MyAnimes/config/database.yml

	Na parte de username e password arrume elas assim:

		username: dho619            #colocar seu login do database
		password: senhamuitodificil  #colocar sua senha do database
		
	Na parte development, atualize com o nome do banco de dados:

		database: db_myAnimes  # O nome do database

	Obs.: Note que tem develompment, test, production,e cada um pede um banco de dados, recomenda-se ter um para cada, e o motivo já são auto explicativos pelos seus nomes.



Quarto, criar a tabela dos Animes:

	No terminal:

		#é apenas um comando
		rails g model Animes name description:text
 		release_year:integer{4} author number_eps:integer
 		still_casting:string{3}

	#rails g model: cria um modelo de tabela
	#Animes: o nome da minha tabela
	# name… : os campos e seus tipos, quando ausente o tipo, entende que é string

	
		rails db:migrate #migra essa tabela para o banco de dados




Quinto, definir os campos que o rails obrigará o usuario a colocar:

	No atom, no arquivo: MyAnimes/app/models/anime.rb, colocar na classe Anime da seguinte forma os campos obrigatórios:

		class Anime < ApplicationRecord
			validates :name, presence:true
  			validates :number_eps, presence:true
		end



Sexto, criar uma pasta dentro de Myanimes/app/controllers para o local dos métodos get, post… e dentro da pasta, criar o controllers da api, no final deve estar mais ou menos assim:
	
	 Myanimes/app/controllers/api/v1/animes_controller.rb

	# api v1, foi criado apenas para controle de versão, caso tenha mais versões para frente.





Sétimo, criar a rota, nessa API uma rota bastara

	No atom, no arquivo MyAnimes/config/routes.rb diga o caminho de onde esta os seus métodos get, post, etc.., da seguinte forma:

		Rails.application.routes.draw do
  			namespace 'api' do  			#dentro da pasta api
  				namespace 'v1' do 		#dento da pasta v1
  					resources :animes     #no arquivo animes
  				end
  			end
		end


Oitavo, voltando ao arquivo que foi criando anteriormente, Myanimes/app/controllers/api/v1/animes_controller.rb nele deve colocar:


	module Api 		  # pasando a pasta api
        	module V1    #passando a pasta v1

              	class AnimesController < ApplicationController #herdando

		
		   	end
	  	end
	end
	


Nono, no mesmo arquivo, dentro da classe, vamos criar os métodos:


	Método GET, para puxar todos os arquivos:
		
		def index #criando o metodo index
                    animes = Anime.order('created_at DESC');
                    render json: {status: 'SUCCESS', message:'Animes foram carregados:', data:animes},status: :ok
           end

		
		#def index: criando o método para get, tem que ser esse nome
		
		#animes = Anime.order('created_at DESC'): “Anime” é classe q esta 		definida em MyAnimes/app/models/anime.rb, essa parte esta 			adicionando para a variavel animes, os animes da tabela em ordem 		decrescente	de criação.

		#render json: {status: 'SUCCESS' : devolvendo um arquivo json, 		com status sucess.
		
		#message:'Animes foram carregados’ : passando a mensagem Animes…
		
		#data:animes},status: :ok : mostrar animes e dizer que status ok


	Método GET para um cadastro específico:

		def show
          		anime = Anime.find(params[:id])
          		render json: {status: 'SUCCESS', message:'Produto carregado', data:anime},status: :ok
          	end

		#o metodo tem que ter esse nome
		# Anime.find : puxando um cadastro especifico
		#paramns[:id] : o parâmetro passado vai ser o id


	




	Método POST para adicionar cadastros:

		def create
            	anime = Anime.new(anime_params)
            	if anime.save
            		render json: {status: 'SUCCESS', message:'Anime Salvo', data:anime},status: :ok
  			else
            		render json: {status: 'ERROR', message:'Anime nao Salvado', data:anime.erros},
				status: :unprocessable_entity
            	end
           end
		
		#criar o método anime_params, para receber os parametros
		#novamente o método tem que ter esse nome
		#if e eles apenas olhando se deu certo ou não salvar, para exibir a mensagem

	
	Método de Parâmentros
		
		private #metodo privado
          	def anime_params
 			params.permit(:name, :description, :release_year,
			:author, :number_eps, :still_casting)
          	end

		#apenas criando os parâmetros que serão carregados

	
	Método DELETE, para apagar cadastros

          def destroy
              anime = Anime.find(params[:id])
              anime.destroy
              render json: {status: 'SUCCESS', message:'Anime excluido',
		   data:anime}, status: :ok
          end
		
		#anime = Anime.find… : pegando o cadastro especificado
		#anime.destroy : apagando ele do cadastros
		#render json… : apenas apresentando a mensagem de ok
     
	


Método PUT, para atualizar cadastros

         def update
             anime = Anime.find(params[:id])
             if anime.update_attributes(anime_params)
             	render json: {status: 'SUCCESS', message:'Anime
 			atualizado',data:anime},status: :ok

       	  else
                	render json: {status: 'ERROR', message:'Anime não
			atualizado',data:anime.erros},status: :unprocessable_entity
             end
         end

		#anime = Anime.find… : pegando o cadastro especificado
		#if anime.update… : vai tentar atualizar, e exibi se deu certo ou 						não


Décimo, testar se funciona os métodos

	No insomnia usar:

		GET (método index):

		usar uma requisição get com localhost:3000/api/v1/animes

		GET especifico (método show):

		usar uma requisição get com localhost:3000/api/v1/animes/numeroID

		POST (método create):

		usar uma requisição post com localhost:3000/api/v1/animes

		DELETE (método destroy):

		usar requisição delete com localhost:3000/api/v1/animes/numeroID

		PUT (método update):

		usar requisição put com localhost:3000/api/v1/animes/numeroID

