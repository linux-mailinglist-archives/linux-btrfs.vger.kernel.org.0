Return-Path: <linux-btrfs+bounces-19363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C554BC8A501
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442723B3AE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08363258CDC;
	Wed, 26 Nov 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMX5qzWl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAA2FD686;
	Wed, 26 Nov 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167017; cv=fail; b=nTiJP/KdmOpWUUmFKknn052B69j81yssS7Ps2sYzbdcnl6jyZ1D15Xi9oeSseMnYW7AXz5m3Dm7SyWrl1NH3wC8GJyCJoPhwdCKQi6EjUbN4WZStxThLqDcW6hyGGf8iPCbo21LSjMPePN99vP12cjOCZFK5xd1kn3ImGeQn/0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167017; c=relaxed/simple;
	bh=gINWR/44XXcwRXpVyMvn7chAVjUKW5jw8tyc3wJbVEI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bn5NqhjJOC3vJ9SC6O60nTA+oyHWYEqW6XJIIcc5HsbpbtcHIx/YjWqCDBCG2ayyycGlD0ZunkgSN808/XEPMJiKyLUWajVfCHz98cIIrxClcfSv+1vx8rXPb1WMmfZJef5XGBs0e4r5RXELumOzDBziZB+UqI/X7EDWK5nOubs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMX5qzWl; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764167015; x=1795703015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gINWR/44XXcwRXpVyMvn7chAVjUKW5jw8tyc3wJbVEI=;
  b=BMX5qzWl3aMI8IIsKj4ddC0wrukCJKtWV00+2iTzdcus5MuzsE2ol0VR
   9oWwr2eHf8hl7ehoW3b5lpsYph7jhyJ5ZGk8qYnCdSfBXwM7hJ6gkjHo7
   GLtxbkKpyXTEhlTCR+EY9rSaASitesakeU005REjQ0uVJ7q07v1HLN/ve
   d9U2xPhhkm6z6KzYILKakaQvj4oZBj/r974YxurHG3QKJi1tFmoB/7Pdo
   F0B7d5HVJASHBTzJbyKILsCOhGEDQrq/M0ZwatNyGkB0qlZpXnKGbNNTw
   Tib4MnOkU7owVfiGtj92kHhfqz/hOlo8X5PIEB3osYNHZsnsMxehOX5vB
   Q==;
X-CSE-ConnectionGUID: rTPPT920Th62Y+b3Kg3vqQ==
X-CSE-MsgGUID: /xjOVw3wRHiKiAXkIeA08A==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66152296"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66152296"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 06:23:35 -0800
X-CSE-ConnectionGUID: Hnr6A7nMSMC6BjziAAIGSw==
X-CSE-MsgGUID: 1NNedsy9SyKt1EzVeAyVDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192205862"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 06:23:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 06:23:33 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 06:23:33 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 06:23:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeWROzjKmFZHnVP6tjhaylXxdikszFemPHqS5YzzYfpTBBPgguiiHji6oXtqSSkLtSTMznd2kic5HbAxdYwY+RYUTH1twgFAVGp5zvrH1jYKoNcg50OMCoaeB8pQL/IjgteUGyJmkCpYJLQ9+CV71xA4KL6A0WO3PzQ8SWytwbwU8Tbg+yYHpzAPEQ7T8pdzBmvEVKSdFll4NF5yJ91uelvJpPYW6hUpkYdDBhLeYVINir3ExKADGWNIe9BBR234jcQsXuF+GIzyvpwoe8/qZwErAxh+OBQnTnK3ng8QeIe+wCfy/ZODLwQg4Dqre55rUWlwSQ/A6I4CrCthjOkIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bgcWry+Moqm2qumAutFookGh4VEuLciWKcduoSLxDo=;
 b=lcZ94KbmZfSYZ+4JAehFwbU0vvbcbh0QjfuFLHjkBgcF4gmjr2vbmM8Z6mRp7fLqenXoQJmGjl5Ldfsm0tvGWtS9EcArFwoBeP1Fz48tASF0JdtE92B5UUmPKtqGVtUWxxZbLSI+r/+U0AJVGhP1dpF24f7w26KEIYHHJoBLUr3m8IHKi1hPNkOnfp+WcyvuZw9LzixcXXgOliRoX9WsHpMXBB8RFkvQBF+OvdHBKQdCSmnuC3ACWUrxM6UkZfhugkIwUVs82uyI6yada4X5FhLED0QS3akmWm9UO1LWNGAzP87mU432x8a+UPecEWRDSm+zV+JET96gRvCZ9U+7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 14:23:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 14:23:31 +0000
Date: Wed, 26 Nov 2025 22:23:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Leo Martins <loemra.dev@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  e8513c012d: addition_on#;use-after-free
Message-ID: <202511262228.6dda231e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KUZPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 6869927b-3007-4385-a7f3-08de2cf7601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?utmnWXDtQp60ghD6GwfPCJLu+PwceTeVMaFTOJZvlh0+Kofi+Kfjd7ZSk/rH?=
 =?us-ascii?Q?9e40dV3waULEVAUBodiv0oN9DGxbOlD2wpFK4MsOcsxie6pusC3ZZETWWiMu?=
 =?us-ascii?Q?w5u+2xOMPQjXnKVwArI+uf5dsQ1T9Qs9d8g6R5yUscDah65GvYg0teyE4tAC?=
 =?us-ascii?Q?2rn8q49XWLvR4lCXnWHArs8a9WwAoxLKconeHx7yv5P9IHY1KpJIiQZcEhV2?=
 =?us-ascii?Q?a/UdLh+QMuqKWHeJfBR2S72occl4buIljbb4owvIIKEPbxGOnVmPj+08tijV?=
 =?us-ascii?Q?4M0uXnXr97HLiLeY1aBMiNmVbUNZOgK8ty9RoakFn8ZbvA3zQa7UYwYTu9P2?=
 =?us-ascii?Q?XhvM+Eljj4bGA9vOoQIcfReXRWrTT+34r/b0CYtMxHWdYltLphIfFCCH7bQE?=
 =?us-ascii?Q?FM2AqyJ7OX61lxx7+NNHLXO0h/tOruliGmeEc5z54bgpesIk5CYxbiplS6LX?=
 =?us-ascii?Q?w3QgiyNXsm7LnJGjpA0Asv1S5ByihVMcm3m6mqWNGwsLYaKNo+vJk23XnNfo?=
 =?us-ascii?Q?9F9M6Stfa41GSXdgYaBuFWYqHrWm5nDmMZ6glfVedhLjWTMYxF6Qpz3vefeP?=
 =?us-ascii?Q?RHAgxPekHU3xN0xak1v1DIPbdxJL+R7En4hnxamZtK87Bc9JqnGvlQYV8rAu?=
 =?us-ascii?Q?lV6b33sWVkhJBBNI+Q2vRpwl1vVvNyNpwNg2hZNsPnEYP/b25hkikEpacxu5?=
 =?us-ascii?Q?JSQF5WrurcFLLMsiozu7cSl2BVH39cP89N/fRjxZ7TLJ9dtGUrTNuYPjRZ3h?=
 =?us-ascii?Q?mqr8kRyaIYiOH4jrVm0sBO+9ETMRhBviyBcmhAiOBJMWpKfiYDx4hT5K1kYN?=
 =?us-ascii?Q?1ufOU6RHcLqqvL1VzH7zSgexpmhyhh6bwnWQ8jmkcTNuTfB3VEgIbT5mx266?=
 =?us-ascii?Q?NlHiKKrY4DH3UVZm5wyr+CRMkA9ujbeYzw+/vDWBL+C1DmpBmA9GFgwRw+7s?=
 =?us-ascii?Q?5PAX2Xs0OQ01284NALq7ZrG3oz3MjVOd00wUt1b7bGjE1zoS6p6Pp/ahetMv?=
 =?us-ascii?Q?q1BNj6eBE5v3zcjynF0+D/PJhm5vZXp12KfhB1VG5L0Z08ZzbpWYC9yzGsMV?=
 =?us-ascii?Q?GHs9XrOA+0+75rUCNmzsOOaJ/4N/X4WbupGvWnx+YGk5eCCfvPFNNdf+bkm5?=
 =?us-ascii?Q?0Qcs2BwQWCozkY3HTk7BP4YhrqbI7qcZ/cx2Yp+08nPUfctIsVmjUZPHSyWO?=
 =?us-ascii?Q?isM4t/FVJHoqjt9/hs1ckPthygk1iHGw85EMWRXj+o2n1d7p22NVzyTAp3Hy?=
 =?us-ascii?Q?W6OdRGAXF/UR/FE5ebv76E6Z8uJrUCvj9G4IQEzA2Tt4ZmvatoU4S8mA04h3?=
 =?us-ascii?Q?yloSjkL2NpmPQ6yb1FReF8Lo8k0X5rkp8yzwTopAw5ulkXed973CIy1szdGu?=
 =?us-ascii?Q?x0dGEbG2MJGIwwZpLygskjM3EAxz8nwRuSA15w5SvpfD9T56mfOVQhuqYEek?=
 =?us-ascii?Q?QrfdysiuoIGCCNoUNC1VeiMDDJAjaB8lUM1PYIyKubQQYiD6bq/9hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNnO64H/mfd1vDm3nSULde0oAZYWD2fnijp/qUsCA2ZEafwBh5yIE4MHjVC5?=
 =?us-ascii?Q?8NUfGEhfBr7Yr7EqIM4+II1H5MYeXIv8exu0zRvVJMhVXvoHRfRGvT0uX6EM?=
 =?us-ascii?Q?e9NkS/yfP6XmjJmeSJzbdmcI64Y1tMVe9IJBm8KElwt41kLJjTxdtdiE56Bk?=
 =?us-ascii?Q?nMghg4VZ6J5Z783C+Ix9lNn6YSfhC/6GsK5lxNnaxUMD+9uf60VgWBnmqVhp?=
 =?us-ascii?Q?2hjcleSoIa6JCfWOMgbLwA66CXsD3yZ5iRx1bFIPGuNeF0pMYoNBMbFi6SXf?=
 =?us-ascii?Q?jj9xHaIW5jnArq/1c3kSY2+Tlk7C2ycRgIyPm8XYYnMsTmm1de05FbNio47N?=
 =?us-ascii?Q?j9u6mruviDdcofMk8VO7n1OXN+NPHFXPLNuOBK7lVdbAUb33xqSVTS4AxBvA?=
 =?us-ascii?Q?cd5lRDhhKZBDoo9W6/z/PzznwXA4mdBi8zOYacO9GcaZ5TURGpBEoUsLB04/?=
 =?us-ascii?Q?sES4Q18qtr/CDNv0r2nV7EZr/PB7E9h9nIu84s1mBzmafuRcAiJ6MZnBddEs?=
 =?us-ascii?Q?roekM0reGPUv25CbaVpxdRzLNxreNF1yWONJ47/8rBRS40bGqzfksJZR8tfA?=
 =?us-ascii?Q?wx5cE+umeFDNqKNfUyLysp+S+m/fSNw4uYwscgeL6RBS0JSXk7Hs9QBMVs0c?=
 =?us-ascii?Q?kTGadEle+ID5eDuIiyhoBmqYFeeI3QFZnfdfHduYRQm6lN+CuMhqNFVDQSd0?=
 =?us-ascii?Q?4IVhHewQnrKap/fOq/k0czptGCrnVrgICJvr4hHTx8+ptWoCRIwuKiu8qpGt?=
 =?us-ascii?Q?qV92Z+Z/ga4lkLhvmenAcZbo/1NnvvLzbEiInnrqeRlCgTV0l2gZ0ye2wU5m?=
 =?us-ascii?Q?rP7osxZLQUw/fCFsA7dhWR7Q9pbloM+LUcZhxsxLvhNIkl3eu9eHhjquYKnj?=
 =?us-ascii?Q?lRMSQp+AZnLGtTravm0bXqdMCWKSd0BUaDA6Ai8k31MhbUcIEr//CFSUMfvt?=
 =?us-ascii?Q?3lbAIKrSXOrkCiB0CRaIeFZCB5LNrudx0KEcAtkOMjm2rChZ7JXLpuAZGRCu?=
 =?us-ascii?Q?dyFZf+oUTz/cPzBbw0N6SMYyA6GKOVY+koXtJ85HyI3MSUlH9pfBBuy2Y+hU?=
 =?us-ascii?Q?jxUd3zj+ANaJb/eaRSOG26QXi5fJMc8pe1/Fh2hDqjpkR3+5ZLQQRkWz3VVi?=
 =?us-ascii?Q?TRQh3OUzx14wldjtUPFg5lO1aMhlSL2kDsx+WHRL06WT8NLUn0BF0kSC9EJn?=
 =?us-ascii?Q?h9xh3jG1/Rm0+OlidRBo151tY1Dxx++y0A3dGWkLOWzVyKu7X8hurQTkXBog?=
 =?us-ascii?Q?XXaNqefb8uEsb46Zw+2o+HWEALRBrSQAkjC/HJYiLdPPMssSj9O0GaRmdcPT?=
 =?us-ascii?Q?DTSxZEIha5TWwajC8Uu8nH/dnUKPSSrpFbndweLj26NJuG3z+AjNrWX9YOso?=
 =?us-ascii?Q?p/DOfOQZD1mWpbrpWYNDc4uYcJDg8tyEHy6BirQEZpxu71sQdyj5AF4ABz8R?=
 =?us-ascii?Q?FFXIIfafFlyCwUEprLprFvN/O4tD0HeIIkvps/Eg1d4RRzwTrGk/eAjt40iv?=
 =?us-ascii?Q?yzT3Qhw2d75LwKwCFTnff1A8HjrMvRgTuMNDHUL3IaPseMv7ErqDCV5wPQMp?=
 =?us-ascii?Q?JN7O3tHF8B+OKr/wlNv/srhVAVfYd4O2RO5SMLTJUx1q+bJ7oUsESqsn68FI?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6869927b-3007-4385-a7f3-08de2cf7601d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 14:23:31.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXfpvheATx3PlcT7OhcHJLmOSk4ahQPa8r2cK/fUzyY8wBfD3UP3xfhBNTA+v8CXHaIQOdXt+zoKL0HG87i3Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "addition_on#;use-after-free" on:

commit: e8513c012de75fd65e2df5499572bc6ef3f6e409 ("btrfs: implement ref_tracker for delayed_nodes")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 30f09200cc4aefbd8385b01e41bde2e4565a6f0e]
[test failed on linux-next/master 92fd6e84175befa1775e5c0ab682938eca27c0b2]

in testcase: blogbench
version: blogbench-x86_64-1.2-1_20251009
with following parameters:

	disk: 1SSD
	fs: btrfs
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com


[   92.359770][ T1319] ------------[ cut here ]------------
[   92.365399][ T2115]       1513       283338         42318        194834         39930        140043         83712
[   92.365683][ T1319] refcount_t: addition on 0; use-after-free.
[   92.371060][ T2115]
[   92.381336][ T1319] WARNING: CPU: 29 PID: 1319 at lib/refcount.c:25 refcount_warn_saturate (lib/refcount.c:25 (discriminator 1))
[   92.389049][ T2115]       2174       291211         39936        202785         36246        141919         76774
[   92.389356][ T1319] Modules linked in:
[   92.398571][ T2115]
[   92.419599][ T1319]  dm_mod intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp btrfs kvm_intel blake2b_generic xor kvm raid6_pq snd_pcm irqbypass ipmi_ssif snd_timer ghash_clmulni_intel ahci ast rapl snd intel_cstate libahci acpi_power_meter nvme drm_client_lib binfmt_misc drm_shmem_helper mei_me soundcore intel_uncore ioatdma ipmi_si i2c_i801 pcspkr nvme_core acpi_ipmi libata mei drm_kms_helper i2c_smbus lpc_ich intel_pch_thermal dca ipmi_devintf wmi ipmi_msghandler acpi_pad joydev drm fuse nfnetlink
[   92.477068][ T1319] CPU: 29 UID: 0 PID: 1319 Comm: kworker/u770:33 Tainted: G S                  6.17.0-rc7-00022-ge8513c012de7 #1 VOLUNTARY
[   92.490808][ T1319] Tainted: [S]=CPU_OUT_OF_SPEC
[   92.495958][ T1319] Hardware name: Intel Corporation ............/S9200WKBRD2, BIOS SE5C620.86B.0D.01.0552.060220191912 06/02/2019
[   92.508765][ T1319] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[   92.516545][ T1319] RIP: 0010:refcount_warn_saturate (lib/refcount.c:25 (discriminator 1))
[   92.523057][ T1319] Code: 95 95 ff 0f 0b e9 4b 45 90 00 80 3d d3 40 98 01 00 0f 85 5e ff ff ff 48 c7 c7 88 fe ad 82 c6 05 bf 40 98 01 01 e8 9b 95 95 ff <0f> 0b c3 cc cc cc cc 48 c7 c7 e0 fe ad 82 c6 05 a3 40 98 01 01 e8
All code
========
   0:	95                   	xchg   %eax,%ebp
   1:	95                   	xchg   %eax,%ebp
   2:	ff 0f                	decl   (%rdi)
   4:	0b e9                	or     %ecx,%ebp
   6:	4b                   	rex.WXB
   7:	45 90                	rex.RB xchg %eax,%r8d
   9:	00 80 3d d3 40 98    	add    %al,-0x67bf2cc3(%rax)
   f:	01 00                	add    %eax,(%rax)
  11:	0f 85 5e ff ff ff    	jne    0xffffffffffffff75
  17:	48 c7 c7 88 fe ad 82 	mov    $0xffffffff82adfe88,%rdi
  1e:	c6 05 bf 40 98 01 01 	movb   $0x1,0x19840bf(%rip)        # 0x19840e4
  25:	e8 9b 95 95 ff       	call   0xffffffffff9595c5
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	c3                   	ret
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	48 c7 c7 e0 fe ad 82 	mov    $0xffffffff82adfee0,%rdi
  38:	c6 05 a3 40 98 01 01 	movb   $0x1,0x19840a3(%rip)        # 0x19840e2
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	c3                   	ret
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	48 c7 c7 e0 fe ad 82 	mov    $0xffffffff82adfee0,%rdi
   e:	c6 05 a3 40 98 01 01 	movb   $0x1,0x19840a3(%rip)        # 0x19840b8
  15:	e8                   	.byte 0xe8
[   92.543676][ T1319] RSP: 0018:ffffc9000fcabca0 EFLAGS: 00010282
[   92.550187][ T1319] RAX: 0000000000000000 RBX: ffff888e3d2c8d68 RCX: 0000000000000000
[   92.558625][ T1319] RDX: ffff88984f36a3c0 RSI: 0000000000000001 RDI: ffff88984f35c200
[   92.567066][ T1319] RBP: ffff8881069c6368 R08: 00000000000008fd R09: 000000000000001d
[   92.575508][ T1319] R10: 5b5d393933353633 R11: 205d353131325420 R12: ffff888cd91ced20
[   92.583960][ T1319] R13: 0000000000081087 R14: ffff888ed98c2ba8 R15: ffff8881069c6000
[   92.592397][ T1319] FS:  0000000000000000(0000) GS:ffff8898cb53c000(0000) knlGS:0000000000000000
[   92.601843][ T1319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.608920][ T1319] CR2: 0000000000000800 CR3: 0000002c7de24001 CR4: 00000000007726f0
[   92.617398][ T1319] PKRU: 55555554
[   92.621442][ T1319] Call Trace:
[   92.625216][ T1319]  <TASK>
[   92.628645][ T1319] btrfs_get_delayed_node+0xda/0x1b0 btrfs
[   92.636027][ T1319] btrfs_get_or_create_delayed_node+0x12a/0x1b0 btrfs
[   92.644356][ T1319] btrfs_delayed_update_inode (fs/btrfs/delayed-inode.c:1957) btrfs
[   92.651387][ T1319]  ? btrfs_update_root_times (fs/btrfs/root-tree.c:488) btrfs
[   92.658201][ T1319] btrfs_update_inode (fs/btrfs/inode.c:4174) btrfs
[   92.664431][ T1319] btrfs_finish_one_ordered (fs/btrfs/inode.c:4188 fs/btrfs/inode.c:3226) btrfs
[   92.671351][ T1319] btrfs_work_helper (fs/btrfs/async-thread.c:313) btrfs
[   92.677606][ T1319]  process_one_work (arch/x86/include/asm/jump_label.h:36 include/trace/events/workqueue.h:110 kernel/workqueue.c:3241)
[   92.682972][ T1319]  worker_thread (kernel/workqueue.c:3313 (discriminator 2) kernel/workqueue.c:3400 (discriminator 2))
[   92.688065][ T1319]  ? __pfx_worker_thread (kernel/workqueue.c:3346)
[   92.693679][ T1319]  kthread (kernel/kthread.c:463)
[   92.698145][ T1319]  ? __pfx_kthread (kernel/kthread.c:412)
[   92.703205][ T1319]  ret_from_fork (arch/x86/kernel/process.c:148)
[   92.708102][ T1319]  ? __pfx_kthread (kernel/kthread.c:412)
[   92.713169][ T1319]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
[   92.718420][ T1319]  </TASK>
[   92.721904][ T1319] ---[ end trace 0000000000000000 ]---
[   92.772617][ T2117] [ perf record: Woken up 232 times to write data ]
[   92.772626][ T2117]
[   97.041836][ T2115]       2696       307116         30435        210930         28018        143529         49252
[   97.041848][ T2115]
[  107.042097][ T2115]       3311       309408         37927        214378         34672        141593         71871
[  107.042111][ T2115]
[  107.492140][ T2117] Warning:
[  107.492150][ T2117]
[  107.504083][ T2117] 174 out of order events recorded.
[  107.504089][ T2117]
[  107.572544][ T2117] [ perf record: Captured and wrote 680.421 MB /tmp/lkp/perf-sched.data (2685986 samples) ]
[  107.572552][ T2117]
[  116.735824][    C3] perf: interrupt took too long (2518 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
[  116.747160][    C3] perf: interrupt took too long (3163 > 3147), lowering kernel.perf_event_max_sample_rate to 63000
[  116.760698][ T2117] Events enabled
[  116.760708][ T2117]
[  116.763935][    C3] perf: interrupt took too long (3955 > 3953), lowering kernel.perf_event_max_sample_rate to 50000
[  116.796549][   C67] perf: interrupt took too long (4953 > 4943), lowering kernel.perf_event_max_sample_rate to 40000
[  116.866088][  C131] perf: interrupt took too long (6210 > 6191), lowering kernel.perf_event_max_sample_rate to 32000
[  117.042049][ T2115]       3836       310809         30767        213835         28646        137339         48846
[  117.042057][ T2115]
[  117.739156][   C25] perf: interrupt took too long (7763 > 7762), lowering kernel.perf_event_max_sample_rate to 25000
[  119.838008][ T2117] [ perf record: Woken up 399 times to write data ]
[  119.838018][ T2117]
[  124.613970][ T2117] Warning:
[  124.613980][ T2117]
[  124.625324][ T2117] Processed 1601669 events and lost 6 chunks!
[  124.625332][ T2117]
[  124.635344][ T2117]
[  124.635349][ T2117]
[  124.642513][ T2117] Check IO/CPU overload!
[  124.642518][ T2117]
[  124.649994][ T2117]
[  124.649999][ T2117]
[  124.656077][ T2117] Warning:
[  124.656082][ T2117]
[  124.664342][ T2117] 35 out of order events recorded.
[  124.664347][ T2117]
[  124.678444][ T2117] [ perf record: Captured and wrote 252.317 MB /tmp/lkp/perf_c2c.data (1412807 samples) ]
[  124.678450][ T2117]
[  127.042332][ T2115]       4407       303071         35022        208647         31346        136630         47202
[  127.042344][ T2115]
[  137.042250][ T2115]       4943       299584         31810        208626         30129        128390         56528
[  137.042263][ T2115]
[  147.042441][ T2115]       5385       300009         27874        208644         24778        132677         46221
[  147.042453][ T2115]
[  157.042433][ T2115]       5910       307972         30431        216088         28665        137389         57696
[  157.042445][ T2115]
[  167.042628][ T2115]       6460       304663         35022        213949         31758        139786         62225
[  167.042640][ T2115]
[  177.042573][ T2115]       6967       307323         30606        213465         26983        141516         63168
[  177.042587][ T2115]
[  187.042733][ T2115]       7407       307075         26787        213546         24994        142923         41523
[  187.042745][ T2115]
[  197.042791][ T2115]       7927       308105         34190        214356         29643        140592         52914
[  197.042803][ T2115]
[  207.042918][ T2115]       8549       301948         38038        210474         34706        141120         67811
[  207.042931][ T2115]
[  217.042636][ T2115]       8955       297050         25135        208501         22518        135881         44260
[  217.042648][ T2115]
[  227.038865][ T2115]       9471       304296         32936        210610         29938        137844         62809
[  227.038870][ T2115]
[  237.038945][ T2115]       9964       305929         31628        213754         28012        141671         62429
[  237.038951][ T2115]
[  247.039008][ T2115]      10440       307726         30685        214830         28062        140111         62249
[  247.039015][ T2115]
[  257.039183][ T2115]      10802       292789         23345        205882         20689        138434         48453
[  257.039188][ T2115]
[  267.043497][ T2115]      11273       306881         30725        212403         27270        143693         60639
[  267.043508][ T2115]
[  277.043510][ T2115]      11797       302806         33279        211710         30071        142609         64344
[  277.043519][ T2115]
[  287.039432][ T2115]      12205       264441         24852        186434         24016        129256         56311
[  287.039437][ T2115]
[  297.043412][ T2115]      12673       310406         27331        217050         25960        146991         54571
[  297.043421][ T2115]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251126/202511262228.6dda231e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


