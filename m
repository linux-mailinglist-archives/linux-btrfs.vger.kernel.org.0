Return-Path: <linux-btrfs+bounces-19398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0128C9240A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D88334E4F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B2832F74B;
	Fri, 28 Nov 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS4Z0TtL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDB331220;
	Fri, 28 Nov 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339293; cv=none; b=kE0pRwCCP8z8lA0vMbLy1sX3VE6l2NoN6gQPlzRgXpvytktllbN8e7b0xrgRXFY+bhZy9t6sqya341z2eDR0SQwGvtTQR+8S1pJwWzERATehptM11b2E5baXQy7rj8+JE18+bTuhKXXZ1IcWQM/3622v0ER5H0MbBD9pdXQrbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339293; c=relaxed/simple;
	bh=ugBH/1xOXS6ErFva0t3zXOF3Vqy0T7F0qw2qIfPHsSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee6EEhTtW/MkC2tZQubg+lWJ5pHpRrFAkZZ3FHWVkuo7iGMK1iR6Oim+xYkii653UcotSqkvkEMZ/ux9NgbHNcduH1xhIx+rhPyDJ4hib23pdqrphXaopUaAmkiH/wuTpeqIRI5QRSlzBmNRVm+nvFDhAVfzqXpk5H8iQ2472Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS4Z0TtL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339292; x=1795875292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ugBH/1xOXS6ErFva0t3zXOF3Vqy0T7F0qw2qIfPHsSA=;
  b=kS4Z0TtLEuul449AdfCkQOhytNmJNzgNRZ4wW+wlTGMiyLaLS910OEbU
   YktvhQTO1Xbh0ThYapVcXTRpDZrIVuPDL8tJOuhDEuNN1fYeehNI/DWcd
   0pT1oA4EcBCloqXUn7Wf4v6LqfRKNf56ySOsSPucWJDxD1a/YaM2+7yoj
   hpyrb8JG0FYHdH4zEg85Ntr/DXGZwNqoszf7mmXXxLl+BjVxBeoprxbvd
   S1JAA7B5YXbrLUASMibqjtOrd8AfKuQglJBnA4jgS4CncB71cIqNTWWiV
   U2KP4nbqJoSgwarFSQbr1yHx9m742/P76sYNLUveyynR9yE1hDfsoEhdF
   A==;
X-CSE-ConnectionGUID: IgorhvyqS8GNFlfB3D0deQ==
X-CSE-MsgGUID: DWJRqZmHRdGN+Sk1pBcB6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409451"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409451"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:51 -0800
X-CSE-ConnectionGUID: Cz0YEQ1RQvyxKO1qKvY95w==
X-CSE-MsgGUID: C/WQdyV8TrS37eDM5idDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823019"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:49 -0800
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
Subject: [RFC PATCH 05/16] Revert "crypto: testmgr - Remove zlib-deflate"
Date: Fri, 28 Nov 2025 19:04:53 +0000
Message-ID: <20251128191531.1703018-6-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

Reintroduce the zlib-deflate test cases for the acomp API.

This reverts commit 30febae71c6182e0762dc7744737012b4f8e6a6d.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/testmgr.c | 10 +++++++
 crypto/testmgr.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index dc22b4f28633..9ca309b84b92 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5580,6 +5580,16 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(xxhash64_tv_template)
 		}
+	}, {
+		.alg = "zlib-deflate",
+		.test = alg_test_comp,
+		.fips_allowed = 1,
+		.suite = {
+			.comp = {
+				.comp = __VECS(zlib_deflate_comp_tv_template),
+				.decomp = __VECS(zlib_deflate_decomp_tv_template)
+			}
+		}
 	}, {
 		.alg = "zstd",
 		.test = alg_test_comp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index bdd9e71fee0f..523268679bf4 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -33364,6 +33364,81 @@ static const struct comp_testvec deflate_decomp_tv_template[] = {
 	},
 };
 
+static const struct comp_testvec zlib_deflate_comp_tv_template[] = {
+	{
+		.inlen	= 70,
+		.outlen	= 44,
+		.input	= "Join us now and share the software "
+			"Join us now and share the software ",
+		.output	= "\x78\x5e\xf3\xca\xcf\xcc\x53\x28"
+			  "\x2d\x56\xc8\xcb\x2f\x57\x48\xcc"
+			  "\x4b\x51\x28\xce\x48\x2c\x4a\x55"
+			  "\x28\xc9\x48\x55\x28\xce\x4f\x2b"
+			  "\x29\x07\x71\xbc\x08\x2b\x01\x00"
+			  "\x7c\x65\x19\x3d",
+	}, {
+		.inlen	= 191,
+		.outlen	= 129,
+		.input	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+		.output	= "\x78\x5e\x5d\xce\x41\x0a\xc3\x30"
+			  "\x0c\x04\xc0\xaf\xec\x0b\xf2\x87"
+			  "\xd2\xa6\x50\xe8\xc1\x07\x7f\x40"
+			  "\xb1\x95\x5a\x60\x5b\xc6\x56\x0f"
+			  "\xfd\x7d\x93\x1e\x42\xe8\x51\xec"
+			  "\xee\x20\x9f\x64\x20\x6a\x78\x17"
+			  "\xae\x86\xc8\x23\x74\x59\x78\x80"
+			  "\x10\xb4\xb4\xce\x63\x88\x56\x14"
+			  "\xb6\xa4\x11\x0b\x0d\x8e\xd8\x6e"
+			  "\x4b\x8c\xdb\x7c\x7f\x5e\xfc\x7c"
+			  "\xae\x51\x7e\x69\x17\x4b\x65\x02"
+			  "\xfc\x1f\xbc\x4a\xdd\xd8\x7d\x48"
+			  "\xad\x65\x09\x64\x3b\xac\xeb\xd9"
+			  "\xc2\x01\xc0\xf4\x17\x3c\x1c\x1c"
+			  "\x7d\xb2\x52\xc4\xf5\xf4\x8f\xeb"
+			  "\x6a\x1a\x34\x4f\x5f\x2e\x32\x45"
+			  "\x4e",
+	},
+};
+
+static const struct comp_testvec zlib_deflate_decomp_tv_template[] = {
+	{
+		.inlen	= 128,
+		.outlen	= 191,
+		.input	= "\x78\x9c\x5d\x8d\x31\x0e\xc2\x30"
+			  "\x10\x04\xbf\xb2\x2f\xc8\x1f\x10"
+			  "\x04\x09\x89\xc2\x85\x3f\x70\xb1"
+			  "\x2f\xf8\x24\xdb\x67\xd9\x47\xc1"
+			  "\xef\x49\x68\x12\x51\xae\x76\x67"
+			  "\xd6\x27\x19\x88\x1a\xde\x85\xab"
+			  "\x21\xf2\x08\x5d\x16\x1e\x20\x04"
+			  "\x2d\xad\xf3\x18\xa2\x15\x85\x2d"
+			  "\x69\xc4\x42\x83\x23\xb6\x6c\x89"
+			  "\x71\x9b\xef\xcf\x8b\x9f\xcf\x33"
+			  "\xca\x2f\xed\x62\xa9\x4c\x80\xff"
+			  "\x13\xaf\x52\x37\xed\x0e\x52\x6b"
+			  "\x59\x02\xd9\x4e\xe8\x7a\x76\x1d"
+			  "\x02\x98\xfe\x8a\x87\x83\xa3\x4f"
+			  "\x56\x8a\xb8\x9e\x8e\x5c\x57\xd3"
+			  "\xa0\x79\xfa\x02\x2e\x32\x45\x4e",
+		.output	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+	}, {
+		.inlen	= 44,
+		.outlen	= 70,
+		.input	= "\x78\x9c\xf3\xca\xcf\xcc\x53\x28"
+			  "\x2d\x56\xc8\xcb\x2f\x57\x48\xcc"
+			  "\x4b\x51\x28\xce\x48\x2c\x4a\x55"
+			  "\x28\xc9\x48\x55\x28\xce\x4f\x2b"
+			  "\x29\x07\x71\xbc\x08\x2b\x01\x00"
+			  "\x7c\x65\x19\x3d",
+		.output	= "Join us now and share the software "
+			"Join us now and share the software ",
+	},
+};
+
 /*
  * LZO test vectors (null-terminated strings).
  */
-- 
2.51.1


