Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F208104618
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKTVvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34639 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKTVvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id b188so1292507qkg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Hea7aVTom6REhWz5W8jlZHLcyNP2MEFfaOn3AwqhSpY=;
        b=smS7wVOn++RBO+8q40BgvZhX5qq5929nOolyc00AfJkH7ZwMoyqKimzkRMhp23bzIP
         qdO5zpfIxGc/CKmG5nw52qSXlm08JQZYoveQOgBp/qTFoW3M38Sgoi69nQC+YQE7ozHB
         /nuI8rhO2EVCIvWTBoUIDrKfAsyJSABfLUoXm5c7wlZo9ZBcLW8bYw3n15c1aOLTukuP
         NcnXo1jfsC/sNqmzX2SrtujZ5N8hDte6+tWUFrowDGBYUXEtXbY7EJ7eRh/C+5XFUN2H
         UmT+IfIIAdiK/ogDrzVkcyJB/0fnlgGvTcUKgqhJf4obKklGciVOLK71PplYnZsH5PgE
         XgRw==
X-Gm-Message-State: APjAAAWPk9/Zoa/QaIKyVtiorDx2PXkuuTpEz4V9aDhf2QQbpG4m75Mt
        7Qrbn3PUquSXUiThEjosHEI=
X-Google-Smtp-Source: APXvYqwtTxscJ6aQqPA+d99iO4iwTaQcBeYANm7Btugjk7CVv45EoCteUdZW5/WMzNI1AGjkInkwYQ==
X-Received: by 2002:a37:6442:: with SMTP id y63mr4647159qkb.264.1574286693389;
        Wed, 20 Nov 2019 13:51:33 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:32 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 05/22] btrfs: add the beginning of async discard, discard workqueue
Date:   Wed, 20 Nov 2019 16:51:04 -0500
Message-Id: <63d3257efe1158a6fbbd7abe865cd9250b494438.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
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
 fs/btrfs/block-group.c      |   4 +
 fs/btrfs/block-group.h      |   9 ++
 fs/btrfs/ctree.h            |  21 +++
 fs/btrfs/discard.c          | 273 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          |  26 ++++
 fs/btrfs/disk-io.c          |  15 +-
 fs/btrfs/extent-tree.c      |   4 +
 fs/btrfs/free-space-cache.c |  35 ++++-
 fs/btrfs/super.c            |  35 ++++-
 10 files changed, 414 insertions(+), 10 deletions(-)
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
index 6064be2d5556..d2bc46c365f4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -14,6 +14,7 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
+#include "discard.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -1272,6 +1273,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->unused_bgs_lock);
 
+		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+
 		mutex_lock(&fs_info->delete_unused_bgs_mutex);
 
 		/* Don't want to race with allocators so take the groups_sem */
@@ -1617,6 +1620,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
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
index 8ac3b2deef4a..d5ce8054f074 100644
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
index 000000000000..15d54de3d682
--- /dev/null
+++ b/fs/btrfs/discard.c
@@ -0,0 +1,273 @@
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
+static struct list_head *btrfs_get_discard_list(
+					struct btrfs_discard_ctl *discard_ctl,
+					struct btrfs_block_group *block_group)
+{
+	return &discard_ctl->discard_list[block_group->discard_index];
+}
+
+void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group *block_group)
+{
+	spin_lock(&discard_ctl->lock);
+
+	if (list_empty(&block_group->discard_list))
+		block_group->discard_eligible_time = (ktime_get_ns() +
+						      BTRFS_DISCARD_DELAY);
+
+	list_move_tail(&block_group->discard_list,
+		       btrfs_get_discard_list(discard_ctl, block_group));
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
+	btrfs_add_to_discard_list(discard_ctl, block_group);
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
index 000000000000..439ca8c51877
--- /dev/null
+++ b/fs/btrfs/discard.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_DISCARD_H
+#define BTRFS_DISCARD_H
+
+struct btrfs_fs_info;
+struct btrfs_discard_ctl;
+struct btrfs_block_group;
+
+void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
+			       struct btrfs_block_group *block_group);
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
index e0edfdc9c82b..8785b5c999b0 100644
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
 
@@ -3263,6 +3271,8 @@ int __cold open_ctree(struct super_block *sb,
 
 	btrfs_qgroup_rescan_resume(fs_info);
 
+	btrfs_discard_resume(fs_info);
+
 	if (!fs_info->uuid_root) {
 		btrfs_info(fs_info, "creating UUID tree");
 		ret = btrfs_create_uuid_tree(fs_info);
@@ -3954,6 +3964,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	kthread_park(fs_info->cleaner_kthread);
 
+	/* cancel or finish ongoing work */
+	btrfs_discard_cleanup(fs_info);
+
 	/* wait for the qgroup rescan worker to stop */
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e1ff2f115182..40e965b06f8f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -32,6 +32,7 @@
 #include "block-rsv.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "discard.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2940,6 +2941,9 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		cond_resched();
 	}
 
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_schedule_work(&fs_info->discard_ctl, true);
+
 	/*
 	 * Transaction is finished.  We don't need the lock anymore.  We
 	 * do need to clean up the block groups in case of a transaction
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 946a7df33249..72933996e743 100644
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
 
@@ -3204,6 +3211,7 @@ void btrfs_init_free_cluster(struct btrfs_free_cluster *cluster)
 static int do_trimming(struct btrfs_block_group *block_group,
 		       u64 *total_trimmed, u64 start, u64 bytes,
 		       u64 reserved_start, u64 reserved_bytes,
+		       enum btrfs_trim_state reserved_trim_state,
 		       struct btrfs_trim_range *trim_entry)
 {
 	struct btrfs_space_info *space_info = block_group->space_info;
@@ -3211,6 +3219,9 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
 	int update = 0;
+	u64 end = start + bytes;
+	u64 reserved_end = reserved_start + reserved_bytes;
+	enum btrfs_trim_state trim_state;
 	u64 trimmed = 0;
 
 	spin_lock(&space_info->lock);
@@ -3224,11 +3235,20 @@ static int do_trimming(struct btrfs_block_group *block_group,
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
 
@@ -3255,6 +3275,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 	int ret = 0;
 	u64 extent_start;
 	u64 extent_bytes;
+	enum btrfs_trim_state extent_trim_state;
 	u64 bytes;
 
 	while (start < end) {
@@ -3296,6 +3317,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 
 		extent_start = entry->offset;
 		extent_bytes = entry->bytes;
+		extent_trim_state = entry->trim_state;
 		start = max(start, extent_start);
 		bytes = min(extent_start + extent_bytes, end) - start;
 		if (bytes < minlen) {
@@ -3314,7 +3336,8 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		mutex_unlock(&ctl->cache_writeout_mutex);
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
-				  extent_start, extent_bytes, &trim_entry);
+				  extent_start, extent_bytes, extent_trim_state,
+				  &trim_entry);
 		if (ret)
 			break;
 next:
@@ -3440,7 +3463,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		mutex_unlock(&ctl->cache_writeout_mutex);
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
-				  start, bytes, &trim_entry);
+				  start, bytes, 0, &trim_entry);
 		if (ret) {
 			reset_trimming_bitmap(ctl, offset);
 			break;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f131fb9f0f69..0edf00753c00 100644
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
-- 
2.17.1

