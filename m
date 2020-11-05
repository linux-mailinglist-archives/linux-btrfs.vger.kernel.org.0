Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D312A7BE0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 11:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgKEKcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 05:32:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:36106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKEKcD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 05:32:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604572322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=wjqbqqetuIHOmU+FIVSIojfVedIb2TITcOV/xDSp+WU=;
        b=RLY+nHo8DlknxfwpbJKlTVMg2F/3RcYdf5409VKRiW5+yNVkgLUF5S98rFLEYhiCnvT1N4
        5TErYh26M7ldyq9FJLJQXiOdapo3ljuEXCUf+WmXzlDpgFUXYxWISydClKFs+WzMviZgEf
        AvDNcA5/ufllfoKX9o0CkWuL/kfAI2E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EDEEAAF1;
        Thu,  5 Nov 2020 10:32:02 +0000 (UTC)
Subject: Re: [PATCH 01/32] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-2-wqu@suse.com>
 <831ff919-f4f4-7f1b-1e60-ce8df4697651@suse.com>
 <1e7bf8d5-30d0-a944-c400-b5fe870f1cb5@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <07ee7ff2-e2b1-5318-b72e-8bff87231036@suse.com>
Date:   Thu, 5 Nov 2020 12:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1e7bf8d5-30d0-a944-c400-b5fe870f1cb5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.20 г. 12:15 ч., Qu Wenruo wrote:
> 
> 

<snip>

>>
>> The endio routine cares about logical file contiguity as evidenced by
>> the fact it uses page_offset() to calculate 'start', however our recent
>> discussion on irc with the contiguity in csums bios clearly showed that
>> we can have bios which contains pages that are contiguous in their disk
>> byte nr but not in their logical offset, in fact Josef even mentioned on
>> slack that a single bio can contain pages for different inodes so long
>> as their logical disk byte nr are contiguous. I think this is not an
>> issue in this case because you are doing the unlock on a bvec
>> granularity but just the above statement is somewhat misleading.
> 
> Right, forgot the recent discovered bvec contig problem.
> 
> But still, the contig check condition is still correct, just the commit
> message needs some update.
> 
> Another off-topic question is, should we allow such on-disk bytenr only
> merge (to improve the IO output), or don't allow them to provide a
> simpler endio function?

Can't answer that without quantifying what the performance impact is so
we can properly judge complexity/performance trade-off!

<snip>

>> I suspect for large bios with a lot of bvecs this would likely increase
>> latency because we will now invoke endio_readpage_release_extent
>> proportionally to the number of bvecs.
> 
> I believe the same situation.
> 
> Now we need to do extent_io tree operations for each bvec.
> We can slightly reduce the overhead if we have something like globally
> cached extent_state.
> 
> Your comment indeed implies we should do better extent contig cache,
> other than completely relying on extent io tree.
> 
> Maybe I could find some good way to improve the situation, while still
> avoid doing the existing dancing.

First I'd like to have numbers showing what the overhead otherwise it
will be impossible to tell if whatever approach you choose brings any
improvements.

<snip>

>> Also bear in mind that this happens in a critical endio context, which
>> uses GFP_ATOMIC allocations so if we get ENOSPC it would be rather bad.
> 
> I know you mean -ENOMEM.

Yep, my bad.

> 
> But the true is, except the leading/tailing sector of the extent, we
> shouldn't really cause extra split/allocation.

That's something you assume so the real behavior might be different,
again I think we need to experiment to better understand the behavior.

<snip>

>> I definitely like the new code however without quantifying what's the
>> increase of number of calls of endio_readpage_release_extent I'd rather
>> not merge it.
> 
> Your point stands.
> 
> I could add a new wrapper to do the same thing, but with a small help
> from some new structure to really record the
> inode/extent_start/extent_len internally.
> 
> The end result should be the same in the endio function, but much easier
> to read. (The complex part would definite have more comment)
> 
> What about this solution?

IMO the best course of action is to measure the length of extents being
unlocked in the old version of the code and the number of bvecs in a
bio. That way you would be able to extrapolate with the new version of
the code how many more calls to extent unlock would have been made. This
will tell you how effective this optimisation really is and if it's
worth keeping around.

<snip>

