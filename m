Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E6271E5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 10:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIUIxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 04:53:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2396 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgIUIxO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 04:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600678393; x=1632214393;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VQaxq9GX/jUdm9DTyeU2mp8fX4Rf6D4cBylMUBxDREI=;
  b=OF/lHK+BQKdMJQZywlmEPfLsYfvW3GWz6Sk1VeLrm6t0W2oQarqPCF+E
   Jk6ozUQe8hUH+r4NGCOdbFbhx5CZEdFeQBWEdz1ZBUtdh8QzDlHzcjq/4
   KYKYlojSMjgNLGdcw7p9vxySEcwj6Mcbj9bh+PK42MTdvznCMCc7et4Hi
   BlJk++P2zfy+LUeWVsb5RzdCiNJLvTMxLTIsLRM5kYBenhqWgaWFl5PKH
   lpsU1+LoJySGFws4YemyfM7GWzrvBvIBe9Xp8WYHePeczpdM+6gHNq4Nh
   EKFF9D/wmoleSeYLJylgYAeZ/7WvyqU5hCMpUAAbMq6eRU7dLb90rpknv
   w==;
IronPort-SDR: BO/K4CNymD8RmqauXRSaR5G0TUOrDEVhngV8z4N4ccIEqlqvf/dXI38AEpvb0kPRcyn38gp2Yv
 o2c4qNnFcIrFlzuEXBA8mtb6KxzzIbXaOrvMRUqstDzZOzSX9ev03YISGH3rJkF19ZH/923dDe
 nyLdriRz0/zAVGBIQDQqHn/bN5jasSPsHf2prGO3wSll8SBX7r2CimF/SzM06Wesy81f7FhQrr
 8LvytHhO79aNpsGG5j02PjNgBjv27ATkwDw8bTau0QtMJi3UrN1MIg5HVsvH5FyzP0picCojQt
 S70=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="257578959"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 16:53:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLoX0lbiTI3zAJ6Oy5lu2uieNomks3kuJgdJA3A30zcm9vqkq8O668Znmv8xeol8LqubjsGWe/gwWGPTw3F8OC5ucGAc9M9gt3Qr0BdgA+iyShd9wQnICMu5vW0EvrRa+J8JV2ALDSkDsrqG5b05DQW+chE8fJwsfEj9gmZXCiJXsUT7L0TdR+lzMkVgSRR52l+P0G2JU53gjxdUjQ7+cTu4jbyiGUc8hlrT9jyZCmvc0klkKY1TLa8UD0+IYMzepPtQiel+jHF5JIAYhSR6cDjDw/c+r+w2yAUSu2LwVmTZyZOUW6ry8s8o3kvBLP75vAsyv3837vUP1d8cp0Sc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG1/MGH/ajpxBSqlR1PqhTYeXyneQ6DzSInmCPk4MuY=;
 b=UPf4dkqzsZbmgHNISV73V1DIHzrRIdGxT7JeGwD0w+R4xxqL+4AsU6251Qh3Gjb3rthyrAsHaHkGjwxl3UOVaHuudqvuLzuazYvMwcPRK/M22u3FYqrcd2VAOplvN+4Ug2UkuIUVrFnTQ2owMQeTTEW6zjSYsGtrDelasKtlemehCac5UN4E9FeKYeQ9Yz7V16ITQomPNRmp+PLJWgfb7Q0aU5lmOieOHlWNiQjL1dEMeOeGxI/dyr1G8ipr1f+8DLz3n7CRKXZLBdEzbsh9b/jOSoSRp1qZTQ4R46mKMIKG97pTiZuXdJ4Y7z94bLq8JVZ5Ye6cMBKMzMdSx0uOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG1/MGH/ajpxBSqlR1PqhTYeXyneQ6DzSInmCPk4MuY=;
 b=SS7KS6t9y8sWdbyJoWfy9wULDB6t3QY61Rjfe3VdGJSQi6/YAJ03yyUk4VdOSpcfKlGVMMLKrzeXYbnSH4akXdhllFlVILQczfN8R0li3fQ4vxAKtl8nHkae64m2XdSeERWcINvYEfULZph+bK3HVQDg93+MN+ZH+z+H/R3cDZY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4239.namprd04.prod.outlook.com
 (2603:10b6:805:36::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Mon, 21 Sep
 2020 08:53:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 21 Sep 2020
 08:53:11 +0000
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
Date:   Mon, 21 Sep 2020 08:53:11 +0000
Message-ID: <SN4PR0401MB3598EE548546274CFDD618AA9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: a7405979-3128-42c2-9f9f-08d85e0bc502
x-ms-traffictypediagnostic: SN6PR04MB4239:
x-microsoft-antispam-prvs: <SN6PR04MB4239985737FADF7213A604DD9B3A0@SN6PR04MB4239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6h11ZipXxR0Fq8yKMiu4yvf1o4+1QmdF5at/51hZ/BWrs73ZIO+23iYEjLWdUYs0b8zf5MYrrF+ELC6LEoNn0KOve+ZDMfW6jAZ9pyMQYASPEjtI3YfT2bCSd5Ns0mSjDlqUEmvf3ejJrD6AnuEwVe0cTWAyuOl20kuaQt9f+pCrBYZMdD/D615PnJ8RpBzF3vkZCHc38UvJFEOC2RCyvGkKLdY4ht94fCpoLt4uXjyqJtpCHNgPEkritMFmP0GZypb/ej6CYgHgm+o1DjTk2PCzI/Z057TCVPYk7XvifgcZD2gEY3JP/aSdd6O0hhTLXr5a0VmNHIJ1TGfcWDwyfmhJ8CWMhWoBg12tg9UHrdgHG8nDaW6E/1L9Xqm7nVPthUur1ib2L90QQ2sdxQj9WWt1ic1Bb9scYvpkgOQy3G8tsGFnc6JwiYe1xyPVGVe9YVyF7BdTMuUtwtz4ofUEKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(2906002)(76116006)(91956017)(86362001)(66946007)(66476007)(66446008)(64756008)(5660300002)(52536014)(66556008)(71200400001)(110136005)(9686003)(53546011)(6506007)(7696005)(33656002)(186003)(26005)(316002)(55016002)(83380400001)(8676002)(83080400001)(8936002)(478600001)(966005)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UJR/nyhEyH1wUZ/KJ7bvbBB4PxXUjGw49b4ZtGyd6edswG4ziLhqgbPMYahfyVbTWs3QV1hnrybc3NRLA3Uq5qYmVenbdtj2fuyePxyj7hcasHms5UwVXbsdhYWyfhC3e7W9ZC+7vYfFHR4+w7gkzsG6dB/wkzcZPeGaFt4gRA4A7oI/PnFDwW6zlqWFojBw5a18SiaYB3avpElGcczX+1Cbr2zdM1Jg37oZzwRHWGHaClHTMHwiKRHWJlZZqBflCVWnkOK2MbfXkDWWo2oMi0dx1Fvfd8XuIhmxxKvla+1VyyU7mKXfUfqOawqftu5FsLmHks7+4/ZSLaBD27f0P7R5bPjILq33w5Xax2Wijp0FycB74T6qAfgPdKbOQ7+NVGFSYNm0xOGggsmR9lC1fwxdg2gLLfnVK6zQWOnzlRuSwMPC9BlHibhYCppbqZGM6pDnMJL19CH57CFhwsUCRt8uDNcHvjzQnFaoMwXbk71FbC9dWxSsvdyP20S5pU0fp6htU2d9z42cy72ABY0WHiZZ6+J8OZ5OZ6U9QSDid/treGkYYn3ckKNO47fRLnBsiykNHemLWAYrW8k8tKuzeBCBwS7moMazNqZWcSspZhR987QciBMUPZo3cax4a8ChmdNBbY48W+SzM3Mu3DLskA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7405979-3128-42c2-9f9f-08d85e0bc502
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 08:53:11.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JopDIt0jhtSs8MPpeto2pydF9slriu1W4NbffcGNvF/16ZVvOmfqTwb1caPN1Ui0x3sL6GpwL09QB6cugQU69pKAIQnURe+8pG1tBenJOBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4239
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
#syz test: btrfs: Fix missing close devices=0A=
