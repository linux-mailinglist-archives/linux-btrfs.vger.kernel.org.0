Return-Path: <linux-btrfs+bounces-7671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F2D965220
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2061C23619
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A051B3B1D;
	Thu, 29 Aug 2024 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSKj6Puk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12B1B3F0A;
	Thu, 29 Aug 2024 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967503; cv=fail; b=b09I/xgTrlsBN9S84cY16/GsCjpnKw8abCQWClRXNP+oMGtivndLaimi1F29ZeexvMGiG85clSro8i4cPBchvOrBVg0gUqudcH9vwfFa19qDa/adKWMmaA8RR05sh1mxwHE6gvTcob8tB96IAUkZFVftlF1K1UjxfKOReEWuTHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967503; c=relaxed/simple;
	bh=xN9HJeYlNpvZjLsVymJ40NheJuwVdmexivPHyEItUfs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g9aCOEWWHhrI5rfT16gG8eD3chQKpfjcTapnZVB1gLinzcqL2x24y1uKLPemM+hcp2uKYHQp0qwi0csirAh+Qb3N2O/jXXjiyHqUKCpNoJMbGrqB/loF4QD51PauFVZB0d7MIdY9ghTNET5TBnQNOL8CGjaW2iHx4qbMtilk1S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSKj6Puk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724967502; x=1756503502;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xN9HJeYlNpvZjLsVymJ40NheJuwVdmexivPHyEItUfs=;
  b=XSKj6Puk9+giUkSOS2KUeFozf5zjCw6UvV5tbBE6pSVkApK796OWdRpl
   MQlkCctbZWuIMlm/UWhNc5LLk+EFqcI3XhAZcnleneBkG//dXbfIa5SvE
   rMDfXmQt7ZRl1L+wubEUfSLk+NKdVkYUsxBMT8492qsF2FDYKEj5Juy/A
   NJYa9Es7VJlWycf99Shr5igEtbhnEqf8B8KJGz9Jy0Mf6ZAxd1EZt+dZx
   xj2Da4xi3wK4TVrx9iBGXvtzaYhG4gQhSGjJFR5bUitIStXxA+PEMjOUa
   5M5nOB4Wz4mN5ZPpn1/lT8QY0xi7D8hrUER3c7jdGA/gjxfjlh+5BWlnS
   Q==;
X-CSE-ConnectionGUID: DAhGjjuFRnajHkPpKXToXA==
X-CSE-MsgGUID: NAU4B17wRQabpBVUbUBHlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34211971"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34211971"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:36:57 -0700
X-CSE-ConnectionGUID: YX83dVt9RZ6rA8d5uosygA==
X-CSE-MsgGUID: T+WgSTtNRKWOyDyd16lWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63699628"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 14:36:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 14:36:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 14:36:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 14:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aANxnNtTatdu80qdpHIqPj6hEB+NNgLkWcO7V+n8YW5UkbjMn8wElSRVcQm7rgdgG08SC6ZgXfeudRqWde7qLHXSNg278nMxEsRgBZq6vBFtBkQRDZ0zwIU4SO0ixI+ktVmZ859Mx+MqO42WO6LHfgUElUvpWGloAjxQeWaX9Mxu1bDTWV/ykXyLVynEfYNFEcZRyLONyNGfUyamTFeYz/TEkx8OvGyudFsFdcqXJqqdccHNCgbmnL+wujQT8a75bSzJQCX69izithZDqCy/SGJck0S1SIGYNIOm+eXFMobbkfZs0/O6KsjRnpx9nT3XmeCuD7WAhYDB5JAQ+ynb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIh+i0BTiNETJfdm0feCR6RryEN0uCdcOR3MmDOnAns=;
 b=tVXPBEf0OXjujEUjY3bPbpW+PjUFjR1hModdlRIMYcL/QkwA5lNqpd5CjIi1vIjrWDk2fSvWTvRYVRl0C5HnFJF9WGtkFZRV4QsuabAz1P3SfLYmJOXfuxshcBvkxLsgJDIp+Y2/TC7ZjxCon3FkEmcgP4cZay3QPSE9LarH5D0MoEY4Tn4sUVO0yuxiTCpHMiwfILrjEpsnratk6Tqhg9AWt2ZA8osYlTu0lPwOKkWVZlEbTJXR2U5G/3qK4lIyjdWDF9+6f4Tks4XUjl04EGLToLxiChT8szZOEc69o3ZFL1YWxu8JacvGnFcaieEX62bVWNX7s121ypH2ep2OfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:36:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:36:46 +0000
Date: Thu, 29 Aug 2024 16:36:41 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 20/25] dax/bus: Factor out dev dax resize logic
Message-ID: <66d0e9e93aab4_f937b29446@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-20-7c9b96cba6d7@intel.com>
 <20240827142613.00005c91@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827142613.00005c91@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7816a4-1051-44fd-09ba-08dcc872aeca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvNTK8oPHfY4SRpdRgswJTrg9RufVQQMvvpeVniDm2Rfbq25SIWvg/wv+w1f?=
 =?us-ascii?Q?ItalFf/LjwIIfR1kSDAk88yxUCNavI6xkoBevhFSUXnxiQ6O5RYri4NcR1ov?=
 =?us-ascii?Q?cxhaXJfvZFGz9Jm9rY8X6u5SdfXrJrFz+b8Pv/4HojzM8FaRBr35CJO4mt/U?=
 =?us-ascii?Q?g2GWIP1GJ4PS60wm0xSI8RVDweQ2reuv96oiokLetKEjouz+FvDHEbU5VASJ?=
 =?us-ascii?Q?A3MU1dXH+JsKMMB3UURtPgOE5pD9WrnC1C+i8Si216I6dxscTPwS795TaUDf?=
 =?us-ascii?Q?2Eap6/kayWBEgfSBIW8OiDWdCvnrZ5R+R6pC9Op+oGc8dso0qh/8Iryezupl?=
 =?us-ascii?Q?rIqvShqXUaUDBcSbLpzT7+VgoKU+h7ZDfgeoG1BEml9Cpq4QXwI8ktoXsRD7?=
 =?us-ascii?Q?klKg7l3rkjsdRDaN7rdb/+P2VQsMu1sOe5dcj24JXj4n/I1TkWq+uykjw+gG?=
 =?us-ascii?Q?fJu5nkbRalL0IGCAEfUSkwtaNrLBANeQarfC8y6Ce1orepLRdOkg0ooyYgbG?=
 =?us-ascii?Q?x0DnVKYOEN3YZVIAZw28FA5mABC3eQLQcLFsUjrjJq1QbXKyZa+3fV7syR+u?=
 =?us-ascii?Q?FEc07fAnltk3xIGqjx9HNmD5+/lh+9JMxgjZeiVGtA0x1tNbKVg8zY0fbiDA?=
 =?us-ascii?Q?FHcRpaT2qAnWMW+QiAmRgwfWdUSobRdo11zS+YcIrjSBYPqO+MPP/gUHrvVd?=
 =?us-ascii?Q?tt1FjBIb1gh5M41yd48Tuu5sSqqx4Uprasej6QKvOkc86Ufpg+PVkC2UyOAl?=
 =?us-ascii?Q?/blzv+1Y/o2aw+vqA1B+dzzIjpphaPjx1i4quft72HDL+X7rUQomm/ZqKnq+?=
 =?us-ascii?Q?0xc1mdX/bJO1cHaL2iYDQDkUH7HbZ3YXpRTPLx4fFUayIU8rWRcDyqZIwnVZ?=
 =?us-ascii?Q?wYQda/Lh0o9oMr7Zv1zqKEMDqV+rdtSTwp43fPHVJn6fGClPFgj2Ln8dGMqz?=
 =?us-ascii?Q?6ddKq8UinfLKxFn2TxBzETPlAkUZxqQG1T+gm5yDFAm/yU1Hjo9+BEbf3d6D?=
 =?us-ascii?Q?lm8drj2FxpCh044PKMOZf3jclBABy6xS5WD5mQfPwppqTbtp1qqFjHey2quB?=
 =?us-ascii?Q?+b29mU2Ee6hcwEONT8A4HniJ5FPYi4awviYVGQoohkYBKE2kVLgxK9BwNks1?=
 =?us-ascii?Q?3XahB/URHgBcHUQ3niY49eMWsv4yrDc1w+6/gDzQBOu1ZlZexI0XMeu17oHo?=
 =?us-ascii?Q?80RoxiPAC/70QxI+dUnY176TBkBt7/cvAT+CVqjTgPGWhqOcEpSjqud94edu?=
 =?us-ascii?Q?z+ct8UDWrp9IYp3B2zzAER0UX/qX+D0ynRZXp8O5DKXL1x84jjHpf9MyISHd?=
 =?us-ascii?Q?i+T7CJnrROA9/k6dXly/zV+QwT6JTZczInal2tdBrhqiIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzBy9oq2tWAY9HreuWNzsG4NW1EyGVGOWSJGsakE+YpoVU03vK21rgGB64pG?=
 =?us-ascii?Q?dmbEaZFI6tt4MgnfL7uF9KV7HY6HZmlfXa6DQW6OYxm+lbuqCbLqYRRGi1c4?=
 =?us-ascii?Q?QV7h4GpPgART6drXes/kQg+mKDnzsMorsQsesdZkyMBxJ6TppOABw6B46PgC?=
 =?us-ascii?Q?pZuo+Q5sjBRcqTXh7XxQcM5C60C3ncnLtedFTjDjKXvW/ymNvJciw7WVQVcP?=
 =?us-ascii?Q?RlTloMQi3qqyftaNQZ6QdJGd+4Q7BfQsCn0zkloqmCSfBXVWyijrhEkTd/Pn?=
 =?us-ascii?Q?IusuXU5EE9QKsef9mQQl0Z1aXog6Ju/vfcAhBmWg+QVJ6ayExSm2tnEbiL8V?=
 =?us-ascii?Q?3FP1TvWThsVT4KVk5zUf2NqyM2MI7/tI1X6KdcYffaVs4qhfMCtp7uww92u9?=
 =?us-ascii?Q?n8TbdwZwTNOV4my/duwmK9VF6WhunZ252BMdt0Po8zUB+o3D7y/1RZZdQww1?=
 =?us-ascii?Q?4TTsl4IQVzn3IL/VFh39MRrxbUvgZ/6q2Pu2p3xX3LAzVDsWI4j5KFdWsy+o?=
 =?us-ascii?Q?2+W2FS1tGWWMPaAO+86CKDdZTCJ16YNCPsHP5x3mEZvdBmlsD34qz7hBnBQH?=
 =?us-ascii?Q?GZflNyim9BKJQzFKaNs3VjTaK/AXhARXFTDe1R5sIALMj/DvtYhKBvhIQVUV?=
 =?us-ascii?Q?5zjbcl2NNGbhvG2Q6Rj9flN3PuUtBme+f8TNqosP79+6pm92/3b/Psr+7je7?=
 =?us-ascii?Q?Up2pQy7s6+sYkeOUoEFmp7zhrX7vzxROLrB/PnC2ZlWjrU5pVAMNeowWW+Q9?=
 =?us-ascii?Q?+q7xYViZKHiQbXpy0l/pGXIgGpTKtTjYGoXAlrQnAK3VTom7aibCRohu18AC?=
 =?us-ascii?Q?WFtCbzCjW5OPdcCZkwhlALzKy1pvGdv7MMwQILfuAnLU/Qi1x3duTGuzkmXy?=
 =?us-ascii?Q?MFsnIYGKr4STVAMAFYHEYWG7WFip+CxYmPIN6ZoIdWsOPTYhWtzDesIBt102?=
 =?us-ascii?Q?qMQ2pNOKVvXRbQTDhQMx0Qc1WapYsu9hPB7rd6+K42b/UvyBHNYbbfeNVxef?=
 =?us-ascii?Q?TOeBntAribZrpdTlgL1/iHWzQN7WuISzFpuFKMZDNt/7M4X2rHbRmzAM3Lst?=
 =?us-ascii?Q?5gpNmuSTkXqO39r28SxDL9elREyMZIOI0mQDIrOngI2ec4zSEtRh4/xBGMp8?=
 =?us-ascii?Q?BIEtAUsyCpjH7W5F+QqBNeE15oEtzlbSzceSp+3cYXpG70fiUsXL/IKEMisD?=
 =?us-ascii?Q?5TjocFQTKUnisJ1Vus6/Bd4lW2f/paDHYqLxHK+nCMi3O2TGbQBNz9/oRPEn?=
 =?us-ascii?Q?ntkwXi0KwXBtpjqwu32gI6E4c15WskH/9iSgZdiXWYm+CCa1ayf19jjTVk4T?=
 =?us-ascii?Q?TksAcuQrPhNTFQCrpaO8yeB6FWX4UVlXLnlVciGosotIWWlS6c6xwIZH3yKs?=
 =?us-ascii?Q?mMpntGjr3sYvSdQOPpLFxGQCyjPwkKmdikyI1fuahMUjt3s7sWF8qhmv//4t?=
 =?us-ascii?Q?E24YAY3QyRlrgu6I7WquK/UBob9I+IkMqeWRpHAoDxzax0W1HaquZz1zHqnG?=
 =?us-ascii?Q?N1GJ3D3OKJ6SUgBgjuT1dZiOXAV4QYo5dzOzo9UvJqNM+eZq4ThmNVoLcoCD?=
 =?us-ascii?Q?MXlgW3e0YdmT9Keu+m7ghZq1XNbqecxdxejcwmEa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7816a4-1051-44fd-09ba-08dcc872aeca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:36:46.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM42E0k6/UfmZZ5ChlM/IHh4XSX635wxJIBTHSLTlChBRM3HXsbu7yQI4WHPqTFs108MZ9GVnMflzWUCp9tp9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 16 Aug 2024 09:44:28 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Dynamic Capacity regions must limit dev dax resources to those areas
> > which have extents backing real memory.  Such DAX regions are dubbed
> > 'sparse' regions.  In order to manage where memory is available four
> > alternatives were considered:
> > 
> > 1) Create a single region resource child on region creation which
> >    reserves the entire region.  Then as extents are added punch holes in
> >    this reservation.  This requires new resource manipulation to punch
> >    the holes and still requires an additional iteration over the extent
> >    areas which may already have existing dev dax resources used.
> > 
> > 2) Maintain an ordered xarray of extents which can be queried while
> >    processing the resize logic.  The issue is that existing region->res
> >    children may artificially limit the allocation size sent to
> >    alloc_dev_dax_range().  IE the resource children can't be directly
> >    used in the resize logic to find where space in the region is.  This
> >    also poses a problem of managing the available size in 2 places.
> > 
> > 3) Maintain a separate resource tree with extents.  This option is the
> >    same as 2) but with the different data structure.  Most ideally there
> >    should be a unified representation of the resource tree not two places
> >    to look for space.
> > 
> > 4) Create region resource children for each extent.  Manage the dax dev
> >    resize logic in the same way as before but use a region child
> >    (extent) resource as the parents to find space within each extent.
> > 
> > Option 4 can leverage the existing resize algorithm to find space within
> > the extents.  It manages the available space in a singular resource tree
> > which is less complicated for finding space.
> > 
> > In preparation for this change, factor out the dev_dax_resize logic.
> > For static regions use dax_region->res as the parent to find space for
> > the dax ranges.  Future patches will use the same algorithm with
> > individual extent resources as the parent.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> I'm not 100% confident on this one, so will probably take another look
> before giving a tag.

Thanks.

> One trivial comment below.
> 
> 
> 
> > +static ssize_t dev_dax_resize(struct dax_region *dax_region,
> > +		struct dev_dax *dev_dax, resource_size_t size)
> > +{
> > +	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> > +	resource_size_t dev_size = dev_dax_size(dev_dax);
> > +	struct device *dev = &dev_dax->dev;
> > +	resource_size_t alloc = 0;
> 
> No path in which this is not set before use.

fixed thanks
Ira

[snip]

