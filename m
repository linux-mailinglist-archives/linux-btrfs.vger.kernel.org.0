Return-Path: <linux-btrfs+bounces-10341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4659F0591
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 08:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CC0169C3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7411991CD;
	Fri, 13 Dec 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EfUo4OUB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C93207
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075160; cv=none; b=aP2XTRJi9yYnI/OaZBFLA1qk76IisyLj/CNZiQjfOvaix4We5tTzLBmNVpFIQqsxNlTTv4kHCLAMeTXk22SbkyOk4JsQwTolbCQUmsC2N5fYN7T3gXbz4TIaq6MGDOgNWYeb+tIu5X0SGXOsJrCF6AfN2/wW5m4kqw0SwJsOWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075160; c=relaxed/simple;
	bh=qLdbf5KJ1GIW4nK//Y1oSoIycJp+nE7HilEG64rwAw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzHaBoiTGGgcP7vGsbYQEljdhj8jLjF3nyE75jrtO83ekpRwlJiuHLGJyZ4Lh/uxvyHJR2IwungAzy7FA1QD9ZNVIhwSYuVDTyF//AW9jTRE0Gp5rk6CK00cI/7PqhKUJgZPyMQq9Nk3AHXEOozaPrUECmNOayTGD32oT59xUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EfUo4OUB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e0e224cbso739699f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 23:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734075156; x=1734679956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W8LpfwMxyI4OxNxPuOabUz1/FCPGYK61EZbqbX+xHkU=;
        b=EfUo4OUBsPBazZsDjHkLmUETZOqu2LidEqk4wJWbr6NJHVLDbZcCRNt0yn6EZATQs0
         oSgyBrXwR7g9M5OfNG9ZReCLyY5ewAKnNtvkbh3SKRkXAEiTLCLvnudSTssY75NMHAc+
         Y5o1FRnyqfP5kTo6VnyjvYB+8lsb+EE+rl0QsLsRLhF8AA6hi/5875Vgzc5qlXjV0RQL
         v/C451MBlPi9hrWdvbAQoIl7KkAhPHxRV3nFcgY4xmw2gu6dXh5vlrlVZiQo5HgrJ38e
         vwFtSXlkOrwe5LB1KLFJd4YAcqWj6FnYhEAX5nFq6Pyb84S+yf3Sz+OL0SjMM0/MODsY
         yI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734075156; x=1734679956;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8LpfwMxyI4OxNxPuOabUz1/FCPGYK61EZbqbX+xHkU=;
        b=dKlMsQ1dBxm/cuXRqqxn7Nirn6yQ/EznUYVENHz1H3+rD5xjA+2aR8F79Vio5mJgfo
         Hyc6F3HxnA6/mPfYy6JrutvQmYSup6F9rF7KdtGnBVjsy2oXFYMH5eLk/0OEzpdJMb40
         5QLXEcjNtDpX1KvEfcH83AEtd+1fab8jZjtqQSLnEYyG+W1gzx2g0BDc1CuTsacGn50J
         qu4Xl479AXZ4ndc9sfl4RhsRR4Gu3KKn00596t4g37p3FtL3oLibNeRPZdKQvsPhjJ0D
         Q4PHL83+Hqvk6DHqit17X76dBIL61zpDXBnA6awnW6owxiwPQzNtsWSmK4Ux3c2KlIPz
         EWfg==
X-Gm-Message-State: AOJu0YxU79Yb6H9ds15tiWtGDQmqlI6evtrliVI2xzB+7PVI86tEznZx
	R4/RVOFPoMMpB6SZdmbsRdMsmBSixfiveeGNr/vA5CgelXJCrNmdN/JQxGek36I=
X-Gm-Gg: ASbGnctodysymS1BH5eZwTBM4rz4EWytmnwdWWh6TRf4fLXMfo1NC/PLfHoSay69+uQ
	LK1OR4c5WXsupdhb98oFdM4hOJZwmN+X+4bj9FgVOBg6IQHEvXnDHR/Lj0DYKsaqVeplkw0wyrK
	g7eOs70bfghsvFukhYXNIREM6LnVSVJ4AsIsymxG5lKQqP45vOkfJRCtyxJT6UsAm8FzOiPfplB
	0DgzWlMPEZNijVayzW8nPCUcwbkZ5qkEfNq0SBV9d9CyU27gVQoVQ7BCylxzqxalDADUQVMW0Ef
	Fu5RCdLR
X-Google-Smtp-Source: AGHT+IGqqC9Vu99QBRXuHyyulrzQ26RL8KkAmce59RQV72n6icjH4ly6C1qKj9tPmhZEh+wWWKelig==
X-Received: by 2002:a5d:59ac:0:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38880ac61e0mr946057f8f.7.1734075156192;
        Thu, 12 Dec 2024 23:32:36 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21674098305sm56276475ad.122.2024.12.12.23.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 23:32:35 -0800 (PST)
Message-ID: <8ce3be5f-2a88-460c-b1c5-e80fbe349014@suse.com>
Date: Fri, 13 Dec 2024 18:02:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1734033142.git.beckerlee3@gmail.com>
 <c80d0f92b73983e7454291154b3fb6ae555f6053.1734033142.git.beckerlee3@gmail.com>
 <6c633f79-9808-4537-be9f-fc201c032a6b@suse.com>
 <fe2b0dfb-1b3b-4e98-8c81-b4dc98af59cf@wdc.com>
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
In-Reply-To: <fe2b0dfb-1b3b-4e98-8c81-b4dc98af59cf@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/13 18:00, Johannes Thumshirn 写道:
> On 13.12.24 07:19, Qu Wenruo wrote:
>>
>>
>> 在 2024/12/13 06:59, Roger L. Beckermeyer III 写道:
>>> update tree_insert() to use rb_find_add_cached().
>>> add cmp_refs_node in rb_find_add_cached() to compare.
>>>
>>> note: I think some of comparison functions could be further refined.
>>>
>>> V2: incorporated changes from Filipe Manana
>>
>> Firstly changelog should not be part of the commit message. It should be
>> after the "---" line so that git-am will drop it when applying.
>>
>> Secondly if you're updating a series of patches, please resend the whole
>> series and put the change log into the cover letter to explain all the
>> changes.
>> Updating one patch of a series is only going to make it much harder to
>> follow/apply.
>>
>> And put a version number for the whole series. It can be done by
>> git-formatpatch with `--subject="PATCH v2"` option.
> 
> Nit: git format-patch -v 2 also gives you a nice v2-XXX.patch prefix for
> the files as well as "PATCH v2" for the subject.

Thanks a lot! It saves quite a lot of key strikes, and even added the 
"v2-" prefix.

Never too old to learn.

Thanks,
Qu

