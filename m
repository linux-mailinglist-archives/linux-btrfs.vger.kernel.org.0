Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08828E016E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 12:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfJVKB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 06:01:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:47225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbfJVKB1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 06:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571738485;
        bh=7wYDrrqrHAKX/7eCp0ZqxXUXJ5MZHa5z1zxcoH4APys=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=c4K48/bZQLILi7gbFagaTu+W/Bszt0yyMAFHXnZjh/d8DQ0WNkqUUl3Y+papCGeZ0
         Be09j3QfWz1DNJyv+CB+/9bx50sOIi6fwjSEu0YmFvNgnKx8+j0RkoKBKMqkDr9xAh
         cu1qvWbuyTiZVTlpMtGqTINDkjM7rRsFiUZv5P+4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ml6mE-1hbSzw2csG-00lYzA; Tue, 22
 Oct 2019 12:01:25 +0200
Subject: Re: Effect of punching holes
To:     Tobias Reinhard <trtracer@gmail.com>, linux-btrfs@vger.kernel.org
References: <2b75abb1-4dd8-1da4-77be-7557ff53ec75@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <67354156-286a-f80e-ebc3-99c32e356fac@gmx.com>
Date:   Tue, 22 Oct 2019 18:01:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2b75abb1-4dd8-1da4-77be-7557ff53ec75@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FDJ3F3RwIA1IEDfFkuqEjX42YgbcCmKJ0"
X-Provags-ID: V03:K1:EXnaq7KHnpSajf7gO+yA0DCkWr62Udv5HYP5H9/bufPP8R0wylo
 /y335qKDfDF9HC3ulfPz90PxkDMOnKKr18kNqArcZmPv2aPW6ZPhMHIuwDeJjzTcR7GKTRc
 HqqPdZ/NV82l8dRGg5UHsn0PIABp+gCGjUrBYIRbg2nOTswZbwc/ph5ocMnyBCwWBWMy/jc
 r9gOhq5nRetLbs3h4ZT+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B5LSOObxJnE=:dHxO/NyqczodNa3D17BCUA
 esJnV++UbAvllaTThQWn6j8OQkntS+jHliJ8//6aAzrEuOYcJtxGIaD0bZVFBvpu/7QHSzZ2w
 2L+BlN9AY1Rvf0Rh1GvviiTyXoNPrfh95VgYIId9v6sEgAn1WyjZHpiDPj7bqGoKLU7FnZvQb
 zIgtUb7FE7CcOCTg5l0TBTbVr8Rjk1PzVwiAVLkSq+E9iL4q42ReiVqF5wXtIZWu8+ER6LC1N
 LfRqsOG/6FH8rtk/jhE3MHQWqmhOaOEUa418H/viT/4DzBqrKvSYV9GJRds32KJqhfHXujn+a
 j1UPp5+iPxdJVLhI0HySm2sIhxViAcSc8sfxN+1SVIq8QOFR7sfv8RqEr4nV0yZebNcT5B7zQ
 A5cKyZzwMb7OR4QdoQltFH/cT8dLfOC2usTLmiUNKRps/3XX7LLeXdR352de85lRJQA1WXBIC
 ClXf+hMBx7Hr7AaFOAmohCdRHH25+eHNLO0u9Zfi4HhbF3vChniA6nycaAg8LTfTZ2QThciS7
 mObyMSpZ9Yxb5tZg7XsX+xTPkIoeBMS1okvdC6OhvXfVT0npQBzRL4v870dqCFn/yxTOkJJVw
 dSesDx92mxf59ubGCIYrxtKXOkJQ7NqpNhS9WiHLi7Xpz5xCUpl6+Fs/OzCMZI2MSbHv7uqBX
 3fo3BNdnN0di3XQjzqnQFwbwrDxUk2pswQ4FMgCP8U+xwSvzcd1WbO3YZ+Qn58jyawFcU/QxB
 6BDfID6J0oERWKyzx+xOp7vUaLLZCCwgPe1dbmzlJiDb03vyckGtIlaUnlNDzSzW9K8KnApq5
 rSEXxpxQlcEm9H90hBs6vomeDI6rWa6E0VdyZ9i+MzKXtKLXnGnvSK7TyqnQ38eUu+qkfmt6G
 5YX7fRyCqR3I/0OB4XkeGzFNC2gH4IfFGN6CkRhCCJH486Xx5hBVmdXl7I6JudGkgBwiX4UVI
 GrGNirbj4DcaeZWLU1irTZN0TTYXxeTWnsBg0RqJJwtPQxyEZpLdrlJzi/ZCDbKC7T05+CGEq
 VSsVG5N/aTRML7KFvJ+8BGhnU7MjmVuAYhzBljX7npYHbIwWyVeP6FNuJ7WRXYJtmcZ9zkTAK
 J6KwDDHB6azdrnEtpa00QmfFoiVWdOtnpX2sdwZR1e73ph0n0xn9NxlPC9SZnx8bkL7qTD+Oy
 3Zh5KulsDkrHOwHOE+QTKyqWIuTtKHsk7Z2qPtn2hDNeZ68nCFvk9I7A7D2cmW59wFqCEAVfS
 363+pTvwciPSDzoMt4jvx/I/7wt0NNvZhMrfc0fEh+LthvH6gMBY0EcsCsHQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FDJ3F3RwIA1IEDfFkuqEjX42YgbcCmKJ0
Content-Type: multipart/mixed; boundary="K5xLgBNr98cWjMqvPOGHN7CVqO81zla9n"

--K5xLgBNr98cWjMqvPOGHN7CVqO81zla9n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/22 =E4=B8=8B=E5=8D=885:47, Tobias Reinhard wrote:
> Hi,
>=20
>=20
> I noticed that if you punch a hole in the middle of a file the availabl=
e
> filesystem space seems not to increase.
>=20
> Kernel is 5.2.11
>=20
> To reproduce:
>=20
> ->mkfs.btrfs /dev/loop1 -f
>=20
> btrfs-progs v4.15.1
> See http://btrfs.wiki.kernel.org for more information.
>=20
> Detected a SSD, turning off metadata duplication.=C2=A0 Mkfs with -m du=
p if
> you want to force metadata duplication.
> Label:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (null)
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 415e925a-588a-4b8f-bdc7-c30a4a0f5587
> Node size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384
> Sector size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
> Filesystem size:=C2=A0=C2=A0=C2=A0 1.00GiB
> Block group profiles:
> =C2=A0 Data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8.00MiB
> =C2=A0 Metadata:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00Mi=
B
> =C2=A0 System:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 4.00MiB
> SSD detected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
> Incompat features:=C2=A0 extref, skinny-metadata
> Number of devices:=C2=A0 1
> Devices:
> =C2=A0=C2=A0 ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIZE=C2=A0 PA=
TH
> =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0 1.00GiB=C2=A0 /dev/loop1
>=20
> ->mount /dev/loop1 /srv/btrtest2
>=20
> ->for i in $(seq 1 20); do dd if=3D/dev/urandom of=3Dtest$i bs=3D16M co=
unt=3D4 ;
> sync ; fallocate -p -o 4096 -l 67100672 test$i && sync ; done
>=20
> this failed from the 16th file on because of no space left

Btrfs doesn't free the space until all space of a data extent get freed.

In your case, your hole punch is [4k, 64M-4K), thus the 64M extent still
has 4K being used.
So the data extent won't be freed until you free the last 4K.

>=20
> ->df -T .
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0 Type=C2=A0 1K-blocks=C2=A0=C2=A0 Use=
d Available Use% Mounted on
> /dev/loop1=C2=A0=C2=A0=C2=A0=C2=A0 btrfs=C2=A0=C2=A0 1048576 935856=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2272 100% /srv/btrtest2
>=20
> ->btrfs fi du .
> =C2=A0=C2=A0=C2=A0=C2=A0 Total=C2=A0=C2=A0 Exclusive=C2=A0 Set shared=C2=
=A0 Filename
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test1
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test2
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test3
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test4
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test5
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test6
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test7
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test8
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test9
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test10
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test11
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test12
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test13
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test14
> =C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 8.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test15
> =C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test16
> =C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test17
> =C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test18
> =C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test19
> =C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=A0 4.00KiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 ./test20
> =C2=A0140.00KiB=C2=A0=C2=A0 140.00KiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0.00B=C2=A0 .
>=20
> When doing this on XFS or EXT4 it works as expected:
>=20
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0 Type 1K-blocks=C2=A0 Used Available =
Use% Mounted on
> /dev/loop1=C2=A0=C2=A0=C2=A0=C2=A0 ext4=C2=A0=C2=A0=C2=A0 999320=C2=A0 =
2764=C2=A0=C2=A0=C2=A0 927744=C2=A0=C2=A0 1% /srv/btrtest
> /dev/loop2=C2=A0=C2=A0=C2=A0=C2=A0 xfs=C2=A0=C2=A0=C2=A0 1038336 40456=C2=
=A0=C2=A0=C2=A0 997880=C2=A0=C2=A0 4% /srv/xfstest
>=20
> How to i reclaim the space on BTRFS? Defrag does not seem to help.

Rewrite the remaining 4K.

Then the new write 4K will be cowed into a new 4K extent, the old large
64M extent gets fully freed and free space.

Thanks,
Qu

>=20
> Best regards
>=20
>=20
> Tobias
>=20


--K5xLgBNr98cWjMqvPOGHN7CVqO81zla9n--

--FDJ3F3RwIA1IEDfFkuqEjX42YgbcCmKJ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2u03EXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgZSQgAnFdGjDnsPd0xc+spiq3ThwnD
4pcSPOOnXDl0pULAeMI/tsA1FvpiX96ou66waoz1hMKXkUmnV4G1VG4lBYKX8uT0
a21XgzPOY98vJGxUUSE+186G4Vq4wxzz9bDAZvFKj2Chpq5OpvjlA8UAa3IvyMha
r7MlW83+p2j+x3NnVQIgKWfMl44a/8ejPUHlWLx2XK0HME5CIyxJ7Y1eVEGUXp45
9xdQRMVbUBLH/HPAJDvZ8POGllkqRKeamGpitpKre6/E3ggQ9NN0L4wjrBFgyoiX
vCi2ug/ZY/s/g2S1Y6Sps7A8oOb6z+0SpiB2Va2qQzQ0KytQkxNt4IIVADAZ8Q==
=h68L
-----END PGP SIGNATURE-----

--FDJ3F3RwIA1IEDfFkuqEjX42YgbcCmKJ0--
