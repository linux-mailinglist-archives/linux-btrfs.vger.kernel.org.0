Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507673E3C90
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Aug 2021 21:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhHHTsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Aug 2021 15:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhHHTsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Aug 2021 15:48:47 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59164C061760
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Aug 2021 12:48:27 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so3777828oos.10
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Aug 2021 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XHvKW6iVDAjkUWi0qN4NsfNYUj1BAEOIbI+7ucxp3yc=;
        b=ifj0oY12nFJGBfrVy6uR3qpC58QY+z4OUcw6VqLcAEFUHshhrOYXXu+VM8bpdzfJST
         +sOZR6XXa4NWgeTC1Zs5rReTXaZV3ZHKD+NxW01QsSoH5KpN71xbU5suAhlyba65X0O5
         nBvIXmQLQELN6j+hX8gPHvCWXLtJF5YtV1pvJO2hHGJC5UjX9bh46ysTI+ZbD3A6yWZw
         AzwcbAtl2QNTojphMP1WsjeN1Lzq2JIPvcf0Q75o7qI+ApDQ+bNsiZP7K1Wv/YuGweNn
         7CAjJud+Nygj1q9FkBxMZRNeWwo9IVZjlkO7wnCKk2LRJSjx6aBhrd0QVO13dUycRzH9
         iskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XHvKW6iVDAjkUWi0qN4NsfNYUj1BAEOIbI+7ucxp3yc=;
        b=BY1SKYBrskqQBZD7sht/8KT3ccc4u1oeqnPQ026S8VXVBwfyJzaY5To7xk9pI/CLLc
         CxaD2SNII+AzkdvANgKVujgJQBZYXg8E9vd7oBl7IpcrMQiz6p4Wsapq3Ipb0HaX4z1I
         3VklhNFe1bTkIxvvnBkRR8OcIhL6RDGSKVn2pINIsnxTsB7tZHo6t8P0qoEPxrnKuxMO
         W1ACOkv7EPaj3CS+G+apkvIGCLhLCy8v3tUZzkXufWRfMkrUJgUHZYbo22SyYSwW7OnS
         XQuFNd3RiQhSNLn61+mCJ8jby0LK0Nal5GC4sKzDu1OguwR9Zfru0NHzjZHa40dsuidQ
         1oLQ==
X-Gm-Message-State: AOAM530WH+fntALWQI+UAchQgDqX9UfgYMCXWTOOCOKgXLve8os3UbYU
        6ezXUSBV6rFyXheeHyrt4v+GLY2hWP+fHBDwfv/sfisAFWU=
X-Google-Smtp-Source: ABdhPJzpBEFUGrkSeWHB1aflYxRE+dgRPJXC8YFzqBsC/JoqfuXZ5rFxQbQ07kEFd60opwjSQiw/4Dk1Ecig/xP26O0=
X-Received: by 2002:a4a:e750:: with SMTP id n16mr11042811oov.13.1628452106574;
 Sun, 08 Aug 2021 12:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
In-Reply-To: <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Sun, 8 Aug 2021 15:48:16 -0400
Message-ID: <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Phillip Susi <phill@thesusis.net>, kilobyte@angband.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 8, 2021 at 8:10 AM <devel@roosoft.ltd.uk> wrote:
>
> On 05/08/2021 17:46, Dave T wrote:
> > I recently switched from snapper and snapsync to btrbk, which I
> > generally prefer. However, I am running into one issue.
> >
> > Background - from https://digint.ch/btrbk/doc/faq.html
> > Btrbk is designed to operate on the subvolumes within a root
> > subvolume. The author recommend booting linux from a btrfs subvolume,
> > and using the btrfs root only as a container for subvolumes (i.e. NOT
> > booting from "subvolid=3D5").
> >
> > That's exactly what I'm doing.
> >
> > The key point is that btrbk requires mounting the toplevel subvolume
> > to perform its tasks.
> >
> > I'm using btrbk via a systemd timer. I have a daily and hourly timer
> > set up. Each timer starts by mounting the btrfs root, performing the
> > btrbk task, and unmounting the btrfs root.
> >
> > I create hourly snapshots and on a daily basis I use btrbk to transfer
> > those to two different USB HDD's as well as to a remote server via
> > SSH.
> >
> > Here's the problem. I now end up (after some time) with a nested list
> > of mounts for one particular mount point as shown below. I don't
> > understand why or how this is happening. It does have side effects
> > (disk access can hang). The apparent "cure" is to restart the nfs
> > server service, but I'm still trying to understand the issue fully.
> >
> > # cat /etc/fstab
> > UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /     btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvol=3D/@btrtop/snap=
shot
> > 0 0 #mounts my root filesystem
> > UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /mnt/btrtop/root  btrfs
> > noauto,nofail,rw,noatime,nodiratime,compress=3Dlzo,space_cache    0 0
> > #mounts the top btrfs volume for btrbk access to all snapshots
> > /var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0
> >
> > # findmnt -t btrfs
> > TARGET                                      SOURCE
> >                                        FSTYPE OPTIONS
> > /
> > /dev/mapper/xyz[/@btrtop/snapshot]                     btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=9C=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82 =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82   =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82     =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82       =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82         =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82           =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82             =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=9C=E2=94=80/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82 =E2=94=94=E2=94=80/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82   =E2=94=94=E2=94=80/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82     =E2=94=94=E2=94=80/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82       =E2=94=94=E2=94=80/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82         =E2=94=94=E2=94=80/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
> > =E2=94=82           =E2=94=94=E2=94=80/var/cache/pacman
> > /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=
=3D/@btrtop/snapshot
>
> Try mounting the subvolume with it's subvolume ID. System only generates
> unit files from the fstab it does not follow them , so if you are vague
> in your fstab the systemd unit files will also be vague.

Thank you for the tip. I appreciate your interest in my issue.
However, I don't fully understand what to change.
Here are the relevant lines from my fstab. I added line numbers
because the lines will get wrapped in email.  I don't see what part of
this is vague:

1. # cat /etc/fstab
2. UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /     btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvol=3D/@btrtop/snapshot
0 0
3. UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /mnt/btrtop/root  btrfs
noauto,nofail,rw,noatime,nodiratime,compress=3Dlzo,space_cache    0 0
4. /var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0

The path /var/cache/pacman is not a subvolume, but it resides on btrfs
subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
"/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
additional mount operation seems to be causing these nested mounts of
my bind mount for  /srv/nfs/var/cache/pacman .

P.S. I cannot test without using systemd. (I'm not even sure I
remember how to use a non-systemd distro anymore!)
