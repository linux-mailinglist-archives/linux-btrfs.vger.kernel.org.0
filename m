Return-Path: <linux-btrfs+bounces-9744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C59D09BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 07:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E64E281020
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7213CA95;
	Mon, 18 Nov 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pqw889W4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30B13AD32
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912476; cv=none; b=m5psQY7Ew/rm7qFBXoTXz3a6HI9eeRbQ6pIMDGQQvAlMEx7Oa1E/v8gJ1KVh2UNpEdHp9+f9s4mOjc/8Yb2WVaMQSs8gdjpsMjRshl5atjWaJI0xjcamHi4YoUPj6eaO240VXQVII1gqjRZfPYlwW6D/Yn0idiJZ8quQkulLc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912476; c=relaxed/simple;
	bh=I2WcOFgrsUD83JyzZttXm1A0xtRF25u8n49OUoglzEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sDkurSnjg1mm4t9dxewIt+1CZ+lYaYRCrmW8qVb7w08/G5hRLc5xFTWDecCk+d120bkmjdojuTejTrNvWn30dSh7Xq3jJC5MlNT46qi3JGGyMuhxnt0kc3A5O5X5Mv5TcGLQ+K7FrjVzTMyYwHXoJ2iW38OYDOE81BLCumU31EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pqw889W4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53d9ff8ef3aso3996940e87.1
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Nov 2024 22:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731912472; x=1732517272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=owj7aBVOcoZ3umGGIlShlJ7/HGkEhFw2HIjoHNIu2lw=;
        b=Pqw889W4XKlI/flBod7BE4vW1mr1yrgfisiCzdjnxd78xdugfJb3/ykv5w6sAK7bmz
         rE2pl1iGt9Vi/EzI2fA9beG+HxjZgj8n386wuIfwJXOxbbysYlQpqbNaZvLCajO0uH4c
         /LatioIQMx3hIVYrvixQ/hXEVWI6knGXUC3vqOETqdbEKLY6C7/QyGo3yPy8E6xxj/E9
         bMslo5aeTGV3xToaSuB7HFabAa+CJ9GNyfzqbmSvjVKP5kGexCeK1mZAWg6rklJrTPPe
         aFsuBq1Uc+gkP2gy1Y1c/7m7B+UHLwFqkcDfde9olqoDT5Qdv3kE+HiyB4XG7CTFJTAq
         7l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731912472; x=1732517272;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owj7aBVOcoZ3umGGIlShlJ7/HGkEhFw2HIjoHNIu2lw=;
        b=MFw4I+Ry7rXj95uLR3sjMw1aUgcAju7bxlb2DYnJwTAwEYT7r6F4VLIeZL6Lq3Eo2i
         qAJcERKzgNKtlikkJtgGOZZSkIGvzOGX/TL5Q5Nj5mStiwWPY4Mbq8aJ/mtywHrkhe29
         pYoQcXQ/xn9aj38ZK2OJvmasyXFHRtO1aZK0/FOttzwBLV+TyEUhfCThRZyhCn8xonoG
         wppmSecARAUUSmHOSC4GZwBfVLVC529ecHvRc+39AbnV+rF7jZjJiN4/IH0M4fGy23mp
         dvK6Eh9arO0VOkjNIvtBreE1SH23amFUDmAE1q722PrjzZKxVlzxJn0SmKohlQF1Lxj6
         SWuw==
X-Forwarded-Encrypted: i=1; AJvYcCXTB4V4o8XMnPjDGTzp/VGbxGnfL7TyffIsnf+MD1mOjZ5auhGbQyjiA1X+BnGm4mCTWD5rOLvgVV50eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOd+6JxV4yu9IIIE1zWNo20MuTP1+NaWah1GTOnnEPgsaM2YS
	0ZwGlpEdASypZr810dEXGcyswkYFYQpkPDu0koFRO6c+TrK7wiYVyDBiY7magRs=
X-Google-Smtp-Source: AGHT+IHDEEINMUuQlD8AjX941iJtYuzrBN6F/WPOdLuLN9qCYFKBGYCJeOS3xoMO7ur83DQ8kOHcfg==
X-Received: by 2002:a05:6512:118d:b0:53d:a5d0:ef3a with SMTP id 2adb3069b0e04-53dab29266bmr4377308e87.4.1731912471318;
        Sun, 17 Nov 2024 22:47:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e202asm5627148b3a.142.2024.11.17.22.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 22:47:50 -0800 (PST)
Message-ID: <d808ed2a-d255-429f-823d-ef4e29300a4f@suse.com>
Date: Mon, 18 Nov 2024 17:17:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs scrub results in kernel oops does not proceed and cannot be
 canceled
To: Sergio Callegari <sergio.callegari@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <e4e79b2b-ebca-4ca2-a028-084a6dfcb3e8@gmail.com>
 <931d4609-6ad9-4232-a930-4c6866434a10@gmx.com>
 <770176d3-f1e6-46d5-8025-24610843be81@gmail.com>
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
In-Reply-To: <770176d3-f1e6-46d5-8025-24610843be81@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/18 08:19, Sergio Callegari 写道:
> Thanks for the answer!
> 
> On 14/11/2024 21:20, Qu Wenruo wrote:
>>
>> Dmesg please, for the regular mount (without rescue options) and the
>> scrub oops (with rescue options).
> 
> Thought I had saved it, but in the restlessness of trying to put the 
> machine back in a condition to let me finish work, I ended up messing 
> it. My bad.
> 
>>
>> And I'm guess it's an extent/csum tree corruption, that caused some
>> btrfs_root_node() failure.
>>
>> This patch should solve it:
>>
>> https://lore.kernel.org/linux-btrfs/20241025045553.2012160-1- 
>> lizhi.xu@windriver.com/
>>
> Is it already in some stable kernel? Was it a regression or something 
> that was just recently discovered?

It's something introduced with the rescue=ibadroots option.
With that option, we allow some tree roots to be corrupted, but not 
every call site can handle it (scrub is one example).

It's not yet in upstream, but I believe we will push it for an rc 
release and backport it.

> 
>>> - The scrub does not seem to progress (calling it with status).
>>> - The scrub cannot be canceled.
> 
> Mouting read only with the `rescue=` option let me get some access to 
> the filesystem content and helped me recover some of the data. Other 
> data was recovered from a backup that, unfortunately, was not very recent.
> 
> What seems strange is that if the filesystem can be mounted it cannot be 
> scrubbed.

> 
> I have a questions, if you are so kind to answer:
> 
> - mounting in rescue mode I have apparently lost all the files at the 
> top of my subvolumes (some disappeared altogether, other appeared with 
> zero length). The stuff inside the directories that survived seems to be 
> there. Can I trust these files to be correct? Are there checksums in 
> place, so I would have seen errors if they were not?

If your csum tree is not corrupted, ibadroots still allow csum verification.

This can only be determined from your dmesg.

And if csum verification is in place, you do not need scrub, but regular 
read is enough to know if it's fine.
(Bad one will cause the read to return -EIO).

> 
>>
>> Yes, I do not think it's the driver.
>> When hibernation and suspension is involved, things can get tricky.
>> (From ACPI bugs to btrfs bugs)
> 
> My swap (for hibernation) was not a file in btrfs, but a separate 
> partition. Can this make any difference?

I do not think it's the swap partition/file causing problems.

Mind to share if you have hit some other problems related to hibernation 
or suspension?

I'm not an expert but I guess we have to take this issue more seriously.

> 
>> Thus my personal experience is, just do not utilize them.
> 
> Hard not to use hibernation with laptops that only sleep to hidle, so 
> that the battery charge ends up while sleeping and you get an unclean 
> shutdown whenever you leave the laptop alone for more than 12 hours.
> 
> And to switch off the laptop is a pain with full disk encryption and 
> grub taking ages to unlock the encrypted device...

I regularly shutdown my laptop and accept the cost of LUKS unlock.
But in my experience, the LUKS unlock only takes seconds...

But I'm using systemd-boot with an plaintext ESP partition (with 
kernel/initramfs in it), so the experience may differ.

Thanks,
Qu

> 
> I'll try to back up more often...
> 
> Thanks
> Sergio
> 
> 


