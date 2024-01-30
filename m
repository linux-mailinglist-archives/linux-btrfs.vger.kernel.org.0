Return-Path: <linux-btrfs+bounces-1930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A766841876
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41501F2728D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F436AE5;
	Tue, 30 Jan 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SCKWx4aJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t2M3M2nm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73A364AC
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578742; cv=fail; b=djthwlI7GiovrZc+akIaK+XgXOVG8ENt9kA61RkB8giKTD+KGkKq9UqXpCS1d0n96uP3+h+PAy255GID+S0o2wmR0pxQiu3mOEi4riM8lKidiCR3aaz9g59ARiuqoIJqMfZ1PrfhXxyvC1DYRvxqjp2gLaAndApm696mmu/xJXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578742; c=relaxed/simple;
	bh=h1NiwUV3vuw8/3rW/AgzSI/Oo9QvrTgBzGSxkSiqmGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTT+Lz17l6uppn+06aqQizvVxBgLakAwOsy5gxhSx2VA4kA5MuOe9kkUupaJgT7mAQ/4lv8zYZddwrpq9NTvEPoMhlPqO+c48ROp6g9SsK52dBRrQS7gdWV+9zQfN7L2LGrtIZK3v2hbxiO3Liz+WsiugqZsSDkdjqY4Jbvvb74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SCKWx4aJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=t2M3M2nm; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706578741; x=1738114741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h1NiwUV3vuw8/3rW/AgzSI/Oo9QvrTgBzGSxkSiqmGA=;
  b=SCKWx4aJHbKa2lyKVCCKawP3dkmqPVXaLiaLHs42XYXjtwqrHLjCDvIY
   lpZaefXZW7QVxYpo00VKV5t/cSX4fkxYEvQj1tgLGQjMEK6ObKKAGm0ny
   Wop5nEMfxQ00nuowys8df56jyRLrG4IhSo2hFyhbmdVzvimayQ9leDyPq
   fMuQ98WFlAxMCJbuBrtfs11CtlfES8yW4A/AtTFJNFY0w8E/wD1fXuVtO
   GqWormTNb1FIFbiBNrqfH8H97liPci1+QdbwYF3oFt/6onC1Q+ZREMY8E
   VZKXjGWaHE73cJIswCQUn9mLgS0BfLjGQWGA2HM/aoEGE0oAbQXS0Q6OI
   g==;
X-CSE-ConnectionGUID: 3lB+H9EqTK2bM3F2VGj8oA==
X-CSE-MsgGUID: Ic+p1X0DT9+Q19RKP4lkAg==
X-IronPort-AV: E=Sophos;i="6.05,227,1701100800"; 
   d="scan'208";a="7959935"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2024 09:38:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLYU9jAieozFG8Rsm4JWj12/A8sm5NRYv430a3ZAqZAVOz3kebFrUYjSvPSp1knO1uWM/sXkNAf+A6dDcuHL1/5m1mYighgZ17uWrb4lUVlEvafoKpFiFQfM+/j6+LZZzR61a2ToH8gtwBOilmkOe3kfUeTKju+g3RFDOt0KAQQQ6hBOCVEV9MrRbbf7qbwAlaEX1QjuGG3/RlKAZqSOyeyOR5DfS+1ZH4dHP9oHi0cVptFTnIGVwdTDYEoF8+8M/X2XCdOF6uaJksNhnuRG73xWZo7taWXGn+DAIMUWH/bUkLO/t1WKMPjvNVnoJot98rZP2Ls7HZKSJsvjNbV7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzKl6yDqzdmt5IcKnQ0zruOUcQXq9h9yQgjvApTL8qU=;
 b=kRrOU2olBS7HbEMgwn0zHhuokZGECVMhnAYWRsEYUYmaDqsX3Q/HRgL8JpI491CwJnkE+LKLmFTPsNC8HqN602Fub6HEOLaOKqicBxg5I5/g0SBgrr2cCsdcA4PGvsvvbqWWmJEyF5/63nu2jt6DxejtFK+gTyk7k1YheXkQGiHiVtkc7Csg81el7BFAYo6r4c6b/14pcSC9EBEF6dQORZqmX/c+B3Vq0S5kVl5dcLtbRpNZT5qHwgJdwxXLunGcK2bHl3EAQzR4nUOGQtpTnZhqJUrAJcG7CHdjN3IFottMH9gn37J52A2A46YoCI9uwPUpKrW8+bGSIKMxtnKObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzKl6yDqzdmt5IcKnQ0zruOUcQXq9h9yQgjvApTL8qU=;
 b=t2M3M2nmGVHfs7w3RBDSrDshiL2jgSMOA5+pw521O42HwBuIltPmZoWCuLEb2xP3/aj97YwLD4wBqCcCkPEWp3AR+HzdrADEY06o+zXTJhC+Z/fze0/NlacKVMcSlA1Xdp4Sat4QE/M6xZV2kB0pVbvnobj9/ORTzKIeQMeQ2sg=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 MN2PR04MB7088.namprd04.prod.outlook.com (2603:10b6:208:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:38:56 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::fc7e:ae94:249f:c957]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::fc7e:ae94:249f:c957%2]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 01:38:56 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Wang Yugui <wangyugui@e16-tech.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Thread-Topic: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Thread-Index: AQHaSewVbT8W0k+HTU2pfeXHKHnXkLDoIikAgAivHQCAANUPAA==
Date: Tue, 30 Jan 2024 01:38:56 +0000
Message-ID: <7pljxx3p7w5uv3hrgjjxar3rychebbx4ldncft7b7fqk2tq4uo@p6kagjt5qwh7>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <20240124081931.1DDE.409509F4@e16-tech.com>
 <20240129205621.1BA8.409509F4@e16-tech.com>
In-Reply-To: <20240129205621.1BA8.409509F4@e16-tech.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB7765:EE_|MN2PR04MB7088:EE_
x-ms-office365-filtering-correlation-id: 18e64d34-9fe9-4c22-eace-08dc21343992
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q7EZFKg4ulcKqLom+WIS7QkYMVzjFWtn9jajlT36TLS6rONr4KqGiJpZVPZERjOBz/DhSRHoUEZ3Hupa8CfHRGv6rhpKqQWIKiwC3CstDyOe61nXj8CWC2aLyTkY7jlKGJ2Qx4GcE+mp7E7QuQx7pQ2SJq5i2oRgLHxOkwy3BzI3HC2CRY1eAhuGrBB4BFMFXw78aMD33dcCp+JKLq9jVmMziJ2XI1aF3JiSmm/FSw3FQjkXA+QcxvxpUItbURKWgcuVbsJCTRe0hWV9O9QTNVs93A+IVcftlvkjWmGTLG9zBZhZClYEyonuqA+C9JBOS7HzmEnsD1mNcFRyYJSwsCzC0IWmOPmfKknW+h9BGTUfZ2/m8Z/sUK5rp+damzx7dj0ftA8hUBPin+DMa0ctrihxYcPZxVJjPE7gSVFXvGmz7ro+oM1dA6DrHIc+BJiZuKcaiiwf5D0pYOR3XqYSwohHC9VuVUVwYXojkKbuASd9er7IRrR7i5V0FnKxjqeEwhesU48rmQIA6snUTYoQ4ikzMXCPD1IYQwc25zy7zQ4lSnCsDaYMbgOxPFM02W35mPYlvU2Q1BAF/IJl/12if4Y0tApTTscHfiZfT8Bfa7DNxgvt+nqN8C9I3z6c1dav0jtI+R1S1nf94eEK5BfdqQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(6506007)(6512007)(83380400001)(8676002)(9686003)(26005)(41300700001)(6916009)(4326008)(316002)(5660300002)(8936002)(2906002)(66556008)(38070700009)(66946007)(76116006)(66446008)(64756008)(66476007)(91956017)(71200400001)(33716001)(478600001)(6486002)(966005)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yjYWEySvdtSjVwqAbYej99LQk5gmuwmYNOZt4pQ7nyD0Nq2s1aYNJQbyCgPl?=
 =?us-ascii?Q?6IsLdtOTKzND+QWd68PVLzYwtF1kq350e6jYaFyuMKTck3wCWzhHtwCWAG3n?=
 =?us-ascii?Q?hhqBfWAUe6P2mCinhlY+uj+8OsUxSs+e80EfGiEbqbP3vKBzPJZN1GJiegCf?=
 =?us-ascii?Q?aO1dWBljS9+PlK7udgfuOX7HGWv1D9Ma7vYSfgZL1iq2vlo8Boub3YSyKzUF?=
 =?us-ascii?Q?eq9UGhP54pJFZ6fwsUGtcGWIPTbiFKmvCTZN3YJkz/xBtK2Wu1MT9Lfr7tAb?=
 =?us-ascii?Q?eAD0alymcPplFT9LFuYzB3+/SVp85az+XedXEyKmMeaIwvzuSgFwO3WbBHYI?=
 =?us-ascii?Q?dPwMc5aaeacWUnYs04V/D1zAFlFV/XnhqAmQIj1h7eKvcWwGKcUA4mOh2pbz?=
 =?us-ascii?Q?a1I/DWDkzpXYPBg2oTsBrruDH6AegznnjrtDo0UlowhfB1myDR5N3TKt0C54?=
 =?us-ascii?Q?AbJOAwUE7K307Z5VjWtH3l6Rn20ibx/gWjaDDwL23KfaSekw0Dtl9xxoTYYb?=
 =?us-ascii?Q?ExjAReUD15zuLVioWe+Z2y9PvBuXt9X2/d81zYVTlm99j0tAin8Hkvme9sr+?=
 =?us-ascii?Q?m4cv7NN7pAUsuZcHO7h44EotS2jypgrsjDaDk9Fbr4H4ynK9tJh+wqkCoe9x?=
 =?us-ascii?Q?r941SxPOGGSZ/MDpNxu60bPiDnJ2Vshz0LiDDuuKmZ0DIpdBnXmBwSeVMf1s?=
 =?us-ascii?Q?iq73d/UVII+VtgImIj2590wjBuRHlHAwNuERcPAwNeZnhTnTcX/3xYKdloJ7?=
 =?us-ascii?Q?f6orWIqtn9sadCDopbFxqtZUJ5mRtRuFJlVgiusGjkwlN9o65omGIt5ILdFj?=
 =?us-ascii?Q?3pjcx8Wgpgim2mjsgCiYY23Oqnlg0Zsngn396/mlkvmUnrBVt9/HacgglbHs?=
 =?us-ascii?Q?/ENksUGZeSLQ2kPosjFYrpm2C6dXmSEKSDlGHguKM/B0WSdWg8cVfQ+H7+Dj?=
 =?us-ascii?Q?eSwo4jnqLvzn0WQGViA1eUQ6f3esNXXJ73qx9FMu21WpoZUsqINZidXiLXjL?=
 =?us-ascii?Q?rnauhV9Bey48KEPcnSRp65sb8cbtGSNAIcmd5XH+GQLyMzihh8Uxtu04tX65?=
 =?us-ascii?Q?TqTJ6HwtliaXcK3OyeZUy1+9UCVkH493kUaimHXnAhsLrHW9JMOaPEcAGUnL?=
 =?us-ascii?Q?uGpA//S7zhgn8wDsrOfJygCQPP9uu5q9HzYiPeEK0KMERNjtJvqsDna9p/qC?=
 =?us-ascii?Q?Rr1ElmW3P7bOiVhgjXOOaLy/eC/C6y72RpOklgplHLYSsUbJp7OuU0w8hK3J?=
 =?us-ascii?Q?33zchMMH/tAg4R1KC0j2JVksI8Oc22lUmfx2tZyZlotNR1eF4OCCcHa0ob1I?=
 =?us-ascii?Q?iPSAsS+Ryunbh0/U8uF5Li8JKULmkeZFsiYu5HvINQD8rxanx61VvntL8sJw?=
 =?us-ascii?Q?Nw+vgFj1sdjaSy/vvtZHl65dBcdfLzsz7/WWvDd98qa53Pr7zrsnOZpoUInb?=
 =?us-ascii?Q?v8rjkMzD8lgzbSUfHpVs16kqnKGnXIf8ARkhawOzMwlckRr6gQOQ4N+aQmzp?=
 =?us-ascii?Q?uuiVuq9ajT6f0yoFcyjB9U7iIF/vtA1yY3+ufUKEgcSc19z3zLNPW67ol2mv?=
 =?us-ascii?Q?vvkYicowOEs0z5x6SizaydkiROwVWUDkmuja6bUIIDvnvLkfEOYf1tpsz8bq?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3965DAFDBA8D774790E10F200896D803@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GmShQSydtGkFQ5yVbT6+/gGnL/JR67lvqEQO2GRaNes5iLw8IN0Cb/3fmQVTyloZShqPHOVMNDof2UvCJwDbRLeGT9k+yHPe4H111hI42hLjO7WTV5fxHhGaoDpne9dpiJ121Ehg6DiDGVh7tdDC86244uFwkVzFY03MQu+uQ8uO3FnXqL2iZpaV+vJo3fVlbS6AD5z9dYcyYkwvvyv8GlSJowQSB14M31Dy+NSQzyRfOgf5pGSn5a7DziZHkx41YiVEwW/R8xxRFo6rfwTp8sJ8dIqDKfkaXGNK52wO3uuOsnUIlaYhOwONreY7zO0++un7jWSKVIIAXKQF8rU5gGfLGD/XxABSPS4u1s/rf9KWxfUbmQsMYl9AvLT2UjW7C+LgbdccnhIrFz0qbOOAoCkb3jnAvBNFbK7QIiZeB+cFQoclq+NtaY0ctMew2jZj2sCSDCCojleAK1GufCWwmCKvgKj+R8Hgfuuy7lIRyiQ+vu5VB8U7UHOs6mxfTsC153SfZo53HSCC51U/KiT+jUKb15GmbLa9E70KaX1DFaPd/xwfo2Ue6PK67LvQuLjuydFnlvxVmicZCo0mljyF7qvOy1wnfSSmEezkM2477YEDvbEFfUye5Urc0KcedYje
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e64d34-9fe9-4c22-eace-08dc21343992
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 01:38:56.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM8+9gIIxDLa6rAai9fWKlxQHqkYoaHqq6bmQDlwSjMM6uEO2KT4hCHs8FccPeeByIDQcKI9DRRzV4xMKPYlJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7088

On Mon, Jan 29, 2024 at 08:56:22PM +0800, Wang Yugui wrote:
> Hi,
>=20
> > Hi,
> >=20
> > > There was a report of write performance regression on 6.5-rc4 on RAID=
0
> > > (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> > > and doing the checksum inline can be bad for performance on RAID0
> > > setup [2].=20
> > >=20
> > > [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@=
e16-tech.com/
> > > [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6=
vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> > >=20
> > > While inlining the fast checksum is good for single (or two) device,
> > > but it is not fast enough for multi-device striped writing.
> > >=20
> > > So, this series first introduces fs_devices->inline_csum_mode and its
> > > sysfs interface to tweak the inline csum behavior (auto/on/off). Then=
,
> > > it disables inline checksum when it find a block group striped writin=
g
> > > into multiple devices.
> >=20
> > We have struct btrfs_inode | sync_writers in kernel 6.1.y, but dropped =
in recent
> > kernel.=20
> >=20
> > Is btrfs_inode | sync_writers not implemented very well?
>=20
> I tried the logic blow, some like ' btrfs_inode | sync_writers'.
> - checksum of metadata always sync
> - checksum of data async only when depth over 1,
> 	to reduce task switch when low load.
> 	to use more cpu core when high load.
>=20
> performance test result is not good
> 	2GiB/s(checksum of data always async) -> 2.1GiB/s when low load.
> 	4GiB/s(checksum of data always async) -> 2788MiB/s when high load.
>=20
> but the info  maybe useful, so post it here.
>=20
>=20
> - checksum of metadata always sync
>=20
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 12b12443efaa..8ef968f0957d 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -598,7 +598,7 @@ static void run_one_async_free(struct btrfs_work *wor=
k)
>  static bool should_async_write(struct btrfs_bio *bbio)
>  {
>  	/* Submit synchronously if the checksum implementation is fast. */
> -	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> +	if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, =
&bbio->fs_info->flags))
>  		return false;
> =20
>  	/*
>=20
>=20
> - checksum of data async only when depth over 1, to reduce task switch.
>=20
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index efb894967f55..f90b6e8cf53c 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -626,6 +626,9 @@ static bool should_async_write(struct btrfs_bio *bbio=
)
>  	if ((bbio->bio.bi_opf & REQ_META) && btrfs_is_zoned(bbio->fs_info))
>  		return false;
> =20
> +	if (!(bbio->bio.bi_opf & REQ_META) && atomic_read(&bbio->fs_info->depth=
_checksum_data)=3D=3D0 )
> +		return false;
> +
>  	return true;
>  }
> =20
> @@ -725,11 +728,21 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bb=
io, int mirror_num)
>  		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
>  		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
>  		    !btrfs_is_data_reloc_root(inode->root)) {
> -			if (should_async_write(bbio) &&
> -			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
> -				goto done;
> -
> +			if (should_async_write(bbio)){
> +				if (!(bbio->bio.bi_opf & REQ_META))
> +					atomic_inc(&bbio->fs_info->depth_checksum_data);
> +				ret =3D btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num);
> +				if (!(bbio->bio.bi_opf & REQ_META))
> +					atomic_dec(&bbio->fs_info->depth_checksum_data);

This does not looks like well implemented. btrfs_wq_submit_bio() returns
soon after it queues a checksum work to the workqueue without processing
any actual work.

> +				if(ret)
> +					goto done;
> +			}
> +
> +			if (!(bbio->bio.bi_opf & REQ_META))
> +				atomic_inc(&bbio->fs_info->depth_checksum_data);
>  			ret =3D btrfs_bio_csum(bbio);
> +			if (!(bbio->bio.bi_opf & REQ_META))
> +				atomic_dec(&bbio->fs_info->depth_checksum_data);

These lines seems fine. But, as the btrfs_wq_submit_bio() side is not well
implemented, it will work like this:

- The first data bio will go to sync checksum: btrfs_bio_csum() because
  depth_checksum_data =3D=3D 0.
- While at it, the second one come and it goes to btrfs_wq_submit_bio()
  because depth_checksum_data =3D=3D 1.
- Then, depth_checksum_data soon decrements to 1. The same happens for
  other parallel IOs.
- Once the checksum of the first bio finishes, depth_checksum_data =3D=3D 0=
,
  accepting sync checksum. But, at this time, the workqueue may have a lot
  of work queued.

>  			if (ret)
>  				goto fail_put_bio;
>  		} else if (use_append) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d7b127443c9a..3fd89be7610a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2776,6 +2776,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
> =20
>  	fs_info->thread_pool_size =3D min_t(unsigned long,
>  					  num_online_cpus() + 2, 8);
> +	atomic_set(&fs_info->depth_checksum_data, 0);
> =20
>  	INIT_LIST_HEAD(&fs_info->ordered_roots);
>  	spin_lock_init(&fs_info->ordered_root_lock);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 7443bf014639..123cc8fa9be1 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -596,6 +596,7 @@ struct btrfs_fs_info {
>  	struct task_struct *transaction_kthread;
>  	struct task_struct *cleaner_kthread;
>  	u32 thread_pool_size;
> +	atomic_t depth_checksum_data;
> =20
>  	struct kobject *space_info_kobj;
>  	struct kobject *qgroups_kobj;
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2024/01/25
>=20
> =

