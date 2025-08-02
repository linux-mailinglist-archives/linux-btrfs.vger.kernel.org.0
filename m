Return-Path: <linux-btrfs+bounces-15811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF3B19097
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 01:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BE01766F3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 23:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAF1C2334;
	Sat,  2 Aug 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CGlD8tvl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC22BAF7
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754176586; cv=none; b=Sj4pZdA76xWud6xYOn29NmxPcq1UCWybKT/waJ72SCRbaWmT9TTBNy+AQieY177Tp9qb5oF2v1kR1L70jmGPm0D5Yxkrc6wTUVF+0401jjWwpkOM6mJm5EWhPyZ97y/m4TqpyvMVgCq6SWJ9rA4wy1J1ovC66fRK2EVVQSz3OPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754176586; c=relaxed/simple;
	bh=lWE41mySGoZghT0hKihhbS4SSHlvTLTfXa9TcHSDFsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFM9OgSn3xB1Iq0hrpqWWcpdr/bB/oJGj0YhVRFVJDbEEUlxySUVaFdKpm7f54yJW40TlNFcB8hTj2dKf96o84BM9DgVQm10yOdvksOS99JMyR2QuuNrkgRUW9xowpLIVSIZ17zWRhHVt1i33P5UVoOCFrjilw8kt9OHCSb1aaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CGlD8tvl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso4090325e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754176582; x=1754781382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FLhPFxubFSyBAsCxR/ZdE+2JqHIAxoMnXrkASjFZDkE=;
        b=CGlD8tvlee+31OYSg89Af1DUKavU88i3zc8ATS0unbdM4J/fdxA9e9f1o/QX1YIV8x
         R+5P+nQNO1CCK2zXNQrNzYnbWF836QCYWfMDHl1uGIRB4+0PRv+uk2b5WSWTzJsmUDbf
         W+NoEHn0lP3iOaHMlZnXPL+J+FKL8opRXnlFrWF68IZLR7XuNAIgyoZN4xh5UCim5bGP
         X/KHBXwWpZHYZSJlLtkeDdVTcXKUmZHMinLlvkWvasVcoylxI917Ubu8L3yltGGjvRd+
         b1HebSAwaZWIF7RdH7nwe3xUnX2duBC6A5ubWg+JHfIOwl2xwtJHEaYmwvIsC/Gsu9E7
         WA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754176582; x=1754781382;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLhPFxubFSyBAsCxR/ZdE+2JqHIAxoMnXrkASjFZDkE=;
        b=Q194E1gbNaViX7lzJxpgar6VW64Bh60Bg70ZT10/l9LCQBr8+iAtcxI68d8rsf5Q4O
         fDUboU7WymhnLRlrLwrMU8ymNqQnLpJ9ogHLDAiDQ4mcACfEMaCRgJ8bVGR9jAJWWiPs
         G09F4L0A6JcvZzwvSO0AYQvcNHgIWFsMlRDWj9eA23xkoFxYS6oWcuxyFrONz2gu3D8l
         gnP0j7Kg885qBepy2NEURC/48vuw5YpeFTTyrjtFa3hkLxB41JSkYuaxgRt3crNkiFpP
         PcJ88udEY1lSwJNVMC+nsm0yO4ELfexs+14viO8avqjdKNJ6eZzW2DPS6DAYScJKDOmG
         o6cA==
X-Gm-Message-State: AOJu0YziI187zpqrOdip30tcJ+yKPtg3lk3P7w8bi30klCzaYtsce/Kc
	hnX3zEQPn7bSYQ9+oLyvqQ0pR42/mZqZdCuJOvdLnrkYwuSUmyn08HGxYyOZDUatBWgM7tduCjD
	1odGf
X-Gm-Gg: ASbGncuWGK4fc+gxuKgRs0KjUM1Q30VTbtri9Xik5f+fs/ndKQyx0D7rk11SuHHblrX
	z1lnZCQivL+w3rcFnaNjrI+7CKzWEYx4uzp3qMzTJ5PYcAI6HM9TYUt+cCP6j5GGHNvWpciYCwm
	6GdiwErg16hgZ+CDxUoMEGoYKnp5M8FvOrpVr73QbsNAc7xN68/f/oPq2CHiDscB7rku6ScCv7+
	jynnYc5+eavh+yrNeO+TYKMi2OOZOqAhyJxvWUjcEESGvLxd9PR611s5Sv2HkgwhmKIjfze+7mS
	NCyQdoNGYaqzHGMHIPypZDsE9rpPy3mqDHnIotYdMWSWzvD8rVkF/ML3vrAuoQYVw1UfdOe8Mbx
	E02klWZVpgCi1mR4lGoxTt1rYdVpdpVHULgUeDzwJfOOx/jR1OQ==
X-Google-Smtp-Source: AGHT+IGH8WoA/GR+V2Vmxcs0hREklcp26DZxZJmMWSThJ/6eKBEfFw2qhhSLjARm4a/l4Ndkk1FR5g==
X-Received: by 2002:a05:6000:40e1:b0:3b7:8c5c:539a with SMTP id ffacd0b85a97d-3b8d94b997fmr3230899f8f.38.1754176581699;
        Sat, 02 Aug 2025 16:16:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4236edbb31sm4958625a12.55.2025.08.02.16.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 16:16:21 -0700 (PDT)
Message-ID: <f5482052-dbd7-4997-a0ba-226722a07e6c@suse.com>
Date: Sun, 3 Aug 2025 08:46:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: Fix get_partition_sector_size_sysfs() to
 handle loopback and device mapper devices
To: Racz Zoli <racz.zoli@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250801110318.37249-1-racz.zoli@gmail.com>
 <3a8f23bf-e1cf-4803-a290-8d77b0d5dadd@gmx.com>
 <CANoGd8=_frhw+8iF=n0dFe-+vzwg4SRpM41XXRkB6Zt-2ANPpg@mail.gmail.com>
 <ccfba80a-d238-43d1-86b1-9d1ac1ec5c56@gmx.com>
 <CANoGd8=8km8v_-Md3GSvUh3F_hWaHtCj8-EQkeujDWx=NzWFyQ@mail.gmail.com>
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
In-Reply-To: <CANoGd8=8km8v_-Md3GSvUh3F_hWaHtCj8-EQkeujDWx=NzWFyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/2 22:15, Racz Zoli 写道:
> If I add my user to the disk group it works, but starting from the
> issue reported on github, I think it could be useful to leave the
> sysfs functionality there and make btrfs device usage work for normal
> users, and also users which are not in the disk group.
> One usage I can think of would be for web services doing statistics
> running under the apache user or any other random user who are not
> part of this group.

For those use cases, they do not really need to access the raw disks, 
regular `df` would be enough.

Although vanilla `df` is not always accurate for btrfs due to the 
dynamic chunk allocation behavior.

> 
> But if the policy should be for normal users to not have access to
> this functionality then you are right, and it might not be necessary
> to have the sysfs functionality.

I think the distro's policy is to minimal privilege by default, thus 
they want to reject such read access for non-disk group users.

And to be honest, if there is really some services want to access `btrfs 
fi usage`, adding them to `disk` group sounds completely valid to me.



But I also understand there are exceptions, like `lsblk` which shows the 
device size no matter if the user is in `disk` group or not, and that is 
utilizing sysfs too.

So I'd prefer David to do the final call.


And no matter what the final call David made, I still believe the error 
handling enhancement series (the first 4 patches from 
https://lore.kernel.org/linux-btrfs/cover.1754116463.git.wqu@suse.com/) 
would be needed before your fix.

Thanks,
Qu

> 
> Thank you,
> Zoli
> 
> On Sat, Aug 2, 2025 at 12:32 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2025/8/2 18:59, Racz Zoli 写道:
>>> I reproduced the bug on three separate distros, Arch, Ubuntu 25.04 and
>>> Fedora 42 and open() fails on all three of them
>>> when device usage was checked as a normal user. For testing I used the
>>> most basic commands I could to be sure it`s
>>> not only a particular usecase it fails.
>>>
>>> For real storage device:
>>>
>>> sudo mkfs.btrfs /dev/sda1
>>> sudo mount /dev/sda1 /mnt
>>> btrfs device usage /mnt -> run as normal user, and open() fails.
>>
>> Have you checked if you're in the "disk" group?
>>
>>>
>>> For loopback device:
>>>
>>> fallocate -l 5G test_bug.img
>>> sudo losetup --find --show test_bug.img
>>> sudo mkfs.btrfs /dev/loop0
>>> sudo mount /dev/loop0 /mnt/
>>> btrfs device usage /mnt/ -> also fails
>>>
>>> Thank you,
>>> Zoltan
>>>
>>> On Sat, Aug 2, 2025 at 7:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> 在 2025/8/1 20:33, Zoltan Racz 写道:
>>>>> Commit e39ed66 added get_partition_sector_size_sysfs() used by "btrfs device usage"
>>>>> which returns the sector size of a partition (or its parent). After more testing
>>>>> it turned out it couldn`t handle loopback or mapper devices. This patch adds a fix
>>>>> for them.
>>>>
>>>> I can fold this change into the original patch if needed.
>>>>
>>>> Although during my test, even unprivileged users can still do regular
>>>> ioctl based size detection, as long as the user have read permission to
>>>> that device.
>>>>
>>>> And if the user can not even read the device, I'd say the environment is
>>>> set up to intentionally prevent user accesses to that block device.
>>>>
>>>> So I'm not convinced about all the fallback method, especially we're
>>>> doing a lot of special handling (partition vs raw devices).
>>>>
>>>> Mind to also provide the test setup you're using and the involved block
>>>> device mode?
>>>>
>>>>>
>>>>> Signed-off-by: Zoltan Racz <racz.zoli@gmail.com>
>>>>> ---
>>>>>     common/device-utils.c | 48 +++++++++++++++++++++++++++++--------------
>>>>>     1 file changed, 33 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/common/device-utils.c b/common/device-utils.c
>>>>> index dd781bc5..a75194bf 100644
>>>>> --- a/common/device-utils.c
>>>>> +++ b/common/device-utils.c
>>>>> @@ -353,26 +353,44 @@ static ssize_t get_partition_sector_size_sysfs(const char *name)
>>>>>         char sysfs[PATH_MAX] = {};
>>>>>         char sizebuf[128];
>>>>>
>>>>> -     snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
>>>>> +     /*
>>>>> +      * First we look for hw_sector_size directly directly under
>>>>> +      * /sys/class/block/[partition_name]/queue. In case of loopback and
>>>>> +      * device mapper devices there is no parent device (like /dev/sda1 -> /dev/sda),
>>>>> +      * and the partition`s sysfs folder itself contains informations regarding
>>>>> +      * the sector size
>>>>> +      */
>>>>> +     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", name);
>>>>> +     sysfd = open(sysfs, O_RDONLY);
>>>>>
>>>>> -     if (!realpath(link_path, real_path)) {
>>>>> -             error("Failed to resolve realpath of %s: %s\n", link_path, strerror(errno));
>>>>> -             return -1;
>>>>> -     }
>>>>> +     if (sysfd < 0) {
>>>>
>>>> Just a small nitpic, it's better to check the errno against ENOENT.
>>>>
>>>> But my question still stands, does it really make sense to use sysfs as
>>>> a fallback?
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> +             /*
>>>>> +              * If we couldn`t find it, it means our partition is created on a real
>>>>> +              * device and we need to find its parent
>>>>> +              */
>>>>> +             snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
>>>>>
>>>>> -     dev_name = basename(real_path);
>>>>> +             if (!realpath(link_path, real_path)) {
>>>>> +                     error("Failed to resolve realpath of %s: %s\n", link_path, strerror(errno));
>>>>> +                     return -1;
>>>>> +             }
>>>>>
>>>>> -     if (!dev_name) {
>>>>> -             error("Failed to determine basename for path %s\n", real_path);
>>>>> -             return -1;
>>>>> -     }
>>>>> +             dev_name = basename(real_path);
>>>>>
>>>>> -     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
>>>>> +             if (!dev_name) {
>>>>> +                     error("Failed to determine basename for path %s\n", real_path);
>>>>> +                     return -1;
>>>>> +             }
>>>>>
>>>>> -     sysfd = open(sysfs, O_RDONLY);
>>>>> -     if (sysfd < 0) {
>>>>> -             error("Error opening %s to determine dev sector size: %s\n", real_path, strerror(errno));
>>>>> -             return -1;
>>>>> +             memset(sysfs, 0, PATH_MAX);
>>>>> +             snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
>>>>> +
>>>>> +             sysfd = open(sysfs, O_RDONLY);
>>>>> +
>>>>> +             if (sysfd < 0) {
>>>>> +                     error("Error opening %s to determine dev sector size: %s\n", real_path, strerror(errno));
>>>>> +                     return -1;
>>>>> +             }
>>>>>         }
>>>>>
>>>>>         ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
>>>>
>>
> 


