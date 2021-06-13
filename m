Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2E3A58D7
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhFMNnS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C32921970;
        Sun, 13 Jun 2021 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGXS7gxOb+12aVOmu+jitXQx/RU1aR6UUDQhT8W6LUQ=;
        b=KSAC2gRfKJ3fdzRyBoDf8DO5NPcDCK0ZBofnF8xXjHYoM8RQ/RXYcPt4tinxyU2tYLAE/7
        kJTMEjFgk3hwuAhXZ736vQHb7t8gTY699jgV3ah+u/CYc4QmLoUGxjmom8E02xo9PdahKt
        ihLGQwvTOOPyD520xSDpbMprW4txNgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGXS7gxOb+12aVOmu+jitXQx/RU1aR6UUDQhT8W6LUQ=;
        b=nBymWOz5BFipOr133y9TQb3F2rxvmyMO5PVMro5bDLkVl4EuhF+eAEPpPeLtB6cZ3uGNme
        wvIkUZMOrH4qn0AQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8B081118DD;
        Sun, 13 Jun 2021 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGXS7gxOb+12aVOmu+jitXQx/RU1aR6UUDQhT8W6LUQ=;
        b=KSAC2gRfKJ3fdzRyBoDf8DO5NPcDCK0ZBofnF8xXjHYoM8RQ/RXYcPt4tinxyU2tYLAE/7
        kJTMEjFgk3hwuAhXZ736vQHb7t8gTY699jgV3ah+u/CYc4QmLoUGxjmom8E02xo9PdahKt
        ihLGQwvTOOPyD520xSDpbMprW4txNgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGXS7gxOb+12aVOmu+jitXQx/RU1aR6UUDQhT8W6LUQ=;
        b=nBymWOz5BFipOr133y9TQb3F2rxvmyMO5PVMro5bDLkVl4EuhF+eAEPpPeLtB6cZ3uGNme
        wvIkUZMOrH4qn0AQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id NispFvsKxmCoJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:15 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 28/31] btrfs: iomap_begin() for buffered read
Date:   Sun, 13 Jun 2021 08:39:56 -0500
Message-Id: <55e7d9c0cb329323d11f7782da1e69bb7ca9ccff.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Lock the extents before performing a read.
Convert the offset/length to iomap by calling btrfs_em_to_iomap().
If reading from a hole, unlock the extent because iomap provides page
with zeros set.

Lock only the range on which iomap I/O can be performed. If iomap is
lesser than requested range, unlock extents beyond iomap
range.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index be0caf3a11f9..6b9b238837b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8267,6 +8267,56 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
 }
 
+
+static int btrfs_read_iomap_begin(struct inode *inode, loff_t pos,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	struct extent_state *cached_state = NULL;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct extent_map *em;
+	u64 start = round_down(pos, fs_info->sectorsize);
+	u64 end = round_up(pos + length, fs_info->sectorsize) - 1;
+
+	/* Lock the extent */
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode),
+			start, end, &cached_state);
+
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, end - start + 1);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+
+	btrfs_em_to_iomap(inode, em, iomap, start);
+	iomap->private = em;
+
+	if (iomap->type == IOMAP_HOLE) {
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+				start, end, &cached_state);
+	} else if (end > iomap->offset + iomap->length) {
+		/* Unlock part beyond iomap */
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+				iomap->offset + iomap->length,
+				end, &cached_state);
+	}
+
+	return 0;
+}
+
+static int btrfs_read_iomap_end(struct inode *inode, loff_t pos,
+		loff_t length, ssize_t written, unsigned int flags,
+		struct iomap *iomap)
+{
+	struct extent_map *em = iomap->private;
+
+	free_extent_map(em);
+	return 0;
+}
+
+const struct iomap_ops btrfs_buffered_read_iomap_ops = {
+	.iomap_begin = btrfs_read_iomap_begin,
+	.iomap_end = btrfs_read_iomap_end,
+};
+
 int btrfs_readpage(struct file *file, struct page *page)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-- 
2.31.1

