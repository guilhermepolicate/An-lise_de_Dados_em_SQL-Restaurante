/* CRIE UM BANCO DE DADOS, SOLICITE O USO E CRIE AS TABELAS COM PARAMETROS E CHAVE ESTRANGEIRA*/
create database restaurante;
use restaurante;
create table funcionarios
	( id_funcionario int primary key auto_increment,
    nome varchar(255),
    cpf varchar(14),
    data_nacimento date,
    endereço varchar(255),
    telefone varchar(15),
    email varchar(100),
    cargo varchar(100),
    salario decimal(10,2), 
    data_admissao date );
    desc funcionarios;
    create table clientes
    ( id_cliente int primary key auto_increment,
    nome varchar(255),
    cpf varchar(14),
    data_nascimento date,
    endereco varchar(255),
    telefone varchar(15),
    email varchar(100),
    data_cadastro date );
    create table produtos
    ( id_produto int primary key auto_increment,
    nome varchar (255),
    descricao text,
    preco decimal (10,2),
    categoria varchar (100));
    create table pedidos
    ( id_pedido int primary key auto_increment,
    id_cliente int,
    id_funcionario int,
    id_produto int,
    quantidade int,
    preco decimal(10,2),
    data_pedido date,
    status_pedido varchar(50)
    );
    alter table pedidos add foreign key (id_cliente) references clientes(id_cliente);
    alter table pedidos add foreign key (id_funcionario) references funcionarios (id_funcionario);
    alter table pedidos add foreign key (id_produto) references produtos (id_produto);
    desc pedidos;
    create table info_produtos
    ( id_info int primary key auto_increment,
    id_produto int,
    ingredientes text,
    fornecedor varchar(255)
    );
    
/*ATUALIZE O FUNCIONARIO DE CPF 444.555.666-77, COM CARGO DE GARÇONETE' E SALAÁRIO DE.*/
/*ATUALIZE TODOS OS PEDIDOS COM DATA MENOR QUE '2004-07-06' PARA STATUS COMO 'CONCLUIDO'.*/
/*REMOVA P FUNCIONARIO DE CPF 222.333.444-55*/
set sql_safe_updates = 0;
    
select * from funcionarios where cpf = '444.555.666-77';
update funcionarios set cargo = 'Garçonete', salario = 2700.00 where id_funcionario = 4;

select * from pedidos where data_pedido < '2024-07-06';
update pedidos set status_pedido = 'Concluido' where data_pedido < '2024-07-06';

select * from funcionarios where cpf = '222.333.444-55';
delete from funcionarios where cpf = '222.333.444-55';

set sql_safe_updates = 1;

/*SELECIONE O NOME E A CATEGORIA DOS PRODUTOS QUE TEM O PREÇO SUPERIOS A 30*/
select * from produtos;
select nome, categoria from produtos where preco > 30;

/*SELECIONE O NOME, TELEFONE E A DATA DE NASCIMENTT DOS CLIENTES QUE NACERAM ANTES DE 1985*/
select * from clientes;
select nome, telefone, data_nascimento from clientes where year(data_nascimento) < '1985'order by data_nascimento desc;

/*SELECIONE O ID DO PRODUTO E OS INGREDIENTES DOS PRODUTOS QUE CONTENHAM CARNE*/
select * from info_produtos; 
select id_produto, ingredientes from info_produtos where ingredientes like 'carne%';

/*SELECIONE O NOME E A CATEGORIA DOS PRODUTOS EM ORDEM ALFABETICA POR CATEGORIA, PARA CADA CATEGORIA DEVE SER ORDENANDA PELO NOME DO PRODUTO*/
select * from produtos;
select nome, categoria from produtos order by nome asc, categoria asc;

/*SELECIONE OS 5 PRODUTOS MAIS CAROS DO RESTAURANTE*/
select * from produtos;
select * from produtos order by preco desc limit 5;

/*FAÇA BACKUP DOS DADOS DA TABELA PEDIDOS*/
select * from pedidos;
create table backup_pedidos as select * from pedidos;
 
/*SELECIONE TODOS OS PEDIDOS PENDENTES DO FUNCIONARIO ID 4*/
select * from pedidos;
select * from pedidos where id_funcionario = 4 and status_pedido = 'pendente';

/* SELECIONE TODOS OS PEDIDOS COM STATUS DIFERENTE DE 'CONCLUIDO'*/
select * from pedidos;
select * from pedidos where status_pedido <> 'concluido';

/*SELECIONE OS PEDIDOS QUE CONTENHAM ID PRODUTO: 1, 3, 5, 7, OU 8*/
select * from pedidos;
select * from pedidos where id_produto in(1,3,5,7,8);

/*SELECIONE OS CLIENTES QUE O NOME COMEÇA COM A LETRA 'C'*/
select * from clientes;
select * from clientes where nome like 'c%';

/*SELECIONE AS INFORMAÇÕES DE PRODUTOS QUE TENHAM NOS INGREDIENTES 'CARNE' OU 'FRANGO'*/
select * from produtos;
select * from produtos where descricao like '%carne%' or descricao like '%frango%';

/*SELECIONE OS PRODUTOS COM PREÇO ENTRE 20 E 30 REAIS*/
select * from produtos;
select * from produtos where preco between 20 and 30;

/*SELECIONE TODOS OS PEDIDOS NULOS */
select * from pedidos;
select * from pedidos where status_pedido is null;

/*SELECIONE O ID PEDIDO E O STATUS DA TABELA PEDIDO MOSTRANDO COMO CANCELADO AQUELES COM STATUS NULO*/
select * from pedidos;
select id_pedido, status_pedido, ifnull(status_pedido, 'cancelado')from pedidos;

/*SELECIONE NOME, CARGO, SALÁRIO DOS FUNCIONARIOS E ADICIONE UM CAMPO CHAMDO MEDIA SALARIAL QUE IRA MOSTRA ACIMA DA MÉDIA PARA 
SALÁRIO MAIOR QUE 3000, SENÃO A BAIXO DA MEDIA*/
select * from funcionarios;
select nome, cargo, salario, if (salario > 3000, 'Acima da media', 'abaixo da media') as media_salario from funcionarios;

/*CALCULE A QUANTIDADE DE PEDIDOS*/
select * from pedidos;
select sum(quantidade) from pedidos;

/*CALCULE A QUANTIDADE DE CLIENTES ÚNICOS QUE REALIZARAM PEDIDOS*/
select * from pedidos;
select count(distinct id_cliente) from pedidos;

/*CALCULE A MEDIA DE PREÇOS DOS PRODUTOS*/ 
select * from produtos;
select avg(preco) from produtos;

/*CALCULE O PREÇO MINIMO E MAXIMO DOS PRODUTOS*/
select * from produtos;
select max(preco) from produtos;
select nome, min(preco) from produtos;

/*FAÇA UM RANK COM OS 5 PRODUTOS MAIS CAROS APRESENTANDO O NOME E SEU PREÇO*/
select * from produtos;

/*SELECIONE A MEDIA DOS PREÇOS DOS PRODUTOS AGRUPADOS POR CATEGORIA*/
select * from produtos;
select categoria, avg(preco) from produtos group by categoria;

/*SELECIONE O FORNECEDOR E A QUANTIDADE DE PRODUTOS QUE DELE VIERAM E AS INFORMAÇÕES DOS PRODUTOS*/
select * from info_produtos;
select fornecedor, count(fornecedor) from info_produtos group by fornecedor;

/*SELECIONE OS FORNECEDORES QUE TEM MAIS DE UM PRODUTO CADASTRADO*/
select * from produtos;
select fornecedor, count(fornecedor) from info_produtos group by fornecedor having count(fornecedor) > 1;

/*SELECIONE OS CLINTES QUE REALIZARAM PAENAS 1 PEDIDO*/
select * from pedidos;
select id_cliente, count(id_cliente) from pedidos group by id_cliente having count(id_cliente) = 1;

/*FULL JOIN DE PRODUTOS:(ID, NOME E DESCRIÇÃO), DE INFORMAÇÕES DE PRODUTOS:(INGREDIENTES)*/
select produtos.id_produto, produtos.nome, produtos.descricao, info_produtos.ingredientes
from produtos left join info_produtos on info_produtos.id_produto=produtos.id_produto
union
select produtos.id_produto, produtos.nome, produtos.descricao, info_produtos.ingredientes
from produtos right join info_produtos on info_produtos.id_produto=produtos.id_produto;

/*INNER JOIN DE PEDIDOS: (ID, QUANTIDADE E DATA), E DE CLIENTES:(NOME E E-MAIL)*/
select pedidos.id_pedido, pedidos.quantidade, pedidos.data_pedido, clientes.nome , clientes.email
from pedidos inner join clientes on pedidos.id_cliente=clientes.id_cliente;

/*LEFT JOIN DE PEDIDOS: (ID, QUANTIDADE E DATA), DE CLIENTES: (NOME E E-MAIL) E DE FUNCIONÁRIO: (NOME)*/
select funcionarios.nome as funcinario, pedidos.id_pedido, pedidos.quantidade, pedidos.data_pedido, clientes.nome , clientes.email
from funcionarios left join pedidos on pedidos.id_funcionario=funcionarios.id_funcionario
left join clientes on pedidos.id_cliente=clientes.id_cliente;

/*LEFT JOIN DE PEDIDOS: (ID, QUANTIDADE E DATA), DE CLIENTES: (NOME E E-MAIL), DE FUNCIONÁRIO: (NOME) E DE PRODUTO: (NOME E PREÇO)*/
select funcionarios.nome as funcinario, clientes.nome as cliente, clientes.email as email_cliente, 
pedidos.id_pedido, pedidos.quantidade, pedidos.data_pedido, produtos.nome as produto, produtos.preco
from funcionarios left join pedidos on pedidos.id_funcionario=funcionarios.id_funcionario
left join clientes on pedidos.id_cliente=clientes.id_cliente
left join produtos on pedidos.id_produto=produtos.id_produto;

/*SELECIONE O NOME DOS CLIENTES COM OS PEDIDOS COM STATUS 'PENDENTE' E EXIBA POR ORDEM DESCENDENTE DE ACORDO COM O ID DO PRODUTO*/
select clientes.nome, pedidos.id_pedido, pedidos.status_pedido
from pedidos left join clientes on pedidos.id_cliente=clientes.id_cliente 
where pedidos.status_pedido = "Pendente" order by pedidos.id_pedido desc;

/*SELECIONE OS CLIENTES SEM PEDIDO*/
select clientes.nome, pedidos.id_pedido, pedidos.status_pedido
from pedidos left join clientes on pedidos.id_cliente=clientes.id_cliente
where pedidos.status_pedido is null;

/*SELECIONE O NOME DOS CLIENTE E O SEU TOTAL DE PEDIDOS*/
select clientes.nome, sum(pedidos.quantidade)
from pedidos left join clientes on pedidos.id_cliente=clientes.id_cliente
group by clientes.nome order by clientes.nome;

/*SELECIONE O PRECO TOTAL DE CADA PEDIDO*/
select clientes.nome, pedidos.quantidade, produtos.nome, pedidos.quantidade * produtos.preco as valor_total
from clientes left join pedidos on pedidos.id_cliente=clientes.id_cliente
left join produtos on pedidos.id_produto=produtos.id_produto;

/*CRIE UMA VIEW DO JOIN DE PEDIDOS: (ID, QUANTIDADE E DATA), CLIENTES: (NOME E DATA), FUNCIONÁRIOS: (NOME), PRODUTOS: (NOME E PREÇO)*/
create view resumo_pedido as select funcionarios.nome as funcinario, clientes.nome as cliente, clientes.email as email_cliente, 
pedidos.id_pedido, pedidos.quantidade, pedidos.data_pedido, produtos.nome as produto, produtos.preco
from funcionarios left join pedidos on pedidos.id_funcionario=funcionarios.id_funcionario
left join clientes on pedidos.id_cliente=clientes.id_cliente
left join produtos on pedidos.id_produto=produtos.id_produto;

/*SELECIO O ID DO PEDIDO, O NOME DO CLIENTE E O TOTAL DOS SEUS PEDIDOS DA VIEW ANTERIOR*/
select id_pedido, cliente, (quantidade * preco) as valor_total from resumo_pedido order by id_pedido;

/*ADICIONE UM CAMPO DE TOTAL DE VALOR A VIEW CRIADA*/
create or replace view resumo_pedido as select funcionarios.nome as funcinario, clientes.nome as cliente, clientes.email as email_cliente, 
pedidos.id_pedido, pedidos.quantidade, pedidos.data_pedido, produtos.nome as produto, produtos.preco, (pedidos.quantidade * produtos.preco) as total
from funcionarios left join pedidos on pedidos.id_funcionario=funcionarios.id_funcionario
left join clientes on pedidos.id_cliente=clientes.id_cliente
left join produtos on pedidos.id_produto=produtos.id_produto;

/*REALIZE NOVAMENTE UMA CONSULTA DO ID DO PEDIDO, O NOME DO CLIENTE E O TOTAL DOS SEUS PEDIDOS DA VIEW ANTERIOR RESPEITANDO A ATUALIZAÇÃO*/
select id_pedido, cliente, total from resumo_pedido order by id_pedido;

/*REFAZER A CONSULTA COM O USO DO EXPLAIN PARA COMPREENDER O JOIN*/
explain select id_pedido, cliente, (quantidade * preco) as valor_total from resumo_pedido order by id_pedido;

/*CRIE UM FUNÇÃO QUE IRA RETORNAR OS INGREDIENTES DA TABELA DE INFORMAÇÃO DOS PRODUTOS QUANDO PASSAR O ID DO PRODUTO COMO ARGUMENTO DA FUNÇÃO*/
delimiter //
create function busca_ingredientes_produtos(produto_id int)
returns varchar (200) 
reads sql data
begin
declare ingredientes varchar(200);
select info_produtos.ingredientes into ingredientes from info_produtos where id_produto = produto_id;
return ingredientes;
end //
delimiter ;

/*EXECUTE A FUNÇÃO CRIADA COM O ID '10'*/
select busca_ingredientes_produtos(10);

/*CRIE UMA FUNÇÃO QUE IRÁ RETORNAR UMA MENSAGEM DIZENDO SE O TOTAL DO PEDIDO É 
ACIMA, IGUAL OU ABAIXO DA MEDIA DE TODOS OS PEDIDOS QUANDO PASSAR O ID DO PEDIDO COMO ARGUMENTO*/
delimiter //
create function media_pedido(pedido_id int)
returns varchar(200) 
reads sql data
begin 
declare preco_produto decimal (10,2);
declare media_preco decimal (10,2);
declare comparacao varchar (200);
select produtos.preco into preco_produto from pedidos
left join produtos on pedidos.id_produto=produtos.id_produto where pedidos.id_pedido=pedido_id;
select avg(preco) into media_preco from produtos;
set comparacao = case
when preco_produto < (media_preco) then 'abaixo da média'
when preco_produto = (media_preco) then 'igual a média'
when preco_produto > (media_preco) then 'acima da media'
end;
return comparacao;
end//
delimiter ;

/*EXECUTE A FUNÇÃO COM O PEDIDO 5 E 6*/
select media_pedido(5);
select media_pedido(6); 


