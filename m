Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D7811D6F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 20:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfLLTSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 14:18:44 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39591 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730168AbfLLTSo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 14:18:44 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 40F38220DD;
        Thu, 12 Dec 2019 14:18:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 12 Dec 2019 14:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=mUZ+ZBvwU5aTTXscvUL5y187buf
        Uyndd8tEzCZDM8XE=; b=D+iQu11iPGW2iiRqwkaKVrVMYpvlnWNtG3DETn/EDZu
        bp81BtOiWgA1E4hUduGoWKv/grpRYWfBiTbMqBMMpZ24mZvtTgVLTXUOK6JJUKp9
        6szSqtUphXwGnXzqLEhSUQ1gvTj4D8/cg6uIMt+jePZx/0JHGHRPMThYk7wrmJcl
        zaZ0c5tY5thytAllnBrv1emBsV4AuKSwr0fw1cWUG9FcoU/c9sucrU7Ce2DX9Xhh
        BzilpwJBCTUOCGFRDbZ1Wlyi9oicuNDdZ4oS0TeQeozpYjWt0tPhLjXNadgcgs0e
        RqAuQrwZiRoAet2HMlyolU50mhR8vTEUHDrXgIkZAmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mUZ+ZB
        vwU5aTTXscvUL5y187bufUyndd8tEzCZDM8XE=; b=v9wXjJIiweTZx/CxmbmEHs
        3PNREuL7DGwHbT/4GqxASbDZFH+ypbsUxlVlr59FfifoULJ2JpRrprX1YTxj1NcI
        UIvwk7mBaKToTIcaJvp9fxCjYN7P5l8V0KRed1XMX64Wctl475OYwQARxCUvQW/O
        +rpzBYPeTBvGQ40mQUKtsGxy/dCvLd0MGSpXozGqLSBih0VtmgOklrcEhmcaMncY
        0W5zonpd9R4YkviMvypyPlnvdnKXNGtKZLZChcWU32cdpcCIaLfj/JsKu/LlMRw8
        dj8Qp5/0C1mKjzTimiEWi/HSCieUbR7mw1kQZrHjDyMLd0jEKxze31XnnP1L5L8g
        ==
X-ME-Sender: <xms:kpLyXb8WVTZ-F368wBc3YJ_5xoJ4QYX-ttvQxhZnBfzrkSWCaDBdLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeljedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgesghdtrefotdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecukfhppedufeehrddvfedrvdegiedrudefudenucfr
    rghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenuc
    evlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:kpLyXb8-48-nGa_To1upvFD2hsdKuRr4t5iWib3L66-PZMnijjRnJA>
    <xmx:kpLyXUA-4OkVccUnmIy5NB9yBp7iBQwsfL3QuVplHoRJxIKM72UP5g>
    <xmx:kpLyXbwKZ_76zwOARv9FnaYz8Nfkozk4IkDX1zLC_jikSynZceG1KA>
    <xmx:k5LyXXKtWKYudQ4sRX9ek8Q8vWAjew8HVz_hbWGjOHNHaZjc7_4iXQ>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id BFC5830602EE;
        Thu, 12 Dec 2019 14:18:42 -0500 (EST)
Subject: Re: Is it logical to use a disk that scrub fails but smartctl
 succeeds?
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <20191211160000.GB14837@angband.pl>
 <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Openpgp: url=http://www.georgianit.com/pgp/Remi%20Gauvin%20remi%40georgianit.com%20(0xEF539FF247456A6D)%20pub.asc
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBPgQTAQIAKAUCWiCNxgIb
 IwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ71Of8kdFam2V1Qf9Fs6LSx1i
 OoVgOzjWwiI06vJrZznjmtbJkcm/Of5onITZnB4h+tbqEyaMYYsEIk1r4oFMfKB7SDpQbADj
 9CI2EbpygwZa24Oqv4gWEzb4c7mSJuLKTnrhmwCOtdeDQXO/uu6BZPkazDAaKHUM6XqNEVvt
 WHBaGioaV4dGxzjXALQDpLc4vDreSl9nwlTorwJR9t6u5BlDcdh3VOuYlgXjI4pCk+cihgtY
 k3KZo/El1fWFYmtSTq7m/JPpKZyb77cbzf2AbkxJuLgg9o0iVAg81LjElznI0R5UbYrJcJeh
 Jo4rvXKFYQ1qFwno1jlSXejsFA5F3FQzJe1JUAu2HlYqRrkBDQRaII3GAQgAo0Y6FX84QsDp
 R8kFEqMhpkjeVQpbwYhqBgIFJT5cBMQpZsHmnOgpYU0Jo8P3owHUFu569g6j4+wSubbh2+bt
 WL0QoFZcng0a2/j3qH98g9lAn8ZgohxavmwYINt7b+LEeDoBvq0s/0ZeXx47MOmbjROq8L/g
 QOYbIWoJLO2emyxmVo1Fg00FKkbuCEgJPW8U/7VX4EFYaIhPQv/K3mpnyWXIq5lviiMCHzxE
 jzBh/35DTLwymDdmtzWgcu1rzZ6j2s+4bTxE8mYXd4l2Xonn7v448gwvQmZJ8EPplO/pWe9F
 oISyiNxZnQNCVEO9lManKPFphfVHqJ1WEtYMiLxTkQARAQABiQElBBgBAgAPBQJaII3GAhsM
 BQkJZgGAAAoJEO9Tn/JHRWptnn0H+gOtkumwlKcad2PqLFXCt2SzVJm5rHuYZhPPq4GCdMbz
 XwuCEPXDoECFVXeiXngJmrL8+tLxvUhxUMdXtyYSPusnmFgj/EnCjQdFMLdvgvXI/wF5qj0/
 r6NKJWtx3/+OSLW0E9J/gLfimIc3OF49E3S1c35Wj+4Okx9Tpwor7Tw8KwBVbdZA6TyQF08N
 phFkhgnTK6gl2XqIHaoxPKhI9pKU5oPkg2eI27OICZrpTCppaSh3SGUp0EHPkZuhVfIxg4vF
 nato30VZr+RMHtPtx813VZ/kzj+2pC/DrwZOtqFeaqJfCi6JSik3vX9BQd9GL4mxytQBZKXz
 SY9JJa155sI=
Message-ID: <ff7f40eb-301e-e890-f58d-99f65a79cbe1@georgianit.com>
Date:   Thu, 12 Dec 2019 14:18:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JOblQtx0H6kabHlXLbL9whNz2p4bVwTDK"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JOblQtx0H6kabHlXLbL9whNz2p4bVwTDK
Content-Type: multipart/mixed; boundary="x1UmuNGJwjE6BZtbqrzBri1xoFQabClyf";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Cerem Cem ASLAN <ceremcem@ceremcem.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <ff7f40eb-301e-e890-f58d-99f65a79cbe1@georgianit.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl
 succeeds?
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <20191211160000.GB14837@angband.pl>
 <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
In-Reply-To: <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>

--x1UmuNGJwjE6BZtbqrzBri1xoFQabClyf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-12-12 10:40 a.m., Cerem Cem ASLAN wrote:

>> Try 'smartctl -t long', then wait some minutes (it will give you an
>> estimate of how many), then look at the detailed self-test log output =
from
>> 'smartctl -x'.  The long self-test usually reads all sectors on the di=
sk
>> and will quantify errors (giving UNC sector counts and locations).
>=20
> I tried this one, however I couldn't interpret the results. Here is
> the `smartctl -a /dev/sda` output:
> https://gist.github.com/1a741135af10f6bebcaf6175c04594df
>=20

That drive is toast.. the giveaway here is the over 1000 "Current
Pending Sectors.".. there's no point trying to convert this drive to
DUP,, it must simply be stopped, and what files you can successfully
copy consider lucky.  The rest depends on your backup...  (I wasn't
clear on why your backup is supposed to be bad... BTRFS should have
caught any errors during the backup and stopped things with I/O errors.)



--x1UmuNGJwjE6BZtbqrzBri1xoFQabClyf--

--JOblQtx0H6kabHlXLbL9whNz2p4bVwTDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJd8pKRAAoJEO9Tn/JHRWptxpIH/je+nDHvXrMfnt+JzMH2v8MF
C1lYUSvqnGCI/JkjMUpFvHpTX1EsJ6G6W2ayRSBID2EJAD700UBe85mTmkA7vVV5
yWzhoOgSLIljK7Vw7WJ9FY6VyZykn4X1C3FgtSW47yIcklT5zsJelr/13CvbvLQl
WNPhJuhsBmFOW54CsNTwCRMMv3GaLCtrW+D6yuBTE3nfSw8b8BLPI2nshYWiqw2Q
ZxNZ1o6FLfysuRom5IbbFetkXYD5WIXyB3DPWuobMEleH8h97dZtMdjPzrnkr5yd
7G5I4J/TApStVfb434iJreyJWGKkZO2vDvxDFbkLQA46M3NP4L38d8DU4unZtG4=
=eqZN
-----END PGP SIGNATURE-----

--JOblQtx0H6kabHlXLbL9whNz2p4bVwTDK--
