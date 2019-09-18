Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F5B58DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfIRAOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 20:14:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:49993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfIRAOl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 20:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568765674;
        bh=w+1hbie677cOigKNxa/LFiGzw+3P+qTErLFp9kvBmug=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KltEkGNgmgBGpYAUJHqmtuDRLUcct/gSggFWKtbYuTj6djKDsi7xQryIz7h04/G3A
         AE7HKn6vGWOUvxQpYA394JehgIXl1mf1LqLXHrfy4k8CUNHayAnqG+INO4rna9Cy85
         Kg5NBDsD/f/e1wvoA3YEHRqnI49tkic6iSbwJnsg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M8laO-1iMRtN0ZAq-00C9Kn; Wed, 18
 Sep 2019 02:14:33 +0200
Subject: Re: BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2bf/0x330
 [btrfs]
To:     Cebtenzzre <cebtenzzre@gmail.com>, linux-btrfs@vger.kernel.org
References: <11898294e644baf5da8121f2c0f3d71e155a7352.camel@gmail.com>
 <752f6e85-7466-2773-932c-0bbc20c7bcd6@gmx.com>
 <fbe5c62b275d8338d79617cdf6d0d6aadae5823f.camel@gmail.com>
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
Message-ID: <6038d948-a2ec-7ca8-4892-c20d59b0c5de@gmx.com>
Date:   Wed, 18 Sep 2019 08:14:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <fbe5c62b275d8338d79617cdf6d0d6aadae5823f.camel@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Km3igoI7X4PEcWURQWWGWQj1DeLPescLo"
X-Provags-ID: V03:K1:th+YQiZkEISVCiw8Tg8U4r22DaxMLkaDM/DA4al04nDUPV1zRl5
 uBCgoSuwZee+ckIohaU5XdLisu5ekpmlFjVAQ3FsYx1+Zb71xGuUwEwcwKdjx5yha05V1nd
 OONfJJj21xtVh0Sr81bSQcLESvOFlfjBCtHyTAQsKcHpnqxVkNa3u571uaU9bfTzvG4Vmsy
 98c13eE3s6gmg2xtuuPcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LSVA1rHu1jo=:6SvbD3Adx05Uaa6pgQlfpG
 VnkS+ha+8TbwUAWUeaS7HOO+bflZPHGrAdywiNyZ9B8JoXYwfdJ4SLNkU0RON7/0akoZIERV5
 BUSDh5VYCxHlKZL0JE/22IpCma1B1JMBbQx/FBRpUVC3yKDbx3rOLE5ErEDGaB4Trk0alrGIO
 aGrI/NUtkxHgPZzKRSDTvUUi9CzVNKUOmtCQ2B9W9Ezrrk8k/3tvlmd7ItbtHg4UtoybBFU1p
 6TgmuRCvHTreDYcedgQSImJF9ZB9TuqbvHiAU35CEzKOFJ53oL7+3Df/Ip3eW1LfvjbllNKdM
 +JzubPjZC2ArMIln1x36+NFOKBLwjpeMDTGYLteCoYvrpD44zripFcM2z2R2jC2J8i17NTdBP
 0cRMXEu+6RVz1JVVTrVNwDTJ0j8BN2RFMzpDwkY/186/WL3FF4Q/L2nCEU8Wg7fUz30CNJCaf
 7TpWPdbe2JAUTf1ghrPBkX44qyz3PY7tVhDGOZvqMOyncwrxMAefCZH2+kVLoyvqv/OWtC/jj
 GD4MyzJYjWmVr72njxQg6Yn/wEU2eqPapGPm9WXzQ+fkfS1yz/BKX17WHVea9Cfe0j5njGN3f
 eGgXmQXEFeqS0A+ABAPuVp9SRPpbNSBdCzthSh78lzQDt2Hwh/2EpTZL91jICaF15iU9EnF6d
 a4NMRhldddxQ7n0Fx3BcTRSeLSglTp1OH2C+UWdDyDIaNosDcjYS5yXFOEdC6TTWUzquwqMvA
 k3eigkv6/ZwQOP7C0oHdJugwsZ/OcMOL3SU6lDOf519QgufAbD41LskPAme2dWCF68ZLQ9cni
 vW+BBgFYTb1UDvfPbI4pNR4EIUtNPsH4L7Ch2/AFY/XBcyVvdtNebtwaqRqBmfKdJ34gXxvtb
 +M+9HyY5ueW96AM0QjBZA3zTDlP9jsWbco1BMB3YvY+xaK+emWF/klfZGthSgiJ9bNJZDDDNh
 cC2CH0eMU6lUaTLa+b+WU9Rf/zrk6VvnwmNKeoht+ezOLldvfMSxCeC3ThLTp3MIkcorAyq2O
 3tD2hJJaiyWHlWDWVrLujCu94/fv37EFvjWTzJbl1rrw2GOZ08yqreHdZDKYXgqnb0J9ELotE
 gC3LJc4c5kBn8fbgNtcPXtq1wiTr4lZaw/yn/hlYLwuH3KzAuQ8E1joF4U15AWzI9K3NcCEs3
 I7DnahYIKM/Jnf8442W8vC+jUyV8xoJp5LYTlMONwTfcOly7cYQhjUX8bHs57SJsqPMeJQGbe
 U83DNWqXexI+AAnotYpIgM8p9umZuSqESRNRIc0Hq9m5N+36YzQu1u2gQzas=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Km3igoI7X4PEcWURQWWGWQj1DeLPescLo
Content-Type: multipart/mixed; boundary="2TwgR7pmxoBO1FV9a2Cwpd62zI8RdwKER"

--2TwgR7pmxoBO1FV9a2Cwpd62zI8RdwKER
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>=20
>> My config results something doesn't make sense at all.
>>
>>> [49294.092645] Write of size 8 at addr ffff8885b4901440 by task kwork=
er/u24:6/10894
>>>
>>> [49294.092657] CPU: 8 PID: 10894 Comm: kworker/u24:6 Tainted: P      =
     OE     5.3.0-rc8-rc-kasan #2
>>> [49294.092661] Hardware name: To Be Filled By O.E.M. To Be Filled By =
O.E.M./X99 Extreme4, BIOS P3.80 04/06/2018
>>> [49294.092726] Workqueue: btrfs-endio-write btrfs_endio_write_helper =
[btrfs]
>>> [49294.092730] Call Trace:
>>> [49294.092743]  dump_stack+0x71/0xa0
>>> [49294.092751]  print_address_description+0x67/0x323
>>> [49294.092817]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>> [49294.092879]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>> [49294.092884]  __kasan_report.cold+0x1a/0x3d
>>> [49294.092945]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>> [49294.092951]  kasan_report+0xe/0x12
>>> [49294.093012]  btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> We need code contex of this,
>=20
> That would be +0x2cd on my 5.2.11 build, which according to GDB is here=
:
>=20
> (gdb)  list *(btrfs_init_reloc_root+0x2cd)
> 0x1dcbdd is in btrfs_init_reloc_root (fs/btrfs/relocation.c:1456).
> 1451		reloc_root =3D create_reloc_root(trans, root, root->root_key.obje=
ctid);
> 1452		if (clear_rsv)
> 1453			trans->block_rsv =3D rsv;
> 1454=09
> 1455		ret =3D __add_reloc_root(reloc_root);
> 1456		BUG_ON(ret < 0);
> 1457		root->reloc_root =3D reloc_root;
> 1458		return 0;
> 1459	}
> 1460
>=20
> But according to faddr2line, it is at relocation.c:1438.
>=20
> $ ./scripts/faddr2line fs/btrfs/btrfs.ko btrfs_init_reloc_root+0x2cd
> btrfs_init_reloc_root+0x2cd/0x340:
> btrfs_init_reloc_root at /path/to/linux/fs/btrfs/relocation.c:1438
>=20
> That is here:
>=20
> (gdb) list relocation.c:1438
> 1433		int clear_rsv =3D 0;
> 1434		int ret;
> 1435=09
> 1436		if (root->reloc_root) {
> 1437			reloc_root =3D root->reloc_root;
> 1438			reloc_root->last_trans =3D trans->transid;
> 1439			return 0;
> 1440		}
> 1441=09
> 1442		if (!rc || !rc->create_reloc_tree ||
>=20
>>> [49294.093066]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
>>> [49294.093119]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
>>> [49294.093170]  start_transaction+0x1c3/0xea0 [btrfs]
>>> [49294.093226]  btrfs_finish_ordered_io+0x811/0x1610 [btrfs]
>>> [49294.093233]  ? syscall_return_via_sysret+0xf/0x7f
>>> [49294.093238]  ? syscall_return_via_sysret+0xf/0x7f
>>> [49294.093243]  ? __switch_to_asm+0x40/0x70
>>> [49294.093248]  ? __switch_to_asm+0x34/0x70
>>> [49294.093300]  ? btrfs_unlink_subvol+0xa30/0xa30 [btrfs]
>>> [49294.093307]  ? finish_task_switch+0x1a1/0x760
>>> [49294.093312]  ? __switch_to+0x457/0xe90
>>> [49294.093317]  ? __switch_to_asm+0x34/0x70
>>> [49294.093378]  normal_work_helper+0x15a/0xb90 [btrfs]
>>> [49294.093387]  process_one_work+0x706/0x1200
>>> [49294.093394]  worker_thread+0x92/0xfb0
>>> [49294.093401]  ? __kthread_parkme+0x85/0x100
>>> [49294.093406]  ? process_one_work+0x1200/0x1200
>>> [49294.093410]  kthread+0x2ba/0x3b0
>>> [49294.093414]  ? kthread_park+0x130/0x130
>>> [49294.093420]  ret_from_fork+0x35/0x40
>>>
>>> [49294.093431] Allocated by task 11689:
>>> [49294.093441]  __kasan_kmalloc.part.0+0x3c/0xa0
>>> [49294.093493]  btrfs_read_tree_root+0x8f/0x350 [btrfs]
>>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This,
>=20
> GDB points here:
>=20
> (gdb) list *(btrfs_read_tree_root+0x92)
> 0xb07c2 is in btrfs_read_tree_root (./include/linux/slab.h:742).
> 737	 * @size: how many bytes of memory are required.
> 738	 * @flags: the type of memory to allocate (see kmalloc).
> 739	 */
> 740	static inline void *kzalloc(size_t size, gfp_t flags)
> 741	{
> 742		return kmalloc(size, flags | __GFP_ZERO);
> 743	}
> 744=09
> 745	/**
> 746	 * kzalloc_node - allocate zeroed memory from a particular memory n=
ode.
>=20
> Whereas faddr2line points at slab.h:547, here:
>=20
> (gdb) list slab.h:547
> 542			index =3D kmalloc_index(size);
> 543=09
> 544			if (!index)
> 545				return ZERO_SIZE_PTR;
> 546=09
> 547			return kmem_cache_alloc_trace(
> 548					kmalloc_caches[kmalloc_type(flags)][index],
> 549					flags, size);
> 550	#endif
> 551		}
>=20
> btrfs_alloc_root calls kzalloc, so it looks like this is the inlined
> result of that. It is called here:
>=20
> (gdb) list disk-io.c:1434
> 1429=09
> 1430		path =3D btrfs_alloc_path();
> 1431		if (!path)
> 1432			return ERR_PTR(-ENOMEM);
> 1433=09
> 1434		root =3D btrfs_alloc_root(fs_info, GFP_NOFS);
> 1435		if (!root) {
> 1436			ret =3D -ENOMEM;
> 1437			goto alloc_fail;
> 1438		}

It's btrfs_root causing the problem. Now we have a clue.
>=20
>>> [49294.093542]  btrfs_read_fs_root+0xc/0xc0 [btrfs]
>>> [49294.093601]  create_reloc_root+0x445/0x920 [btrfs]
>>> [49294.093660]  btrfs_init_reloc_root+0x1da/0x330 [btrfs]
>>> [49294.093709]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
>>> [49294.093758]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
>>> [49294.093806]  start_transaction+0x1c3/0xea0 [btrfs]
>>> [49294.093856]  __btrfs_prealloc_file_range+0x1c2/0xa50 [btrfs]
>>> [49294.093907]  btrfs_prealloc_file_range+0x10/0x20 [btrfs]
>>> [49294.093966]  prealloc_file_extent_cluster+0x24e/0x4a0 [btrfs]
>>> [49294.094025]  relocate_file_extent_cluster+0x193/0xc90 [btrfs]
>>> [49294.094083]  relocate_data_extent+0x1f2/0x460 [btrfs]
>>> [49294.094142]  relocate_block_group+0x5a5/0xf50 [btrfs]
>>> [49294.094200]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
>>> [49294.094258]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
>>> [49294.094315]  btrfs_balance+0x1292/0x2f00 [btrfs]
>>> [49294.094373]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
>>> [49294.094430]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
>>> [49294.094434]  do_vfs_ioctl+0x99f/0xf10
>>> [49294.094437]  ksys_ioctl+0x5e/0x90
>>> [49294.094440]  __x64_sys_ioctl+0x6f/0xb0
>>> [49294.094446]  do_syscall_64+0xa0/0x370
>>> [49294.094451]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [49294.094457] Freed by task 11689:
>>> [49294.094464]  __kasan_slab_free+0x144/0x1f0
>>> [49294.094468]  kfree+0x95/0x2a0
>>> [49294.094516]  btrfs_drop_snapshot+0x1529/0x1c40 [btrfs]
>>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> And this.
>=20
> (gdb) list *(btrfs_drop_snapshot+0x154c)
> 0x7643c is in btrfs_drop_snapshot (fs/btrfs/disk-io.h:110).
> 105	}
> 106=09
> 107	static inline void btrfs_put_fs_root(struct btrfs_root *root)
> 108	{
> 109		if (refcount_dec_and_test(&root->refs))
> 110			kfree(root);
> 111	}
> 112=09
> 113	void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
> 114	int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_tra=
nsid,
>=20
> faddr2line agrees with GDB on this one.
>=20
> There is one direct call to btrfs_put_fs_root in btrfs_drop_snapshot,
> here:
>=20
> (gdb) list extent-tree.c:9446
> 9441		if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state)) {
> 9442			btrfs_add_dropped_root(trans, root);
> 9443		} else {
> 9444			free_extent_buffer(root->node);
> 9445			free_extent_buffer(root->commit_root);
> 9446			btrfs_put_fs_root(root);
> 9447		}
> 9448		root_dropped =3D true;
> 9449	out_end_trans:
> 9450		btrfs_end_transaction_throttle(trans);

Thank you very much for the detailed report!

>=20
>>> [49294.094573]  clean_dirty_subvols+0x23f/0x380 [btrfs]
>>> [49294.094632]  relocate_block_group+0x95b/0xf50 [btrfs]
>>> [49294.094691]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
>>> [49294.094748]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
>>> [49294.094805]  btrfs_balance+0x1292/0x2f00 [btrfs]
>>> [49294.094863]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
>>> [49294.094920]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
>>> [49294.094923]  do_vfs_ioctl+0x99f/0xf10
>>> [49294.094926]  ksys_ioctl+0x5e/0x90
>>> [49294.094929]  __x64_sys_ioctl+0x6f/0xb0
>>> [49294.094934]  do_syscall_64+0xa0/0x370
>>> [49294.094939]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [49294.094946] The buggy address belongs to the object at ffff8885b49=
01100
>>>                 which belongs to the cache kmalloc-2k of size 2048
>>> [49294.094953] The buggy address is located 832 bytes inside of
>>>                 2048-byte region [ffff8885b4901100, ffff8885b4901900)=

>>> [49294.094957] The buggy address belongs to the page:
>>> [49294.094962] page:ffffea0016d24000 refcount:1 mapcount:0 mapping:ff=
ff88864400e800 index:0x0 compound_mapcount: 0
>>> [49294.094968] flags: 0x2ffff0000010200(slab|head)
>>> [49294.094976] raw: 02ffff0000010200 dead000000000100 dead00000000012=
2 ffff88864400e800
>>> [49294.094981] raw: 0000000000000000 00000000800f000f 00000001fffffff=
f 0000000000000000
>>> [49294.094983] page dumped because: kasan: bad access detected
>>>
>>> [49294.094987] Memory state around the buggy address:
>>> [49294.094992]  ffff8885b4901300: fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb
>>> [49294.094997]  ffff8885b4901380: fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb
>>> [49294.095002] >ffff8885b4901400: fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb
>>> [49294.095006]                                            ^
>>> [49294.095010]  ffff8885b4901480: fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb
>>> [49294.095015]  ffff8885b4901500: fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb
>>> [49294.095018] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [49301.893672] BTRFS info (device sdi1): 1 enospc errors during balan=
ce
>>> [49301.893675] BTRFS info (device sdi1): balance: ended with status: =
-28
>>>
>>>
>>> Without KASAN, I would eventually get an oops like this:
>>>
>>> [...]
>>>
>>> I only noticed this bug because I keep an eye on dmesg. In one instan=
ce,
>>> I ignored it for a few hours, then my graphics driver crashed because=
 of
>>> memory allocation failure and/or heap corruption. Aside from that, I
>>> have seen no obvious effects.
>>>
>>> I have hit this bug at least 5 times over the last two weeks. Every
>>> time, it has been caused by a balance on various volumes (typically t=
o
>>> balance a single block group). I was able to trigger it somewhat
>>> reliably by attempting a balance on a volume with a size of 596.18GiB=

>>> and 1.68GiB of estimated free space, but that stopped working
>>> eventually.
>>
>> Is it always that particular fs?
>> Have you ever hit it on another fs?
>> Furthermore, did you hit it in v5.1?
>=20
> I usually hit this on a raid0 data volume, but I got the same KASAN
> report once while attemtping to balance my raid1 system volume.
>=20
> I got the data volume into a state where it would consistently trigger
> the bug (2.05GiB of free space), and did a few git bisects.
>=20
> On v5.0, the balance correctly fails with ENOSPC.
>=20
> As of commit d2311e69857815ae2f728b48e6730f833a617092 ("btrfs:
> relocation: Delay reloc tree deletion after merge_reloc_roots"), first
> appearing in v5.1-rc1, I get "kernel BUG at fs/btrfs/relocation.c:1413!=
"
> at create_reloc_root+0x6a1/0x920 when attempting a balance.

That means you have an existing reloc tree already.

>=20
> As of commit 30d40577e322b670551ad7e2faa9570b6e23eb2b ("btrfs: reloc:
> Also queue orphan reloc tree for cleanup to avoid BUG_ON()"), first
> appearing in v5.2-rc3, I get the KASAN report instead of the BUG_ON.

So with that fix, we're queuing the already orphan reloc tree first, but
then we're by somehow still trying to use that tree and get the things
screwed up.

Would you like to provide the following dump on the fs where you can
always reproduce the bug?

# btrfs ins dump-tree -t root <device>

Thanks,
Qu

>=20
>> I guess there is a chance my previous change of reloc tree lifespan
>> screwed up something, but it's introduced in v5.1...
>>
>> Thanks,
>> Qu
>>


--2TwgR7pmxoBO1FV9a2Cwpd62zI8RdwKER--

--Km3igoI7X4PEcWURQWWGWQj1DeLPescLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2BduUACgkQwj2R86El
/qgVKgf/cU6NMgCS6vhlZP6/r66t0UI01x32jwNF/DO/qVbxyrS64FyUc3I004IJ
MqB61lhLKsQi81/UTqdXOCIL2iRe44IrMvAhiExv9oJCbb3LJ9liQv9lGk6eoou3
fhrSdJacON55Q+Mr0K/GIR+b8WVgV6dixmdzwWiYwD+J4MUT/2aTQc7/jigwADCR
EJ3/+RtiP9jywIEZ0801TUUeI2+6djUKvhGSOlIsVd4uNmpxqDsOL44VU2PErpBz
kuJh2cLRX6arMpOhOJjltfhEMWUJtyU+i0QrSf6+YxOvLcYskku45fqUlJeOFBM3
G0LmDZfM91zmzzD0o2XIqkp0IAXPvg==
=hHuC
-----END PGP SIGNATURE-----

--Km3igoI7X4PEcWURQWWGWQj1DeLPescLo--
