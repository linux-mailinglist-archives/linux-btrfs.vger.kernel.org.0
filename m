Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7002550DAAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 09:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiDYH7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241833AbiDYH6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 03:58:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73F6584
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GXOloPkjVfC4/EUUaIqa81GZ6+oD7+r8FjcoQyRJ5SM=; b=Y0gYQTqeE5VtzJfn/0Qj+HHcub
        J8HYe10TDXyUhgN0R5Sy0m3+h+Aq2hQju8P9F6M4IzrQ8xVzy3jZN2l4VrrRo/XJc/RFBnJ/Fr0QD
        BbyVb4HxvnDdIbHotM1zx05LjV0NxD3BiTPQksT8uKN98WJdplDPky6u3AZvChSSsBsQ4vUks/bLS
        ymlp7TIc1wJBz8EvVS1VgQNUAe8DSrZGEdngYQbPMCwHg9voyHogHcm63v6yoe8iAhkcljFECJJsP
        rF4O5oaZLy0GZNTkTkiUWKrZcwTsFWJditCyq2R3uQpDJhX/QkFJLp4aO6Uq4+jKkE+e1xDLQrkEt
        4zBzOsbw==;
Received: from 80-254-69-104.dynamic.monzoon.net ([80.254.69.104] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitYS-008gkv-Hl; Mon, 25 Apr 2022 07:54:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: centralize setting REQ_META
Date:   Mon, 25 Apr 2022 09:54:15 +0200
Message-Id: <20220425075418.2192130-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425075418.2192130-1-hch@lst.de>
References: <20220425075418.2192130-1-hch@lst.de>
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
---
 fs/btrfs/disk-io.c   | 2 ++
 fs/btrfs/extent_io.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1e6ee7f1a375d..65e680895e628 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -915,6 +915,8 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
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

