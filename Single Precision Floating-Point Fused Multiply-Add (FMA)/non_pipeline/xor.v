module xor1 (sign_A, sign_B, sign_P);
    
input sign_A, sign_B;
output sign_P;

assign sign_P = sign_A ^ sign_B;


endmodule