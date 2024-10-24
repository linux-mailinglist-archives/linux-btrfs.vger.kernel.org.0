Return-Path: <linux-btrfs+bounces-9118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536AD9ADAB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 05:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108D52828C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 03:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F44167D80;
	Thu, 24 Oct 2024 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFMeVdDy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC954165F01;
	Thu, 24 Oct 2024 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741870; cv=fail; b=U2b+lXCFAtEPJWWM64DWgAlIUNpKc18XJFmr291lRvbt13dz5QBFZab/7ylMpfiS4KNpkiTx6VvUA7weCWtllWDtA3ZTtVKDPTnT+x680KIpEIN2Yb/pXAzfsqc+DG139gzVvFZnqFr5n5gJLTxmFlOu7XqP2BV02ulAVMlU5Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741870; c=relaxed/simple;
	bh=rBCA5I/KQQpcIAcEYZPMtEbHqW5xtbEDJ5FhM8EOSok=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OE7vCrPk1iEG1do1IQ2VznzmazdU/p1/iqR2C8DdSXAGRBYiocvYX0NvkayL5XwJsb7BJOgbJ6OBmQcVNkM99QTT2LM1WMw7WzG+H7U+qRk4qbG8AE0REXvHmDgBWuw9aINQP1nFUnz+z/RuxWGv6eTsDiWm8/vRRtuj4bh/emg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFMeVdDy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741869; x=1761277869;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rBCA5I/KQQpcIAcEYZPMtEbHqW5xtbEDJ5FhM8EOSok=;
  b=UFMeVdDyxanCGCWwUCNp3iiO0NS3RPhhfT1KKkhWPXypUhdn4WCrIqpw
   678M+wuvyv55uHXlyVjTYb23FpdIw/LzGxmqQCCEAV1V1MrGMYmVmnGxi
   GIEe/MVPmuSbidUkRIRhdhnHLvwyQHjL43RvAi24qZ0UsVm3oFsGktK88
   wkPJtY0kUj/+Y2iwDfa16p/x6vmaA4O/Q6GD2HUlYZQI3eySOn9Et8OeV
   k7wM2kjOugy4Y2r3Shpx8lheG9GlBehqCRM6/3SQGFhjBQ8R53b8jeRXU
   kwL0XmwkXIOpj2IlysYO+jjzP11nLSBLvvzbnCmqcu13m6XjzYiPGdUVA
   g==;
X-CSE-ConnectionGUID: AQCiqaDfQ22Ft0PX8c5a/Q==
X-CSE-MsgGUID: 870Ko1OiRZ214aosnRT2iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28818283"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="28818283"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:51:08 -0700
X-CSE-ConnectionGUID: kCROT1mhTACqEJQ1HA9Tdg==
X-CSE-MsgGUID: WELRfp5BRkq8fjF5XFt9eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80127570"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 20:51:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 20:51:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 20:51:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 20:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp8/zFw17UbJu3SD4GPBqK801GRVQu1fIyJrBtemj32ByhCgABgsDHYCtMCT/WOgraRaMmW7jqCLC0bNpy+rWJVMqvmfQDyaFVnv2XI1Y0yn35lHUm0GsLz0rWGaH6iDOlko59HJ46XDzshnPicOsUH25S3i2OCqLoC/bTtBrG/eA4oawHYD7xefkObvPZG+cUG6ctmensQU8Fg6i74QnL6yza9g7hX0aLRWef8FgheFsfCJ2AagjXuu6+aBCFBajfMvJH7JXkpFcJ9g1lDmqbUVSSZKuSe6u2fjve7G9QXLtNftrUPCV1tiBSlZmxXNFagBwmVV383iH5hJqSSytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4V52rImdwsg3LrN2NIBleaKZuN7Yue0nJtDA6R2kxc=;
 b=vwJgXQGTUvb+Hw+NNhlT+XGZ7oYwlnTKIpOaDfokYLblmt4SZrdIHnzy3JCU5TsHzEiZEseib+R0+vcCZkeXHIUAW4AUxtglrofIrVTFrTqlOOAF1TEqfTpz2s+XvIbIPo2JADG0XFZleFaQ/4m+BDDQL3aHY9Xmzqa+RCsqJFH4vTq4Aq2WOtnSSkBS9cfWf8AOrnzxWKLN7eHu4pNOfLZknrYrejHQLMVS5BnFIMQtwFakMEyEWSGbAWjobWbREdfhzTaGj294LNesxrxTYCPuBzSTa5xBv2HW9kUQN1GgDkr/IuMRcqfdRWWkBf519Qk4iQhH8m0Ul/PA54qZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8113.namprd11.prod.outlook.com (2603:10b6:8:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 03:51:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 03:51:00 +0000
Date: Wed, 23 Oct 2024 22:50:54 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 24/28] dax/region: Create resources on sparse DAX
 regions
Message-ID: <6719c41e4af2e_da1f92944f@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-24-c261ee6eeded@intel.com>
 <20241010162745.00007b31@Huawei.com>
 <67184f4ef593_7253d294d5@iweiny-mobl.notmuch>
 <20241023122201.000005a4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241023122201.000005a4@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 632d097f-f96a-4425-fcd0-08dcf3df12f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ni1kb9QdgEOEKoNNIuuVqkqWP0wabCjzbv11ChWIP4vLKbocHHBoSEKhUytH?=
 =?us-ascii?Q?4+Ykzx1BoBwP8jBZSjyW8TUhs7NEHvyvyPKYRpDJxTQKAprBNwyoVBHc567W?=
 =?us-ascii?Q?37Y/Y/sNnn5keVbVFv4TcAPOVca30/rp+G4cyzmOJJw95m6vAP2wG/6rMQ3B?=
 =?us-ascii?Q?S56EaP4OXfo+95i3ooXheV6GtBT98X47BFfjKFM7wqQSgtxmfqg3uVfljXzj?=
 =?us-ascii?Q?vSWxDCmNmBr11cP6k6oUjXI/9/F3awB3oWFewwz1/Fc2OxLyATfzK5oE+OMV?=
 =?us-ascii?Q?anZbJcqzO6vIVjwgk2kEIxRzFbvgHUhnYDzycIdO4lE1kBxrkT8NkvsrucdD?=
 =?us-ascii?Q?s5HeYAPJ8NRs2cEMRbyUMgDkn+tVCcGDoPK+FckhMPyswapY+YSUBysmnjzD?=
 =?us-ascii?Q?VtMCuRdd9sMY+Hbdp0Wonl7c7rKe1DBCNUP1m1NIpnkHMOQdDTMW73kh2if3?=
 =?us-ascii?Q?d1+2V3qq2YZ2jvgl0H7HjQla618IiuzIyZhyxVZ5veOhlr1SH7nsQbBQVWqe?=
 =?us-ascii?Q?IzrQAZFLWAZy9DabjV2FSNr4g5qUiqK9Pu3BaTY2plb6f5DHC+oqd1qBfpkE?=
 =?us-ascii?Q?CMDeP5LZa42jXO19BmdoeNwRY91iu/2CXD8y5OZskTh56cx9+IYPl+qcOVP6?=
 =?us-ascii?Q?DKsImIyqFlrKhZ/hwd+lgWG8WPQAmvhAE7hMBcDSRosvspCBfxqMKIYVpKSR?=
 =?us-ascii?Q?WP5xUpMTpIilux+EnUXx6XE2xpz+A0yYpxlU3wlpGshS/BSF1C9gYLxNcqbm?=
 =?us-ascii?Q?kbMAUOdVaetQhYZrXe5oAbxBmxGByVQYKfgNzpd3Pgu546bPIh54VCGlNy7W?=
 =?us-ascii?Q?I3o9LdSsCnrEiNDeEFTAsYwE+0ZZ4tRc7sXMgRRM4z3bzzgk5xhu0dbJ1Mje?=
 =?us-ascii?Q?E9hXNQ2mWxw6+C/SR1NTCNUdqVGeCWpIlVdEcPpptG0F0FkDclKEK4dqrm6I?=
 =?us-ascii?Q?NtRZSB61aqEanqnf3aYlmAPz5in3C+FAAi5tMOm3a8CNeJvw3XCyP9qNkx8l?=
 =?us-ascii?Q?RXcnUR5lht3MTR5YINjrsKvLHDBe+dt0n8EP7Dg9Ng55nUMybuVRpCkhSxEH?=
 =?us-ascii?Q?YSI1YO8bH7I2HItefhHG+lL3boH6pXPTwO4lDT4GAAKTwofluN8oZ32EQei7?=
 =?us-ascii?Q?b71DyPBeZqAH7cBOer9CE/alRB55JkWkaadHvkTaQcb5sVelnXRRd5SoWfyi?=
 =?us-ascii?Q?NOkJ3N057T3AtvrtqxK93Ng/+wM1tp6EksbH+x+6cx6iu9f0/5t+GcYekjgE?=
 =?us-ascii?Q?hfdM9r6lWA2rZf6ok9LuVyDwDX/WnNGSuSFhm9VJ1Xj9Fv4SEnsD+jS6pQVB?=
 =?us-ascii?Q?Pxs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/46grEh5DZ9VNU7ERZdp95T3Slcn7o6PKLamP8/jAbzOu2DiDEcUAhPD+uo?=
 =?us-ascii?Q?lW+emz8JFOpfla39QU9TSrzNUYGl+UqxqQ9THeS+rkSpV2ceEQTnb3a2kdPG?=
 =?us-ascii?Q?DzePCJDW2ZX5+v0zI5IsxKTgqwZhevx5GnEvsl0Ez5RUW5NHMR26CD9hlwUI?=
 =?us-ascii?Q?1bIjYwFHUmaaRazZWXXW8sdNEVaNSb/iDfaJRwT3q+Za/Y2eYO9BW0qRCkBI?=
 =?us-ascii?Q?NoIQm6uALd45u8UFFsoc6tfTu/0CBPFbXonHE2Q7vkfcnW/ypfONVwITvUr7?=
 =?us-ascii?Q?CvHbAj5k+oYLJhGX0NTroa+uKJ2WuLIEepgNwEiTaMTW+7vspeD7Xd+KbMOH?=
 =?us-ascii?Q?y6cwQGTbn0SFTehgFtBNjzUW+GUVKT3FyafnbvDA7LwNKefDPGjoMiAFhtXy?=
 =?us-ascii?Q?rroyQGWwfrDYsDRNV9G2tdfFhdiwg8Z5KK3SPNChjoIFoiMZpJDnoLE8Jrq9?=
 =?us-ascii?Q?jhk3BzjqEKRRbP2K6aljkuGmm1niqEYItGy2Em4eoOoU58uGghmpex7aMXXp?=
 =?us-ascii?Q?0lVb7a2eTlE5ZtIGIY4Upmru+J2PYzQB4Sj9K44c16qmzmXySsLC1Fot/Bqo?=
 =?us-ascii?Q?Bd4LvShZ82irY+vK0VTJFSYX5rM7gNq/O1L6fGZ64GXlEIGLunOJ2G5W4clF?=
 =?us-ascii?Q?0wtNs8U9TMvbUWf+aEYna+s+J4k/lqLnDGqq5qXcdDjoB4iordhaj4PS7VON?=
 =?us-ascii?Q?d+/2TiwakFjLghTiwDtmfakyw4jXZpGpxf1kL2WD98srKPSl9RyOW0U7+9AH?=
 =?us-ascii?Q?E6OAlvEgG1e0ChDjt+NCnoFMlO7vTGCf1vW2PPX3mOqkjWFYs2RBHPXpuZXH?=
 =?us-ascii?Q?yFCZTcRt6fEHNjsf7ezkPibT3WWkUHffBzG76W2guqwOPFwPcaTwkCG0d+GY?=
 =?us-ascii?Q?jA69TNQQDOy1xwd6baZWdtikWaT+YSll4t7LEyJ0Xkpm/M2Ys83pQv5Ila5n?=
 =?us-ascii?Q?A8SoSPVy82vodq4NQe+Hh3h6qb5Z6BeLO1ke3AiSNuahEjz/+W1tpiRQXcoV?=
 =?us-ascii?Q?lxohVmRglN6s+QmlXEnGQ2rumot5HrQh2i3qaS0V24Cl71WGnGRWSWf1mWJG?=
 =?us-ascii?Q?UBVZ30lEqDZKGJhI52KO90xLMC97DSYjzDgfEOq5V0sj0wh5ikhH+Hk4Cvk7?=
 =?us-ascii?Q?FNY0gZ8cHwRSJqlOx3RzSd60SLSUVXuGewW0k97MNsRo/wjLmfRz2dQ3So2J?=
 =?us-ascii?Q?jNvIE9ZytnQ1g8gVt6xiw1SfouSD00mIEqMxPAn26L4OWdc73Y3TwCRuESru?=
 =?us-ascii?Q?MVNZ2oJH4G7gXhyxW+9maNjZT8njaPwn4V7972Ikbn+MmxaOf/Ou7Vt7eJEs?=
 =?us-ascii?Q?Rhq/4IhjH1RJ0sh4ndogxg2CNs0b4C0d5XLa66HSgXwLwI5buCW+lk2Ylka7?=
 =?us-ascii?Q?3CToKAUX6D/kLfWAo5R8ftjgtuwoJQh7Czgv/A1EioAxE6lXs+t6G7pyxxXr?=
 =?us-ascii?Q?pnWuhESoSbde7bZw6d7+Fe5HDENvs1/7SQKQ+UTFmk2A5rHshSOZRGgm6Xg8?=
 =?us-ascii?Q?zJyoYKbCmzC+6i2d7NumNrPRwVxr1baA2lqQ2xIZgsqDNJrO9bizJsEw1Kg7?=
 =?us-ascii?Q?IyW0W2K8dIpTRHB/Aawm79aH4jfEn9Qwkf+9EAXi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 632d097f-f96a-4425-fcd0-08dcf3df12f3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 03:51:00.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9WkDDiV9iaelCZyShbh3kSJ39D6zgoUFd7MeBsXBdqowLZqSP2NTIlLZIWDteK89af4Jr70+HYjjywNdB5Ybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8113
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> 
> > > > +EXPORT_SYMBOL_GPL(dax_region_add_resource);  
> > > Adding quite a few exports. Is it time to namespace DAX exports?
> > > Perhaps a follow up series.  
> > 
> > Perhaps.  The calls have a dax_ prefix.  In addition, I thought use of the
> > export namespaces were out of favor?
> 
> I guess I missed a change in the wind.
> Any references?

I think Dan mentioned this to me off-line WRT the CXL namespace.  I'll
double check with him.  Regardless that is all something which should be
done separate from this series as I need to reduce, not add, to it right
now.

Ira

