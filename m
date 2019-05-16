Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631C721113
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 01:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfEPXlJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 19:41:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:45833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfEPXlI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 19:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558050065;
        bh=c4QP4fJb99x6vSMZ2P/A7Y2A3zdjaHgQ++mRRynaw/E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=c16B9viCdOUOkidoGKpqnDaX1IYonrvvLYhwMsB6EGdxEZPDnfos9dh0HxyU8ndXC
         qTQ/UrjYyGNjIMfdAG9oJ0rxsQDBf/LnlE5wAkI0EugWv/BglmwXrhnSs+E7K+KtWy
         HLaXX3UVNod4WcjhZuk6atzb72+5JFoeH558twZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1gTo9w3J2e-00xdTC; Fri, 17
 May 2019 01:41:05 +0200
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
To:     =?UTF-8?Q?Michael_La=c3=9f?= <bevan@bi-co.net>,
        linux-btrfs@vger.kernel.org
References: <297da4cbe20235080205719805b08810@bi-co.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <95e94b87-8740-b8b8-8766-2614a83c8d9f@gmx.com>
Date:   Fri, 17 May 2019 07:41:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <297da4cbe20235080205719805b08810@bi-co.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aDvwl28XOZ40aj1scgOvTc2BOCO7vzPrS"
X-Provags-ID: V03:K1:3zJqqCem7HEMAQW444mG7E9hkBKKh3PuQC8ZLZMAV27baaS4EwT
 /SvKGHOYXmUlyEKjG0HrOc+ao1rCn073XZUWIeYstzdeCmNDpI94yB4w1B01aKiqYY+2xbl
 UwiMOJIwg0Z/lwhzBFgg4cgah+tw1fraDyBQqdh1YaoILAga6VkrYxHRots0Pw9tD09jIP+
 1QRIrErxRQ6DrCvM3rQWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yKwRfK6WqI8=:nV1kwfIkPqjkkyihU/3pry
 NjRAXlvzpJte3IzEMy4yJpS2BkX6QhoAbaXq8rR0j1AdkJs6gq4ZmnRCdMOTu77O4qyme3I3Z
 XobKBm0H8qH+59xemH02Z4eb5Ul1q9tNVYS3NQsrtTrAxnYfHqaoy2RuHjo0uMN1xxzPzkgxu
 HqPPKwMKC8liuZj/G9uoEXTu4D0ab5FlvlNHT+J4kZ3+5SEdG/TltHgzzjI5HLLv8e9t+d3/j
 icKAhfeWaPHvD0NQXBsLBLHqvXJf/rerHF0fA9Ot2AgLqa6a1hMaVm9EImjTzMYJIgSWeQuh5
 D8Hu/2mrdhaNmSpQ6qK9uorl9DYhvoIt+0BPF7+EMKf8xfOBqdD0y6D4Mvx30qzz78FH817xW
 2CnBaZoSvvU6U+hBPIqiUXBRwEgz+Iu49SnH30aO3H9PokSfSpGcZibny85f4TMlf0mBKnUQZ
 UCvTKikpjsfw0IHjRmZ7oOaCQveiWYYhzP+awreU8uE7hh1vXEz2BQ7spAX/sHghWmijRCSfR
 nrtXMi1GUk6ntvbbPlwc9PAcqALs6MCGt/JfTcSnH/iT5F7BGjR18h8ERiEJikuCvrXunE5nk
 upYBw2mm/lkGRjt29C4g2yTSgME2xbcYDrxQk0uE/gXTs15sDhQ9eWtpLRAOXPPq9/wNemhSJ
 ga2tbRl6hwuonbobw4F2ULLJvBFNtfJGhkjIb9OXnkejHUGMS7rkGaqCUwnd/ydFKNlrCwQZH
 nH53fQPnIifIT5tkWBQX8vL7GX5Q6XgU6fYO+J2jArmQE6COehlNMUTif9uqCNrx+Vf9WCpl+
 HVZ9iczc9eBdbZ7sqMlGu5Iyohc9RUU2TVslHqmZc0qaA4b9ZuAnLw/iA+nLUMbkqDfV0Kb74
 /fVUA86WyQkxm30s2haekVGG5gcsgXJRoO+H9H+bq7RNVnILRowwSY1vkTEDEKj9PKmY9Keiz
 GfYnn/aU18lId+k39ymz2OyDeeVpL3Fs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aDvwl28XOZ40aj1scgOvTc2BOCO7vzPrS
Content-Type: multipart/mixed; boundary="E7zOYD2Pzejcvta9WwzEEfqIZivXJLrp4";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: =?UTF-8?Q?Michael_La=c3=9f?= <bevan@bi-co.net>,
 linux-btrfs@vger.kernel.org
Message-ID: <95e94b87-8740-b8b8-8766-2614a83c8d9f@gmx.com>
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
References: <297da4cbe20235080205719805b08810@bi-co.net>
In-Reply-To: <297da4cbe20235080205719805b08810@bi-co.net>

--E7zOYD2Pzejcvta9WwzEEfqIZivXJLrp4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/17 =E4=B8=8A=E5=8D=886:16, Michael La=C3=9F wrote:
> Hi.
>=20
> Today I managed to destroy my btrfs root filesystem using the following=

> sequence of commands:

I don't have a root fs filled, but a btrfs with linux kernel with
compiled results filling 5G of a total 10G.

I'm using the that fs in my VM to try to reproduce.
>=20
> sync
> btrfs balance start -dusage 75 -musage 75 /
> sync
> fstrim -v /

Tried the same, while I use --full-blanace for that balance to ensure
all chunks get relocated.

>=20
> Shortly after, the kernel spew out lots of messages like the following:=

>=20
> BTRFS warning (device dm-5): csum failed root 257 ino 16634085 off
> 21504884736 csum 0xd47cc2a2 expected csum 0xcebd791b mirror 1
>=20
> A btrfs scrub shows roughly 27000 unrecoverable csum errors and lots of=

> data on that system is not accessible anymore.

After above operations, nothing wrong happened in scrub:

  $ sudo btrfs scrub start -B /mnt/btrfs/
  scrub done for 1dd1bcf6-4392-4be1-8c0e-0bfd16321ade
  	scrub started at Fri May 17 07:34:26 2019 and finished after 00:00:02
  	total bytes scrubbed: 4.19GiB with 0 errors
>=20
> I'm running Linux 5.1.2 on an Arch Linux. Their kernel pretty much
> matches upstream with only one non btrfs-related patch on top:
> https://git.archlinux.org/linux.git/log/?h=3Dv5.1.2-arch1
>=20
> The btrfs file system was mounted with compress=3Dlzo. The underlying
> storage device is a LUKS volume, on top of an LVM logical volume and th=
e
> underlying physical volume is a Samsung 830 SSD. The LUKS volume is
> opened with the option "discard" so that trim commands are passed to th=
e
> device.

I'm not sure if it's LUKS or btrfs to blame.
In my test environment, I'm using LVM but without LUKS.

My LVM setup has issue_discards =3D 1 set.

Would you please try to verify the behavior on a plain partition to rule
out possible interference?

Thanks,
Qu

>=20
> SMART shows no errors on the SSD itself. I never had issues with
> balancing or trimming the btrfs volume before, even the exact same
> sequence of commands as above never caused any issues. Until now.
>=20
> Does anyone have an idea of what happened here? Could this be a bug in
> btrfs?
>=20
> I have made a copy of that volume so I can get further information out
> of it if necessary. I already ran btrfs check on it (using the slightly=

> outdated version 4.19.1) and it did not show any errors. So it seems
> like only data has been corrupted.
>=20
> Please tell me if I can provide any more useful information on this.
>=20
> Cheers,
> Michael


--E7zOYD2Pzejcvta9WwzEEfqIZivXJLrp4--

--aDvwl28XOZ40aj1scgOvTc2BOCO7vzPrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzd9QwACgkQwj2R86El
/qjIvgf8C9i1cNPNDo2SpzQFAMD69rjlmT4ixm3nr42OFsuYUPwRQ70B5IK4w6Qp
JlplIdpnSeZVrlhTrHdo2bXIXKyz3bGBcejEyYfIOPETmO9oLuwkaCBhb/YB84r7
Z1w0AV0VQE0aSg4aaflh6H5SFcr6xRESZHN/q8rxYE5WFIl88S6x/SSoUKqo0muy
BmLg2eUl0WC8SlsQJd9xz8DanTAroahX8kyFBQFsw/D5hiqCowjDrYequaPYaN9a
DjgBdFyFDTsr0S7knYZ7TrC1VXHUdcutf5spCXMGvq85Qj4+HUAR9OqsMZiry2+L
//XBzYnjlu7Iyc7IKBshVtL4JC+F7A==
=xO0V
-----END PGP SIGNATURE-----

--aDvwl28XOZ40aj1scgOvTc2BOCO7vzPrS--
