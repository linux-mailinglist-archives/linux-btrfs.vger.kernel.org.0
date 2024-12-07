Return-Path: <linux-btrfs+bounces-10113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CE9E8257
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 22:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B272B165533
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5C15535A;
	Sat,  7 Dec 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RwjXyMuh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8198153838
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607951; cv=none; b=XepsYr2ZM6DWb4BFIs4rTamz3YXH1matxTJlUZGth2TR3RksGZW9RtTeorSX/Hh5+VuNdBhDbFfQ6SRyCgwOHI+TAl/TpDwhTuKEXYT3zVxqtd+cAI7QKa89+CXFS2eDd4TpmzYvfQNhRqTz93IKtOAP0lpIdq2QOv7YbvW8b+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607951; c=relaxed/simple;
	bh=GA9sqYKAkDE6mfzadHvHovEm+eXJSftWsEpwOIwp+WU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=KYVjLKRNQKZQCDT5YCeZIe2rtIRujp2C9zM2o+/bUf9Jh4/LiDrU3QZqWO5WHPS6Sc4rpZdNIZfUk1TVIsxxNJ2GzclO7LtC9lRO3/V7lxHsyfezZplb4IjFLdpP3rT8cHozHtf+x1JXmbpAbdhEpYW34iau4c2VGpZUhgkIZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RwjXyMuh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434ab938e37so20535825e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Dec 2024 13:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733607947; x=1734212747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOfzH9vQDjPlreRn7G/7SvMfDY87waRePDgrp26Fnrc=;
        b=RwjXyMuhqhDc6owHsouxOc9lUyU5yTKvdn2DGfHeaTSAQfTXibA4FDcaXiD9UO/hcO
         LF3kmeip64vsOjO0J3NTOeYHrl4tnmDDLY2S/pJmpMXPkDRQavxLNZeIwS/NK0K0TGcS
         ZdfAvrzViRiPipmzqS/rkEo82WkKfRYRlFfwKt2gYpN6TiC/t7IKiB+imyY3mOWXEJYp
         HRDNFiyCa3cGhkcCnaXkVbVRLrn0Fym7y1dJRXmRBk7fiUcHsla0YvbduK4ynYYaMRUp
         ZAwMxkUxs//uLxWs25dx535zi367LGyCFsGi8j8Dc6nFEwJgNKCsc7/5Jhb9ViI66wj7
         j7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733607947; x=1734212747;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOfzH9vQDjPlreRn7G/7SvMfDY87waRePDgrp26Fnrc=;
        b=V3t4eXWzo65YRD1sNiWGOOC6j/pze8DCDPlfWNY8vvzEi3RCpo2iq7aPaTE7OPpIEw
         liT3WDVS9+qx6As1LAxyJaM60oMwQPXjj9SCSndsomXoAEcTO8j/P7OqYZJfVnKs7TKU
         BLmELc3euIWOEq9/VApKR5ZOQW7280bVISWHviNcq+UkGuxxxSnkhA5TGyh45THWvtYk
         QXamZHFYWfvC7PkhGH4rxatZnL8CcWDDV09M5Y3J2BZwfyhP2xNNBp8VZvHm7eAAlptq
         V+wD/udfP9NLS0bgfJPaSS/FAEje3N6YgID+m2a3Y3xX3LGfP16qrv+tdbsK/QrY5RZo
         Ojbg==
X-Forwarded-Encrypted: i=1; AJvYcCUuhs93JNto3980QoKq213U9UTPWyxBn+o12cBlcispzB35XLPTphSJuIMDSPDOVSGYHulcpdZNIGq5jw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjrk7yCAAQivQScydYKImgPWyaGukMCfabh4zAVtBdMUq9sS9o
	fBLp81AxiY4F+d8ljWTO90P9PGM2kThpYuLM1ofx6nWgC9GrKxCNjXqu6iw0xa1aWFPaxP1kmgq
	4
X-Gm-Gg: ASbGncvfT6ag7DPkQek1lakorGYxw20bB5ioj1TqfZdbm2ohTJeuQvpyoloH//xSZqy
	4aj99PGB0X1/2ifIJx99TbFDB1FV4FVyZqsaGawh+6MXpqWsJyYNCZ0cYUztMsioweI4ZvJf7cf
	Tu+uRABFyBupEu0m6V84JLqwBa867ISTWughqAQPQK4Vaz3GdADxqfJByphQpd6/4Yy/UFhThFe
	A3c7cu5HFiDVYG2FHvDqZLmZ80UOArA2EBhUn04UV8q30cICSRoNXjHqrJ1ekwdAuwMyA3GaNRF
	fg==
X-Google-Smtp-Source: AGHT+IGCv52pMZ4OQEVxHXAMdQFsf77h3qvtWObk8fFQ2ly6lj5cqogyOk5C3xi7NK5EIe8tpm62Qg==
X-Received: by 2002:a05:6000:1448:b0:385:f892:c8fe with SMTP id ffacd0b85a97d-3862b36af96mr5775951f8f.21.1733607946750;
        Sat, 07 Dec 2024 13:45:46 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e53798asm13956175ad.60.2024.12.07.13.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 13:45:45 -0800 (PST)
Message-ID: <8d64f2fd-1a20-4b96-aff7-75db96d5cbd4@suse.com>
Date: Sun, 8 Dec 2024 08:15:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Balance failed with tree block error
From: Qu Wenruo <wqu@suse.com>
To: Aldo Gutierrez <btrfs.spry594@slmail.me>, linux-btrfs@vger.kernel.org
References: <173323215268.7.6782695832944219711.518128798@slmail.me>
 <a78e6eab-88a6-4287-b5bc-ba5552cc8726@gmx.com>
 <173358166800.7.9767075912845312020.523411723@slmail.me>
 <7ee86cad-b8ed-4609-87e3-ab9a9e3bb98e@suse.com>
Content-Language: en-US
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
In-Reply-To: <7ee86cad-b8ed-4609-87e3-ab9a9e3bb98e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/8 07:50, Qu Wenruo 写道:
> 
> 
> 在 2024/12/8 00:57, Aldo Gutierrez 写道:
>>> The numbers look a little possible for bitflip:
>>> hex(15648439500800) = 0xe3b6fad8000
>>> hex(15648439517184) = 0xe3b6fadc000
>>>
>>> The same 0x8000 -> 0xc0000 just like Neil.
>>
>> Isn't that suspicious? Why are the numbers so similar? Is it possible 
>> to flip the bit back?
> 
> I have no idea how this happened.
> 
> To flip the bit back, no btrfs-check --repair support so far.

Forgot to mention, although btrfs-check can not fix bitflip errors, it 
can fix the bad backref by deleting the invalid one and create new 
correct ones.

If you have everything properly backed up, you can try "btrfs check 
--repair" on the fs to have a try.

Thanks,
Qu

> 
> This means one has to craft the tool from scratch, which is normally out 
> of reach for all non-developer users.
> 
>>
>>> Did you ran full balance regularly before switching the kernel?
>>> If not, the corruption may already be there for some time, just the last
>>> balance chose to touch that block group and exposed the corruption.
>>
>> I do a -dusage=50 a couple of times a month. This time I did 85.
>> Haven't run a full balance in ages as it takes a long time.
>>
>>> Mind to run memtest first to make sure it's not some faulty hardware
>>> ruining the day?
>>
>> I ran memtest 10 days ago and yesterday I ran memtester. 0 errors found.
>>
>>> For your data, I believe most of them can be read out without problem,
>>> just write into the fs may trigger the fs to RO.
>>> Thus it's recommended to back up your data immediately. (After making
>>> sure your hardware memory is fine).
>>
>> The issue happened 10 days ago and I have used the fs since
>> without any issues (have made copies). I had expected such an error to 
>> RO immediately.
> 
> Do you have the fs mounted on other systems before?
> The corruption can happen in the past but not exposed.
> 
> And the RO flip only happens if the write touches the exact extent (e.g. 
> removing the extent or adding new reflink to it).
> 
> Thus it's not that simple to trigger, and the generation difference is 
> also not small, which means it not something happened recently.
> 
> 
> The extent leaf has generation 4919751, but the offending item has 
> generation 4893938, which means the offending one is created over 25K 
> commits before.
> 
> So definitely not something immediate, but I'm not sure if 10 days are 
> enough to cause 25K commits either.
> 
>>
>> Within a week or so before this error I had run clear-ino-cache and 
>> changed to space-cache v2.
> 
> After the clear-ino-cache, do you tried a "btrfs check --readonly"?
> If at that time btrfs check reports no error, that should be the last 
> known good status.
> 
>>
>> While going through the logs I found this happened about a month ago:
>> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): block group 
>> 12157169172480 has wrong amount of free space
>> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): failed to 
>> load free space cache for block group 12157169172480, rebuilding it now
>> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): block group 
>> 12178644008960 has wrong amount of free space
>> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): failed to 
>> load free space cache for block group 12178644008960, rebuilding it now
> 
> These are fine to ignore.
> 
> Thanks,
> Qu
>>
>>
>>
> 
> 


