Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053D0174A87
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 01:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCAAlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Feb 2020 19:41:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:38291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCAAlO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Feb 2020 19:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583023270;
        bh=2BgfqoMAYdwlINA7WfGP3OB5eeVhXO0U0dDyu9DnvdQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eItRPzGF1FkPK23CyftheYztW+wAZLTfZQkKlTJgMyezTXYyOX1nPc+vWvgidx83H
         KBdVP/h0YkUU7kI7KssO4qkmu6mpj6tLsuq7psiPEU8hv9YztBR7AGY8U5YXeJma7r
         sxLpAgexi+tUIhvk/QXsUSBeNpgSPO/2XY6eCkes=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRRZ-1is6zG3u71-00XssP; Sun, 01
 Mar 2020 01:41:10 +0100
Subject: Re: corrupt leaf
To:     4e868df3 <4e868df3@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com>
 <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
 <2ffbf268-437c-b90e-21f3-7ea44aa9e7e6@gmx.com>
 <CADq=pgkuxOf7h=25Qice9q5Q-RiFXQiDzx0ZuEUCs4uN++3sxw@mail.gmail.com>
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
Message-ID: <81a5e4cb-c6a6-23e0-9a29-76eaa07a6166@gmx.com>
Date:   Sun, 1 Mar 2020 08:41:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CADq=pgkuxOf7h=25Qice9q5Q-RiFXQiDzx0ZuEUCs4uN++3sxw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ddLiOrvXnLwOMDSn27sUEuM3nfZ0wyTAS"
X-Provags-ID: V03:K1:qP+5E354xyuN7lwIjsa5H89glc2TwabR5l7veuEUtr+cDVryqu+
 J77+Vg03/UgNUIGLo+Dy0rH0KYIHBI5TynGih9rbssFagb14RDIUx4gSbHzEPUPXrM9Mdkx
 m6C2i9g19KF9YTSAfiWakCW4LXiOMyaPHuDSoOS3sCqnQyBLfN+ng0ayfs1F26tZwEN0Ywx
 7CCguYxnR0I6vgf+KXa8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Meacx15U5eI=:tKFst/jWo3ByUKNLFyqc7Y
 5QTivQLvRdLWXml239RAWBrWWrJ0uIFJS+nHCT/rr0D9ZlGyfvnGyhmJHG8iTp7YrlX8HeWAj
 tmFGCn+9vVN9nkpm4KPAGCEDXpejkU5dplYHoNdg7xQ+/pJH2f7Hk5POUrpkxdP/T3PeCT3oh
 SnYspRDY7HGDHkDx+FW9Q0QQLlXvSLhIOSP7uS/lUt0j8lR3Gb7vmZmuyIo+/RW9RH9QaJr2k
 mwygzOdAbhIFlTrLgerw+CSWMSbeLlCi0zDoUYINXZlLOUWKyYTu9ghjvw5vVgE62pDRJT8yQ
 XaNcbWMy8ToVwsPkXqTNgnxX1ho97pnXAi3c3ZZ194ZB42j97PSK3rdpysrHpwseFmxCiX53R
 ASiPfjYkQarwf08u2Te7PEYmrBoKSbh7VfpeExhhcR+uPaN/uixDx/p5tZFyOjmySSLdnVGfa
 RKNmN0ecwQ0wBTU+CJcW2fhBprFj2QMNmCdycQg82K16+E2sqVPT9JCAt+E8j0U29huA3w25y
 FXKAA9gNiA3/+cFI5d0Q6p3gTceKJ45xHG06UT1uLpHKmqf0cbyG+bYiasvr+gHMYDpKXYsAR
 44Fga+jveWQpqkwqgpQ5bIs7Mfxabaqy7T03cXVsmZlbRIovyE4NUr5fmR+AjI4UBIQEB/Xi9
 Kdx5hUcPaZUA2BsLgt+lmkmh3P4CX7SCrCdRLN6FkKDAGXmFflHbbIUdLsKUAmJlwfUPl8Fkd
 MLofZ8vQEom8fM1JbmPaK9aq43UkbRVOGgF+K4LWs++T2fLfm0KHu0RorTYCj0avh+vZcMbDv
 oHJQXiMlAmOEFRfEjMmSjzXSQA+/ZhkI6+XqcSBhA3OlcnNANldbJlGHTazKVLxhd0RWjCTGR
 x/EUAXqgxAqAX1uh0AkSADdVDitt7TvUZy0J84WjW734JYPFGKBdjRiWFtT8UdlrBoRPfwF2+
 dOwR70HJQxQwenxt2TQfLJEF82gLy8lSjFVPUw4om9zQ24fVDPm1OD9C0Pi1c+iNWmKCYD2ct
 h2sgQxGAPaF1Ql0TJv8thyzElhI99ys4idpm7jZmZXWF0cVkNb/sBqi4uS+vU22ZiNIxxI5VI
 LHsMqt2CDdZwVtBmYNpyC60VbpHLOtABgJmj3v/37nz682JAU+UHj0MAojkNKL+7LnWiB8m0T
 RmnkWH/ypmGpLgQ3uqw4bF1XtCJzPXVZX5jxzumZjJ2GhuMyYKHdMpmUidWb4GnZFe+qPmzjw
 tUPC8Vf2g503qUoAe
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ddLiOrvXnLwOMDSn27sUEuM3nfZ0wyTAS
Content-Type: multipart/mixed; boundary="kxtdsbeMlEl9Vhh4bUnAvi5UlJIW5WU0J"

--kxtdsbeMlEl9Vhh4bUnAvi5UlJIW5WU0J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/29 =E4=B8=8B=E5=8D=8811:47, 4e868df3 wrote:
> It came up with some kind of `840 abort`. Then I reran btrfs check and
> tried again.
>=20
> $ btrfs check --init-csum-tree /dev/mapper/luks0
> Creating a new CRC tree
> WARNING:
>=20
>         Do not use --repair unless you are advised to do so by a develo=
per
>         or an experienced user, and then only after having accepted tha=
t no
>         fsck can successfully repair all types of filesystem corruption=
=2E Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks0
> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> Reinitialize checksum tree
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0

This means the metadata space is used up.

Which btrfs-progs version are you using?
Some older btrfs-progs have a bug in space reservation.

Thanks,
Qu
> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> btrfs(+0x71e09)[0x564eef35ee09]
> btrfs(btrfs_search_slot+0xfb1)[0x564eef360431]
> btrfs(btrfs_csum_file_block+0x442)[0x564eef37c412]
> btrfs(+0x35bde)[0x564eef322bde]
> btrfs(+0x47ce4)[0x564eef334ce4]
> btrfs(main+0x94)[0x564eef3020c4]
> /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7ff12a43e023]
> btrfs(_start+0x2e)[0x564eef30235e]
> [1]    840 abort      sudo btrfs check --init-csum-tree /dev/mapper/luk=
s0
>=20
> $ btrfs check /dev/mapper/luks0
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks0
> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> there are no extents for csum range 68757573632-68757704704
> Right section didn't have a record
> there are no extents for csum range 68754427904-68757704704
> csum exists for 68750639104-68757704704 but there is no extent record
> there are no extents for csum range 68760719360-68761223168
> Right section didn't have a record
> there are no extents for csum range 68757819392-68761223168
> csum exists for 68757819392-68761223168 but there is no extent record
> there are no extents for csum range 68761362432-68761378816
> Right section didn't have a record
> there are no extents for csum range 68761178112-68836831232
> csum exists for 68761178112-68836831232 but there is no extent record
> there are no extents for csum range 1168638763008-1168638803968
> csum exists for 1168638763008-1168645861376 but there is no extent
> record
> ERROR: errors found in csum tree
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3165125918720 bytes used, error(s) found
> total csum bytes: 3085473228
> total tree bytes: 4791877632
> total fs tree bytes: 1177714688
> total extent tree bytes: 94617600
> btree space waste bytes: 492319296
> file data blocks allocated: 3160334041088
>  referenced 3157401378816
>=20
> $ btrfs check --init-csum-tree /dev/mapper/luks0
> Creating a new CRC tree
> WARNING:
>=20
>         Do not use --repair unless you are advised to do so by a develo=
per
>         or an experienced user, and then only after having accepted tha=
t no
>         fsck can successfully repair all types of filesystem corruption=
=2E Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks0
> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> Reinitialize checksum tree
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> btrfs(+0x71e09)[0x559260a6de09]
> btrfs(btrfs_search_slot+0xfb1)[0x559260a6f431]
> btrfs(btrfs_csum_file_block+0x442)[0x559260a8b412]
> btrfs(+0x35bde)[0x559260a31bde]
> btrfs(+0x47ce4)[0x559260a43ce4]
> btrfs(main+0x94)[0x559260a110c4]
> /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f212eb1f023]
> btrfs(_start+0x2e)[0x559260a1135e]
> [1]    848 abort      sudo btrfs check --init-csum-tree /dev/mapper/luk=
s0
>=20


--kxtdsbeMlEl9Vhh4bUnAvi5UlJIW5WU0J--

--ddLiOrvXnLwOMDSn27sUEuM3nfZ0wyTAS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5bBKMACgkQwj2R86El
/qhjAQf7B6ygn2u8Ruo10vRRZ3vh1iIsyeUyIhGWG7/GPUUO+VLSu6BP1deC6JcW
2cNZOJ/VXPqN7pXtJ5ELWifgdRYlkhVEvxUazweDq2qPydv/jtHqM2R430nj/IE1
8tI5T2/VgZQUlBOrZC6Nt35QdFI6RA6qq5NAmXsKqW6BPz+ncLnzNoaki9vjaYCf
QTA6Jtf8eh7eMtefsGXq356u2Tqe79Pje6lhBUrJNQhio3ILD9RkV8WQUQLZNRMT
IA/bw9bvipcDXJo4dLiKzUGxe6YomXkONjLWpmIlJLuPzx2pJGTkxARKuCLjsrsn
+W2sjT/Ava8RzyFc9FgsfZ5EMY7BmA==
=4Ua6
-----END PGP SIGNATURE-----

--ddLiOrvXnLwOMDSn27sUEuM3nfZ0wyTAS--
