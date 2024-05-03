Return-Path: <linux-btrfs+bounces-4731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188058BB17A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C324B284E8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C9157E98;
	Fri,  3 May 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGfrQ7Uu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E315749A;
	Fri,  3 May 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756194; cv=fail; b=G+DygT/VZF9UNBxS+RoRCysF+EXp7HRBcAZy24gAXc4ZmW+nQuJIbdoBzGsE2BNKeYD4FvMsYkhtSGjzUCLawbpC2r2UlOnuJkV9FFokX/QGjrku3hPMpdDQGDIdLaZ4sStn68eWNkPVPCJogvtmb7++5ezRyD81JkIBh5sSZvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756194; c=relaxed/simple;
	bh=vwyUbpiHeZWMsb4t1JUb1bRgznDPSrdbML2es6IzoNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D2OE/pztXkherY9MiHRcY7oe6r6wZ054Jrcs/tDaQgoCAvs3mnTDAogxcXvJNMOgYwu69Rxr/87/9TTTpkIfbi1qKaTPVNuz9B5ng4P/X3dehtN4Y2xYaxU69oxl0HvEV27jqFFU3lHkB7txgCBPiq5/Ko1u+oKFBgUnMOOxNss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGfrQ7Uu; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756193; x=1746292193;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vwyUbpiHeZWMsb4t1JUb1bRgznDPSrdbML2es6IzoNE=;
  b=ZGfrQ7UuAPND/ilkWDIGgd9d1hUNZ+LuZg7iLAT1vypxWpg236cnkMdv
   apxN4DUmskECLzOXFNTktOpnIOaWM+WRJwn9w7W/27y2wi2ylV1tCudM2
   d0nt5xlv/36fr6aE2cB/Odf2G9E8qiPqnJPNNDHKTBEJpqAY1LeVqBOo4
   S4vZzFQxegjCFxp8uNqTvoL+mvMeLLr1wF94Lw2/PXEv9C4ANX0ddFxA7
   LxlRrnUyX+GfyXZe0MLCAnBXZ9cJicS9ZBavL/vrBUzGycWKdeSbvZNFW
   FNK08M/SVF1AruSWrPC6uD3yKpGx6Ij8sCKfOzqyhy7u7Tg3vOpqe15Fe
   Q==;
X-CSE-ConnectionGUID: 49S/i4RNS4iL6vIdvrOeiw==
X-CSE-MsgGUID: xE0geBbFRoKBkKlslTg2xA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10498590"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10498590"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:09:53 -0700
X-CSE-ConnectionGUID: /LlJdr79R+amhTXcwF2AFQ==
X-CSE-MsgGUID: o/0IMopdQ+mrdCxgHuqfhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32183688"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 10:09:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 10:09:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 10:09:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 10:09:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 10:09:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGQX0bFl83xGfoowFVKoVLz3UhQOjp8TSYnlMZBWP1lZfgkIgXMi2HI4IUjL61h3APk1nOr9tGKe4pb0CgQvV19lpS/eTDcttUPSDJAVr1d+0asNOAETvT5iLlvXCV6MMaDCnSHFmgyvxKfE7mSPNP4oIqrjRf7eqSeHp0ZHx57mPLE4RUOZj2muv+IQ02DyjodZy3KJFweaxwuESupwJLZtq69yYRbNCnRlAogQ+Y0Grwjl4ohvS8357Z8FOsVOfOXcrNziQTMnRE5MHnIhb8y0F4OnINbZujC4RNpskf7uVmXjCqi+FXOrh1yTsVMg7yJvbMNMacW2aaWEH0jc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYwUa5jTkQFcZDHdAox4rVjNmgFL/+CFdlMPjvy3Fcw=;
 b=HNn8nDn9pcVqoLI9w/OpbLXF6mzFIsGuIzv2x+YyDP8oWPHhSEU8d76T0qA1TNpVRqZX6ZQL2XzLml0oA1rQGVoB7Zdo2a4D1XTzP1J2UyWtZx7rh9j+OpB9Bt1IRo3kAKnVyOzhLmVdhJoDudbEMvxDXhNz8NxMcEjaZFhpPK+TgZoeN5Sp6gNGzkiSErvhqRM+LRYwghbENKYFY+RXMy5TKaVrorpuJjF1tO67vhl2d+fNVd2LXZe473L+78SZorTP+R7nd1ZuiXfI93ZfE0jNY+VXrIcyTc0e+0k9ml+XdwXYhAyBUgRt/3p+0b/CNu587pJI2KBo0kzddpAq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 17:09:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 17:09:46 +0000
Date: Fri, 3 May 2024 10:09:41 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/26] cxl/port: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <66351a55a38db_e1f58294ce@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-7-b7b00d623625@intel.com>
 <20240405145444.0000437f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405145444.0000437f@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 9129fd06-5f3b-4212-996c-08dc6b93d536
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WdrAEWz3J6b9cmQLLed4g5NhnLI1TsJmx+bJr0en/zHr6PgSiFt7x2z7U7yb?=
 =?us-ascii?Q?SDOzhoNKQ80nWLyzhgaHB6A1SC0LP7EFPrDEMQBTBkw1mmjPyMqOForfa+EL?=
 =?us-ascii?Q?0sSGpn748il1NmCc5Uxt99l7GjpO4c8dXcQKlaFcBGEM9+dpw52o/FIjA8DQ?=
 =?us-ascii?Q?qmkt2vlxBvYw2tNAePolQbXfT5S0EYpFp4Ny58LPOFp6fLtdKdEnA5XBgBmM?=
 =?us-ascii?Q?Fqd5oMul6Eu3B14n6sdesd2Put13zEJ5q/DOBAmwGt02l9hyQKgXkw63NnRy?=
 =?us-ascii?Q?JD8hwpB42K6J9AexO5FShSI1a/dkbaS1WWDmNIrSBGzDNDg9qcve3SapO2bi?=
 =?us-ascii?Q?HqetuYKdOlzhjpWb0/0G9uq1v55ByUpRMbdLSo9pKnQinvZCHebucmsLEOWi?=
 =?us-ascii?Q?sCy+13/TxkypkoHHKiunImGGzn8Yv/nBwxSz47M4Q29hWKCTOx7fAjpEmvQD?=
 =?us-ascii?Q?QdMucgJB8UZxig69TwegM6JMlyNgr1+M05ko5syhWCRtgpWF0CZiU/sdTr77?=
 =?us-ascii?Q?O0Sg+ZEigJLWtAWPqSYg269Xq3oYsTIwmS0r/6k77cpUBEkkr/UzPIhuzHMr?=
 =?us-ascii?Q?NMR/Cj6ty5fZSkfZr2KyiQR7fAkWWQrinHxG0uePMtmudwi2y4+m2Z6UVh7h?=
 =?us-ascii?Q?t2CaBARb782yXtDsSj5Jzx/he66yiHbooWlnBApdI02lIGcAkysaiDcmgm6X?=
 =?us-ascii?Q?SCSKBGSU880xU2jTwQz3lFt8YiFtvGQ+1B+AzE/1O+V71jzcV8pH6abiv/bV?=
 =?us-ascii?Q?BF8hlX4W7/Vq56uXInPy1UTDL8XXbl9lJ8r8SoZ/jZ6xOLN8LYLSVCIIjM/o?=
 =?us-ascii?Q?gyvwwBZSZhW55ncAkECWAoZD0m1xIbCi8ntWdZTzz5HWuPLLIFZDJ4YYp6HN?=
 =?us-ascii?Q?H/5vt44zOO8HQ0zFQCJTzY6oAVQ05SVqU4RYmq2AlRgKoE8PlVpCmxnxDX/1?=
 =?us-ascii?Q?OLHcYecFi2BXiMNjmhZwyXB06eSK7ivejmKGzBWn8Qg2df+M/iwFP2SwDNul?=
 =?us-ascii?Q?HiXacQ9F8n++0n/5Ugx5URNA32oa+QnXISrBkD1OL5Dfv9Q4pOlFFmF2e4ov?=
 =?us-ascii?Q?pMtmUVCDsnfaLzTBhfeCVLTIPxY6KCFwzkRJMlGQvVVbeMxYudKHmTAkPGEM?=
 =?us-ascii?Q?/tqZHhNjdisZLIdJ7syVQToA8/X9BtRGmhn7ffzK4vXUv8ACcU4vCoL1Z1oz?=
 =?us-ascii?Q?UAkM4lht28KbkJzt7D9vJz9V9wghcW6IR4KbB7Tc+akrQFkUrWIgnfBIFpc4?=
 =?us-ascii?Q?4odGdBucAEU4MI6Mk297ShPuFuArmYOlf7OduZ06dQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMxCtQYcKyr4fWxOzysT90fbvXVhB+j7YaUcF7qwVBD9q/ipbBjBLpfeHdVY?=
 =?us-ascii?Q?dWesQmdP6ShefFY2nmDvWo2mXEq2eOvloVMADuZMc6Ahw37w7Cj4brqxx+3B?=
 =?us-ascii?Q?b3t81MD7oIO5BvzKyn31Go+mq6Qp7UJcvLvNBXESLPh2sKFOwDFgxM4OhAiJ?=
 =?us-ascii?Q?mYZ1lORquAKH+PsnFcbhByu+PRGlOyWkdX0vG4NCP+YM9KIxM2EB3035UILO?=
 =?us-ascii?Q?AAZ6CTVgkKf+41DbE2PvY4Gn6RKAwZiYF8ax1oiK4gbJvHIAdbMbQJr+izJE?=
 =?us-ascii?Q?NVXhVPFqRWNknmfE+U1icdKLEPyrsmOQUXWb9W9wEbjGvdESymmNLt5B36Nq?=
 =?us-ascii?Q?/t4StBuucjR0KLh/x9sS67RedmcJPj6H25T7whegJNPezCZDSAkXCd/bDix9?=
 =?us-ascii?Q?DactpJ2DNxRn3F5GNOIdF3p5hF3s//z7znSvP85+gIsThi1TnfBvtyFreRFT?=
 =?us-ascii?Q?5fH9Qh7RymiSLiBqfjAUr7Z5G1M7uCoQmzx0FoGqJKnJM3eNTNF8f+LVcLxf?=
 =?us-ascii?Q?sSsR58E8vFUCYCdfbiyrHN5M20s7fK+1F0e02CEEv6MbpwLjieiJQ2K4Ux+2?=
 =?us-ascii?Q?2SMvntnOp7h9Zb9MQX+0BQr3eCClWO8Gdlh6ZysHkTCbVpdVYAQO/tYdDzYq?=
 =?us-ascii?Q?NPU5ogyNNAfHDSIblrmhpoF9hwWsQjgy+/peFVow3NSJd57mb0z9NB4xf8Tw?=
 =?us-ascii?Q?vavpr8m1j3GWMPN1R1uGiC6BTsKN/zM+uv3OmlwbrwfkKOUQqtLqX3Z5HJBf?=
 =?us-ascii?Q?E/jVp7ew6r6Qtnv+b/329jgzFLZ7tn9yYhCEiBE3S7xmmztcfX7DlNCEIf6u?=
 =?us-ascii?Q?Ih/MZGPd85xSXoZFm+tt/aESfYJiNfzhfq45zedhKyY6w9bjBG/s2iHsJlmR?=
 =?us-ascii?Q?HHGtUCJ4YVfQr9dXh1aOBvg+RnT799eCZqgrPTRUc7Lhi/Ek0HxRkZLe7Lv5?=
 =?us-ascii?Q?OV7Cs5vjBLxTtJp9bCFRVm1OuQjNwM8udfG1BHYLVJAG2HK9PQWH0brpQ+mf?=
 =?us-ascii?Q?u9bscy/fmQox4226Wx6T19zacKWPW6jORnXH1Ku4u4zSJC1Bi/gcmhnBnHC9?=
 =?us-ascii?Q?tdhefJEuFhH8vPrw+qrDnrHF71IeNFI1KWb/ZZlHRuslYRRwurHcDTxuFpKG?=
 =?us-ascii?Q?3ttXXwNF3J70lnjdO/Q2c6N5uOdhoBhyhBV6RPkOkq6sTe6HHQ/aXVS8ibMR?=
 =?us-ascii?Q?piBko3fzIx8k2DN405iBTs7BqipkjJKoPiaU5/5K8cjlT04cgYSa9qOKl2/h?=
 =?us-ascii?Q?naTuXm5JfzR+Du5KS/+tIwWwjRGm18y9aPdx76/57smJovZVKrbYq2z6+XOp?=
 =?us-ascii?Q?e014cdeBcxZU+FFp533/DtLiGiOxg76Mjil2nv5Bn2UneZDdSfD0T1sQwDWi?=
 =?us-ascii?Q?EA+iUWozEWcdz/37CaoIbe+LK4pfHKWVaGK3mK+cTxnZ32TKSL59IWwWhT6A?=
 =?us-ascii?Q?bRIHSCfwPMJ2GIWNVDnJVL3gq6qorIwKJtDNAg3QoODfORi9CcL3Ia1p7CEy?=
 =?us-ascii?Q?0AOJdccU3VDY7JoGLFNudxpOhIIG0SvL3BytZR08so2TSphW0Wuwp7L31MLF?=
 =?us-ascii?Q?L79xNAA8si84aQOh2fQ5AGPwyHnvLi7OmF2ap2O7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9129fd06-5f3b-4212-996c-08dc6b93d536
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 17:09:46.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpUa400hEndPvqg3qvjm1U7YAehy/hsRjXV25r9JlW6EykjrF9ho02zzDXoDsOiltfoQqCH8aeIf8d4VJ2jgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 24 Mar 2024 16:18:10 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
> > map DC partitions (regions).  In addition to assigning the size of the
> > DC partition, the decoder must assign any skip value from the previous
> > decoder.  This must be done within a contiguous DPA space.
> > 
> > Two complications arise with Dynamic Capacity regions which did not
> > exist with Ram and PMEM partitions.  First, gaps in the DPA space can
> > exist between and around the DC Regions.  Second, the Linux resource
> > tree does not allow a resource to be marked across existing nodes within
> > a tree.
> > 
> > For clarity, below is an example of an 60GB device with 10GB of RAM,
> > 10GB of PMEM and 10GB for each of 2 DC Regions.  The desired CXL mapping
> > is 5GB of RAM, 5GB of PMEM, and all 10GB of DC1.
> > 
> >      DPA RANGE
> >      (dpa_res)
> > 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> > |----------|----------|----------|----------|----------|----------|
> > 
> > RAM         PMEM                  DC0                   DC1
> >  (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])
> > |----------|----------|   <gap>  |----------|   <gap>  |----------|
> > 
> >  RAM        PMEM                                        DC1
> > |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXXXXXXX|
> > 0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB
> 
> 
> To add another corner to the example, maybe map only part of DC1?

Maybe.  See below.


[snip]

> > @@ -500,6 +617,21 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> >  	else
> >  		free_pmem_start = cxlds->pmem_res.start;
> >  
> > +	/*
> > +	 * Limit each decoder to a single DC region to map memory with
> > +	 * different DSMAS entry.

This prevents more than 1 region per DC partition (region).

> > +	 */
> > +	dc_index = dc_mode_to_region_index(cxled->mode);
> > +	if (dc_index >= 0) {
> > +		if (cxlds->dc_res[dc_index].child) {
> > +			dev_err(dev, "Cannot allocate DPA from DC Region: %d\n",
> > +				dc_index);
> > +			rc = -EINVAL;
> > +			goto out;
> > +		}
> > +		free_dc_start = cxlds->dc_res[dc_index].start;
> > +	}
> > +
> >  	if (cxled->mode == CXL_DECODER_RAM) {
> >  		start = free_ram_start;
> >  		avail = cxlds->ram_res.end - start + 1;
> > @@ -521,12 +653,38 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> >  		else
> >  			skip_end = start - 1;
> >  		skip = skip_end - skip_start + 1;
> > +	} else if (cxl_decoder_mode_is_dc(cxled->mode)) {
> > +		resource_size_t skip_start, skip_end;
> > +
> > +		start = free_dc_start;
> > +		avail = cxlds->dc_res[dc_index].end - start + 1;
> > +		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
> > +			skip_start = free_ram_start;
> > +		else
> > +			skip_start = free_pmem_start;
> > +		/*
> > +		 * If any dc region is already mapped, then that allocation
> > +		 * already handled the RAM and PMEM skip.  Check for DC region
> > +		 * skip.
> > +		 */
> > +		for (int i = dc_index - 1; i >= 0 ; i--) {
> > +			if (cxlds->dc_res[i].child) {
> > +				skip_start = cxlds->dc_res[i].child->end + 1;
> > +				break;
> > +			}
> > +		}
> > +
> > +		skip_end = start - 1;
> > +		skip = skip_end - skip_start + 1;
> 
> I notice in the pmem equivalent there is a case for part of the region already mapped.
> Can that not happen for a DC region as well?

See above check.  Each DC region (partition) was to be associated with a
single DSMAS entry.  I'm unclear now why that decision was made.

It does not seem hard to add this though.  Do we really need that ability
considering dax devices are likely going to be the main boundry for users
of a DC region?

Ira

