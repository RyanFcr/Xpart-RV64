`timescale 1ns / 1ps

module SCPU(
    input         clk,
    input         rst,
    input  [31:0] inst,
    input  [63:0] data_in,  // data from data memory
    input  [4:0]  debug_reg_addr, 
    output [63:0] addr_out, // data memory address
    output [63:0] data_out, // data to data memory
    output [63:0] pc_out,   // connect to instruction memory
    output        mem_write, 
    output [63:0]  debug_reg_addr_out, 
    output [1:0] memoryAccessByte 
    );
    
    // ʵ�� CPU ����
    wire mmu_stall, memory_access_start, pc_change, stall, flush, csr_stall, hazard_stall, branch_prediction_we, is_taken_IF, sfence_vma_IF_ID; 
    wire [63:0] output_pa, mem_pa, adderoutput,target_address;
    wire [1:0] memory_access_cnt; 
    wire [63:0]  stored_pc_IF; 
    reg [63:0] csr_data_WB;
    reg [63:0]  branch_pc;
    reg [11:0] csr_addr_WB, csr_addr_read;
    wire [11:0] stored_address_IF, branch_address; 
    reg for_csr_write, real_taken; 
    wire for_reg_write, branch_IF; 
    wire [4:0] for_rd_write; 
    
    pc pc_unit(
        .clk(clk), 
        .rst(rst), 
        .stall(stall), 
        .pc_change(pc_change), 
        .csr_stall(csr_stall), 
        .is_taken(is_taken_IF), 
        .target_address(target_address), 
        .adderoutput(adderoutput),
        .mmu_stall(mmu_stall), 
        .curpc(pc_out) 
    );

    assign branch_IF = (inst[6:0] == 7'b1100011);
    branch_prediction branch_prediction_unit( 
        .clk(clk), 
        .branch(branch_IF), 
        .we(branch_prediction_we), 
        .real_taken(real_taken), 
        .branch_address(branch_address), 
        .branch_pc(branch_pc), 
        .pc_out(pc_out), 
        .stored_address(stored_address_IF), 
        .stored_pc(stored_pc_IF), 
        .target_address(target_address), 
        .is_taken(is_taken_IF) 
    );

//---------------------------------------------------- IF_ID stage
    
    wire [3:0] alu_op_IF_ID;
    wire [1:0] pc_src_IF_ID, mem_to_reg_IF_ID;
    wire memory_access_IF_ID, alu_src_IF_ID, branch_IF_ID, alu_src_b_IF_ID, reg_write_IF_ID, mem_write_IF_ID, mem_read_IF_ID, hazard_mem_read_ID_EX, csr_write_IF_ID, ecall_IF_ID, sret_IF_ID, illegal_IF_ID, is_taken_IF_ID;
    wire [63:0] rs1_out, rs2_out, imm_IF_ID, csr_out_IF_ID, satp;
    wire [31:0] inst_IF_ID, pc_IF_ID, stored_pc_IF_ID;
    reg  [63:0] mem_to_reg_data; 
    wire [4:0] hazard_rd_ID_EX; 
    wire [2:0] b_type_IF_ID; 
    wire [11:0] stored_address_IF_ID; 
    wire [1:0] memoryAccessByte_IF_ID;  

    IF_ID_reg IF_ID_reg (
        .clk(clk), 
        .inst(inst), 
        .pc(pc_out), 
        .stall(stall), 
        .csr_stall(csr_stall), 
        .flush(flush), 
        .stored_address_IF(stored_address_IF), 
        .stored_pc_IF(stored_pc_IF), 
        .is_taken_IF(is_taken_IF),
        .mmu_stall(mmu_stall),  
        .inst_IF_ID(inst_IF_ID),
        .pc_IF_ID(pc_IF_ID), 
        .stored_address_IF_ID(stored_address_IF_ID), 
        .stored_pc_IF_ID(stored_pc_IF_ID), 
        .is_taken_IF_ID(is_taken_IF_ID)
    );

    hazard_detection_unit hazard_detection_unit(
        .hazard_mem_read_ID_EX(hazard_mem_read_ID_EX), 
        .hazard_rd_ID_EX(hazard_rd_ID_EX), 
        .hazard_stall(hazard_stall), 
        .pc_change(pc_change), 
        .inst_IF_ID(inst_IF_ID), 
        .stall(stall), 
        .flush(flush) 
    );

    mycontrol control ( 
        .stall(stall), 
        .flush(flush), 
        .ecall(ecall_IF_ID), 
        .sret(sret_IF_ID), 
        .csr_reg(inst_IF_ID[31:20]), 
        .op_code(inst_IF_ID[6:0]),
        .funct3(inst_IF_ID[14:12]),
        .funct7(inst_IF_ID[31:25]),
        .pc_src(pc_src_IF_ID),         // 2'b00 表示pc的数据来自pc+4, 2'b01 表示数据来自JALR跳转地址, 2'b10表示数据来自JAL跳转地址(包括branch). branch 跳转根据条件决定
        .reg_write(reg_write_IF_ID),   // 1'b1 表示写寄存器
        .alu_src_b(alu_src_b_IF_ID),   // 1'b1 表示ALU B口的数据源来自imm, 1'b0表示数据来自Reg[rs2]
        .alu_op(alu_op_IF_ID),         // 用来控制ALU操作，具体请看AluOp.vh中对各个操作的编�???
        .mem_to_reg(mem_to_reg_IF_ID), // 2'b00 表示写回rd的数据来自ALU, 2'b01表示数据来自imm, 2'b10表示数据来自pc+4, 2'b11 表示数据来自data memory
        .mem_write(mem_write_IF_ID),   // 1'b1 表示写data memory, 1'b0表示读data memory
        .branch(branch_IF_ID),         // 1'b1 表示是branch类型的指�???
        .b_type(b_type_IF_ID),          // 与funct3相同
        .mem_read(mem_read_IF_ID), 
        .csr_write(csr_write_IF_ID), 
        .illegal(illegal_IF_ID), 
        .memoryAccessByte(memoryAccessByte_IF_ID), 
        .memory_access(memory_access_IF_ID) 
    );
    assign ecall_IF_ID = (inst_IF_ID == 32'h00000073); 
    assign sret_IF_ID = (inst_IF_ID == 32'h10200073);
    assign sfence_vma_IF_ID = (inst_IF_ID[31:25] == 7'b0001001&&inst_IF_ID[14:0] == 15'b000000001110011);
    always @(*) begin
        csr_addr_read = inst_IF_ID[31:20]; 
        if (ecall_IF_ID == 1 || illegal_IF_ID == 1) csr_addr_read = 12'h105; 
        else if (sret_IF_ID == 1) csr_addr_read = 12'h141; 
    end

    Regs reg32(
        .clk(clk), 
        .rst(rst), 
        .we(for_reg_write), 
        .debug_reg_addr(debug_reg_addr), 
        .read_addr_1(inst_IF_ID[19:15]), 
        .read_addr_2(inst_IF_ID[24:20]), 
        .write_addr(for_rd_write), 
        .write_data(mem_to_reg_data), 
        .read_data_1(rs1_out), 
        .read_data_2(rs2_out),
        .debug_reg_addr_out(debug_reg_addr_out) 
    );
    
    CSR csr_regs(
        .clk(clk), 
        .rst(rst), 
        .ecall(ecall_IF_ID), 
        .illegal(illegal_IF_ID), 
        .we(for_csr_write), 
        .csr_reg(csr_addr_read), 
        .write_addr(csr_addr_WB), 
        .write_data(csr_data_WB), 
        .csr_out(csr_out_IF_ID), 
        .satp_out(satp) 
    );

    immgen getimm(
        .inst(inst_IF_ID), 
        .imm(imm_IF_ID) 
    );
    
//--------------------------------------------- ID_EX stage

    wire [63:0] data1, data2, pc_ID_EX, imm_ID_EX, res_ID_EX, forwarding_res_EX_MEM, csr_out_ID_EX,stored_pc_ID_EX;
    wire[31:0]  inst_ID_EX;
    wire [1:0] pc_src_ID_EX, mem_to_reg_ID_EX, forwarding_a, forwarding_b, memoryAccessByte_ID_EX; 
    wire memory_access_ID_EX, reg_write_ID_EX, alu_src_b_ID_EX, mem_write_ID_EX, branch_ID_EX, zero_ID_EX, smaller_signed_ID_EX, bigger_signed_ID_EX, smaller_unsigned_ID_EX, bigger_unsigned_ID_EX, mem_read_ID_EX, csr_write_ID_EX, ecall_ID_EX, sret_ID_EX, illegal_ID_EX, is_taken_ID_EX; 
    wire [3:0] alu_op_ID_EX; 
    wire [4:0] forwarding_rd_EX_MEM, forwarding_rd_MEM_WB; 
    wire [2:0] b_type_ID_EX; 
    reg pc_change_ID_EX;
    wire forwarding_reg_write_EX_MEM, forwarding_reg_write_MEM_WB; 
    reg [63:0] adderoutput_ID_EX, alu_in_a, alu_in_b, real_data2, real_res;
    wire [11:0] stored_address_ID_EX; 

    ID_EX_reg ID_EX_reg(
        .clk(clk),
        .flush(flush), 
        .stall(stall), 
        .rs1(rs1_out), 
        .rs2(rs2_out), 
        .inst(inst_IF_ID), 
        .pc_IF_ID(pc_IF_ID), 
        .pc_src_IF_ID(pc_src_IF_ID), 
        .reg_write_IF_ID(reg_write_IF_ID), 
        .alu_src_b_IF_ID(alu_src_b_IF_ID), 
        .alu_op_IF_ID(alu_op_IF_ID), 
        .mem_to_reg_IF_ID(mem_to_reg_IF_ID), 
        .mem_write_IF_ID(mem_write_IF_ID), 
        .branch_IF_ID(branch_IF_ID), 
        .b_type_IF_ID(b_type_IF_ID), 
        .imm_IF_ID(imm_IF_ID), 
        .mem_read_IF_ID(mem_read_IF_ID), 
        .csr_write_IF_ID(csr_write_IF_ID), 
        .csr_out_IF_ID(csr_out_IF_ID), 
        .ecall_IF_ID(ecall_IF_ID), 
        .sret_IF_ID(sret_IF_ID), 
        .illegal_IF_ID(illegal_IF_ID), 
        .stored_address_IF_ID(stored_address_IF_ID), 
        .is_taken_IF_ID(is_taken_IF_ID), 
        .stored_pc_IF_ID(stored_pc_IF_ID),
        .memoryAccessByte_IF_ID(memoryAccessByte_IF_ID),  
        .memory_access_IF_ID(memory_access_IF_ID), 
        .mmu_stall(mmu_stall), 
        .data1(data1), 
        .data2(data2), 
        .inst_ID_EX(inst_ID_EX), 
        .pc_ID_EX(pc_ID_EX), 
        .pc_src_ID_EX(pc_src_ID_EX), 
        .reg_write_ID_EX(reg_write_ID_EX), 
        .alu_src_b_ID_EX(alu_src_b_ID_EX), 
        .alu_op_ID_EX(alu_op_ID_EX), 
        .mem_to_reg_ID_EX(mem_to_reg_ID_EX), 
        .mem_write_ID_EX(mem_write_ID_EX), 
        .branch_ID_EX(branch_ID_EX), 
        .b_type_ID_EX(b_type_ID_EX), 
        .imm_ID_EX(imm_ID_EX), 
        .mem_read_ID_EX(mem_read_ID_EX), 
        .csr_write_ID_EX(csr_write_ID_EX), 
        .csr_out_ID_EX(csr_out_ID_EX), 
        .ecall_ID_EX(ecall_ID_EX), 
        .sret_ID_EX(sret_ID_EX), 
        .illegal_ID_EX(illegal_ID_EX), 
        .stored_address_ID_EX(stored_address_ID_EX), 
        .is_taken_ID_EX(is_taken_ID_EX), 
        .stored_pc_ID_EX(stored_pc_ID_EX), 
        .memoryAccessByte_ID_EX(memoryAccessByte_ID_EX), 
        .memory_access_ID_EX(memory_access_ID_EX) 
    );
    
    assign hazard_mem_read_ID_EX = mem_read_ID_EX;
    assign hazard_rd_ID_EX = inst_ID_EX[11:7]; 
    assign hazard_stall = (inst_ID_EX[6:0] == 7'b0000011); 
    
    forwarding_unit forwarding_unit(
        .forwarding_op_code(inst_ID_EX[6:0]), 
        .forwarding_reg_write_EX_MEM(forwarding_reg_write_EX_MEM), 
        .forwarding_rd_EX_MEM(forwarding_rd_EX_MEM), 
        .forwarding_rs1_ID_EX(inst_ID_EX[19:15]), 
        .forwarding_rs2_ID_EX(inst_ID_EX[24:20]), 
        .forwarding_reg_write_MEM_WB(forwarding_reg_write_MEM_WB), 
        .forwarding_rd_MEM_WB(forwarding_rd_MEM_WB), 
        .forwarding_a(forwarding_a), 
        .forwarding_b(forwarding_b) 
    );
    
    always @(*) begin 
        real_data2 = data2; 
        alu_in_a = data1; 
        alu_in_b = (alu_src_b_ID_EX == 1) ? imm_ID_EX : data2; 
        if (forwarding_a == 2'b10) alu_in_a = forwarding_res_EX_MEM; 
        else if (forwarding_a == 2'b01) alu_in_a = mem_to_reg_data; 
        if (forwarding_b == 2'b10 && alu_src_b_ID_EX == 0) alu_in_b = forwarding_res_EX_MEM; 
        if (forwarding_b == 2'b10 && alu_src_b_ID_EX == 1) real_data2 = forwarding_res_EX_MEM; 
        if (forwarding_b == 2'b01 && alu_src_b_ID_EX == 0) alu_in_b = mem_to_reg_data; 
        if (forwarding_b == 2'b01 && alu_src_b_ID_EX == 1) real_data2 = mem_to_reg_data; 
        
        if (csr_write_ID_EX == 1) begin
            if (inst_ID_EX[14:12] == 3'b001) begin
                alu_in_a = alu_in_a; 
                alu_in_b = 0; 
            end 
            else if (inst_ID_EX[14:12] == 3'b010) begin 
                alu_in_a = imm_ID_EX; 
                alu_in_b = 0; 
            end
            else if (inst_ID_EX[14:12] == 3'b011) begin
                alu_in_a = alu_in_a; 
                alu_in_b = csr_out_ID_EX; 
            end
            else if (inst_ID_EX[14:12] == 3'b101) begin
                alu_in_a = csr_out_ID_EX;
                alu_in_b = imm_ID_EX; 
            end
            else if (inst_ID_EX[14:12] == 3'b110) begin
                alu_in_a = ~alu_in_a; 
                alu_in_b = csr_out_ID_EX; 
            end
            else if (inst_ID_EX[14:12] == 3'b111) begin 
                alu_in_a = csr_out_ID_EX; 
                alu_in_b = ~imm_ID_EX; 
            end
        end 
    end 
    
    ALU alu_unit (
        .a(alu_in_a), 
        .b(alu_in_b), 
        .alu_op(alu_op_ID_EX), 
        .res(res_ID_EX), 
        .zero(zero_ID_EX), 
        .smaller_signed(smaller_signed_ID_EX), 
        .bigger_signed(bigger_signed_ID_EX), 
        .smaller_unsigned(smaller_unsigned_ID_EX), 
        .bigger_unsigned(bigger_unsigned_ID_EX)
    );
     
    always @(*) begin 
        real_res = res_ID_EX; 
        if (inst_ID_EX[6:0] == 7'b0010111) real_res = imm_ID_EX + pc_ID_EX;
        else if (mem_to_reg_ID_EX == 2'b01) real_res = imm_ID_EX; 
        else if (mem_to_reg_ID_EX == 2'b10) real_res = pc_ID_EX + 4; 
    end 
    
    always @(*) begin 
            pc_change_ID_EX = 0; 
            if (branch_ID_EX == 1) begin 
                if (b_type_ID_EX == 3'b000 && zero_ID_EX == 1) begin
                    adderoutput_ID_EX = pc_ID_EX + imm_ID_EX;
                    if (is_taken_ID_EX == 0) pc_change_ID_EX = 1;
                    real_taken = 1; 
                    branch_pc = adderoutput_ID_EX; 
                end
                else if (b_type_ID_EX == 3'b001 && zero_ID_EX == 0) begin
                    adderoutput_ID_EX = pc_ID_EX + imm_ID_EX;
                    if (is_taken_ID_EX == 0) pc_change_ID_EX = 1;
                    real_taken = 1;
                    branch_pc = adderoutput_ID_EX; 
                end 
                else if (b_type_ID_EX == 3'b100 && smaller_signed_ID_EX == 1) begin
                    adderoutput_ID_EX = pc_ID_EX + imm_ID_EX;
                    if (is_taken_ID_EX == 0) pc_change_ID_EX = 1;
                    real_taken = 1;
                    branch_pc = adderoutput_ID_EX; 
                end
                else if (b_type_ID_EX == 3'b101 && (bigger_signed_ID_EX == 1 || zero_ID_EX == 1)) begin
                    adderoutput_ID_EX = pc_ID_EX + imm_ID_EX;
                    if (is_taken_ID_EX == 0) pc_change_ID_EX = 1;
                    real_taken = 1;
                    branch_pc = adderoutput_ID_EX; 
                end
                else if (b_type_ID_EX == 3'b110 && smaller_unsigned_ID_EX == 1) begin
                    adderoutput_ID_EX = pc_ID_EX + imm_ID_EX;
                    if (is_taken_ID_EX == 0) pc_change_ID_EX = 1;
                    real_taken = 1;
                    branch_pc = adderoutput_ID_EX; 
                end
                else if (b_type_ID_EX == 3'b111 && (bigger_unsigned_ID_EX == 1 || zero_ID_EX == 1)) begin
                    adderoutput_ID_EX = pc_ID_EX + imm_ID_EX;
                    if (is_taken_ID_EX == 0) pc_change_ID_EX = 1;
                    real_taken = 1; 
                    branch_pc = adderoutput_ID_EX; 
                end
                else begin 
                    real_taken = 0; 
                    if (is_taken_ID_EX == 1) begin 
                        pc_change_ID_EX = 1;
                        adderoutput_ID_EX = stored_pc_ID_EX; 
                    end
                end 
            end 
            else if (inst_ID_EX[6:0] == 7'b1100111) begin 
                adderoutput_ID_EX = alu_in_a + imm_ID_EX;
                pc_change_ID_EX = 1;
            end 
            else if (inst_ID_EX[6:0] == 7'b1101111) begin 
                adderoutput_ID_EX = pc_ID_EX + imm_ID_EX;
                pc_change_ID_EX = 1;
            end 
            else if (ecall_ID_EX == 1 || sret_ID_EX == 1 || illegal_ID_EX == 1) begin
                adderoutput_ID_EX = csr_out_ID_EX; 
                pc_change_ID_EX = 1; 
            end 
        end 
        
        assign pc_change = pc_change_ID_EX;
        assign adderoutput = adderoutput_ID_EX;  
        assign branch_prediction_we = branch_ID_EX; 
        assign branch_address = stored_address_ID_EX; 
        assign csr_stall = (csr_write_IF_ID || csr_write_ID_EX) && illegal_IF_ID == 0; 

//--------------------------------------------- EX/MEM

    wire [63:0] res_EX_MEM, adderoutput_EX_MEM, data_EX_MEM, imm_EX_MEM, csr_out_EX_MEM,pc_EX_MEM;
    wire [31:0] inst_EX_MEM;
    wire memory_access_EX_MEM, reg_write_EX_MEM, alu_src_b_EX_MEM, mem_write_EX_MEM, branch_EX_MEM, b_type_EX_MEM, csr_write_EX_MEM, ecall_EX_MEM, illegal_EX_MEM; 
    wire [1:0] pc_src_EX_MEM, mem_to_reg_EX_MEM, memoryAccessByte_EX_MEM; 
    wire [3:0] alu_op_EX_MEM; 

    EX_MEM_reg EX_MEM_reg(
        .clk(clk), 
        .imm_ID_EX(imm_ID_EX), 
        .res_ID_EX(real_res), 
        .pc_ID_EX(pc_ID_EX), 
        .inst_ID_EX(inst_ID_EX), 
        .pc_src_ID_EX(pc_src_ID_EX), 
        .reg_write_ID_EX(reg_write_ID_EX), 
        .mem_to_reg_ID_EX(mem_to_reg_ID_EX), 
        .mem_write_ID_EX(mem_write_ID_EX), 
        .data2(real_data2), 
        .csr_out_ID_EX(csr_out_ID_EX), 
        .csr_write_ID_EX(csr_write_ID_EX), 
        .ecall_ID_EX(ecall_ID_EX), 
        .illegal_ID_EX(illegal_ID_EX), 
        .memoryAccessByte_ID_EX(memoryAccessByte_ID_EX), 
        .memory_access_ID_EX(memory_access_ID_EX), 
        .mmu_stall(mmu_stall), 
        .res_EX_MEM(res_EX_MEM), 
        .pc_EX_MEM(pc_EX_MEM), 
        .inst_EX_MEM(inst_EX_MEM), 
        .pc_src_EX_MEM(pc_src_EX_MEM), 
        .reg_write_EX_MEM(reg_write_EX_MEM), 
        .mem_to_reg_EX_MEM(mem_to_reg_EX_MEM), 
        .mem_write_EX_MEM(mem_write_EX_MEM),
        .data_EX_MEM(data_EX_MEM), 
        .imm_EX_MEM(imm_EX_MEM), 
        .csr_out_EX_MEM(csr_out_EX_MEM), 
        .csr_write_EX_MEM(csr_write_EX_MEM), 
        .ecall_EX_MEM(ecall_EX_MEM), 
        .illegal_EX_MEM(illegal_EX_MEM), 
        .memoryAccessByte_EX_MEM(memoryAccessByte_EX_MEM), 
        .memory_access_EX_MEM(memory_access_EX_MEM) 
    );
    
//    assign addr_out = res_EX_MEM; 
    assign memoryAccessByte = memoryAccessByte_EX_MEM; 
    assign data_out = data_EX_MEM; 
    assign mem_write = mem_write_EX_MEM; 
    assign forwarding_reg_write_EX_MEM = reg_write_EX_MEM; 
    assign forwarding_rd_EX_MEM = inst_EX_MEM[11:7]; 
    assign forwarding_res_EX_MEM = res_EX_MEM; 
    assign memory_access_start = memory_access_EX_MEM && satp != 64'b0; 
    
    mmu mmu_unit(
        .clk(clk), 
        .memory_access_start(memory_access_start), 
        .va(res_EX_MEM), 
        .satp(satp), 
        .cnt(memory_access_cnt), 
        .output_pa(output_pa),  
        .mem_pa(mem_pa), 
        .mmu_stall(mmu_stall) 
    );
    
    assign addr_out = memory_access_start ? mem_pa : res_EX_MEM; 

//--------------------------------------------- MEM/WB

    wire [63:0] res_MEM_WB, data_in_MEM_WB, imm_MEM_WB, csr_out_MEM_WB,pc_src_MEM_WB, pc_MEM_WB;
    wire [31:0] inst_MEM_WB;
    wire [1:0] mem_to_reg_MEM_WB;
    wire csr_write_MEM_WB, reg_write_MEM_WB, ecall_MEM_WB, illegal_MEM_WB; 

    MEM_WB_reg MEM_WB_reg(
        .clk(clk), 
        .pc_EX_MEM(pc_EX_MEM), 
        .imm_EX_MEM(imm_EX_MEM),  
        .res_EX_MEM(res_EX_MEM), 
        .data_in(data_in), 
        .mem_to_reg_EX_MEM(mem_to_reg_EX_MEM), 
        .pc_src_EX_MEM(pc_src_EX_MEM), 
        .inst_EX_MEM(inst_EX_MEM), 
        .reg_write_EX_MEM(reg_write_EX_MEM), 
        .csr_out_EX_MEM(csr_out_EX_MEM), 
        .csr_write_EX_MEM(csr_write_EX_MEM), 
        .ecall_EX_MEM(ecall_EX_MEM), 
        .illegal_EX_MEM(illegal_EX_MEM), 
        .mmu_stall(mmu_stall), 
        .res_MEM_WB(res_MEM_WB), 
        .data_in_MEM_WB(data_in_MEM_WB), 
        .mem_to_reg_MEM_WB(mem_to_reg_MEM_WB), 
        .pc_src_MEM_WB(pc_src_MEM_WB), 
        .inst_MEM_WB(inst_MEM_WB), 
        .reg_write_MEM_WB(reg_write_MEM_WB), 
        .imm_MEM_WB(imm_MEM_WB), 
        .pc_MEM_WB(pc_MEM_WB), 
        .csr_out_MEM_WB(csr_out_MEM_WB), 
        .csr_write_MEM_WB(csr_write_MEM_WB), 
        .ecall_MEM_WB(ecall_MEM_WB), 
        .illegal_MEM_WB(illegal_MEM_WB) 
    );
    
    assign for_reg_write = reg_write_MEM_WB; 
    assign for_rd_write = inst_MEM_WB[11:7]; 
    assign forwarding_reg_write_MEM_WB = reg_write_MEM_WB; 
    assign forwarding_rd_MEM_WB = inst_MEM_WB[11:7]; 
    
    always @(*) begin
        csr_addr_WB = inst_MEM_WB[31:20]; 
        csr_data_WB = res_MEM_WB;
        for_csr_write = csr_write_MEM_WB; 
        if (ecall_MEM_WB == 1 || illegal_MEM_WB == 1) begin
            csr_addr_WB = 12'h141;
            csr_data_WB = pc_MEM_WB + 4; 
            for_csr_write = 1;
        end
    end
    
    always @(*) begin
        if (csr_write_MEM_WB == 1) mem_to_reg_data = csr_out_MEM_WB; 
        else if (inst_MEM_WB[6:0] == 7'b0010111) mem_to_reg_data = imm_MEM_WB + pc_MEM_WB;
        else if (mem_to_reg_MEM_WB == 2'b00) mem_to_reg_data = res_MEM_WB; 
        else if (mem_to_reg_MEM_WB == 2'b01) mem_to_reg_data = imm_MEM_WB; 
        else if (mem_to_reg_MEM_WB == 2'b10) mem_to_reg_data = pc_MEM_WB + 4; 
        else mem_to_reg_data = data_in_MEM_WB;
    end 

//---------------------------------------------    
    

endmodule
