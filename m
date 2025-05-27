Return-Path: <linux-btrfs+bounces-14264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CEAC5D24
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F67F3A4DAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8B217679;
	Tue, 27 May 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YhjYo/Vz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E8212FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384979; cv=none; b=jlaRlRRtC2fbneh7zfmPc4O58pfACkVUGQDGxpFSylFEHClscg549N/cdQg3gk12ScKC9Iudg2IaZWveSawyi8sjtqPYPetXyRT9RQuwMcG/nOv/QrWiUCsl0+VFHvl2cv7pwHK0h5pX6e6YPvFg+QGM6qqwQ+etRPpawovSmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384979; c=relaxed/simple;
	bh=XpVKmwX2rdlgWegzvH90tdtBHwgrTIIo/M18s0MfAYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZpygKdplxIhmM9m1Vw3gjfaHqzYEZVb+NCutvU59YM26T0ZKAiCa/yLaaeDo2++4WOWWYT3KNuo7oB++UfNFFgVMRGgf5oKWuZ7tdVB4vTHojNsMD9jX+3hgBAwOOj0DaskzXvcxdngpSFq4TqMV1BlNQx2Sve8JgwUYW596sNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YhjYo/Vz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so51087995e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748384974; x=1748989774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=feYtp37CycM4c+4DBclDHQuQqI0K0pyowXBiJCNxH/o=;
        b=YhjYo/Vz92QzvWTjz52iX6ReSMqsm6jVz6L83mMohe9vt/1ABdu09rzt5F2yiwjae5
         7WK0kjXjB9Ed0i2i9mVuyauN9OTferX2KN6MUOm2ohhlFmE7KYGtfVyx/E0yGS6yXtF4
         OZJvuDtvYP8l2ndDFsLMIHp4hpxlChRaavkNaY0kz6vwPCgaKq8XTrEmT/vw449LQEpD
         /z9xAkYeYyNnMBJoKNxdhaxf+B/one2/VFev8Wpp8Jk+uJ7hOEs7qs3rzQJk9fLeNAne
         +fjzWLEXTIeTDbySGTHh+bjkWxqoeEPatOfGo1jK2yLZyqxZN6Sy9g5WnYfph022bz13
         eAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748384974; x=1748989774;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feYtp37CycM4c+4DBclDHQuQqI0K0pyowXBiJCNxH/o=;
        b=Y4hoGpi8kjeA0tIHxmyeA5USmqXkpmV0e7lAidTfVnw/KPifrFr9kSwdRplviQGDRB
         tBSacn4SgUpfP18petljq+rYVfK5jdh4W2Bp9y2utxkJ8pk9gIoMFRq8MyIWUeQgeVK0
         jQblQEmcrXulJS2Mzk+QRuZj6cp629UfuD1x5VQqUj+hRkm0yKB2aM5+7ydDmT2FpJLt
         JY0ItFERADKzgIJuVhKd/y1y+mHMM72sHObnfDBHaF1gi1bg9XIBqOqZi05UCaON+7GB
         L3Xh9wWZRsPey9LypfsPZlnMkPugHc4AaSImEUSK+QhqU5sL0NO9u776oCqrZCa1pKc9
         EKMw==
X-Forwarded-Encrypted: i=1; AJvYcCUFoN8KJtRBkVRb1ixQTH7Ckt26LNdCc7rjsaR/5Z69UslayAY9DGsUvvQJi5TctOGeQabQSKX7FuYAYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fJM4eC95dBBi+Ds0hDRANEm6Xgkn7lPFFm6vQsCwufOlqp4W
	uwlnjqnp4laNHs2g2CI3Lv19f3FKYnvbAbaYCWDC6tOjGxZKB6bqWAoEk09CNvD/cPxZ0HMdTAU
	IVyUG
X-Gm-Gg: ASbGncvE8vfS4TvaOdwtWAITBJtHfDonkdra6gMdfhmbq6VWEn0Vv7eSNw+4DlsmWNt
	J5o2hFBIRZO8kL6io+WLtH+8vVuMT09miwZKpiDb9Q0/QmMUwwqZewCpzLkGHzY9Ncesh2qfapl
	jo+rOxZhRcFoLs4EbSwdIj9PDRFwyFnP03ColcUDme9nxtG/c15nnQq4yJ8WIBXff7C3bEwE/fk
	EqGPllqpreQ/4+2FsKMIudLIeDbA5HWjNSHFuIbl/5Oh1NgK0azQzeMPkG65achujXlLG3MuWln
	8kybmz/b2xdusIW+CfIVvi8BgDmVkVZaBbfie138je3X4u/GY3XW0pq1EgWdnNX8kDgPVpYhuWJ
	HrzGHZA2K9rA0ig==
X-Google-Smtp-Source: AGHT+IGapqf1mweJmPUicDgL9TVYTXfYCAQNCfcQYWsmBT3KdPBYF4Pr3V4CnqrETHmDcq1uZd7OCA==
X-Received: by 2002:a05:6000:1acf:b0:3a4:d673:af99 with SMTP id ffacd0b85a97d-3a4d673b308mr9169087f8f.34.1748384973903;
        Tue, 27 May 2025 15:29:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc218b64sm862655ad.151.2025.05.27.15.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 15:29:33 -0700 (PDT)
Message-ID: <bdd36e78-b9bc-4950-a933-b36d5d518be2@suse.com>
Date: Wed, 28 May 2025 07:59:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: unfold transaction abort at
 btrfs_insert_one_raid_extent()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <abe65dcfac248737e735f5c3b9d7e9f165dac802.1747653415.git.fdmanana@suse.com>
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
In-Reply-To: <abe65dcfac248737e735f5c3b9d7e9f165dac802.1747653415.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/19 20:48, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a common error path where we abort the transaction, but like this
> in case we get a transaction abort stack trace we don't know exactly which
> previous function call failed. Instead abort the transaction after any
> function call that returns an error, so that we can easily indentify which
> function failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/raid-stripe-tree.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 1834011ccc49..cab0b291088c 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -329,11 +329,14 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
>   
>   	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
>   				item_size);
> -	if (ret == -EEXIST)
> +	if (ret == -EEXIST) {
>   		ret = update_raid_extent_item(trans, &stripe_key, stripe_extent,
>   					      item_size);
> -	if (ret)
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
> +	} else if (ret) {
>   		btrfs_abort_transaction(trans, ret);
> +	}
>   
>   	kfree(stripe_extent);
>   


