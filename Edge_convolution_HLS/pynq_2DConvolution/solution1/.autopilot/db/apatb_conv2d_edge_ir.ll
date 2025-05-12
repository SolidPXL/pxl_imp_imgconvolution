; ModuleID = 'C:/DevWorks/HAC/pynq_2DConvolution/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_uint<8>" = type { %"struct.ap_int_base<8, false>" }
%"struct.ap_int_base<8, false>" = type { %"struct.ssdm_int<8, false>" }
%"struct.ssdm_int<8, false>" = type { i8 }

; Function Attrs: noinline
define void @apatb_conv2d_edge_ir([256 x %"struct.ap_uint<8>"]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="256" "maxi" %input, [254 x %"struct.ap_uint<8>"]* noalias nocapture nonnull "fpga.decayed.dim.hint"="254" "maxi" %output) local_unnamed_addr #0 {
entry:
  %malloccall = call i8* @malloc(i64 65536)
  %input_copy = bitcast i8* %malloccall to [256 x [256 x i8]]*
  %malloccall1 = call i8* @malloc(i64 64516)
  %output_copy = bitcast i8* %malloccall1 to [254 x [254 x i8]]*
  %0 = bitcast [256 x %"struct.ap_uint<8>"]* %input to [256 x [256 x %"struct.ap_uint<8>"]]*
  %1 = bitcast [254 x %"struct.ap_uint<8>"]* %output to [254 x [254 x %"struct.ap_uint<8>"]]*
  call fastcc void @copy_in([256 x [256 x %"struct.ap_uint<8>"]]* nonnull %0, [256 x [256 x i8]]* %input_copy, [254 x [254 x %"struct.ap_uint<8>"]]* nonnull %1, [254 x [254 x i8]]* %output_copy)
  call void @apatb_conv2d_edge_hw([256 x [256 x i8]]* %input_copy, [254 x [254 x i8]]* %output_copy)
  call void @copy_back([256 x [256 x %"struct.ap_uint<8>"]]* %0, [256 x [256 x i8]]* %input_copy, [254 x [254 x %"struct.ap_uint<8>"]]* %1, [254 x [254 x i8]]* %output_copy)
  call void @free(i8* %malloccall)
  call void @free(i8* %malloccall1)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([256 x [256 x %"struct.ap_uint<8>"]]* noalias readonly, [256 x [256 x i8]]* noalias, [254 x [254 x %"struct.ap_uint<8>"]]* noalias readonly, [254 x [254 x i8]]* noalias) unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a256a256struct.ap_uint<8>.20"([256 x [256 x i8]]* %1, [256 x [256 x %"struct.ap_uint<8>"]]* %0)
  call fastcc void @"onebyonecpy_hls.p0a254a254struct.ap_uint<8>"([254 x [254 x i8]]* %3, [254 x [254 x %"struct.ap_uint<8>"]]* %2)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a256a256struct.ap_uint<8>"([256 x [256 x %"struct.ap_uint<8>"]]* noalias %dst, [256 x [256 x i8]]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [256 x [256 x %"struct.ap_uint<8>"]]* %dst, null
  %1 = icmp eq [256 x [256 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a256a256struct.ap_uint<8>"([256 x [256 x %"struct.ap_uint<8>"]]* nonnull %dst, [256 x [256 x i8]]* nonnull %src, i64 256)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a256a256struct.ap_uint<8>"([256 x [256 x %"struct.ap_uint<8>"]]* %dst, [256 x [256 x i8]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [256 x [256 x i8]]* %src, null
  %1 = icmp eq [256 x [256 x %"struct.ap_uint<8>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [256 x [256 x %"struct.ap_uint<8>"]], [256 x [256 x %"struct.ap_uint<8>"]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [256 x [256 x i8]], [256 x [256 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a256struct.ap_uint<8>"([256 x %"struct.ap_uint<8>"]* %dst.addr, [256 x i8]* %3, i64 256)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a256struct.ap_uint<8>"([256 x %"struct.ap_uint<8>"]* %dst, [256 x i8]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [256 x i8]* %src, null
  %1 = icmp eq [256 x %"struct.ap_uint<8>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [256 x i8], [256 x i8]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [256 x %"struct.ap_uint<8>"], [256 x %"struct.ap_uint<8>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i8, i8* %3, align 1
  store i8 %4, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a254a254struct.ap_uint<8>"([254 x [254 x i8]]* noalias %dst, [254 x [254 x %"struct.ap_uint<8>"]]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [254 x [254 x i8]]* %dst, null
  %1 = icmp eq [254 x [254 x %"struct.ap_uint<8>"]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a254a254struct.ap_uint<8>"([254 x [254 x i8]]* nonnull %dst, [254 x [254 x %"struct.ap_uint<8>"]]* nonnull %src, i64 254)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a254a254struct.ap_uint<8>"([254 x [254 x i8]]* %dst, [254 x [254 x %"struct.ap_uint<8>"]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [254 x [254 x %"struct.ap_uint<8>"]]* %src, null
  %1 = icmp eq [254 x [254 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [254 x [254 x i8]], [254 x [254 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [254 x [254 x %"struct.ap_uint<8>"]], [254 x [254 x %"struct.ap_uint<8>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a254struct.ap_uint<8>"([254 x i8]* %3, [254 x %"struct.ap_uint<8>"]* %src.addr, i64 254)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a254struct.ap_uint<8>"([254 x i8]* %dst, [254 x %"struct.ap_uint<8>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [254 x %"struct.ap_uint<8>"]* %src, null
  %1 = icmp eq [254 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [254 x %"struct.ap_uint<8>"], [254 x %"struct.ap_uint<8>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [254 x i8], [254 x i8]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %4, i8* %3, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([256 x [256 x %"struct.ap_uint<8>"]]* noalias, [256 x [256 x i8]]* noalias readonly, [254 x [254 x %"struct.ap_uint<8>"]]* noalias, [254 x [254 x i8]]* noalias readonly) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a256a256struct.ap_uint<8>"([256 x [256 x %"struct.ap_uint<8>"]]* %0, [256 x [256 x i8]]* %1)
  call fastcc void @"onebyonecpy_hls.p0a254a254struct.ap_uint<8>.6"([254 x [254 x %"struct.ap_uint<8>"]]* %2, [254 x [254 x i8]]* %3)
  ret void
}

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a254a254struct.ap_uint<8>.6"([254 x [254 x %"struct.ap_uint<8>"]]* noalias %dst, [254 x [254 x i8]]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [254 x [254 x %"struct.ap_uint<8>"]]* %dst, null
  %1 = icmp eq [254 x [254 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a254a254struct.ap_uint<8>.9"([254 x [254 x %"struct.ap_uint<8>"]]* nonnull %dst, [254 x [254 x i8]]* nonnull %src, i64 254)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a254a254struct.ap_uint<8>.9"([254 x [254 x %"struct.ap_uint<8>"]]* %dst, [254 x [254 x i8]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [254 x [254 x i8]]* %src, null
  %1 = icmp eq [254 x [254 x %"struct.ap_uint<8>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [254 x [254 x %"struct.ap_uint<8>"]], [254 x [254 x %"struct.ap_uint<8>"]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [254 x [254 x i8]], [254 x [254 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a254struct.ap_uint<8>.12"([254 x %"struct.ap_uint<8>"]* %dst.addr, [254 x i8]* %3, i64 254)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a254struct.ap_uint<8>.12"([254 x %"struct.ap_uint<8>"]* %dst, [254 x i8]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [254 x i8]* %src, null
  %1 = icmp eq [254 x %"struct.ap_uint<8>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [254 x i8], [254 x i8]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [254 x %"struct.ap_uint<8>"], [254 x %"struct.ap_uint<8>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i8, i8* %3, align 1
  store i8 %4, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a256a256struct.ap_uint<8>.20"([256 x [256 x i8]]* noalias %dst, [256 x [256 x %"struct.ap_uint<8>"]]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [256 x [256 x i8]]* %dst, null
  %1 = icmp eq [256 x [256 x %"struct.ap_uint<8>"]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a256a256struct.ap_uint<8>.23"([256 x [256 x i8]]* nonnull %dst, [256 x [256 x %"struct.ap_uint<8>"]]* nonnull %src, i64 256)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a256a256struct.ap_uint<8>.23"([256 x [256 x i8]]* %dst, [256 x [256 x %"struct.ap_uint<8>"]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [256 x [256 x %"struct.ap_uint<8>"]]* %src, null
  %1 = icmp eq [256 x [256 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [256 x [256 x i8]], [256 x [256 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [256 x [256 x %"struct.ap_uint<8>"]], [256 x [256 x %"struct.ap_uint<8>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a256struct.ap_uint<8>.26"([256 x i8]* %3, [256 x %"struct.ap_uint<8>"]* %src.addr, i64 256)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a256struct.ap_uint<8>.26"([256 x i8]* %dst, [256 x %"struct.ap_uint<8>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [256 x %"struct.ap_uint<8>"]* %src, null
  %1 = icmp eq [256 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [256 x %"struct.ap_uint<8>"], [256 x %"struct.ap_uint<8>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [256 x i8], [256 x i8]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %4, i8* %3, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @apatb_conv2d_edge_hw([256 x [256 x i8]]*, [254 x [254 x i8]]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([256 x [256 x %"struct.ap_uint<8>"]]* noalias, [256 x [256 x i8]]* noalias readonly, [254 x [254 x %"struct.ap_uint<8>"]]* noalias, [254 x [254 x i8]]* noalias readonly) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a254a254struct.ap_uint<8>.6"([254 x [254 x %"struct.ap_uint<8>"]]* %2, [254 x [254 x i8]]* %3)
  ret void
}

define void @conv2d_edge_hw_stub_wrapper([256 x [256 x i8]]*, [254 x [254 x i8]]*) #5 {
entry:
  %malloccall = tail call i8* @malloc(i64 65536)
  %2 = bitcast i8* %malloccall to [256 x [256 x %"struct.ap_uint<8>"]]*
  %malloccall1 = tail call i8* @malloc(i64 64516)
  %3 = bitcast i8* %malloccall1 to [254 x [254 x %"struct.ap_uint<8>"]]*
  call void @copy_out([256 x [256 x %"struct.ap_uint<8>"]]* %2, [256 x [256 x i8]]* %0, [254 x [254 x %"struct.ap_uint<8>"]]* %3, [254 x [254 x i8]]* %1)
  %4 = bitcast [256 x [256 x %"struct.ap_uint<8>"]]* %2 to [256 x %"struct.ap_uint<8>"]*
  %5 = bitcast [254 x [254 x %"struct.ap_uint<8>"]]* %3 to [254 x %"struct.ap_uint<8>"]*
  call void @conv2d_edge_hw_stub([256 x %"struct.ap_uint<8>"]* %4, [254 x %"struct.ap_uint<8>"]* %5)
  call void @copy_in([256 x [256 x %"struct.ap_uint<8>"]]* %2, [256 x [256 x i8]]* %0, [254 x [254 x %"struct.ap_uint<8>"]]* %3, [254 x [254 x i8]]* %1)
  ret void
}

declare void @conv2d_edge_hw_stub([256 x %"struct.ap_uint<8>"]* noalias nocapture nonnull readonly, [254 x %"struct.ap_uint<8>"]* noalias nocapture nonnull)

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
