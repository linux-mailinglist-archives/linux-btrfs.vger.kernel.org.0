Return-Path: <linux-btrfs+bounces-13826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF8CAAF4DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0069F9C08D0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D7221715;
	Thu,  8 May 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkutCp55"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA16195FE8
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746690183; cv=fail; b=GiIynmvkTX+45V3iVOCz/1f6Itm1Z0/6JfannbQzGfh2Lf2nXC6TanRVWoqTEyFzIfWbefsbH9UEGTnJm/QoR5qPoOjRtVS95TOvTKIDMQDfMHHurUkHL+e2OijE1ZS7yPN2yNpKEVWmc8EM7SwLIdsbifuH+2460yIrMl47UG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746690183; c=relaxed/simple;
	bh=gWluE6D3cw33VWq5NZL4ZtO6Nt8VEG1My7gUfuCREoI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EJOVRwn8dG7kHdw9spOwYWreAukVKiElDro0H1tE/pfomRRaulsu7ZpGqm10uUwNNFe5tHfJfLqU/qF6cE6hsJi2IHyVqTlPaRoQyAwU5QvwtvXQ202PuAdoknWSUtgIxULkg6V7eKmHZNoLq/b3Da8ttg6sZpoTQ7w/K5LeTWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkutCp55; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746690181; x=1778226181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gWluE6D3cw33VWq5NZL4ZtO6Nt8VEG1My7gUfuCREoI=;
  b=UkutCp55C/Oaj9HuY1XdQNuZnFFaE2BXCM1Enz2RZKVvGVOgGJiFX4NF
   VBJLaEGvBtuzc7MZdZWiRn72qc2j8DQ1y9CCM4HP4TPmGN61rjHUYhtyI
   2YE9Vsr2fLXTM/JuCt+wbdg7xBFM4M1jxcke8ZQxlFPCvY9mkjmRCU7Q2
   kEx0zd88lWLADo4Y3UUHh5UI1n9U5f3kyziFG4i9f4oTYkwobgPmOnNpl
   j2pwaoTnycywa6nAhc7Lssnrdwj377yzDevzllrfgI+EbNIegSxhOr4tg
   6btHguVUDouO94O0BCjLH3WtdXe4oDeHBUWY5+nYcEm05DM6G+yEonGyB
   g==;
X-CSE-ConnectionGUID: pQI+dbyDQPiTKLJqhXjIXA==
X-CSE-MsgGUID: JmaknAweQ1KwOjhE5BXGqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48607658"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48607658"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 00:43:01 -0700
X-CSE-ConnectionGUID: 77fvTA8xTYilMi8DF747Iw==
X-CSE-MsgGUID: UybruPEtSx+XoADxY4yhKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="159524776"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 00:43:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 00:43:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 00:43:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 00:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TISCIMaAeXXAnPV5gqhgjCV87a/tAGaxJdISwdpTCxue4SRp0CXhg5aRaDfd8nsrdjfciWR3opLmApqEvMvEdkE3QZ39GwEVfMptVpth01Nd6sX0heeKJCxKwjWniTn/fT4wPkDu29zi3hm5CJb3dU573thZWcdOnvPfD/8UpLrDWT2DQp5R44OvOQcyUc+sFQprK16BlANJudW9ippY3XNzG/Nt/90jfvPGzNYIPD5gHAfnh2TeOueX7+aBf0mthZ+n5naXwpmAWdx85ZlFfo98ekiHFw6Yn3MZwH4C6JFbxY66QS9WYG0KbPzzi7C/m53TkPncqbxZoPp3v1nUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78a3zdy+Po3+obPZTJfckwzT7pOERrVZfAvGd7ABYro=;
 b=EQ6/mofwwBbJXD3mXOxLmlO2yPZkc72cm1S/3+9ldwVWX8QXoJIeX1zWEU5SVdhPRnf+OJGLhlNg4ljdGQYeYcslnwWWvF7uHLpq4/Vahn4fL3YOZ5NEUm+tEKIL+4fseDKx6WWkhYUMZXWKHOAIxA/FnQPqbFMwrHvEi3BQ54YL0fNa8xuxZd+rCFFi9PXnQeZFcgYNmGPCBFb4dUZ12EYd2yHq5dy39KEgA7aQbHBuraIfg38jyOMmmx8QM2MB9MrikMI3w4Mi0hgtrAGs3F9NiFigtmuW2v/kgqdfvXVOAjZQX3p9zPKJ20vIoQgXBzCIsNAMGPM7qY92VZaAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF740777B0C.namprd11.prod.outlook.com (2603:10b6:518:1::d2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 07:42:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 07:42:53 +0000
Date: Thu, 8 May 2025 15:42:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, <linux-btrfs@vger.kernel.org>, <oliver.sang@inte.com>
Subject: [linux-next:master] [btrfs_get_tree_subvol()] 25efcff066:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_NOPTI
Message-ID: <202505081540.3f2a6418-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF740777B0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab7024e-b955-4507-4cb0-08dd8e03f0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tmM64s7c5SXnv6lBg/eOKdR0MZ+XCu8bpxKXGOV7hPJTjAtJZDC6NfON+Koo?=
 =?us-ascii?Q?LEt3J3CRFYN/FPEL33g+TnWyZrAzmCEGlrHZzo80Znu9rj/+UW52Y03Wpmdt?=
 =?us-ascii?Q?3QTWhGy2h9idY4Ge0xADvYjR1Q7hPpf8ArBMVjgLyNOcMSi7KDd6F4zkRuCR?=
 =?us-ascii?Q?fnifr3cKDKBB9F8j4/lL7wb9cyRCLlPOLdWPKpmhYvIsvQ3CdBzyFtrkXr1G?=
 =?us-ascii?Q?27aY+p0JyECiincCCadKFEf818jCw+HoZ5Zfljw8HF+tEPiaoWPvchdZ50Wv?=
 =?us-ascii?Q?oFH4sWW/wVKuG3T13KoAsBOa6NmNm050HVEyGoRdfnY7EESltwbf8uxD6ryu?=
 =?us-ascii?Q?d9ZH4g6Ubtn/ry89XvQeuD29+tqReuotGS8QfQj/C1K9RgGb1LGBYP0EnNsV?=
 =?us-ascii?Q?/jZoisiT3cRnm/v42ipX2PQwCXaoGkxehOS2VfOAsHiXFWjgQOodbALFbO7F?=
 =?us-ascii?Q?F8jvws0rcg6clLiW02idGbjxmiVEe9M6ZxQk2HlitDfgzYWV8QVTtRy9YeUr?=
 =?us-ascii?Q?jBii1VOE/8YLCBl4HzkEHMO74u4og1Znck2JM4WxZlpWSOmcfZhbW8hNtFWZ?=
 =?us-ascii?Q?sN+wyaNkSQA2jUre6+8GrG/o/S3/Oc0SH8q9xgNeoHa2DHTr7hp+fR0kPALX?=
 =?us-ascii?Q?HlnnhQCISwVsD/Zyh7gba1/u5D5/PfQo4E59k1v6mN41uxhfFGF1lhFx3K/j?=
 =?us-ascii?Q?dnI1v/VlOr2wTCg06yeKmaF9z+3wiKyeVJ8r5uyaUFNVwtrwHm85AgF7o/3j?=
 =?us-ascii?Q?4M0gUhHwm4XC0bpLGegPCktb5OUxo/5F1HccYMFJW6ufR3qQlJkBSJx/Nw9p?=
 =?us-ascii?Q?7eKoc5jWlvAQRDIIon9AHI5xIG5A6HqC8d2V6ff6jsy182T9/XaY0RCpUCD5?=
 =?us-ascii?Q?qeNjbe9suI6lPlLFO/E6vLUmARFMMjbdjHIgswlBtn8Ybh084ehqEpIqYRIj?=
 =?us-ascii?Q?cJaMVbjyarz5VN4wqkpy9fKaUju/D/yYtkzuSI+X5qheZ9gril8mx1WuqCGZ?=
 =?us-ascii?Q?Z6zikjObD7kPO3QMky1j2HIpLkOPmu8xiXtjsU38nTYJWHlsBQqc84JiMTMi?=
 =?us-ascii?Q?GmvYWt7u6dAd4a5z0S85x7T6jRHbAOoRJ9pbuyD+GH6FKDG5ifh7OcHZTCSg?=
 =?us-ascii?Q?48RkFsp4PdLBuMUijHhccuTsw6fVdnnRr1vm8aPAEKmhZJmxGq/js1r53N6d?=
 =?us-ascii?Q?pMAWvMN557qJuSlfNSF8dvqfezCF4q5wbmYdoDGMnNmIt8BKnLuTzYT5T3Re?=
 =?us-ascii?Q?ruYtoOfmOsZfjVMewNsbSikzGE+lcbhh6V3zkBg/22F3KdncEvyC8t8l94x0?=
 =?us-ascii?Q?yfzgixP6j9WN09OIMn8S+C2DncWczTOC6ycfIBAYGKhYXdCSVPmHoYDXgxNu?=
 =?us-ascii?Q?UcUxJRuu0Nm30fEOIVgt0LnaNi5L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3F+Z8NSCmK0/WrHzVR8/v5GxIQ+2904hfvXTtOiIht9EBpC+1F3lRie2Qb6?=
 =?us-ascii?Q?bYa3oGyf5p+kEtoY5rL53kWJBG/YhnuqTSllKnyLKLDsQhqx1i6XtxvYjWLY?=
 =?us-ascii?Q?9kEElooB9Dn6DfoIXi0jRFLFeIno43tUhEmclNfi7LfT1gWIgfxpkWE+E+Gp?=
 =?us-ascii?Q?8/rO64vQ5C4rWT4lXWGF/Xq5XRU/Uybzay7GQ+4kA8sQrrRQDguso4vp9FVa?=
 =?us-ascii?Q?TGpibpSMzvyhH9c4m9gINkTNguNUMwhXehIL9Mi1OfzXUnLYtDEfYSojN/NH?=
 =?us-ascii?Q?tgXUsnON118A+Wqb6Mo3usc2imIB5j44fp2fZJlFXtmiA4u1ZDnEyitiQ+kD?=
 =?us-ascii?Q?R4TJ2hIVSJ0Zv/BYcuQOZwWoiJ0jyZH0yXBbhdnvghVLkfp8S7wEbQQNG6aT?=
 =?us-ascii?Q?YaeHyzVJWHYPLrJUNMLEXwxhY9oGs2uI2JPspSLh7cdrvoByuWm1xYslFeXJ?=
 =?us-ascii?Q?ZnjA5AbrPcKVf8Fq2H/qLf8EgcU3/ePLZDMFkUP16txyrcxpjYZuuShrJeIV?=
 =?us-ascii?Q?eFHKbgy0+k4BFVJlhavQIIIbGThekrlmx5DGMZfS3l+W/hoVeNcCzXT9OYb8?=
 =?us-ascii?Q?fyAr0KHvUxoMOFVgwHviedFXUAU0NOEiZB4wSQaMKyd1MD239Z2OAIpHWb/+?=
 =?us-ascii?Q?8fotG0vBSn1/jKVl5eKN4EMlLsVwGNqTJYm4pMwSzIJSB+ZrYlf27ysQ9eWe?=
 =?us-ascii?Q?c1G/KoJe6KlMLfoWpDGSvrlvZfeeElRVREUkQi0m95qktWHGJxld87jFIM5E?=
 =?us-ascii?Q?bX/liexc50mwhC52ANQ9+ayqa9RhqwZFxlWJg9gAe9V1sKJp9MihdOs2MhyY?=
 =?us-ascii?Q?zGS8ORhNHL3ZcuI1oZwCTAiy9xJSfM2VG0D0UHx4+lwazfQYr2A4xGtDWsIc?=
 =?us-ascii?Q?OB/J8SBSf/ydOkhlJph2ruotPLkQWnSE2nBT8Z8Zvz8CrJuiLzfcQ3AorFTg?=
 =?us-ascii?Q?jigqWh0j9TDb7cWF5J7rl/TuKOHJrJUre2B6cwiDf9crf/6SVeELB6Um2PSi?=
 =?us-ascii?Q?lrNbnLi38M3XuYF36KuN90W8Rfeb2AIyGXT1Jtg/e/2Iz1lUQkCKqS2rKZzC?=
 =?us-ascii?Q?i2vrOHzsx1bzB9j+SqsKIf9DSP3drrYbg+ZMKYZek9NxsZGEVSLMH9kiir3j?=
 =?us-ascii?Q?faM4bYmgh1cn7a2DmHGQi6I7bkdoAEvyo5KRo9UeUkYM+wKupR0vdakEgUtl?=
 =?us-ascii?Q?5ZW7uLjLxz073kABGwg+jZsmM4EVdzr4l4DMH0ebLYiOEvucyzJInwykT2+1?=
 =?us-ascii?Q?5B5XSlp4I5CEmwIrMNYZ3gGzDrAUDo7IlrO69M33FP1ytkjVQtC4dRgQbnQP?=
 =?us-ascii?Q?RpnfymHHOPgBBtACfzdnuaiE7t9TCh8s/H+OEzeUan88GVKRugf0/PyxcWxt?=
 =?us-ascii?Q?/wha/KPSQ0wopwmN9DGjUe8zty7BmTtUMCpammyi2NblP6lYoCcxPg2m4ekC?=
 =?us-ascii?Q?GBi5fpmJCMu59ai4UDriDAdHlTlpiqrrc1qoe4Gtnk5TLCQpn9Oo+lYj96uR?=
 =?us-ascii?Q?w+2vqe/Cxr+7sRX6LzBsE1w3IxTlXFX22Yn6IUg0lk4awQrcykAOb49UQ9sG?=
 =?us-ascii?Q?aqnZjna9vQ36iAm2Z29eUQtveqw/knK7v6DHRWhyEidOSOmZfh0K2gvvGNvP?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab7024e-b955-4507-4cb0-08dd8e03f0c0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:42:53.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSvbhoo4h0sG3+2D6A1CFEcxzWjD0FsNtDI/+7qiMfF2P8CdlnnZ4sl04dJVi84kQa2M+8ex36ji4+EclOQBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF740777B0C
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_NOPTI" on:

commit: 25efcff06654aa283be379420e8b1f8d344c2f78 ("btrfs_get_tree_subvol(): switch from fc_mount() to vfs_create_mount()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 08710e696081d58163c8078e0e096be6d35c5fad]

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	disk: 4HDD
	fs: xfs
	test: xfs-scratch-reflink-25


NOTE
sorry if above xfs-related tests cause confusion. as below dmesg, the issue
happens for a btrfs partition (label LKP-ROOTFS, which is mounted before
testing for various purposes in our bot process)


config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505081540.3f2a6418-lkp@intel.com


[  154.907294][ T1546]
[  154.943247][ T2459] BTRFS: device label LKP-ROOTFS devid 1 transid 3324 /dev/sda1 (8:1) scanned by mount (2459)
[  154.963798][ T2459] BTRFS info (device sda1): first mount of filesystem 276a1e11-946d-4e8e-902f-6037a50202d5
[  154.974415][ T2459] BTRFS info (device sda1): using crc32c (crc32c-x86_64) checksum algorithm
[  154.983406][ T2459] BTRFS info (device sda1): using free-space-tree
[  155.158064][ T2459] Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN NOPTI
[  155.170763][ T2459] KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
[  155.179430][ T2459] CPU: 16 UID: 0 PID: 2459 Comm: mount Not tainted 6.15.0-rc5-00204-g25efcff06654 #1 PREEMPT(voluntary)
[  155.190880][ T2459] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0009.2311021928 11/02/2023
[ 155.203187][ T2459] RIP: 0010:btrfs_get_tree_subvol (kbuild/obj/consumer/x86_64-rhel-9.4-func/fs/btrfs/super.c:2065) btrfs 
[ 155.210334][ T2459] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 97 04 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 73 40 49 8d 7e 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 74 49 e8 a5 9c 76 c0 eb 42 48 b8 00 00 00 00 00 fc ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 97 04 00 00    	jne    0x4a8
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df 
  1b:	4c 8b 73 40          	mov    0x40(%rbx),%r14
  1f:	49 8d 7e 68          	lea    0x68(%r14),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	74 49                	je     0x79
  30:	e8 a5 9c 76 c0       	call   0xffffffffc0769cda
  35:	eb 42                	jmp    0x79
  37:	48                   	rex.W
  38:	b8 00 00 00 00       	mov    $0x0,%eax
  3d:	00 fc                	add    %bh,%ah
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	74 49                	je     0x4f
   6:	e8 a5 9c 76 c0       	call   0xffffffffc0769cb0
   b:	eb 42                	jmp    0x4f
   d:	48                   	rex.W
   e:	b8 00 00 00 00       	mov    $0x0,%eax
  13:	00 fc                	add    %bh,%ah
  15:	ff                   	.byte 0xff
[  155.230675][ T2459] RSP: 0018:ffa000000f4cfa48 EFLAGS: 00010202
[  155.237047][ T2459] RAX: dffffc0000000000 RBX: ff110010e271aa00 RCX: 1fe2200036ed4404
[  155.245329][ T2459] RDX: 000000000000000d RSI: 0000000000000004 RDI: 0000000000000068
[  155.253614][ T2459] RBP: 1ff4000001e99f4d R08: 0000000000000000 R09: fffffbfff0ef4144
[  155.261897][ T2459] R10: ffffffff877a0a23 R11: 0000000000000001 R12: ff110010a6ab8380
[  155.270184][ T2459] R13: ff110010fdcb8000 R14: 0000000000000000 R15: ff11001089c122e0
[  155.278469][ T2459] FS:  00007efe6004e840(0000) GS:ff11000cb7444000(0000) knlGS:0000000000000000
[  155.287711][ T2459] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  155.294608][ T2459] CR2: 000055cc21afb098 CR3: 0000001099c7a003 CR4: 0000000000771ef0
[  155.302903][ T2459] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  155.311194][ T2459] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  155.319482][ T2459] PKRU: 55555554
[  155.323337][ T2459] Call Trace:
[  155.326929][ T2459]  <TASK>
[ 155.330164][ T2459] ? security_fs_context_parse_param (kbuild/obj/consumer/x86_64-rhel-9.4-func/security/security.c:1387 (discriminator 4)) 
[ 155.336625][ T2459] ? __pfx_btrfs_get_tree_subvol (kbuild/obj/consumer/x86_64-rhel-9.4-func/fs/btrfs/super.c:2014) btrfs 
[ 155.343515][ T2459] ? vfs_parse_fs_string (kbuild/obj/consumer/x86_64-rhel-9.4-func/fs/fs_context.c:172) 
[ 155.349014][ T2459] ? __pfx_vfs_parse_fs_string (kbuild/obj/consumer/x86_64-rhel-9.4-func/fs/fs_context.c:172) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250508/202505081540.3f2a6418-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


