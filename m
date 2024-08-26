Return-Path: <linux-btrfs+bounces-7522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9F95FB88
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 23:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EAD281EE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7B319CD04;
	Mon, 26 Aug 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/PWjBmo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E219B5B8;
	Mon, 26 Aug 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707087; cv=fail; b=UQEUsaGJIZC7bRYLqWsy2DHBDPG2ide8o2dx/H1866ho4FXos05+vwrYTzBKVdcbpAlS0X2u8/oLRx0P9ZMVh1LRQubMdOsKraIkFA6li8c9HprLBF5xymcO7Zomsc1R+CWs3+oa3oreGmWgPg66FdO8Sfn/Ky8lJsuPSTNoyUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707087; c=relaxed/simple;
	bh=Zp8hDR77vLE6e+ydJJc8yl6Lw2k61vb0eudH5YrSrC4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bnxlyy++JqyvLPWnHWguTS8sQ2r/VdsR2GwSisaJB3VgTWj+YXYOY+YRBIwYOMJv6lNrtcp4DncnNpvOFPFDSP7z4AlgGdaT133ZsB04G/7geXG/rHJ2zlqYxqbFjPHvVouvZytIIIOPp38OjZoJcXn+1JNNtFF7QKiNxsdPJtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/PWjBmo; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724707085; x=1756243085;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zp8hDR77vLE6e+ydJJc8yl6Lw2k61vb0eudH5YrSrC4=;
  b=d/PWjBmoR/wacpkseaR9pI9aaG4jdFRnMQdY/j52Pbcg1kMIR+VLOgbd
   DpuNY55BWxBvDWUiOGafrfwhKX1Z6I20nzx9fPFYkZZob7VxErKkcKuUX
   VAZ+tLwzpPYfp3MavXV9bsdvtwHCF1YQKuWUkkfzFfz/D/9KULSScYKU7
   PPIxXUYfDI7Y596UDnWPN4Fjju0T7yNOHLnkVNPqacBU4iQqD7pKw6NKt
   r4SDt/22mPteeVNDjF8NX1mmF61MDp8A5WS611Eg6887irNr+mlVLuFg4
   UBQaBPKA7C8too4QyQDRDzWTzll4YwG6sNIhTLE3f0s13/G/dXEfTry3K
   Q==;
X-CSE-ConnectionGUID: D5t3+XSZSoi//WhiVWQQZw==
X-CSE-MsgGUID: fq5OJfEzTr+4ucxLV8LL6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33723791"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33723791"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 14:18:04 -0700
X-CSE-ConnectionGUID: gncHfAjRQ6qf+x00/ZmaVw==
X-CSE-MsgGUID: ZHop241mRG2LZe2aRUXm9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62688128"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 14:18:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 14:18:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 14:18:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 14:18:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 14:18:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh5NiiaM4Gup4SDYcSbqvXDnhe6bjhjmm+Rg4tx0VGiBaBaS7RLVqzloVM1ZTCuWNQRRfXciWYr3kv42oVY/ZFIq6vbD3Oc5jmnFN2wclliolkiXFtoluDdw/e0zzqE/5YzMi37N/Sm3TyumxOXGqgETd9faBzGXoCMLW++KWOieI+nYlpxjOLAkMVb7IXcRYgibCG6RkaVAjRksbVifC4mxZhxVDrM4GNBTNkX2lPtDjWRYCdImMePenSpIYK6qEy+kDNa+ORXfGUrlT/htM2uikCw+XKQhCu5mxH4N1vms0UfYSxGoPUrEXF5lxXf+EUE2LN0tMp8SVrlyfgCIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEHbK3fyjoviV8o13LUHT/TMH2HWQjJ1of7XT7p39as=;
 b=Le6o6vOBXQo+V4DBOxdlcAu00mDnLoLFgDlusmnkskjMD7ZvXEYW27QblZ2/AEunqtOmHlV6eqj6Mx28BozjRGhBkTLpaE5LPOkWDjqdr8gkfMg5xRlScfujLz0R+hKHOUHHLEafpcxPPgg+E5fwrxZHNtDWQlKqIS/vBRqJ+9sM3qhDaauU7tiMzrt0EClee2WYjAvIO74YTxGIBem689Ju9suAK8O2aEnvUuOmMecCyV7b/j7CICGmr9PBoK9TB+9fBnntoKcBaQ2NXCSwb4nNO0q3vi9/zcKpBDPvmadQ3AoG/kCvTM0Z7qTQZavc7SxOT3LLrhpVrb7xxkCuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 21:17:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:17:58 +0000
Date: Mon, 26 Aug 2024 16:17:52 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek
	<pmladek@suse.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, "Josef Bacik"
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <66ccf10089b0_e0732294ef@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
 <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
 <Zsy6BbJiYqiXORGu@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zsy6BbJiYqiXORGu@smile.fi.intel.com>
X-ClientProxiedBy: MW4PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:303:83::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 6257a798-c5fd-4530-3903-08dcc6148f34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X6VXg+HkZ4dVJJ5ieQNaQVMxHn6fwX1g0OGsKY8xdJS8pW9BxcES5rM48JE1?=
 =?us-ascii?Q?7jms7pX1EgVxWuRSC32JiqMEA6wLgmomw1lBgPSAwyFN7qwqJIMXPUe4pfZA?=
 =?us-ascii?Q?UhOwlVKehqhrmTkcBc9JkLtPuk2eeY2CAnUMZxrh4EMEMfiHoaTh+CMpcsTF?=
 =?us-ascii?Q?nXhUcQ4DZLQDSw4rD+8jxmiZaeT3NSLuAXP94ByTgRillSeuzEEFSLT+SHzW?=
 =?us-ascii?Q?XNG6KaqiHBVT8h94cRUGsAM61yMuRusZ7d64AS2rGvYWcd3ovWiRjA996Etg?=
 =?us-ascii?Q?D/lFPvR9gfIEDibONrUYaqXj/rH7cKzlY3UGhA8hRLeLPduhBRgQ3XSHZ9Wf?=
 =?us-ascii?Q?HysH8/tgHjEBimm/SMeG7A5xOljIFdXeQZKPR6pSvrGay9Sp/DWgwOJylKWK?=
 =?us-ascii?Q?4avHWm+UGNCZDVAz8ML1oUCqD7Iz89ZHAIwnJXvMp1awQlh6hblfWPRiTSY4?=
 =?us-ascii?Q?wlOcf+w02ry3tgTtQ3vGXOTni70erYku87UxmjTCjZNNl5Dx7+MrqMx2a1SO?=
 =?us-ascii?Q?IysU0fa14iwttn1YSiFaeETwVMAtjyPDEwF+clWG+Y8jotg23ZC5Pf0HJcnr?=
 =?us-ascii?Q?PJwr0EBqPvSEAiMAGjdgC0PaEly7Ob0i27RfjDvJzoJifUFXbAwuEqTexElW?=
 =?us-ascii?Q?UfeKqXsp8JXBbWSHXa/wOieHRBXpjZQAPWCO5mhJXq9eY4kN6tYGdX7zqDvU?=
 =?us-ascii?Q?nc6qdtHn5d7ZR7RsIQDvVqusI4EbEzDkA6XPxiJN/qfVyLsraJ7J6igkuHFY?=
 =?us-ascii?Q?tTyiGCC1sO31RKNDESe3NFK1gf8nGolG570eEA8ArH7ldL4Dw0qSXZgCQJP9?=
 =?us-ascii?Q?Yo81+6zWAfTPilWOGoLfLjco+AM0Kb3MOMFKHMIplkpm+KmVNcvwwkyJrm+B?=
 =?us-ascii?Q?bdJSETmE0BMDQZBahgHgojA8tWOuX02cZLnQZRMK5VqZRi5dQdD1WhZB5lzE?=
 =?us-ascii?Q?e9PtpElAnnWvSIp1vtFnPwOwK/oBjEBLuxovrn14s9ahT/6CCja59sj0nCJS?=
 =?us-ascii?Q?P4RJE86aDJpzcSPDff3tYSZHS4Ju48eLQ7DvgCetCxNU/sTUUkUQaXPbu74/?=
 =?us-ascii?Q?44bwT9vRiRsyA77gOUZCnqX5or66LeJoISPBpAcd52fPWMGCmJtXhYFPoIM+?=
 =?us-ascii?Q?3uy+Vcc+PO1adWeTMWyDgEq6NuCN16xuXZGRQrWY6uMNsibo0A1dfEXmB/4b?=
 =?us-ascii?Q?B8YtjjItjtE85cQ+zaWjV63nT4cBCENSC2On8TbDhHX/5cyzWJRl3zdmdFOY?=
 =?us-ascii?Q?i9wpt1lIP9arbnwadSLXltcE5k8uX+iymQ3S0uTzTrjMQyGDJPZ6h0a6wD42?=
 =?us-ascii?Q?un9Q+rVSem4zuJAkVN4sJZjjhPTaOEJvXLRbkH1tQbCTfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErAzTQXdbovt/ykPy6oyJC96vawD6rfRxO+VZ5wrSV/bc9EFgB1B3FruX+mn?=
 =?us-ascii?Q?fZvdIM5th03Vu1kZQ7GLyCbSY71s62XOrg2R2nRqBq7Hn7ds+YRtMnCtnf+p?=
 =?us-ascii?Q?j0rRKEElt45dP3Wifbm0Y8sdoozIvR2eHdkFyiXwBwu7aRtlb/OEM/aXNTt/?=
 =?us-ascii?Q?Sv9zYn93iL8s5YKWFKz5/aQyqZIo/HWbKkERRvUCCjHImNlQWXpdoKFdUlYI?=
 =?us-ascii?Q?LhPrycY4yDzQlg3+fVqUHbrE3CrnvvT36ynEKQ5olYcOhvteinNtLmozATiD?=
 =?us-ascii?Q?/TjmONXMaGwQCRoP3HzGqCzrGhCTzypqAbcmDOeN+3VaJmBGJhHmF1gbV3g6?=
 =?us-ascii?Q?hpNwRXCKua/ihQDF4fwPTz1f0T3QmZ7jZ2d7zVf4pMkXL0C+40zEBUFpNENE?=
 =?us-ascii?Q?4i4D+aYD3a9o1vHYr0QL5oevtajIVJsQp92X8Ts0AezB/sW9UJxElMvzybvz?=
 =?us-ascii?Q?EhIaf7A5uUfDtbbpakjmWFg2Tcsv+E12Z0RqFysP1jxaoPnAHxJYV0XxQM4g?=
 =?us-ascii?Q?W8TuQdyCOx//2PaOu6s4fhPMjMZuFOGNOgSydPdw/S5KD0RJSqsAa6tTIJ2y?=
 =?us-ascii?Q?LxXrVeJin9F0qVsnofPkRQyhlQGDh9Z544H7auD1vDyuViL6AEIhAlgywSBK?=
 =?us-ascii?Q?8J3wkwn/YJAPAXoDgWOWPQ7emBdENKZgwdyEkcIYH/WRiCbxgyC9BVcoXXeX?=
 =?us-ascii?Q?EKGgoOgmNFQ5yFbfwGXRCHdVL9jM/6SersyV5sTHPTQ28ZA3lJhzV/h4ZRcV?=
 =?us-ascii?Q?CW1dksc3SzmHwfdJNdM45hvjatAAWv5gC0rNJUl0aLKQ+bCh9HhhvHqYyFG3?=
 =?us-ascii?Q?+bNg4KI/sxrQiaWBBqHWLFTB8pW533PeD47U9UuXQrbfhMNmXXC+DeBzwIYT?=
 =?us-ascii?Q?6xjflQDP6rvKmX4bYm9Pc1Hl4L8lcEaHTTmVywEEqpcT/ymI+M90rEgOX4cg?=
 =?us-ascii?Q?3G8kbpFzaK+hO+++D0OITW8SddaFozKGw+Ybo0jyj/A51dpzFoJGU6dfdhbj?=
 =?us-ascii?Q?NR5HZm/J65lOgxf1qipnAXJsn/xEKYO7iHYPOh1P9REA3zvpkeifGPRSvvhS?=
 =?us-ascii?Q?WV11dVCSh9UV6g45q+NNbnPXsab3ugO2ELd3PgvQ4+TEcPqZS3RI+/z8hKmn?=
 =?us-ascii?Q?Dj4SXYaDDmepT06VpRNJeS9NWgXs5M84FrT86BGoNICiOnbLcgxlYeOY6ZLp?=
 =?us-ascii?Q?9mZunohDf0nYEsiJTkHDeKJFSfaoJ7xdLu5VBTlDuQYzqDUhbhKfhpSB/q//?=
 =?us-ascii?Q?63pyeBb92SwfNPSQNl17E4GxNjSKwReIAY8Bel2tyOESG1WULz19IIYnuLHT?=
 =?us-ascii?Q?+S1dfXxGblS7IoH4gqjkkvg/yJ7AbqkbILwejppAVCz9cdDpOQsG6NlHv3Ll?=
 =?us-ascii?Q?xD6ds4lV3tcncwxScMbUpIoG6d/66sUOczufnEsNpMWQzSSsI+vpZFzsZXs3?=
 =?us-ascii?Q?Y4/DSFuGgqCz/s0fbTYnmt1RspLxlt5zYBnO0E8PsZY+dv7d9IxgMMbL0S3p?=
 =?us-ascii?Q?sm0rCkgAPMeveTdCqxh273nBirPcOIcLir4yaBFb3R9ZW7WnQMKlMR4qx/Gl?=
 =?us-ascii?Q?4xOfxMdwV79u6Xfeh77YrIYqZAOV8q3H3ZzF6Vvu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6257a798-c5fd-4530-3903-08dcc6148f34
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:17:58.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1ObbxcewKCiEFBLQSn6euvt19JnuJDqXSYUE10hC8s9BZYjI89Cn103Yefbb+hlNYsoHReLU6XkGww44z9xaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Mon, Aug 26, 2024 at 03:23:50PM +0200, Petr Mladek wrote:
> > On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> > > On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > > > Petr Mladek wrote:
> > > > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:
> 
> ...
> 
> > > > > > +	%par	[range 0x60000000-0x6fffffff] or
> > > > > 
> > > > > It seems that it is always 64-bit. It prints:
> > > > > 
> > > > > struct range {
> > > > > 	u64   start;
> > > > > 	u64   end;
> > > > > };
> > > > 
> > > > Indeed.  Thanks I should not have just copied/pasted.
> > > 
> > > With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
> > > to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?

I'm speaking a bit for Dan here but also the logical way I thought of
things.

1) %p does not dictate anything about the format of the data.  Rather
   indicates that what is passed is a pointer.  Because we are passing a
   pointer to a range struct %pXX makes sense.
2) %pa indicates what follows is 'address'.  This was a bit of creative
   license because, as I said in the commit message most of the time
   struct range contains an address range.  So for this narrow use case it
   also makes sense.
3) %par r for range.

%p[rR] is taken.  %pra confuses things IMO.

> > 
> > The r/R in %pr/%pR actually stands for "resource".
> > 
> > But "%ra" really looks like a better choice than "%par". Both
> > "resource"  and "range" starts with 'r'. Also the struct resource
> > is printed as a range of values.

%r could be used I think.  But this breaks with the convention of passing a
pointer and how to interpret it.  The other idea I had, mentioned in the commit
message was %pn.  Meaning passed by pointer 'raNge'.

I think that follows better than %r.  That would be another break from C99.
But we don't have to follow that.

> 
> Fine with me as long as it:
> 1) doesn't collide with %pa namespace
> 2) tries to deduplicate existing code as much as possible.

Andy, I'm not quite following how you expect to share the code between
resource_string() and range_string()?

There is very little duplicated code.  In fact with Petr's suggestions and some
more work range_string() is quite simple:

+static noinline_for_stack
+char *range_string(char *buf, char *end, const struct range *range,
+                     struct printf_spec spec, const char *fmt)
+{
+#define RANGE_DECODED_BUF_SIZE         ((2 * sizeof(struct range)) + 4)
+#define RANGE_PRINT_BUF_SIZE           sizeof("[range -]")
+       char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
+       char *p = sym, *pend = sym + sizeof(sym);
+
+       *p++ = '[';
+       p = string_nocheck(p, pend, "range ", default_str_spec);
+       p = special_hex_number(p, pend, range->start, sizeof(range->start));
+       *p++ = '-';
+       p = special_hex_number(p, pend, range->end, sizeof(range->end));
+       *p++ = ']';
+       *p = '\0';
+
+       return string_nocheck(buf, end, sym, spec);
+}


Also this is the bulk of the patch except for documentation and the new
testing code.  [new patch below]

Am I missing your point somehow?  I considered cramming a struct range into a
struct resource to let resource_string() process the data.  But that would
involve creating a new IORESOURCE_* flag (not ideal) and also does not allow
for the larger u64 data in struct range should this be a 32 bit physical
address config.

Most importantly that would not be much less code AFAICT.

Ira


[snip]
<new patch>

commit a5f0305d319eac7c6e480851378695f8bd42a3d0
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Fri Jun 28 16:47:06 2024 -0500

    printk: Add print format (%par) for struct range

    The use of struct range in the CXL subsystem is growing.  In particular,
    the addition of Dynamic Capacity devices uses struct range in a number
    of places which are reported in debug and error messages.

    To wit requiring the printing of the start/end fields in each print
    became cumbersome.  Dan Williams mentions in [1] that it might be time
    to have a print specifier for struct range similar to struct resource

    A few alternatives were considered including '%pn' for 'print raNge' but
    %par follows that struct range is most often used to store a range of
    physical addresses.  So use '%par' for 'print address range'.

    To: Petr Mladek <pmladek@suse.com> (maintainer:VSPRINTF)
    To: Steven Rostedt <rostedt@goodmis.org> (maintainer:VSPRINTF)
    To: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
    Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
    Cc: linux-kernel@vger.kernel.org (open list)
    Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
    Suggested-by: "Dan Williams" <dan.j.williams@intel.com>
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>

    ---
    Changes:
    [iweiny: use special_hex_number()]
    [Petr: Update documentation]
    [Petr: use 'range -']
    [Petr: fixup printf_spec specifiers]
    [Petr: add lib/test_printf test]

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 4451ef501936..1bdfcd40c81e 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -231,6 +231,19 @@ width of the CPU data path.

 Passed by reference.

+Struct Range
+------------
+
+::
+
+       %par    [range 0x0000000060000000-0x000000006fffffff]
+
+For printing struct range.  A variation of printing a physical address is to
+print the value of struct range which are often used to hold a physical address
+range.
+
+Passed by reference.
+
 DMA address types dma_addr_t
 ----------------------------

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 965cb6f28527..2f20b0c30024 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -388,6 +388,25 @@ struct_resource(void)
 {
 }

+static void __init
+struct_range(void)
+{
+       struct range test_range = {
+               .start = 0xc0ffee00ba5eba11,
+               .end = 0xc0ffee00ba5eba11,
+       };
+
+       test("[range 0xc0ffee00ba5eba11-0xc0ffee00ba5eba11]",
+            "%par", &test_range);
+
+       test_range = (struct range) {
+               .start = 0xc0ffee,
+               .end = 0xba5eba11,
+       };
+       test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
+            "%par", &test_range);
+}
+
 static void __init
 addr(void)
 {
@@ -789,6 +808,7 @@ test_pointer(void)
        symbol_ptr();
        kernel_ptr();
        struct_resource();
+       struct_range();
        addr();
        escaped_str();
        hex_string();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2d71b1115916..a754eefef252 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1140,6 +1140,26 @@ char *resource_string(char *buf, char *end, struct resource *res,
        return string_nocheck(buf, end, sym, spec);
 }

+static noinline_for_stack
+char *range_string(char *buf, char *end, const struct range *range,
+                     struct printf_spec spec, const char *fmt)
+{
+#define RANGE_DECODED_BUF_SIZE         ((2 * sizeof(struct range)) + 4)
+#define RANGE_PRINT_BUF_SIZE           sizeof("[range -]")
+       char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
+       char *p = sym, *pend = sym + sizeof(sym);
+
+       *p++ = '[';
+       p = string_nocheck(p, pend, "range ", default_str_spec);
+       p = special_hex_number(p, pend, range->start, sizeof(range->start));
+       *p++ = '-';
+       p = special_hex_number(p, pend, range->end, sizeof(range->end));
+       *p++ = ']';
+       *p = '\0';
+
+       return string_nocheck(buf, end, sym, spec);
+}
+
 static noinline_for_stack
 char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
                 const char *fmt)
@@ -1802,6 +1822,8 @@ char *address_val(char *buf, char *end, const void *addr,
                return buf;

        switch (fmt[1]) {
+       case 'r':
+               return range_string(buf, end, addr, spec, fmt);
        case 'd':
                num = *(const dma_addr_t *)addr;
                size = sizeof(dma_addr_t);
@@ -2364,6 +2386,8 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  *            to use print_hex_dump() for the larger input.
  * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
  *           (default assumed to be phys_addr_t, passed by reference)
+ * - 'ar' For decoded struct ranges (a variation of physical address which are
+ *        most often stored in struct ranges.
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)

