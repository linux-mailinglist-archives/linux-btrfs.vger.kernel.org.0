Return-Path: <linux-btrfs+bounces-7244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE06D954BAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303361F23862
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000CB1C0DF2;
	Fri, 16 Aug 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNV4gbj9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE91BF33C;
	Fri, 16 Aug 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816813; cv=none; b=UhSWEqulCULeouxbtJpyJC7n1oVJxkfjJ/JIhLiR/KAOhaG1cguVL5goCAUjvkmHQ8tQDTe1KESQcMkUXjRRnqTZRkWmfPSJp8fQYvb99giGPCpSu9GZGOFXXWNFUBTwXkjSSWrc1orp3gyJM0O7D2QFWhwmqvzLEYvwoOvQ0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816813; c=relaxed/simple;
	bh=SXcZK2p0dJOyPPTEdqGxENz2u5vBcK7fakaFc4Em/+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtpjYpaQzGH4FiOoVhXrOnDbApqricJKor6LRZpCFKpsGBrlI0coIHXodUAt+bVEANL8za1YTsG9y+4EFcY7x8i0+U+/E2UpOTvH6+UKasB5qO7N7xLHsQwzr6rkZlZgimQ1lDPOkULHcbqKU29ZGV2UW1wwuvrI5f8GDtbG2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNV4gbj9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816810; x=1755352810;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SXcZK2p0dJOyPPTEdqGxENz2u5vBcK7fakaFc4Em/+c=;
  b=fNV4gbj90DWor7MGSl6GowWS9YrpxZKzMWxcYQiBPvZv+TSqzWbuS2tv
   TWXW/qGuaDyJp14Ys1owubzlQiUl8aD8c+6sGZ57yvBiGEQjV4QKfULa1
   Nax+Q59ov4/wg+9dE8qUm9v897Prw7NUuYLqvxoQxh79SPxXqifrtmdzB
   ts4GvlrlBKbjrRrmIwWMynsnr0PllucIORiF8NOV0y6SM9SLen5+GPLz9
   4iWF6eN2R73nMTHbpOAu7lcaG1BLdWQ5WyJTY8DGNkyHLXc2R4OS/Pq5i
   PnO+26houPvo9ClnLNZlwZYgCle5rukjeteEGt5dzZFef04/rn89MAiaS
   w==;
X-CSE-ConnectionGUID: jkz1tOtWRPa1MGyoCwlwJg==
X-CSE-MsgGUID: mdGUGQmHSce3ct9dZ54AEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272777"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272777"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:10 -0700
X-CSE-ConnectionGUID: CO8u84Y2ShakfMcLBZiZIw==
X-CSE-MsgGUID: DailO3teSyyFxBkuIu2e4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411214"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:09 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 08:59:56 -0500
Subject: [PATCH v2 08/25] cxl/region: Add dynamic capacity decoder and
 region modes
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-8-20189a10ad7d@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=3348;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=gyPkNovHd6BmfRDNMkhSNaMujG9yjRUBp332DRpzPi4=;
 b=eujWv4jK+IbEOEIutl6Vi6/5PNpu3f4NzOmejmT3DzVgNi52/SHIKEE5ii2U7BeARQr6xONUs
 375r8EhvXNAD/LgH2ZFtK81qHF2qRJh3ftiVzyCzKz0hnnmhwkat/oj
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

One or more decoders each pointing to a Dynamic Capacity (DC) partition
form a CXL software region.  The region mode reflects composition of
that entire software region.  Decoder mode reflects a specific DC
partition.  DC partitions are also known as DC regions per CXL
specification r3.1.

Define the new modes and helper functions required to make the
association between these new modes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: keep tags on simple patch]
[Fan: s/partitions/partition/]
[djiang: New wording for the commit message]
[iweiny: reword commit message more]
---
 drivers/cxl/core/region.c |  4 ++++
 drivers/cxl/cxl.h         | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 796e5a791e44..650fe33f2ed4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1870,6 +1870,8 @@ static bool cxl_modes_compatible(enum cxl_region_mode rmode,
 		return true;
 	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
 		return true;
+	if (rmode == CXL_REGION_DC && cxl_decoder_mode_is_dc(dmode))
+		return true;
 
 	return false;
 }
@@ -3239,6 +3241,8 @@ cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
 		return CXL_REGION_RAM;
 	case CXL_DECODER_PMEM:
 		return CXL_REGION_PMEM;
+	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
+		return CXL_REGION_DC;
 	case CXL_DECODER_MIXED:
 	default:
 		return CXL_REGION_MIXED;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f766b2a8bf53..d2674ab46f35 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -370,6 +370,14 @@ enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
 	CXL_DECODER_RAM,
 	CXL_DECODER_PMEM,
+	CXL_DECODER_DC0,
+	CXL_DECODER_DC1,
+	CXL_DECODER_DC2,
+	CXL_DECODER_DC3,
+	CXL_DECODER_DC4,
+	CXL_DECODER_DC5,
+	CXL_DECODER_DC6,
+	CXL_DECODER_DC7,
 	CXL_DECODER_MIXED,
 	CXL_DECODER_DEAD,
 };
@@ -380,6 +388,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 		[CXL_DECODER_NONE] = "none",
 		[CXL_DECODER_RAM] = "ram",
 		[CXL_DECODER_PMEM] = "pmem",
+		[CXL_DECODER_DC0] = "dc0",
+		[CXL_DECODER_DC1] = "dc1",
+		[CXL_DECODER_DC2] = "dc2",
+		[CXL_DECODER_DC3] = "dc3",
+		[CXL_DECODER_DC4] = "dc4",
+		[CXL_DECODER_DC5] = "dc5",
+		[CXL_DECODER_DC6] = "dc6",
+		[CXL_DECODER_DC7] = "dc7",
 		[CXL_DECODER_MIXED] = "mixed",
 	};
 
@@ -388,10 +404,16 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 	return "mixed";
 }
 
+static inline bool cxl_decoder_mode_is_dc(enum cxl_decoder_mode mode)
+{
+	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
+}
+
 enum cxl_region_mode {
 	CXL_REGION_NONE,
 	CXL_REGION_RAM,
 	CXL_REGION_PMEM,
+	CXL_REGION_DC,
 	CXL_REGION_MIXED,
 };
 
@@ -401,6 +423,7 @@ static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
 		[CXL_REGION_NONE] = "none",
 		[CXL_REGION_RAM] = "ram",
 		[CXL_REGION_PMEM] = "pmem",
+		[CXL_REGION_DC] = "dc",
 		[CXL_REGION_MIXED] = "mixed",
 	};
 

-- 
2.45.2


