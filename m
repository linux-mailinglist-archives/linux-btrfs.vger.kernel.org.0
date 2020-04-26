Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229A11B8CE6
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDZGXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 02:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgDZGXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 02:23:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E94C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 23:23:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m67so14729782qke.12
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO4MFmodN2OBMNhKugBt3jPIb1zqwXADT0MQxWxxEig=;
        b=lomdza/wftM6r6LhzK6CQVEC24pnLd+NWNIUEZbavHSxYITM94mqYF9lcdNFEIinbR
         bqpn+Sh6USBJ9Ch8+DVjZTAYI5OngVjMqXbUOQ+0GPy57uEKNAZGNgPnnttFlHqbchjV
         nkskicmlquTPgLqr8ekyPpH7jVvh4UtdHIEA3Pkpjf0xnCuURqpswAiBiBCJwxxwVSPX
         xJ7AGn4NG2ksZBbR/uouGQtiVTr+ucvTauGKnvEDRdKcqVqfEkyfMMfNHFzncNRHt5No
         wWyZtjrectpQgjsYztKL/Qc7wp+d0KUaxqfWJTZvGVjuSn6eGKpud9mvhL+PeEY4Oung
         s/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO4MFmodN2OBMNhKugBt3jPIb1zqwXADT0MQxWxxEig=;
        b=rPR7miEagGjpPe4soPpOMUrAvKcD1SI4kBA8AgJNCrdaZNjTZEMQ4Jc6hZyUdTCsSC
         F84gPbIOplGhdRVsibfV/cHo1jzxf4H9h/PtMIISWLfz8McZCX1lePMIMZDHqgSwFWQW
         fc9LFQiOd1bak+jZnYwSMxqtEDm9rOS3Tpo2b3CUoyFw3QTeIqRnpdFNYoTIoiCnX5yx
         4K4nVvtuPip5+84vPsB75myTn0xOFKG+swwI3j8vKzXxy3z7NzXcD+HxAdtKG60tzQ9J
         aoMoCO/gflJM6TIIe3Z2As/SkwD1xcVgpLYWWenu6Lu3dYE4zvoZf/u16AfvI263NuVe
         JVMg==
X-Gm-Message-State: AGi0PualR4eazMn3DlYuU7pCDcXxWckleT12fd5TuuPl4pogYyaq3mZJ
        K6Rpbqwg/Zewe2/DTeKv/IrGHAc5m/NSlDXkjQjnrLFNHkQ=
X-Google-Smtp-Source: APiQypIC7OMhWJVL0NUxPwAFRvA+puITJqYABkT1bEppNLCgNfcf4b2vD3STMwUiPGYbMjo50u/p93u9/mZYKHvuoAw=
X-Received: by 2002:a37:9ad0:: with SMTP id c199mr15747349qke.472.1587882199382;
 Sat, 25 Apr 2020 23:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
 <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com>
 <CAP7ccd8u-pStGzCau+bcYEVjRy+SPE+JQz169i_2NiY8dfUXuQ@mail.gmail.com> <CAJCQCtSdyP_SspJGwitWSOM1mvT-_ykXGq_azk=R+jqCZ+V4Yw@mail.gmail.com>
In-Reply-To: <CAJCQCtSdyP_SspJGwitWSOM1mvT-_ykXGq_azk=R+jqCZ+V4Yw@mail.gmail.com>
From:   Yegor Yegorov <gochkin@gmail.com>
Date:   Sun, 26 Apr 2020 09:23:08 +0300
Message-ID: <CAP7ccd8WTtCMb2t4FWPEwrh+d3sNSPrkkpa4R=Z91-ieXK_vMA@mail.gmail.com>
Subject: Re: Help needed to recover from partition resize/move
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, arvidjaar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> What do you get for
>
> btrfs insp dump-s -f /dev/nvme0n1p3
> btfs insp dump-t -d /dev/nvme0n1p3

$> btrfs insp dump-s -f /dev/nvme0n1p3

superblock: bytenr=65536, device=/dev/nvme0n1p3
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x043ea018 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    90e9d74c-3606-4028-9e72-c10e76f44a7c
metadata_uuid           90e9d74c-3606-4028-9e72-c10e76f44a7c
label                   data
generation              49
root                    8612052992
sys_array_size          97
chunk_root_generation   46
root_level              1
chunk_root              1048576
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             188743680000
bytes_used              182011633664
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        48
uuid_tree_generation    48
dev_item.uuid           e2815a2c-6ec8-45c6-baae-7f429a5f0f78
dev_item.fsid           90e9d74c-3606-4028-9e72-c10e76f44a7c [match]
dev_item.type           0
dev_item.total_bytes    188743680000
dev_item.bytes_used     184704565248
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576)
                length 4194304 owner 2 stripe_len 65536 type SYSTEM
                io_align 4096 io_width 4096 sector_size 4096
                num_stripes 1 sub_stripes 0
                        stripe 0 devid 1 offset 1048576
                        dev_uuid e2815a2c-6ec8-45c6-baae-7f429a5f0f78
backup_roots[4]:
        backup 0:
                backup_tree_root:       8612052992      gen: 49 level: 1
                backup_chunk_root:      1048576 gen: 46 level: 1
                backup_extent_root:     8612069376      gen: 49 level: 1
                backup_fs_root:         8852570112      gen: 47 level: 2
                backup_dev_root:        8843755520      gen: 46 level: 0
                backup_csum_root:       8853471232      gen: 48 level: 2
                backup_total_bytes:     188743680000
                backup_bytes_used:      182011633664
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       8852389888      gen: 46 level: 1
                backup_chunk_root:      1048576 gen: 46 level: 1
                backup_extent_root:     8843722752      gen: 46 level: 1
                backup_fs_root:         8842969088      gen: 46 level: 2
                backup_dev_root:        8843755520      gen: 46 level: 0
                backup_csum_root:       8843018240      gen: 46 level: 2
                backup_total_bytes:     188743680000
                backup_bytes_used:      182011633664
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       8853127168      gen: 47 level: 1
                backup_chunk_root:      1048576 gen: 46 level: 1
                backup_extent_root:     8852865024      gen: 47 level: 1
                backup_fs_root:         8852570112      gen: 47 level: 2
                backup_dev_root:        8843755520      gen: 46 level: 0
                backup_csum_root:       8853192704      gen: 47 level: 2
                backup_total_bytes:     188743680000
                backup_bytes_used:      182011633664
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       8853389312      gen: 48 level: 1
                backup_chunk_root:      1048576 gen: 46 level: 1
                backup_extent_root:     8853405696      gen: 48 level: 1
                backup_fs_root:         8852570112      gen: 47 level: 2
                backup_dev_root:        8843755520      gen: 46 level: 0
                backup_csum_root:       8853471232      gen: 48 level: 2
                backup_total_bytes:     188743680000
                backup_bytes_used:      182011633664
                backup_num_devices:     1

$> btrfs insp dump-t -d /dev/nvme0n1p3
btrfs-progs v5.6
checksum verify failed on 1048576 found 00000067 wanted 0000006E
checksum verify failed on 1048576 found 00000067 wanted 0000006E
bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
ERROR: cannot read chunk root
ERROR: unable to open /dev/nvme0n1p3




As Andrei Borzenko has stated it is indeed the third superblock:

$> btrfs insp dump-super -a /dev/nvme0n1p3

superblock: bytenr=65536, device=/dev/nvme0n1p3
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x043ea018 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    90e9d74c-3606-4028-9e72-c10e76f44a7c
metadata_uuid           90e9d74c-3606-4028-9e72-c10e76f44a7c
label                   data
generation              49
root                    8612052992
sys_array_size          97
chunk_root_generation   46
root_level              1
chunk_root              1048576
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             188743680000
bytes_used              182011633664
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        48
uuid_tree_generation    48
dev_item.uuid           e2815a2c-6ec8-45c6-baae-7f429a5f0f78
dev_item.fsid           90e9d74c-3606-4028-9e72-c10e76f44a7c [match]
dev_item.type           0
dev_item.total_bytes    188743680000
dev_item.bytes_used     184704565248
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

superblock: bytenr=67108864, device=/dev/nvme0n1p3
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xa45f88d6 [match]
bytenr                  67108864
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    90e9d74c-3606-4028-9e72-c10e76f44a7c
metadata_uuid           90e9d74c-3606-4028-9e72-c10e76f44a7c
label                   data
generation              49
root                    8612052992
sys_array_size          97
chunk_root_generation   46
root_level              1
chunk_root              1048576
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             188743680000
bytes_used              182011633664
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        48
uuid_tree_generation    48
dev_item.uuid           e2815a2c-6ec8-45c6-baae-7f429a5f0f78
dev_item.fsid           90e9d74c-3606-4028-9e72-c10e76f44a7c [match]
dev_item.type           0
dev_item.total_bytes    188743680000
dev_item.bytes_used     184704565248
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

superblock: bytenr=274877906944, device=/dev/nvme0n1p3
---------------------------------------------------------
ERROR: bad magic on superblock on /dev/nvme0n1p3 at 274877906944
