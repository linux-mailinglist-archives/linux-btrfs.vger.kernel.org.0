Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5629485F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440873AbgJUG2b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440872AbgJUG2a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WwtEX9GctKS04n+aWQNMJNQy7nnQbIwcQUC6nbpgzR8=;
        b=hA1KDPxObv8cefecz5Nks60lBgQvRCqbhh2QCUQRdwPYg2GSmCtSaJ1fcoQzbj7Qygx3BJ
        CYj84ORr6aBLvgZLC+0+Xu0d7QOqTHQiBl5mihHHWFrBN1lLpE5wvg3BFYeGCoH5mq5QYz
        ZyStmyl3eYjJ5PXIxXYkNS7bunUtx4w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A53EAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 67/68] btrfs: reflink: do full page writeback for reflink prepare
Date:   Wed, 21 Oct 2020 14:25:53 +0800
Message-Id: <20201021062554.68132-68-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we don't support subpage writeback yet, let
btrfs_remap_file_range_prep() to do full page writeback.

This only affects subpage support, as the regular sectorsize support
already has its sectorsize == PAGE_SIZE.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/reflink.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 5cd02514cf4d..e8023c1dcb5d 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -700,9 +700,15 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
-	u64 bs = BTRFS_I(inode_out)->root->fs_info->sb->s_blocksize;
+	/*
+	 * We don't support subpage write yet, thus for data writeback we
+	 * must use PAGE_SIZE here. But for reflink we still support proper
+	 * sector alignment.
+	 */
+	u32 wb_bs = PAGE_SIZE;
 	bool same_inode = inode_out == inode_in;
-	u64 wb_len;
+	u64 in_wb_len;
+	u64 out_wb_len;
 	int ret;
 
 	if (!(remap_flags & REMAP_FILE_DEDUP)) {
@@ -735,11 +741,21 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	 *    waits for the writeback to complete, i.e. for IO to be done, and
 	 *    not for the ordered extents to complete. We need to wait for them
 	 *    to complete so that new file extent items are in the fs tree.
+	 *
+	 * Also for subpage case, since at different offset the same length can
+	 * cover different number of pages, we have to calculate the wb_len for
+	 * each file.
 	 */
-	if (*len == 0 && !(remap_flags & REMAP_FILE_DEDUP))
-		wb_len = ALIGN(inode_in->i_size, bs) - ALIGN_DOWN(pos_in, bs);
-	else
-		wb_len = ALIGN(*len, bs);
+	if (*len == 0 && !(remap_flags & REMAP_FILE_DEDUP)) {
+		in_wb_len = round_up(inode_in->i_size, wb_bs) -
+			    round_down(pos_in, wb_bs);
+		out_wb_len = in_wb_len;
+	} else {
+		in_wb_len = round_up(pos_in + *len, wb_bs) -
+			    round_down(pos_in, wb_bs);
+		out_wb_len = round_up(pos_out + *len, wb_bs) -
+			     round_down(pos_out, wb_bs);
+	}
 
 	/*
 	 * Since we don't lock ranges, wait for ongoing lockless dio writes (as
@@ -771,12 +787,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (ret < 0)
 		return ret;
 
-	ret = btrfs_wait_ordered_range(inode_in, ALIGN_DOWN(pos_in, bs),
-				       wb_len);
+	ret = btrfs_wait_ordered_range(inode_in, round_down(pos_in, wb_bs),
+				       in_wb_len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_wait_ordered_range(inode_out, ALIGN_DOWN(pos_out, bs),
-				       wb_len);
+	ret = btrfs_wait_ordered_range(inode_out, round_down(pos_out, wb_bs),
+				       out_wb_len);
 	if (ret < 0)
 		return ret;
 
-- 
2.28.0

