Return-Path: <linux-btrfs+bounces-4093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B089EAAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1298C1F23697
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DE28684;
	Wed, 10 Apr 2024 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBHlP9uJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7F20304;
	Wed, 10 Apr 2024 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729979; cv=fail; b=VEGBiwWuvh8YVd57DoXW1LnH4JJnOvmMeKJb9eAf9pKQudc/eLJ7xhJbvha1tCw79ET74IVIzJI7RAfT8C/Gx/Hm252/LXKoe7QRHyoJjifiSKvmKz55E8QwQhsG43DUXFJP10RG/3IXUp1e/qQTa6SuXRXro+fTLLv2mrnxQRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729979; c=relaxed/simple;
	bh=AcH3wofH9l0Vl13WTjCwq82yjOD7Bzobr+AOm8s7WQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BvqMYwEznQwAta1yhDw//JDBUv/WxJ+CIZTKwO8GoANYhpFLMV6iJ9bNQ6iEwzb0j9P4ntSzuInlqKJdKautvJv2Mziw8AFXxXe+W7y7D952nGPsCCgACSPirzcsFJBeZIR9TciBlwV6si0ZOZt8xE69ELTXV4XMkJpk/ZPc67Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBHlP9uJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712729978; x=1744265978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AcH3wofH9l0Vl13WTjCwq82yjOD7Bzobr+AOm8s7WQw=;
  b=hBHlP9uJslrKVbm3Abj+u5sm8AQURR9muycthzuG63u8rGQ1793+lHMs
   CQvBAddFckJ1eQInbuPwYY8fFompsm8xbQ692SevvFyYvfEVWjPCuYWPD
   QR7GRUhwmtGieMckifnfpshkLkWc1ZvdMXK44fNwOPt9USqGw3fZRRHp+
   C+xsRfGcUU7SfXHMe1pG8Ga1dJgPf52Y7qYRo4GlOMHaY0T1F+TsuLjl+
   XF67o7c9CJq9ZoVv/o0qhvcYseepx24aekn+FYtfa3ipNGEECsotUnsRK
   mby2WpwCkHqGOHxbhmUmV3nG2P24uUntR1YcjN9NVUkz5bCwucTF0JDoB
   Q==;
X-CSE-ConnectionGUID: m2cBowrfR06NTzNsZy2h9g==
X-CSE-MsgGUID: s3AqEJR3SwuZGznH9l20mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18640190"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18640190"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:19:37 -0700
X-CSE-ConnectionGUID: sH2fg7Q4Ree/+8Bddh4u5w==
X-CSE-MsgGUID: y8TQMPrQT4yOnUNXAFM9BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25132908"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 23:19:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:19:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:19:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 23:19:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 23:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnsnnXF9RWD5MBKanYCB13BIqKUBrh1bxXPsTNasTYDf2IhsUYmVLumjGL3j0KXlzR0KEDjkuU5spZnz5RY52txkwcz3TJMXH+7vU/4ZfcSgZJKT9j9MMprhYkry6ql0h9DbTg7qoD4yMbd2T2QCCzjA0cIRdJU4XzqhQkuOeRva/rwcOZKTwufy0uaKfmrgCXUdIHtCBWvAbEnN1p8QpOLXFuq9FZZaw4whG0wt/Z8Kf1BgezqZGOnp6w3RZLku5yyRgDwpD/blVt2pIquhm2UdC5lArZC2VqOzPOsQSD4+THtgmdK0Ouaktn8PD4B76WTNf3J0Q+P+gzMz7yEXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g68ezOYiCsVGWRMxkz1Zp64+bkyodtLbqlJXnASvXKw=;
 b=ghClnMquTLXPX2dBbKHW3CVv5NwqYuFcQCJ/5NL+qrF7pDdUbjhxiOrcpKibJk0YAysvrBiFSL6orDvITirZ1ybyFA/fk+GyGTI+nu3/ahEGpd8xcS43k2lr0Hrk8zPw9IonySVoHfhvFMNmlnzTF0DFK/pQPGGggFnDG7LHT9UMKzKa5MA9BsQIqBRrTp5fKJApXa5XqfLwaA5jxoNCtXUzD1rZXMwiHUoL18h34LsehsCHhgUpL5TSLbzTFQktmjxd+nlyq3luguPz0ng3m116v0i8acQTEu0ZKBkKM/6V1thRHzmiOId5oTVPTJ/0Vc9vnuPMEUzRjVhjhJTtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 06:19:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 06:19:33 +0000
Date: Tue, 9 Apr 2024 23:19:30 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <66162f721d5a_e9f9f2943e@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
 <ZgRbTfmoU3HZPfrf@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgRbTfmoU3HZPfrf@debian>
X-ClientProxiedBy: BY3PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7524:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4hlfSOcXLAVWNe8xHkuuVncl1Efym1COX9vSMqRmBj2R7NTvtB71YbE9xTWLWnPUJPi/bErhIyun8fRVBU9eSPvS/ayuaQu3h7Btat8Chskfql49TQRo2PTD1kDlOr6/DJY35x/etCeK6YbUDm75PtbQjmnyuD1MXw1VgIWJMTykSGXA/zSZTpWGrfQaeh8oZ0kGh8jGMd5YnfqmEUC4huDBZwfpPqKwIo5sLnk7ZoaqnxRloumta5CjLwQMtl3xabkUDXnmlBYldTJ37fMqFwb44yRb/+GWHizTioq/Yrz4TlqMltxlVxZO4BIZdMaeHcBhKqPQtLAjFKH5TA0sdIM1DIClrgZrfSqpZxbvexKzZ9NKchjsun5Zy63cWpKbw0sBU8JerfUWPeOSYjZYFsgf54zAKh44n914yo88te+y7WJY+zvJ0Aef5EPkjXCydu/781FbaF1HBPnM8GIUNYpqmwJJxiWe1vAx/WUYV5CSbzHH241BmwmYEaD2K5rAqb6t0gUxLYrzRuZZ1BeqcOhoKK0TnP4nGWdTZGyay4j08PUoEQqJ36v54G9DEBOS+nR81FaRPydNtYAtkNmH2fppNO0wf6wSocqwhoVgSDwPeBOcIPb2QEbOK2JZ2vukN4Q/yul1hiSA6oj4S6RKTN1LXe1OM+/Mb0NjAMR4pA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IfBaQZ5zMC3REt4VRDJ0070ejd+VSaxZIGo1XCijs0ggZoxIrIkrxK6WOD+N?=
 =?us-ascii?Q?R3pXFEVN6abumndEYALy/535X8ocInzpUME/Nq+2sRy+UxCQoZS8jnE+BJZL?=
 =?us-ascii?Q?JYQe/FB16vxaKBhZqDdw+vr09kcUnvmkQGwoNRpBW1wT2bTwuRmbRSdZ8UM0?=
 =?us-ascii?Q?ASQjhIdOZ1paiuAbSPMvT0XNDJK7OBHLPppLgArsQDOfTqp1X1+VqJMPXuTq?=
 =?us-ascii?Q?z8pguyptd6RqM1gpr/MReUJJjztltThzYglMgLnewakvPAoz/6i71g5ZCOHD?=
 =?us-ascii?Q?Lr19bf4vRFwLdejNHLcVvDdMtgqOXUV8E4/e2fqmvpOURyoYz8oufJNb5Ekv?=
 =?us-ascii?Q?nnNErF/QH/onFK5m4dCFMV1PTEGQItkD3pQHGhABNt+GEONk+wLG5G+dOsUq?=
 =?us-ascii?Q?c6eGAQOHH7yOOkKPzYmrJUWp2XvQbJ/78BxJpCeRTXdONG6+IjrFjExNMwMW?=
 =?us-ascii?Q?IrDppuF6sCg1/0+K77ZdkWcyoqNgD/GWNyL1KYbbJOhcI1TjVYP/wJG498wV?=
 =?us-ascii?Q?nfJ4Y43jz7gqerbYaPoYr0FcPz7og0trGDRrkWLy9x5PuF4CJU4lWuMNplIt?=
 =?us-ascii?Q?DBsi8SGqQONmR+DkbDpMmpi8SW2Ji5n4chYLomCf9NGxd2ztIoqrov7naYEA?=
 =?us-ascii?Q?NyHSDv8yW7qJmxURdBTDgC5IerzvQzQ3IUbwPe5qz5QaorDQuEakP+8spfd6?=
 =?us-ascii?Q?Xg2IqmihgsexgKuvvZhqx8qYbSCgD95yfzz2IkbYr9ZtP3z1FLfS7FFpHQLu?=
 =?us-ascii?Q?8aE2qxYbI0v7AwDpXG9wykC2+kQO79UzpXkMC/HEeeTAc+fJyS0sv/gdgvgM?=
 =?us-ascii?Q?XTm1mOdj+bhG0d+nKN4xOoKTUNkjvih+y0XLSwG63mdcXnIv8es8xpW2nUkX?=
 =?us-ascii?Q?y7zZ9i2IcIic0sl4/KDpChrg1lzFFdrW/4JlHbrtN59Jhb0c0L8QPSPmRFuO?=
 =?us-ascii?Q?INLUv2+LjnaFdvnJ8oDxY43KZ3gS2k5gV2VCJbh0vElOG3WcrKjUueCd8MsR?=
 =?us-ascii?Q?rFJiFrc5OEPC/ATvAuFQ8JKahCBELJodGQ4am672tbgLg2NEDcyRkRzlB/VA?=
 =?us-ascii?Q?IfEW6aYFSs7Q6zLnCEgf/JUzVFuHzFr1STe3Cx3KPdZdu3Et1fEK26RVCbjB?=
 =?us-ascii?Q?NRQ2wyKol3Qap0mFcdJ/DK6RH0j0v7UFrrI/K6K7FQmmNFryrIlLn4PCWwfB?=
 =?us-ascii?Q?0uASnLRxSuXxKDzqXT+GbNKhPS7isa7l5C+86Ei+/5ZCJlGsGmgSMepkcPCv?=
 =?us-ascii?Q?S7z6JnaJogvlJWZIcwBZuFnffm7sU2k0HquKNP4lKhgpG6ftEgy3dDXGm49R?=
 =?us-ascii?Q?z76wMndqIiazfMLqO0C1QDdADu7fbjELqTpFVHj+/NHHX2QPf/1q7crTHfoe?=
 =?us-ascii?Q?ID129VIGFdYjlfoSJMCzwBCQ6nlq3fralDILmFF2bkNX+yXTl5yzlR5JvaeP?=
 =?us-ascii?Q?597SeKV4Y1E74/WRt9LtsV8pveHEWtZ+ilUvJBXSutseJfXNAF9Vh7yU4fip?=
 =?us-ascii?Q?2RmEVxG2trwtcs1WBzINkervcUY/lvrg1R/Q/H7kVgNqK6AnQvkC2F3RasyJ?=
 =?us-ascii?Q?olnOuQ9G+Zdy4tE6oWP4BhjfrWcGyQzjGK18ayWS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aaacc405-2006-494b-f94a-08dc5926302e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:19:33.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo4eFYh2dFCRjKVP3edcez/nP4XDOBtwF43tWwCLVy57wIcRvYJskEwvfVafeHSafP4YXH86G07GTVa6K2amqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com

fan wrote:
> On Sun, Mar 24, 2024 at 04:18:17PM -0700, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > +
> > +/**
> > + * cxl_read_dc_extents() - Read any existing extents
> > + * @cxled: Endpoint decoder which is part of a region
> > + *
> > + * Issue the Get Dynamic Capacity Extent List command to the device
> > + * and add any existing extents found which belong to this decoder.
> > + *
> > + * Return: 0 if command was executed successfully, -ERRNO on error.
> > + */
> > +int cxl_read_dc_extents(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +	struct device *dev = mds->cxlds.dev;
> > +	unsigned int extent_gen_num;
> > +	int rc;
> > +
> > +	if (!cxl_dcd_supported(mds)) {
> > +		dev_dbg(dev, "DCD unsupported\n");
> > +		return 0;
> > +	}
> > +
> > +	rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> > +	dev_dbg(mds->cxlds.dev, "Extent count: %d Generation Num: %d\n",
> > +		rc, extent_gen_num);
> > +	if (rc <= 0) /* 0 == no records found */
> > +		return rc;
> > +
> > +	return cxl_dev_get_dc_extents(cxled, extent_gen_num, rc);
> 
> Not sure about the behaviour here. From the cxl_dev_get_dc_extents
> implementation below, if gen_num changed or the expected extent count
> changed, it will return error. 

yep.

> If I understand it correctly, if the above two values change, it means
> the extent list has been updated due to extent add/release since last
> time we read the extent list info (cxl_dev_get_dc_extent_cnt), do we
> need to fail the operation or try again?

The original series was safe to fail the operation because the list was read on
memory device driver load and not when the regions were created.  This is an
oversight with the new architecture.  Now that regions query for the list
independent of other regions being active the list could indeed change during
this operation.  :-/  So a retry is necessary.

Let me work on the retry because some of the extents may have been surfaced
during the list processing which means a re-read of the list will need to
properly ignore those already found.  Or some other tracking needs to be put in
place.

Ira

