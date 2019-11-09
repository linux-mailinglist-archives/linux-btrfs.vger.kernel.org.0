Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2DF5D4B
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 05:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfKIECm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 23:02:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:44351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfKIECm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 23:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573272075;
        bh=EMFzF6FkFaJ/i1LNq45D4D4025aZRytKkImtsjDfNEM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WYZr5gdFLmDjASqY6+ZY2JjJyuj+KGJ6RZ6dhEidFlVeGckJebUFDfqtF0KIdAgtF
         QAAPr5tN6+5hfMK38chXHRu7TVF87QrDa56DITlgoON/MPqRWdXxXBJmO7rm41S7rJ
         Unnlm5vQyzo9r9GHpZeXfsY3q0AnIfpeN/nCDcRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1iU6kP0g9v-004GFB; Sat, 09
 Nov 2019 05:01:14 +0100
Subject: Re: [next-20191108] Assertion failure in
 space-info.c:btrfs_update_space_info()
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <ebde863f-51f2-d761-4bae-1722ea256e08@suse.de>
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
Message-ID: <3579f352-038a-08a7-30b8-f4935cf55f2c@gmx.com>
Date:   Sat, 9 Nov 2019 12:01:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ebde863f-51f2-d761-4bae-1722ea256e08@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CgBhQdnOcEPacNm319EGbjVei9WhD90Cu"
X-Provags-ID: V03:K1:vAjkSCYtaRxUBnSAbCEnTGYfuRHSFk0gvh17xcCvf/9BiTSkYWn
 fvIBvjTwvLhy0F7Yr0rxvOoZIaCbeKeR+BmrqaBRrNTp+GJOHP8ECrZnup86fBYIAIqgQ8E
 u/s9xk2Ai+i1pPgQb9Q66Jdl9AlfG77yC7Wg7ZE3NLjJhmJnTaNhriVy0dDie5gnaESuq4f
 RufDWf/6uz9l3+22Fm0Tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uzy/hJBlgy8=:NrQ6QHf1nCPWOCHrto+y33
 zbqLISL3OQ+wlVqeplvC+KXduyt5NDJ2U4mip0wi31gyUX6D+kV7uBS0Rx0vXyIbINyMxov7x
 aPy4Xr9gWLclg4Q/u//TcpoQv6hIr4d2QnRqMyxMKX3ucWicUUC26lA0oirTAVIXXMU/wc0YW
 zSrVxvW6A9QsRHhCH6gQE3ldp42vmi7bQZvKrx2tGNDh7YLArruj1b2JVPrQ/wD3dBF0uzLKV
 b+xtP37zrM4fTsz+fPES7Et109aTWTg8cfJdwo6ROlfWIC+CgL36fRD1h/6+YqmnOVMW5b7fA
 Qr+Zcq/wjL3abyOTOkrLTl8OmoicIzpHQj2jo0zeHhYrbheCqnZrnI7wc9DOiVE53fZvbs2tw
 221dALcM6Y7biLU4NemoP0GNuFB1hUturQSJ8BQ1SZ+e/V4v1rhZ+eEIllz3Z+9CBlTJ2rJU5
 76uQTCfEnoPdOyCBdV/ukcu6ziKkC7E3v4Jvr8kSXE8KaO685wzuBWDxOoYOZb6uL5ZIaNcvj
 aDeR27Dprgc90FDb/vwMH7EmbzHVGiIqtfxvKixx6KsN/DB4hCeSkLo6DDC0qLnuJRXxuUrsJ
 VvGjCJ+YJc5BdWEAGrByD/Pk9QlU6yZ9V5bFULektCa9XPdjY/edNk5rLuFCzpfTEO1hCwRtT
 r2jQSyfe6wVaJu7V92WjGwYlzNIrkfi5zKLdwNmZ7sn/MT59MSEsGdElfrixflZErYtXHnuD0
 lXmpW5fxJthmyJmqZMQiG6OwdNgz6QhpO8Sdq9a4wvgFSGeP0aAlYYML1zp+egxlOApA26HEl
 diRS/LjCIz1zFVDkeIJOwAtEx56WYP2Lye4SzlgAcb5l0NHk/Mxl/BksjLtHGGE1mtOPXQK/+
 Rdgx4C8RhJ1Bno2cfusu2wXbCAyMlImuoyJzx/A0vOT+w7989elKXYN9HmvAtwoj9tPB6hVxR
 Hv4G7EpkxPdJrA8pDWsm47ZSjosi8hU3rosgBKVhFkI5DEiQzxYMUr6kG7qs4IjKmRY+duIcb
 MsLe37utVGiw+JKNT+3eWJ+9kxtHG3YaI+Qxmd56qkbtkQJPJ5EF2Ca2pPnQ/Xmlb5GDmcOcd
 mEMDl83gT9t7c/OvQ4klSAwQFAAgKwF0rmysXn3ZieAM3hUUHkPokkpa1oKSY8MBywjt/glKv
 1H1bLrXHmwXIFi9dhbfrgPwmUbMcTPBv6YK0P8igmOahqFSPyobyw/13nVw3+V6RG2ZfXcvx+
 d56TONIQzqZCOM7JhZX9DpzkGVBeisRIO4hK1XfFbZ7X/AVcJ8efavjs7XdE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CgBhQdnOcEPacNm319EGbjVei9WhD90Cu
Content-Type: multipart/mixed; boundary="Uatfwh4dKnxbBn1mvmeiSTQlmo76g3Ozv"

--Uatfwh4dKnxbBn1mvmeiSTQlmo76g3Ozv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/9 =E4=B8=8A=E5=8D=8811:45, Andreas F=C3=A4rber wrote:
> Hello,
>=20
> On arm64 I'm seeing a regression between next-20191031 and next-2019110=
5
> that breaks boot from my btrfs rootfs: next-20191105 and later oopses o=
n
> found->lock, or with CONFIG_BTRFS_ASSERT asserts on a NULL "found"
> variable in btrfs_update_space_info().
>=20
> According to git-blame that code hasn't changed in months, and I didn't=

> spot an obvious cause among the fs/btrfs/ commis between those two tags=
=2E

It looks like caused by "btrfs: block-group: Refactor
btrfs_read_block_groups()".

Due to another refactor, there are conflicts in that patch and is not
resolved properly.

Please try David's latest misc-next branch, which includes the proper
rebased refactor.

e38b826dc9f0214517b4204eb9b726874145c9ee (david/misc-next)

Thanks,
Qu

>=20
> [    3.512280] sd 0:0:0:0: [sda] Attached SCSI disk
> [    3.520043] BTRFS: device label rootfs devid 1 transid 490 /dev/root=

> scanned by swapper/0 (1)
> [    3.529701] BTRFS info (device sda3): disk space caching is enabled
> [    3.536182] BTRFS info (device sda3): has skinny extents
> [    3.547836] assertion failed: found, in fs/btrfs/space-info.c:124
> [    3.554171] ------------[ cut here ]------------
> [    3.558923] kernel BUG at fs/btrfs/ctree.h:3118!
> [    3.563673] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    3.569312] Modules linked in:
> [    3.572465] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.4.0-rc6-next-20191105+ #110
> [    3.580335] Hardware name: Zidoo X9S (DT)
> [    3.584463] pstate: 40000005 (nZcv daif -PAN -UAO)
> [    3.589401] pc : assfail.constprop.0+0x24/0x28
> [    3.593975] lr : assfail.constprop.0+0x24/0x28
> [    3.598543] sp : ffff80001002b7d0
> [    3.601954] x29: ffff80001002b7d0 x28: 0000000000000000
> [    3.607420] x27: 0000000000000001 x26: 0000000000000001
> [    3.612885] x25: 0000000000000000 x24: ffff80001002b890
> [    3.618350] x23: 0000000000000000 x22: ffff00007c7d0000
> [    3.623815] x21: 0000000000800000 x20: 0000000000000001
> [    3.629281] x19: 0000000000000000 x18: 0000000000000000
> [    3.634746] x17: 000000009b04d1f2 x16: 0000000000000014
> [    3.640211] x15: 000000000000000a x14: 0720072007200720
> [    3.645676] x13: 0720072007200720 x12: 0720072007200720
> [    3.651141] x11: 073407320731073a x10: 0763072e076f0766
> [    3.656606] x9 : 076e0769072d0765 x8 : 0000000000000000
> [    3.662071] x7 : 0000000000000007 x6 : 0000000000000000
> [    3.667536] x5 : 0000000000000000 x4 : 0000000000000000
> [    3.673000] x3 : 0000000000000000 x2 : 00e5bec8376cfb00
> [    3.678465] x1 : 0000000000000000 x0 : 0000000000000035
> [    3.683930] Call trace:
> [    3.686455]  assfail.constprop.0+0x24/0x28
> [    3.690672]  btrfs_update_space_info+0x5c/0xe4
> [    3.695248]  btrfs_read_block_groups+0x470/0x620
> [    3.700001]  open_ctree+0x1500/0x1ae8
> [    3.703775]  btrfs_mount_root+0x38c/0x450
> [    3.707904]  legacy_get_tree+0x2c/0x54
> [    3.711766]  vfs_get_tree+0x28/0xd4
> [    3.715361]  fc_mount+0x14/0x44
> [    3.718599]  vfs_kern_mount.part.0+0x74/0x98
> [    3.722994]  vfs_kern_mount+0x10/0x20
> [    3.726767]  btrfs_mount+0x624/0x6cc
> [    3.730450]  legacy_get_tree+0x2c/0x54
> [    3.734312]  vfs_get_tree+0x28/0xd4
> [    3.737904]  do_mount+0x52c/0x728
> [    3.741318]  ksys_mount+0xb4/0xc4
> [    3.744734]  mount_block_root+0x12c/0x2d8
> [    3.748861]  mount_root+0x7c/0x88
> [    3.752275]  prepare_namespace+0x15c/0x16c
> [    3.756491]  kernel_init_freeable+0x1e0/0x224
> [    3.760977]  kernel_init+0x10/0xf8
> [    3.764483]  ret_from_fork+0x10/0x18
> [    3.768171] Code: 913f6842 b0003260 91337800 97f6e0d0 (d4210000)
> [    3.774446] ---[ end trace 21d95ef2db268f8d ]---
> [    3.779221] note: swapper/0[1] exited with preempt_count 1
> [    3.784910] Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x0000000b
> [    3.792786] SMP: stopping secondary CPUs
> [    3.796824] Kernel Offset: disabled
> [    3.800415] CPU features: 0x00002,20002004
> [    3.804626] Memory Limit: none
> [    3.807780] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=3D0x0000000b ]---
>=20
> Kindly revert the tree to some working state again.
>=20
> Thanks,
> Andreas
>=20


--Uatfwh4dKnxbBn1mvmeiSTQlmo76g3Ozv--

--CgBhQdnOcEPacNm319EGbjVei9WhD90Cu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3GOgUACgkQwj2R86El
/qiuuQgAon8VS67WMviN/2cIX6ex7crdFoSIly27Yo+mLtny588fytce+esiV499
o27RAND/U7gm/dr6+NFVAMVriumVobxgrPJf4Cf3nHJFueT6wHJ99EhUXmgZ2gxY
b38VziqhqO83odQMzJBtb3DuEvlsWhyJuTuFUc6x03HUVM3R3hWiukLytB7SP70s
r+bzDjqSvjVC3IFtmYbdkwM42dGp5Jr2W2QeikalV8yhu5WbDCbVKFj/YwqGWYYi
YEfV2WyNYg8lgzHDjRHtPmur4k0M+9sedP69vwR42t2dzIQT2Oe5K2PTSToQUix+
lOjxKtSfiVnMo2CJE0g32a8PizorOg==
=Vjab
-----END PGP SIGNATURE-----

--CgBhQdnOcEPacNm319EGbjVei9WhD90Cu--
