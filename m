Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF74FD5A16
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 06:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfJNEBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 00:01:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37838 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfJNEBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 00:01:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id n17so4186831qtr.4
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Oct 2019 21:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4+6N5xl3c26X3tG3/XihpgAiBgawgpoFTmF58kEGHZU=;
        b=cPv1kyHqX710D61oAth1f39mdwOHRjmO7LEXE/Rd5oUH+e3GTbU6UFUWs/C5UyQycK
         9Hfk+jUo8F5e2ws7pn8iXCu4YlBwXtRwo8KbSUVecTQfurcGGDj4l+whxVZpQgxJuRIz
         SecDcToiWUqPoH/lu5aJRcu+P5WY/Apmz16vYSEYJjsizyWJd38JSVqzH78GJ06yKep9
         JNhHwbnTsG8odgaYS2c/BZLvltNvTxO6FRY8m/Cr9UPMFELT8+aet8Kr6MGVll54abVZ
         0spTEMBrjp1PvUDBhW09P0sjvzj08Wwwd8YFxICgJB+gd11UTxcR1nerWlWGPt6PK6Ey
         xXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4+6N5xl3c26X3tG3/XihpgAiBgawgpoFTmF58kEGHZU=;
        b=cX0alIUkWbQ1i5TyFKFkdLd+DYJKc8dN6ArXKWxWd7G8cW0JRvy9nJeu4ecVwQfEBL
         E4TP6c8zxnUqyucC3dv/5FJce+x/1OVqkVZJ6g5Q/gZw+NS/19TZ3/vov2hmkIudgp/+
         Pufdd8AB50Om72KkkJ91/xA1AII0RjYJ65yvdNwopy5+nGfxQHBzBuJJ932VjH5XhT0q
         GX+8BuQJxDT8f9vjOZheSXnXspYgtAy6OezoBJwgu+Hy3GMfM5BfJPOOb+lvE+cuY3dT
         v1JT6Wq+x3L6NQRLlnLF99Y2ytF/8JIhbTAXl8T4DbAHMLAVcA2BHNa03h3Jjt/y96ps
         zAJA==
X-Gm-Message-State: APjAAAW3ixICIgICTIhwpMF8zgfhJmpCR5X7I3z6mutRZOC+tX9OvGxJ
        IFx7HZBjIF59Sa1RmdC5jPW7pxZP
X-Google-Smtp-Source: APXvYqwSELI4DCPHcMmszzJhiHFSNqwtpXlMzTqkEoKWePpNeVmHKL65cxgnE6IFRXMyEtgvl/yVyQ==
X-Received: by 2002:a0c:91a2:: with SMTP id n31mr29555450qvn.182.1571025662305;
        Sun, 13 Oct 2019 21:01:02 -0700 (PDT)
Received: from DigitalMercury.dynalias.net (mtrlpq0313w-lp130-01-70-50-9-180.dsl.bell.ca. [70.50.9.180])
        by smtp.gmail.com with ESMTPSA id d134sm7476764qkg.133.2019.10.13.21.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 21:01:01 -0700 (PDT)
Received: by DigitalMercury.dynalias.net (Postfix, from userid 1000)
        id CFA6619D4BC; Mon, 14 Oct 2019 00:01:00 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        =?utf-8?Q?Sw=C3=A2mi?= Petaramesh <swami@petaramesh.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
In-Reply-To: <ee4e5ad0e0d4563c829113a84985b48448833fb4.camel@scientia.net>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net> <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com> <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com> <5480ef51-6b55-4f30-fe3d-005c7883c630@petaramesh.org> <ee4e5ad0e0d4563c829113a84985b48448833fb4.camel@scientia.net>
Date:   Mon, 14 Oct 2019 00:00:57 -0400
Message-ID: <87imosx9fq.fsf@DigitalMercury.dynalias.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christoph and Sw=C3=A2mi,

Christoph Anton Mitterer <calestyo@scientia.net> writes:

> On Thu, 2019-09-12 at 12:53 +0200, Sw=C3=A2mi Petaramesh wrote:
>> Yep, I assume that a big flashing red neon sign should be raised for
>> a=20
>> confirmed bug that can trash your filesystem into ashes, and
>> actually=20
>> did so for two of mine...
>
> I doubt this will happen... I've asked for something like this to be
> set up on the last corruption bugs but there seems to be little
> interest for a warning system for users.

I used to track such bugs on the Debian wiki page for Btrfs...but users
of Debian and derivatives continued to track
sid/testing/stable-backports kernel, which made me feel like that work
was a waste of time.  Now that page has a warning that reads something
along the lines of "sid/testing/backports kernels periodically have
grave dataloss bugs.  Please track the most recent upstream LTS kernel
if a kernel newer than 4.19.x is required.  That said, upstream
appreciates bug reports using the most recent kernel available to you".

If you'd like to maintain a section at the top of that page that tracks
this type of issue, please go ahead.  I'd rather work on getting boot
environments working properly, then making them easy to use, then
enabling staged upgrades in a rw snapshot before rotating that snapshot
onto the rootfs.

P.S. Do you want to co-found a BTRFS integration team in Debian?  We're
still quite a ways behind SUSE, and even Fedora is ahead of us now!

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4qYmHjkArtfNxmcIWogwR199EGEFAl2j8vkACgkQWogwR199
EGGP/g/9EuGl2nC9EVbYEf+UfcAHTAvzrY+mKue0iRY++nCmq0biQt8seTekjne6
/FdX+qVACe88ieKO1ILgyCbVTQfeq7M0sg0nOl8kC9kKpJfR+NzIgsYtO6c2VgDf
MnZJ6aKGt/Pzy/S75anyjqZkhUwgEmyDjEnDYcG52Tpzd6ait+5zfJyzR3I7kVX2
kgr0u6ODqDGR9wMm8QUVL2+piSvBJ5ppOv9FulH8EHM7A7CAHDy7L4F3+uOI+QTO
oowXHC5Jzjojh/u8lwfCQhfKD56RDSpWhAycyKv//xihnM+E5istW9qvzMw0/19F
7mvvseUlTZAIH7oyws8gSw2sJb9dJ//yHdfsFWbhnqvrf6zxmhjXlCy46nbMimdd
xJsLWuuulBiKoEhiAeO72DbqpQPpKnktutD/QDYXyzqVcaxIeS06STd5gLc+wXn8
75TjqY1v32RVI762v1zDYIWGV0Au2uM6+rzEsg1BsrjZigzUIWU85/KL7l7jJl/d
VJFYTXaY8v54wIuDLpoXhkjyHvOHjgaiQXrqrzfO0ICr1bnMzwIGtvVwd1APnBJ8
jTEcIPx4G4J8+KX3jYgMJBbP9OuqQLn7Pe0gPXeX8nZdGQ6kDBuGr628/W8f8nQy
1P6Q5eqdfswNeRcrFcIh1LlurZE8/c5JeIvVAAlaJFtvU5+QP00=
=c1A0
-----END PGP SIGNATURE-----
--=-=-=--
