%load database
load wine.data;

%select random samples as baseline
sample_X = 1:5:length(wine)-1;

%select different samples to recognize as a test
resemble_Y = 2:5:length(wine);

%get the classes from the first column
X_classes = wine(sample_X,1);
Y_classes = wine(resemble_Y,1);

%get the relevant data from the other columns
X = wine(sample_X,2:size(wine,2));
Y = wine(resemble_Y,2:size(wine,2));

%get the indexes of the nearest neighbors
Idx = knnsearch(X, Y);

%get the classes of the nearest neighbors
nn_classes = X_classes(Idx);

%initialize classification status with zeros (false)
classified_status = zeros(1, size(nn_classes,1));

%if some classes have been correctly classified
for i = 1:size(nn_classes)
    if nn_classes(i) == Y_classes(i)
        %change the status to one (true)
        classified_status(i) = 1;
    end
end

%get all correctly classified wines
correctly_classified = length(classified_status(classified_status == 1));

%print out the classification result
fprintf('%d out of %d (%.2f%%) wines correctly classified.\n', correctly_classified, length(nn_classes), correctly_classified/length(nn_classes)*100);