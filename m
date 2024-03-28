Return-Path: <linux-btrfs+bounces-3547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBA888BB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7621F24DEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347C18B5F3;
	Sun, 24 Mar 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baGJvKbb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F615ECF9;
	Sun, 24 Mar 2024 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322315; cv=none; b=CLMPzDie1jfCxBlPaLeiftWFY0TzsTHlVZYZBZPbyBy+yOUNsr/TyFDG/Pk/cJa7sbqx/PfHxJcK8lHMVd4F9eF1vumpF1bZLhggEQLpfe16A0IXvkAkgCsVL95rmjmUtGwT0buOOo7C74MijhhAwOavTtRqdrLpWMCSSdDxv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322315; c=relaxed/simple;
	bh=qNDdcDSP8wEaAJJd7uyKmBgAQscJG7aJdkOstM+hti4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6TApecoIvKd4Tz3xQyqO7NpzgDrRpEWlcDzrDHB5ikGn23hwwJZby57BSJTckCJ6gMSb32MBPVHAc/3UTpxsbH6FFLx7fwxYJVHdPgOfJ9eorc776eS//5B94jdXS+JTe9V2FI47ZPy4Vjpn2+7mkQdpuapjw863RZ6Bl5hS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baGJvKbb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322313; x=1742858313;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qNDdcDSP8wEaAJJd7uyKmBgAQscJG7aJdkOstM+hti4=;
  b=baGJvKbbKckOK+FR8mNvCMdMcxR11Koj4VuDaT8zl937AGBbasHturg1
   eYAALQXTdyQMptZ9U1ehNuAHHs5+95PKHrmktuJ4lniLTB7gTnPrkIxFu
   dkB8R0dLrKFHeTG8BxXV/ysxGcrALRnbE5GVhxsxnsVr5TomEXJhoA6M+
   ReUa5QG24EJyr7KbYKd7k9D9NKQEow7q4QssjFkTQsBqsWnydbwzlLg8R
   msXVj+ivgdaE9V9hJLVLWofFTcthI+p/BvUsSxAXXfHKXgJY26+42bJh+
   dlRBOW0cpD3yv/wM7yBku3hlFLuax5GArjThqsbs+ldUcsdMGffVdH7FH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431773"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464739"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:27 -0700
Subject: [PATCH 24/26] tools/testing/cxl: Make event logs dynamic
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-24-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=15319;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=qNDdcDSP8wEaAJJd7uyKmBgAQscJG7aJdkOstM+hti4=;
 b=x25M1ktIhLuCYWQpdNm/VSic4+qXTwF6HdG8/iGYkv0AARVpR+KWbfbGl/YkaJdqRPvQAqFux
 BLZzYUBV2I5Au34+EkcPb69duZFWTeGoVHs5kxGGj+oFTKqNbFOpJk2
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The test event logs were created as static arrays as an easy way to mock
events.  Dynamic Capacity Device (DCD) test support requires events be
generated dynamically when extents are created or destroyed.

Modify the event log storage to be dynamically allocated.  Reuse the
static event data to create the dynamic events in the new logs without
inventing complex event injection for the previous tests.  Simplify the
processing of the logs by using the event log array index as the handle.
Add a lock to manage concurrency required when user space is allowed to
control DCD extents

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
[iweiny: Adjust for new event code]
---
 tools/testing/cxl/test/mem.c | 281 ++++++++++++++++++++++++++-----------------
 1 file changed, 172 insertions(+), 109 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 35ee41e435ab..d8d62e6eeb18 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -124,18 +124,27 @@ static struct {
 
 #define PASS_TRY_LIMIT 3
 
-#define CXL_TEST_EVENT_CNT_MAX 15
+#define CXL_TEST_EVENT_CNT_MAX 17
 
 /* Set a number of events to return at a time for simulation.  */
 #define CXL_TEST_EVENT_CNT 3
 
+/*
+ * @next_handle: next handle (index) to be stored to
+ * @cur_handle: current handle (index) to be returned to the user on get_event
+ * @nr_events: total events in this log
+ * @nr_overflow: number of events added past the log size
+ * @lock: protect these state variables
+ * @events: array of pending events to be returned.
+ */
 struct mock_event_log {
-	u16 clear_idx;
-	u16 cur_idx;
+	u16 next_handle;
+	u16 cur_handle;
 	u16 nr_events;
 	u16 nr_overflow;
-	u16 overflow_reset;
-	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
+	rwlock_t lock;
+	/* 1 extra slot to accommodate that handles can't be 0 */
+	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX + 1];
 };
 
 struct mock_event_store {
@@ -170,64 +179,76 @@ static struct mock_event_log *event_find_log(struct device *dev, int log_type)
 	return &mdata->mes.mock_logs[log_type];
 }
 
-static struct cxl_event_record_raw *event_get_current(struct mock_event_log *log)
-{
-	return log->events[log->cur_idx];
-}
-
-static void event_reset_log(struct mock_event_log *log)
-{
-	log->cur_idx = 0;
-	log->clear_idx = 0;
-	log->nr_overflow = log->overflow_reset;
-}
-
 /* Handle can never be 0 use 1 based indexing for handle */
-static u16 event_get_clear_handle(struct mock_event_log *log)
+static void event_inc_handle(u16 *handle)
 {
-	return log->clear_idx + 1;
+	*handle = (*handle + 1) % CXL_TEST_EVENT_CNT_MAX;
+	if (!*handle)
+		*handle = *handle + 1;
 }
 
-/* Handle can never be 0 use 1 based indexing for handle */
-static __le16 event_get_cur_event_handle(struct mock_event_log *log)
-{
-	u16 cur_handle = log->cur_idx + 1;
-
-	return cpu_to_le16(cur_handle);
-}
-
-static bool event_log_empty(struct mock_event_log *log)
-{
-	return log->cur_idx == log->nr_events;
-}
-
-static void mes_add_event(struct mock_event_store *mes,
+/* Add the event or free it on 'overflow' */
+static void mes_add_event(struct cxl_mockmem_data *mdata,
 			  enum cxl_event_log_type log_type,
 			  struct cxl_event_record_raw *event)
 {
+	struct device *dev = mdata->mds->cxlds.dev;
 	struct mock_event_log *log;
+	u16 handle;
 
 	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
 		return;
 
-	log = &mes->mock_logs[log_type];
+	log = &mdata->mes.mock_logs[log_type];
 
-	if ((log->nr_events + 1) > CXL_TEST_EVENT_CNT_MAX) {
+	write_lock(&log->lock);
+
+	handle = log->next_handle;
+	if ((handle + 1) == log->cur_handle) {
 		log->nr_overflow++;
-		log->overflow_reset = log->nr_overflow;
-		return;
+		dev_dbg(dev, "Overflowing %d\n", log_type);
+		devm_kfree(dev, event);
+		goto unlock;
 	}
 
-	log->events[log->nr_events] = event;
+	dev_dbg(dev, "Log %d; handle %u\n", log_type, handle);
+	event->event.generic.hdr.handle = cpu_to_le16(handle);
+	log->events[handle] = event;
+	event_inc_handle(&log->next_handle);
 	log->nr_events++;
+
+unlock:
+	write_unlock(&log->lock);
+}
+
+static void mes_del_event(struct device *dev,
+			  struct mock_event_log *log,
+			  u16 handle)
+{
+	struct cxl_event_record_raw *cur;
+
+	lockdep_assert(lockdep_is_held(&log->lock));
+
+	dev_dbg(dev, "Clearing event %u; cur %u\n", handle, log->cur_handle);
+	cur = log->events[handle];
+	if (!cur) {
+		dev_err(dev, "Mock event index %u empty? nr_events %u",
+			handle, log->nr_events);
+		return;
+	}
+	log->events[handle] = NULL;
+
+	event_inc_handle(&log->cur_handle);
+	log->nr_events--;
+	devm_kfree(dev, cur);
 }
 
 static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
-	u16 nr_overflow;
 	u8 log_type;
+	u16 handle;
 	int i;
 
 	if (cmd->size_in != sizeof(log_type))
@@ -240,31 +261,40 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 	if (log_type >= CXL_EVENT_TYPE_MAX)
 		return -EINVAL;
 
-	memset(cmd->payload_out, 0, cmd->size_out);
-
 	log = event_find_log(dev, log_type);
-	if (!log || event_log_empty(log))
+	if (!log)
 		return 0;
 
+	memset(cmd->payload_out, 0, cmd->size_out);
 	pl = cmd->payload_out;
 
-	for (i = 0; i < CXL_TEST_EVENT_CNT && !event_log_empty(log); i++) {
-		memcpy(&pl->records[i], event_get_current(log),
-		       sizeof(pl->records[i]));
-		pl->records[i].event.generic.hdr.handle =
-				event_get_cur_event_handle(log);
-		log->cur_idx++;
+	read_lock(&log->lock);
+
+	handle = log->cur_handle;
+	dev_dbg(dev, "Get log %d handle %u next %u\n",
+		log_type, handle, log->next_handle);
+	for (i = 0;
+	     i < CXL_TEST_EVENT_CNT && handle != log->next_handle;
+	     i++, event_inc_handle(&handle)) {
+		struct cxl_event_record_raw *cur;
+
+		cur = log->events[handle];
+		dev_dbg(dev, "Sending event log %d handle %d idx %u\n",
+			log_type, le16_to_cpu(cur->event.generic.hdr.handle),
+			handle);
+		memcpy(&pl->records[i], cur, sizeof(pl->records[i]));
+		pl->records[i].event.generic.hdr.handle = cpu_to_le16(handle);
 	}
 
 	pl->record_count = cpu_to_le16(i);
-	if (!event_log_empty(log))
+	if (log->nr_events > i)
 		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
 
 	if (log->nr_overflow) {
 		u64 ns;
 
 		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
-		pl->overflow_err_count = cpu_to_le16(nr_overflow);
+		pl->overflow_err_count = cpu_to_le16(log->nr_overflow);
 		ns = ktime_get_real_ns();
 		ns -= 5000000000; /* 5s ago */
 		pl->first_overflow_timestamp = cpu_to_le64(ns);
@@ -273,16 +303,17 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 		pl->last_overflow_timestamp = cpu_to_le64(ns);
 	}
 
+	read_unlock(&log->lock);
 	return 0;
 }
 
 static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
-	struct mock_event_log *log;
 	u8 log_type = pl->event_log;
+	struct mock_event_log *log;
+	int nr, rc = 0;
 	u16 handle;
-	int nr;
 
 	if (log_type >= CXL_EVENT_TYPE_MAX)
 		return -EINVAL;
@@ -291,24 +322,23 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 	if (!log)
 		return 0; /* No mock data in this log */
 
-	/*
-	 * This check is technically not invalid per the specification AFAICS.
-	 * (The host could 'guess' handles and clear them in order).
-	 * However, this is not good behavior for the host so test it.
-	 */
-	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
-		dev_err(dev,
-			"Attempting to clear more events than returned!\n");
-		return -EINVAL;
-	}
+	write_lock(&log->lock);
 
 	/* Check handle order prior to clearing events */
-	for (nr = 0, handle = event_get_clear_handle(log);
-	     nr < pl->nr_recs;
-	     nr++, handle++) {
+	handle = log->cur_handle;
+	for (nr = 0;
+	     nr < pl->nr_recs && handle != log->next_handle;
+	     nr++, event_inc_handle(&handle)) {
+
+		dev_dbg(dev, "Checking clear of %d handle %u plhandle %u\n",
+			log_type, handle,
+			le16_to_cpu(pl->handles[nr]));
+
 		if (handle != le16_to_cpu(pl->handles[nr])) {
-			dev_err(dev, "Clearing events out of order\n");
-			return -EINVAL;
+			dev_err(dev, "Clearing events out of order %u %u\n",
+				handle, le16_to_cpu(pl->handles[nr]));
+			rc = -EINVAL;
+			goto unlock;
 		}
 	}
 
@@ -316,25 +346,12 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 		log->nr_overflow = 0;
 
 	/* Clear events */
-	log->clear_idx += pl->nr_recs;
-	return 0;
-}
+	for (nr = 0; nr < pl->nr_recs; nr++)
+		mes_del_event(dev, log, le16_to_cpu(pl->handles[nr]));
 
-static void cxl_mock_event_trigger(struct device *dev)
-{
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
-	struct mock_event_store *mes = &mdata->mes;
-	int i;
-
-	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
-		struct mock_event_log *log;
-
-		log = event_find_log(dev, i);
-		if (log)
-			event_reset_log(log);
-	}
-
-	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
+unlock:
+	write_unlock(&log->lock);
+	return rc;
 }
 
 struct cxl_event_record_raw maint_needed = {
@@ -459,8 +476,27 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-static void cxl_mock_add_event_logs(struct mock_event_store *mes)
+/* Create a dynamically allocated event out of a statically defined event. */
+static void add_event_from_static(struct cxl_mockmem_data *mdata,
+				  enum cxl_event_log_type log_type,
+				  struct cxl_event_record_raw *raw)
 {
+	struct device *dev = mdata->mds->cxlds.dev;
+	struct cxl_event_record_raw *rec;
+
+	rec = devm_kmemdup(dev, raw, sizeof(*rec), GFP_KERNEL);
+	if (!rec) {
+		dev_err(dev, "Failed to alloc event for log\n");
+		return;
+	}
+	mes_add_event(mdata, log_type, rec);
+}
+
+static void cxl_mock_add_event_logs(struct cxl_mockmem_data *mdata)
+{
+	struct mock_event_store *mes = &mdata->mes;
+	struct device *dev = mdata->mds->cxlds.dev;
+
 	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
 			   &gen_media.rec.validity_flags);
 
@@ -468,43 +504,60 @@ static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
 			   &dram.rec.validity_flags);
 
-	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
-	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
+	dev_dbg(dev, "Generating fake event logs %d\n",
+		CXL_EVENT_TYPE_INFO);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO, &maint_needed);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO,
 		      (struct cxl_event_record_raw *)&gen_media);
-	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
+	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO,
 		      (struct cxl_event_record_raw *)&mem_module);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
 
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	dev_dbg(dev, "Generating fake event logs %d\n",
+		CXL_EVENT_TYPE_FAIL);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &maint_needed);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
+		      (struct cxl_event_record_raw *)&mem_module);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&dram);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&gen_media);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&mem_module);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
 		      (struct cxl_event_record_raw *)&dram);
 	/* Overflow this log */
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
 
-	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
-	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
+	dev_dbg(dev, "Generating fake event logs %d\n",
+		CXL_EVENT_TYPE_FATAL);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+	add_event_from_static(mdata, CXL_EVENT_TYPE_FATAL,
 		      (struct cxl_event_record_raw *)&dram);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
 }
 
+static void cxl_mock_event_trigger(struct device *dev)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct mock_event_store *mes = &mdata->mes;
+
+	cxl_mock_add_event_logs(mdata);
+	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
+}
+
 static int mock_gsl(struct cxl_mbox_cmd *cmd)
 {
 	if (cmd->size_out < sizeof(mock_gsl_payload))
@@ -1438,6 +1491,14 @@ static ssize_t event_trigger_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(event_trigger);
 
+static void init_event_log(struct mock_event_log *log)
+{
+	rwlock_init(&log->lock);
+	/* Handle can never be 0 use 1 based indexing for handle */
+	log->cur_handle = 1;
+	log->next_handle = 1;
+}
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1504,7 +1565,9 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	cxl_mock_add_event_logs(&mdata->mes);
+	for (int i = 0; i < CXL_EVENT_TYPE_MAX; i++)
+		init_event_log(&mdata->mes.mock_logs[i]);
+	cxl_mock_add_event_logs(mdata);
 
 	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
 	if (IS_ERR(cxlmd))

-- 
2.44.0


