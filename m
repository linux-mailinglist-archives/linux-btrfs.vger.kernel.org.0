Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242453C0CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbfFKBLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 21:11:31 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48639 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389723AbfFKBLb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 21:11:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 6FB34477;
        Mon, 10 Jun 2019 21:11:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 10 Jun 2019 21:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=+1ls2VRp+oZJa/za1CSadqiM1s8
        +frcH/RsVQnk1ROM=; b=ALNnpRu73HxSWH1cDgJR14XumJ3cqHNcWBHYpUjbhjZ
        DL0ehIscHmeVL8gQPv4Zcg2PZxdycQrCoFGYeTBhmjtpTowl2iosfcn+6LwsGl6v
        jjmaTgvcWnxyeiN+UW/v5aIQKKLnYr9nvlLsaRU05O/qSp9jvrjuWjMDMWhOsiN8
        yp/lIadchow65M09NTVk5p/dcykJH5nsOX71M7fLu5SwCuiDcMnzTEyxMUIamhC7
        Z4iDwW11CYxbUNSyxOQLlCcBPC24H6PP8YRpv81Kkazrx1z/ksMPOBu+TCiuzUF2
        /i5yzdg3mKTIjin91pvMazIVOsLDYaRgmNSDpCGtPsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+1ls2V
        Rp+oZJa/za1CSadqiM1s8+frcH/RsVQnk1ROM=; b=D+WB6A/7OqetbFA9i8G0S7
        ONCeLqeHpaIzJj5VAXLOSEwqt8K3n5NjGqTJ6ZXSoMZwlSNzzriI4yiw7nBj/fNQ
        JVgl63sI0JRJE7MZJn0sgj2GylVF29aDRj5T7ULsq/ISA4Y0fv2YyG3lC8N+1MkM
        dLD1Utc4QZy6N67sACaTh/3Y3CuSE6jpzhsCTR/GyOqS0CUoHFUKb/AZZjenel0Z
        XXQR+xtSFyTigQUbMfPoVjuZkoCJVKD9alGGPliYLOCYkHPH6Z9RBknLNKwmeYCy
        XexRcac9mP1myp6zqHhW8ocKdLHz7MZOeg455BtpIJC1+9U42XhTdmDdvckCWQrg
        ==
X-ME-Sender: <xms:wP_-XN9muEv0IbqEy_T-Hq2J4zrmaituyqytPzin_OfMSLMwC8hjCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehfedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeehnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedufe
    ehrddvfedrvdegiedrudefudenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehg
    vghorhhgihgrnhhithdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wP_-XDCAzL00GFj7g9PKN4p9rmKRVNb9bumeKs4GMd3z3IGevZ1gog>
    <xmx:wP_-XNf7pyX2Y6R5eo7WyUGiIq3KhRSQaiA-HarNoFema_A-c8em4Q>
    <xmx:wP_-XHGkutko9uMhCe1l1dIEXlePC6GwsWBegHQxm2byaAPM_BpAMg>
    <xmx:wf_-XGoWZmtWB7nly6DatROE9c-VXnb3JpENOyAC1n1uO5D48ltMNg>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76BEB80060;
        Mon, 10 Jun 2019 21:11:28 -0400 (EDT)
Subject: Re: Issues with btrfs send/receive with parents
To:     Eric Mesa <eric@ericmesa.com>, linux-btrfs@vger.kernel.org
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
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
Message-ID: <17367bc7-fe7d-5014-7b75-2a3520da119f@georgianit.com>
Date:   Mon, 10 Jun 2019 21:11:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2yyV7gdS7wNpvVFoc69o1I6sVyDUZ9nRp"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2yyV7gdS7wNpvVFoc69o1I6sVyDUZ9nRp
Content-Type: multipart/mixed; boundary="W0vh9Ky8jpGhdCd0n8GcQTEE8HDwhqIsW";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Eric Mesa <eric@ericmesa.com>, linux-btrfs@vger.kernel.org
Message-ID: <17367bc7-fe7d-5014-7b75-2a3520da119f@georgianit.com>
Subject: Re: Issues with btrfs send/receive with parents
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
In-Reply-To: <3884539.zL6soEQT1V@supermario.mushroomkingdom>

--W0vh9Ky8jpGhdCd0n8GcQTEE8HDwhqIsW
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-06-10 7:56 p.m., Eric Mesa wrote:

> ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
> bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 -> ermesa=
/.mozilla/
> firefox/n35gu0fb.default/bookmarkbackups/
> bookmarks-2019-06-08_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 failed: N=
o such file=20
> or directory
>=20

Are you by any chance using btrfs property to change RO snapshots RW?
That must *never* be done to parent subvolumes, on either sending or
receiving side.  (Really probably not a good idea to do at all outside
of very special development/testing cases, but is guaranteed to make of
mess of send/receive.)




--W0vh9Ky8jpGhdCd0n8GcQTEE8HDwhqIsW--

--2yyV7gdS7wNpvVFoc69o1I6sVyDUZ9nRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJc/v+/AAoJEO9Tn/JHRWpt8uEH/2B+yv2nhyCkBqT8CG6bwYAF
8u64SkqEQofobucPcsA1AtjHCChEyvEW17L+37UIAGMAzAAzPeT7nL7si23U1lBv
h2NSAUf9umJ+vkFGUOzEO0O868DslPvnzm1kFFUSas6c+d+4eWPi2WsSqIabU1Xg
JdJoV8KrftajAGaZYliZce3MpBsWmnK/ZzMiHjtF9mo0y/KIocL0sGnUq8Y89zgG
VzXi80QX01unZftKCVQWqbvkgC7le0Y6gk8jfylB0NqlATWoiyL1lHuMPrCD4kog
qfC44DvmiPFkVFp1up337jurWQtL12QWkw/KSB/qNOQrPy9amttpKH7s5V9l+Mo=
=Tkxj
-----END PGP SIGNATURE-----

--2yyV7gdS7wNpvVFoc69o1I6sVyDUZ9nRp--
