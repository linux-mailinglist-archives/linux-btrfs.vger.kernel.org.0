Return-Path: <linux-btrfs+bounces-14003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA95AB6932
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D0817AC88
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90582701C5;
	Wed, 14 May 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PYAVFWBP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8B25E453
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219898; cv=none; b=TbOlGdkbtOX3hHCns21OvyqwucZtJCYE5wBekEZmH6J5qJsuI/QPF9YWQvsmdH3pco9ZBHhGSgarlS8ihlICCJKpUtMrbCdNuCcAA2+mFLS3Y5KVh3pf+nzEvkvVgREtQvSGAZYaYf9+ydpjMoOpjpHU5wAJ2iKU1z5skLGkxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219898; c=relaxed/simple;
	bh=FTrupf31tG+mTRHcNWI2bupY1A/LJoqrj2zJBG7j1TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HnX2agCtzYl9TheBzOYmWIPUqUgsQmwyhQOWJI5R8wjzvsw0P3UdMMf7Qw3EokBeE4lnzlsN0HBGe9T6ZeH/7KuKWCa8mvvUEcxcfG+eeucn6+kkEk8hMdJD+58n1H7lpVo4I5uUH9j9Xc39BoPWgHdxo8tXCozNgVFhY7rNNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PYAVFWBP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a206845eadso2260077f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747219894; x=1747824694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KbnFR9I9B8Vg4O8p3vG8FCXX14ZMgXmZtGAR0i9PHps=;
        b=PYAVFWBPc7mIRQurT239NDXfNkScb52Ju9tjqAPqEC58c/pDB84XpM8LZhJkQ5bVNx
         HN4l55hmOQZ5akMLUw//iXNuvNY4T6dw+4PIR60tSKZHkqBorKrL8chkPDkYfgcoonCD
         W5yfDldbLmJtXkCUzNdipRVD3AIpk5I8i1JJrHCvUeaQWGyUdr/i9Q8HJYtsW9ulR0oC
         m4ZNJmngNZP4D6wnDdVZokjlWOWilVzwUb1gNJ78HKEhkw9LX4J1ocVkISsbt6CVVzTY
         Ut4F5enDMRuOrLdm396C5FQk7CVR7G0L5lXc0NlNWl+8DZb0e+qpHROnACXFkN9mBu2z
         VJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747219894; x=1747824694;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbnFR9I9B8Vg4O8p3vG8FCXX14ZMgXmZtGAR0i9PHps=;
        b=h4AIPKDKlfzdGA1tzoY91wrmNOz9JZamTwK238mn1qj9R68rQzA4LosnNoHFzwl+Xg
         2TZi09E6A0/jUcquGPppEHGK26i2iTbtFzsveaHDZSgsJa1CCFCwmkrAp6NTESxh1qw8
         lX2a9lrhtdG3F3782Ma3socwJFlSeoYjrzqL9aUVk6ZCcemOhi/RnFw+J5K4M9rP77L0
         D9Xlu1vw2D9Hrp9ugN1ykCQZKXiI/WvDvc1DXONW6abP09Z7X2VwM2b4vFu222uLQa5q
         3J3RBG+1gVbxhQGqoRgMtuhk3rsF58wgXGb7lVIepTBz/mXLhvt66AtY3splNawkDSr9
         ZjRg==
X-Forwarded-Encrypted: i=1; AJvYcCU8vFQE0C/kg/SmemDaISPWrFad8cRbpDAzwGVc6JfI13nMUoeHK+rr66yYgBNCGi3P5YIc78p+QxJPUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3oXhhg+mXLwZzEkEZprRhZxIM/w5OoFgMet+goshLKubQRGM
	lAMjSxLYWd2pjyTMEXpjhZ2OUwtqskUb3ZF0aZopKeoVm6jQitzFv4prIvJXI/S2hMQS+je6Xk8
	+
X-Gm-Gg: ASbGncsCzAtBUtJnIGetL24vwvyFTaLRpwT0StdC5uVO6qng9Is5DdqwWYNkzKNxInN
	G6X9xr47nmLprtf39fzkn8GLobU8saAzcs+mX9HyzE1DZFIifcsRCLfPH6Z9y5lGmTPN3wFqE6z
	s1XRSx6olCTVpy8DszqYOt9Lt/JWC1ex06NKHeS+kUOJ/foyEwiTGfLpLxANl6tnZQIyxqpf5qO
	XHhiZTu7n5f9fO5KpySIrms5Xwb3F+Ua6mjnG42dlzqTpCLzNgnvX7G1GQXa3ykuZmuIutvnhP8
	UxWsP0tNZhCNCMPfqgUV41EYcYaEsb+YC7gygnOaB0WVy0AE6GKJ4U0wkm1iBNW+lO58bHHi03i
	amQI=
X-Google-Smtp-Source: AGHT+IGyTaKwcbMUBo3cD4MCrYjrJYT3XUeGnwuWVmD5aGFXOy+AacvGsVlRxzQTTbwsRC8y6nQAIA==
X-Received: by 2002:a05:6000:3109:b0:3a1:fe52:e1cd with SMTP id ffacd0b85a97d-3a3496b7e34mr2316121f8f.20.1747219893980;
        Wed, 14 May 2025 03:51:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::c8a? (2403-580d-fda1--c8a.ip6.aussiebb.net. [2403:580d:fda1::c8a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33435b5bsm1265828a91.19.2025.05.14.03.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 03:51:33 -0700 (PDT)
Message-ID: <86e99ac0-31d1-40c3-ac28-ad978347da17@suse.com>
Date: Wed, 14 May 2025 20:20:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: simplify early error checking in
 btrfs_page_mkwrite()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747217722.git.fdmanana@suse.com>
 <fc9d7357ad819c2586a3ad42bc3e0f3486d577e0.1747217722.git.fdmanana@suse.com>
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
In-Reply-To: <fc9d7357ad819c2586a3ad42bc3e0f3486d577e0.1747217722.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/14 19:59, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have this entangled error checks early at btrfs_page_mkwrite():
> 
> 1) Try to reserve delalloc space by calling btrfs_delalloc_reserve_space()
>     and storing the return value in the ret2 variable;
> 
> 2) If the reservation succeed, call file_update_time() and store the
>     return value in ret2 and also set the local variable 'reserved' to
>     true (1);
> 
> 3) Then do an error check on ret2 to see if any of the previous calls
>     failed and if so, jump either to the 'out' label or to the
>     'out_noreserve' label, depending on whether 'reserved' is true or
>     not.
> 
> This is unnecessarily complex. Instead change this to a simpler and
> more straighforward approach:
> 
> 1) Call btrfs_delalloc_reserve_space(), if that returns an error jump to
>     the 'out_noreserve' label;
> 
> 2) The call file_update_time() and if that returns an error jump to the
>     'out' label.
> 
> Like this there's less nested if statements, no need to use a local
> variable to track if space was reserved and if statements are used only
> to check errors.
> 
> Also move the call to extent_changeset_free() out of the 'out_noreserve'
> label and under the 'out' label  since the changeset is allocated only if
> the call to reserve delalloc space succeeded.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good to me, but I'm wondering can we do something better by 
completely merging @ret2 and @ret.

In fact we didn't really utilize @ret except two sites:

- page got truncated out

- btrfs_set_extent_delalloc() failure
   In that case, we should use vmf_error()

In the out_noreserve tag, do something like:

	if (ret)
		return vmf_error(ret);
	return VM_FAULT_NOPAGE;

Now we only need a single "int ret" as usual and not need to bother the 
VM_FAULT* return values at all.

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a2b1fc536fdd..9ecb9f3bd057 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1843,7 +1843,6 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	size_t fsize = folio_size(folio);
>   	vm_fault_t ret;
>   	int ret2;
> -	int reserved = 0;
>   	u64 reserved_space;
>   	u64 page_start;
>   	u64 page_end;
> @@ -1866,17 +1865,17 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	 */
>   	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
>   					    page_start, reserved_space);
> -	if (!ret2) {
> -		ret2 = file_update_time(vmf->vma->vm_file);
> -		reserved = 1;
> -	}
>   	if (ret2) {
>   		ret = vmf_error(ret2);
> -		if (reserved)
> -			goto out;
>   		goto out_noreserve;
>   	}
>   
> +	ret2 = file_update_time(vmf->vma->vm_file);
> +	if (ret2) {
> +		ret = vmf_error(ret2);
> +		goto out;
> +	}
> +
>   	/* Make the VM retry the fault. */
>   	ret = VM_FAULT_NOPAGE;
>   again:
> @@ -1972,9 +1971,9 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
>   	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
>   				     reserved_space, true);
> +	extent_changeset_free(data_reserved);
>   out_noreserve:
>   	sb_end_pagefault(inode->i_sb);
> -	extent_changeset_free(data_reserved);
>   	return ret;
>   }
>   


