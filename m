Return-Path: <linux-btrfs+bounces-3532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB9888B7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CEB28E939
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BE22AA9DE;
	Sun, 24 Mar 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZFUAwJ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013512002DB;
	Sun, 24 Mar 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322300; cv=none; b=md+NEWTZHDMqiyGQSQ7LYErFAXvesn3fjaPQxAamF9kklLCgdjZ0uN0mdrSVjjKuFHGhFCdAAy8UKzjhAfsvgbtrxDFcqGqBJyshoMM7mjRkDwJvNhEq2mVO4sG53RkcV1NW+P51RuQBMtv2bj7ouQGUhklauVs/unkP2AJqcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322300; c=relaxed/simple;
	bh=LU3mMInKh8CA4wuJytrcoR1TJCTXH8qvdHqcPiWRSYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUrHR51a8/67c4/hUkFrZmPGMmIy5Dg9CTrHocBrdp+ivbgvRfKTtToB9+HSFbEIzQlqbbRdeyT1HAA+u1Atnf2Y8Zdsdn6EbGCOmP3+Vk+uiNITBCoop/jT4voWZCqxVmsoh/HMsPYVkEQhI9M/oWn/b4xEESzbUxoPC+uh5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZFUAwJ6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322298; x=1742858298;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LU3mMInKh8CA4wuJytrcoR1TJCTXH8qvdHqcPiWRSYc=;
  b=hZFUAwJ6Q2bo04pS8Zm5jngomqyBbSCaSOV8jJzjSs9fyIdQkXy1C3Dc
   18r4Knn04i9R9B77w/BGYwfoIynP/nrSBDqqdrqRO5Yd8U256giJGMazQ
   Lz/jYhUM06U8m3WfAJ716O/pJX9bbO4aNIITNuIM16aFVy8Ks8bM1Rkek
   i1EGs++PvZLYzQFTtcvncZ6no66SdqaINDa0bAJji5y3aCIDdqUoKXWc3
   s8yz9GN61vuJR9tldzKtZpCu1FASZYIiSLcWANxQp+BJuCqIAr6bFE4c+
   YiTad9/HNCF20LbFGafPdm4wKp+9qZNcGMAU0oaIelLTstNwflEOk/LAu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431709"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431709"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464682"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:16 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:12 -0700
Subject: [PATCH 09/26] cxl/region: Add Dynamic Capacity CXL region support
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=8897;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=+w44ZaRnnuSgyXxYYZ37HJrVw/1eUidIfwSam5HwsWQ=;
 b=I6krxIl+DxVHMk247UcvYhObxjCvUUasSgFqtxiAN9orUhOHzPVLzRdzGl+IMtUkxHAVY6ZwA
 4Ll8mzfGHTtC4nmGDNaZ7tYLrBdfb2DiNAhF34CWK+5JJMNBj9Okpf+
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

CXL devices optionally support dynamic capacity.  CXL Regions must be
configured correctly to access this capacity.  Similar to ram and pmem
partitions, DC Regions, as they are called in CXL 3.1, represent
different partitions of the DPA space.

Introduce the concept of a sparse DAX region.  Add the create_dc_region
sysfs entry to create sparse DC DAX regions.  Special case DC capable
regions to create a 0 sized seed DAX device to maintain backwards
compatibility with older software which needs a default DAX device to
hold the region reference.

Flag sparse DAX regions to indicate 0 capacity available until such time
as DC capacity is added.

Interleaving is deferred in this series.  Add an early check.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1:
[djiang: mark sysfs entries to be in 6.10 kernel including date]
[djbw: change dax region typing to be 'sparse' rather than 'dynamic']
[iweiny: rebase changes to master instead of type2 patches]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 22 +++++++++++-----------
 drivers/cxl/core/core.h                 |  1 +
 drivers/cxl/core/port.c                 |  1 +
 drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++++++++++++
 drivers/dax/bus.c                       |  8 ++++++++
 drivers/dax/bus.h                       |  1 +
 drivers/dax/cxl.c                       | 15 +++++++++++++--
 7 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8a4f572c8498..f0cf52fff9fa 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -411,20 +411,20 @@ Description:
 		interleave_granularity).
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
-Date:		May, 2022, January, 2023
-KernelVersion:	v6.0 (pmem), v6.3 (ram)
+What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
+Date:		May, 2022, January, 2023, June 2024
+KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.10 (dc)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a string in the form 'regionZ' to start the process
-		of defining a new persistent, or volatile memory region
-		(interleave-set) within the decode range bounded by root decoder
-		'decoderX.Y'. The value written must match the current value
-		returned from reading this attribute. An atomic compare exchange
-		operation is done on write to assign the requested id to a
-		region and allocate the region-id for the next creation attempt.
-		EBUSY is returned if the region name written does not match the
-		current cached value.
+		of defining a new persistent, volatile, or Dynamic Capacity
+		(DC) memory region (interleave-set) within the decode range
+		bounded by root decoder 'decoderX.Y'. The value written must
+		match the current value returned from reading this attribute.
+		An atomic compare exchange operation is done on write to assign
+		the requested id to a region and allocate the region-id for the
+		next creation attempt.  EBUSY is returned if the region name
+		written does not match the current cached value.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..91abeffbe985 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -13,6 +13,7 @@ extern struct attribute_group cxl_base_attribute_group;
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
+extern struct device_attribute dev_attr_create_dc_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 036b61cb3007..661177b575f7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -335,6 +335,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
+	SET_CXL_REGION_ATTR(create_dc_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ec3b8c6948e9..0d7b09a49dcf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2205,6 +2205,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	switch (mode) {
 	case CXL_REGION_RAM:
 	case CXL_REGION_PMEM:
+	case CXL_REGION_DC:
 		break;
 	default:
 		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
@@ -2314,6 +2315,32 @@ static ssize_t create_ram_region_store(struct device *dev,
 }
 DEVICE_ATTR_RW(create_ram_region);
 
+static ssize_t create_dc_region_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
+static ssize_t create_dc_region_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	struct cxl_region *cxlr;
+	int rc, id;
+
+	rc = sscanf(buf, "region%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	cxlr = __create_region(cxlrd, CXL_REGION_DC, id);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
+
+	return len;
+}
+DEVICE_ATTR_RW(create_dc_region);
+
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -2759,6 +2786,11 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	struct device *dev;
 	int rc;
 
+	if (cxlr->mode == CXL_REGION_DC && cxlr->params.interleave_ways != 1) {
+		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
+		return -EINVAL;
+	}
+
 	cxlr_dax = cxl_dax_region_alloc(cxlr);
 	if (IS_ERR(cxlr_dax))
 		return PTR_ERR(cxlr_dax);
@@ -3040,6 +3072,7 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_REGION_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_REGION_RAM:
+	case CXL_REGION_DC:
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index cb148f74ceda..903566aff5eb 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -181,6 +181,11 @@ static bool is_static(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
 }
 
+static bool is_sparse(struct dax_region *dax_region)
+{
+	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
+}
+
 bool static_dev_dax(struct dev_dax *dev_dax)
 {
 	return is_static(dev_dax->region);
@@ -304,6 +309,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 
 	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
 
+	if (is_sparse(dax_region))
+		return 0;
+
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
 	return size;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..783bfeef42cc 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -13,6 +13,7 @@ struct dax_region;
 /* dax bus specific ioresource flags */
 #define IORESOURCE_DAX_STATIC BIT(0)
 #define IORESOURCE_DAX_KMEM BIT(1)
+#define IORESOURCE_DAX_SPARSE_CAP BIT(2)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index c696837ab23c..415d03fbf9b6 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -13,19 +13,30 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct cxl_region *cxlr = cxlr_dax->cxlr;
 	struct dax_region *dax_region;
 	struct dev_dax_data data;
+	resource_size_t dev_size;
+	unsigned long flags;
 
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
+	flags = IORESOURCE_DAX_KMEM;
+	if (cxlr->mode == CXL_REGION_DC)
+		flags |= IORESOURCE_DAX_SPARSE_CAP;
+
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, IORESOURCE_DAX_KMEM);
+				      PMD_SIZE, flags);
 	if (!dax_region)
 		return -ENOMEM;
 
+	dev_size = range_len(&cxlr_dax->hpa_range);
+	/* Add empty seed dax device */
+	if (cxlr->mode == CXL_REGION_DC)
+		dev_size = 0;
+
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = -1,
-		.size = range_len(&cxlr_dax->hpa_range),
+		.size = dev_size,
 		.memmap_on_memory = true,
 	};
 

-- 
2.44.0


