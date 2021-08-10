Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A583E7D77
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhHJQ1h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhHJQ1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 12:27:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC37C0613C1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 09:27:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so18250115otl.9
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F6ebawrDq3Xt7nnx1FcpcfUXVdpbzYT2t/SOHyr8aVY=;
        b=VCoRfUPoSIMxqlB4gQFBmFEs6DoTvSh/FJ1FKQQvbH4TvJ6gaKA2llFvXhPY6HBYYo
         bEirnxq3eVbL+0cPm+eUTYONUvK6CpjHic0bDPkqOxI9B+gxOXTEb9XHoXmLEEjQsNwa
         8Oinrn+QCfjWYm8ywBC6YXD/MsaMIUWQlKOW6yzK1ubtF0ywSsCjTOLNe1tRzKoyNJOM
         MwetV4d2iurppVEJ+xFMDsf9Czk2tdp3Urf6xd3GF8nhaXtHLim31naoAmN9hxXUrLfm
         N5fXVVvnJbGt7pUgGo7DoXyasYDqbdprIAywNZXb5pcLYlHrX+TGGv0au+GfilodbieA
         TqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F6ebawrDq3Xt7nnx1FcpcfUXVdpbzYT2t/SOHyr8aVY=;
        b=R6zzyiWZfpQjlIUCbDUAG22Ml3KbAedgSXsKqgLcbyWbBrXcl4lAoLgFkH6JTvnOr6
         AxuVqvflvGL5c72ZR/x9ZpGueeQnijzF9A457oXhurNqlcj5kdD6jU3JtJ0loXV3vn7O
         fX8X01Rrz4O+DRQJ/9WSgv71eNii2XBlNPctdJPxu+1Kz/VIU65irLusoO5JyR1/sG2a
         yuF2sy3RvkdKelbRTPrFU/LUoWrdr8hLo3AMDxl/4DHC4EcPBNiywvlVIEP8LN+Hd/bD
         BIepwoNOiydRFDC7droap++9dX9BVblY+AdDZCzbVBGl87oMczd11q/Jbhso6GKZ/F/g
         4RkQ==
X-Gm-Message-State: AOAM532RySV/e6KJOiiU5Bd4EtYhA+r8mjQ/WwVOuB5OGMAC6/if1Ull
        EJqNPWRa4k9JjmEotc9SiA0fbtqXT22nH3I9o34=
X-Google-Smtp-Source: ABdhPJx4RTyyNI+KqqhfR99tJ9vdiia9TdjBHwAaCIZSfmjQXUQEd1gs3IURnGMCLIbad52kQUZ2NFuOTB0JQ9lq1Rs=
X-Received: by 2002:a05:6830:438b:: with SMTP id s11mr21998362otv.133.1628612834382;
 Tue, 10 Aug 2021 09:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
 <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it> <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
 <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it> <CAGdWbB46hPUYHj6FTi777DL=SASVyQ9wE4_5oyFtAWBos4xa9g@mail.gmail.com>
 <a8ee4ee6-ce11-45d4-f793-a98921cc8405@inwind.it>
In-Reply-To: <a8ee4ee6-ce11-45d4-f793-a98921cc8405@inwind.it>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 10 Aug 2021 12:27:03 -0400
Message-ID: <CAGdWbB5mU-3J0wsha92Ry9HYdH1G7-0H05rza10RVLcKt1QKbQ@mail.gmail.com>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     kreijack@inwind.it
Cc:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Phillip Susi <phill@thesusis.net>, kilobyte@angband.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 10, 2021 at 12:17 PM Goffredo Baroncelli <kreijack@inwind.it> w=
rote:
>
> On 8/10/21 6:03 PM, Dave T wrote:
> > On Tue, Aug 10, 2021 at 11:43 AM Goffredo Baroncelli <kreijack@inwind.i=
t> wrote:
> >>
> >> On 8/9/21 10:15 PM, Dave T wrote:
> >>> On Mon, Aug 9, 2021 at 3:29 PM Goffredo Baroncelli <kreijack@libero.i=
t> wrote:
> >>>>
> >> [...]
> >>
> >>>
> >>> Also, in recent days I stopped mounting and umounting /mnt/btrtop/roo=
t
> >>> and just left it mounted all the time. However, when checking today, =
I
> >>> still found a nested mount:
> >>>
> >>> =E2=94=9C=E2=94=80/srv/nfs/var/cache/pacman
> >>> =E2=94=82
> >>> =E2=94=82 =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> >>>
> >>>
> >>
> >> Ok, so it seems that these mounts are triggered not by the mount of /m=
nt/btrtop/root (see below). What is the output of
> >>
> >> $ systemctl --reverse list-dependencies -- srv-nfs-var-cache-pacman.mo=
unt
> >>
> >
> > srv-nfs-var-cache-pacman.mount
> > =E2=97=8F =E2=94=9C=E2=94=80nfs-server.service
> > =E2=97=8F =E2=94=94=E2=94=80local-fs.target
> > =E2=97=8F   =E2=94=94=E2=94=80sysinit.target
> > =E2=97=8B     =E2=94=9C=E2=94=80btrbk-daily.service
> > =E2=97=8F     =E2=94=9C=E2=94=80btrbk-daily.timer
> > =E2=97=8B     =E2=94=9C=E2=94=80btrbk.service
> > =E2=97=8F     =E2=94=9C=E2=94=80btrbk.timer
> > =E2=97=8F     =E2=94=9C=E2=94=80dbus.service
> > =E2=97=8F     =E2=94=9C=E2=94=80dbus.socket
> > =E2=97=8F     =E2=94=9C=E2=94=80dhcpcd.service
> > =E2=97=8F     =E2=94=9C=E2=94=80getty@tty1.service
> > =E2=97=8F     =E2=94=9C=E2=94=80gssproxy.service
> > =E2=97=8B     =E2=94=9C=E2=94=80keymap_ds.service
> > =E2=97=8B     =E2=94=9C=E2=94=80logrotate.service
> > =E2=97=8F     =E2=94=9C=E2=94=80logrotate.timer
> > =E2=97=8B     =E2=94=9C=E2=94=80man-db.service
> > =E2=97=8F     =E2=94=9C=E2=94=80man-db.timer
> > =E2=97=8B     =E2=94=9C=E2=94=80nfs-utils.service
> > =E2=97=8B     =E2=94=9C=E2=94=80users_permissions.service
> > =E2=97=8F     =E2=94=9C=E2=94=80users_permissions.timer
> > =E2=97=8B     =E2=94=9C=E2=94=80shadow.service
> > =E2=97=8F     =E2=94=9C=E2=94=80shadow.timer
> > =E2=97=8B     =E2=94=9C=E2=94=80snapper-cleanup.service
> > =E2=97=8F     =E2=94=9C=E2=94=80snapper-cleanup.timer
> > =E2=97=8F     =E2=94=9C=E2=94=80sshd.service
> > =E2=97=8B     =E2=94=9C=E2=94=80sshdgenkeys.service
> > =E2=97=8B     =E2=94=9C=E2=94=80systemd-ask-password-wall.service
> > =E2=97=8F     =E2=94=9C=E2=94=80systemd-logind.service
> > =E2=97=8F     =E2=94=9C=E2=94=80systemd-tmpfiles-clean.timer
> > =E2=97=8F     =E2=94=9C=E2=94=80systemd-user-sessions.service
> > =E2=97=8F     =E2=94=9C=E2=94=80user-runtime-dir@1000.service
> > =E2=97=8F     =E2=94=9C=E2=94=80user@1000.service
> > =E2=97=8F     =E2=94=9C=E2=94=80basic.target
> > =E2=97=8B     =E2=94=82 =E2=94=9C=E2=94=80initrd.target
> > =E2=97=8F     =E2=94=82 =E2=94=94=E2=94=80multi-user.target
> > =E2=97=8F     =E2=94=82   =E2=94=94=E2=94=80graphical.target
> > =E2=97=8B     =E2=94=94=E2=94=80rescue.target
> >
> >
> > This looks interesting -- some of those dependencies are very
> > unexpected to me. I look forward to your take on what this output
> > indicates. I don't understand why there is a connection between
> > srv-nfs-var-cache-pacman.mount and btrbk.service, for example. (I
> > included btrbk.service with source listings you requested below.)
>
> The btrbk.* units are triggered by sysinit.target. And sysinit requires l=
ocal-fs.target, which in turn requires that all fstab mounts are mounted (t=
hen the link to srv-nfs-var-cache-pacman.mount).
> There no is any direct connection between btrbk and srv-nfs-var-cache-pac=
man.mount.
>
> What is more interesting is the dependencies between srv-nfs-var-cache-pa=
cman.mount and nfs-server.service. I suspect (but I don't have any proof) t=
hat systemd is confused by the tuple {btrfs subvolume, bind mount, nfs depe=
ndecies}.
>
> What happens if you restart the nfs-server ?

As part of this issue, nfs clients have been experiencing slowness and
sometimes hangs. I have restarted the nfs server service a few times
while this issue was happening and it seems to temporarily resolve the
client issues, but I'm not 100% sure because a specific incident will
resolve eventually on its own without any intervention by me. But
future incidences of slowness or temporary hangs are continuing and I
do think this is all related.

Restarting the nfs server service does not make the nested mounts we
are discussing go away. I have to unwind them with multiple calls to
umount -- although the number of calls is less than the number of
nested mounts, which I find confusing. Typically just 2-3 calls to
umount will unmount a nesting 5-6 deep.

Clients connect to a number of different nfs shares from this server,
yet none of the others wind up with nested mounts like
srv-nfs-var-cache-pacman.mount . All mounts are configured the same
way, using the same bind mount parameters in fstab.

> >
> >>
> >> [...]
> >>>
> >>> As mentioned, I have (temporarily) stopped unmounting these volumes
> >>> and I just leave them mounted all the time. The logs now look like
> >>> this:
> >>>
> >>> Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volumes.=
..
> >>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (1 of
> >>> 3) was already mounted. Nothing to do.
> >>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (2 of
> >>> 3) was already mounted. Nothing to do.
> >>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (3 of
> >>> 3) was already mounted. Nothing to do.
> >>
> >> This told another story. It seems that "btrbk" itself already try to m=
ount the btrfs subvolume. I understood that it was the systemd unit to do t=
hat. Could you share the content of btrbk_run.sh ?
> >>
> >
> > # systemctl cat btrbk.service
> > # /usr/lib/systemd/system/btrbk.service
> > [Unit]
> > Description=3Dbtrbk backup
> > Documentation=3Dman:btrbk(1)
> >
> > [Service]
> > Type=3Doneshot
> > ExecStart=3D/usr/bin/btrbk run
> >
> > # /etc/systemd/system/btrbk.service.d/override.conf
> > [Service]
> > ExecStart=3D
> > ExecStart=3D/usr/local/bin/btrbk_run.sh
> >
> >
> > # cat /usr/local/bin/btrbk_run.sh
> > #!/bin/bash
> >
> > /usr/local/bin/btrbk_mount
> >
> > /usr/bin/btrbk --config /etc/btrbk/btrbk.conf run
> >
> > # 2021-08-05 My first troubleshooting step is to disable unmounting
> > these shares.
> > # /usr/local/bin/btrbk-umount
> >
> >
> > # cat /usr/local/bin/btrbk_mount
> > #!/bin/bash
> >
> > btrbk_mount() {
> >
> > echo "mounting btrbk btrtop volumes..."
> >
> > findmnt /mnt/btrtop/root
> > if [[ $? -ne 0 ]]; then \
> >    mount /mnt/btrtop/root
> >    if [[ $? -ne 0 ]]; then \
> >      echo "ERROR: failed to mount [/mnt/btrtop/root] (1 of 3)"
> >    else
> >      echo "OK: mounted [/mnt/btrtop/root] (1 of 3)"
> >    fi
> > else
> >    echo "INFO: [/mnt/btrtop/root] (1 of 3) was already mounted. Nothing=
 to do."
> > fi
> > findmnt /mnt/btrtop/home
> > if [[ $? -ne 0 ]]; then \
> >    mount /mnt/btrtop/home
> >    if [[ $? -ne 0 ]]; then \
> >      echo "ERROR: failed to mount [/mnt/btrtop/home] (2 of 3)"
> >    else
> >      echo "OK: mounted [/mnt/btrtop/home] (2 of 3)"
> >    fi
> > else
> >    echo "INFO: [/mnt/btrtop/home] (2 of 3) was already mounted. Nothing=
 to do."
> > fi
> > findmnt /mnt/btrtop/user
> > if [[ $? -ne 0 ]]; then \
> >    mount /mnt/btrtop/user
> >    if [[ $? -ne 0 ]]; then \
> >      echo "ERROR: failed to mount [/mnt/btrtop/user] (3 of 3)"
> >    else
> >      echo "OK: mounted mount [/mnt/btrtop/user] (3 of 3)"
> >    fi
> > else
> >    echo "INFO: [/mnt/btrtop/user] (3 of 3) was already mounted. Nothing=
 to do."
> > fi
> >
> > echo "Finished mounting btrbk btrtop volumes."
> >
> > }
> >
> > btrbk_mount
> >
> > # end of file /usr/local/bin/btrbk_mount
> >
> >
> >>
> >>> Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk btrtop=
 volumes.
> >>> Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volumes.=
..
> >>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (1 of
> >>> 3) was already mounted. Nothing to do.
> >>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (2 of
> >>> 3) was already mounted. Nothing to do.
> >>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (3 of
> >>> 3) was already mounted. Nothing to do.
> >>> Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk btrtop=
 volumes.
> >>>
> >>>>
> >>>>>
> >>>>> The path /var/cache/pacman is not a subvolume, but it resides on bt=
rfs
> >>>>> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
> >>>>> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. Th=
is
> >>>>> additional mount operation seems to be causing these nested mounts =
of
> >>>>> my bind mount for  /srv/nfs/var/cache/pacman .
> >>>>>
> >>>>> P.S. I cannot test without using systemd. (I'm not even sure I
> >>>>> remember how to use a non-systemd distro anymore!)
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> >>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> >>
> >>
> >> --
> >> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> >> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
