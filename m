Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9653DCED47
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfJGUSB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40899 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfJGUSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so13903269qkb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZJSpfXKr2hMfNtJ1fPN4QJ6gpi4z8sS8bTyjlFkZCP4=;
        b=Bnody1XzpFsobeicZgUsgkELWwrch1xLMAySmxECwM8kyLfxYiKqZU9mo+esCtCCLx
         WsZ8B8Ern4BiXzpDNmMoBLPOJrXnsM00tJEY63AaZx7sElNqYPZA0bQrIr2SA3mJvo5M
         HNujiiUjsmE/RB5we533RpdkASquqkRbuASnXYwYe7Wp22J0HGbZOM5sB126Y4TRhVdH
         22Qb3S/SNUrJcTRwNz4kmeVoMVmaY3RaJUNFAiWIHVDhFqzXNMWeP3vPc5BvXzYJqdjH
         opzVY4Nob9UtjLfPkcVXObcO4LwghN+tZCdqBdn0iR7bGrxVAF5R9uULpFcujS7yNWDG
         7AkA==
X-Gm-Message-State: APjAAAVfPMADzWJqhK5EatwiUnqnA2WKd8gm6ceVhg1XHJXHBfkzW9Y3
        i3vg6otn84q97Bb/6LDVyg4=
X-Google-Smtp-Source: APXvYqxcNrnQcucxrnXSASkBzJqHE5LqkK4HFsB+hKbFOg+D6RoYfvdHSUo6T+g1x+o4cY/BQWTTpw==
X-Received: by 2002:a05:620a:549:: with SMTP id o9mr25836933qko.223.1570479479127;
        Mon, 07 Oct 2019 13:17:59 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:17:58 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 05/19] btrfs: add the beginning of async discard, discard workqueue
Date:   Mon,  7 Oct 2019 16:17:36 -0400
Message-Id: <b2f59782f8a7b02fee6c3a2994154b01134b09dc.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When discard is enabled, everytime a pinned extent is released back to
the block_group's free space cache, a discard is issued for the extent.
This is an overeager approach when it comes to discarding and helping
the SSD maintain enough free space to prevent severe garbage collection
situations.

This adds the beginning of async discard. Instead of issuing a discard
prior to returning it to the free space, it is just marked as untrimmed.
The block_group is then added to a LRU which then feeds into a workqueue
to issue discards at a much slower rate. Full discarding of unused block
groups is still done and will be address in a future patch in this
series.

For now, we don't persist the discard state of extents and bitmaps.
Therefore, our failure recovery mode will be to consider extents
untrimmed. This lets us handle failure and unmounting as one in the
same.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/block-group.c      |   4 +
 fs/btrfs/block-group.h      |  10 ++
 fs/btrfs/ctree.h            |  17 +++
 fs/btrfs/discard.c          | 200 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          |  49 +++++++++
 fs/btrfs/disk-io.c          |  15 ++-
 fs/btrfs/extent-tree.c      |   4 +
 fs/btrfs/free-space-cache.c |  29 +++++-
 fs/btrfs/super.c            |  35 ++++++-
 10 files changed, 356 insertions(+), 9 deletions(-)
 create mode 100644 fs/btrfs/discard.c
 create mode 100644 fs/btrfs/discard.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 82200dbca5ac..9a0ff3384381 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o delalloc-space.o block-group.o
+	   block-rsv.o delalloc-space.o block-group.o discard.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index afe86028246a..8bbbe7488328 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -14,6 +14,7 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
+#include "discard.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -1273,6 +1274,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->unused_bgs_lock);
 
+		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+
 		mutex_lock(&fs_info->delete_unused_bgs_mutex);
 
 		/* Don't want to race with allocators so take the groups_sem */
@@ -1622,6 +1625,7 @@ static struct btrfs_block_group_cache *btrfs_create_block_group_cache(
 	INIT_LIST_HEAD(&cache->cluster_list);
 	INIT_LIST_HEAD(&cache->bg_list);
 	INIT_LIST_HEAD(&cache->ro_list);
+	INIT_LIST_HEAD(&cache->discard_list);
 	INIT_LIST_HEAD(&cache->dirty_list);
 	INIT_LIST_HEAD(&cache->io_list);
 	btrfs_init_free_space_ctl(cache);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c391800388dd..0f9a1c91753f 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -115,7 +115,11 @@ struct btrfs_block_group_cache {
 	/* For read-only block groups */
 	struct list_head ro_list;
 
+	/* For discard operations */
 	atomic_t trimming;
+	struct list_head discard_list;
+	int discard_index;
+	u64 discard_delay;
 
 	/* For dirty block groups */
 	struct list_head dirty_list;
@@ -157,6 +161,12 @@ struct btrfs_block_group_cache {
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
 };
 
+static inline
+u64 btrfs_block_group_end(struct btrfs_block_group_cache *cache)
+{
+	return (cache->key.objectid + cache->key.offset);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline int btrfs_should_fragment_free_space(
 		struct btrfs_block_group_cache *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1877586576aa..419445868909 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -438,6 +438,17 @@ struct btrfs_full_stripe_locks_tree {
 	struct mutex lock;
 };
 
+/* discard control */
+#define BTRFS_NR_DISCARD_LISTS		1
+
+struct btrfs_discard_ctl {
+	struct workqueue_struct *discard_workers;
+	struct delayed_work work;
+	spinlock_t lock;
+	struct btrfs_block_group_cache *cache;
+	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+};
+
 /* delayed seq elem */
 struct seq_list {
 	struct list_head list;
@@ -524,6 +535,9 @@ enum {
 	 * so we don't need to offload checksums to workqueues.
 	 */
 	BTRFS_FS_CSUM_IMPL_FAST,
+
+	/* Indicate that the discard workqueue can service discards. */
+	BTRFS_FS_DISCARD_RUNNING,
 };
 
 struct btrfs_fs_info {
@@ -817,6 +831,8 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *scrub_wr_completion_workers;
 	struct btrfs_workqueue *scrub_parity_workers;
 
+	struct btrfs_discard_ctl discard_ctl;
+
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	u32 check_integrity_print_mask;
 #endif
@@ -1190,6 +1206,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
+#define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
new file mode 100644
index 000000000000..6df124639e55
--- /dev/null
+++ b/fs/btrfs/discard.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#include <linux/jiffies.h>
+#include <linux/list.h>
+#include <linux/sizes.h>
+#include <linux/ktime.h>
+#include <linux/workqueue.h>
+#include "ctree.h"
+#include "block-group.h"
+#include "discard.h"
+#include "free-space-cache.h"
+
+#define BTRFS_DISCARD_DELAY		(300ULL * NSEC_PER_SEC)
+
+static struct list_head *
+btrfs_get_discard_list(struct btrfs_discard_ctl *discard_ctl,
+		       struct btrfs_block_group_cache *cache)
+{
+	return &discard_ctl->discard_list[cache->discard_index];
+}
+
+void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group_cache *cache)
+{
+	u64 now = ktime_get_ns();
+
+	spin_lock(&discard_ctl->lock);
+
+	if (list_empty(&cache->discard_list))
+		cache->discard_delay = now + BTRFS_DISCARD_DELAY;
+
+	list_move_tail(&cache->discard_list,
+		       btrfs_get_discard_list(discard_ctl, cache));
+
+	spin_unlock(&discard_ctl->lock);
+}
+
+static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
+				     struct btrfs_block_group_cache *cache)
+{
+	bool running = false;
+
+	spin_lock(&discard_ctl->lock);
+
+	if (cache == discard_ctl->cache) {
+		running = true;
+		discard_ctl->cache = NULL;
+	}
+
+	cache->discard_delay = 0;
+	list_del_init(&cache->discard_list);
+
+	spin_unlock(&discard_ctl->lock);
+
+	return running;
+}
+
+static struct btrfs_block_group_cache *
+find_next_cache(struct btrfs_discard_ctl *discard_ctl, u64 now)
+{
+	struct btrfs_block_group_cache *ret_cache = NULL, *cache;
+	int i;
+
+	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++) {
+		struct list_head *discard_list = &discard_ctl->discard_list[i];
+
+		if (!list_empty(discard_list)) {
+			cache = list_first_entry(discard_list,
+						 struct btrfs_block_group_cache,
+						 discard_list);
+
+			if (!ret_cache)
+				ret_cache = cache;
+
+			if (ret_cache->discard_delay < now)
+				break;
+
+			if (ret_cache->discard_delay > cache->discard_delay)
+				ret_cache = cache;
+		}
+	}
+
+	return ret_cache;
+}
+
+static struct btrfs_block_group_cache *
+peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
+{
+	struct btrfs_block_group_cache *cache;
+	u64 now = ktime_get_ns();
+
+	spin_lock(&discard_ctl->lock);
+
+	cache = find_next_cache(discard_ctl, now);
+
+	if (cache && now < cache->discard_delay)
+		cache = NULL;
+
+	discard_ctl->cache = cache;
+
+	spin_unlock(&discard_ctl->lock);
+
+	return cache;
+}
+
+void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group_cache *cache)
+{
+	if (remove_from_discard_list(discard_ctl, cache)) {
+		cancel_delayed_work_sync(&discard_ctl->work);
+		btrfs_discard_schedule_work(discard_ctl, true);
+	}
+}
+
+void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
+				 bool override)
+{
+	struct btrfs_block_group_cache *cache;
+	u64 now = ktime_get_ns();
+
+	spin_lock(&discard_ctl->lock);
+
+	if (!btrfs_run_discard_work(discard_ctl))
+		goto out;
+
+	if (!override && delayed_work_pending(&discard_ctl->work))
+		goto out;
+
+	cache = find_next_cache(discard_ctl, now);
+	if (cache) {
+		u64 delay = 0;
+
+		if (now < cache->discard_delay)
+			delay = nsecs_to_jiffies(cache->discard_delay - now);
+
+		mod_delayed_work(discard_ctl->discard_workers,
+				 &discard_ctl->work,
+				 delay);
+	}
+
+out:
+	spin_unlock(&discard_ctl->lock);
+}
+
+static void btrfs_discard_workfn(struct work_struct *work)
+{
+	struct btrfs_discard_ctl *discard_ctl;
+	struct btrfs_block_group_cache *cache;
+	u64 trimmed = 0;
+
+	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
+
+	cache = peek_discard_list(discard_ctl);
+	if (!cache || !btrfs_run_discard_work(discard_ctl))
+		return;
+
+	btrfs_trim_block_group(cache, &trimmed, cache->key.objectid,
+			       btrfs_block_group_end(cache), 0);
+
+	remove_from_discard_list(discard_ctl, cache);
+
+	btrfs_discard_schedule_work(discard_ctl, false);
+}
+
+void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+		btrfs_discard_cleanup(fs_info);
+		return;
+	}
+
+	set_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
+}
+
+void btrfs_discard_stop(struct btrfs_fs_info *fs_info)
+{
+	clear_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
+}
+
+void btrfs_discard_init(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
+	int i;
+
+	spin_lock_init(&discard_ctl->lock);
+
+	INIT_DELAYED_WORK(&discard_ctl->work, btrfs_discard_workfn);
+
+	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
+		 INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
+}
+
+void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
+{
+	btrfs_discard_stop(fs_info);
+	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
+}
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
new file mode 100644
index 000000000000..6d7805bb0eb7
--- /dev/null
+++ b/fs/btrfs/discard.h
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#ifndef BTRFS_DISCARD_H
+#define BTRFS_DISCARD_H
+
+#include <linux/kernel.h>
+#include <linux/workqueue.h>
+
+#include "ctree.h"
+
+void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group_cache *cache);
+
+void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group_cache *cache);
+void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
+				 bool override);
+void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
+void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
+void btrfs_discard_init(struct btrfs_fs_info *fs_info);
+void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info);
+
+static inline
+bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
+{
+	struct btrfs_fs_info *fs_info = container_of(discard_ctl,
+						     struct btrfs_fs_info,
+						     discard_ctl);
+
+	return (!(fs_info->sb->s_flags & SB_RDONLY) &&
+		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
+}
+
+static inline
+void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
+			      struct btrfs_block_group_cache *cache)
+{
+	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
+		return;
+
+	btrfs_add_to_discard_list(discard_ctl, cache);
+	if (!delayed_work_pending(&discard_ctl->work))
+		btrfs_discard_schedule_work(discard_ctl, false);
+}
+
+#endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 044981cf6df9..a304ec972f67 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -41,6 +41,7 @@
 #include "tree-checker.h"
 #include "ref-verify.h"
 #include "block-group.h"
+#include "discard.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -2009,6 +2010,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->flush_workers);
 	btrfs_destroy_workqueue(fs_info->qgroup_rescan_workers);
 	btrfs_destroy_workqueue(fs_info->extent_workers);
+	if (fs_info->discard_ctl.discard_workers)
+		destroy_workqueue(fs_info->discard_ctl.discard_workers);
 	/*
 	 * Now that all other work queues are destroyed, we can safely destroy
 	 * the queues used for metadata I/O, since tasks from those other work
@@ -2218,6 +2221,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 		btrfs_alloc_workqueue(fs_info, "extent-refs", flags,
 				      min_t(u64, fs_devices->num_devices,
 					    max_active), 8);
+	fs_info->discard_ctl.discard_workers =
+		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
 
 	if (!(fs_info->workers && fs_info->delalloc_workers &&
 	      fs_info->submit_workers && fs_info->flush_workers &&
@@ -2229,7 +2234,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	      fs_info->caching_workers && fs_info->readahead_workers &&
 	      fs_info->fixup_workers && fs_info->delayed_workers &&
 	      fs_info->extent_workers &&
-	      fs_info->qgroup_rescan_workers)) {
+	      fs_info->qgroup_rescan_workers &&
+	      fs_info->discard_ctl.discard_workers)) {
 		return -ENOMEM;
 	}
 
@@ -2772,6 +2778,8 @@ int open_ctree(struct super_block *sb,
 	btrfs_init_dev_replace_locks(fs_info);
 	btrfs_init_qgroup(fs_info);
 
+	btrfs_discard_init(fs_info);
+
 	btrfs_init_free_cluster(&fs_info->meta_alloc_cluster);
 	btrfs_init_free_cluster(&fs_info->data_alloc_cluster);
 
@@ -3284,6 +3292,8 @@ int open_ctree(struct super_block *sb,
 
 	btrfs_qgroup_rescan_resume(fs_info);
 
+	btrfs_discard_resume(fs_info);
+
 	if (!fs_info->uuid_root) {
 		btrfs_info(fs_info, "creating UUID tree");
 		ret = btrfs_create_uuid_tree(fs_info);
@@ -3993,6 +4003,9 @@ void close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	kthread_park(fs_info->cleaner_kthread);
 
+	/* cancel or finish ongoing work */
+	btrfs_discard_cleanup(fs_info);
+
 	/* wait for the qgroup rescan worker to stop */
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b9e3bedad878..d69ee5f51b38 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -32,6 +32,7 @@
 #include "block-rsv.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "discard.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2919,6 +2920,9 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		cond_resched();
 	}
 
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_schedule_work(&fs_info->discard_ctl, true);
+
 	/*
 	 * Transaction is finished.  We don't need the lock anymore.  We
 	 * do need to clean up the block groups in case of a transaction
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 129b9a164b35..54ff1bc97777 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -21,6 +21,7 @@
 #include "space-info.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "discard.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_32K
@@ -2353,6 +2354,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
 			   u64 offset, u64 bytes, u32 flags)
 {
+	struct btrfs_block_group_cache *cache = ctl->private;
 	struct btrfs_free_space *info;
 	int ret = 0;
 
@@ -2402,6 +2404,9 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 		ASSERT(ret != -EEXIST);
 	}
 
+	if (!(flags & BTRFS_FSC_TRIMMED))
+		btrfs_discard_queue_work(&fs_info->discard_ctl, cache);
+
 	return ret;
 }
 
@@ -3175,14 +3180,17 @@ void btrfs_init_free_cluster(struct btrfs_free_cluster *cluster)
 static int do_trimming(struct btrfs_block_group_cache *block_group,
 		       u64 *total_trimmed, u64 start, u64 bytes,
 		       u64 reserved_start, u64 reserved_bytes,
-		       struct btrfs_trim_range *trim_entry)
+		       u32 reserved_flags, struct btrfs_trim_range *trim_entry)
 {
 	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
 	int update = 0;
+	u64 end = start + bytes;
+	u64 reserved_end = reserved_start + reserved_bytes;
 	u64 trimmed = 0;
+	u32 flags = 0;
 
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
@@ -3195,11 +3203,19 @@ static int do_trimming(struct btrfs_block_group_cache *block_group,
 	spin_unlock(&space_info->lock);
 
 	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
-	if (!ret)
+	if (!ret) {
 		*total_trimmed += trimmed;
+		flags |= BTRFS_FSC_TRIMMED;
+	}
 
 	mutex_lock(&ctl->cache_writeout_mutex);
-	btrfs_add_free_space(block_group, reserved_start, reserved_bytes);
+	if (reserved_start < start)
+		__btrfs_add_free_space(fs_info, ctl, reserved_start,
+				       start - reserved_start, reserved_flags);
+	if (start + bytes < reserved_start + reserved_bytes)
+		__btrfs_add_free_space(fs_info, ctl, end,
+				       reserved_end - end, reserved_flags);
+	__btrfs_add_free_space(fs_info, ctl, start, bytes, flags);
 	list_del(&trim_entry->list);
 	mutex_unlock(&ctl->cache_writeout_mutex);
 
@@ -3226,6 +3242,7 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 	int ret = 0;
 	u64 extent_start;
 	u64 extent_bytes;
+	u32 extent_flags;
 	u64 bytes;
 
 	while (start < end) {
@@ -3267,6 +3284,7 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 
 		extent_start = entry->offset;
 		extent_bytes = entry->bytes;
+		extent_flags = entry->flags;
 		start = max(start, extent_start);
 		bytes = min(extent_start + extent_bytes, end) - start;
 		if (bytes < minlen) {
@@ -3285,7 +3303,8 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 		mutex_unlock(&ctl->cache_writeout_mutex);
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
-				  extent_start, extent_bytes, &trim_entry);
+				  extent_start, extent_bytes, extent_flags,
+				  &trim_entry);
 		if (ret)
 			break;
 next:
@@ -3413,7 +3432,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 		mutex_unlock(&ctl->cache_writeout_mutex);
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
-				  start, bytes, &trim_entry);
+				  start, bytes, 0, &trim_entry);
 		if (ret) {
 			reset_trimming_bitmap(ctl, offset);
 			break;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a02fece949cb..3da60d7be535 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -46,6 +46,7 @@
 #include "sysfs.h"
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
+#include "discard.h"
 
 #include "qgroup.h"
 #define CREATE_TRACE_POINTS
@@ -146,6 +147,8 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	if (sb_rdonly(sb))
 		return;
 
+	btrfs_discard_stop(fs_info);
+
 	/* btrfs handle error by forcing the filesystem readonly */
 	sb->s_flags |= SB_RDONLY;
 	btrfs_info(fs_info, "forced readonly");
@@ -313,6 +316,7 @@ enum {
 	Opt_datasum, Opt_nodatasum,
 	Opt_defrag, Opt_nodefrag,
 	Opt_discard, Opt_nodiscard,
+	Opt_discard_version,
 	Opt_nologreplay,
 	Opt_norecovery,
 	Opt_ratio,
@@ -376,6 +380,7 @@ static const match_table_t tokens = {
 	{Opt_nodefrag, "noautodefrag"},
 	{Opt_discard, "discard"},
 	{Opt_nodiscard, "nodiscard"},
+	{Opt_discard_version, "discard=%s"},
 	{Opt_nologreplay, "nologreplay"},
 	{Opt_norecovery, "norecovery"},
 	{Opt_ratio, "metadata_ratio=%u"},
@@ -695,12 +700,26 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				   info->metadata_ratio);
 			break;
 		case Opt_discard:
-			btrfs_set_and_info(info, DISCARD_SYNC,
-					   "turning on sync discard");
+		case Opt_discard_version:
+			if (token == Opt_discard ||
+			    strcmp(args[0].from, "sync") == 0) {
+				btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
+				btrfs_set_and_info(info, DISCARD_SYNC,
+						   "turning on sync discard");
+			} else if (strcmp(args[0].from, "async") == 0) {
+				btrfs_clear_opt(info->mount_opt, DISCARD_SYNC);
+				btrfs_set_and_info(info, DISCARD_ASYNC,
+						   "turning on async discard");
+			} else {
+				ret = -EINVAL;
+				goto out;
+			}
 			break;
 		case Opt_nodiscard:
 			btrfs_clear_and_info(info, DISCARD_SYNC,
 					     "turning off discard");
+			btrfs_clear_and_info(info, DISCARD_ASYNC,
+					     "turning off async discard");
 			break;
 		case Opt_space_cache:
 		case Opt_space_cache_version:
@@ -1324,6 +1343,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
 		seq_puts(seq, ",discard");
+	if (btrfs_test_opt(info, DISCARD_ASYNC))
+		seq_puts(seq, ",discard=async");
 	if (!(info->sb->s_flags & SB_POSIXACL))
 		seq_puts(seq, ",noacl");
 	if (btrfs_test_opt(info, SPACE_CACHE))
@@ -1714,6 +1735,14 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 		btrfs_cleanup_defrag_inodes(fs_info);
 	}
 
+	/* if we toggled discard async */
+	if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
+	    btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_resume(fs_info);
+	else if (btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
+		 !btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_cleanup(fs_info);
+
 	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 }
 
@@ -1761,6 +1790,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		 */
 		cancel_work_sync(&fs_info->async_reclaim_work);
 
+		btrfs_discard_cleanup(fs_info);
+
 		/* wait for the uuid_scan task to finish */
 		down(&fs_info->uuid_tree_rescan_sem);
 		/* avoid complains from lockdep et al. */
-- 
2.17.1

