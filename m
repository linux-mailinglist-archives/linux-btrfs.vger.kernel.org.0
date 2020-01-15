Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340EB13B818
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgAODPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 22:15:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43705 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgAODPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 22:15:15 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DD7721F82;
        Tue, 14 Jan 2020 22:15:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 Jan 2020 22:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm2; bh=/dbiXt/YoeweEoftmnHSjhWH++a
        l0XzAMEmUfXl+h7Q=; b=cvAfbrqs9oT2ErEpxHlyUgW7SNizZREX5dqIxJVkpSO
        vxyPx6EsE3kb06lrpcJm3IHTeiE+x7uNGdNTUUZOBQwvjDiYgRn+QIHpv0baGR+q
        34uIF9MUTa320xpD4rIrgmXKbvt5xcc2XgDT7rn2duUkJkEPbdGMTmjvdBU6b58d
        fWVxsb3mOI0L6pPmyL8H5r8qP5eJ4OAKf00iin6sqbZiSY8LuuU63xWbGF270t/z
        s8n4EldmOm0WtRc8F41SiPdZ6e+wsXog4bzEDCW8Btv7dWKm0HN83g9pHG/PEKiT
        5EwZtwyLdulX3Q5dXvDzowJonNxjfQ41030Dtd/Odtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/dbiXt
        /YoeweEoftmnHSjhWH++al0XzAMEmUfXl+h7Q=; b=RFJVBWmmomy+zNBHeA2JUX
        8/V9OYhxupeufSGUhO77Vao2mTbhQlKmLP5j1FRaYoTckXVKCm7CqwivHucnr7wF
        X3LvR+omYQmxdIfcJa7B8c3AsuT55q22aD5M8Tx9F9fK6Dqss02ekCFZNKTHm7D0
        RO8PjW4YhKr+cZXh1A5V4yDN2Nlmwf4PTH2YQ3haynhAKzT48GwZZsS50CzSH8JG
        oV3jrlp5ohAt9Svs4JtcScNkRVUE7iTeruRrw42s2z5zdHtMNwhZMsWsoide/dxq
        /RkC2osYheYfIAYqehx8tAZ6vN8T4/p5NB+wLuTJ9Z5VuFtl5yhiOUypqYPuBr2A
        ==
X-ME-Sender: <xms:wYMeXkIF1Ki9Ir-v5Troc6ZOobTFRrFajm-sapXtcIguOzjIJ8816A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgesghdtrefotdefshenucfhrhhomheptfgvmhhiucfi
    rghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucfkphepvdefrd
    dvfeefrddutddvrdefkeenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvgho
    rhhgihgrnhhithdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wYMeXv1YeoBuEgJWyuI1SfvK7WrUAfJYvcECkWtdpm4g9fI7HgK-1w>
    <xmx:wYMeXvaKj6u4CRNGWRQeVadMCFqrkw2pra2nLr9_r5WluAfh1zpdlQ>
    <xmx:wYMeXiV26T8eH1hq1pHVeluOLvXgngF87sD42OZzThRxnboP4fAwaQ>
    <xmx:woMeXkjuHE4SIFN-yfqr167XjYGUgTjy_xphVHa_S1gu18rwcspVmA>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6412080065;
        Tue, 14 Jan 2020 22:15:13 -0500 (EST)
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM
 volume)
To:     jn <jn@forever.cz>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com>
 <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz>
 <CAJCQCtQhVQrnq7QnTd6ryDSg4SAGv55ceJ+H8LTM6MEYzQX4jQ@mail.gmail.com>
 <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>
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
Message-ID: <93d25506-3782-a012-384e-d61cb2589b4a@georgianit.com>
Date:   Tue, 14 Jan 2020 22:15:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GO4o7vSf11XnyXkoNNiUshx2Wuuan57mS"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GO4o7vSf11XnyXkoNNiUshx2Wuuan57mS
Content-Type: multipart/mixed; boundary="QqBWRKaoOOVxogDZDnuV7zer27RjvDZ47";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: jn <jn@forever.cz>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <93d25506-3782-a012-384e-d61cb2589b4a@georgianit.com>
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM
 volume)
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com>
 <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz>
 <CAJCQCtQhVQrnq7QnTd6ryDSg4SAGv55ceJ+H8LTM6MEYzQX4jQ@mail.gmail.com>
 <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>
In-Reply-To: <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>

--QqBWRKaoOOVxogDZDnuV7zer27RjvDZ47
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-01-14 3:53 p.m., jn wrote:

>=20
> Unallocated:
> =A0=A0 /dev/mapper/sopa-data=A0=A0=A0 =A0=A0=A0=A0 0.00B
> =A0=A0 /dev/sdb3=A0=A0=A0 =A0=A0 1.86TiB
>=20
>=20


With only 2 devices, and one of them being completely out of
unnallocated space, I would expect it is impossible to allcoate any
mirrored blocks.  (The system needs unnallocated space on 2 devices.).
If it's possible, you might have to do some filtered regular balances
(ie, no convert) to get some space on sopa-data.  If there are large
chunks of data you can copy off and delete, that might help as well...
(completely empty allocated space should be de-allocated.)


I believe Chris also already pointed out some concerning errors that
might hint at unhealthy underlaying hardware as well.



--QqBWRKaoOOVxogDZDnuV7zer27RjvDZ47--

--GO4o7vSf11XnyXkoNNiUshx2Wuuan57mS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJeHoPAAAoJEO9Tn/JHRWpt1IEH/i+7yXCkyBEGGweQZF+JFKlp
PfWh+FpQfSpqAgC2DsZxZK+FTV/4sS6orEO6ZVgdexV0Ws2p/EIta3zC86EADkrC
z5ZBILmuMYsLfCP4JbZvp3ZCbf/G1de1d8u6sow9d//1jAmvjgnSysr8CgZ9Z95l
uavELVaRQbukkHDZoW26LFWlqx9ftWchsxz4UhIizqJH4SskFB4DEGG5DKzKHNcF
MvpAI86HvIZ2aAdKRPl2WU6w1FhcrPo4Co8Nzl3F9pOxu8NGhXCKvPvuCHF8igIJ
jIj+jt+i4u/PJQ0wAp1fKnlDojRtiqVrS1i8LHjP6WkboA8+RuIvhVNGzwckAtg=
=I4a6
-----END PGP SIGNATURE-----

--GO4o7vSf11XnyXkoNNiUshx2Wuuan57mS--
