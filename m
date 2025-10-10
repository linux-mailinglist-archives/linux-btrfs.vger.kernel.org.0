Return-Path: <linux-btrfs+bounces-17614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C20BCBF5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 09:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EAE19E44AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 07:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB6278E63;
	Fri, 10 Oct 2025 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PD8nE2Ts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B962765C0
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082137; cv=none; b=GtUZshF+iu7XrP2SHFNV4a4D21Bhph+/CyYsA/UoIh6VucqkKkXaXKPdByS1GOz4l/vgUp5NWy14XHC7eyazxpdATIrs2uNj98Co81Bls99RLEcuaRiJigCADEHuzfOte2DOS7VNZlPBKLV90joMtJx5wEXPeyaRzZyPcNfEH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082137; c=relaxed/simple;
	bh=3nEVZ2PT4jI7VFB1mdUJM3M2yrmreHkWTM4JDHYx1H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XVu+INblFUbfZZwHFVulywfr4QFc0wRRRLTCMqGRhKl+IC/gisA1uZE5QMfTgLgtRQRHfj/M8b3JMGY5vgYR8NXrp3EhxWI6ay26tDm9JclyAv3fYwnYJA9ZyMcAbxZKgUkfjub2omSHSV813W+5ye0As+huxlhaK2CgLb9yQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PD8nE2Ts; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42421b1514fso863363f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760082134; x=1760686934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cMrli2NYYgj5fCsrbFbhRUeHYJb0kAs9+v0nFNl+ZEE=;
        b=PD8nE2TsoHA3iX3oglUQf01Jl6VGcF7mS4qYaHfvvggf4UHcabDjnW/pIUyG2Psz5l
         V3HCic3SltAPg7iim8n8puUxzfspRNSSpU7b8BIKl+vkl243397i+OERQtPQ5nqnW2IE
         RPzLhRMnpNA7W0cirhW6uL8Nfai8yABpIdf1fOAY53CXCpR6Co6bLE8xGFH3JVR460VB
         KXL0lIlTbJw6sOGbBSTC7xnEx7SeKtlccsjUil1i//17y7gBrUeb+LJRZB6cmarnz6qy
         ulkCFplQErxeHbZMbWujwYV/k4x/oAiQ02WiWIOMNBSgjBEa/tNkIQOpqofUcH1zRJg3
         ro0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082134; x=1760686934;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMrli2NYYgj5fCsrbFbhRUeHYJb0kAs9+v0nFNl+ZEE=;
        b=FScjnal8vwMKjjlfeyRrgco72uE3hBIfnA69Hx12OsCUXNLqQBndLFOj2+X+qgmbTO
         lCLQxn900RuwhecwAVRlpHPGsJR31r4sDO0dewSuQHezUZWBz/K7UddyQW1/zZpkso5T
         Gl9Q39a0RDv6FdZdnH6TbFPT/ImzYl3/h+3LtV6cDqfIJJ/UoZpCPF/2tnGSTPE7dMq4
         xonQ/VQYeqK0/bfga06ZXlvMiSZRrKIQ22IeFVsLZoxhpdMBnSbbcL3LbZQy+2D/5pQo
         BJ904hoG8FjOF2LQmp8ftnwcuPn2KeaN9L4guh6Xgwapm/fH0PFxQqtnyXxAoH+bYLM1
         RXDg==
X-Forwarded-Encrypted: i=1; AJvYcCVlomW5QgWhJUAmn1B6NgIWk/7ZG+y2khauOz5ZuUyKAzX8SJ6V+UFt/BvPWNk4zKytTxKN7WQyo1oPtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9GrJ090U1QYsCsIVkBcx2pHtm/q8Eh5TFbpVw/njwPNWOiM2
	bKGuDL+SfU7lb9qcQ3P37wqLn1Tf9HBa0J/BEzh/SHd0ZhYcLiRNP5icEC3NeCocPAFceT/+XXY
	R1Tpd
X-Gm-Gg: ASbGncviKdLCHwLmoJTOWZ2ZX74CWKtjTvStf7WgOd9BXrOrMUehqWYuQuBJXweNPp8
	haqEnDNDLC4xv/0mrZXYZOG7htABVZ2Kp6jbDwSvlBm/5u0D4aio+OnFWN7KRSBqUUBplXnH72W
	pVykVJ/NDs8um9zsNosGh+Cgf2i0DjO8RkXney6l6yV+/YmfUxp2uszrNDhyd8WxcPjQ8bV4j0l
	MxQIX7DAirsznMpK1Gfhp3uhom5qM3mtgFtG85lzQOCmuburMMrGjsXggLlGR/9NMMDpNsHy54E
	QIwD0Miqgb02hGCTenWFp1V9lahcH2mFpRtkdAH5VyHE4+XC20oBOYYDCxeM0xOsgLYwT7SqlSX
	mSDFhUPQVYDfNGXn8c8+o2Pv4vQaDfFN5GDLS/ZD5Bcx9CAHcg0xIjtyIaU+zhBF8GdslhA==
X-Google-Smtp-Source: AGHT+IGTcl4xu0ZQEBAVyQ/OlTJo8tt+aKRMrvGdl8SAEZj1RZ1m7faEoR9FTcbS6Ts5VVI7lmuQnQ==
X-Received: by 2002:a05:6000:610:b0:3ee:1586:6c71 with SMTP id ffacd0b85a97d-42666ac6c7amr6824194f8f.27.1760082133780;
        Fri, 10 Oct 2025 00:42:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d15bfsm1834167a91.19.2025.10.10.00.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:42:13 -0700 (PDT)
Message-ID: <d0ef80c6-7ed4-4ff1-85a1-f5fdf108e8f1@suse.com>
Date: Fri, 10 Oct 2025 18:12:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] btrfs: reject delalloc ranges if in shutdown state
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1760069261.git.wqu@suse.com>
 <4c244c7f13e63941f3c366867264c50d4392a8ed.1760069261.git.wqu@suse.com>
 <56575026-9cc0-4ca9-866b-06ec115197cb@wdc.com>
 <44915bc8-9ea6-4776-9b2e-037e35b79f32@suse.com>
 <4831f2ed-114d-46b8-a4b5-ffe62e1c43d1@wdc.com>
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
In-Reply-To: <4831f2ed-114d-46b8-a4b5-ffe62e1c43d1@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/10 17:59, Johannes Thumshirn 写道:
> On 10/10/25 9:12 AM, Qu Wenruo wrote:
>>
>> 在 2025/10/10 17:24, Johannes Thumshirn 写道:
>>
>>> Stupid question, going to error here will give us a error print
>>> (run_delalloc_nowcow failed, root= ... ). Is this intentional or would
>>> bailing out before allocating a path and erroring make more sense?
>> That error message is mostly to help debugging various leakage related
>> to ordered extents.
>>
>> In this shutdown case, such error message will still help, because it's
>> no different than an injected error.
>> If later we hit some ordered extent related bugs (including the folio's
>> ordered flag), such error message will show the possible involved paths.
>>
> My concern here is, that we will get user reports because of the error
> messages. If it is a debug only message, it should be btrfs_debug().

To be honest, btrfs_debug() is useless nowadays. It needs one to 
reproduce the bug in the first place, then enable the debug message.


And concerning user reports, if the fs is already shutting down, they 
will have more urgent problem to bother other than an error message in 
the dmesg.
After all, all IO, including reading cached pages, will return -EIO.

Finally there will be a message line showing "emergency shutdown", and 
we can explain to such sysadmin level users very easily.


The seemingly "debug" error message has already helped us to fix several 
hard-to-reproduce delalloc error handling bugs.

Considering how hard those errors are going to hit and how useful those 
messages are, I really prefer to keep them as is.

Thanks,
Qu

