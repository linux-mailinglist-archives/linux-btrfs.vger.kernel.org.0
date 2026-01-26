Return-Path: <linux-btrfs+bounces-21056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHzoBL0nd2kUcwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21056-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:37:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7718587B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FD9300EAAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8A1DF254;
	Mon, 26 Jan 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="dNXQp4Ts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728626B741
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416613; cv=none; b=VzGUHYLeRXfWmb3mOoQ4fu5Zor6WVvXWwKZsQodHohwGyPZg/bUdpyF52zv1hZP2+L96Xr9AU4+nl8qdjZfRJ+66y/izF58KrT+nFZGXgRX4ZMTKLm3Oo3FR2g43sH6AFYJzlwKfkaN6Te04SgNC6idCn1kxLUnPBuPm5fZfyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416613; c=relaxed/simple;
	bh=nBfXPXeQ8yBcutvB9Y7w+kdOv48a76K/1MhBFFUVesQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD/d4jAlLRpiRv6FaJlVc6eWB+4lClMCJ4Y62jDyA3I/D31wyeP245OZ1XSH+oe2H/RWkeITVwh+MN+TTIktF9M8kXBX3W0jKJKkNiec3KANTCIiDjQAsRMdJirqjFdRWFJMK78dOq/uMROONvs/KTWMr9GPA8rdoJquDHb/2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=dNXQp4Ts; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4f022T4bCZzG9NvRM;
	Mon, 26 Jan 2026 16:36:49 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769416610; bh=nBfXPXeQ8yBcutvB9Y7w+kdOv48a76K/1MhBFFUVesQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNXQp4Ts0hNSf42NucCe0UWvV66bLKWUmepoUIxD6uyuINHaMVxvfMKXeEBnpfW6F
	 0TFQuXON2jZhx5SXxzVJ48xbM3iYUrtvrLProsl8IbFXpHRx8UA6+j/HXGL1CWzsb/
	 m9PWBHBgp3k4NwHf8bN5ndvcl/qvU9Gmv4Cz1TE0=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	dsterba@suse.com,
	jinbaohong <jinbaohong@synology.com>,
	robbieko <robbieko@synology.com>
Subject: [PATCH v3 2/2] btrfs: fix transaction commit blocking during trim of unallocated space
Date: Mon, 26 Jan 2026 08:36:39 +0000
Message-Id: <20260126083639.602258-3-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126083639.602258-1-jinbaohong@synology.com>
References: <20260126083639.602258-1-jinbaohong@synology.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21056-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:email,synology.com:dkim,synology.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE7718587B
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
 fs/btrfs/extent-tree.c | 164 +++++++++++++++++++++++++++++++++++------
 1 file changed, 140 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b299e369649b..57f6ed1665d1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6493,6 +6493,9 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
 	unpin_extent_range(fs_info, start, end, false);
 }
 
+/* Maximum length to trim in a single iteration to avoid holding mutex too long. */
+#define BTRFS_MAX_TRIM_LENGTH SZ_2G
+
 /*
  * It used to be that old block groups would be left around forever.
  * Iterating over them would be enough to trim unused space.  Since we
@@ -6513,10 +6516,12 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
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
 
@@ -6536,6 +6541,9 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 
 	while (1) {
 		struct btrfs_fs_info *fs_info = device->fs_info;
+		u64 cur_start;
+		u64 end;
+		u64 len;
 		u64 bytes;
 
 		ret = mutex_lock_interruptible(&fs_info->chunk_mutex);
@@ -6544,9 +6552,11 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 			break;
 		}
 
+		cur_start = start;
 		btrfs_find_first_clear_extent_bit(&device->alloc_state, start,
 						  &start, &end,
 						  CHUNK_TRIMMED | CHUNK_ALLOCATED);
+		start = max(start, cur_start);
 
 		/* Check if there are any CHUNK_* bits left */
 		if (start > device->total_bytes) {
@@ -6572,6 +6582,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		end = min(end, device->total_bytes - 1);
 
 		len = end - start + 1;
+		len = min(len, BTRFS_MAX_TRIM_LENGTH);
 
 		/* We didn't find any extents */
 		if (!len) {
@@ -6592,6 +6603,12 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 
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
@@ -6604,6 +6621,123 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 	return ret;
 }
 
+static int btrfs_trim_free_extents(struct btrfs_fs_info *fs_info, u64 *trimmed,
+				   u64 *dev_failed, int *dev_ret)
+{
+	int ret;
+	struct btrfs_device *dev;
+	struct btrfs_device *working_dev = NULL;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	u8 uuid[BTRFS_UUID_SIZE];
+	u64 start = BTRFS_DEVICE_RANGE_RESERVED;
+
+	*trimmed = 0;
+	*dev_failed = 0;
+	*dev_ret = 0;
+
+	/* Find the device with the smallest UUID to start. */
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
+
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
+		/* Find and trim the current device. */
+		list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+			if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+				continue;
+			if (dev == working_dev) {
+				ret = btrfs_trim_free_extents_throttle(working_dev,
+					&group_trimmed, start, &next_pos);
+				break;
+			}
+		}
+
+		/* Throttle: continue same device from new position. */
+		if (ret == -EAGAIN && next_pos > start) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			*trimmed += group_trimmed;
+			start = next_pos;
+			cond_resched();
+			continue;
+		}
+
+		/* User interrupted. */
+		if (ret == -ERESTARTSYS) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			*trimmed += group_trimmed;
+			*dev_ret = -ERESTARTSYS;
+			return -ERESTARTSYS;
+		}
+
+		/*
+		 * Device completed (ret == 0), failed, or EAGAIN with no progress.
+		 * Record error if any, then move to next device.
+		 */
+		if (ret == -EAGAIN) {
+			/* No progress - log and skip device. */
+			btrfs_warn(fs_info,
+				   "trim throttle: no progress, offset=%llu device %s, skipping",
+				   start, btrfs_dev_name(working_dev));
+			(*dev_failed)++;
+			*dev_ret = ret;
+		} else if (ret) {
+			/* Device failed with error. */
+			(*dev_failed)++;
+			*dev_ret = ret;
+		}
+
+		/*
+		 * Find next device: smallest UUID larger than current.
+		 * Devices added during trim with smaller UUID will be skipped.
+		 */
+		working_dev = NULL;
+		list_for_each_entry(dev, &fs_devices->devices, dev_list) {
+			if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+				continue;
+			/* Must larger than current uuid. */
+			if (memcmp(dev->uuid, uuid, BTRFS_UUID_SIZE) <= 0)
+				continue;
+			/* Find the smallest. */
+			if (!working_dev ||
+			    memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_SIZE) < 0)
+				working_dev = dev;
+		}
+		if (working_dev)
+			memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
+
+		mutex_unlock(&fs_devices->device_list_mutex);
+
+		*trimmed += group_trimmed;
+		start = BTRFS_DEVICE_RANGE_RESERVED;
+
+		/* No more devices. */
+		if (!working_dev)
+			break;
+
+		cond_resched();
+	}
+
+	return 0;
+}
+
 /*
  * Trim the whole filesystem by:
  * 1) trimming the free space in each block group
@@ -6615,9 +6749,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
  */
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 {
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_block_group *cache = NULL;
-	struct btrfs_device *device;
 	u64 group_trimmed;
 	u64 range_end = U64_MAX;
 	u64 start;
@@ -6648,7 +6780,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		}
 
 		start = max(range->start, cache->start);
-		end = min(range_end, btrfs_block_group_end(cache));
+		end = min(range_end, cache->start + cache->length);
 
 		if (end - start >= range->minlen) {
 			if (!btrfs_block_group_done(cache)) {
@@ -6679,25 +6811,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
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
-		if (ret == -ERESTARTSYS) {
-			dev_ret = -ERESTARTSYS;
-			break;
-		}
-		if (ret) {
-			dev_failed++;
-			dev_ret = ret;
-			continue;
-		}
-	}
-	mutex_unlock(&fs_devices->device_list_mutex);
+	btrfs_trim_free_extents(fs_info, &group_trimmed,
+				&dev_failed, &dev_ret);
+	trimmed += group_trimmed;
 
 	if (dev_failed)
 		btrfs_warn(fs_info,
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

