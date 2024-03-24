Return-Path: <linux-btrfs+bounces-3540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F888909F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 07:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B1B1F27F04
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392002AE8D8;
	Sun, 24 Mar 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KyyL16QT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5D1E621F;
	Sun, 24 Mar 2024 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322316; cv=none; b=QMfmAEzpC0b3Ne/1vkv2GdSpa0qxypewhf0DgWUsClaO/i8WcC4bw5hnm18e3tKKGudY7tvOV0NWNPsMwMe1HsRqsf6u4zB5MOuva/63UDITw49+x+NdvHIEkSDu7c7moVcsgmR/E+IpAi9bByaOgXNKRUNEoaO0+huukBwAOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322316; c=relaxed/simple;
	bh=4r1yORMfG2GW4l9FysFu86n8CxAflr6BotLuESBN30Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sj9QsrPEERNRVkrTuV3WVllgHbpWAHORAG3DFf8MVu6bt4G3ZtkDrSu18NE6kSFWXVVZpjZAL0+ZbfWFVVrSq+57VuYgc9wpdmYGsf2ux+1j8DP1dfJk7uKavldaGkGEIFUBM7MUQ8gssU00azgD/2ZyxDvLQfhYFP8w/0PYbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KyyL16QT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322315; x=1742858315;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4r1yORMfG2GW4l9FysFu86n8CxAflr6BotLuESBN30Y=;
  b=KyyL16QTu6UuA+b0sx6LRx1oGItbQQvIsdQvnSolQeqJqvGiYz9+PM+k
   s1VRDQcduTW3xgWOaSzXlq25la7Jjaf4toMHyOPm8HGdu6phQCjgmgm6F
   TtxEmqB3NhlLb8q0tYS9FulhihU3+NSRLGgdrIGdrTdUyE55AgmoB0642
   X/x181JwsvZq5E+J/7a6AR+GmzwJHl2ijCGus9tJFoVw/klR2bNSuDD5i
   BzlU2OwOIJVt0GCXTX9e7QnpRFc+cribbPCNVf2d0pn9/DZ76W9vd2zn+
   Gop2vrFj6pTKipWmnyT+ZeDjMdZvrp3c7hlpKXcZpA5XCtPsgcnEnicGY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431781"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431781"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464745"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:25 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:29 -0700
Subject: [PATCH 26/26] tools/testing/cxl: Add Dynamic Capacity events
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-26-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=3859;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=4r1yORMfG2GW4l9FysFu86n8CxAflr6BotLuESBN30Y=;
 b=2wMkvzR7hOyCAE/hZCpNZoz7BvuAavRQSyPfw4ZEfsjYXlVPnG9KQlvo0fHS12TZ7TTfvULM3
 UmqKvDZxmMdDqmEz7Ik1KCnLdr0HY+k36CZ+hl3JaKzp0FhbY1mWPMN
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

cxl_test provides a good way to ensure quick smoke and regression
testing.  The complexity of DCD and the new sparse DAX regions required
to use them benefits greatly with a series of smoke tests.

The only part of the kernel stack which must be bypassed is the actual
irq of DCD events.  However, the event processing itself can be tested
via cxl_test calling directly the event processing function directly.

In this way the rest of the stack; management of sparse regions, the
extent device lifetimes, and the dax device operations can be tested.

Add Dynamic Capacity Device tests for kernels which have DCD support in
cxl_test.

Add events on DCD extent injection.  Directly call the event irq
callback to simulate irqs to process the test extents.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes for v1
[iweiny: Adjust to new events]
---
 tools/testing/cxl/test/mem.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 7d1d897d9f2b..e7efb1d3e20f 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -2122,6 +2122,49 @@ static bool new_extent_valid(struct device *dev, size_t new_start,
 	return true;
 }
 
+struct cxl_test_dcd {
+	uuid_t id;
+	struct cxl_event_dcd rec;
+} __packed;
+
+struct cxl_test_dcd dcd_event_rec_template = {
+	.id = CXL_EVENT_DC_EVENT_UUID,
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_dcd),
+		},
+	},
+};
+
+static int log_dc_event(struct cxl_mockmem_data *mdata, enum dc_event type,
+			u64 start, u64 length, const char *tag_str)
+{
+	struct device *dev = mdata->mds->cxlds.dev;
+	struct cxl_test_dcd *dcd_event;
+
+	dev_dbg(dev, "mock device log event %d\n", type);
+
+	dcd_event = devm_kmemdup(dev, &dcd_event_rec_template,
+				     sizeof(*dcd_event), GFP_KERNEL);
+	if (!dcd_event)
+		return -ENOMEM;
+
+	dcd_event->rec.event_type = type;
+	dcd_event->rec.extent.start_dpa = cpu_to_le64(start);
+	dcd_event->rec.extent.length = cpu_to_le64(length);
+	memcpy(dcd_event->rec.extent.tag, tag_str,
+	       min(sizeof(dcd_event->rec.extent.tag),
+		   strlen(tag_str)));
+
+	mes_add_event(mdata, CXL_EVENT_TYPE_DCD,
+		      (struct cxl_event_record_raw *)dcd_event);
+
+	/* Fake the irq */
+	cxl_mem_get_event_records(mdata->mds, CXLDEV_EVENT_STATUS_DCD);
+
+	return 0;
+}
+
 /*
  * Format <start>:<length>:<tag>
  *
@@ -2134,6 +2177,7 @@ static ssize_t dc_inject_extent_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf, size_t count)
 {
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
 	unsigned long long start, length;
 	char *len_str, *tag_str;
 	size_t buf_len = count;
@@ -2181,6 +2225,12 @@ static ssize_t dc_inject_extent_store(struct device *dev,
 		return rc;
 	}
 
+	rc = log_dc_event(mdata, DCD_ADD_CAPACITY, start, length, tag_str);
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 static DEVICE_ATTR_WO(dc_inject_extent);
@@ -2190,8 +2240,10 @@ static ssize_t __dc_del_extent_store(struct device *dev,
 				     const char *buf, size_t count,
 				     enum dc_event type)
 {
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
 	unsigned long long start, length;
 	char *len_str;
+	int rc;
 
 	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
 	if (!start_str)
@@ -2221,6 +2273,12 @@ static ssize_t __dc_del_extent_store(struct device *dev,
 		dev_dbg(dev, "Forcing delete of extent %#llx len:%#llx\n",
 			start, length);
 
+	rc = log_dc_event(mdata, type, start, length, "");
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 

-- 
2.44.0


