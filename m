Return-Path: <linux-btrfs+bounces-8672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B88995D82
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 03:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E96C28943F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 01:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69A558BC;
	Wed,  9 Oct 2024 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4SXWsgH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1444C76;
	Wed,  9 Oct 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438996; cv=fail; b=iLXKCaokxN97G8FwHBtlDORukmGgkdtAy5JBaKzXzGPkzb/QBBBfuwJU78eK6H/Xmz8qr5WCWUun5fZE/ULlDX5fbZg1vj/zK6D/2JxD2ChZT+fDG0y3JNg/6rAh6OpNJQcJwlVYMnXIsyq5VSN7HvHx6fqg3UiWXwneQFaCMRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438996; c=relaxed/simple;
	bh=9fohnkhIe5UyF+rPAGs2KJ+QqL2AgFjLHLx0NoyynBg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kN7XaxUOMQB2PcsP4y1Z8VYoG6Hv+6uotUHAksynRCKvagnysQdZyV8aXazF0lN5dTBbee3cPktbqjGC81i9BPvzLNWJKHTgviXAJffG5rKKdozsh3zXtJGy0663FFlmfK3xekZYM7QPSRt7LpQlUG1xasX6KdtHqvZdu5Iz+8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4SXWsgH; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728438994; x=1759974994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9fohnkhIe5UyF+rPAGs2KJ+QqL2AgFjLHLx0NoyynBg=;
  b=d4SXWsgHXFLYrO7B5DJeDXdcw2fsRQLXQUlzDet9R4kdBRKeo36yruQA
   VhC6nrmeWciUvL0MmSqGTAPbbZiQprU6XIAEiJOVZ+VBUYm+odH2uRR4s
   ED1Y+dU3H7ZS+sFGIJHbGFXKvo/zTK593ITNDMsDSoCHk09ilQPs/J1b2
   hkibNZoUaYm/UCQqBnq0+s3C+YzbqnTriPMur9iSbgAQnnD6j8aNcSHTU
   EcWc0uBCbGgfACmApcoDYU3nxzHyEt1JLz7JJXVUPtvIE2oTAcUX8B1od
   ioh3dutNZtGOUWAVrm0OrY5qpr1Z6Bv+tzMF4/+LhPOZxBNos1I4L1oDO
   A==;
X-CSE-ConnectionGUID: xVKWJ62KSMmx/aOcJ+nljA==
X-CSE-MsgGUID: aQD+yGZqQM6iwQGV9NwhRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31411168"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="31411168"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:56:27 -0700
X-CSE-ConnectionGUID: Nc474462SMK49IaBMRqZ+A==
X-CSE-MsgGUID: olRm7WHISxWjaRQ6IJFE4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106916801"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 18:56:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 18:56:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 18:56:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 18:56:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 18:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXC4JI2P26rIG6fZcLiRmF78jhGSpdenNaauSIy1pYD7943sLoUb31Mc4RMQgzsx1/h36I84BKhOpa9oT0NwV6ZEZjk355xPeRJ5J+MnEbCidJMyGtxLFXynEcYbO3Yi/IeIKDsuxhEQlTj1K+P2ADcn6nBLei/S4k+NiT9OnLSvxubdddbmz3Up+e0IOaFiH+qjwSq1mcbTfG6tQ8Dl1mYPEUqIDpSmR41wx0ozFCygPZzwrREae6oTwguqTj3NkEFigDJbvKq6GxD1Tkn038gI/kuND58pqQgi2/pl8ylekb0sSNdGGKt28mF3N+KAVlKIfmok9vVIZZnykXieDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD0gBv9/N+a+6/hUmmSrM3RpY33VxHzN3iUhd70/Il8=;
 b=lWrOkXQtQxPPdv2QThXh4dM+I2u+duTd1DQ3fZvL1O5jepSBTz3/JpGFtiAzkhvlGWsra4BY/F5ePWDw+kX4/pOUN2OxE28d1JMXSmUZIpYjMAVRhUy8CNh1WqZI5+Ot7PSyEW/96ju2sGYHX5dNupYHUlG6F1YNoMxiDWUxbB9d/yKsDPOzecBCbA2A2eoozNu1Rv6YfiPg50qjxy4HK6bE63R/t7ns8MWyEYkykIWI1t1fejgbGtl4f/TP+nXG6RbUdH6AucNsrciToC1fu98iWdQ+0IVGu9j3ImDmBFaRL2UxIqDlhmgNPdc8seVPh/vXa7LXUYEeCrnH1lABxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 01:56:17 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 01:56:17 +0000
Message-ID: <4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
Date: Wed, 9 Oct 2024 09:56:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|PH0PR11MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: fce003ee-148b-4fb6-49db-08dce8058ff2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXhRZWpDaHJqYkhMZVFScDdpRG10ZWdFbVIxak9xS1owVm9wM1I3bzUvdG91?=
 =?utf-8?B?clpYa0xZWDMzVTZIOStZK1VyRUJ5YjRoN05oQlY4M3NZVVgwOUtOaENzNzVm?=
 =?utf-8?B?em1kandYaTRaZ3BxQ0hGc1FZcWp4NTJ2OUNzRG5PTWZQZmhnV1hzYnU5bVEx?=
 =?utf-8?B?aW5QaHdaRTA0YjQyMTYvUmVhWlVlUkZBdjg1NHR1eDV2cUpFUnBHbS90aGVI?=
 =?utf-8?B?Qnl0bzlzSjF1OWxZZEwzamhCVFdHeE1hSlI4cm5HblJTT0o5RUI2NHVSUzFM?=
 =?utf-8?B?Q0VzekRmQzdsazJONVUzYXo4QkUwRmZvd1BEdDk4ekloY2h5VDVjczh6aXZV?=
 =?utf-8?B?VmU4S3FOVUdjdDFnczNSNFpwYVc3UEloYU5va3RXbVhVeCsyUGVVU29PZHBN?=
 =?utf-8?B?aUV1SWpvNnZKYkFIUXNoaitzWFkySU9xa1JtNkdCTE9iTWg2bW1yUVJCb281?=
 =?utf-8?B?emxhWmkyUkJtZDhzYjA4dWdBK1k0U0M4UEpnU2R5M2RaSExQRHJ3TjM2TFlP?=
 =?utf-8?B?OXNHOGNIMEJ2NWFKVW8yeVpKMW01MUFXWFY4dXJXWG81UlVDMGN4K1RWbkEx?=
 =?utf-8?B?U3ZPL3NPUm5oc0hUQ2lJUEk2eVZDcGVnT3FZYXZURXY1MVRCV0Z5Vk1zOS9k?=
 =?utf-8?B?NmRMZTFXaGxIKzhTc0k5U0NRaE94WktzQkpGYUY4dTZoNUtVM1dSTHVBcmFl?=
 =?utf-8?B?anVYN0o2dkRRazVNN1hwU3c2THh4UVFHLytMU2E4Tis1bkVuWndISlE5bmFM?=
 =?utf-8?B?Vy85Q0VneG1YQmt1RUcwa29BQWl1S0hvZkhYSWRDZHhzR2FwU2kxUUVtOVVQ?=
 =?utf-8?B?U2ZabjJacmtXNHAyNUhvRzZHN1VveWFkdDBZWGRyV0gyT29CNndQb2M0NXlP?=
 =?utf-8?B?andFWk54dGZKTEFUR2pwWUFBMVVyY2xvK1UrOHhJTnVSTWx5aDVadTNTUU5J?=
 =?utf-8?B?Ymt5NGZoOU11QUVnMDI2ZUZLZCtkb3RHRlA1aWFBc1RRTWN0MjU3dmNoam81?=
 =?utf-8?B?Wi9Dd1hTZWt0VitNWmI0dXpDVE9MaEU1dlFwbDlvMzMybVY4enpRbWRiZXFR?=
 =?utf-8?B?VzRKb2pTNXlheWNyRklqZWxFOVBuS3dyYmhrNlYvS0Njb21QVm45Z0RIVHRD?=
 =?utf-8?B?c3NKdkdDblEzUG1IVkJZbnBzNm9PeCs2MzZQQTJUTW9SOHR1bHkyM1JOOUZ3?=
 =?utf-8?B?WHNWak9DK3pPdlFUZEYzS1FJeDhRTGRPVlFncE0zZFJCSnpyekNHNkFUa2lW?=
 =?utf-8?B?cFlOd3VVTHJVbmtXQ05LTENxY3o0WlNsRURWcWFjVTBIc094MHhkRXFaR1ZL?=
 =?utf-8?B?YXlTR21UY0FzNDVzUnJzYzhSZEZ2SDFNbkNNeHlmekdsb0hTNkZaWExkUU1a?=
 =?utf-8?B?UHBCeDVsTFRGRkNLekx0cTBsOGR6Zk9qbFpoSDhPUDdjczVlR3FnMHZUV2w3?=
 =?utf-8?B?TUtIZ2ZxOXV1bVowWFNudjZGZmFHVGoyejl2RW5sems5MVdqT0F3WmxYbU8z?=
 =?utf-8?B?Zlpjc3lEc20vMlR0eGFhc1h3ZFdWbkRMTTBBTnNZUFltTWNjUGljU3RraWpG?=
 =?utf-8?B?V3lLV1lLdFdHRFlWaTA3VDJqRHhEZkhWWGdNbHZHZnVSbmw4S2pFMHFyYVhu?=
 =?utf-8?B?cjZMNWlFem0zQmNuenI4Qzd0TFBnZU9pc0FtTzdwSTQ5NVNPamF1SHk0OFRo?=
 =?utf-8?B?cERlL21YbXNiTjlmZEREYWtUa2dJZFlqczZtK05YS2JqWG5SRlNqVzJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRrTmdzU2U5My9RR05CQ2c4QjNIaWZueE5kbFV4bjZNeUdiaXcvYy8xYXVK?=
 =?utf-8?B?WS9HK2RCdCtqTnBReGZtTXVyT1ArK3VUeVFjOFJBRzRLYThnMmxkK093Rlo4?=
 =?utf-8?B?V0xtS2daZmFhczhyR3Y5S0EyQVpwN1JNM0FCcTJNV0QxM0oyL2ZBSUJmQmho?=
 =?utf-8?B?Y3Y5SFZ5NG9HVm9BanR3bmpjTGErZ1RDODBOb3hRZkwzS3I5NWJRT2dOSnR4?=
 =?utf-8?B?WjVXanVuTjhiS3JvcHpkWURpTjFodDduVjI5cXE0Z3FxRHJmMk9jYVV0N2ls?=
 =?utf-8?B?MndhS0VHWnd6Vk1xNWhsM0xCVUllQ3BxdUYweHJGeEdwaXZPSlZvZ2FRT1A3?=
 =?utf-8?B?Q3FqT3ZGeEYwQ21HL0dZcGNHUUhyVHpLMHFhMGl0SGFOczZRQkNCZStaLzN6?=
 =?utf-8?B?VjBJTEFBbXFOQUxvNUFQMmU5NU8wWExKeHc1dFVwWGJxcWM2K2FqbTFtaXZw?=
 =?utf-8?B?bWUrMVlyeUkzcnhxK21lZHI4K0JlWjRTcTliYnFiY2YzN0xjQ3Vrd0hqVVgw?=
 =?utf-8?B?MDh5OWhZU3RvQnlsQjNsditveU0vTmtNZEY2UTltK2hUQ2VsaDNIRUwvUThC?=
 =?utf-8?B?b0RCd3ExM0FxSFlGbWg2ZGdFWXI5TTE4ZVVLNkhWbHluNVRhbmYrWG0ybDZQ?=
 =?utf-8?B?NHVWR2xJenJnNzhXRUY5V1FaR2NjSVRkUEdEb0ZmL0FkWGg3RFNtSEtjUlE1?=
 =?utf-8?B?V2s3aG9kdW5HdFNaSHZsT1g5bmo0M1E4aGNEYjZ1L3ROZjhGeDN4WU9YamVI?=
 =?utf-8?B?OW1USTZ5Sit0ZW9DaFJ3UnNTK09nWjhqeSs1VEZLQkJrdldYNHlUcXRaK3Bj?=
 =?utf-8?B?K0ZveXJuMDgvb25kNUdqUEdraWs2WXc3ZzBBM1dpeHlJT3BpLytudEs0Snh0?=
 =?utf-8?B?ME5sZGt2M1BQWFRVWFU2S0FlWEdQOElJMGRpTEZHMHN5aU1weExpMkI1dTFK?=
 =?utf-8?B?MkNjRll5SlZodkJZL1NweGVSMnF6Y3VsWXhGVEVtOHUxOFhyWW96ZVFRNlds?=
 =?utf-8?B?eXhIZTZnNUNybkZrSDhtYU5sdDFkZVkvVEZkc3pndGtsWmhIcUlzZlpydkYr?=
 =?utf-8?B?TEM0LzMwQ2ZQWXFncXQ3S1BqTmw1Y3Jlc3BYRkU5TjlSR2lQZFVESmx3aVVp?=
 =?utf-8?B?Zm85U2FYUjdIekMvdTlwZkl0TTBCcWs0a1ZiaUNVVWVtTVZRUFVrSjRxN1c4?=
 =?utf-8?B?dlVBK2VCenE2a254MVZmc2pjVHdTd20vajFMdnh4ZlpLNktWMXl1YW11MkVE?=
 =?utf-8?B?eUVMSWdYQUhQemxVQ3Z3RnhiQ0VDWStiRXV1ZHdnUm9wMDcxUmtPbyszUGdi?=
 =?utf-8?B?VjlFd3hGSDc0TFZzcDNDZXF4UTZjRDJ5ak8wR1hRdjc1aU9DRkRMeFBFNHhI?=
 =?utf-8?B?M09teXNWQlZCcDlJNUxoOSs0b2tLREcvdGFxRk5YeGt0MU1yN1FaVnpERTlt?=
 =?utf-8?B?aGxHQUV4NnFqbUwrWDdVNk53Y2d3c0NNSjdOb2M5WDdSWHJNdERNWWZEcThK?=
 =?utf-8?B?VE4wZWJxSlFsS2l0cG11Zzh0WTZRb1Axd1B3Qmd1RG1OQUpONHVFamtsUXVR?=
 =?utf-8?B?dnBXS0REUkpDeEVkVWxtcWllazRrT0lZNVdrYW1xRkdXUzlHaTlHMThrZ2dm?=
 =?utf-8?B?WkNBL2FnODVFSUxrNGxoUnBrMXorUE9laTRzQUdyempVSmlqcFNLbmM4T3RK?=
 =?utf-8?B?RGFWVmtLTmFhUS8xWDRrR0Z2Qm1nZXlvVnNMRElXM0VhR2JXSkxWUklTRmcw?=
 =?utf-8?B?WTdDM2pRYUNaUkx5Mk1YbHE3aUx3YUdFUk0zTFNlZzZQZG1JRmdmeFFBbEdp?=
 =?utf-8?B?VFBYNEJhVGkzbHQxUWVJQlpMZUQxaHlsR1Ixbm8rMmpzVHhsY2ZqcnByYldz?=
 =?utf-8?B?VXdIUGcwbUg3UVJxREdkWDNUWUF5RkhrVDdpRVNocnJ5a095NS9oZlVxbVRT?=
 =?utf-8?B?TWMzY0ZpTTZGTmxBYXJJM3VXQmh2bFVwU1dZdCs3U3ZkLzRuVUdBb3VWREd1?=
 =?utf-8?B?NTQ2TS9ZOXBDZlRZK3JwRnhyZ2VDSVFMTVVTSUJ1aFpzR2JQWk5OMXZISlZT?=
 =?utf-8?B?WEt1NFEzd1Y1MlpDSDV4Q0NDZlJRZU5tUDhQNFJUMklsUmhOTkI2Tzk2ek5X?=
 =?utf-8?Q?wbYrjAvQoY6UhbHkuc7im64OD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fce003ee-148b-4fb6-49db-08dce8058ff2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 01:56:17.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4m9lPJk1JUg7q1C1NcvvTjZwuyWUWVS4OaIM2w2/KZDqVuFtKX6V06xbaaZmudsq0zwPYh4xJ7UFxShQOQ1Oag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com

On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:
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
> 	   host.  Eating duplicates serves three purposes.  First, this
> 	   simplifies the code if the device should get out of sync with
> 	   the host.  And it should be safe to acknowledge the extent
> 	   again.  Second, this simplifies the code to process existing
> 	   extents if the extent list should change while the extent
> 	   list is being read.  Third, duplicates for a given region
> 	   which are seen during a race between the hardware surfacing
> 	   an extent and the cxl dax driver scanning for existing
> 	   extents will be ignored.
>
> 	   NOTE: Processing existing extents is done in a later patch.
>
> Management of the region extent devices must be synchronized with
> potential uses of the memory within the DAX layer.  Create region extent
> devices as children of the cxl_dax_region device such that the DAX
> region driver can co-drive them and synchronize with the DAX layer.
> Synchronization and management is handled in a subsequent patch.
>
> Tag support within the DAX layer is not yet supported.  To maintain
> compatibility legacy DAX/region processing only tags with a value of 0
> are allowed.  This defines existing DAX devices as having a 0 tag which
> makes the most logical sense as a default.
>
> Process DCD events and create region devices.
>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
Hi Ira,

I guess you missed my comments for V3, I comment it again for this patch.

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
> +	if (!extent_device)
> +		return false;
> +
> +	put_device(extent_device);
could use __free(put_device) to drop this 'put_device(extent_device)'
> +	return true;
> +}
[...]
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
> +	if (!extent_device)
> +		return false;
> +
> +	put_device(extent_device);
Same as above.
> +	return true;
> +}
> +
[...]
> +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> +				struct xarray *extent_array, int cnt)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_dc_response *p;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_extent *extent;
> +	unsigned long index;
> +	u32 pl_index;
> +	int rc;
> +
> +	size_t pl_size = struct_size(p, extent_list, cnt);
> +	u32 max_extents = cnt;
> +
> +	/* May have to use more bit on response. */
> +	if (pl_size > cxl_mbox->payload_size) {
> +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
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

It should be 'response->flags |= CXL_DCD_EVENT_MORE' here.

Another issue is if 'cnt' is N times bigger than 'max_extents'(e,g. cnt=20, max_extents=10). all responses will be sent in this xa_for_each(), and CXL_DCD_EVENT_MORE will be set in the last response but it should not be set in these cases.


> +
> +			rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +			if (rc)
> +				return rc;
> +			pl_index = 0;
> +		}
> +	}
> +
> +	if (cnt == 0 || pl_index) {
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = opcode,
> +			.size_in = struct_size(response, extent_list,
> +					       pl_index),
> +			.payload_in = response,
> +		};
> +
> +		response->flags = 0;
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +


