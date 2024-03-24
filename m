Return-Path: <linux-btrfs+bounces-3548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92BA889934
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670C2B43974
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B24397986;
	Mon, 25 Mar 2024 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONwCAvgp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEF2002C9;
	Sun, 24 Mar 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322300; cv=none; b=jNdN6nG9duwo6jW9WpNGeBLdvfpWhItHmiz+9V8Mf438CwwjfVjmVcryS4boZFdN1YWpcTtNLuCMwnTdrps9X4VF8RSKC4IuQAvYofVl8KzMwNUI9l9J9+ls/ltL8XsMmJblX8pB6Kq0Kbo1vWCGdgUBlxnfiDV4sTOhLAgNv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322300; c=relaxed/simple;
	bh=h1CNRTltsU7gPeX80g46Nck3+CI4jauWHOLhiBqnfJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnT9oXISqS2psTMqcy1/fQFmCb95CsiocXU0JUAlwzdEPMZkqiPenXj43MDZ/g9rW6wwlwssJaisFR5DKlteMoYKtvw//+6dCnqssdF0cm7VkbSp9qnlHP3ZBWwsec9DvPxHWiITGWkyFAsoI4lZeftDIpxb4uAoEWJLu446xT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONwCAvgp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322298; x=1742858298;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=h1CNRTltsU7gPeX80g46Nck3+CI4jauWHOLhiBqnfJQ=;
  b=ONwCAvgp7474I+BfCLhGKlBX7P8vCww7mY16sldczbfOQttAZzthK2vj
   TNnTLN/nH7y64/1PLkCLBXfoirk79GS0IdknLp/SZ+giJBvs5+Nl1T8Sp
   R+W3X8WddiJ6AqrF9j9riuFF9Z9AnleVma9EcUN2qLl6bOl9RaxI+sgfp
   FJTDBIEDKA/K2H0K19kUkmnyoMDgRJFCLmmOi2deOOgmBw288LIhFlBR1
   /GBH5Lmj6VN8WTV8EhBxjMn4aMqqD5tAhQeO/Wu/5O7vWDBeqspwfDc0R
   DBn2yIaX+HsURGFLDTTKcBCMKfXqY2ifiyMcOkkRkmAXLGnEHtWlT3LJh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9260906"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9260906"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15842195"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:08 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:05 -0700
Subject: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=9537;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=V2iP5Szvwem/AOSd5vyUWK3LbafmZL0V8Ed3fQGBvZo=;
 b=zbhEvTN2nNzo9o8XT4Yvnq4HvBT7x0cTu1fxa5482N3wiqcoIfkyCZUtSkrlqa1b2IevYieNZ
 4QdHBzjJz/FA+Rhov0PzbvXJaSudOgqYfR7gG98v5P+o6JKbMMKOClY
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Until now region modes and decoder modes were equivalent in that they
were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
regions (which will represent an array of device regions [better named
partitions] the index of which could be different on different
interleaved devices), the mode of an endpoint decoder and a region will
no longer be equivalent.

Define a new region mode enumeration and adjust the code for it.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
<none>
---
 drivers/cxl/core/region.c | 77 +++++++++++++++++++++++++++++++++++------------
 drivers/cxl/cxl.h         | 26 ++++++++++++++--
 2 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4c7fd2d5cccb..1723d17f121e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -40,7 +40,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	rc = down_read_interruptible(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (cxlr->mode != CXL_DECODER_PMEM)
+	if (cxlr->mode != CXL_REGION_PMEM)
 		rc = sysfs_emit(buf, "\n");
 	else
 		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
@@ -353,7 +353,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 	 * Support tooling that expects to find a 'uuid' attribute for all
 	 * regions regardless of mode.
 	 */
-	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
+	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_REGION_PMEM)
 		return 0444;
 	return a->mode;
 }
@@ -516,7 +516,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 
-	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
+	return sysfs_emit(buf, "%s\n", cxl_region_mode_name(cxlr->mode));
 }
 static DEVICE_ATTR_RO(mode);
 
@@ -542,7 +542,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 
 	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
 	if (!p->interleave_ways || !p->interleave_granularity ||
-	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
+	    (cxlr->mode == CXL_REGION_PMEM && uuid_is_null(&p->uuid)))
 		return -ENXIO;
 
 	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
@@ -1683,6 +1683,17 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
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
@@ -1693,9 +1704,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
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
 
@@ -2168,7 +2181,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
  * @id: memregion id to create, or memregion_free() on failure
- * @mode: mode for the endpoint decoders of this region
+ * @mode: mode of this region
  * @type: select whether this is an expander or accelerator (type-2 or type-3)
  *
  * This is the second step of region initialization. Regions exist within an
@@ -2179,7 +2192,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
  */
 static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 					      int id,
-					      enum cxl_decoder_mode mode,
+					      enum cxl_region_mode mode,
 					      enum cxl_decoder_type type)
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
@@ -2188,11 +2201,12 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
 
@@ -2242,7 +2256,7 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_region_mode mode, int id)
 {
 	int rc;
 
@@ -2270,7 +2284,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2290,7 +2304,7 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2800,6 +2814,24 @@ static int match_region_by_range(struct device *dev, void *data)
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
+
+	return CXL_REGION_MIXED;
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -2808,12 +2840,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
 
@@ -2996,9 +3033,9 @@ static int cxl_region_probe(struct device *dev)
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
@@ -3010,8 +3047,8 @@ static int cxl_region_probe(struct device *dev)
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
index 003feebab79b..9a0cce1e6fca 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -383,6 +383,27 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
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
@@ -511,7 +532,8 @@ struct cxl_region_params {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
- * @mode: Endpoint decoder allocation / access mode
+ * @mode: Region mode which defines which endpoint decoder mode the region is
+ *        compatible with
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
@@ -521,7 +543,7 @@ struct cxl_region_params {
 struct cxl_region {
 	struct device dev;
 	int id;
-	enum cxl_decoder_mode mode;
+	enum cxl_region_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;

-- 
2.44.0


