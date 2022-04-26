module Assignment5(
input wire x,
input wire y,
input wire z,
input wire w,
output wire redled,
output wire greenled,
output wire blueled
);

reg kmap_output;
always @(*)
begin
kmap_output = (!x&y)|(!y&z)|(x&z&w);
if(kmap_output==1)
begin
redled=1;
end
else
begin
redled=0;
end
end
endmodule
