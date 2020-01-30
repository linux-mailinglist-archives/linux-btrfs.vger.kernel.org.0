Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE22214E4BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 22:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgA3VUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 16:20:50 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40507 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgA3VUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 16:20:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 4C788639;
        Thu, 30 Jan 2020 16:20:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 Jan 2020 16:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:cc:message-id:date:mime-version
        :in-reply-to:content-type; s=fm2; bh=XXQXVRMrZWdq3FlYmSFDaDP2zME
        MB2gYCkHYqPP17TQ=; b=iqrBD2A5OJzgPMH7Jd9e+mUmmlTHvCp14QZvYR2sYVj
        /l+dBndhvv7BAVgL4AcPegImUYqqtvMO6v2a8CEG31ZG0K1SVPG3qw2BJr89SOOY
        S0Fw1wniXNyr1ygO42NjRNLeShtaPofYxB5SbugyZpj0hCkTdxHJRp0sfqRnG18y
        7gnVVd4+EM7YB6VxDuQuUJP4iS0Kq0jXLqAT2aeCDBGiiAscoDCPAFpTzkawmsAQ
        bBm8TeT77p/tG/JBLr1CYBiT0JqeeSA+X8CCgNimMdhyxDfJh4ZJclNIJezkAZhC
        PCi7Hx6vbOMQgVtkRzdQECBJ9YdowvUr1HkOJVLkQ5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XXQXVR
        MrZWdq3FlYmSFDaDP2zMEMB2gYCkHYqPP17TQ=; b=I6jATvCtcNpfisIry0g6sX
        WSXHv0eupVwQNA+YA0sTZWh/XoS7fYEC+QJ0Kgqn+xyrzur7YbZA9Ryo0xUG5HUl
        q7fXemmWwG4Ca7+3omctG0Lg1XVQIbZ9fB9Tquwhme7OYK3nKfok4IuH71Rn5xJU
        zR/Wfw/H1Fd8sHsZu64aXgHsKLe54xcjSIE6PFYIR8VMK1qCQXJnQU/dUEpArczc
        y+VnIdA4EGMxwoxXpF6AckFkcjXFUD93GY6lGUuVegy66s8wdaEztc8jHuBEW+B3
        Q8zMn7ogBLhoW67E90NNQL89Exc/+87uVp+gbwLVmwmh2UzOj4zAewke7LdXDZ7A
        ==
X-ME-Sender: <xms:sEgzXpc-Ubv5qadqwnOfZ2FTULqnxymKZdOQvzn3-19PUCsUzoV63A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeekgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedvfe
    drvdeffedruddtvddrfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:sEgzXoxMDi774y-DLgPElLHi_mDwknsri4GX2us3cPHLmNAnFVK6hg>
    <xmx:sEgzXo1GuOVXRpufg1cneJeBBqYwmaQUp0SskDty8LfIg1kQ7Tr-eA>
    <xmx:sEgzXuzweiKrBhpzUS2CqINX9a-phWhjSRnFq71rEr7j2BwFRD9x8w>
    <xmx:sEgzXlQEB2XqSH3OXgURTMCW2NRkmjQv62swQrQ-fs9en7K7BJgJ8w>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E358328005A;
        Thu, 30 Jan 2020 16:20:48 -0500 (EST)
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Martin Steigerwald <martin@lichtvoll.de>
References: <112911984.cFFYNXyRg4@merkaba> <21104414.nfYVoVUMY0@merkaba>
 <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
 <1887603.ctEADUaVB5@merkaba>
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
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <4b18e328-72fc-8167-d140-97c898c47e6a@georgianit.com>
Date:   Thu, 30 Jan 2020 16:20:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1887603.ctEADUaVB5@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DIwQsDUyuVUnGtzeufPaDonOPhV9LnN7W"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DIwQsDUyuVUnGtzeufPaDonOPhV9LnN7W
Content-Type: multipart/mixed; boundary="OshYGbl0FUYN2FEftT9WorLjB7a5rrrLQ";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <4b18e328-72fc-8167-d140-97c898c47e6a@georgianit.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
References: <112911984.cFFYNXyRg4@merkaba> <21104414.nfYVoVUMY0@merkaba>
 <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
 <1887603.ctEADUaVB5@merkaba>
In-Reply-To: <1887603.ctEADUaVB5@merkaba>

--OshYGbl0FUYN2FEftT9WorLjB7a5rrrLQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-01-30 4:10 p.m., Martin Steigerwald wrote:

>=20
> I am done with re-balancing experiments.
>=20


It should be pretty easy to fix.. use the metadata_ratio=3D1 mount option=
,
then write enough to force the allocation of more data space,,

In your earlier attempt, you wrote 500MB, but from your btrfs filesystem
usage, you had over 1GB of allocated but unused space.

If you wrote and deleted, say, 20GB of zeroes, that should force the
allocation of metatada space to get you past the global reserve size
that is causing this bug,, (Assuming this bug is even impacting you.  I
was unclear from your messages if you are seeing any ill effects besides
the misreporting in df.)

Note: Make sure you don't have anything taking automatic snapshots
during the 20GB write/delete. I would create a new subvolume for it to
avoid that.





--OshYGbl0FUYN2FEftT9WorLjB7a5rrrLQ--

--DIwQsDUyuVUnGtzeufPaDonOPhV9LnN7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJeM0ivAAoJEO9Tn/JHRWptbCQIAOj7UKqpY+xuFRZk5Z2snP/E
D1/hoL+uZx+LEF8/RpFqrWg6XBScocmnKGT7udNnhdiV5tDofMPQcOHKk0sPk/Lb
HIjfwlvqWqMUAk/u5mfN8h2C2ZhhIP2Ow4KoMnhfWzMUsjcXGTlox0tdgA7DJvOQ
Uy+Zr/sTki/SnvHO/3yMWM7VTRlOQVUWtM0mzcYujSB7tD+4u/TDRPCc+tqHpATK
SDYIHhPWtHnzPEUrFqllAYxhE7kkdvbGLiJRDWKZMoGZq7ehUo0M/GW4nkldXXKN
cymkk/gX2hEqgK6UJRQu7ocGIANEckVa/U5yyh7vk4+EBZZjzTnrgvhp+JL8QBk=
=pdDG
-----END PGP SIGNATURE-----

--DIwQsDUyuVUnGtzeufPaDonOPhV9LnN7W--
