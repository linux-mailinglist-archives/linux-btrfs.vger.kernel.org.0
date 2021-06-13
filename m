Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D43A58CC
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhFMNmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55434 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 968741FD2D;
        Sun, 13 Jun 2021 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=817jSEC+Ks6fELKz59lWJQgVXpski9/T9iIR9yuHxSM=;
        b=B39gS6OtqZGHGVf9u0kag8BShGB83aOFlxrHGvLRG2Oy+MLdg04Bv7IE2hcW4aEHeqWg/E
        JF3ry8a1IawiH60G5oU93ZDccpJL05+PiEpEq7iHrWqKDXpwzvdR8VmrTh92VI+nGUiRaR
        3g1WZVy0yeuLLWSCI6QBXxZHs1htNAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=817jSEC+Ks6fELKz59lWJQgVXpski9/T9iIR9yuHxSM=;
        b=sMt4DpmdNdbUMgHwBgSjq7p5PZh/EIGtzH2ttwLefImgumZEaNKIoIgtBFc3sRXWijcqBZ
        TBeN+5WPNLd83VDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3F2A6118DD;
        Sun, 13 Jun 2021 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=817jSEC+Ks6fELKz59lWJQgVXpski9/T9iIR9yuHxSM=;
        b=B39gS6OtqZGHGVf9u0kag8BShGB83aOFlxrHGvLRG2Oy+MLdg04Bv7IE2hcW4aEHeqWg/E
        JF3ry8a1IawiH60G5oU93ZDccpJL05+PiEpEq7iHrWqKDXpwzvdR8VmrTh92VI+nGUiRaR
        3g1WZVy0yeuLLWSCI6QBXxZHs1htNAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=817jSEC+Ks6fELKz59lWJQgVXpski9/T9iIR9yuHxSM=;
        b=sMt4DpmdNdbUMgHwBgSjq7p5PZh/EIGtzH2ttwLefImgumZEaNKIoIgtBFc3sRXWijcqBZ
        TBeN+5WPNLd83VDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id hfhHB+EKxmB+JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:49 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 17/31] btrfs: Introduce btrfs_iomap
Date:   Sun, 13 Jun 2021 08:39:45 -0500
Message-Id: <23b8bc9426ff2de7cf4345c21df8d0c9c36dffa6.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

A structure which will be used to transfer information from
iomap_begin() to iomap_end().

Move all locking information into btrfs_iomap.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a94ab3c8da1d..a28435a6bb7e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -56,6 +56,15 @@ struct inode_defrag {
 	int cycled;
 };
 
+struct btrfs_iomap {
+
+	/* Locking */
+	u64 lockstart;
+	u64 lockend;
+	struct extent_state *cached_state;
+	int extents_locked;
+};
+
 static int __compare_inode_defrag(struct inode_defrag *defrag1,
 				  struct inode_defrag *defrag2)
 {
@@ -1599,14 +1608,13 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	struct page **pages = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	u64 release_bytes = 0;
-	u64 lockstart;
-	u64 lockend;
 	size_t num_written = 0;
 	int nrptrs;
 	ssize_t ret;
 	bool only_release_metadata = false;
 	loff_t old_isize = i_size_read(inode);
 	unsigned int ilock_flags = 0;
+	struct btrfs_iomap *bi = NULL;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1634,6 +1642,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		goto out;
 	}
 
+	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
+	if (!bi) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
 		size_t offset = offset_in_page(pos);
@@ -1647,7 +1661,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		size_t copied;
 		size_t dirty_sectors;
 		size_t num_sectors;
-		int extents_locked = false;
 
 		/*
 		 * Fault pages before locking them in prepare_pages
@@ -1658,6 +1671,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			break;
 		}
 
+		bi->extents_locked = false;
 		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
 
@@ -1698,11 +1712,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		release_bytes = reserve_bytes;
 
 		if (pos < inode->i_size) {
-			lockstart = round_down(pos, fs_info->sectorsize);
-			lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
+			bi->lockstart = round_down(pos, fs_info->sectorsize);
+			bi->lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
 			btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
-					lockstart, lockend, &cached_state);
-			extents_locked = true;
+					bi->lockstart, bi->lockend,
+					&cached_state);
+			bi->extents_locked = true;
 		}
 
 		/*
@@ -1715,11 +1730,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
-			if (extents_locked)
-				unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-						lockstart, lockend, &cached_state);
-			else
-				free_extent_state(cached_state);
 			break;
 		}
 
@@ -1777,12 +1787,13 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 * as delalloc through btrfs_dirty_pages(). Therefore free any
 		 * possible cached extent state to avoid a memory leak.
 		 */
-		if (extents_locked)
+		if (bi->extents_locked)
 			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     lockstart, lockend, &cached_state);
+					     bi->lockstart, bi->lockend,
+					     &bi->cached_state);
 		else
-			free_extent_state(cached_state);
-		extents_locked = false;
+			free_extent_state(bi->cached_state);
+		bi->extents_locked = false;
 
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
@@ -1825,6 +1836,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		iocb->ki_pos += num_written;
 	}
 out:
+	kfree(bi);
 	btrfs_inode_unlock(inode, ilock_flags);
 	return num_written ? num_written : ret;
 }
-- 
2.31.1

