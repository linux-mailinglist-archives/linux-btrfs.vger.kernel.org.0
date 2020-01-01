Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB23412DC61
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2020 01:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgAAANl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 19:13:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:49269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgAAANl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 19:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577837619;
        bh=uMRR2a/oiGGx6E+8YApqph83AzCtl0FKIGskxled5Sw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hK81txlbpALOj2W/aqPWWhqD69RBgoBBmWRM3SZi2a8+JkHVZtYhd1VjPOKYWeFGJ
         WViTEWQzuIreB7o04opeXok55vGYZJd6ldy/W7U6Zwl7lAo0Na0webaaX5L9fmy8Sp
         ylSUT0D1j05PR+yUTNwCNjTe4dHgDo04Zp5hoNOc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s51-1imicn0rsV-001xOz; Wed, 01
 Jan 2020 01:13:38 +0100
Subject: Re: repeated enospc errors during balance on a filesystem with spare
 room - pls advise
To:     Ole Langbehn <neurolabs.de@gmail.com>, linux-btrfs@vger.kernel.org
References: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9689db15-bf00-2a9d-d5d4-7e0a47f7cd1f@gmx.com>
Date:   Wed, 1 Jan 2020 08:13:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ecXxbINy8N66OhILJatLDOZPAYXrP87lx"
X-Provags-ID: V03:K1:N5GE6mhwQhcsvKbVttJE3+rRCjuLDo7pNMelHyf3nU3msqkTzmM
 x8oMQFNOuMjpx1eSZEyMc/ENYCDsgiTyakfWdCViLi/ZZcGTfUE62DMsCnry4fWiJiQEKxd
 a5xtRJFeNyzLSxkIu+vwGISftPZU7VqFsHWO6Fd9JYVBHYPAoIb4+Dr+pEEWPvdSa8BjgsT
 97Uy8amSpQjZONuEIwaQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:36Q9w76Qma0=:ygSNeRP4+riFCucB5g4qSB
 3hWbREtvEQcP/rUlc6rX7QR6rSox/a2THLF033aesTwtAU/i52Qz1R6qgJpj6M4PaPCb6z4dx
 QASK7kWJfUSSAh1AGXrifAjUN5SoPxQaCh64MSdlgdrBotB+6khl5ftnnTsGEW1IRNiIa8LTi
 Nmtl97g2n9x2pAaDYegMhPan4V1x5i8kffzO/nXfae6qEsl+/dN7Gtnjxoh9Zxd91r0q5nipK
 XrCerGK5KkfbmYKxX1q6n+W1rIrIdnhe4OwFNmUOFLyjhGNZKUBqrKbCy4Ov3+FJ/BAvm/IZn
 8M0ppmoQlHU6w0e8MmYc8uR2W4xeIYrNDE582vzT0vYHspjiCg/zmSxvESj+DcUvMPk2rAg6S
 JV1MrVddumL8EFKOCjgpUzPBdYeSX1gBbuOSYGPm+9xHYKanV1Ux2cTTU5tbCTyfJMkG+uZ7+
 8Got/TMDuarCvl3vS7DMyMFgB97CsvudXX7pcGdOflB5DmSeyClk2VATIpxVTJ4mwofsTTpRc
 BhsYvhhbClMIqSgluat47R96z0+bFm7ZpYmkSmlv+/fwiSTJuNkWFy+rj6OHfun5t25B3myTp
 D7oKAhfqVgp8psE4/SGndpJbI+0oY1lQqbsUz6Uxn+w9B0jwHu5KdbJSZCd0mLPF3uomxU3C3
 qc+DurP3LrPdCuTlVfjr22FL/1EY4W68RNVOJhsWSEBXczoxuWc7z3uj6Fd74b5ePt2NPMb40
 jar4CalLQFsYobHLp91VsIKsjE1y48mZnO/uMeXQuEcx+T5pngIjAt1m0Hl5mRvls+0JPBmDC
 8WNzSFpu5TcrxoMI6x9Gzy2Wd6ZJ9XIgq9b7YroonMQzGyCOWP4bxGFkrRnztKOas6Onz+guW
 Cenw2j4OadwD0Gf8ydPnIGy2FmFpkmZsEZi4ZDoKSQiCU1ebq8on7G8WMd9QFC7Ri/PucwXnJ
 fCOtlCezSJyEY1CwvgZ8bd7/c9wjgg4p5o3csAYM0q54NUlU5SHKevF6tY30i9Biv8PROQkhF
 laxn22okX/2Y277IToVcR4fjTqlpCkzjE8LM4JEfM/ldqloIxZrKgUcQSWv+sZHop998GHX72
 FLBPw91+ZGus3gJacL5npA+D+JCKGaBB14zEr0FVyEcom8DiZhdH9wHWiJC0REVGdbE0d1Wqg
 Y6k+onj1l0pDJwEVecGo5qqO0BrY88Yb+vU/5trJiFozoTcAckqDPtJvo5BwVfKx7HPTQl7lY
 uAqhsZLjw83DXxtCuXDFomnTvMAXk9D9ecBbpkxLCirTvZXuMPMw99V1hlsI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ecXxbINy8N66OhILJatLDOZPAYXrP87lx
Content-Type: multipart/mixed; boundary="QBEXnUZhHCQt0S7YGuKBFpNE3FD3fDGxj"

--QBEXnUZhHCQt0S7YGuKBFpNE3FD3fDGxj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/31 =E4=B8=8B=E5=8D=8811:04, Ole Langbehn wrote:
> Hi,
>=20
> I have done three full balances in a row, each of them ending with an
> error, telling me:
>=20
> BTRFS info (device nvme1n1p1): 2 enospc errors during balance
> BTRFS info (device nvme1n1p1): balance: ended with status: -28
>=20
> (first balance run it was 4 enospc errors).
>=20
> The filesystem has enough space to spare, though:
>=20
> # btrfs fi show /
> Label: none  uuid: 34ea0387-af9a-43b3-b7cc-7bdf7b37b8f1
>         Total devices 1 FS bytes used 624.36GiB
>         devid    1 size 931.51GiB used 627.03GiB path /dev/nvme1n1p1
>=20
> # btrfs fi df /
> Data, single: total=3D614.00GiB, used=3D613.72GiB
> System, single: total=3D32.00MiB, used=3D112.00KiB
> Metadata, single: total=3D13.00GiB, used=3D10.64GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> This is after the balances, but was about the same before the balances.=

> Before them, data had about 50GB diff between total and used.
>=20
> The volume contains subvolumes (/ and /home) and snapshots (around 20
> per subvolume, 40 total, oldest 1 month old).
>=20
> My questions are:
>=20
> 1. why do I get enospc errors on a device that has enough spare space?

A known bug in v5.4, where extra space check in relocation doesn't match
the new metadata over-commit.

> 2. is this bad and if yes, how can I fix it?

There are patches for that:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D208445

>=20
>=20
>=20
> A little more (noteworthy) context, if you're interested:
>=20
> The reason I started the first balance was that a df on the filesystem
> showed 0% free space:
>=20
> # df
> Filesystem     1K-blocks      Used Available Use% Mounted on
> /dev/nvme1n1p1 976760584 655217424 	   0 100% /

Another known bug, which we also had a patch for it:
https://patchwork.kernel.org/patch/11293419/

Thanks,
Qu

> ...
>=20
> and a big download (chromium sources) was aborted due to "not enough
> space on device".
>=20
> I monitored the first balance more closely, and right after the start,
> df looked normal again, showing available blocks, but during the
> balance, it flip-flopped a couple of times between again showing 0
> available bytes and showing the complement between actual size and used=

> bytes. I did not observe this behavior any more during balance 2 and 3,=

> but did not observe as closely.
>=20
> TiA for any insights and ideas on how to proceed and a healthy start
> into the new year for everyone.
>=20
>=20
>=20
>=20


--QBEXnUZhHCQt0S7YGuKBFpNE3FD3fDGxj--

--ecXxbINy8N66OhILJatLDOZPAYXrP87lx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4L5C8XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhwZggAkJyJ2dAtrG8ZC1bO/xofxwqK
K0f8iHKU+otbQU5dp7q3Bce+HhWq9QG9pheqSCV9GkIBzQB+064HjH+yJrtFVBui
DxSg76FwHuZE7d8qQPOhHZxnrRHmoEWuqyb9GsRMUbtQ/gMMajnWVfEByBif/eSS
Rzbc2/IL6YFhbTOl1hBKdpKu9D2CATrK1Vo6U5ERq90au/Lvnup1j5DE6j3mVyEP
oJldFvBV+HkUYYkI5S/AzKD9gvaY0p3eGDm0rf8hGXiTsWssOlE47jKqVdf9C9kB
+fP6vKmfMlMA9h8Gss5UhIbY7VsQjblbVmpqC5jrb7FF2fCSz+mOovnz4m1Q2Q==
=hV2x
-----END PGP SIGNATURE-----

--ecXxbINy8N66OhILJatLDOZPAYXrP87lx--
