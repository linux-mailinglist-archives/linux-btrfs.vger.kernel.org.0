Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628481C74D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgEFP3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgEFP3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 11:29:38 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F94AC061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 08:29:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id g2so1258596vsb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mklHEVS1nbQjZVt3KqK8sj09a44t087taIYExmznuWc=;
        b=VBCjnyjcGFikAN3DEDRKl987jUIMVJGerEDzT1CDrsJqxA4XTs4VtFBAEjvIkJW8qe
         Hdt2HrnR10oF/kxwo5B7VoQVLGmK6aDuz3szZJlOqPlupfAjQZe/OcXXDDSBYtg0sUhf
         yRlCHe2RLGGJdHMGOz71Z022GyC+qfBtMPg70LiINRyw6mmK0oeBwhdHiQUzB+gCNMKQ
         VKXtyt9/+DbEzXkkbsT5XDoecCHydQkfY7oph8kLPvdYJnivbBovLEWPELJMJTcYPYzZ
         uaZNSp/nclUIq+0U4kSPaAbHeKZmLtBQaVCw7dLtfXI/UAu9gXqGYJhe0PbnOvtY3upG
         fyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mklHEVS1nbQjZVt3KqK8sj09a44t087taIYExmznuWc=;
        b=MYJRqU3gXPk1UiiD23iYV89tHvwwQWrcrtkaOu+Pzbjfjupmb5a219KxNfWJ+yCQg9
         cNvO65/pXX55SYSDUznTFBmv/o0d2zsLn3/9QD5OnKNC8KWFNH9MBNFOIR1EI08MaJWg
         uymj9MiSXaN4fnWiGdcmesFuUa3J58Rv5CHxTkRfRWJcTD/P+dKoIIhLkpHgsrtx5u0i
         wZLDkWVt/kWSlPkR+5IhL6CP3ath2jgwsSbvkECrTyckITm5enVOduFkmse/WRUSuKVf
         nbnOkL4wg6B+Xy8vQZvgmIbttiOBGQybQ129+7VVz//U6PK7w7W5dy/LtjppKk+L1G4J
         ZXjA==
X-Gm-Message-State: AGi0PuY1jtjJYm269UlwVCkurVcUEl1nTJ9TchC4mGYcsLTtNIcmq/Ik
        C2ijraSpca3p87d9qnkgE+Xg1BVByZnqtVesK5FH+wwaBbQ=
X-Google-Smtp-Source: APiQypIhgQg809zmZNZEbV+6tAXJbHTE7m0Y/JKUZgeOLqXvurDOsJ2wnXynRZjk+S4CkRuRsvYa5R5G5s6ttkwlPGo=
X-Received: by 2002:a67:ed51:: with SMTP id m17mr8173763vsp.158.1588778977147;
 Wed, 06 May 2020 08:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft895gy-zmDsax14pOgK3JmGxj6+1Z_itn3GhaGREBfDKw@mail.gmail.com> <87cb36b6-618d-5005-d832-53cd486084cb@gmx.com>
In-Reply-To: <87cb36b6-618d-5005-d832-53cd486084cb@gmx.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Wed, 6 May 2020 10:29:23 -0500
Message-ID: <CA+M2ft8oLkTrav1=zW1AFRU+=44Yd6-fXYO5mhre4mi-1PANmw@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 6, 2020 at 1:13 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/5/6 =E4=B8=8B=E5=8D=8812:37, John Hendy wrote:
> > Greetings,
> >
> >
> > I'm following up to the below as this just occurred again. I think
> > there is something odd between btrfs behavior and browsers. Since the
> > last time, I was able to recover my drive, and have disabled
> > continuous trim (and have not manually trimmed for that matter).
> >
> > I've switched to firefox almost exclusively (I can think of a handful
> > of times using it), but the problem was related chromium cache and the
> > problem this time was the file:
> >
> > .cache/mozilla/firefox/tqxxilph.default-release/cache2/entries/D8FD7600=
C30A3A68D18D98B233F9C5DD3F7DDAD0
> >
> > In this particular instance, I suspended my computer, and resumed to
> > find it read only. I opened it to reboot into windows, finding I
> > couldn't save my open file in emacs.
> >
> > The dmesg is here: https://pastebin.com/B8nUkYzB
>
> The reason is write time tree checker, surprised it get triggered:
>
> [68515.682152] BTRFS critical (device dm-0): corrupt leaf: root=3D257
> block=3D156161818624 slot=3D22 ino=3D1312604, name hash mismatch with key=
,
> have 0x000000007a63c07f expect 0x00000000006820bc
>
> In the dump included in the dmesg, unfortunately it doesn't include the
> file name so I'm not sure which one is the culprit, but it has the inode
> number, 1312604.

Thanks for the input. The inode resolves to this path, but it's the
same base path as the problematic file for btrfs scrub.

$ sudo btrfs inspect-internal inode-resolve 1312604 /home/jwhendy
/home/jwhendy/.cache/mozilla/firefox/tqxxilph.default-release/cache2/entrie=
s

> But consider this is from write time tree checker, not from read time
> tree checker, this means, it's not your on-disk data corrupted from the
> very beginning, but possibly your RAM (maybe related to suspension?)
> causing the problem.

Interesting. I suspend al the time and have never encountered this,
but I do recall sending an email (in firefox) and quickly closing my
computer afterward as the last thing I did.

> >
> > The file above was found uncorrectable via btrfs scrub, but after I
> > manually deleted it the scrub succeeded on the second try with no
> > errors.
>
> Unfortunately, it may not related to that file, unless that file has the
> inode number 1312604.
>
> That to say, this is a completely different case.
>
> Considering your previous csum corruption, have you considered a full
> memtest?

I can certainly do this. At what point could hardware be ruled out and
something else pursued or troubleshot? Or is this a lost cause to try
and understand?

Many thanks,
John

> Thanks,
> Qu
>
> >
> > $ btrfs --version
> > btrfs-progs v5.6
> >
> > $ uname -a
> > Linux voltaur 5.6.10-arch1-1 #1 SMP PREEMPT Sat, 02 May 2020 19:11:54
> > +0000 x86_64 GNU/Linux
> >
> > I don't know how to reproduce this at all, but it's always been
> > browser cache related. There are similar issues out there, but no
> > obvious pattern/solutions.
> > - https://forum.manjaro.org/t/root-and-home-become-read-only/46944
> > - https://bbs.archlinux.org/viewtopic.php?id=3D224243
> >
> > Anything else to check on why this might occur?
> >
> > Best regards,
> > John
> >
> >
> > On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.com> wrote:
> >>
> >> Greetings,
> >>
> >> I've had this issue occur twice, once ~1mo ago and once a couple of
> >> weeks ago. Chromium suddenly quit on me, and when trying to start it
> >> again, it complained about a lock file in ~. I tried to delete it
> >> manually and was informed I was on a read-only fs! I ended up biting
> >> the bullet and re-installing linux due to the number of dead end
> >> threads and slow response rates on diagnosing these issues, and the
> >> issue occurred again shortly after.
> >>
> >> $ uname -a
> >> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020 16:38:40
> >> +0000 x86_64 GNU/Linux
> >>
> >> $ btrfs --version
> >> btrfs-progs v5.4
> >>
> >> $ btrfs fi df /mnt/misc/ # full device; normally would be mounting a s=
ubvol on /
> >> Data, single: total=3D114.01GiB, used=3D80.88GiB
> >> System, single: total=3D32.00MiB, used=3D16.00KiB
> >> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
> >> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
> >>
> >> This is a single device, no RAID, not on a VM. HP Zbook 15.
> >> nvme0n1                                       259:5    0 232.9G  0 dis=
k
> >> =E2=94=9C=E2=94=80nvme0n1p1                                   259:6   =
 0   512M  0
> >> part  (/boot/efi)
> >> =E2=94=9C=E2=94=80nvme0n1p2                                   259:7   =
 0     1G  0 part  (/boot)
> >> =E2=94=94=E2=94=80nvme0n1p3                                   259:8   =
 0 231.4G  0 part (btrfs)
> >>
> >> I have the following subvols:
> >> arch: used for / when booting arch
> >> jwhendy: used for /home/jwhendy on arch
> >> vault: shared data between distros on /mnt/vault
> >> bionic: root when booting ubuntu bionic
> >>
> >> nvme0n1p3 is encrypted with dm-crypt/LUKS.
> >>
> >> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
> >>
> >> If these are of interested, here are reddit threads where I posted the
> >> issue and was referred here.
> >> 1) https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recoveri=
ng_from_various_errors_root/
> >> 2)  https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs_r=
oot_started_remounting_as_ro/
> >>
> >> It has been suggested this is a hardware issue. I've already ordered a
> >> replacement m2.sata, but for sanity it would be great to know
> >> definitively this was the case. If anything stands out above that
> >> could indicate I'm not setup properly re. btrfs, that would also be
> >> fantastic so I don't repeat the issue!
> >>
> >> The only thing I've stumbled on is that I have been mounting with
> >> rd.luks.options=3Ddiscard and that manually running fstrim is preferre=
d.
> >>
> >>
> >> Many thanks for any input/suggestions,
> >> John
>
