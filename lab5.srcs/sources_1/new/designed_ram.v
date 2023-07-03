`timescale 1ns / 1ps

module designed_ram(
    input clka, 
    input wea, 
    input [63:0] addra, 
    input [63:0] dina, 
    output reg [63:0] douta, 
    input [1:0] memoryAccessByte 
);
    
    reg wea1, wea2, wea3, wea4, wea5, wea6, wea7, wea8; 
    wire [7:0] douta1,douta2, douta3, douta4, douta5, douta6, douta7, douta8;  
    
    always @(*) begin
        if (wea == 1'b1) begin
            if (memoryAccessByte == 2'b00) begin
                wea1 = 1'b1; 
                wea2 = 1'b0; 
                wea3 = 1'b0; 
                wea4 = 1'b0; 
                wea5 = 1'b0;
                wea6 = 1'b0; 
                wea7 = 1'b0; 
                wea8 = 1'b0;  
            end
            else if (memoryAccessByte == 2'b01) begin
                wea1 = 1'b1; 
                wea2 = 1'b1; 
                wea3 = 1'b1; 
                wea4 = 1'b1; 
                wea5 = 1'b0;
                wea6 = 1'b0; 
                wea7 = 1'b0; 
                wea8 = 1'b0; 
            end 
            else if (memoryAccessByte == 2'b10) begin
                wea1 = 1'b1; 
                wea2 = 1'b1; 
                wea3 = 1'b1; 
                wea4 = 1'b1; 
                wea5 = 1'b1;
                wea6 = 1'b1; 
                wea7 = 1'b1; 
                wea8 = 1'b1; 
            end
        end
    end
    
    Ram ram_unit1 (
        .clka(clka),  // ʱ��
        .wea(wea1),   // �Ƿ�д������
        .addra(addra), // ��ַ���� 
        .dina(dina[7:0]),  // ��������
        .douta(douta1)  // �������
    );
    
    Ram ram_unit2 (
        .clka(clka),  // ʱ��
        .wea(wea2),   // �Ƿ�д������
        .addra(addra + 8), // ��ַ���� 
        .dina(dina[15:8]),  // ��������
        .douta(douta2)  // �������
    );
    
    Ram ram_unit3 (
        .clka(clka),  // ʱ��
        .wea(wea3),   // �Ƿ�д������
        .addra(addra + 16), // ��ַ���� 
        .dina(dina[23:16]),  // ��������
        .douta(douta3)  // �������
    );
    
    Ram ram_unit4 (
        .clka(clka),  // ʱ��
        .wea(wea4),   // �Ƿ�д������
        .addra(addra + 24), // ��ַ���� 
        .dina(dina[31:24]),  // ��������
        .douta(douta4)  // �������
    );
    
    Ram ram_unit5 (
        .clka(clka),  // ʱ��
        .wea(wea5),   // �Ƿ�д������
        .addra(addra + 32), // ��ַ���� 
        .dina(dina[39:32]),  // ��������
        .douta(douta5)  // �������
    );
    
    Ram ram_unit6 (
        .clka(clka),  // ʱ��
        .wea(wea6),   // �Ƿ�д������
        .addra(addra + 40), // ��ַ���� 
        .dina(dina[47:40]),  // ��������
        .douta(douta6)  // �������
    );
    
    Ram ram_unit7 (
        .clka(clka),  // ʱ��
        .wea(wea7),   // �Ƿ�д������
        .addra(addra + 48), // ��ַ���� 
        .dina(dina[55:48]),  // ��������
        .douta(douta7)  // �������
    );
    
    Ram ram_unit8 (
        .clka(clka),  // ʱ��
        .wea(wea8),   // �Ƿ�д������
        .addra(addra + 56), // ��ַ���� 
        .dina(dina[63:56]),  // ��������
        .douta(douta8)  // �������
    );
    
    always @(*) begin
        if (memoryAccessByte == 2'b00) douta = {56'b0, douta1}; // 1 byte  
        else if (memoryAccessByte == 2'b01) douta = {32'b0, douta4, douta3, douta2, douta1}; // 4 byte 
        else if (memoryAccessByte == 2'b10) douta = {douta8, douta7, douta6, douta5, douta4, douta3, douta2, douta1}; // 8 byte 
    end
    
endmodule
