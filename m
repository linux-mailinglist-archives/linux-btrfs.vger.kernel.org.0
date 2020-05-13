Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C021D08C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgEMGgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 02:36:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:52437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgEMGga (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 02:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589351785;
        bh=TszCI+9cyS0tpMjrRVDhfEENtRQQzyQpEPxsH4VaC4s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Kii7sBo7zuczVBIPdLze1dV9tkg6o/E3hZ4z/2Ww2EhR8ziaNzUwJ9omwJAcnURba
         LVRCZPjUrI3QhEK2GfWhDR2SBt05yZBDq8jXe7RblDFFgMt3uaziFF+N7UYWRUICBs
         Q3Z6bC0EZROv5d/k0A3mXh3Vy14HmmwoW1eiRvXg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRRZ-1jaE9T32Mt-00Xwjv; Wed, 13
 May 2020 08:36:25 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
 <20200513050204.GX10769@hungrycats.org>
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
Message-ID: <437bf0bc-b308-5b41-67cc-5b84ba6a88d2@gmx.com>
Date:   Wed, 13 May 2020 14:36:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513050204.GX10769@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cFx1aHECXyjdCh4tFtoN575UNIPIt6zaC"
X-Provags-ID: V03:K1:J+9xYgBkvEiLwbiKPbO+O6p1ALvUQrvgRLBhjsEuhl8s0W1uPZZ
 Gl+4vGrBjZfWv7zSQbgfcDBh451bu1cucjvFlhd3UMS/pLvI9poX69spMsUriMIku4V6KOH
 2M7ZpPz44MPdyQxsCHJly6udXrfmlbIe5voZrDZqMYpH30vWtZsAw/djMzqPo6q9aLu0GdI
 l1tJJvOb+Pe9sdbRT0MRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y5V4noDGCfg=:M/XFAQmEzOcToK8qlrn/jw
 McaUUn1f+CP4FfTxf53Gq47ZhRriorGjgzuoUbDh/M+yNuBiAbD2wheegfvnaaFKrp9GMAwq/
 /awdyeAiKRBkDl3OKzmoBqsBcdjSru6e5GDDMPtxzDIufvcvFWvUbA5tvYOmX+NwP+LsonW5u
 SMjXx+3y/AZSXWqQudVSuz0zvDG72Oh46LNnmZw/rT5B9/OSXiF2a7/+NfexnRUnR+fFlFXWy
 08eW7EmrexIh/rQoLZMdPHcGzCyh5/pHVNzE/UFhqDHHZmP1I2pjjmIuJl2FZJGVvPOYcq3Xn
 +g/qiKnElG/pzySajfSH4+yAPnke23cduwbuRvH01nD+g7m1ej5irUpkafbw5QKQn4jvKptZv
 ZCgPsiK3N/j072+HR5oCFR0EwC3ESSgi42kdX0aXVRIwWjgRECz7GPRPVb2avlVVA4lMht4Cb
 MRa8lZukVdXJuZoqAkkQQ7wtfSzPBDJqlct0wMk7mkiTWHhHZdnHrgvaKxCb6C8jfECQVBQzS
 Sb3enHRMHXWtJJ+sO+QqIzdfa7v6epRnXSsmbtXxL5p5IrP2r+PWmYvTyzSbsXNi2qhiNm9fN
 MOKTgWwDgSFx8BDlKyds1Qm16MXTZgpMvWTY3TdrVMI3IiYtZqZK3FcNnGLKzJ1R4r3dIZAzh
 czVW/lHo2uuBQX622SuiG+XYLiAhMZ4aQglxLsK/zLyDGN8E73/sgbva3pqWt1jlYXV/xrBIl
 Pv3L4/8RVAL6Ld5csqoE6biI7N+ep8mLUxHePa4QupDabRMRmczoFQ4MEN30YJgwZ12KgCJ8h
 QT5sCqzm45zAtKxMvHhSBlpacq5odK/zRtfLSUyldrqrhdJ9QvX2PPEp+49QcQ49iBBdcWTA+
 ySuJPjbbykDERIVJhhGS4QJs+uFqtTopZBjXCPfg5+fWM8rtHmnN6G4w6qAAVDJL00wv4BmQz
 3yOzM9U/5Pk07Pqo6rJlqC2WQ5VBsx1iOvmTU3sl+/FJGTepIgGGlxcHvVA9tiHL8X9ll+q3q
 n42NzmrAkcaykzPO1SVgJCfX07xR5DWIJ4lUjkI+WqV2r/SvHASz6WnaE+luNlmQ1z2y/KM7O
 VoTRMQq9OjieXMhzh+/zx43hQLTb4f/akAy4czUr+ixV4uEbjcvsdtOgFk6Chbw0VF1XUcy8t
 +2utXK5B8eNGLDKCUkR0uF9DYqoVX88GZqH1LhWNjCfl3VY2REB2SHJli3/Lqbh1aJfWY/pGS
 9KZ745u1pYOTArF6N
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cFx1aHECXyjdCh4tFtoN575UNIPIt6zaC
Content-Type: multipart/mixed; boundary="gRRQNVHmvDP6tU5PC85fj7kBiG3nderxz"

--gRRQNVHmvDP6tU5PC85fj7kBiG3nderxz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/13 =E4=B8=8B=E5=8D=881:02, Zygo Blaxell wrote:
> On Wed, May 13, 2020 at 10:28:37AM +0800, Qu Wenruo wrote:
>>
>>
[...]
>> I'm a little surprised about the it's using logical ino ioctl, not jus=
t
>> TREE_SEARCH.
>=20
> Tree search can't read shared backrefs because they refer directly to
> disk blocks, not to object/type/offset tuples.  It would be nice to hav=
e
> an ioctl that can read a metadata block (or even a data block) by byten=
r.

Sorry, I mean we can use tree search to search extent tree, and only
search the backref for specified bytenr to inspect it.

In such hanging case, what I really want is to inspect if the tree block
4374646833152 belongs to data reloc tree.

>=20
> Or even better, just a fd that can be obtained by some ioctl to access
> the btrfs virtual address space with pread().

If we want the content of 4374646833152, we can easily go btrfs ins
dump-tree -b 4374646833152.

As balance works on commit root, at the time of looping, that tree block
should still be on disk, and dump-tree can get it.


Another way to workaround this is, to provide full extent tree dump.
(I know this is a bad idea, but it would still be faster than interact
with mail).

>=20
>> I guess if we could get a plain tree search based one (it only search
>> commit root, which is exactly balance based on), it would be easier to=

>> do the digging.
>=20
> That would be nice.  I have an application for it.  ;)
>=20
>>> 	OSError: [Errno 22] Invalid argument
>>>
>>> 	root@tester:~# btrfs ins log 4368594108416 /media/testfs/
>>> 	/media/testfs//snap-1589258042/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//current/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589249822/testhost/var/log/messages.6.lzma
>>> 	ERROR: ino paths ioctl: No such file or directory
>>> 	/media/testfs//snap-1589249547/testhost/var/log/messages.6.lzma
>>> 	ERROR: ino paths ioctl: No such file or directory
>>> 	/media/testfs//snap-1589248407/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589256422/testhost/var/log/messages.6.lzma
>>> 	ERROR: ino paths ioctl: No such file or directory
>>> 	/media/testfs//snap-1589251322/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589251682/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589253842/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589246727/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589258582/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589244027/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589245227/testhost/var/log/messages.6.lzma
>>> 	ERROR: ino paths ioctl: No such file or directory
>>> 	ERROR: ino paths ioctl: No such file or directory
>>> 	/media/testfs//snap-1589246127/testhost/var/log/messages.6.lzma
>>> 	/media/testfs//snap-1589247327/testhost/var/log/messages.6.lzma
>>> 	ERROR: ino paths ioctl: No such file or directory
>>>
>>> Hmmm, I wonder if there's a problem with deleted snapshots?
>>
>> Yes, also what I'm guessing.
>>
>> The cleanup of data reloc tree doesn't look correct to me.
>>
>> Thanks for the new clues,
>> Qu
>=20
> Here's a fun one:
>=20
> 1.  Delete all the files on a filesystem where balance loops
> have occurred.

I tried with newly created fs, and failed to reproduce.

>=20
> 2.  Verify there are no data blocks (one data block group
> with used =3D 0):
>=20
> # show_block_groups.py /testfs/
> block group vaddr 435969589248 length 1073741824 flags METADATA|RAID1 u=
sed 180224 used_pct 0
> block group vaddr 4382686969856 length 33554432 flags SYSTEM|RAID1 used=
 16384 used_pct 0
> block group vaddr 4383794266112 length 1073741824 flags DATA used 0 use=
d_pct 0
>=20
> 3.  Create a new file with a single reference in the only (root) subvol=
:
> # head -c 1024m > file
> # sync
> # show_block_groups.py .
> block group vaddr 435969589248 length 1073741824 flags METADATA|RAID1 u=
sed 1245184 used_pct 0
> block group vaddr 4382686969856 length 33554432 flags SYSTEM|RAID1 used=
 16384 used_pct 0
> block group vaddr 4384868007936 length 1073741824 flags DATA used 96170=
8032 used_pct 90
> block group vaddr 4385941749760 length 1073741824 flags DATA used 11203=
3792 used_pct 10
>=20
> 4.  Run balance, and it immediately loops on a single extent:
> # btrfs balance start -d .
> [Wed May 13 00:41:58 2020] BTRFS info (device dm-0): balance: start -d
> [Wed May 13 00:41:58 2020] BTRFS info (device dm-0): relocating block g=
roup 4385941749760 flags data
> [Wed May 13 00:42:00 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 1, stage: move data extents
> [Wed May 13 00:42:00 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 2, stage: update data pointers
> [Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 3, stage: update data pointers
> [Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 4, stage: update data pointers
> [Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 5, stage: update data pointers
> [Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 6, stage: update data pointers
> [Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 7, stage: update data pointers
> [Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 8, stage: update data pointers
> [Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 9, stage: update data pointers
> [Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 10, stage: update data pointers
> [Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, l=
oops 11, stage: update data pointers
> [etc...]
>=20
> I tried it a 3 more times time and there was no loop.  The 5th try loop=
ed again.

10 loops, no reproduce.
I guess there are some other factors involved, like newly created fs
won't trigger it?

BTW, for the reproducible case (or the looping case), would you like to
dump the data_reloc root?

My current guess is some orphan cleanup doesn't get kicked, but it
shouldn't affect metadata with my patch :(

Thanks,
Qu
>=20
> There might be a correlation with cancels.  After a fresh boot, I can
> often balance a few dozen block groups before there's a loop, but if I
> cancel a balance, the next balance almost always loops.
>=20


--gRRQNVHmvDP6tU5PC85fj7kBiG3nderxz--

--cFx1aHECXyjdCh4tFtoN575UNIPIt6zaC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl67lWUACgkQwj2R86El
/qiAOQgAgeSslRZkTtUYBmEheB+I2iO3BLKvNsjXonrEn4kLqxtb8fpVdypPkw9H
Va2SLv6jCTRsgZfaATIdz5IX6FoSA5HMaEA77RZsu/B3aQzPzIP311oIviX4CcAQ
BgFB1OkcAG3gHIlfmma85KJlbzoSd5oQxmfomTN/lHlUjUgTBmZ6G9+nZaFNPqs/
QIa5yCxbIIfZIeO/BXZulWOUG5o/aWXjhBo7sH4+RY0l20/Ljw+r6IyueTmGhcKX
hEQmNFa0OyPArLY5SPBrghl3/I2WkpPOK56QIpF+Gn1aooLoaKgcUHx0VL2IiuRi
L33+twYQjHUZoWCNqt9duDzC+VlUKA==
=tU+K
-----END PGP SIGNATURE-----

--cFx1aHECXyjdCh4tFtoN575UNIPIt6zaC--
