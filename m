Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120013F5981
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhHXH4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 03:56:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38177 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhHXH4l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 03:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629791757; x=1661327757;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GIuDuMkKvKfaS+8FM1173ADLTm2toKUV328U83p2sf/XrkrewC6BVlEI
   ARcbypdfG6rt4xa32AqkRxFIsaI8xe3/4iHmTtjN8XHTjCG7i0Qd2d97A
   ZIQExDjCIgRvonqDx1vz8u8ipDyJpCBAymbY5nqk0TomcG2vDDgRVsruE
   lW0D/JwB7RMfQi/npDoqj2cXKbgZ28nPJpGHMDpEgMwDoJ5+1xH2WBT5c
   zNTqdqH+9wCcMoVFjyPhIUc3jOV8JDlrSVqxdYHmBmimvoGY9V1QS+I1q
   bAdGjU3kGKKHXFmHChrEKgkBFvGCWscA8oDjatPrhwx4auZzcOLVlPrQe
   w==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="178203590"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 15:55:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtgnijTVdmb67c55Gf754P7lDtt9VUFzhlaaicSgz4bT05nnTQ6vlFuQqtL901td8yJVyOmeGX67fGwo/2bQBSniXnkBbq0p5GRyQrSiuduYev+9xU1SRrNKZpEOWfJaTR0I41xOvdBU8Z0u575DB3r4MjKuIopuKzppn0wvpT4UnoxymW260hqr6AAnk+B5Cm1V2QsYRVSvDW94gmyxElLtVzZ/bfmIlZgSBaQRKgDFFB9Bt2hLxbHPBlyisbKNFBctWuyWJVQsvEjZ352xBUcBE6Xgwjwe5UD/nL9PyRwL1n2fuVGKas8C8xAKKqx2PscYb6ywVKar5GbqhwfdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=afQ11FnkxZpcsRXF9jz6H/zif2Csv4XUag2BDZvkZ9HGFYLHkTUmsfS7rwMbAJGeQfNXtEq4/eBzGC1gNxVjvZLEa1lFuLmCSE1gzDK/Fbxza0tpFz7P8FU7bWIomHTrpBkmP/8JHrwiuawKb0kMHkYyuBrUVcz/dclXyC4pNG5b34ZCaa3lDnvTxUIa3Fp26mH0m/7QQY8zl1SeE6nbGTCxQXxsZksvViayMacLPCvgXvgo89n4dWzxW+aWM13u2tAX9e9TCd9ohCh4U7CvqwE95Gwmro3HO3Hyw+51GKqLOjeQp3YIsex3E/7ZwA3QCsL3RV6kL0IN9mr0pTSJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jeoiQt1gmRwIRJIzZ3L+XbLLU3wrIUfUjy+SjdGPQesjPXGQqmqjGkMs95vQJEZOG9supkJEXRhLRmqPY/YI2Nc1Sx44G1mc5tXqptUl4JKFKMIJMo1FqylpMVNyOFY4eooy7KaXAuvtMGuVeF7nwgzN/kCFGjuN9GL7xOlcQ5Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7302.namprd04.prod.outlook.com (2603:10b6:510:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 07:55:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 07:55:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 02/17] btrfs: zoned: move btrfs_free_excluded_extents
 out from btrfs_calc_zone_unusable
Thread-Topic: [PATCH v2 02/17] btrfs: zoned: move btrfs_free_excluded_extents
 out from btrfs_calc_zone_unusable
Thread-Index: AQHXlPWLJwWBRnJOEkiifJ/UL1Tafw==
Date:   Tue, 24 Aug 2021 07:55:56 +0000
Message-ID: <PH0PR04MB7416CD956EC536E82C84DEDC9BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <d75c1d36b98cd9ea877cff90492a632d1eec8ca8.1629349224.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf2d6264-2030-47a1-9fc1-08d966d49a9d
x-ms-traffictypediagnostic: PH0PR04MB7302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7302D07F19F977C1A9ADFCF89BC59@PH0PR04MB7302.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5B8ODzL04fo1BRPkuvtw8aT5f2tWZXDS9+2FGN6wlJ5OA4qXspxW2j/x+VRQf7eL6fOHjsyhLjDHs6QU4/Je0jvCp6mp5Ih2jhHqrTlMWpSe/nx7H+H2cmx53QouzqwXA/FdIgXBEIPdrYQKbmgDZzg2DaARjgC8eq0iAUnAvxrA6WgqXrkWMH08lwK1oe01qBKYCpvllse20mdO9V6alwXxWmZyJPseSL9ElnJ9wA5+ikTds7isJH0cb6wWESRlrcbXBSli+CQnApAmUYWcFOseUjfCdv8SDT16Nw/+2VTvWrZnt51vvsa+5btTca/nhsmVnpDDtIPfy1eAykxyHOAaYdG07uo8YRRzWd8nlzaLfmwFbcj46yvByMpUH0b/37nDY3L5QWecJFErBPuI7WCrT+3z7dwNq82HhlK8vBvFnLQ8xbEnON5Gsr1mwjKGo4elNG+LvmYQpLfuQZZiegaJeTTgGR8LY/OiorKRKncCnxBUDUKFY2un34PFfM3vmPk45iPqRsuVZYk6kLJA5r5ycaMofC1HQZfSD0QjPVLW11qRz0/2STYXxNjefZ2BYrcfa78XDj/1fpDq6bs1h8YUW0iWkOsdiUQzZLSx213f63zcuJVi1c8jkBYIBpB0lWqD9uRHvHIld3oJOASp8B5i9HacbNtU89t7ehnp105mHV6Ls+ZznK5gaS17E6va5L2RTpXKSUxE5Kpm8XxTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(64756008)(9686003)(6506007)(5660300002)(66446008)(66556008)(66946007)(76116006)(52536014)(4326008)(4270600006)(33656002)(71200400001)(558084003)(186003)(66476007)(38100700002)(110136005)(19618925003)(122000001)(86362001)(2906002)(8936002)(316002)(7696005)(38070700005)(55016002)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kJ3mY+/f1LfX1J0MRd/LCk0HXV7zr3JSySTls+znucTH2y0o2JsrNmiN7Xts?=
 =?us-ascii?Q?YO9FhUrKL1OtsvyOShzFvZhZDKWQdS9I7FB9c6U9rog09KYp25GXsxunYDE8?=
 =?us-ascii?Q?jAumlvXKd+KD4S0oKzxfj/Amb8n2DIBBre7IJdYGwsyCieg/r8hMjcq0BR1D?=
 =?us-ascii?Q?Fc6s8BChrucmOxEoQ8LvuyYLlXksrzEjni15StN588ufhMfIf0HcZuzH0f+S?=
 =?us-ascii?Q?wB8FbCjlfRUP2R+JAPGHgEBU7OSB8yysdEdaKGdeywZLFERNOwOIWWbudbrG?=
 =?us-ascii?Q?SY6RZmaitYmCWaxMETxMQgQb4lYR4S3a8oYQHRXB/uVis0OT/NbxF+wfSx88?=
 =?us-ascii?Q?iWtLPRvj4Qx3mFM0gSGcSIudgSHatrOQ1Mak4LPMQReZoC71Pq3SbV8B/hed?=
 =?us-ascii?Q?R4kBmMowskwTNDWLU7mOhlGC7WPTQOe/7HofrprcxynYNmpTwhH2pKcS7BRv?=
 =?us-ascii?Q?kGp5DT6vPJr3HLOsgP11yhlpvhC+3I4FcQPxqF/9rXq0ipYUv9zMWdT/eMST?=
 =?us-ascii?Q?W+vcpnppiCEilT2Z56YuhfpIRVnfrgDCtZp1u9UWXPc90Mgzru4LGV94Ogb1?=
 =?us-ascii?Q?FbzANPM18+KI8aXRVKFl0IIPtTOdV9hiZtl8aqaLBcO4F4UsPQqutbTdawDb?=
 =?us-ascii?Q?64C8N5L7vDS5NDtQrTmW9ugA8eU56qjSBv2Xu9bvnf2OzijjbGifpdPj9p3f?=
 =?us-ascii?Q?yqX6oBWhpAw3eOIGnL5CS2wHKYjJcrctY4ibWfKjB00rYSoSNRgU4YDf9HK7?=
 =?us-ascii?Q?aqk9nuVIHusx1lRQe0BdXxDpUwccPtWeNx8CekTrTdjOJihs0aE060snpaQN?=
 =?us-ascii?Q?sXsTzjEHHsb/mK37eK1BF2ySrYXsC0jOWDiqx9a/qwPEoX2ZYnUUk+TazJVV?=
 =?us-ascii?Q?ozJW7ANWNOWEFYjtl+xzqXOezOupByc1o26MtvduVoClA+zy/tHjZB41RnI5?=
 =?us-ascii?Q?Wpt8suEVW/1me8n1/3wiGHI7PPqQqn4KSLSmHp4t7ALEnGbkCtZHG/5qrFe6?=
 =?us-ascii?Q?8L6r6p0yj83gRXJkvgZ3d2a6fLAPzuhCRR+WUSNpgoMw8ot0lbOx7mnAprX8?=
 =?us-ascii?Q?4mcvjmeOf6vpiG5M//IdA3216YTvulyLOFM82t52vkfMMOWiogJgf214U17w?=
 =?us-ascii?Q?5LPHwgs5KjR3V49tpOxVlNn6V5epRifFX50iYI1CB1cebHz99xN1VSVUV7Qt?=
 =?us-ascii?Q?DqCsPY2neICLPwfXcDC7ds9mBQQ1CTD57XSoItF6/BcwOY3gSfPY0AuOxWma?=
 =?us-ascii?Q?nXcyHG+ug+Ai/BzcSo7nyP6RC0AOVis33O5ZtmER7emfLUNQxkShMwVH+qFe?=
 =?us-ascii?Q?byclr+z75K402gCTLZy8vaCtE6f6YfR72fJVr5Q2Nj6Ye/DQt1Q/L+xgBIuR?=
 =?us-ascii?Q?+ajQzAKC3u1L8Ta1VwOi7xAl72F1gHjby2fCygYc6nIJWXeikA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2d6264-2030-47a1-9fc1-08d966d49a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 07:55:56.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NscFtr1xtraBMJs7v5S05TJWLMTLrp9sbi9O0EL8ok6pkOfGPY8LLxtvw/IeaIJ35zlEwYgDwuzDaQLjczl3JiCF9g0ky8lpikGJvANlSXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7302
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
