Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1870C38DCD1
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 22:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhEWURT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 16:17:19 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44260 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhEWURS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 16:17:18 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D8ED3A72250; Sun, 23 May 2021 16:15:50 -0400 (EDT)
Date:   Sun, 23 May 2021 16:15:50 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andreas Falk <mail@andreasfalk.se>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs check discovered possibly inconsistent journal and now the
 errors are gone
Message-ID: <20210523201550.GC11733@hungrycats.org>
References: <CADw67XBxEvo_doMWCFChUhEhQxDVg4XuzQvTTMOhE=A+wFbuMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADw67XBxEvo_doMWCFChUhEhQxDVg4XuzQvTTMOhE=A+wFbuMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 23, 2021 at 04:55:16PM +0100, Andreas Falk wrote:
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

Did you run that with the filesystem mounted?  If so, it explains all
of the following errors, and the way they seem to appear and disappear.
They are the result of btrfs check losing races against the filesystem
while the filesystem moves metadata around.

Don't run btrfs check on a mounted filesystem.  It won't work.

Don't run btrfs check at all, unless there are errors the kernel cannot
recover from with a scrub.  btrfs check necessarily has fewer data
integrity checks than the kernel (otherwise it would not be able to repair
anything) but that means check can stumble into problems that the kernel
would have easily avoided, and can cause damage with --repair as a result.

If you suspect damage to the filesystem (e.g. due to buggy firmware in
the drives + power loss), then run btrfs scrub first.  If that reports no
errors (or corrects all the errors it does find), then there is usually
no need to do anything else.

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

If the filesystem is readonly then btrfs check has a lower chance of
failure.  Still not zero, though.  btrfs check should only be run on
unmounted filesystems, if it should be run at all.

> and now it's no longer finding any problems or printing any paths that
> are problematic.
> 
> >From what I've understood from this[a] article, the errors I saw were
> likely due to an inconsistent journal.

One rule of thumb for finding bad advice about btrfs on the Internet is to
ask if the author believes in the existence of a 'btrfs journal'.  If so,
it's a safe bet that the author has no idea what they're writing about.

btrfs doesn't use a journal.  It uses wandering trees for metadata
integrity, and a log tree for fsync().  These store different things
than a journal, and have very different failure behavior compared to
journals in other filesystems.

> Now for my questions:
> 
> 1. I'm guessing that my reboots, in particular the ones where I still
> had it mounted in readwrite mode somehow cleared the journal and
> that's why I'm no longer seeing any errors. Does this sound
> plausible/correct? 

Well, there's no journal, so that can't be part of any correct theory.

It is most likely that there were no errors on disk in the first place.
If btrfs check is reading metadata while btrfs was modifying it, then
it will always see an inconsistent view of the filesystem.  Each time
you run btrfs check, it will see a different inconsistent view of the
filesystem, so old errors will disappear, and new ones could appear.

That said, self-correction is not impossible.  Normally btrfs raid1 will
automatically correct a corrupted mirror using data from a good mirror.
This uniformly handles cases ranging from bits flipped in drive DRAM,
writes that were dropped on their way to the disk (due to UNC sector,
firmware bug, power loss, misdirected write, FTL failure, or hundreds
of other possible reasons), and drives that temporarily disconnected
from arrays.

> The errors being gone without me manually clearing
> them feels scary to me.

btrfs will usually report such events in the kernel log and increment the
'btrfs dev stats' counters, though there are a handful of exceptions.

The correction is automatic when possible.  It occurs both on normal
reads and during scrubs.

> 2. Is there any way to identify the paths again that were problematic
> based on the values in the log that I posted above so I can figure out
> what to restore from backups rather than doing a full restore?

The error messages you posted are all metadata tree issues.  Paths are
in a higher layer of the filesystem.  Depending on which metadata is
affected, anywhere from a few hundred paths to the entire filesystem
may be affected.

Note that if you ran 'btrfs check' on a mounted filesystem, the errors
reported are most likely a result of that mistake, and you should ignore
all of check's output under those conditions.

If there are really unrecovered metadata errors on the disks then paths
do not matter very much.  The filesystem cannot be safely modified in
this case, so only a full mkfs + restore (or successful 'btrfs check
--repair --init-extent-tree' run) can make the filesystem writable again.

Note that we have no evidence that you are in this situation, or indeed
any evidence of a problem at all.  Power failures are totally routine
events for btrfs, and most drive firmware will handle them with no
problems (though there are one or two popular drive models out there
that won't).

> a. https://ownyourbits.com/2019/03/03/how-to-recover-a-btrfs-partition/

This article features a random mashup of btrfs recovery commands and
error messages.  Half of it is simply wrong:  zero-log cannot fix a
parent transid verify failed error, all but two btrfs errors imply that
you don't need to run chunk-recover, there is no journal...

> Thank you,
> Andreas
