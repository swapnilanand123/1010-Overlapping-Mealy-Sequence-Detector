`timescale 1ns/1ns

module mealy1010 (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg data_out
);

  reg [1:0] ns, ps;

  parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

  always @(posedge clk, negedge rst) begin
    if (!rst)
      ps <= S0;
    else
      ps <= ns;
  end

  always @(*) begin
    case (ps)
      S0: begin
        ns <= data_in ? S1 : S0;
        data_out <= 1'b0;
      end
      S1: begin
        ns <= data_in ? S1 : S2;
        data_out <= 1'b0;
      end
      S2: begin
        ns <= data_in ? S3 : S0;
        data_out <= 1'b0;
      end
      S3: begin
        ns <= data_in ? S1 : S2;
        data_out <= data_in ? 1'b0 : 1'b1;
      end
      default: begin
        ns <= S0;
        data_out <= 1'b0;
      end
    endcase
  end

endmodule

interface mealy1010_if;
  logic clk, rst;
  logic data_in, data_out;
endinterface
