Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A4271D75
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgIUIJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 04:09:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64612 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIUIJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 04:09:21 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 04:09:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600675760; x=1632211760;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4HbQa0GGDi1u4FfMS6wVQLrbnIG6hroOzN9gbIuxBmY=;
  b=jAYSL0ppWNySP+HLC+zN/5kFUx9ZOBShAhCM1Lmu1xaIgRLb3KlWu3S3
   Nba2Ml3CCsUFmEBH6mU7uPT3O/EaxxJTfG2Zx3EK3j5KO9KFvtd6fcX8f
   8mrZJ8kuJXQwnjGe3SyNVQ/c74UqTn8B5BUs+3inHNjGVFjQ4bMuv9Oeu
   jFTeqiw/deiKjRoIhP2J3wJHrC/to9w6ZoX0h7oJmBlaa6t6xZ3IpUBF6
   +SlnyN6KlqPULSG+2hbJ9R3aIR6nl9yc6T4t2wt+6gz5H4Vgcvwv/5sOb
   9fjntjtKMP3yyfPp63fQTlWy8KvDFcyNr2sq6CBa0OJc7H3Z/F+OqfkGq
   w==;
IronPort-SDR: 3egTVdcqdSURDeyrBGFB6PsTErPaxmklzN6C/x0rNymN/SMe/VjFgaj0ufZSPfkI7b32yW8WQX
 E9EZEInGQQzJFzqX8qUblsob8UrcNV9OADtIjpkFBPbdXdz+cuIEkHJN2uZiE9c0MutnlMEAQA
 T6xtB+zeXXWIwF5ydU7Lpv7JLGiKx0ys/fPHXGuFjTdhXaUIyT3iDiEDdonZnS0Lv8XfNrEC3j
 F46EPBuK0dd/4XehORGuNMw6Xrv4lEh61HSr2T3C74A+L77meP+ACDsnJQTlDDI0MTh4qjytLf
 6MU=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147793877"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 16:02:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0uysWLlflK9p9dGSRBfn+zwRgPG78BFfA5AgBUpRpDHq0bErX5Fs3r0ydwNkVewZ+Uyo7me+AdS7sqoU5L6KB+QevHYvseKp5r3JAZ6BNT8CF6GVunpkQohwa+kn7iw2gdx9sIELE9xXIdEh5UBH7Ff09QYyPGun/kvehOc78ZZ/p/nhTGZp2v5HMh40uMlrfoYhoAemQ0Q+/wjVCeJMjnJPaCxxTJ5VS85JPz64iaN8L69t+NmRmsA1ETS8u6oAsQCX+lEU7ChREdrYABKcLDC1KlDPp4WlLv1w1gZqA0bjheJEQe5fEe7IOBguD52QpxRj3hIA5Zlp61OULQ0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHo3TOMUaK5J2hbdJPQhbAfDuHD4puUCvS7e8Vmui+k=;
 b=mnbr1jCK5uQq5knsMnD1QEpRd3zWpZs5NK6dWl+7VbwolgkegeVh2Tg8WUF2QgG19AzDoLSP6rhjfqZvQBZk+MGl0IOZ9ttuLsBV4RS37IpZIsoM1Uqgm7yOx8r/qgAYhtqU1vD/4WADMDhLS/HezmLc/YEbLL0K4yHFJL+P6R7gij00hkMpTa6qK/gan0re+Kn7Gl4ryaVUgw8tHu8OEwAtCyKvUhcils10miDrH+Q2R/Y2vZzZh03U2stM0cKV+5MqGwYEdz46btS/Lda9NLNctT1jrQYNm4Z7kHX5ZlC6W4GbHs0ouc1Jx7tqH02DOp9WRExPO+bb8OGpikhl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHo3TOMUaK5J2hbdJPQhbAfDuHD4puUCvS7e8Vmui+k=;
 b=pYQyJ7r5jBCaByomXnxCVqtCIGILJF0xtuCKUAaJqMuHRhT6mike2zXMBGVMXSWvse+o0h9chOxNIFPur0gSn6xaU5UwZpwT7roQ8gaFFX3t3JzryDuTmwmCYDHU8zckU3rj8vEQeJa7iVfVd9RqpGN9pmye+Iia0FWTFubUjx0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 08:02:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 21 Sep 2020
 08:02:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in close_fs_devices (2)
Thread-Topic: WARNING in close_fs_devices (2)
Thread-Index: AQHWja39agc8tRwN2EiffefaHahz4g==
Date:   Mon, 21 Sep 2020 08:02:10 +0000
Message-ID: <SN4PR0401MB359850A4D04212234BF9C57F9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <0000000000005a890b05afc67285@google.com>
 <c46c0d04-0ab7-dc81-978a-357c117eadbc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8b18412-d78d-43be-b2f3-08d85e04a4b7
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB40459455FFB14764A8B066719B3A0@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8euCI4EzbLehANnK8tKmNc6run4l6cDuSCd+44BhrtJxHJFOzRJtQxnPmbsgWUKXYJuMxHi20pvdk3asqIQWP6unB91tyfu3+MCM6wmSqGh1RJUNJfDDMUILKOSaFcBQd2U7GoT85RwqDFEGt2WpvNyjPpG/aZKE+pnyKDs8nAUSMh88ly93W6ensQc8sEVK26FMi0/7GxQg6Es/DrNf+AoLGaAL12bsJg4jHuy1ugxkIc+YJFIaQ7Pmni1nuNtNBao/uTAAG/5zPlWbJTjo47P/CQcrkYd010pYICtE37aGhttXOAU/JNMgInjhjfZb8ah+IE/hbvAIjVIKd5gwCdV222SEQkLhr+TdonfTuZlL8AUjK0DN+LdHzJjO2zG2BJSrq8scdTrOIQYRFwq+j7vv4XeGmGEE+YqffYcVqUYJrrfg+gUEPawQz+cdZOyOreB274W15P8/XzMqOXCVfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(33656002)(52536014)(8936002)(6506007)(7696005)(5660300002)(2906002)(53546011)(83080400001)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(91956017)(76116006)(7116003)(966005)(9686003)(71200400001)(316002)(26005)(110136005)(83380400001)(55016002)(86362001)(45080400002)(186003)(478600001)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5zo3DTOOs05AOGyI2or3cE0iCVvouluE7AG1nxVIjopWEzD/T8p4iMRJ39bMKLED+HyUF4LukLcIDCc9foH2b8GxxUWc2lxnmWgGuDksaeWpBQ5q4lvsjqzmVZiqEryrtuekDDJyWm5wEXkCMi5wMVUBrGj4o9pRrBWwfkb/2rICHRrmq/IoZSaTJkaqEEvEARs/gPkJbjj9J45LAUHXWXd7W72zwxPw2CdWoLm09NyzWAaDycntNJQEFV5tScMxLqNz2bGTr1cxPGwvOcI/UfFgqsIc2GdKd/L+00izdoVdzsmpYae97/L7/WisgwKHet7SO816yoNaxHUvp7e+4OnxuYvbd4FfvZsY3IxEyBjBBs6xurzkTcg6AKzEwFtScJQ4cgRBfdBsx+9Xe52o/NyPFZ+KXgK7rFU+Y5bfY6/zDhvPVzl09RjAltujivn+MsNpD3AOKpBmixWzuqHO/Eo2rzlknnuR0HIJJRmxnNfTmO92uLceO8gdD5btCiv/vcAXFHG2gMg/px02bGy9a8uH39jxyS5oy8XXn5p6eYexROqhwvQLr2NYpaSqdvZT8J90cckqDx4yXOR4hekqB7O4pDCzzpzcfSnu7SKKCwaTFFBuQW/0G+zufxG5hYDCcmsYtGiG2FBqCCRBinpB9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b18412-d78d-43be-b2f3-08d85e04a4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 08:02:10.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypPKBHuLXckykosJRKNRewmGLhku/SZOGcu3QlDRaBuHaeGXYiVb+F5wQQfJz9H3GKfFa2Y9Ft5j+912h9PQuWgp9KO3i9IrstLTb0koc5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2020 09:58, Anand Jain wrote:=0A=
> On 21/9/20 6:42 am, syzbot wrote:=0A=
>> syzbot has found a reproducer for the following issue on:=0A=
>>=0A=
>> HEAD commit:    b652d2a5 Add linux-next specific files for 20200918=0A=
>> git tree:       linux-next=0A=
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17e84b079000=
00=0A=
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3cf078293343=
2b43=0A=
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4cfe71a4da060b=
e47502=0A=
>> compiler:       gcc (GCC) 10.1.0-syz 20200507=0A=
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D112425d990=
0000=0A=
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1486929b9000=
00=0A=
>>=0A=
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:=0A=
>> Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com=0A=
>>=0A=
>> ------------[ cut here ]------------=0A=
>> WARNING: CPU: 0 PID: 6972 at fs/btrfs/volumes.c:1172 close_fs_devices+0x=
715/0x930 fs/btrfs/volumes.c:1172=0A=
>> Modules linked in:=0A=
>> CPU: 1 PID: 6972 Comm: syz-executor044 Not tainted 5.9.0-rc5-next-202009=
18-syzkaller #0=0A=
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 01/01/2011=0A=
>> RIP: 0010:close_fs_devices+0x715/0x930 fs/btrfs/volumes.c:1172=0A=
>> Code: e8 00 b8 4c fe 85 db 0f 85 65 f9 ff ff e8 93 bb 4c fe 0f 0b e9 59 =
f9 ff ff e8 87 bb 4c fe 0f 0b e9 c0 fe ff ff e8 7b bb 4c fe <0f> 0b e9 f9 f=
e ff ff 48 c7 c7 fc a1 8f 8b e8 e8 0b 8e fe e9 19 f9=0A=
>> RSP: 0018:ffffc900061b7758 EFLAGS: 00010293=0A=
>> RAX: 0000000000000000 RBX: ffffffffffffffff RCX: ffffffff83285c2c=0A=
>> RDX: ffff8880a6bbe4c0 RSI: ffffffff83285d35 RDI: 0000000000000007=0A=
>> RBP: dffffc0000000000 R08: 0000000000000000 R09: ffff8880a2be1133=0A=
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a2be1130=0A=
>> R13: ffff8880a2be11ec R14: ffff888093ab0508 R15: ffff8880a2be1050=0A=
>> FS:  000000000208a880(0000) GS:ffff8880ae500000(0000) knlGS:000000000000=
0000=0A=
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
>> CR2: 00000000004babec CR3: 00000000a7bc7000 CR4: 00000000001506e0=0A=
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=0A=
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=0A=
>> Call Trace:=0A=
>>   btrfs_close_devices+0x8e/0x4b0 fs/btrfs/volumes.c:1184=0A=
>>   open_ctree+0x492a/0x49cf fs/btrfs/disk-io.c:3381=0A=
>>   btrfs_fill_super fs/btrfs/super.c:1316 [inline]=0A=
>>   btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672=0A=
>>   legacy_get_tree+0x105/0x220 fs/fs_context.c:592=0A=
>>   vfs_get_tree+0x89/0x2f0 fs/super.c:1547=0A=
>>   fc_mount fs/namespace.c:983 [inline]=0A=
>>   vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1013=0A=
>>   vfs_kern_mount+0x3c/0x60 fs/namespace.c:1000=0A=
>>   btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732=0A=
>>   legacy_get_tree+0x105/0x220 fs/fs_context.c:592=0A=
>>   vfs_get_tree+0x89/0x2f0 fs/super.c:1547=0A=
>>   do_new_mount fs/namespace.c:2896 [inline]=0A=
>>   path_mount+0x12ae/0x1e70 fs/namespace.c:3216=0A=
>>   do_mount fs/namespace.c:3229 [inline]=0A=
>>   __do_sys_mount fs/namespace.c:3437 [inline]=0A=
>>   __se_sys_mount fs/namespace.c:3414 [inline]=0A=
>>   __x64_sys_mount+0x27f/0x300 fs/namespace.c:3414=0A=
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46=0A=
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>> RIP: 0033:0x44851a=0A=
>> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e =
0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 f=
f ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00=0A=
>> RSP: 002b:00007ffcb26bce08 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5=
=0A=
>> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000044851a=0A=
>> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcb26bce50=0A=
>> RBP: 00007ffcb26bce90 R08: 00007ffcb26bce90 R09: 0000000020000000=0A=
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003=0A=
>> R13: 00007ffcb26bce50 R14: 0000000000000003 R15: 0000000000000001=0A=
>>=0A=
> =0A=
> =0A=
> I am able to reproduce. And its quite strange at the moment. A devid 0 =
=0A=
> is being scanned. Looks like crafted image.=0A=
> =0A=
> [19592.946397] BTRFS: device fsid f90cac8b-044b-4fa8-8bee-4b8d3da88dc2 =
=0A=
> devid 0 transid 0 /dev/loop0 scanned by t (70902)=0A=
=0A=
Yeah if you look at the C reproducer it crafts an image in memory and =0A=
then loop mounts it.=0A=
=0A=
=0A=
