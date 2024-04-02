Return-Path: <linux-btrfs+bounces-3813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B48894B19
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407B72825D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 06:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65311863E;
	Tue,  2 Apr 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SzwI6Ubp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PASktzFR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B21D6AE;
	Tue,  2 Apr 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037827; cv=fail; b=OTxmkOJCwjrlSqrIAlJdMitgRsHQhdOtpXJeW5xDWvBy0z0oK9CCRMr42T8aAOXnq3+tGgVAxShkO0qUl+lDkjdH38De8pK0OxrgYOuWtxZIeViiTwodkqazSfRpnqm09z8+canX17D8zr42WzdSgoyH6zELyPHM3FWE8l6bUU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037827; c=relaxed/simple;
	bh=GrveoGpr/vonC/OIFXBQctEZJCdOSyV8zULwaumcyUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnXYmLvcEYxyJ8/oXSHUveAyyIuh8lnJoA/0ji/ri86CobyFjNsyPWvwLo4SG0FrHRVuQpRU3P8oMeSrkD2bQX1Rj7OA4aWrjaa1edLqB5l9fkOPy9dkO/YxZr9eOtlwtgMHaUCf46/jOepvDrsg8iC6jiQocZOpGLLbJQc6XUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SzwI6Ubp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PASktzFR; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712037825; x=1743573825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GrveoGpr/vonC/OIFXBQctEZJCdOSyV8zULwaumcyUQ=;
  b=SzwI6UbpS3iOHn4UtfBtuJg4YxNsRWQokAQlE5bxtrZEmPFupXeLLMak
   Yu2r+SDthzd+EWRo7Qf/YIQ8SD8OPCI8J6nfdXf+UCT6AHO5fF5+JaGWt
   5EOo3jFA5Ur0rKMjLfORp7yvALiJYvg5ncYfUI6c5vgmdQSIVE4pg5dQB
   5JlJjWc6gBr3jMMHb3AOwwtqq1SZTv623P5Y5SwTKk5Z6ONw2lSOwV6B9
   /YXktl7poL7soa9rApuMiigpdxgmdF/OLT3AAVjXlIfNqojEsFPtY3dEd
   sGz51CwWqKF0dO9R1w4jy/vj7BZXsu3Rrk2EKM59++mOx9O7XcCZt0Lbk
   Q==;
X-CSE-ConnectionGUID: WeCf5GZ6TuqpVu+R7qiS/g==
X-CSE-MsgGUID: uCBG7c9cSt+EQApFEbV94g==
X-IronPort-AV: E=Sophos;i="6.07,174,1708358400"; 
   d="scan'208";a="12846870"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2024 14:03:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V68GCtrjyWmrfcjfcojYs6G5XsWMndHTHmXglNxksQpK6dm3G4RP7d2EnZqG3bAP5EWlYnlf0aE6CPpXCYYuynLbmEubdms6BJhv5OTFrhniP8T5RgCkKWbJ7pD+5GQlttbCjHn8mfcmHl1M7iAS0Ru8vSL9mNljzKUkzQSdF2TEEzGp+wrzXG3cjBMyTshYC8LCTjbmmMsTO8EWFLDd76Eb2LF/zX2y4SZaz5t55DVbTOWkWNFvUYo5pHVyqhpk6DnvueUXJux/AcQ8C29maAOZP2KUohVH69MgTEuI9+qAqZLIHdvUcSweL8GWpd8IxmvlFFG22Vx1XFFMIMZkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S05qyfM9j3ijewTh/f7k9Pejh2qBbLz7ra741TZXjkg=;
 b=SVHZdcFDeEAe4XMTuWU5zip9NDsdiMV/+JTZSpJRTgBqMKxIN1oVdQSq9ASZMtrqkLdm3u3zghF3EJvtXC7DWUNPsh7C93J4BYBCUUo4R6QmO/XDg2tvv1PDCLYMYZNRM95tk/418m1fVzuHmflcPgdUYqNdkdrTD+A3gDEwPC6mKJyz7fMviA+8B1hgDCH8rGjoU1/jtLS6rLR1p6HnFhY5Q6Focl2nhNnZd5xuG93EvJPGamhxkglfRHuRgsDAWh6CF21MnY/wP8rbBL8oqsaOWoot/bjM92jo2pO9Cha24QTZwfpl4hKZmUoKW/SjDgQIACK/4ew9adEgFdGxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S05qyfM9j3ijewTh/f7k9Pejh2qBbLz7ra741TZXjkg=;
 b=PASktzFRZfTfvvv3ciiiwH7xIH9fKaR95V6oiBVcQci8s0DkMxQCZPcR6RWjSqR+ZcZ/f2zHvdpypyaWPAlFQdgaffmiZjESdFbrCEHaGE3YGrLrhqxj202ZwCl1fOqMJAQI/zEjB3BHmRMWzp9hAo+mnguRRHvFG6yDW+BHSYs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6541.namprd04.prod.outlook.com (2603:10b6:5:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 06:03:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 06:03:36 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "hch@lst.de" <hch@lst.de>, Boris Burkov
	<boris@bur.io>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Thread-Topic: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Thread-Index: AQHagRfFZPYyrls190GkY8abHfqDl7FNxrAAgAa+H4A=
Date: Tue, 2 Apr 2024 06:03:35 +0000
Message-ID: <ozmewhhflwko2z75luj33futfnkhoryyhk7vvb76suuagqse7o@gdwyk3dj3yw7>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-2-4cd558959407@kernel.org>
 <e32027a2-6032-4937-a362-287897abdf11@kernel.org>
In-Reply-To: <e32027a2-6032-4937-a362-287897abdf11@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6541:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tahSnsXjPBxMK5oZz0DVnxu4Fg5mXfp5wLh0/XZBpugfQW8bc2ETuXW+CcVm0ih++Wm6mJTN7DF833sKGQofkgzqyH0ez1/mQob2YRGv6WrLmWY9jPxwIiBlAwB1/UdR2IdGgKaW+9IY3R39SDufXqWcXRE6gmDnMpkavooO/4YxVMsOoNMiJ6rQMkwsVGx5OXopQDZ9urTt+JLBe2PkJSSMz3KFMlE7ddfLEN8g2MDgqJgbesO0e40YZD8SyEE/FF+ry+Zy+cKEUXdUbfrKJi069lsL1lbvtzJZC5Vn1mZhKs6tmSa19YSafh32mWdFwirdwsl6EYbt5CeirhTSBihjKIS3/EgbhweQ8Cn2MUVAutHZ6sVNF401NQTARslJ/46yDeOcgRIcbOPo8+ssUAGXuKJIBkxRAHzfl+UyPbSVDAQs+UDScn5crb4YSj0D2XLSHJftDeCRNB8KpiXUhjoFN5vBXcrOdtcrx1X8+kBYt/1plAeDalvOIcHB06eTJKtGxWr6zEBCSeO16uiX7UJEJ+56IA2PB9nuCk39wgkTe4zkfRlfe8tbUUMBfcXe2/gsgkvNcxhwKdgciVnVlnD5j/Cp4wHhezQ2tLCjcl36IEmnZn8ChdmfmlWpy8vK9Vb68yerq/SdCUfmxJ8e72z0nqLgGsXHCvewn9Jvanw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TK9QVEC/ODzFIV11Huz3KZJ0ss5dUBH47Au4pMD7A59Zj1Yth9bQoJSt7GG3?=
 =?us-ascii?Q?4wNuC7KDk/oiZ5BJpUhy9EB8K07xV6T+p3fsKh6nhz+GoCwnsIVDwqEeOx/U?=
 =?us-ascii?Q?tMqOxs8YwQCelf3jb5Ze2ktjap+2HfNjLwhq0PeJoRwGcz7Bg6T80OQwYrtf?=
 =?us-ascii?Q?NQa/2GxEon7usn3JW7WZbeI7JdSLZ7KjkIZPDQDg3aUAzhclAvxlA1vcDXlV?=
 =?us-ascii?Q?zbqktSxuFcuOMK6EnDRzuGKfLoco4u0LCM2ieR0UjyYBq1KxfrqrtCuw7Kue?=
 =?us-ascii?Q?KvDBUhwmQlchkW1iPMgFd7KEaP1yFoQ32yKix17B5zWDXsZsPG8Mrx6RgUwi?=
 =?us-ascii?Q?YuQXvC1TlS6WwPxY0/t/VGi7hREYO5L4mbH3b4wH0YBat5LJFMCku5rVCj4l?=
 =?us-ascii?Q?17+3EKBBfTDxbqmxhwVb4dkOSUpReZM9IvR1ORUrvuJLiTCRzUHtX+EMMKR7?=
 =?us-ascii?Q?5+vLkT8xjDqr6yjSBZcT9Sevtwk8CejjlZxGIy3TxYFLRZC/ACEtY0j3A4eM?=
 =?us-ascii?Q?gkhb9tRKz4su4dFR9gsV8aeNhmhiwKJmpMHJO1WBc/RBCUQx2pIru8aq7p4c?=
 =?us-ascii?Q?IUY36R4R8/Mgif5tVeJcCGVdCCgjyRaVuc7Vp0gplrJVu+USR8we7se4Bp6+?=
 =?us-ascii?Q?GVgrf2o7orr8DG+Tohsg0SI/3GI4xPcVX+MelBZL8rqVDwO1q3seBFJRxIBo?=
 =?us-ascii?Q?t0Ax889vWDvjkJBYZvCfJHro4NS9stQUekJNY990fkCfKmgBsb+0KSpfImgp?=
 =?us-ascii?Q?PekIIu7J+Naw2UppF55IS2psKxZc6GCC+WBf6sHEKCLQS5UUpENfduHFNLMM?=
 =?us-ascii?Q?DsylFvE8Tp9t9cp73NNy1jvOmykhGSYIjM9x/4UJzXDqoq1Bofk77bVJHP7z?=
 =?us-ascii?Q?0a41HB4/PVamEOCtXaIEg16fFtA0Voeafu/Nct6RjlUikJRtncRCA4OHXmrh?=
 =?us-ascii?Q?ARrAgJpgOWNJ/8Im420l/EQZgCD5/ifoYytLNeVDSv1ALfrrX3PrOzLh2wr1?=
 =?us-ascii?Q?mzeRApkzLM0cTE/da+7PR/PyUq8NL0m2BIYOFsJvxyP8u6Gc568ndOV8ucc+?=
 =?us-ascii?Q?oj9bCcDGEx3GlQAd6C8caWnDXSL6cuJVNH5CjoZQoFKjMxc9usOeB0goZBPg?=
 =?us-ascii?Q?5y9dkciwiZYYVAbUd0wuRF+2fHYQ8EMMoXuaIuJCpX2Vcr6tBpPdsaXcNmCh?=
 =?us-ascii?Q?i6Wm6+Ddet+9/zbDIhESCMGYRi0zVz+emSp26OnJ5tn+KC9mb2ons/eKmrNb?=
 =?us-ascii?Q?GIAlj8w24dvcyID7RCTaC6PqzN6r/5DHcq0vbs8CTU12r2dcLwXDeZy0C9OQ?=
 =?us-ascii?Q?Isfrh5nZ7MbGgn6lSgIEzM3qv2Ard/N2eAaGkxdY17JuDn5UjhFYNWS8cst6?=
 =?us-ascii?Q?Qst7IYi+8ShdrxWVBvY56a6g1pdFs+3vp7mn6IdC+b8duoIiQUACxMwujodT?=
 =?us-ascii?Q?J/hdB2AEmM8I9AbuBAYoG5IwuPM6UZs7HLd3aBB8tmw5j3AgDKklJ+cPhtDP?=
 =?us-ascii?Q?9hY+22ms474orwZnAXP+ItwRUVOosMUhZU+yLriRByiLrae5mykyI3J4BTVN?=
 =?us-ascii?Q?mTVf6agqoMy5X5jJ2NC2L3xUSaxH/+nkxPX3P0u0ORmdrNXyMfHxp8hwjOn+?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92D0BD54A861AD41B735BB1C2EAA8A9B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qa46tlfbFaK+KaElUtDRk7/utQ5phKDyiiUIMzZA+NH6IKgBYvXSjVBA9bMhllD9km+FX63Xa3JLe3CT6r3IHYmZHcxVsZVQaJvQ51IKjCyu7JVfjb+8oSbC+DFziUBJSNjjwAiwFQwel+8P7hMtIRmlcFfS2MTk3M24VtIQ6KjMrfpR4X7JiSZ4debTAVSuvA7WEn3SaJhvW9sxO3ix78uPAFVRuY/+WGy3mvyzpQmN64EuDgaySpIyMN7pDuDbb4lVPf/kSxNcDlIEcKR+JRKh5Qb8w0KhQuujER0tybMQytGbEBR6hqkcWmNCxmAYslQ+o1LTbftJNEzpqyWhNllZkWyBcTcIPUQGVaQROn+qXNjijn1p6eF55LemXfhsnoJKiYKafx/vvuDUR2qhj7hQuH+t0Qoaz+E50KV9/oBGn5kkbGsPtligkmVlIziPESxvmTZbV+xLzmfH716fWFXwj1um/7fMf2jnrcSdUVWRxkJYWTfTsXk0paYuYuHzenVANVHWXbD/JnuXM8ArFoLuG75RyDorTyJoxfCuZFyvbykRSOD/JXeoglQPqLV86WTh/mF06XKehpQsHeJX5bEkUnSn4Cd2/uu/5Cb3JqmbWQU67gUnVZM0UZeLRY2B
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadfa6ca-dc45-4304-b9e9-08dc52daa25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 06:03:35.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZiKR+14+mrQJarjfLvSFAopkrfsGwQiLJStJZmjjh2kyYnMN8A4xJ4V3tMy+EZPuZVwrd+VbKwPxP99cDxaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6541

On Fri, Mar 29, 2024 at 08:05:34AM +0900, Damien Le Moal wrote:
> On 3/28/24 22:56, Johannes Thumshirn wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >=20
> > Reserve one zone as a data relocation target on each mount. If we alrea=
dy
> > find one empty block group, there's no need to force a chunk allocation=
,
> > but we can use this empty data block group as our relocation target.
> >=20
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  fs/btrfs/disk-io.c |  2 ++
> >  fs/btrfs/zoned.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/zoned.h   |  3 +++
> >  3 files changed, 51 insertions(+)
> >=20
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 5a35c2c0bbc9..83b56f109d29 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3550,6 +3550,8 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
> >  	}
> >  	btrfs_discard_resume(fs_info);
> > =20
> > +	btrfs_reserve_relocation_zone(fs_info);
> > +
> >  	if (fs_info->uuid_root &&
> >  	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
> >  	     fs_info->generation !=3D btrfs_super_uuid_tree_generation(disk_s=
uper))) {
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index d51faf7f4162..fb8707f4cab5 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -17,6 +17,7 @@
> >  #include "fs.h"
> >  #include "accessors.h"
> >  #include "bio.h"
> > +#include "transaction.h"
> > =20
> >  /* Maximum number of zones to report per blkdev_report_zones() call */
> >  #define BTRFS_REPORT_NR_ZONES   4096
> > @@ -2634,3 +2635,48 @@ void btrfs_check_active_zone_reservation(struct =
btrfs_fs_info *fs_info)
> >  	}
> >  	spin_unlock(&fs_info->zone_active_bgs_lock);
> >  }
> > +
> > +static u64 find_empty_block_group(struct btrfs_space_info *sinfo)
> > +{
> > +	struct btrfs_block_group *bg;
> > +
> > +	for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> > +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> > +			if (bg->used =3D=3D 0)
> > +				return bg->start;
> > +		}
> > +	}
> > +
> > +	return 0;
>=20
> The first block group does not start at offset 0 ? If it does, then this =
is not
> correct. Maybe turn this function into returning a bool and add a pointer
> argument to return the bg start value ?

No, it does not. The bg->start (logical address) increases monotonically as
a new block group is created. And, the first block group created by
mkfs.btrfs has a non-zero bg->start address.

> > +}
> > +
> > +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)
> > +{
> > +	struct btrfs_root *tree_root =3D fs_info->tree_root;
> > +	struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> > +	struct btrfs_trans_handle *trans;
> > +	u64 flags =3D btrfs_get_alloc_profile(fs_info, sinfo->flags);
> > +	u64 bytenr =3D 0;
> > +
> > +	if (!btrfs_is_zoned(fs_info))
> > +		return;
> > +
> > +	bytenr =3D find_empty_block_group(sinfo);
> > +	if (!bytenr) {
> > +		int ret;
> > +
> > +		trans =3D btrfs_join_transaction(tree_root);
> > +		if (IS_ERR(trans))
> > +			return;
> > +
> > +		ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
> > +		btrfs_end_transaction(trans);
> > +
> > +		if (!ret)
> > +			bytenr =3D find_empty_block_group(sinfo);
>=20
> What if this fail again ?

That (almost) means we don't have any free space to create a new block
group. Then, we don't have a way to deal with it. Maybe, we can reclaim
directly here?

Anyway, in that case, we will set fs_info->data_reloc_bg =3D 0, which is th=
e
same behavior as the current code.

> > +	}
> > +
> > +	spin_lock(&fs_info->relocation_bg_lock);
> > +	fs_info->data_reloc_bg =3D bytenr;
> > +	spin_unlock(&fs_info->relocation_bg_lock);
> > +}
> > diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> > index 77c4321e331f..048ffada4549 100644
> > --- a/fs/btrfs/zoned.h
> > +++ b/fs/btrfs/zoned.h
> > @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs=
_info);
> >  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
> >  				struct btrfs_space_info *space_info, bool do_finish);
> >  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info=
);
> > +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
> >  #else /* CONFIG_BLK_DEV_ZONED */
> >  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 =
pos,
> >  				     struct blk_zone *zone)
> > @@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(struc=
t btrfs_fs_info *fs_info,
> > =20
> >  static inline void btrfs_check_active_zone_reservation(struct btrfs_fs=
_info *fs_info) { }
> > =20
> > +static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_info =
*fs_info) { }
> > +
> >  #endif
> > =20
> >  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device=
, u64 pos)
> >=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research
> =

