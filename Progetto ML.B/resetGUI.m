function  resetGUI( h )
%RESETGUI Reimposta i valori di defualt della GUI

set(h.modalita,'Value',1);
set(h.features_edit,'String','2');
set(h.stratiInterni_edit,'String','20,30,1');
set(h.funzioniOutput_edit,'String','sigmoid,identity');
set(h.err_edit,'String','((y-z)^2)/400');
set(h.modalita_tr,'Value',1);
set(h.file_browse_tr,'String','path/to/file.m','fontweight','normal');
set(h.file_browse_tr,'BackGroundColor','white');
set(h.file_browse_tr,'ForegroundColor','black');
set(h.sample_tr,'String','400');
set(h.sample_vs,'String','800');
set(h.num_epoche_edit,'String','1000');
set(h.limit_tr,'String','<1000');
set(h.limit_vs,'String','<1000');
end

