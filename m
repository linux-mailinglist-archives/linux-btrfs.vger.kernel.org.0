Return-Path: <linux-btrfs+bounces-15231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E736CAF8282
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B54584AAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 21:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9767B2BE7C7;
	Thu,  3 Jul 2025 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fM9x0Xmt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B32BD5BF
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577257; cv=none; b=sZD1EyJ0iypYixXSVFAYxyQfJ+6rHvqn6r63mKLQtq9O4OPXV5jz48qkTEwHSdlira59G59dhg7i9kLxscAD/U41c4lEBRtMwByzPLyc6cW2O2DNjAeEzDcMmSrg1XYwiDK1QZHFpCjfupazD9AwiLg3pxdK5a8TK4PyleVHblI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577257; c=relaxed/simple;
	bh=7ZtsT7fAlt6dvtIqkaEdmTmfEynvhg8gy4XDqnx8LuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gWqAUceccRIqhoWU1KAA8DD7zUw2kgYC3FZFw5cD8FpBn3WzeTr4yaaEBuFKGQqt0ZlTvQtkPOL61wZ7vCyq+X01Y8M6b1Ky35EKR2ikeGkwGo7PChPpr9/P6gvTH/+I9FXJrHpsyIlTRN1vt8vNe6cduNX18CzRjChUyVggpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fM9x0Xmt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso10263805e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Jul 2025 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751577253; x=1752182053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6dhBI2hY9ot/tqwehbzjdHNoENiJJCRa9Aal8URpDR4=;
        b=fM9x0XmtW7x/pfnnd2nVfdI9iOeGdihwBrifEv8pLwSUh8eY3jof19NfkhIRBzEUQK
         kpl3FSB61cvD7VXdQLwJ9V1b07dFtNtSiSbLxV8TEhCxGFcMRx0eRDhYyCVE2wXro4mA
         Vlj/Ep3SQlZtQL/tJMF4Ru9b9Qv82vPDt2OPYhdag+VfRLWecLm/DeO1JRzWNJvhc6FA
         +GXf8GaE66rg8njMMYkAS272J1hl+eYCisyKeuLs5IgwVSMaXgxSc5XlrnG63YgXG1JC
         zp/MvlpeL4Y/8P6MMw4K2qitT1kCYjWY6rKcVf9eweANgk2BqkCTee4+GNC1b3DTCiLr
         KN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751577253; x=1752182053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dhBI2hY9ot/tqwehbzjdHNoENiJJCRa9Aal8URpDR4=;
        b=IB7k/p2AFAaTIicwwl/gmC7H60HRbLXyLE7z2Z5Bjb87MFUNt9tQ4eeh/QGHYDJ3gQ
         AUzMDynxmsqqhNqHj5sJodcPu+9XzU6GLGb/lTD6XrY8cXT21Ykjwo+mdL6Baiyq7F2u
         h1mPttRSdwyizsm0eP94NA5m5DGXypSPjsmx26w9V3sPFKu8oYdMcy7aFTCH9od1Ov17
         C8hkUEnWwaeQNXzN39xQZFb5Spwi3GHjTBVQQ3oYhbhJHj/No7WHKuh1wX0vVpKubI2z
         4Sir1+x8sTqxd0doCfVKh+dxrvkdT0CV8Gptmtw45eTIbd1FPYdHzaE/PO43L8wA/hdF
         YFlA==
X-Forwarded-Encrypted: i=1; AJvYcCU3O9w3gkHQWnisplHC8pWpEqDJgUyitXhkLoIJRYo4R8H9VCBN8O7PWdBJZvTv2f9kCMC3xadJ1GiOKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqqW0VkNEslyw5eqymYc/NJRLK/6MWnQijeuZBVOYvP+pBej7
	Wq3lu919mCgVefzPG7SnPC6+ihFarETtq80K1gdvIOLG7SoV9PsJOIyCVJ8yw2ZfawK8mFZZoEA
	2oi2d
X-Gm-Gg: ASbGnct7Gpo5q2JQ93C/hItVmAYOiyWXfdILWHD4tMq53KZclnl0JNZjVLF1Eo3gYuT
	22iRaQZq2uybs+ztwBXWjyPovgw5XkyiIBFv1vtP+x7tWMbMPM7sust000BR1QEmdJKQ+S6tbr3
	opiS4FvEfQIWAVtZxbO4G0aikkwdVt+uzNmVyhGNyHOmFnAft54VGo74hxVd2QJ0/ItsignJyUP
	znRPaxCan++iFMgjH4RZz2zypkrr8z44smw/Gcs9nPsaKd0y4eubVEdOU/mfR4I6NSsa37BrErs
	YnarLcNV3UXMANdBaevtrYodTg3obRczQPHyGOIQRVS+8BDDJ4CTrU5g2CNwffn6GIkYXwZa6PT
	V2bXa4LEo/D+DGQ==
X-Google-Smtp-Source: AGHT+IFoiUIxtzzCRAoesvgBp47Wbj2Qf+sZjwc7f964LYX5xdKBVnU0d6keqKvzsfhugZJeuM7Vmg==
X-Received: by 2002:a05:6000:2801:b0:3aa:ac7b:705a with SMTP id ffacd0b85a97d-3b493204a97mr369521f8f.11.1751577252525;
        Thu, 03 Jul 2025 14:14:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417de1bsm427264b3a.83.2025.07.03.14.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 14:14:11 -0700 (PDT)
Message-ID: <953389f1-f23b-43ec-88b1-dd66778d5393@suse.com>
Date: Fri, 4 Jul 2025 06:44:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: directly return strcmp() result when
 comparing recorded refs
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <30bcc022fde1071a86db10f10c984bddd87fcef9.1751558928.git.fdmanana@suse.com>
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
In-Reply-To: <30bcc022fde1071a86db10f10c984bddd87fcef9.1751558928.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/4 01:40, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no point in converting the return values from strcmp() as all we
> need is that it returns a negative value if the first argument is less
> than the second, a positive value if it's greater and 0 if equal. We do
> not have a need for -1 instead of any other negative value and no need
> for 1 instead of any other positive value - that's all that rb_find()
> needs and no where else we need specific negative and positive values.
> 
> So remove the intermediate local variable and checks and return directly
> the result from strcmp().
> 
> This also reduces the module's text size.
> 
> Before:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1888116	 161347	  16136	2065599	 1f84bf	fs/btrfs/btrfs.ko
> 
> After:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1888052	 161347	  16136	2065535	 1f847f	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/send.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 01aab5b7c93a..09822e766e41 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4628,7 +4628,6 @@ static int rbtree_ref_comp(const void *k, const struct rb_node *node)
>   {
>   	const struct recorded_ref *data = k;
>   	const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
> -	int result;
>   
>   	if (data->dir > ref->dir)
>   		return 1;
> @@ -4642,12 +4641,7 @@ static int rbtree_ref_comp(const void *k, const struct rb_node *node)
>   		return 1;
>   	if (data->name_len < ref->name_len)
>   		return -1;
> -	result = strcmp(data->name, ref->name);
> -	if (result > 0)
> -		return 1;
> -	if (result < 0)
> -		return -1;
> -	return 0;
> +	return strcmp(data->name, ref->name);
>   }
>   
>   static bool rbtree_ref_less(struct rb_node *node, const struct rb_node *parent)


