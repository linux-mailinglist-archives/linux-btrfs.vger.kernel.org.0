Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9911E175196
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 02:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgCBBsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 20:48:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:57543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgCBBsc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 20:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583113709;
        bh=AaboO24sazybnV79CuB9eYSLlkgvelWQ89Lbo9XxZPs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PKS3HIvSwaNgYxykxz4U0hKQDuq/S7oZ9stjZQUfPsGCtEHsijUxBzwhj+B8fiygj
         ppLpAKP5t/l0SBfUNqugBRZL/lxOxiSoy127Pea2LMfdfJBRR+uM6TNWLs0y1i4fmy
         Om1eWfFhePLlKJUDzmm/FboSQoQ+IEwsuYzA2PDg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mBQ-1jVidc3aQe-0134dV; Mon, 02
 Mar 2020 02:48:29 +0100
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Rich Rauenzahn <rrauenza@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
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
Message-ID: <0894d268-0c7b-82e1-d28a-ea72e91f4b18@gmx.com>
Date:   Mon, 2 Mar 2020 09:48:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MBGwoRYWpyvUziafOr7201yJQl9xKN9W8"
X-Provags-ID: V03:K1:E1ezvlw2rc88d9KDP9K+TxO27At5aEU+g+vHSAFXJV6oCoR30pE
 B/2LzLMpAJKsfTcENPFoRWzAv+Rp2w2yD7W30SdX7nMxlJ0WIho3TDKnUvlNOqPSgXkDh1m
 +byl3hlLz6bl9ZOfa7Jo8NSny8xTcy8HzxuYwcTw4tg6KGtydNlZNOcwz0CAAgDiP5gz3X0
 OFCIAVBATHGJz98IrPBmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8gaEwGUdX+Q=:wjyUYOYlpkigWzidh+zqEb
 xsh6VA/2DTf4VH7q8vXTdmhmaG1y/bTYEMjM0X7R5iJKeXTZle7VATvqAXqoDwgCM7AtbRUAe
 NpammIiThh9yLUO6rWQ2SSoP4QPNqnnWrgIqoROvphgGP5vrMU3JvCrpKsiZz4mw0jLtuYO64
 j4V6jNPMiDGFWIgb9aIqrwzyBlVM3vETyVA+nTzC+DGdr627/NuBmdStkc6+tUQHaTMl+/DqH
 L9qhsJ0U7YvYwYiemcnUJQ8oMnWbdkxgJ/S9+Lvv+eEKWiOPgjk77wKkKWugEaMUMvA18PB3/
 yEKJBgK/tSr6a545zlmHekWgIsjbxjeEjcHtu+0M4MvCbCCdgHoW4cEs1LAuAN+LgyAVVHxRm
 /qio16Ru3xs8ZWXudJwe0V3vbAMjfjPklitRfMTBq/cQ8nfwAcewdBadNHJI+j211Vpp4YJ5V
 y6anNxlucg0uPn8Ow0D0eVAb8RaHz5mt1GOrtFiRw1pE3noQnHD2PfBf6xzcbNViL6bOr0czq
 xH3AxwfneaO6jcOo0M8dLcLPIG7/p2KMQUgMGLiGMgzyd7g3eNrXHDOQdW37gWdjokogXlwQY
 zt3tFQqSB2oHzxa1XR5m+zcA/6p5Z8aU+1ghjoZU9nEtA5ucgB8mgpvbF4L37JTjqfKm8GmFj
 VY58xZi6xvmdlwz3q6u+Xjrx7MyhdewwfY3jM4qNhnu5cUhJ7N7Uw0h7nKpDTX9GAB5rj2kL2
 WD7V1gXnvCXxbB9I1xLmm7kYQW7CMgWheutWSsMX7yfsqK2Uty7utGa3SgWmcQO+a8hqgBubV
 fRUDPDjVDB6auk4DYa8i9KnweSy/q6datXC1gCMjtfQ3q1uR1Mb8LQeI8fUt5UrdTCqpmnygj
 UVy/erdi8mpIzZKl+SkqThOXyRLB0J3dRJrFLosOkKPhyNlMjZ90rylmfpFrRSRg3k01m4zGg
 aDde3x5yxAXWLEYKVF8QJ/K8nLFiX2F233cN1XWWbigE9ViW/L6vX4gY0Lq79Yzmdjlno4swf
 egCNbbMc80QVBf9GBUD/qowhzYpY3Vt0d3RS0/Vj41Ufjl/1NFevt858EOcXzm8ph0d6vHEB1
 qq4R/buQf5c0HV3YR45E8PcvMg/aFvBAgPodxrY7Z+W4QyI05OL66giLnUfWW2NcZpA8UkdQ+
 ZpGEhDJvKQT6Bun6JWe7VAjlb8vGng8j9OzXTgJVZkVn2Rzpok2JayTixUN2p+bv+bcUPj3u+
 2I4BesEMuADyN48T/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MBGwoRYWpyvUziafOr7201yJQl9xKN9W8
Content-Type: multipart/mixed; boundary="kLHvCLcOrhOINgfC4gIgYnwQ4v1D8WJQE"

--kLHvCLcOrhOINgfC4gIgYnwQ4v1D8WJQE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/2 =E4=B8=8A=E5=8D=884:32, Rich Rauenzahn wrote:
> (Is this just taking really long because I didn't provide filters when
> balancing across the new drive?)
>=20
> Also, I DID just change my /etc/fstab to not resume the balance just
> in case I reboot:
>=20
> /.BACKUPS               btrfs   compress=3Dlzo,subvol=3D.BACKUPS,skip_b=
alance   1 2
>=20
> Kernel version:
>=20
> Kernel:  5.5.5-1.el7.elrepo.x86_64
>=20
> The pool is mirrored, 2 copies.
>=20
> The last drive in the list is the one I added.  I think it's been at
> 8MiB the whole time.
>=20
> $ sudo btrfs fi show /.BACKUPS/
> Label: 'BACKUPS'  uuid: cfd65dcd-2a63-4fb1-89a7-0bb9ebe66ddf
>         Total devices 4 FS bytes used 3.64TiB
>         devid    2 size 1.82TiB used 1.82TiB path /dev/sda1
>         devid    3 size 1.82TiB used 1.82TiB path /dev/sdc1
>         devid    4 size 3.64TiB used 3.64TiB path /dev/sdb1
>         devid    5 size 3.64TiB used 8.31MiB path /dev/sdj1
>=20
> $ sudo btrfs fi df /.BACKUPS/
> Data, RAID1: total=3D3.63TiB, used=3D3.63TiB
> System, RAID1: total=3D32.00MiB, used=3D736.00KiB
> Metadata, RAID1: total=3D5.00GiB, used=3D3.88GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> $ btrfs fi usage /.BACKUPS/
> WARNING: cannot read detailed chunk info, RAID5/6 numbers will be
> incorrect, run as root
> Overall:
>     Device size:                  10.92TiB
>     Device allocated:              7.28TiB
>     Device unallocated:            3.64TiB
>     Device missing:               10.92TiB
>     Used:                          7.27TiB
>     Free (estimated):              1.82TiB      (min: 1.82TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>=20
> $ sudo btrfs fi usage /.BACKUPS/
> Overall:
>     Device size:                  10.92TiB
>     Device allocated:              7.28TiB
>     Device unallocated:            3.64TiB
>     Device missing:                  0.00B
>     Used:                          7.27TiB
>     Free (estimated):              1.82TiB      (min: 1.82TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>=20
> Data,RAID1: Size:3.63TiB, Used:3.63TiB
>    /dev/sda1       1.82TiB
>    /dev/sdb1       3.63TiB
>    /dev/sdc1       1.82TiB
>    /dev/sdj1       8.31MiB
>=20
> Metadata,RAID1: Size:5.00GiB, Used:3.88GiB
>    /dev/sda1       3.00GiB
>    /dev/sdb1       5.00GiB
>    /dev/sdc1       2.00GiB
>=20
> System,RAID1: Size:32.00MiB, Used:736.00KiB
>    /dev/sda1      32.00MiB
>    /dev/sdb1      32.00MiB
>=20
> Unallocated:
>    /dev/sda1       1.00MiB
>    /dev/sdb1       1.00MiB
>    /dev/sdc1       1.00MiB
>    /dev/sdj1       3.64TiB
>=20
>=20
> Processes (I also tried a cancel, which is just hung as well)
>=20
> 4 S root      3665     1  0  80   0 - 60315 -      06:45 ?
> 00:00:00 sudo btrfs balance cancel /.BACKUPS/
> 4 D root      3666  3665  0  80   0 -  3983 -      06:45 ?
> 00:00:00 btrfs balance cancel /.BACKUPS/
> 4 S root     14035     1  0  80   0 - 60315 -      Feb28 ?
> 00:00:00 sudo btrfs filesystem balance /.BACKUPS/
> 4 D root     14036 14035  2  80   0 -  3984 -      Feb28 ?
> 00:59:12 btrfs filesystem balance /.BACKUPS/
>=20
> All four drives ARE blinking, and the process takes <10% CPU, but > 0%.=

>=20
> 2.6%:
>=20
> 14036 root      20   0   15936    656    520 D   2.6  0.0  59:13.90
> btrfs filesystem balance /.BACKUPS/
>=20
> df, while probably misleading with btrfs:
>=20
> Filesystem      1K-blocks       Used  Available Use% Mounted on
> /dev/sda1      5860531080 3906340128        384 100% /.BACKUPS
>=20
> dmesg has a lot of these, and you can see they are issued pretty quickl=
y:
>=20
> [773986.367090] BTRFS info (device sda1): found 472 extents
> [773986.583133] BTRFS info (device sda1): found 472 extents
> [773986.799169] BTRFS info (device sda1): found 472 extents

That's a runaway balance.

>=20
> sar output of relevant drives (10 secs):
>=20
> 10:26:23 AM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz
> avgqu-sz     await     svctm     %util
> 10:26:26 AM       sdb     78.45      0.00   2312.37     29.48
> 0.48      6.64      0.58      4.52
> 10:26:26 AM       sda     78.80      0.00   2312.37     29.35
> 0.94     12.53      0.53      4.20
> 10:26:26 AM       sdc     36.40      0.00    220.49      6.06
> 0.25      7.24      0.85      3.11
> 10:26:26 AM       sdj     36.40      0.00    220.49      6.06
> 0.23      6.74      0.83      3.04
>=20
> $ sudo btrfs balance status -v /.BACKUPS/
> Balance on '/.BACKUPS/' is running, cancel requested

And ironically, currently to hit a runaway balance, canceling is the
primary reason.

So to properly canceling the runaway balance, you need to apply the
latest quicker canceling patchset:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D242357

Thanks,
Qu


> 0 out of about 3733 chunks balanced (29 considered), 100% left
> Dumping filters: flags 0x7, state 0x5, force is off
>   DATA (flags 0x0): balancing
>   METADATA (flags 0x0): balancing
>   SYSTEM (flags 0x0): balancing
>=20
> Oh, and the drive does think it is out of space even though the drive
> has been added:
>=20
> $ dd if=3D/dev/random of=3Drandom
> dd: writing to =E2=80=98random=E2=80=99: No space left on device
> 0+7 records in
> 0+0 records out
> 0 bytes (0 B) copied, 0.341074 s, 0.0 kB/s
>=20


--kLHvCLcOrhOINgfC4gIgYnwQ4v1D8WJQE--

--MBGwoRYWpyvUziafOr7201yJQl9xKN9W8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5cZeoACgkQwj2R86El
/qgb7wf7Bj7GRf1e7JIuYyJHLDtxnOE0Mf4kYi8YGr/r5tDDG81o57a2qeTZEtTo
QAfkY5h8Vxo/IcWR+/U+NadUFpmOx+VwKdSxHoRNbMiWD1x3VUNSQAbKxzK+ef+Q
EhkQPp/RMo2y/9+gQB7I8PhlCL1Ht7abs9msjf/TtYDuvKAHFDdze2nQxENme+ai
xTqu3VQFKudFR0By2ZL9l3Y+Z8IjKsWtzVbQP2kYxixtGLfsZ3+84d3Slriur9Rx
l3pdBujxtpgNeHtNQAYWARlc5SADFFVQ3v3SF0VZALmYadmZmGd9ylNEaNpprYk4
ROwThlHerjntZoQnuiDeejV7I4oU1Q==
=st/n
-----END PGP SIGNATURE-----

--MBGwoRYWpyvUziafOr7201yJQl9xKN9W8--
