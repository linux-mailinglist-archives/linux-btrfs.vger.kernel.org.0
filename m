Return-Path: <linux-btrfs+bounces-7258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A8954C2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F633B244C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2821BD013;
	Fri, 16 Aug 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPW0Xndd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8F1BCA14;
	Fri, 16 Aug 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817860; cv=fail; b=jGH7IuJcQxYXZrxpbiMh9JrYdLj+jlbLMm9BkooQk5lgYRFFkihtCfrc/QZqGZCH9coyiO6qYKOa5twPNuU8nzqD4i3ba6JUoyzftg5R3RqdO8xgHV4+DHLymVhtS7BMUZfSSUOJs8LCrw7qd5hsBpr4R0Qt0OpOOQvK1WmOwT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817860; c=relaxed/simple;
	bh=i6mf7JzyY4fgkEupuqfjbtzTMaphYzNsi1AIHqh1SQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sNUApfnotdMCmalteopV/19bm9DNEKlpdu1bky3I+AsEQ2+QVeYN7zEUI72jHVSNnsd2OnwEKVG3jZ9/SFbNporIoLlDb2a1jztJVKHbUYyqS68soc6QVXi1gt5/BFuePnsY8N8CZMD75ZOsHhE5qb+ZFEtqiitygC8I3KAt6t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPW0Xndd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817859; x=1755353859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i6mf7JzyY4fgkEupuqfjbtzTMaphYzNsi1AIHqh1SQQ=;
  b=DPW0Xnddc6uSzl0p8dhOc4ZcN/r0VJNZJk445/GnNRptqI9DZaztjg8J
   lt/BWChwkreCh+cetiOsBPBJi1jaysgz+5wB5IlvNrpnHIBd2CzMagmmZ
   iETH29HFyVeYwZWpP0OvIAnGIL5fhmm5KruHgrKx40I2/w0V+Km0WM5yb
   SPDU5zcEOywMRBmBucg5/ap4nKg2h/d+dnJgN3cjMQF0SNSFiRjY7dmOh
   BHDuNB2u4tyYEW3PWA2DUl0DUDM4m2uE68KLWjWBjgI/YO9k5KddHOjfl
   8sAKXvl7DvkTZH4pWgAlYxNOrCx55/fESajCigtX4bSjc1yjqP4uihb+1
   Q==;
X-CSE-ConnectionGUID: VsGU/jciTPmNdVUVklUc3A==
X-CSE-MsgGUID: ymVRFizWRG2ATHMjQ5rKRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33524187"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="33524187"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:17:38 -0700
X-CSE-ConnectionGUID: YgzusHraTMyPrSYfqDfsNg==
X-CSE-MsgGUID: 4xI29Zo9Qxm02GCSxImVLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64632438"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 07:17:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 07:17:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 07:17:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 07:17:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 07:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQTarqB/o9AltzUT46wlcepDV1ch84ddNxfRu6XB1j3jxh54WxHlgShKTubpcqx9+hQT2EDGNDiUNffZuutDaCz9GFwHZT7O+LfWx/kNd3BOdVRjfbYqcEOdwWZ/Cr1B/Y7Qh9mNrlF30QVy3JlPmfv7ZhD5lQuetJl8sxnQySMplXoa+hrxXPhRjV0AGEyWWDXgOJoEISLJZQG95MLV1zmP4MF3uKMu5/EU/lNV5OwRobBCcSvwe3u1+hDAprrlioj2F09Q+kM5lpaWVYSj2VcHBAm5W/tLduBZcbbI9fL4XOLX4/6VqACRINGb5f66bxUGuZxK6Imi4+/MN9EyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RlDoyrwDT7/PnM8+BL7XuIaY4vNi729kDMZA5+WK/w=;
 b=q2JKD2pftP2xI0mqegKvDv+ulvRGM0uX5Ni6vCiD6d4f4wOTN0MIWr1A3p1kSFF39sX/Tu2vfpSH3V5eZcJPxLxeCE14FyO08QpulODcbINx17NyxlUDO3Q9e+hxVEAdpuSeW8XQri+XirTuglVWndTjrWX26xEFoZFOK2pCGkK2QgfmfLi4ED5zx92vNvMHukobNPulOf+2eKC3FEn5rWeAvkYDWKlkADZuFptSOP+zyMvGtOHx62URhhJ53KUPrAusUYST+zwZ6Acs7LCJbLMRFh5S6RLj7Gp6U/2Sie9T23TJyPXbbariG4CBzoEdwW4mHTUfRZXjfBB2JrE6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 14:17:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 14:17:34 +0000
Date: Fri, 16 Aug 2024 09:17:28 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "Li, Ming"
	<ming4.li@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/25] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <66bf5f78a2330_22328529480@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a282d8-d9ba-4052-8a64-08dcbdfe2c44
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U+8xXvClbRrd3ZnBc4ucFbI/rTCOp974ukcl1XkwMdEgoq5QgwXPhVriv58V?=
 =?us-ascii?Q?fb+K2wZNHLekBpWKQLjAnBK2xIxliwME+hcMf7ddOoZHWi3ZC16pc/HPVCUv?=
 =?us-ascii?Q?2P9gMA21Ir7UqFUqvkrNkwJRLILrxfgH/+IGwEYyH0FcDNAsDoICMeST35ct?=
 =?us-ascii?Q?8K1MUNzr59ICi0FNfjGJV7N4dQmIsdkrcvNnlxHHzyPhUMGvStuq8uzY5hFi?=
 =?us-ascii?Q?wQ9gBtQjLPhLZGhL/28zfxcwaO1PqnWjBnfKMDXiyGHFZJHb2wO28BY4Ey3S?=
 =?us-ascii?Q?MdsSVIIIe7VgLRrg+w2dyKoBYY0orfk5AXOuuT3r6H/Un+JyGiHEmKEnFE66?=
 =?us-ascii?Q?xUr9WKDm+OClgZsH7ja2LB/FUSH9+hZqXyLzqJG3Ht2Lv4T74Q4b5PLri1Zx?=
 =?us-ascii?Q?/EZxhP9uWyxhl9agzIB5rR9ZbbhYNTAALE6D8JaX9ybumrmxsaou61y8EnIn?=
 =?us-ascii?Q?GvsOo9y4YO+vOfE2O89iMMkehdqeaRFzZQcUEYJmf4jrPrLrUYe2sZGHPYlC?=
 =?us-ascii?Q?hBB6CtkO5Ttt8OaI8Uak/7bLqK9vJhCGWM1QnercLm/2t+mAd6of16m97pFk?=
 =?us-ascii?Q?LtY0Ko5/4LnSepkZJ96PDe5kp+GXg2rGcEVYzUJt8K1Xwc4HKBPR/rndPUkB?=
 =?us-ascii?Q?jw0WgPETGel9OL3i4bg5M6hzYoWOhbIutZ4cSYqeXIr/N9YVYD4P05oVbUxt?=
 =?us-ascii?Q?ETMkbvWQ00MaKHS/Su2xtLOKKoWTQnwx6gPgv0rCpuFyUoUfBYgSnyrayGbr?=
 =?us-ascii?Q?juJ1AaQz+JVPj6DQuLggt8UYwHbF/YB9Ngp0MuUWApDEvT2aedDMDxpEK03T?=
 =?us-ascii?Q?kiOc/UmRHXflox95Hk5LMEO/EuTHjbtIARwoeXiXDFS7jktcpZfFnCjFoCxJ?=
 =?us-ascii?Q?wMEIBNB6v1rcr68vXIvlfMVB8ejZdsUoS0Lj9tGo97fWxaZdDnf0l4t6AMsW?=
 =?us-ascii?Q?vlAXeRv3ld5K2WhxFEeP7OU1C/ZnRXqrXrM70ZQWFXcknhe/Mkt0TT2QRIHn?=
 =?us-ascii?Q?P3jQRSGHJ3ziOE3UDXPRlyK2zX5F9Ruhllf+nzmd3zs/te9DXShuKvMfgO4q?=
 =?us-ascii?Q?yVgmy8z+YuHXmD9bo+uMdhTYFk05kozDHdXA5Ao9Cue3l3h4VRmXdGPUJjS9?=
 =?us-ascii?Q?poevEdU2D7rZ69YrMO7Enedy4IXgkgsJAbkchZzB6114UYn3KIRAczznb6qX?=
 =?us-ascii?Q?I7GtlckSErCJ32Qt1AP8i3iRmsJHf6eX26Ks/4Fc7GTYPkZThv0MD+5EgLHc?=
 =?us-ascii?Q?fx4Z8It4RclIop1I2HMDf2MHUJgupn2qtl9uAMgTc7uIUKjTnppG8p/A9Wgd?=
 =?us-ascii?Q?UnxE3xIjr9XHnOdXEZA+m9jz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2YgJjoeX3zUdrUqXfsich76byh5ZK9Vpqm6asMvDe8ccB2OqeXsJWkgqebB?=
 =?us-ascii?Q?Mo6feUsglmuh03aEmPtVV8nfSWcrqvbdieWbE1wcyC2a2vfQ74q2+6NhuF9r?=
 =?us-ascii?Q?RvGxYQMQWywGqmBSpNW+gFXr/VuoKtJ2I6K9hUbkN31Sl33aVOq2w/zrWXQU?=
 =?us-ascii?Q?5NqobvsIzenUXV3jZDn6oNg2iIzVk1/KmK925KGQCsl2U2hDPwJ5D/WijSGW?=
 =?us-ascii?Q?BXMR362af1JnxOyWTs/sP9mfwVFD841DVdXVRknXoPVxcZqcP02OgT/rJq7v?=
 =?us-ascii?Q?jYAdcdnbq5VHOLupaocCdT5Ku7F57ny4qfK4CKc8gKWaxjpTGXTA0kqzI29j?=
 =?us-ascii?Q?Hh5X5C0a9BTVddzGyEhMjetvFl/kNusl1VaE1OrAzdQyhN7BMksvpz+A1RfT?=
 =?us-ascii?Q?o1HH2ixS30568it/ojEE7+2VnUw88GtubEZ89dX4TmkKIsTguUaX/uxnZlUb?=
 =?us-ascii?Q?U51M7H5Tcv0Exlq/Uc5lA741/bZiwSRayeqwUq5uRWPHhQtR2d8kzYppYAlL?=
 =?us-ascii?Q?pMFjxZGWrQL8WOiUEfe6KyMni++nCrhoUH418v21ffjmo+RsMYaa4ALT5n0N?=
 =?us-ascii?Q?lxsgOLyxVN+J0v61OG7ssckc36Z/u7yNO9TIV5k78MYK5A0RzvITGs6T8lOp?=
 =?us-ascii?Q?X/gCz7a/xN9W8b2J8pJ/jW9GX5nOYP5pWhBuWazjq0irgJ7UC/eOeRdstCsE?=
 =?us-ascii?Q?IGaT8clbn7ldPnQz8MPSxfW37KV3gzDnLjlIabjd2le/6DPyOEAvkqamIy5+?=
 =?us-ascii?Q?mbPz7MKdvaLXzeOteKqdfDrMn08VyOAX6G13+92rPIYWVoX5u6JUhEalzf9S?=
 =?us-ascii?Q?w6ThbO26HxGlLT3KhQYkNBt9/nW0y1oLTH/3/pDIWFqtdqop386pc5bVQ83M?=
 =?us-ascii?Q?EB4jdaEVO164fjZ3lNW/MdwOFLXOPVEMyQ3P6myOtzgx11E4/tUhGlsLC+lm?=
 =?us-ascii?Q?2HI4bdpeMB1y8DwgP4vCFu7U4AluZsESOv7kBpflURAHPKUw1wcISceOuRzH?=
 =?us-ascii?Q?hLkg4Hat3BSSwufW6TcHKxGN/eoPE7avPc7h53GLrZ+qXz6sLjK0yDn7pQNM?=
 =?us-ascii?Q?RsxrhCL59NubjQ/IbcCT1N7t5YrmtUFc/QbVZWRlZ6fLeCOIF+/mf/xbDEUQ?=
 =?us-ascii?Q?a7xY5gJs2ytGUnGiQllVTXTbFjIh9UAYNJklY8r3MrowGH3HclJDA/p6DiGE?=
 =?us-ascii?Q?tStCjejnqXhIB4tcNlIcnTs+zlaghc1O59PRv++89+f2wuKDgsRBuKZcqNHE?=
 =?us-ascii?Q?4apNQ1A44UGY2br58NQi6LBwSEpRW7jzr9ZorxtChBZhZuiJuEYOwuTB1ZJ3?=
 =?us-ascii?Q?5ZJvCU0knxelT+GjIA/6N1IswVZ3UBsdEVrU5dqy1AtbOMBJ21Drvaz66VyR?=
 =?us-ascii?Q?WxkcPsNrrKgGXC8j0xMt+qu+vY6zxt/LYWM09nrXiY1Ab5iDf0q2VfXltOSo?=
 =?us-ascii?Q?+4qkjWCInCurJVMGIfsFbcDCVfGZjhiufdgjLbqfd0bEz0QW8QomwUD7PF4E?=
 =?us-ascii?Q?EenFruyii59TytFW8cq/7sjZGI9NvxCjhDeQ5zd7bsi1kqUQjZJQoh5oQUHz?=
 =?us-ascii?Q?VPXcC2uk1KNeT2d4EIcNpbloEUVX2/5LFj/sdDgm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a282d8-d9ba-4052-8a64-08dcbdfe2c44
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:17:34.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yu+s4buPuorg1nobInHaeE3wfIKyfH39k1Qu2Mzpbb5PfNprKN4tLBa0w/xPK48ZGjJO1F+LNw8A+qzP0P8sWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

Please ignore this series __and__ the RESEND.

The series did not get sent properly.  Something went wrong with my smtp
server in the middle.

  [PATCH v2 22/25] cxl/region: Read existing extents on region creation
CRITICAL: Error running /usr/bin/msmtp -i: msmtp: cannot locate host smtpauth.intel.com: No address associated with hostname
msmtp: could not send mail (account default from /home/iweiny/.msmtprc)

Then I used b4 --resend v2.  But glossed over the fact that it was going
to do something very bad and send a very old version.

https://lore.kernel.org/all/20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com/

So please ignore that too.  :-(

At this point I'm going to send v3.


<fingers crossed>
Ira



Ira Weiny wrote:
> A git tree of this series can be found here:
> 
> 	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-08-15
> 
> This series requires the CXL memory notifier lock change:
> 
> 	https://lore.kernel.org/all/20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com/
> 
> Background
> ==========
> 
> A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
> device that allows memory capacity within a region to change
> dynamically without the need for resetting the device, reconfiguring
> HDM decoders, or reconfiguring software DAX regions.
> 
> One of the biggest use cases for Dynamic Capacity is to allow hosts to
> share memory dynamically within a data center without increasing the
> per-host attached memory.
> 
> The general flow for the addition or removal of memory is to have an
> orchestrator coordinate the use of the memory.  Generally there are 5
> actors in such a system, the Orchestrator, Fabric Manager, the Logical
> device, the Host Kernel, and a Host User.
> 
> Typical work flows are shown below.
> 
> Orchestrator      FM         Device       Host Kernel    Host User
> 
>     |             |           |            |              |
>     |-------------- Create region ----------------------->|
>     |             |           |            |              |
>     |             |           |            |<-- Create ---|
>     |             |           |            |    Region    |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->|--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Accept -|<- Accept  -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |<- Create --->|
>     |             |           |            |   DAX dev    |-- Use memory
>     |             |           |            |              |   |
>     |             |           |            |              |   |
>     |             |           |            |<- Release ---| <-+
>     |             |           |            |   DAX dev    |
>     |             |           |            |              |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |-- Remove -->|- Release->|- Release ->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Release-|<- Release -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->|--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Accept -|<- Accept  -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |<- Create ----|
>     |             |           |            |   DAX dev    |-- Use memory
>     |             |           |            |              |   |
>     |             |           |            |<- Release ---| <-+
>     |             |           |            |   DAX dev    |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |-- Remove -->|- Release->|- Release ->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Release-|<- Release -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->|--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |<- Create ----|
>     |             |           |            |   DAX dev    |-- Use memory
>     |             |           |            |              |   |
>     |-- Remove -->|- Release->|- Release ->|              |   |
>     |  Capacity   |  Extent   |   Extent   |              |   |
>     |             |           |            |              |   |
>     |             |           |     (Release Ignored)     |   |
>     |             |           |            |              |   |
>     |             |           |            |<- Release ---| <-+
>     |             |           |            |   DAX dev    |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |             |- Release->|- Release ->|              |
>     |             |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Release-|<- Release -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |<- Destroy ---|
>     |             |           |            |   Region     |
>     |             |           |            |              |
> 
> Previous versions of this series[0] resulted in architectural comments
> as well as confusion on the architecture based on the organization of
> patch series itself.
> 
> This version has reordered the patches to clarify the architecture.
> It also streamlines extent handling more.
> 
> The series still requires the creation of regions and DAX devices to be
> synchronized with the Orchestrator and Fabric Manager.  The host kernel
> will reject an add extent event if the region is not created yet.  It
> will also ignore a release if the DAX device is created and referencing
> an extent.
> 
> These synchronizations are not anticipated to be an issue with real
> applications.
> 
> In order to allow for capacity to be added and removed a new concept of
> a sparse DAX region is introduced.  A sparse DAX region may have 0 or
> more bytes of available space.  The total space depends on the number
> and size of the extents which have been added.
> 
> Initially it is anticipated that users of the memory will carefully
> coordinate the surfacing of additional capacity with the creation of DAX
> devices which use that capacity.  Therefore, the allocation of the
> memory to DAX devices does not allow for specific associations between
> DAX device and extent.  This keeps allocations very similar to existing
> DAX region behavior.
> 
> Great care was taken to keep the extent tracking simple.  Some xarray's
> needed to be added but extra software objects were kept to a minimum.
> 
> Region extents continue to be tracked as sub-devices of the DAX region.
> This ensures that region destruction cleans up all extent allocations
> properly.
> 
> Due to these major changes all reviews were removed from the larger
> patches.  A few of the straight forward patches have kept the tags.
> 
> In summary the major functionality of this series includes:
> 
> - Getting the dynamic capacity (DC) configuration information from cxl
>   devices
> 
> - Configuring the DC partitions reported by hardware
> 
> - Enhancing the CXL and DAX regions for dynamic capacity support
> 	a. Maintain a logical separation between hardware extents and
> 	   software managed region extents.  This provides an
> 	   abstraction between the layers and should allow for
> 	   interleaving in the future
> 
> - Get hardware extent lists for endpoint decoders upon
>   region creation.
> 
> - Adjust extent/region memory available on the following events.
>         a. Add capacity Events
> 	b. Release capacity events
> 
> - Host response for add capacity
> 	a. do not accept the extent if:
> 		If the region does not exist
> 		or an error occurs realizing the extent
> 	b. If the region does exist
> 		realize a DAX region extent with 1:1 mapping (no
> 		interleave yet)
> 	c. Support the more bit by processing a list of extents marked
> 	   with the more bit together before setting up a response.
> 
> - Host response for remove capacity
> 	a. If no DAX device references the extent; release the extent
> 	b. If a reference does exist, ignore the request.
> 	   (Require FM to issue release again.)
> 
> - Modify DAX device creation/resize to account for extents within a
>   sparse DAX region
> 
> - Trace Dynamic Capacity events for debugging
> 
> - Add cxl-test infrastructure to allow for faster unit testing
>   (See new ndctl branch for cxl-dcd.sh test[1])
> 
> Fan Ni's upstream of Qemu DCD was used for testing.
> 
> Remaining work:
> 
> 	1) Integrate the QoS work from Dave Jiang
> 	2) Interleave support
> 
> Possible additional work depending on requirements:
> 
> 	1) Allow mapping to specific extents (perhaps based on
> 	   label/tag)
> 	2) Release extents when DAX devices are released if a release
> 	   was previously seen from the device
> 	3) Accept a new extent which extends (but overlaps) an existing
> 	   extent(s)
> 	4) Rework DAX device interfaces, memfd has been explored a bit
> 
> [0] v1: https://lore.kernel.org/all/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/
> [1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-08-15
> 
> ---
> Major changes:
> - Jonathan: support the more bit
> - djbw: Allow more than 1 region per DC partition
> - All: Address the many comments on the series.
> - iweiny: rebase
> - iweiny: Rework the series to make it easier to review and understand
>           the flow
> - Link to v1: https://lore.kernel.org/r/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com
> 
> ---
> Ira Weiny (13):
>       range: Add range_overlaps()
>       printk: Add print format (%par) for struct range
>       dax: Document dax dev range tuple
>       cxl/pci: Delay event buffer allocation
>       cxl/region: Refactor common create region code
>       cxl/events: Split event msgnum configuration from irq setup
>       cxl/pci: Factor out interrupt policy check
>       cxl/core: Return endpoint decoder information from region search
>       dax/bus: Factor out dev dax resize logic
>       dax/region: Create resources on sparse DAX regions
>       cxl/region: Read existing extents on region creation
>       tools/testing/cxl: Make event logs dynamic
>       tools/testing/cxl: Add DC Regions to mock mem data
> 
> Navneet Singh (12):
>       cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>       cxl/mem: Read dynamic capacity configuration from the device
>       cxl/core: Separate region mode from decoder mode
>       cxl/region: Add dynamic capacity decoder and region modes
>       cxl/hdm: Add dynamic capacity size support to endpoint decoders
>       cxl/port: Add endpoint decoder DC mode support to sysfs
>       cxl/mem: Expose DCD partition capabilities in sysfs
>       cxl/region: Add sparse DAX region support
>       cxl/mem: Configure dynamic capacity interrupts
>       cxl/extent: Process DCD events and realize region extents
>       cxl/region/extent: Expose region extent information in sysfs
>       cxl/mem: Trace Dynamic capacity Event Record
> 
>  Documentation/ABI/testing/sysfs-bus-cxl   |  68 ++-
>  Documentation/core-api/printk-formats.rst |  14 +
>  drivers/cxl/core/Makefile                 |   2 +-
>  drivers/cxl/core/core.h                   |  33 +-
>  drivers/cxl/core/extent.c                 | 467 ++++++++++++++
>  drivers/cxl/core/hdm.c                    | 206 ++++++-
>  drivers/cxl/core/mbox.c                   | 578 +++++++++++++++++-
>  drivers/cxl/core/memdev.c                 | 101 ++-
>  drivers/cxl/core/port.c                   |  13 +-
>  drivers/cxl/core/region.c                 | 173 ++++--
>  drivers/cxl/core/trace.h                  |  65 ++
>  drivers/cxl/cxl.h                         | 122 +++-
>  drivers/cxl/cxlmem.h                      | 128 +++-
>  drivers/cxl/pci.c                         | 123 +++-
>  drivers/dax/bus.c                         | 352 +++++++++--
>  drivers/dax/bus.h                         |   4 +-
>  drivers/dax/cxl.c                         |  73 ++-
>  drivers/dax/dax-private.h                 |  39 +-
>  drivers/dax/hmem/hmem.c                   |   2 +-
>  drivers/dax/pmem.c                        |   2 +-
>  fs/btrfs/ordered-data.c                   |  10 +-
>  include/linux/cxl-event.h                 |  32 +
>  include/linux/range.h                     |   7 +
>  lib/vsprintf.c                            |  37 ++
>  tools/testing/cxl/Kbuild                  |   3 +-
>  tools/testing/cxl/test/mem.c              | 981 ++++++++++++++++++++++++++----
>  26 files changed, 3327 insertions(+), 308 deletions(-)
> ---
> base-commit: 3cef9316df4cda21b5bf25e4230221b02050dfa1
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 



