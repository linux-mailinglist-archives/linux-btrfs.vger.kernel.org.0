Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C871D7AA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfJOPzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:55:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35671 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfJOPzQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:55:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so20814420wmi.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1WtNY3KEXqNUNHMMHS5lQz/pQfzO5jjAW1M+wBnwTxE=;
        b=ZsdGT89iOMQyK3nvJ1b0OsosMFUPLvbPd/QZstdT+3R3mkncFWLiGY5wlpBoVbXypa
         h81Hz2RRo6Dx37z4qHattdLw5RxfJnWRFLyyWuMQu97g+ry+vmIiga+nBTvgMM7SAPb0
         TlfvrL/ZsKta1jlo54LZcbBr4rcAYJiXzUz8E9eYKq+wxWMf9xB40b8GECqWwFvlqqWz
         Vgwx8sqO79YfYZ0GMElHakGfSfddmREdJ6YmOPGidTqBJDyxZ0gkitcbK7pCI0YRsCZZ
         6nzXaLQgEHG+3iTJ92JFP9ok/e3mZe/B0+iL4Jur/4zsqndsV3u1J3P6LHMfIhQ+rWNM
         41PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1WtNY3KEXqNUNHMMHS5lQz/pQfzO5jjAW1M+wBnwTxE=;
        b=EyaIGJDF3CnaIirupV4PMTZ2pNacmoMD7QnxihsMchwfMrPrVne0JWHGKEz02NV6pC
         Ylp4aFzIe5amJoKt+dcXCS9Z7FiUpwkOW6rUIZjO08knFDK5KvMjyY/PRnDPJx62+ojr
         WUZ3qe3njglO/toJ3gJQexNoU9Hfn5I9I21aJmFZGAGFh+2gI/8DJMGM5mT056gSzvcJ
         ofOW8fmX3VEdyTcX8HWtEE+RC959MnxOdTI621iuJHcliO6JfKzJTpxyloDWIGcsPD8B
         2+b06moRN3bpcBPvELGBEPjJtS4c9ksNFqCZSGe5KbFUdA+6SIa5RgiaNlJXx2Czfchv
         t8jA==
X-Gm-Message-State: APjAAAWuRMtfGCiIAQrQPAmCeBAQ1XDeqYYbqHaD+FP4OgJabkk6ENAt
        ghSLf74OLYRshiORA1Atx9Vr13gEj2EbYZSVzYk=
X-Google-Smtp-Source: APXvYqz//W/zQCtNH7ntZ4kiIBPWaGXtYrkCK+8q56+7UvAi07OlS7UILcJR7iWOrdfF0V236mbzpQrxYJiP3McODe4=
X-Received: by 2002:a7b:cc8c:: with SMTP id p12mr19522261wma.167.1571154912975;
 Tue, 15 Oct 2019 08:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
 <66e27fee-7f64-6466-866d-42464fca130f@gmx.com> <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
 <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com> <3e7acddf-6503-7746-db4b-a116b7f89c4d@gmx.com>
In-Reply-To: <3e7acddf-6503-7746-db4b-a116b7f89c4d@gmx.com>
From:   =?UTF-8?Q?Jos=C3=A9_Luis?= <parajoseluis@gmail.com>
Date:   Tue, 15 Oct 2019 19:55:01 +0200
Message-ID: <CADTa+SoDEcHvpJj6-QMHUubFcKACiKLQ6izr=uER-hYtqVg20g@mail.gmail.com>
Subject: Re: kernel 5.2 read time tree block corruption
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I also noticed the craziness of the previous dump. I cannot remember
the kernel running by this date but I use to install the latest stable
kernel on the Manjaro repositories (I'm an early adopter :P).
According the Manjaro forum release news they roll up version 4.19 by
these days so probably I was using kernel 4.19 or 4.18. Diggin on my
memory, maybe I could access that filesystem from a Windows 10 running
on another disk using the windows btrfs driver that could be the
origin of the problem.

I added a \s to the pattern you provided to avoid undesired inode informati=
on:
[manjaro@manjaro ~]$ sudo btrfs ins dump-tree -t 5 /dev/sdb2 | grep "(431 "=
 -A 7
output --> https://pastebin.com/y3LzqNx6

Is there any magic command to repair my sdb2 filesystem? Or I have to
backup data and rebuild those filesystems?

Thanks Qu,
Jos=C3=A9 Luis

El mar., 15 oct. 2019 a las 15:25, Qu Wenruo
(<quwenruo.btrfs@gmx.com>) escribi=C3=B3:
>
>
>
> On 2019/10/15 =E4=B8=8B=E5=8D=8811:03, Jos=C3=A9 Luis wrote:
> > Thanks for fast response Qu.
> >
> > I booted into a pendrive live system for the test cause I'm using the
> > involving fylesystem with kernel 4.19. This time when I mount
> >> [manjaro@manjaro ~]$ sudo mount /dev/sdb2 /mnt
> >> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
> > and in the dmesg:
> > [ +30,866472] BTRFS info (device sdb2): disk space caching is enabled
> > [  +0,017443] BTRFS info (device sdb2): enabling ssd optimizations
> > [  +0,000637] BTRFS critical (device sdb2): corrupt leaf: root=3D5
> > block=3D32145457152 slot=3D99, invalid key objectid: has
> > 18446744073709551605 expect 6 or [256, 18446744073709551360] or
> > 18446744073709551604
> > [  +0,000002] BTRFS error (device sdb2): block=3D32145457152 read time
> > tree block corruption detected
> > [  +0,000012] BTRFS warning (device sdb2): failed to read fs tree: -5
> > [  +0,061995] BTRFS error (device sdb2): open_ctree failed
> >
> > So I suppose you need dump output from the block 32145457152 so I paste=
bin that:
> > sudo btrfs ins dump-tree -b 32145457152 /dev/sdb2
> > output --> https://pastebin.com/ssB5HTn7
>
> The output is way crazier than I thought...
>
> I was only expecting some strange inode number, but what I got is
> completely ridiculous.
>
> From item 96, we are having completely impossible inodes.
> From FREE_INO to DATA_RELOC, even EXTENT_CSUM.
>
> All of these are impossible to exist in fs tree.
> The most strange thing is, they are all last modified in 2019-2-15.
>
> Anyway, the tree-checker is doing completely valid behavior for this
> case. The data is really ridiculous.
>
> Any history about the kernel used in that time?
> I see something only possible in Windows, any clue?
>
> >
> > Please provide the parameter to the grep redirection for: "btrfs ins
> > dump-tree -t 5 /dev/sdb2 | grep -A 7"
>
> My bad, the parameter is "(431"
>
> It will output all info about inode 431, so we can make sure what's
> going wrong.
>
> Thanks,
> Qu
> >
> > El mar., 15 oct. 2019 a las 14:38, Qu Wenruo
> > (<quwenruo.btrfs@gmx.com>) escribi=C3=B3:
> >>
> >>
> >>
> >> On 2019/10/15 =E4=B8=8B=E5=8D=888:24, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2019/10/15 =E4=B8=8B=E5=8D=886:15, Jos=C3=A9 Luis wrote:
> >>>> Dear devs,
> >>>>
> >>>> I cannot use kernel >=3D 5.2, They cannot mount sdb2 nor sb3 both bt=
rfs
> >>>> filesystems. I can work as intended on 4.19 which is an LTS version,
> >>>> previously using 5.1 but Manjaro removed it from their repositories.
> >>>>
> >>>> More info:
> >>>> =C2=B7 dmesg:
> >>>>> [oct15 13:47] BTRFS info (device sdb2): disk space caching is enabl=
ed
> >>>>> [  +0,009974] BTRFS info (device sdb2): enabling ssd optimizations
> >>>>> [  +0,000481] BTRFS critical (device sdb2): corrupt leaf: root=3D5 =
block=3D30622793728 slot=3D115, invalid key objectid: has 18446744073709551=
605 expect 6 or [256, 18446744073709551360] or 18446744073709551604
> >>>
> >>> In fs tree, you are hitting a free space cache inode?
> >>> That doesn't sound good.
> >>>
> >>> Please provide the following dump:
> >>>
> >>> # btrfs ins dump-tree -b 30622793728 /dev/sdb2
> >>>
> >>> The output may contain filename, feel free to remove filenames.
> >>>
> >>>>> [  +0,000002] BTRFS error (device sdb2): block=3D30622793728 read t=
ime tree block corruption detected
> >>>>> [  +0,000021] BTRFS warning (device sdb2): failed to read fs tree: =
-5
> >>>>> [  +0,044643] BTRFS error (device sdb2): open_ctree failed
> >>>>
> >>>>
> >>>>
> >>>> =C2=B7 sudo mount  /dev/sdb2 /mnt/
> >>>>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
> >>>>
> >>>> (cannot read superblock on /dev...)
> >>>>
> >>>> =C2=B7 sudo btrfs rescue super-recover /dev/sdb2
> >>>>> All supers are valid, no need to recover
> >>>>
> >>>>
> >>>> =C2=B7 sudo btrfs check /dev/sdb2
> >>>>> Opening filesystem to check...
> >>>>> Checking filesystem on /dev/sdb2
> >>>>> UUID: ff559c37-bc38-491c-9edc-fa6bb0874942
> >>>>> [1/7] checking root items
> >>>>> [2/7] checking extents
> >>>>> [3/7] checking free space cache
> >>>>> cache and super generation don't match, space cache will be invalid=
ated
> >>>>> [4/7] checking fs roots
> >>>>> root 5 inode 431 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 755 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 2379 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 11721 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 12211 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 15368 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 35329 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 960427 errors 1040, bad file extent, some csum missing
> >>>>> root 5 inode 18446744073709551605 errors 2001, no inode item, link =
count wrong
> >>>>>         unresolved ref dir 256 index 0 namelen 12 name $RECYCLE.BIN=
 filetype 2 errors 6, no dir index, no inode ref
> >>>
> >>> Check is reporting the same problem of the inode.
> >>>
> >>> We need to make sure what's going wrong on that leaf, based on the
> >>> mentioned dump.
> >>>
> >>> For the csum missing error and bad file extent, it should be a big pr=
oblem.
> >>
> >> s/should/should not/
> >>
> >>> if you want to make sure what's going wrong, please provide the
> >>> following dump:
> >>>
> >>> # btrfs ins dump-tree -t 5 /dev/sdb2 | grep -A 7
> >>>
> >>> Also feel free the censor the filenames.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>>> root 388 inode 1245 errors 1040, bad file extent, some csum missing
> >>>>> root 388 inode 1288 errors 1040, bad file extent, some csum missing
> >>>>> root 388 inode 1292 errors 1040, bad file extent, some csum missing
> >>>>> root 388 inode 1313 errors 1040, bad file extent, some csum missing
> >>>>> root 388 inode 11870 errors 1040, bad file extent, some csum missin=
g
> >>>>> root 388 inode 68126 errors 1040, bad file extent, some csum missin=
g
> >>>>> root 388 inode 88051 errors 1040, bad file extent, some csum missin=
g
> >>>>> root 388 inode 88255 errors 1040, bad file extent, some csum missin=
g
> >>>>> root 388 inode 88455 errors 1040, bad file extent, some csum missin=
g
> >>>>> root 388 inode 88588 errors 1040, bad file extent, some csum missin=
g
> >>>>> root 388 inode 88784 errors 1040, bad file extent, some csum missin=
g
> >>>>> root 388 inode 88916 errors 1040, bad file extent, some csum missin=
g
> >>>>> ERROR: errors found in fs roots
> >>>>> found 37167415296 bytes used, error(s) found
> >>>>> total csum bytes: 33793568
> >>>>> total tree bytes: 1676722176
> >>>>> total fs tree bytes: 1540243456
> >>>>> total extent tree bytes: 81510400
> >>>>> btree space waste bytes: 306327457
> >>>>> file data blocks allocated: 42200928256
> >>>>>  referenced 52868354048
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> ---
> >>>>
> >>>> Regards,
> >>>> Jos=C3=A9 Luis.
> >>>>
> >>>
> >>
>
