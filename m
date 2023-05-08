Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE36FB4CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjEHQJM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjEHQI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B365AB
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AePrBrt5hj8Dih6JViE7MLHGtyPDkRI/jp1GQbGbY4w=; b=BvN6rvBFwtt8GIjK4NHIldfS//
        AuCkSi3gC5ajlc5iOUtV7wClEuHW3leBGfr2dk5+5DeZlEanNcI4EwT/8TtLVZ3f7ug+RhQ33wG56
        uqoJNBseUB4W1Vh2RY2mD26RJfOKIYrtiF+7s+bi3SgxkmIDvox333Y9IqR/owhTcAOAQnksdu99i
        eKNqd0WAnixd23uH4uVCRD3o+thCleeVlVNBY6snJZ0d+FKxuiH70EQriff0zxgfpqYGvA6UtLjfM
        A+qh70kOu0g5CBa6nt2fZXo74tpMLRHBai9sxgZ10lC0BY0ASfqRELU59WU5uFf/rMnFtAKOJkXLY
        NLSOXl7Q==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pw-000w3B-36;
        Mon, 08 May 2023 16:08:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/21] btrfs: use bbio->ordered for zone append completions
Date:   Mon,  8 May 2023 09:08:36 -0700
Message-Id: <20230508160843.133013-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the ordered_extent pointer in the btrfs_bio instead of looking it
up manually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c   |  3 ++-
 fs/btrfs/zoned.c | 13 -------------
 fs/btrfs/zoned.h |  5 -----
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a1ad9aba2f7fc2..d697c4c9ef3c73 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -376,7 +376,8 @@ static void btrfs_simple_end_io(struct bio *bio)
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
-			btrfs_record_physical_zoned(bbio);
+			bbio->ordered->physical =
+				bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 		btrfs_orig_bbio_end_io(bbio);
 	}
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e3fe02aae641f3..5882eca045a9d4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1675,19 +1675,6 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 	return ret;
 }
 
-void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
-{
-	const u64 physical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
-	struct btrfs_ordered_extent *ordered;
-
-	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
-	if (WARN_ON(!ordered))
-		return;
-
-	ordered->physical = physical;
-	btrfs_put_ordered_extent(ordered);
-}
-
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c0570d35fea291..f01d096f87d59b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -56,7 +56,6 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
-void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
@@ -186,10 +185,6 @@ static inline bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 	return false;
 }
 
-static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
-{
-}
-
 static inline void btrfs_rewrite_logical_zoned(
 				struct btrfs_ordered_extent *ordered) { }
 
-- 
2.39.2

