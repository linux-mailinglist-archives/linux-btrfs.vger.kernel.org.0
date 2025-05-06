Return-Path: <linux-btrfs+bounces-13728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF3AAC9B5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341A01BC8B15
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7D283FC1;
	Tue,  6 May 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNItyZPy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020E27FD57;
	Tue,  6 May 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545927; cv=fail; b=KzG17Uc44vSTHqSBW0Xyhc1J0saeatpm4SW8fKbiqk232ePmjgTf3utsB7QOemYqsqTxWKOG1jN1p+Tu8okhDZLK6xTm6QQNcyZoNeHw1IPgDrB5vogSQe6Ii8W4HuV+LbeONHTtHDHgT+i0svm30lRG/b10wZ32t7adYKwuxhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545927; c=relaxed/simple;
	bh=sCEgP/jl2YQkRWnNkUOJNRv+b/bIrqs8e5mE0zhSMxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N7xyYqChCEHaOb5GPllhpwx6fQXKO8Dzb9XGRG6QBFKIsbI6ao302Caq5VcCELgNpkMXf+qVixVPUbNUejZSjkCnW3ETCK1KCxvRMD2xYge0L5r6KxPaK8vN1tdEVLPPt6F8RNmNCbYHNN205LNw5H7VaVGKgxthzOEsHpoG4jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNItyZPy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746545926; x=1778081926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sCEgP/jl2YQkRWnNkUOJNRv+b/bIrqs8e5mE0zhSMxU=;
  b=LNItyZPyu42iOu95pzQNFL3igCCnEbMiucCxmkBK1P0WDqJjbpnBPV7+
   fQIQrZBjWxFqvjYKa9aNqkhSmWRec3PLtWBUL/l4HEeZoz0/4XLwqUWPK
   /o8kPIzqtzmj6dE6H6ihM4yCPBm9mlSyqcAxGy4VXebnOABfefvGuSts0
   sXlIBtbGUckkQSDLDnH/9Y/L91JHy7jvJ6svy1SNViDEj2pGgkWeUrBq0
   Ce2SHWrmYr/nTb6CQRmyDaC4gn1M75k7haQRtwzRgKbaJFyDmQ98Lnngl
   JFP24D+HdQ+etc2ai+rQzcUtDFz6ZY7vJJ+QkHnOAfQNjFG2iYA3NtA9a
   w==;
X-CSE-ConnectionGUID: dCJQkf07TOO1M1XfiFg4YQ==
X-CSE-MsgGUID: Q/AVxJhFSaSAvq75yVzNJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48095211"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48095211"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 08:38:28 -0700
X-CSE-ConnectionGUID: GZNwX8+gR/OwsOMJfcFhvQ==
X-CSE-MsgGUID: VgyJqyZETpCgw4LCThW8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="139720064"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 08:38:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 08:38:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 08:38:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 08:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Al4yO4CauZfarJM3lnHb9L+JBWS0q2krVRsOgohjhlKLzZoXzybQRV0hf/FjBivHbrlYLkr8jTq2bUfm+vjx3Dps0Ngv+QOslYg3vulYfGGjPJ1FuBnHX5gkQOY2i3tptqar7Qu/eumB7t8AnXKheqmF2X9+dGmdHISQzvGpsxfEG4rAfS7sxB/e/TuiCzEnqGNLoJsIhA1ZwVBImr3vNFJJ6vtni6BQamlspmFQp2PEvUOushku7+WH9tPXaxqn/0s9wvmsBH2f6G+gAvhJLmp51kp3CSbdZflXefdJa+b2adbxbQv3A0PgQo5Dw/fWPj0JmOP3jVSeNlda1Ew5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u7E99Scqvg9ODIkTWbswJibWOWZzkzFJJDPQVGzk24=;
 b=fVEZMyBNuP6ZfYFMhe7VZwOj2ycTqvd6vR7Tcn+LkW+ClBmIEKSSYiFIN331fM0uteN97aeo/lkc88dvCrfhu6rDYl3gd1k9A52xjmSUV/Tn6t4hpTsT9qs4aWBpki7xL2XWSjgpOpSIRQyhHvMbxrVBlMgYndHVtPYv3Z4vQXenhDygg24eeopBo6alrzAh4Lv6jgBfeCFLGeOFIA1/j82h2jsvVsja1N4KKlM/KPOLH+d9AnXg50XcPXDtbFf29Xx1wp27M2eN4v6cRNF3sujh1ITLK+R0IO3T5ZJQeYMpjU5NlhEd9eT8BsFJkGz9Yud/tGDFxSW0/YX6n092+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS0PR11MB7357.namprd11.prod.outlook.com (2603:10b6:8:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 15:38:16 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 15:38:16 +0000
Date: Tue, 6 May 2025 16:38:11 +0100
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, qat-linux <qat-linux@intel.com>,
	"embg@meta.com" <embg@meta.com>, "Collet, Yann" <cyan@meta.com>, "Will,
 Brian" <brian.will@intel.com>, "Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429154129.GD2585@twin.jikos.cz>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU2PR04CA0310.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::15) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|DS0PR11MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4b9010-bb5f-44f5-3049-08dd8cb40505
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h0oOuQRJ4pOFmhOrn+cqpsnx8/B5rSz2K24UwpI6R4akw1qg/wvEXzcgoN/e?=
 =?us-ascii?Q?FGITUxlCyF3VDvs8poYyGGlXnIN9knt6nZBqnc8ww4Vcjb755nT3QKJiiyeb?=
 =?us-ascii?Q?VWqA/Jv2LSzowGp98+QFUI/VuV8dsg0kXVUg12dbNhbFcKWO+62ibYaTIHRW?=
 =?us-ascii?Q?jlLOjLZs9BDTGKOisEZhn+HxDAK9XhLIcehFZDr89KTdQLeC4a5JgAXYzTuE?=
 =?us-ascii?Q?d0wjgWFfVw73LZYNcLJesclJq3xNfgeS3WPTH9UXU8V4qmn77lTK7+MGtzB5?=
 =?us-ascii?Q?o8rtoA8xLwECL/axWIBn+LjFbi8tQGnWa5kmUZXcugH9vCx2Dm/un8XSmgJs?=
 =?us-ascii?Q?cvX2nr5Kr7kouE5T82HwZveNbeQdbd9qpQ8zHR74wM2k18B5Rpevk28r/j/k?=
 =?us-ascii?Q?fm2Vkc9ZRovCVjB6vRrIdbOWa0yCraCS9WunupGYvBnNoLb+KiOz6QzG7ho/?=
 =?us-ascii?Q?QTCq8tiE+nqNzHQY/IbcahPe1pTE+EzGss2GYw9LgV2F8W7gr2PLNc7n/+f3?=
 =?us-ascii?Q?Ec2dKN0r8aYS+/OYItcPbFGjlJ45CCbXP7yxPl1tDVg/cmL07uLAXNHkVIwj?=
 =?us-ascii?Q?09BWB7QzJeFWzywgwqCLkHU+ntGeZXWdaVxfHSYcBLv9LdZxHVw3yZwSibQ9?=
 =?us-ascii?Q?GR2Ov9TOF/Mjr/VAfMXPOz43mxG5XTwGol9Z1BJJ6sSsfUdcnutOFpJYsYc8?=
 =?us-ascii?Q?yF1pY8Jhml+SEVrY504/q+5j1HfgFYebT2CwdxMCdokte1ewBATM4ZOMuXeg?=
 =?us-ascii?Q?S58vy+gEKyxfpGjx7wyGKgilwxTM4VsDibG0Oe5RM7pmYouuHsQUNQYpgJ7B?=
 =?us-ascii?Q?q4ChSmdTg8E467Jkr0nPvPi0ImXIFVrDF/wR9sgslGUI4KBe18dOiq4Sn7hi?=
 =?us-ascii?Q?cNumsXwvz056ymsiLYhyGoqfrln8OVu6klW/sD1hLQzXVTlFsFmmLEKozUok?=
 =?us-ascii?Q?K/miBIEjIS2yBqYGP5ga4ibcxlPrmE7uqwbUVitWx4EOri+3IMhAyF6WyGfr?=
 =?us-ascii?Q?2hOanmGqLcchZUyDm6d/BdXj7YZm5rxgeaDJIhGbNpAEhBQQvtkOrjaGt4jk?=
 =?us-ascii?Q?YLluUbrnFfFvQjgAyJQdrLCAv9F6Bx4jpQcUQT2xYlEBtyh062CUPCauQ+TQ?=
 =?us-ascii?Q?RUaLyerimsFCVndKErqWJRRferm8KqTroguUyiFQ269ZPG84Wa+qXcOFqWOW?=
 =?us-ascii?Q?Gzcyj4Kw4GvbxgGghwSNcmwpjrkM3jVjzOzivZwnXSVVcYYQYW/2N4J4HtMQ?=
 =?us-ascii?Q?WrH1bkiErec6JUpjKBDJJCx2fvztkQRBi88HDM3wYQP9KtLxYeLLChrtr5Q3?=
 =?us-ascii?Q?ERPoYegPrcSph4VeY92s9Z5sC0qR9802+6LbStDSAAhkkaQom0EKRzHY7muH?=
 =?us-ascii?Q?hVNRv4VZ+pfRTG1lhXXBbK4l0N2q80itTMhj42oIYc6HCZu5/5a98DM9se+Q?=
 =?us-ascii?Q?IusDky7tIKc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y0r5hc3vEs0mRG1ECMObRduYilYpZzki5IaawZqinHORxPgSZe+gpiarkMIS?=
 =?us-ascii?Q?9zjsDVxML/20Far9jlQRnY8VZa70ib4w4AzNtQH7V1maKKJnr0kSNb/NXcob?=
 =?us-ascii?Q?sN8Evi7fLJ2py/UMm0pZW5X0pugAU16m2E04VT0Cd0ZJEJdtyGE/J/EVizgo?=
 =?us-ascii?Q?IdHRZGnMXIj9xhW9su0A+uYxJu7PWnj3rzcyQEentwrJ3rXXT0LM6gJYhz1A?=
 =?us-ascii?Q?76hDHjraDanq7HIZWDtsq0GIMqO17/p7n0JMG5HvcCx47rUCCF+o7AAAMwaV?=
 =?us-ascii?Q?2AO1u4PtpKphMIGzDqqX4ndcLIxn3lPeLXATigXfQHtNucuqsMU73PiMoAoZ?=
 =?us-ascii?Q?n4pcZaM1kKriTrPJkyRJD4rJJB5fNXc/nO3I+Q+crv/eke5Alv0bXVE4C8nh?=
 =?us-ascii?Q?pJtiGZ6jnRk4QZ1Cd6vu0hVssMEtuExExhWbrvEcydTfr+IxOtxlRWFBy4Ay?=
 =?us-ascii?Q?fdJrWZcaq450YpHOL9JaxKdc/Si2ADDUB0skukexRV74SxpTzt/CVTCwEkY3?=
 =?us-ascii?Q?AVTsUXuo2jx0AiZ/2q9s/qk/t+0suN9alkpGF9Q0ZMwFZgHgDLJ1bp+2O7PS?=
 =?us-ascii?Q?0N39zt2m0JmttO35HlS4k+kS4zHV92CPnVkEe+59cobP96EIWg5AbDceJTL7?=
 =?us-ascii?Q?lpf4ycGjEskWDSYIDY8bMRh5njNMgM1qIG+tfYyeHYMhM/Urb+TptkyXO8B5?=
 =?us-ascii?Q?uiMy2s1WzMfrgi7WzPumLng7MgtSJ7jZ+WYs4bj+JuW/zUFvm98jcrj9XmjU?=
 =?us-ascii?Q?h9M9kZaRxR2Kzk+EWHmnsxiGqbHaVCnCQ/3YFG3OGNo3b+yU07ALHuDD278S?=
 =?us-ascii?Q?HMWss1JDjqH33negjqWeDFtbpjt/R74jd4OGVr+TeTVvoDOl8PoAZHmEjIny?=
 =?us-ascii?Q?EpId3AtpZzPW79R9p6aPQjpo8snjRkwFXrufDFEnjq8dA6ocqGXostxWeF1P?=
 =?us-ascii?Q?zTz5XT25LD3IqIrxVAvods6Vn820bfq3y5U50+7CrM1rou5k4v6HRYJB1HYI?=
 =?us-ascii?Q?16GvQrI3UqAb6bejyyQfwX0qWMVdV7m3cg1VVlWLltH3CW1AbVvKanANPoGy?=
 =?us-ascii?Q?5/+rB/Gu/yMwQi5vGohpEYWrJA8w9w+7D+weznLYiCtKGpJYHCvuCWJKZZUX?=
 =?us-ascii?Q?szYaZ/rodXIw6ZjvOsRkknd3qAu1AsgDF668MImW3ooPnY911cwiX2JkTj8L?=
 =?us-ascii?Q?P4bXwDU0MvqYDaNVOvVD1F8kXXzSgrQ6fgIgx55z90+GFJ5fexP8j8f9lR5/?=
 =?us-ascii?Q?8fo7dwkQss51v4i7xDvV7LbtCFIvLfb20oUjt18hnpr4tGfgBsSjl0pD6Y5R?=
 =?us-ascii?Q?mgzsm2p8QyNYGXNdIeIJtXBuzSDc0Wpx4GtWyK+609YYWXmMjy19fk1TYrBc?=
 =?us-ascii?Q?pP+hfHZ2FjGW4sALGLLS5CIVSVH2mZYrJZvBO7+ZkCDV1R7/24zT0Ri5i2t8?=
 =?us-ascii?Q?oCBEX00NZZNMRi4gKCFUYrg8QLXIY8d+8QnuzB0bWxOpKLQsh0crnIhXc6oX?=
 =?us-ascii?Q?nPVW3uRaqT0FhHrYtsVKHmIjNG6oCY1I8LoL0R2BLCinTdGuPPt/mTEVyphU?=
 =?us-ascii?Q?2sxJ6xHE/R+DkGQ/XxA1qsvEfhR9iakJcJhVYmx8ahlWk2SAkUXu9+3judyR?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4b9010-bb5f-44f5-3049-08dd8cb40505
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:38:16.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTmWtkq4PfSsTwUhWKjiDvjorE2RJg7coNyvs9iY00p5urahjj1uo3R4b9mW5u0ZrL/NAvmVXqOGraVf1F4AbvZbz+6Tf7PKufDIDSEcWU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7357
X-OriginatorOrg: intel.com

Hi David,

I've resumed work on this, now that I have all necessary dependencies to
offload ZSTD to QAT.

On Mon, Apr 29, 2024 at 04:41:29PM +0100, David Sterba wrote:
...
> I'd skip the style and implementation details for now. The absence of
> compression level support seems like the biggest problem, also in
> combination with uncondtional use of the acomp interface.
Regarding compression levels, Herbert suggested a new interface that
would effectively address this concern [1].

> We'd have to enhance the compression format specifier to make it
> configurable in the sense: if accelerator is available use it, otherwise
> do CPU and synchronous compression.
For usability, wouldn't it be better to have a transparent solution? If
an accelerator is present, use it, rather than having a configuration
knob.

In any case, I would like to understand the best way forward here. I
would like to offload both zlib_deflate and ZSTD. However, I wouldn't
like to replicate the logic that calls the acomp APIs in both
fs/btrfs/zlib.c and fs/btrfs/zstd.c.

Thanks,

-- 
Giovanni

[1] https://lore.kernel.org/all/cover.1716202860.git.herbert@gondor.apana.org.au/

