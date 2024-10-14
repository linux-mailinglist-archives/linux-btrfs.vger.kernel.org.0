Return-Path: <linux-btrfs+bounces-8916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5EF99D88C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DB51C211AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E301D1318;
	Mon, 14 Oct 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5FsnsKa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576211A76B4;
	Mon, 14 Oct 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939172; cv=fail; b=LylULQe2CFl02xrQkH27W6f1DK7TWVWom/WSGyiuZFWzjhYXoAYrCAqTFz04MWHuUrvInn0KRIyaUmWxnu1Zzr5yFM639VI63kWZsm4HTTms5/F8to2j212eQinF4AWOADHqFZleq+HXvP8/7qHVNGX5LmVZ6Uh6GwYq5e3Tn80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939172; c=relaxed/simple;
	bh=GXDEJo1oqAuHGnmtu7QEspqM1c258jrvHATh+a5Mj7g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/JdA6DGXX/6s9Ro0h4j+iVOvp/BNw2GnB+n1lqfkKOHxWB5gAMMwYuhuT9coQQzkAnyIPlVG4+1HKl8VaAYuXwGFKIGpjcHI5qEZNQTHXN5yxFqre0hCd5pjy9JM0CnHvMBITLs47dQvhoEaYP0IV8IkebLgGG/kMOZwDNXXWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5FsnsKa; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728939170; x=1760475170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GXDEJo1oqAuHGnmtu7QEspqM1c258jrvHATh+a5Mj7g=;
  b=H5FsnsKal6q/gY1z1py7wMh454UqanmZUaLjNimpHGKYeao3WTANY0Sa
   g7+zdK8CHOFRXVB+13fnL9w6lq7fibYF+Gs2+EdvkxsfDrqNSDO6M+tmj
   rNzQ6WySpjq0M8fptHCF7XAFarGZAoPr2EKgWn1xmUbfOaX8cxl0+ZTh+
   gOjU1lP8+kdWwM/jJqNZDcETEb8o28LcR6d//ZqKHGyYf1zw4ym0VAO+i
   lNq8FYxqasp8kRAuRxINFKr94l8/bcvVgYed7oBinxcRSej0/HYZh/0UK
   4PAYs5nWWQ1qFGpwOgl+0c3Tpmta+bBbnNB04qbuv4Wnl5iR0sTlRusdw
   Q==;
X-CSE-ConnectionGUID: ZpobdXWDS9WZsAkkxPiB4A==
X-CSE-MsgGUID: ASWVCKmaTvilzcUBPhaD+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="38943548"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="38943548"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 13:52:49 -0700
X-CSE-ConnectionGUID: jl6+17TGQgaDA1CK1LsX8A==
X-CSE-MsgGUID: KodWv6QjRYaoDQ8t2c7uSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="81660504"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 13:52:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 13:52:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 13:52:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 13:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijh6PAGPC5qdzweri2ybASak+6hlrXPAUHkpmz7UFl80c7GMkVnKgi+ZIXH/KTU5Em/GBFbiRWiqKnQw9tNpeJBSYtgTOo/tBFP/Gae/sgg2JvINW1TKraYyQj5Zy7vGC/9tTKeVBYdYdkHKZFos7C/8w/E3zxlS8LyUhMYm2afxV7ho1HtEunsjCRvhLDnb8GHfMKqVA1lsv2Xm6ZwsFOd14KT6RHKYJxkJj+iqOygr+ne1K6EwdwZrsbP5vrK33leksZQAJ4FrWaIzN7Rf+cVUQu4VScXoq8H2eAbVL6R1fyxjBYEBaobEzGqjc4v8n/sOSDY6oakuaK3UE/C+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+54c6lB8xWVPIgbLfsNVeAUqO9co3OyXFUcbQ6Myv4=;
 b=ODoNbjlMibm2nqpHFMdgqZ6Fv/91IwVuBhaaXRBjoi8P526EkkCv3POv0cBtqwjIChvIvDxEZnaRzhdnU2jghmQyMr8BVN1baju16SJpZKZdofAeTyRiYsGIAl2MK4IInys+d3cPX2CEzzcNTWOzNOEQzY+U++H60Z2Sl6SS6QK07Hf/mNH22ZIn9K2aehMgio8XDHSfRexmHTuh5BoiX/+VGNra27ssQu5u2LCqYDknLNkyX62EqGNcpX2Iebz1Z9XEZy3Ew19E3N/SAoYmd8OACRszyc1jCtO2lD3aC/7dXXelRuKmC8XX13LMZ6lp1Q+Jbon4/NMh6RPP+UEtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:52:46 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:52:46 +0000
Message-ID: <29531a24-a86e-4e2d-9f7b-d886177099d7@intel.com>
Date: Mon, 14 Oct 2024 22:52:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/28] cxl/cdat: Gather DSMAS data for DCD regions
To: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, "Len
 Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
 <CAJZ5v0iFco4htzfW1sYYKKh67oe4GsnUBOPRiunHQ1n2FHa3hA@mail.gmail.com>
 <67098cb436d87_a55db294f8@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <67098cb436d87_a55db294f8@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eda861d-5fd2-4115-0947-08dcec9227e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUw3cUVCWG5IVFVjamZBM3V4eEZJb3RJVmVsckRXT3RMTk1YZ1pTWUthaWVY?=
 =?utf-8?B?dHR0ckgvUWt0Y2JMVDBTdW0vdllPL0pkZmo1ZDFGZHFiMHlkK2ZIc3lyaGtU?=
 =?utf-8?B?VjRhRUJHQ0NHeHF2VkdleDNaN0ZWR21FYXNiaUR0SVdxd0NzZkYyendZb0ti?=
 =?utf-8?B?MFU5czJ0cDMrcDAxOGlubEhkQmpKaFRUVWVrSzVRMmdxVjJzQ1VVS1orRkp5?=
 =?utf-8?B?MGFQRzBxeHNZbE1FVmtxMGVDRHJKYWF2ais2NFVoT1Nzd0w2REZzazQ2VkJV?=
 =?utf-8?B?K21Vanhicmc3MXRuUFJxWmZLdU96Rmc2dk91Q2IxQnhGdENOci9kOXY2VWJH?=
 =?utf-8?B?MVd0Sm1WWmdtdHd4VVB0WC82SklKT096SkFCUEJmU2JhNFBGMDNuOGVORjRF?=
 =?utf-8?B?d2dEeGxDWWZqVlh1elhpeVd4RDZaMVRpWHNqbGpobVliVTRzckRZQWk5YkZv?=
 =?utf-8?B?azgvWXZrT1JtRkkyM3JqMGVKMVNHSEhzdm5rVnNNU3J3OHhKU2ZOb1IwdG1Q?=
 =?utf-8?B?N0gwUUFQOXpYMU9FU29iSmd5MWFidi84UDFRMCtlWWlnNmxWaUJWRmdMSzA2?=
 =?utf-8?B?RUlFZ0V1L2Naa1hSdTc4bTAwQ2pPWjM1SVhWZTRKdGxWWVhFUzYwN0hCNUtQ?=
 =?utf-8?B?MmtGdjJvYzQ5MzFKdTlxalFpUGZiNmMxVWFheHFNMzlObGdPVkYxbDRsTVU5?=
 =?utf-8?B?eUhTcFlZSCtlck5jWTZ0RzRHa3RGRUtxUkkxMXZCMlE5dVQweU1OaG00WDA2?=
 =?utf-8?B?NGtSYnN0UEpKS0tESFZyc0lzTlVVSWhVckhlbk5lY29uZ2N3eUhXY09iZ3FM?=
 =?utf-8?B?SllkbGhHeUtwUlBOWDJSU1k0cmdoTStKYzJ4R3hrQ3JUOHFPeElwYXZDMWly?=
 =?utf-8?B?cDhaWlJZN0ZHMFhFc3huZ3VGM0F6UVc0U0pncTRDak5MSi9GZHZvcFp2dE4w?=
 =?utf-8?B?L3hhQkh1bWEvMTUxK2dJYVM0cjZObC8yanNxcFVYR0ZBMVlOUXRPUEVOdHdj?=
 =?utf-8?B?bTgwUjlPTTYxUnFWZkpnbHVYT0xRQzZTUU16S1FrcnRwOE5pWEFsYWI1b0tZ?=
 =?utf-8?B?c1NOUHlUUlYxbFpwSlNyb0tTME5NUnFqK0h3cTZQWGhVQzFrZU4rcEFmaFdh?=
 =?utf-8?B?MVloZmVqUDZZK28rOWdWTk5DZEFTT044VE9qbmxtMVczNnhhMzF5OHR0alR6?=
 =?utf-8?B?Y2xmcWw5NG0yMDJoblBCVHBzd0lSRjFuTXNxT3NFNmU1eVJoWVh3RTFQQzAw?=
 =?utf-8?B?OXNOMm9lTERWdVk2cDJDbG4vd1BpT0luVExkb3l4M080emRTTWpkRlhNSVpY?=
 =?utf-8?B?cVlGS3N4anFtZURPVHBSQmxISjYxNXNSNDBxaEZoWk1VT3hPK1ZvQllWR3dG?=
 =?utf-8?B?elpSTWdEZWZEQlZ5bmwvRDFiZnpVSTdGRUE1NHZmbVVSYjhCaHNCL0d4ZWM0?=
 =?utf-8?B?ZzhnSzZEQTI4UDEyZDM0ZkFhaEZqQldWelo3blJBZjMrWkQ5b1dWUlB5eTV5?=
 =?utf-8?B?VjlOYnNLaVNzeUlMZUduSGU4RklWbkN6blFIeVlJRFBBMkdPeTVCdXdEUk9U?=
 =?utf-8?B?TGNlV3dkMEtSYWFIUkdqbGF5V0Rvbi9HSDV5U0NMODB1TVhBNi96YlRiSmFI?=
 =?utf-8?B?bTZnYWtZR0I4Wk51RVhNL0FmR1AyU0ZGdEZUYktSVUtaVHMyZ1FMVDRYVXQv?=
 =?utf-8?B?VnhmbzB0Y29kaWFMeUs2OTlVQ2kveFd0YU00Mi9heFZVbUFQWnpXdHl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG1jeDA1NUhEanZQam9seUc5Wm5XZFI3OUVVMytVY1JoZFNsbzFWUTF4aC9K?=
 =?utf-8?B?b3BJejFOcTF2Y2NzMXRzZ2JaWTBNQXc5dUNiTmJCazEyOG55WjkvS2ZpSElt?=
 =?utf-8?B?WXNpSkptNW5XU1NsYW5YWlQrQXE0Y3g1N2E5Qk10TEs4SVVNSVluSFdmYnor?=
 =?utf-8?B?VnA0b2VHWE5rcnNLMEJ1cmc2MCtpenJEWFpmNmY2OU94RXBrVC8ycUxzSjlU?=
 =?utf-8?B?RGt6QmwwS3Q3TTNtbnFQaWZaTmlUeWpLQ3g3MHhBMGNCT3BnL2V0V2NUS0FE?=
 =?utf-8?B?ejV2VlByK1hTUlJxYWxZdVRXWE55UXo5aTdlYVFEb1lSOFd4WmFhT2JvNERO?=
 =?utf-8?B?bHNGOFliejdnTG9LSWRSYmZLbThBaEIrUWZkRFhtTWp2c21DcTJtUTZnc3NX?=
 =?utf-8?B?VmRkRm1MYy8vcmt6SVZMRFg1MWd6bWZEK1RJeXZLbEo2VXhMbEZtd1Q3Sllt?=
 =?utf-8?B?YnZ5d2xGYnpjRlU0d01yeVhITzNMeGtEbm9KNzNUT1FMNDlQL2Q5cTd3cTlV?=
 =?utf-8?B?Q2VJcXJDQTBqZ2d0ZDlXeGVJeWtkNjF1b2RoYlFkdG05MkQvNTNicDZPUW1U?=
 =?utf-8?B?VVg0Tk5ib1JqY1ZHOGVKMGJCQk9OSGt0TVFFQ0x3clZHV0pzZDlNc2toMmlQ?=
 =?utf-8?B?c2s5d1JHaitjV0JheC85YUNaZ29CRmh6bWdlUlVUL1MzV2NNWnZBb3c3QlBu?=
 =?utf-8?B?RGQ3VFFtR3F5VUdxMDY5WUt0R3RwR3AxNEFCSTk2dUlXQ1ZBbHpGZmcydG1n?=
 =?utf-8?B?VXRIQnU0SVpqaFNvRFdoWlFwaEpMcUY4UXZUTUF0NXp4aWh4ZG1ybVRPMllD?=
 =?utf-8?B?a2RZUlRpSmloWldvSTZzbS9wQ0VuMkwxWXlzV0lxKyt6YUJwMlZER3cwV0ds?=
 =?utf-8?B?aVhobGttejlCWmQvNmZCaXYrVkc0b1ZPTFJFZHlaLzRhMk9zSEgyOEtwa2lD?=
 =?utf-8?B?RDI0VTdpSGJtODY2S1RTdHB0bTZySmQ3ODZkWVAyejE0L044djhGQlRDaWtT?=
 =?utf-8?B?bVh5b0U3OXdWaElUckNlbUx3dW1WcGpWN2VEaHRZOEpQRkRGTGJ1emk3dDVE?=
 =?utf-8?B?aXVCaEZpVTNVS2NnWGswZlowM0RxYnhZY0lnWTJsU0pDTEZFOXoxSHhGWFQz?=
 =?utf-8?B?S0srL1ZjUHpGZ0QzMmp0eEdnd25UY2kzS20xM2JvdnR0Q05PR29Qd2dJTDRD?=
 =?utf-8?B?YmFzTERwVWJ2SjFxcjJyM243ZG5hUStBRmlwUTAyY1I2bjl5bThPZ1BHeFBq?=
 =?utf-8?B?TUk4VWc0S3dwanV4djBUY1llbFhRY0l2eUpteFlRcG1PSGFiT1poVVVoQnA4?=
 =?utf-8?B?VU0yMHpWd1dtTUs1akNjZnFVTmVJWUxJT3RORHNvNWQxQVZlUFZMWk1KLzVa?=
 =?utf-8?B?MEk3QUNyZ3NMTGxKT3FxNnFkTVdac1VIWHFQT2NlYlhuK1ZEbFFYY3dmK3V4?=
 =?utf-8?B?K29hSklGNUt1SURZSm1Pa3JOTmt6NUFyY3dKY09qWnd4MDIrSTlZYUV6ZytP?=
 =?utf-8?B?T2pTTUFESEFLeFE1THZWNEZLc3F6SFp6UW1yUzRHZDZ3OVdhMytPVHJrTjYr?=
 =?utf-8?B?dkY2NHlIS0xnSGVjbmFTZ0dVN0pJMnZvQy9ET3FpcTNLeXVsUnplTFEybExR?=
 =?utf-8?B?TEVXbDBVNnF1a0kvOTZ5NVhwRERtaVg1UlBBREZ1aTNqcHBxMHo2d05IL3Z2?=
 =?utf-8?B?Y2NVak9zQ2M2YnNmVU9MZExEa3VadkNaQVU4UUoyOFlidFN0UmJnMk9INHA3?=
 =?utf-8?B?ckgxRjU3c3g4QVhoYzc0V2dDR3R1ZmZjU3QzRUFSOGdHTndqSjRSelgvUTcr?=
 =?utf-8?B?WXQxd2FkUHQyN2dEYUU1MTVsUi9BMlFPWkpYRUJzSkZHd3BWYWhOajRRQURX?=
 =?utf-8?B?Zmppa2dJYlF4OExtcGhuTjM3bGliRmsyWnhoTnI3a255dklnbVpvSmM5WCsy?=
 =?utf-8?B?SFJTOHpYUjVOWHQzWkJPNUlLb3RHVnZIOTg3TXQyZml6N216NFZlWkhaektq?=
 =?utf-8?B?dmhlOWtYYUdNWVJIZ21MaTVoZ2twT3VzQW9ObVNNYjV6MUg1bVRjeGJSc3o3?=
 =?utf-8?B?NXdVak5UaWhvOXBiUURlY29qTjY4SGwzUWN4VXloaXBpVzhtNVBOc0JOcnFF?=
 =?utf-8?B?bEVpZmFLcmY0bUl2OUljeS9lZTkvRk5JdkxySFFmVHJHVElMZFJDTzMvdnhy?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eda861d-5fd2-4115-0947-08dcec9227e2
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:52:46.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWbrxA9W5N2E0Fhfhwkc7FjzumOM1xltvPujjisEzw711HJPc5bQIUPVyHKeRDVpITQb3vMyvAOXIGu84TQFnqDiOINUf9cpirWq9+OrxgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com


On 10/11/2024 10:38 PM, Ira Weiny wrote:
> Rafael J. Wysocki wrote:
>> On Tue, Oct 8, 2024 at 1:17 AM Ira Weiny <ira.weiny@intel.com> wrote:
> [snip]
>
>>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>>> index 199afc2cd122..387fc821703a 100644
>>> --- a/include/acpi/actbl1.h
>>> +++ b/include/acpi/actbl1.h
>>> @@ -403,6 +403,8 @@ struct acpi_cdat_dsmas {
>>>   /* Flags for subtable above */
>>>
>>>   #define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
>>> +#define ACPI_CDAT_DSMAS_SHAREABLE           (1 << 3)
>>> +#define ACPI_CDAT_DSMAS_READ_ONLY           (1 << 6)
>>>
>>>   /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
>>>
>> Is there an upstream ACPICA commit for this?
> There is a PR for it now.
>
> 	https://github.com/acpica/acpica/pull/976
>
> Do I need to reference that in this patch?  Or wait for it to be merged
> and drop this hunk?

Wait for it to be merged first.  Then either drop this hunk and wait for 
an ACPICA release (that may not happen soon, though), or send a Linux 
patch corresponding to it with a Link tag pointing to the above.

Thanks!



