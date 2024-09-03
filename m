Return-Path: <linux-btrfs+bounces-7758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55945969158
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 04:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E40F282935
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03E1CDA0A;
	Tue,  3 Sep 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC/uO+vu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA11A4E8D;
	Tue,  3 Sep 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329733; cv=fail; b=KXFBlxZC7gGXgd6O0gLo4LxvbScXzCG0JvERq7SYFqgkyyJ/LSbX8EgtxINlrMLrxqsbtT3tFqW4AQ/+gLFlfcr9MjlCJLLppiEp4U7Fe505fIti7uwtWBQ2K1Tt3uo92vqPs2b4kkqnUM5KNNXhBkL8X8Mk2v3UWdTewEC+JfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329733; c=relaxed/simple;
	bh=WHFonrVEBRkZMyTC1JaxIcHE5SB62rOYYodiujp+Sj8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWqDv9L7S0RrsMU4xZ6NrzeKw7zr4giW0HMLT9cq0womRMW5Yuw4/UCZuHWmmHTYi7Idlld0VeU8tVHifEywWMR7Vln8uVqjvGV2J2nPHW8Krnipk3Q+4L2nviK/NRfgZG+5Z/5oQGXxgGX8Pvo161tZxdpF91fTXOPee3nwZro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC/uO+vu; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725329730; x=1756865730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WHFonrVEBRkZMyTC1JaxIcHE5SB62rOYYodiujp+Sj8=;
  b=DC/uO+vuvT8vH5/89jmy7XmxsZ+ycZXdhtZ4u4hO44nW/QUzNUSwcNhB
   JnvAL9JvO4d417IRJtFhYeI6Mrdc+Mb3GlcF8TXr7tjgQRc/JHj9ycccN
   xss17EEvdl1W/8x4zUhhHIxxdVLet4HSLT/7XMlUyrY8qG8r9grmIxnnn
   bRTeFdxSNHkwuvClzRmzM34J00I9hWb//u2wqZ2hTOqi6Cgp4INyfumi5
   QWzeAJgs9AoEg9kAVS19vautEsH752ciFx/zjayCWMPg+c+N8mpYAjpj0
   OoMYyoZ2HKSWXAj6PGymLs5QLUrpKKhz3aXNy06iAS+3msHU/5A2nwMST
   A==;
X-CSE-ConnectionGUID: vP6xZMWHQSyqkRTDHbjFSw==
X-CSE-MsgGUID: Kcs65PGuTVmemHhzRKADog==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24024120"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="24024120"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 19:15:29 -0700
X-CSE-ConnectionGUID: SvS4Ja7OSROUiamrT+mUEA==
X-CSE-MsgGUID: t/8M+JkjSzWiA1Je7+i30w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="69388079"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 19:15:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 19:15:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 19:15:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 19:15:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 19:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g92VVpNoVzWG82i8TyRpZFRKqmqMZa0g+C4e+XFntv7LpisGAiTkT7e9Q9hoDZfOudl3QMGD7ZFmLcalRDzUAIKqMUJa1CH0dpQrLfrVEF28nizbuLLGDCP2ZHjUhWha/ggbi8DboAOI1T8bjzDtQRFlODUwPGY9oFH5Tnf5H34tM8kFEuoeSorXeKaT2+hzPuNpVJG7HAQGUl7SmKPOwJe2neuJDwz/ONOFnmBGXSwYqiO8FVooBR2ONxCrSKJZsACbwoHwf9dg2pwHAjqA5hgx9mFjcVHiybYkkIK6myzrdcJYha8UVyfJKE6kuPx4nvHmUzojZU7wWBnSYRltiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUei7IU36J5ehQ+1fKTFQ58ea0EVxM5UQLt0CF4GCxE=;
 b=sGuRJ6JflweQWUS298rJh+MnrpPWvhqEBTy/DGTXaJOPaXQ2sAMLFS5FcFeeg8BeH8yQU4S8p3FV4aWTwDqj+eCR4hmBI/coh6I3iCYc4v04WjqGHBYEnEszyHlHmhacD3pj3H6QpTPkXeM1TQJe34w/Lzk2PnWCBho05cOF0AghvwWXX1IYmUanIc7sd5eRvHnNAW5iOw8j62k9AWINHDzgWV0TAsD0h7j7zrfLa4RMQ+69tg2SGZXhCsg72CsZ1gRBMUcR1M2iZSUUn1bFdmu3jHIZVbHXSEtHNxiJiUZEPaiFrWNogKzzdqA46fpToRHTCcNKVGKzuG+zWEhPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by IA0PR11MB7356.namprd11.prod.outlook.com (2603:10b6:208:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 02:15:25 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 02:15:24 +0000
Message-ID: <0999d7fb-8b8a-4888-9187-19b50a8bfbf7@intel.com>
Date: Tue, 3 Sep 2024 10:15:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/25] cxl/region: Add sparse DAX region support
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
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
 <20240816-dcd-type2-upstream-v3-13-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-13-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|IA0PR11MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 780321b3-e863-423f-6db6-08dccbbe4532
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFdHVzlQakNEU2J4aTZGYXdodWZtRGxQUXdJb0U2ek8yMzZTVGlqa2NTYzlP?=
 =?utf-8?B?WCs0ZFdGcDNoUGNVWlkxOUg3dFcxL2hSZHN6SG83THd3R0NNcXNKai9wY0Zs?=
 =?utf-8?B?aExXV1FtajdGMW9hL1ZGS2NBcVpTdHFuS0ZjVTBiTWpNaGdHbzM3SStPMGFT?=
 =?utf-8?B?Sk1FdEgzQ1ZveXJkY2tUampGcHBQWi80UENHOWFrNndKSkpLZTFLQnkxbURj?=
 =?utf-8?B?R01jS1JyYzBTS2xoRWVnMWxZZkQyaktqcHBMdGVVQTUxbk85OEN2Y29hamVs?=
 =?utf-8?B?UWJ5Kzlib1pxQVRFdURzaFdyWmNycUZUYzNOWUNXOUkxTi8xdTFNTGpNdHgy?=
 =?utf-8?B?eWMxU2RUV0NsMTFjRHVSbnp5eXlveXpHZnpUb2dnQ1JrWkh4Tkh5dTQwMEtB?=
 =?utf-8?B?TTNlU3JoMkxnQkFBeVM1Y1hCL3JjOWZwT1Rlck52cFFSWXMwbVB2Q3M2R1FK?=
 =?utf-8?B?TkRIVm1KeTlkZXQ4VmtyRk13SHE4L2pwUWtNb1A5dzg0RWRGMnN4YXJ2UVJI?=
 =?utf-8?B?ek9NVEx3cFdibGVvMGd4UzF6UUtxQUlCbmdFWTlNOWIybmRCNXBTYzZUUjZ6?=
 =?utf-8?B?SWRGaFkrZWlHblRySVRwbHZMNVIrV0RRM1BaMjBWTWxDM3J4L1dMVG9XUFJo?=
 =?utf-8?B?MHd6RXBrUG1xU2pmVU02VDZZSjBmVmhrdVZSYng0WHZWOXFPbFczZnZDOWxH?=
 =?utf-8?B?SjV1Zkl5eXFyS3BJQ215NWdyN2tQYndhZTlTMUFXeUZRRlEwZTFmaTU4YnJJ?=
 =?utf-8?B?WVVxTXBoVkVNMkkrdFNoUXBONWhtRXVSYm1sOUdrbmszellxVmxrNWl0bW1T?=
 =?utf-8?B?MjVYQytRb2hWRmYxemFGZHdVc29HUHZabWs2UTNwbS9OSUNlU1FMV2pCU0VF?=
 =?utf-8?B?dmQzMmhRZ1RRcHd2VGtMUEhwaUtudk02REhvaHNtK0huZTRuQ1o4WVB0U05G?=
 =?utf-8?B?L3VGK0kwMDYzSmlSa09hTXV4MTB1LzlsRUVzRjk0U3h4dHNYUzN5SVp5YVk5?=
 =?utf-8?B?QWlmMmhFUWJlREczSUxPcXpNWENzQWJiTjNxMFEyT2kxRk5rV2czTUpMczJh?=
 =?utf-8?B?VFJSTCtuUmk1OFJ4UDJEWkpTSFdqQ1VtRHF6eDAvaDgyMWtvNlJwdGhpejlT?=
 =?utf-8?B?OEQzOFZVM2dZQmtVb2c4alJjVCtNZWlLWlIrc0NNejgwbndlZXJSU29vLzZY?=
 =?utf-8?B?Qm15UnVibUZGYUgyVGlnSVZYWlNlYVBDaTgwNHRPS3JJOFIvWW5nZUZRUTN4?=
 =?utf-8?B?UEVKaUtHMjNZbGozZmdvb1dscG85RzFlLytSeVZ1WnplRWZNTEhEMVVFWjlO?=
 =?utf-8?B?cVdaUkxXSTYrTk91aEl4UFNGM3R1TVR5bE42R0JaN3hkeEZDbkNmTEoxN050?=
 =?utf-8?B?VlUzTUc4RW1Fc1cwdHprQTM5a29LRm5IN0hmOFc5ZlZSRzJMSTVSaTVJZEtO?=
 =?utf-8?B?ai9QUkRwaW5qNTR2ZkxaaDQxQ1pWekhEUThiYmF0cmdTZmlHd0tzM3dYTGZ0?=
 =?utf-8?B?dENtRmZuSnRac3RCdEFMc2dPTmlPR001dkNWNTIxOW5oMktOaG45MW5EU3JM?=
 =?utf-8?B?a0EwM1VJdEFWNnA5YnBTZlRIbEd0S1gzRWE2M01COVE1M09waUF4Z0tkeGdw?=
 =?utf-8?B?aUVyckVjbjBPbEVnNWFOaGwyNHFlcmVCeFUxQUhUZzIwQ1BCTFBJdUZnSkpj?=
 =?utf-8?B?WGNjRmZrcXdUUUkzTkJ1MjlHOUpoQjZDUVJVd2ZZTVlqZUh0Y0V6MVBPN3Bm?=
 =?utf-8?B?RGZCb1ZRdkh0RExsZWF1NWd6dWIrZ0JhT0J6UXBwTUVwditpU0dyeFFjckpa?=
 =?utf-8?B?TlRTUjZiUC8rcXpMemJMaWtYM1g5bmZGZUo2a1BYbVVRUmk3VG1rdm9qd1Jw?=
 =?utf-8?Q?VS5jJCs8cpETZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUltWWFWYms0OG1wcGdoQm1vb2VLUVJMeTBBbHpTdFpVVy9EZnVUSEJ5QkVu?=
 =?utf-8?B?M1VyajFYNkRQMEhPOXd6K3pSWTl1eXRTOEJQOEhGOTZrN0xKSGoyckhBK0NQ?=
 =?utf-8?B?c0xVSmdSR3BGNUxtSm5SY2NRbGsvKzM4Q2x5OWZjekhKaUM2TkNGYW5HeGRh?=
 =?utf-8?B?WTFGaEtkN0hNRXFXaXRaNnU3aUNmdnFKNVQwa21IdjlNQllNNVN6Tnp3Q2la?=
 =?utf-8?B?OFVjbHZWdHdXWTM4Q3BtMWR4dkNLY2ZKZ3FCUndUU0h5VHBlSVk2ZmhVd0p3?=
 =?utf-8?B?UVhuTFNiUk5RVmxhMVRaSVhDaVJEMG01KzIvNXFGeGpjemhVeTMvcVFoQzNo?=
 =?utf-8?B?dUI1ckRDbnVCZ3VBbVdFRDdrM0ZJYS8ycGR1bE9JRTV4cG0vV0ZHVjNxN2hZ?=
 =?utf-8?B?a0JZNnJ3RDlZRks1d2J6alV1dU9qeFMrTGhRbk5LYVFYQWtXeTZOa29yNDZ6?=
 =?utf-8?B?WEI4QjMvcEdSb2o4WVRXeC92OW9MU0FuVFlrYVV2RE9KRE80VGhraWdZNm9x?=
 =?utf-8?B?cEV0WGswOTRLRjhyQ2JnVk82SUdMbm1vUGJ6WGlVcTJBUjUxczc5TFFTOWVK?=
 =?utf-8?B?V1p5U2NkUk9FSE1YRU5ISy9HRzBjMnhSNUppVFY5NDVrVS9oS3NpdzA2cEk5?=
 =?utf-8?B?bitOM1R5dU10a1d0V2lHejl2TkNSQ2lUdnplOWpvTEN0VlBCamJrWFFZQzhY?=
 =?utf-8?B?U3h4K2g1WlRCVGdPN2hJMmlpa0E0STRFSTU2MjdhdVJ5cVM2c3RXWCsyS0dH?=
 =?utf-8?B?V0E1Q2JyVWJKalJoTU1HVDRnUzBrb3g3Z2FHdmNUekJ5YnllWXZkOVVSMjk0?=
 =?utf-8?B?UXFlSktpMVJjeXc3bFV3NllPUEs5Z0JzZnlVZTdFZXMzSTlkZUE0eFBjMmY5?=
 =?utf-8?B?blYwSmZlOCtST2JyWHd3TEZpd2ZvakJzOFJSSE9RMlpvUlZrc3p5dHBESlov?=
 =?utf-8?B?ZEVjUURVOEhiakw3V2xMR1R4SDFaZFVNeEd5TGdyc2MycVB6ekdybkhRaU1G?=
 =?utf-8?B?aEFKS3hPaVpNdWxuV3ErMHNUUU9hbXJvWUJmdlJURDBSYlZEVVptSGttWUNL?=
 =?utf-8?B?VGZ6NlppcUJiUGd4VlFLYi9EZHBnUkd5UWJoaWJIbWJLRVRELzJsbCtHeTlZ?=
 =?utf-8?B?Nmg0d3RUenR1UzY4WkNMS0ZQU0JYRUFsNWRzWmVMRDdNNzYydTRjRml0RFlL?=
 =?utf-8?B?bm5RSVRnNUNpODdKTURuajNLRFdETHE4UFJwcEQrYWErSHp2ZEJDWG15czNC?=
 =?utf-8?B?K1FnZ0NjQ1ZTdGFFTW5UekdwVVFWNC91dTRUUUlzOC9zSjlQeG1SbSsxKytC?=
 =?utf-8?B?aXFBYU95eWdmZ0l4bWh0RzR4bk9LTDVJRU1sZjFJUzFDUzVwR1lsL1M2VjZQ?=
 =?utf-8?B?NUVWYzR0NUpwalpCdFY3bU9QMEFlNVovSTIzNmpFcTY1SGlDVzBYY254SFdU?=
 =?utf-8?B?UGpESS9zSGxVbUdlVE12WEphZytkS2VoUFQ0UlQ3RlJ2K3JvYm5JTVZ6OVJZ?=
 =?utf-8?B?cFl0eGc2STRMd1NWdGxCd0NxVHczbGswQ2JzOXMzSHlBWThYZm9IdnNFdE5S?=
 =?utf-8?B?aFovVnd5TEZvTVF5TTJuSUJwR1RoRHFpMmxRSVYrZlp6ZzdNMldSQWREWWp6?=
 =?utf-8?B?OWc3REdOU25RdXJRa3VJSVZ4ZkJ5U3phU0F0V1FXVDdMY3V2TXl6Vkx0Tkt3?=
 =?utf-8?B?YThoV1lrcjRFQ2U5c3NQeEZrZkhnSFBvMDNIMTRIeWkzNHNXTnhZUHlWUHN4?=
 =?utf-8?B?OUlWdUdmVGs5TFhHNVZTNTFOYnl2dzdrZU9TbW1uaWtWUEFEejRrWVpLMjAz?=
 =?utf-8?B?a0dkZGhVTm9QVFV6b2pLaGpaVERYQmlsNUZXK2VKQkhYUHdOWElTb09SUDM4?=
 =?utf-8?B?ajVHTlhCRStKL05WTnA3Ym1XTmNsV1NxcnJPSGNkRVBKdkpqOFEyeUQ5anY5?=
 =?utf-8?B?UjFYVzg4L3ZFb0xQNlYzMGRJb0FlQ0tCOE53QXdvcXBMcVIrQXpnUVNWQmVY?=
 =?utf-8?B?MS9STVpxSk9NNnk3TGJ5NmJTeVZiWUNHYXIwdGl2Z0pvRmFMWERFZnZHUy9m?=
 =?utf-8?B?RHQ5cGU5VmNISy9FZEpjeFFsNW1HTFRXVzhVN1pUOVFwdzJGUTNwT0I5Tklj?=
 =?utf-8?Q?IIOzg7/Fn9y18QauR5SF5ekIe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 780321b3-e863-423f-6db6-08dccbbe4532
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 02:15:24.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1QkV3r61P8MYxGkTtlNpvNNzTR61kyaQQe4br8JQf19L9yD5sUCLiQPoQHIQO9zPgdN2uatYZi9OfDHLLnKlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7356
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
>
> Dynamic Capacity CXL regions must allow memory to be added or removed
> dynamically.  In addition to the quantity of memory available the
> location of the memory within a DC partition is dynamic based on the
> extents offered by a device.  CXL DAX regions must accommodate the
> sparseness of this memory in the management of DAX regions and devices.
>
> Introduce the concept of a sparse DAX region.  Add a create_dc_region()
> sysfs entry to create such regions.  Special case DC capable regions to
> create a 0 sized seed DAX device to maintain compatibility which
> requires a default DAX device to hold a region reference.
>
> Indicate 0 byte available capacity until such time that capacity is
> added.
>
> Sparse regions complicate the range mapping of dax devices.  There is no
> known use case for range mapping on sparse regions.  Avoid the
> complication by preventing range mapping of dax devices on sparse
> regions.
>
> Interleaving is deferred for now.  Add checks.
>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes:
> [Fan: use single function for dc region store]
> [djiang: avoid setting dev_size twice]
> [djbw: Check DCD support and interleave restriction on region creation]
> [iweiny: squash patch : dax/region: Prevent range mapping allocation on sparse regions]
> [iwieny: remove reviews]
> [iweiny: rebase to master]
> [iweiny: push sysfs version to 6.12]
> [iweiny: make cxled_to_mds inline]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++--------
>  drivers/cxl/core/core.h                 | 12 +++++++++
>  drivers/cxl/core/port.c                 |  1 +
>  drivers/cxl/core/region.c               | 46 +++++++++++++++++++++++++++++++--
>  drivers/dax/bus.c                       | 10 +++++++
>  drivers/dax/bus.h                       |  1 +
>  drivers/dax/cxl.c                       | 16 ++++++++++--
>  7 files changed, 93 insertions(+), 15 deletions(-)
>
[...]
> @@ -2185,8 +2191,13 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>  			goto out;
>  		}
>  
> -		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
> -				   TASK_INTERRUPTIBLE);
> +		cxled = to_cxl_endpoint_decoder(dev);
> +		if (cxlr->mode == CXL_REGION_DC &&
> +		    !cxl_dcd_supported(cxled_to_mds(cxled))) {
> +			dev_dbg(dev, "DCD unsupported\n");
> +			return -EINVAL;

need a 'goto out' here to dereference the device?


> +		}
> +		rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
>  out:
>  		put_device(dev);
>  	}
> @@ -2534,6 +2545,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_REGION_RAM:
>  	case CXL_REGION_PMEM:
> +	case CXL_REGION_DC:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> @@ -2587,6 +2599,20 @@ static ssize_t create_ram_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> +static ssize_t create_dc_region_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static ssize_t create_dc_region_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	return create_region_store(dev, buf, len, CXL_REGION_DC);
> +}
> +DEVICE_ATTR_RW(create_dc_region);
> +
>  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -3168,6 +3194,11 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	struct device *dev;
>  	int rc;
>  
> +	if (cxlr->mode == CXL_REGION_DC && cxlr->params.interleave_ways != 1) {
> +		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
>  	cxlr_dax = cxl_dax_region_alloc(cxlr);
>  	if (IS_ERR(cxlr_dax))
>  		return PTR_ERR(cxlr_dax);
> @@ -3260,6 +3291,16 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EINVAL);
>  
>  	mode = cxl_decoder_to_region_mode(cxled->mode);
> +	if (mode == CXL_REGION_DC) {
> +		if (!cxl_dcd_supported(cxled_to_mds(cxled))) {
> +			dev_err(&cxled->cxld.dev, "DCD unsupported\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		if (cxled->cxld.interleave_ways != 1) {
> +			dev_err(&cxled->cxld.dev, "Interleaving and DCD not supported\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
>  	do {
>  		cxlr = __create_region(cxlrd, mode,
>  				       atomic_read(&cxlrd->region_id));
> @@ -3467,6 +3508,7 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_REGION_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_REGION_RAM:
> +	case CXL_REGION_DC:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..d8cb5195a227 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -178,6 +178,11 @@ static bool is_static(struct dax_region *dax_region)
>  	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
>  }
>  
> +static bool is_sparse(struct dax_region *dax_region)
> +{
> +	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
> +}
> +
>  bool static_dev_dax(struct dev_dax *dev_dax)
>  {
>  	return is_static(dev_dax->region);
> @@ -301,6 +306,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
>  
>  	lockdep_assert_held(&dax_region_rwsem);
>  
> +	if (is_sparse(dax_region))
> +		return 0;
> +
>  	for_each_dax_region_resource(dax_region, res)
>  		size -= resource_size(res);
>  	return size;
> @@ -1373,6 +1381,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  		return 0;
>  	if (a == &dev_attr_mapping.attr && is_static(dax_region))
>  		return 0;
> +	if (a == &dev_attr_mapping.attr && is_sparse(dax_region))
> +		return 0;
>  	if ((a == &dev_attr_align.attr ||
>  	     a == &dev_attr_size.attr) && is_static(dax_region))
>  		return 0444;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index cbbf64443098..783bfeef42cc 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -13,6 +13,7 @@ struct dax_region;
>  /* dax bus specific ioresource flags */
>  #define IORESOURCE_DAX_STATIC BIT(0)
>  #define IORESOURCE_DAX_KMEM BIT(1)
> +#define IORESOURCE_DAX_SPARSE_CAP BIT(2)
>  
>  struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  		struct range *range, int target_node, unsigned int align,
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 9b29e732b39a..367e86b1c22a 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -13,19 +13,31 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct cxl_region *cxlr = cxlr_dax->cxlr;
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
> +	resource_size_t dev_size;
> +	unsigned long flags;
>  
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>  
> +	flags = IORESOURCE_DAX_KMEM;
> +	if (cxlr->mode == CXL_REGION_DC)
> +		flags |= IORESOURCE_DAX_SPARSE_CAP;
> +
>  	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> -				      PMD_SIZE, IORESOURCE_DAX_KMEM);
> +				      PMD_SIZE, flags);
>  	if (!dax_region)
>  		return -ENOMEM;
>  
> +	if (cxlr->mode == CXL_REGION_DC)
> +		/* Add empty seed dax device */
> +		dev_size = 0;
> +	else
> +		dev_size = range_len(&cxlr_dax->hpa_range);
> +
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
>  		.id = -1,
> -		.size = range_len(&cxlr_dax->hpa_range),
> +		.size = dev_size,
>  		.memmap_on_memory = true,
>  	};
>  
>


