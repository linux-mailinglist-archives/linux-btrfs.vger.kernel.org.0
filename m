Return-Path: <linux-btrfs+bounces-14344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8009AC97DB
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 00:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD21D3BE4FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E0B230D1E;
	Fri, 30 May 2025 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KtlxAReD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3F283CA2
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748645625; cv=none; b=HKVLLOoecBE9on+ZBJmmTr4TnBA/wtUkRaCdGnPUxymEefOfJM+InmHHs52URxnAI2EOaPf5kjiSGj6nLE+4KLWsDQg6yKxLMWk290c57OyoNmLpSKAp9GGVTKRq7PhDCN6AJyf5jVu6/4LobvQE+oLa84d3Ggl85etDOar/T8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748645625; c=relaxed/simple;
	bh=9M2aUk21zpyaB5+qPXvp8o7feeiSnkIwk4U6HwlAQdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UblXslQzWfuY2U+larLT8ye5Ech4WC/155Jau0zlZMhe26Xn3/dj4oFIWcbRisZS89PPKLtKOq3N2wAOi25YO+sPaFNqPRpDKy30T9zHm1hHvCqwLmiFUzw/CJqW+5COXD5n1a0SMILUBs5+1WJTtqddk/jI0sNxKUhortKn3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KtlxAReD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so26050295e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748645621; x=1749250421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lUBFXK1IoWHq6cn3mtZgmEtB8Wbr6W/AwdAsknpYAg4=;
        b=KtlxAReDNYr+D0PtmlQ3FV14cG/N0yHcwN6A//GQViDeHFmpPR4KiPUisOha85d9xr
         +kZIsgmb9qFlQQ+04h8+ZQomLDTV64nlsNgRa9K5EciTVk1rSw4MsU3+KBEQUs+7jTu5
         q/ekSXGQFMywt9fL7ePRAHcE+BDJIyQn6o3CtXaoz7gUz0j3ElAi2AbiV9ypG60MNZgg
         KAhGI4m2EPIZwshcUPg9g41RgFB+3wyRCkiXr00+sixxKVaFcDTjXogirAxtJnAPWQF6
         zt+MiWMLc841yfiHFsVvdrSe4v1a3ATg5t5fh+FlQ86cSIQCqlva/avgvqfU0bbxIG/q
         x9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748645621; x=1749250421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUBFXK1IoWHq6cn3mtZgmEtB8Wbr6W/AwdAsknpYAg4=;
        b=YY/uMAR82kJGehZEUgj0r6XVf2BqJZSxXmn3Ib/LjeBr4cvqJluBfo6TMsK/q3F1xd
         YaRJU3mJkSfHIdLLZjYuWPdgrd5oXPR+kXvvDsjY6DVf3HOXaxEhwDZGZSWdNPoKcxrH
         0ushraHJ/2M/LU318J6aRlN40lsMmhXcG4r6etap024NUY8o1oLqREYOODyjX7dmAnEo
         Vh8ivqLdbBXSbvyz3sKTboMhI5Jggx5ENQ4tOzrQSc/5hIpDsGaavQdELlPgIzSEcdWK
         lK6vZqSUgjQLWI3MfSWBPPxcSKaWV87dS4wVsoO+uGJEDuJOmOQav7m1MVb3nYq480N4
         hdng==
X-Forwarded-Encrypted: i=1; AJvYcCXOOxWD6/68li+sfHRTnDOyaTnRGj+JdwsBheYZkHYjR7Q2WrPuk3oJd2/+ERC0X9ETDOXA0TPw49qesw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CwwcecuBA/Au3Wti1QsPOq7ZuClFX40lT6GzdTGEYHYH7U5j
	meb5QaDOh1sgD1wpenMGLYykk+e5HCvMXsIni8Xs1BEfBYro/bu3OFR6V83wywnrLLJtXrqqDz8
	vxPW1
X-Gm-Gg: ASbGnctA7kDsCjakbywmEO5BmLGwaGo16mnU3oUzZ9Szhs/xK8d3dwiUjRhhpRT8iZN
	A+ndO0hQ+WaEek8ozZfMPYRNBVtkh6fZeKtapUOODt7Foko0tyzzXDSNyYvPBu0L5wrXNhxmTEp
	F0BX7xKutUnMnAveh0AV4hXpceLWF4MpJohE53nrJC/upDGzyJb48JjC4AIqWm84f2f5/+1nzF1
	pKIhOb9K+ZLPichC6CRLNeuWlLO+ceY43W180zIrcYKyjWzhLtd9/tRp2cTizLH50YDuXd0/zSZ
	MWoF10idGCDE8767vC4Vh7jWdqch5Fj8byCgmW7S6+zlKo4DUjFZZjFT74Kh5e41bQJqm52A9lG
	0kvmWHCA/OltBtw==
X-Google-Smtp-Source: AGHT+IFqY2VAe0zTQV6b0zbtQB4cG6fDD+kRJCDygCay43VxEbKpBHiNjuFlO+pF9Lc/gg6ATmEziQ==
X-Received: by 2002:a5d:6f18:0:b0:3a4:f892:de86 with SMTP id ffacd0b85a97d-3a4f892df7cmr2721331f8f.33.1748645620640;
        Fri, 30 May 2025 15:53:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcf84asm3650546b3a.130.2025.05.30.15.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 15:53:40 -0700 (PDT)
Message-ID: <0b95e062-8f11-48c9-86c7-d6a74390cf9a@suse.com>
Date: Sat, 31 May 2025 08:23:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does defragmenting break reflinks?
To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>, linux-btrfs@vger.kernel.org
References: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
 <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
 <3eabd123-e2a8-4554-b57b-0c84b713cd10@velocifyer.com>
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
In-Reply-To: <3eabd123-e2a8-4554-b57b-0c84b713cd10@velocifyer.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/31 08:09, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 写道:
> On 5/29/25 20:27, Qu Wenruo wrote:
>>
>>
>> 在 2025/5/30 09:22, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 写道:
>>> BTRFS-FILESYSTEM(8) says "defragmenting with  Linux kernel versions < 
>>> 3.9 or ≥ 3.14-rc2 as well as with Linux stable kernel versions ≥ 
>>> 3.10.31, ≥ 3.12.12 or ≥ 3.13.4 will break up the reflinks of COW data 
>>> (for example files copied with cp --reflink, snapshots or de- 
>>> duplicated data)." Why does defragmenting not preserve reflinks and 
>>> why was it removed?
>>>
>>
>> Defrag means to re-dirty the data, and write them back again, which 
>> will cause COW.
>> And by nature this breaks reflinked data extents.
> 
> But why did it not break reflinks previusly?

It looks like it's technical difficulties.

The commit is 8101c8dbf624 ("Btrfs: disable snapshot aware defrag for now").

I do not have all the details, but at least a quick glance already shows 
that the old detection is not taking reflink into consideration.
It only considers snapshot, but reflink can happen within a single 
subvolume, or between subvolumes (not snapshot).

So the old method is not reliable in the first place.

Thanks,
Qu



> 
> -- 
> George truly, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 Improve your wifi reception for free <https:// 
> www.youtube.com/watch?v=LY8Wi7XRXCA>Home alone any% world <https:// 
> www.youtube.com/watch?v=IMstFIKZLpI>record set by 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 <https:// 
> www.speedrun.com/home_alone_nes/runs/zpkq978y> This email does not 
> constitute a legally binding contract


