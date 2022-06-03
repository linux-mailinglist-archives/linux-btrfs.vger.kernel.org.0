Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1214653C57E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiFCG57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbiFCG5r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 02:57:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A4DFCD
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8Ub206OY7Z+VrJhjR2/ebMp8LC1Ob688gKwV+naqAKA=; b=KJ+YkmshuOy+gSE3dRwTmZ8zUC
        VExjHjySA5p7B4xPWwAnVCltCHi5w64QqOfcYS9WYyp+FKqfh8H/+NXCBwMwYdHA0lGXNz+e9AOk/
        R7hH540PBQmzF3oHR/6pocCrqZBvaBXzyDg9KndV6SePbfl9WuAWCU10tRW57mBbl9xR8s2frLl/6
        SdW8Y1NoNr5GdP32KhraUq0tMpbPlrGmJJOG6NrcEpiv20WROKWGNFnl0jIu2NSBhpUZwMuQU19AB
        RdcsLOT3YO3K/66J+M3crh3I1H4nm57B0FbEJizgaSXPJFz6HnjFMAE/U6GkZn6Ii7QkQGe3/8vL3
        YZcV9J+A==;
Received: from [2001:4bb8:185:a81e:b29a:8b56:eb9a:ca3b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx1Fg-0069JA-At; Fri, 03 Jun 2022 06:57:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: stop looking at btrfs_bio->iter in index_one_bio
Date:   Fri,  3 Jun 2022 08:57:42 +0200
Message-Id: <20220603065742.40931-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

All the bios that index_one_bio operates on are the bios submitted by the
upper layer.  These are never resubmitted to an actual device by the
raid56 code, and thus the iter never changes from the initial state.
Thus we can always just use bi_iter directly as it will be the same as
the saved copy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 00cd9e8db7ae0..3c58869779375 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1106,9 +1106,6 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
 		     rbio->bioc->raid_map[0];
 
-	if (bio_flagged(bio, BIO_CLONED))
-		bio->bi_iter = btrfs_bio(bio)->iter;
-
 	bio_for_each_segment(bvec, bio, iter) {
 		u32 bvec_offset;
 
-- 
2.30.2

