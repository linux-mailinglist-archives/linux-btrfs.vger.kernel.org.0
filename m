Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0007723F76D
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Aug 2020 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHHLqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Aug 2020 07:46:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:51135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgHHLqE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Aug 2020 07:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596887159;
        bh=4EUb8Han+iseA9MGsqv2d57Fo7VAGdJWWyMG64jGATc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UWc7k1YAVDL0ynXnuKnL8JvSOHqMQ8PKAWdT/5foVjhUOF3vex1j+6w2asBqKUZqv
         NqD3sD/Ulk1vxWPCJQGcjiSRWDeOqKJJrFM28fBo8tBDCBpXn01Wp7vsS+vRNSDuBq
         IdGZKbjA+pO27cJtXMblQH0ki/Kij7h1UmDqMUPg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1kni2d2zL3-017lKv; Sat, 08
 Aug 2020 13:45:59 +0200
Subject: Re: fails to boot with "BTRFS critical (device sda2): corrupt leaf:
 ..."
To:     Lu Pi <lp.contact2@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAEYyJDyMkOBjhhVFbX_CCG0bnWC1i7OGLvPj8tFhntgxYjkRGg@mail.gmail.com>
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
Message-ID: <e194deb8-4126-0ac6-becd-890939c99275@gmx.com>
Date:   Sat, 8 Aug 2020 19:45:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEYyJDyMkOBjhhVFbX_CCG0bnWC1i7OGLvPj8tFhntgxYjkRGg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sqNysJ3SPmEhUVQmGgr7BRuXY06k5f3bl"
X-Provags-ID: V03:K1:/jXmEhoSU9TZI9Di1DFiA1Mai8gBgrIyFYQMNaHd4m+aPFIjnGe
 7vlRYnk0e9CekeuAHiGjxKrfNGbVc24NdGzh/4EcmTMIvKHVxxU8T1YQWuRSAx557tSPEmk
 2zBX2KAH9jALYt12SFvuuPmAJ3qlEVAsxzEpSElyOvQp8xNxqLk8w7QR58nEMEYa9+5GexA
 eRd2Fn6xqD71j1HFeemmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YCoprFG/SFQ=:sb6y3XEQ2DU4MpxawfxXSn
 pWjlluhbEa/s1gVcOTbeIgZghXOtz3JNSLdJnD0X1BlxbNWKzrOC6mat/ajP4bdIqtkp8IN63
 No+uXHOTVtmA5geIofccBLP2GdhFMGJAJE01JAt6PFkx5p/e3zNlyJ6mIQ6LmyBypXuyb/l7V
 WaXtFkdgIxs7HPPLqSev+6oQKMfoQLCEPwYe43dr76d/f9amBXvF1lUbnnCS/qde1fMYzqiQV
 e2k7EglNJ/npYXTqSBlgUQ0BdgVUTEzJDIuRtGDeZ+/wZvsXjsdOJzONcbQLMDEfQYbZonmN4
 Zz4xaG4r3LOEghSyM6bZ8MXdF9Vu099EDHQBSB6iE40mKxg/eMbjw9rt+5F+MDKknSmKH6HUD
 y2yC/hfE7kJSxMO6+4WRbGnKUhfNV0OAN+j96QgipC/mcUyGwVh7HmJMbcljPC8r2fDOaGCF6
 YdNObWM74SeLt4CPO0ZnIcFToFq/cPZYAgY+eqq6gZHEskXzophG3P4ayYRkhJqOvndqSUdWb
 9RUyhzKk6ZQ3cjD39iWTZYzRP9odZNZTil2ETUHVhnbSK5bywM6pMGYon6EkqJp2n3U6/zKwN
 6drtXkZQ2F+LUaWuA+/hISPHmephXo5f0p8mnJ20v24TcOFffrTEOdqWiI6/Bp5Fg9/BFQfjb
 H1dmFrTyRVOxkGLuqUcyS1A7ONgjmHQ649DSEoi3oAZ1fWS7rOKKmgjOMcPzHO0sv2xtzGBHf
 oFCFgUwmVl27WbAFmaMAc4t/WmSp8YiATOWwXxgq9yJUjhVh/uGr8350jpNS31cv6lPspTxhZ
 1g6JF8XvIbkyORGYaQvh6mrBe1FwN5ornqOhq8vdNJ+2f6Q/qOwOXj2zATNdBVPM+n1uarzFd
 s/1caM/nTjwgLpr2dYJYGctAX0q+b8P/OPkbIULkw49p42wi6X5adVDgmy4V6+86Dd6HxTMEB
 CfAjv2YxroHqFHaDvVJd4Uul9+cgdtFZF5uY32Alerf96ePkbySPYqWk6Ut+UVDCKxvcw+W2J
 CZdg/AmB/LBtyZyrylp2iXzCqv7Y+T/QOO8e9mderisy473+PlzXQiGrJj3rzvzwIsCoLW5qe
 wJArxXm8UTB7hKTXcA8Mvd76VncLkP+13XJmsM8+S2IjND5RU2Qqc+RGwMUZdqqUsqv1w4jLf
 QPIXfZHdD5NupTBBr7vpAHnY7H5wDD4oLYe5N277ecYnRLwr5pfmyf+BNbgrdrr5kbxIyL7qb
 dNpCKQ9pIIVQvrL3tCULr3YvW645fRPT+RKUvBw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sqNysJ3SPmEhUVQmGgr7BRuXY06k5f3bl
Content-Type: multipart/mixed; boundary="kFI7QOx8FsFkDfWksGTx8PU1Ptp7a1Lnq"

--kFI7QOx8FsFkDfWksGTx8PU1Ptp7a1Lnq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/8 =E4=B8=8B=E5=8D=885:57, Lu Pi wrote:
> Hi,
>=20
> I have a system that fails to boot, with "BTRFS critical (device
> sda2): corrupt leaf: " error, and open an "initramfs" shell.
>=20
> I did backup /home with 'btrfs restore'. There were a few errors,
> though only on cache files (Google Chrome cache files).
>=20
> Now considering 'btrfs check --repair'.
>=20
> I'm contacting you as recommended here:
>    https://btrfs.wiki.kernel.org/index.php/Tree-checker
>    "Please report to btrfs mail list <linux-btrfs@vger.kernel.org> firs=
t."
>    "Please *NOT* use btrfs check --repair until instructed by a develop=
er."
>=20
>=20
> Can you advice?
>=20
>=20
>=20
>=20
> BACKGROUND
>=20
> - the system is Linux Mint 17
>=20
> - a week ago or so, after a kernel update, the system was remounting
> read-only after about 1 minute after boot. Downgrading the kernel
> solved the issue.
>   - 4.15.0-112-generic brought the issue
>   - 4.15.0-107-generic was OK
>=20
> - a few days ago, something else happened, though I'm unsure, as I'm
> not the user of the system. Possibly any of these,
>   - another kernel update (now I can see that 4.15.0-112 is back)

The kernel update is the direct cause, we added a lot of extra selftest
to ensure we detect problems before it crash the kernel.

The root cause is some even older kernel, which writes some
uninitialized data to disk.

>   - maybe the system was shut down by cutting electricity (?)
>   - could it be also that the SSD drive is failing (?)
>   - or?
>   - though as a result the system fails to boot and the drive is not mo=
untable.
>=20
>=20
>=20
> SYSTEM INFORMATION
> ---
> When reporting errors or asking for support always supply the output
> of the following commands:
>   uname -a
>   btrfs --version
>   btrfs fi show
>   btrfs fi df /home # Replace /home with the mount point of your
> btrfs-filesystem
>   dmesg > dmesg.log
> ---
>=20
> See below, and dmesg log enclosed
>=20
>=20
> ---
> (initramfs) uname -a
> Linux (none) 4.15.0-112-generic #113~16.04.1-Ubuntu SMP Fri Jul 10
> 04:37:08 UTC 2020 x86_64 GNU/Linux

This is a little old, considering how many enhancement and bug fixes are
in recent kernel releases.

Thus it's recommended to use newer kernel, *after* your problem been fixe=
d.

>=20
>=20
> (initramfs) btrfs --version
> btrfs-progs v4.4

Btrfs-progs is too old to even detect the problem, not to mention fix it.=

It should only report the fs as healthy, if there are no other problems.

>=20
>=20
> (initramfs) btrfs fi show
> Label: none  uuid: f813bbe2-0bff-4923-822b-d3f6d6ebbb9e
>     Total devices 1 FS bytes used 55.22GiB
>     devid    1 size 107.98GiB used 85.02GiB path /dev/sda2
>=20
>=20
> (initramfs) btrfs fi df /home
> ERROR: can't access '/home': No such file or directory
>=20
> (initramfs) btrfs fi df /
> ERROR: not a btrfs filesystem: /
>=20
>=20
>=20
> (initramfs) mount -t btrfs /dev/sda2 /mnt/sda/
> [70391.973518] BTRFS critical (device sda2): corrupt leaf:
> block=3D353828864 slot=3D148 extent bytenr=3D242073600 len=3D16384 inva=
lid
> generation, have 9367487224930631680 expect (0, 458036]

The generation is mostly garbage, it's 0x8200000000000000L, just some
random number not really initialized.

This is a pretty old bug in older kernels.

It's the recently added extra self check detecting them.

This can be detected by "btrfs check --repair" after btrfs-progs v5.4.1,
but not yet repairable. (Haven't got a real world report before this one)=



There is a way to workaround this, by locating the offending extent, and
delete it manually.

Firstly, you need to mount the fs with older kernel.

Then run the following command (maybe you need latest btrfs-progs):
# btrfs ins logical-resolve 242073600 <mnt>

Where the 242073600 is the "extent bytenr" in the dmesg output.

There are two possible output patterns:
- The path of the offending file
  Then just delete it.

- No such file or directory
  This means it's a tree block, it's going to be a little trikcy.
  You need to use btrfs ins again:
  # btrfs ins dump-tree -t 402653184 <device>

  Then search thing like this "EXTENT_DATA":
        item 6 key (257 EXTENT_DATA 0) itemoff 15813 itemsize 53
                generation 3 type 1 (regular)
                extent data disk byte 138424320 nr 1048576
                                      ^^^^^^^^^
  Then use that "138424320" to logical-resolve command again, then
  to remove all offending files.

I'll work on the btrfs check repair ability soon, before that, please
use the above workaround.

Sorry for the inconvenience and thanks for the first real world report.

Thanks,
Qu

> [70391.975504] BTRFS: error (device sda2) in __btrfs_free_extent:7000:
> errno=3D-5 IO failure
> [70391.977490] BTRFS: error (device sda2) in
> btrfs_run_delayed_refs:3083: errno=3D-5 IO failure
> [70391.979490] BTRFS: error (device sda2) in btrfs_replay_log:2369:
> errno=3D-5 IO failure (Failed to recover log tree)
> [70391.980588] BTRFS error (device sda2): pending csums is 475136
> [70392.023935] BTRFS error (device sda2): open_ctree failed
> mount: mounting /dev/sda2 on /mnt/sda/ failed: Input/output error
>=20
>=20
>=20
> (initramfs) dmesg |grep 70391
> [70391.723717] BTRFS info (device sda2): disk space caching is enabled
> [70391.723721] BTRFS info (device sda2): has skinny extents
> [70391.763253] BTRFS info (device sda2): enabling ssd optimizations
> [70391.763256] BTRFS info (device sda2): start tree-log replay
> [70391.973518] BTRFS critical (device sda2): corrupt leaf:
> block=3D353828864 slot=3D148 extent bytenr=3D242073600 len=3D16384 inva=
lid
> generation, have 9367487224930631680 expect (0, 458036]
> [70391.975504] BTRFS: error (device sda2) in __btrfs_free_extent:7000:
> errno=3D-5 IO failure
> [70391.977490] BTRFS: error (device sda2) in
> btrfs_run_delayed_refs:3083: errno=3D-5 IO failure
> [70391.979490] BTRFS: error (device sda2) in btrfs_replay_log:2369:
> errno=3D-5 IO failure (Failed to recover log tree)
> [70391.980588] BTRFS error (device sda2): pending csums is 475136
>=20
>=20
> full dmesg log enclosed.
> ---
>=20


--kFI7QOx8FsFkDfWksGTx8PU1Ptp7a1Lnq--

--sqNysJ3SPmEhUVQmGgr7BRuXY06k5f3bl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8ukHIACgkQwj2R86El
/qgQvgf/Qz2tYz6/BqDBHf04NOuqRvz135VlzRO8Y+dvVmFbuuRwYKyiHW5f1Qzz
TkIpGGNRqoAZ8mA7hURWvRm5CjvzeaixAbyDdzWZqNzpAmDPT3FBNCu9lppUZsFq
1L9zsbkXPnbMPaez8eyEZdGt6kJU1CUXGhAA0tm+M4zHLvwrH29aRC//0je2UnIL
pX4jttfZt+KI47gwv47uD2Izu8lWGwT3S7g1pu5V1cFJyLB/PHsBjXJytR8pH09k
gHDTFzcEc5g3B+PKnM1C/HswSjElfSIba+ow4UOOOwl39q4QysLGowgki88lxYsS
A+9vJGBxwUcpp1udJ0uycEfdWckvew==
=q7Zp
-----END PGP SIGNATURE-----

--sqNysJ3SPmEhUVQmGgr7BRuXY06k5f3bl--
