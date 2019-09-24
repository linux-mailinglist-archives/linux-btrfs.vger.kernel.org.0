Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2850BC4A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfIXJSO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 24 Sep 2019 05:18:14 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfIXJSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:18:14 -0400
Received: from oxbsltgw62.schlund.de ([172.19.249.152]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mf0Nm-1hg4xl10RO-00gYsr; Tue, 24 Sep 2019 11:18:11 +0200
Date:   Tue, 24 Sep 2019 11:18:11 +0200 (CEST)
From:   Felix Koop <fdp@fkoop.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <1393339585.178213.1569316691139@email.ionos.de>
In-Reply-To: <7ab6805a-f372-d5e2-04c9-51dc7cf51fbc@gmx.com>
References: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
 <1af945c1-0e58-a6e0-477f-59e0900a0e6f@gmx.com>
 <1746580228.276165.1569313641249@email.ionos.de>
 <7ab6805a-f372-d5e2-04c9-51dc7cf51fbc@gmx.com>
Subject: Re: help needed with unmountable btrfs-filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev60
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:xWeQjsbfNO0y8mGyFStyWjsC7Ijj/hJ7fu4ku4jQ+qBbovEX/yt
 tZgK3FLF9ke2nS0BUq7Z8VAqjG2pnkbEwqudyXUFcU2a0UhTIYOGU5WtNLX0eSo13QUFwY5
 2BX1G8l61X/V3LnkO1AbMbQ2psGstXucBJZd/8bnzt530s6DNXI/KywHEMy/JsC5h+JnkBD
 mF07O2ah1/loEmlYejvsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Ua7syUPuzw=:F4f0eafMSWCoBtS9y4pzT3
 NfoLWVJLjzymllSKLilCyhtJNSdfJ1CqeiC0uA8+vvuBiDJbehN+8gHbBRcBxZBJR7N2lTCt6
 r+C6rcNwoo7e0IBuk+Wx7lbgUqAmBdFIDTKMc89bw3E0eOj1e0Arw5++eUDKSkEt2FPx9+JCT
 +8eQAsNe+K+FRwCS5BGSz/kBpAyrvSwvgsYXJv9/kiYD8zpFqtHZyEEmORvDJV21niRJy+FXK
 6FwoOIjr3PYEQ3UzX5xAfD3qeY9fgKtexhuxmYpjCIj8eJICM3n3kjM/40hpk1cO8RoZPiSFU
 V9DV/dafc7aojiJ1pOWp2zQlpe7ZfWP2xRbs4DLDm2EGX0o+PQ6G4BIma4A1sqbFQICOSrYjh
 7SbVQ0mn9SntgxJSW6L0BkIITUiskP8g4vf5cVf6DGUuHFpVJU7RTiSFonDmKvu1U1eswpQoy
 f93zof04cZ9MpHTJU/cLBPcMwb+mLckLfnQr3/H6KYGJjmBvDT1YgiMvrHJwB3rcgKq/QaNPS
 tjoMLxCtxK44HDmWtjcAaYIK5IUVFJNkw45cZByklP9PZY95bl9G8l53jBn5qaYDZ0/U7pNJ1
 wRelXJR8wtN+crYY/DcL7PgKUQ5zKt41dJTtP/KNIzqm/0N7pP9xUUHOvLpZMPuB0zGpZr3qL
 rqNgWxLt35mGcF2B3k4gjA8SyI2JXyA75uCfr9Vfc5ZcINnNUTmbG1zg3dXlo1PcRMXNOdWOt
 Ae6pTe7sSuHUb97552ktIjzf2ovYaw7qJ1TTyJr6Icc+l3Yo5kJQvpaYkv5nA+IWjEIVDNpnp
 nSKyMx7bUQFkII//BCPHOnAOyLvMzZawPfeF87TpBdaSZAnkxskn5sfsmYB6CXYKekItm/fkI
 BvzEM18I7J1FQr4f6sgg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

this is what I got:

root@tuxedo:~# btrfs rescue super-recover /dev/md/1
Make sure this is a btrfs disk otherwise the tool will destroy other fs, Are you sure? [y/N]: y
checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
checksum verify failed on 340721664 found CBE54D32 wanted 6010C3E7
checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
bad tree block 340721664, bytenr mismatch, want=340721664, have=14969249826309169724
Couldn't read tree root
Failed to recover bad superblocks
root@tuxedo:~# btrfs check --readonly /dev/md/1
Opening filesystem to check...
No valid Btrfs found on /dev/md/1
ERROR: cannot open file system

Additional tips?


Mit freundlichen Grüßen/Kind regards


Felix Koop


> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 24. September 2019 um 11:11 geschrieben:
> 
> 
> 
> 
> On 2019/9/24 下午4:27, Felix Koop wrote:
> > Hi Qu,
> > 
> > unfortunately nothing under dmesg.
> > 
> > ~# btrfs ins dump-super -fFa /dev/md/1
> > superblock: bytenr=65536, device=/dev/md/1
> > ---------------------------------------------------------
> > csum_type               48250 (INVALID)
> > csum_size               32
> > csum                    0x8e5542eb70bced2a96808253fcb7a73c6085b6e754cbc8e2fb89674e9f738238 [UNKNOWN CSUM TYPE OR SIZE]
> 
> So the first super block is completely garbage, no wonder neither kernel
> nor the btrfs-progs detects the fs.
> 
> [...]
> > 
> > 
> > superblock: bytenr=67108864, device=/dev/md/1
> > ---------------------------------------------------------
> > csum_type               0 (crc32c)
> > csum_size               4
> > csum                    0x636f9da3 [match]
> > bytenr                  67108864
> > flags                   0x1
> >                         ( WRITTEN )
> > magic                   _BHRfS_M [match]
> 
> Still have a good backup.
> 
> I'm not sure what makes the first super block completely garbage. It can
> be bad trim or whatever something wrong.
> 
> But anyway, you can try to fix it by "btrfs rescue super-recover
> /dev/md/1" to at least recover the superblock so that kernel and
> btrfs-progs can recognize the system.
> 
> Then you may like to run a "btrfs check --readonly /dev/md/1" to make
> sure nothing else is corrupted.
> 
> Thanks,
> Qu
> 
> > fsid                    6bd5c974-2565-4736-815d-fe071f560e68
> > metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
> > label
> > generation              168
> > root                    340721664
> > sys_array_size          129
> > chunk_root_generation   156
> > root_level              1
> > chunk_root              22020096
> > chunk_root_level        1
> > log_root                0
> > log_root_transid        0
> > log_root_level          0
> > total_bytes             375567417344
> > bytes_used              243939692544
> > sectorsize              4096
> > nodesize                16384
> > leafsize (deprecated)   16384
> > stripesize              4096
> > root_dir                6
> > num_devices             1
> > compat_flags            0x0
> > compat_ro_flags         0x0
> > incompat_flags          0x161
> >                         ( MIXED_BACKREF |
> >                           BIG_METADATA |
> >                           EXTENDED_IREF |
> >                           SKINNY_METADATA )
> > cache_generation        168
> > uuid_tree_generation    168
> > dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
> > dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
> > dev_item.type           0
> > dev_item.total_bytes    375567417344
> > dev_item.bytes_used     248059527168
> > dev_item.io_align       4096
> > dev_item.io_width       4096
> > dev_item.sector_size    4096
> > dev_item.devid          1
> > dev_item.dev_group      0
> > dev_item.seek_speed     0
> > dev_item.bandwidth      0
> > dev_item.generation     0
> > sys_chunk_array[2048]:
> >         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> >                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
> >                 io_align 65536 io_width 65536 sector_size 4096
> >                 num_stripes 2 sub_stripes 0
> >                         stripe 0 devid 1 offset 22020096
> >                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >                         stripe 1 devid 1 offset 30408704
> >                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> > backup_roots[4]:
> >         backup 0:
> >                 backup_tree_root:       350814208       gen: 166        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     340721664       gen: 166        level: 2
> >                 backup_fs_root:         338608128       gen: 166        level: 2
> >                 backup_dev_root:        354140160       gen: 166        level: 1
> >                 backup_csum_root:       353402880       gen: 166        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> >         backup 1:
> >                 backup_tree_root:       57311232        gen: 167        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     69419008        gen: 167        level: 2
> >                 backup_fs_root:         338608128       gen: 166        level: 2
> >                 backup_dev_root:        317472768       gen: 167        level: 1
> >                 backup_csum_root:       345784320       gen: 167        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> >         backup 2:
> >                 backup_tree_root:       340721664       gen: 168        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     340738048       gen: 168        level: 2
> >                 backup_fs_root:         338608128       gen: 166        level: 2
> >                 backup_dev_root:        345358336       gen: 168        level: 1
> >                 backup_csum_root:       353320960       gen: 168        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> >         backup 3:
> >                 backup_tree_root:       57311232        gen: 165        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     69419008        gen: 165        level: 2
> >                 backup_fs_root:         352387072       gen: 157        level: 2
> >                 backup_dev_root:        317325312       gen: 165        level: 1
> >                 backup_csum_root:       343932928       gen: 165        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> > 
> > superblock: bytenr=274877906944, device=/dev/md/1
> > ---------------------------------------------------------
> > csum_type               0 (crc32c)
> > csum_size               4
> > csum                    0x9ee8cb92 [match]
> > bytenr                  274877906944
> > flags                   0x1
> >                         ( WRITTEN )
> > magic                   _BHRfS_M [match]
> > fsid                    6bd5c974-2565-4736-815d-fe071f560e68
> > metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
> > label
> > generation              168
> > root                    340721664
> > sys_array_size          129
> > chunk_root_generation   156
> > root_level              1
> > chunk_root              22020096
> > chunk_root_level        1
> > log_root                0
> > log_root_transid        0
> > log_root_level          0
> > total_bytes             375567417344
> > bytes_used              243939692544
> > sectorsize              4096
> > nodesize                16384
> > leafsize (deprecated)   16384
> > stripesize              4096
> > root_dir                6
> > num_devices             1
> > compat_flags            0x0
> > compat_ro_flags         0x0
> > incompat_flags          0x161
> >                         ( MIXED_BACKREF |
> >                           BIG_METADATA |
> >                           EXTENDED_IREF |
> >                           SKINNY_METADATA )
> > cache_generation        168
> > uuid_tree_generation    168
> > dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
> > dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
> > dev_item.type           0
> > dev_item.total_bytes    375567417344
> > dev_item.bytes_used     248059527168
> > dev_item.io_align       4096
> > dev_item.io_width       4096
> > dev_item.sector_size    4096
> > dev_item.devid          1
> > dev_item.dev_group      0
> > dev_item.seek_speed     0
> > dev_item.bandwidth      0
> > dev_item.generation     0
> > sys_chunk_array[2048]:
> >         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> >                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
> >                 io_align 65536 io_width 65536 sector_size 4096
> >                 num_stripes 2 sub_stripes 0
> >                         stripe 0 devid 1 offset 22020096
> >                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >                         stripe 1 devid 1 offset 30408704
> >                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> > backup_roots[4]:
> >         backup 0:
> >                 backup_tree_root:       350814208       gen: 166        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     340721664       gen: 166        level: 2
> >                 backup_fs_root:         338608128       gen: 166        level: 2
> >                 backup_dev_root:        354140160       gen: 166        level: 1
> >                 backup_csum_root:       353402880       gen: 166        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> >         backup 1:
> >                 backup_tree_root:       57311232        gen: 167        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     69419008        gen: 167        level: 2
> >                 backup_fs_root:         338608128       gen: 166        level: 2
> >                 backup_dev_root:        317472768       gen: 167        level: 1
> >                 backup_csum_root:       345784320       gen: 167        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> >         backup 2:
> >                 backup_tree_root:       340721664       gen: 168        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     340738048       gen: 168        level: 2
> >                 backup_fs_root:         338608128       gen: 166        level: 2
> >                 backup_dev_root:        345358336       gen: 168        level: 1
> >                 backup_csum_root:       353320960       gen: 168        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> >         backup 3:
> >                 backup_tree_root:       57311232        gen: 165        level: 1
> >                 backup_chunk_root:      22020096        gen: 156        level: 1
> >                 backup_extent_root:     69419008        gen: 165        level: 2
> >                 backup_fs_root:         352387072       gen: 157        level: 2
> >                 backup_dev_root:        317325312       gen: 165        level: 1
> >                 backup_csum_root:       343932928       gen: 165        level: 2
> >                 backup_total_bytes:     375567417344
> >                 backup_bytes_used:      243939692544
> >                 backup_num_devices:     1
> > 
> > 
> > 
> > 
> > 
> > Mit freundlichen Grüßen/Kind regards
> > 
> > 
> > Felix Koop
> > 
> > 
> >> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 22. September 2019 um 11:50 geschrieben:
> >>
> >>
> >>
> >>
> >> On 2019/9/22 下午2:34, Felix Koop wrote:
> >>> Hello,
> >>>
> >>> I need help accessing a btrfs-filesystem. When I try to mount the fs, I
> >>> get the following error:
> >>>
> >>> # mount -t btrfs /dev/md/1 /mnt
> >>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md1,
> >>> missing codepage or helper program, or other error.
> >>
> >> dmesg please.
> >>
> >>>
> >>> When I then try to check the fs, this is what I get:
> >>>
> >>> # btrfs check /dev/md/1
> >>> Opening filesystem to check...
> >>> No valid Btrfs found on /dev/md/1
> >>> ERROR: cannot open file system
> >>
> >> As it said, it can't find the primary superblock.
> >>
> >> Please provide the following output.
> >>
> >> # btrfs ins dump-super -fFa /dev/md/1
> >>
> >> And kernel and btrfs-progs version please.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> Can anybody help me how to recover my data?
> >>>
> >>>
> >>
>
