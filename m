Return-Path: <linux-btrfs+bounces-7243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED3954BAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473571F25451
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5101BC9EB;
	Fri, 16 Aug 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTtJFmTz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522A1BC09F;
	Fri, 16 Aug 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816810; cv=none; b=BOXZnai23NVDfYICimNGBWCzKyAO7qqAOma2FP1o5ffmhD/LkwxLmUldWn0xOqlmdHa697v+QrqhjuaFhf+FAue8afBQ+tdtdaXmHHdKoQ+E6BsIve8LKs71CM7Au8texNoVTQPMD9TuhE1Lrp25UkM3RLjzqDCckbAsLt+z7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816810; c=relaxed/simple;
	bh=N4lF7H6SxQ+yssoa1SQxppiwbjyD+JzY4faHAfQkGCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/yxCG0GITlfsYQSKlS6KFK4HAr1QO+GoIjyFOrFfbuzOShvueLBc37vbJsblXbKNnG9ZrIiblv1B0rZgMEBVr7ATrcyN87+ch0Tv7WudoCoj1oNnPeDy57L6TWaz3r7TFjN5FWasEwTiD4q+8nc6rk2jnvN2bMkbX1hmeJUAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTtJFmTz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816808; x=1755352808;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=N4lF7H6SxQ+yssoa1SQxppiwbjyD+JzY4faHAfQkGCA=;
  b=lTtJFmTzOU2qCkY5XnZws75Erin1nAT4VHiAOI6LL/B67cOVVAPuBZeV
   uxCGJcccnLWKFa3gptcnxPSnXKuq8Tl3u/PMwnv7tWm8/a9YJG2/wtf3e
   dXo4vkz3QefadWt5AHd5jdXrXWA+CHxlyvUwDXe+RXXI0pW7SvS4hcAOi
   nBqGBtOxRP97ypopBW3AQ0hq51IdKUVpmygtIkgaPsRhNCvUtHij7F/ud
   qVqi4PNfoX96Nz9SB4pX2foJwOdwM7ArK3VSfnTSqpge3HZtL0o2dq2oL
   YHcGT4gqdpStj0A+AeHvCIqdT9Yu7hKhNjOrreGv4JgRznoYBgX9JjRjA
   g==;
X-CSE-ConnectionGUID: AdtkRAUTQw+44bUC48krUA==
X-CSE-MsgGUID: 8c+Kr31dTE6X1e/luE/tjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272770"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272770"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:08 -0700
X-CSE-ConnectionGUID: Bqal0j15SxCqc9LYKvmelQ==
X-CSE-MsgGUID: 1tOF0NDFSyeeI4SX6ecXug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411184"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:07 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 08:59:55 -0500
Subject: [PATCH v2 07/25] cxl/core: Separate region mode from decoder mode
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-7-20189a10ad7d@intel.com>
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
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=9613;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=WLipwvq9440B92e192SQh8N4RKAgn5laswj+ww4UXFU=;
 b=drei73NyZ0C3dQPRKzl26DOZ+6BMPbOjZ1+MG4VwaITa13efRf/I/mfUICKxy0Cc/rSKJACGM
 FN+ij/46iw/DJIZu3vyMHK9ZJ6K470J1JfHe4LmNYW4vRXgzXDQ2Ujx
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Until now region modes and decoder modes were equivalent in that both
modes were either PMEM or RAM.  The addition of Dynamic
Capacity partitions defines up to 8 DC partitions per device.

The region mode is thus no longer equivalent to the endpoint decoder
mode.  IOW the endpoint decoders may have modes of DC0-DC7 while the
region mode is simply DC.

Define a new region mode enumeration which applies to regions separate
from the decoder mode.  Adjust the code to process these modes
independently.

There is no equal to decoder mode dead in region modes.  Avoid
constructing regions with decoders which have been flagged as dead.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: rebase]
[Jonathan: remove dead code]
[Jonathan: clarify commit message]
---
 drivers/cxl/core/region.c | 75 ++++++++++++++++++++++++++++++++++-------------
 drivers/cxl/cxl.h         | 26 ++++++++++++++--
 2 files changed, 79 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 971a314b6b0e..796e5a791e44 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -144,7 +144,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	rc = down_read_interruptible(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (cxlr->mode != CXL_DECODER_PMEM)
+	if (cxlr->mode != CXL_REGION_PMEM)
 		rc = sysfs_emit(buf, "\n");
 	else
 		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
@@ -457,7 +457,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 	 * Support tooling that expects to find a 'uuid' attribute for all
 	 * regions regardless of mode.
 	 */
-	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
+	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_REGION_PMEM)
 		return 0444;
 	return a->mode;
 }
@@ -620,7 +620,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 
-	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
+	return sysfs_emit(buf, "%s\n", cxl_region_mode_name(cxlr->mode));
 }
 static DEVICE_ATTR_RO(mode);
 
@@ -646,7 +646,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 
 	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
 	if (!p->interleave_ways || !p->interleave_granularity ||
-	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
+	    (cxlr->mode == CXL_REGION_PMEM && uuid_is_null(&p->uuid)))
 		return -ENXIO;
 
 	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
@@ -1863,6 +1863,17 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	return rc;
 }
 
+static bool cxl_modes_compatible(enum cxl_region_mode rmode,
+				 enum cxl_decoder_mode dmode)
+{
+	if (rmode == CXL_REGION_RAM && dmode == CXL_DECODER_RAM)
+		return true;
+	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
+		return true;
+
+	return false;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -1882,9 +1893,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return rc;
 	}
 
-	if (cxled->mode != cxlr->mode) {
-		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
-			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
+	if (!cxl_modes_compatible(cxlr->mode, cxled->mode)) {
+		dev_dbg(&cxlr->dev, "%s region mode: %s mismatch decoder: %s\n",
+			dev_name(&cxled->cxld.dev),
+			cxl_region_mode_name(cxlr->mode),
+			cxl_decoder_mode_name(cxled->mode));
 		return -EINVAL;
 	}
 
@@ -2447,7 +2460,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
  * @id: memregion id to create, or memregion_free() on failure
- * @mode: mode for the endpoint decoders of this region
+ * @mode: mode of this region
  * @type: select whether this is an expander or accelerator (type-2 or type-3)
  *
  * This is the second step of region initialization. Regions exist within an
@@ -2458,7 +2471,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
  */
 static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 					      int id,
-					      enum cxl_decoder_mode mode,
+					      enum cxl_region_mode mode,
 					      enum cxl_decoder_type type)
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
@@ -2512,16 +2525,17 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_region_mode mode, int id)
 {
 	int rc;
 
 	switch (mode) {
-	case CXL_DECODER_RAM:
-	case CXL_DECODER_PMEM:
+	case CXL_REGION_RAM:
+	case CXL_REGION_PMEM:
 		break;
 	default:
-		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
+		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
+			cxl_region_mode_name(mode));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -2549,7 +2563,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2569,7 +2583,7 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3215,6 +3229,22 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static enum cxl_region_mode
+cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
+{
+	switch (mode) {
+	case CXL_DECODER_NONE:
+		return CXL_REGION_NONE;
+	case CXL_DECODER_RAM:
+		return CXL_REGION_RAM;
+	case CXL_DECODER_PMEM:
+		return CXL_REGION_PMEM;
+	case CXL_DECODER_MIXED:
+	default:
+		return CXL_REGION_MIXED;
+	}
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3223,12 +3253,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
+	enum cxl_region_mode mode;
 	struct cxl_region *cxlr;
 	struct resource *res;
 	int rc;
 
+	if (cxled->mode == CXL_DECODER_DEAD)
+		return ERR_PTR(-EINVAL);
+
+	mode = cxl_decoder_to_region_mode(cxled->mode);
 	do {
-		cxlr = __create_region(cxlrd, cxled->mode,
+		cxlr = __create_region(cxlrd, mode,
 				       atomic_read(&cxlrd->region_id));
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
@@ -3431,9 +3466,9 @@ static int cxl_region_probe(struct device *dev)
 		return rc;
 
 	switch (cxlr->mode) {
-	case CXL_DECODER_PMEM:
+	case CXL_REGION_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
-	case CXL_DECODER_RAM:
+	case CXL_REGION_RAM:
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
@@ -3445,8 +3480,8 @@ static int cxl_region_probe(struct device *dev)
 			return 0;
 		return devm_cxl_add_dax_region(cxlr);
 	default:
-		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
-			cxlr->mode);
+		dev_dbg(&cxlr->dev, "unsupported region mode: %s\n",
+			cxl_region_mode_name(cxlr->mode));
 		return -ENXIO;
 	}
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..f766b2a8bf53 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -388,6 +388,27 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 	return "mixed";
 }
 
+enum cxl_region_mode {
+	CXL_REGION_NONE,
+	CXL_REGION_RAM,
+	CXL_REGION_PMEM,
+	CXL_REGION_MIXED,
+};
+
+static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
+{
+	static const char * const names[] = {
+		[CXL_REGION_NONE] = "none",
+		[CXL_REGION_RAM] = "ram",
+		[CXL_REGION_PMEM] = "pmem",
+		[CXL_REGION_MIXED] = "mixed",
+	};
+
+	if (mode >= CXL_REGION_NONE && mode <= CXL_REGION_MIXED)
+		return names[mode];
+	return "mixed";
+}
+
 /*
  * Track whether this decoder is reserved for region autodiscovery, or
  * free for userspace provisioning.
@@ -515,7 +536,8 @@ struct cxl_region_params {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
- * @mode: Endpoint decoder allocation / access mode
+ * @mode: Region mode which defines which endpoint decoder modes the region is
+ *        compatible with
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
@@ -528,7 +550,7 @@ struct cxl_region_params {
 struct cxl_region {
 	struct device dev;
 	int id;
-	enum cxl_decoder_mode mode;
+	enum cxl_region_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;

-- 
2.45.2


