Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7407B143541
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 02:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAUBj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 20:39:28 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43180 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUBj2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 20:39:28 -0500
Received: by mail-vs1-f68.google.com with SMTP id s16so747798vsc.10
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 17:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=c3Rr6gMe3mjAs3OqtYLbhZCRLyefiwD6jKhnO77WD48=;
        b=dWbVNP905xp6/jv+PFEPBOAdbvED0neRo7/6sxOjjSbn1PzKX4EkWb3H6ZRQcsneu7
         pnnrraQtv8MF1IuGDvYNnkTgaIGDoP/N/03/dbyXMxBDa9BJu4U3t2KlqhRjGZIxeH3f
         fOelEVHtdrD9to+RoF8cKRCJSqSN7ZT/N3PHvSVEGOn0a79mCItENVCMB8LHXH6hj0np
         38rH2p9/idQFnmFRxy+h6KRqf/1Px7Yf2H7N1gpYfJUAcx+t94xJWDglq4COY3I2ypN0
         E0numc5TymtNYfPGdFINNlW/JpFflKO39emW2S1+jw8flZMb3bIWJ1BX3AcG/M3sQ891
         YwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=c3Rr6gMe3mjAs3OqtYLbhZCRLyefiwD6jKhnO77WD48=;
        b=bpuNWGAN2WrJglwOuteNayjMxQxBvjTaHHWTYA1CkwCGHC4whWs8DG0kd6U2Vx7gD6
         mCBWGRbEAnoWajSaKj+V/snwGyEVxjK1Z4T2+F7wfpAP+NqEldlBTzfLsiLn/DNwicLE
         ft32zg0WpuyEA9ujp9Feg2ytmIPGzmNRumEjKYRlmddo/WBiMpZmhYxS9NfWggFV8H/W
         LHe51blfEbZqTDBXUBiVR7zHtHyymIaNFG0mUfnrMbUTo1nY3V1Y6F9aI3wZvjQY0U99
         S9DrP/MaPGq9KL08O24D0uGts6C5oxezKcERnhFPtSxKUuZHSMzlS1aANqr3pFcqCDAw
         kBSA==
X-Gm-Message-State: APjAAAVxG9ePuEzGl2h0/1DUMXl6Ec00yzZjk+BfcTgIqdi1LDdCEu6p
        UsdI8wWI6vgULCTozDQ+NgIS5pWM27jyY01SOZJP6ttHe0Y=
X-Google-Smtp-Source: APXvYqwXaluiCKrpB2xJMtenfYZnXEnApBc7+2HhCvhhhVoVQZqm94P8SbrrxmjFRg6r2B86s9BGI0TR2QMxij2x8c4=
X-Received: by 2002:a67:ee13:: with SMTP id f19mr1259933vsp.147.1579570766401;
 Mon, 20 Jan 2020 17:39:26 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com>
In-Reply-To: <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com>
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Tue, 21 Jan 2020 12:39:15 +1100
Message-ID: <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
Subject: Re: BTRFS failure after resume from hibernate
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 21 Jan 2020 at 11:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/20 =E4=B8=8B=E5=8D=8810:45, Robbie Smith wrote:
> > I put my laptop into hibernation mode for a few days so I could boot
> > up into Windows 10 to do some things, and upon waking up BTRFS has
> > borked itself, spitting out errors and locking itself into read-only
> > mode. Is there any up-to-date information on how to fix it, short of
> > wiping the partition and reinstalling (which is what I ended up
> > resorting to last time after none of the attempts to fix it worked)?
> > The error messages in my journal are:
> >
> > BTRFS error (device dm-0): parent transid verify failed on
> > 223458705408 wanted 144360 found 144376
>
> The fs is already corrupted at this point.
>
> > BTRFS critical (device dm-0): corrupt leaf: block=3D223455346688 slot=
=3D23
> > extent bytenr=3D223451267072 len=3D16384 invalid generation, have 14437=
6
> > expect (0, 144375]
>
> This is one newer tree-checker added in latest kernel.
>
> It can be fixed with btrfs check in this branch:
> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>
> But that transid error can't be repair, so it doesn't make much sense.
>
> > BTRFS error (device dm-0): block=3D223455346688 read time tree block
> > corruption detected
> > BTRFS error (device dm-0): error loading props for ino 1032412 (root 25=
8): -5
> >
> > The parent transid messages are repeated a few times. There's nothing
> > fancy about my BTRFS setup: subvolumes are used to emulate my root and
> > home partition. No RAID, no compression, though the partition does sit
> > beneath a dm-crypt layer using LUKS. Hibernation is done onto a
> > separate swap partion on the same drive.
>
> Please provide the output of "btrfs check" and kernel version.

Here's the kernel and btrfs information:

> # uname -a
> Linux rocinante 5.4.10-arch1-1 #1 SMP PREEMPT Thu, 09 Jan 2020 10:14:29 +=
0000 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.4
>
> # btrfs fi df /
> Data, single: total=3D541.01GiB, used=3D538.54GiB
> System, DUP: total=3D8.00MiB, used=3D80.00KiB
> Metadata, DUP: total=3D3.00GiB, used=3D1.56GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> # btrfs fi show
> Label: 'rootfs'  uuid: 25ac1f63-5986-4eb8-920f-ed7a5354c076
>         Total devices 1 FS bytes used 540.11GiB
> devid    1 size 794.25GiB used 547.02GiB path /dev/mapper/cryptroot

I tried a btrfs check and it failed almost immediately.

> # btrfs check /dev/mapper/cryptroot
> Opening filesystem to check...
> ERROR: /dev/mapper/cryptroot is currently mounted, use --force if you rea=
lly intend to check the filesystem
>
> # btrfs check --force /dev/mapper/cryptroot
> Opening filesystem to check...
> WARNING: filesystem mounted, continuing because of --force
> Checking filesystem on /dev/mapper/cryptroot
> UUID: 25ac1f63-5986-4eb8-920f-ed7a5354c076
> [1/7] checking root items
> parent transid verify failed on 223455674368 wanted 144355 found 144376
> parent transid verify failed on 223455674368 wanted 144355 found 144376
> parent transid verify failed on 223455674368 wanted 144355 found 144376
> Ignoring transid failure
> parent transid verify failed on 223452872704 wanted 144358 found 144376
> parent transid verify failed on 223452872704 wanted 144358 found 144376
> parent transid verify failed on 223452872704 wanted 144358 found 144376
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D223602655232 item=3D233 parent=
 level=3D1 child level=3D2
> ERROR: failed to repair root items: Input/output error

I haven't rebooted the laptop, in case this issue makes the laptop
unbootable, but I could try re-running the check from a live USB and
an unmounted filesystem. My Arch Live USB is from June last year, and
it's got kernel 4.20 and btrfs-progs 4.19.1 on it=E2=80=94will they be new
enough, or should I fetch the latest Arch disk and flash a new one?

In answer to Nikolay's questions, both Windows and Linux share a disk
but are on separate partitions, and Windows did update itself. I've
had Windows updates occur while Linux is hibernated before, and it has
no reason to touch a partition it can't read and never mounts.

Robbie
>
> Thanks,
> Qu
>
> >
> > This is the second time in six months this has happened on this
> > laptop. The only other thing I can think of is that the laptop BIOS
> > reported that the charger wasn't supplying the correct wattage, and I
> > have no idea why it would do that=E2=80=94both laptop and charger are n=
early
> > brand-new, less than a year old. The laptop model is a Lenovo Thinkpad
> > T470.
> >
> > I've got backups, but reinstalling is a nuisance and I really don't
> > want to spend a couple of days getting the laptop working again. I
> > don't have a conveniently large drive lying around to mirror this one
> > onto.
> >
> > Robbie
> >
>
