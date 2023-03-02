Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438266A8BBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCBWZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBWZl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359301EBDC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA8EA2006A;
        Thu,  2 Mar 2023 22:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNMnYZjtpI1sknuwdOT3eQNI4Fbqyn71ytbQ6Splzt4=;
        b=1hRK3lqSOeoORL9ZFC+Cybe8BRFkkL66W4YD0WqVFf/sXezQ1kxmGbr6mMyPQhu9YIpVCy
        fIu48x84741O+ilE3M2+LMSP11JHWeYMn+jAe0LmE2IFN7n4GN8sthdDtBcZVCQNArqFr/
        FxnTnZOqs/UQyAkt66xAqHVsPl5YulI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNMnYZjtpI1sknuwdOT3eQNI4Fbqyn71ytbQ6Splzt4=;
        b=3Ke6GW8k4NLG8T3NbCXetxD8SI5h5vKqAlWAeofxhf+k13GxugKFBSEakCgorPNHzYw6m5
        lgGB4XdKwCOiq8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94B1113349;
        Thu,  2 Mar 2023 22:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iePoHGIiAWTZSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:38 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 15/21] btrfs: lock extent before pages for encoded read ioctls
Date:   Thu,  2 Mar 2023 16:25:00 -0600
Message-Id: <476ceb4477d4ffa7a2cebfc3cc0119bfa48637f9.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Lock extent before pages while performing read ioctls.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f879c65ee8cc..729def5969d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9839,13 +9839,11 @@ static ssize_t btrfs_encoded_read_inline(
 				u64 lockend,
 				struct extent_state **cached_state,
 				u64 extent_start, size_t count,
-				struct btrfs_ioctl_encoded_io_args *encoded,
-				bool *unlocked)
+				struct btrfs_ioctl_encoded_io_args *encoded)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(iocb->ki_filp));
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *item;
@@ -9907,9 +9905,6 @@ static ssize_t btrfs_encoded_read_inline(
 	}
 	read_extent_buffer(leaf, tmp, ptr, count);
 	btrfs_release_path(path);
-	unlock_extent(io_tree, start, lockend, cached_state);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-	*unlocked = true;
 
 	ret = copy_to_iter(tmp, count, iter);
 	if (ret != count)
@@ -10003,11 +9998,9 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 					  u64 start, u64 lockend,
 					  struct extent_state **cached_state,
 					  u64 disk_bytenr, u64 disk_io_size,
-					  size_t count, bool compressed,
-					  bool *unlocked)
+					  size_t count, bool compressed)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(iocb->ki_filp));
-	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct page **pages;
 	unsigned long nr_pages, i;
 	u64 cur;
@@ -10029,10 +10022,6 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 	if (ret)
 		goto out;
 
-	unlock_extent(io_tree, start, lockend, cached_state);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-	*unlocked = true;
-
 	if (compressed) {
 		i = 0;
 		page_offset = 0;
@@ -10075,7 +10064,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	u64 start, lockend, disk_bytenr, disk_io_size;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em;
-	bool unlocked = false;
 
 	file_accessed(iocb->ki_filp);
 
@@ -10126,7 +10114,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		em = NULL;
 		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
 						&cached_state, extent_start,
-						count, encoded, &unlocked);
+						count, encoded);
 		goto out;
 	}
 
@@ -10179,9 +10167,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	em = NULL;
 
 	if (disk_bytenr == EXTENT_MAP_HOLE) {
-		unlock_extent(io_tree, start, lockend, &cached_state);
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-		unlocked = true;
 		ret = iov_iter_zero(count, iter);
 		if (ret != count)
 			ret = -EFAULT;
@@ -10189,8 +10174,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
 						 &cached_state, disk_bytenr,
 						 disk_io_size, count,
-						 encoded->compression,
-						 &unlocked);
+						 encoded->compression);
 	}
 
 out:
@@ -10199,11 +10183,9 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 out_em:
 	free_extent_map(em);
 out_unlock_extent:
-	if (!unlocked)
-		unlock_extent(io_tree, start, lockend, &cached_state);
+	unlock_extent(io_tree, start, lockend, &cached_state);
 out_unlock_inode:
-	if (!unlocked)
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	return ret;
 }
 
-- 
2.39.2

