Return-Path: <linux-btrfs+bounces-10938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7405CA0BCAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 16:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DC3188652F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3291FBBC0;
	Mon, 13 Jan 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bex/Vjjh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17D240225
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783682; cv=none; b=sF6yYDpNVyddRHU9HqY7KSBIMTXEt05ykgC7VVOZAZewXJnx746Uo/JCGdMnySUDait2PBc3NLUd7mpqCC74CGhdiZCBdvYhnQQ85Cs8kcBMKisW1+KaYESEPoXF4JrEWBw10x7hgGoSKbEkJPRuvX4RbJwA6z5pxmhoMefQVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783682; c=relaxed/simple;
	bh=cpCaQcmja0YUzjWAJsphpxLWAkZeol/GKBUriiTJxxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NNgM3CODGh3ULuXN3mGNGOA7jti6Nkm9NAITZNYs52kSuOiBfKnO8Ju8bct4FNNHF5MnlwjyRFPrfmsA2KmY1xhqX/DIbWX9FHOhHB3Um+SkZoOb4KFbSG7BpVRyhmlgPxezjZVcohReV0L15thIqYOLoBhFYBoexWHZNIcePs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bex/Vjjh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec111762bso810040166b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 07:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736783679; x=1737388479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElHxHYF5NgHSmY97Ruv7689Wu5TnUl5D6BjXBBetJF0=;
        b=Bex/VjjhrVKKmRBxVmCliYGWRaEGunZ5dOmiJvvOsqwA1j9xraakNZuR2cr0Zxmk0K
         n5gqEDfA2v2eABQInAFRjCifg06/DRu/rIdv1L/HsR38IOQA2dJsoanPx5/rOJmdcGmc
         umZJkBA7qpVnHGtwH23ByvnTtDHeWqTG6Kyn33QJ0YL+7asqDrCyEcznaDp4o9GAaHm4
         sFAninkQjJDvfagEUmQzO3fQyFte7nyJDT0BC1bAzamVSWzmJNL/1bHcu0uDSaYCm3ta
         dcV/NAbc65yQA3LPnZDE9phjrvrEMuOpLwq4BQd4tILXcb9Y4Nlako9LHBVJnUOpC5Jb
         pqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783679; x=1737388479;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElHxHYF5NgHSmY97Ruv7689Wu5TnUl5D6BjXBBetJF0=;
        b=ImgK2TjCHjU/0zZ1qf0ZMoIADusWE5v3v39yzNedD55gwc+MxMAMOKvbmdqRavOP09
         dV/bCq6DwQJiUzHi3ckAcmJbWBFa8N1NFha+Nfd0VH4ExyGe7Z04Nu2x2WvXikNIzM93
         BbvpCYjAf9GzeHkZd2UpGSIIDViqpb1UBaXZ7Kti+PiBs/dMEEyk1BeP7EJOrEDgQsFY
         os76XUR9AzHPQ5O/YN86VkUj11YQn0Drh4XVgKaTpdewu0PyngnfgzTFqG5INTPjrFB7
         xLsWD85G2d1lQh5naKELB1X/zDuS0dZszRo5vTLX3Sar3lPH/Fx/ZxewBaeDZtG/YiX/
         TGjQ==
X-Gm-Message-State: AOJu0YyygWbPeJscAFW5g7PUVlPjMJR1mwP06ACveNNKyBX7ezl69vD8
	WGW/xt+NUyR/QxGWmfisqAgTMaT7Grelc/91RbIUjzZAoXROFB8cGZVRMA==
X-Gm-Gg: ASbGncv1dithh59F30YrgqJMBeFyxJ/pxclt9VA6niLBZzo2IG8vQ1SaWm1TWLtbIa3
	C3GbGvfVEDJWx1ItLyDbYvspda7fqkuuR2R1f57XZma29ufI5WqNpomByJVHzNWNNYyYWXfgr8L
	IK+hQcFeW2bSIgVpJyWMQULrGoiERXaw8arf3wWEW/8NFQu+JLHWeuYx6L9jpXCWUllAIPFHid0
	mGY8nHsEtU1Z0SfR2kX3hxVLfLLOIDT/6DSmwky72eiAU3Tgr4=
X-Google-Smtp-Source: AGHT+IGI4QhSpJArnt6COQclYJX8lTy7rdxTikniuERmJ22IZ7BNUt4axJvGSyZA7wGWAmeRPsGnWA==
X-Received: by 2002:a17:907:9997:b0:ab2:c0ba:519e with SMTP id a640c23a62f3a-ab2c0ba708fmr1824150566b.35.1736783678434;
        Mon, 13 Jan 2025 07:54:38 -0800 (PST)
Received: from [10.1.1.2] ([77.253.223.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b1bb6sm516008066b.159.2025.01.13.07.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:54:35 -0800 (PST)
Message-ID: <501eb99a-dee6-4e84-93cb-ae49d48dcab6@gmail.com>
Date: Mon, 13 Jan 2025 16:54:31 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RAID1 two chunks of the same data on the same physical disk, one
 file keeps being corrupted
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <6ae187b3-7770-4b64-aa65-43fff3120213@gmail.com>
 <37cfd270-4b64-4415-8fee-fa732575d3a9@gmail.com>
 <a00a0c80-85fa-4484-9076-d4a2f50e177e@gmx.com>
Content-Language: en-US
From: ein <ein.net@gmail.com>
Cc: Linux fs Btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <a00a0c80-85fa-4484-9076-d4a2f50e177e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.07.2024 12:05, Qu Wenruo wrote:
> On 10.06.2024 16:56, ein wrote:
>>> [...]
>>> I don't think that it's RAM related because,
>>> - HW is new, RAM is good quality and I did mem. check couple months ago,
>>> - it affects only one file, I have other much busier VMs, that one
>>> mostly stays idle,
>>> - other OS operations seems to be working perfectly for months.
>>
>> [...]
>>
>> after spotting this:
>> https://www.reddit.com/r/GlobalOffensive/comments/1eb00pg/intel_processors_are_causing_significant/
>>
>> I decided to move from:
>> cpupower frequency-set -g performance
>> to:
>> cpupower frequency-set -g powersave
>>
>> I have got:
>>
>> ~# lscpu
>> Architecture:             x86_64
>>   CPU op-mode(s):         32-bit, 64-bit
>>   Address sizes:          46 bits physical, 48 bits virtual
>>   Byte Order:             Little Endian
>> CPU(s):                   32
>>   On-line CPU(s) list:    0-31
>> Vendor ID:                GenuineIntel
>>   BIOS Vendor ID:         Intel(R) Corporation
>>   Model name:             13th Gen Intel(R) Core(TM) i9-13900K
>>     BIOS Model name:      13th Gen Intel(R) Core(TM) i9-13900K To Be
>> Filled By O.E.M. CPU @ 5.3GHz
>>
>> One week without corruptions.
Hi Qu,  thank for the answer.
> Normally we only suspect the hardware when we have enough evidence.
> (e.g. proof of bitflip etc)
> Even if the hardware is known to have problems.
I think I have those - proofs. (1)
> In your case, I still do not believe it's hardware problem.
>
> > - it affects only one file, I have other much busier VMs, that one
> mostly stays idle,
>
> Due to btrfs' datacsum behavior, it's very sensitive to page content
> change during writeback.
>
> Normally this should not happen for buffered writes as btrfs has locked
> the page cache.
>
> But for Direct IO it's still very possible that one process submitted a
> direct IO, and when the IO was still under way, the user space changed
> the contents of that page.
>
> In that case, btrfs csum is calculated using that old contents, but the
> on-disk data is the new contents, causing the csum mismatch.
>
> So I'm wondering what's the workload inside the VM?

As far as I know in such configuration there's no writeback:

<disk type="file" device="disk">
   <driver name="qemu" type="qcow2" cache="none" discard="unmap"/>
   <source file="/var/lib/libvirt/images-red-btrfs/dell.qcow2" index="2"/>
   <backingStore/>
   <target dev="vda" bus="virtio"/>
   <alias name="virtio-disk0"/>
   <address type="pci" domain="0x0000" bus="0x00" slot="0x04" function="0x0"/>
</disk>
[...]
<controller type="pci" index="0" model="pci-root">
   <alias name="pci.0"/>
</controller>

This is mostly empty Win7 virtual machine with very small SQLite database (100-500MiB) with some 
network monitoring tool.

(1)
It took almost a year, I spent hundredths of hours and thousands of $ chasing this issue:
- tired 4 different new SATA controllers, from cheap ASM106X series to, DC grade HBA like LSI,
- multiple times replaced all SATA cables,
- replacing HDDs WD Red drives (mix of CMA/SMR) to WD Red SSDs SA500,
That part changed nothing. I experienced a lot of PCI-E link issues like, disappearing SATA drives, 
disappearing NVME drives - sometimes both of them, USB link problems etc.
But I don't think that link issues was related - the corruption happens without them (indication of 
link reset in dmsg).

- RMA the CPU from i9-13900k to i9-14900k,
- try every available Intel CPU microcode update packaged as BIOS update by mainboard vendor.
This part made the situation better, but I still could recreate corruption errors. As times goes on 
when running in the "performance" mode, the issues appeared often and were more severe. Every time 
switching from performance mode to powersave (lower voltage) made the CPU more stable.

The process of recreation looked as follows.
- shut the VM off,
- defrag the filesystem (btrfs filesystem defragment),
- turn the VM on,
- defrag/chkdsk on VM.
The errors appeared almost immediately. There was correlation how often it happens.
If the VM image was very fragmented in btrfs, then the probability of corruption was lower.

i9-14900k 3 month after RMA, started to have threading issues and started to leave zombie processes 
in performance mode. Powersave mode fixed it as well and it worked stable.

Finally, I replaced my mainboard (it was X13SAE-F) with Intel Z890 mobo and the latest CPU 
generation leaving whole IO stack intact (same: chassis, cables, controllers and disks).
I ran scrub, balance, this VM had one small 4096b unrecoverable error on bluescreen memory dump file 
and everything works fine from couple of days. I can't reproduce it with above method anymore.
I used ddrescue to reread everything I could from btrfs (this one file used by mentioned VM) and 
just replaced the file after ddrescue was done.

On Friday last week I asked Intel for refund.

I am positively surprised how much pain this btrfs filesystem (RAID10 for data and metadata) handled 
over last year. Great job devs, keep it up!

Sincerely,
e.


