Return-Path: <linux-btrfs+bounces-7577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE4C961963
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC802851C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D661D4156;
	Tue, 27 Aug 2024 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrII35JC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EB1991AD;
	Tue, 27 Aug 2024 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795124; cv=fail; b=X35q525q32z81RCvdkUdJU3tHIZKxx2RvGiBT9tF1ED+uW77CYd8b1dItqhiMcD5iG0NbtG9pHaIxxuP7ioyRUNbg74OHQ1tbU89UYomLt3ZyQy/+H65UjMx1bhIka3qDYt1Tiu4M5nt95aQPKRDZpeMLaSb4yQ51gpSNf61VPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795124; c=relaxed/simple;
	bh=8w7sZDSGu+GbrI7dI+W2sC+SUUg3u5aZWot8CCGGM7E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AgYS23F+hb5vi78CEjRZrceCx0v6pB+U8kCB6rGF6EqmG3huFsraQx47Ie9tOVzBCs/33vXG/pDSPKHqhOTJkiftcOgJwYOwd4K08XefqQf1Dp7K+Bk2HzO7r08xFSs9y3eaQMAqHqVyTE61aYQiB21ymdi2uQ9Ny8gQUNvukOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrII35JC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724795123; x=1756331123;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8w7sZDSGu+GbrI7dI+W2sC+SUUg3u5aZWot8CCGGM7E=;
  b=KrII35JCG9tyeYlBmkK2LtIfLB8MIlWEQjgz2awgsk6+i6i76tISxDyz
   6FaerUj3VLglodvt+S5YlARIX0G+gMfSLyFlogBcpikcco/GqSPG9z587
   wX720n2vbyuVStbEaJLSYJZVBFzZKup9IZBHzZaXU2MjZ1z2bgKRGPXmO
   L2KVAdorwEkBEp9grxuG5BymRR6HYVZLl7tEG2D2fpFvFciAlwEf22ns5
   vbeBl88ueOJstqlB9/cvlIRaPTT/ElIQL9dzGBs2e3F+x46VnpIr1po/T
   Kfh2v9HdFEJk0J1C7YkenMZ2hWP823A4bEu9CFlipRnWs6hhKaiDiqs1h
   w==;
X-CSE-ConnectionGUID: ukDYtFmRSb+9yKXdQ1rG4Q==
X-CSE-MsgGUID: R8bDnjhAQKmuxHthCIEvjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27093566"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27093566"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:45:05 -0700
X-CSE-ConnectionGUID: hpBWbceJQ+ufyHle929q+w==
X-CSE-MsgGUID: wV0BBS/sSze6T+4j4dXM3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63000981"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 14:45:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 14:45:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 14:45:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 14:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvTJC3O17Ya2WEvUcpLHb+dFEZeI7GUnACiGqtO7t6pVNc9/EHMCN13SFw7xl10vddp9C72rYoYkHBZ3opusqyJBWtJGMuvr5RNdXjHliqEwe8XInmlY0IJSw+72m0J7NJaWY8xAlgWYb6DizoP540zK8MzUxg+B24qOYM9Z68P1JNIEJ5a34OCFogK7ct9yhK9+y/9AK6T8phdg1jaCo2oHO805a6oDGW1dIjTXC2XDNw9DqoxSgk3V9zdCNkTXaFkE9HyfXMsqqC7eBh+5zJla1grnf6dVEsBFXiYNQ5uHdfGCTpw5pHMy5o6AsR1VpOvunuwGv16yqvIkk0HEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smQ3gblKATRhVDPzH+lALlb1/1RlU8BZQXcXfCUdCdw=;
 b=vEOOTBWAZhizuGI1vnziDM/4f2ATodP8EEf74tdI0wfMWdtJbAX1s+v4sLhu/X7ctAzgWnxr7xIOXZB/m6qTDbSQ6aJlGoGmKUimMcGWwcblgKtbShhDocWrFtDtjw388GhyD3MMgZ3BhyUaF7fdHjik2zsoDcrsLrmfjWkAgPVfgwMKSPB7r2N0FJm263QqPWtQOGNly5QtsmmVpaSV4wQExGZv20fvl9oU7O6rNKMIwyMicq7/GpbzS2y2zE/LVL+pz8J4DAugZjXTP9ERAsnpYl+ZsBMFAXhs2LP5+3B07FGCtBz2hq+ZbAN0jtIRzgjkg444fdkWTUUJjuQ29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 21:45:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 21:44:55 +0000
Date: Tue, 27 Aug 2024 16:44:49 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Petr Mladek <pmladek@suse.com>, Ira Weiny <ira.weiny@intel.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>,
	"Chris Mason" <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <66ce48d1e11dd_f937b294fd@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
 <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
 <Zsy6BbJiYqiXORGu@smile.fi.intel.com>
 <66ccf10089b0_e0732294ef@iweiny-mobl.notmuch>
 <Zs2DhzbLK_LU6B0a@pathway.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zs2DhzbLK_LU6B0a@pathway.suse.cz>
X-ClientProxiedBy: MW4PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:303:87::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6777edee-e5e8-4a26-9e87-08dcc6e17d68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MeCsbWQ/VmReis2IjiYXmt/tVMEdJGXNacHL7XVI/GwFjdvi8qKrRPbxpkuE?=
 =?us-ascii?Q?oE2PTB8v8OD1hWz5VPUR5AKDWdLJPAk2f1QD8HFaiigz4q/ASEjBQpsvzA5/?=
 =?us-ascii?Q?7rdck5g3cGnyutT9Qd1mosg9q7xXpIJcSizbgeb1iiPULdN4uyEAeetcAeOd?=
 =?us-ascii?Q?o66nUdbCewLytE6QbeUVRyQrAIshBp6YRWy8S76IY1IPmuVTIBdzVsWbKTP9?=
 =?us-ascii?Q?iemmCAbvvIklAkKYnznjXZhQ2aRsPgejKwUYIVq30neLnu5vwv7JJfSPMecF?=
 =?us-ascii?Q?kuaCMPi6KxAP+oQMqK1rfIRr+zels3eTZah9x5vBLmR73mx8mJsdlj3i9H+N?=
 =?us-ascii?Q?34ZAtdTMxG79+d1j1HNSuB2x9CDTUKfp9X4gGGAdezBE4SW4L298khy5ly8V?=
 =?us-ascii?Q?xv2t331AHr+lPDx/mpFtvOM2XImlMf7oaOAojgAJ/x61TMU0TTMHXTHTslPm?=
 =?us-ascii?Q?sh/mmSYRWZ/pIcRNE++iDr6wo1NscwRIpDJXNanLP3pRii7Y5A2NUUsFP9Se?=
 =?us-ascii?Q?A4OeKf9fgWodfhd8KZBvWu2x11oNTcaqXIlozbcuzCBBnp1Fnbug6NM/guUA?=
 =?us-ascii?Q?tjDahz0YK80U36+sGszxwC3YMdDtdpk7tpPQDtRi+VxuEUZKCnE1XvKtmN2J?=
 =?us-ascii?Q?d3g9l5wJ06JQNr7e6hci1ORvDRK6t4mW9cwfXRsrY3sDammb8VmEK1DkJLYm?=
 =?us-ascii?Q?RvoBG5Kb+NHSSJHYXhEw49KMGWoi1wC56fS9FfpBdhWLxO9ceRM3ksnXSZFa?=
 =?us-ascii?Q?l1UJ6zr4PHPq1mYM20fl8F1oae+Pdsdv7aNXe7oxLi/6amwG1oiUrj61ThDd?=
 =?us-ascii?Q?+Euz3bld3SD9ErDEhAMEx2Wc2hwG/AoTE6RCbG6lD08g9WX3sfN0DiaCjJnz?=
 =?us-ascii?Q?tgt+oJzZ8060hlTrqOWGpBjad/Q5mRs2QRdpH7JswDRCXee3ifCa/aaS4pwG?=
 =?us-ascii?Q?7hbiOsDeCepppUSN3Yp9/5ql3482e2VTfxc6u7dSset9IOXYK8zH/jMCBc8x?=
 =?us-ascii?Q?l5LXp8hSdsJqTIKqy52TZnHobS7ayd2X6dNDujEm9heWuXaKcfW/H/dkZyf4?=
 =?us-ascii?Q?aBFNF2+uM/4UiXzU0g/eCYDlCtHgxp+t0m7gmVUfQqoc0gP3Rdz1emFOaVfd?=
 =?us-ascii?Q?nMchxDd0qQGynk2BE5eaCeU9pDCmQ+qkjLdpjlALOVMbCJHzD2ZCM1/Dbsyn?=
 =?us-ascii?Q?uz6l0wxlP9rZABsE5aya9sYtsjkr/QYGpApp2n9QTiveqWmXxrC9Z+qJfkdc?=
 =?us-ascii?Q?2JsbXRIRzJZseh3gf+bTdm+desuaWM4Uzx4IEMd7oUym7pQCOQCwwdEmkrMf?=
 =?us-ascii?Q?kHIDx6xCmOAiELQLTbhQ1Di6aEYJiDh1H0KSRTQdXgxlzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qweZgjqEAP5pY4WIL7hu9+eCCMvCrbl7dGXcSD1kNiuUWSSykdhoW/HY9ujX?=
 =?us-ascii?Q?YlU0txCzL98Tyyc89IM+b1eVTCZG6g8rjZ/2ikwEFwk/YY8Lh9i52y8BJCN4?=
 =?us-ascii?Q?gYAVufkKKwb2LjjgYbc4GLpWdDGN84QkIBCrkN9CGD/3naECPshtk/o2Yxx3?=
 =?us-ascii?Q?bMrhoIa44E1zFhKXnA+qudCUaorRC0waQwqhtuRWTj0JxywdXrzexD0i6v8U?=
 =?us-ascii?Q?QY9hbF/AW/kHW0arncVfyyzxAbO+2ZCKo2rR5/gv9xyHcKArF6Ns+N4Tj2Mk?=
 =?us-ascii?Q?vgiyaSMyle8J2GLP40Lnxn2DDJ0ZxP9RYdAsYDdjwIQQP5zhggwyrx0z5vWQ?=
 =?us-ascii?Q?Qb20ShC37OSh9n7Z43vL4M9bIJBKNM9K9M9FNioFYDgjrj61OB2GV4Q3+cMz?=
 =?us-ascii?Q?9UpZF4PVcF1/TrgRwffEz0+210D25hOst6I4BCafnRSkevDbVdiilvhOBtoN?=
 =?us-ascii?Q?RVPzutizMkfa3uuq/x1rKcG/PP1MSbHEw6+kqC+U3NBhENE2FQ4cE7jxvNm/?=
 =?us-ascii?Q?AtPA0VBG28HWA4AOVWH6b9w/IXrjXkZMOdz9pU4hZP3fWJbsfcxx3viU/OTC?=
 =?us-ascii?Q?5w3yNvOi2t9E0dndyOtpy4SDAX866s2Juf4Yx7jkklHVROBK/bHzYxoe5c0J?=
 =?us-ascii?Q?yGxA2JL0pkeEB9d4QzeRuvY70eZAKuzXjn2Ek/XXqtLnCyT8mbS1ayayqrJI?=
 =?us-ascii?Q?ER/uH9W9KKqbuh+JesI2YmfobpCZo5+f6o0+8OTZrx/UVM1CUqK3lH680k+Y?=
 =?us-ascii?Q?Rp2pgrvPbpnS8Ga4WfLdRaJLu7m5h9uG6P1QaIbX6QnXkHdkMsUUkytL1Edp?=
 =?us-ascii?Q?A5XDIObELHKWJsd4ZIUDUM9Q6ugF4nMumefoDZ19ZHjtT4xKqUk8tX0OxpYV?=
 =?us-ascii?Q?0arncfLxBKMAgXsqBChRoSWN6PplOcc6n7JysT5F/7FlsrhbNURJ52oFJJO+?=
 =?us-ascii?Q?u+hrCEjRNF26bs/QgF1PJuKZlD+Fx/OnCzHQfIVB32sOwOP+T+EiulriM5As?=
 =?us-ascii?Q?HLlbJd7G2eleHqJ8S0k118UwVV+c/mdrV3I1YFT40HPudMYmMrEzyeVHMyb1?=
 =?us-ascii?Q?VaWiW97woaGBgYmTfZzWRyp5mFqs2ZZ7cFGvDTHn9a3X9BmXcugP2zpVZJLB?=
 =?us-ascii?Q?zLzXAoWLsox2rjiZFh7kDCZ57U2Zw0jJiRagGe6ObHqoJl9Va0ylnT1Nax00?=
 =?us-ascii?Q?aSX/itZsYQcho/VYJrimLzk+N4BhUNkGvnGrSM0SmJt4UvS/X24IciywxUWs?=
 =?us-ascii?Q?5v2gexysgIFpYOYV50Q2zt/y9ikVjt+8ryVWK5Wi60fRH6nxgl8/IQHExLXv?=
 =?us-ascii?Q?aS7QAS52zbcx8mTQNuy4iPTYffzlMPrQ5GgLNHjeRUeKtPoV97bB3BmMVxY0?=
 =?us-ascii?Q?UM4bk9kVYreLdsMcsMVaLrmTpojC0dSTvy5stTR/+ibVrau2UQWDn7EZJf6+?=
 =?us-ascii?Q?cBwO7/0cLBoI03J/lSHzJZbGlMouRznZKz+iqgaHO7/qPsn987J4nbOCECFO?=
 =?us-ascii?Q?PZ2B/spY/KerW4hfJO9mQkBLecAvyvUHfvgz2Py9AroN9FNEoVA9f42iktsQ?=
 =?us-ascii?Q?iCnLJtcBoWXgi1J39yZL4jvvxIQc15nzkPmagrrz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6777edee-e5e8-4a26-9e87-08dcc6e17d68
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 21:44:55.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpVO+sCi9PsAjRbktHTdDaodrAATohhVWklKJUvvcDFDJXgG4Jcc0oDkQCPtGyUsLzwJXmSa55w0GdDWZAxvBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com

Petr Mladek wrote:
> On Mon 2024-08-26 16:17:52, Ira Weiny wrote:
> > Andy Shevchenko wrote:
> > > On Mon, Aug 26, 2024 at 03:23:50PM +0200, Petr Mladek wrote:
> > > > On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> > > > > On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > > > > > Petr Mladek wrote:
> > > > > > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:
> > > 
> > > ...
> > > 
> > > > > > > > +	%par	[range 0x60000000-0x6fffffff] or
> > > > > > > 
> > > > > > > It seems that it is always 64-bit. It prints:
> > > > > > > 
> > > > > > > struct range {
> > > > > > > 	u64   start;
> > > > > > > 	u64   end;
> > > > > > > };
> > > > > > 
> > > > > > Indeed.  Thanks I should not have just copied/pasted.
> > > > > 
> > > > > With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
> > > > > to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?
> > 
> > I'm speaking a bit for Dan here but also the logical way I thought of
> > things.
> > 
> > 1) %p does not dictate anything about the format of the data.  Rather
> >    indicates that what is passed is a pointer.  Because we are passing a
> >    pointer to a range struct %pXX makes sense.
> > 2) %pa indicates what follows is 'address'.  This was a bit of creative
> >    license because, as I said in the commit message most of the time
> >    struct range contains an address range.  So for this narrow use case it
> >    also makes sense.
> > 3) %par r for range.
> 
> Yes. I got it.
> 
> Well, is struct range really used for addresses?

Commonly yes.  But I agree with Andy that it is not always.

> It rather looks like
> a range of any 64-bit values.
> 
> > %p[rR] is taken.  %pra confuses things IMO.
> 
> Another variants might be %pr64 or %prange.
> 
> IMHO, there is no good solution. We are trying to find the least
> bad one. The meaning should be as obvious and as least confusing
> as possible.

Yep.

> 
> Honestly, I do not have a strong opinion. I kind of like %prange ;-)
> But I could live with all other variants, except for %pn mentioned below.
> 
> > > > The r/R in %pr/%pR actually stands for "resource".
> > > > 
> > > > But "%ra" really looks like a better choice than "%par". Both
> > > > "resource"  and "range" starts with 'r'. Also the struct resource
> > > > is printed as a range of values.
> > 
> > %r could be used I think.  But this breaks with the convention of passing a
> > pointer and how to interpret it.
> 
> How exactly does it break the convention, please?
> 
> Do you passing a pointer to struct range instead of a pointer to
> struct resource?

Yes a pointer is passed as the parameter.  This is what %p means AFAIU.
Then the modifier is applied to know what we are pointing to.

> 
> It should not be a big problem as long as the vsprintf() code is
> able to guess the right pointer type from the %pXX modifier.
> 
> > The other idea I had, mentioned in the commit
> > message was %pn.  Meaning passed by pointer 'raNge'.
> 
> This looks like the worst variant to me.

Fair enough.

> 
> > > Fine with me as long as it:
> > > 1) doesn't collide with %pa namespace
> > > 2) tries to deduplicate existing code as much as possible.
> > 
> > Andy, I'm not quite following how you expect to share the code between
> > resource_string() and range_string()?
> > 
> > There is very little duplicated code.  In fact with Petr's suggestions and some
> > more work range_string() is quite simple:
> >
> > +static noinline_for_stack
> > +char *range_string(char *buf, char *end, const struct range *range,
> > +                     struct printf_spec spec, const char *fmt)
> > +{
> > +#define RANGE_DECODED_BUF_SIZE         ((2 * sizeof(struct range)) + 4)
> > +#define RANGE_PRINT_BUF_SIZE           sizeof("[range -]")
> > +       char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
> > +       char *p = sym, *pend = sym + sizeof(sym);
> > +
> > +       *p++ = '[';
> > +       p = string_nocheck(p, pend, "range ", default_str_spec);
> > +       p = special_hex_number(p, pend, range->start, sizeof(range->start));
> > +       *p++ = '-';
> > +       p = special_hex_number(p, pend, range->end, sizeof(range->end));
> > +       *p++ = ']';
> > +       *p = '\0';
> > +
> > +       return string_nocheck(buf, end, sym, spec);
> > +}
> 
> I agree that there is not much duplicated code in the end.
> 
> > Also this is the bulk of the patch except for documentation and the new
> > testing code.  [new patch below]
> > 
> > Am I missing your point somehow?  I considered cramming a struct range into a
> > struct resource to let resource_string() process the data.  But that would
> > involve creating a new IORESOURCE_* flag (not ideal) and also does not allow
> > for the larger u64 data in struct range should this be a 32 bit physical
> > address config.
> 
> This would be nasty. I believe that this is not what Andy meant.

Nope.

> 
> Best Regards,
> Petr
> 
> PS: I have vacation until the end of the week, so my next eventual
>     reaction would be delayed.

No hurry.  I'm still mucking around with it,
Ira

