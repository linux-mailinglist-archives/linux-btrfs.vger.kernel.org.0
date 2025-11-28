Return-Path: <linux-btrfs+bounces-19410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9CAC9250A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349AC3A4D87
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09969264A77;
	Fri, 28 Nov 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsQ83pZX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F272405EB;
	Fri, 28 Nov 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339931; cv=fail; b=BSuzUoDTyFHPFsUSjoMcfgf1vnKYb8YTTRZSg1EL/iwdOPRq/COlGw3rFOfdcpUTjPIWK2gP4pNcKKDD/V6KzAopJ/7w3ulfZ8No2Y0q//pwRiUVFIxfRPrppaKBN1DwJdCFxNqv5QG+5Q6vRFqM6HQEBcutgH59pY0a2ImVq30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339931; c=relaxed/simple;
	bh=RypCay/z/vxzMf8n0s4JTCsn+v1WkAgBCOfTZ227Hww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yp5v+M1IKJFFQBFnRrhRG55KTyzTkjHAZX5NfIT1OXTI9xxSkWkf+/lhDWHOuokWfYLbhrUlOisfFdsjZWzv3eB1kM/kQ15ilFY1gvX8is86lXdtJDUzgcpcKBN8kk4WwwjgPiAChsQOxFvieTVdPytd8/SdKnQbkNt2SIS7PFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsQ83pZX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339930; x=1795875930;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RypCay/z/vxzMf8n0s4JTCsn+v1WkAgBCOfTZ227Hww=;
  b=bsQ83pZXOabjd7pKMlEdXjjCwvaMFL+y49Vri+MxvwuR69cDNbg7cA0u
   17eZOEJoufQFyNCMpriv3ot1f1PC4tcZz45R6Ve7EW6tX+xzC901xIV3/
   WyGzXIbk98f+xtS10s8E3lpnr5cF/MApMrTJKlfggrBxCM1wYYXJV0ACJ
   RP1GoTz1n4Sv6+JG05jbSmXhi08hRgkOL1znhCzGtepHhQhCfjGk/cOvx
   5HkzHlAhL3+BT55kGLzdBbuxLR6F8MqrBIc2LaGJSpbtnt2cNUZx4WN4k
   KdyqNyn4BdAVY7JoI90jPUPujuArEC69sw6KtBsAEy8lH/zhDdtwxOLKw
   g==;
X-CSE-ConnectionGUID: GO0qMTnBR6qU2kXTholbHg==
X-CSE-MsgGUID: csRwpTQXTGil8cEMd3e0xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66410115"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66410115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:25:29 -0800
X-CSE-ConnectionGUID: d/SvbiYBTS2DXHeRbH/hBA==
X-CSE-MsgGUID: CA8js6IeStWS1Bf5VFJIkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="197810405"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:25:29 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 06:25:27 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 28 Nov 2025 06:25:27 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 06:25:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSlGkAQ+rSfyG0GfClQ4JfsnKMSIWzfrcSmXIHc66UyBEP3fB+RiIW5iwF/OBR0lbht2lykdm6RG1KWbDfllIF7ZvsxZAuKWKu7fArhG38jbyUFvOCz0aNKqrsUldiV0zGjuYOE+dUQRbZmWwRJ2coU8OhpcC5a4eWEnnrBnv234ERjNnR3eGn/UVZGvzeAetIrr1aUcuLe+B8rLbEJ/Zg3PKrQaPlMHgztY3q4BpLJi4uYfc2Gz8YerZLO7GFlp4X5GIPGJzYQzXZIllYVkP49abQf1f0VZ7qo90zdZUxUl4Bq8yfvtw3rR9QehiUTw3F0aBJAlRnmlVO+5XFKvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DBEjt0pM3ADd7YD3/DAQpM+ejETMY5cEUju/Bnnfn4=;
 b=wCFMTuiFDzFLcEf13yNwAx8vjHM9uSSXP5TC8hF+ls90rgUz5f/ld6PKwKzjn8lxsNnCngZ1eVFfDmNEFo3gCemdhCOGesfa7aJKuJCy+/PSCJaXvVPgx0R5G0uJaRIXzersqJM7jvMpNi5QyyryYLy5FonAb98U9skBBOHl6NdxEQGbx8adtTni5JGPWgxAoQKvz1PIRV6cDPJjEmMkQSnWTj02amWpwVklLR3LQTEUXxuziXZp2R7PoIV1O5m3tVstB9t/dY73621O0szUuRiPBnHMmJCpkX/Nj9hNZDI5QSfVd0rIbfsyW7z5V+xRMAbkQ7/hsF9L++XOlzOXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 14:25:24 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 14:25:23 +0000
Date: Fri, 28 Nov 2025 14:25:14 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: <clm@fb.com>, <dsterba@suse.com>, <terrelln@fb.com>,
	<herbert@gondor.apana.org.au>
CC: <linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
Message-ID: <aSmwygmtIVgfm+2o@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB9PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::6) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 22901ddb-7741-4273-452c-08de2e89f7ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ltmEBpZ5+AX3VkoypEs11gEiZB6z+I2BLoCZCyCB1GjiG+G2FV0aZ3oUWtyS?=
 =?us-ascii?Q?6XmDQlsLZvSfBGRgBoIEZOQFIbg/mAgNKtNHVM84U6FYwx0iHyJoZUwNoBnb?=
 =?us-ascii?Q?kGstGkxgz5KvbXblrzGDgzw9o796TMOOGtpThoViTt3mV179vXzGhrNMJ0Jc?=
 =?us-ascii?Q?PH7745qNCdQF4xuDAG8MuTYLSAAUjAL14TYbP4FRQbtRBaYRdX743y/I2noG?=
 =?us-ascii?Q?L9JJZeQW87R0s8FKGjNhtvINzYoFf2jn7EiKW0d3c3Dcm+vLc2fq8VXjDgcy?=
 =?us-ascii?Q?qAypD1c760BejWX0Zo/VrNo/ovP+kMprb6VL54RbmGdinEjff80aOOGYAgvZ?=
 =?us-ascii?Q?Qt4+J0TNCa1gaQ0vBC0/IAtsflsKrP3yEd5CIbTgLE7KjR6+4pwsMExUNYnP?=
 =?us-ascii?Q?Zxwtz001RrmJ7uRUyFEyuEjtWe2OHjDqbgtSe6xvtRrg1daYN9PxjeF0qCNA?=
 =?us-ascii?Q?Qnd9yreIAAuxRiAnYZWiNuC1f+6mW+iraurL4PATX+VbKWIF5d3DeEB+48Am?=
 =?us-ascii?Q?Pj4qAjEZ4IDjUt1Pa9e1FI4FY4rwvnJ+k8R4NzP8CMZP+bjzzh57/3Bgged/?=
 =?us-ascii?Q?Gf4IREwkReGudJYM5q7F5bOReieIWuzqLjM6flX4N+MDpUJTLbl7DrxNMMoh?=
 =?us-ascii?Q?Xci9jBAjMJNBaVGtB0SCFjB5GcQQKc0TUB5waq0yZHlKDGI5/9lajRHyV2Vl?=
 =?us-ascii?Q?3niEinh3Gen/orGjGOtSjJHufstPiebAE0sMpFFOfFyWolS9yptma1Ina0fn?=
 =?us-ascii?Q?K11juRTzI4Z2mS+gdvfRZ0hsgtpFT3+JfOz5ArpHe1R5Shvf4DcoPkK+foVO?=
 =?us-ascii?Q?8I4st/5zMMTYhGu69gASMWR5fU9mzGI/UEPsPxI5orUJ0hKlBxIB8iHrNQCH?=
 =?us-ascii?Q?5JGKo7st9US4EQfIxa9ESHTWNevAqnX45WStQfMNwbO5nHXYBIWORAYcwlm7?=
 =?us-ascii?Q?AuIsr9FMygjNPYOzQ3Sl1zZLnf4htHO4Akq3O2heLTZ/6lD7xDFjrTRpry62?=
 =?us-ascii?Q?2zveK0IhChnk1yq1Ns0qPAR425vFhYFKvrccHXsI0mwCp2no493vej58qj/H?=
 =?us-ascii?Q?RxAxo0LEeGGMnNlVwGDUVsIjdIcgzxMAkzIzyAcD1DhBEQMT8kRHlh5rGZvy?=
 =?us-ascii?Q?Vy7N7WI6PZUyroVeMkmc9Ww5PjXyOuuOn1ZlIwPpy/puL3SoRKQYqOp+VD1r?=
 =?us-ascii?Q?IcT7MJLOjIra9JIDoOPxfKFBk63+YPER0GiSncroRSRp57i+dIo/Kx+XFL38?=
 =?us-ascii?Q?LyyNQcumnsPByZV++DqDdGvcSmVjZkEBJoYm5Dlj7pyOEEvLPSAas6n0BjXt?=
 =?us-ascii?Q?eLcdPGT9+lPyek16DbgxBY90a6Hj6+lYkqifxbWVrTK+7rJpua2IPT9uP4c0?=
 =?us-ascii?Q?OBf74DfBf2/8W2ph9zE9EkYUpyktQV1+6oxcZH3c6DwiJGkmgyxUGxasRj/B?=
 =?us-ascii?Q?u4AXxNmghMwwOs0wY59sEU6nyCvv/k3U4AWnOLYPW81V/TSuaxUKxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKH9vZEC8bSNsczj/jZk6FCWWU53ky5bii1ZHLDnNFBPnZkOo06HHnZy2RWk?=
 =?us-ascii?Q?pQJHwEmzB+U37quBeK3/j/5xoBGqo0u6+rOWN+8VtrY2oW18iFoccf95wbBl?=
 =?us-ascii?Q?Z08uSmHttT2Wyyrz+HKA77lLtY6DHvIOU3EP1FKRauLhlN1pLopytBqpWCPv?=
 =?us-ascii?Q?Ztg9jKTeP8s3Y3oHivuDVsruoLCeDBRAlSKNNEZUdOoI7GOesCEPQg+aXIWo?=
 =?us-ascii?Q?4P88xzNGaesgDQFfhp69zBoOwLARYlP/PAyPvQ1ZL+tG01+Xm1xFA1jk1k2v?=
 =?us-ascii?Q?+7K/rsHkHGz6/ENrcf98hxV9smzWusePszVS1kLkMz6g0MLbJYY7s73Yg2fa?=
 =?us-ascii?Q?Sv6v+QqwXzmzqzcRN/DChx4zEUHR/EnebRkgRZEGkasA8YAwHzgsat/D2rHX?=
 =?us-ascii?Q?hTgVllV0BSFCU3kR0RYp1mSeokcYauEB/cn7+3JHM7KKHXzN6gGZrMrPPziD?=
 =?us-ascii?Q?Z10WtnimMRaXJaZhKEwLqLjUTfDDuDeTT/XuVJyRsfP8+w/uYmi9igBlvblH?=
 =?us-ascii?Q?/l/hWieNSlatxq7ouZpBy3kLOQ8EqpjC//yYOKnY1dFbNQLrCPYakswgpAqZ?=
 =?us-ascii?Q?u9YRTxQrSVZGw/XMzvGqZJ0+Oe9O2EkuLvvxKkdvtaYWXreonDbZLDApAT0Q?=
 =?us-ascii?Q?WWE7bX2DxKNGl1WEc10Dnt0RQrBxzdFaHdYAh4kDLSngeJxP0nKZmDCHKE9F?=
 =?us-ascii?Q?mP7Pw//i1JgSPyG4UhgL2TpHsAa0VZVTZPisU7baRir1kS4/G7DlmIvV6Yav?=
 =?us-ascii?Q?YPjksVOw3tpzQzmjlBg9sNtBzLs9yr1ptxhiwFz806Yf5z1+ezkDTvQHtOrM?=
 =?us-ascii?Q?WV4A8jbJU3ryFxpycbI9y/4GOBq0SgcsqpCYA3pFj/cPNkNXW5gunRuszAOO?=
 =?us-ascii?Q?uAE8xfmGilfiPMDLimF1kpj2uuBS0sBAoFAuFM3ZNXZwcUrghCidkvOo3KaB?=
 =?us-ascii?Q?v0z4J9wVZrBUvfXIMtcAgD7znokSrm6oXg/EIEZ6lQumJdiiPgkn4ECNfUuB?=
 =?us-ascii?Q?xYvXVr6XQK26G7Gvv90s/41zbuDR1A/AQGhkkANGkXNPlfL298x55nzvcrRv?=
 =?us-ascii?Q?8KnhgYPr3gqrD14X9ZeN5Jh63ZXtDoh9LgF46StAoEZ6YwmO7hz69JYnCLt4?=
 =?us-ascii?Q?7bEx2aPsbbA/tfrB60xlWuZpHcKOGGmFvc18+9duj2rGxAfd/GOLVSNuTxOu?=
 =?us-ascii?Q?jfjht4wZOOhDu8S/4vkPHQBqoljbq3nv/1Dj5IIl+r4HSHPkWFSz4Kodp5jP?=
 =?us-ascii?Q?UGbBrvpvcoxWSpHfRuPJ2X8xeCIdrpqYC8fTEYmb8JfCtgpe5d1pCE+05fyc?=
 =?us-ascii?Q?X809EFR1Gi587ST+UZxiRQyy6G+I5vDUeamg4RoScYTZMMUGJnY/B0XVEwiw?=
 =?us-ascii?Q?hqvQfhhUD699DVubkBa6DaSwRXdeXtecAQh5n4Q9HQay9fpjrFltfqixcX8h?=
 =?us-ascii?Q?ePYK+ZHN7DJ8htr6yZEjYwB+nK8lt3hbE3rx6lVRE5oBLToptwH6uM2VwpsI?=
 =?us-ascii?Q?ccthKZp/TzolTKRHyTYCc4f6fLOPziH4JCfMkfzXOarFqGg7xmX8GsjKZIJY?=
 =?us-ascii?Q?HuvUrdq8mOl2KnLb5QQIzhCHbyJYkpmbSYhTFfPlJV0NfgKqjC5CHGqHGATr?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22901ddb-7741-4273-452c-08de2e89f7ea
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 14:25:23.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiR2lRVD6XfPt4gj5lz0uwZ5nTWq/HbxwY7KSXK0DJ0D2vR0+Lu070YQOVeY9S7TJ1EwOlIFrKzwJ0ELmzzw5O+3KKsm7h8J2sYY8nCe0Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com

Apologies, I just realized that there was a typo on one of the email
addresses in the TO list (Chris Mason's).
Let me know if I shall resend the series.

-- 
Giovanni

On Fri, Nov 28, 2025 at 07:04:48PM +0000, Giovanni Cabiddu wrote:
> This patch series applies to:
>   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> 
> This series adds support for hardware-accelerated compression and decompression
> in BTRFS using the acomp APIs in the Crypto Framework.  While the
> implementation is generic and should work with any acomp-compatible
> implementation, the initial enablement targets Intel QAT devices.
> 
> Supported operations:
>   - zlib: compression and decompression (all QAT generations)
>   - zstd: compression only (GEN4 and GEN6)
> 
> This is a rework of the earlier RFC series [1].
> 
> Changes in this series:
>   1. Re-enable zlib-deflate in the Crypto API and QAT driver. These were
>      removed in [2] due to lack of in-kernel users. This series reverts
>      those commits to restore the functionality.
> 
>   2. Add compression level support to the acomp framework. The core
>      implementation is from Herbert Xu [3]; I've rebased it and
>      addressed checkpatch style issues.
>      Compression levels are enabled in deflate, zstd, and the QAT driver.
> 
>   3. Add compression offload to QAT accelerators in BTRFS using the acomp
>      layer enabled with runtime control via sysfs.
>      This feature is wrapped in CONFIG_BTRFS_EXPERIMENTAL.
> 
> Note that I included to this set also the bug fix `crypto: zstd - fix
> double-free in per-CPU stream cleanup`, even if this is already merged
> to crypto-2.6. This is just in case someone wants to test the series.
> 
> Feedback Requested:
>   1. General approach on integration of acomp with BTRFS
>   2. Folio-to-scatterlist conversion.
>      @Herbert, any thoughts on this? Would it make sense to do it in the
>      acomp layer instead?
>   3. Compression level changes.
>   4. Offload threshold strategy. Should acomp implementations report
>      optimal data size thresholds, possibly per compression level and
>      direction?
>   5. Optimizations on the LZ4s to sequences algorithm used for GEN4.
>      @Yann, any suggestions on how to improve it?
>   5. What benchmarks are required for acceptance?
> 
> Performance Results. I'm including here the results from the
> **previous implementation**, just to have an idea of the performance.
> I still need to formally benchmark the new implementation.
> 
> Benchmarked on a dual-socket Intel Xeon Platinum 8470N system:
>   - 512GB RAM (16x32GB DDR5 4800 MT/s)
>   - 4 NVMe drives (349.3GB Intel SSDPE21K375GA each)
>   - 2 QAT 4xxx devices (one per socket, compression-only configuration)
> 
> Test: 4 parallel processes writing 50GB each (Silesia corpus) to separate
> drives
> 
> +---------------------------+---------+---------+---------+---------+
> |                           | QAT-L9  | ZSTD-L3 | ZLIB-L3 | LZO-L1  |
> +---------------------------+---------+---------+---------+---------+
> | Disk Write TPUT (GiB/s)   | 6.5     | 5.2     | 2.2     | 6.5     |
> +---------------------------+---------+---------+---------+---------+
> | CPU utils %age @208 cores | 4.56%   | 15.67%  | 12.79%  | 19.85%  |
> +---------------------------+---------+---------+---------+---------+
> | Compression Ratio         | 34%     | 35%     | 37%     | 58%     |
> +---------------------------+---------+---------+---------+---------+
> 
> Results: QAT zlib-deflate L9 achieves the best throughput with significantly
> lower CPU utilization and provides better compression
> ratio compared with software zstd-l3, zlib-l3 and lzo. 
> 
> Changes since v1:
>   - Addressed review comments from previous series.
>   - Refactored from zlib-specific to generic acomp implementation.
>   - Reworked to support folios instead of pages.
>   - Added support for zstd compression.
>   - Added runtime enable/disable via sysfs (/sys/fs/btrfs/$UUID/offload_compress).
>   - Moved buffer allocations from data path to workspace initialization
>   - Added compression level support.
> 
> [1] https://lore.kernel.org/all/20240426110941.5456-1-giovanni.cabiddu@intel.com/
> [2] https://lore.kernel.org/all/ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au/
> [3] https://lore.kernel.org/all/cover.1716202860.git.herbert@gondor.apana.org.au/
> 
> Giovanni Cabiddu (12):
>   crypto: zstd - fix double-free in per-CPU stream cleanup
>   Revert "crypto: qat - remove unused macros in qat_comp_alg.c"
>   Revert "crypto: qat - Remove zlib-deflate"
>   crypto: qat - use memcpy_*_sglist() in zlib deflate
>   Revert "crypto: testmgr - Remove zlib-deflate"
>   crypto: deflate - add support for deflate rfc1950 (zlib)
>   crypto: acomp - add NUMA-aware stream allocation
>   crypto: deflate - add support for compression levels
>   crypto: qat - increase number of preallocated sgl descriptors
>   crypto: qat - add support for zstd
>   crypto: qat - add support for compression levels
>   btrfs: add compression hw-accelerated offload
> 
> Herbert Xu (3):
>   crypto: scomp - Add setparam interface
>   crypto: acomp - Add setparam interface
>   crypto: acomp - Add comp_params helpers
> 
> Suman Kumar Chakraborty (1):
>   crypto: zstd - add support for compression levels
> 
>  crypto/842.c                                  |   4 +-
>  crypto/acompress.c                            | 133 +++-
>  crypto/compress.h                             |   9 +-
>  crypto/deflate.c                              | 118 ++-
>  crypto/lz4.c                                  |   4 +-
>  crypto/lz4hc.c                                |   4 +-
>  crypto/lzo-rle.c                              |   4 +-
>  crypto/lzo.c                                  |   4 +-
>  crypto/scompress.c                            |  43 +-
>  crypto/testmgr.c                              |  10 +
>  crypto/testmgr.h                              |  75 ++
>  crypto/zstd.c                                 |  48 +-
>  drivers/crypto/intel/qat/Kconfig              |   1 +
>  .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |   1 +
>  .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   1 +
>  .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     |  19 +-
>  drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
>  .../intel/qat/qat_common/adf_accel_devices.h  |   8 +-
>  .../intel/qat/qat_common/adf_common_drv.h     |   6 +-
>  drivers/crypto/intel/qat/qat_common/adf_dc.c  |   5 +-
>  drivers/crypto/intel/qat/qat_common/adf_dc.h  |   3 +-
>  .../intel/qat/qat_common/adf_gen2_hw_data.c   |  16 +-
>  .../intel/qat/qat_common/adf_gen4_hw_data.c   |  29 +-
>  .../crypto/intel/qat/qat_common/adf_init.c    |   6 +-
>  .../crypto/intel/qat/qat_common/icp_qat_fw.h  |   7 +
>  .../intel/qat/qat_common/icp_qat_fw_comp.h    |   2 +
>  .../crypto/intel/qat/qat_common/icp_qat_hw.h  |   3 +-
>  drivers/crypto/intel/qat/qat_common/qat_bl.h  |   2 +-
>  .../intel/qat/qat_common/qat_comp_algs.c      | 712 +++++++++++++++++-
>  .../intel/qat/qat_common/qat_comp_req.h       |  11 +
>  .../qat/qat_common/qat_comp_zstd_utils.c      | 120 +++
>  .../qat/qat_common/qat_comp_zstd_utils.h      |  13 +
>  .../intel/qat/qat_common/qat_compression.c    |  23 +-
>  fs/btrfs/Makefile                             |   2 +-
>  fs/btrfs/acomp.c                              | 470 ++++++++++++
>  fs/btrfs/acomp_workspace.h                    |  61 ++
>  fs/btrfs/compression.c                        |  66 ++
>  fs/btrfs/compression.h                        |  30 +
>  fs/btrfs/disk-io.c                            |   6 +
>  fs/btrfs/fs.h                                 |   8 +
>  fs/btrfs/sysfs.c                              |  29 +
>  fs/btrfs/zlib.c                               |  81 ++
>  fs/btrfs/zstd.c                               |  64 ++
>  include/crypto/acompress.h                    |  27 +
>  include/crypto/internal/acompress.h           |  15 +-
>  include/crypto/internal/scompress.h           |  27 +
>  46 files changed, 2253 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.c
>  create mode 100644 drivers/crypto/intel/qat/qat_common/qat_comp_zstd_utils.h
>  create mode 100644 fs/btrfs/acomp.c
>  create mode 100644 fs/btrfs/acomp_workspace.h
> 
> 
> base-commit: ebbdf6466b30e3b37f3b360826efd21f0633fb9e
> -- 
> 2.51.1
> 

