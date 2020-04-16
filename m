Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE51AC050
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634239AbgDPLyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 07:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634153AbgDPLx4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 07:53:56 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32A8C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 04:53:55 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id t8so2700123uap.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ai02csrIwWn1vKnp4o6/bLVh7VivJj/gD9gFxRiSKX0=;
        b=t5y+tTsX4QDB0RtToDiMPe20+aAWYLy3/hYnf0P+pVm0trQjlD2iSpRi+OglIEBwNV
         eha/Jdfg8wIbl4wwY3zNUnaPuOtmEc2yyGNRZUMPuS4YPrI8VhNKmpz2M++/GCgAe7w1
         AOV5hsm2SrEeP795zgSW6Pz6oACW7Pykdn5b3ES6ri+pyHe6+1MWw8HO2EyMU4P1T6eu
         4hMqnc6305PvDNnCDmnnGP5X0dcYJUks74HVk9woc5rkeoVR4Ug0sRYby81shRCMuCyP
         Ozuz+taVsbRnXFFhFU9KckEY8pTU13ojATZZLRWJ8UJhwkt5ONbJ9aPdDkul9jBfSuuc
         Gc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ai02csrIwWn1vKnp4o6/bLVh7VivJj/gD9gFxRiSKX0=;
        b=oqooln4ZsqfHy3P47xf/YC2giUxSdl0cvL9FiW0/Fxb4E5srhzcGJGiBVI7eQCDAF1
         mAm16sj6F06IXt99BF25972fFq78D/6lK+ozSOEZq4GOvX7/l9WLG5LDRc9rC442rcJT
         OSOwEO7YUCqLXXu5XuwcZFRNalbr9lUQ7XjFP2cyR6YOLMNsXccdjWBhE9FAPLdpQi+g
         C82s52Zr1uwmlDsKhAFOjOCeEh1OkRlI89TenREA3gfvtC3KAQ8eR2d/rKnwSqvmuliJ
         I5Vv49VOVPvkni4jpc1fEIn4I5raRo3LUWPNM7jF9MYf0FM9B8/paZqHCJRgznqqsj7G
         Px1w==
X-Gm-Message-State: AGi0PubbrrYA6dUvL3md0CP8hFx2JhP1RwjVgSP8AXIn4aJlZVfLW6jd
        uzH/dMrsRY5LGin431GGz8WaJaWfYtGiOmJk09w=
X-Google-Smtp-Source: APiQypI5xjG4LZF4LXlsIdVbxKsZ0Dx3BXOVqYpV8eI0zJAfXg7OwS1C4Djx/MVrer/KWvHX6nph5uOZjhPlEi2BBxI=
X-Received: by 2002:ab0:e5:: with SMTP id 92mr8310187uaj.83.1587038034275;
 Thu, 16 Apr 2020 04:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <87blnsuv7m.fsf@gmail.com>
In-Reply-To: <87blnsuv7m.fsf@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 16 Apr 2020 12:53:43 +0100
Message-ID: <CAL3q7H58UOROQMe-AXhZ39u=oy93zExgYgj1R+pHOs=Tk5psrA@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Matt Huszagh <huszaghmatt@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 2:16 AM Matt Huszagh <huszaghmatt@gmail.com> wrote:
>
> I'm attempting to perform a backup to an external hard drive. Both the
> native drive and external drive use a BTRFS filesystem. I do this by
> first creating a read-only snapshot of my home directory:
>
> # btrfs subvolume snapshot -r /home /.snapshots/home/BACKUP
>
> Followed by a send/receive to the backup drive:
>
> # btrfs send /.snapshots/home/BACKUP | btrfs receive /.backup/home
>
> I get this output:
>
> At subvol /.snapshots/home/BACKUP
> At subvol BACKUP
> ERROR: failed to clone extents to matt/.local/share/Anki2/Matt/collection=
.anki2: Invalid argument
>
> There several files that trigger this error (most of them .sqlite
> files). I can delete the offending files, which causes the backup to
> work. However, new offending files are created that recreate the error
> (e.g. Firefox generates lots of offending .sqlite files).
>
> I performed
>
> # btrfs scrub start -B /
>
> which exited without errors and failed to resolve the issue and I even
> ran check --repair on my filesystem unmounted:
>
> # btrfs check --repair /dev/mapper/...
>
> which didn't make a difference.
>
> uname -a:
> Linux ryzen3950 5.5.0 #1-NixOS SMP Mon Jan 27 00:23:03 UTC 2020 x86_64 GN=
U/Linux

The issue you are hitting is very likely what was fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D9722b10148504c4153a74a9c89725af271e490fc

Upgrade your kernel from 5.5.0 to at least 5.5.3 (latest 5.5 stable
release is 5.5.17).

And rest assured that kind of problem is not because of any
corruption, so need to do a scrub or 'check --repair'.


>
> btrfs --version
> btrfs-progs v5.4.1
>
> btrfs fi show
> Label: 'btrfs'  uuid: d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b
>         Total devices 2 FS bytes used 737.53GiB
>         devid    1 size 931.01GiB used 853.03GiB path /dev/mapper/cryptnv=
me
>         devid    2 size 931.50GiB used 853.03GiB path /dev/mapper/cryptnv=
me1
>
> Label: 'backup'  uuid: 0bd10808-0330-4736-9425-059d4a0a300e
>         Total devices 2 FS bytes used 473.34GiB
>         devid    1 size 1.82TiB used 475.01GiB path /dev/mapper/cryptsda1
>         devid    2 size 1.82TiB used 475.01GiB path /dev/mapper/cryptsdb1
>
> btrfs fi df /
> Data, RAID0: total=3D1.44TiB, used=3D730.13GiB
> System, RAID1: total=3D32.00MiB, used=3D144.00KiB
> Metadata, RAID1: total=3D20.00GiB, used=3D7.40GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> Here's the output of dmesg. I've only taken the lines containing
> dmesg. Please let me know if this is insufficient and I'll provide the
> full log.
>
> [    1.168132] stage-1-init: loading module btrfs...
> [    1.442869] Btrfs loaded, crc32c=3Dcrc32c-intel
> [   14.552850] BTRFS: device label backup devid 2 transid 303 /dev/mapper=
/cryptsdb1 scanned by btrfs (857)
> [   14.553396] BTRFS: device label backup devid 1 transid 303 /dev/mapper=
/cryptsda1 scanned by btrfs (857)
> [   14.553487] BTRFS: device label btrfs devid 2 transid 409463 /dev/mapp=
er/cryptnvme1 scanned by btrfs (857)
> [   14.553573] BTRFS: device label btrfs devid 1 transid 409463 /dev/mapp=
er/cryptnvme scanned by btrfs (857)
> [   14.553634] stage-1-init: Scanning for Btrfs filesystems
> [   14.561445] BTRFS info (device dm-0): use lzo compression, level 0
> [   14.561447] BTRFS info (device dm-0): enabling ssd optimizations
> [   14.561447] BTRFS info (device dm-0): disk space caching is enabled
> [   14.561448] BTRFS info (device dm-0): has skinny extents
> [   14.637769] BTRFS info (device dm-0): checking UUID tree
> [   14.786327] BTRFS info (device dm-0): disk space caching is enabled
> [   15.926714] BTRFS info (device dm-0): device fsid d31878d6-3a77-4f0f-9=
fdd-bb9a2c4e578b devid 1 moved old:/dev/mapper/cryptnvme new:/dev/dm-0
> [   15.926763] BTRFS info (device dm-0): device fsid d31878d6-3a77-4f0f-9=
fdd-bb9a2c4e578b devid 2 moved old:/dev/disk/by-uuid/d31878d6-3a77-4f0f-9fd=
d-bb9a2c4e578b new:/dev/dm-1
> [   16.043567] BTRFS info (device dm-0): disk space caching is enabled
> [   16.074722] BTRFS info (device dm-2): use lzo compression, level 0
> [   16.074723] BTRFS info (device dm-2): disk space caching is enabled
> [   16.074724] BTRFS info (device dm-2): has skinny extents
> [27057.785935] BTRFS info (device dm-0): scrub: started on devid 1
> [27057.800078] BTRFS info (device dm-0): scrub: started on devid 2
> [27107.287558] BTRFS info (device dm-0): scrub: not finished on devid 1 w=
ith status: -125
> [27107.316437] BTRFS info (device dm-0): scrub: not finished on devid 2 w=
ith status: -125
> [27109.542589] BTRFS info (device dm-0): scrub: started on devid 1
> [27109.556751] BTRFS info (device dm-0): scrub: started on devid 2
> [27243.975463] BTRFS info (device dm-0): scrub: finished on devid 1 with =
status: 0
> [27247.857511] BTRFS info (device dm-0): scrub: finished on devid 2 with =
status: 0
> [250470.993201] [  23284]     0 23284     3204       25    45056        0=
             0 btrfs
> [250470.993203] [  23286]     0 23286     1155       53    40960        0=
             0 btrfs
>
> Thanks!
> Matt



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
