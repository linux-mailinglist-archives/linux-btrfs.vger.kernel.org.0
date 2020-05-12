Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD61CEABD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 04:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgELC0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 22:26:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:38839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgELC0p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 22:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589250402;
        bh=4mI/TXs6VVcgX2aowoAQ15s6ucLfLPECS6xMWEBXiIg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bKkJ0yE6oSTwqNrGSXxW92WPscsIMFHTSWju6zWR0sgIy+cS5j+7t5sGh15LudADM
         Pkrw5CgGGYrEMILQmOuet6yS8OXG196vSq7cqNZocm2htbvLhxIDNuqUYglCY805tL
         G7WFuK70ZcXqgpYpnJvWCSZqqg/TMO1fwyN7l2hI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bSt-1j7tsQ1q4Z-010cXo; Tue, 12
 May 2020 04:26:42 +0200
Subject: Re: Help with unmountable boot volume
To:     Jason Clara <jason@clarafamily.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <14907AA2-4E26-4025-945E-4BCB87A32254@clarafamily.com>
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
Message-ID: <1b10886e-c2ec-a301-99e5-34a284e06bd8@gmx.com>
Date:   Tue, 12 May 2020 10:26:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <14907AA2-4E26-4025-945E-4BCB87A32254@clarafamily.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RDb2HCE6z1YklXWPp7Tj5pqW0IzZrmfJu"
X-Provags-ID: V03:K1:f16KZC8UvvlJ3iGtDaUKOmW0Qq0KTUTQWFVIctZv80ZmULXCMH4
 Sxp2TUjKJ6vGbE3bsmReRFqKYGkfTN5ms2GJfCR6LQCDA19/ftYv8Q3+U3WxMyWRRGputQ1
 JGlXX/LyaRksWNKbatTc0hKHSCw+t9lEgf4sxh64iTbYqVxMLneEm0maU6MzSHazrLaHQOL
 CdXz5antGMjJ82BLp73Ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNl84Qr+pa4=:DDUJ4zgAMjBM4BN2F+ZTA6
 GJULZQrKpQQ+TOrtXNItDQRSNB0GfvtpBPGItfa0Rba0FfNAogr3nsTg9utavTVupVyvq+gQO
 q6gw71ACicIByzu48kZkZk2zTNao4wdbxCLp4I7iksT5W3Hp7l6oFmoowqCEcgWWoJweYlbyv
 pw4mAB5e+EYjgA/LCexY0anZQX0P5MVwgufRKG0DqNSr9FYCORVqLeQ93nTswPqIz6bKdz4/n
 6o6rwAC/CM06dDNBYEYZm/zFhuFKdhx+M8CFXa7ro65ysCS6x10qK+HTRLzaUcQviX8+zuRW9
 yNF0GTkjEWc2HKWjFkePBwRWlksXPpwKPsEOEXFPw55/vfkv6ax7ISvw2BPIucAMg2KK8W8Qz
 8vFUQbfCFMnZoiwO3pfevF5YnAv5nlM7leQBQiH8OZYQma61kDzZlAe83fPVA0BFC58kHPyxU
 z7ckSGPHDHx6Vvi6M+IaieclM0Wgri6KM13/ujcXBOtL/s8pUxOQD+a57lXaSIUWoJUr2kk7E
 6KjxJtf/3g5x/EnNC+Aof+4IRs9F2OLwrlC8rmsnZzZyCeJUML314SJXxSChWKpdDtkZmWu3h
 NZegf+7jqWyNygM2jkMSs/iBL4FO7Jh6vr1QbhGLAXiM28nMsLK6SQjD7S9/bGD2CHLdpAMYu
 yKMz1RTKPpLBqw87us+6rtsqYryLbj0P79TMXwLwXRqQTaPaKwvihdlUqJMOxXvwQNorOA88B
 E8EwZ2glXcfxB4akv7ONRjmfDO+lglEP3vSsWJq/TLdTggctMyNyDq466UaPdLGnFzDjm8q2i
 jq1GQ2S/r9L6Y+c+wzANNA/IpEl5TCwNnoPl90gZA7p+OwqxLe/3kDzp6i2ZQacRbEVjyF87/
 zLBWWjcHeyszTrVMdA4APBbhE4MzHsQmcoVDFim3AiJREW/RaUxPZyejamw/XoWv1vRqD6Kwf
 L5M0wVZrFj1WWskI6qVbpySQJq4FtF7+3rovL70/6hq+coFiAVQ2ndOUgVCoJU4nj9B9odjAR
 TnngMKclrUhzvvRaRdYEdlvtWJkjKWHra4JZZM1xIRgKMNxvs23iqJx1pQYE1G0QwBcL22PeR
 Nf+Ql1r2G9y1vHFsGYTJCRk22tCcpEFZg3hJxt4Ee4z+5YHUOWn9NiTn3UXGJgXnrI3tCmVic
 WR9QdGRU8lUrHNWvgmPsVzJxZAPyX+zY70cgMPNS9INXeiB9c7rkoQAJO+Lqx8SYFVuqAq4XH
 gFytn13NWsw9Y5vsP
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RDb2HCE6z1YklXWPp7Tj5pqW0IzZrmfJu
Content-Type: multipart/mixed; boundary="ZFoUrSe8Bua4sW2PQNHWxNRaUzDFgPzUS"

--ZFoUrSe8Bua4sW2PQNHWxNRaUzDFgPzUS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/11 =E4=B8=8B=E5=8D=889:11, Jason Clara wrote:
> I woke up this morning and my system had crashed and my root filesystem=
 was readonly.
>=20
> Reboot failed when mounting the root filesystem, and now my system will=
 not boot.
>=20
> I had a USB I setup for recovery and booted into that and to help with =
recovery but I am currently stuck.
>=20
> Some background into.
> Root file system is RAID 1 with two 1TB drives (Both M.2 one is NVME an=
d one is SATA)
> Original system is Ubuntu 18.04 with kernel 5.5.7 and btrfs-progs I thi=
nk was version 5.6
> I think last scrub on the pool was maybe 1-2 months ago.  But sure exac=
t timing.
>=20
> My recovery environment is ubuntu 20.04 with kernel 5.6.7 and btrfs-pro=
gs 5.6 and that is what I am running under at the moment
>=20
> When I try to mount the filesystem I get the following error.
> boot@boot-live-usb:~$ sudo mount /dev/sdm2 /media/root/
> [sudo] password for boot:=20
> mount: /media/root: wrong fs type, bad option, bad superblock on /dev/s=
dm2, missing codepage or helper program, or other error.
>=20
> With dmesg showing
> [Mon May 11 08:56:47 2020] BTRFS info (device nvme0n1p2): disk space ca=
ching is enabled
> [Mon May 11 08:56:47 2020] BTRFS info (device nvme0n1p2): has skinny ex=
tents
> [Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): bad tree blo=
ck start, want 2728265449472 have 5440864628575810330
> [Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): bad tree blo=
ck start, want 2728265449472 have 0

This means both copy is corrupted.
Furthermore, the second copy looks like being completely trimmed.

Are you using discard mount option?

> [Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): failed to re=
ad block groups: -5

Again, extent tree corruption.

Normally we'd recommend to do restore (already done), or go skipbg mount
option (out of tree, need to compile kernel).

But considering the data loss is from wiped tree blocks, I believe it
won't be the only corruption.

> [Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): open_ctree f=
ailed
>=20
>=20
> Trying a readonly check on the filesystem gave me the following error
> boot@boot-live-usb:~$ sudo btrfs check --readonly /dev/sdm2=20
> Opening filesystem to check...
> checksum verify failed on 2728265449472 found 0000008B wanted 00000017
> checksum verify failed on 2728265449472 found 000000B6 wanted 00000000
> checksum verify failed on 2728265449472 found 0000008B wanted 00000017
> bad tree block 2728265449472, bytenr mismatch, want=3D2728265449472, ha=
ve=3D5440864628575810330
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>=20
> I tried a restore (with -io options) to at least get as much data as I =
could off just to be safe and it finished but there was a number of check=
sum errors, bad tree block error and loop errors.  So not sure how good t=
he backup will be.
>=20
> Any help would be appreciated.  I have backups so I could format and se=
tup the system again, but would rather not if I don=E2=80=99t have too.
>=20
Another very dangerous try is, btrfs check --init-extent-tree.

But it won't end up well due to the data loss.

Thanks,
Qu


--ZFoUrSe8Bua4sW2PQNHWxNRaUzDFgPzUS--

--RDb2HCE6z1YklXWPp7Tj5pqW0IzZrmfJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl66CV4ACgkQwj2R86El
/qi4RQf+LOQ4KiDiz9R8F5aI2BHo6VmnsFlRAamyWpNsAcaGJYm18OloKL52YF4j
+4CpZ1FdP6v1Uk0RWi0d2/BCe5fMJbze4iGQHLGbM0CxORcZTdlAGf6Ff42GlFOd
6brMaiCY3w+lOdHf7/kfnCDQDf2HIwhuXvvtJTLV6qC/WztGjAY1V6kxcL8I9HUw
e7r7acBjR75CA1bdizGqKv/xePX0jb1lUBvipdrU42iytVuEERbsHw7U1Ke5L7u0
LiAS/ZtohCXXVvBCRloWkV8FBNgn4BSkKQkE7PlwPazylSmczaZyvwivhxMCnqMQ
yBMHBO1cW+9deVdxUoppJprqIiddlw==
=MX0b
-----END PGP SIGNATURE-----

--RDb2HCE6z1YklXWPp7Tj5pqW0IzZrmfJu--
