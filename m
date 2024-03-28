Return-Path: <linux-btrfs+bounces-3698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCD88F721
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 06:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C7292FCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 05:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D140871;
	Thu, 28 Mar 2024 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9XQ4yaO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E418E3A;
	Thu, 28 Mar 2024 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603366; cv=fail; b=aoJm2UhhV/zVp2RropJui0VKUZJNTAFtxQ3mcD3/MLuO3OnJMmpA7L74jGqv7JgFaCHXDGwtpP2K7f2fYLvrDMVrD6z9Ot48PWgMuK9BlYs+kEoiAhA+N0c4LWqek4UyRt4BEWEzeIfqBqk7g+XSARY8hKZ4HP7Vhuf7sAV0fDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603366; c=relaxed/simple;
	bh=ezY4+jgawocJNzOGkgxGGke5N2z6kHXiMee20N0I2dw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hUO6rv8js+xsWjoHBs8ltw/MhY4JRjD+Lq7QA9QzYfQR21NeXwLiNCL5P7rhE2z0b1TOoEl3+ksbYmzKeT6AvFsIemcCC68siqehp36TPnMO4xYqkbXc9v8ika3RfuT0WbCW2Jj/BBNpGzFxQZuieHHuZuYaEOXI4EfG6QRr+Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9XQ4yaO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711603364; x=1743139364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ezY4+jgawocJNzOGkgxGGke5N2z6kHXiMee20N0I2dw=;
  b=C9XQ4yaOk8Nj6ZGr4JTg3uT3uKwNtWyG/jU7hVf5rmUlV8PCY1F1IhzR
   5Hg5648mJzLP9NP6SmBTe/FLlcyZ0nFM5rwjSnM59+kZ09UWphh8O25EF
   hzN+6YDqThkHrbYEm1XXBaXfIAk87xVI2PR/tfU+uqbdXKDGYEp+J+tsS
   OXaQX4hSbE02wDM5Jwky+pjRuUiFhcczS/s7N4ooipx2npLugdQfC+rtC
   mnuF54AqeVX/YPdeum1JMN+2M3SvLcNI32HrDKnLxRkkf3hAy+Sy247UO
   8ybUxZtlvZ7ghm3+JqTxqFpA2RGfSnv4mgJxWK4/wZrUMrX8m5mOPmtrM
   w==;
X-CSE-ConnectionGUID: bGq91MKgRZiLyzQ2BNhZmw==
X-CSE-MsgGUID: CKrrkmnEQfq2hdSoXf28rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10521897"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10521897"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 22:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16472248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 22:22:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 22:22:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 22:22:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 22:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaN/5SQ5BIBnDYkc5cLdxGJl8Wz3cbDGvtX/WFaqQttEQ6oQjx3tttXy5n7YQWKdWbeojCmcxqFktituDXOPQBXebHjz1CEQ0a7gjfrZt2WSd/7w9IUuJgx12U3cyuq3hj0dGzQDZ6DaWZYsF+tzGZrO5GwSkP4rCBOD2MO/63/qGVWOLAe41ab/oSViEUaAbaqa84pu3DCouBYRhOjQQJ3UGQVcE7p2eVWsVcP1fTNc/AFsdNa9rmPnr08w28GO8DuLL1ChtiMhx/Yg6tuZoPbqb3vdeolKJrnBY2zOv/wArPSClMTmnqSRUOsT+z+oz9Aep6fmm+QWCAdB4R6BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBqjahLbnrVGyGJjrmW8DCfufPhkk39WwkZ/ybXWsN8=;
 b=lLYmm+EnXi1lb1rZw91AaPXblwOUTN80ggIx23nFxilZV8CfNK6X9/gr0CGd+GRepgnOZTTCRhB6NNRme71MC8L4t32O64QS3b08UD5tRkSJmQx9eD5dfTAGI8u4f+wJCjKZ9tcIpowsZBZRr45kyUNZg0msY1KI+XnC07GgEEMdeXXZMbVMVVs4YT19KTZiqn/zuS0hCOOcJt7qvTAnhv6wtjR2s/MwLdhttfWOlx108k1nl7viGQZHLJ6MtyrqorQQMQtRmHzKQXOOSGn9w76iYJRZ8u+71Qog8ty6mxJKFZWoXKUpSK0Qy+R1nPSwqe93gC39nL9rPbQ5ZIOLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 05:22:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 05:22:41 +0000
Date: Wed, 27 Mar 2024 22:22:38 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <6604fe9e18eeb_20890294a1@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
 <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
X-ClientProxiedBy: BYAPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:a03:40::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: a51b15e6-73ed-4af0-5eae-08dc4ee7173b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6WNlhNiyj/2KWFyLOfx7rGm2tepjL2mq9+tCwmvSZ7UB7Kq1I1FvLEGVKb2/UiSlXeBYs2Jtb0J+17gmU4IbmVSY3wL2paVVE/3w4XzLOlCq+is3XbqW0EAl+c1oUZRfuL4mxWAQz8cVQRJ53xKDJMfHh8dK2RlXDKnjSTagGXOTgbUNnzsxGtojD//Kz+TSS269Bxj20XCNBCPNRPUNt/r7eUNjCH2zYUkyWKlJuYL/KzSDJcX8QKoX7AEQCoojmgEHlxKWK7dHB4Cjz1xNE7ofKF/hP2UYU6kQDSPmjVYVe/uMJ6/6Wwyt4wUwXpseo8nfy5b/Oj98YKQMNxQ8/WZooKla8jg/+tcKDjCZn46CFh5WLhbNmN97TNvyA7x3wij5MiS7CrYQ1nlB4MC6pVAltvVrg2swvNIMm/LPg3j0c3Q9b7304S3vxG57BH/79Aof1176JvxkZNfvNsTw+/G2tVvugDQW6GJ12wwnxrTYSClI9GoKNwfCbGwKHbFVCvga0XWqcBh6OJ8JibaX42Ch4jCpOYGMD3s3r++MRiLNktcYrL26Tw3mE6Ff35PKOULkQkj4minuNUUfZeH5hsTzAMjJR0aHTn3F5ZBPLmJdyzbzSGr4U6XjaYUj5BVpV5SH6spqDOQR7ZD/5ro++Ab9sCdnBWTYG2bK20UzmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6rkIwwrKKUtbIsf7fIPCUb1jVjG3PhXW/NumIPqjkdM+VDCyBQesPe2tTqi4?=
 =?us-ascii?Q?7fBub6m9V+Dnu7BKsN3vFW7zVev2+q+Vskjja2KMDTHGzQ8QiwUXL3WRvDkH?=
 =?us-ascii?Q?04uWRjVZVj82rg0r66s2n2b7nDa4f3nDP1NqPg69YOyKlXpjCEX1ymiFcEc2?=
 =?us-ascii?Q?d28QVWWI2SQXTW2/gv++eBQQZ7+83/hTecSuAqh+UFdjCL38qCE2sEqIHYli?=
 =?us-ascii?Q?AVPUxMseV/JcFn43BcRxK+jUmLk7ONRZ+gscaRrIpctUKqwNonL7zz8Xss3X?=
 =?us-ascii?Q?BqKoW3c88YIA0cJzTw6JESh0OTEfv13X3aRgWcdMX1ft8clp8NNiRRXJAWLN?=
 =?us-ascii?Q?EgIey1PVl6ude/6cdwugeqTyjaC+VXhwVsEN3wQd/yo1IzNei1SYbF8Ay26a?=
 =?us-ascii?Q?usL3+yYCREdxoFmBdBeSU/xQfwmO+hwUzykSJtyEG9JEjQevpytokC7tqFwL?=
 =?us-ascii?Q?rEgf8k1NLtFwCJaGZf7je42pf5KuAN99XjYDdreLB/5wkCFq8S6yJgsswrlT?=
 =?us-ascii?Q?Ol+6xpLDIyD1OBnqcfGjh5B7r6sTeC9eMDPiyR6xDbqboerUrf/4t5X0jpKK?=
 =?us-ascii?Q?M2SyJt8RL2CQtVK/ggPMmm12Gn8spiyLcCpiyeStQsJM8QJtzd8d9iyj1hZ1?=
 =?us-ascii?Q?JJx0yCkwlyNFXw3aCdsdgG7UszUfYSOL/AIfYiEKizGHgBOe0dQQWDC0+e37?=
 =?us-ascii?Q?GQKJhzL+qdXJZg4m1L/jdiZy6L3baoW/82EA5cf+NT0QqR+vKouM+Ha5bvsU?=
 =?us-ascii?Q?KnU0yJzuHYRGAlv1vW6WFOKyKwREeM1WZawer+rgd38gII7GVPvZwDWDWfuy?=
 =?us-ascii?Q?56p49ejWYhz8O7DSfgE33Yjua7XPM/rXmxMOqgSZjb+6VU0wQirEKBZnW9Gu?=
 =?us-ascii?Q?wB8MBf6auq4CEdZH6mQF2yCibH1bCxi+ZI94wje6rapoWyltyk8V5gg+SI8w?=
 =?us-ascii?Q?YUIy18eBR+TSHNNYRl/0Srdy6LO0w18yQ7Xx5ZJQx+0GNY0nRqe671d7Bs1K?=
 =?us-ascii?Q?NO0/+CNGcSlmboH3bu4x0wyRqA5Uy3pls1owb/5hC0ihhi5MyemGHOByrtrr?=
 =?us-ascii?Q?X+ur0vFo0KOzqgE3J34yrA5fWzWKYCRIlaQx3QHEh4yoHGI5qWaiDnRFxBfS?=
 =?us-ascii?Q?PWWD8BgQqolpQZXMx0jq9Ag2YXnZFv8TKtxdv3V9N+Zio0YVEruQyhz7YaGK?=
 =?us-ascii?Q?RKgPP2NXFZ3bW0RedpSZ9fhkuRN+N88531hmuPdKs63ff6IJ3aJ6k2xno90d?=
 =?us-ascii?Q?N9FFUB7slpyKSIC8mCi4fWRkPDj78ci6JcDLFNSuD1RACshjJHE3wp6Qy/Kz?=
 =?us-ascii?Q?6sCrtoSOQECY9G2s2FHyWDr1zz7+0xzxE+/PXhGNBspH1UGAG7uhB3n9Ui4o?=
 =?us-ascii?Q?JYqxJoD3oTkiY2FMMLMqlWmMJrLa/4b86xR9uE10PeJymxVM6WE2V2tNWGQw?=
 =?us-ascii?Q?6YH9+ndq3P+N+RPHgNiUtZ9LIKADdHo8wkZQowEDn+rS937SUjb+XCMfOsGU?=
 =?us-ascii?Q?0XNKvAXOC6ZNK00vh0IOj9Z0g1jd25WpoLbwzFfqiQSvG7PTbSYeTW5YU11+?=
 =?us-ascii?Q?UlgWEDEeq3dFrcojbQ+4sjVT1EHPb8yo+Z7B+16l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a51b15e6-73ed-4af0-5eae-08dc4ee7173b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 05:22:41.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ckJYQrCjIdIa9qluFgRmXcp5ez9CSX8Hm9Z37HumUTRmrk5hOcENhvJCC9Iy77v351p8yzUHhzNEiThvglTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
> 
> >From: Navneet Singh <navneet.singh@intel.com>
> >
> >Until now region modes and decoder modes were equivalent in that they
> >were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
> >regions (which will represent an array of device regions [better named
> >partitions] the index of which could be different on different
> >interleaved devices), the mode of an endpoint decoder and a region will
> >no longer be equivalent.
> >
> >Define a new region mode enumeration and adjust the code for it.
> 
> Could this could also be picked up regardless of dcd?

It could but there is no need for it without DCD.

I will work on re-ordering the cleanups if Dave will agree to take them
early.

Ira

