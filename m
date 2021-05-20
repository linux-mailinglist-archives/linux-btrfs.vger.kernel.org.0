Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17952389E7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhETG7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:59:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:32784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhETG7u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:59:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621493908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cywWo1qcroWiWLo87JaYy4aECnk0se2HU74kcDPrmgQ=;
        b=BDnBGmwaXDeo2sy16QFgee88st/s8Mkcaixss2ali031wojxef1QhbUB0aGIg4JlpWCkRb
        +vTpELKYW/ka8XX4/UhV0/jVJIp73KTLJ2MLVS0Gge+rbbaa4mt8nKXZH8lr1Bd76Y9wmo
        83EvJ1zeAYdOA8Hzka8M22K06hTu8yY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B659AB004;
        Thu, 20 May 2021 06:58:28 +0000 (UTC)
Subject: Re: Behavior of btrfs_io_geometry()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20210520061138.d775gajnfj7h2xu4@naota-xeon>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <bb4d60e6-5bb0-d50a-ed20-309bb643dc06@suse.com>
Date:   Thu, 20 May 2021 09:58:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520061138.d775gajnfj7h2xu4@naota-xeon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20.05.21 г. 9:11, Naohiro Aota wrote:
> I have a few questions about btrfs_io_geometry()'s behavior. 
> 
> While I'm testing zoned btrfs on ZNS drive with 2GB zone size, I hit
> the following ASSERT in btrfs_submit_direct() by running fstests
> btrfs/017.
> 
> static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
> 		struct bio *dio_bio, loff_t file_offset)
> {
> ...
> 	start_sector = dio_bio->bi_iter.bi_sector;
> 	submit_len = dio_bio->bi_iter.bi_size;
> 
> 	do {
> 		logical = start_sector << 9;
> 		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
> ...
> 		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
> 					    logical, submit_len, &geom);
> ...
> 		ASSERT(geom.len <= INT_MAX);
> 
> 		clone_len = min_t(int, submit_len, geom.len);
> ...
> 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
> 
> 
> On zoned btrfs, we create a SINGLE block group whose size is equal to
> the device zone size, so we have a 2 GB SINGLE block group on a 2 GB
> zone size drive. Then, on a SINGLE single block group,
> btrfs_io_geometry() returns the remaining length from @logical to the
> end of the block group regardless of the @len argument. Thus, with
> @logical == 0, we get geom->len = 2 GB, which is larger than INT_MAX,
> hitting the ASSERT.
> 
> I'm confusing because I'm not sure what the ASSERT wants to do. It
> might want to guard btrfs_bio_clone_partial() (and bio_trim()) below?
> But, since bio_trim() takes sector-based values, and the passed
> "clone_offset" and "clone_len" is byte-based, we can technically allow
> larger bytes than INT_MAX. (well, we might never build such large bio,
> though). And, it looks meaningless to check geom->len here. Since, it
> can be much larger than bio size on a SINGLE block group.
> 
> So, in summary, below are my questions.
> 
> 1. About btrfs_bio_clone_partial()
>   1.1 What is the meaning of geom->len?
>       - Length from @logical to the stripe boundary? or
>       - Length [logical, logical+len] can go without crossing the boundary?

So think of it as splitting a block group into 64k chunks (those are the
stripes) then finding in which such 64k chunk/stripe_nr logical falls
within, so len would be the length of an io you could do without
crossing this 64k boundary. This process is described in
https://github.com/btrfs/btrfs-dev-docs/blob/master/bio-submission.txt
under section 'Bio mapping'. With this in mind I'd say it's  [logical,
logical+len] without crossing a 64k boundary. !!!HOWEVER!!!!  This
applies to bg types other than SINGLE , that's the
if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) check in the function.
We do this because for raid levels we'd like the io granularity to be
64k, whereas for SINGLE we simply issue a single write, i.e len is
calculated as:

len = em->len - offset;

which is why you are getting such the size of the block group.



>   1.2 @len is currently unused in btrfs_bio_clone_partial(), is this correct?

It's used to calculate @clone_len parameter so it's indirectly involved
in btrfs_bio_clone_partial.

>   1.3 What should we fill into geom->len when the block group is SINGLE profile?

See above.

> 
> 2. About the ASSERT
>   2.1 Shouldn't we check submit_len (= bio's length) instead of geom->len ?

The assert got added quite a while back so I'm not entirely sure it's
pertinent.

>   2.2 Can't it be larger than INT_MAX? e.g., INT_MAX << SECTOR_SHIFT?
> 
> 3. About btrfs_bio_clone_partial()
>   3.1 We can change "int" to "u64" maybe?

Can we though? So if size in btrfs_bio_clone_partial is switched to u64
then in that fuction we do size >> 9 potentially having a value of at
most 55 bits, passing it to bio_trim, which in turn takes an int. So
you'd be truncating values at the time you call bio_trim, no ?
