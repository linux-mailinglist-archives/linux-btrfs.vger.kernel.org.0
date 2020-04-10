Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2541A3D6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 02:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgDJAlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 20:41:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:59541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgDJAlI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 20:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586479266;
        bh=RpjFzDmDALRYDt/hMjeZG7TFjSLqq5S0iuFkHGy70nY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BkyP0xR41ZptyZiTBhgvUMpjWp5UxGGoG5jyBSdU/m4xSMIhMcEnis3UcCXnRmeAP
         x5F+5om9nC6rDQuj0y0OUR4BYUS0O5I3JYJLd+Q7IcvR7yekjM7gz3aFzHR/tqe3Ov
         O+j8BaT9Mz/CV45yG+u+4GCVmoFWjdwDWLwV6HV8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTmY-1jpqGF2MoI-00WXMk; Fri, 10
 Apr 2020 02:41:06 +0200
Subject: Re: Minor corrupt leaf
To:     Anton Olsson <exuvo@exuvo.se>, linux-btrfs@vger.kernel.org
References: <c2adb5eb-e5c1-8377-174c-e2a6e3b4a706@exuvo.se>
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
Message-ID: <0558687a-15a6-a40a-4778-7e9d33bbb6d0@gmx.com>
Date:   Fri, 10 Apr 2020 08:41:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c2adb5eb-e5c1-8377-174c-e2a6e3b4a706@exuvo.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8dbMkDgScsjizzkeaoguhlwiJ5rraxChj"
X-Provags-ID: V03:K1:eszT66dpB5gl+Dy9aIsrbedvLL7AQ0vQYnxUWluhF4XjR8PNc5K
 /mm+Leda/Vtp1U7tHlrVC38q9/jcluGsFvUkVisnbEx+LkG/3pdydB3K9Uqkg3Kg79506Db
 KZkS1PkTd8BDRo0njnhbDDNiCFXcRTK+jDHL4+w8XrwcmU+drxjswDTl+hFa74juvEKA4WJ
 M/46+FXQiDbms9SxMY7Fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tA9MVoBdxCI=:gtGHRRWxTrguIFhp9VCcw8
 xkEudBUKnw0NqC3nNeDH/d18hHsXLtcHwiJ+OjTkroTeZfn7wCxlOb953RhX8S9AVATP1NT3f
 aUNElzt1HX3DHLN/G911ZpHrzUtVbTWowIuCbeUhpv2kxNDgR/aCwQsfR0MNW0YorJvLCTcHs
 rrrvPpehqTIy8z/rYyWPhQpvEa4RsKimNQxfRYqaDOSOdeqclWgoy8RrRf7oRn0wSr2EUslzV
 oh700vAOOf8OWWHFh1TAfmF/i3gszXEyE+Z/NJbLJGgXaQUkBARoAdmN/F9wS8+WQ7+lPqm/W
 FPJTyyNzsi2Dff9+GNI+yqGyBr2o/SfwDkTgM/J7QeN/+Sti1bMVxpnw8zCSOk317fI95RonV
 1+IOgIwea9BpzG5O9deX9ElYk7LtONXuxtEYsewHz7pUYpBa/bMlZJTQmse+HGytpJ8qmaFyJ
 CTBSdWgJObxGB/NlVe1Ao7R4uEjlhShJFNgOdC2pkQaCa5CYya5RdoeFU5pB04HkYQfgdrgN7
 4kGfEVRfeV2D+CMa2XvkifHlC88VA0CWCM/ZNK9txc5f8cXemew8zW2Rz6NEAl+ClRFrZdLuL
 prgGDeCC64N1qCPxaFG6EkRntIloEsCQoaJMUi9BpBJCotSX5fhhyeiB24QQpfACL+kHV4G9H
 A6Aofmts64PxrLHV4CRxnan712kfE09f1fteHW9G/NieNLggdfYYYjDvKtanit3NSCHlIrAiE
 lWVSfDZiPQC5OdUYFGXFMs0pDveRjvNRJd2IOoheiyhvYcjMVUTfXFRWebvXLbNAlndbGUDy7
 EJXV3QMROMVrdIHamdwR7CFg9tRiLnwiAics54bf6XMTb4aSYqdSxOUGI+MpkZZT80k4/MKEr
 Fq9wnzjD+UuKy8vOiB4IT4lXPIPRys9gScbQl/MoqGA82nt9NVidbJUQSpLaaBQc5ZQ7YxMrC
 /YVm8w/zlSjY2r7nQRxl3DtttOwfYX/VGCl+1m9H7yrOMgIbYvAgisRz1Ap9k5zz2BIDedG46
 tqjIZACNDDu2dJ3yAw6HN+T2v3QXsQBHmofnHEUnG2jF+ZAgexh4oqU+nida3GtavUIPVTxHV
 SgPIezrt9q24DDvC2FcpqUyB8/0ku3t/CBBtdcAXPW/ywcW2dMNc5kn6lqsMjGlxLruAfyHCI
 BTfp7T0y5SNMLLf1Ta3oRl7/xrJd/WSJh5S+4POx12S6emRStQO2ne5f847BPO0wJa2n/ixIX
 xZjHnAoTSTaIqVpUp
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8dbMkDgScsjizzkeaoguhlwiJ5rraxChj
Content-Type: multipart/mixed; boundary="NZswPxJ1kbHqVjQ9M8rsdQQHEKLgEeoLX"

--NZswPxJ1kbHqVjQ9M8rsdQQHEKLgEeoLX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/10 =E4=B8=8A=E5=8D=881:00, Anton Olsson wrote:
> So i've had a directory for years (modifed date is 2016 and btrfs files=
ystem was created in 2015-06) that contained 2 unremovable files.
> Like ls would list a file but not be able to show any info about it eve=
n as root.
>=20
> Dir a
> =C2=A0broken file
> =C2=A0Dir b
> =C2=A0 another broken file
>=20
> in b :
> #ls -l
> ls: cannot access '9193E7A71E8820B8D4C0D786AA679FFF2356189D.dat': No su=
ch file or directory
> total 0
> -????????? ? ? ? ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? 9193E7A71E8820B8D4C0D786AA679FFF23=
56189D.dat
>=20
> rm and every other command i tried just said No such file or directory =
even though ls could list its name so i just ignored the directory as it =
is non essential.
>=20
> From what i remember dmesg never showed any errors last time i tried to=
 remove those files. Last attempt was on 2020-03-06 but on old 2019-autum=
 kernel due to broken wifi driver in newer kernels.
> Now i recently updated the kernel to 5.6.0 (own compile based on arch d=
efault linux kernel with minor fix for the broken wifi driver). btrfs-pro=
gs is v5.4 .
>=20
> Today i was listing files in my home directory and got a Input/Output e=
rror on dir a (which used to work fine, it was the files inside that were=
 problematic) and another directory .gnome2 (no idea if this one containe=
d broken files too, never checked before, but i think it did as the backu=
p shows no files in there which it also does not for the other dir a).
>=20
> Dmesg shows these lines each access attempt (always exactly the same):
> [389277.482811] BTRFS critical (device dm-0): corrupt leaf: root=3D259 =
block=3D24071061798912 slot=3D167 ino=3D7742, invalid location key offset=
:has 9223372036854775808 expect 0

This means your INODE_ITEM has unexpected offset.

Normally INODE_ITEM looks like (<ino> INODE_ITEM 0), but in your case,
it's not zero.

Although it won't hurt, btrfs tree-checker, the super paranoid but
reliable sanity checker, would reject the metadata due to the unexpected
value.

And furthermore, this corruption doesn't seem to be an coincident.
9223372036854775808 =3D 0x8000000000000000

It looks like one bit get flipped in your memory, then written to disk.

If the corruption happens after v5.2 kernel, it would be caught at write
time and avoid corruption data written to disk.
But since your fs has long history, the bit flip must happened before tha=
t.

> [389277.495923] BTRFS error (device dm-0): block=3D24071061798912 read =
time tree block corruption detected
> [389277.518900] BTRFS critical (device dm-0): corrupt leaf: root=3D259 =
block=3D24071061798912 slot=3D167 ino=3D7742, invalid location key offset=
:has 9223372036854775808 expect 0
> [389277.532118] BTRFS error (device dm-0): block=3D24071061798912 read =
time tree block corruption detected
>=20
> Disk layout is 4 SATA disks of 3TB each with individual full disk luks =
encryption and then btrfs raid 5 (data) raid 1 (metadata).
> I use 3 subvolumes, / and /storage and /home. Both problematic director=
ies are in /home. I have backups for / and /home subvolumes on a separate=
 2TB ext4 drive. /storage has no backups as i don't have 8TB to spare.
>=20
> I run a scrub each month and last results were:
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 33a10d7b-819b-4a61-b35c-d47738ab698f
> Scrub started:=C2=A0=C2=A0=C2=A0 Wed Apr=C2=A0 1 03:00:03 2020
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fin=
ished
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 70:13:46
> Total to scrub:=C2=A0=C2=A0 7.73TiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 33.37MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>=20
> No other file seems to have access problems (ran ncdu on / which access=
es every file) or read errors (most files are read and checked by torrent=
 program over time as it seeds).
>=20
> btrfs device stats /
> [/dev/mapper/cryptoroota].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptoroota].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptoroota].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptoroota].corruption_errs=C2=A0 304
> [/dev/mapper/cryptoroota].generation_errs=C2=A0 0
> [/dev/mapper/cryptorootb].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootb].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootb].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootb].corruption_errs=C2=A0 426
> [/dev/mapper/cryptorootb].generation_errs=C2=A0 0
> [/dev/mapper/cryptorootc].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootc].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootc].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootc].corruption_errs=C2=A0 425
> [/dev/mapper/cryptorootc].generation_errs=C2=A0 0
> [/dev/mapper/cryptorootd].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootd].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootd].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/mapper/cryptorootd].corruption_errs=C2=A0 0
> [/dev/mapper/cryptorootd].generation_errs=C2=A0 0
>=20
> I did have some checksum errors a few years back so i think most errors=
 are from that. Data was fine but the checksum was wrong. At least I can'=
t see anything else recent in dmesg relating to btrfs.
>=20
> Any clues to what might have caused this?
> And secondly how do i get rid of that broken leaf? (Assuming only those=
 2 directories and their contents are affected)
>=20
> btrfs-progs v5.4
> Linux 5.6.0-arch1-1-custom #1 SMP PREEMPT Sat, 04 Apr 2020 23:33:26 +00=
00 x86_64 GNU/Linux
> Kernel compiled with standard Archlinux settings + minor patch for wifi=
 driver (continue even with communication errors)
>=20
The way to fix it is a little complex, but shouldn't be any burden for
arch user.

You need to revert to older kernel, older than v5.2 (excluding v5.2).

Then you can access the file, either delete it, or copy it to new
location, then overwrite the existing one with the new copy.

You can locate the file by its inode number (7742).

Thanks,
Qu


--NZswPxJ1kbHqVjQ9M8rsdQQHEKLgEeoLX--

--8dbMkDgScsjizzkeaoguhlwiJ5rraxChj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6PwJ4ACgkQwj2R86El
/qg75Qf+L0VfPIfOFYRLlPoNCVW11tgnu0MTjK05OvlQHJgWbsklCqN6wEFmvgQR
z+w7Q5nO/Y1NJRMRFo+voXOFBUtYSjXfspPqn46COwuDjYZFgl8lRgfZQERLqW9N
XploLjErqk8hSGeXwwnHTq+L227E2EONnWD3cLZS65pslJM4GqYa/MzAJfrgqSAG
cV6a+gTxp2DkKh/5imXchBi2DC4g1QaGYuvXjzGysyiSDxVjTfSJuEVpLIEPWp+u
ID8GuyUS+v02uXPw2HZiW4qZ2mZxBPg07rQQJvHjU91gwKsS37Bh1BfDpz51NXwY
CRKBx7AP6NMxZOr81lx+c5to4Zt0Vg==
=duhk
-----END PGP SIGNATURE-----

--8dbMkDgScsjizzkeaoguhlwiJ5rraxChj--
