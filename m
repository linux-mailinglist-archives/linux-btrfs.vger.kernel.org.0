Return-Path: <linux-btrfs+bounces-446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE77FE524
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 02:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E727228236B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 01:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA6B80E;
	Thu, 30 Nov 2023 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q8UTKLcw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2181.outbound.protection.outlook.com [40.92.63.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B4D5C
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 17:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK0y+A5hTy+sh7JIqK/u5zCZ87pe2Reua+GHhAhtMN6O4UxrU4cG8xJyms5i8cp1vkDwUEs9F4d73DAUNjwTFKxUjEugFgWW1lEPJY8djuZ7HOPmFf85LbTtLJrphr/Wl86kKcv72ApcXefk35OMVqOcldpSQ8tqzRPAhMBFNB+qW7iUwDx1diBZwu1QDh3gHB+Ta4e+It5NScgkbVe8OV2vxk4SdIAX76qPWI04cq6EnKfFyGVDgSGSDsObjm++n3lZeXNbX2B9c53bT8FFOS7neYjVfqYmK5cbBsf9v59ShKRUqpRgfYc0bHyoICijVAyUxGfGy655l/QzUZ9aWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kNwjHoHRpMuYg0VWzq6PMNBvbe0eznwxZi/Uh/YpSc=;
 b=WJZso9hQ4vibJ9g21yFXeEPtAgg/OhQCf7EIHWMm3jiDhx12j89SSxiekq0cXLsiQo91BLLEH+W3BhjDsdHb2uR517inIuEzEL1nBJPcvnRmerpn6zNhfVNRsjbDXlHIBSxaxzW/G8e/EfAa0jIAFmit6ofPwwxqe5v0SAa4FmfANiOQ1jmyvyrXixGbtX0IHdHMMSUJeekKsbWmCvMJvHU3lFIBcUQWyfGAdz+gOZTHcDCkbEvqaBq+YbnGR5abro+1t6HmbkmjJPMob7XKTHGlAxZWgiBRy4mfAAnlfNVBkWN+fyS8NtOwAe4rQ+qYVS/i6N1u/x41u7dV9QXtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kNwjHoHRpMuYg0VWzq6PMNBvbe0eznwxZi/Uh/YpSc=;
 b=Q8UTKLcwJmr4ogxNFc0W97zTzsQUooWLmSar7pzdYscHjL7UJ4Pvz1wehNsL4r7YtNG/Sf/2P/OwNzkpem01xezXJqrJ4UVVyZlu3EnTG+1NRccYtUc25Xw7sz+llW+j10NfkehOLV27bggUff4gqURAZAsjO6YhNO9z/frNgOnE+Yj0oYUm36vozoIJ4jF+0xBrQjPV4IrQ8RoF09vQ5KTBugaRpMhg9cO22rOyA/qVvRXp1Gm/wTYV6fAMBcpVEaE9Bpi2AT6/5MuDwKEM/J3/xSDp1sST247RujHxqzBc/QRmBDwPHZg3TrY2dMyU3e1mcIojC5hUAJSxsdO/tg==
Received: from SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:17c::12)
 by SYBP282MB3558.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:179::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:02:49 +0000
Received: from SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
 ([fe80::fd36:56d0:568c:643d]) by SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
 ([fe80::fd36:56d0:568c:643d%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:02:46 +0000
Message-ID:
 <SY4P282MB361358FA4E3BC2D390F0D8D6E182A@SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM>
Date: Thu, 30 Nov 2023 01:02:44 +0000
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Jackson Marsden <jackson.marsden@outlook.com>
Subject: Btrfs support needed - various failures in all blocks after computer
 hibernation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [1sknnzaQ3CyLrPD+lWEAEZslH/OtHopG]
X-ClientProxiedBy: SY6PR01CA0131.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::7) To SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:17c::12)
X-Microsoft-Original-Message-ID:
 <4ddb6ff3-4d61-40c8-a077-e6e6c09347ea@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3613:EE_|SYBP282MB3558:EE_
X-MS-Office365-Filtering-Correlation-Id: 536df441-d1d1-4381-8e27-08dbf140106e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RN4uUzomvaW2sp3cTmkFR3FCCJa60XZ8eff2jK9gAEdO4wQiJm0hfrByL5AdOrIUaqlffEP16GhbBckeIPutvY9veAmAYkpipFUxz+CHLpnVrDT2dXofWQwTg2T7CI9pyZGsf3Bd5Z0JWRcedL1sreo7mOCJkaWCJbhWLa/cUSDhxNRKqAIuvktN14KM5tvjeMQSKP3HCAYhtCfDwpJZXIuo+T4nx5+8xo3vWeDKKcpnb3jgMn9g4H8fwKWJquTq5k+8aoYZPQrVUs8vgX/AzeDsIrEU5YFs+diZ9ANw+E6f8oYbDSDJLKwf+rhv+YO68eO9qLOhtzq4r/pWf8riYjPC9d9RArjHpkxiEzQj3hc3FehRix33+xYsJlWHIniVxOCl/It9Tw3IBueg6cJ//iAkXXsLTyyGZuMyTl74M0iDDBZo6VL1eNACMa4dsKdtbpBbaTS3wRswhxOr/y7suPtf8zUE8oSbqG5dR//ICEKyyCpNDdElhtIs/z7fP8Af/+YFeES/3qjBqmF7O7nrFSZKP2y7RpSm1Vjmq8ozPfi9qHTVBQASTkvdokp9OX4M
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enRoT3ljSXNIcmNUWDhVV2tMNktOQ3FGM1VVb1dadmQrWE1aNWQrMjhaZ2gz?=
 =?utf-8?B?WDJiU0FHb2dONDN2Tis1UXZqVlJhKzFKaU5ab2U1Q251UWx3dVBsMzVyTkN1?=
 =?utf-8?B?MkhuUjBYVXVmN3piczMzVzRaQTExbkV6ckV1RGJnOGtKN29GZkE0bm1YRjk0?=
 =?utf-8?B?U1RtMjIzYThMb0kvMTlRVzBDWlJyTnBDS0l6bWpLbDU2YU0xaURYWFZEQ0E3?=
 =?utf-8?B?ZGM2Uy8zZE4yOGc3QzR0NzA5WUdKTDZpcUFtcGptcW4wMnFydWt3ZHhHTWhD?=
 =?utf-8?B?NzlUVGdRc3Z3a2JDaEQ2dVlmRXRCNzVUeVpnYWhxY0dHNjQzd0dZZlRJbUk3?=
 =?utf-8?B?M3ZVSzRQbTZkYU9tR2RVL3kybW9kSVg3dkZTOWFQanllN3hJZGNLMW5VWmdR?=
 =?utf-8?B?ZGRPY0cyNXkyRUFsZC8xeTQzSUVVeHF4alVXV0NkdGhUcHBkSndqeDFTZEdW?=
 =?utf-8?B?N1pEOWZpTE9FcTh3MUlySXBwWE1tK1VaaW9PMnJoa1dNMXpkb0IyR2JMdWdI?=
 =?utf-8?B?STlDOU93VzhjMWd0bngyd2Nud1NqaXZmTy8xdzYrZk1JbVpMWnlEVzRSSUsr?=
 =?utf-8?B?Ky8vTjQyRi9jV2kxRUYvSnZTeUozazYvWnZLaVhvaTNkWG9JK0xsYnBpY2pD?=
 =?utf-8?B?UjIveXJnKzRmTmlOa1l3V0w5L0sxZjlydDNFMnFrTUVMaUZvL0tBZFpZc0Rr?=
 =?utf-8?B?a2pTTGYvNUFoaWo1WFlRWndOWHRCZmgzcGJUeHhDTFRVaUlxZmFMUUh4eDNU?=
 =?utf-8?B?c25UbjBhbFM0TkszUkZhcFBNVUY4Wm9BNmRITWNJbTdQaXFHaGIvOVNSdndC?=
 =?utf-8?B?aUlMcmRPQzhabkRXaXRoMWpwQ1hXYmM3ZHkyR0hCUzVMNmZaTURVNklYcURx?=
 =?utf-8?B?ejc5NWpHa2M4VGNoazhHMTZLWVJSWEZXdkoxZFlpbTdJd1BnenRZVXB2NXNF?=
 =?utf-8?B?Ri9HYkYwRHRnTkNsVXdlamhjSHRkMExtZnp3clBUWlMzVTUvZjhmdnBmTmJ2?=
 =?utf-8?B?MmI3SmE2OU8yT3hzTXpTTUZMK21rT1llTEJoSWVkQXRZVWU0WmlmcS9PNlo2?=
 =?utf-8?B?c0lndnZBQlExejVMMS8wR0FROFpMaGkrOWI3WkQrVSttV3cxY1pWRzh0V1h1?=
 =?utf-8?B?MmVkZUk1cWZqcmpKQW9BOXc1RG1OaEE5NDJQZEdjOGtGUWNlSE1OYnlZSUhk?=
 =?utf-8?B?OTdmSzFOZnJYR2ZkUk1QUWI1dnRQL05KdEFDamNiWUZDQ3dzMktyUjYzSnRx?=
 =?utf-8?B?NWFOandOb1lQNkFJVTF6NmFpQ0JoWGtmRmY2YWI3dXhSOXYzN2xpMTZHeHc1?=
 =?utf-8?B?QklvaWZ5VGV5aklKNDR0MUMrQUFKMUVPa3VWY1FBbzArRjZ4VHU4WTlna3Jw?=
 =?utf-8?B?ci9FTTdRZnJzZHc4TFlrSFhrZFRCV3hwMUNNZzdwYTQ2R3I2RTYxdnRxbXY5?=
 =?utf-8?B?ejl6c1Y4UXVITFg2L1p6WUoxZGFYUHBYemZ4emF5enhqTUcvOG9aVklLWDB5?=
 =?utf-8?B?RmM2V09rWUxGMkdDV04weFNnQ0ljVER4QmdpZHFSblY4WEFIajJTQXFkNEZv?=
 =?utf-8?B?RFQwblhHWldYK2lDN1pDaER3OWErSmNEbzhsVFBKc0NTcmMzNGdVb2VCTFlw?=
 =?utf-8?Q?Pr7U85E0lWnq7FZy6OFe2keY35KSqlQBNwxbolsUCmFM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536df441-d1d1-4381-8e27-08dbf140106e
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:02:46.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB3558

Hello, hope all is well.

I am currently booted into a liveusb running Debian Sid, as my current 
Debian system is unbootable and unmountable (btrfs).
(Linux siduction 6.5.2-1-siduction-amd64 #1 SMP PREEMPT_DYNAMIC 
siduction 6.5-2 (2023-09-06) x86_64 GNU/Linux)

btrfs-progs version: v6.3.2

The dmesg/journalctl of the incident is currently unreachable.

History of events:
System had gone flat and went into hibernation, (I believe that the 
system used a Swap partition not a swapfile, but I am unsure), in which 
the partition became read-only. I had rebooted the laptop, and 
discovered that the partition has become unbootable and unmountable. The 
UUID of the device file cannot be detected in grub2.

I have run diagnostics, but cannot perform any repairs due to the 
filesystem being unable to be opened by any tools (that I know of).

Diagnostics of partition:

dmesg after attempting to mount (does not work with usebackuproot either):
[  +9.874748] BTRFS: device fsid c818a43c-0e0d-41e2-b6ea-bd147f5afe9a 
devid 1 transid 130186 /dev/nvme0n1p8 scanned by mount (3443)
[  +0.000832] BTRFS info (device nvme0n1p8): using crc32c (crc32c-intel) 
checksum algorithm
[  +0.000016] BTRFS error (device nvme0n1p8): unrecognized mount option 
'recover=all'
[  +0.000037] BTRFS error (device nvme0n1p8): open_ctree failed

sudo btrfs rescue super-recover -v /dev/nvme0n1p8:
All Devices:
         Device: id = 1, name = /dev/nvme0n1p8

Before Recovering:
         [All good supers]:
                 device name = /dev/nvme0n1p8
                 superblock bytenr = 67108864

         [All bad supers]:
                 device name = /dev/nvme0n1p8
                 superblock bytenr = 65536


Make sure this is a btrfs disk otherwise the tool will destroy other fs, 
Are you sure? [y/N]: y
checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
Couldn't read tree root
Failed to recover bad superblocks

sudo btrfs check --repair /dev/nvme0n1p8
enabling repair mode
WARNING:

         Do not use --repair unless you are advised to do so by a developer
         or an experienced user, and then only after having accepted that no
         fsck can successfully repair all types of filesystem 
corruption. E.g.
         some software or hardware bugs can fatally damage a volume.
         The operation will start in 10 seconds.
         Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
bad tree block 85681651712, bytenr mismatch, want=85681651712, have=0
Couldn't read tree root
ERROR: cannot open file system

sudo btrfs -v inspect-internal dump-super /dev/nvme0n1p8
superblock: bytenr=65536, device=/dev/nvme0n1p8
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xab4571d0 [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    c818a43c-0e0d-41e2-b6ea-bd147f5afe9a
metadata_uuid           c818a43c-0e0d-41e2-b6ea-bd147f5afe9a
label
generation              130186
root                    85681651712
sys_array_size          129
chunk_root_generation   95444
root_level              0
chunk_root              24526848
chunk_root_level        1
log_root                85695545344
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             167786840064
bytes_used              158392016896
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x3
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID )
incompat_flags          0x361
                         ( MIXED_BACKREF |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES )
cache_generation        0
uuid_tree_generation    26901
dev_item.uuid           c79dbc88-5c77-4947-be90-e04f352d6a0b
dev_item.fsid           c818a43c-0e0d-41e2-b6ea-bd147f5afe9a [match]
dev_item.type           0
dev_item.total_bytes    167786840064
dev_item.bytes_used     167785791488
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

btrfs-find-superblock
Couldn't read tree root
Superblock thinks the generation is 130186
Superblock thinks the level is 0
corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
invalid generation, have 130193 expect (0, 130187]
corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
invalid generation, have 130193 expect (0, 130187]
Well block 85678981120(gen: 130185 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85672886272(gen: 130184 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85667332096(gen: 130183 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85661794304(gen: 130182 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 352387072(gen: 129972 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85790687232(gen: 129791 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85784363008(gen: 129790 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85779005440(gen: 129789 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85774237696(gen: 129788 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85770469376(gen: 129787 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85757296640(gen: 129784 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85750087680(gen: 129782 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85742714880(gen: 129780 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85737275392(gen: 129779 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85732376576(gen: 129778 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85717434368(gen: 129774 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85688336384(gen: 129767 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0
Well block 85683781632(gen: 129766 level: 0) seems good, but 
generation/level doesn't match, want gen: 130186 level: 0

sudo btrfs restore -v -c -x -S -i /dev/nvme0n1p8 /mnt
checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
bad tree block 85681651712, bytenr mismatch, want=85681651712, have=0
Couldn't read tree root
Could not open root, trying backup super
checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
bad tree block 85929639936, bytenr mismatch, want=85929639936, have=0
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super

cat roots.txt
856728862
856673320
856617943
352387072
857906872
857843630
857790054
857742376
857704693
857572966
857500876
857427148
857372753
857323765
857174343
856883363
856837816

while read meme; do btrfs restore -t $meme -v -c -x -S -i /dev/nvme0n1p8 
/mnt; done < roots.txt
ERROR: tree block bytenr 856728862 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 856728862 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 856673320 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 856673320 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 856617943 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 856617943 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
parent transid verify failed on 352387072 wanted 130186 found 129972
parent transid verify failed on 352387072 wanted 130186 found 129972
parent transid verify failed on 352387072 wanted 130186 found 129972
Ignoring transid failure
checksum verify failed on 346832896 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 346832896 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 346832896 wanted 0x00000000 found 0xb6bde3e4
bad tree block 346832896, bytenr mismatch, want=346832896, have=0
WARNING: could not setup extent tree, skipping it
checksum verify failed on 342458368 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 342458368 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 342458368 wanted 0x00000000 found 0xb6bde3e4
bad tree block 342458368, bytenr mismatch, want=342458368, have=0
WARNING: could not setup csum tree, skipping it
checksum verify failed on 346898432 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 346898432 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 346898432 wanted 0x00000000 found 0xb6bde3e4
bad tree block 346898432, bytenr mismatch, want=346898432, have=0
WARNING: could not setup free space tree, skipping it
parent transid verify failed on 35766272 wanted 125618 found 130194
parent transid verify failed on 35766272 wanted 125618 found 130194
parent transid verify failed on 35766272 wanted 125618 found 130194
Ignoring transid failure
corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
invalid generation, have 130193 expect (0, 130187]
parent transid verify failed on 35766272 wanted 125618 found 130194
Ignoring transid failure
corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
invalid generation, have 130193 expect (0, 130187]
corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
invalid generation, have 130193 expect (0, 130187]
ERROR: search for next directory entry failed: -1
ERROR: tree block bytenr 857906872 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857906872 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857843630 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857843630 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857790054 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857790054 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857742376 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857742376 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857704693 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857704693 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857572966 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857572966 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857500876 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857500876 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857427148 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857427148 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857372753 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857372753 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857323765 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857323765 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 857174343 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 857174343 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 856883363 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 856883363 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super
ERROR: tree block bytenr 856837816 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: tree block bytenr 856837816 is not aligned to sectorsize 4096
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 
167786840064
Could not open root, trying backup super


