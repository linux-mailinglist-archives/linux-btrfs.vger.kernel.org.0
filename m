Return-Path: <linux-btrfs+bounces-19436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60957C97DCF
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 15:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF83A3F70
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8431A542;
	Mon,  1 Dec 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INEqIXOn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729071917F0;
	Mon,  1 Dec 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599573; cv=fail; b=sib36XJZZU08fE4+Aq/EcKx1JjSItn95iWO+X474ygbYhYWbR29KOAPnAVZfOpQGV+dByvN0d3FhrzDzm+kutaHA8EVvbnvPZcA4poLkiMYXNU2Rgk39AfqJVKhFyBboyerV95mtB5uz9xGDKythfn7eBzR+lcADT8fMUh2wZbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599573; c=relaxed/simple;
	bh=kL1RijbnQ13N/k6XtZXvCMAYL79wSun9b7cb45EPa8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g+UDtXM0QKZqS0zZ8atHI6ZEuGzCRPk+CNcYA8E2lNBksHcDdNOFx7MNQXugGSj2SfTePe64N/LCno5fEjpmR874vqf0r1duFQhEzaep3LGTjTKP9f5FR4CAbGtwV0Diivssjo/Aif+9HZIgAcTxRQNAERPuh0dAWam63o+XGOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INEqIXOn; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764599571; x=1796135571;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kL1RijbnQ13N/k6XtZXvCMAYL79wSun9b7cb45EPa8I=;
  b=INEqIXOnnlQ7tHgxBpOMTyXvfcuegFsz4gxJsfwWltCMdCfxjgX5/2Rc
   w9ETcUV5cng6uehTGw00pGXlEPCQqNPjfVdOBFLXT6tDdzAJoWMAlEYC7
   qdLEjqQ1ExtdgZgtqIX38uxxuiTirmox+ETUDkpk2nkQyCzi9kFDXtSVL
   qfyak9p/mwFXC49NdYWqobnPoJqMFEcGKyAUYFcFJ1nVpEVOgHZ3EK1nC
   +tWonuxceO4WNFG36564MzZI1N3DTpceqdYvaYuwxhxl5Eaq21TCFYV/t
   k2B+YexSrDAf3oy9+VaMPRYMQPLZEtIZsUrlKyvjHKOA2H9Zr6rOcdcEO
   g==;
X-CSE-ConnectionGUID: dfWHRNhPT7ibU5BL52gS/w==
X-CSE-MsgGUID: PkbzaeVITR+legFjlGT70g==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66430385"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="66430385"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 06:32:50 -0800
X-CSE-ConnectionGUID: LEJ/iUfRT7mJG+kH6H7xKQ==
X-CSE-MsgGUID: dnnslIbsSJ+4yjYAV1wQDA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 06:32:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 06:32:49 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 06:32:49 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 06:32:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8UItznaQMTRPp6LG8D8ubRs6oX+f43O5lk57JVErD1tYzLlCsfDjiUEOHr5nK4EhVc67CzswXyppCoMBB8ZPNiat5BjtuZ6leJfQphEzgeHRCBrqfLMERJ+POz5yIB/o3C5wOQVVAKl5FB/Zev20fsM53+SnE+xQ1BlIUkm2evWq48RH8gfBQSn47RZE4X7RKyCNYccpuJkRiT7Airb2bFRn2sMvloXIn2s9pQzBwqmzWTEYYovlA4bkf6sgq71uUoWNFnHjsp/Ot69lkrnJcSyowRm0DQLOzmIKzDwzJjgpvuMaO15IuYvZF7c3CVQw5nqJj8EwTz26tJatrPACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzdFQTET7+7jfpBi7mmJUVcyf4wXBGnTtolH75DZuOE=;
 b=SjYQfy3fmfMy9M0sMpbJ9+80Mj3ye0i8ou1Ma1ENJwL6EJEvo5wQjQZiGvr8qaLhnXxTj9hf5KZcR/HQWORmcsd0yUCSPW3+v7Tyk65GtK7/Jv/rDjBAT4VhHW1ZtJqMwXW5qpz17XY43Hv2lmjiQI8ec/Fgfd+qQI5crDRkJUY/6+rfANZYGc9lWXie3vVJzEa0Sd610v28uBG3r7g43F8u9u3gzbRgLqAOV+OMzgPt0ZG7LODME3/zGfuh0t9sF85nquAsu14klMDzMfjxI2j4A8/fQcZETBMlTu15f9BtOLhCZ7Q76/aCBa1AubMbZhhJywpWfbMJ+gpAZCKsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 14:32:43 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 14:32:43 +0000
Date: Mon, 1 Dec 2025 14:32:35 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, <dsterba@suse.com>,
	<herbert@gondor.apana.org.au>
CC: Qu Wenruo <wqu@suse.com>, <clm@fb.com>, <terrelln@fb.com>,
	<linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU7PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::15) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8d1499-f3d0-438a-2951-08de30e67d35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUdOcTQ5N01xNUI0REJHRmd2SndtWVZoSWI1ZnNCbmZvNmdSZ2FuMTZIbVBa?=
 =?utf-8?B?T3V2NXVhVDhBZjk1ckxMVE9pcmtCcTFCcFppcGZtdkxUMlBHSVhmVXYxeDl6?=
 =?utf-8?B?KzQ0Y1p1RHQxbnJicGtNeUdxQzRMZ0Y5emZCaE1hVXRZQXcxemZxK1ppTVNE?=
 =?utf-8?B?RllDbmZGbkhzK1F6RDlzUHpWdTU0bXZDRE5UT0c4NzFQV1pUblhsUzNiVXcw?=
 =?utf-8?B?SXVhQng0bm1VRmYvMms0NlJmY3RKNlV6SEc3cnZxTXlNNWI1MWJ4SmdablpW?=
 =?utf-8?B?dkpES0R4ckNJWTFhL0o1bThZZ1d6cDlIb3hkazk5c3o3V1BycTdiNzMwUW5q?=
 =?utf-8?B?V1kydEJVQ2ZBTTg3cWpFcWV6VmtiZ2JOMzBxdlRVcTFOaFkxVlNqbG8yVDE5?=
 =?utf-8?B?Y203TURMTnBiWlBJK29udTB3ZUFxTWNCbUJrbnFJbU1Sclh3aFd1RHZqNGtB?=
 =?utf-8?B?UnIvZy9zTU56cnl3RlNMN1c5V3p0bm1VOTV1VjEzNkdRL0dId3dGemMyM0gz?=
 =?utf-8?B?Qlp5UGk2MTM0V0tUNzYwOXd4djFmaW9ZTldxcWFMSGsxRnkxcnUwL3FTS09U?=
 =?utf-8?B?Ry9hd2h3NDJXTTRweW11N3hGaHJkWnMwbTJmVzMxd2tPcVpCSGNTdlhCN1RJ?=
 =?utf-8?B?VEJTemFPaHZ4YXlWaVF4cmtLRmdENCtpTXZEMzI1L2tnNnVrMUZkdk9sSVkv?=
 =?utf-8?B?a1dta3p3Q0pEU1h4U3pSRTRqRnNUQUFaYmtJKzdoMDRhVFFrcGgxVGpwSVN5?=
 =?utf-8?B?OXZ6Z25OUEtWQjVyTGllaTY5Ris3WWp5aVcrZHdvcVRvOVc3OEg4eCsxU0J1?=
 =?utf-8?B?RlNpK0V4N24xSk5ibXRQeVY0VjNXVHNzUVcyTTZGRHZCMTJCblpFalRYOUJm?=
 =?utf-8?B?WFJ6dHBENVZWSDVLaWpZWnNTNVk5cHU3bjZRMWFack5mU3V2MWhFMTJtclZp?=
 =?utf-8?B?eE8vSHY4UVNOVmJzMkZ0MGl1ZTZIMDIvRWFPL1V4QVBwSWpkZXNFa1ppQWQr?=
 =?utf-8?B?U1dteW5NbnJlMjJqbVF0eURyY3VRZEN5U01lWVoybCt2blZJRlR5eWZvMmVu?=
 =?utf-8?B?L00rYTJWa1owU2N0K096aTMwVWFRc1JLN0xteFlaS3NUdFJTNzAzRmtYUWZa?=
 =?utf-8?B?TUVyVnFydzVkd2dZdlRqOVNXbzZmeGprTGVydVY1YkRwUDRyL0t5WUpvQ2Nk?=
 =?utf-8?B?ZGRzNWZLRTc3VzV1TnFwcUtLZzFHdFIvT2ozbHlON3FldXlmVUxpenAwdVFQ?=
 =?utf-8?B?SXErZUw5NHNXd3lteUhiWTZybzJwZDQ5Y3N3YVhwdCticnNhbkFrWnJReFZh?=
 =?utf-8?B?bnhQM2lGRWIrV0s3QldGTkhJMXVNcENYWXNXaTNIanNMcU5Xd0J0M08xNjQ1?=
 =?utf-8?B?VFhiN0ptQUJnMHpvK2l3amNxRVRpcmNYWVpuN1FGQ0pBaS9ROGJDaGJUd3Zk?=
 =?utf-8?B?WjNRR09PTFJGRU5EM1g3V0RNRHphSFZXVEw4Q0pWWlBkL1JuMm9EbnoxMHox?=
 =?utf-8?B?YUc5OGFmZnlVRWFCR29HZVVwNTlTejhDMXJnU2ZpTTRVTnNkeWRCcGc3NU5C?=
 =?utf-8?B?U0VDUTJXYkRlNlJibkRJMkNFL1huZ0lZd0hNZkQxZGNVQXBDd3VrcXVwaGht?=
 =?utf-8?B?OTAydlNScFRqNkpJMEtvd0dkejVjUjlCcVNrM3dEVlB0dFJ2SldhK2FZWU9t?=
 =?utf-8?B?Qi94dzRzRG0rVk5nT0p2RW9TM25SMHY2OUxiaTM2d1Y1eUlueGNoaU91eVpJ?=
 =?utf-8?B?dG1PL2ZoU2Y5YVBEK05jN1BDU2kwVDJsenpLS0VJTU00R3kxL0tMWWh5UmJa?=
 =?utf-8?B?ZndkN3NDNnY4ZkJVUGllVDFkS3hKeGZCMElMelkxZnZ6Qkd0bGxmV0ZzenF0?=
 =?utf-8?B?NlhlMHI1WVUwUXJWdk5JeW5MTW5wMTRyUnJ2MW9WU3lEcnpWcGRNTjl6VWMr?=
 =?utf-8?Q?P7x5au/EOySHkEpBVpwFTuPf93Mam+8K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJ4d3hRL0VvUVU0czNzUmx2WlpqR1NtaFZISWpPcnFFVTVXK1FCL0NYdFBh?=
 =?utf-8?B?Z2xkT2VrU2pXb3dyNFo3V1g4ajFqdWR4ejhQUUtNRlJuSW1HWWRqTXNkSWpP?=
 =?utf-8?B?Vll6bzlJWExuRkxGN3p1dldnUGhNMWNMZExKdUNzNU9FZ2xPMldwU05zSGJu?=
 =?utf-8?B?OFFvRU8zYzhxNEFDeDNPSnB3eFBPUlBxRFg4RlRYeU8vdDlnSG9Ca3l2cjNG?=
 =?utf-8?B?aWhsWTRNd2pIVzI2TFpwcGtXZWFkZFNXaExYL3JnMEw0L0tyNkhLS2ZvenNP?=
 =?utf-8?B?ekF3UG5YVzJaZmFjV1NqS25WdnFXMkt2Z2FpOE9MSlpDYml6VGxHN01XcWVC?=
 =?utf-8?B?NDRSZk5VMGxTY1pOU0NWcnBsTE92L3NpWXhJTzlwYi92SWFSbzJZT1pzRjRS?=
 =?utf-8?B?aUt1RTRPMWN4RysyT25hWnRIOVFwTzJRRFpsWktRWXgrLy9heUN4Q2htYlZC?=
 =?utf-8?B?SytRdnNLbGZJOFBGd0drZExhd2FoMXRiOHRPOTcyclpVR0txRGVzRlQ5N2h3?=
 =?utf-8?B?WnllemgvRlFoZyt0RnFuWjJOWHNhWno0VE0xU21GRmdXcFZlR1dPQmRJMGZH?=
 =?utf-8?B?YXFHQlFuclZxYzdxa3pmcnVGblVUQkI4RlVCajVXOXZYSklHVHp0b0thblVu?=
 =?utf-8?B?enZWOFNYZXVMSlh2R04wRTVROVhYYkZlemtpWkIzbno4a2lNc0tNanpLS0hM?=
 =?utf-8?B?NlQ1OUtGUUFmeThmNU9NRW9zUFNCY2pMQ09RNE9JTkhsWWVwQjloRXVyT0lP?=
 =?utf-8?B?cm02dkY4c0Z1dnVlQ0xsZHFuaGFKVGZYME5iTlpUY2hnbXFnb3YxdmxWSUtZ?=
 =?utf-8?B?NVpPRXI1QWUwRERUYmxqeEFjVjFseGx6Nm9nNWlBZHRTNzFUcTVnVDA2cUlj?=
 =?utf-8?B?cXhBRCtRNHNrTlMzaUE0elhIenpHQkhtemlIZkxyS1U5TFd6NGVZYTJmV1Vx?=
 =?utf-8?B?OVFRWUp4dGI2SWpvQUt2bzI5MzBad0lYQWVQV0tGQWVnODZUSHlkcnNqYldu?=
 =?utf-8?B?VVlnTjNXSWtCa3lINld4Z1k4akRKTjlULzY3SzdtUzdpcGVvRWJOb0tETXEw?=
 =?utf-8?B?TDYzdGRmcVpicTYweWNJS1BMZjVzbUoyOUU5MEhENlh3ZVRPd0JWenVtZWtB?=
 =?utf-8?B?MDRoTTUxeEFRa1FtaEJUdmI3TWJwMUNmajA3cU1HRTNnTUFzamlKcjVJKzli?=
 =?utf-8?B?ZVQrUllSa1BWdG13T1U5ZUJyTFEvaUZkUjBobjd0K2FpaHpXeEtxUUU3WGli?=
 =?utf-8?B?YjNwaTZLMzM3aHN0ZThpa296OHRHT0dwOENjTXN1STd4b3o4NFREbzloNE9H?=
 =?utf-8?B?SW9HR0ZxNWZDREdEZjk0d1ovS2lRREhFL2lOOXJzQ29yMlF5bjQ5Uk4rNWRi?=
 =?utf-8?B?VjRwdUR0aGNtUzNFaGlTRkY5OWFmTEsyT0lvTWs1NGdaM1pLbGJ2elRleG9q?=
 =?utf-8?B?TGxBZmg4TFNXOElzem9KS3dPT0dqMy9UVVJVSkdWOGQ3d25XL0YvZzMvQVh2?=
 =?utf-8?B?ZGJmUEVzSjgwNGRKYVg0LzMxQzdFZFplM2JpR3J3bWF6dVI2eWxrZlZoUEV3?=
 =?utf-8?B?dU9lamhEZnQrVVBKbXpXeFRSQWozd3h5WjJTVXluV1MzOG42V2RiTDQxY0dx?=
 =?utf-8?B?TlBkK1JiM2lMbFFlaWNldzlSd0VKby9RdlRCbFhCSDBGMEI3NmpDaW1SdU9H?=
 =?utf-8?B?ZWFWUTZUU2NSdy83ZE5WajJ3MjZXdHErTFRrRFIwby8vcS8zUDl3aXVmb01F?=
 =?utf-8?B?enhTS2c4d2FQWGdDM2pVSjEzRXVnTmVKK3pESWFENEV3SXgyQ1ZqTW1LYXN2?=
 =?utf-8?B?UUgvQlJ6YWRFR3BSVWRWNFlVdGJkTTJnMjczNTM0RElsN05kVXJsR3pVV01F?=
 =?utf-8?B?SjdERXAxOFBvQUkxVTZObUl5NERhYmNZUFh2QXZicFQxOWN5eGdieFhaU3Za?=
 =?utf-8?B?a0lNU3RaSVZyNi8yUksxVHJsakNuL1l5OGZpL3VZQVZ6dFlJMDVjQ1NmQ1dX?=
 =?utf-8?B?ZjFiMWlVR01xbVV3Rm5tL2NHcVBJVk92b1l6akV6cG9DM1ExSStjMzh6cGQw?=
 =?utf-8?B?ejY5bVV4THEwRE5MVElPOHByT3hiTUJla21lalREZ1hHMWFDcE1ENmRoWlVl?=
 =?utf-8?B?SGY1N1pQQ1ZmdCtjaithcS92WHZxalpQODRMWTV3NzVVWjBBN01UWnk0Nm5P?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8d1499-f3d0-438a-2951-08de30e67d35
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:32:43.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xH79fIKgvV/0FwOjIRIqoSpI11hcko3sCUXFFQ5ArGFgeE+hlIUktqlLg6WIsQ60yzlD7wXAsJML4NVaTEgrIwuXHD5yue5dJhLkatIQjJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

On Sat, Nov 29, 2025 at 10:53:02AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/11/29 10:29, Qu Wenruo 写道:
> > 
> > 
> > 在 2025/11/29 09:10, Giovanni Cabiddu 写道:
> > > Thanks for your feedback, Qu Wenruo.
> > > 
> > > On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
> > [...]
> > > > Not an compression/crypto expert, thus just comment on the btrfs part.
> > > > 
> > > > sysfs is not a good long-term solution. Since it's already behind
> > > > experiemental flags, you can just enable it unconditionally (with proper
> > > > checks of-course).
> > > The reason for introducing a sysfs attribute is to allow disabling the
> > > feature to be able to unload the QAT driver or to assign a QAT device to
> > > user space for example to QATlib or DPDK.
> > > 
> > > In the initial implementation, there was no sysfs switch because the
> > > acomp tfm was allocated in the data path. With the current design,
> > > where the tfm is allocated in the workspace, the driver remains
> > > permanently in use.
> > > 
> > > Is there any other alternative to a sysfs attribute to dynamically
> > > enable/disable this feature?
> > 
> > For all needed compression algorithm modules are loaded at btrfs module
> > load time (not mount time), thus I was expecting the driver being there
> > until the btrfs module is removed from kernel.
> > 
> > This is a completely new use case. Have no good idea on this at all.
> > Never expected an accelerated algorithm would even get removed halfway.
To clarify, the sysfs switch does not disable the algorithms themselves,
it only controls whether acceleration of that algorithm is used, if
supported.  If enabled, the filesystem can offload operations to the
accelerator. If disabled, it performs them in software. The
implementation also handles the case where acceleration is disabled or
enabled while the filesystem is in use.

BTW, currently, the feature is disabled by default. If that is
not preferable, we can enable it by default.

> Personally speaking, I'd prefer the acomp API/internals to handle those
> hardware acceleration algorithms selection.
> 
> If every fs type utilizes this new accelerated path needs an interface to
> disable QAT acceleration, it doesn't look sane that one has to toggle every
> involved fs type to disable QAT acceleration.
> 
> Thus hiding the accelerated details behind common acomp API looks more sane.
Even if we hide these details behind the acomp API, we would still face
a similar issue with the current acomp algorithms. If we need to disable
compression acceleration, for example, to assign a QAT device to user
space, we would have to unmount the filesystem.

What's needed is an `acomp_alg` implementation that is independent of the
QAT driver (or any specific accelerator) and can transparently fall back
to software. We already have a software fallback in the QAT driver, but
as explained, that does not prevent unloading the driver or re-purposing
the device. @David and @Herbert, any thoughts?

Thanks,

-- 
Giovanni

