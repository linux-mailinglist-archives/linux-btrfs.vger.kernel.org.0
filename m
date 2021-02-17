Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3507431DBB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhBQOv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 09:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhBQOv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 09:51:58 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E0AC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 06:51:18 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id k4so14017567ybp.6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ie/XaMEy4ZTh4VJXrmO+nS06Ctr/K68rOilHKWX2ZR0=;
        b=h3dUQvNPIwxcfG9niyLKrN76ImxYovHOQTG2IyATlM28JjonsLu1Pj3EpfZS3CKZyu
         tWbtzxkOPFKwwuMtt+FR8ULo2TO/Kbh3IsrsDsc6t0MUfK6+fu1Gp45LR/q7mULX2CGZ
         8J9SixflCU9wfWYsN8kg1kQVdTJXEVEGS2EeBYZNlCIRg9GgKajlditKbA3wbusf5nDW
         RodwprUHXgDOO1eDcuJ03od+aTIVMP9kTO2qcHiqkWe5+GtvAv7kXUlr5BeYiZ2OOUxe
         nM6Vu1CKLPIKt1d9/WoKwdrfxa2/cJpQUP8Gr3csZ2OzZEuJu+2qBE4Tc0hV8CCiJ6O3
         ZzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ie/XaMEy4ZTh4VJXrmO+nS06Ctr/K68rOilHKWX2ZR0=;
        b=gGeXAZovU8FCsr0PLhD3zJZv0metQdOpaTcOLobSzLYmtBL8Hr3NydGKqvG7p/pD/t
         +uXB1qwgghtmWepk5EdUFO3qDlOmqKgEli3rDZHQ0TSQtQ6bsnGicPdoM8uGSafnCARt
         DPcWCOFYdAQCk9iyQmVRGptqb9RAabU03yzyJxD0qHuUPCQgzeS+JkuPuIEC1uTsA39q
         ti+NxRGRc9QwTVa6HKH+X9d46VE6l9855p6uG1jrUUuMbm5EzCP1tPjL5sLVxaqER48H
         adti0piNt7U7OPXujnuKH9MWw8p5cc7NdSFTOgXt2IHjVViL5UINhEYVv7u6gwuEJ43l
         lwUQ==
X-Gm-Message-State: AOAM530G2w83p/yd7zZLXNgrK4jF7yNW1DOFaS8AnJw7PDHxYOKinllJ
        Lj+IOmlqo0fP4X8DYPd8lEsD8u5HYuZDbPmb1HTZiFcoTjVxXg==
X-Google-Smtp-Source: ABdhPJzPhxR4d0yFPjpLA0x1EkrbFTocHQTLf/WMuLr7LsCj0ILnZ4hmMAqYBLtPluhJAMce/b5oBM6/6w82AhHbCjw=
X-Received: by 2002:a25:46d6:: with SMTP id t205mr20034455yba.47.1613573477312;
 Wed, 17 Feb 2021 06:51:17 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com> <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com> <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com> <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com>
In-Reply-To: <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 17 Feb 2021 09:50:41 -0500
Message-ID: <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/16/21 9:05 PM, Neal Gompa wrote:
> > On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wr=
ote:
> >>>>
> >>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >>>>>>
> >>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>> Hey all,
> >>>>>>>
> >>>>>>> So one of my main computers recently had a disk controller failur=
e
> >>>>>>> that caused my machine to freeze. After rebooting, Btrfs refuses =
to
> >>>>>>> mount. I tried to do a mount and the following errors show up in =
the
> >>>>>>> journal:
> >>>>>>>
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3):=
 disk space caching is enabled
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3):=
 has skinny extents
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sd=
a3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, inv=
alid inode transid: has 888896 expect [0, 888895]
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3)=
: block=3D796082176 read time tree block corruption detected
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sd=
a3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, inv=
alid inode transid: has 888896 expect [0, 888895]
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3)=
: block=3D796082176 read time tree block corruption detected
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda=
3): couldn't read tree root
> >>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3)=
: open_ctree failed
> >>>>>>>
> >>>>>>> I've tried to do -o recovery,ro mount and get the same issue. I c=
an't
> >>>>>>> seem to find any reasonably good information on how to do recover=
y in
> >>>>>>> this scenario, even to just recover enough to copy data off.
> >>>>>>>
> >>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 a=
nd
> >>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14=
. I'm
> >>>>>>> using btrfs-progs v5.10.
> >>>>>>>
> >>>>>>> Can anyone help?
> >>>>>>
> >>>>>> Can you try
> >>>>>>
> >>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>
> >>>>>> That should fix the inode generation thing so it's sane, and then =
the tree
> >>>>>> checker will allow the fs to be read, hopefully.  If not we can wo=
rk out some
> >>>>>> other magic.  Thanks,
> >>>>>>
> >>>>>> Josef
> >>>>>
> >>>>> I got the same error as I did with btrfs-check --readonly...
> >>>>>
> >>>>
> >>>> Oh lovely, what does btrfs check --readonly --backup do?
> >>>>
> >>>
> >>> No dice...
> >>>
> >>> # btrfs check --readonly --backup /dev/sda3
> >>>> Opening filesystem to check...
> >>>> parent transid verify failed on 791281664 wanted 888893 found 888895
> >>>> parent transid verify failed on 791281664 wanted 888893 found 888895
> >>>> parent transid verify failed on 791281664 wanted 888893 found 888895
> >>
> >> Hey look the block we're looking for, I wrote you some magic, just pul=
l
> >>
> >> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>
> >> build, and then run
> >>
> >> btrfs-neal-magic /dev/sda3 791281664 888895
> >>
> >> This will force us to point at the old root with (hopefully) the right=
 bytenr
> >> and gen, and then hopefully you'll be able to recover from there.  Thi=
s is kind
> >> of saucy, so yolo, but I can undo it if it makes things worse.  Thanks=
,
> >>
> >
> > # btrfs check --readonly /dev/sda3
> >> Opening filesystem to check...
> >> ERROR: could not setup extent tree
> >> ERROR: cannot open file system
> > # btrfs check --clear-space-cache v1 /dev/sda3
> >> Opening filesystem to check...
> >> ERROR: could not setup extent tree
> >> ERROR: cannot open file system
> >
> > It's better, but still no dice... :(
> >
> >
>
> Hmm it's not telling us what's wrong with the extent tree, which is annoy=
ing.
> Does mount -o rescue=3Dall,ro work now that the root tree is normal?  Tha=
nks,
>

Nope, I see this in the journal:

> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): enabling=
 all of the rescue options
> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring=
 data csums
> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring=
 bad roots
> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disablin=
g log replay at mount time
> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disk spa=
ce caching is enabled
> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): has skin=
ny extents
> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree le=
vel mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree le=
vel mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3): could=
n't read tree root
> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): open_ct=
ree failed





--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
