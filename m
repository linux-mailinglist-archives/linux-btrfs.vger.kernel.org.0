Return-Path: <linux-btrfs+bounces-7898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9B971C1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689E72848A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAD31BA279;
	Mon,  9 Sep 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILKZdkk2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08C178CDE;
	Mon,  9 Sep 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890937; cv=fail; b=WYLkSy9s8oZ50rgUNbS6o/anca3D6cXcLJcM332/wcN9ver2CaejOzFH78wAhIc4kD336EVvk5Q3CmN8iPPL9zRwZeDjA+HKpvc2B2mJRCvAXZzHMyGtAc0zL2SpgPvkM9kpi4Q9FN/xb6ZEgVYIUdtln4K/dZaj4oHcPwRmwLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890937; c=relaxed/simple;
	bh=Yk//0WpziYLZapWPYyCcif435LQUU41oNM08h606gjo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axG02xh+HRq+ppzOSB9I7JPOGJasRGNq3m5qTaqGmZLu3dJDplu0vlmE5rZxgl0YPcatR4c0EEbRQiuw0PMkcQL17sLP0P6dHvsPqxion8C3YwhJht5jSX5yGLHSOVVUW9YHgk+y2ifngLjgkRpoeR89s8nAQwb6uy53da1jCYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILKZdkk2; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725890936; x=1757426936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Yk//0WpziYLZapWPYyCcif435LQUU41oNM08h606gjo=;
  b=ILKZdkk2RWJ7w8WqMwRBEoXSx8kf9UL76CaghYENP4FZIjhUd7Mg32lu
   wrowg0T2Eh14K2B7aMHVMFZSKdWKJgewZXt6kitDHmGzEHItSb4I9GeHt
   +TphHnFqhZDRfvqL8AIhJtY7E6UNx1KvNXAzduVlGbP9v+FNVwlz/UV+b
   RvBUpC7HQYJN4xrtIcvVYFUkmUfd+iKF2vtx1WQuXx8Hs5M8V3XMLcapm
   PnbUvV2HjYgHxD8dD1g6efR8NVTDUj8ue5sGobUaw1FdT4yP6KHyDhGex
   aAkBl6Q7/CcGtjKa9um3h+yHuUXYcfXkI0dmchVWu3RG8O7KpSjvTWjaq
   Q==;
X-CSE-ConnectionGUID: 6Yh/xrA4S2ejSz+FGpX/+w==
X-CSE-MsgGUID: zdfvApFWQLS2km+WdfjQ8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35164363"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="35164363"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 07:08:55 -0700
X-CSE-ConnectionGUID: MpGa9LEPTfOQq7QZ7BbcmQ==
X-CSE-MsgGUID: tjB5Sz1JTGi0GLdOw/ASxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66401233"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 07:08:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 07:08:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 07:08:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 07:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbRHcARm6vW0rZvZyg+tVcSWLd6s2r7wVpk9gMxWXm0gFhvNodpMWJ4T7TSKtPjWjrUHoV1+f+I8vjAFHB8oYnCf/qSYW+Hin4g0Ed/uuVd9n8ZGdCO/aDFVSNkfa/ldriOOVvSfCmWxFdLqL57aute7aIe6JHKg6ZAPH9c6+IHCuAh8mzBa1VPcUb0WQ9s6LBkZQ33RuOem8TkdnjL/cVEVTsOlPMkVKeRSDvXwrv2yNQM1ZuFAEaILayAXdgGszBTRKtbBKTmuuQKS7XZVad9hYyaHT2vX3R/0Mb4QcbNOnjy/Nr3f2yo4uFGQs5reUqHuwXKh24kwovNEn0Y/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hj4Dwd1Ezu7Rf0CuQ42jPFwp5jkJc3tX/AqVS9J58k=;
 b=OBdyCoc+4TQ0vrWLRxsW0GvdhN1ymhTS0Zrzi8GLdbKnYin4Go/fyaiJFsUb9qRfg3yaj4ZLCIp6XagwOpVcleO6Xy7+rzZSA/L5tM0P/yskvzi7eXITC9HRUqNiBWDTHV0rqF/uTfif/efHz3+6c/F3ieDnjRfcdmTHpbIcILxcgdiH+PLNOKvPBw7Di7iNBeA43JprsQc8vm/zP5zFpFIeWir7M/cJ9k7i8oz1pcmQbemt31V0ummnv83zbli3oPqPyKBGls0pN7QtHQZK1d3xqQs+G/wMbtCwzWKGdKSBywmOTYKkDclInYGfoqZmhhQZLrSz8jwpgwEWDuMGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 14:08:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 14:08:50 +0000
Date: Mon, 9 Sep 2024 09:08:43 -0500
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
Subject: Re: [PATCH v3 25/25] tools/testing/cxl: Add DC Regions to mock mem
 data
Message-ID: <66df016bbfde9_f937b294d6@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-25-7c9b96cba6d7@intel.com>
 <20240827153947.000077a8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827153947.000077a8@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dce3130-c6d0-4d82-f12f-08dcd0d8edab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?miA07QQadOAWKU+7GIwRoNdPxxY4DqCQmySZDnqMDzuPLt7LMTPpYmmzleRX?=
 =?us-ascii?Q?2431OPfNySqGKh3dyma2iglB9ZkmnkbHqVzeSYjU5qbIcZ0zNGPjBBBJKyp8?=
 =?us-ascii?Q?pl2z5XQYq+XZFeM/b8F1yIDB60rBbMgDBQzeJzk2hciUbIkNWTDUCWLxfr2T?=
 =?us-ascii?Q?H4Qc3vjfq0vT59ndoXopan8ad4oSO37S86EsP5ldkd3/2+92yqDXEBaFV7xi?=
 =?us-ascii?Q?eE24MWgsa/uDrQdtgXYJNBK82k0xIokvKSSqlNcYo/yfiZ8VewCJww8FEmjN?=
 =?us-ascii?Q?Fi8SkiRCtSY7buGLKT8TJPaXw03Uvs/CC9kh4CxaCOrL5bj1dJ3FMM0njO3J?=
 =?us-ascii?Q?m7EikVV9uhT0ix2Dy6KVv3I1RDvq+DfRCQz0GjuZXw5Ks5zGuaFwmtfBSy7j?=
 =?us-ascii?Q?5FdnSsclCNUToGpHvwIZX/9iEMO8q/9wr0vHLbN4GypZ9A9TJkAIAxQqILXa?=
 =?us-ascii?Q?EkxJVRBgZMcsOVAKTG3ViDD4N42w/XkXczMZS58H4AbgS/hACH0u7948SvKq?=
 =?us-ascii?Q?6aQ7LA1bI0k3oeW2U+pPpW634YpyTZZYcnt+S8fb1h/v/qeTR6wpIljfwv1k?=
 =?us-ascii?Q?/FcPMP3meRkxneQpHHa0xieXRXAVGlnaxf5L/ZuzUgoRvVPQ4jO8NDpAf50v?=
 =?us-ascii?Q?oLoLfOR7mgiO4X+J94ITpnAW9ZoI3VLi6aDdekRmpQIB4Iv6davuEdmCswfQ?=
 =?us-ascii?Q?ANX1tQuJT5xbA4lLDK7Gl0tFhQKwRBwDFUGle0iML2/iaqLm4tWHb/LMRJiU?=
 =?us-ascii?Q?ZyPWZ2ZZ2OQe3xBLmyNQEWVDmxdGWFPRWIL6nMwjeIDIdFePfY9xGYzRdrAl?=
 =?us-ascii?Q?Eztoar5nNJS+BDkuGq3lsgRRGx9e554LVjrPVSD1oI8WvXVmyienXPVbYo/z?=
 =?us-ascii?Q?DL6Fmmp0b5xlpUFvn1lC20UGqG7Tr8ihyaaRCf9mSEwTFFbxdhwvW6R22PC6?=
 =?us-ascii?Q?4+/jaCuuTSPV7SNp2afdRUcuZJe/Kjxuo7Mkav6oJC5++zuBwJK2SZMvXz74?=
 =?us-ascii?Q?nZd1Y15pCTniwkae03xKlZm4q0txr8qkHReejBtKr7o1bIPQ79+NJU/9SQAU?=
 =?us-ascii?Q?J3HaS0xCONQjqUVDZfb3YWedSWKrv3I4bO+IfKAVu0cxXYmHbXXl+MQ6FKhP?=
 =?us-ascii?Q?voXLG3Cg6LcaSUKtEDB0io1KVUzKFAz8UBo6bd1tQJAzCgEuNPet+i1EARSF?=
 =?us-ascii?Q?fNw0h/jo52PobG1VHst5VTf8HT9aN4T/gRGw5SdNBC3KxnNcCwH8fRPitPTf?=
 =?us-ascii?Q?VJqjDtV32UNRf+l5RF//mtXWESNgiVQ2crRyjyRgx3Jp1Qi5BiGoQNbvAgbb?=
 =?us-ascii?Q?3pAX+LWRzkuhTFO4jEXH9k7BHw4fziN5JW9OM3k9RWmvdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vAfCOqR+YfnycmUFWDQb6M4dmtIMLBPr23SkVzHQh0OesSaCIFWRfs5Lr1BL?=
 =?us-ascii?Q?U2/wIaZrv2qb5n9Y4a0tlT1s/OSrhbwMN6HgYqtrRM9kABKJApaoRg6vQowm?=
 =?us-ascii?Q?4F1E/5eEQirMD6MwhoNIoIcxYjd8JRPFX0h/OQiMB293NgLZDNG7UG2K6UKb?=
 =?us-ascii?Q?cJDpnxm8/h9Wnnwk3KuG4/SJHJ0Bf7g6ZdBUK8Z5UxGzVNlnb/XfUdY9zz1a?=
 =?us-ascii?Q?KW+/EMqypdgU4bx+De4vol6tP59F684dNrF86OKdHWIHhC3IIIha/D5ZxRXX?=
 =?us-ascii?Q?SoSkiyAgv00JDZcZrVEh/tsFt/I536sSkeeJQ+zphJDr9siyo7LHfnqyaCeI?=
 =?us-ascii?Q?W8RdTfs2BcXqttKfx1vGEJhjl+TBrjsXvQ5Ed2yg+oldaJTbBRfO6p0tf+Af?=
 =?us-ascii?Q?r+qzaCMz1739Y2udMYfoKpBRqJcIxCRM71HB7trPTeILDqbGt/ZV9Sk5aNUd?=
 =?us-ascii?Q?BnrIomtCGZwQHDioq4eph0K1cJAq3ttf7Z3DLt02I7kdPfslTH+WXMPhRRPK?=
 =?us-ascii?Q?59eC4dmheK+S+w0k02zt4ZZhuUtWB8TQATAhTMjSo+EKzE/fao8/QrytJxNB?=
 =?us-ascii?Q?COck4l1dgnIs7kLaJq1lyAvMe18HQTYqM6Qzg2zLOqzrQT0FP3eM6IWJwGDt?=
 =?us-ascii?Q?NlhreptnkB2oXkQnSoK/7PMNAgOFc2Sm0aiHACVrWDiatrQVJ1nwLWdSQ/rn?=
 =?us-ascii?Q?jZOml2ERBfx+cNGc+JWNxCCXYJGDrCk++gAWr6kCLovVHovA2rhaUIx97qjl?=
 =?us-ascii?Q?IXUk40WzsnfT7xeh0qcPbWLWMVd2W5fnoJefMxo+iXtQeFNVgCGedQoxZY6J?=
 =?us-ascii?Q?dD7WlKUBpltSqR+uktMerJ/9/Pgq7gJuX89wB6g1O/NsliHMRi649PuYusL1?=
 =?us-ascii?Q?zzmDmkQfCRjCpaAKPpr5tWnkI+f5tWu2/u9wl2rF1AoczfujqNS7cd2X7wJS?=
 =?us-ascii?Q?zEsEI4cPRbNpJ1zrd679hBDHnoJRrcm6gkm83FPcHvDeTp96aqFf9QDhS4zh?=
 =?us-ascii?Q?RqvK0V9mMpRNrhfjYfNcFDVqu90KCueUXaq/kMI1VxVK4+glrQsGOpNxtiGt?=
 =?us-ascii?Q?0BhIi2q2BZfoySydw1rguZa17AUup2kpBPWuu7DGbbIPi6g09uJzJpcbDbuE?=
 =?us-ascii?Q?s6P2zN695ncSoRWk3Q492mVqWRWq5DIFBzGdClnL/kNfI6ftWRE3sdZptUyx?=
 =?us-ascii?Q?zYBGyVXhIQuf7SPBLqiKpw0MdSqCXqkk0HzVbMkC0dapZ/ApqNzBcnqdGPtA?=
 =?us-ascii?Q?/EWG2g8QPAci34GrPJpiMGgBdlnfO9olFECWqbkxj1/XbqBNqtvYySC4LAG0?=
 =?us-ascii?Q?K5XryQtSKiQB0w1d7JaVPt8XPqxoWzgkkGUScFOf5y0zz5ogymJi86I3Gfqe?=
 =?us-ascii?Q?suazbZHIerMWZNWcTgS+OUbPfHLEHDpYMcZUOYHJkvzmpk0ZrakpLxYEFNWp?=
 =?us-ascii?Q?AKjrXuUPY0JqzyFpwpHL2jlrrkBdGi0dBp6b4dx9D+byIJv4inUP3nkhzmHx?=
 =?us-ascii?Q?Tdom1Y/KvVELoMqw38an2r9bQRSts8gYLi8Ss+z5P6tGUUAHU2Wo8q5dbMTP?=
 =?us-ascii?Q?/Y54yVvy8DRXVq2qawNhoZpNEB3HykMCG8n80SSh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dce3130-c6d0-4d82-f12f-08dcd0d8edab
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:08:50.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tI0rqbmSdZu8ffRehPUJKmq7pHHSWnbj5AC/HiMv5khlEIteayC+yMMrvlgJwRxvNRjUuZ1JlYuhG2UlTeTlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 16 Aug 2024 09:44:33 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > cxl_test provides a good way to ensure quick smoke and regression
> > testing.  The complexity of Dynamic Capacity (DC) extent processing as
> > well as the complexity of the new sparse DAX regions can mostly be
> > tested through cxl_test.  This includes management of sparse regions and
> > DAX devices on those regions; the management of extent device lifetimes;
> > and the processing of DCD events.
> > 
> > The only missing functionality from this test is actual interrupt
> > processing.
> > 
> > Mock memory devices can easily mock DC information and manage fake
> > extent data.
> > 
> > Define mock_dc_region information within the mock memory data.  Add
> > sysfs entries on the mock device to inject and delete extents.
> > 
> > The inject format is <start>:<length>:<tag>:<more_flag>
> > The delete format is <start>:<length>
> > 
> > Directly call the event irq callback to simulate irqs to process the
> > test extents.
> > 
> > Add DC mailbox commands to the CEL and implement those commands.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Minor stuff inline.
> 
> Thanks,
> 
> Jonathan
> 
> > +static int mock_get_dc_config(struct device *dev,
> > +			      struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_mbox_get_dc_config_in *dc_config = cmd->payload_in;
> > +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> > +	u8 region_requested, region_start_idx, region_ret_cnt;
> > +	struct cxl_mbox_get_dc_config_out *resp;
> > +	int i;
> > +
> > +	region_requested = dc_config->region_count;
> > +	if (region_requested > NUM_MOCK_DC_REGIONS)
> > +		region_requested = NUM_MOCK_DC_REGIONS;
> 
> 	region_requested = min(...)

Sure.

> 
> > +
> > +	if (cmd->size_out < struct_size(resp, region, region_requested))
> > +		return -EINVAL;
> > +
> > +	memset(cmd->payload_out, 0, cmd->size_out);
> > +	resp = cmd->payload_out;
> > +
> > +	region_start_idx = dc_config->start_region_index;
> > +	region_ret_cnt = 0;
> > +	for (i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
> > +		if (i >= region_start_idx) {
> > +			memcpy(&resp->region[region_ret_cnt],
> > +				&mdata->dc_regions[i],
> > +				sizeof(resp->region[region_ret_cnt]));
> > +			region_ret_cnt++;
> > +		}
> > +	}
> > +	resp->avail_region_count = NUM_MOCK_DC_REGIONS;
> > +	resp->regions_returned = i;
> > +
> > +	dev_dbg(dev, "Returning %d dc regions\n", region_ret_cnt);
> > +	return 0;
> > +}
> 
> 
> 
> > +static void cxl_mock_mem_remove(struct platform_device *pdev)
> > +{
> > +	struct cxl_mockmem_data *mdata = dev_get_drvdata(&pdev->dev);
> > +	struct cxl_memdev_state *mds = mdata->mds;
> > +
> > +	dev_dbg(mds->cxlds.dev, "Removing extents\n");
> 
> Clean this up as it doesn't do anything!

Opps...  Must have been some previous xarray thing.  Or perhaps I'm leaking
some memory here?  I'll double check.

> 
> > +}
> > +
> 
> > @@ -1689,14 +2142,261 @@ static ssize_t sanitize_timeout_store(struct device *dev,
> >  
> >  	return count;
> >  }
> > -
> Grump ;)  No whitespace changes in a patch doing anything 'useful'.
> >  static DEVICE_ATTR_RW(sanitize_timeout);
> >  
> 
> > +static int log_dc_event(struct cxl_mockmem_data *mdata, enum dc_event type,
> > +			u64 start, u64 length, const char *tag_str, bool more)
> > +{
> > +	struct device *dev = mdata->mds->cxlds.dev;
> > +	struct cxl_test_dcd *dcd_event;
> > +
> > +	dev_dbg(dev, "mock device log event %d\n", type);
> > +
> > +	dcd_event = devm_kmemdup(dev, &dcd_event_rec_template,
> > +				     sizeof(*dcd_event), GFP_KERNEL);
> > +	if (!dcd_event)
> > +		return -ENOMEM;
> > +
> > +	dcd_event->rec.flags = 0;
> > +	if (more)
> > +		dcd_event->rec.flags |= CXL_DCD_EVENT_MORE;
> > +	dcd_event->rec.event_type = type;
> > +	dcd_event->rec.extent.start_dpa = cpu_to_le64(start);
> > +	dcd_event->rec.extent.length = cpu_to_le64(length);
> > +	memcpy(dcd_event->rec.extent.tag, tag_str,
> > +	       min(sizeof(dcd_event->rec.extent.tag),
> > +		   strlen(tag_str)));
> > +
> > +	mes_add_event(mdata, CXL_EVENT_TYPE_DCD,
> > +		      (struct cxl_event_record_raw *)dcd_event);
> I guess this is where the missing event in previous patch come from.
> 
> Increment the number here, not back in that patch.

No that patch needed to pass the counts correctly for the event test.  DCD
event records have nothing to do with that.

I've cleaned up the patch.

Ira

