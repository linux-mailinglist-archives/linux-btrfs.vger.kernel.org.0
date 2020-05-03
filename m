Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6347D1C293F
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgECAkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 20:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726570AbgECAkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 20:40:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD798C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 17:40:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e20so5742694otk.12
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+f6Rl2yClYI6q6C4PTmmKq0H4Y2Ol5FMle4UupFzRlY=;
        b=WriWNVhUrJFXdiI9j0PSdspyN/DEIjIAlk6LBMF8Y300XO1SmDf/IO2QVdIF4H9FZA
         e6Ov5pQhTcQKjeYIQZ9J/fsXedWsd2OdNe5fGeeCLlMg2CI9f+uElaburhcA3LpBJGW5
         C+CU+uDgHraGAcYOG10fAnc//kdeW2FlSlqDhcqmlW8bBoka0czxs5JX9RC+QsRY+LLM
         cXaOOv09NNwJwEpLaUdNyySn5oKhAtMbJDIs8Dp9XCfoUr9KPVU99c3Eiq34SNHetzTp
         ZzWOHA27TjS5EWI4bc9wWgpsQsAIpRGg1EIDxJQ7vNe6CY4IxzA5LR07WdZcmI8OgUr5
         QLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+f6Rl2yClYI6q6C4PTmmKq0H4Y2Ol5FMle4UupFzRlY=;
        b=YEJ5yrIjY+dLtlrPx34UVXQmi1895qYaJNwVyixgcGW4nGFu0BVB+/ncljiVG+DWjb
         TgIjJV0rKsyhVI3mCbgn5rWZgNSr/DiOW+NBZH3Yo3/P4xw7e//t0DbRyVrlm3AQrVx+
         6b2zKAUpJWd+XaUgsDqbC4an+FLIA+9yJLpPZ/7Qc/yi/Y5M2ZJoYP2y7PS1veowS+rv
         pV0xeuaN0UwxqMu8R/FGg3425/Z88tpECkaiLK4QO1jOKYQaUpHrnjG3HNdzbK6Q4ocn
         5S4YHD7A9M0yAPY3TKN6tqyeAvjIhG/tHMHhGz5kyqjqshP+BR7YjJyXOoKbYIxX0yJl
         qM7A==
X-Gm-Message-State: AGi0PuZAiW8gAZIbx2BNSpXrXa5CIF3xIgZ/HmUN3njYMhVePtuPrWeX
        NDbKKblloICB+HCtvabKmJtuc6UHxGl6lMS/pdybyBJH0gg=
X-Google-Smtp-Source: APiQypIEtWI+ZdZaEhhIxNURXRwwtCC55/O7I6lXwP74cI+Mmyfyt+ImMmNEI2uDl5W4OjhcLj0kzeYzNllVEGcgvto=
X-Received: by 2002:a05:6830:108b:: with SMTP id y11mr8872135oto.88.1588466440948;
 Sat, 02 May 2020 17:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhjAp1zrjrizrswo3BF1-cTXArpZ5XFUPbd-OR_Nu1N05pdSQ@mail.gmail.com>
 <20200501023029.GD10769@hungrycats.org> <CAAhjAp0xitJN0S7T9DPEO84ELAYyWi1-k7ZRZSd1vddT4ozbTA@mail.gmail.com>
 <20200502055654.GJ10769@hungrycats.org>
In-Reply-To: <20200502055654.GJ10769@hungrycats.org>
From:   Rollo ro <rollodroid@gmail.com>
Date:   Sun, 3 May 2020 02:40:05 +0200
Message-ID: <CAAhjAp1mg-KF+YY=y_t-KEYHp-0uST84vS1z1=mEG858DzWX4w@mail.gmail.com>
Subject: Re: raid56 write hole
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Sa., 2. Mai 2020 um 07:56 Uhr schrieb Zygo Blaxell
<ce3g8jdj@umail.furryterror.org>:
>
> On Fri, May 01, 2020 at 03:57:20PM +0200, Rollo ro wrote:
> > Am Fr., 1. Mai 2020 um 04:30 Uhr schrieb Zygo Blaxell
> > <ce3g8jdj@umail.furryterror.org>:


>
> None of the superblocks are updated before all of the new trees are
> flushed.  So either the old or new state is acceptable.  I believe the
> current btrfs implementation will try to choose the newer one.
>

Yes I understood that first the trees are finished and only after that
the superblocks updated to point to the new tree version. But now this
superblockupdate write command is sent to both drives. Drive 1 writes
it correctly but drive 2 has problems and keeps trying for 7 seconds
(depending on drive model and settings) before it will report an
error. Now a power outage hits in this 7 seconds period. On the next
boot we have drive 1 with the new version and drive 2 with the old
version. Drive 2 could be updated with information from drive 1, but
we lost redundancy then. Hence, I'd let both drives use the old
version. It seems acceptable for me to lose the very last writes.

> If all your drives lie about completing flushes, unrecoverable data loss
> may occur.  If only one of your drives lies, btrfs will repair (*) any lost
> data on the bad drive by copying it from the good drive.
>
> (*) except nodatasum data and data with a csum collision between good and
> bad data.
>

Is this a thing in real drives? And if yes, how can one find out which
drive models are affected?


>
> If a superblock write fails, it either leaves old data (with an old transid)
> or it fails a csum check (and the whole device is likely ignored).  Picking
> the highest transid with a valid superblock csum would suffice.

Yes, hence I think it's not a good idea to write it all the time. I
noticed that there are other attributes that need to be updated
frequently, but think that should be in what I called candidates. The
superblock is ideally written only once during filesystem creation and
for repairing if needed, and contains two (or more) addresses to go
on. The roots at these two (or more) addresses are then written
alternately.

>
> If the superblocks have the same generation but different addresses that's
> a bug in btrfs, or both halves of split-brain raid1 were reunited after
> they were mounted separately.  btrfs doesn't handle the latter case
> at all well--it destroys the filesystem.

Good to know. At least that can't happen by itself, because it won't
mount without the degraded option.

>  mdadm has a solution there,
> they put a timestamp (a random nonce will do) on each drive so that a
> reunited split-brain raid1 won't come online with both drives.
>

>
> As far as I know, no.  It's typically used in cases where the latest root
> passes sanity checks but turns out to be bad later on.
>

>
> Writes can continue on all drives as long as 1) superblocks always
> refer to fully complete trees, 2) superblocks are updated in lockstep,
> at most one transid apart, and 3) when userspace explicitly requests
> synchronization (e.g. fsync), the call blocks until the associated trees
> and superblocks are completely flushed on all drives.
>
> Note that this relies on the CoW update mechanism, so there is no
> guarantee of data integrity with nodatacow files (they do have write
> hole problems at every raid level).
>
> In the kernel it's a bit less flexible--there's only one active
> transaction per filesystem, and it must fully complete before a new
> transaction can begin.  This results in latency spikes around the
> commit operation.
>

>
> The write ordering does cover crash and power outage.  What else could it
> be for?  Mounting with -o nobarrier turns off the write ordering, and
> makes the filesystem unlikely to survive a power failure.

That's clear. If we want the sequence:
Write some data on disk --> Write the data's address into superblock
a drive could change the sequence to save time and then there is a
period during that the data is missing. To prevent that, we do:
Write some data on disk --> barrier --> Write the data's address into superblock

But it doesn't help if we have two drives and one finishes the
sequence, but the other drive not, because of power outage.

>
> During kernel and hardware qualification tests we hook up a prospective
> new server build to a software-controlled power switch and give it 50
> randomly-spaced power failures a week.  It has to run btrfs stress
> tests for a month to pass.
>

That will in most cases miss a problem that the system is vulnerable
to for 10ms every 10s for example. Good test, though.

>
> Maybe it does, but upstream btrfs doesn't use it.
>
>
> If you have enough drives in your topology, you can join the devices in
> the same failure domain together as mdadm or lvm JBOD devices and then
> btrfs raid1 the JBOD arrays.
>

Good idea!

> > So for now, I'll be limited to 4 drives
> > and if I need more, I'll probalby get an additional PCIe SATA card.
>
> Usually I trace that kind of problem back to the power supply, not
> the SATA card.  Sure, there are some terrible SATA controller chips out
> there, but even good power supplies will turn bad after just a few years.
> We replace power supplies on a maintenance schedule whether they are
> failing or not.
>
> Sometimes when spinning drives fail, they pull down hard on power rails
> or even feed kinetic energy from the motors back into the power supply.
> This can disrupt operation and even break other devices.  This gets worse
> if the power supply is aging and can't fight the big current flows.
>

Yes that's possible. I still suspect the SATA port more, as it was
always on one controller.


>
> ...and you let this continue?  raid1 is 2-device mirroring.  If you
> have simultaneous 2-device failures the filesystem will die.  It's right
> there in the spec.
>

It's not real usage yet. I'm just evaluating. I know that it can only
cope with one drive failure. Did'n expect that the other drive also
will be affected.

>
> One failure is fine.

Not with this particular failure I was refering to, that "auto-fails"
another drive.

>  You can mitigate that risk by building arrays out
> of diverse vendor models, and even ages if possible (we also rotate
> disks out of live arrays on a schedule, whether they're failing or
> not).

I learned that when I was like 16 years old. Saved all my money to buy
4 IBM DTLA. And then they failed faster than I could replace and the
replaced drives failed again.

>
> Two or more failures are always possible.  That's where backups become
> useful.

I'd really like to use raid 6, though, if it only had not this problem.

>

>
> This is maybe true of drives that are multiple years past their warranty
> end date, where almost any activity--even carefully moving the server
> across the room--will physically break the drive.  It's certainly not true
> of drives that are in-warranty (*)--we run scrubs biweekly on those for
> years, in between heavy read-write IO loads that sometimes run for months.
>
> People who say things are often surprised when they don't run a scrub
> for a year and suddenly discover all the errors that have been slowly
> accumulating on their drives for months, and they think that it's the
> scrub _causing_ the problem, instead of merely _reporting_ problems that
> occurred months earlier.

Well, that function is one of the main reasons to use zfs/btrfs. I'm
wondering why people use it and don't scrub. And then scrub but don't
know why.

>
> Run a scrub so you'll know how your drives behave under load.  Run a
> scrub every month (every day if you can, though that's definitely more
> than necessary) so you'll know if your drives' behavior is changing as
> they age, and also whether your host system in general is going to be
> able to survive any kind of RAID failure.  If the system can't cope with
> a scrub when disks are healthy, it's definitely not going to be able to
> recover from disk failures.  Drives that are going to break in scrub are
> going to break during RAID recovery too.  You want to discover those
> problems as soon as possible so you can replace the faulty components
> before any data is lost.

True!

>
> (*) except Seagate Barracudas manufactured between 2011 and 2014.
>
>
> If this occurs, and is reported to btrfs, then btrfs aborts all future
> writes as well, as a critical disk update failed.  If it occurs without
> reporting then it's just another case of silent data corruption for btrfs
> to clean up with self-repair later on.  If the one sector on your disk
> that is unreadable after a crash is the one 64K offset from the start
> of your btrfs, but the rest of the disk is still usable, you've hit the
> one-in-a-billion target (a 4 TB drive has a billion 4K sectors on it).
>
> There are lots of other ways disks can fail, but they mostly reduce to
> integrity failures that btrfs handles easily with raid1 and at most one
> disk failure.
>

>
> Yes, btrfs is very conservative there.  btrfs requires explicitly
> authorizing a degraded array read-write mount too.
>
