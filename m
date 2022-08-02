Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B597D5876F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 08:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiHBGD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 02:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 02:03:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F19A26AEE
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 23:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659420206; x=1690956206;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=LzWJ0XXNUbZ8h361WY8s9qHnzM8+fYojcAWsEPe35iw=;
  b=OgkBFDh97mK9F+ZMgUZeL6ZhVynqI62M88kWwBkdZCnB747UTLvIj9+U
   ZSG6M2Te+vujqbFPG5dK6QCvRIvAZz9cM2LEfplagFEuW94sqY6rL0GPj
   TLS21/LqyA4mqqUzCPVW6x1N2nZnHYMl1vYLd3IimH+Xth+EweBYb777z
   MvnsXyfT9tvBEP2Euor3laaZL6h3YLPPmFl9iVdOlA2gJnlmef6RKZF1Y
   Qg4Oph6Ut4kwfxps+Bprx3XZYTonjGVrML/deexDY5sz7wdkqu6lRqOfs
   BNlFr6Ich9N61+BIYcqrlChQY/xBN3L0yFEl69JzMTjeKwSVeyMms+dxN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="207536164"
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 14:03:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWxA6PMeShP+qxBeF1COaqaCAgQEI5lxE0zLGP2sNCWDyMkYlQ6FkKv44cObqsF6KUDj/321WTLd44YVrlBns0eX46BuvutFmOXOT6SkCiSSX7C0aRWwPbe7qyrIPScrIUE5+fkOc7z87/B/THmPX4b2Ewj33KLdme0qmx7AI8ij67Vk0XL/aTJ6KcBYhRTxz2bmScrFG+IzK9AFR1Ku3D/kNMXYC7sl8FzC3h8Q6RQOpd+Ooo8CInJEuAziiIQKOIvWY+EglctbzG3SWInogYNxVyS5wnAxBzfWHJZJ80YbsiJszCcOAOU8RCjLkiqsCZaejl0f//CcBrfgUmLnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4kOrHErARxib5zG270l3T2mpZiJQLwFzLwmt/WiWsA=;
 b=HlvEistKeoCuPMbFo68hwF6tAS7Lxl+AE5equSc5/+icSEtxWQdmAV7y/Q6Yo3G8LTOJSmk39QrLzzNAZLprfG2DKHey/mCnKSdZ1+xs7gytScisPQj7T5MHjL4GQZDZFK/rVMJRCFC4JXSjOah8NsU6Oi/pmJXkrDPnnkihDSGXXyAywIpDaXKzRVltn25m6yV18CwYy0t21Zi3kddqyIl/8UNb+1MOXDmhjlF1uXblns5QNakg+aa7UOy9R7HGfZ7kXvNKmLIQzbNJfCZMdj4OGx5hOMG7tAAdZqXF9sbfb9ME0J3j7KF3b6yct1cnFhbZE7A5Jfa7e4B/JfdC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4kOrHErARxib5zG270l3T2mpZiJQLwFzLwmt/WiWsA=;
 b=dKwUeM5LiOn7j4BQbFE1n6Jmntq4Y8rrpXKyoudzcHBk6uvSB4bVI5n/xmQXQo6FKS6LjAHJju8B6fxKnzxGMAtbsMEAV7AFx3e7ReOJnrI8NZ5U7RVa3CtWyLfZeamd3RvZ9BgcIX6sz/B2XaUdi3dUHNTecDsdMVAaPYDHp7U=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB1265.namprd04.prod.outlook.com (2603:10b6:301:3f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Tue, 2 Aug 2022 06:03:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 06:03:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: mkfs.btrfs failure on zoned block devices with DUP metadata profile
Thread-Topic: mkfs.btrfs failure on zoned block devices with DUP metadata
 profile
Thread-Index: AQHYpjWThm0xZX/JWk+GQ+9JQNXFWQ==
Date:   Tue, 2 Aug 2022 06:03:23 +0000
Message-ID: <20220802060323.khfjqwhwwbpjbegb@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96ce18a3-fa3e-4df7-b5c2-08da744cb5aa
x-ms-traffictypediagnostic: MWHPR04MB1265:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHA+/qhZedig3rP5E117+wHuUtx5Pt/UdQNb4k/oNf/waU0C60+vfWEPYI5cWfqv8p8Pyxk68HW9EGmN4+04seMEJxbWPkJYYcf49GqZK+tZkqp7rKf/gWtBc13GFkjuqSla9RP2u1C+NZIIq7GdEsQV6RF4XUgYNHqgPcnztE0UyT91lp8qBPLHx6xr3mzrGRVq5l6gLjgclyOGhKSGw3Ei/lERPmHLbFFbZ98yoMXWG2WRwQW0kZA5//wiSetVdrKllrOhvXDzxs9rOWb3Y9bcm1P4rgrizokP7s2tDPIicv0GEKrnOsJ3ykcDG+f5aeD/xmLMZ1UHTfOzd52k7+WAyBs4MyQQcT8TtR5m57DiPLMeMxKTQEpVuHZ7K+Uj46T6TQcF7UT7Lmj0GPVZ+LBxy51cUtAYh/7ZkuR18YmaKrizAXaM9vFNtJa+saGVljsVUY6VRk4lPUpxKJpVPDb0jHmctDip9DyI+7tFSfhc0WoThmuy6P70rOzFHGb3eZQIehFy2kV4jrhZJ5Z6m1L0BujmGpJYBoExsx9WnhGOpzqczlnbC7uNWIwFI41Hq710wRMuq3rdXwfTBecfpM2WRPcTeUfSsRxw5UL1SSFRpmPKwHq2XA684MWTaZ+OSc+snH+v2w2eDEa8XJxQyJbR/xAPEwr0mjqEM5R3qJmmQPX2nyaHkI60kEH+ImTMfuGYwkBw1dXfTYgOIL5sSUjoPPGC4/FOoy4XAl2d9phUhDkIdDcHO/anH/Jo8k7JxlXvxoCY8pzmLricq/bgzqeMjbm2imQoBa9IXmyJF91deLEV9imTmzL5eRKj/jmftsEHVA3mED9m8X/4t21TdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(86362001)(82960400001)(26005)(478600001)(186003)(6512007)(9686003)(38100700002)(1076003)(6486002)(966005)(6506007)(44832011)(2906002)(41300700001)(8936002)(3716004)(83380400001)(5660300002)(122000001)(110136005)(316002)(71200400001)(91956017)(54906003)(33716001)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bE6SDkc7aBYpi8FFAUf3hizR7+wGBh5XqfWkrUWkmrwuR5h8IVRA1JQ+aIjH?=
 =?us-ascii?Q?g+BFJx+IdBgIGRijUgiJzBsK+DTZAsDMM9OLlPuRfBZCH4GrPmbgl6yxO0g9?=
 =?us-ascii?Q?dSvmj2GugEyQCT+Czgt/W4gAK0nfWRsLftoiHhHFNGnineMRTuy6EjhkWqiU?=
 =?us-ascii?Q?GeQCqsoIoh/VhcBqnoHsVX3/wI2I4wK5k6WML2hlMH6f9l+BXvpABRh6x991?=
 =?us-ascii?Q?sG56i46UX8Uhbj7tRbzVOZiKZDTRs89VjNi+dDx7WedXekD+OYorXJZkXmjJ?=
 =?us-ascii?Q?9niTl7e8MoTg1muZk0gpeRM4rFUMjqbC4so59BFgjKcXA/n+MiK9C7ofzI+H?=
 =?us-ascii?Q?Rkm/CmkDcsPTeJYp269DWRXV2sTViD5BCo+2LrcSWEShIi41Y15tCnb+zXoi?=
 =?us-ascii?Q?U29CDmXNEoVkbsbC/a1nF7dgQb0/Obq5Tg2Y7yu+rc+R7o+6bqaPqGFrOzp/?=
 =?us-ascii?Q?rAnVMmQ968+zPL5aNzpwyGa/9aStRJTVZ9L29zpiysduTA9Fz9kjTC/humTN?=
 =?us-ascii?Q?KFfXlvXhrZRcZaCnOFCmm/PQhZc/tSeJ2bGI/OyTNw6qlxPvNnaL1GzhsWWK?=
 =?us-ascii?Q?z3P0MOPXonsFdY4l5nOBNqI4fjpdeXy12U1L6Ptr/GELXcWFJzJ5vKxOEswk?=
 =?us-ascii?Q?AMMg+nhwesYbPqIltTFpilXDPHce2OaG8KrbdxK5yQFWg6orD3Y2S06i4r6C?=
 =?us-ascii?Q?/STieGpXgk8/vzc4ZTuuHpqJMEVNRZTDgfzcWYo3pvV/03CNnzC6OSalpCds?=
 =?us-ascii?Q?uo8wWMZUd/WKYLPrQLiLeSaK+GtG992yXPyzA0NtJN4SlS5yalvzV2+kRZO2?=
 =?us-ascii?Q?pyNWrb91gPdCzBIrsx0SnSTvYu5hzJT8ItQSVjIrdBJvBu+J/JOhSW56fBmf?=
 =?us-ascii?Q?Zwig1j7rBUwdgn/Bb+FPW8f/LeOOymWlILBrZzO5mTBZDUz7U794EtoQW7Fw?=
 =?us-ascii?Q?HdaUuUVFozYBdz/W9qFtAMt0iW4DIVj86L5OkrXlvol3fLoPIUHmfRJ9AJ85?=
 =?us-ascii?Q?GES4F/roInfp/8uqy2SlocwTbeFEU7j04OFsGBrAjhuygUZO9YU+GvO1q7GV?=
 =?us-ascii?Q?1gTaTftW3KU34i3fRut/k+rbL/MkRSEJk46a14FDvCkyN+KrW+r59Gs43y4a?=
 =?us-ascii?Q?IYC2SsbKXrkL4WSnRF8xWVNGjzyf4JtmajX1aUJ2fcNOhVGlfA3pZ/JH9Wki?=
 =?us-ascii?Q?HiYn6m/+pbQi7FW4femtf4lNlKE7I00XCwIsSunI2Tn+68tvkOduo3NCeXO+?=
 =?us-ascii?Q?flsJRqYIxrNA/1S6HSIhknRlgNlk00LWLuIM+w4dKWNp0Mqz/z1SIbnl2dUa?=
 =?us-ascii?Q?5rU0E6pXANMyXG7i7mWIAZkHCr/QgZanSW+divMKik+3sFbR2fXIfw/pYTgv?=
 =?us-ascii?Q?Aj4mvEl11NySR5MVzBdfHvyG5ApqKuhhX9P4bw38SZkvUPundVA4CuJ4Fe/G?=
 =?us-ascii?Q?eJgQUAoEsoz/TCXMfzAnllM4SZqIAUNeh2D/jeRqt9RlLR83sC8GYx+tz4oG?=
 =?us-ascii?Q?ggNQOHqkNtyzDunmyozZFjrapiAsSg7Guqr5MNaPXUOwyS060xHrTqkbdoDW?=
 =?us-ascii?Q?I1I/j3GVgDTCrLgSV08b0f/9Mxf5eCd/IxlzcI1jeVmO9rBIDjX14bb+43m9?=
 =?us-ascii?Q?93KyRyEA7/o/3nPHi2d8nDc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A7B7A4DE47D7B47988384342632A5C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ce18a3-fa3e-4df7-b5c2-08da744cb5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 06:03:24.0390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fh01eAx2O5FyiM0C7TuCUsTAUXqscW0u66NGf/PRsob5xNPnH7QxaeMic4DRChOyntz99QTlWnsqLqeLxzie0z/Kgiaz+5eHOf+Ds1VwCPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1265
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,

I found that the latest version of mkfs.btrfs fails on zoned block device w=
hen
DUP profile is specified for metadata. The failure depends on btrfs-progs
version and the trigger commit is 2a93728391a1 ("btrfs-progs: use
write_data_to_disk() to replace write_extent_to_disk()"). After some
investigation, it looks for me that this is a common problem for zoned and =
non-
zoned block devices. Here I describe findings below. Your comments will be
appreciated.

On the failure, mkfs.btrfs reports "Error writing" to the device [1]. At th=
is
time, kernel reports an I/O error, which indicates "Unaligned write command
error" to sequential write required zones. With strace, I observed that the=
 mkfs
writes data to same sector twice. This repeated writes were observed regard=
less
whether the device is zoned or non-zoned. It does not cause an error for no=
n-
zoned devices, but it causes the I/O error for zoned devices.

Using strace, I compared the write to a non-zoned disk image file before an=
d
after the commit 2a93728391a1. It shows that the commit introduced the repe=
ated
writes to same sectors [2]. Is the repeated write expected after the commit=
?
If not, common fix is needed for zoned and non-zoned devices.


[1]

(/dev/nullb0 is a zoned block device with no conventional zone)
$ sudo ./mkfs.btrfs /dev/nullb0
btrfs-progs v5.18.1
See http://btrfs.wiki.kernel.org for more information.

Zoned: /dev/nullb0: host-managed device detected, setting zoned feature
Resetting device zones /dev/nullb0 (64 zones) ...
NOTE: several default settings have changed in version 5.15, please make su=
re
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Error writing to device 5
kernel-shared/transaction.c:156: __commit_transaction: BUG_ON `ret` trigger=
ed, value 5
./mkfs.btrfs(__commit_transaction+0x197)[0x4382a6]
./mkfs.btrfs(btrfs_commit_transaction+0x13b)[0x43840a]
./mkfs.btrfs(main+0x171c)[0x40d64e]
/lib64/libc.so.6(+0x29550)[0x7f5108629550]
/lib64/libc.so.6(__libc_start_main+0x89)[0x7f5108629609]
./mkfs.btrfs(_start+0x25)[0x40b965]
Aborted


[2]

$ truncate -s 1G /tmp/btrfs.img
$ git reset --hard 2a937283~; make -j
$ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/btr=
fs.img |& grep btrfs.img > /tmp/pre.log
$ git reset --hard 2a937283; make -j
$ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/btr=
fs.img |& grep btrfs.img > /tmp/post.log
$ diff -u /tmp/pre.log /tmp/post.log
--- /tmp/pre.log        2022-08-02 14:12:19.670688371 +0900
+++ /tmp/post.log       2022-08-02 14:12:47.019382686 +0900
@@ -32,36 +32,66 @@
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 5357568) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 4096, 65536) =3D 4096
 pwrite64(5</tmp/btrfs.img>, ""..., 4096, 67108864) =3D 4096
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
+pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
 ....

--=20
Shin'ichiro Kawasaki=
