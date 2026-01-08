Return-Path: <linux-btrfs+bounces-20223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A9D0105A
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 05:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854CB304F15E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 04:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE692D0617;
	Thu,  8 Jan 2026 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNtSsJb1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC102C21F2
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848085; cv=none; b=oA7huU7TJF3VGg0ImlaPKYD/J2U2QM2wN9ORTzmSIr+ryRzjRRm2MkcpsDmjnYx9j/5NOd0C0zRjQIulHcaACiKbvfp/w93q9fLPLQwY2ee3COHoj8Dn1MyliMBkP6gWNht9Od0cNyOdp8tvTfEkAZHl4HYqyrI+uEOi4Z0MeyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848085; c=relaxed/simple;
	bh=lf9tbZPQC2vldXc6xpGlIahad/kFPImjZgEqDBquWQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkLrb/L0VZCXHFCeuWgz6e5ZEfsrhWfnXt5rubwIf9jF1BBaBzLnXABidUYnF9CPvTtJQ/j419yB35QDGn70neyaW+jDJAD0JyWqVYksqhzD9hOSZp8oUUs0PPXXr7o2LlJE0iU4hAm2Y2TXJ4FVqWOo8Wsgz1/mXDs7uvkhgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNtSsJb1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so27943765e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jan 2026 20:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767848082; x=1768452882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AczRykxlHPGe7GMjyjFSL+mHmZOPG+Sx8I2PL/1Jdt4=;
        b=KNtSsJb1ke3sjeKEq0vrusnYgFu2P/lmOIOpKXmjJKakrAyDh1WUwX5g5GYXIo6QQT
         JNUOaAL/5Y2Giae2bhYt96BxhqB6x1moGfNGG4nOeLhFBUpPQogXp/g0gBEqt7JEqgCX
         LX615I+X48JbFVCSm92kTbl6e2wyemtzp6p8+MmlMOOOJ0WRVJXuDrMKOYm4MQdmiNNb
         +LGjHUuUo1hSyB5N9MN5y1CxFUPoNrb5ns9ygOiIPPmHfNRaxRf6if/MGDGfpKu3W478
         ldVrAau0uzb+HWTUiRYs5yvkjsD5d6miiyRVkzi2fEe7R+Gift2h4pDKD5thjwIJ/Omb
         aRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767848082; x=1768452882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AczRykxlHPGe7GMjyjFSL+mHmZOPG+Sx8I2PL/1Jdt4=;
        b=WjsNZa7LxaP6zWmaY+PWbTIloY4kLyYViUxoR6fvPcSnNDSA0K3p9TPi2ZZfQEVzoD
         59Zcxrj+CsL6a1F/Mr1E8EgHLPgnCUo1Iy4NE9kTdfGeZ/2KHZHNA3mTQDzxAqIF7iK1
         rT1ZBsqEfifqMzVX8OrRUEZCV0pBMDKpBJZ/tF2xwyk5iic8fcz50jb6+bisZfXkOqJm
         Xg7UKDajC33grRhbdSGhp8MKqh7atCv6tEbTIgFGC+MHDnj6O+GujjxMDmxtwqOd2pbp
         /EMeblr4kZp9L12aOlzGOJzERvxx5e2FPe9fasPi5L3mf+yfYsT1MUni+4+me1hL9jYm
         uVkw==
X-Gm-Message-State: AOJu0YwpMKm8m6YOrsD8cD3DZ+cOTzqziZa1I1HCjy8ddMKvvZblXkwC
	EEduF1hConzsEvvT4B8qIuZE9TZ0sjDFKbxJGPrpyyer47elEe/geyerJ7VtfB+gll2GUFOfXyT
	XrlpkQkY=
X-Gm-Gg: AY/fxX4ubS1NeCJ/NEYvDOj4wUQ0B0TOdgAS67IDahLWoQ6ASlqLL8oSziGkEQhsdKq
	vNyRegq6R8Sitt8q2CDk+oqTYCc6rXwDa1DCc64zwgOSLS2Dd1GpegzJyAfCnz8xr4GGkLP1xYP
	0AZTjKT1+vpORyYiw9se3PqQ46nvTHhxeBTdxuQt1LZSu6oTQvvKHnJo9t6vrAFMIgl4xCafxon
	fPu/L82tWPkBXmUfu66b4bB+a5EI2IR52Zw2RfgDTdyNUoSlsIpKU9Ti635ry11Ms3nqw4ounBS
	842Rd/7ZWxJMtom/16/TkIcyyYCamblBiYCWyJLkWGmJ9lv8WZoS9fOmxSiJnnzbCd+4iBZRsQd
	CiUzo2jNxJKHI+FkJzhyOSbe4UgEAy8vypZnn6Z1Ky40mWx6olGF7vZmNhKViyynhsUQNoq/Dbn
	51LAOR0yh3VavCrN9/swHvKQV2SPaeOval8k2aMVk=
X-Google-Smtp-Source: AGHT+IGkg0TS5yv/M017VwTy69thPMHq1IqXsmFSRrevFQVF/Y/ljPBmHkh+CPPDLHwzJPlyCPcrSw==
X-Received: by 2002:a05:600c:c4a5:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-47d84b347ebmr65698235e9.24.1767848081504;
        Wed, 07 Jan 2026 20:54:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm64153695ad.73.2026.01.07.20.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 20:54:40 -0800 (PST)
Message-ID: <35a26759-cd26-4d1f-9d84-03d13e909f07@suse.com>
Date: Thu, 8 Jan 2026 15:24:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: mkfs: use device_discard_blocks() to replace
 prepare_discard_device()
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
References: <284c38aeccd4abefa2349d2bab1cefb09e89b5bd.1767847334.git.wqu@suse.com>
 <20260108095120.0d85f706@nvm>
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
In-Reply-To: <20260108095120.0d85f706@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/8 15:21, Roman Mamedov 写道:
> On Thu,  8 Jan 2026 15:12:17 +1030
> Qu Wenruo <wqu@suse.com> wrote:
> 
>> -static void prepare_discard_device(const char *filename, int fd, u64 byte_count, unsigned opflags)
>> -{
>> -	u64 cur = 0;
>> -
>> -	while (cur < byte_count) {
>> -		/* 1G granularity */
>> -		u64 chunk_size = (cur == 0) ? SZ_1M : min_t(u64, byte_count - cur, SZ_1G);
>> -		int ret;
>> -
>> -		ret = discard_range(fd, cur, chunk_size);
>> -		if (ret)
>> -			return;
>> -		/*
>> -		 * The first range discarded successfully, meaning the device supports
>> -		 * discard.
>> -		 */
>> -		if (opflags & PREP_DEVICE_VERBOSE && cur == 0)
>> -			printf("Performing full device TRIM %s (%s) ...\n",
>> -			       filename, pretty_size(byte_count));
>> -		cur += chunk_size;
>> -	}
>> -}
>> -
>>   /*
>>    * Write zeros to the given range [start, start + len)
>>    */
>> @@ -293,8 +270,16 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
>>   		goto err;
>>   	}
>>   
>> -	if (!(opflags & PREP_DEVICE_ZONED) && (opflags & PREP_DEVICE_DISCARD))
>> -		prepare_discard_device(file, fd, byte_count, opflags);
>> +	if (!(opflags & PREP_DEVICE_ZONED) && (opflags & PREP_DEVICE_DISCARD)) {
>> +		ret = device_discard_blocks(fd, 0, byte_count);
>> +		if (ret < 0) {
>> +			errno = -ret;
>> +			warning("failed to discard device '%s': %m", file);
>> +		} else {
>> +			printf("Performing full device TRIM %s (%s) ...\n",
>> +			       file, pretty_size(byte_count));
>> +		}
>> +	}
>>   
>>   	ret = btrfs_wipe_existing_sb(fd, zinfo);
>>   	if (ret < 0) {
> 
> Before: the message is printed after the first successful discard of a 1G
> range, so with any real-world device at the very beginning of operation.
> 
> After: the message is printed only after the full device is discarded???
> And it still implies the operation has just begun and is in progress.

I'll change the message timing to before the call.

> 
> It could take a significant time and it was good to print it in the beginning
> to let the user know what is going on.
> 
> Or I am missing something here?
> 


