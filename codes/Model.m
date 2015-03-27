function [rmean,bmean,rbcov]=Model()
%get crominance values (Blue Difference and Red difference) of skin sample images
[cr1, cb1] = get_crcb('sampleset/1.jpg');
[cr2, cb2] = get_crcb('sampleset/2.jpg');
[cr3, cb3] = get_crcb('sampleset/3.jpg');
[cr4, cb4] = get_crcb('sampleset/4.jpg');
[cr5, cb5] = get_crcb('sampleset/5.jpg');
[cr6, cb6] = get_crcb('sampleset/6.jpg');
[cr7, cb7] = get_crcb('sampleset/7.jpg');
[cr8, cb8] = get_crcb('sampleset/8.jpg');
[cr9, cb9] = get_crcb('sampleset/9.jpg');
[cr10, cb10] = get_crcb('sampleset/10.jpg');
[cr11, cb11] = get_crcb('sampleset/11.jpg');
[cr12, cb12] = get_crcb('sampleset/12.jpg');
[cr13, cb13] = get_crcb('sampleset/13.jpg');
%Made the model using different skin colors and their Cb and Cr values 
cr = [cr1 cr2 cr3 cr4 cr5 cr6 cr7 cr8 cr9 cr10 cr11 cr12 cr13];
cb = [cb1 cb2 cb3 cb4 cb5 cb6 cb7 cb8 cb9 cb10 cb11 cr12 cb13];

%rmean and bmean are means
rmean = mean(cr);
bmean = mean(cb);

%rbcov is covariance
rbcov = cov(cr,cb);

%Model Generated
end