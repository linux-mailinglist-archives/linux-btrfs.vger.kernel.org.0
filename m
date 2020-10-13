Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D085D28D0F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgJMPEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 11:04:43 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:45590 "EHLO
        6.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMPEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 11:04:42 -0400
X-Greylist: delayed 3608 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 11:04:42 EDT
Received: from player795.ha.ovh.net (unknown [10.108.35.240])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id D82C817B6FD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 15:46:51 +0200 (CEST)
Received: from grubelek.pl (89-77-39-184.dynamic.chello.pl [89.77.39.184])
        (Authenticated sender: szarpaj@grubelek.pl)
        by player795.ha.ovh.net (Postfix) with ESMTPSA id 2B95A16F93A6E;
        Tue, 13 Oct 2020 13:46:49 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004f01e56be-0a30-4757-8a4a-5aae3aab91e0,
                    AA506B1D2CAA152689122792A0433A89576A5AF1) smtp.auth=szarpaj@grubelek.pl
Received: by teh mailsystemz
        id 11F2527C6179; Tue, 13 Oct 2020 15:46:48 +0200 (CEST)
Date:   Tue, 13 Oct 2020 15:46:48 +0200
From:   Piotr Szymaniak <szarpaj@grubelek.pl>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Hendrik Friedel <hendrik@friedels.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Raid5 Write Hole: Is it worse than in MD?
Message-ID: <20201013134648.GG4220@pontus>
References: <em46b9d48d-39d4-44bc-9fd7-a08d9a96fca2@ryzen>
 <SN4PR0401MB3598F3C8CAC47F1BB28801279B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598F3C8CAC47F1BB28801279B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-Ovh-Tracer-Id: 12667218377992836674
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrheelgdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfhiohhtrhcuufiihihmrghnihgrkhcuoehsiigrrhhprghjsehgrhhusggvlhgvkhdrphhlqeenucggtffrrghtthgvrhhnpeejheffvdelkeefhfeuieetfeeugfevgfelgfefiefhtdethfeuvdekleevvdejveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdekledrjeejrdefledrudekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshiirghrphgrjhesghhruhgsvghlvghkrdhplhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 09:43:25AM +0000, Johannes Thumshirn wrote:
> *snip*
> For the other problems of raid56, Zygo once compiled a very comprehensive=
 list,
> but I don't have the link anymore.

This list (both user/dev):
https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/
https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/


Best regards,
Piotr Szymaniak.
--=20
Chyba  musze  juz wracac do sklepu.  Kelly jest w porzadku,  ale czasem
potrafi  zupelnie sie wylaczyc.  I do tego nie wierzy w cos takiego jak
odpowiedzialnosc.  Ma to jakis zwiazek z ta sekta,  do  ktorej  nalezy.
Maharishi Woda-z-mozgu czy cos w tym stylu.
  -- Graham Masterton, "Mirror"

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFSphDYLXjiCg60ZUQykCi/VzD2UFAl+Fr8IACgkQQykCi/Vz
D2Us0w/+NnR30fqmsLF6sDXhK6rXaV+L1FMfV/XI3L8zx5YH1uZXLgpW4mHQyvTP
X+2wOM2s7FI87s3eWGkUQ8Ns5uTBgn64RbkyWWO9rnzzdvxmTPI6RcNEyDELIV6I
GqL9sg5UQojnuVxlpld/T+iCLr/GVNUrzsMZIJ1wsyc6tp7mTWf2opopt2cfIce5
QdpUkb+MF27AZuGLtHS8kMYSm7JGy3zF9Zv8eczENOLq0BntmpmTHZbyax7Cyhnm
qiv/xMM92FOLawOvHNeOJdHnA4tq+DvJCWWoyirafzaus9tma+1EatqE1Ae60Y5s
eQgPeKvpKt7JY1vG/XlWysoYOQExs+Z/Iw60exWSRFwmPSKz5t+9kcohDwjFmyA1
FyvcE1ajjApkQz0c8TEQbqxt6UReZa7zHmqLIiCNtBT/p80qP0/G0CtfwqD2k8jB
jn3Tr4HXE5mE1ANhTjIHVG/DHQUi33bleHb1l+z0x73cXBtVG+UWUQGQsYz9f5A+
SgAz+zz9aW8yt/VuO5htyk2hGcKhDQqPOYJj413ZMXME3ysBC0Hocf97kF5JRriE
ZwxDQndXjJhMOmTxuxwvsuMw1vLQQ1UPAP348z6AEF9uCmT5jifzL+Aao1m/Mn8w
ZmbD15+A3IHgp0mu7WttNpDR5Ksnj6EuVZPT3Q9zTvLZ4LEmzkA=
=9VpT
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
