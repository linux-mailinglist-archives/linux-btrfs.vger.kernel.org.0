Return-Path: <linux-btrfs+bounces-4761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DD8BC649
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 05:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59941F21EE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 03:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682574436A;
	Mon,  6 May 2024 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caauH1w/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE443156;
	Mon,  6 May 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967229; cv=fail; b=MmY9JBCeOGGbiA66LiO94z9Uly91pAVAXSEJcbjb8OOUziJZey2wdiOdz0N2nhX5SwuBEzpabENb+7CZPClO8TNsvfvnFTpgG/LhmkZFtC01jcKCjgRf91gyEHJqxJ2sFqBgPYWjlHVH3o9U9MsKFFlnkyN7Q5cb9ET8Dp/H6BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967229; c=relaxed/simple;
	bh=k7rdyq53AgRfXqczBly9YJYfcEfesowOv2PegI4K2Ig=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N8UjVTAN50CdxgdLOrsMm8389BBvXu30xRM6MRkf9+pB4xPGoeZSMNGH3QnPTlzeW2ijQ/2InY+zBj3WcAkWGeRuuhYs/yPIxHCKK7ehh9igHCQ5LQhGUFamiPmuG/V9ni7da9uukVDvrE3Gfse+tsN+G4VdKi5fLFAi/u5/M/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caauH1w/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714967227; x=1746503227;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k7rdyq53AgRfXqczBly9YJYfcEfesowOv2PegI4K2Ig=;
  b=caauH1w/ugivE0TnD0DmR98K93arUcBBuo+5up1AlahnaP5l9VcVJDSa
   VsJKR2BOeZ505ZX7OGw0YsI+4nqROCbEOKtH3wZ6OGiw9C8WlfQdmGY01
   3e5i01KTsokiEKrF6o8WqnJcYuNLEX4CoJiE9jWxRVKVB9LwDYew/I1nI
   58h4hMdPI5o2ZHJWdYpE3B70JG0qLdRkboH75soFRSmpqO43lm45dHIbX
   je3gmHQ1H09eFDz31LgGUaJmHvvWf03qNIb69uTBj1lscohu0jmnWyEz1
   453HK1S0ogzxanH9YE6tlO5VyWgkzIq1vqqZcdz+E8JuQWVXYyfNSIIFc
   A==;
X-CSE-ConnectionGUID: c13TCiZTSHKeY9YtIPefFA==
X-CSE-MsgGUID: EfUyAk5vTlm3mBAB2gEiTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10851819"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10851819"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 20:47:07 -0700
X-CSE-ConnectionGUID: Fq8B/WTBQeyK0nOOndUnxg==
X-CSE-MsgGUID: Ldu5QireRUqz41BlkYJevg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28144701"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 20:47:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 20:47:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 20:47:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 20:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WivuW5TFMYUvYRpfMgELBuxbi9JoqntAe/PvTQOQuMJoaMOAYmzLSi9m3wINhbW+RDU0b7liBhrsr11LLzZ6l6rQsKr4nZdW9IouCIQnu2gSJ7L062pLD/zLyudAt+kJdfnmXQqdMv4VRV97nOKWg9aIRw7IjZHxWbZJlGrC8wWDMzXN6U7suZriSLo0MrfvqMQrlsryNHqRv18+nRxkZDZaEGzmuvkFHjtuv6ccsu6yxivrDd0bIZzc4WcP1xfJlWA3JpMVEx1HKYHZI+K2Fra3jp04fzRXYQaffhnw4+if+BdgJ/vTMfu3joyXirvNlyfdzch0cfbfIT8X+8j5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed+FYOYFeofXaRJosSG2QktFuGG5WdLEaTmO5CR5gKQ=;
 b=Mj4JNp/FPVHibhvajVuREK33dd/xtKSLogkh+3RbrpXcm7U4HiMxi06JXkZ57lglm0JbZ1nXdtg+VXBj/mSpe9s5OSWkLpTM6LNlzXA35sogYVCit4/Nel2++9kW+/op+2JlqasI3qFy7jYyDIuiOZX4yEraH8DCa1NXNMBqmX79oNdjMb9/NP8mX8kuhcK0YLqcXaeLmQUiVvvipNZ7BXdGtObNtwBMmJF/CTzWmicnW1Cdd3n2pxqEykS07NuE/5s++EQ7cGdfOHlMV/PF1ePgy6NXCp5w0bM8evb86GEoynNhjP0NR6s5XxtbvXBzpSJGdVu4pCCIP8K3vzFzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV3PR11MB8481.namprd11.prod.outlook.com (2603:10b6:408:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 03:47:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:47:02 +0000
Date: Sun, 5 May 2024 20:46:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <663852b3806f1_258421294be@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <ZhSPHvoTHl28GXt1@aschofie-mobl2>
 <6635366717079_e1f582941d@iweiny-mobl.notmuch>
 <6635b5e0e3954_1aefb294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6635b5e0e3954_1aefb294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV3PR11MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: e10b184f-0711-41ba-c0aa-08dc6d7f3099
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dO9SJ70tkGU7iMopaPco17UI3kbO8xF2j3Z1a+k/7lRjU8QPkYUuTQ4Vl1tF?=
 =?us-ascii?Q?NXTwmi5QibYm42vpqk8bJQzKlrERiT5+U1k1kSQf0OrngVgjE4huwK4RjKgd?=
 =?us-ascii?Q?Oo32dWDDdNG0JU5ttAynNxtADOQWgKZtWCV4F5ygMdV7Mm/UF6J1rEJo8OCx?=
 =?us-ascii?Q?QRISHirMLyTrGGSz9Glqr/hBZfwI9bSVRhvFFrqu/efPrIxS87j2Nrx22Z67?=
 =?us-ascii?Q?ONdKzmqmRznqkepkR22OGFBQ1I0Y2uO2ntNhCRLQe9PKPpk6udMCw9iuQhNP?=
 =?us-ascii?Q?gCuy69nwA1Hy/3lRiku5YCoTyCpc8vczaee3KjNQQTMFA9juilCQg/ZsfsIX?=
 =?us-ascii?Q?AujMNdAv+XgsvCQ5t6atzyOA/Ydm83d/5hA9cmQDo7ophBfAdDqPWEwZrN5o?=
 =?us-ascii?Q?+gygFpqgs0SnR9Egw4SsVlhorKezzRtlH11olva0E4CRipjY0SZJhebdPPvO?=
 =?us-ascii?Q?GCDnqRHXz8ALI2AgELB1m5tik7Yt2pQfjQErfig8hZwKtlFbcWcn0DU5npMK?=
 =?us-ascii?Q?xz2yjtNd7duoL62mnQgRMwbX21E48cfuKNoHBzDU88gJDVDvRj6fQtb81MtM?=
 =?us-ascii?Q?YWry2PLbMvbQAx3V95sPZDIyOHELLzTyVitiWBIVj+GaeQzyrFMGSo/Pr9O+?=
 =?us-ascii?Q?mKX2n8f1EXprJ1b1844OMz111tccNUJXV5p3yRVuRql+3i9psqU3XKoAU7XQ?=
 =?us-ascii?Q?62PrBSgG0wxkq/VkVUoADDf/chvthaZitlaX8+W/+EcsbI5AJKXx/oeiog0b?=
 =?us-ascii?Q?UkUJjJp+fZPivBEmSWx91wC0ry1/Q4FGUoPpyRnjmqc1iIfBCo94xgrQN7Bs?=
 =?us-ascii?Q?LTeITq+mV71ArLfxsSKF4AMESc/lfOkBAmMnNbAY/Xh35inXYU26ZllZwJf4?=
 =?us-ascii?Q?oRHEFoW6wCFz76Uv50v+TPjOKZD4ZBKDiDFbAlZxRNIROeTQhFOYpuFu8fck?=
 =?us-ascii?Q?qD9zoAhZRvjCVwcuRZ1IhVkH6NWLXaEl5q9psaWI1CrdNtyvJvnBWc/m85qC?=
 =?us-ascii?Q?7kaVZgkPuDPqPZPerkNp7nrTM/iTMgrAnxKMutvxmcy+xY5nw9lJRk0AT8MF?=
 =?us-ascii?Q?nTz1xiKuFKd2839BfOhsk1Am7G+VzjVfaMXHBC46mI9pKEVbURiz3tctzatA?=
 =?us-ascii?Q?PTaiTUZSH+CX5Mo6X0e2bOCWbh6PpmC6L2Hmn9XHBneHYf4ly8isdkvNRg1F?=
 =?us-ascii?Q?k8Sz6jEy9BnPgXJyC1ZQg1scVfUGC+GT5UZYGUjtIa4hK7ymk3fu/Kj7/rY+?=
 =?us-ascii?Q?fSMw00hYKErWasBlq5SsizrffCoRTw2W+b/0PgYPgw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yA689V/YDqENvTcziRg05HCoI1o7EQsJOam4f0gBMedfeeCrTrZ2t4WEy8W?=
 =?us-ascii?Q?rFJoR/ArJgLoGOIi8U2+bCnLx43vucQj+gb5cc4ENeLBy0qn1w3mZ9352o2n?=
 =?us-ascii?Q?6HUnhSVSQ3JR51fg2vm9z3NADsc7qsjVBIUSVs7FggH31OJslFWG4KMnGj4V?=
 =?us-ascii?Q?qLjGhvrOR5cmfcAWCrY56c8jCgaZgZPgipBIfa4ZzZZv364aU0dJYGwTEpx3?=
 =?us-ascii?Q?aBSvqSJdJ4rGnOtHUIpW0pCo7GCwOU5LREYjL5FHUMkwwFthgjvccn1ZNO+k?=
 =?us-ascii?Q?ap2GCcJnYR5SjOFQm+jJW7HCPacvWFk6zN1/36ND2SFhQhlerdLXCgYUkeqv?=
 =?us-ascii?Q?Vqw01y7pvXXQscauSjVrcEq12aERtE19HB6KiAX/w6CJ2WnwCDwRnMz0z6y6?=
 =?us-ascii?Q?jloqxEbR96cPalZoWsDbViUw5AtAuKJe5wlO7uPNG51aGt95I4isHcxuXxW1?=
 =?us-ascii?Q?/3ZY/cime5GdPwCvfknlejT3CGWPCyBbCAsIrnYMd8YuMOXCkirkas+3O/0z?=
 =?us-ascii?Q?xiiXZXhhwU78NFzl6zQrO3EhMyQZAJcEdpQ37ksLrONG5T3uXROY4+Wsdy8y?=
 =?us-ascii?Q?adZiX8D8M4swQpt5spkF0dymULaNpVEOAxZTRoU0tXXLd29O89FsDms00vhU?=
 =?us-ascii?Q?XNEZNyoL4+g+GnjxXBIAPJ+pgrKcQWF0A50d2+bqSuye2w7jL0vOI/dHk1mV?=
 =?us-ascii?Q?2e56OjCtDfI4b49D7hgRHGQmJdxfBn3PU6iJf48QMsIPg7ql8Xg7TfxtojiS?=
 =?us-ascii?Q?+Z12r+Eq23hh7of+t5PXYz8yxs8Ing7dA5gI9OgDNBCsdNqvK9LJfKRqFkon?=
 =?us-ascii?Q?5bhXqE4xm/6yAcF5xp3zpnIeKgfT9EhXLFfxZLghxHsiq0/idMxNm1pQx6px?=
 =?us-ascii?Q?S2hCSgIk4tCSbp1dZM55fZgiwY2bedBKoqMS3IXR113hPHo/JDIVbnjuFs61?=
 =?us-ascii?Q?5gfQlf6IEbtpYmjD2v/I2z9Nm2vxIDbhXEQkWi0JV6MaqYo4iBklNwzrjRYf?=
 =?us-ascii?Q?LO+6oTFyHOLR4qPEye3E+svMJefEKdNvMcxtvOaXZ+n7LJX74W6jSj1QhrK1?=
 =?us-ascii?Q?myLs2ke2UmUF0vkeTeKwdoVO7kccWF5N9gA7t/9lODzjsSXRhSsJ5cl6V89t?=
 =?us-ascii?Q?H+ykALazYSOl9gGxfgN9WjYoPXA3d88a0lmqK7JkZmJ6sd+2qvfFHk4wLxT1?=
 =?us-ascii?Q?G7O+SdPIrMHmc9nz6oG8bIGIfVKFukRqNMmztL4lNwrxDi1Dv+Vprjn34UFZ?=
 =?us-ascii?Q?NUwpHEOibZqoJge2V9KMhlfZYd4KYPwkGfXzTktvEQihcspvCqY7oaigvjTE?=
 =?us-ascii?Q?iPVcSZs3xrXa2SXRjUnCXS5QTVB3358m8p3XEQAUVgXLUNohITgbsbb/hPUy?=
 =?us-ascii?Q?LVil7JoEIh1S6yiVOMHTiJQfAWVq37X6/HDC9s2cMcXw1LJ1GMJIXF61JR0H?=
 =?us-ascii?Q?ehIX4ARv1m8crJN6M99Wely0VSu6EJ7IMcEtNfGm7oTLWpw7NXExNb4Vp/SC?=
 =?us-ascii?Q?YPSxMKeUDy4SCHkUou9ZcOi5YDEOpB985lA9bBegR5dq/ZQNQJGkWwp5iFBc?=
 =?us-ascii?Q?7GNhyWbkzRgWZRPE0SxXBxJHASyXosivjlLY0bbc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e10b184f-0711-41ba-c0aa-08dc6d7f3099
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:47:02.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5K/AAFsNWDFKYhTeQkWVCBGzGgG1lzPlG4gEy0FLwT1BWSHzBo73OgnZFCDH8g5dznLbTuNFFIqcx+SbMVVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8481
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Alison Schofield wrote:
> > > On Sun, Mar 24, 2024 at 04:18:08PM -0700, Ira Weiny wrote:
> > > > cxl_dpa_set_mode() checks the mode for validity two times, once outside
> > > > of the DPA RW semaphore and again within.
> > > 
> > > Not true.
> > 
> > Sorry for not being clear.  It does check the mode 2x but not for
> > validity.  I'll clarify.
> > 
> > > It only checks mode once before the lock. It checks for
> > > capacity after the lock. If it didn't check mode before the lock,
> > > then unsupported modes would fall through.
> > 
> > But we can check the mode 1 time and either check the size or fail.
> > 
> > > 
> > > > The function is not in a critical path.
> > > 
> > > Implying what here?  OK to check twice (even though it wasn't)
> > > or OK to expand scope of locking.
> > 
> > Implying that checking the mode outside the lock is not required.
> > 
> > > 
> > > > Prior to Dynamic Capacity the extra check was not much
> > > > of an issue.  The addition of DC modes increases the complexity of
> > > > the check.
> > > > 
> > > > Simplify the mode check before adding the more complex DC modes.
> > > > 
> > > 
> > > The addition of the DC mode check doesn't seem complex.
> > 
> > It is if you have to check it 2 times.
> > 
> > > 
> > > Pardon my picking at the words, but if you'd like to refactor the
> > > function, just say so. The final result is a bit more readable, but
> > > also adding the DC mode checks without refactoring would read fine
> > > also.
> > 
> > When I added the DC mode to this function without this refactoring it was
> > quite a bit more code and ugly IMO.  So this cleanup helped.  If I were
> > not adding the DC code there would be much less reason to change this
> > function.
> 
> Where did the "quite a bit more code" come from? A change that moves
> unnecessary code under a lock and is larger than just incrementally
> extending the status quo does not feel like a cleanup.

I'll drop the patch.

Ira

> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..0dc886bc22c6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -411,11 +411,12 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>         struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>         struct cxl_dev_state *cxlds = cxlmd->cxlds;
>         struct device *dev = &cxled->cxld.dev;
> -       int rc;
> +       int rc, dcd;
>  
>         switch (mode) {
>         case CXL_DECODER_RAM:
>         case CXL_DECODER_PMEM:
> +       case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
>                 break;
>         default:
>                 dev_dbg(dev, "unsupported mode: %d\n", mode);
> @@ -442,6 +443,11 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>                 rc = -ENXIO;
>                 goto out;
>         }
> +       dcd = dc_mode_to_region_index(mode);
> +       if (resource_size(&cxlds->dc_res[dcd]) == 0) {
> +               dev_dbg(dev, "no available dynamic capacity\n");
> +               goto out;
> +       }
>  
>         cxled->mode = mode;
>         rc = 0;



