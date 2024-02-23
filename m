Return-Path: <linux-btrfs+bounces-2693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B2861F27
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 22:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE39A1F22673
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 21:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2214AD36;
	Fri, 23 Feb 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="Y6GKCUSZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out3.mxs.au (h1.out3.mxs.au [110.232.143.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E931493B7
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724516; cv=none; b=gn9eaLxnw/afDo325BLyqC64hLlbJu0n7vyUq9YtqIvGwuWTP01spgtl0MPqLDgdFfHefMeOHBU7kbDdcIFqx88auRUPNFUhCer69PJbQVEBQzInteKwbGACw5eqG+rjTKEfgj7jat1gIBGvCX7olEa9/zhRhSIg3nz6OBREhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724516; c=relaxed/simple;
	bh=c/WLoeBOYormcOlly6j0jmPvQ7UqFLuKx6KCwszLNfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NDQm+rhp1kULtzBeJ4yquiTX5Y0qHJiyyjZUVjJOMZqswTm6NAN3GWoYGVbK8xUlR1DOjzmZPq42K7zdgo0bJOBpdOi6PTP0pxOKUxMrVsH0BaLeEnFn2XrlmE3a426DB9VkV38cEL+4MLmumERtvwE9A90xX4nLSXjlqGE8KrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=Y6GKCUSZ; arc=none smtp.client-ip=110.232.143.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out3.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 537a19ff-d294-11ee-990e-00163c573069
	for <linux-btrfs@vger.kernel.org>;
	Sat, 24 Feb 2024 08:41:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rjzCMPcuKZxMqJnomYB8gDWi6l7buvooULwkyWAATf4=; b=Y6GKCUSZvLOdWNa5X5sYPUZ4c+
	9BxEyisLiHthy60Hz7rSgWtlkifdlSLd307JgVqDvP2g8zGZCE9uWaohXHLR1f6c4qqG9cdXBKd3f
	fKq88Ymu+mISRdy8MD2r5nM0Z9NVOoH+HOiIU+IwTIyMtym+Pnz+KiFnuipDWLB7Wwg2V39q/3XBi
	3s0QSbpRyaAB8aMVr92nhX/fUNdWDjDZHuyYxjsAFe+fmbO60n62ky5Rse27ZcZsZsfvyGKZ/7X6b
	nLOmRdBC2uEguLTU7KDqsOYBVwf6aCwka7lcA1jGT0t4ldVl6O0l3O7micx1O2GiUp9G3l6sxhGk+
	Bg9opIcg==;
Received: from [159.196.20.165] (port=8041 helo=[192.168.2.2])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1rddIZ-000wH3-0T;
	Sat, 24 Feb 2024 08:41:39 +1100
Message-ID: <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
Date: Sat, 24 Feb 2024 08:41:37 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
From: Matthew Jurgens <default@edcint.co.nz>
In-Reply-To: <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 


On 24/02/2024 6:55 am, Qu Wenruo wrote:
>
>
> 在 2024/2/23 21:39, Matthew Jurgens 写道:
>> If I can't run --repair, then how do I repair my file system?
>>
>> I ran a scrub which reported 8 errors that could not be fixed.
>
> The scrub report and corresponding dmesg please.
>
The latest scrub report is

UUID:             021756e1-c9b4-41e7-bfd3-bc4e930eae46
Scrub started:    Fri Feb 23 21:42:13 2024
Status:           finished
Duration:         5:52:50
Total to scrub:   9.00TiB
Rate:             447.36MiB/s
Error summary:    verify=8
   Corrected:      0
   Uncorrectable:  8
   Unverified:     0


Probably the most relevant dmesg lines:

[    0.751162] Btrfs loaded, zoned=yes, fsverity=yes
[    1.038744] sd 6:0:0:0: [sdb] 5860533168 512-byte logical blocks: 
(3.00 TB/2.73 TiB)
[    1.038748] sd 6:0:0:0: [sdb] 4096-byte physical blocks
[    1.038764] sd 6:0:0:0: [sdb] Write Protect is off
[    1.038767] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.038790] sd 6:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.038828] sd 6:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    1.039423] sd 7:0:0:0: [sdc] 5860533168 512-byte logical blocks: 
(3.00 TB/2.73 TiB)
[    1.039427] sd 7:0:0:0: [sdc] 4096-byte physical blocks
[    1.039442] sd 7:0:0:0: [sdc] Write Protect is off
[    1.039445] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.039469] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.039501] sd 7:0:0:0: [sdc] Preferred minimum I/O size 4096 bytes
[    1.063934] sd 7:0:0:0: [sdc] Attached SCSI disk
[    1.064625] sd 6:0:0:0: [sdb] Attached SCSI disk
[    1.672328] sd 10:0:0:0: [sdf] 5860533168 512-byte logical blocks: 
(3.00 TB/2.73 TiB)
[    1.672337] sd 10:0:0:0: [sdf] 4096-byte physical blocks
[    1.672369] sd 10:0:0:0: [sdf] Write Protect is off
[    1.672378] sd 10:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    1.672443] sd 10:0:0:0: [sdf] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.672502] sd 10:0:0:0: [sdf] Preferred minimum I/O size 4096 bytes
[    1.691053] sd 10:0:0:0: [sdf] Attached SCSI disk
[    2.152571] sd 11:0:0:0: [sdg] 5860533168 512-byte logical blocks: 
(3.00 TB/2.73 TiB)
[    2.152580] sd 11:0:0:0: [sdg] 4096-byte physical blocks
[    2.152693] sd 11:0:0:0: [sdg] Write Protect is off
[    2.152702] sd 11:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[    2.152785] sd 11:0:0:0: [sdg] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.152852] sd 11:0:0:0: [sdg] Preferred minimum I/O size 4096 bytes
[    2.183438] sd 11:0:0:0: [sdg] Attached SCSI disk
[    3.036114] BTRFS: device label DUPLICATE devid 2 transid 1476328 
/dev/sda scanned by (udev-worker) (618)
[    3.089538] BTRFS: device label PHDD_SEA4TB devid 1 transid 2894 
/dev/sdh scanned by (udev-worker) (698)
[    3.098034] BTRFS: device label SHARED devid 3 transid 4416278 
/dev/sdb scanned by (udev-worker) (626)
[    3.111915] BTRFS: device label SHARED devid 4 transid 4416278 
/dev/sdc scanned by (udev-worker) (622)
[    3.139441] BTRFS: device label SHARED devid 2 transid 4416278 
/dev/sdf scanned by (udev-worker) (652)
[    3.148380] BTRFS: device label SHARED devid 1 transid 4416278 
/dev/sdg scanned by (udev-worker) (638)
[    7.296462] BTRFS info (device sdg): using crc32c (crc32c-intel) 
checksum algorithm
[    7.296480] BTRFS info (device sdg): allowing degraded mounts
[    7.296485] BTRFS info (device sdg): disk space caching is enabled
[   47.136544] NFSD: Using nfsdcld client tracking operations.
[  127.051829] BTRFS info (device sda): using crc32c (crc32c-intel) 
checksum algorithm
[  127.051836] BTRFS info (device sda): use zstd compression, level 1
[  127.051837] BTRFS info (device sda): allowing degraded mounts
[  127.051838] BTRFS info (device sda): disk space caching is enabled
[  148.773514] BTRFS info (device sda): auto enabling async discard
[  164.193697] BTRFS info (device sdg): scrub: started on devid 1
[  164.227617] BTRFS info (device sdg): scrub: started on devid 3
[  164.227628] BTRFS info (device sdg): scrub: started on devid 2
[  164.242797] BTRFS info (device sdg): scrub: started on devid 4
[ 4897.083624] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.128300] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.263347] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.271085] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.383592] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.428270] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.436955] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.484842] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.518797] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[ 4897.561889] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[10226.535987] BTRFS warning (device sdg): tree block 20647087931392 
mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
[10226.615321] BTRFS warning (device sdg): tree block 20647087931392 
mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
[10226.615524] BTRFS warning (device sdg): tree block 20647087931392 
mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
[10226.615731] BTRFS warning (device sdg): tree block 20647087931392 
mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
[10226.615733] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdb physical 1597612949504
[10226.615741] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdb physical 1597612949504
[10226.615742] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdb physical 1597612949504
[10226.615744] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdb physical 1597612949504
[10871.525097] BTRFS warning (device sdg): tree block 20647087931392 
mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
[10871.538286] BTRFS warning (device sdg): tree block 20647087931392 
mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
[10871.546525] BTRFS warning (device sdg): tree block 20647087931392 
mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
[10871.551011] BTRFS warning (device sdg): tree block 20647087931392 
mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
[10871.551033] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdg physical 1600879263744
[10871.551055] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdg physical 1600879263744
[10871.551063] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdg physical 1600879263744
[10871.551069] BTRFS error (device sdg): unable to fixup (regular) error 
at logical 20647087898624 on dev /dev/sdg physical 1600879263744
[12097.231261] btrfs_validate_extent_buffer: 12 callbacks suppressed
[12097.231264] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12097.257496] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12097.399518] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12097.437847] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12097.456673] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12097.507496] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12097.539579] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12097.562906] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12097.610849] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12097.616316] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12817.886430] btrfs_validate_extent_buffer: 12 callbacks suppressed
[12817.886437] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12817.911375] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12818.002768] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12818.031952] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12818.066655] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12818.108668] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12818.136420] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12818.169702] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[12818.207071] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
[12818.235735] BTRFS warning (device sdg): checksum verify failed on 
logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
[20654.902312] BTRFS info (device sdg): scrub: finished on devid 3 with 
status: 0
[20790.498498] BTRFS info (device sdg): scrub: finished on devid 4 with 
status: 0
[21228.046956] BTRFS info (device sdg): scrub: finished on devid 1 with 
status: 0
[21333.526634] BTRFS info (device sdg): scrub: finished on devid 2 with 
status: 0

The complete dmesg is at https://www.edcint.co.nz/tmp/dmesg_1.txt

>>
>> ------------------------------------------------------------------------------------------------------------------------------ 
>>
>>
>> Then I ran a btrfs check while mounted which looks like:
>>
>> WARNING: filesystem mounted, continuing because of --force
>
> Do not run btrfs check --force on RW mounted fs.
>
> It's pretty common to hit false transid mismatch (which normally should
> be a death sentence to your fs) due to the IO.
Ok, thanks for the info
>
> Thanks,
> Qu
>> Opening filesystem to check...
>> Checking filesystem on /dev/sdg
>> UUID: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>> parent transid verify failed on 18344238039040 wanted 4416296 found
>> 4416299s checked)
>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>> 4416299
>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>> 4416299
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent
>> level=2 child bytenr=18344238039040 child level=0
>> [1/7] checking root items                      (0:00:06 elapsed, 69349
>> items checked)
>> ERROR: failed to repair root items: Input/output error
>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>> 4416300
>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>> 4416300
>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>> 4416300
>> Ignoring transid failure
>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>> 4416301
>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>> 4416301
>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>> 4416301
>> Ignoring transid failure
>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>> 4416301
>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>> 4416301
>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>> 4416301
>> Ignoring transid failure
>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>> 4416301
>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>> 4416301
>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>> 4416301
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent
>> level=1 child bytenr=18344246345728 child level=2
>> [2/7] checking extents                         (0:00:00 elapsed)
>> ERROR: errors found in extent allocation tree or chunk allocation
>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>> 4416299
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent
>> level=2 child bytenr=18344238039040 child level=0
>> [3/7] checking free space cache                (0:00:00 elapsed)
>> parent transid verify failed on 18344241594368 wanted 4416296 found
>> 4416300ecked)
>> parent transid verify failed on 18344241594368 wanted 4416296 found 
>> 4416300
>> parent transid verify failed on 18344241594368 wanted 4416296 found 
>> 4416300
>> Ignoring transid failure
>> root 5 root dir 256 not found
>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>> 4416300
>> Ignoring transid failure
>> ERROR: free space cache inode 958233742 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233743 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233744 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233745 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233746 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233747 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233748 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233749 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233750 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233751 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233752 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233753 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233754 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233755 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233756 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233757 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233758 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233759 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233760 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233761 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233762 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233763 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233764 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233765 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233766 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233767 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233768 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233769 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233770 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233771 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233772 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233773 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958233774 has invalid mode: has 0100644
>> expect 0100600
>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>> 4416301
>> Ignoring transid failure
>> ERROR: free space cache inode 958232811 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232812 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232813 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232814 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232815 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232816 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232817 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232818 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232819 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232820 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232821 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232822 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232823 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232824 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232825 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232826 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232827 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232828 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232829 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958232830 has invalid mode: has 0100644
>> expect 0100600
>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>> 4416301
>> Ignoring transid failure
>> ERROR: free space cache inode 958231543 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231544 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231545 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231546 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231547 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231548 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231549 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231550 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231551 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231552 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231553 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231554 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231555 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231556 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231557 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231558 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231559 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231560 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231561 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231562 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231563 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231564 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231565 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231566 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231567 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231568 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231569 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231570 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231571 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231572 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231573 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231574 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231575 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231576 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231577 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231578 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231579 has invalid mode: has 0100644
>> expect 0100600
>> ERROR: free space cache inode 958231580 has invalid mode: has 0100644
>> expect 0100600
>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>> 4416301
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent
>> level=1 child bytenr=18344246345728 child level=2
>> [4/7] checking fs roots                        (0:00:00 elapsed, 1 items
>> checked)
>> ERROR: errors found in fs roots
>> found 0 bytes used, error(s) found
>> total csum bytes: 0
>> total tree bytes: 0
>> total fs tree bytes: 0
>> total extent tree bytes: 0
>> btree space waste bytes: 0
>> file data blocks allocated: 0
>>   referenced 0
>>
>> ------------------------------------------------------------------------------------------------------------------------------ 
>>
>>
>> I then ran a btrfs check again whilst not mounted and I won't put the
>> output here since the file is 1.5GB and full of things like:
>> root 5 inode 437187144 errors 2000, link count wrong
>>          unresolved ref dir 942513356 index 9 namelen 14 name
>> _tokenizer.pyc filetype 1 errors 0
>>          unresolved ref dir 945696631 index 9 namelen 14 name
>> _tokenizer.pyc filetype 1 errors 0
>>          unresolved ref dir 948998753 index 9 namelen 14 name
>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>          unresolved ref dir 952510365 index 9 namelen 14 name
>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>          unresolved ref dir 954421030 index 9 namelen 14 name
>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>
>> and
>>
>> root 5 inode 957948416 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 690084 index 17960 namelen 19 name
>> 20240222_084117.jpg filetype 1 errors 4, no inode ref
>> root 5 inode 957957996 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 890819470 index 4463 namelen 8 name hourly.3
>> filetype 2 errors 4, no inode ref
>>
>> and ends like:
>>
>> [4/7] checking fs roots                        (0:00:58 elapsed, 415857
>> items checked)
>> ERROR: errors found in fs roots
>> found 4967823106048 bytes used, error(s) found
>> total csum bytes: 4834452504
>> total tree bytes: 17343725568
>> total fs tree bytes: 10449027072
>> total extent tree bytes: 1109393408
>> btree space waste bytes: 3064698357
>> file data blocks allocated: 5472482066432
>>   referenced 5313641955328
>>
>>
>> ------------------------------------------------------------------------------------------------------------------------------ 
>>
>>
>> I have tried to see if I can find out which files are impacted by 
>> doing eg
>>
>> btrfs inspect-internal logical-resolve 18344253374464 /export/shared
>>
>> using a what I think is a logical block number from the scrub or btrfs
>> check, but these always give an error like:
>>
>> ERROR: logical ino ioctl: No such file or directory
>>
>> ------------------------------------------------------------------------------------------------------------------------------ 
>>
>>
>> after mounting it again, subsequent checks while mounted look like the
>> first one
>>
>> I have also run
>>
>> btrfs rescue clear-uuid-tree /dev/sdg
>> btrfs rescue clear-space-cache v1 /dev/sdg
>> btrfs rescue clear-space-cache v2 /dev/sdg
>>
>>
>> I am currently running another scrub so I will see what that looks like
>> in a few hours
>>
>>
>> ------------------------------------------------------------------------------------------------------------------------------ 
>>
>>
>> Other Generic Info:
>>
>> uname -a
>> Linux gw.home.arpa 6.5.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Oct
>> 11 04:07:58 UTC 2023 x86_64 GNU/Linux
>>
>> btrfs --version
>> btrfs-progs v6.6.2
>>
>> btrfs fi show
>> Label: 'SHARED'  uuid: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>>          Total devices 4 FS bytes used 4.52TiB
>>          devid    1 size 2.73TiB used 2.55TiB path /dev/sdg
>>          devid    2 size 2.73TiB used 2.56TiB path /dev/sdf
>>          devid    3 size 2.73TiB used 2.55TiB path /dev/sdb
>>          devid    4 size 2.73TiB used 2.56TiB path /dev/sdc
>>
>> btrfs fi df /export/shared
>> Data, RAID1: total=5.09TiB, used=4.50TiB
>> System, RAID1: total=64.00MiB, used=768.00KiB
>> Metadata, RAID1: total=24.00GiB, used=16.14GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>>
>

