Return-Path: <linux-btrfs+bounces-19602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011DCB011C
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 14:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B865300A299
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C0322755;
	Tue,  9 Dec 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="VQk+K8JS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6221423C
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287299; cv=none; b=qt/b4B0qOV0Udjt9JNrBH/RvzyHu+CG64g/ivVL2e1wQTV22wPZwMIty5ngYt/lLzdQsuZopmNeidfKQe1h8MAIizWsQY3DmtVdaapTBeHiGGZ5/1u27Ixcb6+rHmUQdXdSTFzwewIVz0KDZBfsgmpKAVss735FiLchCQQjyjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287299; c=relaxed/simple;
	bh=4kqoEZaUu7xiikm6BH0ACEx7flGx/6a2sn820AHi+2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwriWtFoVfPFBpFz6NKjw1Ou0cIRHh3EUOAFqZdQ7dPbTpXG48gp7/MBxKts1MWxttIqw9udTTzsW0UR3GOKUgK/sMcpfhOPmaNCiZxrugFdg5uOOyN+QiefodGqh2BHyJN/lEPYy6c+K/qfcpYiLsBJfNYvPaYlx7WGf2Ad7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=VQk+K8JS; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1765287285;
	bh=E5QNv2AwXKJO1COHgD2tqwL0EMk0jmXq/FwbIrDnShM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VQk+K8JSxNvCfyjFCMZJ8eMqWQc4bV1SnsSGy6kGhOGEZsjZLCOHuoUiWQ8mSYP12
	 rNWzc7GlKV8POupEy1v/9bshHbkCIgatJ0WdcU1GEeHmHwbamB20Q6D2zShGAKBWi9
	 hK/nRSqWVOEUnCVBUGDX59DNzbAmYGdqvEKejcKg=
X-QQ-mid: zesmtpgz7t1765287281tc4504af8
X-QQ-Originating-IP: K4s5aI2P8zvYAPKEWmZ6YLzEw3rpplUqPCO9RDDphs4=
Received: from [198.18.0.1] ( [123.134.104.238])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Dec 2025 21:34:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1734294373353242157
Message-ID: <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
Date: Tue, 9 Dec 2025 21:34:42 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mw3/skGyA4U5yVHcmVv7gZbY1CHiTp0SCJeOtKQtnp00Kz+qTseVkCDB
	oz4Oav05gqUcufrujIIZGfp2bUque2mzwNHsQ2/VudQbdwrRZVt79ulzEmifV0tKmGe+NII
	7C8uoT33wWr1mUT/h7mAsmmyxv70FstCIk4c3jHKvyDKCrb57AWaVTkoMppuadlZOOrpl4m
	X63GB7uPxZyQnSCImnkCGq9eSXkz1eUzmxpRaAaNOW8kNUP7Ytj8KMC5KB9a9aoTx8tguuI
	Xs7c+YXc6SoclXqk9I8suM+w9QmNozju9AsZUs+WxMtHXRlx7cByeBnYc93KVIMVu6SXItd
	dSBbtHtK8utOKnLu+jmPKSbtey5btw5wvMlSDKdq8lQTBs3JoT8ofF0TpdX4PoqHjDiBNII
	6TC+dbbjJWd0mv7gqPS+IWxfMRrA8Kq9Fy1WwkrMT6Exrb/LR/e9xaxbR6/qFhD47S/F3RW
	xhkrJLfZ6y+Gi4i23KFjpckZGZpfICdYqUJJzxGPT3YS9F8HZJGx3lLn5v7kcegf9W6S0UD
	v+Mvy93DtJZyNrZiT0fepcvtu8NdrhX7jRtHmJV2G7KJvF2qCo+o3ubY9LJJrUIaGcB7dzA
	ZD1Inr9g6Q5Mnrf2hLmBmLAEn5DudP92fdboP8kP/72x8ojquMGJVrO9oJm9QBQVaCA5FRG
	4OkX7gKWP1A73d88xZDp9eoRM8fGK7q4aCCBNl9vgTV4p9hFTMI1v841FOWLLC2qMU3goPn
	x8ry6DIiPb6lURzJzLL5GSWmnPSCnZvUbdglc49VjmJx5sinaw/sRnC4u/WzMsYZfEW529t
	CbjoPcU6tEzcr8crRqm5oJQPm94ps8BWjUJql6Smzz4QCyX0CnxE/hXLwo6msoIqmr8uN2I
	hZXFwL2CjnShIgJRbNAe7ROvbB8291j1oiXrLOf7jW0xH2r4LXlBjA/cgQQ+Xhxc8SnMw8M
	H9NxurFwzyWfkYQyrJWBZ6ukfVg00TUfbaZn3CjFJrRuaGQkJNtjmOCQqnn3MUxrKo8EhOR
	3Z6458f87WqZPv4N7JTX+FYZXGfco=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

在 2025/12/1 14:30, Johannes Thumshirn 写道:
> On 11/28/25 4:38 PM, HAN Yuwei wrote:
>> 在 2025/11/28 23:03, Johannes Thumshirn 写道:
>>> On 11/28/25 12:36 PM, HAN Yuwei wrote:
>>>> /dev/sdd, 52156 zones of 268435456 bytes
>>>> [   19.757242] BTRFS info (device sda): host-managed zoned block device
>>>> /dev/sdb, 52156 zones of 268435456 bytes
>>>> [   19.868623] BTRFS info (device sda): zoned mode enabled with zone
>>>> size 268435456
>>>> [   20.940894] BTRFS info (device sdd): zoned mode enabled with zone
>>>> size 268435456
>>>> [   21.101010] r8169 0000:07:00.0 ethob: Link is Up - 1Gbps/Full - flow
>>>> control off
>>>> [   21.128595] BTRFS info (device sdc): zoned mode enabled with zone
>>>> size 268435456
>>>> [   21.436972] BTRFS error (device sda): zoned: write pointer offset
>>>> mismatch of zones in raid1 profile
>>>> [   21.438396] BTRFS error (device sda): zoned: failed to load zone info
>>>> of bg 1496796102656
>>>> [   21.440404] BTRFS error (device sda): failed to read block groups: -5
>>>> [   21.460591] BTRFS error (device sda): open_ctree failed: -5
>>> Hi this means, the write pointers of both zones forming the block-group
>>> 1496796102656 are out of sync.
>>>
>>> For RAID1 I can't really see why there should be a difference tough,
>>> recently only RAID0 and RAID10 code got touched.
>>>
>>> Debugging this might get a bit tricky, but anyways. You can grab the
>>> physical locations of the block-group form the chunk tree via:
>>>
>>> btrfs inspect-internal dump-tree -t chunk /dev/sda |\
>>>
>>>          grep -A 7 -E "CHUNK_ITEM 1496796102656" |\
>>>
>>>          grep "\bstripe\b"
>>>
>>>
>>> Then assuming dev 0 is sda and dev 1 is sdb
>>>
>>> blkzone report -c 1 -o "offset_from_devid 0 / 512" /dev/sda
>>>
>>> blkzone report -c 1 -o "offset_from_devid 1 / 512" /dev/sdb
>>>
>>>
>>> E.g. (on my system):
>>>
>>> root@virtme-ng:/# btrfs inspect-internal dump-tree -t chunk /dev/vda |\
>>>
>>>                                          grep -A7 -E "CHUNK_ITEM
>>> 2147483648" | \
>>>
>>>                                         grep "\bstripe\b"
>>>                 stripe 0 devid 1 offset 2147483648
>>>                 stripe 1 devid 2 offset 1073741824
>>>
>>> root@virtme-ng:/# blkzone report -c 1 -o $((2147483648 / 512)) /dev/vda
>>>       start: 0x000400000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>>
>>> root@virtme-ng:/# blkzone report -c 1 -o $((1073741824 / 512)) /dev/vdb
>>>       start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>>
>>> Note this is an empty FS, so the write pointers are at 0.
>>>
>> # btrfs inspect-internal dump-tree -t chunk /dev/sda|\
>> grep -A 7 -E "CHUNK_ITEM 1496796102656"|\
>> grep stripe
>>
>> length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
>> num_stripes 2 sub_stripes 1
>>        stripe 0 devid 2 offset 374467461120
>>        stripe 1 devid 1 offset 1342177280
>> # blkzone report -c 1 -o "731381760" /dev/sda
>>      start: 0x02b980000, len 0x080000, cap 0x080000, wptr 0x07ff80 reset:0
>> non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
>> # blkzone report -c 1 -o "2621440" /dev/sdb
>>      start: 0x000280000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>> non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
>>
> Commit c0d90a79e8e6 ("btrfs: zoned: fix alloc_offset calculation for
> partly conventional block groups") should fix the problem described
> there. Not sure (yet) why it doesn't.
> 
> 
Any update on this? Should I keep states of disks or I can mkfs a new 
volume?

HAN Yuwei


