Return-Path: <linux-btrfs+bounces-8825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0FC99933B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 21:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DC2B25895
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4CC1CF5C9;
	Thu, 10 Oct 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVooKoAU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F61B6539;
	Thu, 10 Oct 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590141; cv=fail; b=BT1qhnvyZDzt+0wLtnpXCjJGsQHWcvzT9mmT6MXbZEi6k8k1iYBWjsyAkC//HqKUIKnTs9d9R59nGcurhWZSH7ALrhJefCq0UEGhKaVK0q9HCTKtXuVX+jbmOspwrqi97WhcN5Byb0JnDz68DvWeiQAg4obfX0F+iYXECKpykYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590141; c=relaxed/simple;
	bh=wpQDyAPGpINWIS+lHSSfKKXqUFx+dmsIdcWiuPMIOHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tnLGOLo0TDSc3zZoXcQZ/1YDS1dSmXeG3T2gGgy+ltdk+rv/bexfNehcd4umAzi4A1P3rEgqX4gE7gErfSP7tski62Xf4s8VZj/JHi23frFMWibg3jX/g/v+rg3D6qUhhUKgpComdaJxiNMYQbSqThr9qZ4SDWZHX4bqUsEPRcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVooKoAU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728590139; x=1760126139;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wpQDyAPGpINWIS+lHSSfKKXqUFx+dmsIdcWiuPMIOHM=;
  b=dVooKoAUzX5Nee91Gp1ECj3E0dk+/Y6nyQVTyoRyWUXfTa6chNy5GOUv
   Ri/+e+4wrREVOepppeQHG+0hUINJ5eWPWqmSTpMRlEMqlcmxqhuviiAGo
   FlWwmsLLMIAztCp1i/diL5I6xamc0jxmXzApJn+9zH1hfIrI0j1OHod6N
   /QZQN5+FBJEOsXZvths1QB00LFtIZlJNWcYcEMLcUh/6+Qg2R/X1ICf13
   o5fICkBrOlYbWq4RTMB3iKyL6z2riYyytPiKjlOEOEfCxjNyJa0sKqVNo
   7RD90s6CzXYlJAxipjQjTxeRtBbbA8rBVuP6KxwHjkMuOHXdRqW01rUag
   w==;
X-CSE-ConnectionGUID: BsZZPO5eRaOkZolCNF07jg==
X-CSE-MsgGUID: ZtU39VGhTD+JD0I0k7zNtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="30845768"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="30845768"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 12:55:38 -0700
X-CSE-ConnectionGUID: Pu3ZyiekQIilkAwiNcvaZQ==
X-CSE-MsgGUID: ZVIgCE+nSvq8kzqbkH1HCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76620597"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 12:55:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 12:55:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 12:55:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 12:55:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 12:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTRChCgF4ctmtTwDGwjl2bi02OdxKl5zye6jaXw54z/7MJDlk2ZSoSrK8ARdDtqj7FiZ4edesJjcrMQs4jyoMxq9rULA0vE833miVDyPv4CSmt7kJJiGGz8BADbOIESM4SR3RnVTvDmUZoDGGPBRb68fNwnvr+rXaE03vKjEOv2yj4leH1fRjJQsHRyAJMUCM+icSQzl3PTAvKfHHj0GmFcfqVXapS2083xHr3SS4nXOj/yl+DqylNuWoSV8lURpUQZiMqo8MTufekXxADUXZLgV6kCdgx5IoZOZAWK4+G/4tkUAIp7cNtRE05keylo4H9wA1KyX2udFnR6UKN1o7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NAtbZnY7/8VJmVF2iIZRwc4DkinTU+d55DhqUd9Js0=;
 b=qQovGZMFNaC+NO4dSA5kUkKyHVnRiy+mL/aL+5Bdla0fJmXcngqutB4lDIuWhAOvNZEFHKNiOAI50lbioHfou+NnBYkMO0A5KUIulfv5pLFmP1jFLXc16G8g867qxBwcOZJb0d2rZUJ/AItudWC7vhz6z3QngIbhvRx8d9E5UaR6NuXpO3LCpc5uHDz8FO3vbk3Ql+71Aqc+TKH2gW5FX1D0mUlmXOhRukWSkX+SFsTQ6E5i4iNNwv47AJOiJ/QeXGfnim3Z9UJNGe8Dj66u2P5i4M2fN9jmO8B/1oap2sld2CflWAmDU7ycoyw4KgNWcouZW3jfWYzB4pPyP3vYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5877.namprd11.prod.outlook.com (2603:10b6:510:141::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:55:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 19:55:35 +0000
Date: Thu, 10 Oct 2024 12:55:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, David Sterba <dsterba@suse.com>, "Chris
 Mason" <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
CC: <linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.cz>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH] kernel/range: Const-ify range_contains parameters
Message-ID: <6708313495f51_964f22949d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241010-const-range-v1-1-afb6e4bfd8ce@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010-const-range-v1-1-afb6e4bfd8ce@intel.com>
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: ab394a6b-0801-4f8c-a6d6-08dce9658154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tpC9MJceY5+NqYHFrfMfAWapDlx5b4oQbCTT7IMYy46xSYYKHS2SMt3lndyS?=
 =?us-ascii?Q?NC9L2UQxQsgROL4Iu48Y19stX1efeGb/29j11nJP/AimJU+0wH7eC4A0VDZF?=
 =?us-ascii?Q?3J3r5agXGpQMc5CCn6K73Sajcu60MdZWbcr8PTHTyPVddypoRQ4k0BG4Y8bQ?=
 =?us-ascii?Q?Ec/n8V0QFaaEERL/XZEeZR+tgEA4Ytn5Cggz2UI9K6TriGvhz93zhPMwysMR?=
 =?us-ascii?Q?MEDdCzIuY0h7cQISN8RKDLcda0L7+xe09V8R8eO7irJDkIbeAYxXFGz5XchV?=
 =?us-ascii?Q?vhu6KdQdtnE9ADOBhvnL2aGAzzu7Djau4JTWZdW2/5rQYR4oTTOYUn6HwjRE?=
 =?us-ascii?Q?AjfNgVUHrS2dtGNE2exzi3N95sdL95YSPOK56xV3ya4JcCtu304RFhATULLJ?=
 =?us-ascii?Q?nEmiloZnSv3MNFdiFV91CBBkUg5DJuCEDIdYkvhD/6+kfJEDGmx253NdZ384?=
 =?us-ascii?Q?G3fhRBABkBX16G89EgIRH9LwSQPeyPxvpGu342m7g+xf7hqM3/F5Qqybjv+c?=
 =?us-ascii?Q?NVVX1N+ZPJvC6lmoVP+A3yc9ey4y+YVH+VE+ltoSqCvirEGc9U34F/GGb6+8?=
 =?us-ascii?Q?dfikfxsZnGCpYFjcztWj8Z3ESuKHr2qOwn0oZSxP1IIirmBTrsqYqGX0J/sS?=
 =?us-ascii?Q?UNpcixLK0z+tg1u3MgoCyhDzhumGeLNxEc2cRqxrtOjbzRO6pPx95IrH+UC6?=
 =?us-ascii?Q?3gz94C+gDBTkwnjQhAy0D+UQGZ4QWxV0YaeuvxBJDDKv6yeWN3EOX8E/2+6r?=
 =?us-ascii?Q?UkuKITe4O2XbsMVACtvYfXipeoiYurqXX/Mg4zIAzTsgohu+RCLW3rJHQxmF?=
 =?us-ascii?Q?tHeyWgDlcOu/Fw167K46kf1TQDoFSkQl/gqa0P26u7Ue5deOYej/HJihw+7h?=
 =?us-ascii?Q?6u8YeKFSwAl3+nKAjD7xe4KaUkpgAH6cWSLSO8oIZlKbuN2h6GsQ5799b6p4?=
 =?us-ascii?Q?xJK4FD2HNkUSMoQ9AkxKhB58HyidBrZImVkMkgYFfGdfZLB1LeUsT/XzhLZu?=
 =?us-ascii?Q?hxy+7uuXFNOaffm04LHXx514iNhj+cCKVCNvaCqBoO7mMo75V6aG5E0Deek0?=
 =?us-ascii?Q?7W4icMPSTLBSX92q43zTetbiNBl/SeCR83CNdozB61JtAH7uvI52GAjpIVsr?=
 =?us-ascii?Q?Op8y0DTYfh35424xNqUKuAcBSNPmRfWYLWmKji/jCtdeOc0p+Vrh1LdDvyPX?=
 =?us-ascii?Q?ksJ0ZkaT92vXqxwu+cpddwE4v7cASsuoDkUkJXnhqRV3V0dinI+axHwg2KA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8vMW3zhz8F3I6o4nWWesatr22a/4VXd5ABHHauZFHY854Be1IeUsWwJb671?=
 =?us-ascii?Q?3H/LD4e4DJ5SPvuGyVx8CSU/dp9zt/HTUeaJxx22bP7AxCCKfFKR8QxOtc8r?=
 =?us-ascii?Q?oAsmpzAqE2IjDa+jv5NhXWjFjd+g/l3DwAg6x4EpAKX/gBg25B3pdE7bssIv?=
 =?us-ascii?Q?qMSJEJrAdiftDCs5z6Wkkw387Al+BuQoOIKWcM8me4IC4Pm5UHUYaWhiPSOI?=
 =?us-ascii?Q?G5DR/ah6HeM2VJhAkHuMJTQDOvvPizAvlhwcq6hZGjHhYSHx7++JaBhe36yt?=
 =?us-ascii?Q?qdJ5vgpNw9SgdvysEQGRsjtfKgqpO9uFXkwf0m1WEI6bz9xTsG8cSa7oFED7?=
 =?us-ascii?Q?fD/SufE3aEnQDpV8vA8RE3eo3jI2BU09/1OafI8V9dQfoODvDx4mAxnKnTfs?=
 =?us-ascii?Q?TiVhR3/gmg2A8zOUs2+0PfPF4zADRTC2MP4X8bl0iODYKXIrOHh5coSW557+?=
 =?us-ascii?Q?WMn9WvWHNnGTBnGsul+vCyxFk267ed+FayGKzboi76ELNgWwMvmOX/iWcbe1?=
 =?us-ascii?Q?SqebpUCplDKOYShyRsB1cUf0IEjYOYXVG2Ouje5VOKAgUm5AzQ+IV0MRtw/V?=
 =?us-ascii?Q?ZKmxspf0c4e8m8ml/QoVrnyPN29eBBqz8G1XX6TOGijyuUR1O913P47ygq//?=
 =?us-ascii?Q?Q8WRDy6mA/6uqknp8OzLiaoee99ODD+lfopwDQGSC31o75HQjgdv35Z+ma07?=
 =?us-ascii?Q?5gpkX1ZkAhXm8WJ+CbyZGcFwB4WP4WCIxqxO7Hk4QbUVZP8n7veLL452OjwZ?=
 =?us-ascii?Q?gIZvAt9R7x4dVg9MujlaX25eyL9x3zgg6r9uV3dPG67vd8PUAPvV9Y693th0?=
 =?us-ascii?Q?kAapiJuho0EIYNBq4gYfnCT69y5TABQ9Hdj0/SLqEOJUVRsCeCTSzgfbkpdN?=
 =?us-ascii?Q?22ODcH8sg94THgfuH/PPJGgxr5wEH80/Hke4wDvCbfmjI0R78qekWuQcXx3T?=
 =?us-ascii?Q?yzrsvyZ/dPI1oPwTBazrO9eMrxTF0JqTUn2n67FJNqP4dSScrEDw8LEiASWi?=
 =?us-ascii?Q?u1HPcqn6qUP1ijqkoV8m758lAAZhwXJB7B7JyIBLN0Awl6NdNg3j6Ouus2eO?=
 =?us-ascii?Q?/3YG4D/dIl5u1if6O21n+/rJa+ruvq/y2Q4+iBlHS6O4icB5uqaSBSv4WxjJ?=
 =?us-ascii?Q?KdWBUwLW1FatBzHeB7J0Z+U7Cviy5xgpjwXl33wKyZlmIf+pQsjfkK8yWdu9?=
 =?us-ascii?Q?CUY1GjNWJw6TuQ9P/mlHQlhLgfa4enA5cAtxJ7DktWGRguYUbmEE8wb+kYXV?=
 =?us-ascii?Q?Q0B5rnnTXZnopiT+P5gf51qaS+QmpDbl7jeuY+LB5AE/oiM67HlX83REev2I?=
 =?us-ascii?Q?x+X9b2gRvDVuPyAoDbl8ty/Fc/0UKeJsA8n8bkNRlEP0SpO6JFS2UciHDsnO?=
 =?us-ascii?Q?yz5N0k9J8wOCngGETs/LpX8GoL9u52byv7/iZncIT1YhaIcHCAOyUV+2NR98?=
 =?us-ascii?Q?k79zRNeBwuDJQhauh0WjVoFO2hhMAfWKF8VYRdQuFn8xOt/v+FA/LJ+ES7ai?=
 =?us-ascii?Q?x8G7mg1g1XCFDOl7ac+CNSyY5gfLsANmxgVzRsGkEG9y69TBjFaFeAYC6LSQ?=
 =?us-ascii?Q?hBY7xyhwfZkjDRJY6pukBSQn8fxxQBuvnkHulu05zAoM53ZipQ6QDqsikElU?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab394a6b-0801-4f8c-a6d6-08dce9658154
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:55:35.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Stu14uQKLsrJxrm8eCyCOvSMoS+RUw06BIYMRy17OGHpuj+MgygMCcBJfGtSgz64C/QM1RsdAEx/VI9oI3SFVhvsxo2vtdu79Y3oSd7WWGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5877
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> range_contains() does not modify the range values.  David suggested it
> is safer to keep those parameters as const.[1]
> 
> Make range parameters const
> 
> Link: https://lore.kernel.org/all/20241008161032.GB1609@twin.jikos.cz/ [1]
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

