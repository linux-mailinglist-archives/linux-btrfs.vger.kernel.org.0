Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F14BF2C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 08:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiBVHl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 02:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiBVHlx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 02:41:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17F129BB4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 23:41:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C495F1F39A
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645515686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gALd5WBR35d4Kex6ujcxrDHEuz+4kVTmP0LC166byc=;
        b=Z1rHnh1+KzK8bj3m/pCxycVKErH0PpdzHT5GsCzkgsY4A7+ae8r5dkE4Rz8kGyHrT5C5Ho
        meGqvEYbveTnicQFIpo5r3XIXNo38yoLUD5h8tZWfYYl8RuYHizdo8jPFY7nK4WlHj4+gh
        y8eFst/CXSIZZxawz48kCmiF7UV6cDM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10DCD13BA7
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ALaGMaWTFGJxKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: unify the error handling pattern for read_tree_block()
Date:   Tue, 22 Feb 2022 15:41:19 +0800
Message-Id: <1f9c0592a6318849dbed4c377c70813c3ec92a45.1645515599.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645515599.git.wqu@suse.com>
References: <cover.1645515599.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We had an error handling pattern for read_tree_block() like this:

	eb = read_tree_block();
	if (IS_ERR(eb)) {
		/*
		 * Handling error here
		 * Normally ended up with return or goto out.
		 */
	} else if (!extent_buffer_uptodate(eb)) {
		/*
		 * Different error handling here
		 * Normally also ended up with return or goto out;
		 */
	}

This is fine, but if we want to add extra check for each
read_tree_block(), the existing if-else-if is not that expandable and
will take reader some seconds to figure out there is no extra branch.

Here we change it to a more common way, without the extra else:

	eb = read_tree_block();
	if (IS_ERR(eb)) {
		/*
		 * Handling error here
		 */
		return eb or goto out;
	}
	if (!extent_buffer_uptodate(eb)) {
		/*
		 * Different error handling here
		 */
		return eb or goto out;
	}

This also removes some oddball call sites which uses some creative way to
check error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    |  7 +++++--
 fs/btrfs/ctree.c      | 30 ++++++++++++++++--------------
 fs/btrfs/disk-io.c    | 16 +++++++++-------
 fs/btrfs/print-tree.c |  4 ++--
 fs/btrfs/relocation.c |  3 ++-
 5 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index c9ee579bc5a6..ebc392ea1d74 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -789,11 +789,13 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
 		if (IS_ERR(eb)) {
 			free_pref(ref);
 			return PTR_ERR(eb);
-		} else if (!extent_buffer_uptodate(eb)) {
+		}
+		if (!extent_buffer_uptodate(eb)) {
 			free_pref(ref);
 			free_extent_buffer(eb);
 			return -EIO;
 		}
+
 		if (lock)
 			btrfs_tree_read_lock(eb);
 		if (btrfs_header_level(eb) == 0)
@@ -1335,7 +1337,8 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				if (IS_ERR(eb)) {
 					ret = PTR_ERR(eb);
 					goto out;
-				} else if (!extent_buffer_uptodate(eb)) {
+				}
+				if (!extent_buffer_uptodate(eb)) {
 					free_extent_buffer(eb);
 					ret = -EIO;
 					goto out;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1bb5335c6d75..9b2d9cd41676 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -846,9 +846,11 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 			     btrfs_header_owner(parent),
 			     btrfs_node_ptr_generation(parent, slot),
 			     level - 1, &first_key);
-	if (!IS_ERR(eb) && !extent_buffer_uptodate(eb)) {
+	if (IS_ERR(eb))
+		return eb;
+	if (!extent_buffer_uptodate(eb)) {
 		free_extent_buffer(eb);
-		eb = ERR_PTR(-EIO);
+		return ERR_PTR(-EIO);
 	}
 
 	return eb;
@@ -1460,19 +1462,19 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	ret = -EAGAIN;
 	tmp = read_tree_block(fs_info, blocknr, root->root_key.objectid,
 			      gen, parent_level - 1, &first_key);
-	if (!IS_ERR(tmp)) {
-		/*
-		 * If the read above didn't mark this buffer up to date,
-		 * it will never end up being up to date.  Set ret to EIO now
-		 * and give up so that our caller doesn't loop forever
-		 * on our EAGAINs.
-		 */
-		if (!extent_buffer_uptodate(tmp))
-			ret = -EIO;
-		free_extent_buffer(tmp);
-	} else {
-		ret = PTR_ERR(tmp);
+	if (IS_ERR(tmp)) {
+		btrfs_release_path(p);
+		return PTR_ERR(tmp);
 	}
+	/*
+	 * If the read above didn't mark this buffer up to date,
+	 * it will never end up being up to date.  Set ret to EIO now
+	 * and give up so that our caller doesn't loop forever
+	 * on our EAGAINs.
+	 */
+	if (!extent_buffer_uptodate(tmp))
+		ret = -EIO;
+	free_extent_buffer(tmp);
 
 	btrfs_release_path(p);
 	return ret;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b6a81c39d5f4..8165ee3ae8a5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1543,7 +1543,8 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 		ret = PTR_ERR(root->node);
 		root->node = NULL;
 		goto fail;
-	} else if (!btrfs_buffer_uptodate(root->node, generation, 0)) {
+	}
+	if (!btrfs_buffer_uptodate(root->node, generation, 0)) {
 		ret = -EIO;
 		goto fail;
 	}
@@ -2538,11 +2539,13 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		log_tree_root->node = NULL;
 		btrfs_put_root(log_tree_root);
 		return ret;
-	} else if (!extent_buffer_uptodate(log_tree_root->node)) {
+	}
+	if (!extent_buffer_uptodate(log_tree_root->node)) {
 		btrfs_err(fs_info, "failed to read log tree");
 		btrfs_put_root(log_tree_root);
 		return -EIO;
 	}
+
 	/* returns with log_tree_root freed on success */
 	ret = btrfs_recover_log_trees(log_tree_root);
 	if (ret) {
@@ -2984,15 +2987,14 @@ static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen, int lev
 	if (IS_ERR(root->node)) {
 		ret = PTR_ERR(root->node);
 		root->node = NULL;
-	} else if (!extent_buffer_uptodate(root->node)) {
+		return ret;
+	}
+	if (!extent_buffer_uptodate(root->node)) {
 		free_extent_buffer(root->node);
 		root->node = NULL;
-		ret = -EIO;
+		return -EIO;
 	}
 
-	if (ret)
-		return ret;
-
 	btrfs_set_root_node(&root->root_item, root->node);
 	root->commit_root = btrfs_root_node(root);
 	btrfs_set_root_refs(&root->root_item, 1);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 524fdb0ddd74..dd8777872143 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -392,9 +392,9 @@ void btrfs_print_tree(struct extent_buffer *c, bool follow)
 				       btrfs_header_owner(c),
 				       btrfs_node_ptr_generation(c, i),
 				       level - 1, &first_key);
-		if (IS_ERR(next)) {
+		if (IS_ERR(next))
 			continue;
-		} else if (!extent_buffer_uptodate(next)) {
+		if (!extent_buffer_uptodate(next)) {
 			free_extent_buffer(next);
 			continue;
 		}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f5465197996d..1ac36d9bfaf4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2601,7 +2601,8 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
 			     block->key.offset, block->level, NULL);
 	if (IS_ERR(eb)) {
 		return PTR_ERR(eb);
-	} else if (!extent_buffer_uptodate(eb)) {
+	}
+	if (!extent_buffer_uptodate(eb)) {
 		free_extent_buffer(eb);
 		return -EIO;
 	}
-- 
2.35.1

