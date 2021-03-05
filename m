Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB12E32F21C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 19:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCESE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 13:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCESD4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 13:03:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57AFC061574
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Mar 2021 10:03:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id z11so5061831lfb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Mar 2021 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hypertriangle-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqHxpIXbqgldvhlLIQ2EMgYApQUQHhs2b1teFfuCaHE=;
        b=Bn0xjdodxjdJcmExkaE/Hc3thDSCEBGNuDTVLLxBA08pELn9njrHXxopM7oNn1n8cl
         p3jQJlM+Pubb9tzRijb3D0Us8dgbqkcxqsc3nmCUZ+Nvq8BUak8SML9548KoXcBsyvRQ
         ZqBVKg4Md42TZ6izpzmq7QaQXfVh3SOpnoqst7WxMf2ONIMKgwslftcgIAug8kgA/1Y+
         azsPWuJPKAFaFoD6EYNeTpZdLEeGaj4MNIXNUdAed65N45R0P1p46wD0mhvFAX3LWdZ6
         b3p6BQR2Y/a3f9aFhkqk9Cd3dv1pKhUXtxulEDsdEgdImX8FjQkbuaF2qbrm3CLQjsvD
         pRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqHxpIXbqgldvhlLIQ2EMgYApQUQHhs2b1teFfuCaHE=;
        b=EojqXLajPtXjzah36iXTAAKp6rAmSxy9hnpKU6uPhnSSDj7LSEakm+ImpAVbXFH4rX
         0221ydUItPXVp8cUXWYY725baHK7mELAua+uQFdol6MKdVgSyXFIG6W49Jl8LERnLRqJ
         PQA+jeeyQyCMPKqHNPPWmkyHc1TxOLR2lMyhj+kq56i3weVoq3K1hk8CzzPHUYcLYDxj
         UpL0mDWhVkQtaC/skzwyhwICzDbpWlQlKAuPHh+zl5QTLCnna2tNnlukhELium/sJ9J8
         I3BN9S6xyvvmjouLZgbjb/lMriQFjdqj73qqwHZAm0KAnKm4j0mICmRxX4tzOzMleE65
         tK2w==
X-Gm-Message-State: AOAM532KMOo6u9kU/lMU94hJ2W2Z/6wKWVyzIbkWdMJwh+2eelgRX30Q
        BbEFAUzhXUR/zyvyQDJvE/yTughDk9wj1s4IQ0w=
X-Google-Smtp-Source: ABdhPJyP2686tD7GvodP7VQqaKIoArVvdchETmtxjcLooAz7E/bovC3EfZUbWoKeIWvcr21SJOJ+DClZiTlnAqrp3Ws=
X-Received: by 2002:a05:6512:504:: with SMTP id o4mr6145959lfb.438.1614967434192;
 Fri, 05 Mar 2021 10:03:54 -0800 (PST)
MIME-Version: 1.0
References: <CAE9tQ0dz-c05oGgzwwuJVfO9WUorwdUM_aDPy8Cc53cAK8AT9A@mail.gmail.com>
 <29e12e1c-b599-d807-0f3f-382ae18c3e22@oracle.com>
In-Reply-To: <29e12e1c-b599-d807-0f3f-382ae18c3e22@oracle.com>
From:   Alexandru Stan <alex@hypertriangle.com>
Date:   Fri, 5 Mar 2021 10:03:17 -0800
Message-ID: <CAE9tQ0d0ckKn9eDo_qUBr6puTkv0VV-h_Tvi9u_vK0_WBcYWtA@mail.gmail.com>
Subject: Re: Scared with degraded raid1 fs
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 5 Mar 2021 at 05:38, Anand Jain <anand.jain@oracle.com> wrote:
>
> On 05/03/2021 15:15, Alexandru Stan wrote:
> > Hello,
> >
> > My raid1 btrfs fs went read only recently. It was comprised of 2 drives:
> > /dev/sda ST4000VN008 (firmware SC60) - 6 month old drive
> > /dev/sdb ST4000VN000 (firmware SC44) - 5 year old drive (but it was
> > mostly idly spinning, very little accesses were done in that time)
> > The drives are pretty similar (size/performance/market segment/rpm),
> > but they're of different generations.
> >
> > FWIW kernel is v5.11.2 (https://archlinux.org/packages/core/x86_64/linux/)
> >
> > I noticed something was wrong when the filesystem was read only. Dmesg
> > showed a single error about 50 min previous:
> >> Mar 04 19:04:13  kernel: BTRFS critical (device sda3): corrupt leaf: block=4664769363968 slot=17 extent bytenr=4706905751552 len=8192 invalid extent refs, have 1 expect >= inline 129
> >> Mar 04 19:04:13  kernel: BTRFS info (device sda3): leaf 4664769363968 gen 1143228 total ptrs 112 free space 6300 owner 2
> >> Mar 04 19:04:14  kernel:         item 0 key (4706904485888 168 8192) itemoff 16230 itemsize 53
> >> Mar 04 19:04:14  kernel:                 extent refs 1 gen 1123380 flags 1
> >> Mar 04 19:04:14  kernel:                 ref#0: extent data backref root 431 objectid 923767 offset 175349760 count 1
> > No other ATA errors nearby, there wasn't much activity going on around
> > there either.
> >
> > I tried to remount everything using the fstab, but it wasn't too happy:
> >> ~% sudo mount -a
> >> mount: /mnt/fs: wrong fs type, bad option, bad superblock on /dev/sdb3, missing codepage or helper program, or other error.
> > I regret not checking dmesg after that command, that was stupid of me
> > (though I do have dmesg output of this later on).
> >
> > Catting /dev/sda seemed just fine, so at least one could still read
> > from the supposedly bad drive. I also think that the error message
> > just above always lists a random (per boot) drive of the array, not
> > necessarily the one that causes problems, which scares me for a second
> > there.
> >
> > The next "bright" idea I had was maybe this was a small bad block on
> > /dev/sda and what are the chances that the array will try to write
> > again to that spot. Maybe the next reboot will be fine. So I just
> > rebooted.
> >
> > The system didn't come back up anymore (and so did my 3000 mile ssh
> > access that was dear to me). SInce my rootfs was on that array I was
> > dumped to an initrd shell.
> > Any attempts to mount were met with more scary superblock errors (even
> > if i tried /dev/sdb)
> >
>
>
>
> > This time I checked dmesg:
> >> BTRFS info (device sda3): disk space caching is enabled
> >> BTRFS info (device sda3): has skinny extents
> >> BTRFS info (device sda3): start tree-log replay
> >> BTRFS error (device sda3): parent transid verify failed on 4664769363968 wanted 1143228 found 1143173
> >> BTRFS error (device sda3): parent transid verify failed on 4664769363968 wanted 1143228 found 1143173
> >> BTRFS: error (device sda3) in btrfs_free_extent:3103 errno-5 IO failure
> >> BTRFS: error (device sda3) in btrfs_run_delayed_refs:2171: errno=-5 IO failure
> >> BTRFS warning (device sda3): Skipping commit of aborted transaction.
> >> BTRFS: error (device sda3) in cleanup_transaction:1938: errno-5 10 failure
> >> BTRFS: error (device sda3) in btrfs_replay_log:2254: errno-5 I0 failure (Failed to recover log tree)
> >> BTRFS error (device sda3): open_ctree failed
> > A fuller log (but not OCRd) can be found at
> > https://lh3.googleusercontent.com/-aV23XURv_f0/YEGLDeEavbI/AAAAAAAALYI/bFuSQsTYbCM7-z9SSNbcZq-7p1I7wGyLQCK8BGAsYHg/s0/2021-03-04.jpg,
> > though please excuse the format, I have to debug/fix this over VC.
> >
> > I managed to successfully mount by doing `mount -o
> > degraded,ro,norecovery,subvol=/root /new_root`. Seems to work fine for
> > RO access.
> >
>
>
>  From the parent transid verify failed it looks like a disk did not
> receive few writes. A complete dmesg log will be better to understand
> the root cause.

My dmesg only prints at most that snippet every time I try to mount
the fs. Is there any other debugging wanted that I should enable for
this?

I doubt there's any way to get the original dmesg (besides that first
"corrupt leaf" snippet I posted) before the reboot, I assume it didn't
have a chance to write those logs to the rootfs since it went RO.

>
> Thanks.
>
> > I can't really boot anything from this though, systemd refuses to go
> > past what the fstab dictates and without either a root password for
> > the emergency shell (which i don't evne have) or being able to change
> > the fstab (which I don't think I am capable of getting right in that
> > one RW attempt).
> >
> > I used a chroot in that RO mount to start a long smart scan of both
> > drives. I guess I'll find results in a couple of hours.

Long smart scan completed with no errors on both drives.

> >
> > In the meantime I ordered another ST4000VN008 drive for more room for
> > activities, maybe I can do a `btrfs replace` if needed.
> >
> > I was earlier on irc/#btrfs, Zygo mentioned that these (at least the
> > later transid verify errors) are very strange and are either drive
> > firmware, ram or kernel bugs. Hoping this brings a fuller picture.
> > Ram might be a little suspect, it's a newish machine I built, but I
> > have run memtest86 on it for 12 hours with no problems. No ECC though.
> >
> > My questions:
> > * If both my drives' smart run report no errors, how do I recover my
> > array? Ideally I would do this inplace.
> >      * Any suggestions how to use my new third drive to make things safer?
> > * I would be ok with doing a 3 device raid1 in the future, would that
> > protect me from something similar while not degrading to RO?
> >
> > When this is all over I'm setting up my daily btrbk remote snapshot
> > that I've been putting off for an extra piece of mind (then I'll have
> > my data copied on 5 drives in total).
> >
> > Thanks,
> > Alexandru Stan
> >
>


Alexandru Stan
