Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADC7196E81
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgC2Qkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 12:40:55 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45725 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2Qkz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 12:40:55 -0400
Received: by mail-yb1-f195.google.com with SMTP id g6so7627416ybh.12
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LSM1MUqQEkuJkwfHKr560ghWS1gpF61Zq+WPOuuFVHI=;
        b=rWrNP4YO10VxFPDrtgWOaADGYQYAR1Nxe9bQ84DCQPaZqyZUaQPBc5BwHvRhrBGgC3
         vWpH6FLHVxf45QXztxYjGGgXN9TTzjXgIebeKAQjSeFYmDnzZuTZwJ16/mP/BGS/neiU
         Exqi+WvrSgawAVcOtWx5BtBMKw+Numn/5cpy/zgqWiaeSDgRiYrA/Hm0645uK7UqPEqZ
         DJbmWqEgUzpP90blewzHLtYXoHBkNbPq0nqKaWh6YpyRdI3UT5KCIHEukQYBOkTRDgVw
         Jdx6zPioTYlFLOzgWCUMquXjLBxla+GopaHDZx8pzBTBzcL5hEblGcHefPBDb8ULRWk8
         TRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LSM1MUqQEkuJkwfHKr560ghWS1gpF61Zq+WPOuuFVHI=;
        b=iqjW89qivZIHaqdPSLj3NT4CskOLeUYdhUMU7UKxPTT+why3t3Mf2NU6O8KWFRsCrp
         oenMGFfeP6bKyw4AN6p7y5x25efTij/9/hb/o70fvXpGf7ksATZfItQT81FZnrcwEil4
         T7KeJpIw/5Ms0sh9eoY3wtrgjQOt6I1KetqOj7HbeXDC74DHwh58KL6I79VgYeWenbqT
         wmHiU3DzaAvCja2WjNmNpx3Y0Xegtk4nIIYt/jzamG1wLH0c+5c8igF9DfRNuOk4PHj+
         2MFAmQ/zW4jRVOwl0Ddg3Ck4nryqF0tXkcEv+1Sn51TiKa3X38LXm9bAPqlYa1BEM1wg
         zPDA==
X-Gm-Message-State: ANhLgQ1+eZ3dCQsWfI5iYRyXuMH6RfaJhDyjuuSoy8xOZXqYz0LLelmo
        oYUwGDfV9/UeOsrzNNcbi2YeRilF+pqeEQIwQJ50Dg==
X-Google-Smtp-Source: ADFU+vtlxQ4/303fzcWTbqgfieqRaIKJGGt8DKvXBLm2qhGC48yIRvv5yJau40NHHz1dS2gNF91F7MllRQYGNPfxj+Q=
X-Received: by 2002:a25:df0b:: with SMTP id w11mr13465057ybg.195.1585500053292;
 Sun, 29 Mar 2020 09:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <B7A6E37C-C10A-49C3-B98A-0D659CA4E33B@clarafamily.com>
In-Reply-To: <B7A6E37C-C10A-49C3-B98A-0D659CA4E33B@clarafamily.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Sun, 29 Mar 2020 17:40:41 +0100
Message-ID: <CAG_8rEfmJrCtkgpBnUjnWwVuzJNkyM=u1vaBbX-3+UnvQ9Vizw@mail.gmail.com>
Subject: Re: Device Delete Stuck
To:     Jason Clara <jason@clarafamily.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jason,

I am not a btrfs developer but I had he same problem as you.  In my
case the problem went away when I used the mount option to clear the
free space cache.  From my own experience, whatever is going wrong
that causes the checksum error also corrupts this cache but that does
no long term harm as, once it is cleared on mount, it gets rebuilt.

Steve.

On Sun, 29 Mar 2020 at 15:15, Jason Clara <jason@clarafamily.com> wrote:
>
> I had a previous post about when trying to do a device delete that it wou=
ld cause my whole system to hang.  I seem to have got past that issue.
>
> For that, it seems like even though all the SCRUBs finished without any e=
rrors I still had a problem with some files.  By forcing a read of every si=
ngle file I was able to detect the bad files in DMESG.  Not sure though why=
 SCRUB didn=E2=80=99t detect this.
> BTRFS warning (device sdd1): csum failed root 5 ino 14654354 off 16385228=
8 csum 0
>
>
> But now when I attempt to delete a device from the array it seems to get =
stuck.  Normally it will show in the log that it has found some extents and=
 then another message saying they were relocated.
>
> But for the last few days it has just been repeating the same found value=
 and never relocating anything, and the usage of the device doesn=E2=80=99t=
 change at all.
>
> This line has now been repeating for more then 24 hours, and the previous=
 attempt was similar.
> [Sun Mar 29 09:59:50 2020] BTRFS info (device sdd1): found 133 extents
>
> Prior to this run I had tried with an earlier kernel (5.5.10) and had the=
 same results.  It starts with finding and then relocating, but then reloca=
ting.  So I upgraded my kernel to see if that would help, and it has not.
>
> System Info
> Ubuntu 18.04
> btrfs-progs v5.4.1
> Linux FileServer 5.5.13-050513-generic #202003251631 SMP Wed Mar 25 16:35=
:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> DEVICE USAGE
> /dev/sdd1, ID: 1
>    Device size:             2.73TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:            888.43GiB
>    Unallocated:             1.00MiB
>
> /dev/sdb1, ID: 2
>    Device size:             2.73TiB
>    Device slack:            2.73TiB
>    Data,RAID6:            188.67GiB
>    Data,RAID6:            508.82GiB
>    Data,RAID6:              2.00GiB
>    Unallocated:          -699.50GiB
>
> /dev/sdc1, ID: 3
>    Device size:             2.73TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:            888.43GiB
>    Unallocated:             1.00MiB
>
> /dev/sdi1, ID: 5
>    Device size:             2.73TiB
>    Device slack:            1.36TiB
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.18TiB
>    Unallocated:             1.00MiB
>
> /dev/sdh1, ID: 6
>    Device size:             4.55TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          2.00GiB
>    Unallocated:           601.01GiB
>
> /dev/sda1, ID: 7
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          2.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             3.32TiB
>
> /dev/sdf1, ID: 8
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          8.00GiB
>    Unallocated:             3.31TiB
>
> /dev/sdj1, ID: 9
>    Device size:             7.28TiB
>    Device slack:              0.00B
>    Data,RAID6:            188.67GiB
>    Data,RAID6:              1.68TiB
>    Data,RAID6:              1.23TiB
>    Data,RAID6:            888.43GiB
>    Data,RAID6:              2.00GiB
>    Metadata,RAID1:          8.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             3.31TiB
>
>
> FI USAGE
> WARNING: RAID56 detected, not implemented
> Overall:
>     Device size:                  33.20TiB
>     Device allocated:             20.06GiB
>     Device unallocated:           33.18TiB
>     Device missing:                  0.00B
>     Used:                         19.38GiB
>     Free (estimated):                0.00B      (min: 8.00EiB)
>     Data ratio:                       0.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>
> Data,RAID6: Size:15.42TiB, Used:15.18TiB (98.44%)
>    /dev/sdd1       2.73TiB
>    /dev/sdb1     699.50GiB
>    /dev/sdc1       2.73TiB
>    /dev/sdi1       1.36TiB
>    /dev/sdh1       3.96TiB
>    /dev/sda1       3.96TiB
>    /dev/sdf1       3.96TiB
>    /dev/sdj1       3.96TiB
>
> Metadata,RAID1: Size:10.00GiB, Used:9.69GiB (96.90%)
>    /dev/sdh1       2.00GiB
>    /dev/sda1       2.00GiB
>    /dev/sdf1       8.00GiB
>    /dev/sdj1       8.00GiB
>
> System,RAID1: Size:32.00MiB, Used:1.19MiB (3.71%)
>    /dev/sda1      32.00MiB
>    /dev/sdj1      32.00MiB
>
> Unallocated:
>    /dev/sdd1       1.00MiB
>    /dev/sdb1    -699.50GiB
>    /dev/sdc1       1.00MiB
>    /dev/sdi1       1.00MiB
>    /dev/sdh1     601.01GiB
>    /dev/sda1       3.32TiB
>    /dev/sdf1       3.31TiB
>    /dev/sdj1       3.31TiB
>
>
> FI SHOW
> Label: 'Pool1'  uuid: 99935e27-4922-4efa-bf76-5787536dd71f
>         Total devices 8 FS bytes used 15.19TiB
>         devid    1 size 2.73TiB used 2.73TiB path /dev/sdd1
>         devid    2 size 0.00B used 699.50GiB path /dev/sdb1
>         devid    3 size 2.73TiB used 2.73TiB path /dev/sdc1
>         devid    5 size 1.36TiB used 1.36TiB path /dev/sdi1
>         devid    6 size 4.55TiB used 3.96TiB path /dev/sdh1
>         devid    7 size 7.28TiB used 3.96TiB path /dev/sda1
>         devid    8 size 7.28TiB used 3.97TiB path /dev/sdf1
>         devid    9 size 7.28TiB used 3.97TiB path /dev/sdj1
>
> FI DF
> Data, RAID6: total=3D15.42TiB, used=3D15.18TiB
> System, RAID1: total=3D32.00MiB, used=3D1.19MiB
> Metadata, RAID1: total=3D10.00GiB, used=3D9.69GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
