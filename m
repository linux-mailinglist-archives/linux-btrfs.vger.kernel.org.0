Return-Path: <linux-btrfs+bounces-3528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62FA888B6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A90428BC6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830F2A8759;
	Sun, 24 Mar 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHcV2fRD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DD14E2EF;
	Sun, 24 Mar 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322298; cv=none; b=VwPHw9gTqD3qTktP5qPIDRuQWJi0oZIKfoZ5oAt1zg/XaYjsS/GshzcelPdhOb9IvCHw/EUDYD21RcxqH3X/OkqytZcbT6zA4hNdnMdaWsRwUcLcxK9Y6xYAM4zsSknKY9cmYbZqwo7PdnWTF1Nd/XhE7p8cFX4m3rZ6US/fZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322298; c=relaxed/simple;
	bh=gXFukfdO+9GClAuLeiJnLXVckGkIjmj7N2RX/CD17Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oInV7pyGneeofiV282MktFApItTFCWYIhA77+ek4xwiH5PaM2ARe9OxX7IrdiFw+FbZj8pRXznEiFYf0wJf32yjAeVsYS2t28ViufXuswF8owIvorJ9uWdffPorj8CLP9k3hLYTHRQB0lKiQqD+CUkZ8kFJzGFGEs4ifSmtZt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHcV2fRD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322295; x=1742858295;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gXFukfdO+9GClAuLeiJnLXVckGkIjmj7N2RX/CD17Iw=;
  b=AHcV2fRD6KOodno0x5r9r2bjScf8BjLL3iusqyWy9LTW7f08yxqm1xAX
   4ZgiuhXSmDsO/MPR/tV7pjKAprDzHSzsimSicMM65ji4gNwIek1lS1n21
   vIiOJFObs7Q2LoTOVttfndgGs4PwqAe8n+75xzQ1lG4YcXXXqBwuTiDmB
   3F4ketcx4unJDM5Umjkz7uJ+yiMCYRLZa+Qhh+LZ7UjweBct6krNE3h0g
   AM9zfvcvH7yRfzPd9zWi60AOh73Df4I2+G53lOP2C7QBrXKB+wX4XCDHF
   rpVGVbVCv27GArIlrCcZy7Yj8oT5YaowxHpd+8mFmBc6AVq2MatmymPIi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9260901"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9260901"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15842197"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:09 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:06 -0700
Subject: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=13179;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=YBe1lZctaajAhYBvq1juOjo8yj8PP7PHSCE92tEpsuo=;
 b=zHp9gqYgy43Ah8BI0jC3MkZistAm75xnKwrLVcGy9HZuOUVQ065InukpuZXXuB3HfWEZBN8lG
 KMFMC5YtxKyBRKuoIAj235OSGz/xXZxNku0nDDZNKl20a6x0YNRMa4K
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Devices can optionally support Dynamic Capacity (DC).  These devices are
known as Dynamic Capacity Devices (DCD).

Implement the DC mailbox commands as specified in CXL 3.1 section
8.2.9.9.9 (opcodes 48XXh).  Read the DC configuration and store the DC
region information in the device state.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
[Jørgen: ensure CXL 2.0 device support by removing dc_event_log_size]
[iweiny/Jørgen: use get DC config command to signal DCD support]
[djiang: fix subject]
[Fan: add additional region configuration checks]
[Jonathan/djiang: split out region mode changes]
[Jonathan: fix up comments/kdoc]
[Jonathan: s/cxl_get_dc_id/cxl_get_dc_config/]
[Jonathan: use __free() in identify call]
[Jonathan: remove unneeded formatting changes]
[Jonathan: s/cxl_mbox_dynamic_capacity/cxl_mbox_get_dc_config_out/]
[Jonathan: s/cxl_mbox_get_dc_config/cxl_mbox_get_dc_config_in/]
[iweiny: remove type2 work dependancy/rebase on master]
[iweiny: fix 0day build issues]
---
 drivers/cxl/core/mbox.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxlmem.h    |  49 +++++++++++++
 drivers/cxl/pci.c       |   4 ++
 3 files changed, 236 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ed4131c6f50b..14e8a7528a8b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1123,7 +1123,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 	if (rc < 0)
 		return rc;
 
-	mds->total_bytes =
+	mds->static_cap =
 		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
 	mds->volatile_only_bytes =
 		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
@@ -1230,6 +1230,175 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return rc;
 }
 
+static int cxl_dc_save_region_info(struct cxl_memdev_state *mds, u8 index,
+				   struct cxl_dc_region_config *region_config)
+{
+	struct cxl_dc_region_info *dcr = &mds->dc_region[index];
+	struct device *dev = mds->cxlds.dev;
+
+	dcr->base = le64_to_cpu(region_config->region_base);
+	dcr->decode_len = le64_to_cpu(region_config->region_decode_length);
+	dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
+	dcr->len = le64_to_cpu(region_config->region_length);
+	dcr->blk_size = le64_to_cpu(region_config->region_block_size);
+	dcr->dsmad_handle = le32_to_cpu(region_config->region_dsmad_handle);
+	dcr->flags = region_config->flags;
+	snprintf(dcr->name, CXL_DC_REGION_STRLEN, "dc%d", index);
+
+	/* Check regions are in increasing DPA order */
+	if (index > 0) {
+		struct cxl_dc_region_info *prev_dcr = &mds->dc_region[index - 1];
+
+		if ((prev_dcr->base + prev_dcr->decode_len) > dcr->base) {
+			dev_err(dev,
+				"DPA ordering violation for DC region %d and %d\n",
+				index - 1, index);
+			return -EINVAL;
+		}
+	}
+
+	if (!IS_ALIGNED(dcr->base, SZ_256M) ||
+	    !IS_ALIGNED(dcr->base, dcr->blk_size)) {
+		dev_err(dev, "DC region %d invalid base %#llx blk size %#llx\n", index,
+			dcr->base, dcr->blk_size);
+		return -EINVAL;
+	}
+
+	if (dcr->decode_len == 0 || dcr->len == 0 || dcr->decode_len < dcr->len ||
+	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
+		dev_err(dev, "DC region %d invalid length; decode %#llx len %#llx blk size %#llx\n",
+			index, dcr->decode_len, dcr->len, dcr->blk_size);
+		return -EINVAL;
+	}
+
+	if (dcr->blk_size == 0 || dcr->blk_size % 0x40 ||
+	    !is_power_of_2(dcr->blk_size)) {
+		dev_err(dev, "DC region %d invalid block size; %#llx\n",
+			index, dcr->blk_size);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev,
+		"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
+		dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
+
+	return 0;
+}
+
+/* Returns the number of regions in dc_resp or -ERRNO */
+static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_region,
+			     struct cxl_mbox_get_dc_config_out *dc_resp,
+			     size_t dc_resp_size)
+{
+	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
+		.region_count = CXL_MAX_DC_REGION,
+		.start_region_index = start_region,
+	};
+	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
+		.payload_in = &get_dc,
+		.size_in = sizeof(get_dc),
+		.size_out = dc_resp_size,
+		.payload_out = dc_resp,
+		.min_out = 1,
+	};
+	struct device *dev = mds->cxlds.dev;
+	int rc;
+
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	rc = dc_resp->avail_region_count - start_region;
+
+	/*
+	 * The number of regions in the payload may have been truncated due to
+	 * payload_size limits; if so adjust the returned count to match.
+	 */
+	if (mbox_cmd.size_out < sizeof(*dc_resp))
+		rc = CXL_REGIONS_RETURNED(mbox_cmd.size_out);
+
+	dev_dbg(dev, "Read %d/%d DC regions\n", rc, dc_resp->avail_region_count);
+
+	return rc;
+}
+
+static bool cxl_dcd_supported(struct cxl_memdev_state *mds)
+{
+	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
+}
+
+/**
+ * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
+ *					 information from the device.
+ * @mds: The memory device state
+ *
+ * Read Dynamic Capacity information from the device and populate the state
+ * structures for later use.
+ *
+ * Return: 0 if identify was executed successfully, -ERRNO on error.
+ */
+int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
+{
+	size_t dc_resp_size = mds->payload_size;
+	struct device *dev = mds->cxlds.dev;
+	u8 start_region, i;
+	int rc = 0;
+
+	for (i = 0; i < CXL_MAX_DC_REGION; i++)
+		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
+
+	/* Check GET_DC_CONFIG is supported by device */
+	if (!cxl_dcd_supported(mds)) {
+		dev_dbg(dev, "DCD not supported\n");
+		return 0;
+	}
+
+	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
+					kvmalloc(dc_resp_size, GFP_KERNEL);
+	if (!dc_resp)
+		return -ENOMEM;
+
+	start_region = 0;
+	do {
+		int j;
+
+		rc = cxl_get_dc_config(mds, start_region, dc_resp, dc_resp_size);
+		if (rc < 0) {
+			dev_dbg(dev, "Failed to get DC config: %d\n", rc);
+			return rc;
+		}
+
+		mds->nr_dc_region += rc;
+
+		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
+			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
+				mds->nr_dc_region);
+			return -EINVAL;
+		}
+
+		for (i = start_region, j = 0; i < mds->nr_dc_region; i++, j++) {
+			rc = cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
+			if (rc) {
+				dev_dbg(dev, "Failed to save region info: %d\n", rc);
+				return rc;
+			}
+		}
+
+		start_region = mds->nr_dc_region;
+
+	} while (mds->nr_dc_region < dc_resp->avail_region_count);
+
+	mds->dynamic_cap =
+		mds->dc_region[mds->nr_dc_region - 1].base +
+		mds->dc_region[mds->nr_dc_region - 1].decode_len -
+		mds->dc_region[0].base;
+	dev_dbg(dev, "Total dynamic capacity: %#llx\n", mds->dynamic_cap);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
@@ -1260,8 +1429,12 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct device *dev = cxlds->dev;
+	size_t untenanted_mem;
 	int rc;
 
+	untenanted_mem = mds->dc_region[0].base - mds->static_cap;
+	mds->total_bytes = mds->static_cap + untenanted_mem + mds->dynamic_cap;
+
 	if (!cxlds->media_ready) {
 		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
 		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
@@ -1271,6 +1444,15 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 
 	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
 
+	for (int i = 0; i < mds->nr_dc_region; i++) {
+		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
+
+		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
+				 dcr->base, dcr->decode_len, dcr->name);
+		if (rc)
+			return rc;
+	}
+
 	if (mds->partition_align_bytes == 0) {
 		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
 				 mds->volatile_only_bytes, "ram");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79a67cff9143..4624cf612c1e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -402,6 +402,7 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
+#define CXL_MAX_DC_REGION 8
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range - range for DPA address
@@ -431,6 +432,8 @@ struct cxl_dpa_perf {
  * @dpa_res: Overall DPA resource tree for the device
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
+ * @dc_res: Active Dynamic Capacity memory configuration for each possible
+ *          region
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  */
@@ -445,10 +448,22 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
+	struct resource dc_res[CXL_MAX_DC_REGION];
 	u64 serial;
 	enum cxl_devtype type;
 };
 
+#define CXL_DC_REGION_STRLEN 8
+struct cxl_dc_region_info {
+	u64 base;
+	u64 decode_len;
+	u64 len;
+	u64 blk_size;
+	u32 dsmad_handle;
+	u8 flags;
+	u8 name[CXL_DC_REGION_STRLEN];
+};
+
 /**
  * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
  *
@@ -467,6 +482,8 @@ struct cxl_dev_state {
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
  * @total_bytes: sum of all possible capacities
+ * @static_cap: Sum of static RAM and PMEM capacities
+ * @dynamic_cap: Complete DPA range occupied by DC regions
  * @volatile_only_bytes: hard volatile capacity
  * @persistent_only_bytes: hard persistent capacity
  * @partition_align_bytes: alignment size for partition-able capacity
@@ -474,6 +491,8 @@ struct cxl_dev_state {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
+ * @nr_dc_region: number of DC regions implemented in the memory device
+ * @dc_region: array containing info about the DC regions
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -494,7 +513,10 @@ struct cxl_memdev_state {
 	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+
 	u64 total_bytes;
+	u64 static_cap;
+	u64 dynamic_cap;
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
 	u64 partition_align_bytes;
@@ -506,6 +528,9 @@ struct cxl_memdev_state {
 	struct cxl_dpa_perf ram_perf;
 	struct cxl_dpa_perf pmem_perf;
 
+	u8 nr_dc_region;
+	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
+
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
@@ -705,6 +730,29 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+struct cxl_mbox_get_dc_config_in {
+	u8 region_count;
+	u8 start_region_index;
+} __packed;
+
+/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
+struct cxl_mbox_get_dc_config_out {
+	u8 avail_region_count;
+	u8 rsvd[7];
+	struct cxl_dc_region_config {
+		__le64 region_base;
+		__le64 region_decode_length;
+		__le64 region_length;
+		__le64 region_block_size;
+		__le32 region_dsmad_handle;
+		u8 flags;
+		u8 rsvd[3];
+	} __packed region[];
+} __packed;
+#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
+#define CXL_REGIONS_RETURNED(size_out) \
+	((size_out - 8) / sizeof(struct cxl_dc_region_config))
+
 /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
 struct cxl_mbox_set_timestamp_in {
 	__le64 timestamp;
@@ -828,6 +876,7 @@ enum {
 int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
+int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..216881455364 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -874,6 +874,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_dev_dynamic_capacity_identify(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_create_range_info(mds);
 	if (rc)
 		return rc;

-- 
2.44.0


