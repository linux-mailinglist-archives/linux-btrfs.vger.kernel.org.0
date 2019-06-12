Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75151428BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409333AbfFLOWM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:22:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:42321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfFLOWL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560349327;
        bh=iyxwzayH5NNGV4ncYc2JKijh0S2iGV6XzCH2b2htSFY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IEIpNS/HKDA0n89NhLyMsnzQ9lCtEarQ8kdtqIYUWjCcLN9RoJ2pLfyS7rAvEzjzo
         bWoVAgkEz3oc58AgiduWjVkpYr/ZSmwZiytNpt5xuKNGZ3l1B7paxsQsSYCnsRoA+r
         nsG4Gm3oLSqTjg6Z0en00gKcAZ4gV2Aas69oqlU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LjZhg-1iCakI10lk-00bahs; Wed, 12
 Jun 2019 16:22:07 +0200
Subject: Re: btrfs progs v5.1: tree block bytenr 0 is not aligned to
 sectorsize 4096
To:     "marcos k." <Marcos.Ka@posteo.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <3057842.IWvHFmXsFP@ernsv0> <2675522.6BlBp3bEyT@ernnb113>
 <1acbfdec-0e7e-7be7-3612-7dea01db4df2@gmx.com> <33202605.PZYGi36h5c@ernnb113>
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
Message-ID: <add32e99-e4fd-1a5e-8294-b6de299db16f@gmx.com>
Date:   Wed, 12 Jun 2019 22:22:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <33202605.PZYGi36h5c@ernnb113>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ireoL4NSBemhkTnkvdTSI32U4HvzwDWK8"
X-Provags-ID: V03:K1:2jFAGwJQu+1CQru4Eg8bzpZYT5s7+lNEMpBQDQsxQxKzAGqpVZE
 GFrBPLMBSsN0qY9yfS+1fWbSZM95J+8Y4Qh2UMYDc+69pEU88KqfMEM+jsdrf/pyDzSOJrk
 UbrN7LcWy2HoHJwQLxGHzd5exeKeDwjuh4mptYq1AwkcUbY5Yx/EB7KXv3wFjKZwGgrFKdd
 zmOWQQNnzwzeUX6XqQ+Jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aTqR2BuguUk=:mUrDE1QrTswSn+o6NL8t8h
 RftaME0pf54o3AoSzBJij+lAuSXOUlyyT3r6nywlwVmQeaZtVM+sqfPkos0tknJBJ4AlUtw47
 3Ya1CNA4HPRq74bCqb0cGHq/V6XVZe31E1m+QIW0SnUugqRwZwHxSTfTHN3O+z8F77e4FGoMV
 YRRfUqQWOJUDSJI/z5MVOampCzIwTjQF4iD96SNNGlU5CJDbZqndckfw5BjaPa9hLai1vlJHn
 KaiWqN1Miqtwgk5QuUuGvvSwEerGeXcJhpw7hJD+qsHkw5rTlhvKUjG1219+kXeNaC1svOfC1
 SV7KVHgPu2GK0LdYRmHLjcNO3s274+IYWBigEAMATmy5FNB5hn8vgc9JfhvqtQ9NZGZX/thwp
 tB1iSZzFJkTKkH1OjU9LzDDZCtOh+u3TFIT8e1DpGV1137L0DVyQvrgnA02P/XPJ6Lhm1Stct
 Y/xQouo5d24AlnwwGGyKkD1RxhSL+cJqWhJpLS2ZXpf22pB6UypMzeszXu/9e8iqocfrGzDm7
 dh4QSqVeUBF7VFWGfALBeiWYc7RzT1trlHBmQllTizvp8V3jtg/NmpsCrOmgq+4leHWYUgRtJ
 U/SI41fmrPsFFdHhQckLgpiRFjkjNx37B4XW11wz+x0Ut1ArXjoPNwiq7M6l0DhWs6vSi0P2B
 4GZMhUQOjYWgP6a2p3KGpsaPlNfKLnz/AwNnuFOat6PuQXBv5DfEq5NgGMDSAKkct8JbTVhDk
 J7ofG7H1iY0W1RhrLdxG0tzGNKp2lSnUXX226dJDamFUsSqaSJE7CppX/g9jhUbedtWSNo4fS
 do4iIKMtmEveeC4FwxVjSfor1IFyW12ctFHMJxkqIvrvChq/thNS6i2wrgn3+qUnDSgqyN1Rs
 vnuoN1Yy7pT35jyoUIOf6yXaxFhArUOivI4XADAe8wonXFaSbL71DwmZfxhArFVNONleeh7bZ
 2PuRj+JJVyDADYsOwzTIN6Vz1L9rBhJU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ireoL4NSBemhkTnkvdTSI32U4HvzwDWK8
Content-Type: multipart/mixed; boundary="lxurSxFMcaFWvU8iPOmIuNG097VuRTmX0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "marcos k." <Marcos.Ka@posteo.net>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <add32e99-e4fd-1a5e-8294-b6de299db16f@gmx.com>
Subject: Re: btrfs progs v5.1: tree block bytenr 0 is not aligned to
 sectorsize 4096
References: <3057842.IWvHFmXsFP@ernsv0> <2675522.6BlBp3bEyT@ernnb113>
 <1acbfdec-0e7e-7be7-3612-7dea01db4df2@gmx.com> <33202605.PZYGi36h5c@ernnb113>
In-Reply-To: <33202605.PZYGi36h5c@ernnb113>

--lxurSxFMcaFWvU8iPOmIuNG097VuRTmX0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/12 =E4=B8=8B=E5=8D=8810:12, marcos k. wrote:
> Hallo again,
>=20
> =C2=A0
>=20
> On Wednesday, 12 June 2019 15.47.49 CEST you wrote:
>=20
>> > The patch helped me a lot !!! ;-)) After compiling a new btrfs
>=20
>> > kernel-module with your small patch, the filesystem just mounted! Af=
ter
>=20
>> > a "scub" and "balance" of the btrfs filesystem, it could be mounted =
with
>=20
>> > the regular btrfs kernel-module. So far so good ...
>=20
>> >
>=20
>> > After another full backup (rsync) of the home-directory I checked th=
e
>=20
>> > filesystem again. The btrfs check indicated a lot of errors.
>=20
>>
>=20
>> Would you mind to share the output?
>=20
>>
>=20
> Strange enough I found a "check --repair" output of the corrupted
> homefs. But the filesystem does not exist any more. I will attach the
> output.

So indeed some corruption.
Some corruption in extent tree and some in fs tree.

I'd say the corruption is pretty serious, not some simple one.
But surprisingly, the btrfs-progs --repair doesn't make things worse.
Either you're using the latest btrfs-progs or you're lucky.
(older btrfs-progs could easily further corrupt the fs if btrfs check
aborted).

>=20
> =C2=A0
>=20
> The png-files are cached icons from "~/.cache/thumbnails"
> . It seems that most of the errors are cached data.

To me, it looks like a failed metadata CoW.

Would you mind to share about the layout of dm-2?

Recently we have some reports of failed data/metadata CoW on device
mapper devices.
Not sure if dm is contributing to the problem.

>=20
>>
>=20
>> If scrub shows no error but check reports, then there is something wro=
ng
>=20
>> in metadata, but not some serious corruption to prevent btrfs to read
>=20
>> the tree blocks.
>=20
>>
>=20
>> > I tried to
>=20
>> > remove all files and all directories (except the subvolume dirs) but=

>=20
>> > cloudn't. I tried to check --repair, check --init-csum-tree
>=20
>> > , check --init-extent-tree the remainig files but without success.
>=20
>>
>=20
>> --init-csum/extent-tree normally makes no sense, except some special c=
ase.
>=20
>> And if --repair doesn't help, we need the original output to determine=

>=20
>> what's wrong.
>=20
>>
>=20
> Yes I read about normaly not using --init-csum/extent-tree. Therefor I
> did "check --repair" on the remaining files and dirs, then tried to
> remove them, then did another "check --repair" on the remaining files,
> tried to remove them .... So only after a lot of tries with "check
> --repair" I did a last test with "--init-csum/extent-tree" and another
> "check --repair", which did not help. Some dirs e.g. in
> /home/user/.cache could not be removed.

I remember --repair should have the ability to repair mismatch in
INODE_ITEM/DIR_ITEM/DIR_INDEX.

I may need to double check the repair code for that part.

Thanks,
Qu

>=20
>>
>=20
>> Thanks,
>=20
>> Qu
>=20
>>
>=20
>> > I had to make a new btrfs over the old one. After copying all the da=
ta
>=20
>> > back, everything is good now.
>=20
>> >
>=20
>> > =C2=A0
>=20
>> >
>=20
>> > Maybe a switch would be helpful to mount "old"-btrfses. Some user mi=
ght
>=20
>> > not be able to patch and compile kernel-mudules. At least everybody
>=20
>> > should be informed to balance his "old" btrfs.
>=20
>> >
>=20
>> > =C2=A0
>=20
>> >
>=20
>> > Thanks a lot, marcos. k.
>=20
>> >
>=20
>> > =C2=A0
>=20
>> >
>=20
>> > =C2=A0
>=20
>> >
>=20
>> > =C2=A0
>=20
> =C2=A0
>=20
> =C2=A0
>=20


--lxurSxFMcaFWvU8iPOmIuNG097VuRTmX0--

--ireoL4NSBemhkTnkvdTSI32U4HvzwDWK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0BCokACgkQwj2R86El
/qgHcgf8D04meBEogHD0jKpb6RFVko4D0tJTFlcO4lerpcWv5fAURbJ/hVKixdT1
pQsZjvYEAo8k8FGfHZcHDq4eWTUeWzkC40uRL6ctIHNhTUGnP0eJ9aaOgAZUPns6
PGOYOmFWdbErSa7D53MAN6Ljh6CYOpjCZ0Q9WRKKIJ++CCdqtLBGA72wKcFYcp/W
kdIp3xx8PrnYdBLPQtubNhKOtP+MFuDMb5cCz13zefiJZnl7xQBk7FFBSJNc3+5W
NXjtq203mw4+ApyiAaJChAtFe5dirAVax8lGpygFGFAGtHupUN5yEKRcxDY4ua+Z
ErQhvlRNfPhi+1EWyVlwON2j5C9T3w==
=X7/Q
-----END PGP SIGNATURE-----

--ireoL4NSBemhkTnkvdTSI32U4HvzwDWK8--
