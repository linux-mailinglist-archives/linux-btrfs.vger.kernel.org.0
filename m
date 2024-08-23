Return-Path: <linux-btrfs+bounces-7425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565095C37F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 04:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06A3284643
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ECB347A2;
	Fri, 23 Aug 2024 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5uK4xdS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392D28DA5;
	Fri, 23 Aug 2024 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381895; cv=fail; b=XvD7AbX40r2gDhHsQIE0UxCVyTzCxSTDZbCuk7J18AD3qgFNHM04jtD9MkmiCzGfyjNrdVXebGKbAAswU55CzaSn+oDyFGJxdVBRelmw6o4jIzYFW6rIX9O3rbMZvJFom6NFG+pw6u1IYe6RLHIXLpqVwsslMx0s4e4HiqYBPQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381895; c=relaxed/simple;
	bh=4+NIU+JBfef5mNXzOZTHzC06QC9sBLRFNz9SXv19SP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P5M54ELvTqRSP3nn9Vd/t8adpF5FDup9XtaA72tQdbhvfgOnL5M94jB4zHBZoJooptmiCiRHqjaG3+YNZxr0nFZHVNgcZYbI98SsVN2BDRIJJqIXPkkW+LLr/bpTAIiup4Qdk1iu3vq+R2g1m77rXP3Sn51+M/f9CAOvAlopW/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5uK4xdS; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724381893; x=1755917893;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4+NIU+JBfef5mNXzOZTHzC06QC9sBLRFNz9SXv19SP8=;
  b=D5uK4xdS4dTDLnbkVi+PAI/Io0verRYm0q9FAnbdQ8RVpNvwYL6LrwZX
   nY02KIhX6lfbC9b36Tk6pNB4I+d/edTK8Fem5HJcTL0eiW5imQGQaf9On
   L8JHZZyKyQ3ai4vX/4WXEPyt8IvQbFBTAuFA5WZ7rDibTJ3akSb9sg2Ky
   PGzVOfIPdwqJFnMDSRxfKhbCRnyUXDwN/pnlpSrzG15x64IbbgYDULkQz
   usa5/yLZ+2GpslhqueyEVLzuz/wVC+t6yRKrHyVsQaxgqcfxLTdD8GMSD
   Fp49H0m0hlJPLF8VviXlGVTRLf6aROBLWb1DIdhQ7mAUi92opg4d/Fs0I
   Q==;
X-CSE-ConnectionGUID: 8zKLmEctSWyh97429iU5rA==
X-CSE-MsgGUID: Jq8tmyuhQGKtQfrvtXk0GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22697835"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22697835"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:58:13 -0700
X-CSE-ConnectionGUID: +OGIyV1oQQykR+K8dmEaqA==
X-CSE-MsgGUID: 6H2f9ThaTxebql3ChZwa7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="62386070"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 19:58:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:58:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:58:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 19:58:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 19:58:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klNmAj9kv17SEwTXz74Jprw7abNri1Bc78rj+Tszg2IydAl92j/ubZFPo0pzbfNdNclrByAba6iObUOxaEIUGNfDJsNiWJLyiLPrM5FghGtce+0CY+5R2yHwa0jx6Nrki0cH5AyxIZX9dL8dlnipaQdD5zEMf5XiZ8TLY1fQNhTTD7HsdH5xD5FH5YMbtSFe753WZHzb8vuB0XI/06LDfK9CcW1fkuuOTar2cjP1QcBpaB0je6arjOqgEeijxBrueso5MqbY6vwd2wg8SZzf7xTh+RIO0cMu0s9eDydAW42EvVxVu+rMWwKMFQr3hzgU7ATCdB8rZ32w7gv+eRa88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPudyF37UKT79T0u40tizkuUt+kTrRdV9po/FqcHkek=;
 b=gazNjoXqBlEAmBdXBsYOoku/bfVtsPRHHh+6qaU6hyaxv8KpQl6k6XrRylzGmJSWTywwwfcmrB8EsxtTbbDq8i3ICRloaAjtkA4XtmniY88OJgMSBcJRZkcNXBf02Sd38uzvgG0dqbT7ejKoMFm83PjD/FjFCnLm8MZtIW5iZ0S5gfhaHPKyNcHpztZa9khgmkvK7M0rWtJf1MKaI2WE78k9PUepPpZyABg2OL5ArAjqEIcFPdeuDnJ6e0kJiuBR6e8947Baz/4OilGb9Flgtshikfi0fIv9bRQ/BE/eHXNlc0oXMEXZoYSsXfYQWMUx1GElp8TSorLfi/daorBOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 02:58:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:58:08 +0000
Date: Thu, 22 Aug 2024 21:58:02 -0500
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
Subject: Re: [PATCH v3 19/25] cxl/region/extent: Expose region extent
 information in sysfs
Message-ID: <66c7faba90d0a_1719d294b@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-19-7c9b96cba6d7@intel.com>
 <63cfd343-763e-4f7a-a1cc-857927a7282c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63cfd343-763e-4f7a-a1cc-857927a7282c@intel.com>
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: f818c646-f204-4be1-1a5a-08dcc31f6ae9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tr8iMfpMVQ1J3z6dpchDYq+Lv0uRnATmb51P0v22t8H98jLJtCEgtgXHtha+?=
 =?us-ascii?Q?ihwD+bWQyjHDrqOy67dSicOz063qjdj08gKOaGYZeCzZ/wxb9IuO/6uFqv3f?=
 =?us-ascii?Q?7v35/+Pb6nZqfRCG/jxJFtG/68U9oUnHBTFHKWKmc2d+fy1fSlTpwDCLO8NA?=
 =?us-ascii?Q?6gCWnepm5tJPEiJZvG1URa//eePoctTmm6ixHmLSztcw6COJYslKfI4o78oX?=
 =?us-ascii?Q?H9fQFWpA8Pvm7BYPNo771qI9hTduwOZn2vLcfnn7AVEhGtPfJhYKKOzRWDc5?=
 =?us-ascii?Q?xOYOS6igUIGvSCt/rBhjrzTiCkEpzAb3A68I6aEDPOS8v+q2Xm0NUxFuBkca?=
 =?us-ascii?Q?OpWSuc+cLD4o9+hcMCmhdrJhi8Rw/4IbrqZ0WmChR2po5zxcIIsuBojAWfhK?=
 =?us-ascii?Q?JOk9YUJHBk00k822RD82YkGHm3XlS3ApkvidZZu+v7uDw16L4vWDk8vjsBL7?=
 =?us-ascii?Q?PEItpEhQtgd9Xc25F0ajawD2Pedcs5fR/WYOXnat1rfeCdpEbkkjYTC/Qj9n?=
 =?us-ascii?Q?KLhF4NcrsoNeBJ1bEMPrps+aY5/lwNW/fy7aaeU9LXctLOoALo73fPiYMeKv?=
 =?us-ascii?Q?bEM1VeDd2wdeJkL8zmDFm6xjqAIO4l8LtnxnXF2a/qvR+7Adv7WE448TkwiJ?=
 =?us-ascii?Q?r00TuBE+spTa5Xl3rNXXjMfQBAXoSsq9XZmPdQQroH3VdV82SyFLSDCPv9FQ?=
 =?us-ascii?Q?vE2s5hVjZDRavOvBTnBOGcFRFeJvlFOeXY669xNYivc1yVhb4Q7ZZM6rHvZ2?=
 =?us-ascii?Q?CJ+JZdX2QZguZM6RpsdapU9kcYeNFmoSriKUrA4NWAd+q51EEsvnyL+OGIbp?=
 =?us-ascii?Q?6FgGzxOaJhlxVzDGYBPiPRYhTixeH3Qi8v2yHCbSyJNDRkn5cuuDUvOi5umY?=
 =?us-ascii?Q?C+dJHwbvTQ1qMypRz7sdfMFtiMDk3ESW7FgGyEMKORCukuUKgiE94GHjlw0t?=
 =?us-ascii?Q?V9PL8cecAg6X0sdvLsFYuvwe/6tolvB1WC5/KROzO53DqwV/ffOF+SipnjO0?=
 =?us-ascii?Q?T0XThuY3CJ+Hg58NknNSsdaO0ePW7HG6gL6Zps7hACcTeZOFETmhUBaSEj+b?=
 =?us-ascii?Q?cjMzUXYYih8rewSihLWrNvUKymSwPqk9k3T2W5ycanEGcIe/C9wZ5DpCaPif?=
 =?us-ascii?Q?q25Z0m2PwSyZSXIBt24lC+6eWY1EHD9nWcNRfDDOySD+3J9segAW0bTqDdFS?=
 =?us-ascii?Q?+mbBy1IWfd2Ozb4VG6GBToynZH6X3IQYqhZHyhWWFNWlMjQ7VrKfkrFO02cB?=
 =?us-ascii?Q?5q+K+kYa4ejhNisIMW0waOVVR501Dl3TfdcS2Ovx1ZppIT2Y0pyOP0SwA2Gb?=
 =?us-ascii?Q?vET1S81BzwVAESgRFmcpkhB/wndIHkmSZ+ZZPpQ4XXTMPaTDjmJI/0UwwpDb?=
 =?us-ascii?Q?NWAxE4Q7Duu5khoQ9T9MdtxWXPcM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xv4DBb3Xx3V3H3XxHKg3K0zIZyzkl6ZIGW7wdn4Tw26CLK6UbLs7dNbr6u2d?=
 =?us-ascii?Q?90Q/pun5Wr7Ah+scZFgk+sMvPhQNtY28A6UUmAUELEUBIreTt/O1T//720wN?=
 =?us-ascii?Q?HnJ/NKwtvTgS7kCmzk9Kd6i+TT8Lhwz+12XAQwNfe9bQ14jpkb4Hp3xqD0xP?=
 =?us-ascii?Q?dtR7kBcNiTDcR/jb3z/DAWCbhBPVZYTUnO+3iI28Pg0AD2GmDTvDEeozRuUe?=
 =?us-ascii?Q?kwUumaFho8EWsvVeH9EAimOkf+ru2DW63Ms567y7RsRPwz0DlAhNMPezgQaV?=
 =?us-ascii?Q?TpqVtJqmPazZgt0XQL/i4wGra8Hn4RmiHqXnxIxhftXzUrLm72NtrkBvHLKE?=
 =?us-ascii?Q?T0AHIYZaF5+2CmhBQ0tS4XKv809h7J/sqVQXmfyDxk8KHXaDL/UE5bW74HGc?=
 =?us-ascii?Q?4eD2R1KVHhihsHb2UhaJVyaMnD7EcIE3tYdVRH/WSVO8wI94txnucSo6igke?=
 =?us-ascii?Q?efSbzclHqv9zh+m9cQ8hQWMV7RppwV+uiTCQGpEpuBlGsOzJ2SjklYY6ahEO?=
 =?us-ascii?Q?QNs/RBCe90csCi9rGIuoMNyw8pDrSPnXmTlmwBUL7aFDB9q3o15ZkyctcIqI?=
 =?us-ascii?Q?Cl8CuZ0Zllr81QSfK6YcBN2U3KUXcMkPIlAEULXHQ/jF5IrvdRbyn9y17NxK?=
 =?us-ascii?Q?X8kOdkqAOTHUo2DBJ3hEnhxj6tmHN31zSZjzX2U3nJCjove1xYk0kddO/0zJ?=
 =?us-ascii?Q?TG+IJhNEdFHw1eYr8m+6+88jnizvMe0aUI2OBrrYJ/111QNfOUO8Arf9vfgT?=
 =?us-ascii?Q?n060b4cuJjwDkSEzXUzKIGQ+bxn2lrd/BdAZgnyBn0fv9gq27DCtv2qbiM+6?=
 =?us-ascii?Q?cTWUDnEreagcUFYY68/bkS6s63IRpzARpYY0R6gxAJrUlnNLbi/3gPShM5gb?=
 =?us-ascii?Q?Snk85/ehj6W2z+0UfdfImAryviiebfV+zV5WkEkHTvjD9FwjjpGjj1sDKwwi?=
 =?us-ascii?Q?GL3aZvdPJZ+83Tio0+CUh29mkskVBOIkysWipsSA98MDh8FyK8kPbJMD7PN2?=
 =?us-ascii?Q?1NakL6amc8WUe+uotVfmj5Ab+cmVNwlgjkxtukDaNst6ZTOcX0n5dd1jGjz1?=
 =?us-ascii?Q?QI8WgsYfEbdyMQ5I8iQLZ1zoGsp40tlnNLnVvju2zTP2IK4r/NbPk+UyAf68?=
 =?us-ascii?Q?L+WZhYIj3d3KDrAbxw1TKVoMT1JR/HgV1VTZgAzmcjqwhX+lNfuYte8rtUDd?=
 =?us-ascii?Q?Zd6f/SOQjt3Ns9ZCTyMmy5qJv6R8SnrmlGUIdSDw8WQ/6E7vUWJIddgfoRhs?=
 =?us-ascii?Q?Cq0oILGTd4GwhVvhMxW9c+7QjgxFAHlaV6tPjDnU5xYQPFS4uz2UVwdcnF9R?=
 =?us-ascii?Q?brWwxYX9imPSgQ8QE5ec0ZO51kF6sYZfGZo59d1PKe+98iXAxTcPufmNn6cQ?=
 =?us-ascii?Q?2t1jbaHu2CK1HbP+Y60Wj/UcUbBva9vSV4C5XVd6BPYaeRA9GLK1BT6l1LwP?=
 =?us-ascii?Q?+iGhOby33bK3UYcIKNOpksuxOGuD6wNq80uknE4YCZvxJcLdAOjgMaHcUc4F?=
 =?us-ascii?Q?NXKL23P3a5zZDfcBmk6ZhzpGrTWYnizGBHkTdsD8ErkvwC3tqncJERVqAZJn?=
 =?us-ascii?Q?g4h+IaFW82+0GaSrgRh3J46qgITVqcxxYz4rB7Xr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f818c646-f204-4be1-1a5a-08dcc31f6ae9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:58:08.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTv/IsTnDavPR1vgVUkHzrsbf2OuW9HC0kED4oqGIP/u2NF+PP1JNUYbEBVBay82/x5GbRqc+E0Gn+IJj47lFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Extent information can be helpful to the user to coordinate memory usage
> > with the external orchestrator and FM.
> > 
> > Expose the details of region extents by creating the following
> > sysfs entries.
> > 
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> >         /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes:
> > [iweiny: split this out]
> > [Jonathan: add documentation for extent sysfs]
> > [Jonathan/djbw: s/label/tag]
> > [Jonathan/djbw: treat tag as uuid]
> > [djbw: use __ATTRIBUTE_GROUPS]
> > [djbw: make tag invisible if it is empty]
> > [djbw/iweiny: use conventional id names for extents; extentX.Y]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 13 ++++++++
> >  drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++++++++++
> >  2 files changed, 71 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 3a5ee88e551b..e97e6a73c960 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -599,3 +599,16 @@ Description:
> >  		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
> >  		the number to the closest initiator and access1 provides the
> >  		number to the closest CPU.
> > +
> > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> > +		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> > +		/sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
> 
> I wonder consider an entry for each with their own descriptions, which seems to be the standard practice.

:-/  Except kind of for the access'.

What:           /sys/bus/cxl/devices/regionZ/accessY/read_bandwidth
                /sys/bus/cxl/devices/regionZ/accessY/write_banwidth

What:           /sys/bus/cxl/devices/regionZ/accessY/read_latency
                /sys/bus/cxl/devices/regionZ/accessY/write_latency

But I think you have a point.

Ira

> 
> DJ
> 

[snip]

