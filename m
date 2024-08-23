Return-Path: <linux-btrfs+bounces-7423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFD95C33B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 04:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA18A1F23D6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F227713;
	Fri, 23 Aug 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4J/DrgX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185731CD31;
	Fri, 23 Aug 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380133; cv=fail; b=k1IXmZkQxeyG5C39+aaraVxeukfs+uaNTabSrsv1TlZGwETUUq2pJe2wMcgP1KO0xGLB5oA0vf2QaRycng6am/oTIcUMuMFEPGBwbMvKwIewxm/2dl1heSl9pNpQzfh/j/X3T6I2Sf3P2zAME2vItMbViYulvkbtbF60EJ+HFKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380133; c=relaxed/simple;
	bh=8SWTZInMmyKkmBuNA2rtvxA9dwdal1NbT803HXa2COA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YXRg7EzbjCLnyT23hzuQs80hje8iRsqPtre9rgmcb9Rn6Jzu0wE7GbXeYHzpjqbmwf/l8i1pQNbbquIqheo+6dRnPZbLrJG6TzG5OwY1sJu031M2bcoNXODgdK1V2JLNtKhcWwWWj85L1sMi/udRe9zVG1NKhIZlLzxlneEoGbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4J/DrgX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724380131; x=1755916131;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8SWTZInMmyKkmBuNA2rtvxA9dwdal1NbT803HXa2COA=;
  b=F4J/DrgX4gdv5ffg27cmJ8G3wjiskiH4PT9vCMSxar6hGnZ1mRo12Vp8
   n2fo1hpqoBbxfMY7Nytk8T2WMBrNfBX0qS/dqy3pSJnxUVJLDl7xr7oMO
   XHPqXUeGt4yMHTijXkvhzxOY8GVE6Zh/qOgUsbhbo2prgoLmjuqaN5AjJ
   d3hCByR9WsmydtVfqiCrz2Idrt3u8taAxgOJ++6GOFNgIDJs7gXXn4pFL
   AIZBDq9LyAlo+UadW+WLNNQw50hTRm1YnceOgwkGUyxPRRB4dWbpXmCMF
   MA1brX/0GGE60+GP6LWevu+UqYzx+q2/5e4oUtGg/icq3iBZeZhwIkKdL
   w==;
X-CSE-ConnectionGUID: i1Fa5rI1SlmbZwSR336PZg==
X-CSE-MsgGUID: PVmlh9MYS/uV507XccKlpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22999062"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22999062"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:28:50 -0700
X-CSE-ConnectionGUID: aRv/CIdYTxGvWf0wsaydQg==
X-CSE-MsgGUID: d+xEzIM0ShWxMj7w2bvijg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61635233"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 19:28:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:28:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:28:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 19:28:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 19:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCwvlLz0OKp3AEIpRNeEwQsWd1jUs6MZnY5tOXuYdVAKwA8Ez9YWqbkWP4HtKNr/Rq75P9ZayMYYpJMrzCOyyfF4XjrwLfcP0JaG6Kx5XgAD9mFiwHkLPf4T8kQFyScAdomQzjJDfnrxYmidsc1AddZ0UYDcFHgHzj5WeTyET6/VKqW+PHhSAb+UuFXPGGauoWYOXpC0yMaP65L8qYZgYVqsYKumd6boirFfmZBdchVmdoA+/++ge3PcDNzlaLuoxX+cN7zrDpKoI1cvD+I4uKQrqk5Mj6uE2mKuTyP16fSVdxRBur5qIj4nMCteIfxwTxsj953nxsU+2acyxYmRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxdhh1OzdT4Pf0HiMOkLVhRW4Q33MdwMVxgJ3a7Ekzg=;
 b=ySo3neOlzJRumql1LMBr+ddhVpc5suc4UXWrYrj2FkYlqhYBbPqEuVePXtTgui8HVDg0IjzqPo18hQOuSkAQidx1rA9tbPCY6Frwc3jKoLbF3besN9ZbsAaoKSBwELWublArFXHBlfQcGlr6BN1xCYlNXf0PXNWD1OH2PHglt44dLTl39u3W2pZpPhtl65KI7Pc2yHe6sIdU0BeQWrd+t5gSQdBCACseuTfdmmkC9+pYfL5E9R4Jo9lQYivBSutwk/bbRiyK2jbxTUj3oDdB1PDxpCEVqbWz4ObBysfdZvXOyvjVnTvy9QgATZ41cYXqkaiiOg4jhFWlzMoDZkSbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8524.namprd11.prod.outlook.com (2603:10b6:806:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 02:28:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:28:47 +0000
Date: Thu, 22 Aug 2024 21:28:41 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, "Josef Bacik"
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 11/25] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <66c7f3d977851_1719d29424@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-11-7c9b96cba6d7@intel.com>
 <8649e30c-a43a-4096-a32f-e31bf3e71d90@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8649e30c-a43a-4096-a32f-e31bf3e71d90@intel.com>
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: d76ba340-f2f0-45b0-80d8-08dcc31b512e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QP2TNqpwLQp390rtpKwwPfTCsed1V58kHZPhwmEEcDw5LuucCISDluXymILy?=
 =?us-ascii?Q?NRvPuHrRP1FBTXO/0Wf2F9b5wimkVkSi7bu/kY+yYAtc2yJzb4JggrQ7UF8P?=
 =?us-ascii?Q?uARIsWYc+pclrDi7Jo6/RTLexLYWPmWbJhG4uXRB2amBXRSN6vpXShGSNPFt?=
 =?us-ascii?Q?3TGrpKjsuchR8Lmzf9WUijeujZ5fOyXnP1VYzCs7APzZdJTRGjp75XaW7dQN?=
 =?us-ascii?Q?Lk9f1emCrMN593kM0BQqmI12myotGlZSEbH5s76Yyz0kU+EueVfnYjmMxNXJ?=
 =?us-ascii?Q?FufpoH+FKb1gX9ANw3brHdg/3oengnZZsZAzeNlPvO0TG2tPOMk7vF0M7diy?=
 =?us-ascii?Q?PmDWNjjlo2FW+YiOHS9XATwLMObfxbsmFOTHtYE8aw8JN3SxSYcolqIWITzX?=
 =?us-ascii?Q?/xfklXkUb98b3pYHSr3yl1FmaPdiLizIEFQLPs0CoRgrKyca5SPtNOU9fRhr?=
 =?us-ascii?Q?29s8xGVzOOQP2Mu6Yil6KNUZO7REuPBQv+yxSIzHHpu3H9V3r6NHccrYvQ4P?=
 =?us-ascii?Q?ql4lS/NQSS3o5vOuyqqSbGZtAQuPDX2QpV8IGECSP0r4NPJU7uHUf7yLhEfl?=
 =?us-ascii?Q?4i2nVjIDdlBzZDY312x3GYHNJHedZr6Gs/Vcd8/NPqOc7OGzXxArUL6AtGAo?=
 =?us-ascii?Q?xBYiE4unW13ZxQm9qO8s9eeJKWNkqlDqClTPaW5bzeVjAo6pQd8pw2A+bErL?=
 =?us-ascii?Q?GbSsQgDLDDfycXEwjrHVWt06BEYq3qzCjYg5PvDZqGNaCZAf+li+QfeyPFuK?=
 =?us-ascii?Q?YTQzs/e2mqu7NTTto8DXfNhu4CVRgDzkd27FViWT0vDv/nPcbTbCAW5/J6Ve?=
 =?us-ascii?Q?YVukmMIKNkMoZCE8igkqdiqbdI3sCnLxwWX7pYdEww7lvMhy5Ua2UaHC8Fbe?=
 =?us-ascii?Q?JaUM/7ffBaRJ66BZ0SoXAwkShTvSfWXIRCRRWOtxozyC/m8mpTm2jePqw6WP?=
 =?us-ascii?Q?DaakYg8B80l+5kbke/waSRimCuBHAWZdvdhX9pDv2N8y4ndbmGQuse4yfUwi?=
 =?us-ascii?Q?niUEhEW/wZRsQJwsVCW9cI9W6vuZ4sUo33NpYTEyjdrO+ncSQQ/YlRz7fZ4q?=
 =?us-ascii?Q?pfJDxAMZcEUxWte8P76h5FZ3ucPiAJU47X13cS4Sa2SktLC9xxO9pc1lBRcs?=
 =?us-ascii?Q?iFkS5buQdyuciiLqft5cAKmJ5CWKQijffTBGZL6qZCud2NRnLBNiWNTJClXQ?=
 =?us-ascii?Q?WrHhYs/Q9PPgolvLEqa8t/Q7r8n3jXlf3iMnOAIov281AO4BXzCldNkLRNv3?=
 =?us-ascii?Q?MDBVoxPotgGLuNXDCwnH8K43SqPnxiYZw3WAK3uowMA7Kh8pxZSpciyFDl1e?=
 =?us-ascii?Q?zTFR02Lf7elKwKWKHw0Ouo/wTRAiVk+d8xtVp6GAQLRUDzBqlF6381ReJc58?=
 =?us-ascii?Q?xhh7GCF16WErggqBvmSNM6MvbB8E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lwDJUUoHoWeBLwpmq+JzhV6eB2yFpcwqXWFEkl7+EFahZ2SslChmuK8lBmob?=
 =?us-ascii?Q?t03l+wqr15RItujeJtaGltb5slEsZrmAwXQ2hegCmQx++bewYbMyDaVlpxnY?=
 =?us-ascii?Q?bhXwCdiPzjkf4HhHYhhoAoGNA7+oKC/IMN4faefN3HdkT3/eZCiyyg4ziToQ?=
 =?us-ascii?Q?cqmUjjn6fhYrqPjgGRNHWzB/lqMQ/DIdklHiOU+O7rqRIHLlXVYfv+djPzGo?=
 =?us-ascii?Q?1LGwR/RcekLLmJlpVCdtDej16Z1uQCbTzen0ovD29dn3B4PLn2UK4TVfq2l1?=
 =?us-ascii?Q?H9j5x3Cnm5ZsqA7tU8f8t7nhQhkojzqpQfSmwndB1eFlxCMJH7amjTYvREGW?=
 =?us-ascii?Q?odRuSDdtqTTmljyubn9BidgqSslN9tSu9les6PwriMrAVWO1c8tD8FbecjTc?=
 =?us-ascii?Q?F11IZJfPEVpnO1vJmwQoIPXfwkrjtr0uook2Z2w7ojbDpMmJdMNTvJBnFOX+?=
 =?us-ascii?Q?4RBPRD2JFjRNQjMnyHwadIFboB9zFk0/Ln/4cNsECSWwM0766ryQTsixsGoB?=
 =?us-ascii?Q?jbU6F7N4NOI+p2iKDnZR2m8qcixXZFkSsAtbya419euZg+tAAk0EaLGsolx8?=
 =?us-ascii?Q?pkxKPjjIy4BYxnRoeI8C5ARrDtO8dbBHajwOdlZeSi1m+N9vqs8gtf9lukq6?=
 =?us-ascii?Q?NFNLJrgDLpfHe85/CVIrYRVxJpVzKEUnLnUmwULdBj4Q8MaP1IR7mz4k2u/m?=
 =?us-ascii?Q?5VFkhHu55nXqxWJovRSvo7dkpGFVw56OnvqQWQjzU5OkGcDEsjfzQtCVV5M2?=
 =?us-ascii?Q?pHTiddpllJW3peRCn0SZVU8+dQjaF9ATLHXxov+SVnSTvxFmjAQg+Gwmt3Mt?=
 =?us-ascii?Q?xGbHmOEPedDMvnubYrCtHybndimgOdrXIx6aZ0NdmkJ9AvUt0RmOPlU8zoZh?=
 =?us-ascii?Q?dmoHoyUWa2DzC0MWiB0LR5aZkCocnYAwp6S25IF31bpVOtkjgRXSpWeZj5xe?=
 =?us-ascii?Q?5lPmT+W9Bb4pEl7zcck+1Mr8wVxXlNYq5cWtX/uhgkR44U0srf7NvmXCPOl3?=
 =?us-ascii?Q?gylzVeQo1TKLzdnC9o6/ddj2jrBZo76Dm//4UJX8KEMw4AVzntzYeah6clf8?=
 =?us-ascii?Q?SotUzJmgiFgcXsJQ0gQs8EsEPeypNKTu6tLcJ+cjxZLXmZXQKVuyAI6k8Q2D?=
 =?us-ascii?Q?2Kwv92IpbapGWLekr3bllhbgQaOcIyytuWCMJWBHa/OnUv4WBOTJIHOEee7b?=
 =?us-ascii?Q?806HXK0kvJZpdZR733dWFjBaMkppBu7R4XWqlSrMWeSjchkB9gziK7B2jp9/?=
 =?us-ascii?Q?H4eIgTZnKSS7GabL/8q/znWoHOCXsRmUMy2L2Yz7zSNBBswkbccznwA6cQk/?=
 =?us-ascii?Q?amdvahhoF1De3FZsHnhrbDI7Fx266serGNRW2Y6pDetxUEL5sSQJrPQycBq4?=
 =?us-ascii?Q?lidHHueG+r8Ht7vWQ5XZKRjMdb1WAzDhalpSfCxg7+wqYb03kWDU9ol7LedF?=
 =?us-ascii?Q?My8lW7OAz16DzVzv8OlCEyDhNTpm9Kn+E5w8oCAEJhymdBV8Leg/tRQpW58S?=
 =?us-ascii?Q?eb1MorhIsXio+sjjbJiKNZ0ZKQO0DcdIUrWMdksrgXhAJ1DIHdUdyQRVvGj8?=
 =?us-ascii?Q?KHLjLF/QYzBmnAP5QtMkbg6w5QJAjKN70X1oThoG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d76ba340-f2f0-45b0-80d8-08dcc31b512e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:28:47.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sNntV8OlZXpz+YIpF5kyPoXAeJHH83nBIRnxiKC3S/SI6vuALwJMBivIc9gXpe+Y+bGFNpe/HFadB3DWARm9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8524
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> > user space will need to know the details of the DC partitions available.
> > 
> > Expose dynamic capacity capabilities through sysfs.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes:
> > [iweiny: remove review tags]
> > [Davidlohr/Fan/Jonathan: omit 'dc' attribute directory if device is not DC]
> > [Jonathan: update documentation for dc visibility]
> > [Jonathan: Add a comment to DC region X attributes to ensure visibility checks work]
> > [iweiny: push sysfs version to 6.12]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 12 ++++
> >  drivers/cxl/core/memdev.c               | 97 +++++++++++++++++++++++++++++++++
> >  2 files changed, 109 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 957717264709..6227ae0ab3fc 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -54,6 +54,18 @@ Description:
> >  		identically named field in the Identify Memory Device Output
> >  		Payload in the CXL-2.0 specification.
> >  
> > +What:		/sys/bus/cxl/devices/memX/dc/region_count
> > +		/sys/bus/cxl/devices/memX/dc/regionY_size
> 
> Just make it into 2 separate entries?

Do you mean in the docs?

Ira

> 
> DJ
> > +Date:		August, 2024
> > +KernelVersion:	v6.12
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Dynamic Capacity (DC) region information.  The dc
> > +		directory is only visible on devices which support Dynamic
> > +		Capacity.
> > +		The region_count is the number of Dynamic Capacity (DC)
> > +		partitions (regions) supported on the device.
> > +		regionY_size is the size of each of those partitions.
> >  
> >  What:		/sys/bus/cxl/devices/memX/pmem/qos_class
> >  Date:		May, 2023

[snip]

