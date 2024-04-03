Return-Path: <linux-btrfs+bounces-3894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F1897B92
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 00:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AB4B2682D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC315698D;
	Wed,  3 Apr 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYwYk4kI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C2138494;
	Wed,  3 Apr 2024 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183000; cv=fail; b=BjC3j7Cis+jlf68bO/ZBV0ssl/AYY0ZvbUTUmQ/eWC/AuWB6SZnrk/ese/FV1a0OHuU7VtJpS1B+uOCGzYkJv2pfp3wKeyWrLabGzh1VHL2dn204CLqWtnoQUEjJDuq/two2i5X7qqvjsXXjOcztekSbpPRDglKbyVIOYVIqT80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183000; c=relaxed/simple;
	bh=xWfxjXzb+1nsndsO3E5Qn3Gs5pOkBqR91teH4jRPcXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p7PLkyvwX4Sn6z0Pu7NJQJlzSSK67NLuGU48HdUutm6GxRJ47syOdc155Lw5IXlZzRn/RtIYtLwlf78lzCsGdZOtkUmjLic/sPr4NDBr8ujN1PBq5oe4Y+xZzMUlCun0p5OgBOJlOClPX9U1o1SEbOhgmiSukVS/S/qOPpKR+d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYwYk4kI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712182998; x=1743718998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xWfxjXzb+1nsndsO3E5Qn3Gs5pOkBqR91teH4jRPcXU=;
  b=RYwYk4kIvwJC/JLelWdLDzc2acUqs+3HT+ivQbZsdvwQjSGCSDeCCh8J
   cTX/8EDUcQ0+ZFIhTDgA35BN6JRFEQUh6SAiUVUkv+zFTM7lWWdI4KTRK
   /PPzn75DJQ1+ZSAv2ry91cgmbzCycS8fGsFldIJ8W2PgnwP9HRzqOvKmw
   eOpo3J2FQMu5MIOtJQsoi+7NQmm4hIYwnxeiEl3FZEsuMQNjCSxC8XrWU
   KNNUQbNqznFEvKxOvR54XvV2FNWyPMUER9o3rV4YEu94/+R4BeEGcdLjY
   Z4jkIQgk3uHfIxHMifoEAH8M4z4hULldq0hzIEReoUIJhW02fOr8XqnqT
   w==;
X-CSE-ConnectionGUID: oKyx5g0vQ1CsLmwfWBa1yg==
X-CSE-MsgGUID: wNDoYlyUSTCksssBvCFV6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="10411381"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="10411381"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 15:22:49 -0700
X-CSE-ConnectionGUID: REAI9ISrTL6QQ8UUjDSajA==
X-CSE-MsgGUID: y/4+sRmuRNiieTFRcOwsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="49807055"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 15:22:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 15:22:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 15:22:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 15:22:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 15:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqfXPVzv2FjvxvwaIhssuxpx+t5h6UFog+Zg3MpPBZs2+E4i4FAW7sSOscNlagOlvYkI9MqFDimVkkADcHUKWjv3zZsuBprPyI1iMUZ+lhQjBLdGYOKlVNQZ9ClvH+INy6lIeNmbjzfENaE5NWWB3/cPODjSHoK30nSivyv0Grd2kOxLaA7zc5Hzg8RdQ5QMs9PeaUQMgO4h06T6Kq4gw9GSGeP3j+QLe5hE+XtlAg6nE6AIjGYLwlflYSHgVHjJuV5LCziCyZe1jPEv5yP4h7/gHKU2gaFVs94tGBwadov0AcvOdyXABnNGiUB5F3U7HRPPcTg0sELFHZfOLVC7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btJU6d8CWUYPmQbaB0uOIy4iScJ55k1UE6LjmpAjLYs=;
 b=ZRWA/m3KyK/sOVV0goXMgZ8QYQzuwT5gcQOehA6lwwXyJWPZco/Jpjg+LFlvz0rr7ZtwxeLIOksIDqYgWnmJP1wiKxDbNdOoe3hEMjz1gm2bgV9StgZpOVU7qz2lllR2ktIamCP4Flq02meb4bEkQHqA5V4Z4K4ewfl6COLaxggDQOU5YjGQy0+5T7u967nzeUySdAWWbZd8u7WR8vmZFBTQKeUt3aae9jIG+4V2oAa7pWj03Tdj3n074WQrwK0kjzgk+Vn1YkP3D1xXqgKKRqNsg4Xv0n9SLF1RGY+hJ6VbWvz6s28BSZB6RvTLIp51OA/A8ppkRZocGteo7H80xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB7702.namprd11.prod.outlook.com (2603:10b6:a03:4e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.20; Wed, 3 Apr
 2024 22:22:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 22:22:41 +0000
Date: Wed, 3 Apr 2024 15:22:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Message-ID: <660dd6a5dccbb_8a7d02947@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
 <20240325174002.00005dc6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325174002.00005dc6@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB7702:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hhxftu0SsRgHf6JHQzbQ1mpuNqy6QAmyqyBByiR0R9Rbi5igh5e4aDJGXitXLS5UiOoP/tdTc8NccbVeo7A8X4UCfVsNvPmU/5xq2F18la8TEYxgoiD5nPVyzr2brodfyNHB4GJD+aPwirViq5D2weEb7/W4I15rpCJoWxeRrthIC7dY9N2rl6msSAaMfuBDH35sDFjlTZHX8lHH0HKyfcRoveYcBH4crEJ6lIAya0KNZlIZrH3RsiIaCfmHoujsCGtLsqQNZ48vCrNsna1oVax6WpB5xqgDHjrDU7HE4tvARTshszUQsXTtpMWa+J9V+I1DMFSQ8uxDuEdNVzHPCSczDltK+SpDB2zLn7x79R3fpFmrJclZGvkahj5gKV8zTiyHP2k+1EaK9DTfcy1rCYPJ/WMW/RvZ608jBs1z/EnT2hr+V26x0+jyxha4JSP82lwhj5tqDWxzasG2/gjYS474JswcWko5i9atDCaK1rrrxXYURJq1d29w7u+MO5nQLYYmh5vUh6SRnb5ENfCkYT6PN+Hz43Bcz3ASP/hBiFTdVBlWNpeLlkya8CMnzHqauxC9x2UHNVm1mu2y96C/FQiultNeC/W3cyy3SWLuvP3NUy5dfhkA32HUw1uiTvnZy1mKjHsx+6XzAwvRCveR4QIc7KVRR1w8zWEsUzfdakA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eg+S0txgYsAl9RZKgAf+LapWOR4dbTMgFQRiffWs7YHxGL523Qnp1GRNAub9?=
 =?us-ascii?Q?QS2tMLiaWF46fSpHzYIGCsS03gjdkA/VJqgoceVmgfRvhOiF0b4LkCtK3JOP?=
 =?us-ascii?Q?5IqB1gK0Q9b5Jjeph5da/Glee4h8wbyJsg1CHMa6ZYCSVhobDN4Riz89dEEC?=
 =?us-ascii?Q?v02UrWdYyBVqBC9nI+7252JIT6jNIFwyKHKAaRv6Ou5tRq+wPtDfKwOjTBib?=
 =?us-ascii?Q?5SVoy+G9N8Wz9fYbvpP904/veIfwXKxHvGKhK5JsvK4zbLeEw7rI7pL+tkrJ?=
 =?us-ascii?Q?D2g1u72lgK7RVrXQsGwlCPa86LYRfAbBrPxoOZdwfDHIPcheysE9mont7hnk?=
 =?us-ascii?Q?egDFetRGWzCNrEEh5w9R0cw9kXpu4pvtZMf27wajZBNl724OMRp9miLPffYB?=
 =?us-ascii?Q?2mCEcDJS1EP0MPz24hgFzfEk6t6imzfwylIf17dhvsSw91h74j5QD5mwf3Y9?=
 =?us-ascii?Q?P1XVbNB9Eti0oxdh5SEH0zPvXyqNx8xCSIl3yQ1ZtJa+reJTrv0gD058+hEM?=
 =?us-ascii?Q?1enFk7FOMTXehswH4ssfobEXN9JKjw1+DA6gt2VYBDNqecn/I22iGhDyeInB?=
 =?us-ascii?Q?QRCLYjnRC53vOaX8sLPQztfkYqzypnJFbLyt8KyL2zflGfCD6Csj0wE4g7qI?=
 =?us-ascii?Q?Ntdo4sooql4JzZZfw+qQ6rPzvwUVSFXpr8l9DGs8lpXV3y7kpaQFQvcBKJem?=
 =?us-ascii?Q?O+b/uYAH61YeItrg+fbxQdLFAahElamtrCD4hzYHeoZDx/7GiGjJ9i/lAmVG?=
 =?us-ascii?Q?mCj5Foi2i2BF/7T3lLsMG9Bor72eO069h9aDZRoB65Y9X4ELvtDGC6dHFenX?=
 =?us-ascii?Q?y6aq/J2XDu9Bee9mTpnPVJtOGYvky7fa+rcHe51Vs7RiJGs2tmp0XSdglM9K?=
 =?us-ascii?Q?G69OAaZ28n+E3koSqosWWlx5RwQR4ZtFiclDghVnDhXeyqaCqiG9o1Dz12TZ?=
 =?us-ascii?Q?0b5UlGcLRhFlMW6+Wgj3QhlJMelVDWirxNDnSWA4sdsxBoKepX5X5e58io0I?=
 =?us-ascii?Q?m5Oz7BbT4CbSPdcoxirWfaMgKUHPV/0Ex/RSZwPTEn2ivcWXMgiLcf8CAtQ5?=
 =?us-ascii?Q?+NoYeE0logv6iRr4x/3tENp5Xqci7HPHzLZnfK1L+pcpDe3yptHSDDN04ak3?=
 =?us-ascii?Q?Pe8DymHyAvckXYooPxvWsjEUZ1BbMxRTM4bYzpBsaTr5wKssKQrwQUBM2RMb?=
 =?us-ascii?Q?3PHl7KUEDw1aKak2GL1kgjmoLixd8vmIGNj6qLL42JJ2u/gr5PuPhS3ZPQ2F?=
 =?us-ascii?Q?qwWYmyO+kfGJr1avHKp3y8NkBMYZC5HPg+CcsM8RDkGFEb0ehoAKatUcCkA+?=
 =?us-ascii?Q?1mXYiFoztr91PpfEywLhF0IinvDXrzg6rn5x8spk4x2AEYKSlAQ/Eu2MDrzV?=
 =?us-ascii?Q?OeY+TrGDRYzzDAkOWRTVUS+cGeWSQ8wgm+A/a19ry8tItRzidjMSSB17m+ym?=
 =?us-ascii?Q?GXrQpAhHP1PsHTm0nPeKcO0ofWdssDqTS/h5mytwGhxeneoOLxVJpxuy2OhS?=
 =?us-ascii?Q?2+FIO3/tnJUyVTrdcIikt1JD6Ug2N8FAulQH9+oPweYc5yOG/F39VQNBSPoW?=
 =?us-ascii?Q?8Ow7KxEkwQQg/R+HDEMPHrBjXS/9LeBNCZicjhTS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc95fa7-6401-4482-12b4-08dc542c9359
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 22:22:40.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQKShqlUwM2pY4rf1czNgx7C8ySF/ysmQQioUMES0gR7ZEgZJCTDE9LwQr9yp+tnJ0UFZIvg0Svh7Zmx95Fy/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7702
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 24 Mar 2024 16:18:06 -0700
> ira.weiny@intel.com wrote:
> 

[snip]

> > +
> > +	/* Check regions are in increasing DPA order */
> > +	if (index > 0) {
> > +		struct cxl_dc_region_info *prev_dcr = &mds->dc_region[index - 1];
> > +
> > +		if ((prev_dcr->base + prev_dcr->decode_len) > dcr->base) {
> > +			dev_err(dev,
> > +				"DPA ordering violation for DC region %d and %d\n",
> > +				index - 1, index);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!IS_ALIGNED(dcr->base, SZ_256M) ||
> > +	    !IS_ALIGNED(dcr->base, dcr->blk_size)) {
> > +		dev_err(dev, "DC region %d invalid base %#llx blk size %#llx\n", index,
> 
> Odd choice of line wrap.  I'd drag index onto the line below.

fixed.

> 
> > +			dcr->base, dcr->blk_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (dcr->decode_len == 0 || dcr->len == 0 || dcr->decode_len < dcr->len ||
> > +	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> > +		dev_err(dev, "DC region %d invalid length; decode %#llx len %#llx blk size %#llx\n",
> > +			index, dcr->decode_len, dcr->len, dcr->blk_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (dcr->blk_size == 0 || dcr->blk_size % 0x40 ||
> 
> Hmm. I thought we had a define for CXL 'cacheline' size, but can't find it now.
> If not we should add one (and find a better name than that).

Asking me to add a define is fine...  Asking me to name said define is...
The issue...  I am absolute rubbish at picking names...  :-/  ;-)  :-D

> 
> > +	    !is_power_of_2(dcr->blk_size)) {
> > +		dev_err(dev, "DC region %d invalid block size; %#llx\n",
> > +			index, dcr->blk_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(dev,
> > +		"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> > +		dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Returns the number of regions in dc_resp or -ERRNO */
> > +static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_region,
> > +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> > +			     size_t dc_resp_size)
> > +{
> > +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> > +		.region_count = CXL_MAX_DC_REGION,
> > +		.start_region_index = start_region,
> > +	};
> > +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> > +		.payload_in = &get_dc,
> > +		.size_in = sizeof(get_dc),
> > +		.size_out = dc_resp_size,
> > +		.payload_out = dc_resp,
> > +		.min_out = 1,
> > +	};
> > +	struct device *dev = mds->cxlds.dev;
> > +	int rc;
> > +
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	rc = dc_resp->avail_region_count - start_region;
> > +
> > +	/*
> > +	 * The number of regions in the payload may have been truncated due to
> > +	 * payload_size limits; if so adjust the returned count to match.
> > +	 */
> > +	if (mbox_cmd.size_out < sizeof(*dc_resp))
> > +		rc = CXL_REGIONS_RETURNED(mbox_cmd.size_out);
> 
> Why not always return this?  If there was space, doesn't it equal
> the value set above anyway?

I've been looking at this more carefully and there is a bigger issue with
this.  I need to update this code to handle the regions_returned which was
added in the errata and get rid of this macro.

> 
> > +
> > +	dev_dbg(dev, "Read %d/%d DC regions\n", rc, dc_resp->avail_region_count);
> > +
> > +	return rc;
> > +}
> 
> > +/**
> > + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> > + *					 information from the device.
> > + * @mds: The memory device state
> > + *
> > + * Read Dynamic Capacity information from the device and populate the state
> > + * structures for later use.
> > + *
> > + * Return: 0 if identify was executed successfully, -ERRNO on error.
> > + */
> > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > +{
> > +	size_t dc_resp_size = mds->payload_size;
> > +	struct device *dev = mds->cxlds.dev;
> > +	u8 start_region, i;
> > +	int rc = 0;
> 
> Is this used before being set?

nope...

> 
> > +
> > +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> > +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> > +
> > +	/* Check GET_DC_CONFIG is supported by device */
> > +	if (!cxl_dcd_supported(mds)) {
> > +		dev_dbg(dev, "DCD not supported\n");
> > +		return 0;
> > +	}
> > +
> > +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
> > +					kvmalloc(dc_resp_size, GFP_KERNEL);
> > +	if (!dc_resp)
> > +		return -ENOMEM;
> > +
> > +	start_region = 0;
> > +	do {
> > +		int j;
> > +
> > +		rc = cxl_get_dc_config(mds, start_region, dc_resp, dc_resp_size);
> > +		if (rc < 0) {
> > +			dev_dbg(dev, "Failed to get DC config: %d\n", rc);
> > +			return rc;
> > +		}
> > +
> > +		mds->nr_dc_region += rc;
> > +
> > +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> > +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> > +				mds->nr_dc_region);
> > +			return -EINVAL;
> > +		}
> > +
> > +		for (i = start_region, j = 0; i < mds->nr_dc_region; i++, j++) {
> > +			rc = cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> > +			if (rc) {
> > +				dev_dbg(dev, "Failed to save region info: %d\n", rc);
> > +				return rc;
> > +			}
> > +		}
> > +
> > +		start_region = mds->nr_dc_region;
> > +
> > +	} while (mds->nr_dc_region < dc_resp->avail_region_count);
> > +
> > +	mds->dynamic_cap =
> > +		mds->dc_region[mds->nr_dc_region - 1].base +
> > +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> > +		mds->dc_region[0].base;
> > +	dev_dbg(dev, "Total dynamic capacity: %#llx\n", mds->dynamic_cap);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> 
> 
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 79a67cff9143..4624cf612c1e 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> 
> >  /**
> >   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> >   *
> > @@ -467,6 +482,8 @@ struct cxl_dev_state {
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> >   * @exclusive_cmds: Commands that are kernel-internal only
> >   * @total_bytes: sum of all possible capacities
> > + * @static_cap: Sum of static RAM and PMEM capacities
> > + * @dynamic_cap: Complete DPA range occupied by DC regions
> >   * @volatile_only_bytes: hard volatile capacity
> >   * @persistent_only_bytes: hard persistent capacity
> >   * @partition_align_bytes: alignment size for partition-able capacity
> > @@ -474,6 +491,8 @@ struct cxl_dev_state {
> >   * @active_persistent_bytes: sum of hard + soft persistent
> >   * @next_volatile_bytes: volatile capacity change pending device reset
> >   * @next_persistent_bytes: persistent capacity change pending device reset
> 
> Looks like we have some ordering issues ram_perf and pmem_perf (at least)
> that we should fix up as a precursor. I sent a reply to the QoS patch
> that added these.

I see.  That will likely resolve out when I rebase.  But seems nothing to
be done for this patch and best left as a separate patch from this series.

> 
> > + * @nr_dc_region: number of DC regions implemented in the memory device
> > + * @dc_region: array containing info about the DC regions
> >   * @event: event log driver state
> >   * @poison: poison driver state info
> >   * @security: security driver state info
> > @@ -494,7 +513,10 @@ struct cxl_memdev_state {
> >  	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
> >  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> >  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> > +
> Trivial but this is an unrelated change and shouldn't be in this patch.
> 
> >  	u64 total_bytes;
> > +	u64 static_cap;
> > +	u64 dynamic_cap;
> >  	u64 volatile_only_bytes;
> >  	u64 persistent_only_bytes;
> >  	u64 partition_align_bytes;
> > @@ -506,6 +528,9 @@ struct cxl_memdev_state {
> >  	struct cxl_dpa_perf ram_perf;
> >  	struct cxl_dpa_perf pmem_perf;
> >  
> > +	u8 nr_dc_region;
> > +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> > +
> >  	struct cxl_event_state event;
> >  	struct cxl_poison_state poison;
> >  	struct cxl_security_state security;
> 
> > +
> > +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_get_dc_config_out {
> > +	u8 avail_region_count;
> > +	u8 rsvd[7];
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[];
> > +} __packed;
> > +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> > +#define CXL_REGIONS_RETURNED(size_out) \
> > +	((size_out - 8) / sizeof(struct cxl_dc_region_config))
> 
> Can we make that 8 self documenting?
> offsetof(struct cxl_dc_region_config, region) perhaps?

As I said above I think this macro is wrong I'm adjusting to remove it.

Thanks,
Ira

