Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805B7243126
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 00:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHLWvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 18:51:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:54741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgHLWvA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 18:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597272657;
        bh=3NQbR5DdHAfSzpFEp0HuMJXGP0U+y4FQRaYtSHATJmQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aTV0Iey9+OLhWIMbnec+tSD+0Qvzn9zhtLbQOQWoMsf5JU99Gh9qyTkfc4S3eSPGO
         6CxKBW/hvnBdOYO0ijlH1GAhS7w5hSVt6FNGLJ2vomW6Z88cFNI/+y8dF5AWDYRPw7
         MeqYteJFYVNAaCMbMXvT8W3Ej0AnuP5C4rhTbbrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiHl-1kL2f13GoR-00QDFk; Thu, 13
 Aug 2020 00:50:57 +0200
Subject: Re: Tree-checker Issue / Corrupt FS after upgrade ?
To:     benjamin.haendel@gmx.net, linux-btrfs@vger.kernel.org
References: <004201d670c9$c69b9230$53d2b690$@gmx.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <facaa4ae-5001-13e7-3ea1-26d514f73848@gmx.com>
Date:   Thu, 13 Aug 2020 06:50:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <004201d670c9$c69b9230$53d2b690$@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ywVJscBRFX3peKf5KQPSs9DoDXUgBiGON"
X-Provags-ID: V03:K1:poU23/qgs+upEXBIh1yK9Vo2NMSdfjKwt5IhSXPvCHLrNaQP7rm
 gjk8KEoBhEA/Nqy54U/S0AdS/V4CMcmaaWo4VRppT4lG+zYZZDXRYz3hZ/wdSOf4+6kqjm5
 d3/17Zkmh44Nte/z4EV6I8tcP+Yj4B+/cWorrkrzxvFjPoROkOpdCHpIW59HlfBUN4Aggex
 U/6qD//0oSaHPK/oUhAnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ysKP6VBtm5w=:XO5C5n97bMEFoCeKveyODb
 my9ghgyrPxy+yyHlwZ5fKaDIEGwEP8BEkgmHw+co+uNhBg8DtnYnHVL38/CJT8QUHSMNS4+HN
 eb+9WcqMBWdZO8QmMr61Nay8Ms/ynUdjWBHRquKXm6A4BPrLMUphu6ZHoOxUpYGxpGnQRFqi8
 tf/VYU9CaKGJEd25u8cvd3iVfFzDDx7F8Bbgf5ss1AF+cemyqutjhp0IUIm7xxwJ7brBzHhf/
 oYPk1oHF3U1kL20NFe04uSC1dpocJBS/ZO76HDO+naFz2jFto5vRGIhweHxmvphVVtRKOkQK0
 shUWMqFd3vEngx7JBUr+PBpYeKUcrm4H90ApOfiK638LbQ6/KZnv9SzSqfBdadpbqQO/FdPDb
 w+7wuBNfGTqwuwreuPv22HRyJAaZxOGaKdYNfSnZqUOKPlRcfrmZbp9FK5hlGEOf9NXxew/HH
 3SVUattu0nTA46A+CrwWZ1pU+XX7lT4Vb8+KhRTwvX91uvvSNV+DRhHGcbC7eaaOf9lgKFkgy
 VdwgORe0bplJ6onrHNE7kUMXFlGrdYoMy8eUo19m1LCVk/LUKQS5t06NcvZEf/sfxo34QpKTr
 gYsb65TJWe11mPgtQjTkXF+gupTcllkQPbWA5qaxK6zLUa0tYqIqewgeMPeWi4+R7wV6Sq1a8
 dpVHq9lWQPqeHomGzgVqWZoyF9JC/OWmIaxtnu6tlLIhqh4fL08U+qwvzqWPuLraSiauHeAne
 IYJQVxhvCAyAYq3qfxopLOoHTNWG0CqHk/whVEdg9QkoOvKD+bBlABFeINbzsWMskoyIN8dK4
 yb0JfpTi5KHIedPuf6BEfCdRQmPzfk5lVT1b5Ydi590TbaD3CzmO6nq+NXZeUNZ70KXdlwHiP
 32DnBJBZRxB6N1Ad7VwsoxK78WtFXUPYQcNzxWeOJ1Hko1ssHf78WtZh9xsCVl5yNjgSRP6Ei
 M7Hv8FM/rcwEjTJ0zQwPIToYsdsXM7bY+cYIIk6yw20x9wICUjJxw0vkySyd5IF2kOYsnztGn
 XCUqsMNm/IFg7VhVahwGFqemEeA4yzi/mjaVmEwFBXGj7IxAdzTmBwLuuISWDfNlS8ZOpVNWa
 /lCHH+lAAzhXQBjWLIWHARoknbBj9cQibq/Cqlh9iVO5xGaA4Xzuu/cjWKl/l6OrrJ2hR7Gfz
 2hi233CCyrZWZYXlScXrDYOsZtiDlXK2Y1jmlspcPvknb6yBKTp6OTr86RlPWndTv9d9eOXGG
 RS4aigNfj8FMmKTUNGfY+dNynqF33sFjcNbwf+Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ywVJscBRFX3peKf5KQPSs9DoDXUgBiGON
Content-Type: multipart/mixed; boundary="Vo6RyX8WIZ4i2lQqM5uDRFhEGtbzb7a2y"

--Vo6RyX8WIZ4i2lQqM5uDRFhEGtbzb7a2y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/13 =E4=B8=8A=E5=8D=8812:58, benjamin.haendel@gmx.net wrote:
> Hi,
>=20
> i have been running my little Storage (32TB) on a Ubuntu 18.04 LTS Mach=
ine
> with btrfs-progs 4.17. I then did my monthly upgrade (apt dist-upgrade)=
 and
> after a reboot my Partition could not mount with the error message:=20
> "root@Userv:/home/benjamin# mount -r ro btrfs /dev/mapper/Crypto
> /media/Storage
> mount: bad usage"
>=20
> I then proceeded to run a btrfs check which gave thousands of errors an=
d
> then also a super-recover:
> root@Userv:/home/benjamin# btrfs rescue super-recover -v /dev/mapper/Cr=
ypto
> All Devices:
> Device: id =3D 1, name =3D /dev/mapper/Crypto
>=20
> Before Recovering:
> [All good supers]:
> device name =3D /dev/mapper/Crypto
> superblock bytenr =3D 65536
>=20
> device name =3D /dev/mapper/Crypto
> superblock bytenr =3D 67108864
>=20
> device name =3D /dev/mapper/Crypto
> superblock bytenr =3D 274877906944
>=20
> [All bad supers]:
>=20
> All supers are valid, no need to recover
>=20
> I now checked my dmesg log:
> [45907.451840] BTRFS critical (device dm-0): corrupt leaf:
> block=3D22751711027200 slot=3D1 extent bytenr=3D6754755866624 len=3D409=
6 invalid
> generation, have 22795412619264 expect (0, 207589]

This is caused by older kernel, which writes some uninitialized value
onto disk.

You can try to fix it with this branch:
https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair

Or you can use older kernel to delete the offending extents.

Thanks,
Qu

> [45907.451848] BTRFS error (device dm-0): block=3D22751711027200 read t=
ime
> tree block corruption detected
> [45907.451892] BTRFS error (device dm-0): failed to read block groups: =
-5
> [45907.510712] BTRFS error (device dm-0): open_ctree failed
>=20
> Google inquiries to this topic led me to this link:
> https://btrfs.wiki.kernel.org/index.php/Tree-checker
> It tells me to mail here first so thats what i am doing. I kind of susp=
ect
> since everything worked perfect (Memtest also no errors) before the upd=
ate,
> it has to do something with that update. I am wondering if it would hel=
p if
> i deleted my OS Disk and reinstalled an older Version of Ubuntu, like
> 16.04.6 LTS ?
>=20
> Since then i upgraded to 20.04 LTS with BTRFS-PROGS 5.7 as a lot of for=
um
> entries said it would be wise to use the newer versions as older were b=
uggy.
> That brought no help as well.
>=20
> Since i am no Linux/Unix Expert i thought it might be better to ask now=

> first as advised in the link above before proceeding with any other pla=
ns.
>=20
> I find it hard to believe that all data is gone, i feel its buggy behav=
ior
> as the partition and everything is still there:
> root@Userv:/home/benjamin# btrfs fi show
> Label: 'Storage'  uuid: 46c7d04a-d6ac-45be-94cc-724919faca2b
> Total devices 1 FS bytes used 28.23TiB
> devid    1 size 29.10TiB used 29.04TiB path /dev/mapper/Crypto
>=20
> Best Regards,
> Benjamin H=C3=A4ndel
>=20


--Vo6RyX8WIZ4i2lQqM5uDRFhEGtbzb7a2y--

--ywVJscBRFX3peKf5KQPSs9DoDXUgBiGON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl80ck0ACgkQwj2R86El
/qh2Swf9G96Av1fYNjE7l+jTILf6kU0FevjlRTNw+cGikB6dHmWwoujeC8rGYe5i
aq7t+/giOeP3hg0HegYsG5ktMgStSpf04YQNbsaDM1JuoM1CZO24xkQLJzCF4BUj
JevLRbOYKWiECWW7bKmV0XnwYKnY9wtqV0fWEFtkIyWJTaU0OcBSav4NswqPw0Im
ZdGxT+OOXX8XjAFG6QNhGK7Z4xm8nbpvrUHTuhuMdxxXSVcIBZp8Ejr9r5E00fuR
OFl+H0ZdK1GKb+ceCuV+t3pdzMkA3u/coXqCV294xvvQWoFxM1X9akUfdhFpA7ZZ
MwWyQ485oUf3+mLqcRZOe7341A1Smw==
=MFGa
-----END PGP SIGNATURE-----

--ywVJscBRFX3peKf5KQPSs9DoDXUgBiGON--
