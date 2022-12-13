Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11364B13E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiLMIhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLMIhC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:37:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C562FB
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TmHCXF/h68Vn2g6lKC6oVR4O4gpIrtHEUfl0yz1m3rI=; b=BpiaeQq4nKC5mhVHi6wqCDwG00
        94trQld1fOkjjsJ8zMYm7n3/vvXl7LLYiBYf27M+d2IoWmL/IKffD0llokcVzI0rrxE1B6MnQtajb
        u3l+6IlRRj9U7Z30Xs5pZRGT3HA9w3j+IjF/oEgBoxek3PDdi7BRa28e8pv9CsSFF6qe7w7EuQLnn
        FyphmbIshPWXHbO68M+jQhhrkExv9Pp5jeQiMK0gZF1Ru7dmNdnOpZp7bjsZ2qe6K3YTiMGkpBh+R
        WuUD0723YPbb4fi8L30FGnbJqQkWwIFOomJ2Foqe2jtOJZCmYB2ud/68Yd92MqHlTDEFOhpdn+2IU
        rzAhTmKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50mZ-00DyAs-Mn; Tue, 13 Dec 2022 08:36:59 +0000
Date:   Tue, 13 Dec 2022 00:36:59 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y5g5q1O4dj9e04E4@infradead.org>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
 <Y5bWt7ENo2OkKK+v@infradead.org>
 <e69f2a95-3802-d8f7-2415-5320903a876e@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69f2a95-3802-d8f7-2415-5320903a876e@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 08:15:43AM +0000, Johannes Thumshirn wrote:
> >> +	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
> >> +		INIT_WORK(&bbio->raid_stripe_work, btrfs_raid_stripe_update);
> >> +		schedule_work(&bbio->raid_stripe_work);
> > 
> > This needs to be on a specific workqueue (or maybe multiple if/when
> > metadata and freespace inodes are supported).  Note that end_io_work
> > isn't currently used for writes, so you can reuse it here.
> 
> I'm not sure I understand your comment. It is on a specific workqueue,
> nameley 'raid_stripe_work'.

No.  It is a work_struct scheduled on system_wq:

static inline bool schedule_work(struct work_struct *work)
{
	return queue_work(system_wq, work);
}

> > 
> > It seems like the chunk_map lookup is only needed to figure out if
> > the chunk needs a stripe tree update, which seems rather inefficient.
> > Can't we find some way to stash away that bit from the submission path
> > instead of rediscovering it here?
> > 
> 
> True, but I've not yet found a good solution to this problem TBH. I could
> do a call to btrfs_need_stripe_tree_update() at the start of a transaction
> and then cache the value. That's the only way I can think of it atm.

So to me the btrfs_delayed_data_ref, or for better packing reasons,
btrfs_delayed_ref_node would seem like the more suitable structure as
that contains all the other relevant information.

But in general this makes me thing of you are really inserting the
stripe tree at the right place in the btrfs code [caveat:  I'm still
a learner on a lot of the btrfs structure..], as the whole delayed_ref
mechanisms seems to be about the file offset to logical mapping,
and not logical to physical.  What is the argument of not inserting
the stripe tree from btrfs_finish_ordered_io similar to the L2P
mapping rewrite for the "normal" zoned write completion?  Nothing
in the stripe deals with file-level offsets, so piggying it back
on the file extent insert seems a bit odd.
