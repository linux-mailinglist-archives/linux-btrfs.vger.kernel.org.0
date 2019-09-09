Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9854AE178
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 01:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbfIIXZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 19:25:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:39921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbfIIXZm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 19:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568071492;
        bh=WYhRzM3pwcKAg3U0xfyEybh6EsjrqJIskyjmtl9pUSc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Th6alO4c2yM4NoPqBj4pl4z3DThzR5bTeRV6oRVqP7hfWIBN1HOHdSHu84aW2ALTM
         2caU8Y9iR8XkqdTESj5jS+uSUZDAmEeID7Ypb9IDG4Puq+mHXFufBBY2GOTDbvdbdj
         VnQEcaSi7io4z/fQbx5h366c5WdZX0dHbgu+FXEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDysm-1hxb8a060C-009v1I; Tue, 10
 Sep 2019 01:24:52 +0200
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        zedlryqc@server53.web-hosting.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <e6712117-f002-b7d8-6a5e-9e5735f04090@gmx.com>
Date:   Tue, 10 Sep 2019 07:24:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bOIiqhmpfGARxY7ZDwEKQlojWKGotdSn3"
X-Provags-ID: V03:K1:JCi3BxJHgWV4DJSxiKrObjw37+XGILGVBDvH0RnfuxYlWvOro7t
 YJgIdwekV/LNQKrspvDplO1WInwwuGe9vLN3UhygG4Rqsi335Dpmbh2eDwRDy9MDjlhy6aL
 h3qk+UEKREX6lnrV9P3aUEUpev1ZoUxwmuquVsvEITypkR/RWz6YAZl/GC5VyHCSY+Q0Rdy
 Wdobs5hO+4ptGT9A8mXLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2rmpxZu2MYw=:Rg4poXfqBP2+OPIYsq6o5m
 zQW9X//SRh42/LqVAVHCEKXczDQB0S7c7bLeqBcNVbSs/FBM1IvANxQA7gb8m/NM7hQIik2pa
 240T118RiI5vJrIceEgtSq5s6er9+OyWGt5jM79uLREJiewxlMCTyZH02j/6VTHlWjiggYc1p
 1DVVKbgJEXzAgfdS0aYoi6IMUGb1lu8MmNpBVIcP74j1fh0vjlzoC2X/dHN1Q8z/8CDzO4b3r
 4Fuvn5rJU4o/ietV48SOda0+/PQrbkf5P3Ty8bd1XHdLl5MltUmfXdgM5Pw1yEOZmSqeufSlo
 oRbiTEsKZSwqKhIz6cSLdZqzdkhRezgVJxsGCGC2OLm0332NuSK0XpgV6jkhcFmXOmFXsHQwv
 moZ+8pI8nzmuh0L6m2cb+0eRP+12dcRcGUjJCGY0MUll0f5Nu8uVtzeub5voMz6fFtb6U7SqN
 j9b9j6hN0SVARgEirzRlUvndcOBVPUnHX7wpulZ/awqXQw5uOs2F5eoR+zxHT0EePC6m+GIJ3
 osRgugD1PcOCHNvFJOQduK0LrZQxkT22pKdYbZqAE0wFA6Ft1PNFLN82OHYrnwIJvlClTzbSa
 U5smU4FA++dnRW/DNBtGAUatnq07WiBcR/v7YPYnEFv22L3Ft9roUKwB5TM3pFKixXZoIxRha
 LJIEEGCmcWRNNSjiTfrsJhSybTkkRDU+X7ksj/c93tX/VS5RO5x8hwn9hijAIzKBoKyXH2gKR
 1Iax614TBEvtWnpcptmORiJgoyCfP1gdjauW9KTBlB0pwLB6GblbKHSadBFxnrkf8GZy5EO8W
 H7a7Q1LGLqTSGKqa25ZDJRT8eyKDHUgXvTfTa/UtXGEwzxpQL652v8ya0n7aA7UCS6TP0OeWQ
 GrqY+9LXGOA1IeX1DxTeVJwZeBJS2HCnBFycVaCBJ+S/WVW3PdMOwfnNqT2S0EQaszThOsxIZ
 nTYmBVvG1LKOiKc5bCgtt9lLy4Ub6EjfNO37CK7qM1EZDGdLj3ODiGwWpp9YxAV/A5L3dLYzo
 8v0qCj4Vk0brB91oJoykXrj0uLDjigKZV7ecilCveqfQCSyvtlO0AszpmUST2qWljZroB+/U5
 RsjJo7+MC7MCyb6rm9bkUFjplAqJqoV2FYX9yTWlKO7c9jd84peEaDQqJtYYT9oFq4rJJlUuO
 joO+gLHKOuCN6tcF1DjYffGNtZ/dP+vXa78EwA38XdHffiNhGF+fCfb793MbOZegmT4OnfIbR
 AjOD/YYN09MFnEKaI
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bOIiqhmpfGARxY7ZDwEKQlojWKGotdSn3
Content-Type: multipart/mixed; boundary="B2m9z4sjgsloo25tJJcPkZ8dgd3oRtcv6"

--B2m9z4sjgsloo25tJJcPkZ8dgd3oRtcv6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/9 =E4=B8=8B=E5=8D=8811:29, Graham Cobb wrote:
> On 09/09/2019 13:18, Qu Wenruo wrote:
>>
>>
>> On 2019/9/9 =E4=B8=8B=E5=8D=887:25, zedlryqc@server53.web-hosting.com =
wrote:
>>> What I am complaining about is that at one point in time, after issui=
ng
>>> the command:
>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfs balance start -dconvert=3Dsingle -mconv=
ert=3Dsingle
>>> and before issuing the 'btrfs delete', the system could be in a too
>>> fragile state, with extents unnecesarily spread out over two drives,
>>> which is both a completely unnecessary operation, and it also seems t=
o
>>> me that it could be dangerous in some situations involving potentiall=
y
>>> malfunctioning drives.
>>
>> In that case, you just need to replace that malfunctioning device othe=
r
>> than fall back to SINGLE.
>=20
> Actually, this case is the (only) one of the three that I think would b=
e
> very useful (backup is better handled by having a choice of userspace
> tools to choose from - I use btrbk - and does anyone really care about
> defrag any more?).
>=20
> I did, recently, have a case where I had started to move my main data
> disk to a raid1 setup but my new disk started reporting errors. I didn'=
t
> have a spare disk (and didn't have a spare SCSI slot for another disk
> anyway). So, I wanted to stop using the new disk and revert to my forme=
r
> (m=3Ddup, d=3Dsingle) setup as quickly as possible.
>=20
> I spent time trying to find a way to do that balance without risking th=
e
> single copy of some of the data being stored on the failing disk betwee=
n
> starting the balance and completing the remove. That has two problems:
> obviously having the single copy on the failing disk is bad news but,
> also, it increases the time taken for the subsequent remove which has t=
o
> copy that data back to the remaining disk (where there used to be a
> perfectly good copy which was subsequently thrown away during the balan=
ce).
>=20
> In the end, I took the risk and the time of the two steps. In my case, =
I
> had good backups, and actually most of my data was still in a single
> profile on the old disk (because the errors starting happening before I=

> had done the balance to change the profile of all the old data from
> single to raid1).
>=20
> But a balance -dconvert=3Dsingle-but-force-it-to-go-on-disk-1 would hav=
e
> been useful. (Actually a "btrfs device mark-for-removal" command would
> be better - allow a failing device to be retained for a while, and used=

> to provide data, but ignore it when looking to store data).

Indeed, it makes sense.

It would be some user-defined chunk allocation behavior, in that case,
we need to double think about the interface first.

BTW, have you tried to mark the malfunctioning disk RO and mount it?

Thanks,
Qu
>=20
> Graham
>=20


--B2m9z4sjgsloo25tJJcPkZ8dgd3oRtcv6--

--bOIiqhmpfGARxY7ZDwEKQlojWKGotdSn3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl123z8ACgkQwj2R86El
/qhG3wf/ZxAj7wS0GeOHBdXeLUTdmwyyVHY1zr9dDiB7epylNU5TiElN5RTLH7dJ
J4rlYUvj1aFwIFYQ63a7MfB7mFBmpSS8h+MhcRgf8MmyDr7g2fDFBLDeD1bRA3vV
oW+3wTEY7HfA6MGS1DTprbFYVYS8Oga95ZxRecvUGHSgO9wPV6TqDraowuNpr3kY
stbIn8ALnozfVFiye9Lm5S3TvGyjtYQ4rnR9NA6iWmyVjzbaGRgmbsIwngBH5Nz/
4usaIw+TEaaAkcgX6ZeI7jvXgibo08jn0beLxTeEIgwO2BHjPWeHPpU5J7RRuL4A
lVB20LFl+72mzFqDGNsP5tZnN+HVOw==
=9lqT
-----END PGP SIGNATURE-----

--bOIiqhmpfGARxY7ZDwEKQlojWKGotdSn3--
