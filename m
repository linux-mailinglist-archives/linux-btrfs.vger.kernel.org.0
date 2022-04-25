Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4972350DEEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiDYLjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiDYLjC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 07:39:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7A912743
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:35:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A8D7568B05; Mon, 25 Apr 2022 13:34:58 +0200 (CEST)
Date:   Mon, 25 Apr 2022 13:34:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Message-ID: <20220425113458.GA26412@lst.de>
References: <20220425075418.2192130-1-hch@lst.de> <20220425075418.2192130-4-hch@lst.de> <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com> <20220425091920.GC16446@lst.de> <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com> <20220425110928.GA24430@lst.de> <bade7fa8-d95b-e0e8-0af8-e40fec341789@gmx.com> <20220425111925.GA25233@lst.de> <af44fee8-deb9-a3e2-a04f-06dbcc16b6c0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af44fee8-deb9-a3e2-a04f-06dbcc16b6c0@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 07:31:08PM +0800, Qu Wenruo wrote:
> Then it comes against the btrfs read time repair.
>
> Currently we split bio to make sure we never need to split bio at
> btrfs_map_bio() time.
>
> But this is against common layer separation.
>
> And we really want the ability to read a partially corrupted bio (some
> part matches csum, some doesn't), no matter if the bio is cloned or not.
>
> Especially, we already have cloned bio which needs repair (for dio).

I have a barely working version based on your patches to split the
bio in btrfs_bio_map that solves this problem.  But the next step
only removed the save iter for writes, where the only user is
index_one_bio.  And the fix for that is pretty trivial :)

---
From c8fe61748ebc583a7f57c8e5de79f92428e5717c Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 25 Apr 2022 13:23:54 +0200
Subject: btrfs: stop looking at btrfs_bio->iter in index_one_bio

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
index 1a3c1a9b10d0b..8b40353bb89db 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1218,9 +1218,6 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
 		     rbio->bioc->raid_map[0];
 
-	if (bio_flagged(bio, BIO_CLONED))
-		bio->bi_iter = btrfs_bio(bio)->iter;
-
 	bio_for_each_segment(bvec, bio, iter) {
 		u32 bvec_offset;
 
-- 
2.30.2

