Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADBB130E2C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 08:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFHsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 02:48:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:40359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgAFHsM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 02:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578296887;
        bh=z177UmCmtfCvq2ULOcAbOvtMvCnq6LbSVjNpnp1CZ68=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fBr/VeDzgbvF/H0ve27sKzpXEYlkwioVzLjwZs0oWrtDGVGvGo4kQfyHkVYfHuGAp
         gWEOq9bfaqQv1fprVIVavRBGvefqfxlN7l+x8Y3hMz8dqz2okccej+MvgIfhdMagmh
         dDAp8dxiodL71o/dyNSLnbt/BkaDkHMQadSnglEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDou-1jcmyc0pfU-00xZwn; Mon, 06
 Jan 2020 08:48:06 +0100
Subject: Re: /bin/df showing btrfs filesystem full
To:     Kenneth Topp <toppk@bllue.org>, linux-btrfs@vger.kernel.org
References: <4f3eb367af2a4585c30f96c6d7e910a4@bllue.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <308a3c86-27f0-074c-734d-871639f339c7@gmx.com>
Date:   Mon, 6 Jan 2020 15:48:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4f3eb367af2a4585c30f96c6d7e910a4@bllue.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wGctoIQzgL1ZheaphoxgndbtczdegOqgz"
X-Provags-ID: V03:K1:LMeIa8OoDQvEXPzAXShJyfPwMgAHyTwR8hIjop01Cw+kqLGKfk7
 PM4H6JfWaSmtgfrf7KUbIaL3PMJXZhYr/DFz4maTI7QiS9+z8G7u1NWPoFfPCOD5yGBFKjD
 u2nZkxN67zoJMPrXW10pmi55sBfHxoKT5N0KX61/9+vIuAeP7ZFzZ0xloHQaGGEdKcWBngc
 IEwvIaZvTYY2Y+a0Tu+kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m4uj4SL2v1k=:2Ww1u5vXJudF8b2IzGWCGJ
 dGrJaWobJ4LHnMzdr3yrfWmAwujf7rcRmT0Iw3R2zv+cC7CZvDCfqZjeyniO+FuqWGT22cMtU
 JYBlvtbwMAO+t6H1EYSnucyZnmDNn6HvsDiK8UEvbpNfs4RidGQ4uJAF4aH8rePcnD85S9Twx
 8fVoGQhTd1FW0gMcUvXtFLJi7u7zC6iENvqw7DhKM/mnG4q1Q1jTqeLiu5M+uwjjHQWw2L1Qm
 qEuky0wAg4UOp46uJKIuaRshw/UnybdLEQ/UL3mlnClIjeMq2diCbddCoOmg0nqzOyNRa+nzX
 DA49+x4LZL3Q2VImgdAq+dAM+FbA/LW00g0eJQa6UXbtuGl0jDhqaELDlxvapofSJy8nNdqSn
 j1TZ7MpC6KzXW8j9LZMKNq9SXapaIpWtZFFyfVr+zzUW/UlchkT4UK7u2+hXEyGwqYw7OIW7L
 a+D+Z9r8vsFqsljStJUnzLWoH14/IHUeuUnIuqCUOr8RvD1DxLTjjsCgX8lz0vbOSai46Zd6v
 CsPyCjJSPrmBIHd1JCy0UD00r/MeG35I4k5VdCx4djxXk9HC37z5pA694G4K8HcEsuP3R8ySu
 PRiQ8Juy86K7QIfKmJb8tMghDd9GLPEJvsVUAMm4YZt8wR6I9yDNbmEL/1BP0umR897ujlM2Z
 Qne5UxYJYwSHvsG3LxMOm8DvlZPvbAl3hkFRZNob7n3EhyhbVbYOqlqCLSn3mCVqCwaOliuAw
 7JFUPmIroK8rLaWl77h7menyCxUK0X1nbNqtFtQLxhkIciP+bUhkfjYu38txNog18C90MJKaH
 GbHNA1zZoSyCzFI2bImz4MqWpbVABz1YHJ0z0p7OatCKdUNzKijTyS8WVhbogUUFdpM7aYQqT
 PKeffZ7il+xj5tV7GpUN+LpqTAwnbf1J5XlY87hmkwL2TKj5tgk+fa/sVaZvzZHkci+YIkHAh
 l60efuobqKdEUtFNfOxE1LHniJUpcSUN7I9otOYxpc+q7ZFBcclYSg9iQRlH0e1/JdAfW8mdA
 QnzBfLK6hnYCMDTx1LslSVmbQTGwt8Y+7G6bjFlIeqSDiOqzqwjiIuzRcjDyh5ewFfKhYa9A3
 qD75SYCEtzAZfT3T1Zbw6Lw/DqQZ0Vo6wXHL2+aiAXOfWVd4yFeKZiYId+k8/CiAExKq6ntCW
 QlBxl+Na0PvZyWbpTIUWxtS1WcxCuy0LhSYmGIZR5sd5tQxdWSNUS32mYpAQ5NVsyxURNuZRK
 aldDI5kXsUgoRWZuAWP+srOwyCxMQaAWzW41ZyBYtX8iFUXGyKoEhuU6RO/4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wGctoIQzgL1ZheaphoxgndbtczdegOqgz
Content-Type: multipart/mixed; boundary="2cDxohEFh9LvIwljRmfSFYvG8qMbciXXo"

--2cDxohEFh9LvIwljRmfSFYvG8qMbciXXo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/6 =E4=B8=8B=E5=8D=883:21, Kenneth Topp wrote:
>=20
>=20
> Hi.
>=20
> I have an issue were periodically a btrfs filesystem shows 100% utilize=
d
> 0% available
> # df -h /home
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Size=C2=A0 Used Avail Use% Mounted on
> /dev/mapper/cprt-50=C2=A0=C2=A0 30T=C2=A0=C2=A0 20T=C2=A0=C2=A0=C2=A0=C2=
=A0 0 100% /home
>=20
>=20
> Then it goes back to normal as follows:
>=20
> # df -h /home
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Size=C2=A0 Used Avail Use% Mounted on
> /dev/mapper/cprt-50=C2=A0=C2=A0 30T=C2=A0=C2=A0 20T=C2=A0 9.7T=C2=A0 67=
% /home

A known bug if the metadata reservation reaches a threshold, only for
v5.4 kernel.

The latest patchset trying to address this bug is here:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D223921

>=20
>=20
> This filesystem was created on this kernel 5.4.6 that it's currently
> running.=C2=A0 This filesystem went from 0tb used to 20tb used and woul=
d show
> this problem periodically as i was filling up the drive.=C2=A0=C2=A0 Th=
ere was no
> ENOSPACE issues, so I thought it was just related to the heavy writing,=

> but now that the system is in regular service, it's still periodically
> "filling up".=C2=A0 but again, the only symptom I can see is gnome and =
df
> showing the drive being full.=C2=A0 nothing else indicates that the dri=
ve is
> full.
>=20
> I have some other btrfs filesystems that didn't show any issues.=C2=A0 =
They
> were created under earlier kernels, but with the same options.=C2=A0 th=
e
> other difference is this new filesystem is on top 4kn drives, where the=

> others are all 512e.
>=20
> Any advice would be welcome, for now I'm just ignoring the problem, and=

> making sure my backups are good.

Only statfs() call is affected, so your data is fine.

But quite some programs would use statfs() to determine if the fs is
full, so there would be quite some inconvenience, but should be no data
corruption.

Thanks,
Qu

>=20
>=20
> filesystem creation commands:
>=20
> mkfs.btrfs -f=C2=A0 -O no-holes -d single -m raid1 -L tm /dev/mapper/cp=
rt-50
> /dev/mapper/cprt-53
>=20
> first time mounted was with this:
> mount -o clear_cache,space_cache=3Dv2 LABEL=3Dtm /mnt
>=20
> diagnostics commands:
>=20
>=20
>=20
> #=C2=A0=C2=A0 uname -a
> Linux static.bllue.org 5.4.6-301.fc31.x86_64 #1 SMP Tue Dec 24 15:09:19=

> EST 2019 x86_64 x86_64 x86_64 GNU/Linux
> #=C2=A0=C2=A0 btrfs --version
> btrfs-progs v5.4
> #=C2=A0=C2=A0 btrfs fi show
> Label: 't2'=C2=A0 uuid: ce50d21c-7727-4a53-b804-d02480643dfa
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 640.00KiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 447.13GiB used 2.01GiB path /dev/mapper/cprt-30
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 447.13GiB used 2.01GiB path /dev/mapper/cprt-31
>=20
> Label: 'btm'=C2=A0 uuid: 0a5b42a7-0e39-48fa-be1f-4aa29bc323f2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 19.45TiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 14.55TiB used 9.75TiB path /dev/mapper/cprt-50
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 14.55TiB used 9.75TiB path /dev/mapper/cprt-53
>=20
>=20
> #=C2=A0=C2=A0 btrfs fi df /home # Replace /home with the mount point of=
 your
> btrfs-filesystem
> Data, single: total=3D19.45TiB, used=3D19.43TiB
> System, RAID1: total=3D32.00MiB, used=3D2.05MiB
> Metadata, RAID1: total=3D26.00GiB, used=3D25.73GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B


--2cDxohEFh9LvIwljRmfSFYvG8qMbciXXo--

--wGctoIQzgL1ZheaphoxgndbtczdegOqgz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4S5jMXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjwZAf+MN6Ku5N6g8VGSBSP3q7jT/Re
uNwqhz77Xh4zJuExQxYjquPrH1ts2B532F7+FkdwgYt31gx4AGbxXsAeKtctP3Bq
QaYWjJdWZJ3CMBgu03jRcublcy56mWYPMEU/piAfscV7v6rKJT2sSzGk4BPC6MK5
MZbMF4JuT5yUBY+YNo6VT5gBFxvGs1v8iWVAA/W+wBh220NEMYmhxLpE0JENiiSy
atsO/fs/oT6bNC2R/zjO0yMp86VftRUobdFXuRsKR9LtdQ2uSYkQWy9qHPLMxql1
fCJsER6/AqpKSwCHtJXnwQ70RYyY8OJV5l43fsrgYztV3xsUjESFLyOoLejbgw==
=dvMS
-----END PGP SIGNATURE-----

--wGctoIQzgL1ZheaphoxgndbtczdegOqgz--
