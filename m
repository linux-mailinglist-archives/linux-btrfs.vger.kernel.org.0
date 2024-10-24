Return-Path: <linux-btrfs+bounces-9124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7699AE030
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 11:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB11F2244E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305FA1B219E;
	Thu, 24 Oct 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/D42Dqk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDBD2FC52
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761070; cv=none; b=O/Q/sIs63kFwudYB6IrEPfZkokGaEVap0woBj5oARhPfGlhmwadwO8VHHdewjfcjUtHDe38ZUEnoEzAwW6OxqSyvgGy4rIYl9qxsDk8+WGtKrpI/px1NmKT7sjzIuTnuHeGXeSBHSBpAA5lHGHinMr0ISTwWcuUrYt5IY8XFfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761070; c=relaxed/simple;
	bh=OUTLQYJppcMUfLZEjg7CxXbyF1N28CRIhxa5VMiheyQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nSGOz+f0xJjZZbRyGghkWJTx82mv9w69OcKeZD2lseo0CGn9dbRYVdMJdPsTadZHFNuz/Bnlk5VsD6i6kx470oPoiSm19A9QGJJ+UJAgjG7QpgiXlFc1ndiVTkHb7n6Kpg+V8F+5NMXvkRb5EEE2mG6smr6F9I5QGb0hIpdb9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/D42Dqk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a017a382bso11980566b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761065; x=1730365865; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pp5VW/b43xEkgilU2AdfCWfBFtMrKqkpg5xCHgjgw6E=;
        b=h/D42DqkaEB9hG7iHAX5yK5O/RcwNw0pkRW52x4/UKxCGOktahgMpTxXfLCkaK5g4T
         Og+hoHCBSAalSyPO2jg/ZSOu9bs78dkBmwoSZfHB51kEjQesADBEnVX36CGQ8w7n9+UO
         Tre72lJEcy1G7MAoHDNDP2Qzk0exGrg9fyaoAcrzETGwnYH7o1DAL30AzCd9N7wQFMXj
         J/XSMB/0Shw8IhdeSIKGim+uRyWhnkpzRryYajIhU03tiIdhWmnQvW/g0mWf6njChlpU
         lkzBq0TnwbDf/WNDb7yxNMDklw9RZRTF1ZRqnlI1x3wAF37xPnP16znaoU1EbtluYJfj
         ct3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761065; x=1730365865;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pp5VW/b43xEkgilU2AdfCWfBFtMrKqkpg5xCHgjgw6E=;
        b=FzBC6WALLOXdE0NGZ2ZeLqtTjIcxnRNxT/BMHHU8z6Uqz6VqId7ohTs7+NuNeKAIXY
         tkCD2Equa0N1QP/tfY7HEmO0ZKIrB4GZJDg7yboOyeuwHsnimkIZ+EVN5Lc0YB8cyQrS
         tEZzqwWqStUHmYq1FyubWe2Xq8daDGKdxarcyUisIp881Gy7f7umuXlDJOGBdKGai/mP
         FNXc6/x3jmLBXDmt0ZTDC70oVuCCiHIGIcAYHAs8ptlMsfbMBBtsTj5CNr8sn2Xbf9tg
         mKYdE7OFyKG77CXkqisrg12XeNNfZWDEkFKpdjTzYeOLH/IWz0eYzj0vbSKcFh3BSLbK
         npGw==
X-Gm-Message-State: AOJu0Yy8FfKiJZVNj8GD6plWapGeqZjsJ8ccmnB9ejTjLGeCDw1Vbs8I
	GVwuWS1c8GMzZRWjbSRte0wOCrTP3EfXztJt9D0W8eJSXSNjSQi+z+W+gFCLggj2TlzvPiyXOZ/
	ttehvRGYT1XlDHLnkep/8L6HdDl4OO2Xy
X-Google-Smtp-Source: AGHT+IFUWCAiPYOJtU++U7XawnU4t3S8ZFuvkfiLSNQ1KnGAL9iZ8zRp2CiRgipEOXgXatoe2ysZuclFVhXIJ2oCjJw=
X-Received: by 2002:a17:906:3b92:b0:a9a:cee1:3cc9 with SMTP id
 a640c23a62f3a-a9acee13ef4mr63727866b.13.1729761064615; Thu, 24 Oct 2024
 02:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dikus Extrange <dikus.android@gmail.com>
Date: Thu, 24 Oct 2024 11:09:51 +0200
Message-ID: <CAJtTrbTpb82JzmtKxU6X5BvgWLHeQ=J2Tx+q8XgP-CTz1h=+Rg@mail.gmail.com>
Subject: Help recovering data from Btrfs filesystem on Raspberry Pi
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have a hard drive connected to a Raspberry Pi that I turn on and off
every day. Today, the drive did not mount, so I tried to check what
was wrong and saw that it had errors when mounting. Could you please
help me recover the data if possible?

Some information about my system:

#btrfs --version
btrfs-progs v6.2

#uname -a
Linux raspberrypi 6.6.51+rpt-rpi-v8 #1 SMP PREEMPT Debian
1:6.6.51-1+rpt3 (2024-10-08) aarch64 GNU/Linux


I have been googling to try to find some help or solution, and these
are some things I have tried:

* sudo btrfs check /dev/sdc2

Opening filesystem to check...
parent transid verify failed on 2443752472576 wanted 123957 found 123955
parent transid verify failed on 2443752472576 wanted 123957 found 123955
parent transid verify failed on 2443752472576 wanted 123957 found 123955
Ignoring transid failure
parent transid verify failed on 2443740397568 wanted 123957 found 123955
parent transid verify failed on 2443740397568 wanted 123957 found 123955
parent transid verify failed on 2443740397568 wanted 123957 found 123955
Ignoring transid failure
ERROR: root [5 0] level 0 does not match 2

ERROR: cannot open file system


* sudo mount -t btrfs -o ro,rescue=all /dev/sdc2 CallistoBk

mount: /media/CallistoBk: can't read superblock on /dev/sdc2.
       dmesg(1) may have more information after failed mount system call.


dmesg output:

[jue oct 24 10:51:22 2024] BTRFS: device label Callisto devid 1
transid 123959 /dev/sdc2 scanned by mount (59524)
[jue oct 24 10:51:22 2024] BTRFS info (device sdc2): first mount of
filesystem eef34502-757e-4684-bef5-cb444789952e
[jue oct 24 10:51:22 2024] BTRFS info (device sdc2): using crc32c
(crc32c-generic) checksum algorithm
[jue oct 24 10:51:22 2024] BTRFS info (device sdc2): enabling all of
the rescue options
[jue oct 24 10:51:22 2024] BTRFS info (device sdc2): ignoring data csums
[jue oct 24 10:51:22 2024] BTRFS info (device sdc2): ignoring bad roots
[jue oct 24 10:51:22 2024] BTRFS info (device sdc2): disabling log
replay at mount time
[jue oct 24 10:51:22 2024] BTRFS info (device sdc2): using free space tree
[jue oct 24 10:51:22 2024] BTRFS error (device sdc2: state C): parent
transid verify failed on logical 2443752472576 mirror 1 wanted 123957
found 123955
[jue oct 24 10:51:22 2024] BTRFS error (device sdc2: state C): parent
transid verify failed on logical 2443752472576 mirror 2 wanted 123957
found 123955
[jue oct 24 10:51:44 2024] BTRFS info (device sdc2: state C): auto
enabling async discard
[jue oct 24 10:51:44 2024] BTRFS error (device sdc2: state C): level
verify failed on logical 2443740397568 mirror 1 wanted 2 found 0
[jue oct 24 10:51:44 2024] BTRFS error (device sdc2: state C): level
verify failed on logical 2443740397568 mirror 2 wanted 2 found 0
[jue oct 24 10:51:44 2024] BTRFS warning (device sdc2: state C):
failed to read fs tree: -5
[jue oct 24 10:51:44 2024] BTRFS error (device sdc2: state C): open_ctree failed


* sudo btrfs-find-root /dev/sdc2

parent transid verify failed on 2443752472576 wanted 123957 found 123955
parent transid verify failed on 2443752472576 wanted 123957 found 123955
parent transid verify failed on 2443740397568 wanted 123957 found 123955
parent transid verify failed on 2443740397568 wanted 123957 found 123955
Superblock thinks the generation is 123959
Superblock thinks the level is 1
Found tree root at 2996263q829504 gen 123959 level 1
> Well block 2443816222720(gen: 123958 level: 1) seems good, but generation/level doesn't match, want gen: 123959 level: 1
Well block 2443815534592(gen: 123957 level: 0) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2443740069888(gen: 123955 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2443266932736(gen: 123952 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 1780725301248(gen: 123951 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 297811968(gen: 123950 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2443266670592(gen: 123948 level: 0) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 1780550598656(gen: 123942 level: 0) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2995981926400(gen: 123940 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2995989037056(gen: 123939 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2995983581184(gen: 123937 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2995960053760(gen: 123936 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2443266818048(gen: 123935 level: 0) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 1781142601728(gen: 123895 level: 0) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2996027015168(gen: 123745 level: 1) seems good, but
generation/level doesn't match, want gen: 123959 level: 1
Well block 2443760402432(gen: 84050 level: 0) seems good, but
generation/level doesn't match, want gen: 123959 level: 1

Not success trying:
sudo btrfs check --tree-root 2996263829504 --super 1 /dev/sdc2

* Here is a dump:

sudo btrfs ins dump-super -fa /dev/sdc2

superblock: bytenr=65536, device=/dev/sdc2
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xe7606b92 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    eef34502-757e-4684-bef5-cb444789952e
metadata_uuid           eef34502-757e-4684-bef5-cb444789952e
label                   Callisto
generation              123959
root                    2996263829504
sys_array_size          258
chunk_root_generation   122414
root_level              1
chunk_root              3435031166976
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             5000683061248
bytes_used              3409085583360
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x3
                        ( FREE_SPACE_TREE |
                          FREE_SPACE_TREE_VALID )
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        0
uuid_tree_generation    123959
dev_item.uuid           a2f26bff-9e99-4f6e-a659-e842935e5ced
dev_item.fsid           eef34502-757e-4684-bef5-cb444789952e [match]
dev_item.type           0
dev_item.total_bytes    5000683061248
dev_item.bytes_used     3421033725952
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
                length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 22020096
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
                        stripe 1 devid 1 offset 30408704
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 3435031166976)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 2951755071488
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
                        stripe 1 devid 1 offset 2951788625920
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
backup_roots[4]:
        backup 0:
                backup_tree_root:       2443816222720   gen: 123958     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443759353856   gen: 123957     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409089089536
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       2443816222720   gen: 123958     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443752718336   gen: 123958     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409085583360
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       2996263829504   gen: 123959     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2996263845888   gen: 123959     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409085583360
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       2443752718336   gen: 123956     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443753848832   gen: 123956     level: 2
                backup_fs_root:         2443753177088   gen: 123956     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409089122304
                backup_num_devices:     1


superblock: bytenr=67108864, device=/dev/sdc2
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x4701435c [match]
bytenr                  67108864
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    eef34502-757e-4684-bef5-cb444789952e
metadata_uuid           eef34502-757e-4684-bef5-cb444789952e
label                   Callisto
generation              123959
root                    2996263829504
sys_array_size          258
chunk_root_generation   122414
root_level              1
chunk_root              3435031166976
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             5000683061248
bytes_used              3409085583360
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x3
                        ( FREE_SPACE_TREE |
                          FREE_SPACE_TREE_VALID )
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        0
uuid_tree_generation    123959
dev_item.uuid           a2f26bff-9e99-4f6e-a659-e842935e5ced
dev_item.fsid           eef34502-757e-4684-bef5-cb444789952e [match]
dev_item.type           0
dev_item.total_bytes    5000683061248
dev_item.bytes_used     3421033725952
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
                length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 22020096
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
                        stripe 1 devid 1 offset 30408704
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 3435031166976)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 2951755071488
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
                        stripe 1 devid 1 offset 2951788625920
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
backup_roots[4]:
        backup 0:
                backup_tree_root:       2443816222720   gen: 123958     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443759353856   gen: 123957     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409089089536
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       2443816222720   gen: 123958     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443752718336   gen: 123958     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409085583360
                backup_num_devices:     1
        backup 2:
                backup_tree_root:       2996263829504   gen: 123959     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2996263845888   gen: 123959     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409085583360
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       2443752718336   gen: 123956     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443753848832   gen: 123956     level: 2
                backup_fs_root:         2443753177088   gen: 123956     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409089122304
                backup_num_devices:     1


superblock: bytenr=274877906944, device=/dev/sdc2
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xba86156d [match]
bytenr                  274877906944
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    eef34502-757e-4684-bef5-cb444789952e
metadata_uuid           eef34502-757e-4684-bef5-cb444789952e
label                   Callisto
generation              123959
root                    2996263829504
sys_array_size          258
chunk_root_generation   122414
root_level              1
chunk_root              3435031166976
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             5000683061248
bytes_used              3409085583360
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x3
                        ( FREE_SPACE_TREE |
                          FREE_SPACE_TREE_VALID )
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        0
uuid_tree_generation    123959
dev_item.uuid           a2f26bff-9e99-4f6e-a659-e842935e5ced
dev_item.fsid           eef34502-757e-4684-bef5-cb444789952e [match]
dev_item.type           0
dev_item.total_bytes    5000683061248
dev_item.bytes_used     3421033725952
dev_item.io_align       4096
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
                length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 22020096
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
                        stripe 1 devid 1 offset 30408704
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 3435031166976)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 2951755071488
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
                        stripe 1 devid 1 offset 2951788625920
                        dev_uuid a2f26bff-9e99-4f6e-a659-e842935e5ced
backup_roots[4]:
        backup 0:
                backup_tree_root:       2443816222720   gen: 123958     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443759353856   gen: 123957     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409089089536
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       2443816222720   gen: 123958     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443752718336   gen: 123958     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409085583360
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       2996263829504   gen: 123959     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2996263845888   gen: 123959     level: 2
                backup_fs_root:         2443740397568   gen: 123957     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409085583360
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       2443752718336   gen: 123956     level: 1
                backup_chunk_root:      3435031166976   gen: 122414     level: 1
                backup_extent_root:     2443753848832   gen: 123956     level: 2
                backup_fs_root:         2443753177088   gen: 123956     level: 2
                backup_dev_root:        297910272       gen: 123950     level: 1
                csum_root:      2443774033920   gen: 123935     level: 3
                backup_total_bytes:     5000683061248
                backup_bytes_used:      3409089122304
                backup_num_devices:     1


I'm concerned about losing the data on this drive, as it contains
important files. Any help troubleshooting this issue and recovering
the data would be greatly appreciated.

Thank you in advance,
Dikus.

