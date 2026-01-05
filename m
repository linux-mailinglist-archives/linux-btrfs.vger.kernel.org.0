Return-Path: <linux-btrfs+bounces-20100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED81CF3AA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BD50300FA05
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B591917F0;
	Mon,  5 Jan 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ9NijaV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049A1946BC
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618026; cv=none; b=AT/HSD5nYO1ni2LOu1ChPNX1uRzkawmxzCjM6b7qLiiOQQ6JwIDIcJMy5xCKnPZB+6T/CejlcolgMXxPNry6sxOMoxZeUC+VniSTDjat/gc2esz9Rm6Y7Q0igH5WFizRqZ+0I1RqRpck0m8HtHw7FAcVlSxDYLngBF9iMylXBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618026; c=relaxed/simple;
	bh=INVpxXAh/EX4x9PfzJCXcSAFXhZIPbWNsllFo38kKWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYh0dLWBP3oyG40YlTJVDG9dmEinLNY8PHTkhAfopu8hAt6nVUAyjbXCH+7i6LbdTbFJ9NoG3nWSVYsf+yG1AcBsJFixXjsivadEBrzijvoEwBiVO/WNSu3nMttsdAM2oBDa5qswKijS451RMvLaAOoTuJcq4cg0QX5ybjZ8ed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ9NijaV; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7baa5787440so625968b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 05:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767618023; x=1768222823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R38cpoBvt5iSnq3fvyhCrC+HqBowVgu8SN/Q0rpR83s=;
        b=iJ9NijaVmiOXMQ4J1baiO+I4NKuoB2sGbF8XSQFbJ7WJRFiCC5awhc4bOn88KVdRXL
         4/oREiW28+axaynApYzJCX9brQN86463BYihOgtn6v3zRhmqQgtsE2jG464tf1sglAnM
         sWZyX+HlXWA27mTDOIxX9ZKnfWRB5W6xT3O6idGl2UeVrTL/OkibPTr4Lc0ajy4PRnAu
         TVKoIzBmamFZshboRPFRWPUFyvtPvewgapWj98aqucoKhuTkwmAIwVglwm2VMnt9UJan
         8zDBfY9MrzZ+au3pjr9ggqbf4T+oTBmh5v2UKNLqbWFizSd+z3eQ9yB5QQZg90pN3rjH
         kn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767618023; x=1768222823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R38cpoBvt5iSnq3fvyhCrC+HqBowVgu8SN/Q0rpR83s=;
        b=JNLx6qBptcFr03Wp2aMPbAXc/qL0uZqlFiV4mHbu/ut4wMKE7xERYhezKQd+QnkL2l
         dGKZIU+C6/Z72Np4Prvkkf2PbUmTwaDaUyilYdNVV4uSXRpXM4QvqyQKjP9ubnm+99Sg
         TqV02hzT7la/Q95BVUCZ9gBjtVG46211FbXrVdoSrgjm3IzdrCq3sBS+SgdupU+UYvsa
         bm3B19OT8eIVmKos5/HauYO86fkbTatFKA75FIc2QU5XvBowk05isbjlDPbfcvsI11Sx
         HWLmBTK6lA7/G/3ZMRLQK8/mw9YKyxcMyFgY5GXzIbIt+7xaduHyN9YaDnCXDEXpfz8w
         yYyw==
X-Gm-Message-State: AOJu0YyVALKXUS50hWEVgh1zGhKRk/8EQGWzB0Kuf5x/5Kupgp6oHvtR
	qfVhY2Al50x00qNwJSw8kCJlvx5sTlYBYH3Chon4V3ShUE2F4hmtZLou
X-Gm-Gg: AY/fxX6jDKH7SeFD1EpqsAM0xqGzdJs1wc+70IGfU4UiIOgM9CFowzEKeCZzSgE0z3u
	13bbMNPyUbNeNOz6U49kd9k8CRyFHHDZkfEFFkb2SHdjwf9QSB7MRw4IZTgjsXCKb2SXmnXbwFq
	kDAMInL6FqsTph0/aAhcNUgQFf64YHq8fMzWTuclaWlr7Y4/RCiqnspblH0OusUAKeCi3t/re9D
	6V2lUOLBuz3uQ2mUfDjOk5htP/6u9Y0ZFRZY2U2I+sD0hLwWQ9eXQHXb3BzhAWWQalD67uIFme1
	S66FDwdqR1XedI4HQuxo/SLhIhTTTND5ZmKiaoDUKM9DP+xkLHO8D7Rl5ypWpZ9NgiirejpG6Wd
	3qd4XrcXobSmPbZJN3L8Ae4L5pKvDvPV/UOyF5LG0nLGEvDZkwhpnyW3oL3QI0jq2jrnHvh9zfh
	R/eZHZTOt0puc8a0rSXACzsV7X
X-Google-Smtp-Source: AGHT+IFsLXcoqefZh7yGZKmlkAoSuyKGI4RHo7RowWFAvB/3fyTtZ38755IJDiOHwbTDajtm/ZoyhQ==
X-Received: by 2002:a05:6a00:889:b0:7fb:e19e:2dbb with SMTP id d2e1a72fcca58-7ff66b6d01fmr30720745b3a.5.1767618021875;
        Mon, 05 Jan 2026 05:00:21 -0800 (PST)
Received: from [192.168.1.13] ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a1a2asm47716250b3a.41.2026.01.05.05.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 05:00:21 -0800 (PST)
Message-ID: <7797d6e2-99b6-4112-9c7c-4cb09dde8486@gmail.com>
Date: Mon, 5 Jan 2026 21:00:15 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] btrfs: fix periodic reclaim condition
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20260103122504.10924-2-sunk67188@gmail.com>
 <20260103122504.10924-3-sunk67188@gmail.com>
 <20260104194008.GA416121@zen.localdomain>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20260104194008.GA416121@zen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/5 03:40, Boris Burkov 写道:
> On Sat, Jan 03, 2026 at 08:19:48PM +0800, Sun YangKai wrote:
> 
> First off, thank you very much for your attention to this and for
> your in depth fixes.

Glad to hear from you and Happy New Year! :)

>> Problems with current implementation:
>> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>>    negative reclaimable_bytes to trigger reclaim unexpectedly
> 
> Agreed, completely. IMO, the message here could use a bit more clarity
> that negative reclaimable_bytes is an intentionally designed condition
> so this is a fundamental bug, not a weird edge case.
> 
>> 2. The "space must be freed between scans" assumption breaks the
>>    two-scan requirement: first scan marks block groups, second scan
>>    reclaims them. Without the second scan, no reclamation occurs.
> 
> I think I understand what you are saying, but let me try to restate it
> myself and confirm:
> 
> Previously, due to bug 1, we were calling
> btrfs_set_periodic_reclaim_ready() too frequently (after an allocation
> that made the reclaimable_bytes negative). With bug 1 fixed, you really
> have to free a chunk_sz to call btrfs_set_periodic_reclaim_ready(). As a
> result, periodic_reclaim became way too conservative. Now the
> multi-sweep marking thing AND reclaim_ready mean we basically never
> reclaim, as the second sweep doesn't get triggered later.
> 
> Is that about right? I agree that this needs some re-thinking / fixing,
> if so.

Yes that is the case. Your statement is way much better than mine. A sweep
always reclaim blockgroups marked by the previous sweep and mark blockgroups for
the next sweep. That explains why the assumption is not proper and we need a new
assumption to work on.

>> Instead, track actual reclaim progress: pause reclaim when block groups
>> will be reclaimed, and resume only when progress is made. This ensures
>> reclaim continues until no further progress can be made, then resumes when
>> space_info changes or new reclaimable groups appear.
> 
> I think you are making a much bigger change than merely fixing the bugs
> in the original design, so it requires deeper explanation of the new
> invariants you are introducing. Clearly, I am one to talk about it, as I
> messed up with my attempt, but I still think it is very valuable for
> future readers. Thanks for bearing with me :)

Thank you for bring us such a cool feature so I can try it out, learn details of
the implementation and bring some my opinions. I'm quite happy with these
experience. I started with a simple fix but the change was getting bigger and
bigger to reduce regressions and finally it's more like a redesign rather than a
fix.

Sorry for the previous short but unclear statement and let me try to make it
clear in the new year :)

Let's start with the new assumptions:
1. Reclaim is for getting more unallocated blockgroups/spaces.
2. Periodic reclaim should happen periodically :)

I think both users and developers will agree with this but I want to explain
more about 2. Currently, the bg->reclaim_mark related logic and dynamic periodic
reclaim logic both depend on 2. Your previous statement explains the former one
very well and I'll focus on the latter one here.

When we have less than 10GiB unallocated space, dynamic periodic reclaim will
kick in. With the filesystem getting fuller, the bg_reclaim_threshold is getting
larger to make periodic reclaim more aggressive to reclaim some unallocated
space. However, if we paused periodic reclaim when the threshold is small, like
19, then we'll never resume it even if we want to reclaim more aggressively with
a larger threshold later. And dynamic periodic reclaim will not work as
expected. This may happen when we first try reclaiming with threshold 19, while
having some quite large extents in 10% used blockgroups and having no enough
continuous free space in other 70+% full blockgroups. We'll fail to get more
unallocated space, pause periodic reclaim, and not try reclaiming when the
threshold gets larger than 79 later. This is why I resume periodic reclaim when
threshold changes.

So the core issue of this part logic about periodic reclaim is when to pause and
when to continue.

If we cannot free more unallocated blockgroups in periodic reclaim, we should
pause it because we don't want to just move things from a blockgroup to a newly
allocated blockgroup and then remove the old one periodically.

And we should continue periodic reclaim when we may be able to free more
blockgroups.

For pausing, it's hard to tell if we're freeing more unallocated directly
without changing current code. But in btrfs_reclaim_bgs_work() we have

btrfs_relocate_chunk()
  ->btrfs_remove_chunk()
    ->btrfs_remove_block_group()

So the old blockgroup is removed and we can see that in space_info->total_bytes.

Let's start with all the blockgroups having the same size and reclaiming a
single blockgroup. If we succeeded moving extents into existing blockgroups,
we'll not allocate a new one and space_info->total_bytes is getting smaller
because we've freed the old one. If we failed moving things into existing bgs
and allocated a new one, then space_info->total_bytes will not change.

When reclaiming n blockgroups, as long as we're using less space, such as n-1
new blockgroups are allocated or n new smaller blockgroups, we're making some
progress and able to detect that from space_info->total_bytes.

Reclaim may racing with some other work that free/allocate blockgroups, which
will lead to either an unnecessary extra periodic reclaim or an unexpected
pause. An extra periodic reclaim is not a big thing. But the unexpected pause
matters. This is the only regression currently and I think that will not happen
frequently.

For continuing, rather than tracing used_bytes, I think we should care more
about unused_bytes. This is inspired by calc_dynamic_reclaim_threshold(), which
will return 0 if there's no enough unused space. And also care about
reclaim_threshold to make dynamic periodic reclaim work.


> I think the simplest pure "fix" is to change the current "ready = false"
> setting from unconditional on every run of periodic reclaim to only when
> a sweep actually queues a block group for reclaim. I have compiled but
> not yet tested the code I included in this mail :) We can do that more
> carefully once we agree how we want to move forward.
> 
> If you still want to re-design things on top of a fix like this one, I
> am totally open to that.
> 
> Thanks again for all your work on this, and happy new year,
> Boris
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6babbe333741..aad402485763 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -2095,12 +2095,13 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
>  	return unalloc < data_chunk_size;
>  }
> 
> -static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> +static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  {
>  	struct btrfs_block_group *bg;
>  	int thresh_pct;
>  	bool try_again = true;
>  	bool urgent;
> +	bool ret = false;
> 
>  	spin_lock(&space_info->lock);
>  	urgent = is_reclaim_urgent(space_info);
> @@ -2122,8 +2123,10 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  		}
>  		bg->reclaim_mark++;
>  		spin_unlock(&bg->lock);
> -		if (reclaim)
> +		if (reclaim) {
>  			btrfs_mark_bg_to_reclaim(bg);
> +			ret = true;
> +		}
>  		btrfs_put_block_group(bg);
>  	}
> 
> @@ -2140,6 +2143,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  	}
> 
>  	up_read(&space_info->groups_sem);
> +	return ret;
>  }

It's a good idea to return bool here! I hadn't thought of it.

>  void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> @@ -2149,7 +2153,8 @@ void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s6
>  	lockdep_assert_held(&space_info->lock);
>  	space_info->reclaimable_bytes += bytes;
> 
> -	if (space_info->reclaimable_bytes >= chunk_sz)
> +	if (space_info->reclaimable_bytes > 0 &&
> +	    space_info->reclaimable_bytes >= chunk_sz)
>  		btrfs_set_periodic_reclaim_ready(space_info, true);
>  }
> 
> @@ -2176,7 +2181,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
> 
>  	spin_lock(&space_info->lock);
>  	ret = space_info->periodic_reclaim_ready;
> -	btrfs_set_periodic_reclaim_ready(space_info, false);
>  	spin_unlock(&space_info->lock);
> 
>  	return ret;
> @@ -2190,8 +2194,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
>  	list_for_each_entry(space_info, &fs_info->space_info, list) {
>  		if (!btrfs_should_periodic_reclaim(space_info))
>  			continue;
> -		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
> -			do_reclaim_sweep(space_info, raid);
> +		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
> +			if (do_reclaim_sweep(space_info, raid))
> +				btrfs_set_periodic_reclaim_ready(space_info, false);
> +		}

Even if we have blockgroups to reclaim in this turn, we still mark some
bg->reclaim_mark and expect the next periodic reclaim, which will not run, might
reclaim them.

>  	}
>  }

So I'm afraid this patch will introduce obvious regression on periodic reclaim.
Add the "changed threshold" condition can alleviate this when dynamic reclaim is
also enabled but will not work for fixed threshold. So I failed to come up with
a simple fix patch with no obvious regression :(

>> CC: Boris Burkov <boris@bur.io>
>> Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
>> ---
>>  fs/btrfs/block-group.c | 15 +++++++-------
>>  fs/btrfs/space-info.c  | 44 +++++++++++++++++++-----------------------
>>  fs/btrfs/space-info.h  | 28 ++++++++++++++++++---------
>>  3 files changed, 46 insertions(+), 41 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index e417aba4c4c7..94a4068cd42a 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1871,6 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>  	while (!list_empty(&fs_info->reclaim_bgs)) {
>>  		u64 used;
>>  		u64 reserved;
>> +		u64 old_total;
>>  		int ret = 0;
>>  
>>  		bg = list_first_entry(&fs_info->reclaim_bgs,
>> @@ -1936,6 +1937,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>  		}
>>  
>>  		spin_unlock(&bg->lock);
>> +		old_total = space_info->total_bytes;
>>  		spin_unlock(&space_info->lock);
>>  
>>  		/*
>> @@ -1988,14 +1990,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>  			reserved = 0;
>>  			spin_lock(&space_info->lock);
>>  			space_info->reclaim_errors++;
>> -			if (READ_ONCE(space_info->periodic_reclaim))
>> -				space_info->periodic_reclaim_ready = false;
>>  			spin_unlock(&space_info->lock);
>>  		}
>>  		spin_lock(&space_info->lock);
>>  		space_info->reclaim_count++;
>>  		space_info->reclaim_bytes += used;
>>  		space_info->reclaim_bytes += reserved;
>> +		if (space_info->total_bytes < old_total)
>> +			btrfs_resume_periodic_reclaim(space_info);
> 
> Why is this here? We've just completed a reclaim, which I would expect
> to be neutral to the space_info->total_bytes (just moving them around).
> So if (any) unrelated freeing happens to happen while we are reclaiming,
> we resume? Doesn't seem wrong, but also seems a little specific and
> random. I am probably missing some aspect of your new design.
> 
> Put a different way, what is special about frees that happen *while* we
> are reclaiming?

As explained, I want to use this to detect if the reclaim freed some unallocated
space.

>>  		spin_unlock(&space_info->lock);
>>  
>>  next:
>> @@ -3730,8 +3732,6 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>>  		space_info->bytes_reserved -= num_bytes;
>>  		space_info->bytes_used += num_bytes;
>>  		space_info->disk_used += num_bytes * factor;
>> -		if (READ_ONCE(space_info->periodic_reclaim))
>> -			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
>>  		spin_unlock(&cache->lock);
>>  		spin_unlock(&space_info->lock);
>>  	} else {
>> @@ -3741,12 +3741,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>>  		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
>>  		space_info->bytes_used -= num_bytes;
>>  		space_info->disk_used -= num_bytes * factor;
>> -		if (READ_ONCE(space_info->periodic_reclaim))
>> -			btrfs_space_info_update_reclaimable(space_info, num_bytes);
>> -		else
>> -			reclaim = should_reclaim_block_group(cache, num_bytes);
>> +		reclaim = should_reclaim_block_group(cache, num_bytes);
> 
> I think this is a bug with periodic_reclaim == 1
> 
> In that case, if should_reclaim_block_group() returns true (could be a
> fixed or dynamic threshold), we will put that block group directly on
> the reclaim list, which is a complete contradiction of the point of
> periodic_reclaim.

I guess you mean just resume periodic reclaim is enough and put it on reclaim
list is not necessary. I agree.

>>  
>>  		spin_unlock(&cache->lock);
>> +		if (reclaim)
>> +			btrfs_resume_periodic_reclaim(space_info);
> 
> This also makes me wonder about the idea behind your change. If you want
> periodic reclaim to "pause" until a block group meets the condition and
> then we "resume", that's not exactly in the spirit of checking at a
> periodic cadence, rather than as block groups update.

Because IMO we need periodic reclaim to reclaim this blockgroup. So if it's
paused, resume here so the next periodic reclaim will handle this blockgroup.

>>  		spin_unlock(&space_info->lock);
>>  
>>  		btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 7b7b7255f7d8..de8bde1081be 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -2119,48 +2119,44 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>  	 * really need a block group, do take a fresh one.
>>  	 */
>>  	if (try_again && urgent) {
>> -		try_again = false;
>> +		urgent = false;
>>  		goto again;
>>  	}
>>  
>>  	up_read(&space_info->groups_sem);
>> -}
>> -
>> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
>> -{
>> -	u64 chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
>> -
>> -	lockdep_assert_held(&space_info->lock);
>> -	space_info->reclaimable_bytes += bytes;
>>  
>> -	if (space_info->reclaimable_bytes >= chunk_sz)
>> -		btrfs_set_periodic_reclaim_ready(space_info, true);
>> -}
>> -
>> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
>> -{
>> -	lockdep_assert_held(&space_info->lock);
>> -	if (!READ_ONCE(space_info->periodic_reclaim))
>> -		return;
>> -	if (ready != space_info->periodic_reclaim_ready) {
>> -		space_info->periodic_reclaim_ready = ready;
>> -		if (!ready)
>> -			space_info->reclaimable_bytes = 0;
>> +	/*
>> +	 * Temporary pause periodic reclaim until reclaim make some progress.
>> +	 * This can prevent periodic reclaim keep happening but make no progress.
>> +	 */
>> +	if (!try_again) {
>> +		spin_lock(&space_info->lock);
>> +		btrfs_pause_periodic_reclaim(space_info);
>> +		spin_unlock(&space_info->lock);
>>  	}
>>  }
>>  
>>  static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
>>  {
>>  	bool ret;
>> +	u64 chunk_sz;
>> +	u64 unused;
>>  
>>  	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
>>  		return false;
>>  	if (!READ_ONCE(space_info->periodic_reclaim))
>>  		return false;
>> +	if (!READ_ONCE(space_info->periodic_reclaim_paused))
>> +		return true;
> 
> This condition doesn't feel like a "pause". If the "pause" is set to
> false, then we proceed no matter what, otherwise we check conditions? It
> should be something like:

> if (READ_ONCE(space_info->periodic_reclaim_force))
>         return true;
> 
> as it is acting like a "force" not a "not paused".
> 
> Hope that makes sense, it's obviously a bit tied up in language semantics..

Because assumption 2. if it's not paused, periodic reclaim should happen
periodically. I use "pause" here because I expect periodic reclaim happen
periodically, and setting "pause" to true express that the periodic reclaim
should not keep ticking.

>> +
>> +	chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
>>  
>>  	spin_lock(&space_info->lock);
>> -	ret = space_info->periodic_reclaim_ready;
>> -	btrfs_set_periodic_reclaim_ready(space_info, false);
>> +	unused = space_info->total_bytes - space_info->bytes_used;
> 
> Probably makes sense to use a zoned aware wrapper for this, just in
> case we make this friendly with zones eventually.
> 
>> +	ret = (unused >= space_info->last_reclaim_unused + chunk_sz ||
>> +	       btrfs_calc_reclaim_threshold(space_info) != space_info->last_reclaim_threshold);
> 
> This second condition is quite interesting to me, I hadn't thought of
> it. I think it makes some sense to care again if the threshold changed,
> but it is a new behavior, rather than a fix, per-se.
> 
> What made you want to add this?

To make dynamic periodic reclaim work but it will also help for fixed threshold
when it's changed :)

>> +	if (ret)
>> +		btrfs_resume_periodic_reclaim(space_info);
>>  	spin_unlock(&space_info->lock);
>>  
>>  	return ret;
>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>> index 0703f24b23f7..a49a4c7b0a68 100644
>> --- a/fs/btrfs/space-info.h
>> +++ b/fs/btrfs/space-info.h
>> @@ -214,14 +214,11 @@ struct btrfs_space_info {
>>  
>>  	/*
>>  	 * Periodic reclaim should be a no-op if a space_info hasn't
>> -	 * freed any space since the last time we tried.
>> +	 * freed any space since the last time we made no progress.
>>  	 */
>> -	bool periodic_reclaim_ready;
>> -
>> -	/*
>> -	 * Net bytes freed or allocated since the last reclaim pass.
>> -	 */
>> -	s64 reclaimable_bytes;
>> +	bool periodic_reclaim_paused;
>> +	int last_reclaim_threshold;
>> +	u64 last_reclaim_unused;
>>  };
>>  
>>  static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
>> @@ -301,9 +298,22 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
>>  void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
>>  u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
>>  
>> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
>> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
>>  int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
>> +static inline void btrfs_resume_periodic_reclaim(struct btrfs_space_info *space_info)
>> +{
>> +	lockdep_assert_held(&space_info->lock);
>> +	if (space_info->periodic_reclaim_paused)
>> +		space_info->periodic_reclaim_paused = false;
>> +}
>> +static inline void btrfs_pause_periodic_reclaim(struct btrfs_space_info *space_info)
>> +{
>> +	lockdep_assert_held(&space_info->lock);
>> +	if (!space_info->periodic_reclaim_paused) {
>> +		space_info->periodic_reclaim_paused = true;
>> +		space_info->last_reclaim_threshold = btrfs_calc_reclaim_threshold(space_info);
>> +		space_info->last_reclaim_unused = space_info->total_bytes - space_info->bytes_used;
>> +	}
>> +}
>>  void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
>>  void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
>>  
>> -- 
>> 2.51.2
>>

Thanks,
Sun Yangkai


