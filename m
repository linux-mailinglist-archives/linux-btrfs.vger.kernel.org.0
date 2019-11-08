Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB7F503B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 16:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKHPxQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 10:53:16 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55107 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbfKHPxQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 10:53:16 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AE8B218BB;
        Fri,  8 Nov 2019 10:53:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 08 Nov 2019 10:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=q4u2lG9EbiJ1h3sdzCmmpqMCOz6
        JPABUseOzhrq8VII=; b=ZGJsq0Xg5ALJ7FGLFdqekr7fRXRFXZ1ucESHamA9rZ5
        ahsY9ovLpz+Tjl9TTcI/rbKWcF0MuvVlN7GLShJm3DzHOvF9GGH0AjQZ0arhLihR
        D24k5gZZ8H+4nA3Y6G/eHXZRUQQYnKV0Ohu1Zbcj3+mdrvI5klAk4Sl8mVpJbJhu
        jNoJ0XESwfxrzoa9Sit6PglKXNZF0lXzL3fRhUYrjHUP0Mvx0B5QdXQk5bTNZ+ER
        EKdmomZ2t5xa70yMtSdjalQykG0Y9eULiDsvnlcVukBiabrSAlLC+dgGBrhFaLjL
        LYbfeJm3K2Q9eMC4dTz1hDrzw1A/2ZwrF8D8oPDK16w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=q4u2lG
        9EbiJ1h3sdzCmmpqMCOz6JPABUseOzhrq8VII=; b=O4hTpqvNLFS+x4zO5ii7t6
        32fpugLQQk/2DLfWMZep8yTD2qKYqSpfRHGMEuNDXtjGjowSthdLl02t1fISz55E
        LQVve3clBj2DtbLBSCOxrWOj3yvLlwjLXGmnKIfHnGRLC5l+yLQSOgB3qHdNEtIr
        77ctWmBCzfzSyeCUxtcbl8kZyIYMfvWTcbWNJ/0IvA/6BBITy+7tO4oOgadWHgGL
        2kKPO+xki/axZsT4PGp06EJIP9gS8A7AgG8kXSbDWedflwSp/l738JncVStFkaua
        50Ny/YK6tTN2AlHkePpViRrd3kQYUacJVVLFAmxw30GflVQcaAm6UqvZjEj8U08Q
        ==
X-ME-Sender: <xms:ao_FXZgR3bQ03ecv3W_ttQKIzLn1qgxZOr_Iv4i2QywrLR70CbakOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvuddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedufe
    ehrddvfedrvdegiedrudefudenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehg
    vghorhhgihgrnhhithdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ao_FXc40f6uHllM4N-nJyned_su2w_UZLDFONh-m4qxE-mhgEH1KKA>
    <xmx:ao_FXZcb-YWacdYbULeUnUCgsEn8I1ft4BdnxPVDV-Oje5EOaxQoqw>
    <xmx:ao_FXTRyU2bBJte8KRoZibuSrIuu0BQUa9B2ZfCOkjCReUOH6-5cxw>
    <xmx:a4_FXUGMEzK4o9qMP75O09xPMSvOQmeiG4mvYr7aHwruAePbW2B27A>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82CB0306005C;
        Fri,  8 Nov 2019 10:53:14 -0500 (EST)
Subject: Re: Defragmenting to recover wasted space
To:     Nate Eldredge <nate@thatsmathematics.com>
References: <alpine.DEB.2.21.1911070814430.3492@moneta>
 <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com>
 <alpine.DEB.2.21.1911071419570.3492@moneta>
 <c5458fb8-7df9-9e27-4208-fdbb3b4d731f@gmx.com>
 <alpine.DEB.2.21.1911081021520.3492@moneta>
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
Message-ID: <c48fac3d-dcd4-25cd-2fe8-efaee0478f99@georgianit.com>
Date:   Fri, 8 Nov 2019 10:53:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911081021520.3492@moneta>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LsTgW1cJ53xXyuHKnWCcwll2dq3ZvcgHb"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LsTgW1cJ53xXyuHKnWCcwll2dq3ZvcgHb
Content-Type: multipart/mixed; boundary="evLlTdE4DTl3Ju0UzrYgBwWgKrEedeXtb";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Nate Eldredge <nate@thatsmathematics.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <c48fac3d-dcd4-25cd-2fe8-efaee0478f99@georgianit.com>
Subject: Re: Defragmenting to recover wasted space
References: <alpine.DEB.2.21.1911070814430.3492@moneta>
 <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com>
 <alpine.DEB.2.21.1911071419570.3492@moneta>
 <c5458fb8-7df9-9e27-4208-fdbb3b4d731f@gmx.com>
 <alpine.DEB.2.21.1911081021520.3492@moneta>
In-Reply-To: <alpine.DEB.2.21.1911081021520.3492@moneta>

--evLlTdE4DTl3Ju0UzrYgBwWgKrEedeXtb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-11-08 10:24 a.m., Nate Eldredge wrote:
> On Fri, 8 Nov 2019, Qu Wenruo wrote:
>=20
>> In fact, you can just go nodatacow.
>> Furthermore, nodatacow attr can be applied to a directory so that any
>> newer file will just inherit the nodatacow attr.
>>
>> In that case, any overwrite will not be COWed (as long as there is no
>> snapshot for it), thus no space wasted.
>=20
> Aha, I didn't know about that feature.=C2=A0 Thanks, that is exactly wh=
at I
> want.
>=20


I would advise caution with this approach.. with nodatacow you give up
all of the features that would make you want to use BTRFS in the first
place.  (No Checksum verification, for example.)

And if using in conjunction with BTRFS Raid, BTRFS behavior, is,, in
terms of RAID, outright psychotic.  In case of unclean shutdown while
data was being written, the RAID copies will be inconsistent, and BTRFS
will never synchronize them, (short of a full re-balance.).. What data
gets read will just randomnly depend on what device BTRFS is reading from=
=2E

If you would rather forgo the benefits of BTRFS for better performance
or fragmentation issues, why not carve out an XFS / EXT4 partition?




--evLlTdE4DTl3Ju0UzrYgBwWgKrEedeXtb--

--LsTgW1cJ53xXyuHKnWCcwll2dq3ZvcgHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdxY9pAAoJEO9Tn/JHRWptS9cH/0/n92MCASIYyDaC9oAlkAeN
kFvPZy0JIe8t4WPSDDZEPvfRarX7WZyQ7wB8OgvsWRDCMRHfx/eK7kUNuZVWwu5Y
D7FXUXBxooRmE9pVugTsYKZdUZS5zIv4JJxnnhTuFecgnHCaWBKywd02s+oDhzAI
i2XF3+v0ya+ilVeg++L4+7W2OTinw3lByla+Ud48to6HYzA0AS+Oi7hr9RY5cWxi
FVo/7D2y0cxU4CA+m1kKjE82W/guR9ZXDIb0NdPcl8QClcxHl/z9gQtDzeiB45N7
HURU36yF/JJ3pYRvQ+hT0YA5F0rBnR6p3RpfGPnzJwvQp0rKbdj5GSqw6QYcFWo=
=/Hew
-----END PGP SIGNATURE-----

--LsTgW1cJ53xXyuHKnWCcwll2dq3ZvcgHb--
