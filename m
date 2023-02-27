Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9655C6A3B39
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 07:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjB0GX7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 01:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjB0GX6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 01:23:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F1C668;
        Sun, 26 Feb 2023 22:23:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVNuHCfE7wspwwiNno0XtGW6YarA47ewtgKbRhno5JtbpyKhVB/VW1i/3TQYMN4LnlaeKhg3n2rcsZvPRRyb79QuVQzcWvAS8CjUsZPUiB1hph0RzC/l9f97qRMO4obqbTtjgLzPQGezFkakXnC3a8dbxYVHAXjof1+AP9YgqymApPd2FoLtsrX+SXLPDC6S1jj6LimQoaVN6Px/pGQBhrIV+Dd1I/CUPVaPm8MxeJnmUV9heq20Rl5Jbv6+N6EmQER5h7s2NjjWnc63Afrb3KhJNo73a610zxekFwFc8vdxUjEvbecH9ht7vAGj/pM6U+0YoFzg+RyJaqianDKSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=876IegzJofdeU5rSG2ONjjWBOx68PM4Zjk5YZzo3dAA=;
 b=imeaJ2bZy8XMRZREgYf+QMR4GW+p3siB1ScOe5eD4VM0WoJw75crR8vbzu0gGjm7AajhWdjSqYKcYHcDemWpz2cu6yBXyXQt+IRIks+8fp9tfgDWAPuCQ4+AQINtbYEYewFd6E+S2Nc+gks3YrWAaQ02GrqtDW6jUQD+gpa4WZknAXUdm6CPie60u7R9ln9WwJfUNcvb2laDSZILHRqJT6PhNiXd8nkeeO3uiMX/h7ip3uBItZkHRIMACY76/y6yreuULUphEPJRxhk4rmneIJ76n+0z0CMjYD0FfvJUoZmXpEHxbtriQvcicyOnDSDoyleZIjsN7LUYXpSjmz7CtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=876IegzJofdeU5rSG2ONjjWBOx68PM4Zjk5YZzo3dAA=;
 b=GZB/b9GB1r1RihvN5PSEeq4b7pK1ghv99pQR1mX4HEyWG/SxAg30gFE7awHJKYNy5hm/DeFFxZK/9D4hPyJmWH4/7Hb3WqMI3zOI17NsfkI7DawL8VO3TXOBjf0Y38a6qDJ547ada9uZQ4tG0ZRoiACDRu1zXd9udYCSMFIUrfU=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by SJ0PR07MB9123.namprd07.prod.outlook.com (2603:10b6:a03:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 06:23:34 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 06:23:34 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: kernel BUG in btrfs_global_root_insert
Thread-Topic: kernel BUG in btrfs_global_root_insert
Thread-Index: AQHZSnMzTuEAqcOzNEC5oBl5E9uMxQ==
Date:   Mon, 27 Feb 2023 06:23:34 +0000
Message-ID: <IA1PR07MB9830E423E811EADC458805E3ABAF9@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|SJ0PR07MB9123:EE_
x-ms-office365-filtering-correlation-id: 5c18a7d0-0963-4092-1660-08db188b2752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4KTi2DaPmfjP1r3CZP0r4No63ZKNvmuM0BFqt1vEYFHLWL5+WvN3VyWxcNd+AhdMLeNygb+sZ2roOzuFFg75cytawy49m/wgxHT+gAT9pz0qiYgtC0n7cA0tzEl4B7Ad0OfAgZwgbGx5Bhz0eXL0a/te/TRwYfKmm2J61C3vjl0FfMgq0IgtNg/vG6jLpk5FTzks0dC7V6qjKJtFU+AkJJaNUwB43mOmig2vieeugJde1qrp/JAwQQbetNNC5DwuNZ49HYP/T0YTc8zLbg+bUaezMyeYzKHj5ESd/J/POlXqLGqChWzMwu2ay1WfpP9GsJ2R/eY+BeLk162WDvRZKhcczk7raaKZYdS5qXk/buO2Hk4CNixxM3aksQPvW8ueF+L2qzmT2Ti/zw7yBEPv9K0syQHVetCStENnRQmDTFI3pSQg5tQkg66MP0EWxhMClWBt5gMfz8ODtojfvE0tLSAaj+Ibdkb1mEJCoBlJ9WvbPTCXYV7B9nXeIXvh6/vsbTluZ/ELNM4v6w0BelSLc2rzzFbCkFYQFSN0ZrVZ2kdd/S7M6wyuDw2Jd61Gbl3gxTpMt1M//iTLvT4XYqB2rP7xotQl1055izkgcXiaIi71okaZPx0+nXUYdqqQTn5PkbN6fmB3+yXuS3I1eI+OO3PGG7S+f7Qq7p+xv8NzBlfflZz8DrtEkMQK6rXsE/rq0ZVWZxkCD1x+BUfOSMCU/XA5fTwOs2Xw0A4F+z6oqdGxVLFtARbV+4kk33QeFk6m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(83380400001)(52536014)(44832011)(8936002)(2906002)(5660300002)(122000001)(55016003)(38070700005)(41300700001)(76116006)(64756008)(66446008)(66476007)(66556008)(91956017)(66946007)(5930299012)(8676002)(38100700002)(4326008)(7696005)(45080400002)(966005)(86362001)(41320700001)(9686003)(186003)(26005)(6506007)(71200400001)(478600001)(75432002)(33656002)(316002)(786003)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?foMbqusKPRP7x5Eutb7e1p8wFY/wcU8c3LO3QtObeqPb6ZyP7n+9Y6k71p?=
 =?iso-8859-1?Q?xmi0eMpqiH/bW33er8MphgeJw6Uhryab8o43TCP4y7R49mr17QX3PZQgX1?=
 =?iso-8859-1?Q?mUdvwLRloutiDrt2UWkg6zK0ADwpukdKL3euEof/gZ+NT7FZ3jgY1OArR1?=
 =?iso-8859-1?Q?3xgff8lhWJs2/soD74SKrq36wfJF3R87YxbIdwd3giJq2dt08PibtVCoKi?=
 =?iso-8859-1?Q?sSO06NSsSVjB5ENz8O+scLql2xfthNQI52+2IyZTG7HhmaV8F1ldn/N7C1?=
 =?iso-8859-1?Q?PqH8JttBXM6ucVvlkg+etfuYw48c7osguFiIEOWneAIGSKMMHyTGoqQ1Xy?=
 =?iso-8859-1?Q?6UKINlzoTD2EgY6sWAydKvIvAg4MsgKzRKj/0o+7aUyxtrqQ5tc6ZpyQVs?=
 =?iso-8859-1?Q?24FMudQHw6eOpXg0t3j0UUaiUSz4MTf6EVwRUfDlxsEDM2nZRJOkKegWID?=
 =?iso-8859-1?Q?1/1v1Qz0UpO1sT2tO7CUA0HnnOAJZ95iecmnohm4r6QwfNKyChqa5YSkhc?=
 =?iso-8859-1?Q?x2zpfrin/yzw5WVDg2/DzZM4+tGhZ1GkiMUJnfovzhWw8sbz4fSSQ+197f?=
 =?iso-8859-1?Q?chBK3AgoUKr41y6nuiVF8Lv4GpxMe2APvyKLRJL/Spey5rVCjZKt9NAiWa?=
 =?iso-8859-1?Q?G+VxaM+ixsOA09PlZ8imp9mfo6Lz08ZHZfnrwccW4HyS44Iv+VO9PhkIWm?=
 =?iso-8859-1?Q?7Rkl+zEu9D7dUMBDd+QfVPr62MPnmyDrf8T+4aJ8J05B8ZtKb8iJcquPPx?=
 =?iso-8859-1?Q?6HCgz25PM7FhSCx0v7mwRb5uICRZj1Bsxs+CXuw4GAWR8DqvZID5tL0gvQ?=
 =?iso-8859-1?Q?oTpHIb4WR+/INoxVAzWpQVC9wXLiC3Xq/JR1lZACtGk+Dt4JCrMdYXbMeM?=
 =?iso-8859-1?Q?hgMLRfy8DCFatgXZ6pb+bDMoW+Wg1HiqWaaKjMZgyp78KPYHloZfHWgOY3?=
 =?iso-8859-1?Q?AXPfuAGvFLVC0EP/DWYerow4lVT61Td2rShh7CD1oI6135QaPnhvgPmxA/?=
 =?iso-8859-1?Q?vh62FEdDFcGJNEbiBo6DwcTyxVZsNRoNmjSTreUv6ytyUrPHT1oWAmpEGq?=
 =?iso-8859-1?Q?fk9Lm561IV8uuAHyqwPitA0XV9jwUnKHeFRsQzK5rcXvjaa9UnGbqXFXPS?=
 =?iso-8859-1?Q?q0ndn+Q8u1bR2WBJ+Ta43STuUBpbZPYsjj0XNw65I+RDLqthGIv/vw1cUC?=
 =?iso-8859-1?Q?3LrfAjNvNMHOG+HTq5jFKf9x1hP+mIRdF5nJgPFl4MQtQeb6ifDMxwwJGD?=
 =?iso-8859-1?Q?Gca7CJpWV0dEOc1Na06IJQ/tCoooYvxY+08RC7V4EMQJuAK5SpwyFAJr86?=
 =?iso-8859-1?Q?/PkinEfP0HOkQznb3NYAwaPRdFhZSO5Xic/fwWDdSiAQawNdHGQdzNpZDL?=
 =?iso-8859-1?Q?TMOHiunr7s4X92QTAx7Ve4PFyHUt+lfqeqKxeCYLNwpuySli8l2VUvypTC?=
 =?iso-8859-1?Q?9eVdWxusMTlSQXq7cPMWSzPg98zIRWUhGoaYXpXLus2vGaHONUjRjAr1CW?=
 =?iso-8859-1?Q?Nr9ToiODe3OkexUa4IDFu2hKCym/RXJ0iA+vCshUTLiqQILxvNecNTooCR?=
 =?iso-8859-1?Q?Jj0EVbtk+7i8hNgH9Gb2aW5PCwHOJ8feA2ioVyHnb7OYEAk7FrQMnbC1uv?=
 =?iso-8859-1?Q?nyYs9FuyzGBZ1oC3sOHXuPVypvBzRgxxTqnZN+y7U7NXjGB/w4p9vsDg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c18a7d0-0963-4092-1660-08db188b2752
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 06:23:34.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ir9aKLr4RC07ONEB1kMPXZ+qCOPqYPfpSX9KvZQEYo/RqU0En77PhTS23nTFtW7JO9ObcipheT1iXKQICbNkPfz4YKLx9ePLZGTk1WWWHPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9123
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Kernel Branch: 6.2.0-rc8-next-20230216=0A=
Kernel config: https://drive.google.com/file/d/1kpgNI36h0EQvewtvqC6j8Qv2VGr=
Wuiwz/view?usp=3Dshare_link=0A=
C Reproducer:=A0https://drive.google.com/file/d/1HS0Rd6uxycIxCq0Qv8KwKXgHSZ=
9W27fb/view?usp=3Dshare_link=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
BTRFS warning (device loop0): couldn't read tree root=0A=
assertion failed: !tmp, in fs/btrfs/disk-io.c:1002=0A=
------------[ cut here ]------------=0A=
kernel BUG at fs/btrfs/messages.c:259!=0A=
invalid opcode: 0000 [#1] PREEMPT SMP KASAN=0A=
CPU: 1 PID: 24800 Comm: syz-executor.0 Not tainted 6.2.0-rc8-next-20230216+=
 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:btrfs_assertfail+0x2c/0x30 fs/btrfs/messages.c:259=0A=
Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 c9 7a 21 fe 44 89 =
e9 4c 89 e2 48 89 ee 48 c7 c7 e0 e3 d4 8a e8 94 e1 07 fe <0f> 0b 66 90 66 0=
f 1f 00 55 48 89 fd e8 a3 7a 21 fe 48 89 ef 5d 48=0A=
RSP: 0018:ffffc9000c1af670 EFLAGS: 00010286=0A=
RAX: 0000000000000032 RBX: ffff8880453be000 RCX: ffffc900126de000=0A=
RDX: 0000000000000000 RSI: ffffffff81614205 RDI: 0000000000000001=0A=
RBP: ffffffff8ad239a0 R08: 0000000000000001 R09: ffff8881198a898b=0A=
R10: ffffed1023315131 R11: 6f69747265737361 R12: ffffffff8ad22a40=0A=
R13: 00000000000003ea R14: ffff888116e98060 R15: 0000000000000000=0A=
FS:  00007f036ab58700(0000) GS:ffff888119880000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fff8adf26c0 CR3: 000000004c692000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 btrfs_global_root_insert+0x1e6/0x250 fs/btrfs/disk-io.c:1002=0A=
 load_global_roots_objectid+0x11d/0x850 fs/btrfs/disk-io.c:2361=0A=
 load_global_roots fs/btrfs/disk-io.c:2395 [inline]=0A=
 btrfs_read_roots fs/btrfs/disk-io.c:2422 [inline]=0A=
 init_tree_roots fs/btrfs/disk-io.c:2845 [inline]=0A=
 open_ctree+0x213f/0x4ee0 fs/btrfs/disk-io.c:3541=0A=
 btrfs_fill_super fs/btrfs/super.c:1152 [inline]=0A=
 btrfs_mount_root+0x98b/0xcd0 fs/btrfs/super.c:1521=0A=
 legacy_get_tree+0x107/0x210 fs/fs_context.c:610=0A=
 vfs_get_tree+0x8d/0x330 fs/super.c:1501=0A=
 fc_mount fs/namespace.c:1035 [inline]=0A=
 vfs_kern_mount.part.0+0xaf/0x140 fs/namespace.c:1065=0A=
 vfs_kern_mount+0x40/0x60 fs/namespace.c:1052=0A=
 btrfs_mount+0x20d/0x990 fs/btrfs/super.c:1581=0A=
 legacy_get_tree+0x107/0x210 fs/fs_context.c:610=0A=
 vfs_get_tree+0x8d/0x330 fs/super.c:1501=0A=
 do_new_mount fs/namespace.c:3042 [inline]=0A=
 path_mount+0x4bf/0x1ac0 fs/namespace.c:3372=0A=
 do_mount fs/namespace.c:3385 [inline]=0A=
 __do_sys_mount fs/namespace.c:3594 [inline]=0A=
 __se_sys_mount fs/namespace.c:3571 [inline]=0A=
 __x64_sys_mount+0x235/0x2c0 fs/namespace.c:3571=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f0369a9176e=0A=
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f036ab57a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5=0A=
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0369a9176e=0A=
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f036ab57a60=0A=
RBP: 00007f036ab57aa0 R08: 00007f036ab57aa0 R09: 0000000020000000=0A=
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000=0A=
R13: 0000000020000100 R14: 00007f036ab57a60 R15: 0000000020000040=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:btrfs_assertfail+0x2c/0x30 fs/btrfs/messages.c:259=0A=
Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 c9 7a 21 fe 44 89 =
e9 4c 89 e2 48 89 ee 48 c7 c7 e0 e3 d4 8a e8 94 e1 07 fe <0f> 0b 66 90 66 0=
f 1f 00 55 48 89 fd e8 a3 7a 21 fe 48 89 ef 5d 48=0A=
RSP: 0018:ffffc9000c1af670 EFLAGS: 00010286=0A=
RAX: 0000000000000032 RBX: ffff8880453be000 RCX: ffffc900126de000=0A=
RDX: 0000000000000000 RSI: ffffffff81614205 RDI: 0000000000000001=0A=
RBP: ffffffff8ad239a0 R08: 0000000000000001 R09: ffff8881198a898b=0A=
R10: ffffed1023315131 R11: 6f69747265737361 R12: ffffffff8ad22a40=0A=
R13: 00000000000003ea R14: ffff888116e98060 R15: 0000000000000000=0A=
FS:  00007f036ab58700(0000) GS:ffff888119880000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fff8adf26c0 CR3: 000000004c692000 CR4: 0000000000350ee0=0A=
=0A=
