function Matrix=Le_accMat2Matrix(accMat_L1,CropArea,NonCropArea)
    Matrix=zeros(3,4);
    Matrix(1:2,1:2)=accMat_L1(1:2,1:2);
    Matrix(1:2,3)=sum(accMat_L1(1:2,1:2),2);
    Matrix(1,4)=NonCropArea;
    Matrix(2,4)=CropArea;
    Matrix(3,:)=sum(Matrix(1:2,:));
end