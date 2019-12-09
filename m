Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF55116451
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 01:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLIARW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 19:17:22 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35052 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLIARW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 19:17:22 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6D42E5160DF; Sun,  8 Dec 2019 19:17:21 -0500 (EST)
Date:   Sun, 8 Dec 2019 19:17:21 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unable to remove directory entry
Message-ID: <20191209001721.GF22121@hungrycats.org>
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oXUzUgc67Nrfa9SE"
Content-Disposition: inline
In-Reply-To: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--oXUzUgc67Nrfa9SE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2019 at 02:19:10PM -0500, Mike Gilbert wrote:
> Hello,
>=20
> I have a directory entry that cannot be stat-ed or unlinked. This
> issue persists across reboots, so it seems there is something wrong on
> disk.
>=20
> % ls -l /var/cache/ccache.bad/2/c
> ls: cannot access
> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest':
> No such
> file or directory
> total 0
> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.manif=
est

I have seen a bug similar to this some years ago.  It was present as
far back as 4.5, and seems to still be present in 5.0.21.  I don't have
detailed tracking information on it due to the low severity: not a crash
or data corruption bug, and workarounds exist both to prevent the bug
and to clean up its aftermath.

The reproducer is something like:

	while (true) { // pseudocode
		int fd =3D create(tmp_name);
		write(fd, ...);
		fsync(fd);	// required, bug does not appear without this fsync
		close(fd);
		rename(tmp_name, regular_name);
	}

and a crash, maybe with some heavy write load.  This is typical of
applications like git and ccache, and in the wild, broken directory
entries are often found in these applications' directories.

Somewhere between 4.5 and 4.12 (a big range, I know), there was a change
in behavior:  before, the broken directory entry could not be removed,
renamed, or used for a new file, the only way to get rid of the broken
directory entry was to delete the entire subvol.  After the behavior
change, the broken directory entry could be removed by creating a new
file and renaming it to the broken directory entry name.

Another workaround is to remove the fsync by running the application
under eatmydata.  btrfs performs a flush in the rename() operation when
an existing file is replaced, so the fsync that triggers the bug was
not necessary in the first place.  Note this only works when replacing
an existing file, so the flushoncommit mount option is required to make
this work in other cases.

> % uname -a
> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
> Phenom(tm) II X6 1055T Processor
> AuthenticAMD GNU/Linux
>=20
> % btrfs --version
> btrfs-progs v5.4
>=20
> I have tried running btrfs check, and I get differing results based on
> the --mode switch:
>=20
> # btrfs check --readonly /dev/sda3
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups
> Opening filesystem to check...
> Checking filesystem on /dev/sda3
> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> found 284337733632 bytes used, no error found
> total csum bytes: 267182280
> total tree bytes: 4498915328
> total fs tree bytes: 3972464640
> total extent tree bytes: 199819264
> btree space waste bytes: 776711635
> file data blocks allocated: 313928671232
>  referenced 279141621760
>=20
> # btrfs check --readonly --mode=3Dlowmem /dev/sda3
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 5 INODE_ITEM[4065004] index 18446744073709551615 name
> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 missing
> ERROR: root 5 DIR ITEM[486836 13905] name
> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 mismath
> ERROR: root 5 DIR ITEM[486836 2543451757] mismatch name
> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/sda3
> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> found 284337733632 bytes used, error(s) found
> total csum bytes: 267182280
> total tree bytes: 4498915328
> total fs tree bytes: 3972464640
> total extent tree bytes: 199819264
> btree space waste bytes: 776711635
> file data blocks allocated: 313928671232
>  referenced 279141621760
>=20
> Please advise on possible next steps to diagnose and fix this.

--oXUzUgc67Nrfa9SE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXe2SjAAKCRCB+YsaVrMb
nJBgAJ9Jh4ag+em7ZOeHEH5XkQu1JtS95gCgjmSAnkhjImpNH8p1PMxgDGVcQ0c=
=X3A0
-----END PGP SIGNATURE-----

--oXUzUgc67Nrfa9SE--
