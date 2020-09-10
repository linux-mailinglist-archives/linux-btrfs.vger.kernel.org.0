Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298D9263A85
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 04:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIJCb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 22:31:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:40997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgIJCZc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 22:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599704729;
        bh=wqbB4/BwSd5hpVvBlK2Gk6Ax67T3R9WI+VycEU5hQz4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DTQ/4jm0HxQ7LLiHwaNc432m28LGLo8bNMMo8BP5MLcMoBYHofIFCSdYWkrBzi6g8
         dcMhQhGSxH9tStG/tDVtb8aSDye75piVMGtuUjc6cqo2vvVExR+n9y18wDDLhhWCdH
         bpJtbyveAHSSQObi1iSexFz3tTNxLrcN84G6QFrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1kSVOQ0Oxr-00za9d; Thu, 10
 Sep 2020 04:25:29 +0200
Subject: Re: Corrupted filesystem after power loss
To:     Benedikt Rips <benedikt.rips@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <2080952.sO1OYyYaP7@orion>
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
Message-ID: <26cc2afa-a71b-c449-a4e9-80ff0c5ae68c@gmx.com>
Date:   Thu, 10 Sep 2020 10:25:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2080952.sO1OYyYaP7@orion>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5oyCKOGIHLbYFXxlxRkwQUhhmLwj5X2KI"
X-Provags-ID: V03:K1:SSBx4gDPr1Y8JXvezDn5PpGtrQVLRdF5z2t5uavCasqhQeITjcg
 Sw4zYR3YNcGxD/LiXsJH1tDgP7EaTksFPdeJbyjiXwjh1q3BdUWj8gcUv1EnA/7KMGmFHBH
 5lVgLyYlWmRTMWLdrRyem7/wsqn15wL7bc3NCEFVF/nTgyg42QfindPdEy1PJjCBGtEFMJe
 lTkla86aI1lcFwX5OA09w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6qp9BWNUS4=:cjhiPw8JnbiMw6mS6sJqWN
 ORsaadq41P9xZwutAyzWBFIzhSqR8jX3xvURNjucoHdNIRIuhQpCAUyCiPeDKFaF7NWJ4rUV/
 ubHDowtVbc2oBAloU9MkDIWPqCMau5/lSiWphuytnrUNi90u1AKLtd2rbg56voyZuaeFQE2P4
 BVXYUXYE3vQcZfBaUjgUr4I574eciRW7KFd04kWTVuoqRLo0lsn4kZ8apaSXITZnyt/CwjoA5
 76KSljgaMPVoyEG9brr5mhFP5SGsf1z3GjlJ5FYA6gaz0dGE2HS4iySFRx9Va8eJigGYXlT4F
 EdjfJUndmAIpal02KCs9/gtu24pdiQRgmqW0vBPnu5FkaxBWwSU+dsQer+fMXv8bvB/PgRSfH
 9nZwKaQ1XW0Ydp39evV635HGpP1ZjT+QIM9lqHe7jP3n6meig30KVw6gAJS4txKOiskXJUj6C
 j66b6arELrxcNmXmwjP10/vPhsoqJMbNrAw//3OSsW+nNJnNIcByc/R9dHIJ7qcg2ff2oPV0k
 lDy7lE39LHv7KQkdE5qP5tCpIuEOCQSYue0Dq+CzP3lZ51N490zg2GRGRB9GX3qxZyaHejUhb
 XZ6E5LuigmGvT2Jqt28Q4RK4blQ/ydHbeEePCUkR4U/zSf5Cnk9K0X4A0tqVpvaa/LIPYV8NX
 kJ8+XU8lTmTibCKSVYPp+Hx+sbWHYZ3dcvdF/1+inlOIqo3/PqI72QflMp+hF/qnZkLiD2OuI
 n6k1T4cgUSsmSYkQGnlp18RzHm/Pky4cuAJM0qcSX+LB7ke4aG4q/+tAQWgFLoPcJgtdPwYha
 eY06Pik8omgDAn859pelRPCAkElN4lgeasu3hB+R+YPdOti5cUkQ6K3FhCFSIBt7ZO9GjRM5r
 xMwIq1U4DTr7LZIdPBjjzcy3kCSlfvM6eSlv5E6D1rdIzD9rsEamouXBGV3yw7i+kBKsOz83F
 fOgkON8DlTn70UHGQzmZ+rRYJ2T0sWUfZI/OlHcOEf7yTE1/o8bDcYhm5T5MWeUlkMl028j2x
 NxjVdAt8AMq6baNz0UYJuNkBlhyF+cn//h+8gTgdxIlOzJW74v1+6aOcQpTlztpzIBXPZ6+yk
 HsWhGHwW9rITmRbN8/QYG2C2s7N2PLd8ljbN7afElrrRfiKNoDwNFiWTtDBGgK6jXE9EUz56h
 P4imUnit8BZQ94WlzaKXdDUTb0+gwbkbYzrNSiemRlbw4RWcUT3giSyjl09LOakGr+XKnyEv+
 bpS+8tgcWezIQg7Mz5cj2tYVvQ8pIsAasuPgVVQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5oyCKOGIHLbYFXxlxRkwQUhhmLwj5X2KI
Content-Type: multipart/mixed; boundary="cmsuVdfAMdBCR3DRFhQYIeYdgoXa1U3H9"

--cmsuVdfAMdBCR3DRFhQYIeYdgoXa1U3H9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/9 =E4=B8=8B=E5=8D=888:13, Benedikt Rips wrote:
> Hi there,
>=20
> two weeks ago, I forcibly shut down my system when it was frozen, by pr=
essing
> the power button for several seconds. At the next boot, I was not able =
to=20
> mount
> the filesystem. I booted from a usb stick and at mounting my root files=
ystem
> (which is btrfs), I got the following error messages:
>=20
>=20
> # journalctl -qxeb | tail ... | head ...
> Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): trying to use=
 backup=20
> root at mount time
> Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): use zstd=20
> compression, level 3
> Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): disk space ca=
ching=20
> is enabled
> Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): has skinny ex=
tents
> Aug 28 16:43:21 archiso kernel: BTRFS warning (device dm-2): dm-2 check=
sum=20
> verify failed on 95634915328 wanted 59c7037e found 97021a59 level 0
> Aug 28 16:43:21 archiso kernel: BTRFS warning (device dm-2): failed to =
read=20
> root (objectid=3D2): -5

This is the real problem, extent tree get csum corruption.

But since you're using backup roots, it should just rollback to next back=
up.


> Aug 28 16:43:21 archiso kernel: BTRFS critical (device dm-2): corrupt l=
eaf:=20
> root=3D18446744073709551610 block=3D95602491392 slot=3D0 ino=3D10363009=
, invalid inode=20
> generation: has 1518459 expect [0, 1518458]

This is in fact not a bug, but indicates your fs finds a good backup,
but then log tree is triggering problems.

As log tree is newer than your backup root, tree-checker is rejecting it.=


This is easy to handle, just zero the log by 'btrfs rescue zero-log'
should allow you mount the fs with "-o rescue=3Dusebackuproot".

Furthermore, we should not allow log replay if we use "usebackuproot"
option at all.

I'll add extra check on that for the kernel.

Thanks,
Qu

> Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): block=3D9560=
2491392=20
> read time tree block corruption detected
> Aug 28 16:43:21 archiso kernel: BTRFS warning (device dm-2): failed to =
read=20
> tree root
> Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): parent trans=
id=20
> verify failed on 95599607808 wanted 1518455 found 1518457
> Aug 28 16:43:21 archiso kernel: BTRFS info (device dm-2): bdev /dev/map=
per/
> lvm-linux errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
> Aug 28 16:43:21 archiso kernel: BTRFS critical (device dm-2): corrupt l=
eaf:=20
> root=3D261 block=3D95596232704 slot=3D112 ino=3D11473161, invalid inode=
 generation:=20
> has 1518457 expect (0, 1518456]
> Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): block=3D9559=
6232704=20
> read time tree block corruption detected
> Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): failed to re=
ad=20
> block groups: -5
> Aug 28 16:43:21 archiso kernel: BTRFS error (device dm-2): open_ctree f=
ailed
>=20
>=20
> The filesystem is on an SSD, my kernel version at the time of the failu=
re was
> v5.8.5 and my btrfs-progs version is v5.7.  The information regarding t=
he SSD
> are:
>=20
>=20
> # smartctl --info /dev/nvme0
> smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.8.7-arch1-1] (local build=
)
> Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools=
=2Eorg
>=20
> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Model Number:                       THNSN5256GPUK NVMe TOSHIBA 256GB
> Serial Number:                      Y6EB70N0KMBU
> Firmware Version:                   5KDA4103
> PCI Vendor/Subsystem ID:            0x1179
> IEEE OUI Identifier:                0x00080d
> Controller ID:                      0
> Number of Namespaces:               1
> Namespace 1 Size/Capacity:          256.060.514.304 [256 GB]
> Namespace 1 Formatted LBA Size:     512
> Namespace 1 IEEE EUI-64:            00080d 0300085baf
> Local Time is:                      Wed Sep  9 00:18:09 2020 CEST
>=20
>=20
> After reading through the btrfs wiki (btrfs-restore, btrfs-rescue, btrf=
s-
> check),
> I asked on the IRC channel for help.  With the advice of cmurf and dark=
ling I
> ran the following commands, trying to find the cause of this error and =
a
> suitable backup root to restore data from: http://cwillu.com:
> 8080/37.201.170.65/1
>=20
> Kind regards,
> Benedikt
>=20


--cmsuVdfAMdBCR3DRFhQYIeYdgoXa1U3H9--

--5oyCKOGIHLbYFXxlxRkwQUhhmLwj5X2KI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9ZjpYACgkQwj2R86El
/qjXTAgAgm66m5uI9+/kreacNaCmOFvdPJUsI0/u3ZNW6Q2u7Ot9aqICZRIBTDuq
CbKoLujgtGhKbpa4JR5Ez6KOiCOSBa801ARXTdW2BQLq0I5WDA8/K6Xuw+wlSH67
Fgs0bEMESg63lvZhAhOmsSi96hoMHXFrgudUT/b0WjydMcpT2YYZt9fCjg4FP0Oy
PtqvLUwO9NfYcZgaAEg/DJmjMTiMXxVIIsf0j1g8Kzj9I43B+/7S2zDCdCIEIl3l
rNRf6bGTgkizDPQdAxgYJbIyRHYiO5hbYS6suHUE869EzbRgahpk10mar/kDw8fP
Wqt7P6vyJLiShEdtElCMiREE/mFDuQ==
=epY3
-----END PGP SIGNATURE-----

--5oyCKOGIHLbYFXxlxRkwQUhhmLwj5X2KI--
