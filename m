Return-Path: <linux-btrfs+bounces-7766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24FE969439
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 08:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD921F23FDF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677E1D61A6;
	Tue,  3 Sep 2024 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdLS/h0W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E21CE6EA;
	Tue,  3 Sep 2024 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346613; cv=fail; b=fixYM5jx8907f81aBjm7nk8RJDW3l9Wz8F1RQTzNsm0kB8p74zuUWyxzbsdyt9fBmZdAx/TIaa2WxOin9NLme/3GoVMPbFdVltWLBvk663+3VZD3UdCZnIvWwf0dPb7ID9RycHkpjiUB9YITkI4z5PnGRVhQ0Gae1kBkHIyZwzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346613; c=relaxed/simple;
	bh=p90d2fbWETtzHZJPZ8M8jHy2VnWtYHC3iqWyPmsUzh8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qzj9misDJl/a7G6IcMROY6LnHpP82r3jt+Um3X7aCcZujr3NKpL05U3w8sE+aiYJrZLd4vAuDdHwY5Bg8Agdu55SNltfQbQj+nXsIAcL6DJu30QcDTY09h7FghT19DekHCPU+6qfv2ZLLmjuSSRuCE7cEiZz1UbFpxE9+pSyTC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdLS/h0W; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725346612; x=1756882612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p90d2fbWETtzHZJPZ8M8jHy2VnWtYHC3iqWyPmsUzh8=;
  b=jdLS/h0W8HmchZRcfcXF68x5tR+n1iYFRpYbo6xjkknaG0tHpTi+9Fzl
   PiCXWLfIxMXmM/GK3qfz74c+u9aNEtmdVF0zGlFbBARwKLbCJr0hQ+L8M
   BoSs0gx3fwaG8VfhNTSQGlNvyj0C7OZQ4aOPvpAwzXbKlREm3/ftzvD+N
   asysqulQaH7oR/PvOjJTes1JJDAqTpdLnZ89yeXTOT/jsrHsaD52/MCFZ
   4SCr+FCPIcm4yEJnai7yFmOu4K0ZRaKU1fQQ4XMh6Z+EX0Zfzms2ovOEt
   aj4aajhQbgVZYBjGuDTQ0UtGm2YxVMRbfXKQ/vPEBwqh1uJR6w7xCEcJA
   A==;
X-CSE-ConnectionGUID: cBI1NvUzRL2hJX9MD2bIKg==
X-CSE-MsgGUID: ypl6tSBjR8iIolCmcbm0AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="34533842"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="34533842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:56:51 -0700
X-CSE-ConnectionGUID: 9blw6pkaQGGMUTtdRYTULg==
X-CSE-MsgGUID: RE958JByQZSS0UOvBiPsTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="64786803"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 23:56:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:56:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 23:56:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 23:56:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 23:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIf/YcNK/2Jj4PS23ko3fLYIrxZbVfxR1Thq4+e7hBcClNulZ1LrBk5MIfY8+AcEfHuX++PFZO3kOXPeTzNXkp/bAXUCIRzLAdk/mkNWfxmtpKruvBdwGaBsdWHuQbv9cYRdxKo3S3jsAcMtSt6nyIwEXPV7Ic1k+ihx7rfFSJFuPjN316bw3AXHVFrRUrfpF5Csw27mBr7q/3EwesIEvn6jx3nPGVOUt5/4zeiturDOckJwUm/cIqjM2prXqbrUD+bq51NSQKwNjw1WDxudmoEhJkmzbi74rQwWMsbElEt9IpEHqIvKb/5VBpxwpSSZvNwWDl4IzqPqtbuQjIOR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD5zavdZ+K73tpMmOW6K6BZMzAE2U+62fxW0dQqvhFs=;
 b=EAMxae9oQ/t5a+WpKrssocew7d1RM/NMUyqN8dxkrJsZY0Ke+DOClhrwfRno98fa5Pg/xkJb7AOKTJjC/JPOY4GdmM5lqC4o1TuuER5a5rq/dqK1LT7kNqL96gP/jQ+szJvx269jSRvZAjVYZY8CDkkRj9nBoDUVsE+vatDJWeHsXdg731KrtWzysNf8HfcPo7rCsfbAVL5kPDNmWlA5fcMJCu4gF2gRoJF6i15dk+pADwoYi/prXeN/KtnNwo4nYociw4hvuuM4ONy5/Xo4NwXdsn919cHnHCFfLaciXF/i7UVlLlc6RoLotkExPzrcBUVuV+B4ccMJengNkk4XHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 3 Sep
 2024 06:56:43 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:56:42 +0000
Message-ID: <1f45b5df-720d-4723-9aa7-72073dc0ba3a@intel.com>
Date: Tue, 3 Sep 2024 14:56:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/25] cxl/core: Separate region mode from decoder mode
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
 <20240816-dcd-type2-upstream-v3-7-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-7-7c9b96cba6d7@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3068dfe-ec16-4118-09e0-08dccbe590c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjdDVTZJUEZneC9FYXFENzlFRWl2UzdXeDVHNzQyTGtyMnNmam9MNHZDL2lS?=
 =?utf-8?B?Sm93NENOc3hPdDB5bVhDcEY3Snp0eXVRUTd0a3BIVC9FRkhwTmlnOHRBMWdh?=
 =?utf-8?B?d2QrRjB4a2lXYVZTYTdMbjJXT1JaaERjVzNkeVBSeHlBOUdQKy9EUTZQc1lj?=
 =?utf-8?B?VytzeHJiNFNEMlBlQ3MxNksrZDJYcE1MZnBQTWU0bUxTYTBNdHJXZVgyc2V5?=
 =?utf-8?B?WGR4Y05yUW8xKzJxWk9qcWs4a0czbUFLQ1V2WjNWOU5MVkVibmhjVDZxaFF2?=
 =?utf-8?B?TVV6UHJEN2lJU2c2TUxvNldqQWVRSTJpdUtwOG9SUGs1N1FPcmFtQnZXYzFL?=
 =?utf-8?B?emFqRlRveGFEKzZZY0VzQkxYNCtUa3l5ck41S2xjQnh5OTUwYmYxcW94UmNX?=
 =?utf-8?B?cEx1RjI2MXlteW40Ry82UmVNbG1QcVhLY3FFaWFyZkxJbjFjUkc4dVB3OFo1?=
 =?utf-8?B?Y2dCbmFBRzVSZzFTeWF2R0pDNVRLOVEzQTNCZzAxQTd0enp0Y2hGUHNVa0lu?=
 =?utf-8?B?MlZmVzFCREJMM3VzZU0xaFlDUXdpZzFtQUhneEV4NU5SNkxxNkRWQ2xVMkxh?=
 =?utf-8?B?aUtZa2RsZW5KcE8yU0JuRm83eGQvY3Jtb3R6L1FrNWJPVDRsRlhQSytEM2ZL?=
 =?utf-8?B?VnliMWdnWFQ2YjNvblBXQi9RZEQxOEZOWmhsMlhGTWZXRFdUOFVCR0loQ2Ro?=
 =?utf-8?B?VW5PUmN5bklrUU9yaGE5cnRMbDU0b0ZERHhBaDVES1hoVWsxVDNROUptT0hY?=
 =?utf-8?B?UHZ4SitHVEhsdmN2eXFqVHZGZlU1N1BRT0Q2VnFTQW1lK21NN0ZrY2VHQVo5?=
 =?utf-8?B?eWRaMEJRaC9FdHJTUm1VUEpBZzk5WUw5ZmNlR1BtSEIvd3BXOXpyT2JPNlpK?=
 =?utf-8?B?d3ZtNE8zSTIzQ1orRTFEQ2pWV2srdVFGckYxNjBlSWdIck5Jc3NLYlVxUHZy?=
 =?utf-8?B?Tmdaa2hMdzZ1Q0U2L2pCRC95WGxSTHlvOXE3Tmlrd0U0dWtSL0pyRjB4UlFK?=
 =?utf-8?B?TEU4TGpSb0x2Tm0rL2F5WnY4N1FRZ2tIcHZTaG41VkRqbmZZK0p1TUZtRVVJ?=
 =?utf-8?B?aXdaNjdRU0RCN0ttZzdLSVFFZEU1dG4rV2NpNkZtcTJDUFpZQTdqRHEwZzNZ?=
 =?utf-8?B?QzRrNUF6VGN0ZVdRTlV6N2IzQkhmOTRtajFTaVdIVkdRK1VKZit6TzNGOVVm?=
 =?utf-8?B?cytVclJPMktPbGJSejc4bUhLTUErRVZ4ZXdWdVlGKy9BTXFHR1AyMVVLRkhm?=
 =?utf-8?B?R1MwOWtSYUxYbG1DanJRbVBTRHNzT0FlRG9WTHdnTmZHZHdqUWY2a043aGIy?=
 =?utf-8?B?MUlxSmxmV3NPK0NRVTgydXZWSGdlYVd6bTdHWWtFL2dvUDBhS1BSVGhEY1JF?=
 =?utf-8?B?WmorQlBlZi9iYVpQenMzZUtzTUwzRVBuRWNDQWF0dlR6U0NPT2pEMjNXN3dS?=
 =?utf-8?B?QzJDaEtGbVVrUkNTNy9nT0MybWg0YVk1ZDNpWUwxbkdEcFAwdXJkS3RRVXZO?=
 =?utf-8?B?RUN3Y1NqeXIzRGJPSU1Vdm5ISmpzNFpFSFpkNFdCb2NRNkswRGlrWDJoVVVR?=
 =?utf-8?B?Yk1zcXBFbHk0TXJkcUxVcUdPUmRob2ZLa25rcklNTEQrTndyQ0xNQWtKS3pi?=
 =?utf-8?B?bENwY0VVZ1NJVWZKWEdBc3lYa21ST0lNWjhLQXlPZlZxVi9MM2dzS0ZEWmtm?=
 =?utf-8?B?YzIzbkE3RERwNFBuUkg0REd1U2VDNDNoYVdCanJBL2xlSjBveGQ2NWp0Tm1Y?=
 =?utf-8?B?MFExU2tIcmhuaG5iTDA1Qi9NUU40cXp2V2t6b01YZ3gxbXcxaXN0d2RaeUJv?=
 =?utf-8?B?NHpESk84eXNiaVRWdURrTlFjUkxOZVF0SUlWZkNwNkxTU2Q0ekR4bWkwSjNy?=
 =?utf-8?Q?YWsfm6yQ1Nh0F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNJRVFYQ2Q4Nmp3M3lSK2lJWjZkNS9IZzdiakJGd0xUenpNQjQ1WkpGcUxx?=
 =?utf-8?B?L3UvQkFnejNVL3hUVnIzV1lDM1UzbmdqaGpxNUdxbTV0b1Bqd2RJcU9BMEds?=
 =?utf-8?B?YnBjdjZTdFhIbXRuUXRyUThqSzBUT05FYVBWcmFJVWlweW45clRNbWlRZ2hE?=
 =?utf-8?B?QS9xT0xoY2RFa0tna1V3VUtFTEZyaDZiWnJyRXAxbU1iTXZheUIvM1NJQVJJ?=
 =?utf-8?B?Z2EzODRaMTJ5UnlqYXdER1F0SjROVUhVdXUrQTVDZEZEdFZwYnFJejdwY2VN?=
 =?utf-8?B?eUt2N05IUGkvK0xkaGsva2dKaDNZcGJtRHg1SkpDY1h4dktHVzg0REJ5cnlJ?=
 =?utf-8?B?SWdMSXpYRjVoOEw4U3ZObG5XaHhkNnBUeTArVGx5OTREZzNudmdZSU1Hb293?=
 =?utf-8?B?bHROc2lGZjdid3RKZ0ZWajhmYTFNZ1lwemlLRUFrMGFJOWdEeGpvbGt0TFBw?=
 =?utf-8?B?M2Q3L3VVbnBWQkVxR25DOVQ5eVRhc3oxaW8zQllXMk11V25ieVRPL1I1Tm8x?=
 =?utf-8?B?bkkyUDhTODhXSi94TnpMbUkrS2ZWSUdlVlNJWjc2eWsxYndkNGxxZ01HSEYy?=
 =?utf-8?B?dTRxaGs3c00vUFFGSHZhaE1rakQyU1J0em85QWdkTy92YWpQOVZqYmhFTTBX?=
 =?utf-8?B?QjU4QzFmWkphNFBqOFFxUStaNVJ1YVVBdk9oRXdKRUZnTzZWODY1ZjV6WTVv?=
 =?utf-8?B?NlJXNW50S2Y0Y1ZCYlgrU0JMTmJvVS83NkhROGFXV3RyaFZ5ZzJpaWVIdG5G?=
 =?utf-8?B?R0MyQ3BQUHFkVzRnRExRN2V6MGxyaERkbWw3NkU3S2VLUjgzaWx1cWdFdlIx?=
 =?utf-8?B?eDNRelFTcGNHQS9SeEV4d1o4NnB2bXArMDFyWW9yVDFMSURwRzM2dE9NbTNu?=
 =?utf-8?B?cXFlMkd5YXVRd2tqQWtLd2hzVFphYURQMFZ3Rk0rbG5XZmpuUGhTWmJaY0hV?=
 =?utf-8?B?eG1tbElZLzlYZHBaek9HZVJGbFhZd2VCWTJEcjZFMlpZM3c5ZWI1TXp2ZzFs?=
 =?utf-8?B?cFpiKytIa2RGd3lkQkZBTkR3Ymd2Z1IvMWhXNk1wZWc3Umt0cUFXNWFOYTMv?=
 =?utf-8?B?MDZjTThLR2dFUUFxbG5kN2JSWjZoNmQwdm5rU3V1ODVEMW1UR2lQMzhxeFJF?=
 =?utf-8?B?Z0NpeEhMK0V0cHkyOW5va3BGRDNQdm55R0ZiTGpkOHN2eUE5SlpvdFdLUS85?=
 =?utf-8?B?V1l1b2dmcUxlNDY0dDY3ZVo4SEhrcjFhM0xqemtEQ3lVVjZCemsrTE4vZDBt?=
 =?utf-8?B?M1BLOXhhbWFqOUEzeHBXOUFzN1lPVnhMWE13aTV0QTN0THRyWVRrVEZ1dWdE?=
 =?utf-8?B?YWt4UDE2aUQ5bHVHRFhma21lQ3Z0U1RCek4zK3ZsSldaKy9sK01Vb0krdlZH?=
 =?utf-8?B?cFk3YkJhMEdpK3Nua1A2VWxJVHVLNGNyTy9PMXhFWTFQS1JxTDNlRXo2VWdY?=
 =?utf-8?B?ZkFPd1RMRFNycm1jMms2YzZGd1pGTGtVbkRFMlZWa3BLeUJpQnF4UlVBd2dk?=
 =?utf-8?B?ekdNYko4MFBSd2taL2Y0ZzMzcTU1dXJDODUxdmJWVUp0S0dKOTUzY0ZmUExJ?=
 =?utf-8?B?QlFGMktmVWs0ZkRZaEt5Wk5LWldnMEZkUS9MbURIc3dJRXpQbGVKRDlvVElx?=
 =?utf-8?B?dXJOVG1FSVZKZllNZ3hjSmJEaHVMVTFtYkRkOE52ZE56cWc4VVVMVmJFQWNJ?=
 =?utf-8?B?cjFXaitjWWh1WHNVcm5NSi9rN01HTmUwdE12cGlnbktnM2tVRE5GaHlIR0hX?=
 =?utf-8?B?Wk1rMzM0MnZ1UjhwWGk4RlltdUxsTWNQcFVSNG9CcGdNVU1LTjBoQjNueVp4?=
 =?utf-8?B?S25jSVFCQ2ZFbVZNNXI3c2xnOXNMbHNjWkM0TzM0bnFIeVZVWTk3Vk9YSGdG?=
 =?utf-8?B?aGNFSVlHaUROZFhTTXo1cWVIeWJHZCtTV2Y5Y1VuWmxCYlg2SFBvUTRwQ0h2?=
 =?utf-8?B?Uy9kaktjdFFvTTNTTHlOWG04SnpKWDl4Z3hwelBxYzVFVGZZbXMxajNyS1FE?=
 =?utf-8?B?MnAyV3Z4YlFpZkZ1VEpPTkpVa2x3TGdCUnVKMFlvQ3REdmdha0lEL3Y0VDJM?=
 =?utf-8?B?VllZajJjU0twWjdmZW1IYXBmRFlGaXU2eC93VFBTSk5teThLYlJHLzdLUlpC?=
 =?utf-8?Q?GaoTwFwkxFID7CFPiL3fwTGqr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3068dfe-ec16-4118-09e0-08dccbe590c9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:56:42.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRURVDcAY/l/L1HuVOEsW1yKX++KjaseV0MqJ4T8BcaojdPmmnCajsUT1f6AoyVMDQwqI9cjBQHcmEhfdaxZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
>
> Until now region modes and decoder modes were equivalent in that both
> modes were either PMEM or RAM.  The addition of Dynamic
> Capacity partitions defines up to 8 DC partitions per device.
>
> The region mode is thus no longer equivalent to the endpoint decoder
> mode.  IOW the endpoint decoders may have modes of DC0-DC7 while the
> region mode is simply DC.
>
> Define a new region mode enumeration which applies to regions separate
> from the decoder mode.  Adjust the code to process these modes
> independently.
>
> There is no equal to decoder mode dead in region modes.  Avoid
> constructing regions with decoders which have been flagged as dead.
>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>

