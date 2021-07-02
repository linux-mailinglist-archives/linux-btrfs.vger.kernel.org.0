Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7123BA0F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGBNMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 09:12:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56938 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhGBNMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 09:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625231375; x=1656767375;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bisVPcyLyFTM9rTv7kbobIqzqfZBXi0I0eikMrkb68k=;
  b=KIBTHHEKLjoodd7T/tSWjTA76YX5iSoLs8oo1eHTj0mydnnECHW5MrU8
   ssqX9TDfuX+3ZibC3CXyq7YIkQaPr4l4RIyxdGN+qzYK4YBS0cfma3Dn4
   1aqRdAOfBwbllgfbX5s0PuPGfSyWgyjeXMs/+qaLDepZCwZYwkyHPOikV
   3uMIMn8p/5Cq1RUHFmA0op6F+qMAzeYfjIUHl4jxfpfdpD4a3hLfE8F7t
   tyN131Ugq9ssTLV024MPJHlbiBijlVOIqGzmC3w/cnrCeRb2wrnkhqOcG
   c9SU6g+67aT9cxvSS7SA1dEUp840l2lk21DnbVA1JZ/2+btExRX1dy8ZW
   Q==;
IronPort-SDR: Kg+QIxVaHnc8KbWv9/cTU6md2WkclBJ2sSthEAecEFZyLMgsGJvcuwec3+wWAlzmXD6fQqOz5S
 yb7DX7CpTzEiGuHkHm9H8oqARBZu1azikDANJSAu2AV3bLtD3IGxjQm59NKcLlvyFDBASKBHy3
 Grr7E0t0piF7BnH0MbAlB9AK8CbW2yjR0soreEhH8wZzTAv5gwwv40ZINbFiOxz4P4EaDxvFv8
 haadC1W9mGgvASID9SCRMDh2AWQ4twIyUSYOyx2FXf5Ayh6Sb+g9/oVlGH6Q1Pp03k4U1jzJ14
 zj8=
X-IronPort-AV: E=Sophos;i="5.83,317,1616428800"; 
   d="scan'208";a="174142259"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2021 21:09:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5otGtZCCQai1Um9xMPsboXOEsvw2tWaoWRPtdEH56w459qCA4gJrUGLw4H/iBd1DIeoeqQ2B4LEgm6U7LSACNd5x9lWZDjjGU8gaQoiTy0hTo6uikx75WT/CeRB9RJPq1J7Q0NOQ7JgVAxwad8WLKZnoOZ/miRfxXzUgCfbzcqAZVBQx/e7xHPPFFAknMIn/GLidCJSG0UW/Y1D2j45G913u0Oo7DV/vIMrRKGbvDPP8tqz7vK+4KrcwWhrm4bM9ad2qavpTvctLRYlVNGoMg1AcrQw2TldEemFCn4b6rNJZjO0QQBvbLFeibrI/tLTSfaU26yM6mNIj8WtG//Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylaDK8p9nTIz3AUY0wCq0un7XZyW3a80hz985j7roXk=;
 b=G8qRMjzZG8grIDWc9tJMfGgbrw2oVJjk1uhlO0xstR9bzmWONAdjzpEYzRr2WtvEw1NbfaTMCfV+K548iU6imDBugC8BUeErbPfOSmC0ngtiHFlJ67mmFd0xK3OgzaLeEM1LLX9SIAv9pU6HTYes5QRg2azMAJ1a3Ybh+wMQTyYXCbPiN2pOmZI1Udu5duQqGdnFKJWkmbAJYsFoYYBtzk1UUJM2TEDW61prarQVbSjdl06jXGeFDCdMpvGp9pV83wm3Q80ZXMpnzklyRGg6kOcn9xJ3AJR8qmyvzHEWvsf8Xh34ru8rXu4q1obCO6MMsah2KkPI5V/dZFy+u8px2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylaDK8p9nTIz3AUY0wCq0un7XZyW3a80hz985j7roXk=;
 b=kY0vQJSzDrbhXHag2U23xF10MLEYpyBuwQ7hCGuJ1uJapRifys5uEwKa1NDeLPMs+hcYA2aweCqaYOMpVCwt4XZmDZ7CvLD2eSLoNPcNfleJxEFCFKaQFZUKP7VFNdwOgl5f5bFbMicWs2etmybeZ/lsbq5kYsCNDQbsC3ZR8dE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Fri, 2 Jul
 2021 13:09:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.033; Fri, 2 Jul 2021
 13:09:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Make btrfs_finish_chunk_alloc private to
 block-group.c
Thread-Topic: [PATCH] btrfs: Make btrfs_finish_chunk_alloc private to
 block-group.c
Thread-Index: AQHXb0CJd8Gq+ksRNk+94Fo+TraMyQ==
Date:   Fri, 2 Jul 2021 13:09:31 +0000
Message-ID: <PH0PR04MB741661FC90F8B379EC1E5AEA9B1F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210702124813.29764-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fb5cced-96b6-43d0-bf64-08d93d5aa1a0
x-ms-traffictypediagnostic: PH0PR04MB7416:
x-microsoft-antispam-prvs: <PH0PR04MB7416B1482563F9EF5A5CC3B69B1F9@PH0PR04MB7416.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mO2BrxoZ4hiNtdQ8JqTbXGu0YZppJCEOZNtD6nv5ts3jMtoyLKaYG9zr3qLIpcnXdqHIFp7LotA9aa6F2NJI5c9h9D1hRiRwgpgr9UjoG0R+ycInz+QE18FidSyzoPW/697DwmvBiRGBFblFx1DfnaLEUm4+twgLgMCB33uMnWE8PwNmuKF0JurY+ewUe692o2jg5a2GMYqzSD1EX9flLcIxC4sgy/eYIJS/2siF6fM3BSZUfnJqLZBEnLtrvF5x2gguLxvs1VBdWHrIe4mW3KtA5TJ0AFCDy+zrDICzcx3uScnbKU4i5LdOmgF909fatUE6VUyYRoHKV4PUcfQW3lbSFtCAchiR5djaS7CRlF6xJqUZpFRo7WrybU36NF361BKKjgRTgFywXKpGkFscVMiMp9+jaQ4O0pysvpOec3kVxDtysP5k8x/HetozmnmmRrOxY1G7GP32pD6fsQasGwe+BhQah2OCy9r0WaECmRGj58Rd3ECk2xIvN/QhG4NI229SnAtzPRy6zN4YrZLfm4tYZOMRzC04eWuSvucbOpNbHTkLizhzDWbFJHYUkab54OtfOOp3UmJdtclzzjCzG+FcTZhwPSGyfxUVIrSW1lV8jQHNv/fIAZ2vEtEtzdkWzWemEJTaK3pRup6VNk4Tmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(2906002)(478600001)(5660300002)(7696005)(8936002)(8676002)(9686003)(316002)(122000001)(110136005)(6506007)(55016002)(38100700002)(53546011)(64756008)(33656002)(52536014)(26005)(66946007)(76116006)(66476007)(66556008)(66446008)(86362001)(83380400001)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eKGf2TqHsKst4yJ7kAoZ3xYHh3wRqrAuae7ym9ytC6eCGcJiWjIZ1j5I7VpR?=
 =?us-ascii?Q?4UmGKujXZVDeyF5Y9d54lOczxqwEl2nQtbmmjqO8A1rUgTYekM6vof4ZnFQl?=
 =?us-ascii?Q?PrhevJ60mzDDZcWatiOQAx14cb9zy6tTbg5HKz5cPXA3evTsrRDJ1YDWF1sn?=
 =?us-ascii?Q?KCYD3nHscg765rTRSSRQdVF+JfhuBm2fxBpnxJlZBlr0oBh5dHka2fZTMxF4?=
 =?us-ascii?Q?uGVHxzo+pK3715MsmwcfofnWDoKZHIWooKxuOuVaR89ZmP8Zfg0ufUkyLgyr?=
 =?us-ascii?Q?V5xCFRd86gvueL08eyabsWPp98A38dNW84SJ0YJL8eNQl2JyoAgkXAEcClEh?=
 =?us-ascii?Q?+RaTEgvsGUi9lVNf58qoC83P+a2EwZJI2GiViQHpAnytIL155BZ7/TdQ6kvE?=
 =?us-ascii?Q?hq+AI0Zy/6qRmvziYdk8iNKjOOzgb69RiT3/apcUpRn+ALJyJ0dhf8WGzrLa?=
 =?us-ascii?Q?cm5o/uKa49nZhc0UZwE2xCD5BQXjXoBUPY4rBMBIR7ggmKg6rFURN6C+ACyn?=
 =?us-ascii?Q?7cPsS15cNYFdRckAUN5NTYt+9KlusaAB3EK9mTVVxWjeK0pNdRHpwvOzj6ky?=
 =?us-ascii?Q?JfIETbEacoBjtw2DdLUKEFFQNUjHmXqOjdL3UTdfE9r3Cf4ZDCI3mV8rDni5?=
 =?us-ascii?Q?VZ/3+bDA9iFQVjkcbzaa7cO7a+JMcFI2FOjujqj9UAfDf+5Hvgrqw67JRm58?=
 =?us-ascii?Q?W4z634ZdOu3DIVgW2S4CKLTnuo6MCVUmAx8ft6Wu7NunozGAGM9WZnWKkv/q?=
 =?us-ascii?Q?rRP6fnf9aLIjCc6pc1Kgw/BOWUYxwUY2658IlEqA5D4RLatnqWueVnvGs+x3?=
 =?us-ascii?Q?fBiHhu0FZxY0G01dvg6+n97WCCLZzj71+k+Fx4Vvy6T6q7zkOyhBk0mFlc3o?=
 =?us-ascii?Q?h3lm36qJTYthH7tU9UAnV1TuPJKzNIkI7kRojJls5/AsEBWGvaQPPapmhoW7?=
 =?us-ascii?Q?vq+lVGDUatoH//+CUkrhgcr+RDzGdz0e35eWhtfPiKbelN9Cy1GlKywUVJZG?=
 =?us-ascii?Q?rzJd8OKv2XmfEZhJzvNBz6uh3VUBY691Ek2gbl5Nw2WZMlgozS5lwedBIKjv?=
 =?us-ascii?Q?q0EBQTBTelmkrBnVpSeMDHXimfz7HcAa87mAEtk3SSTHytHGFrV95PMT9YdB?=
 =?us-ascii?Q?HFJ2+/x87KEB0TYOF0ZfCSqHVIQom8NzGDFE97Qx/1FxAicK2ebk9OgemhPw?=
 =?us-ascii?Q?s5YrObfNvONDxjRH9vUlpsa8jwvLL5rVuCdvPpwinCUsBz2CuFIgL3bqi4L1?=
 =?us-ascii?Q?5HHxCURUKfLEXC9eqCYayUt8aXPiIkzGcIpsT2j1hK8E1AMh+RciL5QgcPwo?=
 =?us-ascii?Q?esq4kaUHOIAbiWAJYEHM1nYzJnmKAGZqbYUWB/2o9ymPLA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb5cced-96b6-43d0-bf64-08d93d5aa1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 13:09:31.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vnWDbSRViKMEWqyHlXSZD2knhvn27Z2d2L/jJeVqaznEAEusdi9TvdXgrjnlgK67+llXiUN1xL2xfmk2xT6oAxOHETxsqsW/LrvRdGO06s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7416
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2021 14:48, Nikolay Borisov wrote:=0A=
> One of the final things that must be done to add a new chunk is=0A=
> allocating its device extents and inserting them in the extent tree.=0A=
> This is currently done in btrfs_finish_chunk_alloc whose name isn't very=
=0A=
> informative. What's more this functino is only used in block-group.c bu  =
                    function ~^                                 but ~^=0A=
=0A=
> is defined as public. There isn't anything special about it that would=0A=
> warrant it being defined in volumes.c.=0A=
> =0A=
> Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to=0A=
> block-group.c, make the former static and it to alloc_chunk_dev_extents.=
=0A=
                                   rename ~^=0A=
=0A=
=0A=
> The new name is a lot more explicit about the purpose of the function.=0A=
> =0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> =0A=
> ---=0A=
>  fs/btrfs/block-group.c | 98 +++++++++++++++++++++++++++++++++++++++++-=
=0A=
>  fs/btrfs/volumes.c     | 92 ---------------------------------------=0A=
>  fs/btrfs/volumes.h     |  2 -=0A=
>  3 files changed, 96 insertions(+), 96 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
> index c557327b4545..2e133ee61d83 100644=0A=
> --- a/fs/btrfs/block-group.c=0A=
> +++ b/fs/btrfs/block-group.c=0A=
> @@ -2236,6 +2236,100 @@ static int insert_block_group_item(struct btrfs_t=
rans_handle *trans,=0A=
>  	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));=0A=
>  }=0A=
>  =0A=
> +=0A=
=0A=
double newline=0A=
=0A=
