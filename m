Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9800ECF66
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKBPKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Nov 2019 11:10:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40423 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKBPKG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Nov 2019 11:10:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id p59so9681746edp.7
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Nov 2019 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GeRUR5F8H/kOJBqad9nPXbg+kWqsTbUPdUwkx7NZKzc=;
        b=MgsDA3zfkgpmoSeNIUzgWYDusMM3SIvY6pnfyLTTSdarlHD3EvsItOtmX6ChLRtmCe
         rWURPKu+WHeApc57SbVtH5gkjpTQYY9WA63YQ5XLW0G79NzALgKGG9dL5LQ7pubGJs2h
         tKm4vx7GDXkjQpv+CPvbfomG3gBS5Ngz6cJz0dsysSvUBM6GInnNAmn+4H24fbL4ZPur
         mmQl3Sb/XzI8qOcGUy50DvQAGcwI6uNkDcXgl3uxpjtCqdKNUm2TqPOUlcFGm1iK/R59
         2I/6aC7dMKrFcFYFbGZ8Vx+EqTb1Aess9q/tEjgU4+T1JgEYvdPUUWT3f3vGI5X9Rw2B
         F5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeRUR5F8H/kOJBqad9nPXbg+kWqsTbUPdUwkx7NZKzc=;
        b=FUjkeDI8HfxrNWXct7p0ZZJmvw7kkMp6t2QWpEkKzsg4TWFVGGApuqSMAqrYfG3oIE
         Pny9RGKVz/nBeZU7zJG3xO2gLXg9MuMHzFOmOpNveZQXFxdX98zJ6S+vPSuPV7Fonzky
         HO6G1fJ8LC0y5/h8sJuzq4hCeH2IaoI/Bi3RVDy5D2Uh2Ex/IDzWhthMn/TnFAo0iO4q
         1yO9bGXKWKjP3qqbo016xNxWuE/QkVw9xshWEVrTxHWBwhHbD+y3iuVMVtkO2yY8EPje
         JlFgGvoWrtTenB3YrDVCLNjtjoD3j01GieIAlzRQqrWjN4n95aQ9LRbaLiaqH+HqijL7
         nBww==
X-Gm-Message-State: APjAAAWOgmuEOVbRdbi+GiYBaejLrPCeY9fc1iiUbhopBtn3wWPTPFS4
        LACXvTe2rHZmnIhJvVgXpG0p63w9oO/HUV+Ib7w=
X-Google-Smtp-Source: APXvYqzD+yR7C7S/psZa4rVN0h6xoVxMP9ynjAFb2qF6TMSPdDekSwhsfb1KoivGKuPMbqGYvTu5QQy8JI/bXgNGqtE=
X-Received: by 2002:a17:906:5004:: with SMTP id s4mr15545578ejj.26.1572707404443;
 Sat, 02 Nov 2019 08:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMiuOHXH1ic6Mcz+o1uWLNMCK+iCinhR+nnZ8N1wTHQoEms-7Q@mail.gmail.com>
 <20191102193624.3411de0d@natsu>
In-Reply-To: <20191102193624.3411de0d@natsu>
From:   Brian Hansen <dulanic@gmail.com>
Date:   Sat, 2 Nov 2019 10:09:27 -0500
Message-ID: <CAMiuOHWtjJdeKmkEV-kx+GRk_VskXEKMZoJWD5z7acapqeDE-A@mail.gmail.com>
Subject: Re: reflink copy now works with nocow?
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ah I see, so I only have +C set on my temporary directory, but I guess
when the file is moved to the final directory which does not have C
set, it still has it enabled from when it was in the temporary
directory. So I'll need to setup a script to remove C when moving
directories. Unless there is a easier way to deal with this? I have it
download to incomplete then move to a final dir, but it seems to trake
the +C /w it.

------------------ ./archive
------------------ ./radarr
------------------ ./sonarr
------------------ ./autodl
------------------ ./radarr4k
---------------C-- ./incomplete
------------------ ./archive1
------------------ ./temp
------------------ ./freeleech

File was moved from incomplete to radarr4k but it seems to carry the +C.

---------------C--
/mnt/btrfs/downloads/torrent/radarr4k/Spider-Man.Far.from.Home.2019.UHD.BluRay.2160p.TrueHD.Atmos.7.1.HEVC.REMUX-FraMeSToR/Spider-Man.Far.from.Home.2019.UHD.BluRay.2160p.TrueHD.Atmos.7.1.HEVC.REMUX-FraMeSToR.mkv


On Sat, Nov 2, 2019 at 9:36 AM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Sat, 2 Nov 2019 08:49:37 -0500
> Brian Hansen <dulanic@gmail.com> wrote:
>
> > Hello,
> >
> > First time i've sent to this group but I am trying to figure out the
> > cause of this. Normal copy is working fine, but then if I use
> > --reflink it says invalid argument. Not sure how to read some of this,
> > but here is the strace.
> >
> > I'm running kernel v4.15
> >
> > Here is the full output of strace. I ran a strace on normal copy and
> > most looks similar so I'm not able to figure out much here...
> >
> > https://pastebin.com/raw/YmQ8FvCH
>
> At first I was going to say, "oh it's because you are using 'chattr +C', or
> mounted the filesystem as nocow, and reflink copying is prevented by those".
> In fact this article from 2014 confirms that to be the case:
> http://infotinks.com/btrfs-nodatacow-reflink-copies-snapshots/
>
> But then I tested on my machine, and what used to fail, now works:
>
>   # mkdir tmp
>   # chattr +C tmp
>   # echo abc > tmp/a
>   # cp -a --reflink=always tmp/a tmp/b
>   # lsattr tmp/
>   ----------------C-- tmp/a
>   ----------------C-- tmp/b
>
> According to strace, the clone IOCTL succeeds:
>
> ...
>   openat(AT_FDCWD, "tmp/b", O_WRONLY|O_CREAT|O_EXCL, 0600) = 4
>   fstat(4, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
>   ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = 0
> ...
>
> Same on kernels 4.14.151, 4.14.113 and 4.9.189.
>
> So I wonder, is setting nocow via 'chattr +C' getting ignored now, or is there
> an improvement that it no longer prevents reflink copying?
>
> --
> With respect,
> Roman
