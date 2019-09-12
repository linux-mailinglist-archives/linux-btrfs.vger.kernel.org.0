Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA54BB0627
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 02:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfILAKQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 20:10:16 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60541 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbfILAKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 20:10:15 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2345E2260E;
        Wed, 11 Sep 2019 20:10:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 11 Sep 2019 20:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=LXnPcXFz3wJxdF5fTpbmehN7bps
        ZFLe+qW+mPhJu3iw=; b=fBsebRWQ5BcITJEn0B/TXR4zERoaKaEJM60e/n7QCUT
        AagC4v2NWu10UE1T6KJqoCTEe0s5S1+evjmG+NxLEEwYGG8vlxGsT2z6HM9M/7tr
        D7FIE4RBCI++Y0jSG6ePiF3pKR6YLeeT2m51HWpLbt7kxrzF0YMHJLe5Z19rM4VP
        RAkR51nhrKfh3tfMLHogCgn+fRNjsyxILT4+VRd3l8MTZoADbrTU4DrNmHR1tupK
        9Ef2Hb6e91HgAFWHQbu4aRNNO2WqlqexCPpWNRityoPg6dVPXdAbG0dbnXuPwVkx
        +4gyIJp3DcZLGcv5QVG/3z/TMaZ677YEt6H0S2TABuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LXnPcX
        Fz3wJxdF5fTpbmehN7bpsZFLe+qW+mPhJu3iw=; b=QNdoF3bWR2GLrIiJ8oCbkm
        yOnbXLPbFdOBNMQPvqM7yvzP52L3vgK8V/6mJYwUD5WRHBTZ4Eb4v+5kopjytvPd
        C5hxufJ+VSgwd8uUcie5g1hKfwjmAGlMoNYnaBJBEyuj4wmc2HKc7GUNdMbdR/lS
        KbQ7ToEs61HFtxMyRLL6QJ0pyRj9sSZKaA5bUxDbfSJ9OM7t8VS7dq0u1oDGuxf0
        kPIwDJdk4uNsaA4D2bFV5rrkk8P3gm0Ta8ggtOE18pADWq3krolySCmpzkmPUjo9
        uDeTcRfUxDbnxykdZYj97Z5fFSGG4Phl46P+s2UZL6Ne0GFmABzDAwh2VOaWsebg
        ==
X-ME-Sender: <xms:5Yx5XRQT5BMosQn8t4D4xj19nvsQJfh0iybvRhEcI5O-LDRLbcPX8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdeggdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:5Yx5XaeFaPGLJrJL504CB1zgY2FUaZ6jkRI7zIVSGMScuEZrskgOQQ>
    <xmx:5Yx5XcykJqiCMUkVBls4awEUkhtBpUbTp4M9vqlYhoUVcCNgt-jS1A>
    <xmx:5Yx5XTQvO1yj1b_bMbn9ijiPKZS5I2ZvFGHeUDbF33Uwxijjn4t8iw>
    <xmx:5ox5XY6BxRrfmDL_AoXHqX29ugzuECQasYtMNUK4PtKLts_A2BUUaw>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C8EB80069;
        Wed, 11 Sep 2019 20:10:13 -0400 (EDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
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
Message-ID: <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
Date:   Wed, 11 Sep 2019 20:10:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RW8cDceBxXX4qErlsuJPVueGf0Nb5TDD8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RW8cDceBxXX4qErlsuJPVueGf0Nb5TDD8
Content-Type: multipart/mixed; boundary="PSGRcfIXhGwBzfNBulOJEuxw6dRu5THYs";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: webmaster@zedlx.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
In-Reply-To: <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>

--PSGRcfIXhGwBzfNBulOJEuxw6dRu5THYs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-11 7:21 p.m., webmaster@zedlx.com wrote:


>=20
> For example, lets examine the typical home user. If he is using btrfs,
> it means he probably wants snapshots of his data. And, after a few
> snapshots, his data is fragmented, and the current defrag can't help
> because it does a terrible job in this particualr case.
>=20

I shouldn't be replying to your provocative posts, but this is just
nonsense.

 Not to say that Defragmentation can't be better, smarter,, it happens
to work very well for typical use.

This sounds like you're implying that snapshots fragment data... can you
explain that?  as far as I know, snapshotting has nothing to do with
fragmentation of data.  All data is COW, and all files that are subject
to random read write will be fragmented, with or without snapshots.

And running defrag on your system regularly works just fine.  There's a
little overhead of space if you are taking regular snapshots, (say
hourly snapshots with snapper.)  If you have more control/liberty when
you take your snapshots, ideally, you would defrag before taking the
snaptshop/reflink copy.  Again, this only matters to files that are
subject to fragmentation in the first place.

I suspect if you actually tried using the btrfs defrag, you would find
you are making a mountain of a molehill.. There are lots of far more
important problems to solve.


--PSGRcfIXhGwBzfNBulOJEuxw6dRu5THYs--

--RW8cDceBxXX4qErlsuJPVueGf0Nb5TDD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdeYzkAAoJEO9Tn/JHRWptwuIIAInSA+jbBy/UM2Zric0x4KT2
sWybn/YN3+Om7zu2GA1lhNWk3Puoegu+ihqU8tweLt6z9OnXg9JUO1I99ff0UiiR
Ge8uu51c7eGuWsJhSPjDzt41lkvcZwLa0lERFJ45ImcxKe5L+cAvr+9fDVro/ZmG
cHP4XysAAHbBJGAplrOCZFhrWtaTgOBxkeBUH4ZjBH3HnnZYVuuYHYPZrihpZ4Mw
FlHucxZvZFIjLXCJs8G57h7zeIlWbGcpOKAumjiIKPgq3668rNYEig7GP4xdO8A9
q5B5Nqks9f4TFbl+J+0HxXaGZ78dDsz3eW8DnHAT2EsDqP7WHX8aDbzgOlC1YlQ=
=fdUL
-----END PGP SIGNATURE-----

--RW8cDceBxXX4qErlsuJPVueGf0Nb5TDD8--
