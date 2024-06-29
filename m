Return-Path: <linux-btrfs+bounces-6049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6C91CAE3
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2024 05:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02A7B2263D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2024 03:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6E1EA91;
	Sat, 29 Jun 2024 03:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Og/UQVbd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29EB8475;
	Sat, 29 Jun 2024 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719632837; cv=fail; b=gQNMUVc1I7fnx6E5Wtavt+TT87NGTDdejoAtwG2wp2TwG/HQDyFUq/zJ+Np05iIHlMpq6oy9ZS5oEaBSzhUpPquM5C2ngKg97rvAIG6ovNbTOEAmksSD5oqKMRHON3/ksn2LEeyHl4O4JLCFoFh7k7wm+gLcIL7EaL/hqOOUDkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719632837; c=relaxed/simple;
	bh=wxcxweK9War0NaIOH35MKc9T1R0LS7XSS40s7Jvi9n4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IaTqgQ/RYC7aWOYcCSIY33dz6A5g6HHJ0I2Df9Plbb6qm+Z0csFg6Yrfwi4l1YWmlB5AEV+BvaCauVpslWOoTiGoh08r80+BmZMQdexiS0NBw7rwzW90zGxtRoN21noJgRNfVCsExj8U6jhaObr4V7pbcMuiAQyHi46dp1rZH8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Og/UQVbd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719632835; x=1751168835;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wxcxweK9War0NaIOH35MKc9T1R0LS7XSS40s7Jvi9n4=;
  b=Og/UQVbdBu94jVc3szoQP7OXckTQlUlmMbx0ATUwYLro3Yao/ObYQang
   0yVddvpfStgWwBYqfbldmoLA/GuwL1rXvJBbbGMxv3vjWMO64niWV8wjT
   CKOMtytL5QPDOHulQLykI/PKpdaL3juDo6Crnnr95qa7qctLuh/TXMP/J
   Aorpt1fAsWyRLRpLB7kkdKlSIMjoytyzzT3PnzpPdYJpOtVANYIHmpU/8
   u4WFFvzDaxSBT0HeB0DbmFvdruUeaCw5axFuU3+KZh0tEQ+sgEsXNi40J
   QC/7exoBOHM9QtUoKSPCAbOrMoJVTCdPtFrsqdtVvBScN7AXbPfI2CAZN
   g==;
X-CSE-ConnectionGUID: fXjm0ftbRbm6IefY8NxTfw==
X-CSE-MsgGUID: gVEbLEa8QxGY/qN3pcbQjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="28218164"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="28218164"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 20:47:14 -0700
X-CSE-ConnectionGUID: OgYmNHgwSfedOYQBcGzL5w==
X-CSE-MsgGUID: 3v0APIo2Roed0VOl68SO8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45605513"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 20:47:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 20:47:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 20:47:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 20:47:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 20:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG9EZu7Qo0ogqG3Xw0kEPz7vwBZXa2pzVJNbm8UnH5F886SpIQZK7c9GhShiX9ojs+5jFrbdOkVti9dhH4pqnuSyInXV+tR2ku7GG7x5+96KRfz741zAVHTm9ZZPquT9V3Q/9ttsHxtcIcbS2w3KNccgIvnJJAu3g13kUrHYPOfUSeqrd6Q3hRnP0GKIxSnLKMjHDolf9EaTl5Nw9HVGm+gH54JcZHoBDkg/e2We9f4F+B50JB5B/ltALEYGUXu+swxagPpvGSayBrb7r0l2DlpGJ4LZ8wM3Nfe4XmyJlVBU7k2JUcQGh8Cl2dzazJjirr6pfPTT1CcZD+hIZItJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVU+PvRwf6XQdyj2GiewK25ni2I4yq8NzIebwv6ncws=;
 b=Cp4ugzForF+a4Q+lKigp13p2vR3wMZF6VezlTj1Q1cEB1zXadPktCTEw3WkXuKgLNKP5rAPX6PZxuo8EUo2MDdSzNjZpzRZMMt7CMrGR48BFc1WlmeXnUw1eQOqWQXCp11Rn+lUEaD5GnfWzJ/N3xjyc10LMKPssxJC1HOqf8/vIdyA/BMPKl0GARZbFJNkAslThkBIOFUUJFgJ0AYWUhnI9TSKwsIiCElTB73ZBiN/MFukWIDZ0NeQ6wONMdqg9T5g+MYDAhqhrn3L/Heb9oSNTb72/bAkgIpH/Yw1hlGbceVuQBaQGCfwXMZ1phlwaMDtF8CSVox4IxCyCq01Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Sat, 29 Jun
 2024 03:47:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.7719.022; Sat, 29 Jun 2024
 03:47:05 +0000
Date: Fri, 28 Jun 2024 22:47:01 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <667f83b543c6d_310db92946d@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
 <663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff8beef-b78e-47ac-44cb-08dc97ee24c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lOh9LlifM+8mUV6L5IweDjO+r6okNkCPV+Cf/kDPjyA4HUZAfxXxYkDk0Vms?=
 =?us-ascii?Q?J8T0UalDpYpikGmtP3Q7GbUvYouHHAW3Cvgl8rXlqOIMjVRjAp2DUVnl/sbU?=
 =?us-ascii?Q?XGHoQth07mV8ZOLX51SdbHYwhAmrXfUToJ/4sU3m1DwPCw8iifaNCNriqZwB?=
 =?us-ascii?Q?nJwHSEzKrGe/oaB925ryOqsjaC3GSpByyBfStvXxPH0bJWh3IvTzSN5v9Cz9?=
 =?us-ascii?Q?oscKC5udhOZ0iamkSyGXHUfVqeBEFK/XXCN5DjbxSav3dND/qg+k+xip/rHJ?=
 =?us-ascii?Q?msVVW4hQmQXMllYx2Nzn0u3JplQxbBO/YjwWKN7n1yab1HR0jWrb7Je7dtER?=
 =?us-ascii?Q?Zi+X/fOlVmyM6GDMhRoF/HRduG8l0q4q/sHXZnj2ok6BRJITD+OgxnAAjeta?=
 =?us-ascii?Q?7m3z+EdMI7wpAQGflhP3L/6Hd+yga0IXHDuQr4cYbYmhPpTJAl/fPq1Gxf6S?=
 =?us-ascii?Q?mIbAGnSYrBv36dJI4u5oqdTqLSJjwdFNNH3QPhcfBMXCoB9UmRWgp9l81oD1?=
 =?us-ascii?Q?T0zjaRdl8lAj7s7Mw8IkQl1NJdbx9e1ZhoJbtPUvdlOMslwojmHB5T6/GQZ9?=
 =?us-ascii?Q?gNjex4fuIuVqY8ghCTvlx/uF8pStpJx+evpA37pZjJ+wPL2SASgjug8vYtva?=
 =?us-ascii?Q?J/R9SliU5wrq013WT8J5uRee/DAqVmU+dX471GkkMir+EsRxRi8YqZxK1WJ1?=
 =?us-ascii?Q?LcpOTeE0UZpEO1OEAbCq/mkBHizi3Xi2yOag0nf7af4Qd3JWS2hzRWhkyfFp?=
 =?us-ascii?Q?KZ6R73R6wWO6Ag/so/JVaoen0jv3XlaVkLoqguch5zsyZ62jbNKKSNgz4n91?=
 =?us-ascii?Q?8YumKzMUbGr7S2pw7Kz5M8/2hUIhUU5i70JSbWKLkkAvRrF0P0RoLEkZs5ys?=
 =?us-ascii?Q?mavkFbMW05p+ttrrsVkXM75QlR4d2ueJjMPUaVxjmQ8iPtC9lAKk+Kax1Iqy?=
 =?us-ascii?Q?UnTChgtCAahLIUY20USrOcDaIQDPF6mbCQ13GP+asgP7cFjX3Km4rVdvSq5a?=
 =?us-ascii?Q?cIOgy0/XnL9Y345c24cdYiFRCQzn+86AVnKcFZS1AZ8jjUKbdmaTJldyh1z6?=
 =?us-ascii?Q?wl8DN7sBPsFIroW4aEOH2fYOvjLGRO4cRDAxOwFc0SPBXt/b1SXWaG4TX/FI?=
 =?us-ascii?Q?dWnm5bIWolAx/gZQlDAq9fyTC736zpWspHWviOx+JsYof9Zqr5txR7BuPaWF?=
 =?us-ascii?Q?8Uci8E0s5stWGpL8gnSqgsIVZUEBSqZ6z5Z+moWbvtyCvehVAiDeQvpTUqo8?=
 =?us-ascii?Q?AN0hHVLFjBwTPjxFBR+JIJe6Z4sOQe6tlUEdaIv4r7QXDr3SG36D83JET0z5?=
 =?us-ascii?Q?OJdWq0Dn1wdvlj2lLM+LVpTOqoBvCPWT+2DG90kgWSKG2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWfVsZX3X6wwuaCqi1nB7EcmUec98tjvgqm9RN3jtsnzdor3l9XtHtkZQO5z?=
 =?us-ascii?Q?XaPkfGe/R6ccgUm2kQTaubHeYk4srJjg4XyhdhBQIssbegXx+9Waa91ZtmY2?=
 =?us-ascii?Q?R8TBXEjktV8iUcBYapm5GJ4F52CwDeYTdowJg2xKA/jRUJhuZA54DaheuANQ?=
 =?us-ascii?Q?yTpoxjyBvJncarviI1mhGG1pej2Y5fQGf83pCKFYMh8pS7oQXgJWO3JnsXd7?=
 =?us-ascii?Q?qfcDyCQ+OtWqxn4CKuaqJBe8orI6fYw2Ax31rGUZBE2iPDH7qeXbYAuB56gZ?=
 =?us-ascii?Q?o5sJJD9oxVRotjUXhdyccUz03deqkHW8r2VMNcDYeU0UsVZQ3B6A0CJ+nSJz?=
 =?us-ascii?Q?YwLGIu99m5NHO5L4+wB/smCH7p3jY6eMTviGsUY88VdAtmhsGK5XTfJAOHoH?=
 =?us-ascii?Q?slFx2aU4jCi7618i9Xfktb3qqKd5iIhi+KVvXKz8MjrpWzZUz4mdOip/G4As?=
 =?us-ascii?Q?D/1j2X238+dXAoxHoqB8PBRCZ+JsZuZOgVWOuoQZAxVyNTp9WpZ4rL5Yc5S3?=
 =?us-ascii?Q?VCkeEGcb6lDXAxif86CCB10fO6R8jweZfn8g8QGHST+KcDvGft0ee9SAD1Np?=
 =?us-ascii?Q?c9Wd53gz0nZngBBTmuYdL2AjofEcXdaQQ3Pp2aE9AbgsBk7TqMz7uwLJrsUM?=
 =?us-ascii?Q?6AYoZ43NnypVSu4WybeDTeVSuSQkJ20akT0ck8yZi1upp1jCFeDbSO5Q6oDw?=
 =?us-ascii?Q?UUc3sVB0gmyymvYiKBzu1cnx3PuSAo//Bz86NCwCjAxU7XFcKeiLvRQK6yuH?=
 =?us-ascii?Q?kw4Ntree78MvvQmvmbqDXKTMgyMNqPdGtKCb5KCTfje1SuwdFRh99SGGtX7j?=
 =?us-ascii?Q?IHrNsRDP5PW7ul8P4HqGza7bzWqzGnDOvp54HkS4A1sWB5XQ3pAhq46YJZu+?=
 =?us-ascii?Q?Ucqlr06EcNrRpbEMfz7P8FUYTHTzxuH741/K7PcpWAHUnfkOqel4aa/vTMg8?=
 =?us-ascii?Q?sxj2GH0y/xXoJ0nz/Wr7f8zSbhnE8sFVoDA3HXn3bwtHZu2/VWKanL1/0FgB?=
 =?us-ascii?Q?lqsmXKpGYmqHUWt12NuEgzZ8pKK4VwkLpcpVGDYt6dXjZjOmU+0kAZ9/LcXf?=
 =?us-ascii?Q?QkXF9oxnWC/q5relc6hM1VJ7B1gbHcrJSxPn9z8IDsAEY2imuZ+mekRM3qE0?=
 =?us-ascii?Q?VixkxXaX+OpxfhtHWQAI+ohEOVcUaxaFHS7TIph0y9Y9OuaP3jFaTmcu8ueP?=
 =?us-ascii?Q?TRjrBdKWP2qeHYpZiwoBQbBHZlawWhFPVBTULDrEuHQVvYYYJURqFFugZm8P?=
 =?us-ascii?Q?O+IDdRdZD9D6TteAPS10SWjCCfs3j/YbMLaDre4oLAL2+eQ4R8pZGagNa4eX?=
 =?us-ascii?Q?lBoguXN/QS6ky3erEVGC2ON9rv30wselNvp4KZlgIzwEe42WnkejVWrOGQwl?=
 =?us-ascii?Q?zpPqZOguaMNzRErD02birOSa2UuBgWZpy9wEiTSj02IOaAsNHR/HZ5gyWk0U?=
 =?us-ascii?Q?V/jVXQ0FAJ+j2gGAkoUoAHB7CuQRGy3ZYpcRglfV4Rp5B2s8lvbLHPTeJrHc?=
 =?us-ascii?Q?AFyRhYyU2L6zNpl96K1csfREz7dKx0EE4H/NoSmGKD2E7TuexZNEWWCM0V8X?=
 =?us-ascii?Q?ZYEj25O2lN//pP/nAGniAtbWVHulnZbLWzxE7wxM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff8beef-b78e-47ac-44cb-08dc97ee24c2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 03:47:05.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjeLnz03n1QQc+ZOj2auee3zqRQ3xdcYuJ/GfpayVcofKF2h6VapIBortmIXwj6GCszeKK99p33sy35nwG2Jsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com

Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

I seemed to have missed some of the comments/questions in this review.

[snip]

> >  
> > +#include <cxlmem.h>
> > +
> >  extern const struct device_type cxl_nvdimm_bridge_type;
> >  extern const struct device_type cxl_nvdimm_type;
> >  extern const struct device_type cxl_pmu_type;
> > @@ -28,6 +30,8 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
> >  int cxl_region_init(void);
> >  void cxl_region_exit(void);
> >  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> > +int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> > +			  struct cxl_dc_extent *dc_extent);
> 
> There are already functions called "cxled_", so lets not invent the
> "cxl_ed_" prefix.

Done.

> 
> [..]
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 58b31fa47b93..9e33a0976828 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -870,6 +870,53 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> > +			       struct cxl_dc_extent *dc_extent)
> > +{
> > +	struct device *dev = mds->cxlds.dev;
> > +	uint64_t start, len;
> > +
> > +	start = le64_to_cpu(dc_extent->start_dpa);
> > +	len = le64_to_cpu(dc_extent->length);
> > +
> > +	/* Extents must not cross region boundary's */
> > +	for (int i = 0; i < mds->nr_dc_region; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +		if (dcr->base <= start &&
> > +		    (start + len) <= (dcr->base + dcr->decode_len)) {
> > +			dev_dbg(dev, "DC extent DPA %#llx - %#llx (DCR:%d:%#llx)\n",
> > +				start, start + len - 1, i, start - dcr->base);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	dev_err_ratelimited(dev,
> > +			    "DC extent DPA %#llx - %#llx is not in any DC region\n",
> > +			    start, start + len - 1);
> 
> If the goal is give the admin an answer to the question "hey what
> happened to the capacity I was expecting?", then this should include the
> tag. Also, this is a warning, not an error, right? I.e. the driver
> continues with the validated extents.

Done.

> 
> > +	return -EINVAL;
> 
> This value is not returned up the stack, however, I expect EINVAL on
> user input errors. For misaligned device-internal addressing, ENXIO is
> more appropriate.

Done.

> 
> > +}
> > +
> > +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> > +				struct cxl_dc_extent *extent)
> 
> How about cxled_contains_extent()?
> 
> There's no other "extents" besides "dc_extents" in the driver, and once
> a symbol name goes over 2 underscores it starts to be too many tokens.

Done.

> 
> > +{
> > +	uint64_t start = le64_to_cpu(extent->start_dpa);
> > +	uint64_t length = le64_to_cpu(extent->length);
> > +	struct range ext_range = (struct range){
> > +		.start = start,
> > +		.end = start + length - 1,
> > +	};
> > +	struct range ed_range = (struct range) {
> > +		.start = cxled->dpa_res->start,
> > +		.end = cxled->dpa_res->end,
> > +	};
> > +
> > +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent DPA:%#llx LEN:%#llx\n",
> > +		cxled->dpa_res, start, length);
> 
> ED is not a standalone abbreviation anywhere else, it's either "cxled" or
> "endpoint decoder". I am open to renames, but not mixed names.

Done.

> 
> For this one the decoder name is already in the printout, so no real
> need to redundantly mention "ED".
> 
> Lastly, I think continued use of 'struct range' is begging for a new
> enlightened format specifier. I am thinking "%par" since these things
> are usually some kind of physical address, and I do not see an easy way
> to extend the existing "%pr/%pR" to accommodate ranges.

I've made a patch to add '%pn'  Not sure if '%par' would be better but
using a single modifier to %p seems to be more standard for this.

> 
> > +
> > +	return range_contains(&ed_range, &ext_range);
> > +}
> > +
> >  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  			    enum cxl_event_log_type type,
> >  			    enum cxl_event_type event_type,
> > @@ -973,6 +1020,15 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >  	return rc;
> >  }
> >  
> > +static struct cxl_memdev_state *
> > +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +
> > +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> > +}
> 
> Looks good, makes me wonder if a cxled_to_devstate() would be a net positive
> reduction in code. I think most of the current cxled_to_memdev(), just
> do cxlmd->cxlds with the result.
> 
> >  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  				    enum cxl_event_log_type type)
> >  {
> > @@ -1406,6 +1462,142 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> >  
> > +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> > +				     unsigned int *extent_gen_num)
> 
> I know the spec has this behavior where asking for zero extents returns
> the total pending, but that does not really justify having this extra
> step before retrieving extents.

Ok

> 
> > +{
> > +	struct cxl_mbox_get_dc_extent_in get_dc_extent;
> > +	struct cxl_mbox_get_dc_extent_out dc_extents;
> 
> The more I look at these patches the more I think a s/dc_extent/extent/
> change is warranted to cut down on the visual token parsing reading this
> code.

I'll try and clean it up.  I have gone back and forth on the number of
objects which represent an 'extent' and so I want to make it clear what
'extent thing' is being worked on.  This does get pretty verbose though.

> 
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	unsigned int count;
> > +	int rc;
> > +
> > +	get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> > +		.extent_cnt = cpu_to_le32(0),
> > +		.start_extent_index = cpu_to_le32(0),
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +		.payload_in = &get_dc_extent,
> > +		.size_in = sizeof(get_dc_extent),
> > +		.size_out = sizeof(dc_extents),
> > +		.payload_out = &dc_extents,
> > +		.min_out = 1,
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	count = le32_to_cpu(dc_extents.total_extent_cnt);
> > +	*extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);
> 
> Setting aside that this function likely serves no incremental purpose,
> why is the number of extents stored in a variable called "gen_num"?

It is not.  extent_list_num is the generation number.  That is a poor name
for the structure not this code.

I've removed this function per your's and other feedback and have changed
the structure to be 'generation num' which is much clearer.

> 
> > +
> > +	return count;
> > +}
> > +
> > +static int cxl_dev_get_dc_extents(struct cxl_endpoint_decoder *cxled,
> > +				  unsigned int start_gen_num,
> > +				  unsigned int exp_cnt)
> > +{
> > +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +	unsigned int start_index, total_read;
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +
> > +	struct cxl_mbox_get_dc_extent_out *dc_extents __free(kfree) =
> > +				kvmalloc(mds->payload_size, GFP_KERNEL);
> > +	if (!dc_extents)
> > +		return -ENOMEM;
> > +
> > +	total_read = 0;
> > +	start_index = 0;
> > +	do {
> > +		unsigned int nr_ext, total_extent_cnt, gen_num;
> > +		struct cxl_mbox_get_dc_extent_in get_dc_extent;
> > +		int rc;
> > +
> > +		get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> > +			.extent_cnt = cpu_to_le32(exp_cnt - start_index),
> 
> Shouldn't this be something like:
> 
> 			.extent_cnt = cpu_to_le32(start_index ? remaining : 1),
> 
> ...where @remaining is initialized at the end of the first iteration?

That could work but the math is such that we have to have the start_index
anyway.  So this calculation is 'remaining'.  The algorithm in this patch
is to query for exp_cnt ahead of time for exactly this reason.  But
without that initial call one must do:

	.extent_cnt = max(max_extent_count,
			cpu_to_le32(expected_total - current_start)),

Where max_extended_count is calculated per the payload_size.

The lack of a max was a bug in this patch.  So it is good to have
questioned this.  But the remaining calculation was correct.

> 
> > +			.start_extent_index = cpu_to_le32(start_index),
> > +		};
> > +
> > +		mbox_cmd = (struct cxl_mbox_cmd) {
> > +			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +			.payload_in = &get_dc_extent,
> > +			.size_in = sizeof(get_dc_extent),
> > +			.size_out = mds->payload_size,
> > +			.payload_out = dc_extents,
> > +			.min_out = 1,
> > +		};
> > +
> > +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +		if (rc < 0)
> > +			return rc;
> > +
> > +		nr_ext = le32_to_cpu(dc_extents->ret_extent_cnt);
> 
> It occurs to me that usage of "nr_" outnumbers "_cnt" in the driver, lets
> stick to the predominate style and just use "nr_" for symbol names that
> represent counts and just call this nr_returned, or similar.

'cnt' removed.

> 
> > +		total_read += nr_ext;
> > +		total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > +		gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > +
> > +		dev_dbg(dev, "Get extent list count:%d generation Num:%d\n",
> > +			total_extent_cnt, gen_num);
> > +
> > +		if (gen_num != start_gen_num || exp_cnt != total_extent_cnt) {
> > +			dev_err(dev, "Possible incomplete extent list; gen %u != %u : cnt %u != %u\n",
> > +				gen_num, start_gen_num, exp_cnt, total_extent_cnt);
> > +			return -EIO;
> 
> Why fail? When the generation number has changed I would only hope that
> means that the number of extents in the list has gone up, not that
> previously retrieved extents have been invalidated.

Actually it could be that previous extents were removed.  But it could be
that they were removed for other regions which had nothing to do with the
current region being onlined.  All the generation number means is that the
list changed.  How it changed is up to the host to resolve.

> 
> So a generation number change event likely just means to retry the
> retrieval starting from the end of the last generation.

I've added the retry per Jonathan's request already.  But this does bring
up a good point.  If extents are removed _as_ the region is being onlined
I think there is a race here.  I'm going to punt on this ATM because it
seems unlikely to be real.  But the list could change at any time if other
live regions are changing.

> 
> > +		}
> > +
> > +		for (int i = 0; i < nr_ext ; i++) {
> > +			dev_dbg(dev, "Processing extent %d/%d\n",
> > +				start_index + i, exp_cnt);
> > +			rc = cxl_validate_extent(mds, &dc_extents->extent[i]);
> > +			if (rc)
> > +				continue;
> > +			if (!cxl_dc_extent_in_ed(cxled, &dc_extents->extent[i]))
> > +				continue;
> > +			rc = cxl_ed_add_one_extent(cxled, &dc_extents->extent[i]);
> > +			if (rc)
> > +				return rc;
> 
> I would rather this patch just claim to only validate all present
> extents rather than pretend to add it. I.e. defer
> cxl_ed_add_one_extent() to be defined and called later. When it comes
> back a name with less tokens like cxled_add_extent() would be nice.
> "one" is already assumed by non-plural "extent".

This code has changed a bit.  I've avoided the stubbed out calls in the
next version per your feedback on the patch which added the implementation.

> 
> > +		}
> > +
> > +		start_index += nr_ext;
> > +	} while (exp_cnt > total_read);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * cxl_read_dc_extents() - Read any existing extents
> > + * @cxled: Endpoint decoder which is part of a region
> > + *
> > + * Issue the Get Dynamic Capacity Extent List command to the device
> > + * and add any existing extents found which belong to this decoder.
> > + *
> > + * Return: 0 if command was executed successfully, -ERRNO on error.
> > + */
> > +int cxl_read_dc_extents(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +	struct device *dev = mds->cxlds.dev;
> > +	unsigned int extent_gen_num;
> > +	int rc;
> > +
> > +	if (!cxl_dcd_supported(mds)) {
> 
> Why is "dcd_supported" being checked again so deep in the stack? How
> does an upper layer get this far into the driver without something
> already noticing that dcd support is not present?

This is the first check of this type.  I think the real issue is that a DC
region was allowed to be created in the first place.

Although I thought that was something I tested.  I'll double check these
flows.

> 
> [..]
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 0d7b09a49dcf..3e563ab29afe 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1450,6 +1450,13 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
> >  	return 0;
> >  }
> >  
> > +/* Callers are expected to ensure cxled has been attached to a region */
> > +int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> > +			  struct cxl_dc_extent *dc_extent)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int cxl_region_attach_position(struct cxl_region *cxlr,
> >  				      struct cxl_root_decoder *cxlrd,
> >  				      struct cxl_endpoint_decoder *cxled,
> > @@ -2773,6 +2780,22 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> >  	return rc;
> >  }
> >  
> > +static int cxl_region_read_extents(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int i;
> > +
> > +	for (i = 0; i < p->nr_targets; i++) {
> > +		int rc;
> > +
> > +		rc = cxl_read_dc_extents(p->targets[i]);
> 
> Per comment above, the targets should have already been checked for dcd
> support before being added to the region.
> 

Yes.

> 
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void cxlr_dax_unregister(void *_cxlr_dax)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> > @@ -2807,6 +2830,12 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> >  		dev_name(dev));
> >  
> > +	if (cxlr->mode == CXL_REGION_DC) {
> > +		rc = cxl_region_read_extents(cxlr);
> 
> devm_cxl_add_dax_region() happens way after the region parameters have
> been validated.

I don't follow this.  The purpose of this patch is to read and surface any
extents which existed during a system crash and were not released by the
device.

>
> I would have expected that initial extent list
> validation happens earlier during region attach.

The validation is just to keep the host software consistent and to ignore
any extents which are not part of the region being onlined.  Obviously I
have not make the purpose of this patch clear.  I will try and do better
in the next version.

> This reorganization
> also more naturally fits the interleave case where there will need be
> cross device-validation before cxl_region_probe() runs.

I don't follow this either.  What cross device validation must occur?  An
extent can be offered on any 1 device in the interleave set.  The driver
must ignore that until the other devices offer their matching extents.

This is why I have said in the past that the driver will need to track the
extents in the endpoint decoders not just in the region.  Because until
all the EDs for the interleave have a matching extent the region extent
can't be surfaced.

Furthermore, this call was placed here after the large discussion at
plumbers last year where it was insisted that the driver not accept any
extents until the region is created.  It is true that extents could be
read for each ED when that ED is attached to the region.  But why bother
if the region is never fully realized?

Ira

