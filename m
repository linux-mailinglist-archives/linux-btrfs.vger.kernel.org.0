Return-Path: <linux-btrfs+bounces-20382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D90D0FE4E
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 22:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43EEB30519FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7229D25EFBE;
	Sun, 11 Jan 2026 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gZUEA974"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF825C80D
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165597; cv=none; b=EjRJ+a6yzZIINeeI/iJCXDomC1BwITML+H6BycMkcAoVwRvNFRyvbV3lHADgsSgvVivvJZZJNkFYUvx5HSI4PbWicAclqutr/zjkFRDmblGKHtQ8o4m7Y2QgtQsJ6G6iJSJEplhSp9DDOvG5wvxXFlrM8ar7J5l2c2nROOdUg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165597; c=relaxed/simple;
	bh=CeacqnARiRuvydYDHLYo+juf/d+fsp/e6o0DV8dQqpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oWh88YQduKDGGBof+7hag/BsnyI8Eklp5E0MEsJqDnS6U5bUjh+gghbPAIkA9x/GISGMyufD5NqIHpYc7JFg6ze9A6EtsymneJ4iFp/xBBDe6onXJdhycYGs4tENb50Mah/8u2ZM/mvzkpGLKdTPP1FsOGYYX5w0daFyCGmY+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gZUEA974; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so54761525e9.1
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 13:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768165594; x=1768770394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NyuXrsbOv+abpxhinnbHt8G/nbosEdA2exTQ7iLAr4Y=;
        b=gZUEA974GqNiVyxF+e8/t62BjokX7w47JGZ8M6mRiF3OE8/QkGDTWNP/Ur736MZz81
         AHvqLL9dECnHF95DdT52YENZUSdhXEaXHB0DyyR29x6UlihXVWuf7mpVm+X5FohPvcJe
         utWR6j23+CAC3RuN/hpfqaSS2W5hUdBy5r+TlZExJaIfXWKvScfSiEPS+lc3AkN6Bu4k
         W6uz1JIW0k+Uu7B+mOo7YIm8reFqKKWJKTFAaiBsahkBMVsX2w9kJHmDgtItDS50cjbk
         hpmtfcn0zIlMktlecW2tbR2PWg08ejvT+tA8Pd/MJxz7aQkQ2csym8OoVecwFHMnJxIM
         J2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768165594; x=1768770394;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyuXrsbOv+abpxhinnbHt8G/nbosEdA2exTQ7iLAr4Y=;
        b=ONrf9fpCB716qw4RDUKY2qaGyd5GQAj+DJfrCNcR2KbZs4Jsn3nZp9CB3Jh7V3ljAJ
         Xuv6OAEs67x9mSZxu4Yv2VntEd99AIej1yf4PSr7rMYcDv1VNtAivNOQMQA09Y+XYW/E
         9l+ciRGESBeJrr8O5f8uSqjWLuNJ1jCPzamNaGVjEVmZT4fBVuvIwsz3Ou35iUqupC0B
         ww2p86nKBsxkU8YdJfoboWkvKxdZ3iyHTyZyWmKbKGE3C4CU2iv29k7J/wXte3ufRk5x
         mcTE+RZGjhCFw3Fj6SsxceqrO69UvbGPm2IyQHT3DWYzAzEm/fqW+O6e3LznhP4Dyayi
         lS8A==
X-Forwarded-Encrypted: i=1; AJvYcCViH2T7HdCS4/+kKaHeIyKXS/pC9PiTp5RQwN8tNVSjRSa4U2cuSuxLvpMD305IBH6qaytjA2H8/2tqxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRi3du3kzaNK9F5WArpfANyqT3BS4jP94fCQK4vM/UXUP/mCv
	fim48WBxUlWQg3qtFZfdxbj06l4GKDgu6RmjWP4FFL6NiMESgPhbcqHrlbOPONMMVZ0=
X-Gm-Gg: AY/fxX4zNoYTXCxk6kpocxei6BzdqiriI1NMsdX+kXpUl+B8sA5+7/c/BQ19OkOd3BZ
	5cwawB24o4hAIfDHq0qLlukB8hSS4DZrloU/1Y5yOJ9JMwcHO4geCdBJwBqHDqfQQZRACeLTZMb
	uKUsPMbxpn7Md4F1gfnlAhOguIKvcAdcM32J5fHat3VIoReHyUgvwD5BOCRIlLIbsQKjkeDTAPx
	xCbo1sKSOGkzCZobho8NO+FdvvLFBAOQNNc4uT8IAQfD9IZnTT4PQjHgWkySDNjwK++HJuX57XR
	hObpO3iRwD4gIdP9i03UP6DlHVzXAdXBUnlX44Bv64eey1GQ6ot+0BIeECTiUN6rE9XeK++iGsI
	ekLp/cl7BezKSTXObe8tJPKZo9dbphZSWc6KxkU+8N8GzT0ElclvWPBdfn+GMd9AbaKDwQ7mJj9
	UPoiUwMe0cUcjv7KmZMBRL7/gA5YdRuRjAmsPnSkxR4Qzw7h4cqA==
X-Google-Smtp-Source: AGHT+IHyaJfWuxxOmSUJl5EDgqOWbUE9Dh8lTQy7dHTisFSim8fZ6abZkKz3Y1kyLI7GabtQwl8WFQ==
X-Received: by 2002:a05:600c:630d:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d84b1fbeamr215216005e9.16.1768165594569;
        Sun, 11 Jan 2026 13:06:34 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c39fefsm156761025ad.17.2026.01.11.13.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 13:06:34 -0800 (PST)
Message-ID: <2539a74d-9276-4b82-8e67-80581ff7dcb9@suse.com>
Date: Mon, 12 Jan 2026 07:36:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix memory leaks in create_space_info error paths
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Jeff Mahoney <jeffm@suse.com>,
 Liu Bo <bo.li.liu@oracle.com>, Nikolay Borisov <nborisov@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260111192037.20932-1-jiashengjiangcool@gmail.com>
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
In-Reply-To: <20260111192037.20932-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/12 05:50, Jiasheng Jiang 写道:
> In create_space_info(), the 'space_info' object is allocated at the
> beginning of the function. However, there are two error paths where the
> function returns an error code without freeing the allocated memory:
> 
> 1. When create_space_info_sub_group() fails in zoned mode.
> 2. When btrfs_sysfs_add_space_info_type() fails.
> 
> In both cases, 'space_info' has not yet been added to the
> fs_info->space_info list, resulting in a memory leak. Fix this by
> adding an error handling label to kfree(space_info) before returning.
> 
> Fixes: 2be12ef79fe9 ("btrfs: Separate space_info create/update")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/space-info.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6babbe333741..3f08e450f796 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -306,18 +306,22 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>   							  0);
>   
>   		if (ret)
> -			return ret;
> +			goto out_free;
>   	}
>   
>   	ret = btrfs_sysfs_add_space_info_type(space_info);
>   	if (ret)
> -		return ret;
> +		goto out_free;
>   
>   	list_add(&space_info->list, &info->space_info);
>   	if (flags & BTRFS_BLOCK_GROUP_DATA)
>   		info->data_sinfo = space_info;
>   
>   	return ret;
> +
> +out_free:
> +	kfree(space_info);
> +	return ret;
>   }
>   
>   int btrfs_init_space_info(struct btrfs_fs_info *fs_info)


