Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B222908C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2019 07:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbfEXFwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 May 2019 01:52:20 -0400
Received: from mail-eopbgr1370055.outbound.protection.outlook.com ([40.107.137.55]:54365
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388128AbfEXFwT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 May 2019 01:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector1-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quDmTQpdNNcSCKq0Oz857xBraY3BAJAJMRGACFDXM0U=;
 b=ekdhlyDgNpYpLyjNkTenYYdN2T91sneTWzmPlc8XNqTlc3VbdOSC7ri/74gwmbRuubD9EO2bPtX0ZNPHNtuT4qn5qlu4xOKI1lo+YP1RRlTYcC92XVeuSrM8zretLLkNXKMNPCYvY5Od7x1R8XcBpTcLIwtbaxrWdkBDBreQ0XI=
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com (20.178.187.213) by
 SYCPR01MB4160.ausprd01.prod.outlook.com (20.177.107.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Fri, 24 May 2019 05:52:12 +0000
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::6016:fd57:4a00:d6e0]) by SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::6016:fd57:4a00:d6e0%7]) with mapi id 15.20.1922.019; Fri, 24 May 2019
 05:52:12 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: kernel BUG at fs/btrfs/relocation.c:1413! on 5.1.4 
Thread-Topic: kernel BUG at fs/btrfs/relocation.c:1413! on 5.1.4 
Thread-Index: AdUR9MIzWiBcuPiBTs2DaQP36L6Idw==
Date:   Fri, 24 May 2019 05:52:12 +0000
Message-ID: <SYCPR01MB5086504BE1D2062E2550207B9E020@SYCPR01MB5086.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [203.221.78.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4be570bc-722b-4e9e-04cf-08d6e00bf7b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SYCPR01MB4160;
x-ms-traffictypediagnostic: SYCPR01MB4160:
x-microsoft-antispam-prvs: <SYCPR01MB4160AB940D8FA9E3C756C5899E020@SYCPR01MB4160.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39830400003)(376002)(199004)(189003)(73956011)(76116006)(64756008)(66946007)(6116002)(66476007)(9686003)(3846002)(74482002)(66446008)(66556008)(81156014)(81166006)(86362001)(7736002)(52536014)(6916009)(2906002)(476003)(14454004)(8676002)(4743002)(2351001)(71200400001)(71190400001)(5660300002)(486006)(55016002)(8936002)(5640700003)(6436002)(25786009)(68736007)(186003)(45080400002)(316002)(305945005)(508600001)(26005)(53936002)(99286004)(66066001)(74316002)(256004)(14444005)(2501003)(6506007)(7696005)(33656002)(102836004)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:SYCPR01MB4160;H:SYCPR01MB5086.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4M90HptdCeCBg9qRN131DfZJ8OXTx/E0X4weCPHGHP6ySozaIgTGPPbfYFy7hP1QDhruoc58bf4fY2oukzoyqEuRPSAn7uGw4FtLPqXhR/m7pAxrBvvgETEDJ7k+2Ii7ktABxWa2ihjqLj/Da28dAzl0HzNvb8PYcTgvHJNeKCPvfC9bhziY/X0r3QcdBunoAk1jfl7T9yczP8nnsQbR4rQQ5renwUzNm/wZ5q5O07hkp5Ymf50tCj/zaiIqni1YqAMZ9MhIJrWSvSffP1BgUgNiqMEYN/4QzTMm4QkZcMTSkw8WoDK1VfgoKeiVhM0BV3oNvV71BIjCaRT8VE5291jzwkTFTFj2Gz30r272fI3OOcqDLH0RQbOw3DeUwanJUObv9KnIrzSP0hz98vCvqnYeos5MsnD/8ZLwoloTvak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be570bc-722b-4e9e-04cf-08d6e00bf7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 05:52:12.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paul@pauljones.id.au
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCPR01MB4160
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is a stack trace I got when removing a device from a raid1 filesystem.
I have run a check on the filesystem and I got no errors,  just a message a=
bout the free space tree needing to be rebuilt, which I did on mount.

[ 1569.185720] BTRFS info (device dm-5): relocating block group 70427974041=
60 flags metadata|raid1
[ 1635.157948] BTRFS info (device dm-5): found 32629 extents
[ 1643.277714] BTRFS info (device dm-5): relocating block group 70439718092=
80 flags system|raid1
[ 1643.577339] BTRFS info (device dm-5): found 36 extents
[ 1643.878316] BTRFS info (device dm-5): relocating block group 70440053637=
12 flags system|raid1
[ 1644.403175] BTRFS info (device dm-5): found 35 extents
[ 1645.268105] BTRFS info (device dm-5): relocating block group 70395761786=
88 flags data|raid1
[ 1645.959683] ------------[ cut here ]------------
[ 1645.959684] kernel BUG at fs/btrfs/relocation.c:1413!
[ 1645.959695] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 1645.959720] CPU: 0 PID: 10402 Comm: btrfs Not tainted 5.1.4-gentoo #2
[ 1645.959745] Hardware name: Gigabyte Technology Co., Ltd. To be filled by=
 O.E.M./B75M-D3H, BIOS F15 10/23/2013
[ 1645.959778] RIP: 0010:create_reloc_root+0x1f0/0x200
[ 1645.959801] Code: c7 85 dc 00 00 00 00 00 00 00 48 c7 85 e4 00 00 00 00 =
00 00 00 c6 85 ec 00 00 00 00 c6 85 ed 00 00 00 00 e9 00 ff ff ff 0f 0b <0f=
> 0b 0f 0b 0f 0b 0f 0b e8 73 07 d9 ff 0f 1f 00 49 89 f9 48 89 d7
[ 1645.959844] RSP: 0018:ffffc90000043838 EFLAGS: 00010282
[ 1645.959867] RAX: 00000000ffffffef RBX: ffff8885ff9a9800 RCX: 00000000000=
00001
[ 1645.959893] RDX: 0000000000000010 RSI: ffff888541736460 RDI: ffff8886024=
45e00
[ 1645.959918] RBP: ffff8885ff899400 R08: ffff888570a50508 R09: ffffc900000=
43658
[ 1645.959944] R10: 0000000000000049 R11: 0000000000000000 R12: ffff8885fb7=
05e38
[ 1645.959970] R13: fffffffffffffff7 R14: ffff8885ef3f8000 R15: ffff8885ef3=
f8000
[ 1645.959996] FS:  00007f1d5b7868c0(0000) GS:ffff888606000000(0000) knlGS:=
0000000000000000
[ 1645.960024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1645.960047] CR2: 000055b26a74f7f0 CR3: 00000005a5f3e004 CR4: 00000000000=
606b0
[ 1645.960073] Call Trace:
[ 1645.960094]  btrfs_init_reloc_root+0x56/0xa0
[ 1645.960118]  record_root_in_trans+0xa7/0xd0
[ 1645.960140]  btrfs_record_root_in_trans+0x4a/0x60
[ 1645.960173]  start_transaction+0x96/0x410
[ 1645.960206]  __btrfs_prealloc_file_range+0xba/0x450
[ 1645.960239]  ? btrfs_alloc_data_chunk_ondemand+0x1f5/0x230
[ 1645.960274]  btrfs_prealloc_file_range+0xb/0x10
[ 1645.960306]  prealloc_file_extent_cluster+0x117/0x240
[ 1645.960340]  relocate_file_extent_cluster+0x90/0x4b0
[ 1645.960373]  relocate_data_extent+0x5d/0xd0
[ 1645.960405]  relocate_block_group+0x277/0x600
[ 1645.960437]  btrfs_relocate_block_group+0x154/0x220
[ 1645.960470]  btrfs_relocate_chunk+0x2c/0xa0
[ 1645.960502]  btrfs_shrink_device+0x1dc/0x540
[ 1645.960533]  ? btrfs_find_device_by_devspec+0x140/0x1d0
[ 1645.960566]  btrfs_rm_device+0x11c/0x50e
[ 1645.960598]  btrfs_ioctl+0x2a08/0x2de0
[ 1645.960631]  ? mem_cgroup_commit_charge+0x69/0x420
[ 1645.960664]  ? mem_cgroup_try_charge+0x88/0x1d0
[ 1645.960697]  ? _copy_to_user+0x28/0x30
[ 1645.960729]  ? cp_new_stat+0x126/0x160
[ 1645.960760]  ? do_vfs_ioctl+0x3e6/0x640
[ 1645.960790]  do_vfs_ioctl+0x3e6/0x640
[ 1645.960822]  ? __se_sys_newstat+0x48/0x70
[ 1645.960853]  ksys_ioctl+0x35/0x70
[ 1645.960883]  __x64_sys_ioctl+0x11/0x20
[ 1645.960915]  do_syscall_64+0x43/0xf0
[ 1645.960948]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1645.960981] RIP: 0033:0x7f1d5b9ca047
[ 1645.961011] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 =
8d d0 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 ce 0c 00 f7 d8 64 89 01 48
[ 1645.961084] RSP: 002b:00007ffc2285cc18 EFLAGS: 00000206 ORIG_RAX: 000000=
0000000010
[ 1645.961120] RAX: ffffffffffffffda RBX: 00007ffc2285ede0 RCX: 00007f1d5b9=
ca047
[ 1645.961156] RDX: 00007ffc2285cc50 RSI: 000000005000943a RDI: 00000000000=
00003
[ 1645.961191] RBP: 00005634b8aa5110 R08: 0000000000000000 R09: 00000000000=
00000
[ 1645.961227] R10: 00005634b89dac68 R11: 0000000000000206 R12: 00000000000=
00003
[ 1645.961262] R13: 00007ffc2285cc50 R14: 0000000000000000 R15: 00000000000=
00000
[ 1645.961298] Modules linked in: ipt_MASQUERADE xt_nat xt_recent xt_commen=
t ipt_REJECT nf_reject_ipv4 xt_addrtype iptable_nat xt_mark iptable_mangle =
xt_TCPMSS xt_CT iptable_raw xt_multiport xt_conntrack xt_NFLOG nf_nat_tftp =
nf_nat_snmp_basic nf_conntrack_snmp asn1_decoder nf_nat_sip nf_nat_pptp nf_=
nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_=
nat nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp =
nf_conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conn=
track_irc nf_conntrack_h323 nf_conntrack_ftp iptable_filter ip_tables nfsd =
auth_rpcgss oid_registry nfs_acl binfmt_misc intel_powerclamp pcspkr corete=
mp i2c_i801 k10temp it87 lpc_ich mfd_core hwmon_vid xts cbc ixgb macvlan r8=
169 libphy igb dca i2c_algo_bit e1000 atl1c loop fuse nfs lockd grace sunrp=
c linear raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor a=
sync_tx raid1 raid0 md_mod dm_snapshot dm_mirror dm_region_hash dm_log dm_c=
ache_smq hid_sunplus hid_sony
[ 1645.961320]  hid_samsung hid_pl hid_petalynx hid_gyration usbhid xhci_pc=
i xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd mpt3sas hpsa mpt=
sas scsi_transport_sas mptspi scsi_transport_spi mptscsih mptbase sata_inic=
162x ata_piix ahci libahci sata_nv sata_sil24 pata_jmicron pata_amd pata_mp=
iix nvme nvme_core
[ 1645.962169] ---[ end trace 0497f2210bcbbb57 ]---
[ 1645.962219] RIP: 0010:create_reloc_root+0x1f0/0x200
[ 1645.962253] Code: c7 85 dc 00 00 00 00 00 00 00 48 c7 85 e4 00 00 00 00 =
00 00 00 c6 85 ec 00 00 00 00 c6 85 ed 00 00 00 00 e9 00 ff ff ff 0f 0b <0f=
> 0b 0f 0b 0f 0b 0f 0b e8 73 07 d9 ff 0f 1f 00 49 89 f9 48 89 d7
[ 1645.962343] RSP: 0018:ffffc90000043838 EFLAGS: 00010282
[ 1645.962385] RAX: 00000000ffffffef RBX: ffff8885ff9a9800 RCX: 00000000000=
00001
[ 1645.962431] RDX: 0000000000000010 RSI: ffff888541736460 RDI: ffff8886024=
45e00
[ 1645.962490] RBP: ffff8885ff899400 R08: ffff888570a50508 R09: ffffc900000=
43658
[ 1645.962491] R10: 0000000000000049 R11: 0000000000000000 R12: ffff8885fb7=
05e38
[ 1645.962492] R13: fffffffffffffff7 R14: ffff8885ef3f8000 R15: ffff8885ef3=
f8000
[ 1645.962493] FS:  00007f1d5b7868c0(0000) GS:ffff888606000000(0000) knlGS:=
0000000000000000
[ 1645.962494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1645.962495] CR2: 000055b26a74f7f0 CR3: 00000005a5f3e004 CR4: 00000000000=
606b0
