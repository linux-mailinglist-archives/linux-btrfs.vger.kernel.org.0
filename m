Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C683196A79
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 01:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC2A6h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Mar 2020 20:58:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:56401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC2A6g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Mar 2020 20:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585443498;
        bh=MaHihEVMWbNS9t6fyPQ8o/1NZEKh07I5c5qMctUMiK8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=V6+WuDyuXAuErL2rQiJfhRD2+4fQ3r2bWzpHheBbnhYPuBiOcH0A9JJu8paVFH1Q1
         xBwZi+uJtb9y7N8OIvjg9pEENHfXDGxdVn/tzPFS1wIy7mB0SUeNT2zmFdbsBU3266
         WLGoX2OosKipXNAe7O5ibloP2g6gRkYhI7NVObD8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNJg-1imt7g0upu-00VQQi; Sun, 29
 Mar 2020 01:58:18 +0100
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
To:     Brad Templeton <4brad@templetons.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <7c0a1398-322f-400a-abe4-dfea98fd46e1@templetons.com>
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
Message-ID: <10c1cc37-0b34-637e-32a4-b00aeae2d17e@gmx.com>
Date:   Sun, 29 Mar 2020 08:58:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7c0a1398-322f-400a-abe4-dfea98fd46e1@templetons.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xOywyPdHlOSJHHFbYDJN5lI2DIWXCgRXK"
X-Provags-ID: V03:K1:MeWdVyx+DNl2L/nTLHzLdRz7K3twmCPijJ6yHdburwENV84iB+K
 6oSwNrmkpVoLJ4j4uRYV+NAbrBSv/u44gXcDVeLMoGT2csNE0n59hJBAH4F9+rhCnvp+wya
 HHkc4TDvpxb6rtl2gztkUFzW86OW70jo/M45bQkAzvyAO9j933K25P2/WJvpyFWdcr2YXHg
 06tUunM9FEsL871tFITXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vYZg6/ayFb8=:2LVKuUTYb11OqLVjc4wEiS
 j1nWDabtQvbktrpYfHg1Cixw4rrwQPfN2yWan4MCsJi4VFRSdOOJcKu58XlwWYsqUPssMZDxI
 nPqg7hrAovcTuVTJHjt9CgUFyTEhHM77xZMtUZQr7hxyt+Dr5VbChgqQN1epgrTLFGghdKJ6D
 uKFVkPsqMuW2I1DinP5rs6xaOM826rWolpmQTA6JvsA0BMxpWQQSpkEW/6AzMROaQHvIMBHvS
 ZB1JuzTxtYgrGmEseoZOftlQcmMtOP838MEFbqEm4G2tGqWf33Hmi+ciaoBsojKdAGh+4oaHr
 +BG1C8wbgtlPT6Datk2fe/kJsRBfaSykx4KoY7mcLng1NTiCGB+WtmRVKziIUhXfx5bh3rwUJ
 YsG3rTqRHSaI9iMvbhRzV4G7NWrSdKAL5+vyWB4SXgI9zgG+Zqv799FgnzknI/y5ZzYMYEFif
 yXPmvprVo+o9KLwIqGHE+b/TYcICIsYDOa/dNXa9EVCW3FwlNiR6+kh6UJ7jSVfUYI0Fxrc8W
 ZdJtSZzrgOIcFkZJSS+6yfmzigUwQf9mrlnoO/3326w5mDm8IQu+LiCutW2UXPAe9Km6+X3V+
 VYu17xbTcEGIyFSX2mchn1z5P01ke2krR44PN3OL+g80lfl0qy8mDoDa/a3rqIRUxEr4Z60Xm
 UWoHgEKoDhhBDqoP5SYx5R2EibY+6ChcD4/Ir9QByKstYb5nWmhXLXeNDG9kVEKJTtY++zbQb
 vU/oqyAVFQUDhZBTTxTs7E4uvqYjqX/fTPS0SNXSadtabeVf4H0kcj0Xi5wXSeTEX+Luec/gu
 DhEaA6haLb0+WZIbdX3RU5EgY26XaO+4SlKhJ99qDVaqJ8Dtgf288GcyRY4M9ueMLr5PBiaey
 4m0nvLGifK+IoOBMv4fw6dYXv381R2D2LkNEbbEkvc/94umLS2nCL/SUUDZaw2MxNKRmETuHs
 J5/Ugotan1tcxg8WHV5EiYd2BVIHcZK4ddvgy6PWfcYihtrBSTtffZQDQZ9v9294KDy5FPr0D
 kvaQJdKHpLUO6S4uIOpqEllnUG3/lqRsfVWg1cwROsGBvSbOrsSKENJvdiUS66uuPAy1kd25o
 hJAr3dtaCnmk4aWWuDB3rXjNoIagsdLAI/s3WY6q3AJm2CeeUVc2LIntXepgTMRNjVipTZPMM
 4KORcW+TbxYVG/CSJBvQjXrypEKq394NkU38+/XkmXpeuPhr0jf69Euga+DGZsk5LklmhqlN4
 MwGK8dpRE/sL3q67P
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xOywyPdHlOSJHHFbYDJN5lI2DIWXCgRXK
Content-Type: multipart/mixed; boundary="1Z01YhJSK11gLWFDIq0C3Lu3O7IaZhYbm"

--1Z01YhJSK11gLWFDIq0C3Lu3O7IaZhYbm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/29 =E4=B8=8A=E5=8D=882:26, Brad Templeton wrote:
> I have a decent sized 3 disk Raid 1 that I have had on btrfs for many
> years. Over time, a serious problem has emerged, in that from time to
> time all I/O will pause, freezing any programs attempting to use the
> btrfs filesystem.   Performance has degraded over the years as well, so=

> that just browsing around in directories with 300 or so files often
> takes many seconds just to autocomplete a filename or do an ls.
>=20
> But the big problem is that during periods of active but not heavy use,=

> every few minutes the i/o system will hang for periods of 1 to 10
> seconds.   During these hangs, btrfs-transacti is doing very heavy I/O.=

>   Programs waiting on I/O block -- the most frustrating is typing in vi=

> and having the echo stop.  It's getting close to unusable and may be
> time to leave btrfs after many years for a different FS.

Are you using qgroups and doing routinely balance or snapshot drop?

Qgroup is known for causing a lot of performance impact, especially for
snapshot drop and balance.
For the balance part, it get improved in recent releases, but v5.3 it
shouldn't cause too much overhead unless it's doing a lot of background
IO during balance.

Anyway, if you're using qgroup and it's not critical to your use case,
disabling qgroup would help a lot.

Thanks,
Qu

>=20
> During these incidents iotop will look like this:
>=20
> Total DISK READ :     499.57 K/s | Total DISK WRITE :    1639.00 K/s
> Actual DISK READ:     492.73 K/s | Actual DISK WRITE:       0.00 B/s
>   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN      IO    COMMAND
>   882 be/4 root      499.57 K/s 1604.78 K/s  0.00 % 98.60 %
> [btrfs-transacti]
> 21829 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.23 %
> [kworker/u32:1-btrfs-endio-meta]
> 14662 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.17 %
> [kworker/u32:0-btrfs-endio-meta]
> 22184 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.11 %
> [kworker/u32:3-events_freezable_power_]
> 13063 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.06 %
> [kworker/u32:6-events_freezable_power_]
>   486 be/3 root        0.00 B/s    6.84 K/s  0.00 %  0.00 % systemd-jou=
rnald
> 22213 be/4 brad        0.00 B/s    6.84 K/s  0.00 %  0.00 % chrome
> --no-startup-window [ThreadPoolForeg]
>=20
> A way to reliably generate it, I have found, is to quickly skim through=

> my large video collection  (looking for videos) I would be hitting
> "next" every second or so -- lots of read, but very little write.
> After doing about 40 seconds of this, it is sure to hang.
>=20
> I am running kernel 5.3.0 on Ubuntu 18.04.4, but have seen this problem=

> gong back into much older kernels.
>=20
> My array looks like this:
>=20
> /dev/sda, ID: 2
>    Device size:             3.64TiB
>    Device slack:              0.00B
>    Data,RAID1:              1.79TiB
>    Metadata,RAID1:          8.00GiB
>    Unallocated:             1.84TiB
>=20
> /dev/sdg, ID: 1
>    Device size:             9.10TiB
>    Device slack:              0.00B
>    Data,RAID1:              7.21TiB
>    Metadata,RAID1:         14.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.87TiB
>=20
> /dev/sdh, ID: 3
>    Device size:             7.28TiB
>    Device slack:          344.00KiB
>    Data,RAID1:              5.43TiB
>    Metadata,RAID1:          8.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.84TiB
>=20
> /dev/sdg on /home type btrfs
> (rw,relatime,space_cache,subvolid=3D256,subvol=3D/home)
>=20
> I have 16gb of ram with 16gb of swap on a flash drive, the swap is in u=
se
>=20
> KiB Mem : 16393944 total,   398800 free, 13538088 used,  2457056 buff/c=
ache
> KiB Swap: 16777212 total,  6804352 free,  9972860 used.  2045812 avail =
Mem
>=20
>=20
> What other information would be useful in attempting to diagnose or fix=

> this?   I like a number of things about BTFS.  One of them that I don't=

> want to give up is the ability to do RAID with different sized disks,
> which seems like the only way it should work.  Switching to ZFS or mdad=
m
> again would involve disk upgrades and a very large amount of time
> copying this much data, but I'll have to do it if I can't diagnose this=
=2E
>=20
>=20


--1Z01YhJSK11gLWFDIq0C3Lu3O7IaZhYbm--

--xOywyPdHlOSJHHFbYDJN5lI2DIWXCgRXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5/8qUACgkQwj2R86El
/qg/GQgAkQCZyJ1LowGvQXUKju1VWfkIPKkR8qHhKp6+LDbO2Kb3cgR/iznkaGrf
75jGNhOqgNPkyiNDACfpOWaPnw3yVCAUIA0AqKhPZFInS/Jq1KiwKfCNRtMxjz0K
FBzB2kWrUQXHBoSHzZ+9a1QbPrzrBVt2dQi3C7hba+0zJ7eWilp4czdY4rM7X13M
R/h5VbIIpx+tKn8Wge8ePkvI3URqXFu/C6EcJVNwCdMIMlaDHgrORS8+kfj1+McB
Xx6HnagCBrAPvjepuCRl3f3le5VeYAADYMcvgbQMQmtqF0lVKzxLFEZjEosQuIVy
hQt08u82Adxj3d0dfg9I6ydWRYbHpQ==
=0cm4
-----END PGP SIGNATURE-----

--xOywyPdHlOSJHHFbYDJN5lI2DIWXCgRXK--
