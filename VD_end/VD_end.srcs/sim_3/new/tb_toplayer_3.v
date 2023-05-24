`timescale 1ms/1ms

module tb_toplayer_3 ();

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
top_layer top_layer_3(
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