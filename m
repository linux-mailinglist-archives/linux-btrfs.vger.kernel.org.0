Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26F174D07
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCALky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 06:40:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:43445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCALky (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 06:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583062850;
        bh=aIolV67gIT4ft2dseUtNoQESY45qFx5Rv96cLFefUmg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cVvrXpAqyuVHYuv4GSyZj+JOR3bfh0J/wq8w/ZyAsZk6GI1bclvWMpQRrn77l/9Hp
         PBMwjEqtFQwZZbmxzOQ99qrPLiuZatSOYYz4H+yWpupnArHTNOWr8xdhjFhEgd6wpo
         blp4Zws6ZGKQLeMtZZH0NiFnD4ASQ+89iZpg7DOc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9yS-1iqHqd3fmM-00I9fQ; Sun, 01
 Mar 2020 12:40:50 +0100
Subject: Re: corrupt leaf
To:     4e868df3 <4e868df3@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com>
 <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
 <2ffbf268-437c-b90e-21f3-7ea44aa9e7e6@gmx.com>
 <CADq=pgkuxOf7h=25Qice9q5Q-RiFXQiDzx0ZuEUCs4uN++3sxw@mail.gmail.com>
 <81a5e4cb-c6a6-23e0-9a29-76eaa07a6166@gmx.com>
 <CADq=pgkV21ZSCeJEC8jGSB4P6+_OXzpG8v54Px8XbDDh72Edjw@mail.gmail.com>
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
Message-ID: <df40a18a-4a28-f3b7-dfff-8ccade905d32@gmx.com>
Date:   Sun, 1 Mar 2020 19:40:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CADq=pgkV21ZSCeJEC8jGSB4P6+_OXzpG8v54Px8XbDDh72Edjw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i0odKGhJQ4zEI8Z7quCzMwCVTvOZCbmGd"
X-Provags-ID: V03:K1:HaJ4Q/r98ILZsQmcNIBvp1pB14hJhHoTFdI4LDrId+R0k1g+Z4f
 SlU9J5nw0K4PD6PIvpc6CPISwbENvFTmm90iIEBZ2sAnwqcVTN0be9JZLBvBv+M3VgtYsTe
 NwgKvSRhcQFALtdvamDrs3995zLYY609f4boBf50voXvnb8FbgVou3e+7RjoDZdqJk664rS
 GsEvQGiOC0+CsoRxOtfOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qRqBeN6wC5A=:T0GQJLNxH1W574WA+Un2yn
 VZZJeFe2qysGHz9gEau5PvUJXkljDrEsLi1YcTY/dvQuIMesXXT5UlptMxqyesyqKmB7s42WS
 FLopQcbei+RPZ7rL+QZ2pKsAv7OoJKw3cBMW89Fq4JjQ9pse6bjb9LtwS81aWCV4rEfZFgaXK
 9AsXvCyQNYoR5UL9yGDRaqLu4skb0GAEuyHqvsfaf1YKMivf3HP48YjgBu5Z3TXb4AWUkWYiN
 7HgM4+ZQc2LggskIuxd0CWE1k+xTZlZTmYRLMhmOpMuEewVBts8xlzgjzrhuEjhgnrv4ECKf2
 xFirEa+xuPK/dX6YceFzG08+osLffTwnBjc7sRFVKEcIloDAd6E//g0lHfviCvKsHyJ7m78nB
 cDk6J4LNA5+TzmhOXpkFTETqQrWtQ8R9zD8PeAPP+zlXXNVewgMCCfEh/vV9M/wB9ECIkShO5
 IfzKs4tHw+lNdLr/eQDMhDSlpVOLKtj0RIN1oN8sbvl+6u8m19Opkb/cISktDXPraji9bMdKn
 UOxm3bv7qZMNZZJDFXoL7r0mMeKM9p/CbloZQMIuWaxOH2hrLs6iBRI7vkR6iyGWPqqeh8iNF
 A3ZfIKvdqeczjoN3NlfTYo/PcYpi7D/5T9sLlcYphmv2husU44zSui0Av2q8XlzVOOaSUxrmv
 XSUmP1OdZkAi/uz2GLWRdhzZshmCOZI+J9yN+bdrpi3jGTaY6te4u5jwd6jNiz6wfUPTAa6M1
 N8ou/CePXjwRrMFSHJOO1MSN4WfRibKeuquO++tKafAAwO4B/ww7rywItAbU2RMq5K86i7Oz5
 CCSO5L876eYfH5B+slTpewh9FBPQ3YnHB4TZhFldrsMab1e8NDL/JHYD1NmiRhwInQkWctm9k
 x+ZIgHL3kDjd7tpxO0g6k3r47VMS2nN5363xBVVjcFLXL4+X1Pb8hESX/lRwWbBb/W05PY04V
 HdamwDckHLp3n7/h5yO+cVKFCafscjei+lxvkU3sS0bcMebajNYiJ2Oir0ulscObdroIrQXMx
 lVZCx+N7zZCkyvsqD5b7qVokuWDudmojVPS2nuGH8FTZbUvwOd4q6LMKlTb/Em/Xau4FeZHHN
 t/+UPznscR0gyy16gO/VPNEYMOYolueLZQ20+6/pAgw5cgkEkPSRwnV7D2wUaBzkZ3AS3aR0I
 uR0dHHr8unRXlsDDoxRO12BlQ/qsxZ8mJOT61swWFYVf8aUBRnUTt9U/dRkAoBhXr5+LyFoOS
 tWbMNkxYZqChJhW5R
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i0odKGhJQ4zEI8Z7quCzMwCVTvOZCbmGd
Content-Type: multipart/mixed; boundary="0exjOEtPpD0anVAbaEo7BCbE0UB6ReQ8G"

--0exjOEtPpD0anVAbaEo7BCbE0UB6ReQ8G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/1 =E4=B8=8B=E5=8D=882:11, 4e868df3 wrote:
> It's possible a pacman upgrade triggered this BTRFS event. I don't
> know what was previously installed. Here is what is installed now.
>=20
> $ btrfs version
> btrfs-progs v5.4

Then it's a bug in btrfs-progs. I need to find sometime to reproduce the
problem and fix it.

`btrfs fi df` output may help in this case.


For now, I only have possible workaround, that is to delete the
offending files which contains the csum.

You can try the following command to locate the offending files:

# btrfs ins logical 68761178112 -s 45056 <mnt>

And delete related files and hopes kernel find its way to delete the
offending csums.

Thanks,
Qu
>=20
> On Sat, Feb 29, 2020 at 5:41 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/2/29 =E4=B8=8B=E5=8D=8811:47, 4e868df3 wrote:
>>> It came up with some kind of `840 abort`. Then I reran btrfs check an=
d
>>> tried again.
>>>
>>> $ btrfs check --init-csum-tree /dev/mapper/luks0
>>> Creating a new CRC tree
>>> WARNING:
>>>
>>>         Do not use --repair unless you are advised to do so by a deve=
loper
>>>         or an experienced user, and then only after having accepted t=
hat no
>>>         fsck can successfully repair all types of filesystem corrupti=
on. Eg.
>>>         some software or hardware bugs can fatally damage a volume.
>>>         The operation will start in 10 seconds.
>>>         Use Ctrl-C to stop it.
>>> 10 9 8 7 6 5 4 3 2 1
>>> Starting repair.
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/mapper/luks0
>>> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
>>> Reinitialize checksum tree
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>
>> This means the metadata space is used up.
>>
>> Which btrfs-progs version are you using?
>> Some older btrfs-progs have a bug in space reservation.
>>
>> Thanks,
>> Qu
>>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
>>> btrfs(+0x71e09)[0x564eef35ee09]
>>> btrfs(btrfs_search_slot+0xfb1)[0x564eef360431]
>>> btrfs(btrfs_csum_file_block+0x442)[0x564eef37c412]
>>> btrfs(+0x35bde)[0x564eef322bde]
>>> btrfs(+0x47ce4)[0x564eef334ce4]
>>> btrfs(main+0x94)[0x564eef3020c4]
>>> /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7ff12a43e023]
>>> btrfs(_start+0x2e)[0x564eef30235e]
>>> [1]    840 abort      sudo btrfs check --init-csum-tree /dev/mapper/l=
uks0
>>>
>>> $ btrfs check /dev/mapper/luks0
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/mapper/luks0
>>> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> there are no extents for csum range 68757573632-68757704704
>>> Right section didn't have a record
>>> there are no extents for csum range 68754427904-68757704704
>>> csum exists for 68750639104-68757704704 but there is no extent record=

>>> there are no extents for csum range 68760719360-68761223168
>>> Right section didn't have a record
>>> there are no extents for csum range 68757819392-68761223168
>>> csum exists for 68757819392-68761223168 but there is no extent record=

>>> there are no extents for csum range 68761362432-68761378816
>>> Right section didn't have a record
>>> there are no extents for csum range 68761178112-68836831232
>>> csum exists for 68761178112-68836831232 but there is no extent record=

>>> there are no extents for csum range 1168638763008-1168638803968
>>> csum exists for 1168638763008-1168645861376 but there is no extent
>>> record
>>> ERROR: errors found in csum tree
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 3165125918720 bytes used, error(s) found
>>> total csum bytes: 3085473228
>>> total tree bytes: 4791877632
>>> total fs tree bytes: 1177714688
>>> total extent tree bytes: 94617600
>>> btree space waste bytes: 492319296
>>> file data blocks allocated: 3160334041088
>>>  referenced 3157401378816
>>>
>>> $ btrfs check --init-csum-tree /dev/mapper/luks0
>>> Creating a new CRC tree
>>> WARNING:
>>>
>>>         Do not use --repair unless you are advised to do so by a deve=
loper
>>>         or an experienced user, and then only after having accepted t=
hat no
>>>         fsck can successfully repair all types of filesystem corrupti=
on. Eg.
>>>         some software or hardware bugs can fatally damage a volume.
>>>         The operation will start in 10 seconds.
>>>         Use Ctrl-C to stop it.
>>> 10 9 8 7 6 5 4 3 2 1
>>> Starting repair.
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/mapper/luks0
>>> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
>>> Reinitialize checksum tree
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
>>> btrfs(+0x71e09)[0x559260a6de09]
>>> btrfs(btrfs_search_slot+0xfb1)[0x559260a6f431]
>>> btrfs(btrfs_csum_file_block+0x442)[0x559260a8b412]
>>> btrfs(+0x35bde)[0x559260a31bde]
>>> btrfs(+0x47ce4)[0x559260a43ce4]
>>> btrfs(main+0x94)[0x559260a110c4]
>>> /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f212eb1f023]
>>> btrfs(_start+0x2e)[0x559260a1135e]
>>> [1]    848 abort      sudo btrfs check --init-csum-tree /dev/mapper/l=
uks0
>>>
>>


--0exjOEtPpD0anVAbaEo7BCbE0UB6ReQ8G--

--i0odKGhJQ4zEI8Z7quCzMwCVTvOZCbmGd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5bnz8ACgkQwj2R86El
/qhOkwgArx5YbYaET4DZM6M1Sk15pJHLvsePhVEllXvfyfm0/ZkYCr+UM5iKrXJL
igtyYhDybMP+0EfKuU8cPWMxexBOmAI9s11JQHYHL9iW0c7yXeEhqkcdyeru978+
n/xSvnPcBN8Vgt4gfvVwdagEQ+88jPbkUgsHqg58hnewwgwdEprz7q8I/zMxU++x
vFEu37Mf2WxHMF3cZnOUGSITwNDGFxcCmyAXfNKUqVhNJKFKr5DgMxCpuItXiyue
VD61IgY+3Hb57xDMK1RKSc2PbYXG8bzhzK6bgQbp9UushXo0JHAgAovQNhGkx4/B
frh1KMwsGOtq6I+fAHaYbI9rwk11xA==
=odWc
-----END PGP SIGNATURE-----

--i0odKGhJQ4zEI8Z7quCzMwCVTvOZCbmGd--
