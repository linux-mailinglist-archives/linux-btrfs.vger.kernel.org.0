Return-Path: <linux-btrfs+bounces-8979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00D9A14D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 23:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FE8283A5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C31D2F46;
	Wed, 16 Oct 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXE+7z7d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358761B6D19;
	Wed, 16 Oct 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114490; cv=fail; b=YZvjbbjianeNjbGWmLsx6x5P9wbA6c2mf1w4TY06MQldcSMe0L7EvtHDY/zar0etLKQytohwwF+BLW/igndozkGnfFwpD8SHomAIlmysIgJqlZRFym5OP7oJmu5KcmquKUnIrXYbazzM4L/j+qkviolj3awVBF7piwOeNjGDlm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114490; c=relaxed/simple;
	bh=ZHvN85X/Mnl066mvlfTVn5gX/TqXxRq8TEug3W7mXLw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qbEE5L4el28Lx3hUTRd273QEVodRBfAsfAomjoV3HKvpvMv3btxWOHWrjColcK9yTO4w8tcWUKi+jmVKSgTpf0v0MQWhcrR5VQRScWjOSs9ryzC5QaDR1qtYQR9xXZnsxaFXsrXBq8ozTT09mYoBGhC6ogCklGtZgq/4adD5KwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXE+7z7d; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729114487; x=1760650487;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZHvN85X/Mnl066mvlfTVn5gX/TqXxRq8TEug3W7mXLw=;
  b=EXE+7z7dczebHiYALmIIIF3/bnHBfXhmi7whGCcA1h9t8rtKt0wgOTgR
   MFyyh/puYjlovWNb74gcSnQ7LswZfdlnXr3OWAxI+CkiIZ0kRjzXMNRbm
   J0cXGSWOG21kc2a0p257v+skt0Wvwi955CYMME/fH9uj7787IBHAZ3e38
   Kt5tQzSGxXtVP8nacsF4CqmQWINJwuI+ojoUY7Wjzl3f+uaolp3Xu3TPL
   m6nBC8UqC4ohYRpMevbWDZUO7eE4jrGP+evLqVw1qKIj+JxIEDcLH6ysE
   a3UIkt/Vd2/NzCrr0WPnGDlno7F2z4VGaUSFeHyol4+RQHtIFJWokJEZc
   w==;
X-CSE-ConnectionGUID: 3u4gGKRIRVGgdjTza9msqw==
X-CSE-MsgGUID: BRi4xMyETLq7DoPeqyZrUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28369791"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28369791"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 14:34:46 -0700
X-CSE-ConnectionGUID: 47IHsr1rQ4iJbG5yiU+Rmw==
X-CSE-MsgGUID: 1kFfxF73Rda+hCR15jpXag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="82889708"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 14:34:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 14:34:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 14:34:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 14:34:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 14:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mskhjgdNnHJxBKSC0/KnJmijVpLekCO/QcjL4Yr3mCPuxo37MKvFp52xyeguuvb6QcFuqeErH61pSB2FKh/Bv3v8h/cOxQ9guWm5+3ftxU3RNKmoNcoMPrVuWM/RyW4iOe2isVfY6FPfIBDFZWN4pbHobYtljWAahrU8vC07SGbgmuyDwg9npnLLwrRcZJrbMn7uONjweKWVvFRC5/MUbvCduAek24KbWXzRI/dIpbh2SJyQDTfUHS/NJgSDMxvlosqXSMggQ+Du1BsBYjl6Pj+jEArH1jukEMHM1lJPbF3zGxJ3sreyzo96Y8N0b03ZYdG3Pj4WZyDNVxmHPIPP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF0hxSU1xP98PzWkhLs41ZdIxQs4Yy5lOKs1Td8Wsnc=;
 b=hFGWZ2+8k9Zn5XXzl1cmTA7e0CxhlM9fOhySLLW84GpNRqNaVpp2FU1uakzRRS8b2RAeztKcdbEH5u60jVLdA3mVmrRU1mOVYUypZ3a8hJSKP6jhO4pNYfLnKaiX28ZoF3fLyj8HLG1VvjvB6J3l7whY0JDQAKnWa7yfduEfjn4n3v3k6kQAVwpL3IKrCAeXXa8p++tZgHtdDhuP1Xdcyy0hv5bwN3D92sA63KmDp/SJ8+FqF38AaeJ7L9uhodg5BUsqMUzZfcKRsR8gcagtjfl5410mlNio59FCdGPv1iib4gRRXZTG/2N1cGv+3pfrCQ7NOVGdpQiUsT4IJVyOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8750.namprd11.prod.outlook.com (2603:10b6:610:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 21:34:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 21:34:42 +0000
Date: Wed, 16 Oct 2024 16:34:32 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 13/28] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <6710316875819_2cee294ec@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>
 <20241010140426.000065aa@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010140426.000065aa@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f63aff2-6b3f-428c-4ca1-08dcee2a58a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/CtqlnS/gkYInyolIBMXYopmE7TQNs22+VFAeCNtB8u0NkXWmScTMsSNETk?=
 =?us-ascii?Q?BreSdnkKLIX5Mj49X13mDE398Fz8kKq04CYI7+9lUjwfm5PMB1rKFoOwpxvS?=
 =?us-ascii?Q?C0M7sSsOxASj6ush4UfmWF3YkpwrykbIimXZZFahHeksS1klN45eZbspQYF7?=
 =?us-ascii?Q?pL+ErUJ0UbdcpDfPbLzlReyZYRNvfNZZzuh8fQfGcczgsIpoyIxJr/2BpMew?=
 =?us-ascii?Q?FLiUDKupghHmZYqqWAoCEgoIk8D4Ac/MYiEBOOXu7iLXtxa5KyLAvPhxZtxK?=
 =?us-ascii?Q?gqEt8EyixThXIaLgcFbCLvbGZPS/OHa77JzLbP/Je2gruCCuQ1BB13QGb7ZI?=
 =?us-ascii?Q?nrVfQ6KOQGhUnEdxg34wFnihKn6LODz+QsO6IahG4i4vqbI1iZU5g6sFo1Ar?=
 =?us-ascii?Q?VeGyCFusza6zCG+V4uQIcV5iz9go7Q0B22aVUFUiClHRnLmaEQPcKBdi/2fe?=
 =?us-ascii?Q?ZsengcLuNDMAqGEYRDUVsvYeohwG+N1kIfzIkKOkjpy6m3x/TB56yK1GnomA?=
 =?us-ascii?Q?dN2TtHwXB3n/k5R2Cb7i93I3U+v3eFyK1gcRKe1IVYGfJFNTtA6REOOh1wST?=
 =?us-ascii?Q?vSfHJq4gJwfgdsEMgIUZR69+Eu905+mp37xR7eTL0ls0R6B9nXrzr+wDJ04h?=
 =?us-ascii?Q?oABM45EDbPRI/EMC72TZoZ48FULapUdqspjFM+/gYvdr0my4UzHZE5tY1ofs?=
 =?us-ascii?Q?WIphrfbmreKDFuaCehY5tQuqIFCd9QOe0CIIoTvtmswB7c6v8oqdI1GQptuq?=
 =?us-ascii?Q?t1CFjlPpo9CGuXqNgfQzhbF+lMTfEbvA1iVp6s9sSFzmr9tkQPPHmAFJ8UFu?=
 =?us-ascii?Q?InzOLKd0T8ymKiQqPTo6V0PWzg6GKeloyKvXvQyoRinPINEWrzGRhApgxBo1?=
 =?us-ascii?Q?16s350nfKzVykhU+TR9raBGkIa9prOoKq2dKDU/tB2NJ62if4b5+pU9noNOI?=
 =?us-ascii?Q?56f8RsadTA+41pWB4/ke2B0rQJqZvg980LcffSkSx9LlVyWKW+FEMgKsoFPn?=
 =?us-ascii?Q?DtZ/1bIljBIgj5OiwMBxd7O1J9Id45u+eOghebpcTmi4ogkvKcTcycDIqO+q?=
 =?us-ascii?Q?iEMG5IQQ1SEvFyrGT7ankdtbKyrITn1F77Mf4W+YbJN1L5TBwEx9HcBKPUnc?=
 =?us-ascii?Q?pOzgU8YsVuEoUZpEX6Xm934gm3Zbl6WdthlVZPi+w6IQjP4fvg1qniSMY2/D?=
 =?us-ascii?Q?FBhmvpc2gLH3Gc8O0WgJJE/UCRVA6FCJ0hEFVZW91cjQgIW5gNXpIkiBek4v?=
 =?us-ascii?Q?WMvzalgleOPTIFGPJqqH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzvGoFZTlqcaY8MKtszLxVGTos8j3HjhjRT3JFEXxBdly/lg0KfQuHq2S/dt?=
 =?us-ascii?Q?1NTv4aDmhxLgBnv8EA6f2XkCigJbN2ytLRJHTtIvsypI9abVfm0KMRSTWMK2?=
 =?us-ascii?Q?rQx7MAsUFfMSZGXvN2L66BE9rueVoptpZOY/C5XLh3V6Z+0W+Uly7FhAzqxP?=
 =?us-ascii?Q?HFHy0d6dckKSIM1TM/cGuHQ4KCZl6uh1LQ+AFJnKjfBJK1wyowTOffgPiX78?=
 =?us-ascii?Q?Q2dFjD/JxfFBKAmc0MGYFOeSM4Kt8lBE1hxNRX+kHaekKdpj/llPGW+w97tp?=
 =?us-ascii?Q?V6R111afUrmyd8Pq09v192WqM2vrFmqd19fudUZmi9cITlFUHXD7EFuyCw2W?=
 =?us-ascii?Q?2X73lktPdlOMysFwoHybWyzEHcZvin6M2WgrvwGwLvXVdEbNYZjHOv1zuv9v?=
 =?us-ascii?Q?qdHQotpmZ6wsNecZUAudyqBAsVb2dBA/MxEpaELjZKpa0TMIdZ1kd1HIpNX4?=
 =?us-ascii?Q?FR8iNg4CEksENfWhomDANl3H5/cOJ3sGkRgO8HFjULHjHUC3r8WuLlkCjNKm?=
 =?us-ascii?Q?AJnIQ7KsBxuMqEkh//OHZrWti8Us6arCNn9+hcSHcB9AL2B5du7ReVA1O+S8?=
 =?us-ascii?Q?9vktdesmVc9COX2xeKeIZqk6Gjww6hvR6Jscg9L8NNZpd2CQOnAn/AE3Xq51?=
 =?us-ascii?Q?u/ka+P5x0NgOnJ5ewcmUr6AhvtgWYKYO9Jl8M4uQdsNzX3gHhGUt9PunY9Z/?=
 =?us-ascii?Q?cNMbGNj6te1kXRDDLmcg6Zq3u9KqEuuXoYKRFrdnIk1Cmyf68VHlBiVyR+gz?=
 =?us-ascii?Q?k442cmf5bOVTi0v7cx8eVCf31jD0dVC6srTOpe6PxLWj9UvUYJ9741e8deO3?=
 =?us-ascii?Q?Q+Zgv4GtVFpihfevaG8nGNaHEcoc4+VAoQ5SbrMKNVjYypVSaWlUmLBkrhg8?=
 =?us-ascii?Q?OGAdFCEpJU9tHL5TsC4Jr0ZrUfz8HfQU4riRwQUUmDj+GDYi/mTwPyACgfZE?=
 =?us-ascii?Q?it6NRj5GGUPkTepdkWdoZ1tsCfkm/ieudpkUHNSW2ylTGqcC0rMGGNUcH/6Q?=
 =?us-ascii?Q?5S0jLr/9Z6dKSp70n7/4E3/kTU9d3aPZpByDCmb9HJRohXIW5FauKwh+7iCH?=
 =?us-ascii?Q?ZHK3mHkadzk/WRWez0VA9LvvqpTht4VRqm3ly+A4y/+8vf9D3hqLEaIckk0Z?=
 =?us-ascii?Q?15ZDkKmTZWCQwuqto62uGRq6yf9GMeWlt1hiR7jqoSSv39gx4ZlXvIT4CFKp?=
 =?us-ascii?Q?dMbef44vHT6Zjn+xebASgAqK6avFvV3UE2mfXbBz4ghIKRE4/U8APtpzOtas?=
 =?us-ascii?Q?vzd//jvu436kekdzjfRsNZc6P/xTdxYnrLyRTX+qn60cznODpH6GaHxVDfI4?=
 =?us-ascii?Q?nnB2+ha7uOnCODCfn59GMxa/oM0naqEpMKUMupAkDsmzDy9jW3zg58wfSy0L?=
 =?us-ascii?Q?0eu+EGTiT02D5gqgManMUqf+BWcDo1PyVOZSnVaAfqH5ZIG0UNtdDWr+WQCz?=
 =?us-ascii?Q?c4Wx8sgmggsdjxvxmspfLMtq8GeaEJDqnOBFhwNsXgBFqsYpURKbLH9wkR4q?=
 =?us-ascii?Q?B6TrXirN9tS8PpzoMAD24tX4aTrjrX8283yel4EGexfzUH1GQ/e3A6V+/Yid?=
 =?us-ascii?Q?y66qjBOuyTmSt9ySQ9J/Z/UQ4ZjEw2D0CM0ZDGOg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f63aff2-6b3f-428c-4ca1-08dcee2a58a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 21:34:42.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUAK/TEZYl3bxH0v5HF7fqmXdYHID0ynj4BzNahL5rZZDNCzVhBJKFhdD2jxIYVfHdKvVjrP9iPRDbUCrFS/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8750
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:19 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> > user space will need to know the details of the DC partitions available.
> > 
> > Expose dynamic capacity capabilities through sysfs.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Some trivial stuff inline that I'm not that bothered about either way.
> 
> Subject to answering Fan's query
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

[snip]

> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 3f5627a1210a..b865eefdb74c 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -54,6 +54,51 @@ Description:
> >  		identically named field in the Identify Memory Device Output
> >  		Payload in the CXL-2.0 specification.
> >  
> > +What:		/sys/bus/cxl/devices/memX/dcY/size
> > +Date:		December, 2024
> > +KernelVersion:	v6.13
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Dynamic Capacity (DC) region information.  Devices only
> > +		export dcY if DCD partition Y is supported.
> > +		dcY/size is the size of each of those partitions.
> > +
> > +What:		/sys/bus/cxl/devices/memX/dcY/read_only
> > +Date:		December, 2024
> > +KernelVersion:	v6.13
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Dynamic Capacity (DC) region information.  Devices only
> > +		export dcY if DCD partition Y is supported.
> > +		dcY/read_only indicates true if the region is exported
> > +		read_only from the device.
> > +
> > +What:		/sys/bus/cxl/devices/memX/dcY/shareable
> > +Date:		December, 2024
> > +KernelVersion:	v6.13
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Dynamic Capacity (DC) region information.  Devices only
> > +		export dcY if DCD partition Y is supported.
> > +		dcY/shareable indicates true if the region is exported
> > +		shareable from the device.
> > +
> > +What:		/sys/bus/cxl/devices/memX/dcY/qos_class
> > +Date:		December, 2024
> > +KernelVersion:	v6.13
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Dynamic Capacity (DC) region information.  Devices only
> > +		export dcY if DCD partition Y is supported.  
> 
> You can document sysfs directories I think, e.g.
> https://elixir.bootlin.com/linux/v6.12-rc2/source/Documentation/ABI/stable/sysfs-devices-node#L32
> so maybe
> 
> What:			/sys/bus/cxl/device/memX/dcY
> Date:		December, 2024
> KernelVersion:	v6.13
> Contact:	linux-cxl@vger.kernel.org
> Description: 
> 		Directory containing Dynamic Capacity (DC) region information.
>                 Devices only export dcY if DCD partition Y is supported.
> 
> What:		/sys/bus/cxl/devices/memX/dcY/qos_class
> Date:		December, 2024
> KernelVersion:	v6.13
> Contact:	linux-cxl@vger.kernel.org
> Description:
> 		For CXL host...
> 
> To avoid the repetition of first bit of docs?

The other docs don't do this.  For example:

	/sys/bus/cxl/devices/memX
	/sys/bus/cxl/devices/memX/ram
	/sys/bus/cxl/devices/memX/pmem

Are not documented like that.  I'm inclined to leave it.

> 
> > +		platforms that support "QoS Telemmetry" this attribute conveys
> > +		a comma delimited list of platform specific cookies that
> > +		identifies a QoS performance class for the persistent partition
> > +		of the CXL mem device. These class-ids can be compared against
> > +		a similar "qos_class" published for a root decoder. While it is
> > +		not required that the endpoints map their local memory-class to
> > +		a matching platform class, mismatches are not recommended and
> > +		there are platform specific performance related side-effects
> > +		that may result. First class-id is displayed.
> >  
> >  What:		/sys/bus/cxl/devices/memX/pmem/qos_class
> >  Date:		May, 2023
> 
> 
> > +static ssize_t show_shareable_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> > +{
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +	return sysfs_emit(buf, "%s\n",
> > +			  str_false_true(mds->dc_region[pos].shareable));
> 
> Fan has already raised that these seem backwards.

Yep fixed.


[snip]

> > +static struct attribute *cxl_memdev_dc##n##_attributes[] = {			\
> > +	&dc##n##_size.attr,							\
> > +	&dc##n##_read_only.attr,						\
> > +	&dc##n##_shareable.attr,						\
> > +	&dc##n##_qos_class.attr,						\
> > +	NULL,									\
> 
> No comma needed on terminator.

Fixed.

> 
> > +};										\
> > +static umode_t cxl_memdev_dc##n##_attr_visible(struct kobject *kobj,		\
> > +					       struct attribute *a,		\
> > +					       int pos)				\
> > +{										\
> > +	struct device *dev = kobj_to_dev(kobj);					\
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
> > +										\
> > +	/* Not a memory device */						\
> > +	if (!mds)								\
> 	if (!to_cxl_memdev_state(cxlmd->cxlds))
> 		return 0;
> 
> I dislike long macros so if we can shave them down that is always good!

Agreed but this was the most straight forward way to deal with this.  I
could perhaps break it up by having a 'master macro' which is made of
smaller macros...  But this works.

> 
> We do have precedence in hdm.c

Not in hdm.c directly but all the 'to_XXX()' calls have a type check.  So
it is modeled that way and is called from other places.

>
> for just checking the type directly so maybe
> 	if (cxlmd->cxlds->type != CXL_DEVTYPE_CLASSMEM)
> 
> but the above is also fine as compiler should be able to figure out it
> doesn't need to do the second half of the inline.

I'm going to leave it.

> 
> 
> > +		return 0;							\
> > +	return a->mode;								\
> > +}										\
> > +static umode_t cxl_memdev_dc##n##_group_visible(struct kobject *kobj)		\
> > +{										\
> > +	struct device *dev = kobj_to_dev(kobj);					\
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
> > +										\
> > +	/* Not a memory device or partition not supported */			\
> > +	if (!mds || n >= mds->nr_dc_region)					\
> > +		return false;							\
> > +	return true;								\
> 
> 	/* Memory device and partition is supported */
> 	return mds && n < mds->nr_dc_region;

Done.
Ira

