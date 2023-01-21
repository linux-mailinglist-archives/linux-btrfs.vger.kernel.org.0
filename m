Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE167648B
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 07:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjAUGwR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Jan 2023 01:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjAUGwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Jan 2023 01:52:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51273152;
        Fri, 20 Jan 2023 22:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fgxjQuMdZovASll3J/RzA6EXNgljzWchp5cxt0pQqGg=; b=42ItnGBpCfJt+7WD4sPgSMhW4L
        Z4U8McoVzEt7S/VAG+SvuFef1opa1tfukU+C3Oay5+ehCpqZaIWLXHEFsol9K6McbgbS3R4ofMM7p
        Ehfyn8HczAiKvJ1q3+bAJm6O5EXxwjl6Jpzo1M1c/UzS76bLsAzNJk29d/vlooaUbg1CkePFYIXid
        t0mfJ2lIyExBSFaebkDak4wrta0UlGINvMd2jizqJImYzmkPtqBHDENSK5rLrsc0Lx5F+oKcZvGcx
        Qb/vQ6Grqb4ks5/yvLDlQiVbhCKli5xOr8VgpeB1X1QkEKLtDhkDKF5i9CDBrOEtMZLBmOX1JIyFs
        OvigjBXQ==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7jD-00DRgS-54; Sat, 21 Jan 2023 06:51:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 29/34] btrfs: remove submit_encoded_read_bio
Date:   Sat, 21 Jan 2023 07:50:26 +0100
Message-Id: <20230121065031.1139353-30-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
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

Just opencode the functionality in the only caller and remove the
now superfluous error handling there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e246fa8e4ae7f6..aad802d100e134 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9937,17 +9937,6 @@ struct btrfs_encoded_read_private {
 	blk_status_t status;
 };
 
-static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
-					    struct bio *bio, int mirror_num)
-{
-	struct btrfs_encoded_read_private *priv = btrfs_bio(bio)->private;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-
-	atomic_inc(&priv->pending);
-	btrfs_submit_bio(fs_info, bio, mirror_num);
-	return BLK_STS_OK;
-}
-
 static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 {
 	struct btrfs_encoded_read_private *priv = bbio->private;
@@ -9972,6 +9961,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 file_offset, u64 disk_bytenr,
 					  u64 disk_io_size, struct page **pages)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
 		.inode = inode,
 		.file_offset = file_offset,
@@ -10002,14 +9992,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 			if (!bytes ||
 			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
-				blk_status_t status;
-
-				status = submit_encoded_read_bio(inode, bio, 0);
-				if (status) {
-					WRITE_ONCE(priv.status, status);
-					bio_put(bio);
-					goto out;
-				}
+				atomic_inc(&priv.pending);
+				btrfs_submit_bio(fs_info, bio, 0);
 				bio = NULL;
 				continue;
 			}
@@ -10020,7 +10004,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		}
 	}
 
-out:
 	if (atomic_dec_return(&priv.pending))
 		io_wait_event(priv.wait, !atomic_read(&priv.pending));
 	/* See btrfs_encoded_read_endio() for ordering. */
-- 
2.39.0

