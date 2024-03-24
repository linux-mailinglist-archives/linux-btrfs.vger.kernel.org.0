Return-Path: <linux-btrfs+bounces-3545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26348888BA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87BD28D96E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259152B2175;
	Sun, 24 Mar 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mviP4DL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEF15ECC8;
	Sun, 24 Mar 2024 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322312; cv=none; b=YlwD0geG23PgEmUn7bB40wYuEowKbwqjkiP51+3dyI2DuG4JQb7xSqF4A8QLFinlm6cbrEwKkMW1Wu0b90ZF/vxZqrqYXUZfVJTaxcHPL6Ic3Lrhidm+a5u7lsPSEs5VlhOBHFMOLOOATn7ijqRHayHWyCPQBVO6P+ggyKxqKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322312; c=relaxed/simple;
	bh=G0IGndHDbP9hJ9ZtGXbAmQkU6XG/YHY1jlW10czS90M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDtCFrivxsDhju036US08og5Fq+1guaAP3pJzB3E4plnQHJDnTO5aiAtBWkNy/PnQpyUsrVEneKyiIBze8YKmU7oNF7IGnpZXxHAZoHuKZJ6klWtqwLQLafv7SDgcHmHUW19/rVVRk/dkBO2H8a6RhKysTFxGxah+TipMRaxnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mviP4DL5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322310; x=1742858310;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=G0IGndHDbP9hJ9ZtGXbAmQkU6XG/YHY1jlW10czS90M=;
  b=mviP4DL5gsUoVUPnvNA1IMy7VXP9c0L36KBi7UO+EyMZnkDy9elslmMz
   LxcGL4pFr96ewAHN58iOyTrYeFzhd7zcK6lKigooAEXBuurcxv1YBFJBP
   NgfqwZnIF5nrkJNJzhvZL27CYNtVP58XSQpi+5e1pvdlsqVIugvRejVTk
   qrey4Sqgo1PbolUg2TfQr/fnUacUGfDu9rlVgDsAe63I4p81hRRaagppc
   8lXtuovzvSr7HefvHwQdwqzkxMfOBjAv87oMeypAqJglA0v2nu8hxcxab
   CVvZC0pOsm5ZcyDtuO2QAc0kNTHzwu134mluAualEO/Bx5Q4U+PDQoKvD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431765"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431765"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464733"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:22 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:25 -0700
Subject: [PATCH 22/26] dax/region: Support DAX device creation on sparse
 DAX regions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-22-b7b00d623625@intel.com>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=20942;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=G0IGndHDbP9hJ9ZtGXbAmQkU6XG/YHY1jlW10czS90M=;
 b=sTnsAdQLyCQhXXsyBSOBjRc4Ac0EH0nnvrD9WR2Y6dr+jOiZgmnl/QgVNogK51bqo8+/E9JYl
 2ycQewUF0IZDevDWLqic9EUQfGVXBVXUWsr3Ov5mJXqEPXzUa9+rFo0
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Previous patches introduced a new sparse DAX region type.  This region
type may have 0 or more bytes of backing memory.

DAX devices already have the ability to reference sparse ranges of a DAX
region.  Leverage the range support of DAX devices to track memory
across a sparse set of region extents.

Requests for extent removal can be received from the device at any time.
But the host is not obliged to release that memory until it is finished
with it.  Introduce a use count to track how many DAX devices are using
an extent.  If that extent is in use reject the removal of the extent.

Leverage the region RW semaphore to protect the extent data as any
changes to the use of the extent require DAX device, DAX region, and
extent stability during those operations.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v3
[iweiny: simplify the extent objects]
[iweiny: refactor based on the new extent objects created]
[iweiny: remove xarray]
[iweiny: use lock/invalidate/cnt rather than kref]
---
 drivers/cxl/core/extent.c |   8 ++
 drivers/cxl/core/region.c |   6 +-
 drivers/cxl/cxl.h         |   1 +
 drivers/dax/bus.c         | 191 +++++++++++++++++++++++++++++++++++++++-------
 drivers/dax/bus.h         |   3 +-
 drivers/dax/cxl.c         |  55 ++++++++++++-
 drivers/dax/dax-private.h |  23 ++++++
 drivers/dax/hmem/hmem.c   |   2 +-
 drivers/dax/pmem.c        |   2 +-
 9 files changed, 258 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index e98acd98ebe2..633397d62836 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -81,6 +81,14 @@ static void region_extent_unregister(void *ext)
 	device_unregister(&reg_ext->dev);
 }
 
+void dax_reg_ext_release(struct region_extent *reg_ext)
+{
+	struct device *region_dev = reg_ext->dev.parent;
+
+	devm_release_action(region_dev, region_extent_unregister, reg_ext);
+}
+EXPORT_SYMBOL_NS_GPL(dax_reg_ext_release, CXL);
+
 int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
 			  struct range *hpa_range,
 			  const char *label,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a07d95136f0d..7d75512a16bc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1569,7 +1569,11 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
 static void cxl_ed_rm_region_extent(struct cxl_region *cxlr,
 				    struct region_extent *reg_ext)
 {
-	cxl_region_notify_extent(cxlr, DCD_RELEASE_CAPACITY, reg_ext);
+	if (cxl_region_notify_extent(cxlr, DCD_RELEASE_CAPACITY, reg_ext))
+		return;
+
+	/* Extent not in use, release it */
+	dax_reg_ext_release(reg_ext);
 }
 
 struct rm_data {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 156d7c9a8de5..e002c0ea3c2b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -660,6 +660,7 @@ int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
 			  struct range *dpa_range,
 			  struct cxl_endpoint_decoder *cxled);
 
+void dax_reg_ext_release(struct region_extent *dr_ext);
 bool is_region_extent(struct device *dev);
 #define to_region_extent(dev) container_of(dev, struct region_extent, dev)
 
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 56dddaceeccb..70a559763e8c 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -236,11 +236,32 @@ int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(ext_dev, dax_region_release_extent,
+	/* Assume the devm action will be configured without error */
+	dev_set_drvdata(ext_dev, dax_ext);
+	rc = devm_add_action_or_reset(ext_dev, dax_region_release_extent,
 					no_free_ptr(dax_ext));
+	if (rc)
+		dev_set_drvdata(ext_dev, NULL);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(dax_region_add_extent);
 
+int dax_region_rm_extent(struct dax_region *dax_region,
+			 struct device *ext_dev)
+{
+	struct dax_extent *dax_ext;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+
+	dax_ext = dev_get_drvdata(ext_dev);
+	if (!dax_ext || dax_ext->use_cnt == 0)
+		return 0; /* extent not in use */
+
+	dax_ext->invalid = true;
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(dax_region_rm_extent);
+
 bool static_dev_dax(struct dev_dax *dev_dax)
 {
 	return is_static(dev_dax->region);
@@ -354,19 +375,44 @@ static ssize_t region_align_show(struct device *dev,
 static struct device_attribute dev_attr_region_align =
 		__ATTR(align, 0400, region_align_show, NULL);
 
+#define for_each_extent_resource(extent, res) \
+	for (res = (extent)->child; res; res = res->sibling)
+
+unsigned long long
+dax_extent_avail_size(struct resource *ext_res)
+{
+	unsigned long long rc;
+	struct resource *used_res;
+
+	rc = resource_size(ext_res);
+	for_each_extent_resource(ext_res, used_res)
+		rc -= resource_size(used_res);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_extent_avail_size);
+
 #define for_each_dax_region_resource(dax_region, res) \
 	for (res = (dax_region)->res.child; res; res = res->sibling)
 
 static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 {
-	resource_size_t size = resource_size(&dax_region->res);
+	resource_size_t size;
 	struct resource *res;
 
 	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
 
-	if (is_sparse(dax_region))
-		return 0;
+	if (is_sparse(dax_region)) {
+		/*
+		 * Children of a sparse region represent available space not
+		 * used space.
+		 */
+		size = 0;
+		for_each_dax_region_resource(dax_region, res)
+			size += dax_extent_avail_size(res);
+		return size;
+	}
 
+	size = resource_size(&dax_region->res);
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
 	return size;
@@ -507,15 +553,26 @@ EXPORT_SYMBOL_GPL(kill_dev_dax);
 static void trim_dev_dax_range(struct dev_dax *dev_dax)
 {
 	int i = dev_dax->nr_range - 1;
-	struct range *range = &dev_dax->ranges[i].range;
+	struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+	struct range *range = &dev_range->range;
 	struct dax_region *dax_region = dev_dax->region;
+	struct resource *res = &dax_region->res;
 
 	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
 	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
 		(unsigned long long)range->start,
 		(unsigned long long)range->end);
 
-	__release_region(&dax_region->res, range->start, range_len(range));
+	if (dev_range->dax_ext) {
+		res = dev_range->dax_ext->res;
+		dev_dbg(&dev_dax->dev, "Trim sparse extent %pr\n", res);
+	}
+
+	__release_region(res, range->start, range_len(range));
+
+	if (dev_range->dax_ext)
+		dev_range->dax_ext->use_cnt--;
+
 	if (--dev_dax->nr_range == 0) {
 		kfree(dev_dax->ranges);
 		dev_dax->ranges = NULL;
@@ -711,7 +768,7 @@ static void dax_region_unregister(void *region)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
-		unsigned long flags)
+		unsigned long flags, struct dax_reg_sparse_ops *sparse_ops)
 {
 	struct dax_region *dax_region;
 
@@ -729,12 +786,16 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 			|| !IS_ALIGNED(range_len(range), align))
 		return NULL;
 
+	if (!sparse_ops && (flags & IORESOURCE_DAX_SPARSE_CAP))
+		return NULL;
+
 	dax_region = kzalloc(sizeof(*dax_region), GFP_KERNEL);
 	if (!dax_region)
 		return NULL;
 
 	dev_set_drvdata(parent, dax_region);
 	kref_init(&dax_region->kref);
+	dax_region->sparse_ops = sparse_ops;
 	dax_region->id = region_id;
 	dax_region->align = align;
 	dax_region->dev = parent;
@@ -929,7 +990,8 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 }
 
 static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
-			       u64 start, resource_size_t size)
+			       u64 start, resource_size_t size,
+			       struct dax_extent *dax_ext)
 {
 	struct device *dev = &dev_dax->dev;
 	struct dev_dax_range *ranges;
@@ -968,6 +1030,7 @@ static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
 			.start = alloc->start,
 			.end = alloc->end,
 		},
+		.dax_ext = dax_ext,
 	};
 
 	dev_dbg(dev, "alloc range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
@@ -1050,7 +1113,8 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 	int i;
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
-		struct range *range = &dev_dax->ranges[i].range;
+		struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+		struct range *range = &dev_range->range;
 		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
@@ -1066,12 +1130,21 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 			continue;
 		}
 
-		for_each_dax_region_resource(dax_region, res)
-			if (strcmp(res->name, dev_name(dev)) == 0
-					&& res->start == range->start) {
-				adjust = res;
-				break;
-			}
+		if (dev_range->dax_ext) {
+			for_each_extent_resource(dev_range->dax_ext->res, res)
+				if (strcmp(res->name, dev_name(dev)) == 0
+						&& res->start == range->start) {
+					adjust = res;
+					break;
+				}
+		} else {
+			for_each_dax_region_resource(dax_region, res)
+				if (strcmp(res->name, dev_name(dev)) == 0
+						&& res->start == range->start) {
+					adjust = res;
+					break;
+				}
+		}
 
 		if (dev_WARN_ONCE(dev, !adjust || i != dev_dax->nr_range - 1,
 					"failed to find matching resource\n"))
@@ -1109,19 +1182,21 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 }
 
 /**
- * dev_dax_resize_static - Expand the device into the unused portion of the
- * region. This may involve adjusting the end of an existing resource, or
- * allocating a new resource.
+ * __dev_dax_resize - Expand the device into the unused portion of the region.
+ * This may involve adjusting the end of an existing resource, or allocating a
+ * new resource.
  *
  * @parent: parent resource to allocate this range in
  * @dev_dax: DAX device to be expanded
  * @to_alloc: amount of space to alloc; must be <= space available in @parent
+ * @dax_ext: if sparse; the extent containing parent
  *
  * Return the amount of space allocated or -ERRNO on failure
  */
-static ssize_t dev_dax_resize_static(struct resource *parent,
-				     struct dev_dax *dev_dax,
-				     resource_size_t to_alloc)
+static ssize_t __dev_dax_resize(struct resource *parent,
+				struct dev_dax *dev_dax,
+				resource_size_t to_alloc,
+				struct dax_extent *dax_ext)
 {
 	struct resource *res, *first;
 	int rc;
@@ -1129,7 +1204,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	first = parent->child;
 	if (!first) {
 		rc = alloc_dev_dax_range(parent, dev_dax,
-					   parent->start, to_alloc);
+					   parent->start, to_alloc,
+					   dax_ext);
 		if (rc)
 			return rc;
 		return to_alloc;
@@ -1143,7 +1219,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 		if (res == first && res->start > parent->start) {
 			alloc = min(res->start - parent->start, to_alloc);
 			rc = alloc_dev_dax_range(parent, dev_dax,
-						 parent->start, alloc);
+						 parent->start, alloc,
+						 dax_ext);
 			if (rc)
 				return rc;
 			return alloc;
@@ -1167,7 +1244,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 				return rc;
 			return alloc;
 		}
-		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc,
+					 dax_ext);
 		if (rc)
 			return rc;
 		return alloc;
@@ -1178,6 +1256,56 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	return 0;
 }
 
+static ssize_t dev_dax_resize_static(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	return __dev_dax_resize(&dax_region->res, dev_dax, to_alloc, NULL);
+}
+
+static int dax_ext_match_avail_size(struct device *dev, resource_size_t *size_avail)
+{
+	resource_size_t extent_max;
+	struct dax_extent *dax_ext;
+
+	dax_ext = dev_get_drvdata(dev);
+	if (!dax_ext || dax_ext->invalid)
+		return 0;
+
+	extent_max = dax_extent_avail_size(dax_ext->res);
+	if (!extent_max)
+		return 0;
+
+	*size_avail = extent_max;
+	dax_ext->use_cnt++;
+	return 1;
+}
+
+static ssize_t dev_dax_resize_sparse(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	struct dax_extent *dax_ext;
+	resource_size_t extent_max;
+	struct device *ext_dev;
+	ssize_t alloc;
+
+	ext_dev = dax_region->sparse_ops->find_ext(dax_region, &extent_max,
+						   dax_ext_match_avail_size);
+	if (!ext_dev)
+		return -ENOSPC;
+
+	dax_ext = dev_get_drvdata(ext_dev);
+	if (!dax_ext)
+		return -ENOSPC;
+
+	to_alloc = min(extent_max, to_alloc);
+	alloc = __dev_dax_resize(dax_ext->res, dev_dax, to_alloc, dax_ext);
+	if (alloc < 0)
+		dax_ext->use_cnt--;
+	return alloc;
+}
+
 static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		struct dev_dax *dev_dax, resource_size_t size)
 {
@@ -1201,7 +1329,10 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		return -ENXIO;
 
 retry:
-	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
+	if (is_sparse(dax_region))
+		alloc = dev_dax_resize_sparse(dax_region, dev_dax, to_alloc);
+	else
+		alloc = dev_dax_resize_static(dax_region, dev_dax, to_alloc);
 	if (alloc <= 0)
 		return alloc;
 	to_alloc -= alloc;
@@ -1311,7 +1442,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
 		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
-					 to_alloc);
+					 to_alloc, NULL);
 	up_write(&dax_dev_rwsem);
 	up_write(&dax_region_rwsem);
 
@@ -1536,8 +1667,14 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
+	if (is_sparse(dax_region) && data->size) {
+		dev_err(parent, "Sparse DAX region devices are created initially with 0 size");
+		rc = -EINVAL;
+		goto err_id;
+	}
+
 	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
-				 data->size);
+				 data->size, NULL);
 	if (rc)
 		goto err_range;
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 783bfeef42cc..4127eee1bd6d 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -9,6 +9,7 @@ struct dev_dax;
 struct resource;
 struct dax_device;
 struct dax_region;
+struct dax_reg_sparse_ops;
 
 /* dax bus specific ioresource flags */
 #define IORESOURCE_DAX_STATIC BIT(0)
@@ -17,7 +18,7 @@ struct dax_region;
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
-		unsigned long flags);
+		unsigned long flags, struct dax_reg_sparse_ops *sparse_ops);
 
 struct dev_dax_data {
 	struct dax_region *dax_region;
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 83ee45aff69a..3cb95e5988ae 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -53,7 +53,7 @@ static int cxl_dax_region_notify(struct device *dev,
 	case DCD_ADD_CAPACITY:
 		return __cxl_dax_region_add_extent(dax_region, reg_ext);
 	case DCD_RELEASE_CAPACITY:
-		return 0;
+		return dax_region_rm_extent(dax_region, &reg_ext->dev);
 	case DCD_FORCED_CAPACITY_RELEASE:
 	default:
 		dev_err(&cxlr_dax->dev, "Unknown DC event %d\n", nd->event);
@@ -63,6 +63,57 @@ static int cxl_dax_region_notify(struct device *dev,
 	return -ENXIO;
 }
 
+struct match_data {
+	match_cb match_fn;
+	resource_size_t *size_avail;
+};
+
+static int cxl_dax_match_ext(struct device *dev, void *data)
+{
+	struct match_data *md = data;
+
+	if (!is_region_extent(dev))
+		return 0;
+
+	return md->match_fn(dev, md->size_avail);
+}
+
+/**
+ * find_ext - Match Extent callback
+ * @dax_region: region to search
+ * @size_avail: the available size if an extent is found
+ * @match_fn: match function
+ *
+ * Callback to itterate through the child devices of the DAX region calling
+ * match_fn only on those devices which are extents.
+ *
+ * If a match is found match_fn is responsible for locking or reference
+ * counting dax_ext as needed.
+ */
+static struct device *find_ext(struct dax_region *dax_region,
+			       resource_size_t *size_avail,
+			       match_cb match_fn)
+{
+	struct match_data md = {
+		.match_fn = match_fn,
+		.size_avail = size_avail,
+	};
+	struct device *ext_dev;
+
+	ext_dev = device_find_child(dax_region->dev, &md, cxl_dax_match_ext);
+
+	if (!ext_dev)
+		return NULL;
+
+	/* caller must hold a count on extent data */
+	put_device(ext_dev);
+	return ext_dev;
+}
+
+struct dax_reg_sparse_ops sparse_ops = {
+	.find_ext = find_ext,
+};
+
 static int cxl_dax_region_probe(struct device *dev)
 {
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
@@ -81,7 +132,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		flags |= IORESOURCE_DAX_SPARSE_CAP;
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, flags);
+				      PMD_SIZE, flags, &sparse_ops);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index ac1ccf158650..fe3b271e721c 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -20,13 +20,32 @@ void dax_bus_exit(void);
  * struct dax_extent - For sparse regions; an active extent
  * @region: dax_region this resources is in
  * @res: resource this extent covers
+ * @invalid: extent is invalid and going away
+ * @use_cnt: count the number of uses of this extent
  */
 struct dax_extent {
 	struct dax_region *region;
 	struct resource *res;
+	bool invalid;
+	unsigned int use_cnt;
 };
 int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
 			  resource_size_t start, resource_size_t length);
+int dax_region_rm_extent(struct dax_region *dax_region,
+			 struct device *ext_dev);
+unsigned long long dax_extent_avail_size(struct resource *ext_res);
+
+typedef int (*match_cb)(struct device *dev, resource_size_t *size_avail);
+
+/**
+ * struct dax_reg_sparse_ops - Operations for sparse regions
+ * @find_ext: Find the extent matched with match_fn
+ */
+struct dax_reg_sparse_ops {
+	struct device *(*find_ext)(struct dax_region *dax_region,
+				   resource_size_t *size_avail,
+				   match_cb match_fn);
+};
 
 /**
  * struct dax_region - mapping infrastructure for dax devices
@@ -39,6 +58,7 @@ int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
  * @res: resource tree to track instance allocations
  * @seed: allow userspace to find the first unbound seed device
  * @youngest: allow userspace to find the most recently created device
+ * @sparse_ops: operations required for sparce regions
  */
 struct dax_region {
 	int id;
@@ -50,6 +70,7 @@ struct dax_region {
 	struct resource res;
 	struct device *seed;
 	struct device *youngest;
+	struct dax_reg_sparse_ops *sparse_ops;
 };
 
 struct dax_mapping {
@@ -74,6 +95,7 @@ struct dax_mapping {
  * @pgoff: page offset
  * @range: resource-span
  * @mapping: device to assist in interrogating the range layout
+ * @dax_ext: if not NULL; dax region extent referenced by this range
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -91,6 +113,7 @@ struct dev_dax {
 		unsigned long pgoff;
 		struct range range;
 		struct dax_mapping *mapping;
+		struct dax_extent *dax_ext;
 	} *ranges;
 };
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index b9da69f92697..c5ddbcef532f 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -28,7 +28,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 
 	mri = dev->platform_data;
 	dax_region = alloc_dax_region(dev, pdev->id, &mri->range,
-				      mri->target_node, PMD_SIZE, flags);
+				      mri->target_node, PMD_SIZE, flags, NULL);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index f3c6c67b8412..acb311539272 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -54,7 +54,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	range.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
-			IORESOURCE_DAX_STATIC);
+			IORESOURCE_DAX_STATIC, NULL);
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 

-- 
2.44.0


