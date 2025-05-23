; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse2   | FileCheck %s --check-prefix=SSE --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse4.2 | FileCheck %s --check-prefix=SSE --check-prefix=SSE42
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx    | FileCheck %s --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx2   | FileCheck %s --check-prefix=AVX --check-prefix=AVX2

; PR6399

define <2 x i32> @_mul2xi32a(<2 x i32>, <2 x i32>) {
; SSE2-LABEL: _mul2xi32a:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: _mul2xi32a:
; SSE42:       # %bb.0:
; SSE42-NEXT:    pmulld %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: _mul2xi32a:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulld %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %r = mul <2 x i32> %0, %1
  ret <2 x i32> %r
}

define <2 x i32> @_mul2xi32b(<2 x i32>, <2 x i32>) {
; SSE-LABEL: _mul2xi32b:
; SSE:       # %bb.0:
; SSE-NEXT:    pmuludq %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: _mul2xi32b:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %factor0 = shufflevector <2 x i32> %0, <2 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 2, i32 undef>
  %factor1 = shufflevector <2 x i32> %1, <2 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 2, i32 undef>
  %product64 = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %factor0, <4 x i32> %factor1) readnone
  %product = bitcast <2 x i64> %product64 to <4 x i32>
  %r = shufflevector <4 x i32> %product, <4 x i32> undef, <2 x i32> <i32 0, i32 4>
  ret <2 x i32> %r
}

define <4 x i32> @_mul4xi32a(<4 x i32>, <4 x i32>) {
; SSE2-LABEL: _mul4xi32a:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: _mul4xi32a:
; SSE42:       # %bb.0:
; SSE42-NEXT:    pmulld %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: _mul4xi32a:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulld %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %r = mul <4 x i32> %0, %1
  ret <4 x i32> %r
}

define <4 x i32> @_mul4xi32b(<4 x i32>, <4 x i32>) {
; SSE2-LABEL: _mul4xi32b:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: _mul4xi32b:
; SSE42:       # %bb.0:
; SSE42-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE42-NEXT:    pmuludq %xmm1, %xmm0
; SSE42-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE42-NEXT:    pmuludq %xmm2, %xmm1
; SSE42-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,0,2,2]
; SSE42-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3],xmm0[4,5],xmm1[6,7]
; SSE42-NEXT:    retq
;
; AVX1-LABEL: _mul4xi32b:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmuludq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,2,2]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm2[0,1],xmm0[2,3],xmm2[4,5],xmm0[6,7]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: _mul4xi32b:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmuludq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX2-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,2,2]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm2[0],xmm0[1],xmm2[2],xmm0[3]
; AVX2-NEXT:    retq
  %even0 = shufflevector <4 x i32> %0, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 2, i32 undef>
  %even1 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 2, i32 undef>
  %evenMul64 = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %even0, <4 x i32> %even1) readnone
  %evenMul = bitcast <2 x i64> %evenMul64 to <4 x i32>
  %odd0 = shufflevector <4 x i32> %0, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 3, i32 undef>
  %odd1 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 3, i32 undef>
  %oddMul64 = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %odd0, <4 x i32> %odd1) readnone
  %oddMul = bitcast <2 x i64> %oddMul64 to <4 x i32>
  %r = shufflevector <4 x i32> %evenMul, <4 x i32> %oddMul, <4 x i32> <i32 0, i32 4, i32 2, i32 6>
  ret <4 x i32> %r
}

; the following extractelement's and insertelement's
; are just an unrolled 'zext' on a vector
; %ext0 = zext <4 x i32> %0 to <4 x i64>
; %ext1 = zext <4 x i32> %1 to <4 x i64>
define <4 x i64> @_mul4xi32toi64a(<4 x i32>, <4 x i32>) {
; SSE2-LABEL: _mul4xi32toi64a:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[2,1,3,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[2,1,3,3]
; SSE2-NEXT:    pmuludq %xmm3, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,1,1,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,1,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm2, %xmm1
; SSE2-NEXT:    retq
;
; SSE42-LABEL: _mul4xi32toi64a:
; SSE42:       # %bb.0:
; SSE42-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[2,1,3,3]
; SSE42-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[2,1,3,3]
; SSE42-NEXT:    pmuludq %xmm3, %xmm2
; SSE42-NEXT:    pmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; SSE42-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE42-NEXT:    pmuludq %xmm1, %xmm0
; SSE42-NEXT:    movdqa %xmm2, %xmm1
; SSE42-NEXT:    retq
;
; AVX1-LABEL: _mul4xi32toi64a:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm0[2,2,3,3]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm3 = xmm1[2,2,3,3]
; AVX1-NEXT:    vpmuludq %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX1-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: _mul4xi32toi64a:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovzxdq {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; AVX2-NEXT:    vpmovzxdq {{.*#+}} ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero
; AVX2-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %f00 = extractelement <4 x i32> %0, i32 0
  %f01 = extractelement <4 x i32> %0, i32 1
  %f02 = extractelement <4 x i32> %0, i32 2
  %f03 = extractelement <4 x i32> %0, i32 3
  %f10 = extractelement <4 x i32> %1, i32 0
  %f11 = extractelement <4 x i32> %1, i32 1
  %f12 = extractelement <4 x i32> %1, i32 2
  %f13 = extractelement <4 x i32> %1, i32 3
  %ext00 = zext i32 %f00 to i64
  %ext01 = zext i32 %f01 to i64
  %ext02 = zext i32 %f02 to i64
  %ext03 = zext i32 %f03 to i64
  %ext10 = zext i32 %f10 to i64
  %ext11 = zext i32 %f11 to i64
  %ext12 = zext i32 %f12 to i64
  %ext13 = zext i32 %f13 to i64
  %extv00 = insertelement <4 x i64> undef,   i64 %ext00, i32 0
  %extv01 = insertelement <4 x i64> %extv00, i64 %ext01, i32 1
  %extv02 = insertelement <4 x i64> %extv01, i64 %ext02, i32 2
  %extv03 = insertelement <4 x i64> %extv02, i64 %ext03, i32 3
  %extv10 = insertelement <4 x i64> undef,   i64 %ext10, i32 0
  %extv11 = insertelement <4 x i64> %extv10, i64 %ext11, i32 1
  %extv12 = insertelement <4 x i64> %extv11, i64 %ext12, i32 2
  %extv13 = insertelement <4 x i64> %extv12, i64 %ext13, i32 3
  %r = mul <4 x i64> %extv03, %extv13
  ret <4 x i64> %r
}

; very similar to mul4xi32 above
; there is no bitcast and the final shuffle is a little different
define <4 x i64> @_mul4xi32toi64b(<4 x i32>, <4 x i32>) {
; SSE-LABEL: _mul4xi32toi64b:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE-NEXT:    pmuludq %xmm1, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE-NEXT:    pmuludq %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    punpckhqdq {{.*#+}} xmm2 = xmm2[1],xmm1[1]
; SSE-NEXT:    movdqa %xmm2, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: _mul4xi32toi64b:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmuludq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckhqdq {{.*#+}} xmm1 = xmm2[1],xmm0[1]
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: _mul4xi32toi64b:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmuludq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX2-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpunpckhqdq {{.*#+}} xmm1 = xmm2[1],xmm0[1]
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %even0 = shufflevector <4 x i32> %0, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 2, i32 undef>
  %even1 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 2, i32 undef>
  %evenMul = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %even0, <4 x i32> %even1) readnone
  %odd0 = shufflevector <4 x i32> %0, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 3, i32 undef>
  %odd1 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 3, i32 undef>
  %oddMul = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %odd0, <4 x i32> %odd1) readnone
  %r = shufflevector <2 x i64> %evenMul, <2 x i64> %oddMul, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x i64> %r
}

; Here we do not split into even and odd indexed elements
; but into the lower and the upper half of the factor vectors.
; This makes the initial shuffle more complicated,
; but the final shuffle is a no-op.
define <4 x i64> @_mul4xi32toi64c(<4 x i32>, <4 x i32>) {
; SSE2-LABEL: _mul4xi32toi64c:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[0,1,1,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[0,1,1,3]
; SSE2-NEXT:    pmuludq %xmm3, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,1,3,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[2,1,3,3]
; SSE2-NEXT:    pmuludq %xmm0, %xmm1
; SSE2-NEXT:    movdqa %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: _mul4xi32toi64c:
; SSE42:       # %bb.0:
; SSE42-NEXT:    pmovzxdq {{.*#+}} xmm3 = xmm0[0],zero,xmm0[1],zero
; SSE42-NEXT:    pmovzxdq {{.*#+}} xmm2 = xmm1[0],zero,xmm1[1],zero
; SSE42-NEXT:    pmuludq %xmm3, %xmm2
; SSE42-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,2,3,3]
; SSE42-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[2,2,3,3]
; SSE42-NEXT:    pmuludq %xmm0, %xmm1
; SSE42-NEXT:    movdqa %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: _mul4xi32toi64c:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm2 = xmm0[0],zero,xmm0[1],zero
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm3 = xmm1[0],zero,xmm1[1],zero
; AVX1-NEXT:    vpmuludq %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,2,3,3]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[2,2,3,3]
; AVX1-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm2, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: _mul4xi32toi64c:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovzxdq {{.*#+}} ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero
; AVX2-NEXT:    vpmovzxdq {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; AVX2-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %lower0 = shufflevector <4 x i32> %0, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 1, i32 undef>
  %lower1 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 1, i32 undef>
  %lowerMul = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %lower0, <4 x i32> %lower1) readnone
  %upper0 = shufflevector <4 x i32> %0, <4 x i32> undef, <4 x i32> <i32 2, i32 undef, i32 3, i32 undef>
  %upper1 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> <i32 2, i32 undef, i32 3, i32 undef>
  %upperMul = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %upper0, <4 x i32> %upper1) readnone
  %r = shufflevector <2 x i64> %lowerMul, <2 x i64> %upperMul, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x i64> %r
}

; If we know, that the most significant half of i64 elements are zero,
; then multiplication can be simplified drastically.
; In the following example I assert a zero upper half
; by 'trunc' followed by 'zext'.
;
; the following extractelement's and insertelement's
; are just an unrolled 'trunc' plus 'zext' on a vector
; %trunc0 = trunc <2 x i64> %0 to <2 x i32>
; %trunc1 = trunc <2 x i64> %1 to <2 x i32>
; %ext0 = zext <2 x i32> %0 to <2 x i64>
; %ext1 = zext <2 x i32> %1 to <2 x i64>
define <2 x i64> @_mul2xi64toi64a(<2 x i64>, <2 x i64>) {
; SSE-LABEL: _mul2xi64toi64a:
; SSE:       # %bb.0:
; SSE-NEXT:    pmuludq %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: _mul2xi64toi64a:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %f00 = extractelement <2 x i64> %0, i32 0
  %f01 = extractelement <2 x i64> %0, i32 1
  %f10 = extractelement <2 x i64> %1, i32 0
  %f11 = extractelement <2 x i64> %1, i32 1
  %trunc00 = trunc i64 %f00 to i32
  %trunc01 = trunc i64 %f01 to i32
  %ext00 = zext i32 %trunc00 to i64
  %ext01 = zext i32 %trunc01 to i64
  %trunc10 = trunc i64 %f10 to i32
  %trunc11 = trunc i64 %f11 to i32
  %ext10 = zext i32 %trunc10 to i64
  %ext11 = zext i32 %trunc11 to i64
  %extv00 = insertelement <2 x i64> undef,   i64 %ext00, i32 0
  %extv01 = insertelement <2 x i64> %extv00, i64 %ext01, i32 1
  %extv10 = insertelement <2 x i64> undef,   i64 %ext10, i32 0
  %extv11 = insertelement <2 x i64> %extv10, i64 %ext11, i32 1
  %r = mul <2 x i64> %extv01, %extv11
  ret <2 x i64> %r
}

define <2 x i64> @_mul2xi64toi64b(<2 x i64>, <2 x i64>) {
; SSE-LABEL: _mul2xi64toi64b:
; SSE:       # %bb.0:
; SSE-NEXT:    pmuludq %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: _mul2xi64toi64b:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %f0 = bitcast <2 x i64> %0 to <4 x i32>
  %f1 = bitcast <2 x i64> %1 to <4 x i32>
  %r = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %f0, <4 x i32> %f1) readnone
  ret <2 x i64> %r
}

declare <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32>, <4 x i32>) nounwind readnone
