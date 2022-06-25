Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1D55A886
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jun 2022 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiFYJP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jun 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiFYJP5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jun 2022 05:15:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B8627B
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jun 2022 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j9nAdcmRNVwzw+BYWp5s7/0FjPCKKI3p8GpOXegXgpM=; b=CHQpxEnwYcHPCBQWNqTpOyzvyU
        X8ZKjZTfR7gLCwgO7WpIEYI0hLOsq8fZqK3A0dznNIyoxlv7xsEQiNU3fmKfQ6kXUSR8tMQ1go2jb
        KdNjrdZo76oQ2+oLHH+8wZDaOERfD4KyLZVPlBxUL+sd/ikQx+K+SzjkIycRQ8Rf2xEFkDti9y8ie
        x0+pzwMzg2u5H78P88UOFyNTUPO94lSRWtZcY4WLdU7sEAvvIhb4UdS14LbzxTTrPnfgkD5qCSASj
        G5NeC63vabecAGtj+AuE5ftmPFSENljeZfXNvnO4pMsy7pA4t4misb4fj9o2wpQUJmhIigIAsCXUm
        nJ3RCiew==;
Received: from [2001:4bb8:199:3788:cdf3:f638:73a9:fca4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o51tO-005IPp-J8; Sat, 25 Jun 2022 09:15:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't take a bio_counter reference for cloned bios
Date:   Sat, 25 Jun 2022 11:15:47 +0200
Message-Id: <20220625091547.102882-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

There is no need for multiple bio_counter references for a single I/O.
Just release the reference when completing the bio and avoid additional
counter roundtrips.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

This is against the for-next branch as it is a follow up the review
feeback to the "cleanup btrfs bio submission v2" series.

 fs/btrfs/ctree.h       | 1 -
 fs/btrfs/dev-replace.c | 5 -----
 fs/btrfs/volumes.c     | 6 +-----
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aabc..ad15c0c602a61 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3987,7 +3987,6 @@ static inline void btrfs_init_full_stripe_locks_tree(
 
 /* dev-replace.c */
 void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
-void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info);
 void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
 
 static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index a7dd6ba25e990..aa435d04e8ef3 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1288,11 +1288,6 @@ int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
 	return 1;
 }
 
-void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info)
-{
-	percpu_counter_inc(&fs_info->dev_replace.bio_counter);
-}
-
 void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount)
 {
 	percpu_counter_sub(&fs_info->dev_replace.bio_counter, amount);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6aa6bc769569a..207e136d1a721 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6647,8 +6647,6 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
-	btrfs_bio_counter_dec(bioc->fs_info);
-
 	if (bio != orig_bio) {
 		bio_endio(orig_bio);
 		bio_put(bio);
@@ -6664,6 +6662,7 @@ static void btrfs_end_bio(struct bio *bio)
 	else
 		orig_bio->bi_status = BLK_STS_OK;
 
+	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
 	orig_bio->bi_end_io = bioc->end_io;
 	orig_bio->bi_private = bioc->private;
@@ -6698,8 +6697,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
-
 	if (!dev || !dev->bdev ||
 	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
 	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
@@ -6780,7 +6777,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 
 		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
 	}
-	btrfs_bio_counter_dec(fs_info);
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

