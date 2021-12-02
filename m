Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DDE466429
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 13:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbhLBM6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 07:58:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6246 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhLBM6x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 07:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638449729; x=1669985729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zvt/EOHHgVqlm03fBnEmn/yruqgfCX3vqLGdQIhpH10=;
  b=XZShQVU3hNr+9uhzdoCJIoOoUOAxGc1NfBTsm2FfE1p6JVI4OoqEIwV7
   Te7DI2B+cazrWIJ/Q6OszNa1fa0rDNddrRToUiVLvMA3/noRohMLn8Ulk
   uEiNHxhEgAsE1uaca3dZDrhnPGFCNBsCFxRpv972f/xC+mpihOtGlfqS9
   yCPfsqist8moaSHUrmzNdmy+kLWmK1GtV+MSHg4zmuBA0bEoeDx6wwadE
   KtMF/qQi3TEtAGLGR6LbmxTpJ4soaFW/DHkAtSa7YXxTPKPJ5OPK4O1vv
   VuPc565K0oNN8GHWN6g3I22FOEyjY1iLPx3kpTr22TkebvsZknlFK5jPP
   A==;
X-IronPort-AV: E=Sophos;i="5.87,282,1631548800"; 
   d="scan'208";a="192062964"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 20:55:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHrtfrzN3lEqTTLEzDUanEGmkyX4ftqp3G4rQqZBCzmCTTtpzVvyvTHTYzX2XCbWCJnF81rPWf7KEA0TWQI403awYfJQdmaBt166h6rM0497QRVtiPnphcsQMIi/aGGYg15V/YnXoeyZh7F2WeBo2fzXpYQTcBnf/FUFSW+4y6XxDzcyWqzA0Hocc8p1NYYeQSY8frAJPYmkHQdmwR024vnn/9IPpYhLGv/yWl/i9ylhpULQKd944ShAeK734Hi3AoyqSjudIRGU3EaeFYz9Ihz5l4ptp/G9vwWUvGPKYa7Mro1P1OCc5VJMwCQbDuHwKwYoUvXFJ9MKnn7++LsR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA5QsMRzWR+N892FMNmI5eFFF80MfJ24bsXglVgnhXQ=;
 b=hvuReLgsCa/xawKU4mzg8rwUgWzHFuf6OfDY+puKw0OHaqmFW/eSPlmzUT6O4aJErKccmP5QoRMI3mPETiB2SX+OPUaBsDPYy49LAOn0mJeND7jBPLpwaZ5HGjEdUAxLdcDTkUfNpNzxcc3x6FNXFn36iZqoYWxOZPKZiFXJA47CPgJ7Rg5nq1UGAsigypG7YJcpQJAhNlkL12K4sDbAWGNkG+umRg310vYpwA7vQ+l09/xrooPmmHWVz+uRfWNE4UepI/dgf8KQnXydh85+lAMH9zoE8HJsyRAD10gsV1qZ4dB7jjSmuo6/r8IeUATP4I1ib9DugtYUYwFlKtOaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA5QsMRzWR+N892FMNmI5eFFF80MfJ24bsXglVgnhXQ=;
 b=aW8YrUTE1eA0tVUGLQpVF+GcCfy0a6bf/8nNos27pEy2c0W96bw8NaNopk2afWy9a2urzRna/ad/txpkHuE1ttKbMzwIKTHN9Ex9/4mt+Fx+zrgsxmS/bkasksd0cnTC2FPqEfTnX7gRcixDcNPTnA3PtTjfU6EAuy6xmKB8/UU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7790.namprd04.prod.outlook.com (2603:10b6:a03:303::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 12:55:29 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca%8]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 12:55:29 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: clear data relocation bg on zone finish
Thread-Topic: [PATCH] btrfs: zoned: clear data relocation bg on zone finish
Thread-Index: AQHX51k8PAWCEs/r4Um5mNhjG/pZpqwfKRAA
Date:   Thu, 2 Dec 2021 12:55:29 +0000
Message-ID: <20211202125528.zrf67bgdp4ugwerm@naota-xeon>
References: <50bfb0a3d3bedc7038f2e1926c95aa71a3260e75.1638434808.git.johannes.thumshirn@wdc.com>
In-Reply-To: <50bfb0a3d3bedc7038f2e1926c95aa71a3260e75.1638434808.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85a1584e-5388-4bf1-9a1e-08d9b59304ac
x-ms-traffictypediagnostic: SJ0PR04MB7790:
x-microsoft-antispam-prvs: <SJ0PR04MB7790CDA0960EA4C22CD9F5618C699@SJ0PR04MB7790.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8zf4bnfCWUli9TtUsyLvg7CAoG+AHHr0LSFougMFgdQjCUQaSVTwbRiycFIQAfwd8QcqDTyXXPln8YEyW+VaHQwYUx5uRCB0GNnNH9aJGjRETdk22fhWQMAHutGixxs095o2SnR8M8jqt6brKMUY8kVpvMnFMQ4y79HKDjMtmKxXXF+z8UBo5kyqk2HXcuHl9verQHxYLiYLvyAGlmQ2kQsJrp0L6LpzLgcz/+0FwebKFH6G/E9KPBBOCqi6fWhq4SrU8Ts2oA7dROjRQY4QL0QIpWeYR0MK4RoLwsldbBcLjZ6BQqqIeRRgxb5hWv+jO1eIYd1+eV6YkE0IJw8VEf5eWrJEr875OtvXewrY1+6ZrDa7ClirFNCgXff/Zk9EhsYbANASzCSJZhNL4PtP1W+FnkX33Tw0mcyXnFo8u5tfC9gqHgWsqYcvAkVTzJMtyJotxJHcGT0mM1pE4rHDhnmeOPeHQaIpghAbz0HihqkQEm5vzge0XiIt2THliLG1jcWr9RmlyjElM+zN7+BSQAu9T7z7h0f7Xg13/0DFEYTkw9gxHe+diEagBVf+/Et8t33VmsTHi7dUOkCsoLyNu1xfN01MUSn2eYCf/hjVCeUEiIrOH9BximnsmgEqhtgohll6EH7k6mbrb9bXhqy8wXHoo9GH7WOGzn9eLgD7patcuGRs6eiyZi6tlIt1hLY/0xDekPtp6tIRPL4wwD1dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(6512007)(82960400001)(66446008)(2906002)(26005)(9686003)(66946007)(66556008)(33716001)(66476007)(64756008)(86362001)(6862004)(508600001)(5660300002)(71200400001)(76116006)(316002)(186003)(8676002)(38070700005)(8936002)(54906003)(122000001)(1076003)(4326008)(91956017)(6486002)(83380400001)(38100700002)(6506007)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5kGs/RMPyWU9UlwMGndzRnIcdE17r8I4et0gd0TNQ3jCFJb1a/ZnRCDfOweA?=
 =?us-ascii?Q?wHq+vLQ1fJF4uoR36wsTFW7rt901hX14v9xjf/RDA0Ut2vW3tg8h7hB1RYrR?=
 =?us-ascii?Q?tiVnolSOrdfTMaZm57zZPuDZXGM4dbrlIcZqgvatvWAJ2lRbUyDNZVsLjApb?=
 =?us-ascii?Q?/FFBz5nC3h1rwgJDW/2+m5lfKYW1ZQsMjjpdevc2BBRWDWF8mOyqbkfTU7VT?=
 =?us-ascii?Q?7o3WXUPD6r68jROJ/QWe/G0xtxTVrXyEzs9DN/slBaPLbXr6IksMYgrnaYJ4?=
 =?us-ascii?Q?vTOpIt+/J/ySiGDitCxIojgZZLM7VOBuy/udAhWZs9gNfyV4VN/TKctmBdOf?=
 =?us-ascii?Q?xQS/U+2nVr/e4k5ph9s2Gb99tEEmnJhKO5NlmViEktuVnKUJZo935sux4pZs?=
 =?us-ascii?Q?/H8t8E8HCgR2kXffghSOGrkDFQjpTxRnXbBVYGATlXfw7UKwbCz5lA2lwxnF?=
 =?us-ascii?Q?v6mCxKSwvRqjEEQuPP1dF8bFTi7Dgdjk4KzXC8LoCIsLejCaLdV0olETgMf0?=
 =?us-ascii?Q?5pyrVSiKVhMBFglllP7VqdZG+E/ZMkeMSv6wawqAUQEFZSFO6K506FSFCRIM?=
 =?us-ascii?Q?G8lYvC4TOxRj1nboFK7Idp7y7CDx2WSoS30gkBe40DKf+JifG8pyIW3exkQe?=
 =?us-ascii?Q?QbFef0/Y1TxnBzoxy2mnrYdSNXZV9PeJGl1d0gra3hHHx6YK19UFtTcPmEXK?=
 =?us-ascii?Q?Gs5I7ZPnH8RePv/JAGjkpF8LKBsZLR7tNQ7HHz56b8JHAkVNYZerkKrepRfV?=
 =?us-ascii?Q?pTOUVA7FMdN0YZPqQcAIoAiVzWqIqkdxxZEJq009jQxXVV+PY1Z5bEEuhle0?=
 =?us-ascii?Q?55F1T7k6SJrymCm2+xfBHFj47xEBAGhw6L0xm04ynUdb6QLgJMPGH9MisNUI?=
 =?us-ascii?Q?DUZUPt2Fx+svHP93e07Ftg2duRp88kCWn8zDB9XT2T6riwDp/tdWUcmO0UCi?=
 =?us-ascii?Q?uYsSct1VxVPPQszfwG4fZYY7Rpt0jhjiSETWmadzMrsqDbgduMOumoieGl+I?=
 =?us-ascii?Q?w9j8W90+numxSvLcniLOWD1g60kyqeD3uFAIu7W8EWJkUu+uc+yYkdZGXJzL?=
 =?us-ascii?Q?aEu052P/Qqb7sFp62/76q7JTdfW7Lztf86QV5N8+9upkgFVHHDqZchPMC/se?=
 =?us-ascii?Q?bCak4+XqYxbNox13F/4iAztoKtPVmqF6mM70N39pq4XuGCIQpTbk5+XmKYq+?=
 =?us-ascii?Q?CysI76RWj6eWIe2LcJkxT5b2Lm0gDUhwKNljF02Cmb4oHRlvYbMhUIE9ew7U?=
 =?us-ascii?Q?EFNkSJ5IXqQUqqs7eHhWh3escyUHH20g972CnZMYwm8G+6SAp3+o/VMkyg4H?=
 =?us-ascii?Q?tqxV7jwCkiK6CDeWkC7jEF/lCo9yFnxh0Gb70/Qlma1uGzhr4Ie9Fdf5iIQl?=
 =?us-ascii?Q?5N+FNhdjUUOae7kkTmlaWXglV20uBZLYdM3v+gUIPaEGCSpPvkh8DIXZew/L?=
 =?us-ascii?Q?VqY+B+KhyVw6D2mjNsWVcT7PUyrFTOOa/+BFkB53iocPSfLsp40EfdYWf4Hp?=
 =?us-ascii?Q?oBxAbAreejXdTNLJemVSVbvWpen0oUIUkAPeYWGJavL8kDlfUA+uqF/xDCl5?=
 =?us-ascii?Q?8imD19HopJbu8v/dO7tUxJYQm73ZkFt+EfzLMBVf6j5Hv/k6pG4EY07XqRF0?=
 =?us-ascii?Q?pVgKdm1YYVIPWEbWc6ZZuMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42884134DD860442A523DCDA4EFABD76@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1584e-5388-4bf1-9a1e-08d9b59304ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 12:55:29.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYaiBj9ShEMrmg8jZiYoJge/EuVeBn56EVQOdY5Tjd8Gj8bT3r0HL3ltcO3o2v8wxjlrhmNCYWZdI767+sfM5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7790
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 12:47:14AM -0800, Johannes Thumshirn wrote:
> When finishing a zone that is used by a dedicated data relocation
> block_group, also remove its reference from fs_info, so we're not trying
> to use a full block_group for allocations during data relocation, which
> will always fail.
>=20
> The result is we're not making any forward progress and end up in a
> deadlock situation.
>=20
> Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good.
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> ---
>  fs/btrfs/zoned.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index c917867a4261..9cdef5e8f6b7 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1915,6 +1915,7 @@ int btrfs_zone_finish(struct btrfs_block_group *blo=
ck_group)
>  	block_group->alloc_offset =3D block_group->zone_capacity;
>  	block_group->free_space_ctl->free_space =3D 0;
>  	btrfs_clear_treelog_bg(block_group);
> +	btrfs_clear_data_reloc_bg(block_group);
>  	spin_unlock(&block_group->lock);
> =20
>  	ret =3D blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> @@ -1997,6 +1998,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *=
fs_info, u64 logical, u64 len
>  	ASSERT(block_group->alloc_offset =3D=3D block_group->zone_capacity);
>  	ASSERT(block_group->free_space_ctl->free_space =3D=3D 0);
>  	btrfs_clear_treelog_bg(block_group);
> +	btrfs_clear_data_reloc_bg(block_group);
>  	spin_unlock(&block_group->lock);
> =20
>  	map =3D block_group->physical_map;
> --=20
> 2.31.1
> =
