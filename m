Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656E54F4CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381486AbiFQKEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417669723
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Zxl1x2L1F6zJuf1oSY7ABz2bpfiZzhGJ5XVj1EId8+0=; b=CcXk74iEu1y5S5xTCgsaHLsSqU
        lQ4SFNqs48S7VNrtFDRaOzQo6wjb7ts2TfUQxaxa4eK4GNS51O/PSKkfnMPOOfPPQ3qqo85F9p9+j
        6uuAnYs7mopfxT7rcWoSd9nPE7jjmft5DhlkweZXYGt0kNpqvJJ3U4l4Jx6MF+KiHWmz/2+T5Xt3/
        wUtzulir4RKq121CNWOaXwvrhFsdgDXYWtATKO9m1unqlIrBlInsZXMTgRo3VcV8yJDS2gG98HUE9
        TKC2zpp/sP9wRziJxpip7yLRzL4JXmNkdODQ3JVZ9Lk69Li0N4Suxf15eg8Ui4Hh19IHJcACcK8mX
        4xY0pWfw==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28qB-006slo-GQ; Fri, 17 Jun 2022 10:04:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: transfer the bio counter reference to the raid submission helpers
Date:   Fri, 17 Jun 2022 12:04:10 +0200
Message-Id: <20220617100414.1159680-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
References: <20220617100414.1159680-1-hch@lst.de>
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

Transfer the bio counter reference acquired by btrfs_submit_bio to
raid56_parity_write and raid56_parity_recovery together with the bio that
the reference was acuired for instead of acquiring another reference in
those helpers and dropping the original one in btrfs_submit_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c  | 16 ++++++----------
 fs/btrfs/volumes.c | 15 +++++++--------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index cd39c233dfdeb..00a0a2d472d88 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1815,12 +1815,11 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	if (IS_ERR(rbio)) {
 		btrfs_put_bioc(bioc);
 		ret = PTR_ERR(rbio);
-		goto out;
+		goto out_dec_counter;
 	}
 	rbio->operation = BTRFS_RBIO_WRITE;
 	rbio_add_bio(rbio, bio);
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
 	rbio->generic_bio_cnt = 1;
 
 	/*
@@ -1852,7 +1851,6 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 
 out_dec_counter:
 	btrfs_bio_counter_dec(fs_info);
-out:
 	bio->bi_status = errno_to_blk_status(ret);
 	bio_endio(bio);
 }
@@ -2209,6 +2207,8 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	if (generic_io) {
 		ASSERT(bioc->mirror_num == mirror_num);
 		btrfs_bio(bio)->mirror_num = mirror_num;
+	} else {
+		btrfs_get_bioc(bioc);
 	}
 
 	rbio = alloc_rbio(fs_info, bioc);
@@ -2231,12 +2231,8 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 		goto out_end_bio;
 	}
 
-	if (generic_io) {
-		btrfs_bio_counter_inc_noblocked(fs_info);
+	if (generic_io)
 		rbio->generic_bio_cnt = 1;
-	} else {
-		btrfs_get_bioc(bioc);
-	}
 
 	/*
 	 * Loop retry:
@@ -2266,8 +2262,8 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	return;
 
 out_end_bio:
-	if (generic_io)
-		btrfs_put_bioc(bioc);
+	btrfs_bio_counter_dec(fs_info);
+	btrfs_put_bioc(bioc);
 	bio_endio(bio);
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 844ad637a0269..fea139d628c04 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6756,8 +6756,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
 				&map_length, &bioc, mirror_num, 1);
-	if (ret)
-		goto out_dec;
+	if (ret) {
+		btrfs_bio_counter_dec(fs_info);
+		bio->bi_status = errno_to_blk_status(ret);
+		bio_endio(bio);
+		return;
+	}
 
 	total_devs = bioc->num_stripes;
 	bioc->orig_bio = bio;
@@ -6771,7 +6775,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			raid56_parity_write(bio, bioc);
 		else
 			raid56_parity_recover(bio, bioc, mirror_num, true);
-		goto out_dec;
+		return;
 	}
 
 	if (map_length < length) {
@@ -6786,12 +6790,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
 	}
-out_dec:
 	btrfs_bio_counter_dec(fs_info);
-	if (ret) {
-		bio->bi_status = errno_to_blk_status(ret);
-		bio_endio(bio);
-	}
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

