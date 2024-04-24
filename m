Return-Path: <linux-btrfs+bounces-4539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B758B13D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 21:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0961F24455
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ADA13B5BD;
	Wed, 24 Apr 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="FikhAC0o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBD1848
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988631; cv=none; b=HIJ2cS8haO12DDsu1203VFmxzA0W1eaVLl2SQOBp2MmdvqdhY7ERkTTp2Gt/m5VWrNz8Lb/+QuRreBDdCFdeaAGxz4yNqicEzw9r3DdsIjxNXTXBG407M/fcpj0z9DncP66MA5DpVv8RvufKt0D7+OfXerJhohZnZMBuLHI7jJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988631; c=relaxed/simple;
	bh=XJhzUmdUc8aZVxoGjJEN2f9lhXN1CWwCsXddfNLYKsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhUZLXi1iTr15W6QGXSqW/OtXuR4aBkcTusawfJ2DrVlqScF3ObrynkdbDHPhGIERUDCXK9n2Z9edIl7avI8ogyCZ+UoqO7cA1T2bY/kJF4QBspOQBAgJNwWNanDaYcsDC2IT2DH715/A9sKfAkz31cW1fC7qnD7/QCbYT8bLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=FikhAC0o; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id zijqrgVFKzTQvzijqrmJkf; Wed, 24 Apr 2024 21:57:06 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1713988626; bh=zwRyENk0hJGExkxnwz/+H/UlgDZd1OtiApu4FhD4dDU=;
	h=From;
	b=FikhAC0oLdYInNA7kFlbda2Qgy/+RWDv3sqBq9CVxUHvnQsUn9bOPXlPE5pCPEIGw
	 jQA1slKIOyxmBa/GZ+dF65dwnyKxJWKRQe/DNz32tSCOPmQy5wl+78zfCV7k+waHC2
	 Lnm37IZuq0Hcaxsz9TDdUJYk+La33VW4tW5amuA4zkVKUtpOrIi7J6KS7+4ahHitxw
	 9XFYBlM49NZn8WtXy5+YOBpyOHja8XxqTXKVCMPG1arLooBsN2oz/ETMqvdEVs/UD0
	 hq+rQ5rQm2+nU3aVzR3tmXb4EaN7DDvRt3VbVm/EfSORW5cCs/SszYmmQS1dALK0EK
	 MvhhUSoRJ23gw==
X-CNFS-Analysis: v=2.4 cv=PJXE+uqC c=1 sm=1 tr=0 ts=66296412 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=0nxTnedaYWcc5OCY_AQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <04a4bfa7-9596-424d-afb0-c9ab9458f969@libero.it>
Date: Wed, 24 Apr 2024 21:57:06 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: mkfs.btrfs enabled RST by default casuing unable to mount on
 stable kernel
To: HAN Yuwei <hrx@bupt.moe>, dsterba@suse.cz
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
 <20240424094818.GJ3492@twin.jikos.cz>
 <CC278E560522C9D1+f2ceab96-c158-49b9-b885-7ae55fa260ff@bupt.moe>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <CC278E560522C9D1+f2ceab96-c158-49b9-b885-7ae55fa260ff@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMPT3+SEZsOFCVYRtGpmZZGSCBqd8zD/0X+XEuDO/OplVSIj4VuYo3qml2KpODQ984k67Pohb0Wl0E5DeSECYjDFAl3DuxaGQcIjwqzjjwvWVxEJIabZ
 sH/RMRhu+8WMQyC/OFzlf24wvCnYyBBrdDOF+MUyU4hT7mn3ZnzYymCg9dfM5A0c9oIgj3ahMNWn6VuP8lKYDgeKpRhXVYYxPDi7pWWGLTUJDVPaA0NoJX8e
 YkxKIqswzS5S/+3apDMYzA==

On 24/04/2024 18.15, HAN Yuwei wrote:
> 
> 在 2024/4/24 17:48, David Sterba 写道:
>> On Wed, Apr 24, 2024 at 01:45:24PM +0800, HAN Yuwei wrote:
>>> I have found incompatibility issue on btrfs-prog & kernel. btrfs-progs
>>> is v6.7.1, kernel is 6.7.5-aosc-main.
>>>
>>> Using this command to create btrfs volume:
>>> # mkfs.btrfs -f -d raid10 -m raid1c4 -s 16k -L HYWDATA_ZONED_TEST
>>> /dev/sdb /dev/sdc /dev/sdd /dev/sde
>>>
>>> When mounting, dmesg said:
>>> [  329.071403] BTRFS info (device sdb): first mount of filesystem
>>> 7b4f2ca6-efe3-48d9-81f6-ba65a00db85e
>>> [  329.080422] BTRFS info (device sdb): using crc32c (crc32c-generic)
>>> checksum algorithm
>>> [  329.088222] BTRFS info (device sdb): using free space tree
>>> [  329.093673] BTRFS error (device sdb): cannot mount because of unknown
>>> incompat features (0x5b41)
>>> [  329.102442] BTRFS error (device sdb): open_ctree failed
>>>
>>> dump-super said:
>>> [...]
>>> incompat_flags          0x5b41
>>>                           ( MIXED_BACKREF |
>>>                             EXTENDED_IREF |
>>>                             SKINNY_METADATA |
>>>                             NO_HOLES |
>>>                             RAID1C34 |
>>>                             ZONED |
>>>                             RAID_STRIPE_TREE )
>>> [...]
>>>
>>>
>>> RAID_STRIPE_TREE need CONFIG_BTRFS_DEBUG to be supported and this
>>> feature flag is disabled on most distributions. I hope RST can be
>>> disabled by default on btrfs-progs.
>> IMO this works as intended. Features may be enabled ahead of time in
>> btrfs-progs due to early testing and not requiring the experimental
>> build. The experimental status of progs features is about completeness
>> of the implementation, so if mkfs creates a filesystem with RST then it
>> could be enabled.
> If due to early testing, btrfs-progs could have --experimental option to enable it instead of
> 
> enabling it by default which would causing confusion to normal users. For experienced user who wants to test new feature, we can hint them to use this option when needed.
> 
> e.g.
> 
> # mkfs.btrfs -f -d raid10 -m raid1c4 -s 16k
> can't use raid10, this is a experimental feature, use --experimental if you really want it.
> 
> # mkfs.btrfs -f -d raid10 -m raid1c4 -s 16k --experimental
> 
> [succeed]
> 
>> The kernel support is still missing some features and there are some
>> known bugs, this is conveniently hidden behind the DEBUG option so it
>> does not affect distributions.
>>
>> However it seems that the documentation is not clear about that and the
>> status page should be updated.
>>

I think that the problem is the following: if you want to use a "zoned device"
and a "raid device", you NEED a raid-stripe-tree.
In fact by default the RST is not enabled, but it is pulled if we have
a zoned device and a raid10.

So it is not a problem of btrfs-progs itself.

I think that btrfs.mkfs should be more verbose about pulling incomapt
feature as a dependency.


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


