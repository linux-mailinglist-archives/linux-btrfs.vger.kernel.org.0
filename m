Return-Path: <linux-btrfs+bounces-9701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145649CE4AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995C21F22AC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82D1D5150;
	Fri, 15 Nov 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k89UKHFy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aVJxNZd/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE11D433C
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682531; cv=fail; b=Vp4fkQiy7eDC/Oy3Cik3x1IMvcFQ2m7TFI4TDVf3cKvuSYyZz098z1Aa+Xi3I5JvZVPTbWbleg0BYTuohKxN0JtYo0h2NCpMreS5mT988/YhI6KPaB7ggxqJyjHenXDM8w86mZ5drXU8NQKWrWSFf2qFHJ6xK+gTF7aq+z5iYw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682531; c=relaxed/simple;
	bh=3T+GGniCFwTJdj3ZTIW4IiwBEUnbonUZ6hVpgQxdgoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1Cvx6ZV9xgHPMvfmdoekGpr7RGlhzC+iyq3C2ncJlXHyt4iqg8cBqKQpztRmAkP5MgmHzDl+Fk8iFgJcjmHdWhpFoB4LNdFJNOEjLsNdk8DgZyP2TJSQCE7/YZzUbOJBaYn3szDesinjovyVAhCYLlkk2QjPxyzARm84NlQyI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k89UKHFy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aVJxNZd/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDF7x025341;
	Fri, 15 Nov 2024 14:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mNArQ+Otgbin1oJPvxSLjbodNaWhwtQxHn8IJZK/gjE=; b=
	k89UKHFyOkdiNNGLKpPT2PeFo2ynNQID9Y2k2I0RZJwgF8G42aBLHbOrbJrtEJtV
	Sz9af6cR6ud3DMbUAH+nWtQ8em+k+7R8QRPHNkC1oN57vmrChZb0dcipOtHclH9v
	KL9e0ZKFZKNDXtaRQAlos7h5BriMLIUUUjPpUdPGSM+EDMzbVKB574OhyoV8xGX4
	lnsxtYLWVRQtiHGuFHuGQ9XVsqXbNyzf8m0A60/fx//FIjZG82qyrx2darmU++7T
	lCDCVoVLJtmH/d0PB7uVCC/1vb7zA61L14Ura4jMUvGoPWy7gYFjTM/V1FKlszsC
	drfbvydZn4BCoQwcAxFtPg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5kdkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDGjF025853;
	Fri, 15 Nov 2024 14:55:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ca41n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrtfkr2T66oWu4sSBILU+waZw4lWyIhOqXv9cMdtZKVi4GLtNG6ahcqDkH2H9I21fzoUnxHgbslAZXX/LktNu3dbCeGUrJ598vth5OMPXaKY2nNffgQtnWLwUSDo1diDwiKnNVQ9pVqweqhlQUs7iQCdMLyfJOV+HhOUcDJeWrgrlm4+7JyXCkzJZKXORkMYeWXpRFETQCI1vRAOl/5vpRLYWh0PCpNBss9rykNJqUmYr4xvTmImFCg1VPyLjbRPp/4BJpylzCmf/puZGJRlkSNiEJFJaMumipC0YfP7cSDbdKwmJ6ma80YJK6QrZtfJT2tMRHkvXF7HLf+D4T9JOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNArQ+Otgbin1oJPvxSLjbodNaWhwtQxHn8IJZK/gjE=;
 b=t1QlhnMLFthtMY6Hf9e3rMKnXFJ6MxfcAQ/nWrg3mNBFacHGogOJuym1PffyWyi8H5vInxYse9t11XiP9nq4E0dhUxaiJJsPDC+rlPkIouHY8eqxqpVBXmIag7qf2R0cmflS7fQ3FHa1H5QBI21jaeDLYHVt082tpTpCIAa6w1vQql862DxIJlWiAXG/lvSRxG1BHlTtjGWA+PWF5bMVawogwQlRL0R4O6PKnNO5f4fTn2qSzs8LhFlUUBbSiDKDcBIozEL23uTeZeMvkHwLnzDOTRH4AqH922Rwrd2gLbbsklS5IBstHwBGr0GwdN1arIbDusntWUSq+8t/t7QHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNArQ+Otgbin1oJPvxSLjbodNaWhwtQxHn8IJZK/gjE=;
 b=aVJxNZd/RJV9TZ3rILZkPawKd79ovvn59hCpFZ+lUrS2EIA0bKshNt2vuKSpd4vI5OgS6cDhJ7a3bMD6ZLrYi+PfU/wn3yReUC1nr86+U/cv6+HRtucpfgVUUbIQVM/zVd+BWS4jOxPGe9B+2+G+YI8/9/lkpA/UQ+JW4sy5TDo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:55:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:55:16 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 10/10] btrfs: modload to print RAID1 balancing status
Date: Fri, 15 Nov 2024 22:54:10 +0800
Message-ID: <363f635137e513f902e11fdaca02cc0689d62173.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0f24f4-3e04-47be-f981-08dd058583fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gt4GyURMHYUf4HzhEDN+oCdksQQCMSLVEUeLjoiL/JjI5meNtsONxM+eupf2?=
 =?us-ascii?Q?sYPgewJQ6eaE2ruHALuwUXNL9nM+wE25cLN4XLFr9wemSQWsD2dxL9t3YNWV?=
 =?us-ascii?Q?f2jE7TMnHSa5jZ85BD/msQT14POwNP6pZ9nsPDiPfo8ToP85jycegwoCu2rJ?=
 =?us-ascii?Q?8cEgEayy4XXXWFcOjXO30MWHeHmzZjJbN8whh10yZi+yHi2Q9ChMStwgPl4T?=
 =?us-ascii?Q?ea9ritBQlew4HSkW4k5ElU0HK+CsLtJbneh94ijLIYEyGcs6sQouPP4EtUgA?=
 =?us-ascii?Q?uzfaPP9+/wzqvZqLi0Rkn7FyWILPrlx9BE+eFbAIZELx1tnpnpu0N5kxFQtD?=
 =?us-ascii?Q?+tpv4V3wvVwoYrShe3OTTEG0Va9RYwb4JF2mv+Fvz3EMVTfI3YXcrNbUzbHF?=
 =?us-ascii?Q?9hsdEuZdh2l2n8AUkGyc7M3hw52CuqC86KvbNIrR6kKrYaDy1Dbll0WzxFAk?=
 =?us-ascii?Q?8TG/47a5cIZ/AeX2SRLZwsahOzbGgM0B9Kj3ibmS0IhRJQOlUR1BBJhiQQRO?=
 =?us-ascii?Q?35mbZbiOq3/4zYq2Rwg1E4cGsmVnc6DNKRR2pdF+SaAgPvtkHj6G3BmiEx1s?=
 =?us-ascii?Q?mC5ptXTMmCcSrS9JQwkC+F58nRRDrfRQG4mwCwNrdaX3ZVp1qUW7ayse8xtC?=
 =?us-ascii?Q?4KezqyomkZlAFhebnii5sjt0NhWC457IKd+MhdXkXFhRTUQ1m0euL9LvA94b?=
 =?us-ascii?Q?b6MRuo27/QpVR517OQc0XFueM3ypj2rgCA/v2g0Q2QhqzSdmsKOFdcvum/l/?=
 =?us-ascii?Q?MmHQ3Ec4Qnr89vIcG7VMPjdH8h5OyeEHjUjYLPaChaiGYj1ridCkJDSxvi9d?=
 =?us-ascii?Q?hk4C13LzetXgK7ld0waBHbew1hvVHH7UHS7EXSwcYZOkQYL7KGXw9OeA2XJX?=
 =?us-ascii?Q?Bmnv/9j7P1M70bKMGE/ocqThMx0+FeFCg1gGrm52ZVF1aDiZ2XjNsibN08Jq?=
 =?us-ascii?Q?pjFvmSfp8zI0YZfR1bjeeA7zmptm8PmfCkBkefWBgnaXVTwf/KFnUEzbtM5u?=
 =?us-ascii?Q?1z5Yl8J+EpiE97t0YLP1cTRuWpYLT/EXb9+GaKTsnwLMSwo04hi9d9tIaqbx?=
 =?us-ascii?Q?YAaOStdwEi7szygSsWLU0R8eDCIvY0Kt2nDyk7FzJsKClRE70pWl2EVXS2x1?=
 =?us-ascii?Q?sUdMZAfiKdkYbhT0rltCaJg1HLtzRU313qNFCK5tBsBWE+Nvi9lMD9PdI6I+?=
 =?us-ascii?Q?zsM5s6KV8ZlnqWSHYFxqig1Rx/05c4CNWUjnFEebpBVwcPWGOe4N0aXDqCRI?=
 =?us-ascii?Q?N9tgvtvhZUFJuIS92vir1LMqpnMVmxzLDEp9re6NH+yvZ6t1ZoSJhsU9x3et?=
 =?us-ascii?Q?rHljtg8KjlbqRp4IwP74j1N0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K34MyjiY3/0g00MZZj+u3vNT6ZayqVtuyKkosilmtU1fPs7ppklEaTEr9+1j?=
 =?us-ascii?Q?t0A6cw7xjF22X8RNBuPfjdvLDEgO20U/MLxqML8orIEU8a7GvADZyWis5ElC?=
 =?us-ascii?Q?67JpNEQsPgHqEkjuq0WefBzIWi8aaW1hbDNwHyaARNw0FkX7yRP+IKzv4PhY?=
 =?us-ascii?Q?XVgWWj5+K0vyrK/7CSiroxV5vtZj6Fh3Rdqljj6TjtV5QqpJjr9vLF3WUtu9?=
 =?us-ascii?Q?4UcYUohBXMBWkRirLdYNH8KOwDH3+hSsLMuUQKD4kDPVNdGFA3Y++7aDh4I7?=
 =?us-ascii?Q?kXcpS8aUQO+eY/L8CxFpUFlfdw6k0j9xiHkJDgCkMJc+n1Gn4PZLnLXrFuc/?=
 =?us-ascii?Q?qdRNeKMlVk2tWi/rxHrWawHNVXFIAqOwoHj0mqNLPZIqG3+RDU9CMNLA/d9R?=
 =?us-ascii?Q?YGQ+k7yVeuUOdylBl/fTYXo9HTxLERrDs6e2hTIxWe/4yQqDCIcbAZ3i1WcN?=
 =?us-ascii?Q?QG+5c/KalNcRCiFMTpz4qDMXNZxiLbDaXbqEn9e+yaUsGOMpT0vkpUWYWYKV?=
 =?us-ascii?Q?WvME7R1/ICajT3f/xasVNzOBSOLwBFyZil2AGntAa2zULk7GcZu0RGw7Y9Ro?=
 =?us-ascii?Q?mWG0obok7/n77vYugb4bLKjNxzkBG4JuNzFj9/tKo1oh7GPTYupnN8rINcVl?=
 =?us-ascii?Q?r162KW4FR5lKblfFrmWhi7sQhDmGnC1kkyaf3P/g5OEZSf4eNalsmDUVk503?=
 =?us-ascii?Q?GdbtNdwqYLh5pmZ4nmAgPrwhuc6PMuGfpSn7smu4LflWNax0CjY9VeHj0oyA?=
 =?us-ascii?Q?ApLnEoB48rc/ZitoF3QOL0rtfUtd98kY5npNKR91g/BKJeCRAqrrSkgz4XJr?=
 =?us-ascii?Q?fB9XnzWPf1D80YDsF3sbEHYQOOM2jMXZdC04CcHlD+RwbyqOyeoy1MLVtD9P?=
 =?us-ascii?Q?2duXLxBipnegWe2vaJgq9BdcQQ3RJK2KZsgDkXTznToCsIXAIyLrCrUOhdPL?=
 =?us-ascii?Q?M2kVXoyQu9w91ZW/qM8lUAVXhZfFzoc5kT4WRCFMHaFQHJO8t/TynIiv5Qku?=
 =?us-ascii?Q?O75ebRA3P9bMbxYFjFxefbUq3eHF5L1xzqYGgP42N6tqVPs5xKQLd0G71Vu0?=
 =?us-ascii?Q?791ojiV/QSRQB/P80ng1vofhq6nupI50xhQddNs6yUjrUZcb8obDOTgPXjb4?=
 =?us-ascii?Q?OBLi0nmG2ewqwnhkz2bc+0kCYZ8p60a1l7VO0CB5wODJdTzowzIZhGFgQRI/?=
 =?us-ascii?Q?1X2vu/i/kCQF8fPFtMBYykCfUGL1U0HmfbRn2XNWFMr477265bxB5y+f9uIC?=
 =?us-ascii?Q?EwqOxpWxODrGIMsCBqK6yQVxRNWV3OKuVRVSadHzURVChc1dYz3GvwYuN0+R?=
 =?us-ascii?Q?S187tMedjITwKpLqBeLeCeHTBXD5UyrURyXwm46X8qm3rBHXSifD3ry8xjJe?=
 =?us-ascii?Q?nHqDhy9k+wYNB+fZzN4rPCZtxC6U2x9MBiFFHffigL/zosWaUwHc5kDwUWfA?=
 =?us-ascii?Q?vQL8RSopc+7x18yTKhFGieiluV69qFXJHAiUcNL9pOiXAymVqxTRMA9XbP32?=
 =?us-ascii?Q?hm6tUyeEi4iB+dhYi0BfTgUFIFR5aiqgpyiR3/5zoTWqDlvEcDJ+SfEcnDqQ?=
 =?us-ascii?Q?UdYFo+TxdCDMm1UoBck7Xt8DhB2VzgcScg7QxAuC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nxjKOkr5KeytHLnihDWCnhMWM2yRJ5IJ4VsK6UneJdepJuE2kdT7U2rZ8H2zlLnMoIWxZchifv3ZnKEDjPUSAROkzb4vG02ji2XPt5VWm4midzv9cX8G22znNgjtKgClXG7Y6fofGHYJr+3mHAV+dZospvVzTAJdDHfpFofXO+NhenTTZPFKRzGhm4o6tnzRtIz1Fy30S+SMO3tZewz0NoB0Sa9g2dGy1B2h4x8eNy/6NSw2MS47vh2KcK+aH8A287UmhSDH5r7N91B0PKArvHa+GI1eZBJOAlNrL1lt+DiosZ8StTDZJDJPWhYx/v4b0houvEd6JZIicZQFYsEwS2lBcaopw23BOlq5V05f2J94nGqheJ00sEPl9WyuM44E8BegW8TuZfxpQbo9+4v4zQ2Qepsp/7u4+k8mk7RDFZofoXDaXJqLky0O5dZaNvxI4EV/ol6COBoCxA14EXxMNVhm5qOQPDJC729jsPqPjcZlkQ+wsGRv2yd2bAxqKyiyTtjcZGwPp1JFwVpXlBhxzbrFxuR0ls2nRXX1tXKF2GCOwG2U5c6fVRfF3uuba5w9x1aFK4ELdt45y9U21b1TWiWx433HU8339L+frrwLqNs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0f24f4-3e04-47be-f981-08dd058583fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:55:16.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq/X9ZtZSr0Yhuw7ywayNncv0NmI80BjVX5dPU5lz0+jEw2tu/MFao+0+Zo/ez5RrsuPlsFf3i/qhKGsmYAAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150127
X-Proofpoint-ORIG-GUID: PD8GjOMc2KbUW5i837KJRLmMsR2DfD_0
X-Proofpoint-GUID: PD8GjOMc2KbUW5i837KJRLmMsR2DfD_0

Modified the Btrfs loading message to include the RAID1 balancing status
if the experimental feature is enabled.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ecadc8e0dcfb..8eb5da5da693 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2494,7 +2494,17 @@ static int __init btrfs_print_mod_info(void)
 			", experimental=no"
 #endif
 			;
-	pr_info("Btrfs loaded%s\n", options);
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (btrfs_get_raid1_balancing() == NULL)
+		pr_info("Btrfs loaded%s\n", options);
+	else
+		pr_info("Btrfs loaded%s, raid1_balancing=%s\n",
+			 options, btrfs_get_raid1_balancing());
+#else
+		pr_info("Btrfs loaded%s\n", options);
+#endif
+
 	return 0;
 }
 
-- 
2.46.1


