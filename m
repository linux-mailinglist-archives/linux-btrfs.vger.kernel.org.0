Return-Path: <linux-btrfs+bounces-10112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A49E8239
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 22:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501E91882E0F
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968A155A21;
	Sat,  7 Dec 2024 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kelx+22Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8ED140E2E
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733606445; cv=none; b=oSurc3GRvteZUDkcFm/0KhP7GlxJxdIO6WYI9OasXKH+xSoOTLREvcIuK7CBfWOcqgcA6CM9c10xNCPPMIRixZDo02w6TG+4QJ9hjP5aWB2ZW/w3QZkaJTbl0w4XZJL2O3dYwWl99o4i6ldZ4WrRdQH2i5DWpA5ZTQ4Iipwlz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733606445; c=relaxed/simple;
	bh=phaa6tPi6gomfyt6K9ayS6CqFIfkkgoclXweCyMubGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AMvouODeoaTF9jEh/jQoA07DVdpJxRFslNFRNzYgdbyM53Y7CemKKPYJIPlMgE1uZDEvqrKcF5itKpPtw0N1TiVjBb7+A1iWiYexl9AOAJHQc54MF+JmQRG9cvEW0CL/O2rgAWfqr7HIDHe83i8V93j5Wf3ypw19vNpanzq6PUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kelx+22Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a099ba95so32213055e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Dec 2024 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733606441; x=1734211241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UAH35AH5/obCtHy2CjHblCvQiQVtBXwAutV6LWoNmN8=;
        b=Kelx+22ZLsJkDIHFyflZGkHn4tGG7x2g4q4JrQB99IaOsc/w7KQBLpZLDVyeG/qpmN
         ct77d2dvluViErPa/D7Q0v8Y7ziweMBG6gO+Paat8tvQYRMvLXqth3cY26zXXlytv7N1
         1dftBr97nU4QXc2jRcXr6pjsiBVP/OIi7t6+G3stmJHExHV0OqHkAqRcAbWkWf9MnbOg
         GxKb80F/WW5+zzOcUhSsjiNvjZFooUO6PmExYFZg1iK5vwBU4/edpFHzoyGLEt3msHuw
         F7B+H9AAYLLAE4r4hIzEVnje/Q4h8TmE8aIsmdKVTRzgwPFXDgCEEf72kfQxfGmYxBno
         N3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733606441; x=1734211241;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAH35AH5/obCtHy2CjHblCvQiQVtBXwAutV6LWoNmN8=;
        b=PYOvOXnGtvA6LXFsLOzlHnTRsQuBRkwnFqaLcFcX13IeLjrx3GBIR7ehewbHhIbhzn
         c0vzRP0vQE7tGmWK04RLGs6GHYBGqgYoERLna9DxCsIOAwP4Ho8yySYKd1iOt1JsCVb4
         ap9yJ7/LWEXw1xREGeIZGMII+kT+Pruix2cV9m9dr24fn9nYYDd47pR8RQzB/JkbV2C2
         IW/wtG9Qn8aYoWKzh3r+Yo1BPv1QgNWTyg8vhdPFf9LFB1BCaVoBpGpU049o+2R1xE6u
         by27wmKuFXZASyJPCNNcaSt4W91ZEChRSBEN3ZHkz0vR3DXhPMIT1+ZWy/iN0GdBxUNN
         dVZw==
X-Forwarded-Encrypted: i=1; AJvYcCVGZN9WT63c0NlmAqWFeIOjhrE66PXbuGFmAWPW6MMQ+aLRiMQZDvMFZpeOX9ZnE4Zu1jIRIPXZzSg5jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSXw3+ruG6LOOQyGgCzGgSoKcY884+fjxtVylqXifr6Yb770Q
	ElcrcmHKoK0cui6fqmdy8oQ8dQhY7SvwbTX47HARxQ/G3dvN4MaPF2hmdGcW/VM=
X-Gm-Gg: ASbGncvN4lC0V4Feux3LhNzSX+qjhWesO/ydJi7rcqcn1Mkfh6UNWAq/psFMkX6RCCC
	dQcmzd6oAZbaGjpW+kK0BpdnYP+dXQYNj6RIlJKKPWABi36MVWvKa4PIM5ANi/tH/2uzMkWhfuW
	BvkHzGEW9lVij7jC5PNXUWdr43iNuutbLAskKj7Z62T2fOAzigECefPb4KEwVIDuDZml615Pnyq
	uGP+GopZ/WEVPhic/3M9gLzM7fcvnNdmDpz/2snuQbLuWaghKERz1p4xsezIE8K9DqrFotFoblI
	AA==
X-Google-Smtp-Source: AGHT+IHp8oOSBel7D2xRJ7239vmjkY0cNbiW8Iv2umBn77+NaJIwGWkPBYZJZLerBPWMgEK6CXVRsg==
X-Received: by 2002:a05:600c:4712:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-434e29f0392mr44208655e9.5.1733606440676;
        Sat, 07 Dec 2024 13:20:40 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600cf20sm5288441a91.43.2024.12.07.13.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 13:20:38 -0800 (PST)
Message-ID: <7ee86cad-b8ed-4609-87e3-ab9a9e3bb98e@suse.com>
Date: Sun, 8 Dec 2024 07:50:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Balance failed with tree block error
To: Aldo Gutierrez <btrfs.spry594@slmail.me>, linux-btrfs@vger.kernel.org
References: <173323215268.7.6782695832944219711.518128798@slmail.me>
 <a78e6eab-88a6-4287-b5bc-ba5552cc8726@gmx.com>
 <173358166800.7.9767075912845312020.523411723@slmail.me>
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
In-Reply-To: <173358166800.7.9767075912845312020.523411723@slmail.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/8 00:57, Aldo Gutierrez 写道:
>> The numbers look a little possible for bitflip:
>> hex(15648439500800) = 0xe3b6fad8000
>> hex(15648439517184) = 0xe3b6fadc000
>>
>> The same 0x8000 -> 0xc0000 just like Neil.
> 
> Isn't that suspicious? Why are the numbers so similar? Is it possible to flip the bit back?

I have no idea how this happened.

To flip the bit back, no btrfs-check --repair support so far.

This means one has to craft the tool from scratch, which is normally out 
of reach for all non-developer users.

> 
>> Did you ran full balance regularly before switching the kernel?
>> If not, the corruption may already be there for some time, just the last
>> balance chose to touch that block group and exposed the corruption.
> 
> I do a -dusage=50 a couple of times a month. This time I did 85.
> Haven't run a full balance in ages as it takes a long time.
> 
>> Mind to run memtest first to make sure it's not some faulty hardware
>> ruining the day?
> 
> I ran memtest 10 days ago and yesterday I ran memtester. 0 errors found.
> 
>> For your data, I believe most of them can be read out without problem,
>> just write into the fs may trigger the fs to RO.
>> Thus it's recommended to back up your data immediately. (After making
>> sure your hardware memory is fine).
> 
> The issue happened 10 days ago and I have used the fs since
> without any issues (have made copies). I had expected such an error to RO immediately.

Do you have the fs mounted on other systems before?
The corruption can happen in the past but not exposed.

And the RO flip only happens if the write touches the exact extent (e.g. 
removing the extent or adding new reflink to it).

Thus it's not that simple to trigger, and the generation difference is 
also not small, which means it not something happened recently.


The extent leaf has generation 4919751, but the offending item has 
generation 4893938, which means the offending one is created over 25K 
commits before.

So definitely not something immediate, but I'm not sure if 10 days are 
enough to cause 25K commits either.

> 
> Within a week or so before this error I had run clear-ino-cache and changed to space-cache v2.

After the clear-ino-cache, do you tried a "btrfs check --readonly"?
If at that time btrfs check reports no error, that should be the last 
known good status.

> 
> While going through the logs I found this happened about a month ago:
> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): block group 12157169172480 has wrong amount of free space
> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): failed to load free space cache for block group 12157169172480, rebuilding it now
> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): block group 12178644008960 has wrong amount of free space
> Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): failed to load free space cache for block group 12178644008960, rebuilding it now

These are fine to ignore.

Thanks,
Qu
> 
> 
> 


