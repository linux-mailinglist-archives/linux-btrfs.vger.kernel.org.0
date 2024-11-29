Return-Path: <linux-btrfs+bounces-9965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9B9DBF85
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260AEB20C7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EAA15666A;
	Fri, 29 Nov 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="acG7I98e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB3BA4B
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732862361; cv=none; b=YQ8KxFdZa2eWHzP2lTOd7t5H7Uq+zDYYtdXJFneaa8Y9liORSr2gqPFQD6njeHCbPCcQVimkfEQK+7Cb/NK3H0xQGqZjNuncB6PlKk6+7/R+t6se23/P3xwDe/YQoBdSRwuP458GmVJ2ry1nwUBO98ps0KDzz0qiJwmJ1qU3F7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732862361; c=relaxed/simple;
	bh=2MKk7abYNda5SluRZkBFK8CKCc/CXEkYPRfVnMxEDkM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MS5951ZVV0Ovj1riEaaOvKU2bD8OKjkTnUlE4rR/IS95XWQha83uhogPGjMv3vAcCpSEEFSXladUYMZUbJgIbOwZ0zd6kxHz5AzB4ykOxvCIKBwuw18N3F5vpSEpyOZGZ0qnOg7GF6GqMGkXqAzP3IRxznoGbCng51aO9gWuupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=acG7I98e; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so17671201fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 22:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732862356; x=1733467156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/i2zWjGFZxhYNDpCFa7jyz/6YuafVkFFxliR3c7kfA4=;
        b=acG7I98eFesmNg2mTDZo5KU5NxqUtx10eEW9/XtjHETdN8nnHHY+aSDDr7iJgURhjH
         dcgUgMibA17pm329hdOmp/x8quSRW+lcbYduurM5elP0RUND88Weq55iUJw2YUL9fBJn
         Dpyrl1mU8Rq+pWpJoI9+pGzu3EQBnhpBuOmys9yRxSFO/m9ixk+7GPYW3EYi12EFivWv
         ZGYPcX92paMSYjf9Z/OY8njX51jkE0xZWAnSPZ5Hp/Gi5PvNdjDSCs8vu3g0SPZNbU2h
         H6vk5tnXW/uu5SUDAzVN0pNK+ItrYySwu2LYyFqw3pEKmhB8bjZk7VqKE0x81bxaB7eS
         CGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732862356; x=1733467156;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/i2zWjGFZxhYNDpCFa7jyz/6YuafVkFFxliR3c7kfA4=;
        b=kwsgFL/LDRJHg86yLNYLkaBd8/0jFM15j+XbBkBRulglneUNVI+I1vnnRImjqVd/rI
         4RrcDaq67AAEbl8cTmPiWnyR2yVepSu2Nku+5RjOe5ocSek+3QFILEXD5iL4SWpOmj+R
         ltdty+HcVa9GhfrksLilLRdR7KbBbMF9dhXDXwAM2BEf/EbWQ9+i+R3+oDqNlJvx+lXf
         N4PuqBUZEmRakmQOzHX/f6t754SPuXK3/eKwjf+pxUdLkUJh0MkORsN2AeV/+g7okoFb
         hn3pJPvj3HpkA3wiaO21dZ4NWXah7JOPGXkOYHporNEnHi7q2g925yYNJ/bKw6V1aw68
         gt0A==
X-Gm-Message-State: AOJu0YyZU8egAFq1P2ywmt1DxwVrbTYovy+IMJhIipT2sPRcS9zy0h3K
	/ipEyO4DeYkDHVWab7NgqtVMCopAaJNwWqsA5fsFvMIbmfcSDh6zUsf8sofc/JdnJWM27wjW6wz
	x
X-Gm-Gg: ASbGncuv7fVwjc+1qpID7KRjncSvZnNhoZa28ymKcg22hNri0m1EY3pCnxRuKpmU3eR
	gjpybQ675rjTsqZ7tBlTVKB67FNV+uFCmDIVVN8u043GSFIWp5SFrzKLWJZahUdyQs4NcJuFaJ2
	OWzcr/CyhuaEp6VF7lySP9isCQkfDL/VFnUfhWdj72TDasF63dmKy4pH2KZra5RC2wIWoNGn7P3
	TWvBVQefBHbxWBOb4m6VHzzxfjD6TxgC5iPIvgRhRqlrq6vOD9YKB2o9/kHZNrMLSpImd+RuZKp
	Fg==
X-Google-Smtp-Source: AGHT+IEqF44U+9PzZiluTDZEDvdvhaOl3eeisb/4eALGykSALhJ/MhrrxYGg2mup6MsORsgBftvdLg==
X-Received: by 2002:a05:6512:33c8:b0:53d:abc8:b6dc with SMTP id 2adb3069b0e04-53df00aa1e1mr5865939e87.6.1732862355241;
        Thu, 28 Nov 2024 22:39:15 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848924sm2776661b3a.180.2024.11.28.22.39.13
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 22:39:14 -0800 (PST)
Message-ID: <51aa6661-2e88-41d0-af7e-25d6d217ec0c@suse.com>
Date: Fri, 29 Nov 2024 17:09:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: keep EXTENT_DELALLOC* flags when
 cow_file_range() failed
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <bd9263e9fb83ba977aff71b4d34e4435342f0a3a.1732861916.git.wqu@suse.com>
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
In-Reply-To: <bd9263e9fb83ba977aff71b4d34e4435342f0a3a.1732861916.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/29 17:02, Qu Wenruo 写道:
> [BUG]
> When testing with COW fixup marked as BUG_ON() (this is involved with the
> new pin_user_pages*() change, which should not result new out-of-band
> dirty pages), I hit a crash triggered by the BUG_ON() from hitting COW
> fixup path.
> 
> This BUG_ON() happens just after a failed btrfs_run_delalloc_range():
> 
>   BTRFS error (device dm-2): failed to run delalloc range, root 348 ino 405 folio 65536 submit_bitmap 6-15 start 90112 len 106496: -28
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/extent_io.c:1444!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   CPU: 0 UID: 0 PID: 434621 Comm: kworker/u24:8 Tainted: G           OE      6.12.0-rc7-custom+ #86
>   Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>   Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
>   pc : extent_writepage_io+0x2d4/0x308 [btrfs]
>   lr : extent_writepage_io+0x2d4/0x308 [btrfs]
>   Call trace:
>    extent_writepage_io+0x2d4/0x308 [btrfs]
>    extent_writepage+0x218/0x330 [btrfs]
>    extent_write_cache_pages+0x1d4/0x4b0 [btrfs]
>    btrfs_writepages+0x94/0x150 [btrfs]
>    do_writepages+0x74/0x190
>    filemap_fdatawrite_wbc+0x88/0xc8
>    start_delalloc_inodes+0x180/0x3b0 [btrfs]
>    btrfs_start_delalloc_roots+0x174/0x280 [btrfs]
>    shrink_delalloc+0x114/0x280 [btrfs]
>    flush_space+0x250/0x2f8 [btrfs]
>    btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
>    process_one_work+0x164/0x408
>    worker_thread+0x25c/0x388
>    kthread+0x100/0x118
>    ret_from_fork+0x10/0x20
>   Code: aa1403e1 9402f3ef aa1403e0 9402f36f (d4210000)
>   ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> That failure is mostly from cow_file_range(), where we can hit -ENOSPC.
> 
> Although the -ENOSPC is already a bug related to our space reservation
> code, let's just focus on the error handling.
> 
> For example, we have the following dirty range [0, 64K) of an inode,
> with 4K sector size and 4K page size:
> 
>     0        16K        32K       48K       64K
>     |///////////////////////////////////////|
>     |#######################################|
> 
> Where |///| means page are still dirty, and |###| means the extent io
> tree has EXTENT_DELALLOC flag.
> 
> - Enter extent_writepage() for page 0
> 
> - Enter btrfs_run_delalloc_range() for range [0, 64K)
> 
> - Enter cow_file_range() for range [0, 64K)
> 
> - Function btrfs_reserve_extent() only reserved one 16K extent
>    So we created extent map and ordered extent for range [0, 16K)
> 
>     0        16K        32K       48K       64K
>     |////////|//////////////////////////////|
>     |<- OE ->|##############################|
> 
>     And range [0, 16K) has its delalloc flag cleared.
>     But since we haven't yet submit any bio, all pages are still dirty.
> 
> - Function btrfs_reserve_extent() return with -ENOSPC
>    Now we have to run error cleanup, which will clear all
>    EXTENT_DELALLOC* flags for the range, now we have:
> 
>     0        16K        32K       48K       64K
>     |////////|//////////////////////////////|
>     |        |                              |
> 
>     Note that all pages are still dirty.
> 
> - Some time later, writeback are triggered again for the range [0, 64K)
> 
> - btrfs_run_delalloc_range() will do nothing because there is no
>    EXTENT_DELALLOC flag.
> 
> - extent_writepage_io() find page 0 has no ordered flag
>    Which falls into the COW fixup path, triggering the BUG_ON().
> 
> [FIX]
> To be honest, I have no idea what's the proper way to handle an error
> during btrfs_run_delalloc_range().
> 
> All existing handling are treating them like the IO is done, clearing
> all the EXTENT_DELALLOC* flags and reserved qgroup space.
> 
> But we still leave all those page marked as dirty, and later writeback
> may still try write those pages back.
> 
> So here I choose to treat them as untouched at all, keeping all the
> EXTENT_DELALLOC* flags along with reserved data/qgroup space.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> 
> I have no idea what's the proper way to handle
> btrfs_run_delalloc_range() failure, but since we're trying to
> deprecating the COW fixup, at least we need to keep the EXTENT_DELALLOC*
> flags.
> 
> The other solution is to follow the iomap's handling, if map_blocks()
> failed, just mark all folios in the range as clean, and keep the current
> handling.

My bad, btrfs is already taking the iomap's behavior, by using 
PAGE_START_WRITEBACK will clear the dirty flag for the range.

The problem is in the handling of the range where OE is created (and 
@keep_locked is false).
Which will fully skip the extent_clear_unlock_delalloc() call.

In that case, we need an unconditional cleanup for all dirty flags.

Will give a proper fix to the situation.

Thanks,
Qu
> 
> At least for now that indeed sounds way more reasonable.
> ---
>   fs/btrfs/inode.c | 90 ++++++++++++++++++++++++++----------------------
>   1 file changed, 48 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9267861f8ab0..9d5a3ed95528 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1372,6 +1372,17 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   
>   	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
>   
> +	/*
> +	 * We're not doing compressed IO, don't unlock the first page
> +	 * (which the caller expects to stay locked), don't clear any
> +	 * dirty bits and don't set any writeback bits
> +	 *
> +	 * Do set the Ordered (Private2) bit so we know this page was
> +	 * properly setup for writepage.
> +	 */
> +	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
> +	page_ops |= PAGE_SET_ORDERED;
> +
>   	/*
>   	 * Relocation relies on the relocated extents to have exactly the same
>   	 * size as the original extents. Normally writeback for relocation data
> @@ -1477,20 +1488,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>   
>   		/*
> -		 * We're not doing compressed IO, don't unlock the first page
> -		 * (which the caller expects to stay locked), don't clear any
> -		 * dirty bits and don't set any writeback bits
> +		 * There used to be an extent_clear_unlock_delalloc() call.
> +		 * But that will clear EXTENT_DELALLOC flag even if we error out
> +		 * later, with the page still marked dirty.
>   		 *
> -		 * Do set the Ordered (Private2) bit so we know this page was
> -		 * properly setup for writepage.
> +		 * So here we intentionally do not unlock this range.
> +		 * But only unlock the full range when everything go OK.
>   		 */
> -		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
> -		page_ops |= PAGE_SET_ORDERED;
> -
> -		extent_clear_unlock_delalloc(inode, start, start + cur_alloc_size - 1,
> -					     locked_folio, &cached,
> -					     EXTENT_LOCKED | EXTENT_DELALLOC,
> -					     page_ops);
>   		if (num_bytes < cur_alloc_size)
>   			num_bytes = 0;
>   		else
> @@ -1507,6 +1511,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   		if (ret)
>   			goto out_unlock;
>   	}
> +	extent_clear_unlock_delalloc(inode, orig_start, end,
> +				     locked_folio, &cached,
> +				     EXTENT_LOCKED | EXTENT_DELALLOC,
> +				     page_ops);
>   done:
>   	if (done_offset)
>   		*done_offset = end;
> @@ -1525,38 +1533,42 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   	 * `- orig_start  `- start  `- start + cur_alloc_size  `- end
>   	 *
>   	 * We process each region below.
> +	 *
> +	 *
> +	 * For the EXTENT_* flags, we should only unlock them and do not touch
> +	 * the EXTENT_DELALLOC* flags.
> +	 *
> +	 * All pages in above ranges (1)(2)(3) are not submitted thus they are
> +	 * still dirty and may be rewritten back later.
> +	 * Thus they should still be treated as EXTENT_DEALLOC, or no new
> +	 * delalloc range will be run.
> +	 * In that case we will fall back to the to-be-deprecated COW fixup
> +	 * path.
> +	 *
> +	 * The same applies to the reserved bytes and qgroup space.
>   	 */
> -
> -	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
> -		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
> -	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
> +	clear_bits = EXTENT_LOCKED;
> +	page_ops = PAGE_UNLOCK;
>   
>   	/*
>   	 * For the range (1). We have already instantiated the ordered extents
> -	 * for this region. They are cleaned up by
> +	 * for this region. Ordered extents are cleaned up by
>   	 * btrfs_cleanup_ordered_extents() in e.g,
> -	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
> -	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
> -	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
> -	 * function.
> -	 *
> -	 * However, in case of @keep_locked, we still need to unlock the pages
> -	 * (except @locked_folio) to ensure all the pages are unlocked.
> +	 * btrfs_run_delalloc_range(), which will also free the reserved extents.
>   	 */
> -	if (keep_locked && orig_start < start) {
> +	if (orig_start < start) {
> +		unlock_extent(&inode->io_tree, orig_start, start - 1, NULL);
>   		if (!locked_folio)
>   			mapping_set_error(inode->vfs_inode.i_mapping, ret);
> -		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> -					     locked_folio, NULL, 0, page_ops);
> +		/*
> +		 * However, in case of @keep_locked, we still need to unlock the pages
> +		 * (except @locked_folio) to ensure all the pages are unlocked.
> +		 */
> +		if (keep_locked)
> +			extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> +						     locked_folio, NULL, 0, page_ops);
>   	}
>   
> -	/*
> -	 * At this point we're unlocked, we want to make sure we're only
> -	 * clearing these flags under the extent lock, so lock the rest of the
> -	 * range and clear everything up.
> -	 */
> -	lock_extent(&inode->io_tree, start, end, NULL);
> -
>   	/*
>   	 * For the range (2). If we reserved an extent for our delalloc range
>   	 * (or a subrange) and failed to create the respective ordered extent,
> @@ -1567,13 +1579,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   	 * to decrement again the data space_info's bytes_may_use counter,
>   	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
>   	 */
> -	if (cur_alloc_size) {
> +	if (cur_alloc_size)
>   		extent_clear_unlock_delalloc(inode, start,
>   					     start + cur_alloc_size - 1,
>   					     locked_folio, &cached, clear_bits,
>   					     page_ops);
> -		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
> -	}
>   
>   	/*
>   	 * For the range (3). We never touched the region. In addition to the
> @@ -1581,14 +1591,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   	 * space_info's bytes_may_use counter, reserved in
>   	 * btrfs_check_data_free_space().
>   	 */
> -	if (start + cur_alloc_size < end) {
> -		clear_bits |= EXTENT_CLEAR_DATA_RESV;
> +	if (start + cur_alloc_size < end)
>   		extent_clear_unlock_delalloc(inode, start + cur_alloc_size,
>   					     end, locked_folio,
>   					     &cached, clear_bits, page_ops);
> -		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
> -				       end - start - cur_alloc_size + 1, NULL);
> -	}
>   	return ret;
>   }
>   


