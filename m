Return-Path: <linux-btrfs+bounces-4783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DD58BD4A8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46431C21837
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62A1591E2;
	Mon,  6 May 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iO2zWQLo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA1158A07;
	Mon,  6 May 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020477; cv=fail; b=FJz9N7QPOtHLTKSD4FFYqUehWjE3z0bualvFykThHNc0twS4RU7HXzzT1Zo3gMIvIL7kBKRORjfVePhe6cZkJ8n7wYASm2tFy0E69KlyHC1CvXBbrR1Q5djpjz0+khzhiF5AvyY8ntMLFdb56gAawibJQoU2tsfZihIwxe7oNXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020477; c=relaxed/simple;
	bh=VGRLYFOi76KNXqz5/6Qhrm5A2FsXZeOe6XOxkCTF/e0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NVDmNmlSk8Lk29d08PiS6pD7nvXIDh4pyRO4dPt5lqiHDW+XorvhhmgrlT7HgLfB5+ACnIF0na96vVQ6xMdIViLSx4T4+iNzRxzuMObt2jp+YKTa2w740pyq+T9Th4Slbq1Tq0lC0P6ABzvxnTdgv/b7EGjIE0GtobLUCAeO98E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iO2zWQLo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715020475; x=1746556475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VGRLYFOi76KNXqz5/6Qhrm5A2FsXZeOe6XOxkCTF/e0=;
  b=iO2zWQLoQNnIuj837QJ3VyVV8Gmj41y85EyIeJpR0QbACssOUTXT7mMY
   zwiRKLxelWbBB5n9Dvck2M/ddiD7YJWSw3qab0ZDJ7X6Mzc/xElW9ZUeU
   9+mezCZeWx7m0oLefFrufxXDUumr7bwuomDwzFhFW7+M4zh1RjFEBOPYm
   XAg/axqEstZDEcCL1jOyi92/M9f1PBlXSEiQVomXzjiY6m0yxg1CwSsPO
   iaJebFFkzM8tVX6wk8CiiWZkbJB6KLbV2vL4jxTgEMzxxbYL3Pt703cgq
   rVekb5ycrzKGT4xGLp3jnpYYb24EDR4IxEV5U6aeR07sWVi9ByUy5bOIh
   g==;
X-CSE-ConnectionGUID: IDFNEP4CSzu7CX5VP4vSDg==
X-CSE-MsgGUID: 167W5E/gRea9i1K1j6WbnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11320649"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="11320649"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 11:34:35 -0700
X-CSE-ConnectionGUID: LVvW/HdJSkO8Kiu5s1nWNw==
X-CSE-MsgGUID: tEF/XvW+Ree5HlAItv9Clw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28336821"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 11:34:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 11:34:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 11:34:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 11:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+oVj1zLnkOJ23IPKCLIi5yR4vLQdeQ0A8icwzpKKyJA6ct9C+5Ai0EfdOmNHU3IEWZfKZj6hgXPDeEzEbOi1oqanlzUikEjSYT6/gPmuUUDm6TSrBeV9SMLZQ7NgdXkFbVC2/HpoLUBkwB1yGFoqn3Blvo8yMI+hEiGDJJktoyqlk+01F7yaU8ubqwaqEbtF4SD8RW7yYjY3g7k373FcTiw/6DfUMzYPClJkLNvva6sB4BzPecDHPgec1iiTKCxfrmBoGUfLCNkNLa9IOMUqqJKzozHCZER89fopDyB+5b4I2aLP+glOpCbUHNF7TVvMGmIPiC3LDE0EAu+zeOzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDKdo4BekJxUN5UTcearkA+4+8vNKkkdVamDsorQxqo=;
 b=bxhfuarra9j7+PWogBgzxg36FnxED+dSiYGxkWSSJvtXw92u2bd6+sA934AXVUglTqFvya6WbPo+OA6ZwGzk9ffJJSocHQrRym+rwpasP+q+jQEnHiEwvS0UQ3eA8UR6RgVIYD/9PAwPfLOMzEqmP0B2SIBdzgisTy5YnC46PWGnd2OHczEXoCqygwgPhP6ShSV+vtVmqG7vM2azmRd+JpFBwtW9H5zJzR71ZqGHOcHPIQWOBIfrO85asMxEcqkm/HTZ1uIlvHhWLIH8vUg1rs2QrGY++BOJSeLkVbiJADFTGOngd8qI3KLRC2AfKOrx3MyAZJ85qmY1gbptEKs3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:34:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 18:34:31 +0000
Date: Mon, 6 May 2024 11:34:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9b4476-578f-4c2b-5f1b-08dc6dfb2b2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fO3qThsyNMaL96R5vdIFt4mj4W/vUrqQqDhaccsAfHuHV8l5mQXEoXEuYwXC?=
 =?us-ascii?Q?H0StGTcAPYnBv4Io2U4VJdJgZii0aiJRPwNH4segFrw4r3/e1EWe1kgFNQnm?=
 =?us-ascii?Q?9DSuVJYggYt9ehsiX63xqfypRsMiItm2BnQ5vNgu4YREp544Wf0H9XNg7eTp?=
 =?us-ascii?Q?pmA54Y7Qobl8R5HwJnMCkX9qoslTldm6tJKWGwMNgoj0PzUKkw+kpNrB2BvR?=
 =?us-ascii?Q?ojF/Mnlq5tESup+oNqG1YO+v03oCdoyOO43oJ6UkWDGPfmPoCPv0Fn1f6UfW?=
 =?us-ascii?Q?GJWEnFIecUZL8b5689KWHMv/JS+6VLNvkdI+H/n9Y4Sanel9CiVEXJpO+Bb6?=
 =?us-ascii?Q?QMFVvFBsY9MYfUvEMqfarOYVOvA8EwBOJo8tvaBEgp1bafE60xNT8W94t/v5?=
 =?us-ascii?Q?KaQnmij7kj5iv69zDAYnGQbY1o4gyBF8feRMNl9rbe3lEORMYuWiFPpv3SRE?=
 =?us-ascii?Q?FgKhPYPco3QFJKZ8PCENPs7u1/TZVEGbOynt3SL3Xn9cyL2BnRUm/dj0c2gP?=
 =?us-ascii?Q?okj7rQv/DdpPsUoduPDT9neq8cUbmTFuE7UR4QpcsWoqS+Fa6Iqesn+NrCyQ?=
 =?us-ascii?Q?109xk9SyvehWgtO+lss6WtNULnboktZNZc4eFKH09U6Sz6aq8TglwWrkoACX?=
 =?us-ascii?Q?3GglWGvFE7RuymOgn5cyQIwadYjFGNUSt1bDnv1PRBesvxk/PlynYvWl/3GG?=
 =?us-ascii?Q?A6wCHd9XNV8Y7cL52921sEz1jDy8mjfRWIgzLcQ66NtDz6aFUe4vFtJA8/3p?=
 =?us-ascii?Q?Bj+X0OW7QoJnntspENIlsJhlrqCcoUjuB4wVXC2mSYn5TtHNGp3x8mQQWSu7?=
 =?us-ascii?Q?ua763kIroeoxwWuIBEF00W/Xzz6fAujhN6kC0RfnaLIwt58Ppk8RW9h/qsdF?=
 =?us-ascii?Q?sfOdN5mIpePPGFG/C6DqjUSczlL0r7bYSoxn5ycNnIDudaFV/T2hzD0Hcmc6?=
 =?us-ascii?Q?VfURPTcphoKg+PduL/Mllo6oq7ji8nqGZ+lOX56dcKohTaXn0r+bJnljU+cY?=
 =?us-ascii?Q?p+PwUhrokslm0qBaEjgy/Hv6dXBlt6ZVlqO3XXBUwRuEa/Tl8UDxuA+bp9Yk?=
 =?us-ascii?Q?kiqw5m7+dzAa0pnY0E3CpfB5IvC5lDqQVdhHM1z9RL9/Ae3klt7wDC8iuYxk?=
 =?us-ascii?Q?MSiHmPPILCWbY4LxWqq6ztkQNOue3s610NDsduogvzK7XhKayTgfZN2MgJZP?=
 =?us-ascii?Q?sRAp5ouPS7L4yuKBbtFzcPUhhFq5+gm3HTBtL6WYtQUmKqL/JwFI1nRNeq2V?=
 =?us-ascii?Q?YPdmhTuQipO5pSUSfYH6nEfNM4Ov5bmfrXRYbh0DZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+O+h01qyl/4cadkxuLn2njcJRTlwZY9mv3UpD84PPTbDoWeISPsxcYwQbCWn?=
 =?us-ascii?Q?Y5nBHEKz7vkSSlYTqNkCx4EBckbjmiItCv0cKV5jb7kK0tZQxJCk7RknnsX5?=
 =?us-ascii?Q?PtA6g9xJSw6n1U7CvdSR6lviM4NndvTHU871VMasaxLLE/jgAl4vzGu46Xwp?=
 =?us-ascii?Q?cwvWmAtkLKEyhimPU0G4gPadFfCUnL+mKZsSYzgDUVVxFBEgY7/20jtStzVb?=
 =?us-ascii?Q?2S/v+4ANisG/d4Vx0tWLiuaFwM2OSIyUGre6M4uYcv5t+I8Im9QG3PJUqnMl?=
 =?us-ascii?Q?GNy+ofyQdB1GCzqGz/KOixSUer6hGS7hcbiHVBRYibu9JQpZBZ1hPadRJqAv?=
 =?us-ascii?Q?A2W+qrZ2eqIVYOWCTgFXud4taxNPrZjrzS/GkGbq8ujqOC2JVD2hzBVkI3M+?=
 =?us-ascii?Q?aCh1+zA9O7sPQ3mWh5yRbEBoddcqhWO1TSoVtnB0yd0F4CsoPFBnCD0Zg5PL?=
 =?us-ascii?Q?EjT98AvobKo7a9TTA4z4Na9BXhG2qQrJqYoLhR3Fzl2JsS8DZvlcz6yqhor4?=
 =?us-ascii?Q?LHlZfpfhFCSrFH10z0dU1q8w3z/SiAupSOWd0/53Rseyqxi8UdH3tNIQqqiK?=
 =?us-ascii?Q?wAIQYXDetVlVFc/KBvdAhkhOkHOIdUVEJ034jAxF3xWLqRq7DaVwiIT73HlT?=
 =?us-ascii?Q?GhqI02qbxyypHCIjBSI5uLbtf3DUNAfhfNdM3nJE9dThgnjIRwydudYV09zk?=
 =?us-ascii?Q?FRw1IdTvAh25qbmvjprgfJr4fw/kuXWvJxrPB6wtv3dcHV41s/z65s+YRpq6?=
 =?us-ascii?Q?ONegnh30iR6dDBQh0EM4RxJ6/cJPaMOY/ZK+fK6spN2ORLJTYl5StqjA584c?=
 =?us-ascii?Q?aoSqZWDTH5hpHGfLxGpS8KADFzojtIjhgugLEkIeLF1Mn9i1n4rsb4YBZgbU?=
 =?us-ascii?Q?891vwc4QGqwgJnO6z6TmX+Auui+7TggbxyCjuN0xUn1DvLiG0Ozk+uIK6qaE?=
 =?us-ascii?Q?r/GEoE4++O0IknSRvwdS1ZoG93A8AIjE4zhfsRGyvKzvY43EOjjovRsKiKFr?=
 =?us-ascii?Q?tg1vyARjJ4i/Jjvf1hecvrLJ+QB2WB7KHmHBSp6fO3plrmHaJwf721H2q9nl?=
 =?us-ascii?Q?hMaISDYWVJhKJPzG9VsC1jbBIfu32Oat8qrfoQHZSCK0YFOilIp/8DRkA9Jn?=
 =?us-ascii?Q?1vp6Ak4y6RT+7gBXCtMu7cXcX/elr8d9E4HRfwNvBTHMrJFToiC+EcTEk0qJ?=
 =?us-ascii?Q?d0myIo2KhFlA4zieVXIgHXHIMVu1SJsmxNcfg+YuC1/4lsVfzHZ7SLK96vW4?=
 =?us-ascii?Q?0/gHhevIpS9oyMOgoV12Z0vya/OOXhx2/z/lAa5AU0gwvJkArbxOPs+WOx7h?=
 =?us-ascii?Q?inWA3wOq1KNS4enhhtkFGQ7yw4l/S2s9gaAKxR2Q9i+nIt6jPfErzJWkjf2+?=
 =?us-ascii?Q?/O9yYJSKMAVIp0EcjEIjUr+gaWT7rSFILPBJQ9hey5uSWz6ubmD2G6EzOJtb?=
 =?us-ascii?Q?eNAuCbwV8e6u7+sAUM88dtzL3xpwvu6FpAcieMuVAsoaV8HPr7catFrR/DhZ?=
 =?us-ascii?Q?tmS4Ya6zgGmCR9ulflnOo080d0hYUgn7OBTD8P4+CZRMlhVVdS0YOcVE1rIw?=
 =?us-ascii?Q?lY1TPsj4Alphu0ck5m5xBKL+zmADuLNgZatcQNHCgi1fN7RdCwCoC72WnapF?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9b4476-578f-4c2b-5f1b-08dc6dfb2b2e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:34:31.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnFZOZnfach7img+hpdRewGxKAr9F6U8NzgZZ/rVJXkf0UYTQTfkmHi+BIdvA8Gf80lyeXk/iuB9xzBfAmhq81F9fII6/TgWKf+8e2QXY4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com

ira.weiny@ wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic capacity device extents may be left in an accepted state on a
> device due to an unexpected host crash.  In this case creation of a new
> region on top of the DC partition (region) is expected to expose those
> extents for continued use.
> 
> Once all endpoint decoders are part of a region and the region is being
> realized read the device extent list.  For ease of review, this patch
> stops after reading the extent list and leaves realization of the region
> extents to a future patch.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1:
> [iweiny: remove extent list xarray]
> [iweiny: Update spec references to 3.1]
> [iweiny: use struct range in extents]
> [iweiny: remove all reference tracking and let regions track extents
> 	 through the extent devices.]
> [djbw/Jonathan/Fan: move extent tracking to endpoint decoders]
> ---
>  drivers/cxl/core/core.h   |   9 +++
>  drivers/cxl/core/mbox.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c |  29 +++++++
>  drivers/cxl/cxlmem.h      |  49 ++++++++++++
>  4 files changed, 279 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 91abeffbe985..119b12362977 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -4,6 +4,8 @@
>  #ifndef __CXL_CORE_H__
>  #define __CXL_CORE_H__
>  
> +#include <cxlmem.h>
> +
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
>  extern const struct device_type cxl_pmu_type;
> @@ -28,6 +30,8 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
>  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> +int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> +			  struct cxl_dc_extent *dc_extent);

There are already functions called "cxled_", so lets not invent the
"cxl_ed_" prefix.

[..]
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 58b31fa47b93..9e33a0976828 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -870,6 +870,53 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> +			       struct cxl_dc_extent *dc_extent)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	uint64_t start, len;
> +
> +	start = le64_to_cpu(dc_extent->start_dpa);
> +	len = le64_to_cpu(dc_extent->length);
> +
> +	/* Extents must not cross region boundary's */
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		if (dcr->base <= start &&
> +		    (start + len) <= (dcr->base + dcr->decode_len)) {
> +			dev_dbg(dev, "DC extent DPA %#llx - %#llx (DCR:%d:%#llx)\n",
> +				start, start + len - 1, i, start - dcr->base);
> +			return 0;
> +		}
> +	}
> +
> +	dev_err_ratelimited(dev,
> +			    "DC extent DPA %#llx - %#llx is not in any DC region\n",
> +			    start, start + len - 1);

If the goal is give the admin an answer to the question "hey what
happened to the capacity I was expecting?", then this should include the
tag. Also, this is a warning, not an error, right? I.e. the driver
continues with the validated extents.

> +	return -EINVAL;

This value is not returned up the stack, however, I expect EINVAL on
user input errors. For misaligned device-internal addressing, ENXIO is
more appropriate.

> +}
> +
> +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> +				struct cxl_dc_extent *extent)

How about cxled_contains_extent()?

There's no other "extents" besides "dc_extents" in the driver, and once
a symbol name goes over 2 underscores it starts to be too many tokens.

> +{
> +	uint64_t start = le64_to_cpu(extent->start_dpa);
> +	uint64_t length = le64_to_cpu(extent->length);
> +	struct range ext_range = (struct range){
> +		.start = start,
> +		.end = start + length - 1,
> +	};
> +	struct range ed_range = (struct range) {
> +		.start = cxled->dpa_res->start,
> +		.end = cxled->dpa_res->end,
> +	};
> +
> +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent DPA:%#llx LEN:%#llx\n",
> +		cxled->dpa_res, start, length);

ED is not a standalone abbreviation anywhere else, it's either "cxled" or
"endpoint decoder". I am open to renames, but not mixed names.

For this one the decoder name is already in the printout, so no real
need to redundantly mention "ED".

Lastly, I think continued use of 'struct range' is begging for a new
enlightened format specifier. I am thinking "%par" since these things
are usually some kind of physical address, and I do not see an easy way
to extend the existing "%pr/%pR" to accommodate ranges.

> +
> +	return range_contains(&ed_range, &ext_range);
> +}
> +
>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -973,6 +1020,15 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static struct cxl_memdev_state *
> +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> +}

Looks good, makes me wonder if a cxled_to_devstate() would be a net positive
reduction in code. I think most of the current cxled_to_memdev(), just
do cxlmd->cxlds with the result.

>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -1406,6 +1462,142 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
>  
> +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +				     unsigned int *extent_gen_num)

I know the spec has this behavior where asking for zero extents returns
the total pending, but that does not really justify having this extra
step before retrieving extents.

> +{
> +	struct cxl_mbox_get_dc_extent_in get_dc_extent;
> +	struct cxl_mbox_get_dc_extent_out dc_extents;

The more I look at these patches the more I think a s/dc_extent/extent/
change is warranted to cut down on the visual token parsing reading this
code.

> +	struct cxl_mbox_cmd mbox_cmd;
> +	unsigned int count;
> +	int rc;
> +
> +	get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> +		.extent_cnt = cpu_to_le32(0),
> +		.start_extent_index = cpu_to_le32(0),
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +		.payload_in = &get_dc_extent,
> +		.size_in = sizeof(get_dc_extent),
> +		.size_out = sizeof(dc_extents),
> +		.payload_out = &dc_extents,
> +		.min_out = 1,
> +	};
> +
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	count = le32_to_cpu(dc_extents.total_extent_cnt);
> +	*extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);

Setting aside that this function likely serves no incremental purpose,
why is the number of extents stored in a variable called "gen_num"?

> +
> +	return count;
> +}
> +
> +static int cxl_dev_get_dc_extents(struct cxl_endpoint_decoder *cxled,
> +				  unsigned int start_gen_num,
> +				  unsigned int exp_cnt)
> +{
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	unsigned int start_index, total_read;
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	struct cxl_mbox_get_dc_extent_out *dc_extents __free(kfree) =
> +				kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!dc_extents)
> +		return -ENOMEM;
> +
> +	total_read = 0;
> +	start_index = 0;
> +	do {
> +		unsigned int nr_ext, total_extent_cnt, gen_num;
> +		struct cxl_mbox_get_dc_extent_in get_dc_extent;
> +		int rc;
> +
> +		get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> +			.extent_cnt = cpu_to_le32(exp_cnt - start_index),

Shouldn't this be something like:

			.extent_cnt = cpu_to_le32(start_index ? remaining : 1),

...where @remaining is initialized at the end of the first iteration?

> +			.start_extent_index = cpu_to_le32(start_index),
> +		};
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +			.payload_in = &get_dc_extent,
> +			.size_in = sizeof(get_dc_extent),
> +			.size_out = mds->payload_size,
> +			.payload_out = dc_extents,
> +			.min_out = 1,
> +		};
> +
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;
> +
> +		nr_ext = le32_to_cpu(dc_extents->ret_extent_cnt);

It occurs to me that usage of "nr_" outnumbers "_cnt" in the driver, lets
stick to the predominate style and just use "nr_" for symbol names that
represent counts and just call this nr_returned, or similar.

> +		total_read += nr_ext;
> +		total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> +		gen_num = le32_to_cpu(dc_extents->extent_list_num);
> +
> +		dev_dbg(dev, "Get extent list count:%d generation Num:%d\n",
> +			total_extent_cnt, gen_num);
> +
> +		if (gen_num != start_gen_num || exp_cnt != total_extent_cnt) {
> +			dev_err(dev, "Possible incomplete extent list; gen %u != %u : cnt %u != %u\n",
> +				gen_num, start_gen_num, exp_cnt, total_extent_cnt);
> +			return -EIO;

Why fail? When the generation number has changed I would only hope that
means that the number of extents in the list has gone up, not that
previously retrieved extents have been invalidated.

So a generation number change event likely just means to retry the
retrieval starting from the end of the last generation.

> +		}
> +
> +		for (int i = 0; i < nr_ext ; i++) {
> +			dev_dbg(dev, "Processing extent %d/%d\n",
> +				start_index + i, exp_cnt);
> +			rc = cxl_validate_extent(mds, &dc_extents->extent[i]);
> +			if (rc)
> +				continue;
> +			if (!cxl_dc_extent_in_ed(cxled, &dc_extents->extent[i]))
> +				continue;
> +			rc = cxl_ed_add_one_extent(cxled, &dc_extents->extent[i]);
> +			if (rc)
> +				return rc;

I would rather this patch just claim to only validate all present
extents rather than pretend to add it. I.e. defer
cxl_ed_add_one_extent() to be defined and called later. When it comes
back a name with less tokens like cxled_add_extent() would be nice.
"one" is already assumed by non-plural "extent".

> +		}
> +
> +		start_index += nr_ext;
> +	} while (exp_cnt > total_read);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_read_dc_extents() - Read any existing extents
> + * @cxled: Endpoint decoder which is part of a region
> + *
> + * Issue the Get Dynamic Capacity Extent List command to the device
> + * and add any existing extents found which belong to this decoder.
> + *
> + * Return: 0 if command was executed successfully, -ERRNO on error.
> + */
> +int cxl_read_dc_extents(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	struct device *dev = mds->cxlds.dev;
> +	unsigned int extent_gen_num;
> +	int rc;
> +
> +	if (!cxl_dcd_supported(mds)) {

Why is "dcd_supported" being checked again so deep in the stack? How
does an upper layer get this far into the driver without something
already noticing that dcd support is not present?

[..]
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0d7b09a49dcf..3e563ab29afe 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1450,6 +1450,13 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +/* Callers are expected to ensure cxled has been attached to a region */
> +int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> +			  struct cxl_dc_extent *dc_extent)
> +{
> +	return 0;
> +}
> +
>  static int cxl_region_attach_position(struct cxl_region *cxlr,
>  				      struct cxl_root_decoder *cxlrd,
>  				      struct cxl_endpoint_decoder *cxled,
> @@ -2773,6 +2780,22 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static int cxl_region_read_extents(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int i;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		int rc;
> +
> +		rc = cxl_read_dc_extents(p->targets[i]);

Per comment above, the targets should have already been checked for dcd
support before being added to the region.


> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> @@ -2807,6 +2830,12 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> +	if (cxlr->mode == CXL_REGION_DC) {
> +		rc = cxl_region_read_extents(cxlr);

devm_cxl_add_dax_region() happens way after the region parameters have
been validated. I would have expected that initial extent list
validation happens earlier during region attach. This reorganization
also more naturally fits the interleave case where there will need be
cross device-validation before cxl_region_probe() runs.

[..]

