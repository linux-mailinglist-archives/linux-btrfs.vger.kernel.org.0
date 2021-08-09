Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92D83E411A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 09:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhHIHvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 03:51:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25345 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhHIHvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 03:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628495460; x=1660031460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X0WvNXPtRfCsz3DGwr/LXxVEl90upCVIYU415X89LYs=;
  b=CbRu1l/ocopGBZX1OCwmGUKLOyvTgz39NVxRX6ARfT1SZytnnsDJr69t
   ei3tmduCbfiZZlqYeWIKl0YE7UYEwhi/+4mTxBwZNyA0qBNf51HScU7gC
   W7Rc4BjYqtrqRIY6fRpfhK2r1zIVYFlHhesLjhexELcVycP8Z72eQOxuF
   GLfYDvgewg2/BGSo/D//JE+l2ehC9DQmOefHl4QCukSuKyJ0qv6YUuY3T
   wEPjSsDk3fEaYWjnl/6MLQgYl5s7RdoZpp9bmwRHbglk5JxBQqAO96Vyd
   KA/gbQkSg3NyyFgY+ZK39HgV35UOD+Uf3BbmgBBBfBecQvT8QYtZo1IyL
   g==;
X-IronPort-AV: E=Sophos;i="5.84,305,1620662400"; 
   d="scan'208";a="176662689"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 15:51:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deEmmqJ+oVGsp4z+ESuZfzs8+pbsCacU09M67oY19oro5hSBggq1dOaWIUmEKqHEwM5GmoFksx0N7SdyvnUGqzSZEPZTS7oVSHN0+OXzRnP0jmWrMnheo7FznJLBTjdwQ+7/HIsnRQv2ZTMjPQID4Y+DzC+K9F4FgHMLsBkhmhA0BRoLVIzqvGTa5pbYhBOTP/4MazgVAnrv5Hq10sTaNCcrWbdzQDHeXa3bx546mATtUOoo1mWeeGkAk6F6awNEgq/3t6dZn4cxSrFWnbSed2pgaPoqyc5v437lZsN/dHwnyPfat6uXEjf8mLWQhLo6jMf5IKz7ETgOVIsNz8q8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlj6JdDhgt3sBltlQNpi5rZS7AcPJROxIPKBoFA2Mgo=;
 b=eFGPJsIo0wdf+ROYs+GP0bHgswKpQPhNt4RrnP9D5ZVz3clnSXtFRcJjd/UCG/C3JCQ2h5LyWXPPSq8rdbSB7u1Pff6Az11CFKegiwsBhSqIdpfMXY5Pm92mYKXNm5p5PJj08F01+Hn98bnFoj7GWTYZlUk/fbUsBgzL5xVxCoCJv+YAeN4Z5oRXVDY1OkW2dLB15Vdqntr95SSUzSa/UxMCmimstU1DIMC8W0+fiHBX7IFcZoMwT+qOXnrcTBRYtE5t7hnkXTbIjNEDtLF9+WNu/1eU1Vpdv6ceIu0fxre0Mz7q4FUeKDPCu4kqhMeChd+ysgfyLph7tgrgD10PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlj6JdDhgt3sBltlQNpi5rZS7AcPJROxIPKBoFA2Mgo=;
 b=zlQdC23XgvVNGS7pdWsGOXuZA63iQuECNB9nrrZ0hZiu73MX7a9BoiwlGyXYDmXjfnxwmi6wRpk3a0Ocf62/S2SH1lB/RmMeqHuf+NDVsBY8ZOGUaJC+L8dCYfXH4BZGvrUVfrccYdtTEZeDJj5zw8ycizsu0kg0GcEncyV2UYU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8391.namprd04.prod.outlook.com (2603:10b6:a03:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 07:50:59 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 07:50:59 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: allow disabling of zone auto relcaim
Thread-Topic: [PATCH] btrfs: zoned: allow disabling of zone auto relcaim
Thread-Index: AQHXiqVASeu1uAQRE0actja7qa11v6tq0UuA
Date:   Mon, 9 Aug 2021 07:50:59 +0000
Message-ID: <20210809075059.odgjmdq4kyu7gyya@naota-xeon>
References: <fc988b42d58cf2e6b0ae2030fe0e67033ce27eca.1628242009.git.johannes.thumshirn@wdc.com>
In-Reply-To: <fc988b42d58cf2e6b0ae2030fe0e67033ce27eca.1628242009.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17f293cb-29e9-44d2-6cab-08d95b0a6dc7
x-ms-traffictypediagnostic: SJ0PR04MB8391:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB8391548D6D6AA29C2CF3E2ED8CF69@SJ0PR04MB8391.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oJfBb3PKY8Bm6dCVsInPBLDQaiBOw9MOaxdJO7V0v282ZLOMNgycFaPaD1nXtwtHoaLu+cILWz+b0S66maS93L1ugsNylEdCRJbQYqNfn88R8xqQcSXPq4z2HLzMzQGLs7Q4bTrewQb/yMUVFkzXNhd6jrhXeqH/lJrTuVJxtFt6/uOue8gH//y6iDWpagWsmPN0V2CgxOHABi5RyCk7HyOdnT7hbbZRSkMJnelp2cNCQw3dG1yIbVU30Bvj4EuOPwXj4Qt0tSOKA/1w551UFxVwHdp6kdCMMk4I5jGY9bSENKbsiaibEBjhJlAyM2q5GtsdF3/bcj1Sfxvk47cpc/SEhyjgh9kDEdmZJqaRyHGoq6snmSyJNXF4z82fmu0pinxt9rDFN1ViBZEQBC2dubqVdAeuFHszHx5IwcucP6GWhDSKY2267GINxY1S0k2sOBwfHL/8/a01J9K9Yx6ikt38gL9wF6evG7w27dIWktxRPUp12ASdAznSEUY2laGgD63VEA/FjDWjSr8MppkvvtBRZJxzvJXc9d8kYA87RO132MoGswZNDj/H9mIHCSkq9gMXeKHmIlniTrP79uBQYCzaOnZZ/ALEINa9TRfjlSaObDnxlc8oaJ6PJ7ylfRs2GjCnaTFA4iAwTh9MZEchy/DVKSZvFWJkDUrasxyUaNnM+scCxFipulLNO+tkRtAVUS007K+wGodp8ZqtZsovg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6636002)(6862004)(38100700002)(71200400001)(2906002)(38070700005)(66446008)(66476007)(66556008)(64756008)(8676002)(316002)(186003)(83380400001)(6506007)(6512007)(26005)(9686003)(76116006)(91956017)(33716001)(66946007)(4326008)(122000001)(54906003)(6486002)(478600001)(86362001)(5660300002)(1076003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WYq9ICT8YdSvtpTLhEOywVwINasx61qEmlk74QE26xLgFrosiPTbMjBw620v?=
 =?us-ascii?Q?RlSnbl6sOLuFT+whjfQA5CbHx0uW+JCgBwDjOkE3iMNW6TrHN/Pax+SnfHWA?=
 =?us-ascii?Q?LYeP8/UmoAX/7wd3OFIoIqp5Q7JmeNCqFoL54/J7jLH+5LFeG60EG6zKcFXN?=
 =?us-ascii?Q?n/cs0YVUH9HnAulkNBMsO47FG+EwbeNFjTS0iALKx2Kr0rOqhDzOe7MDcbjs?=
 =?us-ascii?Q?J6GtoanaBI6/3Z7OOwBFKWffrUuxV4CxbGaRWw7JxXZlETzkz2hkN5f1hBW+?=
 =?us-ascii?Q?KXzBjNLrjzwbtpml1UvAlHagv1tEPWWxQ9FIAL3B3pgcPe8TEqcC2EN14xPI?=
 =?us-ascii?Q?KNm8074pEfHYJLqEsUgYPVAV5HbZCH01dk/Vs2wG+s0Yq7AAg12kFLofvd0m?=
 =?us-ascii?Q?VpRkHNS2Mefx+KNvLlxCdVmxbn/Xqc2au0ZHtK2pnl1P5XlmQaEr24Ktjh03?=
 =?us-ascii?Q?RylOTfZEHkhJShrN417mcrzwFgzjrksaCruB8iWK9iqHxFTSJeZajLBCGb27?=
 =?us-ascii?Q?GI5cFI1jeEKwmwWRhzs2MT1zNPa5RW6+1sRoG8xTvwm7NMGCUpP6o3nZk3nH?=
 =?us-ascii?Q?Hy6ht8bKdWqf4Roui+Tx252NrVX17y4S+Qi/J+/AAujzz7woKd5s77obtQLC?=
 =?us-ascii?Q?htOcTpd5G5rUoCq15k3iYJJtIojzudWeRsYvZNt4lw1jIkcDwEIAPC8MbwXS?=
 =?us-ascii?Q?rKQ075RhDuGDeq3Z2qwI2TZnivRlaUtvrSFXOAuuApTmbLSRJ9jkoA4lZYXk?=
 =?us-ascii?Q?NxFlF0nkQUmTh+JJMisYsTbGp8ozC9fAb3mhEYv+pr8kRHzYl1YK632JI1b9?=
 =?us-ascii?Q?OHWmZynVd6oSNQ0BRihSOv1gxZxS0B2/UlqWoq8+j4q3qPn5H123w12XO6mG?=
 =?us-ascii?Q?kkoWyQKZ7UX0adZyGweEvIkkbVDdOMNUlOw8/kd27XAZ1rDTvTXTCtEO8Zwx?=
 =?us-ascii?Q?3Wn8KmcjPP/vYYUI8ediir1rS5ZMda2ZKWuKe97fIe+O8zYlo6ZdRnxkRAV/?=
 =?us-ascii?Q?2RiBU+VCVMOzEgA4wf8BrPvzB0bR+hH/EZmZY0Kw/xqo7GVPqXUTeeG403EE?=
 =?us-ascii?Q?u6clUZ/XhMQz/cKSkKBLNDpnxZ7pQe66AvNpn9vr0P2yLIKmHTBUFvOOA/yZ?=
 =?us-ascii?Q?lNnwhwtSEcSnD+aPWkl8PoKQs10A+lB7ZeT1ccgZpa3T0MTzifD2alJnCZp0?=
 =?us-ascii?Q?9d/W0U6rMJxq8paOzA1GH/o10kAlGIHW9X/wCFJ7srnz65+RzmbZ2VmMB89o?=
 =?us-ascii?Q?dxE/VTGKsoi+C3/xfcAqIvtzULlAmy89S3R841gJ+scGMts3qNDbAi2kWHaT?=
 =?us-ascii?Q?el6uXg2+iFtcEA/nPp2NC4tX?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06159FBFA937D0429570C7E8A5F087BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f293cb-29e9-44d2-6cab-08d95b0a6dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 07:50:59.8276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjwuRoJO+yEXZ0v7UPqmYdfdTavMf7NkiYxSsW3nZ1fH6fiJUTCTfJ/8WPalBySyJKwSar8TPqCU97II5dhJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8391
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 06, 2021 at 06:27:04PM +0900, Johannes Thumshirn wrote:
> Automatically reclaiming dirty zones might not always be desired for all
> workloads, especially as there are currently still some rough edges with
> the relocation code on zoned filesystems.
>=20
> Allow disabling zone auto reclaim on a per filesystem basis.
>=20
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> ---
>  fs/btrfs/free-space-cache.c | 3 ++-
>  fs/btrfs/sysfs.c            | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 8eeb65278ac0..933e9de37802 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2567,7 +2567,8 @@ static int __btrfs_add_free_space_zoned(struct btrf=
s_block_group *block_group,
>  	/* All the region is now unusable. Mark it as unused and reclaim */
>  	if (block_group->zone_unusable =3D=3D block_group->length) {
>  		btrfs_mark_bg_unused(block_group);
> -	} else if (block_group->zone_unusable >=3D
> +	} else if (fs_info->bg_reclaim_threshold &&
> +		   block_group->zone_unusable >=3D
>  		   div_factor_fine(block_group->length,
>  				   fs_info->bg_reclaim_threshold)) {

nit: can this race with btrfs_bg_reclaim_threshold_store()'s
bg_reclaim_threshold assignment? Then, we can end up doing
div_factor_fine(block_group->length, 0)?

>  		btrfs_mark_bg_to_reclaim(block_group);
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index bfe5e27617b0..5f18c3e3d837 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1001,11 +1001,14 @@ static ssize_t btrfs_bg_reclaim_threshold_store(s=
truct kobject *kobj,
>  	if (ret)
>  		return ret;
> =20
> -	if (thresh <=3D 50 || thresh > 100)
> +	if (thresh !=3D 0 && (thresh <=3D 50 || thresh > 100))
>  		return -EINVAL;
> =20
>  	fs_info->bg_reclaim_threshold =3D thresh;
> =20
> +	if (thresh =3D=3D 0)
> +		btrfs_info(fs_info, "disabling auto reclaim");
> +
>  	return len;
>  }
>  BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
> --=20
> 2.32.0
> =
