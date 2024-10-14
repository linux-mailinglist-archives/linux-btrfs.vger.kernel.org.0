Return-Path: <linux-btrfs+bounces-8885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06599BCDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 02:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B428157E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA954A24;
	Mon, 14 Oct 2024 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IewqwAgu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B3182;
	Mon, 14 Oct 2024 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728864496; cv=fail; b=seEIBfmpbrBfd7ABA2JxjSoOkQqBRnEHv8WGsE5A4K0HL3Du1K1MCO61BlhLTDXV39RS9adTY6pOCU8cfN9NJH4PLqRsPQKYUABngVUxzTot1BfnHNn7PJ+gy9mwWhxu/LRHKN/L61sGuJFVMWIijqUyS21xOZJRjc5YEPZ7ovg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728864496; c=relaxed/simple;
	bh=3Y8tld9HnZf4PwfnYJ6V/a3zVFag3mR90LWk2WkdMj0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bl5+y7VuMxfOltVQuChAy6aJLlOpYxqqLCPe2KEsRHaVjDVsC73LWlHbuXeALFpEV30G3sPIIy0k4wIhUAErZej6IkUhUD9WKpQ+L6p3qRoS5UPaEWl4lo99SiI/mcI5Zt+vtQiVqlzxu8IqGj5ccu+WvICoASWqv6LNSsxtwYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IewqwAgu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728864495; x=1760400495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3Y8tld9HnZf4PwfnYJ6V/a3zVFag3mR90LWk2WkdMj0=;
  b=IewqwAgu3Vg1gk87mKW/JWoKBmiGREhhXQLiGdBNcQ1YLQGkoxlmjO2+
   CVUUpeAwIZdblcod9rHAQjmljBld+pnVE90XbHQEtDEi+xFjxJhwObWRP
   xvClA50hbqkm0f3TAnWjqnOI6hkNZ+Ar12N+Mlmcp1eFHtitrWEOrTbfj
   KB9Y9ID+ohzJlEUIzH+mBQEJVovvt8tUo6LMYGn2swTWlzr+c9ZWVp/K4
   98F5M3z4sHDcsqY7ttyU5SenuEc+Y1NEnVtNVra5wxJ/jgIbuVGf3vnbu
   t/cn1pqH8k5kgJkhojtImaoJZd9MyYIwqpRP7Ue5ucla8U4thSXKnVSrZ
   w==;
X-CSE-ConnectionGUID: YVOtQKksSfq0CI8RCJkcmg==
X-CSE-MsgGUID: oo6RyTO1TFSO/FtwxJIrXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="53622091"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="53622091"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 17:08:14 -0700
X-CSE-ConnectionGUID: dpbbhOeZRBibWfj2dnfOyA==
X-CSE-MsgGUID: 3b9NOhxUT8SpTLPOpodbow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="77426620"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 17:08:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 17:08:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 17:08:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 17:08:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 17:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTpu6JLd+hThIHhZfkrD1Muw1uI/WcAVhv269VRau3S4pK8NNUH9xFWw1fLR8CucqyarxV5aL12+xNpPXADItIKe++Vy3dmNoOmtl0h42KHYvfh06jz5ERvZGJ+kFLl2CNT2L0hBQYA+quN+kxKe2wnr2sRUdYECKyTHYQpvwlyVHP51GEfvYjRSkiWvjWpAX6KcQ+vszimZvb1bTXxLjdRt8SMMCcEtd45SVFiyXZpSN8DdapRq4yYY7JpK/ghQFnSx0EylXH74jLp54k/Dy6Jrx7AKKq2OHEFNXg94fLguaYuPqyk2SNjZ1yKA2oT/j1ArKlAfiOx6lYOLljhZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1neW0JRoFZZYhSVJlakbldHgl0H6AcOxFMeA/fiszbU=;
 b=c8mn+vnvAERoIOvpt3p//fyJb9/BBbXiwhLMqy8VzC9vculqsYU5pRnX4xyqyhXSUDJ0/m+Ej4SHTZbyAXAuBrxZhw80HMDiA2HRAd7ENXH/Cz562LwHegVi1RER8dlqQN/Zcbl2bPiJ+XTbPd3AutvAsfyu+TlinonENCUWH+0KAcAT6J+O/0HlsDkmVcoaHnJYQmZHUE63bfGY5VzKlLDqtxU4smWDqiFAJYJTgwCh8dmfV34vcdz50eiVModsfxMP8/rF0mr1uHdL17gRJzajGr/kzx4Zl0LAJ0nT5sq8jZ+5HnmlrsGL6cU+JJW5eyZw1oQ9vjK1IoJuwdwlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 00:08:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 00:08:10 +0000
Date: Sun, 13 Oct 2024 19:08:04 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, "Sergey Senozhatsky"
	<senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
Message-ID: <670c60e46ee3f_9710f294da@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
 <871q0p5rq1.fsf@prevas.dk>
 <ZwaWJcfD8lPLhpY2@black.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwaWJcfD8lPLhpY2@black.fi.intel.com>
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 686268d7-22c4-4bd7-bd30-08dcebe449d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Q8+HXG6SjBCuTs5vuoUnAnErgM2DSUrlrsD4Os3h8e6w2FUQS88YLZrXyES?=
 =?us-ascii?Q?AHHQv3R2bQTYIxSgk5UCNkEh94OfhSRriab+sDBfZ5XVOq86b8P0vr+n4M0m?=
 =?us-ascii?Q?zn3fqrhnONw5e5WSlj5qHNCIXG6BcVGwq9Y51qA2LcSSBgOl7JFb1tJbH3Te?=
 =?us-ascii?Q?3Bqjgwey0SMiZqx+n4DDeXDXe9Qq31ocn02L6J0OdfiDS6Aa4nA2Pgw6i23o?=
 =?us-ascii?Q?ENG1Q1wzB91wz/cLwl2a9oooM1q1gkvjoklxebriwg4JPsqMjkhV0BHVF59D?=
 =?us-ascii?Q?l7CuOQ/bN0eWzRrwOOOmCghoUoSu+KrVqKkT0OO/C67NtiSXrV7qHAeslQPa?=
 =?us-ascii?Q?PXOp4Ueb1UGE99jCN1eEkU0aD3brGkeul6Pp+xABNBF9ayNJxg8TewjKYZGG?=
 =?us-ascii?Q?n9FkprOtZxdRqTILyxFWMUlPnwgZPxGgo/LAnF0Uj+341yRcSF061cc5WIK9?=
 =?us-ascii?Q?YTGeqM9kQR2vf8K4rCSYQlTXAFchu0xa8Kw+1O47cncMkucIirwBEQDtpBjO?=
 =?us-ascii?Q?yqfTqRhZTgCv+SkgYx5H8WGvkPH360Nd3jwbcoPFLp/KWJ1XwHxzwq/1JbXv?=
 =?us-ascii?Q?2oiBh/DAUan9HXd8fXhQNUwasrsQYUwus3DsoF74t6G7+QTV/+yr+QAhEgzy?=
 =?us-ascii?Q?r8skJtiD7/4iFsxMOnXdGXZZI5lmS/a9PiFBUTCVYuQp7EzT3u3MRzvEXeys?=
 =?us-ascii?Q?pAKJ6pBKr9j+JBYiPTLHaDBgdPd1A1pqmP3e3dJEkwBYm+43zF49M3KiPfgP?=
 =?us-ascii?Q?kVXLOmEJqcesLZHtIo+3s84D0PXelo67RRpcDYm9wWYGP8uL/scJBHduylV3?=
 =?us-ascii?Q?0IiUnjwMGfC6MfsiBddjOirxf1b6XFOeXL7zXByNZJzFyBr/09f3iJd9AJRT?=
 =?us-ascii?Q?50cfVfxyyLsXsWwRzVnmKqnlwaAGHag+UfHFnDn6B+UTZfne+kCZ6Qy6ABmM?=
 =?us-ascii?Q?jTmm57n0tTR9b4Qy4NPQVZITumPFEfqIlAxvW9/FLcDc8uxnmeOaHRChPAgP?=
 =?us-ascii?Q?ucBb9gNInFdyEJKHUy4e9TURov2LMv8xcZxnyxBUfx9XXIrr3gLgx8TNvGB/?=
 =?us-ascii?Q?t1U04YATRIKWgktqbYNfnWvmfSD1Ldk3sD5oX1P8MDXxGqyfWGsbSkjaIomh?=
 =?us-ascii?Q?7PTRsIPLRaV1dMhZxXBwOjsVX0BKMyiQAifnvdzCklN6y+5hyUHXvK6Sp2Ug?=
 =?us-ascii?Q?ZWDOpAfOL8EyqcdCB/mQrL+R8oN0w6PgaiQqLHo1YPaCGSCWn4rlsCAjTHbR?=
 =?us-ascii?Q?CU6cwblqi2Sj2Ysjy/ZsR2KJsfLMk9tI0HZ0XBOUVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ULcDDbB93esOh5wtSirNbdnTIOCQMQXZMq7X5xpXUBJ+953iEqRbYdXCQ4r?=
 =?us-ascii?Q?DOkhI1UFh4hxIS2YGrr07IfZmPh8xfCQfLZj6LLWMuRF1q2EFE3WHFK+bH1E?=
 =?us-ascii?Q?ZpiTA3VBd4hTdeKCnHVo2FJkdDd+LZCrTcPGy0x0HULK0EFdU1s9jmE2ofMq?=
 =?us-ascii?Q?HK2v9LscYvF/sryVXfPfhLaqyNfyoXrVaHGs/EHmEvk7og+8PYbLRwD44kIL?=
 =?us-ascii?Q?AwhoCCasxkNo0mv4oMI9JmohbGzKry+Xgt5oexwMJYJEBVXleYK6T8w2Fuce?=
 =?us-ascii?Q?ANpixqQTFulV18ToGw0fLrUoSMnZLeaUyMtNDD35KtFXL6CtUQ1BaXPrP05v?=
 =?us-ascii?Q?YC1LOUN1O9Aa+M0XsBfeZ/NV1Ypv0KfyGYn4q7BwnZ2bFabDJqX4aJHR/C5r?=
 =?us-ascii?Q?wogd5cvFyZCtue/qcnDnhOFf3xUQFoWokPbBLHgUmxqB2dZxSpDxVl8n+hTS?=
 =?us-ascii?Q?tAqWWJWM5yZvovo95y6O8fHpV0cY7sc8TaNPKdHIbY+QQ+TF49gqFLc0Ep+G?=
 =?us-ascii?Q?lj1xi3SQCwwGiMt3mm6Fn18iZyiSc+SCWHfLgaUMtkmjcEuYtOZfBQMYcu79?=
 =?us-ascii?Q?+k/3XEwCWvtbFpEIOKRhFJVgK3sITwqcw1+lEkBw1f+dDHJ1IueTIaS7ve/r?=
 =?us-ascii?Q?/MOQ4l5GKs7CNVOUMSK6vK3dszMOl5c74ONtZuOoXSsL9pLTo4Vg+9kHCG51?=
 =?us-ascii?Q?ijNGsUbbpz/YwGjii+ra2cvtGw9aCr437OmdvbgKmlCWWNsEnJPNIMR9Amjo?=
 =?us-ascii?Q?H473X0kgBIfwN12TR8VsTmupDRKWMaz9nBuHR5FguvGke5izc4a2FTM0h9Th?=
 =?us-ascii?Q?m8i41fqpOQXmu7xPyYUTHvS8vZgzf5VX/tA1HSq94jaK32V+Rar8Zc2WjAcC?=
 =?us-ascii?Q?XfKdqKx5/PJ8dTQE+Q5ZEfCBRew97Uin4j4z8rFqu8YMr5EYLrur2J+BEYO2?=
 =?us-ascii?Q?q2AGrjG22OKEsXMuW3278ZSpn5AU6xUxCe4W9DlJTWIgGRHbRuGs1ilVz75S?=
 =?us-ascii?Q?K0koWlvqxLRG45qCCGnOabfJ6enV81PbPOlbUggvTaXmc9hL0wyl6cIEzD1J?=
 =?us-ascii?Q?oHDvGgKNS5qvXV45UAp462RAsuNcwFfY4jpsHLenM2SfC/tq9VQXmxKaAsaz?=
 =?us-ascii?Q?lZ53C7nuo2NtTbkt/MtOByRijMivjT3DLDb/+xAtbIVr8NhifBeeWeVF6Piq?=
 =?us-ascii?Q?A7ctStgXf7GjnjMt+x2wK4O4fjqglRIIvq3GX6KKlZIWUncVcfTmuu0wbApv?=
 =?us-ascii?Q?i/a091DHJ1R9CEaowV8wRV0RLOE94DddqjQy8776aY7r8kWCWjKeuYKSFyUw?=
 =?us-ascii?Q?aMJgv/PGSEfp4NoJz8sShfCP5aBTJZBpEwzoMeunZHrVLUf0AQStD04IL2Ya?=
 =?us-ascii?Q?aS6O4Ul9YO/jfquyqhQRAprvo1sQx+4FUYc9wEWs3hWX8aQF7JtmWMOJmNd8?=
 =?us-ascii?Q?Dvpm8AcKs6vRVvRIzB+F92ClSJBideQQSPrP443UnwGclROGiRjiSbAZi+AH?=
 =?us-ascii?Q?ySnux/D2GxT7qnZgHS7Fiv6jnCWQIJoq8ixlrS4qC+OveKVbcM6gXcBOfWtJ?=
 =?us-ascii?Q?LVpVqQRDZskVJWFC3Pvnswzh6v1o55AgxZENSDsE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 686268d7-22c4-4bd7-bd30-08dcebe449d0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 00:08:10.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PkPn3xe3JVpKNY66yYP0F5NUXm+8p/3PSdhjA1yCH3VrBW1weecAgCVZoSS9ji5yYmQK4j8/9xO8F/UBiiWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Wed, Oct 09, 2024 at 03:30:14PM +0200, Rasmus Villemoes wrote:
> 
> ...
> 
> > Rather than the struct assignments, I think it's easier to read if you
> > just do
> > 
> >   struct range r;
> > 
> >   r.start = 0xc0ffee00ba5eba11;
> >   r.end   = r.start;
> >   ...
> > 
> >   r.start = 0xc0ffee;
> >   r.end   = 0xba5eba11;
> >   ...
> > 
> > which saves two lines per test and for the first one makes it more
> > obvious that the start and end values are identical.
> 
> With DEFINE_RANGE() it will save even more lines!

Yea I've added DEFINE_RANGE().  Thanks.

> 
> ..
> 
> > > +		if (buf < end)
> > > +			*buf++ = '-';
> > 
> > No. Either all your callers pass a (probably stack-allocated) buffer
> > which is guaranteed to be big enough, in which case you don't need the
> > "if (buf < end)", or if some callers may "print" directly to the buffer
> > passed to vsnprintf(), the buf++ must still be done unconditionally in
> > order that vsnprintf(NULL, 0, ...) [used by fx kasprintf] can accurately
> > determine how large the output string would be.
> 
> Ah, good catch, I would add...
> 
> > So, either
> > 
> >   *buf++ = '-'
> > 
> > or
> > 
> >   if (buf < end)
> >     *buf = '-';
> >   buf++;
> 
> ...that we use rather ++buf in such cases, but it doesn't really matter.

Done.
Ira

