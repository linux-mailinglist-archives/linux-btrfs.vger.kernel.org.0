Return-Path: <linux-btrfs+bounces-3489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84637881C38
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 06:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4001C21315
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEEE38DE5;
	Thu, 21 Mar 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W3YgUCkF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PRgTlstR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730F6FBF;
	Thu, 21 Mar 2024 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000515; cv=fail; b=XI2nlBExg94zsmR6XrRuhUYFOASXd60nMtnm01x6Vp/MkAHZdwkKQ4AvxfZvrTLIcWbcmXzJFM+VROCUcCZ1oc9qeGTH5kXw/f2QqunT55JwUQyWw87NbkTjk6BaOjGwsoBM3N5SiLqOG9vqFoZNqq/c4jX3HiJsidR+F2OVPHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000515; c=relaxed/simple;
	bh=IPsg8a9ENEXUcNOVNJ3OqSf4qrgn4GufyZJS03FvIDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arT51QKbb55HfsoyAeumrezr+sQlhZpznMtEgmaENjqo9jiDJVnyB/8yUbJEYX/gMg0o3BM7uXlYBTjIJhWWIztBb+Dap438NhCSOUCK49pHIgLMpgKkftY3onirpLl0uyu3gWGWXedYtsvSfCPjirvM958xO9yl9rUcL78ebBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=W3YgUCkF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PRgTlstR; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711000513; x=1742536513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IPsg8a9ENEXUcNOVNJ3OqSf4qrgn4GufyZJS03FvIDs=;
  b=W3YgUCkFI2T+oplY2njYzZOEJoD2cohucpOSLaGNM+7UC7OkncCl88P/
   FNXnHZoQ613wb8tpsXwO9f8eCME6A9opjYn7s2itoR4zXWquWqt0Znpdm
   0kwzbEjF3Zm1a6Rwms92WI1f1cZrBDabWd6LWkIwnbfm6s8kxcDmvuZn5
   2xV+lImlTKXHcBWqXlobPnQNeJNz1fGfg67l8ky2H/cx2IxrD72aUoz8L
   +o1dIo3OSKPgWCWEc6pivZ9ubVflH0YvvuDv4G7p2HGwI61hSYynHkFb9
   /kbWAUZoXz3mef3onTQjM7X27qsb0W/+16ztX1f+YPdDJLrOVf+rVcDqt
   g==;
X-CSE-ConnectionGUID: 609ghkuFQVWm+vMnLd/O1w==
X-CSE-MsgGUID: w5UhNFrKRVCFIHoMSsK+Dg==
X-IronPort-AV: E=Sophos;i="6.07,142,1708358400"; 
   d="scan'208";a="11626469"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2024 13:55:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtNa3vauXKJp3UyJcbTvRjzWOVntLl/g3Gm++GPeSloeFhKCUMIiyv8TPBtKzHkOz3gUJo8xOfEENIsZtG1SkH1COU0zhXqu5o5SGLa1lW/0xJgwOv2214LbuV86jGkjSps7TDx5WHKBrbfqgEJc/f7IBhcLA/c0XFc5sIcgLo3A6xFrDugaiWR1d8hw+hN4gKKUMwkHMjGeQQkuzknr6jqXdW5txfKJp4oF42e8yWkDRLXboTa7p+TFcuNqa8Lu4/AxoDLr48bje1kPvTyXeE471paBpNx5PjEVxIY93fcOa8x72U7p/8AWXfemL6QzwlOsxGRB8D26Qr6hL+bdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBiwxf8Y65COWsS383X8EpAy7JGzN1QQKRwaVZJLTVA=;
 b=Fx6/44lklTn3Ukc2bcTsdpvgyxIlqVQYuugnhhXL7ysHz5cDbMw+sUaRBRuIeMCoRtBRcSpcP2utb5xwdeYtLNN9+p0o8k5hTV/YEKY2msO/d2cCRn3taTSucDo8b5qgLEUZFUGC4J/GDsDltNQAPKPVPrA850h2tHnj1n35ThDBVTxX+JDf/+EiSYuO6DtinbiuXgsFo8Us1ofiGRJ69WqmpJDkn3GGEBce29RVgrxu5/B5MxbOqTSvHrXRERaT+LFKWdBgXWzZ189ymrA/YdsiohFHJWHJngzDSZUen3xqo0CckK4tCRzcQU5UVYxp1paSkpLw50haHwOBHQ9qTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBiwxf8Y65COWsS383X8EpAy7JGzN1QQKRwaVZJLTVA=;
 b=PRgTlstRbKqmC/VhXblvxjUbbNn7620HtsiF/UuTnLHuaXWJY5TOM6c4f4xw+l+Y3mHb23HHVLW54Izwz1CLw69HBN48HA6Ce6OT85827LfRja1Jxgi/aK6O8bSMgWp916LE+AM/15eP67PX/hNaczZVBDhgX6wCULH72neH2mE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8307.namprd04.prod.outlook.com (2603:10b6:a03:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 05:55:04 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 05:55:04 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] fstests: add _require_btrfs_fs_feature raid56 to a
 few tests
Thread-Topic: [PATCH 3/3] fstests: add _require_btrfs_fs_feature raid56 to a
 few tests
Thread-Index: AQHaeh5pu0ZdwkzGDUK+dOHqHiAsx7FBtGWA
Date: Thu, 21 Mar 2024 05:55:04 +0000
Message-ID: <ru4x6zy5ot33pkmeoe3axlxnitnqjnafczb4tc3y2va2lstjeg@z2maxc55pvc5>
References: <cover.1710867187.git.josef@toxicpanda.com>
 <13ca87a192f4eb8a8f10415ae1ff06682c3b40a0.1710867187.git.josef@toxicpanda.com>
In-Reply-To:
 <13ca87a192f4eb8a8f10415ae1ff06682c3b40a0.1710867187.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB8307:EE_
x-ms-office365-filtering-correlation-id: 7a85a546-2ec5-4a65-2b66-08dc496b7469
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PmHlaoDrYtIMJlGoB5wmD+UD+Oy/B7DeSUbOlStrx7rjaKvAar9g+Scf2sI/c6EwT824TkS1kVOH9nlMy0nobpCBzxLbE2HIoHfvyizgPSYVv2sV8rrko9SL+73VQkVvfYNbktNyoN9xi7n6BYazcAMWYO7ei+tDcqanVUkSUHuk2+S/OIeUvYGU4mrohyGoB5kXVAR0vTL/zoTagmnuRNfEhzqRdiR7cr1kBFZYvTZ51g6Pbcg2eVdbOT1Phr/iP9CN/jvD5kLs6lG6g5SWyJzeUv0vPYSETb+epqTrU0/n0s9TCsZxZeE6rJ4+sC01Y5H5pIOODKFB+niL2Z/uXoXCx3WK3fcQ3DFjx7N7euwq1Vl4usedAjXqVckpgswXMG60ff++Gqmx+ZhczlUA9URkd0fo1ay/O2iN1Qt/X81y1Yi/TCWalIHmV/Hz30j+yhuMtto8NNcGJaTVf7IAw8r4IDoXpBMR5he1HmSRi8kYWwF4gTF2+wZc4W4GfOTYZsRHpyC3Vj7h9uapQrmlRQy6gtP4oTNzRtx+hQzdGlOY9pa/8cwB8bQGW2SIQ3IzY9hKWSszMcKuN2OB4dfa+Rcla7Mm9VYuh6n3cCuKpt70jaibOVMmTz77zofbPPgBNp0V+xqTNoHWU2I8Yr44CEDT/e+A7uIMzDc0DdAzDMbYCtKONuTTpxz//dwCzVSldUMU0xwFz+UdlUuyWH3htK1po/sM5YXUc6zSjsE0Ez4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tJorLjrQ/4+q7Y0JGVf47q4tDHGCKLCJpTu2sMtob2/Qeu7qlg+b+d2PNs/n?=
 =?us-ascii?Q?6X1yy7IygM/fM7W/5S2+gxcsMKEAWl1CJRrxpnJEWxNMCHvPEfoZs9b8YNpy?=
 =?us-ascii?Q?KtjMnZpErLRaU5LQtrCotzjrulajDvidypNZ6XM9GSnElfw3rjYp0hLuGdNm?=
 =?us-ascii?Q?zSQCvjstS++a8gMfBKZnV7MGwsTYbnB889kBjzzkJdOcS7pMaFLzLqxSNmh/?=
 =?us-ascii?Q?SgyEoUJGYtebfFxPcrichlcZxcz6Ekr9L3RhRlvptub+frtorqI99nMOw/gG?=
 =?us-ascii?Q?/GaPPMHDDHnKXvYD5flN1WxVw+6npnyO9QY/mo6CV1rYOdwcAPNdFC+ZfBXX?=
 =?us-ascii?Q?Uxfgw6SWsoWPyGrtBivOUuOVrCwReu6Sm+vKMEY2DnkjJroxC6ZCKK+XUPzM?=
 =?us-ascii?Q?CgmjYpujEBDRMMfTTGNS4rScggNbGdBWlytHzfuf9LmoJw04t+hxCZZLa8OA?=
 =?us-ascii?Q?atJhHTQem4vhimALUygxe2wBFNxhTWFeIM4zIJcu4YPglUNNj44doRIRR/c5?=
 =?us-ascii?Q?VouD9ewVKkOrns1IbNyL+Qq9DxmvRZLUM4gZfGx+u+LHzD3gTqRb2Zu0Zzex?=
 =?us-ascii?Q?6JJeHQe7lc0w4Y6nfQMQuB5jCzUWds6ofh+2kBQhf6lBf5th/1e0ZSV0q2R6?=
 =?us-ascii?Q?VGRkZZ3mavCh7JvFwW4wWykzXdAxURwp5c9Hfof4BtpTtZ+GmHOr0pBEN9jK?=
 =?us-ascii?Q?arx3oRHZQeeVyZwDXbTqyTLl733Jqon+OxEv4wOPDqx96OlGrHE51JH/EIPG?=
 =?us-ascii?Q?b1sMg4Tr7dPYIUOm4Se8TmgfnBYP1IBYc2eTMxDMQoTc0LtmGymIAoTMadWF?=
 =?us-ascii?Q?akI2XGQ21DW6+zdI5pv0gAAqveCFeOEnTnYTtfZCpwdWg7vy2RZTiSN8zclx?=
 =?us-ascii?Q?oimpaVGQTa36z84j6zOdILmA2B8S7dIx/+Sp4vnoFqZtJz8JDJlbkqNQAyMn?=
 =?us-ascii?Q?/lMeJEIJ0SoqDwEkJV7F4Bpx2aYfhAUkZ+Nt5039pkAHexRDX30tZAC3TFso?=
 =?us-ascii?Q?fCFoptS2hlx8Bt1Y7c6b2Q3DiHQJ6wDc1kEuEaBKtDL5SQzm6voDzG2SiHYc?=
 =?us-ascii?Q?3+K8CxOpZOFp+VI4ijWnRUL8HOG+Y4ikMKi3qpMSf8aB+HOFo9i1iH4eYKDG?=
 =?us-ascii?Q?cKqWSYeYxHWga42pCF6LIOejJxWOVR0fNufZ/k9QXUOkZE47ddzil70u5Q3q?=
 =?us-ascii?Q?fdv90GLlfw9+qD6e5CP1p2XZeyNoNOh99s2e5zaBLSjbuDw71vsA4oU6+2u2?=
 =?us-ascii?Q?KLIvmnKLWjK6Qk0hzto84m6bDietXpZQEyanbifvqitVKAbCV7LtCsptKHeU?=
 =?us-ascii?Q?+mlg3lNdhtKhknZZfVZc9MhhvijO7trCf02AfnNhrH5NknAKYsm07THIV0Co?=
 =?us-ascii?Q?x3IOkED/RL0YmZLQGw0sPBjH+bfr4I8ZKyv0dkl+W/WCBnyuXAQRX7x32/tn?=
 =?us-ascii?Q?tjFV/Qma/Nlw9ZP2rxmnbD8x4b2e3QNPTVwJBK11TkrUfiLwB2a8kV/CyfUa?=
 =?us-ascii?Q?kyiUDxdaUDZY1+hu7aU9QNDyIWEzC7aCPk+qjuAjfaGxLeR2nD9snpfSRI8W?=
 =?us-ascii?Q?Qn9wSai9MzGR1+lPOBd40x6k0gLK+7Cq69dHO9MBAVwT6P+R5T4lWCk9XYS2?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F3AA7B49E0F4A418BB40727DB749883@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RThwk+LjIvYv0+uyhX0V0ZjC42myGmtOpir+rOj4dYOHDN7wazTMbGTB8ymVo/LjLCEKC0G8DBtu6ntocw4dr8VI/Dae4UCkjqYzfdKhM5kQEFzFJLdSOR1sbfxnxp5a0Td4vsGVHfmW0kSg/4uj0i4CPZZ66rkg+7u4NxXpPy7gnc+deZbXMWm+LJQ5MIo2iw/E077nby4C029XdTq0p+qxAoSGS254cKXdF1Op8pg77xiPZJDP1eXZUyaXp401uPvCkRK25XTn0HXDyJRswzP8JyIpjl+MokSXsZsbEhlt6czRHZmhsMwr67+p4WkA5mev+eKsBy4VKDp3Vt5lid5wZDTiwirz5tel+IITQj59JBPbMn58AB54nT0qoMMYyvSiRmCoW638/+jsUigA4+O87S6kf77NMavfXO7kNUajl1Q2NmVtNd2jxkloYxBOJuddWDgMy+QJZ42+D8ong29MiWNct+Vq6TAdA9Re+++z5Sec+Iw70JBHaxoOZkAM1s4yZV1lho9BS9jO31Rfyw2nutC2RDvjQUM2Ddi3hiK/coN0z5yFXnUVfBWS7ft9eaSBhDy1PvpJFwhXp3N+9m2nOdHCvT3Lb/96qWp2H0YobH20RfDLcUiMI1PCeh2y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a85a546-2ec5-4a65-2b66-08dc496b7469
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 05:55:04.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLrenW4jUu/vU8Q6Wt5V9XbtBsb5oSSzNxVHkQHgwFKv9JcKQZ5S/SyLWvq3eDY/e8Bd4mWtp1nZkJEblKUEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8307

On Tue, Mar 19, 2024 at 12:55:58PM -0400, Josef Bacik wrote:
> There are a few tests that don't have the required
>=20
> _require_btrfs_fs_feature raid56
>=20
> check in them even tho they are raid5/6 related tests.  Add this check
> in order to make sure environments that don't have raid5/6 support don't
> improperly fail them.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/197 | 1 +
>  tests/btrfs/198 | 1 +
>  tests/btrfs/297 | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index d259fd99..8a034fdc 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -32,6 +32,7 @@ _require_scratch
>  _require_scratch_dev_pool 5
>  # Zoned btrfs only supports SINGLE profile
>  _require_non_zoned_device ${SCRATCH_DEV}
> +_require_btrfs_fs_feature raid56

How about moving the check in the workout() side, and skip the work based
on a specified profile?

This test runs the workout with raid1, 5, 6, and 10. This check can
needlessly skip the test for raid1 and raid10 if the profile setup does not
contain raid5 and raid6.

Especially, as we already have raid1 and raid10 support on a zoned setup,
we'd like to run the tests for them on it.

> =20
>  workout()
>  {
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index 7d23ffce..ecce81cd 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -20,6 +20,7 @@ _require_scratch
>  _require_scratch_dev_pool 4
>  # Zoned btrfs only supports SINGLE profile
>  _require_non_zoned_device ${SCRATCH_DEV}
> +_require_btrfs_fs_feature raid56

Same here.

>  _fixed_by_kernel_commit 96c2e067ed3e3e \
>  	"btrfs: skip devices without magic signature when mounting"
> =20
> diff --git a/tests/btrfs/297 b/tests/btrfs/297
> index a0023861..990b83b1 100755
> --- a/tests/btrfs/297
> +++ b/tests/btrfs/297
> @@ -15,6 +15,7 @@ _supported_fs btrfs
>  _require_odirect
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  _require_scratch_dev_pool 3
> +_require_btrfs_fs_feature raid56

This seems fine because it runs only raid5 and raid6.

>  _fixed_by_kernel_commit 486c737f7fdc \
>  	"btrfs: raid56: always verify the P/Q contents for scrub"
> =20
> --=20
> 2.43.0
> =

