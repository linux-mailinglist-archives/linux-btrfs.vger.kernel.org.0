Return-Path: <linux-btrfs+bounces-8102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EF97B798
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 08:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5331C217F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0041531D8;
	Wed, 18 Sep 2024 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZxtGhnFF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cpQM6Ush"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE8139D09
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726639617; cv=fail; b=pBlLkDctVEdqkLipgKcZSeIB9QLa5OJZBKZG+trRCYJYDdFoqEJsPr0WJJcL0IANjTUeB7Gg9rlyEM6MXSLbMPGwZRjCxmA7N4N5ultAiFbxO8INLM3VVOtkuXBUjqsxGhzgJXbruYWVAsFPKf9XmBVtZ5A+uchvSnDUCpwYPD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726639617; c=relaxed/simple;
	bh=ueWlAZ6iL4igl6TcHY+wbXtjohI9M1qvqE/NAJnTilY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhsIHNuHaBi2YH6zguwdbzzINCrI6kiT+5LHXK1e2h4eIqFoUWnnaSQgXKq2jHOi5s301A7t14AUtJ7tDs2za/PbVWazhDcxvxJoNm1lFGGitpVnG7bO2AYs9pvNJ1QXRnKVaWZc7FjjZOMzkzFgcNYaSMd7wkC6Hdyajku110w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZxtGhnFF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cpQM6Ush; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726639616; x=1758175616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ueWlAZ6iL4igl6TcHY+wbXtjohI9M1qvqE/NAJnTilY=;
  b=ZxtGhnFFUiHSHm1V/X0q0Mv22zc5rxXlpvxNkbMvyDrINaNn0l7h2CEL
   0Qin3XurrEao1XZQTSn4z8/lCxxaUkA8lmn2jbkAZ5nx9jrbwYhc20i8i
   +yg+cALEHmg1olBi0GXBtRb7LBeDZToa+8htT9fQGslXcp67i1x35nNL/
   HND5bMo+vUfgT7j9DhQvaXy5mS1VnYhSniSjgunctnXgqcer4m4QQnvb6
   SbUaXE67HpHr4G9qP5fgnSn0tnVq9xooGXAQTxJ2/IKaXmeX9rEEdftYs
   /lS8CR2TMlK9gc9SqHLc5xJfDBxjoXHjc9HxXQ4cz7DmqUGKWQfA363J1
   A==;
X-CSE-ConnectionGUID: 2dE8I9AVQsWWWJ41KF3dWA==
X-CSE-MsgGUID: VQopgTAcQ+yefENqrV6ojg==
X-IronPort-AV: E=Sophos;i="6.10,235,1719849600"; 
   d="scan'208";a="26951001"
Received: from mail-eastusazlp17010001.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.1])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2024 14:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH7kA9d/3OXyxbsrlKO7MAJMp8M2lG7PMseA/SkgxkvrBtKxCb7D5jSmn95ozZ8VuOkkgLDDOqMOZ34zcI4MSPRNZp1Aocua2usHWBMY43HNkIz6kvCspERfHihgILkvK7nxvm7ckL/tyh5ltZkr6cyNY6l9tuoHggH0oePtMNbHLFmG0LJxC6WMfmcGGnbuXoDuLagkGpyzQFKwibaCdAX00B7S9QiMOfPGthZcJ2XdE82DPwmqXCae+F4X1lk52kkpBXOVuNauiaPBXBz7ZRLdPOQu188/hMfDWInjbpnTuKQp2R/6CO7j4P3sN4Yyu8RU2Qog9eRjXBoNRF5RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueWlAZ6iL4igl6TcHY+wbXtjohI9M1qvqE/NAJnTilY=;
 b=krJFY0KsAdtk+gAucBG6YjUY12uP26s0xbVRcbzD9ClM7YTQOHUC5waVi3xSAxSqrA8PunPlkXMH1jpfHA1HC6EXlvNEjjZPZAKFonRtM4FjxWiBfyWPyAz7K1CG/tnkCjUSYBT30rSAnpWNLcFbhQzlHJMmk6ra6xdwGl0YyVl9+dbEImILNSNU7JE3D/roYC7oHFIzzJIUuI0ykX+myNowXr9Wy/XR3x2/RIDgAWL2DdKAs+e45IraqguLtQldGWd/gg9swlIU6/iU5bFsQKA5Z5yE+lSR3507f4IxSJQ9CiRy/tEW+Abcq9kSOaMSzuBEOpXQnxeBR+Ts76fkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueWlAZ6iL4igl6TcHY+wbXtjohI9M1qvqE/NAJnTilY=;
 b=cpQM6UshWfNc+toj1IfKVAWAAM42N+GGrNzvx4XGOqh0+lhGtulHWIJ4iB2qhHwsctvD5yRWJ2ezdn1p0AfrLlCnhyqmnGHbDC/alew8RwcIrUgJYs0tTwNi4gxsx9HwOFKgj3oBDOiOto4dzfKmo7p5Dy8KVOXWYAwmCuHXJ1s=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB8101.namprd04.prod.outlook.com (2603:10b6:8:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Wed, 18 Sep 2024 06:06:48 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 06:06:47 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Leo Martins <loemra.dev@gmail.com>, David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: set flag to message when ratelimited
Thread-Topic: [PATCH] btrfs: set flag to message when ratelimited
Thread-Index: AQHbBiPVWxz1NWnxT0CQV0rmIP+H/7JcMZyAgADjyoA=
Date: Wed, 18 Sep 2024 06:06:47 +0000
Message-ID: <p6svr5p3q7yezuqsevuzq7jxqbhn2wbq2cjz43e3nuk5bxfxhl@pgkaoqo53byw>
References:
 <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>
 <20240917163045.GE2920@twin.jikos.cz>
In-Reply-To: <20240917163045.GE2920@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB8101:EE_
x-ms-office365-filtering-correlation-id: b5bcec98-4d85-412c-daf4-08dcd7a81496
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gvzsa3WoQYFNSgbY7ZcFscQ2lKaazGntpkPlqnG//yYnSQXWgGdHO4Ml9sa1?=
 =?us-ascii?Q?XbJZ2sJzPPdu2r8jfTHSyOSxCXvzpRFbIyuYH1Nl1Km4y3vhPwhJxweKtZ1h?=
 =?us-ascii?Q?DKMhua3d47z5i/l+wiWj7zdunS9/DV12gIBTBywrwZVj5V6RHHmxUnsA1uiT?=
 =?us-ascii?Q?nSVKgqTeQ++ZL4vF8Z2BdkxSpZcgk/7JHxfElQGUA4FstNSF31V0HiOnKhvX?=
 =?us-ascii?Q?GajunP4jRdb2IC7j0D54Q8OChxm/HuaViFm89iXbUSObMy+vyq9ezOmu9Mql?=
 =?us-ascii?Q?j0LKux3DqV60an7TOSO7T5WskVUJR1BUe2zgGAaXSYEEOJifLBDO7AXB6MuU?=
 =?us-ascii?Q?4vhqj1bcD+zTwn3xCFV1MvgJchxHaPcMD49eALfmHdDYB7o2F3SkVUF2+wCW?=
 =?us-ascii?Q?pG7B0vcwZl5wJBeznWWUvQiwPNug208MKzBQevIXN6ugTqpsT5DQDHSNR69o?=
 =?us-ascii?Q?pLI3hpQWTsVVqyvrGsTy4me9oGD5hnQ8ou2S1EpEEfw1cmf9voTMkAT4ojMq?=
 =?us-ascii?Q?rKiK0HfHj3f5OjVjkgZqBQOU/ByYp6OIZEHfrSFWPnp4l4F+bozR0RBNQ//I?=
 =?us-ascii?Q?HqyN+SciHjZtIjwe2yO8jiyV3HMUfnAuMFFMNNO1Tg9BvBmir8v3N/b/ZwbQ?=
 =?us-ascii?Q?aBLPiUFq9JUxvrHYViJlfv4pD8WfoZRjSqWtMo/JeoziGOzgAmT9BfMlH+Ua?=
 =?us-ascii?Q?i2kVjwzzJ+btgTeWaMX72zB+I41D5HkCRkI/dVtqwJslgVrEYz/5/TeOHUfo?=
 =?us-ascii?Q?cyBdNV8v7EXI0ww8DqN3Flyyb49IQpkpmHM14ME7G5ksVedKcbJOtHIRgEK+?=
 =?us-ascii?Q?bnr+yxPSRXBY/2y5+ixYkX70Y3zgU8QegLBe0rMgAGadLjQ9y9bPwuJbL5jI?=
 =?us-ascii?Q?nk1IW/9b+chThXxSPtVN3AEf4o/Lzy2HoYNw0uSCfbK+fC7oxCdkbftYqJaQ?=
 =?us-ascii?Q?6oVSVP4U3+C8XQE5o0YW/Q9b6Xk9ObV1I7ZNXuLUDHqmACEZCE9OnipeEDeV?=
 =?us-ascii?Q?JUD6dhKqfhits/07RYAPBTak2QOE84DP9zq3TxBIFWHECOsFxDJk7fLRorLs?=
 =?us-ascii?Q?A/ubNN8sJFhex3LrBlL89bly3c8i1ltIJrFdI1LRRz6MQ3sAYgUe+zj9DKHl?=
 =?us-ascii?Q?C+gFq6QMYa5FXURlo5j35DAmFE+PhVutGvzWrrZ7E2hHZHbSS7qXddnFwsaZ?=
 =?us-ascii?Q?+rLscCx89fv/ZOcH205FoTcopV0vTog1mAsYGqDADA8gYD/nh1CMzd2j8gAj?=
 =?us-ascii?Q?51gODkwC2R39OFbQjOBgONUSaKSCuH1iFriFKmnwcCwLk2hQwVdqrWzDpi27?=
 =?us-ascii?Q?OR8jEUEzRVlz84ndQJHCfu1+KaDdNviKWwzEMLrPaT4nzDJScQbROSJ2Nc6q?=
 =?us-ascii?Q?4JI0qX/4y3Wlo5G6FgTkPb6x1VqlDT//z5LVPY5Qg9e2NWbItg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9ltUL5TWHfEuOXy+ZHvPytPMnq/gxyO1jRu18QF11v7F29Z9qY/4AtwM1KSi?=
 =?us-ascii?Q?roH55UywGAqGHOYS+TAhBHwL1DIZZhfImYfyV3MUuVfCCxBVsQszMkl87IPt?=
 =?us-ascii?Q?9Nv6tBZPxG5DM58khc12B1EqocuBZsZ70LCVu0j7JOBpob0DkO9n2/GWupVb?=
 =?us-ascii?Q?VrF0XJNaoMnwLf/LtbsBF/cxEml4zMzPbTRsoqAHbZFBLMA0WEDHvX+EoViD?=
 =?us-ascii?Q?AMy03cag3UgGIAnqmG5wr6G7T1xHulKAebz49hKwUkKHsNR6Eyl5Y8rJM2H3?=
 =?us-ascii?Q?StTWqH1L96ARMVD9NWNF/0kMPoq394Loe/CaiVFcK6RZp2m3Dzyx86NGv19Y?=
 =?us-ascii?Q?yLrNwXqAFWuK5ex9Yz9rsrrT9tOLs5/eAO6LniFV+HarqdJCVTK4to2746uG?=
 =?us-ascii?Q?DiLo7HHDq+j9CZxh2wvHPWsMu7jkPosBVlviql6urcjVoXfMr6xLvePKHUGT?=
 =?us-ascii?Q?j1CX4WW4PMer7RSSf3gyqnsB0Bkj5k106LxaS9JeFSQ8zwoxbi45dKJOUp0c?=
 =?us-ascii?Q?k4Gy+X45rY/4I4N3kGmSAzV5S1Zy4calU3PEmhLA/K3mMplKi3dAhwN9BzyE?=
 =?us-ascii?Q?bO/KL+yHrqPwKUA1m7BVnAOvsC4Q7jF70RNI6ispQU2zRYih4LQONSbyorl4?=
 =?us-ascii?Q?mkWhbc/b8esW2uDINwmLdb1sMu610jS2WdpWKRzNgFOviCP9n0UQJz6mWaVv?=
 =?us-ascii?Q?/5t1wemjAkYpW06JgUS/UPSf67SC5G9CE5ojyUufqqi9ihJ31t3h95OwlEPU?=
 =?us-ascii?Q?+dhDWsXqKxxp8oRB6hcO2Z7wV9/uqDDJeVcObkA2Mo6PQknJGA2HL287a48p?=
 =?us-ascii?Q?0ehNE04zJyQWGt+b5jJ2qGgpg9mMgQn/ZUlrQJneET2K621zuNNM2aI0StVE?=
 =?us-ascii?Q?RW5cvUfLp9j78CGVSfLsigmd20XqNygi+HRCFNnEYS/iK7F1Ch7hy+uP9CYB?=
 =?us-ascii?Q?9bfdq7jbU0T1dYkUcsgFuXzjUFQwteSKFFKnzHmaAliiFF5ficIvLWeZD/0H?=
 =?us-ascii?Q?1VDmI1fmQExke3fiMgb7GZMwjaJ/2M/nV4d5Y69U6b/+Y3bBafehsEbe1eLg?=
 =?us-ascii?Q?0UvfdHTOPqDgvasSk2qe9WYxRqdhkB5RqgYCOKo9+zhvamtB3wiwKaiciB9M?=
 =?us-ascii?Q?Mndvpfvwx+0Ib295byFJ0aUIg98ZvKn7mxu/KzkPjdRrEw4EExverUq40Atw?=
 =?us-ascii?Q?NvRx7pEj/60pz5Nxhp+5s5vfRYObbZLZAxh/0sX87q9w0G16WKXBdkccXxw+?=
 =?us-ascii?Q?BBscRoHUXsl5mZPMFoIVqH4AX26KptJ+yIk3y6qW21ahr+OzKqNyFcJreaFu?=
 =?us-ascii?Q?vPvhyXEaizTQL1z1WBcN2gqKCOdiosVLdBucY8dwzwkge9AIQ9R6cH30bsxV?=
 =?us-ascii?Q?D5epyC4bmBR6CpePQhlfLjzE8mcCewHZC0j68lh8KdcvUJOfCrsHBrhofv+F?=
 =?us-ascii?Q?fam+g9n9Bk5ep8YVNlgset2lugtBLX4K2mAXFOb6MW7ZbajHyJ6sDg2B1hBL?=
 =?us-ascii?Q?hmNBYwS+l6+YAWP2ANNeeE496ZgOMhmY5qzpO/RBt2RhdlUC/HXkCnjT1DVc?=
 =?us-ascii?Q?f6GE+CL8IOEroPC6AeSQWnwaluZkU42DQ2BoBN81VV+H1YYwwy9kJpX7fycv?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDB48EAF46B2374C97796CBF426C392B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8EwaLvnfdKhjfRuJp6KyVmuxq4fbAjH2ESy5k9NWmvr15Ruu7lWBZFuoYJDuHMJmm+95SaWCx/WTaOc45hv2ja+CH9DJRyL1xmFB4ge9680T7HTaKOmqj/Ex6WbeEN1mRC92xk2m2BStUQi7wC3lpyNJDHNcUarsuaHdHW6LL4rm4S1AG61PJ5nheqPuPrXz/JPC0rtOZwn4nSjZo1yZN1fgBPMADtd1r1oNrnYNHwg70OyINjgdvFo6Zk21DSP04h011HNW2cBsdyugo5usTM5jzmfoR5sl5uPwhxOVVcaXkTXJFWji4QzFnFpp9ztZCmXKf14Sw8vO9FehOKhQ4xBzBSnc2XLzbe8BiW90SFhi0PQayUwElucOnli5V3/zyccP4C7sFwvSKYBgmZt65wo9QB/jU1XXoa6STpFRFzPHbpYoiDP/OvORyyRsvRk4tBpyCIvnvesOIFSnm6mSNmgagOBuAjlI/RfDKmjy/xmKzWp93cjkA7MVNNg5IzOLudkTkAjvTBmB+5cNm4CYMOXdDUbvulpX8jeuDjq8ZJndDRCi/T7W+mbRanMnMk6BP/uyiQOUv12OmWPUZVZn8R/brZSdgup0OlpGc62C0Am2AJ9/FAyV9fObGxsWKNzz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bcec98-4d85-412c-daf4-08dcd7a81496
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 06:06:47.9445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uj6MCXvifQGHz8ViEG0rCbzca0B0qNARbmtcO6F5b84KUu6U1HPamI13Y/Co1zD+PBA07Vy3ruIIhERbRqLx7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8101

On Tue, Sep 17, 2024 at 06:30:45PM GMT, David Sterba wrote:
> On Fri, Sep 13, 2024 at 02:26:06PM -0700, Leo Martins wrote:
> > Set RATELIMIT_MSG_ON_RELEASE flag to send a message when being
> > ratelimited.
>=20
> What does this really do? The documentation does not help either:
>=20
> /* issue num suppressed message on exit */
>=20
> > During some recent debugging not realizing that
> > logs were being ratelimited caused some confusion so making
> > sure there is a warning seems prudent.
>=20
> So you can enable it only for debugging level.

Adding my point, I often see btrfs_info() in btrfs_dump_space_info() is
ratelimited and the info is incomplete, because it tries to print usage inf=
o
about all the block groups. For that purpose, I don't think printing the
number of suppressed lines helps.

Instead, I'd prefer disabling rate limit for them, given that the messages
are behind some debug flag (e.g, CONFIG_BTRFS_DEBUG and/or mount -o
enospc_debug). So, how about adding btrfs_debug_info() which prints the
message in INFO level without rate limitting?=

