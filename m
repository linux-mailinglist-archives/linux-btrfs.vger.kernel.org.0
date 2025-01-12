Return-Path: <linux-btrfs+bounces-10926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F3A0A7C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jan 2025 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3243A89C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jan 2025 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DBA17F4F6;
	Sun, 12 Jan 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VA+4MEh2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280646B5
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Jan 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736671106; cv=none; b=Ec3QS7j0cZ9v17UDacZEHIjD24jBUj35aMu5WOleg6faCqIj0RNWeLFL9lwE4boe42ukUFDpHWJLEmGVs096MRU9snUdyzNwdhno09vdigDG7QRp6hMSvx59Ob3B1R0O8jkZJ9drvZbvBjtJ2D90FXtpR3EXLuTZTUVfgYio+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736671106; c=relaxed/simple;
	bh=muF2fOL3J/+r2dLF+Eq1AN+W3KROkKUeOSsECW7t1sA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=XN/3Xvrn1pItTE+54OSoCHR0F5RHlvWabxQtf7yFbHIyfVV3/ypFywj9pEVSnvVF6gEYM4I48+xNs7O0+W9zeArysOD0cYI4IdwRcKpZL7alAfGbSTZtSlhzMpamgekaT66EcKNPTI45cxABHrLqDnx0q28klhEGV2Vhkl2/Vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VA+4MEh2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so8580874a12.1
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jan 2025 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736671101; x=1737275901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwnZlmRBiv040m3Iv4mvZBPjpE1JcjuFWRtxlbPaoV4=;
        b=VA+4MEh2VapS6tGVkVplKYM5YEQxmeY/9IZ216QFTfpqJ/jb6ac7jSQ9o/tqERFhBF
         4CwzNusMZ3qcNXjox+JHHgz0gZzVlhUMEgV5w9IavtbunJqEB4pMruRDdqLEm6QeT+eN
         D8QKu/dmQWnHBUzlDRBWJ/XLQCyQGMsPzzXf7WZYje6wzJjaPErwuJzviihyxBZSgKoj
         qkOFhBMvYFgK0PWXFUwE0PuvTgZjz7KUxoCh0YRUzCdx1iQSs7/qxae0v2qSxeGHZ0wX
         DAr0qR1/ticMrIXRmz+VtTn5WSuPKYn7ygpLWis6Qv8+JXAeKtSw2nE2lnKYVdTDG46Q
         yFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736671101; x=1737275901;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwnZlmRBiv040m3Iv4mvZBPjpE1JcjuFWRtxlbPaoV4=;
        b=Y6M49Jag5siCRKlC6ZC1TthwOpG8jhDt7mBfLrqUIFnkzxX3gRAEqBWh+TG+X0p6Nk
         Zj25bTWvPP5ZRdSORNuc7tcDT5Oba7tKBiQBohUKq51GmDXozc1FQxiFd6fiNMsKI1XO
         aFyzSgEPzklURIDYp094/bQ4focPhBa1e+2fwK0msRxCy0WWn23YG+tg3cd5+3t0/gYi
         3+FEzUVmHqJgcGZ8KFFscB8xtsWvuGOccw7m8akz5d1Us/HYQYrVhHQDzg2r9gvlRRYU
         Z9THAnDw9XUb93Daw5T98PsVsjVt0lrrUp5PpUzYR+2/LtqQtzrSZne6G2bRnOFRPGik
         dL2Q==
X-Gm-Message-State: AOJu0YyRdNhpHgAg4WO3JPlq6y+qJwNsEYXEyRQ+fRXOt9Vs4y0U0IRB
	d6sH0bnKGHsrw+JAWdUmxMDxEpFbPKhb7Xfh2kUO73e2l0J9n/XfqCJF3TE51xueEz8oaBFoOVf
	y
X-Gm-Gg: ASbGncsMf+mAu0lypi3FPXNJ+FfBF7xE6J2CBG8sl3EnFgvh3JAiOuU9oDbgXcSIx/Z
	oXw3LYNBCUBa7zEY/+K4PA4Hhq+8PJpwVVXJm/eSAqc0lxh+TS7xWWdpLbgpY/vGozMStawKJcl
	ghSc2qiWrgJvzN232P4jt/mXHidJF6+49byRA7NNylsl3J5sU41KHdEKDUYYB0DtgykSnlhYkRg
	p+oKGs0XRT8rQgQk4pm70PmrVCx6QgtObryCZPA1AyLHqV/REIjvyQ7sKrcTbONJqo+Fm/YsNX8
	N/xzivtt
X-Google-Smtp-Source: AGHT+IEnWRfJ7+VOA98gCfkzO2dEZXD1/9dg6UYwF5zJbqV2yITLv5WacglPdIrgAEY4gOIF/pdXfQ==
X-Received: by 2002:a17:907:7210:b0:aa6:9540:570f with SMTP id a640c23a62f3a-ab2c3c7dbfemr1122336466b.18.1736671101168;
        Sun, 12 Jan 2025 00:38:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4054890bsm4136780b3a.17.2025.01.12.00.38.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 00:38:20 -0800 (PST)
Message-ID: <2f2129c0-159a-4341-91bd-d4d4b220ccaf@suse.com>
Date: Sun, 12 Jan 2025 19:08:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] btrfs: move ordered extent cleanup to where they
 are allocated
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1736591758.git.wqu@suse.com>
 <9b55ff95921e88dd00413236390e7fd7561175de.1736591758.git.wqu@suse.com>
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
In-Reply-To: <9b55ff95921e88dd00413236390e7fd7561175de.1736591758.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I'll drop this patch from the series.

The run_delalloc_nocow() is really a mess to fix.

It has too many weird error path that can screw up the ordered extent 
cleanup.
E.g. in must_cow: tag, we can set @cow_start, but without setting a 
proper @cow_end, causing us much harder to properly skip any COW range.

I'll need a dedicated patch to refactor run_delalloc_nocow() to make it 
more streamlined to handle nocow and COW fallback (other than the 
current cursed way).

Thanks,
Qu

在 2025/1/11 21:13, Qu Wenruo 写道:
> The ordered extent cleanup is hard to grasp because it doesn't follow
> the common pattern that the cleanup happens where ordered extent get
> allocated.
> 
> E.g. run_delalloc_nocow() and cow_file_range() allocate one or more
> ordered extents, but if any error is hit, the cleanup is done inside
> btrfs_run_delalloc_range().
> 
> To fix the existing delayed cleanup:
> 
> - Update the comment on error handling
>    For @cow_start set case, @cur_offset can be assigned to either
>    @cow_start or @cow_end.
>    So for such case we can not trust @cur_offset but only @cow_start.
> 
> - Only reset @cow_start when fallback_to_cow() succeeded
> 
> - Add Extra ASSERT() when @cow_start is still set at error path
> 
> - Rewind @cur_offset when @cow_start is set
>    When we fall back to COW, @cur_offset can be set to either @cow_start
>    or @cow_end.
>    We can not directly trust @cur_offset, or we will do double ordered
>    extent accounting on range which is already cleaned up
>    cow_file_range().
> 
> - Move btrfs_cleanup_ordered_extents() into run_delalloc_nocow() and
>    cow_file_range()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/inode.c | 58 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 130f0490b14f..70ef7f59b692 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1272,10 +1272,8 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>    * - Else all pages except for @locked_folio are unlocked.
>    *
>    * When a failure happens in the second or later iteration of the
> - * while-loop, the ordered extents created in previous iterations are kept
> - * intact. So, the caller must clean them up by calling
> - * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
> - * example.
> + * while-loop, the ordered extents created in previous iterations are
> + * cleaned up, leaving no ordered extent in the range.
>    */
>   static noinline int cow_file_range(struct btrfs_inode *inode,
>   				   struct folio *locked_folio, u64 start,
> @@ -1488,9 +1486,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   
>   	/*
>   	 * For the range (1). We have already instantiated the ordered extents
> -	 * for this region. They are cleaned up by
> -	 * btrfs_cleanup_ordered_extents() in e.g,
> -	 * btrfs_run_delalloc_range().
> +	 * for this region, and need to clean them up.
>   	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
>   	 * are also handled by the cleanup function.
>   	 *
> @@ -1504,6 +1500,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   
>   		if (!locked_folio)
>   			mapping_set_error(inode->vfs_inode.i_mapping, ret);
> +
> +		btrfs_cleanup_ordered_extents(inode, orig_start, start - orig_start);
>   		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
>   					     locked_folio, NULL, clear_bits, page_ops);
>   	}
> @@ -1980,6 +1978,9 @@ static void cleanup_dirty_folios(struct btrfs_inode *inode,
>    *
>    * If no cow copies or snapshots exist, we write directly to the existing
>    * blocks on disk
> + *
> + * If an error is hit, any ordered extent created inside the range is
> + * properly cleaned up.
>    */
>   static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   				       struct folio *locked_folio,
> @@ -2152,12 +2153,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   		if (cow_start != (u64)-1) {
>   			ret = fallback_to_cow(inode, locked_folio, cow_start,
>   					      found_key.offset - 1);
> -			cow_start = (u64)-1;
>   			if (ret) {
>   				cow_end = found_key.offset - 1;
>   				btrfs_dec_nocow_writers(nocow_bg);
>   				goto error;
>   			}
> +			cow_start = (u64)-1;
>   		}
>   
>   		nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
> @@ -2229,11 +2230,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   
>   	if (cow_start != (u64)-1) {
>   		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
> -		cow_start = (u64)-1;
>   		if (ret) {
>   			cow_end = end;
>   			goto error;
>   		}
> +		cow_start = (u64)-1;
>   	}
>   
>   	btrfs_free_path(path);
> @@ -2249,25 +2250,40 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   	 *
>   	 *    For range [start, cur_offset) the folios are already unlocked (except
>   	 *    @locked_folio), EXTENT_DELALLOC already removed.
> -	 *    Only need to clear the dirty flag as they will never be submitted.
> -	 *    Ordered extent and extent maps are handled by
> -	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
> +	 *    Need to finish the ordered extents and their extent maps, then
> +	 *    clear the dirty flag as they will never to submitted.
>   	 *
>   	 * 2) Failed with error from fallback_to_cow()
> -	 *    start         cur_offset  cow_end    end
> +	 *    start         cow_start  cow_end    end
>   	 *    |/////////////|-----------|          |
>   	 *
> -	 *    For range [start, cur_offset) it's the same as case 1).
> -	 *    But for range [cur_offset, cow_end), the folios have dirty flag
> +	 *    Special note for this case, @cur_offset may be set to either
> +	 *    @cow_end or @cow_start.
> +	 *    So for such fallback_to_cow() case, we should not trust @cur_offset
> +	 *    but @cow_start.
> +	 *    For range [start, cow_start) it's the same as case 1).
> +	 *    But for range [cow_start, cow_end), the folios have dirty flag
>   	 *    cleared and unlocked, EXTENT_DEALLLOC cleared by cow_file_range().
>   	 *
>   	 *    Thus we should not call extent_clear_unlock_delalloc() on range
> -	 *    [cur_offset, cow_end), as the folios are already unlocked.
> +	 *    [cow_start, cow_end), as the folios are already unlocked.
>   	 *
> -	 * So clear the folio dirty flags for [start, cur_offset) first.
> +	 * So clear the folio dirty flags for [start, cur_offset) and finish
> +	 * involved ordered extents.
> +	 *
> +	 * There is a special handling for COW case, where we advanced cur_offset to
> +	 * the COW end already. For those cases we need to rewind the cur_offset to
> +	 * the real correct location.
>   	 */
> -	if (cur_offset > start)
> +	if (cow_start != (u64)-1) {
> +		ASSERT(cow_end);
> +		ASSERT(cur_offset >= cow_start);
> +		cur_offset = cow_start;
> +	}
> +	if (cur_offset > start) {
> +		btrfs_cleanup_ordered_extents(inode, start, cur_offset - start);
>   		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
> +	}
>   
>   	/*
>   	 * If an error happened while a COW region is outstanding, cur_offset
> @@ -2332,7 +2348,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>   
>   	if (should_nocow(inode, start, end)) {
>   		ret = run_delalloc_nocow(inode, locked_folio, start, end);
> -		goto out;
> +		return ret;
>   	}
>   
>   	if (btrfs_inode_can_compress(inode) &&
> @@ -2346,10 +2362,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>   	else
>   		ret = cow_file_range(inode, locked_folio, start, end, NULL,
>   				     false, false);
> -
> -out:
> -	if (ret < 0)
> -		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
>   	return ret;
>   }
>   


