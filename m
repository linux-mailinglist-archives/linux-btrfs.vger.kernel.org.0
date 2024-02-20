Return-Path: <linux-btrfs+bounces-2557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96B85B46E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13551F22BE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59295C5EC;
	Tue, 20 Feb 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0jAkJtH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829A57333
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416310; cv=fail; b=kLyhsVAFyfHNO1lI2GUd1n1TmLoGoYaMNU2rHPbvAv3lc1430BkUoOm7FmmVvF/DWoJS3jwzNGHyHSpX3MPVq9wBEyroUCcGLiobuAHGd2suCgHerHjcDb0vmc2mTyPlVMZ620+oTmti2CKWRM93etHIH6YXz4Q7odBFuO6lAP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416310; c=relaxed/simple;
	bh=gBBP8yJgX7XteCJhp0rdRa8wpArm9e10H7ZryryDXxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DorsMVy7UDO6jSMd1AZESjBB6n2gL89uH1oc9w/6pd+Lc466ogMtDAuw/1V98SKlMlxolXKLlMwmjSk0Dkfheb1WrUaHDSRKxtzWlPy3dSlKgCcvZkjXIo23pdTL/v80NbUCiLhktAZICI+xVJNV2Hfk1+qogXoOMv/Kt2e9QKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0jAkJtH; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708416309; x=1739952309;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gBBP8yJgX7XteCJhp0rdRa8wpArm9e10H7ZryryDXxk=;
  b=V0jAkJtHVm3Kalp1efh3LNBhwQJEKIrV6MrEdytb2NqRV+35KYZAHRmD
   xwdnN5cZnI9rqwVmu17albYvUYM/WMb2rrqTsYiDyfOURIWbsEG5ESq/B
   c9rADtoNgv1X2fs3AwBPYl/xnUOSc9FP4l2t+CuhCPyCxqnceHTeKxuso
   NYgQEgK1CxZ2PzhMJ3gDVTJ58jA8OfAS2OwcA2mIZLXh9wdrM05uKi1Yl
   Ngp/3recx3cmvYhRS7TTMLFmat6qLvvG8rqJ1z2tSwatLhUZuG73w2bh7
   MYtj++pt/JFSmNBfQJo/QlWq+EciJWd6ahWcuwJS84oQ5t3GIuMyTdmRD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2386650"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2386650"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4995108"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 00:05:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:05:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:05:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 00:05:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 00:05:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxYx8sBhModSMPDIuHSGOWT8Oyjp6Yn9OppR8eVaIrTqYCN0dDl60rUbMy8rF+bzXBTBVgxlyk5YoQzmK+FgXRss5nYx2TKVPErQcqX4+G63OUxZGrsTLPvmj7qfkpLH6LBptvGmgBWENSGNucv0TUTiE/UHsksbOYIZkCGM4XzdDAIX8aCMPRJKi8Zwruv/v3uYvh9u2CcLmGRU0o5sWrdm1KfLWJ42UPV5R093gyiikbz5miw3XVyDySk1v6kAjeZdfB5zaJEryFuUPYy/aJpW6L1K5kbFsFTzi7bJ0CpsJH/fbFx13TrqMgPrvq3kg7r1C9YWVkLJkjS0dT74XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkpbAoiXnhSrAXrg2lMvWMAaliYf2KNZNYPG7lm4bmg=;
 b=YTVgdL3NwFwH1R/a8vun/Vxuui7Hr3JMu0spIOlUt+pehmCKGcLAJ5L8xg1r/DpyCYQdkcWw2/Q/japCuwj1Nm35CO9UyKka7W1I051H4H/BekDa1ME30i/VcEYoc6b5WavB1QjjfSwScdgTr4Y3zsvE87Y3xCtptD/EhrLFhoog6yn8SYrj6nSm2yitSXNhiCvMGtx+/ATPz62C1ex6PAlgzBoMRC7kKxHOA8tMlNOfSno9DUjtiX33AqpJZ9lpx4MhvprpCsdo924jqPPxBwLbII6vp/RlxrV3D45g9XaaJgxfJCFdULZqHx3Ecfgd95zlF6JdHqf+I5cGyybnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 08:04:59 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::4ddc:7ca8:9bb9:9213]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::4ddc:7ca8:9bb9:9213%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:04:59 +0000
Date: Tue, 20 Feb 2024 15:58:03 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
	<linux-btrfs@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 3/4] btrfs: subpage: introduce helpers to handle subpage
 delalloc locking
Message-ID: <ZdRbi3gumI2fGhUq@yujie-X299>
References: <02f5ad17b6415670bea37433c8ca332a06253315.1708322044.git.wqu@suse.com>
 <202402200823.Su3xBnia-lkp@intel.com>
 <549a5778-ee2f-4520-9147-f09854a50948@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <549a5778-ee2f-4520-9147-f09854a50948@gmx.com>
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To DS0PR11MB6397.namprd11.prod.outlook.com
 (2603:10b6:8:ca::12)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|MN2PR11MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e00ad8c-85ef-44b0-10f9-08dc31eaa1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: to1n+uG97B0pzzqN25DJaqy69+jGfM3DsvBx0e5yU3NSRQqBrNklDVkDbiKkubvdxlfOCSpcVrBtzukZuzW4R7M5/nyLqA6nv/nMb6Awz37in+iIppk0S0ZLrWpH6XgXr5zD3+nqshdpUqy084oqpux7JnnIFut3Dk8zj0vVlEcGTi+UC0VrJO2u+5XRrkIOGrTXjZsqQC3cGNORfJX5ymVgffrEHpoCRmjYW8RTCrTz029BnOYOv11owIRVwnTwOphkqwvwlzY0SAIEKw8IcCxz12klK1QsCJzdF3jX4laByu3AijznOWYmni61oGKuPxZIP053Nw9FouFBY1HVap4lHSxD1woSKWECPsgcz4iIm8BUQ4OW3UiE/4kd6REz48tmukHXhQOh7JPOltaC3ZWijXLG1unTvKC8zhLpuAd9+r6URRlCbK/kArtxDZNo65rzAAonMm16Riyk1WzcJ50dr3AFqHAI/375vyGVTAmGpdIItkoSk4Kwa+4iGYMl01Ue60JE9SEJtcaqZBVB1vl5pMORDg5VjspXCYvlw2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cThLclUyR0NmblpnUHNuOGZHTHVIUzgvdndtbCtKME1uTld5KzFTVUN1dVE0?=
 =?utf-8?B?U3lONEY5eWhYT1VhaXlZZG9NVGc5emYrVTRKb3ZGa0ZubnR3NnUzV1FLdmJS?=
 =?utf-8?B?azByajVSMzV4MytNeExYTWsyQkpDY2VsSzBRQzVQT3JCY25HRkJpQTFHcWxn?=
 =?utf-8?B?VENlM1U1TkROOVRIVzU3UmY4S3Q0UE1tMU1SK1pnNWU3UnpmMFFGcGVHWGdJ?=
 =?utf-8?B?RFg5ZzdxRm5kSE1BUm5vcmVaNmQxSlBXT0M1bWp4YVpYRmdoTm52RjkrdFZu?=
 =?utf-8?B?dityaE9LcHNWVU92Wk1UcTRnN0ZXWHlsMTY1NE1idWR4d3BYSWdJMytJTlAx?=
 =?utf-8?B?bjRhb0p4RDlQcFFlYW1kNWpabWJaejRwb28rVnJIeWNEWFRua01PT0VRRW5Y?=
 =?utf-8?B?R2tGNTVWajZSR0tMRHlIRlVRSXdnaXBjUmNxdW9aM2NmZ0VhSFhJOWo4Y0JQ?=
 =?utf-8?B?ZW5VSXhnTmttUEJBNW9XK3hsRGJCY0o5Yk5QblVEVksrSnJkUG9YSy92RkFD?=
 =?utf-8?B?dURVTXovT1dKZUZWNExiTkdPMmJ4YmJxbytJckdUZmhnbVJ4UG4vMjI3SjVH?=
 =?utf-8?B?UTA1R2NJclZBemplbUY1cTBjVUc4TmVCZ3JWaGcwSU1uZ2ZSTkFEb1Mrbk1l?=
 =?utf-8?B?YzNrRGsySzFxdFh3MjZOSDZwMTZjbnEyV0t2Sk5ZK2RaSitGZHo5SCsxc28v?=
 =?utf-8?B?V29RdUw3M0NRSlZnek41Wmp6YmxkL3pxOTNnTm1DaE5GVTZBVTJoTWJKMzBl?=
 =?utf-8?B?bDR3anpNZWU2eHVoa2prME1TY0JlTnFER01XS3YwakFQcUp1WXhQbWxQOCsy?=
 =?utf-8?B?Rk11ajJzaXNtU0Zqd1pXTjhCTWNJamRld3dHbWZYdGVpZXY5SGQ4dzJGVm5D?=
 =?utf-8?B?TkVnUlFleENBMEtoeE5jQmNweCtSbHZIQ29LREg2SjBtTzhoTnVPVU5iZUYy?=
 =?utf-8?B?QVdOR1J2YndVQjZ1RU4wSEpYb3hFU1NzNXpvaE9tbDZucTcydlFxTnFVRzdh?=
 =?utf-8?B?enp5Rm51ZlZJNDNtUEdnWHJMeU12ZE1uS2FsUSthVVpFUXVaelgyVDQyZUE3?=
 =?utf-8?B?MDdBUWF1V05LVDVwVlhRQXNLQzhrN1dzekZZbWpMRDZGVVpDcyt3eHVPYUl6?=
 =?utf-8?B?VVVVQktNbnlNcGNoNVlqK2VmQ20ybytrOUV2VG80Q1A1ZkVKV290d2phdGdn?=
 =?utf-8?B?UTdtRlNGM2dodjRYWXJtVlA5UkQ5ZEQ5QVY4eU1KUk8yR05PaWtoUGZldlZX?=
 =?utf-8?B?azFOUFNpckNXMC83L0FUY0FMMzhZSUZQN2M4M0dIT0ZsQjVMZzRncjZQOTlZ?=
 =?utf-8?B?WGdWaTRiU2hjaWZWK1M2UlBLREYxU0hIYmV3RDNrcTFIRnd3K3d3OEJVZHNr?=
 =?utf-8?B?azZVNjVUS3ZFV0kvUnh3NS9LRTgrOENtNGFmZjNmZUhEZGFwTU9MWi9WR2RW?=
 =?utf-8?B?SG00bFJPUUt0L0hyN0RMbGVhbXNFYWU4SDJvNDZNejY4ejF6bWkvTVFxbzJs?=
 =?utf-8?B?MHZxbWZvRlVONE5ZQ3R2Rm1ybTNlNVVvQmpTZ29ZaEJZM1lzc3BzSTJLVTdW?=
 =?utf-8?B?V05MNkczQlJ5NmVvcmRWSUZUTmJhNC9USlFuUGx0Sk5yb0g3Mno4TzFTMzB1?=
 =?utf-8?B?Vnl6ZWtoU0Y4RG5aNU5pczZFUjNxUWVTWmF6elQ5NVJ4ZkgrQ2dreUZVMyta?=
 =?utf-8?B?K3RHSGVOMkxGc3MzbmMxcnV4NGczMVcyaWxpdUkva1pBUzlKTmVhOTY1RU5Z?=
 =?utf-8?B?RTBXY1BLaFZjSVFGRXFlVVRZcm5PR2VPdVJPbkV6Q2laQ0dGTERXUUVQK1Za?=
 =?utf-8?B?SHhYYy9yelFIYU9nUW1TOW1MR2VQTzhicFdyMnRKOWhXTmRZc2NNT1dxZjZh?=
 =?utf-8?B?NjFQU1FnSTBIRU4wRVljVnBWQWJZMUVvM2Jadi9GWk5HWkprNHlnUDhsZThL?=
 =?utf-8?B?cEZJVjRDZVRtemFRaTVjVU5KVEZsVTMrZlVQVW9lOUUvdGo0VWtqV2FGYkEz?=
 =?utf-8?B?L3lyZmRjdmZ2bVNxNkphMG0rb1E0R0txeDBOd21GbUNrRmgya2tOK2ZpM05T?=
 =?utf-8?B?SUNYMUFEdjhVN1l0bllrSzhKMGNBd1ZuNElzRVBEblMzTUFSa3pZUTNkV2cw?=
 =?utf-8?Q?fdR2BJvgkbRm7kZjU+5sonLS6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e00ad8c-85ef-44b0-10f9-08dc31eaa1f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:04:59.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yrx9mHAUm7RZab0LY69d8Uq4ej2BR1h8iGs0wtHW2tbCqtieP5T2xDTUY0zOW/1jUjXGnkSBHH0ZjfaZDxoPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4741
X-OriginatorOrg: intel.com

Hi Qu,

On Tue, Feb 20, 2024 at 11:46:17AM +1030, Qu Wenruo wrote:
> 在 2024/2/20 11:22, kernel test robot 写道:
> > Hi Qu,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on kdave/for-next]
> > [also build test ERROR on linus/master v6.8-rc5 next-20240219]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> 
> This is applied without the previous preparation patches.
> 
> Is it possible to teach LKP to fetch from certain branch other than
> applying them directly to for-next?
> 
> Do I need certain keyword in the cover letter?

Sorry for applying this patchset on an incorrect base. If the cover
letter mentions that the patches has already been pushed to a certain
branch, usually we will skip the patchset and directly test that branch,
but seems the bot didn't recognize that there is a github link in the
cover letter. We will investigate this and fix it ASAP.

Best Regards,
Yujie

