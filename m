Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAF114AD0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 03:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfLFCMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 21:12:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:57523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLFCMZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 21:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575598340;
        bh=cR4dvf28cr4yaEVN4ZS76DyI2oBA+CFRfon+SH7QUIc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LgeO4BldgHWfj+8sSDcrtlLAIR5ckySLNWZD5fiKYPa5CSUUIX52j4XwxS3NCQVAk
         YLf7eE/MgJO8vjKP3RKK2k7INtbzQMG7MjeciKQ3Rp/v3MwUhze3dblTc0ri4YFGng
         rV4tX1dzt4170dIDWVbOTm171coskWvXc9wvFM9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MK3W0-1iKy1V0dB8-00LTs1; Fri, 06
 Dec 2019 03:12:20 +0100
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
 <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
 <522495ca-ed55-dd81-a819-dab93e67d0aa@gmx.com>
 <BD72A51F-A536-428C-9993-91A43C99EE30@icloud.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <80206bf5-1475-0020-bad1-ebc96c57be84@gmx.com>
Date:   Fri, 6 Dec 2019 10:12:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BD72A51F-A536-428C-9993-91A43C99EE30@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AsUMlodLnCfjboQX9a7DK2INMx8K6bbt0"
X-Provags-ID: V03:K1:XejkYejG1dychKkvcEtPi9tD5nJLCU+3ZPKSr4sKqQfodQc6RQI
 nf4iLeYjJzq4R0dmEJmSqO1wqsSJcIN6/YrduuNKw2/tXJjzZEJsBvDM2BFx2J2H3rfe+z/
 W/Y0pWV5x4SevSCO3jzHmyTGn5qLTdtcfMkVqJCqnhMoT79W3d0z/jA+wcecgnJME1qkOGm
 9kGcBYkw/sSErzTyeKr3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:05Tb4luZnM0=:PIxo5K5h8xM5ptx2pSwVGx
 D81X8f8QbAI8yH4L/MilGq2xVJy6tFi6hHSuzSfXwr+/Bp/ZjjdqMbS24op6oRxlFKjeigzuR
 F+1SeuhD9FklUgw/cED4U007I+v3aaObu18IVg0HbZZnHKeqbZbgGyu7dQhpLm3jZe05PIXhh
 qj5DfZTTtZv6pX2vjObMLHXhf602B9uuusOtpSP/IYuikgGxuODD7Rl61ajYIBgFr4t6DeJCT
 /DQfbEIYHnarL77sIoftmWNfctKqASP6OPT5Z2hdTQxAyE992KMMTZC72RF9tNekLpm5GXEBu
 P19mjdzHqWnttaJydjLC2FU4BXDidiVfzIWHTzmvIZ+a/lRpfGli5M0HdhFKwI9F1cDZykZfC
 s8A+hADms0ooDBW1yzopNQaO+IAvhEsxTdamAfYARnqAI5DXacfNgTdvqQOJ5Hyz8RGm6g2gB
 kDDFqIHnvbwFN85PpNnPn6BQycQ/yzSahp0Px4bOG632aIC5Kr/s6W5UvObd0YKSKAkZJ4BAz
 zKHvWoh/NsSp6WSk1arOmDJXGyBY9dJPaXTiPQ3Ao+Sga3TLyQIpCFInXnnVR+fCrb+K9kahK
 NzBCDd2IByWNkCSzW3mkOUwvl2PEz2mn9/TkULwLifsGnZnYTzqDQRSenvbaVpAEyCMHfgyws
 /D/1Of4gMd5vZJ8pk8CZfRP7XXoRk4Y3ZQIzoqgyHk7okNRdVkEyh+e6NYqvk+Pz3xNrIM0oX
 dEFE+BAuHto/OcmfSIpgK+/9CIZ94OPyzA4Z77IsRfsmZH1hFKRVNi2JpBHEAKqk00uNu4prc
 qLze3IoMZ9eg2eCk9WxmiZSA+KehZPvRM8FYG81ry9gEMveaMPedwVeoHwvTNF6A0wTVMs5JT
 r0o16nMHV+5Xs0H78fcLB6+upTx+8j9dYxLWCDyDnjg/nvBJ5Z2LPfWGopuMttjGCmAqn3mOi
 yK0Z/VZvlJKOhzSkLyEYfH8nqvM4tPHJF7MR9nEMjOPPs0h5DT2vqnAAHATMKBt+rGVx/oT+J
 P7mnhRRyImEzMwLKeTeO7uGyDCLmZj78QgjyAEWG0Jz7Roc19isLv2rtNZENA6i0IPAwXsZt3
 u7AvxPYwrhhJfIs5hXyDCFxpFfQJHMGEFuksQBZ9wtSXNAIMvJJeoL/waFhGLMC7d7FBou862
 uh4N1RMwZNrG5DqH8fKTQ7F6wq/5b1mJ+Z5QUbjbpwnR0ZQZgryFJa/oMw4vZFJwRmEhs/pyn
 rpMQHblXu//Bw+JgeCUeei0UzRMCS9vhoKAeQ6bvxzlU50cw0Vz5KDJLKXBE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AsUMlodLnCfjboQX9a7DK2INMx8K6bbt0
Content-Type: multipart/mixed; boundary="N1lfnfCUZsTiUY5OIuO39TLJh12vgfBmR"

--N1lfnfCUZsTiUY5OIuO39TLJh12vgfBmR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/6 =E4=B8=8A=E5=8D=889:31, Christian Wimmer wrote:
> Hi Hugo and Qu,
>=20
> here the output from the commands:
>=20
> # btrfs ins dump-tree -t root /dev/sde1 2>&1
> btrfs-progs v4.19.1

Too old. Please use latest version btrfs-progs.

Just as mentioned, SLE is not a good choice for btrfs-progs.

Thanks,
Qu

> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
>=20
> # btrfs ins dump-tree -t extent /dev/sde1 2>&1 >/dev/null
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> # btrfs ins dump-tree -t chunk /dev/sde1
> btrfs-progs v4.19.1=C2=A0
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> # btrfs ins dump-tree -t 5 /dev/sde1 2>&1 >/dev/null
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720,
> have=3D14275350892879035392
> Couldn't setup device tree
> ERROR: unable to open /dev/sde1
> #=C2=A0
>=20
>=20
> I will try to setup a newer kernel. Which Distro you would suggest for
> this purpose?
> The idea is to download and install a small linux just for recovery
> purpose for now.
>=20
> Thanks,
>=20
> Chris
>=20
>=20
>=20
>> On 5. Dec 2019, at 21:04, Qu Wenruo <quwenruo.btrfs@gmx.com
>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>
>> btrfs ins dump-tree -t root /dev/sde1 2>&1
>=20


--N1lfnfCUZsTiUY5OIuO39TLJh12vgfBmR--

--AsUMlodLnCfjboQX9a7DK2INMx8K6bbt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3puP0XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjcFwf8C2y4EUCfXuMwhcIAJK8Gd5//
Wk5i/yUZvNCEmuUW/7xtrtLIrsPPy4KJvvc5s1YMzCnbQRgQwe8+/uIITwB03zQF
PH4ihyLYw+affvhgYYJ+3/c1TNfWgoEK8/qUA/2q7EXT+/08jMQUFZrbPJyrJgl6
lQN8qF2HOkt5YFHHNLsVyhMW+twq7tC38yEibHN6gXvClb4rC9t1P7vTRVPEORp5
icjybIxUZHrjmoAwaMi5JLe+5Kf1GStKMMHCKCT3r7KvPfPjdFIwEcKUw+qDqPh+
7qC0hBFbfMXAClZq9by3/5ZqMO+EkmiXXkqRctd4o3bNPIU914rAXK842MAqSw==
=wq/D
-----END PGP SIGNATURE-----

--AsUMlodLnCfjboQX9a7DK2INMx8K6bbt0--
