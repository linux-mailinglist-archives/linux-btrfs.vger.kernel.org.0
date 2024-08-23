Return-Path: <linux-btrfs+bounces-7420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25795C318
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 04:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D111C21CEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335B61CF90;
	Fri, 23 Aug 2024 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrHwwfIG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C029406;
	Fri, 23 Aug 2024 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378570; cv=fail; b=cSG2M2KEySE1Id5QE/Fpf5z5YpdE0LsMisoJAXRvzJC3un0nKn6UmHACDBlw90BONZ0TobYTQRfjlN8l8OhIcr9VDY6EGiMF4InVTBt808XqMG0YLWQpeavOE2oL9zk1P7WACzb3I2vTpsA6p7x4X5s/iT/a31llVCk4+MLH5s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378570; c=relaxed/simple;
	bh=g701McdicLVUh7MsqjixghLHqQk+7jHpSdCSyroqM60=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uxuWARmBrackH3KOPqbaeHnPMUlvPN0ovB3qiZy3ooIZ8mDacL64Ih7Ws7zPg1f0JGdIkcyUIb1uCFSWMNbOFdNEOlmUMRhaBUD/phTguh94xiL/qJWhH8FTKhyNtLT8A9zO5u6PmjbbcgaqFgbW9ulINhntafngG5gRn9TceUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrHwwfIG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724378568; x=1755914568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g701McdicLVUh7MsqjixghLHqQk+7jHpSdCSyroqM60=;
  b=QrHwwfIGZi2T/tgKro+Q7d1hetPc9apusBzjajUInNcF03G4mL6xRp7k
   zkM4Ugprm0D/jKXmIzZvnqHK+ge0aybUu4FuNBGzQABlXK2xD4nOixbAc
   +H4ZmhEZpdniR1jxMCqkQDR7O0TTZWFs2RLaEqQP1RjNxfdr88HkxGIQk
   IbFv5mkavYCq8XUzaL2KM2DWClut4xs1JDX6fuABWyXMmysC4Adi97Lt9
   rkp5iWgfLvqTX4MeU6qlHUklNP77wl0JOixFTeBEq9ybM2jwGZQFnLGLZ
   WNHu0MEa3RqRWNALQnYoTJXNiPB1RTTTP6slwKRrscI3fWX0kt7lcTobg
   Q==;
X-CSE-ConnectionGUID: cqFcMFniQJy13ZTfThdWqQ==
X-CSE-MsgGUID: gZmUI+uiQmS0kcla44TGBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33493872"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="33493872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:02:47 -0700
X-CSE-ConnectionGUID: UwEZM//oRNydqexCykl0JQ==
X-CSE-MsgGUID: GS1w8FZMSdO3KlZjLQD0UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="66473171"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 19:02:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:02:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 19:02:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 19:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM0JLG002D6Y+5SNJluBjwqjuXyV5OcocfvbpOCQ/gZYAC3M+iMKekkiatnIQp6w58ZouRaIZC7Uy8oU2JMt5JpR2OUOj7dvnbfqMlGEIX1SixrRvaa57+3pTuHEEQZG1BskP1TH5WmO0CXijxmARPlPigOLidhV38301R6/5b8k6FHORpfHa+XmivEn8hPZIPgdkvd91pSAusmXqpNvGvG5ph2O5o7Y1ckGPSFXMO9fYDUNhqF/aF8hzvuRbFOKrmMew+Gy6Fwhen7LtIGeWgb3jPS4S6iFs0Kbf99IEmFxFYukXWSRXV75GojyENnISKdNteB/x7TdKenOEZoRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXm8X5/VrTQYAYRa8Sb7eNvTW9hFOw9ww41gl910Mm4=;
 b=QY1ODDJ+vFiuQr/j0A8DK+eNxrVBy5sGn4aERgvq+UnJy71q8w2YOXUDw447MlpMm293SMVZ64cq40u5nh/eS1JAN7B5Chpw3EhQjdCPq6GLFSJq7bc+1HV69UK2dro71H3m4GjcJQPRQa7rJWWWthp0GuN/k1yy/L4MupJcHkzvBdW+XJREnNkeBzkZi26LSX9Ph1h2axS3npASWQcqWhRbS1RGOlVwst5+RAClOiY0ehvUGA7W2iQDqz2f6Gdjbl67tg8lqBzR8+a5sAMHF0/jOQey35+gRNLgpd+VRbc1oUlumLH2n2ZIUDNMI/lyc6ZjaXHDu3sP2jHcsqDKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 02:02:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:02:42 +0000
Date: Thu, 22 Aug 2024 21:02:35 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>
CC: <ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, "Josef
 Bacik" <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>, "Li, Ming"
	<ming4.li@intel.com>
Subject: Re: [PATCH v3 06/25] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <66c7edbbbbccb_1719d2942d@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-6-7c9b96cba6d7@intel.com>
 <1ce9afe3-6f24-4471-8a10-5f4ea503e685@intel.com>
 <ZsTL1QQgYjVdfzqj@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsTL1QQgYjVdfzqj@fan>
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c09d37-bd8a-413e-2496-08dcc317ac0a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i3AbNfkRO+Ku9P/1YzUM2v9PdK5UakbBUnJVNziinjG7lMDITDZapSFU68RZ?=
 =?us-ascii?Q?sF/678f6SpLu59YbSx5Vu8cuVcn14ZAf76ZyENvaNhBNH1ZSYcaKGrVaL8zK?=
 =?us-ascii?Q?fte+XlzdpLR4NQujwvzQ0JsA0+SPzP1c71BnIkjYjkkb4s2bkAe1FUDHyQqz?=
 =?us-ascii?Q?3G5DKbbdf+/ynIcl+iT4wMssMcqaN7OU1r5ceNDO2of12+nNqeCaEodpjNYG?=
 =?us-ascii?Q?ZfiVZG7dg7/N7s4IK2At99QpzjNhqlr4XBoPOAjv1qxEPDlvnAt3u99nVJi6?=
 =?us-ascii?Q?rhKgI2xDSzbJsBWCB+b0M9Qp+vApJkupkzmJNUusmCl19qLwZhZrhZXAoWUd?=
 =?us-ascii?Q?P2hktElqMjBiTW7tw1s9L4LMyXYnB0psEcLPrglycmhzjcc7qQco5MIv3dBz?=
 =?us-ascii?Q?GoaA1p0zbPzAsCXmO1AiqSXTwK2Rgn5AOPUBv+jbyr39hJH3n5KOKM9L1qcY?=
 =?us-ascii?Q?kFMNQkMbxOfnN4Sqai2LaYgIuvzCm7grD3p6Lat26iM48UP+2eaKOl5fLyLi?=
 =?us-ascii?Q?zzRU3x7Mn2vKdUYVXhJGoU+kyq6se8N/bMdUTyfYl15t5+iw8aUjGKZDKAS+?=
 =?us-ascii?Q?PGr8XEBoSqPJ4qzURWofi/xphPtMZfDxk5n7VXL2zdxRZl9JvYciKylfSWN7?=
 =?us-ascii?Q?gr3jpiY7sg1V018TIRbqW9y3o9yLQinQbLIAihhdKQPFWzLPYTT75zdVkLnL?=
 =?us-ascii?Q?41+8SCBdGX+/yFlxYuyFJlCmVfCKrWp+cRYWoHUq8AC9wSknDNpR1801fD9p?=
 =?us-ascii?Q?K08E6WPIGnpfb51kIGVEHWXZcQNv0t1hgXJLH0ARyDrzgtngRUNZ0Tk1KiZZ?=
 =?us-ascii?Q?GkrW/vcZYHWj+SajebpjZ2TdrXdXLhkUDKDB7U+P/a3LtAJeUMXJZKtEffAy?=
 =?us-ascii?Q?QrB7GFsFinZVnkMpv1CfEVoTpFZA6LCf5NTeTsLFcvq4EUNAAhHROdtpSPDd?=
 =?us-ascii?Q?2XSbqDDJ08ATzgSqPKHG9vUrUwwP+5GDPO6wP8RhLtzxbgKRd26LjMlZvaEs?=
 =?us-ascii?Q?Ftyyz7RU6y6UagTrBUyqA2joTvNk/eFVerIrziOB7GGRqlahIaAweRBIC7Tx?=
 =?us-ascii?Q?QzFrcPKKfVwgSi+8WgtS/CkQs4wMLJQtyFKO+VOjvx9VipaHyP8KI/sRnGBq?=
 =?us-ascii?Q?8mYqmEfA9ltdruRgZ0aR3GI7WuonTDQvyMhUlmIOjHS+qMII9Nkd1k4qRmD8?=
 =?us-ascii?Q?wAUBJp/Jk1X0ISMyUmaBfQBjrlvsTL3ac127e+ML92j3WVgQ4OfF53kx1MTe?=
 =?us-ascii?Q?Y3802bW2CtyOQjVZtIyPszN7DM/lYDdfJNRTWJ1Plhog5/laBCqOLusFDM5q?=
 =?us-ascii?Q?gb7Fj6cEWS0gO/J3MJtUlgUbR4dygs9XJ+cMzdUvEgXedw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Kjm5iK8+FX7xPENpIC/HZs56NkX/TgPyZm3Kb8VnFeJ/k/rjQvnqrU7hWIV?=
 =?us-ascii?Q?OAT3XhtYm0TyRBwc+HW7UcssJ46L5Y0PdqEE0a9lMJlZPvlj/Lrsr38bqRgr?=
 =?us-ascii?Q?dxS/GOU4A4flqRBDGHKL424ijCZO95bbgRnGDhVGh2nQt5LoAo/QgDw8otFF?=
 =?us-ascii?Q?dRIfBhrk/oLigNu/lVHife4E4GSpdloOMSh0dCAQQS7WNgYSJ9o3lAM4n7dz?=
 =?us-ascii?Q?yMS2sBw//tGLTJdFO/opBk3F6NeQ9ZR6f5phCcoOQBCD2XM1gAzH2TawnVTT?=
 =?us-ascii?Q?xJhZsdkak/D8Z0Odr2h/UKBnk/uxc9OHPv1Mo3EhMzVKi/6llKVJb947t2Wk?=
 =?us-ascii?Q?b+2ut68dXBs7ZX/sWorR6gdtKyHA1aXqWmsEQUl0FZr4CW2Q+Q9V91GTBHZT?=
 =?us-ascii?Q?ruBKqI0lY8EQf2qAsbjnuUGc31TpRMupPWPW3m6bzn4qvRKasCpTYwiMH2bf?=
 =?us-ascii?Q?5OKd8L9G9peakFzy5/gNg1R6uWBaBZwX77bLSdLm63Sqofls4c2B7C4t66c7?=
 =?us-ascii?Q?uUCiLQ4jJNqMCC2qd7QGks9OMtKFCJfsjHra4bqY1jOBZOZhCbAcrWU1XUzm?=
 =?us-ascii?Q?oGPDSJiekyqXeiEjpyLUniexRAcH5wBBEpZqS1IuNBMPGymCLhPFcwzHoQPl?=
 =?us-ascii?Q?py53/bcmoBf8BTTvjzJvk4bZeEw/bLbBoqZmSYqtiAvxjr+dZKaH/7V6el8L?=
 =?us-ascii?Q?+hZE0ADn57TCohC+pNGGzFtQKuhN1i5DqRFSOezRQ56G2LdDTl6Ad4B7k6VU?=
 =?us-ascii?Q?Pxjpny4biUmRqrAIj5YXbOO2mIlnW58IltkjsuLau0hA6xer30xWTLgAkq/1?=
 =?us-ascii?Q?h4Sw7QYkrQcDC2DrRwdnUB4fRLwL/z1+pIAKCJ0D4H3pC+XeQ0SeEmSZMKUw?=
 =?us-ascii?Q?VjDzJsKut9VA7NHJnVs3W/oitKhbolKvr4pnJxjNtaVIB0/UCRgZCT1OUNgU?=
 =?us-ascii?Q?t3HtgHJSNkkHqjSUZHBAUFW2mSGLSSgpnFzO3Pn8GWCB3E0Hpc8oWs69Jc5W?=
 =?us-ascii?Q?JI6Ku0G1xHxKlTv+Y7bQx0PXVV49umqGmYc385EgD/g1RECkgVdUgUlCguMo?=
 =?us-ascii?Q?EimTUBA3eOyFSG5Q9mbHHERDgstOQ4ucuzIdbEWefSsWdq+t4uJffYISXpfp?=
 =?us-ascii?Q?DDLet/Zf9f49CEfpPDdq6eWKeS4B+ZGYq+0qMaq6Vnu6jzI+/8iL3tOpSsCg?=
 =?us-ascii?Q?I6nWe6qq+Grnn9HW+/ZXkltNnMerrvCcUP+elKQLSmOJn9HihG8AiH3Ixjgq?=
 =?us-ascii?Q?VQAdGrsdXRPbjqF+FYllLcVqvqZ27cm5jNtnPB9YXSMG1zJmhFPGr4ba9TaF?=
 =?us-ascii?Q?xT4D7o4VKFsClHauUUA4qCeSTqv2IfheiqstmfDUoU6vyk8vP8eVTnYltQQb?=
 =?us-ascii?Q?gB3A1Feq8cwzqjVZyXHKed2PNxUFLZzxDs4QL6YE3jTVoqPkGOBttZAVV3xZ?=
 =?us-ascii?Q?RaHe+MRkvYry7CKShksyNovSnmzNDCrpy2GWHYkPMzhaJF77hYik5WufLamf?=
 =?us-ascii?Q?3YtAShldG0SnCkSx+InddivSLnl5AFhjgURkGmZat+OEbV293oIsp/0GVrVt?=
 =?us-ascii?Q?bmGyjUenoFQvvw586Q0Icq2ieZo65CrRf7D2XZr0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c09d37-bd8a-413e-2496-08dcc317ac0a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:02:41.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtAFdsyie08e4BUfplw35zxIeEftX8/h2Au9KLHQCzr2U43Btwx55Yhd/ly9BVWwY8NZe4WkRyGTeQlofv+mEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Fri, Aug 16, 2024 at 02:45:47PM -0700, Dave Jiang wrote:

[snip]

> > > +
> > > +/**
> > > + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> > > + *					 information from the device.
> > > + * @mds: The memory device state
> > > + *
> > > + * Read Dynamic Capacity information from the device and populate the state
> > > + * structures for later use.
> > > + *
> > > + * Return: 0 if identify was executed successfully, -ERRNO on error.
> > > + */
> > > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > > +{
> > > +	size_t dc_resp_size = mds->payload_size;
> > > +	struct device *dev = mds->cxlds.dev;
> > > +	u8 start_region, i;
> > > +
> > > +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> > > +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> > > +
> > > +	if (!cxl_dcd_supported(mds)) {
> > > +		dev_dbg(dev, "DCD not supported\n");
> > > +		return 0;
> > > +	}
> > 
> > This should happen before you pre-format the name string? I would assume that if DCD is not supported then the dcd name sysfs attribs would be not be visible?
> > 

No this string is not used for sysfs.  It is used to label the dpa
resources...  That said in review I don't recall why it was necessary to
add the '<nil>' to them by default.  I'm actually going to remove that and
continue testing and if I recall where this was showing up I might add it
back in.

> > > +
> > > +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
> > > +					kvmalloc(dc_resp_size, GFP_KERNEL);
> > > +	if (!dc_resp)
> > > +		return -ENOMEM;
> > > +
> > > +	start_region = 0;
> > > +	do {
> > > +		int rc, j;
> > > +
> > > +		rc = cxl_get_dc_config(mds, start_region, dc_resp, dc_resp_size);
> > > +		if (rc < 0) {
> > > +			dev_dbg(dev, "Failed to get DC config: %d\n", rc);
> > > +			return rc;
> > > +		}
> > > +
> > > +		mds->nr_dc_region += rc;
> > > +
> > > +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> > > +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> > > +				mds->nr_dc_region);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		for (i = start_region, j = 0; i < mds->nr_dc_region; i++, j++) {
> > 
> > This should be 'j < mds->nr_dc_region'? Otherwise if your start region say is '3' and you have '2' DC regions, you never enter the loop. Or does that not happen? I also wonder if you need to check if 'start_region + mds->nr_dc_region > CXL_MAX_DC_REGION'.
> > 
> That can not happen, start_region was updated to the number of regions
> has returned till now (not counting the current call), while
> nr_dc_region is the total number of regions returned till now (including
> the current call) as we update it above, so start_region should never be larger
> than nr_dc_region.

Yep.

> 
> > > +			rc = cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> > > +			if (rc) {
> > > +				dev_dbg(dev, "Failed to save region info: %d\n", rc);
> 
> I am not sure why we sometimes use dev_err and sometimes we use dev_dbg
> here, if dcd is supported, error from getting dc configuration is an
> error to me.

We are trying to reduce the dev_err() use.  cxl_dc_save_region_info() has
dev_err() which is much more specific as to the error.  At worse this is
just redundant as a debug.

I'll remove it because the debug output is pretty verbose too.

Ira

> 
> Fan

[snip]

