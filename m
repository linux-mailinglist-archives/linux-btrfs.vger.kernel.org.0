Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7455136F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiFTIyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiFTIx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 04:53:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C222637
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 01:53:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9342568AA6; Mon, 20 Jun 2022 10:53:40 +0200 (CEST)
Date:   Mon, 20 Jun 2022 10:53:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: remove bioc->stripes_pending
Message-ID: <20220620085340.GA13344@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-11-hch@lst.de> <bc18e270-371c-98ee-28c2-fd4305206d7a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc18e270-371c-98ee-28c2-fd4305206d7a@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 11:18:03AM +0300, Nikolay Borisov wrote:
> What if the the currently completed stripe bio is the last - then bio_endio 
> would be called for orig_bio, which will executed bi_end_io() in softirq 
> context, but for reads we want to execute this in process context (as per 
> the below code) ?

> The old code guaranteed that btrfs_end_bioc() is executed when the last 
> stripe bio was completed. With this new scheme, say we have 3 bios - 2 
> cloned, 1 being the orig, what guarantees that the orig_bio won't be 
> finished before the remaining 2 (or 1) cloned/stripe bios thus calling 
> btrfs_end_bio() on orig bio with __bi_remaining potentially being 2 or 1 
> and finally calling orig_bio->bi_end_io() again with __bi_remaining being 
> elevated?

This is what the bio_inc_remaining after the bio_alloc_clone takes care
of.  With that the remaining count in the original btrfs_bio is
incremented, which ensures that ->end_io for the originl bio is only
called when all other bios and the original one have completed.

Take a look at bio_endio and bio_remaining_done for the glory details.

>>   	if (clone) {
>> -		bio = bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS, &fs_bio_set);
>> +		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
>> +		bio_inc_remaining(orig_bio);
>
> When cloning why aren't you passing dev->bdev but instead set it after the 
> checks via bio_set_dev ? Is it because of the
>
> if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION))
>
> check inside bio_endio in case bio_io_error is called in submit_stripe_bio?

It is because we don't know if we have a valid bdev until after
the checks a few line down that call bio_io_error.  We need those
checks to be done later now so that all error handling goes through
the bio end_io handler.
