Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABED9BC550
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440677AbfIXJ5m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 24 Sep 2019 05:57:42 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394079AbfIXJ5m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:57:42 -0400
Received: from oxbsltgw62.schlund.de ([172.19.249.152]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MvbJw-1hwYKr2Ely-00scqQ; Tue, 24 Sep 2019 11:57:39 +0200
Date:   Tue, 24 Sep 2019 11:57:39 +0200 (CEST)
From:   Felix Koop <fdp@fkoop.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <763051326.179345.1569319059433@email.ionos.de>
In-Reply-To: <eac5b055-3ec5-47e2-bf6e-d317595240ce@gmx.com>
References: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
 <1af945c1-0e58-a6e0-477f-59e0900a0e6f@gmx.com>
 <1746580228.276165.1569313641249@email.ionos.de>
 <7ab6805a-f372-d5e2-04c9-51dc7cf51fbc@gmx.com>
 <1393339585.178213.1569316691139@email.ionos.de>
 <eac5b055-3ec5-47e2-bf6e-d317595240ce@gmx.com>
Subject: Re: help needed with unmountable btrfs-filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev60
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:GHgvpLYwVJQqwJF49u+BDGd/nY1XWYH5LrcMEQZXgSMm9xSVI3s
 RbZkeqrmTtaw4H81Fsqft1+o7GNeaj+HgtI84oJjfg5C85D0QPeG1Ik6EnQuAVL5hmBWAVl
 X5c77H6PN+O/osvoBKTzRgRVTx7BME7bVtwV168JEQskqB9zyNH3YDa16/q0v0mI+4clLdK
 Zf7uhnVJr1NP28mqpw9bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1/EaC2o6zRU=:kg7bcfa0LlxZWvfcqtQ7vi
 xtl+LxGB6pVtnhUXD4fFqnMLS8p+8BPuvGz5jGb8g2mdJgoB0o2qEB1v8V8SgB4nC7Pxmzbdu
 rlB62FhiZGOoI34v00mOarAsZ1Qp6soflLmLmtQP6dC7rn3V+3x3yeRSaFij6OL9Dm2aE6B2B
 6afLVC30jczPaVUEtJRL1qq1ert5GXv1mu3EOy/V7y/9PUDDwuu+uPbZnUCh4LAwj5v15ZIZZ
 1JHL8VzzUq8Ey7v0d6XqblydMKNuoqMwMf+xX/QwA8QSNEmBjQw2al6S3prKk8nm9f5BpMPEX
 1QU0T0dLXZcbQGYHCAXTBRtepJ/TO+cOt1UIf6vq6Vu7kTj0nlxOzfNHmqg44YVQR4LOk7kNC
 mY+uye5aDde0DpruzsrEsppmq1gTbo01Gf889MVabLj43jltgLrOTCpvB0eNdTWcwLUqp1oPu
 QmN7uTSe4pBaZVi7oiKIe4yK/tZRA0JbYtbpcZ43VEp2hCmWCCJGkexZuDLJcrfLZcdpm9Yh6
 zcDxZdja6pG+aAg9MbwuyBrD3hyZXENl/c0I2CPv33tZirDn1qX2DK9nIFOvJFmv5/4EELSUX
 kEFljxY3su2qgKwbq4JWBnJRJlD2F4vgd8B6HoIJaqjpIC0n0it1+dzm+mjhmKFqF2CMyWJuq
 wRM/Y7Vg4UU8c03GdlT+XMmy3oY2ZXLHqWMqwMfxpDb+M5PdJYgiAJMQ1AGZ5uABD+D/lqmzJ
 bjRx7dWkXbA89aGNJsLOSIvuDAu4PQWSlSpuKR83y9pS97nsJyUNocAJYK8LaCe7M/w6sTXLE
 M62k4mg8osmrGW7dTtxS8BvT7ENY8t/SDfmYVs9V4aZ9MX/5u+K63be47X7WkxfVEwukQ9Ntg
 vWRiF895EO/XshM8b/Yg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fs is on a RAID 6 md device, where 1 or 2 devices had problems. This should not have had an effect with the fs. Now I think it might have.

Mit freundlichen Grüßen/Kind regards


Felix Koop


> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 24. September 2019 um 11:23 geschrieben:
> 
> 
> 
> 
> On 2019/9/24 下午5:18, Felix Koop wrote:
> > Hi Qu,
> > 
> > this is what I got:
> > 
> > root@tuxedo:~# btrfs rescue super-recover /dev/md/1
> > Make sure this is a btrfs disk otherwise the tool will destroy other fs, Are you sure? [y/N]: y
> > checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
> > checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
> > checksum verify failed on 340721664 found CBE54D32 wanted 6010C3E7
> > checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
> > bad tree block 340721664, bytenr mismatch, want=340721664, have=14969249826309169724
> 
> This means your root tree is also corrupted.
> 
> Any idea how is the fs corrupted?
> 
> 
> It should be very rare to corrupt the first superblock already.
> Then more csum corruption is even more rare.
> 
> It looks like the underlying device or encryption or whatever is corrupted.
> 
> If a fs is corrupted to this extent, it's pretty hard to do any more.
> 
> Thanks,
> Qu
> 
> > Couldn't read tree root
> > Failed to recover bad superblocks
> > root@tuxedo:~# btrfs check --readonly /dev/md/1
> > Opening filesystem to check...
> > No valid Btrfs found on /dev/md/1
> > ERROR: cannot open file system
> > 
> > Additional tips?
> > 
> > 
> > Mit freundlichen Grüßen/Kind regards
> > 
> > 
> > Felix Koop
> > 
> > 
> >> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 24. September 2019 um 11:11 geschrieben:
> >>
> >>
> >>
> >>
> >> On 2019/9/24 下午4:27, Felix Koop wrote:
> >>> Hi Qu,
> >>>
> >>> unfortunately nothing under dmesg.
> >>>
> >>> ~# btrfs ins dump-super -fFa /dev/md/1
> >>> superblock: bytenr=65536, device=/dev/md/1
> >>> ---------------------------------------------------------
> >>> csum_type               48250 (INVALID)
> >>> csum_size               32
> >>> csum                    0x8e5542eb70bced2a96808253fcb7a73c6085b6e754cbc8e2fb89674e9f738238 [UNKNOWN CSUM TYPE OR SIZE]
> >>
> >> So the first super block is completely garbage, no wonder neither kernel
> >> nor the btrfs-progs detects the fs.
> >>
> >> [...]
> >>>
> >>>
> >>> superblock: bytenr=67108864, device=/dev/md/1
> >>> ---------------------------------------------------------
> >>> csum_type               0 (crc32c)
> >>> csum_size               4
> >>> csum                    0x636f9da3 [match]
> >>> bytenr                  67108864
> >>> flags                   0x1
> >>>                         ( WRITTEN )
> >>> magic                   _BHRfS_M [match]
> >>
> >> Still have a good backup.
> >>
> >> I'm not sure what makes the first super block completely garbage. It can
> >> be bad trim or whatever something wrong.
> >>
> >> But anyway, you can try to fix it by "btrfs rescue super-recover
> >> /dev/md/1" to at least recover the superblock so that kernel and
> >> btrfs-progs can recognize the system.
> >>
> >> Then you may like to run a "btrfs check --readonly /dev/md/1" to make
> >> sure nothing else is corrupted.
> >>
> >> Thanks,
> >> Qu
> >>
> >>> fsid                    6bd5c974-2565-4736-815d-fe071f560e68
> >>> metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
> >>> label
> >>> generation              168
> >>> root                    340721664
> >>> sys_array_size          129
> >>> chunk_root_generation   156
> >>> root_level              1
> >>> chunk_root              22020096
> >>> chunk_root_level        1
> >>> log_root                0
> >>> log_root_transid        0
> >>> log_root_level          0
> >>> total_bytes             375567417344
> >>> bytes_used              243939692544
> >>> sectorsize              4096
> >>> nodesize                16384
> >>> leafsize (deprecated)   16384
> >>> stripesize              4096
> >>> root_dir                6
> >>> num_devices             1
> >>> compat_flags            0x0
> >>> compat_ro_flags         0x0
> >>> incompat_flags          0x161
> >>>                         ( MIXED_BACKREF |
> >>>                           BIG_METADATA |
> >>>                           EXTENDED_IREF |
> >>>                           SKINNY_METADATA )
> >>> cache_generation        168
> >>> uuid_tree_generation    168
> >>> dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >>> dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
> >>> dev_item.type           0
> >>> dev_item.total_bytes    375567417344
> >>> dev_item.bytes_used     248059527168
> >>> dev_item.io_align       4096
> >>> dev_item.io_width       4096
> >>> dev_item.sector_size    4096
> >>> dev_item.devid          1
> >>> dev_item.dev_group      0
> >>> dev_item.seek_speed     0
> >>> dev_item.bandwidth      0
> >>> dev_item.generation     0
> >>> sys_chunk_array[2048]:
> >>>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> >>>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
> >>>                 io_align 65536 io_width 65536 sector_size 4096
> >>>                 num_stripes 2 sub_stripes 0
> >>>                         stripe 0 devid 1 offset 22020096
> >>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >>>                         stripe 1 devid 1 offset 30408704
> >>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >>> backup_roots[4]:
> >>>         backup 0:
> >>>                 backup_tree_root:       350814208       gen: 166        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     340721664       gen: 166        level: 2
> >>>                 backup_fs_root:         338608128       gen: 166        level: 2
> >>>                 backup_dev_root:        354140160       gen: 166        level: 1
> >>>                 backup_csum_root:       353402880       gen: 166        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>         backup 1:
> >>>                 backup_tree_root:       57311232        gen: 167        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     69419008        gen: 167        level: 2
> >>>                 backup_fs_root:         338608128       gen: 166        level: 2
> >>>                 backup_dev_root:        317472768       gen: 167        level: 1
> >>>                 backup_csum_root:       345784320       gen: 167        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>         backup 2:
> >>>                 backup_tree_root:       340721664       gen: 168        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     340738048       gen: 168        level: 2
> >>>                 backup_fs_root:         338608128       gen: 166        level: 2
> >>>                 backup_dev_root:        345358336       gen: 168        level: 1
> >>>                 backup_csum_root:       353320960       gen: 168        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>         backup 3:
> >>>                 backup_tree_root:       57311232        gen: 165        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     69419008        gen: 165        level: 2
> >>>                 backup_fs_root:         352387072       gen: 157        level: 2
> >>>                 backup_dev_root:        317325312       gen: 165        level: 1
> >>>                 backup_csum_root:       343932928       gen: 165        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>
> >>> superblock: bytenr=274877906944, device=/dev/md/1
> >>> ---------------------------------------------------------
> >>> csum_type               0 (crc32c)
> >>> csum_size               4
> >>> csum                    0x9ee8cb92 [match]
> >>> bytenr                  274877906944
> >>> flags                   0x1
> >>>                         ( WRITTEN )
> >>> magic                   _BHRfS_M [match]
> >>> fsid                    6bd5c974-2565-4736-815d-fe071f560e68
> >>> metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
> >>> label
> >>> generation              168
> >>> root                    340721664
> >>> sys_array_size          129
> >>> chunk_root_generation   156
> >>> root_level              1
> >>> chunk_root              22020096
> >>> chunk_root_level        1
> >>> log_root                0
> >>> log_root_transid        0
> >>> log_root_level          0
> >>> total_bytes             375567417344
> >>> bytes_used              243939692544
> >>> sectorsize              4096
> >>> nodesize                16384
> >>> leafsize (deprecated)   16384
> >>> stripesize              4096
> >>> root_dir                6
> >>> num_devices             1
> >>> compat_flags            0x0
> >>> compat_ro_flags         0x0
> >>> incompat_flags          0x161
> >>>                         ( MIXED_BACKREF |
> >>>                           BIG_METADATA |
> >>>                           EXTENDED_IREF |
> >>>                           SKINNY_METADATA )
> >>> cache_generation        168
> >>> uuid_tree_generation    168
> >>> dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >>> dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
> >>> dev_item.type           0
> >>> dev_item.total_bytes    375567417344
> >>> dev_item.bytes_used     248059527168
> >>> dev_item.io_align       4096
> >>> dev_item.io_width       4096
> >>> dev_item.sector_size    4096
> >>> dev_item.devid          1
> >>> dev_item.dev_group      0
> >>> dev_item.seek_speed     0
> >>> dev_item.bandwidth      0
> >>> dev_item.generation     0
> >>> sys_chunk_array[2048]:
> >>>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> >>>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
> >>>                 io_align 65536 io_width 65536 sector_size 4096
> >>>                 num_stripes 2 sub_stripes 0
> >>>                         stripe 0 devid 1 offset 22020096
> >>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >>>                         stripe 1 devid 1 offset 30408704
> >>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> >>> backup_roots[4]:
> >>>         backup 0:
> >>>                 backup_tree_root:       350814208       gen: 166        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     340721664       gen: 166        level: 2
> >>>                 backup_fs_root:         338608128       gen: 166        level: 2
> >>>                 backup_dev_root:        354140160       gen: 166        level: 1
> >>>                 backup_csum_root:       353402880       gen: 166        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>         backup 1:
> >>>                 backup_tree_root:       57311232        gen: 167        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     69419008        gen: 167        level: 2
> >>>                 backup_fs_root:         338608128       gen: 166        level: 2
> >>>                 backup_dev_root:        317472768       gen: 167        level: 1
> >>>                 backup_csum_root:       345784320       gen: 167        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>         backup 2:
> >>>                 backup_tree_root:       340721664       gen: 168        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     340738048       gen: 168        level: 2
> >>>                 backup_fs_root:         338608128       gen: 166        level: 2
> >>>                 backup_dev_root:        345358336       gen: 168        level: 1
> >>>                 backup_csum_root:       353320960       gen: 168        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>         backup 3:
> >>>                 backup_tree_root:       57311232        gen: 165        level: 1
> >>>                 backup_chunk_root:      22020096        gen: 156        level: 1
> >>>                 backup_extent_root:     69419008        gen: 165        level: 2
> >>>                 backup_fs_root:         352387072       gen: 157        level: 2
> >>>                 backup_dev_root:        317325312       gen: 165        level: 1
> >>>                 backup_csum_root:       343932928       gen: 165        level: 2
> >>>                 backup_total_bytes:     375567417344
> >>>                 backup_bytes_used:      243939692544
> >>>                 backup_num_devices:     1
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> Mit freundlichen Grüßen/Kind regards
> >>>
> >>>
> >>> Felix Koop
> >>>
> >>>
> >>>> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 22. September 2019 um 11:50 geschrieben:
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> On 2019/9/22 下午2:34, Felix Koop wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I need help accessing a btrfs-filesystem. When I try to mount the fs, I
> >>>>> get the following error:
> >>>>>
> >>>>> # mount -t btrfs /dev/md/1 /mnt
> >>>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md1,
> >>>>> missing codepage or helper program, or other error.
> >>>>
> >>>> dmesg please.
> >>>>
> >>>>>
> >>>>> When I then try to check the fs, this is what I get:
> >>>>>
> >>>>> # btrfs check /dev/md/1
> >>>>> Opening filesystem to check...
> >>>>> No valid Btrfs found on /dev/md/1
> >>>>> ERROR: cannot open file system
> >>>>
> >>>> As it said, it can't find the primary superblock.
> >>>>
> >>>> Please provide the following output.
> >>>>
> >>>> # btrfs ins dump-super -fFa /dev/md/1
> >>>>
> >>>> And kernel and btrfs-progs version please.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> Can anybody help me how to recover my data?
> >>>>>
> >>>>>
> >>>>
> >>
>
