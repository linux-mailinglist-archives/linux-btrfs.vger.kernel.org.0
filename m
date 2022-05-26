Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96197534AE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiEZHhJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 03:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiEZHhE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 03:37:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9699BADD
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1kSheuga7wG9pXxyAiU4rlbiaqtUmJinuZbw4DkSYpU=; b=aSc7yfQrgiDCY7gp4LVs3Yeyi0
        5E9j318Exc36vfGsdjwDr3cGA4CH17JzUSpcVIiroq79syYdJg01LeIcvWBmSHFFcDd/bfxOk4WNV
        80M6DS2T26Fc2NHQTYEBJUJFWEuNLXFBmQPl3lE7iCtt1/EdYpIYnkAcaZEhhdDbGO8FiBiTx/94w
        RzTCLoFGy9fOITd0BjtR2mRhvn45RHrQFHRUjqMLKfdBWQvUkRmhDVmLJQ/KWQOjzBnvaLyruSSfP
        fOi3OsJcUbQQiArMap+BTqPSrRx4X5oujlSamuGaVJlefNLA1dVfCkxNBoRpe96jyEWUgBMMWAe+a
        fTZ2P7IA==;
Received: from [2001:4bb8:18c:7298:d94:e0f5:2d65:4015] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu83J-00DpaR-W2; Thu, 26 May 2022 07:37:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: centralize setting REQ_META
Date:   Thu, 26 May 2022 09:36:39 +0200
Message-Id: <20220526073642.1773373-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526073642.1773373-1-hch@lst.de>
References: <20220526073642.1773373-1-hch@lst.de>
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

Set REQ_META in btrfs_submit_metadata_bio instead of the various callers.
We'll start relying on this flag inside of btrfs in a bit, and this
ensures it is always set correctly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 2 ++
 fs/btrfs/extent_io.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2598c347a4bea..46de02ac11aac 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -913,6 +913,8 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
+	bio->bi_opf |= REQ_META;
+
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		/*
 		 * called for a read, do the setup so that checksum validation
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 00c38811ee0f5..cbe04b3decee9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4571,7 +4571,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
-	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool no_dirty_ebs = false;
 	int ret;
 
@@ -4616,7 +4616,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
-	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	unsigned int write_flags = wbc_to_write_flags(wbc);
 	int ret = 0;
 
 	prepare_eb_write(eb);
@@ -6626,7 +6626,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, &bio_ctrl,
+	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
 				 page, eb->start, eb->len,
 				 eb->start - page_offset(page),
 				 end_bio_extent_readpage, mirror_num, 0,
@@ -6733,7 +6733,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 			}
 
 			ClearPageError(page);
-			err = submit_extent_page(REQ_OP_READ | REQ_META, NULL,
+			err = submit_extent_page(REQ_OP_READ, NULL,
 					 &bio_ctrl, page, page_offset(page),
 					 PAGE_SIZE, 0, end_bio_extent_readpage,
 					 mirror_num, 0, false);
-- 
2.30.2

