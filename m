Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36F535BCB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349824AbiE0Inu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240856AbiE0Ins (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DDC5DE6B
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BXrGfpWzqdUsxu1+Zb9reao9QfbVhtK7A+dHaXIVexk=; b=sRVQ6GIyg1PnwaeNzsXdENvGVZ
        ZlG5SUd1oMvGPMk2FhzugDlj0S3UNL6hRI9r9lDM5BXCfe65eLy43hcT2wwLlcQ2RbnYHGcVEzp/y
        ecrBQJrpyKrMeYV+h71mE7xS/kMHEiO3zBrRxX+/XHKgvdYolGnAs2LsodILQra6oBJn6gFrNWH8C
        h9Csy4GfzGE1pW7J8ZW7J+6MhyO1HU0dDA8b6bzg0v1cGLQ8bOnsYdNZlbB8RDirq/nawsnNC2Yxx
        mjTpUD3oAiPt4al3biSh5NF7uW7xzf2a3SmeOFyT8Hc4I4mbWklxHxShITpTLz2LOprOYX7BpNyd4
        FIAEkVjg==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZR-00H3an-Bw; Fri, 27 May 2022 08:43:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure
Date:   Fri, 27 May 2022 10:43:20 +0200
Message-Id: <20220527084320.2130831-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
References: <20220527084320.2130831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fold repair_io_failure into the only remaining caller.

This is still inefficient with single page I/Os, but I have some ideas
on how to improve the metadata repair in the future.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 51 +++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c0cb3d4f5440f..57a709262b730 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2225,35 +2225,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
-static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			     u64 length, u64 logical, struct page *page,
-			     unsigned int pg_offset, int mirror_num)
-{
-	struct bio_vec bvec;
-	struct bio bio;
-	int ret;
-
-	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
-	BUG_ON(!mirror_num);
-
-	if (btrfs_repair_one_zone(fs_info, logical))
-		return 0;
-
-	bio_init(&bio, NULL, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
-	bio.bi_iter.bi_sector = logical >> 9;
-	__bio_add_page(&bio, page, length, pg_offset);
-	ret = btrfs_map_repair_bio(fs_info, &bio, mirror_num);
-	bio_uninit(&bio);
-
-	if (ret)
-		return ret;
-
-	btrfs_info_rl_in_rcu(fs_info,
-		"read error corrected: ino %llu off %llu (logical %llu)",
-			  ino, start, logical);
-	return 0;
-}
-
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -2261,20 +2232,32 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	int i, num_pages = num_extent_pages(eb);
 	int ret = 0;
 
+	WARN_ON_ONCE(!mirror_num);
+
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
+	if (btrfs_repair_one_zone(fs_info, eb->start))
+		return 0;
+
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
+		struct bio_vec bvec;
+		struct bio bio;
+
+		bio_init(&bio, NULL, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
+		bio.bi_iter.bi_sector = start >> 9;
+		__bio_add_page(&bio, p, PAGE_SIZE, start - page_offset(p));
+		ret = btrfs_map_repair_bio(fs_info, &bio, mirror_num);
+		bio_uninit(&bio);
 
-		ret = repair_io_failure(fs_info, 0, start, PAGE_SIZE, start, p,
-					start - page_offset(p), mirror_num);
 		if (ret)
-			break;
-		start += PAGE_SIZE;
+			return ret;
 	}
 
-	return ret;
+	btrfs_info_rl_in_rcu(fs_info,
+		"metadata read error corrected: logical %llu.", eb->start);
+	return 0;
 }
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
-- 
2.30.2

