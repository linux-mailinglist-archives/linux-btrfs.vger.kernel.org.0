Return-Path: <linux-btrfs+bounces-10090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A709E6559
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 05:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188F4284D40
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 04:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67D13DDAE;
	Fri,  6 Dec 2024 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QJYn2n5W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D6ECF
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458587; cv=none; b=gc5DkD3SRgkqdAlcCrKJXAa17gnfVPp64tAAnIWOFpdxNGKmcsDQWVXWGwVvt6mXE0bZYyhQSqCCQFkWTxguBg/dyfS1SAEsJOYrIEZPY8w1+HwMxMCE6dxH7GKiqlX2k8lo+nRH+HwIqo2Jv1U4VaJJpBhw0JxU+GUUarjKSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458587; c=relaxed/simple;
	bh=yBw04mfPKepZfFuurdTwiZRkq9CEo+hhU1J2iWOZjrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NxexGWzbs4KILr6o6+MHCHB2b8ZGMpiLax2XahPXXojmgV1S9HIqN/DBgHEiNUBKN6xm+P11JnR7yy8qUt+m1mcKguG0deFcGj0sd+8tItbUftQTybA9Z2YjRLYWjKlZtThR+hnB7L6HU6Kef/c4iIukFxdHRXWpu0NLxwRNnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QJYn2n5W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382610c7116so919510f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2024 20:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733458583; x=1734063383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iU1VSWcs6QOxRAUEoRD8dHYe57jNEwU1KA6Y3gyK61c=;
        b=QJYn2n5WypRaXFp+a85uJS4KWP7d+QKjkWcOtn7S9ca0A5zVlct7RQQyoTNV5o2VIG
         zper/k7MZjjV3oniAuDvRuhlYr4tLLmpzjJqpKuLHCHAkgegBXfa7CGKPPhyNQKOHTPo
         5IZ96oCfQ0AHw8XTB6ZNGSOeIWiRj16iUeJrsdvwhFaohzNtGamF0cMxoXghLbGZFzA8
         tA0z+x/mfyllbVT+r4Xt+jLM4FrjwJ90GZZ9FfpZlhtJb6HDROKDkKaXQhg232MqCitJ
         w7wqSlXZV9bTzS5Uxy00UsG5a4E8eCZO7didMTI3CEDExWRajk8RWE00FfCaeM8umM9F
         FsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458583; x=1734063383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU1VSWcs6QOxRAUEoRD8dHYe57jNEwU1KA6Y3gyK61c=;
        b=tvZ1RvSb+Ar5KqBAg3VPrWTaQ6hz/I+o8oGFm3cAfiWLve8DFRXqgwlH/w9SiwGcGY
         pGIsAj4JObieAgggdHyM+TVIwSJc4GP1D5MLp+1a7nQsETKsGLIA5i7zyAd5XWbfBsUk
         fsA0yIu38PsEHw8ZvIG9u3Q7a7jdwhbI3jOWsmyt8TQBwcidGV/eFo2LOfNPNRITVbrU
         vVGwg6WvFNxEp3IGFPKoUer5Q/aZYcHXvKXC5IiPV61+VRhIcL2NJV1Njo1KmJ5+B4TW
         R3yPRAQElZSujL/bda1ZGp+xFK6veicnlQRC+knhDx+abAyszbmJl78ZX1AK3ysG93KO
         F1CA==
X-Forwarded-Encrypted: i=1; AJvYcCUtk3IEMTtbql0PSXebm75O0d00iom6yOrANaulkpJ3inr2GDmO2umfNnuwkIDD7XPNmPJotAyDs2Pbgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mt0oCz2IGDqIYBgRsCRJV1W8EdC2tRVN/mzhl1Tgri3VoiyS
	bTThNxmGVqGVaEUfl7Nk3lKR/YTwkobwQNPsqqA5z2oCIZ2gz0chiSXxpDe+P4w=
X-Gm-Gg: ASbGncv8IFupXqAI1E9upHroHIaDtHbJ8E2w49zPLlrBcY1JjhSHGlBziDgdJy7ExU9
	OGlVCAWM22vI9Vuyb2ysHtKGe7wpHQ3WP4uqIP55a44p3NAKRdViX2fgfJEDlaGPl/q1O6k816k
	Jt+dbnV7DiHiMzAh8msxHjwWnj4JxDN6/KTUcXMgE8QpUwo33rBJp4JKyoBDo1H7ER/djlWiJE2
	B0f4NvGwdSB/tnrH87nAPVECY6DbTfHO5uEHzgedjYNwLU+TsYoWxXsFuDnsgFOXlj1GMR1rEZm
	Pw==
X-Google-Smtp-Source: AGHT+IHPeAf2dph6+FRnM6/NoM8Jd6mVp6BZUipDTDTjWjk3Mt5uXxlAdmIl2NmZjY67XWOTXsWoUw==
X-Received: by 2002:a5d:64a2:0:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-3862b33504dmr807133f8f.7.1733458582435;
        Thu, 05 Dec 2024 20:16:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2701df43sm4475438a91.30.2024.12.05.20.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 20:16:21 -0800 (PST)
Message-ID: <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
Date: Fri, 6 Dec 2024 14:46:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo
 <quwenruo.btrfs@gmx.com>, Scoopta <mlist@scoopta.email>,
 linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
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
In-Reply-To: <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/6 14:29, Andrei Borzenkov 写道:
> 05.12.2024 23:27, Qu Wenruo wrote:
>>
>>
>> 在 2024/12/6 03:23, Andrei Borzenkov 写道:
>>> 05.12.2024 01:34, Qu Wenruo wrote:
>>>>
>>>>
>>>> 在 2024/12/5 05:47, Andrei Borzenkov 写道:
>>>>> 04.12.2024 07:40, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> 在 2024/12/4 14:04, Scoopta 写道:
>>>>>>> I'm looking to deploy btfs raid5/6 and have read some of the 
>>>>>>> previous
>>>>>>> posts here about doing so "successfully." I want to make sure I
>>>>>>> understand the limitations correctly. I'm looking to replace an
>>>>>>> md+ext4
>>>>>>> setup. The data on these drives is replaceable but obviously 
>>>>>>> ideally I
>>>>>>> don't want to have to replace it.
>>>>>>
>>>>>> 0) Use kernel newer than 6.5 at least.
>>>>>>
>>>>>> That version introduced a more comprehensive check for any RAID56 
>>>>>> RMW,
>>>>>> so that it will always verify the checksum and rebuild when 
>>>>>> necessary.
>>>>>>
>>>>>> This should mostly solve the write hole problem, and we even have 
>>>>>> some
>>>>>> test cases in the fstests already verifying the behavior.
>>>>>>
>>>>>
>>>>> Write hole happens when data can *NOT* be rebuilt because data is
>>>>> inconsistent between different strips of the same stripe. How btrfs
>>>>> solves this problem?
>>>>
>>>> An example please.
>>>
>>> You start with stripe
>>>
>>> A1,B1,C1,D1,P1
>>>
>>> You overwrite A1 with A2
>>
>> This already falls into NOCOW case.
>>
>> No guarantee for data consistency.
>>
>> For COW cases, the new data are always written into unused slot, and
>> after crash we will only see the old data.
>>
> 
> Do you mean that btrfs only does full stripe write now? As I recall from 
> the previous discussions, btrfs is using fixed size stripes and it can 
> fill unused strips. Like
> 
> First write
> 
> A1,B1,...,...,P1
> 
> Second write
> 
> A1,B1,C2,D2,P2
> 
> I.e. A1 and B1 do not change, but C2 and D2 are added.
> 
> Now, if parity is not updated before crash and D gets lost we have

After crash, C2/D2 is not referenced by anyone.
So we won't need to read C2/D2/P2 because it's just unallocated space.

So still wrong example.

Remember we should discuss on the RMW case, meanwhile your case doesn't 
even involve RMW, just a full stripe write.

> 
> A1,B1,C2,miss,P1
> 
> with exactly the same problem.
> 
> It has been discussed multiple times, that to fix it either btrfs has to 
> use variable stripe size (basically, always do full stripe write) or 
> some form of journal for pending updates.

If taking a correct example, it would be some like this:

Existing D1 data, unused D2 , P(D1+D2).
Write D2 and update P(D1+D2), then power loss.

Case 0): Power loss after all data and metadata reached disk
Nothing to bother, metadata already updated to see both D1 and D2, 
everything is fine.

Case 1): Power loss before metadata reached disk

This means we will only see D1 as the old data, have no idea there is 
any D2.

Case 1.0): both D2 and P(D1+D2) reached disk
Nothing to bother, again.

Case 1.1): D2 reached disk, P(D1+D2) doesn't
We still do not need to bother anything (if all devices are still 
there), because D1 is still correct.

But if the device of D1 is missing, we can not recover D1, because D2 
and P(D1+D2) is out of sync.

However I can argue this is not a simple corruption/power loss, it's two 
problems (power loss + missing device), this should count as 2 
missing/corrupted sectors in the same vertical stripe.

As least btrfs won't do any writeback to the same vertical stripe at all.

Case 1.2): P(D1+D2) reached disk, D2 doesn't
The same as case 1.1).

Case 1.3): Neither D2 nor P(D1+D2) reached disk

It's the same as case 1.0, even missing D1 is fine to recover.


So if you believe powerloss + missing device counts as a single device 
missing, and it doesn't break the tolerance of RAID5, then you can count 
this as a "write-hole".

But to me, this is not a single error, but two error (write failure + 
missing device), beyond the tolerance of RAID5.

Thanks,
Qu

