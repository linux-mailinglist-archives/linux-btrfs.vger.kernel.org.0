Return-Path: <linux-btrfs+bounces-9000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359519A45E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 20:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5054284CD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206022040B3;
	Fri, 18 Oct 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gsmckuvg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEA2038DD;
	Fri, 18 Oct 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275990; cv=fail; b=GEy5Nd1OVh/AgzohiZO2Br58IGwrMgtkk8Z1A4KoUOy8Eht4rOaG9GU9yHN4o491DvjOFo9N9JJg0X7mmd/+ojGiPvpwQjyu3+8NoXx7CbiP5q2O7Ep3XZPt7UTxrVB6oTJNgaTfue0ZWqQ+FxIV5kg88ZobbhciK3Pq+lR7rcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275990; c=relaxed/simple;
	bh=f67otBe5EMA2kH4X2rVvWyj2b/m3sCQSMwy8LCd4bg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VXopPbq8J56GgzqIhXAIC/qY15drQGFGk02c4t//J0Hj9hMs7AfKArZcvYU1ze5YagUJDEotma/h/95JLPuVwTFep7w60rNqd4VvU0a3wsS9k5hZ5HYZCr4NvDNkn5Txr9tbqfV6HTnSqoh14sIg7mjdFLoHR/4TGdV8GF/WVqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gsmckuvg; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729275988; x=1760811988;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f67otBe5EMA2kH4X2rVvWyj2b/m3sCQSMwy8LCd4bg0=;
  b=GsmckuvgfRHe69Qt4letdfo3ihwe4O4EQTDl32hcrG4L9htoVsgddfFl
   pDePVtU1pXVmrPYcN80oIBBKCOusuvcLzeuVdO7aQvVaiupLOVl8JLa5J
   Gmo9NKykMDO3PEpvNEM6Hy/Yiffp0nnw0YM1PSZdUE24jnzfDyMcZkv4A
   JMooCr4jXtQ424up1QuWppOWbvLuryagHRGfcY1q6kz19DYKcAEs+pweA
   RM2v1J994N2UIY72on+nos4/WfViL/MEp6HSvv++wTxGTp50exnPxxtDC
   XhblyfVSEzdg0ST+mmntBSXB5SMme/Bw/swh8zlb7mX0FACQkVCUKO1uw
   A==;
X-CSE-ConnectionGUID: c6+DyoOQQ8qS0UM8Ay296Q==
X-CSE-MsgGUID: vsTPIm4sT52Oskx5Te6cPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="54229389"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="54229389"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 11:26:27 -0700
X-CSE-ConnectionGUID: AHO2E8CIT6O3n3Qmzit3mg==
X-CSE-MsgGUID: IL7BGzU2T/S944UQysirqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83734586"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 11:26:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 11:26:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 11:26:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 11:26:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJoP2EXP/rLpSHwPzqUnP63DFI3EyiQNBXYeujoIA5FfN9Z0Ls7SWaIBnfoHqdr5jWB4DgAHlnPRv4tpwxq67lVBXEE+bfcAyhBVDI7Ror1n7qi7LzM9cqJUMpQEITxEbys0gOxgZ5b7iZDkz5vKnKufOtYjS4cE+zzsDbhz+1wsMbACC7R8uaC/yh2SC3Jit//cd4xNPS8HoO9TcGMCIg9nUqEqDpqT3td6o3mlg+CUJ83xAwEdtBdbNBgOYzYhQx0f1sJ2Lpz0pUEWiHcGjSslRh91BOjrcyTv9UFlXPRSEeBn+DCSo3YH4XsPbqyQ03+tDOj9GNPRrDG2bPQl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LB2mvj1K+/kisY7rbSLYHTrnv48Y2hosGduXgX+NHis=;
 b=pLjLi6+Mo9hZ2FZSkONippZggAghT7/OcRDw7WHqlDoFLYubEsOtBXT+oGDpGVcZuqjteEVvAHeaWRSYOr7WctHE9zpP061m6W2Ux2yyKM0ZuXE8wBqhqzgurM7LWd7z8A+k9QPeq36362UniJC1ViRC0V2qgJSlNqMPRhZUavUcsfmjhYxQKQuLkaucknsre1nxjFwVaD0ea8BqDvJdyKDaSZdDXiHIEUBld9fWalNlbYL5+0xaWvVsqU/ujHrPd1fl63dwpwO5/cqbjIXJwOv1HJ+1RE9I+PCIos4oRt0k5fjbde45SPBpqmo4r9QzgCA2LCMHTUwaY7ypDR0T8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 18:26:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 18:26:23 +0000
Date: Fri, 18 Oct 2024 13:26:14 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 22/28] cxl/region/extent: Expose region extent
 information in sysfs
Message-ID: <6712a846dad09_2cee2945a@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-22-c261ee6eeded@intel.com>
 <20241010160142.00005a5c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010160142.00005a5c@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 325b69ff-5ef0-400f-4f0d-08dcefa25e5e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uS9it/ROv5fx8wAoxaEXusBcKA2u2snPkG394u3ARnrvFO/zQRAidlNE47L1?=
 =?us-ascii?Q?05hLeV1hV6OmO+WVgFojY1MNNWM/8GfOgRhLRx8QnuF6L4U2fJ+p7EkQaozK?=
 =?us-ascii?Q?QOpY3PnUp36UOkp2w8RInViVl6hD2wF15uFOOrzQ+66r66f6gx0O7eLBUmVf?=
 =?us-ascii?Q?Q/fRpWfuLCrwX67nn7vAiy8dFlwtqfHdoGxT+ShnQhbYdCMcRVtPcjW8toPq?=
 =?us-ascii?Q?yr+HwTsgmhfuK1wtJE4IIyWNhb6qw496uQoNlM2HRwEVKopvsPnyvw7OJ+et?=
 =?us-ascii?Q?WtaIYh2QYaNKalM4zDsMWYzi2Gl6GytPFwP5oBeCPVDwuhFL3LfHUSM8wsxB?=
 =?us-ascii?Q?6muHLE1bUPHDRVcYZ/TVaZ/0HvxU549AfSbzi0uzUPSq+cREtDoijDhrBbvi?=
 =?us-ascii?Q?lMlFj1hI3pzosehoCFY2kWe1uTbfVhyLQL1crEL4ugDq2MhU2r8EDIDG4f0C?=
 =?us-ascii?Q?9iMkjqbMR0yhQF1HSqBrHE/wWcc9AQ2dwfRyxRlWDhzRE9unNgFkXVTatun9?=
 =?us-ascii?Q?w2cbPPLO+8HUnoPsgcBmd1/8pUfA3r763Ppc8wN/udRqvKIWoZVwRiDrQLE5?=
 =?us-ascii?Q?oQRxaKyFtcVuXO3Xv1TMbMzrmiWKlM60my95p5GkIvD4KjcW14J5AUpoWoPy?=
 =?us-ascii?Q?J5d6QHyyDkjsn5+P9JM4BgJGj45wuQe00k+Ii7L+n/SP8kAEGspL9uh9wZxY?=
 =?us-ascii?Q?g+bIZqDak2qOVxKp/YVKfpq245Y0lSHxW9DCEEWIymCk5xAl/aNZUxlJZrqT?=
 =?us-ascii?Q?l5VBUAmo5BtzO8Ivk8lB3Yo1bLC3vZjrWODkpA/6LHE5mUOptcTv971qJ4KC?=
 =?us-ascii?Q?T1ipe7QcAvoh2HF8SaVgOXi+VqgiglyULdBtX8GqblzQBrqLG88d8u1i53dF?=
 =?us-ascii?Q?BEF5ViQ+8sNXd6qgWQ/JwZ9BAmskkjAf5rJ7dnCEZgmOKB0umAczzJLO+lSp?=
 =?us-ascii?Q?xJcZDdetbiihXRNlKmTYfijXTH93rLG8XrXc+p6+knP7m8YwtztHhm9LekVg?=
 =?us-ascii?Q?Fb12CTvCgTQxOUqVTxKE4Pw3kbfsG9jKC6AqmoA7tTEQq7745SY2ELFkUcQ8?=
 =?us-ascii?Q?nKhmJKoucmqOnQGQs0ApIzOyaQVSy/BjWX85m6JQb3+/12w3fGS6E95i7Bwo?=
 =?us-ascii?Q?vdDWBNYoS5xknEU0pOI0Br2IYyAyttlV4oYE7I+SGRKsLX+74Nogb+VAt3P7?=
 =?us-ascii?Q?/Y1ZCwIWl1s2xSd5dohLXqryZ6OpezwAFncX97YaxOdgCjyo8Ww63yqO7q83?=
 =?us-ascii?Q?NrPrY1VewcnJ08uaoiOsxa8PHW5u1o++K7kviHZE3zIck40LE33lMAUQL58a?=
 =?us-ascii?Q?oWtFbhc4KWzdzn9c1UEci7tG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZl3llosAL/POnjyanlnYgAtPJ8Ow73M5RXjlP962uNa9NXJS5T4f5Y5GXXq?=
 =?us-ascii?Q?QlLWaF4gHZ5RMPAd/AVYz+kK9l2oVvGlYcJHKZxWFwPvGlDoZzLKRvDjiBbL?=
 =?us-ascii?Q?OvcRU15jHL2UMC2hVR24YuD+W/DCOQT4AKOnhJczF6r+rfaUWvUj4dq4jDWn?=
 =?us-ascii?Q?KONon1v3E6EtZZGj8Q+3JMnLlgOcpMUnIfwuz6NKRnOnKGearJ52p2y4wI5d?=
 =?us-ascii?Q?GS2k+GV6oyO1N+Fw0fsdLiL4QTH5hs92ihK2Q8Qtvk2Gz3bl51PLkwR+fHYb?=
 =?us-ascii?Q?Qj24IYy9MvAJRPZMZc864dBi5MvgPChmCdGi7uC1ylgU9fuC20Y2ZhX/hHhI?=
 =?us-ascii?Q?zWWiSKZWcutur057bzMMUhQ4ZyYOCVOsbDuVgbSiT1rbdLLxoOCv8KXmvEuY?=
 =?us-ascii?Q?yfd8yvNAcgHI7D0U3+J+rDR3KLnyP4qT1pKPnQ5xw/d7YDArUUr5thK4dNlx?=
 =?us-ascii?Q?IehZJ7/a2sZ1WDAbXgygi9RIDOyCkd2qnJ1kGpQEaDBYwjn0SUv/rt10Mfto?=
 =?us-ascii?Q?uGLFDnetX+LbX70hbtGxmuUTSdPAFDt/x51COMnctsIEOt6NYm8RI4C6hPuB?=
 =?us-ascii?Q?r1PmNfoyofozYXnTOEHDYc87y7OoIOWB/ojm2kF3HPfg+B58wAIC0BTjrX12?=
 =?us-ascii?Q?tnguMvv7rIqT7mz48frO9s4Czm0B5cc46ma0zteo1IQTwuEPXxAqW7y7Tsxv?=
 =?us-ascii?Q?ARo5HsvQlpIksS5w1WPYho49qMTXA4/7X1yj0EBeHNyn+Y7fx84E5o0BlFdj?=
 =?us-ascii?Q?fFgFztl7bugjoz3jXdZphtI2GTRPW3Ij8Vb3ywZkSaK2z0AgAn/nVjP4fLkF?=
 =?us-ascii?Q?vLBl/9hkvADc7uHzYJdPpJJz+DAUhhwGayEcebNQObXuCzCNzy5n+9bHQ0yS?=
 =?us-ascii?Q?POmA6RTGeGTmnkmPCqnQrwGFKw7Pmea87+DpsXLkDshPf6rhbxkoh1RgQtGC?=
 =?us-ascii?Q?8oLVdjZs8P64O8HfuGWwJd3QRUrdBBBF4FF5m+UcA0mRIh/HoFhwzN7TYWW4?=
 =?us-ascii?Q?gFYyeGqQXUKURSua/xkXAnrUUFgtrk5MhmepJbsAB1/RqgG+07BxqhgEDUTJ?=
 =?us-ascii?Q?5nOaDkhucCvrVwn2a5KlAlzuKMBVTmwK+CSed6yU5FnQm7gjN+WSYtUKSDBN?=
 =?us-ascii?Q?2WS7YrDkO2WI1wSHVSXn2VZI8bIzIA6ESQNfx7VevCWiuEeRsZGWYAa5GJpH?=
 =?us-ascii?Q?krtfzD7lUIuLxyXTLbpVDyplG7xTDA7XsZJqoP8BPJTiVkJIV0/kDLhipvfC?=
 =?us-ascii?Q?lzpQ3Yea3Gc63myOxsWtjX5zMtb5PFbNK4wTtlE2t8IgVsYdIj9icJe6puyw?=
 =?us-ascii?Q?zUVMFyFoe/uHNBgDVTngZCbOlZ25RU2rfkrOTbKiabH4V4cI09syLqbzSQfE?=
 =?us-ascii?Q?qkWxps+V7pT0XRxJt+0ieUtbJJ8CpFJRR+mSFtXVHfBKKzjsuTobqxc+T5Wq?=
 =?us-ascii?Q?8lx73twslDBLXR6ZAqSFfqmiJaeSAIgq7j9mTgtqGYlrjK0pgQ26cyV2ZEMu?=
 =?us-ascii?Q?OZ27yGZhW8fQJm14G3tiUe5KTPp9kGsux5LtxaBk53ANvr0+4jNnqM6+ix8e?=
 =?us-ascii?Q?QFzn3YtHvWk66Ie+d4xCBZp8VjOYgTDAwhGoHKfD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 325b69ff-5ef0-400f-4f0d-08dcefa25e5e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:26:23.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkFSa8YpE7EpkvXh0g1ZJ6TjXXA5IPxwPoA/3FnBO/sjAbDyeHaKVwITmPRj8s8Dsz9Lu4TNpRxG9pP59CVmFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:28 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Extent information can be helpful to the user to coordinate memory usage
> > with the external orchestrator and FM.
> > 
> > Expose the details of region extents by creating the following
> > sysfs entries.
> > 
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Trivial comments inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> 
> > ---
> > Changes:
> > [djiang: Split sysfs docs up]
> > [iweiny: Adjust sysfs docs dates]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 32 ++++++++++++++++++
> >  drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++++++++++
> >  2 files changed, 90 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index b63ab622515f..64918180a3c9 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -632,3 +632,35 @@ Description:
> >  		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
> >  		the number to the closest initiator and access1 provides the
> >  		number to the closest CPU.
> > +
> > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> > +Date:		December, 2024
> > +KernelVersion:	v6.13
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > +		extent information to create DAX devices on specific extents.
> > +		This is done by creating and destroying DAX devices in specific
> > +		sequences and looking at the mappings created. 
> 
> Similar to earlier patch, maybe put this doc for the directory, then
> have much less duplication?
> 

But none of the other directories are done this way so I'm inclined to keep it.

> 
> > Extent offset
> > +		within the region.
> > +
> > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> > +Date:		December, 2024
> > +KernelVersion:	v6.13
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > +		extent information to create DAX devices on specific extents.
> > +		This is done by creating and destroying DAX devices in specific
> > +		sequences and looking at the mappings created.  Extent length
> > +		within the region.
> > +
> > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> > +Date:		December, 2024
> > +KernelVersion:	v6.13
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > +		extent information to create DAX devices on specific extents.
> > +		This is done by creating and destroying DAX devices in specific
> > +		sequences and looking at the mappings created.  Extent tag.
> 
> Maybe say we are treating it as a UUID?

ok...  How about?

<quote>
...  looking at the mappings created.  UUID extent tag.
</quote>

> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index 69a7614ba6a9..a1eb6e8e4f1a 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> > @@ -6,6 +6,63 @@
> 
> > +static struct attribute *region_extent_attrs[] = {
> > +	&dev_attr_offset.attr,
> > +	&dev_attr_length.attr,
> > +	&dev_attr_tag.attr,
> > +	NULL,
> No need for trailing comma (one of my 'favourite' review comments :)

I'm noticing...  :-D

Ira

