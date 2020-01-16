Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13313D169
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 02:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgAPBQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 20:16:58 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46106 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgAPBQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 20:16:58 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 30D2457631E; Wed, 15 Jan 2020 20:16:56 -0500 (EST)
Date:   Wed, 15 Jan 2020 20:16:56 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     philip@philip-seeger.de
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
Message-ID: <20200116011656.GL13306@hungrycats.org>
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eMP3JyRexyk9c0Bv"
Content-Disposition: inline
In-Reply-To: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--eMP3JyRexyk9c0Bv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 06:41:36PM +0100, philip@philip-seeger.de wrote:
> A bad drive caused i/o errors, but no notifications were sent out because
> "btrfs dev stats" fails to increase the error counter.
>=20
> When checking dmesg, looking for something completely different, there we=
re
> some error messages indicating that this drive is causing i/o errors and =
may
> die soon:
>=20
> BTRFS info (device sda3): read error corrected: ino 194473 off 2170880
>=20
> But checking the stats (as generally recommended to get notified about su=
ch
> errors) claims that no errors have occurred (nothing to see here, keep
> moving):
>=20
> # btrfs dev stats / | grep sda3 | grep read
> [/dev/sda3].read_io_errs 0
>=20
> Why?
> Isn't that the most important feature of a RAID system - to get notified
> about errors, to be able to replace such a drive...?
>=20
> The fs is mirrored, so those errors didn't cause any data loss.

This seems to be a result of commit
0cc068e6ee59c1fffbfa977d8bf868b7551d80ac "btrfs: don't report readahead
errors and don't update statistics" which assumes that readahead errors
are ignored and have no side effects.  It turns out this is not true: in
the event of a recoverable read or csum failure, the filesystem overwrites
the bad block with good data recovered by using mirror copies or parity,
in both normal reads and readahead reads.  Later, when a non-readahead
read comes along to read the block, there's no error on the device any
more because btrfs already corrected it, so no counters are updated.

This is very bad--the whole point of dev stats is to make failure events
observable so failing hardware can be identified and replaced, and commit
0cc068e6ee makes some of those events not count.

This commit appears in kernels 5.1-rc3 and later.  A simple workaround
is to revert the commit, and let printk ratelimiting deal with the dmesg
spam issue.  I don't know if there are other errors that readahead can
generate that are not IO errors (e.g. running out of memory).  If there
are, then there will be some false positive read error counts.  These
are still better than false negative read error counts.

An alternative fix would be to have readahead not correct the data,
so readahead truly has no side-effects.  This would make the rationale
of this commit more supportable--except we'd still want to know if a
device was intermittently failing to read, so we should still count the
readahead errors anyway.

It would be nice to have a dev stats counter for corrections too.  It's a
pretty significant event for monitoring if we overwrite committed data
for any reason, but especially so if we are doing it in response to a
detected device failure.  We should definitely count those.

It would also be nice to throw some data into a tree every time an error
occurs (extent bytenr, offset, generation, error type, event count,
device or mirror ID) every time an error occurs.  A tool can read this
tree to pull out the extent bytenrs, map them back to paths (if the
generation matches; otherwise, it's an old error and the file has since
been overwritten), and produce something like the zfs status output.
But that's way beyond a bug fix.

>=20
> # uname -sr
> Linux 5.2.7-100.fc29.x86_64
> # btrfs --version
> btrfs-progs v5.1
>=20
>=20

--eMP3JyRexyk9c0Bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXh+5hQAKCRCB+YsaVrMb
nODRAKDqCmH0gfArg7YKaHXmeaiSxpEDjgCgqF0ED1PZNilrP4XX8sUv9NWNKqQ=
=zvcY
-----END PGP SIGNATURE-----

--eMP3JyRexyk9c0Bv--
