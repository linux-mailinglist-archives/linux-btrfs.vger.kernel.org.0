Return-Path: <linux-btrfs+bounces-20345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E5D0B951
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA0413039848
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B635B132;
	Fri,  9 Jan 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CiJk/7vp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mOB/Udsy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2693154BE2
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979081; cv=none; b=msGmIcqEAQynR1c2GCH8m6DGW2T3/6d1MNWy6ICr530d3of8EyXbU8zuTiE8JiNc7Vk2QNWVms91/HmAHReieaSE7AuAbTT9HWVpvv3ndrwR3RhhP/L7LIRl5AGFrMASjx+QzqNAHeMdtNzNYik6NZmcKQkP0YFo8kk5S1Wms9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979081; c=relaxed/simple;
	bh=3qmBQShx4+lQnqtxa8Emb7CvAQIt9i042wUxAkXxyeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkonfO++vNDHZUm9gwyiWqJ0JGGy83DS6Xbky2Mk3usNSsyTfGkq4eU0hpr3okjhi3rMOhhIP5zEo7yoGZpb1nQkG1nQ38qtNtHSIObIoAGyqyoWUXGHE7dfgMgDK+H9o0L4Q3ht3+/DEc3axYJZO7Y75AsEKakjRhFXLdwTBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CiJk/7vp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mOB/Udsy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F1605BFF0;
	Fri,  9 Jan 2026 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xbtK6SfTbLgyZBZQP3bSpWQTHQxyWJEB4JFH5hsdHM=;
	b=CiJk/7vp+10ooAS4171xzx1odfvZt8O6DW5Xdsdx8JWRhbWry3aL3hF7cRFq12vtOK/JQZ
	hevlgAZFBDLF78hrWgDjanwL0lezZuPtT3qw7vizD40DhqvTefN7oMDF4GfpdEgITb0v3W
	2V3O/JyS6UXFZ6TIs1AOl0mLRmLDVSA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="mOB/Udsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xbtK6SfTbLgyZBZQP3bSpWQTHQxyWJEB4JFH5hsdHM=;
	b=mOB/UdsyNAcUAayNArJ+F6gsZjLG4gRPxJN6Ruwv2LQz+yRJGHGGLOnsdSI9Giegt7iPiJ
	+fBDNIoNdP3rRO+2R3UG5dwnwwvuL3KgrxptjFItulxT3TDdolwcqoTaiwLAynR23v2Txp
	/Sjf5jbQjMERMLp5PQatdjy7ftp9xGU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8891B3EA63;
	Fri,  9 Jan 2026 17:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JOFVIUI4YWknVAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 09 Jan 2026 17:17:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: don't use local variables for fs_info->delayed_root
Date: Fri,  9 Jan 2026 18:17:42 +0100
Message-ID: <dffaacffee389d8f36557516b36dfb3583f4c5cb.1767979013.git.dsterba@suse.com>
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
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8F1605BFF0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

In all cases the delayed_root is used once in a function, we don't need
to use a local variable for that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index a752646257dff3..fc5926ecc762ff 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -443,7 +443,6 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 {
 	struct btrfs_delayed_node *delayed_node = delayed_item->delayed_node;
 	struct rb_root_cached *root;
-	struct btrfs_delayed_root *delayed_root;
 
 	/* Not inserted, ignore it. */
 	if (RB_EMPTY_NODE(&delayed_item->rb_node))
@@ -452,8 +451,6 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	/* If it's in a rbtree, then we need to have delayed node locked. */
 	lockdep_assert_held(&delayed_node->mutex);
 
-	delayed_root = &delayed_node->root->fs_info->delayed_root;
-
 	if (delayed_item->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
 	else
@@ -462,8 +459,7 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	rb_erase_cached(&delayed_item->rb_node, root);
 	RB_CLEAR_NODE(&delayed_item->rb_node);
 	delayed_node->count--;
-
-	finish_one_item(delayed_root);
+	finish_one_item(&delayed_node->root->fs_info->delayed_root);
 }
 
 static void btrfs_release_delayed_item(struct btrfs_delayed_item *item)
@@ -980,30 +976,21 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 
 static void btrfs_release_delayed_inode(struct btrfs_delayed_node *delayed_node)
 {
-	struct btrfs_delayed_root *delayed_root;
-
 	if (delayed_node &&
 	    test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
 		ASSERT(delayed_node->root);
 		clear_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 		delayed_node->count--;
-
-		delayed_root = &delayed_node->root->fs_info->delayed_root;
-		finish_one_item(delayed_root);
+		finish_one_item(&delayed_node->root->fs_info->delayed_root);
 	}
 }
 
 static void btrfs_release_delayed_iref(struct btrfs_delayed_node *delayed_node)
 {
-
 	if (test_and_clear_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags)) {
-		struct btrfs_delayed_root *delayed_root;
-
 		ASSERT(delayed_node->root);
 		delayed_node->count--;
-
-		delayed_root = &delayed_node->root->fs_info->delayed_root;
-		finish_one_item(delayed_root);
+		finish_one_item(&delayed_node->root->fs_info->delayed_root);
 	}
 }
 
@@ -1150,7 +1137,6 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_delayed_root *delayed_root;
 	struct btrfs_delayed_node *curr_node, *prev_node;
 	struct btrfs_ref_tracker curr_delayed_node_tracker, prev_delayed_node_tracker;
 	struct btrfs_path *path;
@@ -1168,9 +1154,7 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	block_rsv = trans->block_rsv;
 	trans->block_rsv = &fs_info->delayed_block_rsv;
 
-	delayed_root = &fs_info->delayed_root;
-
-	curr_node = btrfs_first_delayed_node(delayed_root, &curr_delayed_node_tracker);
+	curr_node = btrfs_first_delayed_node(&fs_info->delayed_root, &curr_delayed_node_tracker);
 	while (curr_node && (!count || nr--)) {
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
-- 
2.51.1


