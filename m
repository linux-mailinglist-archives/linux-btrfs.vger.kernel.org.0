Return-Path: <linux-btrfs+bounces-7804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA6996AD5B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 02:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD5F1F22A20
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C562E1FA5;
	Wed,  4 Sep 2024 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gqsq9Fzt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bGvVz71k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30D8827
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409904; cv=fail; b=DqEfZUOinOp0j4NWgG5qGsRa1J/+oKZZc4XRCWKNsAzn4HyIYPwGjikyM4qSJf0WLto7Kn0ePOvAmIF4WuI+d0fhV1w4pL0ygXO8aj3BhyGF8FFVb826V48n0kPsfF9V4SKFmi2xh0Y7n4ttclkBwKHXUAyCw26TaxVYpA45Wpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409904; c=relaxed/simple;
	bh=4eEaf0VUYh/G3tGNe0pS/V7LJzCdPIPrfSPAZD1gfE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oN5s9h7XECt36MOVCcdL3NWI3dhK1zyWs13VVrKM5G4FJlk/6OEYy9lHSQwlTYjSyta+RQHkSiO/2o0sODv3x+lMN6xsWapl7+Yb547fMdEg0dLskxIQjF1oYk6LoYEIaUdgD5QltXsixfnu6OtrMfUsZhZiNlS7UgPW6qIm+BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Gqsq9Fzt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bGvVz71k; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725409903; x=1756945903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4eEaf0VUYh/G3tGNe0pS/V7LJzCdPIPrfSPAZD1gfE8=;
  b=Gqsq9FztPuxsKe/6YYne/CtNy05iiSYdZgW4SfByfhQtMfmfsVaDpsHT
   EIeTgwaBoGpnwKLdFIUvAiHawQf+oyNJM04iK7b95MLfw49dS3XEtCSoq
   YNcUJMXwOjjpNBtGF543WlAgq/NvSgS938cihPoHSjbWUGMedWnfNFpRr
   dA6LNcTwVXKXO471K0aHqv9fLVDvg+LtYlGpREgG8dfRfbN9iqxqMM2Lu
   jydus0jwG2w7dfg11Q5wIcmwky37KjcxkWRWxOiDuOYYwEPk3Fdjsje5x
   9ui4YFM2N9QiLlBN17jouvw1xp+pvFrwq7pNJ+j2UOxymxBDX4wBMtKhB
   A==;
X-CSE-ConnectionGUID: uKfnAMqHSmuxNhZSuQIFdQ==
X-CSE-MsgGUID: cgsqoK0LQVe8SwgO4KxyzA==
X-IronPort-AV: E=Sophos;i="6.10,200,1719849600"; 
   d="scan'208";a="25857429"
Received: from mail-centralusazlp17010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.6])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 08:31:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHG9DD38Nl+r1GhwzrTU35Ap2vZRb7wEeaVbDY/9wLt63HHZysiXyxPpInChgxqlg3w0LMVnVrXIhbxlDWv8NjZY0pWytN0w4/wVA+Gcnb8qr23yoJbEIhklem/E2r+vPhx5G62gfmAzdKDaSDRLdAbqmNQaXg6aSHYDP0Rx3tAi/z4ySmPnPxX2rLAepEKjVxNWRNyeJtiGCxeMv6T1kerWn2KSUwR12jpF2PUT2u0VDXQ5cSodOOjNuHaRO7HhmWj32HUoJQo+0J7c6dvpQqiJbIVa21ACxPsiobmhMZe/UO+2L5hjnv/6bo8SGWxVyqG2+tMWghhCEvCfsdBfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kmu2SKWnhI/gSNLgncDGDAQLe1zzRLTYV++WGx6j3Fc=;
 b=m355f95XVAl8qX9ZgixR+XM7PMF1Uh9cQ+czOZbnXONCyRvDBSOrMT441b5Ai2YFcWuR8vlhCSezY7zlgqvuleX/5GlHAkylu7GeZ0obIKKW7FFL+jp4hTm8M3xS/mOLkNqH6S2kvzfvjDKHDkcKSXqKf4KHDsDjqacU4RtKv4trph+HEdU/Q0SOH7U2G8TGvJPf0bTpF9fwHmOQuBy5qtPuCPe/g1Hrt5znHQHCA+wPAk7q4/cqgyoVqNPYbDo2qlZiyrGUaUULHjzhI+oVw/yZarEgkWONEXoxHBJQLGgFvxBFNk2DVpXjXQLXeStlS95DntCIZwQWrxzhYBXP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kmu2SKWnhI/gSNLgncDGDAQLe1zzRLTYV++WGx6j3Fc=;
 b=bGvVz71kqpARf/XeMJcdX3phEmZQe5d5mo9ZSa63StI1sH+aCEQmQQ7Dp0jWYXULgFiaN+g5AJ3U5TTkLrn0kXqVtd3QZXBr9ohHaz1o8plCTdcZiC3pDhl5p7XW4xS4L32DXLADY4GNa7LhB4NDmsh7OXO6YCOQeOWPaW0bwO8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB7880.namprd04.prod.outlook.com (2603:10b6:8:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 00:31:34 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 00:31:34 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"xuefer@gmail.com" <xuefer@gmail.com>, HAN Yuwei <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: handle broken write pointer on zones
Thread-Topic: [PATCH] btrfs: zoned: handle broken write pointer on zones
Thread-Index: AQHa+vpKGEB1FFUXQkqUlBrqkZc6d7JE+DeAgAHVWYA=
Date: Wed, 4 Sep 2024 00:31:34 +0000
Message-ID: <3ywwsqnv5zzsppcp6njl2tb4wtta57arokdnonkos6dp37ndy4@cirv6lhl4dpw>
References:
 <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
 <20240902203127.GD26776@twin.jikos.cz>
In-Reply-To: <20240902203127.GD26776@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB7880:EE_
x-ms-office365-filtering-correlation-id: 25ce432b-4aa0-490d-2142-08dccc78ee09
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YIMqVDbaoQz0I3SGFo+lGsggjKfAYqAPOvZBdIP3WNVwjE/0JjJzEqbsnG87?=
 =?us-ascii?Q?6BR1dtpYTkiD/l3rX4VNUKQJmX+C+HLgDDGWtGnX6aYpQSQ6v1UpT7r4L7AC?=
 =?us-ascii?Q?WYRVZXYzV2DJjYC6J9YzqeijFS+2vMSt3bA5+Tj5Qg8ztw2R9z4t34SxmLNY?=
 =?us-ascii?Q?MCgKreyvhyNI9d7pE0yrVyg5L7I8J0QuxyMAOZzHC6TagxAVjgdUYHiu1ezh?=
 =?us-ascii?Q?KLjlvUYK37wSB8aexBnQIFxf9RxWEkko30mRGg6Db8DdhwIs1r3HE1OZwtcm?=
 =?us-ascii?Q?ms0m6N8gFAyuJIKRNQ9Q12hraw/VPPRmnXf6EMIvIZrEhyngKEm6Aw22Btuh?=
 =?us-ascii?Q?zMPb2Uy2bsIrSdq1qw52DPcWrDruVB1VgVbZMhv2DD8m937vIiFQDKG1xD63?=
 =?us-ascii?Q?OV9MWKXLQBUAMvWi6MMDc/pUnaidL8CQWMhklWT2OvF5332CTZGStA7X7Qv3?=
 =?us-ascii?Q?aAIsjSqbGWPHeinkqjZL9/eTYdcttobGU/0y74et+F9WD4lHoAjbalg4SYdJ?=
 =?us-ascii?Q?OnKShVEkKzNRSHUP6BsH3x5zntW7lxDRbShVXTgm/9LWI6ZEStV4W5LiMlDC?=
 =?us-ascii?Q?CVZqTnorqjRaKS1yQuZMCAhaNN7kIXZWwOKL7pz+U1w8vkWUAwiyPDbVEOW7?=
 =?us-ascii?Q?4VR35cNlIRKSFDqvZ4s+LYrDz0QcY6ujqmixDCgRhf/V92vYwf4qlolpJdfI?=
 =?us-ascii?Q?th9KVMEQyJ0Ht56U/Su0dbrOFyWToy/C+6Lq/r7JRr+qF/iJY+yiF88AMBXn?=
 =?us-ascii?Q?G6e/Toy3P9CtULC9/uY+Niy09cGfcgXLF/M36Wc+fdt2r1Qpx/I+L0D5SIwV?=
 =?us-ascii?Q?szU+WnwHYKPvpb5msBKVhq+8F7nrC7cEEwOf8GtLqlJ1vnb7d0L8AjzpkHC8?=
 =?us-ascii?Q?GrKLFy0vogA8E+nC7c8zNJ2XmUNUEodDjgMR0MSiF57XYAL2eR5Hfk+x8kPm?=
 =?us-ascii?Q?iIkcr3tSlRg4gmyXLpsSTxOL3uxAw4GUfdBcoXHdIWmSNE+MotQgzEsmunkY?=
 =?us-ascii?Q?wSqXfyz4Z+raSXgy2JrbmaNhXOC7GOd64wZfMm6XM0QJcrCVypF5PJkvtwwo?=
 =?us-ascii?Q?q5FbmEa2b2wMVfgAyML6rci7ZXVjpah8aVcFGs+9llw8UBeP+YGTZOghi1Y/?=
 =?us-ascii?Q?i/51LzsV+4GNrblHtu56Ncdv/sks7BkFK2IyftowDzsZkLGOyuCiRu8NIu7O?=
 =?us-ascii?Q?cXyCmZR6kr/wc+H+D6oIqKrh/b3gcneX/jsPFMcF6fe9xAUAicho5gtDomNG?=
 =?us-ascii?Q?fv554gRL9hns46GRbjdWYcf3dWAhIBvj5qrqldVdhcYeHbctrq+Bmdi94LE3?=
 =?us-ascii?Q?W4CSsm6uT2v4sKcV8l9BXi1vHFvjBy6VxaqpCJ+bWpScVlt6IHt2H+Zo5+Bd?=
 =?us-ascii?Q?iOmkK3t2Wl5BsZ0I6rNohqEOjm9p9QLrwW7apOp2VPX7tC3rIw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b+sBoS7lpyQMsx+ttYCz2Zczed2S0iY83zVRWso6F2O3BGXxbpLlGFDtugU9?=
 =?us-ascii?Q?+drqmsCHGOCHNN1r476Su1eoA16zNCpqsxfSdrR101moAi5TL/8wrXV5bxTv?=
 =?us-ascii?Q?LiR4XzSX+gDxr4uWxWMnu8GZww4mXmHlQtQoR2BZQ1sAhu2i4gwYuXKf3Zne?=
 =?us-ascii?Q?iaiTSI/OQBTOXcvhWRMsMynarrwZHpTv4dfZx6PAhJn+udrLnwBHcFdGSuKB?=
 =?us-ascii?Q?6AX7rTC5LRm9wlbL9hUQHcA6KXhrigBS0lcOAQihaPN0snG0iRt17GiztUXl?=
 =?us-ascii?Q?J7FEVAgu9Gc2L55yjaeV+AQkoRQNNxnNkYc6FpYf5XBz+fj/sdIDeMeVSt+w?=
 =?us-ascii?Q?vbHuJXxpsxMTszr9EfYZC78skUJNxN8+WwoqrxNf5Q9eW3RhNVy6MeODqeII?=
 =?us-ascii?Q?8V7c2b3UPMNzXNnF0Dz2FdtLTLtqM5H5KBoQqXQ32mPlGKzfXPpGKc/z9OgI?=
 =?us-ascii?Q?/k3P5Bypk8zohImfGRTf+JhSZMYG+S+L1Gi9n01xaAY9i1+xomY8nMA5VI5d?=
 =?us-ascii?Q?biJ9RnZ1j6ypjfRDEgFhp92PNHB1rIolCR8gkC1ATQ8BG16DKCSLHK38JnYQ?=
 =?us-ascii?Q?PMYME/hzPVm38JZbE5h1saVwnmlcBJeoYw/x3R7pUQgfitwSJgcUQdD5FbO4?=
 =?us-ascii?Q?fl7eGXITNdn0ySSdJuxyy0sqip9RJEwv+n8vEjxMQhq/0kzZ5vXDGoYXNnHv?=
 =?us-ascii?Q?v5yzQxOZTsC67U2EeNby+s0KLkr6sbeQBnJlewUPQ6vPBC3yHV6Dh5l7Mq5Y?=
 =?us-ascii?Q?9a/bgDGGGGu6gm9Fap9ezpekwHIxuryMT/2WgG8mMcmaUwoPXq4SZQB9Mr0v?=
 =?us-ascii?Q?OmSiyrQcpFSjoIJ3+9+ozhqKeWGuk1QEEseFg6PIJsHOY9LzEDk7ht8Vd77d?=
 =?us-ascii?Q?8N0UtfbcK8xe0LnbYiYnNYfR0cOjepawqQv8BAUMCJwYdV15Gh9XKPAU072T?=
 =?us-ascii?Q?HU1Nx0pOmyYy1gpu554Rmx90xm2mQGxQRinrAPWyFtqGji5GFkBcbt0udm7W?=
 =?us-ascii?Q?9lxPErpXTjbHMbE+8YXiuQpcqdaSPiNR7DyYCjJJ4YZr71I0Y4/AJAilyU8C?=
 =?us-ascii?Q?9taH75dFK0M7GRWJbvPOeiN/q/GJJs3dBAqyt2cPzms+mpt+aeBsnTHAuz7U?=
 =?us-ascii?Q?v/2Dul5Uiu5WtE/LEu88UwK0bWx3Oz1sEl3Qiio4PdirQIqF2Xqfrot+zBeN?=
 =?us-ascii?Q?gKzhdDVxfPvXamFMYBJJZpMOix45S87Ys0yrCuweZdGnNHE4GrfkY37+56C2?=
 =?us-ascii?Q?lQEfeZ8JNXd/ckG6xIXMnYRCEACtae/oA2MPT5ltnBrXMdlbZreVOMLLazN5?=
 =?us-ascii?Q?fp0dTeW10ctLpUZSVZnZMcjMJF+8MtwASdTNZFMa5rH/54fKQ5rUACXRW34C?=
 =?us-ascii?Q?CDM0epOREf+aPpXBFo9Yj6aHMfDQ66VZ68skERLakMEVJ5ddOrYrTL/lwSD5?=
 =?us-ascii?Q?Z8nqA8AchFzPg8kxc+vvbSJv6X2rG+3TccDsUKtwbkKCr/gqUHq25FT77V/4?=
 =?us-ascii?Q?taI0Hf5HmEHQ9LccVQfKINze+8DPKYoUTboI/kApWwUawYznG1uL0n2UY1fG?=
 =?us-ascii?Q?bEP2RvEUFtPMyx6rOBFhwJolqwN6eZVQcrJrA3Ow?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56353E6B99D722448822996C674DC316@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oKVlPQ2UStZDw+0qwV0UBa3YH0+I+T7jCZ/TBKs9pvSh+efMQZPBQ8yg/v3CLf3jPAz+dy24rjeR4OCoUxDBu8/G7mb8qtzt+iEJWHaDQbayQRTx5hUmUgYBeEbhxCqgaApWjNqhIxtrbRhTBlKimII/NBjpPoXMUB7AsUSrPyRp7Weg480ZZh05u9We944cvpphjRvDL6Izg5ZWIsxJFdqXZFDeLVZrtv4FUSBIuuPx7p9nibv4rBSwr45AYu9BV86JAsE7+QFXsvw8a9YwjIfqWaeeJQwuvrjbA5y/RKqI0dJAednjl7ZWOS7j6da3IyLZTK1WRlfd4oGgPGQYlXDJhnnRX/28k4nlEBM+/4F6SP7dZmlatPCecm2TfxgglNzKy27KVKxSyOazUVkHDvisj8uAv1jHLM23jmO9ZQo+yvlqlftuvvJ5fjZF7mPG61N0R4B37Zpf11/f7d1PWcY8SdvdxX2+gMu+J45PvJ6Z52VoSlkPhRF1JWDAAPtjpAzXPMkwZdIrh/RbUs/ATZkc9cV4CpZT30ckmCD5/McVRxDrD8MPOv5dUjCZPHZ8mIYxCBOI+4dH9bAZIA9W+HtKbbyNpucPAAQbVbaaSmUhb4M3llxxElypoF4+0xs1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ce432b-4aa0-490d-2142-08dccc78ee09
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 00:31:34.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smDE6M41ZLZ9g2+Rs7T9c4uJaGxkdtAw2TOu8Kngq2oVocFAktsxvDTP+6wPa3bCkYZGKyTQNBZ1Yi7d4f14LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7880

On Mon, Sep 02, 2024 at 10:31:27PM GMT, David Sterba wrote:
> On Sat, Aug 31, 2024 at 01:32:49AM +0900, Naohiro Aota wrote:
> > Btrfs rejects to mount a FS if it finds a block group with a broken wri=
te
> > pointer (e.g, unequal write pointers on two zones of RAID1 block group)=
.
> > Since such case can happen easily with a power-loss or crash of a syste=
m,
> > we need to handle the case more gently.
> >=20
> > Handle such block group by making it unallocatable, so that there will =
be
> > no writes into it. That can be done by setting the allocation pointer a=
t
> > the end of allocating region (=3D block_group->zone_capacity). Then, ex=
isting
> > code handle zone_unusable properly.
>=20
> This sounds like the best option, this makes the zone read-only and
> relocation will reset it back to a good state. Alternatives like another
> state or error bits would need tracking them and increase complexity.
>=20
> > Having proper zone_capacity is necessary for the change. So, set it as =
fast
> > as possible.
> >=20
> > We cannot handle RAID0 and RAID10 case like this. But, they are anyway
> > unable to read because of a missing stripe.
> >=20
> > Fixes: 265f7237dd25 ("btrfs: zoned: allow DUP on meta-data block groups=
")
> > Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid s=
tripe tree")
> > CC: stable@vger.kernel.org # 6.1+
> > Reported-by: HAN Yuwei <hrx@bupt.moe>
> > Cc: Xuefer <xuefer@gmail.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>
>=20
> > @@ -1650,6 +1653,23 @@ int btrfs_load_block_group_zone_info(struct btrf=
s_block_group *cache, bool new)
> >  		goto out;
> >  	}
> > =20
> > +	if (ret =3D=3D -EIO && profile !=3D 0 && profile !=3D BTRFS_BLOCK_GRO=
UP_RAID0 &&
> > +	    profile !=3D BTRFS_BLOCK_GROUP_RAID10) {
> > +		/*
> > +		 * Detected broken write pointer.  Make this block group
> > +		 * unallocatable by setting the allocation pointer at the end of
> > +		 * allocatable region. Relocating this block group will fix the
> > +		 * mismatch.
> > +		 *
> > +		 * Currently, we cannot handle RAID0 or RAID10 case like this
> > +		 * because we don't have a proper zone_capacity value. But,
> > +		 * reading from this block group won't work anyway by a missing
> > +		 * stripe.
> > +		 */
> > +		cache->alloc_offset =3D cache->zone_capacity;
>=20
> Mabe print a warning, this looks like a condition that should be
> communicated back to the user.

It already prints "zoned: write pointer offset mismatch of zones in %s
profile". But, I'll add a message to inform that this block group is set
read-only and btrfs balance is desired.=

