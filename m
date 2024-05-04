Return-Path: <linux-btrfs+bounces-4739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5658BB915
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C8C284D1D
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 01:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8BA927;
	Sat,  4 May 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTZFdBxr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81972185E;
	Sat,  4 May 2024 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714785589; cv=fail; b=mIQOHer+juE/dL6BqUDLF73GBl2YQiRtv/0JlIieU9rauis+ku4xOLLSCmWZFPZBLtFxTVzWBh4Mg5qdldKYqU0AehUPx3rIlOztP9weSKGFWWRSK10p0ayHA0OD9lcML9NUt5B+4+tRamGMzhg4M/8LplkHqXquUBMwTR6gpFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714785589; c=relaxed/simple;
	bh=GUkzndhWCNyj7tNKqnPkTpeSbXfL8AavONYTUJ5T6/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=npXaODMyDZ4cgKo7Vtk1C8g70EjmCZ7xsOzK8orwfz3SQ76DRCDhwxnNxF7+KB3nfVAoqZrOPuXkeHAnmFB53I93aT0AZsJFVUYh38EcLvDcTBE2JY3t5TuPRRt5v9sSddEOri7r/pE0kKGSIJDjzZ6bc1BaBO3nHaPCcQSmzGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTZFdBxr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714785587; x=1746321587;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GUkzndhWCNyj7tNKqnPkTpeSbXfL8AavONYTUJ5T6/o=;
  b=YTZFdBxrreFdnYdMei3lfx5kx249HUZ+G3J3uhiMxdLyjMmrXLBaZjXu
   A4W1Zea9ypi02KJQixi41JCH4SUDafDw0c312gUXD3WB6kr9gXLprv8mm
   t37zoDiIpswpSP7hKvFF2tEbFUE1qiParv/r/I/oZmji/+o5FKdfLmjyr
   6A0QQzQ5sFMGb2C9pYW839bAaZsrwys2Np5ql8F4rwRfuMYeJciOXUCil
   HIyzzg0ZoCPeWQP0ZL3fQqhyhwS/QorRtb2BeWf7zJ/M8SNTgm/ujGm7i
   jZUBNLNpaC2ErrpCswKd7JUf9rMSpUpIs+afq9K8TMG7orhf1eNmjxn2/
   A==;
X-CSE-ConnectionGUID: y1+Y+34dSheC3Y1FUJN7Ow==
X-CSE-MsgGUID: +45ALrg2QomXDDVb/k/aMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10454567"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10454567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 18:19:46 -0700
X-CSE-ConnectionGUID: E7duvWUdTlC4BJZLJ//IXg==
X-CSE-MsgGUID: Lo7nT4X7SWegv1McNISrMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="27706051"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 18:19:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 18:19:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 18:19:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 18:19:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 18:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApdtMVEYfIDU83Avaco30uAfkGzGJD3gbbtVDW8JKaNBSijP7IuC8oZNfllhWx4z7urtMpfDs4Q2upoNJOJHmOA7lusxGF/O6Vc7IkdbLaWCXCfjzEWLDkVXzFxM2pgUREBlCMa6punaW2lw4fwqzh8HmMpvhvvWGvKjODDRrpAWd+VYREgdRLQTlYZD9MJ7enOjgQITXbqLQ93ytMjosqvoM52ngHzxau8QrrxaTga2B0Y//6HuJZx1dOM4+WzBGeFUisyPYGwtSjmfaV+kWKha3x3ZJ6GKl1lgHXbUZQeot6djWBU6+VrKpdHm+VyYgujww2+kh3YYfZnmM7Ttag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ0qHDx5mtYqWXE5e9iEJixNt2N5oPiKfUoGw3gtCrI=;
 b=GpWb6bhoKiOG9oGhDD1P7BJQncuzxpNUUd4ZOCzeuf4n6hyG712xIhJO9+CyVpRSkR+2GBNoOxLZ+uB31IWzC1bCYtUaF2gG2rAcLvMKlWfyzDyeP9yRQxJPGVS0bjPqB5lGhHcl+vI35jfRAkwK1d7VwIAw8mpP0rY/uWxzu1O8I9ckvni9+uXe/1dPDDURhUk7hDSgcV9ITG6K9SuJphr1Z/Tikafpi49o+pI4sKYUJBvN8tgQ2GwW1IQE5EU5afI6pG0BNO+HXSy/ZP5ORo+bpeYAvzXiYEAuwbxHG1ErWLtmD9CUupYvqJSDZ75zBnTlfoQr5PuC7A0jtiP7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.43; Sat, 4 May
 2024 01:19:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Sat, 4 May 2024
 01:19:44 +0000
Date: Fri, 3 May 2024 18:19:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <66358d2dab5f9_1aefb294f1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <ZhSPHvoTHl28GXt1@aschofie-mobl2>
 <6635366717079_e1f582941d@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6635366717079_e1f582941d@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: c470013b-50a8-42a9-c347-08dc6bd8479e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X9NiGXY+8Pvp930avPcdA8BBOM1cokwy/QDlFVuNkHp9BLnmgzUhqoUM04Nu?=
 =?us-ascii?Q?38aT5oa/ubtif7xaijIF3CjiKIJGv39FCGVa1QYP9lyETImHKzeGLgeWJTQH?=
 =?us-ascii?Q?qBfjUctrJj27NPDjOwoxn0eYWc+VEZ+kSJp32CshSTjPaB689NF+c+YPEgDK?=
 =?us-ascii?Q?MOzrP3HkhiQmTyyWKzkspkS8sNrAoIlkQavKAyCo4SQkzcAtGqPZizL1M++e?=
 =?us-ascii?Q?Eu71QWdlz4MY7/JqYDHSs7GCSt3oKnnJuT4AsXITYado6j3x9V/hL5B+2huS?=
 =?us-ascii?Q?aBVQiEQtxJGiF9UHWLN+fIKfoX5uVC/OyJU5luAOXpeqUYqzLH0RsBPk9n2n?=
 =?us-ascii?Q?5ZPFklrqofqNT/Q06kVF214nHlkaiUqp5H/t82IUpi4ILW0zgmdjc7nGn2BT?=
 =?us-ascii?Q?Y6neLXj2sFTkIoPH+DGYMp4A5PFIvjv9uoqCVBBc0jw+iqqaizCf00UBngPM?=
 =?us-ascii?Q?XwoGel0p3wGquuqhKtpX7G/wSZQ/BFTiD5bPw0lpvm18AxaHu+NiC5IouE/e?=
 =?us-ascii?Q?5gjaYWpFat8j0jDjChpUfvRRm9loReMhbYX85wYG/RJHUm3aTsgY/MGLru5+?=
 =?us-ascii?Q?DLnISoB58sxnsCtTxHe5KivOXU1WBmNGMJ+VpYgBZprgMpTlAvaapMWchPHH?=
 =?us-ascii?Q?QQ2iC9j7g24ApQVQZFxNHcqS3YnKLe20k5ApJACf/pROp1BLDvvFcTMpDQ+4?=
 =?us-ascii?Q?ODiV3V/TgHvU+kiaSLiG6S8dPMaM+PKXk/3TgpaJhAl3UpPEZHY9STNrLE1a?=
 =?us-ascii?Q?Rle60JqVYEm51H6o1a2T0Xo8pGVnF+iCLej9088x88AWkiSgTwTmwkm+HdYK?=
 =?us-ascii?Q?FVZaEMGx/tqSY+6UchGBhd1O8A9G29nfNR36sS7ie6aqFNTsIRqOS4s77541?=
 =?us-ascii?Q?m2qjffzVGhV6J3a1BQh+gugaRp6SXZcuiJ0/9/aBHRxVioVWW+MKjUY6KRT+?=
 =?us-ascii?Q?Uxl26tz8CMQ20a1cRKNrQ2JIsUfLhtyTwdYs1wdZ+KvRwIddmiExkQ0CskJ4?=
 =?us-ascii?Q?quvGGaX+AeWUjEiGs7DdAAa8HA+WShC0J80bpSA7otLlsMbu7UHoPY7WDWnN?=
 =?us-ascii?Q?BQtNqpnAEuQwu262J3uEiyGXLNLPoEpClIoD7kSERVEmLiyb8fU9eV3nj16f?=
 =?us-ascii?Q?TcIKyvREGFP9VKcEFGWtbHkv2IcgJuGw5NHVhWHRG9xRCT0OnxPDHWqlfkI7?=
 =?us-ascii?Q?+gnvHFxvz062bsqbqmPUHdT4qfzIl7zZI0fyUIVFJsIqm2ndvJXFTD3GE1gR?=
 =?us-ascii?Q?UQyEHP2Hd3386Fv9W0/+0cXfSmXnPrF+Go07xUZA5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KVhBVdNBfhgilj+kwHuJpqqobQLJV84ZFej3uWu5W44sVnctDffRr0p/lpzP?=
 =?us-ascii?Q?YetEV8W0MBnEeNe3Er4Kqlt/kGe5R0x0dJoak3IUjRnsWSM5b7tpL7SE29XC?=
 =?us-ascii?Q?+e1JIJguEXwVzwVL+MHRjQ5j19UO27lgBATUYPO2Te1KbJTE87uDqileXybT?=
 =?us-ascii?Q?Mh3NG+BCw+Nups0I2WPELX7uDnjzvSo8FyRl7wO4XzH1eQQTjWcOPagyCvn+?=
 =?us-ascii?Q?jYoFtiGQZyvF37nRMGUEthQQCFPG4tNiJzA6pq1XZndTGf0l57sM8Z7SpLjT?=
 =?us-ascii?Q?QjHvvGUakZiJ50ywm/LiBb4VGT4qiN1Eg9faQ/ovNrR0m2yqQt9w19swCbPJ?=
 =?us-ascii?Q?21XfD6n7q+HPWkkLg8joh2zXKl9BgQdoBs8Zhy6FCBydsyaZCMz2Vc8WVryr?=
 =?us-ascii?Q?MFeag4gygj+6+PrY6nBDRRg1xbByKwLtKBB26t1l6m10qAmzjf2L4qccICXw?=
 =?us-ascii?Q?XqWrf9iGN9ojsRYMSsdLWhEvfrxPcTNvn1T3Y3XwMryAN8Oat4rcguh4Jd9n?=
 =?us-ascii?Q?7JH9Tn1SEnIJ0UTzMxYveG5QdSck1GsO6rUKVrlmlu5h3T+R+sJocdXyWWVa?=
 =?us-ascii?Q?9TJJsUXbVSIaSPu3thGH4ccNEC/wAjVRZ4a6p5FsjMiR6/c9vHeR7UghT2oW?=
 =?us-ascii?Q?M+kVXxdxAGqTM9ajnAlcSibpCAyy+CUSdUxCWKcW6sWkkk/OpW+PYlg1UEMy?=
 =?us-ascii?Q?gSHuiR/QCfZ6JVsc/YHNbqIiR28ekGpaYlfQuj6sCPnjID88L15HwdcomCh4?=
 =?us-ascii?Q?ggdD6fSIysxE2bHjzVvigr2zMsSFZXnRfrB0k5ILegNaumt6JI0vj3qb19NC?=
 =?us-ascii?Q?xPVejiq3DkTK11qRPUjux1wvLyUz72LzDCRUi5I1oWf/gKB+/ajSqzmrtx4h?=
 =?us-ascii?Q?Fj55zvvxx5L5VAhcVmMW/CSq5BuMYVCQ0kCeyKff6DjEcc6zwwev5Vg9uAiJ?=
 =?us-ascii?Q?bUKld3WGZmbohdPQmS9ySrexx5bbQo48Y5t4lsLJfACTwFmDvyCu3g/0CbMY?=
 =?us-ascii?Q?yO5ZseFrVpleOsndIsyyQTJuw48oDS07M5eg2hxC2QzBh+38SsAWRA6Oq/L0?=
 =?us-ascii?Q?9k37REH8au6AGQ5or+rF4ODChlfwBDuA6g7tvO+ksEGPUP2gwhe4OMxbbThy?=
 =?us-ascii?Q?JZ+NCKQb8JnrDkUeh7J5dPPrQX2m7yYpQt1Rb4F7AWPICJhGlrO+eveo3HZ6?=
 =?us-ascii?Q?0yWjhtFGCK/es8SZNQJlz4fMJxR/9uJSsuEfbxAZxnpLO8Gk2o/WDwLvPxjh?=
 =?us-ascii?Q?qfLPExp7He4Mq7CFzpXEybGiiTYPcIo78gsKpyr97lQowGEK4SUaRnHfeMsF?=
 =?us-ascii?Q?LgJRkgyMfmUzOSY92B7w2XtUE09kl6sY+MnKgH3I2CxXR/S7vDB8i+kTbfBZ?=
 =?us-ascii?Q?P0l5btre+C/ovR+QEJtgao8lW5LAcBAeY83n+rx/MMxpWU+j/JNnVDdTruaB?=
 =?us-ascii?Q?eCnjVa7CpNaPgRyxN706tX+tfiAEtEGcvzqVer1vcScxTtqebITxbUifWY+q?=
 =?us-ascii?Q?oOMc5V0ONOVmpaegUQ+nm81HRX8DfegGBkamtTzXS25Jxp7R+AasWPok+QUT?=
 =?us-ascii?Q?rrRkh6SBZvS48ZnZ9/SxpcaCYTNwTxSW80BYJ3VAxS+jGwQvsh57LdN5MtP9?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c470013b-50a8-42a9-c347-08dc6bd8479e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 01:19:43.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sIm/kM4erUYpanMbCRJsCjuxhxU1f3hSwFvXUI2jXO/qa9MQndZdxTxOkkYCGe6bJO9Y9zppgOPcISwi+ufRjXwMQ324i7dO92bG1Bnoio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Alison Schofield wrote:
> > On Sun, Mar 24, 2024 at 04:18:08PM -0700, Ira Weiny wrote:
> > > cxl_dpa_set_mode() checks the mode for validity two times, once outside
> > > of the DPA RW semaphore and again within.
> > 
> > Not true.
> 
> Sorry for not being clear.  It does check the mode 2x but not for
> validity.  I'll clarify.
> 
> > It only checks mode once before the lock. It checks for
> > capacity after the lock. If it didn't check mode before the lock,
> > then unsupported modes would fall through.
> 
> But we can check the mode 1 time and either check the size or fail.
> 
> > 
> > > The function is not in a critical path.
> > 
> > Implying what here?  OK to check twice (even though it wasn't)
> > or OK to expand scope of locking.
> 
> Implying that checking the mode outside the lock is not required.

The @mode check outside the lock is there to taking the lock when not
necessary because the passed in mode is already bogus.

The lock is about making sure the write of cxled->mode relative to the
state of the dpa partitions is an atomic check-and-set.

So this makes the function unconditionally take the lock when it might
be bogus to do so. The value of reorganizing this is questionable.

