Return-Path: <linux-btrfs+bounces-14002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643ABAB6909
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0C53B2900
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41146270EA2;
	Wed, 14 May 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cnlxLxLG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252A270577
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219313; cv=none; b=mzuZpmQ+8Z+gFCOgjhplywhyDT+d+8P7tI/Td0nkmMUXQqoAchYypT25DTzRV7hmsKoTTA6gGS2eGJ4qluVzV0iE2uM6XvxNfZfUiDA2tHXPjCEREYxA/pJJDZ7AN9yguWaxJZYrFcRhhVoDkaTjx4efrlf1dAp26f2AOC/kGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219313; c=relaxed/simple;
	bh=gjt1SI1xQrUuk0/1T8x5v39htPaOkQiyOBD0fvbDpaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OVR7FwSAudJTrZJN0HNp2wponiVvAVTR0hSOH3nDHTgJPXIXLNNbq/E36teU8mlYWqwivJiPqKAsKNGJ1FNJJWk4evkqlCENA7DlPFsLt/2erVica6Q0VPvAD6q6GkrF62y9LPa4XVGInAGAUVWNiSy0PCeBKLK1vOd4U252Tco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cnlxLxLG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a1d8c09674so3796136f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747219310; x=1747824110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0cQxBKGoL7KryQ4Ps3wm3vWz2ZDMiO+9vzk4el+I648=;
        b=cnlxLxLGqkHNuKJtajPfaH9MYutKCYw12hoIUFJ7/+rr2AK/3OlEe7hbmN3SiunzHd
         o8x1iqjv2m2au+ymQcTxbhU9OERsNqfeFFVMmZYLMenHYC20fvR4PGnRnLVx9b3SU7xo
         a+4SX97J8kjkSvRCkiXlJlhrfdI2V21DE+Vd7+lZPDlPeeALdbSejddZvsdK16No/rI/
         QxdbCsurHPg6fPSLN8NmduCgcIhTz7KeKvAVGI/QVuGPhckn3+B873biG1vkYjIVqq5X
         g+l7AIndJ02SkQCyVHF3ZjP1orVKq8600QJaDiFgoRk29lQrRnrzoTM8XgQ2zHBV0WvX
         Bi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747219310; x=1747824110;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cQxBKGoL7KryQ4Ps3wm3vWz2ZDMiO+9vzk4el+I648=;
        b=Xaq6F9+CuHfSJhCbSaccNMvHiedt0Xc0K5HqKPBqi9ooz29DI19m6XaZMEJdV1vIhn
         WOfsh2Tub+phXgFOOeHCfsdhepZZIA90hK/s7uoJXBCvXCBJ3p2J5cA7ASbGI3caozV9
         ymqolZLD7TZmZPc4A3VsxrEF1dU1sbC+6jk8KHjTjBUowujgncT5QzdD6bkwAMDocSLZ
         tZDZi5dnNGCQXswR/lZaR3lVldGtHA9jXkqjOt4siDXgoi6ZcNNZMzNZYEI62HLOxfdO
         mktE+MYFUIVkTymKp3sigWUwdAG4CrxplPSjsZfS46Mgb8z2mkcxySpp6K8OYUeNxEQs
         Gsjw==
X-Forwarded-Encrypted: i=1; AJvYcCWpU+l8FkIStOKV8t1r4Q79pieumLbzYUQrzlVZ7RTglgFbavSAb+yIGwWFPWoUmjntjecxeCMKH1hTTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEXqnzOBaLA0vQE0fv/uHVhtIu+8f97XzR5ErO55xxG3CtMJ92
	LTLl9WOkr/H87GIyq1NHvIUsFjzvmginYXUdsShrQyKiB90T5FddSl45Z9GxO1E=
X-Gm-Gg: ASbGncu4Jsw173z/Kn/32d58c1t6FnRznrxH+cjn03O05V9/HMLVNoLtkiUeF7/znm5
	MWMWCS2SddSN78uHcyiyl4iG2/jIseJwuM+YMwZr34HtG+uN243PfnsZ8K210sSjejs6XNU2Cbd
	dPk0t0Kp19rGEfjly4WEQ72YPS71tMuVIqCcdjEVzoKkfTuXc4z/UoFO5NztNgStooaX5UkmUzP
	l34CexwIPHk2juI4WMMmI/JHt78MIrd6Qi1Jih5GVqXE/wk1JCvN32A5b9uPEWFmWheI9dlqztq
	eBJW+TS3E0LYP4jdMUIl/1MFrD9oRpi630CXNL8moTPZFq2lrFf9rRXOSFvqwFAmzwFEWXxtm/h
	9XVY=
X-Google-Smtp-Source: AGHT+IGD0p60V8NbVwfCbuCf6sPWLEdUJpEpOmP/lI9KgGAstbtD4glUu0f7xBlg36xXUUzQzifuLg==
X-Received: by 2002:a05:6000:430d:b0:3a0:b72a:b1a with SMTP id ffacd0b85a97d-3a34994fd92mr2587774f8f.52.1747219309645;
        Wed, 14 May 2025 03:41:49 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::c8a? (2403-580d-fda1--c8a.ip6.aussiebb.net. [2403:580d:fda1::c8a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0cea6sm9595841b3a.92.2025.05.14.03.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 03:41:49 -0700 (PDT)
Message-ID: <f2ddaf26-5b88-4f80-afdd-590fa5305c55@suse.com>
Date: Wed, 14 May 2025 20:10:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: pass true to btrfs_delalloc_release_space() at
 btrfs_page_mkwrite()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747217722.git.fdmanana@suse.com>
 <b0fb503be36f4f51025b901b0c808412949b0a94.1747217722.git.fdmanana@suse.com>
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
In-Reply-To: <b0fb503be36f4f51025b901b0c808412949b0a94.1747217722.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/14 19:59, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the last call to btrfs_delalloc_release_space() where the value of the
> variable 'ret' is never zero, we pass the expression 'ret != 0' as the
> value for the argument 'qgroup_free', which always evaluates to true.
> Make this less confusing and more clear by explicitly passing true
> instead.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 32aad1b02b01..a2b1fc536fdd 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1971,7 +1971,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   out:
>   	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
>   	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
> -				     reserved_space, (ret != 0));
> +				     reserved_space, true);
>   out_noreserve:
>   	sb_end_pagefault(inode->i_sb);
>   	extent_changeset_free(data_reserved);


