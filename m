Return-Path: <linux-btrfs+bounces-4662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 213788B9294
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 01:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958481F223E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 23:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB816ABD7;
	Wed,  1 May 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkKTU/3g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673642A96;
	Wed,  1 May 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714607374; cv=fail; b=HNfsq6JBCHUydk5a2U11F9SBOnAoYKqcIhiDaZm2B7IZM03hz8hpLgBJXZrOzc/oiYARrMm/mqrZyM4WWGBRRBByplOVFLa/c7xRT17vYtI5QnY2uEoisOR6+ZgenB6TmmVEutqIrgZgmgUGJG2lmn5J6Zp/DFeGczsqAcxj5/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714607374; c=relaxed/simple;
	bh=CbIMkCdzWexyOmBUzvQ/ZSrpCyL1pBz0ZITzyz8GLbA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPeLnDiGaMRQ8t7tQOX8RSk4EhkEwKcFau4mfbHoN0gAidI+++RiGR0P2AHFGYZv18E9Cf8iGPfkewTFmgISOJFiORfEiPFk8WXwS9SDZ51pAjk/IzzQBxD+SBfuZRdsaHR9AWs0L9ZTpD5lGS6qiMiwGtg4Zks1JVqFF1+r4RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkKTU/3g; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714607373; x=1746143373;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CbIMkCdzWexyOmBUzvQ/ZSrpCyL1pBz0ZITzyz8GLbA=;
  b=nkKTU/3gm7HgtSTrs2bBs9aMoIQabZ+xf1bjMdbv37cyFZm6sbIm0ghl
   ibSPNk03bkPfmNMTnREb1kC+6xlEWR564fDJQOrCEnt1aw/U/3pSoA297
   w/Q3XNp0tHhQOCqK/inSu0sz4NAMKKbHr0gfX8UuJMTwnkf3ZmOzWGtsj
   3vVkCODpCvH9vOi4LNV93jmqjJWKzX75u71HwRryb7gR90qmfmfo9PbOF
   VSWKbmrR3fQKqwGvByc2NiSds/N6OU+lGDNpQ8PZYq+xaMht3gNUJx3Eg
   dROTyXbHd3NgLMRGGC2x+yLsIfst2nyidKSis/UK7j0xlhmYPyVzaCWVm
   w==;
X-CSE-ConnectionGUID: R3LvLriDRm+iIiJAsRUW3Q==
X-CSE-MsgGUID: SgxX0i1pQRmNeFoF8rN/Iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="27886498"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="27886498"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 16:49:32 -0700
X-CSE-ConnectionGUID: 9c6HtlDdSWuZ8Lh8MRN9RQ==
X-CSE-MsgGUID: FNTiTdbDQWWcPK8yRm1+zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="64386241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 16:49:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 16:49:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 16:49:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 16:49:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 16:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMDwneeABX9G5xo1cqZ5D3TN8lBzeeO6jHx1dOehX0UknUPuhwzXpmo6RfvbZQetOFnYKjZnxHwNhkJPTdiO3RizaGzRoT+QYd5Czpc2ee9zrmQgOobP4HccYtrj/AVpo9torq3YjZHVQn+VYdUKRDUl7WBvL7ttejlHQmr1f0WazIuwuQDFx3Dzg7o07Ovg6/k0YWEeA5GDuZ8+WrWrYnKBKx/UcRui0hJTxVPIdUqSV92WTjVxCDMBpxcTKjqId3Vs74knGFKUEfJxk5BzBVk3NPN3ju/vtnFND7xXuAOSwFcB+G3+wjOmiv0TOrp3bHH6rD/1bP6lcD7NkWdfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miGfn8J/y5L57+62aXH+6KDIq/wJT1r5rHIqZIHZVfI=;
 b=WIhb35nuxnLkDqLOdI53wJb4BVC+/LF6eDFIVzLEHHYd8UMQdZ8Ae4AshpZE3Y75jWEk1Tihh5lCUozpT9WhiSKtANuR61ZxoNPWUIoIY8Xd/ToiVk0fL/yJA8tnPXlDRb49xIuiCktU6yaS+0Lz+dX/FtoRlkATvjynEZKaHqhC+MvM5wTP4vx+YnkhpwUjybX1xlsnpvv0RXxwIkzs9I1uI2zc/oFZf0HpydG+yzXyznQU08Viq5x63c4+auzPRcp7zCdT8QcKdeKe+s+PLiIBrPgPa1JnaJBpKC9VIqZHMaj3YgxAn4MqlIWDouYPboiDeSKKUnAjLYJRxznfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 23:49:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 23:49:28 +0000
Date: Wed, 1 May 2024 16:49:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices (DCD)
Message-ID: <6632d503f3ae5_e1f58294df@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240404184901.00002104@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404184901.00002104@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f206a8-b4c5-445b-1c47-08dc6a3956d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8EgXaXaWDkflbZkFXdAPZz6BVOIz6Y7+yzcLHCHLgTd3Q4CGqjdhouZAAxlM?=
 =?us-ascii?Q?8mz6icSIr6jyrQSBYDMBCt3SU96p7PgaZkFRqZT137YH7ifAZmheEeznpo6f?=
 =?us-ascii?Q?XMWdqWZ30xuQlKSawCwnHccGe6qrWnQEGjh9fM3cy1WKqrrwz2vmDodAgRwx?=
 =?us-ascii?Q?dd4p+qzdolWCsgs/vnPS+Mgm7oU8ekaDr774+CVLBUEQof8D+//RLCDzThh+?=
 =?us-ascii?Q?XHpRvKu+deYPo2+eqr141yyGdZD2jA9xjlRrX08AlZjyib2d4XbcIpe3LFm6?=
 =?us-ascii?Q?dgadd7PxCrUkBFt0NATYYH3s/zkm6iiYhWRwol9H80UCLUtnO82uSOKAQCLw?=
 =?us-ascii?Q?DF28uDnP041p+Agzx8X6LX/iBg0fDIp0cu7deBQ5y2LvmZE9/WcVgDHxonbJ?=
 =?us-ascii?Q?V7IvO/OVZ4ck6ZEO7H9jQiVkQS6fNOvYqGm6/fCD4qglj9X3hk+mZ3/0icAz?=
 =?us-ascii?Q?Bd18sSb1WdhNNZuv6/70cl9MRxs7Ipopu69bmXxuIDkF/2KWOIeDM77ZKcSv?=
 =?us-ascii?Q?ZhQaQz+HegkbpooDaYvtEY/EE71SGlklX3+XxCPfQRMG8UO34G9o6hT/6uDj?=
 =?us-ascii?Q?mtbHMf0FcDL9/a+jV5QM61BhB7xUZwC1zGohI76akwL5++lOo5B7QspC78Kf?=
 =?us-ascii?Q?/xQmziKalfQWrUzYJzX11yTVYlj8CbFsgrCH5fSruWeeIzO3e/a59i+D7f2v?=
 =?us-ascii?Q?flYpEz/tuOUNAfFuAoXwv0hXcYuaklmd2mEjgciR7eOtXBbIXUj6XOYiK9Ol?=
 =?us-ascii?Q?T0OluzxSn6/URKWJfhPKXlyYqDrO8sJGezWhl6hBWrUeOvppPVJOmbqNHfZh?=
 =?us-ascii?Q?5S60B89vH4retOmxn5Qt7N7PJuObnDxOedU9xLq2y0Dk/Fxb3sqMNTUWSPSF?=
 =?us-ascii?Q?HE2mhdxeiLZplz1DtWmjsx1axZ23wSir8WLWeUo3WLrB/Vex/gO0KZNUXwHv?=
 =?us-ascii?Q?U6vY5q0/yIfo2ABgGAe093eiTS6wCETEu0qpX9kGDZExlY2dI0+SF6gfFCOP?=
 =?us-ascii?Q?B7guVsodVubd6E4C0Sssq5aXLuyK5wJD8x1tnVCEq9Pg4n0DcbNiZUiRRbrW?=
 =?us-ascii?Q?fD4/ndFhSQVywNYR5OrOgrxOf/CtnuSPoJe4+Fkk+oAP5iM8xT3Z7AvjYIHc?=
 =?us-ascii?Q?iOs3PxUv6VLFDy2F0orVUwgi+hBW/Jn56XIerhgIu07sLPUWq7SqSHC6DHKU?=
 =?us-ascii?Q?2Ue7EMORCCe742bEWNYZh91J4WnfyOWpTpPqxtFeu335B8VBBH+q4LkdH79c?=
 =?us-ascii?Q?f7vVLeivBZbhdMptlGO3YOaf/8gGPh7pQW9wg9Qb9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bEBpGVKvz7Zoax7bIMS5XUfW+XYlvLEKmNQW/AqZhOTmgMAIBiGR1l9H/Tze?=
 =?us-ascii?Q?lusCTqPDUXuwM5qRfjUxUW/rrwPuaKVMAJHX3/3S+UXZtAiln4I4JGJQF9GA?=
 =?us-ascii?Q?tXZQb0G/j0+HshcAt8ekgiP2C9Mj3ZdG1dnxXGxdBrtUAqGfcJWuXDIf20Kd?=
 =?us-ascii?Q?43r23K7X5DfS+ArtVVBAFN0qBtOaSZ1Mp5FaGcixqGTWYuSFfTjz/uWiIq9A?=
 =?us-ascii?Q?so9U8/r8VscJUOhK1BXV9Knt44JqiMy0awVYBO2kbdz3mPBkXvFKv4ko900B?=
 =?us-ascii?Q?URTUVCSXdFp6sR5Ki6bTB8NYz0q8DEvQ5W1NPC8gz+mQ3fImjarawRY7Yiht?=
 =?us-ascii?Q?biz2XgB8gU7h8g0iFgV50EyBkmsx7cix2RVkliqBrUyBioPS2b4A9zfmTOtX?=
 =?us-ascii?Q?UqTqwDquF5TXYDR2tYaL+fLgh6aPqlm/6ImhnFah9/0UfZ3QHKOMt/bRDNhK?=
 =?us-ascii?Q?k5h8GOp8PwXKhsH3dsl8lIZeUyyrztDnsx9tTkWY47BsLC4IkrdAHX06kWkk?=
 =?us-ascii?Q?Uiu7iAXFjnVf7vscHmt1ftvpSot5nXeEtRZJAESXTEh7c+Rv/gzQk/N4BtTU?=
 =?us-ascii?Q?orL9eZat0lzrDc1PVxp+0RUOGhYKeH/OrrpzxwEtYHR9A/12owuiZfdDcIRi?=
 =?us-ascii?Q?jW9eBo4xmRGnJu/Ey6ojugYJxk0hRF1XPO2iZLjYWFlKE8y88z2uHK81jQ1D?=
 =?us-ascii?Q?vPQBdEl0k1DvZTXhhefEg3snjirBq+i+ob7IAP308rRWAmzAGBQAZfKoFXW0?=
 =?us-ascii?Q?nzI3pZxJmZsvTQy4ILCrqIuRmleIavLlJWKaKlwHu8rb4PH8Sp7Q/f8hXvPL?=
 =?us-ascii?Q?AQYYgDa8nlbrd9Y85VMIdFk0xFD+tO0PQJXoaBlXNzOlC9etSNJPhhYt8QL7?=
 =?us-ascii?Q?b/0FinkBj8pgaEGQI5PlNMDDkvD+xNoG6J5UEKc71LgCPtogV0duAUtua/V6?=
 =?us-ascii?Q?mXBHx5iAKiHy97O8JLAH5QNOo/GGl/FioKKrilXBU+hSOdcezhjhe8+1tf+a?=
 =?us-ascii?Q?TZhqd7dTC9DY0IoUxqHf5/clSD5uh6Sxpymfwci0rmbpesqbMT4VfbCXifmQ?=
 =?us-ascii?Q?aXszs5KfEro+Gx8O6RfN7CWF0cEiQQDh2I2iQPSkgBWNwO4JTcD1dxLJEiRu?=
 =?us-ascii?Q?Jd4pbiVc2vCKP42+UxYfcF+c+T8cZt0YFWcA4SPkYIl9WR2aXiDrOezks+3Z?=
 =?us-ascii?Q?Ix5NYlFdrOjLebEvT6gw7ZVNAMukOpJFY97eLK99Dx8kAreP1CuMOGLLxLto?=
 =?us-ascii?Q?svGgRnaJBj+3qAcEAa5au9Jsa5ggqe6Y1m+TIJBv9inQqrczMEnyPaSi+bKY?=
 =?us-ascii?Q?obz+CNsstSYI8s7dT22jPl5W6kivrk8k8LdJ3+fQyQCQ8ukVtNT84yim2vk7?=
 =?us-ascii?Q?eR01RECI/ZNDsD8RAQlZLZilLfcb1zh6pxbXZVJyyUd+y3VDwNxtOYQoRLic?=
 =?us-ascii?Q?5vMDiZ1LaOFtRMxgjBX5OuQCtqAHMzQNVN10v0RVdMmify4+3PDarBB1cxPt?=
 =?us-ascii?Q?QFaSTjpDMnIteuQJYmWGsjJorqgvJqGEAoRQOGSlRJ7HgHLE+7gp02zAcAlo?=
 =?us-ascii?Q?GFuQCspMdeIKu1c3/f7PA7FwVNOpRYTtdVauKScq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f206a8-b4c5-445b-1c47-08dc6a3956d6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 23:49:28.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWFNn8fKD5iuuAgGFM/jH5SiKKcHrqtoxJupo82d2RZ/p+cCeWT12MEpXmw6es7eiK0qPph5cUo38HJmtlRTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> 
> > 
> > Fan Ni's latest v5 of Qemu DCD was used for testing.[2]
> Hi Ira, Navneet.
> > 
> > Remaining work:
> > 
> > 	1) Integrate the QoS work from Dave Jiang
> > 	2) Interleave support
> 
> 
> More flag.  This one I think is potentially important and don't
> see any handling in here.

Nope I admit I missed the spec requirement.

> 
> Whilst an FM could in theory be careful to avoid sending a
> sparse set of extents, if the device is managing the memory range
> (which is possible all it supports) and the FM issues an Initiate Dynamic
> Capacity Add with Free (again may be all device supports) then we
> can't stop the device issuing a bunch of sparse extents.
> 
> Now it won't be broken as such without this, but every time we
> accept the first extent that will implicitly reject the rest.
> That will look very ugly to an FM which has to poke potentially many
> times to successfully allocate memory to a host.

This helps me to see see why the more bit is useful.

> 
> I also don't think it will be that hard to support, but maybe I'm
> missing something? 

Just a bunch of code and refactoring busy work.  ;-)  It's not rocket
science but does fundamentally change the arch again.

> 
> My first thought is it's just a loop in cxl_handle_dcd_add_extent()
> over a list of extents passed in then slightly more complex response
> generation.

Not exactly 'just a loop'.  No matter how I work this out there is the
possibility that some extents get surfaced and then the kernel tries to
remove them because it should not have.

To be most safe the cxl core is going to have to make 2 round trips to the
cxl region layer for each extent.  The first determines if the extent is
valid and creates the extent as much as possible.  The second actually
surfaces the extents.  However, if the surface fails then you might not
get the extents back.  So now we are in an invalid state.  :-/  WARN and
continue I guess?!??!

I think the safest way to handle this is add a new kernel notify event
called 'extent create' which stops short of surfacing the extent.  [I'm
not 100% sure how this is going to affect interleave.]

I think the safest logic for add is something like:

	cxl_handle_dcd_add_event()
		add_extent(squirl_list, extent);

		if (more bit) /* wait for more */
			return;

		/* Create extents to hedge the bets against failure */
		for_each(squirl_list)
			if (notify 'extent create' != ok)
				send_response(fail);
				return;
		
		for_each(squirl_list)
			if (notify 'surface' != ok)
				/*
				 * If the more bit was set, some extents
				 * have been surfaced and now need to be
				 * removed...
				 *
				 * Try to remove them and hope...
				 */
				WARN_ON('surface extents failed');
				for_each(squirl_list)
					notify 'remove without response'
				send_response(fail);
				return;

		send_response(squirl_list, accept);

The logic for remove is not changed AFAICS because the device must allow
for memory to be released at any time so the host is free to release each
of the extents individually despite the 'more' bit???

> 
> I don't want this to block getting initial DCD support in but it
> will be a bit ugly if we quickly support the more flag and then end
> up with just one kernel that an FM has to be careful with...

I'm not sure which is worse.  Given your use case above it seems like the
more bit may be more important for 'dumb' devices which want to add
extents in blocks before responding to the FM.  Thus complicating the FM.

It seems 'smarter' devices which could figure this out (not requiring the
more bit) are the ones which will be developed later.  So it seems the use
case time line is the opposite of what we need right now.

For that reason I'm inclined to try and get this in.

Ira

