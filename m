Return-Path: <linux-btrfs+bounces-14396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE779ACBD80
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5053A45EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5E25290D;
	Mon,  2 Jun 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FaVb4CZv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F61C1F13
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904971; cv=none; b=QrK1nurxbFdf2XyPlRIqETL+KQi5lglQn34LvVP10Syxuqyf4fyXGdKsWXqAYIX1ILwvs8MVvCUq31Jc3h1KtqUIzcUgqntbmFV1QRm30TbZeuHpWETO8gqQ6wmA8WGiBidzXY1xMlSl18xwhUvZrPDsFrqjebXm40qIKAuBTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904971; c=relaxed/simple;
	bh=fuH8Q97FWwhsPgdHStu/JMorNhLtXVTS4EbQkfR4RwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LHQIz48440T5sQbLKHAKvbof+6i2LK4zrYEydbKSSuelDqwGhyj2ipRcuma30VPbArs37DlmBUVw3GlH73wzzvwLJSLspBJHDTUFNE2x8SlRroJZW3rw1gWyIdVHqeRdQwoik7R2QWcXZcdnZ0ZkTmCbGiKHc6TQEDuRCWgcop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FaVb4CZv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so53837265e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748904966; x=1749509766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+1oS/lTNDg+KPoaBLQaajUx/YGnu23kcq3T6bIdrm/c=;
        b=FaVb4CZvcqjgu2jYPWkE6coLlNwVCd/5fOdFzpRXfvQg10uYuQgvJ/S1ZrHTFW+0Qg
         XuyHSSqR2K4bAmtr07USDtYYiC5+U1NaUbYLGSfwd5iKY42o/JpuWTc1+w5iTh37G8bH
         yWiA9J3lD3/3SKWNH0+EfwfHPrZcnqiKnyxythSFKsTTn7ZTa8etj66uQwvt4OaeodLd
         bjxYa2zuaJW4qbw0hoiABmKO1TRIZhDSlCFa7Am89zkF/ELxt/Mqh+hQXdg3mOYSekOu
         KcJzY5EEY5RhpLv4KHsobVHXtxmuJGpsR1ymdUBrrxLvbzmBnKr8470/cagQN09tJJsW
         uDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748904966; x=1749509766;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1oS/lTNDg+KPoaBLQaajUx/YGnu23kcq3T6bIdrm/c=;
        b=FOQNLSBGbRpkJHeHXxzdHczcwFeGv/iuS50ZJq/3BVJzcyYdF9T6Bd10gL7e9ZsuvF
         OeRlCMp+Em2G1DTO44R+n4FxEqfCwKoRxjDkgIt0yRT6GGCBvyDJx7rC0wp0OXDGs4FA
         B2MJMvBSB8Z37MxVwgdI1uO1IMM79Ow6yZOOnST8X5fWvfy2dEqhvHFn6gKXTkvdpLWp
         EJUrrK1Tb2T2lIAkK2uDxQMCqAGQG1/SVSLMWYeNyf7YP76mZUusC9H4wqvOHuJ1CXs8
         NXAYI7y7K/94fMgYeT1mgT3R6qqCKdkFAZTJRRixi90mceskaLxNPqiP1YTSAiaUPDXn
         blEA==
X-Forwarded-Encrypted: i=1; AJvYcCWHpzm3HgA7l1h5o/o0tBOYn0ogWQYFmGgBlk36wJcjrfrsqyhANOhmISVaOaKsqzAN+CJT09/40/CVww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0C37V385TF9Kpmf5e9akcVXPHi6s6s+TwzhFMa4q1XVJBnFsE
	SdZrnJm9ph3S6lYuHlaaHh1XqmxAo0wd/r/tHTFPqtMzkEBtdc/vfrQ8J3NNMXNCn4o=
X-Gm-Gg: ASbGnctaJOsTdIvNvk/EihPiF61pU8H70NSi4D7LENWeWPaWa8crOL5Buk+oVulQbLq
	kVkbs38atMms4dGWpjLCAwg0EApqfwfXQfCzoXbkGtJOz4E9iCSymkQ9aMbfE8ikINIB7HQOdqY
	D7QrlrFdclCUj1h1D78kV/ilPJOaD2qhkxkKwXRxiigngGPM40V0qkEvLT1zPEcpchXoljeXEkN
	+URekFrjqS0jWT2jjBDH3FCdP/MXjg24YGL3pU6aUVvrRi/34Q5eUPTCRoOqeHeXb+NpIhLomNg
	J666SQWdSGHmNNXsmGmg9w7i5c1GuwGXovqO9yIcnZfzlqmX+2OBVbsvuSOsOgQ88PQCSUQFlJ3
	/gpSGTEGBslddKg==
X-Google-Smtp-Source: AGHT+IGk0COEsgC3PTkIRv6LptLDlNbCcYJ44o9mfs0PAG9oYD8rScJta9LXyN/FTt1eGTsO4jbMBw==
X-Received: by 2002:a5d:584e:0:b0:3a4:e65d:5d8c with SMTP id ffacd0b85a97d-3a4f7a9d5ddmr11939399f8f.40.1748904965959;
        Mon, 02 Jun 2025 15:56:05 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3744sm75702215ad.149.2025.06.02.15.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 15:56:05 -0700 (PDT)
Message-ID: <79875f25-26d8-413b-938e-8b0e8fffcb95@suse.com>
Date: Tue, 3 Jun 2025 08:25:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] btrfs-progs: introduce "btrfs rescue
 fix-data-checksum"
To: kreijack@inwind.it, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1747295965.git.wqu@suse.com>
 <828702dd-33e8-48c0-85f8-455763e34ed2@libero.it>
 <e156fb78-928b-4fea-b29d-c06f70744fdf@gmx.com>
 <b2eee8fc-ef11-431f-81b2-46f48e087a0d@inwind.it>
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
In-Reply-To: <b2eee8fc-ef11-431f-81b2-46f48e087a0d@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/3 02:58, Goffredo Baroncelli 写道:
> On 01/06/2025 00.07, Qu Wenruo wrote:
>>
>>
>> 在 2025/6/1 02:28, Goffredo Baroncelli 写道:
>>> On 15/05/2025 10.00, Qu Wenruo wrote:
> [...]
>>>> We have a long history of data csum mismatch, caused by direct IO and
>>>> buffered being modified during writeback.
>>>>
>>> What about having an ioctl (on a mounted fs) which allow us to read 
>>> data from a file even
>>> if the csum doesn't match ?
>>
>> The problem is again with mirrors.
>>
>> Unless you ask the end user to provide a mirror number, for a with 
>> multiple mirrors, and the mirrors doesn't match each other, the 
>> behavior will be a mess.
>>
>> That's why I'm planning to add something like a mirror priority, with 
>> a new mirror "best" to try use the mirror with the most matches.
>>
>>
>> Despite the mirror number problem (we need to ask the end user for 
>> mirror number), I think it's possible to implement the feature 
>> (mostly) in user space.
>>
>> E.g. combine fiemap result with btrfs-map-logical, then read from the 
>> disk directly.
>>
> This would expose to the user space the complexity of the filesystem; 

Let me be clear, the filesystem is complex.

If there is a csum mismatch, the end user should dig into the rabbit 
hole to find out why, fixing it with some tool should not be the first 
thing they want to do.

> this means having two code path doing the same thing in two subtle 
> different ways.

It's fine to have two code paths doing the same thing.

One for offline and one for online.

> Pay attention to consider also a raid5/6 case with a 
> missing disks.
> 
> I don't know how important is select a valid mirror. Or at least, I 
> don't see a realistic case where a mirror may be better than another one.

RAID1C3, RAID1C4, where one can have 2 or more mirrors matches each 
other but not matching the csum.

> 
> After your consideration, I would like to suggest the following:
> 1) read the data from a mirror, the csum matches, return data
> 2) read the data from a mirror, the csum DOES NOT match:
>     2.1) read the data from another mirror(s), the csum matches,
>      - rebuild the csum
>      - return the data
>     2.2) read the data from another mirror(s), the csum still doesn't 
> match, return error
>     2.3) (NEW, alternatively to 2.2) read the data from another 
> mirror(s), the csum still doesn't match:
>      - take the latest read attempt as valid
>          - rebuild the csum
>          - return the last read attempt
> 
> 2.3) mode should be a enabled by an IOCTL on a specific fd.

Again, we should not even put a complex csum repair into kernel mode and 
allow it to be done online.

Back to the first point, csum mismatch should be investigated, it's not 
something one should hit commonly, and we should not make fixing it 
easier either.


Csum mismatch should be treated as tree-checker errors.
I have not yet seen anyone suggesting there should be some fancy ioctl 
to fix a tree-checker error.

Then there should not be any easy tool to fix csum error online.


> The 
> assumption here is that if the csum doesn't match any mirror may be 
> equally bad/good. But in the IOCTL we could add a parameter to specify 
> the order of the mirrors (still we need a way to specify the order of 
> the mirror in the raid5 case).
> 
>>> I asked that because the problem usually happen on a specific file
>>> and not to an entire filesystem. In this case I think that it would 
>>> be more practical to read the block
>>> using the IOCTL, and then rewrite the block, at the specific offset 
>>> (to update the checksum).
>>
>> I'm fine with the idea of reading from raw data idea (although prefer 
>> to implement it in user space), but not a huge fan to simply re-write 
>> with COW.
>>
>> E.g. the bad csum is still there, can still be exposed by scrub, even 
>> it's not referred by any file anymore.
>>
> 
> If I understood correctly, you are saying that due to the fact that even 
> if an extent is partially referred, all data in the extent is tracked 
> and has his checksum. A rewriting in the middle would generate a new 
> extent with a new checksum, but the old data still exists in the extent 
> with his dedicated (and un-matching ) csum. (I repeated this because it 
> seems to me a technical detail not so obvious but very important)

Yes.


>> So overall, if one hits a csum mismatch, especially after the direct 
>> IO fix, then it should not be treated as "something that can be easily 
>> fixed online", it should be something huge, at least needs some tool 
>> to handle it offline.
>>
> 
> Even tough I agree about the severity (e.g. the corruption happened due 
> to an hw error), I less agree about the fact that this is a 
> justification to not have a simpler interface (form an user interface 
> POV) that don't requires an un-mount/mount of the filesystem.
> 
> Un-mounting a root filesystem is a not so easy operation, so we should 
> provide a different way to access the data.

If you can not trust your hardware, online repair is just going to cause 
more problems.

Again, replace csum error with tree-checker.

Thanks,
Qu

> 
> However I agree that we should allow the user to select a different 
> "mirror", considering that a "mirror" may be any valid combination of 
> disk to rebuild the data (e.g. when we will define the interface, we 
> should consider raid 6).
> 
>> Thanks,
>> Qu
>>
>>>
> 
> BR
> Goffredo
> 


