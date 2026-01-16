Return-Path: <linux-btrfs+bounces-20605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE03D2961E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 01:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2DE3302BF45
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D5253F11;
	Fri, 16 Jan 2026 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dzj2ucS2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F51F7569
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522245; cv=none; b=PzDtpxuBoVHrD7T9GJQ3nBGUk3wFL6vtmw472/LWnwVPh3uL1nSmpDJGZzvD0LO5dHJj7FgzRNcUYv9V3t7J1BN3KLvKf48iaO77t28I6jDXs1XJzJvSA7H8p8wTV+vd7NvANBjYN1EuijNvXg8wslWXNvt0Nsn71KFIKJw6BjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522245; c=relaxed/simple;
	bh=XFNg5ObGu7d57yxcnKSOfwCTVC4fZqbDA6n24XcUARM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/MrTUnsVa614qW69DlJE4zK27Q2tViAUAlrl0OKfx9mIM2Rt118qXVoyyTHn6j38vCTe/GTBogePxqaGa4Xj1ER97YjCcQXz8LcBGiqVdJQQBiqIZmgZGoTdB3LjmT5BUTA98iVuBCxBrHZsJRtYQzKtlFMH+/8NdXqmUzmOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dzj2ucS2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so10779425e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 16:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768522242; x=1769127042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wczD4/JW4vXH7KBr2LebkZ8hebDRw0uCKgE9XBpPlwA=;
        b=dzj2ucS2peF0VDHtJlf9im9d55WvXU+8EAeYpyhLPOH0ujNgolUZgC3zyvHr53m5NQ
         pv2PH9/XbzFjvgYq5FAHWHfaEofmvbe0U2EVDUTHj0Gl6IxiPanbWm/Ey2GWECrcJ7Ok
         ytxa9wCJOb/9yFQYVYjgADYKO1/sP+bEvlNY/9m5ZYrQWiJoD1OZm9NNjnjUx9l8eWTp
         PcGdXZjrLw/QVF6OhNg1By7swMYf3cbtwG6bSD3pXabjB2tgrdMMrXINy0DQylzJF8ez
         r0nHTfzKMP3F06fcVd1pemsTPOxZZHPJrmh8zMbVHJK+hfES0wTEtXgRwkVhZGEi/eRI
         gfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768522242; x=1769127042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wczD4/JW4vXH7KBr2LebkZ8hebDRw0uCKgE9XBpPlwA=;
        b=Hf34V1XTRWGb5g18bEg/BSD27gy2ZGkOaVPa7RSn+6tV+Z3kH8Gwb9LCUCC6M/5rb+
         9+WBDcORk3xjpho6D2VpoYWVJV0z9qgEleSU414LV8+WAi7WBe2uBhdXIGgiYZuzZW0M
         8T3+RjQTkp6BgI02xNMwQUQjpiGoIOAsmr11miSSC8i58nGT42Fo+hdf5n3y7lxEaL05
         zVR7vth3o0uziYwghLUONWI5ZvdHC2abOei4ETlzUqSkrO6a3he4duv8gHVIpdeORCTn
         oeggvXyusqaqnQ4Gnlro9EwuMr1pByHZeo9+FgpH0BfeBaZv+tDroJSupLgHSZhiamhG
         Vzag==
X-Gm-Message-State: AOJu0YytNegwJkyVYKAvvpdzfuQbU0R8OVdEsMq55ysuz7WLr5Dd2xmQ
	YTjgrMYGs3c80fbQKbyOXyUNqvdouDZ9EDi0Hq3QIKkSRuzTb2LcB+oQis1fzgwnhTI=
X-Gm-Gg: AY/fxX5LNmPSSG2IsAG9DggBkN/tUAGwrLbtCjTffITh5bh+nb28yf6GdFU5c47k7zb
	kEr7V/mqs8nxKkxrRW5wZzj+iztxgIBQklCquemTkIqj/7CVaUFBZ2REPSQ73bI4hJYlyjWftkR
	/GeRuvhrMeOkjNYL+6idtJcZYmiirpcvZOSUxuUOENnBig+KEj2ORHOh6b9SLKNP/22plsxpb/d
	AhAJzMepTVmiuCEG4eqT0+w+7y51zHuvOz324XjDiR0vXR/FvMEf5JJFRQtBJiM0QdXIGMd6/UE
	AgyIuAG/scSxyY8GY+E2Ww+axswNSDUXaH2/OuOwHc4mPWYeNGn05w5rqaQC21VyrVa1+SV8Qf4
	F0Xws0qSR3wGXuM0FUjZYKg6j0y3+xHjSu4x7l0c9h55lXhJuch3nJ6Kfm3fvg4Lf44HyKXPDtl
	KB6ajaJtb9WlnTKkVPexznsxWr7maqLAtTZfTbb5WFsIgm5pcUDA==
X-Received: by 2002:a05:600c:5912:b0:471:793:e795 with SMTP id 5b1f17b1804b1-47f3b7a4005mr36412335e9.0.1768522241839;
        Thu, 15 Jan 2026 16:10:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678ef77fsm2913830a91.17.2026.01.15.16.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 16:10:40 -0800 (PST)
Message-ID: <0d94f69b-e664-49c8-bc6e-f7c61f39ef84@suse.com>
Date: Fri, 16 Jan 2026 10:40:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not strictly require dirty metadata threshold
 for metadata writepages
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <ccfd051d2ae173d95f3f6e75b7466efbf4596620.1768452808.git.wqu@suse.com>
 <20260115233007.GC2118372@zen.localdomain>
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
In-Reply-To: <20260115233007.GC2118372@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/16 10:00, Boris Burkov 写道:
> On Thu, Jan 15, 2026 at 03:23:44PM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is an internal report that btrfs hits a hang at
>> balance_dirty_pages() for btree inode.
>>
>> [CAUSE]
>> balance_dirty_pages() can be triggered by both internal calls like
>> btrfs_btree_balance_dirty() and external callers like mm or cgroup.
>>
>> For internal calls, btrfs_btree_balance_dirty() calls
>> __btrfs_btree_balance_dirty() which will check if the current dirty
>> metadata reaches a certain threshold (32M), and if not we just skip the
>> workload.
>>
>> For external calls they can directly call btree_writepages(), which
> 
> grammar nit: you don't need the "can".
> "External callers directly call btree_writepages()" or something is
> clearer.
> 
>> is doing a similar check against the threshold, and skip the writeback
>> again if it's not reaching the same 32M threshold.
>>
>> But the threshold is only internal to btrfs, if cgroup or mm chose to
>> balance dirty pages for the metadata inode at a much lower threshold, in
>> this case the dirty pages count is around 28M, lower than btrfs'
>> internal threshold.
> 
> I think this is a good argument. Layering multiple different mechanisms
> for metering writeback doesn't make a ton of sense to me. With that
> said, it's not great for the write performance of the btrees if we
> writeback already cow-ed nodes, so allowing more frequent writeback
> might be harmful in practice.
> 
> I still think it's worth it to simplify things and "find out",
> especially if this existing behavior is buggy...
> 
>>
>> This causes all writeback request to be ignored, and no dirty pages for
>> btrfs btree inode can be balanced, resulting hang for all
>> balance_dirty_pages() callers.
> 
> Does this happen determinstically if balance_dirty_pages() is called on
> the btrfs sb with <32M dirty eb pages?

Yes, the core dump provided from our customer is exactly showing that.

Our btrfs_fs_info.dirty_metadata_bytes is 28672000, and the 
bdi_writeback.stat[0] shows a count of 5712 (which is around 23396352 
bytes), meaning the writeback request wants to write back around 23M 
dirty pages, and our btree inode has around 28M dirty pages for writeback.

And our customer has hit this hang twice.

> Or does it depend on the state of
> the dirty file pages too, like if those inodes get back some memory,
> it's OK? Just curious to understand better.

My understanding is yes, as long as there are enough dirty pages on data 
inodes that can be written back to fulfill that request.

But in this particular case, almost all dirty pages are from btree 
inode, thus we have to writeback that btree inode to fulfill that 
writeback request.

> 
>>
>> Thanks Jan Kara a lot for the analyze on the root cause.
>>
>> [FIX]
>> For internal callers using btrfs_btree_balance_dirty() since that
>> function is already doing internal threshold check, we don't need to
>> bother it.
>>
>> But for external callers of btree_writepages(), then respect their
>> request and just writeback whatever they want, ignoring the internal
>> btrfs threshold to avoid such deadlock on btree inode dirty page
>> balancing.
> 
> Is it a deadlock or a livelock?

It's more like a livelock, tons of processes (over 1000 UN processes) 
waiting on the balance of btree inode.

They all wait on the io_schedule_timeout() from balance_dirty_pages(), 
and all are for the btree inode.

System can still work to some extent, but considering how many processes 
are waiting for balance_dirty_pages() from even basic buffered writes, I 
definitely won't call it a working system.

> Can you explain the hang a bit more? Is
> it something bad about returning 0 or does the balance_dirty_pages()
> loop forever trying to balance and failing to make progress?

I'll use the following example calltrace of a hanging process:

PID: 3141     TASK: ffff89e1806cc000  CPU: 48   COMMAND: "threadpool"
  #0 [ffffcc2bdd69b930] __schedule at ffffffff8d678240
  #1 [ffffcc2bdd69b9e0] schedule at ffffffff8d679424
  #2 [ffffcc2bdd69b9f0] schedule_timeout at ffffffff8d67fcec
  #3 [ffffcc2bdd69ba68] io_schedule_timeout at ffffffff8d679919
  #4 [ffffcc2bdd69ba80] balance_dirty_pages at ffffffff8cd06cd7
  #5 [ffffcc2bdd69bbe8] balance_dirty_pages_ratelimited_flags at 
ffffffff8cd079d6
  #6 [ffffcc2bdd69bc18] btrfs_buffered_write at ffffffffc05d56a3 [btrfs]
  #7 [ffffcc2bdd69bcf8] btrfs_do_write_iter at ffffffffc05d865a [btrfs]
  #8 [ffffcc2bdd69bd70] vfs_write at ffffffff8ce01bc6
  #9 [ffffcc2bdd69be08] ksys_write at ffffffff8ce01e65
#10 [ffffcc2bdd69be88] __x64_sys_write at ffffffff8ce01eb5
#11 [ffffcc2bdd69be90] do_syscall_64 at ffffffff8d665adb
#12 [ffffcc2bdd69bef0] syscall_exit_to_user_mode at ffffffff8d66d13e
#13 [ffffcc2bdd69bf00] do_syscall_64 at ffffffff8d665ae7
#14 [ffffcc2bdd69bf18] clear_bhb_loop at ffffffff8d8019a0
#15 [ffffcc2bdd69bf28] clear_bhb_loop at ffffffff8d8019a0
#16 [ffffcc2bdd69bf38] clear_bhb_loop at ffffffff8d8019a0
#17 [ffffcc2bdd69bf50] entry_SYSCALL_64_after_hwframe at ffffffff8d80013

It's a regular buffered write, after updating the inode, we call 
btrfs_btree_balance_dirty() and at that time the dirty threshold is met, 
so we call balance_dirty_pages_ratelimited().

But immediately after that percpu counter check, btrfs wrote back some 
dirty metadata blocks, thus the dirty_metadata_bytes is now slightly 
lower than the threshold.

This means, the double checks (one in __btrfs_btree_balance_dirty() and 
the other in btree_writepages()) are causing problems.

One check may pass but may not pass in the later btree_writepages().

In that case, we will hit balance_dirty_pages() with long wait, until 
enough dirty metadata to really trigger a writeback.


> Is it a
> hard requirement that if balance_dirty_pages() selects some inode it
> must make progress on writeback in one call to writepages or else it's a
> bug? That would be a bit surprising to me as well, but I am not a memory
> expert obviously.

Not familiar with the details of balance_dirty_pages(), it seems to 
sleep for a time based on the number of dirty pages and task ratelimit, 
then re-check and re-start the writeback if the exit condition is not met.

Although still with some uncertainty, the double race window for the 
double checks, and the doing nothing behavior is at least causing a lot 
of latency for the corner case.

> 
> Sorry for being a bit pedantic, but I have coincidentally been thinking
> about this a lot lately.

No worry, since there is still some uncertainty, it's totally fine.

> 
> Thanks for hunting it down, by the way.

Well, most of the work is done by Jan, I am just the guy trying to fix 
the btrfs part, and unfortunately not fully understanding the 
balance_dirty_pages() behavior, thus I may still need extra help from 
Jan on this case.

Thanks,
Qu

> 
> Boris
> 
>>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 24 +-----------------------
>>   1 file changed, 1 insertion(+), 23 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 5e4b7933ab20..9add1f287635 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -485,28 +485,6 @@ static int btree_migrate_folio(struct address_space *mapping,
>>   #define btree_migrate_folio NULL
>>   #endif
>>   
>> -static int btree_writepages(struct address_space *mapping,
>> -			    struct writeback_control *wbc)
>> -{
>> -	int ret;
>> -
>> -	if (wbc->sync_mode == WB_SYNC_NONE) {
>> -		struct btrfs_fs_info *fs_info;
>> -
>> -		if (wbc->for_kupdate)
>> -			return 0;
>> -
>> -		fs_info = inode_to_fs_info(mapping->host);
>> -		/* this is a bit racy, but that's ok */
>> -		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
>> -					     BTRFS_DIRTY_METADATA_THRESH,
>> -					     fs_info->dirty_metadata_batch);
>> -		if (ret < 0)
>> -			return 0;
>> -	}
>> -	return btree_write_cache_pages(mapping, wbc);
>> -}
>> -
>>   static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
>>   {
>>   	if (folio_test_writeback(folio) || folio_test_dirty(folio))
>> @@ -584,7 +562,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
>>   #endif
>>   
>>   static const struct address_space_operations btree_aops = {
>> -	.writepages	= btree_writepages,
>> +	.writepages	= btree_write_cache_pages,
>>   	.release_folio	= btree_release_folio,
>>   	.invalidate_folio = btree_invalidate_folio,
>>   	.migrate_folio	= btree_migrate_folio,
>> -- 
>> 2.52.0
>>
> 


