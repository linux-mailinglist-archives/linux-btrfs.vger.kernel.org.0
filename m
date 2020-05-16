Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54A1D5DBA
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 May 2020 03:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEPBoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 21:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgEPBoU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 21:44:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A02C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri, 15 May 2020 18:44:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so5444329wre.13
        for <linux-btrfs@vger.kernel.org>; Fri, 15 May 2020 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version;
        bh=ncnic2ouDG6Ww+oIjJHkdy+uCJBWhahB16PyF1R60mU=;
        b=UM0g7/JfA+RgmWo2Jyo3/Mt5e4nTMDVAaOpttsgUOm/tW1WdDKlaCACSbmAlhiXBAY
         F1/JEYveM5eJx9SRU32ZWQv2rZZqK1zkR8tvF9Y9Ru3HqkRwaozdqI6ffSrP9d1mVU1T
         J8KNaZgV5c4qmP5y/KLQm5IfsOJeIA4+Erdx2aaxfxJxMN57ISKTTwLQ4La7FQ3QK6ea
         mAOaEYOWVIsD8X7ZcUP2EBh/4wJ0GTH+MsqEmCiRyAw94iIjqE4EdKAd/+eKumNRcG6W
         IdQP2VAD1lJVoIKNM++VbaKSD/bJpyOhMOlY+LLuxXXso9h/BPVcz+bbazLXbysuSNuE
         htKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version;
        bh=ncnic2ouDG6Ww+oIjJHkdy+uCJBWhahB16PyF1R60mU=;
        b=TKkHUH2Rgaj2J8mmi+YJX9RcmnadPt3p6XVLZHYP6Q/ZqfNVew5BuxED0TfbxYgK/6
         75rLH0FbN1/cfYezAK8RRNg7FXa09uJKpKF1BCPCzVUEQCAvjSBH+TBweiXRQRAEPz4J
         KS0uItqPUHo/qEjGXQtAAWwac3UOQ7ue6aDUm2lgjTQx549ZQjnTo0vyESt5EWFVXh8m
         Zo4WRAf0ckdKxCCMvC+ibz4lvhIUKdIk6XJYebnwFLOCpL3Ubcg1A30JlEcba57tXYTs
         ikHnfoX2lOQRYjsPMbQETEQGJKCRk3YkdDDpnQ7UwfHyAIeM6bCkSGz4L/WlEGEc4phO
         SLcA==
X-Gm-Message-State: AOAM530JPhxRAV7g4e12TsOPRnAp00r/oqqolS0BtVjT0T94bpw+bsal
        GtKGfqEKbb3eZ3ZrRTXm59CC9gOWd7I=
X-Google-Smtp-Source: ABdhPJzOKeaukpHqsnDqFtyIH84+fYlk+XwtBqFvTt3k82VXlyl2GJ2uaY4lWDungloJrxe/gKsqpg==
X-Received: by 2002:adf:82b3:: with SMTP id 48mr7094683wrc.223.1589593457987;
        Fri, 15 May 2020 18:44:17 -0700 (PDT)
Received: from [127.0.0.1] (p5796797B.dip0.t-ipconnect.de. [87.150.121.123])
        by smtp.gmail.com with ESMTPSA id w12sm5915155wmk.12.2020.05.15.18.44.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 18:44:17 -0700 (PDT)
Date:   Sat, 16 May 2020 01:44:14 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <f6d9ee8a-c0da-4b19-af3a-3c58c9c1478e@localhost>
In-Reply-To: <CAJCQCtQ9HzjjaV20txtoHAWG7tTVWaqdk6wf5QtB5v+w2p4b2Q@mail.gmail.com>
References: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost> <CAJCQCtQ9HzjjaV20txtoHAWG7tTVWaqdk6wf5QtB5v+w2p4b2Q@mail.gmail.com>
Subject: Re: Need help recovering broken RAID5 array (parent transid verify
 failed)
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_10_95367235.1589593454641"
X-Correlation-ID: <f6d9ee8a-c0da-4b19-af3a-3c58c9c1478e@localhost>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_10_95367235.1589593454641
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the answer. I attached the output of the commands you requested =
as a txt file. Unfortunately mounting didn't work, even with the kernel pat=
ch and skipbg option.

I will try to find the journalctl from when it happened.

Emil

May 15, 2020 23:46:55 Chris Murphy <lists@colorremedies.com>:

>       On Fri, May 15, 2020 at 12:03 AM Emil Heimpel=20
>     =20
> <broetchenrackete@gmail.com> wrote:=20
>     =20
> =20
>     =20
> > =20
> >       =20
> >       Hi,=20
> >      =20
> > =20
> >       I hope this is the right place to ask for help. I am unable to mo=
unt my BTRFS array and wanted to know, if it is possible to recover (some) =
data from it.=20
> >      =20
> > =20
> >     =20
> =20
>      Hi, yes it is!=20
>     =20
> =20
>      =20
>      =20
>     =20
> > =20
> >       I have a RAID1-Metadata/RAID5-Data array consisting of 6 drives, =
2x8TB, 5TB, 4TB and 2x3TB. It was running fine for the last 3 months. Becau=
se I expanded it drive by drive I wanted to do a full balance the other day=
, when after around 40% completion (ca 1.5 days) I noticed, that one drive =
was missing from the array (If I remember correctly, it was the 5TB one). I=
 tried to cancel the balance, but even after a few hours it didn't cancel, =
so I tried to do a reboot. That didn't work either, so I did a hard reset. =
Probably not the best idea, I know....=20
> >      =20
> > =20
> >     =20
> =20
>      The file system should be power fail safe (with some limited data=20
>     =20
> loss), but the hardware can betray everything. Your configuration is=20
>     =20
> better due to raid1 metadata.=20
>     =20
> =20
>     =20
> > =20
> >       After the reboot all drives appeared again but now I can't mount =
the array anymore, it gives me the following error in dmesg:=20
> >      =20
> > =20
> >       [=C2=A0 858.554594] BTRFS info (device sdc1): disk space caching =
is enabled=20
> >      =20
> > [=C2=A0 858.554596] BTRFS info (device sdc1): has skinny extents=20
> >      =20
> > [=C2=A0 858.556165] BTRFS error (device sdc1): parent transid verify fa=
iled on 23219912048640 wanted 116443 found 116484=20
> >      =20
> > [=C2=A0 858.556516] BTRFS error (device sdc1): parent transid verify fa=
iled on 23219912048640 wanted 116443=C2=A0 found 116484=20
> >      =20
> > [=C2=A0 858.556527] BTRFS error (device sdc1): failed to read chunk roo=
t=20
> >      =20
> > [=C2=A0 858.588332] BTRFS error (device sdc1): open_ctree failed=20
> >      =20
> > =20
> >     =20
> =20
>      Extent tree is damaged, but it's unexpected that a newer transid is=
=20
>     =20
> found than is wanted. Something happened out of order. Both copies.=20
>     =20
> =20
>      What do you get for:=20
>     =20
> # btrfs rescue super -v /dev/anydevice=20
>     =20
> # btrfs insp dump-s -fa /dev/anydevice=20
>     =20
> # btrfs insp dump-t -b 30122546839552 /dev/anydevice=20
>     =20
> # mount -o ro,nologreplay,degraded /dev/anydevice=20
>     =20
> =20
>      =20
>      =20
>      =20
>     =20
> > =20
> >       [bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sdd1=20
> >      =20
> > =20
> >     =20
> =20
>      For what it's worth, btrfs check does find all member devices, so yo=
u=20
>     =20
> only have to run check on any one of them. However, scrub is=20
>     =20
> different, you can run that individually per block device to work=20
>     =20
> around some performance problems with raid56, when running it on the=20
>     =20
> volume's mount point.=20
>     =20
> =20
>      =20
>     =20
>=20
> >        And how can I prevent it from happening again? Would using the n=
ew multi-parity raid1 for Metadata help?=20
> >      =20
> > =20
> >     =20
> =20
>      Difficult to know yet what went wrong. Do you have dmesg/journalctl =
-k=20
>     =20
> for the time period the problem drive began all the way to the forced=20
>     =20
> power off? It might give a hint. Before doing a forced poweroff while=20
>     =20
> writes are happening it might help to disable the write cache on all=20
>     =20
> the drives; or alternatively always disable them.=20
>     =20
> =20
>      =20
>     =20
>=20
> >        I'm running arch on an ssd.=20
> >      =20
> > [bluemond@BlueQ btrfslogs]$ uname -a=20
> >      =20
> > Linux BlueQ 5.6.12-arch1-1 #1 SMP PREEMPT Sun, 10 May 2020 10:43:42 +00=
00 x86_64 GNU/Linux=20
> >      =20
> > =20
> >       [bluemond@BlueQ btrfslogs]$ btrfs --version=20
> >      =20
> > btrfs-progs v5.6=20
> >      =20
> > =20
> >     =20
> =20
>      5.6.1 is current but I don't think there's anything in the minor=20
>     =20
> update that applies here.=20
>     =20
> =20
>      Post that info and maybe a dev will have time to take a look. If it=
=20
>     =20
> does mount ro,degraded, take the chance to update backups, just in=20
>     =20
> case. Yeah, ~21TB will be really inconvenient to lose. Also, since=20
>     =20
> it's over the weekend, and there's some time, it might be useful to=20
>     =20
> have a btrfs image:=20
>     =20
> =20
>      btrfs-image -ss -c9 -t4 /dev/anydevice ~/problemvolume.btrfs.bin=20
>     =20
> =20
>      This file will be roughly 1/2 the size of file system metadata. I=20
>     =20
> guess you could have around 140G of metadata depending on nodesize=20
>     =20
> chosen at mkfs time, and how many small files this filesystem has.=20
>     =20
> =20
>      Still another option that might make it possible to mount, if above=
=20
>     =20
> doesn't work; build the kernel with this patch=20
>     =20
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715=20
>     =20
> =20
>      Mount using -o ro,nologreplay,rescue=3Dskipbg=20
>     =20
> =20
>      This also doesn't actually fix the problem, it just might make it=20
>     =20
> possible to mount the file system, mainly for updating backups in case=20
>     =20
> it's not possible to fix.=20
>     =20
> =20
>      =20
>      --=20
>     =20
> Chris Murphy=20
>     =20
> =20
>    =20

------=_Part_10_95367235.1589593454641
Content-Type: text/plain; charset=us-ascii; name=btrfslog.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=btrfslog.txt

Last login: Fri May 15 05:05:01 2020 from 192.168.1.35
[bluemond@BlueQ ~]$ sudo btrfs rescue super -v /dev/sda1
All Devices:
        Device: id = 2, name = /dev/sdg1
        Device: id = 3, name = /dev/sdf1
        Device: id = 6, name = /dev/sdd1
        Device: id = 5, name = /dev/sde1
        Device: id = 1, name = /dev/sdc1
        Device: id = 4, name = /dev/sda1

Before Recovering:
        [All good supers]:
                device name = /dev/sdg1
                superblock bytenr = 65536

                device name = /dev/sdg1
                superblock bytenr = 67108864

                device name = /dev/sdg1
                superblock bytenr = 274877906944

                device name = /dev/sdf1
                superblock bytenr = 65536

                device name = /dev/sdf1
                superblock bytenr = 67108864

                device name = /dev/sdf1
                superblock bytenr = 274877906944

                device name = /dev/sdd1
                superblock bytenr = 65536

                device name = /dev/sdd1
                superblock bytenr = 67108864

                device name = /dev/sdd1
                superblock bytenr = 274877906944

                device name = /dev/sde1
                superblock bytenr = 65536

                device name = /dev/sde1
                superblock bytenr = 67108864

                device name = /dev/sde1
                superblock bytenr = 274877906944

                device name = /dev/sdc1
                superblock bytenr = 65536

                device name = /dev/sdc1
                superblock bytenr = 67108864

                device name = /dev/sdc1
                superblock bytenr = 274877906944

                device name = /dev/sda1
                superblock bytenr = 65536

                device name = /dev/sda1
                superblock bytenr = 67108864

                device name = /dev/sda1
                superblock bytenr = 274877906944

        [All bad supers]:

All supers are valid, no need to recover
[bluemond@BlueQ ~]$ sudo btrfs insp dump-s -fa /dev/sda1
superblock: bytenr=65536, device=/dev/sda1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x0774dbf0 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    19b4f289-a87f-4ed8-8882-b0d03e014104
metadata_uuid           19b4f289-a87f-4ed8-8882-b0d03e014104
label
generation              116443
root                    30122565173248
sys_array_size          129
chunk_root_generation   116443
root_level              1
chunk_root              23219912048640
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             31006074101760
bytes_used              17011224203264
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             6
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x1e1
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          RAID56 |
                          SKINNY_METADATA )
cache_generation        116443
uuid_tree_generation    116443
dev_item.uuid           c2b6d51b-f1bc-4e8a-ace5-9acb5b61e1b2
dev_item.fsid           19b4f289-a87f-4ed8-8882-b0d03e014104 [match]
dev_item.type           0
dev_item.total_bytes    8001562152960
dev_item.bytes_used     3334556811264
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          4
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 23219912048640)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 4 offset 1346487779328
                        dev_uuid c2b6d51b-f1bc-4e8a-ace5-9acb5b61e1b2
                        stripe 1 devid 1 offset 4429221527552
                        dev_uuid 6ce59a89-dacb-44dc-9823-8f6a16edd335
backup_roots[4]:
        backup 0:
                backup_tree_root:       30122549657600  gen: 116441     level: 1
                backup_chunk_root:      23219912065024  gen: 116441     level: 1
                backup_extent_root:     30122549706752  gen: 116441     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122549575680  gen: 116441     level: 1
                backup_csum_root:       30122549870592  gen: 116441     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17009168805888
                backup_num_devices:     6

        backup 1:
                backup_tree_root:       30122552590336  gen: 116442     level: 1
                backup_chunk_root:      23219912065024  gen: 116441     level: 1
                backup_extent_root:     30122554408960  gen: 116442     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122549575680  gen: 116441     level: 1
                backup_csum_root:       30122555932672  gen: 116443     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17010697097216
                backup_num_devices:     6

        backup 2:
                backup_tree_root:       30122565173248  gen: 116443     level: 1
                backup_chunk_root:      23219912048640  gen: 116484     level: 1
                backup_extent_root:     30122559078400  gen: 116492     level: 0
                backup_fs_root:         30122471063552  gen: 116492     level: 0
                backup_dev_root:        30122559127552  gen: 116492     level: 0
                backup_csum_root:       30122555932672  gen: 116443     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17011224203264
                backup_num_devices:     6

        backup 3:
                backup_tree_root:       30122548707328  gen: 116440     level: 1
                backup_chunk_root:      23219912048640  gen: 116431     level: 1
                backup_extent_root:     30122548723712  gen: 116440     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122294935552  gen: 116431     level: 1
                backup_csum_root:       30122548822016  gen: 116440     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17009170755584
                backup_num_devices:     6


superblock: bytenr=67108864, device=/dev/sda1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xa715f33e [match]
bytenr                  67108864
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    19b4f289-a87f-4ed8-8882-b0d03e014104
metadata_uuid           19b4f289-a87f-4ed8-8882-b0d03e014104
label
generation              116443
root                    30122565173248
sys_array_size          129
chunk_root_generation   116443
root_level              1
chunk_root              23219912048640
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             31006074101760
bytes_used              17011224203264
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             6
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x1e1
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          RAID56 |
                          SKINNY_METADATA )
cache_generation        116443
uuid_tree_generation    116443
dev_item.uuid           c2b6d51b-f1bc-4e8a-ace5-9acb5b61e1b2
dev_item.fsid           19b4f289-a87f-4ed8-8882-b0d03e014104 [match]
dev_item.type           0
dev_item.total_bytes    8001562152960
dev_item.bytes_used     3334556811264
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          4
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 23219912048640)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 4 offset 1346487779328
                        dev_uuid c2b6d51b-f1bc-4e8a-ace5-9acb5b61e1b2
                        stripe 1 devid 1 offset 4429221527552
                        dev_uuid 6ce59a89-dacb-44dc-9823-8f6a16edd335
backup_roots[4]:
        backup 0:
                backup_tree_root:       30122549657600  gen: 116441     level: 1
                backup_chunk_root:      23219912065024  gen: 116441     level: 1
                backup_extent_root:     30122549706752  gen: 116441     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122549575680  gen: 116441     level: 1
                backup_csum_root:       30122549870592  gen: 116441     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17009168805888
                backup_num_devices:     6

        backup 1:
                backup_tree_root:       30122552590336  gen: 116442     level: 1
                backup_chunk_root:      23219912065024  gen: 116441     level: 1
                backup_extent_root:     30122554408960  gen: 116442     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122549575680  gen: 116441     level: 1
                backup_csum_root:       30122555932672  gen: 116443     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17010697097216
                backup_num_devices:     6

        backup 2:
                backup_tree_root:       30122565173248  gen: 116443     level: 1
                backup_chunk_root:      23219912048640  gen: 116484     level: 1
                backup_extent_root:     30122559078400  gen: 116492     level: 0
                backup_fs_root:         30122471063552  gen: 116492     level: 0
                backup_dev_root:        30122559127552  gen: 116492     level: 0
                backup_csum_root:       30122555932672  gen: 116443     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17011224203264
                backup_num_devices:     6

        backup 3:
                backup_tree_root:       30122548707328  gen: 116440     level: 1
                backup_chunk_root:      23219912048640  gen: 116431     level: 1
                backup_extent_root:     30122548723712  gen: 116440     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122294935552  gen: 116431     level: 1
                backup_csum_root:       30122548822016  gen: 116440     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17009170755584
                backup_num_devices:     6


superblock: bytenr=274877906944, device=/dev/sda1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x5a92a50f [match]
bytenr                  274877906944
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    19b4f289-a87f-4ed8-8882-b0d03e014104
metadata_uuid           19b4f289-a87f-4ed8-8882-b0d03e014104
label
generation              116443
root                    30122565173248
sys_array_size          129
chunk_root_generation   116443
root_level              1
chunk_root              23219912048640
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             31006074101760
bytes_used              17011224203264
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             6
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x1e1
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          RAID56 |
                          SKINNY_METADATA )
cache_generation        116443
uuid_tree_generation    116443
dev_item.uuid           c2b6d51b-f1bc-4e8a-ace5-9acb5b61e1b2
dev_item.fsid           19b4f289-a87f-4ed8-8882-b0d03e014104 [match]
dev_item.type           0
dev_item.total_bytes    8001562152960
dev_item.bytes_used     3334556811264
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          4
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 23219912048640)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 4 offset 1346487779328
                        dev_uuid c2b6d51b-f1bc-4e8a-ace5-9acb5b61e1b2
                        stripe 1 devid 1 offset 4429221527552
                        dev_uuid 6ce59a89-dacb-44dc-9823-8f6a16edd335
backup_roots[4]:
        backup 0:
                backup_tree_root:       30122549657600  gen: 116441     level: 1
                backup_chunk_root:      23219912065024  gen: 116441     level: 1
                backup_extent_root:     30122549706752  gen: 116441     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122549575680  gen: 116441     level: 1
                backup_csum_root:       30122549870592  gen: 116441     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17009168805888
                backup_num_devices:     6

        backup 1:
                backup_tree_root:       30122552590336  gen: 116442     level: 1
                backup_chunk_root:      23219912065024  gen: 116441     level: 1
                backup_extent_root:     30122554408960  gen: 116442     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122549575680  gen: 116441     level: 1
                backup_csum_root:       30122555932672  gen: 116443     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17010697097216
                backup_num_devices:     6

        backup 2:
                backup_tree_root:       30122565173248  gen: 116443     level: 1
                backup_chunk_root:      23219912048640  gen: 116484     level: 1
                backup_extent_root:     30122559078400  gen: 116492     level: 0
                backup_fs_root:         30122471063552  gen: 116492     level: 0
                backup_dev_root:        30122559127552  gen: 116492     level: 0
                backup_csum_root:       30122555932672  gen: 116443     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17011224203264
                backup_num_devices:     6

        backup 3:
                backup_tree_root:       30122548707328  gen: 116440     level: 1
                backup_chunk_root:      23219912048640  gen: 116431     level: 1
                backup_extent_root:     30122548723712  gen: 116440     level: 2
                backup_fs_root:         30122471063552  gen: 116437     level: 2
                backup_dev_root:        30122294935552  gen: 116431     level: 1
                backup_csum_root:       30122548822016  gen: 116440     level: 3
                backup_total_bytes:     31006074101760
                backup_bytes_used:      17009170755584
                backup_num_devices:     6



[bluemond@BlueQ ~]$ sudo btrfs insp dump-t -b 30122546839552 /dev/sda1
btrfs-progs v5.6
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
leaf 30122546839552 items 220 free space 2601 generation 116458 owner EXTENT_TREE
leaf 30122546839552 flags 0x1(WRITTEN) backref revision 1
fs uuid 19b4f289-a87f-4ed8-8882-b0d03e014104
chunk uuid 3115c997-bf8b-4c75-b5a3-40d82169d3f0
        item 0 key (27674016481280 EXTENT_ITEM 6647808) itemoff 16246 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020555120640 count 1
        item 1 key (27674023129088 EXTENT_ITEM 167936) itemoff 16209 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 4923990802432 count 1
        item 2 key (27674023297024 EXTENT_ITEM 7057408) itemoff 16172 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020555120640 count 1
        item 3 key (27674030374912 EXTENT_ITEM 7077888) itemoff 16135 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020555120640 count 1
        item 4 key (27674037452800 EXTENT_ITEM 8818688) itemoff 16098 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020555120640 count 1
        item 5 key (27674046365696 EXTENT_ITEM 4423680) itemoff 16061 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020555120640 count 1
        item 6 key (27674050822144 EXTENT_ITEM 5312512) itemoff 16024 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020555120640 count 1
        item 7 key (27674056134656 EXTENT_ITEM 192512) itemoff 15987 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122676994048 count 1
        item 8 key (27674056327168 EXTENT_ITEM 9228288) itemoff 15950 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 9 key (27674065555456 EXTENT_ITEM 208896) itemoff 15913 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280214827008 count 1
        item 10 key (27674065764352 EXTENT_ITEM 6467584) itemoff 15876 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 11 key (27674072317952 EXTENT_ITEM 8048640) itemoff 15839 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 12 key (27674080444416 EXTENT_ITEM 8077312) itemoff 15802 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 13 key (27674088570880 EXTENT_ITEM 6778880) itemoff 15765 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 14 key (27674095386624 EXTENT_ITEM 6500352) itemoff 15728 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 15 key (27674101940224 EXTENT_ITEM 5480448) itemoff 15691 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 16 key (27674107445248 EXTENT_ITEM 4218880) itemoff 15654 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 17 key (27674111664128 EXTENT_ITEM 217088) itemoff 15617 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122159407104 count 1
        item 18 key (27674111901696 EXTENT_ITEM 6696960) itemoff 15580 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 19 key (27674118598656 EXTENT_ITEM 65536) itemoff 15543 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279284379648 count 1
        item 20 key (27674118717440 EXTENT_ITEM 6647808) itemoff 15506 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 21 key (27674125365248 EXTENT_ITEM 167936) itemoff 15469 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279096455168 count 1
        item 22 key (27674125533184 EXTENT_ITEM 6176768) itemoff 15432 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 23 key (27674131824640 EXTENT_ITEM 6995968) itemoff 15395 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 24 key (27674138902528 EXTENT_ITEM 8138752) itemoff 15358 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 25 key (27674147041280 EXTENT_ITEM 249856) itemoff 15321 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122234511360 count 1
        item 26 key (27674147291136 EXTENT_ITEM 7839744) itemoff 15284 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 27 key (27674155155456 EXTENT_ITEM 6496256) itemoff 15247 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 28 key (27674161709056 EXTENT_ITEM 5644288) itemoff 15210 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 29 key (27674167476224 EXTENT_ITEM 4452352) itemoff 15173 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 30 key (27674171932672 EXTENT_ITEM 3112960) itemoff 15136 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 31 key (27674175078400 EXTENT_ITEM 8372224) itemoff 15099 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 32 key (27674183467008 EXTENT_ITEM 7749632) itemoff 15062 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 33 key (27674191331328 EXTENT_ITEM 6160384) itemoff 15025 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 34 key (27674197491712 EXTENT_ITEM 131072) itemoff 14988 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279284379648 count 1
        item 35 key (27674197622784 EXTENT_ITEM 5574656) itemoff 14951 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 36 key (27674203197440 EXTENT_ITEM 192512) itemoff 14914 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122676764672 count 1
        item 37 key (27674203389952 EXTENT_ITEM 6529024) itemoff 14877 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 38 key (27674209943552 EXTENT_ITEM 6590464) itemoff 14840 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 39 key (27674216534016 EXTENT_ITEM 225280) itemoff 14803 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122163453952 count 1
        item 40 key (27674216759296 EXTENT_ITEM 5660672) itemoff 14766 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020394491904 count 1
        item 41 key (27674222526464 EXTENT_ITEM 4128768) itemoff 14729 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 42 key (27674226720768 EXTENT_ITEM 3756032) itemoff 14692 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 43 key (27674230476800 EXTENT_ITEM 176128) itemoff 14655 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280135282688 count 1
        item 44 key (27674230652928 EXTENT_ITEM 5263360) itemoff 14618 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 45 key (27674235916288 EXTENT_ITEM 241664) itemoff 14581 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122159407104 count 1
        item 46 key (27674236157952 EXTENT_ITEM 4960256) itemoff 14544 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 47 key (27674241138688 EXTENT_ITEM 4894720) itemoff 14507 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 48 key (27674246119424 EXTENT_ITEM 5013504) itemoff 14470 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 49 key (27674251132928 EXTENT_ITEM 221184) itemoff 14433 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122163453952 count 1
        item 50 key (27674251362304 EXTENT_ITEM 4431872) itemoff 14396 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 51 key (27674255818752 EXTENT_ITEM 4894720) itemoff 14359 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 52 key (27674260799488 EXTENT_ITEM 4292608) itemoff 14322 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 53 key (27674265092096 EXTENT_ITEM 163840) itemoff 14285 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020396523520 count 1
        item 54 key (27674265255936 EXTENT_ITEM 6565888) itemoff 14248 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 55 key (27674271821824 EXTENT_ITEM 229376) itemoff 14211 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280209354752 count 1
        item 56 key (27674272071680 EXTENT_ITEM 5505024) itemoff 14174 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 57 key (27674277576704 EXTENT_ITEM 5976064) itemoff 14137 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 58 key (27674283606016 EXTENT_ITEM 4964352) itemoff 14100 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 59 key (27674288586752 EXTENT_ITEM 5480448) itemoff 14063 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 60 key (27674294091776 EXTENT_ITEM 4526080) itemoff 14026 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 61 key (27674298617856 EXTENT_ITEM 192512) itemoff 13989 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020441022464 count 1
        item 62 key (27674298810368 EXTENT_ITEM 6496256) itemoff 13952 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 63 key (27674305363968 EXTENT_ITEM 16154624) itemoff 13915 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279957565440 count 1
        item 64 key (27674321616896 EXTENT_ITEM 9887744) itemoff 13878 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 65 key (27674331578368 EXTENT_ITEM 7372800) itemoff 13841 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 66 key (27674338951168 EXTENT_ITEM 225280) itemoff 13804 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280209354752 count 1
        item 67 key (27674339180544 EXTENT_ITEM 8847360) itemoff 13767 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 68 key (27674348093440 EXTENT_ITEM 7811072) itemoff 13730 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 69 key (27674355957760 EXTENT_ITEM 8171520) itemoff 13693 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 70 key (27674364129280 EXTENT_ITEM 217088) itemoff 13656 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122233790464 count 1
        item 71 key (27674364346368 EXTENT_ITEM 7016448) itemoff 13619 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 72 key (27674371424256 EXTENT_ITEM 10039296) itemoff 13582 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 73 key (27674381463552 EXTENT_ITEM 184320) itemoff 13545 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 7560141701120 count 1
        item 74 key (27674381647872 EXTENT_ITEM 8077312) itemoff 13508 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 75 key (27674389725184 EXTENT_ITEM 36864) itemoff 13471 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020197015552 count 1
        item 76 key (27674389774336 EXTENT_ITEM 6795264) itemoff 13434 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 77 key (27674396590080 EXTENT_ITEM 7417856) itemoff 13397 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 78 key (27674404007936 EXTENT_ITEM 184320) itemoff 13360 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 7560141701120 count 1
        item 79 key (27674404192256 EXTENT_ITEM 7131136) itemoff 13323 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 80 key (27674411323392 EXTENT_ITEM 200704) itemoff 13286 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280220053504 count 1
        item 81 key (27674411532288 EXTENT_ITEM 8908800) itemoff 13249 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 82 key (27674420445184 EXTENT_ITEM 9134080) itemoff 13212 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 83 key (27674429620224 EXTENT_ITEM 7712768) itemoff 13175 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 84 key (27674437332992 EXTENT_ITEM 151552) itemoff 13138 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28019644203008 count 1
        item 85 key (27674437484544 EXTENT_ITEM 8093696) itemoff 13101 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 86 key (27674445611008 EXTENT_ITEM 4902912) itemoff 13064 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 87 key (27674450591744 EXTENT_ITEM 5885952) itemoff 13027 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 88 key (27674456477696 EXTENT_ITEM 139264) itemoff 12990 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020197015552 count 1
        item 89 key (27674456621056 EXTENT_ITEM 7286784) itemoff 12953 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 90 key (27674463961088 EXTENT_ITEM 9035776) itemoff 12916 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 91 key (27674472996864 EXTENT_ITEM 139264) itemoff 12879 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020225720320 count 1
        item 92 key (27674473136128 EXTENT_ITEM 7618560) itemoff 12842 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 93 key (27674480754688 EXTENT_ITEM 245760) itemoff 12805 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280209354752 count 1
        item 94 key (27674481000448 EXTENT_ITEM 9031680) itemoff 12768 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 95 key (27674490032128 EXTENT_ITEM 143360) itemoff 12731 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280506150912 count 1
        item 96 key (27674490175488 EXTENT_ITEM 8699904) itemoff 12694 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 97 key (27674498875392 EXTENT_ITEM 212992) itemoff 12657 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122233921536 count 1
        item 98 key (27674499088384 EXTENT_ITEM 8237056) itemoff 12620 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 99 key (27674507325440 EXTENT_ITEM 151552) itemoff 12583 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 24310685941760 count 1
        item 100 key (27674507476992 EXTENT_ITEM 8601600) itemoff 12546 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 101 key (27674516127744 EXTENT_ITEM 6819840) itemoff 12509 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280504414208 count 1
        item 102 key (27674522947584 EXTENT_ITEM 258048) itemoff 12472 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279725469696 count 1
        item 103 key (27674523205632 EXTENT_ITEM 10412032) itemoff 12435 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 104 key (27674533691392 EXTENT_ITEM 12234752) itemoff 12398 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 105 key (27674546012160 EXTENT_ITEM 9891840) itemoff 12361 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 106 key (27674555973632 EXTENT_ITEM 8740864) itemoff 12324 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 107 key (27674564714496 EXTENT_ITEM 172032) itemoff 12287 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279428198400 count 1
        item 108 key (27674564886528 EXTENT_ITEM 8663040) itemoff 12250 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 109 key (27674573549568 EXTENT_ITEM 249856) itemoff 12213 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280209354752 count 1
        item 110 key (27674573799424 EXTENT_ITEM 10661888) itemoff 12176 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 111 key (27674584547328 EXTENT_ITEM 9232384) itemoff 12139 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 112 key (27674593779712 EXTENT_ITEM 204800) itemoff 12102 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280986841088 count 1
        item 113 key (27674593984512 EXTENT_ITEM 8929280) itemoff 12065 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 114 key (27674602913792 EXTENT_ITEM 237568) itemoff 12028 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 5863440744448 count 1
        item 115 key (27674603159552 EXTENT_ITEM 7999488) itemoff 11991 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280516390912 count 1
        item 116 key (27674611286016 EXTENT_ITEM 7749632) itemoff 11954 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 117 key (27674619150336 EXTENT_ITEM 6713344) itemoff 11917 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 118 key (27674625966080 EXTENT_ITEM 7634944) itemoff 11880 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 119 key (27674633601024 EXTENT_ITEM 225280) itemoff 11843 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 5863440744448 count 1
        item 120 key (27674633830400 EXTENT_ITEM 8347648) itemoff 11806 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 121 key (27674642219008 EXTENT_ITEM 8822784) itemoff 11769 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 122 key (27674651131904 EXTENT_ITEM 7557120) itemoff 11732 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 123 key (27674658734080 EXTENT_ITEM 7606272) itemoff 11695 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 124 key (27674666340352 EXTENT_ITEM 258048) itemoff 11658 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280625754112 count 1
        item 125 key (27674666598400 EXTENT_ITEM 6127616) itemoff 11621 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 126 key (27674672726016 EXTENT_ITEM 163840) itemoff 11584 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28019846856704 count 1
        item 127 key (27674672889856 EXTENT_ITEM 7094272) itemoff 11547 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 128 key (27674679984128 EXTENT_ITEM 245760) itemoff 11510 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122233790464 count 1
        item 129 key (27674680229888 EXTENT_ITEM 11227136) itemoff 11473 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 130 key (27674691502080 EXTENT_ITEM 8495104) itemoff 11436 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 131 key (27674699997184 EXTENT_ITEM 155648) itemoff 11399 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280529727488 count 1
        item 132 key (27674700152832 EXTENT_ITEM 9191424) itemoff 11362 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 133 key (27674709344256 EXTENT_ITEM 221184) itemoff 11325 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122233790464 count 1
        item 134 key (27674709590016 EXTENT_ITEM 10739712) itemoff 11288 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 135 key (27674720337920 EXTENT_ITEM 9732096) itemoff 11251 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 136 key (27674730070016 EXTENT_ITEM 221184) itemoff 11214 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122233790464 count 1
        item 137 key (27674730299392 EXTENT_ITEM 9375744) itemoff 11177 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 138 key (27674739736576 EXTENT_ITEM 11051008) itemoff 11140 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 139 key (27674750787584 EXTENT_ITEM 217088) itemoff 11103 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122234118144 count 1
        item 140 key (27674751008768 EXTENT_ITEM 12079104) itemoff 11066 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 141 key (27674763087872 EXTENT_ITEM 241664) itemoff 11029 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122167648256 count 1
        item 142 key (27674763329536 EXTENT_ITEM 7606272) itemoff 10992 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 143 key (27674770935808 EXTENT_ITEM 258048) itemoff 10955 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29279703105536 count 1
        item 144 key (27674771193856 EXTENT_ITEM 12492800) itemoff 10918 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 145 key (27674783776768 EXTENT_ITEM 9842688) itemoff 10881 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280428163072 count 1
        item 146 key (27674793738240 EXTENT_ITEM 737280) itemoff 10844 itemsize 37
                refs 1 gen 107109 flags DATA
                shared data backref parent 29279105941504 count 1
        item 147 key (27674794524672 EXTENT_ITEM 245760) itemoff 10807 itemsize 37
                refs 1 gen 106489 flags DATA
                shared data backref parent 30122147692544 count 1
        item 148 key (27674794786816 EXTENT_ITEM 8060928) itemoff 10770 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280146391040 count 1
        item 149 key (27674802913280 EXTENT_ITEM 1736704) itemoff 10733 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 28019641319424 count 1
        item 150 key (27674804649984 EXTENT_ITEM 167936) itemoff 10696 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 23219986300928 count 1
        item 151 key (27674804817920 EXTENT_ITEM 176128) itemoff 10659 itemsize 37
                refs 1 gen 104882 flags DATA
                shared data backref parent 28020240449536 count 1
        item 152 key (27674805010432 EXTENT_ITEM 9310208) itemoff 10622 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280146391040 count 1
        item 153 key (27674814447616 EXTENT_ITEM 1048576) itemoff 10585 itemsize 37
                refs 1 gen 104365 flags DATA
                shared data backref parent 23220186726400 count 1
        item 154 key (27674815496192 EXTENT_ITEM 7536640) itemoff 10548 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280146391040 count 1
        item 155 key (27674823098368 EXTENT_ITEM 9768960) itemoff 10511 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280146391040 count 1
        item 156 key (27674832867328 EXTENT_ITEM 192512) itemoff 10474 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 28020528283648 count 1
        item 157 key (27674833059840 EXTENT_ITEM 21815296) itemoff 10437 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280146391040 count 1
        item 158 key (27674854875136 EXTENT_ITEM 200704) itemoff 10400 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280986841088 count 1
        item 159 key (27674855079936 EXTENT_ITEM 1667072) itemoff 10363 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 28019641319424 count 1
        item 160 key (27674856747008 EXTENT_ITEM 200704) itemoff 10326 itemsize 37
                refs 1 gen 104882 flags DATA
                shared data backref parent 23220439678976 count 1
        item 161 key (27674856947712 EXTENT_ITEM 208896) itemoff 10289 itemsize 37
                refs 1 gen 104882 flags DATA
                shared data backref parent 23220439678976 count 1
        item 162 key (27674857177088 EXTENT_ITEM 25477120) itemoff 10252 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280146391040 count 1
        item 163 key (27674882654208 EXTENT_ITEM 212992) itemoff 10215 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 30122234445824 count 1
        item 164 key (27674882867200 EXTENT_ITEM 61267968) itemoff 10178 itemsize 37
                refs 1 gen 104112 flags DATA
                shared data backref parent 29280146391040 count 1
        item 165 key (27674944135168 EXTENT_ITEM 151552) itemoff 10141 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 28020395229184 count 1
        item 166 key (27674944286720 EXTENT_ITEM 143360) itemoff 10104 itemsize 37
                refs 1 gen 106489 flags DATA
                shared data backref parent 23219972423680 count 1
        item 167 key (27674944471040 EXTENT_ITEM 937984) itemoff 10067 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 7559560200192 count 1
        item 168 key (27674945409024 EXTENT_ITEM 258048) itemoff 10030 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 28019635044352 count 1
        item 169 key (27674945667072 EXTENT_ITEM 221184) itemoff 9993 itemsize 37
                refs 1 gen 104162 flags DATA
                shared data backref parent 1959273693184 count 1
        item 170 key (27674945888256 EXTENT_ITEM 258048) itemoff 9956 itemsize 37
                refs 1 gen 104867 flags DATA
                shared data backref parent 2799766552576 count 1
        item 171 key (27674946306048 EXTENT_ITEM 1048576) itemoff 9903 itemsize 53
                refs 1 gen 104112 flags DATA
                extent data backref root ROOT_TREE objectid 9654 offset 0 count 1
        item 172 key (27674947354624 EXTENT_ITEM 3362816) itemoff 9866 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 173 key (27674950762496 EXTENT_ITEM 1609728) itemoff 9829 itemsize 37
                refs 1 gen 104162 flags DATA
                shared data backref parent 28019666698240 count 1
        item 174 key (27674952372224 EXTENT_ITEM 221184) itemoff 9792 itemsize 37
                refs 1 gen 104867 flags DATA
                shared data backref parent 2799766552576 count 1
        item 175 key (27674952597504 EXTENT_ITEM 7790592) itemoff 9755 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 176 key (27674960461824 EXTENT_ITEM 3256320) itemoff 9718 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 177 key (27674963869696 EXTENT_ITEM 3149824) itemoff 9681 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 23220306837504 count 1
        item 178 key (27674967019520 EXTENT_ITEM 258048) itemoff 9644 itemsize 37
                refs 1 gen 104867 flags DATA
                shared data backref parent 2799766552576 count 1
        item 179 key (27674967277568 EXTENT_ITEM 31870976) itemoff 9607 itemsize 37
                refs 1 gen 104113 flags DATA
                shared data backref parent 23220619411456 count 1
        item 180 key (27674999259136 EXTENT_ITEM 21942272) itemoff 9570 itemsize 37
                refs 1 gen 104113 flags DATA
                shared data backref parent 23220619411456 count 1
        item 181 key (27675021279232 EXTENT_ITEM 29499392) itemoff 9533 itemsize 37
                refs 1 gen 104113 flags DATA
                shared data backref parent 23220619411456 count 1
        item 182 key (27675050901504 EXTENT_ITEM 24645632) itemoff 9496 itemsize 37
                refs 1 gen 104113 flags DATA
                shared data backref parent 23220619411456 count 1
        item 183 key (27675075547136 EXTENT_ITEM 258048) itemoff 9459 itemsize 37
                refs 1 gen 104113 flags DATA
                shared data backref parent 29280721780736 count 1
        item 184 key (27675075805184 EXTENT_ITEM 3948544) itemoff 9422 itemsize 37
                refs 1 gen 104113 flags DATA
                shared data backref parent 23220619411456 count 1
        item 185 key (27675079753728 EXTENT_ITEM 229376) itemoff 9385 itemsize 37
                refs 1 gen 104113 flags DATA
                shared data backref parent 30122167648256 count 1
        item 186 key (27675079999488 EXTENT_ITEM 1048576) itemoff 9335 itemsize 50
                refs 2 gen 104113 flags DATA
                shared data backref parent 29280856276992 count 1
                shared data backref parent 26386441879552 count 1
        item 187 key (27675081048064 EXTENT_ITEM 262144) itemoff 9285 itemsize 50
                refs 2 gen 104113 flags DATA
                shared data backref parent 30122580606976 count 1
                shared data backref parent 30122293886976 count 1
        item 188 key (27675081310208 EXTENT_ITEM 20791296) itemoff 9248 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 189 key (27675102101504 EXTENT_ITEM 180224) itemoff 9211 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 30122676797440 count 1
        item 190 key (27675102281728 EXTENT_ITEM 16146432) itemoff 9174 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 191 key (27675118534656 EXTENT_ITEM 18743296) itemoff 9137 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 192 key (27675137277952 EXTENT_ITEM 131072) itemoff 9100 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 29279284330496 count 1
        item 193 key (27675137409024 EXTENT_ITEM 20750336) itemoff 9063 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 194 key (27675158159360 EXTENT_ITEM 217088) itemoff 9026 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 29281025654784 count 1
        item 195 key (27675158380544 EXTENT_ITEM 19812352) itemoff 8989 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 196 key (27675178303488 EXTENT_ITEM 35991552) itemoff 8952 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 197 key (27675214295040 EXTENT_ITEM 184320) itemoff 8915 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 30122506977280 count 1
        item 198 key (27675214479360 EXTENT_ITEM 28688384) itemoff 8878 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 199 key (27675243167744 EXTENT_ITEM 147456) itemoff 8841 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 24310792142848 count 1
        item 200 key (27675243315200 EXTENT_ITEM 27705344) itemoff 8804 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 201 key (27675271102464 EXTENT_ITEM 28364800) itemoff 8767 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 202 key (27675299467264 EXTENT_ITEM 208896) itemoff 8730 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 30122191028224 count 1
        item 203 key (27675299676160 EXTENT_ITEM 12423168) itemoff 8693 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 204 key (27675312099328 EXTENT_ITEM 159744) itemoff 8656 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 28019609403392 count 1
        item 205 key (27675312259072 EXTENT_ITEM 24555520) itemoff 8619 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 206 key (27675336900608 EXTENT_ITEM 45821952) itemoff 8582 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 207 key (27675382775808 EXTENT_ITEM 9080832) itemoff 8545 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 208 key (27675391950848 EXTENT_ITEM 7606272) itemoff 8508 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 209 key (27675399557120 EXTENT_ITEM 258048) itemoff 8471 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 25310294720512 count 1
        item 210 key (27675399815168 EXTENT_ITEM 10326016) itemoff 8434 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 211 key (27675410141184 EXTENT_ITEM 159744) itemoff 8397 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 28019836665856 count 1
        item 212 key (27675410300928 EXTENT_ITEM 8400896) itemoff 8360 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 213 key (27675418701824 EXTENT_ITEM 241664) itemoff 8323 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 29279774638080 count 1
        item 214 key (27675418951680 EXTENT_ITEM 10158080) itemoff 8286 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 215 key (27675429175296 EXTENT_ITEM 7802880) itemoff 8249 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015907328 count 1
        item 216 key (27675437039616 EXTENT_ITEM 5058560) itemoff 8212 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 28019618988032 count 1
        item 217 key (27675442098176 EXTENT_ITEM 184320) itemoff 8175 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 29279343558656 count 1
        item 218 key (27675442282496 EXTENT_ITEM 1888256) itemoff 8138 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 1959015874560 count 1
        item 219 key (27675444170752 EXTENT_ITEM 208896) itemoff 8101 itemsize 37
                refs 1 gen 104122 flags DATA
                shared data backref parent 29280970424320 count 1
[bluemond@BlueQ ~]$



[  113.797333] BTRFS warning (device sdc1): 'nologreplay' is deprecated, use 'rescue=nologreplay' instead
[  113.797336] BTRFS info (device sdc1): disabling log replay at mount time
[  113.797342] BTRFS info (device sdc1): skip mount time block group searching
[  113.797344] BTRFS info (device sdc1): disk space caching is enabled
[  113.797345] BTRFS info (device sdc1): has skinny extents
[  113.798953] verify_parent_transid: 4 callbacks suppressed
[  113.798955] BTRFS error (device sdc1): parent transid verify failed on 23219912048640 wanted 116443 found 116484
[  113.799374] BTRFS error (device sdc1): parent transid verify failed on 23219912048640 wanted 116443 found 116484
[  113.799380] BTRFS error (device sdc1): failed to read chunk root
[  114.014754] BTRFS error (device sdc1): open_ctree failed 
------=_Part_10_95367235.1589593454641--
