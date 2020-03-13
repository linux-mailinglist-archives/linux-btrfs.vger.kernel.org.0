Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7973185106
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCMVYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:24:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33502 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgCMVXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id p62so15185193qkb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8ElM2dajH4z4UD5RegL4lZbes7mgXqJzBjC81uhGlOc=;
        b=F52SsnkA0vMfqPGaEF7SzAWcH4geej5dks6K9sAptGH09B3LR6C4LCQU0o2O28kuio
         BmZdmmE0mwkybsg7mhgc74F8jmoT9bgsmx4cFo4eeHcBX+M5OhJfsZcNVzrJTNJIfCEm
         nkOtgiABfic+8QxHpTQelKcY0YjuwXh+dr7gUB+lIc34D9qO9hANvl6TOlOGJd1gRAXJ
         iCVAigiE8Yv6/0fnUrLR9Nfg62Rsy/Bt1LGYGvdraRqwoP73YsnY2ZbifcYmrKMYilMZ
         GOETHKrEDwlicIbXRzLzL8YP4N7ggQUANETAwPHPoSlJmH7OD2yi89tr2iCHmsGPCgus
         ZYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ElM2dajH4z4UD5RegL4lZbes7mgXqJzBjC81uhGlOc=;
        b=jUGTlpkFwP2f/8ZeSaOTUZaMG2boL+/AcqOqA9htBzuhqH63GZXT9xT3KEeUbyAZPj
         egtjltkggCF6vcetBjDmRvFeOiyVm4kLu5g2r86W3nmE9Dn1bKOzQHRmLIOgvPY1N7Ve
         v92hBj2uTFXMF9Fp9GvLHXWi0CPzpjs2bpqTGZC+3ktnpeXB0liwUwpqYCIxw4n+LWLb
         qyAY4WV1jMcUHlXZ8d0X5ftRVmCaVqo2U3soDAZ7hZsSI9XXfSirkscict1e+wdQkXxv
         FAmA8XMPVuSx2ttfXX3PaJvZkKePFFjU2GmsEK0TylWDKEa2PGpIw/HZChTUQMtP0+db
         yQhA==
X-Gm-Message-State: ANhLgQ0Njr1kDFLO3EXazv9a6+LW/RdaMiU1VICH5MRpSTOlChs53cae
        b1KAze3pA4oQULPpYYOlRixS+YSRbuRsxQ==
X-Google-Smtp-Source: ADFU+vtM9AGPpKAx3M1TeJQGJnVm6wO0gTQ2qYWjCD93FKRQsblq6MmjfKt0D/TbnG9kJOW2tIdKhg==
X-Received: by 2002:a37:8e45:: with SMTP id q66mr15409154qkd.129.1584134628803;
        Fri, 13 Mar 2020 14:23:48 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h47sm12200706qtb.75.2020.03.13.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/13] btrfs: throttle delayed refs based on time
Date:   Fri, 13 Mar 2020 17:23:26 -0400
Message-Id: <20200313212330.149024-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to make sure we don't generate so many delayed refs that the box
gets overwhelmed at commit time.  Keep a sequence number of the number
of entries run, and if we need to be throttled based on our time
constraints wait for the number of delayed refs we added to be run once
we end our transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c |  6 ++++--
 fs/btrfs/delayed-ref.h | 14 ++++++++++++
 fs/btrfs/extent-tree.c |  4 +++-
 fs/btrfs/transaction.c | 49 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/transaction.h | 16 ++++++++++++++
 5 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e709f051320a..e2f40a449d85 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -424,7 +424,7 @@ static inline void drop_delayed_ref(struct btrfs_trans_handle *trans,
 		list_del(&ref->add_list);
 	ref->in_tree = 0;
 	btrfs_put_delayed_ref(ref);
-	atomic_dec(&delayed_refs->num_entries);
+	btrfs_dec_delayed_ref_entries(delayed_refs);
 }
 
 static bool merge_ref(struct btrfs_trans_handle *trans,
@@ -580,7 +580,7 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 
 	rb_erase_cached(&head->href_node, &delayed_refs->href_root);
 	RB_CLEAR_NODE(&head->href_node);
-	atomic_dec(&delayed_refs->num_entries);
+	btrfs_dec_delayed_ref_entries(delayed_refs);
 	delayed_refs->num_heads--;
 	if (head->processing == 0)
 		delayed_refs->num_heads_ready--;
@@ -639,6 +639,7 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
 	if (ref->action == BTRFS_ADD_DELAYED_REF)
 		list_add_tail(&ref->add_list, &href->ref_add_list);
 	atomic_inc(&root->num_entries);
+	trans->total_delayed_refs++;
 	spin_unlock(&href->lock);
 	return ret;
 }
@@ -843,6 +844,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		delayed_refs->num_heads_ready++;
 		atomic_inc(&delayed_refs->num_entries);
 		trans->delayed_ref_updates++;
+		trans->total_delayed_refs++;
 	}
 	if (qrecord_inserted_ret)
 		*qrecord_inserted_ret = qrecord_inserted;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 3ea3a1627d26..16cf0af91464 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -150,6 +150,13 @@ struct btrfs_delayed_ref_root {
 	 */
 	atomic_t num_entries;
 
+	/*
+	 * How many entries we've run, and a corresponding waitqueue so that we
+	 * can throttle generators appropriately.
+	 */
+	atomic_t entries_run;
+	wait_queue_head_t wait;
+
 	/* total number of head nodes in tree */
 	unsigned long num_heads;
 
@@ -391,4 +398,11 @@ btrfs_delayed_node_to_data_ref(struct btrfs_delayed_ref_node *node)
 	return container_of(node, struct btrfs_delayed_data_ref, node);
 }
 
+static inline void
+btrfs_dec_delayed_ref_entries(struct btrfs_delayed_ref_root *delayed_refs)
+{
+	atomic_dec(&delayed_refs->num_entries);
+	atomic_inc(&delayed_refs->entries_run);
+	wake_up(&delayed_refs->wait);
+}
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b9b96e4db65f..e490ce994d1d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1958,7 +1958,6 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		default:
 			WARN_ON(1);
 		}
-		atomic_dec(&delayed_refs->num_entries);
 
 		/*
 		 * Record the must_insert_reserved flag before we drop the
@@ -1974,6 +1973,9 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		ret = run_one_delayed_ref(trans, ref, extent_op,
 					  must_insert_reserved);
 
+		/* Anybody who's been throttled may be woken up here. */
+		btrfs_dec_delayed_ref_entries(delayed_refs);
+
 		btrfs_free_delayed_extent_op(extent_op);
 		if (ret) {
 			unselect_delayed_ref_head(delayed_refs, locked_ref);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index cf8fab22782f..ac77a2b805fa 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -307,6 +307,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	cur_trans->delayed_refs.href_root = RB_ROOT_CACHED;
 	cur_trans->delayed_refs.dirty_extent_root = RB_ROOT;
 	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
+	atomic_set(&cur_trans->delayed_refs.entries_run, 0);
+	init_waitqueue_head(&cur_trans->delayed_refs.wait);
 
 	/*
 	 * although the tree mod log is per file system and not per transaction,
@@ -893,13 +895,29 @@ static void btrfs_trans_release_metadata(struct btrfs_trans_handle *trans)
 	trans->bytes_reserved = 0;
 }
 
+static void noinline
+btrfs_throttle_for_delayed_refs(struct btrfs_fs_info *fs_info,
+				struct btrfs_delayed_ref_root *delayed_refs,
+				unsigned long refs, bool throttle)
+{
+	unsigned long threshold = max(refs, 1UL) +
+		atomic_read(&delayed_refs->entries_run);
+	wait_event_interruptible(delayed_refs->wait,
+		 (atomic_read(&delayed_refs->entries_run) >= threshold) ||
+		 !btrfs_should_throttle_delayed_refs(fs_info, delayed_refs,
+						     throttle));
+}
+
 static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 				   int throttle)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_transaction *cur_trans = trans->transaction;
+	unsigned long total_delayed_refs;
+	unsigned int trans_type = trans->type;
 	int err = 0;
 	bool run_async = false;
+	bool throttle_delayed_refs = false;
 
 	if (refcount_read(&trans->use_count) > 1) {
 		refcount_dec(&trans->use_count);
@@ -907,9 +925,23 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 		return 0;
 	}
 
+	/*
+	 * If we are over our threshold for our specified throttle then we need
+	 * to throttle ourselves, because the async flusher is not keeping up.
+	 *
+	 * However if we're just over the async threshold simply kick the async
+	 * flusher.
+	 */
 	if (btrfs_should_throttle_delayed_refs(info,
-					       &cur_trans->delayed_refs, true))
+					       &cur_trans->delayed_refs,
+					       throttle)) {
 		run_async = true;
+		throttle_delayed_refs = true;
+	} else if (btrfs_should_throttle_delayed_refs(info,
+						      &cur_trans->delayed_refs,
+						      true)) {
+		run_async = true;
+	}
 
 	btrfs_trans_release_metadata(trans);
 	trans->block_rsv = NULL;
@@ -918,7 +950,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 
 	btrfs_trans_release_chunk_metadata(trans);
 
-	if (trans->type & __TRANS_FREEZABLE)
+	if (trans_type & __TRANS_FREEZABLE)
 		sb_end_intwrite(info->sb);
 
 	WARN_ON(cur_trans != info->running_transaction);
@@ -927,7 +959,6 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	extwriter_counter_dec(cur_trans, trans->type);
 
 	cond_wake_up(&cur_trans->writer_wait);
-	btrfs_put_transaction(cur_trans);
 
 	if (current->journal_info == trans)
 		current->journal_info = NULL;
@@ -935,6 +966,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	if (throttle)
 		btrfs_run_delayed_iputs(info);
 
+	total_delayed_refs = trans->total_delayed_refs;
 	if (TRANS_ABORTED(trans) ||
 	    test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
 		wake_up_process(info->transaction_kthread);
@@ -946,6 +978,17 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 			   &info->async_delayed_ref_work);
 
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
+
+	/*
+	 * We only want to throttle generators, so btrfs_transaction_start
+	 * callers.
+	 */
+	if (throttle_delayed_refs && total_delayed_refs &&
+	    (trans_type & __TRANS_START))
+		btrfs_throttle_for_delayed_refs(info, &cur_trans->delayed_refs,
+						total_delayed_refs, throttle);
+	btrfs_put_transaction(cur_trans);
+
 	return err;
 }
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 453cea7c7a72..2ec10978fa2a 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -109,7 +109,23 @@ struct btrfs_trans_handle {
 	u64 transid;
 	u64 bytes_reserved;
 	u64 chunk_bytes_reserved;
+
+	/*
+	 * This tracks the number of items required for the delayed ref rsv, and
+	 * is used by that code.  The accounting is
+	 *
+	 * - 1 per delayed ref head (individual items are not counted).
+	 * - number of csum items that would be inserted for data.
+	 * - block group item updates.
+	 */
 	unsigned long delayed_ref_updates;
+
+	/*
+	 * This is the total number of delayed items that we added for this
+	 * trans handle, this is used for the end transaction throttling code.
+	 */
+	unsigned long total_delayed_refs;
+
 	struct btrfs_transaction *transaction;
 	struct btrfs_block_rsv *block_rsv;
 	struct btrfs_block_rsv *orig_rsv;
-- 
2.24.1

