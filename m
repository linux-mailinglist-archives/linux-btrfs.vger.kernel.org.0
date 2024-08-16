Return-Path: <linux-btrfs+bounces-7281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD84954D0B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043AC282DFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0301CCB37;
	Fri, 16 Aug 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPbvSJ3H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384541CB312;
	Fri, 16 Aug 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819527; cv=none; b=suDBMLlUQbBSLpVznnQX+NNfCH44Y6i5kemFDFvmYsAt1RxGs/jtGdSt9qsZWxOjr8pCP7G1cSXzfDxtiLFD2cLJgKi8AJ8wPg9LzZpy+P2zmPbDB04Uf64vh+7JPUVEX4u+uclgs9F4lDXlBnZYBUsp1PidxAyhTP4Ea+nI4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819527; c=relaxed/simple;
	bh=bb/uWc2iCgzOTXuH9WCLA5eEKm8nQtNTaUfjGDZqTDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vj5ZeVLq0UuxuIIIQR6j+xysdPac4tziWYFaT+rDqwu6JZ+Bi1q0Kpche30QMXAF70dzMx1uqhIBzNR5KCgdDoEOajPi2jkruqSbXqyU85xZvmf0FisIL4l1/ydbkrTeOgV2aFfiQC/0NXKT17esElUUzOGOiL6J6LhQ7mL60zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPbvSJ3H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819525; x=1755355525;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bb/uWc2iCgzOTXuH9WCLA5eEKm8nQtNTaUfjGDZqTDY=;
  b=XPbvSJ3Hpkj1U4TP1yZASJJtG9rLeY7w9xKaPoB4Va9SlS6vj4iisSDo
   AgEIpMYQPJGPLMeiqLcygKyG8njFRfTwEbLZlam9SLIr0qhYSWKqNbmw0
   q/ys+Gnfah/VcgPTE8U9r0WPJ8946TiFYu7mXTvwnEch14enReFoJG74Z
   rm7EeiCDliozOYUikomReMpmpjAuotDVk6LjVlMNBDII8hyirS7X2pMqC
   nFImo0LojXV4mKKM1bm7kVFU3ejme1cEHLIWjiIOy2etYyHD85/oJnUMW
   nb5/ioypIarhv2ck98701aptc1YHmzj1dvKD1+X9v0fQ+JyP2XtSHCKrp
   g==;
X-CSE-ConnectionGUID: QvKm/2f4TGiA8uZ4kuRJkQ==
X-CSE-MsgGUID: DZpgyn9WSIukuh/iej724w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21973118"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="21973118"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:23 -0700
X-CSE-ConnectionGUID: rnbrH2K3StuEsPB4gN+txQ==
X-CSE-MsgGUID: T6ZWSgq9Q2qsxYL+Tmlf6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="97205600"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:21 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:44:30 -0500
Subject: [PATCH v3 22/25] cxl/region: Read existing extents on region
 creation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240816-dcd-type2-upstream-v3-22-7c9b96cba6d7@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819456; l=8476;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=XzfjANoiUaiXIYhSjYmFlm5h7v3MFnVlJoudyWbcJU0=;
 b=kgzd6JHM7e+t47lReWVLs2kz/T8BeWitPhsBNXMfpKOxoe3osZv5RvWX3Nr7iYhlN3aZZzqGP
 PJHrfnazhrFAKI2kjSaPuAv4E9zNhiEEWeRjs7Zk67WCYumnXaqixuV
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Dynamic capacity device extents may be left in an accepted state on a
device due to an unexpected host crash.  In this case it is expected
that the creation of a new region on top of a DC partition can read
those extents and surface them for continued use.

Once all endpoint decoders are part of a region and the region is being
realized a read of the devices extent list can reveal these previously
accepted extents.

CXL r3.1 specifies the mailbox call Get Dynamic Capacity Extent List for
this purpose.  The call returns all the extents for all dynamic capacity
partitions.  If the fabric manager is adding extents to any DCD
partition, the extent list for the recovered region may change.  In this
case the query must retry.  Upon retry the query could encounter extents
which were accepted on a previous list query.  Adding such extents is
ignored without error because they are entirely within a previous
accepted extent.

The scan for existing extents races with the dax_cxl driver.  This is
synchronized through the region device lock.  Extents which are found
after the driver has loaded will surface through the normal notification
path while extents seen prior to the driver are read during driver load.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: Leverage the new add path from the event processing code such
	 that the adding and surfacing of extents flows through the same
	 code path for both event processing and existing extents.
	 While this does validate existing extents again on start up
	 this is an error recovery case / new boot scenario and should
	 not cause any major issues while making the code more
	 straight forward and maintainable.]

[iweiny: use %par]
[iweiny: rebase]
[iweiny: Move this patch later in the series such that the realization
         of extents can go through the same path as an add event]
[Fan: Issue a retry if the gen number changes]
[djiang: s/uint64_t/u64/]
[djiang: update function names]
[Jørgen/djbw: read the generation and total count on first iteration of
              the Get Extent List call]
[djbw: s/cxl_mbox_get_dc_extent_in/cxl_mbox_get_extent_in/]
[djbw: s/cxl_mbox_get_dc_extent_out/cxl_mbox_get_extent_out/]
[djbw/iweiny: s/cxl_read_dc_extents/cxl_read_extent_list]
---
 drivers/cxl/core/core.h   |   2 +
 drivers/cxl/core/mbox.c   | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c |  12 ++++++
 drivers/cxl/cxlmem.h      |  21 ++++++++++
 4 files changed, 135 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8dfc97b2e0a4..9e54064a6f48 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -21,6 +21,8 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 
+void cxl_read_extent_list(struct cxl_endpoint_decoder *cxled);
+
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f629ad7488ac..d43ac8eabf56 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1670,6 +1670,106 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
 
+/* Return -EAGAIN if the extent list changes while reading */
+static int __cxl_read_extent_list(struct cxl_endpoint_decoder *cxled)
+{
+	u32 current_index, total_read, total_expected, initial_gen_num;
+	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_mbox_cmd mbox_cmd;
+	u32 max_extent_count;
+	bool first = true;
+
+	struct cxl_mbox_get_extent_out *extents __free(kfree) =
+				kvmalloc(mds->payload_size, GFP_KERNEL);
+	if (!extents)
+		return -ENOMEM;
+
+	total_read = 0;
+	current_index = 0;
+	total_expected = 0;
+	max_extent_count = (mds->payload_size - sizeof(*extents)) /
+				sizeof(struct cxl_extent);
+	do {
+		struct cxl_mbox_get_extent_in get_extent;
+		u32 nr_returned, current_total, current_gen_num;
+		int rc;
+
+		get_extent = (struct cxl_mbox_get_extent_in) {
+			.extent_cnt = max(max_extent_count,
+					  total_expected - current_index),
+			.start_extent_index = cpu_to_le32(current_index),
+		};
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
+			.payload_in = &get_extent,
+			.size_in = sizeof(get_extent),
+			.size_out = mds->payload_size,
+			.payload_out = extents,
+			.min_out = 1,
+		};
+
+		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		if (rc < 0)
+			return rc;
+
+		/* Save initial data */
+		if (first) {
+			total_expected = le32_to_cpu(extents->total_extent_count);
+			initial_gen_num = le32_to_cpu(extents->generation_num);
+			first = false;
+		}
+
+		nr_returned = le32_to_cpu(extents->returned_extent_count);
+		total_read += nr_returned;
+		current_total = le32_to_cpu(extents->total_extent_count);
+		current_gen_num = le32_to_cpu(extents->generation_num);
+
+		dev_dbg(dev, "Got extent list %d-%d of %d generation Num:%d\n",
+			current_index, total_read - 1, current_total, current_gen_num);
+
+		if (current_gen_num != initial_gen_num || total_expected != current_total) {
+			dev_dbg(dev, "Extent list change detected; gen %u != %u : cnt %u != %u\n",
+				current_gen_num, initial_gen_num,
+				total_expected, current_total);
+			return -EAGAIN;
+		}
+
+		for (int i = 0; i < nr_returned ; i++) {
+			struct cxl_extent *extent = &extents->extent[i];
+
+			dev_dbg(dev, "Processing extent %d/%d\n",
+				current_index + i, total_expected);
+
+			rc = validate_add_extent(mds, extent);
+			if (rc)
+				continue;
+		}
+
+		current_index += nr_returned;
+	} while (total_expected > total_read);
+
+	return 0;
+}
+
+/**
+ * cxl_read_extent_list() - Read existing extents
+ * @cxled: Endpoint decoder which is part of a region
+ *
+ * Issue the Get Dynamic Capacity Extent List command to the device
+ * and add existing extents if found.
+ */
+void cxl_read_extent_list(struct cxl_endpoint_decoder *cxled)
+{
+	int retry = 10;
+	int rc;
+
+	do {
+		rc = __cxl_read_extent_list(cxled);
+	} while (rc == -EAGAIN && retry--);
+}
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8c9171f914fb..885fb3004784 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3190,6 +3190,15 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	return rc;
 }
 
+static void cxlr_add_existing_extents(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int i;
+
+	for (i = 0; i < p->nr_targets; i++)
+		cxl_read_extent_list(p->targets[i]);
+}
+
 static void cxlr_dax_unregister(void *_cxlr_dax)
 {
 	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
@@ -3227,6 +3236,9 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
+	if (cxlr->mode == CXL_REGION_DC)
+		cxlr_add_existing_extents(cxlr);
+
 	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
 					cxlr_dax);
 err:
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3a40fe1f0be7..11c03637488d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -624,6 +624,27 @@ struct cxl_mbox_dc_response {
 	} __packed extent_list[];
 } __packed;
 
+/*
+ * Get Dynamic Capacity Extent List; Input Payload
+ * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-166
+ */
+struct cxl_mbox_get_extent_in {
+	__le32 extent_cnt;
+	__le32 start_extent_index;
+} __packed;
+
+/*
+ * Get Dynamic Capacity Extent List; Output Payload
+ * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-167
+ */
+struct cxl_mbox_get_extent_out {
+	__le32 returned_extent_count;
+	__le32 total_extent_count;
+	__le32 generation_num;
+	u8 rsvd[4];
+	struct cxl_extent extent[];
+} __packed;
+
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
 	u8 rsvd[6];

-- 
2.45.2


