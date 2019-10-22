Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042BDE014F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfJVJ7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:59:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45929 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbfJVJ7A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:59:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so12325705wrs.12
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EGC6zM4+ZaOmgBq+ctMVPIcGkDMOPWa7mq6PGgeYYkA=;
        b=cNnE4FHwP3H7o2xbeu2cVvyXCztsxBG9rWVFZFEm0Hm6DPNxP0ufoIErcjiG1pBtLq
         AEqkbhoMS+M5N0N7bNfsw0RP7pS3MN69235q/9sauw0/i7R6GX9kBVftr70oGOaEsuDH
         kj0jFX/iSsHqzlSbJN4Y/zum77LbK1n2NgXDZt13tCmZ5IrG3RsX8clZwK1KA2JnvBZo
         eQii2Zi2dWb7bEqXcVOsHAY2xhxJeuUM1PHaj1WLyazbliMXCSAmA457F0SXSr8oWXPI
         Y8sIiM7F8y8Bo84Auc50eY1HHuOrHQiUJmy5GDAXL8TsGygeEpCtsHrH9Pd0P4YslzHm
         p0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EGC6zM4+ZaOmgBq+ctMVPIcGkDMOPWa7mq6PGgeYYkA=;
        b=UsJ50vV6qPPrifN7uQi6lrIMvddG6tJkl+8R8b1XCFnE+NxUJXgoc2GkX6fLO4t2hN
         oRdDq5ujOvFNqNj7NcCWwT22oCCRWbS9W/2hiZHWOdoHNf/p3NFIa/S2zxsyN5Tx0GFl
         ErhVCdyu6D5oDlFPme8EEcfbaFopVwmfjGhNAsecBoapaJSjviG3tP0xE5x2vJSkolWv
         DEsoVoluM9wWjmqNvAX4nJQyhGF/n3wz3R3EuEad+uP663hm7wfUpeodEIVtNUGCfjpD
         25NB8yuz2q7G+uzZnDGQ4kGTroOKQ/n2AfJpRFDBgp3g2SB6MTes8r1u4N+KyEr1eFu7
         rGKw==
X-Gm-Message-State: APjAAAWS3QRRbGW2jeAU3q4bQrdeB7+ZzjX1YjUt3VjFX9NnTodszSbA
        ybnjeyxGf2vcRD1PggoRF556VbV2lXk8dokVebv1lZceeabdnw==
X-Google-Smtp-Source: APXvYqzTztN7GZ8zoXBPDLl9ZZ3yoXpw49AJjnAO+T87Pa6s6Qkb6J/L+Fxc6mOJBBEtrLC6kcs9LlWwqdUxnGANWVo=
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr2719407wrq.101.1571738336793;
 Tue, 22 Oct 2019 02:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
 <0a5bc5dd-6077-a0de-8250-e7c1d0d37b51@suse.com>
In-Reply-To: <0a5bc5dd-6077-a0de-8250-e7c1d0d37b51@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 22 Oct 2019 11:58:37 +0200
Message-ID: <CAJCQCtQYjzhc+F-SpNUo9MZvkXKNczAUK6s2kKHZgnpnSc90kg@mail.gmail.com>
Subject: Re: feature request, explicit mount and unmount kernel messages
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(resending to list, I don't know why but I messed up the reply
directly to Nikolay)

On Tue, Oct 22, 2019 at 11:16 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> On 22.10.19 =3DD0=3DB3. 12:00 =3DD1=3D87., Chris Murphy wrote:
> > Hi,
> >
> > So XFS has these
> >
> > [49621.415203] XFS (loop0): Mounting V5 Filesystem
> > [49621.444458] XFS (loop0): Ending clean mount
> > ...
> > [49621.444458] XFS (loop0): Ending clean mount
> > [49641.459463] XFS (loop0): Unmounting Filesystem
> >
> > It seems to me linguistically those last two should be reversed, but wh=
=3D
atever.
> >
> > The Btrfs mount equivalent messages are:
> > [49896.176646] BTRFS: device fsid f7972e8c-b58a-4b95-9f03-1a08bbcb62a7
> > devid 1 transid 5 /dev/loop0
> > [49901.739591] BTRFS info (device loop0): disk space caching is enabled
> > [49901.739595] BTRFS info (device loop0): has skinny extents
> > [49901.767447] BTRFS info (device loop0): enabling ssd optimizations
> > [49901.767851] BTRFS info (device loop0): checking UUID tree
> >
> > So is it true that for sure there is nothing happening after the UUID
> > tree is checked, that the file system is definitely mounted at this
> > point? And always it's the UUID tree being checked that's the last
> > thing that happens? Or is it actually already mounted just prior to
> > disk space caching enabled message, and the subsequent messages are
> > not at all related to the mount process? See? I can't tell.
> >
> > For umount, zero messages at all.
>
> You are doing it wrong.

I'm doing what wrong?

> Those messages are sent from the given subsys to
> the console and printed whenever. You can never rely on the fact that
> those messages won't race with some code.

That possibility is implicit in all of the questions I asked.


> For example the checking UUID tree happens _before_
> btrfs_check_uuid_tree is called and there is no guarantee when it's
> finished.

Are these messages useful for developers? I don't see them as being
useful for users. They're kinda superfluous for them.


> > The feature request is something like what XFS does, so that we know
> > exactly when the file system is mounted and unmounted as far as Btrfs
> > code is concerned.
> >
> > I don't know that it needs the start and end of the mount and
> > unmounted (i.e. two messages). I'm mainly interested in having a
> > notification for "mount completed successfully" and "unmount completed
> > successfully". i.e. the end of each process, not the start of each.
>
> mount is a blocking syscall, same goes for umount your notifications are
> when the respective syscalls / system utilities return.

Right. Here is the example bug from 2015, that I just became aware of
as the impetus for posting the request; but I've wanted this explicit
notification for a while.

https://bugzilla.redhat.com/show_bug.cgi?id=3D3D1206874#c7

In that example, there's one Btrfs info message at
[    2.727784] localhost.localdomain kernel: BTRFS info (device sda3):
disk space caching is enabled

And yet systemd times out on the mount unit. If it's true that only
mount blocking systemd could be the cause, then this is a Btrfs, VFS,
or mount related bug (however old it is by now and doesn't really
matter other than conceptually). But there isn't enough granularity in
the kernel messages to understand why the mount is taking so long. If
there were a Btrfs mount succeeded message, we'd know whether the
Btrfs portion of the mount process successfully completed or not, and
perhaps have a better idea where the hang is happening.

On Tue, Oct 22, 2019 at 11:16 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 22.10.19 =D0=B3. 12:00 =D1=87., Chris Murphy wrote:
> > Hi,
> >
> > So XFS has these
> >
> > [49621.415203] XFS (loop0): Mounting V5 Filesystem
> > [49621.444458] XFS (loop0): Ending clean mount
> > ...
> > [49621.444458] XFS (loop0): Ending clean mount
> > [49641.459463] XFS (loop0): Unmounting Filesystem
> >
> > It seems to me linguistically those last two should be reversed, but wh=
atever.
> >
> > The Btrfs mount equivalent messages are:
> > [49896.176646] BTRFS: device fsid f7972e8c-b58a-4b95-9f03-1a08bbcb62a7
> > devid 1 transid 5 /dev/loop0
> > [49901.739591] BTRFS info (device loop0): disk space caching is enabled
> > [49901.739595] BTRFS info (device loop0): has skinny extents
> > [49901.767447] BTRFS info (device loop0): enabling ssd optimizations
> > [49901.767851] BTRFS info (device loop0): checking UUID tree
> >
> > So is it true that for sure there is nothing happening after the UUID
> > tree is checked, that the file system is definitely mounted at this
> > point? And always it's the UUID tree being checked that's the last
> > thing that happens? Or is it actually already mounted just prior to
> > disk space caching enabled message, and the subsequent messages are
> > not at all related to the mount process? See? I can't tell.
> >
> > For umount, zero messages at all.
>
> You are doing it wrong. Those messages are sent from the given subsys to
> the console and printed whenever. You can never rely on the fact that
> those messages won't race with some code.
>
> For example the checking UUID tree happens _before_
> btrfs_check_uuid_tree is called and there is no guarantee when it's
> finished.
>
> >
> > The feature request is something like what XFS does, so that we know
> > exactly when the file system is mounted and unmounted as far as Btrfs
> > code is concerned.
> >
> > I don't know that it needs the start and end of the mount and
> > unmounted (i.e. two messages). I'm mainly interested in having a
> > notification for "mount completed successfully" and "unmount completed
> > successfully". i.e. the end of each process, not the start of each.
>
> mount is a blocking syscall, same goes for umount your notifications are
> when the respective syscalls / system utilities return.
>
> >
> > In particular the unmount notice is somewhat important because as far
> > as I know there's no Btrfs dirty flag from which to infer whether it
> > was really unmounted cleanly. But I'm also not sure what the insertion
> > point for these messages would be. Looking at the mount code in
> > particular, it's a little complicated. And maybe with some of the
> > sanity checking and debug options it could get more complicated, and
> > wouldn't want to conflict with that - or any multiple device use case
> > either.
> >
> >



--=20
Chris Murphy
