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
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   //���ϼ� �Ӵ�������״̬0
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
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;      //ȷ��������һ����Ʒ2��4Ԫ�������ص�״̬0��ڶ���
#50
sw=16'b0000000000000010;
#30
sw=16'b0000000000000000; 
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;     //��ʱ�ܼ�8Ԫ
#50   
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;     //��ѡ��һ����Ʒ2������״̬2���������ȡ������
#50
sw=16'b0000000000000010;
#30
sw=16'b0000000000000000; 
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       //����ѡ��һ���ڶ�����Ʒ����״̬2
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       //�����ϼ�"���򱾴���Ʒ������������"������״̬3Ͷ��
#50      
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       ///�������м�����Ͷ����1Ԫ
#50
sw=16'b0000000000000010;
#30
sw=16'b0000000000000000; 
#50                                                                 //ֱ�Ӱ�����1���㣬��������\
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
#50
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
#30
{button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       //�������м���������������������״̬
#50




  
#1000 $stop;

end

endmodule