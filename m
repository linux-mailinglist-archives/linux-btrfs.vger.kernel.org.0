Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622AF35F3DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350737AbhDNMf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 08:35:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41486 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhDNMfz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 08:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618403744; x=1649939744;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1tCX8tBdfJTM34rbi5L/r9Rohaus0eGVIHrCG5XpBKA=;
  b=iJY5vopyUYBZJ+ZPVM5yBLlEDoox5Uk3e4zIWP9cD+rt+Sgk9WKZ3MJF
   OeolZ4S2WPke+YmYwvLj6dQdJKHHCqZkEvwADDHohFjuSH+19UEyRPx4m
   FTTxkWJ0Q/65KnzcwJ3yIi+z0kfBTkfEZzJjmO8YH36h+9pZllTKGtqkA
   b83/xUElxqtti5NQVTpbutXx/NaZew3LFJjSd0rJ6ozUishNSEgxgNGw1
   Y7Ppzgt/nly0CZB0qa6qRB/rdwVvmWqiZRhUERzF5oOdIrUVwglkC2YjV
   5UkKh6pwN8degjYGmTWzfzYguRjwVf9NATS3GtUvkOaUgnLeVzJb6FrBL
   w==;
IronPort-SDR: 9WKL6LM+Gwji+hQxtUNn9LH1cT4CWFtAdU4QqVaDinCGQ2xJCfXD4L2AHXhxXMWg0cf12B+QFW
 Z+VoPaEQCnq1ksLWyJQQVPqSvrwnNDEdolfuqzhMcIsOmB9h68cSwFQmVrB79In3mROtgkC9Iw
 ad48NWqIHuRpvhrshtKyPpPUm62M2olajpkfwjS2pwb4TUi2fF3ryWth/OZgwP/i6PWoTJZr8j
 CqDE1RQCSvP4J5oxAHu0GYrwicaG9rO3gVK+rYgBENMmQtbvZCCT21miPFVkgBgYGdnPoY00wI
 Dno=
X-IronPort-AV: E=Sophos;i="5.82,222,1613404800"; 
   d="scan'208";a="268916371"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 20:35:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDqIgP1bU6Hw5jWOPFU8i9mbVVUlPBVSD0gueyg3lcF4zKb96FZDAMbN6CJbskz6Cdphg3PUcUE1ElXxBuiV+4VKjZQd67+C2t/IVsc/rn1ZzZKK/nX/O2iNmCJ4PqsnYoLlyvdm9snB/9mjomjAPYVqhuuh0Z3bbyz9eewuiLmFWJ3xkV/u0KxKyE5r6cEJjY/3RdDlZOkbx38T4a3GggBdNWDivFK+W3HR516FX+o+JRQ0lHjVZLU6PrEISS0GEwNIg8yth4JUdz1R+h4Ozw72YXEPzxwgsw1lM4LYTbj9l6BBRUFlq410OybAXpYFKy2E+PP6hKwyqBy1l6LB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt2BEyCLJldzv7aOU3C9b5fINMipL7enqBzq1BnsAq8=;
 b=jMhUCcpE/JlBVg5J3JpCKczrA6atjQWuzVK1WJ1Hl5IWKIctHDXTk20cdZt1wS6gVXVe8nNQ8QC98Vb6L6LdWp56Uilwy8SwsPI897Kvluae7Pm8b5o5XmAsVANBWRoPhV+GHDbovY7Y7RNv1canGZtDLJHYZgB52xdfe6bCv3U7ZHR2B3d7UQkKrM1zgZHH2l5rcTkBkeiGKn8A4nFGVmdYmMzEYh8CfbmPeawZvqPvJxFdkD9elpfjj9sf6JMGi6ALaXMdMAgwpgR6hvYXdphsuX+muDsAyye/P6pvIKxQimjmWc81wR9+Osp8EixgFfHDfiMrs0FldSk8i7lIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt2BEyCLJldzv7aOU3C9b5fINMipL7enqBzq1BnsAq8=;
 b=o5+cX0kx6n3Iz2jyPBAfFY9VhV9S5VC/yNzIzeAxOluiiSBOl8OvmuBTjgng4Cz3BZhf7LFmMVG2MTtN+4oUrbRBwaamBi5QsZRHdXns1RGNI41Oc2ATw0YSXtUBcegADn3/j6Bq66NccbFByJSraClts7cQqyqRTrq8b3Px/c0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7285.namprd04.prod.outlook.com (2603:10b6:510:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 12:34:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 12:34:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix unpaired block group unfreeze during
 device replace
Thread-Topic: [PATCH] btrfs: zoned: fix unpaired block group unfreeze during
 device replace
Thread-Index: AQHXMScITV7B1gHNw0e7zS/I9BavKQ==
Date:   Wed, 14 Apr 2021 12:34:57 +0000
Message-ID: <PH0PR04MB74163160735912B977C1E0C79B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb4017ee-294b-4b5d-d2d9-08d8ff41b66f
x-ms-traffictypediagnostic: PH0PR04MB7285:
x-microsoft-antispam-prvs: <PH0PR04MB728507A8FAAE86DDE226798C9B4E9@PH0PR04MB7285.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CT0BepKxLJBdhI/AglJppm1DEMJHOg+k1mspJIdsUGRxVw7SxkEAECdc+G4yK7zyZJUVmAUkk/3fgUqyorsQOOh4gGvEQZvd/GXTVPnSAepHM6K0ZPoVfJRZ4+uZk7UzPtkq0DbxehIwHgJSvem2V2mWWnq3fSusdGpaz/hHXI5UhDUPu9q2djQFgFRK5lO4N/Mjsgrx7fTYUZmWuHqrcRS/lybcp5WYI51/zE2SnXLyW/9WEXx00I217GxRSBM6sBbluaRJik2ufNFFS5Ci/fvH0iKxWkFbh3ICbyzgJLW9zH44brKfdLjEtHcvgJq+PftclauNEMFZ3NeTtp0hbsGFl9LywNP3xWPG0tnnc34+pQ3ouym43/l3HrM+fm03pGZDOd+sWR4g6qYsv/xA8WeNSlTuHK79/z/EhNK++DaNaO0kj+uGBwePgNiDeLfTzZuqQA0UqgRnFCKx39PklVMLWg8izgG3Fs/Ied3XFsXBojzrX7JypZ8LTFkN/xoI/fKnD5B+DClV/lMWtvic8jNqeEY4btIGG4pkO6eylpq6vCoqzARrlrnpFwVMsRJxSHgUc3IR+9tMFZPMFncxOsbOCGgHC10e2SwiCqMOTnw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(66446008)(66946007)(64756008)(66556008)(8936002)(122000001)(66476007)(186003)(83380400001)(53546011)(86362001)(6506007)(316002)(26005)(76116006)(478600001)(38100700002)(8676002)(110136005)(71200400001)(33656002)(2906002)(5660300002)(52536014)(7696005)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?939OWAqmFA0gY5D1662qfn2NsAssSuVAlYU148R6JXghZJyY7IDbpX+tVcF6?=
 =?us-ascii?Q?6SQ/p3JyUGQOA/1KjY/yQKqy4nU7n2vR1AlHGaw32bZU/47oYiAZgbdi6cS0?=
 =?us-ascii?Q?Tg3MzxcquwnX4BAgw9D6xRnOcKmGH+bwQYZUybQaXPFtQ2616hp81Ysbo5Ov?=
 =?us-ascii?Q?JwXfk9Yr1bb3LrLnHHx2QG6S7eXkKvkXVXBeyxewat9G8NWxWZU5N7vK1dCI?=
 =?us-ascii?Q?9lrSHVQrOXxhFR/4fJQ4XtPqY+j2gPUFL/C3Zh1gc/ZKomWa70gjq+ZNNkse?=
 =?us-ascii?Q?GwaOZgsVFMem4payLK8SR7rmEoMSrvQ4irh9a/BSgBdZzPjcmTRvuF2xJoX9?=
 =?us-ascii?Q?TWGjq9FW69RQwqZZrPSJ+LTklFJayFnzkVt8FxAME4UsVixZXHItelGlJN1z?=
 =?us-ascii?Q?wYIfE/BbzNScjaWl15ctt4it5KUo98WI3uXgUuFUd5hxCWxl0E2WM/VErOt7?=
 =?us-ascii?Q?Qw1qz283CzUxjCbmgGeXwzRB5hGuYzv2Xn5+Cd82Ryt1a2XLwwGIdkgW/TnF?=
 =?us-ascii?Q?prKzmCCpPWPzpIZuWEXs+Wa4F+s1lVuQVavyDiGlN38lv6e6k8WPMshW78mE?=
 =?us-ascii?Q?TNW1K1q3npvOEfhN6nbyyemKuUfawWTN2ICcqH1ouyN/ntEtekWu4NQC5fYR?=
 =?us-ascii?Q?ZwBSKFjLlTcrnORI6isbh9zuiMm6qn8HvtwWBzc8xIHFQVKsp44MjlqKg7VE?=
 =?us-ascii?Q?ReRlDTfB1U/eXiKDkX0NaFg4Qbd2lYONIQffzFyDdltTd1Oq2ZQu40w0vQcS?=
 =?us-ascii?Q?CuMGnaXDasK/pQBFKlIA8qVmvR/rwTd0CAZ2z89sK55ygXghwoIdF/GulKcN?=
 =?us-ascii?Q?F3ZtaQ2UM3FeX2Rs5mHD2wmqgW9RMxvlXzmt850cLTJ1PJdWDCHEl9rwpC4r?=
 =?us-ascii?Q?0gmS2sJBM2hwNdft8V6Vk2cZHhhAebTvTlj2UXVg0iPQRHI6PXyX6PoPOOC5?=
 =?us-ascii?Q?PDpfytWOlT3JghOAhfivo3IqYndcJPJ/hd58NGSwvLNLh30nl//PwUouulD4?=
 =?us-ascii?Q?Bcj3Dx6w9jzyZSz3KRRWXBJ31o+sldOcc8vAkyZ7fz+qOAmWO8tYAIx6SHW5?=
 =?us-ascii?Q?irjjoa713JPen/jWzQyhDR9jTTNTeUzbqmwgPrYwwwWFcQ7xTRLDkb4bhfqn?=
 =?us-ascii?Q?OcuaxESSlEN2IxyoVYB2vRtAHcOz34LW0Gfi1t5L4+B/ukDV9fLdsUsd14fS?=
 =?us-ascii?Q?dy42ipfsNZsWMIhyK8XMRnMGkxcCeySp91ii12YgJCBn5b+H86OQ4YxXKPAi?=
 =?us-ascii?Q?3coo0mxM5EslzOrCJFIQMMErO6fqC/G1ZN550Vzw9Zl4OK6VALAIJaO9HbDN?=
 =?us-ascii?Q?jeY9RI50Jtug6y9UhvPyMSAuimsMjBYOwLCata1jKChd3g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4017ee-294b-4b5d-d2d9-08d8ff41b66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 12:34:57.0210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YEwW5+Np35cASWBtfS5TmTRNQ9/hJHsPgwk1h0bWtkTzZ3sRNZ2++sfua9bsV1DdSqjq/PyseQUwIEgbw2bwIc7Sy8rgS+gPFozp0FuEIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7285
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/04/2021 14:09, fdmanana@kernel.org wrote:=0A=
> From: Filipe Manana <fdmanana@suse.com>=0A=
> =0A=
> When doing a device replace on a zoned filesystem, if we find a block=0A=
> group with ->to_copy =3D=3D 0, we jump to the label 'done', which will re=
sult=0A=
> in later calling btrfs_unfreeze_block_group(), even though at this point=
=0A=
> we never called btrfs_freeze_block_group().=0A=
> =0A=
> Since at this point we have neither turned the block group to RO mode nor=
=0A=
> made any progress, we don't need to jump to the label 'done'. So fix this=
=0A=
> by jumping instead to the label 'skip' and dropping our reference on the=
=0A=
> block group before the jump.=0A=
> =0A=
> Fixes: 78ce9fc269af6e ("btrfs: zoned: mark block groups to copy for devic=
e-replace")=0A=
> Signed-off-by: Filipe Manana <fdmanana@suse.com>=0A=
> ---=0A=
>  fs/btrfs/scrub.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c=0A=
> index 17e49caad1f9..e0d54ed9acee 100644=0A=
> --- a/fs/btrfs/scrub.c=0A=
> +++ b/fs/btrfs/scrub.c=0A=
> @@ -3674,8 +3674,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,=
=0A=
>  			spin_lock(&cache->lock);=0A=
>  			if (!cache->to_copy) {=0A=
>  				spin_unlock(&cache->lock);=0A=
> -				ro_set =3D 0;=0A=
> -				goto done;=0A=
> +				btrfs_put_block_group(cache);=0A=
> +				goto skip;=0A=
>  			}=0A=
>  			spin_unlock(&cache->lock);=0A=
>  		}=0A=
> =0A=
=0A=
I think we can remove the 'done' label as well, as after this patch it is=
=0A=
unused (at least on my clone of misc-next).=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
