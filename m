Return-Path: <linux-btrfs+bounces-3978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC65189A538
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F01C219A9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7017335F;
	Fri,  5 Apr 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/9pP9fD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9625173353;
	Fri,  5 Apr 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346665; cv=fail; b=A16oXcqi8jWWImhIBiTWofxSGOqkN9dzezgJhse+WvCaP8B2UorGgVc58nyg6av0ba4UaGI5tRluO/y3b1u7cdUlc3HeQ4O7fF/PgzPJDNSY3MlYw8vwDKCiwwhGx6gq8YwQWo/IlOeUbejykB1pIcHf/0YLITU3JO7orAJPJvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346665; c=relaxed/simple;
	bh=L4Wwr12NPIXxuXCbHoEPXDcG+X/narjBvFxijx78Zcw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D6e1wHCUJuf6tTNCuR+BPpNJuszIrzu0qaQkaqrvV6cUC6JJFUTbX0eCcbMgJWKlLiuCMWQQndpWqVCmW8PW1RDTkqnoY3FxdmXpAwfRwi+SznZ9jXl76CYXk6Llxj+KSu88EW1kj5AcwM8VVjyx+2aKlY/jqdeHW3YmauhMfFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/9pP9fD; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712346664; x=1743882664;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L4Wwr12NPIXxuXCbHoEPXDcG+X/narjBvFxijx78Zcw=;
  b=h/9pP9fDe8ZbPkedDM29KHBYp/rUCHn+Eo3rpyMsvDhOXGfzHAJjaqj/
   pMSBq2cNXynrY9m1fUlzCsqLO2f6AzbXCG0eSyt9nDZlxRJi8/DO1gO5J
   yjchL+9oc2i1k6v3kCm/DVmXCwACzkJnPP5ncB/qZ8Wl371ZRVv44Hn8x
   0nEvQOwT6Ww8BojF8YMtv3E4p3221V+63qTlMa+rQ5yoUmtzjqfPK9W3R
   lCIVXeYrByaBZspg0oDCItBdBVujx5wZdIVGwiAvfNQJNopt8N+wItH1u
   vtKTykQGBuTUa8BZluCh7DixAc6ZXhagcVrK6XmeISOQyzGLCmRBbSBNj
   w==;
X-CSE-ConnectionGUID: z6w7iFtaSiqH0JRh+hBpYA==
X-CSE-MsgGUID: J67R+p90TV2YYg21YSPJIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7785745"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7785745"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:50:18 -0700
X-CSE-ConnectionGUID: Pq29WuW8QfuK/89JG1YzgA==
X-CSE-MsgGUID: TvGaCKcbSu6424mB0Niocg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23989522"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 12:50:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 12:50:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 12:50:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 12:50:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 12:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gai9eUdowe23GzVagNrbiJ8DmYjmhXYHLlg+mXugVBLvZqA+9J4zIaovXdRVXM9LwC5znwfCkA8nAatr6nntdpySzRzBPi2wm4U+xZACzX9CVRHPe7CDeCRZUziI5eTt4R7d8rBmw6K7kUvEvpZyJaMV3cj1uK2yh9SvAQVbmQpHtOx0EWs9BqzltsB/Yy9g8OZ2BDpUL9cpdY7ZEnNx5reyLsFlEb+wzCX2w/Prdb6CtSGkGko+9E0us/0knbnF219oCqRMmriwfEOUC567VTb7ERZ9c0CA33MlGT6fjPF67ztRZRV8xaJp6FVWpr0KxWYjskH7mhM8X4CK7WxOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aw+GUsaaDQKYSKcC5e4eHdiBLDu7tguTAMmCsnP4T8=;
 b=BzyOtg21VwEK1WGpiZcfYE90ZNmkHQgNNghA9/Kv918Xanw0Y9FR/fFePMFanhPHAzeFwKNYiPPTDSeonK48AtDLGswwV0l+lhevDngXuhGHp/H/IUAfJeyelDNpPeanrWJ75TjxbUGvudmL4ULcnlXa0XeByVSw3JzWiHFlVzrZTNk3mv3ZUOvkww/rymAIVrayxFny/G+APEXNJnb1V+su0uvObpWoOcCbI0No2bZH4pk1MyUAFY19eWMZqIibNtBFXi5CSv1dy0lLq3aDt3LChxO2YUNWDBAlptG61rYRLtWT/mKdHN8iIUgpRCnGiOHMWckMlOY1WSAKXlUbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 5 Apr
 2024 19:50:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 19:50:10 +0000
Date: Fri, 5 Apr 2024 12:50:06 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <661055ee8c5aa_e9f9f29481@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
 <ZgL5SdGCori3Dh3O@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgL5SdGCori3Dh3O@debian>
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8052:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGJDrbptLrSFkamdiVKNqemNYA0ujAe8S+CcCfpLMfswhdUeUGlG4p52uYtdPx+0oDgh0cYJtpPl6mvdz69I4MXNHae8v9DOuzGJABjZ+ZVFW5sKKx3Lp18FAvxSOpyYW/K4Yxl1/axYVPCUXwLlKpXfn/Mynt3Skp/v2dxsRa+yP0k/JvY5lLfFn368fuq2sw4xfXMjESrHfqGDjZon/ku2x3mq76vjSCTijPBpurGx5s4/p4RwfRnab8VIfz9Q5SPK6yTXwUXW4Kh1bWe1OqjvAWmNducErkgzPfXhET5GPbeIRQMZ3nAia8rNaKV5TvorV1wd6yuPkb/9RKqQBDsu6NmnT5RhQbKm/7KfyGUcfWKclwZUEZsKyvfGtmzpQVdRolSSMIdwcep+X+eDVNSjJxYFbgryXSETUa0xJmyqCd06Y8LaHhzSmg4KYpgzBLw4ngPQDXdYmwaVTNBRfyp+Xv2NUmJt0L23T43tfbKq89Kn3J2h121yHg1y+W+3fmrwou9ZtgS6KAny9nqmKMO3w78qZcvsv71Y9U4b/SdkZmtMtuSnZTZWh4xxhps6oySQRy7wLHievuD4mxxCM0bpPU7wNGdZtVjwb/rG5tJzFv0IGZuG5wt4EvC6GRWx/pXD+LyF1tClTanmCg/45OBpWWC1cLecUdasxfoVfpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VDJYY+aPmjg6S32OC4ACcMiZqs6n3va3HfgEV0gRIeSxoVivS+65cxahwOAj?=
 =?us-ascii?Q?c8v+/hjFIH7jwC7e10vkPi3LL4TIH+8GPztSy4bruTPS6DCNs3upvxrITphZ?=
 =?us-ascii?Q?Fe6UNbvRlWRYgvzvIqQ50Jq7wlDlHpw9RSm2Rd5YHyh6vgfYjPvx0Wvsu6XF?=
 =?us-ascii?Q?taEXhKqnTwKnjtp8wuQWh93dgVPACfZpIDhVeK2h1KNjv8UOnPuTAK2BqWEz?=
 =?us-ascii?Q?qe8ZXHqAlidBYczaabj7wdPth8HZp9cULMvseka+gMN6Bv+3NvYhrXFJtGzM?=
 =?us-ascii?Q?Stppq73UBmUTBRZfsE6NPhS1TQaPKPdTATxGGNyTCLt+ow6eToYiUtqoKq1+?=
 =?us-ascii?Q?vB0ka3WSRlosveKaT98Fapuank7Bo5Yv5p1bqKSbgy7pqR6NPTvY7Xmc7j4T?=
 =?us-ascii?Q?UTrO98i/gBkdsiI25IXwYjmAHFwJYLc9yXYpR5ueDKQB4ZDqsy6lauBjgNyM?=
 =?us-ascii?Q?1xqD/P0ykrzEjTx1d/nJCtuoHArG2GW5R+6wp763S444KbfXguNkJTn5Z4Ot?=
 =?us-ascii?Q?V+jBwGZQcowOzMfgzOKHRMsBi6ST+unEFOtGD/P7QcTjEL1ZTna+WycLWflN?=
 =?us-ascii?Q?T4GcG13t2H/wAUxU2ws32DMuEhQBmXcTYSnNk8YjVhxB1sOcvVccVHkaNQxc?=
 =?us-ascii?Q?EgTxW3bM8csJh2sIQt6SpfQ8zBvq3ZSQpMJppssp9snkge3CeGCkREr1gygB?=
 =?us-ascii?Q?lhQr/oUuyj1wJ4NxUNRrpActf0jvayj6+hZ10OW5N9r5LAU/T2uSyib02B2R?=
 =?us-ascii?Q?6nn900rfqf9FLizDGnAMl8S5yzQigSJkm8pR33gSMNw61OOYzBXUN8HxQjKa?=
 =?us-ascii?Q?TIZ3pYOL5qjQM2ywFLWz3dSeSV6f2eTaq5u5L75RrkET8+stAZA8F+GKhcCX?=
 =?us-ascii?Q?760WgmxXFTHcFCVAWv5ACNjXXZ0kdgUFJL49VxhAs5kCeZRmSZdvJ3XgMyJ5?=
 =?us-ascii?Q?hCGyV8Nz82PK5ltczjXA6LMtpgYdvFISsENa+6YRqfMB0jOZb31ChO/C4P5Q?=
 =?us-ascii?Q?w92Wq1N7JHFPvWKDFkesnYYB34W3/d1w1Qh2fqjAiwb/L0XNs1UNwDWFXQqX?=
 =?us-ascii?Q?fjqO89epzoGC6h4Xa6giu4/k+X5rRwJ3Rh6FeD65/5B+3XJinecltbGyXIb1?=
 =?us-ascii?Q?hcShqR4rqn7FzuuAUJdbevgMilfDcgOXdTdQlpP7o6+H4bdZf3YA9f+u94Kc?=
 =?us-ascii?Q?6PLudGN+PfaLxwS6vCJrUAldhn+wX5nwe9peqxLkVVX8pIOGnAylmmqOUK94?=
 =?us-ascii?Q?KkYCjQBL29b5Ygx5wB+HvFZnbCl8/REYkI0gnjpCnDVk8a4KlrElWlRUYgtJ?=
 =?us-ascii?Q?YXyeOeLpOHWscMVqWVSEplDDKPlkyhw5GsBQzDIeQDzLsewoVF3NioxmeTd7?=
 =?us-ascii?Q?6+vPnqtG+2xpYY7w5eD4UubKXqRrMpX9veYKWssqziv+zkE3HRGlS3c5BOEb?=
 =?us-ascii?Q?7XQpkEzCUkjOfsofPp1IsslGJnLgQEks3E/I0Q9klfJpMHjq/ZrXRsI1qKPM?=
 =?us-ascii?Q?zfOAmqyJftzPSkEbBhEyGiMi2mDToq4oRvxqehGe9lOch4BGpRjTtVd3lUdS?=
 =?us-ascii?Q?jDVFtoQdcxKx+FfqsMzrPK+swZiDJiUYLbgCYi/D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb966056-1364-474c-55dc-08dc55a999ea
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 19:50:10.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEqVOOSSHGVP2YDHhN1wdMyPx0KsuBK7rq8dvfDU330pRrGZ/fDXvJ2iXMTd4i1efJMpGoRFpFVfI8xhI9lfyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com

fan wrote:
> On Sun, Mar 24, 2024 at 04:18:09PM -0700, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 66b8419fd0c3..e22b6f4f7145 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -255,6 +255,14 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	__cxl_dpa_release(cxled);
> >  }
> >  
> > +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> > +{
> > +	if (mode < CXL_DECODER_DC0 || CXL_DECODER_DC7 < mode)
> 
> To me, it is more natural to have something like x<a || x>b other than
> x<a || b < x for out of range check.

Ok.


[snip]

> >  
> >  	guard(rwsem_write)(&cxl_dpa_rwsem);
> >  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> > @@ -433,6 +442,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  			return -ENXIO;
> >  		}
> >  		break;
> > +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> > +		rc = dc_mode_to_region_index(mode);
> > +		if (rc < 0)
> > +			return rc;
> > +
> > +		if (resource_size(&cxlds->dc_res[rc]) == 0) {
> 
> The other similar checks above use "!resource_size(...)".
> 

Yea good catch.
Ira

