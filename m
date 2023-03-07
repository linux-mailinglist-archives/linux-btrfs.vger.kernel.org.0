Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27476AE705
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 17:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCGQoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 11:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCGQoS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 11:44:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F78C95A
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2eA1LD2wI4zYh/i1ovDr12J4j6Kfdj94mWn8wsXMJJE=; b=ttVIyCjZQ51IgTEH4gbAsg1e7k
        0HmPul/TwKqKP8IK4vzemgxqegO3ZJIwwRXTxPILp01whR0+dyRwSug+e1/2t3GpbAP5OL0iGdURN
        2k6KZgfF2slEDJHjpBErIrqGDV+PdboXtI+lqjyZOL9yNAO2PpJ09C/2MIf3JhznHECsjrskDs3hF
        xqlFBgSEt7FCFmB3su7hilolo8Zty8qrqdderl6y+ZDKUSXtkWTsjBSFgYIBPr2LaZQ0zqxfbIvvA
        mcl3P9SVQLOBfWycTImp0UvRJFPy5qbvpR6/Wiao9Gtee6WrMgMom44n/9ekKYU14x5ChAqIITOuX
        4qEuTTHQ==;
Received: from [213.208.157.31] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaNM-001brA-55; Tue, 07 Mar 2023 16:41:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 10/10] btrfs: make btrfs_split_bio work on struct btrfs_bio
Date:   Tue,  7 Mar 2023 17:39:45 +0100
Message-Id: <20230307163945.31770-11-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307163945.31770-1-hch@lst.de>
References: <20230307163945.31770-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_split_bio expects a btrfs_bio as argument and always allocates one.
Type both the orig_bio argument and the return value as struct btrfs_bio
to improve type safety.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 527081abca026f..cf09c6271edbee 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -61,30 +61,31 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
-static struct bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
-				   struct bio *orig, u64 map_length,
-				   bool use_append)
+static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
+					 struct btrfs_bio *orig_bbio,
+					 u64 map_length, bool use_append)
 {
-	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
+	struct btrfs_bio *bbio;
 	struct bio *bio;
 
 	if (use_append) {
 		unsigned int nr_segs;
 
-		bio = bio_split_rw(orig, &fs_info->limits, &nr_segs,
+		bio = bio_split_rw(&orig_bbio->bio, &fs_info->limits, &nr_segs,
 				   &btrfs_clone_bioset, map_length);
 	} else {
-		bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
-				&btrfs_clone_bioset);
+		bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT,
+				GFP_NOFS, &btrfs_clone_bioset);
 	}
-	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
+	bbio = btrfs_bio(bio);
+	btrfs_bio_init(bbio, orig_bbio->inode, NULL, orig_bbio);
 
-	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
-	if (!(orig->bi_opf & REQ_BTRFS_ONE_ORDERED))
+	bbio->file_offset = orig_bbio->file_offset;
+	if (!(orig_bbio->bio.bi_opf & REQ_BTRFS_ONE_ORDERED))
 		orig_bbio->file_offset += map_length;
 
 	atomic_inc(&orig_bbio->pending_ios);
-	return bio;
+	return bbio;
 }
 
 static void btrfs_orig_write_end_io(struct bio *bio);
@@ -633,8 +634,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		map_length = min(map_length, fs_info->max_zone_append_size);
 
 	if (map_length < length) {
-		bio = btrfs_split_bio(fs_info, bio, map_length, use_append);
-		bbio = btrfs_bio(bio);
+		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
+		bio = &bbio->bio;
 	}
 
 	/*
-- 
2.39.1

