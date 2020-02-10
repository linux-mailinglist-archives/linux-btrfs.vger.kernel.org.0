Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A087156EA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 06:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgBJFSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 00:18:10 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38880 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgBJFSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 00:18:10 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 876395B7B67; Mon, 10 Feb 2020 00:18:09 -0500 (EST)
Date:   Mon, 10 Feb 2020 00:18:09 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: data rolled back 5 hours after crash, long fsync running times,
 watchdog evasion on 5.4.11
Message-ID: <20200210051809.GJ13306@hungrycats.org>
References: <20200209004307.GG13306@hungrycats.org>
 <CAJCQCtRzMqPREP5U=8ZoCY0fMEsX_ng4tH3pHbQwJfrdk-MNmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="to+bXLvrczl8f0V1"
Content-Disposition: inline
In-Reply-To: <CAJCQCtRzMqPREP5U=8ZoCY0fMEsX_ng4tH3pHbQwJfrdk-MNmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--to+bXLvrczl8f0V1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2020 at 06:49:11PM -0700, Chris Murphy wrote:
> On Sat, Feb 8, 2020 at 5:43 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > Upon reboot, the filesystem reverts to its state at the last completed
> > transaction 4441796 at #2, which is 5 hours earlier.  Everything seems =
to
> > be intact, but there is no trace of any update to the filesystem after
> > the transaction 4441796.  The last 'fi usage' logged before the crash
> > and the first 'fi usage' after show 40GB of data and 25GB of metadata
> > block groups freed in between.
>=20
> Is this behavior affected by flushoncommit mount option? i.e. do you
> see a difference using flushoncommit vs noflushoncommit? My suspicion
> is the problem doesn't happen with noflushoncommit, but then you get
> another consequence that maybe your use case can't tolerate?

Sigh...the first three things anyone suggests when I talk about btrfs's
ridiculous commit latency are:

	1.  Have you tried sysctl vm.dirty_background_bytes?

	2.  Have you tried turning off flushoncommit?

	3.  Have you tried cgroupsv2 parameter xyz?

as if those are not the first things I'd try, or set up a test farm
to run random sets of parameter combinations (including discard, ssd cache
modes, etc) to see if there was any combination of these parameters that
made btrfs go faster, over any of the last five years.

I know what doesn't work:  Very low values of vm.dirty_background_bytes
can certainly harm throughput, but once it's above 100M or so it makes
no difference.  Some SSDs are terrible with discard, others need it
to avoid crippling performance losses every few months.  Writeback SSD
caches get flooded with data thanks to btrfs's already scary-fast write
path, and end up adding additional latency.  cgroupsv2 measures the wrong
things, so it reports io stall pressure of zero in high-priority cgroups
while all writes are blocked and some low-priority cgroup desparately
needs to be throttled.  If you throttle anything on btrfs at the block
level, you get priority inversion, because it's impossible to predict
which thread will end up hosting its very own btrfs transaction commit,
and nobody gets to write anything while one of those is running (well,
on 5.3+, apparently lots of processes can continue to write, but nothing
they write will be persisted after a crash).

When the kernel hits vm.dirty_bytes, none of the other settings matter:
the performance difference between flushoncommit and noflushoncommit
is the order of the writes during a commit, but the commit is always
dumping all the dirty pages that the kernel can store in RAM on disk.
noflushoncommit allows the kernel to dump the pages in the wrong order,
but has no performance advantages.  noflushoncommit might even make the
latency a little _worse_.

Profiling indicates that btrfs spends most of its time _reading_ the
filesystem during commits.  Roughly half the IO is metadata reads for
extent and csum trees, the other half is writing updated versions of
these, and maybe 1% is writing the data blocks.  While all that's going
on, more and more stuff gets locked, until eventually transactions stop
dead on kernels up to 5.0, or keep going forever on kernel 5.3 and later).
Freezing all reading processes helps the commit finish faster, but it
needs cripping levels of throttling (like 0.1% of raw write bandwidth
of the slowest disk in the array, or even less) before making a dent in
the big latency spikes.

I'm not quite sure what's different on 5.4--there were a lot of changes
and I haven't been doing profiling because I've been focused on fixing
the crashing bugs until recently.  5.4 has apparently moved the latency
to different places--ordinary writing processes no longer block at all,
while processes calling rename or fsync can be blocked for entire days.

>=20
> --=20
> Chris Murphy

--to+bXLvrczl8f0V1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXkDnjgAKCRCB+YsaVrMb
nNszAJ992T7e9XOs0U8ZM3blc8chFMY/tQCg6HlDzG9U9c5bCucehLOnagNZlrU=
=kEe7
-----END PGP SIGNATURE-----

--to+bXLvrczl8f0V1--
