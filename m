Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EED58B46B
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiHFIDs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFIDr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:03:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD313DFB
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YOCiyT2BF++82GKrxYj/9ICMCMBRtm6I1vevB0OTBkM=; b=B+tVKQ5YR2axDIVikdJvwFjXET
        mtX4bTIDHs9EhV+mUWX0q2zYRCYbVxDtSubiUv2ZrgBhHOuWPMnufr4mn0V6QWIe60C20Cq0GuVTf
        yuP2zsQjtPa9VyrlTz+1LedfgMbJ9SxGiizkirVNgBOYh+mK8HT6OeNXm+TdliLbWMUKRZS5eko1d
        YWCjfyHRFPxbL/QfJ/CVIc69iXM5bXMdW6qoqtYTV7apqwieWiI3yG1FjEYYO1sFIK8MlOvvhQ9Gu
        GQ5tPVa6cMhrY3mSVZltH3RspCc39L4UccO59kAGRYp1cQaXvsK44YiKdft9aIi/EfskZLdU/jhbn
        iM/5UPeQ==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEmc-006Loq-Ui; Sat, 06 Aug 2022 08:03:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: don't take a bio_counter reference for cloned bios
Date:   Sat,  6 Aug 2022 10:03:23 +0200
Message-Id: <20220806080330.3823644-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806080330.3823644-1-hch@lst.de>
References: <20220806080330.3823644-1-hch@lst.de>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h       | 1 -
 fs/btrfs/dev-replace.c | 5 -----
 fs/btrfs/volumes.c     | 6 ++----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 51c4804392637..e9a1d0016804a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -4079,7 +4079,6 @@ static inline void btrfs_init_full_stripe_locks_tree(
 
 /* dev-replace.c */
 void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
-void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info);
 void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
 
 static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 488f2105c5d0d..c26b3196a3f17 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1284,11 +1284,6 @@ int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
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
index a73bac7f42624..014df2e64e67b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6670,6 +6670,8 @@ static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
 	struct bio *orig_bio = bioc->orig_bio;
 	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
 
+	btrfs_bio_counter_dec(bioc->fs_info);
+
 	bbio->mirror_num = bioc->mirror_num;
 	orig_bio->bi_private = bioc->private;
 	orig_bio->bi_end_io = bioc->end_io;
@@ -6717,7 +6719,6 @@ static void btrfs_end_bio(struct bio *bio)
 	if (bio != bioc->orig_bio)
 		bio_put(bio);
 
-	btrfs_bio_counter_dec(bioc->fs_info);
 	if (atomic_dec_and_test(&bioc->stripes_pending))
 		btrfs_end_bioc(bioc, true);
 }
@@ -6772,8 +6773,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
-
 	btrfsic_check_bio(bio);
 	submit_bio(bio);
 }
@@ -6825,7 +6824,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 
 		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
 	}
-	btrfs_bio_counter_dec(fs_info);
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

