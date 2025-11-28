Return-Path: <linux-btrfs+bounces-19393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A050EC92404
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA83AB414
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBFE32E75B;
	Fri, 28 Nov 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAY0P9aj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE398330B38;
	Fri, 28 Nov 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339282; cv=none; b=Vckz0l4fOlL/CeW/sRFBxdz877br/atp5OiEUwX4kjbZ5TxU6nVCau0opfJkF0xe0HPokvFOQGgPG5tKfLX3f7jMIQAucquRZD+G9od2Oa5Mmk0YEo5HIbrJQ9Eo4bZzV3+zv0EfAymKi+wzsIJKjGusRRtP1bbrDTReH9FjKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339282; c=relaxed/simple;
	bh=7et88BIxj2vQHyUJilMAX3IGCH8NP3K2KH4TFMrbcek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN0ItFPqMYoohQCDtB2H0IAtwHfdCpdFcLTD9TNCfnM0y8vP1USaASAlnFM4ZcKAbQRPXV5HfBNxwR4tOyeZOyk2+GOTTsmrNyXpz+ZzCBPeT7Xlw9kppadWzCa85Q2u6TdUyoKPkpdtEE6H7XU3AbHd/y9zkEsEqtC48FHP41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAY0P9aj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339280; x=1795875280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7et88BIxj2vQHyUJilMAX3IGCH8NP3K2KH4TFMrbcek=;
  b=LAY0P9ajrAhF43ANds4Y5/0Rpq/VBOSS8jh2kqI9kP+B44Ix0rYbHiUd
   wakNeuJ1yK7lGvo9H7y8HcKqLuSjU0TaOM8qesYl2WuU3x0/R7o4ITeS/
   TyEBi59BDF7zO7m7VapT9A2wrIjQzk04DQnNkduTkYOsBCQrYv8z6VnGV
   /LcziSX1HFGPEVIDcBZsJyl5wtGdKH2TZ8NmRN4x9PSmo9keVVgw1cl48
   KOPMHLZeGWR49QUrTpfo5JSXupQpbdpOZrfk47mMgE3N15sbhlqDyxEk0
   23W9LIo5PgZMP2Q8dUbITRQA/3L4qxWbdD2cnm/kQAo+Vi45EPaMpzTuA
   w==;
X-CSE-ConnectionGUID: UCo4acT+Tyeo9JsX0r7g/Q==
X-CSE-MsgGUID: py42dhWmQBCZNQOIs4YV6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409398"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409398"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:39 -0800
X-CSE-ConnectionGUID: qxKd2eSgTZCtyMI3l1UNlA==
X-CSE-MsgGUID: NeIiSiIJQGi9QN8GlXizzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216822971"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:37 -0800
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: clm@fb.comi,
	dsterba@suse.com,
	terrelln@fb.com,
	herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	cyan@meta.com,
	brian.will@intel.com,
	weigang.li@intel.com,
	senozhatsky@chromium.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [RFC PATCH 00/16] btrfs: offload compression to hardware accelerators
Date: Fri, 28 Nov 2025 19:04:48 +0000
Message-ID: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

This patch series applies to:
  https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git

This series adds support for hardware-accelerated compression and decompression
in BTRFS using the acomp APIs in the Crypto Framework.  While the
implementation is generic and should work with any acomp-compatible
implementation, the initial enablement targets Intel QAT devices.

Supported operations:
  - zlib: compression and decompression (all QAT generations)
  - zstd: compression only (GEN4 and GEN6)

This is a rework of the earlier RFC series [1].

Changes in this series:
  1. Re-enable zlib-deflate in the Crypto API and QAT driver. These were
     removed in [2] due to lack of in-kernel users. This series reverts
     those commits to restore the functionality.

  2. Add compression level support to the acomp framework. The core
     implementation is from Herbert Xu [3]; I've rebased it and
     addressed checkpatch style issues.
     Compression levels are enabled in deflate, zstd, and the QAT driver.

  3. Add compression offload to QAT accelerators in BTRFS using the acomp
     layer enabled with runtime control via sysfs.
     This feature is wrapped in CONFIG_BTRFS_EXPERIMENTAL.

Note that I included to this set also the bug fix `crypto: zstd - fix
double-free in per-CPU stream cleanup`, even if this is already merged
to crypto-2.6. This is just in case someone wants to test the series.

Feedback Requested:
  1. General approach on integration of acomp with BTRFS
  2. Folio-to-scatterlist conversion.
     @Herbert, any thoughts on this? Would it make sense to do it in the
     acomp layer instead?
  3. Compression level changes.
  4. Offload threshold strategy. Should acomp implementations report
     optimal data size thresholds, possibly per compression level and
     direction?
  5. Optimizations on the LZ4s to sequences algorithm used for GEN4.
     @Yann, any suggestions on how to improve it?
  5. What benchmarks are required for acceptance?

Performance Results. I'm including here the results from the
**previous implementation**, just to have an idea of the performance.
I still need to formally benchmark the new implementation.

Benchmarked on a dual-socket Intel Xeon Platinum 8470N system:
  - 512GB RAM (16x32GB DDR5 4800 MT/s)
  - 4 NVMe drives (349.3GB Intel SSDPE21K375GA each)
  - 2 QAT 4xxx devices (one per socket, compression-only configuration)

Test: 4 parallel processes writing 50GB each (Silesia corpus) to separate
drives

+---------------------------+---------+---------+---------+---------+
|                           | QAT-L9  | ZSTD-L3 | ZLIB-L3 | LZO-L1  |
+---------------------------+---------+---------+---------+---------+
| Disk Write TPUT (GiB/s)   | 6.5     | 5.2     | 2.2     | 6.5     |
+---------------------------+---------+---------+---------+---------+
| CPU utils %age @208 cores | 4.56%   | 15.67%  | 12.79%  | 19.85%  |
+---------------------------+---------+---------+---------+---------+
| Compression Ratio         | 34%     | 35%     | 37%     | 58%     |
+---------------------------+---------+---------+---------+---------+

Results: QAT zlib-deflate L9 achieves the best throughput with significantly
lower CPU utilization and provides better compression
ratio compared with software zstd-l3, zlib-l3 and lzo. 

Changes since v1:
  - Addressed review comments from previous series.
  - Refactored from zlib-specific to generic acomp implementation.
  - Reworked to support folios instead of pages.
  - Added support for zstd compression.
  - Added runtime enable/disable via sysfs (/sys/fs/btrfs/$UUID/offload_compress).
  - Moved buffer allocations from data path to workspace initialization
  - Added compression level support.

[1] https://lore.kernel.org/all/20240426110941.5456-1-giovanni.cabiddu@intel.com/
[2] https://lore.kernel.org/all/ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au/
[3] https://lore.kernel.org/all/cover.1716202860.git.herbert@gondor.apana.org.au/

Giovanni Cabiddu (12):
  crypto: zstd - fix double-free in per-CPU stream cleanup
  Revert "crypto: qat - remove unused macros in qat_comp_alg.c"
  Revert "crypto: qat - Remove zlib-deflate"
  crypto: qat - use memcpy_*_sglist() in zlib deflate
  Revert "crypto: testmgr - Remove zlib-deflate"
  crypto: deflate - add support for deflate rfc1950 (zlib)
  crypto: acomp - add NUMA-aware stream allocation
  crypto: deflate - add support for compression levels
  crypto: qat - increase number of preallocated sgl descriptors
  crypto: qat - add support for zstd
  crypto: qat - add support for compression levels
  btrfs: add compression hw-accelerated offload

Herbert Xu (3):
  crypto: scomp - Add setparam interface
  crypto: acomp - Add setparam interface
  crypto: acomp - Add comp_params helpers

Suman Kumar Chakraborty (1):
  crypto: zstd - add support for compression levels

 crypto/842.c                                  |   4 +-
 crypto/acompress.c                            | 133 +++-
 crypto/compress.h                             |   9 +-
 crypto/deflate.c                              | 118 ++-
 crypto/lz4.c                                  |   4 +-
 crypto/lz4hc.c                                |   4 +-
 crypto/lzo-rle.c                              |   4 +-
 crypto/lzo.c                                  |   4 +-
 crypto/scompress.c                            |  43 +-
 crypto/testmgr.c                              |  10 +
 crypto/testmgr.h                              |  75 ++
 crypto/zstd.c                                 |  48 +-
 drivers/crypto/intel/qat/Kconfig              |   1 +
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |   1 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   1 +
 .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     |  19 +-
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   8 +-
 .../intel/qat/qat_common/adf_common_drv.h     |   6 +-
 drivers/crypto/intel/qat/qat_common/adf_dc.c  |   5 +-
 drivers/crypto/intel/qat/qat_common/adf_dc.h  |   3 +-
 .../intel/qat/qat_common/adf_gen2_hw_data.c   |  16 +-
 .../intel/qat/qat_common/adf_gen4_hw_data.c   |  29 +-
 .../crypto/intel/qat/qat_common/adf_init.c    |   6 +-
 .../crypto/intel/qat/qat_common/icp_qat_fw.h  |   7 +
 .../intel/qat/qat_common/icp_qat_fw_comp.h    |   2 +
 .../crypto/intel/qat/qat_common/icp_qat_hw.h  |   3 +-
 drivers/crypto/intel/qat/qat_common/qat_bl.h  |   2 +-
 .../intel/qat/qat_common/qat_comp_algs.c      | 712 +++++++++++++++++-
 .../intel/qat/qat_common/qat_comp_req.h       |  11 +
 .../qat/qat_common/qat_comp_zstd_utils.c      | 120 +++
 .../qat/qat_common/qat_comp_zstd_utils.h      |  13 +
 .../intel/qat/qat_common/qat_compression.c    |  23 +-
 fs/btrfs/Makefile                             |   2 +-
 fs/btrfs/acomp.c                              | 470 ++++++++++++
 fs/btrfs/acomp_workspace.h                    |  61 ++
 fs/btrfs/compression.c                        |  66 ++
 fs/btrfs/compression.h                        |  30 +
 fs/btrfs/disk-io.c                            |   6 +
 fs/btrfs/fs.h                                 |   8 +
 fs/btrfs/sysfs.c                              |  29 +
 fs/btrfs/zlib.c                               |  81 ++
 fs/btrfs/zstd.c                               |  64 ++
 include/crypto/acompress.h                    |  27 +
 include/crypto/internal/acompress.h           |  15 +-
 include/crypto/internal/scompress.h           |  27 +
 46 files changed, 2253 insertions(+), 78 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.h
 create mode 100644 fs/btrfs/acomp.c
 create mode 100644 fs/btrfs/acomp_workspace.h


base-commit: ebbdf6466b30e3b37f3b360826efd21f0633fb9e
-- 
2.51.1


