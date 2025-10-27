Return-Path: <linux-btrfs+bounces-18360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519AC0C2B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 08:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC203B1886
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 07:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD382DFA5A;
	Mon, 27 Oct 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxkC86sz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D6A2D9ECB;
	Mon, 27 Oct 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550903; cv=fail; b=qprzkBEyNeKkmb57Kbnymj2EeQsbalo4VVYczeaKDt0T9IZ4ycOCQstp6weBTsgghzjBM60Wz6EaZz7zqVQWVcOewLAwK57ea0tet8MEUjzZpZzgv1csQKp+JWtNVbeL3a1vd7uEO9g1kHeOAZdpfsxOmINGzbLzFCcHCgWJ4Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550903; c=relaxed/simple;
	bh=uTa2DvkPdJIcaKZg4DFq+wc0ZM1zDxtYFaEsCUzRyD0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Um/WZEwMlBvul77CvzPrmqkkWOHEVEgoenyH4ulHhuNw+57TkgBNWGsmHC3zaq82WStTgW/qHG9SaXCTi32uTVbM2rCDPLzauwVKbOzwC1vLcYe3UPk8R7NAzA2SdYaNWNcNlEkNFVAqYcXK3y7jOxuAiMKt/ioxT4/EY4MVuFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxkC86sz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761550903; x=1793086903;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=uTa2DvkPdJIcaKZg4DFq+wc0ZM1zDxtYFaEsCUzRyD0=;
  b=bxkC86szmzESAnyE0PqUFlD28WXPyk6EXcqa/JreJtSxdQPP4zE2ZhKj
   JDaqP2WIPeXTAYB3SlKIYnqKYmsgCtNe+yaPhety2AKYBlyCxE0vYRXoy
   U3jwI+oljUUd4Rc6csHegDJfXrV1rKSfi76d7JSyHzjtu5ZMQOEn4uAQ7
   4QcAw4rXqYC9iuYbrJhR3Rg2kNAGWrm1Um1/HIRpM3ZYsDEg1MOg+vxc8
   8ksNBmtIrYNfc+UhtETi+qURZdI5q75IfLgTWHFGztgYjiIYTORh4CLKM
   tdyS12qZEcOOruDp4coDS4p3KA7rgsfbftXHDXgV0bE+6O78E5xSlprSa
   A==;
X-CSE-ConnectionGUID: OY89yrzdQNCPMwlxdDWXZA==
X-CSE-MsgGUID: gxQHiWD9RVe21BKJaEgFbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63515019"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63515019"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 00:41:42 -0700
X-CSE-ConnectionGUID: dDkNAEivSJiRl7/XFs7JTw==
X-CSE-MsgGUID: wCIEHZZxQwekZ82UNKjhNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184871672"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 00:41:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 00:41:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 00:41:41 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 00:41:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK6pHHyA+FPcIbg2WiRsKud6BDOc53fXWEGbUDEBQP2bal5KikN7UoIScuUuIlnFiHExeq3ic9O/mkOmodIPZX9wrwSkRbaM/5LhGz6P0wwthhdHR8kHUvClw8rJ4WVVsXfxoYAMrYkylVcPJq8r1vG6YUr3wGl5nEpYiw601ige7dsS08IY+iCCZjkklCQx6UfYiztsCWte7YnD7OZSX2kLcxQDnH9Hn9DTXgA3Xn6jGAKnBjPm6cg0qWuPvnAG/yz/2pt8jhbE7LdNhBMdESGrtN7yS4hJZCPCbWP74CSfhlOKxHa15OLjdOLQ5CQYbNgLhdgoOBHxiuw4Jc8/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHu7ARLuVUXpve7MBR4OkmE0so0E0T8rsws2y52U798=;
 b=EOqoA78EYT/BwQeC/ABE0UF451tCuMyR6CN2rsIJ+CvEhBUkn75kdmSxD/c7CcBGJ1GBBZ1yuXRLh29Bk2anSCNxPOhzNzVJkMuyq5j0XjlCVeXJ9rIKBqgL5tUxWv8FgR+X314Eq2V33/+P0d9vAhmPAtSaaVOGB2mWXcn6Ja3H16gAbKugwNIhUBtf5nC37xg0fX31LO5Tb5mSxOrlNWFfZzeDdXzETcLM1F9oEqnHRHQc3D7fd+s7IbrJg2ki95NFxRqw8sNak0cy1QztYils0fQZFRvFGsb+OuKtjw5X3Z0NpA4tM3VGvPNCGY+4Mj+gpX3XgRvRmOhP7tXdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 07:41:38 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 07:41:37 +0000
Date: Mon, 27 Oct 2025 15:41:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, HAN Yuwei <hrx@bupt.moe>,
	<linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  b7fdfd29a1:  postmark.transactions 9.5%
 regression
Message-ID: <202510271449.efa21738-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:d10:24::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM3PR11MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 689d1e78-2476-4275-06fb-08de152c42ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?oTFz7vNIghoUrwhVlcutDvN9XtFua9ka7Y1qrlupQ3xLX/UzAqu52/YbEV?=
 =?iso-8859-1?Q?qgLPjFF7YKoEma4InxhLIT0WHvj33QenmdtQ1htF2YObZoMSxLO13jIYM7?=
 =?iso-8859-1?Q?jMfDW56kzkXJ/sjw37X9f1V/eEm+mVeR2mmW/qxuAhqqswLeRzWogX0LGF?=
 =?iso-8859-1?Q?lH2XIMBU+UtP2+fZ91RqcFOA8bch8t1sBGmPzzEUHaV62qFTgOoxfjA3xn?=
 =?iso-8859-1?Q?Oy/92JhAxwvTiW4bdto38iIYLYvp6vD581kQOqKkl3mPgxoXh21hAtjGoC?=
 =?iso-8859-1?Q?W8rJLK33rBFcVAIjmRpZDsGIT/kRAK3LCPYOYljAwC0fvXCBa6T1lzZO2d?=
 =?iso-8859-1?Q?jKmqtzS+ZJGqCiV0uZq1ep5vRAUj9WVwTY03l7OUWyYQVt+tcs8BwqS8fm?=
 =?iso-8859-1?Q?IxdL3/1q5u/6TRw3LMGef4kEhWNS/PImnqWO6oNbWeXCcbgVxFTbaLUu2R?=
 =?iso-8859-1?Q?v4F8HzpD8/L7BsfW+0nWBCdJs96Gghr1zcux31EYYknjL9iT0aumM5iaJc?=
 =?iso-8859-1?Q?ELildKR3VT89Lsvx+KZdSXQIVeO+yIRMVYOojzTlNfJJoGRSPdWk0HqnLg?=
 =?iso-8859-1?Q?vjptQc1XwRGOMAOTX0+Y+XfmenyU9rc4TKk/HDFbvYX1uID9mb3c1fzqnX?=
 =?iso-8859-1?Q?mDkRqtwpvjMx7WlQjBuAlNfOhPX4BDmv3M9qD4ETVEy4gKqDfF7LubsdIV?=
 =?iso-8859-1?Q?4cbr0W0T1Q4C8r2W+RHQZheb0ed6c0PkIbo4d4bQhYoPuKEwxMc3r5Wt/K?=
 =?iso-8859-1?Q?bJ+4CT4PB/HP7sQtD5lEO8pjHkKmImWGMcJwm1SjH5DBQI/EMeS29OM+Ny?=
 =?iso-8859-1?Q?rFMrn4xx/VptY8EYAm7IFQLwNgdJw/isM9DRH5LyemaeOO1X5K+yr+Bwbc?=
 =?iso-8859-1?Q?GLX0sPa5R7aUBVr99Uq0COnE5JfNSuXz/cTqTHuDYXXyPEa4DDavHhULv7?=
 =?iso-8859-1?Q?cwHoU45Hjxxt0/TEcLQt+FdiPq+Pv3ekkmr5/rX/mUPVAMkSo3ExkaA9Vf?=
 =?iso-8859-1?Q?v0UdI3FY77NKRmLE+MuNQyuVYInyWm8hjGSYKckVCFgmIJ4B+vcqhLJ1Sv?=
 =?iso-8859-1?Q?KkZzKFaMAZSkaOMWtVksAD2WEaK8AbI+ESL1fbb7jAS6skRpjMlBGe3nJR?=
 =?iso-8859-1?Q?i7d2Tr5LOaKKbFIBhuC5D5X3DTcacFM6a6Iz0OhUUGCjqZYe8uiqz7xprV?=
 =?iso-8859-1?Q?COvItJ4j5HFKA+hQmqU5LfTxNBt5clguRuTY+sxHG5wGhy0SQU0HAmu5zB?=
 =?iso-8859-1?Q?47XpeuQ61QkzuyoSMrNRoE49MxBt2MqJMU7EHZ+FWEx9wOQBnZ6wxmhOvH?=
 =?iso-8859-1?Q?llqirPTlv8qoK2zYuVhetpSnLUG/TJzkNnslWSgJD+O99I1SMcU5tmu+eM?=
 =?iso-8859-1?Q?ea4B+dtzn/6qt4GuXdJC7TN5Y2tOKnR5T8ppzYpzc0NgGZl/1/luzk9q8r?=
 =?iso-8859-1?Q?vcusvkWeAVqHKnd6t3R6I36sGNbzGOyW4uG4+HR+eqJMNYdB9g/UiZuH2z?=
 =?iso-8859-1?Q?3x21teOo2CajRI/f/dkEHViPQe/2vGSibzgBDMkHrhIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y8mBBZLBLVbfvGgmo7vsBd9OoqBTi3GhnuocFZ+flMiyNlSDPYm1Ir1ahG?=
 =?iso-8859-1?Q?kV0liW2mf16o0wqXpBPhIRhGxrrU1VbqF8FYFzRd/EyKKi6YlYwsgzx7rc?=
 =?iso-8859-1?Q?fg0NhvY5mKdCljIW4/Qn0xPHhXi+7+PXUZGFc9BlUkjtL/74pzHx0dzEf/?=
 =?iso-8859-1?Q?Ejalm08Cp2kYiCzkpHY5W9c7SVMYMGhLsrXoJDThVQCf0emQcRZqtoDBio?=
 =?iso-8859-1?Q?EFAAuYie/gbU5RX4yTKVZhlQkSvSxEdP4urp/aof/0f81+DeyWX6jazktc?=
 =?iso-8859-1?Q?1XTkn7teIqJNigv2q97udh+P0+GSNW+9dT/LCeOjZtnhziVez4V9iZGK+G?=
 =?iso-8859-1?Q?jtovcC5NsgXavg5bxs/hDbpVXpQ8njoJfHxCZuGy336wANtIw5H2pxAMog?=
 =?iso-8859-1?Q?l3aRR5e7jh0EPjGffyEEdZkWu/IcfQZBUxjQJwfjwlKBuIBcpgsi7jWEHS?=
 =?iso-8859-1?Q?VQ/TJyPFyUdy2cFrY7pZQjIBXaBkx3gSi3HWbxdK44S+3icLJijojpPgMV?=
 =?iso-8859-1?Q?RIEp1WL9Trs2gHJ7LE2ie/AlL/5sGJqTbdnt7NcG77h+9XfLq4sUX9+BkX?=
 =?iso-8859-1?Q?fZs8bryj3kOUMZWAkK4Fn9AYTz+u8D85nw8eesOSJX1FalbDe650GhSy/8?=
 =?iso-8859-1?Q?nSlYmgO75Vz6+xeUNY2alZo1mLe+/xvMPRAsQ5q7ZYZd9FLqPd1T2hJkri?=
 =?iso-8859-1?Q?ey7PLFCBIBjAZNoXFp8tA6bwMtYSlKUFoOgtQGEKyyoQFQfstD1jo8wpQl?=
 =?iso-8859-1?Q?oDp3C/7Ez81q4ZkHL4QXFgF9WkSWeJIxi5/vtfma03V3gb4ArFOVL4oaDb?=
 =?iso-8859-1?Q?LL6NAiFuIfs7FsNuueyZH8MmgInqJ9sATzgE1QOGF4vIqcXKnnq/KVGOuR?=
 =?iso-8859-1?Q?RHuhkEOBgMnAyxMGv8ZUPFk6YqSl90B+1w+5qDxYbpMrwg3iyiMOzUj43o?=
 =?iso-8859-1?Q?Ei0AjM0YBmDNEerSMBXlM3lp7NPdgPBAPInK3w0QkYF/uk/jU+iJdmMJLn?=
 =?iso-8859-1?Q?HBTyi/i9rfj3NC/S9P3SaAAWFoXKNflgNBxbcM+IBmD00vhpBLqjUEENhH?=
 =?iso-8859-1?Q?zb5C3VUfPvrIcz2tDc9TaadNTcfMQN5LiFRCUjqN9qw9wiPvq7W3EM0i0v?=
 =?iso-8859-1?Q?3MEV2vXrJxJrHAKCmRZbb1mBY2MFgE6eIN5+WKokPyi+cOuOlGMhd6gfOT?=
 =?iso-8859-1?Q?u3al6Mt8Y8HrzWkVzQbZoMEQf9Iuk52sipMqH1B81Pr5ev4Ni02egGmnTJ?=
 =?iso-8859-1?Q?O53U2KjJAxSes8UfhF18CTJLXKQLXAcKG14yWpububCX6jrd94wm3kU1r5?=
 =?iso-8859-1?Q?NsPF84881HOTP33dSIjtU2e8XzcOqZIoVMED0J1YDZA9pIsutzD1XqJNEa?=
 =?iso-8859-1?Q?UScntnheuobKYAuyCepmwG+JEox0vOlFKfCQsCHoz/3eNYP9AjwMgCLQ5l?=
 =?iso-8859-1?Q?UVG7BcskY70jwxLkzICduUr1GaXsOeMvG4+nylwuurVBS/moJNkw680O5i?=
 =?iso-8859-1?Q?VcvNo4HwTNqkMh+JLK05O7kHK5O8wv3PaXTt/Ws1FZ0aWpwMxT6EEaPV69?=
 =?iso-8859-1?Q?fMarJw4B1lA/kTnVfCkawBJrHMlxCSoRJFfDI7IRCRDhIuTLTPVOrc5fOF?=
 =?iso-8859-1?Q?Af9Y7XL/UoAFCHuqBsv6rs4X8HJTN9HFV0HhAytX/Thf+AkVltA1cDjQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 689d1e78-2476-4275-06fb-08de152c42ab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 07:41:37.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QnuR//T2NOgY7FVunN/ujjXSxHoS05lUN5DoUiVGsSdD/hBANiR4oIsJbEsJ9m566YoMP2kgrWNiS+M6BpHDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 9.5% regression of postmark.transactions on:


commit: b7fdfd29a136a17c5c8ad9e9bbf89c48919c3d19 ("btrfs: only set the device specific options after devices are opened")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


we are in fact not sure what's the connection between this change and the
postmark.transactions performance. still report out due to below checks.

[still regression on      linus/master 4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d]
[regression chould be solved by reverting this commit on linus/master head]
[still regression on linux-next/master 72fb0170ef1f45addf726319c52a0562b6913707]

testcase: postmark
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	disk: 1HDD
	fs: btrfs
	fs1: nfsv4
	number: 4000n
	trans: 10000s
	subdirs: 100d
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510271449.efa21738-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251027/202510271449.efa21738-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs1/fs/kconfig/number/rootfs/subdirs/tbox_group/testcase/trans:
  gcc-14/performance/1HDD/nfsv4/btrfs/x86_64-rhel-9.4/4000n/debian-13-x86_64-20250902.cgz/100d/lkp-cpl-4sp2/postmark/10000s

commit: 
  53a4acbfc1 ("btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl")
  b7fdfd29a1 ("btrfs: only set the device specific options after devices are opened")

53a4acbfc1de85fa b7fdfd29a136a17c5c8ad9e9bbf 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2010           +10.5%       2222        nfsstat.Client.nfs.v4.open_noat
     97983 ± 11%     +18.5%     116101        numa-numastat.node1.other_node
     97983 ± 11%     +18.5%     116101        numa-vmstat.node1.numa_other
     16001 ±  5%      -7.5%      14797 ±  5%  sched_debug.cfs_rq:/.load.avg
   1474354 ±  3%      +9.9%    1620281 ±  4%  sched_debug.cpu.avg_idle.avg
    756151 ±  3%     +10.0%     831539 ±  4%  sched_debug.cpu.max_idle_balance_cost.avg
      3585            -2.6%       3490        perf-stat.i.context-switches
      6141 ±  2%      +4.0%       6385        perf-stat.i.cycles-between-cache-misses
      5796 ±  2%      +3.9%       6024        perf-stat.overall.cycles-between-cache-misses
      3580            -2.6%       3486        perf-stat.ps.context-switches
 9.548e+11            +7.3%  1.025e+12        perf-stat.total.instructions
    136494            +4.3%     142419        proc-vmstat.nr_inactive_file
    136494            +4.3%     142419        proc-vmstat.nr_zone_inactive_file
   2784208            +4.8%    2917180        proc-vmstat.numa_hit
   2435763            +5.5%    2568673        proc-vmstat.numa_local
   3042276            +5.1%    3196281        proc-vmstat.pgalloc_normal
   2627503            +6.9%    2808220        proc-vmstat.pgfault
   2754381            +5.4%    2903034        proc-vmstat.pgfree
     97857            +6.3%     104058        proc-vmstat.pgreuse
      9.80            -9.4%       8.88        postmark.creation_mixed_trans
    112312            -7.0%     104473        postmark.data_read
    203502            -7.0%     189298        postmark.data_written
      9.80            -9.4%       8.88        postmark.deletion_mixed_trans
      9.73            -9.5%       8.80        postmark.files_appended
     12.59            -7.0%      11.70        postmark.files_created
     12.59            -7.0%      11.70        postmark.files_deleted
      9.87            -9.5%       8.93        postmark.files_read
    715.35            +7.5%     768.93        postmark.time.elapsed_time
    715.35            +7.5%     768.93        postmark.time.elapsed_time.max
     51508            -1.6%      50690        postmark.time.voluntary_context_switches
     19.61            -9.5%      17.75        postmark.transactions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


