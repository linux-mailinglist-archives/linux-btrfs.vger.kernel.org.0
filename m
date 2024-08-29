Return-Path: <linux-btrfs+bounces-7669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C29651B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477851C227ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D6D1BAEFE;
	Thu, 29 Aug 2024 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKSqYN2T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29A1BAED6;
	Thu, 29 Aug 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966223; cv=fail; b=Kv/hxk7hQhRP8/fDLm1vsqtftCpT/n60zWkMrtibCObe4EMK0dpkWVCx6J9gdchoOPsmSIvsoAq6knuz/CSJb+F7whSrFIjuisKWNDIIqulgzXRrS32E9ykO2Jg+J7ZWG+Xmc1CHHc6VnLCxFT5ba17jlFzCZZlpqO8GtgZ0WQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966223; c=relaxed/simple;
	bh=OkSzBER1tCDHqCakICMWzDv8gdL5CY5O07UMGPgMTlk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m0NC5LHnt6qozYzEcpkCXrzdBF2tJ3lHMYcSJpPOuvp2PdDSOIsMTUvksyenjSY9SmKfiXSh8f6lJtu7RURPxBjE+061RG0DxnbSgD5wWAgiv6/wsLyr2qAEEF43CYGHde34STn/myij3jUOzfsEVoTnKcpJXbo/RAijdz8w6nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKSqYN2T; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724966222; x=1756502222;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OkSzBER1tCDHqCakICMWzDv8gdL5CY5O07UMGPgMTlk=;
  b=ZKSqYN2TQtqI5GOr1PSRtHpd8Ij/3DLZ6dXKzIOK7CT15S+VLIV44bAE
   FO77HHSRfxfqa6UBfRquJhaxXNzhx6VYTsqP9rV046FJ8avo3EURi11nM
   0XrtLvg7gJL8Rfc3WxSSwpY2V/eoZcPFxxqUWXp/hendPd6RNMx9TEOsE
   MnwAm4aAaZcUmprIymI2Cc2EI9+MIhvYUhYKixGK8+ZRmEJH5uuckjdbB
   0Vi1UR2MyCeXb7TlBLc8nmNYtXVn4DiP5GNHYgWVUcO8++TED6LEqXM/C
   lU6WrWnp3Ry7KSwEW5GltNGrRt3gE6BFljw7AFo8HLIltNql1Ug8fICjs
   A==;
X-CSE-ConnectionGUID: DIPPFe8hRvymKf2WIJ47jg==
X-CSE-MsgGUID: uEfkgVF1SLeQ9N1Wwx7pjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23453102"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23453102"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:17:00 -0700
X-CSE-ConnectionGUID: sR7fQbCpSleqLIAYCEnw2w==
X-CSE-MsgGUID: 2n7ZzfksRieI97udP25/jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63697152"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 14:16:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 14:16:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 14:16:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 14:16:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 14:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw8cs6CYQTNdb2yBbRBCu8NVQuI0CSmld0HWWKEodIEcZEm4tifTo01AjT2TCSjdqtlquUS8bOaCQqR3tRqb4fJLXDTLniMWYOVMF7IRzy2MdjQG2T2Ik0QO00NvXO52rAHEtWSOuyp5V4KCezKNI5AVSAZ8UOEdgemozWQ+F15nIc9pEuQzuB/M1UoQZS6u/ipQTrXi0cAOGLyGMbb2tmka2Np/PrE2vviDTDCD2ZA9W1rEjruMGKYSh8ilqwlesba+lxVj+aDacAfLFTsnvoX3A0LItDKJ92uC0gNhL1upj9nPrt+a+8A52cWLgZvltqEC4eJhZC44/dQ2rhVHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnspQfBWmI1rN26mTcKiTbAmSLkpHTPP8UiQ2zH4HVg=;
 b=EQAq0w4dCTCkZlnqHdxh4hhIiIht2hQvWluEEs8eAnwtm5ANlVPoFU2VaBum7Fjjsq7T4zWbEG6EJJfFssYoXJ4rDTs5S6YNc4JYiYicsj4sfO+JirtWGl7TfE4qmpgDEGhMeoKfKYKGOASUZRy6nkuc7UERf0EHtUp1Khd9QSRtXBWTEgiRjx0paW4TM7kfVzOD9a7ClNapzJj8heJcfCQ+UCHkGyjBC0e32/lnI0QIotCQeVF6lAbVUNryTAQEe+ycQuJHrbHNBQOxKSwOZ16vQbWtH56I54DwZWkFUKieIL70LId7FesiNL9EBvBWSCA/EWxZnVjaOMAtS0Igpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8474.namprd11.prod.outlook.com (2603:10b6:806:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 21:16:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:16:53 +0000
Date: Thu, 29 Aug 2024 16:16:46 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
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
Subject: Re: [PATCH v3 18/25] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <66d0e53e9d3e9_f937b294b7@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-18-7c9b96cba6d7@intel.com>
 <20240827141852.0000553d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827141852.0000553d@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: be6e7256-73d3-438f-c53f-08dcc86fe7cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VxrgHbUOw6LD14MBUsCePabmM/NZHqw/lIwBdS0yvv9zSdIXqt6N7iKoFi0G?=
 =?us-ascii?Q?DqnArtsYF1l5yBP2BdYwAXKvMnLfaERMBpsA6QH1Sa4OdPSoVUhNvNP+bZuw?=
 =?us-ascii?Q?ah4m/H4rHPkccTbVQ+G23GWewdTCufCbRcGXSNW9UHkwdQ2c1YfPG6KvxcJz?=
 =?us-ascii?Q?Tz8MrET09njD63ivlrknKcs1wmKrsR1tCfyirgRqTMsh/d9mDh6dXLDZaSgL?=
 =?us-ascii?Q?v7b4LSbsiBLT7fw6gPKQnw71HZ15hXDjkX5E2WgwflDEByaPOTqG11Pz4x7X?=
 =?us-ascii?Q?nIgqS/KXL6jluuj4IUpgZUiTNlANUBS4keHqTdwNv6Hp9ZvSmFCx9Se9Yckp?=
 =?us-ascii?Q?KH/CLck2V1wUVpuYrW9vYtrF/1s8R0qOugCDc8tElSV51gObB9d9NYjB3Wgw?=
 =?us-ascii?Q?UAoUqcuILEAwJ9SOsgbLmlx8R3W1rRsAweK8spRXfqAMx4cx2N8/V3F53uwH?=
 =?us-ascii?Q?2tZ6PpMwfELQJ5xOavr9rSN8N+AOj+iunnJpQR1OhC96v4X3XY/ntPjavrma?=
 =?us-ascii?Q?unKLClV6Ur2uTcNwo5rEqx228SkBjCxldmJsPbk/4sFLR6AeHqYuNH6FdJSh?=
 =?us-ascii?Q?c2S6u4nW4uUv/Qet2aqNLqVpqcp27ZOBXxpy+p3CNf/rwgkWp7J8kLhKWPPi?=
 =?us-ascii?Q?eZMQhb3iyRgyqvotnJOsh0JC+T2Z6FYvntXgNj3xGw83WHvnvjFQiX70q+u8?=
 =?us-ascii?Q?H7myyAPNw3vhvLaMx6gZq1BmkRf7uQalXxp2jJKF71SDnwUZNd3/d0StNYFk?=
 =?us-ascii?Q?tVahH3Tk9oV6aervIotmdOoC03kEfUNNbXG4kT15klIuixArkw/uuM/k2vPB?=
 =?us-ascii?Q?GsniCY4HZ9A0GWpFnoqKXCoMhamomf4ig4yEB19AM0l6bKg2+k68YDCNCHrZ?=
 =?us-ascii?Q?v+IhnmfSIwTSqTJdGwhvJO+ai07UgFcalpnaVzutVi5vIILETfuyDZn6yoKL?=
 =?us-ascii?Q?zMgG82lh5/PsY7Pu6fucljG7uvN2dPGeg5tidc9cUYxS4kQGDBo3Td3fLhXl?=
 =?us-ascii?Q?V/C3l4CETpWpN7hcU9J6D/dvvGvAGUswI6HIWvBZcYnkedf/IHEDtgYIkVIC?=
 =?us-ascii?Q?0y46qGrGq77qLhRuZ1JRPvjEqSdR8jGxWYNrVk6Y33RiuEXv4m4FvskNccZE?=
 =?us-ascii?Q?PHOgxZGKzwgLk6cvNYcsfNPJkl1OIp7CGwseTsDiTHQB3QybVmMcayNtZ3uM?=
 =?us-ascii?Q?UwDXy1RtmJx3i+olw6A4ejQWdaZ+h0dO9unU6W6LJgH6rxKnz/bhxuYXSEf+?=
 =?us-ascii?Q?EpZDmA8kaX66mBojSj0cAggq99vuEvS04GGIIXPWXFi1gB/h57dyfIbG6MNt?=
 =?us-ascii?Q?XfqLtccVuv/PcVchYah2v/Hf1uoS9goxm17A+bdKOSzVzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FFp+zUcxMg2Ua4RiL0DeC82ZBMoWCOW4CN+bmPt+IrmFabdXIxTgFwMM5CmA?=
 =?us-ascii?Q?s7A3CfIPX228x1H0Ys8nTwf7i/yq5/GrAkvJT2Q6mxcwubHvgpvPPNdXZvYw?=
 =?us-ascii?Q?Oqm3POM21Ye7RTJziXmqD7uZRWe2JYKYMjWl/Wqz8iYyBMn8LsmjQVb4+n9l?=
 =?us-ascii?Q?WT6Kcakr7XqOpXw3F+2MoNYY5G+TAN+ObApML47zSGQj3ZNEO7T2uuZHGekl?=
 =?us-ascii?Q?9DZP7PxsNQ4sBQTSfmkBQwiNgssl82tvD9j4usimVCQsjJAZOGqy1uAdODgP?=
 =?us-ascii?Q?hqMvqLPsJd8oETMyr1gfpb1vmPdh+uuirG9nukSZeoT7DDoKGSIvYEHcJDTB?=
 =?us-ascii?Q?7b9NoFFMLc2vV3cJmTRGIN/HjCs5lig9FFSKnHRvSkIz/isbxGRVIpDM8WOM?=
 =?us-ascii?Q?guW97aYBYAJlX9Ll3Ed1yYtl3dOkSAyZMHvfgp3Wa10eJzW7fv76DbV8elmA?=
 =?us-ascii?Q?9strXTiPWWhtNOjPdxVAaaIz7er9h+Ybp7qY6wZFZayVCcp3n1RpJyWN+WmB?=
 =?us-ascii?Q?nudOXAZdAm5wqxPIU+pan7jWtIj+GhsQ+Db5v+s4yC07ZbvNml2wOT3kuUzc?=
 =?us-ascii?Q?g6pqtx9mn4RxqiuSfctsdkkInsoEhev4gJpZ20obcCEQiQg3vCJjgrrauHYB?=
 =?us-ascii?Q?WQ/FmuUhtC9ZCFLHKbxAOuxU766G1tnVhVPxuEcpG84jlWnPRC69xXdPkUll?=
 =?us-ascii?Q?gUwmnPVtQt1uv5ugvWe82dgGAZeqxYfq1dImRdhRygIWvhBr+4UFo7GJ6eDq?=
 =?us-ascii?Q?9sX3OQ0hLGGvL6fxQQu0iNkr3k8d9JrstqgYnsyu3SLjmxHrBEALUil3/qJK?=
 =?us-ascii?Q?bS15sUUBqy3tlb6EOhxO6V+tjCTDnw//p5HvV42/QMF98AMRh50QVreYHJBN?=
 =?us-ascii?Q?+yLrsfFD7ncaccOYqe0HzdNsYA+Lm9iflbLJbcRzcvb6DIbhFV7A3A2wUQp/?=
 =?us-ascii?Q?q9eNJqZTAb2zn8s8vDHXHgDs+mEi5hbzGLVWQqD5CxPfg4FdUv+C6jq9u6Ky?=
 =?us-ascii?Q?v17oWsKoCnzX3auc6f3uMZxTm5bcs7aOUGuud9pajtOV6Xu4iwsRdKsfrozw?=
 =?us-ascii?Q?vrAMseLTgp/vKMv4McSkDIXORufLA4p8Zp0JkioZNbiEM5zKK54jXOoYyj+6?=
 =?us-ascii?Q?mVwWx73fJXx9wnTpbPB5N2ZzQM2bsYt9o9NFTA1j2V3Eoz8igf6C7AKvWcZe?=
 =?us-ascii?Q?Ij7ebz+NoA1gzJxy+M0i5iETZuS8gy8UvBaljTFi+YZ0+lUJqptlGODgTSA1?=
 =?us-ascii?Q?44T/ZYy2+EDuwrQJHJUDKcJxzR/fWbaiNsrZAiuINBKONyPHhsy9ncjAukZ3?=
 =?us-ascii?Q?qX64U4ywp8abipIMSDE+eAGWQfKmo9fdWzX/tFKWHKPh5J4ZMiZU8YxNAzS6?=
 =?us-ascii?Q?iqMQGNMaCva1fwWoRBZXSeLrnm+kqh08VKDCgbrIi+H5D18p+DwlM3Uf2jWY?=
 =?us-ascii?Q?vFR+DKtINeC/xjhwIzCPljW4muEWX70GXosUJM2PB0HBZElCXauzN8xGWfTf?=
 =?us-ascii?Q?XcitoB8QejC4FiuC5GgSpuUImf8OAuaUUpZKLQZoYMEGA75o/mvqcuPf/Wjl?=
 =?us-ascii?Q?dMRxQE4ydCerN9nEUukB3hsL/FjlsiggJr4lzWXG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be6e7256-73d3-438f-c53f-08dcc86fe7cb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:16:53.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6uE6tUy46rDhYaCsyhmNzBy49iKZodduc3AHhjk8NGrR1DKb+YpdBh37Z9AQn4xYbxQzZdjQLf5+LVv6aG76A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8474
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 16 Aug 2024 09:44:26 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > +static int match_contains(struct device *dev, void *data)
> > +{
> > +	struct region_extent *region_extent = to_region_extent(dev);
> > +	struct match_data *md = data;
> > +	struct cxled_extent *entry;
> > +	unsigned long index;
> > +
> > +	if (!region_extent)
> > +		return 0;
> > +
> > +	xa_for_each(&region_extent->decoder_extents, index, entry) {
> > +		if (md->cxled == entry->cxled &&
> > +		    range_contains(&entry->dpa_range, md->new_range))
> > +			return true;
> As below, this returns int, so shouldn't be true or false.

Yep.  Thanks.

> 
> > +	}
> > +	return false;
> > +}
> 
> > +static int match_overlaps(struct device *dev, void *data)
> > +{
> > +	struct region_extent *region_extent = to_region_extent(dev);
> > +	struct match_data *md = data;
> > +	struct cxled_extent *entry;
> > +	unsigned long index;
> > +
> > +	if (!region_extent)
> > +		return 0;
> > +
> > +	xa_for_each(&region_extent->decoder_extents, index, entry) {
> > +		if (md->cxled == entry->cxled &&
> > +		    range_overlaps(&entry->dpa_range, md->new_range))
> > +			return true;
> 
> returns int, so returning true or false is odd.

Yep.

> 
> > +	}
> > +
> > +	return false;
> > +}
> 
> 
> > +int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> > +{
> > +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct range hpa_range, dpa_range;
> > +	struct cxl_region *cxlr;
> > +
> > +	dpa_range = (struct range) {
> > +		.start = start_dpa,
> > +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> > +	};
> > +
> > +	guard(rwsem_read)(&cxl_region_rwsem);
> > +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> > +	if (!cxlr) {
> > +		memdev_release_extent(mds, &dpa_range);
> 
> How does this condition happen?  Perhaps a comment needed.

Fair enough.  Proposed comment.

	/*
	 * No region can happen here for a few reasons:
	 *
	 * 1) Extents were accepted and the host crashed/rebooted
	 *    leaving them in an accepted state.  On reboot the host
	 *    has not yet created a region to own them.
	 *
	 * 2) Region destruction won the race with the device releasing
	 *    all the extents.  Here the release will be a duplicate of
	 *    the one sent via region destruction.
	 *
	 * 3) The device is confused and releasing extents for which no
	 *    region ever existed.
	 *
	 * In all these cases make sure the device knows we are not
	 * using this extent.
	 */

Item 2 is AFAICS ok with the spec.

> 
> > +		return -ENXIO;
> > +	}
> > +
> > +	calc_hpa_range(cxled, cxlr->cxlr_dax, &dpa_range, &hpa_range);
> > +
> > +	/* Remove region extents which overlap */
> > +	return device_for_each_child(&cxlr->cxlr_dax->dev, &hpa_range,
> > +				     cxlr_rm_extent);
> > +}
> > +
> > +static int cxlr_add_extent(struct cxl_dax_region *cxlr_dax,
> > +			   struct cxl_endpoint_decoder *cxled,
> > +			   struct cxled_extent *ed_extent)
> > +{
> > +	struct region_extent *region_extent;
> > +	struct range hpa_range;
> > +	int rc;
> > +
> > +	calc_hpa_range(cxled, cxlr_dax, &ed_extent->dpa_range, &hpa_range);
> > +
> > +	region_extent = alloc_region_extent(cxlr_dax, &hpa_range, ed_extent->tag);
> > +	if (IS_ERR(region_extent))
> > +		return PTR_ERR(region_extent);
> > +
> > +	rc = xa_insert(&region_extent->decoder_extents, (unsigned long)ed_extent, ed_extent,
> 
> I'd wrap that earlier to keep the line a bit shorter.

Done.

> 
> > +		       GFP_KERNEL);
> > +	if (rc) {
> > +		free_region_extent(region_extent);
> > +		return rc;
> > +	}
> > +
> > +	/* device model handles freeing region_extent */
> > +	return online_region_extent(region_extent);
> > +}
> > +
> > +/* Callers are expected to ensure cxled has been attached to a region */
> > +int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> > +{
> > +	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct range ed_range, ext_range;
> > +	struct cxl_dax_region *cxlr_dax;
> > +	struct cxled_extent *ed_extent;
> > +	struct cxl_region *cxlr;
> > +	struct device *dev;
> > +
> > +	ext_range = (struct range) {
> > +		.start = start_dpa,
> > +		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> > +	};
> > +
> > +	guard(rwsem_read)(&cxl_region_rwsem);
> > +	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> > +	if (!cxlr)
> > +		return -ENXIO;
> > +
> > +	cxlr_dax = cxled->cxld.region->cxlr_dax;
> > +	dev = &cxled->cxld.dev;
> > +	ed_range = (struct range) {
> > +		.start = cxled->dpa_res->start,
> > +		.end = cxled->dpa_res->end,
> > +	};
> > +
> > +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent %par\n",
> > +		cxled->dpa_res, &ext_range);
> > +
> > +	if (!range_contains(&ed_range, &ext_range)) {
> > +		dev_err_ratelimited(dev,
> > +				    "DC extent DPA %par (%*phC) is not fully in ED %par\n",
> > +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> > +				    extent->tag, &ed_range);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (extents_contain(cxlr_dax, cxled, &ext_range))
> 
> This case confuses me. If the extents are already there I think we should
> error out or at least print something as that's very wrong.

I thought we discussed this in one of the community meetings that it would be
ok to accept these.  We could certainly print a warning here.

In all honestly I'm wondering if these restrictions are really needed anymore.
But at the same time I really, really, really don't think anyone has a good use
case to have to support these cases.  So I'm keeping the code simple for now.

> 
> > +		return 0;
> > +
> > +	if (extents_overlap(cxlr_dax, cxled, &ext_range))
> > +		return -ENXIO;
> > +
> > +	ed_extent = kzalloc(sizeof(*ed_extent), GFP_KERNEL);
> > +	if (!ed_extent)
> > +		return -ENOMEM;
> > +
> > +	ed_extent->cxled = cxled;
> > +	ed_extent->dpa_range = ext_range;
> > +	memcpy(ed_extent->tag, extent->tag, CXL_EXTENT_TAG_LEN);
> > +
> > +	dev_dbg(dev, "Add extent %par (%*phC)\n", &ed_extent->dpa_range,
> > +		CXL_EXTENT_TAG_LEN, ed_extent->tag);
> > +
> > +	return cxlr_add_extent(cxlr_dax, cxled, ed_extent);
> > +}
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 01a447aaa1b1..f629ad7488ac 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -882,6 +882,48 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> > +			       struct cxl_extent *extent)
> > +{
> > +	u64 start = le64_to_cpu(extent->start_dpa);
> > +	u64 length = le64_to_cpu(extent->length);
> > +	struct device *dev = mds->cxlds.dev;
> > +
> > +	struct range ext_range = (struct range){
> > +		.start = start,
> > +		.end = start + length - 1,
> > +	};
> > +
> > +	if (le16_to_cpu(extent->shared_extn_seq) != 0) {
> 
> That's not the 'main' way to tell if an extent is shared because
> we could have a single extent (so seq == 0).
> Should verify it's not in a DCD region that
> is shareable to make this decision.

Ah...  :-/

> 
> I've lost track on the region handling so maybe you already do
> this by not including those regions at all?

I don't think so.

I'll add the region check.  I see now why I glossed over this though.  The
shared nature of a DCD partition is defined in the DSMAS.

Is that correct?  Or am I missing something in the spec?

> 
> > +		dev_err_ratelimited(dev,
> > +				    "DC extent DPA %par (%*phC) can not be shared\n",
> > +				    &ext_range.start, CXL_EXTENT_TAG_LEN,
> > +				    extent->tag);
> > +		return -ENXIO;
> > +	}
> > +
> > +	/* Extents must not cross DC region boundary's */
> > +	for (int i = 0; i < mds->nr_dc_region; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +		struct range region_range = (struct range) {
> > +			.start = dcr->base,
> > +			.end = dcr->base + dcr->decode_len - 1,
> > +		};
> > +
> > +		if (range_contains(&region_range, &ext_range)) {
> > +			dev_dbg(dev, "DC extent DPA %par (DCR:%d:%#llx)(%*phC)\n",
> > +				&ext_range, i, start - dcr->base,
> > +				CXL_EXTENT_TAG_LEN, extent->tag);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	dev_err_ratelimited(dev,
> > +			    "DC extent DPA %par (%*phC) is not in any DC region\n",
> > +			    &ext_range, CXL_EXTENT_TAG_LEN, extent->tag);
> > +	return -ENXIO;
> > +}
> > +
> >  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  			    enum cxl_event_log_type type,
> >  			    enum cxl_event_type event_type,
> > @@ -1009,6 +1051,207 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >  	return rc;
> >  }
> >  
> > +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> > +				struct xarray *extent_array, int cnt)
> > +{
> > +	struct cxl_mbox_dc_response *p;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	struct cxl_extent *extent;
> > +	unsigned long index;
> > +	u32 pl_index;
> > +	int rc = 0;
> > +
> > +	size_t pl_size = struct_size(p, extent_list, cnt);
> > +	u32 max_extents = cnt;
> > +
> What is cnt is zero? All extents rejected so none in the
> extent_array. Need to send a zero extent response to reject
> them all IIRC.

yes.  I missed that thanks.

> 
> > +	/* May have to use more bit on response. */
> > +	if (pl_size > mds->payload_size) {
> > +		max_extents = (mds->payload_size - sizeof(*p)) /
> > +			      sizeof(struct updated_extent_list);
> > +		pl_size = struct_size(p, extent_list, max_extents);
> > +	}
> > +
> > +	struct cxl_mbox_dc_response *response __free(kfree) =
> > +						kzalloc(pl_size, GFP_KERNEL);
> > +	if (!response)
> > +		return -ENOMEM;
> > +
> > +	pl_index = 0;
> > +	xa_for_each(extent_array, index, extent) {
> > +
> > +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> > +		response->extent_list[pl_index].length = extent->length;
> > +		pl_index++;
> > +		response->extent_list_size = cpu_to_le32(pl_index);
> > +
> > +		if (pl_index == max_extents) {
> > +			mbox_cmd = (struct cxl_mbox_cmd) {
> > +				.opcode = opcode,
> > +				.size_in = struct_size(response, extent_list,
> > +						       pl_index),
> > +				.payload_in = response,
> > +			};
> > +
> > +			response->flags = 0;
> > +			if (pl_index < cnt)
> > +				response->flags &= CXL_DCD_EVENT_MORE;
> > +
> > +			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +			if (rc)
> > +				return rc;
> > +			pl_index = 0;
> > +		}
> > +	}
> > +
> > +	if (pl_index) {
> || !cnt 
> 
> I think so we send a nothing accepted message.

Yep.

> 
> > +		mbox_cmd = (struct cxl_mbox_cmd) {
> > +			.opcode = opcode,
> > +			.size_in = struct_size(response, extent_list,
> > +					       pl_index),
> > +			.payload_in = response,
> > +		};
> > +
> > +		response->flags = 0;
> > +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> 		if (rc)
> 			return rc;
> > +	}
> > +
> 
> return 0;  So that reader doesn't have to check what rc was in !pl_index
> case and avoids assigning rc right at the top.

Ah thanks.  That might have been left over from something previous.

> 
> 
> > +	return rc;
> > +}
> 
> 
> > +static int cxl_add_pending(struct cxl_memdev_state *mds)
> > +{
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_extent *extent;
> > +	unsigned long index;
> > +	unsigned long cnt = 0;
> > +	int rc;
> > +
> > +	xa_for_each(&mds->pending_extents, index, extent) {
> > +		if (validate_add_extent(mds, extent)) {
> 
> 
> Add a comment here that not accepting an extent but
> accepting some or none means this one was rejected (I'd forgotten how
> that bit worked)

Ok yeah that may not be clear without reading the spec closely.

	/*
	 * Any extents which are to be rejected are omitted from
	 * the response.  An empty response means all are
	 * rejected.
	 */

> 
> > +			dev_dbg(dev, "unconsumed DC extent DPA:%#llx LEN:%#llx\n",
> > +				le64_to_cpu(extent->start_dpa),
> > +				le64_to_cpu(extent->length));
> > +			xa_erase(&mds->pending_extents, index);
> > +			kfree(extent);
> > +			continue;
> > +		}
> > +		cnt++;
> > +	}
> > +	rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
> > +				  &mds->pending_extents, cnt);
> > +	xa_for_each(&mds->pending_extents, index, extent) {
> > +		xa_erase(&mds->pending_extents, index);
> > +		kfree(extent);
> > +	}
> > +	return rc;
> > +}
> > +
> > +static int handle_add_event(struct cxl_memdev_state *mds,
> > +			    struct cxl_event_dcd *event)
> > +{
> > +	struct cxl_extent *tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> > +	struct device *dev = mds->cxlds.dev;
> > +
> > +	if (!tmp)
> > +		return -ENOMEM;
> > +
> > +	memcpy(tmp, &event->extent, sizeof(*tmp));
> 
> kmemdup?

yep.

> 
> > +	if (xa_insert(&mds->pending_extents, (unsigned long)tmp, tmp,
> > +		      GFP_KERNEL)) {
> > +		kfree(tmp);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (event->flags & CXL_DCD_EVENT_MORE) {
> > +		dev_dbg(dev, "more bit set; delay the surfacing of extent\n");
> > +		return 0;
> > +	}
> > +
> > +	/* extents are removed and free'ed in cxl_add_pending() */
> > +	return cxl_add_pending(mds);
> > +}
> 
> >  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  				    enum cxl_event_log_type type)
> >  {
> > @@ -1044,9 +1287,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  		if (!nr_rec)
> >  			break;
> >  
> > -		for (i = 0; i < nr_rec; i++)
> > +		for (i = 0; i < nr_rec; i++) {
> >  			__cxl_event_trace_record(cxlmd, type,
> >  						 &payload->records[i]);
> > +			if (type == CXL_EVENT_TYPE_DCD) {
> Bit of a deep indent so maybe flip logic?
> 
> Logic wise it's a bit dubious as we might want to match other
> types in future though so up to you.

I was thinking more along these lines.  But the rc is unneeded.  That print
can be in the handle function.


Something like this:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 88b823afe482..e86a483d80eb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1231,16 +1231,17 @@ static char *cxl_dcd_evt_type_str(u8 type)
        return "<unknown>";
 }

-static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
+static void cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
                                        struct cxl_event_record_raw *raw_rec)
 {
        struct cxl_event_dcd *event = &raw_rec->event.dcd;
        struct cxl_extent *extent = &event->extent;
        struct device *dev = mds->cxlds.dev;
        uuid_t *id = &raw_rec->id;
+       int rc;

        if (!uuid_equal(id, &CXL_EVENT_DC_EVENT_UUID))
-               return -EINVAL;
+               return;

        dev_dbg(dev, "DCD event %s : DPA:%#llx LEN:%#llx\n",
                cxl_dcd_evt_type_str(event->event_type),
@@ -1248,15 +1249,22 @@ static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,

        switch (event->event_type) {
        case DCD_ADD_CAPACITY:
-               return handle_add_event(mds, event);
+               rc = handle_add_event(mds, event);
+               break;
        case DCD_RELEASE_CAPACITY:
-               return cxl_rm_extent(mds, &event->extent);
+               rc = cxl_rm_extent(mds, &event->extent);
+               break;
        case DCD_FORCED_CAPACITY_RELEASE:
                dev_err_ratelimited(dev, "Forced release event ignored.\n");
-               return 0;
+               rc = 0;
+               break;
        default:
-               return -EINVAL;
+               rc = -EINVAL;
+               break;
        }
+
+       if (rc)
+               dev_err_ratelimited(dev, "dcd event failed: %d\n", rc);
 }

 static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
@@ -1297,13 +1305,9 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
                for (i = 0; i < nr_rec; i++) {
                        __cxl_event_trace_record(cxlmd, type,
                                                 &payload->records[i]);
-                       if (type == CXL_EVENT_TYPE_DCD) {
-                               rc = cxl_handle_dcd_event_records(mds,
-                                                                 &payload->records[i]);
-                               if (rc)
-                                       dev_err_ratelimited(dev, "dcd event failed: %d\n",
-                                                           rc);
-                       }
+                       if (type == CXL_EVENT_TYPE_DCD)
+                               cxl_handle_dcd_event_records(mds,
+                                                       &payload->records[i]);
                }

                if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
<end diff>

> 
> 			if (type != CXL_EVENT_TYPE_DCD)
> 				continue;
> 
> 			rc = 
> 
> > +				rc = cxl_handle_dcd_event_records(mds,
> > +								  &payload->records[i]);
> > +				if (rc)
> > +					dev_err_ratelimited(dev, "dcd event failed: %d\n",
> > +							    rc);
> > +			}
> > +		}
> >  
> 
> >  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> >  {
> >  	struct cxl_memdev_state *mds;
> > @@ -1628,6 +1892,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> >  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> >  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
> >  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
> > +	xa_init(&mds->pending_extents);
> > +	devm_add_action_or_reset(dev, clear_pending_extents, mds);
> 
> Why don't you need to check if this failed? Definitely seems unlikely
> to leave things in a good state. Unlikely to fail of course, but you never know.

yea good catch.

> 
> >  
> >  	return mds;
> >  }
> 
> > @@ -3090,6 +3091,8 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> >  
> >  	dev = &cxlr_dax->dev;
> >  	cxlr_dax->cxlr = cxlr;
> > +	cxlr->cxlr_dax = cxlr_dax;
> > +	ida_init(&cxlr_dax->extent_ida);
> >  	device_initialize(dev);
> >  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> >  	device_set_pm_not_required(dev);
> > @@ -3190,7 +3193,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> >  static void cxlr_dax_unregister(void *_cxlr_dax)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> > +	struct cxl_region *cxlr = cxlr_dax->cxlr;
> >  
> > +	cxlr->cxlr_dax = NULL;
> > +	cxlr_dax->cxlr = NULL;
> 
> cxlr_dax->cxlr was assigned before this patch. 
> 
> I'm not seeing any new checks on these being non null so why
> are the needed?  If there is a good reason for this then
> a comment would be useful.

I'm not sure anymore either.  Perhaps this was left over from an earlier
version.  Or was something I thought I would need that ended up getting
removed.  I'll test without this hunk and remove it if I can.

Thanks for the review,
Ira

[snip]

