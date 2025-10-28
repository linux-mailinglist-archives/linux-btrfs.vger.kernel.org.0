Return-Path: <linux-btrfs+bounces-18379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD04C13451
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 08:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D445D46372B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 07:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8221E5B7B;
	Tue, 28 Oct 2025 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5r66UTS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17621199E89
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635984; cv=fail; b=A0JbSoDPltJipZdBNZtLYIdd1/dxYmghmr9AxXQiLMDhhcXL8dxTwxZ7F2snrd/rs5ykCtvGR4w5U9SVD7+9i+0YkLjYFXTFqeh7ZYwbS2POznyRM7ghjBsX8yh2CF9JWqwtNZp0KbqcpExWoiofXwgnQzljsPTKxd/DGj/rLRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635984; c=relaxed/simple;
	bh=DmQmCcd95AZ2OkqWJHeNQtsVoGbSGaKkwtI1JYvqz10=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V+9ltoIv4g8cCelxm3bqUa8z3ZVelxgplEHIm1ha1LJ6Juit1mqTj0Wuq6iLh2WX395zvJI0gcBe+VEY1IuozvC/x9z2kz5ed6gDmsaWMfyc00wYwgqczaxMVHtqu8wcCHltuTeUwYRm9QAln9y659paFw2Vs8g9ndhIc5OS/VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5r66UTS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761635983; x=1793171983;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=DmQmCcd95AZ2OkqWJHeNQtsVoGbSGaKkwtI1JYvqz10=;
  b=L5r66UTSVLD68qa3SJDYXksiaUljV2NTUasMyHZyT9IOfcXokcTzHpos
   vmenURvQoqu3NjKrugFmtfdlquehJRP0dCuoJsWaFXf1qNhMGxfFLmrC7
   t7FRFTBvggSCl0rxjBBvAKYX0GhFx89Ne10VHKETLls1RaDlK4FoCS0ib
   39tE2xtexEFr7APRKFfNQe7ifPlo/KrtkflbEmLT4BndKyu793gSd5wyd
   ZWbNqHchKsFjvzLcUgLF0n4+cXuzIIOU9DXCK3dkZL0te082ecufXJIdU
   acYFEG3LVLE/N0n5dLEl0hdLE2ZkzIs6tD6bPu8ad/iYRCGtLeWbh1H0Q
   Q==;
X-CSE-ConnectionGUID: cp/WcOFkT2OUK2cOC25bYQ==
X-CSE-MsgGUID: Ujw0hydrR7uWIyiUMKeI7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67563959"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67563959"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:19:43 -0700
X-CSE-ConnectionGUID: eSsBG8NVQc6PI2NOioHGHQ==
X-CSE-MsgGUID: 4z7M5C6qTW+Yx8vSQ9IkrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="189325207"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:19:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 00:19:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 00:19:42 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 00:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x70gIfoREMszeck8xuCMv8SBrSDISiFiGLFJQx0SGybNh85tkZ60/oxCPwEL4VHiAxj4FUBAXgPcPOJ5fmuh4l/7vph1+q+WyuHsazxQ596ZZFDD890AMJegSh+9tEas9HiC/0BUkRPX/Kk8ZNGmCQMuTkvzlqNv3oC2m/yCLtZZ7ZOTuQe5x4oe5949GSE2T16J49q8Lqu93+LjBUUPnRXdMOW1uEDxi10GyPPuchKqKytOp0fLnInRIX+pBvizwX8PjWItBq5HeAmmyVEL3ToJQQc45XmhH83hywXOCssfszTN4vRHqzAB8oDHQ1gLa3ZDgvKZ1cdQqkqP5MNhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxIcNE58bboOOdnt8t2UTPHkfQoJZnqbovBzccrWn3M=;
 b=AWzU+R8GG4ZRc5gJ0Pjum1mwkc9z5/YjU1vQxkr3P0F54s2kbaJIUfho6ZnvEg1kGOAFawjvdf/XZhwm4sqLsmgPSPoUprs4bKDNTD3JYj9e6ea3KG+XQRUIFr6RLKpEmjhbwvP+s2vpl7nWE1wv6034Dy3dTe/94OF4UUiDzTWDj8Z9tt/zeH4uXgv9ZccKRcitgJQTmQsq39AO5XIGlwWQD7sG5c66LNE2KTKdt6nlbtKNsgX4Lx26uSNiFF9p4KS3uEU1XIeMcsC0Q6yXwmUfKoKZ4j6rjBzS7XwEvnHZ7SHdk4G5YgG58XLlYf8XgJtGSd+1dRNv8nO/BZMWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ5PPFBBB839A03.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 07:19:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 07:19:39 +0000
Date: Tue, 28 Oct 2025 15:19:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
Message-ID: <202510281522.d23994ae-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
X-ClientProxiedBy: KU0P306CA0021.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::17) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ5PPFBBB839A03:EE_
X-MS-Office365-Filtering-Correlation-Id: edcebe8a-d087-463d-fdaa-08de15f25a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9TKQJwUg8fOZ+5CABDqO3641DHl6MHuSSIuflIUZ0jUHB794+baGmP2ZyvwF?=
 =?us-ascii?Q?az3ldhYYx26NDReAYSA9voCRZnszeMORjdRBWAJ9Duec1erkzfpmk2I9VxsU?=
 =?us-ascii?Q?qnDrnFDDJ2z1LfEy4CP0RVtFxeUszJgEHDuNU3cAhSaJvg90BCNdJ3gJl2ZZ?=
 =?us-ascii?Q?zt7CF00wC/8LLQhYA+/ZH1gGtfjmJKtOoe6O58LNqb+aDBrlSQuI+zUDsmse?=
 =?us-ascii?Q?ZPUYiF7fW5Do6oB7KuX30XqM9JhAdHhPCbFNFDLgvqWzBO22UuWK576VV1Uz?=
 =?us-ascii?Q?alpZcBnJ+eq3XHb277by9pVHSZu3nFZ4w55ZNLaS7tl7vdGOxX7CRDYGu0Tx?=
 =?us-ascii?Q?dib1zOprJLJrkdD+q6RtA1Y6PFdz484VGBEv5/E40xBkBF3wNCWUrXDdNXtz?=
 =?us-ascii?Q?xG1rh+f5iPekwiOSsb6WjNH+ScUIB9m0MeeRlFoSb6qHDxLYQUPPAUwg8/zo?=
 =?us-ascii?Q?DFNHo0dww2CRwidYF4HnuldJxdHzGBbQyYwDrh66NYd9GeH4d93tBTTJQQ94?=
 =?us-ascii?Q?rnCgv1QHfRHY32oLQ4Wgt1sD8YBsS9eBE9T5il9oHsXrNTglBvlltfFLr0L4?=
 =?us-ascii?Q?Bxv5D2yGxUkosiJ5eQV68aP7leRQ1bxDhs1vLDhbVFUKUNC+Ludjsh8KTkyU?=
 =?us-ascii?Q?71aTkogDNmXfe7j0PBUrP8FHkHPDhICpbZtuPqrtk38MiAARjIgkVMpYfmlM?=
 =?us-ascii?Q?VlzpWspPO7nvATgPKM6E3ivkbh/SjP846LN9bATiC7WksMdTA115G4ma34Ot?=
 =?us-ascii?Q?ZlR0n9HUVIz8w8QUTAOkIUOE3ClPMXG2pxiZERx3lU91w03hciraeYVjmf7o?=
 =?us-ascii?Q?Nj33zwbPf3lyrlakOnMNtnq4EWZkPl/tE1WvayhT6BE3kMsXCfsvowCckjP6?=
 =?us-ascii?Q?J51GnLGuCZOWTpJxt3hn85ueGQgYBJsOizXISIWd4rzEjjhbrv/goNIKZevE?=
 =?us-ascii?Q?UM289J9u59dhRI6KJEYM30r1qFBJ41nZ8J84NVjy+pxr+pCquXwYBzJQGFiN?=
 =?us-ascii?Q?8enhRhaRRvJljQ5SRA3ahK/8vOzWwKC5iiRfbs0GVtRTJ5VXgICWRSriUKxb?=
 =?us-ascii?Q?scp5Wm2bsuUgkTygVaRdNMjq8PITnjemV0XBII9YG/TcOShTTvGtIdWOqCG/?=
 =?us-ascii?Q?NIxuytBcukZH7UqHnr7v3TRaZVNHRqpC7QOgAAoCWGbCwyc8L1aohRc68gQr?=
 =?us-ascii?Q?pmU6v6YjCRKtuS5Ccy3jY1f73sMHRUNkD9s2GaT1GUpjX3YV9RrhAwAcjhQ9?=
 =?us-ascii?Q?rU+vFk0np1erJzRqhFsJgFKm9Y1YyF4dncCtHmsH7sOEtJa7aB80ZK3vU6PI?=
 =?us-ascii?Q?OO9ENwzbo+yxwEh8B6tAdEA50AiJyHu9cEMDLwSl7TIvB/MPQBt3pmuc9wwJ?=
 =?us-ascii?Q?H7+9nwouFNXxP/iB22p3uPcWWsd7aMdh74VjuQD4qOZI5l/MW7Ole+5/qIao?=
 =?us-ascii?Q?R+dk9hppXjieF84xvhWZL1571VqUQ/zPQAayUkwHkrCbCgbSIeH0tA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/se+TvxEDLgfnF3MgeKGgeqv2/gRpvsKqoaYVshNS+AB0nfH88QkXPy6EoZ?=
 =?us-ascii?Q?9/k/loSqIthYSVeT+3jRToCyAUh89jNexinjoa/MQCDJQKomNOn7L914H+1X?=
 =?us-ascii?Q?ZX62faEDF3rNNaQN/PXlkmuir4D9uTKQ4lx7RI+yRYlHdhcRCA0MCcJFt0x3?=
 =?us-ascii?Q?oaPOqm4KdXNXC05I8KEIxCDcY1WiKFykkDZTwMy3f7VA1X8FPHTZgASQn7M1?=
 =?us-ascii?Q?C3lWplfa2p7pnMhrmVYazumDmKTZjmpN/lB8YsGBFQzJKyPo8zGAoCHSKkPg?=
 =?us-ascii?Q?nXZsgNpbAUTTTfrWeEUrag/aL2bkO5fvzhuFc1bGMfFSHZg7K1n9ZqS63fCp?=
 =?us-ascii?Q?j46dqcDD94T5lV6XAT1ll5Zq0zn1QUvD6Wy/Ae5FbISdfXd2YRyrtNApUUMP?=
 =?us-ascii?Q?iVP7id+wElmeSgxc3ZNfmV3QVLLOayiDrsz0cRATcjhNvjVMv5TQGwP8/ypc?=
 =?us-ascii?Q?qP5DRei669i/m/GUg+ISDPdjQkk8va8W8jo8F0nY0suzGGRWyMtGPVzv18rs?=
 =?us-ascii?Q?y51zdOHMIZvXtWQsYPwZ+HjHJq41EMtV0D8Jfwx60DaT5cNbvkJaPNotmFp6?=
 =?us-ascii?Q?U8P1K+2fjiY5G+K3c8x/BpK5YMJg5a9aPO+KQ4nsYvQ8MOdIXupiPdKRQ6oH?=
 =?us-ascii?Q?dFBDGhRpnfdYroluNXJDElAFiKOfkcybHe70Kd0Zqj663yn+NnavO1tPeC7j?=
 =?us-ascii?Q?ZGVCUK3NjbDqnrC5qzEJy99etVl74V1GzZI4u4lCxmlVQNB2qlsDRpjjaW0T?=
 =?us-ascii?Q?jeMv4avidBdBIlIqEVExLZGI4sCt9FrWF9+92M6gMGgXs+NOiYbQgyNwVnjV?=
 =?us-ascii?Q?cpUHSs2UkZRHnvqq8jLPwU0ing8Ja45SjiDMFcTuT8Y+H7R1BeVhhHMvw5yA?=
 =?us-ascii?Q?V3feNuZqMOvaOrY3ppGrA1WhTsBy0NEfVnFwl7PGI99uk75xzG7X437oUHBY?=
 =?us-ascii?Q?7ybd56O9XUNXDeY5N1niAsSosNhkiCvvI5zgGRHBNaN21bHz8sRw/glyn1R+?=
 =?us-ascii?Q?xdU2PgW/MZLp+DoaUqteVOKWsX4VGIUTzD/e8mmmoyekVdyVCro1WsWaAPQJ?=
 =?us-ascii?Q?RFvNv4/uxhkB2o92VLXhgF4zJ5cHWmrLEmJZpS25CDwZSFhTv8LJPTtp3rdt?=
 =?us-ascii?Q?ATNqLx854WEq7yGGlJ5UDQk69ZAe8dqJJqhw0J23oNj+3xy7vgY1caNSdy4f?=
 =?us-ascii?Q?NeiuH17m6/YenDz/Z/jflweKyFc8aJqcPEykJCRKWIlppwVzkoD0xmXTWJuY?=
 =?us-ascii?Q?8Lw6NQyQwbZQlI0s38oEDd6qr/zrboaTkNB2HzB7nSx3nAoU0zoacNmv6yKv?=
 =?us-ascii?Q?9WqYOrjSWx8WSQ7JfrVem9A/R6q98tNYX3hop+L/jOIcs5mFr5ve5ewP46eK?=
 =?us-ascii?Q?yLFsGKq98FvNQ+V9OCC7C0GTsfxql6nQn8DnvkRM4fTWH1v1ywfZmtmHWxKP?=
 =?us-ascii?Q?dfvUCxgoY1Xf8mnjKG9ozGMtCjY1ofxKgqmLih/qAWRKADRfF/F3D/dP7GXi?=
 =?us-ascii?Q?+44tqiSU/U+6h02q/i01SlraY+DXmYlvlG7HURalq9KxLX911wvXIum2/k9p?=
 =?us-ascii?Q?90QY9bLUGe4/49pH3bE/hhg0033FF16w0I+KZts0oyyDrReN7DPsCd3D1Wmm?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edcebe8a-d087-463d-fdaa-08de15f25a03
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 07:19:38.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v931VEF3fOcgHwduY3KcJK1aQNkoI/FY6FMDfu8/nTydxiGSdDolWPAh3nRxCnPD6q/ORy5xTn2KSoO8rtz6hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBBB839A03
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.026.fail" on:

commit: d72352d1c3a3a201dcd3684b05987f281b1d66aa ("[PATCH 4/4] btrfs: introduce btrfs_bio::async_csum")
url: https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-sure-all-btrfs_bio-end_io-is-called-in-task-context/20251024-185435
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com/
patch subject: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum

in testcase: xfstests
version: xfstests-x86_64-2cba4b54-1_20251020
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-026



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510281522.d23994ae-lkp@intel.com

2025-10-27 23:06:41 cd /lkp/benchmarks/xfstests
2025-10-27 23:06:42 export TEST_DIR=/fs/sda1
2025-10-27 23:06:42 export TEST_DEV=/dev/sda1
2025-10-27 23:06:42 export FSTYP=btrfs
2025-10-27 23:06:42 export SCRATCH_MNT=/fs/scratch
2025-10-27 23:06:42 mkdir /fs/scratch -p
2025-10-27 23:06:42 export SCRATCH_DEV_POOL="/dev/sda2 /dev/sda3 /dev/sda4 /dev/sda5 /dev/sda6"
2025-10-27 23:06:42 echo btrfs/026
2025-10-27 23:06:42 ./check btrfs/026
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.18.0-rc1-00265-gd72352d1c3a3 #1 SMP PREEMPT_DYNAMIC Tue Oct 28 06:52:50 CST 2025
MKFS_OPTIONS  -- /dev/sda2
MOUNT_OPTIONS -- /dev/sda2 /fs/scratch

btrfs/026       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/026.out.bad)
    --- tests/btrfs/026.out	2025-10-20 16:48:15.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/026.out.bad	2025-10-27 23:06:53.540513519 +0000
    @@ -12,4 +12,4 @@
     5876dba1217b4c2915cda86f4c67640e  SCRATCH_MNT/bar
     File digests after remounting the file system:
     647d815906324ccdf288c7681f900ec0  SCRATCH_MNT/foo
    -5876dba1217b4c2915cda86f4c67640e  SCRATCH_MNT/bar
    +md5sum: /fs/scratch/bar: Input/output error
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/026.out /lkp/benchmarks/xfstests/results//btrfs/026.out.bad'  to see the entire diff)
Ran: btrfs/026
Failures: btrfs/026
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251028/202510281522.d23994ae-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


