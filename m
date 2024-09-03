Return-Path: <linux-btrfs+bounces-7771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A69694D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212631F24A62
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B042139D2;
	Tue,  3 Sep 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="He/hR1Fy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE511D6DC1;
	Tue,  3 Sep 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347389; cv=fail; b=bN+uICmjxU8De5TvN03pkOL6LXaj/uO2qmDo8AilnTBov+0U2/RIVQGSMElaIAfip0zYl1zGF5Wj7DrSRTrJgIcvzkmZ11NOOX9c0OfSSj8mp5PHDF2alNu4dUt9Z0yqB6v2dBeOy7aeQ8RzW7b2jG41je/lsxbmbfnZD6vOwmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347389; c=relaxed/simple;
	bh=M1l2ubnqGzjxTAkVZnbVMvfJVjJlC7Kr+m7g128KBl8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OPjgszK+uS5SlRUxqnfn+BhcuDBIxOGOnjf737uSgizvrOpKjObbISfTnrSAHKjuXQD8HkhkdHaKsrSxS0SVAATu0LuOY1eiRNAjZNCw/baJ019Fnw5pjoyE0oOi16jEmHg6M3OXLKVsXP8T8ErV6bWAqdrUYR2TJ0V2h0GndOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=He/hR1Fy; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725347388; x=1756883388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1l2ubnqGzjxTAkVZnbVMvfJVjJlC7Kr+m7g128KBl8=;
  b=He/hR1Fy+Z7rMV3b2cKjRvZEyqVadPdpAsVApioVUFyQSfLvVoGVIipv
   cM6aFkZMv4r0BYoUt66xfiXdbEL++rHAqSyQ7Y6DHx7i12q4ZkI9w1Dpp
   JumfFnEf/LiWB8UyT98fc6WxItPxNiaWRBdVIpUKlZ46HlBYsupJgae4A
   vt/RhCjroPVth+o5jfEoD7c8m1hVybJ39sEvRORWDZSQe7GvDK/lHxwr3
   6BdFStfZybqoPGK2ykyETx+FpvzDfPzfed6jsJkjV0zvedm5Lyrfmxf2j
   kewXPdYDnpuyI40uzlyQISaqrQ1V9vOSWokhskAehHl0ArVx6A+5aeh1s
   w==;
X-CSE-ConnectionGUID: dvs1xR2pTA6x4YP/v4NVTg==
X-CSE-MsgGUID: pt4CmRy6SiaLDPYNoGApKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35294790"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="35294790"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 00:09:47 -0700
X-CSE-ConnectionGUID: hfIRYjfwTfeh8XfauEVzjQ==
X-CSE-MsgGUID: 6WPHXrEdR8SPCgGgXqcInA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="64639189"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 00:09:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 00:09:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 00:09:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 00:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh+At0m3XF7vEFoxESg4naB40Z392KPWUDTz3kLROT5BX34QVhomGUJiy0En+2zx06sSOAUc+Z77V5OZWWn5f8ZtrMt/JDEzfAbc9x4TlwBz7q/QPSVCMy6xFTFU6uvxzhMjuIg8iI/vrF/cd8XDomXtgoNor7hT+7pa4evJSy44oL++0l+3GujXEXxzvoCGgvUVhHxqxey0LGX9dRniP9e4EiqKcQ4tEu4bytyqb9Lhh5bWa3rZBztZbwkB43ykBeJgSzOoEArYC1E1B6UvJAIMHLlYo9kIu7B1IdTUq4/gvggBqD13kXU0DLJcN3zxicvxKqIPrntQgWdqEJ4y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRcu7tGygES3I65yv4uqm6Ftq4PqzEu7U+R4Nko9R5U=;
 b=LTzURo/H3toQ8l/+5HI1drDQwa7mpLPbaCpLdmISVHiAZpnmPtrA78MJmzST3RSwapcbx9axTgmrA72/LXRL9ewPjXaN/ej1SAAaXeDzd6XNDNkMRvzMGYilZBrfGKdypq8Xf0UUHEjm0X5u41opFFshyu33fb5/8Npr0ehjHgmXG+t6ZWBgIxytwl33Ss3AdivR4pN27m6VW8Be4UW0nWPf9gLGen+N4OvzKRUcp4kPZgb6L/qFSPjV5yg9YwlpKwSYgR2REXFZuUYge1GN4nP6P0VgyqkIiUd6xd561IRVSZ22MtDv7wGsJ/lLeyWabJ/DHcky1fEmlkr/BNShdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:42 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:42 +0000
Message-ID: <46ed20a7-a9b7-4a97-a821-51c4c267588b@intel.com>
Date: Tue, 3 Sep 2024 15:09:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] cxl/mem: Configure dynamic capacity interrupts
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
 <20240816-dcd-type2-upstream-v3-16-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-16-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: df8e09d0-55f2-4db1-a198-08dccbe761c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amQzRG53b3R0RnBaa0h1NTVabVNCVVZGYkNIZHlIU3pqMWFTS3lpZFRkQ2FR?=
 =?utf-8?B?UG9kbnhhOFJ6ODFnT0FtTVJ5cTEwUzJwQmhKdEZRTW5WSDdhWUw3ckpkUjk2?=
 =?utf-8?B?TDBUQUxIUUZoMGd6M01ndVVCeTVwUHRTUVZYMXFZVFU2ZjNiSGtMd0UxOFMv?=
 =?utf-8?B?YjBlOWIzZG9MRGQ5ZzJheW5pekRTMXhOMU5PWG1QYjhPd3F0ZVNZTHFiZWF6?=
 =?utf-8?B?OTJHcTYzaS9XWjV0RDlRTG5FampxczdJamNqR1dZaWpaclhSTnRRN2dhMlM0?=
 =?utf-8?B?amhxallNaDNlODZ3QjhpdGxyZ0tMZnQ5YWN0aTVSUlpMRG1OZjdERmdTd3Rn?=
 =?utf-8?B?QllHZStOMndtSjhmemtIZFpNWDhORVl4UWx4NGY5b3Frbis3Q0NaYkEzWW9q?=
 =?utf-8?B?VDdRNjlhOCtCNEJIRDhyN0pBVEdLRjdCMTl1YkFHNFArbzBJUE1FNGNmZDd2?=
 =?utf-8?B?dFNCQnpGVElDK3BEVUlEMUQ5RkRDZnBJZUVnVjFENTR5YkJMM3ZWWGpueFZ0?=
 =?utf-8?B?TnBkZkxVUk1RT1J0TW9kSElLUldjUGZmVHFyQzVzaGhxamFTT2YvWnpadU9W?=
 =?utf-8?B?NkhPdEdsKzRqWjhDTFQwM21qNVJtQStNSGVtV3lweXdiUWF5RURrejQwRGt2?=
 =?utf-8?B?RUY2akd1bFArRmR0ZGlUUlU2bjlRSU95QTd1T3huMHJLM0QzeUgzenBLYjl1?=
 =?utf-8?B?S0xHR1MwSUxUODN4dDBKVWVYcnZjeTR2WUJrMm5CSUxHdFI2OFFHYXNmbzlZ?=
 =?utf-8?B?c3ViK1lZUGJ4SjVZRURKRTlMWGdzeXZMSkFGQlgzdkZlM2MrQ0NUcHM4SEdK?=
 =?utf-8?B?cjBsMGVLV29mYzk2MnlEcFE4QmtucFE5ZEQ0Q0wwWWp4VHhsOTFMNDBEWnFT?=
 =?utf-8?B?R2RaNzdDYlhEbmpLSXpFQUpwREEvNTdKOTkvbkw1a2x3ZTVPSithUU1oZFVq?=
 =?utf-8?B?YUVSaFZSdUxIQWVGc2c1ZndtbUx2ektsUWJWcFN2NDUxbXVXbXg0Mlc1ODE5?=
 =?utf-8?B?cDdDRkZiR1d3b083WjZ3WVpDZ3QybTF6TkZJa3dZc29UYm9KRnVqMlJUZjJ6?=
 =?utf-8?B?RkJvQWV2VTBHTlRsUTlTb2g0a1RyUFdmdi9YNk4zRnpnZHk4cmdtN3JRVncw?=
 =?utf-8?B?WTJFMER5eTlnZ0lHdlNUVmhHUGVzSm9BSklXUkdCR09Ndnpxc2txd1dNMzE3?=
 =?utf-8?B?QkI0c3p0RGNPY2JxQ05kaHJNblI5QVB0MUNNWHNITEZPUDJQVDdNUFh2Y0F6?=
 =?utf-8?B?NEVVTmIvd0RiaTE0VTFQbTlwMHBsS2ZlUkxURGVSUTNGeXQ2VXRCVzU1OUYw?=
 =?utf-8?B?OFN1elc5UEZLeUQrZzZKQlJhOTlrZ0w4VVZlMFFjcy9rclhnV0Z3eDN0RHpw?=
 =?utf-8?B?alFZSENEYzU2Zk5BVkVJNVFNR0xzT3NVWWRuUlBoQWV3dW9qZ0tKQ3Z1Ty9G?=
 =?utf-8?B?cDh3S1JGTTlpOW1mZ0FYVVgyUEtUYlJ5VFNxQmp1WU9YMXVsQXZ4UlNyWnVM?=
 =?utf-8?B?MTRocXMwTGFyYnh2dVp4N3lQcGl0bnV6Mm5jOTY1Qmt5a0pKMW8yM0hFUFNn?=
 =?utf-8?B?WTJhTG1RUGlleDl0KzdVaGxRaVgwcXdJai9lTlhjcWFhOXJGNlBLWkMxT0Ja?=
 =?utf-8?B?T2FzWmZYVGFRMUp3MnhiV0xxYmp5SnpWU2JUUG9DMjlyc2tvUUR0Z210R3ZZ?=
 =?utf-8?B?b3M2NWpxMVIzUGZML2xOZ25XMmJvMHhhQ3RHd1NUUmxPSSs3VHpGM0xoajBy?=
 =?utf-8?B?Sm5WUG9XOWIzT0RrTkhMNzdKRG5xQ0NOV0J6aTB4U2RZZ3R6cjh3MjNyODcz?=
 =?utf-8?B?WkZBS2hyRi9wSGFKclk1RnlvN09HQjlIRnFwOUNNUDg3Y2tvTzZ1cVR5TnNz?=
 =?utf-8?Q?PZUZ7IJO8uhFs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2p4S0lMcm1SeEFkZ0JaSFlGNzVMYnR1SkU0Q0U2NE84ZkFwZWRKN2NxUTh0?=
 =?utf-8?B?YlR4QzZnZFcvK3p4WjJJcmtVdzYrSVYwNG5TWGdObklrUXp6ZWN3dFc3aHpn?=
 =?utf-8?B?bW9ES0pJSEp6NTNlelNFTGJaZU5KVnRtT0ZkZE9Udzl4eTEwd0l0NVVZakJP?=
 =?utf-8?B?Z0xXNUF2MVFTT1NRUTlWSHl3bDJUb2FUUHdFUzVqRmhCVkEwYVIwbjdxZTFZ?=
 =?utf-8?B?OGJoZVNDUndPOFBwVmZlTHNqVWVlczFPRlRoVndPei9BUHg5dHhmUjBwRWJL?=
 =?utf-8?B?czhleUk5RzU3cTN5Zk5SampLc1Z0V0ZwbW5nbDZqbGpFblgzT05uakxac2Rr?=
 =?utf-8?B?ZTU4SXdSR0ZmeUlZWjFGOUszMzhrbGJ0NTZqMHlBQkN6VU44Und3Z29oN2Rx?=
 =?utf-8?B?djVxNUU1QnI2VHdJR0RUMSs3YXpIcysxV2dCNDlCWFg5WmRSSEVYL25vSEVQ?=
 =?utf-8?B?TE9rZUJHOTJ2dnMwTnRmQjdvSElYMCtUZDFLTFBvVHhlVUtOL2VpTXc5K2Z2?=
 =?utf-8?B?eThWYzYrU092d0trK0xLblhoanllSkI2dzd4WEFKTXpsUGc1WW9qZ0tiUzZq?=
 =?utf-8?B?U25SQlJIYTVzT0ZpM0VFd3dJMTJ6VDlQSVBkc0FtQmN5Tm5rNHNoRndmYk81?=
 =?utf-8?B?bi8yU2lUQm1GNjRWUFJmVmkxTFBtbWhXb2JxRHp6OFdVbDJ2NkJOdkhxZ2hx?=
 =?utf-8?B?bTkvRFQ2TTJnSDVGUENMd09UU3g0c1p6S1IzMGJvNkNPRHdkNGl4dmJ3bCs4?=
 =?utf-8?B?STFFTHJsSldGUlRocko0WWJuaHlSN1Y0R3NpZDhlL2JWczJnUXQvRThlcXUx?=
 =?utf-8?B?MVl4VWtOanpJRTlrS1p6ZGNLUEFiYzZ4TkZvNUZFQWM3Wk5SNXNjKzZaZytX?=
 =?utf-8?B?ZEcvOU5aRDUwZjJjVG9IL3ViMHJrcVdld1pnWlFjTDFMQVpmU2hGRUpwZFRY?=
 =?utf-8?B?NmRTWWJ0NGVpSU5uOVVXanliZ3VEbE9veGhVK0ZvNnpKUlJqaWR1ZWR1RmF5?=
 =?utf-8?B?UmFoQUUvcHE1WEhJUXN6RGUxSTFqYTRqRGNMZDFGVU53dGN3Q0ZVOUdnaGdN?=
 =?utf-8?B?UEdDZU1pM0N1SnU5aWltL29DTFpYS1BoQmpRb2wyV25INnV4QnhHU3Zidm8x?=
 =?utf-8?B?bi91Vm5qM3VjY1FrcDZ0SlN0RW44ZXNPUVIyK1BkQ0J6OFp4dEFhT1ZxZmVK?=
 =?utf-8?B?RzM3Nzhjd3BrbFdja3FjazZTdkpadGRGdkM2dmVaNlByNHFlRFczN21Dbisr?=
 =?utf-8?B?U0wvTVQ4YnY1ME1lQ09ncUtzWGwzclZYekZFYTB1Q1h2RnN2TzlqQlpxV3F1?=
 =?utf-8?B?WnFEVmNYSEQ1U1F1N0ZtU2hoQVY0ejc2YTZCYjNsMUN5TzdwWUt1akcvcHhr?=
 =?utf-8?B?YUxPeVB0QU1qbzNNcy8wSHU5ZExIa2tZSlVWN0NBUlZyUytsdGdRd2szOXFn?=
 =?utf-8?B?eU5Jc0RUQW5NRGFsbmdFMzI1MkRlNUJpaGh6OVlBQlV6bGNQa2NuYzk2TFNZ?=
 =?utf-8?B?UEM2aitoeWJKNG5tek50UndpUWYxQzFzZ1hVRzZPQktBRmZuV1Z1YzZyT1JE?=
 =?utf-8?B?RTdHMm5NbjM0TFdRcGhkbVNvYzJyR0tHWGdQRWZXQ0MrT3J0V3JPVHcvWEov?=
 =?utf-8?B?dlpZYkxGdVhlQ1U5S2VtRkZPc0Flc3JiMXJpSk0vczVRYWhPVWlqQjNTc0dH?=
 =?utf-8?B?NFFaV2pCa2ZDWkNadGNvcnhSQjBvdG1RR1dyaDNKZzZ1QzdFTjRMaWgxd3Zw?=
 =?utf-8?B?OU9CVC9MU1NTQUhGRFhRQmdKL3RpZWZuV2V0czFHQTFmenRkOU9BNmJhSzFD?=
 =?utf-8?B?ZmprZ2JXRExqdkZTVm5qYm5pUlJkT2xlS2VoTzZBbG10dFJoK2NFNVd2eW9i?=
 =?utf-8?B?MW1wZ1ZzS1IrR1p4VVhXMkFuT2R5QXp5UGQxNk9vZGMxMzFKalNKRFhEdmlp?=
 =?utf-8?B?aGRMQ2ltcCtXTmkwSjNuQWJlQUdUK3dIQ3dnS053c3lMQlNndlEyUU83Umow?=
 =?utf-8?B?SUFSa2ZWejNDZjJ6ZTdjdVFEbDZVajNaTmszWTRIYXFuMXgzY2xPNzl6UEkw?=
 =?utf-8?B?bFc1Z0pqL0ZaeVlYcnhNeEZweEROdE1aRlUySndleEM1bVR0dVNIekh1WjNv?=
 =?utf-8?Q?9/l8eKoIYQwpUdNidflPzkWoI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df8e09d0-55f2-4db1-a198-08dccbe761c6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:42.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNc170S5Wy7nRtZ7RCstRQH2Wl7lrGwFHrRCUgG4w5AzDhJOJvGWRZYeOIXuj+Ic+RgaDkRq6DzKgX4AXk43ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
>
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism.  The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications.  Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
>
> Configure DCD event log interrupts on devices supporting dynamic
> capacity.  Disable DCD if interrupts are not supported.
>
> Care is taken to preserve the interrupt policy set by the FW if FW first
> has been selected by the BIOS.
>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>

