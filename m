Return-Path: <linux-btrfs+bounces-7765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3D96942C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 08:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BAB1F23F25
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC761D61AE;
	Tue,  3 Sep 2024 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKQI0D0W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE11D54CB;
	Tue,  3 Sep 2024 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346273; cv=fail; b=Ys5emZGTkjb5FC+r6r61QZ9XKD4ziv/tp23JkM75UhdHaUMVoeNz0DoWJEF2X9DT/gApf15PMwsRFh2kuZzVvC1FAnINpcrJ56x87q1QpbG8IVRmeftQz9Ln9HNwe8NRZqK+DdZzZ7ts/G257HooOWrAU7cvyqL7Gj60qsxMxCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346273; c=relaxed/simple;
	bh=7UtkTfVvXRCyb2Mo0hVRdvs3OWkhdOyQX1yYl4qATkY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxq37m5VhE/3gp4j65zSBRxSnk2XZiR2T/NShPEMhK1tuvEE84GPJsWq8khWu9rjgQ5dWSW0mXs2DSPNw4Uzjof2o6s+ojr+PnBPJmmvP0aHxxQQL1HG7AZuNVujE5JuVB9xbK5J5IwXF2CZMPR+K2bA9KHi4eExdxU0oKae2Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKQI0D0W; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725346271; x=1756882271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7UtkTfVvXRCyb2Mo0hVRdvs3OWkhdOyQX1yYl4qATkY=;
  b=IKQI0D0W5Lvk7MNiss8jlJn89/gSd+Grr3DFUMRYG7GdV0ekw5/yOqvX
   PL2Nuze/x1BA872IV5vV2IcytnzxBuu0KuON7qt8OjfH2UR0aJf59mIKs
   m17AwPRLQ1ZMaRArq3Ge5nLHt1CsMjmS6VOQoG8njgWEoKFtlqXCbRAtT
   oxW9L+9sxCEfpqcgeFvZbfA+riij0ZZleR/1KreA9Qq/U8uid1/WuErVt
   SDKEmfrKhNOCjAI9p9fsKnbTePHJR8fMehhgwDpZDW4OVRJmFgozKD7ir
   ulOWtI4p9qC0LxEOXYZQ2RDANZLIeZGgB/FfJxdEd6WtQptfuC5Rs0yX2
   g==;
X-CSE-ConnectionGUID: lQy91G2SQ+2ZJsiigz854g==
X-CSE-MsgGUID: MAVIaB2NSv+w17eSq2y37w==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35316450"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="35316450"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:50:31 -0700
X-CSE-ConnectionGUID: ssL7YpOjThi1DJrm41uJzA==
X-CSE-MsgGUID: QD20E3jeTn2y83n8XVAB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="65533456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 23:50:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:50:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 23:50:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 23:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOuNv6XRvCPWa6FVngfml6K6rUp388JD0nPwmdt2xdIRh6yFuaTLJVUwxWJSDhMGciePYBkMKWNQqY07ilUCDvbXUy0BV2YlsMxvdvMFbuOH/VLHVZ6YR9Gm/gD2gbphHPofZ9/4Fhzzkcal7xOBEFTD85OGTacIyGKpa8TQ7QNwHQ1yQ6pcNzotBKDauAHbq77TMoBXaTFO9FI3ML9FK6yiNxYQbBlAo+vRHV711QhfkzIn2eAzUT0bRWn1HUeK+m0kO5y7q70uG7Ho8hfZ0URSKw3kabVfxbgMoHziVO+YpxvebYCQwuho1JWnuTtqy7Kv6cp7QadUeqCN/UEu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLWEmhmDPssVkJgHeMxtMLacGTDlzP84AOlkmxcmVo8=;
 b=HcYpMOFpmLAuvyltW+j//1EemAiTY8Dn4pPQXrP6CXk+Gjq01tsz+BHFnQDR6ldVWDqTXmpYFbbZ4G56NEiLQzOfX8LujarEictlYBKLX3F/IcSu0f6hxYP7V5hUu8hBaVrcknxHYbunwH4CMDoHqJSFg0j2AeP4XA1I+J+Af1XA+ZinANFBCwycd5H8heIn753/IB2/tDE4VLSCcAMfIIGKLFYYD+dyNXOXtGMdUiesCWYuI0uI9nAAX/NUxwvOGuPVIn92tHQom84iTHzR0LnsYq2ORhSoTYzZS4KVF0xB+bvXJVuf6fZ/ewi+MY6d6707LwC73aeN6pJqXre6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 06:50:28 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:50:28 +0000
Message-ID: <3e0f1feb-8fcd-4b7d-b8c2-2ca9549bf92f@intel.com>
Date: Tue, 3 Sep 2024 14:50:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/25] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-5-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-5-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MN6PR11MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: a85955f7-5b68-41fb-0696-08dccbe4b1f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDRtS251R25XV0xCcVBIMUtQMDMwUGZJRk9majRHWW9TNjIranB1QTRSOE9Q?=
 =?utf-8?B?ZHJRZm1hc3dhc3NKM1RtM1kvcGVWNmROWVBKNHpTMnoza1Rsd3BhM01OK1Za?=
 =?utf-8?B?V01oTFkvNGRVc3d4cm5Eb1BJeGZ6b0tnNXk4RFNuNk9ONFhudjQrWWJuQ3dt?=
 =?utf-8?B?NFhDUGtiSUtGeEpSQzk1UkJ3QUtQbjhJS01QQjd5T2EvUnlzMkU3d1ZqV21H?=
 =?utf-8?B?V0oxSm9TemJvbDVyei9lR3lHQStUbThSZFVNVnVuSnpyOGxMc1BvZU8rOGJQ?=
 =?utf-8?B?Q2tBa0t1OEZITHh3dVJ5Szhpa3c1TDN3YVF6dGNnTDVEd0psWkN5TG9ncmxH?=
 =?utf-8?B?QzZ5RVAraFlETzhselhpRmcyVEpRc1U2Z2V1TEhua1ZzRDVTMGh3bWk3SVlD?=
 =?utf-8?B?cVpqNHMrb0FvaXl6b0gySkNDUFM4ekRMY3BFTGpWSzRRWEQ0ZFRCNURKQTlU?=
 =?utf-8?B?Q0F4c0pDUGlpNU5xVm1UZXl1cXYwMEVSSityWkRpaitkMmN3TTAyNFVhbFNh?=
 =?utf-8?B?ZHNCcDVzY3laV2M2Ry9mUjVFd2haR2Y2SllqQnhGQzV0QnFNYXpEbk5lQjBT?=
 =?utf-8?B?dkdxV0hZUkN5VE5kbE5XOUNyczBjdjhFWHBFdmx5MU0zS3BVUEk2YnJDcnQw?=
 =?utf-8?B?aDVrbXROVWEyMms3eU43OUovWjBpaWc4RDZiS1ExVVJ0bkVyMTRXYXZGMHYr?=
 =?utf-8?B?dlVWWWF3bHJKMmhCU3IvTFY2UmRSZ2JBQ2E3MkR6R2dzVGhNcjdjUytRN1NV?=
 =?utf-8?B?SjJ5UXVtbG96MnVFWVNIdVN1ZkdZUUIxbGM3bnljSENRSzhob2hpaE5DYjNi?=
 =?utf-8?B?YXZOczNUNklmeHhFNnAyT3Z0N3J4ckI2V1F4VWRGclkyOFE2WU5GSytmNmdZ?=
 =?utf-8?B?TmY1c3NhSUJRS0JtNFBMK21XVHQxQXpuSldPY1o5UitxcFlLVm9mN3ppU1Rs?=
 =?utf-8?B?bUxFcnoxRURUVTI5aXdaclZlMHFCOGVBNG10bGY3Y1dGeHN2dFZ6MzRCRDVY?=
 =?utf-8?B?dmMydjBFQ3ZPalNza3IyVTViZ2Q5RFVTaFFDRThLRDQ2LzNLMUlKUW9FZnBO?=
 =?utf-8?B?UVI1ekgyYzFDRUh2SjkvK0xWaGpLcUI5STJhNysyeXZld0NmR3g1YzJLM0pI?=
 =?utf-8?B?RlUwOCtOUDY5enlaTGxydE1kZkNyRDZzU1pDODd4c1V2NExRTCtNUldPVG5W?=
 =?utf-8?B?M0oyZGRQT2hrWWVBR3hvSFdlSHg0dnVuRXVjR3Z2ZFM5bmtJVjJvY0svcE1u?=
 =?utf-8?B?ZjcrUVdESERBMWpSZ21zUGVSNVpleHJhVUMxaTNFSTRnZ1FVYjFQbGZOUHhZ?=
 =?utf-8?B?NHFFNnZxN25XTFc5R3dDQWdNVHArZmRHUnA3a3Q1dWpVcTdqSXFjN1BvQjRK?=
 =?utf-8?B?NmlFT2drQWxaVnBWUnJPbGJWSGgySUtpYmlEdHUxMmtzUmNldDZRMXVqZXZw?=
 =?utf-8?B?Y1U0WWpSZC9nc0psbDRmQ0tvQzRiRzZ6Qnk1VTIwemwzcHh5OXh6eldSUnJn?=
 =?utf-8?B?SC8xNTJwK3FwVUxlV2g0ZjVLVE11bk9DQVJRRzdxL0tRckxtNG9GcENPaXRp?=
 =?utf-8?B?UWNsSSt4R2xabENaZ3QwWm0xa1V3Vmt3a0pIcXJ5WWdlNDFVM3hwMDR2VDcw?=
 =?utf-8?B?Tk5Ua1ovT3pnajdRNCs5RFNBa2dlbzBwL1JQc0cxMnFONFc0SnpsbU1RWjFm?=
 =?utf-8?B?MDhwcEhoUjMyVkd0NFRUWDZXeGczTFUwWTJiY1VKRlZJWlBUYTRHanpmalY2?=
 =?utf-8?B?MzFhTjZvd3ZoSktJMHdXL0t2RHg3dXZLc0ROZEVacXRrNXA0anlMRVZmV0t5?=
 =?utf-8?B?R2tZenN6VHV0TUtEQk9TM2RvUXBhWXBIalhhMVJIVURnYlVNVDlPNmhacjJx?=
 =?utf-8?Q?nS91iMVGoZM8c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENYL09LZEJHTkhkeS9wejh6anQ2dmlKZ2ZEMGJjWFUwMFQ3ZTJDc2x6R21u?=
 =?utf-8?B?dnF6SWIrVDRMUmtwMUgrTHZkOC9BN3FYTkloT1JrTEVyeHJRcnhwdXpMeWFK?=
 =?utf-8?B?ek9PT3ZUbXJWRElLMEpjTTdrRGljdDFXWVhwRGhDMEpTK2pHQStaTUp0SE1L?=
 =?utf-8?B?eDUyWUUxUHEvZVVFeHJKeTNpYk54K21OUkdTMnk5dVhWdkVPRUFja21kb004?=
 =?utf-8?B?RXZSNGVUVzV5ODZGc2M4K253QkxBbnFHcjJDcnZEKzRXek5Ralhxc3lYK21Q?=
 =?utf-8?B?anpKTTFtU1k2REp2aVpkWkNSc0gxOFpzMm94UHdQajlDeGlUaHFHd2JvVVhL?=
 =?utf-8?B?OWNjeW9pQXZ6Q0xtY1E1OGZsRXBWUFcvQzY1bjFxZnJVY0hFUkthdklLeFFm?=
 =?utf-8?B?L2dTWEZ1ZjI0eHVMeld5azJqQURBUkF5d3RTQkxVWUo4V1o0YXd2VjJUMHNT?=
 =?utf-8?B?TEs5Q1Z6anBnS1NlVnpwTmRWNnl5dDY2Tm5ONWt3cHBiTUtGeDhrekNWZDZh?=
 =?utf-8?B?V0MzMThXZ1NOYWljOTZrcFU1eGRMT0h1S1dyZ0FsZUdmT1J0aWIvMXVDYWJG?=
 =?utf-8?B?Ny9YSXV4dXpMb0Y0Z0tDQW1kK2NhS1VxaS83dnZwSkpTZnBoRVJuSWNvZFBS?=
 =?utf-8?B?VjNjTEFheGFOMWNsRWloNUlEY1huc2MwRE93akpTeXZ2K3BaZm9uNU9ESXdt?=
 =?utf-8?B?ODlRTVdxZE5pVW9Rc3dkY0c2MGFWT2dZZ3VySDYyd0EwSEdoMlBPS2Z3VTZD?=
 =?utf-8?B?UWZTaCtvTENWRzlzclltbm05c2pTcWxvWVNGdElYd3ZOd3RlREdkZGZ4aWxt?=
 =?utf-8?B?bWNBOUY4c1ZvWm5XS3FheFg4UnBqQ3pZSi9Lek14VkZxTzY2Q2xyZms5cTN2?=
 =?utf-8?B?aU1SbE5BejJCOGpZb0MzY1JyUTQ5MkFxcmV1RWF2K1FCS1FSL3pEczVXUzk1?=
 =?utf-8?B?Q01yZ1VKUlp1S0tnUVpXM0R0V0QrTVZ1ZFVaanFKOEtDbFFOTXZHd2UyTmNR?=
 =?utf-8?B?UEhXNFhNSjFMSmdQSEx5cExtcDc4ZlhKdlh0ZDJ0T1M1dHVOeU9BZkNxbnhv?=
 =?utf-8?B?SmQrL0JRTWFZaW0xQ1RXQWJDWmJQOFhaUzdXWnYvU1R2a0JNUlFzdCtlakFL?=
 =?utf-8?B?QmxDbEdrbFA0bUNGQlNDTVRycVlISWZPY0JKMWtjWVM3ZDhoam14YzYxMGFm?=
 =?utf-8?B?VnN1b0RXcVRjaHpBcjlhVGFBQXRJUUlqeXppTG9ORGkvOENhUVVaeGNENC92?=
 =?utf-8?B?MzhTbWhoeW9JYW5WR3p4N1Bud1EybXJoa0lVSzJTTXIxREI1M0lXY01idjVw?=
 =?utf-8?B?cWNUNmVaOG90SEhKMUQ3cUNDUjg1cU55aUI2VXJFb2pVK09ld0JKVk9FL2pJ?=
 =?utf-8?B?MVJPM3c0OFBPakZFcnJ0OUIzZDlUdXpzNnZ2S0ZkY1BBa2hlWFcydkJnOG9w?=
 =?utf-8?B?dTZodjdqaWZIb2phbFd6ckk1cXpNL0VpSmxDZDZaeFFaWXBCTXZjb0dFeHZ4?=
 =?utf-8?B?Qm9QOUtLT2hKRUs0aWRva3NoOUIrekFZSm9GNlRqR3dGVUxLUnVZdDYwLzZ4?=
 =?utf-8?B?MFNZMXpnQ3pVdHRDdVlqMGU5WFM4MVhzcnpKU3pRVk1jdzcxcTUzYUdMeE1F?=
 =?utf-8?B?dkdxam5FdVhpa3BNeTAxRGZZeCs5NWdMTDZIVHhnVFlWM1dSSUprN1UvMEZz?=
 =?utf-8?B?NTJGcmZPL1RmdTZXNXVRVmswSGphd0xpclFzeGV5a2RmUERBNXhkK0d2TmFB?=
 =?utf-8?B?SmVYdUpJcG9DQ3VwNXBJNUIrYTIxVDM0bUV4bFF2M1FIcUZLSlZtTklVc2gw?=
 =?utf-8?B?Nml1ZUp5STZoell3VHhjMFRGUFpRbUlUcjV2ZmhoaC94NWRGN0lUL3NKcDIy?=
 =?utf-8?B?YTFERmhIOTVVVENKVkZ0azBKSWR2NXU4VWNVS0FsMFhqWHZFVFZSdk9kZXZS?=
 =?utf-8?B?UU5UMG1zblEwdEpldXpRM3lQK01iT0RMTEVaM3ppZ2tGRUN3NWlMRDNzM0Fz?=
 =?utf-8?B?TnJSN1BYb3ZhZityMTRRVlpJRC8wOTZWc21nQ0I0YTludzdLTTJuSFo3OFBt?=
 =?utf-8?B?MW40bWc5NzUxWE1vb09TSlNoczd5WnMrei9FaTZEMDlncjNqR1VjcC84N1VM?=
 =?utf-8?Q?T9jeuwPn8M4PxSS+KOnf3o5M+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a85955f7-5b68-41fb-0696-08dccbe4b1f2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:50:28.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKwQ3ogLxDSsU4X/+IrfMxDtY8CNB61Q19VftFQ4AX8q8uY99x5cxKC/aWZL+Gh3CCJuvfl0nJ7pHecHG8iA0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
>
> Per the CXL 3.1 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
>
> Detect support for the DCD commands while reading the CEL, including:
>
> 	Get DC Config
> 	Get DC Extent List
> 	Add DC Response
> 	Release DC
>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
Reviewed-by: Li Ming <ming4.li@intel.com>


