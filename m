Return-Path: <linux-btrfs+bounces-5094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9BD8C935A
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2024 05:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C23281596
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2024 03:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D7DD272;
	Sun, 19 May 2024 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YTzg9QIu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A47492
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716089703; cv=none; b=GO9wtQe3K6eeqmOGYyPIo2NOSxV1rciG1YYH5HHlA51ktVB71PyVuArYBgHNDY0YPWVbDzVMJgB2j3sSyO0LEB5a547UVPSJCCYMCBzR4jiK1mYIzVXRfCchk9U8sJQRCdZwsq4FfKr8EULPEpHyXI35sh1AHEpKAkjDYs87Avk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716089703; c=relaxed/simple;
	bh=eUwiV/x69JFT/D1j3JQc93SR0FbHoUoc2KVDksmVB1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYBTy+67tfAIVsynx4moWtEgI3ezFmvY17p1s9x2taS4U0hwoI72+yCGHQYjXZfOjMzg4AbP3TRlZ7G4vblc8DjY/DoAbjJ8X+IfAkJppambUcIVV/CgtuwPw9VQkapPyMpvXKAjmqYsnyWZIZm+sEixPXPVyhm77HJ2a1dJ8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YTzg9QIu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e6792ea67fso36132761fa.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2024 20:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716089697; x=1716694497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OyHV4rSdM9FB168PbPFsXj2gntwnpAnPJpFRZc9Sk44=;
        b=YTzg9QIuMAA+xcTtO7adyQc71UbmyWOWQjNiYylirlbt5OvqpRLS0Z5uO+KIPwbUlN
         EZjOLAofvToqVZeRys844llL9hHfeLSkkBjZUZaVOb64Z+K3JmiQ901tctcyODvvtY6v
         A3rGuj4uNA5U1utPQn12QCgHe8+4HbY7xCphTh/eMezZscRHrQbfJ9QAgUcJgVHka7fW
         9X6E0N8vzVaGteOiGpf0nNsgGPnrajRBayFRRX3xxZmTzVbt3jaBkigVMKKg7YxYUHsU
         jNQstWnP9k7i0H2iWyB80brCHbQiwFEGYOqWoqq8xvSr99nu4mF+4nl2zPRzS8vyDmAq
         59KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716089697; x=1716694497;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyHV4rSdM9FB168PbPFsXj2gntwnpAnPJpFRZc9Sk44=;
        b=UM1BuKwHPkGFFIJm5/XAZdQNM5FSnFKgfZLygW5wFnTTdX+AletL9yL1mgAlkhR4AE
         QKrqlovkE0Qop3YxEwPOsicPcWDyKAkm/uzqwgIGyGiurrxybUpGKMSF6Udi/UVA/hG8
         FaVFJRkijBtI0x2wkLaZaWqO24iRn30bwHBAuvpB80fnzW/qfBZT7gT4WdQjRilC8sSE
         xa9fADn3U4OSgp0MWJJwJ4ewTeM51Ot+8+HcyPOAGsl7SnNUROpfNAkz3qT1GA4Tjo/x
         f3spcjDgYI+wHAwlp810J2BDKAJODq3TA1tBu0Uno011QfFJiJhr5dB8S9xC+16q+XDL
         Ks0g==
X-Gm-Message-State: AOJu0YwHzQpWCxcQFLmypgOUtE8kmX/eEUKM7FkURbLhGlHm7LT9hC/g
	POXwkeYA+WBS1gzT09W7DXTgMKvWjDT/SjCal9X9fha0U58IR1j/f4HNaWD93YE=
X-Google-Smtp-Source: AGHT+IGOlD+QIjcFr1ThFLo9N7o7ZspbmblF6fB08jG8tMIDhy7o0dKBgogN76wxktYrUvlpqJ1geg==
X-Received: by 2002:a2e:7a0b:0:b0:2e2:72a7:843c with SMTP id 38308e7fff4ca-2e5204ccdc2mr182056281fa.36.1716089697011;
        Sat, 18 May 2024 20:34:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-668c02e2524sm598365a12.11.2024.05.18.20.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 20:34:56 -0700 (PDT)
Message-ID: <cb56ae39-71be-4bbc-b1c2-b9d0ab7241a4@suse.com>
Date: Sun, 19 May 2024 13:04:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: system drive corruption, btrfs check failure
To: Jared Van Bortel <jared.e.vb@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CALsQ4_x-5+W_7NQR68nTiCM9aptigGf6+HD=jLftrxgXTOLyRA@mail.gmail.com>
 <32ca8678-d0fd-44e4-b0a0-9b25383dc866@gmx.com>
 <053ca275b81228acf1259047d6d8bac67efc256f.camel@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <053ca275b81228acf1259047d6d8bac67efc256f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/19 11:47, Jared Van Bortel 写道:
> On Sat, 2024-03-30 at 10:12 +1030, Qu Wenruo wrote:
>>
>>
[...]
>>
>> Do you have any dmesg of that incident?
> 
> Hi, sorry for the delay. I finally got around to running the lowmem
> check on the old drives.
> 
> Firstly, there was nothing relevant in dmesg. When I first saw your
> reply, I checked the system journal from the time of the incident and
> there was nothing disk-related from the kernel between mount and
> shutdown - medium errors, btrfs I/O errors, or anything like that.

I believe the fs flipped RO due to extent tree corruption, thus nothing 
can really be recorded into the journal.

[...]
>>
>> Corrupted extent tree, this can lead to fs falling back to read-only
>> halfway.
> 
> This fs actually still mounts writable without any issue, FWIW. Although
> the error counters are not zeroed:

Only when the corrupted extent backref got modified the kernel would 
throw a lot of errors, and then flip to RO.

> 
> bdev /dev/nvme0n1p2 errs: wr 51, rd 0, flush 0, corrupt 0, gen 5

This shows two new findings:

1. There is some write failures, which may or may not be the root cause, 
but I'll be extra cautious.

And even if it's the root cause, it just exposed some error corner cases 
where btrfs kernel module didn't handle it correctly.
At least even we hit some write errors, we should not lead to some 
corrupted extent tree.

> 
> It's not clear to me when these errors occurred - wouldn't they have
> been logged to dmesg at the time?

As explained, if the root fs flipped RO, no journal can be really 
written onto disk.

[...]
>> Mind to run "btrfs check --mode=lowmem" on that fs, and save both
>> stderr
>> and stdout?
> 
> Here is the output:
> 
> $ sudo btrfs check --mode=lowmem /dev/nvme0n1p2
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 76721faa-8c32-4e70-8a9e-859dece0aec1
> [1/7] checking root items
> [2/7] checking extents
[...]
> ERROR: shared extent[1249401454592 16384] lost its parent (parent: 2368656916480, level: 0)
[...]
> ERROR: shared extent 1624013307904 referencer lost (parent: 1252056268800)
[...]

So yes, there is something wrong with the extent tree.

The "lost its parent" line means for the shared metadata backref item, 
the parent can not be found.

Thus although you can still mount the fs, if you delete or COW that 
extent, the fs would flip RO.

The later "referencer lost" is for data backref item. It is  mostly just 
caused by the previous "lost its parent" line.



> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> block group 1342751899648 has wrong amount of free space, free space cache has 34193408 block group has 42893312
> failed to load free space cache for block group 1342751899648
> block group 1343825641472 has wrong amount of free space, free space cache has 23257088 block group has 25903104
> failed to load free space cache for block group 1343825641472
> block group 1351341834240 has wrong amount of free space, free space cache has 22396928 block group has 42348544
> failed to load free space cache for block group 1351341834240
> block group 1566090199040 has wrong amount of free space, free space cache has 48562176 block group has 50651136
> failed to load free space cache for block group 1566090199040
> block group 1572532649984 has wrong amount of free space, free space cache has 12173312 block group has 15945728
> failed to load free space cache for block group 1572532649984
> block group 1580048842752 has wrong amount of free space, free space cache has 29745152 block group has 33087488
> failed to load free space cache for block group 1580048842752
> block group 1584343810048 has wrong amount of free space, free space cache has 56512512 block group has 58601472
> failed to load free space cache for block group 1584343810048
> block group 1602597421056 has wrong amount of free space, free space cache has 87953408 block group has 90349568
> failed to load free space cache for block group 1602597421056
> block group 1744331341824 has wrong amount of free space, free space cache has 339968 block group has 393216
> failed to load free space cache for block group 1744331341824
> block group 2666675568640 has wrong amount of free space, free space cache has 602112 block group has 782336
> failed to load free space cache for block group 2666675568640
> block group 2909341220864 has wrong amount of free space, free space cache has 65536 block group has 151552
> failed to load free space cache for block group 2909341220864
> block group 3904699891712 has wrong amount of free space, free space cache has 172032 block group has 221184
> failed to load free space cache for block group 3904699891712
> block group 3941207113728 has wrong amount of free space, free space cache has 1728512 block group has 1826816
> failed to load free space cache for block group 3941207113728
> block group 4085088518144 has wrong amount of free space, free space cache has 5697536 block group has 5754880
> failed to load free space cache for block group 4085088518144
> block group 4241854824448 has wrong amount of free space, free space cache has 23293952 block group has 28966912
> failed to load free space cache for block group 4241854824448
> block group 4838855278592 has wrong amount of free space, free space cache has 86016 block group has 118784
> failed to load free space cache for block group 4838855278592
> block group 4847445213184 has wrong amount of free space, free space cache has 49152 block group has 110592
> failed to load free space cache for block group 4847445213184
> block group 4897911078912 has wrong amount of free space, free space cache has 7475200 block group has 7577600
> failed to load free space cache for block group 4897911078912
> block group 5010008178688 has wrong amount of free space, free space cache has 69632 block group has 106496
> failed to load free space cache for block group 5010008178688
> block group 5062655082496 has wrong amount of free space, free space cache has 5836800 block group has 5890048
> failed to load free space cache for block group 5062655082496
> block group 5268813512704 has wrong amount of free space, free space cache has 135168 block group has 221184
> failed to load free space cache for block group 5268813512704

This is minor error, but I'm not sure if it would lead to more problems.

Overall recommended to go v2 space cache.

> [4/7] checking fs roots
> ERROR: root 259 EXTENT_DATA[1522634 4096] gap exists, expected: EXTENT_DATA[1522634 128]
> ERROR: root 259 EXTENT_DATA[1522636 4096] gap exists, expected: EXTENT_DATA[1522636 128]
> ERROR: root 407 EXTENT_DATA[398831 4096] gap exists, expected: EXTENT_DATA[398831 25]
> ERROR: root 407 EXTENT_DATA[398973 4096] gap exists, expected: EXTENT_DATA[398973 25]
> ERROR: root 407 EXTENT_DATA[398975 4096] gap exists, expected: EXTENT_DATA[398975 25]
> ERROR: root 407 EXTENT_DATA[398976 4096] gap exists, expected: EXTENT_DATA[398976 25]
> ERROR: root 407 EXTENT_DATA[418307 4096] gap exists, expected: EXTENT_DATA[418307 25]
> ERROR: root 407 EXTENT_DATA[418316 4096] gap exists, expected: EXTENT_DATA[418316 25]
> ERROR: root 407 EXTENT_DATA[418317 4096] gap exists, expected: EXTENT_DATA[418317 25]
> ERROR: root 407 EXTENT_DATA[420660 4096] gap exists, expected: EXTENT_DATA[420660 25]
> ERROR: root 407 EXTENT_DATA[420673 4096] gap exists, expected: EXTENT_DATA[420673 25]
> ERROR: root 407 EXTENT_DATA[439382 4096] gap exists, expected: EXTENT_DATA[439382 25]
> ERROR: root 407 EXTENT_DATA[439383 4096] gap exists, expected: EXTENT_DATA[439383 25]
> ERROR: root 407 EXTENT_DATA[451252 4096] gap exists, expected: EXTENT_DATA[451252 25]
> ERROR: root 407 EXTENT_DATA[451264 4096] gap exists, expected: EXTENT_DATA[451264 25]
> ERROR: root 407 EXTENT_DATA[451265 4096] gap exists, expected: EXTENT_DATA[451265 25]
> ERROR: root 407 EXTENT_DATA[452326 4096] gap exists, expected: EXTENT_DATA[452326 25]
> ERROR: root 407 EXTENT_DATA[452332 4096] gap exists, expected: EXTENT_DATA[452332 25]
> ERROR: root 407 EXTENT_DATA[452339 4096] gap exists, expected: EXTENT_DATA[452339 25]
> ERROR: root 407 EXTENT_DATA[4293157 4096] gap exists, expected: EXTENT_DATA[4293157 25]
> ERROR: root 407 EXTENT_DATA[4293570 4096] gap exists, expected: EXTENT_DATA[4293570 25]
> ERROR: root 407 EXTENT_DATA[4293571 4096] gap exists, expected: EXTENT_DATA[4293571 25]
> ERROR: root 407 EXTENT_DATA[4293572 4096] gap exists, expected: EXTENT_DATA[4293572 25]
> ERROR: root 407 EXTENT_DATA[4302136 4096] gap exists, expected: EXTENT_DATA[4302136 25]
> ERROR: root 407 EXTENT_DATA[4302148 4096] gap exists, expected: EXTENT_DATA[4302148 25]
> ERROR: root 407 EXTENT_DATA[4302149 4096] gap exists, expected: EXTENT_DATA[4302149 25]
> ERROR: root 407 EXTENT_DATA[4302150 4096] gap exists, expected: EXTENT_DATA[4302150 25]
> ERROR: root 407 EXTENT_DATA[5970391 4096] gap exists, expected: EXTENT_DATA[5970391 25]

Minor problems, would not cause anything wrong, kernel can easily handle it.

So far the fs looks pretty old (v1 cache, no NO_HOLES feature).
Thus the corruption may be caused by some older kernel bugs.

After backing up critical info, you can try "btrfs check --repair" to 
see if it can fix the extent tree corruption.

> ERROR: errors found in fs roots
> found 2397613547520 bytes used, error(s) found
> total csum bytes: 1840478932
> total tree bytes: 13337329664
> total fs tree bytes: 10208378880
> total extent tree bytes: 874070016
> btree space waste bytes: 2240708820
> file data blocks allocated: 24819271946240
>   referenced 2695187488768
> 
> 
> Hopefully that means something to you. I'm still curious to know to what
> degree I should still trust these drives if I were to wipe the fs and
> start over. I suppose I could run a SMART test or something, right?

So far I do not think there is something related to the device.
The only thing that can lead to the drive is the write errors.

The extent tree corruption so far looks more like a bug in (possibly 
older) kernel.

At least the minor problems would never occur for the new default mkfs 
options.

Thanks,
Qu

> 
> Thanks,
> Jared
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Jared
> 
> 

