Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E86210177
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgGABae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 21:30:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:54025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGABad (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 21:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593567029;
        bh=/qX48BsP/lfoQ9/Tqc8ctXWtWAp/htzmDMnA5X+9T/I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JI7MbeDPIipQ+14otxvY9dKdy5PV1LJI78G4tXcGeMgfz4iBfK5vixsjDIcpW7xzu
         oogDaDzJUNJ91bIDE2nqH2ClFnq9Pv7cA2lu8d24fnOLWXGaWVZ7YVvgq4D5krnLG+
         T4iKq9hEspYfSJGJIErxtIjWfuG2SCv5GfdajJPg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLR1V-1jXwrH17kB-00IQdy; Wed, 01
 Jul 2020 03:30:28 +0200
Subject: Re: first mount(s) after unclean shutdown always fail
To:     Marc Lehmann <schmorp@schmorp.de>, linux-btrfs@vger.kernel.org
References: <20200701005116.GA5478@schmorp.de>
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
Message-ID: <36fcfc97-ce4c-cce8-ee96-b723a1b68ec7@gmx.com>
Date:   Wed, 1 Jul 2020 09:30:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701005116.GA5478@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gKWEk8WbviGQAsWlLysUhkuywARbSJae7"
X-Provags-ID: V03:K1:I6BvqUWEPVuR6c/TOodZVJdfEpaaIbsH6WO5XQiolYyejj9+A2T
 QPtzUguJnz0knLxeHme/PcIyJMhWneMbk7Qc1cuAdy4eFo8PN42/soh88+m3gVbTKkFwkuA
 OiBEd1HpMMokh17aB2tE2hc9qdiJp/9RbYwfQ1kXRl4xZ8TrfKTiRkae4pf467t2FwXESnh
 XMG4pHDrb9ako7tkCX2Pw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZK4VI+MvjjY=:2Nq3X+gVXCPPS7zYhRZplR
 XnXpukiTb9xEE3qYyGrKwnqBP5uoAjOEh8ixjCi9MNCWliTy0xYJpAH3Ac6qwsk2PiWw+FEg7
 9P9mheSvXPPYs8bicvAeUbPshflJo2RbqQE+zUpYOK4LMmAVkMesc7TiBklANqigs4q4pqEWa
 7dKAKiIIn09g6vckFkZolysOpMrL08RenDyqA5THCy/2cSfxr6FjxrTgwGSeYwdHOUuPZZ/jn
 3HF7OG15pXn0imSdILqj1wPWdJP16LMgR+iCrs1NjyCbfj+4h2UshMg0IGa71ReV7KvyOooY3
 DW8GuM4wF76JZlSXpu+BK/UgQ40UjL4tvYQ9w4izpQGOHkhntAIJpmkfEz5rgoZrutirLNMrN
 squMaD0kRUe8+iKIOiSag8MEN3LvOpLt1SN5fqke+6ftV6/qvwDBozuxKvLci6s6avusEqIZM
 nDtbfRRSq6hTFPUz7H+9E4HceYgDRaUH3FiiKpLBfoTc57PMS4hobJai9mtb5TdJ2C4ctiLVd
 2qrL8t+jIsi/4qBhin+WCdXUdRDQ/aQh0Eyw2in+xbfNm5LOfUIxBvhgCxrno2aSLE3IJEPkp
 VSCtgC+epvKwCsfnWyO6bifcUmn7YJkfPqaYqpr2EtIV2YHxUGLvyYVrdoNpUoFVtDU9mff6w
 NSrJG0wKg14vve+fxZsyLT46ArYuQcOQp0dIcKxrdyuCvzzez5XCLAy+HjIPRbXGA30chjW3T
 0sE5nDe/DZvYKH1WReXIxP5yuUYgrLbcw1JF1yciLTMeCAKKbWFia2lMM/BbtN9bkt1jBWnDr
 MyecJ1o5BxLm1WU7T6N1jOwUH4cCPNtoS8FhBoroheonjZbhNmjTfNJYtahi38dQ+OQDseu/p
 eH9F8QRFU+/eMw91jMOtmthIW6kxrXy7IutRM22eak8sbXaHAekKcETcryNRO9C1BMoPy644K
 AaZ+7lxvn86T3/zL0nlnZr71JpAIYFZinsg/lqoKGDdL1wr+P4TGnOr180dFniyu46oaMpYKD
 RdcOAAAL0cZw11ow4sF9nYb441MSz8hbKNxq/UPHrbIaQYkzx5Ks5RlkTzpMuMRQgYnIGhtg5
 uOEOxfCvDDxuGb/VGLBwdlfgB4FdUECPFoSlR4jumv5e+VBEGA8w7rjtp8GbXlcTM3BkLfWr0
 B0+i/5uBbRJWVeOVPHrJXpmRPTQoxDfE2AI/5SS2GZriWx0tXp1VxxqhtyqtAmUG0w7+Rh1q8
 Chk6gwBrMoSQtW78vaar+0amaNmQl2+Hh6Ex41g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gKWEk8WbviGQAsWlLysUhkuywARbSJae7
Content-Type: multipart/mixed; boundary="08DbF6HKz9SjTLNhu8SbHDtu3guhu1QQS"

--08DbF6HKz9SjTLNhu8SbHDtu3guhu1QQS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/1 =E4=B8=8A=E5=8D=888:51, Marc Lehmann wrote:
> Hi!
>=20
> I have a server with multiple btrfs filesystems and some moderate-sized=

> dmcache caches (a few million blocks/100s of GBs).
>=20
> When the server has an unclean shutdown, dmcache treats all cached bloc=
ks
> as dirty. This has the effect of extremely slow I/O, as dmcache basical=
ly
> caches a lot of random I/O, and writing these blocks back to the rotati=
ng
> disk backing store can take hours. This, I think, is related to the
> problem.
>=20
> When the server is in this condition, then all btrfs filesystems on slo=
w
> stores (regardless of whether they use dmcache or not) fail their first=

> mount attempt(s) like this:
>=20
>    [  173.243117] BTRFS info (device dm-7): has skinny extents
>    [  864.982108] BTRFS error (device dm-7): open_ctree failed
>=20
> Recent kernels sometimes additionally fail like this (super_total_bytes=
):
>=20
>    [  867.721885] BTRFS info (device dm-7): turning on sync discard
>    [  867.722341] BTRFS info (device dm-7): disk space caching is enabl=
ed
>    [  867.722691] BTRFS info (device dm-7): has skinny extents
>    [  871.257020] BTRFS error (device dm-7): super_total_bytes 85897668=
1984 mismatch with fs_devices total_rw_bytes 1717953363968
>    [  871.257487] BTRFS error (device dm-7): failed to read chunk tree:=
 -22
>    [  871.269989] BTRFS error (device dm-7): open_ctree failed

This looks like an old fs with some bad accounting numbers.

Have you tried btrfs rescue fix-device-size?

Thanks,
Qu
>=20
> all the filesystems in question are mounted twice during normal boots,
> with diferent subvolumes, and systemd parallelises these mounts. This m=
ight
> play a role in these failures.
>=20
> Simply trying to mount the filesystems again then (usually) succeeds wi=
th
> seemingly no issues, so these are spurious mount failures. These repeat=
ed
> mount attewmpts are also much faster, presumably because a lot of the d=
ata
> is already in memory.
>=20
> As far as I am concerned, this is 100% reproducible (i.e. it happens on=
 every
> unclean shutdown). It also happens on "old" (4.19 era) filesystems as w=
ell as
> on filesystems that have never seen anything older than 5.4 kernels.
>=20
> It does _not_ happen with filesystems on SSDs, regardless of whether th=
ey
> are mounted multiple times or not. It does happen to all filesystems th=
at
> are on rotating disks affected by dm-cache writes, regardless of whethe=
r
> the filesystem itself uses dmcache or not.
>=20
> The system in question is currently running 5.6.17, but the same thing
> happens with 5.4 and 5.2 kernels, and it might have happened with much
> earlier kernels as well, but I didn't have time to report this (as I
> secretly hoped newer kernels would fix this, and unclean shutdowns are
> rare).
>=20
> Example btrfs kernel messages for one such unclean boot. This involved
> normal boot, followed by unsuccessfull "mount -va" in the emergency she=
ll
> (i.e. a second mount fasilure for the same filesystem), followed by a
> successfull "mount -va" in the shell.
>=20
> [  122.856787] BTRFS: device label LOCALVOL devid 1 transid 152865 /dev=
/mapper/cryptlocalvol scanned by btrfs (727)
> [  173.242545] BTRFS info (device dm-7): disk space caching is enabled
> [  173.243117] BTRFS info (device dm-7): has skinny extents
> [  363.573875] INFO: task mount:1103 blocked for more than 120 seconds.=

> the above message repeats multiple times, backtrace &c has been removed=
 for clarity
> [  484.405875] INFO: task mount:1103 blocked for more than 241 seconds.=

> [  605.237859] INFO: task mount:1103 blocked for more than 362 seconds.=

> [  605.252478] INFO: task mount:1211 blocked for more than 120 seconds.=

> [  726.069900] INFO: task mount:1103 blocked for more than 483 seconds.=

> [  726.084415] INFO: task mount:1211 blocked for more than 241 seconds.=

> [  846.901874] INFO: task mount:1103 blocked for more than 604 seconds.=

> [  846.916431] INFO: task mount:1211 blocked for more than 362 seconds.=

> [  864.982108] BTRFS error (device dm-7): open_ctree failed
> [  867.551400] BTRFS info (device dm-7): turning on sync discard
> [  867.551875] BTRFS info (device dm-7): disk space caching is enabled
> [  867.552242] BTRFS info (device dm-7): has skinny extents
> [  867.565896] BTRFS error (device dm-7): open_ctree failed
> [  867.721885] BTRFS info (device dm-7): turning on sync discard
> [  867.722341] BTRFS info (device dm-7): disk space caching is enabled
> [  867.722691] BTRFS info (device dm-7): has skinny extents
> [  871.257020] BTRFS error (device dm-7): super_total_bytes 85897668198=
4 mismatch with fs_devices total_rw_bytes 1717953363968
> [  871.257487] BTRFS error (device dm-7): failed to read chunk tree: -2=
2
> [  871.269989] BTRFS error (device dm-7): open_ctree failed
> [  872.535935] BTRFS info (device dm-7): disk space caching is enabled
> [  872.536438] BTRFS info (device dm-7): has skinny extents
>=20
> Example fstab entries for the mounts above:
>=20
> /dev/mapper/cryptlocalvol       /localvol       btrfs           default=
s,nossd,discard                  0       0
> /dev/mapper/cryptlocalvol       /cryptlocalvol  btrfs           default=
s,nossd,subvol=3D/                 0       0
>=20
> I don't need assistance, I merely write this in the hope of btrfs being=

> improved by this information.
>=20


--08DbF6HKz9SjTLNhu8SbHDtu3guhu1QQS--

--gKWEk8WbviGQAsWlLysUhkuywARbSJae7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl775zEACgkQwj2R86El
/qiP/gf+P341vbZYqEUM0+uTicl9Ox/+ublKBGDqU67EuMsF6TdO09t7oS9EdhxO
PsfoB9mWyHk/SlR4M6e8/R0HR1Qbd3WA/hj+y47NcsWIw6FEnwUPvf+EobX7k1k2
hyPGyjqoi53Z3lVf0peXBbM/T0BDrJs+8cX1+nhSaXEbcQwE3B0If6/dYryLsNEG
/qh7hjfGRsWVZgSUCuZmiPFMCq7flYZyNPW/RnTCSXpJ8hNpmo0Y5doxgrGM1uoy
RS19hj3FVLQrQXh6OnIbEcvG+qjR89/Md5JNFhdjTzH3saEpwm8DaCb0IAweLOSh
RCzHIeQbzyghKWW7MYkb3yyrcusk7A==
=rhsv
-----END PGP SIGNATURE-----

--gKWEk8WbviGQAsWlLysUhkuywARbSJae7--
