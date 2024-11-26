Return-Path: <linux-btrfs+bounces-9923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF29D9E59
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645C62857FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D81DE880;
	Tue, 26 Nov 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VtK4DpA1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8D13AD18
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652297; cv=none; b=jjDcgtF0dtRPok4gefKYPvLiLMf2mRDjA1LGuCwC7gFUa7/dp01nZFyZvcrDmDgzoRWj+/H7+UJg8fzvH8P2/qLs4gbKiCvaBJjuDW4dgJBsNmiunG6jCAy/W3Tn73zn3T4qjPZDpMMAVmqreVi2NsIu0MG+f+Hw3Slr74BTEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652297; c=relaxed/simple;
	bh=YkQ8qpP0TATYnqHfYd+XUcsf8A4LfLMh/2ATYwTirGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2PKuTjro9Q7j61Qvlnxd6Y53WSdUO8YECCtUMDR81FGJbOB4NK8X/oSXc4CptlnLRBbPf74Tjn/3y6qRgVUcxKm8R2001c6LRHeVei37iCQNLnNMCM4SR00S6DEJaQ0SHGs5XaMAt5eC4j2aOT6safBiuwgUC4nFN4u+u2XTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VtK4DpA1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3823eaad37aso87438f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 12:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732652293; x=1733257093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DpnVxYvojYmrPX2LNMiiT/2b6M0NiTzXvMbAU80fWdU=;
        b=VtK4DpA19qPYob37RqRdR7yO7HKKHMvJBglvz1YBqri+QQbjgqTo1vFJR7uWSIIxy5
         CE1+C34bW4Zt100twCUWxzAhvTaJBfpb7NxMX1QHRTLKgQOYUewdmsiYnk+ADU/tgCC1
         35OYHQzUeXhCC02JKMlaqawSEgIJxe1kdUsB2tqJeC1Kly6cjCXREfM9HdFWe1YxSe/+
         ypdpt8tZVS4qGfZE/ouxjdpFhTPp7FEr22S4rUz90zDV+GQQidvJQIgAsUIif7zM5jyf
         QYIZ2tcvvYipKYDsfCzH33W1RNZBm0Y0JSG2zFCKIfjqqcLlh1tus0OsFI+XqXRWV6mL
         gb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732652293; x=1733257093;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpnVxYvojYmrPX2LNMiiT/2b6M0NiTzXvMbAU80fWdU=;
        b=ZRc2thuiR4HQISSOsDvbQh8GgHSJv7xIWdOU5p0iWY9F7AHDal9BlR18NY/X36ofPl
         N309bL3Em5t+asSBmAtrH/D+UmBdHrzK/8770bl3izSkVV5i2Me8TF4PeEK4xmHHnW1M
         fCX3uqGRdyvsWM3kbClSXpNwFLeQmoDpvGLRPjQ5I4eQkia4zsfvpM8t2ZkUZtxK0lXP
         ZvCUVtEwq6hqDlA2iUyQrtp6gcQIZ7Cy0qyuxR0xyq6XLOMdWWgPkt/DRZQQ4J4UgdK4
         sA59gPNoLIIVf/uJLWHzV9Ip5KAV7WHcgn2XglcsekxV+56rw8K/LQBDvcQvE/0A8iTA
         i5MQ==
X-Gm-Message-State: AOJu0YzvxhAPGfmnZMpkHME+/SSf/5R1OzqN7Sgac9dbmO8YSjIp1H++
	77kZTCw8irvU7Wlcwb1JzlAsDVZcK5yjkeyHL7t1Bp5zZA9MxMbr1Z1n0ymKmd4=
X-Gm-Gg: ASbGncu4Jws5Folqm4oM2qqTnRAPJcxYogxauVtqQf/Pg8c07bOsckqMhZdqoQcxYna
	3ZTomkzHWVsKcEW2MU7U3/0b+YEf0dtGFT6s8Ag0e6Fcw1PWi/n+Ej0kJ3yknni7JqYC62L3Q2H
	pVouMpD38/XU6FLkRxFtS4cbvywen8+1WAdxUdi1IbHSTBxotjGWc9Fwc5ljgK5tlr34Bhc2Io8
	Csq+zo2ft0nQoQm1+EES5hoO7m8bhx1dE2QIMR/1N9AE7/p5/HsRvJQXhMKdJXBLzIRlektLHLv
	xA==
X-Google-Smtp-Source: AGHT+IH3QG5CT0YsZdZxpxxElI+M3798SYte7iX+8rU5+cZVy8cmnvNX9trtBemTg7o/Ss7VHA34CQ==
X-Received: by 2002:a5d:5985:0:b0:381:f0d0:ed2c with SMTP id ffacd0b85a97d-385bfb1e4d0mr3716323f8f.29.1732652293195;
        Tue, 26 Nov 2024 12:18:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e775819csm8211293b3a.0.2024.11.26.12.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:18:12 -0800 (PST)
Message-ID: <e6211467-c1b1-4dcc-9ec9-96d69a3c2948@suse.com>
Date: Wed, 27 Nov 2024 06:48:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: validate system chunk array at
 btrfs_validate_super()
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <5d205dc4e1126be4c33b1eac62ba625075749469.1732080133.git.wqu@suse.com>
 <20241126182132.GN31418@twin.jikos.cz>
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
In-Reply-To: <20241126182132.GN31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/27 04:51, David Sterba 写道:
> On Wed, Nov 20, 2024 at 03:52:18PM +1030, Qu Wenruo wrote:
>> Currently btrfs_validate_super() only does a very basic check on the
>> array chunk size (not too large than the available space, but not too
>> small to contain no chunk).
>>
>> The more comprehensive checks (the regular chunk checks and size check
>> inside the system chunk array) is all done inside
>> btrfs_read_sys_array().
>>
>> It's not a big deal, but for the sake of concentrated verification, we
>> should validate the system chunk array at the time of super block
>> validation.
> 
> Makes sense.
> 
>> So this patch does the following modification:
>>
>> - Introduce a helper btrfs_check_system_chunk_array()
>>    * Validate the disk key
>>    * Validate the size before we access the full chunk/stripe items.
>>    * Do the full chunk item validation
>>
>> - Call btrfs_check_system_chunk_array() at btrfs_validate_super()
>>
>> - Simplify the checks inside btrfs_read_sys_array()
>>    Now the checks will be converted to an ASSERT().
>>
>> - Simplify the checks inside read_one_chunk()
>>    Now all chunk items inside system chunk array and chunk tree is
>>    verified, there is no need to verify it again inside read_one_chunk().
>>
>> This change has the following advantages:
>>
>> - More comprehensive checks at write time
>>    Although this also means extra memcpy() for the superblocks at write
>>    time, due to the limits that we need a dummy extent buffer to utilize
>>    all the extent buffer helpers.
> 
> Well, the memcpy() is not the problem but rather calling
> alloc_dummy_extent_buffer() at the time we want to write the superblock.
> This requires allocation of the extent buffer structure and all the
> pages/folios. And the alloc/free would be done for each commit. A system
> under load and memory pressure won't be able to flush the data. This a
> known pattern we want to avoid.

That's exactly the concern I have too.
> 
> So either preallocate the dummy extent buffer and keep it around
> (possibly freeing the unused pages/folios), or somehow make the extent
> buffer helpers work with the superblock.

Preallocation makes sense.

> 
> There are 2 trivial helpers that we can replace
> (btrfs_chunk_num_stripes, btrfs_chunk_type), but
> btrfs_check_chunk_valid() needs a proper eb with folio array.

And the reason for full eb helpers is, chunk tree blocks can be 
multi-paged, so that we need the eb helpers to handle cross-page cases.

For superblock one, we can accept full on-stack pointer, since a sb is 
fixed to 4096 bytes, no more than one page for all archs.

So if you really need, I can go with dedicated helpers for sb chunk, but 
I'm not sure if it's the best solution.
Considering we will have a lot of unaligned access anyway.

(I really hope one or more decades ago, the on-disk format design is 
aligned to u32)

Thanks,
Qu

