Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8310461D
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKTVvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43643 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKTVvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so1231421qtn.10
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/OaDQPCEqclPTaWscJCXdX9jz+mYCkmcEJMQCoPZJj0=;
        b=uFHm1HvLHQMMEn8HAytWrv3vy3IhumEJuiZ9PDj5Ho8hBGRFUMC/R8aghkxhtXFRll
         bnJIgze6v/5mIWH/cy6T00MvKRmWuLKBCrDF8F+Cl0nHgOTkf5U988eSwG/orW0tD8ZU
         1EG2DGIYKN6a7VZysGBCHc30FjkBzMeHarA13iq3TLjUuMViHqn6FtwN1A7keCUEnWOP
         q7eLJGFAZm76XgJ/PS6RW6kug/imtyhMmiAHDhQT+Sv6qx431agIcDXYkzq4e9wUuL9e
         4BU/FSkxpNNezPg+egHsbTWJE/+tgBoe9k3E3XboDjgfdvolq94l7XZhwxkY8nD+qoMm
         seGA==
X-Gm-Message-State: APjAAAV+yKk3lgppJVV3FDCWCceQoNGb8nSXNoMNGX2hY62npBfPVam3
        +z5tgpiTwn/Jks7qvGOSLMc=
X-Google-Smtp-Source: APXvYqy8bqYzvs8InYCAj3FcPyM+l0aLhB2HUTquDMkWRKzdJyib0+cw4d+z/WtGcf0UxD6LQIhqQQ==
X-Received: by 2002:ac8:7103:: with SMTP id z3mr5021828qto.387.1574286700832;
        Wed, 20 Nov 2019 13:51:40 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:40 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 11/22] btrfs: track discardable extents for async discard
Date:   Wed, 20 Nov 2019 16:51:10 -0500
Message-Id: <e523a42e1e17272f97b4726a1ff1cbb437257859.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The number of discardable extents will serve as the rate limiting metric
for how often we should discard. This keeps track of discardable extents
in the free space caches by maintaining deltas and propagating them to
the global count.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  10 ++++
 fs/btrfs/discard.c          |  32 +++++++++++
 fs/btrfs/discard.h          |   4 ++
 fs/btrfs/free-space-cache.c | 106 +++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.h |   2 +
 fs/btrfs/sysfs.c            |  15 +++++
 6 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6a547317d26f..c37533a8a313 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -101,6 +101,15 @@ struct btrfs_ref;
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
+/*
+ * Deltas are an effective way to populate global statistics.  Give macro names
+ * to make it clear what we're doing.  An example is discard_extents in
+ * btrfs_free_space_ctl.
+ */
+#define BTRFS_STAT_NR_ENTRIES	2
+#define BTRFS_STAT_CURR		0
+#define BTRFS_STAT_PREV		1
+
 
 /*
  * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
@@ -458,6 +467,7 @@ struct btrfs_discard_ctl {
 	spinlock_t lock;
 	struct btrfs_block_group *block_group;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+	atomic_t discardable_extents;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 8b676103919a..a05180af74e2 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -341,6 +341,36 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
 		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
 }
 
+/**
+ * btrfs_discard_update_discardable - propagate discard counters
+ * @block_group: block_group of interest
+ * @ctl: free_space_ctl of @block_group
+ *
+ * This propagates deltas of counters up to the discard_ctl.  It maintains a
+ * current counter and a previous counter passing the delta up to the global
+ * stat.  Then the current counter value becomes the previous counter value.
+ */
+void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
+				      struct btrfs_free_space_ctl *ctl)
+{
+	struct btrfs_discard_ctl *discard_ctl;
+	s32 extents_delta;
+
+	if (!block_group ||
+	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+		return;
+
+	discard_ctl = &block_group->fs_info->discard_ctl;
+
+	extents_delta = (ctl->discardable_extents[BTRFS_STAT_CURR] -
+			 ctl->discardable_extents[BTRFS_STAT_PREV]);
+	if (extents_delta) {
+		atomic_add(extents_delta, &discard_ctl->discardable_extents);
+		ctl->discardable_extents[BTRFS_STAT_PREV] =
+			ctl->discardable_extents[BTRFS_STAT_CURR];
+	}
+}
+
 /**
  * btrfs_discard_punt_unused_bgs_list - punt unused_bgs list to discard lists
  * @fs_info: fs_info of interest
@@ -428,6 +458,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 
 	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
 		INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
+
+	atomic_set(&discard_ctl->discardable_extents, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index b61ea684b48d..75f00a84d540 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -22,6 +22,10 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 				 bool override);
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
+/* Update operations. */
+void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
+				      struct btrfs_free_space_ctl *ctl);
+
 /* Setup/Cleanup operations. */
 void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
 void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dfb458b33469..b012be2b2213 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -32,6 +32,9 @@ struct btrfs_trim_range {
 	struct list_head list;
 };
 
+static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
+				struct btrfs_free_space *bitmap_info);
+
 static int link_free_space(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info);
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
@@ -816,12 +819,17 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 		ret = io_ctl_read_bitmap(&io_ctl, e);
 		if (ret)
 			goto free_cache;
+		e->bitmap_extents = count_bitmap_extents(ctl, e);
+		if (!btrfs_free_space_trimmed(e))
+			ctl->discardable_extents[BTRFS_STAT_CURR] +=
+				e->bitmap_extents;
 	}
 
 	io_ctl_drop_pages(&io_ctl);
 	merge_space_tree(ctl);
 	ret = 1;
 out:
+	btrfs_discard_update_discardable(ctl->private, ctl);
 	io_ctl_free(&io_ctl);
 	return ret;
 free_cache:
@@ -1635,6 +1643,9 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 {
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
 	ctl->free_extents--;
+
+	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+		ctl->discardable_extents[BTRFS_STAT_CURR]--;
 }
 
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
@@ -1655,6 +1666,9 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
+	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+		ctl->discardable_extents[BTRFS_STAT_CURR]++;
+
 	ctl->free_space += info->bytes;
 	ctl->free_extents++;
 	return ret;
@@ -1711,17 +1725,29 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 				       struct btrfs_free_space *info,
 				       u64 offset, u64 bytes)
 {
-	unsigned long start, count;
+	unsigned long start, count, end;
+	int extent_delta = -1;
 
 	start = offset_to_bit(info->offset, ctl->unit, offset);
 	count = bytes_to_bits(bytes, ctl->unit);
-	ASSERT(start + count <= BITS_PER_BITMAP);
+	end = start + count;
+	ASSERT(end <= BITS_PER_BITMAP);
 
 	bitmap_clear(info->bitmap, start, count);
 
 	info->bytes -= bytes;
 	if (info->max_extent_size > ctl->unit)
 		info->max_extent_size = 0;
+
+	if (start && test_bit(start - 1, info->bitmap))
+		extent_delta++;
+
+	if (end < BITS_PER_BITMAP && test_bit(end, info->bitmap))
+		extent_delta++;
+
+	info->bitmap_extents += extent_delta;
+	if (!btrfs_free_space_trimmed(info))
+		ctl->discardable_extents[BTRFS_STAT_CURR] += extent_delta;
 }
 
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
@@ -1736,16 +1762,28 @@ static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
 			    struct btrfs_free_space *info, u64 offset,
 			    u64 bytes)
 {
-	unsigned long start, count;
+	unsigned long start, count, end;
+	int extent_delta = 1;
 
 	start = offset_to_bit(info->offset, ctl->unit, offset);
 	count = bytes_to_bits(bytes, ctl->unit);
-	ASSERT(start + count <= BITS_PER_BITMAP);
+	end = start + count;
+	ASSERT(end <= BITS_PER_BITMAP);
 
 	bitmap_set(info->bitmap, start, count);
 
 	info->bytes += bytes;
 	ctl->free_space += bytes;
+
+	if (start && test_bit(start - 1, info->bitmap))
+		extent_delta--;
+
+	if (end < BITS_PER_BITMAP && test_bit(end, info->bitmap))
+		extent_delta--;
+
+	info->bitmap_extents += extent_delta;
+	if (!btrfs_free_space_trimmed(info))
+		ctl->discardable_extents[BTRFS_STAT_CURR] += extent_delta;
 }
 
 /*
@@ -1881,11 +1919,35 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 	return NULL;
 }
 
+static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
+				struct btrfs_free_space *bitmap_info)
+{
+	struct btrfs_block_group *block_group = ctl->private;
+	u64 bytes = bitmap_info->bytes;
+	unsigned int rs, re;
+	int count = 0;
+
+	if (!block_group || !bytes)
+		return count;
+
+	bitmap_for_each_set_region(bitmap_info->bitmap, rs, re, 0,
+				   BITS_PER_BITMAP) {
+		bytes -= (rs - re) * ctl->unit;
+		count++;
+
+		if (!bytes)
+			break;
+	}
+
+	return count;
+}
+
 static void add_new_bitmap(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info, u64 offset)
 {
 	info->offset = offset_to_bitmap(ctl, offset);
 	info->bytes = 0;
+	info->bitmap_extents = 0;
 	INIT_LIST_HEAD(&info->list);
 	link_free_space(ctl, info);
 	ctl->total_bitmaps++;
@@ -1991,8 +2053,12 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 	 * This is a tradeoff to make bitmap trim state minimal.  We mark the
 	 * whole bitmap untrimmed if at any point we add untrimmed regions.
 	 */
-	if (trim_state == BTRFS_TRIM_STATE_UNTRIMMED)
+	if (trim_state == BTRFS_TRIM_STATE_UNTRIMMED) {
+		if (btrfs_free_space_trimmed(info))
+			ctl->discardable_extents[BTRFS_STAT_CURR] +=
+				info->bitmap_extents;
 		info->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+	}
 
 	end = info->offset + (u64)(BITS_PER_BITMAP * ctl->unit);
 
@@ -2428,6 +2494,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	if (ret)
 		kmem_cache_free(btrfs_free_space_cachep, info);
 out:
+	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
 
 	if (ret) {
@@ -2537,6 +2604,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 		goto again;
 	}
 out_lock:
+	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
 out:
 	return ret;
@@ -2622,8 +2690,16 @@ __btrfs_return_cluster_to_free_space(
 
 		bitmap = (entry->bitmap != NULL);
 		if (!bitmap) {
+			/* merging treats extents as if they were new */
+			if (!btrfs_free_space_trimmed(entry))
+				ctl->discardable_extents[BTRFS_STAT_CURR]--;
+
 			try_merge_free_space(ctl, entry, false);
 			steal_from_bitmap(ctl, entry, false);
+
+			/* as we insert directly, update these statistics */
+			if (!btrfs_free_space_trimmed(entry))
+				ctl->discardable_extents[BTRFS_STAT_CURR]++;
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
@@ -2680,6 +2756,7 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 		cond_resched_lock(&ctl->tree_lock);
 	}
 	__btrfs_remove_free_space_cache_locked(ctl);
+	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
 
 }
@@ -2754,6 +2831,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			link_free_space(ctl, entry);
 	}
 out:
+	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
 
 	if (align_gap_len)
@@ -2919,6 +2997,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 					entry->bitmap);
 			ctl->total_bitmaps--;
 			ctl->op->recalc_thresholds(ctl);
+		} else if (!btrfs_free_space_trimmed(entry)) {
+			ctl->discardable_extents[BTRFS_STAT_CURR]--;
 		}
 		kmem_cache_free(btrfs_free_space_cachep, entry);
 	}
@@ -3414,16 +3494,24 @@ static void reset_trimming_bitmap(struct btrfs_free_space_ctl *ctl, u64 offset)
 	spin_lock(&ctl->tree_lock);
 
 	entry = tree_search_offset(ctl, offset, 1, 0);
-	if (entry)
+	if (entry) {
+		if (btrfs_free_space_trimmed(entry))
+			ctl->discardable_extents[BTRFS_STAT_CURR] +=
+				entry->bitmap_extents;
 		entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+	}
 
 	spin_unlock(&ctl->tree_lock);
 }
 
-static void end_trimming_bitmap(struct btrfs_free_space *entry)
+static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
+				struct btrfs_free_space *entry)
 {
-	if (btrfs_free_space_trimming_bitmap(entry))
+	if (btrfs_free_space_trimming_bitmap(entry)) {
 		entry->trim_state = BTRFS_TRIM_STATE_TRIMMED;
+		ctl->discardable_extents[BTRFS_STAT_CURR] -=
+			entry->bitmap_extents;
+	}
 }
 
 /*
@@ -3481,7 +3569,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			 * if BTRFS_TRIM_STATE_TRIMMED is set on a bitmap.
 			 */
 			if (ret2 && !minlen)
-				end_trimming_bitmap(entry);
+				end_trimming_bitmap(ctl, entry);
 			else
 				entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 			spin_unlock(&ctl->tree_lock);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 67b59ffd13e4..56235391a04a 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -28,6 +28,7 @@ struct btrfs_free_space {
 	unsigned long *bitmap;
 	struct list_head list;
 	enum btrfs_trim_state trim_state;
+	s32 bitmap_extents;
 };
 
 static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
@@ -50,6 +51,7 @@ struct btrfs_free_space_ctl {
 	int total_bitmaps;
 	int unit;
 	u64 start;
+	s32 discardable_extents[BTRFS_STAT_NR_ENTRIES];
 	const struct btrfs_free_space_op *op;
 	void *private;
 	struct mutex cache_writeout_mutex;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e877e4b3c631..220d77c38363 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -12,6 +12,7 @@
 #include <crypto/hash.h>
 
 #include "ctree.h"
+#include "discard.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "sysfs.h"
@@ -341,7 +342,21 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
 /*
  * Discard statistics and tunables.
  */
+#define discard_to_fs_info(_kobj)	to_fs_info((_kobj)->parent->parent)
+
+static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			atomic_read(&fs_info->discard_ctl.discardable_extents));
+}
+BTRFS_ATTR(discard, discardable_extents, btrfs_discardable_extents_show);
+
 static const struct attribute *discard_debug_attrs[] = {
+	BTRFS_ATTR_PTR(discard, discardable_extents),
 	NULL,
 };
 
-- 
2.17.1

