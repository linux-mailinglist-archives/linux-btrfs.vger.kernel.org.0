Return-Path: <linux-btrfs+bounces-15912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E23B1DF39
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 00:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340E2582CD9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7E21CC64;
	Thu,  7 Aug 2025 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J2k3l7Ak"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E221D6DDD
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604281; cv=none; b=uo/mezwqcW9eE6xgQYslVaL9jtavZSS9T4l4T2AFRYpDI5ORMI6q0wQjL4k7E8t44ZBWbosZ6h/THmZMkB51rFiHOesQhbiInzyqrYfq/fZ0n9zOPHqnPKrNV5OjZkJUxc+R0NCn8GMERp16UmK6y59dfc8a5sCEgmO7MSvFM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604281; c=relaxed/simple;
	bh=isYS88TmpYOiy4EKejCZkJwz8Rd6ovDSfjysyZ7IwIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiPB+y/KILSnnC+knsopGWZn/GjCl9AhAS0QErJUxmcR3IWhrPT5uuzv0i60yFtdJTAhkQ3d5TeLrY9EO5bo3tb2GgvwkCzxI479FN0iO5/sxssIZwEdtbynLEblTRYiNAuPw71orxvGxv43+8bPAwNWvygwTsIGyCpBYTZBrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J2k3l7Ak; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b783ea502eso1172318f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754604277; x=1755209077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jxrGwWHXgsrFZHDmvlcTkaCBQQLE2sZalS1VaFWUT4E=;
        b=J2k3l7AkUqi8dree0KcloiSADmaujZA2UIg+IuMxOSQvoPKB/p8PQniJ2kCZMWaOxQ
         leiMvBgARrRqriGY/9UUlM/6pxKJ8uaZNSwTiS0xMgWhjR909do0m1Y7e4HHKJ4BWtit
         S64Rz+93fh3IOI3de4iDZCwa+gYmdCGaJTOUf+y/MbH/4U3mjU+ttKmKKNgMuwe4KbqR
         SEmYV69DOb1J2C9ue5HcWiWOzMrUogB8RTKGdIhDnDVVmtZgeWWGF2W5tL2VnOMkIdE1
         j5IK9fGC/UkP1QJKS26wz1LLTgTmZm8IrDifGcmbsezlPfDrLExgrlpaVFH4GGhz1U3E
         e97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604277; x=1755209077;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxrGwWHXgsrFZHDmvlcTkaCBQQLE2sZalS1VaFWUT4E=;
        b=IDlVR5p9tVPLPYEJ8dcGkfFx+GT2kyEaQp65/GsBSEpjbdb+vQ4sC58bEoLhHAVpee
         gdiZjV0L4Gp+OJ+irqvGgEExc3lbUA2FshPd7Qr1/tGv4wI3qF7xIbgdoIkb7plzTgZw
         VB89n3B5mvCPu4dBc12k1BZ2INpQrqbg69f5OkPwDlfPvop2ZQt5T8u/Jn9NSnFPiMI3
         JqtxG4HXLtGRIUfbPLs5HSszpDi8GpQus6FBQELVSBZQio5SVV/UUy4DwO5LHnGwSaWE
         +4B2l4kzDGNxFaFZZ695NKh/r80Z93NYuH80Xa5JSBoS8by3XZ31o83Y/Oza2eWLMICu
         G23g==
X-Gm-Message-State: AOJu0YwgHHsMuETjBt3CbdyRIUta76SJW7YSU8dJTi74pFw0iLFqpQfz
	Eq9/V1bhrZveLS9XeN5PYBIB8j4k6sHJypCT5DzkrxVQ7Cn2z+NzB55hvR0dg8SAFoo=
X-Gm-Gg: ASbGncu0akyJu+N/SApX4dXSfYmfcboe1iN7fxYWwLgRPh9kFBObytbZh9wvluiFQhY
	y27oplpTMkfZyJzUfiLXIrdd2G2u9hSyKVRB9nE4CinO57iHKC+U4C69L+Qw4YmTyDyl0I3fUyY
	CUKTgaU3R7GqydaLlSdbNgTWesO7v7rVrOKHR9WdRD8ewQrdA2kwRWJ2KiNzeIVJ8drobWoFobn
	9rCR7iHR2nr0OoKRsB4bpOZaPYKsbJFlM7djgH4Dpzts3sJwR2EE4lO6B/C+S7GCkSCSh8vilIB
	t4gF9xImPqY/mt8Bmxzv8COsFdra/kpSyhUzkSC2Dt7Xg4vBmHLeNPMBzeENAaZpaDGq7vno17I
	Hf0Qtew4NRhfpDUQu5Jjf9KD6Tx5Inqd0GtR5Q7DoprODBjNdLw==
X-Google-Smtp-Source: AGHT+IEmUhoeDcnDo8wQopAcgS3o/axo3KrFcVfVcknlxjuqQsALa25x65EjeVTqWOx5vLfXzFaPVA==
X-Received: by 2002:a05:6000:26d3:b0:3b7:8acf:1887 with SMTP id ffacd0b85a97d-3b8f97e1aedmr4239675f8f.13.1754604276761;
        Thu, 07 Aug 2025 15:04:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49fbsm23254768a91.18.2025.08.07.15.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 15:04:36 -0700 (PDT)
Message-ID: <85ed4a22-a87b-4b92-b636-9156b0271c76@suse.com>
Date: Fri, 8 Aug 2025 07:34:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify support block size check
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
 <20250807175757.GN6704@twin.jikos.cz>
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
In-Reply-To: <20250807175757.GN6704@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/8 03:27, David Sterba 写道:
[...]
>> +static inline bool btrfs_blocksize_supported(u32 blocksize)
> 
> This does not need to be inline, it's used once in sysfs handler.

There are only two call sites, one in btrfs_validate_super() and one in 
sysfs.

Considering how small the function is (an if() with 3 conditions, and 
one ASSERT()), the size should be good enough for inline.

Haven't yet compared the generated asm, but it shouldn't be that 
different between a function call and inlined function.

> Also
> I'd suggest to rename it to btrfs_supported_blocksize() as we already
> have btrfs_supported_ elsewhere.

The new name indeed sounds better.

[..]
>> +	for (u32 cur = BTRFS_MIN_BLOCKSIZE; cur <= BTRFS_MAX_BLOCKSIZE;
>> +	     cur <<= 1) {
> 
> "cur *= 2" reads a bit better and compiler will turn it to the shift.

Sure.

Thanks,
Qu

> 
>> +		if (!btrfs_blocksize_supported(cur))
>> +			continue;
>> +		if (has_output)
>> +			ret += sysfs_emit_at(buf, ret, " %u", cur);
>> +		else
>> +			ret += sysfs_emit_at(buf, ret, "%u", cur);
>> +		has_output = true;
>> +	}
>> +	ret += sysfs_emit_at(buf, ret, "\n");
>>   	return ret;
>>   }
>>   BTRFS_ATTR(static_feature, supported_sectorsizes,
>> -- 
>> 2.50.1
>>


