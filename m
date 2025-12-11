Return-Path: <linux-btrfs+bounces-19659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFCCB6266
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 15:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDED03012DD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4742D23A3;
	Thu, 11 Dec 2025 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJBSkOBC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835B2C3261;
	Thu, 11 Dec 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461907; cv=fail; b=slG4lltiXwRm2AgnaCi/4hsl27ScxIJsBKvnLJWFdPxaHUz91oZ8tZCOilMbCmTyonZgf6Tl2o0Gp1/JagzTrYUa/Xl5b8jjEBSP+pkVE1kspZ661/O/q5CitbVjEAFfJC8KAsGCnor1NSojTnz6SOnpMqZz5i6IrSqyfYAAZnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461907; c=relaxed/simple;
	bh=sjrcMHNLvWQaIxAeLWJdL3sr6/El/si1BMGs92bnGFk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Sv/mtXpUQzk0/Fplxh3aWifM54jNGEGprNc7PaEJ5SNormiEGpzqs1yIo1UYbCpGQfjcmyM4Cs/cAGPaAig8QgkCpriCB71QH3dXYMhYUadi9pp8UjaE6lBd0M2UEDozCHUNRLGOyQ0eDjGwI0YZv695iLb/QRdSsXOcxAAyZnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJBSkOBC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765461897; x=1796997897;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=sjrcMHNLvWQaIxAeLWJdL3sr6/El/si1BMGs92bnGFk=;
  b=AJBSkOBC1f9FEWVhPNJlEmiUSay7C7d+AyxUWXZjPZXN5OcdbGLo7ayH
   97M0fvmjUszt5/cjtrLK8Q7Y5jiUd3cZaVbOPB+793zG04mtAiuwD11cp
   z3jMDxX+BjVjrAdccPj475eUwbPBDQ/BF/BXo8gmIewzegzm6E6JndjXs
   pzFxT/O+35SXOLAkXDShfCz8YEuHnMAaEIcFUyud0rF3xJz/vL8VYlAnU
   y57xLoTf6QhNKXryO94yiy6vL5G+0DRwUKfhUp7PP5OjV9WNRyYcltSpS
   3nkvgYMVMGQwU+ipjEXBAp+2gXMjT5qAv8zTIwPWSNBJ4+0GC9KZMuqtX
   g==;
X-CSE-ConnectionGUID: ECvvj1xDR7adEuq4Gwhgbw==
X-CSE-MsgGUID: klH/euAUSuOIQrcKv7wP5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="70024188"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="70024188"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:04:53 -0800
X-CSE-ConnectionGUID: uy8hXT1zQNSq8qyC8vfpmw==
X-CSE-MsgGUID: PXoojlneR6Kf91ixBjJRBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="227460073"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:04:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 06:04:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 06:04:51 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 06:03:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHpUO1aaM8PJWkdNuXTrEDUcWI8Rtw/T2HQpadAJTerMcsK5jQyYf/8t7pI2fPvL2FepuW1q6ECnl33KXtg3opiYd+04EMPf7uzN2HM9tnHp0YLHUL+67nxRdVSvfxqtMfMhwL0Ee5ifSleF6RcqNsJtt8w1aqE6+3SUa8dVRSwXOnYIfqjSkrtSZQnPh40Ml94nMpiqP8If6DaoUvA4ngFpV9ekD6pP/JuSBaXlpQqgvLBIgBdRnprYfvJgZsqkBJ1EwltrobJ64KITKi6El1i8cqimstNr6qWSlNlfdlpQ88I4Wcq+VeFd9xFb1JwaEqQXXm3iOKpwiGMNzqa7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ/UPvonfqO0OTjyTFFVuPSA6Uo0mAUrXm3tM/VmMok=;
 b=ThF0tNT/4xJ4auXbDKCCBMzQhS2M4zWr8CvxF7JpejyK2MHbTQxWID+oPfDbRd/pOW/ivVLpNYaV2K6dl2GC2cP91E03sloOqa5Xraq1CQvGHIuqryypW4nqM0P9OvQDzw64qSkOh/KmAH1r2c1kPci0bIaH6OMuNHHYbrbXz8zNRuCa2P+hZ0zsGvYtOpk6tArkVC7OKSWxumX69oF9hC3mxh7Z0gEHQz4unW4G2RsVFO9ZjB7h9jC0twqPo4sotliAvCX6ryy2wW5v5u2Ct48tzL2+ZDX5Tk8qCDrxGHUeN/tVPaB52XDIPqBWSRPz9A5ArmpvXy+Q3L18WoRblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 14:03:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 14:03:54 +0000
Date: Thu, 11 Dec 2025 22:03:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  4591c3ef75:  fsmark.files_per_sec 6.3%
 regression
Message-ID: <202512112131.742ab6d2-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0062.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: ac74cc46-1cf9-4806-0cf3-08de38be1e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mGnOSIK7F0PO/QVBs30qHaY2AfFMExyvLhIFJjNvURf4IasLO9fhWHEBVc?=
 =?iso-8859-1?Q?tTFdL0NXonotOPcV0qlkXnbpvU7thddH4S8nhQNjY3ydP2XgBn4Vr52hh7?=
 =?iso-8859-1?Q?W7rrpFObaq9+3WqY1PZZZyVCZut2WQlTbzv+DdF/9ujmt5Qbk279shN9Iq?=
 =?iso-8859-1?Q?Xuac2ev2dKzNTeHLP+oWnoJcPnOfFZba0Je8LjSH1TP9NUYlZ3o6kCFhYA?=
 =?iso-8859-1?Q?OQonpJ+bxEKJ9U3M4yMbvYhOz8cAUYXNZBmkIgMymjz5pQGoSNynUlyEjb?=
 =?iso-8859-1?Q?Yw4hvEE9qv8iC9ufOKQ0SalVgMARlwD1UCkxJBYCyixQUwJHkKh3IWnpu9?=
 =?iso-8859-1?Q?lQr0ZVLCRDGuk8pI6u8F4sDkVf8wRl2t91HQoqGGTX28gg6Jlz5VUN+0qY?=
 =?iso-8859-1?Q?fmnb2WAD1GydpDc9MgRQeNKGfEhaW2n+Zu9BiumPR/87LvJF4Aw5mV6pic?=
 =?iso-8859-1?Q?30TZ2b/meLEcBp1UeN68Re3rd5RtS/e6G5zPFGTp+N/OTmMK8fEY6Zu8MH?=
 =?iso-8859-1?Q?h3NQ5jceaX02bGwEiVGl4SDW9vZF/uA6Whrur9ai/PcBbQX4iIyi3IE0YD?=
 =?iso-8859-1?Q?MWlNk7Vz/s810a7lrGSeS+Jy4OW6+7o2uvCJMznt0qUwY+dJoc9hUXovzn?=
 =?iso-8859-1?Q?vwbBwvKycFqxCbAqZogyRSGybs7PGmPRw1Wf68WGJEeFjaluV3HTXg2L1s?=
 =?iso-8859-1?Q?p7C8OKhVQqebPBnbpdBzg/7H7uxayUalboxndDtF4i/BCqTnBO+eld09iI?=
 =?iso-8859-1?Q?6FWh9NWfwTrD32Cdja3ZuxecAxkhShO1wFH5VM7J62K/hn6ltO5BygLYJk?=
 =?iso-8859-1?Q?ixq8lfwPqnj1jzjcwnJHN8y8Yv27l3whtbJXRfZ4sZCtrUUFvZVtn76L/B?=
 =?iso-8859-1?Q?mIEbmqzyl2wVepzVM3Yk8jKrvIxNwgeNZSx4i9OiVcrBL/Hb/MKjnDHrEz?=
 =?iso-8859-1?Q?E+8gB04qWs2yQbhq6dZQuEXR+QYqlwxALxJqQdx/sGnP6jYXDnEQbFHWTP?=
 =?iso-8859-1?Q?GdM/WM9cBOpNJCRY4Ej+Ldw+uujFPthJaHKk1bgk/DbnZn9g1bF2AKs0Fd?=
 =?iso-8859-1?Q?2FA2BR6Scn7/iKwkHPRfkLP0PBjXc+A4w926slL8Z+hiM40tPHVytu/EJg?=
 =?iso-8859-1?Q?1QyRzW7KxhqER01WSg3pUXnE3t2eTYkwgvONzK9LemU96LJHkM0YTqpmJE?=
 =?iso-8859-1?Q?9kD22g2arD1DwftEhKzbZKXFE83B308M28DhkJySQ8NoZ2lHzkP8WjJAwi?=
 =?iso-8859-1?Q?OHImRMTGfhQXKRWb4u42NQsW4f9BaZJpm55/SVyapqjJ+9/gKRtTs2cbuD?=
 =?iso-8859-1?Q?kJmc0cjl/TMKFVNZEk9UAlvtQgr9s9ilDlL7HuZf25uHyAUb/DfKG8aD97?=
 =?iso-8859-1?Q?a2qrA5J/fEz1ss0ZuGxF0NmIlu5OaLW0R2o3g3K3iBaTj3Jf/fL0EI9yxg?=
 =?iso-8859-1?Q?vW84pJLXtkP0m2cYLxClOBlUfQUltgUpH4JLIEL2n6f5M3jejBXHCzHtet?=
 =?iso-8859-1?Q?4ou8EHCAv3qAv9cmrNehO1IthFZCPM2vHYyQMCdJsKwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Udip5kM3Y3xSe2CASncCgsaUZ4Zv8e+SxJe+h+lrlxB1BKrJlL7kVoBgms?=
 =?iso-8859-1?Q?E0vVP0Uqzeqn/85pHfPNrTs6+R7sQeSzBH35+LqQrXxJIxuvLaFLyH3P5e?=
 =?iso-8859-1?Q?v+xwsm/gPMYP8SLdKZ/fTffzcoN4tVczQi3fsowkQpudmO9EPhFzYHEnWk?=
 =?iso-8859-1?Q?UZv5CuKlQchtT/vpPbMwj+/eBmk53HbeTbbYt0UwLwZl51pVYZBodDnba3?=
 =?iso-8859-1?Q?yDzvKOI2reUTPUxNfLkPgYpQRqV8DIGYqEZkO+8L7T/TxQ/uf0Ha6L7/gt?=
 =?iso-8859-1?Q?AUPNnndnzNU1aw09+xQ45KquhNKanCVEdvSa7DzJWRT56Izkqh8QuMckkH?=
 =?iso-8859-1?Q?xhySL8lt6IQzSYrO0b8GFgdDaY9VVuuBoHQRS7yrWHyEDkvOSof3W8dawb?=
 =?iso-8859-1?Q?oQsYBLZQnFshmcHnMBGagBei7lR0WAJKX1rGtlf1NKPYQJRYN5dHodBg/6?=
 =?iso-8859-1?Q?Cv2RE+0kkjEHlN8UCu638GZSwQ2ykgVclACCR54EjZvZjhzIWi/7khuAl6?=
 =?iso-8859-1?Q?J0/3FxSxrWdKnWzleDBEFGjcevgnmNJhdL1SAveY46TsDkEN+ayVjOv3/y?=
 =?iso-8859-1?Q?UZRGKcuTkf1oJGLWJJIb/ScAWiFqL6e95kaiiF/D077isqT38G/qVSXcPG?=
 =?iso-8859-1?Q?oFJuaXXD9pJhr3X97vSZx5tuJ0iKcngundK7jNd7x06w+MLPjnmBAaP6PV?=
 =?iso-8859-1?Q?w4n45VKWvio6T43R/p5NXZzrtl3Zqu1Ive+n90hOVlFHcgogOW07mzBrPH?=
 =?iso-8859-1?Q?urm7YsQ7An1KgCX6CQcSne73VXKdJyFkaiCCpfN2FVyTQwMgy72l941kWr?=
 =?iso-8859-1?Q?xHLc/jcqBSoFBJK4WYr9pFtEdJX87pCJBnRHk7//VbgNPfOJ/W0exa09Ot?=
 =?iso-8859-1?Q?sBu1hjG3pEMs7illiAYf+wLj0wtJ7PJNRV4Jcsrs+7S2rMaaEwlCmZtSqp?=
 =?iso-8859-1?Q?frPn04qvFFCF6nM/y3FlVEBJ/u58FViX61OxDsd5q6RNqJPcNY0nYm4Ps6?=
 =?iso-8859-1?Q?X/9SWOIlFeIu3MFWTFIeOQVdbRHSbSbjcrsj9jfJ0Iimbx/yucn6Cidawu?=
 =?iso-8859-1?Q?w1OT66P0wQPNvB0iWfA1ERoQGsE3K8Nse9cP2p6/xtj3xNACstxMS1jDqn?=
 =?iso-8859-1?Q?pxOOiddRkLcwwr4aMkM1jCdPZ14aMMP6Hit9GtPMhEZJK7H72OxKi2oER4?=
 =?iso-8859-1?Q?lIweGKmblwoTxVnYbKudHXkypT3RSL3ifPzabxIN3Qz3n8e8YZA6pD4Pem?=
 =?iso-8859-1?Q?9iBII378CvKhw9RuCRYEHtEy9sXlZfFRYJi/g/Jnlspg6vazEHw9BkLeTo?=
 =?iso-8859-1?Q?7ydoXBsxwzmzxTG9jzOYPD9uTRFsKL0qOiW7vd3cGjKev2JDP87t8hyzZQ?=
 =?iso-8859-1?Q?ywZi7nGjvzWdG6cYpEFVNdwlv1VmFz10lzezLzjHxf9fOUcaYAyuBIzJPa?=
 =?iso-8859-1?Q?pgt/Y2WEM8bIYFSTx5XuJvmsHSxr0LHMsDfUvUaW0RzXsKJtYovTbHyfkn?=
 =?iso-8859-1?Q?lg69XwIXUwpgNffO5i8MGuZ8pjGrdb7QgYheAP99C0rt/z3889B5/HdN7D?=
 =?iso-8859-1?Q?AY79sEVbiJ6vdfh+guEqn9XQm3Sqvw0cWH7M+OMyydjwxlitaWZ1Z77p8Q?=
 =?iso-8859-1?Q?8xhns2GzBhU15m7dBE/fHlWKXCALXRtko/3TbCmsvUMPWjuS139zeoxg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac74cc46-1cf9-4806-0cf3-08de38be1e32
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 14:03:54.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3+NR7A38tEl8ex6jxz633vA+mAAJi0RR4K/E5gdNYfYUTMN0E5vcI7yyxuKxTLkO9Y5cDSmdeBvbQYodV0OnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com



Hello,

we reported
"[linux-next:master] [btrfs]  4591c3ef75:  fsmark.files_per_sec 6.0% regression"
in
https://lore.kernel.org/all/202512011418.cce5b747-lkp@intel.com/

since now the commit merged into mainline, we rebuild the kernel and rerun
the tests, still observe similar regression. so report again FYI.


kernel test robot noticed a 6.3% regression of fsmark.files_per_sec on:


commit: 4591c3ef751d861d7dd95ff4d2aadb1b5e95854e ("btrfs: make sure all btrfs_bio::end_io are called in task context")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      67a454e6b1c604555c04501c77b7fedc5d98a779]
[still regression on linux-next/master 6987d58a9cbc5bd57c983baa514474a86c945d56]

testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1BRD_32G
	fs: btrfs
	filesize: 4K
	test_size: 4G
	sync_method: fsyncBeforeClose
	nr_files_per_directory: 1fpd
	cpufreq_governor: performance


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512112131.742ab6d2-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251211/202512112131.742ab6d2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-14/performance/1BRD_32G/4K/btrfs/1x/x86_64-rhel-9.4/1fpd/1t/debian-13-x86_64-20250902.cgz/fsyncBeforeClose/lkp-icl-2sp9/4G/fsmark

commit: 
  81cea6cd70 ("btrfs: remove btrfs_bio::fs_info by extracting it from btrfs_bio::inode")
  4591c3ef75 ("btrfs: make sure all btrfs_bio::end_io are called in task context")

81cea6cd7041ebd4 4591c3ef751d861d7dd95ff4d2a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2828763          +418.5%   14668154        cpuidle..usage
      1.86            +8.6%       2.02        iostat.cpu.system
      0.03 ±  2%      +0.1        0.09        mpstat.cpu.all.irq%
     90664 ±  4%    +262.7%     328881        numa-meminfo.node1.Shmem
     22669 ±  4%    +262.7%      82228        numa-vmstat.node1.nr_shmem
    673.80 ±  5%    +299.3%       2690        perf-c2c.HITM.local
   1757383           +13.5%    1994200        meminfo.Active
   1757367           +13.5%    1994184        meminfo.Active(anon)
     98129          +241.6%     335177        meminfo.Shmem
   1070185            -6.0%    1005903        vmstat.io.bo
     35470          +444.4%     193106        vmstat.system.cs
     25198          +318.6%     105494        vmstat.system.in
      7138 ±  7%     -42.0%       4139 ±  5%  sched_debug.cpu.avg_idle.min
     37085          +413.8%     190558        sched_debug.cpu.nr_switches.avg
    238664 ± 25%    +364.5%    1108615 ±  8%  sched_debug.cpu.nr_switches.max
     55514 ± 10%    +401.0%     278118 ±  5%  sched_debug.cpu.nr_switches.stddev
     94.80           +15.0%     109.00        turbostat.Avg_MHz
      2.63            +0.4        3.03        turbostat.Busy%
   3435872          +349.5%   15445261        turbostat.IRQ
    173216           +21.7%     210726        turbostat.NMI
    439722           +13.4%     498517        proc-vmstat.nr_active_anon
   1752675            +3.4%    1812382        proc-vmstat.nr_file_pages
     19020            +8.8%      20694        proc-vmstat.nr_mapped
     24539          +241.4%      83766        proc-vmstat.nr_shmem
    439722           +13.4%     498517        proc-vmstat.nr_zone_active_anon
    425455            +6.4%     452538 ±  2%  proc-vmstat.pgfault
  14708193            +1.8%   14974669        fsmark.app_overhead
      7621            -6.3%       7142        fsmark.files_per_sec
    134.74            +6.7%     143.70        fsmark.time.elapsed_time
    134.74            +6.7%     143.70        fsmark.time.elapsed_time.max
      9444 ±  3%     -21.1%       7454 ±  6%  fsmark.time.involuntary_context_switches
     86.90            -2.8%      84.50        fsmark.time.percent_of_cpu_this_job_got
   1080769          +184.3%    3072675        fsmark.time.voluntary_context_switches
      0.00 ±  9%     -28.6%       0.00        perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.00 ±  9%     -28.6%       0.00        perf-sched.total_sch_delay.average.ms
      7.22 ±  4%     -79.6%       1.47 ±  4%  perf-sched.total_wait_and_delay.average.ms
     90866          +394.5%     449314        perf-sched.total_wait_and_delay.count.ms
      7.21 ±  4%     -79.6%       1.47 ±  4%  perf-sched.total_wait_time.average.ms
      7.22 ±  4%     -79.6%       1.47 ±  4%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     90866          +394.5%     449314        perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      7.21 ±  4%     -79.6%       1.47 ±  4%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      1.68            -6.0%       1.58 ±  2%  perf-stat.i.MPKI
 1.589e+09            +6.4%  1.691e+09        perf-stat.i.branch-instructions
      1.24            -0.0        1.19        perf-stat.i.branch-miss-rate%
  31053616            -2.8%   30172121        perf-stat.i.branch-misses
     21.19            -3.0       18.21        perf-stat.i.cache-miss-rate%
  13079992            -2.1%   12799191        perf-stat.i.cache-misses
  62282693           +14.7%   71436576        perf-stat.i.cache-references
     36169          +444.3%     196862        perf-stat.i.context-switches
      0.68           +18.8%       0.81        perf-stat.i.cpi
 6.162e+09           +20.9%  7.452e+09        perf-stat.i.cpu-cycles
     87.89           +12.4%      98.75        perf-stat.i.cpu-migrations
    475.41           +23.8%     588.40        perf-stat.i.cycles-between-cache-misses
   8.7e+09            +4.5%  9.091e+09        perf-stat.i.instructions
      1.51           -17.0%       1.26        perf-stat.i.ipc
      1.50            -6.3%       1.41        perf-stat.overall.MPKI
      1.96            -0.2        1.79        perf-stat.overall.branch-miss-rate%
     21.00            -3.1       17.92        perf-stat.overall.cache-miss-rate%
      0.71           +15.7%       0.82        perf-stat.overall.cpi
    471.75           +23.6%     582.89        perf-stat.overall.cycles-between-cache-misses
      1.41           -13.6%       1.22        perf-stat.overall.ipc
 1.578e+09            +6.5%   1.68e+09        perf-stat.ps.branch-instructions
  30910990            -2.8%   30049941        perf-stat.ps.branch-misses
  61841259           +14.7%   70959972        perf-stat.ps.cache-references
     35905          +444.5%     195504        perf-stat.ps.context-switches
 6.125e+09           +21.0%  7.409e+09        perf-stat.ps.cpu-cycles
     87.25           +12.4%      98.07        perf-stat.ps.cpu-migrations
 8.641e+09            +4.5%  9.033e+09        perf-stat.ps.instructions
 1.174e+12           +11.5%  1.309e+12        perf-stat.total.instructions
     57.32            -8.9       48.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     57.33            -8.8       48.48        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     32.14 ±  2%      -5.1       27.05        perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.14 ±  2%      -5.1       27.05        perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.12 ±  2%      -5.1       27.03        perf-profile.calltrace.cycles-pp.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.48 ±  2%      -3.2       20.24 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
     23.48 ±  2%      -3.2       20.24 ±  3%  perf-profile.calltrace.cycles-pp.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
     23.48 ±  2%      -3.2       20.24 ±  3%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
     23.48 ±  2%      -3.2       20.23 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
     23.47 ±  2%      -3.2       20.23 ±  3%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty
     23.48 ±  2%      -3.2       20.23 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work
     23.47 ±  2%      -3.2       20.23 ±  3%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
     23.47 ±  2%      -3.2       20.23 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
     22.30 ±  4%      -3.1       19.16 ±  4%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.29 ±  4%      -3.1       19.16 ±  4%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.43 ±  4%      -3.0       18.46 ±  5%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.vfs_write.ksys_write
     21.43 ±  4%      -3.0       18.46 ±  5%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.vfs_write.ksys_write.do_syscall_64
     21.43 ±  4%      -3.0       18.46 ±  5%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.36 ±  4%      -2.9       18.41 ±  5%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.vfs_write
     21.36 ±  4%      -2.9       18.41 ±  5%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
     17.88            -2.9       14.98 ±  2%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
     16.09            -2.8       13.24 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_submit_bbio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     16.08            -2.8       13.24 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
     20.67 ±  4%      -2.8       17.86 ±  4%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
     17.21 ±  2%      -2.8       14.43 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
     17.04 ±  2%      -2.8       14.28 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
     17.09 ±  2%      -2.8       14.33 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
     17.07 ±  2%      -2.8       14.32 ±  2%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
     20.14 ±  2%      -2.7       17.49        perf-profile.calltrace.cycles-pp.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
     17.08 ±  5%      -2.3       14.76 ±  5%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
     16.37 ±  4%      -2.2       14.17 ±  5%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      9.16 ±  3%      -1.9        7.30 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      9.14 ±  3%      -1.8        7.29 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync
      9.58 ±  2%      -1.8        7.77 ±  4%  perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages
      7.54 ±  2%      -1.7        5.88 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
     31.37 ±  2%      -1.6       29.78 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.75 ±  3%      -1.5        6.20 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
      7.03 ±  5%      -1.4        5.59 ±  3%  perf-profile.calltrace.cycles-pp.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio
      7.10 ±  3%      -1.4        5.69 ±  2%  perf-profile.calltrace.cycles-pp.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      4.83 ±  3%      -1.4        3.44 ± 33%  perf-profile.calltrace.cycles-pp.brd_rw_bvec.brd_submit_bio.__submit_bio.__submit_bio_noacct.btrfs_submit_bio
      5.91 ±  2%      -1.4        4.54 ±  2%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio
      5.93 ±  2%      -1.4        4.56 ±  2%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      6.11 ±  2%      -1.3        4.79 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages
      6.45 ±  3%      -1.3        5.19 ±  2%  perf-profile.calltrace.cycles-pp.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
      4.85 ±  3%      -1.0        3.84 ±  2%  perf-profile.calltrace.cycles-pp.brd_submit_bio.__submit_bio.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk
      4.31 ±  4%      -1.0        3.29 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      3.83 ±  3%      -0.8        3.06 ±  2%  perf-profile.calltrace.cycles-pp.mkdir
      3.80 ±  3%      -0.8        3.03 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      3.80 ±  3%      -0.8        3.03 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mkdir
      3.79 ±  3%      -0.8        3.02 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      3.73 ±  3%      -0.8        2.98 ±  2%  perf-profile.calltrace.cycles-pp.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      3.86 ±  3%      -0.7        3.15 ±  2%  perf-profile.calltrace.cycles-pp.log_csums.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent
      3.85 ±  3%      -0.7        3.14 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.log_csums.copy_items.copy_inode_items_to_log.btrfs_log_inode
      3.48 ±  4%      -0.7        2.82 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
      3.48 ±  4%      -0.7        2.82 ±  3%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread
      3.47 ±  3%      -0.6        2.83 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.copy_items.copy_inode_items_to_log
      3.46 ±  3%      -0.6        2.82 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.copy_items
      3.33 ±  3%      -0.6        2.71 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums
      3.32 ±  3%      -0.6        2.70 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks
      2.73 ±  4%      -0.6        2.12 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
      2.96 ±  3%      -0.6        2.37 ±  2%  perf-profile.calltrace.cycles-pp.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.90 ±  3%      -0.6        2.33 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_mkdir.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      1.89 ±  2%      -0.6        1.32 ±  2%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      1.86 ±  2%      -0.6        1.30 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file.do_fsync.__x64_sys_fsync
      1.86 ±  2%      -0.6        1.30 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file.do_fsync
      1.84 ±  2%      -0.6        1.28 ±  3%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file
      2.70 ±  3%      -0.6        2.15 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_create_common.btrfs_mkdir.vfs_mkdir.do_mkdirat.__x64_sys_mkdir
      1.82 ±  2%      -0.6        1.27 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops
      1.81 ±  2%      -0.6        1.26 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range
      1.80 ±  2%      -0.5        1.25 ±  3%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      2.34 ±  4%      -0.5        1.80 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.33 ±  3%      -0.5        1.79 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.25 ±  4%      -0.5        1.73 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.24 ±  4%      -0.5        1.72 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.41 ±  3%      -0.5        1.89 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.btrfs_mkdir.vfs_mkdir.do_mkdirat
      1.70 ±  2%      -0.5        1.18 ±  2%  perf-profile.calltrace.cycles-pp.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
      1.96 ±  4%      -0.5        1.49 ±  2%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.75 ±  2%      -0.4        2.30 ±  3%  perf-profile.calltrace.cycles-pp.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      1.87 ±  3%      -0.4        1.43 ±  2%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.84 ±  4%      -0.4        1.44        perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent
      1.78 ±  3%      -0.4        1.40 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.btrfs_mkdir.vfs_mkdir
      1.60 ±  8%      -0.4        1.22 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread
      1.60 ±  8%      -0.4        1.22 ±  5%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      1.73 ±  3%      -0.4        1.35 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.btrfs_mkdir
      1.70 ±  4%      -0.4        1.33        perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log.btrfs_log_inode
      1.54 ±  3%      -0.3        1.20 ±  3%  perf-profile.calltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common
      0.89 ±  3%      -0.3        0.55 ±  3%  perf-profile.calltrace.cycles-pp.extent_writepage_io.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages
      1.53 ±  3%      -0.3        1.19 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode
      1.49 ±  5%      -0.3        1.15 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work.worker_thread.kthread
      1.48 ±  7%      -0.3        1.16 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      2.49 ±  4%      -0.3        2.18 ±  4%  perf-profile.calltrace.cycles-pp.io_serial_out.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      1.44 ±  4%      -0.3        1.13 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log
      1.44 ±  4%      -0.3        1.13 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items
      1.30 ±  4%      -0.3        1.01 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_create_common.lookup_open.open_last_lookups.path_openat.do_filp_open
      1.88 ±  2%      -0.3        1.59 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread
      1.35 ±  4%      -0.3        1.07 ±  3%  perf-profile.calltrace.cycles-pp.log_all_new_ancestors.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
      1.79 ±  3%      -0.3        1.51 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_get_32.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      1.23 ±  4%      -0.3        0.96 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.log_all_new_ancestors.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      1.33 ±  3%      -0.3        1.07 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum
      1.23 ±  7%      -0.3        0.97 ±  7%  perf-profile.calltrace.cycles-pp.run_delayed_data_ref.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space
      1.12 ±  3%      -0.2        0.88 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.lookup_open.open_last_lookups.path_openat
      1.05 ±  4%      -0.2        0.81 ±  3%  perf-profile.calltrace.cycles-pp.copy_inode_items_to_log.btrfs_log_inode.log_all_new_ancestors.btrfs_log_inode_parent.btrfs_log_dentry_safe
      0.99 ± 16%      -0.2        0.76 ±  5%  perf-profile.calltrace.cycles-pp.__pi_memcpy.copy_extent_buffer_full.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot
      1.08 ±  4%      -0.2        0.85 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      0.69 ±  7%      -0.2        0.46 ± 50%  perf-profile.calltrace.cycles-pp.copy_one_range.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.66 ±  4%      -0.2        0.43 ± 50%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      0.94 ±  6%      -0.2        0.74 ±  2%  perf-profile.calltrace.cycles-pp.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      0.84 ±  3%      -0.2        0.64 ±  3%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      0.91 ±  4%      -0.2        0.72 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      0.98 ±  6%      -0.2        0.79 ±  5%  perf-profile.calltrace.cycles-pp.copy_extent_buffer_full.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum
      0.70 ±  4%      -0.2        0.52 ± 33%  perf-profile.calltrace.cycles-pp.filename_create.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.85 ±  6%      -0.2        0.67 ±  3%  perf-profile.calltrace.cycles-pp.__memmove.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      0.76 ±  5%      -0.2        0.59 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_insert_delayed_item.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work.worker_thread
      0.79 ±  3%      -0.2        0.62 ±  4%  perf-profile.calltrace.cycles-pp.writepage_delalloc.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages
      0.98 ±  2%      -0.2        0.81 ±  4%  perf-profile.calltrace.cycles-pp.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      0.94 ±  2%      -0.2        0.78 ±  4%  perf-profile.calltrace.cycles-pp.chksum_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio
      0.93 ±  3%      -0.2        0.77 ±  4%  perf-profile.calltrace.cycles-pp.crc32c_arch.chksum_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk
      0.91 ±  3%      -0.2        0.75 ±  4%  perf-profile.calltrace.cycles-pp.crc32c_x86_3way.crc32c_arch.chksum_update.csum_tree_block.btree_csum_one_bio
      0.82 ±  5%      -0.2        0.66 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ±  5%      -0.2        0.65 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
      0.88 ±  4%      -0.1        0.75 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_get_32.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio
      0.84 ±  3%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space
      0.86 ±  2%      -0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      0.84 ±  2%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction
      0.85 ±  2%      -0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space
      0.84 ±  2%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction
      0.82 ±  4%      -0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      0.97 ±  3%      -0.1        0.85 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      0.80 ±  4%      -0.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space
      0.78 ±  4%      -0.1        0.66 ±  4%  perf-profile.calltrace.cycles-pp.__btrfs_add_free_space.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space
      0.72 ±  3%      -0.1        0.60 ±  5%  perf-profile.calltrace.cycles-pp.alloc_extent_buffer.btrfs_init_new_buffer.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block
      0.92 ±  3%      -0.1        0.80 ±  2%  perf-profile.calltrace.cycles-pp.__btrfs_check_node.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio
      0.82 ±  4%      -0.1        0.71 ±  5%  perf-profile.calltrace.cycles-pp.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock
      0.82 ±  4%      -0.1        0.71 ±  5%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.78 ±  3%      -0.1        0.68 ±  6%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all
      0.69 ±  5%      -0.1        0.60 ±  4%  perf-profile.calltrace.cycles-pp.steal_from_bitmap.__btrfs_add_free_space.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction
      0.62 ±  4%      +0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_update_root
      0.50 ± 33%      +0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      0.00            +0.6        0.63 ±  5%  perf-profile.calltrace.cycles-pp.__queue_work.queue_work_on.__submit_bio.__submit_bio_noacct.btrfs_submit_bio
      0.00            +0.7        0.66 ±  4%  perf-profile.calltrace.cycles-pp.queue_work_on.__submit_bio.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk
      0.00            +0.7        0.69 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.7        0.70 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.clone_write_end_io_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.74 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback_no_dropbehind.folio_end_writeback.end_bbio_meta_write.orig_write_end_io_work
      0.00            +0.8        0.85 ±  3%  perf-profile.calltrace.cycles-pp.folio_end_writeback_no_dropbehind.folio_end_writeback.end_bbio_meta_write.orig_write_end_io_work.process_one_work
      0.00            +0.9        0.86 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.93 ±  3%  perf-profile.calltrace.cycles-pp.folio_end_writeback.end_bbio_meta_write.orig_write_end_io_work.process_one_work.worker_thread
      0.00            +0.9        0.94 ±  3%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.0        1.04 ±  4%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.00            +1.4        1.40 ±  2%  perf-profile.calltrace.cycles-pp.end_bbio_meta_write.orig_write_end_io_work.process_one_work.worker_thread.kthread
      0.05 ±299%      +1.5        1.56 ±  4%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt
      0.10 ±200%      +1.6        1.69 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt
      0.00            +1.6        1.63 ±  2%  perf-profile.calltrace.cycles-pp.orig_write_end_io_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.74 ± 19%      +1.8        2.51 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry
      1.69 ± 14%      +2.5        4.16 ±  3%  perf-profile.calltrace.cycles-pp.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      4.09 ±  6%      +8.7       12.79 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      4.09 ±  6%      +8.7       12.80 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.11 ±  6%      +8.7       12.83 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.24 ±  6%      +9.0       13.21 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.96 ±  6%      +9.0       12.98 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.26 ±  5%      +9.4       13.67 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.75 ±  6%     +10.1       14.82 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.76 ±  6%     +10.1       14.86 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      4.77 ±  6%     +10.1       14.88 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      5.25 ±  2%     +10.2       15.43 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
      4.41 ±  5%     +14.1       18.55 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
     61.45            -9.7       51.78        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     61.44            -9.7       51.76        perf-profile.children.cycles-pp.do_syscall_64
     32.14 ±  2%      -5.1       27.05        perf-profile.children.cycles-pp.do_fsync
     32.14 ±  2%      -5.1       27.05        perf-profile.children.cycles-pp.__x64_sys_fsync
     32.13 ±  2%      -5.1       27.04        perf-profile.children.cycles-pp.btrfs_sync_file
     19.70            -3.4       16.26 ±  2%  perf-profile.children.cycles-pp.do_writepages
     19.79            -3.4       16.36        perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     19.76            -3.4       16.33        perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     23.48 ±  2%      -3.2       20.24 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
     23.48 ±  2%      -3.2       20.24 ±  3%  perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
     23.48 ±  2%      -3.2       20.24 ±  3%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
     23.48 ±  2%      -3.2       20.23 ±  3%  perf-profile.children.cycles-pp.drm_atomic_commit
     23.47 ±  2%      -3.2       20.23 ±  3%  perf-profile.children.cycles-pp.commit_tail
     23.48 ±  2%      -3.2       20.23 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
     23.47 ±  2%      -3.2       20.23 ±  3%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
     23.47 ±  2%      -3.2       20.23 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
     23.44 ±  2%      -3.2       20.20 ±  3%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
     23.44 ±  2%      -3.2       20.20 ±  3%  perf-profile.children.cycles-pp.drm_fb_memcpy
     23.42 ±  2%      -3.2       20.18 ±  3%  perf-profile.children.cycles-pp.memcpy_toio
     16.81            -3.2       13.64        perf-profile.children.cycles-pp.btrfs_submit_bbio
     16.80            -3.2       13.64        perf-profile.children.cycles-pp.btrfs_submit_chunk
     22.33 ±  4%      -3.1       19.19 ±  4%  perf-profile.children.cycles-pp.ksys_write
     22.32 ±  4%      -3.1       19.18 ±  4%  perf-profile.children.cycles-pp.vfs_write
     21.54 ±  4%      -3.0       18.56 ±  5%  perf-profile.children.cycles-pp.vprintk_emit
     21.43 ±  4%      -3.0       18.46 ±  5%  perf-profile.children.cycles-pp.devkmsg_emit
     21.43 ±  4%      -3.0       18.46 ±  5%  perf-profile.children.cycles-pp.devkmsg_write.cold
     21.44 ±  4%      -3.0       18.47 ±  5%  perf-profile.children.cycles-pp.console_flush_all
     21.44 ±  4%      -3.0       18.47 ±  5%  perf-profile.children.cycles-pp.console_unlock
     18.06 ±  2%      -2.9       15.15 ±  2%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
     17.88            -2.9       14.98 ±  2%  perf-profile.children.cycles-pp.btree_write_cache_pages
     20.76 ±  4%      -2.8       17.93 ±  4%  perf-profile.children.cycles-pp.serial8250_console_write
     20.14 ±  2%      -2.7       17.49        perf-profile.children.cycles-pp.btrfs_sync_log
     17.97 ±  5%      -2.4       15.52 ±  5%  perf-profile.children.cycles-pp.wait_for_lsr
     17.29 ±  4%      -2.3       14.95 ±  5%  perf-profile.children.cycles-pp.io_serial_in
     11.88 ±  2%      -2.1        9.81 ±  2%  perf-profile.children.cycles-pp.btrfs_search_slot
      9.16 ±  3%      -1.9        7.30 ±  2%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
      9.14 ±  3%      -1.8        7.29 ±  2%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
      8.98 ±  3%      -1.8        7.16 ±  2%  perf-profile.children.cycles-pp.btrfs_log_inode
      6.66 ±  2%      -1.7        4.96        perf-profile.children.cycles-pp.__submit_bio
      6.67 ±  2%      -1.7        4.99        perf-profile.children.cycles-pp.__submit_bio_noacct
      8.15 ±  3%      -1.7        6.49 ±  2%  perf-profile.children.cycles-pp.copy_inode_items_to_log
     31.37 ±  2%      -1.6       29.79 ±  2%  perf-profile.children.cycles-pp.process_one_work
      9.58 ±  2%      -1.5        8.06 ±  2%  perf-profile.children.cycles-pp.btree_csum_one_bio
      5.12 ±  3%      -1.5        3.66 ± 33%  perf-profile.children.cycles-pp.brd_rw_bvec
      6.98 ±  3%      -1.4        5.60 ±  2%  perf-profile.children.cycles-pp.copy_items
      6.51 ±  3%      -1.4        5.14 ±  2%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      6.29 ±  2%      -1.4        4.94 ±  2%  perf-profile.children.cycles-pp.btrfs_submit_bio
      7.54 ±  2%      -1.2        6.32 ±  3%  perf-profile.children.cycles-pp.__btrfs_check_leaf
      7.55 ±  2%      -1.2        6.32 ±  3%  perf-profile.children.cycles-pp.btrfs_check_leaf
      5.15 ±  3%      -1.1        4.08 ±  2%  perf-profile.children.cycles-pp.brd_submit_bio
      4.31 ±  4%      -1.0        3.29 ±  3%  perf-profile.children.cycles-pp.btrfs_work_helper
      4.94 ±  3%      -0.9        4.00 ±  2%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      6.58 ±  3%      -0.9        5.66 ±  2%  perf-profile.children.cycles-pp.btrfs_cow_block
      6.56 ±  3%      -0.9        5.65 ±  2%  perf-profile.children.cycles-pp.btrfs_force_cow_block
      4.01 ±  3%      -0.8        3.16 ±  2%  perf-profile.children.cycles-pp.btrfs_create_common
      3.84 ±  3%      -0.8        3.06 ±  2%  perf-profile.children.cycles-pp.mkdir
      3.54 ±  3%      -0.8        2.77 ±  2%  perf-profile.children.cycles-pp.btrfs_create_new_inode
      3.79 ±  3%      -0.8        3.02 ±  2%  perf-profile.children.cycles-pp.__x64_sys_mkdir
      3.73 ±  3%      -0.8        2.98 ±  2%  perf-profile.children.cycles-pp.do_mkdirat
      3.86 ±  3%      -0.7        3.15 ±  2%  perf-profile.children.cycles-pp.log_csums
      4.22 ±  3%      -0.7        3.51 ±  3%  perf-profile.children.cycles-pp.btrfs_get_32
      3.58 ±  3%      -0.7        2.91 ±  3%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      3.68 ±  3%      -0.7        3.01 ±  2%  perf-profile.children.cycles-pp.__pi_memcpy
      3.48 ±  4%      -0.7        2.82 ±  3%  perf-profile.children.cycles-pp.btrfs_preempt_reclaim_metadata_space
      3.48 ±  4%      -0.7        2.82 ±  3%  perf-profile.children.cycles-pp.flush_space
      2.73 ±  4%      -0.6        2.13 ±  2%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
      2.96 ±  3%      -0.6        2.37 ±  2%  perf-profile.children.cycles-pp.vfs_mkdir
      2.91 ±  3%      -0.6        2.33 ±  2%  perf-profile.children.cycles-pp.btrfs_mkdir
      1.89 ±  2%      -0.6        1.32 ±  3%  perf-profile.children.cycles-pp.start_ordered_ops
      1.87 ±  2%      -0.6        1.30 ±  2%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
      1.81 ±  2%      -0.6        1.26 ±  2%  perf-profile.children.cycles-pp.btrfs_writepages
      2.36 ±  4%      -0.5        1.81 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      2.36 ±  4%      -0.5        1.82 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.80 ±  2%      -0.5        1.25 ±  3%  perf-profile.children.cycles-pp.extent_write_cache_pages
      3.30 ±  2%      -0.5        2.76 ±  3%  perf-profile.children.cycles-pp.check_leaf_item
      2.27 ±  4%      -0.5        1.74 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      2.27 ±  4%      -0.5        1.74 ±  2%  perf-profile.children.cycles-pp.path_openat
      1.71 ±  2%      -0.5        1.18 ±  2%  perf-profile.children.cycles-pp.extent_writepage
      2.37 ±  3%      -0.5        1.86 ±  3%  perf-profile.children.cycles-pp.btrfs_add_link
      2.45 ±  4%      -0.5        1.95 ±  4%  perf-profile.children.cycles-pp.setup_items_for_insert
      2.26 ±  3%      -0.5        1.77 ±  3%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      1.96 ±  4%      -0.5        1.49 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
      1.87 ±  3%      -0.4        1.43 ±  2%  perf-profile.children.cycles-pp.lookup_open
      2.26 ±  5%      -0.4        1.83 ±  3%  perf-profile.children.cycles-pp.copy_extent_buffer_full
      2.01 ±  2%      -0.4        1.58 ±  3%  perf-profile.children.cycles-pp.__memmove
      1.78 ±  7%      -0.4        1.38 ±  5%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      1.78 ±  7%      -0.4        1.38 ±  5%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      1.80 ±  3%      -0.4        1.42 ±  3%  perf-profile.children.cycles-pp.insert_with_overflow
      1.70 ±  3%      -0.4        1.34 ±  3%  perf-profile.children.cycles-pp.read_block_for_search
      2.72 ±  2%      -0.4        2.36 ±  3%  perf-profile.children.cycles-pp.io_serial_out
      1.65 ±  6%      -0.3        1.31 ±  5%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
      0.89 ±  3%      -0.3        0.55 ±  3%  perf-profile.children.cycles-pp.extent_writepage_io
      1.49 ±  5%      -0.3        1.16 ±  4%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
      2.70 ±  3%      -0.3        2.38 ±  3%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
      0.81 ±  4%      -0.3        0.48 ±  4%  perf-profile.children.cycles-pp.submit_extent_folio
      0.72 ±  5%      -0.3        0.40 ±  6%  perf-profile.children.cycles-pp.submit_one_bio
      1.88 ±  2%      -0.3        1.59 ±  3%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      1.35 ±  4%      -0.3        1.07 ±  3%  perf-profile.children.cycles-pp.log_all_new_ancestors
      1.35 ±  7%      -0.3        1.08 ±  7%  perf-profile.children.cycles-pp.run_delayed_data_ref
      0.44 ±  7%      -0.3        0.18 ±  8%  perf-profile.children.cycles-pp.btrfs_start_ordered_extent_nowriteback
      1.34 ±  4%      -0.2        1.09 ±  4%  perf-profile.children.cycles-pp.find_extent_buffer
      1.13 ±  4%      -0.2        0.88 ±  4%  perf-profile.children.cycles-pp.btrfs_bin_search
      1.03 ±  4%      -0.2        0.80 ±  4%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
      1.20 ±  3%      -0.2        0.98 ±  3%  perf-profile.children.cycles-pp.crc32c_arch
      1.02 ±  7%      -0.2        0.81 ±  4%  perf-profile.children.cycles-pp.btrfs_release_path
      0.94 ±  6%      -0.2        0.74 ±  2%  perf-profile.children.cycles-pp.insert_reserved_file_extent
      0.91 ±  6%      -0.2        0.70 ±  5%  perf-profile.children.cycles-pp.split_leaf
      1.09 ±  3%      -0.2        0.89 ±  3%  perf-profile.children.cycles-pp.crc32c_x86_3way
      1.88 ±  3%      -0.2        1.69 ±  3%  perf-profile.children.cycles-pp.btrfs_init_new_buffer
      0.91 ±  4%      -0.2        0.72 ±  4%  perf-profile.children.cycles-pp.btrfs_extend_item
      1.03 ±  2%      -0.2        0.86 ±  4%  perf-profile.children.cycles-pp.csum_tree_block
      0.76 ±  5%      -0.2        0.59 ±  4%  perf-profile.children.cycles-pp.btrfs_insert_delayed_item
      0.79 ±  3%      -0.2        0.62 ±  4%  perf-profile.children.cycles-pp.writepage_delalloc
      0.99 ±  2%      -0.2        0.82 ±  4%  perf-profile.children.cycles-pp.chksum_update
      0.82 ±  4%      -0.2        0.65 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.64 ±  6%      -0.2        0.48 ±  5%  perf-profile.children.cycles-pp.btrfs_check_ref_name_override
      0.86 ±  4%      -0.2        0.70 ±  4%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.82 ±  5%      -0.2        0.66 ±  6%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      0.95 ±  4%      -0.2        0.79 ±  3%  perf-profile.children.cycles-pp.read_extent_buffer
      0.82 ±  3%      -0.2        0.67 ±  3%  perf-profile.children.cycles-pp.btrfs_get_64
      0.66 ±  3%      -0.2        0.51 ±  3%  perf-profile.children.cycles-pp.alloc_reserved_extent
      0.70 ±  6%      -0.2        0.55 ±  4%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.62 ±  9%      -0.2        0.47 ±  6%  perf-profile.children.cycles-pp.set_extent_bit
      0.80 ±  5%      -0.2        0.65 ±  6%  perf-profile.children.cycles-pp.btrfs_buffered_write
      0.62 ±  4%      -0.2        0.47 ±  4%  perf-profile.children.cycles-pp.btrfs_remove_from_free_space_tree
      0.54 ±  8%      -0.1        0.40 ±  4%  perf-profile.children.cycles-pp.btrfs_drop_extents
      0.70 ±  6%      -0.1        0.56 ±  7%  perf-profile.children.cycles-pp.btrfs_set_32
      0.56 ±  5%      -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.remove_free_space_extent
      0.70 ±  4%      -0.1        0.57 ±  6%  perf-profile.children.cycles-pp.filename_create
      0.60 ±  6%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.find_free_extent
      0.69 ±  7%      -0.1        0.56 ±  7%  perf-profile.children.cycles-pp.copy_one_range
      0.86 ±  2%      -0.1        0.73 ±  2%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
      1.66 ±  3%      -0.1        1.54 ±  3%  perf-profile.children.cycles-pp.alloc_extent_buffer
      0.82 ±  4%      -0.1        0.70 ±  3%  perf-profile.children.cycles-pp.btrfs_finish_extent_commit
      0.97 ±  3%      -0.1        0.85 ±  2%  perf-profile.children.cycles-pp.btrfs_check_node
      0.97 ±  3%      -0.1        0.84 ±  2%  perf-profile.children.cycles-pp.__btrfs_check_node
      0.80 ±  4%      -0.1        0.67 ±  4%  perf-profile.children.cycles-pp.unpin_extent_range
      0.61 ±  4%      -0.1        0.49 ±  5%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      0.61 ±  4%      -0.1        0.49 ±  5%  perf-profile.children.cycles-pp.btrfs_lookup
      0.78 ±  4%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.__btrfs_add_free_space
      0.52 ±  8%      -0.1        0.40 ±  7%  perf-profile.children.cycles-pp.btrfs_set_extent_bit
      0.44 ±  5%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.down_write
      0.52 ±  4%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.cow_file_range
      0.51 ±  6%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.41 ±  5%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.btrfs_next_old_leaf
      0.44 ±  6%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.btrfs_tree_lock_nested
      0.49 ±  7%      -0.1        0.38 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.82 ±  3%      -0.1        0.71 ±  5%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.40 ±  3%      -0.1        0.29 ± 33%  perf-profile.children.cycles-pp.brd_lookup_page
      0.74 ±  5%      -0.1        0.64 ±  4%  perf-profile.children.cycles-pp.steal_from_bitmap
      0.64 ±  6%      -0.1        0.54 ±  5%  perf-profile.children.cycles-pp.release_extent_buffer
      0.59 ±  5%      -0.1        0.49 ±  4%  perf-profile.children.cycles-pp.check_inode_item
      0.52 ±  2%      -0.1        0.42 ±  6%  perf-profile.children.cycles-pp.check_extent_data_item
      0.46 ±  6%      -0.1        0.36 ±  7%  perf-profile.children.cycles-pp.btrfs_search_forward
      0.40 ±  5%      -0.1        0.31 ±  5%  perf-profile.children.cycles-pp.random
      0.43 ±  6%      -0.1        0.33 ±  5%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.42 ±  7%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.51 ±  6%      -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.clone_leaf
      0.51 ±  4%      -0.1        0.43 ±  6%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      0.28 ±  7%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.alloc_extent_state
      0.61 ±  4%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.37 ±  4%      -0.1        0.29 ±  4%  perf-profile.children.cycles-pp.push_leaf_right
      0.46 ±  6%      -0.1        0.38 ±  7%  perf-profile.children.cycles-pp.up_read
      0.38 ±  5%      -0.1        0.31 ±  7%  perf-profile.children.cycles-pp.start_transaction
      0.36 ±  6%      -0.1        0.28 ±  7%  perf-profile.children.cycles-pp.btrfs_lookup_inode
      0.41 ±  5%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.memset_orig
      0.31 ± 11%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      0.39 ±  7%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.btrfs_clear_extent_bit_changeset
      0.33 ±  5%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.down_read
      0.32 ± 11%      -0.1        0.26 ±  9%  perf-profile.children.cycles-pp.push_leaf_left
      0.29 ±  6%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.33 ±  5%      -0.1        0.27 ±  6%  perf-profile.children.cycles-pp.alloc_inode
      0.32 ±  4%      -0.1        0.26 ±  6%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.34 ±  7%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.btrfs_free_tree_block
      0.25 ±  6%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.btrfs_log_holes
      0.29 ±  4%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.__push_leaf_right
      0.34 ±  5%      -0.1        0.27 ±  5%  perf-profile.children.cycles-pp.free_extent_buffer
      0.26 ±  9%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.unlock_up
      0.26 ±  7%      -0.1        0.20 ± 10%  perf-profile.children.cycles-pp.btrfs_read_node_slot
      0.26 ±  3%      -0.1        0.20 ± 10%  perf-profile.children.cycles-pp.alloc_eb_folio_array
      0.24 ±  9%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.find_free_extent_clustered
      0.30 ±  5%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.btrfs_tree_read_lock_nested
      0.24 ±  8%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.24 ±  5%      -0.1        0.18 ± 11%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.23 ± 10%      -0.1        0.17 ±  6%  perf-profile.children.cycles-pp.fill_inode_item
      0.18 ±  9%      -0.1        0.12 ±  9%  perf-profile.children.cycles-pp.__wake_up
      0.24 ±  4%      -0.1        0.18 ± 11%  perf-profile.children.cycles-pp.btrfs_alloc_page_array
      0.45 ±  4%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.24 ±  6%      -0.1        0.19 ±  7%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.21 ±  6%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.find_lock_delalloc_range
      0.19 ±  8%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.block_group_cache_tree_search
      0.22 ±  9%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.btrfs_alloc_from_cluster
      0.23 ±  9%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.btrfs_free_path
      0.35 ±  5%      -0.0        0.30 ±  6%  perf-profile.children.cycles-pp.new_inode
      0.27 ±  6%      -0.0        0.22 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.20 ±  9%      -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.up_write
      0.19 ±  7%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.btrfs_lookup_csums_list
      0.21 ±  7%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.read_tree_block
      0.13 ± 13%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.23 ±  6%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.btrfs_log_all_xattrs
      0.17 ± 10%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.run_delayed_tree_ref
      0.23 ±  9%      -0.0        0.19 ±  8%  perf-profile.children.cycles-pp.check_dir_item
      0.17 ± 10%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.alloc_reserved_tree_block
      0.19 ±  7%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.18 ± 11%      -0.0        0.14 ± 13%  perf-profile.children.cycles-pp.rcu_all_qs
      0.19 ±  5%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.link_path_walk
      0.17 ± 13%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.crypto_shash_digest
      0.22 ±  9%      -0.0        0.18 ±  8%  perf-profile.children.cycles-pp.check_inode_key
      0.15 ±  8%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.22 ±  7%      -0.0        0.18 ±  9%  perf-profile.children.cycles-pp.btrfs_alloc_inode
      0.07 ±  9%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.16 ± 15%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.chksum_digest
      0.17 ±  9%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.19 ±  8%      -0.0        0.15 ± 13%  perf-profile.children.cycles-pp.__push_leaf_left
      0.11 ± 14%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.btrfs_lock_extent_bits
      0.18 ±  9%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.xas_store
      0.12 ± 23%      -0.0        0.09 ± 13%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
      0.16 ±  5%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.rcu_core
      0.15 ±  5%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      0.11 ± 10%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.lock_delalloc_folios
      0.08 ±  9%      -0.0        0.04 ± 52%  perf-profile.children.cycles-pp.btrfs_replace_extent_map_range
      0.12 ± 13%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.dput
      0.18 ±  4%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.mutex_lock
      0.07 ±  7%      -0.0        0.04 ± 66%  perf-profile.children.cycles-pp.xa_store
      0.12 ± 10%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.lookup_fast
      0.12 ±  7%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.13 ± 14%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.need_preemptive_reclaim
      0.08 ± 16%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.10 ±  8%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.btrfs_create_io_em
      0.08 ± 10%      -0.0        0.05 ± 35%  perf-profile.children.cycles-pp.xas_create
      0.12 ±  7%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__d_alloc
      0.10 ±  5%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.btrfs_buffer_uptodate
      0.10 ± 10%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.clear_page_erms
      0.09 ± 11%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.__btrfs_free_extent
      0.09 ± 14%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.11 ± 10%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.find_next_csum_offset
      0.10 ±  9%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.btrfs_verify_level_key
      0.07 ±  9%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.join_transaction
      0.08 ± 11%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.btrfs_get_16
      0.08 ±  8%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__xa_store
      0.08 ± 14%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.folio_unlock
      0.31 ±  6%      +0.0        0.35 ±  3%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.11 ± 12%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.work_busy
      0.56 ±  5%      +0.0        0.61 ±  2%  perf-profile.children.cycles-pp.btrfs_wait_ordered_range
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.09 ± 12%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.xas_set_mark
      0.00            +0.1        0.06 ± 12%  perf-profile.children.cycles-pp.x2apic_send_IPI
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.worker_enter_idle
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.sb_clear_inode_writeback
      0.17 ±  8%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.btrfs_bio_counter_sub
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.pick_task_fair
      0.09 ± 14%      +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.13 ± 12%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.xas_clear_mark
      0.07 ± 24%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.do_perf_trace_sched_stat_runtime
      0.35 ±  6%      +0.1        0.43 ±  6%  perf-profile.children.cycles-pp.end_bbio_data_write
      0.01 ±200%      +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.strnlen
      0.22 ±  9%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.01 ±200%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.00            +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.05 ± 54%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.set_next_entity
      0.01 ±200%      +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.bio_endio
      0.03 ± 82%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.wake_page_function
      0.12 ± 16%      +0.1        0.21 ±  9%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.05 ± 35%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.bio_free
      0.07 ± 21%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.set_next_task_fair
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.01 ±200%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.wake_bit_function
      0.02 ±123%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.wq_worker_running
      0.10 ± 37%      +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.prepare_task_switch
      0.48 ±  4%      +0.1        0.59 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      0.02 ±153%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.01 ±300%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.01 ±203%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.wake_affine
      0.21 ± 10%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.wake_up_bit
      0.01 ±200%      +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.folio_wake_bit
      0.07 ± 21%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.13 ± 11%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.update_load_avg
      0.06 ± 15%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.buffer_tree_clear_mark
      0.12 ±  9%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.01 ±200%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.perf_tp_event
      0.04 ± 69%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.12 ±  8%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.enqueue_entity
      0.07 ± 23%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.update_se
      0.40 ±  6%      +0.1        0.54 ±  6%  perf-profile.children.cycles-pp.btrfs_bio_end_io
      0.03 ±100%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.poll_idle
      0.08 ± 16%      +0.2        0.23 ±  8%  perf-profile.children.cycles-pp.sched_clock
      0.16 ± 10%      +0.2        0.32 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      0.09 ± 16%      +0.2        0.25 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.03 ±100%      +0.2        0.19 ±  7%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.08 ± 17%      +0.2        0.25 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.2        0.17 ±  7%  perf-profile.children.cycles-pp.pwq_tryinc_nr_active
      0.12 ± 22%      +0.2        0.29 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.07 ± 21%      +0.2        0.24 ±  6%  perf-profile.children.cycles-pp.select_task_rq
      0.12 ± 16%      +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.07 ± 13%      +0.2        0.24 ±  7%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      0.04 ± 83%      +0.2        0.21 ±  7%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.05 ± 34%      +0.2        0.22 ± 10%  perf-profile.children.cycles-pp.__resched_curr
      0.10 ± 22%      +0.2        0.28 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
      0.01 ±299%      +0.2        0.19 ±  7%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.00            +0.2        0.18 ±  8%  perf-profile.children.cycles-pp.bit_wait_io
      0.07 ± 19%      +0.2        0.25 ±  7%  perf-profile.children.cycles-pp.irqentry_enter
      0.06 ± 11%      +0.2        0.25 ± 10%  perf-profile.children.cycles-pp.wakeup_preempt
      0.78 ±  2%      +0.2        0.98 ±  3%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.06 ± 37%      +0.2        0.27 ±  5%  perf-profile.children.cycles-pp.llist_reverse_order
      0.10 ± 10%      +0.2        0.32 ±  6%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.22 ± 15%      +0.2        0.45 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.18 ±  8%      +0.2        0.41 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.24 ±  7%  perf-profile.children.cycles-pp.__wait_on_bit
      0.00            +0.2        0.24 ±  6%  perf-profile.children.cycles-pp.out_of_line_wait_on_bit
      0.00            +0.3        0.25 ±  4%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.16 ± 10%      +0.3        0.42 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.19 ±  9%      +0.3        0.45 ±  6%  perf-profile.children.cycles-pp.enqueue_task
      0.13 ±  8%      +0.3        0.40 ±  5%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
      0.15 ±  7%      +0.3        0.42 ±  4%  perf-profile.children.cycles-pp.btrfs_wait_tree_log_extents
      0.00            +0.3        0.27 ±  4%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.29 ± 11%      +0.3        0.56 ±  5%  perf-profile.children.cycles-pp.__pick_next_task
      0.14 ±  8%      +0.3        0.41 ±  7%  perf-profile.children.cycles-pp.tick_irq_enter
      0.23 ± 10%      +0.3        0.52 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.3        0.29 ±  5%  perf-profile.children.cycles-pp.btrfs_btree_wait_writeback_range
      0.00            +0.3        0.29 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.26 ± 11%      +0.3        0.56 ±  4%  perf-profile.children.cycles-pp.dequeue_entities
      0.18 ± 11%      +0.3        0.48 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.3        0.31 ±  2%  perf-profile.children.cycles-pp.filemap_fdatawait_range
      0.27 ±  9%      +0.3        0.59 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.79 ±  2%      +0.3        1.12 ±  3%  perf-profile.children.cycles-pp.folio_end_writeback_no_dropbehind
      0.15 ±  8%      +0.3        0.48 ±  6%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.28 ±  8%      +0.3        0.61 ±  3%  perf-profile.children.cycles-pp.try_to_block_task
      0.87 ±  3%      +0.3        1.21 ±  3%  perf-profile.children.cycles-pp.folio_end_writeback
      0.11 ± 10%      +0.3        0.45 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.52 ±  5%      +0.4        0.88 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.38 ±  6%  perf-profile.children.cycles-pp.io_schedule
      0.31 ± 15%      +0.4        0.75 ±  8%  perf-profile.children.cycles-pp.schedule_idle
      0.26 ±  6%      +0.5        0.72 ±  5%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.90 ±  3%      +0.5        1.41 ±  2%  perf-profile.children.cycles-pp.end_bbio_meta_write
      0.34 ±  6%      +0.7        1.06 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.7        0.73 ±  3%  perf-profile.children.cycles-pp.clone_write_end_io_work
      0.32 ±  6%      +0.8        1.13 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.18 ± 10%      +0.8        0.99 ±  2%  perf-profile.children.cycles-pp.kick_pool
      0.67 ±  7%      +0.8        1.50 ±  2%  perf-profile.children.cycles-pp.schedule
      0.47 ±  5%      +1.1        1.60 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.25 ±  8%      +1.1        1.38 ±  2%  perf-profile.children.cycles-pp.__queue_work
      0.27 ±  6%      +1.2        1.45 ±  2%  perf-profile.children.cycles-pp.queue_work_on
      0.97 ±  9%      +1.2        2.15 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.50 ±  5%      +1.2        1.72 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +1.6        1.63 ±  2%  perf-profile.children.cycles-pp.orig_write_end_io_work
      1.10 ±  5%      +1.8        2.88 ±  3%  perf-profile.children.cycles-pp.sysvec_call_function_single
      2.97 ±  3%      +8.1       11.04 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      4.24 ±  2%      +8.8       13.00 ±  2%  perf-profile.children.cycles-pp.pv_native_safe_halt
      4.25 ±  2%      +8.8       13.01 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      4.25 ±  2%      +8.8       13.02 ±  2%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      4.28 ±  2%      +8.8       13.05 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      4.41 ±  2%      +9.0       13.43 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.43 ±  2%      +9.1       13.50 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      4.75 ±  2%      +9.5       14.23 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      4.77 ±  6%     +10.1       14.88 ±  2%  perf-profile.children.cycles-pp.start_secondary
      5.25 ±  3%     +10.2       15.40 ±  2%  perf-profile.children.cycles-pp.do_idle
      5.25 ±  2%     +10.2       15.43 ±  2%  perf-profile.children.cycles-pp.common_startup_64
      5.25 ±  2%     +10.2       15.43 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     23.33 ±  2%      -3.2       20.11 ±  3%  perf-profile.self.cycles-pp.memcpy_toio
     17.29 ±  4%      -2.3       14.95 ±  5%  perf-profile.self.cycles-pp.io_serial_in
      4.32 ±  3%      -1.2        3.13 ± 33%  perf-profile.self.cycles-pp.brd_rw_bvec
      3.53 ±  3%      -0.7        2.88 ±  2%  perf-profile.self.cycles-pp.__pi_memcpy
      3.77 ±  3%      -0.6        3.14 ±  3%  perf-profile.self.cycles-pp.btrfs_get_32
      2.00 ±  2%      -0.4        1.58 ±  3%  perf-profile.self.cycles-pp.__memmove
      2.72 ±  2%      -0.4        2.36 ±  3%  perf-profile.self.cycles-pp.io_serial_out
      1.10 ±  3%      -0.2        0.87 ±  4%  perf-profile.self.cycles-pp.btrfs_bin_search
      1.08 ±  3%      -0.2        0.88 ±  3%  perf-profile.self.cycles-pp.crc32c_x86_3way
      0.76 ±  3%      -0.1        0.62 ±  4%  perf-profile.self.cycles-pp.btrfs_get_64
      0.97 ±  3%      -0.1        0.82 ±  5%  perf-profile.self.cycles-pp.__btrfs_check_leaf
      0.77 ±  4%      -0.1        0.63 ±  3%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.98 ±  3%      -0.1        0.83 ±  3%  perf-profile.self.cycles-pp.check_leaf_item
      0.63 ±  6%      -0.1        0.50 ±  6%  perf-profile.self.cycles-pp.btrfs_set_32
      0.64 ±  6%      -0.1        0.52 ±  3%  perf-profile.self.cycles-pp.btrfs_force_cow_block
      0.75 ±  4%      -0.1        0.63 ±  2%  perf-profile.self.cycles-pp.read_extent_buffer
      0.52 ±  4%      -0.1        0.41 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.44 ±  6%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.59 ±  4%      -0.1        0.48 ±  4%  perf-profile.self.cycles-pp.find_extent_buffer
      0.39 ±  4%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.random
      0.45 ±  6%      -0.1        0.38 ±  7%  perf-profile.self.cycles-pp.up_read
      0.40 ±  4%      -0.1        0.32 ±  6%  perf-profile.self.cycles-pp.memset_orig
      0.57 ±  5%      -0.1        0.49 ±  4%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.22 ±  9%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.down_write
      0.25 ±  6%      -0.1        0.19 ±  9%  perf-profile.self.cycles-pp.__cond_resched
      0.16 ±  8%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.14 ± 12%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.block_group_cache_tree_search
      0.15 ±  8%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.read_block_for_search
      0.18 ± 11%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.19 ±  8%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.down_read
      0.14 ±  7%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.up_write
      0.13 ± 12%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.set_extent_buffer_dirty
      0.11 ±  5%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.alloc_pages_bulk_noprof
      0.09 ±  8%      -0.0        0.06 ± 10%  perf-profile.self.cycles-pp.btrfs_buffer_uptodate
      0.14 ±  5%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.mutex_lock
      0.09 ± 12%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.btrfs_free_extent_state
      0.10 ± 10%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.clear_page_erms
      0.12 ±  7%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.detach_extent_buffer_folio
      0.07 ± 17%      -0.0        0.05 ± 34%  perf-profile.self.cycles-pp.xas_store
      0.10 ±  7%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.check_inode_item
      0.12 ±  8%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.__btrfs_check_node
      0.09 ± 14%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.attach_extent_buffer_folio
      0.07 ± 11%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.btrfs_reduce_alloc_profile
      0.07 ± 10%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.btrfs_verify_level_key
      0.04 ± 66%      +0.0        0.07 ± 15%  perf-profile.self.cycles-pp.__xa_set_mark
      0.06 ± 12%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.btrfs_map_block
      0.05 ± 35%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.08 ± 12%      +0.1        0.14 ± 10%  perf-profile.self.cycles-pp.xas_set_mark
      0.01 ±300%      +0.1        0.06 ± 10%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.00            +0.1        0.06 ± 12%  perf-profile.self.cycles-pp.x2apic_send_IPI
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.__smp_call_single_queue
      0.02 ±153%      +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.dequeue_entity
      0.02 ±153%      +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.06 ± 12%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.1        0.06 ± 12%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.do_perf_trace_sched_wakeup_template
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.schedule
      0.16 ± 10%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.02 ±123%      +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.update_load_avg
      0.12 ± 10%      +0.1        0.19 ±  6%  perf-profile.self.cycles-pp.xas_clear_mark
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.strnlen
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.tick_irq_enter
      0.06 ± 14%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.enqueue_entity
      0.17 ±  5%      +0.1        0.25 ±  6%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.wq_worker_running
      0.00            +0.1        0.08 ±  7%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.03 ±100%      +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.btrfs_submit_bio
      0.00            +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.bio_endio
      0.02 ±200%      +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.prepare_task_switch
      0.03 ±100%      +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.01 ±300%      +0.1        0.11 ± 14%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.08 ± 17%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.menu_select
      0.01 ±300%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.available_idle_cpu
      0.02 ±153%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.07 ± 26%      +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.__queue_work
      0.00            +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.perf_tp_event
      0.01 ±300%      +0.1        0.13 ± 10%  perf-profile.self.cycles-pp.__switch_to
      0.01 ±300%      +0.1        0.13 ± 10%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.1        0.13 ± 11%  perf-profile.self.cycles-pp.end_bbio_meta_write
      0.11 ±  8%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.01 ±200%      +0.1        0.15 ± 17%  perf-profile.self.cycles-pp.kick_pool
      0.02 ±123%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.poll_idle
      0.00            +0.2        0.15 ±  9%  perf-profile.self.cycles-pp.clone_write_end_io_work
      0.09 ± 17%      +0.2        0.24 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.04 ± 67%      +0.2        0.20 ±  8%  perf-profile.self.cycles-pp.irqentry_enter
      0.15 ± 11%      +0.2        0.32 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.03 ±100%      +0.2        0.19 ±  7%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.2        0.17 ±  7%  perf-profile.self.cycles-pp.pwq_tryinc_nr_active
      0.12 ± 22%      +0.2        0.28 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.01 ±200%      +0.2        0.18 ±  9%  perf-profile.self.cycles-pp.process_one_work
      0.05 ± 34%      +0.2        0.22 ± 10%  perf-profile.self.cycles-pp.__resched_curr
      0.01 ±299%      +0.2        0.19 ±  7%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.06 ± 15%      +0.2        0.26 ±  4%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.2        0.20 ±  9%  perf-profile.self.cycles-pp.worker_thread
      0.12 ±  7%      +0.2        0.33 ±  9%  perf-profile.self.cycles-pp.__schedule
      0.10 ± 10%      +0.2        0.32 ±  6%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.06 ± 37%      +0.2        0.27 ±  5%  perf-profile.self.cycles-pp.llist_reverse_order
      0.50 ±  5%      +0.3        0.76 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.37 ±  2%      +6.7        9.09 ±  2%  perf-profile.self.cycles-pp.pv_native_safe_halt




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


