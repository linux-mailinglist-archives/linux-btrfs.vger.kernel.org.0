Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4D3A58CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhFMNm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34580 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:58 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA23D21972;
        Sun, 13 Jun 2021 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+/hZrO15Vf4vY/d/brckWzoWlmW2Z5wUX3vyyNhiWo=;
        b=2VYk/JXOXD5WsYHucmi0wGjG4CYc9UmWYlLuXiAjxtLroa+a17XvmWL6OIsFSbeB22AQXO
        h7nk2OT0DEsN6vISvK9ecXr7sSn5x7/Fp98P3S+5GEwfgHZVuuwRcBs0O/sIyATe/LcinB
        OuzB3RhvL4z29tKuA/jG/t0s4mIVmVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+/hZrO15Vf4vY/d/brckWzoWlmW2Z5wUX3vyyNhiWo=;
        b=DKv5PZxzF2s/uJafic7iy6Cu8WKpDj3FkM4h6fqwYm2k8Jl8N8urKElLGV7uYehWqfvcIP
        nvNSYtvtUSkrb4CA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 34AB7118DD;
        Sun, 13 Jun 2021 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+/hZrO15Vf4vY/d/brckWzoWlmW2Z5wUX3vyyNhiWo=;
        b=2VYk/JXOXD5WsYHucmi0wGjG4CYc9UmWYlLuXiAjxtLroa+a17XvmWL6OIsFSbeB22AQXO
        h7nk2OT0DEsN6vISvK9ecXr7sSn5x7/Fp98P3S+5GEwfgHZVuuwRcBs0O/sIyATe/LcinB
        OuzB3RhvL4z29tKuA/jG/t0s4mIVmVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+/hZrO15Vf4vY/d/brckWzoWlmW2Z5wUX3vyyNhiWo=;
        b=DKv5PZxzF2s/uJafic7iy6Cu8WKpDj3FkM4h6fqwYm2k8Jl8N8urKElLGV7uYehWqfvcIP
        nvNSYtvtUSkrb4CA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id uBu7AOgKxmCKJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:56 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 20/31] btrfs: Carve out btrfs_buffered_iomap_begin() from write path
Date:   Sun, 13 Jun 2021 08:39:48 -0500
Message-Id: <bc0e662fb8728a4cec08e6ce4000971819ede942.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Carve out reservation and locking from bufferd write sequence in
btrfs_buffered_iomap_begin().

Shortcomings: page handling with respect to nrptrs is messed up.
However, since we will be passing the responsibility of pages to iomap,
this will not be problem.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 100 ++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ccae8ce7ec4f..5751bb5e0656 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1627,6 +1627,57 @@ static void btrfs_iomap_release(struct inode *inode,
 	kfree(bi);
 }
 
+static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
+		size_t length, struct btrfs_iomap *bi)
+{
+	int ret;
+	size_t write_bytes = length;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	size_t sector_offset = pos & (fs_info->sectorsize - 1);
+
+	ret = btrfs_check_data_free_space(BTRFS_I(inode),
+			&bi->data_reserved, pos, write_bytes);
+	if (ret < 0) {
+		/*
+		 * If we don't have to COW at the offset, reserve
+		 * metadata only. write_bytes may get smaller than
+		 * requested here.
+		 */
+		if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
+					&write_bytes) > 0)
+			bi->metadata_only = true;
+		else
+			return ret;
+	}
+
+	bi->reserved_bytes = round_up(write_bytes + sector_offset,
+			fs_info->sectorsize);
+	WARN_ON(bi->reserved_bytes == 0);
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
+			bi->reserved_bytes);
+	if (ret) {
+		if (!bi->metadata_only)
+			btrfs_free_reserved_data_space(BTRFS_I(inode),
+					bi->data_reserved, pos,
+					write_bytes);
+		else
+			btrfs_check_nocow_unlock(BTRFS_I(inode));
+		return ret;
+	}
+
+	if (pos < inode->i_size) {
+		bi->lockstart = round_down(pos, fs_info->sectorsize);
+		bi->lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
+		btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
+				bi->lockstart, bi->lockend,
+				&bi->cached_state);
+		bi->extents_locked = true;
+	}
+
+	return 0;
+
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1701,50 +1752,15 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		sector_offset = pos & (fs_info->sectorsize - 1);
 
 		extent_changeset_release(bi->data_reserved);
-		ret = btrfs_check_data_free_space(BTRFS_I(inode),
-						  &bi->data_reserved, pos,
-						  write_bytes);
-		if (ret < 0) {
-			/*
-			 * If we don't have to COW at the offset, reserve
-			 * metadata only. write_bytes may get smaller than
-			 * requested here.
-			 */
-			if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
-						   &write_bytes) > 0)
-				bi->metadata_only = true;
-			else
-				break;
-		}
 
-		num_pages = DIV_ROUND_UP(write_bytes + offset, PAGE_SIZE);
-		WARN_ON(num_pages > nrptrs);
-		bi->reserved_bytes = round_up(write_bytes + sector_offset,
-					 fs_info->sectorsize);
-		WARN_ON(bi->reserved_bytes == 0);
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				bi->reserved_bytes);
-		if (ret) {
-			if (!bi->metadata_only)
-				btrfs_free_reserved_data_space(BTRFS_I(inode),
-						bi->data_reserved, pos,
-						write_bytes);
-			else
-				btrfs_check_nocow_unlock(BTRFS_I(inode));
-			break;
-		}
-
-		release_bytes = bi->reserved_bytes;
+		ret = btrfs_buffered_iomap_begin(inode, pos, write_bytes,
+				bi);
 
-		if (pos < inode->i_size) {
-			bi->lockstart = round_down(pos, fs_info->sectorsize);
-			bi->lockend = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
-			btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
-					bi->lockstart, bi->lockend,
-					&bi->cached_state);
-			bi->extents_locked = true;
-		}
+		if (ret < 0)
+			goto out;
 
+		num_pages = DIV_ROUND_UP(write_bytes + offset, PAGE_SIZE);
+		WARN_ON(num_pages > nrptrs);
 		/*
 		 * This is going to setup the pages array with the number of
 		 * pages we want, so we don't really need to worry about the
@@ -1780,6 +1796,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 						   PAGE_SIZE);
 		}
 
+		release_bytes = bi->reserved_bytes;
+
 		if (num_sectors > dirty_sectors) {
 			/* release everything except the sectors we dirtied */
 			release_bytes -= dirty_sectors << fs_info->sectorsize_bits;
-- 
2.31.1

