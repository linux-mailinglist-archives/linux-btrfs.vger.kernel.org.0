Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68305364550
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 15:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhDSNyz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhDSNyu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 09:54:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AEC061760
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Apr 2021 06:54:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i3so15125177edt.1
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Apr 2021 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=M6uHE6jjBZe04tOxKKarx6lYdPjq/wcAavGTDbvevho=;
        b=dZewkhs3BVug/i2gNAGYtnMMf7oXbm7fVEsqC3vFiQ4cCwUWH7h/6h2a2H2dTEQi7N
         Ju0PBq/o8F44gQZoS1qt+VFLKKpL4BHtMViaNoKPFDEQXyQXs8fBF+CbRg6LCXI6iJtB
         4+R6mkZGqAetSx37Wbvjgao/T7TqAj9f1QXn4XDXAGsNbxxoha0Zsihr5bpWF7SIcpbc
         a6PzM51uduqXDRph7XY+3OYM2PXE6+ZEuAlWcVAjdx3hEu9lL6VoksEzuMb524D0xGEy
         YGo21+xa6CgyDQhjNBqW8Kylr7yG4Yp1h4FA6Y2G4RoNmDGGcPOlBOMzQYbvt+nn0fIV
         3WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=M6uHE6jjBZe04tOxKKarx6lYdPjq/wcAavGTDbvevho=;
        b=JNZObQHVoeuRsW/qroNOUVWzYWU24/iSJ08LJuqbOEBziQ6bkmKLGZ9eihS2pH2Ep6
         zTkLJ8ZyGRISI13yWc7Ck3Dk7J9zCPR56fCrFAFaoAF88QWoKrif9i1GEl2BwFTW0s0B
         FP0iMyvXthpeGrJPDEkth8LVPejLy6hqkdH6NceaCnsE+pWt9riKcOslNuNfdOQFKyMq
         7rDHO9Qbq8qITT7DkB8mNh2s2Vx2GDad1sZ6ZFgAlQTXPxRPTiMkQN87ydyMlfvv7Pv6
         79CthhuUkQqLRIoHWvWejub0NzUFy8tVYlsWLb/1PNTY1WwjhUpdZmN8FsWbikx2kfSh
         Dopg==
X-Gm-Message-State: AOAM532RPbsezdz1vnSQWDLYXJGEfiDHSZsSRehyw3Mu4gaNcMOMrgTm
        MCczTgrtf+T8CnT68zFt4w==
X-Google-Smtp-Source: ABdhPJyzoEbHg7rhv/w7gqDD8IOn2aLqvo5dEHVgpxeKcTjIfFVeSQ8jYBu3c87wh4Y6/EzlSSsm8g==
X-Received: by 2002:aa7:c5c6:: with SMTP id h6mr24815492eds.136.1618840458894;
        Mon, 19 Apr 2021 06:54:18 -0700 (PDT)
Received: from [192.168.1.217] (p5b3f756a.dip0.t-ipconnect.de. [91.63.117.106])
        by smtp.gmail.com with ESMTPSA id a17sm10643051ejx.13.2021.04.19.06.54.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 06:54:18 -0700 (PDT)
From:   Fabian Otto <fabian.otto.de@googlemail.com>
X-Google-Original-From: Fabian Otto <fabian.otto.de@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Help needed with read time tree block corruption on single disk mDUP
 drive
Message-ID: <509577cc-ede3-5b85-1618-24944de7f7c3@gmail.com>
Date:   Mon, 19 Apr 2021 15:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a USB-HDD of 2TB size with metadata DUP . After an unclean 
shutdown I now cannot mount it anymore.

My question is what (possibly destructive) rescue operation to try next 
after having backuped the corrupted disk elsewhere first.
I am thinking of `btrfs check --init-extent-tree` or `btrfs rescue 
chunk-recover`
Unfortunately I'm not well versed enough in btrfs to know what precisely 
that would do, or if it would help at all or just make it worse.

I also don't know how to use that less corrupted DUPlicated version of 
the FStree to get the disk to be mountable again, which, if I understand 
it correctly, would open up scrub and balance as other possible repair 
options.


Thanks in advance for your help and awesome filesystem.
Cheers!


Here's what I've done so far:

$ uname -a
Linux Fabian-openSUSE 5.11.12-1-default #1 SMP Wed Apr 7 17:30:21 UTC 
2021 (92a542e) x86_64 x86_64 x86_64 GNU/Linux

$ sudo btrfs --version
[sudo] password for root:
btrfs-progs v5.11

$ sudo btrfs fi show
Label: 'BTRFS-Archive'  uuid: 2566e7c1-1e0f-40eb-ab68-914e5c346884
         Total devices 1 FS bytes used 1.60TiB
         devid    1 size 1.82TiB used 1.61TiB path /dev/sdb2

dmesg outputs the following with `mount -o rescue=all,ro`
[23079.810710] BTRFS info (device sdb2): enabling all of the rescue options
[23079.810713] BTRFS info (device sdb2): ignoring data csums
[23079.810713] BTRFS info (device sdb2): ignoring bad roots
[23079.810715] BTRFS info (device sdb2): disabling log replay at mount time
[23079.810716] BTRFS info (device sdb2): disk space caching is enabled
[23079.810717] BTRFS info (device sdb2): has skinny extents
[23079.925185] BTRFS info (device sdb2): bdev /dev/sdb2 errs: wr 0, rd 
0, flush 0, corrupt 51, gen 0
[23080.156357] BTRFS critical (device sdb2): corrupt leaf: root=1 
block=449881636864 slot=18 ino=2276, invalid inode generation: has 13167 
expect (0, 13165]
[23080.156377] BTRFS error (device sdb2): block=449881636864 read time 
tree block corruption detected
[23080.169840] BTRFS critical (device sdb2): corrupt leaf: root=1 
block=449881636864 slot=18 ino=2276, invalid inode generation: has 13167 
expect (0, 13165]
[23080.169859] BTRFS error (device sdb2): block=449881636864 read time 
tree block corruption detected
[23080.169891] BTRFS error (device sdb2): failed to read block groups: -5
[23080.173682] BTRFS error (device sdb2): open_ctree failed

$ sudo btrfs check /dev/sdb2
Opening filesystem to check...
parent transid verify failed on 449881636864 wanted 12615 found 13172
parent transid verify failed on 449881636864 wanted 12615 found 13172
parent transid verify failed on 449881636864 wanted 12615 found 13172
Ignoring transid failure
leaf parent key incorrect 449881636864
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system


I have already run `btrfs rescue super-recover` and `btrfs rescue 
zero-log` without success.


Luckily I have set up that disk with metadata DUP so I was able to do

$ sudo btrfs check -r 30408704 -s1 -p /dev/sdb2

and

$ sudo btrfs restore -D -t 30408704 -i /dev/sdb2 1TB-Platte2/

After finding that (stripe 1) offset via

$ sudo btrfs inspect-internal dump-super -f /dev/sdb2
superblock: bytenr=65536, device=/dev/sdb2
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x236347b4 [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    2566e7c1-1e0f-40eb-ab68-914e5c346884
metadata_uuid           2566e7c1-1e0f-40eb-ab68-914e5c346884
label                   BTRFS-Archive
generation              13164
root                    2271131025408
sys_array_size          129
chunk_root_generation   13160
root_level              1
chunk_root              22036480
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             2000188080128
bytes_used              1759527608320
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x179
                         ( MIXED_BACKREF |
                           COMPRESS_LZO |
                           COMPRESS_ZSTD |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA )
cache_generation        13164
uuid_tree_generation    13164
dev_item.uuid           5dda7f3a-edeb-45ed-8a94-d1c11bc74400
dev_item.fsid           2566e7c1-1e0f-40eb-ab68-914e5c346884 [match]
dev_item.type           0
dev_item.total_bytes    2000188080128
dev_item.bytes_used     1765256724480
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
                 io_align 65536 io_width 65536 sector_size 4096
                 num_stripes 2 sub_stripes 0
                         stripe 0 devid 1 offset 22020096
                         dev_uuid 5dda7f3a-edeb-45ed-8a94-d1c11bc74400
                         stripe 1 devid 1 offset 30408704
                         dev_uuid 5dda7f3a-edeb-45ed-8a94-d1c11bc74400
backup_roots[4]:
         backup 0:
                 backup_tree_root:       2271131025408   gen: 13164      
level: 1
                 backup_chunk_root:      22036480        gen: 13160      
level: 1
                 backup_extent_root:     2271131041792   gen: 13164      
level: 2
                 backup_fs_root:         2271132139520   gen: 13163      
level: 2
                 backup_dev_root:        2271131910144   gen: 13164      
level: 1
                 backup_csum_root:       2271144263680   gen: 13164      
level: 2
                 backup_total_bytes:     2000188080128
                 backup_bytes_used:      1759527608320
                 backup_num_devices:     1

         backup 1:
                 backup_tree_root:       2271522717696   gen: 13161      
level: 1
                 backup_chunk_root:      22036480        gen: 13160      
level: 1
                 backup_extent_root:     2271427756032   gen: 13161      
level: 2
                 backup_fs_root:         2271659212800   gen: 13162      
level: 2
                 backup_dev_root:        2271845613568   gen: 13160      
level: 1
                 backup_csum_root:       2271115018240   gen: 13161      
level: 2
                 backup_total_bytes:     2000188080128
                 backup_bytes_used:      1759125020672
                 backup_num_devices:     1

         backup 2:
                 backup_tree_root:       2271131172864   gen: 13162      
level: 1
                 backup_chunk_root:      22036480        gen: 13160      
level: 1
                 backup_extent_root:     2271126110208   gen: 13162      
level: 2
                 backup_fs_root:         2271659212800   gen: 13162      
level: 2
                 backup_dev_root:        2271845613568   gen: 13160      
level: 1
                 backup_csum_root:       2272123355136   gen: 13162      
level: 2
                 backup_total_bytes:     2000188080128
                 backup_bytes_used:      1759290830848
                 backup_num_devices:     1

         backup 3:
                 backup_tree_root:       2271143755776   gen: 13163      
level: 1
                 backup_chunk_root:      22036480        gen: 13160      
level: 1
                 backup_extent_root:     2271141412864   gen: 13163      
level: 2
                 backup_fs_root:         2271132139520   gen: 13163      
level: 2
                 backup_dev_root:        2271845613568   gen: 13160      
level: 1
                 backup_csum_root:       2271132188672   gen: 13163      
level: 2
                 backup_total_bytes:     2000188080128
                 backup_bytes_used:      1759527608320
                 backup_num_devices:     1


