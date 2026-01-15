Return-Path: <linux-btrfs+bounces-20596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E29DED28B03
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 22:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8028730942F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A73246FA;
	Thu, 15 Jan 2026 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I7P1eUOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D551FBC8E
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511892; cv=none; b=RgJ9R6ANJcz5CKTJHo/n+srh34cb6URor9wAdeOLtFvwMaUbKoDbc/UZV6SsaaL2WFd6/8Z8JzT8z/ZCQpEipAAkfg9vsi4ojZowluGz1k9i2a1KlH7qJyctKuHrGES5YIUxYlZWRcu6PxFvh8F2yG6x2flcVw9mNgLye1RmQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511892; c=relaxed/simple;
	bh=72/i5WP0HAMKLm1gG6OMXgvJ1W4VsoWIoVmJhOceIXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEyG7XUcwkOaKovgEax8IaqRNYbHuYt84XcXCX8AMQQx1RotkYrk+TFiJTmeEt3ojfiUcnv+WEcZAUX5I3dxPnP0/OaT/uOPwHlW0kbH7jCJBfC8JXQk801r7h/b94MhuY+geTScKI/0jK/p8frce5D3VXZy96FbynTxfic2esY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I7P1eUOV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee2715254so6738465e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 13:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768511887; x=1769116687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G+OOis8Hz2lcnoTNlOZmtKSZTmkhAd3YSa9lrrdClLQ=;
        b=I7P1eUOVvkBwrP/F217BXiZnkMVHOjnyLagH91a6lj4KcaeaEi5rPry6gjWsaTtMUd
         YsVePibrfcIDzhkMIzPu9VbHPxU5e49BRv4TuNYmMc+llin/mrLFw2tbj8WBn85IZ7Iy
         cb8H0ddoE7NZS9RK4CALwJkJTlhWMN9Se5dpEusfC4qIeD2KIJDiZXqSipzCJWgIkx20
         FT17TUR51hQUhGpcnH8MBncqIL+/UZhctN62KWtqiZEQlBjqmqEgi0+DQ8M80n5RFD8+
         R/Xzy4KwTBMYH8l7W+CIP7jG0iiDw9oj3bcXz4NV8e7yusd6eijBa5gGtnSMsJV3IjwY
         Hsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511887; x=1769116687;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+OOis8Hz2lcnoTNlOZmtKSZTmkhAd3YSa9lrrdClLQ=;
        b=F9gLInBjCp8fEjK8iNFCjsgYBe9Py4zA4Ao4xRHovbbZxiC1pqYF/jTfVr00qqZIeh
         0UJMNmRaB9oT0Ii38vryUJlBL+3oqtq5FuF72VUFGJB3bHqpR57qo/3B7VM6Ln0uJX53
         aOCIfufQO95mYg2ZrIolAO4izvESrfLh2lPC88FDf8MeoMLvGxG/0r9/HFM70Rabhbm5
         hnv7UbDN1ROE0sE9GfcLh7/4uN3YOca5FitsODQT1b+ulgI/L5WvHenqWroOgEVRZD6U
         VN8kNrPE3/afIZj67Jos1mG7MhtscxuN5Fd2jA6GmOuSPkT0OnGK3dXVcGG3AfENZTZH
         rMig==
X-Forwarded-Encrypted: i=1; AJvYcCUJirI1J5+qPilhBDfKDJmm3O57q99u67aQghMMS/5ITW5Kac74SAAFwyaxGc8A6LBpFFayL+JvkRE1vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydNP3pMh2uEjMAP+VTtq0qhvysST8z7bw5zQ5bTXvo70P4chMD
	LwRiU4EIYWXJJu7eZACJhudmk71H4Et+JSzRnH6ggpK7y2YsG/c1ye4QaJngoEEiRQrXgoTbMQC
	M+sss
X-Gm-Gg: AY/fxX7r4Oafi3tfD7+pTcV2BiYdHgUeZHbVRPVL/6eArYlVYE7ou1pBqjbOOtwqCwI
	1ZdshfTO3d/O4J0zxSq4CnnT/6eaEJH5nJ2Ff0hxytjgasW9XVkV3DXiz7daIc9aZFf9Pb2Dszs
	PcTC0OcwmbHRSbGWCkaWtXr7JUitL6Q7aeE2QzJWZ5dGH8F2F2YhofT/qSml3l/IIvyggbsGYub
	Ye0BxaoUa5KssVsliPO5JGNjUZ45GUxiAZ27ANIVgbAb0+TBxGCs+lRCuNNBMBaRgzgVITqjIWw
	+gFwcIiVTN4/YByFnmKyBGyPY10GvfltKqBfSXI/QjuLXzlI3kCR8BrIx2qlz6m86AlR1+dKdZ5
	Llg3yiRkHAIVKHkGPNVSwF0l/5o2gitDpIwjorW2C9e8nUkviOEUwlnoeIIkGMl7hVkoBLkQNUj
	4x7m4lxlmbSDQzfukkoIDYDst07uFuwhM1Y7c5eUDC3BXHyAld7Q==
X-Received: by 2002:a05:600c:1909:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-4801e33c23cmr13985355e9.21.1768511886962;
        Thu, 15 Jan 2026 13:18:06 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10c5502sm271661b3a.24.2026.01.15.13.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 13:18:06 -0800 (PST)
Message-ID: <93db0013-9301-4839-b0c6-fea1847b8f44@suse.com>
Date: Fri, 16 Jan 2026 07:48:02 +1030
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
 <07600bff-a6dc-4b86-9dd6-aa5077ca8b09@suse.com>
 <ScE5lMhg6rlV47ttw0oUEWA5IsyxChuvN1pTOoj_KNj5rUpineEqR3GsPjNZl61xtXG4QS4v9v3ur4Ac0zI5GvdGEW_gWFJBD_FazYLcd_E=@proton.me>
 <5a643fd6-1b1c-45ad-86a0-5d53f074d6f7@suse.com>
 <X0lfIuRtAucC_QSQqThoEcvj3TAfGqQ8Cr--HLo4NpjJPtayej6Tjehlylu2EV2lANMvacCb9xRRfynobNO8DAsMTTrQXhzt6WpTOvjGFOA=@proton.me>
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
In-Reply-To: <X0lfIuRtAucC_QSQqThoEcvj3TAfGqQ8Cr--HLo4NpjJPtayej6Tjehlylu2EV2lANMvacCb9xRRfynobNO8DAsMTTrQXhzt6WpTOvjGFOA=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/16 07:42, jollycar 写道:
> Tested VirtualBox setup on ext4:
> 
> - Created new ext4 partition on different physical disk
> - Cloned VM instance to ext4 location
> - Copied Windows 10 ISO to ext4 partition
> - Started fresh Windows 10 installation
> 
> Result: BSOD still occurs during installation on kernel 6.18.5.

So it's definitely something wrong with the VBox module now.

It's out of our understanding, so not much help can be provided.
You may want to report the error to upstream vbox:
https://github.com/VirtualBox/virtualbox/issues

(And that's why most developers are using libvirt/qemu, where KVM has 
upstream support)

Thanks,
Qu

> 
> Regards,
> Jollycar
> 
> 
> 
> On Tuesday, January 13th, 2026 at 11:03 PM, Qu Wenruo <wqu@suse.com> wrote:
> 
>>
>>
>>
>>
>> 在 2026/1/14 05:38, jollycar 写道:
>>
>>> Thanks for the response.
>>>
>>> Module installation: DKMS via the virtualbox-host-dkms package. The dkms status output confirms vboxhost/7.2.4_OSE is compiled for each kernel including the broken ones (6.18.3, 6.18.5 (tkg), 6.19.0-rc3).
>>>
>>> Regarding CPU type specification:
>>>
>>> VirtualBox doesn't have qemu-style CPU model selection. The --cpu-profile option only supports "host" (full passthrough) or ancient CPUs (8086/80286/80386) which don't meet Windows 10 requirements.
>>>
>>> Additional testing: I recently upgraded my desktop pc from Ryzen 9 5900X to 9950X3D (reusing same disks and linux install) and the regression occurred identically on both CPUs. Also tested custom compiled TKG kernels (6.12/6.18 with bore scheduler). The behavior matches the Manjaro kernels exactly (6.12 works, 6.18 breaks).
>>
>>
>> Thanks for the extra info, I guess the last thing we can verify is, try
>> to run the same VBox setup, using disk images from an EXT4/XFS.
>>
>> And if that still failed, we're sure it's fs independent but more likely
>> VBox dependent.
>>
>> Thanks,
>> Qu
>>
>>> Regards,
>>> Jollycar
>>>
>>> On Monday, January 12th, 2026 at 8:48 PM, Qu Wenruo wqu@suse.com wrote:
>>>
>>>> 在 2026/1/13 02:03, jollycar 写道:
>>>>
>>>>> Qemu/libvirt test results on kernel 6.18.3:
>>>>>
>>>>> Setup:
>>>>> - Virtualization: qemu via libvirt (virt-manager)
>>>>> - Disk format: qcow2
>>>>> - Disk location: /data/virtual-os/win10-qemu-test.qcow2 (same btrfs subvolume as VirtualBox VMs)
>>>>> - COW disabled on disk image (chattr +C)
>>>>> - ISO: Same Windows 10 ISO used in VirtualBox tests
>>>>> - Guest: Windows 10
>>>>>
>>>>> Result:
>>>>> Windows 10 installation completed successfully without any crashes. Installation proceeded through all phases including multiple reboots and reached the desktop without issues.
>>>>>
>>>>> Summary of all tests on kernel 6.18.3:
>>>>> - VirtualBox 7.2.4: Crashes during installation (all cache/mtype configurations tested)
>>>>> - Qemu via libvirt: No crashes, installation completes successfully
>>>>>
>>>>> Both using the same btrfs filesystem, same subvolume location, same Windows ISO, and COW disabled.
>>>>
>>>> Thanks a lot, this looks like there is something wrong related to the
>>>> VBox out-of-tree kernel module.
>>>> In that case, the btrfs community is not going to help much unfortunately.
>>>>
>>>> Mind to share how is the out-of-tree kernel module installed?
>>>> The pre-compiled one from the distro? The DKMS one or something else?
>>>>
>>>> And just some guesses, can VBox specify what type of CPU (and extensions
>>>> like SSE/AVX) it uses?
>>>> If so (like qemu), mind to check if you can specify some CPU types
>>>> without some newer extensions while still meets the minimal CPU
>>>> requirement of Windows 10?
>>>>
>>>> I'm wondering if it's some extension handling not done properly, which
>>>> is commonly utilized by checksums.
>>>> Thus triggers the checksum mismatch errors inside Windows.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> On Sunday, January 11th, 2026 at 8:43 PM, Qu Wenruo wqu@suse.com wrote:
>>>>>
>>>>>> 在 2026/1/11 21:39, jollycar 写道:
>>>>>>
>>>>>>> Storage configuration details:
>>>>>>>
>>>>>>> Storage format: VDI (VirtualBox Disk Image)
>>>>>>> Storage location: /data/virtual-os/ (btrfs subvolume with COW disabled, verified with lsattr)
>>>>>>
>>>>>> OK, this means it's not related to the direct IO changes in newer kernels.
>>>>>>
>>>>>> When COW is disabled, data checksum is also disables, thus direct IO is
>>>>>> still doing the true zero-copy behavior.
>>>>>>
>>>>>> This ruled out the btrfs direct io change, but this means I have no clue
>>>>>> what is going wrong at all now.
>>>>>>
>>>>>>> Controller: IntelAhci (SATA)
>>>>>>> Default configuration: hostiocache on, mtype normal
>>>>>>>
>>>>>>> Cache and media type testing on kernel 6.18.3:
>>>>>>> - Default (hostiocache on, mtype normal): BSOD within 1 minute during installation
>>>>>>> - mtype writethrough: Gets much further, BSOD occurs on first VM reboot
>>>>>>> - hostiocache off (mtype normal): Gets much further, BSOD occurs on first VM reboot
>>>>>>>
>>>>>>> None of the configurations provide a working solution - they only delay the crash.
>>>>>>>
>>>>>>> On kernel 6.12.63 with default settings (hostiocache on, mtype normal), Windows installation completes successfully without any crashes.
>>>>>>>
>>>>>>> I have not yet tested with qemu/libvirt. Should I proceed with that test?
>>>>>>
>>>>>> Yes please. Libvirt/qemu is a more common solution among developers.
>>>>>> If you can reproduce it using libvirt/qemu, more btrfs developers can
>>>>>> try to reproduce it and look into it.
>>>>>>
>>>>>> And if not, the cause may shift towards vbox other than btrfs.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>> On Sunday, January 11th, 2026 at 10:15 AM, Qu Wenruo wqu@suse.com wrote:
>>>>>>>
>>>>>>>> 在 2026/1/11 20:33, jollycar 写道:
>>>>>>>>
>>>>>>>>> #regzbot introduced: v6.12..v6.18
>>>>>>>>>
>>>>>>>>> [1.] One line summary of the problem:
>>>>>>>>> VirtualBox VM crashes with BSOD during Windows installation on kernels 6.18+ (works fine on 6.12 LTS)
>>>>>>>>>
>>>>>>>>> [2.] Full description of the problem:
>>>>>>>>> Windows 10 and Windows 11 installation inside VirtualBox consistently crashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.19-rc3. The same VirtualBox configuration and VM image work perfectly on kernel 6.12 LTS. The BSOD errors vary each time (most recent: 0x80070470 - "file may be corrupt or missing"). The host system remains completely stable with no logged errors.
>>>>>>>>>
>>>>>>>>> [3] Kernel & Hardware:
>>>>>>>>> - Kernel versions tested:
>>>>>>>>> * Working: 6.12.63-1
>>>>>>>>> * Broken: 6.18.3-2, 6.19.0-rc3-1
>>>>>>>>> - Distribution: Manjaro Linux
>>>>>>>>> - Architecture: x86_64
>>>>>>>>> - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJARO SMP preempt mod_unload)
>>>>>>>>>
>>>>>>>>> [4.] Filesystem and storage:
>>>>>>>>> - Root filesystem: btrfs on LUKS encryption
>>>>>>>>> - Mount options: zstd compression level 3, SSD optimizations, async discard, free space tree
>>>>>>>>> - VM storage: separate btrfs subvolume
>>>>>>>>
>>>>>>>> What's the storage file configuration? Like what's the cache mode setting?
>>>>>>>> I don't know VBox at all, but there may be something similar to
>>>>>>>> libvirt's cache mode (none/unsafe/writethrough etc).
>>>>>>>>
>>>>>>>> More importantly, will tweaking the cache mode change fix the broken
>>>>>>>> kernels?
>>>>>>>> If so it may point to direct IO related behavior changes.
>>>>>>>>
>>>>>>>> And what's the storage file format? QCOW2? RAW? Or whatever format
>>>>>>>> provided by Vbox?
>>>>>>>>
>>>>>>>> And one final question, have you tried qemu (or libvirt + qemu) and can
>>>>>>>> it still be reproduced with qemu?
>>>>>>>> As I'm wondering if the direct IO related change will even affects qemu
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>> - btrfs device stats: all zeros (no errors)
>>>>>>>>>
>>>>>>>>> [5.] Reproduction:
>>>>>>>>> - Boot kernel 6.18.3-2 or 6.19.0-rc3
>>>>>>>>> - Start VirtualBox 7.2.4 r170995
>>>>>>>>> - Create new Windows 10 or Windows 11 VM
>>>>>>>>> - Begin OS installation
>>>>>>>>> - BSOD occurs within 1-3 minutes with varying errors (latest: 0x80070470)
>>>>>>>>> - Issue is 100% reproducible on 6.18+, never occurs on 6.12
>>>>>>>>>
>>>>>>>>> Additional context:
>>>>>>>>> - Host system remains completely stable during VM crashes
>>>>>>>>> - No btrfs errors in dmesg or device stats (all zero)
>>>>>>>>> - Issue persists across multiple 6.18/6.19 releases over one month
>>>>>>>>> - VirtualBox 7.2.4 modules load successfully on all kernel versions
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Jollycar


