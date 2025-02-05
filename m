Return-Path: <linux-btrfs+bounces-11280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE4A283CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 06:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07003166BB3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 05:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF0321D5A8;
	Wed,  5 Feb 2025 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU+gCKRz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A738F82;
	Wed,  5 Feb 2025 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734268; cv=fail; b=G14NN/MF/tuLJDmzvhjDTGKa8HMv+5JTKQCnn6gDOkaC8ZssGMESm3002r7NaHkBEX/qXgaxvOvE8/vAM02DVe6MaXpvJ5kM60P9aHokIu5f3VaRBddFNYpAdXBi8WtvqaAjhVCyIyXENMAe+84fot4K55GsYr65lZS7VbDTHwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734268; c=relaxed/simple;
	bh=bW5sS9imFH09bk9o47fX/9xcRDsMP72DtGLW+CE/vt4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ILz9ZfFLcSljpoWbEpZcmRBvYw2BOYPMiMi9ZOgmUMjwjZmG639m2hAT6GgVoRFxRHsB/35jVA9s+OojlkBZMP1P7B+eb08QyQ7RU/YVCEsqRo6kBm1rlkM7H+/3SsuQjXGszYufN2D/L/y/oc8MECCe8ifxWhR8JFV5spIVZg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU+gCKRz; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738734262; x=1770270262;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=bW5sS9imFH09bk9o47fX/9xcRDsMP72DtGLW+CE/vt4=;
  b=bU+gCKRzaOfaz6fF12PVd1lNVvSn/KHzLO+1gdcLGbUVq0p+3o09Mooc
   fjxJ8qDGIbSbacAhUHGoaKIaEZ50jnQ8AXv05AWRDpH+mqF7zpI6Gfnyj
   zSX1PIVJGNh61wJqmyKAUJVUYgDt95XJ7jl2jjOXSilH7XuBR83qdpYzv
   PTe2VdfAIRpXcxvK1QAiAAY1Fbs1VTuMOo+d4bs0BpTN/1qVPz/GsmgLm
   76qQj+L0Rban3kNR4H8+eyOLW1x1m4gicwLAAUaas2piApoksFwkI/q5v
   JG+gQEtIE/3aHqm3Z6J4jvz/E9cQClMmvY4qd0APCClOvaee1oigXHQD1
   A==;
X-CSE-ConnectionGUID: Xjy9jOZQRE2DAXW6WtZBBQ==
X-CSE-MsgGUID: nueTRZcQSZWbdLEGxadg0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42946929"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="42946929"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:44:15 -0800
X-CSE-ConnectionGUID: mXOWhr1VSeGcUqCRx3f0Yw==
X-CSE-MsgGUID: vM9z0kcPRxu3ozQLNtAzxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134046312"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 21:44:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 21:44:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 21:44:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 21:44:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGho7uAdL8Eu1EA2lO5qxR53iUH+KoMYCk2otaXJhsNb6Lp8x/xDfTD7YBUErX80l9BgSw50EDvkU2gLWJrUhgfuvVKZw8NFFe0+b1Le6aQXM/US/21M6Y/z3Ep5q+yavklRaeKKjq4yZ19aNCWtXgU6cuoPwMVpbv0EN4wUJXVAipNDMX0VfTyS+j0XbXBmvFOmA4rZMUlcbQE69AlaJKr1pfbalbqrCvyh5IEoMVNozBe7cOsuffxWeL6nEJpACGRy5U9y2jru5UaxXGD8OiYXLgJmm50pC1qQYaXjLqRQUDddWLn5FhnsucsEQtLyjjmp/HjZria9mBxXUQ+UvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4hQuEUgr8KeAo/VYpKOwmIncCp3d5bmgnejAQPtE6Q=;
 b=DUQizldra9G2bHqKVX4qBCxGerTVvrsnvc+KMjN8gGx422cheoh+ItW24Jvi23EHkbOOlUrMaBj/PBIp/vjH0xGZYQZXG7SGUe8D+GrPKv831QsitGEkC7SjrINchhlOHJg+HtTQPdQpMfn8i2Qno0Qm0x6fIvHOsCxsPpywYdjPgb26L+LvGOhPgWcHVK6pegdq88WG2YmQQykNr4otcJzg1IeYNZUftXt0XEgZVdZJE34cu4FDvN5jiH7zFe5erYqm5s2thCFIxUC98bgv7XNyJ3c9SIcZzqYp2b4q21rjwyvIBkrivsdBuOA1Q95oNsMyI6LesJ3zVbAlnT24Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 05:43:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 05:43:35 +0000
Date: Wed, 5 Feb 2025 13:43:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  c87c299776:
 sysbench-fileio.write_operations/s 14.7% regression
Message-ID: <202501311641.4c5b6a89-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:820:e::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: e5353c26-ff62-43d4-3c88-08dd45a807a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jTWW1WKOXW/xyc0Zxk16niPTL9Hb+2ZTyGO0tQAf5UfAwp3I8NB5qTF2/9?=
 =?iso-8859-1?Q?WtpVBOAwKZRqVAngezVrAa6Fr0yvwtjr0fyxWr+C7dE2bCgJBp17vWcDzG?=
 =?iso-8859-1?Q?0Krpnpl4QQuj3K9Lyapgt0yel/AKPGdzf5ReCg75CjqAcfJV0NqEEMdD6w?=
 =?iso-8859-1?Q?nnMvgLPRR018BB3V/XP7z8c36yaWJy6cyyHKLgxp7XPB+EQ7GIesOLsigT?=
 =?iso-8859-1?Q?zpW5JD0rBpasZMMPpT/4T34Utyqf1VK57/Bo00T76hvFtQPm/+v+lwuX5y?=
 =?iso-8859-1?Q?5EB9g+C3al5o87tROI3RATxEVC3lwG6UQQBeUAPVJyODEL81TnAiXEQ5si?=
 =?iso-8859-1?Q?QmseAcqfeqpku6/KoelIzY9De7kHQSgQ9s93oneZ+damn5rRqs0MZzHojD?=
 =?iso-8859-1?Q?XzBpAQhz1n53qz610UpKAnQ195dwlUZIb/hzJlkx3v61b3No2RL4M+rdZm?=
 =?iso-8859-1?Q?aoJ3ZBFn0dfDxEpWIHS6BSZA2x/ceZGctwRFfjlcGcoR50B5SyVLSPtV5J?=
 =?iso-8859-1?Q?fjkoM1t+QgtVGH4NEP1mXsHyNeJ9mZvLDFUp7QT3c+7lX5GxMvlWkC2l90?=
 =?iso-8859-1?Q?5JuQqpZkwhYEGuRwi4axZsBgnGn5ENaRFJ8yRIq4tZHmYBOA34M9rHp8sg?=
 =?iso-8859-1?Q?J8BfCyl7d2WK6GSkNxTFF10mkmuIQVBSoJThW442V8agd2e6QLOP4h5LS2?=
 =?iso-8859-1?Q?VDQMtfmL+ArFJ7LZPj/QOzZKz0heS+MJHgr8EN24etcW/BTIwxaZtdLGbn?=
 =?iso-8859-1?Q?TOiNrvzMZk63UUT8V0bA7oHwwpVv7GoTUNHdqw93K7Q9qtQLpkzF3QrTHl?=
 =?iso-8859-1?Q?ibzrYO4xlp4XrR9qLO1NiZXMuAWbCO7ftZa0bLOL+5nm12tGHKUyyxW6vh?=
 =?iso-8859-1?Q?9i4MkRn41YmOwpq5mbhT/oaRwPuXXdUnFrcZlfXiAwPAeDIVuKPg/AXNjL?=
 =?iso-8859-1?Q?ktuA+9kaSZW67u0t7e0+JX2IcwVxan3CPNNdxlDqhoa/CWHxiuz2qqLsdF?=
 =?iso-8859-1?Q?I+WGlWP6vj+nzx0nUOzzLsy8YOcGaBnGJek/qZhe1AqxPAOCSHirhWrRYw?=
 =?iso-8859-1?Q?LB0rvlhaUqmccchmpcNIVwOPzeQ7uyCPpPfAkKwjyBSVWrXEUnjHAp1PYt?=
 =?iso-8859-1?Q?3gIFqRcFe176PO3I/mt12j6oZ0w1FOiaf6+OpTbtRZnwbW1ZqaBUw8MEvk?=
 =?iso-8859-1?Q?0B8xfiM8ulxcS10yPQ7+LuQ/Ep+c0K8O4ufrlxGQEkAt4PWF5bzzV1Kzll?=
 =?iso-8859-1?Q?y7y8zpmSxsXUwBjICzIrI1DCHAZ9pyXVbW/lo+2pjiXhIqIn7xIgkUnYns?=
 =?iso-8859-1?Q?ftdneJYJl3rcrLpI2f6sUA/j4593CPNAq9VQ4MfivzyyDtne8gkROXwcqp?=
 =?iso-8859-1?Q?ZzOm4Svff3g86wKPMZIQs9/j5GJzcKrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:vi;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5slFjDwG2jUNQ+n4UzNpvOMKnnwzKti2DdcdHhG4qsdF7SsUA7KkJ3ZA2+?=
 =?iso-8859-1?Q?E/fLW5yfykmZXeJz1Vstb9kLaKZcll7xBqlfKsxVXo1PycF+b8Hx0f/+3R?=
 =?iso-8859-1?Q?E3fkqzqdcmLoyOMCQcdlVH9DUNiQzGmISsRZFgCI+dfk0CnFQbgYp48hLS?=
 =?iso-8859-1?Q?QY+AmfAElAzCRSsRyI436tDwn0mf+pkrAzEPqYrC//4o7lygIU7lA5imQf?=
 =?iso-8859-1?Q?iIYHVGlR5uMfvc48G6godNYBXpp/O3QGWIiFwnY+DmH1sf75miTsWl6svF?=
 =?iso-8859-1?Q?RRzrs3jMo3cTmLAEtmhKrQHbV8GcZzTnO/IF8Ua/5Pw5OyC3p93K3YJMMS?=
 =?iso-8859-1?Q?2dup0+VLM9iGREUlHvX/3Yi2/LbaZypB90KaVA6QsgSLWzyfHReXxUuoVm?=
 =?iso-8859-1?Q?4KmxEBW8Od9h6u1xpgJvZDgUP+DRny0HOOufaUAbXEvA+ROPQ5zwZVRZzg?=
 =?iso-8859-1?Q?pYYrMBLlHTcbaqAzpy0Ucaanj85UdegoJcLxMB8SHELBCjnh9sw9oJ72qs?=
 =?iso-8859-1?Q?HDrtFQbzytZTL0px/yb6S88YG4v4UO+wtltA/zRp5EHupyP41qd3skrMY1?=
 =?iso-8859-1?Q?T363LBTci2W3HNVU66v5UEeEWWRvOSTMhz3eoACSbmZ3aSRafD/4LYihw/?=
 =?iso-8859-1?Q?mhNascpv5vahU28ufbh90zD1h5hjoqjFYbT4VPsyw4EqMJV+8oBB7SXdFv?=
 =?iso-8859-1?Q?oB+CPLKUao/WpMnMlGt5W4JW00uC07s5yFuBQzgwYdbzgkEcQt+RX7jHas?=
 =?iso-8859-1?Q?OAp273PJwwhlzY5JiZyM5U48B3iBr3lFGnWCk8DBAu1qrkzoVuruQcWd4F?=
 =?iso-8859-1?Q?fuSilmFpV5jS4r0aGuhkBhMClSUkkxGbghh/oZuEJbTHwB6bWnx0VmPD0w?=
 =?iso-8859-1?Q?UcQy22rwF7JGgUSnBEbKUmuSuKAbMiTS5pkVgnyD4yv7dx0r9GW8nZGbjm?=
 =?iso-8859-1?Q?lSfM0dQ9DveADICej7P7JP4439/LOaPVeLLooUPgzw/cfMFqkg1cGGPmKH?=
 =?iso-8859-1?Q?XMURYyIfZIMLd2V5VL0R5/Cptl2vYjPQeAruFzrHv5BaUX46JKjS/L08Yn?=
 =?iso-8859-1?Q?NmUg61sZ3UnZBR8zgHhFNEdOoZdJpJ2Ii6lM3JuKM7jqaOBUlss51eFG2D?=
 =?iso-8859-1?Q?yBCBK5i9YdGcno/nVy7oOctIWgBn5zNKaZmKW0TNoapywF4lmLJP/dadYc?=
 =?iso-8859-1?Q?QwRnBblpdCi0eV0fXqH9jjX6ki5eoASvK1t/tLJcrt94JtSkGUa5Szds00?=
 =?iso-8859-1?Q?J7ORaHcJvswjB3Hv4B5TH27reOpVYdL4T0MjqHJ3onS8rsTspc3Dw/AhxJ?=
 =?iso-8859-1?Q?fPiClcmgMxnRjyNVK7T7y6wi5EONcc42ZFGDUcHl2RAzf9SWoMOj23t5Ke?=
 =?iso-8859-1?Q?Oy5PZjffARrEXg2MlBAcp4YY5xyTRQvuisQUyUrSCSRN4YNAN+X5cXTCtG?=
 =?iso-8859-1?Q?BVNv+usiaNHT3LfGlr+nlfzoDosNmu6iixFkoJMqDCjPlXR1IrklzhYqKU?=
 =?iso-8859-1?Q?cTfX7SpzhVBYzbXyd43XRtvx+eKXBfbnm4qKcNcfQkCbk/KmBUtOdK/xEp?=
 =?iso-8859-1?Q?OcLXUz6jCx1SB7QLcRAcX4crTGm+dS6JvkXkuxuGGXzL8QDWw3HqFNoGyM?=
 =?iso-8859-1?Q?XGAF88G7PBGBvvcP5kGRYHB+e8oPUPIt/D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5353c26-ff62-43d4-3c88-08dd45a807a0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 05:43:35.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnDdmjEnF7ddPd+8D88jk4vXR1WIt9/lu0+xxcOaDnSWaf5fZIBM9Y0yuJupCbY9Nfjjh6IH+8/LEZ+p5tQBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com


hi,

we reported
"[linus:master] [btrfs]  c87c299776:  iozone.average_KBps 18.5% regression"
in
https://lore.kernel.org/all/202411302252.67284087-lkp@intel.com/

now we got more performance results for this commit. just FYI.



Hello,

kernel test robot noticed a 14.7% regression of sysbench-fileio.write_operations/s on:


commit: c87c299776e4d75bcc5559203ae2c37dc0396d80 ("btrfs: make buffered write to copy one page a time")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      72deda0abee6e705ae71a93f69f55e33be5bca5c]
[still regression on linux-next/master a13f6e0f405ed0d3bcfd37c692c7d7fa3c052154]

testcase: sysbench-fileio
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	period: 600s
	nr_threads: 100%
	disk: 1SSD
	fs: btrfs
	size: 64G
	filenum: 1024f
	rwmode: seqrewr
	iomode: sync
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | iozone: iozone.average_KBps  14.1% regression                                                      |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=2HDD                                                                                          |
|                  | fs=btrfs                                                                                           |
|                  | iosched=kyber                                                                                      |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | sysbench-fileio: sysbench-fileio.write_operations/s  4.9% regression                               |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | filenum=1024f                                                                                      |
|                  | fs=btrfs                                                                                           |
|                  | iomode=sync                                                                                        |
|                  | nr_threads=100%                                                                                    |
|                  | period=600s                                                                                        |
|                  | rwmode=rndrw                                                                                       |
|                  | size=64G                                                                                           |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | iozone: iozone.average_KBps  18.5% regression                                                      |
| test machine     | 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory            |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=2HDD                                                                                          |
|                  | fs=btrfs                                                                                           |
|                  | iosched=kyber                                                                                      |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501311641.4c5b6a89-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250131/202501311641.4c5b6a89-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filenum/fs/iomode/kconfig/nr_threads/period/rootfs/rwmode/size/tbox_group/testcase:
  gcc-12/performance/1SSD/1024f/btrfs/sync/x86_64-rhel-9.4/100%/600s/debian-12-x86_64-20240206.cgz/seqrewr/64G/lkp-spr-2sp4/sysbench-fileio

commit: 
  b1c5f6eda2 ("btrfs: fix wrong sizeof in btrfs_do_encoded_write()")
  c87c299776 ("btrfs: make buffered write to copy one page a time")

b1c5f6eda2d024c1 c87c299776e4d75bcc5559203ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.206e+08 ±  3%     -18.7%   98090038        cpuidle..usage
      8809           -20.5%       7002        numa-meminfo.node0.Dirty
      8794 ±  2%     -15.2%       7456 ±  2%  numa-meminfo.node1.Dirty
    755.83 ±  4%     -17.0%     627.17 ±  3%  perf-c2c.DRAM.remote
    792.83 ±  3%     -18.8%     643.67 ±  5%  perf-c2c.HITM.local
    552.17 ±  4%     -18.1%     452.33 ±  3%  perf-c2c.HITM.remote
      0.04            -0.0        0.03        mpstat.cpu.all.iowait%
      0.37            -0.0        0.33        mpstat.cpu.all.irq%
      0.53 ±  2%      -0.1        0.44        mpstat.cpu.all.usr%
     43.83 ± 26%    +234.6%     146.67 ±128%  mpstat.max_utilization.seconds
   1160794           -14.8%     988926        vmstat.io.bo
      0.13 ± 11%     -31.6%       0.09 ±  8%  vmstat.procs.b
    456556 ±  3%     -21.6%     357945        vmstat.system.cs
    163016 ±  2%     -12.3%     142938        vmstat.system.in
   1578539 ±  2%     -10.4%    1414861        meminfo.Active
   1578539 ±  2%     -10.4%    1414861        meminfo.Active(anon)
   1697671 ±  2%      -9.8%    1530850        meminfo.Committed_AS
     17686           -18.2%      14475        meminfo.Dirty
     95391 ±  2%     -10.0%      85818        meminfo.Mapped
    913745 ±  4%     -18.2%     747380        meminfo.Shmem
      0.00 ±  2%      +9.5%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
    608241 ±  3%     -21.4%     478145        sched_debug.cpu.nr_switches.avg
    646818 ±  3%     -21.4%     508164 ±  2%  sched_debug.cpu.nr_switches.max
    532758 ±  3%     -17.3%     440538 ±  2%  sched_debug.cpu.nr_switches.min
     19886 ± 28%     -36.5%      12627 ± 20%  sched_debug.cpu.nr_switches.stddev
   -274.21           -31.7%    -187.41        sched_debug.cpu.nr_uninterruptible.min
     26.06 ±  7%     -26.7%      19.11 ±  3%  sched_debug.cpu.nr_uninterruptible.stddev
  81034600           -15.7%   68320589        numa-vmstat.node0.nr_dirtied
      2207           -20.7%       1749 ±  2%  numa-vmstat.node0.nr_dirty
  80930247           -15.7%   68231458        numa-vmstat.node0.nr_written
      2259           -19.8%       1812 ±  2%  numa-vmstat.node0.nr_zone_write_pending
  82238139           -13.9%   70798598        numa-vmstat.node1.nr_dirtied
      2197 ±  2%     -15.1%       1866 ±  2%  numa-vmstat.node1.nr_dirty
  82132807           -13.9%   70703118        numa-vmstat.node1.nr_written
      2251 ±  2%     -14.4%       1927 ±  2%  numa-vmstat.node1.nr_zone_write_pending
    645057           -14.7%     550297        sysbench-fileio.fsync_operations/s
      0.29           +20.7%       0.35        sysbench-fileio.latency_avg_ms
 1.226e+08            +3.7%  1.272e+08        sysbench-fileio.latency_sum_ms
 1.302e+09           -14.8%   1.11e+09        sysbench-fileio.time.file_system_outputs
    180192           -33.5%     119806        sysbench-fileio.time.involuntary_context_switches
    670.70 ±  2%     -18.9%     544.20        sysbench-fileio.time.user_time
 1.325e+08 ±  3%     -21.5%   1.04e+08        sysbench-fileio.time.voluntary_context_switches
      1031           -14.7%     879.86        sysbench-fileio.write_bytes_MB/s
    983.70           -14.7%     839.10        sysbench-fileio.write_bytes_MiB/s
     62956           -14.7%      53702        sysbench-fileio.write_operations/s
    394604 ±  2%     -10.4%     353701        proc-vmstat.nr_active_anon
 1.632e+08           -14.8%  1.391e+08        proc-vmstat.nr_dirtied
      4419           -18.5%       3601        proc-vmstat.nr_dirty
  17631641            -2.5%   17190907        proc-vmstat.nr_file_pages
  16495708            -2.4%   16096490        proc-vmstat.nr_inactive_file
     24134 ±  2%      -9.9%      21747        proc-vmstat.nr_mapped
    228424 ±  4%     -18.2%     186851        proc-vmstat.nr_shmem
     78821            -1.6%      77556        proc-vmstat.nr_slab_reclaimable
    133365            -1.5%     131337        proc-vmstat.nr_slab_unreclaimable
  1.63e+08           -14.8%  1.389e+08        proc-vmstat.nr_written
    394604 ±  2%     -10.4%     353701        proc-vmstat.nr_zone_active_anon
  16495708            -2.4%   16096490        proc-vmstat.nr_zone_inactive_file
      4525           -17.6%       3727        proc-vmstat.nr_zone_write_pending
  30527244            -5.8%   28755813        proc-vmstat.numa_hit
  30295172            -5.8%   28523961        proc-vmstat.numa_local
  30893826            -5.8%   29101927        proc-vmstat.pgalloc_normal
   2308405            -2.1%    2259963        proc-vmstat.pgfault
  12985154           -11.4%   11500128        proc-vmstat.pgfree
 7.015e+08           -14.9%  5.971e+08        proc-vmstat.pgpgout
      1.68           -22.2%       1.30        perf-stat.i.MPKI
 7.758e+09            +6.5%   8.26e+09        perf-stat.i.branch-instructions
      0.31            -0.0        0.27        perf-stat.i.branch-miss-rate%
  23527694            -5.1%   22326808        perf-stat.i.branch-misses
     40.53            -2.4       38.18        perf-stat.i.cache-miss-rate%
  63433996           -16.2%   53141183        perf-stat.i.cache-misses
 1.571e+08           -10.9%  1.399e+08        perf-stat.i.cache-references
    458350 ±  3%     -21.7%     359103        perf-stat.i.context-switches
      4.18            -8.6%       3.82        perf-stat.i.cpi
      2164 ±  2%     -24.4%       1636        perf-stat.i.cpu-migrations
      2494           +17.5%       2932        perf-stat.i.cycles-between-cache-misses
 3.791e+10            +7.6%   4.08e+10        perf-stat.i.instructions
      0.24            +9.2%       0.26        perf-stat.i.ipc
      2.05 ±  3%     -21.6%       1.61        perf-stat.i.metric.K/sec
      3593            -2.1%       3517        perf-stat.i.minor-faults
      3593            -2.1%       3517        perf-stat.i.page-faults
      2086 ± 44%     +40.7%       2934        perf-stat.overall.cycles-between-cache-misses
      0.20 ± 44%     +31.6%       0.26        perf-stat.overall.ipc
 6.464e+09 ± 44%     +27.6%  8.246e+09        perf-stat.ps.branch-instructions
 3.158e+10 ± 44%     +29.0%  4.073e+10        perf-stat.ps.instructions
 1.902e+13 ± 44%     +29.0%  2.454e+13        perf-stat.total.instructions
      0.02 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.01 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
      0.01 ±109%    +297.5%       0.05 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.__lock_extent
      0.01 ±  7%    +182.3%       0.03 ± 70%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 28%     +89.5%       0.02 ± 21%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
      0.01 ± 33%     +62.1%       0.02 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±  6%     +27.3%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
      0.09 ± 58%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_noprof.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.01 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
      0.02 ±117%    +592.0%       0.14 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.__lock_extent
      0.01 ± 16%     +48.1%       0.01 ± 13%  perf-sched.total_sch_delay.average.ms
      4.41 ±  5%     +17.9%       5.20        perf-sched.total_wait_and_delay.average.ms
    880525 ±  4%     -19.8%     706480        perf-sched.total_wait_and_delay.count.ms
      4047 ±  4%      +7.2%       4337 ±  4%  perf-sched.total_wait_and_delay.max.ms
      4.40 ±  5%     +17.8%       5.19        perf-sched.total_wait_time.average.ms
      4047 ±  4%      +7.2%       4337 ±  4%  perf-sched.total_wait_time.max.ms
      5.16 ± 49%    +134.3%      12.08 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      8.68 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_noprof.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      1.05 ±  5%     +21.2%       1.27 ±  2%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.39 ± 28%     +48.2%       0.58 ±  6%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.extent_write_cache_pages.btrfs_writepages
      0.58 ±  3%     +19.8%       0.69 ±  2%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     67.10 ± 11%     +20.8%      81.09 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4.47 ±  8%     +38.8%       6.20 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      1.46 ±  5%     +54.4%       2.25        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
     61.72 ±  2%     +15.6%      71.35 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.33 ± 60%    +228.9%      20.83 ± 29%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      7.00 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_noprof.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      1.33 ±103%    +500.0%       8.00 ± 33%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.set_extent_bit
    650805 ±  4%     -18.3%     532014 ±  2%  perf-sched.wait_and_delay.count.futex_wait_queue.__futex_wait.futex_wait.do_futex
     12453 ± 66%     -68.1%       3974 ±  6%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.extent_write_cache_pages.btrfs_writepages
     16632            -9.6%      15027        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    223.00 ±  7%     -16.4%     186.50 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      6825 ± 13%     -39.9%       4101 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
    148676 ±  3%     -22.5%     115290        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
     28226 ±  2%     -24.6%      21281        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     16.83 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_noprof.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     11.97 ± 73%     +84.7%      22.10 ± 12%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.__lock_extent
    436.82 ± 20%    +100.2%     874.40 ± 41%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      3947 ±  7%      +9.9%       4337 ±  4%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.78 ± 23%    +108.3%      12.05 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      8.65 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_noprof.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      6.45 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
      1.04 ±  5%     +21.1%       1.27 ±  2%  perf-sched.wait_time.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.38 ± 29%     +49.3%       0.57 ±  6%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.extent_write_cache_pages.btrfs_writepages
      0.57 ±  3%     +19.7%       0.68 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     67.10 ± 11%     +20.8%      81.09 ±  8%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4.46 ±  8%     +38.8%       6.19 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      1.45 ±  5%     +54.2%       2.23        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
      2.66 ± 11%     +64.1%       4.36 ± 20%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
     61.65 ±  2%     +15.6%      71.25 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     16.78 ± 19%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
     11.71 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
     11.96 ± 73%     +84.3%      22.05 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_extent_bit.__lock_extent
      8.34 ±118%     -99.8%       0.02 ± 26%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    436.82 ± 20%    +100.2%     874.39 ± 41%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      3947 ±  7%      +9.9%       4337 ±  4%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm


***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/iosched/kconfig/rootfs/tbox_group/testcase:
  gcc-12/performance/2HDD/btrfs/kyber/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/iozone

commit: 
  b1c5f6eda2 ("btrfs: fix wrong sizeof in btrfs_do_encoded_write()")
  c87c299776 ("btrfs: make buffered write to copy one page a time")

b1c5f6eda2d024c1 c87c299776e4d75bcc5559203ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.04            +0.0        0.04        mpstat.cpu.all.sys%
     40964 ±  3%      +7.0%      43827 ±  4%  proc-vmstat.nr_dirty
      0.02 ± 24%     -44.0%       0.01 ± 28%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 13%     +58.1%       0.01 ± 31%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.27 ±100%      +0.4        0.63 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
      0.27 ±100%      +0.4        0.64 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ±141%      +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.__set_extent_bit
      0.47 ± 17%      +0.2        0.64 ± 14%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      0.47 ± 16%      +0.2        0.64 ± 14%  perf-profile.children.cycles-pp.btrfs_buffered_write
      0.00            +0.2        0.19 ± 12%  perf-profile.children.cycles-pp.btrfs_dirty_page
      8.90           -20.5%       7.08 ±  2%  perf-stat.i.MPKI
 1.064e+08 ±  3%     +14.3%  1.216e+08 ±  5%  perf-stat.i.branch-instructions
      1.28            -0.1        1.19        perf-stat.i.branch-miss-rate%
      1.81 ±  3%     -10.2%       1.63 ±  7%  perf-stat.i.cpi
 5.341e+08 ±  3%     +16.2%  6.207e+08 ±  5%  perf-stat.i.instructions
      0.71            +9.9%       0.78 ±  2%  perf-stat.i.ipc
      7.43 ±  2%     -14.9%       6.33 ±  3%  perf-stat.overall.MPKI
      2.32 ±  2%      -0.3        2.00        perf-stat.overall.branch-miss-rate%
      2.27 ±  4%     -13.9%       1.95 ± 10%  perf-stat.overall.cpi
      0.44 ±  4%     +17.4%       0.52 ± 11%  perf-stat.overall.ipc
 1.065e+08 ±  3%     +14.3%  1.217e+08 ±  5%  perf-stat.ps.branch-instructions
 5.344e+08 ±  3%     +16.3%  6.213e+08 ±  5%  perf-stat.ps.instructions
 6.376e+11 ±  3%     +16.3%  7.418e+11 ±  5%  perf-stat.total.instructions
    547682           -19.4%     441519        iozone.1024KB_1024reclen
   9289660 ±  4%     -56.1%    4074847 ±  3%  iozone.1024KB_1024reclen.frewrite
   9534843 ±  2%     -58.2%    3984832 ±  9%  iozone.1024KB_1024reclen.fwrite
   9727700           -56.4%    4238772        iozone.1024KB_1024reclen.random_write
   9313595 ± 11%     -56.0%    4100693 ±  7%  iozone.1024KB_1024reclen.record_rewrite
   9071064 ±  2%     -55.6%    4029397 ±  2%  iozone.1024KB_1024reclen.rewrite
   5545889 ±  5%     -38.4%    3417573 ±  7%  iozone.1024KB_1024reclen.write
   9138260 ± 16%     -50.9%    4488992 ± 10%  iozone.1024KB_128reclen.frewrite
   9022424 ± 20%     -49.9%    4522108 ±  7%  iozone.1024KB_128reclen.fwrite
  12348031 ±  4%     -64.5%    4384741 ± 11%  iozone.1024KB_128reclen.random_write
  16709932 ± 16%     -72.5%    4599273 ±  2%  iozone.1024KB_128reclen.record_rewrite
   9044907 ± 19%     -55.9%    3989041 ±  9%  iozone.1024KB_128reclen.rewrite
    564089 ±  3%     -16.0%     473576 ± 11%  iozone.1024KB_16reclen
  16140082 ±  2%     -15.4%   13659650 ± 16%  iozone.1024KB_16reclen.freread
   5887139 ±  6%     -38.9%    3596343 ±  9%  iozone.1024KB_16reclen.frewrite
   6083099 ±  5%     -39.5%    3678883 ±  9%  iozone.1024KB_16reclen.fwrite
   6863248 ±  3%     -41.8%    3993986 ±  5%  iozone.1024KB_16reclen.random_write
   8481271 ± 11%     -48.8%    4338945        iozone.1024KB_16reclen.record_rewrite
   6338652 ±  7%     -41.3%    3718553 ± 12%  iozone.1024KB_16reclen.rewrite
   5183726           -29.7%    3646659 ± 12%  iozone.1024KB_16reclen.write
  10171037 ± 17%     -51.1%    4972505 ± 10%  iozone.1024KB_256reclen.frewrite
   9256319 ± 19%     -46.9%    4918317 ± 10%  iozone.1024KB_256reclen.fwrite
  11925920 ±  9%     -60.1%    4762105 ±  4%  iozone.1024KB_256reclen.random_write
  16492322 ± 28%     -73.2%    4423732 ±  8%  iozone.1024KB_256reclen.record_rewrite
   8888014 ± 23%     -50.9%    4366373 ±  2%  iozone.1024KB_256reclen.rewrite
    672876 ±  2%     -19.2%     543796 ±  5%  iozone.1024KB_32reclen
   7406374 ±  5%     -45.8%    4014327 ±  5%  iozone.1024KB_32reclen.frewrite
   7773676 ±  3%     -46.4%    4170172 ±  4%  iozone.1024KB_32reclen.fwrite
   9527829           -53.2%    4460646 ±  2%  iozone.1024KB_32reclen.random_write
  12442026 ±  3%     -64.5%    4416499 ±  2%  iozone.1024KB_32reclen.record_rewrite
   8085913 ±  4%     -51.5%    3922409 ±  7%  iozone.1024KB_32reclen.rewrite
   5889389 ±  3%     -41.5%    3447961 ± 18%  iozone.1024KB_32reclen.write
   3036644            +5.1%    3190383 ±  2%  iozone.1024KB_4reclen.frewrite
   3045829 ±  5%      +8.3%    3298523        iozone.1024KB_4reclen.fwrite
   2653949 ±  9%     +11.3%    2954956        iozone.1024KB_4reclen.random_write
   3198956 ±  2%      +4.9%    3355450        iozone.1024KB_4reclen.rewrite
    704035 ±  2%     -18.3%     575276        iozone.1024KB_512reclen
  14032094 ±  3%     -53.6%    6508198 ± 13%  iozone.1024KB_512reclen.frewrite
   5854975 ±  9%     -29.9%    4104339 ±  6%  iozone.1024KB_512reclen.fwrite
  12094761 ±  3%     -61.9%    4603690 ± 10%  iozone.1024KB_512reclen.random_write
  14578102 ± 14%     -68.0%    4670558        iozone.1024KB_512reclen.record_rewrite
   9315744 ± 14%     -55.0%    4194941 ±  4%  iozone.1024KB_512reclen.rewrite
   6493387 ±  8%     -36.8%    4102844 ±  4%  iozone.1024KB_512reclen.write
    757634 ±  5%     -16.6%     631530 ±  4%  iozone.1024KB_64reclen
   8302272 ± 17%     -49.1%    4224948 ±  7%  iozone.1024KB_64reclen.fwrite
  11486168           -59.8%    4621229 ±  2%  iozone.1024KB_64reclen.random_write
  14892370 ± 17%     -70.7%    4359131 ± 10%  iozone.1024KB_64reclen.record_rewrite
   9176731 ±  5%     -54.5%    4174983 ±  8%  iozone.1024KB_64reclen.rewrite
   6267925 ±  5%     -36.9%    3953119 ±  9%  iozone.1024KB_64reclen.write
    478236 ±  2%     -10.9%     425889 ± 10%  iozone.1024KB_8reclen
   4573573           -24.3%    3463970 ±  9%  iozone.1024KB_8reclen.frewrite
   4680120 ±  2%     -25.0%    3509682 ± 10%  iozone.1024KB_8reclen.fwrite
   4726046           -24.4%    3571923 ±  4%  iozone.1024KB_8reclen.random_write
   6017893           -31.2%    4137483        iozone.1024KB_8reclen.record_rewrite
   4878382 ±  5%     -25.1%    3655617 ± 13%  iozone.1024KB_8reclen.rewrite
   8312551 ± 18%     -51.9%    3999327 ± 13%  iozone.128KB_128reclen.frewrite
   8913329 ±  7%     -56.6%    3865100 ± 19%  iozone.128KB_128reclen.fwrite
  11017705 ±  3%     -60.3%    4373983 ±  9%  iozone.128KB_128reclen.random_write
  10032242 ± 17%     -53.7%    4647691        iozone.128KB_128reclen.record_rewrite
   7736893 ± 23%     -48.2%    4007685 ±  5%  iozone.128KB_128reclen.rewrite
   4815130 ± 16%     -30.8%    3333097 ± 11%  iozone.128KB_128reclen.write
   5542899 ± 11%     -31.0%    3824549 ± 11%  iozone.128KB_16reclen.fwrite
   6226594 ±  4%     -41.4%    3647543 ± 15%  iozone.128KB_16reclen.random_write
   7172507 ±  5%     -47.4%    3771299 ±  5%  iozone.128KB_16reclen.record_rewrite
   7134426 ± 10%     -36.2%    4555185 ±  9%  iozone.128KB_32reclen.frewrite
   6881922 ± 10%     -33.5%    4577827 ± 11%  iozone.128KB_32reclen.fwrite
   8177459 ±  5%     -49.3%    4149876 ±  7%  iozone.128KB_32reclen.random_write
   8738321 ± 18%     -55.0%    3931320 ±  7%  iozone.128KB_32reclen.record_rewrite
   6494015 ± 15%     -46.0%    3506189 ± 19%  iozone.128KB_32reclen.rewrite
   2594986 ± 17%     +14.4%    2968586        iozone.128KB_4reclen.random_write
   2580603 ± 16%     +22.5%    3162109 ±  6%  iozone.128KB_4reclen.rewrite
   9770675 ±  5%     -54.9%    4402384 ±  4%  iozone.128KB_64reclen.random_write
  10413873 ±  6%     -59.1%    4257941        iozone.128KB_64reclen.record_rewrite
   7293854 ± 17%     -47.2%    3853718 ± 12%  iozone.128KB_64reclen.rewrite
   4886361 ± 10%     -33.0%    3275505 ± 22%  iozone.128KB_8reclen.record_rewrite
    384352           -16.6%     320541 ±  2%  iozone.131072KB_1024reclen
   4187870           -36.7%    2651178        iozone.131072KB_1024reclen.frewrite
   4220181           -36.9%    2661430        iozone.131072KB_1024reclen.fwrite
   4887947 ±  2%     -41.2%    2874398        iozone.131072KB_1024reclen.random_write
  12467364 ±  5%     -68.2%    3959839        iozone.131072KB_1024reclen.record_rewrite
   4734810           -39.5%    2864893        iozone.131072KB_1024reclen.rewrite
   3710046           -27.2%    2700687        iozone.131072KB_1024reclen.write
    452795 ±  2%     -19.6%     363866 ±  2%  iozone.131072KB_128reclen
   4266654           -37.2%    2681345        iozone.131072KB_128reclen.frewrite
   4284843 ±  2%     -36.9%    2703800        iozone.131072KB_128reclen.fwrite
   4611392           -40.4%    2746837        iozone.131072KB_128reclen.random_write
  19555585 ±  2%     -76.0%    4701436        iozone.131072KB_128reclen.record_rewrite
   4491416           -38.6%    2756157        iozone.131072KB_128reclen.rewrite
   3603325           -27.4%    2616309        iozone.131072KB_128reclen.write
    336442 ±  2%     -11.8%     296621 ±  3%  iozone.131072KB_16384reclen
   3410515 ±  3%     -29.1%    2418230        iozone.131072KB_16384reclen.frewrite
   3576351 ±  2%     -30.8%    2473419        iozone.131072KB_16384reclen.fwrite
   4591806           -38.4%    2826293        iozone.131072KB_16384reclen.random_write
   7350622 ±  5%     -56.4%    3202543 ±  2%  iozone.131072KB_16384reclen.record_rewrite
   4422534 ±  2%     -36.9%    2790029        iozone.131072KB_16384reclen.rewrite
   3482443 ±  2%     -24.8%    2619824 ±  2%  iozone.131072KB_16384reclen.write
    371380           -14.6%     317138 ±  2%  iozone.131072KB_2048reclen
   4078709           -36.4%    2593133        iozone.131072KB_2048reclen.frewrite
   4098349           -36.1%    2620428        iozone.131072KB_2048reclen.fwrite
   4787858           -40.7%    2838462        iozone.131072KB_2048reclen.random_write
  10082067           -63.0%    3728429        iozone.131072KB_2048reclen.record_rewrite
   4677749           -39.3%    2838243        iozone.131072KB_2048reclen.rewrite
   3679263           -26.7%    2697355        iozone.131072KB_2048reclen.write
    474632           -21.3%     373696        iozone.131072KB_256reclen
   4492015           -38.7%    2752060        iozone.131072KB_256reclen.frewrite
   4490272           -38.3%    2772295        iozone.131072KB_256reclen.fwrite
   4748066           -41.4%    2782193        iozone.131072KB_256reclen.random_write
  21604472           -78.3%    4683478 ±  2%  iozone.131072KB_256reclen.record_rewrite
   4616454           -40.0%    2769602        iozone.131072KB_256reclen.rewrite
   3648377           -28.5%    2607598        iozone.131072KB_256reclen.write
    367895           -14.6%     314350 ±  2%  iozone.131072KB_4096reclen
   9062077 ±  2%      -3.8%    8715521 ±  2%  iozone.131072KB_4096reclen.bkwd_read
   4059040           -35.4%    2623511        iozone.131072KB_4096reclen.frewrite
   4105650           -35.7%    2641258        iozone.131072KB_4096reclen.fwrite
   4748841 ±  2%     -40.1%    2846874        iozone.131072KB_4096reclen.random_write
   9805385           -62.3%    3696059        iozone.131072KB_4096reclen.record_rewrite
   4635048           -38.6%    2846269        iozone.131072KB_4096reclen.rewrite
   3681205           -26.9%    2692674        iozone.131072KB_4096reclen.write
    448220           -19.2%     362152        iozone.131072KB_512reclen
  10496215 ±  2%      +3.3%   10844450 ±  2%  iozone.131072KB_512reclen.freread
   4491992           -38.0%    2784974        iozone.131072KB_512reclen.frewrite
   4514993           -37.6%    2815708        iozone.131072KB_512reclen.fwrite
   4956362           -42.1%    2870296        iozone.131072KB_512reclen.random_write
  19233272 ±  2%     -76.2%    4583471        iozone.131072KB_512reclen.record_rewrite
   4917028 ±  2%     -41.6%    2870477        iozone.131072KB_512reclen.rewrite
   3853695           -28.9%    2740736        iozone.131072KB_512reclen.write
    430232           -17.6%     354607 ±  2%  iozone.131072KB_64reclen
   4122519           -36.3%    2625773        iozone.131072KB_64reclen.frewrite
   4134079           -35.2%    2679771        iozone.131072KB_64reclen.fwrite
   4325858           -38.7%    2653598        iozone.131072KB_64reclen.random_write
  16981332           -72.6%    4660451        iozone.131072KB_64reclen.record_rewrite
   4350931           -37.6%    2712816        iozone.131072KB_64reclen.rewrite
   3498084           -27.3%    2543888 ±  2%  iozone.131072KB_64reclen.write
    372156 ±  2%     -13.7%     321258 ±  2%  iozone.131072KB_8192reclen
   4121451 ±  2%     -35.4%    2660880        iozone.131072KB_8192reclen.frewrite
   4147994 ±  2%     -35.4%    2679261        iozone.131072KB_8192reclen.fwrite
   4757455 ±  2%     -40.9%    2811156 ±  2%  iozone.131072KB_8192reclen.random_write
   9351046           -61.4%    3605035        iozone.131072KB_8192reclen.record_rewrite
   4617143 ±  2%     -38.7%    2830230        iozone.131072KB_8192reclen.rewrite
   3610746           -25.9%    2676759        iozone.131072KB_8192reclen.write
    507341 ±  4%     -18.7%     412696 ±  3%  iozone.16384KB_1024reclen
   6336944 ±  5%     -42.8%    3626514 ±  5%  iozone.16384KB_1024reclen.frewrite
   5975822 ±  9%     -42.0%    3467668 ±  7%  iozone.16384KB_1024reclen.fwrite
   9625022 ±  4%     -56.3%    4209850 ±  2%  iozone.16384KB_1024reclen.random_write
  12736426 ±  2%     -68.4%    4025253        iozone.16384KB_1024reclen.record_rewrite
   7663418 ± 15%     -50.8%    3771090 ±  7%  iozone.16384KB_1024reclen.rewrite
   5109291 ±  3%     -31.2%    3516354 ±  5%  iozone.16384KB_1024reclen.write
    643735 ±  5%     -18.4%     525148 ±  6%  iozone.16384KB_128reclen
   7284276 ± 13%     -44.3%    4056501 ±  5%  iozone.16384KB_128reclen.frewrite
   7908295 ± 11%     -48.9%    4040019 ±  5%  iozone.16384KB_128reclen.fwrite
  10297149 ±  4%     -56.8%    4446408        iozone.16384KB_128reclen.random_write
  20064811           -76.6%    4701926        iozone.16384KB_128reclen.record_rewrite
   7846710 ± 13%     -48.8%    4014765 ±  7%  iozone.16384KB_128reclen.rewrite
   5180669 ± 12%     -29.9%    3630809 ±  9%  iozone.16384KB_128reclen.write
    379036 ±  9%     -15.4%     320835 ± 10%  iozone.16384KB_16384reclen
   5879026 ± 14%     -45.7%    3190508 ± 10%  iozone.16384KB_16384reclen.frewrite
   5548877 ± 14%     -41.2%    3260007 ±  9%  iozone.16384KB_16384reclen.fwrite
   7659423 ±  2%     -51.2%    3739849        iozone.16384KB_16384reclen.random_write
   6727664 ± 11%     -48.9%    3437737 ±  7%  iozone.16384KB_16384reclen.record_rewrite
   5799972 ± 14%     -42.6%    3326350 ±  4%  iozone.16384KB_16384reclen.rewrite
   3596354 ±  9%     -24.7%    2709540 ±  6%  iozone.16384KB_16384reclen.write
    486506 ±  4%      -9.5%     440477 ±  5%  iozone.16384KB_16reclen
   5450161 ±  7%     -33.0%    3650670 ±  6%  iozone.16384KB_16reclen.frewrite
   5503462 ±  6%     -33.3%    3672545 ±  4%  iozone.16384KB_16reclen.fwrite
   6029700 ±  2%     -39.0%    3675707        iozone.16384KB_16reclen.random_write
   9116110 ±  3%     -52.2%    4360762        iozone.16384KB_16reclen.record_rewrite
   5604741 ±  8%     -33.1%    3749791 ±  6%  iozone.16384KB_16reclen.rewrite
   4292995 ±  6%     -23.2%    3297457 ±  8%  iozone.16384KB_16reclen.write
    462856 ±  4%     -16.6%     385989 ±  4%  iozone.16384KB_2048reclen
   6153667 ±  9%     -41.5%    3597198 ±  6%  iozone.16384KB_2048reclen.frewrite
   5449827 ± 11%     -36.8%    3445200 ±  8%  iozone.16384KB_2048reclen.fwrite
   8560815           -53.7%    3960813        iozone.16384KB_2048reclen.random_write
   9782852 ±  3%     -61.3%    3781912        iozone.16384KB_2048reclen.record_rewrite
   7191079 ±  8%     -49.8%    3607011 ±  8%  iozone.16384KB_2048reclen.rewrite
   4737205 ±  9%     -29.3%    3349082 ±  8%  iozone.16384KB_2048reclen.write
    665280 ±  4%     -20.9%     526100 ±  6%  iozone.16384KB_256reclen
   8195747 ±  9%     -51.8%    3948302 ±  8%  iozone.16384KB_256reclen.frewrite
   8249066 ±  9%     -50.4%    4088287 ±  6%  iozone.16384KB_256reclen.fwrite
  11094734 ±  2%     -59.5%    4492766 ±  2%  iozone.16384KB_256reclen.random_write
  21693249           -78.2%    4722868        iozone.16384KB_256reclen.record_rewrite
   8477277 ± 10%     -52.4%    4031471 ±  9%  iozone.16384KB_256reclen.rewrite
   5278441 ±  6%     -29.3%    3729284 ±  8%  iozone.16384KB_256reclen.write
    550570 ±  4%     -13.0%     478829 ±  5%  iozone.16384KB_32reclen
   6717424 ±  5%     -41.9%    3903876 ±  4%  iozone.16384KB_32reclen.frewrite
   6358062 ±  8%     -38.5%    3912409 ±  5%  iozone.16384KB_32reclen.fwrite
   7738915 ±  3%     -47.9%    4031920 ±  2%  iozone.16384KB_32reclen.random_write
  13092049 ±  5%     -65.2%    4552060        iozone.16384KB_32reclen.record_rewrite
   6793062 ± 10%     -42.1%    3935793 ±  8%  iozone.16384KB_32reclen.rewrite
   4654579 ± 11%     -24.2%    3526713 ±  8%  iozone.16384KB_32reclen.write
    449979 ±  5%     -15.9%     378538 ±  6%  iozone.16384KB_4096reclen
   6135760 ± 16%     -38.6%    3765269 ± 11%  iozone.16384KB_4096reclen.frewrite
   5660955 ± 11%     -35.6%    3648184 ±  9%  iozone.16384KB_4096reclen.fwrite
   8518821           -53.3%    3976373 ±  2%  iozone.16384KB_4096reclen.random_write
   9355279 ±  3%     -59.6%    3784167        iozone.16384KB_4096reclen.record_rewrite
   6601589 ± 13%     -45.9%    3573371 ±  7%  iozone.16384KB_4096reclen.rewrite
   4422582 ± 11%     -28.4%    3164939 ±  8%  iozone.16384KB_4096reclen.write
   2736469 ±  3%      +7.4%    2939679 ±  5%  iozone.16384KB_4reclen.frewrite
   3416531            +2.8%    3511309        iozone.16384KB_4reclen.record_rewrite
    595796 ±  3%     -21.7%     466375 ±  4%  iozone.16384KB_512reclen
   7394396 ±  4%     -49.0%    3768420 ±  8%  iozone.16384KB_512reclen.frewrite
   7325705 ±  8%     -46.3%    3931880 ±  5%  iozone.16384KB_512reclen.fwrite
  10721576 ±  7%     -58.4%    4462432 ±  3%  iozone.16384KB_512reclen.random_write
  19201645 ±  2%     -76.1%    4583068        iozone.16384KB_512reclen.record_rewrite
   8601383 ± 12%     -52.7%    4069394 ±  7%  iozone.16384KB_512reclen.rewrite
   5535264 ±  8%     -34.0%    3654929 ± 10%  iozone.16384KB_512reclen.write
    616298 ±  4%     -16.8%     512695 ±  5%  iozone.16384KB_64reclen
   7429221 ± 11%     -46.8%    3949408 ±  8%  iozone.16384KB_64reclen.frewrite
   7672960 ±  8%     -47.1%    4060726 ±  5%  iozone.16384KB_64reclen.fwrite
   9543899           -54.8%    4313429        iozone.16384KB_64reclen.random_write
  16952638 ±  2%     -72.4%    4678576        iozone.16384KB_64reclen.record_rewrite
   7421949 ± 12%     -46.8%    3948342 ±  8%  iozone.16384KB_64reclen.rewrite
   4953149 ± 12%     -28.4%    3545804 ±  6%  iozone.16384KB_64reclen.write
    411896 ±  8%     -11.0%     366634 ±  7%  iozone.16384KB_8192reclen
   6539452 ± 16%     -27.2%    4763647 ±  8%  iozone.16384KB_8192reclen.frewrite
   5046680 ±  5%     -26.0%    3736788 ±  7%  iozone.16384KB_8192reclen.fwrite
   8153406 ±  3%     -51.4%    3960619        iozone.16384KB_8192reclen.random_write
   7903795 ±  8%     -53.7%    3659114 ±  3%  iozone.16384KB_8192reclen.record_rewrite
   5937662 ± 17%     -42.6%    3407177 ±  6%  iozone.16384KB_8192reclen.rewrite
   4164583 ± 13%     -27.5%    3020571 ± 10%  iozone.16384KB_8192reclen.write
   4298453 ±  5%     -20.9%    3401509 ±  8%  iozone.16384KB_8reclen.frewrite
   4191839 ±  5%     -18.8%    3404414 ±  6%  iozone.16384KB_8reclen.fwrite
   4200904           -24.5%    3171742        iozone.16384KB_8reclen.random_write
   6118563           -32.2%    4150720        iozone.16384KB_8reclen.record_rewrite
   4529237 ±  4%     -21.7%    3548161 ±  6%  iozone.16384KB_8reclen.rewrite
   3535152 ±  4%     -13.1%    3071626 ±  7%  iozone.16384KB_8reclen.write
    542238           -19.1%     438489        iozone.2048KB_1024reclen
  11967644 ±  4%     -44.2%    6680286 ±  2%  iozone.2048KB_1024reclen.frewrite
   5744660 ±  3%     -28.8%    4089015 ±  6%  iozone.2048KB_1024reclen.fwrite
   9303909 ±  7%     -53.8%    4297862        iozone.2048KB_1024reclen.random_write
  10889649 ±  2%     -62.6%    4071096 ±  3%  iozone.2048KB_1024reclen.record_rewrite
   9130132 ±  2%     -56.7%    3953157 ±  5%  iozone.2048KB_1024reclen.rewrite
   5982222           -35.1%    3882699        iozone.2048KB_1024reclen.write
    776202 ±  2%     -18.4%     633443        iozone.2048KB_128reclen
   8878597 ± 13%     -49.4%    4495701        iozone.2048KB_128reclen.frewrite
   9638797 ±  2%     -54.5%    4389962 ±  7%  iozone.2048KB_128reclen.fwrite
  10844235 ± 11%     -57.1%    4651671        iozone.2048KB_128reclen.random_write
  18749665 ±  3%     -75.2%    4655816        iozone.2048KB_128reclen.record_rewrite
   9623215 ±  4%     -54.5%    4382932 ±  2%  iozone.2048KB_128reclen.rewrite
   6377481 ±  9%     -36.4%    4059105 ±  3%  iozone.2048KB_128reclen.write
    552097 ±  2%     -11.2%     490114        iozone.2048KB_16reclen
   6129175           -35.3%    3964251        iozone.2048KB_16reclen.frewrite
   6067908 ±  4%     -34.5%    3971599        iozone.2048KB_16reclen.fwrite
   6592107           -40.8%    3903901 ±  4%  iozone.2048KB_16reclen.random_write
   9122387           -52.4%    4346330        iozone.2048KB_16reclen.record_rewrite
   6740945 ±  3%     -39.6%    4072351 ±  3%  iozone.2048KB_16reclen.rewrite
   5188484 ±  4%     -28.3%    3721925 ±  6%  iozone.2048KB_16reclen.write
    491057 ±  2%     -18.4%     400917        iozone.2048KB_2048reclen
   8029406 ±  3%     -50.7%    3959139        iozone.2048KB_2048reclen.frewrite
   8107078 ±  3%     -50.8%    3986328 ±  2%  iozone.2048KB_2048reclen.fwrite
   8257179 ±  2%     -51.0%    4042627        iozone.2048KB_2048reclen.random_write
   7947631 ±  7%     -50.7%    3920484 ±  5%  iozone.2048KB_2048reclen.record_rewrite
   7969246 ±  2%     -53.0%    3748665 ±  2%  iozone.2048KB_2048reclen.rewrite
   5006403 ±  7%     -33.9%    3309778 ±  5%  iozone.2048KB_2048reclen.write
    796104 ±  3%     -20.1%     635928        iozone.2048KB_256reclen
  10156675 ±  2%     -54.3%    4641495 ±  5%  iozone.2048KB_256reclen.frewrite
  10096107 ±  3%     -53.4%    4706843        iozone.2048KB_256reclen.fwrite
  11849621 ±  2%     -60.5%    4675630        iozone.2048KB_256reclen.random_write
  20078106           -76.4%    4729504        iozone.2048KB_256reclen.record_rewrite
  10479126 ±  6%     -57.4%    4466888        iozone.2048KB_256reclen.rewrite
   6739247 ±  4%     -37.8%    4194711 ±  2%  iozone.2048KB_256reclen.write
    632369 ±  2%     -15.9%     531966        iozone.2048KB_32reclen
   7515327 ±  2%     -45.2%    4118630        iozone.2048KB_32reclen.frewrite
   7692252           -45.6%    4188416        iozone.2048KB_32reclen.fwrite
   8804466           -52.0%    4229942 ±  4%  iozone.2048KB_32reclen.random_write
  12723390 ±  2%     -64.6%    4508303        iozone.2048KB_32reclen.record_rewrite
   8136652 ±  4%     -47.4%    4278591        iozone.2048KB_32reclen.rewrite
   5533601 ±  7%     -29.6%    3895216 ±  7%  iozone.2048KB_32reclen.write
   3108439            +5.5%    3277973 ±  2%  iozone.2048KB_4reclen.frewrite
   3138092            +5.7%    3316904        iozone.2048KB_4reclen.fwrite
   3400624            +3.5%    3521251        iozone.2048KB_4reclen.record_rewrite
   3223326 ±  2%      +3.9%    3348769        iozone.2048KB_4reclen.rewrite
   2501633            +5.3%    2633799        iozone.2048KB_4reclen.write
    688280 ±  2%     -20.3%     548546 ±  2%  iozone.2048KB_512reclen
  10166943 ±  8%     -49.7%    5109818 ±  2%  iozone.2048KB_512reclen.frewrite
  10130829 ±  3%     -50.9%    4976143 ±  4%  iozone.2048KB_512reclen.fwrite
  11034618 ±  9%     -58.2%    4609040        iozone.2048KB_512reclen.random_write
  16635631 ±  6%     -73.3%    4448460 ±  6%  iozone.2048KB_512reclen.record_rewrite
   9824663 ±  4%     -56.5%    4270365 ±  2%  iozone.2048KB_512reclen.rewrite
    702000           -19.2%     566982        iozone.2048KB_64reclen
   8714969 ±  2%     -50.2%    4336360        iozone.2048KB_64reclen.frewrite
   8877096 ±  2%     -51.2%    4328037        iozone.2048KB_64reclen.fwrite
  10068549 ±  4%     -54.7%    4556848        iozone.2048KB_64reclen.random_write
  16412084 ±  2%     -72.1%    4580174        iozone.2048KB_64reclen.record_rewrite
   8862714 ± 13%     -50.2%    4414148 ±  2%  iozone.2048KB_64reclen.rewrite
   6484504 ±  4%     -36.8%    4096678 ±  4%  iozone.2048KB_64reclen.write
    459113            -5.0%     436126 ±  2%  iozone.2048KB_8reclen
   4667715 ±  2%     -21.9%    3643856 ±  4%  iozone.2048KB_8reclen.frewrite
   4720714 ±  2%     -21.3%    3715479        iozone.2048KB_8reclen.fwrite
   4604725           -23.6%    3517498        iozone.2048KB_8reclen.random_write
   6066526           -32.0%    4128204        iozone.2048KB_8reclen.record_rewrite
   5079700 ±  2%     -23.4%    3889912 ±  2%  iozone.2048KB_8reclen.rewrite
   4310419 ±  2%     -15.0%    3663807        iozone.2048KB_8reclen.write
    870720 ±  3%     -13.1%     756922 ±  3%  iozone.256KB_128reclen
  12361676 ±  8%     -47.6%    6481418 ± 17%  iozone.256KB_128reclen.frewrite
   6028859 ±  7%     -30.4%    4198028 ±  4%  iozone.256KB_128reclen.fwrite
  11978539 ± 18%     -58.6%    4954925        iozone.256KB_128reclen.random_write
  13989142 ±  2%     -67.0%    4613207        iozone.256KB_128reclen.record_rewrite
   8781211 ±  6%     -50.7%    4327498        iozone.256KB_128reclen.rewrite
   5824968 ±  8%     -32.2%    3948101        iozone.256KB_128reclen.write
    625545 ±  2%      -5.9%     588550 ±  3%  iozone.256KB_16reclen
   5784735 ±  4%     -31.5%    3965344 ±  3%  iozone.256KB_16reclen.fwrite
   8124473           -48.8%    4162493        iozone.256KB_16reclen.record_rewrite
   5933337 ± 11%     -32.7%    3990978 ±  2%  iozone.256KB_16reclen.rewrite
    935680 ±  3%     -14.2%     803142 ±  3%  iozone.256KB_256reclen
   9790828 ±  3%     -55.6%    4348832 ±  4%  iozone.256KB_256reclen.frewrite
  10303926 ±  6%     -59.5%    4172312 ± 15%  iozone.256KB_256reclen.fwrite
  13790229 ±  2%     -65.1%    4809704 ±  6%  iozone.256KB_256reclen.random_write
  12454134 ± 18%     -61.3%    4814061 ±  4%  iozone.256KB_256reclen.record_rewrite
   8657426 ± 16%     -53.8%    4000771 ± 16%  iozone.256KB_256reclen.rewrite
   5555379 ±  9%     -43.2%    3153475 ± 18%  iozone.256KB_256reclen.write
    735809           -13.6%     635861 ±  2%  iozone.256KB_32reclen
   6747110 ± 11%     -37.3%    4227088 ± 10%  iozone.256KB_32reclen.fwrite
   9481865           -53.9%    4370633 ±  5%  iozone.256KB_32reclen.random_write
  10467768 ± 15%     -61.5%    4033680 ±  7%  iozone.256KB_32reclen.record_rewrite
   7382401 ±  9%     -48.9%    3774211 ± 15%  iozone.256KB_32reclen.rewrite
   5195034 ±  7%     -28.3%    3724939 ±  8%  iozone.256KB_32reclen.write
   2757773 ± 12%     +10.4%    3043370        iozone.256KB_4reclen.random_write
    815894 ±  2%     -14.4%     698331 ±  4%  iozone.256KB_64reclen
   9377172 ±  2%     -46.9%    4979439 ±  4%  iozone.256KB_64reclen.frewrite
   9153569 ±  6%     -45.1%    5025568 ±  2%  iozone.256KB_64reclen.fwrite
  11381553           -58.0%    4785614        iozone.256KB_64reclen.random_write
  12306212 ± 18%     -64.4%    4375581 ±  3%  iozone.256KB_64reclen.record_rewrite
   7763465 ± 19%     -46.1%    4183995 ±  3%  iozone.256KB_64reclen.rewrite
   5587518 ±  7%     -32.4%    3779744 ±  4%  iozone.256KB_64reclen.write
  14037949 ±  9%     +12.7%   15819848 ±  3%  iozone.256KB_8reclen.freread
   4460606 ±  5%     -20.3%    3553821 ±  4%  iozone.256KB_8reclen.frewrite
   4647707 ±  4%     -19.1%    3758634        iozone.256KB_8reclen.fwrite
   4759194 ±  5%     -22.5%    3690742        iozone.256KB_8reclen.random_write
    386912           -19.1%     313007        iozone.262144KB_1024reclen
   4232892           -37.9%    2628759        iozone.262144KB_1024reclen.frewrite
   4220249           -37.5%    2637327        iozone.262144KB_1024reclen.fwrite
   4772977           -41.3%    2800063        iozone.262144KB_1024reclen.random_write
  12990282           -69.6%    3951277        iozone.262144KB_1024reclen.record_rewrite
   4740754           -40.3%    2831528        iozone.262144KB_1024reclen.rewrite
   3693124           -28.3%    2646645 ±  2%  iozone.262144KB_1024reclen.write
    439819 ±  4%     -18.9%     356653        iozone.262144KB_128reclen
   4095694 ±  9%     -35.9%    2624476 ±  2%  iozone.262144KB_128reclen.frewrite
   4082631 ± 10%     -34.8%    2660105        iozone.262144KB_128reclen.fwrite
   4434398           -40.8%    2627179        iozone.262144KB_128reclen.random_write
  19653812           -76.1%    4706514        iozone.262144KB_128reclen.record_rewrite
   4436480 ±  2%     -38.3%    2738822        iozone.262144KB_128reclen.rewrite
   3512565 ±  3%     -26.1%    2594547        iozone.262144KB_128reclen.write
    345916 ±  2%     -12.6%     302486 ±  5%  iozone.262144KB_16384reclen
   3337163           -31.2%    2297628        iozone.262144KB_16384reclen.frewrite
   3336960           -30.8%    2308592        iozone.262144KB_16384reclen.fwrite
   4616039           -40.9%    2726326 ±  7%  iozone.262144KB_16384reclen.random_write
   4509231           -39.6%    2725345 ±  6%  iozone.262144KB_16384reclen.rewrite
   3552695           -26.7%    2605620        iozone.262144KB_16384reclen.write
   3905995 ±  8%     -34.1%    2572630        iozone.262144KB_2048reclen.frewrite
   3914526 ±  8%     -34.2%    2577172        iozone.262144KB_2048reclen.fwrite
   4479660 ±  9%     -37.8%    2785538        iozone.262144KB_2048reclen.random_write
  10156129           -63.6%    3700959        iozone.262144KB_2048reclen.record_rewrite
   4561708 ±  3%     -38.7%    2797958        iozone.262144KB_2048reclen.rewrite
   3637540           -27.0%    2655254        iozone.262144KB_2048reclen.write
    465299 ±  2%     -21.0%     367698        iozone.262144KB_256reclen
   4452043           -39.2%    2707810        iozone.262144KB_256reclen.frewrite
   4450282           -39.6%    2688213 ±  2%  iozone.262144KB_256reclen.fwrite
   4602473           -41.5%    2692954        iozone.262144KB_256reclen.random_write
  20493445 ±  8%     -77.0%    4720395        iozone.262144KB_256reclen.record_rewrite
   4624931           -41.1%    2725390        iozone.262144KB_256reclen.rewrite
   3631181           -28.4%    2600952        iozone.262144KB_256reclen.write
    366160           -14.5%     312920        iozone.262144KB_4096reclen
   4057145           -36.1%    2591310        iozone.262144KB_4096reclen.frewrite
   4091290           -36.7%    2588346        iozone.262144KB_4096reclen.fwrite
   4724809           -40.4%    2816202        iozone.262144KB_4096reclen.random_write
   9746066 ±  4%     -62.1%    3695234        iozone.262144KB_4096reclen.record_rewrite
   4647939           -39.6%    2808401        iozone.262144KB_4096reclen.rewrite
   3598743 ±  2%     -26.5%    2644334        iozone.262144KB_4096reclen.write
    447128           -21.4%     351589        iozone.262144KB_512reclen
   4518476           -39.6%    2727901 ±  2%  iozone.262144KB_512reclen.frewrite
   4517667           -38.8%    2766839        iozone.262144KB_512reclen.fwrite
   4765332           -41.8%    2775083        iozone.262144KB_512reclen.random_write
  19407427           -76.5%    4559227        iozone.262144KB_512reclen.record_rewrite
   4728401 ±  2%     -41.7%    2755664        iozone.262144KB_512reclen.rewrite
   3875199           -30.1%    2710583        iozone.262144KB_512reclen.write
    427384           -18.3%     349104        iozone.262144KB_64reclen
  10634086            -3.0%   10310675 ±  2%  iozone.262144KB_64reclen.freread
   4102264           -36.8%    2591715 ±  2%  iozone.262144KB_64reclen.frewrite
   4104216           -36.2%    2619535        iozone.262144KB_64reclen.fwrite
   4179688           -39.4%    2532034        iozone.262144KB_64reclen.random_write
  16836231           -72.4%    4653955        iozone.262144KB_64reclen.record_rewrite
   4342670           -37.5%    2712345        iozone.262144KB_64reclen.rewrite
   3507363           -26.9%    2563521        iozone.262144KB_64reclen.write
    362595 ±  2%     -13.6%     313185        iozone.262144KB_8192reclen
   4023362           -35.5%    2594112        iozone.262144KB_8192reclen.frewrite
   4087447           -36.2%    2609184        iozone.262144KB_8192reclen.fwrite
   4661543           -39.8%    2808420        iozone.262144KB_8192reclen.random_write
   9649911           -62.1%    3660742        iozone.262144KB_8192reclen.record_rewrite
   4606811           -38.9%    2816488        iozone.262144KB_8192reclen.rewrite
   3604420           -26.2%    2660531        iozone.262144KB_8192reclen.write
    430745 ±  6%     -16.1%     361371 ±  6%  iozone.32768KB_1024reclen
   5106573 ± 12%     -40.5%    3038878 ±  9%  iozone.32768KB_1024reclen.frewrite
   4750666 ± 15%     -37.0%    2993131 ±  7%  iozone.32768KB_1024reclen.fwrite
   7361820 ± 10%     -48.6%    3786123 ±  4%  iozone.32768KB_1024reclen.random_write
  12748249 ±  3%     -68.6%    4002779        iozone.32768KB_1024reclen.record_rewrite
   5828159 ± 17%     -42.4%    3359563 ±  8%  iozone.32768KB_1024reclen.rewrite
   3969186 ± 11%     -24.1%    3011313 ± 10%  iozone.32768KB_1024reclen.write
    517393 ±  8%     -15.9%     435274 ± 11%  iozone.32768KB_128reclen
   5336143 ±  8%     -36.3%    3397212 ± 10%  iozone.32768KB_128reclen.frewrite
   5086832 ± 14%     -35.8%    3266859 ± 13%  iozone.32768KB_128reclen.fwrite
   7219277 ± 13%     -47.0%    3822675 ±  9%  iozone.32768KB_128reclen.random_write
  19751756           -76.2%    4706931        iozone.32768KB_128reclen.record_rewrite
   5487278 ± 20%     -40.7%    3255304 ± 14%  iozone.32768KB_128reclen.rewrite
   4331209 ± 15%     -28.2%    3111554 ± 14%  iozone.32768KB_128reclen.write
    340985 ±  5%     -10.4%     305450 ±  8%  iozone.32768KB_16384reclen
   5062509 ±  5%     -25.1%    3791480 ±  4%  iozone.32768KB_16384reclen.frewrite
   4265672 ±  6%     -19.5%    3432015 ±  4%  iozone.32768KB_16384reclen.fwrite
   5969841 ±  3%     -45.1%    3275347        iozone.32768KB_16384reclen.random_write
   6136996 ±  4%     -49.2%    3120547        iozone.32768KB_16384reclen.record_rewrite
   4924297 ±  8%     -40.3%    2941728 ±  3%  iozone.32768KB_16384reclen.rewrite
   3588118 ±  6%     -25.1%    2686314 ±  8%  iozone.32768KB_16384reclen.write
    419825 ±  5%     -14.9%     357366 ±  5%  iozone.32768KB_2048reclen
   4790850 ± 12%     -36.4%    3046021 ±  8%  iozone.32768KB_2048reclen.frewrite
   4497964 ± 13%     -35.5%    2902101 ±  8%  iozone.32768KB_2048reclen.fwrite
   7102310 ±  8%     -49.9%    3556423 ±  4%  iozone.32768KB_2048reclen.random_write
   9887212 ±  2%     -62.2%    3739800        iozone.32768KB_2048reclen.record_rewrite
   5588856 ± 15%     -43.2%    3172444 ±  6%  iozone.32768KB_2048reclen.rewrite
   4003454 ± 14%     -26.8%    2928727 ± 11%  iozone.32768KB_2048reclen.write
    547607 ±  8%     -19.9%     438811 ±  9%  iozone.32768KB_256reclen
   5897276 ± 18%     -43.7%    3321258 ±  9%  iozone.32768KB_256reclen.frewrite
   6200520 ± 18%     -46.2%    3333057 ± 12%  iozone.32768KB_256reclen.fwrite
   8239263 ± 10%     -53.7%    3811472 ±  8%  iozone.32768KB_256reclen.random_write
  21117174 ±  5%     -77.5%    4748436        iozone.32768KB_256reclen.record_rewrite
   5542146 ± 21%     -40.3%    3308972 ± 14%  iozone.32768KB_256reclen.rewrite
   4329999 ± 14%     -27.6%    3134686 ± 13%  iozone.32768KB_256reclen.write
    406635 ±  5%     -13.8%     350416 ±  5%  iozone.32768KB_4096reclen
   4711958 ±  9%     -35.4%    3046030 ±  7%  iozone.32768KB_4096reclen.frewrite
   4513362 ±  5%     -32.8%    3035023 ±  7%  iozone.32768KB_4096reclen.fwrite
   6806224 ±  8%     -47.6%    3565039 ±  4%  iozone.32768KB_4096reclen.random_write
   9515688 ±  3%     -60.8%    3729359        iozone.32768KB_4096reclen.record_rewrite
   5697618 ± 14%     -41.9%    3310899 ±  6%  iozone.32768KB_4096reclen.rewrite
   3898864 ± 10%     -25.0%    2924428 ± 10%  iozone.32768KB_4096reclen.write
    507657 ±  7%     -19.4%     409147 ±  7%  iozone.32768KB_512reclen
   5698481 ± 16%     -42.0%    3307347 ±  6%  iozone.32768KB_512reclen.frewrite
   5511060 ± 18%     -40.2%    3295398 ± 11%  iozone.32768KB_512reclen.fwrite
   8257419 ± 13%     -53.2%    3867915 ±  7%  iozone.32768KB_512reclen.random_write
  18757129 ±  3%     -75.6%    4571719        iozone.32768KB_512reclen.record_rewrite
   6320097 ± 15%     -44.6%    3500000 ±  9%  iozone.32768KB_512reclen.rewrite
   4380209 ± 14%     -27.6%    3169557 ±  8%  iozone.32768KB_512reclen.write
    502007 ±  8%     -14.5%     429178 ±  9%  iozone.32768KB_64reclen
   5073623 ± 17%     -38.5%    3119857 ± 12%  iozone.32768KB_64reclen.frewrite
   4878282 ± 21%     -33.9%    3224174 ± 14%  iozone.32768KB_64reclen.fwrite
   7259958 ±  9%     -49.6%    3658480 ±  6%  iozone.32768KB_64reclen.random_write
  17020659           -72.6%    4666812        iozone.32768KB_64reclen.record_rewrite
   5279659 ± 15%     -38.9%    3225203 ± 10%  iozone.32768KB_64reclen.rewrite
   3880368 ±  7%     -27.3%    2819139 ±  6%  iozone.32768KB_64reclen.write
    389639 ±  4%     -13.7%     336197 ±  6%  iozone.32768KB_8192reclen
   4839853 ±  9%     -34.2%    3184449 ±  8%  iozone.32768KB_8192reclen.frewrite
   4843025 ±  8%     -30.9%    3347699 ±  5%  iozone.32768KB_8192reclen.fwrite
   6838978 ±  5%     -49.0%    3490336 ±  3%  iozone.32768KB_8192reclen.random_write
   8463330 ±  3%     -58.3%    3529070 ±  2%  iozone.32768KB_8192reclen.record_rewrite
   5195668 ± 13%     -39.6%    3140021 ±  4%  iozone.32768KB_8192reclen.rewrite
   3804852 ±  7%     -26.6%    2791987 ±  7%  iozone.32768KB_8192reclen.write
    540767           -19.9%     433189        iozone.4096KB_1024reclen
   8611741           -46.2%    4633837 ±  3%  iozone.4096KB_1024reclen.frewrite
   7982259 ±  3%     -43.3%    4524830        iozone.4096KB_1024reclen.fwrite
   9858992           -56.2%    4314497        iozone.4096KB_1024reclen.random_write
  11773436           -65.9%    4009160 ±  4%  iozone.4096KB_1024reclen.record_rewrite
   9487287           -56.4%    4132715        iozone.4096KB_1024reclen.rewrite
   6182018           -37.2%    3883984 ±  2%  iozone.4096KB_1024reclen.write
    718567           -21.1%     567107        iozone.4096KB_128reclen
   9293082 ±  2%     -53.0%    4371150        iozone.4096KB_128reclen.frewrite
   9479069           -54.2%    4344052 ±  2%  iozone.4096KB_128reclen.fwrite
  10905845 ±  2%     -58.6%    4511988        iozone.4096KB_128reclen.random_write
  19563786           -76.1%    4675838        iozone.4096KB_128reclen.record_rewrite
  10155905           -56.8%    4389442 ±  2%  iozone.4096KB_128reclen.rewrite
   6774619           -42.3%    3907601 ±  7%  iozone.4096KB_128reclen.write
    523221            -9.6%     473092 ±  2%  iozone.4096KB_16reclen
   5899290 ±  3%     -34.0%    3892436        iozone.4096KB_16reclen.frewrite
   6031737 ±  3%     -34.1%    3975649        iozone.4096KB_16reclen.fwrite
   6278696 ±  2%     -37.8%    3903608        iozone.4096KB_16reclen.random_write
   9027990           -51.8%    4355980        iozone.4096KB_16reclen.record_rewrite
   6616749 ±  3%     -39.5%    4005795 ±  5%  iozone.4096KB_16reclen.rewrite
  12578233 ±  5%      +5.3%   13240641        iozone.4096KB_16reclen.stride_read
   5038372           -25.9%    3731953 ± 12%  iozone.4096KB_16reclen.write
    489965 ±  2%     -15.4%     414282        iozone.4096KB_2048reclen
   9547257 ±  7%     -36.7%    6045206        iozone.4096KB_2048reclen.frewrite
   5175071           -21.4%    4067368        iozone.4096KB_2048reclen.fwrite
   8192636 ±  6%     -50.0%    4093678        iozone.4096KB_2048reclen.random_write
   8862916 ±  7%     -56.0%    3902567        iozone.4096KB_2048reclen.record_rewrite
   8194974           -52.9%    3859066 ±  2%  iozone.4096KB_2048reclen.rewrite
   5488531 ±  4%     -33.8%    3632734 ±  3%  iozone.4096KB_2048reclen.write
    788648 ±  2%     -20.0%     630788        iozone.4096KB_256reclen
   9619567 ±  8%     -52.9%    4526157        iozone.4096KB_256reclen.frewrite
   9276409 ± 12%     -51.4%    4505160        iozone.4096KB_256reclen.fwrite
  11687693 ±  2%     -60.7%    4595548        iozone.4096KB_256reclen.random_write
  21070383 ±  2%     -77.7%    4698817        iozone.4096KB_256reclen.record_rewrite
  10428314 ±  3%     -57.0%    4489073        iozone.4096KB_256reclen.rewrite
   6598566 ±  5%     -36.4%    4195190        iozone.4096KB_256reclen.write
    612946 ±  2%     -14.9%     521837 ±  2%  iozone.4096KB_32reclen
   7564306           -45.6%    4114578        iozone.4096KB_32reclen.frewrite
   7597494 ±  2%     -44.9%    4186534        iozone.4096KB_32reclen.fwrite
   8360234           -50.1%    4167754 ±  4%  iozone.4096KB_32reclen.random_write
  13028009           -65.7%    4472496        iozone.4096KB_32reclen.record_rewrite
   8296146 ±  3%     -47.7%    4341726 ±  2%  iozone.4096KB_32reclen.rewrite
   5472962 ±  5%     -29.2%    3872708 ±  7%  iozone.4096KB_32reclen.write
    494535           -17.1%     409955        iozone.4096KB_4096reclen
   8255573           -51.6%    3995035        iozone.4096KB_4096reclen.frewrite
   8346592           -52.4%    3974015 ±  2%  iozone.4096KB_4096reclen.fwrite
   8201398 ±  7%     -50.7%    4045946        iozone.4096KB_4096reclen.random_write
   8274606 ±  6%     -51.6%    4002597 ±  2%  iozone.4096KB_4096reclen.record_rewrite
   7831980 ±  2%     -51.5%    3799508 ±  3%  iozone.4096KB_4096reclen.rewrite
   4397504 ±  5%     -28.5%    3145452 ±  2%  iozone.4096KB_4096reclen.write
   3021797            +4.1%    3144891        iozone.4096KB_4reclen.frewrite
   3106524            +3.9%    3226860        iozone.4096KB_4reclen.fwrite
   2665097            +3.7%    2764793        iozone.4096KB_4reclen.random_write
   3352970 ±  2%      +3.9%    3483980        iozone.4096KB_4reclen.record_rewrite
    694005           -22.0%     541105        iozone.4096KB_512reclen
   9325284 ±  2%     -51.5%    4518164        iozone.4096KB_512reclen.frewrite
   9033512           -50.9%    4438984        iozone.4096KB_512reclen.fwrite
  11710424           -61.2%    4546638        iozone.4096KB_512reclen.random_write
  18085198 ±  2%     -75.2%    4476732 ±  2%  iozone.4096KB_512reclen.record_rewrite
  10712906 ±  3%     -58.6%    4432845        iozone.4096KB_512reclen.rewrite
   6855284 ±  3%     -41.6%    4000142 ±  5%  iozone.4096KB_512reclen.write
    675724           -18.9%     548114        iozone.4096KB_64reclen
   8659900 ±  2%     -51.4%    4205335 ±  3%  iozone.4096KB_64reclen.frewrite
   8808427           -52.5%    4188372 ±  4%  iozone.4096KB_64reclen.fwrite
   9792198 ±  3%     -56.0%    4310321 ±  4%  iozone.4096KB_64reclen.random_write
  16087821 ± 12%     -71.3%    4611977        iozone.4096KB_64reclen.record_rewrite
   9493496 ±  2%     -54.2%    4351712 ±  2%  iozone.4096KB_64reclen.rewrite
   6134545 ±  8%     -36.2%    3915308 ± 10%  iozone.4096KB_64reclen.write
    431652            -4.6%     411673 ±  2%  iozone.4096KB_8reclen
   4505758 ±  3%     -20.0%    3604777 ±  2%  iozone.4096KB_8reclen.frewrite
   4592234 ±  2%     -20.7%    3639426 ±  2%  iozone.4096KB_8reclen.fwrite
   4348309           -23.8%    3314837        iozone.4096KB_8reclen.random_write
   5942635 ±  2%     -31.8%    4052635        iozone.4096KB_8reclen.record_rewrite
   4895637 ±  3%     -23.9%    3727054 ±  3%  iozone.4096KB_8reclen.rewrite
   4005205 ±  5%     -16.9%    3329643 ±  6%  iozone.4096KB_8reclen.write
    849891 ±  4%     -16.6%     708633 ±  2%  iozone.512KB_128reclen
   9992208 ±  9%     -49.9%    5005962 ±  8%  iozone.512KB_128reclen.frewrite
  10064753 ±  4%     -48.7%    5160189 ±  3%  iozone.512KB_128reclen.fwrite
  12495290 ± 17%     -60.6%    4927676 ±  2%  iozone.512KB_128reclen.random_write
  16391811           -71.7%    4631043 ±  2%  iozone.512KB_128reclen.record_rewrite
   9497853 ±  6%     -54.7%    4302767        iozone.512KB_128reclen.rewrite
   6276757 ±  3%     -36.4%    3993325 ±  3%  iozone.512KB_128reclen.write
    599163 ±  2%     -10.3%     537677        iozone.512KB_16reclen
   5966929 ±  3%     -34.9%    3882542 ±  2%  iozone.512KB_16reclen.frewrite
   6244343 ±  3%     -34.7%    4078115        iozone.512KB_16reclen.fwrite
   7236442           -45.3%    3957756 ± 13%  iozone.512KB_16reclen.random_write
   8399936 ±  9%     -51.3%    4087729 ±  6%  iozone.512KB_16reclen.record_rewrite
    863825 ±  3%     -17.7%     711184 ±  2%  iozone.512KB_256reclen
  13205154 ±  5%     -46.7%    7031941 ±  3%  iozone.512KB_256reclen.frewrite
   5998441 ± 11%     -36.5%    3806622 ± 17%  iozone.512KB_256reclen.fwrite
  12721268 ± 18%     -60.4%    5043097        iozone.512KB_256reclen.random_write
  16456398           -71.3%    4722798 ±  4%  iozone.512KB_256reclen.record_rewrite
   9459473 ±  6%     -56.4%    4121683 ±  6%  iozone.512KB_256reclen.rewrite
   6550693 ±  3%     -38.1%    4055738 ±  3%  iozone.512KB_256reclen.write
    732462 ±  2%     -14.6%     625747        iozone.512KB_32reclen
   7377624 ±  4%     -44.6%    4090644 ±  2%  iozone.512KB_32reclen.frewrite
   7551793 ±  4%     -45.8%    4090321 ± 11%  iozone.512KB_32reclen.fwrite
   8925654 ± 16%     -49.0%    4556410 ±  2%  iozone.512KB_32reclen.random_write
  11864679 ±  5%     -63.1%    4378521 ±  2%  iozone.512KB_32reclen.record_rewrite
   7914508 ±  3%     -46.2%    4255137        iozone.512KB_32reclen.rewrite
   5626769 ±  3%     -31.0%    3880678 ±  5%  iozone.512KB_32reclen.write
   2906904 ± 10%     +10.7%    3219190        iozone.512KB_4reclen.frewrite
   3153534 ±  2%      +5.3%    3320554        iozone.512KB_4reclen.fwrite
   2927583 ±  2%      +5.0%    3075410        iozone.512KB_4reclen.random_write
   3107640 ±  6%      +6.2%    3298881        iozone.512KB_4reclen.rewrite
    769326 ±  2%     -19.1%     622490 ±  3%  iozone.512KB_512reclen
  10119261 ±  7%     -57.3%    4317683 ±  4%  iozone.512KB_512reclen.frewrite
  10233799 ± 17%     -56.8%    4425162 ±  2%  iozone.512KB_512reclen.fwrite
  13200700           -63.5%    4816654 ±  3%  iozone.512KB_512reclen.random_write
  12282134 ± 10%     -60.3%    4875884        iozone.512KB_512reclen.record_rewrite
   9872795 ±  2%     -58.6%    4091749 ±  7%  iozone.512KB_512reclen.rewrite
   5881992 ±  7%     -41.4%    3447105 ± 10%  iozone.512KB_512reclen.write
    818577           -15.6%     690775 ±  2%  iozone.512KB_64reclen
   8818717 ±  2%     -47.9%    4596044 ±  2%  iozone.512KB_64reclen.frewrite
   9137566 ±  2%     -50.6%    4513498 ±  2%  iozone.512KB_64reclen.fwrite
  11953274           -60.2%    4758179 ±  3%  iozone.512KB_64reclen.random_write
  14353795 ±  5%     -68.8%    4475153 ±  3%  iozone.512KB_64reclen.record_rewrite
   9033427 ±  2%     -52.6%    4279366 ±  2%  iozone.512KB_64reclen.rewrite
   5859731 ± 11%     -30.4%    4078862        iozone.512KB_64reclen.write
   4515885 ±  2%     -21.6%    3541587 ±  6%  iozone.512KB_8reclen.frewrite
   4755612           -21.4%    3738229 ±  3%  iozone.512KB_8reclen.fwrite
   4810738 ±  3%     -23.8%    3666569        iozone.512KB_8reclen.random_write
   5581570 ±  8%     -26.6%    4094825        iozone.512KB_8reclen.record_rewrite
   4904944 ±  6%     -28.3%    3518088 ± 11%  iozone.512KB_8reclen.rewrite
    380205           -17.3%     314508        iozone.524288KB_1024reclen
   4169635           -37.4%    2609179        iozone.524288KB_1024reclen.frewrite
   4192878           -37.5%    2620663        iozone.524288KB_1024reclen.fwrite
   4749212           -41.2%    2790599        iozone.524288KB_1024reclen.random_write
  13005989           -69.5%    3963551 ±  2%  iozone.524288KB_1024reclen.record_rewrite
   4712619           -40.0%    2825312        iozone.524288KB_1024reclen.rewrite
   3636115           -28.4%    2602505 ±  4%  iozone.524288KB_1024reclen.write
    435312 ±  7%     -18.2%     356004        iozone.524288KB_128reclen
   4105371 ±  9%     -36.0%    2628026        iozone.524288KB_128reclen.frewrite
   4106735 ±  9%     -35.5%    2648708        iozone.524288KB_128reclen.fwrite
   4208576 ± 10%     -38.8%    2575677        iozone.524288KB_128reclen.random_write
  19672399           -76.2%    4677090        iozone.524288KB_128reclen.record_rewrite
   4413066 ±  5%     -38.7%    2703636        iozone.524288KB_128reclen.rewrite
   3596681           -29.0%    2552941        iozone.524288KB_128reclen.write
    341830           -11.6%     302184 ±  2%  iozone.524288KB_16384reclen
   8891108            +2.3%    9097504        iozone.524288KB_16384reclen.freread
   3253278           -31.3%    2233951        iozone.524288KB_16384reclen.frewrite
   3260758           -31.4%    2235689        iozone.524288KB_16384reclen.fwrite
   4582189 ±  2%     -39.0%    2796855        iozone.524288KB_16384reclen.random_write
   8145760 ±  7%     -60.6%    3206030 ±  5%  iozone.524288KB_16384reclen.record_rewrite
   4429712 ±  8%     -37.0%    2789583        iozone.524288KB_16384reclen.rewrite
   3597211           -27.0%    2625306        iozone.524288KB_16384reclen.write
    368799           -15.6%     311238        iozone.524288KB_2048reclen
   3997367           -36.5%    2538893        iozone.524288KB_2048reclen.frewrite
   4068154           -37.4%    2544731        iozone.524288KB_2048reclen.fwrite
   4677321           -40.6%    2776934        iozone.524288KB_2048reclen.random_write
  10174427           -64.3%    3636299 ±  4%  iozone.524288KB_2048reclen.record_rewrite
   4650596           -39.7%    2806632        iozone.524288KB_2048reclen.rewrite
   3577468 ±  3%     -25.8%    2653574        iozone.524288KB_2048reclen.write
    468582           -21.9%     365920        iozone.524288KB_256reclen
   4437726           -39.7%    2676028        iozone.524288KB_256reclen.frewrite
   4466769           -39.9%    2683463        iozone.524288KB_256reclen.fwrite
   4591065           -43.2%    2609914        iozone.524288KB_256reclen.random_write
  21466620           -78.1%    4711261        iozone.524288KB_256reclen.record_rewrite
   4626343           -41.0%    2728213        iozone.524288KB_256reclen.rewrite
   3572555 ±  4%     -27.9%    2576439        iozone.524288KB_256reclen.write
    366252           -15.6%     309119        iozone.524288KB_4096reclen
   4036834           -38.6%    2478945 ±  6%  iozone.524288KB_4096reclen.frewrite
   4055015           -36.8%    2562132        iozone.524288KB_4096reclen.fwrite
   4664872           -40.2%    2787862        iozone.524288KB_4096reclen.random_write
  10097018           -63.2%    3713623        iozone.524288KB_4096reclen.record_rewrite
   4643582           -39.4%    2811741        iozone.524288KB_4096reclen.rewrite
   3650074           -27.4%    2648489        iozone.524288KB_4096reclen.write
    451582           -22.6%     349642        iozone.524288KB_512reclen
  10601422            -6.7%    9893058 ±  8%  iozone.524288KB_512reclen.fread
   4489995           -38.9%    2741205        iozone.524288KB_512reclen.frewrite
   4539022           -39.5%    2746598        iozone.524288KB_512reclen.fwrite
   4746791           -42.7%    2718154        iozone.524288KB_512reclen.random_write
  19508016 ±  3%     -76.7%    4554188        iozone.524288KB_512reclen.record_rewrite
   4780508           -42.2%    2760993        iozone.524288KB_512reclen.rewrite
   3837538           -29.5%    2706869        iozone.524288KB_512reclen.write
   3926273 ±  9%     -33.7%    2604343        iozone.524288KB_64reclen.frewrite
   3944643 ±  9%     -33.6%    2619572        iozone.524288KB_64reclen.fwrite
   3914786 ± 11%     -36.3%    2494515        iozone.524288KB_64reclen.random_write
  16885603           -72.5%    4643484        iozone.524288KB_64reclen.record_rewrite
   4162202 ± 10%     -35.4%    2690150        iozone.524288KB_64reclen.rewrite
   3441256 ±  3%     -25.9%    2550996        iozone.524288KB_64reclen.write
    362644           -14.0%     311767        iozone.524288KB_8192reclen
   3993424           -36.0%    2554829        iozone.524288KB_8192reclen.frewrite
   4032514           -36.5%    2558672        iozone.524288KB_8192reclen.fwrite
   4641322           -39.8%    2795171        iozone.524288KB_8192reclen.random_write
   9775740           -62.4%    3678266        iozone.524288KB_8192reclen.record_rewrite
   4608407           -39.1%    2805016        iozone.524288KB_8192reclen.rewrite
   3621619           -27.0%    2643713        iozone.524288KB_8192reclen.write
   4909141 ±  5%     -23.9%    3735825        iozone.64KB_16reclen.fwrite
   5620551 ±  3%     -40.9%    3320783 ± 18%  iozone.64KB_16reclen.random_write
   5198727 ± 11%     -30.8%    3598814 ±  3%  iozone.64KB_16reclen.rewrite
   6827564 ±  7%     -40.7%    4048292 ±  2%  iozone.64KB_32reclen.random_write
   6643251 ± 15%     -46.9%    3530003 ±  9%  iozone.64KB_32reclen.record_rewrite
   5518370 ± 19%     -36.8%    3489900 ±  7%  iozone.64KB_32reclen.rewrite
   4191790 ±  5%     -24.0%    3185742 ±  6%  iozone.64KB_32reclen.write
   7105671 ± 17%     -41.5%    4156912 ±  2%  iozone.64KB_64reclen.random_write
   7617330 ± 17%     -49.4%    3855326 ± 19%  iozone.64KB_64reclen.record_rewrite
   4074018 ±  3%     -15.0%    3463076 ±  6%  iozone.64KB_8reclen.frewrite
   4039136 ±  6%     -18.0%    3311987 ±  4%  iozone.64KB_8reclen.random_write
   4558024 ±  4%     -26.2%    3363548 ±  9%  iozone.64KB_8reclen.record_rewrite
    382562 ±  7%     -13.3%     331569 ±  4%  iozone.65536KB_1024reclen
   4092081 ±  7%     -35.4%    2642056 ±  6%  iozone.65536KB_1024reclen.frewrite
   4161159 ± 11%     -34.7%    2718285 ±  7%  iozone.65536KB_1024reclen.fwrite
   5187064 ± 11%     -40.7%    3077306 ±  3%  iozone.65536KB_1024reclen.random_write
  12553394           -68.9%    3903051 ±  4%  iozone.65536KB_1024reclen.record_rewrite
   4784045 ±  3%     -38.6%    2936477        iozone.65536KB_1024reclen.rewrite
   3705706 ±  3%     -24.7%    2791329 ±  6%  iozone.65536KB_1024reclen.write
    463891 ±  4%     -18.0%     380583 ±  6%  iozone.65536KB_128reclen
   4212074 ±  8%     -34.5%    2760210 ±  2%  iozone.65536KB_128reclen.frewrite
   4265070 ± 13%     -32.9%    2861610 ±  6%  iozone.65536KB_128reclen.fwrite
   5271912 ±  6%     -44.9%    2902920 ±  8%  iozone.65536KB_128reclen.random_write
  19766141           -76.3%    4693931        iozone.65536KB_128reclen.record_rewrite
   4619347 ±  3%     -38.9%    2823181 ±  2%  iozone.65536KB_128reclen.rewrite
   3765429 ±  7%     -27.0%    2749712 ±  7%  iozone.65536KB_128reclen.write
    337213 ±  2%     -13.0%     293416 ±  5%  iozone.65536KB_16384reclen
   3824995           -28.0%    2753337        iozone.65536KB_16384reclen.frewrite
   3953756 ±  3%     -28.9%    2812142 ±  3%  iozone.65536KB_16384reclen.fwrite
   5118255 ±  2%     -43.4%    2897251 ±  8%  iozone.65536KB_16384reclen.random_write
   6645142           -53.6%    3081247 ±  3%  iozone.65536KB_16384reclen.record_rewrite
   4512696           -39.6%    2725527 ±  6%  iozone.65536KB_16384reclen.rewrite
   3548865 ±  3%     -25.4%    2646406 ±  4%  iozone.65536KB_16384reclen.write
    375292 ±  3%     -13.1%     326259 ±  4%  iozone.65536KB_2048reclen
   4144567 ±  2%     -35.8%    2661965        iozone.65536KB_2048reclen.frewrite
   4185808 ±  5%     -35.9%    2681186 ±  7%  iozone.65536KB_2048reclen.fwrite
   5248186 ±  5%     -41.6%    3063178 ±  3%  iozone.65536KB_2048reclen.random_write
   9925598           -62.5%    3724685        iozone.65536KB_2048reclen.record_rewrite
   4748316 ±  2%     -39.1%    2892203        iozone.65536KB_2048reclen.rewrite
   3674009 ±  4%     -25.0%    2755327 ±  7%  iozone.65536KB_2048reclen.write
    483217 ±  2%     -18.9%     391679 ±  4%  iozone.65536KB_256reclen
   4518193 ±  2%     -36.9%    2851143        iozone.65536KB_256reclen.frewrite
   4668303 ±  4%     -36.9%    2947454 ±  5%  iozone.65536KB_256reclen.fwrite
   5517524 ±  5%     -46.5%    2953842 ±  7%  iozone.65536KB_256reclen.random_write
  20870509 ±  5%     -77.3%    4746923        iozone.65536KB_256reclen.record_rewrite
   4772900 ±  2%     -39.7%    2879284 ±  2%  iozone.65536KB_256reclen.rewrite
   3746271 ±  6%     -25.4%    2795894 ±  7%  iozone.65536KB_256reclen.write
    381798 ±  3%     -13.5%     330387 ±  4%  iozone.65536KB_4096reclen
   4155773 ±  2%     -34.4%    2727779        iozone.65536KB_4096reclen.frewrite
   4152130 ±  3%     -34.1%    2736605 ±  2%  iozone.65536KB_4096reclen.fwrite
   5257369 ±  3%     -42.5%    3020776 ±  2%  iozone.65536KB_4096reclen.random_write
   9565767           -61.4%    3691743        iozone.65536KB_4096reclen.record_rewrite
   4715969 ±  3%     -39.0%    2878412        iozone.65536KB_4096reclen.rewrite
   3642488 ±  2%     -24.1%    2765485 ±  4%  iozone.65536KB_4096reclen.write
    452106 ±  2%     -18.1%     370314 ±  5%  iozone.65536KB_512reclen
   4610457           -39.9%    2772499 ±  6%  iozone.65536KB_512reclen.frewrite
   4625412 ±  3%     -37.7%    2883201 ±  6%  iozone.65536KB_512reclen.fwrite
   5655207 ±  5%     -43.6%    3191984 ±  3%  iozone.65536KB_512reclen.random_write
  19138939 ±  5%     -76.5%    4497103 ±  3%  iozone.65536KB_512reclen.record_rewrite
   4937791 ±  2%     -39.8%    2970165 ±  2%  iozone.65536KB_512reclen.rewrite
   3985959 ±  4%     -27.8%    2875993 ±  6%  iozone.65536KB_512reclen.write
    449581 ±  2%     -20.3%     358227 ± 10%  iozone.65536KB_64reclen
   4166743 ±  2%     -38.6%    2558116 ±  9%  iozone.65536KB_64reclen.frewrite
   4360973 ±  7%     -37.1%    2742968 ±  8%  iozone.65536KB_64reclen.fwrite
   4920186 ±  5%     -42.6%    2824014 ±  9%  iozone.65536KB_64reclen.random_write
  16946883           -72.7%    4633978        iozone.65536KB_64reclen.record_rewrite
   4454967           -37.0%    2806195        iozone.65536KB_64reclen.rewrite
   3578643 ±  2%     -24.7%    2695662 ±  3%  iozone.65536KB_64reclen.write
    373375 ±  2%     -12.8%     325741 ±  3%  iozone.65536KB_8192reclen
   4263550 ±  2%     -33.6%    2832091        iozone.65536KB_8192reclen.frewrite
   4331726 ±  3%     -33.4%    2883302        iozone.65536KB_8192reclen.fwrite
   5153310 ±  2%     -41.8%    2999365        iozone.65536KB_8192reclen.random_write
   8922135           -59.9%    3581782        iozone.65536KB_8192reclen.record_rewrite
   4600090 ±  3%     -37.6%    2871404        iozone.65536KB_8192reclen.rewrite
   3590234 ±  2%     -23.7%    2738353 ±  3%  iozone.65536KB_8192reclen.write
    536485 ±  2%     -20.4%     427141        iozone.8192KB_1024reclen
   7467350 ±  3%     -45.5%    4070355        iozone.8192KB_1024reclen.frewrite
   7153373 ±  2%     -44.7%    3958141        iozone.8192KB_1024reclen.fwrite
   9991905 ±  2%     -57.1%    4283298        iozone.8192KB_1024reclen.random_write
  12582519 ±  2%     -67.8%    4048850        iozone.8192KB_1024reclen.record_rewrite
   9330452 ±  2%     -55.6%    4138265        iozone.8192KB_1024reclen.rewrite
   6052907 ±  6%     -41.7%    3526979 ± 12%  iozone.8192KB_1024reclen.write
    709418 ±  3%     -20.8%     561644        iozone.8192KB_128reclen
   9291417 ±  3%     -53.7%    4300748        iozone.8192KB_128reclen.frewrite
   9423660 ±  2%     -54.0%    4333995        iozone.8192KB_128reclen.fwrite
  10775295           -58.6%    4460428 ±  2%  iozone.8192KB_128reclen.random_write
  18856580 ±  9%     -75.0%    4705899        iozone.8192KB_128reclen.record_rewrite
  10171758 ±  2%     -56.5%    4429681 ±  2%  iozone.8192KB_128reclen.rewrite
   6544203 ±  4%     -38.4%    4034196 ±  8%  iozone.8192KB_128reclen.write
    527877 ±  2%      -9.9%     475453        iozone.8192KB_16reclen
   6016398           -34.7%    3930940        iozone.8192KB_16reclen.frewrite
   6091335 ±  2%     -34.5%    3990962        iozone.8192KB_16reclen.fwrite
   6243180           -39.1%    3800859        iozone.8192KB_16reclen.random_write
   8980079 ±  5%     -51.2%    4379826        iozone.8192KB_16reclen.record_rewrite
   6571065 ±  5%     -36.4%    4180600        iozone.8192KB_16reclen.rewrite
   5111432 ±  4%     -24.8%    3841395        iozone.8192KB_16reclen.write
    487748           -16.6%     406881        iozone.8192KB_2048reclen
   7586775 ±  2%     -43.0%    4327454        iozone.8192KB_2048reclen.frewrite
   6842510 ±  4%     -40.1%    4100707 ±  2%  iozone.8192KB_2048reclen.fwrite
   8333234 ±  4%     -51.3%    4055843        iozone.8192KB_2048reclen.random_write
   9758850           -60.8%    3821766        iozone.8192KB_2048reclen.record_rewrite
   8031198 ±  3%     -51.2%    3921374        iozone.8192KB_2048reclen.rewrite
    725722 ±  2%     -21.7%     568110 ±  2%  iozone.8192KB_256reclen
   9787389 ±  2%     -54.7%    4429563        iozone.8192KB_256reclen.frewrite
   9726488 ±  3%     -54.6%    4412030        iozone.8192KB_256reclen.fwrite
  11184217 ±  4%     -59.1%    4574148        iozone.8192KB_256reclen.random_write
  21438531 ±  2%     -77.9%    4727229        iozone.8192KB_256reclen.record_rewrite
  10374852 ±  6%     -57.8%    4382911 ±  3%  iozone.8192KB_256reclen.rewrite
   6546620 ±  5%     -39.9%    3937774 ±  6%  iozone.8192KB_256reclen.write
    613002 ±  2%     -15.8%     516296        iozone.8192KB_32reclen
   7478700 ±  2%     -45.0%    4110493        iozone.8192KB_32reclen.frewrite
   7610048 ±  2%     -45.5%    4147126        iozone.8192KB_32reclen.fwrite
   8189831           -49.0%    4177173        iozone.8192KB_32reclen.random_write
  12979020 ±  6%     -65.1%    4530879        iozone.8192KB_32reclen.record_rewrite
   8193938 ±  3%     -48.3%    4239423 ±  2%  iozone.8192KB_32reclen.rewrite
   5806015 ±  3%     -33.9%    3840535 ±  7%  iozone.8192KB_32reclen.write
    469100 ±  3%     -15.3%     397484 ±  3%  iozone.8192KB_4096reclen
   8233716 ± 10%     -33.1%    5509394 ±  6%  iozone.8192KB_4096reclen.frewrite
   4839933 ±  5%     -23.5%    3704468 ±  4%  iozone.8192KB_4096reclen.fwrite
  10918161            +2.0%   11133879        iozone.8192KB_4096reclen.random_read
   8408425           -52.2%    4017320        iozone.8192KB_4096reclen.random_write
   9028729           -57.6%    3825187        iozone.8192KB_4096reclen.record_rewrite
   7735077 ±  4%     -51.9%    3718859 ±  4%  iozone.8192KB_4096reclen.rewrite
   5142757 ±  3%     -40.5%    3060077 ± 22%  iozone.8192KB_4096reclen.write
    316433            +2.1%     323057        iozone.8192KB_4reclen
   3106713 ±  2%      +5.6%    3279671 ±  2%  iozone.8192KB_4reclen.frewrite
   3140283            +5.1%    3300432        iozone.8192KB_4reclen.fwrite
   2645331            +3.4%    2735643        iozone.8192KB_4reclen.random_write
   3446241            +2.8%    3544056        iozone.8192KB_4reclen.record_rewrite
   3142816 ±  2%      +6.8%    3357075 ±  2%  iozone.8192KB_4reclen.rewrite
   2571214            +4.3%    2681876        iozone.8192KB_4reclen.write
    690912 ±  3%     -21.4%     543137 ±  5%  iozone.8192KB_512reclen
   8823289 ±  4%     -51.7%    4263971        iozone.8192KB_512reclen.frewrite
   8721143 ±  3%     -51.6%    4219045        iozone.8192KB_512reclen.fwrite
  11332724 ±  4%     -61.4%    4377548 ± 10%  iozone.8192KB_512reclen.random_write
  18198176 ±  5%     -74.9%    4559471        iozone.8192KB_512reclen.record_rewrite
  10491585 ±  6%     -57.6%    4453572        iozone.8192KB_512reclen.rewrite
   6766302 ±  2%     -38.8%    4137791 ±  2%  iozone.8192KB_512reclen.write
    672479 ±  2%     -18.9%     545230 ±  2%  iozone.8192KB_64reclen
   8560533 ±  2%     -50.3%    4255326        iozone.8192KB_64reclen.frewrite
   8662238           -50.6%    4278340        iozone.8192KB_64reclen.fwrite
   9832794           -55.4%    4382798        iozone.8192KB_64reclen.random_write
  16983823           -72.6%    4650118        iozone.8192KB_64reclen.record_rewrite
   9202810 ±  5%     -52.7%    4349262 ±  3%  iozone.8192KB_64reclen.rewrite
   6018138 ±  7%     -34.1%    3963336 ±  8%  iozone.8192KB_64reclen.write
    448642 ±  5%     -16.5%     374574 ±  5%  iozone.8192KB_8192reclen
   7528275 ±  6%     -51.0%    3688304 ±  6%  iozone.8192KB_8192reclen.frewrite
   7286598 ±  8%     -48.7%    3735618 ±  5%  iozone.8192KB_8192reclen.fwrite
   8386142           -52.0%    4022082        iozone.8192KB_8192reclen.random_write
   7856538 ±  4%     -50.7%    3870160 ±  3%  iozone.8192KB_8192reclen.record_rewrite
   6713703 ±  9%     -47.1%    3552732 ±  4%  iozone.8192KB_8192reclen.rewrite
   4238426 ±  2%     -30.4%    2950520 ±  2%  iozone.8192KB_8192reclen.write
    440452            -5.1%     418148        iozone.8192KB_8reclen
   4661396           -20.8%    3690317        iozone.8192KB_8reclen.frewrite
   4723736           -21.0%    3730663        iozone.8192KB_8reclen.fwrite
   4398923           -24.1%    3337557        iozone.8192KB_8reclen.random_write
   6140932           -32.6%    4140905        iozone.8192KB_8reclen.record_rewrite
   4957147 ±  3%     -21.9%    3869391 ±  2%  iozone.8192KB_8reclen.rewrite
   5142761           -14.1%    4415674        iozone.average_KBps
  59629216 ±  2%     -40.1%   35705731        iozone.frewrite_KBps
  56166023 ±  2%     -39.0%   34244111        iozone.fwrite_KBps
  69289910           -48.8%   35490335        iozone.random_write_KBps
 1.167e+08           -65.7%   40053242        iozone.record_rewrite_KBps
  60997806 ±  2%     -43.8%   34252510        iozone.rewrite_KBps
      5.00           +20.0%       6.00        iozone.time.percent_of_cpu_this_job_got
     59.48 ±  2%     +25.9%      74.88        iozone.time.system_time
  43309617           -28.3%   31048210        iozone.write_KBps



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/filenum/fs/iomode/kconfig/nr_threads/period/rootfs/rwmode/size/tbox_group/testcase:
  gcc-12/performance/1SSD/1024f/btrfs/sync/x86_64-rhel-9.4/100%/600s/debian-12-x86_64-20240206.cgz/rndrw/64G/lkp-icl-2sp2/sysbench-fileio

commit: 
  b1c5f6eda2 ("btrfs: fix wrong sizeof in btrfs_do_encoded_write()")
  c87c299776 ("btrfs: make buffered write to copy one page a time")

b1c5f6eda2d024c1 c87c299776e4d75bcc5559203ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     17.80            -3.4%      17.20        iostat.cpu.system
     15.17 ±174%     -14.2        0.98 ± 81%  perf-profile.calltrace.cycles-pp.nohz_balance_exit_idle.nohz_balancer_kick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      8.74 ±146%      -7.7        1.04 ± 71%  perf-profile.children.cycles-pp.nohz_balance_exit_idle
    764625            -3.5%     737940        vmstat.io.bo
    444094            -4.1%     425787        vmstat.system.cs
    341789            -2.8%     332108        vmstat.system.in
      0.00 ±113%    +350.0%       0.01 ± 65%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.01 ±  8%   +5097.6%       0.36 ±210%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.00 ±113%    +818.8%       0.02 ± 94%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      2153 ± 44%     -51.5%       1043 ±  7%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±105%    +211.4%       0.02 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      8.14 ±  8%     +54.1%      12.54 ± 43%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±105%    +394.3%       0.03 ± 72%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      1819 ± 27%     -42.6%       1043 ±  7%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
  84392433            -2.9%   81976360        proc-vmstat.nr_dirtied
     93050            +1.5%      94482        proc-vmstat.nr_dirty
  84157122            -2.8%   81787366        proc-vmstat.nr_written
     94209            +1.4%      95555        proc-vmstat.nr_zone_write_pending
  62929776            -1.9%   61711230        proc-vmstat.numa_hit
  62786106            -1.9%   61579028        proc-vmstat.numa_local
  63688616            -2.0%   62436738        proc-vmstat.pgalloc_normal
  44616254            -3.2%   43186322        proc-vmstat.pgfree
 5.153e+08            -2.8%  5.008e+08        proc-vmstat.pgpgout
     79837            +2.6%      81891        proc-vmstat.pgreuse
    244087            -4.9%     232177        sysbench-fileio.fsync_operations/s
      0.40            +6.6%       0.43        sysbench-fileio.latency_avg_ms
  64937141            +1.6%   65990858        sysbench-fileio.latency_sum_ms
    234.12            -4.9%     222.68        sysbench-fileio.read_bytes_MB/s
    223.27            -4.9%     212.37        sysbench-fileio.read_bytes_MiB/s
     14289            -4.9%      13591        sysbench-fileio.read_operations/s
 6.272e+08            -2.6%   6.11e+08        sysbench-fileio.time.file_system_outputs
     79148 ±  3%      +8.1%      85527 ±  4%  sysbench-fileio.time.involuntary_context_switches
      2205            -3.7%       2123        sysbench-fileio.time.percent_of_cpu_this_job_got
     14518            -3.0%      14079        sysbench-fileio.time.system_time
    287.66            -5.5%     271.94        sysbench-fileio.time.user_time
 1.428e+08            -3.9%  1.373e+08        sysbench-fileio.time.voluntary_context_switches
    156.08            -4.9%     148.46        sysbench-fileio.write_bytes_MB/s
    148.85            -4.9%     141.58        sysbench-fileio.write_bytes_MiB/s
      9526            -4.9%       9060        sysbench-fileio.write_operations/s
 3.337e+09            -2.3%  3.261e+09        perf-stat.i.branch-instructions
    446729            -4.1%     428414        perf-stat.i.context-switches
      3.34            -1.3%       3.29        perf-stat.i.cpi
 6.509e+10            -3.3%  6.294e+10        perf-stat.i.cpu-cycles
      4618 ±  2%      +6.7%       4928        perf-stat.i.cpu-migrations
      1359            -3.0%       1318        perf-stat.i.cycles-between-cache-misses
 1.793e+10            -2.3%  1.752e+10        perf-stat.i.instructions
      3.48            -4.1%       3.33        perf-stat.i.metric.K/sec
     29.38           -14.8       14.56 ±100%  perf-stat.overall.cache-miss-rate%
      3.63           -50.8%       1.79 ±100%  perf-stat.overall.cpi
      1479           -51.7%     714.36 ±100%  perf-stat.overall.cycles-between-cache-misses
 3.324e+09           -51.3%   1.62e+09 ±100%  perf-stat.ps.branch-instructions
    444783           -52.2%     212822 ±100%  perf-stat.ps.context-switches
 6.482e+10           -52.0%  3.112e+10 ±100%  perf-stat.ps.cpu-cycles
 1.786e+10           -51.2%  8.708e+09 ±100%  perf-stat.ps.instructions
 1.201e+13           -50.9%  5.893e+12 ±100%  perf-stat.total.instructions



***************************************************************************************************
lkp-kbl-d01: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/iosched/kconfig/rootfs/tbox_group/testcase:
  gcc-12/performance/2HDD/btrfs/kyber/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-kbl-d01/iozone

commit: 
  b1c5f6eda2 ("btrfs: fix wrong sizeof in btrfs_do_encoded_write()")
  c87c299776 ("btrfs: make buffered write to copy one page a time")

b1c5f6eda2d024c1 c87c299776e4d75bcc5559203ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.05 ±  3%      +0.3        1.35        mpstat.cpu.all.sys%
      0.39 ± 10%     +17.3%       0.46 ± 11%  sched_debug.cfs_rq:/.h_nr_running.avg
     23.55            -1.2%      23.26        iostat.cpu.iowait
      1.23 ±  3%     +23.8%       1.52        iostat.cpu.system
      0.03 ±  5%     +16.8%       0.04 ± 12%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 32%     -88.8%       0.00 ±173%  perf-sched.sch_delay.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
      0.04 ± 24%     -84.4%       0.01 ±191%  perf-sched.sch_delay.max.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     24.46 ± 45%     -71.5%       6.97 ±144%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.sync_inodes_sb
     12.63 ± 83%     -99.7%       0.04 ±217%  perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     18.59 ± 72%     -99.7%       0.05 ±218%  perf-sched.wait_time.max.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     40.90           -26.7%      30.00        perf-stat.i.MPKI
  94960381           +25.6%  1.193e+08        perf-stat.i.branch-instructions
      1.67            -0.2        1.47        perf-stat.i.branch-miss-rate%
      1.49 ±  2%     -11.9%       1.31        perf-stat.i.cpi
 6.076e+08 ±  2%     +14.4%  6.953e+08        perf-stat.i.cpu-cycles
 4.902e+08           +28.1%   6.28e+08        perf-stat.i.instructions
      0.73 ±  2%     +11.0%       0.81        perf-stat.i.ipc
      0.06 ± 11%     -22.9%       0.05 ± 14%  perf-stat.i.metric.K/sec
     35.24 ± 44%     +38.6%      48.83        perf-stat.overall.cycles-between-cache-misses
      0.67 ± 44%     +33.8%       0.90        perf-stat.overall.ipc
  78962447 ± 44%     +50.8%  1.191e+08        perf-stat.ps.branch-instructions
 5.036e+08 ± 44%     +37.9%  6.945e+08        perf-stat.ps.cpu-cycles
 4.076e+08 ± 44%     +53.9%  6.272e+08        perf-stat.ps.instructions
 2.992e+11 ± 44%     +56.0%  4.667e+11        perf-stat.total.instructions
      0.28 ±100%      +0.6        0.86 ± 31%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.00            +0.7        0.69 ± 13%  perf-profile.calltrace.cycles-pp.__set_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter
      0.00            +0.7        0.72 ± 13%  perf-profile.calltrace.cycles-pp.__lock_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +0.7        0.72 ± 11%  perf-profile.calltrace.cycles-pp.filemap_dirty_folio.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +0.8        0.83 ± 15%  perf-profile.calltrace.cycles-pp.__set_extent_bit.set_extent_bit.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter
      0.36 ±100%      +0.8        1.19 ± 21%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.00            +0.8        0.84 ± 14%  perf-profile.calltrace.cycles-pp.set_extent_bit.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.00            +1.1        1.10 ± 20%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.prepare_one_page.btrfs_buffered_write.btrfs_do_write_iter
      0.00            +1.1        1.12 ± 21%  perf-profile.calltrace.cycles-pp.pagecache_get_page.prepare_one_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      0.00            +1.2        1.25 ± 19%  perf-profile.calltrace.cycles-pp.prepare_one_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      9.26 ± 16%      +2.6       11.81 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      9.01 ± 16%      +2.6       11.59 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.84 ± 15%      +2.6       11.45 ±  9%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.92 ± 16%      +2.6       11.55 ±  9%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.60 ± 16%      +2.7       11.26 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.7        2.66 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_dirty_page.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      8.50 ± 15%      +2.7       11.19 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
     25.33 ± 45%      +7.9       33.20 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.18 ±  7%      -1.0        7.13 ±  8%  perf-profile.children.cycles-pp.do_writepages
      7.96 ±  7%      -0.9        7.02 ±  8%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      7.96 ±  7%      -0.9        7.02 ±  8%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      0.80 ± 11%      -0.2        0.58 ± 12%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.54 ± 13%      -0.2        0.35 ± 27%  perf-profile.children.cycles-pp.find_lock_delalloc_range
      0.52 ± 16%      -0.1        0.38 ± 16%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.72 ± 12%      -0.1        0.60 ± 15%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.19 ± 24%      -0.1        0.11 ± 45%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.14 ± 33%      -0.1        0.08 ± 31%  perf-profile.children.cycles-pp.xas_set_mark
      0.02 ±141%      +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.do_dentry_open
      0.02 ±141%      +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.vfs_open
      0.02 ±143%      +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.11 ± 67%      +0.1        0.25 ± 13%  perf-profile.children.cycles-pp.slab_show
      0.05 ±107%      +0.1        0.18 ± 46%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.08 ± 57%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.seq_printf
      0.10 ± 76%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.vsnprintf
      0.10 ± 57%      +0.2        0.25 ± 14%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.30 ± 18%      +0.2        0.46 ± 26%  perf-profile.children.cycles-pp.kmem_cache_free
      0.13 ± 53%      +0.2        0.30 ± 20%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.11 ± 32%      +0.2        0.30 ± 34%  perf-profile.children.cycles-pp.free_extent_state
      0.00            +0.2        0.19 ± 41%  perf-profile.children.cycles-pp.btrfs_drop_page
      0.12 ± 54%      +0.2        0.31 ± 31%  perf-profile.children.cycles-pp.btrfs_delalloc_release_extents
      0.16 ± 57%      +0.2        0.37 ± 35%  perf-profile.children.cycles-pp.set_state_bits
      0.09 ± 72%      +0.2        0.32 ± 30%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.19 ± 52%      +0.3        0.45 ± 40%  perf-profile.children.cycles-pp.__reserve_bytes
      0.08 ± 95%      +0.3        0.34 ± 28%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.40 ± 25%      +0.4        0.77 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.37 ± 55%      +0.4        0.73 ± 24%  perf-profile.children.cycles-pp.clear_state_bit
      0.36 ± 37%      +0.4        0.78 ± 12%  perf-profile.children.cycles-pp.alloc_extent_state
      0.27 ± 51%      +0.5        0.72 ± 14%  perf-profile.children.cycles-pp.__lock_extent
      0.40 ± 50%      +0.5        0.88 ± 30%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.38 ± 49%      +0.5        0.87 ± 16%  perf-profile.children.cycles-pp.set_extent_bit
      0.35 ± 46%      +0.6        0.92 ±  9%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      1.17 ± 20%      +0.6        1.79 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
      0.64 ± 46%      +0.9        1.54 ± 11%  perf-profile.children.cycles-pp.__set_extent_bit
      1.05 ± 42%      +0.9        1.96 ± 19%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.00            +1.2        1.25 ± 19%  perf-profile.children.cycles-pp.prepare_one_page
      8.87 ± 15%      +2.6       11.47 ±  9%  perf-profile.children.cycles-pp.vfs_write
      8.96 ± 15%      +2.6       11.57 ±  9%  perf-profile.children.cycles-pp.ksys_write
      8.60 ± 16%      +2.7       11.27 ±  9%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      0.00            +2.7        2.70 ± 16%  perf-profile.children.cycles-pp.btrfs_dirty_page
      8.52 ± 15%      +2.7       11.23 ±  9%  perf-profile.children.cycles-pp.btrfs_buffered_write
     25.45 ± 45%      +7.8       33.20 ±  6%  perf-profile.children.cycles-pp.intel_idle_ibrs
      0.13 ± 36%      -0.1        0.08 ± 31%  perf-profile.self.cycles-pp.xas_set_mark
      0.13 ± 56%      +0.2        0.28 ±  8%  perf-profile.self.cycles-pp.btrfs_delalloc_reserve_metadata
      0.10 ± 30%      +0.2        0.28 ± 32%  perf-profile.self.cycles-pp.free_extent_state
      0.28 ± 40%      +0.3        0.60 ± 13%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      1.01 ± 22%      +0.5        1.49 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock
     25.42 ± 45%      +7.8       33.20 ±  6%  perf-profile.self.cycles-pp.intel_idle_ibrs
    404026 ±  8%     -20.1%     322736 ±  5%  iozone.1024KB_1024reclen
   5779343 ±  8%     -46.0%    3120020 ±  4%  iozone.1024KB_1024reclen.frewrite
   5520470 ±  8%     -47.4%    2902678 ±  8%  iozone.1024KB_1024reclen.fwrite
   7595960 ± 23%     -60.3%    3018802 ±  5%  iozone.1024KB_1024reclen.random_write
   7268453 ± 15%     -56.1%    3187394 ± 10%  iozone.1024KB_1024reclen.record_rewrite
   6148488 ± 12%     -49.5%    3107881 ±  8%  iozone.1024KB_1024reclen.rewrite
   3887031 ± 10%     -28.6%    2775959        iozone.1024KB_1024reclen.write
    480379 ±  3%     -18.1%     393482 ±  5%  iozone.1024KB_128reclen
   6443434 ±  3%     -47.5%    3385255 ±  3%  iozone.1024KB_128reclen.frewrite
   6286942 ±  6%     -47.0%    3329021 ±  4%  iozone.1024KB_128reclen.fwrite
   8220107 ± 11%     -56.1%    3607230 ±  3%  iozone.1024KB_128reclen.random_write
  10884743 ± 16%     -70.5%    3214497 ± 15%  iozone.1024KB_128reclen.record_rewrite
   6539228 ±  4%     -52.4%    3113754 ± 12%  iozone.1024KB_128reclen.rewrite
   4379578 ±  8%     -40.0%    2626472 ± 12%  iozone.1024KB_128reclen.write
    299421 ±  5%     -10.7%     267395        iozone.1024KB_16reclen
   3996999 ± 11%     -30.0%    2798786 ±  2%  iozone.1024KB_16reclen.frewrite
   4292405 ±  9%     -32.3%    2905607 ±  3%  iozone.1024KB_16reclen.fwrite
   4301482 ±  7%     -36.8%    2717189 ±  3%  iozone.1024KB_16reclen.random_write
   5666753 ± 11%     -51.8%    2729481 ± 16%  iozone.1024KB_16reclen.record_rewrite
   4481831 ±  7%     -33.0%    3004970 ±  6%  iozone.1024KB_16reclen.rewrite
   3477849 ± 12%     -23.6%    2655911 ±  3%  iozone.1024KB_16reclen.write
    476237 ±  3%     -22.0%     371524 ±  9%  iozone.1024KB_256reclen
   6810247 ±  8%     -45.2%    3731155 ±  7%  iozone.1024KB_256reclen.frewrite
   6581797 ±  7%     -46.4%    3528219 ±  4%  iozone.1024KB_256reclen.fwrite
   8923106 ±  7%     -63.8%    3225985 ± 14%  iozone.1024KB_256reclen.random_write
  11411063 ±  8%     -74.4%    2920507 ± 23%  iozone.1024KB_256reclen.record_rewrite
   6677329 ±  9%     -53.1%    3133697 ±  6%  iozone.1024KB_256reclen.rewrite
   4742314 ±  5%     -43.8%    2665096 ± 11%  iozone.1024KB_256reclen.write
    387624 ±  8%     -18.9%     314517 ±  3%  iozone.1024KB_32reclen
   5275639 ± 10%     -44.6%    2921319 ±  4%  iozone.1024KB_32reclen.frewrite
   5133958 ± 13%     -41.8%    2990409 ±  6%  iozone.1024KB_32reclen.fwrite
   6099796 ±  6%     -47.9%    3180923 ±  4%  iozone.1024KB_32reclen.random_write
   8251223 ± 15%     -60.1%    3293523 ±  2%  iozone.1024KB_32reclen.record_rewrite
   5514773           -45.3%    3018489 ±  4%  iozone.1024KB_32reclen.rewrite
   4085563 ±  7%     -33.1%    2733760 ±  7%  iozone.1024KB_32reclen.write
   8121273 ± 11%     -39.7%    4894208 ±  4%  iozone.1024KB_512reclen.frewrite
   4559484 ± 10%     -25.2%    3410930 ±  4%  iozone.1024KB_512reclen.fwrite
   8155517 ± 14%     -60.2%    3243802 ±  8%  iozone.1024KB_512reclen.random_write
   8781751 ± 20%     -63.3%    3224865 ±  3%  iozone.1024KB_512reclen.record_rewrite
   6229116 ± 16%     -48.6%    3198827 ±  5%  iozone.1024KB_512reclen.rewrite
   4347573 ±  8%     -32.7%    2923786 ±  5%  iozone.1024KB_512reclen.write
    472615 ±  5%     -19.0%     383049 ±  5%  iozone.1024KB_64reclen
   5744325 ±  8%     -45.3%    3140431 ± 10%  iozone.1024KB_64reclen.frewrite
   5722211 ±  8%     -44.4%    3180853 ±  7%  iozone.1024KB_64reclen.fwrite
   7092470 ±  6%     -53.5%    3296493 ±  4%  iozone.1024KB_64reclen.random_write
  10932587 ± 12%     -68.8%    3411418 ±  3%  iozone.1024KB_64reclen.record_rewrite
   6410689 ± 13%     -48.4%    3308809 ±  3%  iozone.1024KB_64reclen.rewrite
   4686039 ± 10%     -36.7%    2964454 ±  5%  iozone.1024KB_64reclen.write
   3176666 ± 13%     -26.0%    2350845 ± 13%  iozone.1024KB_8reclen.frewrite
   3260613 ± 10%     -25.4%    2430999 ±  5%  iozone.1024KB_8reclen.fwrite
   3027211 ± 16%     -25.8%    2245006 ±  5%  iozone.1024KB_8reclen.random_write
   3467121 ± 14%     -31.9%    2361237 ±  7%  iozone.1024KB_8reclen.record_rewrite
   3238895 ± 13%     -19.5%    2608521 ±  4%  iozone.1024KB_8reclen.rewrite
   2967947 ±  6%     -20.2%    2367737 ±  7%  iozone.1024KB_8reclen.write
   5972578 ± 17%     -48.0%    3106248 ± 11%  iozone.128KB_128reclen.frewrite
   6234234 ± 16%     -48.4%    3214381 ±  6%  iozone.128KB_128reclen.fwrite
   6367969 ± 18%     -47.4%    3350240 ±  3%  iozone.128KB_128reclen.random_write
   6485048 ± 16%     -49.1%    3302444 ±  2%  iozone.128KB_128reclen.record_rewrite
   5871537 ± 16%     -50.3%    2917168 ± 23%  iozone.128KB_128reclen.rewrite
   4188255 ± 10%     -32.4%    2829753 ±  7%  iozone.128KB_128reclen.write
   4246115 ±  6%     -31.6%    2904229 ± 15%  iozone.128KB_16reclen.frewrite
   4294051 ±  8%     -31.6%    2938769 ± 17%  iozone.128KB_16reclen.fwrite
   3953683 ±  5%     -34.3%    2598443 ± 16%  iozone.128KB_16reclen.random_write
   4874725 ±  4%     -44.8%    2688912 ± 15%  iozone.128KB_16reclen.record_rewrite
   4427850 ±  8%     -35.7%    2845297 ± 13%  iozone.128KB_16reclen.rewrite
   3447668 ±  9%     -25.9%    2555642 ± 15%  iozone.128KB_16reclen.write
   5363997 ± 10%     -36.1%    3428810 ± 15%  iozone.128KB_32reclen.frewrite
   5213895 ± 14%     -31.9%    3551187 ± 15%  iozone.128KB_32reclen.fwrite
   5070545 ± 10%     -42.8%    2900559 ± 13%  iozone.128KB_32reclen.random_write
   6108263 ± 11%     -52.0%    2931575 ± 13%  iozone.128KB_32reclen.record_rewrite
   4891011 ±  7%     -43.1%    2783075 ± 15%  iozone.128KB_32reclen.rewrite
   3720260 ± 10%     -28.1%    2673930 ± 15%  iozone.128KB_32reclen.write
   8113389 ± 21%     -42.7%    4652126 ± 22%  iozone.128KB_64reclen.frewrite
   5894858 ± 16%     -44.2%    3287762        iozone.128KB_64reclen.random_write
   6703523 ± 16%     -51.2%    3272488 ±  2%  iozone.128KB_64reclen.record_rewrite
   3325282 ±  8%     -24.9%    2498270 ± 15%  iozone.128KB_8reclen.fwrite
   2858073 ± 11%     -25.9%    2118973 ± 16%  iozone.128KB_8reclen.random_write
   3332162 ± 11%     -29.8%    2337539 ± 15%  iozone.128KB_8reclen.record_rewrite
   2790298 ±  7%     -18.1%    2285025 ± 15%  iozone.128KB_8reclen.write
    556595 ±  2%     -24.9%     418035        iozone.131072KB_1024reclen
   7283879 ± 10%     -53.7%    3375992 ±  3%  iozone.131072KB_1024reclen.frewrite
   7603171 ±  7%     -54.8%    3440316 ±  2%  iozone.131072KB_1024reclen.fwrite
   9011412 ±  5%     -59.8%    3619676        iozone.131072KB_1024reclen.random_write
  16871237 ±  3%     -77.8%    3751658        iozone.131072KB_1024reclen.record_rewrite
   8768236 ±  5%     -57.7%    3705171        iozone.131072KB_1024reclen.rewrite
   5576785 ±  6%     -39.2%    3390303        iozone.131072KB_1024reclen.write
    540004 ±  3%     -24.5%     407855 ±  3%  iozone.131072KB_128reclen
   7567260 ±  4%     -53.8%    3497294        iozone.131072KB_128reclen.frewrite
   7543641 ±  4%     -53.8%    3483685        iozone.131072KB_128reclen.fwrite
   8214156 ±  5%     -57.6%    3483198 ±  3%  iozone.131072KB_128reclen.random_write
  15791699 ±  6%     -76.3%    3749820        iozone.131072KB_128reclen.record_rewrite
   8530694 ±  3%     -56.1%    3741683        iozone.131072KB_128reclen.rewrite
   5440759 ±  6%     -37.8%    3384168        iozone.131072KB_128reclen.write
    355415 ±  6%     -14.9%     302352 ±  5%  iozone.131072KB_16384reclen
   5293019 ±  4%     -40.1%    3170551 ±  2%  iozone.131072KB_16384reclen.frewrite
   5102705 ±  8%     -38.2%    3154449        iozone.131072KB_16384reclen.fwrite
   6085033 ±  9%     -48.0%    3161684 ±  2%  iozone.131072KB_16384reclen.random_write
   6714005 ±  7%     -56.4%    2924415 ±  2%  iozone.131072KB_16384reclen.record_rewrite
   5912564 ±  4%     -45.4%    3229169        iozone.131072KB_16384reclen.rewrite
   4361256 ±  4%     -31.3%    2995716        iozone.131072KB_16384reclen.write
    524466 ±  4%     -20.9%     414665 ±  2%  iozone.131072KB_2048reclen
   5642668 ± 13%     -46.8%    3004614 ±  4%  iozone.131072KB_2048reclen.frewrite
   6069745 ± 13%     -49.3%    3075768 ±  2%  iozone.131072KB_2048reclen.fwrite
   7818775 ± 10%     -55.6%    3472227 ±  3%  iozone.131072KB_2048reclen.random_write
  16255595 ±  6%     -77.6%    3647697        iozone.131072KB_2048reclen.record_rewrite
   7549840 ± 13%     -53.6%    3503649 ±  3%  iozone.131072KB_2048reclen.rewrite
   5063081 ± 16%     -34.3%    3325803 ±  2%  iozone.131072KB_2048reclen.write
    543287 ±  2%     -23.5%     415738        iozone.131072KB_256reclen
   7525988 ±  4%     -53.7%    3486107        iozone.131072KB_256reclen.frewrite
   7551370 ±  4%     -54.9%    3405302 ±  4%  iozone.131072KB_256reclen.fwrite
   8775926 ±  4%     -58.7%    3622848        iozone.131072KB_256reclen.random_write
  16089046 ±  4%     -76.7%    3741974        iozone.131072KB_256reclen.record_rewrite
   8961286 ±  5%     -58.1%    3753775        iozone.131072KB_256reclen.rewrite
   5329259 ±  3%     -36.2%    3398000        iozone.131072KB_256reclen.write
    467257 ±  6%     -20.9%     369445 ±  5%  iozone.131072KB_4096reclen
   5344053 ± 10%     -45.8%    2894013 ±  3%  iozone.131072KB_4096reclen.frewrite
   5178859 ± 11%     -44.2%    2888296        iozone.131072KB_4096reclen.fwrite
   7091453 ±  8%     -53.9%    3267343        iozone.131072KB_4096reclen.random_write
   9958856 ± 23%     -69.0%    3089468 ±  8%  iozone.131072KB_4096reclen.record_rewrite
   6790908 ±  9%     -52.0%    3257618 ±  3%  iozone.131072KB_4096reclen.rewrite
   4657075 ±  6%     -33.3%    3104395 ±  2%  iozone.131072KB_4096reclen.write
    550746 ±  2%     -24.2%     417706 ±  2%  iozone.131072KB_512reclen
   7643592 ±  4%     -54.3%    3492423        iozone.131072KB_512reclen.frewrite
   7622635 ±  4%     -54.9%    3434029 ±  3%  iozone.131072KB_512reclen.fwrite
   9038913 ±  4%     -59.4%    3665678        iozone.131072KB_512reclen.random_write
  16159032 ±  3%     -77.0%    3721799        iozone.131072KB_512reclen.record_rewrite
   9021758 ±  4%     -58.6%    3732833        iozone.131072KB_512reclen.rewrite
   5550664 ±  6%     -39.9%    3337160 ±  4%  iozone.131072KB_512reclen.write
    495904 ±  4%     -21.7%     388115 ±  2%  iozone.131072KB_64reclen
   6944981 ±  4%     -50.3%    3452635        iozone.131072KB_64reclen.frewrite
   6941633 ±  5%     -50.4%    3443365        iozone.131072KB_64reclen.fwrite
   7083196 ±  6%     -53.3%    3311192        iozone.131072KB_64reclen.random_write
  13356791 ±  8%     -72.4%    3689259        iozone.131072KB_64reclen.record_rewrite
   7656280 ±  5%     -52.0%    3675163        iozone.131072KB_64reclen.rewrite
   4889990 ± 14%     -31.2%    3364128        iozone.131072KB_64reclen.write
    375509 ±  5%     -18.4%     306526 ±  5%  iozone.131072KB_8192reclen
   5144601 ±  8%     -42.1%    2979704        iozone.131072KB_8192reclen.frewrite
   4994124 ±  9%     -40.5%    2973687        iozone.131072KB_8192reclen.fwrite
   5966882 ±  7%     -47.6%    3128779 ±  3%  iozone.131072KB_8192reclen.random_write
   6897733 ± 12%     -55.5%    3068179        iozone.131072KB_8192reclen.record_rewrite
   6166392 ±  7%     -48.4%    3179624 ±  3%  iozone.131072KB_8192reclen.rewrite
   4547664 ±  4%     -34.3%    2985575        iozone.131072KB_8192reclen.write
    502575 ±  3%     -26.1%     371228 ±  9%  iozone.16384KB_1024reclen
  10293176 ±  6%      -9.5%    9320083 ±  6%  iozone.16384KB_1024reclen.bkwd_read
   6646368 ±  3%     -49.2%    3376676 ±  6%  iozone.16384KB_1024reclen.frewrite
   6339526 ±  6%     -47.3%    3339024 ±  6%  iozone.16384KB_1024reclen.fwrite
   8911501 ±  7%     -61.4%    3442980 ± 14%  iozone.16384KB_1024reclen.random_write
  16155159 ±  3%     -78.0%    3546393 ±  7%  iozone.16384KB_1024reclen.record_rewrite
   7372124 ±  8%     -54.3%    3369335 ±  9%  iozone.16384KB_1024reclen.rewrite
   5245926 ±  6%     -42.3%    3029117 ± 14%  iozone.16384KB_1024reclen.write
    500856 ±  2%     -25.0%     375560 ±  2%  iozone.16384KB_128reclen
   6866695 ±  6%     -51.8%    3308318 ±  5%  iozone.16384KB_128reclen.frewrite
   7195384 ±  2%     -55.9%    3173530 ± 12%  iozone.16384KB_128reclen.fwrite
   8774656 ±  4%     -58.5%    3640393        iozone.16384KB_128reclen.random_write
  15591161 ±  6%     -75.9%    3754231        iozone.16384KB_128reclen.record_rewrite
   7949451           -55.1%    3568843 ±  5%  iozone.16384KB_128reclen.rewrite
   5252802 ±  6%     -37.5%    3281669 ±  6%  iozone.16384KB_128reclen.write
    396193           -24.2%     300141 ±  8%  iozone.16384KB_16384reclen
   6388871 ±  4%     -50.1%    3189918        iozone.16384KB_16384reclen.frewrite
   6534523 ±  4%     -51.8%    3151340 ±  5%  iozone.16384KB_16384reclen.fwrite
   6456084 ±  5%     -52.7%    3053804 ± 11%  iozone.16384KB_16384reclen.random_write
   6672258           -54.2%    3057919 ± 10%  iozone.16384KB_16384reclen.record_rewrite
   6171950 ±  5%     -49.0%    3148548 ±  3%  iozone.16384KB_16384reclen.rewrite
   4441138 ±  5%     -37.0%    2797259 ± 11%  iozone.16384KB_16384reclen.write
   4823195 ±  4%     -37.8%    2998684 ±  3%  iozone.16384KB_16reclen.frewrite
   4601430 ±  7%     -32.9%    3087716        iozone.16384KB_16reclen.fwrite
   4180916 ±  8%     -33.1%    2798844 ±  2%  iozone.16384KB_16reclen.random_write
   5667637 ±  5%     -44.9%    3122971 ±  2%  iozone.16384KB_16reclen.record_rewrite
   4955347 ±  5%     -35.1%    3214593 ±  2%  iozone.16384KB_16reclen.rewrite
    473227 ±  7%     -21.4%     371728 ±  6%  iozone.16384KB_2048reclen
   5739847 ± 15%     -43.7%    3233427 ±  7%  iozone.16384KB_2048reclen.frewrite
   6333846 ±  3%     -47.4%    3333479 ±  2%  iozone.16384KB_2048reclen.fwrite
   8062496 ± 11%     -58.0%    3389775 ±  9%  iozone.16384KB_2048reclen.random_write
  14684802 ±  9%     -74.8%    3698168        iozone.16384KB_2048reclen.record_rewrite
   6685406 ± 10%     -48.8%    3425186 ±  3%  iozone.16384KB_2048reclen.rewrite
   4783654 ± 10%     -36.9%    3017283 ±  9%  iozone.16384KB_2048reclen.write
    501522 ±  2%     -24.6%     378391 ±  2%  iozone.16384KB_256reclen
   6882929 ±  3%     -50.8%    3387288 ±  4%  iozone.16384KB_256reclen.frewrite
   7052407 ±  6%     -53.1%    3310175 ±  7%  iozone.16384KB_256reclen.fwrite
   9032840 ±  4%     -59.6%    3650079 ±  5%  iozone.16384KB_256reclen.random_write
  16000820 ±  4%     -77.4%    3615234 ±  7%  iozone.16384KB_256reclen.record_rewrite
   8093572 ±  3%     -55.8%    3577186 ±  4%  iozone.16384KB_256reclen.rewrite
   5364208 ±  6%     -38.6%    3294480 ±  3%  iozone.16384KB_256reclen.write
    399141 ±  5%     -18.6%     325048 ±  3%  iozone.16384KB_32reclen
  10066483 ±  3%      -8.9%    9165856 ±  7%  iozone.16384KB_32reclen.fread
  10168580 ±  3%      -8.3%    9327535 ±  4%  iozone.16384KB_32reclen.freread
   5723442 ±  8%     -46.5%    3061356 ± 12%  iozone.16384KB_32reclen.frewrite
   5547324 ± 11%     -43.2%    3148213 ±  6%  iozone.16384KB_32reclen.fwrite
   5623221 ± 11%     -43.8%    3158882 ±  5%  iozone.16384KB_32reclen.random_write
   8720163 ±  7%     -62.1%    3303932 ±  9%  iozone.16384KB_32reclen.record_rewrite
   6067131 ± 10%     -44.4%    3370477 ±  5%  iozone.16384KB_32reclen.rewrite
   4440172 ±  9%     -31.0%    3063071 ±  7%  iozone.16384KB_32reclen.write
    421223 ±  5%     -13.4%     364901 ±  2%  iozone.16384KB_4096reclen
   6166229 ±  8%     -39.7%    3715837 ±  2%  iozone.16384KB_4096reclen.frewrite
   6007088 ±  9%     -39.0%    3665450 ±  3%  iozone.16384KB_4096reclen.fwrite
   7077043 ± 13%     -50.6%    3493249 ±  3%  iozone.16384KB_4096reclen.random_write
   9964873 ± 11%     -65.1%    3482055 ±  3%  iozone.16384KB_4096reclen.record_rewrite
   6184702 ±  5%     -47.1%    3269031        iozone.16384KB_4096reclen.rewrite
   4538005 ±  8%     -33.3%    3027051 ±  2%  iozone.16384KB_4096reclen.write
   2049020 ±  8%      +8.4%    2220129 ±  2%  iozone.16384KB_4reclen.frewrite
   1789750 ±  6%      +8.0%    1933158        iozone.16384KB_4reclen.record_rewrite
    494259 ±  3%     -22.7%     381984 ±  5%  iozone.16384KB_512reclen
   6748999 ±  5%     -50.7%    3328128 ±  6%  iozone.16384KB_512reclen.frewrite
   6687674 ±  4%     -52.1%    3203532 ± 13%  iozone.16384KB_512reclen.fwrite
   8480038 ± 15%     -57.1%    3635705 ±  6%  iozone.16384KB_512reclen.random_write
  15766929 ±  5%     -77.0%    3631363 ±  6%  iozone.16384KB_512reclen.record_rewrite
   7773133 ±  2%     -54.9%    3502963 ±  6%  iozone.16384KB_512reclen.rewrite
   5301780 ±  3%     -38.8%    3242233 ±  6%  iozone.16384KB_512reclen.write
    465431           -24.3%     352331 ±  6%  iozone.16384KB_64reclen
   6370739 ±  8%     -47.4%    3350737 ±  2%  iozone.16384KB_64reclen.frewrite
   6523478 ±  3%     -49.8%    3271535 ±  6%  iozone.16384KB_64reclen.fwrite
   7573757 ±  4%     -56.8%    3270565 ± 13%  iozone.16384KB_64reclen.random_write
  12463547 ±  4%     -70.8%    3642499        iozone.16384KB_64reclen.record_rewrite
   7391311 ±  2%     -54.1%    3391977 ±  7%  iozone.16384KB_64reclen.rewrite
   5008942 ±  7%     -41.0%    2954378 ± 17%  iozone.16384KB_64reclen.write
    391993           -15.1%     332951 ±  2%  iozone.16384KB_8192reclen
   8341214 ±  5%     -39.4%    5058416 ±  5%  iozone.16384KB_8192reclen.frewrite
   5672835 ±  7%     -29.8%    3983885 ±  7%  iozone.16384KB_8192reclen.fwrite
   6224158 ±  6%     -46.2%    3346580        iozone.16384KB_8192reclen.random_write
   6748212 ±  5%     -52.9%    3175726 ±  2%  iozone.16384KB_8192reclen.record_rewrite
   6137617 ±  5%     -48.1%    3185708 ±  2%  iozone.16384KB_8192reclen.rewrite
   4332394 ±  9%     -34.2%    2848563 ± 11%  iozone.16384KB_8192reclen.write
    236378            -8.3%     216744 ±  7%  iozone.16384KB_8reclen
   3537772 ±  7%     -22.8%    2730676        iozone.16384KB_8reclen.frewrite
   3389032 ± 11%     -19.7%    2721082        iozone.16384KB_8reclen.fwrite
   3686254 ± 13%     -28.7%    2626627 ±  2%  iozone.16384KB_8reclen.record_rewrite
   3748926 ±  8%     -23.0%    2886966        iozone.16384KB_8reclen.rewrite
   6836731 ±  9%     -28.6%    4884626 ± 15%  iozone.2048KB_1024reclen.frewrite
   8202740 ±  8%     -55.6%    3644862 ±  2%  iozone.2048KB_1024reclen.random_write
   6719919 ± 20%     -50.6%    3319142 ±  8%  iozone.2048KB_1024reclen.record_rewrite
   5154945 ± 17%     -43.7%    2900878 ±  4%  iozone.2048KB_1024reclen.rewrite
   6855424 ± 11%     -53.8%    3170377 ±  4%  iozone.2048KB_128reclen.frewrite
   6667708 ±  6%     -49.1%    3395053 ±  5%  iozone.2048KB_128reclen.fwrite
   8305700 ± 16%     -56.9%    3577221 ±  5%  iozone.2048KB_128reclen.random_write
  13050534 ± 13%     -73.4%    3466133 ±  5%  iozone.2048KB_128reclen.record_rewrite
   7308813 ± 14%     -55.0%    3290657 ±  3%  iozone.2048KB_128reclen.rewrite
   4992493 ±  3%     -39.6%    3016190 ±  5%  iozone.2048KB_128reclen.write
    306815 ±  4%     -13.0%     266929        iozone.2048KB_16reclen
   4236894 ±  7%     -33.1%    2834252 ±  5%  iozone.2048KB_16reclen.frewrite
   4446168 ±  7%     -38.6%    2728494 ±  3%  iozone.2048KB_16reclen.fwrite
   4123681 ±  5%     -31.8%    2812183        iozone.2048KB_16reclen.random_write
   5747492 ±  8%     -52.2%    2744589 ± 12%  iozone.2048KB_16reclen.record_rewrite
   4667894 ±  7%     -35.4%    3013487 ±  4%  iozone.2048KB_16reclen.rewrite
   3702137 ±  7%     -21.1%    2919899 ±  3%  iozone.2048KB_16reclen.write
   5910897 ± 11%     -52.9%    2785979 ± 13%  iozone.2048KB_2048reclen.frewrite
   6013474 ± 14%     -52.1%    2878111 ± 16%  iozone.2048KB_2048reclen.fwrite
  10690202 ± 13%     -64.9%    3756371 ± 14%  iozone.2048KB_2048reclen.random_write
   6212344 ± 20%     -50.2%    3091598 ± 16%  iozone.2048KB_2048reclen.record_rewrite
   5276785 ± 13%     -47.7%    2760399 ± 13%  iozone.2048KB_2048reclen.rewrite
   3998119 ±  8%     -29.1%    2836278 ± 11%  iozone.2048KB_2048reclen.write
   6633759 ±  9%     -51.5%    3218824 ±  8%  iozone.2048KB_256reclen.frewrite
   6329173 ±  8%     -46.3%    3398214 ±  4%  iozone.2048KB_256reclen.fwrite
   7819350 ± 19%     -55.2%    3501850 ±  6%  iozone.2048KB_256reclen.random_write
  11989233 ± 14%     -71.4%    3424885 ±  6%  iozone.2048KB_256reclen.record_rewrite
   7056075 ± 17%     -53.6%    3272935 ±  5%  iozone.2048KB_256reclen.rewrite
   4733134 ± 19%     -35.5%    3051341 ±  6%  iozone.2048KB_256reclen.write
    375013 ±  4%     -20.6%     297592 ± 12%  iozone.2048KB_32reclen
   5269739 ±  9%     -45.7%    2858907 ± 12%  iozone.2048KB_32reclen.frewrite
   5178543 ±  7%     -44.5%    2871717 ± 12%  iozone.2048KB_32reclen.fwrite
   5138533 ±  4%     -42.1%    2972723 ± 11%  iozone.2048KB_32reclen.random_write
   8859050 ±  5%     -64.9%    3105152 ± 13%  iozone.2048KB_32reclen.record_rewrite
   5481755 ± 14%     -47.3%    2890654 ± 11%  iozone.2048KB_32reclen.rewrite
   4133954 ±  4%     -32.8%    2777714 ± 12%  iozone.2048KB_32reclen.write
   5935222 ± 18%     -41.0%    3503137 ±  6%  iozone.2048KB_512reclen.frewrite
   5755516 ± 14%     -40.4%    3432196 ±  3%  iozone.2048KB_512reclen.fwrite
   7882965 ± 13%     -55.4%    3518040 ±  6%  iozone.2048KB_512reclen.random_write
   9812967 ± 27%     -69.2%    3023544 ± 16%  iozone.2048KB_512reclen.record_rewrite
   6668951 ± 10%     -52.4%    3173521 ±  6%  iozone.2048KB_512reclen.rewrite
   4387223 ± 16%     -32.3%    2971535 ±  4%  iozone.2048KB_512reclen.write
    452484 ± 11%     -20.8%     358435 ±  9%  iozone.2048KB_64reclen
   5940340 ± 12%     -48.7%    3048096 ±  4%  iozone.2048KB_64reclen.frewrite
   6047329 ±  4%     -48.5%    3114050 ±  3%  iozone.2048KB_64reclen.fwrite
   6736254 ±  8%     -51.0%    3299184 ±  4%  iozone.2048KB_64reclen.random_write
  11611764 ±  8%     -70.8%    3394295 ±  4%  iozone.2048KB_64reclen.record_rewrite
   6392041 ± 11%     -50.1%    3188337 ±  3%  iozone.2048KB_64reclen.rewrite
   4636089 ±  4%     -33.3%    3091914 ±  3%  iozone.2048KB_64reclen.write
   3081425 ±  7%     -25.0%    2309660 ±  7%  iozone.2048KB_8reclen.random_write
   3470896 ± 16%     -30.0%    2429657 ± 14%  iozone.2048KB_8reclen.record_rewrite
   3476842 ± 12%     -25.7%    2584243 ±  8%  iozone.2048KB_8reclen.rewrite
   2896290 ±  7%     -13.1%    2517752 ±  2%  iozone.2048KB_8reclen.write
   9446659 ± 19%     -49.8%    4740773 ± 19%  iozone.256KB_128reclen.frewrite
   7603751 ± 19%     -52.2%    3638190 ±  2%  iozone.256KB_128reclen.random_write
   8755883 ± 17%     -61.4%    3383990 ±  4%  iozone.256KB_128reclen.record_rewrite
   6438162 ± 21%     -51.5%    3123611 ±  9%  iozone.256KB_128reclen.rewrite
   4297120 ± 18%     -36.8%    2716274 ± 14%  iozone.256KB_128reclen.write
   4559373 ±  4%     -39.9%    2739746 ± 15%  iozone.256KB_16reclen.frewrite
   4647079 ±  5%     -33.3%    3101322 ±  4%  iozone.256KB_16reclen.fwrite
   4386424 ±  8%     -36.9%    2767743 ±  2%  iozone.256KB_16reclen.random_write
   5309170 ±  7%     -49.1%    2704335 ±  8%  iozone.256KB_16reclen.record_rewrite
   4649650 ±  6%     -37.2%    2921374 ±  9%  iozone.256KB_16reclen.rewrite
   6300156 ± 18%     -52.8%    2972816 ±  6%  iozone.256KB_256reclen.frewrite
   6706970 ± 16%     -52.9%    3160789 ±  9%  iozone.256KB_256reclen.fwrite
   7540355 ± 18%     -54.4%    3436809 ±  5%  iozone.256KB_256reclen.random_write
   7477530 ± 13%     -53.8%    3451828 ±  8%  iozone.256KB_256reclen.record_rewrite
   6516052 ± 14%     -53.2%    3051536 ±  5%  iozone.256KB_256reclen.rewrite
   4441003 ± 14%     -36.4%    2826469 ± 11%  iozone.256KB_256reclen.write
   5352524 ± 16%     -40.9%    3161312 ± 13%  iozone.256KB_32reclen.frewrite
   5358245 ± 15%     -39.6%    3235923 ± 12%  iozone.256KB_32reclen.fwrite
   5690762 ±  2%     -45.2%    3120219 ±  4%  iozone.256KB_32reclen.random_write
   7748557 ±  4%     -59.1%    3172741 ±  4%  iozone.256KB_32reclen.record_rewrite
   5649007 ± 10%     -46.7%    3009095 ± 12%  iozone.256KB_32reclen.rewrite
   6259857 ± 16%     -43.4%    3542430 ±  9%  iozone.256KB_64reclen.frewrite
   6914597 ± 17%     -48.2%    3583163 ± 10%  iozone.256KB_64reclen.fwrite
   6646532 ± 18%     -49.1%    3381439 ±  8%  iozone.256KB_64reclen.random_write
   8821271 ± 16%     -63.1%    3258484 ±  6%  iozone.256KB_64reclen.record_rewrite
   6218666 ± 16%     -54.0%    2857628 ± 12%  iozone.256KB_64reclen.rewrite
   4063725 ± 16%     -34.2%    2675796 ± 11%  iozone.256KB_64reclen.write
   3309908 ±  6%     -20.3%    2637427 ±  2%  iozone.256KB_8reclen.frewrite
   3387771 ±  6%     -23.0%    2607782 ± 10%  iozone.256KB_8reclen.fwrite
   3449324 ±  9%     -21.5%    2709361 ±  4%  iozone.256KB_8reclen.rewrite
   2940894 ±  5%     -17.1%    2436701 ±  7%  iozone.256KB_8reclen.write
    565917 ±  3%     -24.7%     426394        iozone.262144KB_1024reclen
   7426604 ±  4%     -53.6%    3447449        iozone.262144KB_1024reclen.frewrite
   7465832 ±  7%     -54.1%    3426029        iozone.262144KB_1024reclen.fwrite
   9241493 ±  4%     -60.5%    3646617        iozone.262144KB_1024reclen.random_write
  16705624 ±  3%     -77.8%    3710189        iozone.262144KB_1024reclen.record_rewrite
   9117761 ±  4%     -59.0%    3739487        iozone.262144KB_1024reclen.rewrite
   5658804 ±  6%     -41.1%    3333708        iozone.262144KB_1024reclen.write
    548834 ±  2%     -24.2%     415789 ±  3%  iozone.262144KB_128reclen
   7580407 ±  4%     -53.9%    3496669        iozone.262144KB_128reclen.frewrite
   7599726 ±  4%     -54.1%    3491630        iozone.262144KB_128reclen.fwrite
   8254162 ±  5%     -58.6%    3419671        iozone.262144KB_128reclen.random_write
  15674857 ±  5%     -76.0%    3757127        iozone.262144KB_128reclen.record_rewrite
   8578160 ±  4%     -56.7%    3716083        iozone.262144KB_128reclen.rewrite
   5455478 ±  6%     -38.4%    3362617        iozone.262144KB_128reclen.write
   5122765 ±  8%     -41.8%    2979344 ±  3%  iozone.262144KB_16384reclen.frewrite
   5043992 ±  9%     -42.0%    2924477 ±  2%  iozone.262144KB_16384reclen.fwrite
   6495456 ±  8%     -51.1%    3175821 ±  2%  iozone.262144KB_16384reclen.random_write
   6973977 ± 10%     -58.0%    2927753 ±  2%  iozone.262144KB_16384reclen.record_rewrite
   6455402 ±  8%     -50.1%    3223833        iozone.262144KB_16384reclen.rewrite
   4302269 ±  4%     -32.8%    2890933 ±  2%  iozone.262144KB_16384reclen.write
    542367 ±  2%     -22.9%     418397 ±  4%  iozone.262144KB_2048reclen
   6322086 ±  6%     -52.1%    3028214 ±  3%  iozone.262144KB_2048reclen.frewrite
   6134575 ± 10%     -50.6%    3028663 ±  3%  iozone.262144KB_2048reclen.fwrite
   8308015 ± 11%     -58.1%    3484881 ±  2%  iozone.262144KB_2048reclen.random_write
  16212043 ±  2%     -78.2%    3529138 ±  3%  iozone.262144KB_2048reclen.record_rewrite
   7969765 ± 10%     -54.8%    3604916 ±  3%  iozone.262144KB_2048reclen.rewrite
   5300877 ± 14%     -39.8%    3192843 ±  3%  iozone.262144KB_2048reclen.write
    554017           -26.2%     408919        iozone.262144KB_256reclen
  13019165            -6.0%   12236091 ±  2%  iozone.262144KB_256reclen.fread
  12622409 ±  2%      -7.1%   11731982 ±  4%  iozone.262144KB_256reclen.freread
   7704530 ±  2%     -54.8%    3482335        iozone.262144KB_256reclen.frewrite
   7812833 ±  4%     -55.9%    3446681 ±  2%  iozone.262144KB_256reclen.fwrite
   8835487 ±  5%     -60.1%    3523916 ±  4%  iozone.262144KB_256reclen.random_write
  15997491 ±  4%     -76.7%    3730589        iozone.262144KB_256reclen.record_rewrite
   9008693 ±  4%     -58.9%    3699947 ±  2%  iozone.262144KB_256reclen.rewrite
   5557851 ±  5%     -39.2%    3378939        iozone.262144KB_256reclen.write
    474514 ±  4%     -23.1%     364705 ±  9%  iozone.262144KB_4096reclen
   5309234 ±  9%     -45.8%    2878750 ±  3%  iozone.262144KB_4096reclen.frewrite
   5093529 ±  5%     -44.3%    2834589        iozone.262144KB_4096reclen.fwrite
   7364778 ±  7%     -55.6%    3267439 ±  2%  iozone.262144KB_4096reclen.random_write
  10366266 ± 20%     -69.5%    3156979 ±  4%  iozone.262144KB_4096reclen.record_rewrite
   7365247 ±  5%     -54.8%    3330171 ±  2%  iozone.262144KB_4096reclen.rewrite
   4798280 ±  7%     -38.1%    2968182 ±  7%  iozone.262144KB_4096reclen.write
    563088 ±  3%     -25.9%     417441        iozone.262144KB_512reclen
   7752515 ±  5%     -55.0%    3488123        iozone.262144KB_512reclen.frewrite
   7707353 ±  5%     -55.0%    3465149 ±  2%  iozone.262144KB_512reclen.fwrite
   9122558 ±  7%     -60.3%    3619515        iozone.262144KB_512reclen.random_write
  16131006 ±  4%     -76.9%    3723603        iozone.262144KB_512reclen.record_rewrite
   9178400 ±  4%     -59.1%    3751173        iozone.262144KB_512reclen.rewrite
   5645649 ±  6%     -40.0%    3384873        iozone.262144KB_512reclen.write
    504017 ±  3%     -21.9%     393712 ±  2%  iozone.262144KB_64reclen
   6978079 ±  3%     -52.7%    3299284 ±  5%  iozone.262144KB_64reclen.frewrite
   7041202 ±  3%     -51.8%    3391815 ±  2%  iozone.262144KB_64reclen.fwrite
   7114665 ±  7%     -54.6%    3231979        iozone.262144KB_64reclen.random_write
  13278679 ±  8%     -72.3%    3672374        iozone.262144KB_64reclen.record_rewrite
   7586597 ±  2%     -52.0%    3644015        iozone.262144KB_64reclen.rewrite
   5143061 ±  5%     -35.8%    3304019 ±  2%  iozone.262144KB_64reclen.write
   5066711 ±  9%     -43.8%    2845739 ±  2%  iozone.262144KB_8192reclen.frewrite
   4851138 ± 10%     -40.9%    2865015        iozone.262144KB_8192reclen.fwrite
   6278072 ± 11%     -49.0%    3198761 ±  4%  iozone.262144KB_8192reclen.random_write
   7316116 ± 13%     -59.0%    2998594 ±  2%  iozone.262144KB_8192reclen.record_rewrite
   6450681 ±  6%     -50.0%    3228542 ±  2%  iozone.262144KB_8192reclen.rewrite
   4436484 ±  5%     -33.3%    2960325        iozone.262144KB_8192reclen.write
    520469 ±  2%     -22.5%     403395 ±  2%  iozone.32768KB_1024reclen
   6865305 ±  7%     -50.5%    3401362        iozone.32768KB_1024reclen.frewrite
   7344207 ±  2%     -52.8%    3464329        iozone.32768KB_1024reclen.fwrite
   8864633 ±  4%     -60.4%    3513828 ±  9%  iozone.32768KB_1024reclen.random_write
  16492032 ±  4%     -78.0%    3628653 ±  5%  iozone.32768KB_1024reclen.record_rewrite
  11235546 ±  2%      +4.9%   11791425 ±  2%  iozone.32768KB_1024reclen.reread
   8292466 ±  5%     -57.5%    3523443 ±  5%  iozone.32768KB_1024reclen.rewrite
   4828682 ± 20%     -37.0%    3042222 ± 13%  iozone.32768KB_1024reclen.write
    520358 ±  3%     -26.5%     382529 ±  6%  iozone.32768KB_128reclen
   7345834 ±  2%     -53.2%    3440812        iozone.32768KB_128reclen.frewrite
   7129775 ±  7%     -54.6%    3238633 ± 12%  iozone.32768KB_128reclen.fwrite
   8363525 ±  5%     -59.5%    3387573 ± 13%  iozone.32768KB_128reclen.random_write
  15671110 ±  7%     -76.4%    3705583 ±  2%  iozone.32768KB_128reclen.record_rewrite
   8327280 ±  4%     -58.5%    3451855 ±  9%  iozone.32768KB_128reclen.rewrite
   5254021 ±  3%     -35.4%    3394572        iozone.32768KB_128reclen.write
   8066011 ± 14%     -37.1%    5071119 ±  2%  iozone.32768KB_16384reclen.frewrite
   6501615 ±  8%     -33.0%    4358118 ±  5%  iozone.32768KB_16384reclen.fwrite
   6098219 ±  9%     -47.8%    3183470 ±  2%  iozone.32768KB_16384reclen.random_write
   6585067 ± 10%     -53.5%    3061524        iozone.32768KB_16384reclen.record_rewrite
   6353925 ±  5%     -49.5%    3206168        iozone.32768KB_16384reclen.rewrite
   4210893 ±  5%     -29.3%    2977793        iozone.32768KB_16384reclen.write
    522544 ±  2%     -23.6%     399333        iozone.32768KB_2048reclen
   5825805 ±  4%     -46.8%    3099754 ±  5%  iozone.32768KB_2048reclen.frewrite
   5988705 ±  7%     -47.7%    3131337 ±  5%  iozone.32768KB_2048reclen.fwrite
   7737310 ± 13%     -54.7%    3506923 ±  5%  iozone.32768KB_2048reclen.random_write
  16280549 ±  3%     -78.4%    3515026 ± 11%  iozone.32768KB_2048reclen.record_rewrite
   7342137 ±  9%     -53.4%    3422572 ±  4%  iozone.32768KB_2048reclen.rewrite
   4608264 ±  8%     -35.2%    2985182 ± 14%  iozone.32768KB_2048reclen.write
    514576 ±  3%     -24.1%     390757 ±  2%  iozone.32768KB_256reclen
   7237739 ±  4%     -52.7%    3423888        iozone.32768KB_256reclen.frewrite
   7300628 ±  4%     -52.6%    3458449        iozone.32768KB_256reclen.fwrite
   8901040 ±  4%     -59.2%    3631801        iozone.32768KB_256reclen.random_write
  16048341 ±  4%     -78.5%    3445786 ± 11%  iozone.32768KB_256reclen.record_rewrite
   8280876 ±  3%     -57.1%    3555933 ±  8%  iozone.32768KB_256reclen.rewrite
   5120802 ± 15%     -37.3%    3208182 ± 13%  iozone.32768KB_256reclen.write
   5646923 ±  7%     -42.2%    3265200        iozone.32768KB_4096reclen.frewrite
   5116212 ± 18%     -39.5%    3095721 ±  8%  iozone.32768KB_4096reclen.fwrite
   6684645 ± 10%     -50.6%    3301571 ±  4%  iozone.32768KB_4096reclen.random_write
  10282683 ± 24%     -65.8%    3515692        iozone.32768KB_4096reclen.record_rewrite
   6857545 ±  3%     -51.2%    3348852        iozone.32768KB_4096reclen.rewrite
   4366899 ± 12%     -35.0%    2839282 ± 11%  iozone.32768KB_4096reclen.write
    529392 ±  3%     -25.9%     392508 ±  3%  iozone.32768KB_512reclen
   7040580 ±  5%     -51.0%    3453327        iozone.32768KB_512reclen.frewrite
   7364648 ±  2%     -53.5%    3425392 ±  2%  iozone.32768KB_512reclen.fwrite
   8918336 ±  6%     -59.6%    3603100 ±  3%  iozone.32768KB_512reclen.random_write
  15612101 ±  7%     -76.0%    3741355        iozone.32768KB_512reclen.record_rewrite
  11511261            -7.9%   10602443 ±  7%  iozone.32768KB_512reclen.reread
   8402000 ±  4%     -58.6%    3482441 ±  6%  iozone.32768KB_512reclen.rewrite
   5168215 ± 15%     -40.1%    3097976 ± 13%  iozone.32768KB_512reclen.write
    480712 ±  6%     -20.3%     382907 ±  2%  iozone.32768KB_64reclen
   6825879 ±  3%     -50.2%    3401691        iozone.32768KB_64reclen.frewrite
   6690195 ±  6%     -48.8%    3427805        iozone.32768KB_64reclen.fwrite
   7198635 ± 10%     -52.0%    3457655        iozone.32768KB_64reclen.random_write
  13214747 ±  7%     -71.9%    3707938        iozone.32768KB_64reclen.record_rewrite
   7547549 ±  4%     -52.2%    3608505        iozone.32768KB_64reclen.rewrite
   4935168 ±  9%     -32.0%    3353703        iozone.32768KB_64reclen.write
    393804 ±  4%     -21.0%     311208 ±  5%  iozone.32768KB_8192reclen
   6301898 ±  5%     -44.5%    3499366 ±  4%  iozone.32768KB_8192reclen.frewrite
   6295064 ±  7%     -41.5%    3680383        iozone.32768KB_8192reclen.fwrite
   9535662 ±  2%     -21.0%    7533567 ± 15%  iozone.32768KB_8192reclen.random_read
   6543055           -52.3%    3121724 ±  2%  iozone.32768KB_8192reclen.random_write
   7549220 ±  8%     -60.0%    3016909 ±  2%  iozone.32768KB_8192reclen.record_rewrite
   6235066 ±  5%     -49.2%    3166141 ±  2%  iozone.32768KB_8192reclen.rewrite
   3951810 ± 13%     -27.2%    2878694 ±  6%  iozone.32768KB_8192reclen.write
    410587 ±  7%     -18.8%     333504 ±  8%  iozone.4096KB_1024reclen
   5581206 ± 14%     -36.4%    3551408 ±  6%  iozone.4096KB_1024reclen.frewrite
   4963156 ± 11%     -32.6%    3346141 ±  6%  iozone.4096KB_1024reclen.fwrite
  10197657 ± 15%     -60.9%    3984266        iozone.4096KB_1024reclen.random_write
   9292095 ±  4%     -65.2%    3237748 ± 16%  iozone.4096KB_1024reclen.record_rewrite
   6008436 ± 12%     -48.7%    3083516 ±  4%  iozone.4096KB_1024reclen.rewrite
   4580562 ± 14%     -34.7%    2990265 ±  5%  iozone.4096KB_1024reclen.write
    446062 ±  7%     -19.2%     360512        iozone.4096KB_128reclen
   6407111 ±  3%     -49.6%    3230105 ±  4%  iozone.4096KB_128reclen.frewrite
   6033084 ±  8%     -47.1%    3193901 ±  2%  iozone.4096KB_128reclen.fwrite
   8353476 ± 13%     -55.7%    3699894        iozone.4096KB_128reclen.random_write
  13371492 ± 17%     -72.8%    3632717 ±  3%  iozone.4096KB_128reclen.record_rewrite
   6698376 ±  8%     -49.4%    3388864        iozone.4096KB_128reclen.rewrite
   4758658 ± 13%     -33.5%    3163675 ±  3%  iozone.4096KB_128reclen.write
    317419 ±  3%     -15.3%     268982 ±  2%  iozone.4096KB_16reclen
   4412358 ±  5%     -32.8%    2964307 ±  2%  iozone.4096KB_16reclen.frewrite
   4482749 ±  9%     -34.9%    2917748 ±  2%  iozone.4096KB_16reclen.fwrite
   4844116 ±  9%     -38.9%    2961492 ±  3%  iozone.4096KB_16reclen.random_write
   5829791 ± 12%     -47.0%    3090613 ±  2%  iozone.4096KB_16reclen.record_rewrite
   4799124 ±  3%     -36.5%    3048105 ±  3%  iozone.4096KB_16reclen.rewrite
   3680378 ±  4%     -23.9%    2802502 ±  2%  iozone.4096KB_16reclen.write
    400116 ±  6%     -15.0%     340096 ±  2%  iozone.4096KB_2048reclen
   7868614 ±  8%     -40.9%    4654236 ±  8%  iozone.4096KB_2048reclen.frewrite
   3987532 ±  9%     -19.5%    3209474 ±  4%  iozone.4096KB_2048reclen.fwrite
   9991875 ± 19%     -60.2%    3977591 ±  5%  iozone.4096KB_2048reclen.random_write
   9042388 ±  8%     -61.9%    3444073 ±  2%  iozone.4096KB_2048reclen.record_rewrite
   5365959 ±  6%     -43.4%    3034539 ±  3%  iozone.4096KB_2048reclen.rewrite
   4099336 ± 10%     -27.4%    2975606 ±  3%  iozone.4096KB_2048reclen.write
    473068 ±  6%     -17.5%     390054 ±  4%  iozone.4096KB_256reclen
   6284695 ±  9%     -49.4%    3177255 ±  2%  iozone.4096KB_256reclen.frewrite
   6025809 ±  9%     -46.8%    3206110 ±  2%  iozone.4096KB_256reclen.fwrite
   8872736 ± 13%     -57.9%    3735368        iozone.4096KB_256reclen.random_write
  12166515 ± 14%     -70.5%    3587021        iozone.4096KB_256reclen.record_rewrite
   6906230 ± 13%     -51.6%    3342769 ±  2%  iozone.4096KB_256reclen.rewrite
   4802214 ± 13%     -32.9%    3222318 ±  2%  iozone.4096KB_256reclen.write
    392538 ±  6%     -20.0%     314015 ±  3%  iozone.4096KB_32reclen
   5166220 ± 12%     -41.5%    3022049 ±  4%  iozone.4096KB_32reclen.frewrite
   5287356 ± 13%     -43.4%    2993166 ±  2%  iozone.4096KB_32reclen.fwrite
   6648671 ±  5%     -49.9%    3332904 ±  2%  iozone.4096KB_32reclen.random_write
   8724643 ± 13%     -60.9%    3415035        iozone.4096KB_32reclen.record_rewrite
   6000969 ±  8%     -46.1%    3234179        iozone.4096KB_32reclen.rewrite
   4412112 ±  5%     -30.6%    3064044        iozone.4096KB_32reclen.write
    407911 ±  6%     -14.1%     350231        iozone.4096KB_4096reclen
   5645033 ± 10%     -47.3%    2977074 ±  5%  iozone.4096KB_4096reclen.frewrite
   5443644 ±  3%     -45.7%    2956973        iozone.4096KB_4096reclen.fwrite
   9344545 ±  8%     -58.4%    3883484        iozone.4096KB_4096reclen.random_write
   7819624 ± 10%     -56.3%    3413703 ±  2%  iozone.4096KB_4096reclen.record_rewrite
   5468720 ± 11%     -44.6%    3029332 ±  2%  iozone.4096KB_4096reclen.rewrite
   4997122 ±  7%     -37.3%    3132483        iozone.4096KB_4096reclen.write
   5504982 ±  9%     -42.3%    3178736 ±  3%  iozone.4096KB_512reclen.frewrite
   5520488 ±  7%     -42.5%    3173812 ±  6%  iozone.4096KB_512reclen.fwrite
   9231637 ± 13%     -58.9%    3792217        iozone.4096KB_512reclen.random_write
  10670349 ± 16%     -67.6%    3453684        iozone.4096KB_512reclen.record_rewrite
   6376172 ± 13%     -49.2%    3237695 ±  2%  iozone.4096KB_512reclen.rewrite
   4817759 ±  6%     -35.1%    3127697        iozone.4096KB_512reclen.write
    421961 ±  5%     -19.9%     338058 ±  2%  iozone.4096KB_64reclen
   5633467 ±  7%     -44.1%    3147447 ±  2%  iozone.4096KB_64reclen.frewrite
   5660179 ±  5%     -44.8%    3124977 ±  3%  iozone.4096KB_64reclen.fwrite
   7673862 ±  7%     -53.0%    3605881        iozone.4096KB_64reclen.random_write
  11265069 ± 15%     -68.4%    3559151 ±  2%  iozone.4096KB_64reclen.record_rewrite
   6544015 ±  5%     -49.2%    3322831        iozone.4096KB_64reclen.rewrite
   4506577 ± 10%     -28.6%    3217752 ±  2%  iozone.4096KB_64reclen.write
    236006 ±  4%     -13.9%     203254 ±  7%  iozone.4096KB_8reclen
   3321733 ±  5%     -24.6%    2504197 ±  5%  iozone.4096KB_8reclen.frewrite
   3436964 ±  6%     -22.2%    2674833        iozone.4096KB_8reclen.fwrite
   3140234 ± 12%     -27.0%    2293239 ± 16%  iozone.4096KB_8reclen.random_write
   3692256 ± 11%     -28.6%    2637149        iozone.4096KB_8reclen.record_rewrite
   6484428 ±  2%     -11.9%    5711723 ± 12%  iozone.4096KB_8reclen.reread
   3633536 ±  3%     -29.3%    2567758 ± 13%  iozone.4096KB_8reclen.rewrite
   3079501 ±  5%     -19.3%    2483867 ± 14%  iozone.4096KB_8reclen.write
    476193 ±  7%     -22.5%     369196 ±  8%  iozone.512KB_128reclen
   6530898 ± 17%     -46.2%    3514641 ±  3%  iozone.512KB_128reclen.frewrite
   6822052 ±  8%     -48.1%    3543008 ±  9%  iozone.512KB_128reclen.fwrite
   8081924 ± 13%     -62.1%    3060587 ± 12%  iozone.512KB_128reclen.random_write
   9905588 ± 14%     -66.8%    3286321 ± 12%  iozone.512KB_128reclen.record_rewrite
   6311295 ± 10%     -55.1%    2831485 ± 14%  iozone.512KB_128reclen.rewrite
   4269431 ±  5%     -34.2%    2811007 ± 15%  iozone.512KB_128reclen.write
   4279482 ± 15%     -36.4%    2719661 ±  2%  iozone.512KB_16reclen.frewrite
   4415628 ± 13%     -36.5%    2802469 ±  9%  iozone.512KB_16reclen.fwrite
   4095069 ± 13%     -34.8%    2669395 ±  5%  iozone.512KB_16reclen.random_write
   5485427 ± 17%     -50.2%    2732355 ±  3%  iozone.512KB_16reclen.record_rewrite
   4150782 ± 22%     -35.0%    2697202 ±  7%  iozone.512KB_16reclen.rewrite
    460266 ±  4%     -17.0%     381794 ±  3%  iozone.512KB_256reclen
   8556758 ±  8%     -43.8%    4810503 ±  9%  iozone.512KB_256reclen.frewrite
   4821544 ±  8%     -29.7%    3389921 ±  6%  iozone.512KB_256reclen.fwrite
   8131467 ± 11%     -55.6%    3612634 ±  2%  iozone.512KB_256reclen.random_write
   9058008 ±  9%     -64.8%    3190513 ±  8%  iozone.512KB_256reclen.record_rewrite
   6719047 ± 10%     -56.8%    2904750 ± 11%  iozone.512KB_256reclen.rewrite
   4373093 ±  6%     -40.7%    2592783 ±  5%  iozone.512KB_256reclen.write
    393424 ±  7%     -13.3%     341171 ±  2%  iozone.512KB_32reclen
   4895953 ±  7%     -42.6%    2811812 ± 13%  iozone.512KB_32reclen.frewrite
   5181996 ±  8%     -42.1%    3001102 ±  8%  iozone.512KB_32reclen.fwrite
   6088473 ± 17%     -47.9%    3170840 ±  7%  iozone.512KB_32reclen.random_write
   8043848 ±  8%     -61.2%    3123743 ±  6%  iozone.512KB_32reclen.record_rewrite
   5180448 ±  5%     -43.3%    2936157 ± 10%  iozone.512KB_32reclen.rewrite
   3782107 ± 13%     -28.2%    2713878 ±  7%  iozone.512KB_32reclen.write
   6285151 ± 17%     -50.6%    3107107 ±  3%  iozone.512KB_512reclen.frewrite
   6338153 ±  9%     -53.6%    2940734 ±  8%  iozone.512KB_512reclen.fwrite
   7737841 ±  8%     -52.8%    3654890 ±  5%  iozone.512KB_512reclen.random_write
   7350493 ± 16%     -55.0%    3304559 ±  4%  iozone.512KB_512reclen.record_rewrite
   6702196 ±  7%     -55.6%    2975296 ±  7%  iozone.512KB_512reclen.rewrite
   4282814 ± 10%     -38.4%    2637095 ±  7%  iozone.512KB_512reclen.write
    461038 ±  4%     -21.9%     360197 ±  4%  iozone.512KB_64reclen
   5976515 ±  4%     -48.3%    3089257 ±  5%  iozone.512KB_64reclen.frewrite
   6215990 ±  5%     -48.7%    3190509 ±  3%  iozone.512KB_64reclen.fwrite
   7028609 ± 10%     -51.9%    3378061 ±  5%  iozone.512KB_64reclen.random_write
  11056059 ±  5%     -12.0%    9732466 ±  6%  iozone.512KB_64reclen.read
   9887177 ± 14%     -66.7%    3288094 ±  8%  iozone.512KB_64reclen.record_rewrite
   6086083 ±  4%     -49.6%    3065835 ±  8%  iozone.512KB_64reclen.rewrite
   4121861 ± 10%     -33.8%    2729029 ±  6%  iozone.512KB_64reclen.write
   5478377 ±  8%     +10.9%    6076595        iozone.512KB_8reclen.freread
   3144247 ±  5%     -23.4%    2407541 ±  7%  iozone.512KB_8reclen.frewrite
   3264788 ±  8%     -22.0%    2546212 ±  3%  iozone.512KB_8reclen.fwrite
    546111 ±  3%     -21.6%     428357 ±  2%  iozone.524288KB_1024reclen
   7147373 ±  8%     -51.7%    3453896        iozone.524288KB_1024reclen.frewrite
   7619267 ±  7%     -54.3%    3479943        iozone.524288KB_1024reclen.fwrite
   8971485 ±  4%     -59.7%    3618266        iozone.524288KB_1024reclen.random_write
  11472240 ±  6%      +7.7%   12360252 ±  4%  iozone.524288KB_1024reclen.read
  16359250 ±  4%     -77.2%    3723122        iozone.524288KB_1024reclen.record_rewrite
   8956596 ±  3%     -58.8%    3692978        iozone.524288KB_1024reclen.rewrite
   5561660 ±  5%     -39.8%    3349116        iozone.524288KB_1024reclen.write
    544356 ±  3%     -24.1%     413231 ±  2%  iozone.524288KB_128reclen
   7586281 ±  4%     -54.3%    3468246        iozone.524288KB_128reclen.frewrite
   7799627 ±  4%     -55.6%    3460094        iozone.524288KB_128reclen.fwrite
   8203000 ±  5%     -58.8%    3375607        iozone.524288KB_128reclen.random_write
  14847756 ± 14%     -74.7%    3761943        iozone.524288KB_128reclen.record_rewrite
   8675467 ±  5%     -57.2%    3714167        iozone.524288KB_128reclen.rewrite
   5444683 ±  7%     -39.0%    3321742        iozone.524288KB_128reclen.write
   4804260 ± 10%     -39.9%    2886096 ±  3%  iozone.524288KB_16384reclen.frewrite
   4932218 ± 13%     -41.0%    2910119 ±  2%  iozone.524288KB_16384reclen.fwrite
   6144575 ±  9%     -48.1%    3186721 ±  3%  iozone.524288KB_16384reclen.random_write
   6068686 ±  9%     -52.3%    2891868        iozone.524288KB_16384reclen.record_rewrite
   6144818 ± 10%     -47.9%    3202812 ±  2%  iozone.524288KB_16384reclen.rewrite
   4393484 ±  4%     -33.1%    2939119 ±  2%  iozone.524288KB_16384reclen.write
    531931 ±  6%     -20.6%     422173 ±  3%  iozone.524288KB_2048reclen
   5305317 ± 10%     -43.0%    3025608 ±  4%  iozone.524288KB_2048reclen.frewrite
   5693440 ±  9%     -45.9%    3082446 ±  3%  iozone.524288KB_2048reclen.fwrite
   7698042 ± 11%     -55.0%    3462543 ±  2%  iozone.524288KB_2048reclen.random_write
  15532439 ± 10%     -77.3%    3527035 ±  3%  iozone.524288KB_2048reclen.record_rewrite
   7919782 ± 15%     -54.8%    3582221 ±  4%  iozone.524288KB_2048reclen.rewrite
   5033940 ± 12%     -36.7%    3186813        iozone.524288KB_2048reclen.write
    551674 ±  3%     -25.1%     413284 ±  3%  iozone.524288KB_256reclen
   7720443 ±  5%     -55.4%    3440267 ±  2%  iozone.524288KB_256reclen.frewrite
   7697144 ±  2%     -55.1%    3454789        iozone.524288KB_256reclen.fwrite
   8736880 ±  4%     -59.9%    3503065        iozone.524288KB_256reclen.random_write
  16137422 ±  5%     -77.1%    3703151        iozone.524288KB_256reclen.record_rewrite
   9146274 ±  5%     -58.9%    3759435        iozone.524288KB_256reclen.rewrite
   5495525 ±  6%     -39.3%    3338003 ±  2%  iozone.524288KB_256reclen.write
   5118402 ± 12%     -44.7%    2831910 ±  3%  iozone.524288KB_4096reclen.frewrite
   5225137 ± 10%     -44.5%    2897829 ±  4%  iozone.524288KB_4096reclen.fwrite
   6682671 ±  9%     -50.9%    3282453 ±  2%  iozone.524288KB_4096reclen.random_write
  10213606 ± 19%     -69.7%    3092221 ±  3%  iozone.524288KB_4096reclen.record_rewrite
   6601112 ± 13%     -49.0%    3365783 ±  2%  iozone.524288KB_4096reclen.rewrite
   4543441 ±  5%     -34.3%    2982887 ±  3%  iozone.524288KB_4096reclen.write
    563145 ±  2%     -24.3%     426078 ±  3%  iozone.524288KB_512reclen
   7877345 ±  4%     -55.8%    3482088        iozone.524288KB_512reclen.frewrite
   7911042 ±  3%     -56.0%    3480149        iozone.524288KB_512reclen.fwrite
   9103372 ±  6%     -60.4%    3603133        iozone.524288KB_512reclen.random_write
  16296711 ±  3%     -77.2%    3712815        iozone.524288KB_512reclen.record_rewrite
   9176768 ±  6%     -59.3%    3732033        iozone.524288KB_512reclen.rewrite
   5593247 ±  6%     -40.3%    3341511 ±  3%  iozone.524288KB_512reclen.write
    505113           -21.1%     398547        iozone.524288KB_64reclen
   7015773 ±  4%     -50.9%    3446298        iozone.524288KB_64reclen.frewrite
   7106825 ±  2%     -51.4%    3451915        iozone.524288KB_64reclen.fwrite
   7018984 ±  3%     -54.3%    3207930        iozone.524288KB_64reclen.random_write
  13071765 ± 10%     -71.8%    3692656        iozone.524288KB_64reclen.record_rewrite
   7791774 ±  3%     -53.2%    3646300        iozone.524288KB_64reclen.rewrite
   5080218           -35.4%    3282308 ±  2%  iozone.524288KB_64reclen.write
   4473639 ±  6%     -38.0%    2772538 ±  3%  iozone.524288KB_8192reclen.frewrite
   4665490 ± 13%     -38.2%    2885216 ±  3%  iozone.524288KB_8192reclen.fwrite
   5959551 ±  9%     -46.4%    3194100 ±  2%  iozone.524288KB_8192reclen.random_write
   6651150 ± 16%     -56.5%    2894310 ±  2%  iozone.524288KB_8192reclen.record_rewrite
   5990381 ±  9%     -45.7%    3253373 ±  3%  iozone.524288KB_8192reclen.rewrite
   4124475 ±  5%     -28.9%    2931933 ±  2%  iozone.524288KB_8192reclen.write
    366230 ± 11%     -23.1%     281729 ± 20%  iozone.64KB_16reclen
   4199734 ± 11%     -37.5%    2626023 ± 19%  iozone.64KB_16reclen.frewrite
   3822917 ±  9%     -33.1%    2558035 ± 16%  iozone.64KB_16reclen.fwrite
   3601543 ± 13%     -40.6%    2139824 ± 17%  iozone.64KB_16reclen.random_write
   4056590 ±  9%     -47.7%    2120903 ± 16%  iozone.64KB_16reclen.record_rewrite
   3459658 ± 13%     -39.8%    2083160 ± 18%  iozone.64KB_16reclen.rewrite
   8427164 ±  4%     -20.1%    6732788 ± 13%  iozone.64KB_16reclen.stride_read
   6120260 ± 12%     -36.5%    3889010 ± 10%  iozone.64KB_32reclen.frewrite
   4801505 ± 15%     -47.0%    2545830 ± 14%  iozone.64KB_32reclen.record_rewrite
   3263725 ± 16%     -34.9%    2124296 ± 10%  iozone.64KB_32reclen.write
   4880991 ± 17%     -43.0%    2784004 ± 15%  iozone.64KB_64reclen.fwrite
   5292359 ± 17%     -44.7%    2928253 ± 12%  iozone.64KB_64reclen.random_write
   5648278 ±  7%     -48.1%    2930218 ± 14%  iozone.64KB_64reclen.record_rewrite
   4698367 ± 18%     -42.1%    2719953 ± 12%  iozone.64KB_64reclen.rewrite
    256272 ±  8%     -20.3%     204300 ± 19%  iozone.64KB_8reclen
   3018760 ±  5%     -28.6%    2154883 ± 17%  iozone.64KB_8reclen.fwrite
   2589554 ±  9%     -30.9%    1790083 ± 20%  iozone.64KB_8reclen.random_write
   2776391 ±  5%     -34.0%    1831472 ± 20%  iozone.64KB_8reclen.record_rewrite
   9689106 ±  6%     -24.4%    7325245 ± 22%  iozone.64KB_8reclen.reread
   2780070 ±  8%     -26.5%    2044117 ± 19%  iozone.64KB_8reclen.rewrite
    523517 ±  5%     -21.4%     411517 ±  3%  iozone.65536KB_1024reclen
   7309716 ±  6%     -52.8%    3449150        iozone.65536KB_1024reclen.frewrite
   7136170 ± 10%     -51.8%    3436908        iozone.65536KB_1024reclen.fwrite
   8589516 ±  8%     -57.5%    3653446        iozone.65536KB_1024reclen.random_write
  16522904 ±  3%     -77.4%    3740756        iozone.65536KB_1024reclen.record_rewrite
   8237647 ± 13%     -55.2%    3693916        iozone.65536KB_1024reclen.rewrite
   5028003 ± 15%     -32.8%    3379528        iozone.65536KB_1024reclen.write
    532763 ±  3%     -25.6%     396335 ±  3%  iozone.65536KB_128reclen
   7333316 ±  2%     -52.8%    3461546        iozone.65536KB_128reclen.frewrite
   7291372 ±  6%     -52.5%    3461086 ±  2%  iozone.65536KB_128reclen.fwrite
  11653668 ±  2%      -7.9%   10737854 ±  5%  iozone.65536KB_128reclen.random_read
   8279730 ±  4%     -58.6%    3425741 ±  6%  iozone.65536KB_128reclen.random_write
  15784970 ±  6%     -77.4%    3564663 ± 13%  iozone.65536KB_128reclen.record_rewrite
   8209229 ±  4%     -57.6%    3480549 ± 10%  iozone.65536KB_128reclen.rewrite
   5385626 ±  7%     -38.9%    3292029 ±  7%  iozone.65536KB_128reclen.write
    364555 ±  5%     -14.9%     310230 ±  3%  iozone.65536KB_16384reclen
   6121630 ±  8%     -43.7%    3444762 ±  5%  iozone.65536KB_16384reclen.frewrite
   5977371 ± 11%     -39.8%    3600389 ±  2%  iozone.65536KB_16384reclen.fwrite
   5875081 ±  7%     -46.1%    3168819        iozone.65536KB_16384reclen.random_write
   6547127 ± 12%     -55.1%    2937757 ±  2%  iozone.65536KB_16384reclen.record_rewrite
   6309500 ±  6%     -49.4%    3194181        iozone.65536KB_16384reclen.rewrite
   4280168 ±  9%     -30.3%    2981202        iozone.65536KB_16384reclen.write
    523194 ±  3%     -24.7%     393917 ±  3%  iozone.65536KB_2048reclen
   6033279 ±  7%     -47.9%    3140454 ±  4%  iozone.65536KB_2048reclen.frewrite
   5694042 ± 10%     -45.9%    3078205 ±  3%  iozone.65536KB_2048reclen.fwrite
   8145174 ± 12%     -59.9%    3266812 ± 11%  iozone.65536KB_2048reclen.random_write
  15342282 ±  6%     -76.6%    3590795 ±  2%  iozone.65536KB_2048reclen.record_rewrite
   8223228 ±  8%     -56.4%    3581365 ±  2%  iozone.65536KB_2048reclen.rewrite
   4780028 ± 13%     -32.8%    3211311        iozone.65536KB_2048reclen.write
    533351 ±  3%     -24.5%     402890 ±  4%  iozone.65536KB_256reclen
  12079128 ±  2%      -6.9%   11241418 ±  5%  iozone.65536KB_256reclen.bkwd_read
   7334735 ±  8%     -52.5%    3480491        iozone.65536KB_256reclen.frewrite
   7534682 ±  3%     -53.8%    3481345        iozone.65536KB_256reclen.fwrite
   8373364 ± 10%     -58.8%    3453897 ±  9%  iozone.65536KB_256reclen.random_write
  15885493 ±  5%     -76.3%    3761757        iozone.65536KB_256reclen.record_rewrite
   8576540 ±  5%     -58.7%    3543897 ± 12%  iozone.65536KB_256reclen.rewrite
   5497339 ±  5%     -41.8%    3201097 ± 12%  iozone.65536KB_256reclen.write
    447161 ±  7%     -11.7%     395001 ±  5%  iozone.65536KB_4096reclen
  10988607 ±  3%      +7.3%   11794894        iozone.65536KB_4096reclen.bkwd_read
   5013257 ± 15%     -39.4%    3039515 ±  2%  iozone.65536KB_4096reclen.frewrite
   4813077 ± 13%     -36.3%    3064406 ±  3%  iozone.65536KB_4096reclen.fwrite
   6399770 ± 10%     -46.8%    3407474 ±  2%  iozone.65536KB_4096reclen.random_write
  10205662 ± 19%     -66.2%    3454282 ±  4%  iozone.65536KB_4096reclen.record_rewrite
   6482710 ±  9%     -48.2%    3357054 ±  2%  iozone.65536KB_4096reclen.rewrite
   4401916 ± 11%     -30.4%    3065639        iozone.65536KB_4096reclen.write
    535125 ±  3%     -23.3%     410409        iozone.65536KB_512reclen
   7295801 ±  9%     -52.2%    3487131        iozone.65536KB_512reclen.frewrite
   7315293 ±  5%     -52.5%    3476743        iozone.65536KB_512reclen.fwrite
   8838896 ±  5%     -59.8%    3555162 ±  4%  iozone.65536KB_512reclen.random_write
  16004485 ±  5%     -76.7%    3725394        iozone.65536KB_512reclen.record_rewrite
   8725959 ±  5%     -58.4%    3632000 ±  5%  iozone.65536KB_512reclen.rewrite
   5498540 ±  7%     -40.1%    3291327 ±  6%  iozone.65536KB_512reclen.write
    493180 ±  2%     -22.4%     382816        iozone.65536KB_64reclen
   6810831 ±  6%     -50.0%    3407101        iozone.65536KB_64reclen.frewrite
   6441149 ± 15%     -47.1%    3406167        iozone.65536KB_64reclen.fwrite
   7150939 ±  4%     -53.0%    3361410        iozone.65536KB_64reclen.random_write
  13342191 ±  8%     -72.4%    3680370        iozone.65536KB_64reclen.record_rewrite
   7346364 ±  4%     -50.4%    3644451        iozone.65536KB_64reclen.rewrite
   5059274 ±  5%     -34.1%    3333866        iozone.65536KB_64reclen.write
    367800 ±  8%     -13.0%     319920 ±  4%  iozone.65536KB_8192reclen
   5130108 ± 13%     -38.7%    3144695 ±  2%  iozone.65536KB_8192reclen.frewrite
   5282928 ± 14%     -43.3%    2993237 ±  4%  iozone.65536KB_8192reclen.fwrite
   5864239 ± 13%     -44.5%    3255758 ±  2%  iozone.65536KB_8192reclen.random_write
   7447215 ± 12%     -60.8%    2921843 ±  9%  iozone.65536KB_8192reclen.record_rewrite
   6015508 ± 11%     -46.1%    3240985        iozone.65536KB_8192reclen.rewrite
   4093019 ± 10%     -26.5%    3007445        iozone.65536KB_8192reclen.write
    475130 ± 12%     -17.0%     394591 ±  8%  iozone.8192KB_1024reclen
   6130421 ± 12%     -42.9%    3498269 ±  2%  iozone.8192KB_1024reclen.frewrite
   6337955 ± 16%     -45.0%    3486354 ±  5%  iozone.8192KB_1024reclen.fwrite
   9934170 ±  7%     -61.8%    3796260 ±  3%  iozone.8192KB_1024reclen.random_write
  15509021 ±  5%     -76.1%    3701585 ±  3%  iozone.8192KB_1024reclen.record_rewrite
   6870785 ± 13%     -49.9%    3442812 ±  2%  iozone.8192KB_1024reclen.rewrite
   4989329 ± 12%     -35.6%    3210789 ±  2%  iozone.8192KB_1024reclen.write
    465061           -21.4%     365480 ±  3%  iozone.8192KB_128reclen
   6065060 ±  8%     -45.0%    3337027 ±  2%  iozone.8192KB_128reclen.frewrite
   6493273 ±  5%     -49.8%    3259540        iozone.8192KB_128reclen.fwrite
   9439549 ±  5%     -59.4%    3833701        iozone.8192KB_128reclen.random_write
  14670770 ±  2%     -75.0%    3674591        iozone.8192KB_128reclen.record_rewrite
   7314592 ±  4%     -51.4%    3557764 ±  2%  iozone.8192KB_128reclen.rewrite
   5108572 ±  7%     -34.4%    3349232        iozone.8192KB_128reclen.write
    314148 ±  5%     -13.1%     272915 ±  2%  iozone.8192KB_16reclen
   4553655 ±  7%     -34.4%    2984927 ±  2%  iozone.8192KB_16reclen.frewrite
   4576435 ±  2%     -35.0%    2975972        iozone.8192KB_16reclen.fwrite
   4601444 ± 11%     -37.3%    2883163 ±  6%  iozone.8192KB_16reclen.random_write
   6059685 ± 12%     -47.8%    3164798        iozone.8192KB_16reclen.record_rewrite
   4987759 ±  3%     -36.2%    3183789        iozone.8192KB_16reclen.rewrite
    462578 ±  8%     -20.2%     368979 ± 11%  iozone.8192KB_2048reclen
   6306206 ± 10%     -43.2%    3580659 ±  7%  iozone.8192KB_2048reclen.frewrite
   6659820 ± 16%     -44.3%    3709375 ±  6%  iozone.8192KB_2048reclen.fwrite
   9498869 ±  8%     -62.0%    3614123 ±  5%  iozone.8192KB_2048reclen.random_write
  14512262 ±  5%     -75.4%    3574411 ±  5%  iozone.8192KB_2048reclen.record_rewrite
   6602412 ± 11%     -49.9%    3304954 ±  4%  iozone.8192KB_2048reclen.rewrite
    466781 ±  5%     -20.2%     372625 ±  4%  iozone.8192KB_256reclen
   6386508 ±  8%     -47.9%    3325742 ±  3%  iozone.8192KB_256reclen.frewrite
   5820585 ± 11%     -43.1%    3314745 ±  3%  iozone.8192KB_256reclen.fwrite
   9800951 ±  6%     -61.3%    3789649 ±  3%  iozone.8192KB_256reclen.random_write
  14772982 ±  8%     -75.3%    3642014        iozone.8192KB_256reclen.record_rewrite
   7350256 ±  5%     -51.3%    3580211        iozone.8192KB_256reclen.rewrite
   5247001 ±  4%     -36.6%    3328082        iozone.8192KB_256reclen.write
   5460768 ±  8%     -43.4%    3091787 ±  4%  iozone.8192KB_32reclen.frewrite
   5534873 ±  5%     -42.6%    3179338        iozone.8192KB_32reclen.fwrite
   6216039 ± 17%     -47.5%    3263073 ±  7%  iozone.8192KB_32reclen.random_write
   8438285 ± 22%     -59.2%    3443608        iozone.8192KB_32reclen.record_rewrite
   5910033 ±  6%     -44.6%    3274775 ±  5%  iozone.8192KB_32reclen.rewrite
    430569 ±  6%     -17.9%     353551 ±  4%  iozone.8192KB_4096reclen
   8002703 ± 11%     -36.7%    5069052 ±  6%  iozone.8192KB_4096reclen.frewrite
   4862899 ± 12%     -27.2%    3538752 ±  8%  iozone.8192KB_4096reclen.fwrite
   8342306 ± 11%     -57.6%    3541294 ±  3%  iozone.8192KB_4096reclen.random_write
  10085813 ±  5%     -67.3%    3297639 ±  4%  iozone.8192KB_4096reclen.record_rewrite
   6381708 ±  9%     -49.2%    3240446        iozone.8192KB_4096reclen.rewrite
   4568275 ±  9%     -35.5%    2948307 ±  2%  iozone.8192KB_4096reclen.write
    490409 ±  2%     -19.8%     393423 ± 10%  iozone.8192KB_512reclen
   6399076 ± 11%     -47.9%    3335299 ±  4%  iozone.8192KB_512reclen.frewrite
   5784862 ±  8%     -42.4%    3332431 ±  4%  iozone.8192KB_512reclen.fwrite
   9010939 ± 16%     -57.8%    3800958 ±  2%  iozone.8192KB_512reclen.random_write
  15187696 ±  3%     -76.0%    3652068 ±  2%  iozone.8192KB_512reclen.record_rewrite
   6918403 ±  6%     -48.8%    3545527 ±  2%  iozone.8192KB_512reclen.rewrite
   4858375 ± 10%     -33.5%    3232714 ±  4%  iozone.8192KB_512reclen.write
    434205 ±  6%     -19.5%     349456 ±  2%  iozone.8192KB_64reclen
   6063804 ±  4%     -45.6%    3297539        iozone.8192KB_64reclen.frewrite
   6053168 ±  3%     -47.7%    3164408 ±  6%  iozone.8192KB_64reclen.fwrite
   8298214 ± 12%     -55.4%    3702040        iozone.8192KB_64reclen.random_write
  12308732 ±  9%     -70.3%    3651140        iozone.8192KB_64reclen.record_rewrite
   6862988 ±  6%     -50.1%    3426635 ±  6%  iozone.8192KB_64reclen.rewrite
   4552180 ± 13%     -30.0%    3186567 ±  6%  iozone.8192KB_64reclen.write
    387354 ±  4%     -15.3%     328219 ±  2%  iozone.8192KB_8192reclen
   6174265 ±  7%     -49.0%    3149477        iozone.8192KB_8192reclen.frewrite
   6270247 ±  3%     -49.3%    3180202        iozone.8192KB_8192reclen.fwrite
   6440330 ±  8%     -50.0%    3219047 ±  4%  iozone.8192KB_8192reclen.random_write
   6417631 ±  7%     -49.6%    3233756 ±  2%  iozone.8192KB_8192reclen.record_rewrite
   6213176 ±  6%     -48.9%    3174174        iozone.8192KB_8192reclen.rewrite
   4263827 ± 11%     -32.8%    2866624 ±  4%  iozone.8192KB_8192reclen.write
    238775 ±  8%      -8.6%     218130        iozone.8192KB_8reclen
   3470213 ±  6%     -21.4%    2727307        iozone.8192KB_8reclen.frewrite
   3492178 ±  8%     -21.7%    2734116        iozone.8192KB_8reclen.fwrite
   3088507 ± 11%     -22.7%    2385914        iozone.8192KB_8reclen.random_write
   3794719 ± 12%     -29.6%    2673377        iozone.8192KB_8reclen.record_rewrite
   3626974 ± 11%     -20.3%    2890733        iozone.8192KB_8reclen.rewrite
   4092925 ±  2%     -18.5%    3337298        iozone.average_KBps
  55650360 ±  3%     -44.2%   31052398        iozone.frewrite_KBps
  53439424 ±  3%     -43.6%   30144851        iozone.fwrite_KBps
  64647843 ±  5%     -52.7%   30607658        iozone.random_write_KBps
  94823016 ±  5%     -67.5%   30823219        iozone.record_rewrite_KBps
  59841456 ±  3%     -48.9%   30554034        iozone.rewrite_KBps
    733.66            +1.3%     743.16        iozone.time.elapsed_time
    733.66            +1.3%     743.16        iozone.time.elapsed_time.max
      6.83 ±  5%     +31.7%       9.00        iozone.time.percent_of_cpu_this_job_got
     52.33 ±  3%     +34.3%      70.29        iozone.time.system_time
  41427226 ±  5%     -32.2%   28071504        iozone.write_KBps





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


