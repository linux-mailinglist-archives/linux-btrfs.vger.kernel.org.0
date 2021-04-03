Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509E83534EA
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhDCR3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Apr 2021 13:29:18 -0400
Received: from mout.web.de ([212.227.17.12]:41235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhDCR3R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Apr 2021 13:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617470952;
        bh=JBl+M0MtDKwpt05y3X6jDJtnQRsZOxEJXucyy01qsKM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=mNVBptCsv9eakOFPgvR9mYrUHj3IA5fjfDl2WnjQ5bMZkj8VPJ3Gynl97eD2mt1gu
         St6MLQYI88AJbCfREtCOXYkJwtTdoD9zoiLYhtRc+p90hS5/Nv5oF2NpvnaLKqm6bW
         RN+oDyeZPkOuapQb7IFFk/p/6euIAW7aRwdjW3BA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko.fritz.box ([94.134.180.252]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaCji-1lsQNi23mI-00m2uH; Sat, 03
 Apr 2021 19:29:12 +0200
Date:   Sat, 3 Apr 2021 19:28:52 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Thomas <74cmonty@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd
 2719033, flush 0, corrupt 6, gen 0
Message-ID: <20210403192852.5a908568@gecko.fritz.box>
In-Reply-To: <57292e4b-549d-9ce1-7967-32e6820c80e5@gmail.com>
References: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
        <20210313152146.1D7D.409509F4@e16-tech.com>
        <cefa397a-c39a-78c3-5e85-f6a9951de7d8@gmail.com>
        <CAJCQCtR5zeC=jNRf0iSHpqQXDOBExfFzfGj+PzMTxs_S1JVmVg@mail.gmail.com>
        <57292e4b-549d-9ce1-7967-32e6820c80e5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zmgwg7SwpNBQPsHNpWuyN+T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:Qr/3KXAZZ9RZaJuMsuYDdm6Dna6rrGQ/sKZJfN3ETuJ8u3qCt65
 s760YPozEcHZ9fW478wEMwjPTE/730nQVJAQhm61q+J0VD5te7PLD6G1ZQ2aTjx2Qfq5ZHD
 6PcoA/vfm5myMZTONcJ3D0VLU6vcKfOH3D1GP6Z527U1k+VkF++Vy17wr/6/gwOGZdLcbk0
 hv1q3SnBlJIwaUbXELWkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M9DWy9m8lkY=:Lmv2FyK4P7TmA8Wxk3/qEw
 0F98fHq+as3dOHBMF8Ybv7NC8QKwRFU6kK7ksn/rk+nBcGlVWQOg1UEyFcEzLXuFvkhDquv1D
 PXCvFoyoUfsrK5hMN+MUW0UmCofq3lkV585z6c62lGAFQIeJG9uMN8ehnNS7RWWPXT2QweOci
 VM0PPusuxcgLI8C+va4/fKnvVQXo2HjrqFsTkTMPUaeK7FE1msfajMjHmfQj0FKeGAFeV5FAA
 c3Z3Hbo1VriWq93Bzh903JpOIhETEZ2U2vib+YAcdm836STE8+3aMuFGC/QPOOipl5eg9mwJq
 ANpDa8SHzghTL6DbOUu21LrKOJTeGynKjEKzblMRM3iuXAjcESjnRrNKT8v2J8FhANHiRGKDI
 P71ys8L8gwLZcSOeI1GR6K/57+43sbZsIQLexJbmba1/RaYv0uOJUIKDJ/q04kszINT32uwNS
 theACx8cELblHQaMfVQDKoHPYybTqrXU8vX8AlxHIrApcZ52v989MYrTUZIjR2nB+HXJhSAXI
 bET6oKyYHfUkxoMJWJuG8DysxaYpugCzRIHUKplrB+g1zYjyraQtBzz7Mg+hlFPnIc7bNIZ3J
 uNNaiNadSN1nC55CbfvKpO5nhlOUzdfXVGkz3w4jaT7zx1N+7sC+6vKb5eN3psxa4+5ZLL3zG
 TcJB0tncn3Piw/WroxG9Mc26bY/i2wS1rOH0+A3YcrkN1hZx/8Z3VmEKVBflVT65y4QD5gupn
 DDTeYtPoytXPdZVyAN/JNNhs5o920FfGrvLFs5zvYiCKTM1Z+K4o+8mc264vYKw939l39BNu1
 70HO+x+IscRYg1vic57C+T7Wn/+yVBbDV/ZA6Uu05iOfAteDvM1Yb8dOi70LN0StMdDcMsy3s
 DZcuVYIkecxZn+qHY+SpY2hOCrthAhgcl8giLAZpjLfbB0IUMUF0f4tIeh0yqaPp2JfPDZFQB
 gRTjeIdrpqS0ax7Z9h0izqvbCcFcEgXRFXgCaT+HGoQ8hStJPWP4ExP4shHdEL588yJSWGVnf
 dMOauLwII4yXQeeUEBsGdCuq77ZyvQagAUOEvv5Ge00x2y9WI3mgoxvGXAWxB8T0Oeu8VOVDF
 FWa1HMgPWmKFn11terkCPVDLc1vN2ECrm4eToshuK/Gwh5tnrQQ31faLkQf3ttLMwgx+V+rp+
 IxygCk6oqD8p8ZNRTgDqexmpSVB+fK1903+iiwFfzMI6CR3kp+H1GhnUA93GjNCl9N8gc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/Zmgwg7SwpNBQPsHNpWuyN+T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Apr 2021 22:46:25 +0200
Thomas <74cmonty@gmail.com> wrote:

> Hi,
>=20
> I finished repartition of devices /dev/sda + /dev/sdb now.
> On both devices the first partition is equal in size:
> $ sudo fdisk -l /dev/sda
> Festplatte /dev/sda: 238,47 GiB, 256060514304 Bytes, 500118192 Sektoren
> Festplattenmodell: SanDisk SD8SBAT2
> Einheiten: Sektoren von 1 * 512 =3D 512 Bytes
> Sektorgr=C3=B6=C3=9Fe (logisch/physikalisch): 512 Bytes / 512 Bytes
> E/A-Gr=C3=B6=C3=9Fe (minimal/optimal): 512 Bytes / 512 Bytes
> Festplattenbezeichnungstyp: dos
> Festplattenbezeichner: 0x0914a19b
>=20
> Ger=C3=A4t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Boot=C2=A0=C2=A0=C2=A0 Anfang=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ende=C2=A0 Sektoren Gr=C3=B6=C3=9Fe Kn Typ
> /dev/sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 2048 497027071 497025024=C2=A0 237G 83 Linux
> /dev/sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 497027072 500118191=C2=A0=
=C2=A0 3091120=C2=A0 1,5G 82 Linux Swap / Solaris
>=20
>=20
> $ sudo fdisk -l /dev/sdb
> Festplatte /dev/sdb: 238,47 GiB, 256060514304 Bytes, 500118192 Sektoren
> Festplattenmodell: SanDisk SD9TB8W2
> Einheiten: Sektoren von 1 * 512 =3D 512 Bytes
> Sektorgr=C3=B6=C3=9Fe (logisch/physikalisch): 512 Bytes / 512 Bytes
> E/A-Gr=C3=B6=C3=9Fe (minimal/optimal): 512 Bytes / 512 Bytes
> Festplattenbezeichnungstyp: dos
> Festplattenbezeichner: 0xf23fc590
>=20
> Ger=C3=A4t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Boot Anfang=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Ende=C2=A0 Sektoren Gr=C3=B6=C3=9Fe Kn Typ
> /dev/sdb1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2048 497027071 =
497025024=C2=A0 237G 83 Linux
>=20
>=20
> However, the output of btrfs insp dump-s <device> is still different:
> $ sudo btrfs insp dump-s /dev/sda1 | grep dev_item.total_bytes
> dev_item.total_bytes=C2=A0=C2=A0=C2=A0 254476812288
>=20
> $ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes
> dev_item.total_bytes=C2=A0=C2=A0=C2=A0 256059465728

Interesting, this is again larger than the partition!
Did you actually run mkfs.btrfs after formating? Else it might still be
reading the old filesystem's superblock (just repartitioning does not
erase that).

>=20
> Can you please advise how to fix this?
> My understanding is that size of btrfs superblock must be equal on both
> devices.

No, it's not a problem if the disks have different sizes. You have a
different problem here.

Regards,
Lukas Straub

>=20
> THX
>=20
>=20
> Am 13.03.21 um 19:02 schrieb Chris Murphy:
> > On Sat, Mar 13, 2021 at 5:22 AM Thomas <74cmonty@gmail.com> wrote:
> > =20
> >> Ger=C3=A4t      Boot Anfang      Ende  Sektoren  Gr=C3=B6=C3=9Fe Kn Typ
> >> /dev/sdb1         2048 496093750 496091703 236,6G 83 Linux
> >> However the output of btrfs insp dump-s <device> is different:
> >> thomas@pc1-desktop:~
> >> $ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes
> >> dev_item.total_bytes    256059465728 =20
> > sdb1 has 253998951936 bytes which is *less* than the btrfs super block
> > is saying it should be. 1.919 GiB less. I'm going to guess that the
> > sdb1 partition was reduced without first shrinking the file system.
> > The most common way this happens is not realizing that each member
> > device of a btrfs file system must be separately shrunk. If you do not
> > specify a devid, then devid 1 is assumed.
> >
> > man btrfs filesystem
> > "The devid can be found in the output of btrfs filesystem show and
> > defaults to 1 if not specified."
> >
> > I bet that the file system was shunk one time, this shrunk only devid
> > 1 which is also /dev/sda1. But then both partitions were shrunk
> > thereby truncating sdb1, resulting in these errors.
> >
> > If that's correct, you need to change the sdb1 partition back to its
> > original size (matching the size of the sdb1 btrfs superblock). Scrub
> > the file system so sdb1 can be repaired from any prior damage from the
> > mistake. Shrink this devid to match the size of the other devid, and
> > then change the partition.
> >
> >
> > =20
> >> Ger=C3=A4t      Boot    Anfang      Ende  Sektoren  Gr=C3=B6=C3=9Fe Kn=
 Typ
> >> /dev/sda1  *         2048 496093750 496091703 236,6G 83 Linux
> >>
> >> thomas@pc1-desktop:~
> >> $ sudo btrfs insp dump-s /dev/sda1 | grep dev_item.total_bytes
> >> dev_item.total_bytes    253998948352 =20
> > This is fine. The file system is 3584 bytes less than the partition.
> > I'm not sure why it doesn't end on a 4KiB block boundary or why
> > there's a gap before the start of sda2...but at least it's benign.
> >
> > =20
>=20



--=20


--Sig_/Zmgwg7SwpNBQPsHNpWuyN+T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmBopdQACgkQNasLKJxd
sli2/g//c2dVn8dgw+weGjKdwpnKHVSIvlIC4xyWstXEtLp7cdxyLeazsE9VCseQ
6HNbCk1xU6keSTswBP4juZmzT22nZVwOKHS4Ot+5jGnyq2+gGR5cM6/dMrvtPXw6
sWYsrCOkmHQfu5G1zyHzuPpczI+OuLe8MJv1O/2r1nqpj/c/iNWxbSkPr2MpgzDV
ttHfjS+4IObC2uwRKIx2s+8ZrFxzPPxGNSZAuRdryiso/PPyNGV7qpDEs4imHgPd
/WqS1nGYcgFI0dRQjBG7/rnOpOYE4J2zmfQV5QoDw5JummIqo78UVoy0S7hD6QgI
W+SyKHrRi1Lol+TJAhmuLjw+vw0d3og8JlfrBT5W23I/8zldeS5oqJMgrm8VUeeg
ZeF8c6D4auq53ac3Np2aj162TfHjeuAG/tfQpX+5gpl3l8fonpQWJKL3us+K7EBp
tl+BuaUpwEDkHG7DgFG9XL81GS7W4ZJNQfy5A3mPpWrpiQJNNmnoEQLl0mIlv95o
B2s1205Pm/Q74Dg2adTPDNMH9nbcipTxN3fmjdzWYySxclh59iZGFQwgQUAtnSU9
UcdNpxE2TqzWqgIWF3pytzocJ8IESSTReRu6Pyc19Wr3JyW8FXSHv3gNGXYerHLN
aT5AI4FtDVBpU3OtWqf1hUxnB39hc36nceN+dBAv+5hGvzPUOQ8=
=Xbog
-----END PGP SIGNATURE-----

--Sig_/Zmgwg7SwpNBQPsHNpWuyN+T--
