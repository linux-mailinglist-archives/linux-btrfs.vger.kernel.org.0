Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8C1BB666
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD1GUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 02:20:01 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36820 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgD1GUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 02:20:01 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5119E694C80; Tue, 28 Apr 2020 02:19:59 -0400 (EDT)
Date:   Tue, 28 Apr 2020 02:19:59 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200428061959.GB10769@hungrycats.org>
References: <20200426124613.GA5331@schmorp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20200426124613.GA5331@schmorp.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 02:46:13PM +0200, Marc Lehmann wrote:
> Hi!
>=20
> I made an experiment whose results I would like to share with you, in the
> hope of possible behaviour improvement in the future.
>=20
> Summary: A disk was physically removed for a multi-device filesystem while
> copying large amounts of data to the fs. btrfs continued writing half a
> TB of data without signalling an error - it probably would have continued
> like that forever, which I think is suboptimal behaviour.
>=20
> And here the longer version:
>=20
> I created a multi-device fs with data=3Dsingle and meta=3Draid1 and copied
> about 8TB of data to it. After copying roughly 7.5TB of data I powercycled
> the disk, which caused the raid controller to remove the device
> semi-permanently.
>=20
> Since the partitions were on LVM, this didn't cause btrfs to see a rmeoved
> device (if btrfs can even do that) - it did get EIO on every write, but
> btrfs f u for example did display the device even though it was physically
> missing, liekly as the device-mapper device was still there.
>=20
> While the write errors kept increasing (altogether over 300000) in the
> kernel log, no other indications hsowed anything out of the ordinary -
> mkdir/file writes still worked.
>=20
> After restoring the missing disk rebooting, I was able to mount the the
> filesystem without any special options. Accessing the data got  a lot of:
>=20
> Apr 24 21:01:53 doom kernel: [   83.515375] BTRFS error (device dm-32): b=
ad tree block start, want 35423883739136 have 15380345110528
> Apr 24 21:01:53 doom kernel: [   83.534174] BTRFS info (device dm-32): re=
ad error corrected: ino 0 off 35423883743232 (dev /dev/mapper/xmnt-faulty s=
ector 14241833192)
> Apr 24 21:01:53 doom kernel: [   83.849524] BTRFS error (device dm-32): p=
arent transid verify failed on 34293446770688 wanted 2575 found 2539
>=20
> While btrfs seemed to be able to repair most, amybe all, of the metadata
> errors, I did get lots of inaccessible files and directories, which is of
> course expected.

That is _not_ expected.  Directories in btrfs are stored entirely in
metadata as btrfs items.  They do not have data blocks in data block
groups.

With metadata=3Draid1 and a surviving uncorrupted disk, you should have
been able to enumerate and stat() every file on the filesystem, even
the ones where the data inside the files was lost.

> I tried to balance the metadata to simulate a metadata-only btrfs scrub
> (which I wish would exist :), but the balance kept erroring out with
> repeated ENOSPC errors and switched the device to read-only, which was
> unexpected due to using raid1.
>=20
> I finally rebalanced the metadata to dup profile and back to raid1, which
> seemed to have the expected effect of reparing the metadata errors.
>=20
> At remounting and unmounting the device, I got a number of these messages
> as well:
>=20
> Apr 24 21:30:48 doom kernel: [ 1818.523929] BTRFS warning (device dm-32):=
 page private not zero on page 32786264244224
> Apr 24 21:30:48 doom kernel: [ 1818.523931] BTRFS warning (device dm-32):=
 page private not zero on page 32786264248320
> Apr 24 21:30:48 doom kernel: [ 1818.523932] BTRFS warning (device dm-32):=
 page private not zero on page 32786264252416
>=20
> I then deleted all directories written while the disk was gone, did a
> btrfs scrub (no errors) and some other tests (all remaining files were
> readable and had correct contents) and it seems btrfs completely recovered
> from this accident, which is a very positive change compared to older
> kernel versions (I did this with 4.9 and the fs was effectively lost).
>=20
> Discussion:
>=20
> The reason I think the write-error behaviour is suboptimal is because
> btrfs seems to not be bothered by a disk that loudly throws away all data
> - it keeps writing to it and it never signals userspace about it. In my
> case, 500GB were written "successfully" before I stopped it.
>=20
> While signalling userspace for writes is hard (as the EIO comes too
> late to signal userspace directly), I nevertheless am suprised by btrfs
> not only effectively ignoring all write errors, but also not signaling
> errors where it could - for example, a number of subdirectories were
> gone or unreadable after the reboot (as they at least partially were on
> the missing disk) which were written without error even though they were
> multiple times larger than the memory size, i.e. it was almost certainly
> writing to directories long _after_ btrfs got an EIO for the respective
> directory blocks.=20

There would be a surviving mirror copy of the directory, because it's in
raid1 metadata, so that should be a successful write in degraded mode.

Uncorrectable EIO on metadata triggers a hard shutdown of all writes to
the filesystem.  Userspace will definitely be informed when that happens.
It's something we'd want to avoid with raid1.

> This is substantiated by the fact that I was able to
> list the directories before rebooting, but not afterwards, so some info
> lived in blocks which were not writtem but were still cached.

It sounds like you hit some other kind of failure there (this and the
"page private not zero" messages.  What kernel was this?

> I can't say with confidence how to improve this behaviour - I could
> understand writing some gigabytes of data that are still in the cache,
> or writing new files, but I think btrfs should not simply pretend an I/O
> error means "successfully written" to the extent it does now.
>=20
> On the other hand, kicking out a disk because it had a single write error
> might not be the best behaviour either, but at least with normal disks,
> an EIO on write rarely means that the block has a problem (as disk cache
> usually enusres that write errors are silent), but usually indicates
> a much worse condition, so cosnidering a diskunusable after EIO (or a
> certain number of EIO errors) might be better, especially if there is a
> way to get the disk back into the filesystem.
>=20
> I hope this mail comes in useful.
>=20
> --=20
>                 The choice of a       Deliantra, the free code+content MO=
RPG
>       -----=3D=3D-     _GNU_              http://www.deliantra.net
>       ----=3D=3D-- _       generation
>       ---=3D=3D---(_)__  __ ____  __      Marc Lehmann
>       --=3D=3D---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=3D=3D=3D=3D=3D/_/_//_/\_,_/ /_/\_\

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXqfLCwAKCRCB+YsaVrMb
nDrDAJ0fodrzo7jq9ckIbH88mdQbh6vTQACfdesHlEdwu33eO7k53/H0+0KwYM0=
=m6XV
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
