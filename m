Return-Path: <linux-btrfs+bounces-8610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0886993ADF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B81B24797
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B6F1DE885;
	Mon,  7 Oct 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZHlf363"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8D1917EC;
	Mon,  7 Oct 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343032; cv=none; b=NxbS1/evoa49dLr43CnaiNrMJ6SLTCfXAEDfS9umGMhXjRMekrrjDryfp+gYkvPBDWwRBvuM3pOSwbzKStAB1a/gAklGKmH9IuCp8A2FWW7Lm/v5oz67tevQMgkYE7ttnHbUYq4lYgEs1OGhUUwd/HRBVfLsQeD4gx1bz8uyIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343032; c=relaxed/simple;
	bh=NwmV/tPNynIqYZ6V+AJyd9TdBcPCPEff+OroDjLCLvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3+I+WT1vlo6WqDPhN5sTFblugMqmFkxzhVoxrm6aUfJ7TRkoF4HG4o9iwNkS53xEirzCtIt9xO4YZ4pqEFYLzaPi76xsUEoLx9YaHOJTnP1ygG6fVrnQvsDsAgZeSiOj6fHS0Uh8M6UajYkpVuDVRI6DuMopILaFtrt9b/7AAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZHlf363; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728343030; x=1759879030;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NwmV/tPNynIqYZ6V+AJyd9TdBcPCPEff+OroDjLCLvg=;
  b=HZHlf363i72W5wgiFSA1JhH0hs4wyuFnVZo1GsljKygQ7eHYvGURWDet
   5CqBi9770vNRQwS6MZeAoIqHnLWV9kEQs0rOph2Sa70nMnf2zsvfK1wjM
   gSbjPURZSHaDilkos3FgQQObxMVJ7jqIOKwaO+q5CHleQWhMmYqLVeFSC
   RlAggUQKXIaqCp9HgWKhUph5bAAx59eBgM4IRSpBuXoQufI9o73h50K6O
   dNcgoUTIgVtwZdpiRxrlc/pgHNMCA4w7V1l5s05ouuUVmlO+4NMCFoWof
   VPINp7QZJmg/jo41l6DlEjTWIqdbwOhKGFvLna92Fu+Sto6VeVHkIvhZE
   w==;
X-CSE-ConnectionGUID: R39sr4BDSryZnIS8eX1rNA==
X-CSE-MsgGUID: DebohygxQ5uTiZmy4U8n5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="45036888"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="45036888"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:44 -0700
X-CSE-ConnectionGUID: Xu6mD+1MTzqf43B2iChpHw==
X-CSE-MsgGUID: 6aVmDD82Q/+R9d2iYG+B8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75309039"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:41 -0700
From: ira.weiny@intel.com
Date: Mon, 07 Oct 2024 18:16:16 -0500
Subject: [PATCH v4 10/28] cxl/region: Add dynamic capacity decoder and
 region modes
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-dcd-type2-upstream-v4-10-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=3348;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=fr62Az6XMhCHzpt/LfqixRVGwuJGoTNo58Fjm3stTRE=;
 b=IC4UI8fBZIaA8guz+m47EPzWSlBYTRgAAozsTaRQ68dbUaR70A8Io/e8fHqxlcHHEiMo/FNTg
 UkzVO7DmLoHBvdBf4FuKSSnYzmjc6KyaQJh3yt3yJ7OI92CXMzH8HkG
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
index f3a56003edc1..ab00203f285a 100644
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
index 5d74eb4ffab3..f931ebdd36d0 100644
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
2.46.0


