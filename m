Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CD2910B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2019 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfEXGhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 May 2019 02:37:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:52321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbfEXGhV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 May 2019 02:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558679832;
        bh=lZ7ZiP/NO3uPpDtW+3bPFRvsZ5Hy3NAA6HQDbYY1Z4M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RZ0WNX1wb/eX4BJ/RwUicL2L9d+Pk0KYtHXlx9Ky3otgmoG8iMEPySON4FBb0CPNT
         YLtcCqEcu02pftW39qzDjt/K/Y2XLnYnBGQ94FyA4vDK2qCqXuv2DB0dg232rk+nmM
         XIdw2NHDYoSyU5vnDIfNApxrOZpuV3aaRckHIcqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0ML6XF-1hTmi622jZ-000KlJ; Fri, 24
 May 2019 08:37:12 +0200
Subject: Re: kernel BUG at fs/btrfs/relocation.c:1413! on 5.1.4
To:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <SYCPR01MB5086504BE1D2062E2550207B9E020@SYCPR01MB5086.ausprd01.prod.outlook.com>
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
Message-ID: <fb9ce10d-e34f-fc29-c780-b2fea3ff4fa3@gmx.com>
Date:   Fri, 24 May 2019 14:37:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <SYCPR01MB5086504BE1D2062E2550207B9E020@SYCPR01MB5086.ausprd01.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vdoTkag2CJnsQHWdbtcCmPdBCUd80CwLk"
X-Provags-ID: V03:K1:Qj/Og1KQwrQWuDDW03pNDiMZJ9kl1pHNnbZibL3rihQUM8EiwAR
 MBleRTmYD4rjU3wjVL6FYrWohpQSNcrvnAJDCj+1VaZioXcPZ8zyllYKPh8IJc08L/2EiN0
 SXVT8ZKPB8137B+Bt9IDN8vUfVfZSu8KDMypzGFzk/f8IYaOClMKsiqK8YB2FtYzgwqrXGI
 wdXViuQQAHo8tobT2dkYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d8GPiRLv680=:emRnA4IM7KcUtH52lhVHC5
 9sBMm6lAQl3+/23YSmc9HEbZJt3+XDxgBlQabByxbzNLGSWs9SXGjScKmFdXuj6k71CBqf59w
 +I3Iz3DjsmOPGRVU5PafGIVuhie7wWZC2ZxM1NmAe4EjhEBuvgjWcUeXvjoNYJOAaJDex2DOC
 IGJ4grEKDVhkdLFNV0Gwh5RDRNizGg9sx7UNAY+k+Xw1VzsCplB4OA2z026Rz0fCGuxq6C+P5
 Wus3XAz6LbCkIDT1s6LszQ53dUrabZxg8peJq7q84nZHgNOmstUjqPnZJfU7DVjtGc2Ba4NiQ
 gr/bF2pibb3YV0lD9wr94d53ynfyqi+R0msroxD+yD6nn0o8sm7qEN4aAxicWxXl67f2qdAy+
 E8E87U5MDe5GSO6nSEg4xEAXYGLBnaezRWQ0sz8g8mpeXy0a3GB6vZ7dr08yBvokP2Z5PP+Fw
 mpTwqikQGxR+p9UPfTMMfkAeE8eNsQpK4S20XJ/NelTcjclpEZiWOGQJ6F5f2vc3+K10+VMBW
 dj+3gywdXNrseDmzqT+0QhpH+/ilkfzYrVgFmVAnzssaN70XnDB+s3ZjzWzMLh3CDtNF3VaEt
 zaR45hhFuwiW0kgnJrgkC5CfP6pC/t1UTTOhe7oTGA371/EiUYXL8zBfkVqj25lVTnUm8VsXS
 13kodXjv3m8UE9xbU6z13TuVimeTOlxc6zN6UTET7n7wnuvAf9ktEQfgJPfTd8XBOxrPgyxem
 XM23lHiLzEcdk/8O8OO4Y+6JsRXvviQaql51/27FeN6Bde0iBTHvHMFP2XaSD+TakJl8Nik78
 0u7JKUPZ5IhxtRwn8HNUG4mdyXpCCIiY65nKW6fWnVj3BCu05SESSAHA0ZFXNaCbdMSUyEbgz
 FwBUbNfnrhOuwv+TzFzcv0Ufwea2NGUUeFm8WpiqdAnNL1mc/DB5b//c5IPTiiGU2wk/Gli4P
 KrmkV8lBfJRoeA1yLaxFeZdlLOqKJ/wM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vdoTkag2CJnsQHWdbtcCmPdBCUd80CwLk
Content-Type: multipart/mixed; boundary="NdhL4KOwEL4iZ7jxlJwWB2ECTt9QY66Fk";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Paul Jones <paul@pauljones.id.au>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <fb9ce10d-e34f-fc29-c780-b2fea3ff4fa3@gmx.com>
Subject: Re: kernel BUG at fs/btrfs/relocation.c:1413! on 5.1.4
References: <SYCPR01MB5086504BE1D2062E2550207B9E020@SYCPR01MB5086.ausprd01.prod.outlook.com>
In-Reply-To: <SYCPR01MB5086504BE1D2062E2550207B9E020@SYCPR01MB5086.ausprd01.prod.outlook.com>

--NdhL4KOwEL4iZ7jxlJwWB2ECTt9QY66Fk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/24 =E4=B8=8B=E5=8D=881:52, Paul Jones wrote:
> Here is a stack trace I got when removing a device from a raid1 filesys=
tem.
> I have run a check on the filesystem and I got no errors,  just a messa=
ge about the free space tree needing to be rebuilt, which I did on mount.=


This is fixed by this patch:
https://patchwork.kernel.org/patch/10955321/

Thanks,
Qu

>=20
> [ 1569.185720] BTRFS info (device dm-5): relocating block group 7042797=
404160 flags metadata|raid1
> [ 1635.157948] BTRFS info (device dm-5): found 32629 extents
> [ 1643.277714] BTRFS info (device dm-5): relocating block group 7043971=
809280 flags system|raid1
> [ 1643.577339] BTRFS info (device dm-5): found 36 extents
> [ 1643.878316] BTRFS info (device dm-5): relocating block group 7044005=
363712 flags system|raid1
> [ 1644.403175] BTRFS info (device dm-5): found 35 extents
> [ 1645.268105] BTRFS info (device dm-5): relocating block group 7039576=
178688 flags data|raid1
> [ 1645.959683] ------------[ cut here ]------------
> [ 1645.959684] kernel BUG at fs/btrfs/relocation.c:1413!
> [ 1645.959695] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 1645.959720] CPU: 0 PID: 10402 Comm: btrfs Not tainted 5.1.4-gentoo #=
2
> [ 1645.959745] Hardware name: Gigabyte Technology Co., Ltd. To be fille=
d by O.E.M./B75M-D3H, BIOS F15 10/23/2013
> [ 1645.959778] RIP: 0010:create_reloc_root+0x1f0/0x200
> [ 1645.959801] Code: c7 85 dc 00 00 00 00 00 00 00 48 c7 85 e4 00 00 00=
 00 00 00 00 c6 85 ec 00 00 00 00 c6 85 ed 00 00 00 00 e9 00 ff ff ff 0f =
0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 73 07 d9 ff 0f 1f 00 49 89 f9 48 89 d7
> [ 1645.959844] RSP: 0018:ffffc90000043838 EFLAGS: 00010282
> [ 1645.959867] RAX: 00000000ffffffef RBX: ffff8885ff9a9800 RCX: 0000000=
000000001
> [ 1645.959893] RDX: 0000000000000010 RSI: ffff888541736460 RDI: ffff888=
602445e00
> [ 1645.959918] RBP: ffff8885ff899400 R08: ffff888570a50508 R09: ffffc90=
000043658
> [ 1645.959944] R10: 0000000000000049 R11: 0000000000000000 R12: ffff888=
5fb705e38
> [ 1645.959970] R13: fffffffffffffff7 R14: ffff8885ef3f8000 R15: ffff888=
5ef3f8000
> [ 1645.959996] FS:  00007f1d5b7868c0(0000) GS:ffff888606000000(0000) kn=
lGS:0000000000000000
> [ 1645.960024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1645.960047] CR2: 000055b26a74f7f0 CR3: 00000005a5f3e004 CR4: 0000000=
0000606b0
> [ 1645.960073] Call Trace:
> [ 1645.960094]  btrfs_init_reloc_root+0x56/0xa0
> [ 1645.960118]  record_root_in_trans+0xa7/0xd0
> [ 1645.960140]  btrfs_record_root_in_trans+0x4a/0x60
> [ 1645.960173]  start_transaction+0x96/0x410
> [ 1645.960206]  __btrfs_prealloc_file_range+0xba/0x450
> [ 1645.960239]  ? btrfs_alloc_data_chunk_ondemand+0x1f5/0x230
> [ 1645.960274]  btrfs_prealloc_file_range+0xb/0x10
> [ 1645.960306]  prealloc_file_extent_cluster+0x117/0x240
> [ 1645.960340]  relocate_file_extent_cluster+0x90/0x4b0
> [ 1645.960373]  relocate_data_extent+0x5d/0xd0
> [ 1645.960405]  relocate_block_group+0x277/0x600
> [ 1645.960437]  btrfs_relocate_block_group+0x154/0x220
> [ 1645.960470]  btrfs_relocate_chunk+0x2c/0xa0
> [ 1645.960502]  btrfs_shrink_device+0x1dc/0x540
> [ 1645.960533]  ? btrfs_find_device_by_devspec+0x140/0x1d0
> [ 1645.960566]  btrfs_rm_device+0x11c/0x50e
> [ 1645.960598]  btrfs_ioctl+0x2a08/0x2de0
> [ 1645.960631]  ? mem_cgroup_commit_charge+0x69/0x420
> [ 1645.960664]  ? mem_cgroup_try_charge+0x88/0x1d0
> [ 1645.960697]  ? _copy_to_user+0x28/0x30
> [ 1645.960729]  ? cp_new_stat+0x126/0x160
> [ 1645.960760]  ? do_vfs_ioctl+0x3e6/0x640
> [ 1645.960790]  do_vfs_ioctl+0x3e6/0x640
> [ 1645.960822]  ? __se_sys_newstat+0x48/0x70
> [ 1645.960853]  ksys_ioctl+0x35/0x70
> [ 1645.960883]  __x64_sys_ioctl+0x11/0x20
> [ 1645.960915]  do_syscall_64+0x43/0xf0
> [ 1645.960948]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1645.960981] RIP: 0033:0x7f1d5b9ca047
> [ 1645.961011] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3=
 e8 8d d0 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 ce 0c 00 f7 d8 64 89 01 48
> [ 1645.961084] RSP: 002b:00007ffc2285cc18 EFLAGS: 00000206 ORIG_RAX: 00=
00000000000010
> [ 1645.961120] RAX: ffffffffffffffda RBX: 00007ffc2285ede0 RCX: 00007f1=
d5b9ca047
> [ 1645.961156] RDX: 00007ffc2285cc50 RSI: 000000005000943a RDI: 0000000=
000000003
> [ 1645.961191] RBP: 00005634b8aa5110 R08: 0000000000000000 R09: 0000000=
000000000
> [ 1645.961227] R10: 00005634b89dac68 R11: 0000000000000206 R12: 0000000=
000000003
> [ 1645.961262] R13: 00007ffc2285cc50 R14: 0000000000000000 R15: 0000000=
000000000
> [ 1645.961298] Modules linked in: ipt_MASQUERADE xt_nat xt_recent xt_co=
mment ipt_REJECT nf_reject_ipv4 xt_addrtype iptable_nat xt_mark iptable_m=
angle xt_TCPMSS xt_CT iptable_raw xt_multiport xt_conntrack xt_NFLOG nf_n=
at_tftp nf_nat_snmp_basic nf_conntrack_snmp asn1_decoder nf_nat_sip nf_na=
t_pptp nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrac=
k_amanda nf_nat nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_c=
onntrack_pptp nf_conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_b=
roadcast nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp iptable_filt=
er ip_tables nfsd auth_rpcgss oid_registry nfs_acl binfmt_misc intel_powe=
rclamp pcspkr coretemp i2c_i801 k10temp it87 lpc_ich mfd_core hwmon_vid x=
ts cbc ixgb macvlan r8169 libphy igb dca i2c_algo_bit e1000 atl1c loop fu=
se nfs lockd grace sunrpc linear raid10 raid456 async_raid6_recov async_m=
emcpy async_pq async_xor async_tx raid1 raid0 md_mod dm_snapshot dm_mirro=
r dm_region_hash dm_log dm_cache_smq hid_sunplus hid_sony
> [ 1645.961320]  hid_samsung hid_pl hid_petalynx hid_gyration usbhid xhc=
i_pci xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd mpt3sas hp=
sa mptsas scsi_transport_sas mptspi scsi_transport_spi mptscsih mptbase s=
ata_inic162x ata_piix ahci libahci sata_nv sata_sil24 pata_jmicron pata_a=
md pata_mpiix nvme nvme_core
> [ 1645.962169] ---[ end trace 0497f2210bcbbb57 ]---
> [ 1645.962219] RIP: 0010:create_reloc_root+0x1f0/0x200
> [ 1645.962253] Code: c7 85 dc 00 00 00 00 00 00 00 48 c7 85 e4 00 00 00=
 00 00 00 00 c6 85 ec 00 00 00 00 c6 85 ed 00 00 00 00 e9 00 ff ff ff 0f =
0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 73 07 d9 ff 0f 1f 00 49 89 f9 48 89 d7
> [ 1645.962343] RSP: 0018:ffffc90000043838 EFLAGS: 00010282
> [ 1645.962385] RAX: 00000000ffffffef RBX: ffff8885ff9a9800 RCX: 0000000=
000000001
> [ 1645.962431] RDX: 0000000000000010 RSI: ffff888541736460 RDI: ffff888=
602445e00
> [ 1645.962490] RBP: ffff8885ff899400 R08: ffff888570a50508 R09: ffffc90=
000043658
> [ 1645.962491] R10: 0000000000000049 R11: 0000000000000000 R12: ffff888=
5fb705e38
> [ 1645.962492] R13: fffffffffffffff7 R14: ffff8885ef3f8000 R15: ffff888=
5ef3f8000
> [ 1645.962493] FS:  00007f1d5b7868c0(0000) GS:ffff888606000000(0000) kn=
lGS:0000000000000000
> [ 1645.962494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1645.962495] CR2: 000055b26a74f7f0 CR3: 00000005a5f3e004 CR4: 0000000=
0000606b0
>=20


--NdhL4KOwEL4iZ7jxlJwWB2ECTt9QY66Fk--

--vdoTkag2CJnsQHWdbtcCmPdBCUd80CwLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlznkRAACgkQwj2R86El
/qibEggAsjcyKPaQ5uC0enJ8qFBfBWvk1k1R0xCVHsnwR1/nn4Kqstnp/wf9aeRV
yNZDQTHv/kgMflOBfXrAT6rjgeFypNbydkEvlt4wIeZC9iLWtXu6J+ni3t4ULPt+
zxyTltV0HbviwclM6pfYV06Y6TFr/smriZenf93xRlzmTNtTr/rGA4DA2/XZRBtl
hNmuk6s8IoL3tC1S+804+nxQgSrMIPx5yJjTd0n3psMGpPuLhb7YgRJgi2drAyLi
A6hS48S4XwSPLPvVnY4IeZN960YdwkLe007g2vmtwNmveaeq1MKmSI+KI3fMUftp
FiJKEEqFNjKMDKhvLCItaqNhmbbdpg==
=0mcu
-----END PGP SIGNATURE-----

--vdoTkag2CJnsQHWdbtcCmPdBCUd80CwLk--
