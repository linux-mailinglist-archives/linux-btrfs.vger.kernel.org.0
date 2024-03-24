Return-Path: <linux-btrfs+bounces-3542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68753888B9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C96828C8D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335901FEC63;
	Sun, 24 Mar 2024 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5zWWqv8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E48236CFA;
	Sun, 24 Mar 2024 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322309; cv=none; b=Bn07Fq1tEqT7SW2r4N+QHcjiCfhi6AOP6QGF4kDC8v+cKr6qfmGJR/95Mc0yI+rA00aFn0D2yRbxB6udxfGK7p9Oh1KP2LoBNovAkeCNS8uu6jz+sSSZ0DTv3ZJl03HGLnf/oOQzq7DoCewOfWqBk8aIcgNEE4qtAZtJSLyhCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322309; c=relaxed/simple;
	bh=EWYEgLHalFugQDxHMuZ1SSZaWkLeAcVsY/Km0kOJIZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWmFsaSbMelA8ieb6c36LEkhV4llN603z37juGBstW7kVqf3owWQ7aR2BuvErt08YNs78/j/GHDuubyriHvAUNIz4bWVZq9/XpSidGiIm2Q5M6OLXjfRJFueWdDzPlfz2zetlTSjXZ+LaAwtrgsWZrUqnsh6Ecvhv1vzK3lMG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5zWWqv8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322307; x=1742858307;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EWYEgLHalFugQDxHMuZ1SSZaWkLeAcVsY/Km0kOJIZo=;
  b=H5zWWqv844hh+z8vBY+AYQKEFqhrGhoLLoGT9XdVaDjhz6YGyvc3J8QM
   LrwaqJnwyriZa4ZwNb9lNMky38kqf7EXLj80dVROBX9+L2wJbet7qkGzP
   notcX6rkI9uV7Eci8pkIfhd1NsfQAhKw3o6Yx5V6fREgASIn3R4+oAd9R
   LqyRqHrvthAc7q+Jv1gvd5lJidQDh+CnHMjFhpilqIC8/jxPxQGY4GFuz
   RkQ/I7HfzcZKWOR8oOwg/P5KTkTRCMo3LzQ32UmoggyjDAQH0GPxMQ7jS
   p8P+mEB/YyAZ/5MQIh6Y8xaNa0APaSwnn4m6F1Dqsm2UWFui3vEwnhqhl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431749"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431749"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464715"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:20 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:21 -0700
Subject: [PATCH 18/26] cxl/mem: Handle DCD add & release capacity events.
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-18-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=22380;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=5b74S/iuWtfp8wKEYv8807A22Msp/uMjamEP83LPS3Q=;
 b=dV7PiA9aPr9lRSmlAT9NP2mLMgMQZLzjjegLZfJmCONBD4m9cNRYn/0x7k9XFlPqy3iaVMnd9
 KjuGnMc4MRtCcb4nsXVus5LSNjbBC4pvU0ENX8RUY/mKLAJinMGqNDo
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

A dynamic capacity devices (DCD) send events to signal the host about
changes in the availability of Dynamic Capacity (DC) memory.  These
events contain extents, the addition or removal of which may occur at
any time.

Adding memory is straight forward.  If no region exists the extent is
rejected.  If a region does exist, a region extent is formed and
surfaced.

Removing memory requires checking if the memory is currently in use.
Memory use tracking is added in a subsequent patch so here the memory is
never in use and the removal occurs immediately.

Most often extents will be offered to and accepted by the host in well
defined chunks.  However, part of an extent may be requested for
release.  Simplify extent tracking by signaling removal of any extent
which overlaps the requested release range.

Force removal is intended as a mechanism between the FM and the device
and intended only when the host is unresponsive or otherwise broken.
Purposely ignore force removal events.

Process DCD extents.

Recall that all devices of an interleave set must offer a corresponding
extent for the region extent to be realized.  This patch limits
interleave to 1.  Thus the 1:1 mapping between device extent and DAX
region extent allows immediate surfacing.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
[iweiny: remove all xarrays]
[iweiny: entirely new architecture]
---
 drivers/cxl/core/extent.c |   4 ++
 drivers/cxl/core/mbox.c   | 142 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/region.c | 139 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h         |  34 +++++++++++
 drivers/cxl/cxlmem.h      |  21 +++----
 drivers/cxl/mem.c         |  45 +++++++++++++++
 drivers/dax/cxl.c         |  22 +++++++
 include/linux/cxl-event.h |  31 ++++++++++
 8 files changed, 405 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 487c220f1c3c..e98acd98ebe2 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -118,6 +118,10 @@ int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
 	if (rc)
 		goto err;
 
+	rc = cxl_region_notify_extent(cxled->cxld.region, DCD_ADD_CAPACITY, reg_ext);
+	if (rc)
+		goto err;
+
 	dev_dbg(dev, "DAX region extent HPA %#llx - %#llx\n",
 		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6b00e717e42b..7babac2d1c95 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -870,6 +870,37 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static int cxl_notify_dc_extent(struct cxl_memdev_state *mds,
+				enum dc_event event,
+				struct cxl_dc_extent *dc_extent)
+{
+	struct cxl_drv_nd nd = (struct cxl_drv_nd) {
+		.event = event,
+		.dc_extent = dc_extent
+	};
+	struct device *dev;
+	int rc = -ENXIO;
+
+	dev = &mds->cxlds.cxlmd->dev;
+	dev_dbg(dev, "Notify: type %d DPA:%#llx LEN:%#llx\n",
+		event, le64_to_cpu(dc_extent->start_dpa),
+		le64_to_cpu(dc_extent->length));
+
+	device_lock(dev);
+	if (dev->driver) {
+		struct cxl_driver *mem_drv = to_cxl_drv(dev->driver);
+
+		if (mem_drv->notify) {
+			dev_dbg(dev, "Notify driver type %d DPA:%#llx LEN:%#llx\n",
+				event, le64_to_cpu(dc_extent->start_dpa),
+				le64_to_cpu(dc_extent->length));
+			rc = mem_drv->notify(dev, &nd);
+		}
+	}
+	device_unlock(dev);
+	return rc;
+}
+
 static int cxl_validate_extent(struct cxl_memdev_state *mds,
 			       struct cxl_dc_extent *dc_extent)
 {
@@ -897,8 +928,8 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
 	return -EINVAL;
 }
 
-static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
-				struct cxl_dc_extent *extent)
+bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_dc_extent *extent)
 {
 	uint64_t start = le64_to_cpu(extent->start_dpa);
 	uint64_t length = le64_to_cpu(extent->length);
@@ -916,6 +947,7 @@ static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
 
 	return range_contains(&ed_range, &ext_range);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_in_ed, CXL);
 
 void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
@@ -1027,15 +1059,20 @@ static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
 	size_t size;
 
 	struct cxl_mbox_dc_response *dc_res __free(kfree);
-	size = struct_size(dc_res, extent_list, 1);
+	if (!extent)
+		size = struct_size(dc_res, extent_list, 0);
+	else
+		size = struct_size(dc_res, extent_list, 1);
 	dc_res = kzalloc(size, GFP_KERNEL);
 	if (!dc_res)
 		return -ENOMEM;
 
-	dc_res->extent_list[0].dpa_start = cpu_to_le64(extent->start);
-	memset(dc_res->extent_list[0].reserved, 0, 8);
-	dc_res->extent_list[0].length = cpu_to_le64(range_len(extent));
-	dc_res->extent_list_size = cpu_to_le32(1);
+	if (extent) {
+		dc_res->extent_list[0].dpa_start = cpu_to_le64(extent->start);
+		memset(dc_res->extent_list[0].reserved, 0, 8);
+		dc_res->extent_list[0].length = cpu_to_le64(range_len(extent));
+		dc_res->extent_list_size = cpu_to_le32(1);
+	}
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = opcode,
@@ -1072,6 +1109,85 @@ void cxl_release_ed_extent(struct cxl_ed_extent *extent)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_release_ed_extent, CXL);
 
+static int cxl_handle_dcd_release_event(struct cxl_memdev_state *mds,
+					struct cxl_dc_extent *dc_extent)
+{
+	return cxl_notify_dc_extent(mds, DCD_RELEASE_CAPACITY, dc_extent);
+}
+
+static int cxl_handle_dcd_add_event(struct cxl_memdev_state *mds,
+				    struct cxl_dc_extent *dc_extent)
+{
+	struct range alloc_range, *resp_range;
+	struct device *dev = mds->cxlds.dev;
+	int rc;
+
+	alloc_range = (struct range){
+		.start = le64_to_cpu(dc_extent->start_dpa),
+		.end = le64_to_cpu(dc_extent->start_dpa) +
+			le64_to_cpu(dc_extent->length) - 1,
+	};
+	resp_range = &alloc_range;
+
+	rc = cxl_notify_dc_extent(mds, DCD_ADD_CAPACITY, dc_extent);
+	if (rc) {
+		dev_dbg(dev, "unconsumed DC extent DPA:%#llx LEN:%#llx\n",
+			le64_to_cpu(dc_extent->start_dpa),
+			le64_to_cpu(dc_extent->length));
+		resp_range = NULL;
+	}
+
+	return cxl_send_dc_cap_response(mds, resp_range,
+					CXL_MBOX_OP_ADD_DC_RESPONSE);
+}
+
+static char *cxl_dcd_evt_type_str(u8 type)
+{
+	switch (type) {
+	case DCD_ADD_CAPACITY:
+		return "add";
+	case DCD_RELEASE_CAPACITY:
+		return "release";
+	case DCD_FORCED_CAPACITY_RELEASE:
+		return "force release";
+	default:
+		break;
+	}
+
+	return "<unknown>";
+}
+
+static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
+					struct cxl_event_record_raw *raw_rec)
+{
+	struct cxl_event_dcd *event = &raw_rec->event.dcd;
+	struct cxl_dc_extent *dc_extent = &event->extent;
+	struct device *dev = mds->cxlds.dev;
+	uuid_t *id = &raw_rec->id;
+
+	if (!uuid_equal(id, &CXL_EVENT_DC_EVENT_UUID))
+		return -EINVAL;
+
+	dev_dbg(dev, "DCD event %s : DPA:%#llx LEN:%#llx\n",
+		cxl_dcd_evt_type_str(event->event_type),
+		le64_to_cpu(dc_extent->start_dpa),
+		le64_to_cpu(dc_extent->length));
+
+	switch (event->event_type) {
+	case DCD_ADD_CAPACITY:
+		return cxl_handle_dcd_add_event(mds, dc_extent);
+	case DCD_RELEASE_CAPACITY:
+		return cxl_handle_dcd_release_event(mds, dc_extent);
+	case DCD_FORCED_CAPACITY_RELEASE:
+		dev_err_ratelimited(dev, "Forced release event ignored.\n");
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				    enum cxl_event_log_type type)
 {
@@ -1109,9 +1225,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		if (!nr_rec)
 			break;
 
-		for (i = 0; i < nr_rec; i++)
+		for (i = 0; i < nr_rec; i++) {
 			__cxl_event_trace_record(cxlmd, type,
 						 &payload->records[i]);
+			if (type == CXL_EVENT_TYPE_DCD) {
+				rc = cxl_handle_dcd_event_records(mds,
+								  &payload->records[i]);
+				if (rc)
+					dev_err_ratelimited(dev, "dcd event failed: %d\n",
+							    rc);
+			}
+		}
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
@@ -1143,6 +1267,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
 {
 	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
 
+	if (cxl_dcd_supported(mds) && (status & CXLDEV_EVENT_STATUS_DCD))
+		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
 	if (status & CXLDEV_EVENT_STATUS_FATAL)
 		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
 	if (status & CXLDEV_EVENT_STATUS_FAIL)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7635ff109578..a07d95136f0d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1450,6 +1450,57 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 	return 0;
 }
 
+int cxl_region_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+			     struct region_extent *reg_ext)
+{
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+	int rc = -ENXIO;
+
+	cxlr_dax = cxlr->cxlr_dax;
+	dev = &cxlr_dax->dev;
+	dev_dbg(dev, "Trying notify: type %d HPA %#llx - %#llx\n",
+		event, reg_ext->hpa_range.start, reg_ext->hpa_range.end);
+
+	device_lock(dev);
+	if (dev->driver) {
+		struct cxl_driver *reg_drv = to_cxl_drv(dev->driver);
+		struct cxl_drv_nd nd = (struct cxl_drv_nd) {
+			.event = event,
+			.reg_ext = reg_ext,
+		};
+
+		if (reg_drv->notify) {
+			dev_dbg(dev, "Notify: type %d HPA %#llx - %#llx\n",
+				event, reg_ext->hpa_range.start,
+				reg_ext->hpa_range.end);
+			rc = reg_drv->notify(dev, &nd);
+		}
+	}
+	device_unlock(dev);
+	return rc;
+}
+
+static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
+			   struct cxl_dax_region *cxlr_dax,
+			   struct cxl_dc_extent *dc_extent,
+			   struct range *dpa_range,
+			   struct range *hpa_range)
+{
+	resource_size_t dpa_offset, hpa;
+
+	/*
+	 * Without interleave...
+	 * HPA offset == DPA offset
+	 * ... but do the math anyway
+	 */
+	dpa_offset = dpa_range->start - cxled->dpa_res->start;
+	hpa = cxled->cxld.hpa_range.start + dpa_offset;
+
+	hpa_range->start = hpa - cxlr_dax->hpa_range.start;
+	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
+}
+
 static int extent_check_overlap(struct device *dev, void *arg)
 {
 	struct range *new_range = arg;
@@ -1480,7 +1531,6 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
 	struct cxl_region *cxlr = cxled->cxld.region;
 	struct range ext_dpa_range, ext_hpa_range;
 	struct device *dev = &cxlr->dev;
-	resource_size_t dpa_offset, hpa;
 
 	/*
 	 * Interleave ways == 1 means this coresponds to a 1:1 mapping between
@@ -1502,18 +1552,7 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
 	dev_dbg(dev, "Adding DC extent DPA %#llx - %#llx\n",
 		ext_dpa_range.start, ext_dpa_range.end);
 
-	/*
-	 * Without interleave...
-	 * HPA offset == DPA offset
-	 * ... but do the math anyway
-	 */
-	dpa_offset = ext_dpa_range.start - cxled->dpa_res->start;
-	hpa = cxled->cxld.hpa_range.start + dpa_offset;
-
-	ext_hpa_range = (struct range) {
-		.start = hpa - cxlr->cxlr_dax->hpa_range.start,
-		.end = ext_hpa_range.start + range_len(&ext_dpa_range) - 1,
-	};
+	calc_hpa_range(cxled, cxlr->cxlr_dax, dc_extent, &ext_dpa_range, &ext_hpa_range);
 
 	if (extent_overlaps(cxlr->cxlr_dax, &ext_hpa_range))
 		return -EINVAL;
@@ -1527,6 +1566,80 @@ int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
 				     cxled);
 }
 
+static void cxl_ed_rm_region_extent(struct cxl_region *cxlr,
+				    struct region_extent *reg_ext)
+{
+	cxl_region_notify_extent(cxlr, DCD_RELEASE_CAPACITY, reg_ext);
+}
+
+struct rm_data {
+	struct cxl_region *cxlr;
+	struct range *range;
+};
+
+static int cxl_rm_reg_ext_by_range(struct device *dev, void *data)
+{
+	struct rm_data *rm_data = data;
+	struct region_extent *reg_ext;
+
+	if (!is_region_extent(dev))
+		return 0;
+	reg_ext = to_region_extent(dev);
+
+	/*
+	 * Any extent which 'touches' the released range is notified
+	 * for removal.  No partials of the extent are released.
+	 */
+	if (range_overlaps(rm_data->range, &reg_ext->hpa_range)) {
+		struct cxl_region *cxlr = rm_data->cxlr;
+
+		dev_dbg(dev, "Remove DAX region ext HPA %#llx - %#llx\n",
+			reg_ext->hpa_range.start, reg_ext->hpa_range.end);
+		cxl_ed_rm_region_extent(cxlr, reg_ext);
+	}
+	return 0;
+}
+
+static int cxl_ed_rm_extent(struct cxl_endpoint_decoder *cxled,
+			    struct cxl_dc_extent *dc_extent)
+{
+	struct cxl_region *cxlr = cxled->cxld.region;
+	struct range hpa_range;
+
+	struct range rel_dpa_range = {
+		.start = le64_to_cpu(dc_extent->start_dpa),
+		.end = le64_to_cpu(dc_extent->start_dpa) +
+			le64_to_cpu(dc_extent->length) - 1,
+	};
+
+	calc_hpa_range(cxled, cxlr->cxlr_dax, dc_extent, &rel_dpa_range, &hpa_range);
+
+	struct rm_data rm_data = {
+		.cxlr = cxlr,
+		.range = &hpa_range,
+	};
+
+	return device_for_each_child(&cxlr->cxlr_dax->dev, &rm_data,
+				     cxl_rm_reg_ext_by_range);
+}
+
+int cxl_ed_notify_extent(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_drv_nd *nd)
+{
+	switch (nd->event) {
+	case DCD_ADD_CAPACITY:
+		return cxl_ed_add_one_extent(cxled, nd->dc_extent);
+	case DCD_RELEASE_CAPACITY:
+		return cxl_ed_rm_extent(cxled, nd->dc_extent);
+	case DCD_FORCED_CAPACITY_RELEASE:
+	default:
+		dev_err(&cxled->cxld.dev, "Unknown DC event %d\n", nd->event);
+		break;
+	}
+	return -ENXIO;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_ed_notify_extent, CXL);
+
 static int cxl_region_attach_position(struct cxl_region *cxlr,
 				      struct cxl_root_decoder *cxlrd,
 				      struct cxl_endpoint_decoder *cxled,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5379ad7f5852..156d7c9a8de5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -10,6 +10,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <linux/cxl-event.h>
 
 /**
  * DOC: cxl objects
@@ -613,6 +614,14 @@ struct cxl_pmem_region {
 	struct cxl_pmem_region_mapping mapping[];
 };
 
+/* See CXL 3.0 8.2.9.2.1.5 */
+enum dc_event {
+	DCD_ADD_CAPACITY,
+	DCD_RELEASE_CAPACITY,
+	DCD_FORCED_CAPACITY_RELEASE,
+	DCD_REGION_CONFIGURATION_UPDATED,
+};
+
 struct cxl_dax_region {
 	struct device dev;
 	struct cxl_region *cxlr;
@@ -891,10 +900,18 @@ bool is_cxl_region(struct device *dev);
 
 extern struct bus_type cxl_bus_type;
 
+/* Driver Notifier Data */
+struct cxl_drv_nd {
+	enum dc_event event;
+	struct cxl_dc_extent *dc_extent;
+	struct region_extent *reg_ext;
+};
+
 struct cxl_driver {
 	const char *name;
 	int (*probe)(struct device *dev);
 	void (*remove)(struct device *dev);
+	int (*notify)(struct device *dev, struct cxl_drv_nd *nd);
 	struct device_driver drv;
 	int id;
 };
@@ -933,6 +950,8 @@ bool is_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm_bridge(struct device *dev);
 int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
+bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_dc_extent *extent);
 
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
@@ -940,6 +959,10 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+int cxl_ed_notify_extent(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_drv_nd *nd);
+int cxl_region_notify_extent(struct cxl_region *cxlr, enum dc_event event,
+			     struct region_extent *reg_ext);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -958,6 +981,17 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline int cxl_ed_notify_extent(struct cxl_endpoint_decoder *cxled,
+				       struct cxl_drv_nd *nd)
+{
+	return 0;
+}
+static inline int cxl_region_notify_extent(struct cxl_region *cxlr,
+					   enum dc_event event,
+					   struct region_extent *reg_ext)
+{
+	return 0;
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8f2d8944d334..eb10cae99ff0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -619,18 +619,6 @@ struct cxl_mbox_dc_response {
 	} __packed extent_list[];
 } __packed;
 
-/*
- * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51
- */
-#define CXL_DC_EXTENT_TAG_LEN 0x10
-struct cxl_dc_extent {
-	__le64 start_dpa;
-	__le64 length;
-	u8 tag[CXL_DC_EXTENT_TAG_LEN];
-	__le16 shared_extn_seq;
-	u8 reserved[6];
-} __packed;
-
 /*
  * Get Dynamic Capacity Extent List; Input Payload
  * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-166
@@ -714,6 +702,14 @@ struct cxl_mbox_identify {
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86, 0x79, 0xba, 0xb1, \
 		  0x13, 0xb7, 0x74)
 
+/*
+ * Dynamic Capacity Event Record
+ * CXL rev 3.1 section 8.2.9.2.1; Table 8-43
+ */
+#define CXL_EVENT_DC_EVENT_UUID                                             \
+	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f, 0x95, 0x26, 0x8e, \
+		  0x10, 0x1a, 0x2a)
+
 /*
  * Get Event Records output payload
  * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
@@ -739,6 +735,7 @@ enum cxl_event_log_type {
 	CXL_EVENT_TYPE_WARN,
 	CXL_EVENT_TYPE_FAIL,
 	CXL_EVENT_TYPE_FATAL,
+	CXL_EVENT_TYPE_DCD,
 	CXL_EVENT_TYPE_MAX
 };
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0c79d9ce877c..20832f09c40c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -103,6 +103,50 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static int match_ep_decoder_by_range(struct device *dev, void *data)
+{
+	struct cxl_dc_extent *dc_extent = data;
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->cxld.region)
+		return 0;
+
+	return cxl_dc_extent_in_ed(cxled, dc_extent);
+}
+
+static int cxl_mem_notify(struct device *dev, struct cxl_drv_nd *nd)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dc_extent *dc_extent;
+	struct device *ep_dev;
+	int rc;
+
+	dc_extent = nd->dc_extent;
+	dev_dbg(dev, "notify DC action %d DPA:%#llx LEN:%#llx\n",
+		nd->event, le64_to_cpu(dc_extent->start_dpa),
+		le64_to_cpu(dc_extent->length));
+
+	ep_dev = device_find_child(&endpoint->dev, dc_extent,
+				   match_ep_decoder_by_range);
+	if (!ep_dev) {
+		dev_dbg(dev, "Extent DPA:%#llx LEN:%#llx not mapped; evt %d\n",
+			le64_to_cpu(dc_extent->start_dpa),
+			le64_to_cpu(dc_extent->length), nd->event);
+		return -ENXIO;
+	}
+
+	cxled = to_cxl_endpoint_decoder(ep_dev);
+	rc = cxl_ed_notify_extent(cxled, nd);
+	put_device(ep_dev);
+	return rc;
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -244,6 +288,7 @@ __ATTRIBUTE_GROUPS(cxl_mem);
 static struct cxl_driver cxl_mem_driver = {
 	.name = "cxl_mem",
 	.probe = cxl_mem_probe,
+	.notify = cxl_mem_notify,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
 		.dev_groups = cxl_mem_groups,
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 70bdc7a878ab..83ee45aff69a 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -42,6 +42,27 @@ static void cxl_dax_region_add_extents(struct cxl_dax_region *cxlr_dax,
 	device_for_each_child(&cxlr_dax->dev, dax_region, cxl_dax_region_add_extent);
 }
 
+static int cxl_dax_region_notify(struct device *dev,
+				 struct cxl_drv_nd *nd)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+	struct region_extent *reg_ext = nd->reg_ext;
+
+	switch (nd->event) {
+	case DCD_ADD_CAPACITY:
+		return __cxl_dax_region_add_extent(dax_region, reg_ext);
+	case DCD_RELEASE_CAPACITY:
+		return 0;
+	case DCD_FORCED_CAPACITY_RELEASE:
+	default:
+		dev_err(&cxlr_dax->dev, "Unknown DC event %d\n", nd->event);
+		break;
+	}
+
+	return -ENXIO;
+}
+
 static int cxl_dax_region_probe(struct device *dev)
 {
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
@@ -85,6 +106,7 @@ static int cxl_dax_region_probe(struct device *dev)
 static struct cxl_driver cxl_dax_region_driver = {
 	.name = "cxl_dax_region",
 	.probe = cxl_dax_region_probe,
+	.notify = cxl_dax_region_notify,
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..6b745c913f96 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -91,11 +91,42 @@ struct cxl_event_mem_module {
 	u8 reserved[0x3d];
 } __packed;
 
+/*
+ * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51
+ */
+#define CXL_DC_EXTENT_TAG_LEN 0x10
+struct cxl_dc_extent {
+	__le64 start_dpa;
+	__le64 length;
+	u8 tag[CXL_DC_EXTENT_TAG_LEN];
+	__le16 shared_extn_seq;
+	u8 reserved[0x6];
+} __packed;
+
+/*
+ * Dynamic Capacity Event Record
+ * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-50
+ */
+struct cxl_event_dcd {
+	struct cxl_event_record_hdr hdr;
+	u8 event_type;
+	u8 validity_flags;
+	__le16 host_id;
+	u8 region_index;
+	u8 flags;
+	u8 reserved1[0x2];
+	struct cxl_dc_extent extent;
+	u8 reserved2[0x18];
+	__le32 num_avail_extents;
+	__le32 num_avail_tags;
+} __packed;
+
 union cxl_event {
 	struct cxl_event_generic generic;
 	struct cxl_event_gen_media gen_media;
 	struct cxl_event_dram dram;
 	struct cxl_event_mem_module mem_module;
+	struct cxl_event_dcd dcd;
 } __packed;
 
 /*

-- 
2.44.0


