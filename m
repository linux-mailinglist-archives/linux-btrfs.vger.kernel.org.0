Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2353C5C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 09:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiFCHLQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbiFCHLN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 03:11:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53A23120A
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=np4lqrvxfj+ybb3zClPTYaDkwLYvpz//Rs6ebgPwVYs=; b=e2zD+zp8mOU95jK5Q9j2qnJy4k
        r1FoxHdMpvs3pUgbUYiIODWFIBPbnhVm2rZEFwQnE67otNxqyQ/+Z+TSXh+c27d/VkHaYhTsx5Q33
        ne+FrvYIPrp5vE40eNJUVDxHAiqUV87SxyxckxgfIkqHjXrQ6ZdJcS8tbULX3iHqPDUOORfy1eLvb
        4CBgjO2vac3Ql2WFS9IXbbrJowY/ud5SP/ATY9W+x9yF3yE4R3fggQ5DKbxr6xNuNWlzR4hPRulVo
        E5SSevdZLJYXZqm20dJ59yJILegGX4pEYnfX8g4UlWRAncpAZZ28lqdc6x5go0r1kAVNIu9yAjwY+
        OLvm47fg==;
Received: from [2001:4bb8:185:a81e:b29a:8b56:eb9a:ca3b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx1Sg-006Ems-EK; Fri, 03 Jun 2022 07:11:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: merge end_write_bio and flush_write_bio
Date:   Fri,  3 Jun 2022 09:11:02 +0200
Message-Id: <20220603071103.43440-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603071103.43440-1-hch@lst.de>
References: <20220603071103.43440-1-hch@lst.de>
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

Merge end_write_bio and flush_write_bio into a single submit_write_bio
helper, that either submits the bio or ends it if a negative errno was
passed in.  This consolidates a lot of duplicated checks in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 94 ++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 64 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 025349aeec31f..72a258fa27947 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -201,39 +201,26 @@ static void submit_one_bio(struct bio *bio, int mirror_num,
 	 */
 }
 
-/* Cleanup unsubmitted bios */
-static void end_write_bio(struct extent_page_data *epd, int ret)
-{
-	struct bio *bio = epd->bio_ctrl.bio;
-
-	if (bio) {
-		bio->bi_status = errno_to_blk_status(ret);
-		bio_endio(bio);
-		epd->bio_ctrl.bio = NULL;
-	}
-}
-
 /*
- * Submit bio from extent page data via submit_one_bio
- *
- * Return 0 if everything is OK.
- * Return <0 for error.
+ * Submit or fail the current bio in an extent_page_data structure.
  */
-static void flush_write_bio(struct extent_page_data *epd)
+static void submit_write_bio(struct extent_page_data *epd, int ret)
 {
 	struct bio *bio = epd->bio_ctrl.bio;
 
-	if (bio) {
+	if (!bio)
+		return;
+
+	if (ret) {
+		ASSERT(ret < 0);
+		bio->bi_status = errno_to_blk_status(ret);
+		bio_endio(bio);
+	} else {
 		submit_one_bio(bio, 0, 0);
-		/*
-		 * Clean up of epd->bio is handled by its endio function.
-		 * And endio is either triggered by successful bio execution
-		 * or the error handler of submit bio hook.
-		 * So at this point, no matter what happened, we don't need
-		 * to clean up epd->bio.
-		 */
-		epd->bio_ctrl.bio = NULL;
 	}
+
+	/* The bio is owned by the bi_end_io handler now */
+	epd->bio_ctrl.bio = NULL;
 }
 
 int __init extent_state_cache_init(void)
@@ -4248,7 +4235,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	int ret = 0;
 
 	if (!btrfs_try_tree_write_lock(eb)) {
-		flush_write_bio(epd);
+		submit_write_bio(epd, 0);
 		flush = 1;
 		btrfs_tree_lock(eb);
 	}
@@ -4258,7 +4245,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 		if (!epd->sync_io)
 			return 0;
 		if (!flush) {
-			flush_write_bio(epd);
+			submit_write_bio(epd, 0);
 			flush = 1;
 		}
 		while (1) {
@@ -4305,7 +4292,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 		if (!trylock_page(p)) {
 			if (!flush) {
-				flush_write_bio(epd);
+				submit_write_bio(epd, 0);
 				flush = 1;
 			}
 			lock_page(p);
@@ -4721,7 +4708,7 @@ static int submit_eb_subpage(struct page *page,
 
 cleanup:
 	/* We hit error, end bio for the submitted extent buffers */
-	end_write_bio(epd, ret);
+	submit_write_bio(epd, ret);
 	return ret;
 }
 
@@ -4900,10 +4887,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 		index = 0;
 		goto retry;
 	}
-	if (ret < 0) {
-		end_write_bio(&epd, ret);
-		goto out;
-	}
 	/*
 	 * If something went wrong, don't allow any metadata write bio to be
 	 * submitted.
@@ -4930,21 +4913,17 @@ int btree_write_cache_pages(struct address_space *mapping,
 	 *   Now such dirty tree block will not be cleaned by any dirty
 	 *   extent io tree. Thus we don't want to submit such wild eb
 	 *   if the fs already has error.
-	 */
-	if (!BTRFS_FS_ERROR(fs_info)) {
-		flush_write_bio(&epd);
-	} else {
-		ret = -EROFS;
-		end_write_bio(&epd, ret);
-	}
-out:
-	btrfs_zoned_meta_io_unlock(fs_info);
-	/*
+	 *
 	 * We can get ret > 0 from submit_extent_page() indicating how many ebs
 	 * were submitted. Reset it to 0 to avoid false alerts for the caller.
 	 */
 	if (ret > 0)
 		ret = 0;
+	if (!ret && BTRFS_FS_ERROR(fs_info))
+		ret = -EROFS;
+	submit_write_bio(&epd, ret);
+
+	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
@@ -5046,7 +5025,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * tmpfs file mapping
 			 */
 			if (!trylock_page(page)) {
-				flush_write_bio(epd);
+				submit_write_bio(epd, 0);
 				lock_page(page);
 			}
 
@@ -5057,7 +5036,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				if (PageWriteback(page))
-					flush_write_bio(epd);
+					submit_write_bio(epd, 0);
 				wait_on_page_writeback(page);
 			}
 
@@ -5097,7 +5076,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		 * page in our current bio, and thus deadlock, so flush the
 		 * write bio here.
 		 */
-		flush_write_bio(epd);
+		submit_write_bio(epd, 0);
 		goto retry;
 	}
 
@@ -5118,13 +5097,7 @@ int extent_write_full_page(struct page *page, struct writeback_control *wbc)
 	};
 
 	ret = __extent_writepage(page, wbc, &epd);
-	ASSERT(ret <= 0);
-	if (ret < 0) {
-		end_write_bio(&epd, ret);
-		return ret;
-	}
-
-	flush_write_bio(&epd);
+	submit_write_bio(&epd, ret);
 	return ret;
 }
 
@@ -5185,10 +5158,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		cur = cur_end + 1;
 	}
 
-	if (!found_error)
-		flush_write_bio(&epd);
-	else
-		end_write_bio(&epd, ret);
+	submit_write_bio(&epd, found_error ? ret : 0);
 
 	wbc_detach_inode(&wbc_writepages);
 	if (found_error)
@@ -5214,12 +5184,8 @@ int extent_writepages(struct address_space *mapping,
 	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
 	ret = extent_write_cache_pages(mapping, wbc, &epd);
 	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
-	ASSERT(ret <= 0);
-	if (ret < 0) {
-		end_write_bio(&epd, ret);
-		return ret;
-	}
-	flush_write_bio(&epd);
+
+	submit_write_bio(&epd, ret);
 	return ret;
 }
 
-- 
2.30.2

