Return-Path: <linux-btrfs+bounces-19631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93127CB3E92
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 21:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91E653010E59
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 20:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D832A3F1;
	Wed, 10 Dec 2025 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I0/D1mH+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331F1E7C2E
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396986; cv=none; b=CgP1cc/YthGUYCJLSVEaEwrSKfQiQS6y6k55HO7jpjjXkxRT9Zc6jG+gkmBlzYmzRvIBUW0ixKNBh1VcBKdC24DzFqbc7lH/6w/AopF5XFIKFLDb+LvrVyQJh6WEFetLhCFrqmlEF2QVnTyjOSq1l1Dd30qP5D+6djZGhIJLJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396986; c=relaxed/simple;
	bh=FiSd7/ekUm4Cn831qJDyTDjCcNGb3chkgd6jORsCDQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knmBqKvIo3lOo4mHz8RnGydFfSTULrwbJTpGaKWhP2Y/MvsQkbTPYZAEPV8avPRFe0bVzNDAnr5r82+9kUaIld07uGlYOQlzHDD0XVgHZjkAjBj/MHYU/gcuuRDCYgNLY7rvUlP92kURIZWTpmMA4by2wOqRFQo0GvT5brSFw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I0/D1mH+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so1728085e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765396981; x=1766001781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zXY8mTvfBXLKSX0ZEyPzaXf8YAPr9HLi7gVjpf1fDW0=;
        b=I0/D1mH+czkjBR6cwitI8cDaigxhIREiyE4xy7NHqHiyW5TzaMCE3SHXmS2CLZJvFk
         73CY2nXLKvPmwBGN1wRJQqJO3mKXV0ABdZ6Im1j2HZXCUnE/aQnFR7bYwzdkKWHoSzNc
         WdQiRP4Jji9tOlsTWfkaYIsMyyqDrZzyiwb3Bd7F76148wIANiq4FuD0FnWUoQdBG8Q8
         9anUxqFUjiMasdWyOA6y9qzttlq6hxNTz16rs8jYka6TOrkkjCoNIdIQ2GHg/gxXcygo
         6YjVpXi0YecGoMBk/pzL3Q3S4LHx4lxtX71bg51xg3iNhutMhRhiZ8TWOhMVucOOTJ4Z
         9zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765396981; x=1766001781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXY8mTvfBXLKSX0ZEyPzaXf8YAPr9HLi7gVjpf1fDW0=;
        b=fgse127B87AKeWsfyPWASfkB6puV5ochWrexk38hBBTw6KTNdvaSW7jewxEEDP5rjl
         ma4v8T2iz2PmjtLhQgZUgnGF7GetW8CEhw7jdCivVXFh5WIOLmMaeBPh57gxxa6X7WY2
         5wcwoF7AhhkzOHuYkyGqS62fn4pgwhNVbpXZHD8PG8aLtxOhfPfaD6240WeESH/qL+r5
         9QK3jm3L4g33Wa9xxVFoFUmQZUXcjXsROatj2g48eu5lhwQAamDM7swIL5BKOBwN7zED
         6LONhjSrY+hG0CjZ8rz6yFze2fZAFUzGPlcf+LA/WJIr3UsKbjwC1opUf0AhDvXoO/yP
         gbdw==
X-Gm-Message-State: AOJu0YzVcKjsGUoeidb0oZfPMP/qRQIVs/I6JgfEzncruNCCuO04+oX1
	0847/2laCfhj7BR5P8WYXIxysXU9Ay2HWbJ6WjvRxmZ54bu2JGbKL9g16bxGcrHjkkSvhuawxI9
	R/hXD
X-Gm-Gg: ASbGncvsY7vLU3OqnsZSiBZZ3pwS8iJlqszDVYisNoM5LumfUabFUBraSpg3GRr+zdV
	z39u149BjAMfjbx9DH2u29525Kw7dRNrgpQN0YYMW/xJAZQCETfRMPdPIfip6061mueFUcVnRW3
	0U52eJze6ASSJ/y1U9yDoAwYddrNZBpIEGXeP1/M9xf21V9GenuC0kxpyqfvDz1pO4vKHxF0gbO
	xe4fV/WaOWABSZL1aqkilo7O8aMPnrvu9QeZ14h53FaZtmTu1YW5ReYk4bBm/tn+2ubNuPKXf2h
	zCl0HCBqlXgjdVs2D+lXnFRJomd35xqIc1Kwx1OX/rufMaW2eh1oDCreGeFGQzEzCfyDlbu6iI2
	mXP0awiCLI2iwStMptpi59YFyWWPAOR7RammSy+BoRPRaLRBgMVenBkmvpj1C1NcL72kP4iMZUM
	hIt2MOyadBklI2IVr4SOfZYAOIPEI+De7YBQ1rj3s=
X-Google-Smtp-Source: AGHT+IG8yZD9HhxJpuhZ1nz4PYFj4inhrlOneFfPetU7LnhgyRQKZRK7E9sgTVVNluHq/Md6QbPYMQ==
X-Received: by 2002:a05:600c:1c9a:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-47a8378cd34mr34902435e9.19.1765396981418;
        Wed, 10 Dec 2025 12:03:01 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38c7fsm1845995ad.39.2025.12.10.12.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 12:03:00 -0800 (PST)
Message-ID: <e2d6cff9-09e5-42e3-9e13-87bb132d34e0@suse.com>
Date: Thu, 11 Dec 2025 06:32:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: make sure all ordered extents beyond EOF are
 properly truncated
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
 <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
 <3c610ad4-b091-4fe2-9c18-689d6f9d3af3@suse.com>
 <CAL3q7H4JBhA74Mc_KDp8gFbykAd86h-1inLw_fSr8Z0bHJW9Gg@mail.gmail.com>
 <CAL3q7H4wh6cYeiz_a8CYdg_FArSdSJVzENZMjOQ+gfDsbWRQTQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <CAL3q7H4wh6cYeiz_a8CYdg_FArSdSJVzENZMjOQ+gfDsbWRQTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/10 23:30, Filipe Manana 写道:
[...]
>>> Couldn't something like 18de34daa7c6 ("btrfs: truncate ordered extent
>>> when skipping writeback past i_size") happen? E.g. with more holes:
>>>
>>>       0          16K    32K     36K   48K    52K   60K    64K
>>>       |//////////|      |///////|     |//////|     |//////|
>>>
>>> The range [0, 64k) is inside a large folio or just a single page (64K
>>> page size), and above "//" range is dirtied by buffered write.
>>>
>>> Then we truncate the inode size to 16K, which set the inode size to 16K
>>> first, then call btrfs_truncate() which triggers
>>> btrfs_wait_ordered_range()->btrfs_fdatawrite_range() to do the writeback.
>>>
>>> Then we start writing back the large folio 0 for range [0, 64K),
>>> creating ordered extents for [0, 16K), [32K, 36K), [48K, 52K), [60K, 64K).
>>>
>>> Then call extent_writepage_io() to do the submission, which will only
>>> submit [0, 16K).
>>> And the current code will only mark OE [32K, 36K) as truncated, missing
>>> [48K, 52K) and [60K, 64K).
>>
>> No, it will mark all ordered extents as truncated.
>>
>> In extent_writepage_io() we go through each dirty subrange inside the
>> folio with the for_each_set_bit() loop.
>> For each subrange after 16K, we check the start offset ('cur'
>> variable) is >= i_size, so we look up the ordered extent for that
>> subrange and truncate it.
>>
>> As long as for_each_set_bit() works and finds each dirty subrange we
>> don't need this patch.
>> If we did the ordered extent truncation outside that loop, then we
>> would need something like this patch to ensure we process all ordered
>> extents.
> 
> Actually in the for_each_set_bit() loop we have a break statement
> after the first subrange that starts at or after i_size.
> So we need to replace the break with a continue statement.

That's the point, but also we can not simply replace it with a continue.

As the current one call btrfs_mark_ordered_io_finished() and 
btrfs_folio_clear_dirty() for the whole remaining range.

It's that two functions doing extra work handling such holes that 
doesn't cause obvious problems.
And the correct behavior should be only truncating the current sector 
(not to the end), then continue.


And I'd say the existing btrfs_finish_one_ordered() should also be 
enhanced on checking the checksum and inode's NODATACSUM flag.

We should only accept an OE without data checksum only if it's a fully 
truncated OE (no file extent item insert), error, or NODATASUM inode.
This would help us catching those OEs without any csum.

> 
> This also means the code was broken before, as
> btrfs_mark_ordered_io_finished() and btrfs_folio_clear_dirty() weren't
> being called for all the remaining subranges after i_size.

They are, it's that two functions hiding the hole skipping part.

Thanks,
Qu

> 
> 
>>
>> Thanks.
>>
>>>
>>> Normally the file extent item insertion and later truncation (which
>>> drops all the inserted file extents) are inside the same transaction.
>>>
>>> But if the transaction committed after the file extent items insertion
>>> but before the transaction dropping file extent items, then power loss
>>> happened, we got the same ordered extents beyond EOF and without csum.
>>>
>>> Or did I miss something?
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> So how can we find more than one ordered extent after this?
>>>>
>>>> I think this changelog should explain that, it makes no mention of
>>>> this detail about btrfs_truncate().
>>>>
>>>> Thanks.
>>>>
>>>>
>>>>>
>>>>> But OE B and C are not marked as truncated, they will finish as usual,
>>>>> which will leave a regular file extent item to be inserted beyond EOF,
>>>>> and without any data checksum.
>>>>>
>>>>> [FIX]
>>>>> Introduce a new helper, btrfs_mark_ordered_io_truncated(), to handle all
>>>>> OEs of a range, and mark them all as truncated.
>>>>>
>>>>> With that helper, all OEs (A B and C) will be marked as truncated.
>>>>> OE B and C will have 0 truncated_len, preventing any file extent item to
>>>>> be inserted from them.
>>>>>
>>>>> Reviewed-by: Boris Burkov <boris@bur.io>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> Changelog:
>>>>> v2:
>>>>> - Fix the ASSERT() inside btrfs_mark_ordered_io_truncated()
>>>>>     Since the range passed in is to the end of the folio during writeback
>>>>>     path, there is no guarantee that there is always one or more ordered
>>>>>     extents covering the full range.
>>>>>
>>>>>     This get triggered during fsstress runs, especially common on bs < ps
>>>>>     cases.
>>>>>
>>>>>     Remove the ASSERT() and exit the oe search instead.
>>>>>
>>>>> Resend:
>>>>> - Move the patch out of the series 'btrfs: reduce btrfs_get_extent()
>>>>>     calls for buffered write path'
>>>>>     As this is a bug fix, which needs a little higher priority than
>>>>>     the remaining optimizations.
>>>>>
>>>>> - Fix various grammar errors
>>>>>
>>>>> - Use @end to replace duplicated calculations
>>>>>
>>>>> - Remove the Fixes: tag
>>>>>     The involved patch is not yet merged upstream.
>>>>>     Just mention the patch subject inside the commit message.
>>>>> ---
>>>>>    fs/btrfs/extent_io.c    | 19 +------------------
>>>>>    fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
>>>>>    fs/btrfs/ordered-data.h |  2 ++
>>>>>    3 files changed, 36 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>>> index 2d32dfc34ae3..2044b889c887 100644
>>>>> --- a/fs/btrfs/extent_io.c
>>>>> +++ b/fs/btrfs/extent_io.c
>>>>> @@ -1725,24 +1725,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>>>>>                   cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
>>>>>
>>>>>                   if (cur >= i_size) {
>>>>> -                       struct btrfs_ordered_extent *ordered;
>>>>> -
>>>>> -                       ordered = btrfs_lookup_first_ordered_range(inode, cur,
>>>>> -                                                                  folio_end - cur);
>>>>> -                       /*
>>>>> -                        * We have just run delalloc before getting here, so
>>>>> -                        * there must be an ordered extent.
>>>>> -                        */
>>>>> -                       ASSERT(ordered != NULL);
>>>>> -                       spin_lock(&inode->ordered_tree_lock);
>>>>> -                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>>>>> -                       ordered->truncated_len = min(ordered->truncated_len,
>>>>> -                                                    cur - ordered->file_offset);
>>>>> -                       spin_unlock(&inode->ordered_tree_lock);
>>>>> -                       btrfs_put_ordered_extent(ordered);
>>>>> -
>>>>> -                       btrfs_mark_ordered_io_finished(inode, folio, cur,
>>>>> -                                                      end - cur, true);
>>>>> +                       btrfs_mark_ordered_io_truncated(inode, folio, cur, end - cur);
>>>>>                           /*
>>>>>                            * This range is beyond i_size, thus we don't need to
>>>>>                            * bother writing back.
>>>>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>>>>> index a421f7db9eec..3c0b89164139 100644
>>>>> --- a/fs/btrfs/ordered-data.c
>>>>> +++ b/fs/btrfs/ordered-data.c
>>>>> @@ -546,6 +546,39 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>>>>>           spin_unlock(&inode->ordered_tree_lock);
>>>>>    }
>>>>>
>>>>> +/*
>>>>> + * Mark any ordered extents io inside the specified range as truncated.
>>>>> + */
>>>>> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct folio *folio,
>>>>> +                                    u64 file_offset, u32 len)
>>>>> +{
>>>>> +       const u64 end = file_offset + len;
>>>>> +       u64 cur = file_offset;
>>>>> +
>>>>> +       ASSERT(file_offset >= folio_pos(folio));
>>>>> +       ASSERT(end <= folio_pos(folio) + folio_size(folio));
>>>>> +
>>>>> +       while (cur < end) {
>>>>> +               u32 cur_len = end - cur;
>>>>> +               struct btrfs_ordered_extent *ordered;
>>>>> +
>>>>> +               ordered = btrfs_lookup_first_ordered_range(inode, cur, cur_len);
>>>>> +
>>>>> +               if (!ordered)
>>>>> +                       break;
>>>>> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
>>>>> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>>>>> +                       ordered->truncated_len = min(ordered->truncated_len,
>>>>> +                                                    cur - ordered->file_offset);
>>>>> +               }
>>>>> +               cur_len = min(cur_len, ordered->file_offset + ordered->num_bytes - cur);
>>>>> +               btrfs_put_ordered_extent(ordered);
>>>>> +
>>>>> +               cur += cur_len;
>>>>> +       }
>>>>> +       btrfs_mark_ordered_io_finished(inode, folio, file_offset, len, true);
>>>>> +}
>>>>> +
>>>>>    /*
>>>>>     * Finish IO for one ordered extent across a given range.  The range can only
>>>>>     * contain one ordered extent.
>>>>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>>>>> index 1e6b0b182b29..dd4cdc1a8b78 100644
>>>>> --- a/fs/btrfs/ordered-data.h
>>>>> +++ b/fs/btrfs/ordered-data.h
>>>>> @@ -169,6 +169,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
>>>>>    void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>>>>>                                       struct folio *folio, u64 file_offset,
>>>>>                                       u64 num_bytes, bool uptodate);
>>>>> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct folio *folio,
>>>>> +                                    u64 file_offset, u32 len);
>>>>>    bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>>>>>                                       struct btrfs_ordered_extent **cached,
>>>>>                                       u64 file_offset, u64 io_size);
>>>>> --
>>>>> 2.52.0
>>>>>
>>>>>
>>>


