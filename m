Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AB5F04C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiI3GWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 02:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiI3GWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 02:22:07 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFF140F02;
        Thu, 29 Sep 2022 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664518922; x=1696054922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vnFbx/AAoTqmTA3kwkdgMbgFUhblFcFkfgbmYrV0ZXI=;
  b=btFKqy8McbyKLeWuVN8AmmfyQVBGbUNrCLVvSYqw0QsnzMBnRzD9y3tM
   c02PTluDpnhXl7tEvWjLwA31h76rhQd9h394i3FZWv0m/P2PGiD6nEqji
   6DsskUtasSgxY/PcAQXPV04/lqXhZGsuB0DA0Qk9PWF/cGNwsmaARFzQu
   /8ezuNtA+sGFFftPXesSCQU1EAEQa4Q214gHdu21bDjme1X5HZdL/nfYe
   HWkbIbxm7YABHlq+Zcre91JhzbxZXy/vutxJ6kouAzP/sJuCSYxlsoD+l
   WS4YAUIq6nwsVBvKbLd78dArM1yQrixhAATpYM4FRxq5M6kgRB+ajMD+y
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654531200"; 
   d="scan'208";a="217826614"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2022 14:22:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6aHhjGsCYj/AnlP5XDIXtgIlhcLfenJOij6ZE3IxKhnCcFr1AJ4CUMIubgaYqABH5ll9jXLPc6YzfPw3Assu98YDyWaTce95JceDM9bz5KjlPXUDark9oslK7n2jvw1zchBCPHdmlKi2Ea8RCNDKXvfbGcYJuU4YFhTNNESeuiSJILQjJqLCD4ljt8/ol3WlECiHm5oP6ZtyqrqPT3asdcBndDpSwW25cbRtcqlugHlHIcyqNQJdaikF6ahXDFLXco9SgOFq/ESw1SBT0LqRNjWVQIc+7VCV8GWFLPM/tOcyIanUl8hQDAKuVEpV0NpqIURqCdKojuObqwOU5q6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN80pJnQa+lj19XlxZ0nLJpGQ7m/JvbcDicJNJ4bMWE=;
 b=JXgOaxxGv0WYj2Vhd6R0kCAIQwA0ScZnlb44IoHW5OD5u3e9jCcHLDf87vWYlNFw14mgHt4jT6cHU4Lde8xAzk4WWwxeffoROsI6GB78BaDtMKLuhwAd2D1HG8m3rvwv8PrG6u1SeSvs1Plk0CUKFKQ2L2rO92eZj/A0wGXDLNJhycGZfigWVEeKipzAIWP4H/w3Dy0n44W7oeZ82mJHqU0mSlev71j2nA0vD12aZ1W6eov/89IeFP6AIb6lnUpEQppu9O6iLTO0JCpTma1W/74sWUHeBpi0fAdTjMt3fnIEZwicZhrQpVPTL+K+mU447fDdM1eQLh9qKGqPPievuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN80pJnQa+lj19XlxZ0nLJpGQ7m/JvbcDicJNJ4bMWE=;
 b=UDVoMuOjIRZrQKrybd22klN+372hbDNdMn5Upcur7YaHF7H43Ope6WjxLzbtvp/kB0LwzueKLJsLQHqivaZBWxNJP1wqNVLPu+odoXPhBXhU8jWb1SWOS7Ngw5ONUjLrTB3iWx83nfijLxF8A5OPUaVstQNOdTC+tz146jaaxRE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6153.namprd04.prod.outlook.com (2603:10b6:5:12a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 06:21:59 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da%9]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 06:21:59 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     David Sterba <dsterba@suse.cz>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] btrfs: test active zone tracking
Thread-Topic: [PATCH v2 2/2] btrfs: test active zone tracking
Thread-Index: AQHY07qyD3LBbxjtY0mgx3OrQubj26316kQAgABlZACAACIbAIABEKoA
Date:   Fri, 30 Sep 2022 06:21:59 +0000
Message-ID: <20220930062158.r32ivibgda6umvar@naota-xeon>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <7390d3a918ce574d5349d31ab26fed0ae79952a9.1664419525.git.naohiro.aota@wdc.com>
 <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
 <20220929120400.GG13389@twin.jikos.cz>
 <20220929140604.phlru3cjcqfsbsr2@zlang-mailbox>
In-Reply-To: <20220929140604.phlru3cjcqfsbsr2@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6153:EE_
x-ms-office365-filtering-correlation-id: 6d89197c-55a9-4a6f-7a24-08daa2ac1500
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRzFHJjz5429+btfdbYkhCavcPxrmJKmKz1GkgDmlHBcvCv72GEg5EsO2U4O1zY64kHimWBC9j2cjacm73GlGOVfTjbbHYV3MG1HCXQx6KFjULItjT5CJt6XFc8gc87w3XS9k9yV7RJGOfOC7aUv0wP/4IlsAqnKLf7huXBbVFnIBA9anyMOxHjlZlXpE/5OJBjA3RGAFLyC0XLtSA69/pF8SpDFG4nY1Ki0Glx2F60vPqj/cNwl6pQdqQ332AT5MYwaHjfKhVV4lZgITPZ59CjVYlT1FaHk8YRSbGOAAqeEl5bWVeksL5qekaQnJJsxq5GiAfKVk2qvBL1rjWcahbfP+zDasE4ymYFbSz2rCl8eL+NAhG9rNzrCDileEUHEVL1JfTXDvigdz8IEhK9aTV5jYr1Kg0/MJZ6SohMklaw+dfH8HQeO8bP1G6TitLnhx6JYuasCIb5vwlN9iKhBKgSqZln0U1TFgSKrcQURTWKnZ5UGQ0UZbC0i8rXLqe4nV+wCY2RpYJFM4LE+UKHYCOePz56jdkQULmlKziNJLY3Tiy42y8ZjrKYHSKD5fG0R5Gvkd1wbrJOa06nm9ckNVw22A4VVBA6vRXNRnTL9vPts6QfzU0OVoeCGHUeL39niPm7RCSbb7r29jVd1IkdBKRtO0djuvjEH4b8TC+89tWjZ784p/oyOP3L1/hYFtf1cEf4ZQGtyHknkkrfTaPCLfmYqxhr7paHcZwMe2JCwtJgfurnQHd5RcFDcLalnAZSn5kL4zy55j4NUR7U1iO2CVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(71200400001)(6486002)(66446008)(2906002)(4326008)(6506007)(316002)(478600001)(54906003)(38070700005)(82960400001)(38100700002)(8676002)(76116006)(66946007)(33716001)(64756008)(91956017)(66556008)(86362001)(41300700001)(8936002)(6916009)(5660300002)(122000001)(83380400001)(66899015)(186003)(1076003)(6512007)(9686003)(66476007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XbHIQB5dkV6P0Viv4HhQSNCrVMXn845eMBalaxpEE6li9NytHi94/oR8jCHC?=
 =?us-ascii?Q?8s/URNv81lH7Y+VxA2OKHsgCUVTJ8Fpe/+lzNX6F/Y4xLxZmNhVKdnuzC360?=
 =?us-ascii?Q?PAzX+LzKiDf2Z5fjuDJuBWJdUOuA4GAb7VDstoZw+HIAg3ctdgMZz9tFcuwL?=
 =?us-ascii?Q?7OtRLqGbw8Z0b0iUOQUBv8uTRgVEVZUoGFI6AEzAytJ3p/0Cpy7U+Bxdnoup?=
 =?us-ascii?Q?64dpnuyttwRyvhNmtw7DuiU9xsffGXnt1M4TRpyKsM7H5gnGK8m+JZgr8alA?=
 =?us-ascii?Q?IgiFGDu91eOVsCOmcZ/ClX1G6jBSPGdqP5kwTPoNLgWM6tZD6LmEJ4huqZRW?=
 =?us-ascii?Q?bnu++SNcgOtfaxoyuqS8s351TAnR3kskxhewwUqVuhqfiqtwf5LSjjq7+xEN?=
 =?us-ascii?Q?rDaYcOdn2rOBhR/DyUOUdW+PHGknxDUhTQpU0i4BGEKuIN4UIv2HSr1RDrWD?=
 =?us-ascii?Q?QyF8V/wYnOqzCencH+LLa7FFgEXEWoQQ3/CTt2m279KzbOQVi34KhV9ht7mU?=
 =?us-ascii?Q?0g1V3paNobDBVhIEh36442alnDUtNZdnt7306gNEmiIYt6rDDz1+0ANJT5h9?=
 =?us-ascii?Q?LZInp80urs1pGE8qnl6ZZJDccCYNLemM+XzcA2sMbUC1sF625j2O0g+/McdA?=
 =?us-ascii?Q?fCSZe5egIocghZN5DPmj2ZuwL9mSWi2aYDN/FhZ6/pTCEMQlMJfJCjIVSX6h?=
 =?us-ascii?Q?XXrg/HlKYsI7DurKn6/SpiBGP5H9I4lc9+xBmo6EGekit6AGOtb8q3SliFWN?=
 =?us-ascii?Q?XuH8SAXStqaGKC2YYX5MwJsKNTnPK/GvCwc8DFhwH0UN9yidXOIy+y1d+ScK?=
 =?us-ascii?Q?fTZA0stPkbPFwN98cyKyw64JyR3LljqZ3y/OfKNPP9T9Lbw+j4p13EgRAbBR?=
 =?us-ascii?Q?AiyTKI+P76BbNVaC6/0U+WulXmYYz31MAASdFWEy+wbLd3v+EjN4lZCl1Bf4?=
 =?us-ascii?Q?AIkNxV5DOOvNfzGas5AZnHzV5O45rpZDPGc4nwvctJO4qQCz89zCzqn6XTbJ?=
 =?us-ascii?Q?J+KGlp3FNQbN8dYBvHD+U9ygNUiTxzubtQFdWpy9zDY54fIvKmxGJECznhr0?=
 =?us-ascii?Q?9zmW6/NJuPxNUKOn1mxUEsWAbBFG6mAd2OLYgJopYaPiMGCxld5XoYzk97Xx?=
 =?us-ascii?Q?yhkz3kZcSl6KrLbRTdFEA7ZrQJZD9HylHVeEApGe2yWvzfmCA3DG9CUxckw0?=
 =?us-ascii?Q?yVC7ShEye0rdzDx9gAkub5bLgnYbZDr1HooFMEqYPVz5g68S42gw9WwLwWEJ?=
 =?us-ascii?Q?UA9okT0qyPzF4sHCvPr4ZTbL+viinEqzedp5RU/Z0N3YJkPf2+WaJ9yxcHI5?=
 =?us-ascii?Q?4pfbCU3WBdlHB26zDPk1uOQvGglefJjfinjSFB+FKD+bmkursLl170RU8qLW?=
 =?us-ascii?Q?mPWvFpViI+fTIAz5S3Yn70cm8jHwKqSG/mkxAm3BrvIICxG1gs5JXMPc2XrT?=
 =?us-ascii?Q?Zox8YBsg50XIrAVSkgJhNr2Jgb6iDBiSN5DcN5a5eedISRHKvliSLOPptl/2?=
 =?us-ascii?Q?L9YWk5Ytvrj/b/+2Q1dRBuKnDGdJP8XjfnWW3HN+XKLnDciRjWYMN6UCNz2m?=
 =?us-ascii?Q?Gw1eshebBzqFrSeW/nGGGPiHpX8UNc+Mt1rEhJWHAxb2t/EJFeOe30tYirSf?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54558CBFCA5E5742BC85B54A8C20C4F9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d89197c-55a9-4a6f-7a24-08daa2ac1500
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 06:21:59.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2qixM9UorAd8EEJyupMuc88RdXX+zrqWDwPad02pkcKNJ78ABIvFvcSOKWaEwK+rT9wGkLFNnVG0WitNlxBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6153
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 29, 2022 at 10:06:04PM +0800, Zorro Lang wrote:
> On Thu, Sep 29, 2022 at 02:04:00PM +0200, David Sterba wrote:
> > On Thu, Sep 29, 2022 at 02:01:06PM +0800, Zorro Lang wrote:
> > > On Thu, Sep 29, 2022 at 01:19:25PM +0900, Naohiro Aota wrote:
> > > > A ZNS device limits the number of active zones, which is the number=
 of
> > > > zones can be written at the same time. To deal with the limit, btrf=
s's
> > > > zoned mode tracks which zone (corresponds to a block group on the S=
INGLE
> > > > profile) is active, and finish a zone if necessary.
> > > >=20
> > > > This test checks if the active zone tracking and the finishing of z=
ones
> > > > works properly. First, it fills <number of max active zones> zones
> > > > mostly. And, run some data/metadata stress workload to force btrfs =
to use a
> > > > new zone.
> > > >=20
> > > > This test fails on an older kernel (e.g, 5.18.2) like below.
> > > >=20
> > > > btrfs/292
> > > > [failed, exit status 1]- output mismatch (see /host/btrfs/292.out.b=
ad)
> > > >     --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
> > > >     +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
> > > >     @@ -1,2 +1,5 @@
> > > >      QA output created by 292
> > > >     -Silence is golden
> > > >     +stress_data_bgs failed
> > > >     +stress_data_bgs_2 failed
> > > >     +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scrat=
ch/snap825'
> > > >     +(see /host/btrfs/292.full for details)
> > > >     ...
> > > >     (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs=
/292.out.bad'  to see the entire diff)
> > > >=20
> > > > The failure is fixed with a series "btrfs: zoned: fix active zone t=
racking
> > > > issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_m=
ax_segments()
> > > > helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finishe=
d when
> > > > allocation didn't progress")).
> > >=20
> > > If this's a regression test case for known fix, we'd better to use:
> > > _fixed_by_kernel_commit 65ea1b66482f block: add bdev_max_segments (pa=
tchset)
> >=20
> > This is very misleading as the commit only adds a helper that's used in
> > later commits. If anything, the last commit in the series should be
> > mentioned.
>=20
> Sure, I just gave an example, you learned about that patchset more than m=
e, so
> feel free to pick up a proper commit and description :)

Indeed. I'll use the last commit here.

> >=20
> =
