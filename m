Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938C8342BC8
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 12:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCTLMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCTLML (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:11 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41DC05BD40
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 04:03:47 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so11028683ota.9
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vwlfen1PlEcRPhw1oOJnYCO6muzCZdyQOAMVQZcoYTo=;
        b=RsLyECZM8xIEFml2cQ/tfYM7DPB3/iogGCWbSLCKG/c3n7QiCZAKuW4K/6q+iUHKYE
         fnDhq1FsKDExhIGsCFD0iqzScnNwQ+CH79testqdwsaqRWrFKz3ny/BxvO91tmIMHgbb
         Zx3owDjw4SBjpGekl8UVGzvH6Q73LgsNwP0sIotmClNN65enOR8FBlo7Xike4rZOQnX+
         bAubClylIk8h8gZPhlKCs7C47d8++6dznCHbi++bVrSCH2EJ0SJr4Szlxi4J1tfXHAXc
         NF6Gu3lonCGaeL9j9p0UUFGMAEv2WxU9DTzWPN1xHZ1I+bDEyg1+fntwhzsSWxt2czL2
         ISQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vwlfen1PlEcRPhw1oOJnYCO6muzCZdyQOAMVQZcoYTo=;
        b=mly00LsiL5cbfiLqO1NqkzDF8sDZttpx/GnHN6R78npYpBzvREKbiy3lKGJTH3oNKo
         01cr+4ZJ5J8PWwDDbRXS7Mz3uUdoumgrO5v9pze+0xbgFu49qPjhDVKOhu+SgqeeOv2q
         QWIteYQFrfb6L6GmRWD/chl9ej9gBVQtGf+D8aRi5asU6zcrk/vWh6BBUhXalcA8VJTo
         v3sWmiRHLRRCTPzyOAsZg4oSUHS9WNdRTICsRLzIx3Vcm4bt8Rm9K5AYHV6Tac6n3ypi
         +Y8+iqQefeoiiDBTI8OIU8EHmXy+dzANQpoaSkAwZnwEQqNyQcE3ruGOK12xjaLdHjaG
         9esQ==
X-Gm-Message-State: AOAM5305r5c7DnSFcYlQw3OPJzgwgQtCHYUL2N+YhaI8/1fw/RygyT98
        379Swhf8kkS37w2arxPX4mwkkcwziD/uoyJH4aS9vE1AW2pLjg==
X-Google-Smtp-Source: ABdhPJzwLm6L+VqY4bRsDGsV1i+tgu2d13K0Ej38vHg4M3M+7IWXfc/qxz5A5TRrTceOcFLjtEMbdUU0jQwjj9Xrv2k=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr3930811otr.274.1616223101384;
 Fri, 19 Mar 2021 23:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
In-Reply-To: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Sat, 20 Mar 2021 02:51:30 -0400
Message-ID: <CAGdWbB6+1fqjWzAKvC8WV--FF8_2r9psLix_YeRBo=UVh33Ocw@mail.gmail.com>
Subject: Re: parent transid verify failed / ERROR: could not setup extent tree
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 20, 2021 at 2:33 AM Dave T <davestechshop@gmail.com> wrote:
>
> I hope to get  some expert advice before I proceed. I don't want to
> make things worse. Here's my situation now:
>
> This problem is with an external USB drive and it is encrypted.
> cryptsetup open succeeds. But mount fails.k
>
>     mount /backup
>     mount: /backup: wrong fs type, bad option, bad superblock on
> /dev/mapper/xusbluks, missing codepage or helper program, or other
> error.
>
>  Next the following command succeeds:
>
>     mount -o ro,recovery /dev/mapper/xusbluks /backup
>
> This is my backup disk (5TB), and I don't have another 5TB disk to
> copy all the data to. I hope I can fix the issue without losing my
> backups.
>
> Next step I did:
>
>         # btrfs check /dev/mapper/xyz
>         Opening filesystem to check...
>         parent transid verify failed on 2853827608576 wanted 29436 found 29433
>         parent transid verify failed on 2853827608576 wanted 29436 found 29433
>         parent transid verify failed on 2853827608576 wanted 29436 found 29433
>         Ignoring transid failure
>         leaf parent key incorrect 2853827608576
>         ERROR: could not setup extent tree
>         ERROR: cannot open file system
>
> BTW, this command returns no result:
>
>     which btrfs-zero-log
>
> I don't have that script/application installed. I'm running Arch Linux. I have
>
> core/btrfs-progs 5.11-1
> llinux 5.11.7-arch1-1

I'm following up my own post with additional data. I read some other
threads that requested this, so I thought I could proactively include
it.

# btrfs insp dump-s /dev/mapper/xzy
superblock: bytenr=65536, device=/dev/mapper/xzy
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x44b6abfd [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    e23b0b43-0c36-4c7d-b9e1-e821acb259be
metadata_uuid           e23b0b43-0c36-4c7d-b9e1-e821acb259be
label                   usb_backup
generation              29436
root                    2853792677888
sys_array_size          129
chunk_root_generation   29396
root_level              1
chunk_root              22052864
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             5000928428032
bytes_used              2822988496896
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x169
                        ( MIXED_BACKREF |
                          COMPRESS_LZO |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        29436
uuid_tree_generation    29436
dev_item.uuid           b98c68ff-2e12-41c4-97d3-81d488175dcd
dev_item.fsid           e23b0b43-0c36-4c7d-b9e1-e821acb259be [match]
dev_item.type           0
dev_item.total_bytes    5000928428032
dev_item.bytes_used     2848662224896
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0



# btrfs inspect-internal dump-super --full /dev/mapper/xzy
superblock: bytenr=65536, device=/dev/mapper/xzy
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x44b6abfd [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    e23b0b43-0c36-4c7d-b9e1-e821acb259be
metadata_uuid           e23b0b43-0c36-4c7d-b9e1-e821acb259be
label                   usb_backup
generation              29436
root                    2853792677888
sys_array_size          129
chunk_root_generation   29396
root_level              1
chunk_root              22052864
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             5000928428032
bytes_used              2822988496896
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x169
                        ( MIXED_BACKREF |
                          COMPRESS_LZO |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        29436
uuid_tree_generation    29436
dev_item.uuid           b98c68ff-2e12-41c4-97d3-81d488175dcd
dev_item.fsid           e23b0b43-0c36-4c7d-b9e1-e821acb259be [match]
dev_item.type           0
dev_item.total_bytes    5000928428032
dev_item.bytes_used     2848662224896
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
                        dev_uuid b98c68ff-2e12-41c4-97d3-81d488175dcd
                        stripe 1 devid 1 offset 30408704
                        dev_uuid b98c68ff-2e12-41c4-97d3-81d488175dcd
backup_roots[4]:
        backup 0:
                backup_tree_root:       2853865455616   gen: 29435      level: 1
                backup_chunk_root:      22052864        gen: 29396      level: 1
                backup_extent_root:     2853827903488   gen: 29435      level: 2
                backup_fs_root:         31408128        gen: 24 level: 0
                backup_dev_root:        2593527267328   gen: 29423      level: 1
                backup_csum_root:       2853819629568   gen: 29435      level: 3
                backup_total_bytes:     5000928428032
                backup_bytes_used:      2822988496896
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       2853792677888   gen: 29436      level: 1
                backup_chunk_root:      22052864        gen: 29396      level: 1
                backup_extent_root:     2853792727040   gen: 29436      level: 2
                backup_fs_root:         31408128        gen: 24 level: 0
                backup_dev_root:        2593527267328   gen: 29423      level: 1
                backup_csum_root:       2853816270848   gen: 29436      level: 3
                backup_total_bytes:     5000928428032
                backup_bytes_used:      2822988496896
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       2853787942912   gen: 29433      level: 1
                backup_chunk_root:      22052864        gen: 29396      level: 1
                backup_extent_root:     2853788942336   gen: 29433      level: 2
                backup_fs_root:         31408128        gen: 24 level: 0
                backup_dev_root:        2593527267328   gen: 29423      level: 1
                backup_csum_root:       2853806047232   gen: 29433      level: 3
                backup_total_bytes:     5000928428032
                backup_bytes_used:      2822957436928
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       2853792727040   gen: 29434      level: 1
                backup_chunk_root:      22052864        gen: 29396      level: 1
                backup_extent_root:     2853796118528   gen: 29434      level: 2
                backup_fs_root:         31408128        gen: 24 level: 0
                backup_dev_root:        2593527267328   gen: 29423      level: 1
                backup_csum_root:       2853832540160   gen: 29434      level: 3
                backup_total_bytes:     5000928428032
                backup_bytes_used:      2822957436928
                backup_num_devices:     1
