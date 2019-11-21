Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF8105C96
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 23:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKUWW3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 17:22:29 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44840 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 17:22:29 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7BE014E76BF; Thu, 21 Nov 2019 17:22:28 -0500 (EST)
Date:   Thu, 21 Nov 2019 17:22:28 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
Message-ID: <20191121222228.GG22121@hungrycats.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RlgFhasKO3bfRJ5j"
Content-Disposition: inline
In-Reply-To: <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--RlgFhasKO3bfRJ5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 05:36:04PM +0100, Christian Pernegger wrote:
> Hello,
>=20
> I've decided to go with a snapshot-based backup solution for our new
> Linux desktops -- thank you for the timely thread --, namely btrbk.
> A couple of subvolumes for different stuff, with hourly snapshots that
> regularly go to another machine. Brilliant in theory, less so in
> practice, because every time btrbk runs, the box'll freeze for a few
> seconds, as in, Firefox and LibreOffice, for instance, become entirely
> unresponsive, games hang and so on. (AFAICT, all it does is snapshot
> each subvolume and delete ones that are out of the retention period.)

Snapshot delete is pretty aggressive with IO and can force a lot of
commits if you are modifying a lot of metadata pages between snapshots.
Generally I get a coffee when my 1TB NVME systems decide it's time to
drop a snapshot, as the system can effectively hang for a few minutes
while btrfs-cleaner runs.  On performance-critical systems we only ever
have one snapshot active on the filesystem at a time, and we only create
it once a day for backups.  I'd love a way to throttle btrfs-cleaner so
it's not so aggressive with IO and CPU.

Snapshot create has unbounded running time on 5.0 kernels.  The creation
process has to flush dirty buffers to the filesystem to get a clean
snapshot state.  Any process that is writing data while the flush is
running gets its data included in the snapshot flush, so in the worst
possible case, the snapshot flush never ends (unless you run out of disk
space, or whatever was writing new data stops, whichever comes first).

Anything that needs to take a sb_writer lock (which is almost everything
that modifies the filesystem) will hang until the snapshot create is done;
however, processes that are reading the filesystem will not be obstructed.
This can lead to starvation of the writing processes.  cgroups and ionice
won't help here--the block layer doesn't detect waits for sb_writers
(there is no associated block device for those, so they're invisible to
the block layer), so it doesn't know that writer processes are waiting
for IO, and all the writers' IO bandwidth gets reallocated to the reader
processes, making for long-lasting priority inversions.  The IO pressure
stall subsystem reads _zero_ IO pressure even though writing processes
are continuously blocked for hours.

On small systems, this is all over in a second or less.  On bigger
fileservers, I've had single snapshot creates run for many hours.  As a
workaround, I have some scripts that freeze processes that write to the
disk while 'btrfs sub create' runs, to force the snapshot create to finish
in a timely manner.  I think I saw some patches going into later 5.x
kernels that solve the problem in the kernel, too (writes that occur after
the snapshot creation starts are not included in the snapshot any more).

> I'm aware that having many snapshots can impact performance of some
> operations, but I didn't think that "many" <=3D 200, "impact" =3D stop
> dead and "some operations" =3D light desktop use. These are decently
> specced, after all (Zen 2 8/12 core, 32 GB RAM, Samsung 970 Evo Plus).
> What I'm asking is, is this to be expected, does it just need tuning,
> is the hardware buggy, the kernel version (Ubuntu 18.04.3 HWE, their
> 5.0 series) a stinker, something else awry ...?
>=20
> Cheers,
> C.

--RlgFhasKO3bfRJ5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXdcOIQAKCRCB+YsaVrMb
nMOqAJ4rXmnTRKGwiW7F4PcMR/3RyfR/egCeOV0F3x8vgju23gTezkOKqkoUmos=
=/q2b
-----END PGP SIGNATURE-----

--RlgFhasKO3bfRJ5j--
