Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BEDB44E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 02:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfIQAjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 20:39:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:54141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfIQAjH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 20:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568680734;
        bh=dsIQSNeMZa4KaTdCTqWYfYaV/9RUqJi2TuhIoO36dmI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fy39+0h/EFrTbUWnJTeV0zL7Ove1/oxcMPQQZufq1psqAEUwVYNI0x4rKIzrwG1MR
         e3258Bi9K3VDB4XVkV/EdaVs6SwyGpZaQqR+hR08hOJW0q8YPI1SLjheeTaQaOiuNb
         qgujR2p0/N9Woc6g4zn3Phe51ZeTO0SJyyioJW58=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M2ojS-1huHeM3ynG-00seVU; Tue, 17
 Sep 2019 02:38:54 +0200
Subject: Re: btrfs scrub resulting in readonly filesystem
To:     Lai Wei-Hwa <whlai@robco.com>, linux-btrfs@vger.kernel.org
References: <591580482.537773.1568655046847.JavaMail.zimbra@robco.com>
 <79984309.572916.1568665920098.JavaMail.zimbra@robco.com>
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
Message-ID: <289cd208-49cf-8194-d4df-5d0423b6b73d@gmx.com>
Date:   Tue, 17 Sep 2019 08:38:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <79984309.572916.1568665920098.JavaMail.zimbra@robco.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jL8qUYrz5fJe6N06QLXAcCrFcK3eHhcC8"
X-Provags-ID: V03:K1:onbEOW3lEuVZB4/jXesBKn+1MAbmAfrqMEfKxUhyPZwAA8mWHKO
 hjTrlAZukfDiqh9SqDt9HNAjXrUl6e26032yMf72hSJzLINtUUi///txHgEf/3b1Mc4Lt0w
 qfLjVCduaRmVH2hd5FW5M6y+RmbOlIa9hKbg8BnO0KNxO3Hivf155Gmhdh+n3DrR2+RJwjK
 BLcVfbHBSHZyh0IC2Gd4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:32E61CNwPB8=:1ylka6pHTm2/cbhTFuwmdr
 AztBWKKsodtUav4TtCzkNVzkvj1z+udjhOS/16DAKJGMu9Ke23hM922GXLzzvrcAdgqYulAdi
 5C6PCxN6orAw49sTqbqMGUizuMR5CPPQapmmdVRT+rPVqb4UtlcpXS7KI0j8iqM+xkVj1RYzM
 0CpHPUaOEXfQZNYzJZXBbBV7YQl6Qbmw6JKW88O/OVutQnNHolg2cdVjCPjQRilz0j37X1SFD
 PPLqqwwCnoL+5h1WAkbbzuaNC0q8g1ebAfU4qZ9t2kF2ZfPBTuziiVj49dGJhDMKpeiZa23yW
 zjdluwFeU9nbptQgA7E6gKr0+g4d4xnFspPyomM7JI5bjrcXexjyoicSjXQn0RERP4XQdmpiV
 daU/tcjpup3jSYFowA2w1gY47VPGtlUhYIGWiEFO1rgmsKHJAo+wYxRaMolPR2BEYPdrPH0xD
 q0qZFPNLXV4ujXRMkhmKVkNKn+YETGRiXgg2m+29jGzlnBuEpX7ufgvUBndlqKZwbcX+jKOby
 gEDpVEu2suXkLMpRgt+kf92O+NAN8af0HrBmcWfLC2BRdyo0oGw4zVxre9ksa1I2Xuk239hsz
 DuInXzre/+Vkjy4m2hCjzHQjM45albeKqq6nXe7+GbfoCyLSbBAdFhPB4PU94SdJw7GsnxV+l
 Zk9Neq8ssGVK3BLBHZpEUWuvwXtZ9/iIF3K+GiXhVttgeblmFYHG4YZE+0c7hMeUGlDEmkQkq
 rE0xP50lpXS11CWeq2AG5qIIAvGetMh87haVg94Xx2hjXeAPDDCYF0ai30iotTWdqxbjpBqJ4
 SwrFcn7QR4eVOtFRklGAY/ABXUztLi7jHm2rrk9xGJq2m9s/DjgZUS4hCm2rkoPN/GwoXmFQj
 fCXmPfe9doz/Gyi73c7OD6B1DgBimZzrcm9zph2lLQAb26EXd2ZaGo+heFS3gmk75h3Jp1Epz
 30AO4i04bESnpsMg3R1ywMtZKa/nbOA10diFPbEOntBrgALoY77IXEKeYehhBpkMERO6brDac
 nXp5bE+ctRduukiF9U8z7hPkvhLOnBEppvfNCiZ812+fPGl3mmwkdIIJdvdLiEzYTIpNCAhUN
 VACljFV7GMrkMgNONNlEWrN90l1z0ynUezu+ekK9ZjKJRHlTZwWE2zthJVKzp/MMjzJclS+iO
 pHqGN1pX+0W2jryAe4HAxUNjejFl/oY7MR3UGMr2/P47KO2LbuuMPX8GZWfzD6rVHJHn6mSjD
 2VAkGaRKcCVimCtTjaJ6QU6wmUIcNcgBrS/JUjbmiLr0JI+l4MoQ+jPLfraY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jL8qUYrz5fJe6N06QLXAcCrFcK3eHhcC8
Content-Type: multipart/mixed; boundary="7sjpu2KWE5reGLv4FNehjywa0DkOMxKJJ"

--7sjpu2KWE5reGLv4FNehjywa0DkOMxKJJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/17 =E4=B8=8A=E5=8D=884:32, Lai Wei-Hwa wrote:
> Hi There,=20
>=20
> Found a host with readonly filesystem. This is the output from dmesg wh=
ich occurred right after a cron job was executed to scrub.=20
>=20
>=20
>=20
> [Sep14 20:02] ------------[ cut here ]------------=20
> [ +0.000042] WARNING: CPU: 18 PID: 28882 at /build/linux-TSOhpZ/linux-4=
=2E4.0/fs/btrfs/extent-tree.c:10046 btrfs_create_pending_block_groups+0x1=
44/0x1f0 [btrfs]()=20
> [ +0.000002] BTRFS: Transaction aborted (error -27)=20
> [ +0.000002] Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 =
nf_log_common xt_LOG xt_limit xt_tcpudp xt_hl ip6t_rt nf_conntrack_ipv6 n=
f_defrag_ipv6 xt_conntrack nf_conntrack ip6table_filter ip6_tables x_tabl=
es ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs cpuid unix_diag veth bri=
dge stp llc bonding binfmt_misc zfs(PO) zunicode(PO) zcommon(PO) znvpair(=
PO) spl(O) zavl(PO) intel_powerclamp coretemp kvm_intel kvm irqbypass crc=
t10dif_pclmul crc32_pclmul ipmi_devintf ipmi_ssif ghash_clmulni_intel aes=
ni_intel aes_x86_64 lrw gf128mul dcdbas glue_helper input_leds ablk_helpe=
r ipmi_si gpio_ich serio_raw i7core_edac joydev 8250_fintek acpi_power_me=
ter mac_hid ipmi_msghandler shpchp edac_core cryptd lpc_ich ib_iser rdma_=
cm iw_cm ib_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp libisc=
si scsi_transport_iscsi=20
> [ +0.000047] autofs4 btrfs raid10 raid456 async_raid6_recov async_memcp=
y async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipat=
h linear ses enclosure scsi_transport_sas uas hid_generic usbhid usb_stor=
age wmi psmouse hid pata_acpi megaraid_sas bnx2 fjes=20
> [ +0.000019] CPU: 18 PID: 28882 Comm: btrfs Tainted: P IO 4.4.0-157-gen=
eric #185-Ubuntu=20

Although your old kernel is not causing the problem of this case, it's
still recommended to upgrade to a newer kernel for btrfs usage.

> [ +0.000002] Hardware name: Dell Inc. PowerEdge R610/0F0XJ6, BIOS 6.4.0=
 07/23/2013=20
> [ +0.000001] 0000000000000286 1faf5c66f8e16e90 ffff8802adbcfa18 fffffff=
f8140c9a1=20
> [ +0.000003] ffff8802adbcfa60 ffffffffc024d588 ffff8802adbcfa50 fffffff=
f810864d2=20
> [ +0.000002] ffff880697e29720 ffff880c11881da0 ffff880c0f6e6800 ffff880=
697e29640=20
> [ +0.000002] Call Trace:=20
> [ +0.000008] [<ffffffff8140c9a1>] dump_stack+0x63/0x82=20
> [ +0.000007] [<ffffffff810864d2>] warn_slowpath_common+0x82/0xc0=20
> [ +0.000002] [<ffffffff8108656c>] warn_slowpath_fmt+0x5c/0x80=20
> [ +0.000014] [<ffffffffc01f31c4>] ? btrfs_finish_chunk_alloc+0x204/0x5a=
0 [btrfs]=20
> [ +0.000011] [<ffffffffc01b1d24>] btrfs_create_pending_block_groups+0x1=
44/0x1f0 [btrfs]=20
> [ +0.000012] [<ffffffffc01c7ed3>] __btrfs_end_transaction+0x93/0x340 [b=
trfs]=20
> [ +0.000013] [<ffffffffc01c8190>] btrfs_end_transaction+0x10/0x20 [btrf=
s]=20
> [ +0.000010] [<ffffffffc01b5a4d>] btrfs_inc_block_group_ro+0xed/0x1b0 [=
btrfs]=20
> [ +0.000014] [<ffffffffc02253bf>] scrub_enumerate_chunks+0x21f/0x580 [b=
trfs]=20
> [ +0.000004] [<ffffffff810cb700>] ? wake_atomic_t_function+0x60/0x60=20
> [ +0.000013] [<ffffffffc0226d0c>] btrfs_scrub_dev+0x1bc/0x530 [btrfs]=20
> [ +0.000004] [<ffffffff8123f306>] ? __mnt_want_write+0x56/0x60=20
> [ +0.000013] [<ffffffffc0202408>] btrfs_ioctl+0x1ac8/0x28c0 [btrfs]=20
> [ +0.000003] [<ffffffff8119a3b9>] ? unlock_page+0x69/0x70=20
> [ +0.000002] [<ffffffff8119a654>] ? filemap_map_pages+0x224/0x230=20
> [ +0.000004] [<ffffffff811cdb77>] ? handle_mm_fault+0x10f7/0x1b80=20
> [ +0.000002] [<ffffffff811fb77b>] ? kmem_cache_alloc_node+0xbb/0x210=20
> [ +0.000003] [<ffffffff813e13e3>] ? create_task_io_context+0x23/0x100=20
> [ +0.000003] [<ffffffff812318ef>] do_vfs_ioctl+0x2af/0x4b0=20
> [ +0.000002] [<ffffffff813e1510>] ? get_task_io_context+0x50/0x90=20
> [ +0.000003] [<ffffffff813f0936>] ? set_task_ioprio+0x86/0xa0=20
> [ +0.000002] [<ffffffff81231b69>] SyS_ioctl+0x79/0x90=20
> [ +0.000004] [<ffffffff81864f1b>] entry_SYSCALL_64_fastpath+0x22/0xcb=20
> [ +0.000002] ---[ end trace 13fce4e84d9b6aed ]---=20
> [ +0.000003] BTRFS: error (device sda1) in btrfs_create_pending_block_g=
roups:10046: errno=3D-27 unknown

-27 is -EFBIG.

There are only several users of that errno, and according to your
backtrace, it's from btrfs_finish_chunk_alloc() which will try to add
your system chunk to super block syschunk array.

While the syschunk array in super block has a fixed size, if super block
can no longer contain the new chunk, it returns -EFBIG and we abort
transaction, causing the problem.

To verify my analyse, please provide the following dump:
# btrfs ins dump-super -fFa /dev/sda1
# btrfs ins dump-tree -t 3 /dev/sda1

The latter dump needs to be done on an RO fs, or unmounted fs.

I don't have a good workaround right now, but it looks like you have too
many system chunks.
Normally this means you have too many data/metadata chunks, but I'd like
to see the dumps to make the final call on what's causing the problem.

Thanks,
Qu

> [ +0.003942] BTRFS info (device sda1): forced readonly=20
> [ +0.000193] pending csums is 28672=20
> [ +0.002295] BTRFS warning (device sda1): failed setting block group ro=
, ret=3D-30=20
>=20
> [ +7.197271] BTRFS warning (device sda1): failed setting block group ro=
, ret=3D-30=20
>=20
>=20
>=20
> What's the cause here?=20
>=20
>=20
> Best Regards,=20
>=20
> Lai Wei-Hwa
>=20
> Thanks!=20
> Lai
>=20


--7sjpu2KWE5reGLv4FNehjywa0DkOMxKJJ--

--jL8qUYrz5fJe6N06QLXAcCrFcK3eHhcC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2AKxMACgkQwj2R86El
/qglnwgArXYT6QHkMDwB+teVmpJKSnQMG7a8+bu4i3N327RSCBMjlpi7RulIzBIh
6NzTHsSTd2pDWwKBTRLATwwUAGCkeyekZ/t2uyYTfGFIZDa9vXAooImeJ2K+c6el
0pCot2XzrOr6LC0ti1BGU+uAJNBV8uJ6d7TiKK2nV2UmPtB7T6qArIuD/cZg14t1
XmGTEwwn9no0r228j2JuMgeXOls3jvlh2VNMOa5GUk0s7+W1vOsty1EJmg+yUBls
sbP7l4WNprOe/Fu30Ah20UTmN15pINCA3WuNB0tejmAe6dhgaziMkzd3LpkRw2Cx
HEV2badZAXrAWoX9Um66j0g9+lYxeA==
=Rvoh
-----END PGP SIGNATURE-----

--jL8qUYrz5fJe6N06QLXAcCrFcK3eHhcC8--
