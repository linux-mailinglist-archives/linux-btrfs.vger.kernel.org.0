Return-Path: <linux-btrfs+bounces-7520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C295F8B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 20:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F9282CB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5FC1990DD;
	Mon, 26 Aug 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2cntS6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880B1553AB;
	Mon, 26 Aug 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695393; cv=fail; b=lPEVxs3RxlOgb8Tz7wIZ4bywvLVt9hDnDtRePWGLVM1gvIKJmJ81UWwRU6jJh14irmEQ6rUYleSPcWFfsPCkW12qISiNBgoxiizGbR127lOUuAWccCzetPTPN2rx97fCC48TmK/Rav/i2kn76QjHtHDYyvBbPtI7IGTn06afvCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695393; c=relaxed/simple;
	bh=T6eWBkIItJZfMV5pMOkXX5jC/Dfdw3OsC9S6aM1Rm84=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b48chLtV+Z1Z7Ppc+JNr3ABUCTggGx4C6hZU5yeef58OYXL+6wCwpBnTlGRQAWD7Mi+TSseOOn/pSrohpVKYV8CaJe7cB1qcOPU9Lg6TBgxpmSLn0N5i+XaB/4pQ8CNvFWQ3ILJQ/Sxc/KfgHKbBW2iorDCQOS3b7/5CDobTzQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2cntS6V; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724695391; x=1756231391;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T6eWBkIItJZfMV5pMOkXX5jC/Dfdw3OsC9S6aM1Rm84=;
  b=A2cntS6Vb5zPMl0P4D7duTeNMNjP/2vqoxUA9U4e8VByvi+gz6cU11nS
   d9ceN1qrKDQYCfZNjJ7MGX4NLhHN3xiP3Rn84pw6rZol8udFzgsA+YzI9
   9fQlXanZE6PhfMNkxssfg/MysqS4lR/iHtfc7yZpKVrtee6PmDS4NaFHo
   GRY9i5o0MVCpDC03c5QgTGiUhllfonSboegMiIYUCR+vBz2y/Aj2BqdGj
   uC8nv35L4KOuw0dG6xon8HGKVswwHEL4478vcVANalf6ogFaRGxquJST0
   PM0iR/Zh66tLgchcm9yJeFyuwFwyESWrhDJhmZPh3CQjkFPlQ/xlX+dRP
   A==;
X-CSE-ConnectionGUID: yZuaLVbFS/mqHrGlthbixQ==
X-CSE-MsgGUID: gGofwe6qTqCb8+3giN1+dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34292992"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34292992"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 11:03:10 -0700
X-CSE-ConnectionGUID: fAvLPNPlSIazvnhyOlfXcg==
X-CSE-MsgGUID: SScQB9bvSdeHygEZLPfD2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62420561"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 11:03:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 11:03:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 11:03:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 11:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDjBUZmG5994yHCfGUzr4MULrKL+Bq8DMIuvPJuLu0imzrHp11RM0zEY2RLDDhampkvn7h6gkYji3XC1bx79PIFXT8zMwa1utL9q/iRhz25/xRs77L5FBPpo5H+7f4JdJaOFtFhg2LSK7Tp5LHNFhYNQu4DE3RMVXiGWrUDvOYnqSH66vPx1pA4cGjwvBVLsyqL6XcNmZiRYQWZ7T1rXa8Er3y7dFBVQ2YTfk1fXMSVyxzsugf4Souv8690pkWn4v6ddMNYIJlyMEM+tIQiW+y0aIjf5fOh04kGQ46TjdD+bfNBNh42VADS4MbybxbBsYH6AWJTpv6a1Zm/Uwoy83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJvWj9L6h4o+3MnIKdMENOgV+eoIBbTiMJsgTXG/Z5E=;
 b=njPXDYGn68GA/sMkURKpFdn27xAnOnl065n7c8rpF8Co8QtmoGBVLKizFWqYLvhN0PVmA7Fo9a/WCafSh/efqf9s0RoQcrGhePsUQ1iuQ6XTOK9RkP+G99mkCeDv/4zbvWVAV7gm7cKtr6+7WqaqJu7FLheJ7TerH1OmvUff6GN5CQ4m3amNBnMu3E2lJxZCi0hOceI9ClC2IyEMRvi7kuRXlL6MVJKlV9vseg5NDQjsBIcz7293nbygxwpLFc3AqG7q5p5nPXsvGOfJOGpgBuBSqNyYqFBVmWl87Z+4LrxdJk3YHHWIlGZH239jXwULS2RSXyJZMlDqPNEsX6h00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 18:03:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 18:03:07 +0000
Date: Mon, 26 Aug 2024 13:02:59 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
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
Subject: Re: [PATCH v3 23/25] cxl/mem: Trace Dynamic capacity Event Record
Message-ID: <66ccc353c1203_a4ea2294ba@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-23-7c9b96cba6d7@intel.com>
 <725ff759-c49c-4f72-b39c-530822963ff6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <725ff759-c49c-4f72-b39c-530822963ff6@intel.com>
X-ClientProxiedBy: MW4PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:303:b9::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN6PR11MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5314fcab-1477-4d0e-1fdc-08dcc5f9568a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XIFRn9nazBrsyFJvImftViwIxKb5nflD4sd9QoGYverkIBJ9xu/rxQBswok2?=
 =?us-ascii?Q?BrBbnzPc8IPhNEK9cwiVnC1X3wwSlgxAilfvKpB1GwhG7X3ubz7kMl3tcnx3?=
 =?us-ascii?Q?yKwjWRxUALOlPKlyOm36ZjgWOwg/bS/aSxbzymiSNE5O1PA674JjSrZDi4E+?=
 =?us-ascii?Q?KbDk65Qt6d1ix/Bdp33q3YeDlgdx3wQkeICTltC+NCSfmZbYXMomL55hO3z0?=
 =?us-ascii?Q?hDWjv2HbwAvEUqfF0qI3TGJmpst9fhHZuxm9kfW3Ag/UsDf7dE+qhdW/IbhQ?=
 =?us-ascii?Q?Vy1CcCFbs2+35OmlqurjUEaad2P0OxPWaZw2W727tnMmJvqdWH0b92WKxqRZ?=
 =?us-ascii?Q?C3I/iqZ4Bus0jzSp8R96s50lZ97V0AmhNWIGi3Jn9Iz9+VMaiioDKmmV9HJd?=
 =?us-ascii?Q?e1HsQabal+dr6TCP/uyiMwEx4DqcWnU5L3E4eUUExyTV3kwShMSN5PryPn2U?=
 =?us-ascii?Q?844d5FUFn51xvceDp3JqTk9DLwmLTRd3SeExMIwMS8iHnf3vwPibCq4gH6wA?=
 =?us-ascii?Q?10C+9ZviMy//9Q/EfkT5CMwzItbNKfw5GQuQdr+AwmuP6HCjWoV65at0bid1?=
 =?us-ascii?Q?5nz9UYWIOgWaEqpmklcohSEOcQFY87ZdTP5fzDSsYi/UWFlH13+9Q5hN/fBy?=
 =?us-ascii?Q?l5g7Hg7AZW+7qFHB7g5RV/AvVWpFZpsv8YHhNTSo4jZypJezEAYaN9PCebXx?=
 =?us-ascii?Q?MiQU0YnBYfNa3LLmqaKk6PqSao/4w78p4IDxk9CjdMxDRHO5TmfMJXiZX+2f?=
 =?us-ascii?Q?eEy9VM3Rwg5YcF4W7+sV1ISBwanqXAXXpOLZEAd5k+5IOT9zeWymJzce5+Q0?=
 =?us-ascii?Q?2ZAV9X2mnXHAQ1vW+U8zGmfGnVjLyhoYB75pvfCMUTWbf+KHw9HuA8U/UT4S?=
 =?us-ascii?Q?wn+OBy5yqmVUHx5fbXcLnVhey84ridFR23ngNIWSW8/LbE3LVGEc0ovYb8ss?=
 =?us-ascii?Q?uhdvK/poAp7tRQlwxM9zCyoNi+rOmw1PrBVuUOYHhvykpENb7BbpsHpT/UbR?=
 =?us-ascii?Q?MOhyRZANUlzBbuL/Ug99/KtuFnr+Zz13UjSoBSQmewFzwwosuRDbfNBdkl7e?=
 =?us-ascii?Q?cl9Bvrhlwwilx7DL2k4k7jOLOYqdR56dTD3JT7ki53QrGemmYHX/Nq6bn9s/?=
 =?us-ascii?Q?btNhyfSFqBNCeJrJuB5R2gv+JZ8bk1Gkxk9Nq6LqrbndSIWg3Om2uy85XhTK?=
 =?us-ascii?Q?uzfEnRfxKM7HrAlMH75PW8g/zyHkvjIE03hjWrNukIb3n2thYOv555VBjOwQ?=
 =?us-ascii?Q?dWgwQO+JtF817gttMaisFQk5Il+dXx5limqvsrTUbdbytq49oAd40S9QlOKx?=
 =?us-ascii?Q?gvnv84im179z/K3U4SCRLJwe/T7zGkIXE/3EBT1wmxFR2Yt6JZg096woTwHU?=
 =?us-ascii?Q?cj5833D/qfPs8t7jiEziJlXObOJg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGTXqQuhBkunn4ZZclyPKJxkZwdaB+qfVpVMOb4Jamo5eQAf4PCPA+SHVg17?=
 =?us-ascii?Q?KjjD0VgjxkD0x/O6r0+CdlSAVJs0u7qngac+aqQAUnVeTWHVWBmwclWoqRdm?=
 =?us-ascii?Q?Uqfw9w65HQtks9C12zB/5hb3W5DaMGkl5QsiuWdSDdxoo2OCOgRrbuqGCvzW?=
 =?us-ascii?Q?RKN0poUwGYUt2RnIybIC6dZL5vTyQT/9jjJCQ28n+hoYk3hP7h8eKHpHvOV0?=
 =?us-ascii?Q?0H8XYUKuAzhthofgSQTPJWwfPxB9RCB5cs7tCcmQweB8RyESOjkVw8iZPug5?=
 =?us-ascii?Q?OCi5jm3t8Vnk/brY9/5oVeBtyOnMVASQbrCip+EVcarCGt9z7A7tsahH5O7e?=
 =?us-ascii?Q?52SVxZERQzUSQiKDT1GfFXOROHdqhzpcNAV2/EFXNGoEVS41FQL2q6crmeY3?=
 =?us-ascii?Q?dfOvU+OnIQ2cOxlLcYtZxBelzeZf8/FJZ5Ugin5QFG9UBYwe/rtvHg8dvViF?=
 =?us-ascii?Q?AwHgibDaONi/yBWGgXzHXVsJ5SX7DJri1ntOX/ihnKm7TRR8UidiSH7jFi4L?=
 =?us-ascii?Q?2mZqkzHe70MgmjB0+Yq6s4/gGAUeZSnIChn7nvI7lP59qj15xNp2IsC/vEgk?=
 =?us-ascii?Q?azD+Koa/pqboe8YdV+kWlhuacecZLug6YpWBJvR1Gl30CL3ytjFJkhG1OoWQ?=
 =?us-ascii?Q?fXFIbDQxnilRMRKDwF7gdjo5j0Ypf9b9/IgSAAIa1gryIBtSQrO2dQ7871S1?=
 =?us-ascii?Q?ETRDcMqW22FINRhhChbd1VTM3uLwxkskhXzFr1y5CWlyJhKXsZQPTG+VI1Uu?=
 =?us-ascii?Q?ApyKQ0wYZ+nnJY9G/bJ+j9UEpddhbF6+nZ+8olKLliJBvw2r2fTjcnNF4jR6?=
 =?us-ascii?Q?jwFKTvEhhFANWGFWq/jt/yzJFTaOkbT7zs9eBngYbcDtqBtHpfCMq71iGjfR?=
 =?us-ascii?Q?wRt5S6irUCPJ4WYktQXboLenBYfflUZguvMtPGVk65kPdkbQoiYzt/9IAzTN?=
 =?us-ascii?Q?Hw8SRLtAQ63deQCweu4MNxCLmIwy1iz7RI0M2UdiWR6v0xH9FIH44Ww070Ec?=
 =?us-ascii?Q?8YJR2P/Dw5yIZQraV3kUNRNCFQ1TCbAHKxdIUSJQn+aPUiaKPfQIpz0NQBUi?=
 =?us-ascii?Q?FKGIb3iEodFlwdSVRYdcIO3GPlVDJD5NPmK4rp/flNbeE8MTfkvA9zSm5tOn?=
 =?us-ascii?Q?Mt5CMKohmHKihKMuaNpwJSbs1FT7R6F7nSgFJqu8mGieNEbHDJOp/Def0YMJ?=
 =?us-ascii?Q?2U+ntebAHPow4yQthuhhsDn4bk2zOcnaZtWQ8nOLkdalHMRgIYqemI/AlZA/?=
 =?us-ascii?Q?jiCBl6ia62Q0Uzx4KlUhKP7XZFh4mD0BQm0m6tCIm+R8iypOe364KRj/HkOZ?=
 =?us-ascii?Q?dmXGnWwcWifFIhUFoCCjQNacGkAWu8ipFdjJ0j6EHsqSFVVcWoNCdQsY31Uq?=
 =?us-ascii?Q?4LJjR7uPKjQWjZbK8lRDR/yAH5xFVN1daCy4MCg+5lkTnNanpEPHGesn4rhc?=
 =?us-ascii?Q?/0zBaglncWvqbtmRUb9ZxnLcWcGlpwr8c4QUTiQsjLR5xZtInpPBiixVSWKx?=
 =?us-ascii?Q?eT34SFXPIiJ/ish/cktKLTEPFRbE5ZXZHDKnCzUxbObieaFSsSDqqvck5CaW?=
 =?us-ascii?Q?F6dJzXp4F+NTymAesbl3F2pZ8kUV/v1UQwm4rd1z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5314fcab-1477-4d0e-1fdc-08dcc5f9568a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:03:07.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5AnUiryUjUimWmj1cUGAMcAb2KT8LDXaAeqm/hVaKi5qlCUFB7P0fQcYuqOhpf+KQyZsnKnZgJl/H5N/QfNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL rev 3.1 section 8.2.9.2.1 adds the Dynamic Capacity Event Records.
> > User space can use trace events for debugging of DC capacity changes.
> > 
> > Add DC trace points to the trace log.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> small nit below
> 
> > 
> > ---
> > Changes:
> > [Alison: Update commit message]
> > ---
> >  drivers/cxl/core/mbox.c  |  4 +++
> >  drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index d43ac8eabf56..8202fc6c111d 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -977,6 +977,10 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  		ev_type = CXL_CPER_EVENT_DRAM;
> >  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
> >  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
> > +	else if (uuid_equal(uuid, &CXL_EVENT_DC_EVENT_UUID)) {
> > +		trace_cxl_dynamic_capacity(cxlmd, type, &record->event.dcd);
> > +		return;
> > +	}
> >  
> >  	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> >  }
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 9167cfba7f59..a3a5269311ee 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -731,6 +731,71 @@ TRACE_EVENT(cxl_poison,
> >  	)
> >  );
> >  
> > +/*
> > + * DYNAMIC CAPACITY Event Record - DER
> > + *
> > + * CXL rev 3.0 section 8.2.9.2.1.5 Table 8-47
> 
> Should we just use 3.1 since it's the latest?

Yep done.
Ira

[snip]

