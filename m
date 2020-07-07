Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A87217BD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 01:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgGGXnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 19:43:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:33783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgGGXnP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 19:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594165390;
        bh=cLWvm8zsc2Vwl3V/pNJSCVFLgQIk2Sp251Zskb3qzbo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aMdaKUxpCbkIqWesPCLHKX8JDiEZF5JGE+35B+BSs5sHZoinzgfKlDZuyfYuBN5gY
         ZwoOe8ohW+BS0GONGl7BQ6eWssRrzbL7biQ5TuSkoRHu9RBPClcF1Pa0lISzEyFNG5
         dFr3sCIs70dVekbCnCqyUlwLqlbjm1vMocLZ919Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2O1-1kWQrU1puz-00e15w; Wed, 08
 Jul 2020 01:43:10 +0200
Subject: Re: BTRFS-errors on a 20TB filesystem
To:     =?UTF-8?Q?Paul-Erik_T=c3=b6rr=c3=b6nen?= <poltsi@poltsi.fi>,
        linux-btrfs@vger.kernel.org
References: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
 <f2d396d4-8625-1913-9b1c-2fec1452defa@gmx.com>
 <9a804cbb7406be31f55c68d592fd0bd6@poltsi.fi>
 <960db29cd8aa77fd5b8da998b8f1215b@poltsi.fi>
 <e1beb547-3989-0fdd-b2e4-5491728f7dec@gmx.com>
 <7bfbcd06-f4f8-5946-c5e4-d7c7879cf122@poltsi.fi>
 <446cbb5e-bb18-bb93-ee98-d480730e4508@gmx.com>
 <974197e0-0dc3-e0c4-6c44-b5fe8b6c6f6d@poltsi.fi>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <5ab5584d-abc9-2137-a8ec-1429dbe3b075@gmx.com>
Date:   Wed, 8 Jul 2020 07:43:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <974197e0-0dc3-e0c4-6c44-b5fe8b6c6f6d@poltsi.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V7bvJzyZARqfKdr0vr85dcuFaaIlEgT6K"
X-Provags-ID: V03:K1:L531buxAV8Cj8AREvQfAv61dm8iIfYHKuqcTuS4pm82kNnR4+UW
 9Zi6POtlGJFviTKyzrFbnirplFPOXDE916Otk4n78m0VCSQnp2Q2yotGNe/JxusQk+f9Dyp
 2TwPKRo+X50DQS/00gL5i/NIDBVXif8/Se+EPCJt8m2tGmuiEKLSiLju9/RW9yk0W2RDt/w
 NCe00cTw/e08e66yJAZ/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XHcPzfoNVX4=:6A6X21y3HWPW47y/JURxLs
 DeG0+oHUOUjJgSjmCEoYGA2046b9uTnOsSwCPseVnbiy8xG2r749zCocTGG+vGTZxskpubX2W
 MnpqXKL7d7F8d86kyt9IqpNtOBCV96hR35kRmsuPS4vOaBk+fihcVYGHlN4jZTRw9xJjJ7vUE
 BOa20fe49NfZXz/oRjuZoXs3lILjuPSHWEjTwMmisUmrR8okSFhqk/eE3+ldRSiqynnhPdxJ+
 ptp7m8L5VPu31wPmQEmK2O0hzTL7401uuMYPYwr9eSybDXbCJDhZFx2UKHN29emW9ExjHK4Du
 r6/mhuV6BhpdM1MBCC7xjj1DlOFS8fZ1MO9BYvfTt/hntxKWV8qk1lGLfCT9RwAo2Flxd86on
 7O3NkuL52NwOI44E3NcPnyQ5erXusxJXbUusc9Mnj9ug8qkf9nXufVyUA7PQnlr/yY7dd9rve
 2wiYrq0eJjhwvByKFcmr/u03qqTov6XBOssU/p4DAp9vftLkfrBq5r7IrvFVtZM4+P38HBJgm
 +SmYUePqLOCNrjWytaHl1gb78qjsoNEpjUUdkOyjnCQbYJxnsja1ow1LLPzZUv9QYr5188ZSF
 S+TNZHtV4hMrbSFyIK/R4XqS5zZ7T0pnlMw2gCzr8L6DIphfxtMJUJGjYL2VKWbEcMqjnw7BM
 wYfoWZkoch/oFvLnxb4kg8c6OGv5g7SZQNTjQmu0euYBEreuk0gn27ny/Pu0cswCVjCTqUyBO
 LzvBCk2Jbqv8s/vSDCaWGixjEQLc7XISXHAxDkmYke9OI3fdLUmnfXSoHnpP8mMdY6k43o/Kx
 Q3+8EXeynBAB3ZZc9/iOUUOd2P9sjzxlR7SuYMG2pIVdPypldNdfFa+KXmzPPQgcC4ZRL4BZ4
 7mIEDcRk9QQmWLNmQL8+3CnYHAKrEkweqDtzbhlzbiL24/Jg+KsAZV26rERM/0cDA0omYjg+X
 MtH+x98UYt2hLxeHYwgWL+niehS0xU++YZzII77NcyzEXAUK6UKI9KEtTg89shvpKZ3CHiiQw
 F5isBph0ZoXtCOlXOzaTt2RH3ELLoMc8PEnIkk1EoN7y5iF2FB7BFf5MiJ7oj7TyKmph6ubmU
 mOGikvmcXCqpRjaqaN4s3uNRSn2A/IP9K5hKaDtPgNtE53+3NZ6uH431VrR+Ya22yDf3fSEUr
 EXXqd4aFpZHAhsrx7ASFji9l9dTVz4wXMiIr+2qTtUQMosO8dMhXmrv0kBmWSkl745XhtFm1L
 j/Qlh8bicQOob6SbzzfjxOPCNjvoKBnKO9ZUGtg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V7bvJzyZARqfKdr0vr85dcuFaaIlEgT6K
Content-Type: multipart/mixed; boundary="BGIR2n7DcIwWhbmxJNpUvqj1P7c4KZJna"

--BGIR2n7DcIwWhbmxJNpUvqj1P7c4KZJna
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/8 =E4=B8=8A=E5=8D=882:43, Paul-Erik T=C3=B6rr=C3=B6nen wrote:
> Sorry for the delay :-/
>=20
> On 7/7/20 1:58 AM, Qu Wenruo wrote:
>> Although still needs some extra dmesg context for the following bytenr=
:
>> - 2627928588288
>> =C2=A0=C2=A0 I see no obvious problem around slot 10
>=20
> $ dmesg | grep 2627928588288
> [=C2=A0 595.081488] BTRFS critical (device sdc1): corrupt leaf: root=3D=
5
> block=3D2627928588288 slot=3D10 ino=3D11274213 file_offset=3D454656, ex=
tent end
> overflow, have file offset 454656 extent num bytes 18446744073709457408=

> [=C2=A0 595.081589] BTRFS error (device sdc1): block=3D2627928588288 re=
ad time
> tree block corruption detected
>=20
> This is repeated several times later on. The only thing preceeding this=
 is:
>=20
> [=C2=A0 243.295071] BTRFS info (device sdc1): disk space caching is ena=
bled
> [=C2=A0 243.295075] BTRFS info (device sdc1): has skinny extents
>=20
>> - 3154217795584
>=20
> [=C2=A0 602.597770] BTRFS critical (device sdc1): corrupt leaf: root=3D=
5
> block=3D3154217795584 slot=3D102 ino=3D12990328 file_offset=3D184320, e=
xtent end
> overflow, have file offset 184320 extent num bytes 18446744073709395968=

> [=C2=A0 602.597869] BTRFS error (device sdc1): block=3D3154217795584 re=
ad time
> tree block corruption detected
>=20
>> - 3154257952768
>> =C2=A0=C2=A0 Mentioned slot doesn't exist at all, not sure what happen=
ed there
>=20
> [=C2=A0 603.161394] BTRFS critical (device sdc1): corrupt leaf: root=3D=
5
> block=3D3154257952768 slot=3D59 ino=3D13467676 file_offset=3D262144, ex=
tent end
> overflow, have file offset 262144 extent num bytes 18446744073709527040=

> [=C2=A0 603.168062] BTRFS error (device sdc1): block=3D3154257952768 re=
ad time
> tree block corruption detected
>=20
>> - 3154259034112
>> =C2=A0=C2=A0 The offending slot seems fine
>=20
> [=C2=A0 603.316595] BTRFS critical (device sdc1): corrupt leaf: root=3D=
5
> block=3D3154259034112 slot=3D27 ino=3D14013491 file_offset=3D102400, ex=
tent end
> overflow, have file offset 102400 extent num bytes 18446744073709514752=

> [=C2=A0 603.323174] BTRFS error (device sdc1): block=3D3154259034112 re=
ad time
> tree block corruption detected
>=20
>> - 3154291228672
>> =C2=A0=C2=A0 I guess the problem is hash mismatch, but can't confirm.
>=20
> [=C2=A0 602.779540] BTRFS critical (device sdc1): corrupt leaf: root=3D=
5
> block=3D3154291228672 slot=3D9 ino=3D13286681 file_offset=3D204800, ext=
ent end
> overflow, have file offset 204800 extent num bytes 18446744073709481984=

> [=C2=A0 602.786103] BTRFS error (device sdc1): block=3D3154291228672 re=
ad time
> tree block corruption detected
>=20
> Does this help any?

OK, then all the same problem.

Thank you very much for all these detailed info!
Qu

>=20
> Poltsi


--BGIR2n7DcIwWhbmxJNpUvqj1P7c4KZJna--

--V7bvJzyZARqfKdr0vr85dcuFaaIlEgT6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8FCIoACgkQwj2R86El
/qh1twf/VO2fuyHumSPyAXXGrxyj63gNb9oed4BxXE62EVsH1w77dLlXvWOFByO/
hbhDA+cbIlmqWMyHK9TUkS3H2F27ICa326c+2JsqAl3KQAZ55W8eBJpHjo/guA3B
OYjGiVYUZeD7kgB0SaFm23uQXfAufpUHcGUlE9nU76MEXgW5oYZpSPlrz3jffuUM
bo6xDG8tEpxMIgRFxmQcuk4OFuYBr77/wuHmAEKoj2bucReY8bDfQSXI18C3QAQ0
Tlvd2RX10hQ/gmfqQicpXjz8FxIJS3FKO4LF9entzQ9Zmq+0GWtWdNla3iO3MXeY
5u5XwGdA++Krp5AGQBuOzwOReMs9HA==
=Eug+
-----END PGP SIGNATURE-----

--V7bvJzyZARqfKdr0vr85dcuFaaIlEgT6K--
