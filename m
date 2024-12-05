Return-Path: <linux-btrfs+bounces-10064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CC9E4C82
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 03:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE6C2867F1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817E18BC1D;
	Thu,  5 Dec 2024 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gsdX6V8r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A46185955
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367083; cv=none; b=pqhTBAhAC78U9esb4QwmYtNDYVE/qfEMRuSb0GVPV5fx/C1NCghlbWAmfZCgpUql7KR/fd8hsNS/QQBwCEHVo1FKRve8/fGj4z7TtM3BruAC/LzF/orEo32fnS6Vyf5tyheP22tYQcxP+h/sENVvj279w8EaEuwIrSXAg439SdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367083; c=relaxed/simple;
	bh=C6QIeV4sx+z3ZpTwPXvgteXpZ2czYEC24/RTEClQnvY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sqj6X9UPMsI7FD3i5RhAqSn0yWQ1I8m8xU5JBCMYiPXJ2f8hhuui+HhSIKSMRKMngnhC9SV6Qc2y4MZ+CaIb+XWXM7NertjqiKMLwqHWt3PMRaaWUSCLnmgHU5nFAz7XK87tgGpRYZVGeen8mtPFGO0HbLqta3CCAKQvLqOcnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gsdX6V8r; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso203878f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2024 18:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733367079; x=1733971879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V4vSeKosLeQm03elmc976Gn4TxLq2sgRQtGDwl9H/vM=;
        b=gsdX6V8rGqSDBh4afADb3ikvY5G9GW5AKVtqnxKCpsB5GrV1oAxjqC/IiukKnawea+
         RIS8VhxW0xR2IUDJKKWfM6lIuuDY67SXFr9qzPUTSrRZyE3yr4dYaaQFmnu94McR7m1m
         /+3Sx5Anv7KZZmGcexnKZybq9dqUBZ8SKH9qJFcSP1vndMtn9pkGllwg+p4O28tXthn7
         jX+yn/bljHFaw8xjzoHF1AXEj6hhHwWKc/9iixL2NoTj88vsgaM6TGZKLF6bnNQQwT6U
         MsBMhr6UULyWfMKGxJBXRHBiPQ94SAHP3TDB2qWq69k7BB2H2om4A/fb1JfiaVF4kfFa
         MY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733367079; x=1733971879;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4vSeKosLeQm03elmc976Gn4TxLq2sgRQtGDwl9H/vM=;
        b=jHcfsZYMA6u5Q7riiQbinRCKdlL2kkNo4ETFj3GSuHIXMYxURJw9c8xlHozBZ3nD73
         NVvdBKYlz7TK2ISKXl23KCb6n+h1SUPw8P5bBQC9KtMfojiffpQpjLyN65JDzF/k0TNg
         5aM7hKJz+M7af8rIsVKt+pF6DnSYWRRNdLhhfcrewNvsB5ywhisWYmo+SsWjWKfYcVWG
         i15vbSkufc8HPmOCS93rvLCPDLpGgsOCJjXclujVtdS1sXEGSHSel9NGYg76i4zTMEo6
         t5zBsGvWJ6HGfXsQekV36TdvtMtZH/bAh0xnbTmAyP/+e1QzpqcitwAbSGWfeM4Dk+fe
         AhQg==
X-Gm-Message-State: AOJu0YyyZQbWS/pGOVBx6Himm7lnBoqcHugGYYEqEY2HHMY+pfu2Gjn1
	59OFk0GL7C3Ktbdw/iA+hQ3+ldBylhu9Tn93z7eTtdmh+URBSIztClB9fhUT5xpoOxY+E2oX85p
	c
X-Gm-Gg: ASbGncvTJX7BkdMGwS9gPlvIZGqUqWlncDvJwoS716XoVfZD0PQvaROBKSxDspxDt+Y
	ShBq8MD3N4Wa6kW6+gqEU5MBI9rD6Msgjg34yA/tL6nKT2JsV4e+m/MwWkaiUqpOjQ4z2aXgwjP
	i9Y6Rx+mjEGuBWq1Z6AGrtsumrrzWawHEmuIrNStMsyUhGdAAF/4on6bHboYYnHJM07RfuAwLIQ
	faQoknO5GbSOqwMrOTJ85nW9jStSUZToG5KjzhbBAlkyQlOBLEuKd4+XwVDXPY7rD4jTG5Nhbf+
	PQ==
X-Google-Smtp-Source: AGHT+IEGzGbcGGnipQtp0Gqf+Qs+liOMGDndQRILLskdfgQLymoy2Wt4bUgXn31B6wdglMHM56lMmw==
X-Received: by 2002:a05:6000:1866:b0:385:dc45:ea06 with SMTP id ffacd0b85a97d-385fd3e7b28mr8040302f8f.13.1733367079082;
        Wed, 04 Dec 2024 18:51:19 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157ad524sm261711a12.62.2024.12.04.18.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 18:51:18 -0800 (PST)
Message-ID: <627a9d4b-a358-4e5b-a8e7-cfd6ba0298d6@suse.com>
Date: Thu, 5 Dec 2024 13:21:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do proper folio cleanup when
 run_delalloc_nocow() failed
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
References: <3e5d5665ef36ee43e310be321073210785b89adc.1733273653.git.wqu@suse.com>
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
In-Reply-To: <3e5d5665ef36ee43e310be321073210785b89adc.1733273653.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/4 13:05, Qu Wenruo 写道:
> Just like cow_file_range(), from day 1 btrfs doesn't really clean the
> dirty flags, if it has an ordered extent created successfully.
> 
> Per error handling protocol (according to the iomap, and the btrfs
> handling if it failed at the beginning of the range), we should clear
> all dirty flags for the involved folios.
> 
> Or the range of that folio will still be marked dirty, but has no
> EXTENT_DEALLLOC set inside the io tree.
> 
> Since the folio range is still dirty, it will still be the target for
> the next writeback, but since there is no EXTENT_DEALLLOC, no new
> ordered extent will be created for it.
> 
> This means the writeback of that folio range will fall back to COW
> fixup path. However the COW fixup path itself is being re-evaluated as
> the newly introduced pin_user_pages_*() should prevent us hitting an
> out-of-band dirty folios, and we're moving to deprecate such COW fixup
> path.
> 
> We already have an experimental patch that will make fixup COW path to
> crash, to verify there is no such out-of-band dirty folios anymore.
> So here we need to avoid going COW fixup path, by doing proper folio
> dirty flags cleanup.
> 
> Unlike the fix in cow_file_range(), which holds the folio and extent
> lock until error or a fully successfully run, here we have no such luxury
> as we can fallback to COW, and in that case the extent/folio range will
> be unlocked by cow_file_range().
> 
> So here we introduce a new helper, cleanup_dirty_folios(), to clear the
> dirty flags for the involved folios.
> 
> And since the final fallback_to_cow() call can also fail, and we rely on
> @cur_offset to do the proper cleanup, here we remove the unnecessary and
> incorrect @cur_offset assignment.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the incorrect @cur_offset assignment to @end
>    The @end is not aligned to sector size, nor @cur_offset should be
>    updated before fallback_to_cow() succeeded.
> 
> - Add one extra ASSERT() to make sure the range is properly aligned
> ---
>   fs/btrfs/inode.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e8232ac7917f..92df6dfff2e4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1969,6 +1969,48 @@ static int can_nocow_file_extent(struct btrfs_path *path,
>   	return ret < 0 ? ret : can_nocow;
>   }
>   
> +static void cleanup_dirty_folios(struct btrfs_inode *inode,
> +				 struct folio *locked_folio,
> +				 u64 start, u64 end, int error)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	pgoff_t start_index = start >> PAGE_SHIFT;
> +	pgoff_t end_index = end >> PAGE_SHIFT;
> +	u32 len;
> +
> +	ASSERT(end + 1 - start < U32_MAX);
> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> +	       IS_ALIGNED(end + 1, fs_info->sectorsize));
> +	len = end + 1 - start;
> +
> +	/*
> +	 * Handle the locked folio first.
> +	 * btrfs_folio_clamp_*() helpers can handle range out of the folio case.
> +	 */
> +	btrfs_folio_clamp_clear_dirty(fs_info, locked_folio, start, len);
> +	btrfs_folio_clamp_set_writeback(fs_info, locked_folio, start, len);
> +	btrfs_folio_clamp_clear_writeback(fs_info, locked_folio, start, len);
> +
> +	for (pgoff_t index = start_index; index <= end_index; index++) {
> +		struct folio *folio;
> +
> +		/* Already handled at the beginning. */
> +		if (index == locked_folio->index)
> +			continue;
> +		folio = __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
> +		/* Cache already dropped, no need to do any cleanup. */
> +		if (IS_ERR(folio))
> +			continue;
> +		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
> +		btrfs_folio_clamp_set_writeback(fs_info, folio, start, len);
> +		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +	mapping_set_error(mapping, error);
> +}
> +
>   /*
>    * when nowcow writeback call back.  This checks for snapshots or COW copies
>    * of the extents that exist in the file, and COWs the file as required.
> @@ -2217,7 +2259,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   		cow_start = cur_offset;
>   
>   	if (cow_start != (u64)-1) {
> -		cur_offset = end;
>   		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
>   		cow_start = (u64)-1;
>   		if (ret)
> @@ -2228,6 +2269,22 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   	return 0;
>   
>   error:
> +	/*
> +	 * We have some range with ordered extent created.
> +	 *
> +	 * Ordered extents and extent maps will be cleaned up by
> +	 * btrfs_mark_ordered_io_finished() later, but we also need to cleanup
> +	 * the dirty flags of folios.
> +	 *
> +	 * Or they can be written back again, but without any EXTENT_DELALLOC flag
> +	 * in io tree.
> +	 * This will force the writeback to go COW fixup, which is being deprecated.
> +	 *
> +	 * Also such left-over dirty flags do no follow the error handling protocol.
> +	 */
> +	if (cur_offset > start)
> +		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
> +
>   	/*
>   	 * If an error happened while a COW region is outstanding, cur_offset
>   	 * needs to be reset to cow_start to ensure the COW region is unlocked

It turns out that, we can not directly use 
extent_clear_unlock_delalloc() for the range [cur_offset, end].

The problem is @cur_offset can be updated to @cow_start, but the 
fallback_to_cow() may have failed, and cow_file_range() will do the 
proper cleanup by unlock all the folios.

In that case, we can hit VM_BUG_ON() with folio already unlocked.

This means we should skip the failed COW range during error handling, 
making the error handling way more complex.

I'll need to find a better solution for this.

Thanks,
Qu

