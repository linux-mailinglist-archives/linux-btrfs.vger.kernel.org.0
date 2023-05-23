Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5B70D702
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjEWIQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjEWIPl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD810CC
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nC/qJvdFdtjTS9OPWbA/jIIFGrcXX3cLaOhvCrxYDw4=; b=ZVYMf2P5E2feuWqbJGSzearml/
        HCf8yXpyjrj/bbybkXAcHyZZW1UgJgo7pOdYDU6mCLUPPcIPmDcJCvBmxMXLBJmTeFTOy1P2V/oLG
        JMaShpOri8MiB0C298211YlLqGngDEnv6/O8Mnn63f18yovrCVctnJGs0rq+6Je9C6u2CQgsieOG9
        DQS6aa7/cLofMpBQ/7uqwv58AiHOUa6YKcccI3uEXOGYcIaBUoTYz9RYKhd01k5xkzHIFqKsbT4OT
        i/e5LtTDM5kKsglzJPpylZosbhl5dH7uS8G/wy7R2lgUP2BgqWhNfFG2vnQA6Mmu3AmDen1FMbzyt
        L+0Ahb1A==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9V-009OWc-1e;
        Tue, 23 May 2023 08:13:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/16] btrfs: remove non-standard extent handling in __extent_writepage_io
Date:   Tue, 23 May 2023 10:13:16 +0200
Message-Id: <20230523081322.331337-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__extent_writepage_io is never called for compressed or inline extents,
or holes.  Remove the not quite working code for them and replace it with
asserts that these cases don't happen.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8b9e4980d8189c..6151b38add8759 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1361,7 +1361,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	struct extent_map *em;
 	int ret = 0;
 	int nr = 0;
-	bool compressed;
 
 	ret = btrfs_writepage_cow_fixup(page);
 	if (ret) {
@@ -1419,10 +1418,14 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		ASSERT(cur < end);
 		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
 		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
+
 		block_start = em->block_start;
-		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		disk_bytenr = em->block_start + extent_offset;
 
+		ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
+		ASSERT(block_start != EXTENT_MAP_HOLE);
+		ASSERT(block_start != EXTENT_MAP_INLINE);
+
 		/*
 		 * Note that em_end from extent_map_end() and dirty_range_end from
 		 * find_next_dirty_byte() are all exclusive
@@ -1431,22 +1434,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		free_extent_map(em);
 		em = NULL;
 
-		/*
-		 * compressed and inline extents are written through other
-		 * paths in the FS
-		 */
-		if (compressed || block_start == EXTENT_MAP_HOLE ||
-		    block_start == EXTENT_MAP_INLINE) {
-			if (compressed)
-				nr++;
-			else
-				btrfs_writepage_endio_finish_ordered(inode,
-						page, cur, cur + iosize - 1, true);
-			btrfs_page_clear_dirty(fs_info, page, cur, iosize);
-			cur += iosize;
-			continue;
-		}
-
 		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
 			btrfs_err(inode->root->fs_info,
-- 
2.39.2

