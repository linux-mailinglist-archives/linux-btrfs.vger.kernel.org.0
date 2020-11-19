Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41DD2B8C5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 08:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgKSH2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 02:28:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:53448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKSH2e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 02:28:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605770912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=buVK0bp4q9/of8nGBsPpGgTV1gGTa87cMVbcCiYAdTI=;
        b=pmLjdbNGzfl/4GibUFjf7WyGtl+xcqKEKB2UlnKA2qgHx+3IGWe7frtYiYU76NGN3m/NRF
        36qw95m6FAlGrwUkUcHEEz1zvwparZqBITHpJZqwOk83Bd1f4D2uwLv+PPpAnwyfsnGhMU
        G4wvZxcPmZv33EfsoZO2l6BiHI/A9ZA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 663E9AEA3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Nov 2020 07:28:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: introduce qgroup dirty extents threshold mechanism for snapshot drop and inode truncation
Date:   Thu, 19 Nov 2020 15:28:28 +0800
Message-Id: <20201119072828.70909-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When dropping a lot of btrfs subvolumes with qgroup enabled, there can
be a pretty large latency for btrfs_commit_transaction().

The reason is, dropping subvolumes/snapshots will create a lot of extent
owner change, thus qgroup have to traces such owner changes and cause
latency in btrfs_commit_transaction().

For snapshot/subvolume drop, we don't really have any good way to reduce
the number of dirty qgroup extents.

But least we can still reduce the latency of each
btrfs_commit_transaction() run, by trying to commit transaction when the
dirty qgroup extent number reaches a certain threshold.

By this, we can commit several small transactions instead of a big and
slow transaction.

This patch will introduce the following things:

- The ability to trace how many dirty qgroup extents for one transaction
  A new member, atomic64_t nr_dirty_extents, is introduced to
  btrfs_delayed_ref_root.

- Introduce btrfs_should_commit_trans() helper
  Now btrfs_should_end_transaction() will also call
  btrfs_should_commit_trans() before returning.

- Commit transaction for subvolume drop if we hits the threshold
- Commit transaction for inode truncation if we hits the threshold

There is some quick benchmarking for it.

The fs is created by the following script:

  for (( j = 0; j < 16; j++ )); do
          btrfs subv create $mnt/src/subvol_$j
          for (( i = 0; i < 512; i++)) ; do
                  xfs_io -f -c "pwrite 0 2k" $mnt/src/subvol_$j/file_inline_$i > /dev/null
                  xfs_io -f -c "pwrite 0 4k" $mnt/src/subvol_$j/file_reg_$i > /dev/null
          done
  done

  sync

  btrfs quota enable $mnt
  btrfs quota rescan -w $mnt
  btrfs sub delete $mnt/src/subvol*

I tried several threshold value, the execution time for
btrfs_qgroup_account_extents() are:

 Threshold	| Number of calls	| Average execution time
------------------------------------------------------------------------
 infinite	| 1			| 770.74ms
 8K		| 3			| 280.47ms
 4K		| 5			| 146.41ms
 2K		| 9 			|  72.36ms
 1K		| 18			|  35.97ms

Currently I choose the 4K as the threshold for its minimal impact on the
number of new transactions to be committed, while still keep the latency
more or less acceptable.

There is another hidden pitfall, if all these extents are mostly shared
between different snapshots, current snapshot/subvolume dropping
mechanism (breadth-first search) makes the lower level leaves to trigger
tons of backref walk, while the higher level tree blocks will only
trigger less and less work load.

Thus this enhancement won't be that obvious to drop such mostly shared
snapshots.
To address that, we need to rework how we drop snapshots/subvolumes, and
it would definitely be another story.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
- The threshold value
  Any immediate number is not flex enough, but I don't have
  better ideas on how to set the value without introducing extra and
  complex on-disk format change.
  This threshold doesn't deserve that large change on on-disk format,
  nor even a mount option.
---
 fs/btrfs/delayed-ref.h | 20 ++++++++++++++++++++
 fs/btrfs/extent-tree.c | 10 +++++++++-
 fs/btrfs/qgroup.c      |  9 ++++++---
 fs/btrfs/transaction.c |  3 +++
 fs/btrfs/transaction.h | 10 ++++++++++
 5 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 1c977e6d45dc..aa516b6a8fa1 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -14,6 +14,23 @@
 #define BTRFS_ADD_DELAYED_EXTENT 3 /* record a full extent allocation */
 #define BTRFS_UPDATE_DELAYED_HEAD 4 /* not changing ref count on head ref */
 
+/*
+ * Soft threshold to commit transaction.
+ *
+ * Since qgroup has to do its accounting at commit transaction time, it can
+ * greatly impact system performance.
+ * Thus for use cases like subvolume drop, we need to throttle the number of
+ * dirty extents in one transaction.
+ *
+ * The fixed 4K number here means we can handle 2K tree block CoWs (32MiB
+ * for 16K nodesize). Or 16M (4K data extemt size) ~ 512G (128M extent size).
+ * And during test, 4K dirty qgroup extents would make
+ * btrfs_qgroup_account_extents() to take around 150ms to excute.
+ *
+ * This 4K is kinda OK for the balanced latency and extent amount.
+ */
+#define BTRFS_QGROUP_DIRTY_EXTENTS_THRESHOLD	(SZ_4K)
+
 struct btrfs_delayed_ref_node {
 	struct rb_node ref_node;
 	/*
@@ -174,6 +191,9 @@ struct btrfs_delayed_ref_root {
 	 * the snapshot in new_root/old_roots or it will get calculated twice
 	 */
 	u64 qgroup_to_skip;
+
+	/* Record how many dirty extents we have in dirty_extent_root */
+	atomic64_t nr_dirty_extents;
 };
 
 enum btrfs_ref_type {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 56ea380f5a17..5a7d7c02c1db 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5539,7 +5539,15 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 				goto out_end_trans;
 			}
 
-			btrfs_end_transaction_throttle(trans);
+			if (btrfs_should_commit_trans(trans)) {
+				ret = btrfs_commit_transaction(trans);
+				if (ret < 0) {
+					err = ret;
+					goto out_end_trans;
+				}
+			} else {
+				btrfs_end_transaction_throttle(trans);
+			}
 			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
 				btrfs_debug(fs_info,
 					    "drop snapshot early exit");
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index bf4b02a40ecc..cff484bf4f80 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1642,6 +1642,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 
 	rb_link_node(&record->node, parent_node, p);
 	rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
+	atomic64_inc(&delayed_refs->nr_dirty_extents);
 	return 0;
 }
 
@@ -2548,17 +2549,17 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct ulist *new_roots = NULL;
 	struct rb_node *node;
-	u64 num_dirty_extents = 0;
+	u64 num_dirty_extents;
 	u64 qgroup_to_skip;
 	int ret = 0;
 
 	delayed_refs = &trans->transaction->delayed_refs;
+	num_dirty_extents = atomic64_read(&delayed_refs->nr_dirty_extents);
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
 	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
 		record = rb_entry(node, struct btrfs_qgroup_extent_record,
 				  node);
 
-		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
 		if (!ret) {
@@ -2607,10 +2608,11 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		new_roots = NULL;
 		rb_erase(node, &delayed_refs->dirty_extent_root);
 		kfree(record);
-
+		atomic64_dec(&delayed_refs->nr_dirty_extents);
 	}
 	trace_qgroup_num_dirty_extents(fs_info, trans->transid,
 				       num_dirty_extents);
+	ASSERT(!atomic64_read(&delayed_refs->nr_dirty_extents));
 	return ret;
 }
 
@@ -4179,4 +4181,5 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 		ulist_free(entry->old_roots);
 		kfree(entry);
 	}
+	atomic64_set(&trans->delayed_refs.nr_dirty_extents, 0);
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b671ea4d80e1..4ebbf16c3113 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -354,6 +354,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	cur_trans->delayed_refs.href_root = RB_ROOT_CACHED;
 	cur_trans->delayed_refs.dirty_extent_root = RB_ROOT;
 	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
+	atomic64_set(&cur_trans->delayed_refs.nr_dirty_extents, 0);
 
 	/*
 	 * although the tree mod log is per file system and not per transaction,
@@ -912,6 +913,8 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_transaction *cur_trans = trans->transaction;
 
+	if (btrfs_should_commit_trans(trans))
+		return 1;
 	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
 	    cur_trans->delayed_refs.flushing)
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 8241c050ba71..e9857182333d 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -197,6 +197,16 @@ static inline void btrfs_clear_skip_qgroup(struct btrfs_trans_handle *trans)
 	delayed_refs->qgroup_to_skip = 0;
 }
 
+static inline bool btrfs_should_commit_trans(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_transaction *cur_trans = trans->transaction;
+
+	if (atomic64_read(&cur_trans->delayed_refs.nr_dirty_extents) >=
+			  BTRFS_QGROUP_DIRTY_EXTENTS_THRESHOLD)
+		return true;
+	return false;
+}
+
 int btrfs_end_transaction(struct btrfs_trans_handle *trans);
 struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 						   unsigned int num_items);
-- 
2.29.2

