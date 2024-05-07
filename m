Return-Path: <linux-btrfs+bounces-4789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA9A8BD968
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 04:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4D91C216EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 02:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB41CF90;
	Tue,  7 May 2024 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOOvhVbn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2C139F;
	Tue,  7 May 2024 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049100; cv=fail; b=d3rG2w1gbQenrJtTkML6vSsFGuLVFS9Ij8sk2EIZRLTopBgrRhty7G1yUMpF2H9u7KYBt0i+tGWo/NlHBSikmSjobWxcic7H5JJtixOFTupi50xwA+ECUsTIKiE3wAkWsSfnoR05SS9CrCfHnfiskQs5dJznaqewwFb396ZfNqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049100; c=relaxed/simple;
	bh=qIHZKlbUhwY30NlvMWqqcGQjSAbhbZv69CjRsujVfG8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qkjVM5KO0/opY9oS6JuoF7QUwFNI8us2Pz2TcUFL7kuzcC7tnUfWm5Es0XKpfXFomjA3awypiPpJOhNPCl3gyyoGgGB4teIm4dqt1eo9kuJarY6MvLHD9VIJHMApPkpAXAmbFtnoYVBXE0XH3qgcqvBpYjZoTr1TIiZpypuNQ9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOOvhVbn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715049098; x=1746585098;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qIHZKlbUhwY30NlvMWqqcGQjSAbhbZv69CjRsujVfG8=;
  b=lOOvhVbnXyd6Rh+xZYr1khGe/4y4uvMLIFCT6NlsdxeeTMxYQ/nMYmWM
   ipD2renIj9UnGia7y9CPJp6240YjnCiLQe36+aXXTIIj2mMqhlYCE/IES
   ungXnmlSUuU6DZFzHkTSdCbvIO3Cz3J7BGrVBEmZt7wMGIBK2QR0xRwlI
   Q6A4zRD25bX8edFaPV6K9vglPg7iJSEq5GniEe1OFqh5BKmnzRh7v9Ojz
   Y5K9JOzuUTQWlEl9Lmd4kN/ozZqjNXnjHw1aD/sqXt7gPlHNJtuQfauRT
   2YXUwA7jcDgWmA1Owyn/fSmdxV0pb3ybK9QKXXII97oAayy7KehKWj8i6
   A==;
X-CSE-ConnectionGUID: blsJ9cC7Ssuz8B+U+RZBGA==
X-CSE-MsgGUID: a94YIbSsT/OcIsJ9lUgUww==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10655988"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10655988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 19:31:38 -0700
X-CSE-ConnectionGUID: 7pMrAZ3bQ7CqS5mZMcutUA==
X-CSE-MsgGUID: LjYKzSwRQiW5DJp9nyeccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28362282"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 19:31:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 19:31:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 19:31:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 19:31:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 19:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxfj280X0Mh5PsrrLLSAhpHHaATjWQP1YSecmcz1sawl22wcvF5bCA/lpsHJubYNbzJAZt0/QRU2EzheR2WhX2xQD+72qXnQfU2M6UdIlHKPhzDORNlDAYCZXI7aCfDkTKdFxHSICStazcVGL35sPxjMKmDvyo7QKN+1wIAnqg1v07SSvCSs8XRrjX3+2yEU4jSbbocDtMCOAs6yaBPUcBoqJ7ImrcioLSmacTFajxkXs1Iq4r7AfIdoRN8fx6gjHMuZC0zEM5kDLYcqFeuPoDvubL12IJId6+nwQVrjt3Sikir1AXlbrUXkYMEegj/kFUGHyD2aAJAr+i5GqycTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULDJmNDIdVJQdkABpAd7Gd9lbEhokpNOeKZb1M470y0=;
 b=Wb/pjfD9tQzNBHf5ecw3r6ZWwu7qYR9/pupesjDKJB0PsRSTA8EAvg+HSmkRp5d0SGZPjZLZwZFtsl7NNS/No8tXhNyZ1rAjh8wyFIWJU+R4i+48vBzh8+P0tHeVvIGjXED3KGU6i/3sYYbeAx4/JjLs+T+plnbWNZIgz6PKZPoaTu0JpygUHBgOBesU/DIShuZnn2IOEtObGGLjnXtxEg7YFIdxzu4SC/TQaZisbO8QtJnHDUZHYGmFmsvtqbRtPlerBblYmMvOEHWRLHa+p41Og1id/wo+x/5rXJ3sAhtDMG+dmx0as+Dnxhvu6fX++rGuVfWWQO51+5JWj7bjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 02:31:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 02:31:35 +0000
Date: Mon, 6 May 2024 19:31:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/26] dax/region: Create extent resources on DAX region
 driver load
Message-ID: <6639928463d58_2f63a29424@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-17-b7b00d623625@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-17-b7b00d623625@intel.com>
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: e6199e9e-63aa-4a9a-40d1-08dc6e3dd07a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LOT1U2iDUzes+Q9feAtNr11a7y+kRv7OjVsKdiGmudJPEkeRNEXcfqsaQzY1?=
 =?us-ascii?Q?LM598CSlxpGwBYIIpLJryGsYG8VkjlPGgKcG2m43QVSlIYETpapdTcCVNntt?=
 =?us-ascii?Q?J0bWZv/Cbq+ioxADOGTQBmbDfKthSpu7SSRsoxYoMiLorj8EVrLGgdfOtcqy?=
 =?us-ascii?Q?tjmmLe+pwjasWhz35eDmrgyhi7ErgZlQmPmIzIZUk02OLr7HaEOhACEtbz6U?=
 =?us-ascii?Q?cXoS7dya3mDbQN9ZYusIED22q3tu1T+u02f3wIN3P3eY6N5I//jYF9jpIuig?=
 =?us-ascii?Q?P27JdyF5u52VMvwfJwMoBu2EmZodAOVEq/0VSH7rLyQpODr5/vLfWirRjS40?=
 =?us-ascii?Q?wVEr/gPcFXQnFtKSI/rin1FQNpJou5rfDS6qk/pnYAgdvEB3zqVFefZl6Kn0?=
 =?us-ascii?Q?fE5tmn7gM794C20NQWvDhRQtt4sGh71+L9qUuBmpy7bjHG8SuYlOlVAcebYA?=
 =?us-ascii?Q?7GucEGoLBr4AFuEkc1sau+vauN7Dc/sWlkRVqhscahdsUYwd1aNnl7Hswdo9?=
 =?us-ascii?Q?lusCPBxtP3QNmFhbE6IttQAAFAdET0ySH/JM+sO7y94xQBUUwJmFZovB+nEZ?=
 =?us-ascii?Q?YEtb3lPdurMAX6ZrfAft3JoUu2+L/XgMqcuYAAwOSEkCukNtuOIgokgKJ5qr?=
 =?us-ascii?Q?CVYy6JY/1jQm5K92Cvf/T9UrDAJWzS3mm4NEKi7qF76hsPCP/FAZ+bkQfMc6?=
 =?us-ascii?Q?LkZNJM2W+2bUv+Od0QQJxKoXDtTVkeWkE+G/x1EtVfXWtiUAppqRSWQe+iON?=
 =?us-ascii?Q?AqRqSWm7DqBP8szf8bwOIfpT29oMLQP2GNAmxsge1cJVx3a1qPSCSwTCI7Bl?=
 =?us-ascii?Q?+2xOiIf9by4R73eBLhFeOBtyj3kidB3ANgbbALsCfFD4tyuEphbxFtkXhHKd?=
 =?us-ascii?Q?sAdSM0DYCMrvwE7dIXGGMslrEhwMEYTW3qGvL/7duuHE/XlClWmQBvoJ5Zim?=
 =?us-ascii?Q?nCIba6e9pKzdZMgO3z31te/Y2jxF4ONh7VdRYE1r9jk8Qtzy+HdZsFokGGQ4?=
 =?us-ascii?Q?vQZdyFfp94WbGfOesEmlnBqnenCrdnqgKYw/ibrr06XBHXPIBvkMD5OoGqSh?=
 =?us-ascii?Q?D4w5RvRv21yp+uQzzPy9fHYVOHwamyLbFy+ae7+MrYIR5J/xTeK12uLEqCse?=
 =?us-ascii?Q?eKt1FdAT6w5of0wAGIj8TfiQH59GXZC0kJ3GqXOcP/8CAz5xluRV2gst11Jf?=
 =?us-ascii?Q?T118xS5u+hRbOLoF7CDzt02wCRKy5wK+TWCFsxrv6ZV3thMluC3oyeVe1Liu?=
 =?us-ascii?Q?SkV33zm9Dyu6+R108Dn8syvfkJJSLXs6VfxQR/+61w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdV+an+zeUgZrTQSd9qDIj3irzIDoys5xv0w/H+z+hSLM0moMbGFxCpPOuGI?=
 =?us-ascii?Q?o9Di9uszccDyJH9Yo9Qef0zLgkZO1JR+lnoVQ2w9t4vMlxEsM854+anE1/6A?=
 =?us-ascii?Q?Jc51j9YGjqd9Z6vDHf25DioPFpecu3MOWDeNlVXlqIxr4rVsTV/vX4Oa6g0L?=
 =?us-ascii?Q?GMXpHPpJoibDcqAnsaFmklsD7z1LZx6BZeuKeHcxLdLskNwb0QCz1A9f+yDX?=
 =?us-ascii?Q?BTcQ+YCAjtDeUBjlWy4zGok53iFd3zgQhg8CoUSaQy4mGleBu6RSEXuZc3g1?=
 =?us-ascii?Q?X7qT/APTP+PBCPK2Z07hLOCDGyQhE233Dc040LZ+OyXJQZogHjhQSc6vq/IP?=
 =?us-ascii?Q?xha0U81iUxoKwfKAR7xIv9vVN8eYZVxnPurAvbXfPsea5MzjvS8gLwOo80c6?=
 =?us-ascii?Q?c8FwPOHygOftwdD+r6px0AuM8qw1pxLyrty1svg4K4ETyfEzLdEpY4cIwIBM?=
 =?us-ascii?Q?15ymRCQFgQ9s+vT/mLKfW/JygbEPOoJ1rUY7kE6HYlV+yOLBU+FVQNjvLkZn?=
 =?us-ascii?Q?1j6JdQ8ur7Ogs7vo0B4jDWgHkT6H85GoIz6CgSZLiB+xhrBs1HAQ+ADuzmru?=
 =?us-ascii?Q?806K2sC476FEncEY6KSHd4g91cEtOLDWR2+pD7eGyqH7xEBfxZg8wtA2rKCO?=
 =?us-ascii?Q?TFcUoO0oKK2N8elU/wLJMLsjGK9pxSnsl/feuUF/myW3kbfQXkQg9WMK3F4Q?=
 =?us-ascii?Q?24U8UQX+QZ7I9XEGopL6JOB8o7uCel4a1uDwL+Xo3skQBTC1TcqTyZALg7x+?=
 =?us-ascii?Q?GdC4Wc6UQnasJU65p4yQ+L/Ck3p2v4Q5K9YbNeHN8yFa4ck6XzSQI4lvMnEC?=
 =?us-ascii?Q?UMh3z30KOAHEajfVWScaoq5saSCQWKJvTgwCxQlhanung6JiVqLsfdtWGVlz?=
 =?us-ascii?Q?+7/YqZgmGoK3ZNldiyfE1fY5oTUzTDCNzzrEdEyvYs3p1opDGnC79LoWCdAQ?=
 =?us-ascii?Q?75ZxlrW8hdLg9omjI4LjspuTCNLT3+CS3qlUTmWWffVTN0+ZnoW/Jco8mtAm?=
 =?us-ascii?Q?05llSMOb4CcMxXSKuB+PofbBwTaQ5ZeQr5h4grFWPe7w4EFj8zvRxZz3Sdus?=
 =?us-ascii?Q?jyfytbMeLL3hzoK55MOmnd/S7s5FICYUfxjcmLwma/8HEvJ+/sPbsxY/6Zla?=
 =?us-ascii?Q?H0BRqRVqUAbzlOHsl01hfkeCmbxd3Pjo2SjhXs33dsyQyWv3ZHh6hS+JHqDO?=
 =?us-ascii?Q?gORI9VjrfkLhe8BZj8P78SNmJSxRsl1cWvWRnzff9KOCZBSrVCaPBFvAkEL4?=
 =?us-ascii?Q?/CJVHDyxGr3yI6bDCOYCfLvX2RFSWK6CRbWEZX8JB3pAZ9ID+3f77TvME+TN?=
 =?us-ascii?Q?EE3GxVc3HdAY5rUV/I8J7tD8BrRZ8p9R9H3JfFgjcMlpnig/yhWnI4eeX7xb?=
 =?us-ascii?Q?a1kU+UYlHWQvysrDYvnKPYRM/S2wHinUnC7GfaRWUqJiMho+NWYOELDoABwN?=
 =?us-ascii?Q?ZqgEs8zvVUd5OQ0GXVS/yMl00UEnovrKqqL07BY+mhGccbFEiWHJix1vwibI?=
 =?us-ascii?Q?WmGdANyNtfEcU/spOJJ2u+rw+vF7hTKJANo9Rwf50W9J7o7VmN8TBavcFABj?=
 =?us-ascii?Q?LGid+CZitu44i08pwEm1oNByHyyPUh91kxmX74h6A7DaQ9Xp0uMmDO0aw4/p?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6199e9e-63aa-4a9a-40d1-08dc6e3dd07a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 02:31:35.1427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jukrWt0upE1h36KS43To209LvoJhLTCCmu6flk+CtN7aRbryQeQhy9mnlYhIuOGmLnGwh1KI+2Mi43hXFTPIdvIGFlfmuTLBnK+/cOT0l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

ira.weiny@ wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> DAX regions mapping dynamic capacity partitions introduce a requirement
> for the memory backing the region to come and go as required.  This
> results in a DAX region with sparse areas of memory backing.  To track
> the sparseness of the region, DAX extent objects need to track
> sub-resource information as a new layer between the DAX region resource
> and DAX device range resources.
> 
> Recall that DCD extents may be accepted when a region is first created.
> Extend this support on region driver load.  Scan existing extents and
> create DAX extent resources as a first step to DAX extent realization.
> 
> The lifetime of a DAX extent is tricky to manage because the extent life
> may end in one of two ways.  First, the device may request the extent be
> released.  Second, the region may release the extent when it is
> destroyed without hardware involvement.  Support extent release without
> hardware involvement first.  Subsequent patches will provide for
> hardware to request extent removal.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> [iweiny: remove xarrays]
> [iweiny: remove as much of extra reference stuff as possible]
> [iweiny: Move extent resource handling to core DAX code]
> ---
>  drivers/dax/bus.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/cxl.c         | 43 ++++++++++++++++++++++++++++++++++--
>  drivers/dax/dax-private.h | 12 +++++++++++
>  3 files changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 903566aff5eb..4d5ed7ab6537 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -186,6 +186,61 @@ static bool is_sparse(struct dax_region *dax_region)
>  	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
>  }
>  
> +static int dax_region_add_resource(struct dax_region *dax_region,
> +				   struct dax_extent *dax_ext,
> +				   resource_size_t start,
> +				   resource_size_t length)
> +{
> +	struct resource *ext_res;
> +
> +	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
> +	ext_res = __request_region(&dax_region->res, start, length, "extent", 0);
> +	if (!ext_res) {
> +		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
> +			&start, &length);
> +		return -ENOSPC;
> +	}
> +
> +	dax_ext->region = dax_region;
> +	dax_ext->res = ext_res;
> +	dev_dbg(dax_region->dev, "Extent add resource %pr\n", ext_res);

dax_ext is never used, it feels like this these helpers are in the wrong
patch. Like consumer side of dax_ext infrastructure lands *before* the
producer side.

Because the justification for this producer-side patch is after the case
for 'struct dax_extent' has been made.

> +int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
> +			  resource_size_t start, resource_size_t length)
> +{
> +	int rc;
> +
> +	struct dax_extent *dax_ext __free(kfree) = kzalloc(sizeof(*dax_ext),
> +							   GFP_KERNEL);
> +	if (!dax_ext)
> +		return -ENOMEM;
> +
> +	guard(rwsem_write)(&dax_region_rwsem);
> +	rc = dax_region_add_resource(dax_region, dax_ext, start, length);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(ext_dev, dax_region_release_extent,
> +					no_free_ptr(dax_ext));

This looks like an awkward rewrite of __devm_request_region(), but
likely that is because dax_ext is vestigial in this patch.

> +static void cxl_dax_region_add_extents(struct cxl_dax_region *cxlr_dax,
> +				      struct dax_region *dax_region)
> +{
> +	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
> +	device_for_each_child(&cxlr_dax->dev, dax_region, cxl_dax_region_add_extent);

Per the comment on the last patch to move extent device creation to
cxl_dax_region_probe() that can get rid of looping over those devices
another time.

