Return-Path: <linux-btrfs+bounces-7424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8A595C36F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 04:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6377B1F216CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 02:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1542E2BAE1;
	Fri, 23 Aug 2024 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akLWzHxE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5617C66;
	Fri, 23 Aug 2024 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381606; cv=fail; b=MYcNWd0Zk0R8UH84mUTSiPNlafOcRzDvpy/72x4TEzh7HW7YNiC3oqfuVQLwDu5bp3jc2ragtVqJXNFg2BotDbXF90xsZj6vP8z7oYK46AzxioimbcRONSU0A6Tj2WY7ZV7u+adMlvfuZRzFjvgwCBLtslq1PcvzqvG/iTxa7DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381606; c=relaxed/simple;
	bh=1Cm+x9l3kSskSs/UW4sb9g92h1B8TB0kkmFyc3GMWO0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0gs+W1iAENux7MvssmjME65ZrgYedlglX9tQhKpJKagDZP1KE9qD8mXoFMKNwhyrKhTSh6j2hdGRGQPiZLRz3A6NTqosbGw9AWkZvUZPoAfo+OwC3t5UIA8Xk/PZzh3MklMg2u8NEVsXS+/48Nz53Fo6ypZguGWkpK4aCx15OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akLWzHxE; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724381603; x=1755917603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1Cm+x9l3kSskSs/UW4sb9g92h1B8TB0kkmFyc3GMWO0=;
  b=akLWzHxEn7HqXH3dP2M95MwnMi+no/VdztJ4JRoTkQ6LG7ySmKuKRGbN
   QY7eiBHu0D7s1+zUzbGDEcl32AKKQDeEomSCuhfCy1XjteIi7EjOtanFM
   swmZGQrZVGKgBKd88vkZVvDJlP1TFmEYR8P+Ej6AbcW6j2AYlb5bgP6Ir
   ZxfN3Ah+2SumrfRoupur8XdfFZCd59m2hQ+nEH7PMs/7/C8y7towmclt/
   rWPdm6T+/CoH6KeDNtV1NL+Vz4bqY/R3/eaMKlZNASdxmRDzZ6RZTRXOD
   4ExUNaddenj8uD/pYs4GlV53jCDYhKYRd4JO01vE9/98R10fmTZpDMK5t
   g==;
X-CSE-ConnectionGUID: OhQjFlM8Snu+QGHnVDqb3w==
X-CSE-MsgGUID: Y5VYa7rlR/qDqr8z56DRFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22711703"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22711703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:53:23 -0700
X-CSE-ConnectionGUID: dRPyVmS9T/i7d9QEZRMvIw==
X-CSE-MsgGUID: iYzUhlmDSKK8FX3z2DUOSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61966035"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 19:53:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:53:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:53:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 19:53:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 19:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzDmjZX2sz6rIo9TBiXdd/PCc3PhRVKayRh6W3jJHQtmx3ld0eazqeWqHeoflf/LmHs9jaq3cfeZ0MObcfQcz1ntHfIc1II/zuPANG6x8qdWJzFAlm852aRSjN1ZF/i1QS7nBd2x6EfQTv0UKEKDxFOfV2riulNPlQk3FVigf08JaYoglJxzbwCLjXgNW/PJI82be8GWtLLY723dXbOxTdwxkFmvEcnHtaYJuwzSjlG/mHx5Lg1Vll8Dv5i9tX7KpWOmRe6968pO4CBPFPV9drO/qtS5dex6lwkXxaRJ5dNbkZaty8TAKFRebY1aLD5mqtHruPyJy8+QU2gm8gZzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RoxqT3GLzVINBifbhUbJujX0F6dQs70mgzikiB3+z4=;
 b=vxgwSpRykItN2PvJCPr+qCjX0gA6RItPZlEQUX6Bgpwflwpf+HQ6nsk6MiBrbWsHAWdISBYP32bvDeamb86VMNLOS6BY1Fpv6NwagzuRnbfheGckOmyAX1CY6/l9BCv+JGGg+HNbKG7TwiS4aN7ny/q+wj9tVEoYBdlF4vT9V5J9HHyGgH1t82UtZ7+4qnAvPBRWcO7scZ6KB1J8R+WpZFnCJK0+bOiopP6NzdURnbSduYTpS++scW17CZ4u8tBzYYLgKrHloidkV/mO2626H4mwZQQCH/BoeHFRd/AFfzrojEeBkyFsHPe6Kz7zS/k5u0CRvyE0LLooXZXQuq/IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 02:53:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:53:19 +0000
Date: Thu, 22 Aug 2024 21:53:12 -0500
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
Subject: Re: [PATCH v3 18/25] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <66c7f998ca413_1719d2947a@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
 <2d56b34e-64d0-4470-9e00-b14cd7b3af9e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d56b34e-64d0-4470-9e00-b14cd7b3af9e@intel.com>
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bd29ff-1b5c-4a8b-0719-08dcc31ebe48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2B4uD5bTvY+s8RNKVHw5xKPuNXm1+9BClNFanc3iQXN7jLeaPvyLibItf/Er?=
 =?us-ascii?Q?PgQy8kxZCYUxxJhae11Td849xCeUvJoALaqacM3mUX8YbkEKcJC8Y74U+m+u?=
 =?us-ascii?Q?TAslGZQZKX8jvCtp3R7XLXZkX0z/GDFtQHFQtSBeYghx3r/+qCEFUrB4/KB2?=
 =?us-ascii?Q?Fz7v/I8OmCOj7wEFi2imlH1Bo5rjNCGJyBSl1BJCP6SzYyuj+4MPrwEpP3OK?=
 =?us-ascii?Q?mkqIT6ShK/VXVj82X8APM5Fr2ly6rCXMQ0T1jawehxfdpTIQoJxwHW4dRjvv?=
 =?us-ascii?Q?/dr3dQG9Rbbvq7HzF3x06RB93t+ooOy01KCbp9kYY6n5vPBxIFF2HgLrzrYD?=
 =?us-ascii?Q?k41fo7LyaOKfnNgQjtmlH3SkbE+VD2VrQNOFJrirHUhTTWCl+RaaneHQ1Z5d?=
 =?us-ascii?Q?0CjlLoYTU6LsWdh4IsWMY18cFbcradO+qHWs4W1jlawZBrQrR71YmeB4dwKu?=
 =?us-ascii?Q?0/OUjv2cjKRJD+b9lr0wmc8gfTXMf8R12IsdQ+btEUg69/0U68nQ/qnMX01W?=
 =?us-ascii?Q?oXDD9wvyUZTi++515PVx7WiU5iDVAnFQG0mfelXD9feXhWb9szhCk0vYqdeF?=
 =?us-ascii?Q?CJ9aAiOz0/6OSxm1SYxjpWlLqf0msPH2NR4HbPBsrHTU2WrX/ULpyXckgq1w?=
 =?us-ascii?Q?09N1fK+o41p79t/qxohZjPXxhZmh+T4wyYG/VXd5BGt6xAB0wi+JZQ80N/M6?=
 =?us-ascii?Q?Si5RkSy5JmC6ckgE1eBB/BP9H8fhy+fFRwbzv/sLZF2d5Xqf+CQsbF4Vu7iG?=
 =?us-ascii?Q?IGELJS3ED0dxZwqPR+SkzbqZAUTpWak6pBORAvENRSK/TN5XMDOl4EvkFQwi?=
 =?us-ascii?Q?eT3CBEiccE7PqjmUufyZs8lNCXmmqNO4gExdAAlhB3YTsNKKLmrleAECd2yi?=
 =?us-ascii?Q?l7MDYjP0l4niCxmwHLKUa6Abo2/a6nYqibe0ifbb6XXPmkWP/chpJOh2KexB?=
 =?us-ascii?Q?8kqgsJIWwa9bLsSaCXKlAKpjKfzvWvRlP2K6MNXcTyhD+UzVryczhV80SwEo?=
 =?us-ascii?Q?dzPTXZaXCSaUPaj4YeKhUgabFPcDcCmbZp3HKXi6kJceCoV1CSUW5701Eygr?=
 =?us-ascii?Q?mktFepGlCtGKlS1IQb0kzWVTp6jlfAlvW4pPeKTiAILLVL+zCl1FvJkY+gIc?=
 =?us-ascii?Q?d7xAkpxGbFfdYqT3qZg1czkQUGP5zgPdxZHwavssorBGEaVD5kpeXc3kbR5F?=
 =?us-ascii?Q?/OyVMHiMLg4LXi6frP2x02LJoOE24aC4Y116LX752lgu4e0vubEOiRwJ72zA?=
 =?us-ascii?Q?HVl2m3GVcxcMG1pEbaix6ruUl7fUI/xW7PcuFjRbIooY4AOtDqLsFNtOtQty?=
 =?us-ascii?Q?PwoxOKYhSJ0x4bLHLDsZt9qWyN/UI52DIqPw0Z156jdGzLEr/pewQGULNxB1?=
 =?us-ascii?Q?R45s+0I8WUXjl85ZZZ2J/xIiaEVm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hkPLtWZLC6CjucSRehv2B4Dqtn3QQ7o6fpOZW9sp5cwPSIVQJ+FZ3naUCLNU?=
 =?us-ascii?Q?MebU8e6Ujeqx3ngXB54TMFJVr0IgyGHHm29qq7dCBqorndFnM/uEUMDkDCVT?=
 =?us-ascii?Q?QDKHPkyS/RUJILrrki15V5ZYc7Iijljs90FE50KNhqhM3bXBcQs42Ke3gOgM?=
 =?us-ascii?Q?79KlgTWOMZPqmkzfV2TorJtv9ozKgDJPOL5nsVDOQ2u4GT6mSQeOiLz2JrjH?=
 =?us-ascii?Q?oaCaQ0TRPX9LyVk+gCvX/ymxHqP70NZBuLVAT5K9daoDjknAodTc2ruKxe1Q?=
 =?us-ascii?Q?ZH/H67pH0P1TIbY+tEMweuMRmg1b58xolTZMMWYpyhogveq7T3/eCETKu7yu?=
 =?us-ascii?Q?IMcOIcEvoqhIhxG7Gam/BgXYGUGnpT/dkg9REbvnLvN4mfAoAN93EVacuJX7?=
 =?us-ascii?Q?sa6U4RW99LurxDFn6j7YFCzx8npxe+kB93IT5RrKM/uILQqf62kfJnoklrIE?=
 =?us-ascii?Q?uTixt4xvdRlXDoHZfjIv2Wde7LgOx/Pym6RU2GTW0IReQbTNzpyfIxFmXxFT?=
 =?us-ascii?Q?ZNb1jcUgprWOfk6AUYpZBBukPyyUzhYZw2VXT713A+UmCds9i9kd86RqiHEM?=
 =?us-ascii?Q?9ZcK2m+FAiIijl9UufzZnH3DK+aNjmcuAQYoAC4lfShA4L0Wp10h0d/Lu9ef?=
 =?us-ascii?Q?6l3zBoD2GWRMYL66wkrWwe/mjDKei0kXTcbCJhCFbRLrFHUBrFUhvLE4l29B?=
 =?us-ascii?Q?IrDGYlNgVUzjiysSRQ0Nu2aY4cVqHftdUw4G8jLZoa9zIIChl7X6dmIaYNxR?=
 =?us-ascii?Q?ASmFe8X1bm5oFSRDx4pKZAgqy7YU/0ipzf7F27Tlx6jfvcUMJljS0knADbW+?=
 =?us-ascii?Q?xBDcgDC9DUmtJ8NwQmh6M07n9v6rxvoxLj8CnlieGonTCE5cceEsgecw+7Qy?=
 =?us-ascii?Q?NQgG2wohTmZmUSlaYNzv6IvVfwK5WLwDnG4SlplYAa8uYropqGXVFYcIIs/P?=
 =?us-ascii?Q?GIudMWZNB/+J5QoLqbdJIeP7JONFM58EY3JEPDf7LiKgP9CV/uLSgnLvBXm5?=
 =?us-ascii?Q?FWstc9/fLvqlt8EqtPdVLjBhMs5zbpdhxCYDOWRcZWS8zFS35Doxt2ut+ghN?=
 =?us-ascii?Q?6001TIYr0T1QvRoa4Pogf2YcqnbwFzdjtPcLqX6Wr1p0iwpGxXxXPzRZu4m3?=
 =?us-ascii?Q?7hUZ+P3TDjaKniF2X3ABuYqb4ViywPTTqhbsFnwz7uotpwQqD9PJ9UO2Wvhm?=
 =?us-ascii?Q?j1WGlg0diPAI6TxWjcHgSCHHfmGesxNUeEUZk5OxOUjo0/bgxX2S3gGmRbQf?=
 =?us-ascii?Q?SCH6K+mqP0epzc7SmP3VOT7N48yidgjsnAX9xkyV7waHPSvctgVHjkDik3hv?=
 =?us-ascii?Q?8k28K3USwb8uRhn0WaLDeq7YqWFSl9cxZl3mk6bD/a/qgw2tdKk0XfF1YQKD?=
 =?us-ascii?Q?t8bRQlAUxnqwzz0uKzyGncMEAygTi0Rcjw4FuDskBp2cTEUAlt+aMRdFOOgl?=
 =?us-ascii?Q?a771XHHznkje0CV6eGpgdwvCcIjryLcPZA/G3wiR/c5Cs7PUoYPPo8u2os6S?=
 =?us-ascii?Q?+ZuMq+l3PV1FKMj5UnSn3jyFJEZnAjy78RDxsQUyz1LF2JNSnl6wTXu4JT73?=
 =?us-ascii?Q?lQ2pz7icWWF+EPXulBPWn2c/RxK9dTcfjgVBdEsi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bd29ff-1b5c-4a8b-0719-08dcc31ebe48
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:53:19.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6Jiu1vG1oXCIbuyzYoRllXchbAPaiEdnAAl8bDi5pn48MZQ/6o9Vxr6qze4E0/v2SgmvjuB1iGNHVZhw3Fu4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > 
> > Process DCD events and create region devices.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> A few nits below, but in general
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks.

> > +
> > +static int online_region_extent(struct region_extent *region_extent)
> > +{
> > +	struct cxl_dax_region *cxlr_dax = region_extent->cxlr_dax;
> > +	struct device *dev;
> > +	int rc;
> > +
> > +	dev = &region_extent->dev;
> 
> Nit. You can move this up to when you declare 'dev'.

[done.]

[snip]

> > +
> > +static int cxl_add_pending(struct cxl_memdev_state *mds)
> > +{
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_extent *extent;
> > +	unsigned long index;
> > +	unsigned long cnt = 0;
> reverse xmas tree

yep.
[done.]


[snip]

> > +
> > +static int handle_add_event(struct cxl_memdev_state *mds,
> > +			    struct cxl_event_dcd *event)
> > +{
> > +	struct cxl_extent *tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> for readability I would use *extent instead of *tmp

sure.
[done.]


[snip]

> >  
> > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > index 0bea1afbd747..eeda8059d81a 100644
> > --- a/include/linux/cxl-event.h
> > +++ b/include/linux/cxl-event.h
> > @@ -96,11 +96,43 @@ struct cxl_event_mem_module {
> >  	u8 reserved[0x3d];
> Previous code, but 61 would be better than 0x3d to be consistent with rest of cxl code

:-(

I get the rest of the code argument.  However, the specification uses hex
for the number of bytes in the definitions.  For this reason I prefer the
use of hex here so that one can better match the code to the spec.

> 
> >  } __packed;
> >  
> > +/*
> > + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51
> > + */
> > +#define CXL_EXTENT_TAG_LEN 0x10
> > +struct cxl_extent {
> > +	__le64 start_dpa;
> > +	__le64 length;
> > +	u8 tag[CXL_EXTENT_TAG_LEN];
> > +	__le16 shared_extn_seq;
> > +	u8 reserved[0x6];
> 
> Why not just 6? In general I find it odd that this header uses hex for
> array indexing when the rest of the cxl code uses decimal. 

I was just directly matching the spec.

> 
> > +} __packed;
> > +
> > +/*
> > + * Dynamic Capacity Event Record
> > + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-50
> > + */
> > +#define CXL_DCD_EVENT_MORE			BIT(0)
> > +struct cxl_event_dcd {
> > +	struct cxl_event_record_hdr hdr;
> > +	u8 event_type;
> > +	u8 validity_flags;
> > +	__le16 host_id;
> > +	u8 region_index;
> > +	u8 flags;
> > +	u8 reserved1[0x2];
> 
> also here, 2?

Same...  I know it is odd when the hex string == the decimal string.

> 
> > +	struct cxl_extent extent;
> > +	u8 reserved2[0x18];
> 
> 24?

same.

Ira

[snip]

