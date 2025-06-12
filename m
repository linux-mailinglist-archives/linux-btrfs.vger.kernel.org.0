Return-Path: <linux-btrfs+bounces-14634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB4AD7E61
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 00:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06ECA1898105
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFC2DECC9;
	Thu, 12 Jun 2025 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ataHtFV/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8915573F
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767394; cv=none; b=gYt3fKxJ9IYVqx/1WQCrxQgN99aQiivHNhGS7VbHlDn+F5WoXjizzltiTPQEh5eKOEqMlbCg2IS8EyJ2Jjde80KY9HNc1OQRfACBcwJpZ4y5S1khWA0tNBYk+ieRdD+q2cw/jEYunR87qGC92BwX6lenzSzV6hLnhEcqAAeQDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767394; c=relaxed/simple;
	bh=ws2NzuZz48Ctutn9hi6XehsDejZv6DdX/sSIfAgga3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TJ4QIE71iT5+RyUBlV4i/v6AzZ3Fg8Bfgyt1FkFYMy3NpcLDEl1C4T0u1XaaV8VG96B4Ok4byAoqgbCAJ5uAGUhNo0Xs/dTAtO/JCni4Z4CHnq2ERvKz7+YJp+X1hhlPLOGk2S6zHnjcPzPn8czHfJWI0ck6tJvBayAqvVj/cHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ataHtFV/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a54690d369so1465598f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749767390; x=1750372190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3VA4bGIYsxdRkSGnDO0e09mm/2k0BmDWN4TDP1JKCBw=;
        b=ataHtFV/0VXLo22YzlfJ+AFYFp1qU/ArrFTvt3JHZZtg0fmYN7rw769Gf+TLDcmzRK
         3rJPzFlcqh4d0QozzioHYQAcE9I/lnLkxvNK4gl11ScDSwplqivPDUvukMKssufbIuVf
         HXH29Eq3Vd0VvlhIwn8Gj9gXzpG/8uPUfxIWzYD1T/my2oopTrL3dtAZVVhAS5QAKfHm
         NNg9IodNshV+D5DP1FrLYwyoy3GnBDybC3Qo1761hHK5+lqmQGm3dkeziWD8id+FImcJ
         3fUk3GpVF14dnMwYhCyeZSHTi7jiCN8HB+gpr2HHeT2rFQfaco0z89TJnC5Msi1+olDp
         bYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749767390; x=1750372190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VA4bGIYsxdRkSGnDO0e09mm/2k0BmDWN4TDP1JKCBw=;
        b=MAPU9A4NzpltBcusRK4bt/dqJ2mF9KipxcjMb1r3imF0RjRiKdxxeMIm4W0t3FYVJh
         u9aVD4/XAZk96YPKecV05Q+WRUIxI2SLd+hUuv6jhaYDNRUmm2YWY261M/SR2Kwsg6Wl
         3Hnr8Ch2xHa8vP7F8hygSIO/Hv8HNmOe7lQhsxDvr3UJ/g/hPC09BF4O94Ulq2qKD01k
         D+f8+E/scVvseDLk5YjQQtPXYEUYwyX2YwezgMc1gcBlBUGygDVPmxmSXVrxXJY2aTHD
         Ch4RbLiK6g3tWa7kIAc1sym60ez7/0O9qxTYVRq5YPr1o2R3bYnV4bDquCK2ozjx3J23
         HmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgAYQ5rr/T3sh3leERvxE8AK04bx8DNi9d3frs5Wa5JpeBkdICYs1vC0IUuQ0Bz8hyZEMoWIItO2Bjvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdvxBOip7Wz2wELc0vOZU2HeHcO/IUyAG9MH+BJ35vV3MXlDH
	n3eEt2IPNgA8Soatc36J/O6rGYXJYPzDgsdSwT6fk6rMGvJtZruKQNpt4Ah0IU2pNTsHMIRa9fQ
	mMtCB
X-Gm-Gg: ASbGncv2us6HNwm3ugJiFiImjLJN1B99xX6Z2AeOhqW5MkKbtkKbZZw587fb5gqJh4r
	lwUek4vBo/jQvvU2yBZPWT4Cqy72+H3gMae8UP1Mbwg6WjwhkAAAO35iVH31DBb9EPkPYHl2e/M
	FZI5FkfIUwOcfNV40ex/yDxiY3jvSUKJ+cISUWuYVILo9jPv7y1TzZ58Jbf6CIQVVDc/HK+zSbZ
	BrIRVTzo4rQNZiz7DdISVfROCW9nR2Dd+c61qMZioCAicUFK58Bezf+uHxU+4IKpXlyjK9YwT91
	vXvdzTuwOyT+VJNhCBgeihsg/qSsOrC9bLoaT6wkHYuTKmKqcLID3UV1Nb5G4adlWa/d68pn4px
	Q3XOmiKOeX9IAE3TQZuqv6zM0
X-Google-Smtp-Source: AGHT+IG1JKXvKSBJmkBF6EjtOV5ZDDffhfE0PtriP1DMtaW75S0b28LOWRKgLL7Wkv7EBPu1og/CKg==
X-Received: by 2002:a5d:5f56:0:b0:3a4:ef36:1f4d with SMTP id ffacd0b85a97d-3a568755bb8mr635826f8f.38.1749767390022;
        Thu, 12 Jun 2025 15:29:50 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890084af3sm263513b3a.97.2025.06.12.15.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 15:29:49 -0700 (PDT)
Message-ID: <d57e673e-f894-48cc-8b34-c3754fa23b70@suse.com>
Date: Fri, 13 Jun 2025 07:59:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck in CHANGING_BG_TREE state after interrupted btrfstune
 --convert-to-block-group-tree
To: Tine Mezgec <tine.mezgec@gmail.com>, linux-btrfs@vger.kernel.org
References: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
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
In-Reply-To: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/13 03:13, Tine Mezgec 写道:
> Hi,
> 
> I have a Btrfs filesystem mounted at /media/storage with the following 
> setup, that took minutes to mount:
> 
[...]
> btrfstune --convert-to-block-group-tree /dev/sdd
> (using btrfs-progs 6.6.3-1.1build2 from Ubuntu 24.04), but the system 
> lost power during the conversion.

The progs is a little old, but I do not think there are bgt related 
fixes after that though.

> 
> After reboot, rerunning the command gives:

Rerunning the command is the correct way to resume, but something 
doesn't seem correct here.


> 
> ERROR: failed to find block group for bytenr 186297726533632

Please provide the following dump:

# btrfs ins dump-tree -t chunk <device>
# btrfs ins dump-tree -t extent <device>
   The above one is pretty large.

# btrfs ins dump-tree -t block-group <device>

I guess there is something wrong with the last converted bg checks, 
resulting btrfstune to trying to convert an already converted bg.

Thanks,
Qu


> ERROR: failed to convert the filesystem to block group tree feature
> ERROR: btrfstune failed
> 
> extent buffer leak: start 185256860958720 len 16384
> 
> Trying with kernel 6.15.2 and btrfs-progs 6.14 gives the same result.
> 
> The superblock flags now show:
> 
> 0x4000000001 (WRITTEN | CHANGING_BG_TREE)
> 
> Attempting to revert:
> 
> btrfstune --convert-from-block-group-tree /dev/sdd
> fails with:
> ERROR: filesystem doesn't have block-group-tree feature
> ERROR: btrfstune failed
> 
> So I'm stuck with a filesystem in a half-converted state — not fully 
> converted, but marked as changing.
> 
> What’s the best way to either complete the conversion or revert/abort it 
> cleanly?
> 
> Thanks,
> -Tine
> 


