Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B832ECD0D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 04:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKBDih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 23:38:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:40939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfKBDih (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 23:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572665903;
        bh=qDtUAqS+MoCExqYTMGtugErILFwLwVSFGS6X+hW0B34=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YSmpf8pWSZDjUrWbUIwz1bPmQPcxv4b9Po4wlznm/tP2JMiOMYI/sFPuyrtSixyFY
         8PP0ayXTBU+HHtUtPTWVNjI3B6V2Wcdr7huM+XvMuj+sdOK5wwQOMmdB/vH6e4MsP2
         Q5xBMlC2+sRd5qA1PoeAbBGjzV1TCqjtcDY4He/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1iBpjT3DsA-00G2ND; Sat, 02
 Nov 2019 04:38:22 +0100
Subject: Re: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593
 btrfs_update_device.cold+0x10/0x1b [btrfs]
To:     Tomasz Chmielewski <mangoo@wpkg.org>, linux-btrfs@vger.kernel.org
References: <0a25bc52b9d3649d499b76d06e0d117b@wpkg.org>
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
Message-ID: <d24256c7-4398-7627-4352-1878af1467e9@gmx.com>
Date:   Sat, 2 Nov 2019 11:38:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0a25bc52b9d3649d499b76d06e0d117b@wpkg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bpdIpP9SqCDO6DLpnCTXNEf4GjerTPkxy"
X-Provags-ID: V03:K1:xTPRrpGP7nIIdHneNJVBPJFnWDjvCsJgQVLL4yr6Gt5riwUSB1x
 LxdnQ8Ah1qyREZSo5mYxlzY0f0TujqkXMVuaNk2ZiJeDzV7mTJBYDwHZMZYwZBB1yux1mbH
 EAcVv0GfAqeS4t9qJdAdAXRBI/WDHkNQN6kdAoO9IBFPHWPFWf0S1N7co1mXTkJgw6rGh71
 zNl74jTS1+WBO8FJINgKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y3cA71UAQfk=:Z9ijltDKxmwMzMUyhrjEAm
 cUtYgGd/ol8lt+ZRR/DpODDvQenHQO+UYvt8YWV3U/zQN4HWP1kXfsOf0hXBzuM83lOsI0+1l
 18bqRF5URi4cZrQ4v+8ZQuxbRPbVGF2yRrkuJt5rG/3blj/fiuvTGLEguFr4l5Z8d+tBUKuWJ
 7wCTF2ooFh1wEfoAMs1q2ClzPbH4zSuGvruKCXux4NVTk/wrDC3hNZMQjfVotJaf27xdis8YK
 8J1ugKsGNuIneHOY13J2kUHIYInRu+zUo/tKC+rG2zf9TFX4gPajsSO98rZSz4avmVF7M9icv
 XglZgC34nqo02GJ3geQy0subJsNHO3bUwiCyyJu4WVxl1fBFIb0YG1mNnCDjYK3wWx70GQsLV
 w/gjkIdPtqHcWhZFh/CkRYe2cciOZAe7/ugSFKqP6RelhaocQtUlxuJq7IEc7i61r8bpXiRSM
 m5HFZokNSq5fbIHXRavJZ1pdbRZRGVbY993VuPx3+FKi9mUBXaylbZC6QqGeyJfP6BGuOLhb6
 TQTfKxUcH232BTpyU7uqI0iqk7Pj3126GyS5aHq79ARHz3BcJcUGVHI0CSl3YqNRCbt9YcWUJ
 ZpMXrPSo2gn/sj5qFnta/Vgqr3jVPiHEVLOoHtUXTzHbUhm/ef7RzNo+Jfeb+4J25xJeZEmm7
 ooJdIzQwhmH75fhZ/yQ+ZF6ZcLt5bIBcX4LH5GE8ayqI0U1IcuGG1VbiKZ8pwy9lZY4/Yh+fC
 40ZvfmKe7kMQm8byMXvI9bx9C/HudNvfWChvU2A8zNyHic+XEBWQc8tMKGYIFRA5f89dSxwRc
 cATVcnbWbC2tWwpq/I/aKonVtQ72rH7CljIWx0qBP4Ws4UJO4FZzd78eKT5qrIUFqYjYidgad
 1/Io8hjoGFQD5mhgiuO0u2qS0uZznl9LowNV5cxUvNWKAUe453OKUIiYy9807VaD+G8oVfEPT
 p9tn85TZqQl7XCUmUvyzMY5OO+Zpi5E8GAtZMBXITXnobOh9vPXOkS9ObnmIJZZIGN9Ea/CC6
 wexY8esFQL/+IfnKnXVrFe9u9uCwTgLidTbaXgzntu1lhIEZc8UUByEs0yHHjHBW6mdRsP+3J
 xIvTXtrOkegRvanLGUZiBiE1qnLGKzcN5IyKL8i9vsBupdElLnlvgKhstO1MfyZ10KckCHG6W
 qm8iFnyw7Ar+p50m2Ki8QeOJnSkmS/AjDoqdMV5hdybo6wR1Xo0Eq/GjCKgdIdn0qxcsPegpN
 mNu4oqAffEhbIpf9WtRGhJx1vaao/lua05L/GkyAnPDQSbvW4kMMWVdNIZ5k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bpdIpP9SqCDO6DLpnCTXNEf4GjerTPkxy
Content-Type: multipart/mixed; boundary="FDD5aHKgHFkQ82dyz9kWJPG7ASrCbjWoe"

--FDD5aHKgHFkQ82dyz9kWJPG7ASrCbjWoe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/2 =E4=B8=8A=E5=8D=889:13, Tomasz Chmielewski wrote:
> I'm getting these recently from time to time (first noticed in 5.3.x,
> but maybe they were showing up before and I didn't notice).
>=20
> Everything seems to work fine so far. Anything to worry about?

This is a warning about unaligned device size.

You can either fix it by reducing the device size by 4K for each device,
or use btrfs rescue fix-dev-size unmounted to repair.

Thanks,
Qu
>=20
> # btrfs fi usage /home
> Overall:
> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.19Ti=
B
> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.19TiB
> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.00TiB
> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.17TiB
> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00TiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (min: 3.00TiB)
> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2.00
> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0=
0
> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (used: 0.00B)
>=20
> Data,RAID1: Size:537.00GiB, Used:536.08GiB
> =C2=A0=C2=A0 /dev/sda4=C2=A0=C2=A0=C2=A0=C2=A0 537.00GiB
> =C2=A0=C2=A0 /dev/sdb4=C2=A0=C2=A0=C2=A0=C2=A0 537.00GiB
>=20
> Metadata,RAID1: Size:72.00GiB, Used:61.47GiB
> =C2=A0=C2=A0 /dev/sda4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 72.00GiB
> =C2=A0=C2=A0 /dev/sdb4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 72.00GiB
>=20
> System,RAID1: Size:32.00MiB, Used:112.00KiB
> =C2=A0=C2=A0 /dev/sda4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
> =C2=A0=C2=A0 /dev/sdb4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>=20
> Unallocated:
> =C2=A0=C2=A0 /dev/sda4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00TiB
> =C2=A0=C2=A0 /dev/sdb4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00TiB
>=20
>=20
> # btrfs fi df /home
> Data, RAID1: total=3D537.00GiB, used=3D536.08GiB
> System, RAID1: total=3D32.00MiB, used=3D112.00KiB
> Metadata, RAID1: total=3D72.00GiB, used=3D61.47GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
>=20
> # btrfs fi show /home
> Label: 'btrfs'=C2=A0 uuid: c94ea4a9-6d10-4e78-9b4a-ffe664386af2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 597.56GiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 3.59TiB used 609.03GiB path /dev/sda4
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 si=
ze 3.59TiB used 609.03GiB path /dev/sdb4
>=20
>=20
> [20419.701419] ------------[ cut here ]------------
> [20419.701546] WARNING: CPU: 3 PID: 9489 at fs/btrfs/ctree.h:1593
> btrfs_update_device.cold+0x10/0x1b [btrfs]
> [20419.701548] Modules linked in: nf_conntrack_netlink xt_conntrack
> nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtable=
s
> binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE
> xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter
> bridge stp llc unix_diag intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4
> crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw
> intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables
> autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0
> multipath linear raid1 e1000e psmouse ahci libahci wmi video
> [20419.701602] CPU: 3 PID: 9489 Comm: storagenode Not tainted
> 5.3.8-050308-generic #201910290940
> [20419.701605] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12
> R1.18.0.SR.1 for D3401-H2x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07/02/2018
> [20419.701672] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
> [20419.701676] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8=

> 0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2=

> ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
> [20419.701679] RSP: 0018:ffffa89400903a60 EFLAGS: 00010246
> [20419.701683] RAX: 0000000000000024 RBX: ffff90bd80633800 RCX:
> 0000000000000000
> [20419.701685] RDX: 0000000000000000 RSI: ffff90bd8e2d7448 RDI:
> ffff90bd8e2d7448
> [20419.701687] RBP: ffffa89400903ab0 R08: ffff90bd8e2d7448 R09:
> 0000000000000004
> [20419.701688] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff90bce73397e0
> [20419.701690] R13: 0000000000000000 R14: 0000000000003f3c R15:
> ffff90bcd7a995a8
> [20419.701694] FS:=C2=A0 00007fd22268df20(0000) GS:ffff90bd8e2c0000(000=
0)
> knlGS:0000000000000000
> [20419.701696] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [20419.701698] CR2: 00007fd2229f1010 CR3: 0000000767104004 CR4:
> 00000000003606e0
> [20419.701700] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [20419.701702] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [20419.701704] Call Trace:
> [20419.701770]=C2=A0 btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
> [20419.701807]=C2=A0 ? btrfs_insert_item+0x7f/0xf0 [btrfs]
> [20419.701846]=C2=A0 btrfs_create_pending_block_groups+0xeb/0x220 [btrf=
s]
> [20419.701893]=C2=A0 __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
> [20419.701936]=C2=A0 btrfs_end_transaction+0x10/0x20 [btrfs]
> [20419.701995]=C2=A0 btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]=

> [20419.702052]=C2=A0 btrfs_check_data_free_space+0x59/0xb0 [btrfs]
> [20419.702099]=C2=A0 btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
> [20419.702108]=C2=A0 ? inet6_recvmsg+0x5e/0xf0
> [20419.702154]=C2=A0 btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
> [20419.702162]=C2=A0 new_sync_write+0x125/0x1c0
> [20419.702168]=C2=A0 __vfs_write+0x29/0x40
> [20419.702173]=C2=A0 vfs_write+0xb9/0x1a0
> [20419.702178]=C2=A0 ksys_write+0x67/0xe0
> [20419.702183]=C2=A0 __x64_sys_write+0x1a/0x20
> [20419.702190]=C2=A0 do_syscall_64+0x5a/0x130
> [20419.702196]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [20419.702200] RIP: 0033:0x47f050
> [20419.702204] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2=

> 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f=

> 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [20419.702206] RSP: 002b:000000c00054f260 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [20419.702210] RAX: ffffffffffffffda RBX: 000000c000044500 RCX:
> 000000000047f050
> [20419.702212] RDX: 0000000000040000 RSI: 000000c0006f0000 RDI:
> 0000000000000026
> [20419.702214] RBP: 000000c00054f2b0 R08: 0000000000000000 R09:
> 0000000000000000
> [20419.702216] R10: 0000000000000000 R11: 0000000000000202 R12:
> ffea2367ffa35605
> [20419.702218] R13: 0000000000000006 R14: 000000001a4c0b00 R15:
> ffffffffe743d8bf
> [20419.702222] ---[ end trace 77f3c728fd91fa16 ]---
> [20419.702282] ------------[ cut here ]------------
> [20419.702382] WARNING: CPU: 3 PID: 9489 at fs/btrfs/ctree.h:1593
> btrfs_update_device.cold+0x10/0x1b [btrfs]
> [20419.702383] Modules linked in: nf_conntrack_netlink xt_conntrack
> nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtable=
s
> binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE
> xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter
> bridge stp llc unix_diag intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4
> crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw
> intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables
> autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0
> multipath linear raid1 e1000e psmouse ahci libahci wmi video
> [20419.702429] CPU: 3 PID: 9489 Comm: storagenode Tainted: G=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 5.3.8-050308-generic #201910290940
> [20419.702431] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12
> R1.18.0.SR.1 for D3401-H2x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07/02/2018
> [20419.702492] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
> [20419.702497] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8=

> 0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2=

> ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
> [20419.702499] RSP: 0018:ffffa89400903a60 EFLAGS: 00010246
> [20419.702502] RAX: 0000000000000024 RBX: ffff90bd80636000 RCX:
> 0000000000000006
> [20419.702503] RDX: 0000000000000000 RSI: 0000000000000086 RDI:
> ffff90bd8e2d7440
> [20419.702505] RBP: ffffa89400903ab0 R08: 0000000000000357 R09:
> 0000000000000004
> [20419.702507] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff90bce73397e0
> [20419.702509] R13: 0000000000000000 R14: 0000000000003f9e R15:
> ffff90bcd7a995a8
> [20419.702512] FS:=C2=A0 00007fd22268df20(0000) GS:ffff90bd8e2c0000(000=
0)
> knlGS:0000000000000000
> [20419.702514] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [20419.702516] CR2: 00007fd2229f1010 CR3: 0000000767104004 CR4:
> 00000000003606e0
> [20419.702519] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [20419.702521] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [20419.702522] Call Trace:
> [20419.702582]=C2=A0 btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
> [20419.702623]=C2=A0 btrfs_create_pending_block_groups+0xeb/0x220 [btrf=
s]
> [20419.702667]=C2=A0 __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
> [20419.702708]=C2=A0 btrfs_end_transaction+0x10/0x20 [btrfs]
> [20419.702765]=C2=A0 btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]=

> [20419.702820]=C2=A0 btrfs_check_data_free_space+0x59/0xb0 [btrfs]
> [20419.702866]=C2=A0 btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
> [20419.702874]=C2=A0 ? inet6_recvmsg+0x5e/0xf0
> [20419.702920]=C2=A0 btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
> [20419.702927]=C2=A0 new_sync_write+0x125/0x1c0
> [20419.702932]=C2=A0 __vfs_write+0x29/0x40
> [20419.702937]=C2=A0 vfs_write+0xb9/0x1a0
> [20419.702942]=C2=A0 ksys_write+0x67/0xe0
> [20419.702947]=C2=A0 __x64_sys_write+0x1a/0x20
> [20419.702952]=C2=A0 do_syscall_64+0x5a/0x130
> [20419.702958]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [20419.702961] RIP: 0033:0x47f050
> [20419.702965] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2=

> 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f=

> 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [20419.702967] RSP: 002b:000000c00054f260 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [20419.702970] RAX: ffffffffffffffda RBX: 000000c000044500 RCX:
> 000000000047f050
> [20419.702972] RDX: 0000000000040000 RSI: 000000c0006f0000 RDI:
> 0000000000000026
> [20419.702974] RBP: 000000c00054f2b0 R08: 0000000000000000 R09:
> 0000000000000000
> [20419.702976] R10: 0000000000000000 R11: 0000000000000202 R12:
> ffea2367ffa35605
> [20419.702978] R13: 0000000000000006 R14: 000000001a4c0b00 R15:
> ffffffffe743d8bf
> [20419.702982] ---[ end trace 77f3c728fd91fa17 ]---
> [32358.499676] ------------[ cut here ]------------
> [32358.499794] WARNING: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593
> btrfs_update_device.cold+0x10/0x1b [btrfs]
> [32358.499796] Modules linked in: nf_conntrack_netlink xt_conntrack
> nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtable=
s
> binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE
> xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter
> bridge stp llc unix_diag intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4
> crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw
> intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables
> autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0
> multipath linear raid1 e1000e psmouse ahci libahci wmi video
> [32358.499851] CPU: 6 PID: 13386 Comm: kworker/u16:0 Tainted: G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3.8-050308-generic #201910=
290940
> [32358.499853] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12
> R1.18.0.SR.1 for D3401-H2x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07/02/2018
> [32358.499914] Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
> [32358.499981] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
> [32358.500002] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8=

> 0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2=

> ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
> [32358.500004] RSP: 0018:ffffa89400e33940 EFLAGS: 00010246
> [32358.500007] RAX: 0000000000000024 RBX: ffff90bd80633800 RCX:
> 0000000000000000
> [32358.500009] RDX: 0000000000000000 RSI: ffff90bd8e397448 RDI:
> ffff90bd8e397448
> [32358.500011] RBP: ffffa89400e33990 R08: ffff90bd8e397448 R09:
> 0000000000000004
> [32358.500012] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff90bb94f828c0
> [32358.500014] R13: 0000000000000000 R14: 0000000000003f3c R15:
> ffff90bb53dbbad0
> [32358.500017] FS:=C2=A0 0000000000000000(0000) GS:ffff90bd8e380000(000=
0)
> knlGS:0000000000000000
> [32358.500019] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [32358.500020] CR2: 00007f3a0089eb02 CR3: 00000003b4e0a004 CR4:
> 00000000003606e0
> [32358.500022] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [32358.500024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [32358.500026] Call Trace:
> [32358.500080]=C2=A0 btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
> [32358.500111]=C2=A0 ? btrfs_insert_item+0x7f/0xf0 [btrfs]
> [32358.500160]=C2=A0 btrfs_create_pending_block_groups+0xeb/0x220 [btrf=
s]
> [32358.500218]=C2=A0 __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
> [32358.500258]=C2=A0 btrfs_end_transaction+0x10/0x20 [btrfs]
> [32358.500299]=C2=A0 find_free_extent+0xb40/0xdf0 [btrfs]
> [32358.500307]=C2=A0 ? generic_make_request+0xcf/0x320
> [32358.500340]=C2=A0 btrfs_reserve_extent+0xe9/0x180 [btrfs]
> [32358.500376]=C2=A0 cow_file_range.isra.0+0x178/0x440 [btrfs]
> [32358.500412]=C2=A0 submit_compressed_extents+0x1a4/0x430 [btrfs]
> [32358.500445]=C2=A0 async_cow_submit+0x75/0x80 [btrfs]
> [32358.500491]=C2=A0 normal_work_helper+0x19e/0x2f0 [btrfs]
> [32358.500535]=C2=A0 btrfs_delalloc_helper+0x12/0x20 [btrfs]
> [32358.500541]=C2=A0 process_one_work+0x1db/0x380
> [32358.500544]=C2=A0 worker_thread+0x4d/0x400
> [32358.500550]=C2=A0 kthread+0x104/0x140
> [32358.500554]=C2=A0 ? process_one_work+0x380/0x380
> [32358.500558]=C2=A0 ? kthread_park+0x80/0x80
> [32358.500564]=C2=A0 ret_from_fork+0x35/0x40
> [32358.500569] ---[ end trace 77f3c728fd91fa18 ]---
> [32358.500618] ------------[ cut here ]------------
> [32358.500701] WARNING: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593
> btrfs_update_device.cold+0x10/0x1b [btrfs]
> [32358.500702] Modules linked in: nf_conntrack_netlink xt_conntrack
> nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtable=
s
> binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE
> xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter
> bridge stp llc unix_diag intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4
> crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw
> intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables
> autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0
> multipath linear raid1 e1000e psmouse ahci libahci wmi video
> [32358.500743] CPU: 6 PID: 13386 Comm: kworker/u16:0 Tainted: G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3.8-050308-generic #201910=
290940
> [32358.500745] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12
> R1.18.0.SR.1 for D3401-H2x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07/02/2018
> [32358.500792] Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
> [32358.500849] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
> [32358.500852] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8=

> 0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2=

> ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
> [32358.500854] RSP: 0018:ffffa89400e33940 EFLAGS: 00010246
> [32358.500857] RAX: 0000000000000024 RBX: ffff90bd80636000 RCX:
> 0000000000000006
> [32358.500859] RDX: 0000000000000000 RSI: 0000000000000082 RDI:
> ffff90bd8e397440
> [32358.500860] RBP: ffffa89400e33990 R08: 00000000000003ab R09:
> 0000000000000004
> [32358.500862] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff90bb94f828c0
> [32358.500864] R13: 0000000000000000 R14: 0000000000003f9e R15:
> ffff90bb53dbbad0
> [32358.500866] FS:=C2=A0 0000000000000000(0000) GS:ffff90bd8e380000(000=
0)
> knlGS:0000000000000000
> [32358.500868] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [32358.500870] CR2: 00007f3a0089eb02 CR3: 00000003b4e0a004 CR4:
> 00000000003606e0
> [32358.500872] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [32358.500873] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [32358.500875] Call Trace:
> [32358.500922]=C2=A0 btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
> [32358.500955]=C2=A0 btrfs_create_pending_block_groups+0xeb/0x220 [btrf=
s]
> [32358.501009]=C2=A0 __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
> [32358.501046]=C2=A0 btrfs_end_transaction+0x10/0x20 [btrfs]
> [32358.501079]=C2=A0 find_free_extent+0xb40/0xdf0 [btrfs]
> [32358.501084]=C2=A0 ? generic_make_request+0xcf/0x320
> [32358.501118]=C2=A0 btrfs_reserve_extent+0xe9/0x180 [btrfs]
> [32358.501159]=C2=A0 cow_file_range.isra.0+0x178/0x440 [btrfs]
> [32358.501199]=C2=A0 submit_compressed_extents+0x1a4/0x430 [btrfs]
> [32358.501238]=C2=A0 async_cow_submit+0x75/0x80 [btrfs]
> [32358.501286]=C2=A0 normal_work_helper+0x19e/0x2f0 [btrfs]
> [32358.501334]=C2=A0 btrfs_delalloc_helper+0x12/0x20 [btrfs]
> [32358.501338]=C2=A0 process_one_work+0x1db/0x380
> [32358.501342]=C2=A0 worker_thread+0x4d/0x400
> [32358.501348]=C2=A0 kthread+0x104/0x140
> [32358.501352]=C2=A0 ? process_one_work+0x380/0x380
> [32358.501357]=C2=A0 ? kthread_park+0x80/0x80
> [32358.501362]=C2=A0 ret_from_fork+0x35/0x40
> [32358.501366] ---[ end trace 77f3c728fd91fa19 ]---
> [49906.088064] ------------[ cut here ]------------
> [49906.088197] WARNING: CPU: 5 PID: 9511 at fs/btrfs/ctree.h:1593
> btrfs_update_device.cold+0x10/0x1b [btrfs]
> [49906.088199] Modules linked in: nf_conntrack_netlink xt_conntrack
> nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtable=
s
> binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE
> xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter
> bridge stp llc unix_diag intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4
> crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw
> intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables
> autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0
> multipath linear raid1 e1000e psmouse ahci libahci wmi video
> [49906.088254] CPU: 5 PID: 9511 Comm: storagenode Tainted: G=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 5.3.8-050308-generic #201910290940
> [49906.088256] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12
> R1.18.0.SR.1 for D3401-H2x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07/02/2018
> [49906.088323] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
> [49906.088328] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8=

> 0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2=

> ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
> [49906.088331] RSP: 0018:ffffa89401233a60 EFLAGS: 00010246
> [49906.088335] RAX: 0000000000000024 RBX: ffff90bd80633800 RCX:
> 0000000000000000
> [49906.088337] RDX: 0000000000000000 RSI: ffff90bd8e357448 RDI:
> ffff90bd8e357448
> [49906.088338] RBP: ffffa89401233ab0 R08: ffff90bd8e357448 R09:
> 0000000000000004
> [49906.088340] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff90bb5373a2a0
> [49906.088342] R13: 0000000000000000 R14: 0000000000003f3c R15:
> ffff90bb42780840
> [49906.088345] FS:=C2=A0 00007fd22258ff20(0000) GS:ffff90bd8e340000(000=
0)
> knlGS:0000000000000000
> [49906.088348] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [49906.088350] CR2: 00007f8cf3721180 CR3: 0000000767104001 CR4:
> 00000000003606e0
> [49906.088352] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [49906.088354] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [49906.088356] Call Trace:
> [49906.088422]=C2=A0 btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
> [49906.088460]=C2=A0 ? btrfs_insert_item+0x7f/0xf0 [btrfs]
> [49906.088500]=C2=A0 btrfs_create_pending_block_groups+0xeb/0x220 [btrf=
s]
> [49906.088547]=C2=A0 __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
> [49906.088590]=C2=A0 btrfs_end_transaction+0x10/0x20 [btrfs]
> [49906.088649]=C2=A0 btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]=

> [49906.088706]=C2=A0 btrfs_check_data_free_space+0x59/0xb0 [btrfs]
> [49906.088754]=C2=A0 btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
> [49906.088763]=C2=A0 ? inet6_recvmsg+0x5e/0xf0
> [49906.088811]=C2=A0 btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
> [49906.088819]=C2=A0 new_sync_write+0x125/0x1c0
> [49906.088824]=C2=A0 __vfs_write+0x29/0x40
> [49906.088829]=C2=A0 vfs_write+0xb9/0x1a0
> [49906.088834]=C2=A0 ksys_write+0x67/0xe0
> [49906.088839]=C2=A0 __x64_sys_write+0x1a/0x20
> [49906.088846]=C2=A0 do_syscall_64+0x5a/0x130
> [49906.088852]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [49906.088855] RIP: 0033:0x47f050
> [49906.088860] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2=

> 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f=

> 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [49906.088862] RSP: 002b:000000c00034b260 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [49906.088866] RAX: ffffffffffffffda RBX: 000000c000048f00 RCX:
> 000000000047f050
> [49906.088867] RDX: 0000000000040000 RSI: 000000c00077e000 RDI:
> 0000000000000026
> [49906.088869] RBP: 000000c00034b2b0 R08: 0000000000000000 R09:
> 0000000000000000
> [49906.088871] R10: 0000000000000000 R11: 0000000000000202 R12:
> ffffe7dcdd518784
> [49906.088873] R13: 0000000000000002 R14: 00000000078dfd25 R15:
> 00000000073b9ee2
> [49906.088878] ---[ end trace 77f3c728fd91fa1a ]---
> [49906.088930] ------------[ cut here ]------------
> [49906.089028] WARNING: CPU: 5 PID: 9511 at fs/btrfs/ctree.h:1593
> btrfs_update_device.cold+0x10/0x1b [btrfs]
> [49906.089029] Modules linked in: nf_conntrack_netlink xt_conntrack
> nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtable=
s
> binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE
> xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter
> bridge stp llc unix_diag intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_6=
4
> crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw
> intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables
> autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0
> multipath linear raid1 e1000e psmouse ahci libahci wmi video
> [49906.089075] CPU: 5 PID: 9511 Comm: storagenode Tainted: G=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 5.3.8-050308-generic #201910290940
> [49906.089077] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12
> R1.18.0.SR.1 for D3401-H2x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 07/02/2018
> [49906.089139] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
> [49906.089143] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8=

> 0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2=

> ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
> [49906.089145] RSP: 0018:ffffa89401233a60 EFLAGS: 00010246
> [49906.089148] RAX: 0000000000000024 RBX: ffff90bd80636000 RCX:
> 0000000000000006
> [49906.089150] RDX: 0000000000000000 RSI: 0000000000000086 RDI:
> ffff90bd8e357440
> [49906.089152] RBP: ffffa89401233ab0 R08: 00000000000003ff R09:
> 0000000000000004
> [49906.089154] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff90bb5373a2a0
> [49906.089155] R13: 0000000000000000 R14: 0000000000003f9e R15:
> ffff90bb42780840
> [49906.089159] FS:=C2=A0 00007fd22258ff20(0000) GS:ffff90bd8e340000(000=
0)
> knlGS:0000000000000000
> [49906.089161] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [49906.089163] CR2: 00007f8cf3721180 CR3: 0000000767104001 CR4:
> 00000000003606e0
> [49906.089165] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [49906.089167] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [49906.089168] Call Trace:
> [49906.089227]=C2=A0 btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
> [49906.089268]=C2=A0 btrfs_create_pending_block_groups+0xeb/0x220 [btrf=
s]
> [49906.089312]=C2=A0 __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
> [49906.089353]=C2=A0 btrfs_end_transaction+0x10/0x20 [btrfs]
> [49906.089409]=C2=A0 btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]=

> [49906.089464]=C2=A0 btrfs_check_data_free_space+0x59/0xb0 [btrfs]
> [49906.089511]=C2=A0 btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
> [49906.089519]=C2=A0 ? inet6_recvmsg+0x5e/0xf0
> [49906.089565]=C2=A0 btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
> [49906.089571]=C2=A0 new_sync_write+0x125/0x1c0
> [49906.089577]=C2=A0 __vfs_write+0x29/0x40
> [49906.089581]=C2=A0 vfs_write+0xb9/0x1a0
> [49906.089586]=C2=A0 ksys_write+0x67/0xe0
> [49906.089592]=C2=A0 __x64_sys_write+0x1a/0x20
> [49906.089597]=C2=A0 do_syscall_64+0x5a/0x130
> [49906.089603]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [49906.089606] RIP: 0033:0x47f050
> [49906.089610] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2=

> 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f=

> 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [49906.089612] RSP: 002b:000000c00034b260 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [49906.089615] RAX: ffffffffffffffda RBX: 000000c000048f00 RCX:
> 000000000047f050
> [49906.089617] RDX: 0000000000040000 RSI: 000000c00077e000 RDI:
> 0000000000000026
> [49906.089619] RBP: 000000c00034b2b0 R08: 0000000000000000 R09:
> 0000000000000000
> [49906.089621] R10: 0000000000000000 R11: 0000000000000202 R12:
> ffffe7dcdd518784
> [49906.089623] R13: 0000000000000002 R14: 00000000078dfd25 R15:
> 00000000073b9ee2
> [49906.089627] ---[ end trace 77f3c728fd91fa1b ]---
>=20
>=20
> Tomasz Chmielewski
> https://lxadm.com


--FDD5aHKgHFkQ82dyz9kWJPG7ASrCbjWoe--

--bpdIpP9SqCDO6DLpnCTXNEf4GjerTPkxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl28+igACgkQwj2R86El
/qjEawgAjFoh6uqGxYr2U7PPaglCQuLqZcfly5evUa44txJfZuXJy3QlEE1gxYIG
GxJVtnb4EMKM9TYjxdIYbg8FQNWWxFs8ugac7gSLLs+dZtCx2vN0iwKep0EuZwdp
IITrK+2C/Ii7fahzOzSxxJqOpxQ55+10Fl9AArCg4ZTryZNlsRu90AaUwl8a1tTK
VbObzWGaMG68rJU1IFkyzMw+V6+O8AjKh1X8ZB9URgQXd6+13NGJ2w9IRmDzIXsX
2fgcQOVQczUtX1W0JovY1frZ/ruXtlIdq8vpnd77/8UJK9sWZkyKpCHmf+PAGEy1
9EC8G0++xy1Htr7QrdUJ45Z90Qrvzg==
=fSdI
-----END PGP SIGNATURE-----

--bpdIpP9SqCDO6DLpnCTXNEf4GjerTPkxy--
