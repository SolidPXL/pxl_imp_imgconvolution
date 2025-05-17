; ModuleID = 'C:/DevWorks/HAC/pynq_pooling/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_uint<8>" = type { %"struct.ap_int_base<8, false>" }
%"struct.ap_int_base<8, false>" = type { %"struct.ssdm_int<8, false>" }
%"struct.ssdm_int<8, false>" = type { i8 }

; Function Attrs: noinline
define void @apatb_image_pooling_ir(%"struct.ap_uint<8>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="65536" "maxi" %src, %"struct.ap_uint<8>"* noalias nocapture nonnull "fpga.decayed.dim.hint"="16384" "maxi" %dst_min, %"struct.ap_uint<8>"* noalias nocapture nonnull "fpga.decayed.dim.hint"="16384" "maxi" %dst_max) local_unnamed_addr #0 {
entry:
  %malloccall = call i8* @malloc(i64 65536)
  %src_copy = bitcast i8* %malloccall to [65536 x i8]*
  %malloccall1 = call i8* @malloc(i64 16384)
  %dst_min_copy = bitcast i8* %malloccall1 to [16384 x i8]*
  %malloccall2 = call i8* @malloc(i64 16384)
  %dst_max_copy = bitcast i8* %malloccall2 to [16384 x i8]*
  %0 = bitcast %"struct.ap_uint<8>"* %src to [65536 x %"struct.ap_uint<8>"]*
  %1 = bitcast %"struct.ap_uint<8>"* %dst_min to [16384 x %"struct.ap_uint<8>"]*
  %2 = bitcast %"struct.ap_uint<8>"* %dst_max to [16384 x %"struct.ap_uint<8>"]*
  call fastcc void @copy_in([65536 x %"struct.ap_uint<8>"]* nonnull %0, [65536 x i8]* %src_copy, [16384 x %"struct.ap_uint<8>"]* nonnull %1, [16384 x i8]* %dst_min_copy, [16384 x %"struct.ap_uint<8>"]* nonnull %2, [16384 x i8]* %dst_max_copy)
  call void @apatb_image_pooling_hw([65536 x i8]* %src_copy, [16384 x i8]* %dst_min_copy, [16384 x i8]* %dst_max_copy)
  call void @copy_back([65536 x %"struct.ap_uint<8>"]* %0, [65536 x i8]* %src_copy, [16384 x %"struct.ap_uint<8>"]* %1, [16384 x i8]* %dst_min_copy, [16384 x %"struct.ap_uint<8>"]* %2, [16384 x i8]* %dst_max_copy)
  call void @free(i8* %malloccall)
  call void @free(i8* %malloccall1)
  call void @free(i8* %malloccall2)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([65536 x %"struct.ap_uint<8>"]* noalias readonly "unpacked"="0", [65536 x i8]* noalias nocapture "unpacked"="1.0", [16384 x %"struct.ap_uint<8>"]* noalias readonly "unpacked"="2", [16384 x i8]* noalias nocapture "unpacked"="3.0", [16384 x %"struct.ap_uint<8>"]* noalias readonly "unpacked"="4", [16384 x i8]* noalias nocapture "unpacked"="5.0") unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a65536struct.ap_uint<8>"([65536 x i8]* %1, [65536 x %"struct.ap_uint<8>"]* %0)
  call fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>.14"([16384 x i8]* %3, [16384 x %"struct.ap_uint<8>"]* %2)
  call fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>.14"([16384 x i8]* %5, [16384 x %"struct.ap_uint<8>"]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a65536struct.ap_uint<8>"([65536 x i8]* noalias nocapture "unpacked"="0.0" %dst, [65536 x %"struct.ap_uint<8>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [65536 x %"struct.ap_uint<8>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a65536struct.ap_uint<8>"([65536 x i8]* %dst, [65536 x %"struct.ap_uint<8>"]* nonnull %src, i64 65536)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a65536struct.ap_uint<8>"([65536 x i8]* nocapture "unpacked"="0.0" %dst, [65536 x %"struct.ap_uint<8>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [65536 x %"struct.ap_uint<8>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [65536 x %"struct.ap_uint<8>"], [65536 x %"struct.ap_uint<8>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [65536 x i8], [65536 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %1, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16384struct.ap_uint<8>"([16384 x %"struct.ap_uint<8>"]* %dst, [16384 x %"struct.ap_uint<8>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16384 x %"struct.ap_uint<8>"]* %src, null
  %1 = icmp eq [16384 x %"struct.ap_uint<8>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16384 x %"struct.ap_uint<8>"], [16384 x %"struct.ap_uint<8>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [16384 x %"struct.ap_uint<8>"], [16384 x %"struct.ap_uint<8>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %3, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([65536 x %"struct.ap_uint<8>"]* noalias "unpacked"="0", [65536 x i8]* noalias nocapture readonly "unpacked"="1.0", [16384 x %"struct.ap_uint<8>"]* noalias "unpacked"="2", [16384 x i8]* noalias nocapture readonly "unpacked"="3.0", [16384 x %"struct.ap_uint<8>"]* noalias "unpacked"="4", [16384 x i8]* noalias nocapture readonly "unpacked"="5.0") unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a65536struct.ap_uint<8>.25"([65536 x %"struct.ap_uint<8>"]* %0, [65536 x i8]* %1)
  call fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>"([16384 x %"struct.ap_uint<8>"]* %2, [16384 x i8]* %3)
  call fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>"([16384 x %"struct.ap_uint<8>"]* %4, [16384 x i8]* %5)
  ret void
}

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>"([16384 x %"struct.ap_uint<8>"]* noalias "unpacked"="0" %dst, [16384 x i8]* noalias nocapture readonly "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16384 x %"struct.ap_uint<8>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16384struct.ap_uint<8>.10"([16384 x %"struct.ap_uint<8>"]* nonnull %dst, [16384 x i8]* %src, i64 16384)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16384struct.ap_uint<8>.10"([16384 x %"struct.ap_uint<8>"]* "unpacked"="0" %dst, [16384 x i8]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16384 x %"struct.ap_uint<8>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16384 x i8], [16384 x i8]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [16384 x %"struct.ap_uint<8>"], [16384 x %"struct.ap_uint<8>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %1, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>.14"([16384 x i8]* noalias nocapture "unpacked"="0.0" %dst, [16384 x %"struct.ap_uint<8>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16384 x %"struct.ap_uint<8>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16384struct.ap_uint<8>.17"([16384 x i8]* %dst, [16384 x %"struct.ap_uint<8>"]* nonnull %src, i64 16384)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16384struct.ap_uint<8>.17"([16384 x i8]* nocapture "unpacked"="0.0" %dst, [16384 x %"struct.ap_uint<8>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16384 x %"struct.ap_uint<8>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16384 x %"struct.ap_uint<8>"], [16384 x %"struct.ap_uint<8>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [16384 x i8], [16384 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %1, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a65536struct.ap_uint<8>.25"([65536 x %"struct.ap_uint<8>"]* noalias "unpacked"="0" %dst, [65536 x i8]* noalias nocapture readonly "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [65536 x %"struct.ap_uint<8>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a65536struct.ap_uint<8>.28"([65536 x %"struct.ap_uint<8>"]* nonnull %dst, [65536 x i8]* %src, i64 65536)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a65536struct.ap_uint<8>.28"([65536 x %"struct.ap_uint<8>"]* "unpacked"="0" %dst, [65536 x i8]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [65536 x %"struct.ap_uint<8>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [65536 x i8], [65536 x i8]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [65536 x %"struct.ap_uint<8>"], [65536 x %"struct.ap_uint<8>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %1, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @apatb_image_pooling_hw([65536 x i8]*, [16384 x i8]*, [16384 x i8]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([65536 x %"struct.ap_uint<8>"]* noalias "unpacked"="0", [65536 x i8]* noalias nocapture readonly "unpacked"="1.0", [16384 x %"struct.ap_uint<8>"]* noalias "unpacked"="2", [16384 x i8]* noalias nocapture readonly "unpacked"="3.0", [16384 x %"struct.ap_uint<8>"]* noalias "unpacked"="4", [16384 x i8]* noalias nocapture readonly "unpacked"="5.0") unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>"([16384 x %"struct.ap_uint<8>"]* %2, [16384 x i8]* %3)
  call fastcc void @"onebyonecpy_hls.p0a16384struct.ap_uint<8>"([16384 x %"struct.ap_uint<8>"]* %4, [16384 x i8]* %5)
  ret void
}

define void @image_pooling_hw_stub_wrapper([65536 x i8]*, [16384 x i8]*, [16384 x i8]*) #5 {
entry:
  %malloccall = tail call i8* @malloc(i64 65536)
  %3 = bitcast i8* %malloccall to [65536 x %"struct.ap_uint<8>"]*
  %malloccall1 = tail call i8* @malloc(i64 16384)
  %4 = bitcast i8* %malloccall1 to [16384 x %"struct.ap_uint<8>"]*
  %malloccall2 = tail call i8* @malloc(i64 16384)
  %5 = bitcast i8* %malloccall2 to [16384 x %"struct.ap_uint<8>"]*
  call void @copy_out([65536 x %"struct.ap_uint<8>"]* %3, [65536 x i8]* %0, [16384 x %"struct.ap_uint<8>"]* %4, [16384 x i8]* %1, [16384 x %"struct.ap_uint<8>"]* %5, [16384 x i8]* %2)
  %6 = bitcast [65536 x %"struct.ap_uint<8>"]* %3 to %"struct.ap_uint<8>"*
  %7 = bitcast [16384 x %"struct.ap_uint<8>"]* %4 to %"struct.ap_uint<8>"*
  %8 = bitcast [16384 x %"struct.ap_uint<8>"]* %5 to %"struct.ap_uint<8>"*
  call void @image_pooling_hw_stub(%"struct.ap_uint<8>"* %6, %"struct.ap_uint<8>"* %7, %"struct.ap_uint<8>"* %8)
  call void @copy_in([65536 x %"struct.ap_uint<8>"]* %3, [65536 x i8]* %0, [16384 x %"struct.ap_uint<8>"]* %4, [16384 x i8]* %1, [16384 x %"struct.ap_uint<8>"]* %5, [16384 x i8]* %2)
  ret void
}

declare void @image_pooling_hw_stub(%"struct.ap_uint<8>"* noalias nocapture nonnull readonly, %"struct.ap_uint<8>"* noalias nocapture nonnull, %"struct.ap_uint<8>"* noalias nocapture nonnull)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
