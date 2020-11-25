Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E514C2C47A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 19:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgKYS3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 13:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbgKYS3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 13:29:37 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD0C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 10:29:37 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so5583086qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 10:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XQbMpz10IvJvxX8q48xLMAPVXGEULg1pg+5Va54HQVA=;
        b=bevp69Md/Wxj7c/vccLwVAy2mv+iZa6EwDTWLWHHBcSt6MQBFl/tuYGURJHt4y1mBZ
         AxKrH6TYFwOJgbkbWCRKMptLcNGjnviSW1TNM3pylOTbfkw2GvqXHsuYHlFkQDbiwmJc
         slbC16i2T3wj9UcsF8EwGjBsSUqntQerOCad1FvAqTG0qygmqDYRbD1ZiK5w0lMHkFrh
         NTNjMREPoipjY/TOWY+02Vv1MUMN53PAAzKdntrUIPYJUNJ2aV8bAGTAZxiwfIX81Pxc
         T2TDoZPARGPiaKe8Tr8f8yQ5J9Hka8vh4FAJz/z0QRUxPOF5BAhMEPSDIVUmSyPXxbX/
         oZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XQbMpz10IvJvxX8q48xLMAPVXGEULg1pg+5Va54HQVA=;
        b=YTP3PHGELfeydcNmLZIogeBIjyfNzEkQaSbX5BwXySiPfTh1I0MZyoOJ4T5reCe5ef
         P80A766+lH1vP5VUrWyZ0hxBgnX2jSdbavDfYwKGW9RvPo4+OzJTSgzjiyHREFAA71x7
         Y3NOLbFsPbQCu1x+8cr9NeVWTsPUajPzVu9AwcLQHSJQ/DQQa+uEA7ztu8nsNAJm1aQ3
         Ql831OunbVqVIu2YJr64y76yJBQLr9RxkSWVGnd/mSQtuNxNcmwaJWKtVIBAKzM6ND2J
         iFlLrc/gcSX+WCKLyxAnMJsXXa07kBQjTWvdc647Q9Y0AxTPiLo+G/Y50bzyXkujq0P8
         Qf9g==
X-Gm-Message-State: AOAM5319IEQCGMvpyIMNdzG+NcKKd/PsroiGhJ7AwVoSjTDOkeLbxyAc
        m15snDGf1uFRGgDbn1g11EcmqlEAuBH9uIh9vBHaekqopw0=
X-Google-Smtp-Source: ABdhPJx5CcjvtaeLY+tNM49bWnxx025aZRmaUGSRi/Z5oF88M7TBhOX76tS/tivEWK1oz0eoOv1MNDreHlaaUU8zUkI=
X-Received: by 2002:a37:4f57:: with SMTP id d84mr140213qkb.353.1606328976005;
 Wed, 25 Nov 2020 10:29:36 -0800 (PST)
MIME-Version: 1.0
References: <CAMXR++LUTud23_kgWn7WUqHAUSf+f=PjEy=ufGvoTeDJGnd4Kg@mail.gmail.com>
In-Reply-To: <CAMXR++LUTud23_kgWn7WUqHAUSf+f=PjEy=ufGvoTeDJGnd4Kg@mail.gmail.com>
From:   Leorize <alaviss0@gmail.com>
Date:   Wed, 25 Nov 2020 18:28:52 +0000
Message-ID: <CAMXR++KUj2L7qpR7QZeiM2Txav_EqerKKNM3ti1mK0q2-0n_-g@mail.gmail.com>
Subject: Re: Requesting help recovering broken Btrfs file system
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

So I ended up trying btrfs check --repair --init-extent-tree. It
didn't cause any further troubles, but it also didn't enable further
progress in retrieving data from my home folder.

I have decided to wipe the file system and start fresh. Thanks to
everyone who tried to help, your efforts were appreciated.

Regards,
Leorize

On Tue, Nov 24, 2020 at 3:55 PM Hieu Le <alaviss0@gmail.com> wrote:
>
> Hi,
>
> I recently broke my file system by writing to it while the system was
> hibernated then resuming the
> system afterwards.
>
> Here's what I get from running Btrfs scrub:
>
> scrub status for f12ae4d3-a69d-46d8-ae4c-da5a731ff10c
> scrub started at Tue Nov 24 22:18:21 2020 and finished after 00:02:40
> total bytes scrubbed: 410.73GiB with 1 errors
> error details: verify=1
> corrected errors: 0, uncorrectable errors: 1, unverified errors: 0
>
> I've tried btrfs restore but it could not access `home/leorize`. The
> very important data are all backed up,
> however I still have things that wasn't sync-ed in there and I would
> like to retrieve them if possible.
>
> Here are some of the system info:
>
> # uname -a
> Linux leorize-maintenance 5.4.8-lqx2 #4 ZEN SMP PREEMPT Thu Jan 9
> 12:19:45 +07 2020 x86_64 AMD Ryzen 5 3600 6-Core Processor
> AuthenticAMD GNU/Linux
>
> # btrfs --version
> btrfs-progs v4.19
>
> # btrfs fi show
> Label: none  uuid: f12ae4d3-a69d-46d8-ae4c-da5a731ff10c
> Total devices 1 FS bytes used 410.73GiB
> devid    1 size 825.75GiB used 414.05GiB path /dev/mapper/desktop
>
> # btrfs fi df /mnt
> Data, single: total=406.01GiB, used=403.98GiB
> System, single: total=36.00MiB, used=64.00KiB
> Metadata, single: total=8.01GiB, used=6.75GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
> # dmesg (Only the Btrfs part is inlined, check dmesg.log for the full log)
> [ 1221.809775] Btrfs loaded, crc32c=crc32c-intel
> [ 1221.813973] BTRFS: device fsid f12ae4d3-a69d-46d8-ae4c-da5a731ff10c
> devid 1 transid 524556 /dev/mapper/desktop
> [ 1221.814287] BTRFS info (device dm-0): use zstd compression, level 2
> [ 1221.814289] BTRFS info (device dm-0): disk space caching is enabled
> [ 1221.814290] BTRFS info (device dm-0): has skinny extents
> [ 1221.818056] BTRFS info (device dm-0): bdev /dev/mapper/desktop
> errs: wr 0, rd 0, flush 0, corrupt 0, gen 3
> [ 1221.917905] BTRFS info (device dm-0): enabling ssd optimizations
> [ 1223.913639] BTRFS error (device dm-0): parent transid verify failed
> on 20463681536 wanted 524480 found 524513
> [ 3923.727904] BTRFS info (device dm-0): use zstd compression, level 2
> [ 3923.727906] BTRFS info (device dm-0): disk space caching is enabled
> [ 3923.727906] BTRFS info (device dm-0): has skinny extents
> [ 3923.731209] BTRFS info (device dm-0): bdev /dev/mapper/desktop
> errs: wr 0, rd 0, flush 0, corrupt 0, gen 3
> [ 3923.819514] BTRFS info (device dm-0): enabling ssd optimizations
> [ 3923.819868] BTRFS info (device dm-0): checking UUID tree
> [ 3929.550008] BTRFS info (device dm-0): scrub: started on devid 1
> [ 3936.604625] BTRFS warning (device dm-0): checksum/header error at
> logical 20463681536 on dev /dev/mapper/desktop, physical 20463681536:
> metadata node (level 1) in tree 293
> [ 3936.604627] BTRFS warning (device dm-0): checksum/header error at
> logical 20463681536 on dev /dev/mapper/desktop, physical 20463681536:
> metadata node (level 1) in tree 293
> [ 3936.604628] BTRFS error (device dm-0): bdev /dev/mapper/desktop
> errs: wr 0, rd 0, flush 0, corrupt 0, gen 4
> [ 3936.604629] BTRFS error (device dm-0): unable to fixup (regular)
> error at logical 20463681536 on dev /dev/mapper/desktop
> [ 4090.100349] BTRFS info (device dm-0): scrub: finished on devid 1
> with status: 0
>
> # btrfs inspect-internal logical-resolve 20463681536 /mnt
> ERROR: logical ino ioctl: No such file or directory
>
> # btrfs inspect-internal dump-tree -b 20463681536 /dev/mapper/desktop
> btrfs-progs v4.19
> node 20463681536 level 1 items 10 free 483 generation 524513 owner ROOT_TREE
> fs uuid f12ae4d3-a69d-46d8-ae4c-da5a731ff10c
> chunk uuid b1f85ce2-55a9-4c0e-868c-ee0d45b2b7d6
> key (EXTENT_TREE ROOT_ITEM 0) block 20468891648 gen 524513
> key (299 EXTENT_DATA 0) block 20473692160 gen 524513
> key (368 EXTENT_DATA 0) block 20444069888 gen 524512
> key (448 INODE_ITEM 0) block 20471840768 gen 524513
> key (563 EXTENT_DATA 0) block 20446396416 gen 524512
> key (670 INODE_ITEM 0) block 20446904320 gen 524512
> key (743 INODE_ITEM 0) block 20447428608 gen 524512
> key (879 EXTENT_DATA 0) block 20476018688 gen 524513
> key (FREE_SPACE UNTYPED 71962722304) block 20478164992 gen 524513
> key (FREE_SPACE UNTYPED 383381405696) block 20462698496 gen 524512
>
> I asked on IRC and was told that `btrfs check --repair
> --init-extent-tree` might fix it, but was also
> told to backup my drive and consult you folks before trying (I don't
> have the storage to do a full block
> backup so I'm kinda screwed there, but I'm willing to YOLO it at this
> point since most of the important
> stuff are off the drive already).
>
> Please CC me when posting replies since I'm not subscribed to the list.
>
> Thanks,
> Leorize
