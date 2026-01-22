Return-Path: <linux-btrfs+bounces-20888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIUoAgHFcWnfLwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20888-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 07:34:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ECF62456
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 07:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F14C9DB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58570438FF3;
	Thu, 22 Jan 2026 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="lXiyqKRm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9F3904C5
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769063638; cv=none; b=JgOA+LOTRXPiRe4We2twiqqXutPrg7Q+m9rhyFR89/kNLyNU/PAAkmtk30sEHjEFF76noYuvdD1n6CDhKtbHgFKjg/6axmhM/Al2TTRtHnPUAzJFSMcKKhmYQeVIx3jJbNwTQXt/UIybrpVXT339j1tEN8XDkvNt06SgLt3NOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769063638; c=relaxed/simple;
	bh=aCMjsQBeJphHppZJnZGE8G7xZ9Yab2RvvHrLee6xeco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ka2UdJkqUj1zvk4MkzUGVX034Og+dBEAsBcHnlbeO3KEdLUMCAWqzwSMLnA2+DAexXFGdkIK42D1bf0jQvlHlGUScKGxdDABWa7+zmujB9WS+Ie9fmS2QFcFi9OByFh6WHHLGD+xlENFBRKDmvZpqSnpb0xDhjCKJKjN/fuaRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=lXiyqKRm; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4dxWVV4xR2zG5q9Gm;
	Thu, 22 Jan 2026 14:33:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769063634; bh=aCMjsQBeJphHppZJnZGE8G7xZ9Yab2RvvHrLee6xeco=;
	h=From:To:Cc:Subject:Date;
	b=lXiyqKRmuPr+TyPLyzN61xgxDQ8H8fgqGyQ8x9Y/kVPRFM41sMvRjZx5bE1wk5n2D
	 iNg7ECuTMY3D4TadBY+rsCPfnwYcMaj9FCvdwf9tyTtmuRm/t92flqU8EqGqx++u8g
	 BRzGBBTCbMF7VOgH0awurA3CHlH93nEwavaG9CjY=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com,
	jinbaohong@synology.com,
	fdmanana@kernel.org,
	robbieko <robbieko@synology.com>
Subject: [PATCH v2] btrfs: fix transaction commit blocking during trim of unallocated space
Date: Thu, 22 Jan 2026 06:33:50 +0000
Message-Id: <20260122063350.503383-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20888-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DMARC_POLICY_ALLOW(0.00)[synology.com,quarantine];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E6ECF62456
X-Rspamd-Action: no action

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
Changes in v2:
- Add #define BTRFS_MAX_TRIM_LENGTH, remove maxlen parameter (Filipe)
- Move loop-only variables into loop scope (Filipe)
- Fix comment style: capitalization and punctuation (Filipe)
- Replace goto patterns with direct returns (Filipe)
---
 fs/btrfs/extent-tree.c | 148 +++++++++++++++++++++++++++++++++++------
 1 file changed, 128 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 89495e6f8269..04b6c36418c4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6380,6 +6380,9 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
 	unpin_extent_range(fs_info, start, end, false);
 }
 
+/* Maximum length to trim in a single iteration to avoid holding mutex too long. */
+#define BTRFS_MAX_TRIM_LENGTH SZ_2G
+
 /*
  * It used to be that old block groups would be left around forever.
  * Iterating over them would be enough to trim unused space.  Since we
@@ -6400,10 +6403,12 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
  * it while performing the free space search since we have already
  * held back allocations.
  */
-static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
+static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
+		u64 *trimmed, u64 pos, u64 *ret_next_pos)
 {
-	u64 start = BTRFS_DEVICE_RANGE_RESERVED, len = 0, end = 0;
 	int ret;
+	u64 start = pos;
+	u64 trim_len = 0;
 
 	*trimmed = 0;
 
@@ -6423,17 +6428,22 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 
 	while (1) {
 		struct btrfs_fs_info *fs_info = device->fs_info;
+		u64 cur_start;
+		u64 end;
+		u64 len;
 		u64 bytes;
 
 		ret = mutex_lock_interruptible(&fs_info->chunk_mutex);
 		if (ret)
 			break;
 
+		cur_start = start;
 		btrfs_find_first_clear_extent_bit(&device->alloc_state, start,
 						  &start, &end,
 						  CHUNK_TRIMMED | CHUNK_ALLOCATED);
+		start = max(start, cur_start);
 
-		/* Check if there are any CHUNK_* bits left */
+		/* Check if there are any CHUNK_* bits left. */
 		if (start > device->total_bytes) {
 			DEBUG_WARN();
 			btrfs_warn(fs_info,
@@ -6457,8 +6467,9 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		end = min(end, device->total_bytes - 1);
 
 		len = end - start + 1;
+		len = min(len, BTRFS_MAX_TRIM_LENGTH);
 
-		/* We didn't find any extents */
+		/* We didn't find any extents. */
 		if (!len) {
 			mutex_unlock(&fs_info->chunk_mutex);
 			ret = 0;
@@ -6477,6 +6488,12 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 
 		start += len;
 		*trimmed += bytes;
+		trim_len += len;
+		if (trim_len >= BTRFS_MAX_TRIM_LENGTH) {
+			*ret_next_pos = start;
+			ret = -EAGAIN;
+			break;
+		}
 
 		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
@@ -6489,6 +6506,108 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 	return ret;
 }
 
+static int btrfs_trim_free_extents(struct btrfs_fs_info *fs_info, u64 *trimmed)
+{
+	int ret;
+	struct btrfs_device *dev;
+	struct btrfs_device *working_dev = NULL;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	u8 uuid[BTRFS_UUID_SIZE];
+	u64 start = BTRFS_DEVICE_RANGE_RESERVED;
+
+	*trimmed = 0;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+			continue;
+		if (!working_dev ||
+		    memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_SIZE) < 0)
+			working_dev = dev;
+	}
+	if (working_dev)
+		memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
+	mutex_unlock(&fs_devices->device_list_mutex);
+	if (!working_dev)
+		return 0;
+
+	while (1) {
+		u64 group_trimmed = 0;
+		u64 next_pos = 0;
+
+		ret = 0;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+
+		list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+			if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+				continue;
+			if (dev == working_dev) {
+				ret = btrfs_trim_free_extents_throttle(working_dev,
+					&group_trimmed, start, &next_pos);
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
+				/* Must be larger than current uuid. */
+				if (memcmp(dev->uuid, uuid, BTRFS_UUID_SIZE) <= 0)
+					continue;
+
+				/* Find the smallest. */
+				if (!working_dev ||
+				    memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_SIZE) < 0)
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
+				return ret;
+			}
+			start = next_pos;
+			ret = 0;
+		}
+
+		if (ret)
+			return ret;
+
+		/* Error or no more device. */
+		if (!working_dev)
+			break;
+
+		if (btrfs_trim_interrupted())
+			return -ERESTARTSYS;
+
+		cond_resched();
+	}
+	return 0;
+}
+
 /*
  * Trim the whole filesystem by:
  * 1) trimming the free space in each block group
@@ -6500,9 +6619,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
  */
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 {
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_block_group *cache = NULL;
-	struct btrfs_device *device;
 	u64 group_trimmed;
 	u64 range_end = U64_MAX;
 	u64 start;
@@ -6564,21 +6681,12 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
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

