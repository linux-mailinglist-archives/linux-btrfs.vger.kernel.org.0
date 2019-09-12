Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A63B0726
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 05:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfILDaq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 23:30:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57105 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfILDaq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 23:30:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AEA421B4C;
        Wed, 11 Sep 2019 23:30:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 11 Sep 2019 23:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=4llnWGExbWeE2IQlUoCAxlm8EDa
        LbwXyn9KFH8MMZKI=; b=M3Zzh8KSnWMPZRE3kYwbtNlYfPk7zvly8B/skAwQek3
        fu5K6tRqmNyHaOvMMMmToVDVtlB9+GNkwjuNE6rZyITTG12PQU650pyU+Kc5tJXj
        LFK6+7cOqrFgcNEy0zaoFPnZNHOHXzXbIcxkV06Wky9Pa6upStLILI7tJ5mfPGEd
        j4i+O00zoEoWCI+0XOAwsa7pHY6q+4B21aYaNfjWPNQe40Aw7JnVxCAB/V6UJFpz
        LP3M8kA/xwdbcglHnnwLjL7aFT44EbQi5MI7ofA46pWFUhmkBVOB9jx0a+EfrxUG
        nUJ89Nbojhiv0k2fvMmDqES8R0mcVamuBRJoNqKSQVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4llnWG
        ExbWeE2IQlUoCAxlm8EDaLbwXyn9KFH8MMZKI=; b=DcjEuehPF+Xo7vF6tmDMpt
        78ReXg/lilAaN8H+6rXOlgZ9x8hzTac2iz4oYqiV6vrl2SwXD09DP21QWFh8LMNZ
        kzIv0fzNrswexuGjdoofdqgkGcE+IVHcB0aBzZVNB4//pKSAZdPyKNTDc0eiJEma
        LAqFxdKUJIK9T8Lw3W5RcxaVezUBMe6IGh6g4USLATJ+8b9XUgtz1k5c5/znD/un
        81w6CPh7ihKMwZB5NbWFcEusDdJKioA8VZBfyZwTwnf8jYqNXvjytwbNBCgKDm2f
        hVg+f8DtUMJbB4Kwf2awUsSkRKsuI+Y4o1IycI29UaKdr1llr3/MGj3LM8KC4QOA
        ==
X-ME-Sender: <xms:5Lt5XTE4xQqrEmz5DlCG5glgI3BusrI9MjVo1IcXFKJk0VSl1J9ETQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:5Lt5XUnoxbJl5w5byVZZr6d6q5dLxbShB4Nlmef4aRBuuzs-eUL_bA>
    <xmx:5Lt5XQJq7B_XBMvPk9V6IhP3am-eW29OlqNGCbD_xOHHZ7c_54e1DA>
    <xmx:5Lt5XVb4vYOnlUOFbG8LNuF1u_nvxw_c_Zq31DRdAwDWRujK6Obl7A>
    <xmx:5bt5XSTLDFFcIFMDj2T7KI5JgLqwVbYnAdfSA9mirgVREvckEayMbQ>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8B98180065;
        Wed, 11 Sep 2019 23:30:44 -0400 (EDT)
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
 <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
 <20190911230542.Horde.UywNUEBF6L2ExMalgJ0dDTG@server53.web-hosting.com>
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
Message-ID: <c6ec609a-bde8-2a58-ae9a-f845b7a2da43@georgianit.com>
Date:   Wed, 11 Sep 2019 23:30:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190911230542.Horde.UywNUEBF6L2ExMalgJ0dDTG@server53.web-hosting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7798SxtCxJCozxvFjQyhpMazJc9h9Mp80"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7798SxtCxJCozxvFjQyhpMazJc9h9Mp80
Content-Type: multipart/mixed; boundary="PvsLeu24Sabmtwm6ue4vxqEKmsR8tvozt";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: webmaster@zedlx.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <c6ec609a-bde8-2a58-ae9a-f845b7a2da43@georgianit.com>
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
 <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
 <20190911230542.Horde.UywNUEBF6L2ExMalgJ0dDTG@server53.web-hosting.com>
In-Reply-To: <20190911230542.Horde.UywNUEBF6L2ExMalgJ0dDTG@server53.web-hosting.com>

--PvsLeu24Sabmtwm6ue4vxqEKmsR8tvozt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-11 11:05 p.m., webmaster@zedlx.com wrote:

>=20
> Close, but essentially: yes. I'm implying that snapshots induce future
> fragmentation. The mere act of snapshoting won't create fragments
> immediately, but if there are any future writes to previously snapshote=
d
> files, those writes are likely to cause fragmentation. I think that thi=
s
> is not hard to figure out, but if you wish, I can elaborate further.

You'll have too, because the only way snapshots contribute to future
fragmentation is if you use NoCow attribute, (an entirely different
kettle of fish there.)

>=20
> The real question is: does it really matter? Looking at the typical hom=
e
> user, most of his files rarely change, they are rarely written to. More=

> likely, most new writes will go to new files. So, maybe the "home user"=

> is not the best study-case for defragmentation. He has to be at least
> some kind of power-user, or content-creator to experience any
> significant fragmentation.

Torrent Downloaders should make an *excellent* case study, and not uncomm=
on.


>=20
> Btrfs defrag works just fine until you get some serious fragmentation.
> At that point, if you happen to have some snapshots, you better delete
> them before running defrag. Because, if you do run defrag on snapshoted=

> and heavily fragmented filesystem, you are going to run out of disk
> space really fast.
>=20

Agreed that if you have large files subject to fragmentation, (a special
use case for which BTRFS is arguably not the best fit, at least, in
terms of performance,) you need to take special care with
fragmentation.. ie,, defrag before snapshotting when possible.


>=20
> Didn't someone say, earlier in this discussion, that the defrag is
> important for btrfs. I would guess that it is. On many OSes defrag is
> run automatically. All older filesystems have a pretty good defrag.

This statement makes me wonder if you really belong on a Linux
Development list.



--PvsLeu24Sabmtwm6ue4vxqEKmsR8tvozt--

--7798SxtCxJCozxvFjQyhpMazJc9h9Mp80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdebvjAAoJEO9Tn/JHRWptfPEH/R3YBng1NGutR9mDf497ofUC
exuhJ5vRwX0LdlVViJE+CBkTkXdZxLbQMhCY/gXPA+X4CRNx2qJDQ1fiQ6Yd2J4O
Sko0o/ORFw4vX9ufTglMYY5NDU1Kybbd6caNvXMUUmm1g4ciZtKWzMvpXHG+/VSk
y0YC7sjsr+6HVq6p6dDnBMFgoDCYYcJ8AiwkNWyYbXp2mP/+1EqinrM+zAVOOlUH
uNyxeFdC1U1UVC5onjfJlJd/rvTpMSFWc3CLLOH8h1zWJ6RqQ14qbEGwMRORx313
XfjKioxX0KCBA7w42F8pJ7x2RGHmHe8rOFWT0YkFci8dp3irtBVtdvI3SP1jSBk=
=jnl7
-----END PGP SIGNATURE-----

--7798SxtCxJCozxvFjQyhpMazJc9h9Mp80--
