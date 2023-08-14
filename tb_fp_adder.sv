module testbench;

logic clk, reset;

logic [31:0] fp1;
logic [31:0] fp2;
logic [31:0] out;

logic [31:0] expected;

logic [32-1:0] vectornum, errors;
logic [(32+32+32)-1:0] testvectors_fps [0:10000];

fp_adder /* #( ) */ dut(
  .i_fp1(fp1),
  .i_fp2(fp2),
  .o_fp(out)
);

always #5 clk = ~clk;




initial begin
  $readmemb("./fps.tv", testvectors_fps);
  vectornum = 0; errors = 0;

  $dumpfile("testbench.vcd");
	$dumpvars(0, testbench);
  clk = 0;
  reset = 1; #27; reset = 0;
end

always @ (posedge clk) begin
  #1; {fp1, fp2, expected} = testvectors_fps[vectornum];
end


always @ (negedge clk) begin
  if(~reset) begin
    if(out[31:2] !== expected[31:2]) begin
      $display("Error: inputs fp1 = %b, fp2 = %b",fp1, fp2);
      $display(" outputs = %h (%h expected)", out, expected);
      errors = errors + 1;
    end
    //else begin
    //  $display("success: inputs fp1 = %b, fp2 = %b",fp1, fp2);
    //  $display(" outputs = %b (%b expected)", out, expected);
    //end
  end
end

always @(negedge clk) begin
  if (~reset) begin

    vectornum = vectornum + 1;

    if (testvectors_fps[vectornum] === 96'bx) begin
      $display("%d tests completed with %d errors", vectornum, errors);
      $finish;
    end
  end
end

endmodule

