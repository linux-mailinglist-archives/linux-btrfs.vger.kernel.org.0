Return-Path: <linux-btrfs+bounces-20189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4369CFD934
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 13:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9EC30329F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4A309F08;
	Wed,  7 Jan 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="a1kHcmUU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251530BF6A
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787669; cv=none; b=DzT0oqTOEF8Ryhqpj4GQMyJJy/tTjEZMpcLCpFRt6EpD7sH5Bckwbacsk+c7rm9RJz7ilM4Ay9XDHof/F5Kjv8sbDpr5N0vzyn3sEYjLf8nsER+MwUOa2/VaGQtEhroXSNtId4750+UOmT5cpBK2jgX8etUimYyu1qHMHQoipUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787669; c=relaxed/simple;
	bh=JFtvitJTjEMTR6deTlwugDRs+CJ74C5TjiVpTkos6Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQp10lALn8CIFE3C7BAsx2pz8tZeGAgPQ3hJUbPsIGEd44vGjSnSW3Y884vQR7Q+d3q1rNiCGQkmi2ToPZYv5FXJ/YLZ61xTYk7wV7Qrg5IoNnPQhdpDi6sGeP2ogCtcK0+R+AOqVItEj8D1BmYDRj35S+ikmgby0yyCmSUTFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=a1kHcmUU; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1767787654;
	bh=U2/hJZJgPR/GEz1Gyehvxr9YekzARj9Wvbdizt29n9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=a1kHcmUUjJl7f/UzjZiSgYEfEZTEQGOyZ0nvd0lVW7xfXa+R65NfhJ1FkqmUQa4HP
	 N38pyULW1vMIItJn70jNbz4ioJpxJIucOUlejNjxdmoWNlwu1J2DSM7DV6RdO4zujY
	 ukoUKCATK5a4XY4j04PIxw5DJD51ZUpF/c3QUP4g=
X-QQ-mid: esmtpsz10t1767787649t6264873b
X-QQ-Originating-IP: 0/o1HRJc0VD1xhjNj1gRClaJnjPoMuWhC13w1G9c7fw=
Received: from [198.18.0.1] ( [123.134.104.59])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 07 Jan 2026 20:07:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14820184673806875049
Message-ID: <D61E098DC9397C2B+268b627b-a7c7-45e6-b388-c05dec782bb1@bupt.moe>
Date: Wed, 7 Jan 2026 20:07:31 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
To: Naohiro Aota <Naohiro.Aota@wdc.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
 <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
 <99066be8-992b-4476-9a22-8c1ff6f5cff2@wdc.com>
 <36718DD03AD165EF+c4b42ca9-02f2-41e9-9c43-1ff360a6e73e@bupt.moe>
 <DFH8LGFH8LD8.39G3E2X9L5318@wdc.com>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <DFH8LGFH8LD8.39G3E2X9L5318@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MwQdfXoP8nuzodriOzYzIUgnG8u2xV3LwPzXTsn14+IA5EH95ym34EW9
	ruX47a6gUPcux0OrEc2EBv6m02aVy6A4713CDvzWJSrShq5Q63W4IERy6CbkzbMrCp55tSz
	87brzd8V+ROF19qyOOA4NZ0bQfbwFzc0DKj0BAFzeYFc+xhQDp+YqVGffvZ5wwPaE28Y0Tx
	L5QcLNYqo+TrpNNcwVoJD0OSI7L+esrrqTGws7hyeQPzzV2ycZ7mx/pJrSosF6IcILy69Gr
	06Roib58e8mZjDK82ANH5KOLD6ijtAop0re8weT+Jq9qRN9MEHV0xwl3xYDef2m076EcaAV
	CM3ZX5Z9QoxWfEz78OUR1GnZJqGNmGtXtkZslxe7ck79opOE1eCO3W0+yze1kGOsv6QS37U
	M031erN+Xae/p7g18+53p2R5lS7ScA/cXEeKBNvhyIo6aeZ6sOSuDQoYYKkL4X0jzqy5YhG
	aVVY8Y7a6gyr784T5laZa5JA624IeCSdB/NbVsRU1mmA4ZH4qA6y06/qFp8wivRpYAV2TWJ
	HHKbUsAYF/nhLgCJFDvvnukjrL9QCg/HWj9545HXOuCB0UiUDtW7TZJhlFbbEx4qtnNqs4S
	1k1znUfjiVAYKE8m27X6iX5VIvL1KzElUqkvekh/On+F6loVTnv8N6On2NrOsg3imSWGG9h
	TMNn5PJK6Oi7P+sR4S5MkzTSC3Yk6oMImV+16z4BtRkD2eWzeysGO3UKdvh4Dau6AfW0UEA
	SYtyFG0T2zo/8vgiVGywr8ewNqzCPjZT1ohBZt9lV2r6ByoqLNv0LYT+aCXfqml9Z5+gzJm
	aHRQvDbN/1KweioUMQCncKMOA/hhgLc3KVa4tYXUpuM5lso1t+fJAJBSogTrAoZ0PkCcm2Q
	soC2JRyVmt4h0XDuxZr3pBX+KqqYjXJdMXD/kF20Cm/9uVtcZVKFkIKLkvhxTq7qubRUHur
	rPO/OHM9hQ8Mm6FrnfLQAtj1IYic8ERROUR/Q8o/xXrWmHBAy7AdEGPH02g6b2WGiLrE=
X-QQ-XMRINFO: Nq+8W0+stu50PCPapzNDjy5KGwDEocjVqw==
X-QQ-RECHKSPAM: 0

在 2026/1/6 12:55, Naohiro Aota 写道:
> On Fri Dec 26, 2025 at 11:18 AM JST, HAN Yuwei wrote:
>> 在 2025/12/10 10:35, Johannes Thumshirn 写道:
>>> On 12/9/25 2:35 PM, HAN Yuwei wrote:
>>>> 在 2025/12/1 14:30, Johannes Thumshirn 写道:
>>>>> On 11/28/25 4:38 PM, HAN Yuwei wrote:
>>>>>> 在 2025/11/28 23:03, Johannes Thumshirn 写道:
>>>>>>> On 11/28/25 12:36 PM, HAN Yuwei wrote:
>>>>>>>> /dev/sdd, 52156 zones of 268435456 bytes
>>>>>>>> [   19.757242] BTRFS info (device sda): host-managed zoned block device
>>>>>>>> /dev/sdb, 52156 zones of 268435456 bytes
>>>>>>>> [   19.868623] BTRFS info (device sda): zoned mode enabled with zone
>>>>>>>> size 268435456
>>>>>>>> [   20.940894] BTRFS info (device sdd): zoned mode enabled with zone
>>>>>>>> size 268435456
>>>>>>>> [   21.101010] r8169 0000:07:00.0 ethob: Link is Up - 1Gbps/Full - flow
>>>>>>>> control off
>>>>>>>> [   21.128595] BTRFS info (device sdc): zoned mode enabled with zone
>>>>>>>> size 268435456
>>>>>>>> [   21.436972] BTRFS error (device sda): zoned: write pointer offset
>>>>>>>> mismatch of zones in raid1 profile
>>>>>>>> [   21.438396] BTRFS error (device sda): zoned: failed to load zone info
>>>>>>>> of bg 1496796102656
>>>>>>>> [   21.440404] BTRFS error (device sda): failed to read block groups: -5
>>>>>>>> [   21.460591] BTRFS error (device sda): open_ctree failed: -5
>>>>>>> Hi this means, the write pointers of both zones forming the block-group
>>>>>>> 1496796102656 are out of sync.
>>>>>>>
>>>>>>> For RAID1 I can't really see why there should be a difference tough,
>>>>>>> recently only RAID0 and RAID10 code got touched.
>>>>>>>
>>>>>>> Debugging this might get a bit tricky, but anyways. You can grab the
>>>>>>> physical locations of the block-group form the chunk tree via:
>>>>>>>
>>>>>>> btrfs inspect-internal dump-tree -t chunk /dev/sda |\
>>>>>>>
>>>>>>>             grep -A 7 -E "CHUNK_ITEM 1496796102656" |\
>>>>>>>
>>>>>>>             grep "\bstripe\b"
>>>>>>>
>>>>>>>
>>>>>>> Then assuming dev 0 is sda and dev 1 is sdb
>>>>>>>
>>>>>>> blkzone report -c 1 -o "offset_from_devid 0 / 512" /dev/sda
>>>>>>>
>>>>>>> blkzone report -c 1 -o "offset_from_devid 1 / 512" /dev/sdb
>>>>>>>
>>>>>>>
>>>>>>> E.g. (on my system):
>>>>>>>
>>>>>>> root@virtme-ng:/# btrfs inspect-internal dump-tree -t chunk /dev/vda |\
>>>>>>>
>>>>>>>                                             grep -A7 -E "CHUNK_ITEM
>>>>>>> 2147483648" | \
>>>>>>>
>>>>>>>                                            grep "\bstripe\b"
>>>>>>>                    stripe 0 devid 1 offset 2147483648
>>>>>>>                    stripe 1 devid 2 offset 1073741824
>>>>>>>
>>>>>>> root@virtme-ng:/# blkzone report -c 1 -o $((2147483648 / 512)) /dev/vda
>>>>>>>          start: 0x000400000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>>>>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>>>>>>
>>>>>>> root@virtme-ng:/# blkzone report -c 1 -o $((1073741824 / 512)) /dev/vdb
>>>>>>>          start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>>>>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>>>>>>
>>>>>>> Note this is an empty FS, so the write pointers are at 0.
>>>>>>>
>>>>>> # btrfs inspect-internal dump-tree -t chunk /dev/sda|\
>>>>>> grep -A 7 -E "CHUNK_ITEM 1496796102656"|\
>>>>>> grep stripe
>>>>>>
>>>>>> length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
>>>>>> num_stripes 2 sub_stripes 1
>>>>>>           stripe 0 devid 2 offset 374467461120
>>>>>>           stripe 1 devid 1 offset 1342177280
>>>>>> # blkzone report -c 1 -o "731381760" /dev/sda
>>>>>>         start: 0x02b980000, len 0x080000, cap 0x080000, wptr 0x07ff80 reset:0
>>>>>> non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
>>>>>> # blkzone report -c 1 -o "2621440" /dev/sdb
>>>>>>         start: 0x000280000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>>>>> non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
>>>>>>
>>>>> Commit c0d90a79e8e6 ("btrfs: zoned: fix alloc_offset calculation for
>>>>> partly conventional block groups") should fix the problem described
>>>>> there. Not sure (yet) why it doesn't.
>>>>>
>>>>>
>>>> Any update on this? Should I keep states of disks or I can mkfs a new
>>>> volume?
>>> Naohiro has a fix candidate for it. Naohiro any updates on it?
>> Raising this. Hopefully it will have a fix or just make a new volume.
> 
> Hi,
> 
> Could you try this patch, please?
> 
> https://lore.kernel.org/linux-btrfs/20251217111404.670866-1-naohiro.aota@wdc.com/

have tried, normally boot and mounted, but after a while dmesg error:


[    0.000000] Linux version 6.19.0-rc4-btrfs-test-dirty 
(root@ninesheep) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU Binutils) 
2.45.1) #15 SMP PREEMPT_DYNAMIC Wed Jan  7 19:34:40 CST 2026
[    0.000000] Command line: initrd=\amd-ucode.img 
initrd=\initramfs-linux-btrfs-test.img root=LABEL=NS_ROOT_EXT4 rw 
add_efi_memmap
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009bff000-0x0000000009ffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20afff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20b000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x000000003cc0cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000003cc0d000-0x000000003cc0dfff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000003cc0e000-0x000000003e13cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000003e13d000-0x000000003e13dfff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000003e13e000-0x00000000bb5abfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb5ac000-0x00000000bccbdfff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bccbe000-0x00000000bcd03fff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bcd04000-0x00000000bd3b1fff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bd3b2000-0x00000000be1fefff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000be1ff000-0x00000000beffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf000000-0x00000000bfffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd100000-0x00000000fd1fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003beffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000003bf000000-0x000000043effffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000043f340000-0x000000043fffffff] 
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI=0xbd39b000 ACPI 2.0=0xbd39b014 
TPMFinalLog=0xbd365000 SMBIOS=0xbe026000 SMBIOS 3.0=0xbe025000 
MEMATTR=0xb81d8018 ESRT=0xb9b1ca98 RNG=0xbcccbf18 INITRD=0xb74c9b18 
TPMEventLog=0xbccca018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem292: MMIO range=[0xf0000000-0xf7ffffff] 
(128MB) from e820 map
[    0.000000] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    0.000000] efi: Remove mem293: MMIO range=[0xfd100000-0xfd1fffff] 
(1MB) from e820 map
[    0.000000] e820: remove [mem 0xfd100000-0xfd1fffff] reserved
[    0.000000] efi: Not removing mem294: MMIO 
range=[0xfea00000-0xfea0ffff] (64KB) from e820 map
[    0.000000] efi: Remove mem295: MMIO range=[0xfeb80000-0xfec01fff] 
(0MB) from e820 map
[    0.000000] e820: remove [mem 0xfeb80000-0xfec01fff] reserved
[    0.000000] efi: Not removing mem296: MMIO 
range=[0xfec10000-0xfec10fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem297: MMIO 
range=[0xfec30000-0xfec30fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem298: MMIO 
range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem299: MMIO 
range=[0xfed40000-0xfed44fff] (20KB) from e820 map
[    0.000000] efi: Not removing mem300: MMIO 
range=[0xfed80000-0xfed8ffff] (64KB) from e820 map
[    0.000000] efi: Not removing mem301: MMIO 
range=[0xfedc2000-0xfedcffff] (56KB) from e820 map
[    0.000000] efi: Not removing mem302: MMIO 
range=[0xfedd4000-0xfedd5fff] (8KB) from e820 map
[    0.000000] efi: Remove mem303: MMIO range=[0xff000000-0xffffffff] 
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: To Be Filled By O.E.M. B550M-HDV/B550M-HDV, BIOS 
L3.61 02/20/2025
[    0.000000] DMI: Memory slots populated: 1/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3700.068 MHz processor
[    0.000236] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000238] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000249] last_pfn = 0x3bf000 max_arch_pfn = 0x400000000
[    0.000257] MTRR map: 6 entries (4 fixed + 2 variable; max 21), built 
from 9 variable MTRRs
[    0.000259] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- 
WT
[    0.000622] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.000631] last_pfn = 0xbf000 max_arch_pfn = 0x400000000
[    0.004836] esrt: Reserving ESRT space from 0x00000000b9b1ca98 to 
0x00000000b9b1cad0.
[    0.004849] e820: update [mem 0xb9b1c000-0xb9b1cfff] usable ==> reserved
[    0.004892] Using GB pages for direct mapping
[    0.005386] Secure boot disabled
[    0.005387] RAMDISK: [mem 0x9f6a8000-0xaa834fff]
[    0.005568] ACPI: Early table checksum verification disabled
[    0.005571] ACPI: RSDP 0x00000000BD39B014 000024 (v02 ALASKA)
[    0.005575] ACPI: XSDT 0x00000000BD39A728 0000DC (v01 ALASKA A M I 
01072009 AMI  01000013)
[    0.005580] ACPI: FACP 0x00000000BCCF8000 000114 (v06 ALASKA A M I 
01072009 AMI  00010013)
[    0.005585] ACPI: DSDT 0x00000000BCCF1000 0060AC (v02 ALASKA A M I 
01072009 INTL 20120913)
[    0.005588] ACPI: FACS 0x00000000BD395000 000040
[    0.005590] ACPI: SSDT 0x00000000BCCFE000 005419 (v02 AMD    Artic 
00000002 MSFT 04000000)
[    0.005593] ACPI: SSDT 0x00000000BCCFA000 003B45 (v02 AMD    AMD AOD 
00000001 INTL 20120913)
[    0.005596] ACPI: SSDT 0x00000000BCCF9000 000139 (v02 ALASKA CPUSSDT 
01072009 AMI  01072009)
[    0.005598] ACPI: FIDT 0x00000000BCCF0000 00009C (v01 ALASKA A M I 
01072009 AMI  00010013)
[    0.005601] ACPI: MCFG 0x00000000BCCEF000 00003C (v01 ALASKA A M I 
01072009 MSFT 00010013)
[    0.005604] ACPI: AAFT 0x00000000BCCEE000 000115 (v01 ALASKA OEMAAFT 
01072009 MSFT 00000097)
[    0.005606] ACPI: HPET 0x00000000BCCED000 000038 (v01 ALASKA A M I 
01072009 AMI  00000005)
[    0.005609] ACPI: VFCT 0x00000000BCCDF000 00D484 (v01 ALASKA A M I 
00000001 AMD  31504F47)
[    0.005611] ACPI: BGRT 0x00000000BCCDE000 000038 (v01 ALASKA A M I 
01072009 AMI  00010013)
[    0.005614] ACPI: TPM2 0x00000000BCCDD000 00004C (v04 ALASKA A M I 
00000001 AMI  00000000)
[    0.005616] ACPI: IVRS 0x00000000BCCDC000 0000D0 (v02 AMD    AmdTable 
00000001 AMD  00000000)
[    0.005619] ACPI: SSDT 0x00000000BCCDB000 000E34 (v02 AMD    AmdTable 
00000001 AMD  00000001)
[    0.005621] ACPI: CRAT 0x00000000BCCDA000 000810 (v01 AMD    AmdTable 
00000001 AMD  00000001)
[    0.005624] ACPI: CDIT 0x00000000BCCD9000 000029 (v01 AMD    AmdTable 
00000001 AMD  00000001)
[    0.005626] ACPI: SSDT 0x00000000BCCD8000 000D53 (v02 AMD    ArticIG2 
00000001 INTL 20120913)
[    0.005629] ACPI: SSDT 0x00000000BCCD6000 0010C1 (v02 AMD    ArticTPX 
00000001 INTL 20120913)
[    0.005631] ACPI: SSDT 0x00000000BCCD2000 0037C4 (v02 AMD    ArticN 
00000001 INTL 20120913)
[    0.005633] ACPI: WSMT 0x00000000BCCD1000 000028 (v01 ALASKA A M I 
01072009 AMI  00010013)
[    0.005636] ACPI: APIC 0x00000000BCCD0000 00015E (v04 ALASKA A M I 
01072009 AMI  00010013)
[    0.005639] ACPI: SSDT 0x00000000BCCCE000 0010AF (v02 AMD    ArticC 
00000001 INTL 20120913)
[    0.005641] ACPI: SSDT 0x00000000BCCCD000 0000BF (v01 AMD    AmdTable 
00001000 INTL 20120913)
[    0.005643] ACPI: FPDT 0x00000000BCCCC000 000044 (v01 ALASKA A M I 
01072009 AMI  01000013)
[    0.005645] ACPI: Reserving FACP table memory at [mem 
0xbccf8000-0xbccf8113]
[    0.005647] ACPI: Reserving DSDT table memory at [mem 
0xbccf1000-0xbccf70ab]
[    0.005648] ACPI: Reserving FACS table memory at [mem 
0xbd395000-0xbd39503f]
[    0.005649] ACPI: Reserving SSDT table memory at [mem 
0xbccfe000-0xbcd03418]
[    0.005649] ACPI: Reserving SSDT table memory at [mem 
0xbccfa000-0xbccfdb44]
[    0.005650] ACPI: Reserving SSDT table memory at [mem 
0xbccf9000-0xbccf9138]
[    0.005651] ACPI: Reserving FIDT table memory at [mem 
0xbccf0000-0xbccf009b]
[    0.005652] ACPI: Reserving MCFG table memory at [mem 
0xbccef000-0xbccef03b]
[    0.005652] ACPI: Reserving AAFT table memory at [mem 
0xbccee000-0xbccee114]
[    0.005653] ACPI: Reserving HPET table memory at [mem 
0xbcced000-0xbcced037]
[    0.005654] ACPI: Reserving VFCT table memory at [mem 
0xbccdf000-0xbccec483]
[    0.005655] ACPI: Reserving BGRT table memory at [mem 
0xbccde000-0xbccde037]
[    0.005655] ACPI: Reserving TPM2 table memory at [mem 
0xbccdd000-0xbccdd04b]
[    0.005656] ACPI: Reserving IVRS table memory at [mem 
0xbccdc000-0xbccdc0cf]
[    0.005657] ACPI: Reserving SSDT table memory at [mem 
0xbccdb000-0xbccdbe33]
[    0.005657] ACPI: Reserving CRAT table memory at [mem 
0xbccda000-0xbccda80f]
[    0.005658] ACPI: Reserving CDIT table memory at [mem 
0xbccd9000-0xbccd9028]
[    0.005659] ACPI: Reserving SSDT table memory at [mem 
0xbccd8000-0xbccd8d52]
[    0.005660] ACPI: Reserving SSDT table memory at [mem 
0xbccd6000-0xbccd70c0]
[    0.005660] ACPI: Reserving SSDT table memory at [mem 
0xbccd2000-0xbccd57c3]
[    0.005661] ACPI: Reserving WSMT table memory at [mem 
0xbccd1000-0xbccd1027]
[    0.005662] ACPI: Reserving APIC table memory at [mem 
0xbccd0000-0xbccd015d]
[    0.005663] ACPI: Reserving SSDT table memory at [mem 
0xbccce000-0xbcccf0ae]
[    0.005663] ACPI: Reserving SSDT table memory at [mem 
0xbcccd000-0xbcccd0be]
[    0.005664] ACPI: Reserving FPDT table memory at [mem 
0xbcccc000-0xbcccc043]
[    0.005745] No NUMA configuration found
[    0.005746] Faking a node at [mem 0x0000000000000000-0x00000003beffffff]
[    0.005754] NODE_DATA(0) allocated [mem 0x3befd3280-0x3beffdfff]
[    0.005983] Zone ranges:
[    0.005984]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005986]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005987]   Normal   [mem 0x0000000100000000-0x00000003beffffff]
[    0.005988]   Device   empty
[    0.005989] Movable zone start for each node
[    0.005992] Early memory node ranges
[    0.005992]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.005993]   node   0: [mem 0x0000000000100000-0x0000000009bfefff]
[    0.005994]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.005995]   node   0: [mem 0x000000000a20b000-0x000000000affffff]
[    0.005996]   node   0: [mem 0x000000000b020000-0x000000003cc0cfff]
[    0.005997]   node   0: [mem 0x000000003cc0e000-0x000000003e13cfff]
[    0.005998]   node   0: [mem 0x000000003e13e000-0x00000000bb5abfff]
[    0.005998]   node   0: [mem 0x00000000be1ff000-0x00000000beffffff]
[    0.005999]   node   0: [mem 0x0000000100000000-0x00000003beffffff]
[    0.006001] Initmem setup node 0 [mem 
0x0000000000001000-0x00000003beffffff]
[    0.006007] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.006031] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.006223] On node 0, zone DMA32: 1025 pages in unavailable ranges
[    0.006243] On node 0, zone DMA32: 11 pages in unavailable ranges
[    0.008294] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.008357] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.013790] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.013953] On node 0, zone DMA32: 11347 pages in unavailable ranges
[    0.039388] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.039429] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.039975] ACPI: PM-Timer IO Port: 0x808
[    0.039985] CPU topo: Ignoring hot-pluggable APIC ID 0 in present 
package.
[    0.039989] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.040004] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 
0-23
[    0.040011] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, 
GSI 24-55
[    0.040013] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.040015] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.040019] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.040020] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.040037] e820: update [mem 0xb7eba000-0xb7efafff] usable ==> reserved
[    0.040057] CPU topo: Max. logical packages:   1
[    0.040058] CPU topo: Max. logical dies:       1
[    0.040059] CPU topo: Max. dies per package:   1
[    0.040063] CPU topo: Max. threads per core:   2
[    0.040064] CPU topo: Num. cores per package:     4
[    0.040064] CPU topo: Num. threads per package:   8
[    0.040065] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.040065] CPU topo: Rejected CPUs 24
[    0.040097] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[    0.040099] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000fffff]
[    0.040100] PM: hibernation: Registered nosave memory: [mem 
0x09bff000-0x09ffffff]
[    0.040102] PM: hibernation: Registered nosave memory: [mem 
0x0a200000-0x0a20afff]
[    0.040104] PM: hibernation: Registered nosave memory: [mem 
0x0b000000-0x0b01ffff]
[    0.040105] PM: hibernation: Registered nosave memory: [mem 
0x3cc0d000-0x3cc0dfff]
[    0.040107] PM: hibernation: Registered nosave memory: [mem 
0x3e13d000-0x3e13dfff]
[    0.040109] PM: hibernation: Registered nosave memory: [mem 
0xb7eba000-0xb7efafff]
[    0.040110] PM: hibernation: Registered nosave memory: [mem 
0xb9b1c000-0xb9b1cfff]
[    0.040112] PM: hibernation: Registered nosave memory: [mem 
0xbb5ac000-0xbe1fefff]
[    0.040114] PM: hibernation: Registered nosave memory: [mem 
0xbf000000-0xffffffff]
[    0.040116] [mem 0xc0000000-0xfe9fffff] available for PCI devices
[    0.040117] Booting paravirtualized kernel on bare hardware
[    0.040120] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.045171] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 
nr_node_ids:1
[    0.045640] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.045647] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
[    0.045649] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.045671] Kernel command line: initrd=\amd-ucode.img 
initrd=\initramfs-linux-btrfs-test.img root=LABEL=NS_ROOT_EXT4 rw 
add_efi_memmap
[    0.045765] printk: log buffer data + meta data: 131072 + 458752 = 
589824 bytes
[    0.047976] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes, linear)
[    0.049154] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[    0.049281] software IO TLB: area num 8.
[    0.068255] Fallback order for Node 0: 0
[    0.068267] Built 1 zonelists, mobility grouping on.  Total pages: 
3649310
[    0.068269] Policy zone: Normal
[    0.068613] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.109187] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.117739] ftrace: allocating 53095 entries in 208 pages
[    0.117743] ftrace: allocated 208 pages with 3 groups
[    0.117851] Dynamic Preempt: full
[    0.117901] rcu: Preemptible hierarchical RCU implementation.
[    0.117902] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.117903] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.117904] 	Trampoline variant of Tasks RCU enabled.
[    0.117904] 	Rude variant of Tasks RCU enabled.
[    0.117904] 	Tracing variant of Tasks RCU enabled.
[    0.117905] rcu: RCU calculated value of scheduler-enlistment delay 
is 100 jiffies.
[    0.117906] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.117917] RCU Tasks: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.117920] RCU Tasks Rude: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.117922] RCU Tasks Trace: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.123334] NR_IRQS: 524544, nr_irqs: 1032, preallocated irqs: 16
[    0.123556] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.123674] kfence: initialized - using 2097152 bytes for 255 objects 
at 0x(____ptrval____)-0x(____ptrval____)
[    0.123710] Console: colour dummy device 80x25
[    0.123713] printk: legacy console [tty0] enabled
[    0.123761] ACPI: Core revision 20250807
[    0.123905] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 133484873504 ns
[    0.123931] APIC: Switch to symmetric I/O mode setup
[    0.124461] AMD-Vi: Using global IVHD EFR:0x4f77ef22294ada, EFR2:0x0
[    0.125738] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.129934] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x6aab2b8ed4a, max_idle_ns: 881590797869 ns
[    0.129940] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 7400.13 BogoMIPS (lpj=3700068)
[    0.129954] AMD Zen1 DIV0 bug detected. Disable SMT for full protection.
[    0.129985] LVT offset 1 assigned for vector 0xf9
[    0.129986] LVT offset 2 assigned for vector 0xf4
[    0.130040] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.130041] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.130044] process: using mwait in idle threads
[    0.130046] mitigations: Enabled attack vectors: user_kernel, 
user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.130050] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl
[    0.130052] Spectre V2 : Mitigation: Retpolines
[    0.130053] RETBleed: Mitigation: untrained return thunk
[    0.130054] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.130055] VMSCAPE: Vulnerable
[    0.130056] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.130057] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on 
context switch and VMEXIT
[    0.130058] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.130058] active return thunk: retbleed_return_thunk
[    0.130064] Spectre V2 : mitigation: Enabling conditional Indirect 
Branch Prediction Barrier
[    0.130066] active return thunk: srso_return_thunk
[    0.130071] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[    0.130073] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.130074] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.130075] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.130076] x86/fpu: Enabled xstate features 0x7, context size is 832 
bytes, using 'compacted' format.
[    0.163437] Freeing SMP alternatives memory: 48K
[    0.163445] pid_max: default: 32768 minimum: 301
[    0.163601] landlock: Up and running.
[    0.163604] Yama: becoming mindful.
[    0.163867] LSM support for eBPF active
[    0.163882] stackdepot: allocating hash table of 1048576 entries via 
kvcalloc
[    0.169026] stackdepot: allocating space for 8192 stack pools via 
kvcalloc
[    0.169123] Mount-cache hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.169163] Mountpoint-cache hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.271874] smpboot: CPU0: AMD Ryzen 5 3400G with Radeon Vega 
Graphics (family: 0x17, model: 0x18, stepping: 0x1)
[    0.271937] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.271937] ... version:                   0
[    0.271937] ... bit width:                 48
[    0.271937] ... generic counters:          6
[    0.271937] ... generic bitmap:            000000000000003f
[    0.271937] ... fixed-purpose counters:    0
[    0.271937] ... fixed-purpose bitmap:      0000000000000000
[    0.271937] ... value mask:                0000ffffffffffff
[    0.271937] ... max period:                00007fffffffffff
[    0.271937] ... global_ctrl mask:          000000000000003f
[    0.271937] signal: max sigframe size: 1776
[    0.271937] rcu: Hierarchical SRCU implementation.
[    0.271937] rcu: 	Max phase no-delay instances is 400.
[    0.271937] Timer migration: 1 hierarchy levels; 8 children per 
group; 1 crossnode level
[    0.279190] MCE: In-kernel MCE decoding enabled.
[    0.279282] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
counter.
[    0.279409] smp: Bringing up secondary CPUs ...
[    0.279574] smpboot: x86: Booting SMP configuration:
[    0.279576] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.288997] smp: Brought up 1 node, 8 CPUs
[    0.288997] smpboot: Total of 8 processors activated (59201.08 BogoMIPS)
[    0.290114] Memory: 11970188K/14597240K available (18583K kernel 
code, 2816K rwdata, 9176K rodata, 4504K init, 5616K bss, 2596664K 
reserved, 0K cma-reserved)
[    0.291001] devtmpfs: initialized
[    0.291001] x86/mm: Memory block size: 128MB
[    0.293438] ACPI: PM: Registering ACPI NVS region [mem 
0x0a200000-0x0a20afff] (45056 bytes)
[    0.293438] ACPI: PM: Registering ACPI NVS region [mem 
0xbcd04000-0xbd3b1fff] (7004160 bytes)
[    0.293438] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.293438] posixtimers hash table entries: 4096 (order: 4, 65536 
bytes, linear)
[    0.293438] futex hash table entries: 2048 (131072 bytes on 1 NUMA 
nodes, total 128 KiB, linear).
[    0.293994] PM: RTC time: 11:58:23, date: 2026-01-07
[    0.294614] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.295128] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic 
allocations
[    0.295469] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.295811] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.295834] audit: initializing netlink subsys (disabled)
[    0.295856] audit: type=2000 audit(1767787103.171:1): 
state=initialized audit_enabled=0 res=1
[    0.296074] thermal_sys: Registered thermal governor 'fair_share'
[    0.296076] thermal_sys: Registered thermal governor 'bang_bang'
[    0.296077] thermal_sys: Registered thermal governor 'step_wise'
[    0.296079] thermal_sys: Registered thermal governor 'user_space'
[    0.296081] thermal_sys: Registered thermal governor 'power_allocator'
[    0.296097] cpuidle: using governor ladder
[    0.296102] cpuidle: using governor menu
[    0.296216] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.296216] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000) 
for domain 0000 [bus 00-7f]
[    0.296216] PCI: Using configuration type 1 for base access
[    0.296369] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[    0.297087] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.297087] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.297087] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.297087] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.298437] ACPI: Added _OSI(Module Device)
[    0.298441] ACPI: Added _OSI(Processor Device)
[    0.298443] ACPI: Added _OSI(Processor Aggregator Device)
[    0.318634] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.321150] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.327485] ACPI: Interpreter enabled
[    0.327508] ACPI: PM: (supports S0 S3 S4 S5)
[    0.327510] ACPI: Using IOAPIC for interrupt routing
[    0.329339] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.329342] PCI: Ignoring E820 reservations for host bridge windows
[    0.329998] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.348122] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.348131] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.348284] acpi PNP0A08:00: _OSC: platform does not support 
[SHPCHotplug LTR DPC]
[    0.348565] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME 
AER PCIeCapability]
[    0.348578] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 
0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially covers 
this bridge
[    0.349203] PCI host bridge to bus 0000:00
[    0.349209] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.349212] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.349214] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.349217] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.349220] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000dffff window]
[    0.349222] pci_bus 0000:00: root bus resource [mem 
0xc0000000-0xfec2ffff window]
[    0.349225] pci_bus 0000:00: root bus resource [mem 
0xfee00000-0xffffffff window]
[    0.349227] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.349244] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000 
conventional PCI endpoint
[    0.349405] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600 
conventional PCI endpoint
[    0.349560] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000 
conventional PCI endpoint
[    0.349662] pci 0000:00:01.1: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[    0.349683] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.349691] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
[    0.349708] pci 0000:00:01.1: enabling Extended Tags
[    0.349762] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.349932] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[    0.349956] pci 0000:00:01.2: PCI bridge to [bus 02-0b]
[    0.349962] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.349966] pci 0000:00:01.2:   bridge window [mem 0xfcc00000-0xfcdfffff]
[    0.349982] pci 0000:00:01.2: enabling Extended Tags
[    0.350036] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.350236] pci 0000:00:01.4: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[    0.350257] pci 0000:00:01.4: PCI bridge to [bus 0c]
[    0.350264] pci 0000:00:01.4:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.350281] pci 0000:00:01.4: enabling Extended Tags
[    0.350334] pci 0000:00:01.4: PME# supported from D0 D3hot D3cold
[    0.350510] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000 
conventional PCI endpoint
[    0.350616] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400 PCIe 
Root Port
[    0.350639] pci 0000:00:08.1: PCI bridge to [bus 0d]
[    0.350645] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.350649] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcbfffff]
[    0.350660] pci 0000:00:08.1:   bridge window [mem 
0xd0000000-0xe01fffff 64bit pref]
[    0.350670] pci 0000:00:08.1: enabling Extended Tags
[    0.350718] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.350914] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 
conventional PCI endpoint
[    0.351079] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 
conventional PCI endpoint
[    0.351257] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000 
conventional PCI endpoint
[    0.351315] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000 
conventional PCI endpoint
[    0.351375] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000 
conventional PCI endpoint
[    0.351434] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000 
conventional PCI endpoint
[    0.351490] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000 
conventional PCI endpoint
[    0.351546] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000 
conventional PCI endpoint
[    0.351603] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000 
conventional PCI endpoint
[    0.351659] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000 
conventional PCI endpoint
[    0.351819] pci 0000:01:00.0: [1cc4:6a13] type 00 class 0x010802 PCIe 
Endpoint
[    0.351857] pci 0000:01:00.0: BAR 0 [mem 0xfcf00000-0xfcf03fff 64bit]
[    0.352782] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, 
limited by 8.0 GT/s PCIe x4 link at 0000:00:01.1 (capable of 63.012 Gb/s 
with 16.0 GT/s PCIe x4 link)
[    0.353604] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.353690] pci 0000:02:00.0: [1022:43ee] type 00 class 0x0c0330 PCIe 
Legacy Endpoint
[    0.353730] pci 0000:02:00.0: BAR 0 [mem 0xfcda0000-0xfcda7fff 64bit]
[    0.353743] pci 0000:02:00.0: enabling Extended Tags
[    0.353804] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.354030] pci 0000:02:00.1: [1022:43eb] type 00 class 0x010601 PCIe 
Legacy Endpoint
[    0.354074] pci 0000:02:00.1: BAR 5 [mem 0xfcd80000-0xfcd9ffff]
[    0.354077] pci 0000:02:00.1: ROM [mem 0xfcd00000-0xfcd7ffff pref]
[    0.354085] pci 0000:02:00.1: enabling Extended Tags
[    0.354132] pci 0000:02:00.1: PME# supported from D3hot D3cold
[    0.354280] pci 0000:02:00.2: [1022:43e9] type 01 class 0x060400 PCIe 
Switch Upstream Port
[    0.354307] pci 0000:02:00.2: PCI bridge to [bus 03-0b]
[    0.354314] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
[    0.354319] pci 0000:02:00.2:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.354341] pci 0000:02:00.2: enabling Extended Tags
[    0.354393] pci 0000:02:00.2: PME# supported from D3hot D3cold
[    0.354575] pci 0000:00:01.2: PCI bridge to [bus 02-0b]
[    0.354746] pci 0000:03:00.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.354774] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.354805] pci 0000:03:00.0: enabling Extended Tags
[    0.354869] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.355048] pci 0000:03:01.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.355076] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.355108] pci 0000:03:01.0: enabling Extended Tags
[    0.355171] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.355332] pci 0000:03:02.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.355360] pci 0000:03:02.0: PCI bridge to [bus 06]
[    0.355391] pci 0000:03:02.0: enabling Extended Tags
[    0.355455] pci 0000:03:02.0: PME# supported from D3hot D3cold
[    0.355619] pci 0000:03:03.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.355646] pci 0000:03:03.0: PCI bridge to [bus 07]
[    0.355654] pci 0000:03:03.0:   bridge window [io  0xf000-0xffff]
[    0.355658] pci 0000:03:03.0:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.355683] pci 0000:03:03.0: enabling Extended Tags
[    0.355746] pci 0000:03:03.0: PME# supported from D3hot D3cold
[    0.355911] pci 0000:03:06.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.355941] pci 0000:03:06.0: PCI bridge to [bus 08]
[    0.355973] pci 0000:03:06.0: enabling Extended Tags
[    0.356036] pci 0000:03:06.0: PME# supported from D3hot D3cold
[    0.356214] pci 0000:03:07.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.356242] pci 0000:03:07.0: PCI bridge to [bus 09]
[    0.356274] pci 0000:03:07.0: enabling Extended Tags
[    0.356337] pci 0000:03:07.0: PME# supported from D3hot D3cold
[    0.356522] pci 0000:03:08.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.356550] pci 0000:03:08.0: PCI bridge to [bus 0a]
[    0.356581] pci 0000:03:08.0: enabling Extended Tags
[    0.356645] pci 0000:03:08.0: PME# supported from D3hot D3cold
[    0.356818] pci 0000:03:09.0: [1022:43ea] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.356846] pci 0000:03:09.0: PCI bridge to [bus 0b]
[    0.356877] pci 0000:03:09.0: enabling Extended Tags
[    0.356943] pci 0000:03:09.0: PME# supported from D3hot D3cold
[    0.357111] pci 0000:02:00.2: PCI bridge to [bus 03-0b]
[    0.357176] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.357231] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.357287] pci 0000:03:02.0: PCI bridge to [bus 06]
[    0.357374] pci 0000:07:00.0: [10ec:8168] type 00 class 0x020000 PCIe 
Endpoint
[    0.357453] pci 0000:07:00.0: BAR 0 [io  0xf000-0xf0ff]
[    0.357462] pci 0000:07:00.0: BAR 2 [mem 0xfcc04000-0xfcc04fff 64bit]
[    0.357468] pci 0000:07:00.0: BAR 4 [mem 0xfcc00000-0xfcc03fff 64bit]
[    0.357624] pci 0000:07:00.0: supports D1 D2
[    0.357626] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.357902] pci 0000:03:03.0: PCI bridge to [bus 07]
[    0.357972] pci 0000:03:06.0: PCI bridge to [bus 08]
[    0.358045] pci 0000:03:07.0: PCI bridge to [bus 09]
[    0.358142] pci 0000:03:08.0: PCI bridge to [bus 0a]
[    0.358209] pci 0000:03:09.0: PCI bridge to [bus 0b]
[    0.358364] pci 0000:0c:00.0: [1c5c:1327] type 00 class 0x010802 PCIe 
Endpoint
[    0.358403] pci 0000:0c:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 64bit]
[    0.358489] pci 0000:0c:00.0: supports D1
[    0.358491] pci 0000:0c:00.0: PME# supported from D0 D1 D3hot
[    0.358695] pci 0000:00:01.4: PCI bridge to [bus 0c]
[    0.358836] pci 0000:0d:00.0: [1002:15d8] type 00 class 0x030000 PCIe 
Legacy Endpoint
[    0.358875] pci 0000:0d:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit 
pref]
[    0.358879] pci 0000:0d:00.0: BAR 2 [mem 0xe0000000-0xe01fffff 64bit 
pref]
[    0.358883] pci 0000:0d:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.358886] pci 0000:0d:00.0: BAR 5 [mem 0xfcb00000-0xfcb7ffff]
[    0.358895] pci 0000:0d:00.0: enabling Extended Tags
[    0.358980] pci 0000:0d:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.359207] pci 0000:0d:00.1: [1002:15de] type 00 class 0x040300 PCIe 
Legacy Endpoint
[    0.359243] pci 0000:0d:00.1: BAR 0 [mem 0xfcb88000-0xfcb8bfff]
[    0.359256] pci 0000:0d:00.1: enabling Extended Tags
[    0.359305] pci 0000:0d:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.359441] pci 0000:0d:00.2: [1022:15df] type 00 class 0x108000 PCIe 
Endpoint
[    0.359479] pci 0000:0d:00.2: BAR 2 [mem 0xfca00000-0xfcafffff]
[    0.359484] pci 0000:0d:00.2: BAR 5 [mem 0xfcb8c000-0xfcb8dfff]
[    0.359492] pci 0000:0d:00.2: enabling Extended Tags
[    0.359672] pci 0000:0d:00.3: [1022:15e0] type 00 class 0x0c0330 PCIe 
Endpoint
[    0.359710] pci 0000:0d:00.3: BAR 0 [mem 0xfc900000-0xfc9fffff 64bit]
[    0.359722] pci 0000:0d:00.3: enabling Extended Tags
[    0.359775] pci 0000:0d:00.3: PME# supported from D0 D3hot D3cold
[    0.359927] pci 0000:0d:00.4: [1022:15e1] type 00 class 0x0c0330 PCIe 
Endpoint
[    0.359967] pci 0000:0d:00.4: BAR 0 [mem 0xfc800000-0xfc8fffff 64bit]
[    0.359979] pci 0000:0d:00.4: enabling Extended Tags
[    0.360032] pci 0000:0d:00.4: PME# supported from D0 D3hot D3cold
[    0.360176] pci 0000:0d:00.6: [1022:15e3] type 00 class 0x040300 PCIe 
Endpoint
[    0.360211] pci 0000:0d:00.6: BAR 0 [mem 0xfcb80000-0xfcb87fff]
[    0.360224] pci 0000:0d:00.6: enabling Extended Tags
[    0.360274] pci 0000:0d:00.6: PME# supported from D0 D3hot D3cold
[    0.360433] pci 0000:00:08.1: PCI bridge to [bus 0d]
[    0.362390] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.362489] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.362570] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.362667] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.362756] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.362830] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.362905] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.362982] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.366218] iommu: Default domain type: Translated
[    0.366218] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.366218] SCSI subsystem initialized
[    0.366218] libata version 3.00 loaded.
[    0.366218] ACPI: bus type USB registered
[    0.366218] usbcore: registered new interface driver usbfs
[    0.366218] usbcore: registered new interface driver hub
[    0.366218] usbcore: registered new device driver usb
[    0.366218] EDAC MC: Ver: 3.0.0
[    0.366941] efivars: Registered efivars operations
[    0.367193] NetLabel: Initializing
[    0.367196] NetLabel:  domain hash size = 128
[    0.367197] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.367225] NetLabel:  unlabeled traffic allowed by default
[    0.367232] mctp: management component transport protocol core
[    0.367234] NET: Registered PF_MCTP protocol family
[    0.367242] PCI: Using ACPI for IRQ routing
[    0.371962] PCI: pci_cache_line_size set to 64 bytes
[    0.372346] e820: reserve RAM buffer [mem 0x09bff000-0x0bffffff]
[    0.372365] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.372367] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.372369] e820: reserve RAM buffer [mem 0x3cc0d000-0x3fffffff]
[    0.372371] e820: reserve RAM buffer [mem 0x3e13d000-0x3fffffff]
[    0.372373] e820: reserve RAM buffer [mem 0xb7eba000-0xb7ffffff]
[    0.372375] e820: reserve RAM buffer [mem 0xb9b1c000-0xbbffffff]
[    0.372376] e820: reserve RAM buffer [mem 0xbb5ac000-0xbbffffff]
[    0.372378] e820: reserve RAM buffer [mem 0xbf000000-0xbfffffff]
[    0.372380] e820: reserve RAM buffer [mem 0x3bf000000-0x3bfffffff]
[    0.372483] pci 0000:0d:00.0: vgaarb: setting as boot VGA device
[    0.372483] pci 0000:0d:00.0: vgaarb: bridge control possible
[    0.372483] pci 0000:0d:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    0.372483] vgaarb: loaded
[    0.372483] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.372483] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.381107] clocksource: Switched to clocksource tsc-early
[    0.381433] VFS: Disk quotas dquot_6.6.0
[    0.381445] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.381517] pnp: PnP ACPI init
[    0.381712] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.381835] system 00:01: [mem 0x3bf000000-0x43effffff window] has 
been reserved
[    0.382336] system 00:03: [io  0x0280-0x028f] has been reserved
[    0.382339] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.382342] system 00:03: [io  0x02a0-0x02af] has been reserved
[    0.382345] system 00:03: [io  0x02b0-0x02bf] has been reserved
[    0.382754] pnp 00:04: [dma 0 disabled]
[    0.383188] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.383192] system 00:05: [io  0x040b] has been reserved
[    0.383194] system 00:05: [io  0x04d6] has been reserved
[    0.383197] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.383199] system 00:05: [io  0x0c14] has been reserved
[    0.383202] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.383204] system 00:05: [io  0x0c52] has been reserved
[    0.383207] system 00:05: [io  0x0c6c] has been reserved
[    0.383209] system 00:05: [io  0x0c6f] has been reserved
[    0.383212] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.383214] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.383217] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.383219] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.383222] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.383224] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.383227] system 00:05: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[    0.383230] system 00:05: [mem 0xfec01000-0xfec01fff] could not be 
reserved
[    0.383233] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.383236] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.383239] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be 
reserved
[    0.383242] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.383245] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.384220] pnp: PnP ACPI: found 6 devices
[    0.391111] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.391228] NET: Registered PF_INET protocol family
[    0.391529] IP idents hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.395456] tcp_listen_portaddr_hash hash table entries: 8192 (order: 
5, 131072 bytes, linear)
[    0.395499] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.395631] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes, linear)
[    0.396066] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[    0.396251] TCP: Hash tables configured (established 131072 bind 65536)
[    0.396422] MPTCP token hash table entries: 16384 (order: 7, 393216 
bytes, linear)
[    0.396530] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.396642] UDP-Lite hash table entries: 8192 (order: 7, 524288 
bytes, linear)
[    0.396749] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.396761] NET: Registered PF_XDP protocol family
[    0.396794] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.396802] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
[    0.396814] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.396826] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.396838] pci 0000:03:02.0: PCI bridge to [bus 06]
[    0.396850] pci 0000:03:03.0: PCI bridge to [bus 07]
[    0.396854] pci 0000:03:03.0:   bridge window [io  0xf000-0xffff]
[    0.396861] pci 0000:03:03.0:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.396870] pci 0000:03:06.0: PCI bridge to [bus 08]
[    0.396881] pci 0000:03:07.0: PCI bridge to [bus 09]
[    0.396893] pci 0000:03:08.0: PCI bridge to [bus 0a]
[    0.396905] pci 0000:03:09.0: PCI bridge to [bus 0b]
[    0.396916] pci 0000:02:00.2: PCI bridge to [bus 03-0b]
[    0.396920] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
[    0.396925] pci 0000:02:00.2:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.396934] pci 0000:00:01.2: PCI bridge to [bus 02-0b]
[    0.396937] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.396942] pci 0000:00:01.2:   bridge window [mem 0xfcc00000-0xfcdfffff]
[    0.396951] pci 0000:00:01.4: PCI bridge to [bus 0c]
[    0.396955] pci 0000:00:01.4:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.396968] pci 0000:00:08.1: PCI bridge to [bus 0d]
[    0.396976] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.396981] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcbfffff]
[    0.396985] pci 0000:00:08.1:   bridge window [mem 
0xd0000000-0xe01fffff 64bit pref]
[    0.396994] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.396997] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.397001] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.397005] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.397009] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff 
window]
[    0.397011] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfec2ffff 
window]
[    0.397014] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff 
window]
[    0.397017] pci_bus 0000:01: resource 1 [mem 0xfcf00000-0xfcffffff]
[    0.397020] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.397023] pci_bus 0000:02: resource 1 [mem 0xfcc00000-0xfcdfffff]
[    0.397026] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.397028] pci_bus 0000:03: resource 1 [mem 0xfcc00000-0xfccfffff]
[    0.397031] pci_bus 0000:07: resource 0 [io  0xf000-0xffff]
[    0.397034] pci_bus 0000:07: resource 1 [mem 0xfcc00000-0xfccfffff]
[    0.397037] pci_bus 0000:0c: resource 1 [mem 0xfce00000-0xfcefffff]
[    0.397040] pci_bus 0000:0d: resource 0 [io  0xe000-0xefff]
[    0.397042] pci_bus 0000:0d: resource 1 [mem 0xfc800000-0xfcbfffff]
[    0.397045] pci_bus 0000:0d: resource 2 [mem 0xd0000000-0xe01fffff 
64bit pref]
[    0.397521] pci 0000:0d:00.1: D0 power state depends on 0000:0d:00.0
[    0.397549] pci 0000:0d:00.3: extending delay after power-on from 
D3hot to 20 msec
[    0.397736] pci 0000:0d:00.4: extending delay after power-on from 
D3hot to 20 msec
[    0.397869] PCI: CLS 64 bytes, default 64
[    0.397886] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
supported
[    0.397943] Unpacking initramfs...
[    0.397987] pci 0000:00:01.0: Adding to iommu group 0
[    0.398004] pci 0000:00:01.1: Adding to iommu group 0
[    0.398020] pci 0000:00:01.2: Adding to iommu group 0
[    0.398037] pci 0000:00:01.4: Adding to iommu group 0
[    0.398071] pci 0000:00:08.0: Adding to iommu group 1
[    0.398088] pci 0000:00:08.1: Adding to iommu group 1
[    0.398121] pci 0000:00:14.0: Adding to iommu group 2
[    0.398139] pci 0000:00:14.3: Adding to iommu group 2
[    0.398226] pci 0000:00:18.0: Adding to iommu group 3
[    0.398244] pci 0000:00:18.1: Adding to iommu group 3
[    0.398261] pci 0000:00:18.2: Adding to iommu group 3
[    0.398278] pci 0000:00:18.3: Adding to iommu group 3
[    0.398296] pci 0000:00:18.4: Adding to iommu group 3
[    0.398313] pci 0000:00:18.5: Adding to iommu group 3
[    0.398330] pci 0000:00:18.6: Adding to iommu group 3
[    0.398350] pci 0000:00:18.7: Adding to iommu group 3
[    0.398357] pci 0000:01:00.0: Adding to iommu group 0
[    0.398366] pci 0000:02:00.0: Adding to iommu group 0
[    0.398373] pci 0000:02:00.1: Adding to iommu group 0
[    0.398380] pci 0000:02:00.2: Adding to iommu group 0
[    0.398390] pci 0000:03:00.0: Adding to iommu group 0
[    0.398397] pci 0000:03:01.0: Adding to iommu group 0
[    0.398406] pci 0000:03:02.0: Adding to iommu group 0
[    0.398414] pci 0000:03:03.0: Adding to iommu group 0
[    0.398422] pci 0000:03:06.0: Adding to iommu group 0
[    0.398430] pci 0000:03:07.0: Adding to iommu group 0
[    0.398437] pci 0000:03:08.0: Adding to iommu group 0
[    0.398445] pci 0000:03:09.0: Adding to iommu group 0
[    0.398452] pci 0000:07:00.0: Adding to iommu group 0
[    0.398460] pci 0000:0c:00.0: Adding to iommu group 0
[    0.398476] pci 0000:0d:00.0: Adding to iommu group 1
[    0.398483] pci 0000:0d:00.1: Adding to iommu group 1
[    0.398491] pci 0000:0d:00.2: Adding to iommu group 1
[    0.398498] pci 0000:0d:00.3: Adding to iommu group 1
[    0.398507] pci 0000:0d:00.4: Adding to iommu group 1
[    0.398514] pci 0000:0d:00.6: Adding to iommu group 1
[    0.399476] AMD-Vi: Extended features (0x4f77ef22294ada, 0x0): PPR NX 
GT IA GA PC GA_vAPIC
[    0.399492] AMD-Vi: Interrupt remapping enabled
[    0.399663] AMD-Vi: Virtual APIC enabled
[    0.399676] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.399678] software IO TLB: mapped [mem 
0x00000000b33f3000-0x00000000b73f3000] (64MB)
[    0.399767] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
counters/bank).
[    0.401204] Initialise system trusted keyrings
[    0.401218] Key type blacklist registered
[    0.401363] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    0.401697] fuse: init (API version 7.45)
[    0.401796] integrity: Platform Keyring initialized
[    0.401799] integrity: Machine keyring initialized
[    0.414755] Key type asymmetric registered
[    0.414758] Asymmetric key parser 'x509' registered
[    0.414790] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[    0.414889] io scheduler mq-deadline registered
[    0.414891] io scheduler kyber registered
[    0.414916] io scheduler bfq registered
[    0.416117] ledtrig-cpu: registered to indicate activity on CPUs
[    0.416297] pcieport 0000:00:01.1: PME: Signaling with IRQ 26
[    0.416492] pcieport 0000:00:01.2: PME: Signaling with IRQ 27
[    0.416670] pcieport 0000:00:01.4: PME: Signaling with IRQ 28
[    0.416851] pcieport 0000:00:08.1: PME: Signaling with IRQ 29
[    0.418963] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.419008] ACPI: button: Power Button [PWRB]
[    0.419057] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.420787] ACPI: button: Power Button [PWRF]
[    0.421340] Could not retrieve perf counters (-19)
[    0.421702] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.421997] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    0.426748] Non-volatile memory driver v1.3
[    0.426754] Linux agpgart interface v0.103
[    0.480954] tpm_crb MSFT0101:00: Disabling hwrng
[    0.481419] ACPI: bus type drm_connector registered
[    0.482769] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
[    0.482815] ahci 0000:02:00.1: AHCI vers 0001.0301, 32 command slots, 
6 Gbps, SATA mode
[    0.482821] ahci 0000:02:00.1: 6/6 ports implemented (port mask 0x3f)
[    0.482825] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo 
only pmp pio slum part sxs deso sadm sds apst
[    0.483790] scsi host0: ahci
[    0.483994] scsi host1: ahci
[    0.484160] scsi host2: ahci
[    0.484324] scsi host3: ahci
[    0.484483] scsi host4: ahci
[    0.484646] scsi host5: ahci
[    0.484725] ata1: SATA max UDMA/133 abar m131072@0xfcd80000 port 
0xfcd80100 irq 42 lpm-pol 1 ext
[    0.484729] ata2: SATA max UDMA/133 abar m131072@0xfcd80000 port 
0xfcd80180 irq 42 lpm-pol 1 ext
[    0.484733] ata3: SATA max UDMA/133 abar m131072@0xfcd80000 port 
0xfcd80200 irq 42 lpm-pol 1 ext
[    0.484741] ata4: SATA max UDMA/133 abar m131072@0xfcd80000 port 
0xfcd80280 irq 42 lpm-pol 1 ext
[    0.484744] ata5: SATA max UDMA/133 abar m131072@0xfcd80000 port 
0xfcd80300 irq 42 lpm-pol 1 ext
[    0.484748] ata6: SATA max UDMA/133 abar m131072@0xfcd80000 port 
0xfcd80380 irq 42 lpm-pol 1 ext
[    0.485102] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.485112] xhci_hcd 0000:02:00.0: new USB bus registered, assigned 
bus number 1
[    0.540494] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 
0x110 quirks 0x0000000000000010
[    0.541137] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.541145] xhci_hcd 0000:02:00.0: new USB bus registered, assigned 
bus number 2
[    0.541153] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced 
SuperSpeed
[    0.541255] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.19
[    0.541258] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.541261] usb usb1: Product: xHCI Host Controller
[    0.541263] usb usb1: Manufacturer: Linux 6.19.0-rc4-btrfs-test-dirty 
xhci-hcd
[    0.541266] usb usb1: SerialNumber: 0000:02:00.0
[    0.541460] hub 1-0:1.0: USB hub found
[    0.541477] hub 1-0:1.0: 10 ports detected
[    0.541804] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    0.541836] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.19
[    0.541839] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.541842] usb usb2: Product: xHCI Host Controller
[    0.541844] usb usb2: Manufacturer: Linux 6.19.0-rc4-btrfs-test-dirty 
xhci-hcd
[    0.541846] usb usb2: SerialNumber: 0000:02:00.0
[    0.541947] hub 2-0:1.0: USB hub found
[    0.541957] hub 2-0:1.0: 4 ports detected
[    0.542347] xhci_hcd 0000:0d:00.3: xHCI Host Controller
[    0.542357] xhci_hcd 0000:0d:00.3: new USB bus registered, assigned 
bus number 3
[    0.542508] xhci_hcd 0000:0d:00.3: hcc params 0x0270ffe5 hci version 
0x110 quirks 0x0004000840000010
[    0.543073] xhci_hcd 0000:0d:00.3: xHCI Host Controller
[    0.543077] xhci_hcd 0000:0d:00.3: new USB bus registered, assigned 
bus number 4
[    0.543081] xhci_hcd 0000:0d:00.3: Host supports USB 3.1 Enhanced 
SuperSpeed
[    0.543182] usb usb3: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.19
[    0.543185] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.543188] usb usb3: Product: xHCI Host Controller
[    0.543191] usb usb3: Manufacturer: Linux 6.19.0-rc4-btrfs-test-dirty 
xhci-hcd
[    0.543193] usb usb3: SerialNumber: 0000:0d:00.3
[    0.543382] hub 3-0:1.0: USB hub found
[    0.543399] hub 3-0:1.0: 4 ports detected
[    0.543897] usb usb4: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    0.543927] usb usb4: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.19
[    0.543929] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.543932] usb usb4: Product: xHCI Host Controller
[    0.543934] usb usb4: Manufacturer: Linux 6.19.0-rc4-btrfs-test-dirty 
xhci-hcd
[    0.543937] usb usb4: SerialNumber: 0000:0d:00.3
[    0.544057] hub 4-0:1.0: USB hub found
[    0.544072] hub 4-0:1.0: 4 ports detected
[    0.544810] xhci_hcd 0000:0d:00.4: xHCI Host Controller
[    0.544818] xhci_hcd 0000:0d:00.4: new USB bus registered, assigned 
bus number 5
[    0.544961] xhci_hcd 0000:0d:00.4: hcc params 0x0260ffe5 hci version 
0x110 quirks 0x0004000840000010
[    0.545493] xhci_hcd 0000:0d:00.4: xHCI Host Controller
[    0.545497] xhci_hcd 0000:0d:00.4: new USB bus registered, assigned 
bus number 6
[    0.545502] xhci_hcd 0000:0d:00.4: Host supports USB 3.1 Enhanced 
SuperSpeed
[    0.545596] usb usb5: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.19
[    0.545599] usb usb5: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.545601] usb usb5: Product: xHCI Host Controller
[    0.545604] usb usb5: Manufacturer: Linux 6.19.0-rc4-btrfs-test-dirty 
xhci-hcd
[    0.545606] usb usb5: SerialNumber: 0000:0d:00.4
[    0.545755] hub 5-0:1.0: USB hub found
[    0.545769] hub 5-0:1.0: 1 port detected
[    0.545917] usb usb6: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    0.545949] usb usb6: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.19
[    0.545952] usb usb6: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.545954] usb usb6: Product: xHCI Host Controller
[    0.545956] usb usb6: Manufacturer: Linux 6.19.0-rc4-btrfs-test-dirty 
xhci-hcd
[    0.545958] usb usb6: SerialNumber: 0000:0d:00.4
[    0.546074] hub 6-0:1.0: USB hub found
[    0.546087] hub 6-0:1.0: 1 port detected
[    0.546263] usbcore: registered new interface driver usbserial_generic
[    0.546273] usbserial: USB Serial support registered for generic
[    0.546332] i8042: PNP: No PS/2 controller found.
[    0.546482] rtc_cmos 00:02: RTC can wake from S4
[    0.546830] rtc_cmos 00:02: registered as rtc0
[    0.546870] rtc_cmos 00:02: setting system clock to 
2026-01-07T11:58:23 UTC (1767787103)
[    0.546914] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    0.547463] simple-framebuffer simple-framebuffer.0: [drm] Registered 
1 planes with drm panic
[    0.547485] [drm] Initialized simpledrm 1.0.0 for 
simple-framebuffer.0 on minor 0
[    0.548620] fbcon: Deferring console take-over
[    0.548629] simple-framebuffer simple-framebuffer.0: [drm] fb0: 
simpledrmdrmfb frame buffer device
[    0.548719] hid: raw HID events driver (C) Jiri Kosina
[    0.548792] usbcore: registered new interface driver usbhid
[    0.548794] usbhid: USB HID core driver
[    0.548972] drop_monitor: Initializing network drop monitor service
[    0.549132] NET: Registered PF_INET6 protocol family
[    0.549597] Segment Routing with IPv6
[    0.549600] RPL Segment Routing with IPv6
[    0.549611] In-situ OAM (IOAM) with IPv6
[    0.549645] NET: Registered PF_PACKET protocol family
[    0.550695] x86/amd: Previous system reset reason [0x00080800]: 
software wrote 0x6 to reset control register 0xCF9
[    0.550714] microcode: Current revision: 0x0810810e
[    0.550853] IPI shorthand broadcast: enabled
[    0.555029] sched_clock: Marking stable (554397018, 
346273)->(562840266, -8096975)
[    0.555288] registered taskstats version 1
[    0.555749] Loading compiled-in X.509 certificates
[    0.572121] Freeing initrd memory: 181812K
[    0.580962] Loaded X.509 cert 'Build time autogenerated kernel key: 
0303e5cd77393883c386bbfffb7d7374b4de5087'
[    0.586052] zswap: loaded using pool zstd
[    0.586121] Demotion targets for Node 0: null
[    0.586278] Key type .fscrypt registered
[    0.586279] Key type fscrypt-provisioning registered
[    0.586330] Key type big_key registered
[    0.586736] PM:   Magic number: 10:103:984
[    0.586941] RAS: Correctable Errors collector initialized.
[    0.586993] clk: Disabling unused clocks
[    0.586995] PM: genpd: Disabling unused power domains
[    0.841191] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    0.956570] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.008049] ata1.00: ATA-9: HSH721414ALN6M0, T108, max UDMA/133
[    1.018344] ata1.00: 3418095616 sectors, multi 0: LBA48 NCQ (depth 
32), AA
[    1.020230] ata1.00: Features: HIPM DIPM NCQ-sndrcv NCQ-prio
[    1.037831] ata1.00: configured for UDMA/133
[    1.052702] scsi 0:0:0:0: Direct-Access-ZBC ATA      HSH721414ALN6M0 
T108 PQ: 0 ANSI: 7
[    1.053148] sd 0:0:0:0: [sda] Host-managed zoned block device
[    1.151361] usb 1-2: New USB device found, idVendor=2717, 
idProduct=5055, bcdDevice= 2.06
[    1.151366] usb 1-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    1.151370] usb 1-2: Product: Xiaomi Wireless Keyboard and Mouse Combo 2
[    1.151373] usb 1-2: Manufacturer: Telink
[    1.186617] input: Telink Xiaomi Wireless Keyboard and Mouse Combo 2 
Mouse as 
/devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-2/1-2:1.0/0003:2717:5055.0001/input/input2
[    1.186739] input: Telink Xiaomi Wireless Keyboard and Mouse Combo 2 
Consumer Control as 
/devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-2/1-2:1.0/0003:2717:5055.0001/input/input3
[    1.237430] input: Telink Xiaomi Wireless Keyboard and Mouse Combo 2 
System Control as 
/devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-2/1-2:1.0/0003:2717:5055.0001/input/input4
[    1.237515] hid-generic 0003:2717:5055.0001: input,hidraw0: USB HID 
v1.11 Mouse [Telink Xiaomi Wireless Keyboard and Mouse Combo 2] on 
usb-0000:02:00.0-2/input0
[    1.250387] input: Telink Xiaomi Wireless Keyboard and Mouse Combo 2 
as 
/devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-2/1-2:1.1/0003:2717:5055.0002/input/input6
[    1.265020] sd 0:0:0:0: [sda] 3418095616 4096-byte logical blocks: 
(14.0 TB/12.7 TiB)
[    1.265038] sd 0:0:0:0: [sda] Write Protect is off
[    1.265042] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.265060] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.265093] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    1.301606] hid-generic 0003:2717:5055.0002: input,hidraw1: USB HID 
v1.11 Keyboard [Telink Xiaomi Wireless Keyboard and Mouse Combo 2] on 
usb-0000:02:00.0-2/input1
[    1.435364] tsc: Refined TSC clocksource calibration: 3700.000 MHz
[    1.435371] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x6aaaabc71c7, max_idle_ns: 881590412124 ns
[    1.435393] clocksource: Switched to clocksource tsc
[    1.515369] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.564746] ata2.00: ATA-9: HSH721414ALN6M0, T108, max UDMA/133
[    1.575061] ata2.00: 3418095616 sectors, multi 0: LBA48 NCQ (depth 
32), AA
[    1.576988] ata2.00: Features: HIPM DIPM NCQ-sndrcv NCQ-prio
[    1.594567] ata2.00: configured for UDMA/133
[    1.609464] scsi 1:0:0:0: Direct-Access-ZBC ATA      HSH721414ALN6M0 
T108 PQ: 0 ANSI: 7
[    1.609863] sd 1:0:0:0: [sdb] Host-managed zoned block device
[    1.813895] sd 0:0:0:0: [sda] 52156 zones of 65536 logical blocks
[    1.821459] sd 1:0:0:0: [sdb] 3418095616 4096-byte logical blocks: 
(14.0 TB/12.7 TiB)
[    1.821474] sd 1:0:0:0: [sdb] Write Protect is off
[    1.821477] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.821495] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.821526] sd 1:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    1.912448] ata3: SATA link down (SStatus 0 SControl 330)
[    2.048969] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.232453] ata4: SATA link down (SStatus 0 SControl 330)
[    2.372803] sd 1:0:0:0: [sdb] 52156 zones of 65536 logical blocks
[    2.609066] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.707365] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.760699] ata5.00: ATA-9: HSH721414ALN6M0, T108, max UDMA/133
[    2.770981] ata5.00: 3418095616 sectors, multi 0: LBA48 NCQ (depth 
32), AA
[    2.772894] ata5.00: Features: HIPM DIPM NCQ-sndrcv NCQ-prio
[    2.790482] ata5.00: configured for UDMA/133
[    2.805381] scsi 4:0:0:0: Direct-Access-ZBC ATA      HSH721414ALN6M0 
T108 PQ: 0 ANSI: 7
[    2.805752] sd 4:0:0:0: [sdc] Host-managed zoned block device
[    3.044093] sd 4:0:0:0: [sdc] 3418095616 4096-byte logical blocks: 
(14.0 TB/12.7 TiB)
[    3.044105] sd 4:0:0:0: [sdc] Write Protect is off
[    3.044108] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    3.044125] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.044156] sd 4:0:0:0: [sdc] Preferred minimum I/O size 4096 bytes
[    3.267362] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.326647] ata6.00: ATA-9: HSH721414ALN6M0, T108, max UDMA/133
[    3.336978] ata6.00: 3418095616 sectors, multi 0: LBA48 NCQ (depth 
32), AA
[    3.338873] ata6.00: Features: HIPM DIPM NCQ-sndrcv NCQ-prio
[    3.356541] ata6.00: configured for UDMA/133
[    3.371508] scsi 5:0:0:0: Direct-Access-ZBC ATA      HSH721414ALN6M0 
T108 PQ: 0 ANSI: 7
[    3.371884] sd 5:0:0:0: [sdd] Host-managed zoned block device
[    3.602071] sd 5:0:0:0: [sdd] 3418095616 4096-byte logical blocks: 
(14.0 TB/12.7 TiB)
[    3.602095] sd 5:0:0:0: [sdd] Write Protect is off
[    3.602099] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    3.602120] sd 5:0:0:0: [sdd] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.602155] sd 5:0:0:0: [sdd] Preferred minimum I/O size 4096 bytes
[    3.765783] sd 4:0:0:0: [sdc] 52156 zones of 65536 logical blocks
[    4.029196] sd 4:0:0:0: [sdc] Attached SCSI disk
[    4.237808] sd 5:0:0:0: [sdd] 52156 zones of 65536 logical blocks
[    4.488089] sd 5:0:0:0: [sdd] Attached SCSI disk
[    4.492105] Freeing unused decrypted memory: 2036K
[    4.493279] Freeing unused kernel image (initmem) memory: 4504K
[    4.493312] Write protecting the kernel read-only data: 30720k
[    4.494452] Freeing unused kernel image (text/rodata gap) memory: 1896K
[    4.494757] Freeing unused kernel image (rodata/data gap) memory: 1064K
[    4.556700] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.556710] rodata_test: all tests were successful
[    4.556721] Run /init as init process
[    4.556723]   with arguments:
[    4.556725]     /init
[    4.556728]   with environment:
[    4.556729]     HOME=/
[    4.556731]     TERM=linux
[    4.575261] systemd[1]: Successfully made /usr/ read-only.
[    4.575495] systemd[1]: systemd 259-1-arch running in system mode 
(+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT 
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD 
+LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY 
+P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF 
+XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    4.575501] systemd[1]: Detected architecture x86-64.
[    4.575504] systemd[1]: Running in initrd.
[    4.575684] fbcon: Taking over console
[    4.576484] Console: switching to colour frame buffer device 100x37
[    4.577615] systemd[1]: Initializing machine ID from random generator.
[    4.602149] systemd[1]: Queued start job for default target Initrd 
Default Target.
[    4.653437] systemd[1]: Expecting device 
/dev/disk/by-label/NS_ROOT_EXT4...
[    4.653680] systemd[1]: Reached target Path Units.
[    4.653758] systemd[1]: Reached target Slice Units.
[    4.653827] systemd[1]: Reached target Swaps.
[    4.653895] systemd[1]: Reached target Timer Units.
[    4.654080] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.654252] systemd[1]: Listening on Journal Sockets.
[    4.654420] systemd[1]: Listening on udev Control Socket.
[    4.654551] systemd[1]: Listening on udev Kernel Socket.
[    4.654634] systemd[1]: Reached target Socket Units.
[    4.654723] systemd[1]: Create List of Static Device Nodes was 
skipped because of an unmet condition check 
(ConditionFileNotEmpty=/lib/modules/6.19.0-rc4-btrfs-test-dirty/modules.devname).
[    4.654794] systemd[1]: Early Battery Level Check was skipped because 
of an unmet condition check 
(ConditionDirectoryNotEmpty=/sys/class/power_supply).
[    4.659417] systemd[1]: Started Display Boot-Time Emergency Messages 
In Full Screen.
[    4.664376] systemd[1]: Starting Journal Service...
[    4.667094] systemd[1]: Starting Load Kernel Modules...
[    4.667397] systemd[1]: TPM PCR Barrier (initrd) was skipped because 
of an unmet condition check (ConditionSecurity=measured-uki).
[    4.669670] systemd[1]: Starting Create Static Device Nodes in /dev...
[    4.672330] systemd[1]: Starting Coldplug All udev Devices...
[    4.678789] systemd[1]: Finished Load Kernel Modules.
[    4.681099] systemd[1]: Finished Create Static Device Nodes in /dev.
[    4.681682] systemd-journald[186]: Collecting audit messages is disabled.
[    4.681742] systemd[1]: Reached target Preparation for Local File 
Systems.
[    4.682023] systemd[1]: Reached target Local File Systems.
[    4.685068] systemd[1]: Starting Rule-based Manager for Device Events 
and Files...
[    4.719861] systemd[1]: Started Rule-based Manager for Device Events 
and Files.
[    4.759451] systemd[1]: Started Journal Service.
[    4.979251] wmi: module verification failed: signature and/or 
required key missing - tainting kernel
[    4.985167] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no 
  post: no)
[    4.985632] input: Video Bus as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0b/LNXVIDEO:00/input/input7
[    4.994788] Key type psk registered
[    5.023166] nvme nvme0: pci function 0000:01:00.0
[    5.023166] nvme nvme1: pci function 0000:0c:00.0
[    5.031399] nvme nvme1: 8/0/0 default/read/poll queues
[    5.040437]  nvme1n1: p1 p2 p3
[    5.053995] nvme nvme0: allocated 64 MiB host memory buffer (1 segment).
[    5.065896] nvme nvme0: 8/0/0 default/read/poll queues
[    5.073567]  nvme0n1: p1 p2 p3 p4
[    5.935607] EXT4-fs (nvme1n1p3): mounted filesystem 
5a573672-0822-493c-b5d2-c030855f335f r/w with ordered data mode. Quota 
mode: none.
[    9.459497] [drm] amdgpu kernel modesetting enabled.
[    9.473582] amdgpu: Virtual CRAT table created for CPU
[    9.473602] amdgpu: Topology: Add CPU node
[    9.473801] amdgpu 0000:0d:00.0: enabling device (0006 -> 0007)
[    9.473854] amdgpu 0000:0d:00.0: amdgpu: initializing kernel 
modesetting (RAVEN 0x1002:0x15D8 0x1002:0x15D8 0xC8).
[    9.473868] amdgpu 0000:0d:00.0: amdgpu: register mmio base: 0xFCB00000
[    9.473871] amdgpu 0000:0d:00.0: amdgpu: register mmio size: 524288
[    9.474270] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 0 
<common_v2_0_0> (soc15_common)
[    9.474274] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 1 
<gmc_v9_0_0> (gmc_v9_0)
[    9.474278] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 2 
<ih_v4_0_0> (vega10_ih)
[    9.474281] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 3 
<psp_v10_0_0> (psp)
[    9.474285] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 4 
<smu_v1_0_0> (powerplay)
[    9.474288] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 5 
<dce_v1_0_0> (dm)
[    9.474291] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 6 
<gfx_v9_0_0> (gfx_v9_0)
[    9.474294] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 7 
<sdma_v4_0_0> (sdma_v4_0)
[    9.474297] amdgpu 0000:0d:00.0: amdgpu: detected ip block number 8 
<vcn_v1_0_0> (vcn_v1_0)
[    9.474389] amdgpu 0000:0d:00.0: amdgpu: Fetched VBIOS from VFCT
[    9.474394] amdgpu: ATOM BIOS: 113-PICASSO-118
[    9.504502] Console: switching to colour dummy device 80x25
[    9.504920] amdgpu 0000:0d:00.0: vgaarb: deactivate vga console
[    9.504927] amdgpu 0000:0d:00.0: amdgpu: Trusted Memory Zone (TMZ) 
feature enabled
[    9.504990] amdgpu 0000:0d:00.0: amdgpu: vm size is 262144 GB, 4 
levels, block size is 9-bit, fragment size is 9-bit
[    9.505005] amdgpu 0000:0d:00.0: amdgpu: VRAM: 2048M 
0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[    9.505009] amdgpu 0000:0d:00.0: amdgpu: GART: 1024M 
0x0000000000000000 - 0x000000003FFFFFFF
[    9.505026] [drm] Detected VRAM RAM=2048M, BAR=2048M
[    9.505029] [drm] RAM width 64bits DDR4
[    9.505317] amdgpu 0000:0d:00.0: amdgpu: amdgpu: 2048M of VRAM memory 
ready
[    9.505322] amdgpu 0000:0d:00.0: amdgpu: amdgpu: 6949M of GTT memory 
ready.
[    9.505371] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    9.505674] [drm] PCIE GART of 1024M enabled.
[    9.505677] [drm] PTB located at 0x000000F400A00000
[    9.506871] amdgpu: hwmgr_sw_init smu backed is smu10_smu
[    9.507984] amdgpu 0000:0d:00.0: amdgpu: [VCN instance 0] Found VCN 
firmware Version ENC: 1.15 DEC: 3 VEP: 0 Revision: 0
[    9.529248] amdgpu 0000:0d:00.0: amdgpu: reserve 0x400000 from 
0xf47fc00000 for PSP TMR
[    9.597013] amdgpu 0000:0d:00.0: amdgpu: RAS: optional ras ta ucode 
is not available
[    9.603683] amdgpu 0000:0d:00.0: amdgpu: RAP: optional rap ta ucode 
is not available
[    9.607590] amdgpu 0000:0d:00.0: amdgpu: psp gfx command LOAD_TA(0x1) 
failed and response status is (0x7)
[    9.608485] [drm] DM_PPLIB: values for F clock
[    9.608490] [drm] DM_PPLIB:	 400000 in kHz, 3099 in mV
[    9.608493] [drm] DM_PPLIB:	 933000 in kHz, 3574 in mV
[    9.608495] [drm] DM_PPLIB:	 1200000 in kHz, 4399 in mV
[    9.608498] [drm] DM_PPLIB:	 1333000 in kHz, 4399 in mV
[    9.608501] [drm] DM_PPLIB: values for DCF clock
[    9.608503] [drm] DM_PPLIB:	 300000 in kHz, 3099 in mV
[    9.608505] [drm] DM_PPLIB:	 600000 in kHz, 3574 in mV
[    9.608507] [drm] DM_PPLIB:	 626000 in kHz, 4250 in mV
[    9.608509] [drm] DM_PPLIB:	 654000 in kHz, 4399 in mV
[    9.609596] amdgpu 0000:0d:00.0: amdgpu: [drm] Display Core v3.2.359 
initialized on DCN 1.0
[    9.679845] amdgpu 0000:0d:00.0: amdgpu: kiq ring mec 2 pipe 1 q 0
[    9.697715] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    9.697736] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    9.697924] amdgpu: Virtual CRAT table created for GPU
[    9.698028] amdgpu: Topology: Add dGPU node [0x15d8:0x1002]
[    9.698031] kfd kfd: amdgpu: added device 1002:15d8
[    9.698046] amdgpu 0000:0d:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 
11, active_cu_number 11
[    9.698052] amdgpu 0000:0d:00.0: amdgpu: ring gfx uses VM inv eng 0 
on hub 0
[    9.698054] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 1 on hub 0
[    9.698057] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 4 on hub 0
[    9.698059] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
eng 5 on hub 0
[    9.698062] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
eng 6 on hub 0
[    9.698064] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 7 on hub 0
[    9.698066] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 8 on hub 0
[    9.698069] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
eng 9 on hub 0
[    9.698071] amdgpu 0000:0d:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
eng 10 on hub 0
[    9.698073] amdgpu 0000:0d:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv 
eng 11 on hub 0
[    9.698076] amdgpu 0000:0d:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
on hub 8
[    9.698078] amdgpu 0000:0d:00.0: amdgpu: ring vcn_dec uses VM inv eng 
1 on hub 8
[    9.698080] amdgpu 0000:0d:00.0: amdgpu: ring vcn_enc0 uses VM inv 
eng 4 on hub 8
[    9.698083] amdgpu 0000:0d:00.0: amdgpu: ring vcn_enc1 uses VM inv 
eng 5 on hub 8
[    9.698085] amdgpu 0000:0d:00.0: amdgpu: ring jpeg_dec uses VM inv 
eng 6 on hub 8
[    9.704744] amdgpu: pp_dpm_get_sclk_od was not implemented.
[    9.704748] amdgpu: pp_dpm_get_mclk_od was not implemented.
[    9.704858] amdgpu 0000:0d:00.0: amdgpu: Runtime PM not available
[    9.705433] amdgpu 0000:0d:00.0: [drm] Registered 4 planes with drm panic
[    9.714359] [drm] Initialized amdgpu 3.64.0 for 0000:0d:00.0 on minor 1
[    9.718016] amdgpu 0000:0d:00.0: amdgpu: [drm] Failed to setup vendor 
infoframe on connector HDMI-A-2: -22
[    9.722531] fbcon: amdgpudrmfb (fb0) is primary device
[    9.738923] Console: switching to colour frame buffer device 240x67
[    9.772652] amdgpu 0000:0d:00.0: [drm] fb0: amdgpudrmfb frame buffer 
device
[   10.058500] systemd-journald[186]: Received SIGTERM from PID 1 (systemd).
[   10.478148] systemd[1]: systemd 259-1-arch running in system mode 
(+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT 
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD 
+LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY 
+P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF 
+XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[   10.478162] systemd[1]: Detected architecture x86-64.
[   10.553032] systemd[1]: Hostname set to <ninesheep>.
[   10.754826] systemd[1]: bpf-restrict-fs: Failed to load BPF object: 
No such process
[   11.643531] systemd[1]: initrd-switch-root.service: Deactivated 
successfully.
[   11.643768] systemd[1]: Stopped Switch Root.
[   11.645074] systemd[1]: systemd-journald.service: Scheduled restart 
job, restart counter is at 1.
[   11.645817] systemd[1]: Created slice Slice /system/dirmngr.
[   11.646398] systemd[1]: Created slice Slice /system/getty.
[   11.646945] systemd[1]: Created slice Slice /system/gpg-agent.
[   11.647539] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[   11.648081] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[   11.648617] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[   11.649141] systemd[1]: Created slice Slice /system/keyboxd.
[   11.649625] systemd[1]: Created slice Slice /system/modprobe.
[   11.649945] systemd[1]: Created slice User and Session Slice.
[   11.650065] systemd[1]: Started Dispatch Password Requests to Console 
Directory Watch.
[   11.650170] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[   11.650426] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[   11.650504] systemd[1]: Expecting device 
/dev/disk/by-label/6.17_RST_TEST...
[   11.650561] systemd[1]: Expecting device /dev/disk/by-label/DATA2...
[   11.650616] systemd[1]: Expecting device /dev/disk/by-label/DATA4...
[   11.650669] systemd[1]: Expecting device /dev/disk/by-uuid/1433-29C1...
[   11.650718] systemd[1]: Expecting device 
/dev/disk/by-uuid/204a9589-6a4f-478a-8477-3510d9b31337...
[   11.650774] systemd[1]: Expecting device 
/dev/disk/by-uuid/ba54f121-eb78-4af4-8a33-4764db37c0fa...
[   11.650836] systemd[1]: Reached target Local Encrypted Volumes.
[   11.650901] systemd[1]: Reached target Image Downloads.
[   11.650961] systemd[1]: Stopped target Switch Root.
[   11.651017] systemd[1]: Stopped target Initrd File Systems.
[   11.651071] systemd[1]: Stopped target Initrd Root File System.
[   11.651128] systemd[1]: Reached target Local Integrity Protected Volumes.
[   11.651208] systemd[1]: Reached target Path Units.
[   11.651264] systemd[1]: Reached target Remote File Systems.
[   11.651324] systemd[1]: Reached target Slice Units.
[   11.651404] systemd[1]: Reached target Local Verity Protected Volumes.
[   11.651532] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   11.655617] systemd[1]: Listening on Query the User Interactively for 
a Password.
[   11.657429] systemd[1]: Listening on Process Core Dump Socket.
[   11.659193] systemd[1]: Listening on Credential Encryption/Decryption.
[   11.662655] systemd[1]: Listening on Factory Reset Management.
[   11.667024] systemd[1]: Listening on Console Output Muting Service 
Socket.
[   11.667718] systemd[1]: Listening on Network Management Resolve Hook 
Socket.
[   11.668342] systemd[1]: Listening on Network Management Varlink Socket.
[   11.668919] systemd[1]: Listening on Network Management Netlink Socket.
[   11.669401] systemd[1]: TPM PCR Measurements was skipped because of 
an unmet condition check (ConditionSecurity=measured-uki).
[   11.669418] systemd[1]: Make TPM PCR Policy was skipped because of an 
unmet condition check (ConditionSecurity=measured-uki).
[   11.672027] systemd[1]: Listening on Disk Repartitioning Service Socket.
[   11.672636] systemd[1]: Listening on Resolve Monitor Varlink Socket.
[   11.673149] systemd[1]: Listening on Resolve Service Varlink Socket.
[   11.673667] systemd[1]: Listening on udev Control Socket.
[   11.674181] systemd[1]: Listening on udev Varlink Socket.
[   11.674700] systemd[1]: Listening on User Database Manager Socket.
[   11.677097] systemd[1]: Mounting Huge Pages File System...
[   11.678509] systemd[1]: Mounting POSIX Message Queue File System...
[   11.679881] systemd[1]: Mounting Kernel Debug File System...
[   11.681292] systemd[1]: Mounting Kernel Trace File System...
[   11.683083] systemd[1]: Starting Create List of Static Device Nodes...
[   11.684397] systemd[1]: Load Kernel Module configfs was skipped 
because of an unmet condition check (ConditionKernelModuleLoaded=!configfs).
[   11.685638] systemd[1]: Mounting Kernel Configuration File System...
[   11.687555] systemd[1]: Load Kernel Module drm was skipped because of 
an unmet condition check (ConditionKernelModuleLoaded=!drm).
[   11.687647] systemd[1]: Load Kernel Module fuse was skipped because 
of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
[   11.694975] systemd[1]: Mounting FUSE Control File System...
[   11.695909] systemd[1]: systemd-fsck-root.service: Deactivated 
successfully.
[   11.695988] systemd[1]: Stopped File System Check on Root Device.
[   11.697071] systemd[1]: Clear Stale Hibernate Storage Info was 
skipped because of an unmet condition check 
(ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   11.699152] systemd[1]: Starting Journal Service...
[   11.704296] systemd[1]: Load Kernel Modules was skipped because no 
trigger condition checks were met.
[   11.705150] systemd[1]: Starting Generate Network Units from Kernel 
Command Line...
[   11.705883] systemd[1]: TPM PCR Machine ID Measurement was skipped 
because of an unmet condition check (ConditionSecurity=measured-uki).
[   11.705931] systemd[1]: TPM NvPCR Product ID Measurement was skipped 
because of an unmet condition check (ConditionSecurity=measured-uki).
[   11.706954] systemd[1]: Starting Remount Root and Kernel File Systems...
[   11.708740] systemd[1]: Starting Apply Kernel Variables...
[   11.709599] systemd[1]: Early TPM SRK Setup was skipped because of an 
unmet condition check (ConditionSecurity=measured-uki).
[   11.710580] systemd[1]: Starting Load udev Rules from Credentials...
[   11.712384] systemd[1]: Starting Coldplug All udev Devices...
[   11.783059] systemd[1]: Finished Create List of Static Device Nodes.
[   11.784887] systemd[1]: Starting Create Static Device Nodes in /dev 
gracefully...
[   11.791173] systemd[1]: Mounted POSIX Message Queue File System.
[   11.793012] systemd[1]: Mounted Kernel Debug File System.
[   11.793856] systemd[1]: Mounted Kernel Trace File System.
[   11.795159] systemd[1]: Mounted Huge Pages File System.
[   11.795912] systemd[1]: Mounted Kernel Configuration File System.
[   11.796500] systemd[1]: Mounted FUSE Control File System.
[   11.799641] systemd[1]: Finished Generate Network Units from Kernel 
Command Line.
[   11.800698] systemd[1]: Reached target Preparation for Network.
[   11.807498] EXT4-fs (nvme1n1p3): re-mounted 
5a573672-0822-493c-b5d2-c030855f335f.
[   11.808755] systemd[1]: Finished Remount Root and Kernel File Systems.
[   11.812585] systemd-journald[466]: Collecting audit messages is disabled.
[   11.829203] systemd[1]: Rebuild Hardware Database was skipped because 
of an unmet condition check (ConditionNeedsUpdate=/etc).
[   11.830421] systemd[1]: Starting Load/Save OS Random Seed...
[   11.831256] systemd[1]: TPM SRK Setup was skipped because of an unmet 
condition check (ConditionSecurity=measured-uki).
[   11.831289] systemd[1]: TPM PCR NvPCR Initialization Separator was 
skipped because of an unmet condition check 
(ConditionSecurity=measured-uki).
[   11.831848] systemd[1]: Finished Apply Kernel Variables.
[   11.839615] systemd[1]: Finished Load udev Rules from Credentials.
[   11.840722] systemd[1]: Started Journal Service.
[   11.868111] systemd-journald[466]: Received client request to flush 
runtime journal.
[   13.079850] acpi_cpufreq: overriding BIOS provided _PSD data
[   13.085436] input: PC Speaker as /devices/platform/pcspkr/input/input8
[   13.126037] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 
163840 ms ovfl timer
[   13.126045] RAPL PMU: hw unit of domain package 2^-16 Joules
[   13.126047] RAPL PMU: hw unit of domain core 2^-16 Joules
[   13.216014] mousedev: PS/2 mouse device common for all mice
[   13.248930] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, 
revision 0
[   13.248944] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus 
port selection
[   13.249774] i2c i2c-6: Successfully instantiated SPD at 0x50
[   13.249917] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller 
at 0xb20
[   13.286932] ccp 0000:0d:00.2: enabling device (0000 -> 0002)
[   13.287913] ccp 0000:0d:00.2: ccp enabled
[   13.289105] ccp 0000:0d:00.2: tee enabled
[   13.289371] ccp 0000:0d:00.2: psp enabled
[   13.314640] raid6: skipped pq benchmark and selected avx2x4
[   13.314648] raid6: using avx2x2 recovery algorithm
[   13.340763] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   13.340899] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO 
address
[   13.341033] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec 
(nowayout=0)
[   13.407645] xor: automatically using best checksumming function   avx 

[   13.508784] ee1004 6-0050: 512 byte EE1004-compliant SPD EEPROM, 
read-only
[   13.619297] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[   13.626269] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.626436] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   13.653070] faux_driver regulatory: Direct firmware load for 
regulatory.db failed with error -2
[   13.653086] cfg80211: failed to load regulatory.db
[   14.051319] r8169 0000:07:00.0 eth0: RTL8168h/8111h, 
9c:6b:00:10:66:03, XID 541, IRQ 93
[   14.051328] r8169 0000:07:00.0 eth0: jumbo features [frames: 9194 
bytes, tx checksumming: ko]
[   14.079440] r8169 0000:07:00.0 ethob: renamed from eth0
[   14.152259] Adding 8388604k swap on /dev/nvme1n1p2.  Priority:-1 
extents:1 across:8388604k SS
[   14.318104] snd_hda_intel 0000:0d:00.1: enabling device (0000 -> 0002)
[   14.318396] snd_hda_intel 0000:0d:00.1: Handle vga_switcheroo audio 
client
[   14.318682] snd_hda_intel 0000:0d:00.6: enabling device (0000 -> 0002)
[   14.393802] kvm_amd: TSC scaling supported
[   14.393812] kvm_amd: Nested Virtualization enabled
[   14.393819] kvm_amd: Nested Paging enabled
[   14.393826] kvm_amd: LBR virtualization supported
[   14.393840] kvm_amd: SEV disabled (ASIDs 0 - 15)
[   14.393847] kvm_amd: SEV-ES disabled (ASIDs 1 - 4294967295)
[   14.393854] kvm_amd: Virtual VMLOAD VMSAVE supported
[   14.393858] kvm_amd: Virtual GIF supported
[   14.410297] snd_hda_codec_generic hdaudioC1D0: autoconfig for 
Generic: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   14.410312] snd_hda_codec_generic hdaudioC1D0:    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[   14.410321] snd_hda_codec_generic hdaudioC1D0:    hp_outs=1 
(0x1b/0x0/0x0/0x0/0x0)
[   14.410328] snd_hda_codec_generic hdaudioC1D0:    mono: mono_out=0x0
[   14.410333] snd_hda_codec_generic hdaudioC1D0:    inputs:
[   14.410339] snd_hda_codec_generic hdaudioC1D0:      Rear Mic=0x18
[   14.410346] snd_hda_codec_generic hdaudioC1D0:      Front Mic=0x19
[   14.410369] snd_hda_codec_generic hdaudioC1D0:      Line=0x1a
[   14.428632] input: HD-Audio Generic Rear Mic as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.6/sound/card1/input9
[   14.428765] input: HD-Audio Generic Front Mic as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.6/sound/card1/input10
[   14.428870] input: HD-Audio Generic Line as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.6/sound/card1/input11
[   14.428975] input: HD-Audio Generic Line Out as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.6/sound/card1/input12
[   14.429066] input: HD-Audio Generic Front Headphone as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.6/sound/card1/input13
[   14.430418] snd_hda_intel 0000:0d:00.1: bound 0000:0d:00.0 (ops 
amdgpu_dm_audio_component_bind_ops [amdgpu])
[   14.435778] input: HD-Audio Generic HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.1/sound/card0/input14
[   14.436432] input: HD-Audio Generic HDMI/DP,pcm=7 as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.1/sound/card0/input15
[   14.436611] input: HD-Audio Generic HDMI/DP,pcm=8 as 
/devices/pci0000:00/0000:00:08.1/0000:0d:00.1/sound/card0/input16
[   14.643791] intel_rapl_common: Found RAPL domain package
[   14.643805] intel_rapl_common: Found RAPL domain core
[   14.658267] Btrfs loaded, experimental=on, debug=on, assert=on, 
zoned=yes, fsverity=yes
[   14.658923] BTRFS: device label 6.17_RST_TEST devid 2 transid 475 
/dev/sdb (8:16) scanned by (udev-worker) (519)
[   14.658959] BTRFS: device label 6.17_RST_TEST devid 1 transid 475 
/dev/sda (8:0) scanned by (udev-worker) (510)
[   14.704509] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com 
for information.
[   14.704520] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld 
<Jason@zx2c4.com>. All Rights Reserved.
[   14.725281] amd_atl: AMD Address Translation Library initialized
[   14.765382] Generic FE-GE Realtek PHY r8169-0-700:00: attached PHY 
driver (mii_bus:phy_addr=r8169-0-700:00, irq=MAC)
[   14.922471] r8169 0000:07:00.0 ethob: Link is Down
[   15.181575] BTRFS info (device sda): first mount of filesystem 
c3b4520d-ea9c-4ac2-9cbd-2c8820346809
[   15.181593] BTRFS info (device sda): using crc32c (crc32c-lib) 
checksum algorithm
[   15.190970] BTRFS: device label DATA2 devid 1 transid 13015 /dev/sdd 
(8:48) scanned by mount (643)
[   15.194373] BTRFS: device fsid ba54f121-eb78-4af4-8a33-4764db37c0fa 
devid 1 transid 5138 /dev/nvme0n1p4 (259:8) scanned by mount (645)
[   15.194756] BTRFS info (device sdd): first mount of filesystem 
6a75f34b-1b2e-40f5-87ef-d83d980148b8
[   15.194771] BTRFS info (device sdd): using crc32c (crc32c-lib) 
checksum algorithm
[   15.246690] BTRFS: device label DATA4 devid 1 transid 8201 /dev/sdc 
(8:32) scanned by mount (644)
[   15.247134] BTRFS info (device sdc): first mount of filesystem 
2662c5a3-eac0-477a-a82a-b298a16dae02
[   15.247150] BTRFS info (device sdc): using crc32c (crc32c-lib) 
checksum algorithm
[   15.247231] BTRFS info (device nvme0n1p4): first mount of filesystem 
ba54f121-eb78-4af4-8a33-4764db37c0fa
[   15.247244] BTRFS info (device nvme0n1p4): using crc32c (crc32c-lib) 
checksum algorithm
[   15.318377] BTRFS info (device sda): host-managed zoned block device 
/dev/sda, 52156 zones of 268435456 bytes
[   15.335451] BTRFS info (device sda): host-managed zoned block device 
/dev/sdb, 52156 zones of 268435456 bytes
[   15.437485] BTRFS info (device sda): zoned mode enabled with zone 
size 268435456
[   15.462812] BTRFS info (device nvme0n1p4): enabling ssd optimizations
[   15.462820] BTRFS info (device nvme0n1p4): turning on async discard
[   15.462823] BTRFS info (device nvme0n1p4): enabling free space tree
[   15.631507] BTRFS info (device sdd): host-managed zoned block device 
/dev/sdd, 52156 zones of 268435456 bytes
[   15.830534] BTRFS info (device sdc): host-managed zoned block device 
/dev/sdc, 52156 zones of 268435456 bytes
[   17.064382] BTRFS info (device sda): checking UUID tree
[   17.064456] BTRFS info (device sda): enabling free space tree
[   17.114998] BTRFS info (device sdd): zoned mode enabled with zone 
size 268435456
[   17.637690] BTRFS info (device sdc): zoned mode enabled with zone 
size 268435456
[   17.918346] r8169 0000:07:00.0 ethob: Link is Up - 1Gbps/Full - flow 
control off
[   19.569125] BTRFS info (device sdd): checking UUID tree
[   19.569213] BTRFS info (device sdd): enabling free space tree
[   19.816799] BTRFS info (device sdc): checking UUID tree
[   19.816877] BTRFS info (device sdc): enabling free space tree
[   37.459961] BTRFS info (device sda): scrub: started on devid 2
[   37.475639] BTRFS info (device sda): scrub: started on devid 1
[  112.125457] BTRFS info (device sdd): scrub: started on devid 1
[  115.629237] BTRFS info (device sdc): scrub: started on devid 1
[  246.876480] INFO: task btrfs-transacti:772 blocked for more than 122 
seconds.
[  246.876553]       Tainted: G            E 
6.19.0-rc4-btrfs-test-dirty #15
[  246.876602] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  246.876640] task:btrfs-transacti state:D stack:0     pid:772 
tgid:772   ppid:2      task_flags:0x208040 flags:0x00080000
[  246.876656] Call Trace:
[  246.876662]  <TASK>
[  246.876674]  __schedule+0x41a/0x16d0
[  246.876693]  ? __btrfs_run_delayed_refs+0xe78/0xf80 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.876921]  schedule+0x27/0xd0
[  246.876932]  schedule_preempt_disabled+0x15/0x30
[  246.876942]  __mutex_lock.constprop.0+0x527/0xa60
[  246.876963]  btrfs_commit_transaction+0xa0/0xd70 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.877192]  ? btrfs_init_metadata_block_rsv+0x28/0x40 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.877467]  ? srso_return_thunk+0x5/0x5f
[  246.877480]  ? start_transaction+0x228/0x830 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.877711]  transaction_kthread+0x157/0x1c0 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.877935]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.878154]  kthread+0xfc/0x240
[  246.878166]  ? __pfx_kthread+0x10/0x10
[  246.878177]  ret_from_fork+0x243/0x280
[  246.878189]  ? __pfx_kthread+0x10/0x10
[  246.878198]  ret_from_fork_asm+0x1a/0x30
[  246.878220]  </TASK>
[  246.878248] INFO: task btrfs-transacti:772 is blocked on a mutex 
likely owned by task btrfs:877.
[  246.878292] INFO: task btrfs:876 blocked for more than 122 seconds.
[  246.878326]       Tainted: G            E 
6.19.0-rc4-btrfs-test-dirty #15
[  246.878362] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  246.878408] task:btrfs           state:D stack:0     pid:876 
tgid:875   ppid:1      task_flags:0x440140 flags:0x00080000
[  246.878422] Call Trace:
[  246.878427]  <TASK>
[  246.878435]  __schedule+0x41a/0x16d0
[  246.878456]  schedule+0x27/0xd0
[  246.878465]  schedule_preempt_disabled+0x15/0x30
[  246.878474]  __mutex_lock.constprop.0+0x527/0xa60
[  246.878485]  ? btrfs_init_metadata_block_rsv+0x28/0x40 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.878722]  btrfs_inc_block_group_ro+0x7c/0x240 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.878944]  scrub_enumerate_chunks+0x266/0x710 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.879209]  ? srso_return_thunk+0x5/0x5f
[  246.879227]  btrfs_scrub_dev+0x24c/0x690 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.879473]  btrfs_ioctl+0xdd8/0x2d10 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.879708]  ? srso_return_thunk+0x5/0x5f
[  246.879719]  ? __do_sys_ioprio_set+0x83/0x2f0
[  246.879734]  ? srso_return_thunk+0x5/0x5f
[  246.879744]  ? do_syscall_64+0x81/0x610
[  246.879758]  __x64_sys_ioctl+0x97/0xe0
[  246.879771]  do_syscall_64+0x81/0x610
[  246.879786]  ? srso_return_thunk+0x5/0x5f
[  246.879797]  ? srso_return_thunk+0x5/0x5f
[  246.879806]  ? set_pte_range+0x112/0x2c0
[  246.879816]  ? srso_return_thunk+0x5/0x5f
[  246.879827]  ? next_uptodate_folio+0x89/0x2a0
[  246.879841]  ? srso_return_thunk+0x5/0x5f
[  246.879852]  ? filemap_map_pages+0x4ee/0x770
[  246.879865]  ? __alloc_frozen_pages_noprof+0x192/0x350
[  246.879897]  ? srso_return_thunk+0x5/0x5f
[  246.879908]  ? do_fault+0x367/0x600
[  246.879918]  ? srso_return_thunk+0x5/0x5f
[  246.879929]  ? srso_return_thunk+0x5/0x5f
[  246.879938]  ? __handle_mm_fault+0x941/0xf60
[  246.879959]  ? srso_return_thunk+0x5/0x5f
[  246.879968]  ? count_memcg_events+0xc2/0x170
[  246.879980]  ? srso_return_thunk+0x5/0x5f
[  246.879989]  ? handle_mm_fault+0x1d7/0x2d0
[  246.880001]  ? srso_return_thunk+0x5/0x5f
[  246.880010]  ? do_user_addr_fault+0x21a/0x690
[  246.880025]  ? srso_return_thunk+0x5/0x5f
[  246.880034]  ? exc_page_fault+0x7e/0x1a0
[  246.880045]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  246.880055] RIP: 0033:0x7fcf0591670d
[  246.880063] RSP: 002b:00007fcf057fec10 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  246.880075] RAX: ffffffffffffffda RBX: 000055e1796d0370 RCX: 
00007fcf0591670d
[  246.880081] RDX: 000055e1796d0370 RSI: 00000000c400941b RDI: 
0000000000000003
[  246.880087] RBP: 00007fcf057fec60 R08: 0000000000000020 R09: 
38203a6b63617473
[  246.880093] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007fcf057ff6c0
[  246.880099] R13: 00007ffdcd8e3e70 R14: 00007fcf057ffce4 R15: 
00007ffdcd8e3f77
[  246.880117]  </TASK>
[  246.880147] INFO: task btrfs:876 is blocked on a mutex likely owned 
by task btrfs:877.
[  246.880187] INFO: task btrfs:877 blocked for more than 122 seconds.
[  246.880219]       Tainted: G            E 
6.19.0-rc4-btrfs-test-dirty #15
[  246.880254] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  246.880289] task:btrfs           state:D stack:0     pid:877 
tgid:875   ppid:1      task_flags:0x440140 flags:0x00080000
[  246.880302] Call Trace:
[  246.880307]  <TASK>
[  246.880315]  __schedule+0x41a/0x16d0
[  246.880324]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  246.880343]  schedule+0x27/0xd0
[  246.880352]  schedule_preempt_disabled+0x15/0x30
[  246.880361]  __mutex_lock.constprop.0+0x527/0xa60
[  246.880381]  btrfs_inc_block_group_ro+0x7c/0x240 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.880614]  do_zone_finish+0x81/0x430 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.880819]  btrfs_zone_finish_one_bg+0xfd/0x130 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.881018]  btrfs_zoned_activate_one_bg+0x12f/0x160 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.881217]  reserve_chunk_space+0xe0/0x170 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.881444]  btrfs_inc_block_group_ro+0x223/0x240 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.881658]  scrub_enumerate_chunks+0x266/0x710 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.881894]  btrfs_scrub_dev+0x24c/0x690 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.882128]  btrfs_ioctl+0xdd8/0x2d10 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  246.882361]  ? ___pte_offset_map+0x1b/0x100
[  246.882371]  ? sysvec_apic_timer_interrupt+0xe/0x90
[  246.882381]  ? srso_return_thunk+0x5/0x5f
[  246.882400]  ? srso_return_thunk+0x5/0x5f
[  246.882409]  ? do_syscall_64+0x81/0x610
[  246.882418]  ? srso_return_thunk+0x5/0x5f
[  246.882427]  ? exit_to_user_mode_loop+0x302/0x4b0
[  246.882441]  ? srso_return_thunk+0x5/0x5f
[  246.882454]  __x64_sys_ioctl+0x97/0xe0
[  246.882466]  do_syscall_64+0x81/0x610
[  246.882477]  ? srso_return_thunk+0x5/0x5f
[  246.882486]  ? _copy_from_user+0x27/0x60
[  246.882495]  ? srso_return_thunk+0x5/0x5f
[  246.882504]  ? __x64_sys_rt_sigprocmask+0xe7/0x160
[  246.882519]  ? srso_return_thunk+0x5/0x5f
[  246.882528]  ? do_syscall_64+0x81/0x610
[  246.882536]  ? srso_return_thunk+0x5/0x5f
[  246.882545]  ? irqentry_exit+0x2c3/0x5e0
[  246.882554]  ? srso_return_thunk+0x5/0x5f
[  246.882563]  ? exc_page_fault+0x7e/0x1a0
[  246.882574]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  246.882582] RIP: 0033:0x7fcf0591670d
[  246.882589] RSP: 002b:00007fcf04ffdc10 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  246.882599] RAX: ffffffffffffffda RBX: 000055e1796d0800 RCX: 
00007fcf0591670d
[  246.882605] RDX: 000055e1796d0800 RSI: 00000000c400941b RDI: 
0000000000000003
[  246.882611] RBP: 00007fcf04ffdc60 R08: 0000000000000020 R09: 
38203a6b63617473
[  246.882617] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007fcf04ffe6c0
[  246.882622] R13: 00007ffdcd8e3e70 R14: 00007fcf04ffece4 R15: 
00007ffdcd8e3f77
[  246.882640]  </TASK>
[  246.882666] INFO: task btrfs:877 is blocked on a mutex likely owned 
by task btrfs:877.
[  369.755498] INFO: task btrfs-transacti:772 blocked for more than 245 
seconds.
[  369.755618]       Tainted: G            E 
6.19.0-rc4-btrfs-test-dirty #15
[  369.755676] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  369.755714] task:btrfs-transacti state:D stack:0     pid:772 
tgid:772   ppid:2      task_flags:0x208040 flags:0x00080000
[  369.755730] Call Trace:
[  369.755736]  <TASK>
[  369.755748]  __schedule+0x41a/0x16d0
[  369.755784]  ? __btrfs_run_delayed_refs+0xe78/0xf80 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.756015]  schedule+0x27/0xd0
[  369.756025]  schedule_preempt_disabled+0x15/0x30
[  369.756035]  __mutex_lock.constprop.0+0x527/0xa60
[  369.756057]  btrfs_commit_transaction+0xa0/0xd70 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.756310]  ? btrfs_init_metadata_block_rsv+0x28/0x40 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.756558]  ? srso_return_thunk+0x5/0x5f
[  369.756571]  ? start_transaction+0x228/0x830 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.756800]  transaction_kthread+0x157/0x1c0 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.757074]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.757338]  kthread+0xfc/0x240
[  369.757350]  ? __pfx_kthread+0x10/0x10
[  369.757360]  ret_from_fork+0x243/0x280
[  369.757372]  ? __pfx_kthread+0x10/0x10
[  369.757381]  ret_from_fork_asm+0x1a/0x30
[  369.757415]  </TASK>
[  369.757456] INFO: task btrfs-transacti:772 is blocked on a mutex 
likely owned by task btrfs:877.
[  369.757502] INFO: task btrfs:876 blocked for more than 245 seconds.
[  369.757536]       Tainted: G            E 
6.19.0-rc4-btrfs-test-dirty #15
[  369.757571] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  369.757606] task:btrfs           state:D stack:0     pid:876 
tgid:875   ppid:1      task_flags:0x440140 flags:0x00080000
[  369.757620] Call Trace:
[  369.757625]  <TASK>
[  369.757634]  __schedule+0x41a/0x16d0
[  369.757654]  schedule+0x27/0xd0
[  369.757663]  schedule_preempt_disabled+0x15/0x30
[  369.757672]  __mutex_lock.constprop.0+0x527/0xa60
[  369.757684]  ? btrfs_init_metadata_block_rsv+0x28/0x40 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.757921]  btrfs_inc_block_group_ro+0x7c/0x240 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.758169]  scrub_enumerate_chunks+0x266/0x710 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.758429]  ? srso_return_thunk+0x5/0x5f
[  369.758448]  btrfs_scrub_dev+0x24c/0x690 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.758684]  btrfs_ioctl+0xdd8/0x2d10 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.758937]  ? srso_return_thunk+0x5/0x5f
[  369.758948]  ? __do_sys_ioprio_set+0x83/0x2f0
[  369.758964]  ? srso_return_thunk+0x5/0x5f
[  369.758973]  ? do_syscall_64+0x81/0x610
[  369.758988]  __x64_sys_ioctl+0x97/0xe0
[  369.759002]  do_syscall_64+0x81/0x610
[  369.759017]  ? srso_return_thunk+0x5/0x5f
[  369.759027]  ? srso_return_thunk+0x5/0x5f
[  369.759037]  ? set_pte_range+0x112/0x2c0
[  369.759047]  ? srso_return_thunk+0x5/0x5f
[  369.759056]  ? next_uptodate_folio+0x89/0x2a0
[  369.759069]  ? srso_return_thunk+0x5/0x5f
[  369.759078]  ? filemap_map_pages+0x4ee/0x770
[  369.759088]  ? __alloc_frozen_pages_noprof+0x192/0x350
[  369.759112]  ? srso_return_thunk+0x5/0x5f
[  369.759122]  ? do_fault+0x367/0x600
[  369.759132]  ? srso_return_thunk+0x5/0x5f
[  369.759142]  ? srso_return_thunk+0x5/0x5f
[  369.759152]  ? __handle_mm_fault+0x941/0xf60
[  369.759173]  ? srso_return_thunk+0x5/0x5f
[  369.759182]  ? count_memcg_events+0xc2/0x170
[  369.759194]  ? srso_return_thunk+0x5/0x5f
[  369.759203]  ? handle_mm_fault+0x1d7/0x2d0
[  369.759215]  ? srso_return_thunk+0x5/0x5f
[  369.759224]  ? do_user_addr_fault+0x21a/0x690
[  369.759239]  ? srso_return_thunk+0x5/0x5f
[  369.759248]  ? exc_page_fault+0x7e/0x1a0
[  369.759259]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  369.759269] RIP: 0033:0x7fcf0591670d
[  369.759278] RSP: 002b:00007fcf057fec10 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  369.759289] RAX: ffffffffffffffda RBX: 000055e1796d0370 RCX: 
00007fcf0591670d
[  369.759296] RDX: 000055e1796d0370 RSI: 00000000c400941b RDI: 
0000000000000003
[  369.759302] RBP: 00007fcf057fec60 R08: 0000000000000020 R09: 
38203a6b63617473
[  369.759308] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007fcf057ff6c0
[  369.759314] R13: 00007ffdcd8e3e70 R14: 00007fcf057ffce4 R15: 
00007ffdcd8e3f77
[  369.759332]  </TASK>
[  369.759364] INFO: task btrfs:876 is blocked on a mutex likely owned 
by task btrfs:877.
[  369.759417] INFO: task btrfs:877 blocked for more than 245 seconds.
[  369.759451]       Tainted: G            E 
6.19.0-rc4-btrfs-test-dirty #15
[  369.759485] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  369.759520] task:btrfs           state:D stack:0     pid:877 
tgid:875   ppid:1      task_flags:0x440140 flags:0x00080000
[  369.759533] Call Trace:
[  369.759538]  <TASK>
[  369.759546]  __schedule+0x41a/0x16d0
[  369.759556]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  369.759575]  schedule+0x27/0xd0
[  369.759584]  schedule_preempt_disabled+0x15/0x30
[  369.759593]  __mutex_lock.constprop.0+0x527/0xa60
[  369.759613]  btrfs_inc_block_group_ro+0x7c/0x240 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.759861]  do_zone_finish+0x81/0x430 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.760067]  btrfs_zone_finish_one_bg+0xfd/0x130 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.760266]  btrfs_zoned_activate_one_bg+0x12f/0x160 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.760476]  reserve_chunk_space+0xe0/0x170 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.760708]  btrfs_inc_block_group_ro+0x223/0x240 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.760950]  scrub_enumerate_chunks+0x266/0x710 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.761187]  btrfs_scrub_dev+0x24c/0x690 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.761433]  btrfs_ioctl+0xdd8/0x2d10 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.761665]  ? ___pte_offset_map+0x1b/0x100
[  369.761676]  ? sysvec_apic_timer_interrupt+0xe/0x90
[  369.761686]  ? srso_return_thunk+0x5/0x5f
[  369.761696]  ? srso_return_thunk+0x5/0x5f
[  369.761705]  ? do_syscall_64+0x81/0x610
[  369.761714]  ? srso_return_thunk+0x5/0x5f
[  369.761723]  ? exit_to_user_mode_loop+0x302/0x4b0
[  369.761737]  ? srso_return_thunk+0x5/0x5f
[  369.761750]  __x64_sys_ioctl+0x97/0xe0
[  369.761762]  do_syscall_64+0x81/0x610
[  369.761773]  ? srso_return_thunk+0x5/0x5f
[  369.761782]  ? _copy_from_user+0x27/0x60
[  369.761791]  ? srso_return_thunk+0x5/0x5f
[  369.761800]  ? __x64_sys_rt_sigprocmask+0xe7/0x160
[  369.761815]  ? srso_return_thunk+0x5/0x5f
[  369.761824]  ? do_syscall_64+0x81/0x610
[  369.761832]  ? srso_return_thunk+0x5/0x5f
[  369.761841]  ? irqentry_exit+0x2c3/0x5e0
[  369.761850]  ? srso_return_thunk+0x5/0x5f
[  369.761859]  ? exc_page_fault+0x7e/0x1a0
[  369.761870]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  369.761878] RIP: 0033:0x7fcf0591670d
[  369.761886] RSP: 002b:00007fcf04ffdc10 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  369.761896] RAX: ffffffffffffffda RBX: 000055e1796d0800 RCX: 
00007fcf0591670d
[  369.761902] RDX: 000055e1796d0800 RSI: 00000000c400941b RDI: 
0000000000000003
[  369.761907] RBP: 00007fcf04ffdc60 R08: 0000000000000020 R09: 
38203a6b63617473
[  369.761913] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007fcf04ffe6c0
[  369.761918] R13: 00007ffdcd8e3e70 R14: 00007fcf04ffece4 R15: 
00007ffdcd8e3f77
[  369.761936]  </TASK>
[  369.761964] INFO: task btrfs:877 is blocked on a mutex likely owned 
by task btrfs:877.
[  369.762006] INFO: task vim:1205 blocked for more than 122 seconds.
[  369.762038]       Tainted: G            E 
6.19.0-rc4-btrfs-test-dirty #15
[  369.762073] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  369.762107] task:vim             state:D stack:0     pid:1205 
tgid:1205  ppid:822    task_flags:0x400000 flags:0x00080002
[  369.762119] Call Trace:
[  369.762124]  <TASK>
[  369.762132]  __schedule+0x41a/0x16d0
[  369.762152]  schedule+0x27/0xd0
[  369.762161]  schedule_preempt_disabled+0x15/0x30
[  369.762170]  __mutex_lock.constprop.0+0x527/0xa60
[  369.762191]  btrfs_chunk_alloc+0x11c/0x620 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.762416]  find_free_extent+0xad1/0x1960 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.762640]  ? srso_return_thunk+0x5/0x5f
[  369.762654]  ? btrfs_reduce_alloc_profile+0x93/0x1a0 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.762857]  btrfs_reserve_extent+0x13a/0x2b0 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.763020]  btrfs_alloc_tree_block+0xc1/0x600 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.763172]  ? __kmalloc_cache_noprof+0x162/0x5b0
[  369.763179]  ? srso_return_thunk+0x5/0x5f
[  369.763185]  ? __kmalloc_cache_noprof+0x162/0x5b0
[  369.763195]  btrfs_alloc_log_tree_node+0x32/0x70 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.763331]  btrfs_add_log_tree+0x75/0x140 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.763471]  btrfs_log_inode_parent+0x6f4/0xcd0 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.763614]  ? srso_return_thunk+0x5/0x5f
[  369.763620]  ? kmem_cache_alloc_noprof+0x156/0x5e0
[  369.763627]  ? srso_return_thunk+0x5/0x5f
[  369.763633]  ? wait_current_trans+0x2c/0x170 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.763766]  ? srso_return_thunk+0x5/0x5f
[  369.763773]  ? join_transaction+0x13c/0x420 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.763906]  ? srso_return_thunk+0x5/0x5f
[  369.763912]  ? btrfs_init_metadata_block_rsv+0x28/0x40 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.764044]  ? srso_return_thunk+0x5/0x5f
[  369.764051]  ? start_transaction+0x228/0x830 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.764187]  btrfs_log_dentry_safe+0x3e/0x60 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.764329]  btrfs_sync_file+0x37d/0x560 [btrfs 
baccf26ae5d5cb9debb29275b7601f927e8719f7]
[  369.764433]  do_fsync+0x3b/0x80
[  369.764438]  ? srso_return_thunk+0x5/0x5f
[  369.764443]  __x64_sys_fsync+0x13/0x20
[  369.764447]  do_syscall_64+0x81/0x610
[  369.764450]  ? __vfs_getxattr+0x83/0xb0
[  369.764457]  ? do_truncate+0xc2/0xf0
[  369.764461]  ? srso_return_thunk+0x5/0x5f
[  369.764465]  ? do_truncate+0xd6/0xf0
[  369.764471]  ? srso_return_thunk+0x5/0x5f
[  369.764475]  ? do_ftruncate+0x126/0x1f0
[  369.764480]  ? srso_return_thunk+0x5/0x5f
[  369.764484]  ? do_sys_ftruncate+0x62/0x80
[  369.764489]  ? srso_return_thunk+0x5/0x5f
[  369.764492]  ? srso_return_thunk+0x5/0x5f
[  369.764496]  ? do_syscall_64+0x81/0x610
[  369.764502]  ? srso_return_thunk+0x5/0x5f
[  369.764505]  ? __do_sys_getcwd+0x149/0x1d0
[  369.764512]  ? srso_return_thunk+0x5/0x5f
[  369.764516]  ? do_syscall_64+0x81/0x610
[  369.764520]  ? srso_return_thunk+0x5/0x5f
[  369.764524]  ? __irq_exit_rcu+0x4c/0xf0
[  369.764529]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  369.764533] RIP: 0033:0x7f081bc9f002
[  369.764536] RSP: 002b:00007fffd63973c8 EFLAGS: 00000246 ORIG_RAX: 
000000000000004a
[  369.764540] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f081bc9f002
[  369.764542] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000004
[  369.764544] RBP: 00007fffd63973f0 R08: 0000000000000000 R09: 
0000000000000000
[  369.764546] R10: 0000000000000000 R11: 0000000000000246 R12: 
000055937a31e460
[  369.764549] R13: 0000000000000000 R14: 0000000000000004 R15: 
0000000000002000
[  369.764556]  </TASK>
[  369.764573] INFO: task vim:1205 is blocked on a mutex likely owned by 
task btrfs:877.


