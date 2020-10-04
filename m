Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F275282A95
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Oct 2020 14:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJDMMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Oct 2020 08:12:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:54313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgJDMMM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Oct 2020 08:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601813529;
        bh=KnF0pBUBCSgBGoR36+NMcsXwftFrKWuF601ZLg8yZQY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hAxjBUqKgAQnDIpuLXHggxON3biY4JQEWNSpdqLfT+0i71sz/su72L5IL165GXLn7
         WCwzpw7il8UEMZTjJNZbLgVZ0R6iGWgT1weFb2+Z2CIjkGKqnqc2XZ9KWqOxSlctpX
         zcOvbBE/+Uw7mkO4seACTc+x5O7aJPntpE7o38dc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1kWd6a3H7E-0138rX; Sun, 04
 Oct 2020 14:12:09 +0200
Subject: Re: BTRFS device unmountable after system freeze
To:     Pet Eren <peteren@gmx.com>, linux-btrfs@vger.kernel.org
References: <trinity-8bafe7e4-3944-4586-8ccf-01fca6664979-1601808281835@3c-app-mailcom-bs04>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <1c7b7bf3-5912-3d51-c1f2-5c2c889367f6@gmx.com>
Date:   Sun, 4 Oct 2020 20:12:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <trinity-8bafe7e4-3944-4586-8ccf-01fca6664979-1601808281835@3c-app-mailcom-bs04>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cm1IkAH20QhBCHAjD1F9YidGxtUbuQC3D"
X-Provags-ID: V03:K1:OLbsFDEgjpBw9h7S8CsTtF7AU5WrNpiV28BIVz0MiiX/38zbzHl
 PVNDCeomKn9Jqr0Qd/7zP6D18Fy5z4KUmPK1Wh6mxiMXTSRWazhxRlyW+bf6jHE5gF8Hf49
 udjpKqUl1rRyyHG1uG4RINu0PvO9lD7jfCVgdy+wUnZ3G7ChPKvOYWfv+keu5HQdpUr3wjQ
 fPA/N2ZA9MO+rRtmKxfgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PPGk0zhj0Nw=:1PWY1IYXNPGgpPymcMtH/X
 32WPeray+MYjIxromT43iXPn+79Vn7q/3OCbD+MITAkvNfw5vE+mi6MtAvG29Sez5XIlQ7tRR
 w5j5S5lGGk1no6snL5A2QPy/B0x2MqykqtPuO8GWTEPpttLUkwkQOFVfJL5QRyW6zDKInDtr4
 roJa0wlj3acIebQROs1irlYch0oQHZWf5JXB4R19f9TPdn47jnM9EEsswr3m+5XIdkGnmYywM
 TEekG79mi62EJteQ25ckfoOQ5OlVCarMlns3MhIy6Vrf/nOPzEpnvl4Fe0EKS9Sk5vawu63wf
 bzGEjuNxNd8eXjPtcZcE8wbtnmVq2Pfeguxszpa9abKNJ+OEoO0OZiWoorl1kntYBGvqO5gvK
 WJrXyc0Ny5qlyUkoBg9EmolxILI9CsFcXgmrSFIPKssFETC4vNAMmOD3X3Le95ZB6SXxsZdh3
 qWa9l4zJlXf+LfaXaKquYbIHQNYeMctq6aXUsJ/Hd6kWy12HhBUgz0Ayk/cq2J6CL6RqBvm+N
 xdq4jw0loH4fWxmrDSerJJeuI5XUGSYCDNEqx8kLpuG3Kl4C1RB6LYUAVqCWjFsuBv1Y8CV5q
 5b3o40NlYE+GNxUE67oKbY86Nu6SXDGJ86IzHiSmXS5c/r2SuJLuE0j10uey+HN5vzZx0W18Z
 KhozAsM6K9QJUi+ynxUwA5ecdFBKllxgq6MSCvig+Ql3i/rLVh1RjIWYAMK1+EO103Z8XgIyq
 N0jgCz2xMH01FpqFrDZXqTRnie5yz/BuJFM1YR/Is/N1VNMuYmIe3EK6jcbM53kX0phxj2MzF
 3ZXc1JpbuCSuEWKNbQQq6UHytXEk4oM4vF1EFTV8RjGOYdA0YOFGXdzlTckObj/oSUrbiAiRK
 EC3wExwywdqPAoNzZ3FKQT0FTaDmTzcMrv12hJIRD22hY8xU06waiOO5RrTk9byC97vY1feUW
 hg/KiBg0Shf+C2EeSd+xWYYIqbLQ8l1NFTd9roHnLgvK/u6kt6JV9ogQHVQsWvLfqjOcd1gBp
 cvwS/ZsVp52vBNZCb9MyhfVOncCkdgSSKHHTA6XvfE8WzlvO0WSjQMcFxn5TGhnqLs/0/n6Eb
 SwqhVgrLzIU/uIjMc0pLQMEc4SS8ezoVUubOGwED4FvdM1Pv2LAUJgLNw8iUqz0bNYxgjdRws
 IeNke0N8omeX/tyrMPdzzy8V9QH4m43ghsxfbeZxEpVNOhlU2iGDO1lYgjFBEy1mSjQGXr2tF
 13BZSILU1XnFfd8rFe++3jdV8C9feGVtmx5JIpg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cm1IkAH20QhBCHAjD1F9YidGxtUbuQC3D
Content-Type: multipart/mixed; boundary="18LnwDBGazXR8lVuMI8rHa0z2cyExk3Q9"

--18LnwDBGazXR8lVuMI8rHa0z2cyExk3Q9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/4 =E4=B8=8B=E5=8D=886:44, Pet Eren wrote:
> Hi there!
> =C2=A0
> I have been using BTRFS on an external hdd (WD Elements 8TB, Single mod=
e, data, metadata and system in DUP). The device is LUKS encrypted.
> After my Ubuntu 18.04 freezed, I can unlock LUKS, but I am not able to =
mount the BTRFS filesystem.
>=20
> - uname -a =3D 5.8.6-1-MANJARO
> - btrfs --version =3D btrfs-progs v5.7
> - btrfs fi show =3D Label: 'Elements'=C2=A0 uuid: 62a62962-2ad6-45db-a3=
ad-77d7f64983e8
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 2.81TiB
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 7.28TiB used 5.77=
TiB path /dev/mapper/elements
> - btrfs fi df /home =3D Unfortunatly I am not able to mount de btrfs fi=
lesystem
> - dmesg:
> [560852.004810] BTRFS info (device dm-4): disk space caching is enabled=

> [560852.004812] BTRFS info (device dm-4): has skinny extents
> [560852.552878] BTRFS critical (device dm-4): corrupt leaf: block=3D290=
783232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid gener=
ation, have 878116864 expect (0, 1475717]
> [560852.552884] BTRFS error (device dm-4): block=3D290783232 read time =
tree block corruption detected
> [560852.557557] BTRFS critical (device dm-4): corrupt leaf: block=3D290=
783232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid gener=
ation, have 878116864 expect (0, 1475717]
> [560852.557564] BTRFS error (device dm-4): block=3D290783232 read time =
tree block corruption detected
> [560852.557605] BTRFS error (device dm-4): failed to read block groups:=
 -5
> [560852.616539] BTRFS error (device dm-4): open_ctree failed
> =C2=A0
> I also tried to mount the device on another system (where the volume is=
 created) with the same results:
> - uname -a =3D 4.15.0-118-generic
> - btrfs --version =3D btrfs-progs v4.15.1=C2=A0
> =C2=A0
>=20
> sudo btrfs check --readonly /dev/mapper/elements=20
> Ends like this (with many more "Error: invalid generation for extent" l=
ines)
> ..
> ERROR: invalid generation for extent 4552998985728, have 15046180803710=
188199 expect (0, 1475717]
> ERROR: invalid generation for extent 4555984134144, have 69219449903502=
60720 expect (0, 1475717]
> ERROR: invalid generation for extent 4556810252288, have 13383730893851=
772781 expect (0, 1475717]
> ERROR: invalid generation for extent 4558174781440, have 86490674675929=
86678 expect (0, 1475717]
> ERROR: invalid generation for extent 4558308999168, have 12953021474535=
714951 expect (0, 1475717]

Only extent tree corruptions, not a big problem.

Nothing of your fs is lost, just kernel is too sensitive to any possible
corrupted metadata, thus rejecting it completely, to avoid further proble=
ms.

In fact, if you go several kernel version backward, you can mount the fs
without problem.

> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated=

> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3086706528256 bytes used, error(s) found
> total csum bytes: 3008753956
> total tree bytes: 4968366080
> total fs tree bytes: 1722761216
> total extent tree bytes: 103022592
> btree space waste bytes: 352037386
> file data blocks allocated: 3189338202112
>  referenced 3189312909312
>=20
>=20
> Do you have any solutions how I can fix this problem?

You can try this branch with "btrfs check --repair":

https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair

Thanks,
Qu
> =C2=A0
> Kind regards,
> =C2=A0
> Peter
> =C2=A0
>=20


--18LnwDBGazXR8lVuMI8rHa0z2cyExk3Q9--

--cm1IkAH20QhBCHAjD1F9YidGxtUbuQC3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl95vBUACgkQwj2R86El
/qgFhwgAqdy6olXLREQMnu3oN3AciZHZKpbgQIfV2BEENxtcIHwOS9HZWp8SawuI
N4hk2xL5br3hiLTm1j6WWvYiwbpsgdDUlNjhkTkYwhFysWexoVBA7raqpThjtPUY
geORCUDsEvDoOlxl/qnx3LUdEb4rfh/ArUJ3SGHlYDeVg4dFDOWB4auUCzpPPzOS
9QCMi9IwQIFds8RZtEKYZPWCH7KqbQOTjKUGgCJ5P7fkE2ORIBF51MTB26Dkg+nS
0dFZuEjz0DAq0+JkVNlvBGJWlrwT2+r65PRIOonc1//ORE+kfur+RBAHxSJjFucQ
L28TXDwCY4brwtvzhBpFCoc5ZAaoYQ==
=0amb
-----END PGP SIGNATURE-----

--cm1IkAH20QhBCHAjD1F9YidGxtUbuQC3D--
