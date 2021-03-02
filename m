Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D345432B252
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbhCCB6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:14 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56517 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379933AbhCBK3L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Mar 2021 05:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614682032; x=1646218032;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=oP97R3KibnlnG+/nuk2X0Hz+DqD1WsEEdErTssm2LrA=;
  b=owk4clOId3ekMQlEF1YCCCsWpVCYMjDMDCaLrbkYzITLNY4Dz/xPCbUk
   1FeMIlO2dXKbA8tVkCuOtRcjV8cU51cQCXMqFo86thbLbQSP8jFpEVPP2
   MwGb66yeqdxXI82JOcyMftC8NeAQkQHLETTbyCi5BWl+mbtlguhMivAit
   P7PlHF75fVw0J0dwcE2npiSYZ2QD81RcBenaOdpMC0q7IkGKkAZj8N3lg
   E87V1NXKMUldzWagyWsX6QdUnq5WcSBdejz0fh3l9u56Oydm4564M+mAq
   f24FnZccdyvtbMGm87s5Sft4dSL2sBJ6IdfRRfIbP8twpgO/G5AAkj/db
   Q==;
IronPort-SDR: 7Y9ug100r99JITZyd5CIedviJJ/ERifdxLQNNhcl7a6s/1Lhw1XNThT7uSn4zu1S5hYWxocYZd
 R/lTABREMfJRycWGzY9pfUcu4HdpmZ238pfsL7Ige3d3UUShl/VlymPegfSZQi3cWoibKA42FK
 hYXjSkVMxNB6O20lQkd6ufuR0gnOb5l6r56elmjzyi2zb4STcdCob4s5I8osSQwYsau/qaLI8a
 sJJMJPR6jnDYL/hcAaJeiWme76GiEQT7rydxRHVpM8QxsFwdnsRGpTi0s/vx1Z4x9BiQNxkkcV
 vPA=
X-IronPort-AV: E=Sophos;i="5.81,216,1610380800"; 
   d="scan'208";a="265428581"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2021 18:44:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcmmEOL4ai50Ew9TNtCuNLSmQ/ook5zFKJ/voNOhy2fYPnbIT+eIgoBv2+d51iw00AGKdXIuacPbVxUq0kkO9JFRVvR5Pwpo08es0URWYZvwUp3aQtXEJc/4C4WS0cAqc4mp5lqfU1CwLEiiDnB5XdvYQh7rbhO065aMEgqEoyMO7dT3tUOWUZc9YyzB9tetX3kqmfkN+a7vGpPzL4c5HelOjr4s5YQe3u2q+Vjw9r5kj3Uqam6UYBlxuG5l9d8BcmwNxwIcF789GGpj+QBdIHwtZ/lj5vwl1yN/YBFR8qvl2A0t2r0IEG8P9Kn46+dnVCbLMuQlTxn8zWaSXu3cyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVjArujLuPX1+isnXStz5MVfezueis4DmcWtZtzyfWE=;
 b=ThFc8E1o5krLHWKKuYjQ2+ZZgTvQkQx/5lsM9/OjhiqI2aqmNK+0ynFj0zW0Xs3eDiBilgBEpJlLX1SMqgs56UtFbVLq5jhfizOfbEOPv76P1xMUoH06HQKWlfFGz8JuGf2PaNA1Qx53aAN4rdVxEQTPr9xsrjB/iCjFjEA6cIAU76DrSW0L0sE3r3ecioZG2vFVgoEIrArIi6wyxWd08FZPfivqiR7x3duG03mOwGBP+LjtOa/gwRSG7npVHMWtAQtkfwsD0RBWFCz9Ko6W1EoJbkpVzZAJ8ZBAfX1l+sN1MUDuVMOP5NigAdOSv/UQDXx++XXWEu+KU7bjtFofEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVjArujLuPX1+isnXStz5MVfezueis4DmcWtZtzyfWE=;
 b=M0v+X/IeRQubSpOXnELsdrSYG1MUAfnJn/zghMA/uwpDcjMqThlHX104PNCrbvQ2KyEDY3HDwlpdZRZy3Frwgv1WhFa44bPWpXfGvRAUCvgDO897c6+eMAFDu70DwBYPMhZtgnXwOFG5b/nvvHC0tgpexZldUJkOfZuw0ZiYoPU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7397.namprd04.prod.outlook.com (2603:10b6:510:1d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 10:27:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 10:27:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Thread-Topic: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Thread-Index: AQHXD06lWpni3H/DnUiny8ST2cCO2g==
Date:   Tue, 2 Mar 2021 10:27:28 +0000
Message-ID: <PH0PR04MB74169B4B92CC269611F54BF09B999@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:cf6:7682:fb45:6590]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ec908c4-9c32-454b-699e-08d8dd65c7f4
x-ms-traffictypediagnostic: PH0PR04MB7397:
x-microsoft-antispam-prvs: <PH0PR04MB73977B4F44DEAE360C0CF2C29B999@PH0PR04MB7397.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGoPVbf8EA2xLQZJlW8qAsiDmlIpB8GAN7smhHd1xxn9RioASOsNNhPdFXzgJUhc7xSjXXoh+WVnG1UQNm3lNTN8P9xhlq1wTu02/STmK715BBcNL0v1JHzhHZp9Qqcw6oIy06bMxGNYRqgfJ5UIuhQTsIKQpDupPhsA3Q7NvvUdXb26JB+6xxFhntXinyon8+KVynBMGWoLOgL5gSBFmlpavgfZcZ4hGulVXp5ujWXxsu0V4Dqfibw4B+YdeZssH72C7S41w2ks/S2k/ZLcme2qGique6TfMwTuR6biMa1nUPNdEBDvdxZa/RCdj2GnTAlfiHjbAFYUA59YbCpf2EfwH0e1hnMQIe79CVgCLBZ00G/zOlT504MXZDhBYhmeE7MrdazZ4SQhx37nRVyYd+Z8RqVXyDMuMF4v5TQZpWr88hnVZYJXitb4RL11uKyxEZW4hhqzItlaLQ8qamDMsV/tJiRK3eF5bfsW9U1RGQsURJ1hE6N2e+e+PPsW5PPNr5m3YMBS6BhiU19UZtKoTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(66946007)(9686003)(5660300002)(64756008)(33656002)(316002)(52536014)(6916009)(2906002)(86362001)(83380400001)(91956017)(478600001)(186003)(71200400001)(66476007)(7696005)(8676002)(8936002)(6506007)(66556008)(76116006)(66446008)(7116003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mltaRpGW9bGwq9upE6hyrdpZn0QcunFWFAscVVjTCrArpgg07jY82hYFrx4/?=
 =?us-ascii?Q?o5p0k65ihXDP4osnv3SUdEzHx9MdMbljGZUNn0eQInb98tZhE9q16roAogOq?=
 =?us-ascii?Q?LHgNolWAkOvT64r5ryJtkutJO/Min7/OyNjXGJKf65aS9nH8Ic8W5hd7si0J?=
 =?us-ascii?Q?ZFwU61QO5Gm7r2UIZOEgexMbSUvwGcX9jBaHlxJC1sRKakW7Za629d/h0RUK?=
 =?us-ascii?Q?wWyCcfiDwqNQVOZwDb2JlK6TBfosa9BoMWu1Gcm8hyAdsBtoEZULUYqxu7tT?=
 =?us-ascii?Q?PSDQmMXM1S5mt03sigtYhignnp0EHJ9tque90iJ/SyPXyCfFdguQvGvkc20i?=
 =?us-ascii?Q?UuCpmBnsHEAaouY79wyKzaXdjKng2HojFirP+sZKl1rwTj5e/3B9i2xg04CN?=
 =?us-ascii?Q?6ypVvVxNfTteurHeuA7RaMrFEBnsL9PNty7wvtnCB7Uhf4aEjFxaGo0kzfhV?=
 =?us-ascii?Q?dhe99TY6QqVjOPd8V2g34NHMh436mhHNCKXF3TcFO3jXYmz/Cix5Z7QfKYjK?=
 =?us-ascii?Q?wgOiDZB6c2tmhFKoyaZW+WqIFCV3vMzyPtpUUhDjvd9KbKiy+bTav8mNBg5G?=
 =?us-ascii?Q?5GZMxbD5lAQb6DyPnDqhT4A48v1z3TCDlGg5lmIY8f6XPDH+NBmHyAanh5MQ?=
 =?us-ascii?Q?DUTXBJXoqERjkvuoTv4CNgvBvINOPoem5YpgWeMkksASzBzxlX/v/VXmoSH7?=
 =?us-ascii?Q?HFL/gPmVqILYeUPF3vyWRZQQa0AD7c/2G/UfSbDsX9SBALduOHIJ4eY2MwzZ?=
 =?us-ascii?Q?QXswwTMc63/4+fy1Y7tSKipSe3Ji29y1eBvIelZREd+ACxUyRMYHhZOxu+N2?=
 =?us-ascii?Q?2E3uoMfCcTQkoGx7hz6OYZgakl56eq9+uXIShfk0rEYvYgbZF78pdYVn3RwE?=
 =?us-ascii?Q?i9dImvhUBF45RzYGOYk68X6RgV/NhUnca98HQS7XyWcR7pO6iCyWh/WsYGeG?=
 =?us-ascii?Q?/iWR56qYnyiQaFlhMZXxu9ngqxkWDEDMEqAKUYdmQLUGrwVcdsgvxOf0KbeF?=
 =?us-ascii?Q?LPfUTnabDtHg3OdHnTySoZfoWJbH2/Y4mW2sfrDqX5zs0tQWiZ/2Ai9YxUDL?=
 =?us-ascii?Q?9f1rWk284QVa2+DWhfKHa7JuL+oK8inLB+UDLcX9szTc9r9nSDKU5oCEMX+E?=
 =?us-ascii?Q?VWBB43nfTDvH7G5tVtHxrwIb4pNanePt1msxcFS+u9rtaR2NP+PdiSlCfmfp?=
 =?us-ascii?Q?YKV1qMEJXj4C7jn3f+1j1B337YLRw1j4fbqz2Y+plt3eZExyHDLtWiFsAWeP?=
 =?us-ascii?Q?Eezb45CnoGKkRgjQszPkheCFGKjXBnqTVM9WOZUAPcvRZ9kxGWieqEhQW3qR?=
 =?us-ascii?Q?L6PUU9R2y4dj6d0okTpV0jg9t0xV6m5qZzAWEH/kRu3WUk5BxeXbr83wLBnU?=
 =?us-ascii?Q?+bhddaRA9axCWcmL3/+SkOVihZl9Fuj670OpuGy2hLCVOwxTjQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec908c4-9c32-454b-699e-08d8dd65c7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 10:27:28.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyiRhvAY8uTk3Q3C5fVfwjQD8KW1dfli0jEfJDAv9YBmUn0obklHb3S8//pP1EuYXYITpPZLqYXtwjRskISM8nYgKbYC/WjXs7BGiIUwnyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7397
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've just tripped over this lockdep splat on v5.12-rc1 (Linus' tree not mis=
c-next),=0A=
while investigating a different bug report.=0A=
=0A=
=0A=
[ 1250.721882] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!=0A=
[ 1250.722641] turning off the locking correctness validator.=0A=
[ 1250.723486] CPU: 0 PID: 468 Comm: fsstress Not tainted 5.12.0-rc1 #950=
=0A=
[ 1250.724483] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014=0A=
[ 1250.726180] Call Trace:=0A=
[ 1250.726551]  dump_stack+0x6d/0x89=0A=
[ 1250.727052]  __lock_acquire.cold+0x2dd/0x2e2=0A=
[ 1250.727676]  lock_acquire+0xab/0x350=0A=
[ 1250.728204]  ? btrfs_add_delayed_tree_ref+0x1ae/0x4a0 [btrfs]=0A=
[ 1250.729215]  ? debug_mutex_init+0x33/0x40=0A=
[ 1250.729822]  _raw_spin_lock+0x2c/0x40=0A=
[ 1250.730340]  ? btrfs_add_delayed_tree_ref+0x1ae/0x4a0 [btrfs]=0A=
[ 1250.731208]  btrfs_add_delayed_tree_ref+0x1ae/0x4a0 [btrfs]=0A=
[ 1250.732047]  ? kmem_cache_alloc+0x17a/0x300=0A=
[ 1250.732635]  btrfs_alloc_tree_block+0x292/0x320 [btrfs]=0A=
[ 1250.733417]  alloc_tree_block_no_bg_flush+0x4f/0x60 [btrfs]=0A=
[ 1250.734253]  __btrfs_cow_block+0x13b/0x5e0 [btrfs]=0A=
[ 1250.734964]  btrfs_cow_block+0x117/0x240 [btrfs]=0A=
[ 1250.735662]  btrfs_search_slot+0x688/0xc60 [btrfs]=0A=
[ 1250.736378]  ? mark_held_locks+0x49/0x70=0A=
[ 1250.736927]  btrfs_insert_empty_items+0x58/0xa0 [btrfs]=0A=
[ 1250.737706]  btrfs_insert_file_extent+0x8d/0x1c0 [btrfs]=0A=
[ 1250.738494]  btrfs_cont_expand+0x359/0x4c0 [btrfs]=0A=
[ 1250.739226]  btrfs_setattr+0x380/0x660 [btrfs]=0A=
[ 1250.739900]  ? ktime_get_coarse_real_ts64+0xcb/0xe0=0A=
[ 1250.740578]  ? current_time+0x1b/0xd0=0A=
[ 1250.741088]  notify_change+0x27b/0x490=0A=
[ 1250.741613]  ? do_truncate+0x6d/0xb0=0A=
[ 1250.742122]  do_truncate+0x6d/0xb0=0A=
[ 1250.742604]  vfs_truncate+0x108/0x140=0A=
[ 1250.743122]  do_sys_truncate.part.0+0x6a/0x80=0A=
[ 1250.743738]  do_syscall_64+0x33/0x40=0A=
[ 1250.744250]  entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
[ 1250.744946] RIP: 0033:0x7f38d7819b8b=0A=
[ 1250.745453] Code: 48 8b 4c 24 28 64 48 2b 0c 25 28 00 00 00 75 05 48 83 =
c4 38 c3 e8 c5 69 01 00 0f 1f 44 00 00 f3 0f 1e fa b8 4c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 b1 92 0c 00 f7 d8=0A=
[ 1250.748044] RSP: 002b:00007ffdf2983ed8 EFLAGS: 00000202 ORIG_RAX: 000000=
000000004c=0A=
[ 1250.749096] RAX: ffffffffffffffda RBX: 00007ffdf2984030 RCX: 00007f38d78=
19b8b=0A=
[ 1250.750081] RDX: 00000000001b92a2 RSI: 00000000001b92a2 RDI: 0000000000b=
db380=0A=
[ 1250.751061] RBP: 00000000001b92a2 R08: 0000000000000029 R09: 00007ffdf29=
8402c=0A=
[ 1250.752052] R10: 0000000000000002 R11: 0000000000000202 R12: 00000000000=
00010=0A=
[ 1250.753040] R13: 00000000001b92a2 R14: 0000000000000000 R15: 00000000000=
00001=0A=
[ 1260.719289] BTRFS info (device md0): scrub: started on devid 1=0A=
[ 1262.030768] BTRFS info (device md0): scrub: finished on devid 1 with sta=
tus: 0=0A=
=0A=
To trigger the bug I did several (4-5 I think) runs of this script:=0A=
=0A=
rapido1:/home/johannes/src/xfstests-dev# cat test.sh =0A=
#!/bin/sh=0A=
=0A=
SCRATCH_DIR=3D/mnt/scratch=0A=
=0A=
echo "running fsstress"=0A=
./ltp/fsstress -w -f unlink=3D1 -f rmdir=3D1 -f symlink=3D1 -f sync=3D1 -f =
link=3D1 \=0A=
        -f rename=3D1 -f fdatasync=3D1 -f removefattr=3D1 -f fsync=3D1 -f s=
etfattr=3D1 \=0A=
        -f setxattr=3D1 -f unresvsp=3D1 -f mkdir=3D1 -f mknod=3D1 -f chown=
=3D1 -f fiemap=3D1 \=0A=
        -f freesp=3D1 -f snapshot=3D1 -f rnoreplace=3D1 -f rexchange=3D1 -f=
 rwhiteout=3D1 \=0A=
        -f allocsp=3D1 -f subvol_create=3D1 -f subvol_delete=3D1 -f awrite=
=3D1 \=0A=
        -f writev=3D1 -f write=3D1 -f splice=3D1 -f mread=3D1 -f deduperang=
e=3D1 \=0A=
        -f mwrite=3D1 -f dwrite=3D1 -f clonerange=3D1 -f copyrange=3D1 -f t=
runcate=3D1 \=0A=
        -f fallocate=3D1 -f punch=3D1 -f zero=3D1 -f collapse=3D1 -f insert=
=3D1 -p 30 \=0A=
        -n 1000 -S t -d $SCRATCH_DIR=0A=
=0A=
echo "scrubbing"=0A=
btrfs scrub start -Bd $SCRATCH_DIR || exit 1=0A=
=0A=
echo "cleaning up"=0A=
rm -rf $SCRATCH_DIR/*=0A=
=0A=
=0A=
$SCRATCH_DIR is mounted on top of a md-raid1 array: =0A=
=0A=
rapido1:/home/johannes/src/xfstests-dev# mdadm --detail /dev/md0=0A=
/dev/md0:=0A=
           Version : 1.2=0A=
     Creation Time : Tue Mar  2 09:38:17 2021=0A=
        Raid Level : raid1=0A=
        Array Size : 3142656 (3.00 GiB 3.22 GB)=0A=
     Used Dev Size : 3142656 (3.00 GiB 3.22 GB)=0A=
      Raid Devices : 4=0A=
     Total Devices : 4=0A=
       Persistence : Superblock is persistent=0A=
=0A=
       Update Time : Tue Mar  2 09:58:57 2021=0A=
             State : clean =0A=
    Active Devices : 4=0A=
   Working Devices : 4=0A=
    Failed Devices : 0=0A=
     Spare Devices : 0=0A=
=0A=
Consistency Policy : resync=0A=
=0A=
              Name : rapido1:0  (local to host rapido1)=0A=
              UUID : 10a4866b:6da1ccdc:e069e6da:79196fb1=0A=
            Events : 19=0A=
=0A=
    Number   Major   Minor   RaidDevice State=0A=
       0     251        1        0      active sync   /dev/zram1=0A=
       1     251        4        1      active sync   /dev/zram4=0A=
       2     251        2        2      active sync   /dev/zram2=0A=
       3     251        3        3      active sync   /dev/zram3=0A=
=0A=
=0A=
=0A=
johannes@redsun60:linux(master)$ ./scripts/faddr2line fs/btrfs/btrfs.ko btr=
fs_add_delayed_tree_ref+0x1ae=0A=
btrfs_add_delayed_tree_ref+0x1ae/0x4a0:=0A=
btrfs_add_delayed_tree_ref at /home/johannes/src/linux/fs/btrfs/delayed-ref=
.c:999=0A=
johannes@redsun60:linux(master)$ cat -n fs/btrfs/delayed-ref.c | grep -C 10=
 999=0A=
   989                                is_system);=0A=
   990          head_ref->extent_op =3D extent_op;=0A=
   991=0A=
   992          delayed_refs =3D &trans->transaction->delayed_refs;=0A=
   993          spin_lock(&delayed_refs->lock);=0A=
   994=0A=
   995          /*=0A=
   996           * insert both the head node and the new ref without droppi=
ng=0A=
   997           * the spin lock=0A=
   998           */=0A=
   999          head_ref =3D add_delayed_ref_head(trans, head_ref, record,=
=0A=
  1000                                          action, &qrecord_inserted);=
=0A=
  1001=0A=
  1002          ret =3D insert_delayed_ref(trans, delayed_refs, head_ref, &=
ref->node);=0A=
  1003          spin_unlock(&delayed_refs->lock);=0A=
  1004=0A=
  1005          /*=0A=
  1006           * Need to update the delayed_refs_rsv with any changes we =
may have=0A=
  1007           * made.=0A=
  1008           */=0A=
  1009          btrfs_update_delayed_refs_rsv(trans);=0A=
=0A=
Has anyone seen this before?=0A=
