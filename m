Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E13BCED4A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJGUSE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43718 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfJGUSD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so13898476qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FEfKhK13RzvZMEwZXKKlhPFCSdu8GvaM4WgRr2ZLFRo=;
        b=WC2sTIfw/Kxjj6VtKrLefmT9ZrwHPwWbmZncZROpJkklQQ+FkX47TR6PtcxygmZtBI
         5x6uTkDZeS69pdT7XVY12ysl+sgfhzMzo2IpD27bLSSXQr8obmUpzffKihevBTsj3JQQ
         ooZXPFFhtSjLvKHOANo0q8OFhZohzK+g8S4jmyicwST3KWVggKE8N+viQ6BSrIKGF7BZ
         TmvK5F23TkhnIxVMHdmSrUiSriya27X37TwibIs8gBkJR1LFCq7oHOlfQniJ+jkPBS4e
         QB5xQG4TXURFHGqBm3CEPVokSGD7pmOQQw/3A1jTORoQvs3h4dJ1ee2KEGoNp5tzFySx
         5gsA==
X-Gm-Message-State: APjAAAXdY+k48FqvD2lpp/BAOBJbYPhIq/biLUKaxj0G2Bx+dAa8gIT7
        GRzQX9Ul7c8nv7Emyt4ur2Q=
X-Google-Smtp-Source: APXvYqyUWGEmo62N0950dGheEqkGo2AId5YeHWrIKEIjeZpU4QKjcY/zEc9NPkgLcqLOOYthxiRQ2w==
X-Received: by 2002:a37:d52:: with SMTP id 79mr25470194qkn.300.1570479482645;
        Mon, 07 Oct 2019 13:18:02 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:01 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 08/19] btrfs: track discardable extents for asnyc discard
Date:   Mon,  7 Oct 2019 16:17:39 -0400
Message-Id: <31c4f29228c76df72cc92112e397db648e9b9ab9.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The number of discardable extents will serve as the rate limiting metric
for how often we should discard. This keeps track of discardable extents
in the free space caches by maintaining deltas and propagating them to
the global count.

This also setups up a discard directory in btrfs sysfs and exports the
total discard_extents count.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  2 +
 fs/btrfs/discard.c          |  2 +
 fs/btrfs/discard.h          | 19 ++++++++
 fs/btrfs/free-space-cache.c | 93 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.h |  2 +
 fs/btrfs/sysfs.c            | 33 +++++++++++++
 6 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c328d2e85e4d..43e515939b9c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -447,6 +447,7 @@ struct btrfs_discard_ctl {
 	spinlock_t lock;
 	struct btrfs_block_group_cache *cache;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+	atomic_t discard_extents;
 };
 
 /* delayed seq elem */
@@ -831,6 +832,7 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *scrub_wr_completion_workers;
 	struct btrfs_workqueue *scrub_parity_workers;
 
+	struct kobject *discard_kobj;
 	struct btrfs_discard_ctl discard_ctl;
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 26a1e44b4bfa..0544eb6717d4 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -298,6 +298,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 
 	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
 		 INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
+
+	atomic_set(&discard_ctl->discard_extents, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 22cfa7e401bb..85939d62521e 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -71,4 +71,23 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 		btrfs_discard_schedule_work(discard_ctl, false);
 }
 
+static inline
+void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
+				      struct btrfs_free_space_ctl *ctl)
+{
+	struct btrfs_discard_ctl *discard_ctl;
+	s32 extents_delta;
+
+	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
+		return;
+
+	discard_ctl = &cache->fs_info->discard_ctl;
+
+	extents_delta = ctl->discard_extents[0] - ctl->discard_extents[1];
+	if (extents_delta) {
+		atomic_add(extents_delta, &discard_ctl->discard_extents);
+		ctl->discard_extents[1] = ctl->discard_extents[0];
+	}
+}
+
 #endif
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 97b3074e83c0..6c2bebfd206f 100644
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
@@ -809,12 +812,15 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 		ret = io_ctl_read_bitmap(&io_ctl, e);
 		if (ret)
 			goto free_cache;
+		e->bitmap_extents = count_bitmap_extents(ctl, e);
+		ctl->discard_extents[0] += e->bitmap_extents;
 	}
 
 	io_ctl_drop_pages(&io_ctl);
 	merge_space_tree(ctl);
 	ret = 1;
 out:
+	btrfs_discard_update_discardable(ctl->private, ctl);
 	io_ctl_free(&io_ctl);
 	return ret;
 free_cache:
@@ -1629,6 +1635,9 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 {
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
 	ctl->free_extents--;
+
+	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+		ctl->discard_extents[0]--;
 }
 
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
@@ -1649,6 +1658,9 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
+	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+		ctl->discard_extents[0]++;
+
 	ctl->free_space += info->bytes;
 	ctl->free_extents++;
 	return ret;
@@ -1705,17 +1717,29 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
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
+		ctl->discard_extents[0] += extent_delta;
 }
 
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
@@ -1730,16 +1754,28 @@ static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
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
+		ctl->discard_extents[0] += extent_delta;
 }
 
 /*
@@ -1875,11 +1911,35 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 	return NULL;
 }
 
+static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
+				struct btrfs_free_space *bitmap_info)
+{
+	struct btrfs_block_group_cache *cache = ctl->private;
+	u64 bytes = bitmap_info->bytes;
+	unsigned int rs, re;
+	int count = 0;
+
+	if (!cache || !bytes)
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
@@ -1981,8 +2041,11 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 	u64 bytes_to_set = 0;
 	u64 end;
 
-	if (!(flags & BTRFS_FSC_TRIMMED))
+	if (!(flags & BTRFS_FSC_TRIMMED)) {
+		if (btrfs_free_space_trimmed(info))
+			ctl->discard_extents[0] += info->bitmap_extents;
 		info->flags &= ~(BTRFS_FSC_TRIMMED | BTRFS_FSC_TRIMMING_BITMAP);
+	}
 
 	end = info->offset + (u64)(BITS_PER_BITMAP * ctl->unit);
 
@@ -2397,6 +2460,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	if (ret)
 		kmem_cache_free(btrfs_free_space_cachep, info);
 out:
+	btrfs_discard_update_discardable(cache, ctl);
 	spin_unlock(&ctl->tree_lock);
 
 	if (ret) {
@@ -2506,6 +2570,7 @@ int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 		goto again;
 	}
 out_lock:
+	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
 out:
 	return ret;
@@ -2591,8 +2656,16 @@ __btrfs_return_cluster_to_free_space(
 
 		bitmap = (entry->bitmap != NULL);
 		if (!bitmap) {
+			/* merging treats extents as if they were new */
+			if (!btrfs_free_space_trimmed(entry))
+				ctl->discard_extents[0]--;
+
 			try_merge_free_space(ctl, entry, false);
 			steal_from_bitmap(ctl, entry, false);
+
+			/* as we insert directly, update these statistics */
+			if (!btrfs_free_space_trimmed(entry))
+				ctl->discard_extents[0]++;
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
@@ -2649,6 +2722,7 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group_cache *block_group)
 		cond_resched_lock(&ctl->tree_lock);
 	}
 	__btrfs_remove_free_space_cache_locked(ctl);
+	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
 
 }
@@ -2717,6 +2791,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 			link_free_space(ctl, entry);
 	}
 out:
+	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
 
 	if (align_gap_len)
@@ -2882,6 +2957,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 					entry->bitmap);
 			ctl->total_bitmaps--;
 			ctl->op->recalc_thresholds(ctl);
+		} else if (!btrfs_free_space_trimmed(entry)) {
+			ctl->discard_extents[0]--;
 		}
 		kmem_cache_free(btrfs_free_space_cachep, entry);
 	}
@@ -3383,11 +3460,13 @@ static void reset_trimming_bitmap(struct btrfs_free_space_ctl *ctl, u64 offset)
 	spin_unlock(&ctl->tree_lock);
 }
 
-static void end_trimming_bitmap(struct btrfs_free_space *entry)
+static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
+				struct btrfs_free_space *entry)
 {
 	if (btrfs_free_space_trimming_bitmap(entry)) {
 		entry->flags |= BTRFS_FSC_TRIMMED;
 		entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
+		ctl->discard_extents[0] -= entry->bitmap_extents;
 	}
 }
 
@@ -3443,7 +3522,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			 * if BTRFS_FSC_TRIMMED is set on a bitmap.
 			 */
 			if (ret2 && !minlen)
-				end_trimming_bitmap(entry);
+				end_trimming_bitmap(ctl, entry);
 			else
 				entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
 			spin_unlock(&ctl->tree_lock);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 450ea01ea0c7..855f42dc15cd 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -16,6 +16,7 @@ struct btrfs_free_space {
 	u64 max_extent_size;
 	unsigned long *bitmap;
 	struct list_head list;
+	s32 bitmap_extents;
 	u32 flags;
 };
 
@@ -39,6 +40,7 @@ struct btrfs_free_space_ctl {
 	int total_bitmaps;
 	int unit;
 	u64 start;
+	s32 discard_extents[2];
 	const struct btrfs_free_space_op *op;
 	void *private;
 	struct mutex cache_writeout_mutex;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..14c6910128f1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/bug.h>
 
 #include "ctree.h"
+#include "discard.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "sysfs.h"
@@ -470,6 +471,22 @@ static const struct attribute *allocation_attrs[] = {
 	NULL,
 };
 
+static ssize_t btrfs_discard_extents_show(struct kobject *kobj,
+					struct kobj_attribute *a,
+					char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			atomic_read(&fs_info->discard_ctl.discard_extents));
+}
+BTRFS_ATTR(discard, discard_extents, btrfs_discard_extents_show);
+
+static const struct attribute *discard_attrs[] = {
+	BTRFS_ATTR_PTR(discard, discard_extents),
+	NULL,
+};
+
 static ssize_t btrfs_label_show(struct kobject *kobj,
 				struct kobj_attribute *a, char *buf)
 {
@@ -727,6 +744,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 {
 	btrfs_reset_fs_info_ptr(fs_info);
 
+	if (fs_info->discard_kobj) {
+		sysfs_remove_files(fs_info->discard_kobj, discard_attrs);
+		kobject_del(fs_info->discard_kobj);
+		kobject_put(fs_info->discard_kobj);
+	}
+
 	if (fs_info->space_info_kobj) {
 		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
 		kobject_del(fs_info->space_info_kobj);
@@ -1093,6 +1116,16 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	if (error)
 		goto failure;
 
+	fs_info->discard_kobj = kobject_create_and_add("discard", fsid_kobj);
+	if (!fs_info->discard_kobj) {
+		error = -ENOMEM;
+		goto failure;
+	}
+
+	error = sysfs_create_files(fs_info->discard_kobj, discard_attrs);
+	if (error)
+		goto failure;
+
 	return 0;
 failure:
 	btrfs_sysfs_remove_mounted(fs_info);
-- 
2.17.1

