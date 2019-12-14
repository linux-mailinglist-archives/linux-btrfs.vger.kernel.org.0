Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFA11F03D
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 06:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfLNFTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Dec 2019 00:19:39 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36264 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfLNFTj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Dec 2019 00:19:39 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E451B525997; Sat, 14 Dec 2019 00:19:38 -0500 (EST)
Date:   Sat, 14 Dec 2019 00:19:38 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     halfdog <me@halfdog.net>, linux-btrfs@vger.kernel.org
Subject: Re: FIDEDUPERANGE woes
Message-ID: <20191214051938.GA13306@hungrycats.org>
References: <2019-1576167349.500456@svIo.N5dq.dFFD>
 <691d3af5-da85-5381-7db3-c4ef011b1e4a@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <691d3af5-da85-5381-7db3-c4ef011b1e4a@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 05:32:14PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/12/13 =E4=B8=8A=E5=8D=8812:15, halfdog wrote:
> > Hello list,
> >=20
> > Using btrfs on
> >=20
> > Linux version 5.3.0-2-amd64 (debian-kernel@lists.debian.org) (gcc versi=
on 9.2.1 20191109 (Debian 9.2.1-19)) #1 SMP Debian 5.3.9-3 (2019-11-19)
> >=20
> > the FIDEDUPERANGE exposes weird behaviour on two identical but
> > not too large files that seems to be depending on the file size.
> > Before FIDEDUPERANGE both files have a single extent, afterwards
> > first file is still single extent, second file has all bytes sharing
> > with the extent of the first file except for the last 4096 bytes.
> >=20
> > Is there anything known about a bug fixed since the above mentioned
> > kernel version?
> >=20
> >=20
> >=20
> > If no, does following reproducer still show the same behaviour
> > on current Linux kernel (my Python test tools also attached)?
> >=20
> >> dd if=3D/dev/zero bs=3D1M count=3D32 of=3Ddisk
> >> mkfs.btrfs --mixed --metadata single --data single --nodesize 4096 disk
> >> mount disk /mnt/test
> >> mkdir /mnt/test/x
> >> dd bs=3D1 count=3D155489 if=3D/dev/urandom of=3D/mnt/test/x/file-0
>=20
> 155489 is not sector size aligned, thus the last extent will be padded
> with zero.
>=20
> >> cat /mnt/test/x/file-0 > /mnt/test/x/file-1
>=20
> Same for the new file.
>=20
> For the tailing padding part, it's not aligned, and it's smaller than
> the inode size.
>=20
> Thus we won't dedupe that tailing part.

We definitely *must* dedupe the tailing part on btrfs; otherwise, we can't
eliminate the reference to the last (partial) block in the last extent of
the file, and there is no way to dedupe the _entire_ file in this example.
It does pretty bad things to dedupe hit rates on uncompressed contiguous
files, where you can lose an average of 64MB of space per file.

I had been wondering why dedupe scores seemed so low on recent kernels,
and this bug would certainly contribute to that.

It worked in 4.20, broken in 5.0.  My guess is commit
34a28e3d77535efc7761aa8d67275c07d1fe2c58 ("Btrfs: use
generic_remap_file_range_prep() for cloning and deduplication") but I
haven't run a test to confirm.


> Thanks,
> Qu
>=20
> >=20
> >> ./SimpleIndexer x > x.json
> >> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/x =
> dedup.list
> > Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test/x=
/file-1': [(0, 5472256, 155648)]}
> > ...
> >> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/tes=
t/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> > ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0, =
src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D0}=
]} =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
> >> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/x =
> dedup.list
> > Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test/x=
/file-1': [(0, 5316608, 151552), (151552, 5623808, 4096)]}
> > ...
> >> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/tes=
t/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> > ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0, =
src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D0}=
]} =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
> >> strace -s256 -f btrfs-extent-same 4096 /mnt/test/x/file-0 151552 /mnt/=
test/x/file-1 151552 2>&1 | grep -E -e FIDEDUPERANGE
> > ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D151=
552, src_length=3D4096, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=
=3D151552}]}) =3D -1 EINVAL (Invalid argument)
> >=20
>=20




--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXfRw6QAKCRCB+YsaVrMb
nMTvAJ9NQ52wqk5i648I2KHmXi5toBoL0QCg4GCZXp31WVumrcG5oEQF0EfsVrA=
=9wgK
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
