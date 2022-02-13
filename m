Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5354B39FD
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Feb 2022 08:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiBMHnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Feb 2022 02:43:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiBMHnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Feb 2022 02:43:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935333B
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Feb 2022 23:42:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15D801F37F
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644738175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMXTPDbOgSPgKWRjgZHjFd9VntoTx5UinawUvcEtyDU=;
        b=JmmyYMIO925a6zd+1685tqXeZf9K/H2JXwav1InfYmGsRi7kNSq2pqmEmyskIbv6X9Qk+S
        LGaKWpVUMeTrXmMbxwFUDQOADGyZQfBhrndlTXyIy+mEcuPN6HpjA8I6wwDOkYwlLZJkGV
        PIWUyAxwENVWwh8W466cwBHX3wlFsbM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6672A1331A
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MDQrDH62CGI+dAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Date:   Sun, 13 Feb 2022 15:42:32 +0800
Message-Id: <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644737297.git.wqu@suse.com>
References: <cover.1644737297.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we have btrfs_requeue_inode_defrag(), for autodefrag we are
still just exhausting all inode_defrag items in the tree.

This means, it doesn't make much difference to requeue an inode_defrag,
other than scan the inode from the beginning till its end.

This patch will change the beahvior by always scan from offset 0 of an
inode, and till the end of the inode.

By this we get the following benefit:

- Straight-forward code

- No more re-queue related check

- Less members in inode_defrag

We still keep the same btrfs_get_fs_root() and btrfs_iget() check for
each loop, and added extra should_auto_defrag() check per-loop.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 147 +++++++++++++++++++-----------------------------
 1 file changed, 59 insertions(+), 88 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 73f393457547..ada73f26b682 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -49,12 +49,6 @@ struct inode_defrag {
 
 	/* root objectid */
 	u64 root;
-
-	/* last offset we were able to defrag */
-	u64 last_offset;
-
-	/* if we've wrapped around back to zero once already */
-	int cycled;
 };
 
 static int __compare_inode_defrag(struct inode_defrag *defrag1,
@@ -107,8 +101,6 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 			 */
 			if (defrag->transid < entry->transid)
 				entry->transid = defrag->transid;
-			if (defrag->last_offset > entry->last_offset)
-				entry->last_offset = defrag->last_offset;
 			return -EEXIST;
 		}
 	}
@@ -174,34 +166,6 @@ int btrfs_add_inode_defrag(struct btrfs_inode *inode)
 	return 0;
 }
 
-/*
- * Requeue the defrag object. If there is a defrag object that points to
- * the same inode in the tree, we will merge them together (by
- * __btrfs_add_inode_defrag()) and free the one that we want to requeue.
- */
-static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
-				       struct inode_defrag *defrag)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	int ret;
-
-	if (!__need_auto_defrag(fs_info))
-		goto out;
-
-	/*
-	 * Here we don't check the IN_DEFRAG flag, because we need merge
-	 * them together.
-	 */
-	spin_lock(&fs_info->defrag_inodes_lock);
-	ret = __btrfs_add_inode_defrag(inode, defrag);
-	spin_unlock(&fs_info->defrag_inodes_lock);
-	if (ret)
-		goto out;
-	return;
-out:
-	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-}
-
 /*
  * pick the defragable inode that we want, if it doesn't exist, we will get
  * the next one.
@@ -268,63 +232,74 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 
 #define BTRFS_DEFRAG_BATCH	1024
 
+static bool should_auto_defrag(struct btrfs_fs_info *fs_info)
+{
+	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
+		return false;
+	if (!__need_auto_defrag(fs_info))
+		return false;
+
+	return true;
+}
+
 static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 				    struct inode_defrag *defrag)
 {
-	struct btrfs_root *inode_root;
-	struct inode *inode;
-	struct btrfs_defrag_ctrl ctrl = {0};
-	int ret;
+	u64 cur = 0;
+	int ret = 0;
 
-	/* get the inode */
-	inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
-	if (IS_ERR(inode_root)) {
-		ret = PTR_ERR(inode_root);
-		goto cleanup;
-	}
+	while (true) {
+		struct btrfs_defrag_ctrl ctrl = {0};
+		struct btrfs_root *inode_root;
+		struct inode *inode;
 
-	inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
-	btrfs_put_root(inode_root);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		goto cleanup;
-	}
+		if (!should_auto_defrag(fs_info))
+			break;
 
-	/* do a chunk of defrag */
-	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
-	ctrl.len = (u64)-1;
-	ctrl.start = defrag->last_offset;
-	ctrl.newer_than = defrag->transid;
-	ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
+		/* This also makes sure the root is not dropped half way */
+		inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
+		if (IS_ERR(inode_root)) {
+			ret = PTR_ERR(inode_root);
+			goto cleanup;
+		}
+
+		/* Get the inode */
+		inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
+		btrfs_put_root(inode_root);
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
+			goto cleanup;
+		}
+
+		/* Have already scanned the whole inode */
+		if (cur >= i_size_read(inode)) {
+			iput(inode);
+			break;
+		}
+
+		/* do a chunk of defrag */
+		clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
+
+		ctrl.len = (u64)-1;
+		ctrl.start = cur;
+		ctrl.newer_than = defrag->transid;
+		ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
+
+		sb_start_write(fs_info->sb);
+		ret = btrfs_defrag_file(inode, NULL, &ctrl);
+		sb_end_write(fs_info->sb);
+		iput(inode);
+
+		if (ret < 0)
+			break;
 
-	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(inode, NULL, &ctrl);
-	sb_end_write(fs_info->sb);
-	if (ret < 0)
-		goto out;
-	/*
-	 * if we filled the whole defrag batch, there
-	 * must be more work to do.  Queue this defrag
-	 * again
-	 */
-	if (ctrl.sectors_defragged == BTRFS_DEFRAG_BATCH) {
-		defrag->last_offset = ctrl.last_scanned;
-		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-	} else if (defrag->last_offset && !defrag->cycled) {
 		/*
-		 * we didn't fill our defrag batch, but
-		 * we didn't start at zero.  Make sure we loop
-		 * around to the start of the file.
+		 * Just in case last_scanned is still @cur, we increase @cur by
+		 * sectorsize.
 		 */
-		defrag->last_offset = 0;
-		defrag->cycled = 1;
-		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-	} else {
-		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+		cur = max(cur + fs_info->sectorsize, ctrl.last_scanned);
 	}
-out:
-	iput(inode);
-	return 0;
+
 cleanup:
 	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	return ret;
@@ -343,11 +318,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 	atomic_inc(&fs_info->defrag_running);
 	while (1) {
 		/* Pause the auto defragger. */
-		if (test_bit(BTRFS_FS_STATE_REMOUNTING,
-			     &fs_info->fs_state))
-			break;
-
-		if (!__need_auto_defrag(fs_info))
+		if (!should_auto_defrag(fs_info))
 			break;
 
 		/* find an inode to defrag */
-- 
2.35.0

