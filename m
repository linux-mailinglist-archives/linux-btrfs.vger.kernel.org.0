Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7471572DFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiGMGOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiGMGOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75FB9DAF
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3ZUZGBZWOTmbQRH0/5LcXPbyTw05XGaqcqgtGmJQZU8=; b=1orgxqAM3B0VgSXkmtbr2Pnz3q
        8jUZyEOSj95YNo3uvt/8nQLqnkmZBf00VRLDc4odij62wGn3xPi2FBNEZKYVpmGH/KTmfuV2RE6eF
        bBhjReUxFAD/W4Zi/vDU8CK5hzo5fWk4vz8xVhByO5rIWiRwZAjUHs9UUf4SUI1jhoEmyWuI8uHrg
        89Wu1grOGYCl8EdQlXoN12R0Jr0xj0Qw2Yi+wo0sylQBPVP2AJp5ByGgR1RtoP4S4rHC8ltDXxPvT
        8p2IK+uVhZHL0Dqp0TRnbgqsovSzAuwilNOpOozpdj90dfdVDR3huATfIIaGAgepE8ya3IkesMAQU
        NpOJyPUA==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdT-000T2O-3s; Wed, 13 Jul 2022 06:14:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: don't take a bio_counter reference for cloned bios
Date:   Wed, 13 Jul 2022 08:13:52 +0200
Message-Id: <20220713061359.1980118-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
References: <20220713061359.1980118-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Stop grabbing an extra bio_counter reference for each clone bio in a
mirrored write and instead just release the one original reference in
btrfs_end_bioc once all the bios for a single btfs_bio have completed
instead of at the end of btrfs_submit_bio once all bios have been
submitted.

This means the reference is now carried by the "upper" btrfs_bio only
instead of each lower bio.

Also remove the now unused btrfs_bio_counter_inc_noblocked helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       | 1 -
 fs/btrfs/dev-replace.c | 5 -----
 fs/btrfs/volumes.c     | 6 ++----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 68a10c515dd65..1d33bec9c6b72 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3996,7 +3996,6 @@ static inline void btrfs_init_full_stripe_locks_tree(
 
 /* dev-replace.c */
 void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
-void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info);
 void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
 
 static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f43196a893ca3..eabf6de361c68 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1289,11 +1289,6 @@ int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
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
index ce86ab6207eab..3f5672b362202 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6673,6 +6673,8 @@ static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
 	struct bio *orig_bio = bioc->orig_bio;
 	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
 
+	btrfs_bio_counter_dec(bioc->fs_info);
+
 	bbio->mirror_num = bioc->mirror_num;
 	orig_bio->bi_private = bioc->private;
 	orig_bio->bi_end_io = bioc->end_io;
@@ -6720,7 +6722,6 @@ static void btrfs_end_bio(struct bio *bio)
 	if (bio != bioc->orig_bio)
 		bio_put(bio);
 
-	btrfs_bio_counter_dec(bioc->fs_info);
 	if (atomic_dec_and_test(&bioc->stripes_pending))
 		btrfs_end_bioc(bioc, true);
 }
@@ -6775,8 +6776,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
-
 	btrfsic_check_bio(bio);
 	submit_bio(bio);
 }
@@ -6828,7 +6827,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 
 		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
 	}
-	btrfs_bio_counter_dec(fs_info);
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

