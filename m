Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C64B5AFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 07:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfIRFoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 01:44:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:51203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfIRFoe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 01:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568785465;
        bh=mMKszs5ac/FP5VpO1ZvIpvYRTFuIF/tOSAoz319aF0E=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=ZixKVgFrJ50axrsPXQKMzVNod63xVcoPj6n5fobtErbinT2ucyeR4qCCkImKxnheD
         bjmU/58Eo/PKpmYJB8gKmDVkv3Zlt6feaHMkx+2K3d9j0PtgVPj6IM+tuj/kntYe18
         Zsj19xSDMQJ+HBp8TevgINntuMGBxRux0w4f7giM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvqW-1hcmAo0qiE-00b4mR; Wed, 18
 Sep 2019 07:44:25 +0200
Subject: Re: BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2bf/0x330
 [btrfs]
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Cebtenzzre <cebtenzzre@gmail.com>, linux-btrfs@vger.kernel.org
References: <11898294e644baf5da8121f2c0f3d71e155a7352.camel@gmail.com>
 <752f6e85-7466-2773-932c-0bbc20c7bcd6@gmx.com>
 <fbe5c62b275d8338d79617cdf6d0d6aadae5823f.camel@gmail.com>
 <6038d948-a2ec-7ca8-4892-c20d59b0c5de@gmx.com>
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
Message-ID: <b1295acb-3943-ba25-624a-a37f3871a564@gmx.com>
Date:   Wed, 18 Sep 2019 13:44:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <6038d948-a2ec-7ca8-4892-c20d59b0c5de@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PISwmMckhNUMUTpeGc8rSTBbxY7w6ODwo"
X-Provags-ID: V03:K1:fnInEIh+ccomeGFhxHpSdHYHYJN+9kuos9TRWMxRAeK/4VC9OD+
 5TKBkfptF/01u8DQlee+tp+V2lXm2vmcN9MTAqq61heltScgin7Q1loT/MBT2UzD78rqSg/
 xdkrHQSCQ04o0OIfElT+8Y50OFdq3REAw/+l7zlzEDo8rnweJX0lnIHQydwiapUYjtKtG21
 MTl2s+utBsS2UydRTksdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r8wEenJPzqI=:2/BPYfQk9HJ7+RReOhGLz5
 b3OCzUw1kc6HfivIWsy8P649WQw+VFVox1Wi4QEDn3qtyosauF768hPYfy1rFnrDhR97sJLsc
 9q7PxBvHjJ2PrW8KmEpnfdNG+vOg0r2uunuTjlyOxpaTdCiHHroCMUjRErwZM99uU1ms5UcDm
 Fll7utSstNq4O8D1kvD0HwDfYAqSRfKHLsVseTPtPsvsmWKrVxfQiFBJXR8i+SDyW7vdsgu81
 6XgTSd5+4/7W1RqVrW79nkQTxFmjNZi1A4yeQoLzGV5hoeAIbBr0MuCkUWMMfB/JfRI8RZVqV
 SKrTPzUd0UAeDzictgJ6bGYQ7aF7sOl1GeVLq/Hoqx2NciJX/yfFEQR/Ccf+JKdLvcnD+xsRA
 SzXwQrrfs6cENDHReXYCsEFV1NN+cPFnT3tdROc+sNQxUEyVJvNv5/wJj+VZuLNQa5fEI9qpq
 qJ+/rDdYvXstqGHBtthtrs7khFe2pYRyORTi7UguXR+5zu/JDxmSZmE6yeDURei1ANuOoWTHV
 L52unct613MBQu3FJbN0efIZAhoAjPQi05fkueNhUQNC2t29sRM6lgko7CYciCLYUATG+sNq9
 AmButGrbd4OtA+7psoYdqHcBtU1koPIRFfpGXoACgVrkZccbNthqoP2wZ6BgEoPe7f1p25tq8
 gtjd43dzF2euHD/qTLQsDDX9N+jwjTddnrkWslGlF1LGQIU6wViWPlrX/q4ySP5if1kIEU8SH
 orHI8FIXfWTKXnuXvhTuxPSgHs7AV4ooIkaNazOq8v87dYxXQy4+oxW28YPMphOV/RMoolWeR
 3z5PXXNtjcrCzeoLZn7EqHXXT9CW6PAgK9dsOxCmSoWG03wPViU+fvp8fiCFrPWw0gYm5L424
 s4Mc80oQonWq3VQMvE3nruFS5kW3GRlFOQbUyjHCtoiy5u6UwEn+jp6ihJTPnoEW9G0Kctw6e
 5lEDQzzXrGrTnnbZZS5t/o2WPQ6w/sPwkDmJ7f4eD3Ik8pKiWrwiUfVmxS2SIP17bBFrRcjb/
 IG35SHPRLKh+6kDtrFF99OZtZjqJOB9HcvEtuMGsp1HKAAzRfe68UzqQBoLabgGpZcBiMSGMB
 B3gTZIvFCZAXmmt9xD33/1y1inkw+aEn0Umps7NPKIeZYso9iev0iqUWedNL2HYpP+b0jxkXd
 REW6JgJReoYkGhURw7nSf4LL1Lfze8l9GLpbbtC2ZomtA0ZQzPVmDghZAhCrsE0fd0fyhr+Bz
 4sHfamdIa0FAmNE+W8jQfz0SmGcJLImyLKBS/zUpfiwtqhubA1e9SUk29c84=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PISwmMckhNUMUTpeGc8rSTBbxY7w6ODwo
Content-Type: multipart/mixed; boundary="Whh82R572rDApoOItCnSjJ2zPvbr1Mtb5"

--Whh82R572rDApoOItCnSjJ2zPvbr1Mtb5
Content-Type: multipart/mixed;
 boundary="------------6AEFFA40B4B4CF802C492EB2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6AEFFA40B4B4CF802C492EB2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8A=E5=8D=888:14, Qu Wenruo wrote:
> [...]
>>
>>> My config results something doesn't make sense at all.
>>>
>>>> [49294.092645] Write of size 8 at addr ffff8885b4901440 by task kwor=
ker/u24:6/10894
>>>>
>>>> [49294.092657] CPU: 8 PID: 10894 Comm: kworker/u24:6 Tainted: P     =
      OE     5.3.0-rc8-rc-kasan #2
>>>> [49294.092661] Hardware name: To Be Filled By O.E.M. To Be Filled By=
 O.E.M./X99 Extreme4, BIOS P3.80 04/06/2018
>>>> [49294.092726] Workqueue: btrfs-endio-write btrfs_endio_write_helper=
 [btrfs]
>>>> [49294.092730] Call Trace:
>>>> [49294.092743]  dump_stack+0x71/0xa0
>>>> [49294.092751]  print_address_description+0x67/0x323
>>>> [49294.092817]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>>> [49294.092879]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>>> [49294.092884]  __kasan_report.cold+0x1a/0x3d
>>>> [49294.092945]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>>> [49294.092951]  kasan_report+0xe/0x12
>>>> [49294.093012]  btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> We need code contex of this,
>>
>> That would be +0x2cd on my 5.2.11 build, which according to GDB is her=
e:
>>
>> (gdb)  list *(btrfs_init_reloc_root+0x2cd)
>> 0x1dcbdd is in btrfs_init_reloc_root (fs/btrfs/relocation.c:1456).
>> 1451		reloc_root =3D create_reloc_root(trans, root, root->root_key.obj=
ectid);
>> 1452		if (clear_rsv)
>> 1453			trans->block_rsv =3D rsv;
>> 1454=09
>> 1455		ret =3D __add_reloc_root(reloc_root);
>> 1456		BUG_ON(ret < 0);
>> 1457		root->reloc_root =3D reloc_root;
>> 1458		return 0;
>> 1459	}
>> 1460
>>
>> But according to faddr2line, it is at relocation.c:1438.
>>
>> $ ./scripts/faddr2line fs/btrfs/btrfs.ko btrfs_init_reloc_root+0x2cd
>> btrfs_init_reloc_root+0x2cd/0x340:
>> btrfs_init_reloc_root at /path/to/linux/fs/btrfs/relocation.c:1438
>>
>> That is here:
>>
>> (gdb) list relocation.c:1438
>> 1433		int clear_rsv =3D 0;
>> 1434		int ret;
>> 1435=09
>> 1436		if (root->reloc_root) {
>> 1437			reloc_root =3D root->reloc_root;
>> 1438			reloc_root->last_trans =3D trans->transid;

This should the correct line.

According to your backtrace, the problem seesms to be caused by some
race, and of course it's caused by my reloc tree lifespan commit.

However my test environment is really bad at catching race related proble=
ms.

So would you please try this attached patch to see if it solves the
kasan bug?

Thanks,
Qu

> [...]

--------------6AEFFA40B4B4CF802C492EB2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-relocation-Fix-KASAN-report-about-use-after-fr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-btrfs-relocation-Fix-KASAN-report-about-use-after-fr.pa";
 filename*1="tch"

=46rom 158a6fb4b5e0143f2058dcc6e17fe5e61245ede4 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 18 Sep 2019 13:00:25 +0800
Subject: [PATCH] btrfs: relocation: Fix KASAN report about use-after-free=
 due
 to dead reloc tree cleanup race

[BUG]
One user reported a reproduciable KASAN report about use-after-free:
  BTRFS info (device sdi1): balance: start -dvrange=3D1256811659264..1256=
811659265
  BTRFS info (device sdi1): relocating block group 1256811659264 flags da=
ta|raid0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2cd/0x340 [btrfs]=

  Write of size 8 at addr ffff88856f671710 by task kworker/u24:10/261579

  CPU: 2 PID: 261579 Comm: kworker/u24:10 Tainted: P           OE     5.2=
=2E11-arch1-1-kasan #4
  Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X99 Extrem=
e4, BIOS P3.80 04/06/2018
  Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
  Call Trace:
   dump_stack+0x7b/0xba
   print_address_description+0x6c/0x22e
   ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
   __kasan_report.cold+0x1b/0x3b
   ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
   kasan_report+0x12/0x17
   __asan_report_store8_noabort+0x17/0x20
   btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
   record_root_in_trans+0x2a0/0x370 [btrfs]
   btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
   start_transaction+0x1ab/0xe90 [btrfs]
   btrfs_join_transaction+0x1d/0x20 [btrfs]
   btrfs_finish_ordered_io+0x7bf/0x18a0 [btrfs]
   ? lock_repin_lock+0x400/0x400
   ? __kmem_cache_shutdown.cold+0x140/0x1ad
   ? btrfs_unlink_subvol+0x9b0/0x9b0 [btrfs]
   finish_ordered_fn+0x15/0x20 [btrfs]
   normal_work_helper+0x1bd/0xca0 [btrfs]
   ? process_one_work+0x819/0x1720
   ? kasan_check_read+0x11/0x20
   btrfs_endio_write_helper+0x12/0x20 [btrfs]
   process_one_work+0x8c9/0x1720
   ? pwq_dec_nr_in_flight+0x2f0/0x2f0
   ? worker_thread+0x1d9/0x1030
   worker_thread+0x98/0x1030
   kthread+0x2bb/0x3b0
   ? process_one_work+0x1720/0x1720
   ? kthread_park+0x120/0x120
   ret_from_fork+0x35/0x40

  Allocated by task 369692:
   __kasan_kmalloc.part.0+0x44/0xc0
   __kasan_kmalloc.constprop.0+0xba/0xc0
   kasan_kmalloc+0x9/0x10
   kmem_cache_alloc_trace+0x138/0x260
   btrfs_read_tree_root+0x92/0x360 [btrfs]
   btrfs_read_fs_root+0x10/0xb0 [btrfs]
   create_reloc_root+0x47d/0xa10 [btrfs]
   btrfs_init_reloc_root+0x1e2/0x340 [btrfs]
   record_root_in_trans+0x2a0/0x370 [btrfs]
   btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
   start_transaction+0x1ab/0xe90 [btrfs]
   btrfs_start_transaction+0x1e/0x20 [btrfs]
   __btrfs_prealloc_file_range+0x1c2/0xa00 [btrfs]
   btrfs_prealloc_file_range+0x13/0x20 [btrfs]
   prealloc_file_extent_cluster+0x29f/0x570 [btrfs]
   relocate_file_extent_cluster+0x193/0xc30 [btrfs]
   relocate_data_extent+0x1f8/0x490 [btrfs]
   relocate_block_group+0x600/0x1060 [btrfs]
   btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
   btrfs_relocate_chunk+0x9e/0x180 [btrfs]
   btrfs_balance+0x14e4/0x2fc0 [btrfs]
   btrfs_ioctl_balance+0x47f/0x640 [btrfs]
   btrfs_ioctl+0x119d/0x8380 [btrfs]
   do_vfs_ioctl+0x9f5/0x1060
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x73/0xb0
   do_syscall_64+0xa5/0x370
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

  Freed by task 369692:
   __kasan_slab_free+0x14f/0x210
   kasan_slab_free+0xe/0x10
   kfree+0xd8/0x270
   btrfs_drop_snapshot+0x154c/0x1eb0 [btrfs]
   clean_dirty_subvols+0x227/0x340 [btrfs]
   relocate_block_group+0x972/0x1060 [btrfs]
   btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
   btrfs_relocate_chunk+0x9e/0x180 [btrfs]
   btrfs_balance+0x14e4/0x2fc0 [btrfs]
   btrfs_ioctl_balance+0x47f/0x640 [btrfs]
   btrfs_ioctl+0x119d/0x8380 [btrfs]
   do_vfs_ioctl+0x9f5/0x1060
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x73/0xb0
   do_syscall_64+0xa5/0x370
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

  The buggy address belongs to the object at ffff88856f671100
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 1552 bytes inside of
   4096-byte region [ffff88856f671100, ffff88856f672100)
  The buggy address belongs to the page:
  page:ffffea0015bd9c00 refcount:1 mapcount:0 mapping:ffff88864400e600 in=
dex:0x0 compound_mapcount: 0
  flags: 0x2ffff0000010200(slab|head)
  raw: 02ffff0000010200 dead000000000100 dead000000000200 ffff88864400e60=
0
  raw: 0000000000000000 0000000000070007 00000001ffffffff 000000000000000=
0
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff88856f671600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   ffff88856f671680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  >ffff88856f671700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                           ^
   ffff88856f671780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   ffff88856f671800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  BTRFS info (device sdi1): 1 enospc errors during balance
  BTRFS info (device sdi1): balance: ended with status: -28

[CAUSE]
The problem happens when finish_ordered_io() get called with balance
still running, while the reloc root of that subvolume is already dead.
(tree swap already done, but tree not yet deleted for possible qgroup
usage)

That means root->reloc_root still exists, but that reloc_root can be
under btrfs_drop_snapshot(), thus we shouldn't access it.

The following race could cause the use-after-free problem:

                CPU1              |                CPU2
-------------------------------------------------------------------------=
-
                                  | relocate_block_group()
                                  | |- unset_reloc_control(rc)
                                  | |- btrfs_commit_transaction()
btrfs_finish_ordered_io()         | |- clean_dirty_subvols()
|- btrfs_join_transaction()       |    |
   |- record_root_in_trans()      |    |
      |- btrfs_init_reloc_root()  |    |
         |- if (root->reloc_root) |    |
         |                        |    |- root->reloc_root =3D NULL
         |                        |    |- btrfs_drop_snapshot(reloc_root)=
;
         |- reloc_root->last_trans|
                 =3D trans->transid |
	    ^^^^^^^^^^^^^^^^^^^^^^
            Use after free

[FIX]
Fix it by the following modifications:
- Test if the root has dead reloc tree before accessing root->reloc_root
  If the root has BTRFS_ROOT_DEAD_RELOC_TREE, then we don't need to
  create or update root->reloc_tree

- Clear the BTRFS_ROOT_DEAD_RELOC_TREE flag until we have fully dropped
  reloc tree
  To co-operate with above modification, so as long as
  BTRFS_ROOT_DEAD_RELOC_TREE is still set, we won't try to re-create
  reloc tree at record_root_in_trans().

Reported-by: Cebtenzzre <cebtenzzre@gmail.com>
Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after =
merge_reloc_roots")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7f219851fa23..d60993a8b2ae 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1434,16 +1434,19 @@ int btrfs_init_reloc_root(struct btrfs_trans_hand=
le *trans,
 	int clear_rsv =3D 0;
 	int ret;
=20
-	if (root->reloc_root) {
+	if (!test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) &&
+	    root->reloc_root) {
 		reloc_root =3D root->reloc_root;
 		reloc_root->last_trans =3D trans->transid;
 		return 0;
 	}
=20
 	if (!rc || !rc->create_reloc_tree ||
-	    root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID)
+	    root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID ||
+	    test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
 		return 0;
=20
+
 	if (!trans->reloc_reserved) {
 		rsv =3D trans->block_rsv;
 		trans->block_rsv =3D rc->block_rsv;
@@ -2186,7 +2189,6 @@ static int clean_dirty_subvols(struct reloc_control=
 *rc)
 			/* Merged subvolume, cleanup its reloc root */
 			struct btrfs_root *reloc_root =3D root->reloc_root;
=20
-			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 			list_del_init(&root->reloc_dirty_list);
 			root->reloc_root =3D NULL;
 			if (reloc_root) {
@@ -2195,6 +2197,7 @@ static int clean_dirty_subvols(struct reloc_control=
 *rc)
 				if (ret2 < 0 && !ret)
 					ret =3D ret2;
 			}
+			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 			btrfs_put_fs_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
--=20
2.23.0


--------------6AEFFA40B4B4CF802C492EB2--

--Whh82R572rDApoOItCnSjJ2zPvbr1Mtb5--

--PISwmMckhNUMUTpeGc8rSTBbxY7w6ODwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2BxDQACgkQwj2R86El
/qgqXgf+KGzcJKFtstDjAupRNzO2pMWxcKZ56kFF3CYbMRWU3o6vo38z91q+JXIV
IGSaTwDp5X2WXGYoM2eNg/dKoAr+RFeYOby43goMdvlWfzUsWlo5lYCS/j63Ol0v
q5urZ3k1Tdu6Av0cjTIh4LoMsFVi9RTiBl5qeKeZ6dVzrABdEQp8klEgOlVWdnWU
33VdN2p3yySUx/f7g7vzwKDRskUuJnpDEuScvwFSyQnNNNYZxVv578hwrCVE2oZa
rQ/BjpGCmbYiNsjrhgsSRCXb9g7IakplNFNg/aFXZkb4u4YzjCAVu3XsYzYb6f5g
o2oaRSEe2d0H16EapOwC75OWxg9PSA==
=NsB/
-----END PGP SIGNATURE-----

--PISwmMckhNUMUTpeGc8rSTBbxY7w6ODwo--
