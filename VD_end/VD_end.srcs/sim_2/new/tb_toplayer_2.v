`timescale 1ms/1ms

module tb_toplayer_2 ();

reg clk;
reg rstn;
reg button_shang;
reg button_xia;
reg button_zuo;
reg button_you;
reg button_zhong;
reg [15:0] sw;
wire v_sig;
wire h_sig;
wire [11:0] rgb;
wire [6:0] led;
top_layer top_layer_2(
    .clk(clk),
    .rstn(rstn),
    .button_shang(button_shang),
    .button_xia(button_xia),
    .button_zuo(button_zuo),
    .button_you(button_you),
    .button_zhong(button_zhong),
    .sw(sw),
    .v_sig(v_sig),
    .h_sig(h_sig),
    .rgb(rgb),
    .led(led)
);
initial begin
    clk=0;
    forever #1 clk=~clk;
end
initial begin
rstn=0;
#50
rstn=1;
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;
sw=16'b0000000000000000;
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   //按上键 从待机进入状态0
#50
sw=16'b0000000000000010;
#30
sw=16'b0000000000000000; 
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00010;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;      //确定购买了一件商品2（4元），并回到状态0买第二件
#50
sw=16'b0000000000000010;
#30
sw=16'b0000000000000000; 
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;     //此时总价8元
#50   
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;     //挑选了一件商品2，但在状态2按了左键，取消购买。
#50
sw=16'b0000000000000010;
#30
sw=16'b0000000000000000; 
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       //重新选购一件第二种商品进入状态2
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       //测试上键"不买本次商品并不继续购买"，进入状态3投币
#50      
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       ///按两下中键，即投两个1元
#50
sw=16'b0000000000000010;
#30
sw=16'b0000000000000000; 
#50                                                                 //直接按开关1找零，不出货了\
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       //按两次中键，即找零结束，进入待机状态
#50




  
#1000 $stop;

end

endmodule