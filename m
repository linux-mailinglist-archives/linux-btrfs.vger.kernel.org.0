Return-Path: <linux-btrfs+bounces-21162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OAqLrHNeWnEzgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21162-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:49:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E149F9E680
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E13343007289
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068523385A8;
	Wed, 28 Jan 2026 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fbx5a+WW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0611328B41
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590162; cv=none; b=AXHu4ixfEXamDpmPCbM1T06DQF+/tLLfHlH8yzaTGkhUgx0HQIm0sOq3ecEnq6ZLjNIMIbExl21cuC/jk9iTZ/uwunkkq2gSw8v8x3JNjr5V2YmuqAHpzATqVarU1PMDXeODahN2hFDTueT+GclbkWXZPyiQA0GGjGy+bVclU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590162; c=relaxed/simple;
	bh=Adn3Fr/oeglmg2ExdztrRmS8NmX3OMGsnhe/EcD6tyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T4BmDqWJfGFhphcDsynNVhb4Vy6RAFVoEnPf/Nt6nQFiJhGS8LHrDI5PxlKJiieWrNBPPSMl3GAKefGUmjwjbuKW18RIR1y9dP7TtzA2YZ92oX1ysuXNm0ul9uCzkmo8HhiDfpfvZ+YupHvuLS4i891JEqR4UCVHs75afAFVJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fbx5a+WW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432755545fcso4892794f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769590159; x=1770194959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZONYVpxxRdYbLHKBdIlC6yzi+cwyyDNVQhqeqB8weh0=;
        b=fbx5a+WW88C3zSNjHwlWOoE/SanXX3fnuKB/nyUoRiXfvYSYMw9rlY13CYwmtnEU10
         pRxD9GNdiL8s3sjiFZGSyjzC8z49EY2cGwMjXDKHFDL1ZADuSAAhOLriJCtZ6deoXQLL
         qced+NqZooUT3nuj2vQzujIT1NDbQEkdCIMnzeWSwDIJauUfgnZBWrDIF+3oOsPQwOeD
         PBJVsIQ4sMOiWQeW1WH5EXVvsrEhkBz7PoKua792zknJ7b4YB91YyZibCefviFwt1cJB
         fuiuXERKFja5ELHxDE4A5vhGOYmKoAy7W1fRIfzNvsv9xoI3SMQSZnn1Rjeg71BLqOiy
         AJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769590159; x=1770194959;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZONYVpxxRdYbLHKBdIlC6yzi+cwyyDNVQhqeqB8weh0=;
        b=NMXICRlbHQpclpQiz1CigY0X1/qwRRJvBUerfRUtrgQrW+1L9qr58KxrY2jwtU8rb7
         NSl/FatnxQZ6QPCIk7CV9d2RiGwO6lp9CW9DKk1a8B9WMOxleaecVFQ9q5n8BC3sL01a
         HzNjonOWgwgGkJXSuJxZzj0mOKnvUFIWsph4J8z3gaRu0NI/PNn0kKNP0j9tQoOJzXfW
         uhSSQLBMt4sV93iJo9/40Uhv3WqhD8F5nQoq+Jsae1W8igbGW1Zh1au8QGATPhx5mg2X
         bgcC91WX5SjWBrVJztLKdGhZtiFXguHpndYCBvileaWcrLJlqCSIUQUpXTmfQSoE6pUK
         Ir2Q==
X-Forwarded-Encrypted: i=1; AJvYcCURwI+7yJffB3ceIp3l27Xkl0ZH5isvax6t463RmYmU2xnyoZ442HJT7wjx+ESBG9w4d5lSXgMdfzupmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6x2+EWaCnvCwVBDGv4kgrADTucP+50HpmEqAVYjvt1VofIwZi
	p3JumejTSE41grWcHyrilkBci+mQtvX4J/PB03+qIrCaCGN5sHPSIFhliwD4LrpSu0M=
X-Gm-Gg: AZuq6aJ1/UWuAiBBr/L5T8rq0Vd0zm91Yvz7+f7nXo3T4oUvIXRiE0j/TRMVa2E9ko6
	gkj/ettssnGsJ99IpcIsPA+p8XbVBVtQ8igPRINionkF0UtLcUIPPIIj+Ujo9eUq6j2tFvx6xeE
	Kf1AJ4KeiwPozqBuZ64imImIWdPogcMGA4dBhJ6Sphd7KapeP+dRd9ArsoI+HCQLYnYhOsSP0Jl
	9FVIg6ttYaVWNy3X1pgJHxH5unGbkOuRxMM13gZJEPg7mHT6Ztg8kpzH3YqnoIB3t6pspXyAwDF
	STTKDpVArPfY1sFX4HWc7ujFi90pVNIGI3p1kuRSpsZNO9x68eGpf8mAZN1acYchkJREZ9jPEX+
	cJVTQYvHG8ZLhvU5FI9Gbe4CN5ao9reaEXzU1lJ3B0le/p52PIDQmUo0STz9MxB1J3EgtUc6Srz
	tzh1kHUoExIB/BVKdwnSV9Ar3cuYDJ6iMzcL0V3WPifM2whVbzTg==
X-Received: by 2002:a5d:64e7:0:b0:435:960c:5286 with SMTP id ffacd0b85a97d-435dd1d853amr7099478f8f.58.1769590159007;
        Wed, 28 Jan 2026 00:49:19 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4148d0sm16064195ad.27.2026.01.28.00.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 00:49:18 -0800 (PST)
Message-ID: <8adc2517-a0fa-497d-ac3b-8700d39bb085@suse.com>
Date: Wed, 28 Jan 2026 19:19:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck subvolume removal:
To: Paul Graff <pj.world@gmx.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
 <4b4fc981-912d-40cd-945b-d4acf14198e1@gmx.com>
 <01f8b560-fb57-4861-8382-141c39655478@gmx.com>
 <0ed6fdf0-842a-4641-90e4-5239b5049e4b@gmx.com>
 <121b0011-8076-4a0b-baff-384b6ec62986@gmx.com>
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
In-Reply-To: <121b0011-8076-4a0b-baff-384b6ec62986@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21162-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: E149F9E680
X-Rspamd-Action: no action



在 2026/1/28 19:12, Paul Graff 写道:
[...]
>> Unfortunately btrfs-progs doesn't have the ability to repair it yet, 
>> I'll craft a branch of btrfs-progs with the repair ability soon.
>>
>> Meanwhile please prepare an environment to compile btrfs-progs.
>>
>> Thanks,
>> Qu
> 
> Hi, I would like to ask if there is a solution to the "dropped ghost 
> subvolume" the filesystem on machine here exhibits as of yet?

My bad, forgot to inform you about the fix.

In fact the fix is already merged into btrfs-progs, but not yet included 
in any release.

If you can compile btrfs-progs, please fetch and compile the latest 
devel branch:

https://github.com/kdave/btrfs-progs/tree/devel

After compiling the devel branch, you can use `btrfs check --repair` to 
fix the problem, which will add back the missing orphan item for those 
ghost subvolumes.

Thanks,
Qu

> 
> -Thanks
> 
> Paul Graff
> 
>>
>>>
>>> [6/7] checking root refs (0:00:01 elapsed, 94 items checked)
>>>
>>> ERROR: errors found in root refs
>>>
>>> found 496776130741 bytes used, error(s) found
>>>
>>> total csum bytes: 465839608
>>>
>>> total tree bytes: 16133832704
>>>
>>> total fs tree bytes: 14983905280
>>>
>>> total extent tree bytes: 624771072
>>>
>>> btree space waste bytes: 3613129770
>>>
>>> file data blocks allocated: 1062495817728
>>>
>>> referenced 976540409856
>>>
>>> :~ #
>>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>> -Greatest Hopes
>>> Paul
>>>>>
>>>>> After passing,
>>>>>
>>>>> |:~> sudo btrfs subvolume sync / [sudo] password for root: 
>>>>> hightower- i5-6600k:~> |
>>>>>
>>>>> the command returned to prompt very, very quickly.
>>>>>
>>>>> A second balance attempt results with the following output:
>>>>>
>>>>> |:~> sudo btrfs balance start / WARNING: Full balance without 
>>>>> filters requested. This operation is very intense and takes 
>>>>> potentially very long. It is recommended to use the balance filters 
>>>>> to narrow down the scope of balance. Use 'btrfs balance start -- 
>>>>> full-balance' option to skip this warning. The operation will start 
>>>>> in 10 seconds. Use Ctrl-C to stop it. 10 9 8 7 6 5 4 3 2 1 Starting 
>>>>> balance without any filters. ERROR: error during balancing '/': 
>>>>> Structure needs cleaning There may be more info in syslog - try 
>>>>> dmesg | tail hightower- i5-6600k:~> |
>>>>>
>>>>> |:~> dmesg | tail [93689.781162] [ T69656] BTRFS info (device 
>>>>> dm-2): found 16 extents, stage: update data pointers [93690.667290] 
>>>>> [ T69656] BTRFS info (device dm-2): relocating block group 
>>>>> 1495819878400 flags data [93703.323923] [ T69656] BTRFS info 
>>>>> (device dm-2): found 33 extents, stage: move data extents 
>>>>> [93705.575991] [ T69656] BTRFS info (device dm-2): found 33 
>>>>> extents, stage: update data pointers [93706.769453] [ T69656] BTRFS 
>>>>> info (device dm-2): relocating block group 1494746136576 flags data 
>>>>> [93725.570642] [ T69656] BTRFS info (device dm-2): found 39 
>>>>> extents, stage: move data extents [93727.449779] [ T69656] BTRFS 
>>>>> info (device dm-2): found 39 extents, stage: update data pointers 
>>>>> [93728.465650] [ T69656] BTRFS info (device dm-2): relocating block 
>>>>> group 60294168576 flags metadata|dup [93736.722689] [ T69656] BTRFS 
>>>>> error (device dm-2): cannot relocate partially dropped subvolume 
>>>>> 490, drop progress key (853588 108 0) [93750.594559] [ T69656] 
>>>>> BTRFS info (device dm-2): balance: ended with status: -117 
>>>>> hightower- i5-6600k:~> |
>>>>>
>>>>> Please see the following referenced, prior posting for stuck 
>>>>> subvolume removal similarity. https://lore.kernel.org/linux- 
>>>>> btrfs/9f936d59- d782-1f48-bbb7-dd1c8dae2615@gmail.com/
>>>>>
>>>>> Is there a patch for btrfsprogs? If so can the patch be merged?|
>>>>> |
>>>>>
>>>>> What are your thoughts on this?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>
> 


