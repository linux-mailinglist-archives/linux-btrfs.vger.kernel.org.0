Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6445023
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 01:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFMXmA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 19:42:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:33151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfFMXmA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 19:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560469316;
        bh=KWddNUNKMAczWyuRGokCCx3fBB/b67kez3mRdR59eig=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Yww++VjkryJAZsnxKsJfEcNR+X894voq+iKi73rACma1XgKKKL5YLAoBdK9eti9ez
         Dx0aT90il6ByTvD7dO7r6wP6ti4OSRkmB7/ZvLZyqREJAWeUkY6WDyZkzOv5MFrHFV
         EjJzq1bjY/FpDzwWByoizHcIq183wUykAABuM+3I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7i8O-1iepAP43CU-014m6j; Fri, 14
 Jun 2019 01:41:56 +0200
Subject: Re: Removing a failed device - stuck in a loop or normal?
To:     Steven Fosdick <stevenfosdick@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAG_8rEfMr-MpQ4bfBs79aJybBE3ipOwN=yQDBM6W+bWprFz34g@mail.gmail.com>
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
Message-ID: <51a231b3-7f04-bcad-a3d9-3bec791850a7@gmx.com>
Date:   Fri, 14 Jun 2019 07:41:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAG_8rEfMr-MpQ4bfBs79aJybBE3ipOwN=yQDBM6W+bWprFz34g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YqxRaqFoI9Y56sgSaMxTTAobClkFd8VZG"
X-Provags-ID: V03:K1:2b3TGNGv5L1Vu+SgUwaPd3ksg5VWTVI2APD8RcllcZezbb5/YG2
 qFhWVWStRzihXgO1aohS6X5mxhiT/d4wQogCnwzIoAoeCJQf1VC4Tnes1Mb0TtFw8qrkQCM
 zv/z02KvGf2vMoKw6Aw28wLRHUu4dycgBHakHiQzLoMLw7WgeF306i3GLHhM9RY4Vx41TS6
 pmxi4RxejeOqMnUGbl7aQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RIi+pPqiWag=:v7zWtFXQEw/5zsp7a24DlM
 sHaKeg51irvMBKHDJV95ZNa7p1pHD7ZczX1izyMWXjsVbAaa30ez/ksROHFx7/EVq5Hc1HWIF
 8WhfIXql2dFmCOxOUvSvgp8EjYuMKox1wb1rAlppEZ0h/B8Tuwk0NUtAfeAGEhNjXfS+J7pTR
 eSQ+0WL7ahjF1Ja04IW9C2IVv/VGCEJXOtxgIJtwlU9YDxsA3FMIlwXOkQPnNrZJBsAZgcr96
 FnyQEmfofQBzTa908J2KKw2/eSo3uCOJhO4z0Swc8so4Dj3SRX1jfpeQWOcbAIevqM/HzHclJ
 e5T2hOT2Nr7B/qUUL18blO9q31JDfKNXtqylYMvWD9EJFDNdzXFCx0x5C87nYsH4f6pWzsd/0
 WIEvENW3+EdSYFzwpr1agGCmUj2KCms9x/UDp9MeEFP+uXK6lUH020PXkTQ9MNFxCBYaavwJv
 qoECBigdRooz3zi7/Gbk9aoXEB8Fzsc4zTidYip22GxaQE/gZgYb1fhvnKXQybvxYCdV5mhPv
 NsOScily807207umdxb1ddxW+VQPWOVqE6TNO8Nn0WTVT4gwobp3LqpEOysv+CKXZovoTRNqF
 OBbOr9SeTY05gFcNCW9qxyhQa+GNaI5jSdvGF46bPGoFtNeDoRXwsLd/eDo9O1lTVVvTgJ8Mn
 xgmfkZm8DBlQ4LVwweoxk350YBU+Add5GC2I0aoiuEJB6KurY8HZLXvNZ//46k1Et6df1Xh8a
 C9bYhpOh1hsq1UJYCV8pHCnUGrlWdSgRHJWT3zcFWuXJGtLg2IiGU24r0QDLyvCe+iPV9SgmV
 +I6hX3Qv6MbfqliH06jsm/xV4+YG4g8STQYaEvS5jZwlxyKH6Vz6UkazYexo1joKgVcBT2Fua
 fVQRnuBvhJ+dkUv/rbkXu4FEJW2q/aONLsq7V79Qn1+UpsH9RCdPRQyDItMf9GFjYrcYJRTTA
 9PPNeITIWeXSQUbhsdD/UZkbe9sNwEKo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YqxRaqFoI9Y56sgSaMxTTAobClkFd8VZG
Content-Type: multipart/mixed; boundary="1liRUMVOCZ72uXHDVPAsl3B6O1rx9vequ";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Steven Fosdick <stevenfosdick@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <51a231b3-7f04-bcad-a3d9-3bec791850a7@gmx.com>
Subject: Re: Removing a failed device - stuck in a loop or normal?
References: <CAG_8rEfMr-MpQ4bfBs79aJybBE3ipOwN=yQDBM6W+bWprFz34g@mail.gmail.com>
In-Reply-To: <CAG_8rEfMr-MpQ4bfBs79aJybBE3ipOwN=yQDBM6W+bWprFz34g@mail.gmail.com>

--1liRUMVOCZ72uXHDVPAsl3B6O1rx9vequ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/14 =E4=B8=8A=E5=8D=887:17, Steven Fosdick wrote:
> I have a BTRFS volume with four devices one of which has not failed
> and is no longer present in the machine.  The volume is mounted in
> degraded mode.  I am trying to remove the failed device with:
>=20
> btrfs device remove missing /data
>=20
> There should be enough space to consolidate the data onto the three
> remaining disc before adding a fourth.  The first few attempts have
> failed with errors of the form:
>=20
> Jun 12 14:54:36 meije kernel: BTRFS info (device sda): relocating
> block group 10436799889408 flags data|raid5
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519241728 csum 0x9cb8912f expected csum 0x73ba6e2a
> mirror 2

That's common if the device is really failing.
Raid5 should re-build the corrupted blocks.

> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519245824 csum 0x98f94189 expected csum 0x4ab823e6
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519254016 csum 0xd3f53909 expected csum 0x94ab4db4
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519249920 csum 0xcb29eade expected csum 0x65d28b9e
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519258112 csum 0x714821f5 expected csum 0xeed771e2
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519262208 csum 0x574f1bdc expected csum 0x5a78e046
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519266304 csum 0x63ec8641 expected csum 0xcee67afe
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519270400 csum 0xb3d8a215 expected csum 0x39db0f0a
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519274496 csum 0x910dd641 expected csum 0x3599ad7d
> mirror 2
> Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
> root -9 ino 272 off 519278592 csum 0xe6ca8bc2 expected csum 0x413d5da7
> mirror 2
>=20
> Deleting the files concerned allows it to progress further and the

The corrupted info is from data reloc tree, I'm not sure if deleting
files would really help.

> device remove has been logging messages of the form:
>=20
> Jun 13 21:14:01 meije kernel: BTRFS info (device sda): relocating
> block group 7956456275968 flags data|raid5
> Jun 13 21:14:36 meije kernel: BTRFS info (device sda): found 785 extent=
s
> Jun 13 21:14:46 meije kernel: BTRFS info (device sda): found 785 extent=
s
>=20
> The numbers obviously vary but the pattern of those three lines which
> the block group and two identical "found extents" lines has been
> repeating for several hours and the amount of data reported by:
>=20
> btrfs fi usage /data
>=20
> as being on the missing disc has been gradually reducing and the
> amount on the other three gradually increasing just as I would expect.
> Now, however, there is a new pattern:
>=20
> Jun 13 21:14:54 meije kernel: BTRFS info (device sda): relocating
> block group 7955382534144 flags metadata|raid1
> Jun 13 21:18:51 meije kernel: BTRFS info (device sda): found 51353 exte=
nts
> Jun 13 21:19:18 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:23 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:27 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:32 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:36 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:40 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:44 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:48 meije kernel: BTRFS info (device sda): found 1 extents
> Jun 13 21:19:52 meije kernel: BTRFS info (device sda): found 1 extents
>=20
> With the last line repeating.  So far there have been 9,347 of the
> "found 1 extents" messages with no other BTRFS messages in between.
> The amount of data on the missing disc does not seem to be decreasing
> now.
>=20
> Does this seem like normal behaviour, or has it not got stuck in an
> infinite loop, i.e. is it finding the same extent over and over again?

Looks like a dead loop.

Would you please provide the kernel version please?

And have you tried cancel current balance and start a new one again?

Thanks,
Qu

>  What should I do?
>=20
> Regards,
> Steve.
>=20


--1liRUMVOCZ72uXHDVPAsl3B6O1rx9vequ--

--YqxRaqFoI9Y56sgSaMxTTAobClkFd8VZG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0C30AACgkQwj2R86El
/qgfYQf/fQV7AZz6OXP5BGhmvcuydXX69aYr5EtHdmy44Opb9raeMLbyz0snJbLp
SsuzjMntPdtwImvA/bKqdizEtY6W9TZljaOsT9fxop8F0y/FsYplwe5MLfXC69GB
zD8saG0vvKZXy7ClKxwhNNG1SHX/3t9GYka5dSGcC5dkG8CvQdQlISEjRtuTzZYU
E5yRIi8NevoHjsCehDI9HHCtX2hAsnEw9YfhxaYtor8TF38s588DFTVDbzclHxqq
0o4VKbOG4IQjFIOLUBClJxa1pa45PEB7WMuumxMOZtv9W2Ig9P33OjKSnzHZdVGH
s/MxXN250hBur4nGzfxTLT815xcTVw==
=9Kge
-----END PGP SIGNATURE-----

--YqxRaqFoI9Y56sgSaMxTTAobClkFd8VZG--
