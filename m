Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C506C3005
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCULPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCULOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28723129
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A5261B16
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED657C4339C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397256;
        bh=vojGQL3BFYgRmrlC6eu+8Wf+TbDiHX8KzQiEPpoQrvM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DktwGReAJ0cGUIZqq6QYpYXpMhCnPdyCMkweJ6XPIDa/vZuyo1uv9W06QeaTdI827
         1NPjmai8BorHTBNL30U0aPTpOS4ojHDJ6G2FLJF9+1FPv1MjLnpAtW6LzplUcT+Uqr
         lTP4Wx9yMPQk3gP/qBAntrI7U1W+04jK9OrYIO3mscI8nYs3eGfP5faqz2qk7B3k6u
         kdfwQEY2ylUGQZ1KfTmcpZ2dSj5Yw3kqgGPReRiSdhDr8NNhBgHWJryEI4fhZ9gGUT
         z7nFcoBjvyeBoVtRjY5EgT7qjli+V+2PRLlh2cNgSKDDal4k64I69XEKyxHsPFHXE0
         XsnqxUKosBbGw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/24] btrfs: remove obsolete delayed ref throttling logic when truncating items
Date:   Tue, 21 Mar 2023 11:13:49 +0000
Message-Id: <851e11f4716ee1cd6284634533e8e9bbc1b52a1d.1679326433.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have this logic encapsulated in btrfs_should_throttle_delayed_refs()
where we try to estimate if running the current amount of delayed
references we have will take more than half a second, and if so, the
caller btrfs_should_throttle_delayed_refs() should do something to
prevent more and more delayed refs from being accumulated.

This logic was added in commit 0a2b2a844af6 ("Btrfs: throttle delayed
refs better") and then further refined in commit a79b7d4b3e81 ("Btrfs:
async delayed refs"). The idea back then was that the caller of
btrfs_should_throttle_delayed_refs() would release its transaction
handle (by calling btrfs_end_transaction()) when that function returned
true, then btrfs_end_transaction() would trigger an async job to run
delayed references in a workqueue, and later start/join a transaction
again and do more work.

However we don't run delayed references asynchronously anymore, that
was removed in commit db2462a6ad3d ("btrfs: don't run delayed refs in
the end transaction logic"). That makes the logic that tries to estimate
how long we will take to run our current delayed references, at
btrfs_should_throttle_delayed_refs(), pointless as we don't take any
action to run delayed references anymore. We do have other type of
throttling, which consists of checking the size and reserved space of
the delayed and global block reserves, as well as if fluhsing delayed
references for the current transaction was already started, etc - this
is all done by btrfs_should_end_transaction(), and the only user of
btrfs_should_throttle_delayed_refs() does periodically call
btrfs_should_end_transaction().

So remove btrfs_should_throttle_delayed_refs() and the infrastructure
that keeps track of the average time used for running delayed references,
as well as adapting btrfs_truncate_inode_items() to call
btrfs_check_space_for_delayed_refs() instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 16 ----------------
 fs/btrfs/delayed-ref.h |  1 -
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/extent-tree.c | 27 ++-------------------------
 fs/btrfs/fs.h          |  1 -
 fs/btrfs/inode-item.c  | 12 +++++-------
 6 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 3fdee91d8079..bf2ce51e5086 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -53,22 +53,6 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
-{
-	u64 num_entries =
-		atomic_read(&trans->transaction->delayed_refs.num_entries);
-	u64 avg_runtime;
-	u64 val;
-
-	smp_mb();
-	avg_runtime = trans->fs_info->avg_delayed_ref_runtime;
-	val = num_entries * avg_runtime;
-	if (val >= NSEC_PER_SEC / 2)
-		return true;
-
-	return btrfs_check_space_for_delayed_refs(trans->fs_info);
-}
-
 /*
  * Release a ref head's reservation.
  *
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 316fed159d49..6cf1adc9a01a 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -385,7 +385,6 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *src,
 				       u64 num_bytes);
-bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bb864cf2eed6..b638e27468a7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2951,7 +2951,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	atomic64_set(&fs_info->free_chunk_space, 0);
 	fs_info->tree_mod_log = RB_ROOT;
 	fs_info->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
-	fs_info->avg_delayed_ref_runtime = NSEC_PER_SEC >> 6; /* div by 64 */
 	btrfs_init_ref_verify(fs_info);
 
 	fs_info->thread_pool_size = min_t(unsigned long,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6b6c59e6805c..5cd289de4e92 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1894,8 +1894,7 @@ static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
 }
 
 static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
-				    struct btrfs_delayed_ref_head *locked_ref,
-				    unsigned long *run_refs)
+					   struct btrfs_delayed_ref_head *locked_ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -1917,7 +1916,6 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 			return -EAGAIN;
 		}
 
-		(*run_refs)++;
 		ref->in_tree = 0;
 		rb_erase_cached(&ref->ref_node, &locked_ref->ref_tree);
 		RB_CLEAR_NODE(&ref->ref_node);
@@ -1981,10 +1979,8 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_head *locked_ref = NULL;
-	ktime_t start = ktime_get();
 	int ret;
 	unsigned long count = 0;
-	unsigned long actual_count = 0;
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	do {
@@ -2014,8 +2010,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		spin_lock(&locked_ref->lock);
 		btrfs_merge_delayed_refs(fs_info, delayed_refs, locked_ref);
 
-		ret = btrfs_run_delayed_refs_for_head(trans, locked_ref,
-						      &actual_count);
+		ret = btrfs_run_delayed_refs_for_head(trans, locked_ref);
 		if (ret < 0 && ret != -EAGAIN) {
 			/*
 			 * Error, btrfs_run_delayed_refs_for_head already
@@ -2046,24 +2041,6 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		cond_resched();
 	} while ((nr != -1 && count < nr) || locked_ref);
 
-	/*
-	 * We don't want to include ref heads since we can have empty ref heads
-	 * and those will drastically skew our runtime down since we just do
-	 * accounting, no actual extent tree updates.
-	 */
-	if (actual_count > 0) {
-		u64 runtime = ktime_to_ns(ktime_sub(ktime_get(), start));
-		u64 avg;
-
-		/*
-		 * We weigh the current average higher than our current runtime
-		 * to avoid large swings in the average.
-		 */
-		spin_lock(&delayed_refs->lock);
-		avg = fs_info->avg_delayed_ref_runtime * 3 + runtime;
-		fs_info->avg_delayed_ref_runtime = avg >> 2;	/* div by 4 */
-		spin_unlock(&delayed_refs->lock);
-	}
 	return 0;
 }
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index abe5b3475a9d..492436e1a59e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -407,7 +407,6 @@ struct btrfs_fs_info {
 	 * Must be written and read while holding btrfs_fs_info::commit_root_sem.
 	 */
 	u64 last_reloc_trans;
-	u64 avg_delayed_ref_runtime;
 
 	/*
 	 * This is updated to the current trans every time a full commit is
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b27c2c560083..4c322b720a80 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -527,7 +527,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 	while (1) {
 		u64 clear_start = 0, clear_len = 0, extent_start = 0;
-		bool should_throttle = false;
+		bool refill_delayed_refs_rsv = false;
 
 		fi = NULL;
 		leaf = path->nodes[0];
@@ -685,10 +685,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
-			if (be_nice) {
-				if (btrfs_should_throttle_delayed_refs(trans))
-					should_throttle = true;
-			}
+			if (be_nice && btrfs_check_space_for_delayed_refs(fs_info))
+				refill_delayed_refs_rsv = true;
 		}
 
 		if (found_type == BTRFS_INODE_ITEM_KEY)
@@ -696,7 +694,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 		if (path->slots[0] == 0 ||
 		    path->slots[0] != pending_del_slot ||
-		    should_throttle) {
+		    refill_delayed_refs_rsv) {
 			if (pending_del_nr) {
 				ret = btrfs_del_items(trans, root, path,
 						pending_del_slot,
@@ -719,7 +717,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			 * actually allocate, so just bail if we're short and
 			 * let the normal reservation dance happen higher up.
 			 */
-			if (should_throttle) {
+			if (refill_delayed_refs_rsv) {
 				ret = btrfs_delayed_refs_rsv_refill(fs_info,
 							BTRFS_RESERVE_NO_FLUSH);
 				if (ret) {
-- 
2.34.1

