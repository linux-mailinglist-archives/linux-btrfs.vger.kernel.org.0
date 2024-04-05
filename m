Return-Path: <linux-btrfs+bounces-3943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09A8992BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 03:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5595B1C22573
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7C8814;
	Fri,  5 Apr 2024 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i5hBUqRM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SAO/dVqO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D2256A;
	Fri,  5 Apr 2024 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279647; cv=fail; b=O+s0RdtdnabxuzHKfOt7+0wC1d3QF5BQA0HXiuY1DHLV17Axqq4fwjymTqef+YegAB73+qJhZndjTPaflDkL1gQE7S69Do4/taxRHttsI4Ph2NWBl/Cg0DIFIpCVX8hO5d4+3pX6IZjpROQn5HlaGiDlvdkS5M0n5wC9eqpW/p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279647; c=relaxed/simple;
	bh=oxbZTWqs0hW8jQjFqeAUMNyhXAL9pTQ6yV3oSeZE0m4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pEkF0NwHf0oYe2ORUanCDiRaXBtUambgwimYIdhGy6PJqQ3vX6uKLziVzmmxhQ9t8H5DnY10NGp4T62B2KUgbgGZzNfz1v8pwLmzVyjnK7vR+Hm15Z6qb1JN6CTqqLhDtV/epAnF3iwvk9Zv+9R6CXMEDJZtIFNv/KByJTVwDGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i5hBUqRM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SAO/dVqO; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712279645; x=1743815645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oxbZTWqs0hW8jQjFqeAUMNyhXAL9pTQ6yV3oSeZE0m4=;
  b=i5hBUqRMwkB6YgWn2aDMwf8MOvXa9K9Re/7LysQXEtmsNRo/Ls2rIpj+
   wGCi7N7tryKhTzkc2GTQbbIfHgzj+dZEdsrbQsjB7bzi6PNFDzWuhFc/1
   BGwsk3tup/9I69uKABrSW0r6PgtlTlda3f0YOoWJWQHhJL3321GkWo5gn
   nKLc/WLdeYdJHLtiQz83Wq7iVo+bBDwGF6uPMOKL9a1divl0LO/bb48uJ
   VlgZixEQ3oLcrdPe2jb4uuyVN4X9kzVG4+euCSb5l6HSjaIxtAMcR/+/e
   gH7foGqMSYGUkeWUI9VorSXvr7K1XXCra9SFAd7FKebR2ZhykSSgQLSnT
   Q==;
X-CSE-ConnectionGUID: vPlm52hKSziKv7rrQhw4Sg==
X-CSE-MsgGUID: e4h/AyIuThmVUIvoxh/jHQ==
X-IronPort-AV: E=Sophos;i="6.07,180,1708358400"; 
   d="scan'208";a="13540671"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2024 09:14:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnFgndIYwAinpY37IPH0IhXRfGJ8b9phgpIexysaGYznK955FhBZsvA7yIxO7Ce4/ern7xmDd8rlA5MG5KMoALEu9XjIyBlvIgxFcK3pMbtFbkrMnc0c5wBK2VPE6drnOnui7MLLw+hcq+5gixK+9n3KFqz74HP+/m49HYkOYV8Gn/AY/zdXCFCKgcHH/jRY/43LBXgxhGL8De1TIAaYAGpzx9dIqSO3kdlSuh580EM38oxGJt2PiqxL2zZJleoJTQdvwtKTGdefGVMxXzQ6iDDV+2DOD8earD2qQeaxVQz/PSPz+w0m47wZM8HA33ZLAzS/F01jUGcastcLsdNeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7itllXJsqW/jwa363nzfKUN3sMxOEglsR4mHzg378u4=;
 b=Qd1mpTZCI7hkdDRQnN9L+vbqyXSmmq+1WVe44hFYl4PdORvRZUbPvB2basz4yYXXwvhJUgdk9dV0tqIqS8IkXkH/15HaNSYU2Xe36b2+G9uyrcRnKfKOR6u/eprlp+fYPlBVU7sGhs2ATysMytCXNGDbYufWXiInRxJ26Bes9wm6k14+2PTpx3dPPfY96pPtjKhjeZO4+YC6Puh/BGeuHrb8b10iKyWdUwzHB2TqH0oAxO0mb1THW3DT2Js0P70JHiqwfR8lWfqjQEvMIXFTe/McVGEkdzS08mplWXwhbfxpB0jvNAfvh0LGPIFEI7XBb7/An2M8I4t/i8odvJHF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7itllXJsqW/jwa363nzfKUN3sMxOEglsR4mHzg378u4=;
 b=SAO/dVqOmdcXXECdAQANQ4OpimyMMVB1GusvsAtn/HwVpu57R0Xl92wQxzbBF60BVFbgeR+BBJLVeQR0U7lDi8z7i0ywotE4XN2Iy2TZoZPepe2qe7033wj94JYelAgvJzeDsJOLbPfdVmRfPrkbtY1htXpz5MspaP3HJZxo8ss=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7571.namprd04.prod.outlook.com (2603:10b6:303:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 01:14:01 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 01:14:01 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"hch@lst.de" <hch@lst.de>, Damien LeMoal <dlemoal@kernel.org>, Boris Burkov
	<boris@bur.io>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Thread-Topic: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Thread-Index: AQHagRfFZPYyrls190GkY8abHfqDl7FY6uOA
Date: Fri, 5 Apr 2024 01:14:01 +0000
Message-ID: <rmcoehidi2a2in3c767vcpetuz2txqilhpjjsg6mxjqd6wum3s@wav53ox52gun>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-2-4cd558959407@kernel.org>
In-Reply-To: <20240328-hans-v1-2-4cd558959407@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7571:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xq+d3Y0tq+HkBPMp76H2UTKntqb1nrc5R84zpFt9srbRInKpYfxTF92VSUzvRzKOrxQ1bJwiudBchrOfkvAxFOcrIKeNJsxdBQ7lGdiBUAxe3WoWyEurxx13X7kK7aeONw2zGeupfCbzkf9EwyU/WX3u5K+B6BgomYjzOLJ6xftZ6L0mtQ5tr1ugYCZfnBdaptTXY4gsEiYRAOUc0ti84VPhHsgyu4QDhyip+azcEMLK2RR+53gp6/Cqi5O7UNtsRiT70Mj/m70YTVVxUJkRFtrkvKgAmZ8YI3uUa6Fr1eQdJE6IsLMLbgo6x7XRpqwrJJwxBehWYIQT9M1rG5HhzEbU6NNz7Qof9Ctqu4ihTCeYBcNv9Ua9NQcsJM5Y6MiKwvNfxzUCWOdrflFHSHncozOnCIZCUMq98knYvViYCbAqvLNEqnDqPG23LsTODX8MCdQ42EqxRfB9tDsKWQJHwVQXOEpxGSxT2qeUdULltVt061PRqbu8cpQX8OeRm7uLzW6yXHx282MxsQN5IeRbKPwyCiGKHmUXRS8zOQUp0vaTT3svwb4TjfU9m0JDpts58zKAuiJ4XMuM8WCB7ZLSchYWyq7tJNb79HNIOee0pa2NdgV5yyjDiwK0Mj77anWbyKji3Jq4hKiPWz7yWkz1JttQsfXqw3dE5Nm+NhnnAiI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6KdkOexZGdrgeE7SNQR0w9frdO7/gSj/fd14++zi6lM4eCyZJMhXnzenjg9q?=
 =?us-ascii?Q?wjaJZAKLksSqL0eZttBG2pxUC7c6/+dbop8jaWJcBommo9AzX8sPlsfAE9lM?=
 =?us-ascii?Q?jxdnkxOglKz5kRznkLJjd1Qx3fYzRY7HjGW5EsC2Sa0zO1gDG6eYSJlDS7E6?=
 =?us-ascii?Q?9tOcTKPoM1nLCDVatPzA5/VQLI/9JRSoVgKv47Lk3vYdg9P39gq+0elSkXt+?=
 =?us-ascii?Q?rtkBqnPdPSeDAITpitkp9Oglun51/Dt59sCSFB/XgSxTMd7Mm/EkZIBIRLe+?=
 =?us-ascii?Q?7KeEMESV3K0F94qLwVBsvrW0tIS0kPzYHp19ooncz0YY2AazyLyjHBcZkaiF?=
 =?us-ascii?Q?rQhYt00JEKiPS3e8pdI+kG0bt/GlkFIIlzFHhKFp5wA9b8VcBGoQOF6ffPkf?=
 =?us-ascii?Q?T8Q5+FJiKWFW8yX8ck4Ga5Wa7p29zXohOHA81dzJFfwNi/+H3Ulh3YDZF2W7?=
 =?us-ascii?Q?jF/7fRELhPFyaFL/sOVTSEoTy9lw6544LZdpHc68y4VdkfrTzUvxuWNi10tI?=
 =?us-ascii?Q?G/xs98qQTj+JCvhzyiMeTE0kaoYPsNIx37qYF9tbN5VW8mYPJ+sa3ZrdWxQq?=
 =?us-ascii?Q?KYNF9xPlCnBjIdncS1cwWQGpCcIbfUWYRq2wFpdrijlhxwnSrGmJgfZsDCbs?=
 =?us-ascii?Q?SucqYXnV160WKa89sTrGmOLLoCIqD1qpM0Oq2tay8mlzyI2aBqSZDtRuzvLa?=
 =?us-ascii?Q?vsron+lrDuPFvcMbdjti37NDQLtS6Jo0fB/QBMsFm9RO4LJmIf0CPHvh3HLR?=
 =?us-ascii?Q?lv7fvqoPTSVQujrTDlhVjpR3wR5U52/+Dh82gL0T92m6qd9VxyBs9B383mAr?=
 =?us-ascii?Q?Lrl/HQ6ru1lvrWsT6dqprPvqouguMCCzNdpAp8F3X9jW2+H8ynoFcZwOWRbb?=
 =?us-ascii?Q?mJ4SDEjFAXE00FUhTxiUphjaKhN4cihO8NHJNM39SJvbjQ+NG6Ga4WTopH6n?=
 =?us-ascii?Q?77AUN6+OK9AMdeLy8z0AVbJ4eD7gyuMojEWGLdXX3t2MN0Qd2F880Z8wsrgX?=
 =?us-ascii?Q?c6RMKT08FTDm/GjAzJEJ5D04P5+7fQ+hdrfgKoIU2LcpID6ORcKnvHZuYfjD?=
 =?us-ascii?Q?AubKMMSQhIgzUDN2sMJRJiMxinZjfdH5HJ6VI/7KAruHGJJ2nuS+QC6K1ojr?=
 =?us-ascii?Q?HFI0i5jStDlOoh6SRt/nrONSXGuPShKNr1NYOJYqjZ9k9uJAFejH1ThzeS71?=
 =?us-ascii?Q?Wqu9ab8pk8PAUHIGtYKymCBuvWFze4syFz5WhhIq6VaPck5SpC1WbV0PjE04?=
 =?us-ascii?Q?TRUAMw/tk3NBQGuWd7S9MV6BBY07T7bVPvVBGv2nzFvNyK5QpC6AixugjwSv?=
 =?us-ascii?Q?aydZWi9CNH0PpXWoaDcDtzc1iJOyEbj6QKPzUsms3AfnaBzchwmLngCqlxm3?=
 =?us-ascii?Q?iipsvEuo33WwStFlfvKJonFlH4AAdBWEcUO2ds/+6HtkPh4Di3AZUZXkqi+Q?=
 =?us-ascii?Q?BrHwu83+u79mD46v3gXylRtjOTDuRhh6W8Yvn8YDvWT+5UvCnc8VxjJkWqcq?=
 =?us-ascii?Q?IP2BxDdLyEe7cizGBykK0x2tc9hZE6sHoJlsxrdfi32RokExxaO96F6ZVxPR?=
 =?us-ascii?Q?CmuXdwgTMQPWRr7VQu9KFaiS8G89WMvO3+c0L9/irRtHiUAsQ22+2MhNyu42?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61B0C137E30DE84AB2F5A44E6AFDB92E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xX5UOxJ1GxZM9nbZWB0q//54tidcy8qpADBuTpb/bZT9B7Bw5FcSyMHA7xhjIMBCEYQS0LLapQ5PjwJH5ApZCreZQvMmun6QUADCfJiHcbqziRcIS8Fjo5a80dBAhqPbDZ6Xk+opG1dERyg6f+f/z3HBaLNzHB5Ab3eqcOVg9ou2JdkEb3C5DtShGzYuBH2G2X0E5+vOANtCemRBiABVy2AisM+4xC1I5EBXrOHtxSUIMqT6m1y7muyDOvGqIS65vnn2PVTwkpTwlSlA6kC4W0aWflMLAYrAbxM+KP28K76bWwEWL+K4P18cQzO4KAK/gbN6cZMO6mncIXBg+gPoBj8vJHOE249N57Bi0rlGU/XUe7RfXaLz2yzu9zDUUm7nUquf6dMm4/+n78pk4PGMRU6YCyc+w1+U1WrNXcc9IYbwmn3xr62HhnDAdYGXWRx4Miphkf8yIGdE5grfyZ9Wyp9o6EYt0XzAdSDy0wG+BYH3dIwyJmjrXSwPt6cL2komwURkGIVoJ+qCsjIevEKTZJj4H+indxBwDbUnagc7fKstrcFXbUMdOaG+LTMir9k2XWDl4RUto9qj7BBFDIylzu61CiBVeyIqco4kNjAHfcBG8n0yuThgAkRd6NSwQUoG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0560f0fb-75a2-447b-f03f-08dc550dad72
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 01:14:01.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJkvfQ2fyRmzmhcnvdWmy7fWZLw7x1iwti4FT+SKfB4HQ26x5b16csMwnwDf9693IwyzSMW9jTVW5of8iNCJVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7571

On Thu, Mar 28, 2024 at 02:56:32PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Reserve one zone as a data relocation target on each mount. If we already
> find one empty block group, there's no need to force a chunk allocation,
> but we can use this empty data block group as our relocation target.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c |  2 ++
>  fs/btrfs/zoned.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h   |  3 +++
>  3 files changed, 51 insertions(+)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5a35c2c0bbc9..83b56f109d29 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3550,6 +3550,8 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>  	}
>  	btrfs_discard_resume(fs_info);
> =20
> +	btrfs_reserve_relocation_zone(fs_info);
> +
>  	if (fs_info->uuid_root &&
>  	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
>  	     fs_info->generation !=3D btrfs_super_uuid_tree_generation(disk_sup=
er))) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d51faf7f4162..fb8707f4cab5 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "bio.h"
> +#include "transaction.h"
> =20
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2634,3 +2635,48 @@ void btrfs_check_active_zone_reservation(struct bt=
rfs_fs_info *fs_info)
>  	}
>  	spin_unlock(&fs_info->zone_active_bgs_lock);
>  }
> +
> +static u64 find_empty_block_group(struct btrfs_space_info *sinfo)
> +{
> +	struct btrfs_block_group *bg;
> +
> +	for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {

This starting index prefers SINGLE to DUP/RAID profiles, which is bad. We
can use something like get_alloc_profile_by_root() to decide a proper
starting index.

> +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> +			if (bg->used =3D=3D 0)
> +				return bg->start;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *tree_root =3D fs_info->tree_root;
> +	struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> +	struct btrfs_trans_handle *trans;
> +	u64 flags =3D btrfs_get_alloc_profile(fs_info, sinfo->flags);
> +	u64 bytenr =3D 0;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return;
> +
> +	bytenr =3D find_empty_block_group(sinfo);
> +	if (!bytenr) {
> +		int ret;
> +
> +		trans =3D btrfs_join_transaction(tree_root);
> +		if (IS_ERR(trans))
> +			return;
> +
> +		ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
> +		btrfs_end_transaction(trans);
> +
> +		if (!ret)
> +			bytenr =3D find_empty_block_group(sinfo);
> +	}
> +
> +	spin_lock(&fs_info->relocation_bg_lock);

Currently, this function is called in the mount process: there is no
relocation BG set. To prevent future misuse, I'd like to add an
ASSERT(fs_info->relocation_bg_lock =3D=3D 0).

> +	fs_info->data_reloc_bg =3D bytenr;

We can activate that block group as well to ensure it's ready to go.

> +	spin_unlock(&fs_info->relocation_bg_lock);
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 77c4321e331f..048ffada4549 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_i=
nfo);
>  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
>  				struct btrfs_space_info *space_info, bool do_finish);
>  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 po=
s,
>  				     struct blk_zone *zone)
> @@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(struct =
btrfs_fs_info *fs_info,
> =20
>  static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_i=
nfo *fs_info) { }
> =20
> +static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_info *f=
s_info) { }
> +
>  #endif
> =20
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, =
u64 pos)
>=20
> --=20
> 2.35.3
> =

