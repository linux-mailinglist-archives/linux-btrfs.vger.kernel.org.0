Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8EE595D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF1IPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 04:15:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:40617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfF1IPT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 04:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561709716;
        bh=/tTUxMVT5DMpRhicWZRWejYds0ogDxyAVac553FfyoA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GO7Z1sLc4taUSq3+v3eWkNIqQebr4A1x74JqIYS0aRVAIYiedrd07qoV+9pXEVkPI
         /PX07rOe82AmfDCqZtsXspJViar2tZDGDXKvkbLaqOz6EBaoOcwTnrPiG7kcX4RdPi
         oeMloxaJFST0Ud9TSPfmynw6H7kmDRCx+IDbCkd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LjIBr-1iHCO41I5P-00daWw; Fri, 28
 Jun 2019 10:15:16 +0200
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
 <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
 <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
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
Message-ID: <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
Date:   Fri, 28 Jun 2019 16:15:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qWj3QhjVOnQPv89LqbBpZdum4bWdXsHcB"
X-Provags-ID: V03:K1:EIoJw3HJTU/yl86rEuw9Pe7VVnqQlZKkXZCuCeZxT1eDbfzTNTw
 NQ3AvWZnPgrBWR4+7s6rw/0Mhx0CxxoMDm/nUu3HHt4a+bL8t/0gHnv24hpiSrLP+0fKXCI
 eB6ZU6VV6DzyzNg/y8SXhFHgdYlS6ld5VOnRlY10SwnsFeJTm8qVSxmcHnX8dMBFel8u2HM
 B9yk/AI5X2OZM6suV3vuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zWRsbZTKOrA=:OUcQ2n4iJk9VkMMVz7T+AM
 SywgwjihiozaUSseVER20HnXc8k/1rIGvbStfLVdRAZDcbUef+fs1DCTeHxGvodvf7/HwiDof
 o2Owmc2OatC1LbzyPgTKWub6DyRKACYPV3oRE0VxKWLYBGpZl7S9r7zHYFbEWeEgh02SYNpFI
 spWaf1HzsWlUa9U2rlMfGeVV23Q3bZAGO+/hHwejIUqW2Skqa/alvqQrEai9mThbydG7C4CDp
 61XOezT+RtSCMihN3PH9heQrjCEvbzxJEpW9XxL4E1BAH+OPt8X8wBWXkBUZHjdb9Ry+kxJ2F
 ul8fHcYfWZwFQJXaq2nZMIIJBSpJdSAUYl5NU28COE9oPNslK4wPHkeKqTFhjbU8XlxR7ZVDZ
 kv0tC7au9zmeVnhxRcrv5L28pc5KPQ/cnUd28/JevNMoFPlPK0TMwGYQRA6Sg2G9wLd3/RjXh
 dgj2YYhOK2apU8OWx10TacOzj8cRJcgzuMin6I8YE2YBaKaqes7PWiQcTyaYSKwKWtqRKdTKi
 TKddDe1UVGlOLOvvE4HvnCWFNGySjTYfjigdYmCQQX+Oq71xx/oYxyZWG5v+8yajPA4RdGeZn
 1xTPYHHY+Y9gyOTkZaoxZ3CFP2jzTfQHraG7kvS1IRvN7hZhMMBQkMIkfUgBdumOYNX2DFELi
 3a4W4QL3/6yD3C44utfwnwrH472KQ8Lk+HJz5WUU3pKSra+AQkdSAV8CPtPgTWO07vp351/7E
 MJfWUs/2TQO/Pz7iu/mV1tU2hYDDDvUQhyaNnqZojdaExzn7atg2r5ZMmxzz/+nOHZqu7U1YE
 +6HhKRNMKlCmcCGV5vKh1Eq9mJT6qhq7HJ3PA0SNpweKgmbs+FF/7lxDrAb4RJth1+aSdCzZh
 U/SQKQUzQ4dqr27/U8OaJjpITyymLF/D55SizOtry94hXhYg5Sqwkdq4vWQwkIoriasvsHa0N
 DIJ1wYBelNYA2+T0zlwT8h1qFgb/fTuP2Hutyy6lJWrxmQUQK1XakChCo+TPmN4Jmmbk18BWe
 P1FQNCrufZqn9krKf30uAET5F64G/jGKSFGHOHakFTuGEpycqktLBJhu6giJij98TqWGidjrq
 jYRapRf6kKszgY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qWj3QhjVOnQPv89LqbBpZdum4bWdXsHcB
Content-Type: multipart/mixed; boundary="x3UZx2WDT3oql5dFaFHbm0t28C2mLRf33";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Erik Jensen <erikjensen@rkjnsn.net>
Cc: Hugo Mills <hugo@carfax.org.uk>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
 <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
 <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
In-Reply-To: <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>

--x3UZx2WDT3oql5dFaFHbm0t28C2mLRf33
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/28 =E4=B8=8B=E5=8D=884:00, Erik Jensen wrote:
>> So it's either the block layer reading some wrong from the disk or btr=
fs
>> layer doesn't do correct endian convert.
>=20
> My ARM board is running in little endian mode, so it doesn't seem like
> endianness should be an issue. (It is 32-bits versus my desktop's 64,
> though.) I've also tried exporting the drives via NBD to my x86_64
> system, and that worked fine, so if the problem is under btrfs, it
> would have to be in the encryption layer, but fsck succeeding on the
> ARM board would seem to rule that out, as well.
>=20
>> Would you dump the following data (X86 and ARM should output the same
>> content, thus one output is enough).
>> # btrfs ins dump-tree -b 17628726968320 /dev/dm-3
>> # btrfs ins dump-tree -b 17628727001088 /dev/dm-3
>=20
> Attached, and also 17628705964032, since that's the block mentioned in
> my most recent mount attempt (see below).

The trees are completely fine.

So it should be something else causing the problem.

>=20
>> And then, for the ARM system, please apply the following diff, and try=

>> mount again.
>> The diff adds extra debug info, to exam the vital members of a tree bl=
ock.
>>
>> Correct fs should output something like:
>>   BTRFS error (device dm-4): bad tree block start, want 30408704 have =
0
>>   tree block gen=3D4 owner=3D5 nritems=3D2 level=3D0
>>   csum:
>> a304e483-0000-0000-0000-00000000000000000000-0000-0000-0000-0000000000=
00
>>
>> The csum one is the most important one, if there aren't so many zeros,=

>> it means at that timing, btrfs just got a bunch of garbage, thus we
>> could do further debug.
>=20
> [  131.725573] BTRFS info (device dm-1): disk space caching is enabled
> [  131.731884] BTRFS info (device dm-1): has skinny extents
> [  133.046145] BTRFS error (device dm-1): bad tree block start, want
> 17628705964032 have 2807793151171243621
> [  133.055775] tree block gen=3D7888986126946982446
> owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> [  133.065661] csum:
> 416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba9656f=
c

Completely garbage here, so I'd say the data we got isn't what we want.

> [  133.108383] BTRFS error (device dm-1): bad tree block start, want
> 17628705964032 have 2807793151171243621
> [  133.117999] tree block gen=3D7888986126946982446
> owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> [  133.127756] csum:
> 416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba9656f=
c

But strangely, the 2nd try still gives us the same result, if it's
really some garbage, we should get some different result.

> [  133.136241] BTRFS error (device dm-1): failed to verify dev extents
> against chunks: -5

You can try to skip the dev extents verification by commenting out the
btrfs_verify_dev_extents() call in disk-io.c::open_ctree().

It may fail at another location though.

The more strange part is, we have the device tree root node read out
without problem.

Thanks,
Qu

> [  133.166165] BTRFS error (device dm-1): open_ctree failed
>=20
> I copied some files over last time I had it mounted on my desktop,
> which may be why it's now failing at a different block.
>=20
> Thanks!
>=20


--x3UZx2WDT3oql5dFaFHbm0t28C2mLRf33--

--qWj3QhjVOnQPv89LqbBpZdum4bWdXsHcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0VzIsACgkQwj2R86El
/qiTDwgAj0iXKz2+ljKeHWs4e6io3mHdEDREz7+isUkCSygvFU7SwEXcA9zYwuIx
yhjwppcJnag8ooL4tQ2KPuifmhEhElr9396yiKC4VEiYxlzP1M4MTWiLb9q+XbZW
DaqUrUCBCqbhONErLOj7z1hcX9bNBGa6sY6ZHoDC43OlQrRLmcj1tOtXH7rW9ilO
v4C0BjmDnoazCGZoGjtus8EuI+Ie+PJAOUD/j6qa+Zk9lE4dD6cP+UxMG6SIGO/k
8YTrAQQTTs+r3sJc115PkCRg3UTEDFyPx59+gOcL20zQmbDKdBikiYAPjoGBw4ef
RLKKowFB6phIUK25UDmNMsoSGFmxtg==
=Zu+r
-----END PGP SIGNATURE-----

--qWj3QhjVOnQPv89LqbBpZdum4bWdXsHcB--
