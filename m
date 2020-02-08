Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE351562DD
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 05:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBHEhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 23:37:18 -0500
Received: from mail-vk1-f182.google.com ([209.85.221.182]:32987 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBHEhS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 23:37:18 -0500
Received: by mail-vk1-f182.google.com with SMTP id i78so414126vke.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 20:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLnJoljtC5nDuwx/bbQ+sX4s7Lp9bsK1ko+YeYtDRLo=;
        b=aUUU24+1hdHPkl9Qtore8ndq/idINvVdoAr5O8s5EYqs0FwCp9uGv4iy38ZoC+JlFm
         Y64TbfMfr2iW0lD7vDHmF8vhyYdWT7p64F1tVcTK+u60NGVLWxwcbjw6Im/6wFvXJM64
         sXXvy6fqt+WALb9QxZwOReOPTaReRUzSk4CVE+E5B1LCP9/K3oL7AijRsuLYabd2Wp6s
         Nwiwd4ky/ObXEm+qZ+IwAbohlGzE8e5/kBK5IsOiwzlBjL1GPDwVW6ESxZDsv4N9KQ8x
         ryy1sLnPi0Ydf+3DxepW3tPZ6wEtZq++KOgp2joHH2U0HoTNAkbVgCU8Pn8tcX+zSWkr
         hb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLnJoljtC5nDuwx/bbQ+sX4s7Lp9bsK1ko+YeYtDRLo=;
        b=ptn3Cg0iKR6wUOKtDwRGx7SBvEJ0152dCmLvIfbj4hUuvCxUxoWY2zE25XL3PqGonN
         xlcstfitDBsfQFCl7QsrQbPu+wGLSSzbYxRZyRElW3U0JqhxFa9kVa9+DXpNnM//E3C8
         8icqjofSo3oadOAwtOhfujMA4EcR63Gpplp+d50eX49NM1tw3UjR/qBKQ0xL6SbXQquM
         z3q5gBMvNbfsFWgpyyZMc/P5PURQoTKwPrqEzLUZm6OSndDaW7HCq+AVskz/rbbci4Pz
         aiQtMAfbh/MQqvqUwtwWS+55M0qLTvRpmyYZz+Wa2A9wqOsmVPf5aGkILM9XRRUsPnNy
         F1qg==
X-Gm-Message-State: APjAAAU9iYAyIJOKUiBCr1u21mqYGqIl6NsP7781HDwFWkrzqy0tWb7J
        NUhRBMBMHe/x3JPcTyq1Pr0rRJZiqs9i1tK1a+9UZZGI/ok=
X-Google-Smtp-Source: APXvYqxeo6IitvGHIRVhTAT9axKTnS05Lt3Ya+a6zran/+dkpW2BM12TYCpIym9Q1j9PzLT2kXahVlBwuz4obbVCeW4=
X-Received: by 2002:a1f:9d8a:: with SMTP id g132mr1392085vke.39.1581136636339;
 Fri, 07 Feb 2020 20:37:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <CAJCQCtShJVH-mTQEQ--RHyJgMWw1R-YfeUQLp2rn3x+xOwJz+Q@mail.gmail.com>
 <CA+M2ft88F8XfF+Ob8mvdPvgKEQx=q8xwfgiCjL+ACM3XVuAhbA@mail.gmail.com> <CAJCQCtRFchojvVBCPc5BGtd_o8V9YKHfoxmZJExxKwirkZO=Jg@mail.gmail.com>
In-Reply-To: <CAJCQCtRFchojvVBCPc5BGtd_o8V9YKHfoxmZJExxKwirkZO=Jg@mail.gmail.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Fri, 7 Feb 2020 22:37:06 -0600
Message-ID: <CA+M2ft-m62WX99BkpVE25NLGn==qc2f+pEnbD0bgwPoeQmT_-g@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 7, 2020 at 5:17 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Fri, Feb 7, 2020 at 3:31 PM John Hendy <jw.hendy@gmail.com> wrote:
> >
> > On Fri, Feb 7, 2020 at 2:22 PM Chris Murphy <lists@colorremedies.com> wrote:
> > >
> > > On Fri, Feb 7, 2020 at 10:52 AM John Hendy <jw.hendy@gmail.com> wrote:
> > >
> > > > As an update, I'm now running off of a different drive (ssd, not the
> > > > nvme) and I got the error again! I'm now inclined to think this might
> > > > not be hardware after all, but something related to my setup or a bug
> > > > with chromium.
> > >
> > > Even if there's a Chromium bug, it should result in file system
> > > corruption like what you're seeing.
> >
> > I'm assuming you meant "*shouldn't* result in file system corruption"?
>
> Ha! Yes, of course.
>
>
> > Indeed. Just reproduced it:
> > - https://pastebin.com/UJ8gbgFE
>
> [  126.656696] BTRFS info (device dm-0): turning on discard
>
> I advise removing the discard mount option from /etc/fstab. This
> obviates manual fstrim, and makes sure you can't correlate discards to
> these problems.

Done!

/dev/mapper/luks-0712af67-3f01-4dde-9d45-194df9d29d14 on / type btrfs
(rw,relatime,compress=lzo,ssd,space_cache,subvolid=263,subvol=/arch)
/dev/mapper/luks-0712af67-3f01-4dde-9d45-194df9d29d14 on /home/jwhendy
type btrfs (rw,relatime,compress=lzo,ssd,space_cache,subvolid=339,subvol=/jwhendy)
/dev/mapper/luks-0712af67-3f01-4dde-9d45-194df9d29d14 on /mnt/vault
type btrfs (rw,relatime,compress=lzo,ssd,space_cache,subvolid=265,subvol=/vault)

> > Aside: is there a preferred way for sharing these? The page I read
> > about this list said text couldn't exceed 100kb, but my original
> > appears to have bounced and the dmesg alone is >100kb... Just want to
> > make sure pastebin is cool and am happy to use something
> > better/preferred.
>
> Everyone has their own convention. My preferred convention is to put
> the entire dmesg up on google drive, unedited, and include the URL.
> And then I extract excerpts I think are relevant and paste into the
> email body. That way search engines can find relevant threads.
>

Thanks for that. I'll stick to pastebin for now just for convenience.
Mainly I wanted to make sure that links to these were reasonable, and
sounds like this is okay for the list. Thanks!

> > Clarification, and apologies for the confusion:
> > - the m2.sata in my original post was my primary drive and had an
> > issue, then I wiped, mkfs.btrfs from scratch, reinstalled linux, etc.
> > and it happened again.
> >
> > - the ssd I'm now running on was the former boot drive in my last
> > computer which I was using as a backup drive for /mnt/vault pool but
> > still had the old root fs. After the m2.sata failure, I started
> > booting from it. It is not a new fs but >2yrs old.
>
> Got it. Well it would be really bad luck but not impossible to have
> two different drives with discard related firmware bugs. But the point
> of going through the tedious work to prove this? Such devices will get
> the relevant (mis)feature blacklisted in the kernel for that
> make/model so that no one else experiences it.

> >
> > If you'd like, let's stick to troubleshooting the ssd for now.
> >
> > > [   60.697438] BTRFS error (device dm-0): parent transid verify failed
> > > on 202711384064 wanted 68719924810 found 448074
>
> 448704 is reasonable for a 2 year old file system. I'm doubt 68719924810 is.
>
>
> > $ lsattr /home/jwhendy/.config/chromium/Default/Cookies
> > -------------------- /home/jwhendy/.config/chromium/Default/Cookies
>
> No +C so these files should have csums.
>
>
> > Yes, though I have turned that off for the SSD ever since I started
> > booting from it. That said, I realized that discard is still in my
> > fstab... is this a potential source of the transid/csum issues? I've
> > now removed that and am about to reboot after I send this.
>
> Maybe.
>
>
> > I just updated today which put me at 5.5.2, but in theory yes. And as
> > I went to check that I get an Input/Output error trying to check the
> > pacman log! Here's the dmesg with those new errors included:
> > - https://pastebin.com/QzYQ2RRg
> >
> > I'm still mounted rw, but my gosh... what the heck is happening. The
> > output is for a different root/inode:
>
> Understand that Btrfs is like a canary in the coal mine. It's *less*
> tolerant of hardware problems than other file systems, because it
> doesn't trust the hardware. Everything is checksummed. The instant
> there's a problem, Btrfs will start complaining, and if it gets
> confused it goes ro in order to stop spreading the corruption.
>
>
> >
> > $ sudo btrfs insp inod -v 273 /
> > ioctl ret=0, bytes_left=4053, bytes_missing=0, cnt=1, missed=0
> > //var/log/pacman.log
> >
> > Is the double // a concern for that file?
>
> No it's just a convention.
>
>
> > - ssd: Samsung 850 evo, 250G
> > - m2.sata: nvme Samsung 960 evo, 250G
>
> As a first step, stop using discard mount option. And delete all the
> corrupt files by searching for other affected inodes. Once you're sure
> they're all deleted, do a scrub and report back. If the scrub finds no
> errors, then I suggest booting off install media and running 'btrfs
> check --mode=lowmem' and reporting that output to the list also. Don't
> use --repair even if there are reported problems.

I tried to remove .config/chromium, but ran into a weird problem. I
was getting an error on `rm` with a TransportSecurity file saying "No
such file or directory." More on that below. I also removed
/var/log/pacman.log, the other offending file from the previous inode
error. At this point I tried a `btrfs scrub start /` but it fails
(aborted):

[  126.520270] BTRFS error (device dm-0): parent transid verify failed
on 202711384064 wanted 68719924810 found 448074
[  126.532637] BTRFS info (device dm-0): scrub: not finished on devid
1 with status: -5

Full dmesg at that point:
- https://pastebin.com/9TvvMVpE

Brief aside before we get back to .config/chromium: after I sent the
last message and removed the discard option (but before I deleted
these files), I ran btrfs check from an arch install usb.
- https://pastebin.com/Wdg8aqTY

The first inode resolved to /var/log/journal so I just rm'd the whole
thing. Every subsequent inode on root 263 (/ mountpoint) resulted in
the following, so I think problematic files on / are set:
ERROR: ino paths ioctl: No such file or directory

This inode was also in the output of the btrfs check, and is the same
file I can't delete from above:

root 339 inode 17848 errors 200, dir isize wrong
    unresolved ref dir 17848 index 6 namelen 11 name File System
filetype 2 errors 2, no dir index
root 339 inode 4504988 errors 1, no inode item
    unresolved ref dir 17848 index 489287 namelen 17 name
TransportSecurity filetype 1 errors 5, no dir item, no inode ref

$ sudo btrfs insp inode -v 17848 /home/jwhendy/
[sudo] password for jwhendy:
ioctl ret=0, bytes_left=4034, bytes_missing=0, cnt=1, missed=0
/home/jwhendy//.local/share/Trash/expunged/3065996973

$ cd .local/share/Trash/expunged/3065996973/
$ ls
ls: cannot access 'TransportSecurity': No such file or directory
TransportSecurity
$ ls -la
ls: cannot access 'TransportSecurity': No such file or directory
total 0
drwx------ 1 jwhendy jwhendy 22 Feb  7 21:42 .
drwx------ 1 jwhendy jwhendy 20 Feb  7 21:46 ..
-????????? ? ?       ?        ?            ? TransportSecurity

Posts online suggest `rm -i -- ./*` but that doesn't work.

$ rm -i -- ./*
rm: cannot remove './TransportSecurity': No such file or directory

I also found a post suggesting this, potentially revealing weird,
non-obvious characters that might be present:
$ ls | od -a
0000000   T   r   a   n   s   p   o   r   t   S   e   c   u   r   i   t
0000020   y  nl
0000022

Not sure what to make of that. In other StackOverflow and similar
posts, the `rm -i -- ./*` does the trick. Yet another post suggested
moving to /tmp and rebooting, but I can't move it (same "no such file
or directory" error).

Any input on how to blow this thing up?

> A general rule is to change only one thing at a time when
> troubleshooting. That way you have a much easier time finding the
> source of the problem. I'm not sure how quickly this problem started
> to happen, days or weeks? But you want to go for about that long,
> unless the problem happens again, to prove whether any change solved
> the problem. Ideally, you revert to the suspected setting that causes
> the problem to try and prove it's the source, but that's tedious and
> up to you. It's fine to just not ever use the discard mount option if
> that's what's causing the problem.
>
> I can't really estimate whether that could be defect in the SSD, or
> firmware bug that's maybe fixed with a firmware update, or a Btrfs
> regression bug. BTW, I think your laptop has a more recent firmware
> update available. 01.31 Rev.A 13.5 MB Nov 8, 2019. Could it be
> related? *shrug* No idea. But it's vaguely possible. More likely such
> things are drive firmware related.

firmware = BIOS? I can check that. Or if this is is intel-ucode, I
just have whatever arch has as current...

Thanks again,
John

>
> --
> Chris Murphy
