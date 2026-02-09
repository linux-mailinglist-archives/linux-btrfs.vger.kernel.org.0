Return-Path: <linux-btrfs+bounces-21542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGXABQLAiWneBQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21542-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 12:07:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E110E82D
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0433C301DAD8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C236C0D0;
	Mon,  9 Feb 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2mBd43v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CB36C0CA
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635236; cv=none; b=J5b55j2MPJuly+0HwWqoELfooBo4YsSdLtDOpLLvZVC/bG4ZZEq9Xh1WXTugSKoEJJcxfaYiKK3tk4ySkS75zJrc//dPRWdgCkcFVAFMfC9UiqDYj5YKxG+pZo/g6uCukGYySzfsGEv7AiEwcROcWDn1DHkbMfXuxt+PAESi/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635236; c=relaxed/simple;
	bh=2z2ddmuD9cnQSM8/0k6F62bqg8rbyyjVzqOrf+5FrMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwIVMwSlBMl+QTLn/zfkc7JLHNV7wYFGHL9M11+8PKpghERLh17XuSg/I3TmDp3cUESab8sl22PbX8JTUxOvNIhBfrtXh3u9J4vYK7W8O3riQqUdTkYUyBPEaspF5gOO9P5owSKx4buqYoc2pfyXJGgUwgwG48MKnWxmXElhZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2mBd43v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05146C116C6
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 11:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770635236;
	bh=2z2ddmuD9cnQSM8/0k6F62bqg8rbyyjVzqOrf+5FrMw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d2mBd43vu9iljt9RFji91bDgUnfKIRrQnNb4YmVaOmEsMmrcx/H83s5iyB6u7QY5z
	 uuRSnu87U6lqreV/0/dBAupRIfAYJ8nZKKTlYoSnNUD0/Y72ZRKmnQfMXEZBxL401u
	 sNxTSIn89xkUgmdd7Gp76h6QKE6Fv61zToPmdRihpJp3mHN0UQixn79pc605N7OAhE
	 nbTnfP8/YAouZYQJisj2/8eiS1G68t+nOl8HeOb+aIGcrpg55KeQyc07t0V8sLrazr
	 E6MTS9MnXaGLevJ+mrGgstFO68lMq/B8xClWmso2WHEGLWqw58t591hu4NKbo4K3S6
	 3ec6IgqTw8pgg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: remove redundant extent_buffer_uptodate() checks after read_tree_block()
Date: Mon,  9 Feb 2026 11:07:11 +0000
Message-ID: <bb5b95740b5ad0d60c53a5ef404982f111fca764.1770634919.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770634919.git.fdmanana@suse.com>
References: <cover.1770634919.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21542-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 9D7E110E82D
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

We have several places that call extent_buffer_uptodate() after reading a
tree block with read_tree_block(), but that is redundant since we already
call extent_buffer_uptodate() in the call chain of read_tree_block():

  read_tree_block()
     btrfs_read_extent_buffer()
        read_extent_buffer_pages()
           returns -EIO if extent_buffer_uptodate() returns false

So remove those redundant checks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c      | 10 ----------
 fs/btrfs/ctree.c        | 13 ++-----------
 fs/btrfs/disk-io.c      | 10 ----------
 fs/btrfs/print-tree.c   |  4 ----
 fs/btrfs/qgroup.c       |  4 ----
 fs/btrfs/relocation.c   |  5 +----
 fs/btrfs/tree-mod-log.c |  8 +++-----
 7 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 7921a926f676..8a119c505e32 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -858,11 +858,6 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
 			free_pref(ref);
 			return PTR_ERR(eb);
 		}
-		if (unlikely(!extent_buffer_uptodate(eb))) {
-			free_pref(ref);
-			free_extent_buffer(eb);
-			return -EIO;
-		}
 
 		if (lock)
 			btrfs_tree_read_lock(eb);
@@ -1620,11 +1615,6 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 					ret = PTR_ERR(eb);
 					goto out;
 				}
-				if (unlikely(!extent_buffer_uptodate(eb))) {
-					free_extent_buffer(eb);
-					ret = -EIO;
-					goto out;
-				}
 
 				if (!path->skip_locking)
 					btrfs_tree_read_lock(eb);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7267b2502665..f2c925e90a87 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -822,7 +822,6 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 {
 	int level = btrfs_header_level(parent);
 	struct btrfs_tree_parent_check check = { 0 };
-	struct extent_buffer *eb;
 
 	if (slot < 0 || slot >= btrfs_header_nritems(parent))
 		return ERR_PTR(-ENOENT);
@@ -835,16 +834,8 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 	check.has_first_key = true;
 	btrfs_node_key_to_cpu(parent, &check.first_key, slot);
 
-	eb = read_tree_block(parent->fs_info, btrfs_node_blockptr(parent, slot),
-			     &check);
-	if (IS_ERR(eb))
-		return eb;
-	if (unlikely(!extent_buffer_uptodate(eb))) {
-		free_extent_buffer(eb);
-		return ERR_PTR(-EIO);
-	}
-
-	return eb;
+	return read_tree_block(parent->fs_info, btrfs_node_blockptr(parent, slot),
+			       &check);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c7b1f779e252..597d78d2dfe1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2024,11 +2024,6 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		btrfs_put_root(log_tree_root);
 		return ret;
 	}
-	if (unlikely(!extent_buffer_uptodate(log_tree_root->node))) {
-		btrfs_err(fs_info, "failed to read log tree");
-		btrfs_put_root(log_tree_root);
-		return -EIO;
-	}
 
 	/* returns with log_tree_root freed on success */
 	ret = btrfs_recover_log_trees(log_tree_root);
@@ -2628,11 +2623,6 @@ static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen, int lev
 		root->node = NULL;
 		return ret;
 	}
-	if (unlikely(!extent_buffer_uptodate(root->node))) {
-		free_extent_buffer(root->node);
-		root->node = NULL;
-		return -EIO;
-	}
 
 	btrfs_set_root_node(&root->root_item, root->node);
 	root->commit_root = btrfs_root_node(root);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index f189bf09ce6a..15f7c0de513f 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -616,10 +616,6 @@ void btrfs_print_tree(const struct extent_buffer *c, bool follow)
 		next = read_tree_block(fs_info, btrfs_node_blockptr(c, i), &check);
 		if (IS_ERR(next))
 			continue;
-		if (!extent_buffer_uptodate(next)) {
-			free_extent_buffer(next);
-			continue;
-		}
 
 		if (btrfs_is_leaf(next) &&
 		   level != 1)
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6030214e413a..aaa47b63ffb1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4884,10 +4884,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		reloc_eb = NULL;
 		goto free_out;
 	}
-	if (unlikely(!extent_buffer_uptodate(reloc_eb))) {
-		ret = -EIO;
-		goto free_out;
-	}
 
 	ret = qgroup_trace_subtree_swap(trans, reloc_eb, subvol_eb,
 			block->last_snapshot, block->trace_leaf);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 64d140bea1fb..1da892af9a44 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2440,10 +2440,7 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
 	eb = read_tree_block(fs_info, block->bytenr, &check);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
-	if (unlikely(!extent_buffer_uptodate(eb))) {
-		free_extent_buffer(eb);
-		return -EIO;
-	}
+
 	if (block->level == 0)
 		btrfs_item_key_to_cpu(eb, &block->key, 0);
 	else
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 9e8cb3b7c064..d9f4bd2c17f1 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -1043,12 +1043,10 @@ struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq)
 		check.owner_root = btrfs_root_id(root);
 
 		old = read_tree_block(fs_info, logical, &check);
-		if (WARN_ON(IS_ERR(old) || !extent_buffer_uptodate(old))) {
-			if (!IS_ERR(old))
-				free_extent_buffer(old);
+		if (WARN_ON(IS_ERR(old))) {
 			btrfs_warn(fs_info,
-				   "failed to read tree block %llu from get_old_root",
-				   logical);
+				   "failed to read tree block %llu from get_old_root: %ld",
+				   logical, PTR_ERR(old));
 		} else {
 			struct tree_mod_elem *tm2;
 
-- 
2.47.2


