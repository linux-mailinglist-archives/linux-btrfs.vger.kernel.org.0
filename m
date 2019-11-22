Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71BE105F5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 05:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVE7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 23:59:47 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37604 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVE7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 23:59:45 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C535D4E7F13; Thu, 21 Nov 2019 23:59:43 -0500 (EST)
Date:   Thu, 21 Nov 2019 23:59:43 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
Message-ID: <20191122045943.GH22121@hungrycats.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <20191121222228.GG22121@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
Content-Disposition: inline
In-Reply-To: <20191121222228.GG22121@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 05:22:28PM -0500, Zygo Blaxell wrote:
> On Wed, Nov 20, 2019 at 05:36:04PM +0100, Christian Pernegger wrote:
> > Hello,
> >=20
> > I've decided to go with a snapshot-based backup solution for our new
> > Linux desktops -- thank you for the timely thread --, namely btrbk.
> > A couple of subvolumes for different stuff, with hourly snapshots that
> > regularly go to another machine. Brilliant in theory, less so in
> > practice, because every time btrbk runs, the box'll freeze for a few
> > seconds, as in, Firefox and LibreOffice, for instance, become entirely
> > unresponsive, games hang and so on. (AFAICT, all it does is snapshot
> > each subvolume and delete ones that are out of the retention period.)
>=20
> Snapshot delete is pretty aggressive with IO and can force a lot of
> commits if you are modifying a lot of metadata pages between snapshots.
> Generally I get a coffee when my 1TB NVME systems decide it's time to
> drop a snapshot, as the system can effectively hang for a few minutes
> while btrfs-cleaner runs.  On performance-critical systems we only ever
> have one snapshot active on the filesystem at a time, and we only create
> it once a day for backups.  I'd love a way to throttle btrfs-cleaner so
> it's not so aggressive with IO and CPU.
>=20
> Snapshot create has unbounded running time on 5.0 kernels.  The creation
> process has to flush dirty buffers to the filesystem to get a clean
> snapshot state.  Any process that is writing data while the flush is
> running gets its data included in the snapshot flush, so in the worst
> possible case, the snapshot flush never ends (unless you run out of disk
> space, or whatever was writing new data stops, whichever comes first).
>=20
> Anything that needs to take a sb_writer lock (which is almost everything
> that modifies the filesystem) will hang until the snapshot create is done;
> however, processes that are reading the filesystem will not be obstructed.
> This can lead to starvation of the writing processes.  cgroups and ionice
> won't help here--the block layer doesn't detect waits for sb_writers
> (there is no associated block device for those, so they're invisible to
> the block layer), so it doesn't know that writer processes are waiting
> for IO, and all the writers' IO bandwidth gets reallocated to the reader
> processes, making for long-lasting priority inversions.  The IO pressure
> stall subsystem reads _zero_ IO pressure even though writing processes
> are continuously blocked for hours.
>=20
> On small systems, this is all over in a second or less.  On bigger
> fileservers, I've had single snapshot creates run for many hours.  As a
> workaround, I have some scripts that freeze processes that write to the
> disk while 'btrfs sub create' runs, to force the snapshot create to finish
> in a timely manner.  I think I saw some patches going into later 5.x
> kernels that solve the problem in the kernel, too (writes that occur after
> the snapshot creation starts are not included in the snapshot any more).

Nope, the patch I'm thinking of is dated Nov 1 *2018* and is already in
5.0.  So either that fix is ineffective, or the slow snapshots are caused
by something else.

> > I'm aware that having many snapshots can impact performance of some
> > operations, but I didn't think that "many" <=3D 200, "impact" =3D stop
> > dead and "some operations" =3D light desktop use. These are decently
> > specced, after all (Zen 2 8/12 core, 32 GB RAM, Samsung 970 Evo Plus).
> > What I'm asking is, is this to be expected, does it just need tuning,
> > is the hardware buggy, the kernel version (Ubuntu 18.04.3 HWE, their
> > 5.0 series) a stinker, something else awry ...?
> >=20
> > Cheers,
> > C.



--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXddrOwAKCRCB+YsaVrMb
nC9/AKCggIn5Tnq7xfhm8HCj8QFi3d3NNACg5dzWLWk9jWU2t4Bji1hSnmWt7uw=
=sRmZ
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
