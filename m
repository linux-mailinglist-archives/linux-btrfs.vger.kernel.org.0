Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434915ED3AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 05:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiI1D6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Sep 2022 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiI1D6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 23:58:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147E0115F68;
        Tue, 27 Sep 2022 20:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664337502; x=1695873502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vrLZuhsicxwShyTwOFiXwHCp+Y28o2/pghLtbfax6e8=;
  b=QrxLnmyOyDYRMc0udwWgxGtTVmNSv6LXyyDrtp9iXrxVye6wL8HvHtG6
   GkMKPgm20+tpspCvGAi3UNR5PRxAawAK7ANPUIdjQxKLHaI5p1PfMoCx9
   xTfjkf3SL9NAoTqWQiVRe2V1EwP2zx3acupXbPS1PhWm5/x9kzjnhYwSa
   ZsNXQIWtOlG2FGTUv/atfDw9Ws0U3ZK8S9JT4XtpIlZSbijlFMaDhm89c
   EPHh/llEhXE9aJ3IL3SlqocqfkuPaIzDbPGPLvWG0HIhUMFw9JqpWDTjy
   GMNGclgGkzXt9yt0lzDRuS6piaiu0Xe6QREM1/cuvG4KBDz8KOosXPcuL
   g==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="210811734"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 11:58:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKJljQJdjtnU3mUoP6DpWJjPTla+4p7+qMYPbk9kNeuM2MepO/TLUVxq3MP1WsHcX2/67PfrXnw4m4ApSs9Bn9qaK3iESK9v2Qt72yLaV9UBzbT2a2f8Um6Ls2DmylGao2zqjVqeLfHGeYwSIzyrYINHKi7ejw55IZWAy//dF+x+lUs0Z5xLFQIxk1f7Stq4I73F6bpAwWyUSRtkbWU6UhunB4YD5X8lvC+atseP/OGVSK6AHj1dlrFv0uOA6xpckbaggWkfOTEVwvXRgfp0BTtkHoXtbqJIKcaDOdiuQ5D7477Fz/hIYzND3t7YA01GOYr+MoYVu+Aqgif+W1WlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HnXUBwYX1hqMy4ErsaOU0FHxNN2FlPlhxZnk8ZIj0U=;
 b=g7FI76Q3WeAkUhvnZxC9lfu1c7YiatyHXADNNyKAmigShrYavMEXs40Fo0iceY3xPHGm5SPEOiXcgOd1pqXmt/dWGj5stD8t5iek5vN/2m4d5n8FSHV/1b6bNKaspVUFCsf7gxohFT1T7rz6YEjnaXU8gnxUmGBEK2f8nj0Uv8Hw705p0MSSxROJUtJ7QbndMAwsAW36+271+qO7VbFuNLQHE98IJ949+Nu2vfMsj3ESbIG8b+X09OexTCyVw8BSjCxVP4BVzOMXQa7mzHBXjH4nYdh2Ff0EnhS1Fz2C6MiFlIlWFp7/PvplxI7QPSnYWn2gj/OgD+4UNW7sv/89FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HnXUBwYX1hqMy4ErsaOU0FHxNN2FlPlhxZnk8ZIj0U=;
 b=jrJ1P6xPRnx92bvP1bd2waIBA0yJzjKU8EcWSuoCoGUHsc63IAWD64b2Ld9f7Rg71pRzdaa/AugiJ+nDLDmt3Mgmzb0GvP8HQxiUnym/Vi3dcZUBNtpcR9vJ/hfsK7asKU8O1PrLgSrdcEvQp4A0h26L0aw+DL6TaAuFz1SL/20=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL0PR04MB4756.namprd04.prod.outlook.com (2603:10b6:208:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 03:58:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da%7]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 03:58:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: test active zone tracking
Thread-Topic: [PATCH 2/2] btrfs: test active zone tracking
Thread-Index: AQHYzkf28nQbRR6A4EOzAMSR2oCiga3rnSiAgAijXoA=
Date:   Wed, 28 Sep 2022 03:58:20 +0000
Message-ID: <20220928035819.vpghj75vianweptv@naota-xeon>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <7e30a693ce98783d68bc70d07c185bffc693a4d1.1663825728.git.naohiro.aota@wdc.com>
 <20220922160331.mzddtycyewfev7jo@zlang-mailbox>
In-Reply-To: <20220922160331.mzddtycyewfev7jo@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BL0PR04MB4756:EE_
x-ms-office365-filtering-correlation-id: e7fcdd54-5733-4417-83d4-08daa105aeab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rK7kl4svrPHc6opPOd7WeahoT6Fjg4xMw+vojlsNWbXvyk+yzO64IWek8CvNf2gFuvqK938AJ1RsQ7gvGMWtxVqSkhFkQgGuJEwIB+HRSKN0VP/a7RDFlw+Vl1vc6H6CA+MctOkaCBiClpIxBUAIpOUI1bmEC3UWQP6u/sjtOO0SmZNW3zlbRTgAV3sz/KnjL51VAHU3Ljb55Qa48IQNZc7wPzLLyQJEAMTLtxbbbylHiKe3iazCZTaVNk9EJti2FaqAwJkEWFUHK6ynBYyDeWefb6rn/0cNkkaItbOJB+bJzGPNCAis/aDnD2BFDeo9I5ZDcM2Y0gDZi48FK6eBHEUy7rqx6xV/bv3LoJRcIf6BtTjzrWLB2CL0zFGDHfEHiJNBDJ1FSLBTJ/Erw+Ym18QfOjfQnE05yYzLor3jDr20EdCAPZYZcnKUOw4ywMXyRyFOMcuaTiMrMMtInFiTMp8noJhMBndTQBsnFELbJ7gIoTBark+ETeeBdH77kfmzvA7neMZP76dW3DxgT3eXSnuIHw/54o83yosMgN3YX9jgp9FhhBnzcN00IRuyI/UJ638UGolI7KjejoOABhSl75RxK6I+9jJEvODsMvCodnJsWfDo8Lby4muFWrMlzqm17+NGEKBhW7/Rwg7h//gE1WGyS5zl9A6pVzaowIRdRDsF6EUw6mINkKnMqtU1bfScWRgG5ySSDckJfhwYksz5L6o6pPD37/+oclmsXh6wW5tMYCtdlgYdapdKZBtEeA7p3O+mlWW70C94j5YoO1oT9/8vszIwSqbqBHsy8+ZA9qo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(71200400001)(478600001)(316002)(8936002)(6506007)(26005)(9686003)(186003)(76116006)(66946007)(64756008)(91956017)(66476007)(1076003)(4326008)(66446008)(66556008)(82960400001)(38100700002)(86362001)(5660300002)(8676002)(6916009)(33716001)(6512007)(54906003)(2906002)(122000001)(6486002)(66899015)(966005)(83380400001)(41300700001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bc7OeYHKRzN9UBAWVPEm53mXSQv/pswmqgDzyytwWsXYyB+gpjDhjPuc7ovu?=
 =?us-ascii?Q?vPanNORNuG30ICXagcP+t5RgmO+Hh6WcVX3zT29NTNCWX1zTYwo0BGXlTHft?=
 =?us-ascii?Q?9DeKUOJJzyuDON0CA9VzIq/VWHdv18sBA38xMQrI2IF/Puj/fB0UaAnU1zNL?=
 =?us-ascii?Q?ArLfetMcgDaeGX80fRKsPJVywMGggcDPqhBgf6tKjy4PbVNQVnNQ2CwbNVUU?=
 =?us-ascii?Q?HzSRzMJ+IX7V2ODgWuZhL4zvC0Ukqk7OGAd2bBcWz/tKjJaW42ae07QwLwCB?=
 =?us-ascii?Q?JX7gY75rYGsyFv4gg3C6oW9ZAYpP3GFHSoS/ncM76deLhHuwyIBk6DRExEy8?=
 =?us-ascii?Q?cvWa2MZWd/GoZCwiU6QY0DfG/aQ1n41oElI4QjOOwnryUWRcxvVEnpqskw6O?=
 =?us-ascii?Q?nN8AjPSwwzJA7SSSDwUxU+Z1dG4qbhtlX8+YI0CUpXfNZ5E0eLmKv022jfEV?=
 =?us-ascii?Q?FmwOpYZ9Dw3IkU8iBUUCLPdVNvpphLIU+yFnrAzwlgRtANsdPiTrT56KZeeD?=
 =?us-ascii?Q?B825qYKY+MxcAR6ZdyrG3aj4GqMbHGsIoJbR5C33rkqoWC+UxA0ta7pZ50QU?=
 =?us-ascii?Q?jB45ht+TmK2imVthO+KVlGpT3d1mgqDdcvIVXIiE893dwD6+fTbe1R58KqDN?=
 =?us-ascii?Q?loW5s6x4SavcXv3kY8lhSPj/L2rseRhz50/jir0Po7+VlGfWckwd/E/NPY+6?=
 =?us-ascii?Q?chc+etHUYXPuSJJtkKcUjf0WOVl8EKINoTAhcWXZpYbZI2nONnc51bH8TScI?=
 =?us-ascii?Q?bKaS3DZ29q09XASFUUWZ/u+IAzmPWbpo0XAEUSt9P8iarJE5DQl9psFV6tPW?=
 =?us-ascii?Q?FL0u/dcZSuoCPVfYdZWZGQvfGEyV17oXwGxUIbX5qcGEIo8HGw7y2uyRRUYH?=
 =?us-ascii?Q?AMmLlIkky8PH8j+j2nVrB9VzyA9RuIXqBrS1prLiTDdl7zudmyYyaNJ1FNNn?=
 =?us-ascii?Q?gKSWUOipr8McAmF+JaU11bfsJpXD/gOFrwchvQF91RbeYtkHADgwRHA+WsD4?=
 =?us-ascii?Q?uTAmYz5PdFIxgvs4u9FFKVr6TEy/Pd6EMabtCT058YspUR+Se/R+QrdY0s5l?=
 =?us-ascii?Q?JxIyrR5Cfuvpxe3l3ciudQDxZ7bX++vEPNp0/AnhHY4p/SMxmpfbV77gm3Hz?=
 =?us-ascii?Q?MEKIEfDavm+lG8YkMMmcjl/JPCWfFFC9UHaV58jiEWh4Yaw4ShijAuNJvO9j?=
 =?us-ascii?Q?rJo4H215YamgrWKTr5aqJXEKRtqXAkNqOwEofWdf0V4zdpnbE2uCJbo0w0ug?=
 =?us-ascii?Q?249/6r+AUjwDIE4UeCI0E2U3FYCN9GT9slypn/GNoIfDcFcc8x3Bk99PjlEG?=
 =?us-ascii?Q?RJTgTPeJYD6ChHak2b/3HbU4DahSLril/7Kg7rjzQefml/XhoXi2UOD9+idZ?=
 =?us-ascii?Q?KdO3ygSYU59eU64LT6PTESpCAx8XgPtVFCnGCl6cYClMymvOSQeXQjPKBKT/?=
 =?us-ascii?Q?1Zt+RWkx6her6rRAC1HfJuNILZvdBZDg0I+j8T6XLubgXwxNyosRQWcr80RQ?=
 =?us-ascii?Q?PKwEzQij2npUp+Cy1QrROg6EhyHRheaTuQiaZVr8WQTi4irzashrQpDiiC5G?=
 =?us-ascii?Q?hB5FOmeHIT02TlLL5umA/alt6YWz2YyBfIMw+mO1p5lgvOGsOumK19L8UVRU?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <313E041F9AC25947AED311466E663CA8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fcdd54-5733-4417-83d4-08daa105aeab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 03:58:20.3417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkiK1yWTLWy7rtHcBbEyhrdVSChWyM9rAhwdLtb8CcnEj8WrvpmrRFDWlonJY/uaRhRlrw1lMZDfZj8HpYkjJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4756
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 12:03:31AM +0800, Zorro Lang wrote:
> On Thu, Sep 22, 2022 at 02:54:59PM +0900, Naohiro Aota wrote:
> > A ZNS device limits the number of active zones, which is the number of
> > zones can be written at the same time. To deal with the limit, btrfs's
> > zoned mode tracks which zone (corresponds to a block group on the SINGL=
E
> > profile) is active, and finish a zone if necessary.
> >=20
> > This test checks if the active zone tracking and the finishing of zones
> > works properly. First, it fills <number of max active zones> zones
> > mostly. And, run some data/metadata stress workload to force btrfs to u=
se a
> > new zone.
> >=20
> > This test fails on an older kernel (e.g, 5.18.2) like below.
> >=20
> > btrfs/292
> > [failed, exit status 1]- output mismatch (see /host/btrfs/292.out.bad)
> >     --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
> >     +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
> >     @@ -1,2 +1,5 @@
> >      QA output created by 292
> >     -Silence is golden
> >     +stress_data_bgs failed
> >     +stress_data_bgs_2 failed
> >     +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scratch/s=
nap825'
> >     +(see /host/btrfs/292.full for details)
> >     ...
> >     (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs/292=
.out.bad'  to see the entire diff)
> >=20
> > The failure is fixed with a series "btrfs: zoned: fix active zone track=
ing
> > issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_max_s=
egments()
> > helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finished wh=
en
> > allocation didn't progress")).
> >=20
> > [1] https://lore.kernel.org/linux-btrfs/cover.1657321126.git.naohiro.ao=
ta@wdc.com/
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/zbd          |  12 ++++
> >  tests/btrfs/292     | 137 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/292.out |   2 +
> >  3 files changed, 151 insertions(+)
> >  create mode 100755 tests/btrfs/292
> >  create mode 100644 tests/btrfs/292.out
> >=20
> > diff --git a/common/zbd b/common/zbd
> > index 329bb7be6b7b..19a59fd27e69 100644
> > --- a/common/zbd
> > +++ b/common/zbd
> > @@ -2,8 +2,20 @@
> >  # Common zoned block device specific functions
> >  #
> > =20
> > +. common/rc
>=20
> Did hit anything wrong if you don't import this file here? I think genera=
lly
> we don't need to import common/rc in other common files (except common/pr=
eamble)
> , due to it's always be imported at the beginning of each test cases.

Thank you for the comment. I'll check removing it affects the test.

> >  . common/filter
>=20
> As I said in patch 1/2, if you'd like to create this separated common fil=
e
> about zone device, are you willing to move those extant zone related help=
ers
> into this file, and change related cases to turn to import this file? I d=
on't
> have objection if you'd like to organize that.

Yeah, moving _filter_blkzone_report() would be fine and clean. I'll at
least move it to here.

> Thanks,
> Zorro
>=20
> > =20
> > +_require_limited_active_zones() {
> > +    local dev=3D$1
> > +    local sysfs=3D$(_sysfs_dev ${dev})
> > +    local attr=3D"${sysfs}/queue/max_active_zones"
> > +
> > +    [ -e "${attr}" ] || _notrun "cannot find queue/max_active_zones. M=
aybe non-zoned device?"
> > +    if [ $(cat "${attr}") =3D=3D 0 ]; then
> > +	_notrun "this test requires limited active zones"
> > +    fi
> > +}
> > +
> >  _zone_capacity() {
> >      local phy=3D$1
> >      local dev=3D$2
> > diff --git a/tests/btrfs/292 b/tests/btrfs/292
> > new file mode 100755
> > index 000000000000..30c027c4ba5f
> > --- /dev/null
> > +++ b/tests/btrfs/292
> > @@ -0,0 +1,137 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Western Digital Corporation.  All Rights Reserved=
.
> > +#
> > +# FS QA Test 292
> > +#
> > +# Test that an active zone is properly reclaimed to allow the further
> > +# allocations, even if the active zones are mostly filled.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick snapshot zone
> > +
> > +# Import common functions.
> > +. ./common/btrfs
> > +. ./common/zbd
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs btrfs
> > +_require_scratch
> > +_require_zoned_device "$SCRATCH_DEV"
> > +_require_limited_active_zones "$SCRATCH_DEV"
> > +
> > +_require_command "$BLKZONE_PROG" blkzone
> > +_require_fio
> > +_require_btrfs_command inspect-internal dump-tree
> > +
> > +# This test requires specific data space usage, skip if we have compre=
ssion
> > +# enabled.
> > +_require_no_compress
> > +
> > +max_active=3D$(cat $(_sysfs_dev ${SCRATCH_DEV})/queue/max_active_zones=
)
> > +
> > +# Fill the zones leaving the last 1MB
> > +fill_active_zones() {
> > +    # Asuumes we have the same capacity between zones.
> > +    local capacity=3D$(_zone_capacity 0)
> > +    local fill_size=3D$((capacity - 1024 * 1024))
> > +
> > +    for x in $(seq ${max_active}); do
> > +	dd if=3D/dev/zero of=3D${SCRATCH_MNT}/fill$(printf "%02d" $x) bs=3D${=
fill_size} \
> > +	   count=3D1 oflag=3Ddirect 2>/dev/null
> > +	$BTRFS_UTIL_PROG filesystem sync ${SCRATCH_MNT}
> > +
> > +	local nactive=3D$($BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | wc =
-l)
> > +	if [[ ${nactive} =3D=3D ${max_active} ]]; then
> > +	    break
> > +	fi
> > +    done
> > +
> > +    echo "max active zones: ${max_active}" >> $seqres.full
> > +    $BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | cat -n >> $seqres.=
full
> > +}
> > +
> > +workout() {
> > +    local func=3D"$1"
> > +
> > +    _scratch_mkfs >/dev/null 2>&1
> > +    _scratch_mount
> > +
> > +    fill_active_zones
> > +    eval "$func"
> > +    local ret=3D$?
> > +
> > +    _scratch_unmount
> > +    _check_btrfs_filesystem ${SCRATCH_DEV}
> > +
> > +    return $ret
> > +}
> > +
> > +stress_data_bgs() {
> > +    # This dd fails with ENOSPC, which should not :(
> > +    dd if=3D/dev/zero of=3D${SCRATCH_MNT}/large bs=3D64M count=3D1 ofl=
ag=3Dsync \
> > +       >>$seqres.full 2>&1
> > +}
> > +
> > +stress_data_bgs_2() {
> > +    # This dd fails with ENOSPC, which should not :(
> > +    dd if=3D/dev/zero of=3D${SCRATCH_MNT}/large bs=3D64M count=3D10 co=
nv=3Dfsync \
> > +       >>$seqres.full 2>&1 &
> > +    local pid1=3D$!
> > +
> > +    dd if=3D/dev/zero of=3D${SCRATCH_MNT}/large2 bs=3D64M count=3D10 c=
onv=3Dfsync \
> > +       >>$seqres.full 2>&1 &
> > +    local pid2=3D$!
> > +
> > +    wait $pid1; local ret1=3D$?
> > +    wait $pid2; local ret2=3D$?
> > +
> > +    if [ $ret1 -ne 0 -o $ret2 -ne 0 ]; then
> > +	return 1
> > +    fi
> > +    return 0
> > +}
> > +
> > +get_meta_bgs() {
> > +    $BTRFS_UTIL_PROG inspect-internal dump-tree -t EXTENT ${SCRATCH_DE=
V} |
> > +        grep BLOCK_GROUP -A 1 |grep -B1 'METADATA|' |
> > +        grep -oP '\(\d+ BLOCK_GROUP_ITEM \d+\)'
> > +}
> > +
> > +# This test case does not return the result because
> > +# _run_btrfs_util_prog will call _fail() in the error case anyway.
> > +stress_metadata_bgs() {
> > +    local metabgs=3D$(get_meta_bgs)
> > +    local count=3D0
> > +
> > +    while : ; do
> > +        _run_btrfs_util_prog subvolume snapshot ${SCRATCH_MNT} ${SCRAT=
CH_MNT}/snap$i
> > +        _run_btrfs_util_prog filesystem sync ${SCRATCH_MNT}
> > +        cur_metabgs=3D$(get_meta_bgs)
> > +        if [[ "${cur_metabgs}" !=3D "${metabgs}" ]]; then
> > +            break
> > +        fi
> > +        i=3D$((i + 1))
> > +    done
> > +}
> > +
> > +WORKS=3D(
> > +    stress_data_bgs
> > +    stress_data_bgs_2
> > +    stress_metadata_bgs
> > +)
> > +
> > +status=3D0
> > +for work in "${WORKS[@]}"; do
> > +    if ! workout "${work}"; then
> > +	echo "${work} failed"
> > +	status=3D1
> > +    fi
> > +done
> > +
> > +# success, all done
> > +if [ $status -eq 0 ]; then
> > +    echo "Silence is golden"
> > +fi
> > +exit
> > diff --git a/tests/btrfs/292.out b/tests/btrfs/292.out
> > new file mode 100644
> > index 000000000000..627309d3fbd2
> > --- /dev/null
> > +++ b/tests/btrfs/292.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 292
> > +Silence is golden
> > --=20
> > 2.37.3
> >=20
> =
