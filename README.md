# Temporizador em um Display LCD
## Tema

Desenvolvimento de software usando linguagem Assembly para arquitetura cortex A7 e aplicação de conceitos de arquitetura de computadores.

## Objetivos de Aprendizagem

Após a conclusão deste desafio, o estudante deverá ter adquirido as seguintes habilidades:

- Programação em Assembly para um processador baseado na arquitetura ARM;
- Compreensão do conjunto de instruções da arquitetura ARM e sua aplicação de acordo com as necessidades do sistema;
- Capacidade de construir uma biblioteca a partir de um código Assembly;
- Avaliação do desempenho de um código Assembly através da análise do comportamento de sua execução no sistema.

## Problema

Este projeto tem como principal propósito criar um temporizador capaz de exibir valores numéricos inteiros em um display LCD específico da Orange pi Pc Plus. Para tanto, o controle tanto do processador quanto do display será realizado por meio da linguagem de baixo nível Assembly. Com o intuito de permitir a correta aplicação e execução do código e biblioteca aqui desenvolvidos, abaixo serão apresentados os comandos necessários para tal finalidade.

- O tempo inicial deverá ser configurado diretamente no código.
- 2 botões de controle devem ser usados: 1 para iniciar/parar a contagem e outro para reiniciar a partir do tempo definido.

Com o propósito de criar uma biblioteca que possa ser utilizada posteriormente em conjunto com um programa em linguagem C, é necessário que a função responsável pelo envio de mensagem para o display seja separada em um arquivo de biblioteca (.o). Esta biblioteca deve possibilitar, no mínimo, as seguintes operações:

1. Limpar display;
2. Escrever caractere;
3. Posicionar cursor (linha e coluna).


## Pré-requisitos

- Orange Pi Pc Plus
- Cliente SSH

## Passo a passo

1. Acessar a Orange Pi Pc Plus via ssh
2. Realizar git-clone deste repositório com o comando:

```
git clone git@github.com:silas-silas/Timer_Assembly_OrangePI_ARMv7
```

3. Acesse a pasta contendo o temporizador:

```
cd timer
```

4. Realize a montagem da main.s com:

```
make
```

5. Se tudo der certo, insira o comando:

```
sudo ./main
```

## Ferramentas
- GDB : Para debugar a execução assembly na Orange Pi Pc Plus.
- CPulator : Usado no inicio para compilar codigos simples em assembly. [https://cpulator.01xz.net/?sys=arm](https://cpulator.01xz.net/?sys=arm)

## Execução


## Debugando com o GDB

O GDB (GNU Debugger) é uma ferramenta de software livre utilizada para depurar códigos em diversas linguagens, incluindo C, C++, Fortran e Assembly, entre outras. Ele permite a execução do programa em modo de depuração, onde é possível parar a execução em pontos específicos do código, examinar o valor das variáveis, avaliar expressões, observar o comportamento do programa linha a linha e identificar possíveis erros. O GDB é amplamente utilizado por programadores e desenvolvedores de software para facilitar o processo de depuração e melhorar a qualidade do código.

```
make
```

Executar o make já deixa o programama pronto para ser executado com GDB, pois já tem os comandos especificos para executar o GDB.

```
sudo gdb ./main
```

Após esse comando o GDB irá inicializar, para fazer uso do mesmo há um conjunto de comandos básicos importantes nesse processo, tais como:

- `l` Exibe as 10 primeiras linhas do código
- `b` Define um ponto de parada no momento de debugar o código, é obrigatório especificar onde será o ponto de parada, exemplo : `b _start`.
- `r` Inicia a execução do programa e sua depuração
- `s` Executa o código linha a linha e os pontos de parada definidos
- `i r` Exibe os valores e estados atuais dos registradores

## Problemas encontrados durante o desenvolvimento

Durante o processo de desenvolvimento, por ter poucos conteúdos sobre a placa em especifico (Orange Pi Pc Plus), foi utilizado para ajudar no processo, o livro "Raspberry Pi Assembly Language Programming", o que abstrai para a placa que tinha para o trabalho.
A data prevista para terminar a atividade foi até dia 31/03/2023, e acabou não sendo possivel concluir o trabalho, o que consegui foi, fazer o mapeamento da GPIO do fisico para virtual, assim tendo acesso ao GPIO pude controlar os pinos, onde fui capaz de fazer um led acender, e posteriormente fazer o mesmo piscar, acendendo e apagando.
Em sessões tutoriais decidimos usar o método de resto da divisão, para separar os digitos de um numero inteiro maior que 10, por exemplo o numero 117, ficaria "1", "1" e "7", usando o resto da divisão por 10, e divisões por multiplos de 10, conseguimos separar os digitos em unidade, dezena, centena, e assim por diante, essa parte também consegui fazer, onde usei um algoritimo para fazer esse processo e usei a instrução `sdiv` do assembly para ARMv7 para facilitar o processo de desenvolvimento.
Para mostrar os digitos, é necessario acessar e configurar o LCD, onde acabei tendo problemas, tanto para inicializar o display, como para mandar dados para o mesmo, e no final não consegui mandar os dados para o LCD.

## Referências

[1] SMITH, Stephen. Raspberry Pi Assembly Language Programming. Apress, 2019.

[2] GNU DEBUGGER (GDB). GDB: The GNU Project Debugger. 2023. Available on [https://www.sourceware.org/gdb/](https://www.sourceware.org/gdb/)