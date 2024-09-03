Return-Path: <linux-btrfs+bounces-7769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17AE9694AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61F91C2089B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9BA1D61BD;
	Tue,  3 Sep 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKk6sgj5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC51D6196;
	Tue,  3 Sep 2024 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347219; cv=fail; b=I0rwGytOFxEfTXzBI269oFhx3dTVrjAGvp0M6dT6SCAhf1IzP8XdLlbWEm2yXM830iIZesvYrm1SkZHOGeJQVGKr6OGAvW1sts1vncR8G5QBzyMHa0hHfPx/5gU+Mcb2oELSEh5+Ifntb4tr3JZz/z90v/xGDo6uFQo2utllguE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347219; c=relaxed/simple;
	bh=2bmoinGk+hpYXlZd2p9vXCoQPyV9CfX3ZWtJrz2JV7A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qDkqn84FBAMQNd7XZNRVuT1D5rnMI4ug5lDoXFGGbD120I7bsfIDHKXsOfdp0/mllhq5NksEhrMLFt/Ghld+JzgdOHemDvvhTqAug0Hmc3Vv0TjWV4S8Bi1iCrBI0ebYHw8mGoPaoTJyN/RknxKIeWIQtb4OE116sFyNF/5JK4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKk6sgj5; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725347217; x=1756883217;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2bmoinGk+hpYXlZd2p9vXCoQPyV9CfX3ZWtJrz2JV7A=;
  b=mKk6sgj50iTb+/1vOyYtTc+2pYctvnnLR/35S3lomM6AwbgVqO0dPF0U
   2Wic7Q7Qp9p+ztGjkyKMl/+67eVh1CGoAXg7bdoZ7j74fmvmazawSaLAi
   A/j4WTFIBsKcUsRYyd6ySH20UAyuSpMOKWpIPXG+ErGiKi/b9bTFjWW4t
   ZhQf8OHqz8ffb6OTU983cXkLivjXMKB8QQ+kuIYP4Mn5Minw3QTtCzWTx
   1FFYiA3mWXP7Fl/x5+j9i+4LLz9kT+UL39QOinhzOz8wzyaVj6KkdY4Ty
   koeBpGE+Ojc0QOhMWtYvHGevUi2aF3uP2pW1CDNoYydQR2N8XIE9zgSfy
   Q==;
X-CSE-ConnectionGUID: RDawA23QSwKJjiSOPOHTNg==
X-CSE-MsgGUID: 972qpjmJQk+05436mbrh8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35294500"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="35294500"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 00:06:56 -0700
X-CSE-ConnectionGUID: CDAdxQheTxm89CrnBO738g==
X-CSE-MsgGUID: jP3OqHnVQ0GYbGyFmWsAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="64637949"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 00:06:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 00:06:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 00:06:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 00:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j68OzwBq/Njxkq0qsDe/VZNncGEhLoXBZS5ewAEheDSUK2/XgjESJHuAnaiZrRWwcr13zk0VUwPyhSWYJesSraa98CgMcqSsZbjnPdozdvvdcUir5aWUnjmzPvVQBCoCT7qaXkBGfEP+6yOvqyJQ9hI3qiDjppWvyHVD0BykjPQ795szVnGl8ioQcyBlXITRG/tOoP8RQVlGSoo78NfCWVl1kXus3KQNazptpn0lTM4zjn3LImHiba0CYZoWrT1Zbi4P/vvrbdb1YY0wJZDd75cnAGckw8JjqLhBRv2dMilzh1b8H5mLRgHOUbSI3bXJnwd5R6yFWJggwn5VPHRMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC8npr1nLoXxjMnmBIXzgMMmRKoEGbttuXkOvOa8WSA=;
 b=b20Dkd/rD8/0+LmDtE6GFEcnlX40A+XkmYZlTgvFjRskaC7YPglNDv1eSM5WUva8QayXTIYODb4pfz39eD64FpKGYi4liwvPOVO1fnkUljgr63d2U8O6EujdHs36rdk0RbhMybCcGnW01Ih2TCmEnHL2gHq15pc/bd1tu0A+dP0V8oH/dOVyeAGFUjQ1BqkkovcpTgjVK1A1h/zfa59DUoBfqtKyW45NlgfmrhWl10Cvjx16ia1mgu/X5zEiP55siQQvp99tyIzvIUxhbE7NXRHqGp/TZWO1IiSLz9F4W2drLQKB6Ntp3oK0/BL6ZHRRAOUv9b17T5Hhavv3SWfs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:06:53 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:06:53 +0000
Message-ID: <379deed9-ba35-4891-9bfe-89478b4eeff1@intel.com>
Date: Tue, 3 Sep 2024 15:06:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/25] cxl/events: Split event msgnum configuration
 from irq setup
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
 <20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a322f1c-202d-4e02-b253-08dccbe6fd1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHM0MEljSnN0N2hpdkJ5anpDUmk2bTNkdHZqL2dRUm1ZRHEydWZMVG1XQlRL?=
 =?utf-8?B?MzBISGQwOHZqWXBEbGU1dndOaDdRVU4wTVFDQ01ZODlRTndWNHVrUXlKWUtj?=
 =?utf-8?B?WGRyTHptakNBQytGUjBzWmw3MFFNeUM5LzN5RnpSR01Zbnk3UEo3NEhkSXla?=
 =?utf-8?B?eXpzUTdqeEtiNzkwZWtsekxmTE5XUnJXcWtHNnNQSHg4QmxITnBvcUx3NTlG?=
 =?utf-8?B?bDBEQmp1QmtOTGtrcjdoY3dCUGxRTFh6UGRBS1BadkVpZDM1czV2Q1VXM29W?=
 =?utf-8?B?TXNLV2RlemhMQU9YZkdEb3ZCS3NLajU1TURENjBCM2p5RTA5bHkySVhoL1hm?=
 =?utf-8?B?UzZuOW1zZTcwNkU4WENXck1nNHRpZkpXTHJRbWpMQ0tpUzdEZ2ZxSzVqODlh?=
 =?utf-8?B?dk0wZDBnaklLU29IbkM3Zm9NNS8zQWpIQWFxblVVOUNUeTBKM1pGU3pWbzdp?=
 =?utf-8?B?akRmZnArb2IrVk1lNUxVaEZqMGhXbFBmZFl2OVhkYWQ5b1FERzFuZUZIMGdQ?=
 =?utf-8?B?ZmRTNDBpb2ZUSnZ4REF4bDF5aXJkVTBZeGthV3VER0VMWXJnUXRWTDJRV3lD?=
 =?utf-8?B?Q1lwN2VlbGR6M0xDeWFwRkwvbUt2eHl5cEZJSlpCKzF6VjVBS3l1T3JGYW11?=
 =?utf-8?B?aTdxMUtsVkJvdnpIRVNVbjhRWW1VaUE4LzlBcWZwamhjdjlYNTJ0RUw2OGJ2?=
 =?utf-8?B?Q3VSSHNndnpEelg1NERMdFJXUXpuMm5zZUpLdWlNeE5vK2JxbkJkd2wrbGNU?=
 =?utf-8?B?d0d1amNhSzdwQ1VUcUd0MTVxeDVyRFk2KzlCT21XR0FQdXRpSzA0OE9zQVJs?=
 =?utf-8?B?M0dZQ3E1dDcrMHRvdEhVMkxHbG5xUjR2Vk9zdzVUb2h3TVB1bGpYVmtSUW51?=
 =?utf-8?B?OSs0VHlkTWwxajBpZEFqV1I1YTkzaHNrZkRRYWR4bERnczNvNUVna2tKRTZ3?=
 =?utf-8?B?Zk1zVU1hUDNxMDVNME44Q2ZzR1I5UW94YVpXU1NWL3JndFE0M0lSelhQdklG?=
 =?utf-8?B?dTJ3TFMwejYyNTNCN2hiSy9qTUwzNExKa01RaUxCQ2R1d05Mci9KbEw3eXJI?=
 =?utf-8?B?bU9ocEpMcjBlWGJTRXZpZVRLUzBNTkU1Rk13Zkp3KzdyZ2JpTk1GTVJ1NzE3?=
 =?utf-8?B?UUJkS3FGc1ZQOFFuRHV2WHl4QXozSnJVS2lWQzFwZWpHZkRPQXlQVk1LdENB?=
 =?utf-8?B?RjBRWmp4OENickZ3SFQ0S25IRUNuQlR4V2w3cnFmY2VFUU1ZNHRER3A3R0tR?=
 =?utf-8?B?UnJ3aXVzSWRrcndZeElQZ1pqV0JPaW41R1BRMUtoTTJrYWNzc2thMSsvRm0w?=
 =?utf-8?B?dVZ5aDcxT1ZYa0pzc1hnNDJYWmxVWU9TNnlBVHpUV3NvZTN2YUxBODZHTEts?=
 =?utf-8?B?YWF5SGdYMUdOK25qWThCelB6cExyL3lieGc3SExPNFlnM3BkaXJFWExxU1Z1?=
 =?utf-8?B?UXRZNzRYc1ZrQUFjQ2dhdWpDY2psa3IxUXg5V3lHR0dvMWpwUkZlQ1V2cTdK?=
 =?utf-8?B?dVZSRURqYmRkdWEvSWY0SCtXOGNZVHJxS0o4ZVhpZlRHdHFEUEhwTk1VdnZM?=
 =?utf-8?B?VzlyYld4cVZFZG5wZXdqZVhodk03OVUvdTdzSU5wQjBmWnNwaG5ZSVVuUjJ5?=
 =?utf-8?B?UUNoV0o2S1lGRDV4Zk1xQmZrb0ZuK0RCQXd6dFBQR1YzN2FFYWEvVmoyVWFR?=
 =?utf-8?B?eHVWeVhLNlpOaThDRWpXcjg0NTJmeTRBT3N2b0pvbDhwemRJTGZ3WGlBaHBI?=
 =?utf-8?B?NjhrMEpWRVF0VFQyaGRQWVk3WExsM1RKYUtUMVpnVmFGcVpDNFVzODgzSnhT?=
 =?utf-8?B?elJWVGpwWk9qZzAzMUR5NXJ2elRJVnluUUVWVkY5NWI3ZUlSaVlxL05mOWMx?=
 =?utf-8?Q?+hZ5IvadWWKe2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5oUG96V3FhUHlBTmhhY1pjT0JDT0tTTmZLTW80RjlzN0MybHRtaGlJQnFF?=
 =?utf-8?B?ZzZzdG5ENTVFcmhTL3U5aXhqN2pYand6WWpTa2hoRlVPMDkvVktNdEtjOUUr?=
 =?utf-8?B?WGJ5WVFOVnFLbHhiZ283ZG4xcWFidDg4RWM2U2dVaTdXZGxoMURCUmFNTldB?=
 =?utf-8?B?aHVnRGFCOWVGRUMvVjFWNU1Bb0RXRFFYZXdLV3dQRzIyQ21PazdONWhYNXBR?=
 =?utf-8?B?YUpJUXBwK1hCbEFFOEcrVGZRZjVwVytMSUp4TVpkSXE4RUEyeHY1enNWdW5p?=
 =?utf-8?B?NnlmcFJUZXlWTDdrblN6eG9ZOFJ4M3k3RGcwc0hxUC9EZEYyRXM0NVJlWm51?=
 =?utf-8?B?OXVHdnRWUDZ5WURiY1czWXBaTUhIYnR3Ni84WXhXM0xUbFhtMUNsRjR0R3cw?=
 =?utf-8?B?RFdJanlnMkxJN1lBS05rOHRJTWlFcGRzbFRtN3JNOWoyVmJ6bjkvVk05QkU2?=
 =?utf-8?B?OEtkZTkvY3pmYko5TktEbWxRR28raUVXNnp3WHI2NHBxYlRvb3lra2JMOWVT?=
 =?utf-8?B?dS94aW1vdC9zUDJDZndmNzlZL2VidDR0R3AvejVKd1JlVXQ5VUFkMkM1QnZX?=
 =?utf-8?B?U0swcmpvRE5nNWFhdk40bVpRbGx6SDE3VDhTbzQ1UEVLZ3RQa3FUZ0JZU0VH?=
 =?utf-8?B?Q1loR2JwcWRrNmNjckhWbjVoWjJqZGpvVjlsZG1sUUVpc3EvTWlxOXRZYUht?=
 =?utf-8?B?UGNZbGRyR0hLSStUSEpmeFRFQ3RMZmR1UFdPV0V1SjhHeUdEL1hhVWIvSytD?=
 =?utf-8?B?QXRHRFFmR2lFbnVra1ZrdDV0M3JXZkgxMGJ3M21SSDRpazZLMFdQSk5ScjVx?=
 =?utf-8?B?TTh3dS9oaDNPTDVMT0FsNFVDK3dabGN5dlRxOVB1UVplWGwvQWNuRmlKZVhT?=
 =?utf-8?B?ME5YQXB1UmMxZkdnNEs5Yzd0Ym9UdGRsSEZVRjRMdUY5M2pqbXdnNWJkU05G?=
 =?utf-8?B?OGhIYzBwZUNDZk9Wc2ozUUxtK1FWNHQzcy9VREdwUU5TSG8zNFFLcDI2aExP?=
 =?utf-8?B?Q2FjUFVUWDZnZlBlQ0R5aE15cDlGeHZPcE5ZN0VXdTkxK2FXTmlJbGU0M1Ey?=
 =?utf-8?B?a0s3YjFsYWRxZTVNSUtVZGZpdlExYzNkMkFCaFpLcTluUm5sc042T0puZTRk?=
 =?utf-8?B?aFNRSVRjWEVyTmJ0NHdNeFNHcVV1UkJjM3pvVEVBTTcwemhWQ1RIenBQckpo?=
 =?utf-8?B?TEhxcTZ6Z0wrdW5Ld0oxZnFJSXRnU1JTeHVvZDIwQVNjRWIvb0NsREwzSHVL?=
 =?utf-8?B?NkhXTjFtSEJlK0hOK09WTVdoSW1rajFVSU1PU1NHdHpWem9yUzlUYnhtY1pJ?=
 =?utf-8?B?RXpwOTdzaU9zSHZCSE5ZOWRPSk8rckJ3VW5XQXBneEpiSmNFd3lEVjB6Zisv?=
 =?utf-8?B?WHFIWTUwbGdTVEt5OUtMVkc0M3BGaXZsanM3bWdsdlo1YU91RkdaeWhUY3E5?=
 =?utf-8?B?TGdBYkNvOTR2eWlUV0ttZ1g5TG5jQ2NOOEZKWnF6V2FXcWtEU00zRjBBZk5w?=
 =?utf-8?B?YjVhUnVwdEdsOGpsNWxtRG5jNVNGVnBLZmhQRVdPWCtYcDl5V1oraTJGaVV0?=
 =?utf-8?B?bWxnanVwZStJR3gzWExCUzN1VGJGMDh1QXNkYTZYQ0FPakFFNG5LaGo4Zm9j?=
 =?utf-8?B?elVyQVFWS3dMVHdXM2xvZVhsVkxBV2FyRENtMzA0UnNpaGFnWkJwaEZjd3Ey?=
 =?utf-8?B?V29hVkczTVlpalZ5WTdBUjR5TmFNdVAwRXZJLzZhb2xHN256UW9tVklJaHhJ?=
 =?utf-8?B?TmsySFU3R0hiblZiVUg5UTl4WWFhbSt2b3A3eXU4Q0x5Y0RzSmQ5ajJDMzlJ?=
 =?utf-8?B?ODRlTmhXaEZUK2hQcjM4TmZkdXhrVHVXS1dHcHFqdWExRXZIdm84bWtMeHlW?=
 =?utf-8?B?ZDlRa0xrU2dqczU0TGJjSVEySmhERTdIMGJKdHJDRDlMcUFFcitFR0dSaGFX?=
 =?utf-8?B?RzJlWVBTNlNBT21rT2F5L2hCSFZIbG1XQi9WTnd5a1hsT2h5R0U1aGxuOWI3?=
 =?utf-8?B?SS9mRjZxb2ZndWo5Zlo3NUpnZmltNlpPZW0wYmVKQVBDcmVkUmtyZ09DdHBX?=
 =?utf-8?B?ditUbllxdWRJam82T3pXUTRZNklmdUtudFErdFdPYkM5OTBhbGt4OFFYbGZT?=
 =?utf-8?Q?CsAA6oKFithKdNAEHu5AoU4qy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a322f1c-202d-4e02-b253-08dccbe6fd1e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:06:53.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvGVs8hemW8WajI6WEh+DvJ0jEuILIBKgNHLxEUkDYfi5LwITmtMkIB/zbme5S5HLl4TdJ0zinC7R/dK45p+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, Ira Weiny wrote:
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
>
> Split cxl_event_config_msgnums() from irq setup in preparation for
> separate DCD interrupts configuration.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>

