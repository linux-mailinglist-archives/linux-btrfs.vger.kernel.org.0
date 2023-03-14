Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F906B8B1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCNGR7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCNGR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACDE2658A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HC9/VdYhrN0IrsPz1W78MfWec8WlajBSNeVSbs1KyXo=; b=fqBTamwBMIGXbS31b7QDV8RoyK
        pMIOeebmi41OoZ7dlghppAvIto8T9nMXNIDWlBbxYI+5jwV4jBkisgMrGsT7Fxdn0G2tx1evYeuaq
        2WuhLOGpZCU6NsonWz6Dsy+LGO2af8RzybJbi+KAk67+gxvYDySjvvLf9S2+jfh2suZKWCson3qzt
        FUvJImFn7E2zwMRwfebqIMoHfaR6Mw5XW6LuuGK+t/gSnYfa4Xgp5VHgTFvyg/UaCBXPrA59tA4bp
        nHGRV41RekIS9IjYb/t23ZbUX8/RPTGIG4/diQNjiG9FHhwsV6gaaTyIc5FZoSJCyu/ozL6omiLAC
        Uh205z3A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxys-009Ar5-IO; Tue, 14 Mar 2023 06:17:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/21] btrfs: stop using lock_extent in btrfs_buffer_uptodate
Date:   Tue, 14 Mar 2023 07:16:53 +0100
Message-Id: <20230314061655.245340-20-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only other place that locks extents on the btree inode is
read_extent_buffer_subpage while reading in the partial page for a
buffer.  This means locking the extent in btrfs_buffer_uptodate does not
synchronize with anything on non-supage file systems, and on subpage
file systems it only waits for a parallel read(-ahead) to finish,
which seems to be counter to what the callers actually expect.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e007e15e1455e1..2f62852348cc6d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -113,11 +113,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
 			  int atomic)
 {
-	struct inode *btree_inode = eb->pages[0]->mapping->host;
-	struct extent_io_tree *io_tree = &BTRFS_I(btree_inode)->io_tree;
-	struct extent_state *cached_state = NULL;
-	int ret = 1;
-
 	if (!extent_buffer_uptodate(eb))
 		return 0;
 
@@ -127,7 +122,6 @@ int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
 	if (atomic)
 		return -EAGAIN;
 
-	lock_extent(io_tree, eb->start, eb->start + eb->len - 1, &cached_state);
 	if (!extent_buffer_uptodate(eb) ||
 	    btrfs_header_generation(eb) != parent_transid) {
 		btrfs_err_rl(eb->fs_info,
@@ -135,11 +129,9 @@ int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
 			eb->start, eb->read_mirror,
 			parent_transid, btrfs_header_generation(eb));
 		clear_extent_buffer_uptodate(eb);
-		ret = 0;
+		return 0;
 	}
-	unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
-		      &cached_state);
-	return ret;
+	return 1;
 }
 
 static bool btrfs_supported_super_csum(u16 csum_type)
-- 
2.39.2

