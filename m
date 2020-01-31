Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5019C14E7CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 05:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgAaEMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 23:12:55 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35594 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAaEMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 23:12:54 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so5074475ild.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 20:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KtNSexvxePgzGp4wGnM9OWv/klalzAU60BWvLbpu184=;
        b=b0Cwi2TRyXdzTUVwV2xu+rsIuO5y+bWZVjzNw336iIIAsLdgr8xZg+4rM+kjU7BK4q
         arEB0rTDplwD4upryMwmAa+Z8ZFOufhcdG8zMOZgED/aCdhyKSD+6n+ji/VY88GI67wk
         Z5c81dOW4FHGycdtSQWc6NwggrJQ2683V7/27k2auvmmUSi+VwPEnq13Kv7wnt0O/Cuq
         WDFUIGtlcVPZ352cJWyhG30IJkl0mM/215cusrgSmr9Me7RZsdi5GJ+sJ7znuKOXh8R/
         juqBgzXpYbZF8vmwChsUnxj9CShB9iFPQCjiZpAla+hOqpqnsXFiHdQF3263bZ7VtFf5
         U1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KtNSexvxePgzGp4wGnM9OWv/klalzAU60BWvLbpu184=;
        b=BEGcg333HmvoH7jHMtc9m6fl0n7dNhGpQfcEJ1VHehy9UQUe8ss0t8XMR72Vx1XUcY
         1XGn2kogWZlJw/gT+p7YmL8uKLT84v+X9s0RoKZQJDPLl3zywis2kBMT0y29CaYgTQa2
         oojhgPhjU1aV+ZgdI2hdOeulvDyp13Qp79s3Ovaw3RwWFofdCZndgr1jQLCdub+gJKMY
         duPNaoOpkLkfFVSUBlEYK/i4zozwwHTFe5ej1fRAsA/rFHt9uT1x2VTmy/ExCXeXVcQb
         WsTGLJP6Vs3bIXJ4hCBGJUNcVjPnesXXSYznpN2PIwIOoLhlv4EcCNudOXWaFPjHzv12
         Xwww==
X-Gm-Message-State: APjAAAUf1ADsuUvetMTA/pBAvUEb4knSzv8eTL/I10EvBjBbIlfhH0jH
        VtmlIGjqRp0N83R5PpbEToKzngEw5Vx53gCihEWfJ1dMdBw=
X-Google-Smtp-Source: APXvYqzJuyU8BvbV8ejUBVa7KKdfW+5jhUkFrVIhHJhvyM5sqW1Mnffl0dccAkZDQkbkfY1w6jq7cCs4ShOqgc6/Pgw=
X-Received: by 2002:a05:6e02:f47:: with SMTP id y7mr7821677ilj.162.1580443973455;
 Thu, 30 Jan 2020 20:12:53 -0800 (PST)
MIME-Version: 1.0
References: <1746386.HyI1YD2b7T@merkaba> <BA3238FF-0884-40AA-9E32-89DA35D8CD0A@bluematt.me>
In-Reply-To: <BA3238FF-0884-40AA-9E32-89DA35D8CD0A@bluematt.me>
From:   Etienne Champetier <champetier.etienne@gmail.com>
Date:   Thu, 30 Jan 2020 23:12:41 -0500
Message-ID: <CAOdf3gpi8MkveLHXgukSC8UU6fpW-u=8L8BbG-Yhm=aAy_dgwg@mail.gmail.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Matt Corallo <kernel@bluematt.me>,
        Remi Gauvin <remi@georgianit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le jeu. 30 janv. 2020 =C3=A0 20:53, Matt Corallo <kernel@bluematt.me> a =C3=
=A9crit :
>
> This is a pretty critical regression for me. I have a few applications th=
at regularly check space available and exit if they find low available spac=
e, as well as a number of applications that, eg, rsync small files, causing=
 this bug to appear (even with many TB free). It looks like the suggested p=
atch isn=E2=80=99t moving towards stable, is there some other patch we shou=
ld be testing?

I was migrating some data over to a new Fedora 31 server with btrfs
when dnf complained that my disk were full, despite having 2.61TiB
unallocated
Once a new kernel with a fix is available Fedora systems will need
some manual work to recover.

Running transaction test
The downloaded packages were saved in cache until the next successful
transaction.
You can remove cached packages by executing 'dnf clean packages'.
Error: Transaction test error:
installing package libev-4.27-1.fc31.x86_64 needs 160KB on the / filesystem
...

# uname -r
5.4.7-200.fc31.x86_64
# LANG=3DC df -hT /
Filesystem                                            Type   Size
Used Avail Use% Mounted on
/dev/mapper/luks-17a54b4f-58b1-447f-a1e2-f927503936f2 btrfs  3.7T
1.1T     0 100% /

# btrfs fi usage -T /
Overall:
    Device size:           3.63TiB
    Device allocated:           1.03TiB
    Device unallocated:           2.61TiB
    Device missing:             0.00B
    Used:               1.02TiB
    Free (estimated):           2.61TiB    (min: 1.31TiB)
    Data ratio:                  1.00
    Metadata ratio:              2.00
    Global reserve:         512.00MiB    (used: 0.00B)

                                                         Data
Metadata System
Id Path                                                  RAID0
RAID1    RAID1    Unallocated
-- ----------------------------------------------------- ---------
-------- -------- -----------
 1 /dev/mapper/luks-17a54b4f-58b1-447f-a1e2-f927503936f2 522.00GiB
3.00GiB  8.00MiB     1.30TiB
 2 /dev/mapper/luks-ee555ebd-59ca-4ed8-9d68-7c3faf6e6a25 522.00GiB
3.00GiB  8.00MiB     1.30TiB
-- ----------------------------------------------------- ---------
-------- -------- -----------
   Total                                                   1.02TiB
3.00GiB  8.00MiB     2.61TiB
   Used                                                    1.02TiB
2.75GiB 96.00KiB

The good news is that I saw that I messed up my kickstart installed
and ended up with RAID0 for data

>
> > On Jan 30, 2020, at 18:12, Martin Steigerwald <martin@lichtvoll.de> wro=
te:
> >
> > =EF=BB=BFRemi Gauvin - 30.01.20, 22:20:47 CET:
> >>> On 2020-01-30 4:10 p.m., Martin Steigerwald wrote:
> >>> I am done with re-balancing experiments.
> >>
> >> It should be pretty easy to fix.. use the metadata_ratio=3D1 mount
> >> option, then write enough to force the allocation of more data
> >> space,,
> >>
> >> In your earlier attempt, you wrote 500MB, but from your btrfs
> >> filesystem usage, you had over 1GB of allocated but unused space.
> >>
> >> If you wrote and deleted, say, 20GB of zeroes, that should force the
> >> allocation of metatada space to get you past the global reserve size
> >> that is causing this bug,, (Assuming this bug is even impacting you.
> >> I was unclear from your messages if you are seeing any ill effects
> >> besides the misreporting in df.)
> >
> > I thought more about writing a lot of little files as I expect that to
> > use more metadata, but=E2=80=A6 I can just work around it by using comm=
and line
> > tools instead of Dolphin to move data around. This is mostly my music,
> > photos and so on filesystem, I do not change data on it very often, so
> > that will most likely work just fine for me until there is a proper fix=
.
> >
> > So do need to do any more things that could potentially age the
> > filesystem. :)
> >
> > --
> > Martin
> >
> >
>
