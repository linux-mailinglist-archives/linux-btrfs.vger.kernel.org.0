Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A711E15E6F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394218AbgBNQvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 11:51:16 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:42250 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394217AbgBNQvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 11:51:15 -0500
Received: by mail-ua1-f52.google.com with SMTP id p2so3792127uao.9
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xIu3T5/+ScLfuEND5sseDc1HRL1SPvnGgBFk/5TOdGY=;
        b=rsizz0BmRT4SpjUb2bMg+DFyIjLPZ2paOPAHlJtfyYbX3V6uOjHncngO8ZUEzWWs3V
         J/5v6A174kNR/KPRJAa7Jat4ujz4YAUTwYtQOV6bcXgf/g5G8DD4PS5/1b51OJimbfZz
         WXeViXqdrirhhkbch4FSjiz08bUljY8zdq/Erlw/V8lRo1dAkbSSTPrGelR2gEOc5wlw
         PbIjNkbHHqNIYcpnN+wOv3rWgV/tFl2QisBT8+HZoEGIA1P0m8d39RdXzPLDyOrY882u
         U+UlbDC5jqF2MIVcT33u89lyeuJesdGse2HpgjTkuu8SIiJkL9CKK5IY+3pYVZoUEphO
         jYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xIu3T5/+ScLfuEND5sseDc1HRL1SPvnGgBFk/5TOdGY=;
        b=JiidB7f8EPDiBs6o/AAjPx69/eKJHkuEAtWG+WgAzP5BDBrAe8CgKlucJ9k8O0Gkji
         B+VhY7RiYtF3Rkkyx7bNGcueafnNHK+R4zfUI63fwUpiD4oSSNYPm+0L7mNflUXwWC1M
         6Il6a4udcWqmSRC8W9FtWiIH1cI/BKaXi8g1r/C6qa9+JdZOdFhB4r7njnQPL6b9/dIv
         b3+5xFxvywnAIkqYBy1PFQm+mUP0bdmyO5pXydiqtV9JfMqRfiHX1V2xmWPvIRttyVu/
         cJVExM0ELdCKBS/hE6yQsitaCJTIdrTfRx/cHNapeqpilTcc8hsFo3DblIu2RiWqP2e2
         g2ww==
X-Gm-Message-State: APjAAAWD617Pt3vvEWTRpXBghf1WQFuHrhV5bRV95f7ggCgZgwy/utMg
        GfNKhbItinJlj4FM+lPcnJNHTwwDyWLplqn6LUN47BhG
X-Google-Smtp-Source: APXvYqzDwadVivUzW3WOaJFxkgWvhQ5rY4rwOad1OWc4WBDe7sYqqfjtjJ8dQFf+Ec/q0k1XKgPN+DifzcgOexGpy4c=
X-Received: by 2002:ab0:72d0:: with SMTP id g16mr1877102uap.11.1581699074132;
 Fri, 14 Feb 2020 08:51:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMry8ZstY5f_qpS-uft1AxOOUxB=LrBAdaJnCosZ2Xj_3_vr-A@mail.gmail.com>
 <CAMry8Zt8BWWc_Kk_x9TDk+ZRL94pSFZwuqeiW7L4AcZHrXrFXg@mail.gmail.com>
In-Reply-To: <CAMry8Zt8BWWc_Kk_x9TDk+ZRL94pSFZwuqeiW7L4AcZHrXrFXg@mail.gmail.com>
From:   Kareem Straker <kareem.straker@gmail.com>
Date:   Fri, 14 Feb 2020 17:51:04 +0100
Message-ID: <CAMry8Zs8omAJGqyJWL=O5=pKBq5yhq1+tnKvS9OFEooZNsv-GQ@mail.gmail.com>
Subject: Re: Help with unmountable btrfs fs - device tree issues suspected
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I'm still trying to restore data from the drive that I have.

I'm hoping that someone might be able to help, or provide some advice
how I can proceed.

It's starting to seem hopeless for this.

Thanks for any help you can provide.

kareem.

On Wed, 29 Jan 2020 at 21:55, Kareem Straker <kareem.straker@gmail.com> wrote:
>
> Hi,
>
> My first mail to the list, so I hope I'm getting this right.
>
> I'm getting a little despirate trying to recover my Unraid system
> btrfs 2-disk cache pool, that seems to be corrupted. The 1st disk
> seems to have lost the partition information completely, the 2nd seems
> to be present but is not able to mount. Neither disk has been
> overwritten as far as I'm aware. Both disks are nvme model Samsung 970
> Evo Plus 250GB.
>
> Trying to cram info into this mail.
>
> Can anyone help? Advice?
>
> When I use any fsck or btrfs tool, I get an error: bad tree block
> 479137857536, bytenr mismatch, want=479137857536, have=0
>
> I believe the filesystem is there, but seems I need to rebuild the
> superblock or tree.
>
> Any suggestions would be appreciated.
>
> disk paths:
> /dev/nvme0n1p1
> /dev/nvme1n1p1
>
> First info + dmesg.log (attached):
> ```
> root@blaster:~# uname -a
> Linux blaster 4.19.94-Unraid #1 SMP Thu Jan 9 08:20:36 PST 2020 x86_64
> AMD Ryzen 5 3600 6-Core Processor AuthenticAMD GNU/Linux
> root@blaster:~# btrfs --version
> btrfs-progs v5.4
> root@blaster:~# btrfs fi show
> bad tree block 479137857536, bytenr mismatch, want=479137857536, have=0
> Couldn't setup device tree
> Label: none  uuid: 3d4bca36-f541-4b63-bb84-1745a9a384eb
>         Total devices 2 FS bytes used 179.16GiB
>         devid    1 size 232.89GiB used 232.01GiB path /dev/nvme1n1p1
>         *** Some devices missing
>
> root@blaster:~# btrfs fi df /mnt/cache
> ERROR: cannot access '/mnt/cache': No such file or directory
> ```
>
> Extra info:
> ```
> root@blaster:~# btrfs check --repair /dev/nvme1n1p1
> enabling repair mode
> WARNING:
>
>         Do not use --repair unless you are advised to do so by a developer
>         or an experienced user, and then only after having accepted that no
>         fsck can successfully repair all types of filesystem corruption. Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> bad tree block 479137857536, bytenr mismatch, want=479137857536, have=0
> Couldn't setup device tree
> ERROR: cannot open file system
> root@blaster:~#
> root@blaster:~#
> root@blaster:~# btrfs rescue fix-device-size /dev/nvme1n1p1
> bad tree block 479137857536, bytenr mismatch, want=479137857536, have=0
> Couldn't setup device tree
> ERROR: could not open btrfs
>
> ```
>
> ```
> root@blaster:~# btrfs rescue super-recover -v /dev/nvme1n1p1
> All Devices:
>         Device: id = 1, name = /dev/nvme1n1p1
>
> Before Recovering:
>         [All good supers]:
>                 device name = /dev/nvme1n1p1
>                 superblock bytenr = 65536
>
>                 device name = /dev/nvme1n1p1
>                 superblock bytenr = 67108864
>
>         [All bad supers]:
>
> All supers are valid, no need to recover
> ```
