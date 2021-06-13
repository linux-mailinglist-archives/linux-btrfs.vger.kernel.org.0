Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0213A58D1
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFMNnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNnD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FCB121972;
        Sun, 13 Jun 2021 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znXXNpFAe+aq+YAsUkY0lqM2azAuju2wzEFWUnhjD8E=;
        b=rAi/2znaRQsOtnopGHiIRzzyUQgevCBwNL1b0yoy/lj8xfBy5rZcWKRU5JkXL36MntQhUY
        ixbz8VifzyQOCIPwOVa21MfwFeXL4MDe7wyBLYFadzKwLYV/ow1ZEqDzMNsjxc9uWz4EvL
        qXVrA6+dQ4Gls8aGN0p6NNU3j8rmbzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znXXNpFAe+aq+YAsUkY0lqM2azAuju2wzEFWUnhjD8E=;
        b=X86wekEHyPOGI0QCifbh+5SHVMQmYoM4A8iQVpr4T213ko5J6y+FRvcT4W+8lIzz0nl7aM
        qP4+kMsUZimQujAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id DCF7B118DD;
        Sun, 13 Jun 2021 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znXXNpFAe+aq+YAsUkY0lqM2azAuju2wzEFWUnhjD8E=;
        b=rAi/2znaRQsOtnopGHiIRzzyUQgevCBwNL1b0yoy/lj8xfBy5rZcWKRU5JkXL36MntQhUY
        ixbz8VifzyQOCIPwOVa21MfwFeXL4MDe7wyBLYFadzKwLYV/ow1ZEqDzMNsjxc9uWz4EvL
        qXVrA6+dQ4Gls8aGN0p6NNU3j8rmbzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znXXNpFAe+aq+YAsUkY0lqM2azAuju2wzEFWUnhjD8E=;
        b=X86wekEHyPOGI0QCifbh+5SHVMQmYoM4A8iQVpr4T213ko5J6y+FRvcT4W+8lIzz0nl7aM
        qP4+kMsUZimQujAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id YT+nLewKxmCSJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:00 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 22/31] btrfs: Set extents delalloc in iomap_end
Date:   Sun, 13 Jun 2021 08:39:50 -0500
Message-Id: <ce5ebbefe63ebdc909fa596a174f870120657472.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since the new code path would not be calling btrfs_dirty_pages(),
set extent delalloc for the extent just written.
In order to make the flow easier, modify btrfs_buffered_iomap_end() to
use written_block_end and block_end to calculate respective written and
length sectorsize boundaries.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 58 +++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ab2b1790e0bb..d311b01a2b71 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1682,44 +1682,38 @@ static int btrfs_buffered_iomap_end(struct inode *inode, loff_t pos,
 		loff_t length, ssize_t written, struct btrfs_iomap *bi)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	size_t num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bi->reserved_bytes);
-	size_t dirty_sectors = 0;
-	int dirty_pages = 0;
-	int sector_offset = pos & (fs_info->sectorsize - 1);
-
-	if (written) {
-		dirty_sectors = round_up(written + sector_offset,
-				fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
-		dirty_pages = DIV_ROUND_UP(written + offset_in_page(pos),
-				PAGE_SIZE);
-	}
+	int ret = 0;
+	size_t release_bytes = 0;
+	u64 start = round_down(pos, fs_info->sectorsize);
+	u64 written_block_end = round_up(pos + written, fs_info->sectorsize) - 1;
+	u64 block_end = round_up(pos + length, fs_info->sectorsize) - 1;
+        int extra_bits = 0;
 
-	/* Release excess reservations */
-	if (num_sectors > dirty_sectors) {
-		size_t release_bytes = bi->reserved_bytes -
-			(dirty_sectors << fs_info->sb->s_blocksize_bits);
-		if (bi->metadata_only) {
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					release_bytes, true);
-		} else {
-			u64 p;
+	if (written == 0)
+		release_bytes = bi->reserved_bytes;
+	else if (written < length)
+		release_bytes = block_end - written_block_end + 1;
 
-			p = round_down(pos,
-					fs_info->sectorsize) +
-				(dirty_pages << PAGE_SHIFT);
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					bi->data_reserved, p,
-					release_bytes, true);
-		}
-	}
+	if (bi->metadata_only)
+		extra_bits |= EXTENT_NORESERVE;
+
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, start, written_block_end,
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
+			 0, 0, &bi->cached_state);
+
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), start,
+			written_block_end, extra_bits, &bi->cached_state);
+
+	/* In case of error, release everything in btrfs_iomap_release() */
+	if (ret < 0)
+		release_bytes = bi->reserved_bytes;
 
 	/*
 	 * If we have not locked the extent range, because the range's
 	 * start offset is >= i_size, we might still have a non-NULL
 	 * cached extent state, acquired while marking the extent range
-	 * as delalloc through btrfs_dirty_pages(). Therefore free any
-	 * possible cached extent state to avoid a memory leak.
+	 * as delalloc. Therefore free any possible cached extent state
+	 * to avoid a memory leak.
 	 */
 	if (bi->extents_locked)
 		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
@@ -1732,6 +1726,8 @@ static int btrfs_buffered_iomap_end(struct inode *inode, loff_t pos,
 	if (bi->metadata_only)
 		btrfs_check_nocow_unlock(BTRFS_I(inode));
 
+	btrfs_iomap_release(inode, pos, release_bytes, bi);
+
 	return 0;
 }
 
-- 
2.31.1

