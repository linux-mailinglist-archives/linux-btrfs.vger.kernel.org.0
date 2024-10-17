Return-Path: <linux-btrfs+bounces-8992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBB9A2F9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C288287FDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B62281C5;
	Thu, 17 Oct 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFtekvmu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD21D799E;
	Thu, 17 Oct 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199728; cv=fail; b=fV5kOdanOxDwnIWeqU1ys7wB5hqS0TXjSJlTvaLkmpTz8TXJFn93tb6B/q2VY5518Dgww/bfyrgIT9F4gpqQuUwc8lYnuTd5yDNa86wQSchaJwr4R19LoaPRFr6cm8nqsjx/pMPpmlQStqRkG/RdvPWNpOXiV0Yqif07GnnWPDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199728; c=relaxed/simple;
	bh=maZ/BCRmVRNXgrg3+PesluzEkZOYnu6dTjr/z9JtGCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LlZEEY8IGz3U83y86hGWzFpJSs+JlF0gUJtT5Pp6D8kOttrwPsGu+2ybHDcS+Ou6AKnI+DYweibrrnljf4x67W2Q+SLm0m5VlQLwM9IWk/iWSGpE1bOrnJNT8VzV3V5mpHTJMucjJYqKyrwH/GCbCUggIqfaatN6GTFGhNRf7bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFtekvmu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729199723; x=1760735723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=maZ/BCRmVRNXgrg3+PesluzEkZOYnu6dTjr/z9JtGCU=;
  b=nFtekvmu6itrYCrNpTfS3YRuEipOhBZjnj6qp6zLawGdjGrrmWiyKBIZ
   oJNdEVXM/5DuqZHrkh2h9WRmW/y1oc1m16CrVWF5bkGDc6d+0fO7uh2Jc
   jwhvL19v/6BbxQunVTumDkXCl6t5A8Jprm13x8j5/uCyoCUHLMFbxlPd+
   U1mVZoWXdLSgfofRdHknPili0h7eZ5n1OYQpj0Ol9+EUV4rRIvoGC3bq+
   vyz23IhrxQGJ76yPmp9E4IFgzwoip/c2MKMS/9bZyrNDi4Armk/MtZy6W
   /zjIV+qT5wT1m8bZ3xfK6otpa+EW3qnjjkTk6WRAjxzIVJZxfQCZDva++
   A==;
X-CSE-ConnectionGUID: +2+U8bM6RCqDbzoIUC+g5g==
X-CSE-MsgGUID: sLm0EwD0QIC6NJEOqOY4Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28181003"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="28181003"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:15:17 -0700
X-CSE-ConnectionGUID: I3vCRMiZQ1Ko70KIUYxy+A==
X-CSE-MsgGUID: RJA7Xs/kRZW7CP/Hm8giDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78342965"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 14:15:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 14:15:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 14:15:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 14:15:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLyd+Ur1lqGNkCv4TDpbj7zH/bA7oWbeC1AMRoZfHmF4R3TQNQXD1u+4IpJX+URNdPIUhCOF0S6JuO7TInNFui7t5UMcH02Thuja3An6Vfi7BF/5imTFKYY4FdpN82emyKiuIrDpwL+M4/+2rdFAg0RPAk8XV0YglzC0rCDf9EdgxAlHUyPrhk+DnvwtU/PhWh8t/IXI3pJAS6/oqQPHOH5mGuXeBojNqYedbP8fBMRBf1xfYac/jSS2JydFyFWhZEIvT3AdVqqvHaMlsunqapEHlHUHq4sl5hAH+GV4wl3yHYLIb/tqVHfraGHmfcn7owMcTiPNBVvgdE5/xd7R/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9NbZHZTqrUSL6ZnkieMvWpS0i1kJicHu75OdY6Rgb8=;
 b=p4rON9jxtJk5/G3bsUepDgOq9/i8OsI0fDDWOYuij7QXPekuTABU/vOyw59BmK8IDYKzIrUpswxw7gX9IW7onP6zY3rVGeyw0x0iQL+xu9Jwgvpp2QzQz+QhgHw3WfQTAPf6ytUmhQEZ9ScMaloez6ee39ApmTcIyFFGP7HyTLr58umWXSQQsxqGNmS7NkX0xy2iVV7liqzp/eBYwDkeLiN8b6C83/uQ01i98zURdNLmFGYXKaE+seEhUQgw1bwt2QfVNypAt6goodSC4bQ7Kl+cWGm7g8ibnas0apyKBG9SrcVqBcFBNbpDNhJwLEHaSB6fcsFps2hScOydiYBGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.30; Thu, 17 Oct
 2024 21:15:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 21:15:08 +0000
Date: Thu, 17 Oct 2024 16:15:03 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: "Li, Ming4" <ming4.li@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Fan
 Ni" <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <67117e57479b3_2cee2942d@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
 <4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
 <6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
 <20241010155014.00004bdd@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010155014.00004bdd@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: f29b5c8a-7abe-45c7-85b3-08dceef0c74f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GBjnEnpt9O5GVbxAswSVcoD4dH4ak2rrWe2X/fyCYjj1uu19RYtmMZUgR5X6?=
 =?us-ascii?Q?AFloaiZULc6qPGEmvvpTXVyQJiQ36CL7kWYWN8Wfz8zcoLmvMfqs3HRSju+J?=
 =?us-ascii?Q?LbHKTzSx6JdYQ7E4Bl7v0JXc9u5ZGchK0v4AGjrNGyq0mgKnt7HfZ7y/bWE3?=
 =?us-ascii?Q?aQM46J8jnMNakBNxk9teYseRCcOlGAmaCGp1mPLPMIZBxUaRCwS8U0w3hrsS?=
 =?us-ascii?Q?v0dFhj8j4Te/AO5gtcD5/xSAnh29zchAJE+hy0/jqFcRLYJoJD1aRrLme6yI?=
 =?us-ascii?Q?gRiZdUjyaUYzhE0KfX13uej+daLoVBX7aPbKBJ63UKT0cf6Zxv+pAKMzFhCU?=
 =?us-ascii?Q?pHBV3c6/aph9r3Y9tcncwns5+53MHSNeDzc6bu9XgxrSziE96Gp1Jw1nmlgE?=
 =?us-ascii?Q?6ibhadCZRP/KaqLx9WmF3M3f2l5o9HfbF2QtX0caDS68KEC4f9pb0BTPfPfH?=
 =?us-ascii?Q?9WaSndV2BSAB6p9PZge/8/re+YnLdV4qvmZsNoY6VF5hcouGQ8mMQLveaLax?=
 =?us-ascii?Q?mDnfO7jCixrdLxMp4z5+aJNrNkt5vAx/qTYsoOuosrGDyxpbeZO554wI3HD1?=
 =?us-ascii?Q?FCUVvPmgh2ZvEuj2trgrCybgsOGSmLcjyminENS+L5AFbVaWwc1qQHO7U+YT?=
 =?us-ascii?Q?XNc1e7hbz8/vIK9lD/hYaKsW++S+Dnh9MD6t7JWvVI+lu+skGrEDm0kpNilg?=
 =?us-ascii?Q?NRy2naZvRUANtuqzHFvelgfO7vxhyrx60+tGf6kaN04VW6ysVrpKYVj/UAXV?=
 =?us-ascii?Q?miFrO3y8uatXt6HzuMKb1b6bcjiKMxL9W3YWS8cWG21wktqhucn8skpSiG0i?=
 =?us-ascii?Q?9cAyKD5fFTK4/HCQhwvs/PhhiMC54SLDrVBFE0hlEGZ8m1XXKm/+o5yU2ss3?=
 =?us-ascii?Q?bEJGkbHcgQCBPgq0LjLa/hIkWoHp4t7o/BxJHnxTeQyvGIDfVoziw4Rk+E1C?=
 =?us-ascii?Q?cx3k5LEoVzXqHyKnYoB3gEA/lsmOvIZBg71pgyY5cVm7p1rJFr1INvSEg+6c?=
 =?us-ascii?Q?Ylep0mrlNa/IEGtv4oM7GWNrueGU9JofTnyzNf72kc6X5u0tkhoWlzRdvrf4?=
 =?us-ascii?Q?HzsyXuI8FLxm6f6rYpOE7eBMBuSXuMj1QxuRXkX1OfTpEQ914wfEox4z3Rte?=
 =?us-ascii?Q?RVNczcML7laqyMDxhm5pTCa+gl9PD+QsXThYBB8W/Nw/zRxznCgGIx4gxE+w?=
 =?us-ascii?Q?o5psnjz6odE66PJDqPvn/1i/DHO8K8n3jcvB3rtkgDbAVET5C3r7bZx6YmpI?=
 =?us-ascii?Q?gou2mB4HQEQ6PykhStbwecSvm/WMONZVOHpDYxlqvXXLQG9fBnDTSqw4lDiL?=
 =?us-ascii?Q?G25fiQOeOX2m96lw6A0FypjT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqB9YKCP21HGIEAzWPjVO+BEmWf/sSZ6v1gZAWqgKwW5yoeLmPCSMTIZ5NPA?=
 =?us-ascii?Q?WPLa+g2BlgnxP3ufsb65vQguZ9Kk3wFCLxXnL5eUH8Vw0w1OhxCrumq7tKyE?=
 =?us-ascii?Q?nfzpR14B+fs00IpXGCEbfaIM16i4E6ZgkwYZAGILzD5//kFszN0zdllhI0Z8?=
 =?us-ascii?Q?ECmkNCQlyeUhgxd2fI0ejs7jaVMTIKEBgFFFyJwqRWJvuaqFFv7C+JPMy+2e?=
 =?us-ascii?Q?P0QVRErhh9HQAlBhoWM/yR7qS3RsCzNOMizisc01MhrsgmZnKMLRGnNmzEgV?=
 =?us-ascii?Q?shDWUtRcSFMqI2axFiZKtt3/uAMM7/m/IH19pvjyss2l+3ZtT0jU5ync4B4h?=
 =?us-ascii?Q?ig9jodkcbS1NIkS1GQkskRUrWP4t4L6IiAAJWRFkUQKSajQROoaC22fmhUFi?=
 =?us-ascii?Q?Coy8XyIrokHFKPUq+2WbCBl7HNlTFV9VbPyoCWBWrN6zO6TARIu0yzC1Wtub?=
 =?us-ascii?Q?7rGBBDA+uR2yLk0QEi+HC6ydhbZXKP0W/DudcGhxQVzpSe0Q4XT19t9WFp+u?=
 =?us-ascii?Q?UYb9E9ZejKSkMLFHYgq71lKnNk495WgjVu+Pi1WlBawYezOpEupOW9CmEtFc?=
 =?us-ascii?Q?PNMvclKxAQrclJ0EdPUn05c3UUhHHMuptDdIlsZCuExEgxE06rVPxv82BUJf?=
 =?us-ascii?Q?MzR1RdBDTXMJuw44JIbndLjuZZyp4agmOO+ZhqibBKoxyQiirC50uL3H7sPK?=
 =?us-ascii?Q?u1tOS3gARLEo0il7kRtmNy8xxU8nuLF4YtJEal/itVJ0GXdshtmyNruoZHd8?=
 =?us-ascii?Q?8NmwelUNFwDCS9+ncx538P8Oyoh0SqprlKtlStdh2ZoP62JwFmxhK+TYX/De?=
 =?us-ascii?Q?M/Ryn4JXcdbryipZeWXWEfq9Rt4zzM8RdE3sL163piDNJ+PZ/lPUL3Wu9z3p?=
 =?us-ascii?Q?cg2441ZK07+9SRGryn4X0/vLD/qwFDP02XbE0f/upZ4S8odGh6++DKrfbApP?=
 =?us-ascii?Q?/xwf/4gCSJ/TNQsyol59bckrsFYNAGTSwXR4WwhgMqRkxjvMCagBeX0sL6au?=
 =?us-ascii?Q?N8s9rwf475eDwn7wdrUfIJM6pmvhrX/Z0FvnWab/Eo9jODxYK/epq3KufLx5?=
 =?us-ascii?Q?S2oVs1Dd+GLSU14yTU+KTdKJC5OwtaSKjP4DsbEeQ/zJ7P1GrFXcf93lSr0O?=
 =?us-ascii?Q?kLFZa35JxkFhXAXktx5PvCPjv0NqZuO5k+93NyLqoAeoFX3PsnGCANE2VIgG?=
 =?us-ascii?Q?4NfhZIwP70LK/JVb7lxpD153KPWzZaKyW/i97Xwr/xxXHzmAyf1ZAeru7elo?=
 =?us-ascii?Q?ZIGFZAAJlwYsq88PS5mzTaccjOSJSHhKom50mJtY6wHR/IRm7x1/XPxTyrD4?=
 =?us-ascii?Q?fOGDTTC0JAwd+7h38QtppZUXvMwjb+8H8n7qVyfx9w1YINFF8J8AMKk89zqW?=
 =?us-ascii?Q?q1at5+ywN47qjVHxac8io2OGffQ9dFRSyNW7NeYf9N5zVPfwM8et1j9CAzCC?=
 =?us-ascii?Q?bAlO0qbkHsPeAjIsQSC0YCGvUN12oRDROMOiRk2cWKKFNXrr0U7143Bh/L7E?=
 =?us-ascii?Q?zEG9kNSJUry2LCn2qMwqAj+CCFFLqSMNXYM4+7Y2jZkkdRD+pHAMjBJ1OkGE?=
 =?us-ascii?Q?nAcNWhGplQWshNrCD0T2tM/gDppyWl2QfOUGjqgO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f29b5c8a-7abe-45c7-85b3-08dceef0c74f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:15:08.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVXHvWT3ZBxDI7W3gkASPqmWswAU50+Jo30+dSp4gN07heBj66Vn6nY65hjYn3QH3Nx/ASDLHMThnhbx4pCl+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 9 Oct 2024 14:49:09 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Li, Ming4 wrote:
> > > On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:  
> > > > From: Navneet Singh <navneet.singh@intel.com>
> > > >  

[snip]

> > 
> > > > +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> > > > +				struct xarray *extent_array, int cnt)
> > > > +{
> > > > +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > > > +	struct cxl_mbox_dc_response *p;
> > > > +	struct cxl_mbox_cmd mbox_cmd;
> > > > +	struct cxl_extent *extent;
> > > > +	unsigned long index;
> > > > +	u32 pl_index;
> > > > +	int rc;
> > > > +
> > > > +	size_t pl_size = struct_size(p, extent_list, cnt);
> > > > +	u32 max_extents = cnt;
> > > > +
> > > > +	/* May have to use more bit on response. */
> > > > +	if (pl_size > cxl_mbox->payload_size) {
> > > > +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
> > > > +			      sizeof(struct updated_extent_list);
> > > > +		pl_size = struct_size(p, extent_list, max_extents);
> > > > +	}
> > > > +
> > > > +	struct cxl_mbox_dc_response *response __free(kfree) =
> > > > +						kzalloc(pl_size, GFP_KERNEL);
> > > > +	if (!response)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	pl_index = 0;
> > > > +	xa_for_each(extent_array, index, extent) {
> > > > +
> > > > +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> > > > +		response->extent_list[pl_index].length = extent->length;
> > > > +		pl_index++;
> > > > +		response->extent_list_size = cpu_to_le32(pl_index);
> > > > +
> > > > +		if (pl_index == max_extents) {
> > > > +			mbox_cmd = (struct cxl_mbox_cmd) {
> > > > +				.opcode = opcode,
> > > > +				.size_in = struct_size(response, extent_list,
> > > > +						       pl_index),
> > > > +				.payload_in = response,
> > > > +			};
> > > > +
> > > > +			response->flags = 0;
> > > > +			if (pl_index < cnt)
> > > > +				response->flags &= CXL_DCD_EVENT_MORE;  
> > > 
> > > It should be 'response->flags |= CXL_DCD_EVENT_MORE' here.  
> > 
> > Ah yea.  Good catch.
> > 
> > > 
> > > Another issue is if 'cnt' is N times bigger than 'max_extents'(e,g. cnt=20, max_extents=10). all responses will be sent in this xa_for_each(), and CXL_DCD_EVENT_MORE will be set in the last response but it should not be set in these cases.
> > >   
> > 
> > Ah yes.  cnt must be decremented.  As I looked at the patch just now the
> > 
> > 	if (cnt == 0 || pl_index)
> > 
> > ... seemed very wrong to me.  That change masked this bug.
> > 
> > This should fix it:
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index d66beec687a0..99200274dea8 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1119,10 +1119,11 @@ static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> >                         if (rc)
> >                                 return rc;
> >                         pl_index = 0;
> > +                       cnt -= pl_index;
> >                 }
> >         }
> >  
> > -       if (cnt == 0 || pl_index) {
> 
> I thought this cnt == 0 check was to deal with the no valid
> extents case where an empty reply is needed.

Yes but the bug found by Ming needs to be handled too.  I see Fan is also
questioning this code.

So...  for clarity among all of us here is the new function.  I'm not thrilled
with the use of a goto but I think it is ok here.

Ira

static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,      
                               struct xarray *extent_array, int cnt)           
{                                                                              
       struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;                    
       struct cxl_mbox_dc_response *p;                                         
       struct cxl_mbox_cmd mbox_cmd;                                           
       struct cxl_extent *extent;                                              
       unsigned long index;                                                    
       u32 pl_index;                                                           
       int rc;                                                                 
                                                                               
       size_t pl_size = struct_size(p, extent_list, cnt);                      
       u32 max_extents = cnt;                                                  
                                                                               
       /* May have to use more bit on response. */                             
       if (pl_size > cxl_mbox->payload_size) {                                 
               max_extents = (cxl_mbox->payload_size - sizeof(*p)) /           
                             sizeof(struct updated_extent_list);               
               pl_size = struct_size(p, extent_list, max_extents);             
       }                                                                       
                                                                               
       struct cxl_mbox_dc_response *response __free(kfree) =                   
                                               kzalloc(pl_size, GFP_KERNEL);   
       if (!response)                                                          
               return -ENOMEM;                                                 
                                                                               
       pl_index = 0;                                                           
       if (cnt == 0)                                                           
               goto send_zero_accepted;                                        
                                                                               
       xa_for_each(extent_array, index, extent) {                              
               response->extent_list[pl_index].dpa_start = extent->start_dpa;  
               response->extent_list[pl_index].length = extent->length;        
               pl_index++;                                                     
               response->extent_list_size = cpu_to_le32(pl_index);             
                                                                               
               if (pl_index == max_extents) {                                  
                       mbox_cmd = (struct cxl_mbox_cmd) {                      
                               .opcode = opcode,                               
                               .size_in = struct_size(response, extent_list,   
                                                      pl_index),               
                               .payload_in = response,                         
                       };                                                      
                                                                               
                       response->flags = 0;                                    
                       if (pl_index < cnt)                                     
                               response->flags &= CXL_DCD_EVENT_MORE;          
                                                                               
                       rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);        
                       if (rc)                                                 
                               return rc;                                      
                       cnt -= pl_index;                                        
                       pl_index = 0;                                           
               }                                                               
       }                                                                       
                                                                               
       if (!pl_index)                                                          
               return 0;                                                       
                                                                               
send_zero_accepted:                                                            
       mbox_cmd = (struct cxl_mbox_cmd) {                                      
               .opcode = opcode,                                               
               .size_in = struct_size(response, extent_list,                   
                                      pl_index),                               
               .payload_in = response,                                         
       };                                                                      
                                                                               
       response->flags = 0;                                                    
       return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);                      
}                                                                              

