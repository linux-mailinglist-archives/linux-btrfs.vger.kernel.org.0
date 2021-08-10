Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C764F3E7D17
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 18:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhHJQD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 12:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJQD6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 12:03:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12698C0613C1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 09:03:36 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so22597086oti.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=et+Q+EICSzKOj7ICh8ReV9Ar/XLd8FSv1JUcaI4Y3pI=;
        b=kOApaazRmidjeDh18zBfVqf7+6upvb3Hd8afwnx6MULF71O9Vq4dMBS/lWTt9Ofum6
         vX9KxQCQBJm24B0xcZVuhNce1ErAHvDApWJg4I30h/xxpZW1z5hCkjfFx02AMKpLmpYL
         Rnw4jQPjq//xDhcuYHGENFrBHfKjtBdutFPEOFK2pC5H8sW3yJ+/8EfX4GRZKPbdLFsw
         4unqMllHkPXn/RiQ2H30PGOLpPscdObtf7Tvq5F26FGIy+axlUtpqr84ffBNqW6FQmA/
         ecLFtoQzupxAqUKcg7ji6Z8dOhHTtwrjfZFJDbbOuMAnFUa11w/0ybGTMPRTFfZJx7Q2
         id1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=et+Q+EICSzKOj7ICh8ReV9Ar/XLd8FSv1JUcaI4Y3pI=;
        b=ZYHqH9ttPa5Mz19uY9OqbM6bOoOYYFwSCujBgPn0yneOxrk4uUpWvKwL9st4vrsI5T
         BgNcVj3nA+2Pm6CFjdSXsxFWAFrpvHQ+wquYZQFzlukIURUxr7c2NJbvq/NuhHWyeI5+
         0m5mMVna+7905jeKzUwjJSJgEdLxUn1UFexcYKql5oVJcxal64b23DVnr08QFa0+AhI4
         gvndE+344VZ91f5tHKHB+PVjj5d8Ge29hzEONkP+wp4aUh5SaYLNm0TEbLeShXXh7oRM
         CYE92bm1s4qcozeADs3qM0X3Eb7zLekSuTazzK58RpO5k1gmYWObkAfxZPYmzVh51sM6
         45jg==
X-Gm-Message-State: AOAM5304HRtRfU1kWkD6ZLG+h3AvzzwNv8mIn0EgETE9wHtBR/ma93IG
        My6J0olbyTTI4U30oEKvIDyL1Z1GWt0d0Iyi4eo=
X-Google-Smtp-Source: ABdhPJyz/+srX4v33nYhGf3ZwS4dm9Tw3WGMvTdaFCZDGFFyXVglCba4jHadpilwLm7y1Ht079SV5IpbRd6+tnQRtvU=
X-Received: by 2002:a9d:6359:: with SMTP id y25mr6469364otk.274.1628611415357;
 Tue, 10 Aug 2021 09:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
 <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it> <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
 <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it>
In-Reply-To: <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 10 Aug 2021 12:03:24 -0400
Message-ID: <CAGdWbB46hPUYHj6FTi777DL=SASVyQ9wE4_5oyFtAWBos4xa9g@mail.gmail.com>
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

On Tue, Aug 10, 2021 at 11:43 AM Goffredo Baroncelli <kreijack@inwind.it> w=
rote:
>
> On 8/9/21 10:15 PM, Dave T wrote:
> > On Mon, Aug 9, 2021 at 3:29 PM Goffredo Baroncelli <kreijack@libero.it>=
 wrote:
> >>
> [...]
>
> >
> > Also, in recent days I stopped mounting and umounting /mnt/btrtop/root
> > and just left it mounted all the time. However, when checking today, I
> > still found a nested mount:
> >
> > =E2=94=9C=E2=94=80/srv/nfs/var/cache/pacman
> > =E2=94=82
> > =E2=94=82 =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
> >
> >
>
> Ok, so it seems that these mounts are triggered not by the mount of /mnt/=
btrtop/root (see below). What is the output of
>
> $ systemctl --reverse list-dependencies -- srv-nfs-var-cache-pacman.mount
>

srv-nfs-var-cache-pacman.mount
=E2=97=8F =E2=94=9C=E2=94=80nfs-server.service
=E2=97=8F =E2=94=94=E2=94=80local-fs.target
=E2=97=8F   =E2=94=94=E2=94=80sysinit.target
=E2=97=8B     =E2=94=9C=E2=94=80btrbk-daily.service
=E2=97=8F     =E2=94=9C=E2=94=80btrbk-daily.timer
=E2=97=8B     =E2=94=9C=E2=94=80btrbk.service
=E2=97=8F     =E2=94=9C=E2=94=80btrbk.timer
=E2=97=8F     =E2=94=9C=E2=94=80dbus.service
=E2=97=8F     =E2=94=9C=E2=94=80dbus.socket
=E2=97=8F     =E2=94=9C=E2=94=80dhcpcd.service
=E2=97=8F     =E2=94=9C=E2=94=80getty@tty1.service
=E2=97=8F     =E2=94=9C=E2=94=80gssproxy.service
=E2=97=8B     =E2=94=9C=E2=94=80keymap_ds.service
=E2=97=8B     =E2=94=9C=E2=94=80logrotate.service
=E2=97=8F     =E2=94=9C=E2=94=80logrotate.timer
=E2=97=8B     =E2=94=9C=E2=94=80man-db.service
=E2=97=8F     =E2=94=9C=E2=94=80man-db.timer
=E2=97=8B     =E2=94=9C=E2=94=80nfs-utils.service
=E2=97=8B     =E2=94=9C=E2=94=80users_permissions.service
=E2=97=8F     =E2=94=9C=E2=94=80users_permissions.timer
=E2=97=8B     =E2=94=9C=E2=94=80shadow.service
=E2=97=8F     =E2=94=9C=E2=94=80shadow.timer
=E2=97=8B     =E2=94=9C=E2=94=80snapper-cleanup.service
=E2=97=8F     =E2=94=9C=E2=94=80snapper-cleanup.timer
=E2=97=8F     =E2=94=9C=E2=94=80sshd.service
=E2=97=8B     =E2=94=9C=E2=94=80sshdgenkeys.service
=E2=97=8B     =E2=94=9C=E2=94=80systemd-ask-password-wall.service
=E2=97=8F     =E2=94=9C=E2=94=80systemd-logind.service
=E2=97=8F     =E2=94=9C=E2=94=80systemd-tmpfiles-clean.timer
=E2=97=8F     =E2=94=9C=E2=94=80systemd-user-sessions.service
=E2=97=8F     =E2=94=9C=E2=94=80user-runtime-dir@1000.service
=E2=97=8F     =E2=94=9C=E2=94=80user@1000.service
=E2=97=8F     =E2=94=9C=E2=94=80basic.target
=E2=97=8B     =E2=94=82 =E2=94=9C=E2=94=80initrd.target
=E2=97=8F     =E2=94=82 =E2=94=94=E2=94=80multi-user.target
=E2=97=8F     =E2=94=82   =E2=94=94=E2=94=80graphical.target
=E2=97=8B     =E2=94=94=E2=94=80rescue.target


This looks interesting -- some of those dependencies are very
unexpected to me. I look forward to your take on what this output
indicates. I don't understand why there is a connection between
srv-nfs-var-cache-pacman.mount and btrbk.service, for example. (I
included btrbk.service with source listings you requested below.)

>
> [...]
> >
> > As mentioned, I have (temporarily) stopped unmounting these volumes
> > and I just leave them mounted all the time. The logs now look like
> > this:
> >
> > Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volumes...
> > Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (1 of
> > 3) was already mounted. Nothing to do.
> > Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (2 of
> > 3) was already mounted. Nothing to do.
> > Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (3 of
> > 3) was already mounted. Nothing to do.
>
> This told another story. It seems that "btrbk" itself already try to moun=
t the btrfs subvolume. I understood that it was the systemd unit to do that=
. Could you share the content of btrbk_run.sh ?
>

# systemctl cat btrbk.service
# /usr/lib/systemd/system/btrbk.service
[Unit]
Description=3Dbtrbk backup
Documentation=3Dman:btrbk(1)

[Service]
Type=3Doneshot
ExecStart=3D/usr/bin/btrbk run

# /etc/systemd/system/btrbk.service.d/override.conf
[Service]
ExecStart=3D
ExecStart=3D/usr/local/bin/btrbk_run.sh


# cat /usr/local/bin/btrbk_run.sh
#!/bin/bash

/usr/local/bin/btrbk_mount

/usr/bin/btrbk --config /etc/btrbk/btrbk.conf run

# 2021-08-05 My first troubleshooting step is to disable unmounting
these shares.
# /usr/local/bin/btrbk-umount


# cat /usr/local/bin/btrbk_mount
#!/bin/bash

btrbk_mount() {

echo "mounting btrbk btrtop volumes..."

findmnt /mnt/btrtop/root
if [[ $? -ne 0 ]]; then \
  mount /mnt/btrtop/root
  if [[ $? -ne 0 ]]; then \
    echo "ERROR: failed to mount [/mnt/btrtop/root] (1 of 3)"
  else
    echo "OK: mounted [/mnt/btrtop/root] (1 of 3)"
  fi
else
  echo "INFO: [/mnt/btrtop/root] (1 of 3) was already mounted. Nothing to d=
o."
fi
findmnt /mnt/btrtop/home
if [[ $? -ne 0 ]]; then \
  mount /mnt/btrtop/home
  if [[ $? -ne 0 ]]; then \
    echo "ERROR: failed to mount [/mnt/btrtop/home] (2 of 3)"
  else
    echo "OK: mounted [/mnt/btrtop/home] (2 of 3)"
  fi
else
  echo "INFO: [/mnt/btrtop/home] (2 of 3) was already mounted. Nothing to d=
o."
fi
findmnt /mnt/btrtop/user
if [[ $? -ne 0 ]]; then \
  mount /mnt/btrtop/user
  if [[ $? -ne 0 ]]; then \
    echo "ERROR: failed to mount [/mnt/btrtop/user] (3 of 3)"
  else
    echo "OK: mounted mount [/mnt/btrtop/user] (3 of 3)"
  fi
else
  echo "INFO: [/mnt/btrtop/user] (3 of 3) was already mounted. Nothing to d=
o."
fi

echo "Finished mounting btrbk btrtop volumes."

}

btrbk_mount

# end of file /usr/local/bin/btrbk_mount


>
> > Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk btrtop v=
olumes.
> > Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volumes...
> > Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (1 of
> > 3) was already mounted. Nothing to do.
> > Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (2 of
> > 3) was already mounted. Nothing to do.
> > Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (3 of
> > 3) was already mounted. Nothing to do.
> > Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk btrtop v=
olumes.
> >
> >>
> >>>
> >>> The path /var/cache/pacman is not a subvolume, but it resides on btrf=
s
> >>> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
> >>> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
> >>> additional mount operation seems to be causing these nested mounts of
> >>> my bind mount for  /srv/nfs/var/cache/pacman .
> >>>
> >>> P.S. I cannot test without using systemd. (I'm not even sure I
> >>> remember how to use a non-systemd distro anymore!)
> >>>
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
