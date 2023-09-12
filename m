Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567779DC62
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 01:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjILXDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 19:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjILXC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 19:02:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B4B10F4;
        Tue, 12 Sep 2023 16:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbT27kOlmEbfllag2Zg+A0yuOWkWT2hXGOAsrJ572irc7ACBRWkdndaozv2UMZY3KDgAeNW+J0NPZ8ge0GH3eZmggqIYsOIlyyHTD4KLlNmRIBVprEnCSTfP1Q35gUPal15JQJaIxiBM1IU+juf4gAyyUuEawuQV54+v7CAJNHrUjvOTXIAZl2euFkzd/ocSimH6G5BX/bZzMI6swLeMqK1KrBl5R/m2BVru4VVbdhyDi4M+roIOlo5/CgCMwBtAUItCdmsjSBuoNiekeUkGkAwNkbM5aoDiuonwl52k6xh6PrDqDVhdlebAEX/kv/6EToG3j8i/M3HqLslxWmTNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAYWf9UMa1YdavoT+Sc87n7Jwaaz6xVwZTFB8TLTzP4=;
 b=FgtYfnHtQmQnM1M8rj6ClGklX8oR3NwOUIjedofola3QHocAdNesVbylSuiG0iPoyOnoJG/urajVKXCbFHs8FSXDoqA3MVuAMK2Vux6Spq4ZbrZAT0P24zfvIfvxsOMMXdB5hZSPQINS6iug4aVrBnRwj7DV6kuzFILFximls+t+rOsNuJ0lRUknnn9a/nob/539725TvSsQ6X1hM+TNJ5ozAMss5KRjN8uoJqLruC06sfzyf7qWx1UfAUVxLVIGqvG7BoJKgr6l9O5SBXxqua2NilhTHwXvIhXC+Rm/ziDiG49A08i8jlJhQMWv9hV+JjY4QBALZ7YwNWE6xG8Dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAYWf9UMa1YdavoT+Sc87n7Jwaaz6xVwZTFB8TLTzP4=;
 b=lWm5PRdmgFDPoVPTliREiQehQsE1NmSpWgY87IdnuHTuVMOtd2yCutqsVn9Usz0Nx3UxKvvIGdcJgyYuMWMkTz78mS/jWGFld3Xz+Ds7sdIX2LU+SPYpcfp53vkUYsmCo2Ox9sPBivdVGJSEjkPr20K4d7uWbWwx+IaVIYCetG4=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 23:02:51 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:02:51 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: WARNING in btrfs_block_rsv_release
Thread-Topic: WARNING in btrfs_block_rsv_release
Thread-Index: AQHZ4c4NyDYMUt6sekiMo1CsSHKy0Q==
Date:   Tue, 12 Sep 2023 23:02:50 +0000
Message-ID: <BL0PR11MB3106A43B762A10A880E67172E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: fee6eac1-a07c-4686-91c6-08dbb3e463bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GE4b/1CTZ7xPo3EClMD6Ic/h1ArmnslsbNO+u5I2p3VwTDAFPOOfVIn9hiHUXFrXO8rosGIqrUTGS70uX477l3vbrMWqdjWXbrzdaAXIDYz5cX9kIoca52PBlbFbyExlKYWIExSzGhRf8akixJE81CQ12aptlJELiAZI7HKgZhGPQvdTXPy542k58Imtx7Y9Bmmo1EV8aQD42SRasXev+IhSzZaT1++DxO8hpUFfuuJpljNY63mqZe3kZ5eb7ChPD5o2glXrTdPYOZDD5y1qg9ruhuy92Tjvfuf3YbBaHpC4PBofOxKc2sv7Jmyyler8Vr77VM8sUZwwpOeVKxC66AhCxCaoWmHn2UGICM9lx2N55BPwsR2BegmM3exyfXA1QOOT2+1JLKzX0OwG/JyCiDyh4MdO9F5zvfsLCvUEAOkwF+TkvBqN729xSWakXcDCdwrHe2EA3I6c6V3alWwLko72yjvL+I9z/jbL/oDEgQaV3cqxg78CEhwnm3cYaz3GYLhIR5N6tQIypTa17KCxUkn7UxCneAlcXxd804MIk6IViko0o8DEfaHXvJysFCbNzAns3J1NGJR/XVpYXRf9mUWvjn25t5RuDjK/8669WpE2WwXVS00ty1oQwzzdsa3UAyE9xtDEK0lCiNWupzCphB/5ZcDxrPVsfO9md7Lbumlnad4NAui0ns0OijXLySK1+39gvpjUe+KUtHHIRvm0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(1800799009)(451199024)(186009)(7116003)(122000001)(5930299018)(6506007)(7696005)(71200400001)(33656002)(75432002)(38070700005)(55016003)(38100700002)(478600001)(83380400001)(26005)(45080400002)(52536014)(86362001)(2906002)(9686003)(41300700001)(64756008)(966005)(76116006)(8936002)(8676002)(5660300002)(4326008)(110136005)(54906003)(786003)(66946007)(66446008)(316002)(66476007)(66556008)(30864003)(58493002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CaOLQhKCF61LE5DgrTHpiI3+5rZsxxSvx7XxiC5GcfePSzH2MwUwc57xJf?=
 =?iso-8859-1?Q?FHsLcDvZejv8hxXqSnMMFKPePzo7nf1aT+9DYBegUPnGas+4RBrhjl2hgD?=
 =?iso-8859-1?Q?zB0pj353peJBwssOnGk1P9d+j8bstCu+jqEupGxpuGBeEuUmqKP3+t34gL?=
 =?iso-8859-1?Q?ty7MmjUd3ak7HrIyWkjljWHVqFUtYtUokYZfexAJXmzs7W9foTgT5nQazd?=
 =?iso-8859-1?Q?4iiLY4fMo1LVpIbhBZz7knqry4R+D1oT+NmMa8rd+fBfsr+bqJoJXmDTnx?=
 =?iso-8859-1?Q?vY81Kq7SPAzfRRO0vn1oyFcwJ/hO24ULrPt0SSoqLLZR7ah+fK7aTNZXgd?=
 =?iso-8859-1?Q?1ndr8ASZz1SRHaElMvHmuIWE10hPv8pDk72vQyJHr3u8IVWUTvoc+s/jpe?=
 =?iso-8859-1?Q?HF5YgIZ6Dh85OdiqdSE4TQvFYNH22XRKI8saR55kp5PozMAzDHxY9whmVH?=
 =?iso-8859-1?Q?Nd6IzrRSurWdASAMclfzsmanMAb+2geKL2G1S/uD3/uC/ZDm9tt7Vur7Do?=
 =?iso-8859-1?Q?xrK15bu3J9DJyk+fnvZ0RyYvlSs73ialTL8FNs8gYUR6tMlod47co9bRk8?=
 =?iso-8859-1?Q?gzg0nNIAJNKfthIxOM8HzaRpq5KR7PIKSMkcpB9ftzL7NO376/DfoabwaU?=
 =?iso-8859-1?Q?e6WLO9QrsqLxrt90aW4p/N93mwitN1EV9Ze5DybY33czIfw+mFDAsf+V7s?=
 =?iso-8859-1?Q?/AxdaSt2InpiTZo0w7d2czGyxPjb1EPa87YdEpVMJvakYRjKJOPXgVhrsB?=
 =?iso-8859-1?Q?WJc92HwkCFUJlIgbyzFzlnQjpTRtDSC904KiuPVunQaQTqt0MOtkYHDTDk?=
 =?iso-8859-1?Q?UvKiHwQ3/4wIM4kz6QwjFE88uo/Epjj1Yo3wGles/HPoJh+9MXgY4Tkebx?=
 =?iso-8859-1?Q?nWQpN7reSShtGPppD58c1F0SANo6gVRSY+LByEoO9f8tR4kcw3COterFO6?=
 =?iso-8859-1?Q?lRQyYvoqcZItJ2yAXS47w9kXRh6l++Ch9Tj0BCtLmTNf83rZuSlLDNgbfy?=
 =?iso-8859-1?Q?ySPPuAfhzJ5lW1iX6bm2H6v1b6NSXJ/yKwuPDQPeu1zUnXg6QlrF5wxFdV?=
 =?iso-8859-1?Q?Itjl/pDNYZt8ot2DiUcbVihiT/mKdAvqwQgDbr86Xnd05c8Ri5+HjK0X/1?=
 =?iso-8859-1?Q?vG2MfAZICNwdLKebwp9Kf5mMPH4Rh/+U0+t4BJYcpNrbAR7ilLP45JcEQH?=
 =?iso-8859-1?Q?/625Z6J0ea4IqfLTbC5tRunlRKe4MRJT4CVIP9L9XoXSqWlkraPB/qonRv?=
 =?iso-8859-1?Q?AgFfqrQuGYzNHYRRrhRITcDVqizTi0y+q5tM96hOg2oLdPIGg8NDgxioyF?=
 =?iso-8859-1?Q?NlFMmo5vBd/c8umk7ZDRNKKTaSsBbv1J/xURKBTKlMNltDsw9tGNgDwPE5?=
 =?iso-8859-1?Q?5WXbwc1YOzN9ce3ZVviJ99EMLM+N8Qw/Qud2pXYg9l0d+4pliprLMhdOuq?=
 =?iso-8859-1?Q?D4VwGF/NjEviIHGw3oGS32PQ4lumlotSxtlAq+muqlV24epAjmwEV1JoEX?=
 =?iso-8859-1?Q?+QUEYV89QngVmObGsQi62HFRWGYviX8aMuqPe8aTPpUWLURZKZ2Rmrmt65?=
 =?iso-8859-1?Q?fFIfRkQ0FapgtaRJeAaeyYRBjA9YXiXWMewVBeOZZAdVpGb7CYxN1ShD24?=
 =?iso-8859-1?Q?m0YnIfHAWqW1c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee6eac1-a07c-4686-91c6-08dbb3e463bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:02:50.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdn+wrMeS8Vnq13ozabF+MTF0VmXNiUH2HZypkEU1SmPgTgv2QnO1nD40OgygYUWuipHx6zbMnraFEIDkj9Z5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch: 6.3.0-next-20230426=0A=
Kernel Config: https://drive.google.com/file/d/1Y_qd41rAEHHmgd0soinXzReeRKv=
UEq6m/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1ydCeL6Dr0aawrcj3vSzoqhBJFozeE8=
PK/view?usp=3Dsharing=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_space_info_upd=
ate_bytes_may_use fs/btrfs/space-info.h:197 [inline]=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_space_info_fre=
e_bytes_may_use fs/btrfs/space-info.h:229 [inline]=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 block_rsv_release_by=
tes fs/btrfs/block-rsv.c:153 [inline]=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_block_rsv_rele=
ase+0x6c6/0x890 fs/btrfs/block-rsv.c:297=0A=
Modules linked in:=0A=
CPU: 1 PID: 7400 Comm: syz-executor.1 Not tainted 6.3.0-next-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:197 [=
inline]=0A=
RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:229 [in=
line]=0A=
RIP: 0010:block_rsv_release_bytes fs/btrfs/block-rsv.c:153 [inline]=0A=
RIP: 0010:btrfs_block_rsv_release+0x6c6/0x890 fs/btrfs/block-rsv.c:297=0A=
Code: 3c 02 00 0f 85 c7 01 00 00 48 8b 04 24 4c 89 ee 48 8b 58 60 48 89 df =
e8 88 9b 05 fe 4c 39 eb 0f 83 79 ff ff ff e8 ba 9f 05 fe <0f> 0b 31 db e9 7=
3 ff ff ff e8 ac 9f 05 fe 48 8b 04 24 be ff ff ff=0A=
RSP: 0018:ffffc9000f457af8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: 00000000000df000 RCX: 0000000000000000=0A=
RDX: ffff888116420000 RSI: ffffffff837be876 RDI: 0000000000000006=0A=
RBP: ffff8881151d8000 R08: 0000000000000006 R09: 00000000000df000=0A=
R10: 00000000000e0000 R11: 0000000000000001 R12: 00000000000e0000=0A=
R13: 00000000000e0000 R14: ffff888064cf2060 R15: 0000000000000000=0A=
FS:  0000555556a26980(0000) GS:ffff888119c80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f493c197878 CR3: 0000000058101000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 btrfs_release_global_block_rsv+0x26/0x2e0 fs/btrfs/block-rsv.c:440=0A=
 btrfs_free_block_groups+0xa0c/0x11d0 fs/btrfs/block-group.c:4278=0A=
 close_ctree+0x550/0xda0 fs/btrfs/disk-io.c:4649=0A=
 generic_shutdown_super+0x158/0x480 fs/super.c:500=0A=
 kill_anon_super+0x3a/0x60 fs/super.c:1107=0A=
 btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2133=0A=
 deactivate_locked_super+0x98/0x160 fs/super.c:331=0A=
 deactivate_super+0xb1/0xd0 fs/super.c:362=0A=
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177=0A=
 task_work_run+0x168/0x260 kernel/task_work.c:179=0A=
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]=0A=
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]=0A=
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204=0A=
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]=0A=
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297=0A=
 do_syscall_64+0x46/0x80 arch/x86/entry/common.c:86=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7fbdbe69173b=0A=
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffc3fd6bce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fbdbe69173b=0A=
RDX: 00007fbdbe628c20 RSI: 000000000000000a RDI: 00007ffc3fd6bdb0=0A=
RBP: 00007ffc3fd6bdb0 R08: 00007fbdbe6fb54e R09: 00007ffc3fd6bb70=0A=
R10: 00000000fffffffb R11: 0000000000000246 R12: 00007fbdbe6fb527=0A=
R13: 00007ffc3fd6ce50 R14: 0000555556a27d90 R15: 0000000000000032=0A=
 </TASK>=0A=
irq event stamp: 687881=0A=
hardirqs last  enabled at (687891): [<ffffffff8165e22e>] __up_console_sem+0=
xae/0xc0 kernel/printk/printk.c:347=0A=
hardirqs last disabled at (687900): [<ffffffff8165e213>] __up_console_sem+0=
x93/0xc0 kernel/printk/printk.c:345=0A=
softirqs last  enabled at (687718): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last  enabled at (687718): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
softirqs last disabled at (687703): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last disabled at (687703): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_space_info_upd=
ate_bytes_may_use fs/btrfs/space-info.h:197 [inline]=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_space_info_fre=
e_bytes_may_use fs/btrfs/space-info.h:229 [inline]=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 block_rsv_release_by=
tes fs/btrfs/block-rsv.c:153 [inline]=0A=
WARNING: CPU: 1 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_block_rsv_rele=
ase+0x6c6/0x890 fs/btrfs/block-rsv.c:297=0A=
Modules linked in:=0A=
CPU: 1 PID: 7400 Comm: syz-executor.1 Tainted: G        W          6.3.0-ne=
xt-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:197 [=
inline]=0A=
RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:229 [in=
line]=0A=
RIP: 0010:block_rsv_release_bytes fs/btrfs/block-rsv.c:153 [inline]=0A=
RIP: 0010:btrfs_block_rsv_release+0x6c6/0x890 fs/btrfs/block-rsv.c:297=0A=
Code: 3c 02 00 0f 85 c7 01 00 00 48 8b 04 24 4c 89 ee 48 8b 58 60 48 89 df =
e8 88 9b 05 fe 4c 39 eb 0f 83 79 ff ff ff e8 ba 9f 05 fe <0f> 0b 31 db e9 7=
3 ff ff ff e8 ac 9f 05 fe 48 8b 04 24 be ff ff ff=0A=
RSP: 0018:ffffc9000f457af8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: 00000000000df000 RCX: 0000000000000000=0A=
RDX: ffff888116420000 RSI: ffffffff837be876 RDI: 0000000000000006=0A=
RBP: ffff88804e3b8000 R08: 0000000000000006 R09: 00000000000df000=0A=
R10: 00000000000e0000 R11: 0000000000000001 R12: 00000000000e0000=0A=
R13: 00000000000e0000 R14: ffff888041a5f860 R15: 0000000000000000=0A=
FS:  0000555556a26980(0000) GS:ffff888119c80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f6d86215d78 CR3: 0000000058101000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 btrfs_release_global_block_rsv+0x26/0x2e0 fs/btrfs/block-rsv.c:440=0A=
 btrfs_free_block_groups+0xa0c/0x11d0 fs/btrfs/block-group.c:4278=0A=
 close_ctree+0x550/0xda0 fs/btrfs/disk-io.c:4649=0A=
 generic_shutdown_super+0x158/0x480 fs/super.c:500=0A=
 kill_anon_super+0x3a/0x60 fs/super.c:1107=0A=
 btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2133=0A=
 deactivate_locked_super+0x98/0x160 fs/super.c:331=0A=
 deactivate_super+0xb1/0xd0 fs/super.c:362=0A=
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177=0A=
 task_work_run+0x168/0x260 kernel/task_work.c:179=0A=
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]=0A=
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]=0A=
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204=0A=
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]=0A=
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297=0A=
 do_syscall_64+0x46/0x80 arch/x86/entry/common.c:86=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7fbdbe69173b=0A=
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffc3fd6bce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fbdbe69173b=0A=
RDX: 00007fbdbe628c20 RSI: 000000000000000a RDI: 00007ffc3fd6bdb0=0A=
RBP: 00007ffc3fd6bdb0 R08: 00007fbdbe6fb54e R09: 00007ffc3fd6bb70=0A=
R10: 00000000fffffffb R11: 0000000000000246 R12: 00007fbdbe6fb527=0A=
R13: 00007ffc3fd6ce50 R14: 0000555556a27d90 R15: 0000000000000032=0A=
 </TASK>=0A=
irq event stamp: 698649=0A=
hardirqs last  enabled at (698659): [<ffffffff8165e22e>] __up_console_sem+0=
xae/0xc0 kernel/printk/printk.c:347=0A=
hardirqs last disabled at (698670): [<ffffffff8165e213>] __up_console_sem+0=
x93/0xc0 kernel/printk/printk.c:345=0A=
softirqs last  enabled at (698296): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last  enabled at (698296): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
softirqs last disabled at (698181): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last disabled at (698181): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 3 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_space_info_upd=
ate_bytes_may_use fs/btrfs/space-info.h:197 [inline]=0A=
WARNING: CPU: 3 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_space_info_fre=
e_bytes_may_use fs/btrfs/space-info.h:229 [inline]=0A=
WARNING: CPU: 3 PID: 7400 at fs/btrfs/space-info.h:197 block_rsv_release_by=
tes fs/btrfs/block-rsv.c:153 [inline]=0A=
WARNING: CPU: 3 PID: 7400 at fs/btrfs/space-info.h:197 btrfs_block_rsv_rele=
ase+0x6c6/0x890 fs/btrfs/block-rsv.c:297=0A=
Modules linked in:=0A=
CPU: 3 PID: 7400 Comm: syz-executor.1 Tainted: G        W          6.3.0-ne=
xt-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:197 [=
inline]=0A=
RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:229 [in=
line]=0A=
RIP: 0010:block_rsv_release_bytes fs/btrfs/block-rsv.c:153 [inline]=0A=
RIP: 0010:btrfs_block_rsv_release+0x6c6/0x890 fs/btrfs/block-rsv.c:297=0A=
Code: 3c 02 00 0f 85 c7 01 00 00 48 8b 04 24 4c 89 ee 48 8b 58 60 48 89 df =
e8 88 9b 05 fe 4c 39 eb 0f 83 79 ff ff ff e8 ba 9f 05 fe <0f> 0b 31 db e9 7=
3 ff ff ff e8 ac 9f 05 fe 48 8b 04 24 be ff ff ff=0A=
RSP: 0018:ffffc9000f457af8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: 00000000000df000 RCX: 0000000000000000=0A=
RDX: ffff888116420000 RSI: ffffffff837be876 RDI: 0000000000000006=0A=
RBP: ffff888112680000 R08: 0000000000000006 R09: 00000000000df000=0A=
R10: 00000000000e0000 R11: 0000000000000001 R12: 00000000000e0000=0A=
R13: 00000000000e0000 R14: ffff888064033060 R15: 0000000000000000=0A=
FS:  0000555556a26980(0000) GS:ffff888119d80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fca667985f8 CR3: 0000000058101000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 btrfs_release_global_block_rsv+0x26/0x2e0 fs/btrfs/block-rsv.c:440=0A=
 btrfs_free_block_groups+0xa0c/0x11d0 fs/btrfs/block-group.c:4278=0A=
 close_ctree+0x550/0xda0 fs/btrfs/disk-io.c:4649=0A=
 generic_shutdown_super+0x158/0x480 fs/super.c:500=0A=
 kill_anon_super+0x3a/0x60 fs/super.c:1107=0A=
 btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2133=0A=
 deactivate_locked_super+0x98/0x160 fs/super.c:331=0A=
 deactivate_super+0xb1/0xd0 fs/super.c:362=0A=
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177=0A=
 task_work_run+0x168/0x260 kernel/task_work.c:179=0A=
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]=0A=
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]=0A=
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204=0A=
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]=0A=
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297=0A=
 do_syscall_64+0x46/0x80 arch/x86/entry/common.c:86=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7fbdbe69173b=0A=
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffc3fd6bce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fbdbe69173b=0A=
RDX: 00007fbdbe628c20 RSI: 000000000000000a RDI: 00007ffc3fd6bdb0=0A=
RBP: 00007ffc3fd6bdb0 R08: 00007fbdbe6fb54e R09: 00007ffc3fd6bb70=0A=
R10: 00000000fffffffb R11: 0000000000000246 R12: 00007fbdbe6fb527=0A=
R13: 00007ffc3fd6ce50 R14: 0000555556a27d90 R15: 0000000000000032=0A=
 </TASK>=0A=
irq event stamp: 709525=0A=
hardirqs last  enabled at (709535): [<ffffffff8165e22e>] __up_console_sem+0=
xae/0xc0 kernel/printk/printk.c:347=0A=
hardirqs last disabled at (709544): [<ffffffff8165e213>] __up_console_sem+0=
x93/0xc0 kernel/printk/printk.c:345=0A=
softirqs last  enabled at (709404): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last  enabled at (709404): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
softirqs last disabled at (709235): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last disabled at (709235): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
