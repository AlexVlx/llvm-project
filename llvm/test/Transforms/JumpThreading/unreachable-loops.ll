; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=jump-threading -S < %s | FileCheck %s

; Check the unreachable loop won't cause infinite loop
; in jump-threading when it tries to update the predecessors'
; profile metadata from a phi node.

define void @unreachable_single_bb_loop() {
;
; CHECK-LABEL: @unreachable_single_bb_loop(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = call i32 @a()
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i32 [[TMP]], 1
; CHECK-NEXT:    br i1 [[TMP1]], label [[BB8:%.*]], label [[BB8]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ne i32 [[TMP]], 1
; CHECK-NEXT:    switch i1 [[TMP4]], label [[BB2:%.*]] [
; CHECK-NEXT:      i1 false, label [[BB8]]
; CHECK-NEXT:      i1 true, label [[BB8]]
; CHECK-NEXT:    ]
; CHECK:       bb8:
; CHECK-NEXT:    ret void
;
bb:
  %tmp = call i32 @a()
  %tmp1 = icmp eq i32 %tmp, 1
  br i1 %tmp1, label %bb5, label %bb8

; unreachable single bb loop.
bb2:                                              ; preds = %bb2
  %tmp4 = icmp ne i32 %tmp, 1
  switch i1 %tmp4, label %bb2 [
  i1 0, label %bb5
  i1 1, label %bb8
  ]

bb5:                                              ; preds = %bb2, %bb
  %tmp6 = phi i1 [ %tmp1, %bb ], [ false, %bb2 ]
  br i1 %tmp6, label %bb8, label %bb7, !prof !0

bb7:                                              ; preds = %bb5
  br label %bb8

bb8:                                              ; preds = %bb8, %bb7, %bb5, %bb2
  ret void
}

define void @unreachable_multi_bbs_loop() {
;
; CHECK-LABEL: @unreachable_multi_bbs_loop(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = call i32 @a()
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i32 [[TMP]], 1
; CHECK-NEXT:    br i1 [[TMP1]], label [[BB8:%.*]], label [[BB8]]
; CHECK:       bb3:
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ne i32 [[TMP]], 1
; CHECK-NEXT:    switch i1 [[TMP4]], label [[BB3:%.*]] [
; CHECK-NEXT:      i1 false, label [[BB8]]
; CHECK-NEXT:      i1 true, label [[BB8]]
; CHECK-NEXT:    ]
; CHECK:       bb8:
; CHECK-NEXT:    ret void
;
bb:
  %tmp = call i32 @a()
  %tmp1 = icmp eq i32 %tmp, 1
  br i1 %tmp1, label %bb5, label %bb8

; unreachable two bbs loop.
bb3:                                              ; preds = %bb2
  br label %bb2

bb2:                                              ; preds = %bb3
  %tmp4 = icmp ne i32 %tmp, 1
  switch i1 %tmp4, label %bb3 [
  i1 0, label %bb5
  i1 1, label %bb8
  ]

bb5:                                              ; preds = %bb2, %bb
  %tmp6 = phi i1 [ %tmp1, %bb ], [ false, %bb2 ]
  br i1 %tmp6, label %bb8, label %bb7, !prof !0

bb7:                                              ; preds = %bb5
  br label %bb8

bb8:                                              ; preds = %bb8, %bb7, %bb5, %bb2
  ret void
}
declare i32 @a()

; This gets into a state that could cause instruction simplify
; to hang - an insertelement instruction has itself as an operand.

define void @PR48362(i1 %arg) {
;
; CHECK-LABEL: @PR48362(
; CHECK-NEXT:  cleanup.cont1500:
; CHECK-NEXT:    unreachable
; CHECK:       if.end1733:
; CHECK-NEXT:    [[I82:%.*]] = load i32, ptr undef, align 1
; CHECK-NEXT:    [[TOBOOL1731_NOT:%.*]] = icmp eq i32 [[I82]], 0
; CHECK-NEXT:    br label [[IF_END1733:%.*]]
;
cleanup1491:                                      ; preds = %for.body1140
  switch i32 0, label %cleanup2343.loopexit4 [
  i32 0, label %cleanup.cont1500
  i32 128, label %lbl_555.loopexit
  ]

cleanup.cont1500:                                 ; preds = %cleanup1491
  unreachable

lbl_555.loopexit:                                 ; preds = %cleanup1491
  br label %for.body1509

for.body1509:                                     ; preds = %for.inc2340, %lbl_555.loopexit
  %l_580.sroa.0.0 = phi <4 x i32> [ <i32 1684658741, i32 1684658741, i32 1684658741, i32 1684658741>, %lbl_555.loopexit ], [ %l_580.sroa.0.2, %for.inc2340 ]
  %p_55.addr.10 = phi i16 [ 0, %lbl_555.loopexit ], [ %p_55.addr.11, %for.inc2340 ]
  %i82 = load i32, ptr undef, align 1
  %tobool1731.not = icmp eq i32 %i82, 0
  br i1 %tobool1731.not, label %if.end1733, label %if.then1732

if.then1732:                                      ; preds = %for.body1509
  br label %cleanup2329

if.end1733:                                       ; preds = %for.body1509
  %tobool1735.not = icmp eq i16 %p_55.addr.10, 0
  br i1 %tobool1735.not, label %if.then1736, label %if.else1904

if.then1736:                                      ; preds = %if.end1733
  br label %cleanup2329

if.else1904:                                      ; preds = %if.end1733
  br label %for.body1911

for.body1911:                                     ; preds = %if.else1904
  %l_580.sroa.0.4.vec.extract683 = extractelement <4 x i32> %l_580.sroa.0.0, i32 2
  %xor2107 = xor i32 undef, %l_580.sroa.0.4.vec.extract683
  br label %land.end2173

land.end2173:                                     ; preds = %for.body1911
  br i1 %arg, label %if.end2178, label %cleanup2297

if.end2178:                                       ; preds = %land.end2173
  %l_580.sroa.0.2.vec.insert = insertelement <4 x i32> %l_580.sroa.0.0, i32 undef, i32 1
  br label %cleanup2297

cleanup2297:                                      ; preds = %if.end2178, %land.end2173
  %l_580.sroa.0.1 = phi <4 x i32> [ %l_580.sroa.0.2.vec.insert, %if.end2178 ], [ %l_580.sroa.0.0, %land.end2173 ]
  br label %cleanup2329

cleanup2329:                                      ; preds = %cleanup2297, %if.then1736, %if.then1732
  %l_580.sroa.0.2 = phi <4 x i32> [ %l_580.sroa.0.0, %if.then1736 ], [ %l_580.sroa.0.1, %cleanup2297 ], [ %l_580.sroa.0.0, %if.then1732 ]
  %cleanup.dest.slot.11 = phi i32 [ 0, %if.then1736 ], [ undef, %cleanup2297 ], [ 129, %if.then1732 ]
  %p_55.addr.11 = phi i16 [ %p_55.addr.10, %if.then1736 ], [ undef, %cleanup2297 ], [ %p_55.addr.10, %if.then1732 ]
  switch i32 %cleanup.dest.slot.11, label %cleanup2343.loopexit [
  i32 0, label %cleanup.cont2339
  i32 129, label %crit_edge114
  ]

cleanup.cont2339:                                 ; preds = %cleanup2329
  br label %for.inc2340

for.inc2340:                                      ; preds = %cleanup.cont2339
  br i1 %arg, label %for.body1509, label %crit_edge115

crit_edge114:                                     ; preds = %cleanup2329
  unreachable

crit_edge115:                                     ; preds = %for.inc2340
  unreachable

cleanup2343.loopexit:                             ; preds = %cleanup2329
  unreachable

cleanup2343.loopexit4:                            ; preds = %cleanup1491
  unreachable
}

; This segfaults due to recursion in %C4. Reason: %L6 is identified to be a
; "partially redundant load" and is replaced by a PHI node. The PHI node is then
; simplified to be constant and is removed. This leads to %L6 being replaced by
; %C4, which makes %C4 invalid since it uses %L6.
; The test case has been generated by the AMD Fuzzing project and simplified
; manually and by llvm-reduce.

define i32 @constant_phi_leads_to_self_reference(ptr %ptr) {
; CHECK-LABEL: @constant_phi_leads_to_self_reference(
; CHECK-NEXT:    [[A9:%.*]] = alloca i1, align 1
; CHECK-NEXT:    br label [[F6:%.*]]
; CHECK:       T3:
; CHECK-NEXT:    br label [[BB5:%.*]]
; CHECK:       BB5:
; CHECK-NEXT:    [[L10:%.*]] = load i1, ptr [[A9]], align 1
; CHECK-NEXT:    br i1 [[L10]], label [[BB6:%.*]], label [[F6]]
; CHECK:       BB6:
; CHECK-NEXT:    [[LGV3:%.*]] = load i1, ptr [[PTR:%.*]], align 1
; CHECK-NEXT:    [[C4:%.*]] = icmp sle i1 [[C4]], true
; CHECK-NEXT:    store i1 [[C4]], ptr [[PTR]], align 1
; CHECK-NEXT:    br i1 [[C4]], label [[F6]], label [[T3:%.*]]
; CHECK:       F6:
; CHECK-NEXT:    ret i32 0
; CHECK:       F7:
; CHECK-NEXT:    br label [[BB5]]
;
  %A9 = alloca i1, align 1
  br i1 false, label %BB4, label %F6

BB4:                                              ; preds = %0
  br i1 false, label %F6, label %F1

F1:                                               ; preds = %BB4
  br i1 false, label %T4, label %T3

T3:                                               ; preds = %T4, %BB6, %F1
  %L6 = load i1, ptr %ptr, align 1
  br label %BB5

BB5:                                              ; preds = %F7, %T3
  %L10 = load i1, ptr %A9, align 1
  br i1 %L10, label %BB6, label %F6

BB6:                                              ; preds = %BB5
  %LGV3 = load i1, ptr %ptr, align 1
  %C4 = icmp sle i1 %L6, true
  store i1 %C4, ptr %ptr, align 1
  br i1 %L6, label %F6, label %T3

T4:                                               ; preds = %F1
  br label %T3

F6:                                               ; preds = %BB6, %BB5, %BB4, %0
  ret i32 0

F7:                                               ; No predecessors!
  br label %BB5
}

; Same as above, but with multiple icmps referencing the same PHI node.

define i32 @recursive_icmp_mult(ptr %ptr) {
; CHECK-LABEL: @recursive_icmp_mult(
; CHECK-NEXT:    [[A9:%.*]] = alloca i1, align 1
; CHECK-NEXT:    br label [[F6:%.*]]
; CHECK:       T3:
; CHECK-NEXT:    br label [[BB5:%.*]]
; CHECK:       BB5:
; CHECK-NEXT:    [[L10:%.*]] = load i1, ptr [[A9]], align 1
; CHECK-NEXT:    br i1 [[L10]], label [[BB6:%.*]], label [[F6]]
; CHECK:       BB6:
; CHECK-NEXT:    [[LGV3:%.*]] = load i1, ptr [[PTR:%.*]], align 1
; CHECK-NEXT:    [[C4:%.*]] = icmp sle i1 [[C6:%.*]], true
; CHECK-NEXT:    [[C5:%.*]] = icmp sle i1 [[C6]], false
; CHECK-NEXT:    [[C6]] = icmp sle i1 [[C4]], [[C5]]
; CHECK-NEXT:    store i1 [[C6]], ptr [[PTR]], align 1
; CHECK-NEXT:    br i1 [[C6]], label [[F6]], label [[T3:%.*]]
; CHECK:       F6:
; CHECK-NEXT:    ret i32 0
; CHECK:       F7:
; CHECK-NEXT:    br label [[BB5]]
;
  %A9 = alloca i1, align 1
  br i1 false, label %BB4, label %F6

BB4:                                              ; preds = %0
  br i1 false, label %F6, label %F1

F1:                                               ; preds = %BB4
  br i1 false, label %T4, label %T3

T3:                                               ; preds = %T4, %BB6, %F1
  %L6 = load i1, ptr %ptr, align 1
  br label %BB5

BB5:                                              ; preds = %F7, %T3
  %L10 = load i1, ptr %A9, align 1
  br i1 %L10, label %BB6, label %F6

BB6:                                              ; preds = %BB5
  %LGV3 = load i1, ptr %ptr, align 1
  %C4 = icmp sle i1 %L6, true
  %C5 = icmp sle i1 %L6, false
  %C6 = icmp sle i1 %C4, %C5
  store i1 %C6, ptr %ptr, align 1
  br i1 %L6, label %F6, label %T3

T4:                                               ; preds = %F1
  br label %T3

F6:                                               ; preds = %BB6, %BB5, %BB4, %0
  ret i32 0

F7:                                               ; No predecessors!
  br label %BB5
}

!0 = !{!"branch_weights", i32 2146410443, i32 1073205}
