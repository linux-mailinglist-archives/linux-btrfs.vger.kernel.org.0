Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4515FC7E
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2020 04:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBODr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 22:47:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33809 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbgBODr0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 22:47:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so11504093oig.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 19:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/UoqntjKHpUxoz4Rs4SnjTb57gN5X3yT8KD5c8wFJ4A=;
        b=Ucima4ugBrSl8+koLX/PYJwvBGYwOJNKqcCoT0X24poOYHN29YwJiDd/zlYwBrV1s3
         OPSsdryAEFS3OJ94AHCpZC2POq+Y+XhTm0n5wHdWHhxFA5uHiAaXsOt9mQEubG/VzEk5
         pLOGfdaYgSWjqKT+CvDwZSc/pZb4vOqzSSnYw4kC2Ki+lXhwqBCKNJ3mGeJTPCodhYou
         wV9zDmpKnWm8IhTEd1o113WdTZbFEy2PUSg1I1d5DgyI+2xEmrqXV8SwV83e9bcKeFwC
         uFgDzluE8gHRhOwQivzqM/CApycJuY/EwjnP/K2LKMRuvLw536FS0suCkrx/zW8BZ9Al
         DPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/UoqntjKHpUxoz4Rs4SnjTb57gN5X3yT8KD5c8wFJ4A=;
        b=k5Dy3H4tQtaBSJRRPXGWrZq+bLCZbZGfyUErRmQKlgYuZzsyJLrPfbtiw7mvhnV9ql
         fBnetE4jtKaEwcAyBIkI/whQ9SqWPIiu1q+XfJIZPG5qSYdTAf3O1oKPNHJAcxZRxpMj
         /mP8l+2DOSaMwC9T7wuuUsWuO0DXFqsRUyktA0O9nKAA0Wn481R9QbmFjJb5p5Ua/CBC
         RcNJ1prGQKGD8MqePD2Mv5b1wIySnXCmqZhQOV8fo7vCdN6ARi3UukWo6nRRg1XLwGXh
         GgzSP6VQAkaTEX9FzEN0UW9lOpfDFU2HOmKjVDQDJQVwQ9nGI1GWtuTBhESDRa6hHaf1
         fiNA==
X-Gm-Message-State: APjAAAXq9wWXmhMNxxasCErz0BdPRaRm10fAGSLDeJiRey43yyGoh/P1
        VOboAc//xFciqsYUDVz23+vkGZfGiw87zX0fGeIPwwvY
X-Google-Smtp-Source: APXvYqzSoEser91LvSAT2Cplang/lQinUJg+9qW98eZWvogtsYm4Q/fJiCFP+NQY0s37vKKN44yQwA6FH043hpG3raI=
X-Received: by 2002:aca:4ace:: with SMTP id x197mr4135324oia.23.1581738445017;
 Fri, 14 Feb 2020 19:47:25 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com> <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com> <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com> <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
 <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com> <CAEOGEKGgA7-3CsjYhgZJdZjzHPJNQ9xZETjjZwAoNh_efeetAA@mail.gmail.com>
 <49cc4e6d-07c0-aea0-e753-6a6262e4dedb@gmx.com> <CAEOGEKHARKKSYMEU5kbswA7-PjxT9xAOomktG32h9RS6aYUVjA@mail.gmail.com>
 <8d8be3c5-e186-d1d5-c270-da22c61f1495@gmx.com>
In-Reply-To: <8d8be3c5-e186-d1d5-c270-da22c61f1495@gmx.com>
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Sat, 15 Feb 2020 11:47:13 +0800
Message-ID: <CAEOGEKHrN_i2fSb=iWY3yCLRjCuU1Hn08trCyg0Br9fJasjK6A@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu

Thanks for your reply. That's really helpful. BTW, I just read this url and
the mail thread in it. https://unix.stackexchange.com/a/345972
It seems to say if raid1 is degraded and even if rw, it should not be appli=
ed
any operations other than btrfs-replace or btrfs-balance.

Does it mean the degraded raid1 should not be used with both
btrfs-replace/balance and the original server rw services at the meantime?

For example, I put PostgreSQL DB on btrfs raid1 and I though one of raid1
two copies is my backup. Even if I lost one copy, the service still can kee=
p
running by another one immediately. Okay, maybe not immediately. I need
to reboot. But waiting 24 hours or longer which depends on the size of data
for the completion of btrfs-replace/balance seems not to be a good idea.

Regards,
Chiung-Ming Huang

Regards,
Chiung-Ming Huang


Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 2020/2/10 =E4=B8=8B=E5=8D=882:50, Chiung-Ming Huang wrote:
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >>
> >>
> >> On 2020/2/7 =E4=B8=8B=E5=8D=882:16, Chiung-Ming Huang wrote:
> >>> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>>>
> >>>> All these subvolumes had a missing root dir. That's not good either.
> >>>> I guess btrfs-restore is your last chance, or RO mount with my
> >>>> rescue=3Dskipbg patchset:
> >>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D1707=
15
> >>>>
> >>>
> >>> Is it possible to use original disks to keep the restored data safely=
?
> >>> I would like
> >>> to restore the data of /dev/bcache3 to the new btrfs RAID0 at the fir=
st and then
> >>> add it to the new btrfs RAID0. Does `btrfs restore` need metadata or =
something
> >>> in /dev/bcache3 to restore /dev/bcache2 and /dev/bcache4?
> >>
> >> Devid 1 (bcache 2) seems OK to be missing, as all its data and metadat=
a
> >> are in RAID1.
> >>
> >> But it's strongly recommended to test without wiping bcache2, to make
> >> sure btrfs-restore can salvage enough data, then wipeing bcache2.
> >>
> >> Thanks,
> >> Qu
> >
> > Is it possible to shrink the size of bcache2 btrfs without making
> > everything worse?
> > I need more disk space but I still need bcache2 itself.
>
> That is kinda possible, but please keep in mind that, even in the best
> case, it still needs to write some (very small amount) metadata into the
> fs, thus I can't ensure it won't make things worse, or even possible
> without falling back to RO.
>
> You need to dump the device extent tree, to determine the where the last
> dev extent is for each device, then shrink to that size.
>
> Some example here:
>
> # btrfs ins dump-tree -t dev /dev/nvme/btrfs
> ...
>
>         item 6 key (1 DEV_EXTENT 2169503744) itemoff 15955 itemsize 48
>                 dev extent chunk_tree 3
>                 chunk_objectid 256 chunk_offset 2169503744 length 1073741=
824
>                 chunk_tree_uuid 00000000-0000-0000-0000-000000000000
>
> Here for the key, 1 means devid 1, 2169503744 means where the device
> extent starts at. 1073741824 is the length of the device extent.
>
> In above case, the device with devid 1 can be resized to 2169503744 +
> 1073741824, without relocating any data/metadata.
>
> # time btrfs fi resize 1:3243245568 /mnt/btrfs/
> Resize '/mnt/btrfs/' of '1:3243245568'
>
> real    0m0.013s
> user    0m0.006s
> sys     0m0.004s
>
> And the dump-tree shows the same last device extent:
> ...
>         item 6 key (1 DEV_EXTENT 2169503744) itemoff 15955 itemsize 48
>                 dev extent chunk_tree 3
>                 chunk_objectid 256 chunk_offset 2169503744 length 1073741=
824
>                 chunk_tree_uuid 00000000-0000-0000-0000-000000000000
>
> (Maybe it's a good time to implement some like fast shrink for btrfs-prog=
s)
>
> Of course, after resizing btrfs, you still need to resize bcache, but
> that's not related to btrfs (and I am not familiar with bcache either).
>
> Thanks,
> Qu
>
> >
> > Regards,
> > Chiung-Ming Huang
> >
> >
> >>>
> >>> /dev/bcache2, ID: 1
> >>>    Device size:             9.09TiB
> >>>    Device slack:              0.00B
> >>>    Data,RAID1:              3.93TiB
> >>>    Metadata,RAID1:          2.00GiB
> >>>    System,RAID1:           32.00MiB
> >>>    Unallocated:             5.16TiB
> >>>
> >>> /dev/bcache3, ID: 3
> >>>    Device size:             2.73TiB
> >>>    Device slack:              0.00B
> >>>    Data,single:           378.00GiB
> >>>    Data,RAID1:            355.00GiB
> >>>    Metadata,single:         2.00GiB
> >>>    Metadata,RAID1:         11.00GiB
> >>>    Unallocated:             2.00TiB
> >>>
> >>> /dev/bcache4, ID: 5
> >>>    Device size:             9.09TiB
> >>>    Device slack:              0.00B
> >>>    Data,single:             2.93TiB
> >>>    Data,RAID1:              4.15TiB
> >>>    Metadata,single:         6.00GiB
> >>>    Metadata,RAID1:         11.00GiB
> >>>    System,RAID1:           32.00MiB
> >>>    Unallocated:             2.00TiB
> >>>
> >>> Regards,
> >>> Chiung-Ming Huang
> >>>
> >>
>
