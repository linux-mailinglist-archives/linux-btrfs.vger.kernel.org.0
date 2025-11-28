Return-Path: <linux-btrfs+bounces-19412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96BC9276D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 16:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35CA034BC5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A832765E2;
	Fri, 28 Nov 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="LGtKfeMi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F922578A
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764344301; cv=none; b=OFSYG2JfKRW0vnSH/dUwRId4S1Ngyb5td3MXTIlK4ZikrHj+/sj+9BFCbPu598wTEbnVhgG9Ur1yvsKGnwA3YtYDDzimsUJJjFcY/hm/dQb+sMwXtAEt2PLLbOEMtew6fbZCLSlH8t3bDqjBZvopDnfNodWy3EnD5VUW+Y9Mtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764344301; c=relaxed/simple;
	bh=3tbhuG6QtXvOvuVmlevATL72mpGFmT1zkyG3+6tLmzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfhMVjLQeMYeDpkGdiN/eVO9zysc119JbAq7rk+6rpbBPrjiwWG/gfSuCYzwi1kENV3jnM/7PL3VeCJDhNVpMrE9TLzb7tSc9+1NEgl6q8I3YQr3qCyMKVV7l4s06d+iFl5O2jcUKfAXSf6hMpckypt5g/j/ef3WsJT06bGlZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=LGtKfeMi; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1764344292;
	bh=Zcwv6YJ2HJwUDh0oqHOtA8QFGZ8LfDJVcXjtXCA4krU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LGtKfeMitSHCUPc/L4AMY0xH3lIiJ+eUspwXs0D4+m9fTJjmMEVwwcSrWOPTQRLiD
	 YGJ1pmodLxrMsJlp03h6fl6oXbkOeq4qf+8f/TEn4f2GZpRBAYPVZQRzSFqZCnSxxi
	 VVpAdf7At07GbNJv7h17SOjyGjLW9xRVto618wEU=
X-QQ-mid: esmtpgz11t1764344287tc9e99a64
X-QQ-Originating-IP: QVzNof8QjtdRHVMyO/zrD4mor401L8g5n4jUmGBFRrE=
Received: from [198.18.0.1] ( [123.134.104.238])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Nov 2025 23:38:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2126347876065525862
Message-ID: <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
Date: Fri, 28 Nov 2025 23:38:06 +0800
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
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MLQK/Qc97rZTC8TK8hKeayrvY1vDZiYyeW56U5XFdJpVm2m1Xu3gqa+z
	DpQei9h9cO4pncjE+KoVKN6KsowbRBVO+wajuakV7LemdPRXAUb9m4/TO4iFaDrGR6kkANG
	jlfxBY7tqbn1Iqr4RkROOYnn8HUmTkIptAXeb8Olus6x9ZmEObWcPZ/YnTRcchNLHtMkfoK
	1JX50ZpIxEFQSScbsCRqzqREYKZAbg8EpnBRnk+1HYPoVtNPtIIIJ5eoN6UIt0VXIxTgBp0
	OsZTP4Ac3vkrvP5PMtez1sv0mqI4Gm9DLVMd8eLpPkPMcDvCTPs6ogJH5moS5c9EbCBdm1g
	IHbWibLSXITe+wkc+cFYT8ZwU55otTVoBS7L+5EcoBGN7TK/+diTxYa3q52scYSY3YP5bK8
	x+e4LQt79MB1ifF7ddRVb+UJ5mOhKbDikeRDaXYxCEWFVw6PhRldkvE9kMbV+jGlx58IfeK
	mYfjXfBT0DhKPxB9eqNWUDvuS5oy7QkmSjA90duq7mUFMsYiQuh+bK0t0q2x/CCMXm8CXUP
	0wK0nRIUDkPOoJmjD6PABT2I1ut9JD7hVh/9TiIGA3z1sfguvNOmxa+oUgdTo3BcXRNEAqb
	QJYEoO+1Hs3BOwTH0iw2zQGBmQcInxhl9e5eRIWrpwYyOE2mNNDK8bXSnv/4zHJjyU6qL8r
	H3/NVat38YzcCulmn8cQXc9C9SQgBg7O/xK3PoNf5GA++TSERq0fdI1ONVPiu44RAgDBjwy
	ZhkN18ybYZ5CI2h7if6aLTgF3Y8m20lVcsyzEIWfxoR2wSlHITk3ewgK8JD8D563JyRLKMz
	RZHCDGE/MgWHlBHLARn8pK67xv8MyocU88aT5nc+DSzlDBUSiiUEqyTZacN7WUwKeq5JMeU
	Ptt9fQBu4fnUOxPY00vttcSXmHAkYsxZ1lEl/AuVnv8gMxXmK+VBxwCo+6wzcO08vhO9jam
	PpPG/gGhJWtYollgl5ZZJPgs+R8SnbvGp5EG1Fpy7gqaJxWyQ2XJ3GXNg
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

在 2025/11/28 23:03, Johannes Thumshirn 写道:
> On 11/28/25 12:36 PM, HAN Yuwei wrote:
>> /dev/sdd, 52156 zones of 268435456 bytes
>> [   19.757242] BTRFS info (device sda): host-managed zoned block device
>> /dev/sdb, 52156 zones of 268435456 bytes
>> [   19.868623] BTRFS info (device sda): zoned mode enabled with zone
>> size 268435456
>> [   20.940894] BTRFS info (device sdd): zoned mode enabled with zone
>> size 268435456
>> [   21.101010] r8169 0000:07:00.0 ethob: Link is Up - 1Gbps/Full - flow
>> control off
>> [   21.128595] BTRFS info (device sdc): zoned mode enabled with zone
>> size 268435456
>> [   21.436972] BTRFS error (device sda): zoned: write pointer offset
>> mismatch of zones in raid1 profile
>> [   21.438396] BTRFS error (device sda): zoned: failed to load zone info
>> of bg 1496796102656
>> [   21.440404] BTRFS error (device sda): failed to read block groups: -5
>> [   21.460591] BTRFS error (device sda): open_ctree failed: -5
> 
> Hi this means, the write pointers of both zones forming the block-group
> 1496796102656 are out of sync.
> 
> For RAID1 I can't really see why there should be a difference tough,
> recently only RAID0 and RAID10 code got touched.
> 
> Debugging this might get a bit tricky, but anyways. You can grab the
> physical locations of the block-group form the chunk tree via:
> 
> btrfs inspect-internal dump-tree -t chunk /dev/sda |\
> 
>        grep -A 7 -E "CHUNK_ITEM 1496796102656" |\
> 
>        grep "\bstripe\b"
> 
> 
> Then assuming dev 0 is sda and dev 1 is sdb
> 
> blkzone report -c 1 -o "offset_from_devid 0 / 512" /dev/sda
> 
> blkzone report -c 1 -o "offset_from_devid 1 / 512" /dev/sdb
> 
> 
> E.g. (on my system):
> 
> root@virtme-ng:/# btrfs inspect-internal dump-tree -t chunk /dev/vda |\
> 
>                                        grep -A7 -E "CHUNK_ITEM
> 2147483648" | \
> 
>                                       grep "\bstripe\b"
>               stripe 0 devid 1 offset 2147483648
>               stripe 1 devid 2 offset 1073741824
> 
> root@virtme-ng:/# blkzone report -c 1 -o $((2147483648 / 512)) /dev/vda
>     start: 0x000400000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> root@virtme-ng:/# blkzone report -c 1 -o $((1073741824 / 512)) /dev/vdb
>     start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> Note this is an empty FS, so the write pointers are at 0.
> 
# btrfs inspect-internal dump-tree -t chunk /dev/sda|\
grep -A 7 -E "CHUNK_ITEM 1496796102656"|\
grep stripe

length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1 
num_stripes 2 sub_stripes 1
     stripe 0 devid 2 offset 374467461120
     stripe 1 devid 1 offset 1342177280
# blkzone report -c 1 -o "731381760" /dev/sda
   start: 0x02b980000, len 0x080000, cap 0x080000, wptr 0x07ff80 reset:0 
non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
# blkzone report -c 1 -o "2621440" /dev/sdb
   start: 0x000280000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]

seems like they have distributed to different type of zones. Should I do 
bisect to pin the commit?

HAN Yuwei


