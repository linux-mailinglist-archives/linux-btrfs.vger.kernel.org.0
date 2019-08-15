Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016178EDB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfHOOIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 10:08:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:33537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732334AbfHOOIS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 10:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565878070;
        bh=lCC2Ybei/1DodmVKYwk+5U4I589v8j1MIavx6cuo3QA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=F/PdbWXMd8hSSOU1aI2SoYsx0O7bLGu2u7tOj6n2TZ4cfhOScCkV4jZvZKa9VPOef
         HgYzuktHOHd5kkcbi/yIB92l/XkoBSiNWjMcmeZs9MdEL2CMMJ+InOzxaTzPIvsNIL
         TGU5MnnRidgfS0uTKM55v0Tc/3ZulPoTy/xGxnIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp9i-1hm5Cz1xhk-00YBqI; Thu, 15
 Aug 2019 16:07:50 +0200
Subject: Re: recovering from "parent transid verify failed"
To:     Tim Walberg <twalberg@comcast.net>
Cc:     linux-btrfs@vger.kernel.org
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
 <20190815135251.GC2731@comcast.net>
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
Message-ID: <b871da91-1330-f8c9-add8-858025a91fc9@gmx.com>
Date:   Thu, 15 Aug 2019 22:07:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815135251.GC2731@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7I4halIGC4K6OeJmh2NkokF4zgdgaYLwW"
X-Provags-ID: V03:K1:Bw7oFW6kodXQeL3jwSIhViQPPedYAgzO/PC18y3jAs82Exhi/il
 rVcSnYVDxzCzMSCXMnCTeAHueF3f7KuMnicTk/ABB+kaPcdgCwyfAkIAb8zWOu/Da5kh0xW
 MRhulIN9Hoqs2YdXGr8q4xvWk3kudvJiYieE5LdzlXxIMF/wZvHU1GifCS5MpKdrJEeQc/N
 dOPcOeuQ/p85j4qJyylow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UfMuB+dIcS0=:K0E5yk+ohej9ljrKsqicBD
 pYCScVMBHe76pBf436eTrvP5kfKgBCH40mSpMsEww2STK7l022QKivFbZz4aEs1qFR596zXnZ
 6rZUwNqIja/jZmCjr/SlDgNRHUkbS60BIuLyKNPqt6ZUwd0qPP+RSGeA+O7ZFlVYRze+v8aRi
 jxfChGXsjKWePsmOIlOowHLcQkZ5DiVWaBgZVRM+oZ4zqfMlCcvo1kgpODer/oS0jYdJxdciX
 HY4MPhwEkZfSWWa1tw0ISythNc0uqN6Ayd8CceYzWGH33ZL06GkCex0nUaunRA2bswIKJzlCp
 stj96A8UIyjNhNE03BD6apcqP14YcDy0VeaNrgbFG9t16qRsuf734wLhSqSXMFv/wNxi3Jeao
 Ho4noI/hFKBHjxfYRWHOlnRDiQ10Kn4N2InyblDS8dAY6mudscpAzd1ii6+d/mHZgqpt4U7Ki
 UQ1HpYy6qPiecVQltEeCSZjlNHdVhTuH7TE2CltSHuUXa/DWZZYU+6duqA6SqpM1d2zGB+gD/
 HbbrlzNcYbgDkDQ2NnJzKIZ4kOpIlxqgwGpf6Vz8H5b3arxBucRzyjxe7lznIcqtoXGaB3KqF
 DhTiP6WKaxDyxDdkAT6vzUgaHzj47VR7qlyhQlZ+7B/OLKCm98nhpb1n8zZghsLYTgHiSNtSb
 k1sjFQAWpDc7SeFouwXbMEpLFnqxC82kbNRk6mI4l25TS6me3Td62DHVoouTbipltfr5gZ6CB
 C425CTauII9h0K5EaKDggPZzurXJ5I1Z1qatExafwZW0H9wKzsE6xxwoEmNRlc+b4yKnGQsHL
 +aMDTw1kc707GL9534d3wVLHfZeCZvlyEf+dNCfvX0/VhLUNH+FjUIob0mgGVe4vGsesrzhX5
 OFoBDVEFQJQZ0NGNfCSaQokIFitDtC41NjmI3tXythXahOnAUwC7g9ORUd9v4RTMEBBLQEBPx
 6EIceE/FxqtC6u87WMtqTHgYwsgi8AmyRerBMTt6zhR55HrcnUVQ7G8FmeK8Rz7mT2LCJWKTy
 Th+25GOw0sdhUmlPr+MaJfA7oHl6FrH7eb8vt3K0Yiscq0uUg6m/Yd5nY9tW8yDRpm8/F9RR8
 nUzK+pnU1Q8K9b0FRokv0fSFHnYy8fQUgVeQ69enf5FJ9Lk9jfWI1p76Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7I4halIGC4K6OeJmh2NkokF4zgdgaYLwW
Content-Type: multipart/mixed; boundary="hcN47UO100L6NiRS0h5lIisv5cgE06V7W";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Tim Walberg <twalberg@comcast.net>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <b871da91-1330-f8c9-add8-858025a91fc9@gmx.com>
Subject: Re: recovering from "parent transid verify failed"
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
 <20190815135251.GC2731@comcast.net>
In-Reply-To: <20190815135251.GC2731@comcast.net>

--hcN47UO100L6NiRS0h5lIisv5cgE06V7W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/15 =E4=B8=8B=E5=8D=889:52, Tim Walberg wrote:
> Had to wait for 'btrfs recover' to finish before I proceed farther.
>=20
> Kernel is 4.19.45, tools are 4.19.1
>=20
> File system is a 3-disk RAID10 with WD3003FZEX (WD Black 3TB)
>=20
> Output from attempting to mount:
>=20
> # mount -o ro,usebackuproot /dev/sdc1 /mnt
> mount: wrong fs type, bad option, bad superblock on /dev/sdc1,
>        missing codepage or helper program, or other error
>=20
>        In some cases useful info is found in syslog - try
>        dmesg | tail or so.
>=20
> Kernel messages from the mount attempt:
>=20
> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): trying to use back=
up root at mount time
> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): disk space caching=
 is enabled
> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): has skinny extents=

> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid ve=
rify failed on 229846466560 wanted 49749 found 49750
> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid ve=
rify failed on 229846466560 wanted 49749 found 49750
> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): failed to read bl=
ock groups: -5

Extent tree corruption.

So if that's the only corruption, you have a very high chance to recover
most of your data.

Btrfs rescue can work, or you can try the experimental patches which
provides rescue=3Dskip_bg mount option to allow you mount the fs RO and
receive your data (later is way faster than user space rescue)
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D130637

Also, for your dump super output, it doesn't provide too much info.

You would like to use -Ffa option for more info.
Also, you could also try that on all 3 devices, to find out which one
has lower generation.

Also, please provide the history of the corruption.
One generation corruptions is a little rare. Is sudden power loss
involved in this case?

Thanks,
Qu

> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): open_ctree failed=

>=20
> Output from 'btrfs check -p /dev/sdc1':
>=20
> # btrfs check -p /dev/sdc1
> Opening filesystem to check...
> parent transid verify failed on 229846466560 wanted 49749 found 49750
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D229845336064 item=3D0 parent=
 level=3D1 child level=3D2
> ERROR: cannot open file system
>=20
>=20
>=20
> On 08/15/2019 10:35 +0800, Qu Wenruo wrote:
>>> =09
>>> =09
>>> 	On 2019/8/15 ??????2:32, Tim Walberg wrote:
>>> 	> Most of the recommendations I've found online deal with when "want=
ed" is
>>> 	> greater than "found", which, if I understand correctly means that =
one or
>>> 	> more transactions were interrupted/lost before fully committed.
>>> =09
>>> 	No matter what the case is, a proper transaction shouldn't have any =
tree
>>> 	block overwritten.
>>> =09
>>> 	That means, either the FLUSH/FUA of the hardware/lower block layer i=
s
>>> 	screwed up, or the COW of tree block is already screwed up.
>>> =09
>>> 	>=20
>>> 	> Are the recommendations for recovery the same if the system is rep=
orting a
>>> 	> "wanted" that is less than "found"?
>>> 	>=20
>>> 	The salvage is no difference than any transid mismatch, no matter if=

>>> 	it's larger or smaller.
>>> =09
>>> 	It depends on the tree block.
>>> =09
>>> 	Please provide full dmesg output and btrfs check for further advice.=

>>> =09
>>> 	Thanks,
>>> 	Qu
>>> =09
>=20
>=20
>=20
>=20


--hcN47UO100L6NiRS0h5lIisv5cgE06V7W--

--7I4halIGC4K6OeJmh2NkokF4zgdgaYLwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1VZzEACgkQwj2R86El
/qgNcQf/QmDLPKAPzBzCcIHgaqd3xJ2NeNpLotxl7g8h1J0xkoUC71Dg0PNDzPoo
VDvNrPf89woCr9OitxlkAJ/bKfYH2+GGCOkabwDOvl67FVI93TvPBReKMhOOgNw8
6ehRTdrKCmT5RifpEp7njdY3V7+PyC0/JCSaW0L+aMk2GONv0iCJDOpMn86aXJxg
LTasFuMlbICb/+oY17Smg+UFQnhQDjAOM1RpdJKsMe43qMPMa5SKU2wqmiy60JMe
3MRbGibLJYf29A1M1rI8K58pz9GPK95lAcXpaSDB8KDhBe8iSb64jHflTcZ2znD2
IlaS8Sm0cM4ouSyI+PfB5LWCkU6Mbg==
=+oTs
-----END PGP SIGNATURE-----

--7I4halIGC4K6OeJmh2NkokF4zgdgaYLwW--
