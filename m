Return-Path: <linux-btrfs+bounces-9844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8749D6CED
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 08:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813F9B212AD
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 07:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B4156F3A;
	Sun, 24 Nov 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UtQX3YWC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7EA3D0D5
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732433497; cv=none; b=gIvqlKwdo/aMLQuJVP6DMu5YgfKdOmUq93ukpWzF8L4L7F+CRuXIYn5WTRZf2kQo2fhqQ+HEQtf5npM0wQyquGqEpcJWBcbCye/z/KmPm2/M+wJjwKwdBsWywvhWNECw4T4MJULASdoLOWpHOgyJYcWS/y2MmGSSi06poCtX89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732433497; c=relaxed/simple;
	bh=vw6SoLQ+KhHbcAfEOw39JTdI6RD2GDTaLROMRxrcQ0o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tLHOS/5C7fpeo04qm81YsTWz06YKIU5oKnOPGh5W4eJuHdC+1n+2lK1CYabV6kFhDqnChGIMcLW6MBsqDQksUY8sAn2TSKwBn6d57cLSJ3dtEUXQ6NiuWmWywBkihIXmJ5cvIOTO5LRQFVwQvuaRgSXq1JTa4DruYSMY7hSJomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UtQX3YWC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so2718813f8f.3
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Nov 2024 23:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732433492; x=1733038292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8USLEmttCnlD1YP8mUQeQmsOMai+Su6bIpgdnzzYhg=;
        b=UtQX3YWCOXC54EngjPZTu7XLdLo1j5YsIIgikGLw/jCooCVS0CYrerhk2iFG28tMWE
         XZM/veW5AvXuB9/OszMXo/mEo9wPuRC58MwM+XRHDq6LiRygsi94hoAtYRPF1ikvJScG
         60LhyE7SHZ6Dt+E30+DLdddsCkz0cKTs53TJUV+o6vC1fbZBQbC0HhgguatqiCfi7S8W
         n+sJEzdTNwJBUrYYhQIDaIp9qUqG/3isjarrIUAI4kChlsGX+gryuB07LMC3kDwdHrs1
         IBglJxnqUgcp2B9RnxQkD90hkBZgL5Q9JChRc70MmFzykZwjAhZamc8dd+VtOc3BnLMD
         8qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732433492; x=1733038292;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8USLEmttCnlD1YP8mUQeQmsOMai+Su6bIpgdnzzYhg=;
        b=iERUAJsjkqxFz1Uo1QWe3B9bak8A6P9zmju1mwfW4s8UDwme6bAxeSG8XA6IRHfiJy
         w4u7kWYgDFAcqU2+cZ9Hy7Q7jnEOulYWCkcrXWu8A+FgLy5OpcXt5EiBiuev9xpFQaDX
         uqtrUs6ttKwesbMm66UovhR9u6oa0F7hG63/yjnXC04k22yEwVKAUlx4zQ0IL57IUCQ+
         j1hQC5YFq3ldMmGIrpsQvFVQW5iY0Dj8zo3OcALrH+ffuyyWQkPIHIrca1t2fXDJIkPV
         K15Rf7rm34wPYaU4cEqeAcAk0/+rTexnscwnU1r8m60TB7KPI8mZ1TMLiLBvuL/NfoBz
         TBtA==
X-Gm-Message-State: AOJu0YzuUw7z5aCWYKtbINQYjG+9r5u045OXsD4pps0psTB2/UUxWn2r
	QnG+o7ziEMFuhA6Bwsj2w3V6NNfHEIaz0DdO5cWo7/15W+/Oyt/BU3posioRR3VyvZgYcOZwb1t
	g
X-Gm-Gg: ASbGnctJWzHf+7P9xvJWeRqFhZQfmj9oAI4Q2JjqemOJNFr/r5uPnczY16ffr51sBoR
	TgQng67bTSYpZh96RnJBXCZ14DngSAE7WPr6A+HMS2qSiQJWfpw3lhG5C7DP9R9tDxozFnF8bOl
	AC+sSM2bzACueIw37pG24NZubTIMoRvKAO3bv+vZQoOVRzburHhkk1SB3JnQ+jKUIx8FaVkWtqA
	v0biNOMZS+MnSHp7WSwBdqM1AMfPtGGk5OiHRLXRo+lx3DOenOxJ9dfr1vgG/LS7e+9pAoVUqwg
	0A==
X-Google-Smtp-Source: AGHT+IHFAEGhxao4m7o290oMFW/cM6ska/7P2ObXU8OHcfiia2NCpy3dg9jQXlUOFkYTqrZUuwaDAQ==
X-Received: by 2002:a5d:588e:0:b0:382:383e:84e2 with SMTP id ffacd0b85a97d-38260bc93acmr8617085f8f.46.1732433491401;
        Sat, 23 Nov 2024 23:31:31 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0314497sm7932632a91.17.2024.11.23.23.31.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 23:31:30 -0800 (PST)
Message-ID: <2327765d-c139-495e-94f0-5bab11adf440@suse.com>
Date: Sun, 24 Nov 2024 18:01:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] btrfs: fix double accounting of ordered extents
 during errors
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1730269807.git.wqu@suse.com>
 <2faab8a96c6dd2a414a96e4cebae97ecbddf021d.1730269807.git.wqu@suse.com>
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
In-Reply-To: <2faab8a96c6dd2a414a96e4cebae97ecbddf021d.1730269807.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I know this is part of the subpage patches, but this is really a bug fix 
for the existing subpage handling.

Appreciate if anyone can give this a review.

Thanks,
Qu

在 2024/10/30 17:03, Qu Wenruo 写道:
> [BUG]
> Btrfs will fail generic/750 randomly if its sector size is smaller than
> page size.
> 
> One of the warning looks like this:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 90263 at fs/btrfs/ordered-data.c:360 can_finish_ordered_extent+0x33c/0x390 [btrfs]
>   CPU: 1 UID: 0 PID: 90263 Comm: kworker/u18:1 Tainted: G           OE      6.12.0-rc3-custom+ #79
>   Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
>   pc : can_finish_ordered_extent+0x33c/0x390 [btrfs]
>   lr : can_finish_ordered_extent+0xdc/0x390 [btrfs]
>   Call trace:
>    can_finish_ordered_extent+0x33c/0x390 [btrfs]
>    btrfs_mark_ordered_io_finished+0x130/0x2b8 [btrfs]
>    extent_writepage+0xfc/0x338 [btrfs]
>    extent_write_cache_pages+0x1d4/0x4b8 [btrfs]
>    btrfs_writepages+0x94/0x158 [btrfs]
>    do_writepages+0x74/0x190
>    filemap_fdatawrite_wbc+0x88/0xc8
>    start_delalloc_inodes+0x180/0x3b0 [btrfs]
>    btrfs_start_delalloc_roots+0x17c/0x288 [btrfs]
>    shrink_delalloc+0x11c/0x280 [btrfs]
>    flush_space+0x27c/0x310 [btrfs]
>    btrfs_async_reclaim_metadata_space+0xcc/0x208 [btrfs]
>    process_one_work+0x228/0x670
>    worker_thread+0x1bc/0x360
>    kthread+0x100/0x118
>    ret_from_fork+0x10/0x20
>   irq event stamp: 9784200
>   hardirqs last  enabled at (9784199): [<ffffd21ec54dc01c>] _raw_spin_unlock_irqrestore+0x74/0x80
>   hardirqs last disabled at (9784200): [<ffffd21ec54db374>] _raw_spin_lock_irqsave+0x8c/0xa0
>   softirqs last  enabled at (9784148): [<ffffd21ec472ff44>] handle_softirqs+0x45c/0x4b0
>   softirqs last disabled at (9784141): [<ffffd21ec46d01e4>] __do_softirq+0x1c/0x28
>   ---[ end trace 0000000000000000 ]---
>   BTRFS critical (device dm-2): bad ordered extent accounting, root=5 ino=1492 OE offset=1654784 OE len=57344 to_dec=49152 left=0
> 
> [CAUSE]
> The function btrfs_mark_ordered_io_finished() is called for marking all
> ordered extents in the page range as finished, for error handling.
> 
> But for sector size < page size cases, we can have multiple ordered
> extents in one page.
> 
> If extent_writepage_io() failed (the only possible case is
> submit_one_sector() failed to grab an extent map), then the call site
> inside extent_writepage() will call btrfs_mark_ordered_io_finished() to
> finish the created ordered extents.
> 
> However some range of the ordered extent may have been submitted already,
> then btrfs_mark_ordered_io_finished() is called on the same range, causing
> double accounting.
> 
> [FIX]
> - Introduce a new member btrfs_bio_ctrl::last_submitted
>    This will trace the last sector submitted through
>    extent_writepage_io().
> 
>    So for the above extent_writepage() case, we will know exactly which
>    sectors are submitted and should not do the ordered extent accounting.
> 
> - Introduce a helper cleanup_ordered_extents()
>    This will do a sector-by-sector cleanup with
>    btrfs_bio_ctrl::last_submitted and btrfs_bio_ctrl::submit_bitmap into
>    consideartion.
> 
>    Using @last_submitted is to avoid double accounting on the submitted
>    ranges.
>    Meanwhile using @submit_bitmap is to avoid touching ranges going
>    through compression.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 41 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e629d2ee152a..427bfbe737f2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -108,6 +108,14 @@ struct btrfs_bio_ctrl {
>   	 * This is to avoid touching ranges covered by compression/inline.
>   	 */
>   	unsigned long submit_bitmap;
> +
> +	/*
> +	 * The end (exclusive) of the last submitted range in the folio.
> +	 *
> +	 * This is for sector size < page size case where we may hit error
> +	 * half way.
> +	 */
> +	u64 last_submitted;
>   };
>   
>   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> @@ -1435,6 +1443,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>   		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
>   		if (ret < 0)
>   			goto out;
> +		bio_ctrl->last_submitted = cur + fs_info->sectorsize;
>   		submitted_io = true;
>   	}
>   out:
> @@ -1453,6 +1462,24 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>   	return ret;
>   }
>   
> +static void cleanup_ordered_extents(struct btrfs_inode *inode,
> +				    struct folio *folio, u64 file_pos,
> +				    u64 num_bytes, unsigned long *bitmap)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	unsigned int cur_bit = (file_pos - folio_pos(folio)) >> fs_info->sectorsize_bits;
> +
> +	for_each_set_bit_from(cur_bit, bitmap, fs_info->sectors_per_page) {
> +		u64 cur_pos = folio_pos(folio) + (cur_bit << fs_info->sectorsize_bits);
> +
> +		if (cur_pos >= file_pos + num_bytes)
> +			break;
> +
> +		btrfs_mark_ordered_io_finished(inode, folio, cur_pos,
> +					       fs_info->sectorsize, false);
> +	}
> +}
> +
>   /*
>    * the writepage semantics are similar to regular writepage.  extent
>    * records are inserted to lock ranges in the tree, and as dirty areas
> @@ -1492,6 +1519,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>   	 * The proper bitmap can only be initialized until writepage_delalloc().
>   	 */
>   	bio_ctrl->submit_bitmap = (unsigned long)-1;
> +	bio_ctrl->last_submitted = page_start;
>   	ret = set_folio_extent_mapped(folio);
>   	if (ret < 0)
>   		goto done;
> @@ -1511,8 +1539,10 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>   
>   done:
>   	if (ret) {
> -		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
> -					       page_start, PAGE_SIZE, !ret);
> +		cleanup_ordered_extents(BTRFS_I(inode), folio,
> +				bio_ctrl->last_submitted,
> +				page_start + PAGE_SIZE - bio_ctrl->last_submitted,
> +				&bio_ctrl->submit_bitmap);
>   		mapping_set_error(folio->mapping, ret);
>   	}
>   
> @@ -2288,14 +2318,17 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>   		 * extent_writepage_io() will do the truncation correctly.
>   		 */
>   		bio_ctrl.submit_bitmap = (unsigned long)-1;
> +		bio_ctrl.last_submitted = cur;
>   		ret = extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
>   					  &bio_ctrl, i_size);
>   		if (ret == 1)
>   			goto next_page;
>   
>   		if (ret) {
> -			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
> -						       cur, cur_len, !ret);
> +			cleanup_ordered_extents(BTRFS_I(inode), folio,
> +					bio_ctrl.last_submitted,
> +					cur_end + 1 - bio_ctrl.last_submitted,
> +					&bio_ctrl.submit_bitmap);
>   			mapping_set_error(mapping, ret);
>   		}
>   		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);


