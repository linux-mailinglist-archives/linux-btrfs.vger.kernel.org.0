Return-Path: <linux-btrfs+bounces-8865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465599ADA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 22:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB0DB23655
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8941D1507;
	Fri, 11 Oct 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgEFy2gk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FB19B3CB;
	Fri, 11 Oct 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679106; cv=fail; b=BVjNLOIQYwimCPY1uHWHaDL88C/BW0CMk+7rlB5hYp+Mhr2vKyOY4ZFfZCaijGIiMVvn6Pq0/ES3/adaT6dXGvCT0S17fM8c4Tl+OIuqWtJqU7Io7hCMYIwJpNOPhpzL48uiq1OdijWINMm9FIyV9pfQW3aO3kMCRV7qTlrpoJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679106; c=relaxed/simple;
	bh=TN06abKnyHnPe8ujbPS7t+Vypi97uRydXUevwEruehs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EL7ITspzyo8obo6jmkUTCtLpqMz6MUrbMJQPsKFHKyAg7Awcg1C2sBcP8SMcY1lmP9jUW5xGE2kK+gPFdD/CV3vntzBDy42D8ttsMumGetFOf8EdzRE//mtl4b/iRW+UayMkmOtMyUxbMghol2NDhX1oP/kjMANiVU79DKBbcTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgEFy2gk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728679105; x=1760215105;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TN06abKnyHnPe8ujbPS7t+Vypi97uRydXUevwEruehs=;
  b=VgEFy2gkGkQU259VLMZ/UdgCpSPLXLk6hv7OrAxD7Fvf+Gk288BmML9/
   +hoVGTCyIG3LEnAQtFonB4nWtI4KEOYwncaDCnmqV2VcuW1foes7oAi++
   YLqwqsL0tV2mndig2x12P8CupDTF3+LBiMJnaVkzYJN+Z3yHwkfsEvxyW
   e/iOyh7Odtuu/qLJZ9mT132cxmg+g5Hgj9HylZBlVrCZ/YmQjgMC2xGCW
   kudUYc7oKQG5JQqDysBs1aByPORjEHHTNLKz4Qi9nt/PS5ukEIzoYWeWy
   QMvx+8cW+9chNZ6NoRrXTYhgVgnI61mGLgmC1Y0JobJN7XlNYK00TNo0x
   w==;
X-CSE-ConnectionGUID: 9kGpW//mRWG/YbzotM5kXg==
X-CSE-MsgGUID: 7fwjcYm+Sy+KrdiLeJ1TBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39463739"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="39463739"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 13:38:24 -0700
X-CSE-ConnectionGUID: wEPQbErySMWiQvO4ub+kew==
X-CSE-MsgGUID: qRKNiSmcSwWU4rPvf8xe+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81014707"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 13:38:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 13:38:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 13:38:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 13:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjQYsi6P4JqiuGAcGF9fG8smaleeNcEMAxXINYAudrA0/Q/SMWgBJw58K2FlnI8aQoOwiCZuWBKY5ZCSKrto/G4J7M+rc7LydmAhEISnl/Coese7BkzF/7WiQKGGsSSuebaRpPrSSFbZZSLB33onjiYKH2rO736SSxp4v++9LV0hkb4FEUkGxh9U+t4gwgKjn6ffv4eoTkdd+Wruk+WIHPAERFCw8CTzXuRquhuQ/xhM92335b9C9EI6hWHSgB5h+Py49nr4JGHkW8wHqctjhtk1h/FszjNupJdhyeeSGi1OnUD/tUwozidu3F3lEtrylLMhfI0SVhS6F+9CCDhXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7noy4HOjjPxndstDBlybTQwEwCu4S+2zewtIIOvG+z0=;
 b=gQe8PxC8zWEixkLiz4EjEuSG3pwXpn47dcsESY94bMT1QnmlqptGo8XDdjSNXgo7nJONkY9F/lRHTpAnCASigjsNJbvvSTSvKgEswB8RuVi84Jkgfh0c93g1K4IVDtqJyBI+lASadMhyokfHgCkRolycOvtHrdX8xDVXv50P9MFXekAPY3Qg64+UqNSPxLn5hVUyNL+rCP2qlJlvDUTr8ZYkcIKvQ4/RUzcBfQ9frf8xbRA0Q6mLFYbbXVtkPOrAGaf4blRTmBlhbSPU2cQSR1uxkX6iWFtpT/GSuzW1UfhD0MsUgmCjzmMENJXgImfwSUxlDABfK2uraAOOPXoFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB8190.namprd11.prod.outlook.com (2603:10b6:610:188::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 20:38:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 20:38:18 +0000
Date: Fri, 11 Oct 2024 15:38:12 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 12/28] cxl/cdat: Gather DSMAS data for DCD regions
Message-ID: <67098cb436d87_a55db294f8@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
 <CAJZ5v0iFco4htzfW1sYYKKh67oe4GsnUBOPRiunHQ1n2FHa3hA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iFco4htzfW1sYYKKh67oe4GsnUBOPRiunHQ1n2FHa3hA@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ab2738-a44d-448c-6514-08dcea34a339
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEQ2Y2FvRzA2NkRzd0RicGRSWGk3dVYyTFNWM2lJbU1yREtkVVBQLzArNXZi?=
 =?utf-8?B?RERWRmh3bDRNa1hGdGphNzk0djNNRlRnUStvRGU4ZHRzQjh4bTdPMllZOGlk?=
 =?utf-8?B?WWs0MjRLenJ4cCttcUpTTDZ5T2pDekQ2emd5VkhlaCtSMTFZNWdqaFhTVlFa?=
 =?utf-8?B?Z3IrVG5TdStYTjR5aVN5djRoaVpEV0d0S1daazZHNHVyNEU3R2diWTBxWEdG?=
 =?utf-8?B?NDhTL09EOEEzNTI5R0U1VDhFTkdXQ1NiZEFWUnl5cVhxcVBFM2diTzQ2bTNq?=
 =?utf-8?B?QnJBd3VKaUdjTEs1enI5VVkwN2VvUzI4alhkeSsxVk1mbTM0Vk9kbmx3WkVT?=
 =?utf-8?B?ZDNyYXNqL3FrOTd6K3d2ODg4OVBTMkNUZGNNR3FobWU4K3lEaGdRMDNucGxq?=
 =?utf-8?B?NDM3MEhqdk5HbmZLVEZtQ1A3aXNVakhhVjNIeit0UXJmKzZBZ3FUWkc2NUFp?=
 =?utf-8?B?SytLUlZrdXZNN1Y4eXhCK0l5QnhjcGdsZmRjckVVanU4clZoTm9UbVBYdjNT?=
 =?utf-8?B?RzRHZVZRS0dRR3lpNm1FN3hQZUd4N0traUhNUHU2NHRkMWRyUXlFdm5DMTUv?=
 =?utf-8?B?bVhpN0dzNnJtckdxcDhIU3NjSVRjbHd0U0ZEblJMeDNBRmFxVTg1N1BmQzVC?=
 =?utf-8?B?aldkb2o2VjdNYk5wOUVDbGFld2Frd3hReTB1emIvL01TSTZyNE01ZDYxK2px?=
 =?utf-8?B?aWh2TGp5QmV3WnhqRnE4NkwwWTBGNWNoMFZBWTRkYkgrZ2V0dHkvbXdLQ2E1?=
 =?utf-8?B?MUF2cklHQTZvbm5ob25GV0tFczRFWWNjMGJ3VUVrMFpBblYzWC9memkwQzhK?=
 =?utf-8?B?a2xPN05rRUl3MENzUGhYZ2ErWkFQMmE2YmJtUEswRHp2eUNpcHVhYzR6N2hs?=
 =?utf-8?B?SEpmWmJUKzZZMGZpakxXK0lnZ1FlbW5leG5HUGV6REhOUW1Xc2tXNHl1eGJz?=
 =?utf-8?B?RXpyS3dQcDRYSkd2T3p5WkFRNHVibHZaYzBiQ09tREtBeWJMRXRUUXFGcFBI?=
 =?utf-8?B?bnRmNlZvaERGNU1hLzFiQUZvTkhkbGwrTEJoWWpWdm43bFZ5bHhLbTJHdmNx?=
 =?utf-8?B?Zzk4cldLcmQwQzd2VkoxWjZjTjRSVFRwNWk2MDM3YXpCVHBCZHNPMFJDQ1RO?=
 =?utf-8?B?OU9PZkpCdkl2YjUwM3FldEF5N1hCWnJNR0JrOUNtTU9YRWgyQlV2N0lkUm9B?=
 =?utf-8?B?MlF2b1ZCVDd1MFQrSVJUeXd3ZTJ5S01sdG1XUXl3NUpWcGsxR2lwZExOakxr?=
 =?utf-8?B?aDArK04zK0RSTGdaNWJiTys4NW9Dbzc3VTBWaUEvK21jd2VKTnpHVTJiMVRZ?=
 =?utf-8?B?YllOaHJrTGxyTEYyd1creEdiRHArYTBnYUlXRVhMVklmSmx0K0pjUTVJcmZJ?=
 =?utf-8?B?VllEaDdLQm9mb0Jxc21TL3hSU3QySHlVWU9sU293UkdoSGxWUWFVL2tZQUp0?=
 =?utf-8?B?dXAvcWhid1dHVkR0ckVNNjV4VDQ4MERJbDVtNjBvSCtjcEdxdDZWK08xa2p2?=
 =?utf-8?B?Vlp2alJZamtYcERZdFJUdXVNZEhwNDVaVWhZTllHeEx6L3ljRUZxSUxmUCtr?=
 =?utf-8?B?OHdRNDU0YkRtN1NtMXhyU0FJQWs1NG9LZTlvTjVJbWhOWXRBSm45REY0bE5z?=
 =?utf-8?B?NjVXUCtZZzBxcnlSYk5RWll6WGNLazl2OWNoK29weVNKaDhJUG5iS1c0eHRs?=
 =?utf-8?B?OHowQnZVQ2dqSXB0cjFKdElGd3dWSmlDY1lJNzBlajlha2czeE1kOEhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjI1anRuTVN0dGlkVmM3S2xYQ2N2ZEhpVGxqUnlwL1RKQW9KaE51akJFaFp0?=
 =?utf-8?B?NXR5N3hyUUVZU2ZNeGFWR0cwOVJpTC9UcFgydllZS05MMU1qbHlpeUVzM1Nh?=
 =?utf-8?B?N2pzY2VvdGk1ZnNmVDJzWlRwZnBMb09qOW9SOHM1clRhVzRGYkNUaGRsTHFh?=
 =?utf-8?B?MHNOUlJYdlRVSGNrc0pzTS83SzhkTDF6aHFSTmc3OGNvQ2Q2dDMzd01SS0Uw?=
 =?utf-8?B?ay9rRlFsL0NJemtEanRSN29yT0lWVzdzdjNjSjF2TVE0emttUFQ2aEYxMnQ4?=
 =?utf-8?B?bGFkNGpTVytqQVBLY2hYWkQwbWExUVcrZVhlOHN3T09aOFEzeXRxdHhkd01m?=
 =?utf-8?B?NVNad091RG9ic2tqMUtUNStobThxTjJhQ2dVMmlZanl4VERFM3k4YUJUOXJJ?=
 =?utf-8?B?dVRMWnVDL2F2QmUvVVZlbjNtaWdNUzV5WGtkM1BycjZwZmpwcWZMZ05vNE5W?=
 =?utf-8?B?Y3hGR2x4c2tYOElIay9kL3pYZllYRm02VEM2V0lKd1kyRVNIb2ltYS9sNGNa?=
 =?utf-8?B?eEVjbzV5azZYSEZLMUVKdlFsTHZDWDY4enRhanFPZTU2b2w0enVJKzNPSXIx?=
 =?utf-8?B?SXZESkxFMGcwV0dkSTQ0Z2VYcFhNOVlvQjlyYVRSZjU0d0dqMjBOQk1FQVAv?=
 =?utf-8?B?N0lVTks2UjQ1SnM3ZDlvRk9rcDZNbVdMcnJXQXpyREdmcHRxSStuV2Rka3Bo?=
 =?utf-8?B?UE9acmM0ZEFMdDA2OXYvdWFtUVZIZmFaS0crYTdYa1J1UFI0US9rQ041MUxp?=
 =?utf-8?B?cU05dndaa2N1UXJweXNNaXBFUjlCRk9YdWdrelVtVzhTUHdTYmJYemV2TlNl?=
 =?utf-8?B?UkdFeXJUdUdGUUV4U1VVamltbE1MNXZUTGlhTjB6SkljWE40Q0xjNFlhdERt?=
 =?utf-8?B?L0o3R2tRMERkR1E2MW5SVUJBakc4ZWpUUkgzOEMzN3VxdG1BWWZqdXQyZUJ6?=
 =?utf-8?B?eHZTZzhIUnJxR0k1eE8xS2dJZkNGZ1h0SFExa25nWjZ6RDI0eko0MjExOXBD?=
 =?utf-8?B?OEZIKzB1dDF5VXZRWDc2VVN6Vk5SZzZrdnRrZDRVK3lUcXpLSkFGcjA1NHZ0?=
 =?utf-8?B?YUZwcFQxdTQ0ZkV5Q2gyRXIybEJyaUxvY3ZZRklvdkloOFB2emRzSktpQUlZ?=
 =?utf-8?B?b1RjbFZHTGlEZXJwMFpldHpJNUZUdHcrWUVNWnl6NkdpakVLb3B4VnNEOXEv?=
 =?utf-8?B?THlDUlJVUWZPNGs4SjA2bG9rNENyMnF1MHRlYzNEaUVidnpIRWFJWlV2TS9R?=
 =?utf-8?B?eEk1azd2UmluTFdWSHZOR05VdWIxM3VzVlZRRlRjWnJnSmVpVlZrVGdtU1gx?=
 =?utf-8?B?RDFySkxyMDh6OVlmTDh0cXV2SktIK3JjZW5kVTg0VnQ4RjYwYkZWQTdmb2Vk?=
 =?utf-8?B?TVJtcml1cktWNm94OUU3WVhnNUx2WWlVQ1RsWGJza1VFaTdaei9tcGhPZGZ3?=
 =?utf-8?B?bUZVRFZWNlA2TU9uaHJDRXhMM3JKeXVEUmJld1hXa01VUzdvTTdNSTI1UFh6?=
 =?utf-8?B?MWRTSXl2RThjalpCZDFESWwwTkp0RU1BL3VSbml0SXE3Y1NVRjE3dWNaVGk1?=
 =?utf-8?B?Tk5Uc2lZdThRMHJTS1FjN3ZOYURoK0F3cy9Reis4RWJXNnBWWlhlOFJwbUJ5?=
 =?utf-8?B?dlBLT2ZNU3ZqdEdNQ1oxMUlKTG1DQUU5a0daZkRMRFlLSUFmc1RxNlNPT0VV?=
 =?utf-8?B?U0FSV3BTTUIwRHVSZEt1RzQ1Yk9ZY2s3MjhkRkx6REI3TXgzcHlVVkFidmxu?=
 =?utf-8?B?RzJHc21DRFdublJacE9UNmorUzF1VEo1ZnNKbDlaTFVWNkZ2ZjVOMzhycTZI?=
 =?utf-8?B?cEpSdVlJVjRmQkxCM0V3eDkwZU9FdEE5TXdXN0Zsa3YwVk0wdU1tMFY1Ujdw?=
 =?utf-8?B?TGZwRmZSSjlubVNnUExFT2lNOWxjR1V4bmxSbTRnK1RUNURTYXFZT2dueDg5?=
 =?utf-8?B?bGp3NngxTEo4VkErSjNEUTc3TFZyZ3VNM2xJc3o0dlhoYnkwa29STVV3azRr?=
 =?utf-8?B?aDlCQ0w1K3BUajZhVkpVcTNZK242bXVSeU40OXVaTDBZWW9TUWl6U3NKY0NS?=
 =?utf-8?B?OHh5RU9hbm9yeVpGVkZGVzJRUTYvd2FFaXE2Q3hVQ3RUVHBkaHBmL2ZMcDJV?=
 =?utf-8?Q?wacg5Hz52S76P9oJfQkoS9DQA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ab2738-a44d-448c-6514-08dcea34a339
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:38:18.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJRFrua5VQAcgaDgqeh+O7CQBlG+u5KapVxvs6i4aX0N45WX1bqTEpe8huSLqUGqpDdbY9AL5W8wwwGE/mOxtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8190
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Tue, Oct 8, 2024 at 1:17 AM Ira Weiny <ira.weiny@intel.com> wrote:
> >

[snip]

> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index 199afc2cd122..387fc821703a 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -403,6 +403,8 @@ struct acpi_cdat_dsmas {
> >  /* Flags for subtable above */
> >
> >  #define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
> > +#define ACPI_CDAT_DSMAS_SHAREABLE           (1 << 3)
> > +#define ACPI_CDAT_DSMAS_READ_ONLY           (1 << 6)
> >
> >  /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
> >
> 
> Is there an upstream ACPICA commit for this?

There is a PR for it now.

	https://github.com/acpica/acpica/pull/976

Do I need to reference that in this patch?  Or wait for it to be merged
and drop this hunk?

Ira

