Return-Path: <linux-btrfs+bounces-7763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D69693DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 08:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD8D1F245DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500451D6798;
	Tue,  3 Sep 2024 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eG9QCGsp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB51D678A;
	Tue,  3 Sep 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345467; cv=fail; b=efNSdl9KHVs9cE9OUE5/Dy2zFrCOnHS+ZHi1sAHpTOH1s1Zjd/S2Ahq570H32NxYeKtUykDx+TBt0gwjOxu4vo4RZLM2LJ9Ohb6UBmHunvSKSwbPhbRgrOnwVxl6SFDrt+/5gG5bLFN+FiFvHDZOVWePFvD8oIhTx5dnZKFYiaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345467; c=relaxed/simple;
	bh=GU69SDGjbiL7+E7fAAovhXzYH4RVIrGrdFLHGQvY2LI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KnNLkAg6cZ/9uGLqa0s/3c+A51QJR4X+ZNJuK6/5xJn41Tdo5d9EB+jGHmczfLfxk7a+MXZX57WMlSIk75rBWwGwJDNHbimz35mCQ1OyAYTazgFs5/8y3fOW6vCcvqeW1CA/EoKovmFKPSr+RqSDxg0A3EZ1dPJ10qwNIKUADIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eG9QCGsp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725345465; x=1756881465;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GU69SDGjbiL7+E7fAAovhXzYH4RVIrGrdFLHGQvY2LI=;
  b=eG9QCGspd2V+qukVr1X3wFymPumk6OmO1OSEKWyUNFZ95Z4csH2mBJ/d
   B3sIO6BoA98JN/b6ecMfnSUm6PCV0WSYRbKO8a0Ws2Hs381sCiXwjQJFw
   XzLsVM5OH9YIcQ2u6Qntzn/Wa9kPX2B11LEpYwewcvLVKO0KYMAA2AbuW
   Kp9UXcLlD73k0HthCXeKt1v/Rw6sWq4rYw60DcrbdoL7ihNvb8VPBDz0Q
   pl7Z0l9HnfQj5IQtRNEEEHcNMIkM0+3dvBn1rgYlfx+ixp1nAhjUPt1FV
   YVFekFYEypGUwoZSjzspBRyWCJ1zIKfXdh8tvEJ0n3Wh7iGlh76eAck1r
   g==;
X-CSE-ConnectionGUID: +vz7njbgT6mVYNT6T6lecg==
X-CSE-MsgGUID: hi+SN3k6Q3SliehqjNrmHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24078332"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="24078332"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:37:44 -0700
X-CSE-ConnectionGUID: wHJnZujLSX2EA1kngTKqOg==
X-CSE-MsgGUID: RLz/jr5DRniSGTkI3YBKNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="69597215"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 23:37:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:37:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 23:37:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 23:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7BOv08j6a6Z8GQ6VpcN0XsafFMBPd016a9sUn+TvdPcIzdKEQBIuEZrrdUYiCg+z8J3i6i26SGG0yBbXmDn6yVvi6o/yVWFaeWxZlUmoELgvnmINC6mFhqJOWJMt5GJpV3CmgzZXvOEoQDWsz/MM2HGvALcI6BY4YZX6TYm1VXld1/9IpBe7ulERkoSkSMMA1mxeBTF212ait5QKu2y117J9n28sWzM0y1AxtJ2/TQ3MkhMc3oSOwfg879WRRXmZ5SPqTjKMlqCU0s1vwSrWcGdGPDr87v8ncl8qWqwgfqWAXN95f/NLDT7j0NaBWUsnijavK0MUFlQPC49jYNrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjckvYscrxkXx8cBj6UxUjuYZl/ymXP0zVLkcFHPnkw=;
 b=PYi/cwHTxDZa1hSqLyJfPrj2oNRT8mz/Ikp1p55dkAROoQr+osCbpuy4Bgs1LQ5Hbmc0l3p2HTV3z+EqHZrQte71irH3pNfpX/TOvqd2I2CI9yvdDVjC4DxuCHvtMxh9iMB3R5f0JP1IWBmz/GOHflYwSjytnLb9mcWynb2dLXUeava6MJqdkI1gRYBV2WlbCVpWlJf8Qq7XigUuWzY+Vt3o8nuqc05f2fOsuyD3KfqTQG0aNupeFrstEMnJtiEj+sIaIRkqyVnlPYqXOikj8zv4F9A9MDyxJ13hMQrPcEeED5tk09WD3z3tEg1KjBJrcwMLCACAXHR/IXNt8qIGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 06:37:35 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:37:34 +0000
Message-ID: <8f8d69fa-f6d4-462e-b476-b812d4138c2a@intel.com>
Date: Tue, 3 Sep 2024 14:37:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/25] cxl/extent: Process DCD events and realize
 region extents
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
 <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SA2PR11MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6eabc9-c74d-45a9-0f8a-08dccbe2e4c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amZXS3QySHlDbTNKRXZGRXR5UVhNOU85enZEeTh0ZWlzcE05NFpOTU02U2FP?=
 =?utf-8?B?SDFzU2pMM0pJK1V6QW9yaVlhTXA1N0J2UGp4VEpzbkNQOEtvVWpHU3djd2RH?=
 =?utf-8?B?MGhtNEowTVFKaFRsNnRveVgxakFWUkRaajFVTjBncmk3RGhXUng3dDgyWnYw?=
 =?utf-8?B?NmRmNklPZi9HWVhCV2ZJaUxTL1k3amkwOHd1NU5rSmJPNjArM1gwaW9ZUllT?=
 =?utf-8?B?SjJrMUM3K29ZM1c3eU8zZzlEMThFckJ2YVJhZk5ueFR3TXNsSTVzR29RMFNk?=
 =?utf-8?B?VFgycEZSSW5hZG9qeEVKMTZHYUUxSnJqNGdHTVJBekZMV1RpT2pOblVqaHdI?=
 =?utf-8?B?SWtLT2swWUx3dUxXTEVXbnZHWU5ac0ZzKzBMcUpZOS9xS3dDQTR6WTVIZkJV?=
 =?utf-8?B?dDFRL05aa0wxWlBUZ2dXK2ZyTVJOT1l0cUZmZ1Z6ZjNLMDZYWUs0U1QydEVr?=
 =?utf-8?B?dFRRM3YxeGxPRVBDYXZKcnpkYkd6WkFoK2hpMjNOZU0ySkQvbktvTDBsaWRG?=
 =?utf-8?B?Z1lMSkJlVjhXWFdjaVNnRkUwSXpvdnZIVjhiaVpidmRaNnFvWDllQTBvNVo5?=
 =?utf-8?B?MTNhcnAyeis4dUMvT0hLSEp4WVZTaldVNmlJUTA3QXlnRys0U1NWZGFXR1lr?=
 =?utf-8?B?Ukh2RVczazZTZzI0REcxYnFqMllwOFNwM1dFN0RsSUp5UFNnNFBHUzNaWUNh?=
 =?utf-8?B?R09nbSt4YlVkRTZ6QStGdzg2MU8rOUs1Yi9RMFdiOXBrS3kwU0NjMVZqRXNL?=
 =?utf-8?B?NG9LbndWN3RmaHF3QjczWm01OW9MSFk5eFVMaSs4RW5jNVo0NUFiQ2dTOTlR?=
 =?utf-8?B?SEgwcmI3V3NwZEFLNVRCYUZBM0wxYnpEczVlNms2bVRhQUV2TVY5QkV0ZVF3?=
 =?utf-8?B?aXcvc0hYZGlmYWF0bGFLQXFXNlhmU3VlV3hpeEVPdWlteVVWaHdickJvSXpy?=
 =?utf-8?B?MGYrR1NleE5LWUxhbU1mOHlaOERYMHJXRkJsYXdIUzYvUkFFbEJzY0tjZEw0?=
 =?utf-8?B?QXZ5eWthQ1dMOUVWY084d2c2TU56Zjg0ckRUbzlmc0RBWnV2a3FPdDZEaTRI?=
 =?utf-8?B?Q1ViaEVXbzJxcEVlN0FuZjhEYkRhQXJmN3FxZUFrTUVSSmU3b0dpYjM1Nlk1?=
 =?utf-8?B?YXJYK1RaME1iSWVwNEg1d3k5MDdUNXZiS2VnbUU2L01iMmtqZG1tc3VZRWg0?=
 =?utf-8?B?enovU2JFL0pRNTNOZytLZDRlRU0yQnIrSTZ5bTB4U3A1b3V0aUdkTmNQNFZ6?=
 =?utf-8?B?MHd4OENQMjhvSm5sSjJTdzB5aWtkQ2tsQWVFVm1KTGJTOHkremN0MXRKWGhm?=
 =?utf-8?B?MTk0akdpQ1Y5UWFDZ3ZUdzhDd0JwdkNpUllyM1lNNFVWTjlsanFrYXR2VUJr?=
 =?utf-8?B?SktYbE9yaTJrZGRmejIxK2R0YkpRNEFMUWIrdkpNU3FRVTVBbEU1cUdzSm0y?=
 =?utf-8?B?YkN5K2o3QXN1MnJCaHFZa3lOUVBwQ3RSZjBlc2c1TXNqMUduak9rc3RLbkor?=
 =?utf-8?B?cXYySFNFdUdiNVhPUlZQY0J5ZU8rejRIcDd1amNqU0M2NWdwZ2IvTlVKQzRN?=
 =?utf-8?B?bDVWVWdmRmoranFFQ0JUQWdhWEZUeGRmVVZSdjNTaGVHZ3MyQUVzSEZzVlQ1?=
 =?utf-8?B?OC9DVVBISElKMkFPV3crWVlXaFdYNjgxb1FRY3dlR0NBZ0t6Z3Z2TTdQbGpr?=
 =?utf-8?B?QnFFQkQ2K1ViWDUyV09SbWhDdjlZTEd3TDhiZ3NYSjZ4YkxxeUtkN1Y3NWtX?=
 =?utf-8?B?dzYvVi9UVi9rRXRDMUgwemdGOUplZUI3TGtKMDhqQ3BsbVc3cnpqQjh2MW01?=
 =?utf-8?B?UG5sbEdQbEk1UUFSZlBHcExRbkNnQkRJRmxxVDlpd0xkcFRNWmt4QytnOXlV?=
 =?utf-8?Q?YiNlPEGVyzMD+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjQwWGJJMnBLZHNhNm1iZ1pPbTBxSThWT1RMRDFHdERudHlFUnh6NjIyVy9Q?=
 =?utf-8?B?TGt2VmRuN0pJKzA3UzRJbGZCTjh4K2xVdmNVcVB6UDJnODJ3UkYzZ25FOUNC?=
 =?utf-8?B?d3p0QVo1cC82ZlFCWUlMMGFGVGJWMXI4NC85ZEpIQ0E4VE9yTFcrbGdrZ0Qz?=
 =?utf-8?B?SkdaSDlvUFBjTGZtVklPNEJlUjlRdFI1WS8ydUlLV2RzSUV2cjhKaWJGVHVa?=
 =?utf-8?B?ZzAwRW1rNmViV21VKzdJNmFkeXNuT2J5TjFOa2tvSTd0dks3VFlKUU41SFE3?=
 =?utf-8?B?MFhxc2pnYVFJRHd0NjNqMUNxNDFTMWlRanJCVGVRS2h4VnRFS3F0dkRYbHhJ?=
 =?utf-8?B?UWlkc29hM29tdDlnNURvSW9tVTlzaldmc1grTEQ5bEh2WHRCSmduTHErNWw2?=
 =?utf-8?B?a0d1REZsQnlQNU83ejFnN2srd0d6bklZT052dG5BREtsbkcxUStLT2FmUzd0?=
 =?utf-8?B?SFUwN3Q3VVRWZjBKMmJDQ3p3aWFxeGdFZ3lxMCs0c0ppYWt2Q05vM2tJcXE5?=
 =?utf-8?B?dWVmdEowRGtQbFRHd1NWWkN6TFpGYlg1K28yVGVad1hYNGtOa0ZudU9DUzZv?=
 =?utf-8?B?c0lVQllpT25SYTYrY01vMk50K2cvU1dSRVFtaHdsMHdkNG1ZSXBNeE9tN0hB?=
 =?utf-8?B?ZjdYeHpTd0w1TVJJMUtUY1J1L25KVVFGL1lNYk95MnpqQUV5dnJtbGxHaThl?=
 =?utf-8?B?YXZGUS9qMml4RUg2ZmdDYWpyL1lXT1BnTmJCdmFIRitmZkdyYkdaaXlvMXp4?=
 =?utf-8?B?K3IySmJDNDhmNVg3OTQ3NFhNYVhnOCtKcmVpMFlmQU5mTVhmQmZiZHZPUVlv?=
 =?utf-8?B?MFFaUkxOd3hWZHFuOGpjZy9TSWxOdCtvQlJOc2syOERYZmVHYW5odUFOVmJ0?=
 =?utf-8?B?VGF1WCtjYUZnVzlyQmRKSWhTU0J2TkVYQlh5bmpzSWZUTkVyVlJLejRQZzg1?=
 =?utf-8?B?NUpSZktNZGU0R1dBSFBUU1NKNGxQaTVFQmVhKzBwNjJEeGZmRWlCQllyaGtB?=
 =?utf-8?B?VVVoT2NMZnRtTDdtaXd4Y0Z2OWFNd3l2OHlNTGpzb2JVZ3hDb2pTT21BaWZq?=
 =?utf-8?B?SWRIN3FuNmxNczJ0akpLdFAzdVpGWSs0T3VIRzRJb3BVSGtNRjhLWXFrRFpK?=
 =?utf-8?B?d2U1SWJNbUhqdWVPd3R5cmpVWUEvckFxSUNNbnBlN2crWEFScWNuVExOYjFU?=
 =?utf-8?B?QmZLVUlqeGZBWW1EbVdPTzNBSTVRZ0RyOVJ3MGtpdC9jNDRHbEVuZGxoVjBD?=
 =?utf-8?B?UEVWQXBMWXFveHlxelY0K1BTN2IwOVh3VDF4OWg4dG5UVXA2RndxSmVZSWdN?=
 =?utf-8?B?d0JDcjU3NldzWnBoN0c5ZkhnSXF5cVJlMHhYNzMyVVR1UDJwR1F6MVFjUTBQ?=
 =?utf-8?B?SHQ5bDF3Nkw3YThUS3g0R0FlWm9KM21mcUJjV1UwWFBwbGp6aXJMa2tZY3Za?=
 =?utf-8?B?UGN3VTJVTmdGUG01UTRTdkQ4Ym5Yd3BRU0NrTUQxcG4yWEZ2cmhxeGJLUG83?=
 =?utf-8?B?bENzTWFram1zb3ZrRjdqNGJuMHNwYkVCY0M1a2p3aEtPR091bEU5c3Jub2Jx?=
 =?utf-8?B?NXh6Yk5FWE1aUmZXME04VWlMeUdaNU1uUXJWWks0OHBRaWk5bDlMQm9aWWM5?=
 =?utf-8?B?R3Zpd3dUYmZwTFoyN0VrVDJIT1dIOGtmaU9NQ2lINFpINmVKN3BKSlJHWkhw?=
 =?utf-8?B?T0ZhU1lLOU4rMnNRRHM0RVFJZUFOM3MwS2ptQk9ad0ZaNkRkZlRDUzJNR3Mv?=
 =?utf-8?B?L2R4ankxUFBFN3huc2FUY056Nyt2UnppUW8yR05kZmZmYm1wK3Qzb0J4bllj?=
 =?utf-8?B?MllGcWRzUUpWUzVBcWpMZ2JLZTVwUWo2aHVjZWdWdGRMOHh2VEZEcW9YZHJy?=
 =?utf-8?B?OHFXeEZIWlpVL1BuYjEzUU9lV2dKVFE3b0FGZHZmVHdqT2JkUkNEN3lMb2hq?=
 =?utf-8?B?S2daWkJuanNQVllSODg0WlM0eEhkdXJydnI4SE1EL3EzRHJDWFU4QUE2Uktw?=
 =?utf-8?B?eVZHWXcvM1hwM3VEdGhIWHRvUUJaN0d1WCtjMWhYYlM3SmpYb1NPbGZPQ241?=
 =?utf-8?B?WWFWZ2pZOWxqM2NNMjBMS1Jlbm0yRUtmdEZEUTdUUlVWMmhRaTVqT2krc1pW?=
 =?utf-8?Q?woG7JgtejBtd7ud30RfZitYIh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6eabc9-c74d-45a9-0f8a-08dccbe2e4c1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:37:34.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QYkaaRquc1QIiiYGJnVWGAi6P4TLCX8WyUDIXTEjXINML+wAHZovrSaOBaUy4ecc3LYYCIczQwqZ8RVNaPRrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
>
> A dynamic capacity device (DCD) sends events to signal the host for
> changes in the availability of Dynamic Capacity (DC) memory.  These
> events contain extents describing a DPA range and meta data for memory
> to be added or removed.  Events may be sent from the device at any time.
>
> Three types of events can be signaled, Add, Release, and Force Release.
>
> On add, the host may accept or reject the memory being offered.  If no
> region exists, or the extent is invalid, the extent should be rejected.
> Add extent events may be grouped by a 'more' bit which indicates those
> extents should be processed as a group.
>
> On remove, the host can delay the response until the host is safely not
> using the memory.  If no region exists the release can be sent
> immediately.  The host may also release extents (or partial extents) at
> any time.  Thus the 'more' bit grouping of release events is of less
> value and can be ignored in favor of sending multiple release capacity
> responses for groups of release events.
>
> Force removal is intended as a mechanism between the FM and the device
> and intended only when the host is unresponsive, out of sync, or
> otherwise broken.  Purposely ignore force removal events.
>
> Regions are made up of one or more devices which may be surfacing memory
> to the host.  Once all devices in a region have surfaced an extent the
> region can expose a corresponding extent for the user to consume.
> Without interleaving a device extent forms a 1:1 relationship with the
> region extent.  Immediately surface a region extent upon getting a
> device extent.
>
> Per the specification the device is allowed to offer or remove extents
> at any time.  However, anticipated use cases can expect extents to be
> offered, accepted, and removed in well defined chunks.
>
> Simplify extent tracking with the following restrictions.
>
> 	1) Flag for removal any extent which overlaps a requested
> 	   release range.
> 	2) Refuse the offer of extents which overlap already accepted
> 	   memory ranges.
> 	3) Accept again a range which has already been accepted by the
> 	   host.  (It is likely the device has an error because it
> 	   should already know that this range was accepted.  But from
> 	   the host point of view it is safe to acknowledge that
> 	   acceptance again.)
>
> Management of the region extent devices must be synchronized with
> potential uses of the memory within the DAX layer.  Create region extent
> devices as children of the cxl_dax_region device such that the DAX
> region driver can co-drive them and synchronize with the DAX layer.
> Synchronization and management is handled in a subsequent patch.
>
> Process DCD events and create region devices.
>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes:
> [iweiny: combine this with the extent surface patches to better show the
>          lifetime extent objects in review]
> [iweiny: clean up commit message.]
> [iweiny: move extent verification of the 'read extents on region
>          creation' to this patch]
> [iweiny: Provide for a common path for extent realization between an add
> 	 event and adding existing extents.]
> [iweiny: Persist a check that an extent is within an endpoint decoder]
> [iweiny: reduce exported and non-static calls]
> [iweiny: use %par]
>
> 	<Combined comments from the old patches which were addressed>
>
> [Jonathan: implement the more bit with a simple algorithm which accepts
> 	   all extents it can.
> 	   Also include the response more bit to prevent payload
> 	   overflow]
> [Fan: Do not error if a contained extent is added.]
> [Jonathan: allocate ida after kzalloc]
> [iweiny: fix ida resource leak]
> [fan/djiang: remove unneeded memset]
> [djiang: fix indentation]
> [Jonathan: Fix indentation]
> [Jonathan/djbw: make tag a uuid]
> [djbw: create helper calc_hpa_range() straight away]
> [djbw: Allow for multiple cxled_extents per region_extent]
> [djbw: s/cxl_ed/cxled]
> [djbw: s/cxl_release_ed_extent/cxled_release_extent/]
> [djbw: s/reg_ext/region_extent/]
> [djbw: s/dc_extent/extent/]
> [Gregory/djbw: reject shared extents]
> [iweiny: predicate extent.c compile on CONFIG_CXL_REGION]
> ---
>  drivers/cxl/core/Makefile |   2 +-
>  drivers/cxl/core/core.h   |  13 ++
>  drivers/cxl/core/extent.c | 345 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c   | 268 ++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c |   6 +
>  drivers/cxl/cxl.h         |  52 ++++++-
>  drivers/cxl/cxlmem.h      |  26 ++++
>  include/linux/cxl-event.h |  32 +++++
>  tools/testing/cxl/Kbuild  |   3 +-
>  9 files changed, 743 insertions(+), 4 deletions(-)
[...]
> +
> +static bool extents_contain(struct cxl_dax_region *cxlr_dax,
> +			    struct cxl_endpoint_decoder *cxled,
> +			    struct range *new_range)
> +{
> +	struct device *extent_device;
> +	struct match_data md = {
> +		.cxled = cxled,
> +		.new_range = new_range,
> +	};
> +
> +	extent_device = device_find_child(&cxlr_dax->dev, &md, match_contains);

Is it better to use __free(put_device) here to drop below 'put_device(extent_device)'?


> +	if (!extent_device)
> +		return false;
> +
> +	put_device(extent_device);
> +	return true;
> +}
> +
> +static int match_overlaps(struct device *dev, void *data)
> +{
> +	struct region_extent *region_extent = to_region_extent(dev);
> +	struct match_data *md = data;
> +	struct cxled_extent *entry;
> +	unsigned long index;
> +
> +	if (!region_extent)
> +		return 0;
> +
> +	xa_for_each(&region_extent->decoder_extents, index, entry) {
> +		if (md->cxled == entry->cxled &&
> +		    range_overlaps(&entry->dpa_range, md->new_range))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool extents_overlap(struct cxl_dax_region *cxlr_dax,
> +			    struct cxl_endpoint_decoder *cxled,
> +			    struct range *new_range)
> +{
> +	struct device *extent_device;
> +	struct match_data md = {
> +		.cxled = cxled,
> +		.new_range = new_range,
> +	};
> +
> +	extent_device = device_find_child(&cxlr_dax->dev, &md, match_overlaps);

Same as above.


> +	if (!extent_device)
> +		return false;
> +
> +	put_device(extent_device);
> +	return true;
> +}
> +
> +static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
> +			   struct cxl_dax_region *cxlr_dax,
> +			   struct range *dpa_range,
> +			   struct range *hpa_range)
> +{
> +	resource_size_t dpa_offset, hpa;
> +
> +	dpa_offset = dpa_range->start - cxled->dpa_res->start;
> +	hpa = cxled->cxld.hpa_range.start + dpa_offset;
> +
> +	hpa_range->start = hpa - cxlr_dax->hpa_range.start;
> +	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
> +}
> +
> +static int cxlr_rm_extent(struct device *dev, void *data)
> +{
> +	struct region_extent *region_extent = to_region_extent(dev);
> +	struct range *region_hpa_range = data;
> +
> +	if (!region_extent)
> +		return 0;
> +
> +	/*
> +	 * Any extent which 'touches' the released range is removed.
> +	 */
> +	if (range_overlaps(region_hpa_range, &region_extent->hpa_range)) {
> +		dev_dbg(dev, "Remove region extent HPA %par\n",
> +			&region_extent->hpa_range);
> +		region_rm_extent(region_extent);
> +	}
> +	return 0;
> +}
> +
> +int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> +{
> +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range hpa_range, dpa_range;
> +	struct cxl_region *cxlr;
> +
> +	dpa_range = (struct range) {
> +		.start = start_dpa,
> +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> +	};
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> +	if (!cxlr) {
> +		memdev_release_extent(mds, &dpa_range);
> +		return -ENXIO;
> +	}
> +
> +	calc_hpa_range(cxled, cxlr->cxlr_dax, &dpa_range, &hpa_range);
> +
> +	/* Remove region extents which overlap */
> +	return device_for_each_child(&cxlr->cxlr_dax->dev, &hpa_range,
> +				     cxlr_rm_extent);
> +}
> +
> +static int cxlr_add_extent(struct cxl_dax_region *cxlr_dax,
> +			   struct cxl_endpoint_decoder *cxled,
> +			   struct cxled_extent *ed_extent)
> +{
> +	struct region_extent *region_extent;
> +	struct range hpa_range;
> +	int rc;
> +
> +	calc_hpa_range(cxled, cxlr_dax, &ed_extent->dpa_range, &hpa_range);
> +
> +	region_extent = alloc_region_extent(cxlr_dax, &hpa_range, ed_extent->tag);
> +	if (IS_ERR(region_extent))
> +		return PTR_ERR(region_extent);
> +
> +	rc = xa_insert(&region_extent->decoder_extents, (unsigned long)ed_extent, ed_extent,
> +		       GFP_KERNEL);
> +	if (rc) {
> +		free_region_extent(region_extent);
> +		return rc;
> +	}
> +
> +	/* device model handles freeing region_extent */
> +	return online_region_extent(region_extent);
> +}
> +
> +/* Callers are expected to ensure cxled has been attached to a region */
> +int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> +{
> +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range ed_range, ext_range;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct cxled_extent *ed_extent;
> +	struct cxl_region *cxlr;
> +	struct device *dev;
> +
> +	ext_range = (struct range) {
> +		.start = start_dpa,
> +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> +	};
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> +	if (!cxlr)
> +		return -ENXIO;
> +
> +	cxlr_dax = cxled->cxld.region->cxlr_dax;
> +	dev = &cxled->cxld.dev;
> +	ed_range = (struct range) {
> +		.start = cxled->dpa_res->start,
> +		.end = cxled->dpa_res->end,
> +	};
> +
> +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent %par\n",
> +		cxled->dpa_res, &ext_range);
> +
> +	if (!range_contains(&ed_range, &ext_range)) {
> +		dev_err_ratelimited(dev,
> +				    "DC extent DPA %par (%*phC) is not fully in ED %par\n",
> +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> +				    extent->tag, &ed_range);
> +		return -ENXIO;
> +	}
> +
> +	if (extents_contain(cxlr_dax, cxled, &ext_range))
> +		return 0;
> +
> +	if (extents_overlap(cxlr_dax, cxled, &ext_range))
> +		return -ENXIO;
> +
> +	ed_extent = kzalloc(sizeof(*ed_extent), GFP_KERNEL);
> +	if (!ed_extent)
> +		return -ENOMEM;
> +
> +	ed_extent->cxled = cxled;
> +	ed_extent->dpa_range = ext_range;
> +	memcpy(ed_extent->tag, extent->tag, CXL_EXTENT_TAG_LEN);
> +
> +	dev_dbg(dev, "Add extent %par (%*phC)\n", &ed_extent->dpa_range,
> +		CXL_EXTENT_TAG_LEN, ed_extent->tag);
> +
> +	return cxlr_add_extent(cxlr_dax, cxled, ed_extent);
> +}
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 01a447aaa1b1..f629ad7488ac 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -882,6 +882,48 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> +			       struct cxl_extent *extent)
> +{
> +	u64 start = le64_to_cpu(extent->start_dpa);
> +	u64 length = le64_to_cpu(extent->length);
> +	struct device *dev = mds->cxlds.dev;
> +
> +	struct range ext_range = (struct range){
> +		.start = start,
> +		.end = start + length - 1,
> +	};
> +
> +	if (le16_to_cpu(extent->shared_extn_seq) != 0) {
> +		dev_err_ratelimited(dev,
> +				    "DC extent DPA %par (%*phC) can not be shared\n",
> +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> +				    extent->tag);
> +		return -ENXIO;
> +	}
> +
> +	/* Extents must not cross DC region boundary's */
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +		struct range region_range = (struct range) {
> +			.start = dcr->base,
> +			.end = dcr->base + dcr->decode_len - 1,
> +		};
> +
> +		if (range_contains(&region_range, &ext_range)) {
> +			dev_dbg(dev, "DC extent DPA %par (DCR:%d:%#llx)(%*phC)\n",
> +				&ext_range, i, start - dcr->base,
> +				CXL_EXTENT_TAG_LEN, extent->tag);
> +			return 0;
> +		}
> +	}
> +
> +	dev_err_ratelimited(dev,
> +			    "DC extent DPA %par (%*phC) is not in any DC region\n",
> +			    &ext_range, CXL_EXTENT_TAG_LEN, extent->tag);
> +	return -ENXIO;
> +}
> +
>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -1009,6 +1051,207 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> +				struct xarray *extent_array, int cnt)
> +{
> +	struct cxl_mbox_dc_response *p;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_extent *extent;
> +	unsigned long index;
> +	u32 pl_index;
> +	int rc = 0;
> +
> +	size_t pl_size = struct_size(p, extent_list, cnt);
> +	u32 max_extents = cnt;
> +
> +	/* May have to use more bit on response. */
> +	if (pl_size > mds->payload_size) {
> +		max_extents = (mds->payload_size - sizeof(*p)) /
> +			      sizeof(struct updated_extent_list);
> +		pl_size = struct_size(p, extent_list, max_extents);
> +	}
> +
> +	struct cxl_mbox_dc_response *response __free(kfree) =
> +						kzalloc(pl_size, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	pl_index = 0;
> +	xa_for_each(extent_array, index, extent) {
> +
> +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> +		response->extent_list[pl_index].length = extent->length;
> +		pl_index++;
> +		response->extent_list_size = cpu_to_le32(pl_index);
> +
> +		if (pl_index == max_extents) {
> +			mbox_cmd = (struct cxl_mbox_cmd) {
> +				.opcode = opcode,
> +				.size_in = struct_size(response, extent_list,
> +						       pl_index),
> +				.payload_in = response,
> +			};
> +
> +			response->flags = 0;
> +			if (pl_index < cnt)
> +				response->flags &= CXL_DCD_EVENT_MORE;

Should "response->flags |= CXL_DCD_EVENT_MORE"?

And seems like there is a bug if the value of 'cnt' is double the value of 'max_extents'. the response command will be sent in this xa_for_each() scope twice, and CXL_DCD_EVENT_MORE will be set for both times. because 'pl_index < cnt' is always true.


> +
> +			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +			if (rc)
> +				return rc;
> +			pl_index = 0;
> +		}
> +	}
> +
> +	if (pl_index) {
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = opcode,
> +			.size_in = struct_size(response, extent_list,
> +					       pl_index),
> +			.payload_in = response,
> +		};
> +
> +		response->flags = 0;
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	}
> +
> +	return rc;
> +}
> +

