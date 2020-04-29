Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F561BECB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgD2Xpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 19:45:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:39947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgD2Xpi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 19:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588203931;
        bh=ZtgGH6IwwZ3rhtiq17BJtXnuPhdfSo1aZ2Ih2/bSvG8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Rd+tQkOi14a9prLpkLcUVVC08snQm3TUngipSp8dJiT3635aeSWHGFDbQw1mWsnMu
         /E9QMbfH2MdAyic+Dq1L9dR1sE0mjgr0isTF15QTjiud8ObWe7nwt8j9+KXTnYXJs+
         7PaA6SGemDrwoQtrir9FHAZxPuvMVNdGM/S6YkV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1ixLSV2Rsf-00gHn9; Thu, 30
 Apr 2020 01:45:31 +0200
Subject: Re: Input/output errors (unreadables files)
To:     Ferry Toth <fntoth@gmail.com>, linux-btrfs@vger.kernel.org
References: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
 <b178dd1e-7ef6-6808-5656-d9e22056cf1f@gmail.com>
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
Message-ID: <f5c77e4d-ef4d-b291-98d0-59fe85914390@gmx.com>
Date:   Thu, 30 Apr 2020 07:45:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b178dd1e-7ef6-6808-5656-d9e22056cf1f@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1SZxm1Lh4cDdYm1SySUAEnIH1M3C5nt5e"
X-Provags-ID: V03:K1:EifTRX9dZEZYzjqFhCSvpQsVLQWvjEbtVmQH6d7kZDkbtj1ZfOW
 RhFw9+b34WVwub89P0iYdR/xTc5jxLaXoKnKFGU6Iqxpd8eyhgGD9LOOzrqAETSHc7D9uDI
 9RUGW3rlYAydLuiApjKwdX27voOcFEmBzRdWrSEzVzb16FyuXfEDRg56jJHQVtGsvxNCqoV
 GZSEC8/UyIv/uLn/FsQ5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UqafMzVs/UU=:JIO/FfFe7cHx02gZRxXhgY
 htG/BHwKB4PrpKkF55SKWYXZBPT0bthg5d6M5g8CP0PO5MJO01ccrHZkoqDNatuDX+f8VhAN/
 H0ZUvvUjR9xJi1vNMEbWLvjTbp/I6fjOsW2ImSBVkolqIZ8kn4UM/mZNHChS09YSwLZOgIc3g
 TJQA3DJmEEtBtgK3sy9LpIzNxEnnpUZaEp19Osgch6WDt9AnYPFV/v5kHTL6p0igABLb0XhEM
 K1WeQlQ7BVWPDMEZWyhLHCo1SSku+46QuBOpLGit0bMJbEKKHaHwoq2TRLryBaJr5aKoHNs8Z
 GBsm9z3L/vmFwUd/XZ6iBfZ4019th69bzwen5EL4G7LBbDpsQRW/cWFTLjk8w6w1EJo2uSFiM
 UGd+TsBtWpH0OM+f2OFgESbccMK1Q1E8HcuNYXskfeUQ69X8wmYAI26erLTt6qkH+V0LE7P9F
 8SePwl2m726A1qnQ9vZfrTABBRdat5Csp6SIV0tOpkH5bHitmPDsYjN085oRNEryIrdpAQJGB
 3/CVjK6ZyJEwEp8+3OnMFO+UY95eWy0PoInj+nFWeDMETmebvB7KIf9aW84Wo/w+MCuDoKq7x
 wC8Oue+6DbTWNLTvsFGrH4HDuNJvAQFXBnkYKC3wmt4sxbXOXpqXEwdTbmkCKTQOZQTblZ2T2
 2BhDLeUtGIMD3WqaB3/cu2ftKuhL6ctl97rENlBoZTcsKp9YkrZ/REIkFQGs4pwDLrQQCuRZk
 ZD6YuqeFkUUAuttOK2OMeG/c4faNvzhHCpyBYwrSnzXroH1MkwDIxhTQW2H97MLeQhGVMoP9I
 m2dGoW7fGOsQdYkWOMnFA6FJ7Uh30FvxSYn7v8oTn1kRcyPr+MUh9DvVaUkNgT5tQfiTgO46w
 Rj8Lmaibs2DMOiC0z0vXPdflo980oSod7mZqpM10McDK+5XUbXbe22GBk29jSGum8rZ8isF08
 HLS3tBZEzhxjBtyITjoOsJgEWubfOLXjHoGEAK8hliWE+CXv1auQTGJbmYQgBSsi1okkBhg6D
 c2cJ8IS7Qhm2CFHITYQyRZpPT2lJcTBno0m1/LTW7fzuchOz3VbegBzm5xxDKmvsgietP2Jsq
 X4vZ8A2YrRPg9//J054876FHHX61/XLdc6rfT4H/LnkL4uYUO8IKC7rgq9B+vynge9OJc67zR
 qJO6j/lJl/IeL3Q9qVFx65AziNwCyuBKFghumhEdy1L7rKj9Tg+st3Wabin63vGWU8hZaJ4Yn
 WqjdNkzlkbI6uxpTo
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1SZxm1Lh4cDdYm1SySUAEnIH1M3C5nt5e
Content-Type: multipart/mixed; boundary="9B5pUrOHyb5c0bXwne6xRCHA0cgSCLcCI"

--9B5pUrOHyb5c0bXwne6xRCHA0cgSCLcCI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/30 =E4=B8=8A=E5=8D=883:10, Ferry Toth wrote:
> While upgrading Ubuntu the upgrade fails due to input/output errors on =
4
> files. Journal shows the same block is causing the problem for all 4 fi=
les.
>=20
> I would like to delete the files, but that appears impossible.
>=20
> I fear to reboot before finishing the upgrade, so this is with the old
> kernel:
>=20
> ferry@ferry-quad:~$ uname -a
> Linux ferry-quad 5.3.0-51-generic #44-Ubuntu SMP Wed Apr 22 21:09:44 UT=
C
> 2020 x86_64 x86_64 x86_64 GNU/Linux
>=20
> ferry@ferry-quad:~$ journalctl -b -e
> ...
> apr 29 20:51:39 ferry-quad kernel: BTRFS critical (device sda2): corrup=
t
> leaf: root=3D294 block=3D1027628027904 slot=3D1 ino=3D915987, invalid i=
node
> generat>

This line explains the problem.
Older kernel tends to create inode with invalid generation.

Newer kernel is pretty picky about anything suspicious, and reject the
whole tree block.

Latest btrfs-progs should be able to repair it.

Or, revert to older kernel and delete these files, and call it a day.

Thanks,
Qu
> apr 29 20:51:39 ferry-quad kernel: BTRFS error (device sda2):
> block=3D1027628027904 read time tree block corruption detected
> apr 29 20:51:55 ferry-quad kernel: BTRFS critical (device sda2): corrup=
t
> leaf: root=3D294 block=3D1027628027904 slot=3D1 ino=3D915987, invalid i=
node
> generat>
> apr 29 20:51:55 ferry-quad kernel: BTRFS error (device sda2):
> block=3D1027628027904 read time tree block corruption detected
>=20
> ferry@ferry-quad:~$ sudo btrfs ins dump-tree -b 1027628027904 /dev/sda2=

> btrfs-progs v5.3-rc1
> leaf 1027628027904 items 36 free space 966 generation 4933124 owner 294=

> leaf 1027628027904 flags 0x1(WRITTEN) backref revision 1
> fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
> chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (915986 DIR_INDEX=
 2) itemoff 3957 itemsize 38
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (915987 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 7782235549259005952 data_len 0 name_len 8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: smb.conf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (915987 INODE_ITE=
M 0) itemoff 3797 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 18446744073709551492 size 12464
> nbytes 16384
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 0 flags 0x0(none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1350489744.0 (2012-10-17 18:02:24)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1353328654.0 (2012-11-19 13:37:34)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1350489744.0 (2012-10-17 18:02:24)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 0.0 (1970-01-01 01:00:00)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 2 key (915987 INODE_REF=
 915986) itemoff 3779 itemsize 18
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 2 namelen 8 name: smb.conf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 3 key (915987 EXTENT_DA=
TA 0) itemoff 3726 itemsize 53
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 18 type 1 (regular)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent data disk byte 1110664871936 nr 16384
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 16384 ram 16384
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 extent compression 0 (none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 4 key (915989 INODE_ITE=
M 0) itemoff 3566 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 4933124 size 56 nbytes 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 144 flags 0x0(none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1571487761.716511096 (2019-10-19 14:22:41)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1571414492.451090452 (2019-10-18 18:01:32)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1571414492.451090452 (2019-10-18 18:01:32)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 0.0 (1970-01-01 01:00:00)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 5 key (915989 INODE_REF=
 659081) itemoff 3546 itemsize 20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 1101 namelen 10 name: libassuan0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 6 key (915989 DIR_ITEM =
653215628) itemoff 3497 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61471579 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4900555 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 7 key (915989 DIR_ITEM =
1600214284) itemoff 3458 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61471580 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4900555 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 8 key (915989 DIR_INDEX=
 56) itemoff 3409 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61471579 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4900555 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 9 key (915989 DIR_INDEX=
 57) itemoff 3370 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61471580 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4900555 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 10 key (915990 INODE_IT=
EM 0) itemoff 3210 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 4933124 size 56 nbytes 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 96 flags 0x0(none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1571487761.720511096 (2019-10-19 14:22:41)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1477470910.249847328 (2016-10-26 10:35:10)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1477470910.249847328 (2016-10-26 10:35:10)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 0.0 (1970-01-01 01:00:00)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 11 key (915990 INODE_RE=
F 659081) itemoff 3189 itemsize 21
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 1343 namelen 11 name: libasyncns0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 12 key (915990 DIR_ITEM=
 653215628) itemoff 3140 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (25762857 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 2068663 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 13 key (915990 DIR_ITEM=
 1600214284) itemoff 3101 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (25762858 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 2068663 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 14 key (915990 DIR_INDE=
X 38) itemoff 3052 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (25762857 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 2068663 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 15 key (915990 DIR_INDE=
X 39) itemoff 3013 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (25762858 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 2068663 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 16 key (915991 INODE_IT=
EM 0) itemoff 2853 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 4933124 size 68 nbytes 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 48 flags 0x0(none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1571487761.720511096 (2019-10-19 14:22:41)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1540813807.330187853 (2018-10-29 12:50:07)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1540813807.330187853 (2018-10-29 12:50:07)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 0.0 (1970-01-01 01:00:00)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 17 key (915991 INODE_RE=
F 659081) itemoff 2831 itemsize 22
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 1545 namelen 12 name: libatasmart4
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 18 key (915991 DIR_ITEM=
 653215628) itemoff 2782 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (52273681 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4036682 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 19 key (915991 DIR_ITEM=
 1600214284) itemoff 2743 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (52273682 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4036682 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 20 key (915991 DIR_ITEM=
 3650993379) itemoff 2707 itemsize 36
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (52273680 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4036682 data_len 0 name_len 6
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: README
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 21 key (915991 DIR_INDE=
X 20) itemoff 2671 itemsize 36
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (52273680 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4036682 data_len 0 name_len 6
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: README
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 22 key (915991 DIR_INDE=
X 21) itemoff 2622 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (52273681 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4036682 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 23 key (915991 DIR_INDE=
X 22) itemoff 2583 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (52273682 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4036682 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 24 key (915992 INODE_IT=
EM 0) itemoff 2423 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 4933124 size 56 nbytes 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 595 flags 0x0(none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1571487761.728511097 (2019-10-19 14:22:41)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1571414569.458782758 (2019-10-18 18:02:49)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1571414569.458782758 (2019-10-18 18:02:49)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 0.0 (1970-01-01 01:00:00)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 25 key (915992 INODE_RE=
F 659081) itemoff 2402 itemsize 21
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 2141 namelen 11 name: libatk1.0-0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 26 key (915992 DIR_ITEM=
 653215628) itemoff 2353 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511250 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902445 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 27 key (915992 DIR_ITEM=
 1600214284) itemoff 2314 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511251 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902445 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 28 key (915992 DIR_INDE=
X 227) itemoff 2265 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511250 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902445 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 29 key (915992 DIR_INDE=
X 228) itemoff 2226 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511251 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902445 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 30 key (915993 INODE_IT=
EM 0) itemoff 2066 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 4933124 size 56 nbytes 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 299 flags 0x0(none)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1571487761.720511096 (2019-10-19 14:22:41)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1571414569.158783954 (2019-10-18 18:02:49)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1571414569.158783954 (2019-10-18 18:02:49)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 0.0 (1970-01-01 01:00:00)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 31 key (915993 INODE_RE=
F 659081) itemoff 2042 itemsize 24
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 1639 namelen 14 name: libatk1.0-data
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 32 key (915993 DIR_ITEM=
 653215628) itemoff 1993 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511215 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902428 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 33 key (915993 DIR_ITEM=
 1600214284) itemoff 1954 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511216 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902428 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 34 key (915993 DIR_INDE=
X 116) itemoff 1905 itemsize 49
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511215 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902428 data_len 0 name_len 19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: changelog.Debian.gz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 35 key (915993 DIR_INDE=
X 117) itemoff 1866 itemsize 39
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (61511216 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 4902428 data_len 0 name_len 9
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: copyright
>=20


--9B5pUrOHyb5c0bXwne6xRCHA0cgSCLcCI--

--1SZxm1Lh4cDdYm1SySUAEnIH1M3C5nt5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6qEZcACgkQwj2R86El
/qjkrwf8DxCoA3lwZTb89KGmii0s8H67aV+DBdvi6DA3fw70FMi5K4TjLLtYKyRg
m3LbaKqj81uI6pm9yOesjY2PPlf4yRJna5iFIiYqtevQUovZVN6RoUAkYy3yNnBV
pGutW/cYuBK2rFPWwyzhheHXyVSM4yIP34HadiZjgybOe9Pht4tg9mUmjXoqZjHM
eKAkSy50p5yuevdaFMHkAC3z/5fM4Eybzxx66AwvRcHrWZszHE0jvWzdZfw2KP9l
JTnbpMNjn8wXJkMiD4yRsJKjueIoGlHIS7tILQiUqMEUdZrODXv2VM5PsJx8Mi3X
K6IvUjdS7hw9GfLUG4q4ftpUfPLOlQ==
=11US
-----END PGP SIGNATURE-----

--1SZxm1Lh4cDdYm1SySUAEnIH1M3C5nt5e--
