Return-Path: <linux-btrfs+bounces-9024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547519A6B86
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 16:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1084D2832E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF01FA249;
	Mon, 21 Oct 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iu8ALFKA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FE1F9A8F;
	Mon, 21 Oct 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519517; cv=fail; b=imBbbcZcAOSAFUoo/r6SMI83RZuNqLF2d0g5Zf4sAQjZIGnTCQGsUQWjtKaQKfxHuIa+5N/fR2Ubqm4oYroB+sMqTRMjVrkTkgwVOl2h+JeBXyoooKQc0q186K/Yus14suEqKUfRdOSTIVzftIZrJ51hjfBE/YI2rTmBISKmbg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519517; c=relaxed/simple;
	bh=o3uEcmrUhndbyBrTfWB/276eCnehUHTySx5OlXFGNOU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JsS7gGPwtbIQnen2Z15BWVMEogOykLm94ugk+OdOXduUlMNsLMwv4Z6mawvUme+7ZUtPZscUD3i5lPu+tYSkqSOrjpTg/9Z+88sJctYTcTpcwIBoIGAg5aLstJNA2f32Pyf5VtRwU8jlC0dJ+pBkaXv03mrp1mIWR1earZJ4S4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iu8ALFKA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729519516; x=1761055516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o3uEcmrUhndbyBrTfWB/276eCnehUHTySx5OlXFGNOU=;
  b=iu8ALFKAi6Tdk9/PbhOS393FUZBST7oWSw7xbxB50wGQYopSCQaS34wk
   hYXlXi1NdDhHN/nSTHGey7twk7hKek1foBSg9HZLs97Xs7pwl7W4E13bL
   xiwe6D9yo+75YSY5i/wQmgRgcC9jwuDNzJzheqlp/k+MDcxJgcOakX01I
   yJnnajPHufJT+FeFob0cw62ORdgGu+ITUL9wQxtsJJ1wpq+1896/ESpRo
   w0xyTuuYkOQpPMNmXvPDoT/XmKkkNpAl/UIJ+rqZWJ/CriBq/WILBkp+x
   N/yQJPwVSMekzLGnTa3Gzd9L8GkvahmJgjbHfjafWAKZc93RGLLADaXTR
   A==;
X-CSE-ConnectionGUID: oZHFE0WEQ921U/ICCpUsPQ==
X-CSE-MsgGUID: ZLTOZJsqQmSH7xKFcEYPTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46469245"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46469245"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:04:50 -0700
X-CSE-ConnectionGUID: GEueAy7rRCW7cp2tLE1xbg==
X-CSE-MsgGUID: KC7MElVEQZmjXs8vQbCHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84326996"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 07:04:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 07:04:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 07:04:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 07:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZxPrGsjDeGLXNsWlDxXuwZIISSbEf9bvlZhu9csytQSwUlpyCcU+1DOuVFIct5JDKmdJJIMrmwpssSjhlBiipxDChvSHzHlQqj967CFQa5Z0MZke6wS27MtopVTPyMOJQwMMPvDyOZ+L4M5VNj9qsfPBJDsv7Ft27+LDPxscv0ZmjAu5gytyYbL/+Vs5su7iHH/n8ZdL2WslQ6erVtjGhBJgEXVrLqyn8bFjLH/XCmV7+mu8QG4SS21l83yNm833xGBlrA8DaGEs1qAXNGGURRbY6wXPbLNgFYGV2wQLnUoEBzbTcWgY+XvqNy9QQyAiswa+r0fah8mf6O2DFvTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGVqqoYTCXZwUFWdpB9g6VvlDgkp9dZynb6xH58jP7s=;
 b=IFcfx8vCA7wVC7OU3/H+N3lkFZ9i3QYzn87v/yfX6r4GvR3eG5ubrRluPfdotI+eUSZAvvGMtBcMVpl6+gtI/yz7gc7z60lUJfdauv0/nlP6C4srXrBgXpzoyVjw8hbI/rasSPk87c6T8//KuIZ1B1wmpqNXehVoLLRpHgi5G6LSE+L+fV4L+OVWY9uZDVq+J4Yz9ly0ic19lbQ6uFIvXxq7VuTWAYBozzffebytj7di/RutzfKUN10DTfnqmr7ScWk/uMp+tjrGZ3cXzvzTY3A/SA/pDZifKh6X+AWO7n6T7vPJ1wvnQ4WJkrGoIhxjg5v/Jd1MeZiOzEDZM7t3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:04:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:04:44 +0000
Date: Mon, 21 Oct 2024 09:04:36 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: "Li, Ming4" <ming4.li@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Fan
 Ni" <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <67165f7447c77_8cb17294f0@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
 <4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
 <6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
 <20241010155014.00004bdd@Huawei.com>
 <67117e57479b3_2cee2942d@iweiny-mobl.notmuch>
 <20241018100307.000008a9@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018100307.000008a9@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:303:dd::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a52e199-6c77-42bf-ee1b-08dcf1d95095
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Rmv7GU1UdmoNM80QfqEhJOBJiUiZy8ANKQgTwVTNfJUDkIPe/eGLuZD/ka9?=
 =?us-ascii?Q?nT8s7Pcm7S992Bp9+FlQztep/pltdZAvAo4dGvZuDaFPdKn1ilFGO7jswwYr?=
 =?us-ascii?Q?Yar/eFHT8mSJslnzDLHXTVD4NRrNKIdu6e0HebgHXdG6EvF9BQdjXMiTxowD?=
 =?us-ascii?Q?R05YfQMfI/LgO/OmgWLqBeQ0Cz8sHvhJ2POB+o6MEE+sT1BaKuOtCcgbJAa7?=
 =?us-ascii?Q?b+peVrI2kJGn+p4/l0PqbICh6bIISp0VYEz9dlwPJyuhHVQApcs0LZVz6i92?=
 =?us-ascii?Q?QfOacazS/3vaqjmNojhwe8qTcLF3esnicKEVDww1H1KkemI3Dtzvv9PnrI3A?=
 =?us-ascii?Q?ueymIkeg59PijbAIAVBOI7Bo+4Kamdkw+W8bLreYTcB7+r5/J5/9OGHOWhdS?=
 =?us-ascii?Q?yrGm+Q5KpTCKFuGNxrBpDTha3feJsBuakZ4F59R19KiXdDK9f7wJEkWQhu12?=
 =?us-ascii?Q?Mr5Zv0d6tGsVepUm0f3FhOlgh/ABbWAPfIoWM7y289SYQrZZkHUNlRnUYWCa?=
 =?us-ascii?Q?cE4MwsyRFjOrTbzZKLdfPPuv9SelbNzOItDiYmnWmvgNyy2BSbUnAXaouGlI?=
 =?us-ascii?Q?WEx1XVusKAdZzKYpDRcqZgKsjwcjGDiZP/nSrf88FgZryf1gHDeXWDZkdQJ+?=
 =?us-ascii?Q?dHlOJbc6pUO8HjusyxAnj1zFGmy8k/IF/nrdbOSH7Rt3RDwZz+4WS2UkQcaN?=
 =?us-ascii?Q?LIWinu/kUhHJHbMkM3k0mB4ptADpb3Az2oXkdYo2iqAk5fM4H0Jc/dBWC+1K?=
 =?us-ascii?Q?iU9q3P6Zivy0rr0vl3dbJIpCprtoGhibkJ4M8yJtEuPyEPsRmKCRFDg0NadD?=
 =?us-ascii?Q?+wOOumdpcp8e8PAsq8P68ViCN4fH9KCJwuwb+qwtBaoh2uXD3E0VWDHTmwES?=
 =?us-ascii?Q?pS0Cf2u2zYJQb7rbqkijnG1cspbrHQ4gAaJDwapuBWX7D/Y+OB+qvl3Y9J6o?=
 =?us-ascii?Q?zwL4jGdImCiM8TGMHBdHCViHXmgZDYYzX5+oH8EyLwVHf0dOTxO2mZNlEtxd?=
 =?us-ascii?Q?9np9pZVvfmf7tNaiR/LbsI+cWCAWkqzmgy3jb7kT0r5LsmbyCTPygcaWLwLE?=
 =?us-ascii?Q?nsWztgu3bFbh/2iJ6Fe9otSHhGUioNdPICpeBDJBNy+p99QPCx0tQ/TQsMlY?=
 =?us-ascii?Q?XeVIxyZZ8n6VSHgO2zShFPoHbnuCMeSgV3XDeCqqPvolMRezDgtGLMLRbjhK?=
 =?us-ascii?Q?EDhW2sh6pQyDQFL5UWfbSIHT6o1imn0bo8lxghnKGJyoUp7/RPn2UnvDOvS6?=
 =?us-ascii?Q?KCd7VvxjOsC9ZNR41CndDiJ19qb4whGd5AfjeJ+dgQYjfBAzVO/4/rm/4N3d?=
 =?us-ascii?Q?kDpAseMFFYJ/gAFmzxyl8bi3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Zh6beXqdh3xyqh8TzpLXRxY6d9GwwqoIR7EWDCrvfNOXPAnDYxK3OKA1TJ8?=
 =?us-ascii?Q?o3euwWhf2fN2Kqf/w2arCFqRFA0JbBHoGIIG9Q7v8DV226/wWxORWbJ75ehD?=
 =?us-ascii?Q?bA4f9Y17Zy0/wtLI7VPHyIijdRxO1G0nU+NnKoo2/ijcwrlNghH2ZaYbeafV?=
 =?us-ascii?Q?sBgb9fKmwsYqGzF3QjTq+G9nN0HhTK4D5OO2ZS6F7XfGDjmuIC9SvXVJYlnw?=
 =?us-ascii?Q?kEbrItJBg9xhtx2WeYyZRxGSwOBZTDrrrKLckIWpkszB2h8zJEVFgcjZc1n8?=
 =?us-ascii?Q?mrlEWmbsyaF8KmE/PiE2WORjaCIBi7bNO7hNLf6fgEmXgOMX/Wqc5IY7A9+T?=
 =?us-ascii?Q?Ui3gVfOp0yYa29n9g1KGaZg28YfrGai+r3ZmcLzhB3h0Zi0KJnQxsLv4AmM8?=
 =?us-ascii?Q?qdC6iKIgnSflJqueJYXs+y0giepkc977AiJdPbCYRcUvCenJ+3nrgt+hCK8A?=
 =?us-ascii?Q?JQOjYKhVXm28mS2fp3zliGYywLcLnz3/iUKe6GqXpNRJPyyxeuCV71hGVgWx?=
 =?us-ascii?Q?tF98trb+1efkSp5Xpeh0qcuoWlIdfcHhLAHRV6VGxDL3M5XVzw8Zm0EGiOiT?=
 =?us-ascii?Q?SBY2dGRt5bzyUlySNnu4neucMBO9wOkwh2gAypd3cbpSF6VjJ7ZS7Y10xY74?=
 =?us-ascii?Q?Lfw6Jzs8wfkHNwW/F6vIGb1TotLxVI6cCjN21c0RW1i+E4I47XaXcNnI7iNB?=
 =?us-ascii?Q?8Vk7LWcmE7LZzSbzBZZGN0AQ5smjsnVb1dpt6fS5Px4NFBmtBCTzs69d+9aT?=
 =?us-ascii?Q?9R2z1UoAsRzQArCgvp0sz2x8qfHyHgsOmhst2wui/8b8rmAKBN6qwpLIrbNJ?=
 =?us-ascii?Q?1lo/iwRA2ef8gbQT3xVtfGlBgbgzAF5O8CV5LY/+PBSnVFiHPJbe0rnrUzcW?=
 =?us-ascii?Q?g0OymDEhHbYrFYtmOO56k+Po7LXCGtIvZvlD8JFtwA3tap5cn7Z6xdFe1iCs?=
 =?us-ascii?Q?mA3U4ygd9L6WTPelU2R7fiuB0rNSX2RObPkvgVevSFJpI220LbIJP7pf/rZI?=
 =?us-ascii?Q?aOHXtbm+nLYc0mN7ZJ3ZDCq6lARx0LF5asFE7hVtziqO0KcbrmhMt9IOQC1B?=
 =?us-ascii?Q?oZAcoLT7MKCQLpGoECaD1+vTg+f81pGs4JRAaqqt/J4aH7aPLa1pR7y7bgjE?=
 =?us-ascii?Q?fgMlZ1367NQ/Ii4ufvQKOpSG3tOxsceqpclV41OcKiJJtHnus3ryK3MlwIc7?=
 =?us-ascii?Q?Nbo5zz1X0QYpYFOPkCZzhTggEcSr16yhCIlaocmHYVaQ2l/Bn+bVhUEQQLL1?=
 =?us-ascii?Q?xzP6lqmunKrhm7LHnaUxLSFB+JM1O2x5L/A5FTw+fuL8kM7KvZK3ptr+ru8K?=
 =?us-ascii?Q?5r+s12B9YCvC51MEXoTAu42O3SqBPUGA6SsoEbsp9dtLdbkIqR4f+xBcbkZ1?=
 =?us-ascii?Q?7E00aqMDMN6gPx7/HkdI/X4QIn72bLY0K7lvhZX7nyNWuxuwsP1zdtUds71K?=
 =?us-ascii?Q?2aftEHGTee0h9doGr33e2nJ7ZrP285kzfrBme2/OKVYGiYreGzIWFPa5Bn5r?=
 =?us-ascii?Q?R7VdA75GkLUzfzdhXufdGN/Urw+m2dlNAGtAdDO+jThwcdRq+c41cnrcOKhA?=
 =?us-ascii?Q?9pZaEz4S2QjeAp2UP0XhMzI++6Un336PWpcYhtJP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a52e199-6c77-42bf-ee1b-08dcf1d95095
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:04:44.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIa/nJxg+ES1147eeIxb+NngAymS7nFtnmfPVSSnwTeOKvs68PwVIJRRoSzhCPKVukV3gDhkofvD+SKk71vPtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5924
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 16:15:03 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Wed, 9 Oct 2024 14:49:09 -0500
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >   
> > > > Li, Ming4 wrote:  
> > > > > On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:    
> > > > > > From: Navneet Singh <navneet.singh@intel.com>
> > > > > >    
> > 
> > [snip]
> > 

[snip]

> > 
> > So...  for clarity among all of us here is the new function.  I'm not thrilled
> > with the use of a goto but I think it is ok here.
> 
> Easy enough to avoid and I don't think it hurts readability much to do so.

I disagree...  See below.

> 
> Your code should work though.
> 
> > 
> > Ira
> > 
> > static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,      
> >                                struct xarray *extent_array, int cnt)           
> > {                                                                              
> >        struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;                    
> >        struct cxl_mbox_dc_response *p;                                         
> >        struct cxl_mbox_cmd mbox_cmd;                                           
> >        struct cxl_extent *extent;                                              
> >        unsigned long index;                                                    
> >        u32 pl_index;                                                           
> >        int rc;                                                                 
> >                                                                                
> >        size_t pl_size = struct_size(p, extent_list, cnt);                      
> >        u32 max_extents = cnt;                                              
> >                                                                                
> >        /* May have to use more bit on response. */                             
> >        if (pl_size > cxl_mbox->payload_size) {                                 
> >                max_extents = (cxl_mbox->payload_size - sizeof(*p)) /           
> >                              sizeof(struct updated_extent_list);               
> >                pl_size = struct_size(p, extent_list, max_extents);
>              
> >        }                                                                       
> >                                                                                
> >        struct cxl_mbox_dc_response *response __free(kfree) =                   
> >                                                kzalloc(pl_size, GFP_KERNEL);   
> >        if (!response)                                                          
> >                return -ENOMEM;                                                 
> >                                                                                
> >        pl_index = 0;                                                           
> >        if (cnt == 0)                                                           
> >                goto send_zero_accepted;
> >        xa_for_each(extent_array, index, extent) {                              
> >                response->extent_list[pl_index].dpa_start = extent->start_dpa;  
> >                response->extent_list[pl_index].length = extent->length;        
> >                pl_index++;                                                     
> >                response->extent_list_size = cpu_to_le32(pl_index);    
> 
> Why set this here - to me makes more sense to set it only once but I can
> see the logic either way.

I put it here to group it with the changing of pl_index.  It is extra work.

Since I'm resending I'll make the quick change.

>          
> >   
> >                if (pl_index == max_extents) {                                  
> >                        mbox_cmd = (struct cxl_mbox_cmd) {                      
> >                                .opcode = opcode,                               
> >                                .size_in = struct_size(response, extent_list,   
> >                                                       pl_index),               
> >                                .payload_in = response,                         
> >                        };                                                      
> >                                                                                
> >                        response->flags = 0;                                    
> >                        if (pl_index < cnt)                                     
> >                                response->flags &= CXL_DCD_EVENT_MORE;          
> >                                                                                
> >                        rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);        
> >                        if (rc)                                                 
> >                                return rc;                                      
> >                        cnt -= pl_index;                                        
> >                        pl_index = 0;                                          
> >                }                                                               
> >        }                                                                       
> >                                                                                
> >        if (!pl_index)                                                          
> >                return 0;                                                       
> >                                                                                
> > send_zero_accepted:                                                            
> >        mbox_cmd = (struct cxl_mbox_cmd) {                                      
> >                .opcode = opcode,                                               
> >                .size_in = struct_size(response, extent_list,                   
> >                                       pl_index),                               
> >                .payload_in = response,                                         
> >        };                                                                      
> >                                                                                
> >        response->flags = 0;                                                    
> >        return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);                      
> > }                
> 
> 
> Alternative form for what you have...

Sure but lots of indentation on the common path which I have grown
to avoid...  :-/

Looking at this fresh...  A helper function works best.



static int send_one_response(struct cxl_mailbox *cxl_mbox,
                             struct cxl_mbox_dc_response *response,
                             int opcode, u32 extent_list_size, u8 flags)
{
        struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
                .opcode = opcode,
                .size_in = struct_size(response, extent_list, extent_list_size),
                .payload_in = response,
        };

        response->extent_list_size = cpu_to_le32(extent_list_size);
        response->flags = flags;
        return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
}

static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
                                struct xarray *extent_array, int cnt)
{
        struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
        struct cxl_mbox_dc_response *p;
        struct cxl_extent *extent;
        unsigned long index;
        u32 pl_index;

        size_t pl_size = struct_size(p, extent_list, cnt);
        u32 max_extents = cnt;

        /* May have to use more bit on response. */
        if (pl_size > cxl_mbox->payload_size) {
                max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
                              sizeof(struct updated_extent_list);
                pl_size = struct_size(p, extent_list, max_extents);
        }

        struct cxl_mbox_dc_response *response __free(kfree) =
                                                kzalloc(pl_size, GFP_KERNEL);
        if (!response)
                return -ENOMEM;

        if (cnt == 0)
                return send_one_response(cxl_mbox, response, opcode, 0, 0);

        pl_index = 0;
        xa_for_each(extent_array, index, extent) {
                response->extent_list[pl_index].dpa_start = extent->start_dpa;
                response->extent_list[pl_index].length = extent->length;
                pl_index++;

                if (pl_index == max_extents) {
                        u8 flags = 0;
                        int rc;

                        if (pl_index < cnt)
                                flags &= CXL_DCD_EVENT_MORE;
                        rc = send_one_response(cxl_mbox, response, opcode,
                                               pl_index, flags);
                        if (rc) 
                                return rc;
                        cnt -= pl_index;
                        pl_index = 0;
                }
        }

        if (!pl_index) /* nothing more to do */
                return 0;
        return send_one_response(cxl_mbox, response, opcode, pl_index, 0);
}

