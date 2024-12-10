Return-Path: <linux-btrfs+bounces-10179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476359EA735
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 05:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C87B163500
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367AF1D14E2;
	Tue, 10 Dec 2024 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WHNmCrRJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6E469D
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733805395; cv=none; b=qaQ/zbqPGA/IFlqdCrvR7GjmSKglMpyr9eJ7fhiPVw4ZW2cfVqz98Q7e5LqLf8eXN1+bc6UuSMP/+w6rb4oZkZfmT5LR95rJ8qLRoVeNTzrqq+I2nEJ/idsnr3N+JZmlPW+ND9ySL0h89SVlaJZD1dTanVOqc5YwoOBZoqQYqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733805395; c=relaxed/simple;
	bh=CukTMpTMh/Gcy9w2BCwQGLdUvMeKBq4KnBviroTRtWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nlRrEjI+t2hlRC+n7DOOonqtVLDRV0TGf87KiAUJ0qsULVY2P09fzhXrwlKaxmR3DXzetUNdIwOHupO98NcDaRQiY6twIho2oK5euTGDge9CNbMMZnF/557qZrLT3Ro9dz3IEg0D0AGNU+QGPy495vv55YVhLnh9NW2lZNCj/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WHNmCrRJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38637614567so1259968f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 20:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733805390; x=1734410190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mybaZDS1dYbzJ+XHCHgrju1KNNJQm5k1R/ukTn6u8Us=;
        b=WHNmCrRJZrs4WuVkGRN50C8c6RoQu8Fp+QWpdIynNY+Ic3sCYw6+k1XHF4ZIdjlyse
         jm31T2ZZ1v2GlL+YEH76edT80/B6Ir1feVAgstkJrnasxA7RcdJUZAujHUJDxGwB99Mb
         SwjhM0xTa1/kOqQ5cBzBIniOFOHtDbzV9i+wljOcpxNuR176ZtPyHYfz0ZMZukcACHf9
         5hSjMhtBrImMunKxHBTglopckD6sRwp17/5iS3hxyleLgSrdbBURHHW0X9bWuwqFAp5P
         PuJiMveFRcQt52t5xWQkzrstl6XdR3nsoDDj2akkA+3vUbWLHlljQEMh4tlhhiJMXjWk
         HCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733805390; x=1734410190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mybaZDS1dYbzJ+XHCHgrju1KNNJQm5k1R/ukTn6u8Us=;
        b=jpw3+tZ4AiazAVFnljR5b18/0ViMwyyv04+iqI+KPv24dZb6TrdIbLYbmcWiym4oEp
         jjf8ESsJV60w2eIFIvsa4/eSPpajZJ/IiMUqkXdQrsJ5s2pRuWtvLWPZn2r0wj6pKQbq
         IJTosmpCAP8dlG7cNucBQIpcDwouRJm/7yeHFU0XIt9fO/sasZwXqyXEP0L1fB8o3RWJ
         sKSGVmLZIG0hehoyOrn3xWoFr5tJ+IogMOv10uOPKAUxcpLC8s1+PY9MRDGuhA2/WDyQ
         6ZrXvK3LPKHNvjcYxLV/cjg+ZIr+t82Xf5sz28Y2hc3EoAQY/4d9usLu0mIpEVHKcIHK
         uExA==
X-Forwarded-Encrypted: i=1; AJvYcCWRgItYCufK1kcuyLKuXkXpgVgSF5DWS05gfkxr2w2FVyEGbmzevNeZkOMxqxx3VWQZqIh0jczVc23XcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytlSwrDTS9oKUtnPkWP7DJbi8XxsBytV7K39eqeIdm1+m2x/TU
	QniWPL1vITagVYqJguqHVwVzYwIFrzCFa9oqSVBd05XlEojIUHhT1i7Kste1K2KOvkplGZY4NWs
	U
X-Gm-Gg: ASbGncs4jlqE2ZacEHtvMNcDMLnEwvSgsHiGecE516QV+w4rjVTHRL9zOvxi774KGoo
	VOQllKei/W0k4JW5HXCNCr42ssc9SD4tLB5Mp1MaTqjyot0H7XMJ4uAuThKwz4RBXices0Fl+95
	Vjy/RxszmCws2WkzKYbawKbt24a/8s5oywNTTxv4+Qeo/hGR7YMzQiXsBt7EkVvQ6BLi0EvbVp/
	JO/yuMWiZIti7Lj1iqqJ43n02zkbu7hp+7G1velWVqi0Pn7ScMB+opkimfT49XqpfB45r13ahSn
	oPwtDQ==
X-Google-Smtp-Source: AGHT+IFFNazwJycsttGT2yJtxqQiPxT1eND1BSgRMndbdsowGSkAPE85L1wrXLyQm8vjp0wqLZu4DA==
X-Received: by 2002:a5d:5f8c:0:b0:385:e67d:9e0 with SMTP id ffacd0b85a97d-3862b37d51amr11256765f8f.29.1733805389544;
        Mon, 09 Dec 2024 20:36:29 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f3d9c4sm80613565ad.274.2024.12.09.20.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 20:36:29 -0800 (PST)
Message-ID: <74c8536a-3108-4e6c-941a-5d7b9c697862@suse.com>
Date: Tue, 10 Dec 2024 15:06:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of raid1 vs raid10
To: Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
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
In-Reply-To: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/10 12:56, Scoopta 写道:
> I've read online that btrfs raid10 is theoretically safer than raid1 
> because raid10 groups drives together into mirrored pairs making the 
> filesystem more likely to successfully survive a multi-drive failure 
> event.

It's only theoretically possible, but hardly possible in the real world.


For one single RAID10 chunk, btrfs can tolerant as many as half of the 
devices being missing, as long as each sub stripe (the RAID1 pair) has 
one device standing.

E.g. for chunk at bytenr X, we have 4 stripes:

  stripe 0 devid 1 physical X1
  stripe 1 devid 2 physical X2
  stripe 2 devid 3 physical X3
  stripe 3 devid 4 physical X4

We can have either devid 1+3 or devid 2+4 missing, and btrfs is totally 
fine with that chunk.

But the real problem is, one btrfs has more than 3 chunks, and normally 
one chunk is only 1GiB in size, so for a btrfs with 1TiB used space, it 
will have at least 1024 chunks.

Good luck all the chunks have the same stripe layout.

If there is another chunk at bytenr Y, also 4 stripes but a different 
layout:

  stripe 0 devid 1 physical Y1
  stripe 1 devid 3 physical Y2
  stripe 2 devid 2 physical Y3
  stripe 3 devid 4 physical Y4

Then the devid 1+3 missing is fine for chunk X, but not for chunk Y.

In really, the chunk layout is never ensured, and I just did the same 
RAID10 assumption in my btrfs-fuse project, until it failed selftest 
(missing two devices for a RAID10 btrfs) on a recent kernel, exactly due 
to the device rotation.

Thanks,
Qu

> I can't find any documentation that says this to be the case. Is 
> it true that btrfs pairs drives together for raid10 but not raid1, if 
> this is the case what's the reasoning for it?

