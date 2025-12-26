Return-Path: <linux-btrfs+bounces-20008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745BACDE3A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 03:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF68300A1C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4C238C0B;
	Fri, 26 Dec 2025 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="QbvGpArn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373072040B6
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715509; cv=none; b=n0oncCFJ2eNVsFggonwO9FcVUxv7C/0FTV6eGqgoCwoyMPjxW1bGV8MZY9qXjee5xR1TeRXbe96v1gSKVlLEmKG1IYIKMk9vhlwS+cYPFOkM8QTXbnfXIXh1tv3YsD0Tl/zcPDZ9VGkz1W5WAxW+/QoycblZ3sBuwkBeMiADUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715509; c=relaxed/simple;
	bh=ioDX3ES2UU3LS7Pjq9JGwvjyqM9iBseoZbHEUWR0A0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuwQmGtAMlInJZRK1tLjbfXc5k1ExBDI/viN/hpGTYBmOwRiXOLzkPEJ/EyR2sIsuO9x/cOHExW0VYeA87laWbqnM4LoNgv7qLDIkpNRyY60vYXwPRNjaeY+5D5JzuCD/4w/yabsXuFizTbv/CXG+0X4sWsrCJNa/QO+OmknEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=QbvGpArn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1766715500;
	bh=mB22XSifviiWhZIXOO9wpEP3HWeZ+z9Fw4yLEpV/46I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QbvGpArnPpL+PlEQG9vAhRTFvWBr05oWMCDksOPls8cNBhlOsQZEV4JmtBTc92GWf
	 QE4F0XdITPY5pkFHm/P4+EGsnzQurAymxeVIc9wrwsPwB6gmkX8uwfLOltk3d+FykX
	 jwwqxZpqxXBcKxQ3o/wYfu8z9zAb/tSovDeYpE3w=
X-QQ-mid: zesmtpsz8t1766715495t221a21ca
X-QQ-Originating-IP: /mMGxtDY6JdmHkN6MCvsyOoTWNDST0pzUn+RO6EodFY=
Received: from [198.18.0.1] ( [123.134.105.92])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Dec 2025 10:18:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17625004940546056218
Message-ID: <36718DD03AD165EF+c4b42ca9-02f2-41e9-9c43-1ff360a6e73e@bupt.moe>
Date: Fri, 26 Dec 2025 10:18:19 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
To: linux-btrfs <linux-btrfs@vger.kernel.org>,
 Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
 <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
 <99066be8-992b-4476-9a22-8c1ff6f5cff2@wdc.com>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <99066be8-992b-4476-9a22-8c1ff6f5cff2@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NLIB+vaC3XIAr6tR7oTQruaXSRqNf7e7X0MLpdTuCEdCly51UNrmUkKZ
	paIRW6IJ8pZJM+d1Ycb7kGoFNTaA/+HXHHscHZpYJN6eH6ll4ekaj9OgFLEG16cSE1QmaG2
	0R4Yo+BzRJ6cw2WY1LUcYv3h4bQ5jonpg8yQV+EUTn0C5bpPggwocBQzSDfESvyFii8DQwh
	J9OjnFM+gS8dlkxS7TjcrxFIPncTbGfvGhX7Jy47FkYQi2fNIyJKuEmIyxbrdbGkJ74eztH
	88F5BAZtNGQa2kzJIVEHcmHXo1BmQUWk50AvE+fwt00vbMGWkDCARfTZNLrzCn6sfTNxnaY
	Ipj5Hl+XIbbye/C4mZaaq8TMoibGVchIZt8CZIkemsCDU2IwUSny0P5y5qqqKeqSxAahmgq
	8ny4BLtOpphxu02sgPFXAA32jRse9AGfE8eu2WXZrPNJY5VdevWwk+xjvJgafTnIUUXmfip
	mtCEh+fSU5KjvQ4EeFLMJ54yEdWpFhLXVxRYHydkuGn+Ylmtifqf0shtfKvmtsIgX+acLeI
	vzKbIEz58pP/foqouy5TMlzh7tnBxHm99Krmp9KuQeVGmNn2VTqQkL5zjD0OmTV1iIixjF5
	71b8yyPnG7OWArOObUehYAuyzeVa7lfJopWBDetwhNVLlq/5ZpcX5sAOgsxMYrsiFhsYSmP
	Z866MC5TiadtnhAJGKxNIXC6iPr9LhyPwqyzqF2vC9zJku3TA34c2+twazP1RiofASe1fCM
	xy4IZG8WFprT0riW+WJ5nijLkmBzX4AWnQnOivdeyBeazZqogfE+eqwNjnadyxtEZMAsyEN
	Q+RUCyJJHaqOQQL3HlVG++0jCQEWSHOvQ41TddUcYRMCxGcCxwcJr2rImAfRrNx+cBYnvig
	IoViZJKo4N5vfWI48pq8qM065qBVKcoevxsBK+V3yb2GqrdQzmsJ6UZiWHDgqQV3Yxaixci
	LNX2Oeiky1Lx/JKOF4LhaimgBdW5wWiOpIcI=
X-QQ-XMRINFO: Mp0Kj//9VHAxHBpkON4h1QbhVf4GKSqarA==
X-QQ-RECHKSPAM: 0

在 2025/12/10 10:35, Johannes Thumshirn 写道:
> On 12/9/25 2:35 PM, HAN Yuwei wrote:
>> 在 2025/12/1 14:30, Johannes Thumshirn 写道:
>>> On 11/28/25 4:38 PM, HAN Yuwei wrote:
>>>> 在 2025/11/28 23:03, Johannes Thumshirn 写道:
>>>>> On 11/28/25 12:36 PM, HAN Yuwei wrote:
>>>>>> /dev/sdd, 52156 zones of 268435456 bytes
>>>>>> [   19.757242] BTRFS info (device sda): host-managed zoned block device
>>>>>> /dev/sdb, 52156 zones of 268435456 bytes
>>>>>> [   19.868623] BTRFS info (device sda): zoned mode enabled with zone
>>>>>> size 268435456
>>>>>> [   20.940894] BTRFS info (device sdd): zoned mode enabled with zone
>>>>>> size 268435456
>>>>>> [   21.101010] r8169 0000:07:00.0 ethob: Link is Up - 1Gbps/Full - flow
>>>>>> control off
>>>>>> [   21.128595] BTRFS info (device sdc): zoned mode enabled with zone
>>>>>> size 268435456
>>>>>> [   21.436972] BTRFS error (device sda): zoned: write pointer offset
>>>>>> mismatch of zones in raid1 profile
>>>>>> [   21.438396] BTRFS error (device sda): zoned: failed to load zone info
>>>>>> of bg 1496796102656
>>>>>> [   21.440404] BTRFS error (device sda): failed to read block groups: -5
>>>>>> [   21.460591] BTRFS error (device sda): open_ctree failed: -5
>>>>> Hi this means, the write pointers of both zones forming the block-group
>>>>> 1496796102656 are out of sync.
>>>>>
>>>>> For RAID1 I can't really see why there should be a difference tough,
>>>>> recently only RAID0 and RAID10 code got touched.
>>>>>
>>>>> Debugging this might get a bit tricky, but anyways. You can grab the
>>>>> physical locations of the block-group form the chunk tree via:
>>>>>
>>>>> btrfs inspect-internal dump-tree -t chunk /dev/sda |\
>>>>>
>>>>>            grep -A 7 -E "CHUNK_ITEM 1496796102656" |\
>>>>>
>>>>>            grep "\bstripe\b"
>>>>>
>>>>>
>>>>> Then assuming dev 0 is sda and dev 1 is sdb
>>>>>
>>>>> blkzone report -c 1 -o "offset_from_devid 0 / 512" /dev/sda
>>>>>
>>>>> blkzone report -c 1 -o "offset_from_devid 1 / 512" /dev/sdb
>>>>>
>>>>>
>>>>> E.g. (on my system):
>>>>>
>>>>> root@virtme-ng:/# btrfs inspect-internal dump-tree -t chunk /dev/vda |\
>>>>>
>>>>>                                            grep -A7 -E "CHUNK_ITEM
>>>>> 2147483648" | \
>>>>>
>>>>>                                           grep "\bstripe\b"
>>>>>                   stripe 0 devid 1 offset 2147483648
>>>>>                   stripe 1 devid 2 offset 1073741824
>>>>>
>>>>> root@virtme-ng:/# blkzone report -c 1 -o $((2147483648 / 512)) /dev/vda
>>>>>         start: 0x000400000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>>>>
>>>>> root@virtme-ng:/# blkzone report -c 1 -o $((1073741824 / 512)) /dev/vdb
>>>>>         start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>>>> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
>>>>>
>>>>> Note this is an empty FS, so the write pointers are at 0.
>>>>>
>>>> # btrfs inspect-internal dump-tree -t chunk /dev/sda|\
>>>> grep -A 7 -E "CHUNK_ITEM 1496796102656"|\
>>>> grep stripe
>>>>
>>>> length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
>>>> num_stripes 2 sub_stripes 1
>>>>          stripe 0 devid 2 offset 374467461120
>>>>          stripe 1 devid 1 offset 1342177280
>>>> # blkzone report -c 1 -o "731381760" /dev/sda
>>>>        start: 0x02b980000, len 0x080000, cap 0x080000, wptr 0x07ff80 reset:0
>>>> non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
>>>> # blkzone report -c 1 -o "2621440" /dev/sdb
>>>>        start: 0x000280000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
>>>> non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
>>>>
>>> Commit c0d90a79e8e6 ("btrfs: zoned: fix alloc_offset calculation for
>>> partly conventional block groups") should fix the problem described
>>> there. Not sure (yet) why it doesn't.
>>>
>>>
>> Any update on this? Should I keep states of disks or I can mkfs a new
>> volume?
> Naohiro has a fix candidate for it. Naohiro any updates on it?
Raising this. Hopefully it will have a fix or just make a new volume.



