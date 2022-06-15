Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26A854CC67
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbiFOPPb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiFOPP0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 11:15:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB803C49C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VH50fX1D2WRdj/D8tZlw/7D2Zl7TPBqgQ7VjcH5QYuQ=; b=WQTUQSpBNgdCmiyhgAFrnH7VUE
        da7nQq4wLqyEiBOKjxIr7KD4sWqGBSS4mX6RVhm5Awif1whEL8WvthXQCixnZqmvmB/anBS5Xwnbp
        KThWkV32frJJAXczlDa04r2/h70ZfK8uKRY1JlU9xl7lTnBR7RBDsmd38+IHBcx2aY9as2HoWjasy
        Nq4mdcnQlCEi36TWckNwLz2LLf4WZLd2951pGFuehxQfzr3OP8bjNbLWWUBZtuGwMoccNrDA0zdOC
        /xbQd2BPnQTifNUgxh30P1+WGKRTKxnCD3GFGqoPhiUu9p2SbLsM8fTay7ObaywXHaZJ8m+tu6W8a
        GInm9PAA==;
Received: from [2001:4bb8:180:36f6:5ab4:8a8:5e48:3d75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Ujs-00F8rS-82; Wed, 15 Jun 2022 15:15:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: return proper mapped length for RAID56 profiles in __btrfs_map_block()
Date:   Wed, 15 Jun 2022 17:15:12 +0200
Message-Id: <20220615151515.888424-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615151515.888424-1-hch@lst.de>
References: <20220615151515.888424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

For profiles other than RAID56, __btrfs_map_block() returns @map_length
as min(stripe_end, logical + *length), which is also the same result
from btrfs_get_io_geometry().

But for RAID56, __btrfs_map_block() returns @map_length as stripe_len.

This strange behavior is going to hurt incoming bio split at
btrfs_map_bio() time, as we will use @map_length as bio split size.

Fix this behavior by return @map_length by the same calculatioin as
other profiles

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 07b1e005d89df..ff777e39d5f4a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6469,7 +6469,10 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			num_stripes = map->num_stripes;
 			max_errors = nr_parity_stripes(map);
 
-			*length = map->stripe_len;
+			/* Return the length to the full stripe end */
+			*length = min(raid56_full_stripe_start + em->start +
+				      data_stripes * stripe_len,
+				      logical + *length) - logical;
 			stripe_index = 0;
 			stripe_offset = 0;
 		} else {
-- 
2.30.2

