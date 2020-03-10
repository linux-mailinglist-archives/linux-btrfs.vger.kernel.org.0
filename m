Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5D180C1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 00:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgCJXMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 19:12:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJXMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 19:12:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id n2so101337wmc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Mar 2020 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=shrS/fgLjoHHQJzS45aFCkS2LE116IVjhUtGM1PYTvs=;
        b=gPqsbgIsetqnHY9XyMy6GjGkaWgLC6KIwHNwDeDGV++VLlI6/3hPwFrxphDb8s6Dlb
         lWffUm1IUtApMbVMOU/KvgFIlMKknRz2mhPMqdwhxdx5mPPpnTC/DMhmPgscnEmanXKF
         x6C+Jn8hm4Q6j5NgfhWnAHd+0hQncmOFJftXGHcQ/aVCo9R46+pC+T+5DiCgOp0ht72+
         QPF+bSZjNzbCW4L6njcG7sQNKLs5YEBPXUR5XHv92mmWXrTaBLZJvE0EiZekrDJLyVSN
         frSe/8TuAlNuFYzwnppNdpdbbJnTp01lfThJMLB7xwiaLbcq8O5BpRHEQJiKZZkJXHFs
         d/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=shrS/fgLjoHHQJzS45aFCkS2LE116IVjhUtGM1PYTvs=;
        b=NAoEL7LQwXiuXSX5bBh3R7PwR0MzSnUzx+W/pxbOgGCIRXTGdXOe0yDEbXtSYR5QOX
         yKQHA3AD8PFsCD1fEr8SlUrev7VSlBJ1BlAT+PkV1BIPr4+ej0YugOGw/RFRZmzy2jPj
         OvItErks8IkdtHQCDAWTBt1rO+SVEsfXRPCye0AHY9bqWV7lRkmweXPKWaDIKU2j7qht
         gpm1gizu0E12lTJ3+YNSM446pvfyzio7qTibT34RgEKLg82/sx3lWK7L30iiufVQc8Dl
         ZOwkaf2ziBAEReD6cTkDoZkRC38Xl3MJZNRnFkaykdbtf6iWdVK9+oyGjKtEe+V8Rca6
         jWXg==
X-Gm-Message-State: ANhLgQ3zms5+VlWXq6qkE8Oj7eyo143U2YAyR3pksafNAHZFHpFcF3pd
        ADLaFXiJbIOWgZI+Gkf7mVi2nh9S6tTW1J8AZ83Nwg==
X-Google-Smtp-Source: ADFU+vu5o6EIK0OKsDJyYbNzhTytb1JV9ljZwWvyniiKwWsRj2tJbqokLkDcREHEj/RL2KU8X5QhyGN/KPSq0NnzuoY=
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr4387454wmd.11.1583881973360;
 Tue, 10 Mar 2020 16:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
 <CAJCQCtT+_ioV6XAUgPyD++9o_0+6-kUgGOF7mpfVHEyb7runsA@mail.gmail.com>
 <3234bc4b-6e93-c1f7-9ed4-a45173e22dd5@petaramesh.org> <CAJCQCtR-SUsiE5L8ba=pKHbJyQ9X3sTSBJ6vV0-X0-58nV-fxw@mail.gmail.com>
 <b99b8106-2aa9-e288-e637-d79a200da278@petaramesh.org> <CAJCQCtR6DnpkmgOnDY8GmO3T86Bk7ASmpGXTUmbdi9DVwdtMoQ@mail.gmail.com>
 <56e26938-3c85-f879-2f30-44283a6df5d1@petaramesh.org>
In-Reply-To: <56e26938-3c85-f879-2f30-44283a6df5d1@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 10 Mar 2020 17:12:37 -0600
Message-ID: <CAJCQCtTR0ADQXAC2g1kj1hFdpdPYwapOQnsqwfVnw7OzmSCq8w@mail.gmail.com>
Subject: Re: (One more) BTRFS damaged FS... Any hope ?
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 12:38 AM Sw=C3=A2mi Petaramesh <swami@petaramesh.or=
g> wrote:
>
> [root@zafu ~]# btrfs check -b /dev/sdb1 |& head -64
> [1/7] checking root items
> [2/7] checking extents
> ref mismatch on [3819245568 4096] extent item 1, found 0
> incorrect local backref count on 3819245568 root 257 owner 736217 offset
> 0 found 0 wanted 1 back 0x55f5e4931c00
> backref disk bytenr does not match extent record, bytenr=3D3819245568, re=
f
> bytenr=3D0
> backpointer mismatch on [3819245568 4096]
> owner ref check failed [3819245568 4096]
> ref mismatch on [3819421696 4096] extent item 1, found 0
> incorrect local backref count on 3819421696 root 257 owner 736218 offset
> 0 found 0 wanted 1 back 0x55f5e49327e0
> backref disk bytenr does not match extent record, bytenr=3D3819421696, re=
f
> bytenr=3D0
> backpointer mismatch on [3819421696 4096]
> owner ref check failed [3819421696 4096]
> ref mismatch on [3821916160 4096] extent item 1, found 0
> incorrect local backref count on 3821916160 root 257 owner 736219 offset
> 0 found 0 wanted 1 back 0x55f5e1ee28e0
> backref disk bytenr does not match extent record, bytenr=3D3821916160, re=
f
> bytenr=3D0
> backpointer mismatch on [3821916160 4096]
> owner ref check failed [3821916160 4096]

...

Maybe some extent tree corruption. I'm thinking that the older kernel
without an extensive tree checker won't care, and eventually things
may get worse and unworkable again. But it might work for a while?
*shrug* Maybe Qu has some idea.

It's possible there's more than one power loss event, and that the
problem is cumulative. If it were just one time, I'd expect that
zeroing the log and mounting with backuproot would completely clear
the problem, because you'd go back to a good extent tree state. So I
think there's a good chance of prior problems, and that also makes it
more difficult to fix.

What kernel version was it at the time of the problem? I see btrfs-progs 4.=
15.1

If you boot from Arch and use btrfs-progs 5.4.1 might fix this
problem, but it's about the heaviest hammer there is, and could
totally break the file system.

btrfs check --init-extent-tree

So I wouldn't use it until Qu says it's OK; or you get to a moment
with enough time to try to fix and and reformat/reinstall if the fix
breaks it totally.

As for how to avoid the problem, it may be an old bug (or more than
one) in that particular kernel era. Or it might be the storage isn't
honoring fua/fsync correctly. Hard to say. I know Btrfs has the
potential to be crash safe, because I've got a system I've forced
power off over 100 times while compiling, which is doing writes to the
Btrfs volume - and Btrfs never complains. But that doesn't mean it's
always crash safe - so even though it's a PITA to have a system break
due to a kid letting the system crash due to low battery, I think it's
a very useful and valid use case.

You could change fstab to include these two mount options:

flushoncommit,notreelog

The first probably won't slow things down, might help improve
consistency if there's a crash; where the second will likely make
certain things slower because it turns off fsync optimization and
requires full sync each time.

Next, see about asking Linux Mint community how to run newer kernels.
I know that they use Ubuntu packages, so I'd think it's possible to
just drop in install new already built Ubuntu kernels like these:
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.5.8/

But ideally it's some opt in for just newer kernels that you can
depend on being regularly updated. But I don't know much about how
this distribution handles newer kernels. By the way, I mean use new
kernels only once the file system is fixed or created new. The new
kernels are actually more fussy about existing file system problems,
due to the more sophisticated tree checker.

--=20
Chris Murphy
