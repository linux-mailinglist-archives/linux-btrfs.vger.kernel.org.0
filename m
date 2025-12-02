Return-Path: <linux-btrfs+bounces-19461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CEC9BEB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 16:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89756348584
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92B252292;
	Tue,  2 Dec 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="vXdB7s4x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C937DA66
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688618; cv=none; b=RT9G2urihE/Yw12045bPaqDdpm8OkiaoFTJnOm1wUNzcBMERSnHjI5Cb4bIO4ubc/cWh/DZ5zQqiU6D2gd+RjC1NgSSwqpzUD9D8XOhL43TaquuUe5kcLq7vi0aI64NFQSO/bzF563IGVPoTVCAyo8yNHu3OkoQ5ljyj7AumQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688618; c=relaxed/simple;
	bh=RYvHFCEHYFyUTDhTObt7ymnmaf08yLak542VinEypis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dCE/8K+hGBl2WXS8sYnb3zkRkO9B2o8pMnYB8VNGA2jg+vGViHydg/LDXFgz3ROZJzV9Lm7l/7RKXsL1K4PiaiXxpnqpjy+DKsev2gyB0Hd6etwK1Y6rmIoGn26tCquJvjeZOLEXdTtD3L0t9RAIZeK5C0DHkejZNvqMgIf/rAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=vXdB7s4x; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1764688607;
	bh=nRMsO8V3i0JlFbvF7f3gQHsSv7bbVpi1gOFHqHqxjBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=vXdB7s4xS04/zzg6zADagbirOUcQVrkVxnAZqkTRysT71DzER97dJESnvFyw+cUD6
	 k9uH2BMU3GYmdK+gqXjHo80IJLo174Q54pbCm/pw2w24osyIwf1PSE9Wgdqx05up7M
	 1NFmmJkwmSRntJcbSIKcgQElrFjq4JjDjjCP7ulM=
X-QQ-mid: zesmtpgz3t1764688603tf0f0cd2f
X-QQ-Originating-IP: Vb/l6eRAX3q6qPr6gj1pR1p4f6UDrIbr8oBJzIjmidg=
Received: from [198.18.0.1] ( [123.134.104.238])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Dec 2025 23:16:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8019220805694550285
Message-ID: <92785CEDF310B353+14512df2-8c80-4a0d-920e-df428c87c5c5@bupt.moe>
Date: Tue, 2 Dec 2025 23:16:44 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
To: Naohiro Aota <Naohiro.Aota@wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <DENLBYCUSKZP.13MWTQQNEAUBW@wdc.com>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <DENLBYCUSKZP.13MWTQQNEAUBW@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OccmtviHNKX2VVC0iF37qqaMG+eHBIS8dvCNzkOimdr/CM1gYEfy4sht
	gSmUe4xD7ihI8POWCfKxX09V9qY0OxsNnQFwQLrBD7bdSv48NQVEsftMPrQjI9egqVDmyD8
	UvzMnmSvmJ1aO/jcLtRwsp6vauzwJjoZ++8/PfNWz6iFPD1zekmSuXDeuDGvsWygOZJGY07
	Ja1QRo52L31YNnZ4qk36cDDbvqgUGJNIgQ/y0WePT7BxTcCsf5Ds4ch8V6BhBxOtlpDYB7q
	g4quG6aehSoUgPpgEf1UxT1+krgU5ipqhwsrMeO5I1hWmqdVkTf2pAmL54apMCXtU/dXwpK
	KsKtI6787OXSFPv28EAVIRy1JHacleJK+g7cDxZ/hP6CXY4hSmmjXFeIsL61MZ1aCDbN+OB
	t/eb3KsAlLw2mt9tVIeexbHnvV2kJVk8m5y4BgOPTZ2P8xBAN7IkP50QMKWcDLkBV5RmsYe
	5SK3LhZVO/bNwYxoRKOSxFMv8P2aCcC4Zxk93IkeLcWnwNGN5elgg4u+zVVPhE5+sG9OHJx
	EF28a3YZPXDnofqbrx7wrHaQnF8okiByzdnX/RrznHkord2NA38F/PJErLS16ojlAj8gqyt
	JVQKcKosiVj6fzTRQR+az2R+xNLrd6z5ni8lBXnQHLYf+/uVQ2jbYY+52hmOYq5C6B8xMsk
	cRzVvY83lpq97sVe2Vx1d/cXlBrvdIN3Y0LH1t+1zmUTfNCg/38/J697vkCAYOgXPJ7c6kq
	Ezcle8YmjLRuNPYr0eV1tGhvGGGuHt9m/16S6RLEqgkp35ONymuPj2Uyz/0l3hMOCllSqR/
	gvOOrA5mBhccFdXuSsF7QFdt9wudH0XwIrotRqhYLkivOj22i9sntvTqDMBrVAZhKD/nMUT
	nsVtcAbC6JBWEyQSSHlPVd9g63VtpS5YXWgqcShmF2kt4oczjpSZKbIfhGyVIEp/vHby9Gk
	IgrmL1L1arMav6LxCA29nhYrhOSNbGh6ve14=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

在 2025/12/2 16:33, Naohiro Aota 写道:
> On Sat Nov 29, 2025 at 12:38 AM JST, HAN Yuwei wrote:
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
>>>
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
>>>         grep -A 7 -E "CHUNK_ITEM 1496796102656" |\
>>>
>>>         grep "\bstripe\b"
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
>>>                                         grep -A7 -E "CHUNK_ITEM
>>> 2147483648" | \
>>>
>>>                                        grep "\bstripe\b"
>>>                stripe 0 devid 1 offset 2147483648
>>>                stripe 1 devid 2 offset 1073741824
>>>
>>> root@virtme-ng:/# blkzone report -c 1 -o $((2147483648 / 512)) /dev/vda
>>>      start: 0x000400000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>>
>>> root@virtme-ng:/# blkzone report -c 1 -o $((1073741824 / 512)) /dev/vdb
>>>      start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
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
>>       stripe 0 devid 2 offset 374467461120
>>       stripe 1 devid 1 offset 1342177280
>> # blkzone report -c 1 -o "731381760" /dev/sda
>>     start: 0x02b980000, len 0x080000, cap 0x080000, wptr 0x07ff80 reset:0
>> non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
>> # blkzone report -c 1 -o "2621440" /dev/sdb
>>     start: 0x000280000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>> non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
> 
> Could I also have the last extent of the chunk, please? You can see that
> with the following command:
> 
> btrfs inspect-internal dump-tree -t extent /dev/sda |\
> grep -B 4 -A 1 -E "1496796102656 BLOCK_GROUP_ITEM"
> 
"-t extent" seems filtered out what your need. I have done this:
# btrfs inspect-internal dump-tree /dev/sda |grep -B 4 -A 1 -E 
"1496796102656 BLOCK_GROUP_ITEM"
         item 201 key (1495453925376 BLOCK_GROUP_ITEM 268435456) itemoff 
11435 itemsize 24
                 block group used 268435456 chunk_objectid 256 flags 
DATA|single
         item 202 key (1496527667200 BLOCK_GROUP_ITEM 268435456) itemoff 
11411 itemsize 24
                 block group used 0 chunk_objectid 256 flags DATA|single
         item 203 key (1496796102656 BLOCK_GROUP_ITEM 268435456) itemoff 
11387 itemsize 24
                 block group used 0 chunk_objectid 256 flags METADATA|RAID1

>>
>> seems like they have distributed to different type of zones. Should I do
>> bisect to pin the commit?
>>
>> HAN Yuwei


