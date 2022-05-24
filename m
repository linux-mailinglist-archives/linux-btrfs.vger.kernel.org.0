Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0A53241C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiEXHca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiEXHcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:32:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB01496B6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 00:32:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4E0A68AFE; Tue, 24 May 2022 09:32:16 +0200 (CEST)
Date:   Tue, 24 May 2022 09:32:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Message-ID: <20220524073216.GB26145@lst.de>
References: <20220522114754.173685-1-hch@lst.de> <20220522114754.173685-9-hch@lst.de> <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com> <20220522123108.GA23355@lst.de> <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com> <20220522125337.GB24032@lst.de> <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com> <20220523062636.GA29750@lst.de> <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 23, 2022 at 03:46:02PM +0800, Qu Wenruo wrote:
>> Becasue btrfs_repair_io_failure can't handle multiple-page I/O.  It
>> is also is rather cumbersome because it bypassed the normal bio
>> mapping.  As a follow on I'd rather move it over to btrfs_map_bio
>> with a special flag for the single mirror parity write rather than that
>> hack.
>
> In fact so far for all callers of btrfs_repair_io_failure(), we are
> always handling things inside one stripe.
>
> Thus we can easily enhance that function to handle multi page ranges.
>
> Although a dedicated btrfs_map_bio() flags seems more generic and better.

I did think of moving btrfs_repair_io_failure over to my new
infrastructure in fact, because it seems inherently possible.  Just
not the highest priority right now.

>> Because the whole bio at this point is all the bad sectors.  There
>> is no point in writing only parts of the bio because that would leave
>> corruption on disk.
>>
>>>    The only reason I can think of is, we're still trying to do some
>>>    "optimization".
>>>
>>>    But all our bio submission is already synchronous, I doubt such
>>>    "optimization" would make much difference.
>>
>> Can you explain what you mean here?
>
> We wait for the read bio anyway, I doubt the batched write part is that
> important.

I still don't understand the point.  Once we read more than a single
page, writing it back as a patch is completely trivial as shown by
this series.  Why would we not do it?

>
> If you really want, I can try to make the write part asynchronous, while
> still keep the read part synchronous, and easier to read.

Asynchronous writes gets us back into all the I/O completion handler
complexities, which was the whole reason to start on the synchronous
repair.

> In your current version, the do {} while() loop iterates through all
> mirrors.
>
> But for the following case, we will hit problems thanks to RAID1C3 again:
>
> Mirror 1 	|X|X|X|X|
> Mirror 2	|X| |X| |
> Mirror 3	| |X| |X|
>
> We hit mirror 1 initially, thus @initial_mirror is 1.
>
> Then when we try mirror 2, since the first sector is still bad, we jump
> to the next mirror.
>
> For mirror 3, we fixed the first sector only. Then 2nd sector is still
> from mirror 3 and didn't pass.
> Now we have no more mirrors, and still return -EIO.

Can you share a test case?  The code resets initial_mirror as soon as
we made any progress so that should not happen.

> So my points still stand, if we want to do batched handling, either we
> go bitmap or we give up.

Why?  For the very common case of clustered corruption or entirely
failing reads it is significantly faster than a simple synchronous
read of each sector, and also much better than the existing code.
It also is a lot less code than the existing code base, and (maybe
I'm biassed) a lot more readable.

Bitmaps only help you with randomly splattered corruption, which simply
is not how SSDs or hard drives actually fail.

> Such hacky bandage seems to work at first glance and will pass your new
> test cases, but it doesn't do it any better than sector-by-sector waiting.
> (Forgot to mention, the new RAID1C3 test case may also be flawed, as any
> read on other mirrors will cause read-repair, screwing up our later
> retry, thus we must check pid first before doing any read.)

The updated version uses the read from mirror loop from btrfs/142
that cleverly used bash internals to not issue the read if it would
be done using the wrong mirror.  Which also really nicely speeds up
the tests including the exist 140 and 141 ones.
