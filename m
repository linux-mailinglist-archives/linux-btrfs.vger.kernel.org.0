Return-Path: <linux-btrfs+bounces-7767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4216969460
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEDF283424
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D302101AB;
	Tue,  3 Sep 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcm92F9G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFE1D6193;
	Tue,  3 Sep 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346651; cv=fail; b=BiROw+c2TDXqT9F+oG6nRfmSwT1NaHJXtT9RbVE1R3eDQX/jkqv0TABAgXYx5HX0JZir9jbvDYGuPid8YyDnXofy9Ou6KUETGRWg2ACbIO9SaW3zSQgRILcvgU4Nq8T8ypNIGEIsVmXMry9LFr+h1wCAWfw3PC7LnIMx39NOYf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346651; c=relaxed/simple;
	bh=6R73pp+SJejjOroUKJFyPONzLMwiSxzBduZvgdpCkpY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ashPuEQkt6GFjRSDpjAYKWqGALsRuKoglsDg3NrEX5TUzVCwno13gMuO0SGS8rjp2Cv3aBdAubM4glXMgz5pUQkBNVed9VXJcIukCAaWmkBPkkLTkcs+hBSfTse9FkGamofOXdH9uP54mORI8CqYXB+o1WZnXVb4B06/i4OfKPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcm92F9G; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725346650; x=1756882650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6R73pp+SJejjOroUKJFyPONzLMwiSxzBduZvgdpCkpY=;
  b=jcm92F9G54xjOV67LFL5g5pjIDt56cuE3viBIvrxY+fjA4kB8YJGLzg1
   VpniUuhJ4gEX4O17gZJjUdTY9Fc9Ur7FyLdsmg+tKSup/vl0Oaj45k99n
   4NIklNT2Oj3I0R1SFaU6SSK2Fi0MMKGXWda3kpI9yN8dSMMOZ7aC12XNd
   zdsijymshdMsJv/AN1tMK/oxRDSV9d3rZh0Xpcnj8KI56uTQQMsFSvWVv
   n/9Jue2UUhc+rBolTf9+l3fHggcq1ETg3g5zHc6EtEUKCXDXUEZCnivkk
   piieB+OXgBk++hpSfAlDj5hu/USJRLPpntfZrrH+UJRxdBqLGfYdWcKKK
   g==;
X-CSE-ConnectionGUID: ZaSv5xa6QXSzS8BhaYKqdw==
X-CSE-MsgGUID: 4yC+rjUETtG8wZBATqy3JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35082861"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="35082861"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:57:30 -0700
X-CSE-ConnectionGUID: uepeJQNGQOeyj6c4RtUr2A==
X-CSE-MsgGUID: d1bgvUBnS6O8wLBzHWoe3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="68946154"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 23:57:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:57:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:57:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 23:57:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 23:57:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc9S+z3SkbWxiOlHPfVppOytbPNzNxFIqllYKO9Hv95Kcz06bKQsBE0/PFLRG/oxtBHmcnQgkpy3rzZQ495c6lahvn0BXDkzwadtLIJoHoBzjf14JCcf8KR3jCkvjnYamA4STrXTWbzskqbAvdP5ptji8okoWHs2WBdGeKeBY79DUpFPkZ9apVdNDMtQrFm4rtduB1g15g2uiMNViXOa+8EfShgLtu5aQLxlx+ee2oVtgHLl0Pz9hpJDq5I9QM2qMPalsosuhZSDjwoAsCcGY6mLaUBdrRezexgFoh0wdP4B394T9JbbwFXSfK+2/+GZQ870C8vcxed8WJMsCHRvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB5PtE/5iQxW+ohAQXrI6pU/DA4oXHEf9V76bi0X4JM=;
 b=j7FKsG2oXHcEhyMzxpXne9J4SJa6sp/D9hFpUIJLFofd6JHSusy6SSVHaaiqu1LlgatmtaQH6dg8K4H+KiTQI1Uzyu4XuJabxKBUcqANNsevuXuj1ZEfRWF9VcPpJLzer+QFk5D9JOOYcTeyFWw8y4GUcLrDB0OJWjCqS/UDM71aA6PxKEoH5kNBdXwBMW99G03bn5f8uB2d4B9niAzAN0ucxUzHAOdHIAB42Q8BUdptNdxS1kWKL1J1qnXukNLr6QdiEAqxlcEbixNJbDkEo/4BK6T+x1UELHVaKr4Y7TVwfYDDXAc1/UTw5ubX1bmeihrEcYezNwaT70qb/9CP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 3 Sep
 2024 06:57:25 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:57:25 +0000
Message-ID: <f9e4155d-395c-4816-b9ca-a9284eb88b98@intel.com>
Date: Tue, 3 Sep 2024 14:57:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/25] cxl/region: Add dynamic capacity decoder and
 region modes
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
 <20240816-dcd-type2-upstream-v3-8-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-8-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: c41a861b-d4dc-462c-2b85-08dccbe5aaae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHRJaGlGREpteVVhMzhqdDlkQm05dlUyenlOek5NNHhFRVRuTG5zRTZvYXFs?=
 =?utf-8?B?dDBFdHVIdGxNZFpkT2NjUmZvRHlMcHVuNXAwbkgwZzBlc0dXRmFwL3Yza0c3?=
 =?utf-8?B?VTJ3WUpIaS9HN1VIbnZ2R2dwblBibFcrdHl2NVJDTUk1dnU5bzhzUXFETXlT?=
 =?utf-8?B?M2VjclNLS3NGNjZvL0pkY1IvVEUwdVlhYkVFcTRmVkdJaTFLS1owNXJHZUxO?=
 =?utf-8?B?MmJ4UjhWY2h2TW9ScHpsWks0NEhsRkNHam9ORmRVY1hqblQ3NWNiQUdTMVJS?=
 =?utf-8?B?TDNLQThpeS9GMUlINUVYRzFZdGFRamE2SllxTDAxSWpiZVA1c3krVXJlWC8r?=
 =?utf-8?B?WjY2aFJHU0RLNXJ6aWdWQVZFTlRaS0JyYzF4NkV4U2hhQUpFenVXMWNLb0t4?=
 =?utf-8?B?UmYrM1RqeVc4Zm0xQnA5YkhwU2pMSlp4WEhyMStTZnhlUXpyMWhQYjFrRUVZ?=
 =?utf-8?B?U2QxanJNYWtLcHFDdDJwY0FyL3hhUTBoNkFKU1VIZ3RVQ3M5MSs0WStqNWZT?=
 =?utf-8?B?ZGloV0xIZFY2WFA1NmFOdXVOTmZLWXBNQnVOWWYwZTZRelduL29hVlpxbko2?=
 =?utf-8?B?U2FVbmJSMk9WV0NmSnJmd0lsWG03YkJ0WU1RV213LzdOLzB6NVAwQkgva1RH?=
 =?utf-8?B?VTRwZy9FaWFwZFR4ci9aeGJKVWdtRG9TTnhFUkhXVHlyK3J5V2pialpiOVZy?=
 =?utf-8?B?WG45Z1BQV1Zhdmo4Z0RHc2NkK0N3VW1mZW1tQTlyaFV4emtGTkJZR0xtVWdH?=
 =?utf-8?B?SnpjOVFjWThoQWwvUUVRb29xUS8wT1RqNndQdVVKamFMc2Y1MTFLMUx1Undh?=
 =?utf-8?B?K1ljMmtIOVArcEVNZmhmK3gyY041cXh2V0tEZTJGT25XckFaL3VSTDVxTTFI?=
 =?utf-8?B?RmJxZWpMSXViQjdQOVlCRWFuNk5GcjVmcy9DYXQ1NVBtUktwZGFmRVgra3F0?=
 =?utf-8?B?T01LQm5taWlxS0d4MXpGdGxDanhLcjNiaGE3bC9nTlEvakN1SXhGd0dhQjFX?=
 =?utf-8?B?UjdQRlhHT04vYzBCSG5YSTRsYWxkRGJ2eEgvR0cwZ2FQSnYzcnUwbld4MUNn?=
 =?utf-8?B?WjI1cXJ6QlkxZ3hpN3VZVGNLbzJBck9KMFRtWWRsSVJBZDZVOFY4THFIb1VE?=
 =?utf-8?B?WXI2aGI2ODlMV0Y4NmhKcjNwdVptRFU2THZwR0lzd3pSMmlXWmg2NzUyeS8v?=
 =?utf-8?B?M2lCQU5EYUV3RHN0MTdEREUzTzl5UDNIQTZFODdyNUV5T1J3eHNkUFUyOFAv?=
 =?utf-8?B?TndrZmdjSVU3Tk1sMWpkRXVMcW1YZ0EzeDMvbnA1YUtPUzFncU5TZ2pRMFF1?=
 =?utf-8?B?Nnk2T3RJV0dwZzNsRm9FNnVxR0F3VjlQaTNUY1dPdW1lWVhNWTB5b3VnU2Fv?=
 =?utf-8?B?ZCttZ0lkR2FmbyswQlRpaERheDFGVFQ2aG40d1pSQ2tyc2ZSUkcvb1JBRVFq?=
 =?utf-8?B?WWZuOXNzYkhvWFlUQkgvYUlBZ2tXNTdLUGdqNUVBcTZydUtEbUFuU0V1UUln?=
 =?utf-8?B?MGxnaklXYjVJdkl5MFQrZHZYN0U2a3NIL2I1WGwvKytNYmNWd1FGVDVJbjVj?=
 =?utf-8?B?dVA2U08ySWJWRUJCUVlXbmFCdE10Vkk4SXg1Wnc4MkdsK0g5MDZxS2twVHVJ?=
 =?utf-8?B?dGJqejNIejhwWEV3L09HT09hUEtybzI4eTJUeTdiMkZCRFdyNEg1T3h4WmVO?=
 =?utf-8?B?MTRMOG44M0Q2bHVTYms1cjYxSUJaU3FyTU8vU0pqTi9DQ2FUQkh2NVBHKytR?=
 =?utf-8?B?aUlkd21OUFFsWnZsQUdqb0FLUWRCWEhzeUpId2Rnd2V1Mm9reEZ0WkcrSlFY?=
 =?utf-8?B?aHN4YVdEcGJ4OTZzdFBZNWk5SENWMi9LZ2hMSWdZMUVYNDdRWVY3YU5xQW1B?=
 =?utf-8?Q?k7LaHHRshU5Y3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNxVHNsNVV2RnY3UG4zaU9zeHVxSk1EMHRGOWhBbGNMaE05ZzVGRkxFT2Jq?=
 =?utf-8?B?NTFnWWpKQlVZdk1TTXpLYTVWd3hyUzBCL0FGVHJ1VDYzQ05tK0VxL0o4SExt?=
 =?utf-8?B?NlpjZjdEM0tTbm9leERiQndrWlhSamI3ZkQ2YWk2bWtlUnlNeVV4R0FhVFly?=
 =?utf-8?B?b21yNnZjdlZhQTN2czFJVDczamVXRk8raEg5VzhqRm1wSElkYUFoaHBWb0I0?=
 =?utf-8?B?aS9xNis5T05FbXF2WjBNbTBQRFoyNFBjNFZPbmxZR3VvelhJQXlDenFQZEtr?=
 =?utf-8?B?OWliZ1JPWUhnTlVWdFVLTi9KODZVMTdBUm9TeHZUYnF0T0FZN3ppRW0vbTVJ?=
 =?utf-8?B?dkJCWVl1YU9weXJpdFNhVGRRblJSU2dueHVYL29uaG0waHcyblgyNDI5Nytt?=
 =?utf-8?B?ZXBGUTZybHF0K0UybHdYMkhpUytOSnR5a3hkL1pwUUFJVmlsbXcwWjFLODRS?=
 =?utf-8?B?QjAxczF3VHpMS3p6UlFjeGMxY25IaU4yUHlSbThTYUtEenplb0V5L2VJaU5P?=
 =?utf-8?B?WXlyQkY0YUpkaGxLM1BmSXNCNGhDNU1tYi9SaFZxaklFdlhHSmtYVHMxaXpP?=
 =?utf-8?B?QXBoeGtETFFXeXNwWVFQNThYUlBtSlZEZkNNZEd5NUk3YnRUZTlCTWpVNUZq?=
 =?utf-8?B?amZhSzY3UDhxK0s0VE96ZnZ5bFFiOGZZRjJBUlp3a002MnMyRktzNGZCbUFx?=
 =?utf-8?B?MXBlemZkdk9Eb1ZuZHdwQUE0aWVFMWtjOUJkeWVOUFFUdGh0eWg4Z1lqUWN6?=
 =?utf-8?B?K0JQazcvb0taTHpneWRBZExWVFBmTW1TOGh4MVJBS3hwOC84R2kza01GL25Z?=
 =?utf-8?B?d3ZsQ2F6Qyt0YWdaOVdDaktyOEorTG9DQzBYSVEvMHExSVFQVUIwOWNBT09N?=
 =?utf-8?B?d2puN0U0UTVnVjZRRDdiRVdDNG16Z09nZEtFOTFoZDVJY3l0VExxYzJ1eFpT?=
 =?utf-8?B?bmFQNnNmZ1lhWnlkcWMwWUVLa1VrYXNGUjBJaHZvLzlkczN6TXRsbHdIVFcy?=
 =?utf-8?B?V1dxbzR2T3IxWEIya2pvUytWYUxKNW5keHEzWUpKMTNtRXNCNHZaU216Zy9P?=
 =?utf-8?B?YjVZUk9qekFENmc5anVBVHh3V2owZkUwbkZBQUg3TmI0Rm5pUWIwWHNJUHZS?=
 =?utf-8?B?bXUzc2JKcG10elFQdlFtbmVnMTYrSjJhMTN2djBaTndXNlMvZTBLdXFKWWdR?=
 =?utf-8?B?NVF6WEE5bXh4b0hFQ2pva0lsWW9icmE2azdoWU1GdnZKUjVveTJHMmRFY3Z3?=
 =?utf-8?B?MHcrSXl1VlErczlvL3FIaDFxQWluaU5oVkFFQW1KVERPbmorZFFsb3ZtOXVi?=
 =?utf-8?B?QXBvMkVFcXFydzcrQ3V4RVlnVFVwQ3RyUldlUWFiaEszODhlc21qb0xDNjVX?=
 =?utf-8?B?NlBQUkpRTmxUcVowZk1oL0FBN0ppOFR4RzU4TU1JWFI3SUllVjJMa3d0VURr?=
 =?utf-8?B?WmVhZlhOMEluVkZiVW9qT1loQm1vSjZ3TjBaQWV5Ull3V0cyYld5clcvSXN6?=
 =?utf-8?B?NzZIYTlvcU04bE0vUnhHTmNRa0xXNU0zMmZJcW1hdmdZaFFFdmQrT2E1L3Jm?=
 =?utf-8?B?RlplOVV3YlhYdWFiaFZPR2s2YlorQUQ4WTNNT2piTHVycm1YR1VLMExXZlZn?=
 =?utf-8?B?U3BCUnpKbUxZRGVkd09BdVZKVk55bktVM3J2UUZPRmFCalJvZWVpeExrdmtl?=
 =?utf-8?B?OXlZOHFsWGRXWmR3eTNQT1VyaUcxUDlMbWlLS01OajlRMXBFN2dkNGcrSi91?=
 =?utf-8?B?aUZvMzdsVXRabGpFVG12R3pBTTExcDQwak4vTHZESjJSWkFhMFA1V2dxRCti?=
 =?utf-8?B?UWg0Z3RUY1htR25qMHR1U1pMQ1FpL2F2MGtnNC80QWZKdGRuQkNheHRscW5p?=
 =?utf-8?B?c0sxT3BJd245VDhSenNwYVF0NGo1dmZteXAwUVkyYnJWUVZySEZnelpCVHdr?=
 =?utf-8?B?RXIycFVvOENGcmZoaGFOSGpuUU52TWFyTTBhekZJM0x3MjdBcnByeHI1eXNj?=
 =?utf-8?B?OFRxSUk5VzlEK3dGcXlhQ3NYc2Mwck56SmpIK1pUaXhmbnBITHZrdlk0cHVG?=
 =?utf-8?B?Yzk5cWZ3TW5VcVc5ZEdUcWxhc2RUbkt0VEVqMHU1enJaN2NxUXRGWmIrclNz?=
 =?utf-8?Q?kh55ax6v9TMmQfN9Ai980D4cW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c41a861b-d4dc-462c-2b85-08dccbe5aaae
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:57:25.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xejAMr9Kpt//lQ6J0lo98ei/JLQyyf1l02TL0Sko3MxS7geaoqHTaAObkBnOxdTtbXkh+xw3epbLBoX/mJAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
>
> One or more decoders each pointing to a Dynamic Capacity (DC) partition
> form a CXL software region.  The region mode reflects composition of
> that entire software region.  Decoder mode reflects a specific DC
> partition.  DC partitions are also known as DC regions per CXL
> specification r3.1.
>
> Define the new modes and helper functions required to make the
> association between these new modes.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
Reviewed-by: Li Ming <ming4.li@intel.com>

