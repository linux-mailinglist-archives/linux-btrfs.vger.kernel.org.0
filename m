Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939173301CC
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Mar 2021 14:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhCGN7W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 08:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhCGN6x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 08:58:53 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37453C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 05:58:51 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z13so7133545iox.8
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Mar 2021 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ojc0nnAmi09tm7Dgxi2iQtulYHEvoheNAidHH6EDIVI=;
        b=QzqRAyN8QTnteCbxizPgCd9+wBhZ9Fc80Ceumsvl2f/ZRjlhql2xSiDoF+xPwSOQGV
         VvhBNOY6ViKOwmzirN5jjAVCV2+gHjKWjfrPIvee5sPB0LaiZeUauLq8SyyM2IB7A6wZ
         GEx0yCoEQSh9HdgV6a55OkgLUvIfAaUSPzYkrats1TU2Vjz7u70YJTH3M1DAAP2qHzz+
         XQkZ8IVtxWpVQ6zxJbaSCyvoEMXG+yQbYNnXbakovT0BtGbWfLtIkLamW/XS9UYZ8x9F
         wWKXsgbs7waFOr5/iHZPzjnrRMhg478ple7YpkD1fmmXxtHWK0cJk7X5GqyLOd6szr4O
         dmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ojc0nnAmi09tm7Dgxi2iQtulYHEvoheNAidHH6EDIVI=;
        b=QXp75AJiguUAjw3PAW5mG4Ep7A4gP7ubQ+zEttV1MbUSqFay3X5BqOvJpblLkVC3X4
         +i5xC/LEApwIj7iVpOUOSQ5Gez+AbmmZzwRo+IEuGOz0l/VcOsAlSq5xsQPZJKJl99mV
         ju8/fQRk+m00DIs+OJ92o1OwWDabS/zt/VNdvlY1hDLKPKf3+kNr+d0wWlK3pCTnhxeN
         Z5mHHzd+awAq5fTlJAFre0WkkIldBnY2NqfYD51/wTj1PibmR71v0ezAS8Z5HeIkG0hU
         fuCCQ91vh0nQ9VfrgjGYZar3EdLYvAmLSJEOUSFS5e2YvoORCUJxRvGUi6krI4mUWjeN
         C20w==
X-Gm-Message-State: AOAM5335pVttII2R+vVrAF1+x+fg73cBVy9BNYp0uKkXbI8Jukts7oYV
        4gRLk9tP4LIY+RXtLI8FKY8iI0c7GD8TsxiMsq0yrEgk1Gs=
X-Google-Smtp-Source: ABdhPJw1mA0rG3enqiYxl13XslwDitGz8jsmuQo3nxz5Ez7CqtAi2nN3EoJr2+HPe+IS6r6hxVwVBK2B8CAlNeMX/mA=
X-Received: by 2002:a02:9986:: with SMTP id a6mr19062750jal.46.1615125530570;
 Sun, 07 Mar 2021 05:58:50 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
 <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
 <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
 <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com> <CAJCQCtR8pXnfVwrtBEvbvm8qrDwMyqyckZyNNgrSwO8++ShfdA@mail.gmail.com>
In-Reply-To: <CAJCQCtR8pXnfVwrtBEvbvm8qrDwMyqyckZyNNgrSwO8++ShfdA@mail.gmail.com>
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Sun, 7 Mar 2021 14:58:14 +0100
Message-ID: <CALS+qHN7hyFzKZHrMj5_95pPTPR9sEgwqzgVqxFK70fs5FW4xA@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > > I don't know. The exact nature of the damage of a failing controller
> > > is adding a significant unknown component to it. If it was just a
> > > matter of not writing anything at all, then there'd be no problem. But
> > > it sounds like it wrote spurious or corrupt data, possibly into
> > > locations that weren't even supposed to be written to.
> >
> > Unfortunately I cannot figure out exactly what happened. Logs end
> > Friday night while the backup script was running -- which also
> > includes a finalizing balancing of the device. Monday morning after
> > some exchange of hardware the machine came up being unable to mount
> > the device.
>
> It's probably not discernible with logs anyway. What hardware does
> when it goes berserk? It's chaos. And all file systems have write
> order requirements. It's fine if at a certain point writes just
> abruptly stop going to stable media. But if things are written out of
> order, or if the hardware acknowledges critical metadata writes are
> written but were actually dropped, it's bad. For all file systems.
>
>
> > OK -- I now had the chance to temporarily switch to 5.11.2. Output
> > looks cleaner, but the error stays the same.
> >
> > root@hikitty:/mnt$ mount -o ro,rescue=all /dev/sdi1 hist/
> >
> > [ 3937.815083] BTRFS info (device sdi1): enabling all of the rescue options
> > [ 3937.815090] BTRFS info (device sdi1): ignoring data csums
> > [ 3937.815093] BTRFS info (device sdi1): ignoring bad roots
> > [ 3937.815095] BTRFS info (device sdi1): disabling log replay at mount time
> > [ 3937.815098] BTRFS info (device sdi1): disk space caching is enabled
> > [ 3937.815100] BTRFS info (device sdi1): has skinny extents
> > [ 3938.903454] BTRFS error (device sdi1): bad tree block start, want
> > 122583416078336 have 0
> > [ 3938.994662] BTRFS error (device sdi1): bad tree block start, want
> > 99593231630336 have 0
> > [ 3939.201321] BTRFS error (device sdi1): bad tree block start, want
> > 124762809384960 have 0
> > [ 3939.221395] BTRFS error (device sdi1): bad tree block start, want
> > 124762809384960 have 0
> > [ 3939.221476] BTRFS error (device sdi1): failed to read block groups: -5
> > [ 3939.268928] BTRFS error (device sdi1): open_ctree failed
>
> This looks like a super is expecting something that just isn't there
> at all. If spurious behavior lasted only briefly during the hardware
> failure, there's a chance of recovery. But this diminishes greatly if
> the chaotic behavior was on-going for a while, many seconds or a few
> minutes.
>
>
> > I still hope that there might be some error in the fs created by the
> > crash, which can be resolved instead of real damage to all the data in
> > the FS trees. I used a lot of snapshots and deduplication on that
> > device, so that I expect some damage by a hardware error. But I find
> > it hard to believe that every file got damaged.
>
> Correct. They aren't actually damaged.
>
> However, there's maybe 5-15 MiB of critical metadata on Btrfs, and if
> it gets corrupt, the keys to the maze are lost. And it becomes
> difficult, sometimes impossible, to "bootstrap" the file system. There
> are backup entry points, but depending on the workload, they go stale
> in seconds to a few minutes, and can be subject to being overwritten.
>
> When 'btrfs restore' is doing partial recovery that ends up with a lot
> of damage and holes tells me it's found stale parts of the file system
> - it's on old rails so to speak, there's nothing available to tell it
> that this portion of the tree is just old and not valid anymore (or
> only partially valid), but also the restore code is designed to be
> more tolerant of errors because otherwise it would just do nothing at
> all.
>
> I think if you're able to find the most recent root node for a
> snapshot you want to restore, along with an intact chunk tree it
> should be possible to get data out of that snapshot. The difficulty is
> finding it, because it could be almost anywhere.

Would it make sense to just try  restore -t on any root I got with
btrfs-find-root with all of the snapshots?

> OK so you said there's an original and backup file system, are they
> both in equally bad shape, having been on the same controller? Are
> they both btrfs?

The original / live file system was not btrfs but xfs. It is in a
different but equally bad state than the backup. We used bcache with a
write-back cache on a ssd which is now completely dead (does not get
recognized by any server anymore). To get the file system mounted I
ran xfs-repair. After that only 6% of the data was left and this is
nearly completely in lost+found. I'm now trying to sort these files by
type, since the data itself looks OK. Unfortunately the surviving
files seem to be the oldest ones.

> What do you get for
>
> btrfs insp dump-s -f /dev/sdXY
>
> There might be a backup tree root in there that can be used with btrfs
> restore -t

This is the output of ./btrfs  insp dump-s -f /dev/sdi1 run with
btrfs-progs 5.9.

./btrfs insp dump-s -f /dev/sdi1
superblock: bytenr=65536, device=/dev/sdi1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x9e6891fc [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    56051c5f-fca6-4d54-a04e-1c1d8129fe56
metadata_uuid           56051c5f-fca6-4d54-a04e-1c1d8129fe56
label                   history
generation              825256
root                    122583415865344
sys_array_size          129
chunk_root_generation   825256
root_level              2
chunk_root              141944043454464
chunk_root_level        2
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             80013782134784
bytes_used              75176955760640
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
cache_generation        825256
uuid_tree_generation    825256
dev_item.uuid           844e80b3-a8d5-4738-ac8a-4f54980556f6
dev_item.fsid           56051c5f-fca6-4d54-a04e-1c1d8129fe56 [match]
dev_item.type           0
dev_item.total_bytes    80013782134784
dev_item.bytes_used     75413317484544
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          2
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 141944034426880)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 2 offset 2034741805056
                        dev_uuid 844e80b3-a8d5-4738-ac8a-4f54980556f6
                        stripe 1 devid 2 offset 2034775359488
                        dev_uuid 844e80b3-a8d5-4738-ac8a-4f54980556f6
backup_roots[4]:
        backup 0:
                backup_tree_root:       122583415865344 gen: 825256     level: 2
                backup_chunk_root:      141944043454464 gen: 825256     level: 2
                backup_extent_root:     122583418175488 gen: 825256     level: 3
                backup_fs_root:         58363985428480  gen: 789775     level: 0
                backup_dev_root:        122583415783424 gen: 825256     level: 1
                backup_csum_root:       122583553703936 gen: 825256     level: 3
                backup_total_bytes:     80013782134784
                backup_bytes_used:      75176955760640
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       122343302234112 gen: 825253     level: 2
                backup_chunk_root:      141944034426880 gen: 825251     level: 2
                backup_extent_root:     122343333937152 gen: 825253     level: 3
                backup_fs_root:         58363985428480  gen: 789775     level: 0
                backup_dev_root:        122077274357760 gen: 825250     level: 1
                backup_csum_root:       122343380992000 gen: 825253     level: 3
                backup_total_bytes:     80013782134784
                backup_bytes_used:      75176955105280
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       122343762804736 gen: 825254     level: 2
                backup_chunk_root:      141944034426880 gen: 825251     level: 2
                backup_extent_root:     122343762935808 gen: 825254     level: 3
                backup_fs_root:         58363985428480  gen: 789775     level: 0
                backup_dev_root:        122077274357760 gen: 825250     level: 1
                backup_csum_root:       122343764967424 gen: 825254     level: 3
                backup_total_bytes:     80013782134784
                backup_bytes_used:      75176955105280
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       122574011269120 gen: 825255     level: 2
                backup_chunk_root:      141944034426880 gen: 825251     level: 2
                backup_extent_root:     122574011432960 gen: 825255     level: 3
                backup_fs_root:         58363985428480  gen: 789775     level: 0
                backup_dev_root:        122077274357760 gen: 825250     level: 1
                backup_csum_root:       122574014791680 gen: 825255     level: 3
                backup_total_bytes:     80013782134784
                backup_bytes_used:      75176955236352
                backup_num_devices:     1
