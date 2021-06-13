Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C1B3A58D0
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhFMNnB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNnA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:00 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06ACF1FD2D;
        Sun, 13 Jun 2021 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPw2ZLv+IdPIxBZFMpyvUX/Ud1VcKuHnz0GAwJFF0zs=;
        b=pCtHEsE+EhVW9KRNXYTFfJphkD1BUwkngMn6jY0lIpvITgrGY5JC/NAXWXjXP0iTx6MviF
        vZ8G9aMLDOwXioehhLYjKCfyFcWsfA7/U2co+HwsE5m0ULPVfToaB64iEoNEGre2mew/6W
        ln05q6+yBJac+KyB0nAmUlFdfEsn6WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPw2ZLv+IdPIxBZFMpyvUX/Ud1VcKuHnz0GAwJFF0zs=;
        b=vrDpEEQiIvlALCo4j8OSPvJbDFG+LbYjB3zmZkuBvJ+OAJ4znD+atrA4y8dSBV0BAgyDZc
        1f8HZrS6X/FlJCBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A5320118DD;
        Sun, 13 Jun 2021 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPw2ZLv+IdPIxBZFMpyvUX/Ud1VcKuHnz0GAwJFF0zs=;
        b=pCtHEsE+EhVW9KRNXYTFfJphkD1BUwkngMn6jY0lIpvITgrGY5JC/NAXWXjXP0iTx6MviF
        vZ8G9aMLDOwXioehhLYjKCfyFcWsfA7/U2co+HwsE5m0ULPVfToaB64iEoNEGre2mew/6W
        ln05q6+yBJac+KyB0nAmUlFdfEsn6WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPw2ZLv+IdPIxBZFMpyvUX/Ud1VcKuHnz0GAwJFF0zs=;
        b=vrDpEEQiIvlALCo4j8OSPvJbDFG+LbYjB3zmZkuBvJ+OAJ4znD+atrA4y8dSBV0BAgyDZc
        1f8HZrS6X/FlJCBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id qGIZH+oKxmCQJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:58 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 21/31] btrfs: Carve out btrfs_buffered_iomap_end from the write path
Date:   Sun, 13 Jun 2021 08:39:49 -0500
Message-Id: <9719e5a213073fe0e49370906a76a76f1b85629e.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Carve out btrfs_buffered_iomap_end() from the write path to form
iomap_end() function for writes.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 97 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5751bb5e0656..ab2b1790e0bb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1678,6 +1678,63 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
 
 }
 
+static int btrfs_buffered_iomap_end(struct inode *inode, loff_t pos,
+		loff_t length, ssize_t written, struct btrfs_iomap *bi)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	size_t num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bi->reserved_bytes);
+	size_t dirty_sectors = 0;
+	int dirty_pages = 0;
+	int sector_offset = pos & (fs_info->sectorsize - 1);
+
+	if (written) {
+		dirty_sectors = round_up(written + sector_offset,
+				fs_info->sectorsize);
+		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
+		dirty_pages = DIV_ROUND_UP(written + offset_in_page(pos),
+				PAGE_SIZE);
+	}
+
+	/* Release excess reservations */
+	if (num_sectors > dirty_sectors) {
+		size_t release_bytes = bi->reserved_bytes -
+			(dirty_sectors << fs_info->sb->s_blocksize_bits);
+		if (bi->metadata_only) {
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+					release_bytes, true);
+		} else {
+			u64 p;
+
+			p = round_down(pos,
+					fs_info->sectorsize) +
+				(dirty_pages << PAGE_SHIFT);
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+					bi->data_reserved, p,
+					release_bytes, true);
+		}
+	}
+
+	/*
+	 * If we have not locked the extent range, because the range's
+	 * start offset is >= i_size, we might still have a non-NULL
+	 * cached extent state, acquired while marking the extent range
+	 * as delalloc through btrfs_dirty_pages(). Therefore free any
+	 * possible cached extent state to avoid a memory leak.
+	 */
+	if (bi->extents_locked)
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+				bi->lockstart, bi->lockend,
+				&bi->cached_state);
+	else
+		free_extent_state(bi->cached_state);
+
+	btrfs_delalloc_release_extents(BTRFS_I(inode), bi->reserved_bytes);
+	if (bi->metadata_only)
+		btrfs_check_nocow_unlock(BTRFS_I(inode));
+
+	return 0;
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1736,7 +1793,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		size_t dirty_pages;
 		size_t copied;
 		size_t dirty_sectors;
-		size_t num_sectors;
 
 		/*
 		 * Fault pages before locking them in prepare_pages
@@ -1776,7 +1832,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
 
-		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bi->reserved_bytes);
 		dirty_sectors = round_up(copied + sector_offset,
 					fs_info->sectorsize);
 		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
@@ -1796,26 +1851,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 						   PAGE_SIZE);
 		}
 
-		release_bytes = bi->reserved_bytes;
-
-		if (num_sectors > dirty_sectors) {
-			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors << fs_info->sectorsize_bits;
-			if (bi->metadata_only) {
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							release_bytes, true);
-			} else {
-				u64 __pos;
-
-				__pos = round_down(pos,
-						   fs_info->sectorsize) +
-					(dirty_pages << PAGE_SHIFT);
-				btrfs_delalloc_release_space(BTRFS_I(inode),
-						bi->data_reserved, __pos,
-						release_bytes, true);
-			}
-		}
-
 		release_bytes = round_up(copied + sector_offset,
 					fs_info->sectorsize);
 
@@ -1824,27 +1859,13 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					&bi->cached_state,
 					bi->metadata_only);
 
-		/*
-		 * If we have not locked the extent range, because the range's
-		 * start offset is >= i_size, we might still have a non-NULL
-		 * cached extent state, acquired while marking the extent range
-		 * as delalloc through btrfs_dirty_pages(). Therefore free any
-		 * possible cached extent state to avoid a memory leak.
-		 */
-		if (bi->extents_locked)
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     bi->lockstart, bi->lockend,
-					     &bi->cached_state);
-		else
-			free_extent_state(bi->cached_state);
-		bi->extents_locked = false;
-
-		btrfs_delalloc_release_extents(BTRFS_I(inode), bi->reserved_bytes);
 		if (ret) {
 			btrfs_drop_pages(pages, num_pages);
 			break;
 		}
 
+		btrfs_buffered_iomap_end(inode, pos, write_bytes, copied, bi);
+
 		release_bytes = 0;
 		if (bi->metadata_only)
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
-- 
2.31.1

