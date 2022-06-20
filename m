Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2329F550E8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 04:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiFTCWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 22:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFTCWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 22:22:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8192AD
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 19:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655691725; x=1687227725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HY3qn7aNm33vFs62kbe/I9l4JQ5bm4rCPif+Lfbs0jA=;
  b=EVuSGX8MQcgz83yXH4QGcjCwprYKl2SLV0K59XWCtZjUMNJ0tpjEivrA
   /oVLnXdSLE5mdAkDfo/xVHCorZWyZzXuFYV/ktBz8NFQZ+3irbcYicYA1
   V7c9R+FZta2TXhiTh0FkhWIm7fwufdm2klcopltf5wlWddroHBjhgtHK6
   MZnU7crpgL9im6FCTwp87uizEpK3czu5uI8bxgiywEqFVsNK0+AUkoE9L
   QBqzKUMW4l1LKz2AC6wUpXNsLErgl9ijPh49DdDxugWI56ajIOHZWp2hI
   l4w7a4ZusbCpi9mTWRZjR1zjU9+ci1qAW7yyZE1f5FURKYOlCS81TPiyM
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307898461"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 10:22:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGlWbUj8epWUIVAf6EHTKMxMuQn4j7s9jG4dm6kFUPOwKdXIxN0kpCaX8xJKeTRb2tJAQzT8etEYegR1AAOPYugbZo1wDyRlTdlZfmsvkDueAfKx1C7dvrkRE8XHNq9gwoKSNODdHe3a6BYHoddKU0JUMhV8f8RWTfKvaWvoBNCmlVaM/3vhaCZV2jibanNVG0e91HGnaJA2e2wJCIILbQQtQ/RGlIo4SfE/RzCSmPUileowYwcgu4UuhZzdE3sQeMGkN6YEsUVvDxaORyp+ZClk7rHHqnCQffsV6affVJFhturUF5PaVmNmEmLlj2cvHVBo8m12ThDwsGC+tSLXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVpNfsjW1CfnQhECeqatu+Zi0n477Mxy8l2P+PzdnHk=;
 b=EjWneAmW5teIZ/ojbRpNRunzR4SU79CsxTN/pPyzdukpIt+sjgNNEVAo88C8ifZ+QmmTE+bAIQ0HsaWiWGcNki0ZUc0WI8Sb3WpQ30ARsxoVr8Vhmqd9v/IMBFk1PpMocmOf/iFLHoPbdvN3YIdnWedY3xlPCwK6YeObw7ikEFyYGBlMyCTu41PxcfonF3n0P6VEmPl6mZC8j46+5BC3OzpITtUpfkMgq49uViMSGoav4wuxIY9uUQVMeoCnUWY/dtkMTTo4xkRSSlVcWex1SJQSXVeeYg42AlrGu2w+MdJZ+MQB5reAjsZFsciG3bNdH+cOmaoDVy19wtcgvnQAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVpNfsjW1CfnQhECeqatu+Zi0n477Mxy8l2P+PzdnHk=;
 b=xhRNdMYU+21CQtU20dswnFKLrpaNhDOCpLOFQirH2rkoPJvqT0dvM8x80ZgiFhVuhP2/ml3jvOBEqPHkmYjMSKs8WuclTUqov6r0TPkCGBHuFPd9Zb6olU4F8D1pzMsJOLHxWTz5PSVQrl3xvXFISOmfkeA7fOXDh541vOQc4fo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MWHPR04MB0576.namprd04.prod.outlook.com (2603:10b6:300:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Mon, 20 Jun
 2022 02:22:02 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 02:22:02 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Topic: [PATCH 1/4] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Index: AQHYgZgu76EMdSkum0uDXbATumnUSa1TYiCAgAQzu4A=
Date:   Mon, 20 Jun 2022 02:22:02 +0000
Message-ID: <20220620022201.ebrjov3xiar3abew@naota-xeon>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
 <318b80987f74e1cf6bf4ab09aed2399538fc4f9e.1655391633.git.naohiro.aota@wdc.com>
 <20220617101149.GA4041436@falcondesktop>
In-Reply-To: <20220617101149.GA4041436@falcondesktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2834e30f-3248-4c39-4189-08da5263a952
x-ms-traffictypediagnostic: MWHPR04MB0576:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0576CC646A00557C8B47B8648CB09@MWHPR04MB0576.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYl5/zfWvgcoR7JyPLh/wVdsP7dCnIAC5i76HHlxauElJ7ts6WDElXYPc9sEx/WGNzrZLO5Oq2gaxOdSHSBfY0Ro7yQRCNLcEfbQR4/2jX5bXsfj6BQwOMnwLGUU33Tf3I2YKQ/f3Rf4QWb9Zc2h2Pon8JBFl45HUA16W8LE7kg3/8wtaqZLOIYxVksqJ8aJQgvgzp6aCdPUQrBDutFHY1W9J7CUMsSZRk0ydivcC7pBy0sC5j3EB9+0lHWOqlBi7nniXDwouHoECsqpj57ITQHKZFbI0Dx/TPpOAJkwy8AGLvnpGhHsgegYo/S2TW1ORG8w0bxWKghsiZHEfqImcrv5pD6Xs22ZYZkzDuLxYSeakSXAyz2FZr+eApE3sPLM2Vrap650LVoWHsdC2xxow08704bsttwJ0E5mTWY0DZmRZ19OiiY/v3s7lPYVd7TjS6nfN4sdyG372o3X2IoWqAX/lXvrru0/0j7IAeWXXOWutlw/H0SAJCQvOu/Xz5UoXZ0mQgjuljAnK5yfh50bX5KiIgfKNkIFEoLR2Z8CsSgHISGzVslIivSKldkMAM78Xz5S/B6Jak4y9vDJpcsuAr67TmFRjqTzeMLHQ8qWTEVEdD/mzuL1lvyF1u/Rz7kb1gwAxROKHovYh98Qh1yXlX7luj7A9fc0+64q2TKl9XQtTfkMqKlrjj28loHm6ar+kj/1SUnYn5dsE3wVJr+IpxM9jkyO0/w0Cvl9vKSKPaf+QArQvsgZj7PLpyVThzxZhXudhKCgiesne/VjNEGFJ8dktqN0OTO7fniWUEYRLFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(478600001)(186003)(8936002)(5660300002)(38100700002)(316002)(33716001)(122000001)(83380400001)(41300700001)(1076003)(86362001)(6506007)(71200400001)(4326008)(6486002)(6916009)(91956017)(76116006)(966005)(66946007)(66476007)(82960400001)(38070700005)(8676002)(26005)(6512007)(9686003)(66446008)(66556008)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rb/qsP+EaHmqF3vntVcIDYkTR0Yw69vNJIhFSpKTp8CWThNosW5PXT7Fwn3n?=
 =?us-ascii?Q?Pnd6eek16qrFkXoXjvRxVTSPyAnbQq9Moh9hHOSDctaRXAOx5AexgUk+Xv5Z?=
 =?us-ascii?Q?2YWIt90z6YqcqoNsVu+5OVlu8IaGxuyBoDSoYrrUe5QhwEnob89x0z9vgYmo?=
 =?us-ascii?Q?7Dp4ZpQk4ordFubfQeVk9eGQt6QKLZt4pwLH+jxHOFx/4MrQWFHpuc6eZtjK?=
 =?us-ascii?Q?r684dZgdIMw5SlBaegl4H7J+YXfbtTUrOV1lvQpQKrbHNrGREnfClh6QJ/X+?=
 =?us-ascii?Q?fAFMC7d3KQfi5znapMHu6xGcOTSVepiVaeoVK5hPJqf79fb+8GZToucY3Jgo?=
 =?us-ascii?Q?Gdedg+vHcEheSBScYgP95gkRNObtKUoanW30Mj0hBWOuhq0Z85kcjUS0pqwi?=
 =?us-ascii?Q?InkQYygsnSvxqXNGAK3kcJRylB5wzunxbAuAyGrStcAtTBrPhOeafemPDxXE?=
 =?us-ascii?Q?JGEAONSRt14Hn2SaJhYcoTWj23MRZx8oFrMybpiT2mtVxVKTe9ZBunj07gLA?=
 =?us-ascii?Q?D5k8qtjXf1nGOg1l/qHsvRKFBCBR1F/XpsHttRqnzaIOvpGgf5/kdYFG5Cfs?=
 =?us-ascii?Q?SQo5mD8SCLiNBvu8qAH1UIMauPXViC3YcshNJF6MRC5e6+Wa8AZN8cAwgM00?=
 =?us-ascii?Q?jJMTh7IVhx+XQhjLbpbCLPn6K48oYo1PtMpm/4+14X1Dk+2FxyMKGDhdXTwz?=
 =?us-ascii?Q?CVQHWsZQYlAreyzSfuvG2FoRmstnukFjdgvntVP3hxTu/xB0x/ZRvHmQ/G/9?=
 =?us-ascii?Q?8eDJt4S/t2bCWG2ef8U6I+qpwiZv0L10mRTWPGnFf/4MTeVZM47GAZ/Z+e61?=
 =?us-ascii?Q?WNrPxfRccLTA3u29O9PMUfSz/Xerv/dAZbi5ZTknJr2iMnnRVprGEL5YQCUD?=
 =?us-ascii?Q?JvnGdn9vWVpy67cA3cZFmPYm/eQI5JXMacNcY704RxbQtT73YAM8C8uS+A9c?=
 =?us-ascii?Q?WD8QxgOW1TMCr0iKI1dGu5F9UsohS50adX9Q9/PqIBHY+qE5UDDVY9+ROofc?=
 =?us-ascii?Q?cA5+UvLyGErn05Yf4FGhodZNxt4NRU79uioRpgku20WzJQ1ptDdvgLYWIWci?=
 =?us-ascii?Q?bkoQItR2AWtUVIp+NLUOdrRcYuUvFYXLEOqxh4FbAPXDR4Wy6sMY3LEhX1Fy?=
 =?us-ascii?Q?2sx60+hYzFkTEuxiQ8oiOdd33WBiwRfQKUyPQJl/+CVTx2DjAR4BN+zjJBe7?=
 =?us-ascii?Q?xQorUVoxnom1YolTFhSl09Hb8zBk6X8naXrNTkv9fgIn2gNqjCHNRk+EQLZ+?=
 =?us-ascii?Q?6OhKMo282Q8PFHDzZKif/PvduyjtZCkf5flvSEgupZaHpMGQ09A0Hof4++F9?=
 =?us-ascii?Q?AF6sQNkNVlpcl7hmBIb0m77+tUphFdbdiKL3lAJ5mq9bprvVSf5K2wE2vm+X?=
 =?us-ascii?Q?f2mdTQ+vvBbd9j8HgtvfouWD+4Hj3fSsm2CjW0xGujhn/by8E6iKiud94KfS?=
 =?us-ascii?Q?FbJv868mtpXwsUcP8OEI68szPcyjiqIFbN7bAOgL2I7I1JMEz89t/4R0/zqS?=
 =?us-ascii?Q?3Sme3dMiDAv9RJYgWSW/EjGn/bUXF7opSuKfojPv1JUfcP1XK9/+3n0EkYTc?=
 =?us-ascii?Q?CljwxC25vaoduG4FVZI/Ql7ZG75QbR7IX/pxJ3HVPdF00NoPUK8iPx3PEWbT?=
 =?us-ascii?Q?BiNAj6jUlk4jYIoKkpts/WcalcvBFgqKuAXXY3zgwBhg5rZZ56yBF6cdk4Rm?=
 =?us-ascii?Q?P2Dc7KjQXht+w4GtWfLdSVIUF5lMXcccprGvtkw6QgFMfPHljyVx8DUp4qnR?=
 =?us-ascii?Q?oASuLIYYG6et4yPcg06ekRVEKc9mYEs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8AFB019D5DC6B4448630C3BC656E3998@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2834e30f-3248-4c39-4189-08da5263a952
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 02:22:02.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0GV6DPHJ3hTCQsumSmbYbyz6KtCl9SHdF5z4WEWFLQdFwu9XQ380TBYat2v16t57rTMpuPEVQU0cLwOU2Swog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0576
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 11:11:49AM +0100, Filipe Manana wrote:
> On Fri, Jun 17, 2022 at 12:45:39AM +0900, Naohiro Aota wrote:
> > There is a hung_task report on zoned btrfs like below.
> >=20
> > https://github.com/naota/linux/issues/59
> >=20
> > [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241=
 seconds.
> > [  726.329839]       Not tainted 5.16.0-rc1+ #1
> > [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> > [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid:=
 11082 flags:0x00000000
> > [  726.331608] Call Trace:
> > [  726.331611]  <TASK>
> > [  726.331614]  __schedule+0x2e5/0x9d0
> > [  726.331622]  schedule+0x58/0xd0
> > [  726.331626]  io_schedule+0x3f/0x70
> > [  726.331629]  __folio_lock+0x125/0x200
> > [  726.331634]  ? find_get_entries+0x1bc/0x240
> > [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> > [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> > [  726.331649]  truncate_inode_pages_final+0x44/0x50
> > [  726.331653]  btrfs_evict_inode+0x67/0x480
> > [  726.331658]  evict+0xd0/0x180
> > [  726.331661]  iput+0x13f/0x200
> > [  726.331664]  do_unlinkat+0x1c0/0x2b0
> > [  726.331668]  __x64_sys_unlink+0x23/0x30
> > [  726.331670]  do_syscall_64+0x3b/0xc0
> > [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  726.331677] RIP: 0033:0x7fb9490a171b
> > [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000057
> > [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb=
9490a171b
> > [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb=
94400d300
> > [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0000000=
000000000
> > [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb=
943ffb000
> > [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb=
943ffd260
> > [  726.331693]  </TASK>
> >=20
> > While we debug the issue, we found running fstests generic/551 on 5GB
> > non-zoned null_blk device in the emulated zoned mode also had a
> > similar hung issue.
> >=20
> > Also, we can reproduce the same symptom with an error injected
> > cow_file_range() setup.
> >=20
> > The hang occurs when cow_file_range() fails in the middle of
> > allocation. cow_file_range() called from do_allocation_zoned() can
> > split the give region ([start, end]) for allocation depending on
> > current block group usages. When btrfs can allocate bytes for one part
> > of the split regions but fails for the other region (e.g. because of
> > -ENOSPC), we return the error leaving the pages in the succeeded region=
s
> > locked. Technically, this occurs only when @unlock =3D=3D 0. Otherwise,=
 we
> > unlock the pages in an allocated region after creating an ordered
> > extent.
> >=20
> > Considering the callers of cow_file_range(unlock=3D0) won't write out
> > the pages, we can unlock the pages on error exit from
> > cow_file_range(). So, we can ensure all the pages except @locked_page
> > are unlocked on error case.
> >=20
> > In summary, cow_file_range now behaves like this:
> >=20
> > - page_started =3D=3D 1 (return value)
> >   - All the pages are unlocked. IO is started.
> > - unlock =3D=3D 1
> >   - All the pages except @locked_page are unlocked in any case
> > - unlock =3D=3D 0
> >   - On success, all the pages are locked for writing out them
> >   - On failure, all the pages except @locked_page are unlocked
> >=20
> > Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path=
 for zoned filesystems")
> > CC: stable@vger.kernel.org # 5.12+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 64 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 1247690e7021..0c3d9998470f 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1134,6 +1134,28 @@ static u64 get_extent_allocation_hint(struct btr=
fs_inode *inode, u64 start,
> >   * *page_started is set to one if we unlock locked_page and do everyth=
ing
> >   * required to start IO on it.  It may be clean and already done with
> >   * IO when we return.
> > + *
> > + * When unlock =3D=3D 1, we unlock the pages in successfully allocated=
 regions.
> > + * When unlock =3D=3D 0, we leave them locked for writing them out.
> > + *
> > + * However, we unlock all the pages except @locked_page in case of fai=
lure.
> > + *
> > + * In summary, page locking state will be as follow:
> > + *
> > + * - page_started =3D=3D 1 (return value)
> > + *     - All the pages are unlocked. IO is started.
> > + *     - Note that this can happen only on success
> > + * - unlock =3D=3D 1
> > + *     - All the pages except @locked_page are unlocked in any case
> > + * - unlock =3D=3D 0
> > + *     - On success, all the pages are locked for writing out them
> > + *     - On failure, all the pages except @locked_page are unlocked
> > + *
> > + * When a failure happens in the second or later iteration of the
> > + * while-loop, the ordered extents created in previous iterations are =
kept
> > + * intact. So, the caller must clean them up by calling
> > + * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
> > + * example.
> >   */
> >  static noinline int cow_file_range(struct btrfs_inode *inode,
> >  				   struct page *locked_page,
> > @@ -1143,6 +1165,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >  	struct btrfs_root *root =3D inode->root;
> >  	struct btrfs_fs_info *fs_info =3D root->fs_info;
> >  	u64 alloc_hint =3D 0;
> > +	u64 orig_start =3D start;
> >  	u64 num_bytes;
> >  	unsigned long ram_size;
> >  	u64 cur_alloc_size =3D 0;
> > @@ -1336,18 +1359,44 @@ static noinline int cow_file_range(struct btrfs=
_inode *inode,
> >  	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> >  	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> >  out_unlock:
> > +	/*
> > +	 * Now, we have three regions to clean up, as shown below.
> > +	 *
> > +	 * |-------(1)----|---(2)---|-------------(3)----------|
> > +	 * `- orig_start  `- start  `- start + cur_alloc_size  `- end
> > +	 *
> > +	 * We process each region below.
> > +	 */
> > +
> >  	clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW =
|
> >  		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
> >  	page_ops =3D PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
> > +
> >  	/*
> > -	 * If we reserved an extent for our delalloc range (or a subrange) an=
d
> > -	 * failed to create the respective ordered extent, then it means that
> > -	 * when we reserved the extent we decremented the extent's size from
> > -	 * the data space_info's bytes_may_use counter and incremented the
> > -	 * space_info's bytes_reserved counter by the same amount. We must ma=
ke
> > -	 * sure extent_clear_unlock_delalloc() does not try to decrement agai=
n
> > -	 * the data space_info's bytes_may_use counter, therefore we do not p=
ass
> > -	 * it the flag EXTENT_CLEAR_DATA_RESV.
> > +	 * For the range (1). We have already instantiated the ordered extent=
s
> > +	 * for this region. They are cleaned up by
> > +	 * btrfs_cleanup_ordered_extents() in e.g,
> > +	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
> > +	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
> > +	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
> > +	 * function.
> > +	 *
> > +	 * However, in case of unlock =3D=3D 0, we still need to unlock the p=
ages
> > +	 * (except @locked_page) to ensure all the pages are unlocked.
> > +	 */
> > +	if (!unlock && orig_start < start)
> > +		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> > +					     locked_page, 0, page_ops);
> > +
> > +	/*
> > +	 * For the range (2). If we reserved an extent for our delalloc range
> > +	 * (or a subrange) and failed to create the respective ordered extent=
,
> > +	 * then it means that when we reserved the extent we decremented the
> > +	 * extent's size from the data space_info's bytes_may_use counter and
> > +	 * incremented the space_info's bytes_reserved counter by the same
> > +	 * amount. We must make sure extent_clear_unlock_delalloc() does not =
try
> > +	 * to decrement again the data space_info's bytes_may_use counter,
> > +	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
> >  	 */
> >  	if (extent_reserved) {
> >  		extent_clear_unlock_delalloc(inode, start,
> > @@ -1359,6 +1408,13 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
> >  		if (start >=3D end)
> >  			goto out;
> >  	}
> > +
> > +	/*
> > +	 * For the range (3). We never touched the region. In addition to the
> > +	 * clear_bits above, we add EXTENT_CLEAR_DATA_RESV to release the dat=
a
> > +	 * space_info's bytes_may_use counter, reserved in e.g,
> > +	 * btrfs_check_data_free_space().
>=20
> This says "in .e.g.", but in fact there's only one place where we increme=
nt the
> bytes_may_use counter for data, which is at btrfs_check_data_free_space()=
. So
> just remove the "in e.g." part because it gives the idea that the increme=
nt/reservation
> can happen in more than one place.

We also have btrfs_alloc_data_chunk_ondemand() in btrfs_fallocate() or
btrfs_do_encoded_write(). But, yeah, for the normal write path calling
cow_file_range(), btrfs_check_data_free_space() is the only place. I'll
update the comment.

Thanks.

> Other than that, it looks good, thanks.
>=20
> > +	 */
> >  	extent_clear_unlock_delalloc(inode, start, end, locked_page,
> >  				     clear_bits | EXTENT_CLEAR_DATA_RESV,
> >  				     page_ops);
> > --=20
> > 2.35.1
> > =
