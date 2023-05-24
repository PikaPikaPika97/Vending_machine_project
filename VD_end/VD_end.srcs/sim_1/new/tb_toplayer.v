`timescale 1ms/1ms

module tb_toplayer ();

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
top_layer top_layer_1(
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
    #30;
    rstn=1;
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   //按上�? 从待机进入状�?0
    #200
    sw=16'b0000000000000000; 
    #200
    sw=16'b0000000000000001;
    #30
    sw=16'b0000000000000000; 
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000000000010;
    #30
    sw=16'b0000000000000000; 
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000000000100;
    #30
    sw=16'b0000000000000000; 
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000000001000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000000010000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000000100000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000001000000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000010000000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000000100000000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000001000000000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000010000000000;
    #30
    sw=16'b0000000000000000; 
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0000100000000000;
    #30
    sw=16'b0000000000000000; 
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0001000000000000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0010000000000000;
    #30
    sw=16'b0000000000000000;  
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b0100000000000000;
    #30
    sw=16'b0000000000000000; 
    #200

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    sw=16'b1000000000000000;
    #30
    sw=16'b0000000000000000;  
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200                                                                          //测试�?有的拨码�?�?

    sw=16'b0000000000000001;
    #30
    sw=16'b0000000000000000; 
    #200                               //选择第一件商�?
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b01000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   
    #200                                                                        //这个时�?�：2件商品，

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       
    #200         
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;          //进入状�??2后按左键清零  
    #200   

    sw=16'b0000010000000000;
    #30
    sw=16'b0000000000000000; 
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;         
    #200   
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        //两下上键，数量为3，进入状�?2   
    #200 
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00010;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;   //确认购买本次商品 进入状�??0       
    #200

    sw=16'b0000000000010000;
    #30
    sw=16'b0000000000000000;  
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;         
    #200   
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        //两下上键，数量为3，进入状�?2   
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b01000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       //下键：进入状�?3投币    
    #200           
                                                            
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;         
    #200   
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;       
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b10000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00010;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;         
    #200   
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b01000;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00100;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;             //投币87元，跳转到状�?4
    #200   
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200                                                                        //按键中：�?始找�?

    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        
    #200
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00001;
    #30
    {button_shang,button_xia,button_zuo,button_you,button_zhong}=5'b00000;        //12下中键，应该是回了待机状态�?? 
    #200   

            
    #1000 $stop;



    end
    endmodule //tb_toplayer
