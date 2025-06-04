Return-Path: <linux-btrfs+bounces-14458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45164ACE0BE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017B3166AD1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCBF291142;
	Wed,  4 Jun 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zut3M4Lp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA97156C6F;
	Wed,  4 Jun 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048697; cv=fail; b=ft86VzVafQFClZ3x0s0yM5rzkbF/lioA4NHuj+k6H9BQ4GdxYWTcz0TV4vRnBAtI9ePqq4zqBGsts0uZfXlWv6u4O8RO4xAglqVJ2/lmHYyfr5fZvDWFw9k+0/e7wvo7obQQ+Y8lMdeeKeRp2ZNp5ewAoJCHavFxr8Ku48VAVKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048697; c=relaxed/simple;
	bh=5YfZu3Ew+agyJq2mndQcSLbEP6pB40h3savqzq0P7x0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Siqv44xlgjZXefe60wYyEO4mbFvKWKhZSdO7yptcDt7wDsU17FWhjZudfb03AWht62ppBDsmm24ycp2jKOlNJT46yadxlE+7j3KZnHTfknK2/IClgfaDj3FVCQoQbX2Loxuqg7B5sPCHc1qgMIFdbqFqczYoLSHgZKZvtO9zrPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zut3M4Lp; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749048696; x=1780584696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5YfZu3Ew+agyJq2mndQcSLbEP6pB40h3savqzq0P7x0=;
  b=Zut3M4LpAwQcR9tGHhjaA6dLvkPU9N2E6204GB632wAA64fbM5ekDnfp
   O3dNZ+9yTq/rDvuySVuzwdY2l4MSYNUbJQ7qKJJnF352MmXw+aoe1qkRP
   cK0ouIAMF7jx5A0idQ3WRsOpSoQunKului4bvnVUHmp1+OD92Ku29/HYh
   xTDr7B91UuazYSMiTlyRvgKQXinldNV36qS7BUlF765R/0XqZpty0TDsQ
   EUwBHjBShy9uyQoJQ4sppEsHgYxB3CXw8Q1T3iy64FNQON/Y65FS/0br6
   HGxfPY+h+RKH1CebcR5DArTyit3c82tleiYEEiAhgQOa88kcvI9Lnc1J+
   w==;
X-CSE-ConnectionGUID: ixhFlyGiQhOQwtx0UB62ow==
X-CSE-MsgGUID: 5flFqYY/SESbb5WX+wbcCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="76530327"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="76530327"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:51:35 -0700
X-CSE-ConnectionGUID: wh7uoRL3TqORDKEReIeo/g==
X-CSE-MsgGUID: uzxxF9FXTqes0VKOABl0zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="182388144"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:51:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:51:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 07:51:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSDJ63Usv5FTlB589qEG9TZF9aJmEPuS9GKZOvOVkiMtW/jQLpZcVSmspOL9zfw9AFbsXWVWmCmQ0Cqrgjykt5tS6xgp+1Yqc+HJQKaW3brCwDWTSLPGzJoslgV37Bu73SSHvLgdU/1YdNgyvgyFPayfMY34TpQ9KJXeW3XmaHRP0ut17Ef/B1Jb76Q+sCxFgnac3dsJp6KfbIwu5jdPE49R/8YRlrUtbCSvtOpZ5LuyCTVYVqf+Zi1zngMmhNUbXNER/lMO/6a55FwNwqHZxEnuKjMNKIzXtKx1VX4Tar3E5A/0bjdse96ygci5EFPKhwr5hoWYig0yutZ8inr9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1iHVBBnMHqV0fsQblfDyl4YR3VGaoylB+hENkSqPDc=;
 b=dznZuzDP9oXZUYgUUCq+LG4Cby8Ibb6C40vly5anwQLyXKqdLwqPHtg03rKKYiQJrO6uSDi32rTPA0PRIX/yy+g7q5AWMorzjJhIyPTSqpIZe9U6rR5c3MGT3xFC/p/1YvcV9uW4SGQ99dN87orP4Yo75iSVrSmEHMipQmdGqJdxjQQaL5s3ZH4SItt/6bT0vFK+6Blj+eYbNTP0gzggWEt1Vz2BRrBOd3N4YngMqecVzaEqg+Tn8O+ua+Q9UwN2Ol9DO/Kpv8qVI5seWNrkM3QvlFgOoVHuy6P9N0iVY/ToimK9Ph6hEH4flQMW0VA4EtFxxCyqdofURP3CZqmV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH2PR11MB8865.namprd11.prod.outlook.com (2603:10b6:610:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 4 Jun
 2025 14:51:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:51:26 +0000
Date: Wed, 4 Jun 2025 22:51:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  8af94e772e: xfstests.btrfs.220.fail
Message-ID: <202506042235.7e3a37da-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH2PR11MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8cdd6b-a3a1-4b14-aa40-08dda377483e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5EkUt5DZdZJXYHe6nmiQCLTop4C+P0OjvOeJLhiqoAzJMh4CUL9K1nnETNnn?=
 =?us-ascii?Q?PGGgstZazlIS7POPJk2960IRxXsQ4WV783Xnvp3DIIqQAtTjfBTHuLptRCpG?=
 =?us-ascii?Q?DTqQfKiTxsFvG6K5yYWCfZyOtr0GbQFw3GGaQHuuQNG7fzohV38PVM5GUEjc?=
 =?us-ascii?Q?znr9rtyRYM/vUtME11JmyGinrmkuXkMCi0OK1qTyxWdx7CIwziH71i8X55JX?=
 =?us-ascii?Q?CFtgk7U3HrRjWVQMWaWkuguaWHt0g/O9aSpfHa1qa+z4Y41RIKo151007lfz?=
 =?us-ascii?Q?l5Iw8D7z0ubQ7OZqQCWv8Gr45/dx97OMN7N814FKaTYYYmbLR/VQIwR2BH5i?=
 =?us-ascii?Q?EwdXsiUGsEhrgfkbIQ3ujrzDA1JXljroLVyMV/LrYfXjrSkWhgDZzU/hRKdv?=
 =?us-ascii?Q?mdw6uEPtFLSBFyUosi99hUXl48ne6GjdC3wNSzByer2Dkvc4VxVhqlJUd4Xb?=
 =?us-ascii?Q?SustZm/t5GRMX3oS8WowxbKEXdoYnVJga27HcA4yKkkwmMy+Wvrhe4GcRJfF?=
 =?us-ascii?Q?7iidLS4Gn0zT/VLSE4EgfzldWbRxM+pXLhCqRlczJ6Vi54U09BAJJr/vmt7L?=
 =?us-ascii?Q?v7JEJzjxrY3XD9pKA1NGtUeZwTBR1gTOCIT01Wi+71Ykd5UC44uqKul0vZNN?=
 =?us-ascii?Q?DAvMSmrUyk23DFf0/Kp8p364OD8tZIyEY1iyQB3wKmYY1Pjve01BCeTU/HW5?=
 =?us-ascii?Q?U2wvAJdM8hserUttT/+KC94SEJ2t7eyXoOV6SqFyGl81FMJ+HSIkrN9NC7+5?=
 =?us-ascii?Q?iKAoSqp5fJyoei1LrgJQf9ZwhSbKxU0nROBzIFga6mOWxGf52IfuIIbrSo+2?=
 =?us-ascii?Q?gz5ltFHc5qkgHkGRiQOYWxZzSXXF5jBIs4B0YrLpNUPb9/CA2OVu5Ya1suYC?=
 =?us-ascii?Q?/y5f2jnPn8DKM2ByJfaQnFvhQCKEOjhtu6EEVuB4VfWSWKjM2ZiZI7bFuUoI?=
 =?us-ascii?Q?+mwMBq49KqcCqSviAYEubfonQkAWCTihSgKNI86Ih7KS2Oc36rFqqLSx2hSh?=
 =?us-ascii?Q?RS8SVql78ZqQL4yUqB62t+tOBfa3uitSstZD+K7eeOwYx47QBApfrE6vLgWW?=
 =?us-ascii?Q?xHHQP9m8R8wF/1TgGiVju/mepwJOU1QAVNgyX3lVgjvpkPXpGUPebBV0ClR+?=
 =?us-ascii?Q?rnMU324F5+8azsMxtKI2zkN3vzwxfRa8ZaccESMM85415TIAJg4+do/3kYvf?=
 =?us-ascii?Q?U4tSvZHHOK77Mc/JPaDR0oV9LnufdlTyihSeBBIVHzbmRZ4yNFq3oxBbNjzG?=
 =?us-ascii?Q?GK7dqfEOPMZ6bPkkTAyb0RDo4p2+pen9aFjRqI0IXFaDMPzvPSjV07J2gLx/?=
 =?us-ascii?Q?589ow8lI5XsvrcHwYE7QKgRt7jeg/Qs04T2YTNi3Y7A92021GJ9WopKtzkUp?=
 =?us-ascii?Q?oR3HzlJ9yIvbj8RTh+9vV5jvHuBY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m3MeYPCAcNDwTEE/idWrZ9T5obke3Deu6eHcNu7e09j05gasc87lOmzRN2Su?=
 =?us-ascii?Q?Yc1IM3/V3/GXgdZZPBrmUcIgrN+3KyFWNl0D5WZaQP4VHaUFpiSe7VkluxNY?=
 =?us-ascii?Q?qiky6ADLDizXvE7YdfAu2OFrvmzXZm96R3MVMmCaTn7g6RM4zamYDhaevXNs?=
 =?us-ascii?Q?bzu9CrVwFGsM7QRJu97l5g+dJQos/HsJ4uK59vTlmG7y+lei0v1JlJdAGjnV?=
 =?us-ascii?Q?mtcBnXKX9P1oXybG2G4f8ctlMuFOCg/18oVpRsEvyz70wuPlh2+k47HaYc4M?=
 =?us-ascii?Q?U9bUhGHi9LbEN+W+T+t6yqq2LMV5i9cocoHkfMlRLUsZBJZLfS6nQLw/lxs8?=
 =?us-ascii?Q?tk9TyCi70iRJ4h7rvYq0TG86Rn2DhPshjIhgqznO+S5FDFRK4E90dOym9iT8?=
 =?us-ascii?Q?6D6yYCproIO6lOyXkGcEs4qIE4mWztuzs7GcFJVhuP05cFbdA6WCfVLpfyM4?=
 =?us-ascii?Q?e2F/xxvULW2IMQhK29OeCjqm0P3665sPQr68xhcBk9qrc/+QCUdUQ2s7TeZW?=
 =?us-ascii?Q?2z/ZXckfCATul0KxKRQCoQPGjD4a/KnkWEoGJtNrbIOJBeO8kgJww5qLPAlG?=
 =?us-ascii?Q?yiSjYNb5Qhic/3qiIKVjw2vk6Z0tAszvtSSm3gvDHR0faoy+7XNib2XyF+tZ?=
 =?us-ascii?Q?vkVII1iYWgWK5U27w6doV5kp6AUf0ZXFuSYOVlKbCdhO/tE9EUXdayoDDWWw?=
 =?us-ascii?Q?Chv2uSGITuQLLRltqrwziz9VKgpq/58UTb8gLptM7bY1/EgtHOiq3lec8WM5?=
 =?us-ascii?Q?1DaAqOj1gGp3qaJAhbtr3HQ8zpfbBKFtRJPapXGaUP9dIf7wNJmofJsH5mcK?=
 =?us-ascii?Q?yHQQLYwLwDOYdAhVNn3+sFxSO5/RbwWhvGquqofR8rH14/yIBTEcwmciJy4o?=
 =?us-ascii?Q?xSdNU7dNUiAs2nmAo1OSTBHqvfil5NvQzjmYaXsQRfW0iLT7DC17zFMr0qMU?=
 =?us-ascii?Q?OAceq2txD5J/sxSfqtuyGH8lz2kfwG4ZsOX8W1EvCB0FrSSbYtmbbpvBOmed?=
 =?us-ascii?Q?8HRlQvEwRzsFzpcFIim5KMWp+rNRwFh3C5RobVdeJaHLItzmULTZWtMxlU6F?=
 =?us-ascii?Q?ZfYJegAm84xRNLh63C7fE0dhEIGIXHI015qDBOK84HVd4Cy1jgGCdKkw9tLK?=
 =?us-ascii?Q?g8ylYTA/oXhFHqwUQNLI0Lo8PInRLWG90xnUbqiyn7peQ7GpT1kYkThnZdA5?=
 =?us-ascii?Q?kCAcUekRNH+hAzu/E/3Il6vJZ21GvBdi1LqTQQOCbdhqK7pHrDy4r/2imShC?=
 =?us-ascii?Q?XuIhIs0lkEiFUXWOdn1oFawQOo/e5uRlen08LEwFNQHmWVpHy4PFNTWSmx6n?=
 =?us-ascii?Q?3WjhTPgN/+wm0SWW5Hs+M8ScbXAwX7P4VXRoJvjnZr1dv5ks2UX3fD8rnjmq?=
 =?us-ascii?Q?a8CF0b9YlhAzY+tFSmwYkJZ35Jg8ctOryLjkd2rHXT8IdTY3DUuyeOuhuga/?=
 =?us-ascii?Q?uJRyOJvVN2B4YHRZcv85ctNe7gGgufzTI/z+5kAjHkty89QQUUz+yEP0NIvI?=
 =?us-ascii?Q?rvPnBN5JTWPPBCm7mAWH5tiolEYjJBl8z9ilO8WfW7sRC/za/yDnM2ldYxLg?=
 =?us-ascii?Q?FfpZJY7pPceLnlBplNUqXngJNMewcHmjSILf3MNeROWQ7S5WzR/dOyAEB6+B?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8cdd6b-a3a1-4b14-aa40-08dda377483e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:51:26.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28Axv1Ut44FUz+Gka31oMKuCMv53+Qw2ePMVRjLSfHv/W7mE26k84xdP4H4N3Ki2kiv4nwsp6cdI2NIHvInQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8865
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.220.fail" on:

commit: 8af94e772ef7bede90895318a3fda6c68a652774 ("btrfs: remove standalone "nologreplay" mount option")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      7d4e49a77d9930c69751b9192448fda6ff9100f1]
[test failed on linux-next/master 3a83b350b5be4b4f6bd895eecf9a92080200ee5d]

in testcase: xfstests
version: xfstests-x86_64-e161fc34-1_20250526
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-220



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506042235.7e3a37da-lkp@intel.com

2025-06-01 10:11:00 export TEST_DIR=/fs/sdb1
2025-06-01 10:11:00 export TEST_DEV=/dev/sdb1
2025-06-01 10:11:00 export FSTYP=btrfs
2025-06-01 10:11:00 export SCRATCH_MNT=/fs/scratch
2025-06-01 10:11:00 mkdir /fs/scratch -p
2025-06-01 10:11:00 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
2025-06-01 10:11:01 echo btrfs/220
2025-06-01 10:11:01 ./check btrfs/220
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.15.0-rc6-00302-g8af94e772ef7 #1 SMP PREEMPT_DYNAMIC Sun May 18 15:54:12 CST 2025
MKFS_OPTIONS  -- /dev/sdb2
MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch

btrfs/220       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/220.out.bad)
    --- tests/btrfs/220.out	2025-05-26 16:25:04.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/220.out.bad	2025-06-01 10:11:04.131877139 +0000
    @@ -1,2 +1,5 @@
     QA output created by 220
    -Silence is golden
    +mount: /fs/scratch: wrong fs type, bad option, bad superblock on /dev/sdb2, missing codepage or helper program, or other error.
    +       dmesg(1) may have more information after failed mount system call.
    +mount -o nologreplay,ro /dev/sdb2 /fs/scratch failed
    +(see /lkp/benchmarks/xfstests/results//btrfs/220.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/220.out /lkp/benchmarks/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
Ran: btrfs/220
Failures: btrfs/220
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250604/202506042235.7e3a37da-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


