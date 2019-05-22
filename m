Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5022425BB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 03:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfEVBml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 21:42:41 -0400
Received: from mail-eopbgr1370084.outbound.protection.outlook.com ([40.107.137.84]:1888
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbfEVBml (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 21:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector1-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98PT7Ctsr7xWL9XgVyAxGmMBkug5wrvFpeDaNMvhUl8=;
 b=GARBRgvvGbdXrC8agUvd815MvmnXvs/Fho5tU7u/IzkXqDwqOS42KT87VbLcS0KDqT+No1By9hKOldqZrHn3XMglcK24cRNj9wEFpVpnGSRnGzw6/sAQQz0CbWasbHXt3vDf0mqBtNY5aMup0+9H4GIiiw+hMK2XfqLOMMixK/I=
Received: from SYBPR01MB5084.ausprd01.prod.outlook.com (20.178.194.213) by
 SYBPR01MB4457.ausprd01.prod.outlook.com (20.178.190.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 22 May 2019 01:42:33 +0000
Received: from SYBPR01MB5084.ausprd01.prod.outlook.com
 ([fe80::38f8:5e57:4059:8bf4]) by SYBPR01MB5084.ausprd01.prod.outlook.com
 ([fe80::38f8:5e57:4059:8bf4%7]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 01:42:33 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Stall on 5.1.3
Thread-Topic: Stall on 5.1.3
Thread-Index: AdUQPtETssZ4Mv2UQ7mi/viYXay2sg==
Date:   Wed, 22 May 2019 01:42:33 +0000
Message-ID: <SYBPR01MB5084AFCC98CC1D9C098DEF499E000@SYBPR01MB5084.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [110.174.5.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6366fe60-ffdc-4bbb-e6eb-08d6de56c2c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SYBPR01MB4457;
x-ms-traffictypediagnostic: SYBPR01MB4457:
x-microsoft-antispam-prvs: <SYBPR01MB44579F913F18B5B235E36C8A9E000@SYBPR01MB4457.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39830400003)(376002)(366004)(51234002)(53754006)(199004)(189003)(5660300002)(2351001)(305945005)(7736002)(52536014)(25786009)(316002)(53936002)(8936002)(486006)(81166006)(81156014)(476003)(2501003)(8676002)(186003)(26005)(86362001)(71200400001)(71190400001)(2906002)(7116003)(64756008)(6506007)(66446008)(66946007)(76116006)(66556008)(73956011)(68736007)(508600001)(66476007)(102836004)(14444005)(256004)(74482002)(6116002)(3846002)(5640700003)(9686003)(6436002)(6916009)(55016002)(66066001)(74316002)(99286004)(14454004)(33656002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:SYBPR01MB4457;H:SYBPR01MB5084.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FXLxoQoPPOmiTqYvy1heeOSNxP3cqIY9M2NKVV2iCIOGmCibvX/ruuLhI4AZotB9MeFoBFXnRqcYtLrLvPCpUdR/SFMT3ZbXppB6SdTPCxM0Z0EjPSV+/n536RkQVYGHcBOYnjIMtQtz5g4hGRFSwtvRQ3YB1mbCi02sc3qXXxMIqFMZdToGm9PQfw2ijsTPSQJoWc2KMzLUbBSVJbML4Lfm/x5oappSkEfy/7LyFGcNQ6l3Qhs9GEJxBc8IY8qdx796Xp7tQqrS/Z9hAYWW8lgZnz5tSoeNm+k7ECqTkIXWZLVydJ0apiuH5BdV8K0V8fq53Mfj3v9odbBu556LpNMSoLe6TG7JyCIkbbjd9br+2dgVogqZTrCbA3v+PP7Llwo8AXmVTaQ3rCAilWYGHclG56t+bA7aJ12rUj2dXko=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 6366fe60-ffdc-4bbb-e6eb-08d6de56c2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 01:42:33.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paul@pauljones.id.au
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB4457
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

I was rsyncing some subvolumes last night and at some point it stalled. Sta=
cktrace is provided in case it is helpful to devs.

Label: 'Backup'  uuid: 21e59d66-3e88-4fc9-806f-69bde58be6a3
        Total devices 4 FS bytes used 3.19TiB
        devid    1 size 2.73TiB used 2.71TiB path /dev/mapper/a-backup--a
        devid    2 size 2.73TiB used 2.71TiB path /dev/mapper/b-backup--b
        devid    3 size 931.51GiB used 500.00GiB path /dev/sdf1
        devid    4 size 931.51GiB used 500.00GiB path /dev/sdi1

Data, RAID1: total=3D3.16TiB, used=3D3.16TiB
System, RAID1: total=3D32.00MiB, used=3D592.00KiB
Metadata, RAID1: total=3D34.03GiB, used=3D28.49GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

Mount:
/dev/mapper/a-backup--a on /media/backup type btrfs (rw,noatime,compress=3D=
zstd:6,nossd,noacl,space_cache=3Dv2,subvolid=3D5,subvol=3D/)


May 22 07:36:16 home kernel: rcu: INFO: rcu_preempt self-detected stall on =
CPU
May 22 07:36:16 home kernel: rcu: \x092-....: (18000 ticks this GP) idle=3D=
862/1/0x4000000000000002 softirq=3D15766895/15766895 fqs=3D4660=20
May 22 07:36:16 home kernel: rcu: \x09 (t=3D18001 jiffies g=3D59669593 q=3D=
4556)
May 22 07:36:16 home kernel: NMI backtrace for cpu 2
May 22 07:36:16 home kernel: CPU: 2 PID: 28207 Comm: kworker/u16:15 Tainted=
: G           O      5.1.3-gentoo #2
May 22 07:36:16 home kernel: Hardware name: Gigabyte Technology Co., Ltd. T=
o be filled by O.E.M./B75M-D3H, BIOS F15 10/23/2013
May 22 07:36:16 home kernel: Workqueue: btrfs-delalloc btrfs_delalloc_helpe=
r
May 22 07:36:16 home kernel: Call Trace:
May 22 07:36:16 home kernel:  <IRQ>
May 22 07:36:16 home kernel:  dump_stack+0x46/0x60
May 22 07:36:16 home kernel:  nmi_cpu_backtrace.cold+0x14/0x53
May 22 07:36:16 home kernel:  ? lapic_can_unplug_cpu.cold+0x39/0x39
May 22 07:36:16 home kernel:  nmi_trigger_cpumask_backtrace+0x99/0xa3
May 22 07:36:16 home kernel:  rcu_dump_cpu_stacks+0x7b/0xa9
May 22 07:36:16 home kernel:  rcu_sched_clock_irq.cold+0x190/0x43b
May 22 07:36:16 home kernel:  ? cpuacct_account_field+0x11/0x60
May 22 07:36:16 home kernel:  update_process_times+0x24/0x60
May 22 07:36:16 home kernel:  tick_sched_timer+0x36/0x70
May 22 07:36:16 home kernel:  ? tick_sched_handle.isra.0+0x40/0x40
May 22 07:36:16 home kernel:  __hrtimer_run_queues+0xe2/0x170
May 22 07:36:16 home kernel:  hrtimer_interrupt+0x101/0x220
May 22 07:36:16 home kernel:  smp_apic_timer_interrupt+0x56/0x90
May 22 07:36:16 home kernel:  apic_timer_interrupt+0xf/0x20
May 22 07:36:16 home kernel:  </IRQ>
May 22 07:36:16 home kernel: RIP: 0010:queued_spin_lock_slowpath+0x3b/0x1a0
May 22 07:36:16 home kernel: Code: ff 75 41 f0 0f ba 2f 08 0f 92 c0 0f b6 c=
0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 1b 85 c0 74 0e 8b 07 8=
4 c0 74 08 <f3> 90 8b 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75=
 04
May 22 07:36:16 home kernel: RSP: 0018:ffffc90000613c28 EFLAGS: 00000202 OR=
IG_RAX: ffffffffffffff13
May 22 07:36:16 home kernel: RAX: 0000000000000110 RBX: 0000000000001000 RC=
X: 00000060c68b4000
May 22 07:36:16 home kernel: RDX: 0000000000000000 RSI: 0000000000000000 RD=
I: ffff88801b636c40
May 22 07:36:16 home kernel: RBP: ffff88801b636c00 R08: 0000000000000001 R0=
9: 0000000000001000
May 22 07:36:16 home kernel: R10: ffff888106554570 R11: 0000000000000001 R1=
2: 0000000000000000
May 22 07:36:16 home kernel: R13: ffff8882c75c2400 R14: ffff88801b636c40 R1=
5: ffff8882c75c2400
May 22 07:36:16 home kernel:  find_free_extent+0x75d/0xe60
May 22 07:36:16 home kernel:  btrfs_reserve_extent+0x9a/0x180
May 22 07:36:16 home kernel:  submit_compressed_extents+0xff/0x470
May 22 07:36:16 home kernel:  normal_work_helper+0x140/0x1e0
May 22 07:36:16 home kernel:  process_one_work+0x19c/0x310
May 22 07:36:16 home kernel:  worker_thread+0x45/0x3c0
May 22 07:36:16 home kernel:  kthread+0xf1/0x130
May 22 07:36:16 home kernel:  ? process_one_work+0x310/0x310
May 22 07:36:16 home kernel:  ? kthread_park+0x80/0x80
May 22 07:36:16 home kernel:  ret_from_fork+0x1f/0x40
May 22 07:39:16 home kernel: rcu: INFO: rcu_preempt self-detected stall on =
CPU
May 22 07:39:16 home kernel: rcu: \x092-....: (72003 ticks this GP) idle=3D=
862/1/0x4000000000000002 softirq=3D15766895/15766895 fqs=3D19438=20
May 22 07:39:16 home kernel: rcu: \x09 (t=3D72004 jiffies g=3D59669593 q=3D=
16770)
May 22 07:39:16 home kernel: NMI backtrace for cpu 2
May 22 07:39:16 home kernel: CPU: 2 PID: 28207 Comm: kworker/u16:15 Tainted=
: G           O      5.1.3-gentoo #2
May 22 07:39:16 home kernel: Hardware name: Gigabyte Technology Co., Ltd. T=
o be filled by O.E.M./B75M-D3H, BIOS F15 10/23/2013
May 22 07:39:16 home kernel: Workqueue: btrfs-delalloc btrfs_delalloc_helpe=
r
May 22 07:39:16 home kernel: Call Trace:
May 22 07:39:16 home kernel:  <IRQ>
May 22 07:39:16 home kernel:  dump_stack+0x46/0x60
May 22 07:39:16 home kernel:  nmi_cpu_backtrace.cold+0x14/0x53
May 22 07:39:16 home kernel:  ? lapic_can_unplug_cpu.cold+0x39/0x39
May 22 07:39:16 home kernel:  nmi_trigger_cpumask_backtrace+0x99/0xa3
May 22 07:39:16 home kernel:  rcu_dump_cpu_stacks+0x7b/0xa9
May 22 07:39:16 home kernel:  rcu_sched_clock_irq.cold+0x190/0x43b
May 22 07:39:16 home kernel:  ? cpuacct_account_field+0x11/0x60
May 22 07:39:16 home kernel:  update_process_times+0x24/0x60
May 22 07:39:16 home kernel:  tick_sched_timer+0x36/0x70
May 22 07:39:16 home kernel:  ? tick_sched_handle.isra.0+0x40/0x40
May 22 07:39:16 home kernel:  __hrtimer_run_queues+0xe2/0x170
May 22 07:39:16 home kernel:  hrtimer_interrupt+0x101/0x220
May 22 07:39:16 home kernel:  smp_apic_timer_interrupt+0x56/0x90
May 22 07:39:16 home kernel:  apic_timer_interrupt+0xf/0x20
May 22 07:39:16 home kernel:  </IRQ>
May 22 07:39:16 home kernel: RIP: 0010:queued_spin_lock_slowpath+0x3f/0x1a0
May 22 07:39:16 home kernel: Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 8=
9 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 1b 85 c0 74 0e 8b 07 84 c0 74 08 f=
3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47 01=
 00
May 22 07:39:16 home kernel: RSP: 0018:ffffc90000613c28 EFLAGS: 00000202 OR=
IG_RAX: ffffffffffffff13
May 22 07:39:16 home kernel: RAX: 0000000000000110 RBX: 0000000000001000 RC=
X: 00000060c68b4000
May 22 07:39:16 home kernel: RDX: 0000000000000000 RSI: 0000000000000000 RD=
I: ffff88801b636c40
May 22 07:39:16 home kernel: RBP: ffff88801b636c00 R08: 0000000000000001 R0=
9: 0000000000001000
May 22 07:39:16 home kernel: R10: ffff888106554570 R11: 0000000000000001 R1=
2: 0000000000000000
May 22 07:39:16 home kernel: R13: ffff8882c75c2400 R14: ffff88801b636c40 R1=
5: ffff8882c75c2400
May 22 07:39:16 home kernel:  find_free_extent+0x75d/0xe60
May 22 07:39:16 home kernel:  btrfs_reserve_extent+0x9a/0x180
May 22 07:39:16 home kernel:  submit_compressed_extents+0xff/0x470
May 22 07:39:16 home kernel:  normal_work_helper+0x140/0x1e0
May 22 07:39:16 home kernel:  process_one_work+0x19c/0x310
May 22 07:39:16 home kernel:  worker_thread+0x45/0x3c0
May 22 07:39:16 home kernel:  kthread+0xf1/0x130
May 22 07:39:16 home kernel:  ? process_one_work+0x310/0x310
May 22 07:39:16 home kernel:  ? kthread_park+0x80/0x80
May 22 07:39:16 home kernel:  ret_from_fork+0x1f/0x40
