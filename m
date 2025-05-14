Return-Path: <linux-btrfs+bounces-14020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF70FAB777A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 23:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1204A0AB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B21F5434;
	Wed, 14 May 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dGM1lwHO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBAC8CE
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256474; cv=none; b=annqvkZiM22DfGf7uDAvLPlDXs3vo77AxVZ2qpUQmoI6037rK71P9N/h6gD3MZTqeUhh3qhyZkUQQHoY/a7Zs4qaxHE/H/XTLPS4f6O0HDso9mf2aKjhRU0eYAe3m949zC1pOb8i1tcz1KFIO7+V+G/AItZEM6jtURFjFQIy0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256474; c=relaxed/simple;
	bh=e8bGBQFFcHxkuV9htApyoGgZNWtyhesu1licY/H+i0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j0OzTz4U6TKn/g96Fi0tqdQF78oIIt0S/vbsD3oWH+iRidR8X3kXW+td/F6CE0c9/Rly93ENX3od9qm0sI4SSrDzBS0srISFR4+no4yIfaCHFnA/gub+fMRA20glfhf2+w6Lq4U22WrMg28bvUzcgLKoYCF4yOi0Pg1ladTtw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dGM1lwHO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a1fb18420aso202762f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747256470; x=1747861270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eVBkA21ITsYGIhoUTCzu9bXe5//IWEAFIsjIpmNbvtA=;
        b=dGM1lwHO63kR0twdbUVET9bF8UNCIQ468MoThHSoM3lGJWPeugU7oZJCTUYAk7wCFP
         ZTTz1u479KmJJEXNY38nQJo1GrgToPWerE2Kv96BO068C1VKPlCNLH9AUpXC1nUI6Iog
         DW/kjW4SLr2M4SnZVbNLqDjdLwiNd+vIJuyLF+evQ6uYxHTZEoP1EpjqplArDYCdHPcU
         zwnqdELafKE/gRHVFcr0dG6j+W9xXW0PPZtjBdtJs2x9ufei9SEx9c4ii+EBvqYLp19l
         4EiCkIHnh+IK/o3Vb0jBCO0u/ESS6aUfYga2G1gihdpuGrn3Rd+/KLY5AnP8vkB2WnZN
         Mq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747256470; x=1747861270;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVBkA21ITsYGIhoUTCzu9bXe5//IWEAFIsjIpmNbvtA=;
        b=i3JxHFduF9DIMpixEzG8Etaaw3AIJ6+EUlYSt3EMLf/Fuy3qiXKkshWvZJwxTkKhAr
         bjtMUBCeDK4DlgukQUXRJBUe9ScG77NZxVBUUSzyUidLbQCdoHfOsKzqgGI/YYq8AE4H
         uSQj6yMy/7qXyYerGCL/NKB63IlPV3WQA8DwJm9ezzjS4nOYRSvy9d1FqhWmPwE6yfgL
         6NQ5kBp+rGQqL8ym4qv73o3Nt1Yzqb3mcgvo6DM05lwzm3jv5P99OZyhILLZaT7SzA33
         TjZ9CU4VswGWOBX8Io9CstRBfA9QSsCzH+VyU7Nb8VflZnY/YAM1EsZQW9fjpZxVDjn5
         u5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXjmyoAHsA9AxWuWqmucBS/h6okz2aP0EKuqiEr+7qTBLspMwSK8ecr0n0OVGqUSKJvG2Q+fSmYOuhDJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8dT03IDtg8rAo0rL3KHJUKP+6YkDUA2dUH2bEw1Mrx3bHg83
	156CReszC9lApktK7nUHzi44Y0pCtzxfGjuhKuITJx75sSq9/5BJjsVM6zIPdMJZPc+qZgPvnxI
	f
X-Gm-Gg: ASbGncvJuPlKBa+itshxLdIfmyun5qQWum1QsWBd+YIHfgW5oL3/Hk+mgRy22kxDUrH
	069e3qRcdww6as/r2MVW7MJKLE41vIbQDQGNbvug5nETWfm9GjIxzDyn0dWpEhcKrM3aQwqTk71
	mmvAbjhXw9z3IsI14FHc8Ou6q+OymwOqG0UlmiC4EDQGQldotNNwF+yTLKS8EkbPAQHx6rliPh5
	JRvBf4ACHFCY4O6j8cqKI9TdsifGu3ac/JSYm0qRId68mzzL5OA+fmyoqENJJ8SzOwGlDnVJGze
	9JGEaHbrWdmzVk0rsVeaRBWQaVwdXS8dZmmcCxxBnFx88pTdq7wIESLSBCko2sws2mCYkFRR0TE
	YtIM=
X-Google-Smtp-Source: AGHT+IHPcvLoSGU3PSnQfykrAMEq9bUHD6mS0275tUV4YybiN3cidVVclngWzKi4Pnq96wMXK7+diw==
X-Received: by 2002:a05:6000:1a86:b0:3a0:b807:7435 with SMTP id ffacd0b85a97d-3a349922ddemr4482145f8f.40.1747256470363;
        Wed, 14 May 2025 14:01:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544f81sm103624245ad.43.2025.05.14.14.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 14:01:09 -0700 (PDT)
Message-ID: <f7d7d87b-e147-453b-8850-4030c1eacd56@suse.com>
Date: Thu, 15 May 2025 06:31:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] btrfs: simplify early error checking in
 btrfs_page_mkwrite()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747222631.git.fdmanana@suse.com>
 <401500c0e0108d519a4b5b5910c8678723885ed1.1747222631.git.fdmanana@suse.com>
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
In-Reply-To: <401500c0e0108d519a4b5b5910c8678723885ed1.1747222631.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/14 21:08, fdmanana@kernel.org 写道:
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

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu> ---
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


