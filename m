Return-Path: <linux-btrfs+bounces-4090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5331889E9F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 07:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6C51F23DD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 05:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F6200CD;
	Wed, 10 Apr 2024 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuPaGRK8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B94C129;
	Wed, 10 Apr 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728011; cv=fail; b=GKwVEthkae9m7fg88t3VzYiXMJywNPWVmRQfXg80Amdnu8L6mxBFhyRSgdkcz6b5HgBTDwleRWXCbxqcbgIOTCAmj52TBpwB4/0NdogqZ6IvNg3VaMpbEJCCFxULpjpQviwJ6XCuFkN+oj389lDNSdIH6d+blpfAEIz90u+X3Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728011; c=relaxed/simple;
	bh=8US5YAD7Rvxpx3BCbuyBopZh1vuCuYHT6EXXGNaMi6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LeNM3sc8c67KsFAlRPM252FAQ7pEszv1MOvON2LnpeJUQ0MXdcdh71Ht3baXFoso6IxXYTCd1v7Nc5TfySxJg34Qvng0fKy4EdzD5Xmvph1tvmakpAzDS6WXAU61AK2CfrLpt028x9wDnYrQxzgrCs2gM4pZ1hIQ5DxGEOCoX5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuPaGRK8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712728010; x=1744264010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8US5YAD7Rvxpx3BCbuyBopZh1vuCuYHT6EXXGNaMi6w=;
  b=PuPaGRK8OKSXwf0yUmlTTgKtKqS2EsGcJYKlj3ikYXGB06Xzh0D12f75
   0ogdyXzc28zm6J9I4LZLsElyfkS6oaHMjRk5OWi8MJuNWt2gpmHkKJQO9
   QEzIhWG4M7/bwAFi/ecz8A4yW7QpLfkBtyzDiSDg9Q56QIHPIEk5NlAvH
   kpGzmPMkx2Rp4pjJo75E/Dy2uQSkvct5uAa7mRygzZ0NAnlrQ7unVGc1m
   czOONdLlt64aANgzi8VvOSCq+34RQRVKqJzU/elh20m4OJ6Zvh7vuGSwW
   5o+8jhwPILG8hwsH+SI5b/Dy6AXrq+y6i/M0YUxHsU6F07DKhNd7g2hoJ
   g==;
X-CSE-ConnectionGUID: t+VYfV02RmS9Em1gTLzcMQ==
X-CSE-MsgGUID: wjFlMKONT5e3gKlF3AJy1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11038192"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11038192"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:46:49 -0700
X-CSE-ConnectionGUID: fFJcirA6SvO0Sr8RlMvKqg==
X-CSE-MsgGUID: FMpBvB7yTNy6cjy+X1hmNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24943009"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 22:46:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 22:46:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 22:46:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 22:46:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCAYXFYK2HWmjyt/2w891ppIRe7eDn7oJ3sH1POtqEtBNISAWjjZKguPlF2cH7BlP5LOCzDssWcMAD1GNu7bDyWXphDTQJm6DNL/zVYJpakt2QKwi3FO/rFFU7XHIJ7yukJHucJLMyDsZKPUuABD4UvZAlMB4ioSISA+yhQPRUqsHci5ZRFJFmrIfojblkCj8KRx8vi8yoNyEekN8wX/46+A9nOB8HVo1KATokxSMseutUNcJcPgTbwL6O5ff8fI+EzJ+ImqSvi3R8EN7ziElEIh8j92xv7sHVVXikpJFQW4WC9AEKBYG8mO1VCWuPODCCsBkkqUlI7K3w9LYcfRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uyMmA0zd7cUBfDbHHVxCxzW0hlM15o1NBn8cHfSoeE=;
 b=nalSEpl4u9UJhGftlQC9c5GvIjnZU60He6N7QDCYqYM+9SSr8LWYUyDztwm32RAD0qybDnMrPEAx3ehz+mhnJPi0JlC6x2L1//F8tzFXoNbhjEXaLzeMv2mwV+yVFVpavdtNtjErdhbm7PEvCC0U/eI0xM55Z8b/C/KECfdq2xw4jwMX8bnHG9QHUQltq4joNbeqXncLHAaijE959yLMV/8vZHRNntqpK/3vkhOO0d/iVDcgs/QuhpJ4oQ0B9PcRzItlJSXMNshc7CJ4gHy4lIhRJhPNQC9Fw02+wcX45exSqM34Sg+0q5W2eCRSsUbFf44d4ATv8TomHa+6JXpFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7924.namprd11.prod.outlook.com (2603:10b6:930:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Wed, 10 Apr
 2024 05:46:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 05:46:40 +0000
Date: Tue, 9 Apr 2024 22:46:38 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <661627bec82e_e9f9f29416@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
 <ZgNZ2Fl8vdW_qm_I@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgNZ2Fl8vdW_qm_I@debian>
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7924:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lj0mDANxZckMQyOzp/wuaR9PqSMXrL9F0b5hDlO+a5EEPITlwFG23CYwR2zqZilrM23Sca9KgDyIbRRnWtnyg4OwuDVFwTruO+9YvEvYdN1N+LjmEh5OTKlUlXvmzM9EX9KqBHXNBWHhoAPEY2xh+2dr5vECEfeJmT6F/pnwQOb2F4rRVwr9sLO3H+kUIKq1gbIncImO2n9ZCfcqPW4+ZhXmQZUtYdy1cpT712txtZZXHMbL5/pybTtC49WPwTc9P+DMHIccdxz4O13RZP/HupVhspQinXZdWgNm8vGhxUBhAcmRkYigNaJQcfguiJpDosAe/+oXojoAlu1P/JkZvsZIqYlVvu/1NQnpWw2ZyufawUsoFZ1P0sEkxiEGGD1NWgG2Jm5yrNyKr5tqnxvnzafpqz+3rGR2m1h4ODGCQBqd+CJkgYrKMZ1TH74X9ZYz1wY7uSF4vvzDFy59+/FN5+/Y9A0xqu9Dvjsi67Tio7StdyoA69Gx+lu+1IThqPxb2ijd0VGjIRqDlTmo3K4WUeulaIh+OcLi1RI/WkFgT19/K2Hff/d8hwBUuaMdvq7ybWzJCIWyLDYcJl2Rm9JWPDM+nArNeV72M4kKqfmlkg+j1stJ3wAuCSV0VC+gYOfiI2+Qau0PPsAxKLMKUqPXHQfmqGib8wa+gci6mwofd+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sp68NsdIsbCXD95ymZMHSnPZr/4oMlia+9ttg9auDX8NSQufcpryOXCCSYsb?=
 =?us-ascii?Q?zSkdiQczsLEh8VtDGpozqIgMmPOTJl5l/t9vZpczSmPfVmrCSPfZJ7d2Lcej?=
 =?us-ascii?Q?yWC7KTxLigf9SYlvEvqUVvQFoNj/2zhQcRHlNgTFnqWT2gQOepS0A3sumLiC?=
 =?us-ascii?Q?J7h6z8vbQvdpdn3JoUsb3Ug0N7I2Gd5QqECzdKJv1qCs8LR3604pEfAsgDyb?=
 =?us-ascii?Q?XMUPaW2q0cc/iO8D5f+pvLaWweyVpemwxweYf963nS1pAgV1GbI5QDky6aap?=
 =?us-ascii?Q?QN7VfRYosT4RLspwMDffRYifGmBhq4DmUOnrM7bZm/UQhAjG1ZhgwCP5WUKE?=
 =?us-ascii?Q?xhZfMUoJoPxl4la+3dtWZMB6qmJjhhP1kmcf1McaG+yT+RdhOnWWO3U/Wa4E?=
 =?us-ascii?Q?NCzQ9rKspHbvrTzOCjdIsUebw21gr8GICPezgstJ84cmLFerzaGA46MQKiqf?=
 =?us-ascii?Q?S881OYsPxg7/+dDkLQKbPSMjEZM7nZWPYIsa3kGuqDFXfP4gR1z1IbpwaBwK?=
 =?us-ascii?Q?mrcivMde3Bzha7ap2sYogwvXsoLFjZ3QB+l24INWBOO6cGNt2xkYeAxV+4kH?=
 =?us-ascii?Q?POyha+3QoUbbu8+PHek3ciJck26J4nRdEmG9wBderhOLLlCtq7suOpsTOj61?=
 =?us-ascii?Q?n1xXZvvQdIJejOwCfALwQ16P9Xxa+b88adTnTvK2V8Jh076lu0nwrL7l67j9?=
 =?us-ascii?Q?xtiOteg2gyRjWefkcoR9EmFEyoAeeGlWH4g4habmZ1UP9PiaGZ/RPLzEzMYx?=
 =?us-ascii?Q?LSQl1DkSnyJzsmcr8SHCB5ERUf5Tv4oJHzkbG5/gqKNhZNJmXEX7x8F/eSnu?=
 =?us-ascii?Q?zMxM5e063MQGdYS5YH9D+gzkqH2AwACHDsygdI1FURMOZGLmxL0MBxunRTo0?=
 =?us-ascii?Q?puRJ77vLRRRxbGb6Rc0W2FVfFzfgO7cHiyAbdqnTXlOIClaB8LLsac5sTNwI?=
 =?us-ascii?Q?5mAQ3sZV0V7uH/0Gn41/8N2i3TMtjodl9C3FEeGVg2kdkjTaLM/m/ILBG0Te?=
 =?us-ascii?Q?TXHIAFTKcYNqh79c0eA+cadPurfRjwE/Z5B3IgXL2pchNsm9uRfMbRNqtsRs?=
 =?us-ascii?Q?578OgAQIaKD6IW4ERlTniBaRwFIagDkzB7loveV44S4G2kD11+5MBlWjfNMn?=
 =?us-ascii?Q?WXxpwUkl9bwewd5/N/qvKxg0EgfIyJCrQCsvmnSAi4VJVuofpODCR8I+686w?=
 =?us-ascii?Q?5J/mleqQ6P/OYyHsfv1T50ODMbkClppxhoCStapucPJhUFow/eWKdYwh433B?=
 =?us-ascii?Q?hPP4cH3BVVu03S18/IZpP115SL1If9DjZYg+e+nmI7bOvRedDt4K/J8Dy6ca?=
 =?us-ascii?Q?FbSv1SMtH2pphvb5tKfnW0H3v20u6EA+FM0ndIaM4KBmKmjGsX5riOQdPzqA?=
 =?us-ascii?Q?JTxJ/I0bEVMJZINmKH+r5j81M4gQdDKjvDh7dlbZ7TVsyxvlhub12w5e2n4L?=
 =?us-ascii?Q?1b5aszV2RGXtTFyURc0tFoNpFpIMqB0bmcx5FZvuUYq54foCLJvhyJz5O2OS?=
 =?us-ascii?Q?9y9ga0XpfPyDha3K5B/Q6WshmdVoSQCam8v9nMShxs1gEETfOt/zJQIFrsIE?=
 =?us-ascii?Q?v2+uPx4iO6y4I57YA0UfeS+chGlJpOhnJ8itEcfp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52541052-7057-41ed-ad12-08dc59219878
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 05:46:40.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58139wzUrdpUVRLP3V2/8hitUBYU6ymN19DtFH3STltsvafEqs5Rtq2NtMcS+aOAjDIhnWYSuzxNS0fRf+3TWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7924
X-OriginatorOrg: intel.com

fan wrote:
> On Sun, Mar 24, 2024 at 04:18:17PM -0700, ira.weiny@intel.com wrote:
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
> Why not use range_contains here as below?

Because when I initially wrote this I (or perhaps Navneet, I can't remember) we
were not using ranges.  This version I tried to convert to ranges and I missed
this one.

Good catch!

Ira

