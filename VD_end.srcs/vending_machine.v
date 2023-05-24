module clk_50M (
    input      I_sys_clk,
    input      I_rstn,
    output reg O_clk_50M
);
  always @(posedge I_sys_clk or negedge I_rstn) begin
    if (!I_rstn) begin
      O_clk_50M <= 0;
    end else O_clk_50M <= ~O_clk_50M;

  end
endmodule

module vga_display (
    input I_clk,
    input I_rstn,
    input I_active_flag,
    input [11:0] I_h_addr,  //čĄĺ°ĺ?
    input [11:0] I_v_addr,  //ĺĺ°ĺ?

    input [15:0] I_item,  //çŠĺ
    input [3:0] I_gewei_toubi,
    input [3:0] I_shiwei_toubi,
    input [3:0] I_gewei_cost,
    input [3:0] I_shiwei_cost,
    input [3:0] I_gewei_change,
    input [3:0] I_shiwei_change,
    input [3:0] I_num,  //çŠĺć°é
    output reg [11:0] O_rgb_data
);
  parameter reg [511:0] NUM_0 =512'h00000000000000000000000003C006200C30181818181808300C300C300C300C300C300C300C300C300C300C1808181818180C30062003C00000000000000000;
  parameter reg [511:0] NUM_1 =512'h000000000000000000000000008001801F800180018001800180018001800180018001800180018001800180018001800180018003C01FF80000000000000000;
  parameter reg [511:0] NUM_2 =512'h00000000000000000000000007E008381018200C200C300C300C000C001800180030006000C0018003000200040408041004200C3FF83FF80000000000000000;
  parameter	reg [511:0] NUM_3 =512'h00000000000000000000000007C018603030301830183018001800180030006003C0007000180008000C000C300C300C30083018183007C00000000000000000;
  parameter	reg [511:0] NUM_4 =512'h0000000000000000000000000060006000E000E0016001600260046004600860086010603060206040607FFC0060006000600060006003FC0000000000000000;
  parameter	reg [511:0] NUM_5 =512'h0000000000000000000000000FFC0FFC10001000100010001000100013E0143018181008000C000C000C000C300C300C20182018183007C00000000000000000;
  parameter	reg [511:0] NUM_6 =512'h00000000000000000000000001E006180C180818180010001000300033E0363038183808300C300C300C300C300C180C18080C180E3003E00000000000000000;
  parameter	reg [511:0] NUM_7 =512'h0000000000000000000000001FFC1FFC100830102010202000200040004000400080008001000100010001000300030003000300030003000000000000000000;
  parameter	reg [511:0] NUM_8 =512'h00000000000000000000000007E00C301818300C300C300C380C38081E180F2007C018F030783038601C600C600C600C600C3018183007C00000000000000000;
  parameter	reg [511:0] NUM_9 =512'h00000000000000000000000007C01820301030186008600C600C600C600C600C701C302C186C0F8C000C0018001800103030306030C00F800000000000000000;
  parameter	reg [1023:0] HUA  =1024'h00000000000000000010100000181C000018180000181800001818383FFFFFFC0018180000181800001818000030100000300000006030000060302000C03070018030E001C0338003C0370006C03C000CC0380008C0F00030C3300040CC300800C0300800C0300800C0300800C0300C00C03FFC00C03FFC0080000000000000;
  parameter	reg [1023:0] FEI  =1024'h000000000000000000082000000C3000000C30400FFFFFE0000C3060000C3040000C304003FFFFC0060C3060060C30080FFFFFFC0418301800303010006030F00180316006FFFFC018C2030000C1830000C1830000C1830000C3030000C3030000C3030000063800000C0F00001803C0007001E001C000E01E00004000000000;
  parameter	reg [1023:0] TOU  =1024'h00000000000000000100000001C080000180FFC00180C1800180C1800180C1800190C1803FF8818001818180018181800181018C018300FE019E004001E7FFE0018880C00F8080C03D8041803180418001802300018023000180360001801E0001801C0001803E00018067000181C1E00F8300FE030C00380070000000000000;
  parameter	reg [1023:0] BI   =1024'h00000000000000000000008000000FC00001FFE007FF8000000180000001800000018000000180000201802003FFFFF0030180600301806003018060030180600301806003018060030180600301806003018060030180600301806003018860030187E0030181C0020180000001800000018000000180000001800000000000;
  parameter	reg [1023:0] ZHAO =1024'h00000000000000000080400000E0380000C0230000C021C000C020E000C0206000C820003FFC200000C0203800C3FFC000C4200000C0200000C4206000F8306001C030E00FC031C07CC0338030C0370000C01E0000C01C0000C0380800C06C0800C0CE0800C1070800C6038810D801D80F8000F80380003C0100000C00000000;
  parameter	reg [1023:0] LING =1024'h00000000000000000000008003FFFFC0000180000001800007FFFFF80C0180180C0180301801802019F99F80000100000000000003F91F800003800000078000000C4000003C300000731C0001C187F00E0080FC3000801003FFFE0000000F000000180000206000001E80000003C0000000F000000038000000180000000000;
  parameter	reg [1023:0] YUAN =1024'h0000000000000000000000000000008003FFFFC0000000000000000000000000000000000000000000000000000000301FFFFFF8000C3000000830000018300000183000001830000018300000183000003030080030300800303008006030080060300800C030080180301C03003FFC06001FF8180000002000000000000000;
  parameter	reg [1023:0] SHU  =1024'h00000000000000000060080000700E000C618C00066318000766180002641000006910083FFFFFFC00E0306001F83060016E7060026650600462904018609040204108C000E008C000C208C03FFF0C8001860D8001060580030C0700038C070000780700003F0D8000E318E0018130700600C03E380100100006000000000000;
  parameter	reg [1023:0] LIANG=1024'h00000000000000000000010001FFFF80018001000180010001FFFF00018001000180010001FFFF0001800180010000087FFFFFFC000000000000000001FFFF80018181800181818001FFFF8001818180018181800181818001FFFF8001818100000180C007FFFFE00001800000018000000180183FFFFFFC0000000000000000;
  wire [  7:0] W_pic_data;
  reg  [ 20:0] R_pic_addr;
  reg  [ 11:0] R_rgb_temp;

  reg  [511:0] R_num_gewei_toubi;  //num[0]
  reg  [511:0] R_num_shiwei_toubi;  //num[1]
  reg  [511:0] R_num_gewei_cost;  //num[2]
  reg  [511:0] R_num_shiwei_cost;  //num[3]
  reg  [511:0] R_num_gewei_change;  //num[4]
  reg  [511:0] R_num_shiwei_change;  //num[5]
  reg  [511:0] R_num_shuliang;  //num[6]

  /**************16ä¸ŞćĄ****************/
  wire k1_1,k2_1,k3_1,k4_1,k5_1,k6_1,k7_1,k8_1,k9_1,k10_1,k11_1,k12_1,k13_1,k14_1,k15_1,k16_1; //x_1ďż˝ďż˝ďż˝ßŁďż˝x_2ďż˝ďż˝ďż˝ďż˝
  wire k1_2,k2_2,k3_2,k4_2,k5_2,k6_2,k7_2,k8_2,k9_2,k10_2,k11_2,k12_2,k13_2,k14_2,k15_2,k16_2;//x_1ďż˝ďż˝ďż˝ßŁďż˝x_2ďż˝ďż˝ďż˝ďż˝
  assign k1_1=(((94<=I_v_addr &&I_v_addr<99)||(179<=I_v_addr && I_v_addr<184))&&(25<=I_h_addr&& I_h_addr<115))?1'b1:1'b0;
  assign k2_1=(((268<=I_v_addr &&I_v_addr<273)||(353<=I_v_addr && I_v_addr<358))&&(25<=I_h_addr&& I_h_addr<115))?1'b1:1'b0;
  assign k3_1=(((442<=I_v_addr &&I_v_addr<447)||(527<=I_v_addr && I_v_addr<532))&&(25<=I_h_addr&& I_h_addr<115))?1'b1:1'b0;
  assign k4_1=(((616<=I_v_addr &&I_v_addr<621)||(701<=I_v_addr && I_v_addr<706))&&(25<=I_h_addr&& I_h_addr<115))?1'b1:1'b0;
  assign k1_2=((99<=I_v_addr &&I_v_addr<179)&&((25<=I_h_addr && I_h_addr<30)||(110<=I_h_addr&& I_h_addr<115)))?1'b1:1'b0;
  assign k2_2=((273<=I_v_addr &&I_v_addr<353)&&((25<=I_h_addr && I_h_addr<30)||(110<=I_h_addr&& I_h_addr<115)))?1'b1:1'b0;
  assign k3_2=((447<=I_v_addr &&I_v_addr<527)&&((25<=I_h_addr && I_h_addr<30)||(110<=I_h_addr&& I_h_addr<115)))?1'b1:1'b0;
  assign k4_2=((621<=I_v_addr &&I_v_addr<701)&&((25<=I_h_addr && I_h_addr<30)||(110<=I_h_addr&& I_h_addr<115)))?1'b1:1'b0;

  assign k5_1=(((94<=I_v_addr &&I_v_addr<99)||(179<=I_v_addr && I_v_addr<184))&&(155<=I_h_addr&& I_h_addr<245))?1'b1:1'b0;
  assign k6_1=(((268<=I_v_addr &&I_v_addr<273)||(353<=I_v_addr && I_v_addr<358))&&(155<=I_h_addr&& I_h_addr<245))?1'b1:1'b0;
  assign k7_1=(((442<=I_v_addr &&I_v_addr<447)||(527<=I_v_addr && I_v_addr<532))&&(155<=I_h_addr&& I_h_addr<245))?1'b1:1'b0;
  assign k8_1=(((616<=I_v_addr &&I_v_addr<621)||(701<=I_v_addr && I_v_addr<706))&&(155<=I_h_addr&& I_h_addr<245))?1'b1:1'b0;
  assign k5_2=((99<=I_v_addr &&I_v_addr<179)&&((155<=I_h_addr && I_h_addr<160)||(240<=I_h_addr&& I_h_addr<245)))?1'b1:1'b0;
  assign k6_2=((273<=I_v_addr &&I_v_addr<353)&&((155<=I_h_addr && I_h_addr<160)||(240<=I_h_addr&& I_h_addr<245)))?1'b1:1'b0;
  assign k7_2=((447<=I_v_addr &&I_v_addr<527)&&((155<=I_h_addr && I_h_addr<160)||(240<=I_h_addr&& I_h_addr<245)))?1'b1:1'b0;
  assign k8_2=((621<=I_v_addr &&I_v_addr<701)&&((155<=I_h_addr && I_h_addr<160)||(240<=I_h_addr&& I_h_addr<245)))?1'b1:1'b0;

  assign k9_1=(((94<=I_v_addr &&I_v_addr<99)||(179<=I_v_addr && I_v_addr<184))&&(285<=I_h_addr&& I_h_addr<375))?1'b1:1'b0;
  assign k10_1=(((268<=I_v_addr &&I_v_addr<273)||(353<=I_v_addr && I_v_addr<358))&&(285<=I_h_addr&& I_h_addr<375))?1'b1:1'b0;
  assign k11_1=(((442<=I_v_addr &&I_v_addr<447)||(527<=I_v_addr && I_v_addr<532))&&(285<=I_h_addr&& I_h_addr<375))?1'b1:1'b0;
  assign k12_1=(((616<=I_v_addr &&I_v_addr<621)||(701<=I_v_addr && I_v_addr<706))&&(285<=I_h_addr&& I_h_addr<375))?1'b1:1'b0;
  assign k9_2=((99<=I_v_addr &&I_v_addr<179)&&((285<=I_h_addr && I_h_addr<290)||(370<=I_h_addr&& I_h_addr<375)))?1'b1:1'b0;
  assign k10_2=((273<=I_v_addr &&I_v_addr<353)&&((285<=I_h_addr && I_h_addr<290)||(370<=I_h_addr&& I_h_addr<375)))?1'b1:1'b0;
  assign k11_2=((447<=I_v_addr &&I_v_addr<527)&&((285<=I_h_addr && I_h_addr<290)||(370<=I_h_addr&& I_h_addr<375)))?1'b1:1'b0;
  assign k12_2=((621<=I_v_addr &&I_v_addr<701)&&((285<=I_h_addr && I_h_addr<290)||(370<=I_h_addr&& I_h_addr<375)))?1'b1:1'b0;

  assign k13_1=(((94<=I_v_addr &&I_v_addr<99)||(179<=I_v_addr && I_v_addr<184))&&(415<=I_h_addr&& I_h_addr<505))?1'b1:1'b0;
  assign k14_1=(((268<=I_v_addr &&I_v_addr<273)||(353<=I_v_addr && I_v_addr<358))&&(415<=I_h_addr&& I_h_addr<505))?1'b1:1'b0;
  assign k15_1=(((442<=I_v_addr &&I_v_addr<447)||(527<=I_v_addr && I_v_addr<532))&&(415<=I_h_addr&& I_h_addr<505))?1'b1:1'b0;
  assign k16_1=(((616<=I_v_addr &&I_v_addr<621)||(701<=I_v_addr && I_v_addr<706))&&(415<=I_h_addr&& I_h_addr<505))?1'b1:1'b0;
  assign k13_2=((99<=I_v_addr &&I_v_addr<179)&&((415<=I_h_addr && I_h_addr<420)||(500<=I_h_addr&& I_h_addr<505)))?1'b1:1'b0;
  assign k14_2=((273<=I_v_addr &&I_v_addr<353)&&((415<=I_h_addr && I_h_addr<420)||(500<=I_h_addr&& I_h_addr<505)))?1'b1:1'b0;
  assign k15_2=((447<=I_v_addr &&I_v_addr<527)&&((415<=I_h_addr && I_h_addr<420)||(500<=I_h_addr&& I_h_addr<505)))?1'b1:1'b0;
  assign k16_2=((621<=I_v_addr &&I_v_addr<701)&&((415<=I_h_addr && I_h_addr<420)||(500<=I_h_addr&& I_h_addr<505)))?1'b1:1'b0;



  /**************4ä¸Şĺžç?****************/
  wire pic1, pic2, pic3, pic4;  //ĺžç1ă?2ă?3ă?4
  wire W_pic_h1;  ////ĺžççčĄ
  assign W_pic_h1 = (30 <= I_h_addr && I_h_addr < 110) ? 1'b1 : 1'b0;
  assign pic1 = ((99 <= I_v_addr && I_v_addr < 179) && (W_pic_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic2 = ((273 <= I_v_addr && I_v_addr < 353) && (W_pic_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic3 = ((447 <= I_v_addr && I_v_addr < 527) && (W_pic_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic4 = ((621 <= I_v_addr && I_v_addr < 701) && (W_pic_h1 === 1'b1)) ? 1'b1 : 1'b0;
  /**************4ä¸Şĺžç?****************/
  wire pic5, pic6, pic7, pic8;  //ĺžç5ă?6ă?7ă?8
  wire W_pic_h2;  //ĺžççčĄ
  assign W_pic_h2 = (160 <= I_h_addr && I_h_addr < 240) ? 1'b1 : 1'b0;
  assign pic5 = ((99 <= I_v_addr && I_v_addr < 179) && (W_pic_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic6 = ((273 <= I_v_addr && I_v_addr < 353) && (W_pic_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic7 = ((447 <= I_v_addr && I_v_addr < 527) && (W_pic_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic8 = ((621 <= I_v_addr && I_v_addr < 701) && (W_pic_h2 === 1'b1)) ? 1'b1 : 1'b0;
  /**************4ä¸Şĺžç?****************/
  wire pic9, pic10, pic11, pic12;   //ĺžç9ă?10ă?11ă?12
  wire W_pic_h3;  ////ĺžççčĄ
  assign W_pic_h3 = (290 <= I_h_addr && I_h_addr < 370) ? 1'b1 : 1'b0;
  assign pic9 = ((99 <= I_v_addr && I_v_addr < 179) && (W_pic_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic10 = ((273 <= I_v_addr && I_v_addr < 353) && (W_pic_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic11 = ((447 <= I_v_addr && I_v_addr < 527) && (W_pic_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic12 = ((621 <= I_v_addr && I_v_addr < 701) && (W_pic_h3 === 1'b1)) ? 1'b1 : 1'b0;
  /**************4ä¸Şĺžç?****************/
  wire pic13, pic14, pic15, pic16;       //ĺžç13ă?14ă?15ă?16
  wire W_pic_h4;                            //ĺžççčĄ
  assign W_pic_h4 = (420 <= I_h_addr && I_h_addr < 500) ? 1'b1 : 1'b0;
  assign pic13 = ((99 <= I_v_addr && I_v_addr < 179) && (W_pic_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic14 = ((273 <= I_v_addr && I_v_addr < 353) && (W_pic_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic15 = ((447 <= I_v_addr && I_v_addr < 527) && (W_pic_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign pic16 = ((621 <= I_v_addr && I_v_addr < 701) && (W_pic_h4 === 1'b1)) ? 1'b1 : 1'b0;
  /**************4ä¸Şĺäť?****************/
  wire [1:0] dj1, dj2, dj3, dj4;  //ďż˝ďż˝ďż˝ďż˝1ďż˝ďż˝2ďż˝ďż˝3ďż˝ďż˝4
  wire W_dj_h1;  //ďż˝ďż˝Ňťďż˝Đľďż˝ďż˝Űľďż˝ďż˝ďż˝
  assign W_dj_h1 = (119 <= I_h_addr && I_h_addr < 151) ? 1'b1 : 1'b0;
  assign dj1[0]  = ((107 <= I_v_addr && I_v_addr < 123) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;//ĘŽÎť
  assign dj1[1]  = ((123 <= I_v_addr && I_v_addr < 139) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;//ďż˝ďż˝Îť
  assign dj2[0]  = ((281 <= I_v_addr && I_v_addr < 297) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj2[1]  = ((297 <= I_v_addr && I_v_addr < 313) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj3[0]  = ((455 <= I_v_addr && I_v_addr < 471) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj3[1]  = ((471 <= I_v_addr && I_v_addr < 487) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj4[0]  = ((629 <= I_v_addr && I_v_addr < 645) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj4[1]  = ((645 <= I_v_addr && I_v_addr < 661) && (W_dj_h1 === 1'b1)) ? 1'b1 : 1'b0;
  /**************4ä¸Şĺäť?****************/
  wire [1:0] dj5, dj6, dj7, dj8;  //ďż˝ďż˝ďż˝ďż˝5,6,7,8
  wire W_dj_h2;  //ďż˝Úśďż˝ďż˝Đľďż˝ďż˝Űľďż˝ďż˝ďż˝
  assign W_dj_h2 = (249 <= I_h_addr && I_h_addr < 281) ? 1'b1 : 1'b0;
  assign dj5[0]  = ((107 <= I_v_addr && I_v_addr < 123) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj5[1]  = ((123 <= I_v_addr && I_v_addr < 139) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj6[0]  = ((281 <= I_v_addr && I_v_addr < 297) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj6[1]  = ((297 <= I_v_addr && I_v_addr < 313) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj7[0]  = ((455 <= I_v_addr && I_v_addr < 471) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj7[1]  = ((471 <= I_v_addr && I_v_addr < 487) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj8[0]  = ((629 <= I_v_addr && I_v_addr < 645) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj8[1]  = ((645 <= I_v_addr && I_v_addr < 661) && (W_dj_h2 === 1'b1)) ? 1'b1 : 1'b0;
  /**************4ä¸Şĺäť?****************/
  wire [1:0] dj9, dj10, dj11, dj12;  //ďż˝ďż˝ďż˝ďż˝9,10,11,12
  wire W_dj_h3;  //ďż˝ďż˝ďż˝ďż˝ďż˝Đľďż˝ďż˝Űľďż˝ďż˝ďż˝
  assign W_dj_h3 = (379 <= I_h_addr && I_h_addr < 411) ? 1'b1 : 1'b0;
  assign dj9[0]  = ((107 <= I_v_addr && I_v_addr < 123) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj9[1]  = ((123 <= I_v_addr && I_v_addr < 139) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj10[0] = ((281 <= I_v_addr && I_v_addr < 297) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj10[1] = ((297 <= I_v_addr && I_v_addr < 313) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj11[0] = ((455 <= I_v_addr && I_v_addr < 471) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj11[1] = ((471 <= I_v_addr && I_v_addr < 487) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj12[0] = ((629 <= I_v_addr && I_v_addr < 645) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj12[1] = ((645 <= I_v_addr && I_v_addr < 661) && (W_dj_h3 === 1'b1)) ? 1'b1 : 1'b0;
  /**************4ä¸Şĺäť?****************/
  wire [1:0] dj13, dj14, dj15, dj16;  //ďż˝ďż˝ďż˝ďż˝13,14,15,16
  wire W_dj_h4;  //ďż˝ďż˝ďż˝ďż˝ďż˝Đľďż˝ďż˝Űľďż˝ďż˝ďż˝
  assign W_dj_h4 = (509 <= I_h_addr && I_h_addr < 541) ? 1'b1 : 1'b0;
  assign dj13[0] = ((107 <= I_v_addr && I_v_addr < 123) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj13[1] = ((123 <= I_v_addr && I_v_addr < 139) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj14[0] = ((281 <= I_v_addr && I_v_addr < 297) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj14[1] = ((297 <= I_v_addr && I_v_addr < 313) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj15[0] = ((455 <= I_v_addr && I_v_addr < 471) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj15[1] = ((471 <= I_v_addr && I_v_addr < 487) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj16[0] = ((629 <= I_v_addr && I_v_addr < 645) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  assign dj16[1] = ((645 <= I_v_addr && I_v_addr < 661) && (W_dj_h4 === 1'b1)) ? 1'b1 : 1'b0;
  /**************17ä¸Şĺ­çŹ?****************ćĺ¸ďźčąč´šďźćžéśďźĺ3ä¸Şĺ,8ä¸Şéąçčžĺ?*/
  wire tou, bi, hua, fei, zhao, ling, shu, liang;  //ćĺ¸ďźčąč´šďźćžéś,ć°é
  wire [2:0] yuan;                         //3ä¸?"ĺ?"
  wire [7:0] num;                         //8ä¸Şéą

  assign tou     =(30<=I_v_addr && I_v_addr <62 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ć?
  assign bi     =(62<=I_v_addr && I_v_addr <94 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ĺ¸?
  assign num[1]  =(104<=I_v_addr && I_v_addr <120 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ĺä˝
  assign num[0]  =(120<=I_v_addr && I_v_addr <136 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ä¸Şä˝
  assign yuan[0]  =(136<=I_v_addr && I_v_addr <168 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ĺ?

  assign hua     =(220<=I_v_addr && I_v_addr <252 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ďż˝ďż˝
  assign fei     =(252<=I_v_addr && I_v_addr <284 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ďż˝ďż˝
  assign num[3]  =(294<=I_v_addr && I_v_addr <310 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ĺä˝
  assign num[2]  =(310<=I_v_addr && I_v_addr <326 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;////ä¸Şä˝
  assign yuan[1]  =(326<=I_v_addr && I_v_addr <358 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ÔŞ

  assign zhao     =(410<=I_v_addr && I_v_addr <442 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ďż˝ďż˝
  assign ling     =(442<=I_v_addr && I_v_addr <474 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ďż˝ďż˝
  assign num[5]  =(484<=I_v_addr && I_v_addr <500 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ĺä˝
  assign num[4]  =(500<=I_v_addr && I_v_addr <516 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;////ä¸Şä˝
  assign yuan[2]  =(516<=I_v_addr && I_v_addr <548 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ÔŞ

  assign shu    =(600<=I_v_addr && I_v_addr <632 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ďż˝ďż˝
  assign liang    =(632<=I_v_addr && I_v_addr <664 && 554<=I_h_addr &&I_h_addr<586 )?1'b1:1'b0;//ďż˝ďż˝
  assign num[7]  =(674<=I_v_addr && I_v_addr <690 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;//ĺä˝
  assign num[6]  =(690<=I_v_addr && I_v_addr <706 && 554<=I_h_addr&& I_h_addr<586 )?1'b1:1'b0;////ä¸Şä˝


  image_rom image_rom_m1 (
      .clka(I_clk),  // input wire clka
      .addra(R_pic_addr),  // input wire [16 : 0] addra
      .douta(W_pic_data)  // output wire [2 : 0] douta
      );

  always @(*) begin
    if(I_active_flag&&(pic1|pic2|pic3|pic4|pic5|pic6|pic7|pic8|pic9|pic10|pic11|pic12|pic13|pic14|pic15|pic16))
      begin
        case (W_pic_data)//ĺ°ćĺĺşç?3ä˝RGBć°ćŽč˝Źć˘ä¸?12ä˝RGBć°ćŽ
          3'b000: 
          begin
            R_rgb_temp <= 12'b000000000000;
          end
          3'b001: 
          begin
            R_rgb_temp <= 12'b000000001111;
          end
          3'b010: 
          begin
            R_rgb_temp <= 12'b000011110000;
          end
          3'b011: begin
            R_rgb_temp <= 12'b000011111111;
          end
          3'b100: 
          begin
            R_rgb_temp <= 12'b111100000000;
          end
          3'b101: begin
            R_rgb_temp <= 12'b111100001111;
          end
          3'b110: 
          begin
            R_rgb_temp <= 12'b111111110000;
          end
          3'b111: 
          begin
            R_rgb_temp <= 12'b111111111111;
          end
          default: 
          begin
            R_rgb_temp <= R_rgb_temp;
          end
        endcase
      end 
    else 
      begin
        R_rgb_temp = 12'b000000000000;
      end
    case (I_num)
      4'b0000: R_num_shuliang = NUM_0;
      4'b0001: R_num_shuliang = NUM_1;
      4'b0010: R_num_shuliang = NUM_2;
      4'b0011: R_num_shuliang = NUM_3;
      4'b0100: R_num_shuliang = NUM_4;
      4'b0101: R_num_shuliang = NUM_5;
      4'b0110: R_num_shuliang = NUM_6;
      4'b0111: R_num_shuliang = NUM_7;
      4'b1000: R_num_shuliang = NUM_8;
      4'b1001: R_num_shuliang = NUM_9;
      default: R_num_shuliang = NUM_0;
    endcase

    case (I_gewei_toubi)
      4'b0000: R_num_gewei_toubi = NUM_0;
      4'b0001: R_num_gewei_toubi = NUM_1;
      4'b0010: R_num_gewei_toubi = NUM_2;
      4'b0011: R_num_gewei_toubi = NUM_3;
      4'b0100: R_num_gewei_toubi = NUM_4;
      4'b0101: R_num_gewei_toubi = NUM_5;
      4'b0110: R_num_gewei_toubi = NUM_6;
      4'b0111: R_num_gewei_toubi = NUM_7;
      4'b1000: R_num_gewei_toubi = NUM_8;
      4'b1001: R_num_gewei_toubi = NUM_9;
      default: R_num_gewei_toubi = NUM_0;
    endcase
    case (I_shiwei_toubi)
      4'b0000: R_num_shiwei_toubi = NUM_0;
      4'b0001: R_num_shiwei_toubi = NUM_1;
      4'b0010: R_num_shiwei_toubi = NUM_2;
      4'b0011: R_num_shiwei_toubi = NUM_3;
      4'b0100: R_num_shiwei_toubi = NUM_4;
      4'b0101: R_num_shiwei_toubi = NUM_5;
      4'b0110: R_num_shiwei_toubi = NUM_6;
      4'b0111: R_num_shiwei_toubi = NUM_7;
      4'b1000: R_num_shiwei_toubi = NUM_8;
      4'b1001: R_num_shiwei_toubi = NUM_9;
      default: R_num_shiwei_toubi = NUM_0;
    endcase
    case (I_gewei_cost)
      4'b0000: R_num_gewei_cost = NUM_0;
      4'b0001: R_num_gewei_cost = NUM_1;
      4'b0010: R_num_gewei_cost = NUM_2;
      4'b0011: R_num_gewei_cost = NUM_3;
      4'b0100: R_num_gewei_cost = NUM_4;
      4'b0101: R_num_gewei_cost = NUM_5;
      4'b0110: R_num_gewei_cost = NUM_6;
      4'b0111: R_num_gewei_cost = NUM_7;
      4'b1000: R_num_gewei_cost = NUM_8;
      4'b1001: R_num_gewei_cost = NUM_9;
      default: R_num_gewei_cost = NUM_0;
    endcase
    case (I_shiwei_cost)
      4'b0000: R_num_shiwei_cost = NUM_0;
      4'b0001: R_num_shiwei_cost = NUM_1;
      4'b0010: R_num_shiwei_cost = NUM_2;
      4'b0011: R_num_shiwei_cost = NUM_3;
      4'b0100: R_num_shiwei_cost = NUM_4;
      4'b0101: R_num_shiwei_cost = NUM_5;
      4'b0110: R_num_shiwei_cost = NUM_6;
      4'b0111: R_num_shiwei_cost = NUM_7;
      4'b1000: R_num_shiwei_cost = NUM_8;
      4'b1001: R_num_shiwei_cost = NUM_9;
      default: R_num_shiwei_cost = NUM_0;
    endcase
    case (I_gewei_change)
      4'b0000: R_num_gewei_change = NUM_0;
      4'b0001: R_num_gewei_change = NUM_1;
      4'b0010: R_num_gewei_change = NUM_2;
      4'b0011: R_num_gewei_change = NUM_3;
      4'b0100: R_num_gewei_change = NUM_4;
      4'b0101: R_num_gewei_change = NUM_5;
      4'b0110: R_num_gewei_change = NUM_6;
      4'b0111: R_num_gewei_change = NUM_7;
      4'b1000: R_num_gewei_change = NUM_8;
      4'b1001: R_num_gewei_change = NUM_9;
      default: R_num_gewei_change = NUM_0;
    endcase
    case (I_shiwei_change)
      4'b0000: R_num_shiwei_change = NUM_0;
      4'b0001: R_num_shiwei_change = NUM_1;
      4'b0010: R_num_shiwei_change = NUM_2;
      4'b0011: R_num_shiwei_change = NUM_3;
      4'b0100: R_num_shiwei_change = NUM_4;
      4'b0101: R_num_shiwei_change = NUM_5;
      4'b0110: R_num_shiwei_change = NUM_6;
      4'b0111: R_num_shiwei_change = NUM_7;
      4'b1000: R_num_shiwei_change = NUM_8;
      4'b1001: R_num_shiwei_change = NUM_9;
      default: R_num_shiwei_change = NUM_0;
    endcase
  end
  always @(posedge I_clk or negedge I_rstn)
    if (!I_rstn) 
      begin
        O_rgb_data <= 12'b000000000000;
      end 
    else if (I_active_flag) 
    begin
      if (k1_2 | k1_1) //ćĄ?1
        if (I_item[0]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k2_2 | k2_1)  //ďż˝ďż˝2
        if (I_item[1]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k3_1 | k3_2)//ćĄ?3
        if (I_item[2]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k4_1 | k4_2)  //ďż˝ďż˝4
        if (I_item[3])
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k5_1 | k5_2)  //ďż˝ďż˝5
        if (I_item[4]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k6_1 | k6_2)  //ďż˝ďż˝6
        if (I_item[5]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k7_1 | k7_2)  //ďż˝ďż˝7
        if (I_item[6]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k8_1 | k8_2)  //ďż˝ďż˝8
        if (I_item[7])
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k9_1 | k9_2)  //ďż˝ďż˝9
        if (I_item[8]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k10_1 | k10_2)  //ďż˝ďż˝10
        if (I_item[9]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k11_1 | k11_2)  //ďż˝ďż˝11
        if (I_item[10]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k12_1 | k12_2)  //ďż˝ďż˝12
        if (I_item[11]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k13_1 | k13_2)  //ďż˝ďż˝13
        if (I_item[12]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k14_1 | k14_2)  //ďż˝ďż˝14
        if (I_item[13]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k15_1 | k15_2)  //ďż˝ďż˝15
        if (I_item[14]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if (k16_1 | k16_2)  //ďż˝ďż˝16
        if (I_item[15]) 
          O_rgb_data <= 12'b111100000000;
        else 
          O_rgb_data <= 12'b000000000000;
      else if(pic1|pic2|pic3|pic4|pic5|pic6|pic7|pic8|pic9|pic10|pic11|pic12|pic13|pic14|pic15|pic16)
		      begin
          case ({pic1,pic2,pic3,pic4,pic5,pic6,pic7,pic8,pic9,pic10,pic11,pic12,pic13,pic14,pic15,pic16})
            16'b1000000000000000: 
            begin
              R_pic_addr = (I_h_addr - 30) * 80 + (I_v_addr - 99);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0100000000000000: 
            begin
              R_pic_addr = 80 * 80 + (I_h_addr - 30) * 80 + (I_v_addr - 273);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0010000000000000: 
            begin
              R_pic_addr = 2 * 80 * 80 + (I_h_addr - 30) * 80 + (I_v_addr - 447);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0001000000000000:
            begin
              R_pic_addr = 3 * 80 * 80 + (I_h_addr - 30) * 80 + (I_v_addr - 621);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000100000000000: 
            begin
              R_pic_addr = 4 * 80 * 80 + (I_h_addr - 160) * 80 + (I_v_addr - 99);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000010000000000: 
            begin
              R_pic_addr = 5 * 80 * 80 + (I_h_addr - 160) * 80 + (I_v_addr - 273);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000001000000000: 
            begin
              R_pic_addr = 6 * 80 * 80 + (I_h_addr - 160) * 80 + (I_v_addr - 447);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000100000000: 
            begin
              R_pic_addr = 7 * 80 * 80 + (I_h_addr - 160) * 80 + (I_v_addr - 621);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000010000000: 
            begin
              R_pic_addr = 8 * 80 * 80 + (I_h_addr - 290) * 80 + (I_v_addr - 99);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000001000000: 
            begin
              R_pic_addr = 9 * 80 * 80 + (I_h_addr - 290) * 80 + (I_v_addr - 273);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000000100000: 
            begin
              R_pic_addr = 10 * 80 * 80 + (I_h_addr - 290) * 80 + (I_v_addr - 447);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000000010000: 
            begin
              R_pic_addr = 11 * 80 * 80 + (I_h_addr - 290) * 80 + (I_v_addr - 621);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000000001000: 
            begin
              R_pic_addr = 12 * 80 * 80 + (I_h_addr - 420) * 80 + (I_v_addr - 99);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000000000100: 
            begin
              R_pic_addr = 13 * 80 * 80 + (I_h_addr - 420) * 80 + (I_v_addr - 273);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000000000010: 
            begin
              R_pic_addr = 14 * 80 * 80 + (I_h_addr - 420) * 80 + (I_v_addr - 447);
              O_rgb_data <= R_rgb_temp;
            end
            16'b0000000000000001: 
            begin
              R_pic_addr = 15 * 80 * 80 + (I_h_addr - 420) * 80 + (I_v_addr - 621);
              O_rgb_data <= R_rgb_temp;
            end
            default: begin
              R_pic_addr = 0;
              O_rgb_data <= 12'b000000000000;
            end
          endcase
      end 
      else if (dj1[0] | dj1[1]) 
      begin
        case (dj1)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-107+(I_h_addr-119)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_3[511-(I_v_addr-123+(I_h_addr-119)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj2[0] | dj2[1]) 
      begin
        case (dj2)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-281+(I_h_addr-119)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_4[511-(I_v_addr-297+(I_h_addr-119)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj3[0] | dj3[1]) 
      begin
        case (dj3)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-455+(I_h_addr-119)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_6[511-(I_v_addr-471+(I_h_addr-119)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj4[0] | dj4[1]) 
      begin
        case (dj4)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-629+(I_h_addr-119)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_3[511-(I_v_addr-645+(I_h_addr-119)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 

      else if (dj5[0] | dj5[1]) 
      begin
        case (dj5)
          2'b01: begin
            O_rgb_data <= {12{NUM_1[511-(I_v_addr-107+(I_h_addr-249)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-123+(I_h_addr-249)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj6[0] | dj6[1]) 
      begin
        case (dj6)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-281+(I_h_addr-249)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_8[511-(I_v_addr-297+(I_h_addr-249)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj7[0] | dj7[1]) 
      begin
        case (dj7)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-455+(I_h_addr-249)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_9[511-(I_v_addr-471+(I_h_addr-249)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj8[0] | dj8[1]) 
      begin
        case (dj8)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-629+(I_h_addr-249)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_7[511-(I_v_addr-645+(I_h_addr-249)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 

      else if (dj9[0] | dj9[1]) 
      begin
        case (dj9)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-107+(I_h_addr-379)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_4[511-(I_v_addr-123+(I_h_addr-379)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj10[0] | dj10[1]) 
      begin
        case (dj10)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-281+(I_h_addr-379)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_6[511-(I_v_addr-297+(I_h_addr-379)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj11[0] | dj11[1]) 
      begin
        case (dj11)
          2'b01: begin
            O_rgb_data <= {12{NUM_1[511-(I_v_addr-455+(I_h_addr-379)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_5[511-(I_v_addr-471+(I_h_addr-379)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj12[0] | dj12[1]) 
      begin
        case (dj12)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-629+(I_h_addr-379)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_8[511-(I_v_addr-645+(I_h_addr-379)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 

      else if (dj13[0] | dj13[1]) 
      begin
        case (dj13)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-107+(I_h_addr-509)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_9[511-(I_v_addr-123+(I_h_addr-509)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj14[0] | dj14[1]) 
      begin
        case (dj14)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-281+(I_h_addr-509)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_4[511-(I_v_addr-297+(I_h_addr-509)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj15[0] | dj15[1]) 
      begin
        case (dj15)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-455+(I_h_addr-509)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_5[511-(I_v_addr-471+(I_h_addr-509)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (dj16[0] | dj16[1]) 
      begin
        case (dj16)
          2'b01: begin
            O_rgb_data <= {12{NUM_0[511-(I_v_addr-629+(I_h_addr-509)*16)]}};
          end
          2'b10: begin
            O_rgb_data <= {12{NUM_5[511-(I_v_addr-645+(I_h_addr-509)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (tou | hua | zhao) 
      begin
        case ({tou, hua, zhao})
          3'b100: begin
            O_rgb_data <= {12{TOU[1023-(I_v_addr-30+(I_h_addr-554)*32)]}};
          end
          3'b010: begin
            O_rgb_data <= {12{HUA[1023-(I_v_addr-220+(I_h_addr-554)*32)]}};
          end
          3'b001: begin
            O_rgb_data <= {12{ZHAO[1023-(I_v_addr-410+(I_h_addr-554)*32)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (bi | fei | ling) 
      begin
        case ({bi, fei, ling})
          3'b100: begin
            O_rgb_data <= {12{BI[1023-(I_v_addr-62+(I_h_addr-554)*32)]}};
          end
          3'b010: begin
            O_rgb_data <= {12{FEI[1023-(I_v_addr-252+(I_h_addr-554)*32)]}};
          end
          3'b001: begin
            O_rgb_data <= {12{LING[1023-(I_v_addr-442+(I_h_addr-554)*32)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (yuan[0] | yuan[1] | yuan[2]) 
      begin
        case (yuan)
          3'b100: begin
            O_rgb_data <= {12{YUAN[1023-(I_v_addr-516+(I_h_addr-554)*32)]}};
          end
          3'b010: begin
            O_rgb_data <= {12{YUAN[1023-(I_v_addr-326+(I_h_addr-554)*32)]}};
          end
          3'b001: begin
            O_rgb_data <= {12{YUAN[1023-(I_v_addr-136+(I_h_addr-554)*32)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (num[0] | num[1] | num[2] | num[3] | num[4] | num[5]) 
      begin
        case (num)
          6'b000001: begin
            O_rgb_data <= {12{R_num_gewei_toubi[1023-(I_v_addr-104+(I_h_addr-554)*16)]}};
          end
          6'b000010: begin
            O_rgb_data <= {12{R_num_shiwei_toubi[1023-(I_v_addr-120+(I_h_addr-554)*16)]}};
          end
          6'b000100: begin
            O_rgb_data <= {12{R_num_gewei_cost[1023-(I_v_addr-294+(I_h_addr-554)*16)]}};
          end
          6'b001000: begin
            O_rgb_data <= {12{R_num_shiwei_cost[1023-(I_v_addr-310+(I_h_addr-554)*16)]}};
          end
          6'b010000: begin
            O_rgb_data <= {12{R_num_gewei_change[1023-(I_v_addr-484+(I_h_addr-554)*16)]}};
          end
          6'b100000: begin
            O_rgb_data <= {12{R_num_shiwei_change[1023-(I_v_addr-500+(I_h_addr-554)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else if (shu | liang | num[6] | num[7]) 
      begin
        case ({shu, liang, num[6], num[7]})
          4'b1000: begin
            O_rgb_data <= {12{SHU[1023-(I_v_addr-600+(I_h_addr-554)*32)]}};
          end
          4'b0100: begin
            O_rgb_data <= {12{LIANG[1023-(I_v_addr-632+(I_h_addr-554)*32)]}};
          end
          4'b0001: begin
            O_rgb_data <= {12{NUM_0[1023-(I_v_addr-674+(I_h_addr-554)*16)]}};
          end
          4'b0010: begin
            O_rgb_data <= {12{R_num_shuliang[1023-(I_v_addr-690+(I_h_addr-554)*16)]}};
          end
          default: begin
            O_rgb_data <= 12'b000000000000;
          end
        endcase
      end 
      else begin
        O_rgb_data <= 12'b000000000000;
      end
    end
endmodule


module vga_driver (
    input R_clk_50M,
    input I_rstn,  // çłťçťĺ¤ä˝
    //output   reg   [4:0]    O_red   , // VGAçş˘č˛ĺé
    //output   reg   [5:0]    O_green , // VGAçťżč˛ĺé
    //output   reg   [4:0]    O_blue  , // VGAčč˛ĺé
    output O_hs,  // VGAčĄĺć­ĽäżĄĺ?
    output O_vs,  // VGAĺşĺć­ĽäżĄĺ?
    output        O_active_flag,  // ćż?ć´ťć ĺżďźĺ˝čżä¸ŞäżĄĺˇä¸ş1ćśRGBçć°ćŽĺŻäťĽćžç¤şĺ¨ĺąĺšä¸?
    output [11:0] O_h_addr,  //čĄĺ°ĺ?
    output [11:0] O_v_addr  //ĺĺ°ĺ?
);

  // ĺčž¨çä¸ş800*600@72ćśčĄćśĺşĺä¸Şĺć°ĺŽäš
  parameter C_H_SYNC_PULSE = 120;
  parameter C_H_BACK_PORCH = 64;
  parameter C_H_ACTIVE_TIME = 800;
  parameter C_H_FRONT_PORCH = 56;
  parameter C_H_LINE_PERIOD = 1040;

  // ĺčž¨çä¸ş800/600@72ćśĺşćśĺşĺä¸Şĺć°ĺŽäš               
  parameter C_V_SYNC_PULSE = 6;
  parameter C_V_BACK_PORCH = 23;
  parameter C_V_ACTIVE_TIME = 600;
  parameter C_V_FRONT_PORCH = 37;
  parameter C_V_FRAME_PERIOD = 666;

  parameter C_IMAGE_WIDTH = 80;
  parameter C_IMAGE_HEIGHT = 80;
  parameter C_IMAGE_PIX_NUM = 640;

  reg  [11:0] R_h_cnt;  // čĄćśĺşčŽĄć°ĺ¨
  reg  [11:0] R_v_cnt;  // ĺćśĺşčŽĄć°ĺ¨
  reg  [13:0] R_rom_addr;  // ROMçĺ°ĺ?
  wire [15:0] W_rom_data;  // ROMä¸­ĺ­ĺ¨çć°ćŽ

  //////////////////////////////////////////////////////////////////
  // ĺč˝ďźäş§çčĄćśĺş
  //////////////////////////////////////////////////////////////////
  always @(posedge R_clk_50M or negedge I_rstn) begin
    if (!I_rstn) R_h_cnt <= 12'd0;
    else if (R_h_cnt == C_H_LINE_PERIOD - 1'b1) R_h_cnt <= 12'd0;
    else R_h_cnt <= R_h_cnt + 1'b1;
  end

  assign O_hs = (R_h_cnt < C_H_SYNC_PULSE) ? 1'b0 : 1'b1;
  //////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////
  // ĺč˝ďźäş§çĺşćśĺş
  //////////////////////////////////////////////////////////////////
  always @(posedge R_clk_50M or negedge I_rstn) begin
    if (!I_rstn) R_v_cnt <= 12'd0;
    else if (R_v_cnt == C_V_FRAME_PERIOD - 1'b1) R_v_cnt <= 12'd0;
    else if (R_h_cnt == C_H_LINE_PERIOD - 1'b1) R_v_cnt <= R_v_cnt + 1'b1;
    else R_v_cnt <= R_v_cnt;
  end

  assign O_vs = (R_v_cnt < C_V_SYNC_PULSE) ? 1'b0 : 1'b1;
  //////////////////////////////////////////////////////////////////  

  // äş§çććĺşĺć ĺżďźĺ˝čżä¸ŞäżĄĺˇä¸şéŤćśĺžRGBéçć°ćŽćäźćžç¤şĺ°ĺąĺšä¸
  assign O_active_flag = (R_h_cnt >= (C_H_SYNC_PULSE + C_H_BACK_PORCH)) && (R_h_cnt <= (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_H_ACTIVE_TIME)) && (R_v_cnt >= (C_V_SYNC_PULSE + C_V_BACK_PORCH)) && (R_v_cnt <= (C_V_SYNC_PULSE + C_V_BACK_PORCH + C_V_ACTIVE_TIME));
  assign O_h_addr = O_active_flag ? R_v_cnt - 12'd29 : 12'd0;
  assign O_v_addr = O_active_flag ? R_h_cnt - 12'd184: 12'd0;
endmodule

// module key_flliter(  
// 	clk,
// 	rst_n, 
// 	key_in, 
// 	button_out
// 	);
// 	input  clk;
// 	input rst_n;
// 	input  key_in;
// 	output button_out;
// 	reg [19:0]count;
// 	reg  key_scan;
// 	always@(posedge clk or negedge rst_n)
// 	begin
// 		if(~rst_n)
// 			count <=20'd0;
// 		   // button_out=1'b0;
// 		else//20ms涓哄幓鎶栨椂锟�?
// 	        begin
// 	            if(count === 20'd9)//50Mhz鏃堕挓锟�???20ms锟�?1000000涓懆锟�???
// 	                begin
// 	                    count <= 20'd0;
// 	                    key_scan <= key_in;//锟�?20ms鎵弿锟�???锟�?
// 	                end 
// 	            else 
// 	                count <= count + 20'd1;
// 	        end
// 	end
// 	reg key_scan_r;
// 	always@(posedge clk)
// 		key_scan_r <= key_scan;//姣忎釜涓婂崌娌块兘灏嗘壂鎻忕粨鏋�??紶缁檏ey_scan_r锛屽嵆key_scan_r涓巏ey_scan涓嶅悓鐨勬椂闂翠笉浼氳秴杩囦竴涓椂閽熷懆锟�???
// 	wire flag_key = key_scan_r&(~key_scan);//濡備笂锟�???璇达紝flag_key鑴夊啿�?�藉害涓嶄細瓒呰繃锟�???涓椂閽熷懆锟�?
// //	reg temp;
// //	always @ (posedge clk or negedge rst_n) //锟�?娴嬫椂閽熺殑涓婂崌娌垮拰澶嶄綅鐨勪笅闄嶆�??
// //		begin
// //			if (!rst_n) 
// //				temp <= 1'b0;
// //			else if ( flag_key) temp=1'b1; 
// //      else temp <= 1'b0;
// //		end
// //	assign button_out= temp;
//     assign button_out= flag_key;
// endmodule
module key_filter (  //鎸夐敭娑堟姈妯�?�潡
    clk,  //灏忔鍝ョ殑鏃堕挓鏄�??50M濂藉儚锛�??        //娉ㄦ剰锛屽挶浠繖涓澘瀛愭椂閽熸槸100M锛�
    Reset_n,
    Key,
    Key_P_Flag,
    Key_R_Flag
);
  input clk;
  input Reset_n;                    //杩欎釜妯″潡鍜岄《灞傛ā鍧楃敤浜嗗嚑涓浉鍚岀殑鍙�??噺锛歝lk涓嶳eset_n,涓嶇煡閬撴湁娌℃湁鍟ュ奖鍝嶃€傘€傘€�
  input Key;
  output reg Key_P_Flag;
  output reg Key_R_Flag;

  reg [1:0] r_Key;
  always @(posedge clk)
    r_Key <= {
      r_Key[0], Key
    };  //姣忎竴涓椂閽熷懆鏈熼兘鎶奒ey鐨勫€兼斁鍒皉_Key鏁扮粍鐨勬渶鍚庝竴浣嶏紙r_Key鏁扮粍涓嶆柇宸︾Щ锛夛紝杩欐牱鍙鎸夐敭鍙樻�??"1"锛堝嵆鎸変笅锛夛紝閭ｈ繖涓�1灏变細鍦ㄤ笅涓€涓椂閽熷懆鏈熻繘鍏_Key鐨勭�??0浣嶏�??
        //鑰屼笖涓€鑸琸ey=1涓嶈鍐嶅皬鐨勬姈鍔ㄩ兘浼氭寔缁釜涓€涓椂閽熷懆鏈燂紝鍥犳鍦ㄤ粎浠呬竴涓椂閽熷懆鏈熶箣鍚庯紝r_Key灏变細鎸佺画涓�11锛�

  wire pedge_key;
  assign pedge_key = r_Key == 2'b01;  //濡傛灉r_Key=01,鍗矺ey鍙樺寲鍒�??1锛堟湁閿寜涓嬶級锛岃繖涓椂鍊檖edeg_key灏辫璧嬪€煎埌1浜嗭紱锛堣�?�绀烘湁涓€涓笂鍗囨部锛�
  wire nedge_key;
  assign nedge_key = r_Key == 2'b10;  //濡傛灉r_Key=1000000,鍗矺ey鍙樺寲鍒�??0锛堟湁閿寜涓嬶級锛岃繖涓椂鍊檔edeg_key灏辫璧嬪€煎埌0浜嗭紱锛堣�?�绀烘湁涓€涓笅闄嶆部锛�  

  reg [19:0] cnt;  //瀹氫箟涓€涓鏁板�??

  reg [ 1:0] state_doudong;  //瀹氫箟涓撳睘浜庢寜閿秷鎶栨ā鍧楃殑鐘舵€侊紱

  always @(posedge clk or negedge Reset_n)
    if (!Reset_n) begin
      state_doudong <= 0;  //澶嶄綅鐘舵€佺殑鏃跺€欙紝鐘舵€佷负0锛�
      Key_R_Flag <= 1'b0;
      Key_P_Flag <= 1'b0;
      cnt <= 0;
    end else begin
      case (state_doudong)
        0:                       //鏈寜涓嬮樁娈碉紝绛夊緟涓婂崌娌�??
          begin
            Key_R_Flag <= 0;  //杩欎釜鑴夊啿淇�?�彿璧剁揣鍙樻垚0
            if (pedge_key)
              state_doudong <= 1;  //濡傛灉鏈変笂鍗囨部锛岄偅灏辫烦杞�??埌锛堟暟20ms锛夐樁娈�??
            else state_doudong <= 0;
          end
        1:  //鏁�20ms娑堟姈闃舵
        if ((nedge_key) && (cnt < 1000000 - 1))  //1000000-1:鎸�20ms
          begin
            state_doudong<=0;                  //濡傛灉鍦ㄤ笉瓒�20ms鐨勬椂闂撮噷闈㈠嚭鐜颁竴涓笅闄嶆部锛岄偅灏辫偗瀹氭槸鎶栧姩锛屽洖鍒扮姸鎬�0
            cnt<= 0;  //璺宠浆鍒�??0鐨勬椂鍊欙紝璁℃暟鍣ㄥ綊闆讹�??
          end
        else if(cnt>=1000000-1)
          begin         //濡傛灉鏃堕棿瓒呰�??20ms閮芥病鏈夊嚭鐜颁竴涓笅闄嶆部锛岄偅灏辨槸鐪熸鐨勬寜涓嬮敭锛屽埌杈剧姸鎬�2锛屽悓鏃朵篃鍙戝嚭涓€涓俊鍙�
            state_doudong <= 2;
            cnt           <= 0;  //璺宠浆鍒�??2鐨勬椂鍊欙紝璁℃暟鍣ㄥ綊闆讹�??
            Key_P_Flag    <= 1;  //鎴戜笓闂ㄦ妸杩欎釜璁剧疆鎴愪簡reg鍨嬶紝涓嶇煡閬撴湁娌℃湁浜嬶�??
          end 
        else 
          begin  //濡傛灉鍟ラ兘娌�?�彂鐢熷苟涓�??椂闂村皬浜�20ms锛岄偅灏辩户缁鏃�??
            cnt <= cnt + 1'b1;
            state_doudong <= 1;
          end
        2:                         //鎸変笅闃舵锛岀瓑寰呬笅闄嶆�??
          begin
            Key_P_Flag <= 0;  //杩欎釜鑴夊啿淇�?�彿璧剁揣鍙樻垚0
            if (nedge_key)
              state_doudong <= 3;  //濡傛灉鏈変笅闄嶆部锛岄偅灏辫烦杞�??埌锛堟暟20ms锛夐樁娈�??
            else state_doudong <= 2;
          end
        3:
        if ((pedge_key) && (cnt < 1000000 - 1))  //1000000-1:鎸�20ms
          begin
            state_doudong<=2;                  //濡傛灉鍦ㄤ笉瓒�20ms鐨勬椂闂撮噷闈㈠嚭鐜颁竴涓笂鍗囨部锛岄偅灏辫偗瀹氭槸鎶栧姩锛屽洖鍒扮姸鎬�2
            cnt<= 0;
          end 
        else if(cnt>=1000000-1)
          begin         //濡傛灉鏃堕棿瓒呰�??20ms閮芥病鏈夊嚭鐜颁竴涓笂鍗囨部锛岄偅灏辨槸鐪熸鐨勬澗寮€閿紝鍒拌揪鐘舵€�??0锛屽悓鏃朵篃鍙戝嚭涓€涓俊鍙�
            state_doudong <= 0;
            cnt           <= 0;  //璺宠浆鍒扮姸鎬�0鐨勬椂鍊欙紝璁℃暟鍣ㄥ綊闆讹�??
            Key_R_Flag    <= 1'b1;  //鎴戜笓闂ㄦ妸杩欎釜璁剧疆鎴愪簡reg鍨嬶紝涓嶇煡閬撴湁娌℃湁浜嬶�??
          end
        else 
          begin                          //濡傛灉鍟ラ兘娌�?�彂鐢熷苟涓�??椂闂村皬浜�20ms锛岄偅灏辩户缁鏃�??,鐘舵€佷笉鍙�??
            cnt <= cnt + 1'b1;
            state_doudong <= 3;
          end
        default: state_doudong <= 0;
      endcase
    end
endmodule





module sale (  //闂佸尅鎷烽柛鐑嗗枟鑶╅柛褝鎷?
    sw,
    clk,
    led_state,
    Reset_n,
    button_shang,
    button_xia,
    button_zuo,
    button_you,
    button_zhong,

    toubi_gewei,
    toubi_shiwei,
    zhaoling_gewei,
    zhaoling_shiwei,
    allprice_gewei,
    allprice_shiwei,
    num_gewei,
    wupin


);
  input [15:0]sw;      //16 items
  input clk=0;
  input button_shang;
  input button_xia;
  input button_zuo;
  input button_you;
  input button_zhong;  //5 buttons
  input Reset_n;  //reset

  output reg [6:0] led_state=7'b1000000;
  output reg [3:0] toubi_gewei=4'b0;
  output reg [3:0] toubi_shiwei=4'b0;
  output reg [3:0] zhaoling_gewei=4'b0;
  output reg [3:0] zhaoling_shiwei=4'b0;
  output reg [3:0] allprice_gewei=4'b0;
  output reg [3:0] allprice_shiwei=4'b0;
  output  reg [3:0] num_gewei=4'b0; 
  output reg [15:0] wupin=16'b0;


  reg [1:0] quantity=2'b0;  
  reg [15:0]count_cishu=16'b0;
  reg [3:0] state=4'b0110;
  reg [9:0] allprice=10'b0; 
  reg [3:0] presentprice=4'b0;  
  reg [9:0] toubi=10'b0;  
  reg [9:0]zhaoling=10'b0;

/*  key_filter se1_shang (  //闁圭顦甸弫顓炩槈閸喎顫嶆俊顖椻偓铏�??
      .clk       (clk),                  //閻忓繐绻戦�?�顏堝传閵壯勭暠闁哄啫鐖奸幐鎾诲及閿燂拷50M濠靛倽妫勯崕姘舵晬閿燂拷
      .Reset_n   (Reset_n),
      .Key       (button_shang),
      .Key_P_Flag(button_shang),
      .Key_R_Flag(buttin_shang_R_Flag)
  );  //缂備焦鐟辩槐妾卽tton_shang闁挎稑顦抽惃鐔兼偨閵娿�?�顏卞☉鎾愁儓缁绘牗绋夐鍛樆闂佹鍠楃粔鐑藉箮閺嶎煂�???宕稿纭锋嫹閿燂�??

  key_filter se1_xia (  //闁圭顦甸弫顓炩槈閸喎顫嶆俊顖椻偓铏�??
      .clk       (clk),                //閻忓繐绻戦�?�顏堝传閵壯勭暠闁哄啫鐖奸幐鎾诲及閿燂拷50M濠靛倽妫勯崕姘舵晬閿燂拷
      .Reset_n   (Reset_n),
      .Key       (button_xia),
      .Key_P_Flag(button_xia),
      .Key_R_Flag(buttin_xia_R_Flag)
  );  //缂備焦鐟辩槐妾卽tton_shang闁挎稑顦抽惃鐔兼偨閵娿�?�顏卞☉鎾愁儓缁绘牗绋夐鍛樆闂佹鍠楃粔鐑藉箮閺嶎煂�???宕稿纭锋嫹閿燂�??

  key_filter se1_zuo (  //闁圭顦甸弫顓炩槈閸喎顫嶆俊顖椻偓铏�??
      .clk       (clk),                //閻忓繐绻戦�?�顏堝传閵壯勭暠闁哄啫鐖奸幐鎾诲及閿燂拷50M濠靛倽妫勯崕姘舵晬閿燂拷
      .Reset_n   (Reset_n),
      .Key       (button_zuo),
      .Key_P_Flag(button_zuo),
      .Key_R_Flag(buttin_zuo_R_Flag)
  );  //缂備焦鐟辩槐妾卽tton_shang闁挎稑顦抽惃鐔兼偨閵娿�?�顏卞☉鎾愁儓缁绘牗绋夐鍛樆闂佹鍠楃粔鐑藉箮閺嶎煂�???宕稿纭锋嫹閿燂�??

  key_filter se1_you (  //闁圭顦甸弫顓炩槈閸喎顫嶆俊顖椻偓铏�??
      .clk       (clk),                //閻忓繐绻戦�?�顏堝传閵壯勭暠闁哄啫鐖奸幐鎾诲及閿燂拷50M濠靛倽妫勯崕姘舵晬閿燂拷
      .Reset_n   (Reset_n),
      .Key       (button_you),
      .Key_P_Flag(button_you),
      .Key_R_Flag(buttin_you_R_Flag)
  );  //缂備焦鐟辩槐妾卽tton_shang闁挎稑顦抽惃鐔兼偨閵娿�?�顏卞☉鎾愁儓缁绘牗绋夐鍛樆闂佹鍠楃粔鐑藉箮閺嶎煂�???宕稿纭锋嫹閿燂�??

  key_filter se1_zhong (  //闁圭顦甸弫顓炩槈閸喎顫嶆俊顖椻偓铏�??
      .clk       (clk),                  //閻忓繐绻戦�?�顏堝传閵壯勭暠闁哄啫鐖奸幐鎾诲及閿燂拷50M濠靛倽妫勯崕姘舵晬閿燂拷
      .Reset_n   (Reset_n),
      .Key       (button_zhong),
      .Key_P_Flag(button_zhong),
      .Key_R_Flag(buttin_zhong_R_Flag)
  );  //缂備焦鐟辩槐妾卽tton_shang闁挎稑顦抽惃鐔兼偨閵娿�?�顏卞☉鎾愁儓缁绘牗绋夐鍛樆闂佹鍠楃粔鐑藉箮閺嶎煂�???宕稿纭锋嫹閿燂�??
  */


  always @(posedge clk or negedge Reset_n)  
    if (!Reset_n) begin
      state <=4'b0110;  //begin with s7
      allprice <= 0;
      count_cishu <= 0;
      led_state<=7'b1000000;
      toubi_gewei<=5'b0;
      toubi_shiwei<=5'b0;
      zhaoling_gewei<=5'b0;
      zhaoling_shiwei<=5'b0;
      allprice_gewei<=5'b0;
      allprice_shiwei<=5'b0;
      num_gewei<=5'b0;
      wupin<=16'b0;
      toubi<=10'b0;
      presentprice<=4'b0;
      zhaoling<=10'b0;
      quantity=2'b0; 

    end else begin
      num_gewei=quantity;

      if (toubi >= 90) begin
        toubi_gewei  = toubi - 90;
        toubi_shiwei = 9;
      end else if (toubi >= 80) begin
        toubi_gewei  = toubi - 80;
        toubi_shiwei = 8;
      end else if (toubi >= 70) begin
        toubi_gewei  = toubi - 70;
        toubi_shiwei = 7;
      end else if (toubi >= 60) begin
        toubi_gewei  = toubi - 60;
        toubi_shiwei = 6;
      end else if (toubi >= 50) begin
        toubi_gewei  = toubi - 50;
        toubi_shiwei = 5;
      end else if (toubi >= 40) begin
        toubi_gewei  = toubi - 40;
        toubi_shiwei = 4;
      end else if (toubi >= 30) begin
        toubi_gewei  = toubi - 30;
        toubi_shiwei = 3;
      end else if (toubi >= 20) begin
        toubi_gewei  = toubi - 20;
        toubi_shiwei = 2;
      end else if (toubi >= 10) begin
        toubi_gewei  = toubi - 10;
        toubi_shiwei = 1;
      end
      else begin
        toubi_gewei  = toubi;
        toubi_shiwei=0;
      end


      if (allprice >= 90) begin
        allprice_gewei  = allprice - 90;
        allprice_shiwei = 9;
      end else if (allprice >= 80) begin
        allprice_gewei  = allprice - 80;
        allprice_shiwei = 8;
      end else if (allprice >= 70) begin
        allprice_gewei  = allprice - 70;
        allprice_shiwei = 7;
      end else if (allprice >= 60) begin
        allprice_gewei  = allprice - 60;
        allprice_shiwei = 6;
      end else if (allprice >= 50) begin
        allprice_gewei  = allprice - 50;
        allprice_shiwei = 5;
      end else if (allprice >= 40) begin
        allprice_gewei  = allprice - 40;
        allprice_shiwei = 4;
      end else if (allprice >= 30) begin
        allprice_gewei  = allprice - 30;
        allprice_shiwei = 3;
      end else if (allprice >= 20) begin
        allprice_gewei  = allprice - 20;
        allprice_shiwei = 2;
      end else if (allprice >= 10) begin
        allprice_gewei  = allprice - 10;
        allprice_shiwei = 1;
      end
      else begin
        allprice_gewei  = allprice;
        allprice_shiwei = 0;
      end


      if (zhaoling >= 90) begin
        zhaoling_gewei  = zhaoling - 90;
        zhaoling_shiwei = 9;
      end else if (zhaoling >= 80) begin
        zhaoling_gewei  = zhaoling - 80;
        zhaoling_shiwei = 8;
      end else if (zhaoling >= 70) begin
        zhaoling_gewei  = zhaoling - 70;
        zhaoling_shiwei = 7;
      end else if (zhaoling >= 60) begin
        zhaoling_gewei  = zhaoling - 60;
        zhaoling_shiwei = 6;
      end else if (zhaoling >= 50) begin
        zhaoling_gewei  = zhaoling - 50;
        zhaoling_shiwei = 5;
      end else if (zhaoling >= 40) begin
        zhaoling_gewei  = zhaoling - 40;
        zhaoling_shiwei = 4;
      end else if (zhaoling>= 30) begin
        zhaoling_gewei  = zhaoling - 30;
        zhaoling_shiwei = 3;
      end else if (zhaoling>= 20) begin
        zhaoling_gewei  = zhaoling - 20;
        zhaoling_shiwei = 2;
      end else if (zhaoling >= 10) begin
        zhaoling_gewei  = zhaoling - 10;
        zhaoling_shiwei = 1;
      end
      else begin 
        zhaoling_gewei  = zhaoling;
        zhaoling_shiwei = 0;
      end
      //gewei shiwei fenli
      case (state)

        4'b0000:                //select item
        begin                    
          led_state[0] <= 1'b1;
          case (sw)  
            16'b0000000000000001: 
            begin
              wupin[0]=1;
              quantity     <= 1;
              presentprice <= 3;
              allprice<=allprice+3;
              state        <= 4'b0001;  //jump to s1
              led_state[0] <= 1'b0;
                  
            end
            16'b0000000000000010:
            begin
              wupin[1]=1;
              quantity <= 1;
              presentprice <= 4;
              allprice<=allprice+4;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000000000000100: 
            begin
              wupin[2]=1;
              quantity <=1;
              presentprice <= 6;
              allprice<=allprice+6;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000000000001000: 
            begin
              wupin[3]=1;
              quantity <= 1;
              presentprice <= 3;
              allprice<=allprice+3;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000000000010000: 
            begin
              wupin[4]=1;
              quantity <= 1;
              presentprice <= 10;
              allprice<=allprice+10;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000000000100000:
            begin
              wupin[5]=1;
              quantity <= 1;
              presentprice <= 8;
              allprice<=allprice+8;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000000001000000: 
            begin
              wupin[6]=1;
              quantity <= 1;
              presentprice <= 9;
              allprice<=allprice+9;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000000010000000: 
            begin
              wupin[7]=1;
              quantity <= 1;
              presentprice <= 7;
              allprice<=allprice+7;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000000100000000: 
            begin
              wupin[8]=1;
              quantity <= 1;
              presentprice <= 4;
              allprice<=allprice+4;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000001000000000:
            begin
              wupin[9]=1;
              quantity <= 1;
              presentprice <= 6;
              allprice<=allprice+6;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000010000000000: 
            begin
              wupin[10]=1;
              quantity <= 1;
              presentprice <= 15;
              allprice<=allprice+15;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0000100000000000: 
            begin
              wupin[11]=1;
              quantity <= 1;
              presentprice <= 8;
              allprice<=allprice+8;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0001000000000000: 
            begin
              wupin[12]=1;
              quantity <= 1;
              presentprice <= 9;
              allprice<=allprice+9;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0010000000000000:
            begin
              wupin[13]=1;
              quantity <= 1;
              presentprice <= 4;
              allprice<=allprice+4;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b0100000000000000: 
            begin
              wupin[14]=1;
              quantity <= 1;
              presentprice <= 5;
              allprice<=allprice+5;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            16'b1000000000000000: 
            begin
              wupin[15]=1;
              quantity <= 1;
              presentprice <= 5;
              allprice<=allprice+5;
              state <= 4'b0001;
              led_state[0] <= 1'b0; 
            end
            default: state <= 4'b0000;
          endcase  

        end 
        4'b0001:     //s1 select num
        begin
          led_state[1] <= 1'b1;  
          case({button_shang,button_xia,button_zuo,button_you,button_zhong})
            5'b10000:begin //num+1
              case (quantity)
                1: begin
                  quantity <= quantity + 1;
                  allprice <= allprice+presentprice;
                  state<=4'b0001;              
                end
                2: begin  
                  quantity <= quantity + 1;
                  allprice <= allprice+presentprice;
                  state <= 4'b0001;
                end
                default: begin
                  
                  state <= 4'b0001;
                end
              endcase  
            end

            5'b01000: begin  //num-1
              case (quantity)
                2: begin
                  quantity <= quantity - 1'b1;
                  allprice <= allprice-presentprice;
                  state<=4'b0001;             
                end
                3: begin  
                  quantity <= quantity - 1;
                  allprice <= allprice-presentprice;
                  state <= 4'b0001;
                end
                default: begin
                  state <= 4'b0001;
                end
              endcase  
            end

            5'b00100: begin  // not buy this
              allprice = allprice-quantity*presentprice;//due to the second time,cant =0 directly
              quantity <= 0;  
              state    <= 4'b0000;  //jump to s0
              wupin<=16'b0;
              led_state[1] <= 1'b0;

            end

            5'b00001:begin  //jump to s2

              state <= 4'b0010;  
              led_state[1] <= 1'b0;
            end
            default:state<=4'b0001;
          
          endcase
        end


        4'b0010:     //sure to buy?
        begin
            led_state[2] <= 1'b1;
            case({button_shang,button_xia,button_zuo,button_you,button_zhong})  
              5'b00010://buy this and contonue
                begin
                    case(count_cishu)    
                    0: //the 1st 
                        begin                           
                            count_cishu<=1145;   
                            state <= 4'b0000;//jumo to s0
                            quantity<=0;
                            led_state[2] <= 1'b0;
                            wupin<=16'b0000000000000000;
                        end
                    1145: 
                        begin
                            count_cishu<=1145;//the 2nd
                            state <= 4'b0010;  //杩涘叆浜嗘姇甯侀樁娈碉紒
                        end
                    default: 
                        begin
                            count_cishu<=1145;   //default鏄敤鏉ヤ互闃蹭竾涓跨殑憧傘總濡傛灉娌＄粡杩囧垵濮嬪寲鐨勯珮闃绘?佽蛋default杩欐潯璺紝閭ｄ笉灏卞彲浠ヨ繘鍏ュ惊鐜簡鍢涖靠
                            state <= 4'b0000;
                            led_state[2] <= 1'b0;
                        end
                    endcase
                end

              5'b00100://not buy this and continue
                  begin  
                      allprice=allprice-quantity*presentprice;
                      quantity<=0;
                      state<=4'b0000;
                      led_state[2] <= 1'b0;  
                      wupin<=16'b0000000000000000;
                  end

              5'b10000://not buy this and not continue and coin
                  begin
                    allprice=allprice-quantity*presentprice;
                    quantity<=0;
                    state <= 4'b0011;
                    led_state[2] <= 1'b0;  
                    wupin<=16'b0000000000000000;
                  end

              5'b01000://buy this and not continue and coin
                  begin
                      quantity<=0;
                      state <= 4'b0011;
                      led_state[2] <= 1'b0;
                      wupin<=16'b0000000000000000;
                  end
              default :state <= 4'b0010;
            endcase
        end
        4'b0011:    //coin
        begin
          led_state[3] <= 1'b1;
          case (sw)
            16'b00000000000000001: begin
              allprice <= 0;
              count_cishu<=16'b0;
              state<=4'b0000;  //闁圭顦花鈩冪▔閿熻姤绋夌?ｎ亞纾婚柛蹇斿▕濞村倿鏁嶅畝鍕簼閻忓繗绮剧换鎴�??炊閻愬弶娅岄柛婵呯窔閿熻棄顦抽崰�???鎮惧畝鍕�?�闁挎稒鐩妴搴㈢瑹閹稿骸惟"闁诡剝顔婇悳�???"鐎殿喖�?�崹锟?0闁挎稑鐭傞崑鍛焊鏉堚晜绁茬憸鐗堟尫缁剟鏌屽鍡樼厐鐎殿噯鎷峰┑顔碱儔閿熻棄顦遍鍥ㄧ▔閿熻姤绂掗敓锟?
              led_state[3] <= 1'b0;
                           
            end
            16'b0000000000000010: begin
              zhaoling=toubi;     //閻犲洢鍎叉竟�???鎯冮崟顖涚ォ=闁硅埖娲栫粩鐢稿极閿燂拷
              state<=4'b0101;  //閻犲搫鐤囧ù鍡涘礆閹殿喖笑闁诡剨鎷?5 闁硅埖娲栫粩鐢告⒓閼告鍞介柕鍡嫹
              led_state[3] <= 1'b0;
            end
            default:
              begin
                if(toubi<allprice)
                  begin
                    case({button_shang,button_xia,button_zuo,button_you,button_zhong})
                      5'b00001: toubi <= toubi + 1;
                      5'b10000: toubi <= toubi + 5;
                      5'b01000: toubi <= toubi + 20;
                      5'b00100: toubi <= toubi + 50;
                      5'b00010: toubi <= toubi + 10;
                      default :state<=4'b0011;
                        
                    endcase
                  end
                else if(toubi>=allprice)//濠碘?�???归悘澶愬箮閺囩偟顏查柡浣规緲閵囧洦绂嶆惔锝囨惣濞存粌姘︽慨宕囨嫻鐟欏嫭娈堕柨娑楁祰缁绘牠寮伴婊冃﹂柟顒婃嫹3闁硅埖娲栫粩鐢告儍閸曨剛澹嬮煫鍥锋嫹
                  begin
                    //zhaoling <= toubi - allprice;
                    state    <= 4'b0100;  //閻犲搫鐤囧ù鍡涘礆閹殿喖笑闁诡剨鎷?4闁挎稒姘ㄩ垾妯尖偓瑙勭濡叉悂宕ラ敃鈧崵顓犳嫻瑜斿Ο浣糕枔閻愮櫢鎷烽敓锟?
                    led_state[3] <= 1'b0;
                  end
                else state<=4'b0011;
                
              end
           
          endcase
          

        end

        4'b0100: 
        begin
          led_state[4] <= 1'b1;
          case(sw)
            16'b00000000000000001: begin
              allprice <= 0;
              state<=4'b0000;  //闁圭顦花鈩冪▔閿熻姤绋夌?ｎ亞纾婚柛蹇斿▕濞村倿鏁嶅畝鍕簼閻忓繗绮剧换鎴�??炊閻愬弶娅岄柛婵呯窔閿熻棄顦抽崰�???鎮惧畝鍕�?�闁挎稒鐩妴搴㈢瑹閹稿骸惟"闁诡剝顔婇悳�???"鐎殿喖�?�崹锟?0闁挎稑鐭傞崑鍛焊鏉堚晜绁茬憸鐗堟尫缁剟鏌屽鍡樼厐鐎殿噯鎷峰┑顔碱儔閿熻棄顦遍鍥ㄧ▔閿熻姤绂掗敓锟?
              led_state[4] <= 1'b0;             
            end
            default:
              case({button_shang,button_xia,button_zuo,button_you,button_zhong})
                 5'b00001: 
                 begin 
                   zhaoling = toubi - allprice;
                   allprice =0;
                   toubi=0;
                   count_cishu=16'b0;
                   state= 4'b0101;
                   led_state[4] <= 1'b0;
                   
                 end
              default :state<=4'b0100;                  
             endcase
          endcase

        end

        4'b0101://change
          begin
            led_state[5] <= 1'b1;
            allprice=0;
            toubi=0;
            case({button_shang,button_xia,button_zuo,button_you,button_zhong})
              5'b00001: 
                begin 
                  if(zhaoling>0)
                    begin
                      zhaoling=zhaoling-1;
                      state<=4'b0101;
                    end
                  else
                    begin

                      state<=4'b0110;
                      led_state[5] <= 1'b0;
                    end
                end
              default:
                begin
                  if(zhaoling==0)
                    begin
                    allprice<=0;
                    led_state[5]<=1'b0;
                    state<=4'b0110;
                    end

                end               
            endcase
          end
        4'b0110:
          begin
            count_cishu<=16'b0;
            led_state[6]=1;
            if(button_shang)
              begin
              state<=4'b0000; 
              led_state[6]<=0;
              end
          end


        default:         //濠碘?�???归悘濉籺ate濞戞挸绉村﹢顏呮交濞嗗繐褰嬪☉鎿冧簽婵悂骞?娓氣偓閸ｇ兘�???鎼存繄鐤勯柛鏃傚剳缁辩敻鏁嶉崼鐔镐粯闁哄牆顦ぐ鏌ユ嚄閽樺韬Δ鍌涳耿濡棝�???娴ｇ鎷烽崒姗堟嫹閸岋妇�???
        state <= 4'b0110;  //閻犙嶆嫹0闁挎稑鑻畵鍡涘矗椤栨繄绠婚柛蹇嬪劚閹﹪鎮抽姗堟嫹閿燂拷
      endcase  //闁轰胶绻濈紞�???6濞戞搩浜炴慨鎼佸箑娴ｇ晫绠瑰☉鎿冧簻閵囧樈ase闁汇劌鍨緉dcase
  end  //閺夆晜鐟ら柌婊堝嫉閿熻姤寰勮濞堟叧lways闁汇劌鍨緇se闁汇劌鍨篹gin闁汇劌鍨緉d


endmodule  //闁绘鍩栭敓鎴掔劍濠р偓缂備焦鎸诲锟?

module top_layer (
  input clk,
  input rstn,
  input button_shang,
  input button_xia,
  input button_zuo,
  input button_you,
  input button_zhong,
  input [15:0] sw,
  output v_sig,
  output h_sig,
  output [11:0] rgb,
  output [6:0] led


);
wire [15:0] item;
wire clk_50m;
wire active_flag;
wire [11:0] h_addr;
wire [11:0] v_addr;
wire [4:0] button_out;
wire [15:0] sw_out;

wire [3:0] gewei_tou,shiwei_tou,gewei_cost,shiwei_cost,gewei_change,shiwei_change,gewei_num;
assign sw_out[15:2]=sw[15:2];

clk_50M M0(
  clk,
  rstn,
  clk_50m
);

key_filter M1_sw0(
  clk_50m,
  rstn,
  sw[0],
  sw_out[0]
);
key_filter M1_sw1(
  clk_50m,
  rstn,
  sw[1],
  sw_out[1]
);
key_filter M1_shang(
  clk_50m,
  rstn,
  button_shang,
  button_out[4]

);
key_filter M1_xia(
  clk_50m,
  rstn,
  button_xia,
  button_out[3]

);
key_filter M1_zuo(
  clk_50m,
  rstn,
  button_zuo,
  button_out[2]

);
key_filter M1_you(
  clk_50m,
  rstn,
  button_you,
  button_out[1]

);
key_filter M1_zhong(
  clk_50m,
  rstn,
  button_zhong,
  button_out[0]

);
vga_driver M2(
  clk_50m,
  rstn,
  h_sig,
  v_sig,
  active_flag,
  h_addr,
  v_addr
);
vga_display M3(
  clk_50m,
  rstn,
  active_flag,
  h_addr,
  v_addr,
  item,
  gewei_tou,
  shiwei_tou,
  gewei_cost,
  shiwei_cost,
  gewei_change,
  shiwei_change,
  gewei_num,
  rgb
);
sale M4(
  sw_out,
  clk_50m,
  led,
  rstn,
  button_out[4],
  button_out[3],
  button_out[2],
  button_out[1],
  button_out[0],
  gewei_tou,
  shiwei_tou,
  gewei_change,
  shiwei_change,
  gewei_cost,
  shiwei_cost,
  gewei_num,
  item
); 
endmodule
