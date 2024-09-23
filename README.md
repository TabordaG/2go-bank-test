# test_2go_bank

Projeto Flutter (versão: 3.24.3-stable).

## Getting Started

O aplicativo possui apenas uma tela básica, onde é listado os produtos para compra, e exibido o valor total.
Existem também um bottom sheet somente para adicionar produto na lista.

![Alt text](checkout.png)

![Alt text](add-product.png)

[Get It] -> Usado para a injeção de dependências;
[MobX] -> Gerenciamento de estado;

### Adicionar Produto

Para adicionar um produto é preciso digitar o seu código e clicar no botão Adicionar.
Códigos inválidos retornarão uma resposta de erro: "Produto não encontrado!".

Um dos pontos iniciais deste projeto foi entender com poderia estar estruturado os dados. O resultado é o conjunto de tabelas logo abaixo, populadas com os preços da semana informados no teste.

![Alt text](tabelas.png)

### Lógica do Sistema

Segue abaixo um diagrama de sequência que mostra o fluxo dos dados dentro do sistema.

![Alt text](diagrama-sequencia.png)


## Melhorias

O projeto foi pensado para um possível abastecimento remoto. A ideia original seria trabalhar com cache e local database, alternando entre os data sources e realizando sincronizações estratégicas. Para uma quantidade pequena de amostra não faria diferença, mas começaria a trazer benefícios de performance a medida que as tabelas Product e Promotion crescessem. Infelizmente, não tive tempo suficiente para trabalhar em cima disto no teste.

A utilização do [MobX] foi apenas pensando na velocidade de desenvolvimento, já que é um gerenciamento fresco na minha cabeça por estar trabalhando com ele em outro projeto. Mas, se tivesse maior tempo, provavelmente trabalharia com bloc/cubit ou riverpod. Porque embora seja simples, o [MobX] te dá muita liberdade de código e isso atrapalha principalmente projetos grandes, que começam a ficar confusos e sem padrão.