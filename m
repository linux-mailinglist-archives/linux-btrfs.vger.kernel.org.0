Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1194EC7F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbiC3PQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiC3PQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 11:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4307139866
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 08:14:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8171B1F38C;
        Wed, 30 Mar 2022 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648653254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQiz/9aEAeWbrR42dqdnPJfGpmtXseGSmKyH26QcgBE=;
        b=cEjDduIZo4KAgesjKRbItB/ZFJWcOXxQwaYOqrFKSSvsbuy434A2/2ACQwYKcLYqX2E/wj
        pJArxeMwTPNj/V8r1uz9z0vzj2zRLxcz/clLrmoxwXHFUDw8je08C+eOz+f8+MJwnPxhPQ
        gCao0RkHBrPNyOUyEOxtLIQfnQV6aUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648653254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQiz/9aEAeWbrR42dqdnPJfGpmtXseGSmKyH26QcgBE=;
        b=EuW7LZvrzwnk/Lcri/9+TKzt0Edk6RaXX9ade2bvCVlaPbeGtWdG3g4XUPncwGShzyUkH7
        e/MQfxV4/nuKmTCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4B80FA3B88;
        Wed, 30 Mar 2022 15:14:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46B46DA7F3; Wed, 30 Mar 2022 17:10:16 +0200 (CEST)
Date:   Wed, 30 Mar 2022 17:10:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Message-ID: <20220330151016.GG2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-3-hch@lst.de>
 <PH0PR04MB7416CF5DB1670FF12D823D779B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220328191240.GT2237@twin.jikos.cz>
 <20220328230426.n3aanogu7at7hnsj@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328230426.n3aanogu7at7hnsj@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 11:04:26PM +0000, Naohiro Aota wrote:
> On Mon, Mar 28, 2022 at 09:12:40PM +0200, David Sterba wrote:
> > On Fri, Mar 25, 2022 at 09:09:56AM +0000, Johannes Thumshirn wrote:
> > > On 24/03/2022 17:54, Christoph Hellwig wrote:
> > > > Zone Append bios only need a valid block device in struct bio, but
> > > > not the device in the btrfs_bio.  Use the information from
> > > > btrfs_zoned_get_device to set up bi_bdev and fix zoned writes on
> > > > multi-device file system with non-homogeneous capabilities and remove
> > > > the pointless btrfs_bio.device assignment.
> > > > 
> > > > Add big fat comments explaining what is going on here.
> > > 
> > > Looks like the old code worked by sheer luck, as we had wbc set and thus
> > > always assigned fs_info->fs_devices->latest_dev->bdev to the bio. Which 
> > > would obviously not work on a multi device FS.
> > 
> > No, it worked fine because the real bio is set just before writing the
> > data somewhere deep in the io submit path in submit_stripe_bio().
> > 
> > That it has to be set here is because of the cgroup implementation that
> > accesses it, see 429aebc0a9a0 ("btrfs: get bdev directly from fs_devices
> > in submit_extent_page").
> > 
> > Which brings me to the question if Christoph's fix is correct because
> > the comment for the wbc + zoned append is assuming something that's not
> > true.
> 
> While the real bio is setup in submit_stripe_bio(), we need to set the

Oh sorry I actually wanted to say that the real 'bdev' is set in
submit_stripe_bio (ie. the one where the write is going to be done).

> device destination for bio_add_zone_append_page() called in
> btrfs_bio_add_page(). The bio_add_zone_append_page() checks that the
> bio length is not exceeding max_zone_append_sectors() of the device,
> and checks other hardware restrictions.

Yeah, but can this still mean that it's checking potentially different
devices with different hw restrictions? In alloc_new_bio() it's one and in
submit_stripe_bio() it's a different one.

Before the cgroup writeback was added to bios, the only reason why
bio_set_bdev required the block device is to check if it's the same one
as before and drop some bit:

static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
{
	bio_clear_flag(bio, BIO_REMAPPED);
	if (bio->bi_bdev != bdev)
		bio_clear_flag(bio, BIO_THROTTLED);
	bio->bi_bdev = bdev;
	bio_associate_blkg(bio);		<-- this was not here
}

So the latest_dev was just a stub to satisfy the bio API requirements.
Please note that its existence spans a long time and things have
changed, I remember that Chris' answer to why we need the latest_dev was
"to put something to the bios". Ie. we don't need it because we have to
write same data to different block devices and distribute that in
submit_stripe_bio(), while the bios have to be set much earlier
expecting a block device.

I'm not sure we have a 1:1 match in what the APIs provide and expect and
what btrfs wants to do. At this point multi-device support for zoned
mode is not complete so we probably won't observe any problems with
hardware with different restrictions.
