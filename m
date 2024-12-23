Return-Path: <linux-btrfs+bounces-10637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AF9FAB36
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 08:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246D61885500
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D74918BB8E;
	Mon, 23 Dec 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kr9Pa5Q3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18278185B4C
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734939498; cv=none; b=mR3/820/GK7xj+UxmFznmUwp8TEma6pmpQYFyBU4sSqmhWSRKlrg0nENYqd1Z0gJHHdn76ShaWeG+TmDVhNYmHOESZm6/TGxqpaQYDHM5dz/kSww96a4DvMG7tO5KGofryaSzS8BJ/jIbDwE/HkyeTfwFQwubXGiu9QT1hG0Mhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734939498; c=relaxed/simple;
	bh=CgoTPi41y8sKmKI2kIrccETckIN7GaTgNVnxnQoZwH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GXl0bg2E/5bgz0xBDs3U+PBNNb+HOuHbWNAdXXIH+LOUazMv7f2Ku38xr6LAiJfMnoFdvqWnVD7M2YA8FdUyiLFDzyiCXa+VagZ5Iey0uD5KjV4TFD+pH5dJaNgUhBbsNAq9dnv4jkSiCRQBsjvwZ3IszAy1A8gYrdmA23ABYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kr9Pa5Q3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec61d0f65so218589866b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 23:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734939494; x=1735544294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wiQHoU9L3MnsvWNqfQf/4dokOc7GnFdCJsgq+6FZckc=;
        b=Kr9Pa5Q36Da83SRIn/Xxz5W2R/kE6D6N8JlrzcRKgzHs3U+2Y7r1iewx7NWQdpx5LN
         hPaZNrEERI6Gkn8JSF3JQe5SPiNys+GMbfmkZIS35JL9fDLh5hoxnQ2rfR9oGwL3JJUU
         Ln6XS5hbNNNt2U8OBnz4CDkWqj24o9mxg/ueiGHPVkmgL9MxehAIR/W6HpYPEXrkcoNV
         5wPaqiAE/CK4hEBDBUypl084HZrpfgO5mIAnwH7tW/We6p7ZCkhCH89Q720LAQu6GTRF
         1LBBufqJdhwNZ/pHCBlbYuJaEVQ4kCswn8sLFGf5yIXkvacA6EHPP8KBem/FFH46LsQp
         meqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734939494; x=1735544294;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiQHoU9L3MnsvWNqfQf/4dokOc7GnFdCJsgq+6FZckc=;
        b=EjYhXkrRAANBxjKAPCUAlmcVIDe5lllad8MfVTngToN3mTcxXtHVH3zpQjkCsF+/SI
         JXavtM8nTBJl38m+ldec+6uFrDb5uLIMULWWf8AR3fY+/8Ncy4/wyhDaIWyHjn2KMZ+3
         OsXU5YhW//j9o3O/6uBRj8D2Jd22LNp6CsqFurt5hCa7i/1VfZILGAiKp0b8O3Xo6sJL
         feFnD+GfLkWWyK7V3IKvTd4u50IdkbWkNDuTdfXqcSSj9Y0/vaa0LoACrizzBGVBLB2b
         q4Vfu2PGab/2HIyxW16OXI8DIl1SzyAhPyvd/9YkxA7F9g03jEfJfu5LVNVx0QBzGU8W
         teHQ==
X-Forwarded-Encrypted: i=1; AJvYcCULjQaoLu01bYaCW5JcBP+GHav6mF57N0PYiAnG0OD477j7YnBjYeNcgLiPclfSVA+1r/5Zxh6igy1fwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOAhbFIxY89KOgbQ5Pmicnn4ARG/TdEqSt7uOFaRhFfGmgVqc
	hzs7eDQ6Y25zTsj9aqFQ25flwhBP3eNWg4uZt+qktYMUmsIiw78cRZhTCItxRpcczKd9BA1BLBP
	n
X-Gm-Gg: ASbGncu5OSNewA6aJifohNxGIHvlmO13C03lN1Md9Yint8oBeIx/IFd4S42qgkP9AU/
	qhUWvbqYs+g3YVt822iU5YNViURJBEBIvYrw6CcAhd6o34Wb8sgOyjbJGmMOMOi7N70Jd7EKgLv
	yjqBr7dNhv2gk0oMrhtVKai5NykMbvu9JDZIgflwVoWcoS8A3/LRhglGT/9bO/u+Y3GQh7iM8DG
	vBlXUFHaeMr4lKS45zhVSYd0QR3ADy6DJ4paB77xw3VXu/hcjBXh+RvoFbUV7zBA4quXW+CeyjF
	ikRMIe5j
X-Google-Smtp-Source: AGHT+IHArYhwjkS6hcZk7WksMhanRj8qk1kzc5NTtVYVbq21m8yHd/bpRrEiJGbVWvBDrp4BV4ZssA==
X-Received: by 2002:a17:906:99cc:b0:aae:85a9:5b66 with SMTP id a640c23a62f3a-aae85a95d37mr585829666b.60.1734939493756;
        Sun, 22 Dec 2024 23:38:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb9b3sm7253945b3a.158.2024.12.22.23.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 23:38:13 -0800 (PST)
Message-ID: <b174a6ef-4a28-4852-82bd-6074c3ac2af5@suse.com>
Date: Mon, 23 Dec 2024 18:08:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use of --convert-to-block-group-tree makes fs unmountable
To: Jeff Bahr <jeffrey.bahr@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAL4+Tgzk=MS1P93u6yq_m0aqbMyjXrwPiP-8nA5zp=fTu7Vr6w@mail.gmail.com>
 <a60e17bd-621d-4663-a3dd-25b0730e7ee5@suse.com>
 <CAL4+TgzD_YrC4jDCYH=-797ppqvrNMRFzxgFqJgUCJ26mKXuUQ@mail.gmail.com>
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
In-Reply-To: <CAL4+TgzD_YrC4jDCYH=-797ppqvrNMRFzxgFqJgUCJ26mKXuUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/23 17:46, Jeff Bahr 写道:
> Qu, thanks for the response,
> 
> When doing the conversion I received no errors. As far as I can
> remember this is the same and only error I've seen. I have not
> attempted any repair other than `btrfs-check --readonly` which returns
> the same set of errors.

OK, so it looks like it's really the conversion causing the problem.

BTW, did you try to mount the fs immediately after the conversion 
without a reboot?
I guess it just showed the same error?

> 
> I agree /dev/sdb appears to be bad. However I don't recall seeing any
> r/w errors recently as I just performed a full fs scrub last week with
> no error on any disks. Smart stats indicate this drive may need to be
> replaced due to age, although it reports no hard failures yet the
> drive is quite old.
> 
> Once my backup is complete I'm happy to try any repairs you could
> suggest.  Should we consider drive replacement for sdb?

Considering it's RAID1C3 and RAID6, no hurry to bother sdb until it 
really gives up.

For the attempted repair, I was going to recommend --init-extent-tree, 
but find out that it doesn't really take block group tree feature into 
consideration.

So unfortunately you may have to recreate the fs, and this time using 
the block-group-tree at mkfs time.

Or if you're adventurous enough, go the regular mkfs (without bgt 
feature), copy several TB's of data, unmount and retry the conversion to 
see if you can reproduce the error.
Appreciated that a lot if you can help pinning down the bug.


Another thing is, you can take the following dump, right now (even when 
doing the data backup):

# btrfs ins dump-tree --hide-names -b 102652926951424 <device>

I'm just a little curious what's the metadata that should be a block 
group tree.

Thanks,
Qu


> 
> Thanks,
> Jeff
> 
> On Sun, Dec 22, 2024 at 10:18 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2024/12/23 07:07, Jeff Bahr 写道:
>>> Looking for suggestions on recovering a broken btrfs fs after
>>> attempting to use --convert-to-block-group-tree. I was experiencing
>>> slow mount times, 5-10 minutes on reboot. Docs suggesting converting
>>> to block group tree. I performed the operation on an unmounted file
>>> system. I tried rebooting to test boot times and was unable to mount
>>> the file system normally after reboot. After a few recovery attempts I
>>> was able to mount with 'mount -o rescue=all,ro'. I'm currently moving
>>> all data to offsite backup incase of total loss of the fs.
>>>
>>> I get the following errors when attempting to mount
>>
>> Is this the same error immediately after the conversion? Before any
>> repair attempt?
>> And what attempt have you done after the failed first mount?
>>
>> And I guess the conversion doesn't result any error message?
>>
>> Finally, have you ran btrfs-check before or after the conversion?
>>
>>>
>>> [  159.345342] BTRFS info (device sdj): bdev /dev/sdb errs: wr 15660,
>>> rd 8, flush 1, corrupt 0, gen 0
>>
>> This line shows a very bad history of the device,
>> sdb have a lot of write errors, some read errors, and even one flush error.
>>
>> I'm not sure if it's even reliable. But it may not be a big deal since
>> your fs have RAID1C3, one unreliable device won't cause anything wrong.
>>
>>> [  159.364088] BTRFS error (device sdj): level verify failed on
>>> logical 102652926951424 mirror 1 wanted 1 found 0
>>> [  159.377694] BTRFS error (device sdj): level verify failed on
>>> logical 102652926951424 mirror 2 wanted 1 found 0
>>> [  159.382394] BTRFS error (device sdj): level verify failed on
>>> logical 102652926951424 mirror 3 wanted 1 found 0
>>
>> This means a tree block of block group tree is not at where it supposed
>> to be.
>>
>> It looks like the metadata COW is completely broken (extent tree
>> corruption? space cache corruption?).
>>
>>>
>>> This can also be seen in the attached dmesg log.
>>>
>>> I am looking for suggestions to possibly recover this file system to
>>> avoid having to recreate the fs from backups.
>>
>> Such tree level mismatch is pretty bad, so I'd recommend to backup the
>> data first. And may have to recreate the fs from backup eventually.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Host information:
>>>
>>> uname -a
>>>> Linux server 6.8.0-51-generic #52-Ubuntu SMP PREEMPT_DYNAMIC Thu Dec  5 13:09:44 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> btrfs --version
>>>> btrfs-progs v6.6.3
>>>
>>> btrfs fi show
>>>> Label: 'new_btrfs'  uuid: 0ab9d35a-4d18-4a06-8881-e9cef44324a8
>>>           Total devices 10 FS bytes used 45.20TiB
>>>           devid    1 size 7.28TiB used 5.66TiB path /dev/sdj
>>>           devid    2 size 7.28TiB used 5.66TiB path /dev/sdk
>>>           devid    3 size 7.28TiB used 5.66TiB path /dev/sdb
>>>           devid    4 size 7.28TiB used 5.66TiB path /dev/sdp
>>>           devid    5 size 7.28TiB used 5.66TiB path /dev/sdr
>>>           devid    6 size 7.28TiB used 5.66TiB path /dev/sds
>>>           devid    7 size 7.28TiB used 5.66TiB path /dev/sdd
>>>           devid    8 size 7.28TiB used 5.66TiB path /dev/sdf
>>>           devid    9 size 7.28TiB used 5.66TiB path /dev/sdl
>>>           devid   10 size 7.28TiB used 5.66TiB path /dev/sdn
>>>
>>> btrfs fi df
>>>> Data, RAID6: total=45.14TiB, used=45.14TiB
>>>      System, RAID1C3: total=32.00MiB, used=32.00MiB
>>>      Metadata, RAID1C3: total=60.00GiB, used=60.00GiB
>>>      GlobalReserve, single: total=512.00MiB, used=0.00B
>>


