Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A03A14358B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 03:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgAUCHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 21:07:02 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39463 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCHC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 21:07:02 -0500
Received: by mail-vs1-f68.google.com with SMTP id y125so794539vsb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 18:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OYXn7xogUAVoCZtubPCvZM6ajPL637xc1I3W6Vj4GR4=;
        b=gFbrldFbopgzQsKfI5W+rSOq6zJcMm1+Kp4SPwOOs525lVXjX3TDel6td+HTU+Yra4
         g22jlwUFZ7W2goorR4B1TErZczZ3fbrObk/r4ncyo664RUx08WpjwYxXgGvAgDgK/F5j
         I3i4lGO83AXadtHTBYZOGZHUs2itBjeAbj203eN0UlHvb52aK7Xo9ETaDlqLfHJVcVFP
         103U5wqQBfI/hzn5WuC6SeXbzFqPkoQy4JA1BL7Gv5YF1QXzESCzwBhxD+Xl/3ndS6My
         kV/nI81mmrerwBP+rmpEq8sqw8clQqRpVMCre+FwQ7+JA/poiu8eX9t4PhuP5FEbp5Dh
         IDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OYXn7xogUAVoCZtubPCvZM6ajPL637xc1I3W6Vj4GR4=;
        b=L9yzwwawOE6/X0WtUoBZLW//7QTrahXJ58rtQagyzNOhvHZAGjwu1Xl1aVnfvFOqal
         onknVVbYGBAibyKAYoS3AqiRPDnchQkcMWeIxwR/3sCjFiqRmHSAyL+9e73S0nyVmy8d
         RklT9uFNwcfQ9Sw1zuSIAZ5s0gaMd3mxIm68rqeJayNNkAtcr0gpo+HOjnHF44MPD5Jc
         ZOqC7CIbN/TkEaGfaLVx5BP2Kx84/ccCWvjLFrGiKPLsNsPwKCNwS3aA/20GpkNw0Mwu
         vFEdGAht386af0/YTUvgFWf1qfdDv5U78EElFNKXP7qSYUW9nlPmgqfN1KcUZGbd0sqI
         Hrhg==
X-Gm-Message-State: APjAAAVZlEop8QX9fYcvgm9AnQRimS1OcrFOXTEZ9FIlyScW1Gu0ftRS
        QMA/KKpoUTvhzyaPieVG8j6e/6o33ADRCIRjHc/EpIgn
X-Google-Smtp-Source: APXvYqxnXXcgRnwSJCy0GLox9Ir4cy4+lEIJJ1TvnqdLvIRDmXIBdoTDuG9yfP/VXAvLZS+eIqrBjcYnc2KghWjlw4U=
X-Received: by 2002:a05:6102:675:: with SMTP id z21mr1264179vsf.46.1579572420802;
 Mon, 20 Jan 2020 18:07:00 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com> <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
 <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com>
In-Reply-To: <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com>
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Tue, 21 Jan 2020 13:06:49 +1100
Message-ID: <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
Subject: Re: BTRFS failure after resume from hibernate
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 21 Jan 2020 at 12:49, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/21 =E4=B8=8A=E5=8D=889:39, Robbie Smith wrote:
> > On Tue, 21 Jan 2020 at 11:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2020/1/20 =E4=B8=8B=E5=8D=8810:45, Robbie Smith wrote:
> >>> I put my laptop into hibernation mode for a few days so I could boot
> >>> up into Windows 10 to do some things, and upon waking up BTRFS has
> >>> borked itself, spitting out errors and locking itself into read-only
> >>> mode. Is there any up-to-date information on how to fix it, short of
> >>> wiping the partition and reinstalling (which is what I ended up
> >>> resorting to last time after none of the attempts to fix it worked)?
> >>> The error messages in my journal are:
> >>>
> >>> BTRFS error (device dm-0): parent transid verify failed on
> >>> 223458705408 wanted 144360 found 144376
> >>
> >> The fs is already corrupted at this point.
> >>
> >>> BTRFS critical (device dm-0): corrupt leaf: block=3D223455346688 slot=
=3D23
> >>> extent bytenr=3D223451267072 len=3D16384 invalid generation, have 144=
376
> >>> expect (0, 144375]
> >>
> >> This is one newer tree-checker added in latest kernel.
> >>
> >> It can be fixed with btrfs check in this branch:
> >> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
> >>
> >> But that transid error can't be repair, so it doesn't make much sense.
> >>
> >>> BTRFS error (device dm-0): block=3D223455346688 read time tree block
> >>> corruption detected
> >>> BTRFS error (device dm-0): error loading props for ino 1032412 (root =
258): -5
> >>>
> >>> The parent transid messages are repeated a few times. There's nothing
> >>> fancy about my BTRFS setup: subvolumes are used to emulate my root an=
d
> >>> home partition. No RAID, no compression, though the partition does si=
t
> >>> beneath a dm-crypt layer using LUKS. Hibernation is done onto a
> >>> separate swap partion on the same drive.
> >>
> >> Please provide the output of "btrfs check" and kernel version.
> >
> > Here's the kernel and btrfs information:
> >
> >> # uname -a
> >> Linux rocinante 5.4.10-arch1-1 #1 SMP PREEMPT Thu, 09 Jan 2020 10:14:2=
9 +0000 x86_64 GNU/Linux
> >>
> >> # btrfs --version
> >> btrfs-progs v5.4
> >>
> >> # btrfs fi df /
> >> Data, single: total=3D541.01GiB, used=3D538.54GiB
> >> System, DUP: total=3D8.00MiB, used=3D80.00KiB
> >> Metadata, DUP: total=3D3.00GiB, used=3D1.56GiB
> >> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >>
> >> # btrfs fi show
> >> Label: 'rootfs'  uuid: 25ac1f63-5986-4eb8-920f-ed7a5354c076
> >>         Total devices 1 FS bytes used 540.11GiB
> >> devid    1 size 794.25GiB used 547.02GiB path /dev/mapper/cryptroot
> >
> > I tried a btrfs check and it failed almost immediately.
> >
> >> # btrfs check /dev/mapper/cryptroot
> >> Opening filesystem to check...
> >> ERROR: /dev/mapper/cryptroot is currently mounted, use --force if you =
really intend to check the filesystem
> >>
> >> # btrfs check --force /dev/mapper/cryptroot
> >> Opening filesystem to check...
> >> WARNING: filesystem mounted, continuing because of --force
> >> Checking filesystem on /dev/mapper/cryptroot
> >> UUID: 25ac1f63-5986-4eb8-920f-ed7a5354c076
> >> [1/7] checking root items
> >> parent transid verify failed on 223455674368 wanted 144355 found 14437=
6
> >> parent transid verify failed on 223455674368 wanted 144355 found 14437=
6
> >> parent transid verify failed on 223455674368 wanted 144355 found 14437=
6
> >> Ignoring transid failure
> >> parent transid verify failed on 223452872704 wanted 144358 found 14437=
6
> >> parent transid verify failed on 223452872704 wanted 144358 found 14437=
6
> >> parent transid verify failed on 223452872704 wanted 144358 found 14437=
6
> >> Ignoring transid failure
> >> ERROR: child eb corrupted: parent bytenr=3D223602655232 item=3D233 par=
ent level=3D1 child level=3D2
> >> ERROR: failed to repair root items: Input/output error
>
> The corruption looks happened on root tree. Which is mostly ensured to
> cause problem for next mount.
>
> It's highly recommended to start data salvage.
>
> >
> > I haven't rebooted the laptop, in case this issue makes the laptop
> > unbootable, but I could try re-running the check from a live USB and
> > an unmounted filesystem. My Arch Live USB is from June last year, and
> > it's got kernel 4.20 and btrfs-progs 4.19.1 on it=E2=80=94will they be =
new
> > enough, or should I fetch the latest Arch disk and flash a new one?
>
> I don't believe newer btrfs-progs can handle it at all.
> But you can still consider it as a last try.
>
> BTW did you have anything weird in dmesg?

dmesg is full of errors from journalctl because the filesystem is
read-only. Journalctl had paused after resume due to this, and I
thought I could catch newer messages by running it (isn't it supposed
to temporarily store logs in volatile storage?), and that made my
laptop completely die. Every program I had open segfaulted at once,
and now it's just spooling through dmesg with thousands (if not
millions) of lines about journalctl being unable to rotate the logs.
Amazingly enough, I'm still logged in remotely via ssh/mosh, but I
can't run any commands due to a bus error. I can't even su to root.

I guess I try rebooting it with a Live USB, and running the check
again, and if that fails, looks like I'll be spending my day
reinstalling everything. Do I have any better options? The only thing
that isn't backed up on this machine is my music collection, but
that's a local lossy copy generated from my lossless library on my
other machine, so I can recreate it if I need to (I'd rather not=E2=80=94if=
 I
can mount the fs readonly, I might be able to copy that to a separate
drive).

What on Earth could possibly cause BTRFS to fail so badly like this,
with this specific error? I've been using BTRFS for years without
problems, except this and the exact same error on the same machine six
months ago.

>
> >
> > In answer to Nikolay's questions, both Windows and Linux share a disk
> > but are on separate partitions, and Windows did update itself. I've
> > had Windows updates occur while Linux is hibernated before, and it has
> > no reason to touch a partition it can't read and never mounts.
>
> For the cause, I don't believe it's related to Windows, but the
> hibernation part.
>
> Not sure how hibernation would interact with fs, but my guess is it
> should at least sync the fs.
>
> Anyway, if something extra happened, dmesg should have some clue.
>
>
> Another possible cause is, some older (still v5.x) upstream kernel had
> some bug, e.g. before v5.2.15/v5.3 there is a bug in btrfs which could
> cause part of metadata not synced to disk, causing the same transid
> corruption.
>
> And since you're not rebooting, but only hibernate, the problem remains
> undetected until today...
>
> Thanks,
> Qu
>
> >
> > Robbie
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> This is the second time in six months this has happened on this
> >>> laptop. The only other thing I can think of is that the laptop BIOS
> >>> reported that the charger wasn't supplying the correct wattage, and I
> >>> have no idea why it would do that=E2=80=94both laptop and charger are=
 nearly
> >>> brand-new, less than a year old. The laptop model is a Lenovo Thinkpa=
d
> >>> T470.
> >>>
> >>> I've got backups, but reinstalling is a nuisance and I really don't
> >>> want to spend a couple of days getting the laptop working again. I
> >>> don't have a conveniently large drive lying around to mirror this one
> >>> onto.
> >>>
> >>> Robbie
> >>>
> >>
>
