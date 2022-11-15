Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12A62A0F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiKOSBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiKOSBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD14C10
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8884E336CD;
        Tue, 15 Nov 2022 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uc3zwMPWJa+3nz3UEityHBUfqKfc6GUABZOxcrB+Elc=;
        b=kudD8IZSa1Noc3+QADxiAYbCY5XS3loMZhk0PylhmwXXYob7Q1N/a7vToGDfvydc69xNEV
        qkbiAa8lo0gHMzG5YzxHL0sTdoO6UEuZcYBzzO/as6KK2tlC+HjoXEw1CNmgZuxyAmmyyP
        /lPPArIMj7ThBkvtqcVGJPQt1M7YonE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uc3zwMPWJa+3nz3UEityHBUfqKfc6GUABZOxcrB+Elc=;
        b=nY1eGHuuICdG7wasAdcFkIUK+y1LUOGweAZeDaqxBYhFBlVaEdHy9exsmrBoK/YaQhcyuY
        A6IwlyxgzHK2AtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3259213A91;
        Tue, 15 Nov 2022 18:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xdZBBM7Tc2OaZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:46 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 04/16] btrfs: lock extents while truncating
Date:   Tue, 15 Nov 2022 12:00:22 -0600
Message-Id: <7ffb8c402e6b8cd3679d5b9a97dc0b43e75079d5.1668530684.git.rgoldwyn@suse.com>
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

Extent locking before pages.

Lock extents while performing truncate_setsize(). This calls
btrfs_invalidatepage(), so remove all locking during invalidatepage().

Note, extent locks are not required during inode eviction, which calls
invalidatepage as well.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c  |  4 ++--
 fs/btrfs/inode.c | 42 ++++++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 940f10f42790..473a0743270b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2212,10 +2212,10 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
 
 	while (1) {
-		truncate_pagecache_range(inode, lockstart, lockend);
-
 		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
+
+		truncate_pagecache_range(inode, lockstart, lockend);
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1044a34a20e6..4bfa51871ddc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4913,7 +4913,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
@@ -4980,11 +4979,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	}
 	wait_on_page_writeback(page);
 
-	lock_extent(io_tree, block_start, block_end, &cached_state);
-
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
 	if (ordered) {
-		unlock_extent(io_tree, block_start, block_end, &cached_state);
 		unlock_page(page);
 		put_page(page);
 		btrfs_start_ordered_extent(ordered, 1);
@@ -4998,10 +4994,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
-	if (ret) {
-		unlock_extent(io_tree, block_start, block_end, &cached_state);
+	if (ret)
 		goto out_unlock;
-	}
 
 	if (offset != blocksize) {
 		if (!len)
@@ -5016,7 +5010,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	btrfs_page_clear_checked(fs_info, page, block_start,
 				 block_end + 1 - block_start);
 	btrfs_page_set_dirty(fs_info, page, block_start, block_end + 1 - block_start);
-	unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
@@ -5108,6 +5101,8 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	u64 hole_size;
 	int err = 0;
 
+	btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end - 1,
+					   &cached_state);
 	/*
 	 * If our size started in the middle of a block we need to zero out the
 	 * rest of the block before we expand the i_size, otherwise we could
@@ -5115,13 +5110,11 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	 */
 	err = btrfs_truncate_block(inode, oldsize, 0, 0);
 	if (err)
-		return err;
+		goto out;
 
 	if (size <= hole_start)
-		return 0;
+		goto out;
 
-	btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end - 1,
-					   &cached_state);
 	cur_offset = hole_start;
 	while (1) {
 		em = btrfs_get_extent(inode, NULL, 0, cur_offset,
@@ -5183,6 +5176,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			break;
 	}
 	free_extent_map(em);
+out:
 	unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
 	return err;
 }
@@ -5195,6 +5189,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	loff_t newsize = attr->ia_size;
 	int mask = attr->ia_valid;
 	int ret;
+	bool flushed = false;
 
 	/*
 	 * The regular truncate() case without ATTR_CTIME and ATTR_MTIME is a
@@ -5239,6 +5234,9 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_end_transaction(trans);
 	} else {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		u64 start = round_down(newsize, fs_info->sectorsize);
+		u64 end = round_up(oldsize, fs_info->sectorsize) - 1;
+		struct extent_state **cached = NULL;
 
 		if (btrfs_is_zoned(fs_info) || (newsize < oldsize)) {
 			ret = btrfs_wait_ordered_range(inode,
@@ -5256,12 +5254,20 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		if (newsize == 0)
 			set_bit(BTRFS_INODE_FLUSH_ON_CLOSE,
 				&BTRFS_I(inode)->runtime_flags);
-
+again:
+		lock_extent(&BTRFS_I(inode)->io_tree, start, end, cached);
 		truncate_setsize(inode, newsize);
 
 		inode_dio_wait(inode);
 
 		ret = btrfs_truncate(BTRFS_I(inode));
+		unlock_extent(&BTRFS_I(inode)->io_tree, start, end, cached);
+
+		if (ret == -EDQUOT && !flushed) {
+			flushed = true;
+			btrfs_qgroup_flush(BTRFS_I(inode)->root);
+			goto again;
+		}
 
 		if (ret && inode->i_nlink) {
 			int err;
@@ -8342,9 +8348,6 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		return;
 	}
 
-	if (!inode_evicting)
-		lock_extent(tree, page_start, page_end, &cached_state);
-
 	cur = page_start;
 	while (cur < page_end) {
 		struct btrfs_ordered_extent *ordered;
@@ -8445,7 +8448,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		 */
 		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
 		if (!inode_evicting) {
-			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
+			clear_extent_bit(tree, cur, range_end,
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
 				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG |
 				 extra_flags, &cached_state);
@@ -8695,12 +8698,9 @@ static int btrfs_truncate(struct btrfs_inode *inode)
 	trans->block_rsv = rsv;
 
 	while (1) {
-		struct extent_state *cached_state = NULL;
 		const u64 new_size = inode->vfs_inode.i_size;
-		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
 
 		control.new_size = new_size;
-		lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 		/*
 		 * We want to drop from the next block forward in case this new
 		 * size is not block aligned since we will be keeping the last
@@ -8715,8 +8715,6 @@ static int btrfs_truncate(struct btrfs_inode *inode)
 		inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 		btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
-		unlock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
-
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN)
 			break;
-- 
2.35.3

