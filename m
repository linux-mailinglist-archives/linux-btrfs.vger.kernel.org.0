Return-Path: <linux-btrfs+bounces-7280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36A954D0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F011C22176
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676341CCB2B;
	Fri, 16 Aug 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiQoumak"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E11C9EAB;
	Fri, 16 Aug 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819526; cv=none; b=pP1MXUtqQmBPD2fLLIr9Sjk+vKivO2gYQnpEiqZ+d33O2/Kq85nEPF2FPXwVn/y0BlRMDSLOHkVNcsdAJQwTpS10i3XFrJTbHnNNUOW/Q0gCo1IHAULMWly3kiXMjasDh3fn2XC+DMhcS3c+qc0m6mbPIbUKutboz/8ewd71qhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819526; c=relaxed/simple;
	bh=tzK9PBWGp0J17dmtABXkahnSGs5L2l3UVxeHZyinL/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6PNszXUv6rHiF/281VIOXjv+18IlBMB5Ds3dpe1eJYV3Iyd7NDAkoAu7T72tK9gF+JNTGyKZf64ZbI/xZ+Qqvot5CmezrnoHZIFyPju9NMIg6rUWEeuQL0fCGN59Qj4qqH+vY2iuhJCfCu5L/fXvfRvuqLZh3q5ASNsTc/HIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiQoumak; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819524; x=1755355524;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tzK9PBWGp0J17dmtABXkahnSGs5L2l3UVxeHZyinL/g=;
  b=SiQoumakgTGonvprV3VpxsxwN18x5D7rPKnjA+21GtV+PobaJ+o6yhT9
   SAQPQg0gh6V6QxBGLJUiE13eM/bgCEfJdDHt8UuJ86iJZa5eo0aw9VVSQ
   XuOPtl7j3quiubKWa1DlKdR0VeyCGXcgNNekdmjSLydnV7CDvECFBGS5g
   VorJ6RCYmeq5/yBQdYDFWGN9+Fagx26PscaJY1wsqJxY1KNTCsFvlqKpz
   X8q9IlycbvKDcaLqcZYK933czxJAbCrXX2SjihLGWBJvh9OjV5o/IOA/m
   vTxH+NSJYlCIH8JKWirLx9T3sdrOfYK42JaA7bzioGW74W4E2+FmEGdRK
   w==;
X-CSE-ConnectionGUID: K0JOZaLORqW36cv8eO5I8w==
X-CSE-MsgGUID: Ixz4YT/ETKCGNoHYIwMEMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21973105"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="21973105"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:21 -0700
X-CSE-ConnectionGUID: +a5m7FfpRDisATMV/MDYEw==
X-CSE-MsgGUID: 5EQR4I2WSZadqJESX//xAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="97205596"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:19 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:44:29 -0500
Subject: [PATCH v3 21/25] dax/region: Create resources on sparse DAX
 regions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-21-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819456; l=26205;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=0OhpyVX09Kez0rZtNDHRqF+W5wjGGgKkoF+xH6iDA/g=;
 b=KaItpPWIASbZ20WRie1i8+a6H6LWAkNcHKJ1UgMGTepdmBpqOq1G+jpakPs5W6mYNjCP59PdG
 C729PJy0BGCBnr3lKq4KkKFNmrTrteYKWUV/wtBwjeS2olxUPDYdRe2
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

DAX regions which map dynamic capacity partitions require that memory be
allowed to come and go.  Recall sparse regions were created for this
purpose.  Now that extents can be realized within DAX regions the DAX
region driver can start tracking sub-resource information.

The tight relationship between DAX region operations and extent
operations require memory changes to be controlled synchronously with
the user of the region.  Synchronize through the dax_region_rwsem and by
having the region driver drive both the region device as well as the
extent sub-devices.

Recall requests to remove extents can happen at any time and that a host
is not obligated to release the memory until it is not being used.  If
an extent is not used allow a release response.

The DAX layer has no need for the details of the CXL memory extent
devices.  Expose extents to the DAX layer as device children of the DAX
region device.  A single callback from the driver aids the DAX layer to
determine if the child device is an extent.  The DAX layer also
registers a devres function to automatically clean up when the device is
removed from the region.

There is a race between extents being surfaced and the dax_cxl driver
being loaded.  The driver must therefore scan for any existing extents
while still under the device lock.

Respond to extent notifications.  Manage the DAX region resource tree
based on the extents lifetime.  Return the status of remove
notifications to lower layers such that it can manage the hardware
appropriately.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: patch reorder]
[iweiny: move hunks from other patches to clarify code changes and
         add/release flows WRT dax regions]
[iweiny: use %par]
[iweiny: clean up variable names]
[iweiny: Simplify sparse_ops]
[Fan: avoid open coding range_len()]
[djbw: s/reg_ext/region_extent]
---
 drivers/cxl/core/extent.c |  76 +++++++++++++--
 drivers/cxl/cxl.h         |   6 ++
 drivers/dax/bus.c         | 243 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/dax/bus.h         |   3 +-
 drivers/dax/cxl.c         |  63 +++++++++++-
 drivers/dax/dax-private.h |  34 +++++++
 drivers/dax/hmem/hmem.c   |   2 +-
 drivers/dax/pmem.c        |   2 +-
 8 files changed, 391 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index d7d526a51e2b..103b0bec3a4a 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -271,20 +271,67 @@ static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
 	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
 }
 
+static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+			      struct region_extent *region_extent)
+{
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+	int rc = 0;
+
+	cxlr_dax = cxlr->cxlr_dax;
+	dev = &cxlr_dax->dev;
+	dev_dbg(dev, "Trying notify: type %d HPA %par\n",
+		event, &region_extent->hpa_range);
+
+	/*
+	 * NOTE the lack of a driver indicates a notification has failed.  No
+	 * user space coordiantion was possible.
+	 */
+	device_lock(dev);
+	if (dev->driver) {
+		struct cxl_driver *driver = to_cxl_drv(dev->driver);
+		struct cxl_notify_data notify_data = (struct cxl_notify_data) {
+			.event = event,
+			.region_extent = region_extent,
+		};
+
+		if (driver->notify) {
+			dev_dbg(dev, "Notify: type %d HPA %par\n",
+				event, &region_extent->hpa_range);
+			rc = driver->notify(dev, &notify_data);
+		}
+	}
+	device_unlock(dev);
+	return rc;
+}
+
+struct rm_data {
+	struct cxl_region *cxlr;
+	struct range *range;
+};
+
 static int cxlr_rm_extent(struct device *dev, void *data)
 {
 	struct region_extent *region_extent = to_region_extent(dev);
-	struct range *region_hpa_range = data;
+	struct rm_data *rm_data = data;
+	int rc;
 
 	if (!region_extent)
 		return 0;
 
 	/*
-	 * Any extent which 'touches' the released range is removed.
+	 * Any extent which 'touches' the released range is attempted to be
+	 * removed.
 	 */
-	if (range_overlaps(region_hpa_range, &region_extent->hpa_range)) {
+	if (range_overlaps(rm_data->range, &region_extent->hpa_range)) {
+		struct cxl_region *cxlr = rm_data->cxlr;
+
 		dev_dbg(dev, "Remove region extent HPA %par\n",
 			&region_extent->hpa_range);
+		rc = cxlr_notify_extent(cxlr, DCD_RELEASE_CAPACITY, region_extent);
+		if (rc == -EBUSY)
+			return 0;
+		/* Extent not in use or error, remove it */
 		region_rm_extent(region_extent);
 	}
 	return 0;
@@ -312,8 +359,13 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
 
 	calc_hpa_range(cxled, cxlr->cxlr_dax, &dpa_range, &hpa_range);
 
+	struct rm_data rm_data = {
+		.cxlr = cxlr,
+		.range = &hpa_range,
+	};
+
 	/* Remove region extents which overlap */
-	return device_for_each_child(&cxlr->cxlr_dax->dev, &hpa_range,
+	return device_for_each_child(&cxlr->cxlr_dax->dev, &rm_data,
 				     cxlr_rm_extent);
 }
 
@@ -338,8 +390,20 @@ static int cxlr_add_extent(struct cxl_dax_region *cxlr_dax,
 		return rc;
 	}
 
-	/* device model handles freeing region_extent */
-	return online_region_extent(region_extent);
+	rc = online_region_extent(region_extent);
+	/* device model handled freeing region_extent */
+	if (rc)
+		return rc;
+
+	rc = cxlr_notify_extent(cxlr_dax->cxlr, DCD_ADD_CAPACITY, region_extent);
+	/*
+	 * The region device was breifly live but DAX layer ensures it was not
+	 * used
+	 */
+	if (rc)
+		region_rm_extent(region_extent);
+
+	return rc;
 }
 
 /* Callers are expected to ensure cxled has been attached to a region */
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c858e3957fd5..9abbfc68c6ad 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -916,10 +916,16 @@ bool is_cxl_region(struct device *dev);
 
 extern struct bus_type cxl_bus_type;
 
+struct cxl_notify_data {
+	enum dc_event event;
+	struct region_extent *region_extent;
+};
+
 struct cxl_driver {
 	const char *name;
 	int (*probe)(struct device *dev);
 	void (*remove)(struct device *dev);
+	int (*notify)(struct device *dev, struct cxl_notify_data *notify_data);
 	struct device_driver drv;
 	int id;
 };
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 975860371d9f..f14b0cfa7edd 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -183,6 +183,83 @@ static bool is_sparse(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
 }
 
+static void __dax_release_resource(struct dax_resource *dax_resource)
+{
+	struct dax_region *dax_region = dax_resource->region;
+
+	lockdep_assert_held_write(&dax_region_rwsem);
+	dev_dbg(dax_region->dev, "Extent release resource %pr\n",
+		dax_resource->res);
+	if (dax_resource->res)
+		__release_region(&dax_region->res, dax_resource->res->start,
+				 resource_size(dax_resource->res));
+	dax_resource->res = NULL;
+}
+
+static void dax_release_resource(void *res)
+{
+	struct dax_resource *dax_resource = res;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+	__dax_release_resource(dax_resource);
+	kfree(dax_resource);
+}
+
+int dax_region_add_resource(struct dax_region *dax_region,
+			    struct device *device,
+			    resource_size_t start, resource_size_t length)
+{
+	struct resource *new_resource;
+	int rc;
+
+	struct dax_resource *dax_resource __free(kfree) =
+				kzalloc(sizeof(*dax_resource), GFP_KERNEL);
+	if (!dax_resource)
+		return -ENOMEM;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+
+	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
+	new_resource = __request_region(&dax_region->res, start, length, "extent", 0);
+	if (!new_resource) {
+		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
+			&start, &length);
+		return -ENOSPC;
+	}
+
+	dev_dbg(dax_region->dev, "add resource %pr\n", new_resource);
+	dax_resource->region = dax_region;
+	dax_resource->res = new_resource;
+	dev_set_drvdata(device, dax_resource);
+	rc = devm_add_action_or_reset(device, dax_release_resource,
+				      no_free_ptr(dax_resource));
+	/*  On error; ensure driver data is cleared under semaphore */
+	if (rc)
+		dev_set_drvdata(device, NULL);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_region_add_resource);
+
+int dax_region_rm_resource(struct dax_region *dax_region,
+			   struct device *dev)
+{
+	struct dax_resource *dax_resource;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+
+	dax_resource = dev_get_drvdata(dev);
+	if (!dax_resource)
+		return 0;
+
+	if (dax_resource->use_cnt)
+		return -EBUSY;
+
+	/* avoid races with users trying to use the extent */
+	__dax_release_resource(dax_resource);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_region_rm_resource);
+
 bool static_dev_dax(struct dev_dax *dev_dax)
 {
 	return is_static(dev_dax->region);
@@ -296,19 +373,44 @@ static ssize_t region_align_show(struct device *dev,
 static struct device_attribute dev_attr_region_align =
 		__ATTR(align, 0400, region_align_show, NULL);
 
+#define for_each_child_resource(extent, res) \
+	for (res = (extent)->child; res; res = res->sibling)
+
+resource_size_t
+dax_avail_size(struct resource *dax_resource)
+{
+	resource_size_t rc;
+	struct resource *used_res;
+
+	rc = resource_size(dax_resource);
+	for_each_child_resource(dax_resource, used_res)
+		rc -= resource_size(used_res);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_avail_size);
+
 #define for_each_dax_region_resource(dax_region, res) \
 	for (res = (dax_region)->res.child; res; res = res->sibling)
 
 static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 {
-	resource_size_t size = resource_size(&dax_region->res);
+	resource_size_t size;
 	struct resource *res;
 
 	lockdep_assert_held(&dax_region_rwsem);
 
-	if (is_sparse(dax_region))
-		return 0;
+	if (is_sparse(dax_region)) {
+		/*
+		 * Children of a sparse region represent available space not
+		 * used space.
+		 */
+		size = 0;
+		for_each_dax_region_resource(dax_region, res)
+			size += dax_avail_size(res);
+		return size;
+	}
 
+	size = resource_size(&dax_region->res);
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
 	return size;
@@ -449,15 +551,26 @@ EXPORT_SYMBOL_GPL(kill_dev_dax);
 static void trim_dev_dax_range(struct dev_dax *dev_dax)
 {
 	int i = dev_dax->nr_range - 1;
-	struct range *range = &dev_dax->ranges[i].range;
+	struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+	struct range *range = &dev_range->range;
 	struct dax_region *dax_region = dev_dax->region;
+	struct resource *res = &dax_region->res;
 
 	lockdep_assert_held_write(&dax_region_rwsem);
 	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
 		(unsigned long long)range->start,
 		(unsigned long long)range->end);
 
-	__release_region(&dax_region->res, range->start, range_len(range));
+	if (dev_range->dax_resource) {
+		res = dev_range->dax_resource->res;
+		dev_dbg(&dev_dax->dev, "Trim sparse extent %pr\n", res);
+	}
+
+	__release_region(res, range->start, range_len(range));
+
+	if (dev_range->dax_resource)
+		dev_range->dax_resource->use_cnt--;
+
 	if (--dev_dax->nr_range == 0) {
 		kfree(dev_dax->ranges);
 		dev_dax->ranges = NULL;
@@ -640,7 +753,7 @@ static void dax_region_unregister(void *region)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
-		unsigned long flags)
+		unsigned long flags, struct dax_sparse_ops *sparse_ops)
 {
 	struct dax_region *dax_region;
 
@@ -658,12 +771,16 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
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
@@ -845,7 +962,8 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 }
 
 static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
-			       u64 start, resource_size_t size)
+			       u64 start, resource_size_t size,
+			       struct dax_resource *dax_resource)
 {
 	struct device *dev = &dev_dax->dev;
 	struct dev_dax_range *ranges;
@@ -884,6 +1002,7 @@ static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
 			.start = alloc->start,
 			.end = alloc->end,
 		},
+		.dax_resource = dax_resource,
 	};
 
 	dev_dbg(dev, "alloc range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
@@ -966,7 +1085,8 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 	int i;
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
-		struct range *range = &dev_dax->ranges[i].range;
+		struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+		struct range *range = &dev_range->range;
 		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
@@ -982,12 +1102,21 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 			continue;
 		}
 
-		for_each_dax_region_resource(dax_region, res)
-			if (strcmp(res->name, dev_name(dev)) == 0
-					&& res->start == range->start) {
-				adjust = res;
-				break;
-			}
+		if (dev_range->dax_resource) {
+			for_each_child_resource(dev_range->dax_resource->res, res)
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
@@ -1025,19 +1154,21 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
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
+ * @dax_resource: if sparse; the parent resource
  *
  * Return the amount of space allocated or -ERRNO on failure
  */
-static ssize_t dev_dax_resize_static(struct resource *parent,
-				     struct dev_dax *dev_dax,
-				     resource_size_t to_alloc)
+static ssize_t __dev_dax_resize(struct resource *parent,
+				struct dev_dax *dev_dax,
+				resource_size_t to_alloc,
+				struct dax_resource *dax_resource)
 {
 	struct resource *res, *first;
 	int rc;
@@ -1045,7 +1176,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	first = parent->child;
 	if (!first) {
 		rc = alloc_dev_dax_range(parent, dev_dax,
-					   parent->start, to_alloc);
+					   parent->start, to_alloc,
+					   dax_resource);
 		if (rc)
 			return rc;
 		return to_alloc;
@@ -1059,7 +1191,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 		if (res == first && res->start > parent->start) {
 			alloc = min(res->start - parent->start, to_alloc);
 			rc = alloc_dev_dax_range(parent, dev_dax,
-						 parent->start, alloc);
+						 parent->start, alloc,
+						 dax_resource);
 			if (rc)
 				return rc;
 			return alloc;
@@ -1083,7 +1216,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 				return rc;
 			return alloc;
 		}
-		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc,
+					 dax_resource);
 		if (rc)
 			return rc;
 		return alloc;
@@ -1094,6 +1228,54 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	return 0;
 }
 
+static ssize_t dev_dax_resize_static(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	return __dev_dax_resize(&dax_region->res, dev_dax, to_alloc, NULL);
+}
+
+static int find_free_extent(struct device *dev, void *data)
+{
+	struct dax_region *dax_region = data;
+	struct dax_resource *dax_resource;
+
+	if (!dax_region->sparse_ops->is_extent(dev))
+		return 0;
+
+	dax_resource = dev_get_drvdata(dev);
+	if (!dax_resource || !dax_avail_size(dax_resource->res))
+		return 0;
+	return 1;
+}
+
+static ssize_t dev_dax_resize_sparse(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	struct dax_resource *dax_resource;
+	resource_size_t available_size;
+	struct device *extent_dev;
+	ssize_t alloc;
+
+	extent_dev = device_find_child(dax_region->dev, dax_region,
+				       find_free_extent);
+	if (!extent_dev)
+		return 0;
+
+	dax_resource = dev_get_drvdata(extent_dev);
+	if (!dax_resource)
+		return 0;
+
+	available_size = dax_avail_size(dax_resource->res);
+	to_alloc = min(available_size, to_alloc);
+	alloc = __dev_dax_resize(dax_resource->res, dev_dax, to_alloc, dax_resource);
+	if (alloc > 0)
+		dax_resource->use_cnt++;
+	put_device(extent_dev);
+	return alloc;
+}
+
 static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		struct dev_dax *dev_dax, resource_size_t size)
 {
@@ -1117,7 +1299,10 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
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
@@ -1226,7 +1411,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
 		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
-					 to_alloc);
+					 to_alloc, NULL);
 	up_write(&dax_dev_rwsem);
 	up_write(&dax_region_rwsem);
 
@@ -1494,8 +1679,14 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
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
index 783bfeef42cc..ae5029ea6047 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -9,6 +9,7 @@ struct dev_dax;
 struct resource;
 struct dax_device;
 struct dax_region;
+struct dax_sparse_ops;
 
 /* dax bus specific ioresource flags */
 #define IORESOURCE_DAX_STATIC BIT(0)
@@ -17,7 +18,7 @@ struct dax_region;
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
-		unsigned long flags);
+		unsigned long flags, struct dax_sparse_ops *sparse_ops);
 
 struct dev_dax_data {
 	struct dax_region *dax_region;
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 367e86b1c22a..bf3b82b0120d 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -5,6 +5,60 @@
 
 #include "../cxl/cxl.h"
 #include "bus.h"
+#include "dax-private.h"
+
+static int __cxl_dax_add_resource(struct dax_region *dax_region,
+				  struct region_extent *region_extent)
+{
+	resource_size_t start, length;
+	struct device *dev;
+
+	dev = &region_extent->dev;
+	start = dax_region->res.start + region_extent->hpa_range.start;
+	length = range_len(&region_extent->hpa_range);
+	return dax_region_add_resource(dax_region, dev, start, length);
+}
+
+static int cxl_dax_add_resource(struct device *dev, void *data)
+{
+	struct dax_region *dax_region = data;
+	struct region_extent *region_extent;
+
+	region_extent = to_region_extent(dev);
+	if (!region_extent)
+		return 0;
+
+	dev_dbg(dax_region->dev, "Adding resource HPA %par\n",
+		&region_extent->hpa_range);
+
+	return __cxl_dax_add_resource(dax_region, region_extent);
+}
+
+static int cxl_dax_region_notify(struct device *dev,
+				 struct cxl_notify_data *notify_data)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	struct region_extent *region_extent = notify_data->region_extent;
+
+	switch (notify_data->event) {
+	case DCD_ADD_CAPACITY:
+		return __cxl_dax_add_resource(dax_region, region_extent);
+	case DCD_RELEASE_CAPACITY:
+		return dax_region_rm_resource(dax_region, &region_extent->dev);
+	case DCD_FORCED_CAPACITY_RELEASE:
+	default:
+		dev_err(&cxlr_dax->dev, "Unknown DC event %d\n",
+			notify_data->event);
+		break;
+	}
+
+	return -ENXIO;
+}
+
+struct dax_sparse_ops sparse_ops = {
+	.is_extent = is_region_extent,
+};
 
 static int cxl_dax_region_probe(struct device *dev)
 {
@@ -24,14 +78,16 @@ static int cxl_dax_region_probe(struct device *dev)
 		flags |= IORESOURCE_DAX_SPARSE_CAP;
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, flags);
+				      PMD_SIZE, flags, &sparse_ops);
 	if (!dax_region)
 		return -ENOMEM;
 
-	if (cxlr->mode == CXL_REGION_DC)
+	if (cxlr->mode == CXL_REGION_DC) {
+		device_for_each_child(&cxlr_dax->dev, dax_region,
+				      cxl_dax_add_resource);
 		/* Add empty seed dax device */
 		dev_size = 0;
-	else
+	} else
 		dev_size = range_len(&cxlr_dax->hpa_range);
 
 	data = (struct dev_dax_data) {
@@ -47,6 +103,7 @@ static int cxl_dax_region_probe(struct device *dev)
 static struct cxl_driver cxl_dax_region_driver = {
 	.name = "cxl_dax_region",
 	.probe = cxl_dax_region_probe,
+	.notify = cxl_dax_region_notify,
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index ccde98c3d4e2..9e9f98c85620 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -16,6 +16,36 @@ struct inode *dax_inode(struct dax_device *dax_dev);
 int dax_bus_init(void);
 void dax_bus_exit(void);
 
+/**
+ * struct dax_resource - For sparse regions; an active resource
+ * @region: dax_region this resources is in
+ * @res: resource
+ * @use_cnt: count the number of uses of this resource
+ *
+ * Changes to the dax_reigon and the dax_resources within it are protected by
+ * dax_region_rwsem
+ */
+struct dax_resource {
+	struct dax_region *region;
+	struct resource *res;
+	unsigned int use_cnt;
+};
+int dax_region_add_resource(struct dax_region *dax_region, struct device *dev,
+			    resource_size_t start, resource_size_t length);
+int dax_region_rm_resource(struct dax_region *dax_region,
+			   struct device *dev);
+resource_size_t dax_avail_size(struct resource *dax_resource);
+
+typedef int (*match_cb)(struct device *dev, resource_size_t *size_avail);
+
+/**
+ * struct dax_sparse_ops - Operations for sparse regions
+ * @is_extent: return if the device is an extent
+ */
+struct dax_sparse_ops {
+	bool (*is_extent)(struct device *dev);
+};
+
 /**
  * struct dax_region - mapping infrastructure for dax devices
  * @id: kernel-wide unique region for a memory range
@@ -27,6 +57,7 @@ void dax_bus_exit(void);
  * @res: resource tree to track instance allocations
  * @seed: allow userspace to find the first unbound seed device
  * @youngest: allow userspace to find the most recently created device
+ * @sparse_ops: operations required for sparse regions
  */
 struct dax_region {
 	int id;
@@ -38,6 +69,7 @@ struct dax_region {
 	struct resource res;
 	struct device *seed;
 	struct device *youngest;
+	struct dax_sparse_ops *sparse_ops;
 };
 
 struct dax_mapping {
@@ -62,6 +94,7 @@ struct dax_mapping {
  * @pgoff: page offset
  * @range: resource-span
  * @mapping: device to assist in interrogating the range layout
+ * @dax_resource: if not NULL; dax sparse resource containing this range
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -79,6 +112,7 @@ struct dev_dax {
 		unsigned long pgoff;
 		struct range range;
 		struct dax_mapping *mapping;
+		struct dax_resource *dax_resource;
 	} *ranges;
 };
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f18491..0eea65052874 100644
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
index c8ebf4e281f2..f927e855f240 100644
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
2.45.2


