Return-Path: <linux-btrfs+bounces-19159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D6C71189
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 21:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F21E234BBEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 20:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3310F329E59;
	Wed, 19 Nov 2025 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MZ6CA9e2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613C2D77E2
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585703; cv=none; b=GT68ATtuiX4jG4M7sFVncUUiySD9T06fjhCnUJ7FTy+kxCFqDh2Gjc9vtyuGqeX0wZnJmOnXLsOVDLk7eWJt9FtZnwWFf3xUwnj7HVWn0uW6eNAa7RaDLELN7rFtGFhX+J+ovzux8x9gc5YSVgc2hYHEa5FtfuSBujqWkuDeE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585703; c=relaxed/simple;
	bh=Z1eca6eu/sArtX5+5WJvCNWL75jaOUufBG39UaYZ1Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fSNRHDUw/ACFEmEiXQznabAombcpnpYQfpJwxLiQsbw1H1wrBI3mIzpIKdlTpNO72cefMapZrTM/KkXyIG+qbW++LtnCcaVnDjUacQMhIeAkfTkCQAzrz3gXuIAM6EgAfhQUDUCPMkb2/lm6uzj8Ux7fXX2cv9rLFkA2h7zQ8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MZ6CA9e2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477770019e4so1824365e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763585699; x=1764190499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AWU/XNqKjhAM8vsfzQubNSb/OjdbaIH8rPYL1NHALqA=;
        b=MZ6CA9e2Yvr/0hviMod0pI+7Dp2aG7uuvEoyELb9mAo+Rc1tuPeh4blCkFVDxNsd3T
         W1rUEZdkDDDviftQUPNP3Bi5iyt9JBTzJL35vntep4kNB8UIUq8+2op335bBKpV0saqN
         rtG/HHFZHHN5GSb/aJDt9YuUA+YLQCtAVkBbwiSoWwfBAe48f3/o764dCxSkYOEDyOIL
         akDev8IcBX2U3lnZucm0LXbMLurCprmay4DHL92cRPby1VGPF2XNWmPPFB5Z9avV/L81
         gORbcYYr/n/zLoM+u6WtcTf4lQ+UGo7u7EH07NwpIAR6JiCelYaQHytAD7hjPFiRYk3c
         FisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763585699; x=1764190499;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWU/XNqKjhAM8vsfzQubNSb/OjdbaIH8rPYL1NHALqA=;
        b=PmJgRoNJ9oAV1sqALfySOplm0RRcQufSi6XyTG3DWJ/Tmm4DWbZAq6nk93yzGZmm3J
         MDpg/dznmDibVFOg1bvhFY0MY6CIponG2Wwp+4wStgqimOEYDbtP18JPna8jUdFdKI+C
         /Sjbr6icJdJ7iYCwjYfoDiewxYc30u+cH8kK+BScQgw9ghCPisSdvxyuLeF1uxr3b17h
         HtEdxh2LE4GJc0Far7J+sMGp1V7iag/gNWOJri4kVVcVOS+Sc1qsRrN5urCbw3jHNCt+
         OhInOaJ9QPL7wojkgxD4DxGqbqssjRJbGtnZOSGpqSFTdkXONibgw1BN3mNQ9kzRfOrC
         o0LA==
X-Forwarded-Encrypted: i=1; AJvYcCWDZV9FtfGlZaBoOQ8orKH5C7LHewv45e8QQSFxYgnqWLKb2c+SS+vGcxTUZv1O6FMmKJNt0Jgo4HAoaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrREPUHraWjvXSokgZNZ1Uvzn7hGTlph1K8tjjjwqbb71WqzBE
	JoupM8eK8wbpLqHOi7pIuo8SPuMSIPIY48x+yLsUYG6Vlr845fuuOOpQ2UxE2PzTEpHE+UsHEGY
	EY0On
X-Gm-Gg: ASbGnct4e1xLY1WSwrMdXxijeR0tHb9LgxTabQRxCBsg/w7xvPPTzRCbvH0SpsZTTG4
	NhLcZDB57IpCSaxLXtVWJjcuLvVHUf6/QAgdSvFHujpI5Cor0mUkapGNC0dO/qiJODKdZb31bMD
	ctDmVRSoeEyVRWnkA+csULMnRDOsViamFvnv3CM7U7bbPD61c2CIFmkRFzGn9dg/rXvPJmYR2Gs
	lrzYm4+nIW0DF5qFhjniOvEBWwMopDJbkl4eGFduZd8df6ltuGMeTprhnIsIEVA0K72k9/T0Aye
	hlIvjbhwu69IsNF2bff4al1jYG/kS6YGvUgrEVlid0travN8oyCGbQByfK/xIUF3zf+ektvTciV
	a2BwWqeqqEEe9joehkWknrVZYDS/G4FtZq4MuEjvGpZ+xQA+94U5n53UrtK5L6BqUhrCLmqSdKE
	FseJaTcgX0Q8AGZQEyXupWL1MnBnY8K7u4JOcFzRLr8+7TGIwCzqv6ooTbmZdj
X-Google-Smtp-Source: AGHT+IEpWesBzJb8UyA8+DwI8SAuTlmgojM+1XHA1VP0Njyr0UfdwOLVXMH6xiHQ0WmjdvvhHh2/hQ==
X-Received: by 2002:a05:600c:3590:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-477b8c92773mr5523375e9.28.1763585699144;
        Wed, 19 Nov 2025 12:54:59 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd7610a6f80sm332249a12.32.2025.11.19.12.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 12:54:58 -0800 (PST)
Message-ID: <3fde2de2-d209-4028-adac-fb53e6a89dd4@suse.com>
Date: Thu, 20 Nov 2025 07:24:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to detect ram memory going bad?
To: BP25 <bp25@posteo.net>, linux-btrfs@vger.kernel.org
References: <665d612165e1f21e681d3b1229bcd40f@posteo.net>
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
In-Reply-To: <665d612165e1f21e681d3b1229bcd40f@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/20 01:01, BP25 写道:
> Hello I'm writing to this mailing list as suggested by the btrfs docs. I 
> wanted to ask how to detect and mitigate ram memory going bad when using 
> BTRFS? Because the 'Hardware Considerations' the BTRFS manual suggest in 
> this scenario to run memtest; but this is probs more like right after 
> installing new ram.

You should always do a stress test after hardware modification.
And it's always recommended using things like memtest86+ which is a raw 
UEFI payload, with minimal memory reserved, so that almost all RAM can 
be properly tested.

Memtester can be executed as a user space program but it can not test 
the space reserved by the kernel.
Considering how small the space reserved by the kernel, it's still a 
worthy solution, but it will still take a lot of memory (if you want to 
test as many memory as possible).

For the timing:

If installing new ram, always run a memtest.
If overcloking/changing DIMM timming, always run a memtest.


Finally, backup is always recommended, no matter what.


> Is there any BTRFS tool, perhaps to run 
> periodically, that can help me detect bad ram hence mitigate the 
> consequences? There is a webpage called 'Will ZFS and non-ECC RAM kill 
> your data?' where it's suggested that ZFS scrub effectively detects bad 
> ram

I doubt, because bad ram can easily corrupt your metadata/data, and the 
same bad content is written to disk.

Furthermore the checksum will still match (calculated using the bad 
metadata/data), thus it's impossible to detect no matter what.


And bad RAM can happen at any random byte, if it's some core kernel 
structure, you're doomed anyway.

> (when at least two copies of the same file and/or metadata are 
> stored, and I wonder if there are other assumptions here...), but I'm 
> new to btrfs and I wonder if the reasoning can be applied to btrfs as 
> well, and how effective of a mitigation it would actually provide. OS is 
> GNU (Guix) and I think can't use ECC because I suspect my X200 
> motherboards wouldn't support it?
> 
> Please CC: or BCC: me cause I'm not subscribed.
> 


