Return-Path: <linux-btrfs+bounces-3550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808AC8896B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 09:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45E61C305D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4339868B;
	Mon, 25 Mar 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHomoorr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFB236CE1;
	Sun, 24 Mar 2024 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322307; cv=none; b=aN0/EZK0Cle0BEXDChW0QmFuugvpYDjtUaN8DjKcQ7LYTeKUMb5Au2CD5vwOHKI0xHQWeJl/QEjpjbWC5vyCLODekU7wgEY6BaicaIsrGY3uizzkXC0ESfj3DF5fysL9BXc9SxQNBXf5xFm0Q0qYEPANbvqEI3IL8jdifmDS33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322307; c=relaxed/simple;
	bh=IZqFBqovj9w5b04kWEpxsSjxo2TucKltF7PDM/S6mu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWEuzaeOkkPUK7sQ+pAQVFQ087LELV2yRfm/UzA29sj6uMtlWID7n5UFAshnEZrDPzTH7co+EcFu7T028k58TOlD/qZvALQobETc/DICvtnYEp6k9WcwauUzpbeVTMlYVTWB2SKyYEiAjVzXWXkjkOb3cWlZainMcyo/Nm5Scio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHomoorr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322306; x=1742858306;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IZqFBqovj9w5b04kWEpxsSjxo2TucKltF7PDM/S6mu0=;
  b=GHomoorrQgiS87TSjGgiFaZ17UKWo0VvjgGT98rnwDOivWDeWNaY2R0s
   o/FBI3ZxfH4BUzheeEjDK2Jjpp7LRZC6mNxEGifDAVDXYX2Q7eXLjbolE
   TxjuHM3FeDcrdMqWNdSYUpkFMD4Ol6X5h1l30B6nh69GfCEmMhUcphQJS
   R8V19ErTJacRSoEl+8dvxKsPZ+1YjM17Ne5Dhx6IufSfU4E1Ck6VbCENK
   PDcj7Lj9DCntfyUh12BNbMaT0KaRyjsimPtlCGAZgMm80yl7SxphALsW3
   /shryzfrrlHiHW16miAbsALxOdQX59c1S03IisWxb/Sa3DO2b5KInsXQS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431745"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431745"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464710"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:20 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:20 -0700
Subject: [PATCH 17/26] dax/region: Create extent resources on DAX region
 driver load
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-17-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=6268;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=uW2K4YJK+QU1uOOUdZ9NGHrCKT5Q4KuadM77x+M1R7E=;
 b=etzHC0KZ70w39eMR5Arfv8AD/8/NpO5ETQZT79OSFkZF8fRBppU9/JRIogrZxW+Kk2kkhkUJj
 IYr9K+mo9cbCvpyXeYM8HFQqCggMDzUJyW1n4MZM17Ney6ucG3EDDLg
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

DAX regions mapping dynamic capacity partitions introduce a requirement
for the memory backing the region to come and go as required.  This
results in a DAX region with sparse areas of memory backing.  To track
the sparseness of the region, DAX extent objects need to track
sub-resource information as a new layer between the DAX region resource
and DAX device range resources.

Recall that DCD extents may be accepted when a region is first created.
Extend this support on region driver load.  Scan existing extents and
create DAX extent resources as a first step to DAX extent realization.

The lifetime of a DAX extent is tricky to manage because the extent life
may end in one of two ways.  First, the device may request the extent be
released.  Second, the region may release the extent when it is
destroyed without hardware involvement.  Support extent release without
hardware involvement first.  Subsequent patches will provide for
hardware to request extent removal.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
[iweiny: remove xarrays]
[iweiny: remove as much of extra reference stuff as possible]
[iweiny: Move extent resource handling to core DAX code]
---
 drivers/dax/bus.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/cxl.c         | 43 ++++++++++++++++++++++++++++++++++--
 drivers/dax/dax-private.h | 12 +++++++++++
 3 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 903566aff5eb..4d5ed7ab6537 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -186,6 +186,61 @@ static bool is_sparse(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
 }
 
+static int dax_region_add_resource(struct dax_region *dax_region,
+				   struct dax_extent *dax_ext,
+				   resource_size_t start,
+				   resource_size_t length)
+{
+	struct resource *ext_res;
+
+	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
+	ext_res = __request_region(&dax_region->res, start, length, "extent", 0);
+	if (!ext_res) {
+		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
+			&start, &length);
+		return -ENOSPC;
+	}
+
+	dax_ext->region = dax_region;
+	dax_ext->res = ext_res;
+	dev_dbg(dax_region->dev, "Extent add resource %pr\n", ext_res);
+
+	return 0;
+}
+
+static void dax_region_release_extent(void *ext)
+{
+	struct dax_extent *dax_ext = ext;
+	struct dax_region *dax_region = dax_ext->region;
+
+	dev_dbg(dax_region->dev, "Extent release resource %pr\n", dax_ext->res);
+	if (dax_ext->res)
+		__release_region(&dax_region->res, dax_ext->res->start,
+				 resource_size(dax_ext->res));
+
+	kfree(dax_ext);
+}
+
+int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
+			  resource_size_t start, resource_size_t length)
+{
+	int rc;
+
+	struct dax_extent *dax_ext __free(kfree) = kzalloc(sizeof(*dax_ext),
+							   GFP_KERNEL);
+	if (!dax_ext)
+		return -ENOMEM;
+
+	guard(rwsem_write)(&dax_region_rwsem);
+	rc = dax_region_add_resource(dax_region, dax_ext, start, length);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(ext_dev, dax_region_release_extent,
+					no_free_ptr(dax_ext));
+}
+EXPORT_SYMBOL_GPL(dax_region_add_extent);
+
 bool static_dev_dax(struct dev_dax *dev_dax)
 {
 	return is_static(dev_dax->region);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 415d03fbf9b6..70bdc7a878ab 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -5,6 +5,42 @@
 
 #include "../cxl/cxl.h"
 #include "bus.h"
+#include "dax-private.h"
+
+static int __cxl_dax_region_add_extent(struct dax_region *dax_region,
+				       struct region_extent *reg_ext)
+{
+	struct device *ext_dev = &reg_ext->dev;
+	resource_size_t start, length;
+
+	dev_dbg(dax_region->dev, "Adding extent HPA %#llx - %#llx\n",
+		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
+
+	start = dax_region->res.start + reg_ext->hpa_range.start;
+	length = reg_ext->hpa_range.end - reg_ext->hpa_range.start + 1;
+
+	return dax_region_add_extent(dax_region, ext_dev, start, length);
+}
+
+static int cxl_dax_region_add_extent(struct device *dev, void *data)
+{
+	struct dax_region *dax_region = data;
+	struct region_extent *reg_ext;
+
+	if (!is_region_extent(dev))
+		return 0;
+
+	reg_ext = to_region_extent(dev);
+
+	return __cxl_dax_region_add_extent(dax_region, reg_ext);
+}
+
+static void cxl_dax_region_add_extents(struct cxl_dax_region *cxlr_dax,
+				      struct dax_region *dax_region)
+{
+	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
+	device_for_each_child(&cxlr_dax->dev, dax_region, cxl_dax_region_add_extent);
+}
 
 static int cxl_dax_region_probe(struct device *dev)
 {
@@ -29,9 +65,12 @@ static int cxl_dax_region_probe(struct device *dev)
 		return -ENOMEM;
 
 	dev_size = range_len(&cxlr_dax->hpa_range);
-	/* Add empty seed dax device */
-	if (cxlr->mode == CXL_REGION_DC)
+	if (cxlr->mode == CXL_REGION_DC) {
+		/* NOTE: Depends on dax_region being set in driver data */
+		cxl_dax_region_add_extents(cxlr_dax, dax_region);
+		/* Add empty seed dax device */
 		dev_size = 0;
+	}
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 446617b73aea..c6319c6567fb 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -16,6 +16,18 @@ struct inode *dax_inode(struct dax_device *dax_dev);
 int dax_bus_init(void);
 void dax_bus_exit(void);
 
+/**
+ * struct dax_extent - For sparse regions; an active extent
+ * @region: dax_region this resources is in
+ * @res: resource this extent covers
+ */
+struct dax_extent {
+	struct dax_region *region;
+	struct resource *res;
+};
+int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
+			  resource_size_t start, resource_size_t length);
+
 /**
  * struct dax_region - mapping infrastructure for dax devices
  * @id: kernel-wide unique region for a memory range

-- 
2.44.0


