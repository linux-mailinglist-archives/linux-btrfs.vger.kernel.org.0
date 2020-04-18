Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFEF1AE938
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Apr 2020 03:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgDRBfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 21:35:46 -0400
Received: from mail-eopbgr1370051.outbound.protection.outlook.com ([40.107.137.51]:36640
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgDRBfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 21:35:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn3Y3GxoB3y6RLGdC8DD423+ZL5Q+VbcZo+/67bh1neeyZDeBTOYoBjVXP1u4+er1kPU9i7unbuuFrsUSdmwog8O3eUyo/OBGBBe3DCPwGxXHq+grEr/uasSwf6GrHC+6q+wagWrTyE9341W/WYYNA7cGdaAw3DH/SrMYl+bHZFjcSsbvnj+uOa4t1QEDOMAAYd8gc0w0gV6ZmuwSiGrMVA4Y7CKwGiYK1E8r8tOuczw4gwSs3bAp3/t34xCRDIUNmMlYtHUbw2KEt9rIE/l0R7GURlFE1oT2HHo4AUS18h1Kebj4iPNoAZ6ZKrxxEcZdLY00wmak4hB4tVIZPE3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9/xvMz9YOHwCUnCU6vsnGfBqXtjUd7POwKm9wRWCP0=;
 b=Ibq0Uitgjt1Qe+1qBGe0jrnVzq9RoYqJjMntKogbB4ylldjyDz3wPZdgwgIHPEYdsGS9eej0DgiluiGFo1gIq6og/fGcjR0r/pw7T8UmflArQxnL32Sf6BisE3g9SoJ8/V/B2SCtidwDSpxbGHggqJ9BlZP5s6+JU2xlLvxElWnvCVj4dMxsXGSdm2B/fUtRLjMT6s2XfYSxdCFOfalt+UoR8J3T3VRjTkKDqH7acKGr2RYWfjGJ2NVfsOwu7l6JmS5xbRaAXtGuqUgqtO4HcoEmL6QDtujBdxr1Uyl1cZ4uaMsc1uaTEMYX+7TuvxafkI1B9QJ7UVcNWoUL/hVE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9/xvMz9YOHwCUnCU6vsnGfBqXtjUd7POwKm9wRWCP0=;
 b=lS6eXtYRnhTJjb/6siTnSp7Hpnx+E36leGhgUATWFMeali1q3cDaNJ6VecIKv3ZMcdCDmjTGmga5mwf7mWvcTPLSq+MG5myZbK3Yol8dxEHfIw/TGfQeg+lZDDmtQ4UeJRhEEUcAA/1JJxklG0018F1R6hH+f+jbpIMaoS6zOhs=
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com (20.177.136.214) by
 SYBPR01MB5003.ausprd01.prod.outlook.com (20.178.190.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.26; Sat, 18 Apr 2020 01:35:36 +0000
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664]) by SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664%4]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 01:35:36 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Stack dump while adding and removing disk
Thread-Topic: Stack dump while adding and removing disk
Thread-Index: AdYVIOylR6Er0sNvRzCme0PBqEjAlw==
Date:   Sat, 18 Apr 2020 01:35:35 +0000
Message-ID: <SYBPR01MB389765DC2CEFEEA1F271F6C39ED60@SYBPR01MB3897.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [220.240.82.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5aee2af0-5442-417c-4f6c-08d7e338cb59
x-ms-traffictypediagnostic: SYBPR01MB5003:
x-microsoft-antispam-prvs: <SYBPR01MB5003C5036041F2BEAF7B09439ED60@SYBPR01MB5003.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB3897.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(39830400003)(396003)(346002)(136003)(376002)(71200400001)(2906002)(186003)(55016002)(8676002)(81156014)(26005)(86362001)(8936002)(45080400002)(508600001)(6506007)(66446008)(9686003)(52536014)(7696005)(316002)(33656002)(64756008)(6916009)(30864003)(66946007)(66476007)(66556008)(76116006)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bu3QVseUqf9dfQXwevbYSEeKn2BaG3RVswjPeXJvSiwWfm6f8We1WEmMQD+j7bT5aI8AotTYSHOcigOcwar+MSkXkeEF1mbOBmGsCZw88TYDUfjI/NkPHHHfWKhdUB851jYT6FtNiiZNDxCrr7RLRlcH6/6OyDrqlZF1nnYH/adGWxJAFUZFT+KF+noyK4sxi/wHGr2i/UCvL8qBKqEXbzj6jImTRudjM7fMxa/v35VRG/3iBL0GB9+I/4NkooSNJLIImiNZDn+PcerV6O1+dok/U/AOtEQ98kW3yzMALsxhi4zqWUziRR5KPwn3fihXgKSL+No9m+dslK2dk+H8zAbG54xo4R9y5LF6JJEPEYH1+BMCpmJ3LotDqsUWdoIduHASEc9vkJOKqqcoR1aJxo+1Fdz7PBp2HpQaZHngD96HL5FZ6NRV8Gc6eLKxeGS+
x-ms-exchange-antispam-messagedata: YtOZE/CZEeIy4ovoHdOvT/bNHk7latHdP969cYF0YBCrhtUqr2FqdQ7TWBNO+sTAj/9HSvzlVoSFXSvcTACRIlxZeTiMx3/gF703HoDCCUt6wfW9xAAOONZasOrdNYNIxQmfNwQSImP3Bc+1RJtQgg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aee2af0-5442-417c-4f6c-08d7e338cb59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 01:35:36.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xpawaboJftuHYuFnHBTXPAKmv3Bf3pJAH7AzMF0VaXcHoc3NPhH2CyHG+4jG/Z2xErGx0UfnYuyGZ1H0nBlzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB5003
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This happened while adding and then removing a disk on 5.6.3

Label: 'Root'  uuid: 58d27dbd-7c1e-4ef7-8d43-e93df1537b08
        Total devices 2 FS bytes used 46.00GiB
        devid   14 size 100.00GiB used 53.03GiB path /dev/sda1
        devid   15 size 100.00GiB used 53.03GiB path /dev/sdf1

Label: 'Boot'  uuid: 8f63cd03-67b2-47cd-85ce-ca355769c123
        Total devices 1 FS bytes used 71.47MiB
        devid    2 size 1.00GiB used 608.00MiB path /dev/sda6

Label: 'Storage'  uuid: 1438fdc5-8b2a-47b3-8a5b-eb74cde3df42
        Total devices 6 FS bytes used 4.40TiB
        devid    1 size 2.73TiB used 2.18TiB path /dev/sdg1
        devid    2 size 3.64TiB used 3.09TiB path /dev/mapper/a-storage
        devid    7 size 3.64TiB used 3.09TiB path /dev/sdh1
        devid    8 size 2.73TiB used 2.18TiB path /dev/sdi1
        devid    9 size 19.00GiB used 7.03GiB path /dev/sdf3
        devid   10 size 19.00GiB used 7.03GiB path /dev/sda5

Label: 'Backup'  uuid: c82771ef-837a-4584-ae4d-4d642d617396
        Total devices 7 FS bytes used 1.62TiB
        devid    0 size 710.00GiB used 686.00GiB path /dev/sdj1
        devid    2 size 640.00GiB used 618.00GiB path /dev/sdc1
        devid    3 size 690.00GiB used 668.00GiB path /dev/sde1
        devid    5 size 3.00TiB used 1.29TiB path /dev/mapper/a-backup
        devid    6 size 710.00GiB used 686.00GiB path /dev/sdk1
        devid    7 size 25.00GiB used 12.03GiB path /dev/sdf2
        devid    8 size 29.00GiB used 12.03GiB path /dev/sda7

All raid1 except boot.


[67120.563171]  sdj: sdj1
[67120.996400]  sdj: sdj1
[68661.727453]  sdj: sdj1
[68693.715160] sysfs: cannot create duplicate filename '/fs/btrfs/c82771ef-=
837a-4584-ae4d-4d642d617396/devinfo/9'
[68693.715164] CPU: 1 PID: 4347 Comm: btrfs Not tainted 5.6.3-gentoo-x86_64=
 #2
[68693.715164] Hardware name: Dell Inc. Precision T3610/, BIOS A03 09/05/20=
13
[68693.715165] Call Trace:
[68693.715175]  dump_stack+0x50/0x70
[68693.715179]  sysfs_warn_dup.cold+0x17/0x32
[68693.715181]  sysfs_create_dir_ns+0xb1/0xd0
[68693.715183]  kobject_add_internal+0xa6/0x230
[68693.715185]  kobject_init_and_add+0x71/0xa0
[68693.715189]  btrfs_sysfs_add_device_link+0xad/0xf0
[68693.715192]  btrfs_init_new_device+0x3ad/0x1130
[68693.715195]  ? unlazy_walk+0x46/0x80
[68693.715197]  ? terminate_walk+0x5f/0xf0
[68693.715200]  ? alloc_set_pte+0xf1/0x580
[68693.715203]  ? __kmalloc_track_caller+0xc1/0x120
[68693.715207]  ? _copy_from_user+0x37/0x60
[68693.715208]  btrfs_ioctl+0x663/0x2dc0
[68693.715210]  ? __handle_mm_fault+0xfcf/0x1180
[68693.715212]  ? ksys_ioctl+0x69/0xa0
[68693.715213]  ksys_ioctl+0x69/0xa0
[68693.715215]  __x64_sys_ioctl+0x11/0x20
[68693.715217]  do_syscall_64+0x43/0x120
[68693.715219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[68693.715221] RIP: 0033:0x7fb0bb7a3c57
[68693.715224] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 =
7d d0 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 d2 0c 00 f7 d8 64 89 01 48
[68693.715224] RSP: 002b:00007ffd148c3aa8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[68693.715226] RAX: ffffffffffffffda RBX: 00007ffd148c4c70 RCX: 00007fb0bb7=
a3c57
[68693.715227] RDX: 00007ffd148c3ae0 RSI: 000000005000940a RDI: 00000000000=
00003
[68693.715228] RBP: 000055e7c0367a30 R08: 00007ffd148c3ae8 R09: 00000000000=
00070
[68693.715228] R10: 0000000000000011 R11: 0000000000000246 R12: 00000000000=
00000
[68693.715229] R13: 00007ffd148c3ae0 R14: 0000000000000000 R15: 00000000000=
00003
[68693.715231] kobject_add_internal failed for 9 with -EEXIST, don't try to=
 register things with the same name in the same directory.
[68693.897847] BTRFS info (device sdc1): disk added /dev/sdj1
[69046.339394] BTRFS info (device sdg1): device fsid 1438fdc5-8b2a-47b3-8a5=
b-eb74cde3df42 devid 2 moved old:/dev/mapper/a-storage new:/dev/dm-1
[69046.348445] BTRFS info (device sdg1): device fsid 1438fdc5-8b2a-47b3-8a5=
b-eb74cde3df42 devid 2 moved old:/dev/dm-1 new:/dev/mapper/a-storage
[69241.772223] BTRFS info (device sdg1): device fsid 1438fdc5-8b2a-47b3-8a5=
b-eb74cde3df42 devid 2 moved old:/dev/mapper/a-storage new:/dev/dm-1
[69241.781163] BTRFS info (device sdg1): device fsid 1438fdc5-8b2a-47b3-8a5=
b-eb74cde3df42 devid 2 moved old:/dev/dm-1 new:/dev/mapper/a-storage
[69303.755177] BTRFS info (device sdc1): resizing devid 5
[69303.755182] BTRFS info (device sdc1): new size for /dev/mapper/a-backup =
is 3298534883328
[69316.164490] BTRFS info (device sdg1): resizing devid 2
[69316.164496] BTRFS info (device sdg1): new size for /dev/mapper/a-storage=
 is 3999331778560
[69349.811984] ------------[ cut here ]------------
[69349.811991] kobject: '(null)' (00000000aaf0f9ae): is not initialized, ye=
t kobject_put() is being called.
[69349.812021] WARNING: CPU: 3 PID: 6405 at lib/kobject.c:736 kobject_put+0=
x40/0xb0
[69349.812022] Modules linked in: sha512_generic cifs l2tp_netlink l2tp_cor=
e ip6_udp_tunnel udp_tunnel xt_recent xt_comment ipt_REJECT nf_reject_ipv4 =
xt_mark iptable_mangle xt_TCPMSS xt_CT iptable_raw xt_multiport xt_NFLOG nf=
_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp asn1_decoder nf_nat_sip nf_na=
t_pptp nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_=
amanda nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pp=
tp nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_connt=
rack_h323 nf_conntrack_ftp nfsd auth_rpcgss oid_registry nfs_acl xt_nat vet=
h xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo xt_ad=
drtype iptable_filter iptable_nat nf_nat ip_tables binfmt_misc hwmon_vid no=
uveau intel_powerclamp coretemp kvm_intel kvm i2c_algo_bit ttm drm_kms_help=
er syscopyarea sysfillrect sysimgblt irqbypass fb_sys_fops pcspkr drm drm_p=
anel_orientation_quirks i2c_i801 nvidiafb cfbfillrect cfbimgblt lpc_ich vga=
state mfd_core e1000 e1000e
[69349.812075]  r8169 cfbcopyarea realtek wmi libphy xts cbc overlay loop f=
use nfs lockd grace sunrpc linear raid10 raid1 raid0 dm_thin_pool dm_snapsh=
ot dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor async_=
tx md_mod dm_mirror dm_region_hash dm_log dm_cache_smq dm_cache dm_persiste=
nt_data dm_bufio dm_bio_prison hid_sunplus hid_samsung hid_pl hid_petalynx =
hid_gyration usbhid ohci_hcd uhci_hcd usb_storage xhci_plat_hcd xhci_pci xh=
ci_hcd ehci_pci ehci_hcd pata_jmicron pata_amd pata_mpiix hpsa mptsas mpt3s=
as scsi_transport_sas mptspi scsi_transport_spi mptscsih mptbase sata_inic1=
62x sata_nv sata_sil24 ata_piix ahci libahci nvme nvme_core
[69349.812122] CPU: 3 PID: 6405 Comm: btrfs Not tainted 5.6.3-gentoo-x86_64=
 #2
[69349.812124] Hardware name: Dell Inc. Precision T3610/, BIOS A03 09/05/20=
13
[69349.812130] RIP: 0010:kobject_put+0x40/0xb0
[69349.812134] Code: ff 48 8d 7d 38 f0 0f c1 45 38 83 f8 01 74 1f 85 c0 7e =
66 5b 5d 41 5c c3 48 8b 37 48 89 fa 48 c7 c7 58 69 da 81 e8 4e c0 92 ff <0f=
> 0b eb ce 0f b6 45 3c 48 8b 5d 28 4c 8b 65 00 89 c2 83 e2 0c 80
[69349.812136] RSP: 0018:ffffc9000149fd18 EFLAGS: 00010286
[69349.812138] RAX: 0000000000000000 RBX: ffff88854ef1cc00 RCX: 00000000000=
00007
[69349.812140] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff88884fd=
980b0
[69349.812142] RBP: ffff88854ef1cda0 R08: 00000000000022f4 R09: 00000000000=
00001
[69349.812143] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8888485=
b5e00
[69349.812145] R13: ffff8888485b5e00 R14: ffff88854ef1cc00 R15: ffff8888485=
b5e78
[69349.812148] FS:  00007fe0e36678c0(0000) GS:ffff88884fd80000(0000) knlGS:=
0000000000000000
[69349.812150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[69349.812152] CR2: 00007fcd3a19e6b8 CR3: 00000001265a6001 CR4: 00000000000=
606a0
[69349.812153] Call Trace:
[69349.812164]  btrfs_sysfs_rm_device_link+0x4e/0xe0
[69349.812170]  btrfs_rm_device.cold+0x6d/0x12b
[69349.812174]  btrfs_ioctl+0x2a08/0x2dc0
[69349.812180]  ? kmem_cache_alloc+0xa0/0x100
[69349.812186]  ? _copy_to_user+0x28/0x30
[69349.812189]  ? cp_new_stat+0x14b/0x180
[69349.812192]  ? __do_sys_newstat+0x48/0x70
[69349.812196]  ? ksys_ioctl+0x69/0xa0
[69349.812198]  ksys_ioctl+0x69/0xa0
[69349.812201]  __x64_sys_ioctl+0x11/0x20
[69349.812205]  do_syscall_64+0x43/0x120
[69349.812210]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[69349.812213] RIP: 0033:0x7fe0e3764c57
[69349.812217] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 =
7d d0 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 d2 0c 00 f7 d8 64 89 01 48
[69349.812218] RSP: 002b:00007ffd661c0e58 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000010
[69349.812221] RAX: ffffffffffffffda RBX: 00007ffd661c3010 RCX: 00007fe0e37=
64c57
[69349.812223] RDX: 00007ffd661c1e80 RSI: 000000005000943a RDI: 00000000000=
00003
[69349.812225] RBP: 0000000000000000 R08: 00007ffd661c1eb8 R09: 00000000000=
00231
[69349.812226] R10: 000055da8079e81b R11: 0000000000000202 R12: 00000000000=
00000
[69349.812228] R13: 000055da80841680 R14: 00007ffd661c1e80 R15: 00000000000=
00003
[69349.812231] ---[ end trace 8fa4b24e88c5878b ]---
[69349.812232] ------------[ cut here ]------------
[69349.812234] refcount_t: underflow; use-after-free.
[69349.812247] WARNING: CPU: 3 PID: 6405 at lib/refcount.c:28 refcount_warn=
_saturate+0xa6/0xf0
[69349.812247] Modules linked in: sha512_generic cifs l2tp_netlink l2tp_cor=
e ip6_udp_tunnel udp_tunnel xt_recent xt_comment ipt_REJECT nf_reject_ipv4 =
xt_mark iptable_mangle xt_TCPMSS xt_CT iptable_raw xt_multiport xt_NFLOG nf=
_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp asn1_decoder nf_nat_sip nf_na=
t_pptp nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_=
amanda nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pp=
tp nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_connt=
rack_h323 nf_conntrack_ftp nfsd auth_rpcgss oid_registry nfs_acl xt_nat vet=
h xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo xt_ad=
drtype iptable_filter iptable_nat nf_nat ip_tables binfmt_misc hwmon_vid no=
uveau intel_powerclamp coretemp kvm_intel kvm i2c_algo_bit ttm drm_kms_help=
er syscopyarea sysfillrect sysimgblt irqbypass fb_sys_fops pcspkr drm drm_p=
anel_orientation_quirks i2c_i801 nvidiafb cfbfillrect cfbimgblt lpc_ich vga=
state mfd_core e1000 e1000e
[69349.812285]  r8169 cfbcopyarea realtek wmi libphy xts cbc overlay loop f=
use nfs lockd grace sunrpc linear raid10 raid1 raid0 dm_thin_pool dm_snapsh=
ot dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor async_=
tx md_mod dm_mirror dm_region_hash dm_log dm_cache_smq dm_cache dm_persiste=
nt_data dm_bufio dm_bio_prison hid_sunplus hid_samsung hid_pl hid_petalynx =
hid_gyration usbhid ohci_hcd uhci_hcd usb_storage xhci_plat_hcd xhci_pci xh=
ci_hcd ehci_pci ehci_hcd pata_jmicron pata_amd pata_mpiix hpsa mptsas mpt3s=
as scsi_transport_sas mptspi scsi_transport_spi mptscsih mptbase sata_inic1=
62x sata_nv sata_sil24 ata_piix ahci libahci nvme nvme_core
[69349.812319] CPU: 3 PID: 6405 Comm: btrfs Tainted: G        W         5.6=
.3-gentoo-x86_64 #2
[69349.812321] Hardware name: Dell Inc. Precision T3610/, BIOS A03 09/05/20=
13
[69349.812325] RIP: 0010:refcount_warn_saturate+0xa6/0xf0
[69349.812327] Code: 05 1c e4 a8 00 01 e8 17 5c cb ff 0f 0b c3 80 3d 0a e4 =
a8 00 00 75 95 48 c7 c7 a0 78 d6 81 c6 05 fa e3 a8 00 01 e8 f8 5b cb ff <0f=
> 0b c3 80 3d e9 e3 a8 00 00 0f 85 72 ff ff ff 48 c7 c7 f8 78 d6
[69349.812329] RSP: 0018:ffffc9000149fd30 EFLAGS: 00010286
[69349.812331] RAX: 0000000000000000 RBX: ffff88854ef1cc00 RCX: 00000000000=
00007
[69349.812333] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff88884fd=
980b0
[69349.812334] RBP: ffff88854ef1cda0 R08: 000000000000231c R09: 00000000000=
00001
[69349.812336] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8888485=
b5e00
[69349.812337] R13: ffff8888485b5e00 R14: ffff88854ef1cc00 R15: ffff8888485=
b5e78
[69349.812340] FS:  00007fe0e36678c0(0000) GS:ffff88884fd80000(0000) knlGS:=
0000000000000000
[69349.812342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[69349.812343] CR2: 00007fcd3a19e6b8 CR3: 00000001265a6001 CR4: 00000000000=
606a0
[69349.812344] Call Trace:
[69349.812348]  btrfs_sysfs_rm_device_link+0x4e/0xe0
[69349.812353]  btrfs_rm_device.cold+0x6d/0x12b
[69349.812355]  btrfs_ioctl+0x2a08/0x2dc0
[69349.812358]  ? kmem_cache_alloc+0xa0/0x100
[69349.812362]  ? _copy_to_user+0x28/0x30
[69349.812364]  ? cp_new_stat+0x14b/0x180
[69349.812367]  ? __do_sys_newstat+0x48/0x70
[69349.812370]  ? ksys_ioctl+0x69/0xa0
[69349.812372]  ksys_ioctl+0x69/0xa0
[69349.812375]  __x64_sys_ioctl+0x11/0x20
[69349.812377]  do_syscall_64+0x43/0x120
[69349.812380]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[69349.812382] RIP: 0033:0x7fe0e3764c57
[69349.812384] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 =
7d d0 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 d2 0c 00 f7 d8 64 89 01 48
[69349.812386] RSP: 002b:00007ffd661c0e58 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000010
[69349.812388] RAX: ffffffffffffffda RBX: 00007ffd661c3010 RCX: 00007fe0e37=
64c57
[69349.812390] RDX: 00007ffd661c1e80 RSI: 000000005000943a RDI: 00000000000=
00003
[69349.812391] RBP: 0000000000000000 R08: 00007ffd661c1eb8 R09: 00000000000=
00231
[69349.812393] R10: 000055da8079e81b R11: 0000000000000202 R12: 00000000000=
00000
[69349.812395] R13: 000055da80841680 R14: 00007ffd661c1e80 R15: 00000000000=
00003
[69349.812397] ---[ end trace 8fa4b24e88c5878c ]---
[69349.886478] BTRFS info (device sdc1): device deleted: /dev/sdj1
[69385.855290] BTRFS info (device sdc1): dev_replace from /dev/sdk1 (devid =
6) to /dev/sdj1 started
