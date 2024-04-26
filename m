Return-Path: <linux-btrfs+bounces-4553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D18B3655
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 13:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7231F21A03
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9332A144D3F;
	Fri, 26 Apr 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGaz5vzH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083781448DF;
	Fri, 26 Apr 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129802; cv=none; b=ZSpYQaK/AoKXjUI8aYz+v9dmx4mTsfbiIQWBshAcbQHE5oLIwgT+NMSKeQJS2iunLdaz9WQDn17QRRQaxZMQH8EVE9+TsWCoiSjZfmAXNljcRJ10uc6HxUWeLRrwCaY6+nq94Y5P3LD/SWLIdjBKFCnNWgInWt443i88m5mnmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129802; c=relaxed/simple;
	bh=yArjolxFXXxo/rbVYFC3ofkx+zApG1M75mGf/E3/juA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0yVAI8Nww5nUrjQQ4yaa0IfaREvEvda9ZJBzkNtxca2G/z0hnKFrv/3Gs02w4h1JqK3Z7QuFGXIuQX/IjxIJ3tGI7HjmXY2F1cbX8O0Nk5Fvy/eGJzGoSnRc1a5vib6rtrGuEhHV4LMJXu03kAqQlEwtxyM3eukeV44u3tPo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGaz5vzH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129801; x=1745665801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yArjolxFXXxo/rbVYFC3ofkx+zApG1M75mGf/E3/juA=;
  b=LGaz5vzHg8bLDk1F7wnytRFJRaChEjuKqWg1jpWcae3fybtht0vHMa8B
   mkaLoX+SpIAftzyu/Wy8FFK2G9Qdnt64tUwlI+bUxs0yM6vSn7CvYQuxG
   y3ZUdy1H926ldRt1pBGVMoEbqKuh+t/73iIHNA4Bcf/eUoW4rYE7fzn7e
   M/PtaXXYYleJLxNr5v2GfXwGPfsYL0r53mHzs5e2ZVuPXa/tcPIqVoSDm
   2LzXRyDHImlqzIg2ho42WOzBLa5vKl7CLglQlwThsSMqqwo3nCfldFZfC
   hmF3V0ru2yql0M6k5WcIta9LD8PHLiAaym/ElziaMfYb8nbQzhZU703DV
   A==;
X-CSE-ConnectionGUID: 8dfZB+fBREaPf1V3bMQ5aA==
X-CSE-MsgGUID: tesGisYDSDmrYRmJxiuI+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20474048"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20474048"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:10:00 -0700
X-CSE-ConnectionGUID: FiFbvnJZRr+OApU+k7sG2A==
X-CSE-MsgGUID: Atx6dXyBSYGBOl+iUnbvfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30030834"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 04:09:57 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	embg@meta.com,
	cyan@meta.com,
	brian.will@intel.com,
	weigang.li@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [RFC PATCH 0/6] btrfs: offload zlib-deflate to accelerators
Date: Fri, 26 Apr 2024 11:54:23 +0100
Message-ID: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

Add support for zlib compression and decompression through the acomp
APIs in BTRFS. This enables [de]compression operations to be offloaded
to accelerators. This is a rework of [1].

This set also re-enables zlib-deflate in the Crypto API and in the QAT
driver as they were removed in [2] since there was no user in kernel.
The re-enablement is done by reverting the commits that removed such
feature.

The code has been benchmarked on a system with the following specs:
 * Dual socket Intel(R) Xeon(R) Platinum 8470N
 * 512GB (16x32GB DDR5 4800 MT/s [4800 MT/s])
 * 4 NVMe disks (349.3G INTEL SSDPE21K375GA)
 * 2 QAT 4xxx devices, one per socket, configured for compression only
 * Kernel 6.8.2

The test consisted of 4 processes running `dd` that wrote in parallel
50GB of data (Silesia corpus) to the 4 NVMe disks separately. We captured
disk write throughput, CPU utilization and compression ratio:

    +---------------------------+---------+---------+---------+---------+
    |                           | QAT-L9  | ZSTD-L3 | ZLIB-L3 | LZO-L1  |
    +---------------------------+---------+---------+---------+---------+
    | Disk Write TPUT (GiB/s)   | 6.5     | 5.2     | 2.2     | 6.5     |
    +---------------------------+---------+---------+---------+---------+
    | CPU utils %age @208 cores | 4.56%   | 15.67%  | 12.79%  | 19.85%  |
    +---------------------------+---------+---------+---------+---------+
    | Compression Ratio         | 34%     | 35%     | 37%     | 58%     |
    +---------------------------+---------+---------+---------+---------+

From the results we see that BTRFS with QAT configured for zlib-deflate Level 9
provides the best throughput with less CPU utilization and better compression
ratio compared with software zstd-l3, zlib-l3 and lzo. 

Limitations: 
  * The implementation is synchronous, even if acomp is an asynchronous API.
  * The implementation tries always to use an acomp tfm even if only
    zlib-deflate-scomp is present. This ignores the compression levels
    configuration for zlib.
  * There is no way to configure a compression level for acomp(zlib-deflate).
    This is hardcoded in the acomp algorithm implementation/provider.

[1] https://lore.kernel.org/all/1467083180-111750-1-git-send-email-weigang.li@intel.com/  
[2] https://lore.kernel.org/all/ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au/

Giovanni Cabiddu (5):
  Revert "crypto: testmgr - Remove zlib-deflate"
  Revert "crypto: deflate - Remove zlib-deflate"
  Revert "crypto: qat - Remove zlib-deflate"
  Revert "crypto: qat - remove unused macros in qat_comp_alg.c"
  crypto: qat - change compressor settings for QAT GEN4

Weigang Li (1):
  btrfs: zlib: add support for zlib-deflate through acomp

 crypto/deflate.c                              |  61 +++--
 crypto/testmgr.c                              |  10 +
 crypto/testmgr.h                              |  75 ++++++
 .../crypto/intel/qat/qat_common/adf_gen4_dc.c |   4 +-
 .../intel/qat/qat_common/qat_comp_algs.c      | 138 ++++++++++-
 fs/btrfs/zlib.c                               | 216 ++++++++++++++++++
 6 files changed, 484 insertions(+), 20 deletions(-)

base-commit: ed265f7fd9a635d77c8022fc6d9a1b735dd4dfd7
-- 
2.44.0


