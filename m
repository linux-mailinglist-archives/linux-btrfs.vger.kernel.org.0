Return-Path: <linux-btrfs+bounces-7770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF099694B3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5AF1F240F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECF1D61BD;
	Tue,  3 Sep 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnU503QN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6941A3AAA;
	Tue,  3 Sep 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347263; cv=fail; b=eX71Hiqb/Oa2uE/FRUkFw/lK1uxl6jEqwrpurXNsnqxWzwQaDB6NEdxNyAVa/8O6wRWLzldmFuIekCIsN3wOCIaStC4l6zLupEV35GEfA7EN3dDA34bR19cqeVLz07MUNs+ZqwjEgWldO69GICJxYDOfWnkOZEVAfWO5jAQKjew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347263; c=relaxed/simple;
	bh=lTII4SjDKF5a74Dy/svVWH83pu0AzU8s6mOBsVypd7k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JX577kRMYYS8jBzaTNI65gz/Fyu6BrzwopZMGsCx/UZwWkNF4ZGjgJgPAVY6r0XTEwbsfjwYSlBE+7LF7BCBNYcCeCWhdS3NJDZjOnNoc0iur41InkWy951LA8EjbMARUmjbGod3a6RUYX49y/ooP53s9B8q9bsQiShO+gkK00I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnU503QN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725347262; x=1756883262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lTII4SjDKF5a74Dy/svVWH83pu0AzU8s6mOBsVypd7k=;
  b=HnU503QNNfJ2sP38mgTlTdZtLSHeI3i6UFI8gmMuxwCtp1zEPdAmXaJK
   wF/v8mVXp+VPqHeHzOiOd7LMjR1pKzhqBHfoj2TNy54KKyI50Mjvye4AS
   umvLKjE0a4ylplsMcqUhLlJlj957Yty3//x8y+ZQxe3t9xTAueMjIPgb2
   U/lAGsjVsHQOXhnPRD5fF8esTVHQcW087VI0T1gAz/f0FLCKSvaJM9BI4
   kNNpATSODfB631Fgs8HW1PMMdyVHZcKCqC/LRd5WHbe2Q7DYiVsOfI0hs
   n7niSIzthX9E9SDpnFSQLjVj1TRU44+G1EqBvcsIt8Anlux0TqMrLggxa
   Q==;
X-CSE-ConnectionGUID: 7AyOBE/hQo+Ux3BHxGnmNA==
X-CSE-MsgGUID: qnVkvXoUTxaxAoi9lPdZxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24043156"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="24043156"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 00:07:39 -0700
X-CSE-ConnectionGUID: JW5AqpXZQVGmHiK2bbjRYQ==
X-CSE-MsgGUID: zDxAs54ISKWvtqXQsF2LFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="69176752"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 00:07:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 00:07:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 00:07:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 00:07:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 00:07:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYBDWZUzM+8w8uUNGHcFfyCoUVnncigtZTl+beZXqhDD1L8o5kGi7ALUAITFNimqakrfOHbRd7IrZWVaQPq+CcsRLhiuF1ssP++36wEiejzV88U5DK9ljJAR92zfCMgogsndxtKZ+BnE8yY2ZpjFODJvJYvxl/L3XKf90Tj5CS//cf/EXqfzok4HUtsR0k4T2LFFREJfwdQ3BZQ4gO8F5nhu8YwalPYdDzsYmPoGEhTh9MkTe3QkWsSWxc90+uLOpTorxH3F86DGvmGp0S0r1DwhUB7Pn2vSUPeMQvN26hk3XG+BTm491tvyFk6i7ft0wPwigKODbuFU3K2ptG/f9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQyjs1ObTQ4uOapaOW+aPROpAX2rGsh6N38wLU6JsOI=;
 b=mwV1UBnrlKYdafYoo7aUODrpbqYDz6I4C/7IQ7lRTY5eJnYOAhDfjW1M3IlAzNH/qbVqIdl4M+jyshBAd99JpxqvAbQ5Cwe0gMYtcQPcXzsGbFBID5doLnqfRowrd3m47doKq9rTovDJjVAyjg3b+6NBfoYDqOHE0aGc8vEsLqStzoa239ei1L3wb3OUAmNyEXOv6MjOjxbLMuHG4WFm5VBuv8vQfRmzZ4O6sjfT43hlerrE6+rpZaeBP1iWMpFrdWk06wR7FqEZK7M7N5DGP8c50cyYi78gJ3VXGYXzUKCyCiUlPDoq7uOj5iPaBNS9eJh7D0mkBsGm+Fb8M4raqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:07:35 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:07:35 +0000
Message-ID: <cfff3976-b39f-4dd9-b74e-695f91cb79c2@intel.com>
Date: Tue, 3 Sep 2024 15:07:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/25] cxl/pci: Factor out interrupt policy check
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, "Josef Bacik"
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
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
 <20240816-dcd-type2-upstream-v3-15-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-15-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 786e05fd-df7b-47e0-26e7-08dccbe7164a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SisyZjRwRGVMb0VZMnpsVERKN1lyeUE0aEd3Nmxsb2lVeGxwNmhHUCtuSlhB?=
 =?utf-8?B?YVdvUDV4dC9xbHZnVDFwRmtyTkJLSkRxbWNRQmtlejN6dDRRekJGZ2xod0c1?=
 =?utf-8?B?WmdDbUdzOTRsejBtZlJESWZ6eEFicFJXZ0dRd3oxUC85V0dnaHg2cy94eFJR?=
 =?utf-8?B?b1I4Q3dRdkJjZVZrb1VreUtLbGZBRlI1REp1NnV4aVhtT1AwdERJVlNhNVRP?=
 =?utf-8?B?WnBSMmpvY0I1QXRhbTNjYlkwdjhiK0M2R2NVV2Vlb055T0p6MkZmUTJHNXJ2?=
 =?utf-8?B?ZmExeHZBeE5uZkVMdkNlTHdtVjdlckdNR0lBQnZaQU54c1l5TCtqSFVoRVNa?=
 =?utf-8?B?VEk1Y24vaEx1RVE5Y3hPSzZ0VWRFN0xsVTlSN3NXY3phMUZxeEtFS0VCdVZv?=
 =?utf-8?B?TXF0VFNqbDF0cFp2cjZhQzlNblBPdk0waW5KUkFuUmRjWWpzMkVTbDVDTGNT?=
 =?utf-8?B?U3RpcW9oYjUybEZtWkVRc1FxZVgxNGYxWkk3QXZxS3FMZTQ2ZGlLZGxGeHph?=
 =?utf-8?B?bkMwcXJCLzdvNVgxOFp1R09MMGxhaUFVMjd2UE9OOVk3OG1taFdESFc2WGlZ?=
 =?utf-8?B?NXBSNmRVL05CMmthYnIzR0czR0FRb3hZd0ZVWHZRWHNuVlZuKytNRG9rT1JD?=
 =?utf-8?B?NExhQkFrQWtSczk5NDZGeDRLOHBtdnErdkZkQzNtL1hHRnV3eHdWMkVOZjRT?=
 =?utf-8?B?aXhnMFNKZC9aenV2TURPUEptckVwSkdsM29NM2FydzFyQWJmYnhEbGhZMm1D?=
 =?utf-8?B?Ukgra25KL0Z4L2dKL3pwaElZcG04bXVoZTNPL2pSL29VbGFhaEVxNmVOYTh2?=
 =?utf-8?B?S2Q0NGMzYUhHM0RKVW81b05SN2NUbDlWQU1sSXJOaVE4bFVEendwREhUTmVm?=
 =?utf-8?B?NTQyakNLenEraS94OC9WVS9OU1k5SlBlTm0wdnFJN0NjR2psc0pnQVh5cUVo?=
 =?utf-8?B?aTdnb01Tb0JubHVnUU5FRzRWRG8ySFZVRlVOUHMrZkVQdXBSbHBmYkpFSTRw?=
 =?utf-8?B?NzBuY2R3SUc3dm12aGFxM0ZwTUYwM2dURFBRbzJHS0VZUHRnSnN0TitDWnRv?=
 =?utf-8?B?UUdyTWhMNEJzVHV0R21JOFdkL2p6NDFFb1IxaWhMTDV2S2VtazFmZjZHb21N?=
 =?utf-8?B?YTZlWkJhL0FBd0RlT3ZDWHQ5RmtyWVc0MVVtM3VSL2NhdXIvSVgvUXMweUYy?=
 =?utf-8?B?NEVoODN1V0xlYXpSaklFQ2xERkk4WkRCQ0hPL3VxOVp3OXRBMjhDZFBYREll?=
 =?utf-8?B?ZmhQNDhidkZNQlFtNnFnVDdaa0FNVU5TcVZDTE9VMlhlOERFV2d6SUFvN1o1?=
 =?utf-8?B?Qis1SEkvZXEvdlZweWw2bC8vZnZKSVU3VS9Hb0VEY2FFRDkyREJhd2RNcTFP?=
 =?utf-8?B?MkJJOUZubUVNN3VZMTRUNHZ2RlBtYTVKZmFiWUpmWGo4ZEx6Tk1xbnU0ODhX?=
 =?utf-8?B?Rml4WUZLR2NZRXdmeHpCVnQvMVI2RWtzbGhUbEhNWjlNZWNpeklKRHo3a3I2?=
 =?utf-8?B?L3B3ano2eE9rZmg5SklGOVdrbS9NcWlacjYvdTBaLzFiRExzcFdxUnpWZmVs?=
 =?utf-8?B?a0E0TGo2R2F2aFp1VzBsNDQ1UUgrSWwzMStRQ1ZKa0dGS1lEK0VXL2p0bUtM?=
 =?utf-8?B?UmpWRC96Q3ZmUHJQaEZSWWhoaldTYzJ0KzZhU3dNUlFVNG12MGtTM0dQSEVC?=
 =?utf-8?B?MzluaFNJMXU3azE5UHhpbkFqTG5FK1hkbWt5N21leTJNdHBlcGxteVpPcEI4?=
 =?utf-8?B?ckNIUDllVTBwbTlkQ0V0Y2dNMzRHNkkwNEsycWs3SHlwTkRWTzV2WjJBdzUy?=
 =?utf-8?B?N3NSTTIyWERsNlJUTjM1enVyQU16eXUwMkhrQjNYcU1lQmJMTStEbWlMdThu?=
 =?utf-8?Q?dbmUQL0FMW6DI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFiT0kvMUJ0L3dMME1HMWM5SVpzcjg5ZTBnVHkwQUtEazZnbUxUOUdPMFZL?=
 =?utf-8?B?WFBlcUovUEZ4QksyeXo2M3BqcXRETmhsbnBTUDNsTWlaNWZNdFIrT0xWZ1F6?=
 =?utf-8?B?SXYrUXplOU42ZkxXNTNOWUFoQlA2cENKZStoY3JSRWNqVzc2bnE4MWhBVEk5?=
 =?utf-8?B?cUg3QjF6WHhHK3JrUjVYbGVwM3NLaE1PUXdIOUlUeS8zNmQyem1sNlNKYUds?=
 =?utf-8?B?LzZJT2hrYkFRYXdlWXNnKzJ6dEJ5a0IwaWdqcy84NlFpK1owdDY4NEJCbFor?=
 =?utf-8?B?THYrcUdkcFFheDF0c2RtSnBtWUZNNVlGNWZob2sxcGJZUlh6NXoyOGErb3ov?=
 =?utf-8?B?ZFRIMC8xVHluSGdYRkJjSktEd3lXYUNmZ0xXZkxWZDkxa3lTbGJMbi9zRndX?=
 =?utf-8?B?eEdROVZKL1RRQWgzaW1HUk54emtIVlJBMEdRempLTVU1UWdlQk1vbmVvNG1Y?=
 =?utf-8?B?SVRPZjRrU3FIZkV5NkFhU1hPc3FCVW83b3hyb3NMTlZSZzQrSUdPZEF6ZlEz?=
 =?utf-8?B?T3Z6UmtEMGxjSW5DSDIvY1hoM3FJWVJnSWxXZXRGVllPdHkreVpUYjBoNi82?=
 =?utf-8?B?djZ2OG5xRjdkM3pncTBwamVYWXF0Zm9sKzFGTEVjd0NkWjdhU3hiVjZnelpQ?=
 =?utf-8?B?MURYMktjSFUwb1kzdTAxb1U3Y2ZiZklpWFhxUFloNmdJMU5UTXpZdjRVbVdP?=
 =?utf-8?B?K3Q5TndIVWZOM3dmYXptU1RndGVZR2RoRUl3UVBWWmRLck1hc3NjYWYrelFq?=
 =?utf-8?B?b0g4clh1TUZKVnhaei9EMFIxdW53T2U3MXVmNzF0RHRFMU00L0VzWU4vMTdR?=
 =?utf-8?B?UXRmUTR5KzFQWWN4OE5tY1VyTFlxZUQvK0NhU24xb2xNUUM0cHV3cDVDYkRq?=
 =?utf-8?B?VTI3QUlMeVkzQW52TlV5UjhPd0pRdG1VRGJiRmZzTWQ5R0MyQm1sZmlwMDZ2?=
 =?utf-8?B?MnhBdVJ0U296SncwRzhYN0ZacE5KT2V5aGZOQ0NMdE9TUTE3SmtxZFdZVlRT?=
 =?utf-8?B?VU1YbWxUNk95YnlxSEk2WDlCR0FpbHB2cDJZdFJZRWd2S2pZQlBNSWlwVE5O?=
 =?utf-8?B?djh4c1U5UnVZdzR4a2ZkbUtmLzRaSHQrbWVHVUs2ZHMvUmtiWVRWSHppZGpP?=
 =?utf-8?B?S3Y4TWM0YVVza01SK0wxSWpDSGZGS2U5d1lQUGVxckZIanBSa01tc2Q5Q0ZE?=
 =?utf-8?B?em5JMTBCaEVQcWZ5QkJ5M0QveFRvTjRVbjVkZ2N0elg0Q2F0SmVqNUdmQ1pk?=
 =?utf-8?B?RW5jeEpsdkw5N0JTbXpzL2FqQXBWYXdLUUt2cGJMazhRMzArRGd6aHM4Smds?=
 =?utf-8?B?UWtGS0luWmgwenpTaFhyRzcyMldCalg3enJrRXNnOWpvNjZ0OW4wWFpTSkwy?=
 =?utf-8?B?RW9XUVZmZVc3VUpFUWp2cStpUGlEV284ZXcva0VyTWdTZ0s5RCtSWXRnY3hp?=
 =?utf-8?B?ZnczeVk1VU0xODVNNGNEeHVoZ0RtUzkxOTZraFJuaDZNRzlYUDNWVk9kVG1B?=
 =?utf-8?B?akI0WkFNanpTcmtEYy9lbXBjZmJEQkErNkRGZWJ5ZitZRTFiYWprUVliMisy?=
 =?utf-8?B?UDQzMmNreEticW16b09ZMGNuenNpZWkyY2ErQ29SMC9HTmNnMDJOVXdIbXJi?=
 =?utf-8?B?bzFsYUZlUjFWdDZoMEgzaTlXK0hwT2FpK0FNdDBrYTJaSUh1c2xjRlZsRE84?=
 =?utf-8?B?WGsrZlpRU3p5czd5NUVVYXdVWjJzZjBPdGlwdGdCY0ZvaVg2ZW9Sc0UrUlk0?=
 =?utf-8?B?N1k1L29QQUYwU1VtWDFmdDNIeWdrdU5RTmVYWTRXem1OallJaCtVcHl3ZDJG?=
 =?utf-8?B?TVZsZGw2ODAxbVpqOXMxTkNtR29vbnRqSlVJckUycWkrVW9vYS9CbGpRV2sx?=
 =?utf-8?B?MHhtMDNYT2Y3akprOXAyc1duYXBhQmliYzVQL0x6YmEycWcwdHNqcDZ1d3I4?=
 =?utf-8?B?aWhTQ1QyYnc1ZmNuN1RpMzg4K2xHMFgxNm51OVRub0JLMTdZOVdiRi9SNkpJ?=
 =?utf-8?B?UTdndVM0MThHTnM1VkNnQXRJajJPU0FHLzVKRkV1REJZTTcxWTlUNDRzV3Vy?=
 =?utf-8?B?QWJYSzY2aktxeWNMclE2ZUVCbENRa1dEUTRUdFVsYXoxbHVMOUx4dVFGMzd6?=
 =?utf-8?Q?KJ/uaK3lq293PwNxBqwVoPaW6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 786e05fd-df7b-47e0-26e7-08dccbe7164a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:07:35.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kg15DZgVggqLLL6djSC/AcXta1/BUdkn/9x7Thp/D2LIfGK6riLtvbyWZtq7O1ryfEq3bqR/xBmMM3rQPRqbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, Ira Weiny wrote:
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
>
> Factor out event interrupt setting validation.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
Reviewed-by: Li Ming <ming4.li@intel.com>

