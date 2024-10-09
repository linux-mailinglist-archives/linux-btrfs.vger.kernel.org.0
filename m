Return-Path: <linux-btrfs+bounces-8749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962239975F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 21:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB141F220C0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD71E2312;
	Wed,  9 Oct 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMxws2ni"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFC1E22F5;
	Wed,  9 Oct 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503364; cv=fail; b=ewfS6bjzS/YIVpqZ4n48aEENvBI5gx9XDkxchyH6uhpaODzAmXyv0Vh3EJX6Wi2cxgCsJEjoJIf8wLOhRRang1h4lEB7gcrOkWEndJxRHdAfLC6vR2WFfoOkBQEUFo1vpmVPoEQt5dnJ8bkdYdfr9/Ox5NLJQi+aLEdqlEi40lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503364; c=relaxed/simple;
	bh=QY301Xf46YxCp8u0o0zeHB2l+oDt7wkYUP3FdOe11KM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BYEhAWeTvV8mRmTfw8FvPitjjhTDJ4hjlKLL5oSoK5nTkOMUppWL8SZWLuU/r/YP8E+Ugd6Wb5vQfuvvbWlZY6JddBwH8PqPJ87/04rfOAXinkJmMqaqlKxMyYTmRJ1NumYxFtmSQHKEOmTMoX6HASdT4dsHtPSZFEZqhH0R4Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMxws2ni; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728503362; x=1760039362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QY301Xf46YxCp8u0o0zeHB2l+oDt7wkYUP3FdOe11KM=;
  b=lMxws2niWSx4hHqzp/pwEAXjYSTDk3k5desLNiQ8mIwEBIB4TyZruLWc
   OrhEC9jXFCXk+W9WF0C6twmV6HcZd49My8iTwf6yFMgRhc5SHaf8YLUwB
   bbNKYBdtLddDJa51jc+nHv4hn0/+lh09NIw5XOL/ntsCsJ/LXqLlBnmWA
   E4X7KI4G+ryCm/dT6nhk1Du3qbqKspt3g1n9hPl8P99UJEmnVbRrdM56G
   579t1QZ8XRD+l5x/gL4jzyV3pl229iQHmowGKXj6MxBz57xhdzA2QxnO0
   DCgEpOfQwv4Z/cneTR8bZwALJUT02LTEP8Kdtwi5OfrUoNm5nMa3tfEtk
   w==;
X-CSE-ConnectionGUID: jJmLzzoRRoeRo/qAkGPEXQ==
X-CSE-MsgGUID: JH3/07pkS5a+BbzbARGPDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27947645"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27947645"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 12:49:22 -0700
X-CSE-ConnectionGUID: KgIDcAYNQLyzDv3ght9Fxg==
X-CSE-MsgGUID: CFyGS9WwTsSVkQT1mVgW5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81372765"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 12:49:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 12:49:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 12:49:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 12:49:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yait+A6HXZqT7YkyAXN176G/r7xIgmF26T0tFS09gC2kQLbIISqlWMZBVI9YrPD2ssBvPzOqYd48pIDOsFv4QPq4C+qlOGg8Ko/L+o+UxGnVOXzECqFVGWKsKpCMfFBaYkMOQCJXQnknjITRYNYnW98FRWhDKO7arBBfXBPyyhi73loopm+VFMwahBjhWXhagWrBjDPsKNygpUAszxhHbA3z7VYz9u64ea8vuajnxbwWXEk9r2PkoFJ1Fty5FXiKQzZSTc40xFZFpvfEGYenqPIhRJTsO04YMZus0bKcOH6/3xaLSQoZBjQLFkk3ohfMBXYZxxiUX0meJjayGMadYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2UNBLt+PEO6fQ8TuaGfxOqHpTc0wXWBYMgKk9uyV2Q=;
 b=tZV0HXvdbU3QU2OyYEV1Vz+FCsROShiwXmf5J0o1ylXL6/1tCZoMNwa9+Urj+5in0KcYA3v2VJ6ABGotqoHTrX3Nywh2gQM0vKo8ggZZg8ZQIdqxz2GiTuGhJmdtp67eUM/h5kgr2Tl+zWFSviyP4IfcVxLWYo9uAg4w4sECEy+TGWSoKAU9AhX1Z8fH0f5AxxZi3E4AI68dQF+MXn8974SEtL5cGyosgzZIP9B8ZRdF/QO7IxK9f8e7gFbwo8Sr560ATwRsJaWC57NjqC/IbKxVEimaKoQkkXlwG3QiFdPmR2HooMF2JLa8yfTzUdacw9sFz/7Fo/g/+XfcjWNTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 19:49:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 19:49:14 +0000
Date: Wed, 9 Oct 2024 14:49:09 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Li, Ming4" <ming4.li@intel.com>, <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
 <4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
X-ClientProxiedBy: MW4PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:303:b4::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cbf47c-a7bc-4977-dca4-08dce89b73af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ERi+DGSjZxJJFxSshwYpHiICMw0aIaKqh8tbGg0fmFBRMfCkYyCv4EK8ufQz?=
 =?us-ascii?Q?P9bz17fcamUCG1pes4kYjJAkRhu5eEFMG2+wcrsigZyFRbgbCu7G8Fk+OBuL?=
 =?us-ascii?Q?wtYjFnISIorhEZnUVk8XRJwkMEwdkhLT/kgs+0/E5SvkSdE5zzwiB49juAEb?=
 =?us-ascii?Q?1u8KsTHmB/9voSMZXrEgzbKHx1V5CIwnu0Qbv3EVG3Gs5wXXbi9Eb8Iw1Skc?=
 =?us-ascii?Q?LdPjz+/t+OLRLEi9UPOuP46pPFnwzbzozY+/If6eyX9xX7DSCGVbseRcjLl8?=
 =?us-ascii?Q?YJ9oX5Cc5ouzJsFthYKAPsbDGtpw90oK5RJBHA7/MMw43VdVeaBgmmNbQGkM?=
 =?us-ascii?Q?hKL8WH6bmz+p5xiSaJbHKXwpd5ILkd+8UG4NI5JFVDCCcoREIwqydZg+oNn6?=
 =?us-ascii?Q?EA+XpwFFryqgwlr8bvzBljuo6vBE+YDW1DOY3L8lirTn76bcu7dQ98HD56Yn?=
 =?us-ascii?Q?i1fiHSqQzlIuXPJr+TXEO2q1OZaDVcbcDG7TAPtD2ztkq5GZRukNnEFTIK1B?=
 =?us-ascii?Q?QujExvbZW/1k3sbbNEg31aOpPpx+LIT8CNQaBRrf38PpaoUcGJ0kzvLBPZ05?=
 =?us-ascii?Q?yeovtt5r7/vWHO51ufsack3735Rlrl+zI7Mc3BcPBjTgN2ikqkGdJXubvBK6?=
 =?us-ascii?Q?sy9kpkCWQrNCN35HRQAOFVClUGPM69FlZdeai+T6krGhCTHHnberY9x0bjVn?=
 =?us-ascii?Q?F7lQdfdXQYUjF9j+l9zGWeXPR7Ewoz8xARNl6aj9NtejbkPnNdSIEnKk+Z/n?=
 =?us-ascii?Q?q0OP+voAA4DtGHfVf1NC5NMEVjlGPgqfYHKFX4ZgPtx/a9+CBDpfH6UHbecv?=
 =?us-ascii?Q?s/F9V40wVZ4BNhuTqAREiuxBJTH/3lhDTKUzW1wPR436KfgmpPYJP6qH1Aas?=
 =?us-ascii?Q?EFrVQR+tznO3UwyurmYQkhJk47XPXDVAhnWpzSU2seukah1lGwLBW5gjWFxu?=
 =?us-ascii?Q?qqHL3COig3gQ0LMAWFOS4oMxZKJmN20gkpEVUvvWby7Qqe7cA3ZiNkAitWd0?=
 =?us-ascii?Q?jex9KRodvkZf4gmHFvSNt+b/vdmhaFPgPYLRxthtrpBTIsSDdi1BYSgCuq93?=
 =?us-ascii?Q?qVCziJT1Z8DnuRYbuWGXXwIf52/cHSIOZP1yepFNLVeSp/FJH6kSJ/jYHd4w?=
 =?us-ascii?Q?o3B5bsevoHlxFBv+IJjz+ik1QXL1F91NvqozjrR321zGRRxEraIbXPAYYojy?=
 =?us-ascii?Q?x+QYon6rByUNzGcLyik9DnwgcgtqCdQgNTge7b0zjKauX9MfQYVPRLOOz2uA?=
 =?us-ascii?Q?jig0YNQOgTnLfTZgZ4soEW/Q7oaC/TlUh0C/+zeH4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dv4nydyWM8u+noE+QxfH/uSIt1QKuggECW/uxuboxx9qQMLbccNBsOz5hiLs?=
 =?us-ascii?Q?LpZ7Cah5hARZzvZceOufOoS3Y69fQlNTPo6Fe9EEcTn0VOzpXRF1erUyw8Gs?=
 =?us-ascii?Q?WLfBrM6hWJZgJ339YFhtaVzd88mjMXSeSNkVLWDEBxqQSYpPJcDXBxynk9hH?=
 =?us-ascii?Q?MZeXGC5YkQY9oTrp7spPxpYWhLFpLPdz9Gv0MJTrVWYxwbvf68BGrZ3JSTIi?=
 =?us-ascii?Q?ixo8gFUUAQ7EMgpCWDAcnUp93ZOCRqyK8lurqcXcmir+LnzFNSPrzoQLj9KR?=
 =?us-ascii?Q?AIhEBW+74KrsomBj39zLJz4Eu80yaBhS7hCeWPRnzwLUpjZ0xXK1PCfXEfn9?=
 =?us-ascii?Q?YPIWFxDzotphCekBa84BN9+PSE7f3gSzhrxDAeyYENh2zMJadHzxO3qG8+fu?=
 =?us-ascii?Q?uIjVj5HZ+z+mN6yI6BBVPieHBrwd8GTTy3vmmET36AP10TlISjU7449Ft7ar?=
 =?us-ascii?Q?e84H8LsH7JD9nUH4om4LTIlpgftYGY7Uv6eWXprbFfNxE10dSt/1F54I2Qsi?=
 =?us-ascii?Q?g5x6+K+y9se8fHrqVgl2gjif1ylRThIiVt1aQgXgySa+oLwOWBMp6bo/fGPI?=
 =?us-ascii?Q?OxYUlR+sjI5pkZvFrf/HShcgkf5UIK5A6IUOqliMlbOKm6VyaoahaOLFSImB?=
 =?us-ascii?Q?xs52KzyR/3r/BVW1aSzG4NBIEWR+XNVkeZtqMUiU6ylnoBQERXKm9oDOiuUV?=
 =?us-ascii?Q?asCvXUjYsM+7O6ofaBUyEVYfnM7//mLEJTcoi9Ju4FSF/cf1gMw5c5DC4vK/?=
 =?us-ascii?Q?KmWWJmEoLODIiAmd4KMAWs1247WmYby/CJR6V0kLISgxAkvygT/DsmQQcQci?=
 =?us-ascii?Q?3y9icULhg7qlRaTb121kiNJju0F29w5V/jMCFH2ATK+zz8GRnk3P0YYs5QRs?=
 =?us-ascii?Q?FpdAwTD8WvATbvckvBjdH9vzbFZ26f8IjsdUWDiudcuHucXwjuF3AxI8CaES?=
 =?us-ascii?Q?f003TyPkF1v9fL7AZlf0QNehgBULSOK3k7pnNR461T8wf9srZH4sazVNPvxi?=
 =?us-ascii?Q?aEU12NoAtpLe19kPPIAFbeU4zdIxh020OoE2fomngmESeEy/q7AGdw1MQQXE?=
 =?us-ascii?Q?5DDVsonJBQlYrzBi3jXemL86tZya9ZdbF+L0v2Oq5EjR5veV1J0+HqUlxHE2?=
 =?us-ascii?Q?GsrvZ9z+Q5IyJXD0BaMleAmhDofeWrDrcX52j9rBQ5ALeiseMCxZC4pkv9ya?=
 =?us-ascii?Q?gU3peWaPnZIal2tFH8lrJDB4cgE3d/boRcE9YQCVn175cllsJIqKbv2vvHbA?=
 =?us-ascii?Q?ByPzcQU+qlLC1scxXtTHwxxCxi29bprM+FksSJUTeej9s/2jKsgQTbpFvGhC?=
 =?us-ascii?Q?v/UxYNPgk8dD4cxmY3yVN80Gc/MLcmpXOjT0S/rNOwhJP1DOvV1Nl6lB5xkO?=
 =?us-ascii?Q?kGhv5rLhluhKh+iwTg+DhSEoaKgJoq3YU7k3csmUw299xGqj/4VeUWhY+2gj?=
 =?us-ascii?Q?qH7vXflKFv571DBjbmnGHhmKJNNvUmdF5VAJgbd9WueWaJk3lxG9aLKfDaKm?=
 =?us-ascii?Q?JqGJSy7USyPK/Kj45P6N8q9z6LDzag1eiElkh+Y+8zdcW6ZnnaRjgACclI+4?=
 =?us-ascii?Q?p71ECsTbeMsVkl59xqMwoHSZ2S++q/AbuLmMmCSW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cbf47c-a7bc-4977-dca4-08dce89b73af
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:49:14.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syS5O/i2+hTFaVqxhFjW3AYEqxB033har8vntJXXdO3hUU4hN2QwTTLd2SeVyn8wiRlHMZ/qSu3S8HIn4THMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8464
X-OriginatorOrg: intel.com

Li, Ming4 wrote:
> On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> >

[snip]

> >
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> Hi Ira,
> 
> I guess you missed my comments for V3, I comment it again for this patch.

Apologies.  Yes I totally missed your reply.  :-(

> 
> > +static bool extents_contain(struct cxl_dax_region *cxlr_dax,
> > +			    struct cxl_endpoint_decoder *cxled,
> > +			    struct range *new_range)
> > +{
> > +	struct device *extent_device;
> > +	struct match_data md = {
> > +		.cxled = cxled,
> > +		.new_range = new_range,
> > +	};
> > +
> > +	extent_device = device_find_child(&cxlr_dax->dev, &md, match_contains);
> > +	if (!extent_device)
> > +		return false;
> > +
> > +	put_device(extent_device);
> could use __free(put_device) to drop this 'put_device(extent_device)'

Yep.

> > +	return true;
> > +}
> [...]
> > +static bool extents_overlap(struct cxl_dax_region *cxlr_dax,
> > +			    struct cxl_endpoint_decoder *cxled,
> > +			    struct range *new_range)
> > +{
> > +	struct device *extent_device;
> > +	struct match_data md = {
> > +		.cxled = cxled,
> > +		.new_range = new_range,
> > +	};
> > +
> > +	extent_device = device_find_child(&cxlr_dax->dev, &md, match_overlaps);
> > +	if (!extent_device)
> > +		return false;
> > +
> > +	put_device(extent_device);
> Same as above.

Done.

> > +	return true;
> > +}
> > +
> [...]
> > +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> > +				struct xarray *extent_array, int cnt)
> > +{
> > +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > +	struct cxl_mbox_dc_response *p;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	struct cxl_extent *extent;
> > +	unsigned long index;
> > +	u32 pl_index;
> > +	int rc;
> > +
> > +	size_t pl_size = struct_size(p, extent_list, cnt);
> > +	u32 max_extents = cnt;
> > +
> > +	/* May have to use more bit on response. */
> > +	if (pl_size > cxl_mbox->payload_size) {
> > +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
> > +			      sizeof(struct updated_extent_list);
> > +		pl_size = struct_size(p, extent_list, max_extents);
> > +	}
> > +
> > +	struct cxl_mbox_dc_response *response __free(kfree) =
> > +						kzalloc(pl_size, GFP_KERNEL);
> > +	if (!response)
> > +		return -ENOMEM;
> > +
> > +	pl_index = 0;
> > +	xa_for_each(extent_array, index, extent) {
> > +
> > +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> > +		response->extent_list[pl_index].length = extent->length;
> > +		pl_index++;
> > +		response->extent_list_size = cpu_to_le32(pl_index);
> > +
> > +		if (pl_index == max_extents) {
> > +			mbox_cmd = (struct cxl_mbox_cmd) {
> > +				.opcode = opcode,
> > +				.size_in = struct_size(response, extent_list,
> > +						       pl_index),
> > +				.payload_in = response,
> > +			};
> > +
> > +			response->flags = 0;
> > +			if (pl_index < cnt)
> > +				response->flags &= CXL_DCD_EVENT_MORE;
> 
> It should be 'response->flags |= CXL_DCD_EVENT_MORE' here.

Ah yea.  Good catch.

> 
> Another issue is if 'cnt' is N times bigger than 'max_extents'(e,g. cnt=20, max_extents=10). all responses will be sent in this xa_for_each(), and CXL_DCD_EVENT_MORE will be set in the last response but it should not be set in these cases.
> 

Ah yes.  cnt must be decremented.  As I looked at the patch just now the

	if (cnt == 0 || pl_index)

... seemed very wrong to me.  That change masked this bug.

This should fix it:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d66beec687a0..99200274dea8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1119,10 +1119,11 @@ static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
                        if (rc)
                                return rc;
                        pl_index = 0;
+                       cnt -= pl_index;
                }
        }
 
-       if (cnt == 0 || pl_index) {
+       if (pl_index) {
                mbox_cmd = (struct cxl_mbox_cmd) {
                        .opcode = opcode,
                        .size_in = struct_size(response, extent_list,


Thank you, and sorry again for missing your feedback.

Ira

[snip]

