Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB69BD31
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2019 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfHXLBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Aug 2019 07:01:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:34837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfHXLBT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Aug 2019 07:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566644470;
        bh=TeZMt4EAsrGfLycY5YswpaF7HYztBNshsHzvJ0xdc5g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Pvi+XqFRdHxMpz64yOf3L+43kVDguhtSbpwfAoTWHJoahKLbpW+BV71TMubzmxeqZ
         GyU+Pyj+aMgJdLdE25IpaB90gou5EwjI+OfTN6wADbz3hfsPOoI6GelbPDTMr5ekdW
         j4PgHHVvBCdrbYFMzFWDsBbxJYGh9lblUIgtGXrM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzFx-1hjfvQ1GfR-00I01v; Sat, 24
 Aug 2019 13:01:10 +0200
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
To:     Patrick Dijkgraaf <bolderbast@duckstad.net>,
        linux-btrfs@vger.kernel.org
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
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
Message-ID: <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
Date:   Sat, 24 Aug 2019 19:01:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="boWgZKuIX8Ym8gWychlutjJyQCReWKeWk"
X-Provags-ID: V03:K1:ff5XI/JNOEEDf/xD5N8DzcozKqFki0RPAT45f3wmf1ejMHbwE/D
 NXr3KwR8l/U3dK2c5V7ktrNAfGbCSTBMmHvcXx9vX1L/s6Gr403AZsRJ0DrVZM7bgRH/RSr
 87RPFiqAOz4ZSHUfYqYEEMR65mmqPbrVMghG6AZFoOBzYcSa2aFKrsoftsm3Ik1AhnZ1l3K
 VMzJmR/heO+IJ4lBT8N2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tzkYe6MgCRM=:or3VTIUgj3zcyq42LqZhD4
 JU3od+SiuvnTa8q7il2eoAwhl+fYDaorAlZbl/M76zQRpN7YUw/3dik7iu3NSEqinWNe/+zCz
 rObI9SqtIDN7dUWIOlCvFLFAS0z622OxBoS0kDNF3RyFMnJW9v/MKdjy1EJVOcn2KvF1fFy9s
 ttR/YJKOe7jl6AgC31YT5jkeOYhVuFW2yrTDJipseUNjKh5PuFAZDYg3J4JOc8jaBlvUBV858
 g5eGORpncA13OmflPFo3lwkDDB/EHAyQTV4xIETvFULetBzYBQafosWd5fOqQME48pf/WfYlp
 nRocxeGx1E2nxsukytX1BtL+rim2NJ+eQTga0yH2DrdBP/FF5ietFRNfmO+gjXpXLdW4Goilw
 KidDlcH3SfZYxVZ4CqzShusJnJMaIBdoQun5FIZ38V3lfTzu6psJ/W0J7/nW/nQ574b3Fx99+
 +JbzQ71UC6NpRZ98ITBsxG7DZCC6h7sJ3CBcJRFKrTPBYuHMexppWoL4RBqiN6bA3qhIgZda0
 2AwbjBEFbwai1KUtRwfh1e4AfvXcKMddYN/Ue8UdqK2L88Ee1kgb6NznZHF/46U/zL64Xcrt1
 UeSl9CGxOMyF24QVLMaCUczPgCl1A1Ltp9HerbG1peW7TaJg/M2RQl5latNWDy/Te8pECSVJi
 alH3ZTQmgAqCYnAFA1SXVGH9kcBHcyZnVuZYemPSeERpV+M+A927RCmQ7In/l7qKNSg7GAx8R
 JbULNUKj0ezLdQ1l+uXcgahcv0v7TyRtnY7IHaU8uxiugjvi+piF50NcRYBGJHUBtl0ZgJL07
 H5YjQHGnyOiTbbL8emiuj+TfiWKBLXaHC+ILz2hRi5nuaySpYVtmrx6zUUCA3BjW5B8oYLC4P
 Sr4IWEV44tBKig8ycFZb6PLlpRVxRIRnQdl91Hm0zMqaCWsPtEhpujv3Tet294iCmv23Id4xS
 +rq1mnmyN7Nnx1atqbl45Xhc6mLgkAE7fvwHSyWhcujKlFCrJmsp8qpMplQZ/JiiEy+bJJZOj
 i9MeADZ4QdZjPbFdKNGdXfIqmZwtuWt8NWfVxX7hg5ZrBwRQoFFOVpgqAnz1xIuYTkq0PYscL
 r4i0xfIAH+B1hlQGrws4eZxVpgQN3lG4U+M9fNVKsc+e0dAcwaEQpNmng==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--boWgZKuIX8Ym8gWychlutjJyQCReWKeWk
Content-Type: multipart/mixed; boundary="GJa6fpsjSva7lJxRhv6wpdx06uH38udFG";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Patrick Dijkgraaf <bolderbast@duckstad.net>, linux-btrfs@vger.kernel.org
Message-ID: <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
In-Reply-To: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>

--GJa6fpsjSva7lJxRhv6wpdx06uH38udFG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/24 =E4=B8=8B=E5=8D=882:48, Patrick Dijkgraaf wrote:
> Hi all,
>=20
> My server hung this morning, and I had to hard-reset is. I did not
> apply any updates. After the reboot, my FS won't mount:
>=20
> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): super_total_bytes=

> 92017957797888 mismatch with fs_devices total_rw_bytes 184035915595776
> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): failed to read
> chunk tree: -22
> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): open_ctree failed=

>=20
> However, running btrfs rescue shows:
> root@cornelis ~]# btrfs rescue fix-device-size /dev/sdh2
> No device size related problem found

That's strange.

Would you please dump the chunk tree and super blocks?
# btrfs ins dump-super -fFa /dev/sdh2
# btrfs ins dump-tree -t chunk /dev/sdh2

And, have you tried to mount using different devices? If it's some super
blocks get corrupted, using a different device to mount may help.
(With that said, it's better to call that dump-super for each device)

>=20
> FS config is shown below:
> [root@cornelis ~]# btrfs fi show
> Label: 'cornelis-btrfs'  uuid: ac643516-670e-40f3-aa4c-f329fc3795fd
> Total devices 1 FS bytes used 536.05GiB
> devid    1 size 800.00GiB used 630.02GiB path /dev/mapper/cornelis-
> cornelis--btrfs
>=20
> Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
> Total devices 16 FS bytes used 36.61TiB
> devid    1 size 7.28TiB used 2.65TiB path /dev/sde2
> devid    2 size 3.64TiB used 2.65TiB path /dev/sdf2
> devid    3 size 3.64TiB used 2.65TiB path /dev/sdg2
> devid    4 size 7.28TiB used 2.65TiB path /dev/sdh2
> devid    5 size 3.64TiB used 2.65TiB path /dev/sdi2
> devid    6 size 7.28TiB used 2.65TiB path /dev/sdj2
> devid    7 size 3.64TiB used 2.65TiB path /dev/sdk2
> devid    8 size 3.64TiB used 2.65TiB path /dev/sdl2
> devid    9 size 7.28TiB used 2.65TiB path /dev/sdm2
> devid   10 size 3.64TiB used 2.65TiB path /dev/sdn2
> devid   11 size 7.28TiB used 2.65TiB path /dev/sdo2
> devid   12 size 3.64TiB used 2.65TiB path /dev/sdp2
> devid   13 size 7.28TiB used 2.65TiB path /dev/sdq2
> devid   14 size 7.28TiB used 2.65TiB path /dev/sdr2
> devid   15 size 3.64TiB used 2.65TiB path /dev/sds2
> devid   16 size 3.64TiB used 2.65TiB path /dev/sdt2

What's the profile used on so many devices?
RAID10?

The simplest way to fix it is to just update the

Thanks,
Qu
>=20
> Other info:
> [root@cornelis ~]# uname -r
> 4.18.16-arch1-1-ARCH
>=20
> I was able to mount is using:
> [root@cornelis ~]# mount -o usebackuproot,ro /dev/sdh2 /mnt/data
>=20
> Now updating my backup, but I REALLY hope to get this fixed on the
> production server!
>=20


--GJa6fpsjSva7lJxRhv6wpdx06uH38udFG--

--boWgZKuIX8Ym8gWychlutjJyQCReWKeWk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1hGPEACgkQwj2R86El
/qiCrAf/Y5kvGT5Fm355qiHR2iZWCKy6j9gURcpAZZnF+YTuMuV9F/aPxdfa9WLo
TeL8dDxvjAKse8qbJeQ+Xz7u2rLBzXlx6sDo0iPnPRv7Mfvjl7W3g5hahLsLMlrB
BLgp5CcvnORbM10sFxIe528GismRcKWu7blWmgvHjWBxYyfCT5QmdJmlsN/gOe5C
du7YklX5Vm22fmnKP2/0toyuLNVfm6BQPiRp40cr4s5sAYBn6uGTiuNerFayy0a6
pxIVZvYIKdsB1gpZLPiv9WPxFLWZ0ngSZvvDbm3lokXuFxpay0EUuwRoygkj5B8S
EaiO/GZsMMH1X6TcI3fuQlnaXzbVxg==
=fId8
-----END PGP SIGNATURE-----

--boWgZKuIX8Ym8gWychlutjJyQCReWKeWk--
