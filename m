Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F76271DCF
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgIUIWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 04:22:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27595 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUIWv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 04:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600676571; x=1632212571;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KGSlv0cwCyFecAnL34k0xbkjkrBBi7eb0NHXse1GfJg=;
  b=d5oROber+szlPYe4RAQhR8rmvGE27FbfgDNcgLbjnYWz5ZqC+6UVUj26
   EGGI3IYRYdubO/Bv9foVmLOUdvB9W+temRSZF4+WPbOnP/LB3XSyPme8m
   ra/bprB46LayZTd7gGirQi2PAIkvW+cXrqObzEVxQ6OudpF1tMWOQe07D
   jNSwoelRy/s6Qprc0e2bdqlM3nZnDBZoeF44Vb4kN175jvevNPMAqEfBY
   /HHkAK0I4Rrzz42MVd0lh24Dqgc/UXm7i1ogl/EsV6jq03t1alZWL2m8e
   Gs0K5XU2QAVOuQHw6HN2T8tXTcNYtLDaFzqk+IMK2qlyaL8yT6sfiCt7e
   A==;
IronPort-SDR: upu6vls/3ARZ3yEBnD15YL7TSlOCeXKp0kV2EuUVlXrJyBGbYATm4d5KT36dbYSAKnoagPQyzR
 ypLGHXYHaHU7XpA6NST9874aioxsBoMLBYWo7bASkIhtEzDwsNna5gbHGY6MLic8P1V0hH3Fde
 he0GInncU+/Qfx023GQSi0VC9xMp4Y4GAysXFzWe6Q4BTYrsFfJ5qKnYkZI9w0n1KC+YQd3oIZ
 BBBdiuemPaIRpmqzUR4owfsjO+RumyG5an1OI6QXwson7IR5DLl2/jqda8mJGz7c4RlzGikF6J
 CAE=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147888960"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 16:22:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3Bz8GwgLsIbDFgpoMeUleJgRQaQUWra0ri8qvdm0J/rX1bMDrUy2bptyfUvjulRl+kiqXK5fiaGeJfMDYFFeAApndDE/011XMYOLkD/7eWqJqiKc3pPizpcNYNIjAxROnTwOnZaZnmfE8O+XMv9PWNnthEgyN9oQ6xHdtWnduENARHFcFpcz402uWrLmwg9s0Fc+nD1ETXLPKRubBpTigNORb8s0afdQO/FdVxymdXZnpR2a62rQAbWG6OYhB3dcEsN+srXmOyrSJsczVvPUbF+0jXrH5BaFEW3QTfblFguP56olcN06bDsm2gmaoBVcOtbiEmG1q/niMR01IvZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u7vNPme2LVqkNkfoRXweAbrp4nJhnS/axOdvH8pR4o=;
 b=Wl/8/tulVZ2gb3mrEAF20LzsFIiLEwX4y2nd3c0mKZXQsM6qN31yruOploGSdaHUM4diKMpWNLbizZWy/nal/MUfavo3BiyV2Tf1KiArhDJGgX8g+ldGdR/i/sqzl0QuLL1dPSavBhkL60skpAYuIXTrKeATye76m5mQsNZpEGo9uoWDPye1YdzNtnJMPnSFr5FOzNmo8YxSHPGQVGyryuANezgkvn+IKgtourUtUKkIGDBr/OwwQ/ePc5CrL3zXuwcYo9OgU9pVT2G5ZJ8c/hMzm0NUKXqHPTqtJUNg4y6hRo787apcNoE180AO92NK6ez3hVIzmVTRg3f5lCUl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u7vNPme2LVqkNkfoRXweAbrp4nJhnS/axOdvH8pR4o=;
 b=j/S/y3J0kG1Zgoz/rJXKZPhCPyHa5/djH+A3DH1oVgU1mRM9cUCCuW0cYPABfUm9G8sjPlwdur6kVo1Zip7dd7VDiLKrrDaeTSpUSRxXPMoEVij7SU8f043X01XvfaT6EiBPVOGOCTwJKwovZ2mabaeZ4uMI94E/2btoyfwMZR0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 08:22:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 21 Sep 2020
 08:22:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in btrfs_scan_one_device
Thread-Topic: KASAN: use-after-free Read in btrfs_scan_one_device
Thread-Index: AQHWj1gW4I1eiPU8KEe/g2JKytiw2Q==
Date:   Mon, 21 Sep 2020 08:22:48 +0000
Message-ID: <SN4PR0401MB3598EF5CB8F9D6419DC236DB9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <000000000000c9e14b05afcc41ba@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [62.216.205.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d039d46-dc07-48e0-fee5-08d85e078662
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB367759A7A01795C9F3ACBE909B3A0@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUWIzHgoxbYU5XfXPuKJtEqI1xyhvkKSab67nsXuVBtFXOtjD5YsovceSC/SV+UfSSvooz+YiDeZuAbliJvFb+6hcfCyUj32dfjE6WKhiPPu0PIq4lmpKLbKZtS8pRTys22D2EcjxY3nB1toAOZ2HsYdUWiU6bnzr8rwxSzB7ULQWyjrr4r8URxG4b2dihBPGf6KfKKjrFUNY+ujZBlNDNyi22VzSFChSWJs1gFZczbS43FtFblKlq74JmwQNiEoi2ECzD/x4qM7cMbe+brqzAszcIZQJkjRWqXqj/XF2Woj01Hg8YioEjq+Um5Dh5zZjMpKO16pYRXaVneSXxVTjOWgWu2jd74YgZ5Jp6AiFThTffD4q3tD44kDuCQvPAwEchZmO866CPC5QQ2FdBslAIM44FfWxspCwilsmGSLYVgPiJI+0adcR9QpW3tJfzXbrajKrfxd//gYhAa2lGWPyeXkXfWKF26z1Ef7ubHHf0aLTOB0pwrDU/xsIm5i/MZH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(478600001)(966005)(8936002)(26005)(8676002)(53546011)(6506007)(7696005)(186003)(86362001)(83380400001)(83080400001)(110136005)(316002)(71200400001)(55016002)(5660300002)(2906002)(66946007)(66446008)(64756008)(66476007)(91956017)(76116006)(66556008)(33656002)(9686003)(52536014)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AJMrLBF75OYAFTZBcvmNMMso0k4RbuckJzem1cyGcsxmgE16AjWhpc8ysrmbNPMFbQ31OpvRBZFY8N2McHLcfCqyxLGeAav9UR3UqB9eC0ZvLXF1PhfeF+4rqEivgF+7A66GKQIgKFISUmN9kdhOdiAZh4S4VZ74uXNHY5YkDpXnXmi8oWi8nWW5RF2sMjDMYm/ib2VkLjm3GtrIDIztja/hfy+dzJa3CLSYLfcWnvWwepiJ/5GvQmpNheFN6KE6MLvw5YJrtqdm+h62RmhqiLZTtEv7+OiDHTOoHGr5PS6pF5xeeXB+8x5VJ7A/sk9jtw9efxPpRAIyhxibkT1kP5MFHFh83jukfD5wF6dUEdfJRBRonqJN8+QtQTt5kpCH2uhfUz/0bfwRGyoENfkPQ61UGebuk0eKLwNKHXhRq0gmVuvXLVO7CDUPLcXQ6T3I2Zp+Tz+Xdq/ZfuOSjmIjnEb4De6mlFzsAiKf1mym5YmlwJLzDC9bK0OxyoNmLu5PLFTYyCm54/J/tEzFjORMzFKZ4O11prGe0fiL2Sz2qSCAOsWq5ElJqBb39nT11aPdPxhi2LfPH4Q5cmXnDH+74FMPW9WtYK39kdlbUsVZz3VZjtdWC/RraPYtR8dKngpmaKjyDRIWvXCIPbZ+/IviBg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d039d46-dc07-48e0-fee5-08d85e078662
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 08:22:48.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kF8Wak3/bhSsXwWhV/HUDVBblqyC4e3cuVwdF+6g9zQ0TYR7xYQ5Wo2//ITe10uOA35BVGME+5YWzicitdT4gh/qEBWha+x9vkK0O72BbzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2020 07:38, syzbot wrote:=0A=
> syzbot has found a reproducer for the following issue on:=0A=
> =0A=
> HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)=0A=
> git tree:       upstream=0A=
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1512df5390000=
0=0A=
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6a8a2ae52ed73=
7db=0A=
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D582e66e5edf36a2=
2c7b0=0A=
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-projec=
t/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)=0A=
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12366f8b900=
000=0A=
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14e6929b90000=
0=0A=
> =0A=
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:=0A=
> Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com=0A=
> =0A=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> BUG: KASAN: use-after-free in btrfs_printk+0x3eb/0x435 fs/btrfs/super.c:2=
45=0A=
> Read of size 8 at addr ffff8880878e06a8 by task syz-executor225/7068=0A=
> =0A=
> CPU: 1 PID: 7068 Comm: syz-executor225 Not tainted 5.9.0-rc5-syzkaller #0=
=0A=
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011=0A=
> Call Trace:=0A=
>  __dump_stack lib/dump_stack.c:77 [inline]=0A=
>  dump_stack+0x1d6/0x29e lib/dump_stack.c:118=0A=
>  print_address_description+0x66/0x620 mm/kasan/report.c:383=0A=
>  __kasan_report mm/kasan/report.c:513 [inline]=0A=
>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530=0A=
>  btrfs_printk+0x3eb/0x435 fs/btrfs/super.c:245=0A=
>  device_list_add+0x1a88/0x1d60 fs/btrfs/volumes.c:943=0A=
>  btrfs_scan_one_device+0x196/0x490 fs/btrfs/volumes.c:1359=0A=
>  btrfs_mount_root+0x48f/0xb60 fs/btrfs/super.c:1634=0A=
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592=0A=
>  vfs_get_tree+0x88/0x270 fs/super.c:1547=0A=
>  fc_mount fs/namespace.c:978 [inline]=0A=
>  vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008=0A=
>  btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732=0A=
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592=0A=
>  vfs_get_tree+0x88/0x270 fs/super.c:1547=0A=
>  do_new_mount fs/namespace.c:2875 [inline]=0A=
>  path_mount+0x179d/0x29e0 fs/namespace.c:3192=0A=
>  do_mount fs/namespace.c:3205 [inline]=0A=
>  __do_sys_mount fs/namespace.c:3413 [inline]=0A=
>  __se_sys_mount+0x126/0x180 fs/namespace.c:3390=0A=
>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46=0A=
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
> RIP: 0033:0x44840a=0A=
> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00=0A=
> RSP: 002b:00007ffedfffd608 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5=0A=
> RAX: ffffffffffffffda RBX: 00007ffedfffd670 RCX: 000000000044840a=0A=
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffedfffd630=0A=
> RBP: 00007ffedfffd630 R08: 00007ffedfffd670 R09: 0000000000000000=0A=
> R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000001a=0A=
> R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003=0A=
> =0A=
> Allocated by task 6945:=0A=
>  kasan_save_stack mm/kasan/common.c:48 [inline]=0A=
>  kasan_set_track mm/kasan/common.c:56 [inline]=0A=
>  __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461=0A=
>  kmalloc_node include/linux/slab.h:577 [inline]=0A=
>  kvmalloc_node+0x81/0x110 mm/util.c:574=0A=
>  kvmalloc include/linux/mm.h:757 [inline]=0A=
>  kvzalloc include/linux/mm.h:765 [inline]=0A=
>  btrfs_mount_root+0xd0/0xb60 fs/btrfs/super.c:1613=0A=
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592=0A=
>  vfs_get_tree+0x88/0x270 fs/super.c:1547=0A=
>  fc_mount fs/namespace.c:978 [inline]=0A=
>  vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008=0A=
>  btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732=0A=
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592=0A=
>  vfs_get_tree+0x88/0x270 fs/super.c:1547=0A=
>  do_new_mount fs/namespace.c:2875 [inline]=0A=
>  path_mount+0x179d/0x29e0 fs/namespace.c:3192=0A=
>  do_mount fs/namespace.c:3205 [inline]=0A=
>  __do_sys_mount fs/namespace.c:3413 [inline]=0A=
>  __se_sys_mount+0x126/0x180 fs/namespace.c:3390=0A=
>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46=0A=
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
> =0A=
> Freed by task 6945:=0A=
>  kasan_save_stack mm/kasan/common.c:48 [inline]=0A=
>  kasan_set_track+0x3d/0x70 mm/kasan/common.c:56=0A=
>  kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355=0A=
>  __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422=0A=
>  __cache_free mm/slab.c:3418 [inline]=0A=
>  kfree+0x113/0x200 mm/slab.c:3756=0A=
>  deactivate_locked_super+0xa7/0xf0 fs/super.c:335=0A=
>  btrfs_mount_root+0x72b/0xb60 fs/btrfs/super.c:1678=0A=
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592=0A=
>  vfs_get_tree+0x88/0x270 fs/super.c:1547=0A=
>  fc_mount fs/namespace.c:978 [inline]=0A=
>  vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008=0A=
>  btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732=0A=
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592=0A=
>  vfs_get_tree+0x88/0x270 fs/super.c:1547=0A=
>  do_new_mount fs/namespace.c:2875 [inline]=0A=
>  path_mount+0x179d/0x29e0 fs/namespace.c:3192=0A=
>  do_mount fs/namespace.c:3205 [inline]=0A=
>  __do_sys_mount fs/namespace.c:3413 [inline]=0A=
>  __se_sys_mount+0x126/0x180 fs/namespace.c:3390=0A=
>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46=0A=
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
> =0A=
> The buggy address belongs to the object at ffff8880878e0000=0A=
>  which belongs to the cache kmalloc-16k of size 16384=0A=
> The buggy address is located 1704 bytes inside of=0A=
>  16384-byte region [ffff8880878e0000, ffff8880878e4000)=0A=
> The buggy address belongs to the page:=0A=
> page:0000000060704f30 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x878e0=0A=
> head:0000000060704f30 order:3 compound_mapcount:0 compound_pincount:0=0A=
> flags: 0xfffe0000010200(slab|head)=0A=
> raw: 00fffe0000010200 ffffea00028e9a08 ffffea00021e3608 ffff8880aa440b00=
=0A=
> raw: 0000000000000000 ffff8880878e0000 0000000100000001 0000000000000000=
=0A=
> page dumped because: kasan: bad access detected=0A=
> =0A=
> Memory state around the buggy address:=0A=
>  ffff8880878e0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
>  ffff8880878e0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
>> ffff8880878e0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
>                                   ^=0A=
>  ffff8880878e0700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
>  ffff8880878e0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> =0A=
> =0A=
=0A=
Could reporoduce this one, working on it=0A=
