Return-Path: <linux-btrfs+bounces-7673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC396526F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0908C1F24D50
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F61BAEC8;
	Thu, 29 Aug 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfGAcodG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE718B460;
	Thu, 29 Aug 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968482; cv=fail; b=SWlAsSyT77fKYEtlltFJW989amQqpJ0YsLGHj5ZsjNz8lBKvjmywFY5stDkVLtwryhPX/H9qz7veteVzDHX4zfLcFBdkuRm8naYKJQZ3GtrSN1KFRIhgjLQEAVTDf8+/OwpTJ3cnJ8Z0oJ7HBPRhy072bFOjzS9kaFkb/abK79c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968482; c=relaxed/simple;
	bh=C6EA8Ivj8Q5+rlyGWyAYnvGab0AnPB8puEI/tx0Tl04=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VvFb4uU22hzRNhfFe7dC4kz+5pISajBjHnECJXBabsXd/TFlgfAtdh1XanLJ374nzbOlK2RWq+pNpLETWvNPzEYBT7AA9/UyIl9/CVLivsNRXeE7Jm6QTmTDgfbLR3WXmcCpixyD7PYXh+VjfOMUrZj+/Oz9aBGKv17+iCDSmXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfGAcodG; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724968481; x=1756504481;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C6EA8Ivj8Q5+rlyGWyAYnvGab0AnPB8puEI/tx0Tl04=;
  b=MfGAcodGK8g8b9cdxdcILwef5LjbWLUxieKvIr3WmgM1l9M6Y9OP0vpz
   Xf6Eis0QLIgr6+TtH7u9jzVBmfheppRP25K8XyDJNVKMjAEEMuV3qCMNb
   abvtFJcg6dd9BwfN4K2XAYoW4wY6C/lEZrPwmGJsdsQwL8i3tQ3c2Em09
   18d7xkEDw9C9LJKn7c0U6JYWHZ/IMdxiRGHah6eWbJ0zqGy29yILkErtM
   NhHNho5XCl5lgCJP+kb4eIduEr3EYbwU3rNNXppDcJ3G92TgpAcUw5D4k
   WRImVOUvhTH9qEsdadzz2IV0Kc8tZpM54VfZSj/CwNc4Z8Mq/Nsgpv9aw
   g==;
X-CSE-ConnectionGUID: 14UAcWRZQfawrqSJIGcqDA==
X-CSE-MsgGUID: Vnq5ZpUiRg2eUeGvEONWjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23736515"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23736515"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:54:40 -0700
X-CSE-ConnectionGUID: Wi5EG/TVQPqmH0Wx7hoy/Q==
X-CSE-MsgGUID: ZkqLUveIQL6Rn4LwvA/PWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63553624"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 14:54:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 14:54:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 14:54:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 14:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7OKQmmTpOIPSS7ZKeJAklNEvFl5XULEDeFMtoWhxVnPyKjPpEDLNPQRM7htVi5+KRQL2mLeZvXXAU2TjudR6GCoqxEArunc7PwWDQOTfAr9FDm+KY87h9p+kKxArt8C7UBek9rSpk5foc26NfB0/tnjVpX+fM6OepSXIYDckB7BakYaerbuT84BaJIG/pP12nQVYAI1DNW/EXfMgibSYIJpX98zMMVawTYLxBQHVl9RJuYD3nkH8zHqesO6nRDfhXfXcCNH8ymxRPmsQDSbE/sIp10mS5neQbnGdImmFlN9/4M32eDCuRxJp6aT9uf2F+n9KEWAPiRZdG+8sLJJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1SyhfgIWAUs+VLzaYFpqSApQN4jMJtkBCpIrN4NekQ=;
 b=YwEYmyOeMoaNkPQ8R1Rj9hr2btAUNPmt8JzZy6wNVKEjuYjj7V3NNmxhR9943gt7oQ73aGYlDYvzz3cuLUQW7lLGDDUI5fO3J7AgeKZsE/xPU18/+PUK18PKgQnebYsm57G4eF4yaa0Pfr7GEENG2w3UecoXnC11M/bVtDQQxJ7IGAfKnNovqxYZw48Flmmq2j1fThLw+BVbXVbzHimAN2iywYwCm+b44uH88qQlzN+3pWywofz70L/H53MtNgWZ12B5I+5fSDwPzlx4PZ2eE3ODb4b+HWloz1ihRo93eacZZMtxoXuLMxHtmivR4rXSxCHcwTUuGzsrzr3D/ZLjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 21:54:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:54:34 +0000
Date: Thu, 29 Aug 2024 16:54:29 -0500
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
Subject: Re: [PATCH v3 21/25] dax/region: Create resources on sparse DAX
 regions
Message-ID: <66d0ee1581f0b_f937b29425@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-21-7c9b96cba6d7@intel.com>
 <20240827151237.00000f2b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827151237.00000f2b@Huawei.com>
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cc30ca-30ef-4863-9b5a-08dcc8752b77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SSspJrl1BfOF9TNL+06dMvO6xGa0nMq8ObBKeo0tUFbJtdp+gQM3HSg033ch?=
 =?us-ascii?Q?x/NVrWXfZfOy2wP/yOktroAihHbuS3/4S2bjYBu0Z+JkT9z/lN/w5mMcHz1l?=
 =?us-ascii?Q?lu78gQRDNBunNHTRODObAmkL7rGirmf388zeuEhZQ8/YgeVTP9dCaAilgRWH?=
 =?us-ascii?Q?2+awkrPJl61Xxl0uhHZpczW39U+9C9tAQOjgZKFYkoWwcXhpheSGWAMRgn6s?=
 =?us-ascii?Q?KIkAW89yOO0ffg/QJnD7E7+Mh0e2o/VezeXSKcivmlnr6dQRujlcgDTL7aqp?=
 =?us-ascii?Q?VH8cT03owEtX89Bfgbbq7twTcfu6npDjL4UM2Grlk8V7Ig5N2kkjGKlcv7WI?=
 =?us-ascii?Q?xtu08LKf1O3z8oJJ7wAiMSkFXtZ+e4FNuoaIkAlpDVG497omaYoflPV74R+c?=
 =?us-ascii?Q?VZQlSfSnf+Icc1aJkyf54JeKS/9Rxp8el+pIJUY5tPvHvXtfCETc/gBByGCM?=
 =?us-ascii?Q?t2xlMMZD9SsZcrdOLxm+E1jv9DhB5X07yE4cXoVBrU5OxBpJOwu8btJZqaGM?=
 =?us-ascii?Q?Kpheyw4RZ8ZBtNlOWQ5+ocwZBH5Pmg1VZaTa9dwizGuG76kM254BCMRlAe/h?=
 =?us-ascii?Q?i6MtB01q7u9HYJ7xQspCSppMbIygNm0NCO4yxmLX0zedfM3bkru1BYaq/jwZ?=
 =?us-ascii?Q?raFW2aLBO4ROQJ1oISDpZElcXDVlM7wjwg64WG9Evx9/PH99nHV+plnVfdBb?=
 =?us-ascii?Q?Fszb/8RZA1HyQ1mNmsqYoLFzogb68dZDl8u66HiU+Xo8yLH8L7vz6NzJ9jhj?=
 =?us-ascii?Q?3YVlBLKjSl58k4vL9DK8M/BOD5tNm9y9QKNyF3V+4fgzmS3xubTDTWMEHgl9?=
 =?us-ascii?Q?jZvVP2Mm/9l+w15T7QQsLZeOfqk+H9pwip4MeudC5aoaH/83dIGEq0nz6rEG?=
 =?us-ascii?Q?X8GVNlKX09miOzWf2pAcpiBGDLjskqJ5k0upAEoEeQ/Z94Oh9Un/T2+2Uzya?=
 =?us-ascii?Q?41NMI1lBLlsfDzE6KGSUXWnL2hIbLXP20NkFYPv6dQTarjJszX2zUp8Z50E6?=
 =?us-ascii?Q?kSlKUFGC1QWJO1n1t85qCvjG+TNnYSeRUF5M54TKdAcL+x8HHJxjQBgSTZi6?=
 =?us-ascii?Q?fdr3/zUP3+HRJVNsAOEzN9wrnaxLOMxvUXOTcxFhiSa1Ss1snxSOzVMkFf6p?=
 =?us-ascii?Q?ke/0WHWnM5WmGkBaWzMjp2Wap0qggW0xFP4emt8OrmGtEyu/VJFeZQSPoD5L?=
 =?us-ascii?Q?mP+QxSqy/Fntb6YR8496N6DcfNPuPpLvA5cQQNPSB6VXCTOmuc14v4sehi/S?=
 =?us-ascii?Q?x8cqU0yEbTDgC0J+DlRXXAyBqFsVcKpH8xmrg5QMxaHgeh0tXdeYsscieBy0?=
 =?us-ascii?Q?SybBxfPRy0liEoNRV6Iy2MzLDDYSmw/8CnnxieNMZxMw5vCMNN1HIWjlszST?=
 =?us-ascii?Q?FqphMXc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FbW+eo/mD3AP4l2Xx1u4gRuZfsuWRRyOE1zllm2FR/G0p9LOAzwUtNP0X6m/?=
 =?us-ascii?Q?6XKILG1W4UoG9IQE5W3coJMyLI8Sux34po8+mdK9aA0HDfflSCoDWjP8PKX9?=
 =?us-ascii?Q?vPvS5K4ztFFumqMiAJUmtDjTqKajZIg24mn+04mp1yoPktiCWSP/MUVZAx07?=
 =?us-ascii?Q?p0+gM7nWDCx0+19C03toG8o+FE0vYTVIi2ZJ2kOAYWd3O42q052r2I7YuGKr?=
 =?us-ascii?Q?T0Vc7+czb4PqTRAbSIi04GtfSajryhauEro4G3nAemRbmwgLVz9wqIDDxLJb?=
 =?us-ascii?Q?u91IBOIfIB4Fc1gSMUpmNUfZdVS2PwA1mRvoUJICGhqDPo2YbfTYla4SuJlc?=
 =?us-ascii?Q?KVXbd1aMtNI3V3vvqo1LZV3yy1D2kVV7G496QnvX/mINrvD9xXUiiM0avp6T?=
 =?us-ascii?Q?/RvzJEvrO7yUihg1GVijGbjNgCimbVXHUgfSwcpzpk7hxdci59MtWtd+9+Ww?=
 =?us-ascii?Q?DA9nrFS3KvXPkyk+MU74+YP91La48e+kcs6OTkHZ1a6Qwh1ZdbgPsNfVUOqQ?=
 =?us-ascii?Q?n9xtBm3/4tIJNaROsR21TYdE73rJqAb00MN4jm5oQiFL1sJp2P6XiYRUb5yA?=
 =?us-ascii?Q?QEMgaT8GY9VauWzH90zs/pnmGLD8QkKugZBH0itQd781i0jdgIj2VewBhhr7?=
 =?us-ascii?Q?70CppVdBLqfIXh9nDIUN6mH/Mp5pqqfRYgpyOVG246X/X5m3ownvf9tzSH9s?=
 =?us-ascii?Q?RzHYC7Dw+dak+eEdgqnVv/oIcPwVGjTZOT+4AMb4M2K3WCiM6252+c8CQEjm?=
 =?us-ascii?Q?ErIkLGl9LvDltf2H+/bienDQhlx+3gcdszG9LttGVOM/lHohKqxNXyFr3206?=
 =?us-ascii?Q?Rpg93c/C/Fam9b/WW+h5p1+h1jUAdf+dG6O9YAYAx1G2S4FSZQBXXoK7s0h9?=
 =?us-ascii?Q?ICoEjQ4ADCvbj6ow2ouK51fYvZTHIGF1dNTECjg2r+BMKvA1GjnDlWKsJA/J?=
 =?us-ascii?Q?ShxTDqrG9MOAixh/4PEg7AfPxp5f+lfeQwYG4WwKKYGhA5Af0tP1tVEkh7Mc?=
 =?us-ascii?Q?igJ6UabZ7IeKBopnPO8qpD3lKo2vqn0wJ9a8/dja/jz2MSM0yLyR+JtmGm5+?=
 =?us-ascii?Q?gA1KzTyaI4BpK7xsGUuEJJxjek2H5YdTthykx6V294Ot6uGTMKqXPAuZEe6q?=
 =?us-ascii?Q?oVgQUcYqVSdaqwQT0tDhKgblh422+sqfDXEdx6OKpRZJlikFUOsSdD1eV32c?=
 =?us-ascii?Q?pY+HNXnO3/N0+DCMgPDOLTBaVysqiN15Bf8dPz6PsLp7z8KJZgPlc+CsuCkg?=
 =?us-ascii?Q?zp8cCcEwoZJV4yDzx+aEpZrPZ5HWxGMjn2r6ytPUCdFVzAunGJbbKfiLbwUF?=
 =?us-ascii?Q?DcY8pS2b+xs2Kkei2YqfW0tt2BW0yY31pO53HrMqvZ+HgKIEFwxRpFAg+1aE?=
 =?us-ascii?Q?iDBedRwLcX4ED+V0JzrMtM0aOnijLbxJYRp49XwwdO5w9r4CSx8D6mDiWTEM?=
 =?us-ascii?Q?ASj4cf3Ife/GjC1wUL454DgLxzc+mcqFAoAU0/NruM238IgHng67Xh+w45u6?=
 =?us-ascii?Q?xf3wXkwxLCqiEQGjrF1Mu6YD7BWV4GF2Zh8+1Fz+3OhwimminFNhwKclo6Fi?=
 =?us-ascii?Q?JQPR4fAKW7kTmerJ4chSDZaQQXzJK1YT57NyacVU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cc30ca-30ef-4863-9b5a-08dcc8752b77
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:54:34.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3VUck72AaVN6I6/wZ4+Nf8a5ge/jPPoEEYjSW5wvETZ2gQn1GB2phlXC/RZ7aYFC4ZyB5ruC1R/ujaQUSrk5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 16 Aug 2024 09:44:29 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index d7d526a51e2b..103b0bec3a4a 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> > @@ -271,20 +271,67 @@ static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
> >  	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
> >  }
> >  
> > +static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
> > +			      struct region_extent *region_extent)
> > +{
> > +	struct cxl_dax_region *cxlr_dax;
> > +	struct device *dev;
> > +	int rc = 0;
> > +
> > +	cxlr_dax = cxlr->cxlr_dax;
> > +	dev = &cxlr_dax->dev;
> > +	dev_dbg(dev, "Trying notify: type %d HPA %par\n",
> > +		event, &region_extent->hpa_range);
> > +
> > +	/*
> > +	 * NOTE the lack of a driver indicates a notification has failed.  No
> > +	 * user space coordiantion was possible.
> > +	 */
> > +	device_lock(dev);
> 
> I'd use guard() for this as then can just return the notify result
> and drop local variable rc

Yep Dave already mentioned this and it is done.

> 
> 
> > +	if (dev->driver) {
> > +		struct cxl_driver *driver = to_cxl_drv(dev->driver);
> > +		struct cxl_notify_data notify_data = (struct cxl_notify_data) {
> > +			.event = event,
> > +			.region_extent = region_extent,
> > +		};
> > +
> > +		if (driver->notify) {
> > +			dev_dbg(dev, "Notify: type %d HPA %par\n",
> > +				event, &region_extent->hpa_range);
> > +			rc = driver->notify(dev, &notify_data);
> > +		}
> > +	}
> > +	device_unlock(dev);
> > +	return rc;
> > +}
> >
> > @@ -338,8 +390,20 @@ static int cxlr_add_extent(struct cxl_dax_region *cxlr_dax,
> >  		return rc;
> >  	}
> >  
> > -	/* device model handles freeing region_extent */
> > -	return online_region_extent(region_extent);
> > +	rc = online_region_extent(region_extent);
> > +	/* device model handled freeing region_extent */
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxlr_notify_extent(cxlr_dax->cxlr, DCD_ADD_CAPACITY, region_extent);
> > +	/*
> > +	 * The region device was breifly live but DAX layer ensures it was not
> 
> briefly

Fixed Thanks

> 
> > +	 * used
> > +	 */
> > +	if (rc)
> > +		region_rm_extent(region_extent);	
> > +
> > +	return rc;
> >  }
> 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 975860371d9f..f14b0cfa7edd 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> 
> > +EXPORT_SYMBOL_GPL(dax_region_add_resource);
> > +
> > +int dax_region_rm_resource(struct dax_region *dax_region,
> > +			   struct device *dev)
> > +{
> > +	struct dax_resource *dax_resource;
> > +
> > +	guard(rwsem_write)(&dax_region_rwsem);
> > +
> > +	dax_resource = dev_get_drvdata(dev);
> > +	if (!dax_resource)
> > +		return 0;
> > +
> > +	if (dax_resource->use_cnt)
> > +		return -EBUSY;
> > +
> > +	/* avoid races with users trying to use the extent */
> 
> Not obvious to me from local code, why does releasing the resource
> here avoid a race?  Perhaps the comment needs expanding.

We are under the dax_region_rwsem here.  So that avoids the users from seeing
the extent while the lower level code is going to remove it.

How about?

        /*
         * release the resource under dax_region_rwsem to avoid races with
         * users trying to use the extent
         */

> 
> > +	__dax_release_resource(dax_resource);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_region_rm_resource);
> > +
> 
> 
> > +static ssize_t dev_dax_resize_sparse(struct dax_region *dax_region,
> > +				     struct dev_dax *dev_dax,
> > +				     resource_size_t to_alloc)
> > +{
> > +	struct dax_resource *dax_resource;
> > +	resource_size_t available_size;
> > +	struct device *extent_dev;
> > +	ssize_t alloc;
> > +
> > +	extent_dev = device_find_child(dax_region->dev, dax_region,
> > +				       find_free_extent);
> 
> There is a __free for put device and it will tidy this up a tiny bit.

And fix the bug...  :-/  Thanks.

> 
> > +	if (!extent_dev)
> > +		return 0;
> > +
> > +	dax_resource = dev_get_drvdata(extent_dev);
> > +	if (!dax_resource)
> > +		return 0;
> > +
> > +	available_size = dax_avail_size(dax_resource->res);
> > +	to_alloc = min(available_size, to_alloc);
> I'd put those two inline and skip the local variables unless
> they have more use in later patches.

Nope just made the line shorter and I tend to not embed calls like that but it
is fine your way too.  I'll change it.

> 
> 	alloc = __dev_dax_resize(dax_resources->res, dev_dax,
> 				 min(dax_avail_size(dax_resources->res), to_alloc),
> 				 dax_resource);
> 	
> 				
> > +	alloc = __dev_dax_resize(dax_resource->res, dev_dax, to_alloc, dax_resource);
> > +	if (alloc > 0)
> > +		dax_resource->use_cnt++;
> > +	put_device(extent_dev);
> > +	return alloc;
> > +}
> > +
> 
> > @@ -1494,8 +1679,14 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
> >  	device_initialize(dev);
> >  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> >  
> > +	if (is_sparse(dax_region) && data->size) {
> > +		dev_err(parent, "Sparse DAX region devices are created initially with 0 size");
> must be created initially with 0 size.
> 
> Otherwise this error message says that they are, so why is it an error?

Indeed!

> 
> > +		rc = -EINVAL;
> > +		goto err_id;
> > +	}
> > +
> >  	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> > -				 data->size);
> > +				 data->size, NULL);
> >  	if (rc)
> >  		goto err_range;
> >  
> 
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index 367e86b1c22a..bf3b82b0120d 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -5,6 +5,60 @@
> 
> ...
> 
> > +static int cxl_dax_region_notify(struct device *dev,
> > +				 struct cxl_notify_data *notify_data)
> > +{
> > +	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> > +	struct dax_region *dax_region = dev_get_drvdata(dev);
> > +	struct region_extent *region_extent = notify_data->region_extent;
> > +
> > +	switch (notify_data->event) {
> > +	case DCD_ADD_CAPACITY:
> > +		return __cxl_dax_add_resource(dax_region, region_extent);
> > +	case DCD_RELEASE_CAPACITY:
> > +		return dax_region_rm_resource(dax_region, &region_extent->dev);
> > +	case DCD_FORCED_CAPACITY_RELEASE:
> > +	default:
> > +		dev_err(&cxlr_dax->dev, "Unknown DC event %d\n",
> > +			notify_data->event);
> > +		break;
> Might as well return here and not below.
> Makes it really really obvious this is the error path and currently the only
> one that hits the return statement.
> > +	}

ok

> > +
> > +	return -ENXIO;
> > +}
> 
> >  static int cxl_dax_region_probe(struct device *dev)
> >  {
> > @@ -24,14 +78,16 @@ static int cxl_dax_region_probe(struct device *dev)
> >  		flags |= IORESOURCE_DAX_SPARSE_CAP;
> >  
> >  	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> > -				      PMD_SIZE, flags);
> > +				      PMD_SIZE, flags, &sparse_ops);
> >  	if (!dax_region)
> >  		return -ENOMEM;
> >  
> > -	if (cxlr->mode == CXL_REGION_DC)
> > +	if (cxlr->mode == CXL_REGION_DC) {
> > +		device_for_each_child(&cxlr_dax->dev, dax_region,
> > +				      cxl_dax_add_resource);
> >  		/* Add empty seed dax device */
> >  		dev_size = 0;
> > -	else
> > +	} else
> 
> Coding style says that you need brackets for all branches if
> one needs them (as multiline).  Just above:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#spaces
> 

Yep missed it.  thanks for the review!
Ira

[snip]

