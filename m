Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9F6AE6FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCGQoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 11:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCGQnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 11:43:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AD01448B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wj1CuQNogxSXqxQpskttZ6KNhBFyapCU0NwQkInS6KM=; b=jyVwoXAnBbpAritoYzhqB1Etxv
        MQUqSYTxGCvCBqBOOBZ758yF8DMFzqHqRoqUO8L7OlCm/UpPaIfHRFZB7MRZec8qZ3u1rAfAcxYjd
        5VWhNwUmr2t8yq9OwQwAtT3oVwAbJUXC/i5GUYc3XGcGyu1izzBB5y0H85vXN3ISxSoeDzhH162Bj
        6p1sCGfJ+SW4oF5q1Ab6c5UHvZ62Q7A6xu09MBnuPWqB41pxW/+yH+oKGJ9ew37PGZyQmMWxqLzoY
        43ijjKCJbrL0n1Domgh63ibxp/yAzLVulwUkA+oDRLcg8jk9BfDpjJO9mO3q8aT6sobGisv4ykgWc
        N1/neQIQ==;
Received: from [213.208.157.31] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaMy-001bir-Vs; Tue, 07 Mar 2023 16:40:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 07/10] btrfs: simplify finding the inode in submit_one_bio
Date:   Tue,  7 Mar 2023 17:39:42 +0100
Message-Id: <20230307163945.31770-8-hch@lst.de>
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

struct btrfs_bio now has an always valid inode pointer that can be used
to find the inode in submit_one_bio, so use that and initialize all
variables for which it is possible at declaration time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2b9e24782b36f5..2670c479847094 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -123,23 +123,16 @@ struct btrfs_bio_ctrl {
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
-	struct bio *bio;
-	struct bio_vec *bv;
-	struct inode *inode;
-	int mirror_num;
+	struct bio *bio = bio_ctrl->bio;
+	int mirror_num = bio_ctrl->mirror_num;
 
-	if (!bio_ctrl->bio)
+	if (!bio)
 		return;
 
-	bio = bio_ctrl->bio;
-	bv = bio_first_bvec_all(bio);
-	inode = bv->bv_page->mapping->host;
-	mirror_num = bio_ctrl->mirror_num;
-
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
-	if (!is_data_inode(inode)) {
+	if (!is_data_inode(&btrfs_bio(bio)->inode->vfs_inode)) {
 		if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 			/*
 			 * For metadata read, we should have the parent_check,
-- 
2.39.1

