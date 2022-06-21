Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE1552C5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347421AbiFUHt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiFUHt4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 03:49:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951132409B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RnekIO8sCB0PQejam8mQpWxeVM6bXp0V+16CXntJ26g=; b=WEUDWjzK0fc4zgjJqYvj0mZnJI
        Y/bW2/7gpepDM75tFuzVViiYzVQG3UodUbmTyVLvvfi77oU4KOBF6G/ceWp5veJZjBJ7A8QAEQa/U
        rnhGCNMtj5OGfv7stVd0xI9fEF8AILxcVJQWtya+pZlsR+cSOfsduK3vRKHs60GngG6q9fKhko2Ly
        dZ87NTwY4+LxQYcrDtqMc4dFCX+OPiFiYxsFM0pMbifHlrAqtvkMzYgbnBBIMgOiN/FbhSbJsTrB+
        r7MmFzvkvuhcaPGgqxGU9nl4klzidOCTluhx45TDHVfz+R7XMM7lFqORjQ/ApSfaMn1UVKmZobWSK
        i9as3Kvw==;
Received: from [2001:4bb8:189:7251:337b:5150:462e:1c35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3Ydw-004CXa-H1; Tue, 21 Jun 2022 07:49:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     hannes@cmpxchg.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove ->writepage
Date:   Tue, 21 Jun 2022 09:49:44 +0200
Message-Id: <20220621074944.2742214-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

->writepage is only used for single page writeback from memory reclaim,
and not called at all for cgroup writeback.  Follow the lead of XFS
and remove ->writepage and rely entirely on ->writepages.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 14 --------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/inode.c     | 26 --------------------------
 fs/btrfs/subpage.c   |  2 +-
 4 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 854999c2e139b..0681c0da7926d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5108,20 +5108,6 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
-int extent_write_full_page(struct page *page, struct writeback_control *wbc)
-{
-	int ret;
-	struct extent_page_data epd = {
-		.bio_ctrl = { 0 },
-		.extent_locked = 0,
-		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
-	};
-
-	ret = __extent_writepage(page, wbc, &epd);
-	submit_write_bio(&epd, ret);
-	return ret;
-}
-
 /*
  * Submit the pages in the range to bio for call sites which delalloc range has
  * already been ran (aka, ordered extent inserted) and all pages are still
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c0f1fb63eeae7..a76c6ef74cd3c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -146,7 +146,6 @@ int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f6dc6e8c54e3a..b31b3360cc1f5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8144,31 +8144,6 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
 }
 
-static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct inode *inode = page->mapping->host;
-	int ret;
-
-	if (current->flags & PF_MEMALLOC) {
-		redirty_page_for_writepage(wbc, page);
-		unlock_page(page);
-		return 0;
-	}
-
-	/*
-	 * If we are under memory pressure we will call this directly from the
-	 * VM, we need to make sure we have the inode referenced for the ordered
-	 * extent.  If not just return like we didn't do anything.
-	 */
-	if (!igrab(inode)) {
-		redirty_page_for_writepage(wbc, page);
-		return AOP_WRITEPAGE_ACTIVATE;
-	}
-	ret = extent_write_full_page(page, wbc);
-	btrfs_add_delayed_iput(inode);
-	return ret;
-}
-
 static int btrfs_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
@@ -11390,7 +11365,6 @@ static const struct file_operations btrfs_dir_file_operations = {
  */
 static const struct address_space_operations btrfs_aops = {
 	.read_folio	= btrfs_read_folio,
-	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
 	.readahead	= btrfs_readahead,
 	.direct_IO	= noop_direct_IO,
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 0146fee730a09..6fc2b77ae5c34 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -731,7 +731,7 @@ void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
  *   It should not have any subpage::writers count.
  *   Can be unlocked by unlock_page().
  *   This is the most common locked page for __extent_writepage() called
- *   inside extent_write_cache_pages() or extent_write_full_page().
+ *   inside extent_write_cache_pages().
  *   Rarer cases include the @locked_page from extent_write_locked_range().
  *
  * - Page locked by lock_delalloc_pages()
-- 
2.30.2

