Return-Path: <linux-btrfs+bounces-13406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22D6A9BAED
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 00:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398894C25B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C12289343;
	Thu, 24 Apr 2025 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LmUBHrp7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917B14E2E2
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534509; cv=none; b=HRMbLokiUuUQNVipsT3MBUPPtEJbbOLNtG29geCxKqyLT20wyXyTeV44EtbxUaoqk36bOrto2jHsTFMIkLlEi4otpQFig/4VA6Zg7YI0Y+wR8fRD+lfK2qlyGzZpWv1r8ZIY+7BbaveMl4JjafBRZLzT8Oh+a0V8xNDFe8ensnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534509; c=relaxed/simple;
	bh=z8wC+I3okJUSLIMlh0lw3OyLYY9248nmCXzB6Lb8htE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RXTSCd9JA0sE6b6Xnn8iX0RSjOpNg3yrUa+USDenEpzG9RLFKHSBkMp5kdGbiYV9s6opPz7ZyNkM76tslC6Pt38BOTe/YDr48iSkZLLEdeGQKkqFtEkWMoiqOjMpKT65S+VMqHjjH5fAfsXYrLSAirs3ExVTk9cfq/rNK7UXO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LmUBHrp7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1867146f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745534505; x=1746139305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mzst3xGoHw6hfW17udYBeWKBfs1mWsIdz0iMUHH+3VI=;
        b=LmUBHrp7sf8GmqaG1f3Xd3GEMsuSON8+S756+ELQtseLR0eTyJyOjcw+qtaikzSZ/0
         6EPBXdASKlPjVejvpkItbw3rJUvf4c9UU/K1MXIoMYgqmRhRexm6AAVAJK8u/d9Qnybe
         yQJuEnvRCWQrw3KhUce4cxDXaJ6QZR5+wsur4Seb2cG2qQvKDeFuHwm2JwTqQkZy6Y/z
         3xLva9x3F92h4y6/hzsp8WXkZfcyhGxUn7/qzFa1eVoTqEou7+GZKCzKyVAK66dj7xFB
         MQs9h4Pku/uqWQzKR2L2yaFOk2noKIrFHLRZHGiaVuMIJCxYXSBtCG+CRJ9/oeZgDXr/
         RXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745534505; x=1746139305;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzst3xGoHw6hfW17udYBeWKBfs1mWsIdz0iMUHH+3VI=;
        b=JRReB5VrT/rFTuPdip3wVDvO2fncXmXTF0uhx/9bfFNsBmf4FvvmrnYM4iysnMMl0L
         AJ/pVnr2jjBN+UV9dS8TgsCACZU5vZrp9qwm97CR/orhhKdPZiuOeh5WqXadOvGxDI1y
         DnxsSI/EiIX7NC8w5bSJumBaeVQGKDJkKe3r6cw3Y6GHddd00Ra02ydmwLqZGMrWAiZv
         PgY8rk8ijwi9iCIRMJf2K6e2xw0o2/MhXnz/0r+TBgrlP8lcCWS/39BcHn6bSuh/XBCy
         u8CK2f+VIzXm5Kw+sA666TS9u6WbQPgg82O+J+yOQeS0ko9uA3qDAgO4SD43bql0dGwL
         bfcg==
X-Forwarded-Encrypted: i=1; AJvYcCWh4DZ9Wz5AfVB8tzgF35M483xyppMUE8kcpnK+rmNhtURg5AG5bFQcabzYKLZE+8ptZIrtcH+Uan5XdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpBEKFkIj7vJOj8LSz/SUEzs9Bx81HHzL75A1YZZAbOuR10PL
	Rl++TSOF/QhBzULx5rWmeQ/Aq0mpB0qXLS8Xe+CG+U6mW7WrNhEyROhf5TtCNqKKgDtz/v8Vm5S
	x
X-Gm-Gg: ASbGncuqGQs8hF3t/+A1Jjp6/8BwtXXsECR8223RBd3nGcywdsdyx4jrLl1ZzYSBkCo
	CgOv7RpRBOCChyLuRUj16N+gBmFddJpHrWIKatJfgaqC/SEU3ZvzK+cHuXct5P74IPEG7cj+xl9
	uF2yY3Tu/OZ0x88rH1LjWRLveeZpDylAs+GOzQYeHTkCiUm77iVD2jytHXLMa+tdgJ5NSRI1xPP
	c05vGPGtno5cFZdzXQZjDswi3h3RKrG6PeYNQ4IzO3QBbEz7xV5KCDmZihJI4TMRF+ad1IBQ+JG
	3iUKsFU//OjnTM4TvtfM0N4Ty3hPTSFxhdYSAn5/eqvj7L2CXruLdkNg/BZyeRDZbDnr
X-Google-Smtp-Source: AGHT+IFoJWZ524SIyL37Ch+ujG3T9O6FIV12WU7B3juU6RpxnFnZbW2+j4cOUjVNYDnTXd8BIwW3Zw==
X-Received: by 2002:a5d:47cc:0:b0:39f:bf3:6f21 with SMTP id ffacd0b85a97d-3a06d64cab2mr3337997f8f.11.1745534504806;
        Thu, 24 Apr 2025 15:41:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db9b02sm19113045ad.56.2025.04.24.15.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 15:41:44 -0700 (PDT)
Message-ID: <9b32db21-e116-4eb5-9a54-7cc23a737523@suse.com>
Date: Fri, 25 Apr 2025 08:11:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
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
In-Reply-To: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/25 07:25, Boris Burkov 写道:
> If btrfs_clone_extent_buffer() hits an error halfway through attaching
> the folios, it will not call folio_put() on its folios.
> 
> Unify its error handling behavior with alloc_dummy_extent_buffer() under
> a new function 'cleanup_extent_buffer_folios()'
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++----------------
>   1 file changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 152bf042eb0f..99f03cad997f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2829,6 +2829,22 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>   	return eb;
>   }
>   
> +/*
> + * Detach folios and folio_put() them.
> + *
> + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> + * does not call folio_put().
> + */
> +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> +{
> +	for (int i = 0; i < num_extent_folios(eb); i++) {

What if we hit error attaching the first folio?

In that case eb->folios[0] is still NULL, while num_extent_folios() will 
call folio_order() on NULL.

I think we need to enhance num_extent_folios() to handle ebs without any 
attached folios.

> +		ASSERT(eb->folios[i]);

And even if the first folio is properly attached, we can still have an 
eb with part of its folios not yet attached.

Meanwhile the original cleanup inside alloc_dummy_extent_buffer() is 
doing proper check other than ASSERT().

Wouldn't the ASSERT() be triggered unnecessarily?

Thanks,
Qu

> +		detach_extent_buffer_folio(eb, eb->folios[i]);
> +		folio_put(eb->folios[i]);
> +		eb->folios[i] = NULL;
> +	}
> +}
> +
>   struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>   {
>   	struct extent_buffer *new;
> @@ -2846,26 +2862,30 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>   	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>   
>   	ret = alloc_eb_folio_array(new, false);
> -	if (ret) {
> -		btrfs_release_extent_buffer(new);
> -		return NULL;
> -	}
> +	if (ret)
> +		goto release_eb;
>   
>   	for (int i = 0; i < num_extent_folios(src); i++) {
>   		struct folio *folio = new->folios[i];
>   
>   		ret = attach_extent_buffer_folio(new, folio, NULL);
> -		if (ret < 0) {
> -			btrfs_release_extent_buffer(new);
> -			return NULL;
> -		}
> +		if (ret < 0)
> +			goto cleanup_folios;
>   		WARN_ON(folio_test_dirty(folio));
> -		folio_put(folio);
>   	}
> +	for (int i = 0; i < num_extent_folios(src); i++)
> +		folio_put(new->folios[i]);
> +
>   	copy_extent_buffer_full(new, src);
>   	set_extent_buffer_uptodate(new);
>   
>   	return new;
> +
> +cleanup_folios:
> +	cleanup_extent_buffer_folios(new);
> +release_eb:
> +	btrfs_release_extent_buffer(new);
> +	return NULL;
>   }
>   
>   struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> @@ -2880,12 +2900,12 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>   
>   	ret = alloc_eb_folio_array(eb, false);
>   	if (ret)
> -		goto out;
> +		goto release_eb;
>   
>   	for (int i = 0; i < num_extent_folios(eb); i++) {
>   		ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
>   		if (ret < 0)
> -			goto out_detach;
> +			goto cleanup_folios;
>   	}
>   	for (int i = 0; i < num_extent_folios(eb); i++)
>   		folio_put(eb->folios[i]);
> @@ -2896,15 +2916,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>   
>   	return eb;
>   
> -out_detach:
> -	for (int i = 0; i < num_extent_folios(eb); i++) {
> -		if (eb->folios[i]) {
> -			detach_extent_buffer_folio(eb, eb->folios[i]);
> -			folio_put(eb->folios[i]);
> -		}
> -	}
> -out:
> -	kmem_cache_free(extent_buffer_cache, eb);
> +cleanup_folios:
> +	cleanup_extent_buffer_folios(eb);
> +release_eb:
> +	btrfs_release_extent_buffer(eb);
>   	return NULL;
>   }
>   


