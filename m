Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09B479463
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbhLQSwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:52:30 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:52998 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240520AbhLQSw0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:52:26 -0500
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnP2601f5DQHji01WnSrN; Fri, 17 Dec 2021 18:47:26 +0000
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
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/6] btrfs: add allocation_hint mode
Date:   Fri, 17 Dec 2021 19:47:20 +0100
Message-Id: <c9f492a7ff1a0e4f0addc6cd451848404f0438db.1639766364.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639766364.git.kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766846; bh=l3HdplbtJ4rePCwDyojsbaAWdVGb8yutr0rSfbenvEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=6TXDuJmn6e9higF451pA4moBc6ZXWn0PvNi8oJrEpCzicDwu64k2YD391dBKRmpo3
         WNQm9ZGyyQ0q93CPAwQL1rzPaoY5wgU0tmCU8n2+SXffFmN/FqQtF/qBIxbDiTlXFg
         /SqX5q2zBstpwbmaiasqUbdW8SkMyUQUfsS7l7DY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

The chunk allocation policy is modified as follow.

Each disk may have one of the following tags:
- BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
- BTRFS_DEV_ALLOCATION_DATA_ONLY
- BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)

During a *mixed data/metadata* chunk allocation, BTRFS works as
usual.

During a *data* chunk allocation, the space are searched first in
BTRFS_DEV_ALLOCATION_DATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_DATA
tagged disks. If no space is found or the space found is not enough (eg.
in raid5, only two disks are available), then also the disks tagged
BTRFS_DEV_ALLOCATION_PREFERRED_METADATA are evaluated. If even in this
case this the space is not sufficient, -ENOSPC is raised.
A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
for a data BG allocation.

During a *metadata* chunk allocation, the space are searched first in
BTRFS_DEV_ALLOCATION_METADATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
tagged disks. If no space is found or the space found is not enough (eg.
in raid5, only two disks are available), then also the disks tagged
BTRFS_DEV_ALLOCATION_PREFERRED_DATA are considered. If even in this
case this the space is not sufficient, -ENOSPC is raised.
A disk tagged with BTRFS_DEV_ALLOCATION_DATA_ONLY is never considered
for a metadata BG allocation.

By default the disks are tagged as BTRFS_DEV_ALLOCATION_PREFERRED_DATA,
so the default behavior happens. If the user prefer to store the
metadata in the faster disks (e.g. the SSD), he can tag these with
BTRFS_DEV_ALLOCATION_PREFERRED_DATA: in this case the data BG go in the
BTRFS_DEV_ALLOCATION_PREFERRED_DATA disks and the metadata BG in the
others, until there is enough space. Only if one disks set is filled,
the other is occupied.

WARNING: if the user tags a disk with BTRFS_DEV_ALLOCATION_DATA_ONLY,
this means that this disk will never be used for allocating metadata
increasing the likelihood of exhausting the metadata space.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/volumes.c | 94 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  1 +
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 806b599c6a46..beee7d1ae79d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -184,6 +184,16 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
 	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
 }
 
+#define BTRFS_DEV_ALLOCATION_HINT_COUNT (1ULL << \
+		BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT)
+
+static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {
+	[BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY] = -1,
+	[BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA] = 0,
+	[BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA] = 1,
+	[BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY] = 2,
+};
+
 const char *btrfs_bg_type_to_raid_name(u64 flags)
 {
 	const int index = btrfs_bg_flags_to_raid_index(flags);
@@ -5037,13 +5047,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
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
@@ -5206,6 +5221,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int hint;
+	int i;
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -5258,16 +5275,91 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
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
+			 * if a data chunk must be allocated,
+			 * sort also by hint (metadata hint
+			 * higher priority)
+			 */
+			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
+		}
+
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
+	/*
+	 * no devices available
+	 */
+	if (!ndevs)
+		return 0;
+
 	/*
 	 * now sort the devices by hole size / available space
 	 */
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+	/*
+	 * select the minimum set of disks grouped by hint that
+	 * can host the chunk
+	 */
+	ndevs = 0;
+	while (ndevs < ctl->ndevs) {
+		hint = devices_info[ndevs++].alloc_hint;
+		while (ndevs < ctl->ndevs &&
+		       devices_info[ndevs].alloc_hint == hint)
+				ndevs++;
+		if (ndevs >= ctl->devs_min)
+			break;
+	}
+
+	BUG_ON(ndevs > ctl->ndevs);
+	ctl->ndevs = ndevs;
+
+	/*
+	 * the next layers require the devices_info ordered by
+	 * max_avail. If we are returing two (or more) different
+	 * group of alloc_hint, this is not always true. So sort
+	 * these gain.
+	 */
+
+	for (i = 0 ; i < ndevs ; i++)
+		devices_info[i].alloc_hint = 0;
+
+	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+	     btrfs_cmp_device_info, NULL);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5097c0c12a8e..61c0cba045e9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -406,6 +406,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int alloc_hint;
 };
 
 struct btrfs_raid_attr {
-- 
2.34.1

