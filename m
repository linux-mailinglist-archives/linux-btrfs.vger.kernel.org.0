Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B583128EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfECHej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 03:34:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:43377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfECHei (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 03:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556868875;
        bh=FPWo36wnAReSjtFeDnI5+59gVmL0uEVYOC+hVyn4Jbs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=E3aK80jsmfCNHGDoXhwidlrg8Tcg0Ij7ZVem3rVM5PwoQeZYMvlbGHppWS/tRHWH+
         /6/pLKbRxxL50M8Yp9gFGhBbzhQLJS6OsQEOod9HVYkJXz1xvzseY+LJzHfDdeaCH1
         jmjc1r/Kr5M05sk/66mWwklPRf4ECdgeQL7HU3NE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvcA-1hHydG1X84-00UqkM; Fri, 03
 May 2019 09:34:35 +0200
Subject: Re: Rough (re)start with btrfs
To:     Hendrik Friedel <hendrik@friedels.name>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
 <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
 <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
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
Message-ID: <655d52b8-596a-2142-9470-8e45d5a0cc8e@gmx.com>
Date:   Fri, 3 May 2019 15:34:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gUYdZIIm3oEGfEKqq2UiMoEsOZZVtdKxx"
X-Provags-ID: V03:K1:wQu2+9TuwbxNKypRqDrhZZLibSPOANkV02yIyxL5ZmLTheSoxcA
 ZJn7okXGMQOvtafgUQ4BEMtRaFn3vqs2HAdlMIMXmKStTR2MXF1RjO/qei8XcCYZYG+51gD
 CtbgPEfU21cEGvYkV0jnN49s+1e/rBj0EJ2siSPui3WAfEaXDVxeup/VSwPnITqBKEUq7tm
 6l4sX7xxNJDFP1stkAKDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dLLv1P58pW8=:gQM8nd6NG/zp491LkDjJXL
 3lELE3VCYLPTxiWkeRR70wuB9OsUdlWbzdCEl89nNHaiWQzMbJNlQYkLBFgcFY3CxmkSIAwmC
 Qlz0JVjT1xz0coTWqu7LMLVJJQgIPuQVhZWIVUoT0LJzlrcpHWfIOule19YuQAUqLmU9FbYI4
 qqRSrSHhToHDhidZ9TXOcRIUs2zcRo5yRf3/A8+dBvTF1wNnY3BsfToGBiQrCtn9wIR8TMZhn
 ZfXp6Da9LZxCJtWcD8iDLdqrNwA7hb8fz+s3+urrDTJ9Rk8F2eW86c4/g3lhsUj87uke7Z8gX
 htGoFYkMDBLXiR5q9sYFbXY3hmHnJYrJJ8+OeAm8EYiy+1I1JoUVERQeEojzFB7YjrLciXxAW
 n0hqvj//kWCay/KwBIIZCnw0B18hq68h/pdoAOIYnbkUN+mcbzaptk7nSet9gQivsjgsIdKCu
 rb3SmKW+qmr3BFyVLJCfo2q4AFo7JnW1tGeyc5I63jixcEEPWUktiH7oOQZ9f+svOVIo3cFNa
 uukTCOVoFclfpTDezzbwNrqJ1yRJfCzO7amz5ImAlQhzF9CbF11on+pt4PKpZYYh/9V+mbK2G
 ti++9Lv90Sj4oZWPeUgWvmQS6qQJgDcn46tYhV7eHITCbGPE0h1+APJEsGPBBhcic6mENp3HC
 NDe6I34oyIpY/0WokqUbA5RW6ri+GN9nuDF8Ksyb4lvM6uNAwn5EEk1pQZrN+TfHiw0DFQgdg
 42hMkO5oa3PqWYAs0hhQrvZafix/AvKqaKKwyHVvdz/PnSnK9ro8Gm5AnUPBAqbae2kpLjL19
 zvNLiU4prSdjqHvcyH3j2zFeg5hSNEkd+N1IPW4MvQm7qqwjnR7PrdhF0Tpcyc0nsL6JXnuJs
 9DqIiy2ALOCLYxvyt1Tr9+vbPtBfUCGhd0EHfNXhdbTDg8yb7j0e0gJoubvq4z
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gUYdZIIm3oEGfEKqq2UiMoEsOZZVtdKxx
Content-Type: multipart/mixed; boundary="NLBI0fHxupG2Fj0oU6m2FpFKsfJUY1wPN";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Hendrik Friedel <hendrik@friedels.name>,
 Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <655d52b8-596a-2142-9470-8e45d5a0cc8e@gmx.com>
Subject: Re: Rough (re)start with btrfs
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
 <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
 <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
In-Reply-To: <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>

--NLBI0fHxupG2Fj0oU6m2FpFKsfJUY1wPN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/3 =E4=B8=8B=E5=8D=881:41, Hendrik Friedel wrote:
> Hello,
>=20
> -by the way: I think my mail did not appear in the list, but only
> reached Chris and Qu directly. I just tried to re-send it. Could this b=
e
> caused by
> 1) me not a subscriber of the list
> 2) combined with me sending attachments
> I did *not* get any error message by the server.
>=20
>>> =C2=A0I was tempted to ask, whether this should be fixed. On the othe=
r
>>> hand, I
>>> =C2=A0am not even sure anything bad happened (except, well, the syste=
m -at
>>> =C2=A0least the copy- seemed to hang).
>>
>> Definitely needs to be fixed.
>>
>> With full dmesg, it's now clear that is a real dead lock.
>> Something wrong with the free space cache, blocking the whole fs to be=

>> committed.
>>
> So, what's the next step? Shall I open a bug report somewhere, or is it=

> already on some list?

Not sure if other is looking into this.

Btrfs bug tracking is somewhat tricky.
Some prefer bug report in mail list directly like me, some prefer kernel
bugzilla.

>=20
>> If you still want to try btrfs, you could try "nosapce_cache" mount
>> option.
>> Free space cache of btrfs is just an optimization, you can completely
>> ignore that with minor performance drop.
>>
> I will try that, yes.
> Can you confirm, that it is unlikely, that I lost any data / damaged th=
e
> Filesystem?

You lost nothing except the new data which is going be committed in the
blocked transaction.

Thanks,
Qu

>=20
> Regards,
> Hendrik
>=20


--NLBI0fHxupG2Fj0oU6m2FpFKsfJUY1wPN--

--gUYdZIIm3oEGfEKqq2UiMoEsOZZVtdKxx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzL7v0ACgkQwj2R86El
/qhypQgAkogbQv7Hfz1p6L7pKZQEHObIrXBfu0oqr4Rbw+VKDjaJ4jYXK1AQxgHF
J7v41Wyet+F8Q/t4Hhaquf4lRCB31dHO0dg6OVOxqAbdV7D8PWr2yQwbnOKlF5sO
8KLDRiRDN/jZa4btoOut6FSdS+A+68AhMqTrW2JGxzLEgClMt0bWjKOWyui6lv5H
PMIco4gsA2QR+Ug7YRoQpOwFdWh+8zuw22IKLT6NsefirwgibnzuOb6v4JJDzRiK
YNJjCJxmaB36+jeoQjYPShYiKi72Y4QuFvp/VlNNPT2c/3p6GxyvP2knhv94TRMd
T9MoQHROVwuOCAr67bruiojlxcKmfg==
=AUpJ
-----END PGP SIGNATURE-----

--gUYdZIIm3oEGfEKqq2UiMoEsOZZVtdKxx--
