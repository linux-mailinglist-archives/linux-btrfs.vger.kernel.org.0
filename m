Return-Path: <linux-btrfs+bounces-8993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E29A2FF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 23:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1650B25339
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 21:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2EE1D63FC;
	Thu, 17 Oct 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9wv+6Cl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2EC1D63C2;
	Thu, 17 Oct 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201213; cv=fail; b=Gdiu4e5pVHQ+iDlHNF3MWL4lvOKcLDacYc4GJpjItqOJb/+K4SckOX/3cpuXD7C+ayZLcUEZzQWDpARQ33Of09DGwmP2Y/d1FQE7DkSCZ4SL6hAxNzWMLn7/2ybWsE3ppwQmaaNd3RN4dpHM3cA6oBOAqli1HeR92Yh3RI3jOuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201213; c=relaxed/simple;
	bh=30BN2POOMOKr8jncE14LPvtVp6sqEeXq3wVR5j76u50=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1Lurxui9oFL6XijPoT1VuBmPO0zl3T76+zO1RC/dweY5lCszgW+cJf+rDIGXG14JDX2Pvqy5ES4AhcyibYrD6j0HAcQZeOaDFVLsgftkxzwAlRU8VvHoovNVEbCmoRU1b7Cwf7mSMPk3qZfCUNgmZMfm1tnp9WrJ/bC0ybNoXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9wv+6Cl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729201207; x=1760737207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=30BN2POOMOKr8jncE14LPvtVp6sqEeXq3wVR5j76u50=;
  b=E9wv+6ClYTO6uBhKMhF/IwX2N9wiQ0MrLXikoyBwkbLLlt8PLMvlUGVw
   k6DWh5BbwnFNJjrnUk/5ey56WScvdPKSiG74hb5hmEdygn/EqnMi1jfJ/
   1EMGKp574gTcdi3vcBCRrUeVwPM/O/r2qJMtNb8So4ps2t8Xf3O0TOTCP
   tOJLFd2DCDsyA4bQHSg9DK3Ay729UNn0GB2QT8SE4SAw+ZkztQAlhdnzd
   2jYUZPXKCzmlaaIG5JUJOYybNg6z8y9K65ohb144UqXT6C7nkSVoFv8v4
   3Om/XWlndPyTO/vijV6Yw0L6UxCC+RoEIO4MVt6EhyanRzgziDyKmgI4Q
   w==;
X-CSE-ConnectionGUID: LG+Nz3pJTmSS5X08kSxXvw==
X-CSE-MsgGUID: VNlVfo/FTOmhR3f58RPDVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="16334301"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="16334301"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:40:06 -0700
X-CSE-ConnectionGUID: ph/YMHyDRGGrhrOJwg13Aw==
X-CSE-MsgGUID: 0I7nVq7QSq+c1b+vog/qcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78645675"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 14:40:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 14:40:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 14:40:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 14:40:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynvJk2K3CUYF1NX/cPaQU4mVRmkGNGv0Z2Mg2ecrI226dYh7FogM3GAgNZ41LZMueDlblVXiqaTxXOOyeSxzd4A9lAwDH1460yYtbU5y5K5B2k4Gq6YWQ3cVNOUoTK5/F7hP2xFSbO8cwSGRbYjYX2tUKXKRnm1wn+84yWcVIlHrDqoowwyEHP2C/lcdpaHytRHqrHZ5+FpAwoMSC6eMfZJVK04t9gmCTLGY4H1i/RF3m+Ve+cwukhJJLwdTJw290N0h/KVgkfKhz4pPfpUuBxKlcuf2I8PglqfM6TUOqW+8eeTZBTzt3Ux7EDSl+GE0Zjn9sUKR01CqiofFPVDUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xty6UORvxwXr3wqU5P3Zr0qC0ocjBaIv6yhS3Zn8AAo=;
 b=ZvVew5OZdCXIgwC0vISIcmGqP0RdmmliL7+scf4hklE3gSZwFLmo0R66ji9VO45pIDJXm/mIPjHIRWBVksANPkv+Atih9WfPRJdEiDfI/qwmfqUMbuqwvQRMxtAySfueQc6EZvGjwjeM6QcPkCsxwyB882+fiewtCtMZvoVIhdB1GIT+aR0idzeXv7CdFceLI7syZjn88aiM2XSc2mbhn0gbe/EJFRVhvVv7/GuZt4H/q4PM+ZN4hoCcFXQ/h0NzFw5CjCB3j6/bpY7tSf1WgcKvyWNf3EqBJTE5gejE+8p1x8jQU6C+vfAk3aNM3siyVaONfGYf3V2FjQ90Mo48Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Thu, 17 Oct
 2024 21:40:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 21:40:01 +0000
Date: Thu, 17 Oct 2024 16:39:57 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
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
Message-ID: <6711842d88fa_2cee2946a@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
 <20241010155821.00005079@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010155821.00005079@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfec3f1-a7b2-4ee1-6050-08dceef4416a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SdzLvYlA0qvTPN4GAA4oYylSNgHmNP3zTJtvIpaYlY2JqX16vVgrUywO0zUm?=
 =?us-ascii?Q?DaTfswsNsV7G1QUsIzKeVC9cmG9O9A1alKw2tueRK3sUChtUYiYgJwocMkeI?=
 =?us-ascii?Q?5d3J6ga+K7moumLiYJvtVRuTnwZAjIqi4iHPmNx5k6CBTf2Hpe1iPpH8IiGS?=
 =?us-ascii?Q?gO9n+XZ2ZIk1aGJl74VdtZXdcfy9/DSS/I8ZQ5M2Nnu+WiLfU2spn+BGgnLR?=
 =?us-ascii?Q?ZY5iwjsPo1BXyfUAUu69dUG2FGfwHBISqUXsHzaIbJLpNn6DSNh8GluYA74L?=
 =?us-ascii?Q?kAiIAXaso/Q61f6+YiZOnv82uUyfGkFYM2rO7/Vw++ZuzTcpNrAB8/7DEvI+?=
 =?us-ascii?Q?R2dARmsSZjNbplMmNqrhTWIgfFK/OS6P//yRMDHnPnAO7nkta0VctsZqXYQW?=
 =?us-ascii?Q?7cm6hd7Uv1K4FvWt1/rzFmMQu3gOlEDQhS9Brv53pjJEmcw/P2VU0WOg8M7d?=
 =?us-ascii?Q?HtF1eQ5JcCa9C1xbRrPeBWUInrC+N0thuzsGzAeox4qhPP3NDZRUPJF+C0MG?=
 =?us-ascii?Q?u0k8gIjPn3Kp4XqLSDmCREg7LAHxHjVoilA4V5om3tPEZ6bL3YhxyrOxrxI6?=
 =?us-ascii?Q?IqS84+oNips8OUtUZCk5ycfnYPs7Xbw5NDgPcBq441WgeeGS6SVOXkZtvFSm?=
 =?us-ascii?Q?UhG2A1Hy5Y8Up6ieHoY0j2x4G4IfTijYVg6kKeycUZjCaWgVwDNApHbTrd8E?=
 =?us-ascii?Q?Ffx+eRzl+xZxS4GZi+8yj22fUj+NFYsyAJpE1/iTpczaBTtvt1nLT9HyqPAE?=
 =?us-ascii?Q?guyCv3I2Litg/eV2RWOXw03W/eAiTHJNT3VyKqHcnT7jvYYLVXVx0SrRCCPh?=
 =?us-ascii?Q?NAOmgJU+2nGjGI+/pfvA0WBYjdsiU4Ul63u75T6bnzc5UkT16rdzTrlJHkZh?=
 =?us-ascii?Q?TiFXwEKr4F5fLAqaQwVt3ZHf7eBfUE9/+OvGAP/3KVYGYRnAyznjiNCaLrJG?=
 =?us-ascii?Q?WZ/fxau+qAQejVlcJ/JmiuaXQNTfJitOiY3ZmJP38j8NAGT6WEC31OATPJN2?=
 =?us-ascii?Q?3TZ/yrGZbcJL5FGTMoZciwimPX/oXtCrICNHFoZYQDz1cFRr7JFCcITLtEn4?=
 =?us-ascii?Q?YhzcSOOFbBiBUWRQ0XxY/SPJFnS4QQS9CeO8wih7/wZDZe0pOAaBivbD8nyV?=
 =?us-ascii?Q?jIqnWRnrgAFIfE/bvPLwI0z6OsplQnL4AWAw9w5ZAjQOOcuirJZNQs7ql3+Z?=
 =?us-ascii?Q?oiUj+/BP0TM/qIPhVEDxayjKwOkAlUar2rdano36mfYwopntn2N+gNG1wegg?=
 =?us-ascii?Q?IGKrZVnoDKXpY4zzUhOACR6e/nVJNkDkFcKWvwSH9o1wHgRtnYPA10a6wByf?=
 =?us-ascii?Q?iO/AYIl/Cg5QqdPRMFaQTUHk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cUKJplwFsdag4nMSQlrzWQhNAFYBP9j8dOYU+KinwLjBzB0/spNwLoVJJ/6V?=
 =?us-ascii?Q?5O8+3j1Wy8g5i/ORLok9brv9svE/VjL253ZId+qbsU0qSPeSvd+ZCfR6n3lY?=
 =?us-ascii?Q?n6IJAFUy4mqBkjYX9dD1+GywzF4+7UP+VVzAR6pWb2ArBtwI2ktpu581sk0p?=
 =?us-ascii?Q?3rjo0M9zwALBsgSOXiMdqxr9tviW2Fj6PSfLs+SPLqZw51cLBNI3zzsoDupp?=
 =?us-ascii?Q?Znn79VdDUhN+23liRlOSKxtFvKcEHQQFDZ3qWlJ3oww9WCxMk9klRaTgjh8Z?=
 =?us-ascii?Q?Op2+BpMPAH7omsC2n8vALuVcKA2fF6pu2qg0XDJKf0Di6XbpbZu8GUQfkbP1?=
 =?us-ascii?Q?ZLn2sklkw/lY8mnc838zXH014E9O5ZK6KtRbWMJOrbFWyvIgexLebBKrQLDt?=
 =?us-ascii?Q?cLDYkedRliTt7k7zVk4CqIs6NZ/GOjmdi3uTu6iFbER/maiaSTMcKE/vFI/e?=
 =?us-ascii?Q?pKQHOVESpNMlBH3ZKYaG8RYI+AvWLqc/8++aZ/gR6K8uPWU/qGc2oQLu7ttS?=
 =?us-ascii?Q?/E24kgSovRKX/a8OSmq1+hf2AKyM64pvLdWeyHzxlmyOv8gyKWeQz+785FrF?=
 =?us-ascii?Q?WZnWQaPLhhWt4847GTpJLu1QitK6hHGkjUDPGSWgAK49Ct5ycsTJtT32+jIH?=
 =?us-ascii?Q?b43UmWabDIEtike1ek9wtRt32AgaskIKHfFHRS/Nhtqp6Xr6htEO8hHapWl4?=
 =?us-ascii?Q?yo2z3sLZne45tVImukVTBDrk1DlkI7FHsC9mWLg8Hlr0ljPsEN/GeB8VvBOR?=
 =?us-ascii?Q?YPAJ7PqI+qmbZ59MDsDgctbc0NjPdBZm8gm2u0W+vWjOHqtkdN0wlOmXaT0k?=
 =?us-ascii?Q?/Ej9cAGsx6wNjendyDTsqhxH7rS9GFZww1gisO+k3054XJHLrOvDFPi6IWZY?=
 =?us-ascii?Q?aA8R0UeKYVzja/W2UxuNUMS4Ud9oivXtHnurxGFpxErIckBNxgCkrrZ6twHZ?=
 =?us-ascii?Q?OtnlkQBmvmTTiF58rrpZwkNWYJ8CsE0/mSZ0tWgkNH7VR20bsNdo9BDd2YZ4?=
 =?us-ascii?Q?w+RPpfbkXMfAW0QDjWbwABIhIoAqHxG7PnEP80awfEpY26bw0QnCHNrtmAJH?=
 =?us-ascii?Q?JbLDT3Ou7mjIH0r1xMsaHO9Zd9n5D7xNGNfWI0Fx+klJeF0WNBHbtzbO0cz4?=
 =?us-ascii?Q?1QDoV1RQMP7pXwekT1cpoUPXVNbf9kf/AcnNc1Y4iwHQuufs2ySKlpckT5TJ?=
 =?us-ascii?Q?VvHlh69Pcg+HIHfW9dJhgcQqCgWWpofIbT8qTHIXXQf0TJP4zUe6YumndQej?=
 =?us-ascii?Q?3byd+y0fe8UFzdW3Vm9LfH7vN3px/PytdmufgNYfpAiUEjDAoaieDQ3lF0hU?=
 =?us-ascii?Q?/ZGpoDgf9c7efKJusvF58+9i0ZOpH5XHjz8MPtXWavPeAgwdsAE9XQhG+RMQ?=
 =?us-ascii?Q?7M5elX7nzlWQINbvIenzIrAKNkHcNuSfBTeqpK1nTlNLyfNTNr7/jF7pHCf3?=
 =?us-ascii?Q?WSR1aD5FQidGtgk2fUf9YjetAQcXCjSMYmFKkNwhgsYYN4CBSQ7DqSoIa+9/?=
 =?us-ascii?Q?hJ15gLMxdYkXulLN29FMXBERIvKXiYDd1ix8uUi+gL8MiBQgRahSc2KDylIX?=
 =?us-ascii?Q?rDTk0kf9Y7zqH6MWB3UPi4pGHrYu7+MK3v6ty9Rx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfec3f1-a7b2-4ee1-6050-08dceef4416a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:40:01.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UElgjkNOxvI/AQ5ij0PJkVph1z9S02wjRyDLJcJAKvQ9UW9+P+GLqGHv74hsdVtGvOnZXMNGs5YSoEO8e+aSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:27 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > A dynamic capacity device (DCD) sends events to signal the host for
> > changes in the availability of Dynamic Capacity (DC) memory.  These
> > events contain extents describing a DPA range and meta data for memory
> > to be added or removed.  Events may be sent from the device at any time.
> > 
> > Three types of events can be signaled, Add, Release, and Force Release.
> > 
> > On add, the host may accept or reject the memory being offered.  If no
> > region exists, or the extent is invalid, the extent should be rejected.
> > Add extent events may be grouped by a 'more' bit which indicates those
> > extents should be processed as a group.
> > 
> > On remove, the host can delay the response until the host is safely not
> > using the memory.  If no region exists the release can be sent
> > immediately.  The host may also release extents (or partial extents) at
> > any time.  Thus the 'more' bit grouping of release events is of less
> > value and can be ignored in favor of sending multiple release capacity
> > responses for groups of release events.
> 
> True today - I think that would be an error for shared extents
> though as they need to be released in one go.  We can deal with
> that when it matters.  
> 
> 
> Mind you patch seems to try to handle more bit anyway, so maybe just
> remove that discussion from this description?

It only handles more bit response on ADD because on RELEASE the count is always
1.


+       if (cxl_send_dc_response(mds, CXL_MBOX_OP_RELEASE_DC, &extent_list, 1)) 
+               dev_dbg(dev, "Failed to release [range 0x%016llx-0x%016llx]\n", 
+                       range->start, range->end);                              


For shared; a flag will need to be added to the extents and additional logic to
group these extents for checking use etc.  

I agree, we need to handle that later on and get this basic support in.  For
now I think my comments are correct WRT the sending of release responses.

> > 
> > Simplify extent tracking with the following restrictions.
> > 
> > 	1) Flag for removal any extent which overlaps a requested
> > 	   release range.
> > 	2) Refuse the offer of extents which overlap already accepted
> > 	   memory ranges.
> > 	3) Accept again a range which has already been accepted by the
> > 	   host.  Eating duplicates serves three purposes.  First, this
> > 	   simplifies the code if the device should get out of sync with
> > 	   the host. 
> 
> Maybe scream about this a little.  AFAIK that happening is a device
> bug.

Agreed but because of the 2nd purpose this is difficult to scream about because
this situation can come up in normal operation.  Here is the scenario:

1) Device has 2 DCD partitions active, A and B
2) Host crashes
3) Region X is created on A
4) Region Y is created on B
5) Region Y scans for extents
6) Region X surfaces a new extent while Y is scanning
7) Gen number changes due to new extent in X
8) Region Y rescans for existing extents and sees duplicates.

These duplicates need to be ignored without signaling an error.

> 
> > And it should be safe to acknowledge the extent
> > 	   again.  Second, this simplifies the code to process existing
> > 	   extents if the extent list should change while the extent
> > 	   list is being read.

This is the 'normal' case.

> > Third, duplicates for a given region
> > 	   which are seen during a race between the hardware surfacing
> > 	   an extent and the cxl dax driver scanning for existing
> > 	   extents will be ignored.
> 
> This last one is a good justification.

I think the second justification is actually better than this one.  Regardless
this makes everything ok and should work.

> 
> > 
> > 	   NOTE: Processing existing extents is done in a later patch.
> > 
> > Management of the region extent devices must be synchronized with
> > potential uses of the memory within the DAX layer.  Create region extent
> > devices as children of the cxl_dax_region device such that the DAX
> > region driver can co-drive them and synchronize with the DAX layer.
> > Synchronization and management is handled in a subsequent patch.
> > 
> > Tag support within the DAX layer is not yet supported.  To maintain
> > compatibility legacy DAX/region processing only tags with a value of 0
> > are allowed.  This defines existing DAX devices as having a 0 tag which
> > makes the most logical sense as a default.
> > 
> > Process DCD events and create region devices.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> A couple of minor comments from me.

I do appreciate the review.


[snip]

> >  
> > +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> > +				struct xarray *extent_array, int cnt)
> > +{
> > +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > +	struct cxl_mbox_dc_response *p;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	struct cxl_extent *extent;
> > +	unsigned long index;
> > +	u32 pl_index;
> > +	int rc;
> > +
> > +	size_t pl_size = struct_size(p, extent_list, cnt);
> > +	u32 max_extents = cnt;
> > +
> > +	/* May have to use more bit on response. */
> 
> I thought you argued in the patch description that it didn't matter if you
> didn't set it?

Only on RELEASE responses.  ADD responses might need it depending on the
payload size and number of extents being added.

Sorry that was not clear.

> 
> > +	if (pl_size > cxl_mbox->payload_size) {
> > +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
> > +			      sizeof(struct updated_extent_list);
> > +		pl_size = struct_size(p, extent_list, max_extents);
> > +	}
> > +
> > +	struct cxl_mbox_dc_response *response __free(kfree) =
> > +						kzalloc(pl_size, GFP_KERNEL);
> > +	if (!response)
> > +		return -ENOMEM;
> > +
> > +	pl_index = 0;
> > +	xa_for_each(extent_array, index, extent) {
> > +
> > +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> > +		response->extent_list[pl_index].length = extent->length;
> > +		pl_index++;
> > +		response->extent_list_size = cpu_to_le32(pl_index);
> > +
> > +		if (pl_index == max_extents) {
> > +			mbox_cmd = (struct cxl_mbox_cmd) {
> > +				.opcode = opcode,
> > +				.size_in = struct_size(response, extent_list,
> > +						       pl_index),
> > +				.payload_in = response,
> > +			};
> > +
> > +			response->flags = 0;
> > +			if (pl_index < cnt)
> > +				response->flags &= CXL_DCD_EVENT_MORE;
> Covered in other branch of thread.

Yep.


[snip]

> 
> >  
> > +/* See CXL 3.0 8.2.9.2.1.5 */
> 
> Maybe update to 3.1? Otherwise patch reviewer needs to open two 
> spec versions!  In 3.1 it is 8.2.9.2.1.6

Yep missed this one.  Thanks,
Ira

