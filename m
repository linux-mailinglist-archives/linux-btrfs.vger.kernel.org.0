Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA54711EF20
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLNAWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45678 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLNAWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2308990pfg.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wwX6hZwtvdTsn9ulQL9PYxQIick7iGjLYDTcOZu7ox4=;
        b=p8/cm+H9y4yCVpIAVHwHKbWISfVIq1oT28e5nuIqhJxwYsCmFQq9TVz1AfsM3a0IUB
         WLzC1Oo75G4sazsYdxqxlMwcCeGrnZSGSARDmaEzwyF0tp7CSVNXCJlLpd0B0NH7N9x4
         UOt4LSgJNGzWOotHuZ9KaTum+UVnbceXuvlHz+OE9Z47MgwzLMK/aAaUeywYIvB/O5iX
         mO+Lzud55Bslf2SYgFtGyVEgkN/nplVICZ9CCwgWw8zyPm6yva2zGy4tA3o/U46+4WzV
         iMpQO8PqWTOj9Xis/euy2sa3vm2pWbcyPD4VH6gwlQ80nVoLfG/0unA19h83VdFql8G4
         04Lw==
X-Gm-Message-State: APjAAAURehCXwebPQm4/QDnM/y0yVX0obFZbYtSHPxkUl973nm0PdN3K
        +hp6p5Xgj1YLu7ekt39T1eU=
X-Google-Smtp-Source: APXvYqyqd7MoRVxN0EsAMfypaA8OZbxDgF488GPtDcbVIMaJrdhi5v2sYCYkg5aq0kaOltJRnTgcIg==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr2653048pgj.119.1576282965366;
        Fri, 13 Dec 2019 16:22:45 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:44 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 05/22] btrfs: add the beginning of async discard, discard workqueue
Date:   Fri, 13 Dec 2019 16:22:14 -0800
Message-Id: <cabe889e88f5f385ebfcf812135e7f4aa8b21cbc.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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

On a number of Facebook webservers, I collected data every minute
accounting the time we spent in btrfs_finish_extent_commit() (col. 1)
and in btrfs_commit_transaction() (col. 2). btrfs_finish_extent_commit()
is where we discard extents synchronously before returning them to the
free space cache.

discard=sync:
                 p99 total per minute       p99 total per minute
      Drive   |   extent_commit() (ms)  |    commit_trans() (ms)
    ---------------------------------------------------------------
     Drive A  |           434           |          1170
     Drive B  |           880           |          2330
     Drive C  |          2943           |          3920
     Drive D  |          4763           |          5701

discard=async:
                 p99 total per minute       p99 total per minute
      Drive   |   extent_commit() (ms)  |    commit_trans() (ms)
    --------------------------------------------------------------
     Drive A  |           134           |           956
     Drive B  |            64           |          1972
     Drive C  |            59           |          1032
     Drive D  |            62           |          1200

While it's not great that the stats are cumulative over 1m, all of these
servers are running the same workload and and the delta between the two
are substantial. We are spending significantly less time in
btrfs_finish_extent_commit() which is responsible for discarding.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/block-group.c      |  37 ++++-
 fs/btrfs/block-group.h      |   9 ++
 fs/btrfs/ctree.h            |  21 +++
 fs/btrfs/discard.c          | 278 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          |  23 +++
 fs/btrfs/disk-io.c          |  15 +-
 fs/btrfs/extent-tree.c      |   4 +
 fs/btrfs/free-space-cache.c |  54 ++++++-
 fs/btrfs/free-space-cache.h |   2 +
 fs/btrfs/super.c            |  35 ++++-
 fs/btrfs/volumes.c          |   7 +
 12 files changed, 474 insertions(+), 13 deletions(-)
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
index be1938dc94fd..c1b1b59343bd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -14,6 +14,7 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
+#include "discard.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -131,6 +132,15 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 		WARN_ON(cache->pinned > 0);
 		WARN_ON(cache->reserved > 0);
 
+		/*
+		 * A block_group shouldn't be on the discard_list anymore.
+		 * Remove the block_group from the discard_list to prevent us
+		 * from causing a panic due to NPE.
+		 */
+		if (WARN_ON(!list_empty(&cache->discard_list)))
+			btrfs_discard_cancel_work(&cache->fs_info->discard_ctl,
+						  cache);
+
 		/*
 		 * If not empty, someone is still holding mutex of
 		 * full_stripe_lock, which can only be released by caller.
@@ -466,8 +476,8 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 		} else if (extent_start > start && extent_start < end) {
 			size = extent_start - start;
 			total_added += size;
-			ret = btrfs_add_free_space(block_group, start,
-						   size);
+			ret = btrfs_add_free_space_async_trimmed(block_group,
+								 start, size);
 			BUG_ON(ret); /* -ENOMEM or logic error */
 			start = extent_end + 1;
 		} else {
@@ -478,7 +488,8 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 	if (start < end) {
 		size = end - start;
 		total_added += size;
-		ret = btrfs_add_free_space(block_group, start, size);
+		ret = btrfs_add_free_space_async_trimmed(block_group, start,
+							 size);
 		BUG_ON(ret); /* -ENOMEM or logic error */
 	}
 
@@ -1258,6 +1269,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->unused_bgs_lock);
 
+		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+
 		mutex_lock(&fs_info->delete_unused_bgs_mutex);
 
 		/* Don't want to race with allocators so take the groups_sem */
@@ -1333,6 +1346,23 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 
+		/*
+		 * At this point, the block_group is read only and should fail
+		 * new allocations.  However, btrfs_finish_extent_commit() can
+		 * cause this block_group to be placed back on the discard
+		 * lists because now the block_group isn't fully discarded.
+		 * Bail here and try again later after discarding everything.
+		 */
+		spin_lock(&fs_info->discard_ctl.lock);
+		if (!list_empty(&block_group->discard_list)) {
+			spin_unlock(&fs_info->discard_ctl.lock);
+			btrfs_dec_block_group_ro(block_group);
+			btrfs_discard_queue_work(&fs_info->discard_ctl,
+						 block_group);
+			goto end_trans;
+		}
+		spin_unlock(&fs_info->discard_ctl.lock);
+
 		/* Reset pinned so btrfs_put_block_group doesn't complain */
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
@@ -1603,6 +1633,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	INIT_LIST_HEAD(&cache->cluster_list);
 	INIT_LIST_HEAD(&cache->bg_list);
 	INIT_LIST_HEAD(&cache->ro_list);
+	INIT_LIST_HEAD(&cache->discard_list);
 	INIT_LIST_HEAD(&cache->dirty_list);
 	INIT_LIST_HEAD(&cache->io_list);
 	btrfs_init_free_space_ctl(cache);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9b409676c4b2..884defd61dcd 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -116,7 +116,11 @@ struct btrfs_block_group {
 	/* For read-only block groups */
 	struct list_head ro_list;
 
+	/* For discard operations */
 	atomic_t trimming;
+	struct list_head discard_list;
+	int discard_index;
+	u64 discard_eligible_time;
 
 	/* For dirty block groups */
 	struct list_head dirty_list;
@@ -158,6 +162,11 @@ struct btrfs_block_group {
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
 };
 
+static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
+{
+	return (block_group->start + block_group->length);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline int btrfs_should_fragment_free_space(
 		struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2f6c21ea84af..f7b429277089 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -440,6 +440,21 @@ struct btrfs_full_stripe_locks_tree {
 	struct mutex lock;
 };
 
+/* Discard control. */
+/*
+ * Async discard uses multiple lists to differentiate the discard filter
+ * parameters.
+ */
+#define BTRFS_NR_DISCARD_LISTS		1
+
+struct btrfs_discard_ctl {
+	struct workqueue_struct *discard_workers;
+	struct delayed_work work;
+	spinlock_t lock;
+	struct btrfs_block_group *block_group;
+	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+};
+
 /* delayed seq elem */
 struct seq_list {
 	struct list_head list;
@@ -526,6 +541,9 @@ enum {
 	 * so we don't need to offload checksums to workqueues.
 	 */
 	BTRFS_FS_CSUM_IMPL_FAST,
+
+	/* Indicate that the discard workqueue can service discards. */
+	BTRFS_FS_DISCARD_RUNNING,
 };
 
 struct btrfs_fs_info {
@@ -816,6 +834,8 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *scrub_wr_completion_workers;
 	struct btrfs_workqueue *scrub_parity_workers;
 
+	struct btrfs_discard_ctl discard_ctl;
+
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	u32 check_integrity_print_mask;
 #endif
@@ -1189,6 +1209,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
+#define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
new file mode 100644
index 000000000000..692d64025802
--- /dev/null
+++ b/fs/btrfs/discard.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/sizes.h>
+#include <linux/workqueue.h>
+#include "ctree.h"
+#include "block-group.h"
+#include "discard.h"
+#include "free-space-cache.h"
+
+/* This is an initial delay to give some chance for lba reuse. */
+#define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
+
+static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
+					  struct btrfs_block_group *block_group)
+{
+	return &discard_ctl->discard_list[block_group->discard_index];
+}
+
+static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+				struct btrfs_block_group *block_group)
+{
+	spin_lock(&discard_ctl->lock);
+
+	if (!btrfs_run_discard_work(discard_ctl)) {
+		spin_unlock(&discard_ctl->lock);
+		return;
+	}
+
+	if (list_empty(&block_group->discard_list))
+		block_group->discard_eligible_time = (ktime_get_ns() +
+						      BTRFS_DISCARD_DELAY);
+
+	list_move_tail(&block_group->discard_list,
+		       get_discard_list(discard_ctl, block_group));
+
+	spin_unlock(&discard_ctl->lock);
+}
+
+static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
+				     struct btrfs_block_group *block_group)
+{
+	bool running = false;
+
+	spin_lock(&discard_ctl->lock);
+
+	if (block_group == discard_ctl->block_group) {
+		running = true;
+		discard_ctl->block_group = NULL;
+	}
+
+	block_group->discard_eligible_time = 0;
+	list_del_init(&block_group->discard_list);
+
+	spin_unlock(&discard_ctl->lock);
+
+	return running;
+}
+
+/**
+ * find_next_block_group - find block_group that's up next for discarding
+ * @discard_ctl: discard control
+ * @now: current time
+ *
+ * Iterate over the discard lists to find the next block_group up for
+ * discarding checking the discard_eligible_time of block_group.
+ */
+static struct btrfs_block_group *find_next_block_group(
+					struct btrfs_discard_ctl *discard_ctl,
+					u64 now)
+{
+	struct btrfs_block_group *ret_block_group = NULL, *block_group;
+	int i;
+
+	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++) {
+		struct list_head *discard_list = &discard_ctl->discard_list[i];
+
+		if (!list_empty(discard_list)) {
+			block_group = list_first_entry(discard_list,
+						       struct btrfs_block_group,
+						       discard_list);
+
+			if (!ret_block_group)
+				ret_block_group = block_group;
+
+			if (ret_block_group->discard_eligible_time < now)
+				break;
+
+			if (ret_block_group->discard_eligible_time >
+			    block_group->discard_eligible_time)
+				ret_block_group = block_group;
+		}
+	}
+
+	return ret_block_group;
+}
+
+/**
+ * peek_discard_list - wrap find_next_block_group()
+ * @discard_ctl: discard control
+ *
+ * This wraps find_next_block_group() and sets the block_group to be in use.
+ */
+static struct btrfs_block_group *peek_discard_list(
+					struct btrfs_discard_ctl *discard_ctl)
+{
+	struct btrfs_block_group *block_group;
+	u64 now = ktime_get_ns();
+
+	spin_lock(&discard_ctl->lock);
+
+	block_group = find_next_block_group(discard_ctl, now);
+
+	if (block_group && now < block_group->discard_eligible_time)
+		block_group = NULL;
+
+	discard_ctl->block_group = block_group;
+
+	spin_unlock(&discard_ctl->lock);
+
+	return block_group;
+}
+
+/**
+ * btrfs_discard_cancel_work - remove a block_group from the discard lists
+ * @discard_ctl: discard control
+ * @block_group: block_group of interest
+ *
+ * This removes @block_group from the discard lists.  If necessary, it waits on
+ * the current work and then reschedules the delayed work.
+ */
+void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group *block_group)
+{
+	if (remove_from_discard_list(discard_ctl, block_group)) {
+		cancel_delayed_work_sync(&discard_ctl->work);
+		btrfs_discard_schedule_work(discard_ctl, true);
+	}
+}
+
+/**
+ * btrfs_discard_queue_work - handles queuing the block_groups
+ * @discard_ctl: discard control
+ * @block_group: block_group of interest
+ *
+ * This maintains the LRU order of the discard lists.
+ */
+void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
+			      struct btrfs_block_group *block_group)
+{
+	if (!block_group ||
+	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+		return;
+
+	add_to_discard_list(discard_ctl, block_group);
+
+	if (!delayed_work_pending(&discard_ctl->work))
+		btrfs_discard_schedule_work(discard_ctl, false);
+}
+
+/**
+ * btrfs_discard_schedule_work - responsible for scheduling the discard work
+ * @discard_ctl: discard control
+ * @override: override the current timer
+ *
+ * Discards are issued by a delayed workqueue item.  @override is used to
+ * update the current delay as the baseline delay interview is reevaluated
+ * on transaction commit.  This is also maxed with any other rate limit.
+ */
+void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
+				 bool override)
+{
+	struct btrfs_block_group *block_group;
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
+	block_group = find_next_block_group(discard_ctl, now);
+	if (block_group) {
+		u64 delay = 0;
+
+		if (now < block_group->discard_eligible_time)
+			delay = nsecs_to_jiffies(
+				block_group->discard_eligible_time - now);
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
+/**
+ * btrfs_discard_workfn - discard work function
+ * @work: work
+ *
+ * This finds the next block_group to start discarding and then discards it.
+ */
+static void btrfs_discard_workfn(struct work_struct *work)
+{
+	struct btrfs_discard_ctl *discard_ctl;
+	struct btrfs_block_group *block_group;
+	u64 trimmed = 0;
+
+	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
+
+	block_group = peek_discard_list(discard_ctl);
+	if (!block_group || !btrfs_run_discard_work(discard_ctl))
+		return;
+
+	btrfs_trim_block_group(block_group, &trimmed, block_group->start,
+			       btrfs_block_group_end(block_group), 0);
+
+	remove_from_discard_list(discard_ctl, block_group);
+
+	btrfs_discard_schedule_work(discard_ctl, false);
+}
+
+/**
+ * btrfs_run_discard_work - determines if async discard should be running
+ * @discard_ctl: discard control
+ *
+ * Checks if the file system is writeable and BTRFS_FS_DISCARD_RUNNING is set.
+ */
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
+		INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
+}
+
+void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
+{
+	btrfs_discard_stop(fs_info);
+	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
+}
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
new file mode 100644
index 000000000000..f3775e84d35a
--- /dev/null
+++ b/fs/btrfs/discard.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_DISCARD_H
+#define BTRFS_DISCARD_H
+
+struct btrfs_fs_info;
+struct btrfs_discard_ctl;
+struct btrfs_block_group;
+
+void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group *block_group);
+void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
+			      struct btrfs_block_group *block_group);
+void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
+				 bool override);
+bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
+
+void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
+void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
+void btrfs_discard_init(struct btrfs_fs_info *fs_info);
+void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info);
+
+#endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 881aba162e4e..d517c4b31338 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -41,6 +41,7 @@
 #include "tree-checker.h"
 #include "ref-verify.h"
 #include "block-group.h"
+#include "discard.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -1953,6 +1954,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->readahead_workers);
 	btrfs_destroy_workqueue(fs_info->flush_workers);
 	btrfs_destroy_workqueue(fs_info->qgroup_rescan_workers);
+	if (fs_info->discard_ctl.discard_workers)
+		destroy_workqueue(fs_info->discard_ctl.discard_workers);
 	/*
 	 * Now that all other work queues are destroyed, we can safely destroy
 	 * the queues used for metadata I/O, since tasks from those other work
@@ -2148,6 +2151,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 				      max_active, 2);
 	fs_info->qgroup_rescan_workers =
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
+	fs_info->discard_ctl.discard_workers =
+		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
 
 	if (!(fs_info->workers && fs_info->delalloc_workers &&
 	      fs_info->flush_workers &&
@@ -2158,7 +2163,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->readahead_workers &&
 	      fs_info->fixup_workers && fs_info->delayed_workers &&
-	      fs_info->qgroup_rescan_workers)) {
+	      fs_info->qgroup_rescan_workers &&
+	      fs_info->discard_ctl.discard_workers)) {
 		return -ENOMEM;
 	}
 
@@ -2793,6 +2799,8 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_init_dev_replace_locks(fs_info);
 	btrfs_init_qgroup(fs_info);
 
+	btrfs_discard_init(fs_info);
+
 	btrfs_init_free_cluster(&fs_info->meta_alloc_cluster);
 	btrfs_init_free_cluster(&fs_info->data_alloc_cluster);
 
@@ -3256,6 +3264,8 @@ int __cold open_ctree(struct super_block *sb,
 
 	btrfs_qgroup_rescan_resume(fs_info);
 
+	btrfs_discard_resume(fs_info);
+
 	if (!fs_info->uuid_root) {
 		btrfs_info(fs_info, "creating UUID tree");
 		ret = btrfs_create_uuid_tree(fs_info);
@@ -3971,6 +3981,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
 
+	/* cancel or finish ongoing discard work */
+	btrfs_discard_cleanup(fs_info);
+
 	if (!sb_rdonly(fs_info->sb)) {
 		/*
 		 * The cleaner kthread is stopped, so do one final pass over
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1a8bf943c3e7..2c12366cfde5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -32,6 +32,7 @@
 #include "block-rsv.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "discard.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2934,6 +2935,9 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		cond_resched();
 	}
 
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_schedule_work(&fs_info->discard_ctl, true);
+
 	/*
 	 * Transaction is finished.  We don't need the lock anymore.  We
 	 * do need to clean up the block groups in case of a transaction
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7108962e208d..0a868b6df893 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -21,6 +21,7 @@
 #include "space-info.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "discard.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_32K
@@ -755,9 +756,11 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 		/*
 		 * Sync discard ensures that the free space cache is always
 		 * trimmed.  So when reading this in, the state should reflect
-		 * that.
+		 * that.  We also do this for async as a stop gap for lack of
+		 * persistence.
 		 */
-		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+		    btrfs_test_opt(fs_info, DISCARD_ASYNC))
 			e->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 
 		if (!e->bytes) {
@@ -2382,6 +2385,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   u64 offset, u64 bytes,
 			   enum btrfs_trim_state trim_state)
 {
+	struct btrfs_block_group *block_group = ctl->private;
 	struct btrfs_free_space *info;
 	int ret = 0;
 
@@ -2431,6 +2435,9 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 		ASSERT(ret != -EEXIST);
 	}
 
+	if (trim_state != BTRFS_TRIM_STATE_TRIMMED)
+		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
+
 	return ret;
 }
 
@@ -2447,6 +2454,25 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
 				      bytenr, size, trim_state);
 }
 
+/*
+ * This is a subtle distinction because when adding free space back in general,
+ * we want it to be added as untrimmed for async. But in the case where we add
+ * it on loading of a block group, we want to consider it trimmed.
+ */
+int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
+				       u64 bytenr, u64 size)
+{
+	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+
+	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC) ||
+	    btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+		trim_state = BTRFS_TRIM_STATE_TRIMMED;
+
+	return __btrfs_add_free_space(block_group->fs_info,
+				      block_group->free_space_ctl,
+				      bytenr, size, trim_state);
+}
+
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			    u64 offset, u64 bytes)
 {
@@ -3209,6 +3235,7 @@ void btrfs_init_free_cluster(struct btrfs_free_cluster *cluster)
 static int do_trimming(struct btrfs_block_group *block_group,
 		       u64 *total_trimmed, u64 start, u64 bytes,
 		       u64 reserved_start, u64 reserved_bytes,
+		       enum btrfs_trim_state reserved_trim_state,
 		       struct btrfs_trim_range *trim_entry)
 {
 	struct btrfs_space_info *space_info = block_group->space_info;
@@ -3216,6 +3243,9 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
 	int update = 0;
+	u64 end = start + bytes;
+	u64 reserved_end = reserved_start + reserved_bytes;
+	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 	u64 trimmed = 0;
 
 	spin_lock(&space_info->lock);
@@ -3229,11 +3259,20 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	spin_unlock(&space_info->lock);
 
 	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
-	if (!ret)
+	if (!ret) {
 		*total_trimmed += trimmed;
+		trim_state = BTRFS_TRIM_STATE_TRIMMED;
+	}
 
 	mutex_lock(&ctl->cache_writeout_mutex);
-	btrfs_add_free_space(block_group, reserved_start, reserved_bytes);
+	if (reserved_start < start)
+		__btrfs_add_free_space(fs_info, ctl, reserved_start,
+				       start - reserved_start,
+				       reserved_trim_state);
+	if (start + bytes < reserved_start + reserved_bytes)
+		__btrfs_add_free_space(fs_info, ctl, end, reserved_end - end,
+				       reserved_trim_state);
+	__btrfs_add_free_space(fs_info, ctl, start, bytes, trim_state);
 	list_del(&trim_entry->list);
 	mutex_unlock(&ctl->cache_writeout_mutex);
 
@@ -3260,6 +3299,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 	int ret = 0;
 	u64 extent_start;
 	u64 extent_bytes;
+	enum btrfs_trim_state extent_trim_state;
 	u64 bytes;
 
 	while (start < end) {
@@ -3301,6 +3341,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 
 		extent_start = entry->offset;
 		extent_bytes = entry->bytes;
+		extent_trim_state = entry->trim_state;
 		start = max(start, extent_start);
 		bytes = min(extent_start + extent_bytes, end) - start;
 		if (bytes < minlen) {
@@ -3319,7 +3360,8 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		mutex_unlock(&ctl->cache_writeout_mutex);
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
-				  extent_start, extent_bytes, &trim_entry);
+				  extent_start, extent_bytes, extent_trim_state,
+				  &trim_entry);
 		if (ret)
 			break;
 next:
@@ -3445,7 +3487,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		mutex_unlock(&ctl->cache_writeout_mutex);
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
-				  start, bytes, &trim_entry);
+				  start, bytes, 0, &trim_entry);
 		if (ret) {
 			reset_trimming_bitmap(ctl, offset);
 			break;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 29d16f58b40b..a88c30cb3b2b 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -113,6 +113,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   enum btrfs_trim_state trim_state);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
+int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
+				       u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			    u64 bytenr, u64 size);
 void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 08ac6a7a67f0..215b25012e49 100644
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
+	Opt_discard_mode,
 	Opt_nologreplay,
 	Opt_norecovery,
 	Opt_ratio,
@@ -376,6 +380,7 @@ static const match_table_t tokens = {
 	{Opt_nodefrag, "noautodefrag"},
 	{Opt_discard, "discard"},
 	{Opt_nodiscard, "nodiscard"},
+	{Opt_discard_mode, "discard=%s"},
 	{Opt_nologreplay, "nologreplay"},
 	{Opt_norecovery, "norecovery"},
 	{Opt_ratio, "metadata_ratio=%u"},
@@ -695,12 +700,26 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				   info->metadata_ratio);
 			break;
 		case Opt_discard:
-			btrfs_set_and_info(info, DISCARD_SYNC,
-					   "turning on sync discard");
+		case Opt_discard_mode:
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
@@ -1713,6 +1734,14 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 		btrfs_cleanup_defrag_inodes(fs_info);
 	}
 
+	/* If we toggled discard async. */
+	if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
+	    btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_resume(fs_info);
+	else if (btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
+		 !btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_cleanup(fs_info);
+
 	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 }
 
@@ -1760,6 +1789,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		 */
 		cancel_work_sync(&fs_info->async_reclaim_work);
 
+		btrfs_discard_cleanup(fs_info);
+
 		/* wait for the uuid_scan task to finish */
 		down(&fs_info->uuid_tree_rescan_sem);
 		/* avoid complains from lockdep et al. */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 66377e678504..65e78e59d5c4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -30,6 +30,7 @@
 #include "tree-checker.h"
 #include "space-info.h"
 #include "block-group.h"
+#include "discard.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
@@ -2869,6 +2870,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_trans_handle *trans;
+	struct btrfs_block_group *block_group;
 	int ret;
 
 	/*
@@ -2892,6 +2894,11 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (ret)
 		return ret;
 
+	block_group = btrfs_lookup_block_group(fs_info, chunk_offset);
+	if (!block_group)
+		return -ENOENT;
+	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+
 	trans = btrfs_start_trans_remove_block_group(root->fs_info,
 						     chunk_offset);
 	if (IS_ERR(trans)) {
-- 
2.17.1

