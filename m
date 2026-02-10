Return-Path: <linux-btrfs+bounces-21605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPGKFCAoi2m6QQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21605-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 13:44:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEDB11AF83
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 13:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBD5230429A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9B2D0C68;
	Tue, 10 Feb 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo07ybLB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027423D7CF
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727443; cv=none; b=fIAhTFURhPCG/Vv/Gh5wC7+W8+xz2rhupBrdgt7+/OyO2T2Mfo0HZwYuVUdJUmhY+HOBHzFl6NPBtrrXWB1v40QDKOkGkIfPzgb/aSNqwHFkfa59CJny1jSLwxy12KsSUtJ+qYUXHAHp+0DMg1ZV+aiURu/1cQuGvo3gb3of7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727443; c=relaxed/simple;
	bh=JYY94LaFrKyI8Ri/wdOqA7pPKPJSc9nh2ggp6YGKqPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZspjFOIOF0udEJKYXEoa5wnozOCi/sAwtfT5CcLJO4YfN/hQaEkGhsp7/8CfKU24GugjjJ4ELi64L+qppG+S0I00HzE8DfIDR16/76ZLHxKVXuwJRp/m16xUlzCF7is7e+aoceHYb3sMzLNrLEDzberAlAXHb2gb/upPWoQGZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo07ybLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A414C116C6
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770727443;
	bh=JYY94LaFrKyI8Ri/wdOqA7pPKPJSc9nh2ggp6YGKqPw=;
	h=From:To:Subject:Date:From;
	b=Qo07ybLBYQzbiS4EKGyJyU2Q1D3Am2WfzeEjtiMjxgcZsITva/HofCV8+Q3pZl/Qj
	 Pl40xI+J6geLMQAIRbIMzBpM716yH5LF9hAOnkaekf8NUxHmouf0g/9PGD3s2FHjs+
	 wBlqJx8yo58DeZBRSbgWHU6yqfhwdxmIXYayz+NWwio0w1NJu24Q3sSBWvty+KTnRe
	 iryILxuyroCUD1G+FN7IiCrINaao9J2GM27D1xGJsTe9+L8wuErXkCJyEb5NjwyyMg
	 MJePQBZq1VKTP8vPlsCSc6Ee97FlLRjvyEoU1Yk7hLFtKW/CN/RGPW/dcL4Ix5IzqU
	 /InyrkWb6bDBQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: pass literal booleans to functions that take boolean arguments
Date: Tue, 10 Feb 2026 12:44:00 +0000
Message-ID: <f496fae02aeb1d929e4b77525bd578bed8a110f9.1770727364.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21605-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: BEEDB11AF83
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

We have several functions with parameters defined as booleans but then we
have callers passing integers, 0 or 1, instead of false and true. While
this isn't a bug since 0 and 1 are converted to false and true, it is odd
and less readable. Change the callers to pass true and false literals
instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c       |  2 +-
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/file.c        |  4 ++--
 fs/btrfs/inode.c       | 12 ++++++------
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/qgroup.c      |  6 ++----
 fs/btrfs/reflink.c     |  4 ++--
 fs/btrfs/send.c        |  6 +++---
 fs/btrfs/transaction.c | 10 +++++-----
 fs/btrfs/tree-log.c    |  4 ++--
 10 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f2c925e90a87..b9004345cf3c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3887,7 +3887,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 			goto err;
 	}
 
-	ret = split_leaf(trans, root, &key, path, ins_len, 1);
+	ret = split_leaf(trans, root, &key, path, ins_len, true);
 	if (ret)
 		goto err;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index b6c7da8e1bc8..8f8fa14886de 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -697,7 +697,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	/* the disk copy procedure reuses the scrub code */
 	ret = btrfs_scrub_dev(fs_info, src_device->devid, 0,
 			      btrfs_device_get_total_bytes(src_device),
-			      &dev_replace->scrub_progress, 0, 1);
+			      &dev_replace->scrub_progress, false, true);
 
 	ret = btrfs_dev_replace_finishing(fs_info, ret);
 	if (ret == -EINPROGRESS)
@@ -1255,7 +1255,7 @@ static int btrfs_dev_replace_kthread(void *data)
 	ret = btrfs_scrub_dev(fs_info, dev_replace->srcdev->devid,
 			      dev_replace->committed_cursor_left,
 			      btrfs_device_get_total_bytes(dev_replace->srcdev),
-			      &dev_replace->scrub_progress, 0, 1);
+			      &dev_replace->scrub_progress, false, true);
 	ret = btrfs_dev_replace_finishing(fs_info, ret);
 	WARN_ON(ret && ret != -ECANCELED);
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 56ece1109832..4c804f9fc9e8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3315,8 +3315,8 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 			*delalloc_start_ret = start;
 			delalloc_len = btrfs_count_range_bits(&inode->io_tree,
 							      delalloc_start_ret, end,
-							      len, EXTENT_DELALLOC, 1,
-							      cached_state);
+							      len, EXTENT_DELALLOC,
+							      true, cached_state);
 		} else {
 			spin_unlock(&inode->lock);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1cbaaf7a7230..54772ab3b428 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1854,7 +1854,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 */
 	btrfs_lock_extent(io_tree, start, end, &cached_state);
 	count = btrfs_count_range_bits(io_tree, &range_start, end, range_bytes,
-				       EXTENT_NORESERVE, 0, NULL);
+				       EXTENT_NORESERVE, false, NULL);
 	if (count > 0 || is_space_ino || is_reloc_ino) {
 		u64 bytes = count;
 		struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -6839,7 +6839,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		}
 	} else {
 		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-				     0, BTRFS_I(inode)->dir_index);
+				     false, BTRFS_I(inode)->dir_index);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			goto discard;
@@ -7055,7 +7055,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	inode_set_ctime_current(inode);
 
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     &fname.disk_name, 1, index);
+			     &fname.disk_name, true, index);
 	if (ret)
 		goto fail;
 
@@ -8478,14 +8478,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     new_name, 0, old_idx);
+			     new_name, false, old_idx);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(old_dir), BTRFS_I(new_inode),
-			     old_name, 0, new_idx);
+			     old_name, false, new_idx);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
@@ -8776,7 +8776,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     &new_fname.disk_name, 0, index);
+			     &new_fname.disk_name, false, index);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f1b56be6f8f4..38d93dae71ca 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3101,7 +3101,7 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 
 	ret = btrfs_scrub_dev(fs_info, sa->devid, sa->start, sa->end,
 			      &sa->progress, sa->flags & BTRFS_SCRUB_READONLY,
-			      0);
+			      false);
 
 	/*
 	 * Copy scrub args to user space even if btrfs_scrub_dev() returned an
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index aaa47b63ffb1..6a60411dad30 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2740,8 +2740,6 @@ static void qgroup_iterator_nested_clean(struct list_head *head)
 	}
 }
 
-#define UPDATE_NEW	0
-#define UPDATE_OLD	1
 /*
  * Walk all of the roots that points to the bytenr and adjust their refcnts.
  */
@@ -2980,10 +2978,10 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	seq = fs_info->qgroup_seq;
 
 	/* Update old refcnts using old_roots */
-	qgroup_update_refcnt(fs_info, old_roots, &qgroups, seq, UPDATE_OLD);
+	qgroup_update_refcnt(fs_info, old_roots, &qgroups, seq, true);
 
 	/* Update new refcnts using new_roots */
-	qgroup_update_refcnt(fs_info, new_roots, &qgroups, seq, UPDATE_NEW);
+	qgroup_update_refcnt(fs_info, new_roots, &qgroups, seq, false);
 
 	qgroup_update_counters(fs_info, &qgroups, nr_old_roots, nr_new_roots,
 			       num_bytes, seq);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 314cb95ba846..fca00c0f5387 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -646,7 +646,7 @@ static int btrfs_extent_same_range(struct btrfs_inode *src, u64 loff, u64 len,
 	 */
 	btrfs_lock_extent(&dst->io_tree, dst_loff, end, &cached_state);
 	ret = btrfs_clone(&src->vfs_inode, &dst->vfs_inode, loff, len,
-			  ALIGN(len, bs), dst_loff, 1);
+			  ALIGN(len, bs), dst_loff, true);
 	btrfs_unlock_extent(&dst->io_tree, dst_loff, end, &cached_state);
 
 	btrfs_btree_balance_dirty(fs_info);
@@ -747,7 +747,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	 */
 	end = destoff + len - 1;
 	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
-	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
+	ret = btrfs_clone(src, inode, off, olen, len, destoff, false);
 	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 	if (ret < 0)
 		return ret;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3dcfdba018b5..1cb2f4bd9ce1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7201,7 +7201,7 @@ static int changed_cb(struct btrfs_path *left_path,
 	sctx->right_path = right_path;
 	sctx->cmp_key = key;
 
-	ret = finish_inode_if_needed(sctx, 0);
+	ret = finish_inode_if_needed(sctx, false);
 	if (ret < 0)
 		return ret;
 
@@ -7328,7 +7328,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	}
 
 out_finish:
-	return finish_inode_if_needed(sctx, 1);
+	return finish_inode_if_needed(sctx, true);
 }
 
 static int replace_node_with_clone(struct btrfs_path *path, int level)
@@ -7879,7 +7879,7 @@ static int send_subvol(struct send_ctx *sctx)
 		ret = btrfs_compare_trees(sctx->send_root, sctx->parent_root, sctx);
 		if (ret < 0)
 			goto out;
-		ret = finish_inode_if_needed(sctx, 1);
+		ret = finish_inode_if_needed(sctx, true);
 		if (ret < 0)
 			goto out;
 	} else {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 98fb8c515a13..02afd7d72454 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -503,7 +503,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	mutex_lock(&fs_info->reloc_mutex);
-	ret = record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, false);
 	mutex_unlock(&fs_info->reloc_mutex);
 
 	return ret;
@@ -1579,7 +1579,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * recorded root will never be updated again, causing an outdated root
 	 * item.
 	 */
-	ret = record_root_in_trans(trans, src, 1);
+	ret = record_root_in_trans(trans, src, true);
 	if (ret)
 		return ret;
 
@@ -1642,7 +1642,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * Or it won't be committed again onto disk after later
 	 * insert_dir_item()
 	 */
-	return record_root_in_trans(trans, parent, 1);
+	return record_root_in_trans(trans, parent, true);
 }
 
 /*
@@ -1726,7 +1726,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 				      trans->transid,
 				      trans->bytes_reserved, 1);
 	parent_root = parent_inode->root;
-	ret = record_root_in_trans(trans, parent_root, 0);
+	ret = record_root_in_trans(trans, parent_root, false);
 	if (unlikely(ret))
 		goto fail;
 	cur_time = current_time(&parent_inode->vfs_inode);
@@ -1774,7 +1774,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	ret = record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, false);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e9655095ba4c..80fd8575b50c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1711,7 +1711,7 @@ static noinline int add_inode_ref(struct walk_control *wc)
 			}
 
 			/* insert our name */
-			ret = btrfs_add_link(trans, dir, inode, &name, 0, ref_index);
+			ret = btrfs_add_link(trans, dir, inode, &name, false, ref_index);
 			if (ret) {
 				btrfs_abort_log_replay(wc, ret,
 "failed to add link for inode %llu in dir %llu ref_index %llu name %.*s root %llu",
@@ -2059,7 +2059,7 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 		return PTR_ERR(dir);
 	}
 
-	ret = btrfs_add_link(trans, dir, inode, name, 1, index);
+	ret = btrfs_add_link(trans, dir, inode, name, true, index);
 
 	/* FIXME, put inode into FIXUP list */
 
-- 
2.47.2


