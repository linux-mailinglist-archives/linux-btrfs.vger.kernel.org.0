Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4708C703DA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbjEOTXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbjEOTXb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 15:23:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895714E59
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JAQ7Cj65o/H2xA1SVNn/k6h3P7JM83GskdANJ+0AMWo=; b=mlizXNkSPTmXX3vfIFrBMVXDdO
        8/D7SB4cb41hIJ0ChamzoHXqVsgl2ez0xzZ2B4chlbY4MQXg4S1u4I6Fo1xjdaaMetX4i1ceHOkgY
        yoEQ5GMuMWlqunEH/uCBegcJ8E2xvWroUW1QjyEDjHBDO2W66tkm+AhsHLraxmP2TfH2jVbpKwrPL
        PbHlHfOxiiApskP3Tpj2WJT2r2xVaKJaZ2a/j3EFfJAD/TpJazgHQWCavARsXmYMXOrSpb+RjZYSZ
        dkTy8rmTb/GZkw16g3xy7XP9hqLqlWoNWQbYd0oouKxVElrfFTr3bjLcY4ZLcmcj+GogMqtv0Fabx
        WZX2x+Cg==;
Received: from [2001:4bb8:188:2249:ad42:acf3:6731:a041] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pydn3-003HIL-2H;
        Mon, 15 May 2023 19:23:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: move locking and write pointer checking into write_one_eb
Date:   Mon, 15 May 2023 21:22:55 +0200
Message-Id: <20230515192256.29006-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515192256.29006-1-hch@lst.de>
References: <20230515192256.29006-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently only submit_eb_page contains handling for checking against the
write pointer on zoned devices.  This is ok as there is no support for
block size < PAGE_SIZE with zoned devices at the moment, but prevents
us from easily adding new callers of write_one_eb without breaking zoned
device support.

Move the call tolock_extent_buffer_for_io as well as the write pointer
checking and related code into write_one_eb.  To be able to do this,
write_one_eb now needs to set the eb_context pointer if the caller
passed in a non-NULL argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 69 +++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1205b3a3147e7d..c291fc728db047 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1759,12 +1759,39 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	}
 }
 
-static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
-					    struct writeback_control *wbc)
+static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
+					   struct writeback_control *wbc,
+					   struct extent_buffer **eb_context)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_block_group *zoned_bg = NULL;
 	struct btrfs_bio *bbio;
 
+	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &zoned_bg)) {
+		/*
+		 * If for_sync, this hole will be filled with
+		 * trasnsaction commit.
+		 */
+		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
+			return -EAGAIN;
+		return 0;
+	}
+
+	if (eb_context)
+		*eb_context = eb;
+
+	if (!lock_extent_buffer_for_io(eb, wbc)) {
+		btrfs_revert_meta_write_pointer(zoned_bg, eb);
+		return 0;
+	}
+
+	/*
+	 * A non-NULL zoned_bg implies zoned mode and that we are writing the
+	 * last possible block in the zone.
+	 */
+	if (zoned_bg)
+		btrfs_schedule_zone_finish_bg(zoned_bg, eb);
+
 	prepare_eb_write(eb);
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
@@ -1801,6 +1828,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		}
 	}
 	btrfs_submit_bio(bbio, 0);
+	return 1;
 }
 
 /*
@@ -1868,11 +1896,8 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 		 */
 		if (!eb)
 			continue;
-
-		if (lock_extent_buffer_for_io(eb, wbc)) {
-			write_one_eb(eb, wbc);
+		if (write_one_eb(eb, wbc, NULL) > 0)
 			submitted++;
-		}
 		free_extent_buffer(eb);
 	}
 	return submitted;
@@ -1902,7 +1927,6 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
-	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -1937,36 +1961,9 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	spin_unlock(&mapping->private_lock);
 	if (!ret)
 		return 0;
-
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
-		/*
-		 * If for_sync, this hole will be filled with
-		 * trasnsaction commit.
-		 */
-		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
-			ret = -EAGAIN;
-		else
-			ret = 0;
-		free_extent_buffer(eb);
-		return ret;
-	}
-
-	*eb_context = eb;
-
-	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(cache, eb);
-		free_extent_buffer(eb);
-		return 0;
-	}
-	if (cache) {
-		/*
-		 * Implies write in zoned mode. Mark the last eb in a block group.
-		 */
-		btrfs_schedule_zone_finish_bg(cache, eb);
-	}
-	write_one_eb(eb, wbc);
+	ret = write_one_eb(eb, wbc, eb_context);
 	free_extent_buffer(eb);
-	return 1;
+	return ret;
 }
 
 int btree_write_cache_pages(struct address_space *mapping,
-- 
2.39.2

