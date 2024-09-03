Return-Path: <linux-btrfs+bounces-7768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327FF9694A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF30028357D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C271D6C4A;
	Tue,  3 Sep 2024 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLG+mZwH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529F1D6786;
	Tue,  3 Sep 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347126; cv=fail; b=Ubn8ORA94VKZvWM70Pgm+E/3seKMAMm/Lr4Al/zmdYJLHjM5XEaJ1SYLg4FiaEhA778ZepKFGWDclrcKUSyv45fO0ep0QDMgvthdL5vpxdRINkM/HnGyk/sgxJy4Tv279TcoqgobegocQbu/c59PDUYo49hAy9gJvqS2vhr5BiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347126; c=relaxed/simple;
	bh=Y9BI0UxXBk0a/gWE8ujJ7gCZ79B2fvtmoIb0m82hu8Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=soCQCEUhrOZsP7a1XLcW+biBwdfIzGmJCwLLitQ6VUz/Uh0CMFwkgdFPXmWWTL3XBIXXne6UqqPDNDHiN5PLEWuZ8D5ygVdLgmiDKzZ/f5T3bA+VVkV9miazYncVmmYSBKBsZLyHdLrFokAw3HuRfo9vPOeXKkPGhRBAM4yOGf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLG+mZwH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725347121; x=1756883121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y9BI0UxXBk0a/gWE8ujJ7gCZ79B2fvtmoIb0m82hu8Y=;
  b=nLG+mZwHCxF2Q1krAq3zIP4NtoaOCO08BpSPm6e4u7MHNI1D/7o8gHoU
   SkD+5PJJJE6I/oEmzcJsq0DbAaXk1Ei2aaYgNWdjQMjQQnLCAsekU/SPI
   VhfA0zQcSP7fTMSRrRepFtsRsvxIhdDw/MDQdAwa2W4fFAt5DezMdmslL
   TAlLgbDGt/ZOOakHm/0wxvXgZEoqaO1jvP9Y0Hphm/jJnt9dkNHpKVSQy
   PH44L7wTIg0NoSgVWG8RMfzfiUE8u2c4FPOUbwQl7JXxsWyNzsBk/TXLm
   +EbXOeN/lbxF9GbG4nRVLidJHPOMDtCTZoOzjiEfaxFW7kL2M0OsgLS3h
   Q==;
X-CSE-ConnectionGUID: WFEA51cwRSS4KaWaujibZw==
X-CSE-MsgGUID: smdBBQLqRW6NyFeC0uBfCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="27719465"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="27719465"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 00:05:20 -0700
X-CSE-ConnectionGUID: KDwfuOoiQQ6IGj75e7C3wA==
X-CSE-MsgGUID: CYvDFSpXRdWKYwcDIj9Kuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="69605272"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 00:05:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 00:05:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 00:05:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 00:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSJRECv6ykHxukvdMHDOcqqKWwB+Me7EImLQLxQxCC4gdTsuzwvktSgKINXiI5HUNO3svVXBfeCBRuG7A3IJNPXGdx3MC9AQLeV0lCoRjAs6vicbfqSR+BS3dz7oTrMSkOoKWvC6cp5Dk/f+tWicHub0/ODL8xGmdvEtP3K2O+nFY+6BdQoEklSoJxV6+DB9bWTm6fTBm7U+Fs85oON+aTpFmaLof/TRabpiekNNMB2PuAuhVHwk4RWyNuvMt4QzeTqJoTxuQR7osqX2x8BZtpLJ0sJUfqo0TAO5mMXrKnVcscg8S8hIqU38XCsz3Fm9JsNvb8beUNg5LGWqNeHTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+0KhKfVO8lSEyW7LFVvegdr/iFiC7i7hnVhU4EuUW8=;
 b=jNWM0pdOEzWI81yG9riQtCP36FwZXHb3tYFZCmdPwTuMxVQDb8j1i2n7TLh6A9EBQiRazegIMtoR0oxW4/svz+A073E2nuqkUiPcDsqpuDngURdc6TctNjditShiQE847tuttfL6PHrjUNfMilHh6CM0t4M9eoMWhDaQU+S5ly6tkWgN+w/hrGjDNIVMnAqxxSlrSr3SJzYAerRPwxL9Yff11Lxl100Vw48LziTh0ev+opNnXg4zHutWqorEyMHwZfF61Xr/dn5wD/56+uEm1YxaARY2SPCdFdmO2fCWMMkPQiQkg2oKyF/HlcZFXfGTDRfDcVXXB2rQU3aR36GHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 3 Sep
 2024 07:05:15 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:05:15 +0000
Message-ID: <d1d8a28a-561a-4611-8a02-63780fcc1419@intel.com>
Date: Tue, 3 Sep 2024 15:04:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/25] cxl/region: Refactor common create region code
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
 <20240816-dcd-type2-upstream-v3-12-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-12-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3f172f-8a66-4775-63e7-08dccbe6c2ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHNONm1LM1l4c0V2bklWY0JHWWJGQ0t4SjREWFE4VVhZSlNqaFJkVml6NTQx?=
 =?utf-8?B?Tm5BNUNsb1BTM096b2dLZjhkaFhnL1pvYUtwTHUySWJ3NnFhWVVERi9KdHEv?=
 =?utf-8?B?ZERqOWdRSVNQZDFleFNoQUJTWlZZcXU4cFY0M084Q1pOZjlKbm9HZnlGS29H?=
 =?utf-8?B?SjJ2VGh0bHRWSG5tSkNaaW95cHhQSk93V08rbUk5NGNIcUREL0ljbFQ5c0Rt?=
 =?utf-8?B?OHZoVVI5R2VyNE9HR3NWSnZOaEZRRSthbUhLUHpjckswOU5uT1Azb1BtWWZy?=
 =?utf-8?B?b1hXRnU4ckpnNy9wbUs1b0xVT3ljRWlmaWZVRDNtYWxrb1FQdC85UzJwRGlz?=
 =?utf-8?B?aXFKQ0NxUE5YN1dkd3lyVUFDUmZ6S1JpVzE3eEgxZ0dQR1RXWFhSdXplM1pk?=
 =?utf-8?B?bUxTd1g0VFh1Nk55dEhsTnRhcWJ0Q2Yzc0FWSlNUY2xoZnJVT0FBUXN6MWJZ?=
 =?utf-8?B?dHBVYjZBT3cvRWdGLzRYZ3dzUkFhamxDL01IWDN6WlV0TU1hSmd4cmpwVFpt?=
 =?utf-8?B?T1NNaWI2dWV5WUQ5b1RYblVyMzlyb01PcXZrc090aUNIV1BWM1l0alo4SDZO?=
 =?utf-8?B?VEQ2YlBFMms2dTBXSFg2aWRsWnZ5bVFvVzloWTVFa1ZqM3NWMlpoVVBCSlZG?=
 =?utf-8?B?K2U2ZUYwRzNEOUxrcGpoeFVqRDdyT3R5QXJvSERndXdnNC9ZQUIrb3dEMi84?=
 =?utf-8?B?d3VsNkl2TmtYREI3OHJ3WTJjTTIwNzlzcWRGTm1rRThVOUQrSytBd1YzOElI?=
 =?utf-8?B?alVGVW1iaW9NUEQ1VlR0WFdWWFBFVnQ3R0g0MnpHOEJNaDI3OE9BS3ROd0oy?=
 =?utf-8?B?aXdxbjlydnRGS0Vkb1B1TWRIbGd4USthVXpyaHBoK09JTUxWcXJPaFVUSnB1?=
 =?utf-8?B?NmRYM0c0UFcyc0xIbnB1VGVpY1RtUjVUeG9qYjdOeWtkOXl3b1R0STMrWUF0?=
 =?utf-8?B?di91WnVaZ3NYV3BZS0Fqam1KdkVRalE1c0lQVll5MzJsckJXUlFsZ3BYSGxI?=
 =?utf-8?B?ZGJTWE45WmdhV3R0eXhTNTVCYldxSXd5YnVPNi9FQkdLR3NWL1BGV2VwdHBo?=
 =?utf-8?B?dXkySHowM1U1REk1YVZRdXhzT0pJa3F3ZTI0K2JtSEhSVExhMlRUSkxlTXFH?=
 =?utf-8?B?TmpqbnVpZzVDQm8weTN3aFZ0K1Y0QnJSam8yOWMzS2hLVTlod28xczdjeWlD?=
 =?utf-8?B?UU9VRDRDTDBkZFZadzFRSUx2dGsxcDdrSExTVXFIZGNKTHFOUy8yUjJ4ems0?=
 =?utf-8?B?cE1LWm42K01pYVhSMm1CcEZ2TUZHT2F1K3AvQzAvUm5CTXlFWHI4bTNyQ1Bu?=
 =?utf-8?B?bjJtYlBIQjZCLzFQMlR4RXBMSTgrbjhnWXU4bWV3ajhRck5FOXNZMG00anhJ?=
 =?utf-8?B?TGZibytBOG50VFg4UFp6bzFuRjc3QUM5VW9URnl0OWJrOUJzWEFqYWJONUxl?=
 =?utf-8?B?SDRSTHV5Yk5GYjBNbG42U2lha3JqODZKWitkNW5aWE5MczJmZEREYksvR2hy?=
 =?utf-8?B?MitOTXBuWENCOTdGcllCL1VHb3hhczJnU3NTS0Y4VmpYaGJYcHY5dkt0dUdY?=
 =?utf-8?B?Z1Nxc2g4WGV5SHhrTDdFYk5TandWNUhycjhDczduRjZQa3c1SDErVHRhdXh5?=
 =?utf-8?B?SFhGaTg1NUxMRXJvK3cvVkM1VXROdEVSY2ppZWRNYTdxTGloZThISVdaTk4w?=
 =?utf-8?B?em1NTEx0dWR5dTVWYk9TcElmZG5PcFQxVnZnNnpPUE5pS0kxUm5od0tHdWVL?=
 =?utf-8?B?enRjRC9hSzUxdDdCKzFSMFVTVzBKd0kwVUFmL1dHT1RvQzFGL3dCN0xWU3Vy?=
 =?utf-8?B?ZGJuUmJ6N1Z0K0hSdklyUlFpaVFhbkRSc0Y1VkswSmhhZnlQVFc4dldTUzMx?=
 =?utf-8?Q?boIP64TahOZSa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlHVkZuNlpIVGNDZzI0bkd6V29GMm1kWkZCdlRaVUcwOUZlL3V3d3IyREUy?=
 =?utf-8?B?WEI1Q3dGd2hYVnhHeGdhdzA0cFpJcG9NbkZpK3VKT25QZFFUakp6N08vUTZ3?=
 =?utf-8?B?aFQyQ3VadmJUTncrUGE1dTBxQjhLU0Vjek1GZXVXMEs0UFNtNlpzZXBtbWw2?=
 =?utf-8?B?YjUyUkVEK1FpNkhQME96ZDJRanprcVloMC83b2VZejFtVnBrd0xybGt4eWFo?=
 =?utf-8?B?TmdCVEpmU3NtZHJER1ZnWkk2OW5YK3BkVzVYK0ZrQ1NkODZxV1F5cmJySktl?=
 =?utf-8?B?eUcxWW9MeTl2elJLSWVyaXpvV1JqbXlMRmVqYTFaUEY4RjNTV0ptWHlFZmk4?=
 =?utf-8?B?UTFxOVBWdjRESkhEL2FNWkYxL1prb2x3MGxmQXBGOUg4bGhaRk91WlUvVmR2?=
 =?utf-8?B?dDdaYmlCem5SVEJJNzBYUmRrYlpQYlNPL1MrMldJWnlaYmp3NDl6T1VOS0NG?=
 =?utf-8?B?MVFlR3V0eHkvOXlGMlhlM3dWOCt2OFE1RksyMHYwdkRBREVZWlZPcGRRMGJY?=
 =?utf-8?B?MzgzRmpjRUZMb0NMZEZoK2xDcHNvTDlQRVN1UVM5M1YyOVd0dzFvaEhLbG9k?=
 =?utf-8?B?MFNMZ3dyWkNYdlZrYThiSjAyc3JrZko2b0hubGpaTmRsd3RGTTYycUNvYnhy?=
 =?utf-8?B?bytWS1BSSmV4KzVvNVl5SnM5SWR3UWRoUmpiSHZYNDczRXZPWFpyWTVLZTRX?=
 =?utf-8?B?TlFCRGRNSC95aFdTZFhXUkE4b3FabUk0eE8rWUExVXRNSldobXNUdHU1aXVM?=
 =?utf-8?B?TzFRNTdsUkhBTVZXR2JwOFNFR0JTaTVUMTY1SmdEYkRMc1VvbzVYNEQ5bGRz?=
 =?utf-8?B?eGZPRjhEQTYzSGZoSlhEVkoyKzJTYVZSM1dEYVo0ZGEyMXBiS1pJd3RjNWJa?=
 =?utf-8?B?TDlUREpKTEsybGUySzhjZFhUb20vUWdRR2xYR2gzYXhVUGVMUGpNTUd6N2xh?=
 =?utf-8?B?cFZydU8weFV0Z2NoNkczOGpnK3VIMjhRbXNjV1pMRWZ2TW44WUpmTHR3UTBM?=
 =?utf-8?B?Qjk1a3dWZXRtN3BHSFBtRWhmK0Z0NEdrL3M3cVdzVVFqUEJubVY5UDNmTGdH?=
 =?utf-8?B?NktWbnZFUXBFaVN2MVVhenBYOWpmYStHbnpNaHdXTXlpVmRibStiZ1FQY0p6?=
 =?utf-8?B?c2Q5OXp1a05WdEtFYnhpWjlLZ2xGdWdxZ2d0ZlFWemZCRlRqbUJKSTVBcWUw?=
 =?utf-8?B?Y1hOOU9IUXVPTUZzOXE0YkRYcFNmUHFsMGVnN0t3UW56WDZDTHNSZ25pamFK?=
 =?utf-8?B?M3BqRUdVdEsxajZOVkhBcGNQT3NPZVBTK1E1MlhKKy9KREo3ZEl0TmJqMklh?=
 =?utf-8?B?YndLWi95S0JQWFNJcE51d2pLNjFmSzR4MmMzdGxYU3NXaWRBUjg3OHBQL0o5?=
 =?utf-8?B?SDBuUkMzT0xsK1VsN0VyVWhITGo5ekJYSmJPaUovL3JGY3U5MEdNSUd1dzRj?=
 =?utf-8?B?MFJoeTVwSEZiRGVpR2Q1UjBMVUhhYkQrMlI0VlZqVmpSYytjelNSQmpKMi9Z?=
 =?utf-8?B?aVB6L3lMZDk1RTlNaytHMmJaQVRBaHc5MEZkTEh5WGNpd3RxYkNpenFPQ3hU?=
 =?utf-8?B?ckZQQk9PVXo5SEVjN2MweDFvZTF2UDAxanBOc3BpWWRETXAvRlZCNEZEOWVW?=
 =?utf-8?B?UFFMUzg3WDA0SncybFMzekNlUForUGRPZEtTakVCbEp0aUlRRHRVZTVQaFF6?=
 =?utf-8?B?WTZlRncrMUdIVFEwODVMNUVFSURKNk40NDRIR3JVYTJHdXMrWVdyVWduOE9r?=
 =?utf-8?B?MFdHazMxVCtTVVhmZGNYUGtQWEM0Y0V1dHRmTXdLUmxqRVZKRGFYQk1JdThk?=
 =?utf-8?B?eCtnUTQzTnpsRElYKzRqemMvS0s2VTlHQ2VjZ3BGdHNFdTJsdW5zWmRCZkVP?=
 =?utf-8?B?TDc2YXV4d0drRERHNVZpTFcyajlsY1hGaTI2KzljanowcWNIVWNSb0ZSSkdG?=
 =?utf-8?B?UmVZSnZXbmxlM3BheERDTUlzVXNSaTYxbWRPQ2hGbWMrbzZWa1BLcy85dlFv?=
 =?utf-8?B?MU91VFdMeGIxRWw5dlJVZUo3MHhab1ZKMWRBajNXUHlRWEszMnpRWk9MVVNY?=
 =?utf-8?B?UkFabHp1WjFCSGF6YldOdWpTQUZGRndTR0ltZXNoMVVSNVhocm9lYVo2VDJO?=
 =?utf-8?Q?bl5LYmp+hr58FBn0XUJ0tmdiv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3f172f-8a66-4775-63e7-08dccbe6c2ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:05:15.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu8RNDSziiIyvTQCZOcy58YkZY+qjsMFSujh+zksbGweC64FuQflFyM6jw1AvLm4XP2xckKBo8XdU+CQNCUfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com

On 8/16/2024 10:44 PM, Ira Weiny wrote:
> create_pmem_region_store() and create_ram_region_store() are identical
> with the exception of the region mode.  With the addition of DC region
> mode this would end up being 3 copies of the same code.
>
> Refactor create_pmem_region_store() and create_ram_region_store() to use
> a single common function to be used in subsequent DC code.
>
> Suggested-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>

