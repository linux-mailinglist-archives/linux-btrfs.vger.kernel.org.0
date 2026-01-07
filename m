Return-Path: <linux-btrfs+bounces-20191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A7CFE336
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 285BE3021796
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46811316184;
	Wed,  7 Jan 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewQCQhQ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C155324713
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794975; cv=none; b=apa6uK3RKzCDt6cd5ei+MDCVDN2zSJ1rH9M96csKibi0NHrqPYLxZnNXrW9nfdg3o+0dQ1X9p3+j+k/rrL9gBm4TH3n0OsHEe+hVuSfn3QAyDIRQllnD4x4QhLlH3GdkT2vAj2NrlkkX/lmQSUJVpmxL0dA6g4HCjM4Du9sBm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794975; c=relaxed/simple;
	bh=8Ahl0lDawO+aOdcFjnXs0dL2i2HnKl1hyuZOPr1RIrQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IOnSL50KOcg7NqrvFO07LC8e3wXAQexbGxODcVyK6jXTzGAB1uyFAk9sVdbW8g1CGpIxnubVYhuGUMSMqX2WEQLOvARZztkU4qZRAPYuEK09SXw8B+VGQCiCg1/Wa2M+3j77R95wxTBxGwI5K4HeQyI9/qyCDWw6gXMVCOLLZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewQCQhQ9; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29f08b909aeso5475425ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jan 2026 06:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767794970; x=1768399770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zZpGsTDEzY7U2Qqj9FtddJcbNFliW9Fjfoj8quoG9K0=;
        b=ewQCQhQ9ogGL+Ty8j7higwoWNMvYnG44XyY/4b9p5MLvF82b8aZLNPlFb3Ls/N+KnW
         pv5B34XxyvX91rXSfQ8eD6U7LXdGUKf2FmV7qtbJEsWL6bbPSX98VKf/aafM3pQCN3MM
         Oc8Qvi68oVh2JkhtBAD9NMH77aHfblrNpDL5/ygqv63edczPfbYkBhEsomwVUZhlz+1U
         LPmqZ68JcGzul+Mmz10uPThBkoUaH53tsoZ+wlYQgg0Zc8z4ffytti2FtwzDb4pX69FL
         W8bB7Hv7lsvV0JkKei7cq1c3rX1kMYnRYm0VzZgWsvUhQKOC/2BkFH4sr5wyIJOChs/d
         gpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794970; x=1768399770;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZpGsTDEzY7U2Qqj9FtddJcbNFliW9Fjfoj8quoG9K0=;
        b=XDlYmPA9qlpzULpkQHE6b6x9UjSqFp9eFL3EGo/Jm6QX/9wlXPoIFFIloz6V+ZTpYy
         3R9jo3nYbmQnERymHtAPILly5b8a16VVqHB5dhFrAhuUQLVzslL61AleHzMkNuEpqZmS
         uCcWBkQ5rL91SpAaOi8vw503Cl+gSAj+gYOKZ+4O+EPYaqDTBx6hSXwAwi/9PLZOxkE0
         D29HDFvDbjInhPjuFi+2bJz6VcgL/U9VWum2SOKAFSN05j4WU/1BngYAjlj3SZRNesxv
         ll3zdg0v/ODQOhd3B03NSIeirWJjzH6+rMsIg6J5290+v1+y/0GcwbcMLgEA9oZkKpYI
         zvbA==
X-Gm-Message-State: AOJu0YxW93XYbL6Di9lIzkyg48K52wFtlND+vwkBxiityQf2gHs9CZ/A
	mUFf+g5cMxCqUfWABurG4IHD3oe9ndRN/esTh8IpuEuE8pjLpCr8WmwaL/U2hirvL1ZSkA==
X-Gm-Gg: AY/fxX6idXTyktseDrhQUrcba6XwTP32yblJwFMXpnthewOErQ+l8gY6gWlClv3jg6s
	G+LVkqdEtebbXrMBR63+t+rwhSCaLZ6PAY4XQgnk5Zoh9K3fzMnCjGC5oNGkQvTHeKQUJgYpeVs
	dPEBWkVsWkNTnF/KyFbuneM0O94TEfSOrO2+XUT/Ce2BjCSVCmn7L6E9d8IcOrBcHtJ4K/S/FrP
	AEr0FYSWPOSdh6gdtASXazBsvIa2N316HjxqkJdxg0uTzegEXLAnvfbO2+Qo2NrOzkObYPNkB+E
	eJjwC3AaZppZmT+//8oxFh94kdOquSth5c/WeopKtWJ43zk1ClF1dGOR8pvChFTAN+hSJAMo7z8
	xZAv9h7SC8gD8lXE3jCMpfF30B0wgKk1aAG3Lo6aOKxTz3n0q5r9n7iLSXK8piwfOkEwsdN70I7
	+vBZ2n754tZ/YP+hzncm3rbpgp
X-Google-Smtp-Source: AGHT+IHpVrCOzJubIud17pZuRyylXoYSXlsH8PYFz2Mqk6ZqnEkoewC8r9fOHzEMiqycoDAnm0XFhA==
X-Received: by 2002:a17:902:cf12:b0:2a0:d07a:bb2f with SMTP id d9443c01a7336-2a3ee452449mr18460335ad.3.1767794969278;
        Wed, 07 Jan 2026 06:09:29 -0800 (PST)
Received: from [192.168.1.13] ([104.28.237.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd3632sm53464175ad.95.2026.01.07.06.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:09:28 -0800 (PST)
Message-ID: <f5986918-d95f-400c-8d45-86551ec16397@gmail.com>
Date: Wed, 7 Jan 2026 22:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sun Yangkai <sunk67188@gmail.com>
Subject: Re: [PATCH v2 1/7] btrfs: fix periodic reclaim condition
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20260103122504.10924-2-sunk67188@gmail.com>
 <20260103122504.10924-3-sunk67188@gmail.com>
 <20260104194008.GA416121@zen.localdomain>
 <7797d6e2-99b6-4112-9c7c-4cb09dde8486@gmail.com>
 <20260105182102.GA1015682@zen.localdomain>
Content-Language: en-US
In-Reply-To: <20260105182102.GA1015682@zen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/6 02:21, Boris Burkov 写道:

>> And we should continue periodic reclaim when we may be able to free more
>> blockgroups.
>>
> 
> This assumption I would push back on. This was my initial assumption as
> well, but it is worth challenging. At Meta, we used to use the automatic
> threshold based reclaim that reclaims every bg that goes over threshold
> (25% for us) then back under. This actually creates a huge amount of
> reclaim and was the reason for even coming up with dynamic thresholds.
> In practice, switching to the buggy dynamic+periodic drastically reduced
> this extra reclaim.

It seems hard to make periodic reclaim work practically with fixed threshold,
and maybe we can merge them into "auto reclaim" or something in future.

> Suppose we allocate some block extents / block groups then free half the
> space and fragment them. You might think it's best to rapidly compact
> everything. But as long as we have unallocated and the holes are big
> enough for allocations to come through and re-fill them, it's mostly OK.

I agree. When we have enough unallocated space, the fragment of free space is
not that bad and it may disappear automatically with future allocation.

> We much more want to do a "minimal" amount of reclaim until we truly
> need it.

And I guess we also don't want a "cliff", or we'll only try once with a high
threshold when "urgent" instead of using a dynamic threshold :)

> With all that said, your points above about the threshold going up but
> reclaim staying asleep make a lot of sense to me. That is a signal that
> the "need" is increasing.

>> For pausing, it's hard to tell if we're freeing more unallocated directly
>> without changing current code. But in btrfs_reclaim_bgs_work() we have
>>
>> btrfs_relocate_chunk()
>>   ->btrfs_remove_chunk()
>>     ->btrfs_remove_block_group()
>>
>> So the old blockgroup is removed and we can see that in space_info->total_bytes.
>>
>> Let's start with all the blockgroups having the same size and reclaiming a
>> single blockgroup. If we succeeded moving extents into existing blockgroups,
>> we'll not allocate a new one and space_info->total_bytes is getting smaller
>> because we've freed the old one. If we failed moving things into existing bgs
>> and allocated a new one, then space_info->total_bytes will not change.
> 
> Some of my comments on this point were silly, I was thinking about
> used_bytes which would not change, not total_bytes. Thanks for the
> detailed description to knock me out of that mistake.
> 
> Also, I'm not sure the logic about total_bytes is 100% ironclad, as
> I haven't carefully checked what block group allocation/freeing is
> possible concurrently over the span where you track the sizes.
> 
>>
>> When reclaiming n blockgroups, as long as we're using less space, such as n-1
>> new blockgroups are allocated or n new smaller blockgroups, we're making some
>> progress and able to detect that from space_info->total_bytes.
>>
>> Reclaim may racing with some other work that free/allocate blockgroups, which
>> will lead to either an unnecessary extra periodic reclaim or an unexpected
>> pause. An extra periodic reclaim is not a big thing. But the unexpected pause
>> matters. This is the only regression currently and I think that will not happen
>> frequently.
> 
> OK, we're on the same page with the possibility of some racing :)
> Your explanation makes sense and I don't think it's a huge deal or
> anything.
> 
>>
>> For continuing, rather than tracing used_bytes, I think we should care more
>> about unused_bytes. This is inspired by calc_dynamic_reclaim_threshold(), which
>> will return 0 if there's no enough unused space. And also care about
>> reclaim_threshold to make dynamic periodic reclaim work.
>>
>>
> 
> First, I think let's agree what we want and don't want to pause:
> I don't think we care about running the reclaim sweep and checking
> thresholds, updating marks, etc. That is relatively cheap. So if we
> change the pausing logic to still allow that work more often, it's OK.
> We really want to prevent triggering reclaims in tight fail loops.

> With that said, let's consider all the cases again.
> 
> 1. We scan all the bgs and don't attempt any reclaims.
> 2. We attempt a reclaim of BG X at threshold T and it completely fails to
> allocate a new home for extent E of X.
> 3. We attempt a reclaim of BG X at threshold T and it "succeeds" by
> allocating a new BG Y and moving all the extents from X to Y.
> 4. We attempt a reclaim of BG X at threshold T and it makes proper
> progress and puts some the extents of X into the existing bgs.
> 
> After case 1, I think we agree pausing isn't needed, and is in fact bad.

Yes!

> After cases 2 and 3, we want to avoid triggering more reclaim until we
> have evidence that it is likely a reclaim could possibly succeed. If
> unused gets worse since then, and the threshold goes up, it is
> *possible* a reclaim will succeed (we might pick a more full block group
> that happens to be full of smaller easy to allocate extents) but it is
> much more likely it won't. As far as I can tell, the best signal for
> unpausing reclaim for the "we have seen a reclaim fail" case is still
> "relative freeing" of extents.

> After case 4, we don't *need* to pause, as it is going to increase
> unallocated and reduce the "pressure" on the reclaim system, but it
> doesn't fundamentally hurt either. We made some progress and we want to
> be conservative and not be too greedy. Let allocation breathe and do
> some work to fill the gaps up. However, this case is quite different
> from 2 and 3 in that a subsequent relocation seems likely enough to also
> succeed.

Yes. I started as a user of this function, monitoring the threshold,
blockgroups' used rates, and filesystem's unallocated space. So I got confused
when there were still some blockgroups could be reclaimed but periodic reclaim
stopped working.

While you are the author of the function and focus on resolving the problem
behind (running out of unallocated space) so just reclaim some blockgroups is ok
so we don't need to try that hard.

> My original (designed) logic was "pause on 2,3,4; unpause on the
> conditions that unstick 2,3" which I think you have correctly argued is
> suboptimal. 4 can get stuck never reclaiming even as things get worse,
> even if we might succeed (we've never failed..)
> 
> So I think the best (short term) solution is:
> "detect failure modes 2 and 3 and unpause on release"
> 
> I believe your patches already enact "detect failure modes 2 and 3" and
> we just disagree on the unpausing mechanism.

For unpausing, I think we both agree on

1. enough space freed
2. threshold changed to a larger value because the increase of "need"
3. do not pause or unpause on case 4

I agree other unpausing conditions are not necessary.


>>> I think the simplest pure "fix" is to change the current "ready = false"
>>> setting from unconditional on every run of periodic reclaim to only when
>>> a sweep actually queues a block group for reclaim. I have compiled but
>>> not yet tested the code I included in this mail :) We can do that more
>>> carefully once we agree how we want to move forward.
>>>
>>> If you still want to re-design things on top of a fix like this one, I
>>> am totally open to that.
>>>
>>> Thanks again for all your work on this, and happy new year,
>>> Boris


>>> @@ -2176,7 +2181,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
>>>
>>>  	spin_lock(&space_info->lock);
>>>  	ret = space_info->periodic_reclaim_ready;
>>> -	btrfs_set_periodic_reclaim_ready(space_info, false);
>>>  	spin_unlock(&space_info->lock);
>>>
>>>  	return ret;
>>> @@ -2190,8 +2194,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
>>>  	list_for_each_entry(space_info, &fs_info->space_info, list) {
>>>  		if (!btrfs_should_periodic_reclaim(space_info))
>>>  			continue;
>>> -		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
>>> -			do_reclaim_sweep(space_info, raid);
>>> +		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
>>> +			if (do_reclaim_sweep(space_info, raid))
>>> +				btrfs_set_periodic_reclaim_ready(space_info, false);
>>> +		}
>>
>> Even if we have blockgroups to reclaim in this turn, we still mark some
>> bg->reclaim_mark and expect the next periodic reclaim, which will not run, might
>> reclaim them.
> 
> Why won't it run? We only pause if we truly called
> btrfs_mark_bg_to_reclaim() (the word mark is unfortunately overloaded
> here... that function really queues the bg for a reclaim attempt)

After userspace stopped writing, we still need 2 periodic reclaims to finish our
work and each of them will reclaim some of the bgs in my experience. But with
this patch, after the first one reclaimed some bgs, the second one will not run.
We might reclaim less and the behavior is a little different. I called this a
regression. But if we focus on "just don't run out of unallocated space", this
patch seems fine.

>>>  	}
>>>  }
>>
>> So I'm afraid this patch will introduce obvious regression on periodic reclaim.
I called it regression here :)
>> Add the "changed threshold" condition can alleviate this when dynamic reclaim is
>> also enabled but will not work for fixed threshold. So I failed to come up with
>> a simple fix patch with no obvious regression :(
>>
> 
> Can you share a description of any workloads you've been testing
> against? I think that would also help frame the discussion to avoid me
> talking too much :D

I test this feature on by BT machine. Download, fill the fs to nearly full and
delete some files and repeat...

> The regression I can foresee here is that the successful passes will
> pause for too long (until the next chunk_sz of freeing)

> We can also relax that condition to something more like an extent size
> (1M or BTRFS_MAX_EXTENT_SIZE perhaps) to make it a little gentler of a pause.
> 
> We can also unpause on "urgent". I think that would likely be
> sufficient. I'll do some actual experiments.. :)

I love these two ideas and looking forward to your experiment results :)

Thanks,
Sun YangKai

> Thanks,
> Boris
> 
>>>> CC: Boris Burkov <boris@bur.io>
>>>> Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
>>>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
>>>> ---
>>>>  fs/btrfs/block-group.c | 15 +++++++-------
>>>>  fs/btrfs/space-info.c  | 44 +++++++++++++++++++-----------------------
>>>>  fs/btrfs/space-info.h  | 28 ++++++++++++++++++---------
>>>>  3 files changed, 46 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>>> index e417aba4c4c7..94a4068cd42a 100644
>>>> --- a/fs/btrfs/block-group.c
>>>> +++ b/fs/btrfs/block-group.c
>>>> @@ -1871,6 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>>>  	while (!list_empty(&fs_info->reclaim_bgs)) {
>>>>  		u64 used;
>>>>  		u64 reserved;
>>>> +		u64 old_total;
>>>>  		int ret = 0;
>>>>  
>>>>  		bg = list_first_entry(&fs_info->reclaim_bgs,
>>>> @@ -1936,6 +1937,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>>>  		}
>>>>  
>>>>  		spin_unlock(&bg->lock);
>>>> +		old_total = space_info->total_bytes;
>>>>  		spin_unlock(&space_info->lock);
>>>>  
>>>>  		/*
>>>> @@ -1988,14 +1990,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>>>  			reserved = 0;
>>>>  			spin_lock(&space_info->lock);
>>>>  			space_info->reclaim_errors++;
>>>> -			if (READ_ONCE(space_info->periodic_reclaim))
>>>> -				space_info->periodic_reclaim_ready = false;
>>>>  			spin_unlock(&space_info->lock);
>>>>  		}
>>>>  		spin_lock(&space_info->lock);
>>>>  		space_info->reclaim_count++;
>>>>  		space_info->reclaim_bytes += used;
>>>>  		space_info->reclaim_bytes += reserved;
>>>> +		if (space_info->total_bytes < old_total)
>>>> +			btrfs_resume_periodic_reclaim(space_info);
>>>
>>> Why is this here? We've just completed a reclaim, which I would expect
>>> to be neutral to the space_info->total_bytes (just moving them around).
>>> So if (any) unrelated freeing happens to happen while we are reclaiming,
>>> we resume? Doesn't seem wrong, but also seems a little specific and
>>> random. I am probably missing some aspect of your new design.
>>>
>>> Put a different way, what is special about frees that happen *while* we
>>> are reclaiming?
>>
>> As explained, I want to use this to detect if the reclaim freed some unallocated
>> space.
>>
> 
> Makes sense now.
> 
>>>>  		spin_unlock(&space_info->lock);
>>>>  
>>>>  next:
>>>> @@ -3730,8 +3732,6 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>>>>  		space_info->bytes_reserved -= num_bytes;
>>>>  		space_info->bytes_used += num_bytes;
>>>>  		space_info->disk_used += num_bytes * factor;
>>>> -		if (READ_ONCE(space_info->periodic_reclaim))
>>>> -			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
>>>>  		spin_unlock(&cache->lock);
>>>>  		spin_unlock(&space_info->lock);
>>>>  	} else {
>>>> @@ -3741,12 +3741,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>>>>  		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
>>>>  		space_info->bytes_used -= num_bytes;
>>>>  		space_info->disk_used -= num_bytes * factor;
>>>> -		if (READ_ONCE(space_info->periodic_reclaim))
>>>> -			btrfs_space_info_update_reclaimable(space_info, num_bytes);
>>>> -		else
>>>> -			reclaim = should_reclaim_block_group(cache, num_bytes);
>>>> +		reclaim = should_reclaim_block_group(cache, num_bytes);
>>>
>>> I think this is a bug with periodic_reclaim == 1
>>>
>>> In that case, if should_reclaim_block_group() returns true (could be a
>>> fixed or dynamic threshold), we will put that block group directly on
>>> the reclaim list, which is a complete contradiction of the point of
>>> periodic_reclaim.
>>
>> I guess you mean just resume periodic reclaim is enough and put it on reclaim
>> list is not necessary. I agree.
>>
> 
> +1
> 
>>>>  
>>>>  		spin_unlock(&cache->lock);
>>>> +		if (reclaim)
>>>> +			btrfs_resume_periodic_reclaim(space_info);
>>>
>>> This also makes me wonder about the idea behind your change. If you want
>>> periodic reclaim to "pause" until a block group meets the condition and
>>> then we "resume", that's not exactly in the spirit of checking at a
>>> periodic cadence, rather than as block groups update.
>>
>> Because IMO we need periodic reclaim to reclaim this blockgroup. So if it's
>> paused, resume here so the next periodic reclaim will handle this blockgroup.
>>
> 
> As argued above, we want to resume when there is space in the "target"
> block groups, not an exciting "source". Otherwise the failed stuck case
> can keep hammering hopelessly.

Make sense.



