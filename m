Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF985B2EDC
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfIOG4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 02:56:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:58045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfIOG4q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 02:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568530603;
        bh=5xV54re+GcZfLgNZAKqIQF9y38tgG4/ilYBL54iX3sU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BSp4s31DKvJFKdz/vQZ77aC6zVmJNH3MqFX6sHfcSyF0+tLTkG9048xmu2Uzdn2+9
         uWcBKhoRjfvNuEpddSwvYJJWP8mUnU1zhPVRUuYhhUzJgkDNftTkndfCWeo6P9zPET
         CI1IDoKPVLRnmRGwddKsgRxRllYimwogeESavwCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKKX-1htiCZ29wP-00Fgxb; Sun, 15
 Sep 2019 08:56:43 +0200
Subject: Re: BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2bf/0x330
 [btrfs]
To:     Cebtenzzre <cebtenzzre@gmail.com>, linux-btrfs@vger.kernel.org
References: <11898294e644baf5da8121f2c0f3d71e155a7352.camel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <752f6e85-7466-2773-932c-0bbc20c7bcd6@gmx.com>
Date:   Sun, 15 Sep 2019 14:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <11898294e644baf5da8121f2c0f3d71e155a7352.camel@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ejb7uEexcKpjBs2442uqiLL8rkoIUeqkc"
X-Provags-ID: V03:K1:x8y1cJbwvlNPfATWnJQTLh5zpPsyamQog5h0uNk0Af6KjaLVGGY
 IN1FlsMyUSJUGWUYrhDPPODxpbeD2sCefSElLnH5RIOnIYxMzinDR59L2cBow0y7VB5DKRx
 ZnqybSQSZAVbZg4iVK7K9R6OoFJs/BZR9UjTEi1Jb9NPIN4qexTJSJew8M85ZX6KomohBuh
 tm4tFt4JMeDIRemhLtNoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7KPNP7+l+G4=:4kwcJqIGjoWlBiVozidk7U
 8Z3axJjXG17D7hNPBwAgRZa4eI/Z/b2oom+a5uJTPZNN7AO6aL+tthvZcEsKVC1kzh38Uu8Y2
 J6xDSI4A12czRZxOKoEi2LRIAqHToddquu3qBYqdXPcz99W1PByAqIQ66LnRdB2XFNr6FpJBo
 EM42eQhIb1KoMFstXZFfPyQhENPkx6crpbPw9sYLPnnqML7T1Dmgzp1yyj8NjQTE4z0lHrJx7
 Vv/E3lOf1LA2bLhv3HvbtuQci1oKaT63wwUF1rDoWXohN9EwSE5zOzPK63iTMfkfpBqCI3QzY
 EPnzNPuoMRNTs/CtKIVOv63xzb7PpO2qmAd4iH25/nFAzFKbUMlpDvuRqDFeZHE9CixPTOQfp
 oMJNQpwykFfmhbnpqquV4T3aWjWKtkBSXiWYCbHqQijjKqiwPSBG8/kBPwh5Dyn82yfihvWjz
 ca51h9lDsF4uneAziqgUfjLfpgrm2fRIRob8ycmm2w8jwavTMNYv4nkgknKJKzgh0YbHqJqei
 pR+W/eMb8WD950Q/L2HtDM84H4we0wTK/Hd9RD3TyDgBRS2puaeYVnlcUCi+AgFMEB87yvedG
 UxURs03MVVSMijXtenE0HuIjKb0iDd/wrRBp3htcVdoaHaKJ1d/K703BZs5euhKQ0jZ2Z25AX
 WuF+eYsEfmB9eIu3kOdGdjVtohzrn7LD3/RmdsOeZAz5KDNzcKRVluQf+0nsY4ucHirZbM0l/
 g5s6raoyjTXjMaXXzMzPEbnNI8D+JWCyzFoHcHZbyvYHgOQzvN63kW+buR+N+PVaMINNv7rwi
 vTBHM9DiHAniiAPPurwYarL7BW9i/cFZm7V61h9uWAaA2QjYsxD0XkIGzwSj8Efb1RjcxAM9p
 nYtEvpcaZGWjoinAmulonReIeaRokXLMLM1i4e6TjUL4HoKr5RKeLWoABQGvAZVxGFszypEr2
 LzRZQCGlIoJ/ERGmqmrZLL7QQhTuLyiIjoKh0CLD00St5wZpondpUapMu7votRqaycYNR/4Ea
 lR4y5BvJ8drd6fxQ5ACnO5ze2ud0mjJDl9T6hOPE2qyqIHIRDQHxnJu4Yx1kW7vsRQUCnVK6N
 g18QEvWmzhOpjXtjRJQJ7gj2EmgSWEgrniQYhgEwM4ATWmdLQSJwtvNIzzC5J2IglfXvvtRjf
 x1QGwAc/Rf4hxKwpvh6f7pKHxuEy3EsAq252+1LfGkUjgQhvrzM7Ftc1ErdYBsIRNQ2h/aGuf
 pglVvZOXJdN14B+34OY+1GP4kkSU6GMJmCLONBRA+Wiy2K9qcHDLuRl6ba4k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ejb7uEexcKpjBs2442uqiLL8rkoIUeqkc
Content-Type: multipart/mixed; boundary="t03GsSTRWlnm8qMsCerRQqA4n7nqmLvZ6"

--t03GsSTRWlnm8qMsCerRQqA4n7nqmLvZ6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/15 =E4=B8=8A=E5=8D=884:52, Cebtenzzre wrote:
> I have been able to trigger a use-after-free in btrfs on a stock Arch
> Linux kernel, versions 5.2.9 and 5.2.11. I also reproduced it on
> kernel.org mainline 5.3-rc8, resulting in this KASAN report:
>=20
>=20
> [49286.511157] BTRFS info (device sdi1): balance: start -dvrange=3D2221=
681934336..2221681934337
> [49286.515651] BTRFS info (device sdi1): relocating block group 2221681=
934336 flags data|raid0
> [49294.092536] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [49294.092637] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2b=
f/0x330 [btrfs]

It would be much nicer if you could provide the code context by using
1) gdb:
   $gdb fs/btrfs/btrfs.ko
    list *(btrfs_init_reloc_root+0x2bf)

2) faddr2line scripts:
   <in linux kernel source code directory>
   $ ./scripts/faddr2line fs/btrfs/btrfs.kobtrfs_init_reloc_root+0x2bf

My config results something doesn't make sense at all.

> [49294.092645] Write of size 8 at addr ffff8885b4901440 by task kworker=
/u24:6/10894
>=20
> [49294.092657] CPU: 8 PID: 10894 Comm: kworker/u24:6 Tainted: P        =
   OE     5.3.0-rc8-rc-kasan #2
> [49294.092661] Hardware name: To Be Filled By O.E.M. To Be Filled By O.=
E.M./X99 Extreme4, BIOS P3.80 04/06/2018
> [49294.092726] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> [49294.092730] Call Trace:
> [49294.092743]  dump_stack+0x71/0xa0
> [49294.092751]  print_address_description+0x67/0x323
> [49294.092817]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
> [49294.092879]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
> [49294.092884]  __kasan_report.cold+0x1a/0x3d
> [49294.092945]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
> [49294.092951]  kasan_report+0xe/0x12
> [49294.093012]  btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
We need code contex of this,

> [49294.093066]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
> [49294.093119]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
> [49294.093170]  start_transaction+0x1c3/0xea0 [btrfs]
> [49294.093226]  btrfs_finish_ordered_io+0x811/0x1610 [btrfs]
> [49294.093233]  ? syscall_return_via_sysret+0xf/0x7f
> [49294.093238]  ? syscall_return_via_sysret+0xf/0x7f
> [49294.093243]  ? __switch_to_asm+0x40/0x70
> [49294.093248]  ? __switch_to_asm+0x34/0x70
> [49294.093300]  ? btrfs_unlink_subvol+0xa30/0xa30 [btrfs]
> [49294.093307]  ? finish_task_switch+0x1a1/0x760
> [49294.093312]  ? __switch_to+0x457/0xe90
> [49294.093317]  ? __switch_to_asm+0x34/0x70
> [49294.093378]  normal_work_helper+0x15a/0xb90 [btrfs]
> [49294.093387]  process_one_work+0x706/0x1200
> [49294.093394]  worker_thread+0x92/0xfb0
> [49294.093401]  ? __kthread_parkme+0x85/0x100
> [49294.093406]  ? process_one_work+0x1200/0x1200
> [49294.093410]  kthread+0x2ba/0x3b0
> [49294.093414]  ? kthread_park+0x130/0x130
> [49294.093420]  ret_from_fork+0x35/0x40
>=20
> [49294.093431] Allocated by task 11689:
> [49294.093441]  __kasan_kmalloc.part.0+0x3c/0xa0
> [49294.093493]  btrfs_read_tree_root+0x8f/0x350 [btrfs]
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This,

> [49294.093542]  btrfs_read_fs_root+0xc/0xc0 [btrfs]
> [49294.093601]  create_reloc_root+0x445/0x920 [btrfs]
> [49294.093660]  btrfs_init_reloc_root+0x1da/0x330 [btrfs]
> [49294.093709]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
> [49294.093758]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
> [49294.093806]  start_transaction+0x1c3/0xea0 [btrfs]
> [49294.093856]  __btrfs_prealloc_file_range+0x1c2/0xa50 [btrfs]
> [49294.093907]  btrfs_prealloc_file_range+0x10/0x20 [btrfs]
> [49294.093966]  prealloc_file_extent_cluster+0x24e/0x4a0 [btrfs]
> [49294.094025]  relocate_file_extent_cluster+0x193/0xc90 [btrfs]
> [49294.094083]  relocate_data_extent+0x1f2/0x460 [btrfs]
> [49294.094142]  relocate_block_group+0x5a5/0xf50 [btrfs]
> [49294.094200]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
> [49294.094258]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
> [49294.094315]  btrfs_balance+0x1292/0x2f00 [btrfs]
> [49294.094373]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
> [49294.094430]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
> [49294.094434]  do_vfs_ioctl+0x99f/0xf10
> [49294.094437]  ksys_ioctl+0x5e/0x90
> [49294.094440]  __x64_sys_ioctl+0x6f/0xb0
> [49294.094446]  do_syscall_64+0xa0/0x370
> [49294.094451]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> [49294.094457] Freed by task 11689:
> [49294.094464]  __kasan_slab_free+0x144/0x1f0
> [49294.094468]  kfree+0x95/0x2a0
> [49294.094516]  btrfs_drop_snapshot+0x1529/0x1c40 [btrfs]
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
And this.

> [49294.094573]  clean_dirty_subvols+0x23f/0x380 [btrfs]
> [49294.094632]  relocate_block_group+0x95b/0xf50 [btrfs]
> [49294.094691]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
> [49294.094748]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
> [49294.094805]  btrfs_balance+0x1292/0x2f00 [btrfs]
> [49294.094863]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
> [49294.094920]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
> [49294.094923]  do_vfs_ioctl+0x99f/0xf10
> [49294.094926]  ksys_ioctl+0x5e/0x90
> [49294.094929]  __x64_sys_ioctl+0x6f/0xb0
> [49294.094934]  do_syscall_64+0xa0/0x370
> [49294.094939]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> [49294.094946] The buggy address belongs to the object at ffff8885b4901=
100
>                 which belongs to the cache kmalloc-2k of size 2048
> [49294.094953] The buggy address is located 832 bytes inside of
>                 2048-byte region [ffff8885b4901100, ffff8885b4901900)
> [49294.094957] The buggy address belongs to the page:
> [49294.094962] page:ffffea0016d24000 refcount:1 mapcount:0 mapping:ffff=
88864400e800 index:0x0 compound_mapcount: 0
> [49294.094968] flags: 0x2ffff0000010200(slab|head)
> [49294.094976] raw: 02ffff0000010200 dead000000000100 dead000000000122 =
ffff88864400e800
> [49294.094981] raw: 0000000000000000 00000000800f000f 00000001ffffffff =
0000000000000000
> [49294.094983] page dumped because: kasan: bad access detected
>=20
> [49294.094987] Memory state around the buggy address:
> [49294.094992]  ffff8885b4901300: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> [49294.094997]  ffff8885b4901380: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> [49294.095002] >ffff8885b4901400: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> [49294.095006]                                            ^
> [49294.095010]  ffff8885b4901480: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> [49294.095015]  ffff8885b4901500: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> [49294.095018] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [49301.893672] BTRFS info (device sdi1): 1 enospc errors during balance=

> [49301.893675] BTRFS info (device sdi1): balance: ended with status: -2=
8
>=20
>=20
> Without KASAN, I would eventually get an oops like this:
>=20
>[...]
>=20
> I only noticed this bug because I keep an eye on dmesg. In one instance=
,
> I ignored it for a few hours, then my graphics driver crashed because o=
f
> memory allocation failure and/or heap corruption. Aside from that, I
> have seen no obvious effects.
>=20
> I have hit this bug at least 5 times over the last two weeks. Every
> time, it has been caused by a balance on various volumes (typically to
> balance a single block group). I was able to trigger it somewhat
> reliably by attempting a balance on a volume with a size of 596.18GiB
> and 1.68GiB of estimated free space, but that stopped working
> eventually.

Is it always that particular fs?
Have you ever hit it on another fs?
Furthermore, did you hit it in v5.1?

I guess there is a chance my previous change of reloc tree lifespan
screwed up something, but it's introduced in v5.1...

Thanks,
Qu


--t03GsSTRWlnm8qMsCerRQqA4n7nqmLvZ6--

--ejb7uEexcKpjBs2442uqiLL8rkoIUeqkc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl194KYACgkQwj2R86El
/qizhAf+OS1NGznhOC/FgNkspHpnmL+vHNX2s/mkR68slIJFlZ2DTXiYZgysPbsM
RZZl2fJJpwq/WyOIO3lXacdm9YkZGxi3e42Ms3QfKJKYNuXFTx4ija1aNPGD28ny
25VvC0gNdSMZoRM0BxxRZNFx9lX7VZThM5ZFe+nKACEIUjGWlBbrVyTJikzJqSkf
6u6tNq9OOSrDT1SIXZfUykK+r86crMZ4R4dsQcVlxjkrdcuAv7LlLDUdLhHWeSwZ
Kg0uf6o2wXf464qPhyeD12xtiN7UxqQB7dQwdWn90BuYEquo3FixP160oPV9hQpw
ytYwY8hXE/++ZhmAs7Fjm/EQHywPTg==
=o4l3
-----END PGP SIGNATURE-----

--ejb7uEexcKpjBs2442uqiLL8rkoIUeqkc--
