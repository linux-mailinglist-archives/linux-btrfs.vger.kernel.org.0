Return-Path: <linux-btrfs+bounces-9112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B12649AD9E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 04:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13020B22F67
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 02:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08E14C5AF;
	Thu, 24 Oct 2024 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwY2Ia4G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF313BC3F;
	Thu, 24 Oct 2024 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736608; cv=fail; b=tcNqQjwvepz6rENCQe3wEN+0EcL6vz51H0TKYh9qYJ/bHWw859NbmqrhLQvI5HbT4AoQsQ/rCTgp6g/J1AWE2Mgpl6lM+jiTpzJq0iDwHzKtmRIu4Vu9/Cu6wuFGb5x9VAbZRmSrrAS1fpiG+EIzLztvNwnIqgai1/A1qyax9S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736608; c=relaxed/simple;
	bh=BUeQZwjqXFhT5MZooihQ6nddSPSitS6vS+Keb++pi9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mmKKuFYBkTN9hpazvpcv2+6lh8TyKtN16KjiNzao+tOangEtxpVqRzoqFDdkzWYvkj3ZnGEVcnjKtf++ysQ2E9pCcU7VmyYyK8A+4t36vFA2tQpiEs6lQpDpxP9Vyz9AxjqhiyYtVrX74Q4x/NzOxNbfbd9XluX5f9TEf8WBGe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwY2Ia4G; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729736606; x=1761272606;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BUeQZwjqXFhT5MZooihQ6nddSPSitS6vS+Keb++pi9c=;
  b=EwY2Ia4Gh/QbmJt2kBUGuq1on9/C6ORf5pR9RZtO5kYIaLJOO7bkMDr3
   yGh7WhhgS0JDK2cRi6I2RIJ/AJ7Xw/D5p0gfdCO+J5RnbO6BRRBT1/Xmz
   n5e2Dxt+8yS7IFPoNtkX0f+3pBYitWb4iF4qLdADbwCuoRAy7QHOR+TTS
   zS5S7JJvN5ucptyLgiHI6h+e9dk+wgwKTMzWpL0KU1mwV9G4GkLzEmE2t
   aaspTlqg1va9F9WCVL72kcMeNOYJw9GR1+dCCp6X7VoInv3u990FXyOei
   uSHqKkgjW06x8V1FedWCwEinA/fnHHkN5PsJD1cLE2zIThGQ3NgjXIE3l
   Q==;
X-CSE-ConnectionGUID: PrvFE57iSiqWf8oSXqPWdg==
X-CSE-MsgGUID: 1Bpk13HuSz2XmtYSZLJEzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29573465"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="29573465"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:23:25 -0700
X-CSE-ConnectionGUID: NMKVmW+/RLKdf+K7d840Yw==
X-CSE-MsgGUID: htNpkRy1QSqoEuAPYMhThA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="117917329"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 19:23:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 19:23:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 19:23:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 19:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaHJOwiFqvQNjI44GI1g+Fo8XxwlEGATPnGCOPVuMUKNcuY+RPDehn/dEgGpKLvHSNIM7AxZxx6A6zducwlo7mcm2n8qSfdwG2sjWbQBw/Bus79U+6S0GeEU4pKRqPd+m9+x9vYZrEBl/QldD73PlPjA4sBvdoTpF0fJIEN2yuRkAXpG4JfSMLaNNqDK0GG9yzE5Pq1CRRLx4kISehRYfwu6Ow1iwXkYDcrd9DXWjPv4s+iIw8g5sluHIPgsZg1ejSRhLk6l+aePKdFkbub1iG8AR8dawJkMAjhEG466TToGjrAuygIAPm3lWQn8BFVdEQbACfZijDb2mZzigEyRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sumeUl7cXQr6CYAymscEe4XiTcxJD/L30eGjO8Y0aag=;
 b=SvczMCnlRAE5TuiXtFvBCpm8roknE7ZFI7EspqNesRwsep0co7imlfK2cTM+C1TayrhdhA1n/lKRN68eGm6MAvRQ+Dhn+03ZjhUquaHPKNPdd+pu5PAbQSkIkD1tBRw+sONJmuNrmkBQwNl0aYFcq7oxxaxYpSIt6Dy7UuNaEpg/L4MSzkrRgNqdMqN9ShvNRTxlcVbtTl8nksr4H1PazeIobDhFa055Xo+DMNDh7Nr2Dh8HmXqkv+vSlIXsSjQTUI9+1UIKDg8CXY+GKnp0mYg/uPJmX5syZPWLGL6eU0Dsnt3ZmUUbc9HSDQ9Ir2vaJQDwr0mgxs+hEhdzS/wBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 02:23:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 02:23:21 +0000
Date: Wed, 23 Oct 2024 21:23:15 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 28/28] tools/testing/cxl: Add DC Regions to mock mem
 data
Message-ID: <6719af9392f8e_da1f929448@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-28-c261ee6eeded@intel.com>
 <20241010165804.00005391@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010165804.00005391@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: aec3f68e-efc6-4701-964d-08dcf3d2d47f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wQ1z0b/qzuac4Oz8GbLTwegSL9dCuFvYWdKtgVuoE/GgpMf0e+yTGsrGu3df?=
 =?us-ascii?Q?yf6VfV7z9tYyOCCkodSjhZtHmWzCQxwKN+CL7vGpJZDwUGaiIqyUmEaycU4+?=
 =?us-ascii?Q?U281b9p28PJH3aXMD/stzq1NKF9XBW2Uvob0UCUWto8xC916SCZwlWWopoZd?=
 =?us-ascii?Q?fZzMzQ2l7vOD1OgdXjqeUpS26HJSsPTOP3erwl6nSQge0HhzGPxvzThEOJSO?=
 =?us-ascii?Q?Vlyyp4Pw9UgLLKwV/z9m4wVND9lYsFGahtjtRSwQmGApmgOKgXXwB7rI0yhg?=
 =?us-ascii?Q?mX983f1Y2ept2PpLHniCREUzwtk/aegu/VLVo5TCSJvrBl1HG0b+eonI+D+k?=
 =?us-ascii?Q?5UOHVbvLVEosf9GsRoms2j/cZCinPG5Nf8EWy/AK9C3SJ7g9JrNKgP1l+ZyC?=
 =?us-ascii?Q?BRsPkR/Qxc3MZoEe8zh5J1q2srT828jW2Sk20oiRq3CSes7j47IrTA7scDVh?=
 =?us-ascii?Q?9KaE+lt4+BC8gTxd2yMvOK1OlLzOi+YQqNrQn6hq7ViG/Ecb7/sMp6D+au2q?=
 =?us-ascii?Q?Pm/XSVpIC5+TnvK4jMuTW2VnCJRB7hB6tV4ynQOPvB5h8MPkvnxtTIesDZb1?=
 =?us-ascii?Q?trcU7pROETqK1ZMNc/PAxP92piyCZVLYbP+H8B3Dtq9HqPP+Icc8Kfl/WW6I?=
 =?us-ascii?Q?Wl5D72rdMTObaWttWqxMEALfW/eMTuPDWfC1yD0p1DuRjkGXSYhuUN7nAaXO?=
 =?us-ascii?Q?+FM6ybkNmWrNmctk5bNwTRn1zI31CV4pHaDtcJCZ8eRwUgj4SORiNonu1WQG?=
 =?us-ascii?Q?yMZ+P9pjs7cGGVYoWow946TGyGA+yGnLBRNs0hBwxYW1if9OXiUzxhVX8gpJ?=
 =?us-ascii?Q?kUWERrgLkHDRIvqDrTS0aYc3nIn5mVX1LKcDetneOpvrGxrSTwZ0Kk+l54gX?=
 =?us-ascii?Q?Je6+FvUGi+sf7ncmqt3PQ1s7jIwrZHc+MYi6Jv5wOtcYLrHmAQyr05tNWU3/?=
 =?us-ascii?Q?V0TW0Sm+mN7ianDQTkdyiKrizlFKSQgy9zb25enT8J1VXM1B3/I4UckCzXNd?=
 =?us-ascii?Q?OO8vAC5a5vE2vFVbJnVwqGROGgvXnIC4J60lROhB43Lsx359JPoi8g4gId+Z?=
 =?us-ascii?Q?DvrAx08mpANYJ5j3T+sd6ZsKUFrZpXmdjV26XQ6MB3ZdGXxNCzDrA86RCV0o?=
 =?us-ascii?Q?s+NAacvaP6birWd37Qbo6wb2k1V+ZjG9Hb3ZDs8dQ/Gd5hjbFFnwzgmeckOL?=
 =?us-ascii?Q?1aGfDoATY0cMzFOMHcgyp1pa5M7UfYCbIvPis9COpeljy4PQqk67BU+y0mN7?=
 =?us-ascii?Q?i7GZYkCVYvawghETcFgXn5r+wt5U7c/b0nq4QNkFGOzbywOR/H4NkQzwZ7vy?=
 =?us-ascii?Q?bC0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tE3lpMRyP9t8vQr+UnojHy/q6SYV+00XPOmdjabZwbKOhdJ9MQvR2gD87y5e?=
 =?us-ascii?Q?ECWXmM0appL3g8WTycMl2vYX2UmaRUi+SeJ3qmnz+GVtmK59EcigwKUq289R?=
 =?us-ascii?Q?RLUeZ4J/fXct1zU04mucEliDT3pb4SE6JujLdb3pIm7fKgjvB4SFZApDRdxI?=
 =?us-ascii?Q?VuKh+o2BrOkg3i9S+B/cD9OYCXGsdouX6wnmgG1p+8TgrCIYixswTgLg29nL?=
 =?us-ascii?Q?eHo1GXCw6WghpT25ogag40keatRRvy7MzhY5Qsyh7rJ4Si0uv4HGx8j38lf4?=
 =?us-ascii?Q?NO8vzt2oy953NFIu0agl03l8ZjRN29lWfOi9Q1xLyumhVmfyK2zm6i2Z+NOo?=
 =?us-ascii?Q?ezgbX+LC1BP7UVILv/0FNKGBqA7GbEV5mZV3bw4se/YhtdPP/MAVzK7yZTbl?=
 =?us-ascii?Q?EV0CzU8J4hJAI1iEeo+7y24i0dGp/PegjS1ZI5DU9IgiDOo51osUETuNX2FZ?=
 =?us-ascii?Q?RJWzobUF0z1/FSVCLYvrutY6fS1siDVKb407Z9aIJ5QNeJhFm8HIlTaLia8X?=
 =?us-ascii?Q?bvAI6P9KCwo9Nh6Ik/MQQWffdVN8e82bPU3xrOttynrWAE62OJvNuWB4W6IG?=
 =?us-ascii?Q?hET3HaedIuxEed5ZnufVcjOP5w9I71WrrMwYGizOc7RkDGtTb+mpcl7Agtql?=
 =?us-ascii?Q?goi6fPvt5Zy3rO1YJf+7v7zRT0eCSs2kALDbfD4eKtnCFahm6ntyJqolZH7Y?=
 =?us-ascii?Q?QNFcSw2e8nmkn6LM1p+qzYSQP2oHxtB+k90sB7hg0ph9CdU58KctOP8pl5yv?=
 =?us-ascii?Q?SwYdViezHbJqcWsYCftgkeAJcK4aRY94XJxymTUhpqz1j5hEz9iy2S7aVVqR?=
 =?us-ascii?Q?15jQItE51Jl9ZiM4KPohevNk5M7LH7u0Jwp065bpOmli+weHJKGmGS69sL/r?=
 =?us-ascii?Q?KNxZT2q346emnSEKI74FLUlvsy2122Zv2/mZtm2FJpzseZxkM35opuw49JJO?=
 =?us-ascii?Q?hMxheQ4SH4VAjQKpEmZFCKaQes9o4VcmznAhElOB+LvLr3qRIqKBnwPa1rnb?=
 =?us-ascii?Q?ARexGhhj/fDjPubtx22gP7Ds5W+5PZse7+/O7mkveOM8FbfkHZON7HwcU3Os?=
 =?us-ascii?Q?yKQyOOHoyNBCAa0kmHEpIFeya6nZ0LDm4ODsOcvi0VxEaGIO2pJqvVAqPfds?=
 =?us-ascii?Q?e2TZMkhR01wnHwZaIXwJhrk89cdMOy1I0enz7Aogq2zKWeeA7jHNJwNkLgU4?=
 =?us-ascii?Q?Kr2UIISgNyoHlW+Hk+C/SXTHz42X0gJPcUJwb4WDyHhAS7ONO11O7kiCidBg?=
 =?us-ascii?Q?ewyQYbVn9lAWRzylCQAhezoH0hHs3TUpF2w+9hjJohvuZQf4v09aVXknmsYk?=
 =?us-ascii?Q?lirxE2D52Wu5hbpK4LGJ6llx3DFVAomAvJ9lu5xe6RUNQwLnqM9PFS1u8hgR?=
 =?us-ascii?Q?55lf93QyQECgWftd0lFoA8xAqh+AYFmkbUOm2qORec/sV9naRQOg9jN/EANb?=
 =?us-ascii?Q?LvU8RPQJL2hZtTwtLEafk8MFSBF+9/iwx9M97l11CCwE5oq41Tp8ynkQhnuE?=
 =?us-ascii?Q?MQ2mP5QAzT5FU6Jf+tWuWwEY7CcboFBnRKlonui6KHvH+UK4LWp+xwv3sobu?=
 =?us-ascii?Q?qIhq/wjGkuiXQboWSp0qq+ZxmSLeWDaN/cABJBQn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aec3f68e-efc6-4701-964d-08dcf3d2d47f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 02:23:21.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZJkX2zWPjrNd1jBlMeUWHK38boZVjua6ufEILzfHJHOGmrGcixpfxS1wiOMXaPjPdqckrIlRrtv5ogQQ2MQNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:34 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Superficial review only.
> 
> Looks fine to me but I've been reviewing too long today to be at all sure
> I'd spot if it was wrong in a subtle way.  So no tag for now.

Thanks.

> 
> > +static void dc_delete_extent(struct device *dev, unsigned long long start,
> > +			     unsigned long long length)
> > +{
> > +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> > +	unsigned long long end = start + length;
> > +	struct cxl_extent_data *ext;
> > +	unsigned long index;
> > +
> > +	dev_dbg(dev, "Deleting extent at %#llx len:%#llx\n", start, length);
> > +
> > +	guard(mutex)(&mdata->ext_lock);
> > +	xa_for_each(&mdata->dc_extents, index, ext) {
> > +		u64 extent_end = ext->dpa_start + ext->length;
> > +
> > +		/*
> > +		 * Any extent which 'touches' the released delete range will be
> > +		 * removed.
> > +		 */
> > +		if ((start <= ext->dpa_start && ext->dpa_start < end) ||
> > +		    (start <= extent_end && extent_end < end)) {
> Really trivial but no {} for single line statement

Sure. done.

> 
> > +			xa_erase(&mdata->dc_extents, ext->dpa_start);
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * If the extent was accepted let it be for the host to drop
> > +	 * later.
> > +	 */
> > +}
> 
> > @@ -1703,14 +2146,261 @@ static ssize_t sanitize_timeout_store(struct device *dev,
> >  
> >  	return count;
> >  }
> > -
> Noise.

Fixed.

Ira

