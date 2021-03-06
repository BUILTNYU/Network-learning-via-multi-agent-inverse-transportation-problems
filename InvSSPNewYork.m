
clear

Cost=[0.168053121	0.727474673	0.228078193	0.41976896	0.306254213
    0.744255891	0.324033196	0.901320112	0.097390899	0.881910813
    0.424206318	0.898699319	0.634238776	0.222161477	0.16095447
    0.844092089	0.675623222	0.830473051	0.105424458	0.643893601
    0.197020259	0.991671127	0.909309469	0.697229395	0.957581682
    0.818915541	0.463212962	0.218746805	0.747630838	0.908828773
    0.072325323	0.109607874	0.739534625	0.435746746	0.900491575
    0.846107712	0.12159851	0.261016429	0.054294489	0.663588862
    0.423648936	0.746471607	0.938431026	0.169936535	0.303046228
    0.140741355	0.578747704	0.957149521	0.944905792	0.074903189
    ];


obs=[1,3,5,7,0,0,0
    38,39,0,0,0,0,0
    38,39,0,0,0,0,0
    16,18,19,11,0,0,0
    33,31,21,17,15,0,0
    12,13,36,37,0,0,0
    12,13,36,37,0,0,0
    40,37,0,0,0,0,0
    33,31,21,17,15,0,0
    28,26,2,0,0,0,0
    28,26,2,0,0,0,0
    16,18,22,32,34,0,0
    8,6,24,29,0,0,0
    16,18,22,32,34,0,0
    38,35,14,11,0,0,0
    40,35,14,10,6,4,2
    16,14,10,6,4,25,34
    8,6,4,25,34,0,0
    33,31,21,17,15,0,0
    40,37,0,0,0,0,0
    8,6,4,25,34,0,0
    38,39,0,0,0,0,0
    33,31,21,17,15,0,0
    12,13,15,0,0,0,0
    12,13,36,37,0,0,0
    16,14,10,6,4,2,0
    16,14,11,0,0,0,0
    40,37,0,0,0,0,0
    33,27,0,0,0,0,0
    12,13,36,37,0,0,0
    40,37,0,0,0,0,0
    33,31,29,0,0,0,0
    12,13,36,37,0,0,0
    8,6,4,2,0,0,0
    16,18,22,32,34,0,0
    12,13,15,0,0,0,0];

obsNum=size(obs,1);

Link=[
    1	10	1	211
    2	1	10	211
    3	1	2	77
    4	2	1	77
    5	2	3	133
    6	3	2	133
    7	3	16	39
    8	16	3	39
    9	3	4	113
    10	4	3	113
    11	4	17	50
    12	17	4	50
    13	4	5	228
    14	5	4	228
    15	5	12	54
    16	12	5	54
    17	7	5	109
    18	5	7	109
    19	7	4	206
    20	4	7	206
    21	9	7	233
    22	7	9	233
    23	9	2	99
    24	2	9	99
    25	1	8	95
    26	8	1	95
    27	8	14	180
    28	14	8	180
    29	9	14	180
    30	14	9	180
    31	8	9	36
    32	9	8	36
    33	11	8	178
    34	8	11	178
    35	6	5	60
    36	5	6	60
    37	6	15	101
    38	15	6	101
    39	6	13	57
    40	13	6	57
    41	18	10	0
    42	18	11	0
    43	10	18	0
    44	11	18	0
    45	19	12	0
    46	19	13	0
    47	12	19	0
    48	13	19	0
    49	20	14	0
    50	20	15	0
    51	14	20	0
    52	15	20	0
    53	21	16	0
    54	21	17	0
    55	16	21	0
    56	17	21	0
    ];

Link(:,4)=Link(:,4)/60;
OD=[18	21
    20	19
    20	19
    19	21
    18	19
    21	20
    21	20
    19	20
    18	19
    20	18
    20	18
    19	18
    21	20
    19	18
    20	21
    19	18
    19	18
    21	18
    18	19
    19	20
    21	18
    20	19
    18	19
    21	19
    21	20
    19	18
    19	21
    19	20
    18	20
    20	21
    19	20
    20	18
    21	20
    21	18
    19	18
    21	19];


or=[18 19 20 21];
linkNum=size(Link,1);
nodeNum=21;


w=zeros(1,linkNum);
w0=w;
C=[ones(1,2*linkNum) zeros(1,linkNum+1)];
ex=1;
count=0;

A1=[eye(linkNum) -eye(linkNum)];
A2=[];
hl=zeros(1,linkNum);

for a=1:linkNum
    hl=zeros(1,nodeNum);
    
    hl(Link(a,2))=-1;
    hl(Link(a,3))=1;
    A2=[A2;hl];
end
B1=Link(:,4);
A1=[A1 A2];

A3=[eye(linkNum) -eye(linkNum) zeros(linkNum,nodeNum)];
W(1,:)=w;
for a=1:obsNum
    od=OD(a,:);
    ff=0;
    hl=zeros(1,2*linkNum+nodeNum);
    hl(2*linkNum+od(1))=-1;
    hl(2*linkNum+od(2))=1;
    for b=1:size(obs,2)
        if obs(a,b)~=0
            hl(obs(a,b))=1;
            hl(obs(a,b)+linkNum)=-1;
            ff=ff+B1(obs(a,b))+w(obs(a,b));
        end
    end
    
    
    B=[B1+w';];
    cost=[ones(1,2*linkNum) zeros(1,nodeNum)];
    M=200;
    
    Aineq=[A1;A3;];
    bineq=[B;w'];
    A=hl;
    B=ff;
    ub=[];
    [x,fval,exitflag(a)]  = cplexlp(cost,Aineq,bineq,A,B,zeros(size(A,2)),ub);
    
    w=w-[x(1:linkNum)]'+[x(linkNum+1:2*linkNum)]';
    

    
    W(a+1,:)=w';
    
end

plinks=find(sum(W)~=0);
plot(linspace(0,3*60,obsNum+1),W(:,plinks))
xlabel('Time [minutes]');
ylabel('Link apacity dual prices [minutes]')
set(gca,'FontSize', 13);
legend('show')

