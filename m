Return-Path: <linux-btrfs+bounces-1082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B9681A795
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 21:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE888286A72
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1E48CC9;
	Wed, 20 Dec 2023 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yosijo.de header.i=@yosijo.de header.b="npkz4zwV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ispconfig.waimanu.io (mail.ispconfig.waimanu.io [46.4.54.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D94487B3
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yosijo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yosijo.de
Received: from localhost (localhost [127.0.0.1])
	by mail.ispconfig.waimanu.io (Postfix) with ESMTP id 8B1A21439DD
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 21:21:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yosijo.de; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id; s=default; t=1703103699; x=1704918100; bh=0TAX
	0t2CfTWHEjUvCq0zLHNa9ulI3RG/+wVZCez592k=; b=npkz4zwVmqq810Gj81Ue
	gSB3zbSEBc4HavSEoP5ifUq1O/IwSDYxy6SqHwShiAFLfQUsglTibzdEiJpz8CJz
	WIRbnSmhhOkMZ2uTtJbbfo5AhSaVPwvh4tH+Cx8lJ5OS4sgYRpLmwDhKjEi2QRyS
	5NpjrOq4o8pAisxQoVdxfJE=
X-Virus-Scanned: Debian amavisd-new at mail.ispconfig.waimanu.io
Received: from mail.ispconfig.waimanu.io ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mNrsOzQZZDur for <linux-btrfs@vger.kernel.org>;
	Wed, 20 Dec 2023 21:21:39 +0100 (CET)
Received: from [IPV6:2001:9e8:267:700:264b:feff:fe55:89e1] (unknown [IPv6:2001:9e8:267:700:264b:feff:fe55:89e1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: info@yosijo.de)
	by mail.ispconfig.waimanu.io (Postfix) with ESMTPSA id 64AEB1439B2
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 21:21:39 +0100 (CET)
Message-ID: <0f669982-356d-4a64-84c7-addce7bc6812@yosijo.de>
Date: Wed, 20 Dec 2023 21:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
To: linux-btrfs@vger.kernel.org
From: York-Simon Johannsen <info@yosijo.de>
Autocrypt: addr=info@yosijo.de; keydata=
 xjMEXa+AZBYJKwYBBAHaRw8BAQdAP4l53sdC98C6c4ivnk9Tci5+C0XZQ9eFATvGOlYktIDN
 JVlvcmstU2ltb24gSm9oYW5uc2VuIDxpbmZvQHlvc2lqby5kZT7CwIcEExYIAO8CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4ACGQEWIQT7FUMmNTClskaH0s4Ab4gSpLUn2QUCX1qZWzIU
 gAAAAAASABdwcm9vZkBtZXRhY29kZS5iaXp4bXBwOnlvc2lqb0Bhbm94aW5vbi5tZUIUgAAA
 AAASACdwcm9vZkBtZXRhY29kZS5iaXpodHRwczovL2NvZGViZXJnLm9yZy9Zb1NpSm8vZ2l0
 ZWFfcHJvb2Y9FIAAAAAAEgAicHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9zb2NpYWwuYW5v
 eGlub24uZGUvQFlvU2lKbwAKCRAAb4gSpLUn2RrRAQCz4zFtX/eKJkTM1RycEXJ5IVQfSh8l
 rch5Mxsmy0D3qgEA2wYe2z2KcxCtOwhQnIWgOfVDEhLdlHQLYOHvRWpfwgXOOARdr4BkEgor
 BgEEAZdVAQUBAQdAxuUf87WrJbYFeAy8GZCxjBuVlJzV2lv2IllOXTvGFFwDAQgHwngEGBYI
 ACAWIQT7FUMmNTClskaH0s4Ab4gSpLUn2QUCXa+AZAIbDAAKCRAAb4gSpLUn2XgtAP98QqPQ
 V7NaB1J8MuxLDQw8RM0gLTzLPW4Z79rt4i9+fQD/a2LgMh6mNBKsxC0flmPfJcGoDz7bCoVb
 2sQCdYXFaQc=
Subject: btrfs rescue chunk-recover: process_extent_buffer: BUG_ON
 `exist->nmirrors >= BTRFS_MAX_MIRRORS` triggered, value 1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I managed to disassemble my `btrfs` with a `btrfs balace start --force 
-sconvert=raid10 ...`.
Before it was `raid1c4` and it went to RO state right after the command.
Currently it is neither mountable nor can I backup the data with the 
`restore` command, even if I have enough other disk space to perform a 
full backup of the ~110TB.
Making it mountable again would of course be the best thing, but 
extracting all the data would be enough

General data:

```bash
# uname -a
Linux pve-003.wg.waima.nu 6.7.0-rc6-1-mainline #1 SMP PREEMPT_DYNAMIC 
Mon, 18 Dec 2023 22:45:10 +0000 x86_64 GNU/Linux
# btrfs --version
btrfs-progs v6.6.3
```

I have now tested the following points:

# mount -t btrfs -o rescue=all,ro …

```bash
mount: /mnt/btrfs/uuid/…: can't read superblock on /dev/….
        dmesg(1) may have more information after failed mount system call.
```

```
… kernel: BTRFS info (device dm-8): first mount of filesystem …
… kernel: BTRFS info (device dm-8): using crc32c (crc32c-intel) checksum 
algorithm
… kernel: BTRFS info (device dm-8): enabling all of the rescue options
… kernel: BTRFS info (device dm-8): ignoring data csums
… kernel: BTRFS info (device dm-8): ignoring bad roots
… kernel: BTRFS info (device dm-8): disabling log replay at mount time
… kernel: BTRFS info (device dm-8): using free space tree
… kernel: BTRFS critical (device dm-8): unable to find chunk map for 
logical 372783278997504 length 4096
… kernel: BTRFS critical (device dm-8): unable to find chunk map for 
logical 372783278997504 length 16384
… kernel: BTRFS critical (device dm-8): unable to find chunk map for 
logical 372783278997504 length 16384
… kernel: BTRFS error (device dm-8): failed to read chunk root
… kernel: BTRFS error (device dm-8): open_ctree failed
```

# btrfs check …

```bash
No mapping for 372783278997504-372783279013888
Couldn't map the block 372783278997504
Couldn't map the block 372783278997504
bad tree block 372783278997504, bytenr mismatch, want=372783278997504, 
have=0
ERROR: cannot read chunk root
ERROR: cannot open file system
Opening filesystem to check...
```

# btrfs-find-root …

```bash
No mapping for 372783278997504-372783279013888
Couldn't map the block 372783278997504
WARNING: cannot read chunk root, continue anyway
Superblock thinks the generation is 1783339
Superblock thinks the level is 1
```

# btrfs inspect-internal dump-super --all …

```bash
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x56803660 [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    cbeb1fd3-4088-47df-9bd8-51cf17ca7c7c
metadata_uuid           00000000-0000-0000-0000-000000000000
label
generation              1783339
root                    139816683683840
sys_array_size          193
chunk_root_generation   1783335
root_level              1
chunk_root              372783278997504
chunk_root_level        2
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             394801724502016
bytes_used              128324063105024
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             60
compat_flags            0x0
compat_ro_flags         0x3
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID )
incompat_flags          0xb71
                         ( MIXED_BACKREF |
                           COMPRESS_ZSTD |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES |
                           RAID1C34 )
cache_generation        0
uuid_tree_generation    1783339
dev_item.uuid           f855e608-48ae-411c-8c29-a66e46103520
dev_item.fsid           cbeb1fd3-4088-47df-9bd8-51cf17ca7c7c [match]
dev_item.type           0
dev_item.total_bytes    8001545375744
dev_item.bytes_used     7856112795648
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          85
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
superblock: bytenr=67108864, device=/dev/mapper/luks_1I_1_1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xf6e11eae [match]
bytenr                  67108864
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    cbeb1fd3-4088-47df-9bd8-51cf17ca7c7c
metadata_uuid           00000000-0000-0000-0000-000000000000
label
generation              1783339
root                    139816683683840
sys_array_size          193
chunk_root_generation   1783335
root_level              1
chunk_root              372783278997504
chunk_root_level        2
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             394801724502016
bytes_used              128324063105024
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             60
compat_flags            0x0
compat_ro_flags         0x3
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID )
incompat_flags          0xb71
                         ( MIXED_BACKREF |
                           COMPRESS_ZSTD |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES |
                           RAID1C34 )
cache_generation        0
uuid_tree_generation    1783339
dev_item.uuid           f855e608-48ae-411c-8c29-a66e46103520
dev_item.fsid           cbeb1fd3-4088-47df-9bd8-51cf17ca7c7c [match]
dev_item.type           0
dev_item.total_bytes    8001545375744
dev_item.bytes_used     7856112795648
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          85
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
superblock: bytenr=274877906944, device=/dev/mapper/luks_1I_1_1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x0b66489f [match]
bytenr                  274877906944
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    cbeb1fd3-4088-47df-9bd8-51cf17ca7c7c
metadata_uuid           00000000-0000-0000-0000-000000000000
label
generation              1783339
root                    139816683683840
sys_array_size          193
chunk_root_generation   1783335
root_level              1
chunk_root              372783278997504
chunk_root_level        2
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             394801724502016
bytes_used              128324063105024
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             60
compat_flags            0x0
compat_ro_flags         0x3
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID )
incompat_flags          0xb71
                         ( MIXED_BACKREF |
                           COMPRESS_ZSTD |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES |
                           RAID1C34 )
cache_generation        0
uuid_tree_generation    1783339
dev_item.uuid           f855e608-48ae-411c-8c29-a66e46103520
dev_item.fsid           cbeb1fd3-4088-47df-9bd8-51cf17ca7c7c [match]
dev_item.type           0
dev_item.total_bytes    8001545375744
dev_item.bytes_used     7856112795648
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          85
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
```

# btrfs rescue chunk-recover …

```bash
…
47, 67161509888 in dev48, 76915101696 in dev49, 55717744640 in dev50, 
63122264064 in dev51, 58334334976 in dev52, 65828638720 in dev53, 
61219491840 in dev54, 75106701312 in dev55, 58837127168 in dev56, 
67529822208 in dev57, 60326367232 in dev58, 59765116928 in 
dev59cmds/rescue-chunk-recover.c:131: process_extent_buffer: BUG_ON 
`exist->nmirrors >= BTRFS_MAX_MIRRORS` triggered, value 1
btrfs(+0xb0ad9)[0x5603f659bad9]
btrfs(+0xb13c2)[0x5603f659c3c2]
/usr/lib/libc.so.6(+0x8c9eb)[0x7ff253c8b9eb]
/usr/lib/libc.so.6(+0x1107cc)[0x7ff253d0f7cc]
Abgebrochen (Speicherabzug geschrieben)
```

# btrfs check --super …

```bash
# btrfs check --super 0 …
using SB copy 0, bytenr 65536
Opening filesystem to check...
No mapping for 372783278997504-372783279013888
Couldn't map the block 372783278997504
Couldn't map the block 372783278997504
bad tree block 372783278997504, bytenr mismatch, want=372783278997504, 
have=0
ERROR: cannot read chunk root
ERROR: cannot open file system
# btrfs check --super 1 …
using SB copy 1, bytenr 67108864
Opening filesystem to check...
No mapping for 372783278997504-372783279013888
Couldn't map the block 372783278997504
Couldn't map the block 372783278997504
bad tree block 372783278997504, bytenr mismatch, want=372783278997504, 
have=0
ERROR: cannot read chunk root
ERROR: cannot open file system
# btrfs check --super 2 …
using SB copy 2, bytenr 274877906944
Opening filesystem to check...
No mapping for 372783278997504-372783279013888
Couldn't map the block 372783278997504
Couldn't map the block 372783278997504
bad tree block 372783278997504, bytenr mismatch, want=372783278997504, 
have=0
ERROR: cannot read chunk root
ERROR: cannot open file system
```

The most problematic thing for me is that `btrfs restore` does not work 
either, otherwise I could backup everything away.
I also found this issue 
(https://github.com/kdave/btrfs-progs/issues/130), but it has a somewhat 
loaded history and I'm not sure if my case fits here.
If anything else is needed, I'll be happy to submit it and if it's 
better, I'll be happy to open an issue in 
https://github.com/kdave/btrfs-progs/

Yours sincerely,
York


