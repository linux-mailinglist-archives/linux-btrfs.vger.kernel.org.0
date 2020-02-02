Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5614FB38
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 03:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBBCTg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 21:19:36 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38779 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbgBBCTf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Feb 2020 21:19:35 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 76AC8216DB;
        Sat,  1 Feb 2020 21:19:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 01 Feb 2020 21:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm2; bh=B4KFhWHkW8/xtFkG2HsgwiV0VWA
        3vu7rwPzAc69np+I=; b=Gs+weshrLT4MvkKSTA41pb/BzbGwlnu3/3y8SOy1P/o
        /fpL0C50byCT+UnbR27CnbHN1nXPcOnhvV+1nSCSmNww/Vrp55N4sjmbUqJ9mGKl
        YtBMZUScdUED94UlJdN9oIPZG6ol9GnvWiO8PKvFI3c8+1tEVoigSS2n8c7kWPjh
        pFKPQQBSrm3yRs+/OuNkNuAGjeMbV3zpk9t4xSATEXun7vMRf1OvLaPYp9utcbpn
        hvYdZMfwu9mGNKL9syvcmXucOlPAOb+PxbTPuOyCYCZHKZhQfnMslZCGo4F6vZs2
        FiO/8wk4099QMsJ6U2inD0+caUyD5WXFd8dBOBMeMZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=B4KFhW
        HkW8/xtFkG2HsgwiV0VWA3vu7rwPzAc69np+I=; b=PPpB4bACc/aRN0Lc1BPbDk
        GIQDMjzkc50vXdkNLlBoD1036qC8yO4xaRB2i8oFgRuT48OZU5Pk92u2lX59SBnz
        yAoqdGo5mSwJRoBEAbh6rJgU2JzHybcGbFpHov1hIzKjGgC/fDIN3Vs+tN3Oi3mB
        FugIVBMzPhKleSuem4LBt2S7/CvYISsegK3Mm+83gi82iHhigyGrO5cTu7YTTk83
        4Cnug+JIVaTEWHmwGw5X2J0i5OIkX+7hSbXwkjGD47pk9KD+yy6y/roQqi+jr4cm
        ZkL5X6Mzh71+8OuYyTxADqmuzU7YCD6fB20dViv6g5ZRoNmaB0Bx3XghoM1gL9uw
        ==
X-ME-Sender: <xms:tjE2XtBLPofknOrUTP6OX5eIAt1lJlqVZlbjtKvVWM_OoLVHwez76A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgesghdtrefotdefjeenucfhrhhomheptfgvmhhiucfi
    rghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucfkphepvdefrd
    dvfeefrddutddvrdefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:tjE2XhRwrwRlsPheUeO66IG3oBtGMU3exLcCYM7TWyvJ54FyGEcAng>
    <xmx:tjE2Xmr_1yOebbcfXPMdKZNibDC4vI2jWfTvTvqw8pHlgzroqOH-8A>
    <xmx:tjE2XiXjPL2c0R65AEhYN6_fLzUfOzIiZ8FfIj68fUiBSRkLB-2mrg>
    <xmx:tjE2XrDumT4am7AomxxoV34emau7muarje6OzTMVXwlHerXyd5Y3rQ>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0548328005A;
        Sat,  1 Feb 2020 21:19:33 -0500 (EST)
Subject: Re: support for RAID10 installation
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>, linux-btrfs@vger.kernel.org
References: <CAOLfK3Vs-5CJxPuC2zFyQ4tw0BZkHx-ggE=tLcmriELx-Qe8og@mail.gmail.com>
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
Message-ID: <3bb0df85-99e1-1e4a-ca0c-3d2bf6d5aded@georgianit.com>
Date:   Sat, 1 Feb 2020 21:19:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOLfK3Vs-5CJxPuC2zFyQ4tw0BZkHx-ggE=tLcmriELx-Qe8og@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8uyybARxGnQOBiSUj1ZgzMAbHVatdOSqz"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8uyybARxGnQOBiSUj1ZgzMAbHVatdOSqz
Content-Type: multipart/mixed; boundary="MjuhSKEWUP4b6jp7sVfXIZeUKMVA6mkbz";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Matt Zagrabelny <mzagrabe@d.umn.edu>, linux-btrfs@vger.kernel.org
Message-ID: <3bb0df85-99e1-1e4a-ca0c-3d2bf6d5aded@georgianit.com>
Subject: Re: support for RAID10 installation
References: <CAOLfK3Vs-5CJxPuC2zFyQ4tw0BZkHx-ggE=tLcmriELx-Qe8og@mail.gmail.com>
In-Reply-To: <CAOLfK3Vs-5CJxPuC2zFyQ4tw0BZkHx-ggE=tLcmriELx-Qe8og@mail.gmail.com>

--MjuhSKEWUP4b6jp7sVfXIZeUKMVA6mkbz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-02-01 4:17 p.m., Matt Zagrabelny wrote:

>=20
> I've also tried resizing the disks smaller and then larger - I found a
> (perhaps misleading) post on an online forum suggesting such things to
> retrieve space.
>=20
> I have no idea how to proceed to fix things.
>=20

As Qu said, a known bug.  However, this mostly just affects the display
of df.. if you use the btrfs filesystem usage command, you'll see the
the true free space.

Sometimes, there are processes which check free space before trying to
write data, and those will fail if you trigger this condition.  Zygo
posted  great script to this list a few days ago that will get you past
this by force allocating metadata space on the filesystem.

His script looks like this:

btrfs sub create sub_tmp
mkdir sub_tmp/single
head -c 2047 /dev/urandom > sub_tmp/single/inline_file
for x in $(seq 1 18); do
    cp -a sub_tmp/single sub_tmp/double
    mv sub_tmp/double sub_tmp/single/$x
done
sync
btrfs sub del sub_tmp


Note, Until this is properly patched, do not balance metadata.  doing so
will actually bring you to this problem, rather than fixing it.



--MjuhSKEWUP4b6jp7sVfXIZeUKMVA6mkbz--

--8uyybARxGnQOBiSUj1ZgzMAbHVatdOSqz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJeNjG1AAoJEO9Tn/JHRWpt6FwIAO3Iu6cXPFJRv1V7RHn1k6Md
VmhpDti6pYlXaK4nwoFWIw0xlMb9ZIO7d1utCbLvCziQFM852DmYuFMDnRGAKEr2
DU1xm3nSqcCeQRjFNiTtUI+PqDYeNcf779g0gQb97VYRpIolgNa7IWm5Gpwrmexh
8xm64yIyvN5+limuc/uE47h1XLwUoKQuQkq8tqL2nIaG9LfBeursEcrzDnjWVIua
XjP2CC/48p9PkscG7xopmX7fdoRLgtUzZc5f39VGfAJh44nAqo35HBNieDxG71jZ
QINm2wMtroH25qcxuDGe7fbUbMOQj7x/4q/2dD0502Jdl7l1oRgaWVMOyOS6M3o=
=Wey3
-----END PGP SIGNATURE-----

--8uyybARxGnQOBiSUj1ZgzMAbHVatdOSqz--
