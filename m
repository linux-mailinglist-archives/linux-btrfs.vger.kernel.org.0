Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71C0513531
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbiD1Nfj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346791AbiD1Nfi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 09:35:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B396DF73
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=szSFhvDPCDdTNwUe9RKDNpocYxN9cmsVeyvWQ0LQ02w=; b=uwi7R7yfCMJ4MR0lne1CPrVy5X
        OItnN/qMtnC8WJ84TCIn0gGRNZpyOnLbjyMxziKDkB7w4KEmXoCSaOszZlDnqd21+k8bDZN6BeRie
        B6X7SwlnbTiUgrXW7G5s/bahzlVHGk8cfgaPjmqNZCTVKLsoN319vpAK22eg/e1wSn3eQyU2n2/Jx
        228muTWGI/7UakJZHSFqqm2mb34WiwsBtZJjKY7wdlabUL4+Tgp40tcM+IFYol+zdQfHOV9PC/pir
        uxV9lJvgDVWbqNJ2nT/McW2HXWSgtQR27/QvtugyqVAXppJwun8stIS++80Bgw77NjgpwL+VRRqhb
        +Q8nbr2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk4Fr-0074e0-TH; Thu, 28 Apr 2022 13:32:23 +0000
Date:   Thu, 28 Apr 2022 06:32:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 02/12] btrfs: always save bio::bi_iter into
 btrfs_bio::iter before submitting
Message-ID: <YmqXZ1Oa8UX3n2ZP@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 03:18:48PM +0800, Qu Wenruo wrote:
> Lower level bio mapping, from driver to dm, even btrfs chunk mapping
> can modify bio::bi_iter.
> 
> This prevents us from doing two things:
> 
> - Iterate the bio range of a cloned bio
>   This is only utilized by direct IO, thus it's already using
>   btrfs_bio::iter, which is populated in btrfs_bio_clone_partial().
> 
> - Grab the original logical bytenr of a bio
>   This will be utilized by incoming read repair patches.
> 
> So to make sure all btrfs_bio submitted to own a proper iter, this patch
> will assigned btrfs_bio::iter in the following call sites:

Independent of what we want to do with the saved iter in the future
I don't think this is an improvement.  The place where we can start
advancing the iter is after the bio is submit by btrfs_map_bio, so that
is the one central place where it should be saved.  I actually had
a patch like that in one my my wip branches:

---
From: Christoph Hellwig <hch@lst.de>
Subject: btrfs: centralize stashing away ->bi_iter in btrfs_map_bio

Once a bio is submitted to a driver, the driver can advance bi_iter.
Save to the copy in the btrfs_bio just before that can happen rather
than in random places high up in the stack.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 7 +------
 fs/btrfs/volumes.c   | 3 +++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 07888cce3bce6..002b1ea92e398 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2683,7 +2683,6 @@ int btrfs_repair_one_sector(struct inode *inode,
 	}
 
 	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_bbio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(btrfs_sb(inode->i_sb),
 		    "repair read error: submitting new read to mirror %d",
@@ -3209,14 +3208,11 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
 
 struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)
 {
-	struct btrfs_bio *bbio;
 	struct bio *new;
 
 	/* Bio allocation backed by a bioset does not fail */
 	new = bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
-	bbio = btrfs_bio(new);
-	btrfs_bio_init(bbio);
-	bbio->iter = bio->bi_iter;
+	btrfs_bio_init(btrfs_bio(new));
 	return new;
 }
 
@@ -3235,7 +3231,6 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	btrfs_bio_init(bbio);
 
 	bio_trim(bio, offset >> 9, size >> 9);
-	bbio->iter = bio->bi_iter;
 	return bio;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 748614b00ffa2..f282a58a12344 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6750,6 +6750,9 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	int total_devs;
 	struct btrfs_io_context *bioc = NULL;
 
+	/* stash away the iter as the low-level processing can advance it */
+	btrfs_bio(bio)->iter = bio->bi_iter;
+
 	length = bio->bi_iter.bi_size;
 	map_length = length;
 
-- 
2.30.2

