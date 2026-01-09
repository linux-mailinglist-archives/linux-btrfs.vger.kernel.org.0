Return-Path: <linux-btrfs+bounces-20343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A37D0B9CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BAD3045393
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10501334C06;
	Fri,  9 Jan 2026 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o27grTiy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o27grTiy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C135B132
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979070; cv=none; b=re48BwasxF72s4LZ+PWIBTrJ0ef59KxYkWcXTRriV9CK5hE8l4AH9tIa+u6Kpu3/DNNvoAduCvx44CcFMGVUjLosjVVzkDzfxWSQcrkcXseZLDKYpiz+mCAI9HH7NPC9nUEvrLVZQ6vXyiPSd2Uq13MIwORho/TRFl4dyKFoyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979070; c=relaxed/simple;
	bh=A9VdY2i3mpS0aptQSVcLOE6H1Luw7aa25xpkXF12INw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLFLtWat255WIKQyQ/g328t7dE9gdGnkll16fIb3B8hG1oLgqzsINqXmcWozIQ71t1B34QEnlvQBJbc5baOEh4N9u5Qh6WTnVbGMWUF3d+eN8tyuvC0iOe3AxgsdGTNz0nBRirO8GEgeKz4/9GMZUCCH4QPKH8pOneZDi/Fb8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o27grTiy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o27grTiy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16E5C33B14;
	Fri,  9 Jan 2026 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zH9G0PODu480eWp+pUR2QTgJLl6qH5rNNwUqquvsgY=;
	b=o27grTiyb96HkKb1AV4PfGr7rWoxudCCXRPvX42MSDMa7fkxyQC5IllrPE5hfnY7sUVzLh
	qQbGgsNk+uSuDLsI4KAbmjpW2ZCkJG5KWW1KKc6EohX7dNiU3swn0QWeOA1r8dKbGkocwB
	SIjbGuHGzAECM/HqHERkhScQnpyBio0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=o27grTiy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zH9G0PODu480eWp+pUR2QTgJLl6qH5rNNwUqquvsgY=;
	b=o27grTiyb96HkKb1AV4PfGr7rWoxudCCXRPvX42MSDMa7fkxyQC5IllrPE5hfnY7sUVzLh
	qQbGgsNk+uSuDLsI4KAbmjpW2ZCkJG5KWW1KKc6EohX7dNiU3swn0QWeOA1r8dKbGkocwB
	SIjbGuHGzAECM/HqHERkhScQnpyBio0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F5B53EA63;
	Fri,  9 Jan 2026 17:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CZC9Azs4YWkYVAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 09 Jan 2026 17:17:47 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: embed delayed root to struct btrfs_fs_info
Date: Fri,  9 Jan 2026 18:17:40 +0100
Message-ID: <e62a36ade59420669ac73c6628474f580c49ebb4.1767979013.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767979013.git.dsterba@suse.com>
References: <cover.1767979013.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 16E5C33B14
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

The fs_info::delayed_root is allocated dynamically but there's only one
instance per filesystem so we can embed it into the fs_info itself. The
size grows from 3880 to 3952 on release config, i.e. still under 4K.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 24 ++++++++++++------------
 fs/btrfs/delayed-inode.h | 15 ---------------
 fs/btrfs/disk-io.c       |  8 ++------
 fs/btrfs/fs.h            | 18 ++++++++++++++++--
 4 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 2286bee2c6d3a8..a752646257dff3 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -257,7 +257,7 @@ static struct btrfs_delayed_node *btrfs_next_delayed_node(
 	struct list_head *p;
 	struct btrfs_delayed_node *next = NULL;
 
-	delayed_root = node->root->fs_info->delayed_root;
+	delayed_root = &node->root->fs_info->delayed_root;
 	spin_lock(&delayed_root->lock);
 	if (!test_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags)) {
 		/* not in the list */
@@ -287,7 +287,7 @@ static void __btrfs_release_delayed_node(
 	if (!delayed_node)
 		return;
 
-	delayed_root = delayed_node->root->fs_info->delayed_root;
+	delayed_root = &delayed_node->root->fs_info->delayed_root;
 
 	mutex_lock(&delayed_node->mutex);
 	if (delayed_node->count)
@@ -425,7 +425,7 @@ static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 		delayed_node->index_cnt = ins->index + 1;
 
 	delayed_node->count++;
-	atomic_inc(&delayed_node->root->fs_info->delayed_root->items);
+	atomic_inc(&delayed_node->root->fs_info->delayed_root.items);
 	return 0;
 }
 
@@ -452,7 +452,7 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	/* If it's in a rbtree, then we need to have delayed node locked. */
 	lockdep_assert_held(&delayed_node->mutex);
 
-	delayed_root = delayed_node->root->fs_info->delayed_root;
+	delayed_root = &delayed_node->root->fs_info->delayed_root;
 
 	if (delayed_item->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
@@ -988,7 +988,7 @@ static void btrfs_release_delayed_inode(struct btrfs_delayed_node *delayed_node)
 		clear_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 		delayed_node->count--;
 
-		delayed_root = delayed_node->root->fs_info->delayed_root;
+		delayed_root = &delayed_node->root->fs_info->delayed_root;
 		finish_one_item(delayed_root);
 	}
 }
@@ -1002,7 +1002,7 @@ static void btrfs_release_delayed_iref(struct btrfs_delayed_node *delayed_node)
 		ASSERT(delayed_node->root);
 		delayed_node->count--;
 
-		delayed_root = delayed_node->root->fs_info->delayed_root;
+		delayed_root = &delayed_node->root->fs_info->delayed_root;
 		finish_one_item(delayed_root);
 	}
 }
@@ -1168,7 +1168,7 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	block_rsv = trans->block_rsv;
 	trans->block_rsv = &fs_info->delayed_block_rsv;
 
-	delayed_root = fs_info->delayed_root;
+	delayed_root = &fs_info->delayed_root;
 
 	curr_node = btrfs_first_delayed_node(delayed_root, &curr_delayed_node_tracker);
 	while (curr_node && (!count || nr--)) {
@@ -1417,7 +1417,7 @@ void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 	struct btrfs_ref_tracker delayed_node_tracker;
 	struct btrfs_delayed_node *node;
 
-	node = btrfs_first_delayed_node( fs_info->delayed_root, &delayed_node_tracker);
+	node = btrfs_first_delayed_node(&fs_info->delayed_root, &delayed_node_tracker);
 	if (WARN_ON(node)) {
 		btrfs_delayed_node_ref_tracker_free(node,
 						    &delayed_node_tracker);
@@ -1440,7 +1440,7 @@ static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
 
 void btrfs_balance_delayed_items(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_delayed_root *delayed_root = fs_info->delayed_root;
+	struct btrfs_delayed_root *delayed_root = &fs_info->delayed_root;
 
 	if ((atomic_read(&delayed_root->items) < BTRFS_DELAYED_BACKGROUND) ||
 		btrfs_workqueue_normal_congested(fs_info->delayed_workers))
@@ -1970,7 +1970,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 	fill_stack_inode_item(trans, &delayed_node->inode_item, inode);
 	set_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 	delayed_node->count++;
-	atomic_inc(&root->fs_info->delayed_root->items);
+	atomic_inc(&root->fs_info->delayed_root.items);
 release_node:
 	mutex_unlock(&delayed_node->mutex);
 	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
@@ -2012,7 +2012,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 	mutex_lock(&delayed_node->mutex);
 	if (!test_and_set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags)) {
 		delayed_node->count++;
-		atomic_inc(&fs_info->delayed_root->items);
+		atomic_inc(&fs_info->delayed_root.items);
 	}
 	mutex_unlock(&delayed_node->mutex);
 	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
@@ -2118,7 +2118,7 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
 	struct btrfs_delayed_node *curr_node, *prev_node;
 	struct btrfs_ref_tracker curr_delayed_node_tracker, prev_delayed_node_tracker;
 
-	curr_node = btrfs_first_delayed_node(fs_info->delayed_root,
+	curr_node = btrfs_first_delayed_node(&fs_info->delayed_root,
 					     &curr_delayed_node_tracker);
 	while (curr_node) {
 		__btrfs_kill_delayed_node(curr_node);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index b09d4ec8c77dde..fc752863f89bcd 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -30,21 +30,6 @@ enum btrfs_delayed_item_type {
 	BTRFS_DELAYED_DELETION_ITEM
 };
 
-struct btrfs_delayed_root {
-	spinlock_t lock;
-	struct list_head node_list;
-	/*
-	 * Used for delayed nodes which is waiting to be dealt with by the
-	 * worker. If the delayed node is inserted into the work queue, we
-	 * drop it from this list.
-	 */
-	struct list_head prepare_list;
-	atomic_t items;		/* for delayed items */
-	atomic_t items_seq;	/* for delayed items */
-	int nodes;		/* for delayed nodes */
-	wait_queue_head_t wait;
-};
-
 struct btrfs_ref_tracker_dir {
 #ifdef CONFIG_BTRFS_DEBUG
 	struct ref_tracker_dir dir;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cecb81d0f9e0c6..52ebb4eefe6362 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -22,6 +22,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
+#include "delayed-inode.h"
 #include "bio.h"
 #include "print-tree.h"
 #include "locking.h"
@@ -1237,7 +1238,6 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
-	kfree(fs_info->delayed_root);
 	free_global_roots(fs_info);
 	btrfs_put_root(fs_info->tree_root);
 	btrfs_put_root(fs_info->chunk_root);
@@ -2889,11 +2889,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	if (ret)
 		return ret;
 
-	fs_info->delayed_root = kmalloc(sizeof(struct btrfs_delayed_root),
-					GFP_KERNEL);
-	if (!fs_info->delayed_root)
-		return -ENOMEM;
-	btrfs_init_delayed_root(fs_info->delayed_root);
+	btrfs_init_delayed_root(&fs_info->delayed_root);
 
 	if (sb_rdonly(sb))
 		set_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0dc851b9c51bc2..dd4944f9a98553 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -44,7 +44,6 @@ struct btrfs_block_group;
 struct btrfs_root;
 struct btrfs_fs_devices;
 struct btrfs_transaction;
-struct btrfs_delayed_root;
 struct btrfs_balance_control;
 struct btrfs_subpage_info;
 struct btrfs_stripe_hash_table;
@@ -455,6 +454,21 @@ struct btrfs_commit_stats {
 	u64 critical_section_start_time;
 };
 
+struct btrfs_delayed_root {
+	spinlock_t lock;
+	struct list_head node_list;
+	/*
+	 * Used for delayed nodes which is waiting to be dealt with by the
+	 * worker. If the delayed node is inserted into the work queue, we
+	 * drop it from this list.
+	 */
+	struct list_head prepare_list;
+	atomic_t items;		/* for delayed items */
+	atomic_t items_seq;	/* for delayed items */
+	int nodes;		/* for delayed nodes */
+	wait_queue_head_t wait;
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -804,7 +818,7 @@ struct btrfs_fs_info {
 	/* Filesystem state */
 	unsigned long fs_state;
 
-	struct btrfs_delayed_root *delayed_root;
+	struct btrfs_delayed_root delayed_root;
 
 	/* Entries are eb->start >> nodesize_bits */
 	struct xarray buffer_tree;
-- 
2.51.1


