#include <cuda.h>
#include <stdio.h>
#include <ATen/ATen.h>
#include <cute/tensor.hpp>
#include "qgemm_kernel.hpp"


template <
  typename SMs,
  typename T,
  typename TQ,
  typename T2,
  typename NumBits,
  typename GroupSize
>
void
_qgemm(int M,
       int N,
       int K,
       int P,
       const T * const __restrict__ A,
       const TQ* const __restrict__ Q,
             T *       __restrict__ D,
       const T * const __restrict__ S,
       const T * const __restrict__ QM,
       const T2* const __restrict__ QM2,
           void*       __restrict__ workspace,
       const cudaStream_t           stream)
{

    using namespace cute;
    static constexpr config::QuantMapModeEnum      kVectorized    = config::QuantMapModeEnum     ::Vectorized;
    static constexpr config::QuantMapModeEnum      kVectorized_32 = config::QuantMapModeEnum     ::Vectorized_32;
    static constexpr config::QuantMapModeEnum      kVectorized_16 = config::QuantMapModeEnum     ::Vectorized_16;
    static constexpr config::QuantMapModeEnum      kVectorized_8  = config::QuantMapModeEnum     ::Vectorized_8;
    static constexpr config::QuantMapModeEnum      kMarlin        = config::QuantMapModeEnum     ::Marlin;
    static constexpr config::AccumulationModeEnum  kLow           = config::AccumulationModeEnum ::Low;
    static constexpr config::AccumulationModeEnum  kHigh          = config::AccumulationModeEnum ::High;
    static constexpr config::AccumulationModeEnum  kMixed         = config::AccumulationModeEnum ::Mixed;
    static constexpr config::DecompositionModeEnum kStreamK       = config::DecompositionModeEnum::StreamK;

#define RUN_QGEMM(T,                           \
                  TQ,                          \
                  T2,                          \
                  SLICES,                      \
                  BLOCKS,                      \
                  THREADS,                     \
                  TILE_M,                      \
                  TILE_K,                      \
                  TILE_P,                      \
                  STAGES,                      \
                  NUM_BITS,                    \
                  GROUP_SIZE,                  \
                  QUANT_MAP_MODE,              \
                  ACCUMULATION_MODE,           \
                  DECOMPOSITION_MODE,          \
                  G2S_TILED_COPY_SIZE_S,       \
                  MMA_PRM_K)                   \
    do {                                       \
        qgemm_host<                            \
            T,                                 \
            TQ,                                \
            T2,                                \
            cute::Int<SLICES>,                 \
            cute::Int<BLOCKS>,                 \
            cute::Int<THREADS>,                \
            cute::Int<TILE_M>,                 \
            cute::Int<TILE_K>,                 \
            cute::Int<TILE_P>,                 \
            cute::Int<STAGES>,                 \
            cute::Int<NUM_BITS>,               \
            cute::Int<GROUP_SIZE>,             \
            QUANT_MAP_MODE,                    \
            ACCUMULATION_MODE,                 \
            DECOMPOSITION_MODE,                \
            cute::Int<G2S_TILED_COPY_SIZE_S>,  \
            cute::Int<MMA_PRM_K>               \
        > (                                    \
            M,                                 \
            N,                                 \
            K,                                 \
            P,                                 \
            A,                                 \
            Q,                                 \
            D,                                 \
            S,                                 \
            QM,                                \
            QM2,                               \
            workspace,                         \
            stream);                           \
    } while (false)

    // Generated Code Below
    if constexpr (cute::is_same_v<SMs, cute::Int<84>>)
    {
        if constexpr (cute::is_same_v<NumBits, cute::Int<3>>)
        {
            if constexpr (cute::is_same_v<GroupSize, cute::Int<32>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 256, 32, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<64>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<128>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<256>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else
            {
                AT_ERROR("Unsupported GroupSize value");
            }
        }
        else if constexpr (cute::is_same_v<NumBits, cute::Int<4>>)
        {
            if constexpr (cute::is_same_v<GroupSize, cute::Int<32>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<64>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<128>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<256>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else
            {
                AT_ERROR("Unsupported GroupSize value");
            }
        }
        else
        {
            AT_ERROR("Unsupported NumBits value");
        }
    }
    else if constexpr (cute::is_same_v<SMs, cute::Int<108>>)
    {
        if constexpr (cute::is_same_v<NumBits, cute::Int<3>>)
        {
            if constexpr (cute::is_same_v<GroupSize, cute::Int<32>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<64>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<128>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<256>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else
            {
                AT_ERROR("Unsupported GroupSize value");
            }
        }
        else if constexpr (cute::is_same_v<NumBits, cute::Int<4>>)
        {
            if constexpr (cute::is_same_v<GroupSize, cute::Int<32>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_32, kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 2, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<64>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<128>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else if constexpr (cute::is_same_v<GroupSize, cute::Int<256>>)
            {
                switch (N)
                {
                case 1024:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 1 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2048:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 2560:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 3584:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4096:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized_16, kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 4608:
                    switch (K)
                    {
                    case 1024:
                        RUN_QGEMM(T, TQ, T2, 0, 2 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 9216:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 18432:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 36864:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 5120:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 6144:
                    switch (K)
                    {
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 7168:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 8192:
                    switch (K)
                    {
                    case 2048:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized_8 , kMixed, kStreamK, 2, 1);
                        break;
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 7168:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 14336:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 28672:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 10240:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 14336:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 4, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 18432:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 28672:
                    switch (K)
                    {
                    case 3584:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 4096:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 5, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 36864:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 57344:
                    switch (K)
                    {
                    case 8192:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                case 73728:
                    switch (K)
                    {
                    case 4608:
                        RUN_QGEMM(T, TQ, T2, 0, 4 * SMs::value, 128, 16, 64, 32, 3, NumBits::value, GroupSize::value, kVectorized   , kMixed, kStreamK, 2, 1);
                        break;
                    default:
                        AT_ERROR("Unsupported K value");
                    }
                    break;
                default:
                    AT_ERROR("Unsupported N value");
                }
            }
            else
            {
                AT_ERROR("Unsupported GroupSize value");
            }
        }
        else
        {
            AT_ERROR("Unsupported NumBits value");
        }
    }
    else
    {
        AT_ERROR("Unsupported SMs value");
    }
}


#define INSTANTIATE_TEMPLATE(SMS,                \
                             T,                  \
                             TQ,                 \
                             T2,                 \
                             NUM_BITS,           \
                             GROUP_SIZE)         \
    template                                     \
    void                                         \
    _qgemm<                                      \
        cute::Int<SMS>,                          \
        T,                                       \
        TQ,                                      \
        T2,                                      \
        cute::Int<NUM_BITS>,                     \
        cute::Int<GROUP_SIZE>                    \
    > (                                          \
        int M,                                   \
        int N,                                   \
        int K,                                   \
        int P,                                   \
        const T * const __restrict__ A,          \
        const TQ* const __restrict__ Q,          \
              T *       __restrict__ D,          \
        const T * const __restrict__ S,          \
        const T * const __restrict__ QM,         \
        const T2* const __restrict__ QM2,        \
            void*       __restrict__ workspace,  \
        const cudaStream_t           stream)


INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 2, 32);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 2, 64);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 2, 128);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 2, 256);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 3, 32);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 3, 64);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 3, 128);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 3, 256);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 4, 32);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 4, 64);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 4, 128);
INSTANTIATE_TEMPLATE(84 , cute::half_t    , cute::uint16_t, __half2       , 4, 256);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 2, 32);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 2, 64);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 2, 128);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 2, 256);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 3, 32);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 3, 64);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 3, 128);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 3, 256);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 4, 32);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 4, 64);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 4, 128);
INSTANTIATE_TEMPLATE(108, cute::half_t    , cute::uint16_t, __half2       , 4, 256);

INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 32);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 64);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 128);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 256);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 32);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 64);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 128);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 256);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 32);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 64);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 128);
INSTANTIATE_TEMPLATE(84 , cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 256);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 32);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 64);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 128);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 2, 256);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 32);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 64);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 128);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 3, 256);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 32);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 64);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 128);
INSTANTIATE_TEMPLATE(108, cute::bfloat16_t, cute::uint16_t, __nv_bfloat162, 4, 256);
