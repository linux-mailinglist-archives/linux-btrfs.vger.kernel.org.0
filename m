Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E551C5E7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 19:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382582AbiEERUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEERUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 13:20:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6DB5C34A
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 10:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EC08B8279B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 17:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B3FC385AE
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651770980;
        bh=nrs/ixux+EwxyQF6lTdHt0kTyMCoiVgqFqVB6d2DuZY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LulsLFKicqSWBMwByGQND0xFmr5p8BHggtALS4yHPQyPHLoiaT3fmxbZIQSFCdxbx
         uH3v9bIR8llnABIQHybR3Nx2W/rp5YM5goG9ygTLjgeUeQlmJcTpa6oYbf8RZUYU3f
         jUsQSPhpXwT7qfSESlTEHQSz92s5aGmUrQ4K0cjd5+HMs8Ur+qK3ZcPWLe4pk1oY9G
         IblDUK9mMmDLJ844fdwH7HZJqk9gymzUpbK+epyNjCvryZ/GR7wEuQeBkVxUVNuKq1
         AaKLdxnUXlh0OR6/Lkr2+qrRKot9MtDg6BYZo9vNh38M2qLFARqHUKJmEmRMp6TACP
         qK4OrUeVcs6uA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: send: keep the current inode open while processing it
Date:   Thu,  5 May 2022 18:16:14 +0100
Message-Id: <82608be46352e0eaba9247107edbe5b39cced443.1651770555.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1651770555.git.fdmanana@suse.com>
References: <cover.1651770555.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Every time we send a write command, we open the inode, read some data to
a buffer and then close the inode. The amount of data we read for each
write command is at most 48K, returned by max_send_read_size(), and that
corresponds to: BTRFS_SEND_BUF_SIZE - 16K = 48K. In practice this does
not add any significant overhead, because the time elapsed between every
close (iput()) and open (btrfs_iget()) is very short, so the inode is kept
in the VFS's cache after the iput() and it's still there by the time we
do the next btrfs_iget().

As between processing extents of the current inode we don't do anything
else, it makes sense to keep the inode open after we process its first
extent that needs to be sent and keep it open until we start processing
the next inode. This serves to facilitate the next change, which aims
to avoid having send operations trash the page cache with data extents.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 54 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 330bef72a555..55275ba90cb4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -131,6 +131,11 @@ struct send_ctx {
 	struct list_head name_cache_list;
 	int name_cache_size;
 
+	/*
+	 * The inode we are currently processing. It's not NULL only when we
+	 * need to issue write commands for data extents from this inode.
+	 */
+	struct inode *cur_inode;
 	struct file_ra_state ra;
 
 	/*
@@ -4868,7 +4873,6 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 {
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode *inode;
 	struct page *page;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	pgoff_t last_index;
@@ -4879,37 +4883,30 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 	if (ret)
 		return ret;
 
-	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-
 	last_index = (offset + len - 1) >> PAGE_SHIFT;
 
-	/* initial readahead */
-	memset(&sctx->ra, 0, sizeof(struct file_ra_state));
-	file_ra_state_init(&sctx->ra, inode->i_mapping);
-
 	while (index <= last_index) {
 		unsigned cur_len = min_t(unsigned, len,
 					 PAGE_SIZE - pg_offset);
 
-		page = find_lock_page(inode->i_mapping, index);
+		page = find_lock_page(sctx->cur_inode->i_mapping, index);
 		if (!page) {
-			page_cache_sync_readahead(inode->i_mapping, &sctx->ra,
-				NULL, index, last_index + 1 - index);
+			page_cache_sync_readahead(sctx->cur_inode->i_mapping,
+						  &sctx->ra, NULL, index,
+						  last_index + 1 - index);
 
-			page = find_or_create_page(inode->i_mapping, index,
-					GFP_KERNEL);
+			page = find_or_create_page(sctx->cur_inode->i_mapping,
+						   index, GFP_KERNEL);
 			if (!page) {
 				ret = -ENOMEM;
 				break;
 			}
 		}
 
-		if (PageReadahead(page)) {
-			page_cache_async_readahead(inode->i_mapping, &sctx->ra,
-				NULL, page, index, last_index + 1 - index);
-		}
+		if (PageReadahead(page))
+			page_cache_async_readahead(sctx->cur_inode->i_mapping,
+						   &sctx->ra, NULL, page, index,
+						   last_index + 1 - index);
 
 		if (!PageUptodate(page)) {
 			btrfs_readpage(NULL, page);
@@ -4935,7 +4932,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		len -= cur_len;
 		sctx->send_size += cur_len;
 	}
-	iput(inode);
+
 	return ret;
 }
 
@@ -5148,6 +5145,20 @@ static int send_extent_data(struct send_ctx *sctx,
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, len);
 
+	if (sctx->cur_inode == NULL) {
+		struct btrfs_root *root = sctx->send_root;
+
+		sctx->cur_inode = btrfs_iget(root->fs_info->sb, sctx->cur_ino, root);
+		if (IS_ERR(sctx->cur_inode)) {
+			int err = PTR_ERR(sctx->cur_inode);
+
+			sctx->cur_inode = NULL;
+			return err;
+		}
+		memset(&sctx->ra, 0, sizeof(struct file_ra_state));
+		file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping);
+	}
+
 	while (sent < len) {
 		u64 size = min(len - sent, read_size);
 		int ret;
@@ -6171,6 +6182,9 @@ static int changed_inode(struct send_ctx *sctx,
 	u64 left_gen = 0;
 	u64 right_gen = 0;
 
+	iput(sctx->cur_inode);
+	sctx->cur_inode = NULL;
+
 	sctx->cur_ino = key->objectid;
 	sctx->cur_inode_new_gen = 0;
 	sctx->cur_inode_last_extent = (u64)-1;
@@ -7657,6 +7671,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
 		name_cache_free(sctx);
 
+		iput(sctx->cur_inode);
+
 		kfree(sctx);
 	}
 
-- 
2.35.1

