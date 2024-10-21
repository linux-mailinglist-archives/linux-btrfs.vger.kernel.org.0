Return-Path: <linux-btrfs+bounces-9035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBE9A7297
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 20:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1465282D25
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6D1FAC46;
	Mon, 21 Oct 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrZNMBv4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DF78C76;
	Mon, 21 Oct 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536372; cv=fail; b=LSPOk78ejZnedxmZRKfUU8Ydx0JSknA+BkKUZM9moccxbA9hj/pf7Jzp6xpWX44tNfeWGPFFTBVrZ9n2M17+y9bhsn9sr6nbg6Tpm4jVmpnjtzJNOQylqRz2/iQgA8YKxhwPSMpDmxxsedKf8kguOUa6We1B3CvDed3d5798YFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536372; c=relaxed/simple;
	bh=5x+qUGWHdZ87AVRUeVj1ykIftgi+hvqCINOwAQ4vhEQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDkSdE2mI9B01j29DwiC0J9Xw6KG/tbW3OeA3mjAdFRxxtc1RVo9q+Zl65OrqZt5jajyces/0LfCtwJJu+o9Ycl85X0M6gUyuECExPe3fptXXZkeMKPY35M4f+/+sC4ZXzfOnzA7KT7aR25ftMitNfIiuGJ7dEoCCGuzhMmSlHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrZNMBv4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729536369; x=1761072369;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5x+qUGWHdZ87AVRUeVj1ykIftgi+hvqCINOwAQ4vhEQ=;
  b=lrZNMBv4k3bwChTfRCG7Fv+llZrOAumaa0g7a7HV2O92lAGelgh0AIwy
   cxK86igrOb48YnJds3RFqqKmpcMuvJ+pYAawhS+l4ENbJK//GDs2iZP0j
   c+xQzapvyd5jZD78ANdhmANSIablswsPphNzZToDiCQmYdSBYkhDBzwyD
   Ch+DH13UGsyFFYr4Jj0cA0an5tFTIv9ubqd0wc6g+APM5vqX68bBDW8bK
   onBDCmi8Xum2TSBjcepT84kf9gbasVC7CtZiUhr5V9LpThFw0V8LxDdXU
   Am9cBK66SUThZWSqSOdzE50FiUSw0y/8vlvTffK/i/4tBnc8A8CBuVKda
   g==;
X-CSE-ConnectionGUID: RmCnv4lBSay+u6bFCqlP8w==
X-CSE-MsgGUID: WTltMgMVSPOT1uTNhbGO9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28916319"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28916319"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 11:46:08 -0700
X-CSE-ConnectionGUID: xq4g3uPUSVOhu0ZbwV2Nqg==
X-CSE-MsgGUID: sEcFUh2PSMWcfTIiPi9jmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="83624049"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 11:46:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 11:46:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 11:46:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 11:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+Z5xwFd/7rF6obOq1OQ2wL7Eq+6au5lnnY9u6d13OL7r2luRboUT8vqMbBbZ40a2QpLlYvYUlmXsYy0Bi8Cm5i50vLEPV2uga+HUL3viVPXqGj3u+r5ROgyOHITBD4KWvYuDcixJP8gyz5YkIc6V13Na/6a+SjkxYecFBJn9AjdO3IN3Dhn3XzMGevEFq2iXBGN0K6hFoaP23/Yfz2M6Y6UqkJ3CAVvxqricBPdzWYK888UjfqPJZTPxNHaoEsyngcaXvSOQbSPxaQmKusu3eZQQyj0ezxFY7yfDeCwBp2r9jqyPVAynulSk3qUCeBJUkIwdjlo+J7MgM/dF37DSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA5/SGmxU7jUo/Q0xLdGQCpud5+WyDtHjxsxTCDGlnA=;
 b=EiZQ7T1K8z7gai5pCHOWOGDfq7yEOxeb5y7IZmPrC4oJ/8iN3Rvz2gNxe4RPrWt0VSAQ7+aQ/zSwfXDLVRB7sWrm9AN5QLaInpanSAzhjbqeHb/laChLsjMucAJSm8VGgFzgCqeuqK1jubsDnPlG/are9Yv5aTRTuAUO9ITzRtoTijgj1oCk0/KQizm5C0msIIUjkBcUKSR0ISIglcO73QgFBkcd4GRIKdBttgXNJ7AdyPszipZDZmmHWn1bcwSXDaXRydDfgsTPXvVvcqPqHNk648jUadcondJGC7XDQAtUeTzrSk1rpv6aEDwMnCkcM19zZPhve3Qpp26lBidS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7513.namprd11.prod.outlook.com (2603:10b6:510:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 18:46:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 18:46:04 +0000
Date: Mon, 21 Oct 2024 13:45:57 -0500
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
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <6716a165823b7_8cb1729437@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
 <20241010155821.00005079@Huawei.com>
 <6711842d88fa_2cee2946a@iweiny-mobl.notmuch>
 <20241018100909.00001ec2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018100909.00001ec2@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 63068724-d880-4881-ce29-08dcf2009ded
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ihm9AeKCPuDMacDSslYIHS+9Wmt4nxEXDn+J3cWUCDkP/P7TO/Zwff8DWAns?=
 =?us-ascii?Q?SvlkH9h+QqXLd00LGiCzevhCeB3sRS2ykTn3k4UfuDRsdiwa4O++bXT2Yr3w?=
 =?us-ascii?Q?Zw1f+jUneJ0zwXxtZuPoXp3AQAj9oA8rrs98ED/LSnpOF4aOz4ojvJlPaSPi?=
 =?us-ascii?Q?ObGURlBinPHWmnw7cxlwr2MWp1XsGnGilBhEHC5ZCGrFpchFvbstyJv5cHp2?=
 =?us-ascii?Q?2Ak6g/7B7hne1Yc/A6dajiKCMsdFOMYSVcu/l4lkcfGNszoy1hWx62OTHV6Z?=
 =?us-ascii?Q?GsHxbPffoYpMeIJiMRqPy9h9Nd0mB/SylTSK9M+nNXMQbf7kegGUbpVozn0W?=
 =?us-ascii?Q?oO/LT+4cpSrIpZfNzTQjDBMeE1CV3OfxbyBfcM5NUM3sb5PG3Shi6fdmWuEe?=
 =?us-ascii?Q?ereZeeWCeMgEKQunwl59Ys1OiN2be1EssjazMlSlWJDsitx67VcjSlqKk/Md?=
 =?us-ascii?Q?zljF66RmpFJDUzl0gIB61geOcMr/qj4+7Y801LRXzG8tKA9lHtLNgvmuFhDY?=
 =?us-ascii?Q?jnwPhCHQMk0qFIxUHGZmJnjs1O60xSxufNMa4D+WcS0BQA6mqcE6H9boSV4H?=
 =?us-ascii?Q?aDQQwBFjGuLG1awCGuLkDuZc5st0vzVYaGX8b4Izk+/z4nfdO4M2osAksCGO?=
 =?us-ascii?Q?rr4OAuhyKGVGsB5faJ8FfH0wzplFb3+ZWmF0b5sPUaFpm2Ue/KHJgYzhUR27?=
 =?us-ascii?Q?nRj3+BXB3MbFvGEiyU7lppzICtpCF3eiaR7InidVyNFqMTroZEBBPJuOv30b?=
 =?us-ascii?Q?BJ9tfRf8vx36ukXE6ZwXr1DwUBi2UhDVxkuO3YrPb/I4wWX9jYjO3ixnkDUD?=
 =?us-ascii?Q?m4LJdNBweKIMv/n7z0gTC2V/z5mQEMkD1QZiUPOiL1/ab9TlI240CArZ3Gp4?=
 =?us-ascii?Q?Mjq81wCsI1RRxVQzKkfJJcmTDvmIgDqJZhoSJItmXw711LjtIorTcgTIO4uT?=
 =?us-ascii?Q?Qa+frr8SVOi6fruwqTGTlLMlhw2kaBTGG/slV90hKKPKBUOPleNcWuwIP+p6?=
 =?us-ascii?Q?MZQvuZ+xXZf3bimSwhlT9b3TEUUWzomQsxhTZcBamYbmWXKkSotRXosxL0GN?=
 =?us-ascii?Q?qbzLW9q2TRvOTQ9oIGNZPkXhlOtJ6Y036UqkdyeI5MKf5jr9zaZn7bJ4d/Xy?=
 =?us-ascii?Q?Ny7+lLnw6AXtEY3wJy3qUBvDn6jwkepSXIjpE6xPAqJCISjg15qZMGx4tD3u?=
 =?us-ascii?Q?KEAPbmwf+mKac0aObQHrWz7BDqlRPDvcfl/zBGwU31Vyt/DsX1BqCpKcNirM?=
 =?us-ascii?Q?Y1i+4IUVq40SaAN9jG+SYWFbbP0UmfjUlnWHl+ilR16A4C6rxWsvS+6yqUpi?=
 =?us-ascii?Q?qTHCZaSNdZc+TrlZccoPGdku?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+RSv1hEsSABfVSXHUVeRcaRGtcnEkS2vk5WZg9IYySatdkYbxdRvS92xQTQw?=
 =?us-ascii?Q?fIsl2SKvmDh5PpLK0Bcr91Kc9EyBnDoP9i4tRkrCR9cSyi2frF8d4UL7sKCH?=
 =?us-ascii?Q?hq+4bqA6YLVemrasytqKf6zYLcvK9I6kz1CPbls/4ttifiWQA3Q+39wkQzDb?=
 =?us-ascii?Q?Gmb3UhagsyPSLvOXdcgWsWufi2QDbdtOSnrPtPw5ULMDFEdhFyWh3w5DeZ9+?=
 =?us-ascii?Q?h4DXlz1aQOigfnmZV+Bpl6YVmD74nzcHlSAphxfaq4+iBkfVNAdkrnJCdKF0?=
 =?us-ascii?Q?Sxdh0/XWdZa/moFK9uMtu3oxpAj9It74EuUqpwOQK9W9iWtl23JimUk8hxcB?=
 =?us-ascii?Q?i/wsDw7nmrYMSIRMri6crF++Nzq29s7HPtYICregh9vGc+cHq7a5xQaOUn1S?=
 =?us-ascii?Q?UDBRXUHnnFe24S+5o7AR8a5MFzOqaQKUY43siOVuds33ZGqDCewN/DsxBItR?=
 =?us-ascii?Q?rWwUf9X+XNC37Lw6vzFMhoYUbVlZmyRK764zJqU1gFPk993To7IELyZuVxCv?=
 =?us-ascii?Q?jz0ZLDde3ZonwCetCeUNc/EMh5Q4Xjwx6Nrj8dg6YowLGgIQlPJeNUzp8gms?=
 =?us-ascii?Q?uFQ3JJ66M0O83yVQQFhvK/B9TgKXRvX//1ANFkuJgAAqySjcgG5CzYZu/0rN?=
 =?us-ascii?Q?zhSQOnkSc40kMGrkBHiNnN8OxWgvqp9QeCjntu3NX0q7MbSSK/F8jaiSYYQJ?=
 =?us-ascii?Q?YWPTAqEoyev6uoU/zLxes9HHU3rkiM4vnzscxh26KmREN9hzWkBJ2rhrX+O2?=
 =?us-ascii?Q?228CHKixzSmk976TRbydpZiummmUGTREd5JjST42gtBkHjLf3rJPO0IL4yDS?=
 =?us-ascii?Q?nIz9wxOCKKbNJaCu84y1lInQD2TWYNu6uak2+E/AX+SsgyZ0/IcjpV7kRbt1?=
 =?us-ascii?Q?dOCckBq7N7EgaC61It17+206vmrSMmPqT4Gvsz20MOqRmoWdECkfNk8ruQ3c?=
 =?us-ascii?Q?0oTpZrno5QMXgBRGaYuEnGqjtvbBdTUtJY1STc7UvrbXBBMV1Z5KDRIeUUq2?=
 =?us-ascii?Q?RgqwBhCUIXIs8JfgCqO38h1njyGTeFpqHKlNAUld0x1IE2y99zTeWMtf9fRY?=
 =?us-ascii?Q?H2ve9S18eiO/5LHnzF7sh/Gs1Nva4dmG2/FnlIkjAaQa1/nC4VmL8Sl0UZXE?=
 =?us-ascii?Q?RvfxSoitiTet8rtxBG3Zn7c3JmLtUtvu1SpHXalcvVX0pSPmQF/EP8fUxzfJ?=
 =?us-ascii?Q?8mKqhKHL9JRV5/1fYbI7ZAfjVU2riXhR3qYPEmg7FIAHndOA7+vRkHrN+K9W?=
 =?us-ascii?Q?WAdTQ7sp+1qJE5rC9K2pMlBG5SE8Wo/CMLrOOpG5VgTXIFtAS1xwTSgg2Ltq?=
 =?us-ascii?Q?wXHkWtzxqyGafEB2zRMLx2Qn6O8y0CPB8HdmIOtDW8dufh/GePmPpryYyVhB?=
 =?us-ascii?Q?DzGkYWg3jur7xONXafryrHvIWcde/fxusdjXVxv6AjSkIbQEKFr1L/eSVEQN?=
 =?us-ascii?Q?laUNxIoHI3u/vwSbENUHBqMj980CXlU/s+wMHaFksoDWo46YtmfMZX1qVsC0?=
 =?us-ascii?Q?MV36oBHe2vBCGMJA/KIYzzzHtAmRjl4hZSNinSdrmmuK9dc8I/XDco4hgchm?=
 =?us-ascii?Q?/N7xpGuLvv16xuU6sKNBTK7e+v6oYz6v3uO097M5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63068724-d880-4881-ce29-08dcf2009ded
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:46:04.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNlfpKO2zh+anI7FJqosyUbggwYwKUyEg06YJAACYf4tSqr1aOVVEL5meIrSWRYpKCwAOx0fGtbqUxafTiKhTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7513
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 16:39:57 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Mon, 07 Oct 2024 18:16:27 -0500
> > > ira.weiny@intel.com wrote:
> > >   

[snip]

> > > > Simplify extent tracking with the following restrictions.
> > > > 
> > > > 	1) Flag for removal any extent which overlaps a requested
> > > > 	   release range.
> > > > 	2) Refuse the offer of extents which overlap already accepted
> > > > 	   memory ranges.
> > > > 	3) Accept again a range which has already been accepted by the
> > > > 	   host.  Eating duplicates serves three purposes.  First, this
> > > > 	   simplifies the code if the device should get out of sync with
> > > > 	   the host.   
> > > 
> > > Maybe scream about this a little.  AFAIK that happening is a device
> > > bug.  
> > 
> > Agreed but because of the 2nd purpose this is difficult to scream about because
> > this situation can come up in normal operation.  Here is the scenario:
> > 
> > 1) Device has 2 DCD partitions active, A and B
> > 2) Host crashes
> > 3) Region X is created on A
> > 4) Region Y is created on B
> > 5) Region Y scans for extents
> > 6) Region X surfaces a new extent while Y is scanning
> > 7) Gen number changes due to new extent in X
> > 8) Region Y rescans for existing extents and sees duplicates.
> > 
> > These duplicates need to be ignored without signaling an error.
> Hmm. If we can know that path is the trigger (should be able to
> as it's a scan after a gen number change), can we just muffle the
> screams on that path? (Halloween is close, the analogies will get
> ever worse :)

Ok yea since this would be a device error we should do something here.  But the
code is going to be somewhat convoluted to print an error whenever this
happens.

What if we make this a warning and change the rescan debug message to a warning
as well?  This would allow enough bread crumbs to determine if a device is
failing without a lot of extra code to alter print messages on the fly?

Ira

