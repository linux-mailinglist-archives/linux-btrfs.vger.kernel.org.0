Return-Path: <linux-btrfs+bounces-4092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBFA89EA6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 08:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753CFB21D25
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A7637168;
	Wed, 10 Apr 2024 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z910e13P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30F219F9;
	Wed, 10 Apr 2024 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729405; cv=fail; b=iGH/almzUbTBEvgE6oFsxT2OeuEtJTKItbXlBuosiFq+PdQ40L1Mt1H2msFNGFqG2FM15EAfUNBaRSVqFKMwTFwWXOuHbYT0uQirW0inXlOmXsL+vS2Rj0fsfjWY2ktZXF0OVVW58kvQq3VGL4sEbSdlm31PJcphtDHEgxirV3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729405; c=relaxed/simple;
	bh=IEK2p9g1R6A969xsVjw17eBbmPVKWhDJ1SCVLOOuWqs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5HsmMcdn+qe83RSrEeF6MCPyqRdDrX+990fi22H6mtzD08aucBDm7SwkNXvCT2TvKuUbzgInVJHWfeFiVC95sbWrXPdCo6dfz3CgVDoNhMFVFHdbVca4rlWXY5TcDaiVGJo6zMnZB568ExnCUQj82OgoTdB6+Uv6OlnmJRgjb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z910e13P; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712729403; x=1744265403;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IEK2p9g1R6A969xsVjw17eBbmPVKWhDJ1SCVLOOuWqs=;
  b=Z910e13P5z+vRVRxaGaT73z+fQRmuhFTTH0We8lZdjGt7BUozBI9TKvL
   wegaKQED7AGwr8R8JLvDD1CfjtvDS4IE1U00lMdVEtsbMiTiYCjfbfPTx
   uHMz7dwjm0T55uHFdo5b96eeOA1s8TPDNYt5ut8JrsmG23MXQP4YG/bjP
   lkFPL/uvNyfflTwk+DNymQ3h/3BnFN1TIIiXR6tdEeyRDbLiCbM0hPyli
   msv6GFtWoQRPgqJVgaA2lI+vch+e2Ye8TmacCcP7hMtyoaFzdZ0NGo7Rl
   DfH4h64L7864XElbg+jhzjUDhKjJAIWSLrq7+2bB27zhELffLJRdBT9mY
   Q==;
X-CSE-ConnectionGUID: do9dPZoHSBOD0G+E4sBFHA==
X-CSE-MsgGUID: lrm2N3ykSdCXnFXeOoPq0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7929789"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7929789"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:10:02 -0700
X-CSE-ConnectionGUID: habuuuqhRySdqzRLH4nrlQ==
X-CSE-MsgGUID: jI42SIGSSaS67gGbsi8lmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20422746"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 23:10:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:10:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 23:10:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 23:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y91OVT4qKczyK9siDdpoLOMAQ4sCiL8Px1lGugxHx+NCkco1wOVDty3AFRMIy4tRjJZ5IL1ZlPgxVis3O5oNoEiLe3hj/6NaFcP+tTVxXchax6dqk38+qXuZQkDVVqw9Qrbx3MB01adkgUZEnLs9wQ9TM6m8a5bXLTnuOU0wzq9mF1D6TUVsirxjPAX1NCqX4GTLdQvdWRMgCQ3QrCflqvPpSGaSMpvoRGLdrA7pnIpBe8fi/KQoX4PlIcE41bAgQ9bwgsAcE0v+cTJ8e9unvxZTKPZM9ScemdVxFJ8e9z0mFnSVJkeQOLP0QfIp+qcOklLOpH++46/4YWcwBBcDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1is//JddQ0SldA8hKkuHLPr8Tz981+FAaUdMrcoLyx8=;
 b=OOlyBXhit+CIk/BiK4/bnINalpb37OKFoVGqJumbLCF+zL+TnE7hmFPIv9bFeA9TmSInCoMYLs9qN+XjndFHiLu3XqAhCFbgP2Z1Q7wbg5hJVZR+PVlZWw2zLQEcDlYCIPAnsTgQcsMVDHPbUzUfD5hqDdXcYqFnH9kP1HH3Cw3KQloqy/iT9sQZ7aIqSj300VOSOr1pbCYfXT3E5QiavIdDza+oPMyOqHQiGMF8l380ny/Le8Qk/h/Dcm+U4nuSaui0oxjsgVQWqNGjaf+Y+daRG3qpB6JS1vkwg8sh3FksXfl02RFTlCoQ9LN4boj9Mj2arUXNs7rhjs5bL+jFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 06:09:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 06:09:59 +0000
Date: Tue, 9 Apr 2024 23:09:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <66162d33d480c_e9f9f294e5@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
 <c2aa9a19-a0ab-46c7-91fc-f3903142097b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2aa9a19-a0ab-46c7-91fc-f3903142097b@intel.com>
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4947:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzpWV3JU/j2HKw/lhqTw+UMs4dtFQsp3iU5cg2Qfn8Cl6/OulPy34ygacNQUe08fvDomEYBtg+wRxGa+Q4hkB2PDw0EYZX5nDOx1szmWRb6la/4L4VSH/8A14GPH9C/5gRxr9R1UEl7Lv73DvBMLwwdAOk+6s2niqE7ZOUPwu6+1B/wI8AYeLfdth3Enxpg/Z5XClD6wGbqM0LUGe7MBrnc1xPwMnQIpbqihz2dERYXgwPy4UawngvVrCg5ctbiY4pNEjcck1RCLbUCmF0PzCp/1uFStEyikjgelDKjsOzeXHrohAmc9dm2XwWeoCAAM+nglugY2huVqJW+vZEV1u5/gn45AuI3klweE4SRpVFfS0aI1R3OenDw5JYsX1pcy7dXdmU33GUcM1WPJWyfeZybdL0cV6sl9x0bXUlZ7tJcVbRPZ6h9FXufDK698YvBOuTfPi5OlVIeHzaEndgOJe7xOnIV50XabKay8Rz7RFhJC62VTfGX41wkTK+Y/ugjo/uw9C42HPy/1zKtkT7TN8XXCQfwDKI1zJjcyNgdjR9PosYxvkiQSwMoR1/kFsEnO+jt3TH33E73ivh/vm0dXtQfv8+Eivw9cQgqh5VuJY/LfSJHqG0HFSkto3ptYx1vBNQ61jlIM/QutkMwWroItQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbFX5ARbquz/A1O+ImmJ0Zvv1Y4t7WjW991F95V+ePoQG7AClS9Mh/BMj1bc?=
 =?us-ascii?Q?2E79HdOz9k31u+R/VdDN2C7peupOyHL8gjmxk+UsKQxjsbn7xIXFQ6jwGpsF?=
 =?us-ascii?Q?ZjGke77aq9tvM+tMR75OVultg8/XhS9juzxU9RMCasWGOPMKrw8Ja2yuK7ES?=
 =?us-ascii?Q?YjIOsQDQDr7Vg3j5/pEsdQBtOr2i2TymLgnovgPTOWOFL3g/iWPWPp40otPR?=
 =?us-ascii?Q?Ys4Onv4GV8UWXaaL+GQK2ZvKltwt5HRHlNGDYnGRHHPPkAcmAZ34cwe6XSjv?=
 =?us-ascii?Q?2yc+jhTS47fNUJPavLwpBzXbSArcAYzDR4biMbQwipBAjTgie2wDkJb//K93?=
 =?us-ascii?Q?OrAPxsqbRjsM46+AMkZt4KfEYblReTj2TdpOq5o7BmCL8xtHUXKet+Nxf+7B?=
 =?us-ascii?Q?e+kmbJ4XYgqvMSvnLuo40uDLOk3S0jyotZLt+INm9IQDOpVUsDDAh6mZ2Qdv?=
 =?us-ascii?Q?mloU1npoVCIOwETpi9g/ysC/qBTTMtqv6CU8T5uCDXE+B6uFWdmtSHLgKOP7?=
 =?us-ascii?Q?U0cdKENtc+oR1kpWn9Eu/ux/gOah0hSPDYfFIO0oGYOXw49jcVes/qHV+bqF?=
 =?us-ascii?Q?/P2BelRJrosoQdfVgUIw9XCoPwJ+VwOaoJ2McOUMpol3EC5QPsQ6/3PTcfch?=
 =?us-ascii?Q?nNRL6iiS/lkNhUDPbTz4W1PCthrhI+hlDtzLtR+47Fhw2oCxAKHKPo1bUaz4?=
 =?us-ascii?Q?QCqtV1zM6MM39IcIsQAs3BTQXNR+MZ+paqQR0a3uR9d0hke5WikupFqXjFAo?=
 =?us-ascii?Q?tXeeO5Q1TavjQTn4CQfh0vflnfeKdXjUitu8dAsdSPbVpJTdsj8ihlVz8xvq?=
 =?us-ascii?Q?xwgtKxSirWxdG89KsmMTgfaVRI5cSNd+Imz9H17CLdBMwljze5r2xMGT8Of6?=
 =?us-ascii?Q?knidd1ijIlvZ5xoacgWdVjskFVQhRf7KmC+LcBqqEoVKqcyhscQxYw/byw2f?=
 =?us-ascii?Q?yamjjif97/ULHWGS0F1KVkU1VynHvm82EFtmZRg+oJrtk5c+K5TNKdTplnjp?=
 =?us-ascii?Q?udPd2x9RO/wv3fe1+y/FuySw5VUel0eABS65ZURmi/iXqSMMgKp0gPkTJ9dQ?=
 =?us-ascii?Q?BTYlq/Ohh836bPkBl7jvzTxERp/BBGTY/KWgbNMqxPV46iVf/9gpIRSXlOBH?=
 =?us-ascii?Q?9YNffSLzKtf2wIe5qSRZa7bJYuiaWcUub/q/mKZev27qUKXEgiTqoOCv2EdY?=
 =?us-ascii?Q?jamem5zsRTPeHoSDZaXmRppvGcdeBKJ0zmkN+hgWAaINS8SDWy3274g6FgYP?=
 =?us-ascii?Q?Tvm/i16OVLkxT1b0f+09AraLYhl18sXrwZatRScKt0sjggXYkDBpee125UpR?=
 =?us-ascii?Q?R6eowxk8D9vNTCUkN7Ppy5N40J/NeGrXUHDBBGhHHTIDjOIh/no9jXh8mRuC?=
 =?us-ascii?Q?WJ9Nr1qNoxF2Gq2HqTsJDam7jnVhP0Lj0azg9GrTW/WaZR1CcoIJ6YVuabjA?=
 =?us-ascii?Q?bQ83g8LL1PG/X0EfewQgeaB7tIGL64+XMamOKti7j46jJ8HHGK3tFWhX94K4?=
 =?us-ascii?Q?gDGNSm3w4y2P7uoss4bz7Ggm0p5X3RNZ9m9+AT9OnzQ4pauDz5RXTB/spHl+?=
 =?us-ascii?Q?VcvrsOHHP1LdZLeccydmEPUSXWCYKdmQULkkdgxZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a93165-8edb-4e0e-ebb0-08dc5924d9e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:09:59.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsT9oqtcpdwWAFMtOo4SRZtUkfX4ELOqQ4ns73IzwWnIMQtMvGe5pFWakRHvRKk/Nd84TFuzLYLEcD0ajq/g4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 58b31fa47b93..9e33a0976828 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -870,6 +870,53 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> > +			       struct cxl_dc_extent *dc_extent)
> > +{
> > +	struct device *dev = mds->cxlds.dev;
> > +	uint64_t start, len;
> u64
> 

Yep

> 
> > +
> > +	start = le64_to_cpu(dc_extent->start_dpa);
> > +	len = le64_to_cpu(dc_extent->length);
> > +
> > +	/* Extents must not cross region boundary's */
> > +	for (int i = 0; i < mds->nr_dc_region; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +		if (dcr->base <= start &&
> > +		    (start + len) <= (dcr->base + dcr->decode_len)) {
> 
> Can range_contains() be used here as well?

Yep and done.

> 
> > +			dev_dbg(dev, "DC extent DPA %#llx - %#llx (DCR:%d:%#llx)\n",
> > +				start, start + len - 1, i, start - dcr->base);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	dev_err_ratelimited(dev,
> > +			    "DC extent DPA %#llx - %#llx is not in any DC region\n",
> > +			    start, start + len - 1);
> > +	return -EINVAL;
> > +}
> > +
> > +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> 
> cxl_dc_extent_in_endpoint_decoder() is more readable

Sure but we are getting awful close to Java naming there...  j/k  ;-)  Changed.

> 
> > +				struct cxl_dc_extent *extent)
> > +{
> > +	uint64_t start = le64_to_cpu(extent->start_dpa);
> > +	uint64_t length = le64_to_cpu(extent->length);
> u64
> 

Yep


[snip]

> >  
> > +static struct cxl_memdev_state *
> > +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +
> > +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> > +}
> > +
> >  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  				    enum cxl_event_log_type type)
> >  {
> > @@ -1406,6 +1462,142 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> >  
> > +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> 
> cxl_dev_get_dc_extent_generation()? or spell out count

I'll spell out count because that is the primary goal.  The generation number
is just to be able to check each query to ensure the list does not change
whilst reading.

Ira

