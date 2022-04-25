Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9459F50DC4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiDYJVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiDYJVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:21:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5704220EA
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:17:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E4E968AA6; Mon, 25 Apr 2022 11:17:55 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:17:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/10] btrfs: refactor btrfs_map_bio
Message-ID: <20220425091755.GA16446@lst.de>
References: <20220425075418.2192130-1-hch@lst.de> <20220425075418.2192130-10-hch@lst.de> <9ae89d00-7047-a207-6fd0-3223871576ca@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae89d00-7047-a207-6fd0-3223871576ca@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 04:56:21PM +0800, Qu Wenruo wrote:
>> +	if (!dev || !dev->bdev ||
>> +	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
>> +	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
>> +	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
>> +		atomic_inc(&bioc->error);
>> +		if (atomic_dec_and_test(&bioc->stripes_pending))
>> +			btrfs_end_bioc(bioc, false);
>
> The bioc is allocated by btrfs_map_block(), but freed inside a helper.
>
> This makes the allocation and free happening at different levels, not sure 
> if it's a good idea.

It is always freed by the end_io handler, this helper just decrements
the pending count and potentially invokes the orig bio end I/O handling
if we never made it to a bio submission for the pending mirror.

> I doubt this fallback would improve the readability.
>
> But you're also right, the original check condition for the RAID56 branch 
> is also not ideal.

I think it helps.  But the next series will do away with this anyway.

>>   	}
>>   -	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
>> -		dev = bioc->stripes[dev_nr].dev;
>> -		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
>> -						   &dev->dev_state) ||
>> -		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
>> -		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
>
> Maybe just make the complex if () condition into a helper?
>
> In fact I see some other locations uses similar complex expressions to 
> check it's a missing device.
>
> Thus it should help a lot of call sites.

I'll see if a helper could be useful here.
