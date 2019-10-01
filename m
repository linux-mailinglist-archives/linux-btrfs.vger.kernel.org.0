Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C36C2BBD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 03:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfJAByE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 21:54:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:45151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfJAByE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 21:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569894837;
        bh=RSfCwL0WdX+4m0w73uqC5eg773CEj5eCzvl5InDLoBk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gJouaG69PUPD/XVLkQJMDSj4w/48zaS8Cf1Hbtoe0a6vzc6p9UXfCu4yTzYNkylYQ
         ZuWt6Hvx4zQlCbHnqPdDtx0NhuB1i2BtdOjV80NEppdGV0XSeeVGIFUPPNDeTNdoy4
         E2pK2ISIQ0yBLp5+KVqGXJW6TirGhsgBHkPpok6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McYCl-1hjMuf2eKb-00d1m2; Tue, 01
 Oct 2019 03:53:57 +0200
Subject: Re: BTRFS corruption, mounts but comes read-only
To:     Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
 <44df5407-b7c9-bbd1-eae0-d5ebf6ad75d8@georgianit.com>
 <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>
 <fe22fa62-7b13-f417-1af8-3ed12bf082f8@georgianit.com>
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
Message-ID: <8d765abc-b9f6-066f-8327-bcfc9a156177@gmx.com>
Date:   Tue, 1 Oct 2019 09:53:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <fe22fa62-7b13-f417-1af8-3ed12bf082f8@georgianit.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FDWQv2pF6mZVKEZL6jmYC4sCespg6mEZe"
X-Provags-ID: V03:K1:GZg2vXTIkj/OIrla/wElYTDt/7CQzpvZP0UUNaL4I0YGE/8P1kI
 nA4fUUDozMWGwHkxUrJtT4qTy0y8X/IPVG802B7H8XO33GIup6W8gIt9AVpKVxFi52RSjbe
 52gZWzWiFSas2iphWMT0leD1Xb9rhKq6PRDc/1RI533QJ7rsNktdpt3kfpanCy0w1N6ISm4
 ESn3AEHEM9Bz8AwQ+ahrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TWCwsfQ3w/g=:5onBdz26T14WlFldsUYc8V
 DyZai+fSoHDVDg62GrJe6Iv9fB/cxumOvYzR19EAb523QPRGBvpuffeaWa5sxZ+VjNsBLTVi8
 PSJ3IBbJKzN15hpkBP1fZtcwdlxYR0v78cnpy+9IsyXT96Y6pUVQ+j5v37QrB1H9sUa9q8odY
 rl6asCOre6Vbe9zQEvJaalR0J6gLPdFIlKA6+jONBvnFyUvR5lscyNprA4GIOYZ/51nGtNjwX
 fIgWbYFzXSazELokn6DFKXEtO0O9ufYZftYJaZa0dyX0i/rGXMxTL3s7KWS6SkC7NaLVQNKvQ
 zx/q7Rg+uo2cMjGImqkeCtdZCzsbJ5HVmbRzAZ7eMARpv2SlHOGD23SMjOhbujDvazadlKCdZ
 OEDuE2qMOnOo1VwP4OR2eAGTSCnzOrvFbbnLRNRsk8Mn/lf7ph+jR8osstJKk5nhcE8Afp/HR
 03Rs7ZIyd3a/3EaUxJeIsPChBg/QIZkcVNeb+7YpreYJjUTP45cEakRV0IjhhZOihJl/wE7bD
 GKrN2Tyf/oC4sqorjCNKXFO3sKgom7TRZWFqZ/VvUwEiGwrCV/umL+0j2IlP/8XajUU6MoJZb
 t+2GUu0lQLWuUqVVY0HjIwHS7uuQVl7xVzUbPAPdHBaHyq8+de2rILjMUN3qw8Owf3iRCWveq
 9WvusH39QYOCpeXICTbV9fQGVLz+DmnwpJ1ZVmYc72rR/1NwYjq7kyEMcp3spS+NGq0RvpXGt
 9Gm7NCB+1blT9F6yJy4UIdV+9wtZskhtZuJtums+aNmewb3KTkSnSzysJE7iiWu4b4Yl2v6SC
 2kqUNNDbKBYrnwVXzrRy18Ubja+X00hNYrNG5AwKB9RrFFdmKq6H7Q1Eexk4Mwk4txbsNCweH
 LBKXx164tLBmIlyV1YaFXqaKfHJVF1eiEcXGgHJxdgBHWebYaI5yK0omROJeRf9hSGcdcrX2i
 5+Gg6dIIwC9cyT9clA8fAp7K2/szm7k/O0EvKOm3SMqAjjutKyaABvUtDlsP/ZdZu3K+EgbDh
 Z++rknBp8mAHhPi/2DU6R0B1vWCHKfHCkDEBqZ+qmVzFf9PnUgXPM9/eb2/KMTsfdYRtnEeyF
 ft5IgX029DSCZHlU4JKhlq5zNuamcO8cV2ynxQHs3raZ7SndLC57J4oSW8E3xIb6j0UWVkuGq
 9X6vWLlKpyoTVAuQofR267rt914OEFYVjm/AXguCcL6hTG8CS1vUtItI0jBpDyH3cj6OJnh9D
 pB9oQRlYguShH4RnARq/U74aIuyw0eTCCRqSNI2CO4VZvKbVjLCs9g6MEnIo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FDWQv2pF6mZVKEZL6jmYC4sCespg6mEZe
Content-Type: multipart/mixed; boundary="qf0PKutSJXxL6ZRVo0ZVh33mQD3U4KZVD"

--qf0PKutSJXxL6ZRVo0ZVh33mQD3U4KZVD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/1 =E4=B8=8A=E5=8D=889:41, Remi Gauvin wrote:
> On 2019-09-30 9:30 p.m., Qu Wenruo wrote:
>>
>>
>> On 2019/10/1 =E4=B8=8A=E5=8D=885:08, Remi Gauvin wrote:
>>> Mounting the FS after that btrfs check, kernel 5.3.1, here is the dme=
sg log:
>>
>> As that btrfs check shows, your extent tree is corrupted.
>> Quite some backref is lost, thus no wonder some write opeartion would
>> cause problem.
>>
>> In that case, it looks like only extent tree is corrupted, and no
>> transid error.
>>
>> If you have data backed up, you would like to btrfs check --repair to
>> see if it can repair them.
>>
>> Thanks,
>> Qu
>=20
>=20
> This is itself a back-up system, but not wishing to tempt fate, I'm
> going to have to create a working substitute before I do anything risky=

> with it.  It would take me several days and lots of travel to re-aquire=

> them.
>=20
> Any idea what could have happened?

Maybe some existing bugs, since it's an older kernel.

But at least, no tree relationship corruption. So you should be pretty OK=
=2E
You could try btrfs check --init-extent-tree, as I see no error report
from fs tree check.

Since it's extent tree only mismatch, you can in fact mount the fs RO
and grab all data.

>  The data and meta data should be
> raid1, and none of the drives have any io errors of any kinds in their
> SMART log.

It's indeed a symptom of btrfs kernel module bug. But at least looks
repairable.

Thanks,
Qu
>=20
> Thank you for your guidance.
>=20
>=20
>=20
>=20


--qf0PKutSJXxL6ZRVo0ZVh33mQD3U4KZVD--

--FDWQv2pF6mZVKEZL6jmYC4sCespg6mEZe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2Ssa8ACgkQwj2R86El
/qikkQf/Sg61y+8aLCMK9vBzp5vakDm+IsOEL47OGPw1QzJ/u9Ae04+6zgFx0ya9
f0E8LqXihHTQyDPR9EEIyl9bVG6AswQffo7/S0QspHV5IJAjpD3rW3/y4Yiw+K23
PQongbHf12enYttCnzEPbtdhVAC+LnEouKtnOPZ2EZIXeWCLaqWN/jqO9/Nm/79m
Msmg/+OtDBeOg+dekOVW10LmxvW4tZJjN7bLJBQs0z4VJ9545lpHNDKh3hl8D9OI
bmLImTtcFQ6PtfLc5ZT3eAGamWHEVIG/zjgkaKbZ25V2A0YqQfs4eIvqU5/SnclE
o4WG5aKG84rlrTEd+IUYUpNSMLQjCA==
=y5zm
-----END PGP SIGNATURE-----

--FDWQv2pF6mZVKEZL6jmYC4sCespg6mEZe--
