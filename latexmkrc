$pdf_previewer = "start zathura %O %S";
push @cus_dep_list, "nlo nls 0 nlo2nls"; # nomenclature
sub nlo2nls { system("makeindex $_[0].nlo -s nomencl.ist -o $_[0].nls -t $_[0].nlg"); }
