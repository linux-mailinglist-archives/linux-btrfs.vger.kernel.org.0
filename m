Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF560A04B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfH1OVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 10:21:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:44165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfH1OVc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 10:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567002088;
        bh=HfE1BxUBXYWy7l9UguYxoeBGEjYEsZ19GjDNsmbZjf8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=euApD8Mb4lOwJfH08YMnFE82kPzTPTiNGa7PlYorOpG9D8L/Gd8CQrUy+f1N5BzHA
         2vRCWg3dBIrFou15uMLK3IwbFJFHcimT3rnPpcbfvQ3YX9BYo5MpYNnAsbroFS6xot
         nTbPZ46bGbCYjp3CMmapBY1N5ccvT/NFdHHqsfEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1iaf562r39-00bKjL; Wed, 28
 Aug 2019 16:21:28 +0200
Subject: Re: WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559
 btrfs_update_device+0x1c5/0x1d0 [btrfs]
To:     Rich Rauenzahn <rrauenza@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAG+QAKXTRiC0s5pH_EQoz7Zd7nNfMC5++AN+EFgU6yY=3uvckw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <2a8f9cce-eef0-6e21-eea5-0aa9eaf4bd83@gmx.com>
Date:   Wed, 28 Aug 2019 22:21:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAG+QAKXTRiC0s5pH_EQoz7Zd7nNfMC5++AN+EFgU6yY=3uvckw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WYTlmfud1mgjPAbK8OyasEAqwnefW8LMo"
X-Provags-ID: V03:K1:gMh5ZyiHSHQl0q4eH40986nbZnhWsaFg+9iDvPbAKhojLBf2E2F
 Z8OPPPrUPIOSeR4YcckLeiD/vuGeDFTcCPkhEVSDkshdRkXRr/R9ABQtlIx19JEQKcTShZF
 OkI2pqXOvyOxfjhdigPmhxG65hhbCAwdLybZC3wW6d0+igDrNRzo8x4kNnYsK1GNNZOYke+
 gA5U99gXp4fDmYeLGTCLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6KYoc3nA0EM=:U0R85IarKvxGheWfsKnHY5
 LbSozzgyW6rrJtbt7UgjXNdVEoitxKKxa2obTVqnGHvz5qHkZlRvetJ6d6y+hpMp5t4qt0tHn
 SKKOcse2xB1dLgCOgRQKNzCcTbs/k4N5vgwwgYzQ6G+6Sqc2uY5e9Me85EimA9MhqBM8xPGAS
 7LHvSUhK002u6Fg8S6gmJav9vBmDeJYbA6IytxmQcFANC/65p5/xyvHBZSToxBMxfH68HrYiN
 LciuN6NGqUy/kerkZs0i6UXUprv3BK/GtET6AZwa4WK8SY9v/Dj4mogMDkgFZJHINRQPsn5VU
 Gd964ti0NirbFiuhLDbb2B3ssLY4MgMCWKHizgti/igp2pr52PcwSnLKFUkW0K/38pY2Ms6zE
 gS+UX9sqZo6XbIrkoFi8Rka+M0M8WvUFVabX6X2gm3w9zYtSrAjh0OTEX5qpO61ZLZ4nUhceG
 P2sVoExusrEAfCX7ryAyDhquWMyM76Ui8TSfQ3JR9J/LoeSPtqc2i9cGBIZ0xWr54DUN/PXQU
 6ag5N3pZY6cA55KUp7t4Z4cayFH91rSkjCEVDdSsMxO3hU6SZLl8jN4zd5VdjI1oxbzj1b5n4
 ZBcwX4GNLRnZIGVeSkfqPYF1FA/Bdtu6zZUUGW2prKOntewb0oMdLvSdlouzG95/UHxiHeRHO
 FS+PWJo5Hyvui2ua0jP0v7O6BVYNMnX7tj3zUajJxvZdMxXyejmcFoRWYdixU2b3Q3t+W6C16
 vzuZ5bjy8meNVNUl+DgbcsTBBYhSXFPq1tMzITlwkdG3zLIF2TgfhPaNxD1nF9LYbe979SYCc
 /QU84d9TikG/LDnVOVth/oWzrBI8RouoE/VqgfqW1cC/R7PnK4vFvl7MCQ+h0DilEfO7guRrj
 5nPn/E1+bHLKhtUCNvZ+8wKflXP2ySnzCZYJwUrTD4BsMTSHRnYmPaNh33Z8gnAndKcPg/Kfk
 pfvjyNdk9nMH0wKN1xRg3BwV5u4Yoo8xP+6PvDAP1rsgw1ZCmGolF6VfjlzRN1xF9X05bHmuR
 Uvf+dWDFwugX6nPDMcIORk9IGJi+N6EXFyjNLsk53bDLAkynafDW2ypDsF+PESdRlIuUJQxnH
 W1VMMleZ/fKcxC/IUWyztt5XeY/fgen/fqsBbebwv3MiweBwh9qEmZOZw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WYTlmfud1mgjPAbK8OyasEAqwnefW8LMo
Content-Type: multipart/mixed; boundary="uSxLA2XN3MZsiFnbsO8MS00HaWCuquEO2";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Rich Rauenzahn <rrauenza@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <2a8f9cce-eef0-6e21-eea5-0aa9eaf4bd83@gmx.com>
Subject: Re: WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559
 btrfs_update_device+0x1c5/0x1d0 [btrfs]
References: <CAG+QAKXTRiC0s5pH_EQoz7Zd7nNfMC5++AN+EFgU6yY=3uvckw@mail.gmail.com>
In-Reply-To: <CAG+QAKXTRiC0s5pH_EQoz7Zd7nNfMC5++AN+EFgU6yY=3uvckw@mail.gmail.com>

--uSxLA2XN3MZsiFnbsO8MS00HaWCuquEO2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2017/9/19 =E4=B8=8B=E5=8D=8811:56, Rich Rauenzahn wrote:
> I've filed a bug on this kernel trace -- I get 100's of these a day.
> I'd like to make them go away ....

If you want to solve the problem sooner, then mail list is faster than
kernel bugzilla.

For your case, it's just a warning for unaligned device size, normally
caused by older mkfs or older kernel.

You can fix it by using "btrfs rescue fix-device-size <device>" on a
unmounted fs, or use "btrfs resize <devid>:-4K <mnt>" to resize *each*
device of your mounted fs.

I'd prefer "btrfs rescue fix-device-size <device>" if you have the
latest version of btrfs-progs, as it does not only fix the unaligned
device size, but also fix your super block total bytes.

Thanks,
Qu
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D196949
>=20
> [    4.747356] ------------[ cut here ]------------
> [    4.747377] WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559
> btrfs_update_device+0x1c5/0x1d0 [btrfs]
> [    4.747377] Modules linked in: nfs_acl lockd grace sunrpc ip_tables
> btrfs xor raid6_pq sd_mod crc32c_intel firewire_ohci igb ahci
>  firewire_core crc_itu_t dca libahci i915 libata i2c_algo_bit e1000e
> drm_kms_helper ptp syscopyarea sysfillrect pps_core sysimgblt f
> b_sys_fops drm video
> [    4.747385] CPU: 3 PID: 439 Comm: btrfs-cleaner Not tainted
> 4.13.2-1.el7.elrepo.x86_64 #1
> [    4.747385] Hardware name: Supermicro X10SAE/X10SAE, BIOS 2.0a 05/09=
/2014
> [    4.747386] task: ffff88040cdcae80 task.stack: ffffc900021f4000
> [    4.747396] RIP: 0010:btrfs_update_device+0x1c5/0x1d0 [btrfs]
> [    4.747396] RSP: 0018:ffffc900021f7d00 EFLAGS: 00010206
> [    4.747397] RAX: 0000000000000fff RBX: ffff880407b7aa80 RCX: 0000001=
bc6c71e00
> [    4.747397] RDX: ffff880000000000 RSI: ffff880404cd3f3c RDI: ffff880=
409417b58
> [    4.747398] RBP: ffffc900021f7d48 R08: 0000000000003f60 R09: ffffc90=
0021f7cb8
> [    4.747398] R10: 0000000000001000 R11: 0000000000000003 R12: ffff880=
40559f800
> [    4.747398] R13: 0000000000000000 R14: ffff880409417b58 R15: 0000000=
000003f3c
> [    4.747399] FS:  0000000000000000(0000) GS:ffff88041fac0000(0000)
> knlGS:0000000000000000
> [    4.747399] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.747400] CR2: 00007f29c3000248 CR3: 00000004056a4000 CR4: 0000000=
0001406e0
> [    4.747400] Call Trace:
> [    4.747410]  btrfs_remove_chunk+0x2fb/0x8b0 [btrfs]
> [    4.747418]  btrfs_delete_unused_bgs+0x363/0x440 [btrfs]
> [    4.747426]  cleaner_kthread+0x150/0x180 [btrfs]
> [    4.747429]  kthread+0x109/0x140
> [    4.747436]  ? btree_invalidatepage+0xa0/0xa0 [btrfs]
> [    4.747437]  ? kthread_park+0x60/0x60
> [    4.747439]  ret_from_fork+0x25/0x30
> [    4.747439] Code: 10 00 00 00 4c 89 fe e8 8a 30 ff ff 4c 89 f7 e8
> 32 f6 fc ff e9 d3 fe ff ff b8 f4 ff ff ff e9 d4 fe ff ff 0f 1f 00 e8
> bb 2e 9e e0 <0f> ff eb af 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 31 d2
> be 02
> [    4.747450] ---[ end trace 1ef80a625983d73b ]---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--uSxLA2XN3MZsiFnbsO8MS00HaWCuquEO2--

--WYTlmfud1mgjPAbK8OyasEAqwnefW8LMo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1mjeQACgkQwj2R86El
/qgcnQf6A1Z0zH2asUEi1UHkBBQ9RQ1ZKHZpIWyPlcLi4l0PW091jVwKNX6BjQca
S9hHCnJdR94+AcfBJNBl1z0T5AGnxlZx7LYictreaMT3LZuHZuzzwYP8ji+OvXow
VmBluV+vDB7uewzHDH5U71OxApoBAWfCOUK00sHL+7t8OCN1ytJ1thLxosRFOT//
OR3ud+rbrkIsXrejEe/B6ZT+Q8Z0XHOCTaE7RIy8K/dw5udf6U88namSojURQ28U
JX9+yis94Mg5tMRY7LUOJW89RVPUFT5f9ehEQCKr9VUbRpdRwrdYbyYrxR6P32Ws
AfEDHs1zwzl3hhP7jtL/Xz4GHufACg==
=AXMG
-----END PGP SIGNATURE-----

--WYTlmfud1mgjPAbK8OyasEAqwnefW8LMo--
