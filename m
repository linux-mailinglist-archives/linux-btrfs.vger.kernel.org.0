Return-Path: <linux-btrfs+bounces-7246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D34954BB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F531C24251
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB901C3782;
	Fri, 16 Aug 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CROXyWvX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606451C2301;
	Fri, 16 Aug 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816816; cv=none; b=jl5AD29mFfVjGRDaBrmVFQjlqdqEb4Bla556qIQi62QCZf79v+pyPgng9OdJ10iDDX9MjYAZuLA6ugI6/w6VZbYxaHhigqaH+wA1q/2no2u3sbPkKZrnKf3WXg83BSiPsCdpi4YNdfdFNH9msNjljRbpShyIo0Vd6OT8mTWdbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816816; c=relaxed/simple;
	bh=vS8COK5ONXmBd+v9Pw/7t83kDsPGQ3h+k3bU/+IWHss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWnnO9PqnY6d5Em2fiJBaYJ3u/eTiLxUlLCfGHI3ZR3EHgtqezUlPQ/scaJIl8wDgdi3694wyAuy5d5sDS2pcdMVLzYdusa/rlTbeNxIsvZ++/ygUpgaBufHC5FjY5vnP0T8txWAeyv3Xanb/YUoaky/6uifXtIq3GT71MNjHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CROXyWvX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816814; x=1755352814;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vS8COK5ONXmBd+v9Pw/7t83kDsPGQ3h+k3bU/+IWHss=;
  b=CROXyWvXvYM1bxV75fIUEX2RnxtrPQnk9S+9w4iKKth1qnhZsSPqOoym
   d3hxYxMuMafuvKAr3LTKe3rC45a0bT/bMpjVOH01JjO8I5nzJgb9t5sb3
   DkKNI/fGGhoYKyZGc3z49nC703CqAHklez+HJXWBS1TbPetXVBt70f2yz
   r6kNhSZ4bFhN/LYl4HTcdcycNl3FWU4yIL/fSJuzUELixrWuGpa5rJKyE
   6EoaMhKig/0s+OUzV5ZdXSz1g+J/dyv6ZO1Cq4+bnMlMFg2Z7trTERR1S
   OruuVHIPMzGpBO5rZqKCJl2Z41m9McBY9r/Wpb9pqc1Ut20PQBGgfaJsb
   Q==;
X-CSE-ConnectionGUID: d5iepILuQuyYXrQoOqfeUQ==
X-CSE-MsgGUID: 2y2sRz8jS6Sppkpx3+mJSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272792"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272792"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:13 -0700
X-CSE-ConnectionGUID: aX7X86weQkidX6zq2mEEng==
X-CSE-MsgGUID: fq7/v0buQR6GDmtcIq+mLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411267"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:13 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 08:59:58 -0500
Subject: [PATCH v2 10/25] cxl/port: Add endpoint decoder DC mode support to
 sysfs
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-10-20189a10ad7d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=6095;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=cMje7vWnYC+ErlwgLy791KZR8UUSe5SVqngdUwWVktE=;
 b=AfZckVztyTR+L9c31WpxqE/zGjQ7Ur7sO1B51EE2unzCyrF3LgR6wxMkJGXSUfQiUvYSUI4aI
 Z34dK5wmdywCm2eF0VvWKHBPn8GON+WMKweNOwosQUE1c2W2SThSyue
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Endpoint decoder mode is used to represent the partition the decoder
points to such as ram or pmem.

Expand the mode to allow a decoder to point to a specific DC partition
(Region).

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[Fan: change mode range logic]
[Fan: use !resource_size()]
[djiang: use the static mode name string array in mode_store()]
[Jonathan: remove rc check from mode to region index]
[Jonathan: clarify decoder mode 'mixed']
[djbw: drop cleanup patch and just follow the convention in cxl_dpa_set_mode()]
[fan: make dcd resource size check similar to other partitions]
[djbw, jonathan, fan: remove mode range check from dc_mode_to_region_index]
[iweiny: push sysfs versions to 6.12]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 21 ++++++++++----------
 drivers/cxl/core/hdm.c                  | 10 ++++++++++
 drivers/cxl/core/port.c                 | 10 +++++-----
 drivers/cxl/cxl.h                       | 35 ++++++++++++++++++---------------
 4 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3f5627a1210a..957717264709 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -316,23 +316,24 @@ Description:
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
-Date:		May, 2022
-KernelVersion:	v6.0
+Date:		May, 2022, October 2024
+KernelVersion:	v6.0, v6.12 (dcY)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
 		translates from a host physical address range, to a device local
 		address range. Device-local address ranges are further split
-		into a 'ram' (volatile memory) range and 'pmem' (persistent
-		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
-		'mixed', or 'none'. The 'mixed' indication is for error cases
-		when a decoder straddles the volatile/persistent partition
-		boundary, and 'none' indicates the decoder is not actively
-		decoding, or no DPA allocation policy has been set.
+		into a 'ram' (volatile memory) range, 'pmem' (persistent
+		memory) range, or Dynamic Capacity (DC) range. The 'mode'
+		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
+		'none'. The 'mixed' indication is for error cases when a
+		decoder straddles partition boundaries, and 'none' indicates
+		the decoder is not actively decoding, or no DPA allocation
+		policy has been set.
 
 		'mode' can be written, when the decoder is in the 'disabled'
-		state, with either 'ram' or 'pmem' to set the boundaries for the
-		next allocation.
+		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
+		the next allocation.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b4a517c6d283..ceca0b3d3e5c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -551,6 +551,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	switch (mode) {
 	case CXL_DECODER_RAM:
 	case CXL_DECODER_PMEM:
+	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
 		break;
 	default:
 		dev_dbg(dev, "unsupported mode: %d\n", mode);
@@ -578,6 +579,15 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		goto out;
 	}
 
+	if (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7) {
+		rc = dc_mode_to_region_index(mode);
+		if (!resource_size(&cxlds->dc_res[rc])) {
+			dev_dbg(dev, "no available dynamic capacity\n");
+			rc = -ENXIO;
+			goto out;
+		}
+	}
+
 	cxled->mode = mode;
 	rc = 0;
 out:
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8054cbaac9f6..222aa0aeeef7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -205,11 +205,11 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 	enum cxl_decoder_mode mode;
 	ssize_t rc;
 
-	if (sysfs_streq(buf, "pmem"))
-		mode = CXL_DECODER_PMEM;
-	else if (sysfs_streq(buf, "ram"))
-		mode = CXL_DECODER_RAM;
-	else
+	for (mode = CXL_DECODER_RAM; mode < CXL_DECODER_MIXED; mode++)
+		if (sysfs_streq(buf, cxl_decoder_mode_names[mode]))
+			break;
+
+	if (mode >= CXL_DECODER_MIXED)
 		return -EINVAL;
 
 	rc = cxl_dpa_set_mode(cxled, mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 53b666ef4097..cda7e40b9a48 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -365,6 +365,9 @@ struct cxl_decoder {
 /*
  * CXL_DECODER_DEAD prevents endpoints from being reattached to regions
  * while cxld_unregister() is running
+ *
+ * NOTE: CXL_DECODER_RAM must be second and CXL_DECODER_MIXED must be last.
+ * 	 See mode_store()
  */
 enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
@@ -382,25 +385,25 @@ enum cxl_decoder_mode {
 	CXL_DECODER_DEAD,
 };
 
+static const char * const cxl_decoder_mode_names[] = {
+	[CXL_DECODER_NONE] = "none",
+	[CXL_DECODER_RAM] = "ram",
+	[CXL_DECODER_PMEM] = "pmem",
+	[CXL_DECODER_DC0] = "dc0",
+	[CXL_DECODER_DC1] = "dc1",
+	[CXL_DECODER_DC2] = "dc2",
+	[CXL_DECODER_DC3] = "dc3",
+	[CXL_DECODER_DC4] = "dc4",
+	[CXL_DECODER_DC5] = "dc5",
+	[CXL_DECODER_DC6] = "dc6",
+	[CXL_DECODER_DC7] = "dc7",
+	[CXL_DECODER_MIXED] = "mixed",
+};
+
 static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 {
-	static const char * const names[] = {
-		[CXL_DECODER_NONE] = "none",
-		[CXL_DECODER_RAM] = "ram",
-		[CXL_DECODER_PMEM] = "pmem",
-		[CXL_DECODER_DC0] = "dc0",
-		[CXL_DECODER_DC1] = "dc1",
-		[CXL_DECODER_DC2] = "dc2",
-		[CXL_DECODER_DC3] = "dc3",
-		[CXL_DECODER_DC4] = "dc4",
-		[CXL_DECODER_DC5] = "dc5",
-		[CXL_DECODER_DC6] = "dc6",
-		[CXL_DECODER_DC7] = "dc7",
-		[CXL_DECODER_MIXED] = "mixed",
-	};
-
 	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
-		return names[mode];
+		return cxl_decoder_mode_names[mode];
 	return "mixed";
 }
 

-- 
2.45.2


