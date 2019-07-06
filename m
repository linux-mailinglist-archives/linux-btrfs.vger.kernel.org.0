Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9460F03
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 07:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfGFFBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jul 2019 01:01:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:56601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGFFBS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Jul 2019 01:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562389276;
        bh=DeuQWOBWnSptipandjOj6hEsXdm3reJ/ZFATZp+Azoo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=G2FWoxh0Sf6TMn4Zp6xDtddOrGGr270pkFKX5aBQBzPXKkHP7VjdjKyos6AL/dQsR
         gfx+2+g2207mv+uyQJSUjCwQVWdIfHO6dZpO/QpD4sg80V+AE3lLpihxsDW7ndtjBX
         +zZBeoYrLER42lR6s+81e7z92sXsiZGzz9Zc3t6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lg1Tn-1iHYbA2YkV-00pdyi; Sat, 06
 Jul 2019 07:01:16 +0200
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Vladimir Panteleev <thecybershadow@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
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
Message-ID: <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
Date:   Sat, 6 Jul 2019 13:01:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kqgdMM8wullSxqSip1e90ny6AhG3z7tzf"
X-Provags-ID: V03:K1:nn9W/Ec69MHNfMh+uQKBHr6l7/Y6Hn+nVfh0KbTkKerpDqxZ4pH
 ObkEfJRZb3ja4ovImjbm5tWjqoDmZS778ENaoaPki9lDbeGaiv3So3vBcRAiZqPVIWPuRT2
 JGY+8j7DPMgD1SCj93RghNq45NpTCYNnqLJ74m6CiZrMG/NM60NCO6aC2oB/g++rZopWB5j
 ZgWDApQugWjHMotwT1CYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qxwurUn/svs=:5x4rmnB832zRlhf5b2yH7E
 MbATptIDNJZ5dlJbVGLZ+a12CqcHonGX9j5sL3Q3/8NPRdb8X2ZmZS8/DuEx3r/oZZW4u79Su
 dlV2lkGfrJ0vOhWYitWKVuvNT4p57VLqXLZzuFtd299cqjeukiy3VDqs91BgyDQnSlK+tnvjp
 jeviW48mIW+s3MQ4WSzneThIvynNlSaZp/Wc+GizUAcgOU4mE+FN/QT4tzzdqH6wo9mhLFyVU
 bJFEaIgZNlGWdYkJGxqhN7F5FqaFBdfjowd7uv+e7qhzShxyvfWCHnZHPFIYTO9pVAXhMPVp+
 YCuNE+GjVxPb+5aIxv7YPbd6M+V8SA67al2HgM5OeoZbu45p/0NE0CT4AYVJyyG2drT9dF9cN
 g6Z9J8hhUzWGgSsD16GS0O94iEvXhPTHgFDns0ZpyaHPiFqutL6UOnM6gGER764r/WzpI/p4J
 2YDJ8Q80QlD3eF0uXtXXOOC/esY+L6fae/6/I+4N8tDX2E+BokuOZuq7ODaVrWpnV3/TWV1wy
 CMYru0KCKqPkw5IBPsbwkPGYGGa9uErejgukeaKCzJ+Kh2wJmElbbaqm16dnOfEyxo3LTnz7B
 iCST/kev5agKQ4wUR5kC1WV4M5H/1vbFFxhg4F3iDGGy9IFkflqXnt0L4+gT1W3f+3iq/r1vx
 Vq6UJrJJF26bRab9ZDGoloW8XpYt5x6ZPcB8EueAu9+U1Wv98dztKTr3y5fSRVOd6ZzDkxK19
 lMhxZ0RsG5M4F/hCmDoyM6L1INwpacZpZNV0ryychS/PoFHAtxFb53X1ml5zoXdYOjd4j1z4v
 TntDTVD4As7bV5jEliKs2VB19UvaQ+F7Vp/+Pjp1Xa3eo820Rs341CyYbs4ri8OgFSBBTwD9W
 2Or0BEQd6RVRyGiqDWSS4G9zbC5eRScsWROPCNoAAwRupo1BGhS3V+Wtyfjb75Rru1pJOhSqN
 SxATcbvbiRJs64pJVj8Np6Ga4A3BQZomNUQh0gpeKKsKPtceQlFHPW4uSc7478CewgGIgd6GQ
 H8TWuwdIIBHA/JUvcMqNWyO86K0aDVz3IN8a8DN8DULiWefJWoWQtiZHNi+TLO6w6Y3a3mjJp
 KlRWees8EKsIpk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kqgdMM8wullSxqSip1e90ny6AhG3z7tzf
Content-Type: multipart/mixed; boundary="FKpAL352ZPWIEvWDCYIhXlox2e6i010xm";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Vladimir Panteleev <thecybershadow@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
In-Reply-To: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>

--FKpAL352ZPWIEvWDCYIhXlox2e6i010xm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/5 =E4=B8=8B=E5=8D=8812:39, Vladimir Panteleev wrote:
> Hi,
>=20
> I'm trying to convert a data=3DRAID10,metadata=3DRAID1 (4 disks) array =
to
> RAID1 (2 disks). The array was less than half full, and I disconnected
> two parity drives, leaving two that contained one copy of all data.

Definitely not something I would even try.

I'd go convert, delete one, delete the other one, although it's slower,
but should work properly.

>=20
> After stubbing out btrfs_check_rw_degradable (because btrfs currently
> can't realize when it has all drives needed for RAID10),

The point is, btrfs_check_rw_degradable() is already doing per-chunk
level rw degradable checking.

I would highly recommend not to comment out the function completely.
It has been a long (well, not that long) way from old fs level tolerance
to current per-chunk tolerance check.

I totally understand for RAID10 we can at most drop half of its stripes
as long as we have one device for each substripe.
If you really want that feature to allow RAID10 to tolerate more missing
devices, please do proper chunk stripe check.

> I've
> successfully mounted rw+degraded, balance-converted all RAID10 data to
> RAID1, and then btrfs-device-delete-d one of the missing drives. It
> fails at deleting the second.
>=20
> The process reached a point where the last missing device shows as
> containing 20 GB of RAID1 metadata. At this point, attempting to delete=

> the device causes the operation to shortly fail with "No space left",
> followed by a "kernel BUG at fs/btrfs/relocation.c:2499!", and the
> "btrfs device delete" command to crash with a segmentation fault.
>=20
> Here is the information about the filesystem:
>=20
> https://dump.thecybershadow.net/55d558b4d0a59643e24c6b4ee9019dca/04%3A2=
8%3A23-upload.txt

The fs should have enough space to allocate new metadata chunk (it's
metadata chunk lacking space and caused ENOSPC).

I'm not sure if it's the degraded mount cause the problem, as the
enospc_debug output looks like reserved/pinned/over-reserved space has
taken up all space, while no new chunk get allocated.

Would you please try to balance metadata to see if the ENOSPC still happe=
ns?

Thanks,
Qu

>=20
>=20
> And here is the dmesg output (with enospc_debug):
>=20
> https://dump.thecybershadow.net/9d3811b85d078908141a30886df8894c/04%3A2=
8%3A53-upload.txt
>=20
>=20
> Attempting to unmount the filesystem causes another warning:
>=20
> https://dump.thecybershadow.net/6d6f2353cd07cd8464ece7e4df90816e/04%3A3=
0%3A30-upload.txt
>=20
>=20
> The umount command then hangs indefinitely.
>=20
> Linux 5.1.15-arch1-1-ARCH, btrfs-progs v5.1.1
>=20


--FKpAL352ZPWIEvWDCYIhXlox2e6i010xm--

--kqgdMM8wullSxqSip1e90ny6AhG3z7tzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0gKxgACgkQwj2R86El
/qiG9Qf/Y1yWJpwUBzlKnydzaaRxrqM2DY/Fz9Jh0HA5A0aAm7PMIUNuNNtP7a8m
uD7x+ZbKDmUzGJZOnLNgAN2gZI1fTt/PrdCgl9CBkwse/67/yQVBrLFDP5FvIuYT
DKo7BR5pzm36fn7I1sr+cST9wLEZbifhntHIIH8F1ulvBvzsRFJN/dLRoGPtH3uZ
QktQsHoUUpcXWH4tX2bulicPTbzoJUDepZ2ytjzcZttJ54MQYQW5Cr31zI7yUVlQ
S98OmS3FdAcLvTsr6uMpUQvse/BxEAjjnOdrqSJpNB57/sVoiL1VlKcn/4uRkywy
nGYg1+pDys+rbL1ToD4U3uzzg3QrUA==
=tDbi
-----END PGP SIGNATURE-----

--kqgdMM8wullSxqSip1e90ny6AhG3z7tzf--
