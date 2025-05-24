Return-Path: <linux-btrfs+bounces-14208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B8AC2D0D
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595CE4E1867
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B8418DB0E;
	Sat, 24 May 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c7RSnaJU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E447E9
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052613; cv=none; b=sAyIRWC9zWCBQHDlMuBbq+FmF1+eNpkSBJvc172+igULFmlnvll+2UdrM7H4JFqhWGH4+zRHeDceLAh6T8jTwVn9DZQcCPJ1FskGuVun+3edGUwfice8kUsD9p1ocFoex3I+uy3YCuRhRo/ETJfkUvvLSXqdnUJBjiS/oYM0DzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052613; c=relaxed/simple;
	bh=oB2u2yYRU3jFltpuEOl87ULk9xu7nhIy5gfp067zxN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWggSnka3GRoeBgqWOJNJQxnqILK3CoYoUn0zDsrc03cjG89AEU4iwAim3hf2FJcffvzby7qZGkjK6DW8n2HbBvAtFM7jdJovGKUs0bnk4VJlIUfn7dczXpXNo6AN2qm29/vbncgpVQJYniXjvm7rL2vF0ealt6MyVpXpyi8Bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c7RSnaJU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-440685d6afcso4371755e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 19:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748052608; x=1748657408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uhF8UEpMpWWihv+wMVbwmtYXxu1PYkZtbu92IGohw48=;
        b=c7RSnaJUIfb8u9WVf8X/YzAlG1LAUBtTBkqOuoIoEfY8iXVlO6x6SmDtIKBJK4aHvV
         L4c4Gt2sM4URp2TN8tlncb94uWMP4J3edJky1MqBi+QlaGgeLEk+sNASfH58QxuMSrh5
         4OY+ID2sbOdHI7yCodvL2LU0h7sj58Fmj7T2weZwQa8ThwG8aljKW4AoLPuGVlLRWSZi
         EIvf7E3xqCjsIp5lrOoHKcT6IJhSMJp5ZrLSvYEGJI+rRJfSY62m9TcnEZUdS/+ctEtd
         1EdETmq/c5ZJDALh+vofjLSm4cwqziNhovcs1ecRLKbFUfHMT5ULOTKbZNFper07lBSj
         l2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748052608; x=1748657408;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhF8UEpMpWWihv+wMVbwmtYXxu1PYkZtbu92IGohw48=;
        b=rFtuUdBju6LhuaprLKj1QgnsjesD2ISdMDa/xeYBaKKFjyPiHY85/YqLNM9Sgj9+DH
         MJcHQcKRg1VBEWzq5VhrSlqkP3DHBsEy7hfhWkC0HInTpppOyB7vAjfyPpzum9YuhkWY
         ajCulSeFxrG+dKKlrswVbvmbvCoF2KPJ2t5GW7TGfMD/MlwwQNHviGjkgWxtvVLL5IoO
         kRDCJbfsw5mFnQ74mZ/6uHwAvpXKSYrVRBW0abdW9mVMhMKW8VLTQJv1qCusN3376+IC
         8ssDWSU7k5Ghy4Fc4c3IVz7vCKUiHpq17MTsyYL6ZpHCF9oy5CC2UBzgd6LVlDGgvjKZ
         kyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8x9vg3X7xQtogC1n6IpWrNulNVeacowSqPgVrDF2cYKb0l44vIwqWII83gr9QwkAblxXHs1z3AXpa4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFeHx+v9Kqt7GCStHG6MHw3Yh5sr1gwPqFatyvpUm7NvjYPGD
	0DPhDv4RWTXgmFEtAPcPhxN5qxITUu0qKM5QbDFIpGaGrLq829J41wxRS/n7uVM+zxU=
X-Gm-Gg: ASbGncvM2a97r7/JnfP5YXNwqyuDBbC1d3ti4wML7mNxBCOSZQuTSFBCvdOuwiHYn6Q
	LcoKPSK2bB2JFwoQInhha0toSKtqFiP4xJeYetdPwopTmB+v4B0hPKxMpV5EV7D5vfpxOb8FKEt
	zpo2PHV4PonyzolCovD44IpbfGiLVOHDdZmtzFxL6RrEv2j0vNQykYEqHhJlLA6mZjoppyb+yc1
	iNWZdkRzBS158cKGl7hJBKLOvvZpm5MOTyg/td+lpcLaj8Xms0saAsAym/YNmSmTiO6xXa2zc6z
	V4PNVI2OsN7rM89tbLkfGHilMmO8x4c2QrhjVNESo69uQAXqkVyJSiAE/VGIQp113ynFFFtBmPe
	cyMs=
X-Google-Smtp-Source: AGHT+IGWgXR3eXHbBipI5jVH+Dl0W+31kd6huMgDjpv8hCQpDh7qhjZWVdyAI1yfIH0Sv7lFo5b+Pg==
X-Received: by 2002:a05:6000:430e:b0:3a3:69a6:c367 with SMTP id ffacd0b85a97d-3a4cb4ad6ffmr915244f8f.59.1748052607889;
        Fri, 23 May 2025 19:10:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba4bcsm130183415ad.182.2025.05.23.19.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 19:10:07 -0700 (PDT)
Message-ID: <d873210f-baa9-4f75-902b-e61158e78333@suse.com>
Date: Sat, 24 May 2025 11:39:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: Fix incorrect log message related barrier
To: Kyoji Ogasawara <sawara04.o@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
References: <20250521032713.7552-1-sawara04.o@gmail.com>
 <20250521032713.7552-3-sawara04.o@gmail.com>
 <e508301e-4474-4490-93ad-bbea3e6ed04d@gmx.com>
 <CAKNDObAZHiqromZUimS_V3mfDT5CJaBN91rhOYr7b4nLTh-__w@mail.gmail.com>
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
In-Reply-To: <CAKNDObAZHiqromZUimS_V3mfDT5CJaBN91rhOYr7b4nLTh-__w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/24 11:30, Kyoji Ogasawara 写道:
> Thanks for the review.
> 
> Regarding the Fixes tag, would you prefer I resubmit the patch with
> Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")?

We will handle the tag when merging the patches into for-next branch.

So you don't need to do anything.

Thanks,
Qu

> 
> 2025年5月21日(水) 13:15 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>>
>> 在 2025/5/21 12:57, sawara04.o@gmail.com 写道:
>>> From: Kyoji Ogasawara <sawara04.o@gmail.com>
>>>
>>> Fix a wrong log message that appears when the "nobarrier" mount
>>> option is unset.
>>> When "nobarrier" is unset, barrier is actually enabled. However,
>>> the log incorrectly stated "turning off barriers".
>>>
>>> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> This is definitely a copy-paste-error.
>>
>> And we can add a fixes tag when merging:
>>
>> Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/super.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 012b63a07ab1..0e8e978519d8 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -1462,7 +1462,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
>>>        btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
>>>        btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
>>>        btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allocation scheme");
>>> -     btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers");
>>> +     btrfs_info_if_unset(info, old, NOBARRIER, "turning on barriers");
>>>        btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
>>>        btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space caching");
>>>        btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free space tree");
>>
> 


