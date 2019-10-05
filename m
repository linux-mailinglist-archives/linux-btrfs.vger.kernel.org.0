Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0ECCB97
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2019 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfJEROR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 13:14:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37087 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727466AbfJEROR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Oct 2019 13:14:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B53421C0F;
        Sat,  5 Oct 2019 13:14:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 05 Oct 2019 13:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=Uj7KyYM7E1bB5+vfZiC+nKdRBCJ
        0+L53leuHPS60cOo=; b=VV5mG10A91PKeP/Ji1e3QwOJZ9SSDge7pvu586n8wmL
        OIsPl+HiqVlxJkuCI1ypSmumny06yl6magoWxcp4KlazGcyALeXpxHW/uSsEJLZH
        vVjTApIsL/KuJQ/8ZanfOxccOC+pRgQrQCE/ew8gZgVyJxZJqR+rRuOuDRqtttIC
        f7aS/iyDC+B0U3H3ksZw9eyYhGsVNvEUUJ9MSr7YCv4quh87qHNFZO/bJI2LHzG4
        Sq57Ue1FFFMS/THDQXOh6f6VXRSugotI6gIAxrRiNo7uewrX+AeOcVByEaP0e0Rq
        Bo02I6wP4bMjB9Y7rkQBIUfm3ZhwP9V/ul2YMNV9oLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Uj7KyY
        M7E1bB5+vfZiC+nKdRBCJ0+L53leuHPS60cOo=; b=EOZfINNW4l56TfBvJpeneu
        FpJ53yxFjCisRxGzMc9l8Z4B88ZIPNWZKRDkkHOLqg5NEqQoISdMVEHFhuYMlkMH
        JON3R7S28nF1zQiM83eH04U+rF8+IQnghhzpOa4WeAyq7ORTkwxXK8PoUOtIwtz4
        J0ngXDHM4tE+Xz4bzj0NKa71IX5/WwDkAXbpjKqR+oMohYXaXlPNqqyON2tIrZof
        8NKlq0DozZR9NmhLG+9agznLyrW11S6xYO2CjThD9oBhb85XSDx11++A+VFU87F1
        kOdI4EmXCEBYBjcyZaNdrWQnjlXIzLJvCms78I3+LI6VJvtbsqoIWLAxSLDzhDog
        ==
X-ME-Sender: <xms:Z8-YXUMu30O7QcW5rGLCnr_TKjgrAvdQqHUbDriGdr5BEZ6akAPwpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgesghdtre
    fotdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucfkphepudefhedrvdefrddvgeeirddufedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Z8-YXdUKzQyFxTdsuVn8oqusD6q9tPP0HH7VIML-etjsKNvdTjiMlQ>
    <xmx:Z8-YXUj891Zy_23I6AcYBbuo_8O_7vB_c8WkM5zuSsYhf64Pfjn7Qg>
    <xmx:Z8-YXf3FX2KlQDT9rFL_lZtYjmQ43Th2LBKM-WT9nQ8xfQvoyUE1Ag>
    <xmx:aM-YXczm1mV5G2-Acq8L5U6Mgl9rFGMaspV4qp4eDpvTbHQ7w1gzzA>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8757BD60065;
        Sat,  5 Oct 2019 13:14:15 -0400 (EDT)
Subject: Re: BTRFS corruption, mounts but comes read-only
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
 <44df5407-b7c9-bbd1-eae0-d5ebf6ad75d8@georgianit.com>
 <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>
 <fe22fa62-7b13-f417-1af8-3ed12bf082f8@georgianit.com>
 <8d765abc-b9f6-066f-8327-bcfc9a156177@gmx.com>
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
Message-ID: <e546074f-4292-32c5-fe6b-170ace2f63f7@georgianit.com>
Date:   Sat, 5 Oct 2019 13:14:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8d765abc-b9f6-066f-8327-bcfc9a156177@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="od9itbxcVFHQuRCCojmZU14MjraBJHlwm"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--od9itbxcVFHQuRCCojmZU14MjraBJHlwm
Content-Type: multipart/mixed; boundary="6IkACV4deixxkzZfjCsFT76W65mLrWRFD";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <e546074f-4292-32c5-fe6b-170ace2f63f7@georgianit.com>
Subject: Re: BTRFS corruption, mounts but comes read-only
References: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
 <44df5407-b7c9-bbd1-eae0-d5ebf6ad75d8@georgianit.com>
 <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>
 <fe22fa62-7b13-f417-1af8-3ed12bf082f8@georgianit.com>
 <8d765abc-b9f6-066f-8327-bcfc9a156177@gmx.com>
In-Reply-To: <8d765abc-b9f6-066f-8327-bcfc9a156177@gmx.com>

--6IkACV4deixxkzZfjCsFT76W65mLrWRFD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-30 9:53 p.m., Qu Wenruo wrote:

>=20
> It's indeed a symptom of btrfs kernel module bug. But at least looks
> repairable.
>=20

As advertised, btrfs --check repair restored the FS to full function.

A follow-up scrub even found and corrected some corrupt data on one of
the disks, that went  completely unreported by the disk itself.  So,
despite this hiccup, BTRFS did it's job admirably.


Whenever I do any further btrfs check after cleanly unmounting the
filesystem, I get this error:

cache and super generation don't match, space cache will be invalidated

Even mounting with clear_cache,nospace_cache , (then mounting again with
space_cache=3Dv2) does not remove this warning.  But it doesn't seem to b=
e
causing any problems.. There are no warnings about the space cache in
the dmesg log when the filesystem is mounted.


--6IkACV4deixxkzZfjCsFT76W65mLrWRFD--

--od9itbxcVFHQuRCCojmZU14MjraBJHlwm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdmM9nAAoJEO9Tn/JHRWptmJAIAMv2sQLdxeKeIGt+h4p4sdIc
YSh4hECLffj+kL9MvPeBRyGeyZbmqTcOr1s17XX4tV8TOR+7nuPsrRJNfgL9UiHK
DnyAmnugnDKCGDipWtQEf0ourXCwYRCZj7P3s1WO5Yh5cwNd46sWVpACfVMhsHlb
2kC9LTk0UYY9veup9mUYsozh25OSWss9Iw0B+W2uKuOEz4yEQpp3K8GO/P56oQhP
XkgWkDLU7yZjcO/R/IHPfTZYRxsfeNs+JOTaGUaSFHgG4HXomMsqkJkGHHznCDOH
N5f80SB7WKtLGgBAxR4tHxYLcnE1MfDd+XdbToN7sC62KfhzRozP+lM1WR5k7Tc=
=sWNp
-----END PGP SIGNATURE-----

--od9itbxcVFHQuRCCojmZU14MjraBJHlwm--
