Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6482254A748
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 05:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiFNDB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 23:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354604AbiFNDBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 23:01:45 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39619036
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655175618; x=1686711618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s1aLdcSXLroDxL+OnxxD8yDfdTKl74O58CtakUIitZs=;
  b=bRaA59/eE+I7ixB4c6jnKsWQCLIYZb/FgGHiJOgjRAeXb3kKqZUQZbDJ
   2TXUDF56GiaPulPWhumr60eEM5RBP7bUw554Ssirq34WURKM0i7LnUGdt
   zq/9ADKHx/EZmnHEF4+cEt+aFKzOYqQpWnDrFICG8Wh4wuHC9scB17fUO
   WlLdBXg9dvmDNTbZfWG2a/U38jfyfaRpSk5zLg0A+aKFgmIKvQUxN3oC9
   BWPgYwbTxglDkRRFev6DHSjbmhLaBJFeAFG0UKg5M4s5a+XCW9wLgF26Z
   sEUod/mrIVLJbp4X1Spx+RpFcviyTS9KP4Pf+rpX4TyP5S19RsJLzN3/s
   w==;
X-IronPort-AV: E=Sophos;i="5.91,298,1647273600"; 
   d="scan'208";a="203824397"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 11:00:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYoD7njZyx6XB0n02sjcUosm+Ty/YU58p0Wj04QL1UKRA6ws13alvMbvyazepKzALoDCBpqKV+IEhf2xzckqcw1PmZQ/Bg4SGmYvj/bVDbbUc5ZbcDpALLDL/JY2ikWKQbyPoqBMvEEzpHNCF6HHivwHDqs/clWT3j3cmkcNy/925OnKW1jsfQwXOm4hq9okGzNg+kJcWFltVBK7YbLA+DBFHARz4yKlfNZpuZTpjEVErpBmbhFQJcUjPijUaLVlslxEcd23EsZuRk5ZsV+i+S4ko6eA7Uw5kzakL8Oe69XTMm+koLCyuBlW17edR0C6nBL7ous5A4jAugEC1ZWA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hu0sIOh0Pn6OZI4YcNJr2PNR9OmNX1TngI1FJDHwAI=;
 b=QpuNd8iZxH+x5iEdApJyN4iMX1RGOFp+F74ywew7fZqpEATMGXFoHBmLRFr+tJKKQJZhAs3wDwqCwoxwN8bAzJ7tVi7hxzArRswWmAtnh5jd76FM3fsO+Vih4MMnSYgpXod12Oq4JH3Z56q0ZqwgeuSiAaFQd2vdlTljK78g/y4LTnU24W6yMsi+T0DRiYKJOkfg45pYY4RrVdz//DuJGpPbNL66ItEuzWt0O0oVk0jVAY0S5/0F/AJCCALfAjMPDWDLOe+SZujrdhgYf8XmOtyzNkeylNMkGXQcTOV9LnWQ/QDiryVuVgEiMDPU14CwvhMVdQeplHo6+3cXXCWX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hu0sIOh0Pn6OZI4YcNJr2PNR9OmNX1TngI1FJDHwAI=;
 b=FIp5U/CHy63HqL7fOAKnq8t0UqdOvEK64yWtLI+rfH/nELy3RfPNqSEZEQfLNibnkcdEJIsIeakOW31ErMopYK8LbIeBU6E2yype9eMUHVSElaAPz49XVK0unI+7hzh2/5H2FVkkvxfdX189ORC6PAQJxRHYsHwZlp6YHfb7Dhg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL0PR04MB4819.namprd04.prod.outlook.com (2603:10b6:208:4f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 03:00:08 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 03:00:08 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Topic: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Index: AQHX79OicLLdJYq/w0OUjXttGMYXaK0nK+QAgCc0lQCAADWvAIAAv+EA
Date:   Tue, 14 Jun 2022 03:00:07 +0000
Message-ID: <20220614030004.kp5pu6mp2wxoy5qy@naota-xeon>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
 <PH0PR04MB741660777362929B7E3D11DB9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220519133850.GA2735952@falcondesktop>
 <20220613122110.6pg6q274wy4er7ri@naota-xeon>
 <20220613153318.GA3829367@falcondesktop>
In-Reply-To: <20220613153318.GA3829367@falcondesktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a09a78d1-5028-4bb2-3896-08da4db1fd47
x-ms-traffictypediagnostic: BL0PR04MB4819:EE_
x-microsoft-antispam-prvs: <BL0PR04MB481946FFAAD3753EA7B771118CAA9@BL0PR04MB4819.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XYt1XWjHHY010rmkmeAVrpan73UYKHgFKy+ZBQVPZIj6xlsNih+s1ui0HGdA/o5gsVLnxpqA5WxRmqysDWoh8+Q5xZURpYI5Fd0tdUN2/iz+mpWSgI9GExIODL3+eqZ3C1t9iK/0uEzbwBnJWHSG1LNw2KVg9NhCbWCv1ZpzsLZXHxfHmHVBmbb/SI3tjt1pzFY9Gyk//XJnGEc8GkufeqgW1u2rfNLDWMIb+VvXTSfGN30W+gHj5ZG4qUrkgTMc5Qp33OTec/5Gn7sornMiiZA20bgINNAoXNhjn8VGgVSMSqwlWPu+hVycsdHPhr32Ve4Zj5YPiz2H4eghFBfdYndNoFZP37/J+4BWm9Bux9tcfKxbvN3nK154YSpO+DabpDoGeJb0XW/Zre0pIzI68KqStTBXnFisc22Z5j7cqpNdox6sw0jvYc2BFjdOp0L/LplkzJM4LwDj6QrWctRVJu/clcFM9EpIN+nfXKPlRE09TKGYyZH3Lq1Buj+j9sA6F7klJF2+XgtBGcYp3nCor0+x1zanPKZgElXxAhu+FZPH6mKomfmbKb/btee5PTKJWz1cCcUwVZDMdt7tPo0nDWKiukIlIpD0heIBzIHxKoBJLJgC3b4Y19gp/zL5d3WSU6d6eIxkVT4LikL9IsrmFcWqnxhkW6dHOtnEYlTm6e5GZ+mZ8ZAz3Vvs/2ZqalIRmFScpB19BxFFOlTMieR8L+Lhyhn7vpBPgsAIkAst+2KjtWW7Ms8WKLj6Jf21jpNnImN6VwZfgsHb5TuYwKBJdxWvUIaJZQJmXmfHXy0lHc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(76116006)(66476007)(66946007)(66556008)(6506007)(54906003)(53546011)(86362001)(8936002)(6916009)(966005)(316002)(71200400001)(83380400001)(8676002)(64756008)(4326008)(66446008)(91956017)(508600001)(186003)(122000001)(38070700005)(5660300002)(2906002)(82960400001)(1076003)(6512007)(26005)(9686003)(38100700002)(33716001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A01cX2o5mXpwlm2rGrrkbO32pHCEO68iFQU8/NCxrc7ghDQfvGKdGkBEe6ND?=
 =?us-ascii?Q?1E59qEFQJZxkWftg2o8BOhCRU1UtbHt82UTwrCDw9kcwmhuCbeB5hvKFAi8g?=
 =?us-ascii?Q?B8fYNl4IiEVKrfwQ4tHaA0TCii9MT3hBAipin6eWIB+xh6mijmDtqOLcPH0r?=
 =?us-ascii?Q?E2HwepeaCt+qg4jUW3Pc8DffzNbHXDp4XWmbl+yIE1/7XJPJK+PwVBM6igru?=
 =?us-ascii?Q?dG7x1yP9pyj1NkX36BeNugXoHg4026ysvWf+cCu4EmWd62BHmhRQe7ftPTOe?=
 =?us-ascii?Q?t+pj57YgNHtemERTkANIHIJZKG6gF/rArx4Os1+gh8KKcneP7ZYvtNJJcyDn?=
 =?us-ascii?Q?1bP/ipnLcKM98OAki6vnDVZYbltZj/pDX9WQaMlh04PrGUWYTvW+LU7rUAyn?=
 =?us-ascii?Q?NWXl5wCFJtMfRALtIdxR/mmmUfY39jFgIo9+sModlag2B+9KCv+uFHWo+C7N?=
 =?us-ascii?Q?4ArOCeH2xIvseBF8CVN5r8EHJG0WjjgI1yiaXKi1v5KhvzlyeojCfcpXjI7D?=
 =?us-ascii?Q?EZ79gKb0fM4BggB/3cH1M5+8qq5tUmXLdMAYxmQ/xOTccL7LOxJclBlKSdJ9?=
 =?us-ascii?Q?7fnKZAVf4swKqogWeWrBhCtIccLDJAcKIKWf2UMsa28W/3RVK/BGKLWAzwAZ?=
 =?us-ascii?Q?iXKrDVs1IHmFbxPjiWj0r7A9MlM85RI4+2KGklja8gtfB5EWm3xli52jq5TG?=
 =?us-ascii?Q?kaji3vZe0jswTt/8G5Yzu336priNHcyD3ilaL0bVSwVPrjyhCNKr0PiAIbbp?=
 =?us-ascii?Q?Fnt5VjZZb+5nXU3TKVoXXKhfVpDOUcvHDCWoYBQilPbSN+xMy+51uZR2Yg6s?=
 =?us-ascii?Q?MGzoAbkCYOn44qd5e4nlLqk/mOW3LE/R8xYuT2Qrb5ALp1DyPQ7Q1mjFr6He?=
 =?us-ascii?Q?jyJ1013MTiHLRHRWI52jL4rgGnM5ArL+d16FUgVgXDCKynlR7zTJ7Y+XpzMX?=
 =?us-ascii?Q?l59595soJprcTZ1Osh1krwoDaEmRzxGg/zcfAtsubslNqpl3l5NkQmjZaJsP?=
 =?us-ascii?Q?s548fpYYojtoWz8lwjU0OVe8msPT3UqYckO18C5DH+UhH4k3lCh3u7Viii6T?=
 =?us-ascii?Q?02yvoAx7qwX5XnSTvG2mYs8zMwIqcrn2NFWoFKRgECNJrNXsYaUFLEspoANF?=
 =?us-ascii?Q?6o8xA93gCqoWW1QtJJPl4J1PJHchr6xG0lYgl8lOdlLoyxZOi7+RsZgc5Ktr?=
 =?us-ascii?Q?imxl5wx5+Z/7+DGVyME0J0ExoHveYJgSwu+kI37L7sJczeYv9dlXKf6JXK54?=
 =?us-ascii?Q?ybKIMOdHluBmw6lmb9TAZ00rRbfLtljOc0C5c+LO0E2jJxJMesvc9TfBie5i?=
 =?us-ascii?Q?1k1Wup5vWaHnehPXPVjKtmLhexSniz6qwV4YYGbNh2QJBePRMHD8yQlPXx/1?=
 =?us-ascii?Q?RwDl6zWpZY93MVDAY0Z4uN3Tq8w32P/QXWSK3bOs8DGSBFxpaHPyoVkqe9U6?=
 =?us-ascii?Q?tdUmIQCQSX9P2/7OukzrBrWA2eXLN63yPrk0GjqUhw1YKeB5gxeQmgUeBec5?=
 =?us-ascii?Q?VkQVUKr346Pdz+DTK8IIHEzbyqlTav6DlcxpLcOfJkqKMSKFFuEO2NSK7/yR?=
 =?us-ascii?Q?beYFA/I/2luP1GNWthBuWyYX3I8u9z+4UNJ9eKrnYxOAksPV/k8Ni9fkhStU?=
 =?us-ascii?Q?q4QK/1wkyvTtblij5l+ec2rmYjNkz6sl8DokoDotzjZeavEhaXeI3/0Lyi6m?=
 =?us-ascii?Q?v/dYIqCrHwqujW56iDPRE6wZ8HLYCFJPISsZ48BpxiSvD91NTGGDUQBIymv4?=
 =?us-ascii?Q?3wiJ1MrWY0rFlyHVuiPphcoVWLQOSpk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC4DFB64D875354DB9F52DC9AE63A6A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09a78d1-5028-4bb2-3896-08da4db1fd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 03:00:07.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CFSsUWUpEcVXE1qmLSDfobLphBBv5PK1yqnLmi6OJa9w5HJyqors/2h6RdmSWsHfYt9o4oJYDsnJ2D6sXg18A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4819
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 04:33:18PM +0100, Filipe Manana wrote:
> On Mon, Jun 13, 2022 at 12:21:11PM +0000, Naohiro Aota wrote:
> > On Thu, May 19, 2022 at 02:38:50PM +0100, Filipe Manana wrote:
> > > On Thu, May 19, 2022 at 12:24:00PM +0000, Johannes Thumshirn wrote:
> > > > What's the status of this patch? It fixes actual errors=20
> > > > (hung_tasks) for me.
> > >=20
> > > Well, there was previous review about it, and nothing was addressed i=
n the
> > > meanwhile.
> > >=20
> > > It may happen to fix the hang for some test case for fstests on zoned=
 mode.
> > > But there's a fundamental problem with the error handling as Josef po=
inted
> > > before - this is an existing problem, and not a problem with this pat=
ch or
> > > exclusive to zoned mode.
> > >=20
> > > The problem is if we fail on the second iteration of the while loop, =
when
> > > reserving an extent for example, we leave the loop and with an ordere=
d
> > > extent created in the previous iteration, and return an error to the =
caller.
> > > After that we end up never submitting a bio for that ordered extent's=
 range,
> > > which means we end up with an ordered extent that will never be compl=
eted.
> > > So something like an fsync after that will hang forever for example, =
or
> > > anything else calling btrfs_wait_ordered_range().
> >=20
> > I'm recently revisiting this patch and I think this is not true. The
> > ordered extents instantiated in the previous loops (before an error by
> > btrfs_reserve_extent) are then cleaned up by
> > btrfs_cleanup_ordered_extents() calling in btrfs_run_delalloc_range(), =
no?
> > So, btrfs_wait_ordered_range() never hang for the ordered extents.
>=20
> You are right, we are doing the proper cleanup of ordered extents.
> I missed that we had this function btrfs_cleanup_ordered_extents() that i=
s
> run for all delalloc cases. In older days we had that only for the error
> path of direct IO writes, but it was later refactored and added for the
> dealloc cases too. And I had the very old days in my mind, sorry.
>=20
> >=20
> > Well, there is a path not calling btrfs_cleanup_ordered_extents(), whic=
h is
> > submit_uncompressed_range(). So, this path needs to call it.
>=20
> Sounds right.
>=20
> >=20
> > Or should we do the clean-up within cow_file_range()? It is more
> > understandable to clean the extents where it is created in the error
> > case. But then, run_delalloc_nocow() should also clean the ordered exte=
nts
> > created by itself (BTRFS_ORDERED_PREALLOC or BTRFS_ORDERED_NOCOW extent=
s).
>=20
> I think it's fine as it is.
> In case it confuses someone, we could just leave a comment at cow_file_ra=
nge(),
> etc, telling we do cleanup of previously created ordered extents at
> btrfs_run_delalloc_range().
>=20
>=20
> >=20
> > > So on error we need to go through previously created ordered extents,=
 set
> > > the IOERR flag on them, complete them to wake up any waiters and remo=
ve it,
> > > which also takes care or adding the reserved extent back to the free =
space
> > > cache/tree.
> >=20
> > I think this is exactly done by btrfs_cleanup_ordered_extents() +
> > end_extent_writepage() in __extent_writepage(). No?
> >=20
> > So, in the end, we just need to unlock the pages except locked_page in =
the
> > error case.
>=20
> So I'm back to my initial review, where everything seems fine except for
> the small mistake in the comment.

Thank you for confirming. I'll send a new version with comment fixed+added
and fixes for extent_clear_unlock_delalloc argument.

>=20
> Thanks.
>=20
> >=20
> > >=20
> > >=20
> > > >=20
> > > > On 13/12/2021 04:43, Naohiro Aota wrote:
> > > > > There is a hung_task report regarding page lock on zoned btrfs li=
ke below.
> > > > >=20
> > > > > https://github.com/naota/linux/issues/59
> > > > >=20
> > > > > [  726.328648] INFO: task rocksdb:high0:11085 blocked for more th=
an 241 seconds.
> > > > > [  726.329839]       Not tainted 5.16.0-rc1+ #1
> > > > > [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> > > > > [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085=
 ppid: 11082 flags:0x00000000
> > > > > [  726.331608] Call Trace:
> > > > > [  726.331611]  <TASK>
> > > > > [  726.331614]  __schedule+0x2e5/0x9d0
> > > > > [  726.331622]  schedule+0x58/0xd0
> > > > > [  726.331626]  io_schedule+0x3f/0x70
> > > > > [  726.331629]  __folio_lock+0x125/0x200
> > > > > [  726.331634]  ? find_get_entries+0x1bc/0x240
> > > > > [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> > > > > [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> > > > > [  726.331649]  truncate_inode_pages_final+0x44/0x50
> > > > > [  726.331653]  btrfs_evict_inode+0x67/0x480
> > > > > [  726.331658]  evict+0xd0/0x180
> > > > > [  726.331661]  iput+0x13f/0x200
> > > > > [  726.331664]  do_unlinkat+0x1c0/0x2b0
> > > > > [  726.331668]  __x64_sys_unlink+0x23/0x30
> > > > > [  726.331670]  do_syscall_64+0x3b/0xc0
> > > > > [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > [  726.331677] RIP: 0033:0x7fb9490a171b
> > > > > [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000057
> > > > > [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0=
0007fb9490a171b
> > > > > [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 0=
0007fb94400d300
> > > > > [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0=
000000000000000
> > > > > [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 0=
0007fb943ffb000
> > > > > [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 0=
0007fb943ffd260
> > > > > [  726.331693]  </TASK>
> > > > >=20
> > > > > While we debug the issue, we found running fstests generic/551 on=
 5GB
> > > > > non-zoned null_blk device in the emulated zoned mode also had a
> > > > > similar hung issue.
> > > > >=20
> > > > > The hang occurs when cow_file_range() fails in the middle of
> > > > > allocation. cow_file_range() called from do_allocation_zoned() ca=
n
> > > > > split the give region ([start, end]) for allocation depending on
> > > > > current block group usages. When btrfs can allocate bytes for one=
 part
> > > > > of the split regions but fails for the other region (e.g. because=
 of
> > > > > -ENOSPC), we return the error leaving the pages in the succeeded =
regions
> > > > > locked. Technically, this occurs only when @unlock =3D=3D 0. Othe=
rwise, we
> > > > > unlock the pages in an allocated region after creating an ordered
> > > > > extent.
> > > > >=20
> > > > > Theoretically, the same issue can happen on
> > > > > submit_uncompressed_range(). However, I could not make it happen =
even
> > > > > if I modified the code to go always through
> > > > > submit_uncompressed_range().
> > > > >=20
> > > > > Considering the callers of cow_file_range(unlock=3D0) won't write=
 out
> > > > > the pages, we can unlock the pages on error exit from
> > > > > cow_file_range(). So, we can ensure all the pages except @locked_=
page
> > > > > are unlocked on error case.
> > > > >=20
> > > > > In summary, cow_file_range now behaves like this:
> > > > >=20
> > > > > - page_started =3D=3D 1 (return value)
> > > > >   - All the pages are unlocked. IO is started.
> > > > > - unlock =3D=3D 0
> > > > >   - All the pages except @locked_page are unlocked in any case
> > > > > - unlock =3D=3D 1
> > > > >   - On success, all the pages are locked for writing out them
> > > > >   - On failure, all the pages except @locked_page are unlocked
> > > > > =
