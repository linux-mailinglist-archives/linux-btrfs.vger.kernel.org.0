Return-Path: <linux-btrfs+bounces-20312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E365D069DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 01:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F56B3035A80
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9218CC13;
	Fri,  9 Jan 2026 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DRSG7I6Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3438DD3
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767918755; cv=none; b=Jkp/ZQS3Hs3LN2xtMjOkHaG61ut3SyzjINJRsUpln7+c38JVdPkYNCIZy45kRTwHoIdEpwIS9wZ69hoIyKIGogAV/bLpY+fSNUe5x4/y4Meb4mF+TCJj8d/cs2ALHfq98TiVEaDrszn/QVzk6sea+36bza4z7S5ndEf2uYMCdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767918755; c=relaxed/simple;
	bh=3U3qkiqe7TsuwSSU+SrH6+FXu2tJSeylekz2ssuMl2w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FZJtXuxUgv9MikGZ+nkGS6dwkmyY6rtj92LfozOWMpUFJuUW3wqz1qhOCFiqZgc4qWZKCj0swtvbZq71MJWLxPsXz9GjtCDpwIrCMjwPnBxBAhnK0by7gNPxqd7twQNcOJurwyp61CtGNW4FqVM9arVDjDsl+eG08mqRPeq7i2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DRSG7I6Q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477632d9326so23014385e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 16:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767918752; x=1768523552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mInf5ymyzf33rKXp1KYnt2PmBtck3W4/AuJZABkZcV8=;
        b=DRSG7I6QgRocYP75XsVR7T22+Vq1QzfFkI6Gnow/J8LrwKybUYN3PUU84AzZoVYGCM
         VmLX0a5/umVM1RaVIay2s8GjhqM8ZhgACOHw1DHch4u9a/9mQldikMjqv5p4RG4/3zpI
         /l2wS3ar3YfkkCRWdgRFZAeykZqH2fDW+hYeAM0ZXq26GuitdG//gkzDVeson82UmTjo
         CHo9EpR+XWhfwBeQdd9o4lASAUanHLOrzXndmFtL/Kg99Tn/oF2ji/XUC98ioSMSutGO
         mh+TQy4ORy+SZVftSqX0i+0ynvhqq0DqSqbZANyeAzEppMZpWDvRceGV/UjJeHjhRSpX
         goFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767918752; x=1768523552;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mInf5ymyzf33rKXp1KYnt2PmBtck3W4/AuJZABkZcV8=;
        b=Wczzw0maJahY6VBdMVURzwDKAyuujrlk3TuprZz1/mBYqiuPXM2/KnVspVBRYsLj66
         Q/kw8imvoxUJbH+MG74Z+e0Y74ySPwshwnlzwI4Ef3cy93K4UWhXwOreIvaSNc5TMF2e
         zW8TLXi63Psbg3fHmRx24ocoh/XoIcD/PEZrTVMJX52w/f9O8WgF7vGIxKKt80jwGm2k
         +/1ho1mWighjVmLeU1+BZVjlMdGliekI9t+XZDaMKQGUttjt8r2bNmsiQY0UWoZxzpKw
         U3uzOHpzA4nYqw5nb7ubeVDNZPZpF7QaGmjR1um+HLuYe8Pxs43Rq4Nh1LGKMA/na+h6
         Y/IA==
X-Gm-Message-State: AOJu0YxQcKQ3e1TvgjUngLg6wlei8A5wrVGDnXFL9Btv1xDetNDnMpU+
	WmHIO/DsJpdqxD9PHG3jufWH18M4lu0PvU8ZfFHsuD5FzsaJvyBA2sA+732aBlQy+2c=
X-Gm-Gg: AY/fxX7bXniNs0epIj05zQL14XTM3SmTtc3b7GjlC8bl0tNEq4rXLTBvDbySUjx3ovc
	jfz0BHALF3sAlbO3kCyiSRhYVGRjqZZu4nJWrFu/dCVjfI/JXbYbDxYJCsMreFNotkRSdELgnWV
	T6IURUpVM3PYPPm/fZxtpBf3w9dNMwkUk4PzvjQ4Lq86PvgxRBqoZJ1pupLh2SZK2e5xC+9B6/I
	R76USdsMZBSQgKmtI4pE89Cwm8BcV9jGbgD4aiZQj3IuwkOqCqLJYf9qJb7KEaXr0CXFfNnBFHk
	32MNJz0Cc0YcQgH9UpBrBnaVSiMOOSX+MDcLBZ3NulTJ0ZPMhu3pAdHWzqYMcG540VH5BarirLV
	cbIRf+rp4Hsa1fVRx/20/+ZKp9X6H6F0ulW5y7mydMr9TUBtH0whNEWws1n3iV3IOCYfMCm7ZMY
	/d4xZjJ+u+nczWKWHICbGoPBPjslTgwbHBWKrSB84=
X-Google-Smtp-Source: AGHT+IFQ8+KJrIWc4AFhw/n0VsJ+JposVksDQRHK4hj43jChSzo7YHXcbuykFdD3t6L9sCcnfji1Gg==
X-Received: by 2002:a05:600c:1e1c:b0:47d:5e02:14e5 with SMTP id 5b1f17b1804b1-47d84b0a8d1mr81436555e9.5.1767918752422;
        Thu, 08 Jan 2026 16:32:32 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb75902sm8823127a91.16.2026.01.08.16.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 16:32:31 -0800 (PST)
Message-ID: <0e7bb2ce-0d32-4d09-b997-e67240c12815@suse.com>
Date: Fri, 9 Jan 2026 11:02:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: invalidate pages instead of truncate after
 reflinking
From: Qu Wenruo <wqu@suse.com>
To: Boris Burkov <boris@bur.io>, fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
 <20260108191733.GA2485498@zen.localdomain>
 <20260108193209.GA2553335@zen.localdomain>
 <7fb9b44f-9680-4c22-a47f-6648cb109ddf@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <7fb9b44f-9680-4c22-a47f-6648cb109ddf@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/9 10:48, Qu Wenruo 写道:
> 
> 
> 在 2026/1/9 06:02, Boris Burkov 写道:
>> On Thu, Jan 08, 2026 at 11:17:33AM -0800, Boris Burkov wrote:
>>> On Thu, Jan 08, 2026 at 05:10:04PM +0000, fdmanana@kernel.org wrote:
>>>> From: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> Qu reported that generic/164 often fails because the read operations 
>>>> get
>>>> zeroes when it expects to either get all bytes with a value of 0x61 or
>>>> 0x62. The issue stems from truncating the pages from the page cache
>>>> instead of invalidating, as truncating can zero page contents.
>>>
>>> Can you make it more clear if this is a subpage/large folios issue or a
>>> generic issue?
> 
> It's a generic one, and it's large folios involved.
> 
> We can have the following case:
> 
> 
>      0          4K         8K         12K          16K
>          |          |          |          |            |
>          |<---- Extent A ----->|<----- Extent B ------>|
> 
> The page size is still 4K, but the folio we got is 16K.
> 
> Then if we remap the range for [8K, 16K), then 
> truncate_inode_pages_range() will got the large folio 0 sized 16K, then 
> call truncate_inode_partial_folio().
> 
> Which later calls folio_zero_range() for the [8K, 16K) range first, then 
> try to split the folio into smaller ones to properly drop them from the 
> cache.
> 
> But if split failed (e.g. racing with other operations holding the 
> filemap lock), the partially zeroed large folio will be kept, resulting 
> the range [8K, 16K) being zeroed meanwhile the folio is still a 16K 
> sized large one.

With that said, the best solution would be introducing some fs aware 
range dropping, so that even if the folio split failed, we don't just 
get some range zeroed by folio_zero_range() only, but also got the 
uptodate bitmap cleared for that range.

So that when the next time we need to read the full 16K folio, we will 
only need to read the last dropped [8K, 16K) range, without the need to 
re-read the range [0, 8K).

But that will be something way more complex, and the current fix is 
pretty safe (will drop every folio covering the range).

Thanks,
Qu

> 
> 
>> Or maybe just explain the "can zero page contents" in a
>>> little more detail? I agree that it is the wrong "contract" so your
>>> change makes sense either way, this is just for future
>>> knowledge/archaeology.
>>
>> I answered part of my own question. It reproduced in 10 tries on my x86
>> system :)
>>
>>>
>>> The documentation of truncate_inode_pages_range only mentions zeroing
>>> partial pages when "lstart or lend + 1 is not page aligned" but our call
>>> is
>>>
>>>     truncate_inode_pages_range(&inode->i_data,
>>>                 round_down(destoff, PAGE_SIZE),
>>>                 round_up(destoff + len, PAGE_SIZE) - 1);
>>>
>>> which appears to align it?
> 
> I think it's also a good time to ask for a comment update on that 
> function. Mentioning the above failed-to-split case will be helpful for 
> any future users.
> 
> Thanks,
> Qu
> 
>>>
>>> Sorry if I am missing something obvious :)
>>>
>>>>
>>>> So instead of truncating, invalidate the page cache range with a 
>>>> call to
>>>> filemap_invalidate_inode(), which besides not doing any zeroing also
>>>> ensures that while it's invalidating folios, no new folios are added.
>>>> This helps ensure that buffered reads that happen while a reflink
>>>> operation is in progress always get either the whole old data (the one
>>>> before the reflink) or the whole new data, which is what generic/164
>>>> expects.
>>>>
>>>> Reported-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Reviewed-by: Boris Burkov <boris@bur.io>
>>>
>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>>> ---
>>>>   fs/btrfs/reflink.c | 21 ++++++++++++---------
>>>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
>>>> index e746980567da..f7ddd3765249 100644
>>>> --- a/fs/btrfs/reflink.c
>>>> +++ b/fs/btrfs/reflink.c
>>>> @@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct 
>>>> file *file, struct file *file_src,
>>>>       struct inode *src = file_inode(file_src);
>>>>       struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>>>>       int ret;
>>>> -    int wb_ret;
>>>>       u64 len = olen;
>>>>       u64 bs = fs_info->sectorsize;
>>>>       u64 end;
>>>> @@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct 
>>>> file *file, struct file *file_src,
>>>>       btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, 
>>>> &cached_state);
>>>>       ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
>>>>       btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, 
>>>> &cached_state);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>>       /*
>>>>        * We may have copied an inline extent into a page of the 
>>>> destination
>>>>        * range, so wait for writeback to complete before truncating 
>>>> pages
>>>
>>> s/truncating/invalidating/
>>>
>>>>        * from the page cache. This is a rare case.
>>>>        */
>>>> -    wb_ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
>>>> -    ret = ret ? ret : wb_ret;
>>>> +    ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>
>>> Even if it's true, not worth doing in a fix like this, but a question:
>>> I think buffered reads will check for outstanding ordered_extents and
>>> wait for them. If we are invalidating the cache next, then how can we
>>> read the file without seeing this ordered_extent? Is this
>>> wait_ordered_range still necessary?
>>>
>>> Again, not a blocker for this patch.
>>>
>>>>       /*
>>>> -     * Truncate page cache pages so that future reads will see the 
>>>> cloned
>>>> -     * data immediately and not the previous data.
>>>> +     * Invalidate page cache so that future reads will see the 
>>>> cloned data
>>>> +     * immediately and not the previous data.
>>>>        */
>>>> -    truncate_inode_pages_range(&inode->i_data,
>>>> -                round_down(destoff, PAGE_SIZE),
>>>> -                round_up(destoff + len, PAGE_SIZE) - 1);
>>>> +    ret = filemap_invalidate_inode(inode, false, destoff, end);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>>       btrfs_btree_balance_dirty(fs_info);
>>>> -    return ret;
>>>> +    return 0;
>>>>   }
>>>>   static int btrfs_remap_file_range_prep(struct file *file_in, 
>>>> loff_t pos_in,
>>>> -- 
>>>> 2.47.2
>>>>
>>
> 
> 


