Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BDE62A0F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiKOSB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKOSBN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316881161
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:01:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6ABD336CD;
        Tue, 15 Nov 2022 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIvtsO76tyAt0xnmv0CJbL/aHLQCt0Mo0S4+1mDuFFs=;
        b=sAwFfMRE9+EkR1av/8Q4zR+lS4TwkQdLcYo8qrSLLQaXXvEfGGChl2UCjhmtow3P68Ceb3
        ennvYyaMJ2zpRO7sH9YR68n+Zpjhip/A5kGvxRPv8P6/W0O1vpVDazrKbY6nRl3XUY4meM
        tXaQ6AflWKLqPirb3mKBr6crV75d0Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535267;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIvtsO76tyAt0xnmv0CJbL/aHLQCt0Mo0S4+1mDuFFs=;
        b=aEUN2wtkR82LnNLqBWh24O3e70ZacZl7Z/+r0DsEoQSEcxZNfCZitXV3yBCiA9tm8HdBH0
        WPJytyySn73ULnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 947A513A91;
        Tue, 15 Nov 2022 18:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vmYeHOPTc2PGZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:01:07 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 14/16] btrfs: lock extent before pages for encoded read ioctls
Date:   Tue, 15 Nov 2022 12:00:32 -0600
Message-Id: <7d0e6ad948ebd8ce5b5858b720a9e2403221d677.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
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

Lock extent before pages while performing read ioctls.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2806ef69122e..3c3f38b0048d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10237,13 +10237,11 @@ static ssize_t btrfs_encoded_read_inline(
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
@@ -10305,9 +10303,6 @@ static ssize_t btrfs_encoded_read_inline(
 	}
 	read_extent_buffer(leaf, tmp, ptr, count);
 	btrfs_release_path(path);
-	unlock_extent(io_tree, start, lockend, cached_state);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-	*unlocked = true;
 
 	ret = copy_to_iter(tmp, count, iter);
 	if (ret != count)
@@ -10482,11 +10477,9 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
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
@@ -10508,10 +10501,6 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 	if (ret)
 		goto out;
 
-	unlock_extent(io_tree, start, lockend, cached_state);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-	*unlocked = true;
-
 	if (compressed) {
 		i = 0;
 		page_offset = 0;
@@ -10554,7 +10543,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	u64 start, lockend, disk_bytenr, disk_io_size;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em;
-	bool unlocked = false;
 
 	file_accessed(iocb->ki_filp);
 
@@ -10605,7 +10593,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		em = NULL;
 		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
 						&cached_state, extent_start,
-						count, encoded, &unlocked);
+						count, encoded);
 		goto out;
 	}
 
@@ -10658,9 +10646,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	em = NULL;
 
 	if (disk_bytenr == EXTENT_MAP_HOLE) {
-		unlock_extent(io_tree, start, lockend, &cached_state);
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-		unlocked = true;
 		ret = iov_iter_zero(count, iter);
 		if (ret != count)
 			ret = -EFAULT;
@@ -10668,8 +10653,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
 						 &cached_state, disk_bytenr,
 						 disk_io_size, count,
-						 encoded->compression,
-						 &unlocked);
+						 encoded->compression);
 	}
 
 out:
@@ -10678,11 +10662,9 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
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
2.35.3

