Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD21569195A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjBJHtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBJHtH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:49:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8E75ACF2
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nVyr7ksdDp7bHkThYtGhhhTiRQfQNBT29lPkMoAaXkk=; b=gNJiy8EGy4nN9bmHMPpN80n9X7
        hrDf5pgsXiGyrl2hIwRaUdhxuP3pbfGtIKekjZMA5C3hjCX1/HdDRSSao/2PstlB+/L69uVZ0pRzS
        bZpEpbvtZlC2UdqQ5e2i+MqaTk5XwRhaf4zmWs4S21M3/TtThz5tLyoAP5f7ABFnn5DPPz3T9iDaR
        aq8SWvkiUIy0ZcWv4+1NKmfN0VXIdpI1USUXCkBKgRPplzmR947xlP0qR1AuS7uRatEaJfHpHwPKy
        AdCqNlZBQRg1M2WyTo4/s2nbIyqX54njj22V4wgHg+yHIFjdhxLrHuwFpU05L++nAolMzeRUPs4yQ
        7MxEEkIA==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9Y-004fgb-8M; Fri, 10 Feb 2023 07:49:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: use the bbio file offset in add_ra_bio_pages
Date:   Fri, 10 Feb 2023 08:48:37 +0100
Message-Id: <20230210074841.628201-5-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
References: <20230210074841.628201-1-hch@lst.de>
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

struct btrfs_bio now has a file_offset field set up by all submitters.
Use that value combined with the bio size in add_ra_bio_pages to
calculate the last offset in the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f7b6c0baae809a..7560345d02cac8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -357,13 +357,6 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		kthread_associate_blkcg(NULL);
 }
 
-static u64 bio_end_offset(struct bio *bio)
-{
-	struct bio_vec *last = bio_last_bvec_all(bio);
-
-	return page_offset(last->bv_page) + last->bv_len + last->bv_offset;
-}
-
 /*
  * Add extra pages in the same compressed file extent so that we don't need to
  * re-read the same extent again and again.
@@ -382,7 +375,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long end_index;
-	u64 cur = bio_end_offset(cb->orig_bio);
+	u64 cur = btrfs_bio(cb->orig_bio)->file_offset +
+		  cb->orig_bio->bi_iter.bi_size;
 	u64 isize = i_size_read(inode);
 	int ret;
 	struct page *page;
-- 
2.39.1

