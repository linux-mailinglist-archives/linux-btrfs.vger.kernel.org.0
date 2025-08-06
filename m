Return-Path: <linux-btrfs+bounces-15891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C51B1C07E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 08:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD933BDC3F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FED820297B;
	Wed,  6 Aug 2025 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DBB5e9zS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BD20E033
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754462166; cv=none; b=tuaPgLj9fLF8VOAjUlO2KQtxx1Z3lWd4t+ni1KxSICrQH2gwoBcNRD5ZDvGuo37lLJyli9zaQ1VUBj03ticuT2+UfhWMvRVmaLyA9O+CmKl7NZAKpZQqtJnRk//LAhQ5kl8qWMplE+KaHT48A3ERQRp4smjz3zu+0/5fdpAs07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754462166; c=relaxed/simple;
	bh=P0Js1unXyKqyaqxeeDkHlFo9R8SkQdXFYaURkzRH/Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bc+zQ78VYluCpSZp+IVJxlTbWncY8vzylZ2k6HaFTpnZ29w9PYmD+uQvimcZL06WHjkbqGbiZPyW+FDKuTypmVkfqNGRO4vR1FVxVUniUlOapjIHXIMau4weM6S4Hb9Gp3UctCNCC9t2XuFuwR5HX9619UOw/7f7LuijpYj5PDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DBB5e9zS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7886bee77so5250219f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754462162; x=1755066962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/U7si9SXRwJtfss+Q2Ggekwgixcc7/Djjf2UmZfsWHo=;
        b=DBB5e9zSxUa0as/3B1f/JAvpap1QUl0WuFvghaDHYnknx3+C6wCyNSe4u644RDO6Oo
         +0GBNRL2EvBnmfLO8TF9Yadx42CZDNB1R+Yj5TJCAN92inTsAZyb3RUQxyiL1GykoXP3
         U5jOdjq6D0UpduYGpyftd0L/Ydk6oCVeusSeGPwvwvmV3IeQZa62OpofVUSzz4Xxgi8O
         GhCIt3OnfstzTmjaYe+BqzgOxw2+nanmuptDf9Yai5BmIBWAyXoi0iuvoG6B8BXh6K5t
         FgB6uBB+zbimkx6j88amwwpINLvIusCEO+gMOhe4EO3zCSEpGhT8i0V3GrOhbBNZ6l/J
         LZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754462162; x=1755066962;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/U7si9SXRwJtfss+Q2Ggekwgixcc7/Djjf2UmZfsWHo=;
        b=IpqOhIB75be5K2uPKK/xfInTa4E0KCuI35iWSt9D8+RjxobmgmOP36FtuO80WkX03J
         +zMyn46YWkrvCdZxy/axxLCPb9etKUzCpmaamYnsgjHoEZAT6vC8uMbkohcDzJ8xEgLv
         TOhVgAV8AP+b+rYAd8r+NnXRFyqO/608V9OBOA3e43o69QZOHgOZ+HVUkttGHJg+H69t
         wqJzpGubQHoVMo5f7lF0jb0UM6Vm+PLGe5QXKLloH3D1LwmLxWZcTOufEI+/bGL/MzCP
         sKRDr91+xHusKVMwmf7W+1ScLgZL7hVs2kTpR6Tbmxpyw2D1v6ffhmnYKPHaXSzV8y8C
         TLYA==
X-Forwarded-Encrypted: i=1; AJvYcCXshA//UaiASZ6g5EhA/wFTme3RU92UzQJXq8S8qfWZ7ioJZFG53BCydXds+bovBOK2TWLQTYmZQ25vOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqTAp7yjRWfB0eJgXPZpEfa6/VwXBB3qxdeOBQVmPYdkxaB0/
	VhOhUi2qGW33tX7ZR38R9uMSNEGT4Qh1VXdyoCvFld3DlR07xhUmdtt6H/L8AFBZ75Q=
X-Gm-Gg: ASbGncvxKe4SR30uQZd/y1iQKqTAHVJN0itPCYJdUZTAm4s8Ws3Yyiv1XOZU30SqDtA
	MlIlE5GWOskNwc/mqayi7E5YluEIm8Jp59rH5quabJEP1K+7mXzfzxicgnDHrRTElfwD4cmrSBL
	G/s2kaOmtCWEK9wrySHcRqvvHodT60p0wUaQrfIbMNcFujiAj+Af43zWZ+s6rpcd299tWuswTMO
	o16DnrZUxr2+qlIP2rOjSOOVh9kPCalV0+WNJHyFawUz3lM3XS/hYhWWtpYB2fIrJcGTHFzFTMR
	Bd6IEBLZn251Uznxfg0N1MDMz3sJRfZW9rMrxhUjWhZ5HShUxIz6xlxztoDJOw/8u2PUrPRXMG8
	3KfFXMPFrufgH5yJR03QtZ3buFU8i79/bBAn8/ENpPYchMs8Olw==
X-Google-Smtp-Source: AGHT+IFGSkgRjjBfcpx3PgAEgIXFFJLS4oPb/ckbsyrt3jz7MfLzOT/8fbPwOCxsUQvohahO1o/M8w==
X-Received: by 2002:a05:6000:240d:b0:3b8:d672:3cf8 with SMTP id ffacd0b85a97d-3b8f41b6bc6mr1111199f8f.43.1754462162481;
        Tue, 05 Aug 2025 23:36:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8911asm14457379b3a.36.2025.08.05.23.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 23:36:01 -0700 (PDT)
Message-ID: <f9bb5ecd-1e82-4bb4-9d24-f557002057da@suse.com>
Date: Wed, 6 Aug 2025 16:05:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
 <4222f30c-8bd5-42a9-ab0a-f8c39d402256@suse.com>
 <6baaa8ad-5cbf-43b2-b7cd-c04572c9952d@oracle.com>
 <bfee8819-5a5b-47d8-90a5-66d053c90cab@suse.com>
 <2f957fae-d12b-435f-bfef-5adf368fd82d@oracle.com>
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
In-Reply-To: <2f957fae-d12b-435f-bfef-5adf368fd82d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/6 15:59, Anand Jain 写道:
> 
> 
> On 6/8/25 14:15, Qu Wenruo wrote:
>>
>>
>> 在 2025/8/6 15:31, Anand Jain 写道:
>>>
>>>
>>> On 6/8/25 13:06, Qu Wenruo wrote:
>>>>
>>>>
>>>> 在 2025/8/6 02:44, Anand Jain 写道:
>>>>> Some devices may advertise discard support but have 
>>>>> discard_max_bytes=0,
>>>>> effectively disabling it. Add a check to read discard_max_bytes and
>>>>> treat zero as no discard support.
>>>>>
>>>>> Example:
>>>>> $ cat /sys/block/sda/queue/discard_granularity
>>>>> 512
>>>>>
>>>>> $ ./mkfs.btrfs -vvv -f /dev/sda
>>>>> ...
>>>>> Performing full device TRIM /dev/sda (3.00GiB) ...
>>>>> discard_range ret -1 errno Operation not supported
>>>>
>>>> Where does the error come from?
>>>>
>>>> In device_discard_blocks() it just calls discard_range() in steps, 
>>>> nor discard_range() itself would output error message.
>>>>
>>>
>>> Its from the my own added debug message at
>>>
>>>          if (ioctl(fd, BLKDISCARD, &range) < 0)
>>
>> So you're only fixing a message caused by a patch not in upstream progs?
>>>
>>>>> ...
>>>>>
>>>>> Fix is to also check discard_max_bytes for a non-zero value.
>>>>>
>>>>> $ cat /sys/block/sda/queue/discard_max_bytes
>>>>> 0
>>>>>
>>>>> Helps avoid false positives in discard capability detection.
>>>>
>>>> Since there is no error message and the error code is either ignored 
>>>> (in btrfs_prepare_device()) or properly handled (in btrfs_reset_zones).
>>>>
>>>> So I didn't see how the false positives are even possible.
>>>>
>>>
>>> discard_granularity suggests discard is supported, but it's actually not
>>> discard_max_bytes is zero. So the discard_granularity check gives a
>>> false positive.
>>> ----
>>> $ cat /sys/block/sda/queue/discard_granularity
>>> 512
>>>
>>> $ cat /sys/block/sda/queue/discard_max_bytes
>>> 0
>>> ----
>>>
>>> If the line is confusing, I’ll remove it.
>>
>> I understand the sysfs problem, but since there is no such error 
>> message in the first place, it won't cause any confusion, thus I see 
>> nothing to fix in progs.
>>
> 
> Please!
> there are two messages...
> 
> 1.
> Performing full device TRIM /dev/sda (3.00GiB) ...
> 
> 2.
> discard_range ret -1 errno Operation not supported

You didn't get the point.

With or without this patch, there will be no difference to the end users.

And I didn't even mention that, since there is no error message related 
to discard, we do not even need the helper discard_supported() at all.


> 
> #1 is in upstream
> and
> #2 is my own debug.
> 
> 


