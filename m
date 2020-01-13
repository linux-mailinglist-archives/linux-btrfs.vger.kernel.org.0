Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729BF139C63
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 23:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAMWYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 17:24:04 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:58140 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgAMWYE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 17:24:04 -0500
Received: from archlinux.localnet (unknown [153.18.172.64])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id A356940707
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1578954243; bh=mMkWPUH2b8U2jvHeFrRjGSGhKsO8/25ON6Qpe7AbXuI=;
        h=From:To:Subject:Date:From;
        b=c7TDp10rtFysaf52WiglPiVPKFitbAVHmZpRVFJVNsjdz3+ZxhqgPmPBLHtASEtKV
         aQ5fCDSVng4xkApvE7JqCEGNpB4Yqcl24DxNiVFQKwJpLSnFmCaSDsd04RK5wB48G4
         eQwGxOqTgKvCS3qUHQI3KanmnxbAufNocMS/ozu5CJxRiqrYO0JTLJFm7Nx2VPKK8x
         Qx4RsnLlvfQs91aEDa3G4ma9mS2urkd5kefiNWR1N3QWp2dHcD05XdqP94A/DdyubO
         DwlWkntl2TlsGzQ4WVYbO3N5GiAdI+WGGC8B+InAuxd7pi/L6g9NAQ83BypvmZf8EF
         QcSgYJ8p+aXqw==
From:   Michael Ruiz <michael@mruiz.dev>
To:     linux-btrfs@vger.kernel.org
Subject: Should I be concerned about the listed mountpoints in lsblk?
Date:   Mon, 13 Jan 2020 14:24:02 -0800
Message-ID: <11445940.O9o76ZdvQC@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5320587.DvuYhMxLoT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart5320587.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=46or sda3 and sdb1, it shows that the mountpoint is the log subvolume and =
the=20
kodi subvolume, respectively. Is this just an error on lsblk part or did I=
=20
mount my system wrong? My fstab appears to have all the correct locations=20
listed and everything seems to be working fine. It's just this mountpoint=20
column shows strange locations where I would expect / and /mnt/storage (the=
=20
designated root subvolume for these devices)

$ lsblk=20
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda           8:0    0 238.5G  0 disk =20
=E2=94=9C=E2=94=80sda1        8:1    0   100M  0 part  /boot/EFI
=E2=94=9C=E2=94=80sda2        8:2    0   300M  0 part  /boot
=E2=94=94=E2=94=80sda3        8:3    0 238.1G  0 part =20
  =E2=94=94=E2=94=80root    254:0    0 238.1G  0 crypt /var/log
sdb           8:16   0 931.5G  0 disk =20
=E2=94=94=E2=94=80sdb1        8:17   0 931.5G  0 part =20
  =E2=94=94=E2=94=80storage 254:1    0 931.5G  0 crypt /mnt/storage/kodi

--nextPart5320587.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEr70V3EMiSIOlxR/PXLDtxglpeu0FAl4c7fkACgkQXLDtxglp
eu1X2Qf+Lf8e8Wo2ew0uPliLbzwsNtEYgyPhNFiuLmCgO7fSVq2cH2DkPbKG3yDT
x8JBBOeoQnIXLFw3uOTK9ybHHeFO4UTt6NeZjzks85XcfHe5f4wnZfN8wfpl/HJl
hJ1ajiWWjQzHxPDX8C8YUJHzO4zxUo2RWkGgW20NxmSbBTPIEaIWfUi48yuPSPjY
G1prdB7z7Lxdvftr/Zuj2gqwNjIod7se+Nr5a8imkAryb3y18PhzlClSKzXa/aqS
Bdk2Ok2y8nL7WycqV540Io36UoytZ/TdvW297hiFVKEzW6qxUvbalT+qFHL3DuiL
c2/1ZWtt2Cgrh1HCWAqzIUuphTlJcg==
=8k+C
-----END PGP SIGNATURE-----

--nextPart5320587.DvuYhMxLoT--



