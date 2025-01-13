Return-Path: <linux-btrfs+bounces-10957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D2A0C2AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 21:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E4F1646AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCAA1CEEAA;
	Mon, 13 Jan 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sEcRreIW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380431B422D
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736800776; cv=none; b=XqepKKcGMA4AJ93ZWDdD2NC34CY3fcZ1MF4MnvZ9miHASYFepYiefOJtF8N0NA+js15Txn9sFQjH72ydpy6q7jWKOBV5fjoNDJNd4GY5tOTzrbhqpO1loKkoI6ICFWkYJdWcQ4NhjTi6UlE1xnD6Wa/pcJwki/kpKSicqJJf8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736800776; c=relaxed/simple;
	bh=ICJQ6VPHWFIX0XO3qyBk3J73DeED4qwGHHylTAafr7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5IL/Fd8rqthvqe8MyaumJneARkZZTDlHiWGOB9WkDK4xiwUa0YggG8SVQp/aBvydyt6MlPr5meoIvtAV6HdgcCQc4D0s6RYmj5VOpJpQ3fStgjiPgXZGocxIB35g7OUks6Xd0SFlOKzgtsxPKaqMBkc+wlLp+J12fxHCJ/ngBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sEcRreIW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736800771; x=1737405571; i=quwenruo.btrfs@gmx.com;
	bh=T4nubM21fss5WYjq3/02kn29KC1jA0XYMx+rGKIjCBY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sEcRreIWQ8REQqqtdliw4SGQfPgTM66GUmYiY6UWbko+qkIq01hMaIBj+fOKobN8
	 KQtW0HxCbAX5U9Nv8VxSGFeEeuP0gTaQjHgSphRxNyNiGuOOgjViydDcoR47/RK6T
	 FQg7ApAm9vLhUZX9C7ZdbFCzgxwm4Tkb+oZZCSVJ9pzmyiCowV7CAneHjvj7g4v2n
	 Xkprbkx0EQPOERiWHotOXm7i/2WFqJtHBz5lP8FbM2PALg8xLMJp+VRUqH5ZJzdbg
	 1YmZ9sDAYvCtt18xyGDCMqj+ELC8QWBvCLrnqv4dc4V6MIw+ykzlCYDsAYqBn8hmU
	 9GE5gTSYg68vGO0qlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1te0nj09Si-0080ud; Mon, 13
 Jan 2025 21:39:31 +0100
Message-ID: <3749cb72-a99f-4f4e-9682-e2cbf7604227@gmx.com>
Date: Tue, 14 Jan 2025 07:09:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RAID1 two chunks of the same data on the same physical disk, one
 file keeps being corrupted
To: ein <ein.net@gmail.com>
Cc: Linux fs Btrfs <linux-btrfs@vger.kernel.org>
References: <6ae187b3-7770-4b64-aa65-43fff3120213@gmail.com>
 <37cfd270-4b64-4415-8fee-fa732575d3a9@gmail.com>
 <a00a0c80-85fa-4484-9076-d4a2f50e177e@gmx.com>
 <501eb99a-dee6-4e84-93cb-ae49d48dcab6@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <501eb99a-dee6-4e84-93cb-ae49d48dcab6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fxpc4IkFoLy5+rZ/lIg8LQX8K4lEKYF89jh+WCdWKIvo20Pjudf
 Wl1wcFknGo0Vz32LtaH3S67Js7LpJ1Xz1Kp190Ivr5jmgu8/LVBx3/WsxCmhNge/zM1VmEm
 oE7wOCMGuolq4Ru41e3LEU8iT/a1ATqxrmvV1LRVfSKxidVVpqwpXUHtQQ9R1b/+TCWHxCt
 8PAkRywRtrU9O2wj1qJ9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VcqeEu10W/Y=;fam4llcdK4ZHBPcgsVLj6gxBmfG
 +xTxo2zkhBjC1Av0JZVlDnRaNBk+JoZLO7z6Ks6Mrp8+9KvNfxlfk7FtGEMFpnd9ieQe5olxA
 +WwKmnyeV0lxbJwi+GK/fmlXEqUaLLTfu8wsZuPI4AdnR+E7nSMteDxnYeG2vlB/ksw1ABv2r
 fIVFkbEhXLel/YWQByW2tJYac2aVzDlFD9eygM/ezQIJykmYnFL6GiThmh8GC+RR2m1E/JHFv
 JhXZ+aeM1Zwz7F55hMLRjDtUdqZ/mGpsQm+lyHn94zbx0zH1UPPqTxiylkJD3B7rBaqA8SKNV
 BKHaPf2etCkb85MqB5yxJpGcfDju7LWUBnvytW3bJs0ZDqDX4mshwXFT8o1Cl7rYKCWmsE3SS
 +8RS+y8NGzsluxsiDjyOQP4zc5TsvfomSvBPWtk/X6LW+AM/6OMPkZfM1QqqISNwixK8d89MO
 mubIOyAcEFsuMeBMdASsHYeohT6t5o8b8/HnazwWVnkq94NCL4h6LCYDMEDVtImG/l7vlDQ2g
 gFC4NMd1/fQDRqgiSsPobWzYdFCllDnh9HxThrRDhy2x4/U4jNIUZB5PqolozmMeZQjfsVDGq
 NlxHKXiSDiqgFLOS1KP62Ld8qypZQdTVXaJzopBl5UNuT/CYi2DnEtrRSIwKmY0eD/tbwX5wF
 q292EkVpzubr8cFPNdZxv40fRzlR/TAUAoeGt8gLB6qVQHLRMIuUAg3OljxsQPLyL9sTLALhO
 z+ss3YDw8W6H/4l24F7gYOGIy9Ui97mJh6MpWjuhwjdznQyxb+s1ZO90URWzW7Y8cL3eYWLj0
 8IsqLkWsEG8O4zZIcED61rrY9B29ZIbuZKW0hquogWRHYMDqDjiv0g5zOZ0/Ji+6LJsAY6xWk
 mMrA9+/ozZkfUgfmAtxcOHtEFRcfow8hBm6nZwjzQUgXe6uc6Ve5tZ2tOOCvfqHspMz6/Y7UR
 nSFwV6BRyP7+h5QwUjzItwg3LCUZ8c0qoUImeturqmaf98bjfm7zUPnWCG9BVWUiAyIpDl/Gc
 793hEPE8LzhK9KmV8Nh48ZCfKnndG4HW6CoKHcVOXUpDK/HiCjyRgtNN3PHR+9lOqsoNtyuhc
 izaSNOc0na7fvXy7Hsl7IGMTk20EmE



=E5=9C=A8 2025/1/14 02:24, ein =E5=86=99=E9=81=93:
> On 29.07.2024 12:05, Qu Wenruo wrote:
>> On 10.06.2024 16:56, ein wrote:
>>>> [...]
>>>> I don't think that it's RAM related because,
>>>> - HW is new, RAM is good quality and I did mem. check couple months
>>>> ago,
>>>> - it affects only one file, I have other much busier VMs, that one
>>>> mostly stays idle,
>>>> - other OS operations seems to be working perfectly for months.
>>>
>>> [...]
>>>
>>> after spotting this:
>>> https://www.reddit.com/r/GlobalOffensive/comments/1eb00pg/
>>> intel_processors_are_causing_significant/
>>>
>>> I decided to move from:
>>> cpupower frequency-set -g performance
>>> to:
>>> cpupower frequency-set -g powersave
>>>
>>> I have got:
>>>
>>> ~# lscpu
>>> Architecture: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0x86_64
>>> =C2=A0=C2=A0CPU op-mode(s): =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A032-bit, 64-bit
>>> =C2=A0=C2=A0Address sizes: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A046 bits physical, 48 bits virtual
>>> =C2=A0=C2=A0Byte Order: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Little Endian
>>> CPU(s): =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A032
>>> =C2=A0=C2=A0On-line CPU(s) list: =C2=A0=C2=A0=C2=A00-31
>>> Vendor ID: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GenuineIntel
>>> =C2=A0=C2=A0BIOS Vendor ID: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0Intel(R) Corporation
>>> =C2=A0=C2=A0Model name: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A013th Gen Intel(R) Core(TM) i9-13900K
>>> =C2=A0=C2=A0=C2=A0=C2=A0BIOS Model name: =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A013th Gen Intel(R) Core(TM) i9-13900K To Be
>>> Filled By O.E.M. CPU @ 5.3GHz
>>>
>>> One week without corruptions.
> Hi Qu,=C2=A0 thank for the answer.
>> Normally we only suspect the hardware when we have enough evidence.
>> (e.g. proof of bitflip etc)
>> Even if the hardware is known to have problems.
> I think I have those - proofs. (1)
>> In your case, I still do not believe it's hardware problem.
>>
>> > - it affects only one file, I have other much busier VMs, that one
>> mostly stays idle,
>>
>> Due to btrfs' datacsum behavior, it's very sensitive to page content
>> change during writeback.
>>
>> Normally this should not happen for buffered writes as btrfs has locked
>> the page cache.
>>
>> But for Direct IO it's still very possible that one process submitted a
>> direct IO, and when the IO was still under way, the user space changed
>> the contents of that page.
>>
>> In that case, btrfs csum is calculated using that old contents, but the
>> on-disk data is the new contents, causing the csum mismatch.
>>
>> So I'm wondering what's the workload inside the VM?
>
> As far as I know in such configuration there's no writeback:
>
> <disk type=3D"file" device=3D"disk">
>  =C2=A0 <driver name=3D"qemu" type=3D"qcow2" cache=3D"none" discard=3D"u=
nmap"/>

cache=3D"none" means direct IO.

Exactly the problem I mentioned, direct IO with data changed during
writeback.

You can change it to "cache=3Dwriteback" then it should resolve the false
alert mismatch.
(Or just simply change the disk image file to NODATASUM)

Thanks,
Qu

>  =C2=A0 <source file=3D"/var/lib/libvirt/images-red-btrfs/dell.qcow2" in=
dex=3D"2"/>
>  =C2=A0 <backingStore/>
>  =C2=A0 <target dev=3D"vda" bus=3D"virtio"/>
>  =C2=A0 <alias name=3D"virtio-disk0"/>
>  =C2=A0 <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x0=
4"
> function=3D"0x0"/>
> </disk>
> [...]
> <controller type=3D"pci" index=3D"0" model=3D"pci-root">
>  =C2=A0 <alias name=3D"pci.0"/>
> </controller>
>
> This is mostly empty Win7 virtual machine with very small SQLite
> database (100-500MiB) with some network monitoring tool.
>
> (1)
> It took almost a year, I spent hundredths of hours and thousands of $
> chasing this issue:
> - tired 4 different new SATA controllers, from cheap ASM106X series to,
> DC grade HBA like LSI,
> - multiple times replaced all SATA cables,
> - replacing HDDs WD Red drives (mix of CMA/SMR) to WD Red SSDs SA500,
> That part changed nothing. I experienced a lot of PCI-E link issues
> like, disappearing SATA drives, disappearing NVME drives - sometimes
> both of them, USB link problems etc.
> But I don't think that link issues was related - the corruption happens
> without them (indication of link reset in dmsg).
>
> - RMA the CPU from i9-13900k to i9-14900k,
> - try every available Intel CPU microcode update packaged as BIOS update
> by mainboard vendor.
> This part made the situation better, but I still could recreate
> corruption errors. As times goes on when running in the "performance"
> mode, the issues appeared often and were more severe. Every time
> switching from performance mode to powersave (lower voltage) made the
> CPU more stable.
>
> The process of recreation looked as follows.
> - shut the VM off,
> - defrag the filesystem (btrfs filesystem defragment),
> - turn the VM on,
> - defrag/chkdsk on VM.
> The errors appeared almost immediately. There was correlation how often
> it happens.
> If the VM image was very fragmented in btrfs, then the probability of
> corruption was lower.
>
> i9-14900k 3 month after RMA, started to have threading issues and
> started to leave zombie processes in performance mode. Powersave mode
> fixed it as well and it worked stable.
>
> Finally, I replaced my mainboard (it was X13SAE-F) with Intel Z890 mobo
> and the latest CPU generation leaving whole IO stack intact (same:
> chassis, cables, controllers and disks).
> I ran scrub, balance, this VM had one small 4096b unrecoverable error on
> bluescreen memory dump file and everything works fine from couple of
> days. I can't reproduce it with above method anymore.
> I used ddrescue to reread everything I could from btrfs (this one file
> used by mentioned VM) and just replaced the file after ddrescue was done=
.
>
> On Friday last week I asked Intel for refund.
>
> I am positively surprised how much pain this btrfs filesystem (RAID10
> for data and metadata) handled over last year. Great job devs, keep it u=
p!
>
> Sincerely,
> e.
>
>


