Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61B1562DE
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 05:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBHEsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 23:48:30 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37289 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBHEsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 23:48:30 -0500
Received: by mail-vs1-f65.google.com with SMTP id x18so995388vsq.4
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 20:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WdBXRyf7ffYmk8ThiigR2f63EskcKRM4FARM3HWVzj0=;
        b=BenMG83iNnUA9Cs6EHKP3PLvxH1uajkq1Cr57vfFVsa9KX6lsBKV3XO8WAh8dyYRuK
         9M0+GVCGjnKn7cxXxiTKYKwPnF06UZw2jeLtwP59KYUMvU05NwCV+7IxBRSE6Ra+0SQJ
         ttlZYGmQq4pOfVTr4ylOpVUnfmvHK7VQvMDAsRD8Sfehj9GzXJvBGHGjxpjIuf2ZO6ob
         0sjQbNf+X+Up3E05NQNzeUfr7GZQUQqe4rTl7Lb/IJc5n/c0Fjav1R0DlrbLHGNtEe2g
         W2D78s0Roi2OByidEkC0a64YXx5KlfCtYtbOPXZk4MdK7yMeuN/zpx6P0k8p4XHxSMtP
         He7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WdBXRyf7ffYmk8ThiigR2f63EskcKRM4FARM3HWVzj0=;
        b=ulmK7pNj4RtiCpfos6O7L5WNuAlKoBAqJoxNjwTTdUMc+M0sG8wGUIxak2wX7niyLh
         L5cNmKUG1HEzae5ch0S1OmE84W9n5NJt4E4Xj8pPhDgVuky1KB9Y0mc4WcJVoG970/tc
         CJuGlnwWrFuX+Ca2H0qzwOcC44jQVlD71M8jmv84nk0HQXvRwQkXlYgak3fwyaQGCWVD
         I4ALNaOfpFUGpk06afA5maJAmR2g8IEyr37c5uq5C61U4vYsZnAyzlGcdtANx7B04vPn
         hAjhai6zNqz7L/aXt43hAiV/DaqKBGipDs9thohDTfSPv3EmZtRAvLLFsMKQvFO1QdEV
         ZpmQ==
X-Gm-Message-State: APjAAAUmYGA4ARqdAwIJXk/Q4ByY1Ale+FYadmIhiw3U26V9ZJFigAt1
        /amQUMpTQIddFCaiCFbQTNGy+AX135tIiVCLRm9VE4sbcns=
X-Google-Smtp-Source: APXvYqyshBbPgRmb8wznNI1GDwF7iBE3+VJ+XvbzYSKuZlepvT1HwMOrN58jKFN9RYaVE0MtUgZmZqczeEGRb04YjqM=
X-Received: by 2002:a67:f253:: with SMTP id y19mr1082817vsm.158.1581137309148;
 Fri, 07 Feb 2020 20:48:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com> <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
In-Reply-To: <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Fri, 7 Feb 2020 22:48:18 -0600
Message-ID: <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
> > Greetings,
> >
> > I'm resending, as this isn't showing in the archives. Perhaps it was
> > the attachments, which I've converted to pastebin links.
> >
> > As an update, I'm now running off of a different drive (ssd, not the
> > nvme) and I got the error again! I'm now inclined to think this might
> > not be hardware after all, but something related to my setup or a bug
> > with chromium.
> >
> > After a reboot, chromium wouldn't start for me and demsg showed
> > similar parent transid/csum errors to my original post below. I used
> > btrfs-inspect-internal to find the inode traced to
> > ~/.config/chromium/History. I deleted that, and got a new set of
> > errors tracing to ~/.config/chromium/Cookies. After I deleted that and
> > tried starting chromium, I found that my btrfs /home/jwhendy pool was
> > mounted ro just like the original problem below.
> >
> > dmesg after trying to start chromium:
> > - https://pastebin.com/CsCEQMJa
>
> So far, it's only transid bug in your csum tree.
>
> And two backref mismatch in data backref.
>
> In theory, you can fix your problem by `btrfs check --repair
> --init-csum-tree`.
>

Now that I might be narrowing in on offending files, I'll wait to see
what you think from my last response to Chris. I did try the above
when I first ran into this:
- https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazhyB95aha_D4=
WU_n15M59QrimrRg@mail.gmail.com/

> But I'm more interesting in how this happened.

Me too :)

> Have your every experienced any power loss for your NVME drive?
> I'm not say btrfs is unsafe against power loss, all fs should be safe
> against power loss, I'm just curious about if mount time log replay is
> involved, or just regular internal log replay.
>
> From your smartctl, the drive experienced 61 unsafe shutdown with 2144
> power cycles.

Uhhh, hell yes, sadly. I'm a dummy running i3 and every time I get
caught off gaurd by low battery and instant power-off, I kick myself
and mean to set up a script to force poweroff before that happens. So,
indeed, I've lost power a ton. Surprised it was 61 times, but maybe
not over ~2 years. And actually, I mis-stated the age. I haven't
*booted* from this drive in almost 2yrs. It's a corporate laptop,
issued every 3, so the ssd drive is more like 5 years old.

> Not sure if it's related.
>
> Another interesting point is, did you remember what's the oldest kernel
> running on this fs? v5.4 or v5.5?

Hard to say, but arch linux maintains a package archive. The nvme
drive is from ~May 2018. The archives only go back to Jan 2019 and the
kernel/btrfs-progs was at 4.20 then:
- https://archive.archlinux.org/packages/l/linux/

Searching my Amazon orders, the SSD was in the 2015 time frame, so the
kernel version would have been even older.

Thanks for your input,
John

>
> Thanks,
> Qu
> >
> > Thanks for any pointers, as it would now seem that my purchase of a
> > new m2.sata may not buy my way out of this problem! While I didn't
> > want to reinstall, at least new hardware is a simple fix. Now I'm
> > worried there is a deeper issue bound to recur :(
> >
> > Best regards,
> > John
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
> >
> > Edit: links now:
> > - btrfs check: https://pastebin.com/nz6Bc145
> > - dmesg: https://pastebin.com/1GGpNiqk
> > - smartctl: https://pastebin.com/ADtYqfrd
> >
> > btrfs dev stats (not worth a link):
> >
> > [/dev/mapper/old].write_io_errs    0
> > [/dev/mapper/old].read_io_errs     0
> > [/dev/mapper/old].flush_io_errs    0
> > [/dev/mapper/old].corruption_errs  0
> > [/dev/mapper/old].generation_errs  0
> >
> >
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
