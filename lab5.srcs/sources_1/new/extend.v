`timescale 1ns / 1ps

module extend(
    input [24:0] imm,    //������λ��
    input Sign,          //��չ���ſ����ź�
    input [2:0] ExtSel,  //������ƴ�ӷ�ʽ
    output reg [31:0] extend //��չ���������
);
    
endmodule
