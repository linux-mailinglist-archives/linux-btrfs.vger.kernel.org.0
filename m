Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0F3A58C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhFMNm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFMNm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D59E821972;
        Sun, 13 Jun 2021 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e10Lqu1nbYMdX1ZgSSgLB6GXzx9FvCEgtMOqZao1vQ=;
        b=VVD1SY1q3rO4MkVrgXenmEAXh/80EfQ799eenbQTx8HygykWV0CzYtQbOOUHqlsDBlwH/M
        C3OTTodqGCFpT1PtDeVjYFu8sYclHgAYp16LRyDID7f8a7kehghEb/mM1QUwPoctOMc5Nx
        Yja3Ig69mzdq2Dn8KanuR4B1KkpNhQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e10Lqu1nbYMdX1ZgSSgLB6GXzx9FvCEgtMOqZao1vQ=;
        b=mnZ5qhSKUSJtszWLw3Y05AyHMuZcIlTu2cjQb91o6sE5P27psibVdvGItLd9W7GTgk+aw5
        XVqpldY6r91fxhDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7F73D118DD;
        Sun, 13 Jun 2021 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e10Lqu1nbYMdX1ZgSSgLB6GXzx9FvCEgtMOqZao1vQ=;
        b=VVD1SY1q3rO4MkVrgXenmEAXh/80EfQ799eenbQTx8HygykWV0CzYtQbOOUHqlsDBlwH/M
        C3OTTodqGCFpT1PtDeVjYFu8sYclHgAYp16LRyDID7f8a7kehghEb/mM1QUwPoctOMc5Nx
        Yja3Ig69mzdq2Dn8KanuR4B1KkpNhQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e10Lqu1nbYMdX1ZgSSgLB6GXzx9FvCEgtMOqZao1vQ=;
        b=mnZ5qhSKUSJtszWLw3Y05AyHMuZcIlTu2cjQb91o6sE5P27psibVdvGItLd9W7GTgk+aw5
        XVqpldY6r91fxhDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id O4vwFskKxmBOJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:25 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 07/31] btrfs: write() perform extent locks before locking page
Date:   Sun, 13 Jun 2021 08:39:35 -0500
Message-Id: <499b1e04baf4e035aeb9a03784b148ec97974787.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Lock order change: Extent locks before page locks.

While performing writes, lock the extents before locking the pages.

Since pages will no longer involved, lock_and_cleanup_extent_if_need()
can be deleted and btrfs_lock_and_flush_ordered_range() is used instead.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 95 +++++++++----------------------------------------
 1 file changed, 16 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 28a05ba47060..e7d33c8177a0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1407,70 +1407,6 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 
 }
 
-/*
- * This function locks the extent and properly waits for data=ordered extents
- * to finish before allowing the pages to be modified if need.
- *
- * The return value:
- * 1 - the extent is locked
- * 0 - the extent is not locked, and everything is OK
- * -EAGAIN - need re-prepare the pages
- * the other < 0 number - Something wrong happens
- */
-static noinline int
-lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
-				size_t num_pages, loff_t pos,
-				size_t write_bytes,
-				u64 *lockstart, u64 *lockend,
-				struct extent_state **cached_state)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 start_pos;
-	u64 last_pos;
-	int i;
-	int ret = 0;
-
-	start_pos = round_down(pos, fs_info->sectorsize);
-	last_pos = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
-
-	if (start_pos < inode->vfs_inode.i_size) {
-		struct btrfs_ordered_extent *ordered;
-
-		lock_extent_bits(&inode->io_tree, start_pos, last_pos,
-				cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, start_pos,
-						     last_pos - start_pos + 1);
-		if (ordered &&
-		    ordered->file_offset + ordered->num_bytes > start_pos &&
-		    ordered->file_offset <= last_pos) {
-			unlock_extent_cached(&inode->io_tree, start_pos,
-					last_pos, cached_state);
-			for (i = 0; i < num_pages; i++) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
-			btrfs_start_ordered_extent(ordered, 1);
-			btrfs_put_ordered_extent(ordered);
-			return -EAGAIN;
-		}
-		if (ordered)
-			btrfs_put_ordered_extent(ordered);
-
-		*lockstart = start_pos;
-		*lockend = last_pos;
-		ret = 1;
-	}
-
-	/*
-	 * We should be called after prepare_pages() which should have locked
-	 * all pages in the range.
-	 */
-	for (i = 0; i < num_pages; i++)
-		WARN_ON(!PageLocked(pages[i]));
-
-	return ret;
-}
-
 static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait)
 {
@@ -1693,7 +1629,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		size_t copied;
 		size_t dirty_sectors;
 		size_t num_sectors;
-		int extents_locked;
+		int extents_locked = false;
 
 		/*
 		 * Fault pages before locking them in prepare_pages
@@ -1742,7 +1678,15 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		}
 
 		release_bytes = reserve_bytes;
-again:
+
+		if (pos < inode->i_size) {
+			lockstart = round_down(pos, fs_info->sectorsize);
+			lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
+			btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
+					lockstart, lockend, &cached_state);
+			extents_locked = true;
+		}
+
 		/*
 		 * This is going to setup the pages array with the number of
 		 * pages we want, so we don't really need to worry about the
@@ -1754,19 +1698,11 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
-			break;
-		}
-
-		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), pages,
-				num_pages, pos, write_bytes, &lockstart,
-				&lockend, &cached_state);
-		if (extents_locked < 0) {
-			if (extents_locked == -EAGAIN)
-				goto again;
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes);
-			ret = extents_locked;
+			if (extents_locked)
+				unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+						lockstart, lockend, &cached_state);
+			else
+				free_extent_state(cached_state);
 			break;
 		}
 
@@ -1831,6 +1767,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					     lockstart, lockend, &cached_state);
 		else
 			free_extent_state(cached_state);
+		extents_locked = false;
 
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
-- 
2.31.1

