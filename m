Return-Path: <linux-btrfs+bounces-8856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DAE99A6DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3825CB25F8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9503C194A66;
	Fri, 11 Oct 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvfgFfvn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE815252D;
	Fri, 11 Oct 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658191; cv=fail; b=OlgTrsL8DXJ83iunJi4GhpaTQqb8uh4KWsw0SxIxO4jhWnHGd4ALf/yvD7U/2m830+Y/c2IIYGMXjpSF0DdJf0dQ2GVaF6Mfp/ZScl561bGwS397JJiG6M01bHQFf0MtAKf4hPKr/XzJpAl21wDHZagKPkTTl6zBZIRBtz2LLVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658191; c=relaxed/simple;
	bh=p2e2f6ZcHSpQf5b7bdqm8T3ntCz2o+MBoREiFW6mNr0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aU4z41OPGH7eshxBFYnOBsDNPHrt5AAclut12CCT6Yp4suDk+WGoZklEb9R1X34FfGETlJDKj2z25Az1eftBN0ACtLT+O85Ck5vawsvf4KX99PAs0yOunoQ8vOA3Us9Ava3IQ8+En9Td36sLSoNqA3nkoVSHbGDxID+XHOkL9No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvfgFfvn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728658190; x=1760194190;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p2e2f6ZcHSpQf5b7bdqm8T3ntCz2o+MBoREiFW6mNr0=;
  b=nvfgFfvnxV8bRtdCuChCU9Ni6J+iQa/no8nKSzAndDk7faqSZ4Kgt4Ov
   TODqmXwd+zunLff9X6O1unIl/A0VnR/q1LhcohX+GYgbQPEZDFEO63gc4
   qG7oZusJDPdRUjrm0iDQrHgiSTVKvagvKsUP6AREF28I8QLrwCQjXneJb
   VY284od3MqT7MkIUl0vhjgnXdj4Pc+Ug5ETDpE2X4sMR9lq6ilOhi2qxF
   kDgLC7JeTOgTwE1hBYASPyoGAOMzW9mJR3Z2O+J/dM3w3dQ2PaJCbNMvW
   NbGLoJXQyAAcikipl1FI0acARceH384nk3hyVdXmS8REuzDSaEAXHQjf2
   w==;
X-CSE-ConnectionGUID: 6qZusuPlTHCz5pvPVekFQg==
X-CSE-MsgGUID: H/ajaOM2SImtTLtdgv6rMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="15686033"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="15686033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:49:49 -0700
X-CSE-ConnectionGUID: uiTF8QkRR4a14z6KEFHb3A==
X-CSE-MsgGUID: GaOlZPuMQqWl5d9N9AeWfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76585214"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 07:49:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:49:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:49:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:49:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 07:49:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 07:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh+EtoejOIawlQY9QXFGXykBfISwiUKcMpmuvBUGdQLqA1Qh0Vzjl2G60OFHEYoF/QtgXCbnAARLdU8oTeRWhlTyGOpsOumy9CP1dnwwh4BF/i/YXNhBlYY9WtsutjgBq7ZE5yUSVnNeMfrAMDHy9eee2NEiDGolqGWBvSJRHS3A3lnK3g5dVG6syrmeVOBEjDpZmS/lSMjQteAF5cGW2jP1n34yhimrQmLt0SWY+ztXpQVdaL0Jxhps4lF7wzBOcMT1pKfQyEcrWS8eoZJPHLEjju4c2lhU9RJuPkrOyHTWCbpiby4jWS6f5/h46GoauiCpYVDVxftOg8prbxubbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nMeUuj8V2RAQwtNzQSiGE4bFDxHe+Yhzu+NWcRpDHc=;
 b=so+WayfJPjFXnGWSbEVvHlsHmi3l9V22M0XQShIf1ZvR71x+p9EqrNAX3v+NUSCWuHUqwPYQdcGcF2Js7CVEKVkt3LHLpQuD7K2+IA/HDSKb9t3f+MoxAQ5Jf+m1Y9I6ZIWEP1hzkpHgCE5HYWqCqACvS8Yx3YUSPhT2Ve8vfCOSuovAxwfcoW1lai5ZjG/I8zzZ4oUmCOTb7Bv4IdIS1W+1ZykWweJ/bmA5L2ybZ7xRjaiSqtf6gZU975Hin6V1RAMs2uTdVwrSXgZSlZ44NopG0HhY/8eRuf1y0eX4onnYOxTaFVx/eLzLTDanQhauCX6qfBwfYvdy4akAtPBiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH2PR11MB8780.namprd11.prod.outlook.com (2603:10b6:610:284::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:49:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:49:45 +0000
Date: Fri, 11 Oct 2024 09:49:39 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Petr Mladek <pmladek@suse.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 01/28] test printk: Add very basic struct resource
 tests
Message-ID: <67093b039528_9533f2948f@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com>
 <Zwfr7na62OKIlN8b@pathway.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zwfr7na62OKIlN8b@pathway.suse.cz>
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH2PR11MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 0989c4d9-4973-4f70-5e32-08dcea03f259
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LBzDFekrnWzRalkgIlNrsxmpnuOnitaCiEbxaMVw/U29r7/LS5WuZij/WIqO?=
 =?us-ascii?Q?VRvXuyICfxF8R2+n9Ds8JInhJlVkeYoyRO9PI45n6RQ6W2VjgIU6TCXm++UY?=
 =?us-ascii?Q?GmFvDI6FYUmQt5+Aeyk3ASTDx9OcbEHCLytYrAhlqhErKPWXB+LXpuKbA8Yk?=
 =?us-ascii?Q?RG2xnA9h5A0tBqEyANSYJcviTv7NfNCICGiX2ancsbMQYHKcic4strilKhHw?=
 =?us-ascii?Q?eSNieE+2qtUgBYTpRJPP6mnYM61l8UGx1PKSDcn1Xohvu6gxcHqf/DT8A8u4?=
 =?us-ascii?Q?Kt5YovB1MA1HgJ0Nekk+F0fV/ajQ/SLzzlEWn2+Xrvl3nEL5y2e/oK7rR1iE?=
 =?us-ascii?Q?i7ZYL3P+6TTR8lP6HZ1rUDxybTbdBSRKmEMnw4HRUsXEoPIDPaNo+vNc48VD?=
 =?us-ascii?Q?OZdLsXrSHFxA6CCGGqPD6JbUVcGlKmCGt+gAJs9E6NvTuh57a3xHRmYzpSko?=
 =?us-ascii?Q?BJ3ZpC6LXBATQd1OshFoH0XMn/eJ8hLL/yKEL+6yazefmfg7PlXW0IjxbxgQ?=
 =?us-ascii?Q?crJNn9NGWjW8KacY0vVW+Esxlh8Ggo5ulSy738pdTYVod1KsUcxf2BPv7SIP?=
 =?us-ascii?Q?QXGo+uJcwInCElZtsvSLDgUzCJvxRaWkVBr1Jj2JXiOgTz3dtcU8M5rsoz63?=
 =?us-ascii?Q?AI1V2QOXNS9emkNPIBLEr8FwRhXESSCNvAJccMcnJ/WU2QO3efplR23eKYjl?=
 =?us-ascii?Q?kxeMs7XYM1EGPFk2M2OevmsPHfZs3cLMZc7W9vbsggoF3U5AnOIjwRqbCb8C?=
 =?us-ascii?Q?GW2Q91N5sFwHTONUPdhLCLwo/tpuQJihS/ZMCywICmecVNMDIAJH9m2XS2iA?=
 =?us-ascii?Q?gq6xGq0eWDnAfH3lgHnTdklfHR5jZtEhDpfpwF2u5Ynmpb+55z1w/TPKu51o?=
 =?us-ascii?Q?s6LRbfTPkMDCFU711erhdoCT54Y03/0pXNCPiyK8QQAEWvaxFOGGsza5ogxt?=
 =?us-ascii?Q?CMuNArYdGZTYhS1ik3zraJjoTafFYci8keHX5A2B08/Zc+cbya1OVZM4MauQ?=
 =?us-ascii?Q?O9w+PHLxFpDjXHLQsgLPAm7L+IZbR9BIH5Uh/hKjxDeYSO6N6ro3MoLfc2UW?=
 =?us-ascii?Q?F2HtrE0UoBnVmQgKzKfL5SUqKVxikMGMpElp7Pb2u/4TFVQpIpsT0R6Y+I36?=
 =?us-ascii?Q?WASdbPn19sp4AD91QJNa0E+pjqjs3h9IONiRAu5Eyr67xWjTHxgsyfSE0SND?=
 =?us-ascii?Q?2ZTKykYfyh7PaAHjkgqAwDZ9LQDJcxLKtsF2+IcfS0VuXoVpCU28htp4YIx9?=
 =?us-ascii?Q?NLjX+SJsDOczEgjqGOi7heolpuooGFYafNBOJDis8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RlF8FEAiD5EY7ZauDI4LYKX9kQNt1J7xWJ78IgG/kTZlG11SZ+RkWb1nBBiz?=
 =?us-ascii?Q?+sjjlkkaTh3baF6nelmpSSlKIh/BFnyqNH+giuvk29gdfb5gw0hhpAy77m98?=
 =?us-ascii?Q?bXCafeCtwgDdHSlQsBki+cc/sVq1BeD100VdX4RDhObaBqgtGQpRX7PVPFWQ?=
 =?us-ascii?Q?vC/PxVYc/V0cWSrOUdnqbpIA8WQtF0evs4ulsocS45bPd8Kj7JElksZrldO9?=
 =?us-ascii?Q?WNzHURYcF61tmos7uWKmPLvrT0xb2a/qAJLWS90UkQa8yeMmVqw4Dof2prNu?=
 =?us-ascii?Q?n9ntxgHQOKQgB6LJiNnTc1BR5AwSgqTEaxx8j6CIsCsgKm0zX/oK7ug2kZRa?=
 =?us-ascii?Q?RT9RwzTeYYKAj9udxoWmns9vVB22y5Kv5JILgo7ezQ6I1QM9XLUNLI/5QD1c?=
 =?us-ascii?Q?xQHbiUFlhTWaWcnLUNzbAVnu8ixqshd72x05dBSV/o7v8TdQp35WxgXo7x1e?=
 =?us-ascii?Q?GDJDks2JmMMHZb8trjW4f3JloMvyVtqmYN/H+VKU31VE3ETVMH2rqpiMJur9?=
 =?us-ascii?Q?lslkCWeB54AVNHL4LCFYcel32OINM7dtp5Wks+MwIuLpFR8Z3c7RPTzqn7sP?=
 =?us-ascii?Q?tLClKeJVgn33YozDBb+zzTkhR+XW+35Qg5AxzgniFvqBAMpFoIzfX5nw2llI?=
 =?us-ascii?Q?bYaeky28QRWSN11NqEkOl3E4jKeraM2sEJolEkTkj6ow69pJotu4zJnK8NJI?=
 =?us-ascii?Q?BPmGYUTH5kwv9R+EtkdnWHT0w6XylTFunjzv12felF80cTAFZJFps+Vnb9tT?=
 =?us-ascii?Q?Fxufxp3ah5BjNs2tAQyZT//x0v18TPVQqWyXQv/VqspK2aggfOG88LL2pBdW?=
 =?us-ascii?Q?XWN6K8+SvTJWTAeYnTnPCfv4BzFr7gunTIvJmY6IAnUVEhlh8WpqsEfZLeVK?=
 =?us-ascii?Q?3ye7P9Ed5SIQogZIlMHvDsIXRAcOClp87/IRA8FW6oBZE7xeCXGBRue+GkEq?=
 =?us-ascii?Q?eIGTuwTkFULjtPRrGVxB/4YxpHCxK/c42KGBOmln7k51kDIEGU+4UGcjrtu8?=
 =?us-ascii?Q?2tBgJvo05r7SnYp0ZxkWmUXdYEIriE+l0HTf8EIa2zXO3/A1138yuN7uz7kW?=
 =?us-ascii?Q?9emmB+zHVM0ZFftNIlAcwsfjvKk28v22y0tBYIKkDVQIt2X18UdEe0kzn9/E?=
 =?us-ascii?Q?LaVjSeocSqekJbBJ+gNbI4uMgc+QUCv2BDCNV3WvQHbrPDC8Vc92zhtkQxsq?=
 =?us-ascii?Q?oRNITRsgavdxewrpzEdvbVD/DeU3YpN+C5qQjlbV06Z3Sn7SlO/rKSAvgzhd?=
 =?us-ascii?Q?d4PCRDZNu+BY0h6PFEp3cUtbN52D5Vx9CRKch/SC7zlrixRPo2qDF63KcVvb?=
 =?us-ascii?Q?hUyXJ/WCif9CvD3lD8IdSHOOgIWZF3OAksgQwYwmBD03CQPSzS8w2C3T9VkA?=
 =?us-ascii?Q?1eB709JVnN8LmUH630Htn/1mnzKaswDWg6PcExGRK2534TYd/1AdaNi6ZVl+?=
 =?us-ascii?Q?8GATiUs396XJd1ZUyVZAwCsWxw4eb4nbdMJzcZ+2EruMaXi3TpKKa80pmvzc?=
 =?us-ascii?Q?WjXfQZHygVq/iYwEotQEfPcF099we83iTwGb/XE9mVJrC4h3AN8+Kevwdgv8?=
 =?us-ascii?Q?+5L67GrWfFuEskwWl792OGV4ghVIb89KU/LYGswn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0989c4d9-4973-4f70-5e32-08dcea03f259
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:49:45.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn3nBze9IedBJzM3R4C/zdu0Ul+C48T2oK7MvJhUtx/ozNb0GLCmCplSFPJipXG2Me0bGa3p2M/JoMT91OPKxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8780
X-OriginatorOrg: intel.com

Petr Mladek wrote:
> On Mon 2024-10-07 18:16:07, Ira Weiny wrote:
> > The printk tests for struct resource were stubbed out.  struct range
> > printing will leverage the struct resource implementation.
> > 
> > To prevent regression add some basic sanity tests for struct resource.
> > 
> > To: Petr Mladek <pmladek@suse.com>
> > To: Steven Rostedt <rostedt@goodmis.org>
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > To: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: linux-doc@vger.kernel.org
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Thanks for adding them. They look good:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>

Thanks I've queued them in cxl-next even if this series is not ready by
then.

Ira

