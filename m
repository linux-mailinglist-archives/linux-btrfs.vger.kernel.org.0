Return-Path: <linux-btrfs+bounces-3541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6BF888B99
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F8B28C828
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECA18AC4B;
	Sun, 24 Mar 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTZZUjLt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9315ECFE;
	Sun, 24 Mar 2024 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322316; cv=none; b=CUy/TbGsFazrVdeTcUrULrW/1h1tGrXjqUEqlCyHEl/pA5l2GvxZ1WAnM5Sgpi+QYixmkooDYpJkftNV1QiOKdNU4gy5J0RmzljC0oJiGI0dnefcCvCIl5DP2VzaFdelRyWEVsNYiILx/BC5gBPjGl3cQdhoR0tOmjKrXNQYAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322316; c=relaxed/simple;
	bh=1FDjkLijZOPxtk8eVYc1f5q/hCjbFQPfEX5BsvtZmb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nByTxaqtPUWlLNn5FhL8Xmn5VOAz6y99WvG8Kue16hh4L6OcC/EjlqGtbxV5Mx/V7Np5rSpmNJ+kyrOK0GnSvfWKXipEU/ZzyAXCJqfrQdTUbz8rNjr/JRqgG/rm7MUcYrYSISzmC7wosju3Eb92f6J6jqtHqy/VzMILnKTD13U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTZZUjLt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322314; x=1742858314;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1FDjkLijZOPxtk8eVYc1f5q/hCjbFQPfEX5BsvtZmb8=;
  b=fTZZUjLtqceY9nnMZmMjAsZiIhWVStN+jg961SBfuw4MDrUTyuY92gnE
   PsEOTybXWvXIAItbIhbTXgpDHYb5sOkexweD64edMdzXvc3DDClag8p3B
   wNfbg/FrixM0fc9l7pYn0RoCGLBk6j63Cd8Oxeo0oxlQ63i7LOyISx7ZF
   bxiOshm3prHbg06PPE+Y2LuIJxX3wSr1AK3vofvMIbai3aSz/0N6F3Hvb
   A3Y7bHUWbgITr+c1vY32sVrIE+uQpJxFY4m44YUHW9lKLZ/OPr5YhILX9
   KrbXUX0etjylquap9tFd16llPRr36w/0dFGg5Aa5Bm0v+TKSQRJH56j6Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431777"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431777"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464742"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:28 -0700
Subject: [PATCH 25/26] tools/testing/cxl: Add DC Regions to mock mem data
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-25-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=19632;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=1FDjkLijZOPxtk8eVYc1f5q/hCjbFQPfEX5BsvtZmb8=;
 b=XjZXq0GLKAGwzh09XmwBDQAyuRWw6F9nIcFYBHrTcUBKFv8aUT8nSvV5toiXFMs9gv8yzZFIG
 7fZqoQLIdt1BJNVM1yz4xAdLtbaGflWD5s+TnhfuFVRA+lCQG5pPxQw
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

cxl_test provides a good way to ensure quick smoke and regression
testing.  The complexity of Dynamic Capacity (DC) devices and the new
sparse DAX regions required to use them benefits greatly with a series
of smoke tests.

To test DC regions the mock memory devices will need mock DC information
and manage fake extent data.

Define mock_dc_region information within the mock memory data.  Add
sysfs entries on the mock device to inject and delete extents.

The inject format is <start>:<length>:<tag>
The delete format is <start>:<length>

Add DC mailbox commands to the CEL and implement those commands.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
[iweiny: adjust to new events]
[iweiny: remove most extent checks to allow negative testing]
---
 tools/testing/cxl/test/mem.c | 575 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 574 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d8d62e6eeb18..7d1d897d9f2b 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -18,6 +18,7 @@
 #define FW_SLOTS 3
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
+#define BASE_DYNAMIC_CAP_DPA DEV_SIZE
 
 #define MOCK_INJECT_DEV_MAX 8
 #define MOCK_INJECT_TEST_MAX 128
@@ -95,6 +96,22 @@ static struct cxl_cel_entry mock_cel[] = {
 				      EFFECT(SECURITY_CHANGE_IMMEDIATE) |
 				      EFFECT(BACKGROUND_OP)),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_DC_CONFIG),
+		.effect = CXL_CMD_EFFECT_NONE,
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_DC_EXTENT_LIST),
+		.effect = CXL_CMD_EFFECT_NONE,
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_ADD_DC_RESPONSE),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE)),
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_RELEASE_DC),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE)),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -152,6 +169,7 @@ struct mock_event_store {
 	u32 ev_status;
 };
 
+#define NUM_MOCK_DC_REGIONS 2
 struct cxl_mockmem_data {
 	void *lsa;
 	void *fw;
@@ -168,6 +186,11 @@ struct cxl_mockmem_data {
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
 	unsigned long sanitize_timeout;
+	struct cxl_dc_region_config dc_regions[NUM_MOCK_DC_REGIONS];
+	u32 dc_ext_generation;
+	struct mutex ext_lock;
+	struct xarray dc_extents;
+	struct xarray dc_accepted_exts;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -558,6 +581,200 @@ static void cxl_mock_event_trigger(struct device *dev)
 	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
 }
 
+struct cxl_dc_extent_data {
+	u64 dpa_start;
+	u64 length;
+	u8 tag[CXL_DC_EXTENT_TAG_LEN];
+};
+
+static int __devm_add_extent(struct device *dev, struct xarray *array,
+			     u64 start, u64 length, const char *tag)
+{
+	struct cxl_dc_extent_data *extent;
+
+	extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
+	if (!extent)
+		return -ENOMEM;
+
+	extent->dpa_start = start;
+	extent->length = length;
+	memcpy(extent->tag, tag, min(sizeof(extent->tag), strlen(tag)));
+
+	if (xa_insert(array, start, extent, GFP_KERNEL)) {
+		devm_kfree(dev, extent);
+		dev_err(dev, "Failed xarry insert %#llx\n", start);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int devm_add_extent(struct device *dev, u64 start, u64 length,
+			   const char *tag)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+
+	guard(mutex)(&mdata->ext_lock);
+	return __devm_add_extent(dev, &mdata->dc_extents, start, length, tag);
+}
+
+/* It is known that ext and the new range are not equal */
+static struct cxl_dc_extent_data *
+split_ext(struct device *dev, struct xarray *array,
+	  struct cxl_dc_extent_data *ext, u64 start, u64 length)
+{
+	u64 new_start, new_length;
+
+	if (ext->dpa_start == start) {
+		new_start = start + length;
+		new_length = (ext->dpa_start + ext->length) - new_start;
+
+		if (__devm_add_extent(dev, array, new_start, new_length,
+				      ext->tag))
+			return NULL;
+
+		ext = xa_erase(array, ext->dpa_start);
+		if (__devm_add_extent(dev, array, start, length, ext->tag))
+			return NULL;
+
+		return xa_load(array, start);
+	}
+
+	/* ext->dpa_start != start */
+
+	if (__devm_add_extent(dev, array, start, length, ext->tag))
+		return NULL;
+
+	new_start = ext->dpa_start;
+	new_length = start - ext->dpa_start;
+
+	ext = xa_erase(array, ext->dpa_start);
+	if (__devm_add_extent(dev, array, new_start, new_length, ext->tag))
+		return NULL;
+
+	return xa_load(array, start);
+}
+
+/*
+ * Do not handle extents which are not inside a single extent sent to
+ * the host.
+ */
+static struct cxl_dc_extent_data *
+find_create_ext(struct device *dev, struct xarray *array, u64 start, u64 length)
+{
+	struct cxl_dc_extent_data *ext;
+	unsigned long index;
+
+	xa_for_each(array, index, ext) {
+		u64 end = start + length;
+
+		/* start < [ext) <= start */
+		if (start < ext->dpa_start ||
+		    (ext->dpa_start + ext->length) <= start)
+			continue;
+
+		if (end <= ext->dpa_start ||
+		    (ext->dpa_start + ext->length) < end) {
+			dev_err(dev, "Invalid range %#llx-%#llx\n", start,
+				end);
+			return NULL;
+		}
+
+		break;
+	}
+
+	if (!ext)
+		return NULL;
+
+	if (start == ext->dpa_start && length == ext->length)
+		return ext;
+
+	return split_ext(dev, array, ext, start, length);
+}
+
+static int dc_accept_extent(struct device *dev, u64 start, u64 length)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_dc_extent_data *ext;
+
+	dev_dbg(dev, "Host accepting extent %#llx\n", start);
+	mdata->dc_ext_generation++;
+
+	guard(mutex)(&mdata->ext_lock);
+	ext = find_create_ext(dev, &mdata->dc_extents, start, length);
+	if (!ext) {
+		dev_err(dev, "Extent %#llx-%#llx not found\n",
+			start, start + length);
+		return -ENOMEM;
+	}
+	ext = xa_erase(&mdata->dc_extents, ext->dpa_start);
+	return xa_insert(&mdata->dc_accepted_exts, start, ext, GFP_KERNEL);
+}
+
+static void release_dc_ext(void *md)
+{
+	struct cxl_mockmem_data *mdata = md;
+
+	xa_destroy(&mdata->dc_extents);
+	xa_destroy(&mdata->dc_accepted_exts);
+}
+
+static int cxl_mock_dc_region_setup(struct device *dev)
+{
+#define DUMMY_EXT_OFFSET SZ_256M
+#define DUMMY_EXT_LENGTH SZ_256M
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	u64 base_dpa = BASE_DYNAMIC_CAP_DPA;
+	u32 dsmad_handle = 0xFADE;
+	u64 decode_length = SZ_1G;
+	u64 block_size = SZ_512;
+	/* For testing make this smaller than decode length */
+	u64 length = SZ_1G;
+	int rc;
+
+	mutex_init(&mdata->ext_lock);
+	xa_init(&mdata->dc_extents);
+	xa_init(&mdata->dc_accepted_exts);
+
+	rc = devm_add_action_or_reset(dev, release_dc_ext, mdata);
+	if (rc)
+		return rc;
+
+	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
+		struct cxl_dc_region_config *conf = &mdata->dc_regions[i];
+
+		dev_dbg(dev, "Creating DC region DC%d DPA:%#llx LEN:%#llx\n",
+			i, base_dpa, length);
+
+		conf->region_base = cpu_to_le64(base_dpa);
+		conf->region_decode_length = cpu_to_le64(decode_length /
+						CXL_CAPACITY_MULTIPLIER);
+		conf->region_length = cpu_to_le64(length);
+		conf->region_block_size = cpu_to_le64(block_size);
+		conf->region_dsmad_handle = cpu_to_le32(dsmad_handle);
+		dsmad_handle++;
+
+		/* Pretend to have some previous accepted extents */
+		rc = devm_add_extent(dev, base_dpa + DUMMY_EXT_OFFSET,
+				     DUMMY_EXT_LENGTH, "CXL-TEST");
+		if (rc) {
+			dev_err(dev, "Failed to add extent DC%d DPA:%#llx LEN:%#x; %d\n",
+				i, base_dpa + DUMMY_EXT_OFFSET,
+				DUMMY_EXT_LENGTH, rc);
+			return rc;
+		}
+
+		rc = dc_accept_extent(dev, base_dpa + DUMMY_EXT_OFFSET,
+				      DUMMY_EXT_LENGTH);
+		if (rc)
+			return rc;
+
+		base_dpa += decode_length;
+	}
+
+	return 0;
+}
+
 static int mock_gsl(struct cxl_mbox_cmd *cmd)
 {
 	if (cmd->size_out < sizeof(mock_gsl_payload))
@@ -1371,6 +1588,177 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
 	return -EINVAL;
 }
 
+static int mock_get_dc_config(struct device *dev,
+			      struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_get_dc_config_in *dc_config = cmd->payload_in;
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	u8 region_requested, region_start_idx, region_ret_cnt;
+	struct cxl_mbox_get_dc_config_out *resp;
+
+	region_requested = dc_config->region_count;
+	if (region_requested > NUM_MOCK_DC_REGIONS)
+		region_requested = NUM_MOCK_DC_REGIONS;
+
+	if (cmd->size_out < struct_size(resp, region, region_requested))
+		return -EINVAL;
+
+	memset(cmd->payload_out, 0, cmd->size_out);
+	resp = cmd->payload_out;
+
+	region_start_idx = dc_config->start_region_index;
+	region_ret_cnt = 0;
+	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
+		if (i >= region_start_idx) {
+			memcpy(&resp->region[region_ret_cnt],
+				&mdata->dc_regions[i],
+				sizeof(resp->region[region_ret_cnt]));
+			region_ret_cnt++;
+		}
+	}
+	resp->avail_region_count = region_ret_cnt;
+
+	dev_dbg(dev, "Returning %d dc regions\n", region_ret_cnt);
+	return 0;
+}
+
+static int mock_get_dc_extent_list(struct device *dev,
+				   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_mbox_get_dc_extent_in *get = cmd->payload_in;
+	struct cxl_mbox_get_dc_extent_out *resp = cmd->payload_out;
+	u32 total_avail = 0, total_ret = 0;
+	struct cxl_dc_extent_data *ext;
+	u32 ext_count, start_idx;
+	unsigned long i;
+
+	ext_count = le32_to_cpu(get->extent_cnt);
+	start_idx = le32_to_cpu(get->start_extent_index);
+
+	memset(resp, 0, sizeof(*resp));
+
+	guard(mutex)(&mdata->ext_lock);
+	/*
+	 * Total available needs to be calculated and returned regardless of
+	 * how many can actually be returned.
+	 */
+	xa_for_each(&mdata->dc_accepted_exts, i, ext)
+		total_avail++;
+
+	if (start_idx > total_avail)
+		return -EINVAL;
+
+	xa_for_each(&mdata->dc_accepted_exts, i, ext) {
+		if (total_ret >= ext_count)
+			break;
+
+		if (total_ret >= start_idx) {
+			resp->extent[total_ret].start_dpa =
+						cpu_to_le64(ext->dpa_start);
+			resp->extent[total_ret].length =
+						cpu_to_le64(ext->length);
+			memcpy(&resp->extent[total_ret].tag, ext->tag,
+					sizeof(resp->extent[total_ret]));
+			total_ret++;
+		}
+	}
+
+	resp->ret_extent_cnt = cpu_to_le32(total_ret);
+	resp->total_extent_cnt = cpu_to_le32(total_avail);
+	resp->extent_list_num = cpu_to_le32(mdata->dc_ext_generation);
+
+	dev_dbg(dev, "Returning %d extents of %d total\n",
+		total_ret, total_avail);
+
+	return 0;
+}
+
+static int mock_add_dc_response(struct device *dev,
+				struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_dc_response *req = cmd->payload_in;
+	u32 list_size = le32_to_cpu(req->extent_list_size);
+
+	for (int i = 0; i < list_size; i++) {
+		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
+		u64 length = le64_to_cpu(req->extent_list[i].length);
+		int rc;
+
+		rc = dc_accept_extent(dev, start, length);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static void dc_delete_extent(struct device *dev, unsigned long long start,
+			     unsigned long long length)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	unsigned long long end = start + length;
+	struct cxl_dc_extent_data *ext;
+	unsigned long index;
+
+	dev_dbg(dev, "Deleting extent at %#llx len:%#llx\n", start, length);
+
+	guard(mutex)(&mdata->ext_lock);
+	xa_for_each(&mdata->dc_extents, index, ext) {
+		u64 extent_end = ext->dpa_start + ext->length;
+
+		/*
+		 * Any extent which 'touches' the released delete range will be
+		 * removed.
+		 */
+		if ((start <= ext->dpa_start && ext->dpa_start < end) ||
+		    (start <= extent_end && extent_end < end)) {
+			xa_erase(&mdata->dc_extents, ext->dpa_start);
+		}
+	}
+
+	/*
+	 * If the extent was accepted let it be for the host to drop
+	 * later.
+	 */
+}
+
+static int release_accepted_extent(struct device *dev,
+				   unsigned long long start,
+				   unsigned long long length)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_dc_extent_data *ext;
+
+	guard(mutex)(&mdata->ext_lock);
+	ext = find_create_ext(dev, &mdata->dc_accepted_exts, start, length);
+	if (!ext) {
+		dev_err(dev, "Extent %#llx not in accepted state\n", start);
+		return -EINVAL;
+	}
+	xa_erase(&mdata->dc_accepted_exts, ext->dpa_start);
+	mdata->dc_ext_generation++;
+
+	return 0;
+}
+
+static int mock_dc_release(struct device *dev,
+			   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_dc_response *req = cmd->payload_in;
+	u32 list_size = le32_to_cpu(req->extent_list_size);
+
+	for (int i = 0; i < list_size; i++) {
+		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
+		u64 length = le64_to_cpu(req->extent_list[i].length);
+
+		dev_dbg(dev, "Extent %#llx released by host\n", start);
+		release_accepted_extent(dev, start, length);
+	}
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
 			      struct cxl_mbox_cmd *cmd)
 {
@@ -1455,6 +1843,18 @@ static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
 	case CXL_MBOX_OP_ACTIVATE_FW:
 		rc = mock_activate_fw(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_DC_CONFIG:
+		rc = mock_get_dc_config(dev, cmd);
+		break;
+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
+		rc = mock_get_dc_extent_list(dev, cmd);
+		break;
+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
+		rc = mock_add_dc_response(dev, cmd);
+		break;
+	case CXL_MBOX_OP_RELEASE_DC:
+		rc = mock_dc_release(dev, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1499,6 +1899,14 @@ static void init_event_log(struct mock_event_log *log)
 	log->next_handle = 1;
 }
 
+static void cxl_mock_mem_remove(struct platform_device *pdev)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(&pdev->dev);
+	struct cxl_memdev_state *mds = mdata->mds;
+
+	dev_dbg(mds->cxlds.dev, "Removing extents\n");
+}
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1513,6 +1921,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	dev_set_drvdata(dev, mdata);
 
+	rc = cxl_mock_dc_region_setup(dev);
+	if (rc)
+		return rc;
+
 	mdata->lsa = vmalloc(LSA_SIZE);
 	if (!mdata->lsa)
 		return -ENOMEM;
@@ -1561,6 +1973,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = cxl_dev_dynamic_capacity_identify(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_create_range_info(mds);
 	if (rc)
 		return rc;
@@ -1673,14 +2089,170 @@ static ssize_t sanitize_timeout_store(struct device *dev,
 
 	return count;
 }
-
 static DEVICE_ATTR_RW(sanitize_timeout);
 
+/* Return if the proposed extent would break the test code */
+static bool new_extent_valid(struct device *dev, size_t new_start,
+			     size_t new_len)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_dc_extent_data *extent;
+	size_t new_end, i;
+
+	if (!new_len)
+		return false;
+
+	new_end = new_start + new_len;
+
+	dev_dbg(dev, "New extent %zx-%zx\n", new_start, new_end);
+
+	guard(mutex)(&mdata->ext_lock);
+	dev_dbg(dev, "Checking extents starts...\n");
+	xa_for_each(&mdata->dc_extents, i, extent) {
+		if (extent->dpa_start == new_start)
+			return false;
+	}
+
+	dev_dbg(dev, "Checking accepted extents starts...\n");
+	xa_for_each(&mdata->dc_accepted_exts, i, extent) {
+		if (extent->dpa_start == new_start)
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Format <start>:<length>:<tag>
+ *
+ * start and length must be a multiple of the configured region block size.
+ * Tag can be any string up to 16 bytes.
+ *
+ * Extents must be exclusive of other extents
+ */
+static ssize_t dc_inject_extent_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	unsigned long long start, length;
+	char *len_str, *tag_str;
+	size_t buf_len = count;
+	int rc;
+
+	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	if (!start_str)
+		return -ENOMEM;
+
+	len_str = strnchr(start_str, buf_len, ':');
+	if (!len_str) {
+		dev_err(dev, "Extent failed to find len_str: %s\n", start_str);
+		return -EINVAL;
+	}
+
+	*len_str = '\0';
+	len_str += 1;
+	buf_len -= strlen(start_str);
+
+	tag_str = strnchr(len_str, buf_len, ':');
+	if (!tag_str) {
+		dev_err(dev, "Extent failed to find tag_str: %s\n", len_str);
+		return -EINVAL;
+	}
+	*tag_str = '\0';
+	tag_str += 1;
+
+	if (kstrtoull(start_str, 0, &start)) {
+		dev_err(dev, "Extent failed to parse start: %s\n", start_str);
+		return -EINVAL;
+	}
+
+	if (kstrtoull(len_str, 0, &length)) {
+		dev_err(dev, "Extent failed to parse length: %s\n", len_str);
+		return -EINVAL;
+	}
+
+	if (!new_extent_valid(dev, start, length))
+		return -EINVAL;
+
+	rc = devm_add_extent(dev, start, length, tag_str);
+	if (rc) {
+		dev_err(dev, "Failed to add extent DPA:%#llx LEN:%#llx; %d\n",
+			start, length, rc);
+		return rc;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(dc_inject_extent);
+
+static ssize_t __dc_del_extent_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count,
+				     enum dc_event type)
+{
+	unsigned long long start, length;
+	char *len_str;
+
+	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	if (!start_str)
+		return -ENOMEM;
+
+	len_str = strnchr(start_str, count, ':');
+	if (!len_str) {
+		dev_err(dev, "Failed to find len_str: %s\n", start_str);
+		return -EINVAL;
+	}
+	*len_str = '\0';
+	len_str += 1;
+
+	if (kstrtoull(start_str, 0, &start)) {
+		dev_err(dev, "Failed to parse start: %s\n", start_str);
+		return -EINVAL;
+	}
+
+	if (kstrtoull(len_str, 0, &length)) {
+		dev_err(dev, "Failed to parse length: %s\n", len_str);
+		return -EINVAL;
+	}
+
+	dc_delete_extent(dev, start, length);
+
+	if (type == DCD_FORCED_CAPACITY_RELEASE)
+		dev_dbg(dev, "Forcing delete of extent %#llx len:%#llx\n",
+			start, length);
+
+	return count;
+}
+
+/*
+ * Format <start>:<length>
+ */
+static ssize_t dc_del_extent_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	return __dc_del_extent_store(dev, attr, buf, count,
+				     DCD_RELEASE_CAPACITY);
+}
+static DEVICE_ATTR_WO(dc_del_extent);
+
+static ssize_t dc_force_del_extent_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	return __dc_del_extent_store(dev, attr, buf, count,
+				     DCD_FORCED_CAPACITY_RELEASE);
+}
+static DEVICE_ATTR_WO(dc_force_del_extent);
+
 static struct attribute *cxl_mock_mem_attrs[] = {
 	&dev_attr_security_lock.attr,
 	&dev_attr_event_trigger.attr,
 	&dev_attr_fw_buf_checksum.attr,
 	&dev_attr_sanitize_timeout.attr,
+	&dev_attr_dc_inject_extent.attr,
+	&dev_attr_dc_del_extent.attr,
+	&dev_attr_dc_force_del_extent.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cxl_mock_mem);
@@ -1694,6 +2266,7 @@ MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);
 
 static struct platform_driver cxl_mock_mem_driver = {
 	.probe = cxl_mock_mem_probe,
+	.remove_new = cxl_mock_mem_remove,
 	.id_table = cxl_mock_mem_ids,
 	.driver = {
 		.name = KBUILD_MODNAME,

-- 
2.44.0


