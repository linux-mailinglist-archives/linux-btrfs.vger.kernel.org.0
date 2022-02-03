Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4934A9089
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 23:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355735AbiBCWPd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 17:15:33 -0500
Received: from mout.web.de ([212.227.17.12]:45781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbiBCWPc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Feb 2022 17:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1643926524;
        bh=3J/kdwxaixbu38SpUgwDJikgfwgWV4uEIBB0PUkhTHU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=dGfpTJhP85knEmO/QVIdpuanGYZDkeMXGgmWOCm+vfOOT/XZtCUGRRcMGg6g89JV7
         C0mjlD+LNfZS6aPjcPuoypqvcTtfC3rQwTQnVjHp1UbxldXsTrfzO4KhdWOuKtjHDH
         DTSxnLH8Dk0+9tt1WIZ/IrZoqELBmOQcWwsHOEh0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.151.147]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjJo-1mIxSY2iPi-00yApr; Thu, 03
 Feb 2022 23:15:24 +0100
Date:   Thu, 3 Feb 2022 22:15:06 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Andy Smith <andy@strugglers.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: "Too many links (31)" issue
Message-ID: <20220203221506.212e72e8@gecko>
In-Reply-To: <20220203163108.ipdv3yxbe7eb6vc4@bitfolk.com>
References: <20220203163108.ipdv3yxbe7eb6vc4@bitfolk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ngSaMnmW7bmrNyD8JOo5yps";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:YK7MJmvaAQO6jNM5pp9D8E3gTbGVwpha24c/SJFezVfJfLe7EP8
 QhJpHtRGnmu8osuCEmiPBbIT7fc9i0wKpRrqDOPHwcgpNZmnHLtBbuDIZBtXzafNvZaDDkh
 W8YrAxgorNThMc54KoDP54XGeyYOvOOvnvlDmILS8DzKUS+obibUziFMshcdTQJafi02Xj/
 8nIE/CcrhMPIaSerbAjyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6umeDZmYsCI=:IZqSJcb21zUh6nsrDfQnq3
 A8uFQ2T9Op4tf6sWpdR6jnptzFMPA6kkangsn9ZyPWIbXHNnW3JQBOMkjhGllJJYEW/V6bJhM
 yE6aEUywioxnXsPB9Oygy2RawgMUpt9/sI8FKK+ZwAjzDSmBTfSgrFjOIGn+EGcPxuN7yMlBe
 V06m7YaEAs2F90F5XUipuUHH+LC6YrLp8lpZFQ+5feQatZwDiNSekO+70XhTfhNEKBjQwDYzs
 HLxKTD0QlhqpBIjUzX8/Cr/WeVlYB8hSlEjHMg1fOFvPN7xeqaXv9UFdPu66IK0acj3Lwrz1q
 qCSVhusnST8V25fdyWwV6mANR62UpMHA5s+MedjXDUerHREC6qnq0vy747Z882nqeuwxNIjzF
 9j57DPMQBG6MTr90ie1wmkhUPagXoJ3+Uf79jpANBoO1ebOyN3YK42PM1TH5C9udzdUPJklLC
 P8PrZA21zfN0Lz0LHkRjZe73NsiStzAVULCl+WSibG94GR3kkg9LC5Pj7IlNToL0G/8iSTfsV
 VUaqeIa13pYf7Qb5CIQ27rFy0Pz4xJ9L6sUZI2X6TTYkFiFljC6PvE3q2t9BQ67U5CMroNYk7
 OW6lVdWS0iMIJXAUd957vVeEj9cqWopDJdlp4i7pxO6KSOjvqT5ghuCYzrdqOYgKUdYREio1n
 e558pIyelINc2zWNSDUVQ4Sv5Pdo6D7+GUviLu2apb/Gquo3W4nDay/jlHsZ7v93WCMNuswx0
 4+Q0dgNtXL1IIl3PJMIqWb9vzT5rSiecX2OcZ2/asFrF51BB/LT8LUvQHhsIjx9djS3TaAzEH
 JfiSCK3zyyBdUXHG4ICMZxAAnQqGm5KxjaJYsDgCkpgV2XyDluRU6yS83lumfYuGKQww/kDQu
 az4n2rLfLx7loFdln+bwmo6vQexrzE4VYkb+Kdy7eQ8OqWRNaVgrwGY/MyiWx3Kv+Ekawwz8U
 xXbdsxBLvhQCz5BuVwDtiogSsXa4jxgezV5MyI3Monmsj/cdEQXlecmztj7zVpw3KkJat1m6h
 LQU7OPOON2L/F+U3pbd3OfhRb7bK1j3yNHfWYVGL+4my2l+z8p0bqkM5yrc3uuHaZv3DPrgb6
 3jQyeH/TyrPJiM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/ngSaMnmW7bmrNyD8JOo5yps
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Feb 2022 16:31:08 +0000
Andy Smith <andy@strugglers.net> wrote:

> Hi,
>=20
> I have a host with an xfs filesystem on it, with about 25 million
> files. It contains an rsnapshot backup that has been aggressively
> deduplicated by means of hardlinks and there's probably only about 7
> million unique files on there.
>=20
> I'm trying to rsync it to a different host into a btrfs filesystem,
> but part way through the rsync I get a "Too many links (31)" error:
>=20
> rsync: [generator] link "/data/backup/rsnapshot/daily.0/chacha/var/lib/dp=
kg/info/.apt-utils.postrm.0" =3D> daily.0/backup1/var/lib/dpkg/info/libpang=
o1.0-0.postrm failed: Too many links (31)
> Hlink node data for 219191 already has path=3Ddaily.0/backup1/var/lib/dpk=
g/info/libpango1.0-0.postrm (daily.0/chacha/var/lib/dpkg/info/apt-utils.pos=
trm)
> rsync error: errors with program diagnostics (code 13) at hlink.c(539) [g=
enerator=3D3.2.3]
>=20
> I searched around on this topic and found hits from 10 years ago
> about maximum hardlinks per directory and being dependent upon
> length of file path. Is that still relevant today?
>=20
> [...]
>=20
> Is there anything I can do to get this working?

Hello, Have you tried the "extended_iref" mount option?=20

--=20


--Sig_/ngSaMnmW7bmrNyD8JOo5yps
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmH8U+oACgkQNasLKJxd
sljOlw/+PKX+wdiTQIvmGQ09Ab1YpGzL8KoTqGZG0UwjZ6rVtVBEk+U0IWiSzoq9
eM3Z9/MRbKWDCMuBWLswbsUppMw21K4vLFdGtRiKUUSpF+158QrEAoXCaCPsf41p
5e49/BUxTmJuJRjihxfiLcJ9VMcNpIUFZuBouALLPzugrQ8dy2Sv7zm+OxY0BcPB
QW1YzDvlVWfC2j45xMa0kzXck3yWU85x52vR23rbrfmOCwcn6FbHlSWeTp+A5Fqb
4JPsJCJEa9GVwWOw2GKLj9T/DDsiHF8DvXHhzQz5SG7PHVy3BVUFS1W+Ihf2NEln
bIeHvHzb+C1GkaTv1SuFOxrPrqKids4Ry/FjMdsLIpO4ZwBhVQPzLukpw+hYzoS3
s8+QUlHOuZTG1kChmU0GWc3+x7fMnG8ABE7oP8CLcXaMSOCQb5hLC1PTBiumuSoe
Q9RYFbCZmf8FQNpzxznpnsfbx8SbrlVKynSe6FLxRaQ8oxPUktYNEBgL3RETNVdZ
o259yKsf28ZWSz21jsGt+GMmADZ+GFRBrMI+doofX7ZBVweVVnIZdRabZA26R/To
j+nOYIlZ/neRX+IU20PyI4LZFLpGZbR/ZYGbbnUSodplX1hhRPs774mWr0YnraIT
yk6a0ocgnFmEUOcxLEIn4g1d2er9+Mm6gZvTTmgHUwRg+z6ReEA=
=Ycen
-----END PGP SIGNATURE-----

--Sig_/ngSaMnmW7bmrNyD8JOo5yps--
