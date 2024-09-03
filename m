Return-Path: <linux-btrfs+bounces-7764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0AF96941D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 08:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CC91C2096C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 06:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38C1D6186;
	Tue,  3 Sep 2024 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvwIM2+g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A01CEACB;
	Tue,  3 Sep 2024 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346182; cv=fail; b=cPyaJxws/ygZe9tzwM0EENr+OPCYFi04xym6Gnv658/OkhlPl884O/CuTMDXGOgjoXhFGPjR0qkMPEu5goWKe3WUjYra/zAfwZiCgtOCRZ7LZKc4vpSPXAfT8tWiCgE0j+XZj6EUwUmROQ3Gvwasy93h7K8QHhkIpfXmB3Mesw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346182; c=relaxed/simple;
	bh=KXNVtYCQt33CB2dNcQm8862HhFUtiZEEeFbXUuHFvUo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mg3vFOX1IKhvHxQCdSg/8jVcZEKmjBXOtRILuzWLzZhKQSGbQFQn7K8CzxImt0q8o3dQmnc1gAFDxT0Zyb+A5W12XV3sVL2TRxUCgJvpbvYVXgUgeMnX4mPnkf3r4rake1Ec08UBeOa/XYghV5SkURw+KNffDP1PAKnDz2MCrCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvwIM2+g; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725346180; x=1756882180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KXNVtYCQt33CB2dNcQm8862HhFUtiZEEeFbXUuHFvUo=;
  b=IvwIM2+gCcpsioejFlHqE6MTK65fh2hZWVjs83LleW/sQJXKd8xQD8uO
   ZFnKC6930WleWpnJ+nPgvma3lhUGFH3Q+y1SL2D+i+b9FxA7BPcSMQBVE
   S1fQmp/JPJsOowRhGFSG/vXPsPLjas6GBj4qQt8SIOHs7S2PjEaC71Nkn
   knFYmoxikmC0UOHsx4RhQ88wWGlJrVzFwbZCBmc12NrvkMJ7cEaxfh4l8
   erlKOcXZxo419D9vqEK5hPuHxkSpHc2M5mea9s8sbf86lnlwwS9vCJ4Ao
   uQdDCSmFJ8gxJXoexoMtpjf3FYRKWpgC00CIaFdMSORcsXSeXqYY7Tscg
   Q==;
X-CSE-ConnectionGUID: eTS0I6+RT+2yt2durQOZzA==
X-CSE-MsgGUID: aLehFVBzRnaktSNqAc4C6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24061920"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="24061920"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:49:40 -0700
X-CSE-ConnectionGUID: uJt+C0X0SPeR4gemjeAywg==
X-CSE-MsgGUID: 2zde0t5NTcO+GjyOp9S3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="64809569"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 23:49:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:49:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 23:49:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 23:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWjUKJ8O38YgTlnS72+kWrmrdWPPbGOt33Q+/4yuAZEDeTCdrKFNxQd/JlqyQR327ZqhgR2HD3FdNW1yaKT6H7KJ3CcgSyk+7tWV/EGiCUVXNmp39tyPiehweoIk4Uf+6oCF9hegjHhE2cWdSzfZ0o+QJ9GOvVxE96LivYNgXaR0yV6UQT+xhGhsz+bANeS1x76I0uvE0esBajD8Pw7K0crLug22f3FUmPnhNNOO1RpJnnUh+jwWy+PVq0Vy0K2FB314I+TNfFttMNH1THsaY3wG/HfLIbqUav6ldALRSe4wjPUR1gU2kGeBJazrN8p++rKb9nie+Hj8wUOPP1SaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXNVtYCQt33CB2dNcQm8862HhFUtiZEEeFbXUuHFvUo=;
 b=Ir4xbPHIvoBj3aqmmVDIwCGHoRrU6Dgz4lOnLGft2gLmG7Vp8mVcsyGPFPa+3X+0ukCTOYMVX1ZX8ZXJDUCsROMRLcc+0COekS1n/8/hocxyvV2sVXHbOLhWKeOLs1OwamPSrtHd0psqDCsOnU+J143qjc7lEwRqxcBmgc8M0+PasMf9S1a+maoyOSnF84EfyeH/QxWyAZVL8H8iDVELhRMDqVWbn1EjJcxaPNmYdL45POjPdFp+wkXXBjNokgvLYqFi7ejWv1TZD9FUV5DDFCmpw1LmMJQ9qe6WUuGaOfNlWi9qsIz/Ui2XITb01rkQP6kxpeMM37TK6MozwD/r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 06:49:37 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:49:37 +0000
Message-ID: <1723ffa0-7fca-4270-a6e0-637b53c31758@intel.com>
Date: Tue, 3 Sep 2024 14:49:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/25] cxl/pci: Delay event buffer allocation
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
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
 <20240816-dcd-type2-upstream-v3-4-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-4-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MN6PR11MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 83abda98-6497-4c01-c9c7-08dccbe49387
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amY5aTVMRlpyVnB1ajNOV3F1SWE5QWl0S3d0T1hpTFVvbDRqZTdqOXZQY2ZW?=
 =?utf-8?B?aFJtTlpIVGhKUytLU1M2TjBDU1ZDRGwzZTc0RXFCNkJUclcwdUV5UlNWV0o4?=
 =?utf-8?B?QS9PbEpUcGhHUXBhQ1NDTUR6S1Y1MGFIYWgyNnhpdEkzNS9xd082OStIL3FU?=
 =?utf-8?B?VVMyd1BXSi9razRlcHRTaUEwSElLRWN5ZGR2bEhEeFVhQmF1YkVLeHRMeUdC?=
 =?utf-8?B?eXNjWHVSRnVqUHN2ck5GZlQvT3k1YTQrRFBnWThac0c2UUFna3VmaDUzM294?=
 =?utf-8?B?NWJRRmJWN09TKzVKekw2NFRoRDIweVI0Tll1Yys2SEZVY3Y1R3NkVzcvaVNM?=
 =?utf-8?B?MHh1Mnk2Z0I4aDcrUlRsLzJISTM1b08vKzNWMlFxaWlsUHgydllkZzl0NWtQ?=
 =?utf-8?B?R0hvUDQ0RkFOZWUxWWFDMVl0NzVHWWxkR3NTbjEwUmdNY0puQ1BjbkhGOGEv?=
 =?utf-8?B?QUcxdWVuSENUS0paM1V2RmRaVjBYbFRWQmJMUjl6U25DTjExaXV0ZHNsQnFF?=
 =?utf-8?B?czVFUnlOMzB1c1JMY256T3RaRXFVbGZ4Q3RrT2lOaVJlbm1xQVlaelF5ZnFV?=
 =?utf-8?B?R2JQdk9NYjN1dkR4U3I2d0Z0ckFTSlcvK2FvY1pkMWJlVm5oRnFmOUphUDk2?=
 =?utf-8?B?blRKcHhXRzJJTFdqM0tTN3VyRS9OZlpqeFlTWE5EU1pXR3dqZ1cwSHlBci9O?=
 =?utf-8?B?QzBFRmhXYmsxclhGc0Z0YndVOGgrczdxdjQwV0RGTUMrNFlYQS9WRDdJeHp0?=
 =?utf-8?B?bjhDemMyS0xyNzk0ZU5nOGovSEtvdHZLM3kwOE9QcmkxcVlJcGJPVEx2RnZk?=
 =?utf-8?B?NzVtd01RdnJJNFFweUtMRld2bExZYVUrQWdaY0ZqRUJSaTFCMFdDemRUTkJ4?=
 =?utf-8?B?ejhuODlNbzdnZWZESVV6VHJBRHNuWEgrQUoxVWxlRGhiNUxZUllFV3crVEtO?=
 =?utf-8?B?ZHRaa3BKNzVVODhhb1RPSEtFOTdyeHNCNS9aTFVxdUoyVVNXVjZLU0VUZFp5?=
 =?utf-8?B?Z1RFTEhCTk5BSWNPSjdlRnZpYjFkcEpzTVhMeUoxWXgvRXRqa0MrTnNVRUc5?=
 =?utf-8?B?WmZJUWNuNTlabWxuQnJjZ0FZZ1kyeEp6UVloMU55R2E1U1lvYjZTSEZ0cFlo?=
 =?utf-8?B?czl1eHM2VklhWmVoOWRnaVhqTjZUbGljQVZnM2pUeS82YXJvdFNkTExESzFN?=
 =?utf-8?B?SU9DYS9iODIvTTI4bzBzNFNsVHc0SVNSUUlIcStXMWhFMklCSWxBajd0TDdj?=
 =?utf-8?B?UnZOcERRWXJQSVo3Q252RVRHbEc1RStLeWpzM1pMYU8yWFRZK2NCUE5lRU1i?=
 =?utf-8?B?MUFqYUZMV3lzdkR6SDhOWlZIOWl4RTBZaHNlektseGpCVzE1T2xPTERVS2ZH?=
 =?utf-8?B?b2wxa2FVWjRGaUhXSm1BK3dYSnlLRFRRN3ROZlR4N3llcVdGZkRZb1plNS9T?=
 =?utf-8?B?RUtvVmVLZ1BidHgzU3RSUS9Ddk51NXYyMzZ3NkxQMUxjYkUwSkxpOHNOdWVn?=
 =?utf-8?B?bVMzL21wYXZWWmNqa3dsbjVnL0ZkRUcrZlQ4MEZiQmdRS1E4RlkxaSt2d2dw?=
 =?utf-8?B?ZVpmREtBOEVxSUlJZWhqL1JRSy9wNDdhYmFKOUpMTTh2ZHpYY3BLbGkyMkRD?=
 =?utf-8?B?RWpxTEgzSkZWcTRTZ2JGRzQ4SUFxbGZlSGNicGhNcGFkRXJzWTRkMXNubit6?=
 =?utf-8?B?NXYxQTBVSnJyeDFMazNKeFhvV2tNaXZOYnZXcm45YzczWThPbG1sL2QwaVVj?=
 =?utf-8?B?b2xEbGVtWnVxRkQzUFNBK2xGMnRlRmVHbWpQckJrbHRqK0NGVWNWRzlSUVBG?=
 =?utf-8?B?RHlINHQ5cFRKd1laSHViNWRqRTBZQThwdFY5T2luZm4xYWRmU0VkeDB5b0dt?=
 =?utf-8?Q?Fi4rYS3RhHvZO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajNMUUcyOXlVMENidFFlTmg5QndWLzlybkRJaVBCOWZQSWJaM2x2RlVqWkFh?=
 =?utf-8?B?WkFQVU5SbkhkbkVQVFY3MU1uOXByREIzOVBIM2h0d0F0d2ltVmF6OTRyQ3pF?=
 =?utf-8?B?Vml1ak81TFZONnRTMXp1eE1XcWFqNFZHL2VUU2F0c0ZHaktZNnVCWVR6U2VX?=
 =?utf-8?B?NS9CeWJuVXdPY3FEUitkeC8xQ1hZWGZYa3ZBTFJZRkdTSEVEdjdPenB0SWpy?=
 =?utf-8?B?Tkk0T3VzN2tnVFdrUk11ZUdDR0xLS1d0MEZzRVozbEdjMHAwNDFxSHFlNEZQ?=
 =?utf-8?B?THUrQXhxaU1UZldjWWVsdTV6cXVWV3FEdi9sMjJMZWltZ09LSlU5amNBODVS?=
 =?utf-8?B?czc2aDdjTDRneEFGOXVZS002SU1hWTdSL3NYTnE3OVh6bjZTanMzWU5wUndU?=
 =?utf-8?B?blJGMUo2ckxYemN4YllYRGlEMGVNMzJma2c3SGp3d2VrbzM4elR3NzZpeVZF?=
 =?utf-8?B?L1NEQ056bHg5Mk55czg5bXR1Q1Q2bHNyRkRQOHEwU0R3bXJvUHN0YzBPeUlS?=
 =?utf-8?B?cktHd0ZVdzBsNHJNZEk5N0JGRG5USFduVDFvR3o3YkJtcGNKNTVzUGFGcTkw?=
 =?utf-8?B?dkV0bE5WODhldVZMT2VyVlNhelVDUzFCemlKL1BNSGNuNGI2bUJ1MlZMSFFJ?=
 =?utf-8?B?MFdnOGVYM0E0NjI0UG45Z1VlcjdUTHdMdG9PblYrV0ZIOXozcHc1enMvNUZa?=
 =?utf-8?B?ZElHYkREQ1ZicHdWUTM2ZnUxeFRmS2x0RzNhYkRLV0tsZGNFNER6cGhDdlEx?=
 =?utf-8?B?V0hIU3I5dUI3cEpudEJSUnhKVmx3QWEwQUwzRlVRM3ZuMCsva0xJWUJXbmlY?=
 =?utf-8?B?YTVrNjdWbURoZXdKSVZ3TnNTbHNSUGdtSWl3UXNsdVFENnFreFVPL01jUmxB?=
 =?utf-8?B?TkZBcThPN2x6dTdoL3BpeGRKZ2l1d2VDK1BHQTBHaW1YSGtUbkdZNEV6ZldE?=
 =?utf-8?B?WEtZZ2MvQW41dXRDc3cyZUFTenRpRVhUQUNhNVBjT1BObUt0OHFueXJtSjUx?=
 =?utf-8?B?NHhBODhVZCsxV1k1eklhMXY3TDgybWk4U084T2hGelphSjY5MjBvZEZ1K2o3?=
 =?utf-8?B?dXZFTm1pVVo5YWJVL1lUS3hXQ2lNVE1sZEk4YnVaY2dHTkY1WU1WM01ZYktK?=
 =?utf-8?B?T241VHVOUk5rYnBsd2RlQ0hVRllwQmZLRHNIY0hYUHYvU0M5WTFtZy85YnNt?=
 =?utf-8?B?QzVyZzVQaEdWaTZFSFh3Q1VjR010Vk1CT1lvM0lxekQxK1pHSFpoQThBUUF0?=
 =?utf-8?B?bGFrM1JlMG4reUVXRmtXazBTVkNsaGlUWTMvU2c1M0NEbG1nYzdETVNhM29U?=
 =?utf-8?B?TUFvVlhmQWJWWWIyckRuOTlITVozbFl1WEo4clA0cGFkRU9vdytJQ0VOQXo5?=
 =?utf-8?B?VHZQWWFKczMxak9JbUQycEVJZGdhWjI1Y3kvazJxdXRwdkhUVlVBbndpSW9D?=
 =?utf-8?B?QUJiUWVBQUhqVXJ4VE9JU2gxdno4M1BvcFQ0bFhwOXdaSnNZcnJwVTFFUGVQ?=
 =?utf-8?B?ZUQ0QjNVSjFIL2c0bjdDMStqNmZMeUJ5aXFaZ1NYNm1pWEpiTkhCWjVVMWFy?=
 =?utf-8?B?Z3dmaVU5SjlNc0JvbEpBZEhZbjM5aHdVQU45SE1jNDFuTXVvS1Exenp0aTg1?=
 =?utf-8?B?YzlUb3c3Vi9GODdyYTdkelpIbUxSelpJemVHdzV1OFBGOWN0RlYvbUdvb3pK?=
 =?utf-8?B?Vi91WFN4eUF4MFMxa2lJUnVCTmZoNHRhRWMvRUh6akJjNVREQURBNGhLaUM3?=
 =?utf-8?B?ZGRWOXAycTVpaXhmUmdhWTJQU3lpbnJ3TWZxSUpGbmU4eVVXanBaNmR4aE9t?=
 =?utf-8?B?Q25QWE90T2J6dWtPTDhrenlTTEdPTzl1ZmhIWUYreHVpTU9PVlpyYjJKSTFK?=
 =?utf-8?B?M2dIYTRnQThBelM1TUsxL3pRQ3kzN0o2RCtVOCtQcnVmaURRMFhNRHhJZWU3?=
 =?utf-8?B?YUdoSUthdVdaelVlWGxDNEFDSjdPUGZmS0g1cmw3QndOMElhK1F6bmw4bTZ6?=
 =?utf-8?B?ejdMbmkrZDRFMlVUcHptM1RYSWN1UVRaZDNnSHU0V0NxeTdycjdDZktsM3lp?=
 =?utf-8?B?OS9iTHRCMWduK3J6TTBsVEdwZmF5c3VMWFJkUXFiMCt1aUorTUQ4RW0wZ0ZE?=
 =?utf-8?Q?nfs0XJYWRJL+l/jo5KIKZmm5D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83abda98-6497-4c01-c9c7-08dccbe49387
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:49:37.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3HEl5HEkBA6nuNyTeEk9XpnvjLIUJJXoWZMAFRWoRGETmGlwwDmY3MUNz5E1uEK5t3IxbSAU/eyoRtdsRLrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, Ira Weiny wrote:
> The event buffer does not need to be allocated if something has failed in
> setting up event irq's.
>
> In prep for adjusting event configuration for DCD events move the buffer
> allocation to the end of the event configuration.
>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>



