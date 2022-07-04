Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B7564EF8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiGDHrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiGDHq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:46:58 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B63E9FC2
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656920816; x=1688456816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tvTM//J95ZipLXLDpwiJIfaU+R7izl2v9/mqvBqXlB8=;
  b=cm9RxAp4ZyNcNtvdSTnfPk+ArUes6yYC5G8eMSkJymG9xylt5PmyT1fX
   9j/kII7wB94nTkUzYGU70R9/4QgFKvhOphsA/zOvUyXzam+Xo4rGeVuUY
   UGepFbt7fMUn36DUWVugKPw9ldgxSZevDlvuPQn/41SKLO0GdUjamcFcN
   syb+1lWsu/1NeNZgNOfPR7CsyU0+4NZZzlRxSrqJzxFaQyFgOcX5C7Qtj
   CjVsSYJ9gJE96slpb23Zs8/Es9WXVtBPW+OtqsDEVZC4KnuPP9deoJkT7
   cn6cDYDWC1V6Hu0GhagVhlyrGhg5KNSejM91t90xe1e9CPDu4aXTB672O
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="309067768"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:46:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMpXDMb7Hgoe8XlRT8XQ7PjZ0ecgRbIyuRp0mUQILNomXtEp2GgU3ZhZQ//tmkYwAB9eq6/UAM+n3nKMN9oJWl1Fog7VRFP/ymsn3iOZRpb8M1/dD74zi/WOWoEWgKRoaN7HmOySmEdwiaGnK/mGD2PW03Xm8nx8OAT0usTryf9KUo2E7ME9gFj7aV3yyf6mf94CFmx9N+lsJj7r2Gvq2cxn2C/GJude2G+nemLmJTrXm2Lo7+/Bfy86IOm19wnb4W/EoOx1EFaOETRKH1ne5nOGK5dD/aBa3+tGdKQ/hqbgyoFIVNcaA7wbnypDnaHHxZNc0ah37OrBHqbd2uZ0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUZYppZ8+cH4+EVYcnJVBnI1bp5glzE4LHQ7B49BmgU=;
 b=a8YuYc6jlzgVEgzDqbe2LifzMnn9wA+xrv+7+eBWi6Ivbrq+3HMCTHI4uwyXo6/27oLl+jO3UvmxTEqWpZjvpbxSrY/nhJwYess7SppK0qARhs4UMXAwE9At+fC7aE6aQpWZjxTtesrnUW2t9KOTTHT7YJH9P+SonfPp6tSGXMAHyLIM3wvwOitJKOVU8jVGMAh0OekBnwNnMPMl2LVVgPzG9DwvNJKR75BpbRb07LEQkYrWydsgzUojO8q8jaYYGK7ymZIrK4WkJGEN+FzMKsv78uw3BbmUjuLsNu5Vs16YmIw5ot/+QhlAssA2jd3NL+B6lmAtGaCebir9c4r7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUZYppZ8+cH4+EVYcnJVBnI1bp5glzE4LHQ7B49BmgU=;
 b=SWgRcrDCx0/GR9lKaEzNUITGovsEyzmxjqlx+tFkqcrsrFEJfpBpG/UWu3uKJ1/CbHmSldh+Dyub5KChZSHBfdWYCwUU5GP9RDq6jvIeFbta0qaPGAb3DfOIS49cltbJ3J6tZTwnXJloOp1IFltXVQ+ZaADQnw0sj60gwwCcSgE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CY4PR0401MB3522.namprd04.prod.outlook.com (2603:10b6:910:8e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 07:46:53 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:46:53 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/13] btrfs: replace BTRFS_MAX_EXTENT_SIZE with
 fs_info->max_extent_size
Thread-Topic: [PATCH 03/13] btrfs: replace BTRFS_MAX_EXTENT_SIZE with
 fs_info->max_extent_size
Thread-Index: AQHYj2LCh4gmpzgcZUqtwbnSHsGnN61t1a0A
Date:   Mon, 4 Jul 2022 07:46:53 +0000
Message-ID: <20220704074652.73gulahctvvyyk7k@naota-xeon>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <128758fed168a54587c5a0902216aff0e6a72131.1656909695.git.naohiro.aota@wdc.com>
 <PH0PR04MB7416C5E6911C2EC0F7FEDF139BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416C5E6911C2EC0F7FEDF139BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6e123f7-745c-4e22-0ada-08da5d915ce2
x-ms-traffictypediagnostic: CY4PR0401MB3522:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTctZHSORfU+0pdnMYAAWxmi+H3sLXwtHnIcig8o2S1n9z8ehAvw5XxEkCGrmTKGLk3B2y6GI3KxJxPC4NBvJp/YgjvQ2hcshtrxB9LWoOGYvR0s6F6eGKfejjAlJjG4ddyL5sqF8iEiB0J1zbgzO0i9NlqIv+bST2a7q6XdZ0DZzFGASwVJrJdQKRzAKiINsifPfBt3ZCTJYgFGy5OzfSePebtSiJw98oKV2En2jTI+jqa2/SFsGcLdyVKG/8jaTBUJzShD+K/YnmpEVKypBdQ/vcgNtTrVZ69zkf+JhRahoMPwsI6AmDpGUIhfOBkKyRWA/m8/7UedmY9G99dqDZH6aA147XglqwIkLLe63kHwrzH0Px3e6SbXg1I1omPIq8gtoJQM42pAhCfHRwNmXM3Nl2gREDW+EvBJdXbqVpzCH8jVR95dIOrSHk8lVi4e9TgESpeRJfgI22O8+HpCE97h/Kt0cXieaj+DA+nFUyzn+urGarmsqD5wZeYRgwHjJP9kqJ5kuD+B9Zndakqsh9mw/SaZOGNcJrJg/k4B3ZzKC2nynQsI4c0JuI9GbcwuR8qmLBWnwvHrKajwxgshPhSn/iAv+BI0WIOzBb7j12gyhXyA1A5hS92FMsT0e815zZ3aNCuoqnxeTBYvfo89hjMOE+tFzYFqtYCdwPtRKPWfY9yAnDA13h4oUf8bXYPCJ79eeuzShtsd2farMSy4+xmPDkgNsWHNKB5Z9Xh/G88FZQU+797nJkUgSwh6omblhFYhBQbE0QVw+kICICB+OtfCEUNByiSCqQ4aiumGPD0/t4+bRxhI1Mj0cvoYhC1H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(346002)(376002)(366004)(136003)(71200400001)(122000001)(4326008)(66446008)(66556008)(66476007)(38100700002)(64756008)(86362001)(316002)(8676002)(6636002)(2906002)(82960400001)(91956017)(41300700001)(38070700005)(76116006)(26005)(186003)(8936002)(5660300002)(83380400001)(66946007)(6862004)(6486002)(6512007)(1076003)(33716001)(53546011)(9686003)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9gHSw8WxVCzqbkljWe8UX2kL+qw/Qx6we+8gZij9lOGPObspHAaddw5H+y7u?=
 =?us-ascii?Q?Fba1AfLsD3WC3Lfqq9Fu8rJ/LqM/z9lrBkyTvhDvBV6LhSfuCBotsT/KVCrX?=
 =?us-ascii?Q?AxvC+Dfbjq4yiWUC2gH6WCvipUuekwc4QYYXOCgNqV7mCg2nlZqiV4sj+GQ9?=
 =?us-ascii?Q?SPN5VY5bWbnkHBMH5CGxCHA+mQf/xR9QcrCoo8D5e0s4I4sH829gEZqAYHwG?=
 =?us-ascii?Q?G6EWKp1Jc9J3R2ahsejF6ZjANpKuOqKxaqzMy2zdEdRplIOyI46YftXcKFW0?=
 =?us-ascii?Q?ET7L48Y1Bz0p2kDNTfNrrae3YOM5vY6v+kaI6enOsdJpCvro1InCa4+7N3mm?=
 =?us-ascii?Q?Osu+fPwo2sTZG0+ouS4+JfdpTHAcsbL4bzDqnMvGUKgA2op8tgxoftmm3gso?=
 =?us-ascii?Q?5bRH9mtUq5suzq3lq/wh8sNOHuTbl6CtZXevrGLnQ+SzdUW1eEOfKJi8TA4Z?=
 =?us-ascii?Q?Woa8piP0nq3VezWyN2773MGd3pXaiam1juwujK+nl8cQt5oQDNl1bDsyFK8H?=
 =?us-ascii?Q?oRux4t1PpvOrYau0StNwDP62nhl9iEKseRZO4JtejcTNmUeDLRsjD3/46OR4?=
 =?us-ascii?Q?81M+8RX+5hpXhE9G9d8yRwh7Zc9asGTp5pGL5x51s9oKyhi5vleAWte3nECY?=
 =?us-ascii?Q?mOB8nbonR156NH+sR+6h5U3LWGRc8JQT8LGwFxwKZSqMGSHvk3eJrEm9gvT7?=
 =?us-ascii?Q?sabgf4BKO6ig91cxJceaWtCjb7bKLiqNrRrzj8DKZrMkbzafbeIZXLODWjtT?=
 =?us-ascii?Q?xqvioCGb58E7RKxJIMJFjBXiYA0QI82mvbVLqt4DkxaKRc0Svr3d/RjAeC41?=
 =?us-ascii?Q?nudA+ClFBpbYt5DpiOqXum+FfF+iVK9D3UOYqzmm0zEoORqU91eMEtS47REv?=
 =?us-ascii?Q?tkhlY3yUiWV79eTKmTCuoZGJ+LgvDLUSVG5/lFp6UYZKmrJNvScrpk9PUiOp?=
 =?us-ascii?Q?W+sT3I2KzVtaFhzPqKx8I9QEN49lP/eq2eNSXIDjmdZYrAuEIIt23FsILnag?=
 =?us-ascii?Q?FRn07sP6ASzwI7sIWCTwaHpuAeRqSORDDHZNcF2n1285/D6LE7GSRqxMXZYH?=
 =?us-ascii?Q?MK2BgBp5yYhj4cMZ2lll8TsydNbYm68IyJk/6JSDDaW1HyBZih7gCwau2vQB?=
 =?us-ascii?Q?+BIfWvPujJsl5S+yodrXc0HjaElmDAwfzfbd8poxBIiw8iEc2MOTD3sI8QHp?=
 =?us-ascii?Q?E7sVVvkcbsrW5W/nEUZDQ9KwW7o2kdbT0fxnG8qBuuI0JCw56fIVfPSZETB2?=
 =?us-ascii?Q?wjzkZssDXcd8OREdYCEn8aVZmz3qqAiqqy2M4E4kUfZrNpXhKiCDKGn23RI/?=
 =?us-ascii?Q?p8OtY0oME+Tzxk+MtNu5nSHQpV/6hLkfOLH8w4xuuEraQvH5irwK7PhGxcDN?=
 =?us-ascii?Q?0l10H76eCSH9lgCskqd1Sax2phs4vuUhQlzwxFZj6bcqdiRB0ehYIpR6O+bJ?=
 =?us-ascii?Q?rp6F4HAa1IVjc6VdxtMYezYIDWDzOS39xE9vYA1bo4GVTAAXXjZAUyqvuAo/?=
 =?us-ascii?Q?0IcCE1JzSu55FAO1vONQH11EsDIHMeQ/S0rjDsZxfnrfWaoppBTNGvIeHl8T?=
 =?us-ascii?Q?08gTyfLSES0B92IjVCBf7JwACoEIIgY1iwykHEFpiE9N6uPwoBuY691TsrA0?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88ECDB3E8C2EB34F9FBA50FAEFFD4655@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e123f7-745c-4e22-0ada-08da5d915ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:46:53.5836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Icc24HhriEPYWXJVV4XIcrFLzmFGH7y1CFf8ixuUwqYtp++XD53KVHALuP7lPKouRa18Ks5L+jC06Lu03aydfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3522
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 07:02:57AM +0000, Johannes Thumshirn wrote:
> On 04.07.22 06:59, Naohiro Aota wrote:
> >  fs/btrfs/ctree.h     | 3 +++
> >  fs/btrfs/disk-io.c   | 2 ++
> >  fs/btrfs/extent_io.c | 3 ++-
> >  fs/btrfs/inode.c     | 6 ++++--
> >  fs/btrfs/zoned.c     | 2 ++
> >  5 files changed, 13 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index e4879912c475..fca253bdb4b8 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -1056,6 +1056,9 @@ struct btrfs_fs_info {
> >  	u32 csums_per_leaf;
> >  	u32 stripesize;
> > =20
> > +	/* Maximum size of an extent. BTRFS_MAX_EXTENT_SIZE on regular btrfs.=
 */
> > +	u64 max_extent_size;
> > +
> >  	/* Block groups and devices containing active swapfiles. */
> >  	spinlock_t swapfile_pins_lock;
> >  	struct rb_root swapfile_pins;
>=20
> Shouldn't count_max_extens() use fs_info->max_extent_size instead of=20
> BTRFS_MAX_EXTENT_SIZE as well?
>=20
>=20
> IIRC I did do a similar patch once as well, which then didn't get merged
> for different reasons and count_max_extens() needed to be converted as we=
ll.

That is done in patch 04. I split the patches because using
fs_info->max_extent_size in count_max_extents() require the argument
change, and I think it looks good to have them separated.

But, squashing them might be OK.=
