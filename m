Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D2186458
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 06:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgCPFGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 01:06:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:48565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbgCPFGp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 01:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584335179;
        bh=+ExQluV/IBy1k64CKE0/ceN/TrwbXyR+s9YnZJ1X3+c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DF/ZDvD3Xn2eoDftbl4G9uvqQ1dSlIQpXNjFyS2kJxY9zglTxwBRoTpYVPQHDJNqh
         qz3RUbAeWoGnJwJs/Qe4jFPGUhIOVtaKZQmjNcWPaaocHGiZWlDBnNuNV0mfS9+tnZ
         8HIoTcz73JYGkZsDkVtkiBCoArsj0/SNFVLomIlc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Rm-1isKFY0MOc-00LTmY; Mon, 16
 Mar 2020 06:06:19 +0100
Subject: Re: kernel panic after upgrading to Linux 5.5
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
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
Message-ID: <fa4d1bf5-b800-edba-1fce-ae7108ae023b@gmx.com>
Date:   Mon, 16 Mar 2020 13:06:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xn8CIYfLVWBiWCiDhvwf3lTmHWvIE7oDm"
X-Provags-ID: V03:K1:cIm6ToDRgtk4fXjD/i6hmdHq/tkYp6SSqVVvAXYYqY/c4Jr5CNB
 vxG2gKe9sxvcbeY2iw0m1rH7A2oPpE945ngy1p9t4uuZpvFfi+O+hXvYf7kLImxoM6HFAOM
 yu4IuMXQMLdRNUg01WGMXwgdvsKRRd2NtHCL+DOQEQAi1coFInJARkhkBDY8sSm5JN4S4bZ
 rrGqgphSC9NjNDOMOoHsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Ue+R2xAA9A=:814wArJzChUvzwJ0K6fOp8
 YG6Z1rJ0tBLkeEbPXYIZCEtOkpLP3q963ThujwXDdeynDis6302CHZITMmDjo/YllnsIg4xf4
 VBpTdLIvAk5DF5EtPt0yKVUf7YtdObtYoXwvp9X5E9GStuS2wYIUvVz9xaxrGqET6EQVIqNQO
 R9xbHNK+dPiVeYU0kqhXwXGbWUekyNXT1i0nMfEafVRqkvk7CBnLKJZTwc+C9KynmiJX3ljBy
 hHl1PL6YPqkEzDaWIjlo1IsPACgPLPLXlKY8m3fitqY01gKeh1TT03S0BfFIOc3rhw9TCmfUT
 L5x5tc1ZBNMqeTrtkmQqVAXcuYyC8uD7RhJHRJJMXW7lFENtZNnrAozmBWvg6hhwBPnR4v8xv
 1+otsg1l7ZthHy2l2aQ5JcJTXAwnPNdjf/LlbWAtwhGhJsxvpGbCtdpkwCDbHIHhCoXoHebtq
 UIVjtyK5bYLXc+9YMu/N+1m0bUG6yL/DQpocv0Yx7rZaEVsjncjoSntzBNk6X+WTCIk6zyZ9I
 /rQKfoJ9yg9uGIxzGils7gjbgvbIOgoUZRidX3gLp4eFRlkSQgRWntuRtzQjvZIKeOXvxpVYr
 yDv9LTcmpVep32f/VJqfpDv8xzGM3+0jqzjIw3R7KbVXZDJeRlW1v1vFYCGcB5Yac3e4Aikp1
 mIBd19+87JTCngZxSePAybiqqrImABpMS6iSvMvnVgxmabfbb8Wo2j4KmP9P0eiy+qoHq1lWO
 GGcsyCpNsn3K6Sw9l1Y8Gnj8d7q5k5N795LTOntmWCTITIY1SHbQKbtDBUgLfWg9zJ1dEMp7q
 ZGv+qaYFQ3RJORquFvycHUT41tKFV4Btt1jarnT3sAAHy5MSaCTINpZxzPlJBeNMNk3H4OwOr
 6bg1YGEVxST9ClKwXwmxgkIL7XkKCX8anFmf/P4SchwHGS+CeRn6RmUBXp+eXXiVp4M9EIGfz
 oLemPIVBHueAlSXUiE9sxCpBzNjCi80TaDMo1cewcWWmgNmhlcrhOtU9Xy60egFXW56Iiqnw/
 QjAwFsDQPFIEQV3JBymtZAArnxEkr4tZ6XvOzrgD89NYMeYaPR7/6+yavyjKkY7bc+3ifaOcQ
 /h0DrxcHYEF56zjVHH91m03nsxOmd+GxMKR2BCvq+8kk6is5ePnOJ53UizSYqNryOwicFKYq6
 mAWRQgkcOlKV1g4rN3bLizQg7Guym8WILJSg4upmU1uvAdJzZ4tdDP5QOJuyCbi3G5od17hFW
 MVUM74Pk+ZJi+WYk+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xn8CIYfLVWBiWCiDhvwf3lTmHWvIE7oDm
Content-Type: multipart/mixed; boundary="HOdceWCeVFHscncM33Y5sjKWENtiaMBtV"

--HOdceWCeVFHscncM33Y5sjKWENtiaMBtV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/16 =E4=B8=8A=E5=8D=8811:13, Tomasz Chmielewski wrote:
> After upgrading to Linux 5.5 (tried 5.5.6, 5.5.9, also 5.6.0-rc5), the
> system panics shortly after mounting and starting to use a btrfs
> filesystem. Here is a dmesg - please advise how to deal with it.
> It has since crashed several times, because of panic=3D10 parameter
> (system boots, runs for a while, crashes, boots again, and so on).
>=20
> Mount options:
>=20
> noatime,ssd,space_cache=3Dv2,user_subvol_rm_allowed
>=20
>=20
>=20
> [=C2=A0=C2=A0 65.777428] BTRFS info (device sda2): enabling ssd optimiz=
ations
> [=C2=A0=C2=A0 65.777435] BTRFS info (device sda2): using free space tre=
e
> [=C2=A0=C2=A0 65.777436] BTRFS info (device sda2): has skinny extents
> [=C2=A0=C2=A0 98.225099] BTRFS error (device sda2): parent transid veri=
fy failed
> on 19718118866944 wanted 664218442 found 674530371
> [=C2=A0=C2=A0 98.225594] BTRFS error (device sda2): parent transid veri=
fy failed
> on 19718118866944 wanted 664218442 found 674530371

This is the root cause, not quota.

The metadata is already corrupted, and quota is the first to complain
about it.

Thanks,
Qu

> [=C2=A0=C2=A0 98.225757] BTRFS warning (device sda2): error accounting =
new delayed
> refs extent (err code: -5), quota inconsistent
> [=C2=A0 129.044785] ------------[ cut here ]------------
> [=C2=A0 129.044840] WARNING: CPU: 4 PID: 4476 at fs/btrfs/qgroup.c:2523=

> btrfs_qgroup_account_extents+0x211/0x250 [btrfs]
> [=C2=A0 129.044841] Modules linked in: unix_diag binfmt_misc nf_tables
> nfnetlink ebt_ip ebtable_filter ebtables joydev input_leds hid_generic
> amd64_edac_mod edac_mce_amd kvm_amd kvm ip6table_filter ipmi_ssif
> crct10dif_pclmul ip6table_nat ip6_tables crc32_pclmul
> ghash_clmulni_intel iptable_filter xt_CHECKSUM iptable_mangle
> xt_MASQUERADE xt_comment xt_nat aesni_intel xt_tcpudp iptable_nat
> crypto_simd nf_nat drm_vram_helper cryptd drm_ttm_helper glue_helper
> nf_conntrack ttm nf_defrag_ipv6 nf_defrag_ipv4 drm_kms_helper cec
> bpfilter rc_core drm usbhid hid fb_sys_fops syscopyarea sysfillrect
> sysimgblt k10temp ccp ipmi_si ipmi_devintf ipmi_msghandler mac_hid
> sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic
> zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
> async_xor async_tx xor raid6_pq raid1 raid0 multipath linear bnx2x igb
> i2c_algo_bit mdio dca libcrc32c ahci libahci i2c_piix4
> [=C2=A0 129.044896] CPU: 4 PID: 4476 Comm: btrfs-transacti Kdump: loade=
d Not
> tainted 5.6.0-050600rc5-generic #202003082130
> [=C2=A0 129.044897] Hardware name: GIGABYTE MZ31-AR0-00/MZ31-AR0-00, BI=
OS
> F03e 09/13/2017
> [=C2=A0 129.044941] RIP: 0010:btrfs_qgroup_account_extents+0x211/0x250 =
[btrfs]
> [=C2=A0 129.044945] Code: 85 db 74 21 48 8b 03 48 8b 7b 08 48 83 c3 18 =
4c 89
> f1 4c 89 fa 4c 89 ee e8 7c 5f 6f e5 48 8b 03 48 85 c0 75 e2 e9 67 ff ff=

> ff <0f> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 d8 95 ff
> [=C2=A0 129.044947] RSP: 0018:ffffadb1cef7fde8 EFLAGS: 00010246
> [=C2=A0 129.044949] RAX: ffff9c4a4b36c300 RBX: ffff9c1a5768a550 RCX:
> 0000000000000017
> [=C2=A0 129.044951] RDX: 0000000000000001 RSI: 000011edd6f5c000 RDI:
> 0000000000000000
> [=C2=A0 129.044952] RBP: ffffadb1cef7fe38 R08: ffff9c4a4b36c300 R09:
> ffff9c4a4cb4bc00
> [=C2=A0 129.044953] R10: 0000000000004000 R11: 0000000000000010 R12:
> 0000000000000000
> [=C2=A0 129.044954] R13: ffff9c4a59240000 R14: 0000000000000001 R15:
> ffff9c4a4b36c300
> [=C2=A0 129.044957] FS:=C2=A0 0000000000000000(0000) GS:ffff9c1a5eb0000=
0(0000)
> knlGS:0000000000000000
> [=C2=A0 129.044958] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> [=C2=A0 129.044959] CR2: 00007f67fab03808 CR3: 0000002abae0a000 CR4:
> 00000000003406e0
> [=C2=A0 129.044961] Call Trace:
> [=C2=A0 129.045004]=C2=A0 btrfs_commit_transaction+0x4dc/0x9e0 [btrfs]
> [=C2=A0 129.045011]=C2=A0 ? wait_woken+0x80/0x80
> [=C2=A0 129.045045]=C2=A0 transaction_kthread+0x146/0x190 [btrfs]
> [=C2=A0 129.045051]=C2=A0 kthread+0x104/0x140
> [=C2=A0 129.045083]=C2=A0 ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrf=
s]
> [=C2=A0 129.045086]=C2=A0 ? kthread_park+0x90/0x90
> [=C2=A0 129.045091]=C2=A0 ret_from_fork+0x22/0x40
> [=C2=A0 129.045095] ---[ end trace e192cb9f9978caa3 ]---
> [=C2=A0 129.094866] BTRFS error (device sda2): parent transid verify fa=
iled
> on 19718118866944 wanted 664218442 found 674530371
> [=C2=A0 129.095331] BTRFS error (device sda2): parent transid verify fa=
iled
> on 19718118866944 wanted 664218442 found 674530371
> [=C2=A0 129.095476] ------------[ cut here ]------------
> [=C2=A0 129.095478] kernel BUG at mm/slub.c:304!
> [=C2=A0 129.095551] invalid opcode: 0000 [#1] SMP NOPTI
> [=C2=A0 129.095618] CPU: 28 PID: 4476 Comm: btrfs-transacti Kdump: load=
ed
> Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.6.0-050600rc5-generic #202003082130
> [=C2=A0 129.095704] Hardware name: GIGABYTE MZ31-AR0-00/MZ31-AR0-00, BI=
OS
> F03e 09/13/2017
> [=C2=A0 129.095780] RIP: 0010:__slab_free+0x183/0x330
> [=C2=A0 129.095842] Code: 00 48 89 c7 fa 66 0f 1f 44 00 00 f0 49 0f ba =
2c 24
> 00 72 65 4d 3b 6c 24 20 74 11 49 0f ba 34 24 00 57 9d 0f 1f 44 00 00 eb=

> 9f <0f> 0b 49 3b 5c 24 28 75 e8 48 8b 44 24 28 49 89 4c 24 28 49 89 44
> [=C2=A0 129.095953] RSP: 0018:ffffadb1cef7fcf0 EFLAGS: 00010246
> [=C2=A0 129.096018] RAX: ffff9c1a47934c00 RBX: 0000000080800076 RCX:
> ffff9c1a47934c00
> [=C2=A0 129.096088] RDX: ffff9c1a47934c00 RSI: ffffe1d03f1e4d00 RDI:
> ffff9c1a5e407800
> [=C2=A0 129.096157] RBP: ffffadb1cef7fd90 R08: 0000000000000001 R09:
> ffffffffc0305740
> [=C2=A0 129.096254] R10: ffff9c1a47934c00 R11: 0000000000000001 R12:
> ffffe1d03f1e4d00
> [=C2=A0 129.096366] R13: ffff9c1a47934c00 R14: ffff9c1a5e407800 R15:
> ffff9c4a4b36c300
> [=C2=A0 129.096469] FS:=C2=A0 0000000000000000(0000) GS:ffff9c1a5ec8000=
0(0000)
> knlGS:0000000000000000
> [=C2=A0 129.096596] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> [=C2=A0 129.096688] CR2: 0000555a48f94988 CR3: 0000002abae0a000 CR4:
> 00000000003406e0
> [=C2=A0 129.096785] Call Trace:
> [=C2=A0 129.096868]=C2=A0 ? kfree+0x22b/0x240
> [=C2=A0 129.096971]=C2=A0 ? ulist_free+0x20/0x30 [btrfs]
> [=C2=A0 129.097074]=C2=A0 ? btrfs_find_all_roots_safe+0xdd/0x130 [btrfs=
]
> [=C2=A0 129.097182]=C2=A0 ? ulist_free+0x20/0x30 [btrfs]
> [=C2=A0 129.097270]=C2=A0 kfree+0x22b/0x240
> [=C2=A0 129.097368]=C2=A0 ulist_free+0x20/0x30 [btrfs]
> [=C2=A0 129.097469]=C2=A0 btrfs_qgroup_account_extents+0x91/0x250 [btrf=
s]
> [=C2=A0 129.097577]=C2=A0 btrfs_commit_transaction+0x4dc/0x9e0 [btrfs]
> [=C2=A0 129.097670]=C2=A0 ? wait_woken+0x80/0x80
> [=C2=A0 129.097769]=C2=A0 transaction_kthread+0x146/0x190 [btrfs]
> [=C2=A0 129.097860]=C2=A0 kthread+0x104/0x140
> [=C2=A0 129.097955]=C2=A0 ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrf=
s]
> [=C2=A0 129.098047]=C2=A0 ? kthread_park+0x90/0x90
> [=C2=A0 129.098133]=C2=A0 ret_from_fork+0x22/0x40
> [=C2=A0 129.098218] Modules linked in: unix_diag binfmt_misc nf_tables
> nfnetlink ebt_ip ebtable_filter ebtables joydev input_leds hid_generic
> amd64_edac_mod edac_mce_amd kvm_amd kvm ip6table_filter ipmi_ssif
> crct10dif_pclmul ip6table_nat ip6_tables crc32_pclmul
> ghash_clmulni_intel iptable_filter xt_CHECKSUM iptable_mangle
> xt_MASQUERADE xt_comment xt_nat aesni_intel xt_tcpudp iptable_nat
> crypto_simd nf_nat drm_vram_helper cryptd drm_ttm_helper glue_helper
> nf_conntrack ttm nf_defrag_ipv6 nf_defrag_ipv4 drm_kms_helper cec
> bpfilter rc_core drm usbhid hid fb_sys_fops syscopyarea sysfillrect
> sysimgblt k10temp ccp ipmi_si ipmi_devintf ipmi_msghandler mac_hid
> sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic
> zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
> async_xor async_tx xor raid6_pq raid1 raid0 multipath linear bnx2x igb
> i2c_algo_bit mdio dca libcrc32c ahci libahci i2c_piix4


--HOdceWCeVFHscncM33Y5sjKWENtiaMBtV--

--xn8CIYfLVWBiWCiDhvwf3lTmHWvIE7oDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5vCUQACgkQwj2R86El
/qjSmAf/T5bzOETIQyejqHBcckgXLzuon4cHnX2y3zJf/m4HhKyapbBUm9L8/Giu
xYi7Baft7CZuH89b49vGok5xGLZpZAge9ZC1SfFhBtpoFinkTzRdNbx7WhGxqbhn
Keb33aB6EhhPT/SqNfDgfnaiNHawtsTek63/Ddl7PcQ0fHt3ojfxmHZ89WJHD1gd
964DMS7Ed+vkA16A2wpv7SykeO8Be2B3TsNvrIRoLO3GnIl2H161HPhL1AXaSb+W
Nh6Wpq1rosnLd5KzhQbR6w2zJPZFj+oG/xdWFKIZnfXeyFDM1be9J8fNp/DUxIa5
iQQQolWjpHTIjInhOIMm0o8udOImHA==
=Fj5q
-----END PGP SIGNATURE-----

--xn8CIYfLVWBiWCiDhvwf3lTmHWvIE7oDm--
