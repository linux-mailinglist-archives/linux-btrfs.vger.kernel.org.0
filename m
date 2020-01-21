Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450401435CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAUC6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 21:58:52 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46550 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUC6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 21:58:51 -0500
Received: by mail-vs1-f68.google.com with SMTP id t12so816275vso.13
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 18:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YQRBFTCjAQ7l6tI5lZvH3o2jLAM8kSa4zgTDUsjc0Mo=;
        b=lpxkScfYIdQ1f4crO5S2EdOc/QPgZee0o7fkim7/5cPz1hV661g+OSdRnySa8UTW8E
         HVH3ZFjxD3LDsk9Mjr4hNiFxaESEGA03yMf/EFzXNJuV5DS4tDb02wVEaeJK3kXCNRgU
         C9jefZ+3uaxe3TccvYZseGeSoMbks53xMiQdn0NPo3WlJYpFPxSMDDqcm2W5h+F3+oCg
         lXFgx7ySSZuRyvszV1w48a1Z/dKWcrJy1EGSsrZmSvr3hIOvzpPjl0v1VO/np4gCNjNP
         UrK0XCXwJDD96qHlrUvOhSFl+Szvx5MHcZtnQZBDI2T7leWwKPAhSALK7ozTE+G1zvwB
         j/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=YQRBFTCjAQ7l6tI5lZvH3o2jLAM8kSa4zgTDUsjc0Mo=;
        b=KAuKbH4TYDgotvVQ2mIkAzSwIcpyNRiuukoB3LJx9PXuxTe3nwchtkYKuCBXWPPeB8
         UGdtyz1Nb/+EJgs7XuxjINabHYntKBCpYuv8OBu0uRPj99jHl/2DQlxbd9o1vIGjC7+p
         cJicRYIKwSRUE1sUgk38gnxMC9MQGCmhIN6e4tdKHzRTuyhpBrsNy1dhPk/PyCFmv6Sc
         ftzEr97WkRYx+EQvrpml3I3Rb7PkUx2pkWzkw8FtD8EJnjd401EiXwjwU2mq78PzTCpH
         /sbZaSQv+/kVYwwQvTKNwxdnb5Ls+1pOo2dfz7DhLLD5xTlWQhVg1AX4956gzbJck3ut
         xO0g==
X-Gm-Message-State: APjAAAU7QSBMPUzjVhu8xRnzmh7B74aYnqZRlpge+6Ti1q6hoEd5g0u9
        BDu6Mi2860miLUc8iNjU3Qbj88bQkAA5FRmRPcOhWmke
X-Google-Smtp-Source: APXvYqyiF1EhAxy6CLcV59ZRrugqoMIzhNCit2Ee1E46KhGtzVyXOauXpS7BUM5vIUJJQN41uo0MYQbXczm4fmqP1Rg=
X-Received: by 2002:a67:ee13:: with SMTP id f19mr1390701vsp.147.1579575529804;
 Mon, 20 Jan 2020 18:58:49 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com> <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
 <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com> <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
 <0949e592-6564-8617-4e8f-fda1e9bdcfb1@gmx.com>
In-Reply-To: <0949e592-6564-8617-4e8f-fda1e9bdcfb1@gmx.com>
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Tue, 21 Jan 2020 13:58:38 +1100
Message-ID: <CACurcBsdPYCba8SjvTRxToPkwKvy3Y_85+GhqV91uS51Tv4b4w@mail.gmail.com>
Subject: Re: BTRFS failure after resume from hibernate
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 21 Jan 2020 at 13:26, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/21 =E4=B8=8A=E5=8D=8810:06, Robbie Smith wrote:
> > On Tue, 21 Jan 2020 at 12:49, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2020/1/21 =E4=B8=8A=E5=8D=889:39, Robbie Smith wrote:
> >>> On Tue, 21 Jan 2020 at 11:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> >>>>
> >>>>
> >>>>
> >>>> On 2020/1/20 =E4=B8=8B=E5=8D=8810:45, Robbie Smith wrote:
> >>>>> I put my laptop into hibernation mode for a few days so I could boo=
t
> >>>>> up into Windows 10 to do some things, and upon waking up BTRFS has
> >>>>> borked itself, spitting out errors and locking itself into read-onl=
y
> >>>>> mode. Is there any up-to-date information on how to fix it, short o=
f
> >>>>> wiping the partition and reinstalling (which is what I ended up
> >>>>> resorting to last time after none of the attempts to fix it worked)=
?
> >>>>> The error messages in my journal are:
> >>>>>
> >>>>> BTRFS error (device dm-0): parent transid verify failed on
> >>>>> 223458705408 wanted 144360 found 144376
> >>>>
> >>>> The fs is already corrupted at this point.
> >>>>
> >>>>> BTRFS critical (device dm-0): corrupt leaf: block=3D223455346688 sl=
ot=3D23
> >>>>> extent bytenr=3D223451267072 len=3D16384 invalid generation, have 1=
44376
> >>>>> expect (0, 144375]
> >>>>
> >>>> This is one newer tree-checker added in latest kernel.
> >>>>
> >>>> It can be fixed with btrfs check in this branch:
> >>>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
> >>>>
> >>>> But that transid error can't be repair, so it doesn't make much sens=
e.
> >>>>
> >>>>> BTRFS error (device dm-0): block=3D223455346688 read time tree bloc=
k
> >>>>> corruption detected
> >>>>> BTRFS error (device dm-0): error loading props for ino 1032412 (roo=
t 258): -5
> >>>>>
> >>>>> The parent transid messages are repeated a few times. There's nothi=
ng
> >>>>> fancy about my BTRFS setup: subvolumes are used to emulate my root =
and
> >>>>> home partition. No RAID, no compression, though the partition does =
sit
> >>>>> beneath a dm-crypt layer using LUKS. Hibernation is done onto a
> >>>>> separate swap partion on the same drive.
> >>>>
> >>>> Please provide the output of "btrfs check" and kernel version.
> >>>
> >>> Here's the kernel and btrfs information:
> >>>
> >>>> # uname -a
> >>>> Linux rocinante 5.4.10-arch1-1 #1 SMP PREEMPT Thu, 09 Jan 2020 10:14=
:29 +0000 x86_64 GNU/Linux
> >>>>
> >>>> # btrfs --version
> >>>> btrfs-progs v5.4
> >>>>
> >>>> # btrfs fi df /
> >>>> Data, single: total=3D541.01GiB, used=3D538.54GiB
> >>>> System, DUP: total=3D8.00MiB, used=3D80.00KiB
> >>>> Metadata, DUP: total=3D3.00GiB, used=3D1.56GiB
> >>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >>>>
> >>>> # btrfs fi show
> >>>> Label: 'rootfs'  uuid: 25ac1f63-5986-4eb8-920f-ed7a5354c076
> >>>>         Total devices 1 FS bytes used 540.11GiB
> >>>> devid    1 size 794.25GiB used 547.02GiB path /dev/mapper/cryptroot
> >>>
> >>> I tried a btrfs check and it failed almost immediately.
> >>>
> >>>> # btrfs check /dev/mapper/cryptroot
> >>>> Opening filesystem to check...
> >>>> ERROR: /dev/mapper/cryptroot is currently mounted, use --force if yo=
u really intend to check the filesystem
> >>>>
> >>>> # btrfs check --force /dev/mapper/cryptroot
> >>>> Opening filesystem to check...
> >>>> WARNING: filesystem mounted, continuing because of --force
> >>>> Checking filesystem on /dev/mapper/cryptroot
> >>>> UUID: 25ac1f63-5986-4eb8-920f-ed7a5354c076
> >>>> [1/7] checking root items
> >>>> parent transid verify failed on 223455674368 wanted 144355 found 144=
376
> >>>> parent transid verify failed on 223455674368 wanted 144355 found 144=
376
> >>>> parent transid verify failed on 223455674368 wanted 144355 found 144=
376
> >>>> Ignoring transid failure
> >>>> parent transid verify failed on 223452872704 wanted 144358 found 144=
376
> >>>> parent transid verify failed on 223452872704 wanted 144358 found 144=
376
> >>>> parent transid verify failed on 223452872704 wanted 144358 found 144=
376
> >>>> Ignoring transid failure
> >>>> ERROR: child eb corrupted: parent bytenr=3D223602655232 item=3D233 p=
arent level=3D1 child level=3D2
> >>>> ERROR: failed to repair root items: Input/output error
> >>
> >> The corruption looks happened on root tree. Which is mostly ensured to
> >> cause problem for next mount.
> >>
> >> It's highly recommended to start data salvage.
> >>
> >>>
> >>> I haven't rebooted the laptop, in case this issue makes the laptop
> >>> unbootable, but I could try re-running the check from a live USB and
> >>> an unmounted filesystem. My Arch Live USB is from June last year, and
> >>> it's got kernel 4.20 and btrfs-progs 4.19.1 on it=E2=80=94will they b=
e new
> >>> enough, or should I fetch the latest Arch disk and flash a new one?
> >>
> >> I don't believe newer btrfs-progs can handle it at all.
> >> But you can still consider it as a last try.
> >>
> >> BTW did you have anything weird in dmesg?
> >
> > dmesg is full of errors from journalctl because the filesystem is
> > read-only. Journalctl had paused after resume due to this, and I
> > thought I could catch newer messages by running it (isn't it supposed
> > to temporarily store logs in volatile storage?), and that made my
> > laptop completely die. Every program I had open segfaulted at once,
> > and now it's just spooling through dmesg with thousands (if not
> > millions) of lines about journalctl being unable to rotate the logs.
> > Amazingly enough, I'm still logged in remotely via ssh/mosh, but I
> > can't run any commands due to a bus error. I can't even su to root.
>
> Well, when a fs get fully corrupted, everything can happen.
>
> >
> > I guess I try rebooting it with a Live USB, and running the check
> > again, and if that fails, looks like I'll be spending my day
> > reinstalling everything. Do I have any better options? The only thing
> > that isn't backed up on this machine is my music collection, but
> > that's a local lossy copy generated from my lossless library on my
> > other machine, so I can recreate it if I need to (I'd rather not=E2=80=
=94if I
> > can mount the fs readonly, I might be able to copy that to a separate
> > drive).
> >
> > What on Earth could possibly cause BTRFS to fail so badly like this,
> > with this specific error? I've been using BTRFS for years without
> > problems, except this and the exact same error on the same machine six
> > months ago.
>
> Really hard to say, there are at least 3 things related to this problem.
>
> - Btrfs itself
> - Hibernation
> - Dm-crypt (less possible)
>
> For btrfs, if you have used kernel between version v5.2.0 and v5.2.15,
> then it's possible the fs is already corrupted but not detected.
>
> For the hibernation part, Linux is not the best place to utilize it for
> the first place.
> (My ThinkPad X1 Carbon 6th suffers from hibernation, so I rarely use
> suspension/hiberation)
>
> Since linux development is mostly server oriented, such daily consumer
> operation may not be that well tested.
>
> Things like Windows updating certain firmware could break the controller
> behavior and cause unexpected behavior.
>
> So my personal recommendation is, to avoid hibernation/suspension, use
> Windows as little as possible.
>
> Thanks,
> Qu

Suspension works flawlessly for me, and hibernation usually does as
well. The one thing that has happened both times I've had a failure
has been something weird with the power: first time was a static shock
from walking on carpet and then touching the laptop, second time was
the BIOS reporting a wattage error with the charger.

I tried mounting the FS from a live USB and the mount said: "can't
read superblock on /dev/mapper/cryptroot" in addition to the transid
failures. Should I try running a `btrfs check --repair`? At this point
I'm pretty much resigned to reinstalling today, so I can't make things
any worse, can I?

I've also used kernel between version 5.2.0 and 5.2.15 on both my
machines, so does that mean there's a risk of undetected disk errors
on my desktop as well? I don't have backups of my backups, and all my
drives use BTRFS because I like the subvolume/snapshot features. I
also don't have a backup of my music/video library because I don't
have another 5 TB HDD.

>
> >
> >>
> >>>
> >>> In answer to Nikolay's questions, both Windows and Linux share a disk
> >>> but are on separate partitions, and Windows did update itself. I've
> >>> had Windows updates occur while Linux is hibernated before, and it ha=
s
> >>> no reason to touch a partition it can't read and never mounts.
> >>
> >> For the cause, I don't believe it's related to Windows, but the
> >> hibernation part.
> >>
> >> Not sure how hibernation would interact with fs, but my guess is it
> >> should at least sync the fs.
> >>
> >> Anyway, if something extra happened, dmesg should have some clue.
> >>
> >>
> >> Another possible cause is, some older (still v5.x) upstream kernel had
> >> some bug, e.g. before v5.2.15/v5.3 there is a bug in btrfs which could
> >> cause part of metadata not synced to disk, causing the same transid
> >> corruption.
> >>
> >> And since you're not rebooting, but only hibernate, the problem remain=
s
> >> undetected until today...
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Robbie
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>>
> >>>>> This is the second time in six months this has happened on this
> >>>>> laptop. The only other thing I can think of is that the laptop BIOS
> >>>>> reported that the charger wasn't supplying the correct wattage, and=
 I
> >>>>> have no idea why it would do that=E2=80=94both laptop and charger a=
re nearly
> >>>>> brand-new, less than a year old. The laptop model is a Lenovo Think=
pad
> >>>>> T470.
> >>>>>
> >>>>> I've got backups, but reinstalling is a nuisance and I really don't
> >>>>> want to spend a couple of days getting the laptop working again. I
> >>>>> don't have a conveniently large drive lying around to mirror this o=
ne
> >>>>> onto.
> >>>>>
> >>>>> Robbie
> >>>>>
> >>>>
> >>
>
