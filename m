Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF56A6D41
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCANmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCANmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951763E0AB
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WBXRHC6CShoAJ2SjmdkEcIXd4uZQR/0ton5597XjJtE=; b=eWlZtGHqbkFcXfQO8lQ7G7/OCH
        t7kFaO3KdAPl4qVaSXySYAAESAgraH032h4D6FuJ8rBYj3UE1/wbeDAcvya1bUWTWLqF++6zWtzk+
        knAd7mWnT1hvD2e0WOCysWQLz2ovr7Rd40a7+g+WNnF4Os+WiGZxoydG56zsfaCXNekD0/Hd49kqM
        g/umdLZOgKN5dmcVmsu18RrKH+Hd7kbvAgc1wKkkYCG3jORWV6u4CnyEzOgwD/iz3+X/FBrVFDbzk
        +mLqHgrqloCpwcglGNYF7d91ZXQ2V0YxRNWuqs3GZG3wM36Dgv17mWg8ih+K6JmlXANTsp6WB/vHz
        ym4CHOdw==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjE-00GN7S-Py; Wed, 01 Mar 2023 13:42:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: pass a btrfs_bio to btrfs_submit_compressed_read
Date:   Wed,  1 Mar 2023 06:42:38 -0700
Message-Id: <20230301134244.1378533-6-hch@lst.de>
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

btrfs_submit_compressed_read expects the bio passed to it to be embedded
into a btrfs_bio structure.  Pass the btrfs_bio directly to inrease type
safety and make the code self-documenting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 16 ++++++++--------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 27bea05cab1a1b..c12e317e133624 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -498,15 +498,15 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * After the compressed pages are read, we copy the bytes into the
  * bio we were passed and then call the bio end_io calls
  */
-void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
 {
-	struct btrfs_inode *inode = btrfs_bio(bio)->inode;
+	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
-	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	u64 file_offset = btrfs_bio(bio)->file_offset;
+	const u64 disk_bytenr = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 file_offset = bbio->file_offset;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
@@ -534,10 +534,10 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	em_len = em->len;
 	em_start = em->start;
 
-	cb->len = bio->bi_iter.bi_size;
+	cb->len = bbio->bio.bi_iter.bi_size;
 	cb->compressed_len = compressed_len;
 	cb->compress_type = em->compress_type;
-	cb->orig_bio = bio;
+	cb->orig_bio = &bbio->bio;
 
 	free_extent_map(em);
 
@@ -558,7 +558,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 			 &pflags);
 
 	/* include any pages we added in add_ra-bio_pages */
-	cb->len = bio->bi_iter.bi_size;
+	cb->len = bbio->bio.bi_iter.bi_size;
 
 	btrfs_add_compressed_bio_pages(cb, disk_bytenr);
 
@@ -573,7 +573,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 out_free_bio:
 	bio_put(&cb->bbio.bio);
 out:
-	btrfs_bio_end_io(btrfs_bio(bio), ret);
+	btrfs_bio_end_io(bbio, ret);
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 95d2e85c6e4eea..692bafa1050e8e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -94,7 +94,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  blk_opf_t write_flags,
 				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
-void btrfs_submit_compressed_read(struct bio *bio, int mirror_num);
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 77de129db364c9..6ea6f2c057ac3e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -155,7 +155,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	if (btrfs_op(bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		btrfs_submit_compressed_read(bio, mirror_num);
+		btrfs_submit_compressed_read(btrfs_bio(bio), mirror_num);
 	else
 		btrfs_submit_bio(btrfs_bio(bio), mirror_num);
 
-- 
2.39.1

