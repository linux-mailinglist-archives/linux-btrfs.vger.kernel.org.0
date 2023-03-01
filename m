Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083176A6D42
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCANmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCANms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408253E0B3
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WoRx/njEl2viqXsggJof5ZorGMbvoGvRTGhL6nynULk=; b=xAnbOFGnFku2FYZZnpKeRQyZyc
        4qEWsU1oU1/wccqJxY9JYYb5UTAjUs0roB/ROWFLKYqdCIfd3mJPwKic/TZDKj07ke2uFhoTg0s6F
        /xeOpz0UFLCKWfuJ+okkJKtq6Up8To3ioEbbBFwPWZilW+DL3DB1GNb9XxC6AgE3P4APfCskc/1GA
        9hqzYsDO5EvV/fd1Gxo1tdkHvDYzrO6GF18I1hcSAa4Jux+r8TdtqwC/LGUhRpRGI4X5UMhVoj6Bp
        kvlEiCkyTw9fozc3t0UJOgW5W8EoiBVE66FcB6a117lvlhC0PL1N38vxI7MQlr9oB5OJbw3YybChu
        ZBBznqzg==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjF-00GN7l-8A; Wed, 01 Mar 2023 13:42:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: store a pointer to the original btrfs_bio in struct compressed_bio
Date:   Wed,  1 Mar 2023 06:42:39 -0700
Message-Id: <20230301134244.1378533-7-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301134244.1378533-1-hch@lst.de>
References: <20230301134244.1378533-1-hch@lst.de>
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

The original bio must be a btrfs_bio, so store a pointer to the
btrfs_bio for better type checking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 15 ++++++++-------
 fs/btrfs/compression.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c12e317e133624..c5839d04690d67 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -177,7 +177,7 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
 		status = errno_to_blk_status(btrfs_decompress_bio(cb));
 
 	btrfs_free_compressed_pages(cb);
-	btrfs_bio_end_io(btrfs_bio(cb->orig_bio), status);
+	btrfs_bio_end_io(cb->orig_bbio, status);
 	bio_put(&bbio->bio);
 }
 
@@ -357,7 +357,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long end_index;
-	u64 cur = btrfs_bio(cb->orig_bio)->file_offset + cb->orig_bio->bi_iter.bi_size;
+	struct bio *orig_bio = &cb->orig_bbio->bio;
+	u64 cur = cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
 	u64 isize = i_size_read(inode);
 	int ret;
 	struct page *page;
@@ -447,7 +448,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 */
 		if (!em || cur < em->start ||
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
-		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
+		    (em->block_start >> 9) != orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
@@ -467,7 +468,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		add_size = min(em->start + em->len, page_end + 1) - cur;
-		ret = bio_add_page(cb->orig_bio, page, add_size, offset_in_page(cur));
+		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
 			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
@@ -537,7 +538,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
 	cb->len = bbio->bio.bi_iter.bi_size;
 	cb->compressed_len = compressed_len;
 	cb->compress_type = em->compress_type;
-	cb->orig_bio = &bbio->bio;
+	cb->orig_bbio = bbio;
 
 	free_extent_map(em);
 
@@ -966,7 +967,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
 	put_workspace(type, workspace);
 
 	if (!ret)
-		zero_fill_bio(cb->orig_bio);
+		zero_fill_bio(&cb->orig_bbio->bio);
 	return ret;
 }
 
@@ -1044,7 +1045,7 @@ void __cold btrfs_exit_compress(void)
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed)
 {
-	struct bio *orig_bio = cb->orig_bio;
+	struct bio *orig_bio = &cb->orig_bbio->bio;
 	/* Offset inside the full decompressed extent */
 	u32 cur_offset;
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 692bafa1050e8e..5d5146e72a860b 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -55,7 +55,7 @@ struct compressed_bio {
 
 	union {
 		/* For reads, this is the bio we are copying the data into */
-		struct bio *orig_bio;
+		struct btrfs_bio *orig_bbio;
 		struct work_struct write_end_work;
 	};
 
-- 
2.39.1

