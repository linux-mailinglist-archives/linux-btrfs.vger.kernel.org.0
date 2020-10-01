Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3827FB70
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgJAIYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 04:24:42 -0400
Received: from ns13.heimat.it ([46.4.214.66]:47930 "EHLO ns13.heimat.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAIYl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 04:24:41 -0400
Received: from localhost (ip6-localhost [127.0.0.1])
        by ns13.heimat.it (Postfix) with ESMTP id 7D5293021B8;
        Thu,  1 Oct 2020 08:24:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at ns13.heimat.it
Received: from ns13.heimat.it ([127.0.0.1])
        by localhost (ns13.heimat.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NaD9V067-a6f; Thu,  1 Oct 2020 08:24:20 +0000 (UTC)
Received: from bourrache.mug.xelera.it (unknown [93.56.169.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by ns13.heimat.it (Postfix) with ESMTPSA id 041533021B5;
        Thu,  1 Oct 2020 08:24:20 +0000 (UTC)
Received: from roquette.mug.biscuolo.net (roquette [10.38.2.14])
        by bourrache.mug.xelera.it (Postfix) with SMTP id 06C1E76ECCA;
        Thu,  1 Oct 2020 10:24:18 +0200 (CEST)
Received: (nullmailer pid 27380 invoked by uid 1000);
        Thu, 01 Oct 2020 08:24:17 -0000
From:   Giovanni Biscuolo <g@xelera.eu>
To:     A L <mail@lechevalier.se>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: how to recover from "enospc errors during balance"
In-Reply-To: <9063a16.9d7d1dfc.174da67af85@lechevalier.se>
Organization: Xelera.eu
References: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
 <9063a16.9d7d1dfc.174da67af85@lechevalier.se>
Date:   Thu, 01 Oct 2020 10:24:17 +0200
Message-ID: <87blhm1hhq.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

A L <mail@lechevalier.se> writes:

> ---- From: Giovanni Biscuolo <g@xelera.eu> -- Sent: 2020-09-29 - 16:25 --=
--

[...]

>> Thank you for any useful hint!
>> Best regards, Giovanni

[...]

> Hi,
>
> I think you need to mount with -o skip_balance to get it back into rw
> mode.
>
> Then you may need to add two new disks, because raid1 profile
> allocates two chunks (1GiB each) on two disks. At the moment you don't
> have space for any additional data or metadata chunks.
>
> You can also as for help on irc channel #btrfs on Freenode.
>
> Good luck!=20

Thanky you very much for your advice, I'm going to try what Zygo Blaxell
suggested me yesterday in this thread.

Happy hacking! Giovanni.

=2D-=20
Giovanni Biscuolo

Xelera IT Infrastructures

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCgAqFiEERcxjuFJYydVfNLI5030Op87MORIFAl91kjEMHGdAeGVsZXJh
LmV1AAoJENN9DqfOzDkSB1EQAK6wJtdYr+SZpNZU2rnLbXtL0BQ/Tcy3hSgubT6R
KbuYHiDnyp8oMoD8AY6Q/Hw0h09wwTvGu2sy2eUxJbgfdsfPSe1n93qs12qHA785
oejmaceDbQS1tN+aMcg2Fw3QcRHIzsTXTi1T5kGQx+w6BnAElSSCNc2YFtbrCHlq
axuvU41XIA98kBt6+0tBxcvucrVhtn0r0g/hq7RZpEc1OkMq7X8fcERofeWABG/W
In+2UELLgpv32bxQ06ZT67WbGl1PhtnhipZdFn3Wl8zhIpy9jZnSAwN7/y/JZnVC
6uQsgcOm0RVwNqg3ZiWwPujp2ToV6uALR8Y1c4BubzGauvSACZHh9rAstePzJQ6F
S1n7Cw6SXckdyktn5qY1A7Q1MBbrd4f2t3eXszu72qTGhr23v9cQmDFCjKAVKKXZ
ZowEKgb0YbnqfXfiiByH+Y0yjVoX3NdO25Nds/RF9Hplp25F5VpO16GXsAOfZfDU
9WQqX5/u8jeiq+ahs4aftM9Abye0mY1yXgrUbrjdIUOAQgCo/qbJBLC7aP4ly5Bp
pgtD0r8Q+bEAWznfp1sXajv8aWsy6AO9IAuappUCY6rof7Ry6W3KiwS7DAWOqLMF
RlJmRrs56RNen9Z2H9ziRCB53LWXA58UPyD9/Q6yPbepeRcW0PtC2SFMe49nQbkh
glAf
=JcY+
-----END PGP SIGNATURE-----
--=-=-=--
