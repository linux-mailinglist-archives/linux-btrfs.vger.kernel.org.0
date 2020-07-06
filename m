Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5722155F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgGFK4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 06:56:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:49563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbgGFKz6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 06:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594032950;
        bh=a5GlqrJyM9CF0GM8iXSLLMu+90rs8pm5rAJgJGaIMNU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=D2BuUBKPbkcNomvvMUDKFVlDtpQIhwIH0/iNb+V837J4wVuidI8Fx2gqY5vRxgxiJ
         LzCVjRW773xY5XkMEg8s3h2R6DxyjCKPN/zcWaR+Ky30bRko/0R/7/15vu3bbdkrOk
         ReDCkeLU3SAelly+HnQkXZH1CaA413XGHe1Y8UGo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1kw6Jb44bC-014gvW; Mon, 06
 Jul 2020 12:55:50 +0200
Subject: Re: BTRFS-errors on a 20TB filesystem
To:     =?UTF-8?Q?Paul-Erik_T=c3=b6rr=c3=b6nen?= <poltsi@poltsi.fi>,
        linux-btrfs@vger.kernel.org
References: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
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
Message-ID: <f2d396d4-8625-1913-9b1c-2fec1452defa@gmx.com>
Date:   Mon, 6 Jul 2020 18:55:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AHEsDFPYc81Tcs5ICTaCJ3c7xELjw6BIQ"
X-Provags-ID: V03:K1:Y/EamhsTeCtPch8FpDnFy6jF+kc6JkSxHMl7Bx0FDSiQntUwtNd
 +qDUl2kDqe06Ls0eyrMy9w5aAuzqDCFCW5RvdZTRkZ+uyFfVJdrZbMrqUt47ouFF5mvEv8c
 tsuXLaHr+NQ/IXGywOJ9R0dexNy3hwlmGEqGqTnnpJl2WhCfceSVcJkdOOWiqauYluTrxuU
 c8hbRx1tWdIptIWswDY/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RtA7OWJGcWc=:36jMHgwLwSHZzqA7ErpLQl
 0bqWR7dgFJHZu1oqJO82AKmqJda9TzA9MRAYuMXJGMFiwiL0OsK23WNEe3io2OvI/pFn5Z8lH
 i3t26OU7GaVBoCNBdmJZaIBURoVOeVn9uyE0Z9AQga8DP4Cw1kTSgMpxghBmbAU4dUM9ION4E
 0UKGqpjwK33Sq1pmlaDBnzyu+wy6ce+e6jZDI206FmHrVLSeh6N/6pmCnHneSNx51rfZuWPN+
 GiBNNv9stLQoYbpV0yP0626eoEaoCaixcKNhoksHPMSFFwUhovaOHFftjHF2AM18LuDqYrMSk
 SVSe4PgyN5KrkeJ9vzX9IK+36a5LW2ij9bfoxXirvlA2+5PInq69IiGtx30oiR1MivpToAB15
 Tocgaj0rswJ9M1rPjJbISOtMqXeuKnflMV7RikClMiS8J/pMXZpJftqFAOMKfDZlBkgsyWuct
 z2HZRJMPC8+G4WD3T/ODlRleuzyQLAjWidDKI9BZ83punHIyPwESR0i1T16iwL6EOlti7Uxik
 veXzAABMp0KabE8puSRU2EZn821uGu6A8vh/i8FhuLtSfaVPmht8R/rSp3FRuKYNFnkSWSoB3
 JRonFwD+07tl3fEGm1xjz7VHbhq8OlKMR3QOvEfh5NPWzJfMMIPSM5n1ffdv3K6zsrZekgCLc
 Krlw2oZFDO0RliyCSh+rNwiHzwNPgk0PbQ9AXab1tJl6GAhI1koL5i8rOHUueqPTZ2ctrJf/l
 uITdEXYWaJE9RPSMMjCIg7iffbiWrMbDDnJqNAAlDJUlAPd/1EFuYYHsGrS6cFq+LRjglowhd
 pfQpCt2Y5hccx+OxyYengacgI+WKazm9wrAnypmrJC/JhrDPThMJaZHSeUILrVPQb2LHisxSn
 x7YtqZp7G8G47cBsGtDmqB84Q8ahGVzNHCSIT/sVem/Ae4nlUQQckBPJU+p3elvIEzqkHeapr
 5nUTh83Ng+Jqkiuk0vU6ASbwvjO61umXk38qIM8PEfegVikH/fVi9S1aMtDjfMCA2PBngcao7
 ae+BfIdibX5nlHPjaOo56oaWo5yYQHNZZHD6FubdSowD39Dt4eqq3n0aTTkiougVgOqkl2quA
 TJAHZkMOrWLUY9wfsqodTkPrI522TGmv2Hj7EGr8EiW7ZDNJEBJwQNRWJmK3ne3U5fpKVJwTe
 YshrWYYk3N+xJoGBP5A3KlhXkujGKKjoj5Vl/SiwxA6V6r+kgUasbbY20aHeg5qkN5eITXOyk
 Bkvi+Bi6EcKnf9bB3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AHEsDFPYc81Tcs5ICTaCJ3c7xELjw6BIQ
Content-Type: multipart/mixed; boundary="62ZzagC9AYaehRc3pvvJMjuRNkDjt3onl"

--62ZzagC9AYaehRc3pvvJMjuRNkDjt3onl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/6 =E4=B8=8B=E5=8D=886:41, Paul-Erik T=C3=B6rr=C3=B6nen wrote:
> OS: CentOS8 with updated kernel and btrfs-tools
> Kernel: 5.4.17-2011.3.2.1.el8uek.x86_64
> btrfs version: 5.6.1
>=20
> Some background. The file server had been running for quite some time
> before I reinstalled it with CentOS 8, at which point I noticed (after
> having installed the Oracle UEK kernel which still supports btrfs) the
> errors when mounting the partition. I updated the btrfs-tools to latest=

> and ran the=C2=A0 'btrfs check --repair /dev/sdc1', but despite this, s=
till
> have errors when accessing certain files on the FS. Dmesg shows them as=

> following:
>=20
> [1681476.647521] BTRFS error (device sdc1): block=3D3154170920960 read
> time tree block corruption detected
> [1681476.694520] BTRFS critical (device sdc1): corrupt leaf: root=3D5
> block=3D3154170920960 slot=3D9 ino=3D13286681 file_offset=3D204800, ext=
ent end
> overflow, have file offset 204800 extent num bytes 18446744073709481984=


Some older extents are affected by older kernel not handling extents
length correctly.

18446744073709481984 =3D -69632, which means there is some underflow.

Recent upstream kernel caught it and reject the whole tree block to
prevent furhter problem.

>=20
> There does not appear to be any HW-related errors in the logs.
>=20
> With the help of darkling on Freenode IRC #btrfs collected the followin=
g
> information:
>=20
> btrfs inspect dump-tree -b 3154170920960 /dev/sdc1 ->
>=20
> btrfs-progs v5.6.1
> leaf 3154170920960 items 97 free space 6102 generation 1326633 owner
> FS_TREE
> leaf 3154170920960 flags 0x1(WRITTEN) backref revision 1
> fs uuid 519a6725-10d4-4d82-bc4a-32de7dfb923f
> chunk uuid 4d1fe695-d2cb-43bc-bac6-d3101dc0725b
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (13286391 INODE_R=
EF 2479498) itemoff 16245 itemsize 38
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 8927 namelen 28 name: file_28-2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (13286391 EXTENT_=
DATA 0) itemoff 15384 itemsize 861
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 152266 type 0 (inline)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inline extent data size 840 ram_bytes 840 compression =
0
> (none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 2 key (13286679 INODE_I=
TEM 0) itemoff 15224 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 148004 transid 1326604 size 0 nbytes 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 40700 links 1 uid 941400003 gid 513=

> rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 5 flags 0x0(none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1592086804.669979287 (2020-06-14 01:20:04)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1488735439.699720907 (2017-03-05 19:37:19)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1488735439.699720907 (2017-03-05 19:37:19)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 1488735439.699720907 (2017-03-05 19:37:19)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 3 key (13286679 INODE_R=
EF 900409) itemoff 15200 itemsize 24
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 156 namelen 14 name: file_14
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 4 key (13286681 INODE_I=
TEM 0) itemoff 15040 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 148002 transid 1102464 size 203197 nbytes 2=
04800
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 100644 links 1 uid 941400003 gid 51=
3
> rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 43 flags 0x10(PREALLOC)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1550596828.990479215 (2019-02-19 19:20:28)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1488735117.417279715 (2017-03-05 19:31:57)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1488735117.417279715 (2017-03-05 19:31:57)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 2562566064006200577.1311248627 (-399890746-03-05=

> 07:02:57)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 5 key (13286681 INODE_R=
EF 2479479) itemoff 15005 itemsize 35
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 10704 namelen 25 name: file_25-1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 6 key (13286681 EXTENT_=
DATA 0) itemoff 14952 itemsize 53
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 148002 type 1 (regular)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent data disk byte 2584805376 nr 204800
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 90112 ram 204800
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent compression 0 (none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 7 key (13286681 EXTENT_=
DATA 90112) itemoff 14899 itemsize 53
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 148002 type 2 (prealloc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 prealloc data disk byte 2584805376 nr 204800
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 prealloc data offset 90112 nr 45056
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 8 key (13286681 EXTENT_=
DATA 135168) itemoff 14846 itemsize 53
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 148002 type 2 (prealloc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 prealloc data disk byte 2584805376 nr 204800
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 prealloc data offset 135168 nr 69632
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 9 key (13286681 EXTENT_=
DATA 204800) itemoff 14793 itemsize 53
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 148002 type 1 (regular)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent data disk byte 0 nr 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 18446744073709481984 ram
> 18446744073709481984
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent compression 0 (none)

The offending one is here, the extent obviouly underflows for hole extent=
=2E
=2E..

>=20
> The dmesg log lists the following unique blocks:
> 2627479830528=C2=A0 slot=3D10=C2=A0 extent data offset 0 nr 18446744073=
709457408 ram
> 18446744073709457408
> 2627928588288=C2=A0 slot=3D10=C2=A0 No extent data line - (seems to be =
a file with
> stat data)

Would you please provide the dump for this bytenr?
I'm a little interested in this.

> 28710276399104 slot=3D79=C2=A0 extent data offset 0 nr 1844674407370942=
0544 ram
> 18446744073709420544
> 28710639370240 slot=3D79=C2=A0 extent data offset 0 nr 1844674407370942=
0544 ram
> 18446744073709420544
> 30933479342080 slot=3D27=C2=A0 extent data offset 0 nr 1844674407370939=
5968 ram
> 18446744073709395968
> 3154170920960=C2=A0 slot=3D9=C2=A0=C2=A0 extent data offset 0 nr 184467=
44073709481984 ram
> 18446744073709481984
> 3154170970112=C2=A0 slot=3D59=C2=A0 extent data offset 0 nr 18446744073=
709527040 ram
> 18446744073709527040
> 3154171035648=C2=A0 slot=3D27=C2=A0 extent data offset 0 nr 18446744073=
709514752 ram
> 18446744073709514752
> 3154217795584=C2=A0 slot=3D102 102 item does not exist

This

> 3154257952768=C2=A0 slot=3D59=C2=A0 59=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -"=
-

And this

> 3154259034112=C2=A0 slot=3D27=C2=A0 No extent data line

And this
> 3154291228672=C2=A0 slot=3D9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-"-

And this too.
>=20
> The curious part are the two which list non-existing slots. These error=
s
> have been present in the dmesg-log ever since booting the server and
> while I mounted, as per instructions from the btrfs-Wiki, as readonly,
> so I don't think it is a case of changed files.
>=20
> All the data on the partition is copied elsewhere, so there is no issue=

> of losing files and recreating the FS on the partition is the most
> probable outcome of this. Thought nonetheless that investigating this
> may be something of interest to the btrfs-developers as I can keep the
> current FS around for couple of days.

Thanks for your detailed report, this would help us to enhance
btrfs-progs to fix them.

For now, you can just mount them with older kernel, find the offending
inode using the ino number in the dmesg, and delete the offending file.

With all offending inodes deleted, the fs would come back to normal statu=
s.

Thanks,
Qu

>=20
> Poltsi


--62ZzagC9AYaehRc3pvvJMjuRNkDjt3onl--

--AHEsDFPYc81Tcs5ICTaCJ3c7xELjw6BIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8DAzEACgkQwj2R86El
/qhl7wf9ElACu3pNJ1RpNOJwWU2OnHIfxxGeE4xXgcHGbhRCLU5LZ2nG4nnFDrki
jrzDpdgAhRR3Gac2O5NyhVH/VaDPf2GRoucHUBWM5e6Rx2/Pbc9A2aFtYkhGii8O
77QwGxmQvk/FWO+331usLu5H+Ktk2V0mwcanMbs9hPfG/dNFpI3BCpzYUXkQj5NO
GkxsWiAKt8FgCCfQ1roWzu/cciCoGszAONrL3323HVB5x/OQQj/NR9bKEDs/ndEz
/e+XdjRU13C3s4vr2q0VNjP/ppA2Zc81LmMIjxnEVAjmauHDBqf2ygKvUKA1ypNA
gq405IuHk6eXLCIGyGn8/W7xqWi5Eg==
=a97q
-----END PGP SIGNATURE-----

--AHEsDFPYc81Tcs5ICTaCJ3c7xELjw6BIQ--
