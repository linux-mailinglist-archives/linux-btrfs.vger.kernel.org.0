Return-Path: <linux-btrfs+bounces-447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017CE7FE525
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 02:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0AD2823EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197C80E;
	Thu, 30 Nov 2023 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="q9Am3nJt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2163.outbound.protection.outlook.com [40.92.63.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48EDC
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 17:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe1JBy2cUJVrRbhyjxXXavN8MUH4TrlsYAAdSF29SAIhGMUKjoM+YWSY5GjhVa1sGgShoOub7NYsGLInnfITvNHDFLZBepGPV6Ldm0dxZ/cVrVHsdzZetQ8UDXr2ocdLHYmx0VDWWmfqmmLwRza4FoPmk1rm7RejkbvmleP3xomxeBfBjzN7Hsa0+pJ7FAE9dwbvDEuzeUnaoifqdmQpW5RiHRNj8CWt3+pLapMvji0tSEWx4aszEsDxq6XoQbwj8AIFVt1hZlFkVI5TZCAPO24EOBoOjx9AZgiMBlxRETGJw33lZ/mzs6tA7ZOnaajpMHLMRr5s4tTCM0RTnLRXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bc+LSpJv7M28gcnERDNzQNqvga6a9jLK36nSE/ed3A=;
 b=LlUJLaL4HoddZ9zdQ0KvUdCOONE7aTK1j1E7jab4VkDdODc1tJK914bdRrqroHYn+i4h8O0lE0GkmxMzuz4/EeDeUzSBr1TAWVlsMykO/3Gezd4FsK6hiUiqjGprcW0igfyqWGIYWLrpDJkyehjJNTuFH/9fM+Abw4XpCMDCAqp41APM72BOrtfxnELBq7a+L8YIKqAu13Svb94Sd8TvHlcDNzt3xIkQdVGjaodsYruVdHMEfFP2x51zShjD7svI35ZPcx9/vRkS/AvuckEeicF9imrNLQK8jWk4FxgCc4BO592EUAaaL7yQUkiXm1Y2FMEFazgju3NNjCIbJ3ZwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bc+LSpJv7M28gcnERDNzQNqvga6a9jLK36nSE/ed3A=;
 b=q9Am3nJtbQPa2BdI4nktq3xpMmGspvzm6LDxFE0hyHe+iRqWPU9PAe46kg+96qO5miOBmPlhiQLUkaSEj2y3mPaSgW7ozjzRMr3XDVuCooUHmGQ85IEg/YJV3cFZQWSbziRLNds9cfmj7CnS3m+pik6lt+/9Tq0jsluTni59KxWgxY571w21FVasbexRxs+tBL1lxSWkli+AzPRfFsDDHJu4AgwYNpA/n5A89DGbQ571wH6Cjcn5OPB3Ij4QubM+c0yCuhqGq9bMnjJ21cI6l/uhxebTXZ+biw+EWdgbCAa/quHH7qY1PxC1Dw7Ccd4QSdL3rcQXX2nZ2xMS3YKbNA==
Received: from SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:17c::12)
 by ME3P282MB4257.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:190::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 01:04:41 +0000
Received: from SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
 ([fe80::fd36:56d0:568c:643d]) by SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
 ([fe80::fd36:56d0:568c:643d%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:04:41 +0000
Message-ID:
 <SY4P282MB3613ADCF4EDE6CF6EF804A08E182A@SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM>
Date: Thu, 30 Nov 2023 01:04:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs support needed - various failures in all blocks after
 computer hibernation
Content-Language: en-US
From: Jackson Marsden <jackson.marsden@outlook.com>
To: linux-btrfs@vger.kernel.org
References: <SY4P282MB361358FA4E3BC2D390F0D8D6E182A@SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB361358FA4E3BC2D390F0D8D6E182A@SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [aSuQ7Llwpjgcs7uWppIRP1UtEuBPv44k]
X-ClientProxiedBy: SY6PR01CA0131.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::7) To SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:17c::12)
X-Microsoft-Original-Message-ID:
 <f020291e-3bdf-4e29-b7a8-178d9863804c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3613:EE_|ME3P282MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c1f073-19c5-47cd-b1c8-08dbf14054d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7UZzeXzMM9uVk/3s/GYQyUCncJnDp5AcSouUBU2gzGDhJmJi4D5Ni62mnznR+nsiVK+uJgMWnyQoloEmhCKnef/pX9wmwZS1iZGW/1nhSNdmjo8qXfBf31yfhz2pPKxp7uZ7T8VbeVJp7VSwZXRC2Vx55HSH1v6q3hxG0PO8m4vTunChY67eZjl8XAzbA7YcQBSxv2n+4aIt+FAi6aE/geB0aRHYmYoUvAksColYbPmT3S+Op6gQ7FRl4RHuq1eRlqxHQpULJFPN0frhI4UHtV/KErK2sFtiqGOPoe5AX5H5VnFvkTZauWPy1cMWs5ngIGgf3Jv+HOJ4hf6DhOXgK+c7eGSFhw67aTTI90B2dB6GTFzxxbN3LdJ7dyZ6k6asNF8cDpHk3HInxLwQ5M3txas88ygLA9lGm1IZrgNSzHqm98ZiLmgGrPX2Lvs9U7n79973ZPAHGG66XrPEYKL9nqdHuFzlcpLT1PSNb+1QOK6dFYaGiplQAlce+mTPp/dHFBvOy93LO0salXpZZ2gWzOMlr6zkAK69KndS3Se/W/+WPm7ApJCRSTR+kDL5SV9m
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTlpTjZKRy9nRkZZckFza2tYaGNaQVZ3RkRyeWgxQVM2NkZuWGVKTVVNY3ht?=
 =?utf-8?B?VnVkV1NERXpQVGJ0djJLZUMyQzUrRkUzVzdabmNNQ1ZwdzFWanpoOStRNnpR?=
 =?utf-8?B?dUJFeUZQbHFPK3VqTVJ4TjdVbHR4TXgzcFlRL3Z6NTdROGkzc09seUhpSFRL?=
 =?utf-8?B?QVByRFpweUNjelJXRDVTR1FqVDVJaGNVWm1veEFzQnQ1VkhxZjArOXNhMnZY?=
 =?utf-8?B?N1BsZ2ltS3p5amdrcUVZUG13b0YvemxaRnBQTVg3L2VDbmxlMkd3NWk0OEFN?=
 =?utf-8?B?Q3BGdGNPcWNZU1g0SFJ0QnBWbjhsVFRSUWxscE8rdXFNOGNUczl3MXBuWjVD?=
 =?utf-8?B?RFMweFhDT1BCRExYTjNtNnNGZlh4SGdmWjFuVnBtQ2lhcm9ONllJOFhlZkdh?=
 =?utf-8?B?UndYTmxrcUZpUVNSYS83MEJoV285cmc2Q1lKL05qVjFKSkhvTkVtRkkrZStr?=
 =?utf-8?B?eTN5TWV3cHFNOWk0MTBsSHlYbFB1T0Q3OGFXbHpJUU5HTVhJQzBVM3RDa0dJ?=
 =?utf-8?B?SEQxOVU0YlhBNjU3QllsMHJmNjBlWVpILyt4MzFCYmo1ZEpxcHMzNGdDZU9C?=
 =?utf-8?B?b29waUdLcHVyM1ZUOWpVM3daQjJtVkw1bk9lT01XOVpKeXRMczJyeW5qK0lX?=
 =?utf-8?B?WWNGeDdtbFhDdjJNb2tYa2pNcEJxREdWckZnd0o4ZkhXazFZZlJwVW5zL2J4?=
 =?utf-8?B?QnVFNEtlcGU5NUExclZEVGtZUVgybFd5cU13SzZLTkRDbnJBcno5YVJ3L3FI?=
 =?utf-8?B?RE4zTmNON0J4ai9yUElkb25heVArYzQ0Smt2Z0F0RDl4Tkl6M3VNUnl6TkJ4?=
 =?utf-8?B?L3ZLZ3g5SEFVY3hTeGllbHMvc2ZoSVZidUUycThmWklqaFVXUGNlT01DbkR3?=
 =?utf-8?B?bUlQeSs3cFhsMmo5a21lTkkxbE5HSDMzak0rRUNoai9sd3ZHWEpqVVpsVVRr?=
 =?utf-8?B?K0NKNzBENXRXMWxyT28xV0k2Z2RVTzhDaWQ1WHVyQzdUdUFYVktSb2tEL1Ry?=
 =?utf-8?B?aU1uQWpYeGdHeU94anRTNU1nMmRObmRsb0VYR0VodTJwSUZNWWFNcUZ3d093?=
 =?utf-8?B?R0cydng1TUlwY0o5QzkzdDlFTWtTTlF3R3h5N1pZYnNWMDBubnBrVDBlVmlP?=
 =?utf-8?B?QThoSjc1Y3RaeFhWSkI3aUF5aFhHUjRyMVJuUVJISERidUZSaUNwN3E2eUdB?=
 =?utf-8?B?NWwvRUlUT3UwWUFRSzdDTzJuemszME9kc0U0NTMyQU9OWE9LWDJhL0d6NVpS?=
 =?utf-8?B?QUtXUHFIRXJxeGEzSlhFRTNwZDRBYjFaT3FpNUZhTmxLOWN4MHByWkh2LzFz?=
 =?utf-8?B?VTAzNlRvc1dwakZwVkFiMnpwZ3JQUENwV0xXb1pNanpPS01ncDlHUFBLVGdh?=
 =?utf-8?B?S00xcEQ3cTJ3Yzc1OW5UbDBtWXFjN1NqRTVMZEw2clNnYXZSZHd0Skt3Vmtq?=
 =?utf-8?B?MTg1ZG56Q1FaaVV5UWs0UVg0ekFYWWo4TEZYeFdTNlV0cXN4SU1uQTBQV0Ji?=
 =?utf-8?B?enpjWi9KU3h0ZjFEeU5YaXRXSmx3QnRxSkJ0Nm8yZVZwYXVPdDcwdDVSMDFX?=
 =?utf-8?B?cG5uRXpvZEZwSmJ5WUxmMmpFdnFYVlpnUWJwV1hCZ0tQVjk2QTNXYndsZXIr?=
 =?utf-8?Q?YV0XjM/u88Qkvy1wC8z8AScvq+BKpGhUq1s4giTkaXH8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c1f073-19c5-47cd-b1c8-08dbf14054d9
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3613.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:04:40.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB4257

Is data recovery/partition possible at this stage, and what steps should 
I take now?

Thank you, Jackson

On 11/30/23 01:02, Jackson Marsden wrote:
> Hello, hope all is well.
>
> I am currently booted into a liveusb running Debian Sid, as my current 
> Debian system is unbootable and unmountable (btrfs).
> (Linux siduction 6.5.2-1-siduction-amd64 #1 SMP PREEMPT_DYNAMIC 
> siduction 6.5-2 (2023-09-06) x86_64 GNU/Linux)
>
> btrfs-progs version: v6.3.2
>
> The dmesg/journalctl of the incident is currently unreachable.
>
> History of events:
> System had gone flat and went into hibernation, (I believe that the 
> system used a Swap partition not a swapfile, but I am unsure), in 
> which the partition became read-only. I had rebooted the laptop, and 
> discovered that the partition has become unbootable and unmountable. 
> The UUID of the device file cannot be detected in grub2.
>
> I have run diagnostics, but cannot perform any repairs due to the 
> filesystem being unable to be opened by any tools (that I know of).
>
> Diagnostics of partition:
>
> dmesg after attempting to mount (does not work with usebackuproot 
> either):
> [  +9.874748] BTRFS: device fsid c818a43c-0e0d-41e2-b6ea-bd147f5afe9a 
> devid 1 transid 130186 /dev/nvme0n1p8 scanned by mount (3443)
> [  +0.000832] BTRFS info (device nvme0n1p8): using crc32c 
> (crc32c-intel) checksum algorithm
> [  +0.000016] BTRFS error (device nvme0n1p8): unrecognized mount 
> option 'recover=all'
> [  +0.000037] BTRFS error (device nvme0n1p8): open_ctree failed
>
> sudo btrfs rescue super-recover -v /dev/nvme0n1p8:
> All Devices:
>         Device: id = 1, name = /dev/nvme0n1p8
>
> Before Recovering:
>         [All good supers]:
>                 device name = /dev/nvme0n1p8
>                 superblock bytenr = 67108864
>
>         [All bad supers]:
>                 device name = /dev/nvme0n1p8
>                 superblock bytenr = 65536
>
>
> Make sure this is a btrfs disk otherwise the tool will destroy other 
> fs, Are you sure? [y/N]: y
> checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
> Couldn't read tree root
> Failed to recover bad superblocks
>
> sudo btrfs check --repair /dev/nvme0n1p8
> enabling repair mode
> WARNING:
>
>         Do not use --repair unless you are advised to do so by a 
> developer
>         or an experienced user, and then only after having accepted 
> that no
>         fsck can successfully repair all types of filesystem 
> corruption. E.g.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 85681651712, bytenr mismatch, want=85681651712, have=0
> Couldn't read tree root
> ERROR: cannot open file system
>
> sudo btrfs -v inspect-internal dump-super /dev/nvme0n1p8
> superblock: bytenr=65536, device=/dev/nvme0n1p8
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0xab4571d0 [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    c818a43c-0e0d-41e2-b6ea-bd147f5afe9a
> metadata_uuid           c818a43c-0e0d-41e2-b6ea-bd147f5afe9a
> label
> generation              130186
> root                    85681651712
> sys_array_size          129
> chunk_root_generation   95444
> root_level              0
> chunk_root              24526848
> chunk_root_level        1
> log_root                85695545344
> log_root_transid (deprecated)   0
> log_root_level          0
> total_bytes             167786840064
> bytes_used              158392016896
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x3
>                         ( FREE_SPACE_TREE |
>                           FREE_SPACE_TREE_VALID )
> incompat_flags          0x361
>                         ( MIXED_BACKREF |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA |
>                           NO_HOLES )
> cache_generation        0
> uuid_tree_generation    26901
> dev_item.uuid           c79dbc88-5c77-4947-be90-e04f352d6a0b
> dev_item.fsid           c818a43c-0e0d-41e2-b6ea-bd147f5afe9a [match]
> dev_item.type           0
> dev_item.total_bytes    167786840064
> dev_item.bytes_used     167785791488
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
>
> btrfs-find-superblock
> Couldn't read tree root
> Superblock thinks the generation is 130186
> Superblock thinks the level is 0
> corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
> invalid generation, have 130193 expect (0, 130187]
> corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
> invalid generation, have 130193 expect (0, 130187]
> Well block 85678981120(gen: 130185 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85672886272(gen: 130184 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85667332096(gen: 130183 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85661794304(gen: 130182 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 352387072(gen: 129972 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85790687232(gen: 129791 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85784363008(gen: 129790 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85779005440(gen: 129789 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85774237696(gen: 129788 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85770469376(gen: 129787 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85757296640(gen: 129784 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85750087680(gen: 129782 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85742714880(gen: 129780 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85737275392(gen: 129779 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85732376576(gen: 129778 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85717434368(gen: 129774 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85688336384(gen: 129767 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
> Well block 85683781632(gen: 129766 level: 0) seems good, but 
> generation/level doesn't match, want gen: 130186 level: 0
>
> sudo btrfs restore -v -c -x -S -i /dev/nvme0n1p8 /mnt
> checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 85681651712 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 85681651712, bytenr mismatch, want=85681651712, have=0
> Couldn't read tree root
> Could not open root, trying backup super
> checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 85929639936 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 85929639936, bytenr mismatch, want=85929639936, have=0
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
>
> cat roots.txt
> 856728862
> 856673320
> 856617943
> 352387072
> 857906872
> 857843630
> 857790054
> 857742376
> 857704693
> 857572966
> 857500876
> 857427148
> 857372753
> 857323765
> 857174343
> 856883363
> 856837816
>
> while read meme; do btrfs restore -t $meme -v -c -x -S -i 
> /dev/nvme0n1p8 /mnt; done < roots.txt
> ERROR: tree block bytenr 856728862 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 856728862 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 856673320 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 856673320 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 856617943 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 856617943 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> parent transid verify failed on 352387072 wanted 130186 found 129972
> parent transid verify failed on 352387072 wanted 130186 found 129972
> parent transid verify failed on 352387072 wanted 130186 found 129972
> Ignoring transid failure
> checksum verify failed on 346832896 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 346832896 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 346832896 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 346832896, bytenr mismatch, want=346832896, have=0
> WARNING: could not setup extent tree, skipping it
> checksum verify failed on 342458368 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 342458368 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 342458368 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 342458368, bytenr mismatch, want=342458368, have=0
> WARNING: could not setup csum tree, skipping it
> checksum verify failed on 346898432 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 346898432 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 346898432 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 346898432, bytenr mismatch, want=346898432, have=0
> WARNING: could not setup free space tree, skipping it
> parent transid verify failed on 35766272 wanted 125618 found 130194
> parent transid verify failed on 35766272 wanted 125618 found 130194
> parent transid verify failed on 35766272 wanted 125618 found 130194
> Ignoring transid failure
> corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
> invalid generation, have 130193 expect (0, 130187]
> parent transid verify failed on 35766272 wanted 125618 found 130194
> Ignoring transid failure
> corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
> invalid generation, have 130193 expect (0, 130187]
> corrupt leaf: block=35766272 slot=34 extent bytenr=33472512 len=16384 
> invalid generation, have 130193 expect (0, 130187]
> ERROR: search for next directory entry failed: -1
> ERROR: tree block bytenr 857906872 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857906872 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857843630 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857843630 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857790054 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857790054 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857742376 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857742376 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857704693 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857704693 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857572966 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857572966 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857500876 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857500876 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857427148 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857427148 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857372753 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857372753 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857323765 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857323765 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 857174343 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 857174343 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 856883363 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 856883363 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
> ERROR: tree block bytenr 856837816 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: tree block bytenr 856837816 is not aligned to sectorsize 4096
> Couldn't read tree root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 
> 167786840064
> Could not open root, trying backup super
>

