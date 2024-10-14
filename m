Return-Path: <linux-btrfs+bounces-8887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F5B99BD38
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB1C1C213E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 01:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F512B73;
	Mon, 14 Oct 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLjthHRc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0D2914;
	Mon, 14 Oct 2024 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728868591; cv=fail; b=GkMz5wOyxQe66MR5topKlqo5adZIQST5GTLBkDvlr8gy5SC/dHlGRjEP70oUukpYGMQgBe3Y3R0N+nNi0vaIb+qxz8roQFQdmDEeaZ0Jafx5+wNHBNvfCS1xU6124U4CLbbHvRLx86zpr9Umvi7msJSm1NXkcvdMgFtrd3oohok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728868591; c=relaxed/simple;
	bh=0nBtbXZh5abV8HNsN9gQ/SNmmhZywTbc5c8bCF4CWcI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n4D102hdnfdJNEK/1eeI4Uil+QoLlSN0w4p620eu3cJc4zfUfmGK9YAsSMC9jM2a7TXMkCVtVJ0h64CP0lVM3EEDgGHAtqUb+kgNmnbXOvj1DNx7S7mD4H1sZPfDrst/ixKon5dHWJC8+FxLaFzYCMmRSzCWG6MnuSPHxxwj7us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLjthHRc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728868589; x=1760404589;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0nBtbXZh5abV8HNsN9gQ/SNmmhZywTbc5c8bCF4CWcI=;
  b=OLjthHRcUtA4PaXmrQj877goEkwGvogvA584dLQBiYZ45GpmNake2TM8
   tY2BXLdHi3gg3db8BiHyISkwZdb2YQCfGCTGC5Gr6zS0M65XILwE10D7K
   rE7xHZUUkI+aKJ/hQMR3hKfwAKISj0JAiDnF4cLH4tWMpTPM7Mro2C3Ok
   scCBPfcs+qD2W/0otvWqZv0ehIg+QK48UH+QEcZgnbLt5JVE9tjE4naFU
   8i8ufRvVtotxgc5YKx7mVH2P7F8iMngxMRFNdJSoWdFHup8xEI6tfxVD7
   2IqKSf7Eo2TytK7u1Z4scDKVWRirp6kqOWQc2jRp4+v1hFUeI5p8YldD/
   w==;
X-CSE-ConnectionGUID: cOdeHHGvTWG0snZKMnc5ww==
X-CSE-MsgGUID: Fh2nExAQTf2O0nlQrGpgYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28287652"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="28287652"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:16:29 -0700
X-CSE-ConnectionGUID: RrBn/eUcSwePhaofJz7A+Q==
X-CSE-MsgGUID: DwcbTA57SFCsodZy/8QUPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="82039108"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 18:16:28 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 18:16:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 18:16:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 18:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdioyhxBp/S2VyLu8R0FRJDOG8GiDQYYoTaVrZfiGY2qkKLQQTmdMg10EUuBoBbilqqNpTIItx8c4ICym59/YBw4/J91dx7UZQmsa4xQFWE7U/qxTiP2H6NGjui2OjaeHOl6RvrQo4ZnKlye6UbWbfSgBEtCAN/KtTEm6o5F16YucBRUTpmj8416OIjCH4ftib86e7TTcWuA04rPSbfaem9qxyw7G8/4Owr2oPthMW4+64V7zHhvvJ5jKyB0/igenrB/F/41HTuPULEqhGFnbPSVrTHwOM/tmwV3g/0453XidA48bR8x6HwKcZoHEWFSS0aO0JIB7QEKRMtOq9Cclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMogswxMyat/lwJqWsK5+Cx90CoIIFEMSHiCTKkbpkI=;
 b=GdcPiGPyqFaevmDB0A4EnTs8PHby1CPTfh00NaMTUYUbjn+qypXquXCsKgyoe7HtVgCnuDSYbgxu8ECG3kEyjgfoVrUUiAZa3X8dEBHQeYEiNiSV7+cRHt4UgnEQgWVX4aY/76dC+nF/3bLvyimT3arYFgQRuOaWZHx/FNFqIdluszspWu38gi1BHkSqaPrF0uSdzsaGeFPSWoUBIBQDpPm9F+jemd8GnjlcPcMdPO+Wc6CxGGbdmNVOYPNOJgUYluu5XsqpaF9foyz73B+xIouUmiCUAuwawndwfbjHAgdvGb1xzwn60JVnYIS2Le5zGmwxeS4gcYvO4vM+kRRIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 01:16:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 01:16:25 +0000
Date: Sun, 13 Oct 2024 20:16:18 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Robert Moore
	<robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 12/28] cxl/cdat: Gather DSMAS data for DCD regions
Message-ID: <670c70e2d760c_9710f2948d@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
 <ZwbIkQCzaOoUwWki@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwbIkQCzaOoUwWki@fan>
X-ClientProxiedBy: MW4PR04CA0301.namprd04.prod.outlook.com
 (2603:10b6:303:82::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc2a76a-8412-4d30-8ded-08dcebedd22e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q8KDNVL0f8lRPWXmLZdzgofIQQxJAlGc8yymAnPjnlUfhJXvf4mBOkcor4M0?=
 =?us-ascii?Q?MebUFGewkgBS/zbSmTcFFHPftUPskp+HmC5ivKHoeqhPlqq9wjFs+hkF0gK4?=
 =?us-ascii?Q?wHRSoPejXIjEThP7fmHI5BgllRITmhdDia3/6hI88cduo2Kc6TIZx3T0mRBU?=
 =?us-ascii?Q?b6lwgr2olYey7jo2F8bIyl/KHuGmsQyuTikJOmKCSO3hkCl7Cxapud7T1xCh?=
 =?us-ascii?Q?mIemKTvJgrpKmfFplBPDLGl8iyIEhWavE05LRlnm/wWjSMSNAAHpqHPiBH+C?=
 =?us-ascii?Q?c8mTojNYkMZY/ggXtNktgCkwbSgV5+le/yoiB3P29MLlsF8KJw0hBboEDHCm?=
 =?us-ascii?Q?TnIBk0VapOUonWCuMXjNZVCQOHNze9NWNGhPbd9VosJCRADUQzdabvo1vLlO?=
 =?us-ascii?Q?3fsLx27PhRRwrcOXYNIUMA6USAsyWhJzm5g2PbZxvyYe7pKiE+jWxGvNp8Td?=
 =?us-ascii?Q?5PLUB1GsVUdwz9+x8V5y6lH46S78gMU+e5vhHnnPVKq/ZADyY6QbYQkRzo2H?=
 =?us-ascii?Q?0btVsSRJB1gDxfC0/xry2sY7QzqJLzK4Utk7xH5x61+IC52rdPnSk4qqEUHm?=
 =?us-ascii?Q?C0zmJS7ndvNyH5ZTq+diL+n1xTQB5pf2lZqOoqouLd6wEWIHaDM6odsh3ITB?=
 =?us-ascii?Q?Z381R9Ywd19L503G09YPh4BfbzI3uWaw+kWiSnGls68ZOlV28VAlbTcwG2nz?=
 =?us-ascii?Q?U4dilNcQozi21FprBtDWKoQ3OWweL73vaDtQIl6QMTVu2/LN4WscEDdC80IS?=
 =?us-ascii?Q?o/T6YkMuHhSepOq5Sn6nkBbmU4PvwSP1n2nY+9/oaVPRowdKnnw7TwAOfpDQ?=
 =?us-ascii?Q?wwnSZkI4jFnUTJq1uZREa/qTN+6j5byBvez9kvqbZYlx6anpOhK9Fd+RD6S1?=
 =?us-ascii?Q?5jyRz6qAwnH6ze/aIsmegFZ4Yumn4tbV+3mkmAjdBm2qANTl3OK95C34mcXm?=
 =?us-ascii?Q?PbawoNYc7fRcskorg0Wyj6Fa+g25RiWr2lNB4KiPzCEEcbz2RCu/qUCqoah9?=
 =?us-ascii?Q?zD5xwSE72AEgh/WDnjLaDzZRxnVm9qcL+7oyick+obJsMfzwf3ksWrrQXPnn?=
 =?us-ascii?Q?ZGDHlPdsheOntHvteO5XNb6rktmNU+rKLRGMFON0DpZ7SVTYY422vlQXuH69?=
 =?us-ascii?Q?r/dE3vQxtkShdr56/U6eaok9ERoUWACbl+kFPdTmdfC9NPHw8MrTWsKjDy2r?=
 =?us-ascii?Q?zPrPN3BU1ajA7C7aPHB5mxrv1LYyFcNOsKJtcEdxqgtysg9J96sgKi583jIU?=
 =?us-ascii?Q?ie5+9PrYEnq84Mo+dW23rd6OaZUbplWPOBjjO8kqEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Nszo3leTxyDU1upbro+StDaXjIog1QJZKqbD4Cbgbgh8OGqCToQOT569YhR?=
 =?us-ascii?Q?QInsuj5IFanJZrM/OGCNY95db3EgHZXvQjqHldcE0y4DHR9M64lq7ubvF14+?=
 =?us-ascii?Q?TU3X0r/DjlC0SSGZZifmdCRqEDj1iy+Dm/X+luGhkL2MJ/GYAkAkaQ+ujJmH?=
 =?us-ascii?Q?MDSSHT9zusG5wUL++9L40kEEAb+xYV0JuKWfUBEUFeALlygebTb79LGPjVCt?=
 =?us-ascii?Q?4DTvQWgKsnjyDlV61UWfiXpFPF9j6qw2/RjYnqkKINRaEVIseshS4TPBRxGP?=
 =?us-ascii?Q?AmAX2D5+AzNVmMCdKyxrcSd7rygSLQUlWZ7/tLNiKO2hMCSx32MH1O1pvqpZ?=
 =?us-ascii?Q?eRzJvbS72kqUgYn+yVTmE1zJNF7lY8tiuiszOTlS96EMb0MoSAOOmUXvd+Ft?=
 =?us-ascii?Q?svO77IgaiekoPBFMzKNNdzTNcFSsAuhSYCt0WFlj68C9kVOQub93R3utV8Rk?=
 =?us-ascii?Q?ZtJA+sfbgiSgsBixce0tankCKCxm/7apu70+Y+uSk8HKrQGmn4prglpGuRoU?=
 =?us-ascii?Q?FqjcH/7fhRf6bqAVBkMDlEi75FB444/MEK+Ngc+FtJe/Xc0NZP5R5fT9U5va?=
 =?us-ascii?Q?SocU6gv6Rxtpmr2YTHuu2J5ohORa1G7GwFGfMpi2YXH7V1vPJunmW9WOkXsX?=
 =?us-ascii?Q?m5tqw9Rp9uD6kOvV3AmTpoSQo6Kdjnl8kMdGtvBLa6XgpfuKUFpZl3tqjcr0?=
 =?us-ascii?Q?NcilqmeAZOoplXULcGPCPzPG80bnf6tAlczmW+SDY4fZ6Qfy9Vv6Bpr7P0Ab?=
 =?us-ascii?Q?8ULYvmM9sL2WM5lpY56KrCDqy5My7+Cw5IzF/tcKaVfVDtEwbnrRVBNvBoHz?=
 =?us-ascii?Q?v9QJv5s/m8ZnA2dWNSRm1dbMeE4nAYPINpD7eUTmYYrUKYHGO5akRaqeEvd5?=
 =?us-ascii?Q?I+n17ynXoDPasb0DkJTrnLVfrKbbxIp6mGGqYa2F5EJuHrKJXxryA99HV7jq?=
 =?us-ascii?Q?rXdF0jWUZE/Wow0AdBfRUSI2t7qZYVlxcOIM01Cl+uyIWeN+q++NieatkL5Z?=
 =?us-ascii?Q?YsI+NUMazqL9a8SdUl8RjcCbHdrW6km2Qx5e2xjGxFFZVgJ6fKkrAAcq9Sal?=
 =?us-ascii?Q?WFpX9F0cevykzybhJ4LMLu6VeJF/fvBMvvJpmhiMnVA249rHsKcMosfeCfCE?=
 =?us-ascii?Q?s4abc6J/sJ9T/+mePhE8y+FBpHxkuozW8KEXXKdwKbgf0NherRvkKVx2wCPK?=
 =?us-ascii?Q?sUE0BkGfUdQ5h4Lucec7SYHeoM+jbT7yfzPoDbajomqV8qJoeT3ltbqdESBb?=
 =?us-ascii?Q?E6sUdRj1OUbJ/TMdfYqguJY61oiEvTPOb67Izd8P2Q1+EEI0rZcbs8TiKOzp?=
 =?us-ascii?Q?Z8k0n9BygHxW/aKMQj5+dMI142jgYknSlEsvpFLJBEKlxJcQEGglJfdvgxZA?=
 =?us-ascii?Q?Z2SXMZVax1Yjsb31b/heee5d3NokdnGGNTaC+fmRNZXR4OJWRVn8zRcp2HyG?=
 =?us-ascii?Q?wa+gB4YIZ5SStq3VPGVhuqTwS4dtnqKouHOB/lB3Aclzqg9Py73tNFBP48nU?=
 =?us-ascii?Q?I7zoztxZUIf+Tfvs+RLa+I7373JmmbW4PQekA8GwzV3Y7dCZnarG7g9UJ/nU?=
 =?us-ascii?Q?D93rF3Y+suWpKk1NrWMIQGYUulYIXOVBUKNvjjbx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc2a76a-8412-4d30-8ded-08dcebedd22e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 01:16:24.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho9NB70U/MDoxeI8QnSmZftAlX6JEIDxq6lDBfpboL2+/wWIrtiOK5VU9H7ZDsTohBCXRKgnqjAeT8qOjnxSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Mon, Oct 07, 2024 at 06:16:18PM -0500, Ira Weiny wrote:
> > Additional DCD region (partition) information is contained in the DSMAS
> > CDAT tables, including performance, read only, and shareable attributes.
> > 
> > Match DCD partitions with DSMAS tables and store the meta data.
> > 
> > To: Robert Moore <robert.moore@intel.com>
> > To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > To: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Cc: acpica-devel@lists.linux.dev
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> One minor comment inline.
> 
> > ---
> > Changes:
> > [iweiny: new patch]
> > [iweiny: Gather shareable/read-only flags for later use]
> > ---
> >  drivers/cxl/core/cdat.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/mbox.c |  2 ++
> >  drivers/cxl/cxlmem.h    |  3 +++
> >  include/acpi/actbl1.h   |  2 ++
> >  4 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index bd50bb655741..9b2f717a16e5 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -17,6 +17,8 @@ struct dsmas_entry {
> >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> >  	int entries;
> >  	int qos_class;
> > +	bool shareable;
> > +	bool read_only;
> >  };
> >  
> >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > @@ -74,6 +76,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> >  		return -ENOMEM;
> >  
> >  	dent->handle = dsmas->dsmad_handle;
> > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> > +	dent->read_only = dsmas->flags & ACPI_CDAT_DSMAS_READ_ONLY;
> >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > @@ -255,6 +259,38 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> >  		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
> >  }
> >  
> > +
> Unwanted blank line.

Fixed. Thanks.
Ira

