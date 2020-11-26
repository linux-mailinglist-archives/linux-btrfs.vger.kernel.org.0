Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C622C4EA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 07:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgKZGPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 01:15:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:39125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbgKZGPP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 01:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606371310;
        bh=bt2e20nLQmZAtsbUUds5tisr7nB1kFON78nvHP/6Qn4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EDx1bPfyG9MNNOfA5EC3c5QetEPnXq+KQml6kAEaQ2zG8P5n4H8kWZtFKOhNUQYMb
         B/L5IR0tr5cXqkettNTlYynU35f03r1taWVpWwbNzbAsMV4iyh5aJsoV8/VBOTz417
         gBVvGgBLVbk7VBjB+UKN1h4PVgI7w09hppWk8MhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCbB-1kmH8e2jFh-00VBnJ; Thu, 26
 Nov 2020 07:15:10 +0100
Subject: Re: btrfs crash on armv7
To:     Joe Hermaszewski <joe@monoid.al>, linux-btrfs@vger.kernel.org
References: <CA+4cVr95GJvSPuMDmACe6kiZEBvArWcBFkLL8Q1HsOV8DRkUHQ@mail.gmail.com>
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
Message-ID: <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
Date:   Thu, 26 Nov 2020 14:15:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+4cVr95GJvSPuMDmACe6kiZEBvArWcBFkLL8Q1HsOV8DRkUHQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ab87ftu69oj0WYfF4IVOgr6pTVRc92vGb"
X-Provags-ID: V03:K1:kKRmgIRlGvJ2FVaeolYaps6cZkl1Mb7DpH2YcM9Igg7+Wb73BRX
 QizztenHGAwsyrBpostYBDG20545HNJq84mLndj77N89+K6S7SOsVxgw1JoS7nba/oXQ0Xk
 oPAfQ6PphFooRV12zqBmpFIFiBdcK7Sh2VLATxKrzMZM7TDCaCDapi3bGMVZxaoZCWd4R3M
 wu79X8t/Ck4T/wEm542Mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VwebDDKGA+k=:sB833yhJV/v6DgkmlWivDq
 ToYJ1goF/O1xZvqqAEs83P2YkMWGhaY0+pKiN35QAkXscLtqL58gM3FygzStn0pgS4thG43eO
 CpLMpNansFhTOvwZzpql7zlRcgTM0FFQH1NdTDwhK2ZwiTVo6l4jnUsm0f5DNg5bI+6UpOcpn
 h00J3Dw8oiLwFmCW5wtX2FFoGVnZaIIPuKqF83Wvdak+N3nOwIPpNMw+1WIiimMGgIv4K9utn
 AZS68V+Bdtlf9+fHKK20iqtmCIN0L4YEt+J4rbMablvhHwgl+nkUObdy485Tag7LUL0KFJFKW
 yT3YUCKYWWcmi5TbdbB1/aNtmBT7A2L9OPCDfn+AL7QgY2uHpFXZmfL/1TBvjUMR9kOzrQyM6
 DHskP2G8PCov5ZpLwbn1kCNYB42O02tI0kn3DDyllJBJRxgTFNcwTuLRSEasysSxfLcqARfmV
 vBsPpj4VjWO4xK8xn5CeVceWXpUwftDutqdn7YjnbrfYe6gzJMrW+rXILEAuYDZAFpOZPMgwV
 QzUrTXcyRLbzSLI4Bgthwb/bFh1HyS9dSwjL0EnAsKTtHLb5Qrn1w345AP2C842Rp9LrR2+I1
 IOSibqle+zTNzQ8vdS3xalI6fmQitQzCI+gBih0EwjsS2AYqkbTLEb1A2VcbmKfRkhVQrh9Xn
 bpH9xqRrjeBumONvmQIXfkauUSxydAcH7JEq0JAZKRBEjRjuEkC0ojeK46dgfouNWyWBbrSNH
 zRHuBeKcxgxy46SuNu7hBJfNoeZgwBk+kO5k78SO2cLWljgXw3s1CyUh/vmTjryjEq7YLapMk
 AkrBWoxVjZEkk+YNhs/ul6gjbN6b0HYeR9tQNwu9yVpht77/MpiptftVmy5jUo8NFcVbQdmug
 Cx8DO3h/gQfqmn9KULOQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ab87ftu69oj0WYfF4IVOgr6pTVRc92vGb
Content-Type: multipart/mixed; boundary="PBdTzVBJDlCQEtpmHstFHrzJhAvtzePkc"

--PBdTzVBJDlCQEtpmHstFHrzJhAvtzePkc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/25 =E4=B8=8B=E5=8D=8811:28, Joe Hermaszewski wrote:
> Hi,
>=20
> I have a arm32 machine with four drives with a btrfs fs spanning then i=
n RAID1.
> The filesystem has started behaving badly recently and I'm writing to:
>=20
> - Solicit advice on how best to get the system back to a stable state
> - Report a potential bug
>=20
> ## What happened:
>=20
> A couple of days ago I could no longer ssh into it, and on the serial
> connection there were heaps of messages (and new ones appearing with gr=
eat
> frequency) along the lines of: `parent transid verify failed on blah...=
 wanted
> x got y`.
>=20
> Although I don't have a record of the precise messages I do remember th=
at there
> was a difference of `15` between x and y.

This normally can be a sign of unreliable HDD, which lies on FLUSH,
killing metadata COW.

But, your btrfs check doesn't report the same problem, thus I'm confused.=


Would you please try to run a "btrfs check --readonly /dev/sda1" with
the fs unmounted?

And, would you provide the full dmesg of that mismatch?
The reason for the exact number is, I'm suspecting hardware memory
corruption.

>=20
> I power-cycled system and started a scrub after it rebooted, this was
> interrupted quite promptly by several more errors in btrfs, and the dis=
k
> remounted RO.
>=20
> Every now and then in the kernel log I get messages like:
>=20
> `parent transid verify failed on blah... wanted x got y`

Not showing up in the gist dmesg though.

>=20
> ## Important info
>=20
> The dev stats are all zero.
>=20
> Here are the outputs of some btrfs commands, dmesg and the kernel log f=
rom the
> previous two boots: https://gist.github.com/b1beab134403c5047e2efbceb98=
985f9
>=20
> The "cut here" portion of the kernel log is as follows
>=20
> ```
> [  409.158097] ------------[ cut here ]------------
> [  409.158205] WARNING: CPU: 1 PID: 217 at fs/btrfs/disk-io.c:531
> btree_csum_one_bio+0x208/0x248 [btrfs]

The line number shows, the tree bytenr doesn't match with the one in memo=
ry.
This is really too rare to be seen, especially when we have no other
error reported from btrfs (at least in the gist)

Since there is no other problems showing up in the gist, it means it
could be a bit flip, considering the magic generation gap you mention is
15, I'm more suspicious about memory bit flip.

If you can provide the full parent transid mismatch error message, it
may help to determine the possibility of hardware memory corruption.

Thanks,
Qu

> [  409.158208] Modules linked in: cfg80211 rfkill 8021q ip6table_nat
> iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter ip6table_raw iptable_raw
> xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_tcpudp
> ftdi_sio usbserial phy_generic uio_pdrv_genirq uio ip6table_filter
> ip6_tables iptable_filter sch_fq_codel loop tun tap macvlan bridge stp
> llc lm75 ip_tables x_tables autofs4 dm_mod dax btrfs libcrc32c xor
> raid6_pq
> [  409.158258] CPU: 1 PID: 217 Comm: btrfs-transacti Not tainted 5.4.77=
 #1-NixOS
> [  409.158260] Hardware name: Marvell Armada 380/385 (Device Tree)
> [  409.158261] Backtrace:
> [  409.158272] [<c010f698>] (dump_backtrace) from [<c010f938>]
> (show_stack+0x20/0x24)
> [  409.158277]  r7:00000213 r6:600f0013 r5:00000000 r4:c0f8c044
> [  409.158283] [<c010f918>] (show_stack) from [<c0a1b388>]
> (dump_stack+0x98/0xac)
> [  409.158288] [<c0a1b2f0>] (dump_stack) from [<c012a998>] (__warn+0xe0=
/0x108)
> [  409.158292]  r7:00000213 r6:bf058ec8 r5:00000009 r4:bf120990
> [  409.158296] [<c012a8b8>] (__warn) from [<c012ad24>]
> (warn_slowpath_fmt+0x74/0xc4)
> [  409.158300]  r7:00000213 r6:bf120990 r5:00000000 r4:e2392000
> [  409.158358] [<c012acb4>] (warn_slowpath_fmt) from [<bf058ec8>]
> (btree_csum_one_bio+0x208/0x248 [btrfs])
> [  409.158363]  r9:e277abe0 r8:00000001 r7:e2392000 r6:ea3d17f0
> r5:00000000 r4:eefd2d3c
> [  409.158465] [<bf058cc0>] (btree_csum_one_bio [btrfs]) from
> [<bf059ef4>] (btree_submit_bio_hook+0xe8/0x100 [btrfs])
> [  409.158470]  r10:e32ce170 r9:ecc45fc0 r8:ecc45f70 r7:ec82b000
> r6:00000000 r5:ea3d17f0
> [  409.158472]  r4:bf059e0c
> [  409.158575] [<bf059e0c>] (btree_submit_bio_hook [btrfs]) from
> [<bf08b11c>] (submit_one_bio+0x44/0x5c [btrfs])
> [  409.158578]  r7:ef36c048 r6:e2393cac r5:00000000 r4:bf059e0c
> [  409.158683] [<bf08b0d8>] (submit_one_bio [btrfs]) from [<bf0965d4>]
> (btree_write_cache_pages+0x380/0x408 [btrfs])
> [  409.158686]  r5:00000000 r4:00000000
> [  409.158788] [<bf096254>] (btree_write_cache_pages [btrfs]) from
> [<bf059028>] (btree_writepages+0x7c/0x84 [btrfs])
> [  409.158793]  r10:00000001 r9:4fd00000 r8:c0280c94 r7:e2392000
> r6:e2393d80 r5:ecc45f70
> [  409.158794]  r4:e2393d80
> [  409.158850] [<bf058fac>] (btree_writepages [btrfs]) from
> [<c0284748>] (do_writepages+0x58/0xf4)
> [  409.158852]  r5:ecc45f70 r4:ecc45e68
> [  409.158860] [<c02846f0>] (do_writepages) from [<c0278c30>]
> (__filemap_fdatawrite_range+0xf8/0x130)
> [  409.158864]  r8:ecc45f70 r7:00001000 r6:4fd0bfff r5:e2392000 r4:ecc4=
5e68
> [  409.158869] [<c0278b38>] (__filemap_fdatawrite_range) from
> [<c0278db8>] (filemap_fdatawrite_range+0x2c/0x34)
> [  409.158874]  r10:ecc45f70 r9:00001000 r8:4fd0bfff r7:e2393e4c
> r6:c73bc628 r5:00001000
> [  409.158875]  r4:4fd0bfff
> [  409.158929] [<c0278d8c>] (filemap_fdatawrite_range) from
> [<bf0604b4>] (btrfs_write_marked_extents+0x9c/0x1b0 [btrfs])
> [  409.158931]  r5:00000001 r4:00000000
> [  409.159033] [<bf060418>] (btrfs_write_marked_extents [btrfs]) from
> [<bf060660>] (btrfs_write_and_wait_transaction+0x54/0xa4 [btrfs])
> [  409.159038]  r10:e2392000 r9:ec82b010 r8:ec82b000 r7:c73bc628
> r6:ec82b000 r5:e2392000
> [  409.159040]  r4:c8b81ca8
> [  409.159141] [<bf06060c>] (btrfs_write_and_wait_transaction [btrfs])
> from [<bf062398>] (btrfs_commit_transaction+0x75c/0xc94 [btrfs])
> [  409.159145]  r8:ec82b418 r7:c73bc600 r6:ec82b000 r5:c8b81ca8 r4:0000=
0000
> [  409.159248] [<bf061c3c>] (btrfs_commit_transaction [btrfs]) from
> [<bf05cd08>] (transaction_kthread+0x19c/0x1e0 [btrfs])
> [  409.159253]  r10:ec82b28c r9:00000000 r8:001aaafa r7:00000064
> r6:ec82b414 r5:00000bb8
> [  409.159254]  r4:ec82b000
> [  409.159309] [<bf05cb6c>] (transaction_kthread [btrfs]) from
> [<c014fabc>] (kthread+0x170/0x174)
> [  409.159313]  r10:eca87bfc r9:bf05cb6c r8:ed619000 r7:e2392000
> r6:00000000 r5:ed5ee700
> [  409.159315]  r4:ed5ee1c0
> [  409.159320] [<c014f94c>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [  409.159322] Exception stack(0xe2393fb0 to 0xe2393ff8)
> [  409.159326] 3fa0:                                     00000000
> 00000000 00000000 00000000
> [  409.159331] 3fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [  409.159334] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> [  409.159338]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
> r6:00000000 r5:c014f94c
> [  409.159340]  r4:ed5ee700
> [  409.159342] ---[ end trace eea59ced12fa7859 ]---
> [  409.165084] BTRFS: error (device sda1) in
> btrfs_commit_transaction:2279: errno=3D-5 IO failure (Error while
> writing out transaction)
> [  409.176920] BTRFS info (device sda1): forced readonly
> [  409.176947] BTRFS warning (device sda1): Skipping commit of aborted
> transaction.
> [  409.176952] BTRFS: error (device sda1) in cleanup_transaction:1832:
> errno=3D-5 IO failure
> [  409.185049] BTRFS info (device sda1): delayed_refs has NO entry
> [  409.310199] BTRFS info (device sda1): scrub: not finished on devid
> 3 with status: -125
> [  409.664880] BTRFS info (device sda1): scrub: not finished on devid
> 4 with status: -125
> [  410.106791] BTRFS info (device sda1): scrub: not finished on devid
> 1 with status: -125
> [  411.268585] BTRFS warning (device sda1): failed setting block group =
ro: -30
> [  411.268594] BTRFS info (device sda1): scrub: not finished on devid
> 2 with status: -30
> [  411.268605] BTRFS info (device sda1): delayed_refs has NO entry
> ```
>=20
> Information requested here
> (https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list):
>=20
> ```
>  $ uname -a
> Linux thanos 5.4.77 #1-NixOS SMP Tue Nov 10 20:13:20 UTC 2020 armv7l GN=
U/Linux
>=20
>  $ btrfs --version
> btrfs-progs v5.7
>=20
>  $ sudo btrfs fi show
> Label: none  uuid: b8f4ad49-29c8-4d19-a886-cef9c487f124
>         Total devices 4 FS bytes used 10.26TiB
>         devid    1 size 3.64TiB used 2.40TiB path /dev/sda1
>         devid    2 size 3.64TiB used 2.40TiB path /dev/sdc1
>         devid    3 size 9.09TiB used 7.86TiB path /dev/sdd1
>         devid    4 size 9.09TiB used 7.86TiB path /dev/sdb1
>=20
> Label: none  uuid: d02a3067-0a23-4c1f-96ac-80dbc26622f2
>         Total devices 1 FS bytes used 116.35MiB
>         devid    1 size 399.82MiB used 224.00MiB path /dev/sda2
>=20
>  $ sudo btrfs fi df /
> Data, RAID1: total=3D10.25TiB, used=3D10.24TiB
> System, RAID1: total=3D64.00MiB, used=3D1.45MiB
> Metadata, RAID1: total=3D18.00GiB, used=3D17.19GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> ```
>=20
> Thanks to demfloro and multicore on #btrfs for prompting this email.
>=20
> Best wishes,
> Joe
>=20


--PBdTzVBJDlCQEtpmHstFHrzJhAvtzePkc--

--ab87ftu69oj0WYfF4IVOgr6pTVRc92vGb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+/R+oACgkQwj2R86El
/qhlwgf/dcarmckkhDzIiYWczeG0Xll5CkqgwjpD5k9JBdzIIHFEUvMskcXLeQuJ
JDnq11FnRITOBR1qSRymCbSLK66hpEbwHYNLcUPmAB3fi04e6YRtihMq4od/TonN
tAg6Y5eIBwqV16ZYbaBDu6M9BFXEdzy2yGSkIQpz+1Aa4hnHFrKkzZvZK7tFi4vD
jsKB4R/W4Gi9p8TFCPUBDaYCBkfhMgXbH2gDEg2dqiqKvOTFMRMUWwXyKePLCJuU
qGyC6Gw42ibWLfsE7a9YEV1cvBTBaDweWhF3n7K+BlRN63wY0gPsy3M24OKDXE9h
R2vBH9IcZ5/k4g29MNo8yVgdibmJTQ==
=Yjyd
-----END PGP SIGNATURE-----

--ab87ftu69oj0WYfF4IVOgr6pTVRc92vGb--
