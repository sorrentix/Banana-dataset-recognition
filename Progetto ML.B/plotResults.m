function  plotResults( results )
%PLOTS MLB - Crea una finestra con il dettaglio riguardante le statistiche
%della rete dopo l'apprendimento
    precisionTR = strcat('Precision: ',strcat(num2str(results.precisionTR*100),'%')) ;
    recallTR = strcat('Recall: ',strcat(num2str(results.recallTR*100),'%')) ;
    specificityTR = strcat('Specificity: ',strcat(num2str(results.specificityTR*100),'%')) ;
    accuracyTR = strcat('Accuracy: ',strcat(num2str(results.accuracyTR*100),'%')) ;
    
    precisionVS = strcat('Precision: ',strcat(num2str(results.precisionVS*100),'%')) ;
    recallVS = strcat('Recall: ',strcat(num2str(results.recallVS*100),'%')) ;
    specificityVS = strcat('Specificity: ',strcat(num2str(results.specificityVS*100),'%')) ;
    accuracyVS = strcat('Accuracy: ',strcat(num2str(results.accuracyVS*100),'%')) ;
    
    precisionTS = strcat('Precision: ',strcat(num2str(results.precisionTS*100),'%')) ;
    recallTS = strcat('Recall: ',strcat(num2str(results.recallTS*100),'%')) ;
    specificityTS = strcat('Specificity: ',strcat(num2str(results.specificityTS*100),'%')) ;
    accuracyTS = strcat('Accuracy: ',strcat(num2str(results.accuracyTS*100),'%')) ;
    
    helpdlg({'Training Set:      '  
        precisionTR
        recallTR
        specificityTR
        accuracyTR
                '  '
                '   '
                'Validation Set:     '
        precisionVS
        recallVS
        specificityVS
        accuracyVS
                '  '
                '   '
                'Test Set:     '
        precisionTS
        recallTS
        specificityTS
        accuracyTS        },'Training Analysis');
end

