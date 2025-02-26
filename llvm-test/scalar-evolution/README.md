clang -S -emit-llvm scev.c -o scev.ll

opt -passes="mem2reg,simplifycfg,instcombine" -S scev.ll -o red_scev.ll

opt -passes="print<scalar-evolution>" -disable-output red_scev.ll