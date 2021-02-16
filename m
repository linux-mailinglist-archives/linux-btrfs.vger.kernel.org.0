Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE431C770
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 09:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhBPIiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 03:38:22 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:36114 "EHLO
        7.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhBPIgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 03:36:32 -0500
X-Greylist: delayed 6600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 03:36:32 EST
Received: from player791.ha.ovh.net (unknown [10.110.171.40])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8091E24099A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 07:08:07 +0100 (CET)
Received: from grubelek.pl (89-77-39-184.dynamic.chello.pl [89.77.39.184])
        (Authenticated sender: szarpaj@grubelek.pl)
        by player791.ha.ovh.net (Postfix) with ESMTPSA id A7A221B072C25;
        Tue, 16 Feb 2021 06:08:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R0064734fe7f-0c24-4cbf-9221-f475996b2450,
                    F082AAFFF005A10AEB44B6B43B38B0BB729527E7) smtp.auth=szarpaj@grubelek.pl
X-OVh-ClientIp: 89.77.39.184
Received: by teh mailsystemz
        id 9AEDB2E5FD6E; Tue, 16 Feb 2021 07:08:04 +0100 (CET)
Date:   Tue, 16 Feb 2021 07:08:04 +0100
From:   Piotr Szymaniak <szarpaj@grubelek.pl>
To:     "Pal, Laszlo" <vlad@vlad.hu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: performance recommendations
Message-ID: <YCthRFaWcq8FW021@pontus>
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <CAFTxqD8fGcL1j904b=yFPUwYjJi_bz5iVcxkNC5BoLZ8Wm12ZA@mail.gmail.com>
 <B7BDEFC2-2444-4926-8FFC-D78B6CE5CB4E@vlad.hu>
 <CAFTxqD8OtnY3AGV6YCyU_GypTdHjSVmuzLsRi5E_ojs=p+GsFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DpN+9kYqXSqcV60f"
Content-Disposition: inline
In-Reply-To: <CAFTxqD8OtnY3AGV6YCyU_GypTdHjSVmuzLsRi5E_ojs=p+GsFA@mail.gmail.com>
X-Ovh-Tracer-Id: 7009571347332732567
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrieelgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrihhothhrucfuiiihmhgrnhhirghkuceoshiirghrphgrjhesghhruhgsvghlvghkrdhplheqnecuggftrfgrthhtvghrnhepjeehffdvleekfefhueeiteefuefgvefglefgfeeihfdttefhuedvkeelvedvjeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkeelrdejjedrfeelrddukeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsiigrrhhprghjsehgrhhusggvlhgvkhdrphhlpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--DpN+9kYqXSqcV60f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2021 at 10:50:15PM +0100, Pal, Laszlo wrote:
> So,

You should start here:
https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list#What_information=
_to_provide_when_asking_a_support_question

Best regards,
Piotr Szymaniak.
--=20
  - Chyba nie jest pan jednym z tych roniacych lzy liberalow?
  - Odmawiam odpowiedzi, poniewaz moglaby zostac wykorzystana przeciwko
mnie - odparlem. Taksiarz wydal prychniecie oznaczajace dlaczego-ja-
zawsze-trafiam-na-takich-cwaniakow... ale zamknal sie.
  -- Stephen King, "The Breathing Method"

--DpN+9kYqXSqcV60f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFSphDYLXjiCg60ZUQykCi/VzD2UFAmArYSUACgkQQykCi/Vz
D2XcHBAAr5X278tavkmky/CYWoNHmBsxnBHTOuuRjJUuM3NXJSU+/J/ZhNL+Tyl5
WQhBaC507gN4Osaf/IKOe/0gpi+2Fu2WfIe2+nsncbLzK47K/1e/Rfl1TGlFCIpY
uUMCKtIxe/FVeaBSqadZGP2vecZdQ3XVcASeCu4yRE2fJNdZ3NfmS/p1RywslyzR
FXjGwZUYJGhzhU3hTwT35OZ2dtaa1EhxidvTdIrPiMONWnjIW0RgadSSHXW0idrP
WvCZNbwRzc8p6Q80G92IEarJ3cUspeYrRpOKsCedkEnqSlfEqO1r2i8kVRjOOK6x
5GwUhA1OVIgGGHyUzjaOda1rgBJjZECPhr8aPrihlbKhZH6PPo6Un1a3Gy3BzOLz
PFJ1Lp+8jkV29x0wzz14lGM2vTfgF3wXrkXL/yHz3/e+V8Eu/LMvVfwdXa+0l8At
A1EBg66rOwr8ds7C/QapJuHHHm287+0MRprXYgHHqqA8Jib7XUaf7e9Qprrhdn1w
LjF6WL5plLWyiqO3KOEPhCyL9ukEC9Qz6Ar3un0EzHO7Hro4yBNazOjLQiIhAvfa
0Af5jX8YrO3o/LLnzAfu6f5AbMf/yGVn3ZhOzgsnAX1+eM3BJhUIifnNlY2yPFmV
KA/Z4W8hTwoWLldW0sxlWZOwXgBnOaF0LVWzeNyuF3mffwG3rhk=
=3Irq
-----END PGP SIGNATURE-----

--DpN+9kYqXSqcV60f--
