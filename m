Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CB717925
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjEaH4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjEaH4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A811BE4
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OWvnyk+PhVZFWoDLswYft6yXU7AKZnGCD7Sbxef+Mag=; b=IW+jzQAYL0a/NDVt06Z0gYhZsy
        E5pwW3gQxnvQCkoCHNno4usVvGTk7qvJxfdZ4ypiyBeZmm71yL37mv2K87MrmmSKAjMa5WCiyQr/l
        ru6nRew+8JyE8syOqlgeuMPRy435PRccUQmC+t7DgddiKBZdnUNrtSMKyXvmx5pBkthkn3XW73mGZ
        6dXNoJudgUro4vkhmKQAr7HYLLewcxmYJBx6R6AvC3J66apPxm5IqbgmqHRPuWTw1+bh4DExlQAr7
        X5at3LJYebAxMYT4DN02mNINMEoe3QkjWYfIOxlWMv/AKB6hXAWnlb1GFxzl72D9UzdoEIkDrt5I5
        NIkhXmcA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfD-00GWt3-0H;
        Wed, 31 May 2023 07:54:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/17] btrfs: add a is_data_bbio helper
Date:   Wed, 31 May 2023 09:54:00 +0200
Message-Id: <20230531075410.480499-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helper to check for that a btrfs_bio has a valid inde inode, and
that it is a data inode to key off all the special handling for data
path checksumming.  Note that this uses is_data_inode instead of REQ_META
as REQ_META is only set directly before submission in submit_one_bio
and we'll also want to use this helper for error handling where REQ_META
isn't set yet.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index bbe1c3b90988fc..18afad50a98774 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -27,6 +27,12 @@ struct btrfs_failed_bio {
 	atomic_t repair_count;
 };
 
+/* Is this a data path I/O that needs storage layer checksum and repair? */
+static inline bool is_data_bbio(struct btrfs_bio *bbio)
+{
+	return bbio->inode && is_data_inode(&bbio->inode->vfs_inode);
+}
+
 /*
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
@@ -312,7 +318,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
 	/* Metadata reads are checked and repaired by the submitter. */
-	if (bbio->inode && !(bbio->bio.bi_opf & REQ_META))
+	if (is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 	else
 		btrfs_orig_bbio_end_io(bbio);
@@ -346,8 +352,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	if (bio_op(bio) == REQ_OP_READ && bbio->inode &&
-	    !(bbio->bio.bi_opf & REQ_META))
+	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, NULL);
 	else
 		btrfs_orig_bbio_end_io(bbio);
@@ -638,7 +643,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	 * Save the iter for the end_io handler and preload the checksums for
 	 * data reads.
 	 */
-	if (bio_op(bio) == REQ_OP_READ && inode && !(bio->bi_opf & REQ_META)) {
+	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
 		bbio->saved_iter = bio->bi_iter;
 		ret = btrfs_lookup_bio_sums(bbio);
 		if (ret)
-- 
2.39.2

