Return-Path: <linux-btrfs+bounces-20747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC97DD3BF88
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 07:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23D543A4CEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69538F238;
	Tue, 20 Jan 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="AFQSVB2S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03038756E
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891411; cv=none; b=A56xdcBo7rs4M2Tjx3+i2jtA3nTuOnBl9qPmXuO0vqxUomgZatRAkTl4JmUKZFejy56hOxVlRMKp3xwwYUwgjqIJhEGxy5kmV/Sd/3dtwlrPuEm9lznaK64YqZa+Ad3OXEzyFzrYPgHl59u7JwHiPefRrVu7xtlb+ISBhUNnKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891411; c=relaxed/simple;
	bh=3/qG9jkP98RccEbYJ2y/zN2smeZD1I8r/nsINt0/Wrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OWpx8hAdq8l6GGWwS+maQY3un/ypyWNOytz0t6w8OWQrazIgBFbnk1/5g8jGjPO+wlwCYMKTxEG4Z2piWzy6s+rpqh1NLLo4cjpr1uYaxUEAr2wsszxYVJGnunZLIp1j5/JRdv+yb3A1vVImcv68MAGvgRcdwcnRS6CTJCB8j8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=AFQSVB2S; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4dwHpB6mWbzG3fkxX;
	Tue, 20 Jan 2026 14:43:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1768891395; bh=3/qG9jkP98RccEbYJ2y/zN2smeZD1I8r/nsINt0/Wrk=;
	h=From:To:Cc:Subject:Date;
	b=AFQSVB2SgE58Zyjc4C32kMgoKVHL30FMCj/gvoZ6y1YW5QwbZygv8e2XUvMRFI/zJ
	 sydSH4eivUqhN9fUm1ThKjn4Y4SaIEHeAUhUwnmi8x30BX6SWrCdHA3ZZhyGA0PuF8
	 A6nyaW3ePu9JYsEm/8ciSSp8clep9fPyW5YZMEKM=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com,
	jinbaohong@synology.com,
	robbieko <robbieko@synology.com>
Subject: [PATCH] btrfs: fix transaction commit blocking during trim of unallocated space
Date: Tue, 20 Jan 2026 06:43:05 +0000
Message-Id: <20260120064305.439036-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Content-Type: text/plain

When trimming unallocated space, btrfs_trim_fs() holds device_list_mutex
for the entire duration while iterating through all devices. On large
filesystems with significant unallocated space, this operation can take
minutes to hours on large storage systems.

This causes a problem because btrfs_run_dev_stats(), which is called
during transaction commit, also requires device_list_mutex:

  btrfs_trim_fs()
    mutex_lock(&fs_devices->device_list_mutex)
    list_for_each_entry(device, ...)
      btrfs_trim_free_extents(device)
    mutex_unlock(&fs_devices->device_list_mutex)

  commit_transaction()
    btrfs_run_dev_stats()
      mutex_lock(&fs_devices->device_list_mutex)  // blocked!
      ...

While trim is running, all transaction commits are blocked waiting for
the mutex.

Fix this by refactoring btrfs_trim_free_extents() to process devices in
bounded chunks (up to 2GB per iteration) and release device_list_mutex
between chunks.

Signed-off-by: robbieko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
---
 fs/btrfs/extent-tree.c | 145 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 127 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 89495e6f8269..7b4708212be6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6400,10 +6400,13 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
  * it while performing the free space search since we have already
  * held back allocations.
  */
-static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
+static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
+		u64 *trimmed, u64 pos, u64 maxlen, u64 *ret_next_pos)
 {
-	u64 start = BTRFS_DEVICE_RANGE_RESERVED, len = 0, end = 0;
+	u64 start = pos, len = 0, end = 0;
 	int ret;
+	u64 cur_start;
+	u64 trim_len = 0;
 
 	*trimmed = 0;
 
@@ -6429,9 +6432,11 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		if (ret)
 			break;
 
+		cur_start = start;
 		btrfs_find_first_clear_extent_bit(&device->alloc_state, start,
 						  &start, &end,
 						  CHUNK_TRIMMED | CHUNK_ALLOCATED);
+		start = max(start, cur_start);
 
 		/* Check if there are any CHUNK_* bits left */
 		if (start > device->total_bytes) {
@@ -6457,6 +6462,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		end = min(end, device->total_bytes - 1);
 
 		len = end - start + 1;
+		len = min(len, maxlen);
 
 		/* We didn't find any extents */
 		if (!len) {
@@ -6477,6 +6483,12 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 
 		start += len;
 		*trimmed += bytes;
+		trim_len += len;
+		if (trim_len >= maxlen) {
+			*ret_next_pos = start;
+			ret = -EAGAIN;
+			break;
+		}
 
 		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
@@ -6489,6 +6501,114 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 	return ret;
 }
 
+
+static int btrfs_trim_free_extents(struct btrfs_fs_info *fs_info, u64 *trimmed)
+{
+	int ret;
+	struct btrfs_device *dev;
+	struct btrfs_device *working_dev = NULL;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	u8 uuid[BTRFS_UUID_SIZE];
+	u64 start = BTRFS_DEVICE_RANGE_RESERVED;
+	u64 maxlen = SZ_2G;
+	u64 next_pos = 0;
+	u64 group_trimmed;
+
+	*trimmed = 0;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+			continue;
+		if (!working_dev ||
+			memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_SIZE) < 0)
+			working_dev = dev;
+	}
+	if (working_dev)
+		memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
+	mutex_unlock(&fs_devices->device_list_mutex);
+	if (!working_dev) {
+		ret = 0;
+		goto out;
+	}
+
+	while (1) {
+		mutex_lock(&fs_devices->device_list_mutex);
+		ret = 0;
+
+		group_trimmed = 0;
+		list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+			if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+				continue;
+			if (dev == working_dev) {
+				ret = btrfs_trim_free_extents_throttle(working_dev,
+					&group_trimmed, start, maxlen, &next_pos);
+				break;
+			}
+		}
+		*trimmed += group_trimmed;
+
+		if (!ret) {
+			/*
+			 * Device completed, go next device.
+			 * Find a device which has the smallest uuid but larger than
+			 * current one.
+			 * Note: Devices added during trim with UUID smaller than the
+			 * current device will be skipped.
+			 */
+			working_dev = NULL;
+			list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+				if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+					continue;
+
+				/* must larger than current uuid */
+				if (memcmp(dev->uuid, uuid, BTRFS_UUID_SIZE) <= 0)
+					continue;
+
+				/* find the smallest */
+				if (!working_dev ||
+					memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_SIZE) < 0)
+					working_dev = dev;
+			}
+			if (working_dev)
+				memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
+			start = BTRFS_DEVICE_RANGE_RESERVED;
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+
+		if (ret == -EAGAIN) {
+			/*
+			 * Ensure next_pos actually progressed beyond start.
+			 * If not, we're stuck and must break to avoid infinite loop.
+			 */
+			if (next_pos <= start) {
+				btrfs_warn(fs_info,
+				   "trim throttle: no progress, start=%llu next_pos=%llu, aborting",
+				   start, next_pos);
+				goto out;
+			}
+			start = next_pos;
+			ret = 0;
+		}
+
+		if (ret)
+			goto out;
+
+		if (!working_dev) /* error or no more device */
+			break;
+
+		if (btrfs_trim_interrupted()) {
+			ret = -ERESTARTSYS;
+			goto out;
+		}
+		cond_resched();
+	}
+
+	ret = 0;
+out:
+	return ret;
+}
+
 /*
  * Trim the whole filesystem by:
  * 1) trimming the free space in each block group
@@ -6500,9 +6620,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
  */
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 {
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_block_group *cache = NULL;
-	struct btrfs_device *device;
 	u64 group_trimmed;
 	u64 range_end = U64_MAX;
 	u64 start;
@@ -6564,21 +6682,12 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			"failed to trim %llu block group(s), last error %d",
 			bg_failed, bg_ret);
 
-	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
-			continue;
-
-		ret = btrfs_trim_free_extents(device, &group_trimmed);
-
-		trimmed += group_trimmed;
-		if (ret) {
-			dev_failed++;
-			dev_ret = ret;
-			break;
-		}
+	ret = btrfs_trim_free_extents(fs_info, &group_trimmed);
+	trimmed += group_trimmed;
+	if (ret) {
+		dev_failed++;
+		dev_ret = ret;
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	if (dev_failed)
 		btrfs_warn(fs_info,
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

