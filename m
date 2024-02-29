Return-Path: <linux-btrfs+bounces-2953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9352886D68B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 23:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BCE1C2209C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6D74BF1;
	Thu, 29 Feb 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="mOa9X+RF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434546D536
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244325; cv=none; b=pt/h+tyhjhvTqndLZe/B0LFLmmgDEA4VA6gP/Ch+wqE4fVUnsrq6mHuwywNbSdyKnRkMY5nzXmihaVhmjll2eA5i0yzdTfHR+fmHPKVi/5GOiqUMkCv+ojekxRb9zAiNSoKfrF0vq1UxS6d7uamrcaNIiPc/PAyzHyduefrlgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244325; c=relaxed/simple;
	bh=WH9N2nGE9wF9zeEhcX5YQJXmxdCM+BrtfCHSzAb23pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeoZk/azB66wr99jJf8J6aIMZ+fGgyaYvxunH1zYxaQ5QkcweU4ep2Hvj1gsQ5V5NWpKNC+Aq8gnxrx0Yu+hmKKvD3h5zNZ5hG67AdOo7SZsXae/8XGTqbtysO/NcazySts5TttiL1Ps0DIsDWCxLQBULauuWthsB31aSAIyBYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=mOa9X+RF; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id foWlrHHVGQc3jfoWlrPW3C; Thu, 29 Feb 2024 23:05:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1709244320; bh=7JoWB01ufRE74I5GTXo+K0ciaCmPX3Y8/xI5JEkDWl0=;
	h=From;
	b=mOa9X+RFLOKx0GliWr4UvYNIcGBchwoV68Co3xehNjSdpX0e3kq0YGbGMckPbFy+6
	 cerA4pN7npa8cUv6jUzL1HxXJp+zWzOxe4s19XnINdYHIZJxSpGmNboq8SoehDVhwH
	 03SoujRY4gqsx3i2As7tULt3JGofyWotP1mOyPVFR3XeGiLUO6GT5pP3GlZ412kkHa
	 9SOulFrLfOwrn/XgAgG/ZQH+TolQasovSc68dXVy2AgpZmzBUiDpmYTXfhVtFgclfa
	 UPFwpQhzlnWqOxDf6GtcSpvvclQQrTs2SEM0JZ7kSewGRI9/zLE3gKvr9q7csNOl0p
	 9Y20qj+0fWxGw==
X-CNFS-Analysis: v=2.4 cv=eux8zZpX c=1 sm=1 tr=0 ts=65e0ffa0 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=p0WdMEafAAAA:8 a=U-wgw_aUbNXxtflkicMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=CEsIH-8HjQcA:10 a=EFd53GHqFYiFSGm04UA1:22
Message-ID: <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it>
Date: Thu, 29 Feb 2024 23:05:19 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [REGRESSION] LVM-on-LVM: error while submitting device barriers
Content-Language: en-US
To: Patrick Plenefisch <simonpatp@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 regressions@lists.linux.dev, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org
References: <CAOCpoWc_HQy4UJzTi9pqtJdO740Wx5Yd702O-mwXBE6RVBX1Eg@mail.gmail.com>
 <CAOCpoWf3TSQkUUo-qsj0LVEOm-kY0hXdmttLE82Ytc0hjpTSPw@mail.gmail.com>
 <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
 <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
 <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
 <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNqcLHk+pE4wHu/qk8irv70ZVHY76ly3H5UQjYaPVPJgqhzk8jIBU9DmO3r299cZrbhVPhUc2nqgB84zm7RaGdzrWSbtKHVDCGitCX1Px4wCLfYfauvu
 VqxQ6mFzBt85iY2BCcb7CJgUhfXL7zIedQxaK480T4BpmdQbwKf/oRuDRr1epZFlYOamIDmrHPxZqBtg7uN1omKVoyq8rAXJuEjL79qsFZnYx3PRrwIceOPh
 n0SNS9NQsj9MZDASyCLZp+0bGfj61gI/C/8FW+bhBQgm9KYnpGQAr07ZAaDY/D74RFHCVuvA+3fDUJwFK1FJjzfKU4m4WZiwIbElkYAdId6YJe243pM9iwgC
 Dk0vT5yJz1oJLjqEVt9WIG4+DCgRKIYZSsmpb09EWkFDElg17FTTuRB71ZPlJAsXv3hW95q1eSALtMLDsINwhoh8ckac7xUkkkZEtndhYb0vZ77pzQYuzSn5
 DT0S+SBoQG40oAB/aOM1molcPnrLY1ujGymfGONKUvBouZzQktYtQxC/caVta5sw/m+vXwAFCtHJN6Zv

On 29/02/2024 21.22, Patrick Plenefisch wrote:
> On Thu, Feb 29, 2024 at 2:56 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
>>> Your understanding is correct. The only thing that comes to my mind to
>>> cause the problem is asymmetry of the SATA devices. I have one 8TB
>>> device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
>>> extents, lowerVG/single spans (3TB+3TB), and
>>> lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
>>> the other leg of raid1 on the 8TB drive, but my thought was that the
>>> jump across the 1.5+3TB drive gap was at least "interesting"
>>
>>
>> what about lowerVG/works ?
>>
> 
> That one is only on two disks, it doesn't span any gaps

Sorry, but re-reading the original email I found something that I missed before:

> BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> 0, rd 0, flush 1, corrupt 0, gen 0
> BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> tolerance is 0 for writable mount
> BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
> failure (errors while submitting device barriers.)

Looking at the code, it seems that if a FLUSH commands fails, btrfs
considers that the disk is missing. The it cannot mount RW the device.

I would investigate with the LVM developers, if it properly passes
the flush/barrier command through all the layers, when we have an
lvm over lvm (raid1). The fact that the lvm is a raid1, is important because
a flush command to be honored has to be honored by all the
devices involved.


> 
>> However yes, I agree that the pair of disks involved may be the answer
>> of the problem.
>>
>> Could you show us the output of
>>
>> $ sudo pvdisplay -m
>>
>>
> 
> I trimmed it, but kept the relevant bits (Free PE is thus not correct):
> 
> 
>    --- Physical volume ---
>    PV Name               /dev/lowerVG/lvmPool
>    VG Name               lvm
>    PV Size               <3.00 TiB / not usable 3.00 MiB
>    Allocatable           yes
>    PE Size               4.00 MiB
>    Total PE              786431
>    Free PE               82943
>    Allocated PE          703488
>    PV UUID               7p3LSU-EAHd-xUg0-r9vT-Gzkf-tYFV-mvlU1M
> 
>    --- Physical Segments ---
>    Physical extent 0 to 159999:
>      Logical volume      /dev/lvm/brokenDisk
>      Logical extents     0 to 159999
>    Physical extent 160000 to 339199:
>      Logical volume      /dev/lvm/a
>      Logical extents     0 to 179199
>    Physical extent 339200 to 349439:
>      Logical volume      /dev/lvm/brokenDisk
>      Logical extents     160000 to 170239
>    Physical extent 349440 to 351999:
>      FREE
>    Physical extent 352000 to 460026:
>      Logical volume      /dev/lvm/brokenDisk
>      Logical extents     416261 to 524287
>    Physical extent 460027 to 540409:
>      FREE
>    Physical extent 540410 to 786430:
>      Logical volume      /dev/lvm/brokenDisk
>      Logical extents     170240 to 416260
> 
> 
>    --- Physical volume ---
>    PV Name               /dev/sda3
>    VG Name               lowerVG
>    PV Size               <2.70 TiB / not usable 3.00 MiB
>    Allocatable           yes
>    PE Size               4.00 MiB
>    Total PE              707154
>    Free PE               909
>    Allocated PE          706245
>    PV UUID               W8gJ0P-JuMs-1y3g-b5cO-4RuA-MoFs-3zgKBn
> 
>    --- Physical Segments ---
>    Physical extent 0 to 52223:
>      Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
>      Logical extents     629330 to 681553
>    Physical extent 52224 to 628940:
>      Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
>      Logical extents     0 to 576716
>    Physical extent 628941 to 628941:
>      Logical volume      /dev/lowerVG/single_corig_rmeta_0
>      Logical extents     0 to 0
>    Physical extent 628942 to 628962:
>      Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
>      Logical extents     681554 to 681574
>    Physical extent 628963 to 634431:
>      Logical volume      /dev/lowerVG/single_corig_rimage_0_imeta
>      Logical extents     0 to 5468
>    Physical extent 634432 to 654540:
>      FREE
>    Physical extent 654541 to 707153:
>      Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
>      Logical extents     576717 to 629329
> 
>    --- Physical volume ---
>    PV Name               /dev/sdf2
>    VG Name               lowerVG
>    PV Size               <7.28 TiB / not usable 4.00 MiB
>    Allocatable           yes
>    PE Size               4.00 MiB
>    Total PE              1907645
>    Free PE               414967
>    Allocated PE          1492678
>    PV UUID               my0zQM-832Z-HYPD-sNfW-68ms-nddg-lMyWJM
> 
>    --- Physical Segments ---
>    Physical extent 0 to 0:
>      Logical volume      /dev/lowerVG/single_corig_rmeta_1
>      Logical extents     0 to 0
>    Physical extent 1 to 681575:
>      Logical volume      /dev/lowerVG/single_corig_rimage_1_iorig
>      Logical extents     0 to 681574
>    Physical extent 681576 to 687044:
>      Logical volume      /dev/lowerVG/single_corig_rimage_1_imeta
>      Logical extents     0 to 5468
>    Physical extent 687045 to 687045:
>      Logical volume      /dev/lowerVG/lvmPool_rmeta_0
>      Logical extents     0 to 0
>    Physical extent 687046 to 1049242:
>      Logical volume      /dev/lowerVG/lvmPool_rimage_0
>      Logical extents     0 to 362196
>    Physical extent 1049243 to 1056551:
>      FREE
>    Physical extent 1056552 to 1473477:
>      Logical volume      /dev/lowerVG/lvmPool_rimage_0
>      Logical extents     369506 to 786431
>    Physical extent 1473478 to 1480786:
>      Logical volume      /dev/lowerVG/lvmPool_rimage_0
>      Logical extents     362197 to 369505
>    Physical extent 1480787 to 1907644:
>      FREE
> 
>    --- Physical volume ---
>    PV Name               /dev/sdb3
>    VG Name               lowerVG
>    PV Size               1.33 TiB / not usable 3.00 MiB
>    Allocatable           yes (but full)
>    PE Size               4.00 MiB
>    Total PE              349398
>    Free PE               0
>    Allocated PE          349398
>    PV UUID               Ncmgdw-ZOXS-qTYL-1jAz-w7zt-38V2-f53EpI
> 
>    --- Physical Segments ---
>    Physical extent 0 to 0:
>      Logical volume      /dev/lowerVG/lvmPool_rmeta_1
>      Logical extents     0 to 0
>    Physical extent 1 to 349397:
>      Logical volume      /dev/lowerVG/lvmPool_rimage_1
>      Logical extents     0 to 349396
> 
> 
>    --- Physical volume ---
>    PV Name               /dev/sde2
>    VG Name               lowerVG
>    PV Size               2.71 TiB / not usable 3.00 MiB
>    Allocatable           yes
>    PE Size               4.00 MiB
>    Total PE              711346
>    Free PE               255111
>    Allocated PE          456235
>    PV UUID               xUG8TG-wvp0-roBo-GPo7-sbvn-aE7I-NAHU07
> 
>    --- Physical Segments ---
>    Physical extent 0 to 416925:
>      Logical volume      /dev/lowerVG/lvmPool_rimage_1
>      Logical extents     369506 to 786431
>    Physical extent 416926 to 437034:
>      Logical volume      /dev/lowerVG/lvmPool_rimage_1
>      Logical extents     349397 to 369505
>    Physical extent 437035 to 711345:
>      FREE
> 
> 
> Finally, I am not sure if it's relevant, but I did struggle to expand
> the raid1 volumes across gaps when creating this setup. I did file a
> bug about that, though I am not sure if it's relevant, as I removed
> integrity and cache for brokenDisk & lvmPool:
> https://gitlab.com/lvmteam/lvm2/-/issues/6
> 
> Patrick
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


