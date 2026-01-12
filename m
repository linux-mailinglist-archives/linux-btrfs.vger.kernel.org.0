Return-Path: <linux-btrfs+bounces-20424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCBED15501
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 21:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB78302D280
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CB32ABFF;
	Mon, 12 Jan 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IYTfAJym"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C623D294
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250905; cv=none; b=czOw+cxyi5VMVKKk9dKcaKh9KPXvhPDIRs7ZZmz2BvpmTM4r2hRUTqJTsDcTGd23l7dPwX4wmempXDUHhEnreNDqFuz767Y0NAwlxHfCqIZmEtNcyRbiqbkY+xCPHOUWup5V5WJN+S+GRqjiZep4WsdtVSm1Br5qxk1MccIUq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250905; c=relaxed/simple;
	bh=9Ghd4y1vzzwmLGCQBkUgixF5wHZfdAbgBykT6GYFYOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/6VjY1mymjw2G9Z0zkqN+pRNNxrWd4g3gQIULvzLTVRQeVsgVh7W1TdRkIwW+N19hxNIuYuisQr1ET9gUfynQo6Rq5MJWG1AyL85/rjFkLIiRY4s/sfBxaZBemUG9TxY7MD9q2ZB79JBe5vkAf7hwrPTHj5zPceoM+bcwPGUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IYTfAJym; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso39653645e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768250902; x=1768855702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNofD1HxaC2o6B0ekPYIm3Vf2/HOdfXWeC4iCJl6B/M=;
        b=IYTfAJymEInX3ZEPbkPYIeTYKbOHoN7piYcSfoSYlHUkewWg842i0MZJwPRSFddTbB
         H5rdLLrD+DmR9ulR06vsM9vnAh6ag+efzb8vrUgWGHYJATx20141A5t1OLT7l6OWkGuR
         r6I201mesOzPTApw2fI2P4sZtNMvq48+SACwM6FT6A0z++U9l/RKG/PxeNdW3d9TlI2Q
         Bjj2Vgzp2zRoiP5aW4GqLIk5oCGD/TqnHRTYdmFja0GTuwsXzW9Xg9ku7WVIoIpJbFvi
         f0PD7z57xXfixrCM3uDtqqgftAFcg0kfdU3G3FBqpwxRz58Zeu0SQLqKsnGzB/uUz1SE
         voxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250902; x=1768855702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNofD1HxaC2o6B0ekPYIm3Vf2/HOdfXWeC4iCJl6B/M=;
        b=H1xqYy4P0cJce9+Zj5KCkUaK6rudEm5mUYZCPKT7HON72dFK/6uS0B8EHG9pZDiQoe
         7NsGAO1czWfh9rWCp6BuGqRBLMmK19ciLnU5zlVJCcXeiRMbXuguK84fJoaEYQqvyjxG
         DBDBWEwofHEZxDBTEPrISSBaNbDw0dFIU0q0/esLvq4VQ6vfbzRWukyZQeXjM/Ed0KwM
         W7bsDwztBYLnF8p8Rhia1PvE7apNqW5fWuFmFs1pqg9uBBR6ZypFVdKAUZ2pew8WT4PL
         oWChjVGF8WHdebiP/kEMHnMvbX41MM/lOXlH23f4l0CTgRDRG1dVGJw5WUox0LlK7CHO
         2p8A==
X-Forwarded-Encrypted: i=1; AJvYcCWjuTArl4jZVMZ1jyDJArg2fJqTnVzG1L+Cfx3rKM2VoVD2LEnRSawBZysPu2ZXDd9f1TNiGI1ePyEIzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCeq5su+eS4FCcSgpV5ago1IG/uidKpTYNB+q0Iaap2Kfg1a1S
	QdYp6yv8K8g677EtCcM06ECQpov7PKRhk6hk69yY4EufUiGxFKjm0i3V0PF6CIEBNgc=
X-Gm-Gg: AY/fxX6Lm0biNqY3jhYZZedKacUADp2am/nP+5NM9sdJNOhcAmmuBUVxakzvFLgOxVO
	0QV7ip1ggpW5Tw45yml6pqYf9Orb7osPdMxshd4zZDVKUJkgfZcWEpvl74HPPduG7Jx5YR269zT
	pfBVn60BuhvtpX9ccQ9q1GwNcTZa00u+QFj7mH6AmTAFFWdS4MwmUIYss7dhog2Z1zCCCeJCGeX
	+z/yn8TvtorkbQNhLpq5SIaIEguy4X6GIHAbS81cRwCAQ81dSJ9D4Rgg3gdrZBPsa5cfuIA6Oz0
	naR8D/a2J1bubPrUXLZuKdEm/9Du3kQ3MQWRH8F4wow5Qrzka28BIn3grTdd3Nx9bOG+AHf9KpO
	k5PMiPJnx2QeY8gD30Wu8az54X7VqKCGkVWVMzNUodIfSIdNgPG/8PLC5egOBGSm2/tfFo1JWqe
	0bQBQpxd4Ddug9PtO/L/r+WFpynTsnJ1m6qKqgnGI=
X-Google-Smtp-Source: AGHT+IH9s93gkmuBttrS+h/XBMHT7i1Su2lrCzfBTYN/NbKyqiB7rnoNQUcvLStIfPiEyeMFbmwjfQ==
X-Received: by 2002:a05:600c:820f:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-47d84b32f09mr194610825e9.22.1768250901940;
        Mon, 12 Jan 2026 12:48:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a51dsm184311955ad.18.2026.01.12.12.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 12:48:21 -0800 (PST)
Message-ID: <07600bff-a6dc-4b86-9dd6-aa5077ca8b09@suse.com>
Date: Tue, 13 Jan 2026 07:18:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows
 installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
To: jollycar <jollycar@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me>
 <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com>
 <LCM3zm3y1s51pkWBZg6NU-4R6f89SVYSAxtNqq0gM5IlDFZfFjwSqvl-8yAvYcl7VizHjXIENm1vf6b7z2e25YQce7IQCr3Ms-w6vKkOKfY=@proton.me>
 <20c3ba51-fbf1-4de2-b88f-5edf817a24d6@suse.com>
 <FmCqd98aDZ5GTLc-1FUc4NRHRhDEDUDy1ylzO4rrFy_mV1zgC2tnmht5ov8px3ME3pBa6dioALVRD_tDKC3FhdUd4alND6G5g2bx8N7R154=@proton.me>
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
In-Reply-To: <FmCqd98aDZ5GTLc-1FUc4NRHRhDEDUDy1ylzO4rrFy_mV1zgC2tnmht5ov8px3ME3pBa6dioALVRD_tDKC3FhdUd4alND6G5g2bx8N7R154=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/13 02:03, jollycar 写道:
> Qemu/libvirt test results on kernel 6.18.3:
> 
> Setup:
> - Virtualization: qemu via libvirt (virt-manager)
> - Disk format: qcow2
> - Disk location: /data/virtual-os/win10-qemu-test.qcow2 (same btrfs subvolume as VirtualBox VMs)
> - COW disabled on disk image (chattr +C)
> - ISO: Same Windows 10 ISO used in VirtualBox tests
> - Guest: Windows 10
> 
> Result:
> Windows 10 installation completed successfully without any crashes. Installation proceeded through all phases including multiple reboots and reached the desktop without issues.
> 
> Summary of all tests on kernel 6.18.3:
> - VirtualBox 7.2.4: Crashes during installation (all cache/mtype configurations tested)
> - Qemu via libvirt: No crashes, installation completes successfully
> 
> Both using the same btrfs filesystem, same subvolume location, same Windows ISO, and COW disabled.

Thanks a lot, this looks like there is something wrong related to the 
VBox out-of-tree kernel module.
In that case, the btrfs community is not going to help much unfortunately.

Mind to share how is the out-of-tree kernel module installed?
The pre-compiled one from the distro? The DKMS one or something else?


And just some guesses, can VBox specify what type of CPU (and extensions 
like SSE/AVX) it uses?
If so (like qemu), mind to check if you can specify some CPU types 
without some newer extensions while still meets the minimal CPU 
requirement of Windows 10?

I'm wondering if it's some extension handling not done properly, which 
is commonly utilized by checksums.
Thus triggers the checksum mismatch errors inside Windows.

Thanks,
Qu



> 
> 
> On Sunday, January 11th, 2026 at 8:43 PM, Qu Wenruo <wqu@suse.com> wrote:
> 
>>
>>
>>
>>
>> 在 2026/1/11 21:39, jollycar 写道:
>>
>>> Storage configuration details:
>>>
>>> Storage format: VDI (VirtualBox Disk Image)
>>> Storage location: /data/virtual-os/ (btrfs subvolume with COW disabled, verified with lsattr)
>>
>>
>> OK, this means it's not related to the direct IO changes in newer kernels.
>>
>> When COW is disabled, data checksum is also disables, thus direct IO is
>> still doing the true zero-copy behavior.
>>
>> This ruled out the btrfs direct io change, but this means I have no clue
>> what is going wrong at all now.
>>
>>> Controller: IntelAhci (SATA)
>>> Default configuration: hostiocache on, mtype normal
>>>
>>> Cache and media type testing on kernel 6.18.3:
>>> - Default (hostiocache on, mtype normal): BSOD within 1 minute during installation
>>> - mtype writethrough: Gets much further, BSOD occurs on first VM reboot
>>> - hostiocache off (mtype normal): Gets much further, BSOD occurs on first VM reboot
>>>
>>> None of the configurations provide a working solution - they only delay the crash.
>>>
>>> On kernel 6.12.63 with default settings (hostiocache on, mtype normal), Windows installation completes successfully without any crashes.
>>>
>>> I have not yet tested with qemu/libvirt. Should I proceed with that test?
>>
>>
>> Yes please. Libvirt/qemu is a more common solution among developers.
>> If you can reproduce it using libvirt/qemu, more btrfs developers can
>> try to reproduce it and look into it.
>>
>> And if not, the cause may shift towards vbox other than btrfs.
>>
>> Thanks,
>> Qu
>>
>>> On Sunday, January 11th, 2026 at 10:15 AM, Qu Wenruo wqu@suse.com wrote:
>>>
>>>> 在 2026/1/11 20:33, jollycar 写道:
>>>>
>>>>> #regzbot introduced: v6.12..v6.18
>>>>>
>>>>> [1.] One line summary of the problem:
>>>>> VirtualBox VM crashes with BSOD during Windows installation on kernels 6.18+ (works fine on 6.12 LTS)
>>>>>
>>>>> [2.] Full description of the problem:
>>>>> Windows 10 and Windows 11 installation inside VirtualBox consistently crashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.19-rc3. The same VirtualBox configuration and VM image work perfectly on kernel 6.12 LTS. The BSOD errors vary each time (most recent: 0x80070470 - "file may be corrupt or missing"). The host system remains completely stable with no logged errors.
>>>>>
>>>>> [3] Kernel & Hardware:
>>>>> - Kernel versions tested:
>>>>> * Working: 6.12.63-1
>>>>> * Broken: 6.18.3-2, 6.19.0-rc3-1
>>>>> - Distribution: Manjaro Linux
>>>>> - Architecture: x86_64
>>>>> - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJARO SMP preempt mod_unload)
>>>>>
>>>>> [4.] Filesystem and storage:
>>>>> - Root filesystem: btrfs on LUKS encryption
>>>>> - Mount options: zstd compression level 3, SSD optimizations, async discard, free space tree
>>>>> - VM storage: separate btrfs subvolume
>>>>
>>>> What's the storage file configuration? Like what's the cache mode setting?
>>>> I don't know VBox at all, but there may be something similar to
>>>> libvirt's cache mode (none/unsafe/writethrough etc).
>>>>
>>>> More importantly, will tweaking the cache mode change fix the broken
>>>> kernels?
>>>> If so it may point to direct IO related behavior changes.
>>>>
>>>> And what's the storage file format? QCOW2? RAW? Or whatever format
>>>> provided by Vbox?
>>>>
>>>> And one final question, have you tried qemu (or libvirt + qemu) and can
>>>> it still be reproduced with qemu?
>>>> As I'm wondering if the direct IO related change will even affects qemu
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> - btrfs device stats: all zeros (no errors)
>>>>>
>>>>> [5.] Reproduction:
>>>>> - Boot kernel 6.18.3-2 or 6.19.0-rc3
>>>>> - Start VirtualBox 7.2.4 r170995
>>>>> - Create new Windows 10 or Windows 11 VM
>>>>> - Begin OS installation
>>>>> - BSOD occurs within 1-3 minutes with varying errors (latest: 0x80070470)
>>>>> - Issue is 100% reproducible on 6.18+, never occurs on 6.12
>>>>>
>>>>> Additional context:
>>>>> - Host system remains completely stable during VM crashes
>>>>> - No btrfs errors in dmesg or device stats (all zero)
>>>>> - Issue persists across multiple 6.18/6.19 releases over one month
>>>>> - VirtualBox 7.2.4 modules load successfully on all kernel versions
>>>>>
>>>>> Regards,
>>>>> Jollycar


