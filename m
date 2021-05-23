Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5D38DC78
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhEWSkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 14:40:19 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34406 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhEWSkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 14:40:18 -0400
Received: by mail-ed1-f49.google.com with SMTP id w12so21541458edx.1
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 11:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gwPLieL8v/hx1U+iqu8OLZsQkCZVIXL9LEE2FFoHk/o=;
        b=nB6C7MgsOFqvoGsZOQLkkXHQIcWtwhqkkwIOsiHTpqbbUJm+6+66H6tXo8DvC5FAt2
         PwW2VdZhHfJ2UWjfQynqOkBI0xyzE0N5BprtARg5slGYMS4m/6xWCYn4gV0+d6UPUWcx
         cRqw2dlfFIATJ+TKPp2LV2sF8xZ+/N3j7F/XbDGu1fC1mfpRgtd6gk4mlrNxn8TYyYKY
         JXXRTJX0E4AuRpFr9kf+9x1R46GV0QMP6CMFMwYGNiJN3/s49K/h49/rBjeS5KrnLEhp
         gjysepSogqVoU7svXT0+oAar7Zm8ieuqtW53BNei7vcbYGdGCq65cCXWUk4kZyDcm865
         pUqA==
X-Gm-Message-State: AOAM533rnrHeKsaoJi8s+TLj4Ad1rn1Wo6RAn2ML0bPwzal7JGp5fE/m
        TExwhFkyD90Bu7rjjXgaeQQPj6KRQuPfaSmVrYtewu5/4KrR9Q==
X-Google-Smtp-Source: ABdhPJysl5bB8ZB+PnTc3k1p5NP+cIbw/trd5LnAr0e4yi4O4nV+0ydJ8ez5i44oZSUZQ8UBsPsmopQpMs7WVvq28iU=
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr21334700eds.16.1621795129727;
 Sun, 23 May 2021 11:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <CADw67XBxEvo_doMWCFChUhEhQxDVg4XuzQvTTMOhE=A+wFbuMg@mail.gmail.com>
In-Reply-To: <CADw67XBxEvo_doMWCFChUhEhQxDVg4XuzQvTTMOhE=A+wFbuMg@mail.gmail.com>
From:   Andreas Falk <mail@andreasfalk.se>
Date:   Sun, 23 May 2021 19:38:39 +0100
Message-ID: <CADw67XA8j5g2p6=3dWj=mxf8tXY_R7h-GkvUWs1GOwTby=p4FA@mail.gmail.com>
Subject: Re: btrfs check discovered possibly inconsistent journal and now the
 errors are gone
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oh, and apologies if this is not a good forum for asking this type of
question. Additionally, the various versions and other information
that might be useful:

$ uname -a
Linux pandora 5.12.3-arch1-1 #1 SMP PREEMPT Wed, 12 May 2021 17:54:18
+0000 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.12.1

$ btrfs fi show
Label: '$LABEL'  uuid: f0aae703-a128-42e7-8ad7-16ebd57833cb
        Total devices 4 FS bytes used 6.85TiB
        devid    1 size 7.28TiB used 5.91TiB path /dev/sdf
        devid    3 size 2.73TiB used 1.39TiB path /dev/sdb
        devid    4 size 1.82TiB used 489.00GiB path /dev/sdc
        devid    5 size 7.28TiB used 5.93TiB path /dev/sde

$ btrfs fi df /home
Data, RAID1: total=6.84TiB, used=6.84TiB
System, RAID1: total=32.00MiB, used=1.12MiB
Metadata, RAID1: total=11.00GiB, used=9.45GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

Cheers!
Andreas

On Sun, May 23, 2021 at 4:55 PM Andreas Falk <mail@andreasfalk.se> wrote:
>
> Hey,
>
> I want to start with clarifying that I've got backups of my important
> data so what I'm asking here is primarily for my own education to
> understand how btrfs works and to make restoring things more
> convenient.
>
> I'm running a small home server with family photos etc with btrfs in
> raid1 and we recently experienced a power cut. I wasn't around when it
> got turned back on and when I finally got to it everything had run for
> ~2h with the filesystem mounted in readwrite mode so I ran (after the
> fact I realized that I should have probably unmounted immediately and
> made sure /etc/fstab had everything in readonly mode):
>
> $ sudo btrfs check --readonly --force /dev/sdb
>
> and it seemed to mostly run fine but after a while it started printing
> messages like this along with what looked like some paths that were
> problematic (from what I remember, but these are not my exact
> messages):
>
> parent transid verify failed on 31302336512 wanted 62455 found 62456
> parent transid verify failed on 31302336512 wanted 62455 found 62456
> parent transid verify failed on 31302336512 wanted 62455 found 62456
>
> along with (these are my exact messages from a log that I saved):
>
> The following tree block(s) is corrupted in tree 259:
> tree block bytenr: 17047541170176, level: 0, node key:
> (18446744073709551606, 128, 25115695316992)
> The following tree block(s) is corrupted in tree 260:
> tree block bytenr: 17047541170176, level: 0, node key:
> (18446744073709551606, 128, 25115695316992)
> tree block bytenr: 17047547396096, level: 0, node key:
> (18446744073709551606, 128, 25187668619264)
> tree block bytenr: 17047547871232, level: 0, node key:
> (18446744073709551606, 128, 25124709920768)
> tree block bytenr: 17047549526016, level: 0, node key:
> (18446744073709551606, 128, 25195576877056)
> tree block bytenr: 17047551426560, level: 0, node key:
> (18446744073709551606, 128, 25162283048960)
> tree block bytenr: 17047551803392, level: 0, node key:
> (18446744073709551606, 128, 25177327333376)
>
> I didn't have time to look into it deeper at the time and decided to
> just shut it down cleanly until today when I'd have some time to look
> further at it. I booted it today (still in readwrite unfortunately)
> and immediately modified /etc/fstab to not mount any of the volumes,
> disabled services that might touch them and then rebooted it again to
> make sure it's not touching the disks anymore. Then I ran a check
> again:
>
> $ sudo btrfs check --readonly --progress /dev/sdb
>
> and now it's no longer finding any problems or printing any paths that
> are problematic.
>
> From what I've understood from this[a] article, the errors I saw were
> likely due to an inconsistent journal.
>
> Now for my questions:
>
> 1. I'm guessing that my reboots, in particular the ones where I still
> had it mounted in readwrite mode somehow cleared the journal and
> that's why I'm no longer seeing any errors. Does this sound
> plausible/correct? The errors being gone without me manually clearing
> them feels scary to me.
> 2. Is there any way to identify the paths again that were problematic
> based on the values in the log that I posted above so I can figure out
> what to restore from backups rather than doing a full restore?
>
> a. https://ownyourbits.com/2019/03/03/how-to-recover-a-btrfs-partition/
>
> Thank you,
> Andreas
