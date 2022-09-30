Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9ED5F04C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 08:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiI3G3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiI3G3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 02:29:41 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621463D9;
        Thu, 29 Sep 2022 23:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664519376; x=1696055376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ma9V9ju0xqkb8aDOcSkahypnTwfsf9Kgqy8ybf7lPoo=;
  b=dsrYw83kpCud2I8NtqIIALXTqsmCxam65EBjuX6u3Y1b92W7WoLpTvol
   0rhVmXLs33zb++3Eh4jDdt+A5ZjPZ98qY8j7iKTJ2xGzeX1mmKrHvdNuE
   JEcEpo/KeOJzOK/68F2NIlo91TTgSGmmUqvFwn8tbRQpiRjTB6925FRKV
   rIYocdgKlGD+EmBCFWnN+nSgLDsUpjZ9Je1kD/NKcIkVR/n6lH5E6f8Ax
   x3j5PIAhw8dPboiTmObqhm+r6Cp44GBb9hIPNk11bIN5zjm1HF45f48HJ
   c+fhfAEsqL6IgduWWOUTDkBrHw51C4hfdoEHJ/bzu1uJF+oIPcpFaRZ15
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654531200"; 
   d="scan'208";a="212648540"
Received: from mail-bn1nam07lp2043.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2022 14:29:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYu+CkD5/efVxOt1rbVzUzf6yFXKT7UOhnyU/USFTcDArZ8hZbL8r3hBIqTWafeBk461gOo6nJF4KNwbQr8uiSR2UtGMM8r/vtJyVgMriSKLsRg8KjNPKnY+AyENK2Ob4CTbCojQ7fC1vwCKN7UDJ2p5FqNkce5ciidmTGtxkg8zVTzxaTNExrhw3M3BFfuvAcJxHw7ZlwgjvkToEJ+eKDc8Fkf4+Rxpi+cuyy+xb7ii623Yx8Yp5YKO+EhojaI9x/yKNYdGk+zWPdstcYK0HLmWifoJQKr/uB1v1hHbmBPp8tlLinvBBI+X2ltVCyKcRwLY3DpPXcOckda5SFhhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZuU9IGkCfn9OWMMj4OYouh4aYUyXfBe8NSqksd4mOo=;
 b=MdbR3dHnxOHNpoGmL/X7EfJBbJ+zUhoPm2Pr2TMbqTqyr70mUFzP88IKJmpTP2MQ9D4S7u4ZPu2JwU8tlic3fXCngeArsNeGY2eRXHqvOUmczeDvIOpzZ2QJpksV0GJFFUCVq5iQclE7k0BQPEnvbEZ4yqu1fbirIXrIPUP2x+0D+9p2C/4QgBZKX3YE0gSdRlk95z8unYjYn4lX5QSalvWuxO75Vk11vLlpk7zE/s0J9+D6Du4+7qM2TuhYNM/2nNwKKh+jML+CAuxWk1cq9tf0uDdFNu7dp55jwbsHZ8cYtCfJwBja8epauRJ6E7ElINPxmuH8SbGOGWC8cQVecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZuU9IGkCfn9OWMMj4OYouh4aYUyXfBe8NSqksd4mOo=;
 b=akgQ9hcjaNqNPs8qaKever48uVfz24uM5m6PiQxnhWa6V1MMUFpjoWfoV9oR6EmAwXUe0DgYHx45M/epBB7gq6b1o3mBPR0/XDE8JN8PO7qVRpXxzh7s3zQ+I8sgjc63eDtYGAP+ScjyDL5VhurysuIxck7EOKJBzmsqpLflSlE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6363.namprd04.prod.outlook.com (2603:10b6:5:1f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 06:29:34 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da%9]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 06:29:34 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] btrfs: test active zone tracking
Thread-Topic: [PATCH v2 2/2] btrfs: test active zone tracking
Thread-Index: AQHY07qyD3LBbxjtY0mgx3OrQubj26316kQAgAGaRgA=
Date:   Fri, 30 Sep 2022 06:29:34 +0000
Message-ID: <20220930062932.6zflr6j4fft2gu3y@naota-xeon>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <7390d3a918ce574d5349d31ab26fed0ae79952a9.1664419525.git.naohiro.aota@wdc.com>
 <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
In-Reply-To: <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6363:EE_
x-ms-office365-filtering-correlation-id: 748e0877-4977-4a60-a72c-08daa2ad2419
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5rsL2JoBia+jDd6dB4uhY2uhFe8yCPgRaGqmqSYE4+j1JAcs9S2z2RJx7fHAkWfLQK6bzCxjjUZhuJCDM/l+xXjKIVmyJbljkqDjtoJLARlnTYgEgGhUos9W8JU5ZiScq/rWL8QyNPl7TnliyR3XNPZWcA+YE8QjoO/dyX97OfKUR4EAI6DYKOcE0AomHnqHwoH40YawOx5WQbXKxy1ywIkt0UPQXVVbIfSF13Jn4qd76AO2JVLhI6UKpiEtsLya2TjKu8x+r3noPI25Nt8uLy0HZ9SBJ8sXcADgWFFMUxeVa1nkm1JBMLBC0UGnc230biDFMRIYNBWkOTAeK/dIgkR3APxIc9WiRkURbEfL5WNWTAoV0lepkw9u/wNP+jRIdKct/FBGRiq0m1vUtO6sXWJwUIWLkSJ69wVHI6HuSYsg44I41Z5wRYnGbizetZJn21ffRDhuT7K7sITGBWF8YxH7TH/DiktEmjhdF2tSl/vjDtXcLtP3ugS6iWPQiX3fFlpkv26Qh821I3qymzdPzrB6lTkCyeRavAc60WI/AhxWfLHYCHzZig39PEtPWtiYO0J47QHso59VI8Hgpg+gEKg6GUCWfZ+fHYsAaqtxNaJEyDbXbkf95GJmdrBuFLwNNwwgIqOanaeVGyfvkTyBKsYBWYmvLgynLLFfSm9xJ46Plg5483d/lZk1X+/LykGis4YpdRtSBq7y9Q58gHxuQMFRWRi9fSSUx06wkebjHLI0JOO4bP4SxY1tJ+jEY8djawS2cz4/7IOE3EkHUEY/5isuOfG3E/w6jeo5qCBEM4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(2906002)(9686003)(6512007)(26005)(1076003)(186003)(478600001)(8676002)(6486002)(71200400001)(6916009)(54906003)(6506007)(83380400001)(5660300002)(316002)(66476007)(66446008)(4326008)(66556008)(966005)(76116006)(91956017)(64756008)(38100700002)(66946007)(86362001)(41300700001)(8936002)(122000001)(33716001)(82960400001)(66899015)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DHvnw2fmWSvATRp3X/Eh/m0md6MrWPzoP2pXl+oF1aK/hzzBWnFsfo+8vz2S?=
 =?us-ascii?Q?lSm6xTt0vMtjKvj4wTKzhADZRNTbnnfmtpJEWOQY/GeZZLdPU7SRfIghoZq8?=
 =?us-ascii?Q?IDqaZY6Q/5kFc6SoXXAQ5DuOiKUPfz5pIdapy04qwn22lgz6HnpqEk5EkM0g?=
 =?us-ascii?Q?TC/AKjmOyxo+++qbVLPun2RFITMeIHb7h/EM/jcwZZd+k83i8Q7PARHA0x2x?=
 =?us-ascii?Q?Q+b+x1EA4s6Vo4xLqCm5yuILx5FzFlBkAcxxXeKhlI2fDCeW5N74AXLbyCzo?=
 =?us-ascii?Q?hdEoXy5oq2QbA/5QXaMQF+ECU3GDpHS0/SaYugyA4ITTbtsPxxLu1BWk/nfF?=
 =?us-ascii?Q?MwJwGM6Nv6bXp5Nbv8PBvuRqeNzebyT0UheOQb777lhrJucZbi2GVOBMWHhp?=
 =?us-ascii?Q?QbnQvRlJgYxkfKlEFSzj1pVgv3gNKyI40qpq+eWwZT/rmJTEaRgq0ouSaaXd?=
 =?us-ascii?Q?0FoxlJQR1vGx1Iz9+NMQUqp/5Ts84kYZ4k37jAeuM8DIyWRFtiETp3bjUq8j?=
 =?us-ascii?Q?3paY11BTfJBe/q075lM/7noi715SEtsozB5msSmVrjNhj7lHo3yavxIH7cH9?=
 =?us-ascii?Q?ophw8damX2d63ESnkZQVGHRbuDXW2MGMKTd3D7yaaJdtP51EjrYXSxZdZ4yt?=
 =?us-ascii?Q?62tg+ZikBjOEOFxMewspoaCZRnezdmQgYAEhqEaB7oso9GHb1027STRTw+f7?=
 =?us-ascii?Q?yVDWQPzWg+7BYtNU0xgfWb9gv1JzpF++NJ8zYmNY7EvmKKm/Ibshs2bBsxRO?=
 =?us-ascii?Q?J9tvoxZuCkUr3hzglHSUPXSw5pt5hMNPUrHEHE4HUsB80rjEl6k00epEazzJ?=
 =?us-ascii?Q?AJiLprpSrCiN0MsaEFNLmqh924w81/taaKWzpN3iGnOAimvo4ezye0T3DXWg?=
 =?us-ascii?Q?3VlhitXXVHJD8jxS1hkCMMfZHt8n1MRPqcpttmQnb1QWA4POIHaVg+FuhQ7P?=
 =?us-ascii?Q?SCUsuCq1SGiVcOR+vifZhcOm5SYSN1LOCJu8F8F4TLf5qL4sf6quv2k6awK7?=
 =?us-ascii?Q?1HYT8521gOH+jgcHX9wh1LShASnDOmCSSnHBm112ca9Khn9wwLV8XXpDwTgW?=
 =?us-ascii?Q?ZDBeT+eCmGzyVYSo5mfadZqHgLxc7Vbxm6sZXeZBZuIf/RrKRVnMxgwIEuFF?=
 =?us-ascii?Q?Pfd5S0DxZ/eoFbpyZ1XrgngyFFpUzmN1VleG2eQS+b6If69TpN42mFV/Vvbr?=
 =?us-ascii?Q?kdT08CC+CNuUCxdRIZNpmH860GJgSiRK8YbR5c6ArJdm9ZdJHiAaOJmpR6pm?=
 =?us-ascii?Q?sY89I1pdccuJJ28lxXbzcpUpsOmcfieJkhmcLVRmC266MDY8URta6UGSa0qC?=
 =?us-ascii?Q?mHGE0nwDfj61HJS9lXFmq5Zyyja+R1FtJg5CkgyriNuDnBa8ODhLh/L/j07y?=
 =?us-ascii?Q?W26rF/QG155nyGIZLm8bUs6VLxRgJNMGicrlvFbRerX2RhUr6qRXSjdStF8V?=
 =?us-ascii?Q?ax6MGxW7sRUeaNekxuUePAefekayHRrRZS/DLOpVxn5BHY3j0yXxtZQ1iB5G?=
 =?us-ascii?Q?mpZzXy49z2gEWsOvFwaEI1OHF4fk5yPU1LeKloYi5v2XO5gQe0YPnVd7RLCH?=
 =?us-ascii?Q?Va5o7mR8GvSr3MYaN+8EbFuMMXFClqDTQzayL1R0+xQ50081No0FB6HjmETQ?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63C6384E6390CF47AC6FAA75DB492264@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748e0877-4977-4a60-a72c-08daa2ad2419
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 06:29:34.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8ENpzBMmkyk16Uy2KFyjFE03gVvJux0yt32AduIZoik/fzwnexrv+Bb2BChebcVntzVquX3FGYJ20IZvufeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6363
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 29, 2022 at 02:01:06PM +0800, Zorro Lang wrote:
> On Thu, Sep 29, 2022 at 01:19:25PM +0900, Naohiro Aota wrote:
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
>=20
> If this's a regression test case for known fix, we'd better to use:
> _fixed_by_kernel_commit 65ea1b66482f block: add bdev_max_segments (patchs=
et)
>=20
> to remind downstream testers about that known issue.
>=20
> >=20
> > [1] https://lore.kernel.org/linux-btrfs/cover.1657321126.git.naohiro.ao=
ta@wdc.com/
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/zoned        |  11 ++++
> >  tests/btrfs/292     | 136 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/292.out |   2 +
> >  3 files changed, 149 insertions(+)
> >  create mode 100755 tests/btrfs/292
> >  create mode 100644 tests/btrfs/292.out
> >=20
> > diff --git a/common/zoned b/common/zoned
> > index d1bc60f784a1..eed0082a15cf 100644
> > --- a/common/zoned
> > +++ b/common/zoned
> > @@ -15,6 +15,17 @@ _filter_blkzone_report()
> >  	sed -e 's/len/cap/2'
> >  }
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
> > index 000000000000..6cfd6b18c299
> > --- /dev/null
> > +++ b/tests/btrfs/292
> > @@ -0,0 +1,136 @@
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
>=20
> It's not necessary, due to fs specified common file is included automatic=
ally
> by _source_specific_fs() according to $FSTYP.

Yep. I'll drop this.

> > +. ./common/zoned
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs btrfs
> > +_require_scratch
> > +_require_zoned_device "$SCRATCH_DEV"
> > +_require_limited_active_zones "$SCRATCH_DEV"
> > +
> > +_require_command "$BLKZONE_PROG" blkzone
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
>=20
> What kind of indentation do you use? 4 spaces? 2 spaces? or a tab? Althou=
gh that's
> not a big deal, 8 characters width tab is recommended in fstests :)

Ah, I use both vim and emacs and there must be confusing. I'll reformat.

>=20
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
>=20
> If we used background processes, we'd better to deal with them in cleanup=
 time.
> But above two background processes are simple enough, I think you can add=
 a
> "wait" in _cleanup to make sure these backgroud processes are done.
> Or you'd like to remove the "local" for pid1 and pid2, then does below in
> _cleanup:
>=20
> _cleanup()
> {
> 	[ -n "$pid1" ] && kill $pid1
> 	[ -n "$pid2" ] && kill $pid2
> 	wait
> 	...
> }
>=20
> And ...
>=20
> > +    local pid2=3D$!
> > +
> > +    wait $pid1; local ret1=3D$?
>=20
> unset pid1
>=20
> > +    wait $pid2; local ret2=3D$?
>=20
> unset pid2
>=20
> At here

Sure. I'll take this. Thank you.

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
>=20
> The $status is 1 at the beginning of each case, and we set it to 0 at the=
 end
> of each case. If a test case _fail exit in the middle, then status keep b=
e 1.
> For your case, I think you don't need to touch the $status, you _fail dir=
ectly
> if anyone *worktout* returns failure. Or just let the "${work} failed" ou=
tput
> breaks the golden image(.out) to cause a test failure (no matter the stat=
us=3D0/1).
>=20
> > +
> > +# success, all done
> > +if [ $status -eq 0 ]; then
> > +    echo "Silence is golden"
> > +fi
>=20
> You can output "Silence is golden" at here directly, due to this case exp=
ect
> that "Silence".

Ah, yes. I tried to run as many tests as possible, even if one test
fails. But, I now think it's not much worthwhile. I'll just _fail any
failed work.

> I'm not the best reviewer for a zoned&btrfs related case, so I tried to r=
eview
> from fstests side. I saw Johannes Thumshirn <johannes.thumshirn@wdc.com> =
has
> given you a RVB last time, I think you can keep that as a review from btr=
fs and
> zbd side (except he has more review points now).

Well, I forgot to add the tag. Thanks.

> Thanks,
> Zorro
>=20
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
