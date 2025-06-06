get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)

add_flang_library(HLFIRTransforms
  BufferizeHLFIR.cpp
  ConvertToFIR.cpp
  InlineElementals.cpp
  LowerHLFIRIntrinsics.cpp
  LowerHLFIROrderedAssignments.cpp
  ScheduleOrderedAssignments.cpp
  SimplifyHLFIRIntrinsics.cpp
  OptimizedBufferization.cpp

  DEPENDS
  CUFAttrsIncGen
  FIRDialect
  HLFIROpsIncGen
  ${dialect_libs}

  LINK_LIBS
  CUFAttrs
  FIRAnalysis
  FIRDialect
  FIRBuilder
  FIRDialectSupport
  FIRSupport
  FIRTransforms
  FlangOpenMPTransforms
  HLFIRDialect
  MLIRIR
  ${dialect_libs}

  LINK_COMPONENTS
  AsmParser
  AsmPrinter
  Remarks
)
