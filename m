Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535C455219
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfFYOhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 10:37:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:43503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfFYOhn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561473460;
        bh=1AcYKt+e1chQd6LU+v+xVYthmpRqLBGuVqtULrhIl/4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=V3hQB4Dp5KQ5RNDrk0zij/bWIpSGtNrJvwv40SQnV/WJRJ2wMymZej/mjCymKFgpB
         +12OmCNnazQB6/oZWpWR/ehjB3zjtzz6K1qERG6wfQK2/iiAVPcWg6q00L41C10eP/
         xny6gBEP92Z5n9KyY5k/iWBtic+OE/9RDmw/gW48=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1ihU6a1joZ-012rir; Tue, 25
 Jun 2019 16:37:40 +0200
Subject: Re: CoW overhead from old extents?
To:     Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org
References: <20190625154155.7b660feb@natsu>
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
Message-ID: <3ad17ed7-cbb9-dc86-816c-afd22f2119af@gmx.com>
Date:   Tue, 25 Jun 2019 22:37:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625154155.7b660feb@natsu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fm9UymrIeKJe9S89ONeJhpc6uRWA7L4lm"
X-Provags-ID: V03:K1:qVzBfO31MIaslBeV87P1KCLsEPpwxPAYpOEERXiII+QuUUUGHa0
 GLplIMimw5ga9+HvR+n0W3g9eSlH4khZKA+BOirwtblcuHz/M77ZmsGaxppD0nDeFAfozNP
 Rp3iXhnjQBvxgPZ1bOGdG7fDUASpEP0ihy+1efEZLDXSfcEfG8HQial7kZY9B5uH/xEIMoI
 mBMQDke2P1ZXI7WEFZUjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4sA2gCyUoU4=:YdfPl5AanMznt3L/gP7h1u
 TTdGLFYzu+4QrYQEr+ctScOAn2EIQHyTAqexLCxkudsUQ3udTJqIz6u1kBMHwc3qcVXDtKT0h
 lEnm2hhxnY+YDAEr6l2ODOOAXvjlmspMh8plgkCwE0o+oYmH4af0IR5znlm8ezYBODsFGayuD
 XqmynChcpf3dg6kz+GvmB8MYyvnaAA+9+jA/UmKQTVdzvU36n/CHqMbSo0Yr1YeIXImpjs39m
 D1jK/Ys4lRt2gYkN/kZ5hDzuGphm9Fz1b2g3c77PuY9GtgT2CIsSIHJwvd6V3hLlCkDfuI/2G
 FFP05mToF7aZP7AVHXUyeaLbhfdrzjHqDCyhHzKfqvEExPj5PkIbaaRmr2Yz6Y6VzeSEH14ql
 IZBGv6L5ifnBL3Zb2vc84bpdezMyg0+hubwOEYrRCVGb6UbxSPi1174LfUhien1we3c+2qqCk
 DIncCQC75SBT11FoPkQU9HPSNNWigm1PjkIfCKJntxgKIXAl+4v3JnP3TLf4jAJivQj9gOL0E
 ZXeXmUSYKOWn8LuC1a1FAmZGik4s8Ore1i8qWGT8q5D63vPaE0eDRxcSSlci5PNuXSHgmFA48
 5SiJ9umKXvdaJ+Xje+w4ZjxfiSPjJQEb4YNhQ0gIQbgWdLd5TM8s1+A4lzTa7rabyBx/5ni9p
 MSdaTUdUaTcHjwnVaEDHUoGIAuFJ61KsoLHWuRhT8Pn/YHh3dQAYria4WAyRx59aZpMuBULvz
 n8d+kzmXhqMDC2yGcaq81iOXoImfybC1Lkd2qLMKiuwCOANAkELji+RTGeqrlWYYWc/9PLJYW
 WUEVh3gQMrODBZlnNpJzYaW0DUn01LvgQgb5etFR7WODRHS8xLYKjs156B1hyLtT9J6uQF6YX
 BxJtwqlmOpyfXKyACvxz0qZdP5ghp622dKhgE2I9hzZCC6sb60puvHcUzc35SK1kaDzW7z6cV
 2BpGPW/fuXNhTLi0zbLGn+9r4yHkPM+cwPuYbOOOKyZyggkv7KBiUiCOf4dtEzfc1L1hAyuFh
 n/pyEUngUBxgg0as3Rv4SOXh6GCepcicxREcjVNSrlho6hpBYAc3aQZrJgwFYjU1gLwk9bH1c
 KFFcXhZ/QLQxYg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fm9UymrIeKJe9S89ONeJhpc6uRWA7L4lm
Content-Type: multipart/mixed; boundary="oJRQbxsnsLMjaLMuMY3bIFCpQfvJ21KYH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org
Message-ID: <3ad17ed7-cbb9-dc86-816c-afd22f2119af@gmx.com>
Subject: Re: CoW overhead from old extents?
References: <20190625154155.7b660feb@natsu>
In-Reply-To: <20190625154155.7b660feb@natsu>

--oJRQbxsnsLMjaLMuMY3bIFCpQfvJ21KYH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/25 =E4=B8=8B=E5=8D=886:41, Roman Mamedov wrote:
> Hello,
>=20
> I have a number of VM images in sparse NOCOW files, with:

NODATACOW and no snapshot?

Then unless some thing like balance or defrag, it should mostly behave
much like regular fs.

>=20
>   # du -B M -sc *
>   ...
>   46030M	total
>=20
> and:
>=20
>   # du -B M -sc --apparent-size *
>   ...
>   96257M	total
>=20
> But despite there being nothing else on the filesystem and no snapshots=
,
>=20
>   # df -B M .
>=20
>   ... 1M-blocks   Used Available Use% ...
>   ...   710192M 69024M   640102M  10% ...
>=20
> The filesystem itself is:
>=20
>   Data, RAID0: total=3D70.00GiB, used=3D67.38GiB
>   System, RAID0: total=3D64.00MiB, used=3D16.00KiB
>   Metadata, RAID0: total=3D1.00GiB, used=3D7.03MiB
>   GlobalReserve, single: total=3D16.00MiB, used=3D0.00B
>=20
> So there's about 23 GB of overhead to store only 46 GB of data.
>=20
> I vaguely remember the reason is something along the lines of the need =
to keep
> around old extents, which are split in the middle when CoWed, but the e=
ntire
> old extent must be also kept in place, until overwritten fully.

Yes, that's the extent booking mechanism of btrfs.
But not the case for NODATACOW case if no other snapshot.

>=20
> These NOCOW files are being snapshotted for backup purposes, and the sn=
apshot
> is getting removed usually within 30 minutes (while the VMs are active =
and
> writing to their files), so it was not pure NOCOW 100% of the time.

Completely removed snapshots still cause some CoWed extents, which
breaks the NODATACOW flag.
Remember COW is the default behavior for btrfs, NODATACOW is kinda
second citizen in btrfs.

So that could happens under certain cases.

>=20
> Main question is, can we have this recorded/explained in the wiki in pr=
ecise
> terms (perhaps in Gotchas), or is there maybe already a description of =
this
> issue on it somewhere? I looked through briefly just now, and couldn't =
find
> anything similar. Only remember this being explained once on the mailin=
g list
> a few years ago. (Anyone has a link?)
>=20
> Also, any way to mitigate this and regain space? Short of shutting down=
 the
> VMs, copying their images into new files and deleting old ones. Balance=
,
> defragment or "fallocate -d" (for the non-running ones) do not seem to =
help.

IIRC defrag should solve your problem as long as there is only one
subvolume owning that file, and all snapshots are completely removed
(subv del just orphan it, doesn't ensure it disappear on-disk, but
normally after some transactions deleted snapshots should disappear).

Balance won't change the situation at all.

And fallocate in fact would make things even worse for snapshot.
If you fallocate + set nodatacow, write some data, so far so good,
everything acts normally.

But then just after one snapshot, even writing to the unpopulated space,
they will be CoWed. So it wastes more space!

>=20
> What's unfortunate is that "fstrim -v" only reports ~640 GB as having b=
een
> trimmed, which means the overhead part will be not freed by TRIM if thi=
s was
> on top of thin-provisioned storage either.
>=20

Fstrim has a bug, that if you have balanced your fs several times,
fstrim will only trim unallocated space.
It should be fixed in recent kernel releases already though.

Thanks,
Qu


--oJRQbxsnsLMjaLMuMY3bIFCpQfvJ21KYH--

--fm9UymrIeKJe9S89ONeJhpc6uRWA7L4lm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0SMa8ACgkQwj2R86El
/qi2/wf+Nv6hut5w9iSYAIIC3xr0fY5HFosunqYVWvvuulgVmcDqGNhWWZIxk48Q
+Fcnx1I7MNhmzq9gxy0NLuklNvgzW4/nU8thCBS6MLWUx/MpnvVmBeNI8mYDaBPZ
4GzldBQHcyPkvbsZIbvIR2DSOLCe5miAZU2MWViI2k9BrSLWLI2yAXeAGOBxZVdW
BucpnZLARZz+RZILEQmibiekds8EHPjdjFAsqBTnsOATGV3zQk7VJVFEzWzHz3Gz
LX9azeyA6K++uHhzKr40gv2fRd2fTYx1zfvnH7MZtWFIvwmNsrcqaFXWI4WRj0AJ
D/lfY3kadksy2FUsfQr5RjS6MwVowA==
=iMkL
-----END PGP SIGNATURE-----

--fm9UymrIeKJe9S89ONeJhpc6uRWA7L4lm--
