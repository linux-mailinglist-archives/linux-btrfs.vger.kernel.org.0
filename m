Return-Path: <linux-btrfs+bounces-10883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC25A08392
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 00:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006F4160546
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A652063C7;
	Thu,  9 Jan 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DYHsdeYB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99482036E2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465702; cv=none; b=eRpygLODoLLzpPIs9Bdz2S0tVbZhY72VCaDlZc4EzNy+jAHMVdd9HrNESsBeO/AKAj6DoIi9zWt4NOrHGS7Iou2gUjeJvZi4IWgh3BickhkzdbWEfCnxkyQfvcN6mNnLP5kYAYotuohfZoO/6gr81GZe/smsLqgnAabE9PDp9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465702; c=relaxed/simple;
	bh=lvtif13hbec47Div966tqt1/lhtMiD1qT4rRFq0NLas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtrI3ZNbdMhcSgHwuTpujkWa4CVQHKRmrGrJoWG3cLBT7TzHfOcajC1A8Lo3oe7WIf65SZgDGezX16/Ahp3xji5Q+DHeg9K5+Ywy9VTALtuLOmXioyhkc1KXkrlyMIfG7MUEuNnUhMMKniaGheCtI4CQq5a4qVjLVfQsD/ZrGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DYHsdeYB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso1472031f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2025 15:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736465698; x=1737070498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YlAX1SzH/idhP84a68rtXUPPblurAdgExFsH//qaftA=;
        b=DYHsdeYBXnyAjPSbJCcEMjRnMxFBS2lK0efeUmAz9ALZ6swz7kTA2Q0XUebTXQ88Zi
         iaPzDswx+JjBs/H9Sz9AVrw1jQJ3bUAPfmc62Y1SxtHZMEtH2l06j0e7l29PAAyBu1h/
         /fJo3pLQfIRFdHuHJkiH+8ejFxaRg4ZJ4+0xB2l6Rbsi6Nmi6OE0K1wVmjK7LiwMdOrv
         rxVSSpIqvl0vzpUSrU/3705HKqDeQalNyQ6Yr32UG6yhpfFqRBmMttflSpyUUpCbgvd9
         CyFvTpYRER+C9M8kEcVOzfeBxkKI+wWogjEIJ/xmg7iIsJjj23Z9cmq0rkK0b5IKpRXO
         h9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736465698; x=1737070498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlAX1SzH/idhP84a68rtXUPPblurAdgExFsH//qaftA=;
        b=R2+C9zDqfctgoTF3zKNvD/n94XObpCQcsiCmAulm3OKur6vHgBVWgsTOzReWU1xfhj
         WTQxmmnE8LX3OYKMooPrmCS5uNsyUnNR87uHATWunNp/ZCExO/DArbOF1EF5l145wqLr
         dZbD1P+ffZ1N8G31qWySzq95auFzC9ewPdOou2+EHhbvf1ffgGND+IQFGMrMAQ2AJDPg
         ARTgj2vnKLfT36FusW7ZfH9NrEp25i6AvF+YAg9RZQpjgiSKar6TW5Q/V3XWfScfX9zb
         fZAwYgwv0uzBiIW9gSp6J44pXhBqNBG4DqF6NnvtEIo4HoouMfrOlsBZ3K5iW3MmqT6f
         K19A==
X-Gm-Message-State: AOJu0YxWSoJJ2bsHMYL/vLp+1xyeEyAgjGMbE8adGYrYxrsCGAVI6pLR
	OVdmehkDOw5hrvEInqVH+A4aUyNUkQO8VWBHO1WCWecXkTwCft3BgBdJ3cpIOVI=
X-Gm-Gg: ASbGncvHkYSPVgdmIyWs0Qpoc8tGM/H8FN9uj2co2GN3mRpz/TN5ktT9sAzMyyCEkWK
	9F34RBFdLfMDEy6dBYVHfBwCcTnnfGVB2bdiJGgbNOdhmRh4LTykteVOn2HGvROpRK1IITCT5N1
	CyIM5IA5AglbXQOAEWMChGRB5ROgRr0ok6c88esxmHT3G1gGOEwZU38cuXEKZVSy8V7hWEraV2E
	djdihC3/Chk+Xg9zAZyfW6DkLxztDqIzKJlANEFqJkUnheTYBRsDkIi2UrTUGJoX6gni9EUdGEM
	EBrc3Xys
X-Google-Smtp-Source: AGHT+IHQINswNhh9vht2Q/7Ndoqp1YkshLwWq8fnzWotJx421ik2SZqkd8BD+2E5Oousgj5HJBCMxA==
X-Received: by 2002:a05:6000:4802:b0:385:e877:c037 with SMTP id ffacd0b85a97d-38a87338d79mr7322209f8f.42.1736465697528;
        Thu, 09 Jan 2025 15:34:57 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df62sm3307265ad.21.2025.01.09.15.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 15:34:56 -0800 (PST)
Message-ID: <599f175d-b11e-4d6e-beb1-326162448560@suse.com>
Date: Fri, 10 Jan 2025 10:04:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] btrfs: do proper folio cleanup when
 cow_file_range() failed
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <cover.1733983488.git.wqu@suse.com>
 <9f8aec2df9dfc39155d3b6f4448528675b97a955.1733983488.git.wqu@suse.com>
 <20250109232040.GA2153241@zen.localdomain>
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
In-Reply-To: <20250109232040.GA2153241@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/10 09:50, Boris Burkov 写道:
> On Thu, Dec 12, 2024 at 04:43:58PM +1030, Qu Wenruo wrote:
>> [BUG]
>> When testing with COW fixup marked as BUG_ON() (this is involved with the
>> new pin_user_pages*() change, which should not result new out-of-band
>> dirty pages), I hit a crash triggered by the BUG_ON() from hitting COW
>> fixup path.
>>
>> This BUG_ON() happens just after a failed btrfs_run_delalloc_range():
>>
>>   BTRFS error (device dm-2): failed to run delalloc range, root 348 ino 405 folio 65536 submit_bitmap 6-15 start 90112 len 106496: -28
>>   ------------[ cut here ]------------
>>   kernel BUG at fs/btrfs/extent_io.c:1444!
>>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>   CPU: 0 UID: 0 PID: 434621 Comm: kworker/u24:8 Tainted: G           OE      6.12.0-rc7-custom+ #86
>>   Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>>   Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
>>   pc : extent_writepage_io+0x2d4/0x308 [btrfs]
>>   lr : extent_writepage_io+0x2d4/0x308 [btrfs]
>>   Call trace:
>>    extent_writepage_io+0x2d4/0x308 [btrfs]
>>    extent_writepage+0x218/0x330 [btrfs]
>>    extent_write_cache_pages+0x1d4/0x4b0 [btrfs]
>>    btrfs_writepages+0x94/0x150 [btrfs]
>>    do_writepages+0x74/0x190
>>    filemap_fdatawrite_wbc+0x88/0xc8
>>    start_delalloc_inodes+0x180/0x3b0 [btrfs]
>>    btrfs_start_delalloc_roots+0x174/0x280 [btrfs]
>>    shrink_delalloc+0x114/0x280 [btrfs]
>>    flush_space+0x250/0x2f8 [btrfs]
>>    btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
>>    process_one_work+0x164/0x408
>>    worker_thread+0x25c/0x388
>>    kthread+0x100/0x118
>>    ret_from_fork+0x10/0x20
>>   Code: aa1403e1 9402f3ef aa1403e0 9402f36f (d4210000)
>>   ---[ end trace 0000000000000000 ]---
>>
>> [CAUSE]
>> That failure is mostly from cow_file_range(), where we can hit -ENOSPC.
>>
>> Although the -ENOSPC is already a bug related to our space reservation
>> code, let's just focus on the error handling.
>>
>> For example, we have the following dirty range [0, 64K) of an inode,
>> with 4K sector size and 4K page size:
>>
>>     0        16K        32K       48K       64K
>>     |///////////////////////////////////////|
>>     |#######################################|
>>
>> Where |///| means page are still dirty, and |###| means the extent io
>> tree has EXTENT_DELALLOC flag.
>>
>> - Enter extent_writepage() for page 0
>>
>> - Enter btrfs_run_delalloc_range() for range [0, 64K)
>>
>> - Enter cow_file_range() for range [0, 64K)
>>
>> - Function btrfs_reserve_extent() only reserved one 16K extent
>>    So we created extent map and ordered extent for range [0, 16K)
>>
>>     0        16K        32K       48K       64K
>>     |////////|//////////////////////////////|
>>     |<- OE ->|##############################|
>>
>>     And range [0, 16K) has its delalloc flag cleared.
>>     But since we haven't yet submit any bio, involved 4 pages are still
>>     dirty.
>>
>> - Function btrfs_reserve_extent() return with -ENOSPC
>>    Now we have to run error cleanup, which will clear all
>>    EXTENT_DELALLOC* flags and clear the dirty flags for the remaining
>>    ranges:
>>
>>     0        16K        32K       48K       64K
>>     |////////|                              |
>>     |        |                              |
>>
>>    Note that range [0, 16K) still has their pages dirty.
>>
>> - Some time later, writeback are triggered again for the range [0, 16K)
>>    since the page range still have dirty flags.
>>
>> - btrfs_run_delalloc_range() will do nothing because there is no
>>    EXTENT_DELALLOC flag.
>>
>> - extent_writepage_io() find page 0 has no ordered flag
>>    Which falls into the COW fixup path, triggering the BUG_ON().
>>
>> Unfortunately this error handling bug dates back to the introduction of btrfs.
>> Thankfully with the abuse of cow fixup, at least it won't crash the
>> kernel.
>>
>> [FIX]
>> Instead of immediately unlock the extent and folios, we keep the extent
>> and folios locked until either erroring out or the whole delalloc range
>> finished.
>>
>> When the whole delalloc range finished without error, we just unlock the
>> whole range with PAGE_SET_ORDERED (and PAGE_UNLOCK for !keep_locked
>> cases), with EXTENT_DELALLOC and EXTENT_LOCKED cleared.
>> And those involved folios will be properly submitted, with their dirty
>> flags cleared during submission.
>>
>> For the error path, it will be a little more complex:
>>
>> - The range with ordered extent allocated (range (1))
>>    We only clear the EXTENT_DELALLOC and EXTENT_LOCKED, as the remaining
>>    flags are cleaned up by
>>    btrfs_mark_ordered_io_finished()->btrfs_finish_one_ordered().
>>
>>    For folios we finish the IO (clear dirty, start writeback and
>>    immediately finish the writeback) and unlock the folios.
>>
>> - The range with reserved extent but no ordered extent (range(2))
>> - The range we never touched (range(3))
>>    For both range (2) and range(3) the behavior is not changed.
>>
>> Now even if cow_file_range() failed halfway with some successfully
>> reserved extents/ordered extents, we will keep all folios clean, so
>> there will be no future writeback triggered on them.
> 
> 2 qs, to make sure I understand:
> 
> This changes the happy path, in that IO can't start on the allocated
> ordered extents until the whole range is done allocating and unlocked or
> errors. But it shouldn't be a big deal unless we have this race a lot?

If we race a lot, it already means the fs is fragmented thus we need a 
lot of loops to allocate quite some small extents.

For normal cases, we should really get a large extent for the delalloc 
range in one go, and in that case, the lock holding period is not changed.

So if we really hit some races, it already means our fs is fragmented 
and no one can expect a quick run anyway.

> 
> What is the new behavior in your test case? The whole range correctly is
> not dirty, no IO happens, and the mapping has an error set on it? Have
> you managed to demonstrate something to that effect more explicitly than
> not hitting the BUG_ON in your new code?

Unfortunately I have no better way to verify the behavior, other than 
BUG_ON() in cow fixup path.

It may reduce the warning from space reservation code (because we 
properly free the reserved space), but it's less obvious than the 
avoided BUG_ON().

> 
> However, assuming I understood correctly, LGTM.
> Reviewed-by: Boris Burkov <boris@bur.io>

Thanks a lot for the review.
Qu

> 
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 65 ++++++++++++++++++++++++------------------------
>>   1 file changed, 32 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 5ba8d044757b..19c88b7d0363 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -1364,6 +1364,17 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   
>>   	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
>>   
>> +	/*
>> +	 * We're not doing compressed IO, don't unlock the first page
>> +	 * (which the caller expects to stay locked), don't clear any
>> +	 * dirty bits and don't set any writeback bits
>> +	 *
>> +	 * Do set the Ordered (Private2) bit so we know this page was
>> +	 * properly setup for writepage.
>> +	 */
>> +	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
>> +	page_ops |= PAGE_SET_ORDERED;
>> +
>>   	/*
>>   	 * Relocation relies on the relocated extents to have exactly the same
>>   	 * size as the original extents. Normally writeback for relocation data
>> @@ -1423,6 +1434,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   		file_extent.offset = 0;
>>   		file_extent.compression = BTRFS_COMPRESS_NONE;
>>   
>> +		/*
>> +		 * Locked range will be released either during error clean up or
>> +		 * after the whole range is finished.
>> +		 */
>>   		lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
>>   			    &cached);
>>   
>> @@ -1468,21 +1483,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   
>>   		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>>   
>> -		/*
>> -		 * We're not doing compressed IO, don't unlock the first page
>> -		 * (which the caller expects to stay locked), don't clear any
>> -		 * dirty bits and don't set any writeback bits
>> -		 *
>> -		 * Do set the Ordered flag so we know this page was
>> -		 * properly setup for writepage.
>> -		 */
>> -		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
>> -		page_ops |= PAGE_SET_ORDERED;
>> -
>> -		extent_clear_unlock_delalloc(inode, start, start + cur_alloc_size - 1,
>> -					     locked_folio, &cached,
>> -					     EXTENT_LOCKED | EXTENT_DELALLOC,
>> -					     page_ops);
>>   		if (num_bytes < cur_alloc_size)
>>   			num_bytes = 0;
>>   		else
>> @@ -1499,6 +1499,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   		if (ret)
>>   			goto out_unlock;
>>   	}
>> +	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
>> +				     EXTENT_LOCKED | EXTENT_DELALLOC,
>> +				     page_ops);
>>   done:
>>   	if (done_offset)
>>   		*done_offset = end;
>> @@ -1519,35 +1522,31 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   	 * We process each region below.
>>   	 */
>>   
>> -	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
>> -		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
>> -	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
>> -
>>   	/*
>>   	 * For the range (1). We have already instantiated the ordered extents
>>   	 * for this region. They are cleaned up by
>>   	 * btrfs_cleanup_ordered_extents() in e.g,
>> -	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
>> -	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
>> -	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
>> -	 * function.
>> +	 * btrfs_run_delalloc_range().
>> +	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
>> +	 * are also handled by the cleanup function.
>>   	 *
>> -	 * However, in case of @keep_locked, we still need to unlock the pages
>> -	 * (except @locked_folio) to ensure all the pages are unlocked.
>> +	 * So here we only clear EXTENT_LOCKED and EXTENT_DELALLOC flag,
>> +	 * and finish the writeback of the involved folios, which will be
>> +	 * never submitted.
>>   	 */
>> -	if (keep_locked && orig_start < start) {
>> +	if (orig_start < start) {
>> +		clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC;
>> +		page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
>> +
>>   		if (!locked_folio)
>>   			mapping_set_error(inode->vfs_inode.i_mapping, ret);
>>   		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
>> -					     locked_folio, NULL, 0, page_ops);
>> +					     locked_folio, NULL, clear_bits, page_ops);
>>   	}
>>   
>> -	/*
>> -	 * At this point we're unlocked, we want to make sure we're only
>> -	 * clearing these flags under the extent lock, so lock the rest of the
>> -	 * range and clear everything up.
>> -	 */
>> -	lock_extent(&inode->io_tree, start, end, NULL);
>> +	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
>> +		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
>> +	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
>>   
>>   	/*
>>   	 * For the range (2). If we reserved an extent for our delalloc range
>> -- 
>> 2.47.1
>>


