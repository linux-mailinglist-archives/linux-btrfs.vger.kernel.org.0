Return-Path: <linux-btrfs+bounces-10434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A39F3C61
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 22:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654E2162890
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C21F5438;
	Mon, 16 Dec 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XC1PkcFl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093B1F5400
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382905; cv=none; b=kdbJ7+qmMtRUnl4/e22hypIO6DrYO2nW+18bT4vdOImAAHiM1evBUSJOKxvfdJH0LumSoHXs0dmWNoTBgljQxb0tbrmmXtOatQk0Q+p7c6uEL/usoTjPXZZxhxFOHkug8l6JcQpAC9Wq6JSWs/aIdGR2GOTrtWHU3wtZrqwNoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382905; c=relaxed/simple;
	bh=zMhbwSyKh+YW9DDhXJnMfaP9rpc4QQE1COMNej6HgiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lwrOJooarBvOtOQQ5Z8WyzFgSDgDZh0E95ArWzRdROaI0b7R29GWy9FgTfUDtRb7A2kc/ra/oxMEBnLdAsbOAikuW0weFywQxkoeacQYO2YEUh5lbx0MWmllnF+K/+KojYYsxie9MKbAWqMNDFkdghxjmUxxOrXIJx9NubLN7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XC1PkcFl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4363ae65100so21637945e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 13:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734382901; x=1734987701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d+2yuQ3MPs+5fm0nNe8a6RE5qSIZ9qt3HDK3JdmhFX0=;
        b=XC1PkcFlyaK1MZsmppXRNiaBtprlwwQ8y7XAwrmyz+j9K1yz1bK9lBzO9pMPlqVYHo
         cxci5AGB3rEnHYqjO8VaUTI0J5xFv6RcRiK5nlML6ZcUl1tpu8EziG0ZbKxqxM3Gv5Se
         AO4/LmAr0/1hyV22lg3N0Z1QC7gALtxc03Fzov+6sTDdUdF80BQqv/t/MX2Exozi4NRx
         F6HG0abB2WPCzemH082gjKZJ5/IKOX9j5HMLFYvCRcwhHlf6HDPSoLRwpusxDsdDJgLf
         vdwlxdAtyY7iPdyqqnh5ofjjh38g03XAoeO9hMoQN+o7nSCXCLwxge2o8VR+Agrs3mEC
         Zh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382901; x=1734987701;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+2yuQ3MPs+5fm0nNe8a6RE5qSIZ9qt3HDK3JdmhFX0=;
        b=Q9LLTWs57yRUytwPZM2FOlzjpxYs4V/0zYz9UluQXM+f/q1+PxA32Ve+f3ZxSpOO3b
         wORefakn6Q7BLUCPL1ga0aV6AepKS3aD60o5c0BXZtuMprxsw/DOmxQWnhkkenshtzuU
         i5apg9YHx6qg4X0Cb60jNitIJK0pKxeJPKhye74aG3K1bYPvTOW70UApjY6I8W2/p5Jm
         fyxCLtZ+X6si8g1DBfT0M+uGlmK8jq3vA+r8n1rPEh/G2cIKCfJIv7SEGdXGjuT4SMI1
         9Qp6y4VrRiMY6Qw9UolTXLBO6xxSqfa4PSP1ePtX9Zw90rRh2cuWDR7msELQyER1tXqE
         e/2w==
X-Forwarded-Encrypted: i=1; AJvYcCVQQBvzn7dug+VnymKpqjodPhQeNEMNXWeM+A1YcM+/AfM/Y0CZDjo8ACi6PaVowBWYPsZWE9yiIZLl5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ZiyU+tbwvixy6tPNnQFuKo02cVXbVJnqUgTVpt/wfqr53sdi
	mBK2qB+AG2dFjCReNWoX/OeIV3BYirtRKoCdFxP/l70UOMhY0qeCqYr8cDyQcAQg/uK1X3CWzth
	h
X-Gm-Gg: ASbGnct7RfVbc7YatonuAQbWF3SkESKN/KYE4fxGNzFDT65WNOaVNBmjBYeihFVVvt+
	Nw9wrw8fA53wuemn4AXgW4YbDF/9Ha0eTN1wNn1Ixn+9IPMtJ7sZa/ZNkNPmGBDHb3u0olJNOlE
	Q18uXudf7Mz4x33SMTgOl8pUebiZyzzPYd3yLA2DHf0MZ5F6zQNo/LbU82zP5y89gM7VIqJQezJ
	2cYyGKIhyZlRkHm7EL9IV0yRJvDhDGshWJNXBBMg7gfHDUqma4rNh1DZl1LDyssH6Tb6EXVVMRA
	/Z3TjO7O
X-Google-Smtp-Source: AGHT+IG73lQPkQ5zwou8XyqNWLlRID2dIJCNLvWuqhFKLwkfbQmzOogiAPle2gWIImOeaW9AqQyVwg==
X-Received: by 2002:a05:6000:18a5:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-38880ad912fmr12230546f8f.22.1734382900820;
        Mon, 16 Dec 2024 13:01:40 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bc05a1sm5235525b3a.173.2024.12.16.13.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 13:01:40 -0800 (PST)
Message-ID: <a6a641f6-b0a1-4915-912a-638cc07eba88@suse.com>
Date: Tue, 17 Dec 2024 07:31:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Leszek Dubiel <leszek@dubiel.pl>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
 <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
 <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
 <ea8eb95c-e64a-4589-b302-23eb1fc6bd5c@dubiel.pl>
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
In-Reply-To: <ea8eb95c-e64a-4589-b302-23eb1fc6bd5c@dubiel.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 03:42, Leszek Dubiel 写道:
> 
>>>
>>> It failed now — there is 258 GB free, but balancing didn't help to
>>> restore unallocated space.
>>
>> Because there isn't that much free space to reclaim in the first place.
>>
>> Your data and metadata chunks are already very highly utilized, you can
>> increase the dusage/musage and retry, but they will only bring marginal
>> gain if any.
>>
>> The only way to go next is start deleting more
>> snapshots/subvolumes/files/etc.
>>
>> With more data/metadata space released, then try musage/dusage again
>> which can free up some space.
> 
> This helped.
> Thank you.
> 
> 
> 
> My system was deleting shapshots automatically if there was less then 
> 250 GB free space.
> This procedure worked fine — 258 GB was free.
> 
> Second procedure was balancing system if there was less then 8GB of 
> Unallocated space.
> This procedure couldn't reclaim free space to makie it unallocated.
> 
> 
> 
> 
> How to improve?
> 
> Tell the first procedure to keep 500GB free space? 800GB?

Increasing the free space will definitely increase the chance of 
reclaiming space using balance.

But that's only increasing the chance, never to ensure that.

As you can keep 800GiB free space, but since your fs have 8TiB data 
space, for the worst case scenario where all space are freed evenly 
among all chunks, it means each 1GiB chunk will only have around 100MiB 
(10%) freed.

That is not really going to chance the result of balance.
But that's for the worst case scenario.


> 
> Or change the procedure to look at percentage of free disk space?
> What is optimal? 90% should be maximum of occupied?
> 
> This is system for backups, so this could be almost full.

If you want to be extra safe, the best solution is to use tools that can 
report the usage percentage of each block group.

You need something procedure like this:

start:
	if (unallocated space >= 8GiB)
		return;
check_usage_percentage:
	if (no block group has usage percentage < 30%) {
		delete_files;
		goto check_usage_percentage;
	}
	balance dusage=30
	goto start;

Although there are some concerns, firstly the tool, sorry I didn't 
remember the name but there is an out-of-btrfs-progs tool can do exactly 
that.

Secondly the tool may need to go through all 8000+ block groups, thus 
just checking the block group usage itself will take some time.
(IIRC if it's using the tree search ioctl and the fs doesn't have 
block-group-tree feature, it may spend one or two minutes, just like 
mounting a large fs)

Third, since you have no control where the data is, at file deleting 
stage, for the worst case you may have to delete 70% of your data so 
that all block groups reach 30% free space...

But at least that should be the most precious way to keep your 
unallocated safe...

Thanks,
Qu

