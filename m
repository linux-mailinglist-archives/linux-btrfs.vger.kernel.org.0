Return-Path: <linux-btrfs+bounces-10053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF029E32AF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 05:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A18BB23FD1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A451616C684;
	Wed,  4 Dec 2024 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gb3+s/s1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7A38385
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287213; cv=none; b=ELhCEK//UR3NV6bt6TM70opXCsocAjGxcCg2RGmKeLvU6hPHXWL6AZIyV3Uy2jikDHx/LN/EPpG6bOR/KQhQ75OSazr/qnIvRBq4PjUd+f4WL3+1hU9DNiRUdOHPQfzffYXlBQJSPEz+KbFhU4vGf4zZsBHVWKM/Vv+17U3n1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287213; c=relaxed/simple;
	bh=x0cGoUmti/5/ki8WxvHkMg98Fvs4MFu+ilWQk3meKdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEurtEWlMFOYj3YA1tvLdP0kFmsnaBnGMitsGiyBvPm/nZwsctowX0jLuB8641rMR5umfc/5ICMF4hPzip4u87BQq7/xrISKOK2eWUbZffogcd+2dWRwhFlO1LY71D6DfT1GrG8tSWgTVpaHhL4VcSIpRHaMDOZ6rfiBMV0wQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gb3+s/s1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385eaecc213so207754f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 20:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733287210; x=1733892010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hCA6IjZOYItopTKJhZsjay8gBUdAKKF/WRv1v8xAxKA=;
        b=gb3+s/s1sPfiYJa7nW3L2YaSidiPRVDYBAS0ZL9D9buF5JKth+8v7vyI0/ZJXA356I
         X3euvwznEK5RUGuf0bRpdgu1mgW9akn7isZ5qnZbqsaMLkX9VQi74KL2VTJAVKlfCSgX
         Vtmfr1KKsR0CgP0FIjNt7R03atb/3FZ/GKJP7E9q50J8niCDwVlV/VhkvE3uPlLWAniD
         nNfbvAuG2lR6bu8OI+DP57XEHA6fJpeAROkeJUPEj87C89JnIIkLR6EbKns8JAR/VY+2
         r5RvXmnMiMIdgBcMVl0vx0xWUYU6UUdzdLdXkhRYVNPmsa+vQCAToZK9U9sDlz5zVmiy
         tIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287210; x=1733892010;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCA6IjZOYItopTKJhZsjay8gBUdAKKF/WRv1v8xAxKA=;
        b=moQ86+tBGufkBDp3K1N91iiAH1eJSiEVHd3UPE2gBEzDobh0+eNpLNI3DB3PVocv5G
         YMe1bj1yO0tWTq/5ZYO3bUNr/9T7Gb3M01ba03qeVFCoJYfkNKcbS1E49WgeL26s59uy
         kZ1TkFyYb22YyDTM7N4sPLjQe2xUzICZVGS+3z2ODKQ0btDLhf07LVmM4c3xXgaqWBf4
         0iH0srZmWlvrHfeBuQxrry3LhSpSH5dcbEqNdLrx6V1wXNPc6PwXGAi7lbnET/oneVjU
         1iXpe14EyGl8qYMmzB8lePpT5ktPigqqQsealkuRsS5LCjhO73Vc5VXO5kQYl3DiguB8
         AiVA==
X-Forwarded-Encrypted: i=1; AJvYcCVdpac0I1u3PqznTJsCqgOMWCqevCxwyPnnBDt7DowdT/smnMN3tY3mc0NqI8OFTiwGL2l0oinRtqPCxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVbXC7XdH83eJMdBtUmQOEytyG6ShfLKrDyO8RDHph68QMEhW
	cifog1J+VB1bsRi+cZlwZmfpMGktAhMQMe8XznODVpNzvQlSe8A6YBZ1Egfn2IbVdzIj81+dRCU
	l
X-Gm-Gg: ASbGncuwzQt3iz03fJwf0+wLzOeCsjzP9CLDAXTkhzXk2SDcnsy0PySDLMwgFQUP40c
	OtxD2oCS2YSCC+XXwhMayeMu41UMpoFSUUZAa5h/dsb7OAbWhGZc9cPFkLBAYdvJPvUbF6G9HA2
	puFnnwGYU+HsOcrcpl/04tjdjlvzlekgPUN8DyA8q2JrRHycTY0pu7lkYYpiSmiLXHmXXpbYIDk
	zTgQ8fQSjJcA2SItJQQ7vlw5kn6IGK9tlPvaKWdr0WfdIhbGGDde36J+L7KMnMvc0xy2wlUY7ln
	Wg==
X-Google-Smtp-Source: AGHT+IFrEa9XHRUANnjIlaj7yyYv1qshxjs2Sa2E6+319V/z6Z3wAFYhtw0oH3So0NqIKpmzDY82uw==
X-Received: by 2002:a5d:6c6d:0:b0:385:e986:416f with SMTP id ffacd0b85a97d-385e986435amr9716185f8f.10.1733287209524;
        Tue, 03 Dec 2024 20:40:09 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157433ef73sm57006455ad.177.2024.12.03.20.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 20:40:09 -0800 (PST)
Message-ID: <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
Date: Wed, 4 Dec 2024 15:10:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
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
In-Reply-To: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/4 14:04, Scoopta 写道:
> I'm looking to deploy btfs raid5/6 and have read some of the previous 
> posts here about doing so "successfully." I want to make sure I 
> understand the limitations correctly. I'm looking to replace an md+ext4 
> setup. The data on these drives is replaceable but obviously ideally I 
> don't want to have to replace it.

0) Use kernel newer than 6.5 at least.

That version introduced a more comprehensive check for any RAID56 RMW, 
so that it will always verify the checksum and rebuild when necessary.

This should mostly solve the write hole problem, and we even have some 
test cases in the fstests already verifying the behavior.

> 
> 1) use space_cache=v2
> 
> 2) don't use raid5/6 for metadata
> 
> 3) run scrubs 1 drive at a time

That's should also no longer be the case.

Although it will waste some IO, but should not be that bad.

> 
> 4) don't expect to use the system in degraded mode

You can still, thanks to the extra verification in 0).

But after the missing device come back, always do a scrub on that 
device, to be extra safe.

> 
> 5) there are times where raid5 will make corruption permanent instead of 
> fixing it - does this matter? As I understand it md+ext4 can't detect or 
> fix corruption either so it's not a loss

With non-RAID56 metadata, and data checksum, it should not cause problem.

But for no-data checksum/ no COW cases, it will cause permanent corruption.

> 
> 6) the write hole exists - As I understand it md has that same problem 
> anyway

The same as 5).

Thanks,
Qu

> 
> Are there any other ways I could lose my data? Again the data IS 
> replaceable, I'm just trying to understand if there are any major 
> advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't care 
> about downtime during degraded mode. Additionally the posts I'm looking 
> at are from 2020, has any of the above changed since then?
> 
> Thanks!
> 
> 


