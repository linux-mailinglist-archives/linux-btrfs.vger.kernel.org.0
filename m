Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E913F2C69F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1MgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 08:36:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:33989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbfE1MgO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 08:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559046970;
        bh=9rmuG2QsjgXvQyZjnjyMy56CqHX7kRPfwhCGlFU9h7U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GodsD/kYIbCAortl7dBr5xaeLFL62GtkDAS++YeHYof1HUfXTWFMNkdxCChZL8YJp
         gb5x7G8f9vtFlLRgju3JtxOuOm3wI6O34YeCADpcMFtTK50htV8j8uZLsekI+x3/CQ
         GupDEoAYAO/M62Nxf/jXoEl0h9o4ZDH+ZhJyvrBo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from monk.localnet ([129.206.205.141]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyEJp-1gZDsV1Tld-015dzQ; Tue, 28
 May 2019 14:36:10 +0200
From:   Dennis Schridde <devurandom@gmx.net>
To:     Szalma =?ISO-8859-1?Q?L=E1szl=F3?= <dblaci@dblaci.hu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: parent transid verify failed on 604602368 wanted 840641 found 840639
Date:   Tue, 28 May 2019 14:36:05 +0200
Message-ID: <5695711.43npD3TUoY@monk>
In-Reply-To: <2a6df734-4c39-2f8a-7d8f-c627c2c15f76@dblaci.hu>
References: <5406386.pfifcJONdE@monk> <2a6df734-4c39-2f8a-7d8f-c627c2c15f76@dblaci.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11385663.Mnys9a88yD"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:LyMB3ML+jP3floypAiYzZIFeaEZNQYVAQiFzZJfBJA+7tPvKIiN
 pGua4EO4jOtimbMgCiVMPK7PYsA69A+LZ7QUEZjF8n6SjKoop5OsvWx8PlmdXD/0RQAhUB8
 XsMq5x+qt1dL7DnYrv+Ej3uFK6F9DqlGQmUouqZyWP39QY+shi2fSIvuThIMfku75M9IjFb
 q/NLT8ZnjwpI1lv1oTqUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W6NfktXGAEM=:jZvsaa3n9KqgQE+nMghgEG
 RaGU4a9hdhAJzIavkI8bQ+TqfAo7i56lCncIsRXaSTwFoueHoSKSr+83UjWpWaILpnbC8P1Oc
 Qs0VHBc9VSZzZ9+kyRgZt8hJnS+rXDPrXL/1zP/be4T1sv7D56v0N53xmE9spXAi3akYrcllj
 48UxUztiqehOdALZzNUJnLGWSlwA8rsBViTeSWeHN8mEjXyZUFKfyEvfwHRxDP2blBLzPJQ7x
 xiv4KZZr5kxktX2GccSY5xpHyem5U0Md3tJvXJ6LVFDOnEnsAVJYMLzrm7RiFNg6pbTkMRJqy
 CTiuZme54TDmLjZ3O8cZ8+bgyw3gxgGTnoUHUmf+3oytzbZ4C5TUw3jiknha/X3Tho0LjfCxu
 sgDNSRislT7VM24Yf2CY/MjTuF5YQrnCtuIQUfnoSQC+yc0+kcj7B7oUgdEl916loQB9KE61H
 OIJkEDOfmZZNSSfN0BKGUgEkgIDEmY/6QQn5bvJ8oRwuiPDNudpiiu1XClZFIU7gpQgJJe6kr
 bQkyCD46EVW/LaBCjYggVfyO60lv0lCx0Is5q8RNOFspGhS2Xdkt+6LcDUmjV2Eln8249nvTA
 V2vQ0B0Jjz4rbaaTrlyicqea/3sQzsoRHme27S9Lkg//YQw6GUB/5ld3T4hLgE5h2ihQTWGfX
 +DxQLDUo2r0K1GXB1qjP2rwYWabY2aFkBRuOX4AVHNTPa3zz+3HAMN7c0xDhabKcRX9ARC9tq
 H3Od4LSqwDBQBhJCPvuHoPG1i6NB5yX+oTq3Zld4KpfqDnDHDo0jlAxxndXuqfy+32KDaKCym
 vy5ER3mRgi/Y3vapFvzbnN3qLZlVJtQ5qSVoTX42XwDKjMd5pwC5z4mfOUd/zguMSez11Wcm5
 kVPdqFoxcrRs6FHBQAtbsISC0lKUzc81vYi+RgqNa6yPmFcAiYUldctuyZye+6Br6zp12g7Xa
 wX92vASc0NnkGb1JTIje4xrQsNB5yYwc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart11385663.Mnys9a88yD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dear Szalma!

Thank you for the information.

On Dienstag, 28. Mai 2019 08:40:40 CEST Szalma L=E1szl=F3 wrote:
> I experienced the same, the problem is with bcache + gcc9. Immediately
> remove the cache device from the bcache, as it prevents more damages to
> your filesystem. After it downgrade gcc to 8 or avoid using bcache (with
> cache device) until the problem is solved by upstream.
>
> Please see here for more information:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203573
>=20
> This is a very serious issue I think, but in my case I could save all my
> files after reboot without bcache cache device (except 1 insignificant
> one), but I guess you might need backups (I hope you have).

I did the following so far:

readlink /sys/fs/bcache/*/cache0/set | sed 's,.*/,,' > /sys/block/bcache0/
bcache/detach

How should I proceed from here on the path that you took to recover your=20
system?

=2D-Dennis
--nextPart11385663.Mnys9a88yD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEE0Ngi/nirHnbsz3NFz+h/M161qdwFAlztKzUACgkQz+h/M161
qdy4egwAtTzctCWEyuBETRyQdqWowWwsV1K03NjrQVVvrD2Cju9yT4ntQkUUzw6y
OisSOwuJZCs00vjgo8W4Vu2peF12oIISthzw77CQdd+C7XPFN3CV13U2LfyX/VOj
UNVuNqJGNErC3jtkyeInRh6vkxQ3ja98PQWtSCVWX0V06Gom/NDblhEvw7phY2EG
A7ptKC0dG8RPJdv7/o4G5GjENx7Zgod+Kj29v6vvCzAUBsqP8sisTK4o/Ix3b5OX
O+K883XAipH5TvNXUDAoThCenPYmHKLrJgcxDQoOc30qzC17la3vEQAH2i9n8oAy
txvcslvRiICoO2NpH6l/BMJAMsCiWOslcXSqowXtniP2mD3yN/NjSiggN8ixvvyR
h4SdoEVEQCi0VBTSLSWncf+t/Bfd53HskDBA6gaDYtc6dkXRJ5ONp43hewZ4HxOx
zZzZrNrSwiCQDsQiwkgV7Yi508eoxuIeO3d9ckVbCaUZbjjlOqGYsqneB5qFz7A+
SV8Mzh3k
=hNgr
-----END PGP SIGNATURE-----

--nextPart11385663.Mnys9a88yD--



