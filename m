Return-Path: <linux-btrfs+bounces-19237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB92C775CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 06:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BF24353053
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D72E6CD9;
	Fri, 21 Nov 2025 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/WMMS5K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B923D7DE
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702674; cv=none; b=VH2E9/FH35QQ5xJCNY/eNx6MjAKWsYubjDXxTvNtklMfc2lYG9n2h6UYHmZ5j81JQ6V3khqVwHw6vjxx+Mnf+pGM6rFxdJoImj53G6i05fic28MmG4y59mt0SOlFdalntxTEkkzcvrsccdL22HPmj+SXnIQ7NSTsFcSlSly9h+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702674; c=relaxed/simple;
	bh=S71uo5WTZEYfRBCFCUXHspwWYv6WcNFfkw59JZUz0bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hVLshUvqyZ/mXHIADQAmY22IPR3M8AXVa8iMFqw7153Dqa/H6li/14esn1BvZbrJQE5ZuUNzAn2eK34JA++UsLaAouiRCknkfuDJZbfaluBFL2gqfC8U+pMmQwv107S0tFQM7RuNEY8hYUN80/EHEkdvfxuY2G6F4VgzkubuHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g/WMMS5K; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so13873165e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 21:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763702670; x=1764307470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OBU3fV7n9AgfwJuSK+KgTeALKur32qgedqmAj2cmu7k=;
        b=g/WMMS5KHNOHpfb3XEP2adqXjKo9LP3yv9Awaq/fqTIqbugWf/xByo/oJFMkx/xk8S
         SHZospgV4vzhCA0OyvCFq5KjndaHdxqnDdj4PMevn8e/DevPH0t2PqtMo+up8Dj/EqSt
         VX7XEyI+amC7OU9CX2X1AEvvVfeHCfFriDLCuDDcCHCA3uPGanL0BVb5KpCPgE+SF2HE
         ICf3EkGyd9cxIjDLEg0F+gnOKfbYP2P3gezCTNA4QW66QVCXNh+UcvXUA0AxJ/yAyiVx
         9mYS5BqHR28XsEtJrtpP4lMMkGIvuy6gIAEDjOmMIJHu7nTeEyVIwlJKzbUd7jVVqMW9
         abcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763702670; x=1764307470;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBU3fV7n9AgfwJuSK+KgTeALKur32qgedqmAj2cmu7k=;
        b=YwW6wILuUmeG+ALXJ1aklKgn9YyNpJ/tgOI/LxJr2/HkIGf5yKAuYbsBA+c7d1bIhc
         VfDGThs57L8t7D+tAT+bHIkRZs/PDGslwtQov2PBlPhJ8kU7AymHw7bwGD591zeZkUhQ
         wpamMOPWqHj1JlbE+2Vj5CWxmBgMPrFrek4ggHbNbUJY1GJJdExdr9dSd7ApXL+wWVL5
         zXEcs+O8VbHxKf4oqqelj8IkB+FCK48Smz2tt2A1s/vn7rf0XmkkvkilckXRjaoxkEzb
         NH3XMFk9qoWcqDbf55gwI0ukHTs1IdfRRKTgdxLW+uZ7cTXvldvvQxz0hyU442/gkgUD
         nHAA==
X-Forwarded-Encrypted: i=1; AJvYcCUpjyOJIfDKkzIAguQbeymBXBbCAoDZI/J+pHQgAg/E4RLWh8f26lT/OoqdG4AejhHsJyApCN3b5rnkfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzET1NTDV33c4okoRCrH44R47mecOPRzTGLQfx0Wtcfw9UkfYX4
	1W49i9DmhYr/v2BePnAXLoQEJnaQXmsK/5sYvvxcLKC63cYutyQcUSbmW/aHo+o6ZfU=
X-Gm-Gg: ASbGncvwHrMRhHutu1NsCBwZLAzDq/qMWsp8qwICTE0yx5OHStJxv4enmJXGQyHUIPk
	/GokuA4Ro6N3lA7Mzep94dpglvdDs/IJCT4EiTmAQBW7i+fife4rKPK+2WK3R81KRquO6XutN9X
	4+k/gvbEUlUoRnk9jD/1BXzF/sdgKR99Sm2/6R1h8vqZiNKZRAVnuHXaEny2r4doN4737SOjxhY
	av35O8uL4DrckZ+rAGKU0n/3Z/SSMHo7IV0Am+TNt3Ta/VCJ6aVABwDsX+k9X5dZ9docHvSRk4f
	zVHfim8uzT+e6FsxuITuA2U9MaW4vZcCU2fZIWUNVJeo/LDOS/CuNI5TgIKYST9k/d83IlcSPrT
	2Fd0XLMpMfxACtBtodeOR2lmPgoX1e/oTuHVT8DM2krLbpanrry2iYY6Jz17RYrCEqr0TAg7BgU
	C3iuqdRXdwXs9+Sh3euCTTNLxKjDQTT0KwXfldkVw1YfB2aY3xvw==
X-Google-Smtp-Source: AGHT+IEqX5m7+1lEZimYUGUo60BnVcYZsLHN7psTO3YT3de89/BijWKhFVBhn+RMHIfBqoyZpGtOVw==
X-Received: by 2002:a05:600c:1d0e:b0:477:b734:8c22 with SMTP id 5b1f17b1804b1-477c018039fmr8113075e9.8.1763702670339;
        Thu, 20 Nov 2025 21:24:30 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29d706sm42773825ad.80.2025.11.20.21.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 21:24:29 -0800 (PST)
Message-ID: <bc5249ba-9c39-42b1-903d-e50375a433d2@suse.com>
Date: Fri, 21 Nov 2025 15:54:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: docs: add warning for btrfs checksum
 features
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
 <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org>
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
In-Reply-To: <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/21 15:47, Christoph Anton Mitterer 写道:
> 
> 
> On November 21, 2025 6:03:05 AM GMT+01:00, Qu Wenruo <wqu@suse.com> wrote:
>> The checksum of btrfs, no matter the algorithm utilized, can not provide
>> any guarantee that the metadata/data is not modified by a malicious
>> attacker.
> 
> Is that even the case when the wohle btrfs itself is encrypted, like in dm-crypt (without AEAD or verity, but only a normal cipher like aes-xts-plain64)?
> Wouldn't an attacker then neet to know how he can forge the right encrypted checksum?

In that case the attacker won't even know it's a btrfs or not.

Thanks,
Qu

> 
> Cheers,
> Chris


