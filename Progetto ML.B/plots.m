function  plots( subsetTR, subsetVS,subsetTS, erroreTotaleTR, erroreTotaleVS, contaEpoca, trainingType,net )
%PLOTS MLB - Effettua i plot dei grafici unificandoli in un'unica finestra.

    N = size(net.W,2);
     numFeatures = size(subsetTR(:,1:end-size(net.W{1,end},1)),2);
     
    strTitle = strcat('Esito Addestramento, modalità ',trainingType)
    scrsz = get(groot,'ScreenSize');
    figure('Name',strTitle,'Position',scrsz);
    subplot(2,2,1)
    hold on;
    for i=1:size(subsetTR,1)
        if subsetTR(i,3)==0
            plot(subsetTR(i,1),subsetTR(i,2),'r*');
        else
            plot(subsetTR(i,1),subsetTR(i,2),'b*');
        end
    end
    title('TrainingSet');
    hold off;

    subplot(2,2,2);
    hold on;
    for i=1:size(subsetVS,1)
        if subsetVS(i,3)==0
            plot(subsetVS(i,1),subsetVS(i,2),'r*');
        else
            plot(subsetVS(i,1),subsetVS(i,2),'b*');
        end
    end
    title('ValidationSet');
    hold off

  
    subplot(2,2,[3 4]);
    hold on;

    
    plot(erroreTotaleTR(1:contaEpoca),'b*');
    plot(erroreTotaleVS(1:contaEpoca),'r*');
    title('Errori su TrainingSet (blu) e ValidationSet (rosso)');

    [y, a] = forwardPropagation(net,subsetTS(:,1:numFeatures));
    yTS=y{N};
    assignin('base','yTS',yTS);
       
    
    figure('Name',strcat('Test Set, modalità ',trainingType),'Position',scrsz);
    subplot(1,2,1);
    hold on;
    for i=1:size(subsetTS,1)
        if subsetTS(i,3)==0
            plot(subsetTS(i,1),subsetTS(i,2),'r*');
        else
            plot(subsetTS(i,1),subsetTS(i,2),'b*');
        end
    end
    title('Test Set');
    hold off    

    subplot(1,2,2);
    hold on;
    for i=1:size(subsetTS,1)
        if yTS(i)<0.5
            plot(subsetTS(i,1),subsetTS(i,2),'r*');
        else
            plot(subsetTS(i,1),subsetTS(i,2),'b*');
        end
    end
    title('Test Set Rete');
    hold off
    

end

