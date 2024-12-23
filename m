Return-Path: <linux-btrfs+bounces-10636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC99FAA38
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 07:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE707A1F22
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 06:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF7154C00;
	Mon, 23 Dec 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MOkbaHsI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A013987D
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734934701; cv=none; b=KiT70/sBuYcwomo11H2Eyi3S7mbRgMuxdkLZ4qqtxltoruiqhSc6E1UERQXKrONBv/isYUGPF/UUVUiXAAxbG2rk07ZRRwQ6AUrdKdlg3D1BGtBaaZnPWKORGrDZlJKWqAuEZBcvL3mJFtwYNGF84tNQmommB2SOgIV8dqZoR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734934701; c=relaxed/simple;
	bh=3i/y9f+kYoD9dIym2UglW5wo7ByfA+NGjaSQh4hTNCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PikoHTmBO2Wtt54SZyDjWIIL36p9JpLLwc2j2OdOPmYNCBFsCpKwiobOzpbjQXjWKDpUxbcwHt7+YwpUJZZXZ1/LVFQvRSK24h0tdTpx0FGgf2tRX1WbQktIajyYSsJqQnisvj8jH+iiYHYQJP7lrjwuMZLVXyCZ6uFJ57F7Dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MOkbaHsI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aab925654d9so703025466b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 22:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734934695; x=1735539495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6GCBlvQv0qHUtCeaVbmhOveDCjxRe0vrO4J8zhiw5To=;
        b=MOkbaHsIhXdo8RaL25wvaLacCjVF2y+PrGYglRS0py86uD69nc2ZnPhApXxtITX11B
         PYZMeNexqQKFQ5EhmV5cWiBPfx3XPU1BtZwTZ5UbYPlIGts+7TA3XB7T/7iUXgZemeiC
         +JNJt/ZcvTPaO0WPlrA6S//CpAEjQdCsKvBSXBaWtAHgmF8ZnDeXNvf2SqHLCphNp8Qe
         uga++DfsC/bKcOel94K+mmBqinV2j6KgiHPOX1qVd2im+zNYRdn0DNwWSkcmfl2kFGrZ
         0JLtHotCzk5xgoGIJE51OQnVYHhm+gDD6OKJAUJjcB5fcj0ClYZqdLEJluSFtmzPmsyB
         VxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734934695; x=1735539495;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GCBlvQv0qHUtCeaVbmhOveDCjxRe0vrO4J8zhiw5To=;
        b=tE35aUbmNZ+RJkZs1Yk9nQXn/XmL4D2h3PX3aQbEZAtk7P0ixc/r4yUQhx4lB8IDfH
         unbwqb5JptiRASRB9TSB6WQXbcTVlQMtzcE++9ns/k+ww5GJySonPySuQV5Pb+hBxMHg
         Qa8kKqtSfolLv67quDdfzuqSpdCL6ktYJQWlVUFNhVeYAXupOtkiy8VeJmKsgnMOKVkD
         3BpDceygd0B6m/VFm6OM+dy8owoCcr3mtPEKb7dMrWEtMDjuolUztjss7VE9kjUfJuxh
         LUsmKFS7aP5EzWMAibrZEerA3jN3X4PEaz3lsiNuRNlyhvWqK77IOI9nYQhgr/2Kz4CC
         aydQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUT3c0tUdLHa5Miikb91tG+vIZ0bC5rWoe8ZX4wbA/nYoP6ZDPItenaVxd/Zd4wzItlY++STqH5XYf5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpo9VH6lP/XSf/B7krxlgi41gI1FJInTIJ9zVunZWcn4wNjeQ
	Gfh/s+CyAa5HEix/IMeJMf7xg4YMHqCGR0M+2IlkK2pK5ZKclaSuJh7A9cVVvJM=
X-Gm-Gg: ASbGncufn8lVVYrDpqdfhC1m5fnHyfMqVdkHcjaAw4UlBSP9MIcmQpgvjP9R4qZB8O3
	9n8ak07MtekWGlVgauWgSCpSSwqkD5yVyBYgf+9q46d4CGdKrYmdwTBk35W/HsXwHvC+dzkAqW4
	L7uuT7ZyZPsNhVTyxks4DqRO8zegZ+XxIsQzGu+rhom3WzOQt0HTjcgxXSdcIVEWD4wF5WiAbkP
	9BN4Zluxktyr3rKQfLk+1GCt9ox08C16SBXXD08zT7E998O9BXxLQmqPkD9NLvq7C6M07nShNDd
	Gjwm44ij
X-Google-Smtp-Source: AGHT+IHxK4/pRzGzd02v1HAJxTGzopFl0n481OBi6wQCyM/MlVv2n4mH4XgZALw1AEtYyYMJqNhzJQ==
X-Received: by 2002:a17:907:1c10:b0:aa6:ac9b:681f with SMTP id a640c23a62f3a-aac3355d85bmr1100497066b.43.1734934694601;
        Sun, 22 Dec 2024 22:18:14 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8162ddsm7098309b3a.17.2024.12.22.22.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 22:18:14 -0800 (PST)
Message-ID: <a60e17bd-621d-4663-a3dd-25b0730e7ee5@suse.com>
Date: Mon, 23 Dec 2024 16:48:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use of --convert-to-block-group-tree makes fs unmountable
To: Jeff Bahr <jeffrey.bahr@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAL4+Tgzk=MS1P93u6yq_m0aqbMyjXrwPiP-8nA5zp=fTu7Vr6w@mail.gmail.com>
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
In-Reply-To: <CAL4+Tgzk=MS1P93u6yq_m0aqbMyjXrwPiP-8nA5zp=fTu7Vr6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/23 07:07, Jeff Bahr 写道:
> Looking for suggestions on recovering a broken btrfs fs after
> attempting to use --convert-to-block-group-tree. I was experiencing
> slow mount times, 5-10 minutes on reboot. Docs suggesting converting
> to block group tree. I performed the operation on an unmounted file
> system. I tried rebooting to test boot times and was unable to mount
> the file system normally after reboot. After a few recovery attempts I
> was able to mount with 'mount -o rescue=all,ro'. I'm currently moving
> all data to offsite backup incase of total loss of the fs.
> 
> I get the following errors when attempting to mount

Is this the same error immediately after the conversion? Before any 
repair attempt?
And what attempt have you done after the failed first mount?

And I guess the conversion doesn't result any error message?

Finally, have you ran btrfs-check before or after the conversion?

> 
> [  159.345342] BTRFS info (device sdj): bdev /dev/sdb errs: wr 15660,
> rd 8, flush 1, corrupt 0, gen 0

This line shows a very bad history of the device,
sdb have a lot of write errors, some read errors, and even one flush error.

I'm not sure if it's even reliable. But it may not be a big deal since 
your fs have RAID1C3, one unreliable device won't cause anything wrong.

> [  159.364088] BTRFS error (device sdj): level verify failed on
> logical 102652926951424 mirror 1 wanted 1 found 0
> [  159.377694] BTRFS error (device sdj): level verify failed on
> logical 102652926951424 mirror 2 wanted 1 found 0
> [  159.382394] BTRFS error (device sdj): level verify failed on
> logical 102652926951424 mirror 3 wanted 1 found 0

This means a tree block of block group tree is not at where it supposed 
to be.

It looks like the metadata COW is completely broken (extent tree 
corruption? space cache corruption?).

> 
> This can also be seen in the attached dmesg log.
> 
> I am looking for suggestions to possibly recover this file system to
> avoid having to recreate the fs from backups.

Such tree level mismatch is pretty bad, so I'd recommend to backup the 
data first. And may have to recreate the fs from backup eventually.

Thanks,
Qu

> 
> Host information:
> 
> uname -a
>> Linux server 6.8.0-51-generic #52-Ubuntu SMP PREEMPT_DYNAMIC Thu Dec  5 13:09:44 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
> 
> btrfs --version
>> btrfs-progs v6.6.3
> 
> btrfs fi show
>> Label: 'new_btrfs'  uuid: 0ab9d35a-4d18-4a06-8881-e9cef44324a8
>          Total devices 10 FS bytes used 45.20TiB
>          devid    1 size 7.28TiB used 5.66TiB path /dev/sdj
>          devid    2 size 7.28TiB used 5.66TiB path /dev/sdk
>          devid    3 size 7.28TiB used 5.66TiB path /dev/sdb
>          devid    4 size 7.28TiB used 5.66TiB path /dev/sdp
>          devid    5 size 7.28TiB used 5.66TiB path /dev/sdr
>          devid    6 size 7.28TiB used 5.66TiB path /dev/sds
>          devid    7 size 7.28TiB used 5.66TiB path /dev/sdd
>          devid    8 size 7.28TiB used 5.66TiB path /dev/sdf
>          devid    9 size 7.28TiB used 5.66TiB path /dev/sdl
>          devid   10 size 7.28TiB used 5.66TiB path /dev/sdn
> 
> btrfs fi df
>> Data, RAID6: total=45.14TiB, used=45.14TiB
>     System, RAID1C3: total=32.00MiB, used=32.00MiB
>     Metadata, RAID1C3: total=60.00GiB, used=60.00GiB
>     GlobalReserve, single: total=512.00MiB, used=0.00B


