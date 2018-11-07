%variáveis
tensao_maxima = 35;
tensao_dead_time = 0;
tensao_minima = -35;
frequencia = 40e3;
tempo_dead_time = 500e-9;
tempo_rise = 250e-9;
tempo_fall = 250e-9;
periodo = 1;

%programa
tempo_tensao_maxima = ((1/frequencia) - (2*tempo_rise) - (2*tempo_fall) - (2*tempo_dead_time))/2;
tempo_tensao_minima = ((1/frequencia) - (2*tempo_rise) - (2*tempo_fall) - (2*tempo_dead_time))/2;
amostras = (250e-9)/10;

%primeiro rise
t0 = 0;
v0 = tensao_minima;
t = t0 + tempo_rise;
v = tensao_dead_time;

m = (v - v0)/(t - t0);
tempo1 = t0:amostras:t;
tensao1 = v0 + m.*(tempo1 - t0);

%primeiro dead time
t0 = t;
v0 = tensao_dead_time;
t = t0 + tempo_dead_time;
v = tensao_dead_time;

m = (v - v0)/(t - t0);
tempo2 = t0:amostras:t;
tensao2 = v0 + m.*(tempo2 - t0);

%segundo rise
t0 = t;
v0 = tensao_dead_time;
t = t0 + tempo_rise;
v = tensao_maxima;

m = (v - v0)/(t - t0);
tempo3 = t0:amostras:t;
tensao3 = v0 + m.*(tempo3 - t0);

%tensão máxima
t0 = t;
v0 = tensao_maxima;
t = t0 + tempo_tensao_maxima;
v = tensao_maxima;

m = (v - v0)/(t - t0);
tempo4 = t0:amostras:t;
tensao4 = v0 + m.*(tempo4 - t0);

%primeiro fall
t0 = t;
v0 = tensao_maxima;
t = t0 + tempo_fall;
v = tensao_dead_time;

m = (v - v0)/(t - t0);
tempo5 = t0:amostras:t;
tensao5 = v0 + m.*(tempo5 - t0);

%segundo dead time
t0 = t;
v0 = tensao_dead_time;
t = t0 + tempo_dead_time;
v = tensao_dead_time;

m = (v - v0)/(t - t0);
tempo6 = t0:amostras:t;
tensao6 = v0 + m.*(tempo6 - t0);

%segundo fall
t0 = t;
v0 = tensao_dead_time;
t = t0 + tempo_fall;
v = tensao_minima;

m = (v - v0)/(t - t0);
tempo7 = t0:amostras:t;
tensao7 = v0 + m.*(tempo7 - t0);

%tensão mínima
t0 = t;
v0 = tensao_minima;
t = t0 + tempo_tensao_minima;
v = tensao_minima;

m = (v - v0)/(t - t0);
tempo8 = t0:amostras:t;
tensao8 = v0 + m.*(tempo8 - t0);

%concatenando vetores
tensao_pre = horzcat(tensao1, tensao2, tensao3, tensao4, tensao5, tensao6, tensao7, tensao8);
tensao = tensao_pre;
%criação do vetor tempo

%looping tensão
contador = 1;

while(periodo ~= contador)
    tensao = horzcat(tensao, tensao_pre);
    
    contador = contador + 1;
end

%gráfico
figure (1);
plot(tensao);
grid;
title('tensão do capacitor em função do tempo');
xlabel('tempo (s)');
ylabel('tensão (Volts)');



