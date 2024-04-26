Return-Path: <linux-btrfs+bounces-4554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E72F8B3658
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95094B2361F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBBA145338;
	Fri, 26 Apr 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMIc2Elf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BB1448DF;
	Fri, 26 Apr 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129805; cv=none; b=ooQk12jF6mrG0jF/2PuOKMyE3zs/lQzEvVnDFvCGoIeRUIN+T+SG81qmAcD2lZb30s7Jmegkl0meyOVlSgxZs6urpCVAT4NVH/Jlafe1qzdlokW9xRa89Co9Y+wLrlNkmOk7IG4A+mBDcekaQlxcayKdPi/kdKFlDLpF7CK65M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129805; c=relaxed/simple;
	bh=C6zwMGNw1Pfmrr7no50l7uH5Ymdi1QlJcQQQ87iPgkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZTHCHPm042rFdU1Y0fbrpbXHGwy86HYmWCiFEvfEkFAZWxo//6pyET4xWaMeYlbDsrXbo8sJ7GtI8vj7kFHh3fafND5CjTOlmC4g0xQq5ApUofYxCGTNkPeFcJBsAfZeIYcl1AXeN1g0HHt+MHtPlgoDzyoBLoUzj3dL90EGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMIc2Elf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129804; x=1745665804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C6zwMGNw1Pfmrr7no50l7uH5Ymdi1QlJcQQQ87iPgkw=;
  b=TMIc2ElfWFv0IN7bPzdTlLYDQIxaQAkNqO84p3s7e5znxV2QiKMqXdI7
   qtUEBL3JyFCvva88Ov2qeOUPAedKtNLX5WwB5XleVg4UXpsjaZTjpiwG/
   igyHbq1puJR/fu6SiQdv/L7Ob0JoxxfNiQRY6v3d7nkFN85US8HR3bVNo
   Kc9Be4gXj1BG8TJuITYzs/vBZ/ln34Pjtfwm2EgELZ0kr2AmK7K4d7/FA
   iHw6Cxvil+ab1g9Ga/fk5w2+Q9cF3TSwx+4y8WFgrXoBTG8IZcWKtFx51
   oQGIOOIeKvRcHtJb+3H8yP+zbxxMt/14SZcVmp8H8UDwEnmzjM7tfW6Mg
   Q==;
X-CSE-ConnectionGUID: vX6aZOF3TLePOf5BbcEaUg==
X-CSE-MsgGUID: qbd+KKHxQ361gO52+dbojg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20474059"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20474059"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:10:04 -0700
X-CSE-ConnectionGUID: F79QqFACRQKhnxQq7r9pUw==
X-CSE-MsgGUID: 7968Phl+SruEgmQlfrBD9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30030866"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 04:10:00 -0700
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
Subject: [RFC PATCH 1/6] Revert "crypto: testmgr - Remove zlib-deflate"
Date: Fri, 26 Apr 2024 11:54:24 +0100
Message-ID: <20240426110941.5456-2-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

This reverts commit 30febae71c6182e0762dc7744737012b4f8e6a6d.
---
 crypto/testmgr.c | 10 +++++++
 crypto/testmgr.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 00f5a6cf341a..ab904ab74bee 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5733,6 +5733,16 @@ static const struct alg_test_desc alg_test_descs[] = {
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
index 5350cfd9d325..71d87a2fd842 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -34752,6 +34752,81 @@ static const struct comp_testvec deflate_decomp_tv_template[] = {
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
2.44.0


