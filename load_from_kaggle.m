clear;
tic;
DataX = zeros(28709,2304,'single');
DataY = zeros(28709,1,'single');

fid = fopen('train.csv');
C = textscan(fid, '%d', 2305, 'Delimiter', '",', 'Headerlines',1, 'MultipleDelimsAsOne', 1);
DataX(1,:) = C{1}(2:end);
DataY(1) = C{1}(1);
for i = 2:28709
    if mod(i, 1000) == 0
        i
    end
    C = textscan(fid, '%d', 2305, 'Delimiter', '",', 'MultipleDelimsAsOne', 1);
    DataX(i,:) = C{1}(2:end);
    DataY(i) = C{1}(1);
end
fclose(fid);
toc;
DataX = DataX./255;

im = write_grid_images(DataX, [48 48], [10 10], 2, 1);
myfclf(1); imshow(im);

save data.mat DataX DataY;


%%
tic;
fid = fopen('test.csv');
C = textscan(fid, '%s', 'Delimiter', '" ', 'Headerlines',1, 'MultipleDelimsAsOne', 1);
fclose(fid);
toc;

CC =reshape(C{1}, 2304, 3589*2);

TestX = zeros(2304,3589*2,'single');
for i = 1:2304
    for j = 1:3589*2
        TestX(i,j) = str2double(CC{i,j});
    end
end

TestX = TestX'./255;

im = write_grid_images(TestX, [48 48], [10 10], 2, 1);
myfclf(1); imshow(im);

save test.mat TestX;
