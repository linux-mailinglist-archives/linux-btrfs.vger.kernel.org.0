Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024633A58C5
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhFMNmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34548 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhFMNme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6D3A21973;
        Sun, 13 Jun 2021 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33EPwHwzBIXafkpmpclsPvxySz1Fq/J7myQK+g42hTk=;
        b=fj0iio22CqauRbqeg0/w+l+KtaSYXkdOrWrKr9Lm5fotflUzMXY4Ub1zyQHO6nfFlW7Ns1
        2xGIqhIGPi6UscH5r54er02kwAXaQnyFI/FjQRXi6JrzzFlJlKygydDIl0ahIiMRIOcHQN
        aVWKieoHab6INjhRWTiBEwFfpTkszJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33EPwHwzBIXafkpmpclsPvxySz1Fq/J7myQK+g42hTk=;
        b=Y8v0VM0bMYeyzU7DjsvZxGRTr5Gx5cGVYkB0Po6uh9q4D3oyzUeyki+JY2GclkyWtl5aSC
        nYX4MZuwbgtoYJCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 56C10118DD;
        Sun, 13 Jun 2021 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33EPwHwzBIXafkpmpclsPvxySz1Fq/J7myQK+g42hTk=;
        b=fj0iio22CqauRbqeg0/w+l+KtaSYXkdOrWrKr9Lm5fotflUzMXY4Ub1zyQHO6nfFlW7Ns1
        2xGIqhIGPi6UscH5r54er02kwAXaQnyFI/FjQRXi6JrzzFlJlKygydDIl0ahIiMRIOcHQN
        aVWKieoHab6INjhRWTiBEwFfpTkszJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33EPwHwzBIXafkpmpclsPvxySz1Fq/J7myQK+g42hTk=;
        b=Y8v0VM0bMYeyzU7DjsvZxGRTr5Gx5cGVYkB0Po6uh9q4D3oyzUeyki+JY2GclkyWtl5aSC
        nYX4MZuwbgtoYJCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id g9IdCdAKxmBeJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:32 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 10/31] btrfs: Add btrfs_map_blocks to for iomap_writeback_ops
Date:   Sun, 13 Jun 2021 08:39:38 -0500
Message-Id: <5a0fbde3961d867e810a22d240882a91f4f81bba.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_map_blocks() runs delayed allocation range to allcate new CoW
space if required and returns the io_map associated with the
location to write.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5491d0e5600f..eff4ec44fecd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8283,6 +8283,77 @@ int btrfs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+static int find_delalloc_range(struct inode *inode, u64 *start, u64 *end)
+{
+	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
+	bool found;
+	int ret;
+	struct extent_state *cached = NULL;
+
+	/* Find the range */
+	found = btrfs_find_delalloc_range(tree, start, end,
+			BTRFS_MAX_EXTENT_SIZE, &cached);
+	if (!found)
+		return -EIO;
+
+	lock_extent(tree, *start, *end);
+
+	/* Verify it is set to delalloc */
+	ret = test_range_bit(tree, *start, *end,
+			EXTENT_DELALLOC, 1, cached);
+	return ret;
+}
+
+static int btrfs_set_iomap(struct inode *inode, loff_t pos,
+			   loff_t length, struct iomap *srcmap)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	loff_t sector_start = round_down(pos, fs_info->sectorsize);
+	struct extent_map *em;
+
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sector_start, length);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+
+	btrfs_em_to_iomap(inode, em, srcmap, sector_start);
+
+	free_extent_map(em);
+	return 0;
+}
+
+static int btrfs_map_blocks(struct iomap_writepage_ctx *wpc,
+		struct inode *inode, loff_t offset)
+{
+	int ret;
+	unsigned long nr_written; /* unused */
+	int page_started; /* unused */
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u64 start = round_down(offset, fs_info->sectorsize);
+	u64 end = 0;
+
+	/* Check if iomap is valid */
+	if (offset >= wpc->iomap.offset &&
+			offset < wpc->iomap.offset + wpc->iomap.length)
+		return 0;
+
+	ret = find_delalloc_range(inode, &start, &end);
+	if (ret < 0)
+		return ret;
+
+	ret = btrfs_run_delalloc_range(BTRFS_I(inode), NULL,
+			start, end, &page_started, &nr_written, NULL);
+	if (ret < 0)
+		return ret;
+
+	/* TODO: handle compressed extents */
+	return btrfs_set_iomap(inode, offset, end - offset, &wpc->iomap);
+}
+
+static const struct iomap_writeback_ops btrfs_writeback_ops = {
+	.map_blocks             = btrfs_map_blocks,
+};
+
+
 static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
-- 
2.31.1

