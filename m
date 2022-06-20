Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA05511C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiFTHsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiFTHsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 03:48:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74710548
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 00:47:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1032168AA6; Mon, 20 Jun 2022 09:47:43 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:47:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
Message-ID: <20220620074742.GB11832@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-7-hch@lst.de> <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com> <1b21e3e9-cdd9-baa6-bd39-e9489de883ff@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b21e3e9-cdd9-baa6-bd39-e9489de883ff@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 05:50:53AM +0800, Qu Wenruo wrote:
> In fact, the bio counter for btrfs_map_bio() is just increased and to
> allow the real bios (either the RAID56 code, or submit_stripe_bio()) to
> grab extra counter to cover the full lifespan of the real bio.
>
> Thus I don't think there is any bio counter to be "transferred" here.

What is the real bio?

In the parity raid case there is:

 1) the upper level btrfs_bio, which is handed off to
    raid56_parity_write / raid56_parity_recover.
    It then to the bios list of the rbio and is eventually completed
 2) lower-level RAID bios, which have no direct connection to the
    btrfs_bio, as they are all driven off the rbio-based state
    machine

For the non-parity case we have

 1) the upper level btrfs_bio, which is submitted to the actual devic
    as the last mirror (write case) or the only bio (read case)
 2) the clones for the non-last mirror writes

btrfs_submit_bio calls btrfs_bio_counter_inc_blocked before
__btrfs_map_block to protect against device replace operations,
and that protection needs to last until the last bio using the
mapping returned from __btrfs_map_block has completed.

So we don't need an extra count for the parity case.  In fact we
don't really need an extra count either for the non-parity case
except for additional mirror writes.  So maybe things are cleaned
up if we also add this patch (which relies on the previous ones in
this series):

---
From 6351835b133ce00e2d65a6b2a398678b45426947 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 Jun 2022 09:43:48 +0200
Subject: btrfs: don't take a bio_counter reference for cloned bios

There is no need for multiple bio_counter references for a single I/O.
Just release the reference when completing the bio and avoid additional
counter roundtrips.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h       | 1 -
 fs/btrfs/dev-replace.c | 5 -----
 fs/btrfs/volumes.c     | 7 ++-----
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1347c92234a56..6857897c77108 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3972,7 +3972,6 @@ static inline void btrfs_init_full_stripe_locks_tree(
 
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
index 33a232c897d14..86e200d2000f9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6647,14 +6647,14 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
-	btrfs_bio_counter_dec(bioc->fs_info);
-
 	if (bio != orig_bio) {
 		bio_endio(orig_bio);
 		bio_put(bio);
 		return;
 	}
 
+	btrfs_bio_counter_dec(bioc->fs_info);
+
 	/*
 	 * Only send an error to the higher layers if it is beyond the tolerance
 	 * threshold.
@@ -6698,8 +6698,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
-
 	if (!dev || !dev->bdev ||
 	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
 	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
@@ -6781,7 +6779,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
 	}
-	btrfs_bio_counter_dec(fs_info);
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

