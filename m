Return-Path: <linux-btrfs+bounces-7772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A270D9694E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7836B23044
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B9F200123;
	Tue,  3 Sep 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/q0t2qE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FA1DAC72;
	Tue,  3 Sep 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347461; cv=fail; b=dWS6o1m8jI7/4Tj4q6xqqBQFYRcklF0cKKqvoitkt1rxZCPrceBom4Sp1AEJOtXGrA9aR/F1xUD8vJ/m5nZZYM/BvJiJHeIKaSBX9rM7YAXQfn90QsTzeLp+4QZ7lCRu8/WxT9qksQSC3lSEShQxZXL730GS+NKGYOKB3HeGNQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347461; c=relaxed/simple;
	bh=C0LvU62nALrTFtYbieXotdBz5BAHXR5WSliWBROaiWY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BC1OtBtD82xls27IFOzEPnapDh0QLIK2CzaZ4m4DeD8cLoeBWeAA/ezyrduPhUScai/Bw4k31GsyiiaqOObBFrZMZdVlHWW9GjYnn9MVUpSVlTZHbpqm5Y96rMKRQp5uEjnLFwRDYm916xDRIaZ/ON1u2EMkL0IYCZCNUfOoV88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/q0t2qE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725347460; x=1756883460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C0LvU62nALrTFtYbieXotdBz5BAHXR5WSliWBROaiWY=;
  b=C/q0t2qEFrccJfVzr5NKk+5R7bAnX2b44U8nvEYMK0xubWK2ItrQ5pH+
   NE89VUe7YYI6kb8xCMyRI9qBaOGYbGxJIb1a3wK0ppxffWIFbTW4iXySG
   FSdBy0BB1IzyXtu0JH1ygmeRzIcq5v+0q5FTYvumUZq9YFct8Uwkm9z2e
   DcT/7gDbIvdtSClxLi4g2c/YPjkkvsLaQXl8ClB6AMiXIhsW5twoFFcjH
   x4WwPnRrBCWB8Bk1fO/XL+w+t7P3CmMNy3pRU62/kZiBgcVc217uLkRX1
   fqOwH3dTJuTGYWAFLoGHtMuLq9egpVZQXTkQsk+45Fg4EDquHShhINLMK
   g==;
X-CSE-ConnectionGUID: dMlwygSuS8a4uysS7FwRXQ==
X-CSE-MsgGUID: t37QtOzAQD2hLg84aEvMEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23442239"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="23442239"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 00:10:57 -0700
X-CSE-ConnectionGUID: xudrnOjEQYCxSckCjhI7AA==
X-CSE-MsgGUID: Q8Nt2PndQBuTsnKgbWuWdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="95617083"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 00:10:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 00:10:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 00:10:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 00:10:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0P246Da83Ng4scSqj+3r4fiiCSuq+wwWbNrNlItVUf+g7LOtfEuvO2KyVjBCTzLNsYN0BPBVOyqVVr0cBKJ5NZjqrr7gT5iGjk6VpC07Bm8Ewpt/EyVHFdzfIACM4kUHmgDkGIaTS8F02/W4fy3qM4dsQL8O/4fhDU3YNPmFi5s4NI8IrroxnQ6TXHVon/t7GuwHQM4C8S7ih21viKzUD/leOdg2pcN62MmO7y4N487eNZ4NMQxg7WPqwZnZ+sp36v1mr6XfX9ywbJGxWhMdvi8tj8nebgwJukibb0wSpq8gCuRWBFZmuqxAoxVIwlRrAAJ6kR2CsJLw3o5J6tqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgzTcONnU6qMtiRVzQPYOhhIjI/IKrWl0YMimFW91Es=;
 b=KanK/iFTYH1AE9uzv4Aa/tgWJp+l5+9RBSo67FtY5Eu9cdvCXw+FNI/Lwz8W2Xao30laJ0jbizkkcmkBunU8OhHoCUU8oYKPVUr1iQDZVPtTxlTLhv1Dl2p9AjWC/E1JtoNyZkENkyV5GbchpebYbz7FQ6LOkfvhjJ4mh2JGsS9/4Ymhf0HbALr4FIQwS5IdnhNJ/yf4CFyJ02st+JWEXjucMPsmTb8R6vKg5NdWYuOVmkP1Gs2Onp0XpoaP0TyVAfF+zHmTmAz9A/v2cGBEb9LXa6GWWglD5mYFZal/5oy/mHABTH9q14nNnGJhocCBpNQzQDj8OHnDKCeMydF97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:10:49 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:10:49 +0000
Message-ID: <ad874bbe-7e56-4a2b-b924-c1595aab5c65@intel.com>
Date: Tue, 3 Sep 2024 15:10:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/25] cxl/core: Return endpoint decoder information
 from region search
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
 <20240816-dcd-type2-upstream-v3-17-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-17-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ff8154-a9bf-4140-3aa7-08dccbe789d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzdrUms0SXVnc2NoUG5DQnVKV1hqbUdsbDdRdnB5cUE5YTB5SWRBSFFPbDB2?=
 =?utf-8?B?a0VZWUdkaWJjRlRXQWFIMXRsb2JaM2dzSEZlbExObTcvRVVyQVRINklZSjRI?=
 =?utf-8?B?eGZHS2ZheXlXUjVxMHUwVDZwVEh0bmNxbXBaQkpPWEg3MEU4V3NVR29QdUtH?=
 =?utf-8?B?ZzRPUHVuSDNRVndUNnFRWERXYVhVY0ZKbEo2OUxXcjg5WjJjR3AvUGRQOEFB?=
 =?utf-8?B?VGxDMFhiUCtNU29tS2p1NjNhZ0x5OFdWZUZTQXJxN3hNU0RYMGFTbDJDT1ls?=
 =?utf-8?B?d1pET1JYNjRBc3FtcEFjakl0UlBLWU9lQUN5SDVjTjg0Ky9kQzVaaVBHd2t0?=
 =?utf-8?B?NEtrRmgxNG9LQlIzNUVoNlZMUXA2c1poTDhoWmJUMWcrT09lMzFmNDFPYVA1?=
 =?utf-8?B?ZmJMNGs3TEVZZXhoZE9HeHRBQmJGVjN4SE1YcDF3Vjh2bisxcDQzSzJhYVhY?=
 =?utf-8?B?RktmMW5YSFdVeURoVDNLWHVLZGd1c1JkM004SU5vQ2txaWVaZ1RWekl0azVj?=
 =?utf-8?B?RTMveVVTTUlBRENTN3lUa2MzL1FiczBFVWRvcmJuRzdwZzZSZStNd2JLRzVU?=
 =?utf-8?B?K1FHR09yNmF0QjVxWllvbXQyMHlodUM2OUI2dlcrUEFna3hHYVpuZnd6WlQ2?=
 =?utf-8?B?NHBJakhvTXg4UnN4SzNKdE1LTE9IOGk5VWRKVXRWcngwQ3p1SE55bk0rdVc4?=
 =?utf-8?B?ZFBkenBSZEVKc0dMZzhEZkd4WHFzMFEzandraXVjL2wzSHNHSWZRVmJiVFFv?=
 =?utf-8?B?VlVBL3prWW9FdWdhOTFnR3RkUVZ2ODRKTnRvUXFLZXIzUFlZL2k2MldCSXpG?=
 =?utf-8?B?UUQyOVhTOUUyWGZZR2JSZ2FvVE9nTjM5elJjYjBEdkVKbkphUVQwWUpVWDJx?=
 =?utf-8?B?Wmh6MFFkd2pSMUtFZ21pY1EycmVMTUdiYXFsQlVWMWtvam9RdG9pRnNuNkhi?=
 =?utf-8?B?eTJCMmhQcUJPTDFadG1QTHRhRVowNktjODJ3MVd3d0t2SXAvL0NBYnJuS0Ri?=
 =?utf-8?B?d2VxS1Q5Y01iMTV6dTlTRm1DMzAvL0JnTnByaUJRaWw2VXlrV2RlM0E5dTVW?=
 =?utf-8?B?a2F1djkrWHdRWDA2SkxIQnRMWVEzTDU0S3lNU2M5TDVnVTlveEhlSDA1Uko2?=
 =?utf-8?B?K04yaFlLN0wvcEdPRWZPWVgwMitxUFczWW40R0p3SlpyQzdENGVFUCtCTDdr?=
 =?utf-8?B?czJtdStEMVN1RmxVZEhZWUJBRWtDVFlyOHVJMk50T2VSRXFtSTJRT0NzS1Ft?=
 =?utf-8?B?dTdXWnNCRUlZM3QrYzRnNHB5Qy9HRlhRMTd0YzlhcVd6VjVuaE82NHdIN2xG?=
 =?utf-8?B?cWM2YklyM2cxK1RSTlpKZk4wS2J6bCtQYWpsUUdHL05TZnZ6aDg2RFlIcFlG?=
 =?utf-8?B?NURhMlZhNklaaE53MFVoTysydlpIU2dRNEp3OUlTUjFIOTdpeFdMeUtMS1ZW?=
 =?utf-8?B?NStxM0hhd044bmFQUERQcllGUkZHOStya205WVRjOWRkajZlaWMrN0UzOHpL?=
 =?utf-8?B?STVZcjgrM2lyUjFnWjVJQkpXbjRST2JUczRUNHF4RmNsQjIweFlTV3l4K3pT?=
 =?utf-8?B?WncrOFBiV3NUU2hQVVNKTXZGNDkvazc1RTZPN2lnOTJYcXRVUWdvNm5EMWgw?=
 =?utf-8?B?VXhPRGdBM0FsNFVyMzBydUJsWS96M25TQ2JuM0g1Lys5US9wd20xWWxPc3VU?=
 =?utf-8?B?L2hRM1d3S3d2TDMvWmp1SjBwZDUyL2NKSXBSbzFsaDl4K3hYYldLTWJIVTdP?=
 =?utf-8?B?cWNVVVRObG5vNEJ1cDUzd3ZyUC9XQ205cVlMdGNKcTA0QVN0Y21ocHgrR1Zq?=
 =?utf-8?B?TzE2T3RrV2drWnNxNVczemd2MlcvaVRVMklBQ3NRUlQvRU93RnBjODJ1dUUx?=
 =?utf-8?Q?E6EasA6Kt91yW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmYxWEhxR2lCWDJ2Y1RpR3I0RnhTa1JmVHRDQmJaaVJIYnNWV255V2dqU2RS?=
 =?utf-8?B?alVLWVNvK1FCWVBRVmppeGJtV1lOSDlRbGVST3RwbGROSVd5c3E4QlFmWjhu?=
 =?utf-8?B?N2VuYXNRZkJLcTJrazVxb0RmekEwc20zYy85L0lCSk5jTGhDKzBjOUpZY3dV?=
 =?utf-8?B?dHdDZ0JqTnlGOUpSVTJuQXBtUXlyNG96TU1pUk03Y1NlRzQ0Y1UvU3R3emt6?=
 =?utf-8?B?YjEwSjBrdDBjd3M3RllQNmxLelNleXJDL1V6K1RObmlpZWN0RzM3dFBpNlE2?=
 =?utf-8?B?SG9jRUltNXN2MGFhSFVKVUl3bXpxMm5EZ0hvY1Z2ZCtWa2ppYXNRRkl4UnUv?=
 =?utf-8?B?NDZPQTFJYi9XQ0RYZkk5YWdWVnV0eE5wUUphVkZhZEZDY2IxVUdRWXE0OGdJ?=
 =?utf-8?B?eFJyOWNoRTVlRmN3eDEreW5nRzVscEszMC9sVFhKR1ZhMHpnNGFpak9nYkl0?=
 =?utf-8?B?WXNwemgzTUVaanpuUmFxdnBac2VOTVpsdFpNNHlEMStyZGNIRlVJdUY3SlRH?=
 =?utf-8?B?bEV4UlZ5ckltNGQ4RUJaUjc1V2g0N1ZXTVdUQytEc045R3AxT2h5bkl6djVq?=
 =?utf-8?B?N0VBTXN3ZmplNmtybUJqNFlCR2pQd09iVlcxdVcxQlBDS0dRc2YwL0o4cjRT?=
 =?utf-8?B?SDRjeUpxcm1PZU9naXRUVEI4TkpweFpoTFRvbHB2NlhyVGQ1VU9pc084Qmlr?=
 =?utf-8?B?V1hhS25xWHU4K3JGanU5ZDh0b1ZVMnRsTUxxb0pOR1dNai8wZmR5NkMvUXN5?=
 =?utf-8?B?L3JFamlCbWh3MXFvYmxBeXJFaDlmdG9Zcnozb2pLdG9mOG1yN1E5dVh0TVhy?=
 =?utf-8?B?aTJIVUFwTm9yL2s3MStzNHlKRjRHM0l2azcwcnNUbCtKQ3pLZHVMMklkSWto?=
 =?utf-8?B?WjErNmhNYUNRYlRzN0F1dElXcFB4b29ocGcycnRFcGNTR3NBNmY5QmRBVDB4?=
 =?utf-8?B?NGtvaUpRdVN1TVo4SkxwamJBc1l6WnpUSG5SZHk2UGtibHFtQ2c1MjBDb0RE?=
 =?utf-8?B?ajhnL3FsUXNJUEJNQVhSbkdNczhYKy9rYld1eU1tWkpGTVR4VnVpcHJBSEN0?=
 =?utf-8?B?UlFSWVpRQ3ordEhJRWhUajlhbGRQQWFTZW5od2I0VDlNVU5UY0ZadEt1USta?=
 =?utf-8?B?TWJqQ29VZjl4QzVIanBELzZLZGUyYlAzVUt4cnlWZ3A5Qmh1cU5jUHVtSjMz?=
 =?utf-8?B?TndwaDM0WE54WCtKeWxpS2QxY3dWWU9wTFFCRVZVUW4zc0hKWTVacDdqbzhH?=
 =?utf-8?B?dFRVR3p5RzFXc1AyME9HME8wN2RCOXh6TFN4eWdlbXV6Zlc5MUg4aUhOMkJk?=
 =?utf-8?B?K2p5NG1jV01hSjRNNUNDbkpGY1JpR1JMR0ZyTWFHTkZXVm1qcXpjTkZKbHk1?=
 =?utf-8?B?MnVidVpRTHk4dlVJVWxkV0hZYVJoUmd0QnBLdmg4NHlzRk9NQnhPTlV1cXhL?=
 =?utf-8?B?eTdSWXJ2YllFZWhhdVFMMUM5RXZpSURFcStLNzlFWUdZT2w0ei92MWpaWEJQ?=
 =?utf-8?B?NVpwSWJaKzM5S0RIcGtiNkpDaHRHdFl3a3UvUmo5QnQyb0xRK2x1dUovc201?=
 =?utf-8?B?blBGVDZKT1NNTEZXa3p4MFBhbUt5NWpNZ0kybTJXM2FTNHVoUXBoTGF4Y1or?=
 =?utf-8?B?OUxGWEZocUFVaTVwc2VIZ3h4MmtWNmtnZVNRV2hkdER2OW5BVnNyMzY0ZWk2?=
 =?utf-8?B?RVhLTGt1UTBZMFNXaUdEaFNLK2h5WGE0VDZmbmZxaGEweHI5NEYrUWQ4dDZE?=
 =?utf-8?B?NWxBdGdXaEhXUExCWTBRM1dZYkFSbzFVNHg5a3J1SkJkUGhlcWRCVU84cm9H?=
 =?utf-8?B?TFk5TGVMcFB3ZkFuZ1RXMXU0aVdVdEl4WVNTNldDQktPZjJvRW51Y0xjTFls?=
 =?utf-8?B?SmdrcW9tN2Z5eTlVenJicStGekt6bUtUWG9Tc1pZaklzQlRQVVdreUZLdGhh?=
 =?utf-8?B?YlBEeVZKZEpLeG5YNm9oZWRPUGRJMHB4Z1JSaVBqOFI3bStTNlpRNDE3a3NY?=
 =?utf-8?B?WnZOSFlETS9KWXlxWHFGMyt4QTRKR2J5S1ZPbHIwOWsrRjJBcVp5eDR0TTZB?=
 =?utf-8?B?YmJaQnhJUm5TaXVkY1EvdFpKU2dGaWNsTnhRdHR2WWxuY3ZmS01FMjd2VFQv?=
 =?utf-8?Q?Wzcd7+O29MvVqbcOkIsiDtcS4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ff8154-a9bf-4140-3aa7-08dccbe789d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:10:49.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWF1px7Vutgnhx/3R6Gwilb1HbQ6T7PtstUX1NUb0oIRjIn2QHvzVaDritEiEavI6xBoR0DwQF1MYRXMn3jEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, Ira Weiny wrote:
> cxl_dpa_to_region() finds the region from a <DPA, device> tuple.
> The search involves finding the device endpoint decoder as well.
>
> Dynamic capacity extent processing uses the endpoint decoder HPA
> information to calculate the HPA offset.  In addition, well behaved
> extents should be contained within an endpoint decoder.
>
> Return the endpoint decoder found to be used in subsequent DCD code.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>

