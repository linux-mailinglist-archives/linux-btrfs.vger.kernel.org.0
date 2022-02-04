Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58244A94FE
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348405AbiBDITL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 03:19:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61464 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiBDITK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 03:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643962750; x=1675498750;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6OId6ahgpCPVk2uW2cJusQemGoSGgf1KeIHrnp2+dcw=;
  b=qJcQIUitfQwih2a6ac2SHqpkGO296bjKpGaSFaxf7Up/dDOZ9X8fdDOM
   3WjPxTj3slKUkOtEPxNriEI0mjBWfA+genEbn750l1mafS2LTVsSvIIKQ
   Ln8ttLwgSMxAUj1izGkOs52Sjl/pbCzru8DhhlLV61p0Z021NQom5p90l
   RZOifvrPBcbV/gyBp2vUD7LPwXW/zYcuDE6xjQz+gS4ZZKiWl4671XMZJ
   UNVDQ2yP4im3Cgewi0Tn+ughqr0Usj2NOFZiTt7VvHxQFuE5IfEDeEo+S
   ud+Yi9gQHM/krJCQcS6sCI6lCKmYNlRL0DBD7aSEIE6t8bsAO8TKerNQG
   w==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="304056332"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 16:19:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUjYUHUGRmMqPhe/ofn9D4YPgsFa/tHrXTJYlQDSDSugJ6zd9ZuKtG3NxziezP9Kd+F+2XfSjZGvKT7d5eBfWc70XFamoldBUf6oJBDA7ht9Kf+aC5BepPOQotbcDq2EUbLVukYvU3USSvt8D72tKj6xGoIiOeO434OCmfcpYxkVfDFroTjjs5RwXaH21b2ZcL9d5ImkAu03PoYWPL3fpJUsmQ/fi8TpwrI9O+M96JpXpTvHyqsLgKpVxKXJ+q3fWotxekZ05NxI0Jc4TWL74fIm+D8WICJ2C+/54w3Na2qjLBRzU6mAHbXotdGiWr0ObHT8dzX3FjRPYRr+CQZ2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OId6ahgpCPVk2uW2cJusQemGoSGgf1KeIHrnp2+dcw=;
 b=neCmIxuhbYc0It1FgBJTTI3ssAaqqz5KWuVM5zIzSEv29Wv2XK7SAchFp6fiJqztjjgPm1ZMUfbIX9Seaqy6l4ZSbXnSSK///u+gip7TFkS4toOtxSgeZCGwrUdPZLO6Ojpv3r12+Gj1/6vhUIv0GnLgaCOXH/K6Z8B8BHLhbYTJVgJDauEEQ/r4Jp62hrWeHm+hNg1sPzFtHJSykp3plz2s2hALs/1UflcAO1aNx0A79fKN0E8sKDZk64eN8fmD24aUYJA58FGUJdiErcY+4VDUSl9OwRemxVtMDRE3o0oh3NgMzz7Jx7Gp0pJhNcGjP/uuv7i35HCfiyMATX4gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OId6ahgpCPVk2uW2cJusQemGoSGgf1KeIHrnp2+dcw=;
 b=wuprOOI7rtRk6q6u8Sz8m4GVguACDzvc9Rn3MceH0TMDghFOyyeysJbkCyPMk89riqZTeSqr+tN+bRxfqBVrf+SgiruCBAgZIwSXDu2VuMrDjlGcU10Bm6nEmGBTrbN/e9PZkFXvw7zZ3tDk7SWIK52O6MswUZ+ZAV5MF3E9FCw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6746.namprd04.prod.outlook.com (2603:10b6:5:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 08:19:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 08:19:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: stop checking for NULL return from
 btrfs_get_extent()
Thread-Topic: [PATCH 1/4] btrfs: stop checking for NULL return from
 btrfs_get_extent()
Thread-Index: AQHYGRPzuqmIzqVATkyIn+LoVrWHFg==
Date:   Fri, 4 Feb 2022 08:19:08 +0000
Message-ID: <PH0PR04MB74166389066CAEC3C1F84B2F9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1643902108.git.fdmanana@suse.com>
 <4296f624e349be0b08984cb3a5276ab4e693c57b.1643902108.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba9891e-0368-43fc-c23d-08d9e7b70446
x-ms-traffictypediagnostic: DM6PR04MB6746:EE_
x-microsoft-antispam-prvs: <DM6PR04MB6746E38D4D5FD1CCC67103BC9B299@DM6PR04MB6746.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4yuBqyO6sN62xT7Ln9p8MBII4kgVeODVssPFl3boIwE6nDeFCi/SghyOfgs38iA9RHuMRqktmSPHM6G8Gekt+Iq4swe8wG4VjZ40MIK2LmU2mbw+DB12fe3us8pGASXoTVY89huupSy3H6aJueM7qoifbwkZqRm7ozYUAymigw+seOzboSldPJ1Z6oz16UkGnjxcdG2kqLArQIhjVZtxGHynQ9TIVQjy+4ZsDYQDATvB1eASm6oUNFyWuIRhNt29IDsiAEyjP4Q4SWu9inr3/CqSjET7STrMIUjWPtCJTYHsWrb6FjXy/fekDCzQKK3ziHl+ECJCwwXjcsz80+8Dab18zmdz2wg/8KWsgw7mPXS8LuvBMdF2MC1+uHZ0YaipDs/gZ+8pER3NrdMF0V0uFSSpoe6SkhvhIeXggCn5wzkHMfOdh5Zs/AB5pmGNc4A3DmmoaFak+ALTtGvrjF6ZqMkVv1hBDTP3LUGOyQRFZiTT0db/mvZzNclHvTYaJq6y6tRZ/H/nvdZ3vMDpwqUt4YFXoLeCcVy1Hm0DLu/Ntzk7notO1IVfsUDQKhiRbtnmKPurIaoTETskaS10BviH4AUzbKmZfbGZ+xhV3cddDHoQRo0cI17EsYiKxOz09uK+FP0Qxn9KjLZREvnv+XhNfhNBz9iFKRMyiWTrePf+36tt+GHW0HeVx5ehcFmISDVDfeK2ES68Jv/xgMervUfp3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(71200400001)(82960400001)(52536014)(122000001)(33656002)(5660300002)(7696005)(91956017)(2906002)(53546011)(4744005)(9686003)(38070700005)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(316002)(55016003)(8936002)(186003)(86362001)(508600001)(38100700002)(110136005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DziliQnTb4/ikBq4epSJMCZucmacHIKMah5sLWtgiG7FQQUi6gB51EBKeVP3?=
 =?us-ascii?Q?uf7Exq2sWtCdFAkaDn0qqZmFuBntxJFtPeOgBJSQGZO2W0+W8tJq+eUf7Rkm?=
 =?us-ascii?Q?3uMYWspPK9apNWRxjOmGmJjpxr8kD+Vb3nFwBxw/H/ru9BtdAW0k0phs/JEL?=
 =?us-ascii?Q?q0V+wF7rz0DBsoysTZWZhStMcaSNm1DLsC+FsgmvFHGgquE1rbqDTqSEqERv?=
 =?us-ascii?Q?xWxJWlpXcvgtgjElBS+XrcpgbNzJd1aMDa7jLrrkQa2QnWonlLZ66SQy4Jjg?=
 =?us-ascii?Q?f1+fpGVXatXmZjRT5Usb7FAfdDOt/vCN7h6svfAzt6buao7GWqMRn1MZntlx?=
 =?us-ascii?Q?FsrgSROSzTSgW0IRycq1x+qAmtVK4i7xJXsoYshx5sgZ/m0MWmwTXv6uC+j1?=
 =?us-ascii?Q?mVgEZUxoktVDdL2Ucf4DTRWI3BO9ieMkB4rBa9YV86tdTPhJjwRY4vEfEn0E?=
 =?us-ascii?Q?jV9+0bOuEUZ1Dl+0/cWk6ulSDFXAS+mTGL7yfSvbPadvVKV0dk1fpOpd6Cjk?=
 =?us-ascii?Q?iuVgcu6stiz1GqIfFEVvlrJ3WIFGR9VX4Oet4gVxCs+CTbgdIqo5HIZY/94u?=
 =?us-ascii?Q?LHiyW8pEkSuaDsWEvSlBBqMVfqmewFAgQ1WFnnXskVw5oEbkzyVnT6ERseJF?=
 =?us-ascii?Q?MSN1DZITg2AhTtq2elST+ELJ9ry+U7t2HZhP8QvkTGzmKRhrR+4G7y1z/NUP?=
 =?us-ascii?Q?1Jgy/JH/+DRBmxJY/sZbBo1A6r3hPBkC5qIxUbeP1nVsx+hzaT/lIRVDC3z2?=
 =?us-ascii?Q?+Ekgh8AivrejYB4dye47c16bYwqi3btLraD6wpAgLE8G8OhjK4hU/fVbHn6z?=
 =?us-ascii?Q?iFZP6XZOmcSYslzkX2enIleomePgJKYZueC8m4oc2A2AtzZ1KJSNS1kBUfB2?=
 =?us-ascii?Q?HrR2phyZbtOTj9XIJtGrZs5LYs+vzpIDfX3JrvKbt4S+FJEGYlJExXJwmC1q?=
 =?us-ascii?Q?WLhhIY5UctNLN5wwKvy8OwtUoH4z5D/I8VOWAzEvOGI7ZLCBBWfr8+a2eLE8?=
 =?us-ascii?Q?aZqluc9hSjWNGEP0B18XwQEP6rWI/kr4swMZ3dZLwNqKkscGX+0nbHrWqrlg?=
 =?us-ascii?Q?/8yT05995z4Ar+Zt6vVl5o7UIw1OTpUmuT8eDePGsrO+9CtjllLKsJ29Q3fE?=
 =?us-ascii?Q?VmGNpbuSuTa6WRJOCQp+kmdl3VwNcXOhDbCi+dOD+EikTA9QR52XWFGvs4Nr?=
 =?us-ascii?Q?+JC0xak6DfOftZD0KAa7JzLpUCjI81W2w0Aq8hvj+8PRTl88J5FFfjtXcrT0?=
 =?us-ascii?Q?IMYcXVqYyYWA3ZqIPLxHv4aH/LLDc0ktxUmSLERQA3fI/5ypo1b1an8ewKm/?=
 =?us-ascii?Q?Nu8R1/FlkaBqogbVgC8hlQX5ri1eKZGc6xh85stpZv6NSuIxy+UIbPgZDqAe?=
 =?us-ascii?Q?XGoZVa+QHwwMF/MRO2MS/tMAagItXvUKwJGCTPrcYrgBLSSM8BbIz1tqM3ih?=
 =?us-ascii?Q?a9QYROmfTzg7nTZH6meRlwUFQMjcCraCr+O1WIGZsepWuSv+2P2VFExmmzvm?=
 =?us-ascii?Q?nCyzhk4E8sL5V5GC35jPPVTpy+PD0Eyfdz4y492HiXlrcxK0FAeP97PhJrDT?=
 =?us-ascii?Q?yYdDIpFurcE8RWWVjCmoDNYONGpDo9bI0FQ0tPdr2F5Dst/C9iBb4SSSjiRg?=
 =?us-ascii?Q?BmO1Tco9pVVAiSDlXM3DdYB80hXygzsaRspmI8xGK7SV4LvYWF82oA3FbfmK?=
 =?us-ascii?Q?hNegmRCki6H0p7cPL59vXabSwFkIyKR9qudEzBTC6sANdvPKFRi04U2jw/1V?=
 =?us-ascii?Q?F4IRIwdoJWdcREDEqC607M/3wOAFzxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba9891e-0368-43fc-c23d-08d9e7b70446
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 08:19:08.4850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8Y1U9DSXh8Ys3Bfe1+aqp+Dnexr0RgQJRjRcYn+Y5DwPEkBnPtmn+KvMQQ/vPASFhEdP4y4Ls3CV/mqVRr9/zR0mdLvLacmO60uQEEOjm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6746
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/02/2022 16:37, fdmanana@kernel.org wrote:=0A=
> From: Filipe Manana <fdmanana@suse.com>=0A=
> =0A=
> At extent_io.c, in the read page and write page code paths, we are testin=
g=0A=
> if the return value from btrfs_get_extent() can be NULL. However that is=
=0A=
> not possible, as btrfs_get_extent() always returns either an error pointe=
r=0A=
> or a (non-NULL) pointer to an extent map structure.=0A=
> =0A=
> Eveywhere else outside extent_io.c we never check for NULL, we always=0A=
> treat any returned value as a non-NULL pointer if it does not encode an=
=0A=
> error.=0A=
> =0A=
> So check only for the IS_ERR() case at extent_io.c.=0A=
> =0A=
=0A=
Isn't the same true for btrfs_get_extent_fiemap()? In get_extent_skip_holes=
() =0A=
we're also checking for IS_ERR_OR_NULL() but AFAICS btrfs_get_extent_fiemap=
()=0A=
will never return NULL only a valid em or an error pointer.=0A=
=0A=
Anyways for this patch:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
