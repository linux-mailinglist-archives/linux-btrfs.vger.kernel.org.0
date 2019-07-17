Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435596BA50
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfGQKeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 06:34:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43025 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbfGQKeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 06:34:01 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B322721F5A;
        Wed, 17 Jul 2019 06:34:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jul 2019 06:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=Hcg6RfbuBZSzMOlrAVWPhTotTkz
        eGGtCbTlFKzMf5AQ=; b=hzxe7MT5FcohPUNZ8nw8suBEaYV5ql2iCbKqcMvlTX7
        0x9ERpQrbEL77ymNeEP9OE+S825S5xFaql+l3jhm5fKYqL4IyOMGCmPWsee3b4Xo
        JhjrsY1kJ5Zi7mcaHOmbz2XVtabDtjskoLRac/MwRmk40hO9iJW0tsHJrRpIbuyL
        5F3jOP6+8uj2L7jhgM66C9dv5jqeeu6RbdSq6mHCWP/6hzNisPmoijIk6QrzHGQU
        Kd5hxYNoDaAQ7EeN3ikih1ONSdemmUGfr21Dq9AlGiF1/1ghf/KCQxdDPMY1CSck
        iX+rY8B6r2U8Sou9w5Q4rGT7HPPdq0x3ZXDXIxtIlAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Hcg6Rf
        buBZSzMOlrAVWPhTotTkzeGGtCbTlFKzMf5AQ=; b=pLDWEeZqwWrkoAEZQw4zDJ
        jxNhLZDncXcc2+QbkOSDf2d1ew/SW2RVx6QvOOUZV6toV9xlXyeDsvLJl5w5x/Ct
        tsB4bBQYhbN+XXJ+M8z9wlS7mxh/Wz9INtsxVL7zXNm2+dmuJgfUjj3TuPbloQv/
        iDGenHQx3JjCeSMmyP++q6kgFFQvu6bvqjxwxpceVANJul1CEXAiAZCnmrk41u24
        2Uz4NOZujBL9PApTH0nwe8f6lV304Nw3bMJeZ7KFHYRLhLdI+nPMGx/BbNGisNJJ
        u31LHIKqsl3pl9R46/gABau2KQxumJiU65kML8w4XTMFcQ1k7CIWtAofCHNwPR6Q
        ==
X-ME-Sender: <xms:mPkuXZr2QgsX5oQtP5ibCi6kThM24TnSvGa5ygmgVNB1p2pLgQXqSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:mPkuXbPjauPKOmfTxADLSuvcGVNox0Gd7MPsmxj0X_L2cWawdJvl0w>
    <xmx:mPkuXZ8_Yhhgsx2-ucuC5UI7EjaIuOUGNFbAw-iY3XALV7oI1ymcwg>
    <xmx:mPkuXZUnsyzlb-NIrmoKQWRVelwojwq8TECt1N7iAF_KaLW6aBHwUg>
    <xmx:mPkuXVZwEtjAiKYfxSRFEMu9Nk7lzALPOsEnpsr0rKmsDkJMHZh-YQ>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id E6FD380066;
        Wed, 17 Jul 2019 06:33:59 -0400 (EDT)
Subject: Re: how do I know a subvolume is a snapshot?
To:     =?UTF-8?Q?Bernhard_K=c3=bchnel?= <bkue@allchangeplease.de>
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
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
Message-ID: <af0af291-1624-bf46-8324-1cae6615a441@georgianit.com>
Date:   Wed, 17 Jul 2019 06:33:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6zhuU2WACsHNl0dSHAg3lmAfsvIGkmDMP"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6zhuU2WACsHNl0dSHAg3lmAfsvIGkmDMP
Content-Type: multipart/mixed; boundary="yAzipi4K7X7na0c18nTqdVq7D5XF6GiLD";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: =?UTF-8?Q?Bernhard_K=c3=bchnel?= <bkue@allchangeplease.de>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <af0af291-1624-bf46-8324-1cae6615a441@georgianit.com>
Subject: Re: how do I know a subvolume is a snapshot?
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>
In-Reply-To: <1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>

--yAzipi4K7X7na0c18nTqdVq7D5XF6GiLD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-07-17 3:45 a.m., Bernhard K=C3=BChnel wrote:

>=20
> I believe the usual practice is to create snapshots with the -r flag an=
d
> follow some naming convention (e.g. place them in a common .snapshots
> folder named by date), but you're free to switch between read-only and
> read-write mode for a snapshot at any time using the btrfs property com=
mand.
>=20
> That allows for some intereresting feats: e.g. there's no guarantee tha=
t
> a (now) read-only snapshot actually reflects the source's state at
> creation time (if someone modified it and re-applied the ro flag). On
> the other hand, reverting to a snapshotted state may be as easy as
> making the snapshot rw and changing the mount options to use it's
> subvolid - no need to copy any files back and forth.
>

You should *really* not do this.  Switching subvolumes between rw and ro
will break assumptions that send/receive rely on in interestingly
disastrous, sometimes silent ways.

The proper way to make a ro subvolume snapshot rw is to create a new
snapshot of it.




--yAzipi4K7X7na0c18nTqdVq7D5XF6GiLD--

--6zhuU2WACsHNl0dSHAg3lmAfsvIGkmDMP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdLvmXAAoJEO9Tn/JHRWptFeIIAMl9skpmBBLLObuz62cO6KyF
iwUgC8UzcViE797NdRtEju1jUSGl/hcjlwlfPnKtCQ+q8HMxaBnaGDUpNZyBxB/K
b1ySn1bx4JKiu0P29BPHlTxYe7amJJYF08bzNmKK4Cy4ekPinP5B3+9OfNU8SI5F
EUCvPkS1rLTABRPlTZ9Qm+7V7cl2jxoaOGxsibej4LHlTRrwMJ4nryh/678S6PIB
pOx9LX89d0EzpV2IGAl2tUM6tag1Iv8Ew92axlfuMA41obS1KTkAR/G0m++E+k/j
ElH+Hu6MECUOf6JEQYbcMlai2RKuOZTbpzV1C9IhjuMThiFipSED6Cy8QGR9qDQ=
=0lW4
-----END PGP SIGNATURE-----

--6zhuU2WACsHNl0dSHAg3lmAfsvIGkmDMP--
