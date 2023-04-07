[1] Apresentação [https://docs.google.com/presentation/d/1jJWNR7vEO01Cd0Ebyplv3q27BTxyp119to4XyWh1-BA/edit#slide=id.p](https://docs.google.com/presentation/d/1jJWNR7vEO01Cd0Ebyplv3q27BTxyp119to4XyWh1-BA/edit#slide=id.p)

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

### Problemas sobre conteúdo para estudo
Durante o processo de desenvolvimento, por ter poucos conteúdos sobre a placa em especifico (Orange Pi Pc Plus), foi utilizado para ajudar no processo, o livro "Raspberry Pi Assembly Language Programming", o que abstrai para a placa que tinha para o trabalho.

### Problemas encontrados e suas soluções
O primeiro problema encontrado foi para fazer o mapeamento da GPIO do fisico para virtual, problema esse que consegui resolver com a syscall sys_mmap2 que é a chamada de sistema com o valor 192, fazendo assim o SO (sistema operacional) mapear a memoria fisica para uma virtual que ele conheça, com acesso ao mapeamento pude controlar os pinos, também fui capaz de fazer um led acender, e posteriormente fazer o mesmo piscar, acendendo e apagando usando o nanosleep para dar um tempo.


### Problema para dividir um numero de digitos
Tendo um numero qualquer, por exemplo "177" como conseguir os digitos individuais dele? os digitos seriam "1", "7" e "7". Em sessões tutoriais decidimos usar o método de resto da divisão, para fazer esse processo, e conseguimos separar os digitos em unidade, dezena, centena, e assim por diante. Usei um algoritimo para fazer esse processo e foi usada a instrução `sdiv` do assembly para ARMv7 para facilitar o processo de desenvolvimento.


### LCD
O LCD foi a mais complicada, pois tinha muitos detalhes para inicia-lo corretamente, principalmente no quesito de tempo, por fim consegui inicializar o display depois de um bom tempo tentando e com ajuda dos professores que me ajudaram com insight importantes. O que fiz no display depois de inicializar, foi exibir dados e limpa-lo caso fosse necessário, assim cobrindo praticamente todas as funções necessárias para o cumprimento do problema de PBL.

### Juntar tudo
As partes individuais funcionando, e chegou a hora de juntar tudo, e nessa parte o problema veio, pois não tinha tempo para lapidar o código e encontrar possíveis problemas, acabou que não consegui juntar tudo, logo para a apresentação, só mostrei na tela os digitos que conseguia escrever e limpar a tela através de um botão, só para demonstrar que tenho certa proficiência com o controle do display através do assembly.




## Referências

[1] SMITH, Stephen. Raspberry Pi Assembly Language Programming. Apress, 2019.

[2] GNU DEBUGGER (GDB). GDB: The GNU Project Debugger. 2023. Available on [https://www.sourceware.org/gdb/](https://www.sourceware.org/gdb/)