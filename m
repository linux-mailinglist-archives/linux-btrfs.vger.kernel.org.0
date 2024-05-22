Return-Path: <linux-btrfs+bounces-5183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD18CB867
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513D71F24ED4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 01:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9912110F;
	Wed, 22 May 2024 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FoQP4Juo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j8e4ig7w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCB613D;
	Wed, 22 May 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716340663; cv=fail; b=EIcp3Ri57aYIPIHZoMgPTUlxyly8NjVTiyLdXCnSawQOoy0GVgtmY6y/0ZfCz5aWG3GYCV12fmXOI2l3s+xEBVqrsPW5ZvySitItQsL0nv65iSHFdNW9ISk6rtGGo7PRfLigtMXhENU3yfUgOvz/GGaRLXaVCUT+A1ilkW+8lQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716340663; c=relaxed/simple;
	bh=4p523E0MyiHQilG78swaMoiHjTiDGNyXhs2RxWXNSes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9NANpVGyuoi4KT6jEUBOhrZ0GF9ZpNAfZL1Y0uB4gnx3PIsP0cPuSPlFYqFDJkY3EIQ+rXLwcEYUsIdkVG/mFusvUcNQR9rR4PtJRQIjvg86Aoh0kX21AKvOBtCQh3DoYpKT5NWUh1h7phig1eqdfZUpiOLZqA7GBxeL88ro88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FoQP4Juo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=j8e4ig7w; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716340661; x=1747876661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4p523E0MyiHQilG78swaMoiHjTiDGNyXhs2RxWXNSes=;
  b=FoQP4Juo+abIosgBt1w+p2/trMkukBRtWybBTj+Tnzcx1BC+lllVGJTT
   QdeZhTESdSUclMGUx1ZIfUe3N5L887SzoDBbS63oGr90BuWg60CXG8Bh1
   jpzMqvyLrtNDlS1y1LLhQOZ7fBV8UU9ABb5c6nTe4v2zvdUIZNsCgLyJo
   GoHWgmgK3cGclgvVnyN5bCaPuxyt+QtWUyU7ndr7umWED9x0ekwxnoFSw
   rEdJMIUlJUS35zZD6DHlLs6jo7s6Wld0BhcjCC2qpa78TS9zZw5j+wpej
   F9B2cz9G5rYStvzbfdKKqo8mHd7uG+0+5ut8tUvvwrhGNNrcTrBR3nlUU
   w==;
X-CSE-ConnectionGUID: 7m5aJHPaSYO0ZdfVuaxoog==
X-CSE-MsgGUID: esUdonCtTfGzXnU82hYq5w==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16894980"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 09:17:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2EFl4ClTjl3jUKlhwavv8VMlC1mENlU8ZOHJN52gALEHRVtlXASWLctRnk4G5NLviXUXXirheYHA1nntgTnFMLQZY9Ot4G/Y2aux0j8ZbW4jPBPC2liUpgfsJYkuAk40Qo3cSmvOv9TNpjJ3aKWn0E8uN1vADCiPu9e1VwMxgsZkozzDh59qg6n1H7Dl6/+rDIOHhPIJrk7Jg/MiXhE3OSWsOGsrGgbnWTP9HEi0y7l7tXM11QcdO60P1PPNt7L07EW0a3/jhpjsOFXc8nYtReMBYylDeKDOfHKE30xipOQvf9/VkFjAoUQ/jWvsHya89zvWxrQ3qE2SR+Zo9EkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p523E0MyiHQilG78swaMoiHjTiDGNyXhs2RxWXNSes=;
 b=XNPvtUyNGPSoHn/bMO8UuqNIUzOMA0mMUOgbSRuJy2gqmxgpx/NNzo/CSe4blHD+pq+lS5mEYhnzuJP8hsluMX44M63nufMZydZDE4P0reNBKnc+ix6uA7k8L4HcG05SBk1EazQwtmODW4A89W7ykSrRKuXOwTn1TaIK1/3zIqn1y32rgr8LZN/arO3T/2WR91/Alm3eMnhJQXm7s6V6l240nHHrYafel/+de2TnU4obVuV+wmv/VjKNaOIQF3hyX4xzdha6Xmr+DC3mNli7bi2bPW1Gy3ZjZ9ogRAHq9kDYuRSEFoHTtfQIXnrgg+M2NyGpyBkF4b3n4FnTAZH8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p523E0MyiHQilG78swaMoiHjTiDGNyXhs2RxWXNSes=;
 b=j8e4ig7wzHzwc04KvuQrqVpGTV0Pqlhqk9P5AvHNr6Vtbga92Pdv3ZBfeX6Hw6i+2foMLrTGT7mWEEcm8yX16IuebBPTbLpV5qM7in3S58cdXCxFjddeNk2WS4IOgViksicez9p3oJ2pTyHruEOkr9y/pz3Q0dI92FAwj0Lnuok=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CYYPR04MB8879.namprd04.prod.outlook.com (2603:10b6:930:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 01:17:38 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 01:17:38 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3 2/2] btrfs: reserve new relocation block-group after
 successful relocation
Thread-Topic: [PATCH v3 2/2] btrfs: reserve new relocation block-group after
 successful relocation
Thread-Index: AQHaq49Qo34cBrrQl02gNQ10+Q1KXbGidIuA
Date: Wed, 22 May 2024 01:17:37 +0000
Message-ID: <rsj5r34ea464ckulccbwtxc4spqfldgwvsyq4kxzf4aztrbarb@ulotgf2p6n5c>
References: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org>
 <20240521-zoned-gc-v3-2-7db9742454c7@kernel.org>
In-Reply-To: <20240521-zoned-gc-v3-2-7db9742454c7@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CYYPR04MB8879:EE_
x-ms-office365-filtering-correlation-id: 717667fd-ff51-469f-5553-08dc79fcf815
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yTzGwfQUJ2nucmc/9pih9gqfRjdcqASDUGAOiJ9fZhUeQfm85pcI0zlokZbT?=
 =?us-ascii?Q?RAF5c6TuMNL4kDxxDSkPMp/F/fsLrwpS6DfR3sQk3BJ75Gjlze/MGMJBrMu4?=
 =?us-ascii?Q?TS4DnYJxEed+rLpmmn6aOM+CmmglpMdbZHXn171q+FdsnBiwKnsuXUddvP0Y?=
 =?us-ascii?Q?ZRrP7JMB0MHVYgemIwXp9vPZLT+cA0x71pUntPT+n/ve5E28PB3v8OQak+Vg?=
 =?us-ascii?Q?+1G5ytMuFjsmgZfK3Y5ZuzlX+oqxG8ejs4dTSX8Zaf5SNo1m4gtVh4AF5vJv?=
 =?us-ascii?Q?tEppxZTEM3BrGudqB79/Snz6B2VbrjpWI4UAfQj/e26X4FdgTniO/HqTp/Bm?=
 =?us-ascii?Q?QdROozs458xS73F/af0F3JLbLUgmGWdMM9yPJsNMk9032lSEUMN6pHvYzLfa?=
 =?us-ascii?Q?+d0ewrs3O2vk6CJM2XbtqQfRSKGqpuLetTd2SJoygZE/k2vSRp7OjclX7oWH?=
 =?us-ascii?Q?BZymNuQYZi5vPgKVnD4FRVBIdWkNtYzYYUg2NjfrXdsRY0pWCFo1ktWqWyzU?=
 =?us-ascii?Q?uNVUfigFFtLvUR208pTNndLyC15yDQTvbscdepi42p6sH3LSFAWwO3Oys94O?=
 =?us-ascii?Q?Pca+LcnQEujynvkLDZQYvDfbwXAB8W2D1eab2IdqANJ5ypOGknJnfTRlSgOl?=
 =?us-ascii?Q?S/iqV5ZsruHN4Zai07br3ZQOCbg4HI3/43SiaT0Cils0UrlNcvxqJymoyqa2?=
 =?us-ascii?Q?nkw5YuVwmo2hj8AuQgSGQ0ZwwsXxPQO0FUqWiGJPunOr1+QMX9z3wpP/bPYe?=
 =?us-ascii?Q?kLJgyTUQs9ZMoiuSHevnuhJzECqF7qmZLj833OwA4voQIs99DbuH55SLCPbo?=
 =?us-ascii?Q?dtNhy7392Ua4M1o06bKGF3rCXRQISTmm42/BGSvymBEc1VtfPY71nwXXPESl?=
 =?us-ascii?Q?97QSuoKTNH1s5S2gVatV/0b1JsYHKP15ou8hHPi0cra5Tv3PNsRaC92m0EOB?=
 =?us-ascii?Q?fYwkLtkuOzimHO90jUoj8CFfaUzUlC/uGFJBvRUDll9bVp2YTo00iRQZyWyb?=
 =?us-ascii?Q?YAIERX4N9S86HBSQKTkQyRVN/wljLTFxlFeB1LrTYVKGX16HtcbmQiwSrtYF?=
 =?us-ascii?Q?9ggeSIp7BLG8z+pTZk5NOP5o6E41mJaEHZ/K1MQq3YbWmXcL8yLgqpiXqXlw?=
 =?us-ascii?Q?RN7V06v5c/46f28fIL//jQwlNEnvqDf/dGTvgX6SozHFqKAQPnjD3fNF9ZU6?=
 =?us-ascii?Q?Ybuj59FbnpGVWDs3NS3smJea80mX6JQ9H+g101h66yZF6IVOdog1jSSVUiS2?=
 =?us-ascii?Q?ekPNHK6vECJhkuwHW+Vzt4toPQNQaCtTRf04IWnTAOjLKhXlT9CALU+vOiUE?=
 =?us-ascii?Q?BxSYKfUp8mpXDhetDqpErdwzqPu3e7toklf//sLvNT0fPA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ubgreV4lgdDwXGXw8Q6giVp2WLVoQZeW07jiR35lskZWn7MagXcSXGHc4Vng?=
 =?us-ascii?Q?3X6a8z3D8yZHfpx+vN1Ooqo+GleBVZl/PU2cBVas33r2Ak/j9X0SPmXYIT4L?=
 =?us-ascii?Q?/IrabMxom9Gw9MevU+fFySachjaevBYiSWdrDCVG7PJTj5hEPKuX9SaeA3ru?=
 =?us-ascii?Q?IkC14QFUR0Y/mhQMIJrZsz0x2rSbS62zIks/gn9t/LhjSg5HGz6P22BiFU3M?=
 =?us-ascii?Q?ZoxHoOEJsSkphhPlEZtAspFC2jt5/NvNcFh/yoknzutuH47gA1ZZz9PuR2Mh?=
 =?us-ascii?Q?bjTXyMeQQIiK0h4Y0dC5cquF7Ik0etIkeeTKp8KevME0YMn2BZNJatzl5CJA?=
 =?us-ascii?Q?ouf2hc4zNWmehnyBE0cyB3/G+DBa/pcOQ8Y/8IKZcV/q7zh2bolaLZOgOKZO?=
 =?us-ascii?Q?Dk17g0l+909V/hSE9v0lO6X9J9y5LqO7gLEHPWH2DWpZ4HdzuHBodEJPxxzo?=
 =?us-ascii?Q?o3Y4ObA0rnDiSYScVxOHToLrQYFqYHFbov7srs8WQ/JXpItgaecr8GzXGmGP?=
 =?us-ascii?Q?WbOiqlv25QB5CgLX9bLqWjQaFg5tnD3V7TIn8FnChU6wjvrLHsQbmWxL1bDm?=
 =?us-ascii?Q?94V4uAkHTRMOjs2KYlEhucY8kmOZg6P1VZ8jdHDKY2+0U9Y22HZnw73h7ZG8?=
 =?us-ascii?Q?vFwJgFALXLelNvBr6Ezu57i1Yt8YbFUYsoQ4orHaqOdxQ4mrqw6ejr2ijDxy?=
 =?us-ascii?Q?C7748j9Wgk9l6kh7MDHA7/4vCxi1wulmA1ukJz8hTuFz/fLwv8fSSPZB/Dlx?=
 =?us-ascii?Q?+YS9GLfhhsJx/vFsncHfntCNV/caxjv/UF6LhQst7uSCMoVai5b+yepavG3o?=
 =?us-ascii?Q?CfvZ1sCM9abSNimlxNCEcjbhERWU73BvtuzQIvdDnARMVXJ85brDCl/7sbcG?=
 =?us-ascii?Q?ULu/O0vKdgBe66AFQd1DH4WSqfVLHc9CqviqSf/To3knLvK5ckwhunnTxPLd?=
 =?us-ascii?Q?s1cEZOWTWVJ/eu1+165MfUY5MbeuI5r/xHllxG9BBf1dJt6F8ppoBuMpS5j+?=
 =?us-ascii?Q?2ACbaqaabMmyNyCI89kfvn1cRA3CBdI68ugm9He3qZ4+7xgEnrqaFC1Bk2yj?=
 =?us-ascii?Q?GcIQgdNXozV6XP5/i7TgVrZfsiwaoX9Ymx1p9Wct/n9d034VRwkJmPVyl6+v?=
 =?us-ascii?Q?cG6xyYtR2mdi7LArgUEg+1GY4Ed8aCkQTXuMFD0TUmuajP7ChCgMSCkTGeVT?=
 =?us-ascii?Q?uzRn0uLR3xRZuwWFOeaTrRq19wtkB4ydGHFqXUsNlsKDApfTsn/oDkk4UsTn?=
 =?us-ascii?Q?2/YMxLTf3Qs1671fr/1JyBZBPrVUNoWPXE7nLg5qEjC+tL3Kz+3wxbbeoEFi?=
 =?us-ascii?Q?06g95P4fg1jEMWBopByPiHdKl3hJde6D9GaKxrT8LOyOP8JfCGD0iA54qV1N?=
 =?us-ascii?Q?z95EVkNGzYR7iNwLbB8eN4brBBycHf91EujlbTmxZO/9G0TZ9J7a9Y22vSCn?=
 =?us-ascii?Q?GoSV5gqH3CA586nfJr9H7OFo+vRa1ElERjKuj4bCb2muoiv6ISdH76Z9wuGZ?=
 =?us-ascii?Q?1OnpNGdXyKrdTZ12C1DTlQu1HjzV2LlZFYWXebZGpyPdE9TQ1FPjjyVenypD?=
 =?us-ascii?Q?EHiseZobjZgPbz9q/o9ZfCx+MovCQF/qi56o7pl5l1zIeFpiKGhEXVp+Y3kU?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C91E203699290E4C8D6EE87CCB56C66A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3moro5TmDXhKdkH8HozTzwoVTKSasl+KoSf8muruYvKibd7YhxK6l5nGsfNgCB3UNcqzSFigiCI+V8E7WuGQK6wNXbhvgONwaUkaKcJH1HQ7kr/3Ktefhx4nExadY6HA0ZQWYHjJpOsNSJnqV5mHDMSpRta+mbElk1U9GjWwbbMU5squEZrSk2wG2hYdNRfmRXc9CH2zRtP85wtjnt4D4XKK7Qj6wIJoiLCX5//jVOz88w7cLxqqhjI2quBoKUjvvI7jqgOd9Q8KLMnGBfZXTRWppVNO6gTiuW42edKzikcTOrOu/RA516T66EKQz9glX1jcdtyCEIa0VPbfZnJBle4G4E9rQi1K74kFkLdg7nDyuHuoRQQpbzcKtS5737hdOe8DcWsaoeGvM9hFmhqAwAjxO3EeBUl9pwUbqmmSZPMxWHCsr/3MR/J43LrNHyqdDs1DeZIaQaJBsUfNPw8gMYss4JNu0QJxvSUSyoOX6d9mwhl6FL70PmgUqMILmQKZzU/1cWGWaYp5bem4r586TysI3UBjWxgoph7O1NkXNvyOAOFyEnP5Zty9/oD3w8BNyo0Vc7WvWbriBwWa5KR8sIFNJPyYBUjfJ7e2WnCNrBPSkgJUKQ5MUnWkXWdmTK4+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717667fd-ff51-469f-5553-08dc79fcf815
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 01:17:38.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fq9Esl0P9fQyW6B/637Xcr2L3jVjbRzlgCDpp1XVW39AZpEWTSARQtUJxuJd6MGiIENH+2MkA/OyahRWVxNSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8879

On Tue, May 21, 2024 at 04:58:08PM GMT, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> After we've committed a relocation transaction, we know we have just free=
d
> up space. Set it as hint for the next relocation.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

