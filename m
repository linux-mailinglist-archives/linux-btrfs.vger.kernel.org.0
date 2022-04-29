Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935BF514D01
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377458AbiD2OeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377391AbiD2OeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:34:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E33641C
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=l4vik+u9gTQloHGkLJj8m4zNn3ss8HRe1FN2Txx5NrM=; b=UYoFlcnAqKS8VkHdzeJHa44HMb
        +3bceV0ejf44N925nULDYPuHYoYoKG1gponVWIKTCY7M4RBV7tsAtExW13hiiSa5W+3woMDVkadQQ
        YCFACyKH5bZcEQrEmuwQmvwcKfh9H7jBobJFvJGpbTi3jCg7kpI4dPsewfsjwVh4VTAl2swA2nna7
        kF90u2r2HXbZPt2NfvNvTMaOXWa4khFn8/zKzNk7JjPSvKEtgqkxptqkL0KuPtRAZOvJVBN4A/300
        5O/U/QpWvyX657xhl8XO0Wl3Um1dq0CErjE4D8YyFPhi5e1y+PM936ezWtoL/w9RkFteVO9MAxgP9
        u+ar40uA==;
Received: from [2607:fb90:27d7:71af:6ca1:91e8:bf19:edd2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkRdw-00Baka-1a; Fri, 29 Apr 2022 14:30:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: centralize setting REQ_META
Date:   Fri, 29 Apr 2022 07:30:37 -0700
Message-Id: <20220429143040.106889-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429143040.106889-1-hch@lst.de>
References: <20220429143040.106889-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 744a74203776e..b8837f66e0a43 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -914,6 +914,8 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
+	bio->bi_opf |= REQ_META;
+
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		/*
 		 * called for a read, do the setup so that checksum validation
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 80b4482c477c6..a14ed9b9dc2d0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4589,7 +4589,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
-	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool no_dirty_ebs = false;
 	int ret;
 
@@ -4634,7 +4634,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
-	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
+	unsigned int write_flags = wbc_to_write_flags(wbc);
 	int ret = 0;
 
 	prepare_eb_write(eb);
@@ -6645,7 +6645,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, &bio_ctrl,
+	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
 				 page, eb->start, eb->len,
 				 eb->start - page_offset(page),
 				 end_bio_extent_readpage, mirror_num, 0,
@@ -6752,7 +6752,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 			}
 
 			ClearPageError(page);
-			err = submit_extent_page(REQ_OP_READ | REQ_META, NULL,
+			err = submit_extent_page(REQ_OP_READ, NULL,
 					 &bio_ctrl, page, page_offset(page),
 					 PAGE_SIZE, 0, end_bio_extent_readpage,
 					 mirror_num, 0, false);
-- 
2.30.2

