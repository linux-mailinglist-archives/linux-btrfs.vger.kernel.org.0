Return-Path: <linux-btrfs+bounces-3841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D10895F8C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070801F233BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96915ECC2;
	Tue,  2 Apr 2024 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWwPgXfZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A715E810;
	Tue,  2 Apr 2024 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712096836; cv=fail; b=hjW3IkouDnd3DQ8SGQ9zB1iNsbx+RXTMS703bG0RZI8wgzezhKSlwhCocvFlXY185Sg/LLLxI3qgOCTXywbK6Cy4pMXT8/zx2AvyCaHvfZhZAf+Bn/L0StIfaYmWX3ewe3/Q2PonAgwSidljMBcsqTfllo8VYigksQHJaGKw3UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712096836; c=relaxed/simple;
	bh=sQ8v2Fz23iD8N59rP+kFiz37MjAmeOr7Ccx1pTiDd4o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ooZwpyHmypPSuVnvwGIZ1U5JZD5vwukGMkqzpKep4v589wDPO4/ZknAcgHLYWz4MOF+xyHFXnDrojLnoWCNUAiN0eWEMVynl1Fwuz1VbBy0MamDVv99Ppb21lVm+YevZv1rPQ8h6k+tbuPe1M4ed+tspezk4pDKYMPbg1bZlwes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWwPgXfZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712096832; x=1743632832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sQ8v2Fz23iD8N59rP+kFiz37MjAmeOr7Ccx1pTiDd4o=;
  b=IWwPgXfZY+uvVEYJ/Bg13Q666vg8H0KPoUlZvx+SeVrx7TkF9EbByeK0
   U+SF1coreCg6OABnfurFahtFQ3TiGCgfv/C/iWRTJi0CADnmYUTtvq7ur
   nwgtE7JYD5xBlbT4vUM0P4XsIis8+n4P8RLNd6w7VNU9HUotp9jBIQziY
   P7btqs4FlLkJRLnUFpQzOGULOk/QQbixFVZhfuR74UA1AG1qvrJ0byEW6
   z6VCYso8mjm7rrfJBlgDALWKtp4ao3rgteKemzDWjOiPYeghnaYc0LS4r
   eT2ozlpTvtesrWpq0IR5IH1i6lGMJ3QlAqV/9vvaoUhDhNT1CEDnnYUw1
   w==;
X-CSE-ConnectionGUID: hLngzPBUSY+ENR5C/GDzsw==
X-CSE-MsgGUID: XlSSehk3SoSXCwq+xBSJmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24791908"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24791908"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 15:27:11 -0700
X-CSE-ConnectionGUID: OBABvH2zQKW9ofzeNUOyaw==
X-CSE-MsgGUID: AK3yHVwzSDuuZ2fUc5utIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="49215475"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 15:27:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 15:27:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 15:27:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 15:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkeDtow4QpSt+3SdzkBI1sZEvulEODtdNIcGem0/a21zjqVFCFz2jTB2coKa3JUbF+dte091H7gOuQsJkM3oVXsGfSu9w1Ip2O8NYaI1CqxilrUkMtDHKakSHoj++Ldx3DZn3s4xsk7xZTrzX1Jj7F2+xbemXqTlN1a3OaFbZt18Lm6Wzc3nXb4nFFAA7UDlLyYsiMT4SZtkWZYTOjigIQtgEFDdDSN46u2B4V21hylAvqWCCPYHNRLxcs4wq30nu0mYL7lJ3zyMnlVPQ4v8Ymyv669U/QZa4yrqnUI/WMahlPaI3bajpuAYJfGyS7xDgL7ecYTVIfh5TSdSDKZ5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjVrT7D9WKlyhG3AQ/mLYU0fhMyQcpd3XkwFw0vOU3w=;
 b=O7Guw9BdvTsSC+Bt6+VaR0aL0aU4nzbXbFqmxv3frw/mK+32CYQWWb/ooZiYA/k8O0hVZxSea9ccZ6/lWNJKPyA9m5FVs7J1J7jQ3LlLN1FSgwKSQUE1p15araMuC3m+OSE1OKVDTECvLS00CJCYgZEVumLQ12n6rSZbDSVCNfOzHBoakHI5IKWA9i1viC0kyq/BAz2nitGnBHs6wUrQLngsL9ZNR4AmhXFxpRYt0dyvaRlcWbzKLJI8RRzPpvZk/T/oKV0MxwC7JaZ6fCA18nKNqN6jNsZNQZv+nSTSGcD1ZC02ELNJiIXJeLUQWfWVqr2u1SiAX5vYHtvfFL8Tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 22:26:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 22:26:54 +0000
Date: Tue, 2 Apr 2024 15:26:44 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <660c8624cb3c9_8a7d029456@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
 <aczotz4a2xv6x4cse3hh5vpk57ekuwqii67pu46okdvdciae7i@qsopoigqhvw5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aczotz4a2xv6x4cse3hh5vpk57ekuwqii67pu46okdvdciae7i@qsopoigqhvw5>
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4709:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXPWMpyZI/QG1dziPXDkzMAfgycNAzeKYttA2eCMO1+JGMpT9CDkP24m21a9ck80ApX5lt2OqonCCArUgJMmyXEHQVfm9IoBUMXZnrfvm//NsysPP4FnC4F1XxeV8cXiWXlDI4bnQtdOuuuSWJt+E1D+WvOl90TO77eJdrx1lzZKM8NVvBYqqvreL4FnbFGhRJXeB4IJkdpn3dk6dy6BHPl7aAtGy04mqEH3IbHq2tJ7hsableYz+mhhSgQX2TRuE+27D7Z/b6mAdQ46tl8gizt2nYIYtpXfHKDlBlPFxWi3/Ho/+tcXgaO6Kid3T95N2nOppsvA6NOoHcQgEFzETycA2BeUGC11iNEAVmVBh9jaAlNLvDsZEzAozsBTAKuCBNLKR987i4I13Z253e15kJxYULNVdY292I0aH0szrxUTIb/udDNDumfzm1NEADBUHBSyb6dVOpDKr+quAvW6sER9HIpKxEvLB4etZlLqXViGdUw1dw8zheF61MSIowyHU51R3D6iLVUjtsqTwWtNAFGtE1SLEol84s+xKQlwbR72Oz0dor371YAw2eBIyKWLeqtSxslI+hTw0PT1UA8kAL/LCr2UcjJqFkB1B8Y66vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zp+I5kYchezsXRpMmZj6QEus1NeJ4Jd7ZxJcBOiQFltczoiutlCPZrhpXF5e?=
 =?us-ascii?Q?XewUxj9F5ieHIHbwgoJrUaSef3dodCVoSx+HadWjeiDa88z3Me0E8gBI6K7+?=
 =?us-ascii?Q?jhbfEsKzTmpRxh1/eMfACqHN+1u/o3/o4hqS4Nf2IXSbrdB/kEqwVie9x/6V?=
 =?us-ascii?Q?mFnjYdoRX9EkJl40OzvVKyEySQniK1VPlq2bTRzHeFujepGKRhH6fuoTigmh?=
 =?us-ascii?Q?B7xwlpb/DtTtQuvDGNjXVswo+9zj7OdkBpQfBDO7csfLYl6Zu/3uexiSErfr?=
 =?us-ascii?Q?Ud9BdVG5m5ObvHd5IgVNaa0Wb43oAfjiRVVPDioOM8siMc0avKOSGZvcAlne?=
 =?us-ascii?Q?hKKKWs8KFNI2L1Ao93/mT3zpLeBw/fSjKnttOp6NlkjozlLDrpsm+HkQWc6y?=
 =?us-ascii?Q?Q8YI9YRdr1759CsXCJUr0wpRzUoqUR7H7HDuLFTTUMh4YiPCb1kDFyvioHt6?=
 =?us-ascii?Q?kmd3TP8mPKJzdCiCGVRr5Zgife2Wpx9BJ4ugCJbUhDsmYaXeYIY76znzYpsd?=
 =?us-ascii?Q?KiICWJTGrnDrBrMMVezRMHwvH/AzQv1H1+Zp8E5Glnsk7djjHwNW0oP0Q+PA?=
 =?us-ascii?Q?cIfLnHBXyJSbbw6jrrnS3/SUVFAwZzRi2hUDZn07UCA8mOcnrCkjX0wVaRQC?=
 =?us-ascii?Q?OGZsl5aU5lK18o3WPFr+iOjIylnCa6qh0NjR3/FCytAvmBBqS1IQIQEFThLF?=
 =?us-ascii?Q?RyNVJRMJeCys30gXPCE6xc99nVA/bIoGnvrN3gQDpc7+KJwFB88DQO6BdBXL?=
 =?us-ascii?Q?Gv+M+B2yN9L4YOBCTYMsxu3uskgJAnjFjFrSs2lLhVPjALbWW1nxe0S5w20O?=
 =?us-ascii?Q?5pEpgxqgwDvUyt4GmBlY09ld+JoUtF6pBO4Ucpjt+w/oYMcK2bzYXn4gE4Uf?=
 =?us-ascii?Q?8/Xdu/TJ1xumPMoBN144t/htln+XtlY+NlG9R9tFkMphh2uDrU68nuRuRXVe?=
 =?us-ascii?Q?rlN3M9AiTmn5jkQ0xHk3QWTAIdHpio1dZrigJpA6bYtJK7pzNguvkxwolJGh?=
 =?us-ascii?Q?gdQyy+aLUZstPW+dslpQzcryPR2vWwg8LbStNZ3VvRXxT7GMi/hs6MI9yd3q?=
 =?us-ascii?Q?tVjE3gExz+dczmGmNqHXj4+tyc6SJwEEZx9pFiriEKFVxX1xNgX06MCzxUAI?=
 =?us-ascii?Q?/ihKkfPgMEqoGZtX/4hdMnbbHhYvxJIwzPMX+jflPZEmhavSnIK+gjOTq2eV?=
 =?us-ascii?Q?cl8VN2tbkCQCTekd9X6AObM0+/7Zd9da2CYSPz6HYSIfFs7pZZ11MCYZ0yKx?=
 =?us-ascii?Q?dHVgXRY8JHiCZtFwL2uHhkzjS67eA837R2aIKhKYXrZOcU/NZinX78r2nhy7?=
 =?us-ascii?Q?55ZxqdfXFiRCFQCkb9QksnVBUwXtUOFBQLg7cZ7Cz34b0QEpsxuYnvlheYip?=
 =?us-ascii?Q?Dbh+btE6dY4qVbvUJyEPG1YuSPLVzUDTqTZbVNYw4VRL04PSUgIHradSwrvM?=
 =?us-ascii?Q?cJtD3S77MvKT/ifwGolfKzFI9bdOi5hPQVsu7/w1I7eAqHgVguFT2e9YAcyG?=
 =?us-ascii?Q?tefAY7Xl1XkDPyQ2uW9nOtxT4oG+O/rTR13PqsBnn8NWD7Nk09QSNbW7EqtS?=
 =?us-ascii?Q?CafwqIHnzeXsAYDte1mwg55vrCx8PQj6jr/C9snS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc74fd1-da33-491f-ae3c-08dc53640037
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:26:54.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7g4w6QAelWcGkOnYskenpGjHTYhRPF2gw+TcShcuUVNz5L8WvbCFqVk8X3E5McMgBRk5q9YeTL4CqZ1MGsG20w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
> 
> >From: Navneet Singh <navneet.singh@intel.com>
> >
> >Per the CXL 3.1 specification software must check the Command Effects
> >Log (CEL) to know if a device supports dynamic capacity (DC).  If the
> >device does support DC the specifics of the DC Regions (0-7) are read
> >through the mailbox.
> 
> I vote to fold this into patch 3, favoring reduced patch count in the
> series to trvially enlarging that particular patch.

I'll consider it.  I've tried hard to split the original series up into
very easily reviewable chunks.  So I'm inclined to leave this separate for
now.

> 
> >Flag DC Device (DCD) commands in a device if they are supported.
> >Subsequent patches will key off these bits to configure DCD.
> 
> It would be good to mention these here explicitly (if this patch will
> live on). For example, that config will be the driver's way of telling
> if dcd is enabled or disabled - we could have cases of that zeroed bit
> but the rest enabled.

It took me a bit to parse this but I see what you mean.  Yes the
GET_CONFIG command is the one used specifically to determine if DCD is
supported.

I'll clean up the commit message.  In retrospect it was wrong for me to
mention subsequent patches here.  I'm going to move this final detail to
patch 3.

> 
> lgtm otherwise.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Thanks!  :-D
Ira

> 
> >Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> >Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> >Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >---
> >Changes for v1
> >[iweiny: update to latest master]
> >[iweiny: update commit message]
> >[iweiny: Based on the fix:
> >	https://lore.kernel.org/all/20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com/
> >[jonathan: remove unneeded format change]
> >[jonathan: don't split security code in mbox.c]
> >---
> > drivers/cxl/core/mbox.c | 33 +++++++++++++++++++++++++++++++++
> > drivers/cxl/cxlmem.h    | 15 +++++++++++++++
> > 2 files changed, 48 insertions(+)
> >
> >diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >index 9adda4795eb7..ed4131c6f50b 100644
> >--- a/drivers/cxl/core/mbox.c
> >+++ b/drivers/cxl/core/mbox.c
> >@@ -161,6 +161,34 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
> >	}
> > }
> >
> >+static bool cxl_is_dcd_command(u16 opcode)
> >+{
> >+#define CXL_MBOX_OP_DCD_CMDS 0x48
> >+
> >+	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> >+}
> >+
> >+static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> >+					u16 opcode)
> >+{
> >+	switch (opcode) {
> >+	case CXL_MBOX_OP_GET_DC_CONFIG:
> >+		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> >+		break;
> >+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> >+		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
> >+		break;
> >+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> >+		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
> >+		break;
> >+	case CXL_MBOX_OP_RELEASE_DC:
> >+		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
> >+		break;
> >+	default:
> >+		break;
> >+	}
> >+}
> >+
> > static bool cxl_is_poison_command(u16 opcode)
> > {
> > #define CXL_MBOX_OP_POISON_CMDS 0x43
> >@@ -733,6 +761,11 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >			enabled++;
> >		}
> >
> >+		if (cxl_is_dcd_command(opcode)) {
> >+			cxl_set_dcd_cmd_enabled(mds, opcode);
> >+			enabled++;
> >+		}
> >+
> >		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
> >			enabled ? "enabled" : "unsupported by driver");
> >	}
> >diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> >index 20fb3b35e89e..79a67cff9143 100644
> >--- a/drivers/cxl/cxlmem.h
> >+++ b/drivers/cxl/cxlmem.h
> >@@ -238,6 +238,15 @@ struct cxl_event_state {
> >	struct mutex log_lock;
> > };
> >
> >+/* Device enabled DCD commands */
> >+enum dcd_cmd_enabled_bits {
> >+	CXL_DCD_ENABLED_GET_CONFIG,
> >+	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> >+	CXL_DCD_ENABLED_ADD_RESPONSE,
> >+	CXL_DCD_ENABLED_RELEASE,
> >+	CXL_DCD_ENABLED_MAX
> >+};
> >+
> > /* Device enabled poison commands */
> > enum poison_cmd_enabled_bits {
> >	CXL_POISON_ENABLED_LIST,
> >@@ -454,6 +463,7 @@ struct cxl_dev_state {
> >  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> >  * @mbox_mutex: Mutex to synchronize mailbox access.
> >  * @firmware_version: Firmware version for the memory device.
> >+ * @dcd_cmds: List of DCD commands implemented by memory device
> >  * @enabled_cmds: Hardware commands found enabled in CEL.
> >  * @exclusive_cmds: Commands that are kernel-internal only
> >  * @total_bytes: sum of all possible capacities
> >@@ -481,6 +491,7 @@ struct cxl_memdev_state {
> >	size_t lsa_size;
> >	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> >	char firmware_version[0x10];
> >+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
> >	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> >	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> >	u64 total_bytes;
> >@@ -551,6 +562,10 @@ enum cxl_opcode {
> >	CXL_MBOX_OP_UNLOCK		= 0x4503,
> >	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
> >	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> >+	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> >+	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> >+	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> >+	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
> >	CXL_MBOX_OP_MAX			= 0x10000
> > };
> >
> >
> >--
> >2.44.0
> >

