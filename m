Return-Path: <linux-btrfs+bounces-8803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F3998BB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566031F21717
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1821CEAA4;
	Thu, 10 Oct 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASMzhMAD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECB191F65;
	Thu, 10 Oct 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574258; cv=fail; b=aWhSaKAYY3QpRyageBhkC99RT6uI7QVAPk+v74gtJV7yJ/3/Fhwv1nEtxuRNmLrIyb9/68LUTPCC/bG4ikk0ACIUpmtQM+QwM2q95Ibp9wbFnSxT17fFPR9+41qIULWM/YvLfIJHhBPkgAVI2Oa8ZWXRuvA6yqLv6tMXBmbd6hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574258; c=relaxed/simple;
	bh=GZATE4Dtn5CltvAbMY5/YsJ1j3hKPQuQ+H/8Ji+3NUE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aot2w5T1bQ8KgkoMdiWRQPV/rj3jRzCSubPze7Q8xKWWDeQmy25w3kVRoB9EodV59K5jW7bGQ70UoFNP8Lo/P2HlEKtFvhlSipCKgECiFtBUGDOrJJ+49Th487zqR+PSU3yya9waP2aFdBa13eOK7VOgZeDdgbtjyyhdjrUIWSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASMzhMAD; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728574257; x=1760110257;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GZATE4Dtn5CltvAbMY5/YsJ1j3hKPQuQ+H/8Ji+3NUE=;
  b=ASMzhMADV57++5Y1+RZ8m9Owf6pyBRiHPxxtAV+tiqC7EpuRGlvvowg2
   fa8ABfj1S4NjVGADQhotKVyZDmt9lPxWLe/98zQMfVqc4qwB1tBWs9ZCJ
   qiXxAWBE8VeuIpPrDVODDBfRayU8WUSHgPj8Qfwe31BxFy9Me62fPtdhc
   lcbrYQ06V37MrhyGr1EKI1p14v8YMLPOn+PXXf1LyFLTjfIMVdy5iRSCn
   7MlQxuNwcH9rTzp0UDjOhVKHLWaMEeL17Ey8DR84AoeJpPc6V1+dghc4b
   T7Th2q5YWUkDGtKVPWxQVw8BkukUUqjhbpIy7pwUtyfceWrUjUucSQz4A
   Q==;
X-CSE-ConnectionGUID: cj7D5SoOQ0uXj7TuQNGZJA==
X-CSE-MsgGUID: hO/RT+rCQNOPpGaR/el28A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31735169"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31735169"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:30:57 -0700
X-CSE-ConnectionGUID: DBM8N4oWSLa3HNx3L3XneQ==
X-CSE-MsgGUID: CktiV7DpR3KtVdQ5/ghVaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81429552"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 08:30:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:30:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 08:30:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 08:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeJrOr+E1CWxLuqttIgw56TyPsQ6o1Z8hVFk28qyng1fLMDyZVoayJlhGlB7cTViOFsyHzBF5wBqaZtBNqV/ZyQC1zUvTfghGRJrSF9QrFcyEPqC1KXurY4IHMfRDy18DKVWmqdJKL+0/XbnQZdZJOkZATgmMg7p6o/1/hXMFANIUiC8VxKOt5mSlcfj1A1oP0Ca0ZgZKZdgFU5WC6JnDigdgLe5/0L+J2RJULLqYXrq43Vif7/+XXb4kvII9L9d/W0tQwGjKl7Z3NtN1EfaUO1VJVytQxHuqUy9zNrJaoNaMM7RGH2SXlNohckM+HpBMF+OG8guzM+xv+tpaqS84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLFAgssDcFiNfkT89bOevseQN493GMr1SP5yd0js2iQ=;
 b=st4efZQ2pSp+LkX/DAVSTvxk5xynUOIU5k/7nkau+oMAJva4OuECCVkX2SFJ/+fLEWHJ4LF0IZUZnGudDAJpHZ3jqO5wn8NPNpGHgaPEJ4lEhghESUJknBx256vzJIjeL2mupTw0iTMQrS61db1X1rht7RIlX1XAwAamsvX1KTL4ySIO9JsCfw7A7SNgpoBynRjAzrNsVZQDg35VKn5yYKjIRF4+LTb8A5kjS7etSW86ybVaGCW5uAp2H5f7RzvwAItiVLS0Dqv7z73cf96V9MXn8SjTDTMGfJzcp2Bx2f0AMJu68AD+rV6LRJ6+K7NHiFwagOpqU2Fm7vV9oVJoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:30:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 15:30:49 +0000
Date: Thu, 10 Oct 2024 10:30:39 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, "Li,
 Ming" <ming4.li@intel.com>, Robert Moore <robert.moore@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 00/28] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <6707f31f39d8f_4042929469@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <ZwW4yQ11wYkaqdgx@fan>
 <ZwW7E2gSUM8SHAzo@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwW7E2gSUM8SHAzo@fan>
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 06356eea-ffc3-4b8f-954e-08dce94084c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ttxXnJRM4UynOAeTrz22UhT9a7gbO8bnm8pe8ryOU2lWfBskHuWcP7RyFMxZ?=
 =?us-ascii?Q?zhMj1kNjv6WlbsfUYw4OEmhb6QB75W6gE/Oiyv8OaNrSC1MreIK+RilfJHBN?=
 =?us-ascii?Q?3X6qLPL8uRXvv0QPiLX+/WL0T9+o4GD25nveXjBSC4R4lpeUD2ZNhqYJlFX3?=
 =?us-ascii?Q?cG85sxsoREz8NUosRQ/LyJb+sy7uHRKKTm8A3VO6imM6Aa/xIpEkSXH4JqOo?=
 =?us-ascii?Q?agVvInXt/jzztNzL5L8UTlQO6bQ4YYNPCwrW8RjE1bFyUvebb5zMUjr7+ABT?=
 =?us-ascii?Q?eh0X30hkBTC9HpEcbFs+ss7w1vWZqTvKF4U+GVt3ddRI/iFY5bIJIIy1IkDG?=
 =?us-ascii?Q?0QyzKwmDB8dYK5iaXul6LhNfgFS8zQwa8kdIkWAJZ6PS3JdSUBTTSZ5wacQP?=
 =?us-ascii?Q?l2Yyq/wa4wBsZgMSQrm+J/eRJiCuBqYmDbmdZLS5Hv0Kwihg189Jt+g9sSD2?=
 =?us-ascii?Q?Qp6CjuE3rU3h855vA4Bf+rYy25CRHlFKsuf9/6bCgI+z1AUTs9MLXJqSQ+dg?=
 =?us-ascii?Q?IjeXVFavqeLgO872dELtW0iZ7WyYeh60SyZBjbj0fSrlnYGq8VcLiAWlr4BE?=
 =?us-ascii?Q?YxKWJTfOoZWYrmV2bCvulXPEluINU7T0218cg24x0CQw8tKcor/8RctZ5AiJ?=
 =?us-ascii?Q?/ATMlWMm3FINITdsM+P8oQDYGnHPhcpLqDZ3CqVIXNntuOdhk+wT1H8wOn5l?=
 =?us-ascii?Q?UHomYbif9NbdBHjVDaWAJkMVWd9qf4WrhJNJtA0cd3U6hJ13VEHk5P0kYOoN?=
 =?us-ascii?Q?qiYzCKerHxVzLUYVqoYFyuboCKYkf+LVCmcQq7FDARLPCPaa3bOoYvbsADbY?=
 =?us-ascii?Q?i+brBpIuGZGCEMlvr40fn1SY6B0/4vWeAmfGfQg6gioGs++5Me3ixjWiycVI?=
 =?us-ascii?Q?ULBMHe5JM90CmehoAQrDyL20O0lqnrF6CB0TkdjkbLWD+606dex2ckGnZz5z?=
 =?us-ascii?Q?JBJ5uL73bkeFxbc6G0UXoPGLfP2ByRHNciMAtpW1w+K8ykloFm1CqCGuMEND?=
 =?us-ascii?Q?7f09WZqXqy71Wgh3ldZxTxO8UqeLhLwh/VD820UhMp39/t2h9bXZZlR9RZNL?=
 =?us-ascii?Q?1jfs6b0PuR5hkqnELq+FSS17VJ/Bb3H+i4qH65dgnGJwFVJG8QGJGd4W9XRw?=
 =?us-ascii?Q?Rmny8Ub07fmkx+z9uFvjGP8AtXggM6FK0wqLmNI7HO9lhapWyodLNUXwYoHn?=
 =?us-ascii?Q?MI4L36Xp2YVuGxDtaw4y4OqvSuIfmPFEXczY+Nv+eSfgKmRW4YgzYUCSD+BW?=
 =?us-ascii?Q?J3ZGebbZLfoDNkmaO6+6B0IHfYnihbwEk7oK2u1tNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SpFYyHttIye6r2mwV/fdhuYdZYncemHJ1qEN3JX8h199fXckU+VOi09s0ikK?=
 =?us-ascii?Q?j448ucXa+/rzDs5Vv80zjW5O42gaFHDvwt/3hZX+ZFlnmOVA0fMFLTSXDY8k?=
 =?us-ascii?Q?RhSIqbC7QAEx63Y4ukaA5ChON5A8YJBNLFRz+r0+M1VrmpwXEXbY3X7knbBI?=
 =?us-ascii?Q?kIlK+Xd8kuYMGM7yIeFDgPfizz7+bqquF/7r9pDF6KZr072NqgUkstg3sSoN?=
 =?us-ascii?Q?6/4SfXv1w99t10UZXmzgvSWTz7BUyq3QINYgKADXLPam7xZ+O9bCJlqPnwkF?=
 =?us-ascii?Q?W+nfasp2IKRkgUZd1FnOX6HvsGMGvdWDF6PbgMy4P25ozQaXIO3fJiBMUagB?=
 =?us-ascii?Q?n+LeLTmBl0kQrPFOCz1h5yXC+mE2QLJJ0MT7u6a++rwqeJEqrL0uxaj7O1CX?=
 =?us-ascii?Q?85C8qsoEPyZenEBsGOkiINkq1ujQJLecEZLRlfPbw4BgtVEz5DXIcZhGo3qI?=
 =?us-ascii?Q?o3eg5FgiCSZuYOoP5TammRlc1is13UzVDI3KZWlxltJZLM9E/iahJD0s47gj?=
 =?us-ascii?Q?lAmnWHzHz7Si0F/yWxQNOBQW1CX2QSIOCpHSgwxT0FHvqrIs4Q9FSA6Nrmcx?=
 =?us-ascii?Q?4pgGQiH0HT15uN99o21i3e3Gb4r3sfjtrf+9giWUW8wSb76WFmFq3RFGS+bK?=
 =?us-ascii?Q?LW7UahoE+iIj4syMTTbyjsfV0j8ePEVcimzju98zVG8gbB/6pMeBZoSmtECG?=
 =?us-ascii?Q?d9ecPoJBrvG/fJjqs40lPtXN0iQmy9nXDudqxFcjUMj3brqXkgYVBb7JS0pZ?=
 =?us-ascii?Q?1ivr70yboN/gXL0ft9BZ6FYB/ijukOoTvbJMtzYWN7SjsM+ezviFX6endu6g?=
 =?us-ascii?Q?/dM50A0PxN9/M20MC3nAb7KFPiVSou3+qt0xxHACBjBJ7Ie8S9IG6FCw/PgX?=
 =?us-ascii?Q?/FMH/uChc9nsXMTegOH0IE7B/OACrT+YxlrTmVfRAJAiWHlU3jJhi1oCaPC5?=
 =?us-ascii?Q?/gbJgNn3ELmtY7uUGUGFu73mtg9+Mhq5tOpfGfTghqsJGn+9ErYzXN9xOxKs?=
 =?us-ascii?Q?yIRF7uJDYzO7r411hr8GLjiwP8Pe44A4kdmunOAvGS3fGV/hAj5twu4qJZtx?=
 =?us-ascii?Q?lly2r4fqv2qomGV2lEu/qk2bx1jEo8Z+bmctRAPPFXIMUZvBgZDg3urqOTpo?=
 =?us-ascii?Q?AcHiP+8zegJ+UKalQSxHCcCGY8np3AsAEJCopgTwD8h5vV8yUbz3jZnTKNw3?=
 =?us-ascii?Q?ZX8SJOYqlcheFqFVKGUxTjJV7yN6V9yq7ZBzm/agTSjAMi4kWDVE6lluBa9N?=
 =?us-ascii?Q?Z6V/VQJ8/mVMlvqbtNwStpP8OKukO12yyqmBHGA0uDGUvyPmXvW/LMAzhaEC?=
 =?us-ascii?Q?ratWBezYQJwPpoc5wuX5z1OEtoRsiCo4AC6KYcMp4qlE+VSaB35b7VmjbiS/?=
 =?us-ascii?Q?nusvwe7ruGfTpgOZS6oeHFYJsjTfIBFFMlpA5/E/3sPn1EGx2c+kcGfl3FZi?=
 =?us-ascii?Q?D0x/1y5Q45i9x9f5nO2ZRaNxPvHAyWqWaJfglwI8rdZZhRCkuv/QIWzBSEaK?=
 =?us-ascii?Q?8I6nqt/hxeYmxxdt/lQVkqmrbH4zmP76rA04JuLwUicD7eVanTEsqBTqYacj?=
 =?us-ascii?Q?eP/avGM0RCMqbktHBsQ9lxSVlyL11NSLkWqI3wI2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06356eea-ffc3-4b8f-954e-08dce94084c6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:30:49.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D12/TnQ+wP6XSGSTIHtwFoskBw6BbusexTZEdcVQx3xOvYjAOusOhrSRNbUL08QJzSWJpp0zFH051fR+3AWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Tue, Oct 08, 2024 at 03:57:13PM -0700, Fan Ni wrote:
> > On Mon, Oct 07, 2024 at 06:16:06PM -0500, Ira Weiny wrote:
> > > A git tree of this series can be found here:
> > > 
> > > 	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-10-04
> > > 
> > > Series info
> > > ===========
> > > 
> > 
> > Hi Ira,
> > 
> > Based on current DC extent release logic, when the extent to release is
> > in use (for example, created a dax device), no response (4803h) will be sent.
> > Should we send a response with empty extent list instead?
> > 
> > Fan
> 
> Oh. my bad. 4803h does not allow an empty extent list. 

Yep.  It is perfectly reasonable and I think intended that releases are ignored
when in use.  Thanks for reviewing though.  As Ming has pointed out I've got
some issues still to clean up.

Thanks,
Ira

