Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518A649D376
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiAZUcY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:24 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59448 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230402AbiAZUcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:22 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYG2600e15VSme01YYLLh; Wed, 26 Jan 2022 20:32:20 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/7] btrfs: add allocation_hint mode
Date:   Wed, 26 Jan 2022 21:32:11 +0100
Message-Id: <a1ce7441b3ba231ee551bf65161442fde96932df.1643228177.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643228177.git.kreijack@inwind.it>
References: <cover.1643228177.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229140; bh=TgM9KKcCDftLXIXl9o3AKjUXPRT3pI4Dh/a7BG4nGwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ZH5zKLQj7gbcPYWgO82bGEGYa01XjnF4ZQuPOJqMHJNa21h8m+CgwBKdaXpF56l/I
         A329CRuglXc/fsE31riEw+wmW2IQloys5I7cxleo5LSv+Iz5KUyezD/29EygKIZg+k
         rfQEV0rRZhm96HIacncpYGPRwTa7IGjGPshZCM3k=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

The chunk allocation policy is modified as follow.

Each disk may have one of the following tags:
- BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
- BTRFS_DEV_ALLOCATION_DATA_ONLY
- BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)

During a *mixed data/metadata* chunk allocation, BTRFS works as
usual.

During a *data* chunk allocation, the space are searched first in
BTRFS_DEV_ALLOCATION_DATA_ONLY. If the space found is not enough (eg.
in raid5, only two disks are available), then the disks tagged
BTRFS_DEV_ALLOCATION_DATA_PREFERRED are considered. If the space is not
enough again, the disks tagged BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
are also considered. If even in this case the space is not
sufficient, -ENOSPC is raised.
A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
for a data BG allocation.

During a *metadata* chunk allocation, the same algorithm applies swapping
_DATA_ and _METADATA_.

By default the disks are tagged as BTRFS_DEV_ALLOCATION_DATA_PREFERRED,
so BTRFS behaves as usual.

If the user prefers to store the metadata in the faster disks (e.g. SSD),
he can tag these with BTRFS_DEV_ALLOCATION_METADATA_PREFERRED: in this
case the metadata BG go in the BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
disks and the data BG in the others ones. When a disks set is filled, the
other is considered.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/volumes.c | 113 +++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h |   1 +
 2 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c43a8a36ff5b..666b67f4e07b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -184,6 +184,27 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
 	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
 }
 
+#define BTRFS_DEV_ALLOCATION_HINT_COUNT (1ULL << \
+		BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT)
+
+/*
+ *	The order of BTRFS_DEV_ALLOCATION_HINT_* values are not
+ *	good, because BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED is 0
+ *	(for backward compatibility reason), and the other
+ *	values are greater (because the field is unsigned). So we
+ *	need a map that rearranges the order giving to _DATA_PREFERRED
+ *	an intermediate priority.
+ *	These values give to METADATA_ONLY the highest priority, and are
+ *	valid for metadata BG allocation. When a data
+ *	BG is allocated we negate these values to reverse the priority.
+ */
+static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {
+	[BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY] = -1,
+	[BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED] = 0,
+	[BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED] = 1,
+	[BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY] = 2,
+};
+
 const char *btrfs_bg_type_to_raid_name(u64 flags)
 {
 	const int index = btrfs_bg_flags_to_raid_index(flags);
@@ -5019,13 +5040,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * sort the devices in descending order by max_avail, total_avail
+ * sort the devices in descending order by alloc_hint,
+ * max_avail, total_avail
  */
 static int btrfs_cmp_device_info(const void *a, const void *b)
 {
 	const struct btrfs_device_info *di_a = a;
 	const struct btrfs_device_info *di_b = b;
 
+	if (di_a->alloc_hint > di_b->alloc_hint)
+		return -1;
+	if (di_a->alloc_hint < di_b->alloc_hint)
+		return 1;
 	if (di_a->max_avail > di_b->max_avail)
 		return -1;
 	if (di_a->max_avail < di_b->max_avail)
@@ -5188,6 +5214,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int hint;
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -5240,17 +5267,95 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+
+		if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
+		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) {
+			/*
+			 * if mixed bg set all the alloc_hint
+			 * fields to the same value, so the sorting
+			 * is not affected
+			 */
+			devices_info[ndevs].alloc_hint = 0;
+		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
+			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
+
+			/*
+			 * skip BTRFS_DEV_METADATA_ONLY disks
+			 */
+			if (hint == BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY)
+				continue;
+			/*
+			 * if a data chunk must be allocated,
+			 * sort also by hint (data disk
+			 * higher priority)
+			 */
+			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
+		} else { /* BTRFS_BLOCK_GROUP_METADATA */
+			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
+
+			/*
+			 * skip BTRFS_DEV_DATA_ONLY disks
+			 */
+			if (hint == BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY)
+				continue;
+			/*
+			 * if a metadata chunk must be allocated,
+			 * sort also by hint (metadata hint
+			 * higher priority)
+			 */
+			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
+		}
+
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
+	return 0;
+}
+
+static void sort_and_reduce_device_info(struct alloc_chunk_ctl *ctl,
+					struct btrfs_device_info *devices_info)
+{
+	int ndevs, hint, i;
+
+	ndevs = ctl->ndevs;
 	/*
-	 * now sort the devices by hole size / available space
+	 * now sort the devices by hint / hole size / available space
 	 */
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
-	return 0;
+	/*
+	 * select the minimum set of disks grouped by hint that
+	 * can host the chunk
+	 */
+	ndevs = 0;
+	while (ndevs < ctl->ndevs) {
+		hint = devices_info[ndevs++].alloc_hint;
+		while (ndevs < ctl->ndevs) {
+			if (devices_info[ndevs].alloc_hint != hint)
+				break;
+			ndevs++;
+		}
+		if (ndevs >= ctl->devs_min)
+			break;
+	}
+
+	ctl->ndevs = ndevs;
+
+	/*
+	 * the next layers require the devices_info ordered by
+	 * max_avail. If we are returning two (or more) different
+	 * group of alloc_hint, this is not always true. So sort
+	 * these again.
+	 */
+
+	for (i = 0 ; i < ndevs ; i++)
+		devices_info[i].alloc_hint = 0;
+
+	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+	     btrfs_cmp_device_info, NULL);
+
 }
 
 static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
@@ -5502,6 +5607,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
+	sort_and_reduce_device_info(&ctl, devices_info);
+
 	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
 	if (ret < 0) {
 		block_group = ERR_PTR(ret);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 93ac27d8097c..b066f9af216a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -404,6 +404,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int alloc_hint;
 };
 
 struct btrfs_raid_attr {
-- 
2.34.1

