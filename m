Return-Path: <linux-btrfs+bounces-9016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 732779A5981
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 06:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6874B22F5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 04:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B61953BB;
	Mon, 21 Oct 2024 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ePdXBW+G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACD64A
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484789; cv=none; b=usK5QgWPtHJVEIRBl9nFD9xqrsWA8CHq0oDpTgAWo6AQcx5jFq5zQnC+NWsU+pgDPQTCv/8l1rNvcRgpkx1poC6AO9YtPGK5llLPQFacrvHDZs5uroKGuud7lu1dcdcRy3WGvnOuvIChrpMDMn0PE/T8SIsu/8zza5e4HZ6lKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484789; c=relaxed/simple;
	bh=XJIV7SrXnv/4lWpKJgrjoTB892RtnygOQimikI1b7/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MwbYA6IXEBhz5Uo4LlmqiYaRagBjUXj2UXW81tf4WfHHXSsz6cndzWop6P3h5cR2hg/dCjzoia6nDg1PfC/HwD1vhh5uWw68CmgmDj97VQnCC8LA8YaevN7P9oAc9o+9+bCyUWgE1G5QLnZaKLIPMAJRP2pYm6oIeW4R7wBQcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ePdXBW+G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d5689eea8so2672352f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729484784; x=1730089584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XbFxRK2YsOsi/Wvxn+lpjPpDRvnFooHvKcaXspJswjQ=;
        b=ePdXBW+GtPhFS8W//YotluJFBtsl1vxlQevsj3ZwOopwXS2X+9tr3ptzEWzd5JOxDz
         /kkMWsnzy3fpeE+AtjW4/N8uS0QiQLWgi43wq6Oml4g3oTMnUlrKQbESNSuwFEMiiaz+
         WcvBqyqA5fgOfB5Gy4x0M20dTi0zPEp6AsYI293AhkB84BKOKrCVgWN4T+0UylZOeyLD
         p7dMVTKArt0G9T0HAORDg2++kjFPUmuTyWV/uuIs0n+ZDjTVVgO1zmnb7jL2AqQ2gLHZ
         ITdT13uphydqdNAep5N/72oNXbzZ+ZEAca4kSv2P27p20doa/oqG86cQyZ7qcrZwMN6a
         ecDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729484784; x=1730089584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbFxRK2YsOsi/Wvxn+lpjPpDRvnFooHvKcaXspJswjQ=;
        b=NerPvObZQX3Iku5v6GzJMe9hRkp3NkRBSgemHvVqd0J0+j/yQ03biEXnGDLHEant/I
         xjEz709Bs8LTuqVy39wrniuT8Xp1tVz1zxUSr8CWcIau00zcPng1wakiWiw1GKFk7rNm
         HNvEdymVC232PwVw0jHr9QJcSY06pPaXt+5FsOwCtzrhxaN+eLrffPlgKC54O+ogGq/d
         uXQHn5/odLBfdHOYqByQ2L0N0jDCqDxfZPC5KURZwn0UU+EUYW2graRRKYalymMPlw8D
         gwkbh86y5WhbqJNRM/xdKKuq27VvoGOWss+B8X86zzYb/r5UE46EPt5lww1qssxLwEMv
         YWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX22J3OMgQlYwe+s8w6q+jxWmA7ayQ7LZARIv9lWMrCX5IVxBSoxUum3wPcoQu7F+PG5BI8J/4z6WnRZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9Mfv/ZEGSJJ6TVrv9TLV+7Wdxon9owP91g/Gtbt6dLLFhnyx
	5gKvpiZSllwnqFhcUePLz1XwMDhwf/RG/11e2GmOpZnnVAY3Z1NfVaLQ8UYWyKuNxnVKGvVJm24
	v
X-Google-Smtp-Source: AGHT+IG+03KmIINSC4SNUo78hhxQF2sxhBYKvRLYm9/W++lqLRtvxTlQnRQJMVQtcr/PE1T/GCijCA==
X-Received: by 2002:a5d:564b:0:b0:37d:4e9d:233f with SMTP id ffacd0b85a97d-37eab704542mr6447296f8f.24.1729484784283;
        Sun, 20 Oct 2024 21:26:24 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9a7esm17040535ad.182.2024.10.20.21.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 21:26:23 -0700 (PDT)
Message-ID: <0bedb9d8-0924-4c19-a5d1-9951b04f2781@suse.com>
Date: Mon, 21 Oct 2024 14:56:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: strangely uncorrectable errors with RAID-5
To: Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <23840777.EfDdHjke4D@xev>
 <67b3649b-2372-4846-bb86-79fafec1bab0@gmx.com> <8439012.T7Z3S40VBb@cupcakke>
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
In-Reply-To: <8439012.T7Z3S40VBb@cupcakke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/21 14:25, Russell Coker 写道:
> On Monday, 21 October 2024 08:01:52 AEDT Qu Wenruo wrote:
>> The metadata is gone, and there is only one mirror for it.
>>
>> What profile are you using for metadata?
> 
> # btrfs fi df /mnt
> Data, RAID5: total=4.92GiB, used=1.21GiB
> System, RAID5: total=48.00MiB, used=16.00KiB
> Metadata, RAID5: total=864.00MiB, used=172.77MiB
> GlobalReserve, single: total=6.95MiB, used=0.00B
> 
> It's all RAID5.  Why would it be all gone?  Also why can't it be recreated
> when diff doesn't report any file loss?  Can I convert a BTRFS filesystem from
> this state to an all good state?

Your metadata is corrupted, no better solution other than doing data 
salvage (-o rescue=all,ro, copy whatever data you can/want)

> 
> As an aside I've had something quite similar happen on a production server
> running Ubuntu 20.04 and RAID-1 and now I'm just running it knowing that a
> scrub will give errors but that it apparently works.

RAID1 is completely another story.

Without the complex RAID5 write-hole problems, it's very reliable.
> 
>> Just in case, RAID5 is not recommended for metadata due to the complex
> 
>  From what I know it's still not recommended for anything though.  But
> definitely if I didn't want to have data loss and I wanted RAID-5 then I'd use
> RAID-1 for metadata.  But in this case I was more interested in seeing how it
> might break than in keeping the data intact.

With the recent RAID56 improves, I'd say RAID5 data + RAID1 metadata is 
usable, but I'm not sure how it will survive in a production environment.

Considering we have a lot of other problems out of our control, like bad 
disk flush behavior, and even hardware memory bitflips, I won't 
recommend RAID5 data for now, but I believe RAID56 for data has improved 
a lot.

If you want to experiment RAID1 metadata with RAID5 data and report 
back, I would appreciate the effort a lot.
And from my last work on RAID56 (for data), it should survive your 
random corruption script.

> 
>> recovery combinations:
>>   >> The power failure safety for metadata with RAID56 is not 100%.
>>
>> I'm pretty sure if you're using RAID5 for metadata, that's exactly the
>> case where corrupted metadata can not be properly fixed at a per-sector
>> basis.
>>
>> Thus it's recommended to go RAID1* for metadata if you want to use RAID5
>> for data.
> 
> OK.  I'll run some new tests on RAID1 metadata and RAID5 data and see how that
> goes.
> 
> Is there any way of recovering the filesystem with those errors or is mkfs
> required?

Metadata is gone, and since you're randomly corrupting the fs with 
metadata using RAID5, I would suggest just go mkfs, with RAID1 metadata 
of course.

Thanks,
Qu

