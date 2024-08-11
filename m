Return-Path: <linux-btrfs+bounces-7095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8594E043
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 08:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D4C1C20F50
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 06:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5988E1BC58;
	Sun, 11 Aug 2024 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="SDRdUQ1Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A70199A2
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723357175; cv=none; b=sC+C6xtM1B8Q81QAxlkMQ/y0Cj3wfgeGDVUOlzZaf2bAl+ZvPZOuamVK19xJoNRUFkj/eQHDsmGNKAUTousQSuV/o0CgXHnNdwuH7rzn2JC+10BOEi8eDcDAQ/L6eY+kc8dbv7I9pe31cpKDgkho99YvWe5EUOOY8Rw4W98IeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723357175; c=relaxed/simple;
	bh=jf9e3l265jzihr/FEjbPTpelrqr0T+IcIHiBdPfU3iI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mkXdB6ZPYlQapb4HHLeLlK1tbbSPwRl313NcQ61Utm/QEMALwvybiqyMy6/bl4zxmagCD7cjEaYyOB8cLOmMI/PHtREfVlf2EStQBsEH2igUABeJTj9X+RpdwBr31P85AMhLyWlKutZWtATsstYqZIVqWEs3Gmivb4J6zO+X/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=SDRdUQ1Y; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1723357165;
	bh=AR3N48Q+liLllrREPsuiQrLobSRP/2cKWnQf6fF7ytI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=SDRdUQ1YAW6R1Kc7721dYvnXCHH07lySqiGT8Vi5w4ajk4ahxuWSEheIr/ckZ25yk
	 g0on7MKpdmdJI3HExF06Zi8i7i46o1KJ25Pib5p6iyZyE0CpJXwqKZneaFR+9jKltE
	 +CpMP+B0NiT/pbS2yjFrZof8LbPubdiGWMEnQmls=
X-QQ-mid: bizesmtpip3t1723357163tc99069
X-QQ-Originating-IP: 8NulOyAhP8YPh6nHSJOPEe4V/BTWR4ImdWzuODBatOE=
Received: from [IPV6:2409:8a3c:593d:ae0:6c80:c ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 11 Aug 2024 14:19:21 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000B00A0000000
X-QQ-FEAT: MvcY5ctQrZ/pXS8MO0KQVtacG4oCKmVPdseCAMWMrowep3ALro8gmqSJkXPbJ
	9Qq36W6EAtYt/m7TAhDCwrhtrjpJgQBuVVgyjwHifUYeMe06KwKF+A1GM/MIXrgHcDorK5G
	LBiGCu8vowsTHKgkzBoULvuWlKp/0GE8/dJTQxDFKq+9zpQJC18+NG1YxD98hcb8EMLUlc6
	oM0RSEGrmXNL5JRJeiSS5Cx8U63YRBPFHi45Md8hzfRKR5f7DRdVESlim1Fh05+X6bC7jk3
	LnVRz4Y12nNygqkmz42Buq4gcGKXXGnN/HuwZVY77t6r5RwFn5tdRCoD0pzoEweLLqiZ/fe
	RzH2cbTljVpwZaqXRmoaQkYkYbAnQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5491448471044600138
Message-ID: <A2D90FFDBFD321D8+60667f8e-7f2b-4940-beee-d3510a5a560b@bupt.moe>
Date: Sun, 11 Aug 2024 14:19:21 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
From: Yuwei Han <hrx@bupt.moe>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
 <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
 <2112398B543F8373+1a8c3746-b3f1-436a-97b1-debe2682cbf1@bupt.moe>
 <pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnkeig2ky@wfxoqxp6rvt7>
 <B15555845F2CCB38+2636f283-c234-44b4-9044-4f25650023f0@bupt.moe>
Content-Language: en-US
In-Reply-To: <B15555845F2CCB38+2636f283-c234-44b4-9044-4f25650023f0@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

Hello? My loongson is back online.
Kindly reminder here. I am still keeping drive state.

HAN Yuwei.

在 2024/6/11 14:48, HAN Yuwei 写道:
> 
> 在 2024/6/10 22:13, Naohiro Aota 写道:
>> On Mon, Jun 10, 2024 at 08:47:37PM GMT, HAN Yuwei wrote:
>>> 在 2024/6/10 16:53, Johannes Thumshirn 写道:
>>>> On 09.06.24 04:24, HAN Yuwei wrote:
>>>>> I can't mount volume on multiple zoned device which data profile is
>>>>> single & metadata profile is raid1.
>>>>> It experienced multiple forced shutdown due to kernel 6.10 can't
>>>>> properly shutdown on loongarch.
>>>>>
>>>>> # dmesg
>>>>>
>>>>> [ 1963.698793] BTRFS info (device sdb): first mount of filesystem
>>>>> b5b2d7d9-9f27-4907-a558-77e8e86df933
>>>>> [ 1963.707801] BTRFS info (device sdb): using crc32c (crc32c-generic)
>>>>> checksum algorithm
>>>>> [ 1963.715597] BTRFS info (device sdb): using free-space-tree
>>>>> [ 1965.492066] BTRFS info (device sdb): host-managed zoned block 
>>>>> device
>>>>> /dev/sdb, 52156 zones of 268435456 bytes
>>>>> [ 1966.953590] BTRFS info (device sdb): host-managed zoned block 
>>>>> device
>>>>> /dev/sdc, 52156 zones of 268435456 bytes
>>>>> [ 1967.346758] BTRFS info (device sdb): zoned mode enabled with zone
>>>>> size 268435456
>>>>> [ 2026.287356] BTRFS error (device sdb): zoned: write pointer offset
>>>>> mismatch of zones in raid1 profile
>>>>> [ 2026.296445] BTRFS error (device sdb): zoned: failed to load zone 
>>>>> info
>>>>> of bg 5399847632896
>>>>> [ 2026.304576] BTRFS error (device sdb): failed to read block 
>>>>> groups: -5
>>>>> [ 2026.352547] BTRFS error (device sdb): open_ctree failed
>>>>>
>>>> Can you check the write pointers for the zones mapping to this block 
>>>> group?
>>>>
>>>> that should be
>>>> blkzone report -c 1 -o 0x274A00000 /dev/sdb
>>> # blkzone report -c 1 -o 0x274A00000 /dev/sdb
>>> start: 0x274a00000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>> # blkzone report -c 1 -o 0x274A00000 /dev/sdc
>>> start: 0x274a00000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>> blkzone takes a physical offset in sector unit (512 bytes). According to
>> the dump-tree output below, the BG 5399847632896 is at "1819455520768" on
>> /dev/sdb and "1819723956224". So, "blkzone report -o" should take
>> "0xd3d00000" and "0xd3d80000".
> # blkzone report -o 0xd3d00000 -c 1 /dev/sda
> 
>    start: 0x0d3d00000, len 0x080000, cap 0x080000, wptr 0x04f0e0 reset:0 
> non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> # blkzone report -o 0xd3d80000 -c 1 /dev/sda
>    start: 0x0d3d80000, len 0x080000, cap 0x080000, wptr 0x080000 reset:0 
> non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> FYI: my loongson device is in RMA. So I am using D2000 (arm64 w/ 4k 
> pages) for reading. can't try any mount for now but can do 
> inspect-internal.
> 
>> Thanks,
>>
>>> FYI,
>>> # btrfs inspect-internal dump-tree /dev/sdb|grep -A 10 -B 10 
>>> 5399847632896
>>>                  io_align 65536 io_width 65536 sector_size 16384
>>>                  num_stripes 1 sub_stripes 1
>>>                          stripe 0 devid 1 offset 1819187085312
>>>                          dev_uuid 754f2932-38e5-46b4-93d2-dd699076879e
>>>          item 104 key (FIRST_CHUNK_TREE CHUNK_ITEM 5399579197440) 
>>> itemoff
>>> 7851 itemsize 80
>>>                  length 268435456 owner 2 stripe_len 65536 type 
>>> DATA|single
>>>                  io_align 65536 io_width 65536 sector_size 16384
>>>                  num_stripes 1 sub_stripes 1
>>>                          stripe 0 devid 2 offset 1819455520768
>>>                          dev_uuid ee669b85-f641-4d6a-9a66-da13907d55b2
>>>          item 105 key (FIRST_CHUNK_TREE CHUNK_ITEM 5399847632896) 
>>> itemoff
>>> 7739 itemsize 112
>>>                  length 268435456 owner 2 stripe_len 65536 type
>>> METADATA|RAID1
>>>                  io_align 65536 io_width 65536 sector_size 16384
>>>                  num_stripes 2 sub_stripes 1
>>>                          stripe 0 devid 1 offset 1819455520768
>>>                          dev_uuid 754f2932-38e5-46b4-93d2-dd699076879e
>>>                          stripe 1 devid 2 offset 1819723956224
>>>                          dev_uuid ee669b85-f641-4d6a-9a66-da13907d55b2
>>>          item 106 key (FIRST_CHUNK_TREE CHUNK_ITEM 5400116068352) 
>>> itemoff
>>> 7659 itemsize 80
>>>                  length 268435456 owner 2 stripe_len 65536 type 
>>> DATA|single
>>>                  io_align 65536 io_width 65536 sector_size 16384
>>>
>>>> and for the other device as well
>>>>
>>>> Thanks,
>>>>     Johannes
>>


