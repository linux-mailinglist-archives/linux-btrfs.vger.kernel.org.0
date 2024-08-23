Return-Path: <linux-btrfs+bounces-7464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55595D888
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 23:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F941F2446C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C81C825B;
	Fri, 23 Aug 2024 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVkRuTKe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E21C8232;
	Fri, 23 Aug 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448726; cv=fail; b=k0F6vxHEvZ/Axh+P65GJP14f8We1MF0C6uVWN1192gQ38lcoWQgEe9cxwEHG98TDbzBR0gq2chvYF5TkBmwFlm28ONf9Be/TgS+k9lkIYuuJXjjBkhnpLaeZU5fMjAzB7fenKOhy6ZP5+yoi1+X8eDcwBwLUe9Xk3WV/1Xih6F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448726; c=relaxed/simple;
	bh=EVcJylAOWDFP0SFTYB5uGS1w65llExoAg5+sQaov1Z4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NoYknHpE2hyTGJse88COWTgDGXTqiBIme/6QFJDT4ZRFrvTnmLXclx1Ebrzc3OJU8jy/8vVBuzZ+v0aP09ZUe2uKuwr58U9d9ZqiHvbAtarrKItuL96SlyaKJTh2KD2R1q3E3/83tDR08fGZRefOK0dlmrbztxfXPIxoH/owXII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVkRuTKe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724448725; x=1755984725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EVcJylAOWDFP0SFTYB5uGS1w65llExoAg5+sQaov1Z4=;
  b=ZVkRuTKecSjGYo9luG2+9ifYAgeyGijszwKhcz88YFPpIkzbImoyyfBi
   chchHnlUvCuEjHg6hX/+6cAjs9pyYrIO5WSrMh6VfoOP7vMloHpQLW6zX
   UzUnRWw6Y7vIbZBU6/HesecCc2nPWMT+4WbDgWWNubH4yEPUtDlSIAR7n
   Q6IcEW5Rtf9pKQPUXCxKVnaDSiageZskQUlZhljPQgZjfGUgzO7hn1IgO
   oC20ZruhCC0Q+UtholSEmlfAYtsv/5el92+k/QjZqlPuTvNVTLJZdXzT9
   h+MfQnnfAxpHgXvVpIFAML48jGFoTjRpyUC151JbHVjNgpW/hL2zyRxE8
   A==;
X-CSE-ConnectionGUID: zuHEKEIzS1mx6qOH1qd2QA==
X-CSE-MsgGUID: /umHGV6fT7a8pEVXlEogRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33499879"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33499879"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 14:32:04 -0700
X-CSE-ConnectionGUID: EFmweCUtTUeTX/sEHW+jXA==
X-CSE-MsgGUID: X/yjxwq5SWeg7lsyoqdSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61776511"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 14:32:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 14:32:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 14:32:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 14:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuSXL3azyeNwLEP7vp3Dr5t0zs973XyfZIdMkEIIQwgFRXe2MZNDh/01OCy2neuzv8UHaCc6U36cB5dp5t3/c/wJmLh2//kfZy59F31VnWcmZovxag6qURZQuZtFNoT/vsjd7uU8vHtnMV4+6meDWfQthhsZGV8qyrZov7htJfNEpTmZRxk+42jpuHTmnqUloff4pQmEEv90UQUR4tjLr8ULkpQJuUmn0YAV7dhL82rMO4OW0OD3BZxfddprfGim33TE3G7jtj3AFRTUP/pjkC3hRs13dzVNu2HhUKRFqtGK0fW3bHWw67yXUvZkGmxBrE/Cxj0XpxlzK6GFTvZd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYD0It5i29TWhFX6yNUKTaD2B/t8Uo/M3ePeLHCb0E0=;
 b=eVR9yKpnua6lwDkF9ZI4VmfPmtUcEoxbinfMMS1KFL7DryvBLE0TMUanFcIKuc4AKZBbKlW/n4yz5CkfeczzTZWg8fLDE+yo/e4Ae9iBW5JfdqUXjKjBFW0nPYEIo5MUf1D8SDzPLPmoytPreLPwW/UiqEX+HGHlNrkF9zVgmdeN2fZzwnZCaNcm25gw0OjrvPeJWLkIL5DmWpddGA75NMq0EW/9+l5VH7MIYaJWGAEw80t2c+iTyLPMAoqrv8uV8YmAsjp87wnMDdZ8b4ySvjOLVKGymZUyAFVCqfXK6LN0x35Gk7W7Zrh7lo00AIFILg1FiS0Hmp1FjQuA0oXZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 21:31:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 21:31:59 +0000
Date: Fri, 23 Aug 2024 16:31:52 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 22/25] cxl/region: Read existing extents on region
 creation
Message-ID: <66c8ffc8985ea_a4ea22949a@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-22-7c9b96cba6d7@intel.com>
 <2e753a02-fc62-4b11-8a4c-e23ab1824d44@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e753a02-fc62-4b11-8a4c-e23ab1824d44@intel.com>
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee20120-165c-488e-0b9c-08dcc3bb0523
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h4ybPX0/aK4Uj6TxXC+ZP3MZCCDLbniZcbhwnSns/uSPyXhsrJeKslOIgihs?=
 =?us-ascii?Q?MsvhPxF3jhHaYondm7HK0LxvgzSUaNjCJy0xFxQFoy1Sv7LaymvPAt/nLaoE?=
 =?us-ascii?Q?N6MX0p2Hwh+KmwGb6R9F6CNnkVUfSRDXQHUtlpXTAAYKoACXxR1tNHcwrh/s?=
 =?us-ascii?Q?bwPQB4CWZeThD19t4tzZIbULFjJ2qn9jjK2jv+ItPUoh7vK0VGuEdO9pwrGk?=
 =?us-ascii?Q?WwO2P4r8OAXYgn++t6FqamL88/GSGTgwJMUcFQOhKjJIK9wuQwuUN971R/cc?=
 =?us-ascii?Q?EDL/3EGMVhd3YJUaunMKVd12aDDVWHqhDHJRrtecRMVq1embKXc4CQ+mRiVY?=
 =?us-ascii?Q?cN72+2S7PB/Ha3GZKY7r8gT8uzgUxFHYYxIzwaIBzQDGbRVczdO8dzrNXpZn?=
 =?us-ascii?Q?KCQFpgsPWyMkE2+c1bME9UAajvDHSkNzY40J+minUe0kIKZcDRJ21H0Csfyp?=
 =?us-ascii?Q?Vb4TFKiTwk7mEZSzUPbc0DYgW37hL6Oqbm8fSN2pfyRHj7ty0q1iWvZus6oK?=
 =?us-ascii?Q?Qc3JtgFC6jVhXE4L4oVguLhIBFx9UwhMeftCFBQI91f1SdPhG6f7bO5Uf3GU?=
 =?us-ascii?Q?ZCWDwoaKLJwKcZsXHRDY+hqVurnDy3B2jVUQEs0/1kHSwc4fjK+9Os5mtbG3?=
 =?us-ascii?Q?Ary+MaycdU6YYgmGSXd5TSTlOl8XdJ9q3MgESgWicaSpQz5OhXpAwkY1kTl7?=
 =?us-ascii?Q?LiRvFCEYAdodH37AdiA26hCw2n7mWBOZDIaJ8eUgC9MW9qRgMWZ0nRmL9a2K?=
 =?us-ascii?Q?lXmXJkXU02nLm865HY32MX04NiTnuB87rbVKi51HONhwpHSxxv77abGRvzW8?=
 =?us-ascii?Q?bTwZ6HkiAM3ot3R4aXmg532cveWZcMFCnqgvZwKvGnLyqdC7EhKdL6g62c4J?=
 =?us-ascii?Q?liPOPZQ49ht/zDuUu+1JvU1WGk91ntHA3drKMc2yXaWKKbuAl45+iWxgecu4?=
 =?us-ascii?Q?iSmlgo4sL/jrMOGpLzWfaqFMudBLs/SreacxyFEYPb6XD2ixy/Mku3LDokSg?=
 =?us-ascii?Q?8g9PFfqDc2XvMxkWcO1HutAdYMuvb/wsd8nqU+qtvHcrxo9nto/yUPGDse96?=
 =?us-ascii?Q?OEJmb5msCCowwekjTCkfriNHFBryX5g7EC4dDtWmLB962+yJE1oPBIPv724f?=
 =?us-ascii?Q?Oi5RHk2HtrdeEkyvpoGmub4B1q37M7JYCS+rAeri1boDZojCzwYujU8X1KAW?=
 =?us-ascii?Q?LUowQ8GIIX3x5FL8cHisXLnW7Q/QTxWL1tzPP6WMk4uly7wn3jyort6CDMw5?=
 =?us-ascii?Q?XTqVqpLUcgjXhU4wViKXye1hYfWZ0RAIA2g9wUkWEIOwT0UTtXlUR+MI85lV?=
 =?us-ascii?Q?Mgxuww5zp7buf5ewkEYhmOUvzOk3in/LJKWQT4h6f9hnc5W2Bj1liJt3WDeM?=
 =?us-ascii?Q?UXLBjJjjzaAo5X414y1+Dt8RA2kJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+J76Vxkbsx6uQSKToRb4lzfJKKhbGD6jWceDqfOJ+QSNKRcoC1rkhyNwI0+?=
 =?us-ascii?Q?hWg+iUfeshcWBx6owyoX42ikXNE/efrCscbmFqgtWYhgawgjRgeI0y/aK6Sj?=
 =?us-ascii?Q?TNpBzkmvNGUpE6/URh6wjiyyCml6x+vFcTpP+5HRTIWczcRK72LkP2jnyxcF?=
 =?us-ascii?Q?9MBYxLFFadNb45TSXnqEgQIZCKwCOvPGBs5bMIm6avEWh2aybZP2L9f2nD66?=
 =?us-ascii?Q?ayLh3m3M7l+accTI1OtJD0K2mJh7mWZ44R1Ym+gO8vw5TBntGN+67p9KzwSd?=
 =?us-ascii?Q?fjxB+qQzYLbZSbWwajDMgD9w9gdSM/BUNVAcQdRujHEqRfH81lh7f8bD7Cc8?=
 =?us-ascii?Q?53jneFgXR7cz9ju544YGJOyEzhdczsktMw3nyVIQThQPmvA+DjKXT0NyQL6i?=
 =?us-ascii?Q?n8czulDOUVyOsW23WWX+T4ZRG6+4FWbRU8chKAd+uTajw8yRvt5+WzX37iyq?=
 =?us-ascii?Q?Ya2j6xBtH9ru9/A8jV0jDYOvP1cUAghyif/rv8X4VOXu3x279SMTI3Gl7lbn?=
 =?us-ascii?Q?b68vhTQFQvGGWPfvY2G0i0CnueZlKXuqXu2DbIFpUeh8kW4WD+guwbqwNmW0?=
 =?us-ascii?Q?e+CZSl4LTw9RlOFajv5LnR9UEMAS266Hf0ovz+my9XAdndwkD8PrvcNEQkJz?=
 =?us-ascii?Q?9yMDrzXN4wYxK1ulMmPejsHeyZEzdwZTQmZ2fUrQnyvUjwhvyGN86KTzyEL4?=
 =?us-ascii?Q?hmoJltVIc2sI6CDMoK6LK+F4nZ1byfyOtbwqZN5wsOEuJxM6gA/5V42JQ3X9?=
 =?us-ascii?Q?27tt/uERHWpmwCniXg75eyshLhNZT07opmzJbYwpEV2bOwf6twsWmASPeb1c?=
 =?us-ascii?Q?o6D+d/7WlK4GOD3ENqFIeep5nAmG1KkA1zespmfecPX2zzVdintcdIZXzdVS?=
 =?us-ascii?Q?nft1t8waRbxHUIhrE/lkcMCwjYx1+/bbQy4jsIcQ+oDzrLAla8q49f54ihP+?=
 =?us-ascii?Q?/lX3GAutaaX4N/Ms67OZesDZMQ2euxWROCkCHzyxuawkomWu7PSQrW5DnKlv?=
 =?us-ascii?Q?CnZatM3Zn/vjDZVNyUYQkvMm3yAO3AJ056erY4hFEi4dZ9LfzHE7h+8UXtfl?=
 =?us-ascii?Q?LvkPkH+iSJyTzF2xach8uGTy9/BxmTkhPPZ8UOV7CbFUPVzCOD1ybhO8710M?=
 =?us-ascii?Q?jkHY5uZEOIo2MQUXEYEBtb1xPtH8m16cSmUuvhAG5kSDX2+TIevjTkRzzraJ?=
 =?us-ascii?Q?S+FN1Y6KdN/7AIZLihG5oibIYxLSjsh566r2ErwPYeSHDSPAbbSyOJB5eAZS?=
 =?us-ascii?Q?m8og38hzhx+phMdkNtz3+sB9JMUkoJ+/RJyYPmcNvB6M0F50qTKnvV3K+bvN?=
 =?us-ascii?Q?ESUDVu655zisY0mApeBYPtzHFnarhV9maT4dt8ZvKV5Llr6khZ27VzIKWjnN?=
 =?us-ascii?Q?Q8dEIQmton9ZVjfiY2VQXDHCmZyEbKY4suJItt9GbzcIBntlPdPscw1RmqRA?=
 =?us-ascii?Q?LnbwxwjYm+X6xb8DccjdWd7wmWYhKGd+DjuuoZsAJDu5OqWsVYwnNEugApCv?=
 =?us-ascii?Q?0p2oG4X5LvLDzz+9NAVYPzyFyl2DNBKxJagTCosA+mu6NcZ1nhZVom8kmqkH?=
 =?us-ascii?Q?KIVETExy1r6yN2amy9NsyCdojNaxzrrFusys3IOA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee20120-165c-488e-0b9c-08dcc3bb0523
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 21:31:59.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5olNMxtc4iWfjSL2paeZ72tB/zggQFBYGr7jObHNCqauP91F2ciIzuCYWheexcuYvW1BkRWcLg+9Q8qikLuNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Dynamic capacity device extents may be left in an accepted state on a
> > device due to an unexpected host crash.  In this case it is expected
> > that the creation of a new region on top of a DC partition can read
> > those extents and surface them for continued use.
> > 
> > Once all endpoint decoders are part of a region and the region is being
> > realized a read of the devices extent list can reveal these previously
> > accepted extents.
> 
> Once all endpoint decoders are part of a region and the region is being
> realized, a read of the 'devices extend list' can reveal these previously
> accepted extents.
> 

Thanks, done.

[snip]

> > +
> > +/**
> > + * cxl_read_extent_list() - Read existing extents
> > + * @cxled: Endpoint decoder which is part of a region
> > + *
> > + * Issue the Get Dynamic Capacity Extent List command to the device
> > + * and add existing extents if found.
> > + */
> > +void cxl_read_extent_list(struct cxl_endpoint_decoder *cxled)
> 
> cxl_process_extend_list()? It seems to do read+validate+add. 

yea maybe.  The name of this function actually changed in my mind many
times.  In the end I went for the higher level meaning which was to read
the existing extent list.

I'll change it because I'm not convinced of any particular name.

> 
> > +{
> > +	int retry = 10;
> 
> arbitrary retry number? maybe define it?

Sure.  But it is still an arbitrary value of 10.

I'll document my justification thusly.

/*
   ...
 * A retry of 10 is somewhat arbitrary, however, extent changes should be      
 * relatively rare while bringing up a region.  So 10 should be plenty.        
 */                                                                            
#define CXL_READ_EXTENT_LIST_RETRY 10

Ira


[snip]

