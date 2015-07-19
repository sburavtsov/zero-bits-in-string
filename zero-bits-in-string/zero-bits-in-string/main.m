//
//  main.m
//  zero-bits-in-string
//
//  Created by Sergey Buravtsov on 18.07.15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <Foundation/Foundation.h>

NSUInteger fastZeroBitsInChar(const char *data) {

    /*
    Counting bits set, in parallel
    http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
    
    https://groups.google.com/forum/?hl=en#!msg/comp.graphics.algorithms/ZKSegl2sr4c/QYTwoPSx30MJ

     unsigned int v; // count bits set in this (32-bit value)
    unsigned int c; // store the total here
    static const int S[] = {1, 2, 4, 8, 16}; // Magic Binary Numbers
    static const int B[] = {0x55555555, 0x33333333, 0x0F0F0F0F, 0x00FF00FF, 0x0000FFFF};
    
    c = v - ((v >> 1) & B[0]);
    c = ((c >> S[1]) & B[1]) + (c & B[1]);
    c = ((c >> S[2]) + c) & B[2];
    c = ((c >> S[3]) + c) & B[3];
    c = ((c >> S[4]) + c) & B[4];
    The B array, expressed as binary, is:
    B[0] = 0x55555555 = 01010101 01010101 01010101 01010101
    B[1] = 0x33333333 = 00110011 00110011 00110011 00110011
    B[2] = 0x0F0F0F0F = 00001111 00001111 00001111 00001111
    B[3] = 0x00FF00FF = 00000000 11111111 00000000 11111111
    B[4] = 0x0000FFFF = 00000000 00000000 11111111 11111111
    
     We can adjust the method for larger integer sizes by continuing with the patterns for the Binary Magic Numbers, B and S. If there are k bits, then we need the arrays S and B to be ceil(log2(k)) elements long, and we must compute
     the same number of expressions for c as S or B are long. For a 32-bit v, 16 operations are used.
     The best method for counting bits in a 32-bit integer v is the following:
            
    v = v - ((v >> 1) & 0x55555555);                    // reuse input as temporary
    v = (v & 0x33333333) + ((v >> 2) & 0x33333333);     // temp
    c = ((v + (v >> 4) & 0xF0F0F0F) * 0x1010101) >> 24; // count
    The best bit counting method takes only 12 operations, which is the same as the lookup-table method, but avoids the memory and potential cache misses of a table. It is a hybrid between the purely parallel method above and the earlier methods using multiplies (in the section on counting bits with 64-bit instructions), though it doesn't use 64-bit instructions. The counts of bits set in the bytes is done in parallel, and the sum total of the bits set in the bytes is computed by multiplying by 0x1010101 and shifting right 24 bits.
    
    */
    
    unsigned char byte = ~ (*data); // inverted to convert 0 to 1
    unsigned int c; // store the total here
    static const unsigned char S[] = {1, 2, 4}; // Magic Binary Numbers
    static const unsigned char B[] = {0x55, 0x33, 0x0F};

    c = byte - ((byte >> S[0]) & B[0]);
    c = ((c >> S[1]) & B[1]) + (c & B[1]);
    c = ((c >> S[2]) + c) & B[2];

    return c;
}

NSUInteger generalZeroBitsInChar(const char *data) {
    
    NSUInteger count = 0;
    
    unsigned char byte = ~ (*data);
    
    for (NSUInteger i = 0; i < 8; ++i ) {
        
        count += ((byte >> i) & 1);
    }
    
    return count;
}

NSUInteger intCountZeroBits_fast(const char *str) {
    
    NSUInteger result = 0;
    for (NSUInteger symbolIndex = 0; symbolIndex < strlen(str); symbolIndex++) {
        
        result += fastZeroBitsInChar(str + symbolIndex);
    }
    return result;
}

NSUInteger intCountZeroBits_general(const char *str) {
    
    NSUInteger result = 0;
    for (NSUInteger symbolIndex = 0; symbolIndex < strlen(str); symbolIndex++) {
        
        result += generalZeroBitsInChar(str + symbolIndex);
    }
    return result;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Counting bits in:");
        NSLog(@"A");
        
        NSString *test = @"AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp  vt7bpntp8t7AOUIBGGHJIHguub8yniutv8h7unhbi&T)Hng76^B86rvtTBY78tv%vrd&^Ctvftgh&YF76tvb97gg*7tbfB^t9F7vbGFb76vtbgtgvobftvfbyfyf  o76bo876ttngvgvbgp9tfb8ognoTPbt7fo^ RVo8btn8pTp";
        
        NSLog(@"Zero fast bits: %tu", intCountZeroBits_fast([test cStringUsingEncoding:NSUTF8StringEncoding]));
        NSLog(@"Zero general bits: %tu", intCountZeroBits_general([test cStringUsingEncoding:NSUTF8StringEncoding]));
        
        NSUInteger M = 10;
        NSUInteger N = M + 1; // one number duplicates, so actual array will be larger by 1 element
        
        // initialize array, it is not important is it will be sorted or no as we will just calculate sum later
        NSUInteger values[N];

        // fill values
        for (NSUInteger index = 1; index < N; index++) {
            
            values[index] = index;
        }

        // make "duplicate"
        NSUInteger duplicate = (arc4random() % M) + 1;
        values[0] = duplicate;

        for (NSUInteger logIndex = 0; logIndex < N; logIndex++) {
            NSLog(@"Value at %tu[%tu]", logIndex, values[logIndex]);
        }
        
        NSUInteger actualSum = 0;
        for (NSUInteger index = 0; index < N; index++) {
            
            actualSum += values[index];
        }
        
        NSUInteger arifmeticScaleSum = M * (M + 1) / 2;
        
        NSUInteger duplicateFound = actualSum - arifmeticScaleSum;
        
        NSLog(@"Duplicate is: %tu", duplicateFound);
    }
    return 0;
}
