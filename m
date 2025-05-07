Return-Path: <linux-btrfs+bounces-13787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD629AAE070
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2207FB20B14
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A178289814;
	Wed,  7 May 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieE/8e0s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F4289357;
	Wed,  7 May 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623548; cv=fail; b=KMSeN4FP8BljOWOge/8ejRQTT6Rr/JnHXKLnQmmiSQ3AWkcXCTa82iWxorR0aAH62SO4D4yol7y2l16zQu82alM9CBHyigKILkHSb/FL8mVZpGCzPRrFNUkoouAUUInIVmGe5NSVZ1J/2Y2RUh61pIMLOoPXhUGs3hkNc5PJFfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623548; c=relaxed/simple;
	bh=4SeaFVNXi88lA5LrF6jLsuXVakCJv7LCFCTLVjj7a8o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZnjoI57QyeGoWMD44R+wPN43Ry1nUo94I8QFtTsTaSMMRZ5/rH0NwBq27Rvi1IQ2MpTsTIbpCtMV7sbixaU3RKO924GaITeOnYZlxrO/0S3p4lueeFaqd+j5vHiFf5vrhJggqYoU9LlOh/+/aSBThzx4fJXUJsqlJWPG8pl7hQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieE/8e0s; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746623547; x=1778159547;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4SeaFVNXi88lA5LrF6jLsuXVakCJv7LCFCTLVjj7a8o=;
  b=ieE/8e0sBel3Vz5jj8U8VRdsYs4CoML2naRaK/mQUy86f7jO6nsq9GlO
   EzioWAIeRUc1ff9iNet7ShVjPgJItljyreQ5B24CuSNzEsgEo+sv6TeO7
   OvML9Mx4ZO7gUgq6tqWp1ncrM4uuVITRolFiB0SEsgSe4j4jE773eHDHs
   rUho3V2zKmov+9lzMPDWihOuSFnQPMZCxPYol5XvYVVK/Enku6RkZqdJZ
   QVmfrTLr/WF3kfRDE1/Rj4lgY5o0KFEKU0VJB6uTnG+BdoiyadaXs91+9
   niQKNF5A/wv16LOUiTKceOFgmBSYqqKWQtaFtHtZ49oEItLIkyrTnrLAH
   g==;
X-CSE-ConnectionGUID: ELQaVjOnTx6kx55lZ1RTAQ==
X-CSE-MsgGUID: vm+LbMepQ1+4aKofkdh0fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52168863"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="52168863"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:12:26 -0700
X-CSE-ConnectionGUID: zm+d1npkQQC1IxtzfVuDvw==
X-CSE-MsgGUID: BSEAdXEkQyOZtjq+T9YYAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="140793297"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:12:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 06:12:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 06:12:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 06:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni7LPbyLGT4HhwktJugPXNVi+jqjd2dHvh/9/9Wq1LnWMJCQQbH1Xqk+M+I6t96GYT10q/A66WEWAb75n/YYJXW+uG8pGURUZADpR5X2L7d2MhyLVyqZbkWszpPORvO0YI2pwTaEO+F3Qn9HYO2+hklcbaMrm6tHOj8wbx1nk2mMCDtwGdMSEfhFe4IemxeF1qkyy5gkgr8XmdnNBsz7IMufH8mAncIOuOQOmFOLGzW0/JFNFyzRLVaknlNgROhqiE30Ueb2JYqjsJzaC4z6blO0SrCF4f+rnaBcMum0HxOuG2SLS6TVgdwex0mnuwJGEcx23Cn6e3JJTFQUgKUZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6eCXcslYi1X+YSuJC82CNFwKhwn8Z0zdeDmXl41R/g=;
 b=BXddl/3yxg00+QMyIqlMDF1lzEDSOD2Vtdx0hyUGL6qcwre+3UWJYc0pIZHP5H+cLeK+4HNOz+zMnnT/QxfQbF0hCIJJWfi+L2+DIvAzEJc6wsBAiC2WjEmv7In3xgG7b/FiXbI5jvTsnPZHp/fi3oC3GPIhEBqM/PQkT9h/OXZGBt/38bAC9N6lJCPN251OedfE5o3i5nPHxffcofqQlLLsTPJk9q6nBuKnZR5TQmP/JxamItV6++A5+K2NU/hQdiDoK5zyhAn5hLftQBLJqztsSMPTgTNA56Tclx8cP00/DKe3Pv4vKJW0hirE/28XytiOrmPpg99cYmXsFjhPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 13:12:14 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8678.028; Wed, 7 May 2025
 13:12:13 +0000
Date: Wed, 7 May 2025 14:12:05 +0100
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: David Sterba <dsterba@suse.cz>
CC: Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, qat-linux <qat-linux@intel.com>,
	"embg@meta.com" <embg@meta.com>, "Collet, Yann" <cyan@meta.com>, "Will,
 Brian" <brian.will@intel.com>, "Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <aBtcJVS1yzUPXtCO@gcabiddu-mobl.ger.corp.intel.com>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
 <20250507124321.GF9140@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507124321.GF9140@suse.cz>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::10) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: eb57ecbb-ccd3-45b3-4b8e-08dd8d68c828
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?na25Zl09m9eSnCNhDtPO9C+1tqjlUNlyr8tntIeOYeW+/WFcJLYLmY+E/6/E?=
 =?us-ascii?Q?vUKbtRqynDJhwFFzUjf1a0cpfY8De/Zrh/K6OvejV0zdWzOUzDYZa1AvC2jL?=
 =?us-ascii?Q?RK68FsSX4codvfGfcSn6THmQlOf/UNWVxaVhrHkb9CwjHPy9q2CI7/nvAqDu?=
 =?us-ascii?Q?XiLnH7vXTB3WqkNAc0eHNn4ndM384o97z17/KSxX16zd35+J2essn/t0nVb+?=
 =?us-ascii?Q?rZ44c7Af4aFUHE23ikPFpDbOzfHcYvK0HE41qJcfW2raCbBtL6zkCzf1YgC8?=
 =?us-ascii?Q?GNUVyNY1OSpIJParjJurBWBAJLTRJpM9ELFubenGttusDWsPxDQ8zPCzIAlD?=
 =?us-ascii?Q?c5dcrPFYmRVNroVLr1NwOCaMDjsqPXXXuwCNxOBp5ir0ktY9T7VCSldacvcC?=
 =?us-ascii?Q?mmTjHwq4aIHSLsf5gKooVu5IPSbEjWqdf5uHqqP78WEv7Di9piAwhu2il71e?=
 =?us-ascii?Q?nxCJfTu3Ln2wFWd3M/YrqECJy/5jidgLm9VC2xzgIluw8/RSv7KTJI44LGya?=
 =?us-ascii?Q?YJIsGwSvjE4x9dAIRt+RHC/vTDJ1zA3LqF/lUTx4ra2EIQitlAFDeM/2DjDw?=
 =?us-ascii?Q?Fwfm1WOqX0+fph85IQ7LzurXN06UGGar1hSN53corPTz/7maHtiC4EwYMCRk?=
 =?us-ascii?Q?CSKZczzBkRE6iNmCsrw7sY1mn+tMRHQaHiKWdj7rdTCYR4iBEyzvt7iwxdS/?=
 =?us-ascii?Q?hZ+sSJAbbm4laE9pyf4i5vlrYHXuFpKWhHFmp549sdhlAcORoI4MXcnamyMz?=
 =?us-ascii?Q?rDWxcF9YbwFwndzDaSVU/DHhaIpF56POeBkzjKcVM3BwZwOQfHMx83YX3dcA?=
 =?us-ascii?Q?nrvmIm42TUN8W05eYiBLC3cM/5/KClL7+6fa9aS5c7qXD1pSbc6b2ARKu2dV?=
 =?us-ascii?Q?rzjpAnOWO/KL8iKZwNyqQ2pXFipKWWTy3FEMTSULWygL6Zi77RAUcIwC9Aqh?=
 =?us-ascii?Q?BeBnth7Z1WIDMCOd/YTXgMiw5gPASP+M7h4KBdS+fDun4jYaVtmibaFsbr3+?=
 =?us-ascii?Q?EscFrATFFLueYN59BMyeuTLMKTWR2XEWlzhZO9IpiokNdRp45UvUfin/KDg8?=
 =?us-ascii?Q?dAbSn+/y+pWoUHMe+wzlUHTmjvFX25ft2b6utJGVi9LNTMrWMeoveruaGIQh?=
 =?us-ascii?Q?9C9vdn1zRGwHpOSxdxSpdtgCZWlsAwc4s9Us49NylC9zMAa3/TBm6Oa84xfJ?=
 =?us-ascii?Q?jwLRPvwyvypPzWzk/+QQn0M81e3SEm9/rbDE7VoLv3cxBfatqTiRDOemAqJo?=
 =?us-ascii?Q?Ww94vlz5hfPCAgwNfoWWPhQwoY4HLhlBzpGNLveSHoc4m5Tz0tIaKSez3StK?=
 =?us-ascii?Q?XfZy19xzrYUwkTlxM4bvwN8FJ3WXm5sb/bPlyR8MM9fRHo2YTbDX3i0R91IP?=
 =?us-ascii?Q?jcmuQmxccOY1o+74epjdLHX4kpQ/7WEwirOABvF20NTcenIpPcbWrG0b1NVL?=
 =?us-ascii?Q?PKm604gCKPg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Kgtx0CxDFzV6u0m2DHuo2Y02bKGSQV3kJX4VxUBZcjeJozd2p9BWHbFUABX?=
 =?us-ascii?Q?4RIvy/ZNzvYAhlBD7qCluGJPe7bC7/BIJ9lNFZhWeLm2Gz0vZVRhCNORbAjq?=
 =?us-ascii?Q?KxyILw4kf2ba+CCWF0JAMhxBchr/SByRv/4xRIrjikvntif6D77byofHuX23?=
 =?us-ascii?Q?IphEMFrfOmVcfs69YLCg65htCqWlWQ+msdAjdDjo/1u7IWhS3rhADZ1eAmjy?=
 =?us-ascii?Q?p1PuaioNZjAb139MV4jh1mmL0D/DDXOS+MIanGnHqRICfOKmoNtqFIW/6YfV?=
 =?us-ascii?Q?6eYT6SvedqECCzL3qa0d+atMYC23hixTk0tb5G2j7I9sB/IMhJnqspThVmNN?=
 =?us-ascii?Q?osgLBxByHDk0PMUO8N+OleWeQpo2kHBOmJnbxd7iZDo2JOG25u8Q8aMunQIt?=
 =?us-ascii?Q?tn0EmDabOBJ7yrwcgS/jRUqzAMUOzoT/OwupT/aFEmcKCxMltKl2nLKn0Ozc?=
 =?us-ascii?Q?oZWUXJfrI6VfKg5PubzIQ9rxQLEYnXq8xCdpey4qTTvF80RhI7P/8aKlXUUb?=
 =?us-ascii?Q?1xtBWM22HXJ76VmERATH7/pzmA7H9W8zdyhTYMZwyMRtd7D08AbX8SoP2ywH?=
 =?us-ascii?Q?d9rsZD5ZTU/RsOQ/oAyoha0k1ltyPSPrhPKOrqt4mVSR+5QWzQp7LlMLtWq3?=
 =?us-ascii?Q?02g8aTFe5giSTbfOEsZv8YbE2WcqdMonPTPOwzHprI9f+N5/hU6xKoGR58E3?=
 =?us-ascii?Q?STNI5ic9Va4Z2pMJUBHiMGWOw+kBszLQ94z0BNpUHC3V1Zdi6EeqZz7ory1n?=
 =?us-ascii?Q?kGddzkX6cZfTsTB2hQcxqMEXgaSDIUDxm0X8tcoDKL+h8ptp4nKgUgm1YHPw?=
 =?us-ascii?Q?uocxRdLO8qfs45dv8l5uEbvttcMEmKkPfAWmSJnF+RdGC7eGCdvW8Uw5plpB?=
 =?us-ascii?Q?FyG0GtmBgTgJxbJXaJwPaCbM9BILObyRmKgG/rCHzID6R94eBPHvo6s8xsou?=
 =?us-ascii?Q?GAd3a50k+EumPPYsGPsvnFjpd3/qacEAcl1aSyUpboOo74KHVnLtPBBVQr/4?=
 =?us-ascii?Q?4Y+WHbLM/jTUFIUC7UxV6TZVSmpbYLsa4GyZubyUIu7S3nh7Y4U6K7M4hHsj?=
 =?us-ascii?Q?+Ncc+IpafkmBHBSFOo93Nejv/D5g71ZkekN4cYpP77Z1hxebtUYAonZFvZ+P?=
 =?us-ascii?Q?UJxTGT1F3IQ4JHYzKg1BO5xxzlpwEFBebEoMekxgl0CjbRN0DlPGm/bvCBpU?=
 =?us-ascii?Q?Mc6o4G9WXY/SIM1Y9fp2F1/cEhajqQtQDDhDCyfa/cvYBI+5etr9qs7nvLl6?=
 =?us-ascii?Q?MwSgrY7i9BYO626hpl+ppnxoesqXLQr4T/sbSs82LlTYHvp4y2KRa5hOFLs6?=
 =?us-ascii?Q?Lh/AKahh+w1/7I4/XKvEDryR5ZM4jism06FTjqb8y5tBTefvpc4i4vpMMbiS?=
 =?us-ascii?Q?7n03U+XIMsxcY+yIv9dcrCRFm1dQfHU1epF/oRg0kg6ReeL4QMemNI4W5vZU?=
 =?us-ascii?Q?t9tVATumuAJ2CPgutKBQFVSMKg+hchuWUaV4olxnpMn0d9reuXq5jgN7bQQM?=
 =?us-ascii?Q?l8rIYydeYSTDa4Ssf23Pzifavx3+88hTAtcLj7xy+Y7Wbr7pBCUULbY3hNGV?=
 =?us-ascii?Q?O4PIe5NNfb4YAx6yCidZeoxDKLlacofKDgbZ/7x+41JJYagtNRjMWwMXqzl2?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb57ecbb-ccd3-45b3-4b8e-08dd8d68c828
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:12:13.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQH286YP8A0MpEUatRKVJZgOM7BpBwS/8spCmGkBgLjyxPGttiehwzSabJrw1ZL8rAicqPJOd0jyMCIq6PobG++mNtSL3lD61MjQVKwHhk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
X-OriginatorOrg: intel.com

On Wed, May 07, 2025 at 02:43:21PM +0200, David Sterba wrote:
> On Tue, May 06, 2025 at 04:38:11PM +0100, Cabiddu, Giovanni wrote:
> > Hi David,
> > 
> > I've resumed work on this, now that I have all necessary dependencies to
> > offload ZSTD to QAT.
> > 
> > On Mon, Apr 29, 2024 at 04:41:29PM +0100, David Sterba wrote:
> > ...
> > > I'd skip the style and implementation details for now. The absence of
> > > compression level support seems like the biggest problem, also in
> > > combination with uncondtional use of the acomp interface.
> > Regarding compression levels, Herbert suggested a new interface that
> > would effectively address this concern [1].
> 
> It seems to be sufficient for passing the level from filesystem to
> crypto layer.
> 
> One thing I'm not sure is considered is that zstd has different
> requirements for workspace size depending on the level. In btrfs this is
> done in zstd_calc_ws_mem_sizes().
> 
> > > We'd have to enhance the compression format specifier to make it
> > > configurable in the sense: if accelerator is available use it, otherwise
> > > do CPU and synchronous compression.
> > For usability, wouldn't it be better to have a transparent solution? If
> > an accelerator is present, use it, rather than having a configuration
> > knob.
> > 
> > In any case, I would like to understand the best way forward here. I
> > would like to offload both zlib_deflate and ZSTD. However, I wouldn't
> > like to replicate the logic that calls the acomp APIs in both
> > fs/btrfs/zlib.c and fs/btrfs/zstd.c.
> 
> This looks doable, acomp_comp_pages() from your patch could work for
> both, the only difference is the parameter to crypto_alloc_acomp() and
> eventually the level.
> 
> Otherwise, how to go forward with that. I think we'd need to get a few
> iterations staring from what you have, with added support for the levels
> and then we'll remove/replace the problematic parts like the numerous
> allocations.
> 
> As the first step, please send an update with the acomp levels added to
> zlib callbacks, so it works in normal conditons with all the
> allocations.
> 
> We'll need to move repeatedly used structures to the workspaces so that
> will be the second step. Once we settle on someting reasonable we can
> extend it and add zstd support.

Thanks David. I like the incremental approach.

I'll be sending a new version that is rebased on top of 6.15-rc. This
update will include the addition of compression levels to zlib-deflate
and will utilize folios instead of pages.
We can proceed from there.

Regards,

-- 
Giovanni

