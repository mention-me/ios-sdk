//
//  CryptoSwift
//
//  Copyright (C) 2014-2017 Marcin Krzyżanowski <marcin@krzyzanowskim.com>
//  This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//  - The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation is required.
//  - Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
//  - This notice may not be removed or altered from any source or binary distribution.
//

public final class MD5: DigestType {
  static let blockSize: Int = 64
  static let digestLength: Int = 16  // 128 / 8
  fileprivate static let hashInitialValue: [UInt32] = [
    0x6745_2301, 0xefcd_ab89, 0x98ba_dcfe, 0x1032_5476,
  ]

  fileprivate var accumulated = [UInt8]()
  fileprivate var processedBytesTotalCount: Int = 0
  fileprivate var accumulatedHash: [UInt32] = MD5.hashInitialValue

  /** specifies the per-round shift amounts */
  private let s: [UInt32] = [
    7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
    5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20,
    4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
    6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
  ]

  /** binary integer part of the sines of integers (Radians) */
  private let k: [UInt32] = [
    0xd76a_a478, 0xe8c7_b756, 0x2420_70db, 0xc1bd_ceee,
    0xf57c_0faf, 0x4787_c62a, 0xa830_4613, 0xfd46_9501,
    0x6980_98d8, 0x8b44_f7af, 0xffff_5bb1, 0x895c_d7be,
    0x6b90_1122, 0xfd98_7193, 0xa679_438e, 0x49b4_0821,
    0xf61e_2562, 0xc040_b340, 0x265e_5a51, 0xe9b6_c7aa,
    0xd62f_105d, 0x2441453, 0xd8a1_e681, 0xe7d3_fbc8,
    0x21e1_cde6, 0xc337_07d6, 0xf4d5_0d87, 0x455a_14ed,
    0xa9e3_e905, 0xfcef_a3f8, 0x676f_02d9, 0x8d2a_4c8a,
    0xfffa_3942, 0x8771_f681, 0x6d9d_6122, 0xfde5_380c,
    0xa4be_ea44, 0x4bde_cfa9, 0xf6bb_4b60, 0xbebf_bc70,
    0x289b_7ec6, 0xeaa1_27fa, 0xd4ef_3085, 0x4881d05,
    0xd9d4_d039, 0xe6db_99e5, 0x1fa2_7cf8, 0xc4ac_5665,
    0xf429_2244, 0x432a_ff97, 0xab94_23a7, 0xfc93_a039,
    0x655b_59c3, 0x8f0c_cc92, 0xffef_f47d, 0x8584_5dd1,
    0x6fa8_7e4f, 0xfe2c_e6e0, 0xa301_4314, 0x4e08_11a1,
    0xf753_7e82, 0xbd3a_f235, 0x2ad7_d2bb, 0xeb86_d391,
  ]

  public init() {
  }

  public func calculate(for bytes: [UInt8]) -> [UInt8] {
    do {
      return try update(withBytes: bytes.slice, isLast: true)
    } catch {
      fatalError()
    }
  }

  // mutating currentHash in place is way faster than returning new result
  fileprivate func process(block chunk: ArraySlice<UInt8>, currentHash: inout [UInt32]) {
    assert(chunk.count == 16 * 4)

    // Initialize hash value for this chunk:
    var A: UInt32 = currentHash[0]
    var B: UInt32 = currentHash[1]
    var C: UInt32 = currentHash[2]
    var D: UInt32 = currentHash[3]

    var dTemp: UInt32 = 0

    // Main loop
    for j in 0..<k.count {
      var g = 0
      var F: UInt32 = 0

      switch j {
      case 0...15:
        F = (B & C) | ((~B) & D)
        g = j
        break
      case 16...31:
        F = (D & B) | (~D & C)
        g = (5 * j + 1) % 16
        break
      case 32...47:
        F = B ^ C ^ D
        g = (3 * j + 5) % 16
        break
      case 48...63:
        F = C ^ (B | (~D))
        g = (7 * j) % 16
        break
      default:
        break
      }
      dTemp = D
      D = C
      C = B

      // break chunk into sixteen 32-bit words M[j], 0 ≤ j ≤ 15 and get M[g] value
      let gAdvanced = g << 2

      var Mg = UInt32(chunk[chunk.startIndex &+ gAdvanced])
      Mg |= UInt32(chunk[chunk.startIndex &+ gAdvanced &+ 1]) << 8
      Mg |= UInt32(chunk[chunk.startIndex &+ gAdvanced &+ 2]) << 16
      Mg |= UInt32(chunk[chunk.startIndex &+ gAdvanced &+ 3]) << 24

      B = B &+ rotateLeft(A &+ F &+ k[j] &+ Mg, by: s[j])
      A = dTemp
    }

    currentHash[0] = currentHash[0] &+ A
    currentHash[1] = currentHash[1] &+ B
    currentHash[2] = currentHash[2] &+ C
    currentHash[3] = currentHash[3] &+ D
  }
}

extension MD5: Updatable {
  public func update(withBytes bytes: ArraySlice<UInt8>, isLast: Bool = false) throws -> [UInt8] {
    accumulated += bytes

    if isLast {
      let lengthInBits = (processedBytesTotalCount + accumulated.count) * 8
      let lengthBytes = lengthInBits.bytes(totalBytes: 64 / 8)  // A 64-bit representation of b

      // Step 1. Append padding
      bitPadding(to: &accumulated, blockSize: MD5.blockSize, allowance: 64 / 8)

      // Step 2. Append Length a 64-bit representation of lengthInBits
      accumulated += lengthBytes.reversed()
    }

    var processedBytes = 0
    for chunk in accumulated.batched(by: MD5.blockSize) {
      if isLast || (accumulated.count - processedBytes) >= MD5.blockSize {
        process(block: chunk, currentHash: &accumulatedHash)
        processedBytes += chunk.count
      }
    }
    accumulated.removeFirst(processedBytes)
    processedBytesTotalCount += processedBytes

    // output current hash
    var result = [UInt8]()
    result.reserveCapacity(MD5.digestLength)

    for hElement in accumulatedHash {
      let hLE = hElement.littleEndian
      result += [UInt8](
        arrayLiteral: UInt8(hLE & 0xff), UInt8((hLE >> 8) & 0xff), UInt8((hLE >> 16) & 0xff),
        UInt8((hLE >> 24) & 0xff))
    }

    // reset hash value for instance
    if isLast {
      accumulatedHash = MD5.hashInitialValue
    }

    return result
  }
}
