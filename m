Return-Path: <linux-btrfs+bounces-2103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04544849811
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 11:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FF41C21143
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1C175A6;
	Mon,  5 Feb 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="CHV3mXm1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82217586
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130226; cv=none; b=FmZf03zw3yNZb3kmiY8yhqlFuKAw4g0gVh94uecgxn4P4Wc0FzcUng3jP3JkgMt7fQweREOJzfXXAA2EOxK3D4lBf7I724lWSsz5l9woF92IV7H1axX7joTMjbHx94GNxmMgr71YZAj4GMcsrTdkiOxqcl0dnKjiKyt+5bUfSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130226; c=relaxed/simple;
	bh=5SPuJ3AiscUr1PWvjDItQh4hVkFW91Laos9s54kB80Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGg4NH1dDXkHsPiplZSumQZsTN0PMnxTdZiqVBB0RNcQQBhQa8cYbBCSZFq++944XmukqQDWe/67w7TXHjH6mag/fs6fqcKGyCGINvgIMp4+ITNe9YodPfkrI3YXPTjhyHQN7tjh+8DGkU319Nn6T+ietQRSIDmTn2rFGTxGy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=CHV3mXm1; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1707130216;
	bh=C3CXuL1eAlVrot9tuonvIVUqrv4XZebnof8sDq+JGVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CHV3mXm1ScdFuDNoXmalCbQarH8nDl1caKjalSZzWpS7spk5q+d69xF47HxAoakwU
	 tIfD/v3TdJTLsFko8d5qqt7igHtjxEKymPhkTjifS3haTIZlY2TRxQ4y3tqn4+nwGO
	 cX1W/lGs6t31y1VlOz4Xbi8PJtFt13eb/XXOu4pw=
X-QQ-mid: bizesmtpipv603t1707130214tqll
X-QQ-Originating-IP: k+56v8SvnV3mDJhA+NQwQupDbY3qfEj3Xg2NdAxkcRE=
Received: from [IPV6:240e:381:70b1:9300:6009:d ( [255.217.104.8])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 05 Feb 2024 18:50:13 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: uGhnJwy6xZKVVpIimPzEkf8+RAakQmxoU5uONId97viArO7j9urS+vqKVVZrV
	xT15uqHCNQIMolEDPsDzBTGqPQq0tRHFgkQdcds6XVi0c6laIjwCag+z8Pl+bssB+oswEF2
	vh73a3zd7BO+rEgbLhxo5tJyejg2ZGlesZl4SZwaqoNWJyj7kt4BTm8QMdpGoWgHzl0rTSn
	bKwAuC8Xf1RD7yy8HTTBrkBbM8v3QMGFqILpCqzc00nEHoij0kH53QWqinfajl0gysNwQ+o
	+vSMSomccQHA+5v4WnXNOCYD7HeCZ8FzZBzc13a5xoCZVym9e5eB2coIiDOzch7dCC1BrLa
	kNi2kKwZGSm2KiweofFJUDzQYiI43oQmOGMKxfne8uIbLnO8CH/hR57TfmecQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3334075539312878658
Message-ID: <ED3C933B1371DD79+bdc357d3-3efb-49f4-9b54-8cb0ab9350d1@bupt.moe>
Date: Mon, 5 Feb 2024 18:50:13 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
In-Reply-To: <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1


在 2024/2/5 15:56, Qu Wenruo 写道:
>
>
> On 2024/2/5 17:16, 韩于惟 wrote:
>>  > Any clue how can I purchase such disks?
>>  > And what's the interface? (NVME? SATA? U2?)
>>
>> I purchased these on used market app called Xianyu(闲鱼) which may be
>> difficult for users
>> outside China mainland. And its supply is extremely unstable.
>>
>> Its interface is SATA. Mine model is HSH721414ALN6M0. Spec link:
>> https://documents.westerndigital.com/content/dam/doc-library/en_us/assets/public/western-digital/product/data-center-drives/ultrastar-dc-hc600-series/data-sheet-ultrastar-dc-hc620.pdf 
>>
>>
>>  > And have you tried emulated zoned device (no matter if it's qemu 
>> zoned
>>  > emulation or nbd or whatever) with 4K sectorsize?
>>
>> Have tried on my loongson with this script from
>> https://github.com/Rongronggg9
>>
>>  > ./nullb setup
>>  > ./nullb create -s 4096 -z 256
>>  > ./nullb create -s 4096 -z 256
>>  > ./nullb ls
>>  > mkfs.btrfs -s 16k /dev/nullb0
>>  > mount /dev/nullb0 /mnt/tmp
>>  > btrfs device add /dev/nullb1 /mnt/tmp
>>  > btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt/tmp
>
> Just want to be sure, for your case, you're doing the same mkfs (4K
> sectorsize) on the physical disk, then add a new disk, and finally
> balanced the fs?
>
No. I didn't specified sector size in first place, just "mkfs.btrfs 
$dev" on default loongarchlinux (kernel 6.7.0). And it succeed with add 
device & balance. Then I successfully write & read some small files. It 
oops when I started using transmission to download something and 
executed "sync".
> IIRC the balance itself should not succeed, no matter if it's emulated
> or real disks, as data RAID1 requires zoned RST support.
>
> If that's the case, it looks like some checks got bypassed, and one copy
> of the raid1 bbio doesn't get its content setup properly thus leading to
> the NULL pointer dereference.
>
> Anyway, I'll try to reproduce it next week locally, or I'll ask for the
> access to your loonson system soon.
>
> Thanks,
> Qu
>>
>> Whether it is 4k or 16k, kernel will have "zoned: data raid1 needs
>> raid-stripe-tree"
>>
>>  > If you can provide some help, it would super great.
>>
>> Sure. I can provide access to my loongson w/ dual HC620 if you wish. You
>> can contact me on t.me/hanyuwei70.
>>
>>  > can you provide the faddr2line output for
>>  > "btrfs_finish_ordered_extent+0x24"?
>>
>> I have recompiled kernel to add DEBUG_INFO. Here's result.
>>
>> [hyw@loong3a6 linux-6.7.2]$ ./scripts/faddr2line fs/btrfs/btrfs.ko
>> btrfs_finish_ordered_extent+0x24
>> btrfs_finish_ordered_extent+0x24/0xc0:
>> spinlock_check at
>> /home/hyw/kernel_build/linux-6.7.2/./include/linux/spinlock.h:326
>> (inlined by) btrfs_finish_ordered_extent at
>> /home/hyw/kernel_build/linux-6.7.2/fs/btrfs/ordered-data.c:381
>>
>> 在 2024/2/5 13:22, Qu Wenruo 写道:
>>>
>>>
>>> On 2024/2/4 20:04, 韩于惟 wrote:
>>>>  > ie. mkfs.btrfs --sectorsize 16k. it works! I can sync without any
>>>> problem now. I will continue to monitor if any issues occurred. seems
>>>> like I can only use these disks on my loongson machine for a while.
>>>
>>> Any clue how can I purchase such disks?
>>> And what's the interface? (NVME? SATA? U2?)
>>>
>>> I can go try qemu zoned nvme on my aarch64 host, but so far the SoC is
>>> offline (won't be online until this weekend).
>>>
>>> And have you tried emulated zoned device (no matter if it's qemu zoned
>>> emulation or nbd or whatever) with 4K sectorsize?
>>>
>>>
>>> So far we don't have good enough coverage with zoned on subpage, I have
>>> the physical hardware of aarch64 (and VMs with different page size), 
>>> but
>>> I don't have any zoned devices.
>>>
>>> If you can provide some help, it would super great.
>>>
>>>>
>>>> Is there any progress or proposed patch for subpage layer fix?
>>>>
>>>> 在 2024/2/4 6:15, David Sterba 写道:
>>>>> On Sat, Feb 03, 2024 at 06:18:09PM +0800, 韩于惟 wrote:
>>>>>> When mkfs, I intentionally used "-s 4k" for better compatibility.
>>>>>> And /sys/fs/btrfs/features/supported_sectorsizes is 4096 16384, 
>>>>>> which
>>>>>> should be ok.
>>>>>>
>>>>>> btrfs-progs is 6.6.2-1, is this related?
>>>>> No, this is something in kernel. You could test if same page and 
>>>>> sector
>>>>> size works, ie. mkfs.btrfs --sectorsize 16k. This avoids using the
>>>>> subpage layer that transalates the 4k sectors <-> 16k pages. This has
>>>>> the known interoperability issues with different page and sector 
>>>>> sizes
>>>>> but if it does not affect you, you can use it.
>>>>>
>>>
>>> Another thing is, I don't know how the loongson kernel dump works, but
>>> can you provide the faddr2line output for
>>> "btrfs_finish_ordered_extent+0x24"?
>>>
>>> It looks like ordered->inode is not properly initialized but I'm not
>>> 100% sure.
>>>
>>> Thanks,
>>> Qu
>>>
>


