Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782C62009A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgFSNMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 09:12:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34613 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728973AbgFSNMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 09:12:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D0B5A5C012B;
        Fri, 19 Jun 2020 09:12:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 Jun 2020 09:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=LYx7x1mb35OJm7A4x/UWu/a7HoK
        lwcyr9KYLPU5+zYo=; b=RwYVfl5LFjUdJS+6X+iL3U2aGM0tEOy3akpyENeci4n
        HIfcLzrHs+KSeIMgxkC4Zs+ftRIOqDicAzxTvyrekWaeNEqg9KtsscMfdK1+fU5W
        1qWj/lpMyFXAH8/J/FXVKTCRUWcmXwMQvdNhoqI+FtHIRJ7+/6zMALasLogLUmkG
        yBym0v/Cb3bQZ3DZprr1S29UaqzmRTN39AoAqeDxqOwHQdoKB/zuDk/2/Yy9hX/z
        p3+2Dlg/tXjJUxOKBjWgHfl67T0sFprWlYOClzwhRfYA7hbbr3kdqifa7iw7oMIO
        LTrN/qfF9etjfkKod4q9qz56J0VYONSoxjuWinjQVvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LYx7x1
        mb35OJm7A4x/UWu/a7HoKlwcyr9KYLPU5+zYo=; b=XksBTC/KH6zzROVVhp8ERb
        y+O8CMT428Nw/gGsQ2Fc4xf5EeGNho1qGIx5sgiuEG2JB9ismXKOP5exNzmcXY6/
        up6tJl09vIVXDdG+vPWJ8LHwpm7zhGLz9Gk+qrnToXoFwkowUHEbPGtSQZ3T5SwX
        CSNbP6+n96Pa9r7Mi1TVihxr1FTojJ45SiUdP250Ts4h9yeseoCrV/is3FsCh42Z
        V0mYYA7ERWcfdimMufFAfGusNkdUhcjuPbow968D6kuVwl/uReF9D9X9G7uauiaP
        ImmU49VwZ/BXJThN4JI7z0PZuoOAu1fQxYNTOBnfZfXj9Wy8y6Rp+StsPe51yHQQ
        ==
X-ME-Sender: <xms:vLnsXtyUbTkecpTPL4C5XbUoQkP7aOATGmJBIq37US5lR9qMYM-BgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejiedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrfgrth
    htvghrnhepgeefvdegtedufeduvdeltedvledvvefgleejvdettdeufeeufeeivdeludfg
    ieejnecukfhppeduledvrddtrddvfeelrddufedtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtgho
    mh
X-ME-Proxy: <xmx:vLnsXtQlLDIjRLGc0C-FwdYRZuS3OyBSwyc2iT4TdG-5unf5mY65Ag>
    <xmx:vLnsXnXrmLV6TvqZgXTRQLcFInl9-0TLg7ZeE49j-zyhvh85_EW-Bg>
    <xmx:vLnsXvjKZoDi7VZlFLgosvP3BLHltsS0Dgvrhap85nuyWw21QXl_4w>
    <xmx:vLnsXi-_l3ZKvAi57XNAlwBJVEclFco9dUex0hVGPY8VtGXsorZK4Q>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44C153280059;
        Fri, 19 Jun 2020 09:12:28 -0400 (EDT)
Subject: Re: Behavior after encountering bad block
To:     Roman Mamedov <rm@romanrm.net>,
        Daniel Smedegaard Buus <danielbuus@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
 <20200619124505.586f2b63@natsu>
 <CAHnuAez0+4LR=Z=+z-bFFj2Z=Jf24YCHZ3CjHGwgsSn8mZU1eA@mail.gmail.com>
 <20200619143148.1ec669e9@natsu>
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
Message-ID: <7aab6236-2767-12bd-e7f7-36c7852eeb4a@georgianit.com>
Date:   Fri, 19 Jun 2020 09:12:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20200619143148.1ec669e9@natsu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wRJIwLCJ3JQfVMdUyKbMJUYOVpBy4c0gu"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wRJIwLCJ3JQfVMdUyKbMJUYOVpBy4c0gu
Content-Type: multipart/mixed; boundary="Xk1sB9JsASVk22agFMpNfugRCLSUxE6lJ";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Roman Mamedov <rm@romanrm.net>,
 Daniel Smedegaard Buus <danielbuus@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <7aab6236-2767-12bd-e7f7-36c7852eeb4a@georgianit.com>
Subject: Re: Behavior after encountering bad block
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
 <20200619124505.586f2b63@natsu>
 <CAHnuAez0+4LR=Z=+z-bFFj2Z=Jf24YCHZ3CjHGwgsSn8mZU1eA@mail.gmail.com>
 <20200619143148.1ec669e9@natsu>
In-Reply-To: <20200619143148.1ec669e9@natsu>

--Xk1sB9JsASVk22agFMpNfugRCLSUxE6lJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-06-19 5:31 a.m., Roman Mamedov wrote:
> On Fri, 19 Jun 2020 10:08:43 +0200
> Daniel Smedegaard Buus <danielbuus@gmail.com> wrote:
>=20
>> Well, that's why I wrote having the *data* go bad, not the drive
>=20
> But data going bad wouldn't pass unnoticed like that (with reads result=
ing in
> bad data), since drives have end-to-end CRC checking, including on-disk=
 and
> through the SATA interface. If data on-disk is somehow corrupted, that =
will be
> a CRC failure on read, and still an I/O error for the host.
>=20

This used to be my assumption as well.  However, since I started using
BTRFS in more places, I have recorded 3 instances of BTRFS detecting
corruption that was completely unnoticed by Drive or system, before
finally hitting an SSD that knew it was hitting an error.

That's a pretty small anecdote in the grand scheme of things, and I'm
sure Zygo can give something that more closely resembles a real
statistic.... But I'm left to admit that silent corruption from drives /
I/O controllers is far more prevalent than I used to think.




--Xk1sB9JsASVk22agFMpNfugRCLSUxE6lJ--

--wRJIwLCJ3JQfVMdUyKbMJUYOVpBy4c0gu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJe7Lm7AAoJEO9Tn/JHRWpt+eIH/RET74wklfCWpjztbZzbxI+o
oVv31QyxUSHiP+HwWXXaVgC1XB9OpTCyA0IdZtiwpcPWCr3G0mAvaDTWgflUYxuy
xaIhBkUEp4Psa9ERoJLIBfNYSNMGLuWjWQU6ZpvPXCitXy1dTPWfwI8TV3jSzjmQ
n/CIlah2N3DFtTjQHSkt2ftzNeV2dRpBFYhixYMaZ7g7qN0yfH+dyZ1VQO0aipuX
o4z0ZPtw48V3H1XDjETGU3zvHPrDz8QRuUV5s39uVgkOQe5hOa41NV7a/Kb3p6nl
aWDzYSkHXfiYrBtnEbwlalHK0xVz2Vm6AvQ0Z5+tZnT8Z4aEx/GlsLMh7yiYaSE=
=9xLY
-----END PGP SIGNATURE-----

--wRJIwLCJ3JQfVMdUyKbMJUYOVpBy4c0gu--
