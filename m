Return-Path: <linux-btrfs+bounces-8762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76970997B11
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 05:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0921C22050
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B6188A3B;
	Thu, 10 Oct 2024 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlNzI6CO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9C188CAE;
	Thu, 10 Oct 2024 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529619; cv=fail; b=qDRJKGrjC4UUL3NoN1ekZg95ITvzyQCi3TeKsMHxD8ad2/+zfp1+0cIox8OT1R4aApWsLD38lIG9ndQqOjVV4sXuXm7lq/U8u8y0b+JpwryRsxvzyiWq5JYKcmeK1o3YYCMGtfZQprbfkBlx/f+FjfNiK4bbHr8AkOXW6vgtFeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529619; c=relaxed/simple;
	bh=lGZko2S/JMWxSLKpzoHbCfOizsi2x4RE+w8Xu0le5/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+ux/kdJJCSCqNkYTl9vbsYAk82nJBkFTOqyyB0J9IKXa9n4BZR+5M9c7XLvJccr+0OFYeX1FFMD3yse9x2sOuCP3MT+4Vx3kZSCGFsmND2hVBSGJY18Kv1F8XVX92WOpNc01PRFdz9ZqRYFMYzjUTYPcTlFpEf5Bbvj90KDjck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlNzI6CO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728529617; x=1760065617;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lGZko2S/JMWxSLKpzoHbCfOizsi2x4RE+w8Xu0le5/A=;
  b=NlNzI6COSMEgUCM79knDY0YC6eNASm58ounzbF/GNa5pvZ1QetgnReTy
   jjaawDNVDUJwuchCl4KUgZRuGKcTNKyvGoVfujef6EwAWtId6pteOm9jI
   jw6Naf2O3Jr7nXErT3P1pu4L4GRnwJoaVROFqsgXtL1sW4dtPNrRuZL8f
   7P/ETQdsdSghWmRkHmw4IR2orSmxQGWCMWAUAiFuQFwLC74Icl8G/9vsT
   Ts4E+xlpPHjpOmCGS0jZ4wta6QhSkhx0U33doWS5jo2FDqtiIDdPuU/4d
   Ycy5j749xslbQuSyVylNt/X7IbuImxHEdPnSGypHSDYovuH1h6Vf0X6Xf
   g==;
X-CSE-ConnectionGUID: 0FQNPCgbQu2Q0dWFhxv+ZQ==
X-CSE-MsgGUID: O9QVp4PWQcug9ioveMpYIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38449876"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="38449876"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 20:06:56 -0700
X-CSE-ConnectionGUID: l/d66aA/ReC1jNIW8cge5w==
X-CSE-MsgGUID: fAG5I3TzRIqvKwkm7lHhNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="81019716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 20:06:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 20:06:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 20:06:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 20:06:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 20:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEedS3mEZ0Suzp+1rBb13fskTMTIRMQ8DbUwrub85YBEzf3woSp40b3r3Z0sPdKUlM0t+cksoPQMvWpwPWTWPUuIIEq9tFP408EpbdoaNWRwISiA7rhb/py/ZWNymaZqXxtPHD6wFrkCVrUzBEcw9/uSJbr4bVRqfh6j/A+U69wKM3SBwUoxxeyPbTSAeMZzrXq3px9pIki8Gv6yzpPoLoBb27BPRcQdR3A76+B4UX82jYE8OapEFgJob57avep2+3zyCZhavYadvwkI/l/o001sinBFZtB2bhbwtNwV7M1pi75JiN9QUN2tF7YOZr5IXhFrusvzXS+M2iIJcR32jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkwsGdQ6Nh9CNTPbSzyI4atMDIXjaOXeL1NJREC/a2Q=;
 b=vnRztkF9RWRC3Dut/8n/CxyKfeeoPxz+u9TQ9NCtAM6PdA5PaDjxyG606RShzxZOGmTIW0UTg97M0tdA/o9fAq0Dh/VrflMGS6PrXA62/pAyAkIcfx4uGVkdt/ePj3RdAAFcxJ7ALKBEbnksdVQrfY+WvUZRreEi/cfpj4p5HWWqWn0sG4l5GMG7tzIQsNHcthZyrqo+imh6756AEtdjf0wZACGgAcZfgGWE8g/kz49fyjHKEJRCMwukNhAlWhuYJKMjq+jMkYXgN3g4fJfnOBX+dDgBqyWH0UReDH+I86OgJ4AaHMUjK6D7rrp3wh2YSTDlJ2S7MNSJXMkIDLcMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MN0PR11MB6159.namprd11.prod.outlook.com (2603:10b6:208:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 03:06:35 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 03:06:35 +0000
Message-ID: <dd13b703-a535-4de3-9b33-0e28fe720700@intel.com>
Date: Thu, 10 Oct 2024 11:06:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
 <4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
 <6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MN0PR11MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: bdea50ef-9515-433e-858c-08dce8d88c7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU0xa2tZOC9vK1plVHkwN1pBL2N2ZTNEN2R2VFl5cGxWSE5kZlUyNmVpTmVu?=
 =?utf-8?B?ZTZUN1A5cUpkMFNoaEpCTzVTVXhJclhRQkNJbmtYczhSWUM5TS9sSTBzMkNH?=
 =?utf-8?B?cUJwcXExQXUzWFNicUpRaVBZVDh4YUVRdk9NeE9ZSUFuSTBMeGttRnJkQS85?=
 =?utf-8?B?QXF1WEhwZEFGVDJpSTRNQThSaFEvdXZsN0FBbVRJQnB6Y24rN1ZXUXBqRGpV?=
 =?utf-8?B?OFY3T3FlKzV6WXV3MEp5RzBBRXhxQ3BEbkJ3ZTJ5Qm8rbmdEQ2FoL0RBOHEy?=
 =?utf-8?B?V3hna24rZnoxM2o3OUZINytTQlNmZnR3VVkzdUxQcFoycHhNcjN1dnpkTkEr?=
 =?utf-8?B?bDhYZ0NNUDhzbjQrUnI0cVNqem8xRVErOExKV05iTEJRWXVSWjZhbzZaWVg5?=
 =?utf-8?B?MzQyOU5NZTdZMDhqSURsNXpaSlRKT1JCWWx6eHFyNmZlQ2hneHd4YTZqNVFm?=
 =?utf-8?B?VE9SaDlhSXBGVU5SaGdMUG9MRWJwUWZ5RmcxTjY1Z0VZeGVCTFNlcU9JV29Q?=
 =?utf-8?B?eXdtZFk0Q0kzUHRIMWRMenIvRDcwMzdSblBTQ0J5M0I5SlF5NUk2TlZJNnkz?=
 =?utf-8?B?eC94RkEvMUpFWUVIU2pyb0tjc3paOXFjcWZMZUNvYkloR2MyWXlsa2Z0SDVK?=
 =?utf-8?B?SGZzaXpFYzIzMjNydGZWSUF1YkFYRksxSFR1aEdCSFpUakVKTkVrSUEyS2xm?=
 =?utf-8?B?bWtHU0xXNHIzQTVKYzR5SzZ1Zmg3aEdCQ3BMald1M0FhalRVY09JZnRqcGxK?=
 =?utf-8?B?L2xBb3JhMTFtRG1NczVLMHVzT1BtRG5oOUkzQ1NJRmU4YnZ1Vlp0NENhUm5p?=
 =?utf-8?B?Nk9LWkQvZFcyeWNDdDdUYlpiYnZ0MnR0dTIwdkxYcjBodysrM2cvRzloUkgy?=
 =?utf-8?B?bzJFUUJ5aFNRWmFtMk5NZVpZM1AvdHg3NDhad0ZlMmgrZ2tVbWttZXBQbHVK?=
 =?utf-8?B?SWEzQmp2T290WU9PUGRBVXJwUnM3SDdZcStxdGE5NmJZN0ZiRjQzVDdTTCt2?=
 =?utf-8?B?NUxLMUJDTFkwY3hVMW01WGsvODBzbjN6azNnRXZGSWFESHE0MFRFUDFnZldS?=
 =?utf-8?B?NEt2c1pMWHdRTkhWRlJXMFp0aXhaejVPd1dwZy9sZ1NURUhYVk82Ykt6dmtk?=
 =?utf-8?B?a09yTGlEZmUzNTd1MGs2bElFTVh6L05HdVdreU93ejhWNGk1RTY4SWNreExl?=
 =?utf-8?B?ZXRzUjNSeEUzWHovM3IxeU85ZGZkOS9MbkVNeVZGQTVFN0VFa3VmVndOS1Rt?=
 =?utf-8?B?dEtNdUZTRXg5WlRkMmFrTnF1ZEJwMmJRRENJRHZkNHhOcUkvTHdzZXkxT3VQ?=
 =?utf-8?B?NDJteElUM2VWWnB0cnl6NWdidjYzcnBmeXV3VmY4bVZqdGk4RVZwMHdmZWI0?=
 =?utf-8?B?VHdaaGZ0bVVJeU1rUWpseW92MHFiZC9tVTJmUEtKUzlLLzNvTGg2emY4U0ZV?=
 =?utf-8?B?YVRnRjFaMVI1bWk0bnBwRkM2Tm8xY3lHVm42M25qeU9EdiszekVWbXRpL3JI?=
 =?utf-8?B?L3ZQRlYxbzZFdUxDNVJpZUZVNXJGOVZyM3FhdURraDlyU2IzSnhMbm85Nmo3?=
 =?utf-8?B?L0pnRUtjZTh3Yzh3RkR0emdNZFI5UWZjUUxkU0UyNy93UHAwLzVQZ3F0RGdI?=
 =?utf-8?B?T0ZRZVA4UHdWczZoNWhPUmhRNGFtRHdZNjliem9NZ3hDRzltVXEyN2JKMGJR?=
 =?utf-8?B?RStSR3hScjdzeXM2TnltQWttNmdYZlVsTytJZktHSGo2SVJ2M01qQm1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hEYnZMNWt4TFZzd1FyYzdUS3dLVmtaUHAwK25CdDZHemZPeG15MlB5a29J?=
 =?utf-8?B?K3JsWC93aXpMMTl6RnVjWTVzN25BeUNKcHAwUHNZU0ZmZkFNQkRVUG9iUE9z?=
 =?utf-8?B?T0VZa0ZnR3c3UENxRGhLdys2UCtObHRmcEhqYTc4RkJkTVlQOFlZTXlMUFdY?=
 =?utf-8?B?endtczZaV211RVRUbUFjWGlLREdJTExWRDdQWmtlN2ZMeWR4cXYzWmJNMjBk?=
 =?utf-8?B?NmN2cjJ4OUMvRjNmYmdpSWd0eXJ2ZnRiZHY1RlF6TmgyRjVpQlZmYW5rOUMz?=
 =?utf-8?B?bVRWSWZvU0pDeVgwbFZrV05pTGpNRHJIQ2pWT0pucXJRZWpBUjNjekVnbUZk?=
 =?utf-8?B?YlJnTkJxejY2TnpkY1FwZnVCM1pocXUwU2QxSitqb0hseE9yNDNlT0YrMWtz?=
 =?utf-8?B?L29ZbUl5dDQ1MXlmdXc3YmVlUDNIV0tsZTc2a2doZlFvMmdnQkZudEl2YVA3?=
 =?utf-8?B?ZnNheHN2SEcrYk4vVitpaTViMllhZURaUE9RK20xdHc1a3E3Qjk4dnZDWDlZ?=
 =?utf-8?B?bjB5blc3MGNhMG04Uk0vU3RPWU96NVlXek5QNi9xLzZvNnB3eFZRR1Y3TUp2?=
 =?utf-8?B?VUMxNjJzRFpWUmFPR2VjWHJqUDFhSEtMMWNjNHF1QnpFQjJVM2h0N00zUW15?=
 =?utf-8?B?RGZkazkyS0FHTHkrS2lNYzd1ZE9ycmozY0YzTWxoUzRuNHZLd3VKQWlhaHlN?=
 =?utf-8?B?a1loUGZ0RGh6TXU4M2piZmdJaHFQVXlwam11M1h1eTVTR0JnWTV0RmNHcWx5?=
 =?utf-8?B?RW9vNndCU01WNEsxRUNMMCtKTHAyaGxYL3FOZW90Y3FzV3FTSFRWUzFLSHND?=
 =?utf-8?B?U1NLbkxmcTc2RGh6L25jK0RRWGQ2MnhRa2hQS1d0UjMxNVZtaVRuY21CSmZt?=
 =?utf-8?B?TXdjN0p5VDVRc2tXUm5pbXpCLzJUcHVGSFEzaGcrNldrU2RWa3V0TG8vWmg2?=
 =?utf-8?B?TnZpZDQyTWJnbnE1cTdpVElad3BrRldyWDF3V1czM3QvbVZTMjdVVlgyWFlQ?=
 =?utf-8?B?amhtZytQWnNvRjBUOEczMnJjOW9TVWR5M3JLRUZ6ZW1nRnAwQzY3SkNSZjFO?=
 =?utf-8?B?SXI2RmpYWkRaS3pyRWZoc3RTTndGVWhyalM3NGNyNnl6ai80ZjdGbEdBSDZK?=
 =?utf-8?B?bkRWanVRcXl6VnBmSkN0WEtJcTcwUkNVOHIwNWkzU3lJQXZLVUVXbTJRd2lF?=
 =?utf-8?B?L2NWaUJGbEVoODQyUFJ3dnhjUVkzKzRHNjE2SXNOSW5rYnZOZGF5bnJvdHVM?=
 =?utf-8?B?YjUyc2cxZGxCTjBRNHNoVEJCZExTZmU0K1hDZE5VMTV6aWVsTzlZZWVxSlBx?=
 =?utf-8?B?MUV5Z0ZZZ0FSTDhnTVZmaEpZQmRCZCszemRranVpVFI5em5oVlRrWitOZDRa?=
 =?utf-8?B?dVNwRmtEL2k0MkRhcm5CdEJlUTAySEtQRDhzNFd6TlFncnErZ3RVclpmcVZV?=
 =?utf-8?B?cU1PU3NKS0g3NTlNU1FFaVFVUmoxS0pwTE4zd2N2UzMyR1pnVDRqc3puLzE1?=
 =?utf-8?B?Z2ttMjk5YXlJY2JmMXJiVVpRaFZCdzFRRElnZ2V4VGVsODBvZWplREIyZzhN?=
 =?utf-8?B?YWpjUC8yZ1RpZnJ4enJibVJHYVMwZEZtR1RPb2RCS0pNME9xRVdoWTlvWG1m?=
 =?utf-8?B?M0w2WGlCcktEQjlTdTFwT2pkK1RTUWFtalNvbFVZMUlYZnhCczV2YnhSbnF6?=
 =?utf-8?B?K3lFbFN6TlAySCtYYnpoRm5KSjEwMlZUZE9rUDRrMjhUMTM1UkF6RXJjQVNU?=
 =?utf-8?B?Rk9TVEJrV2JOTnJTd2s1bmxMbUYvdE9CYjVLWVM4VW5XcStiRXR1aS9IWXRn?=
 =?utf-8?B?eE1kTmJva1dTMEdCSWJodjhoT2V5YXR2T0ZSTTZmcGNORnN3NEZhM0ZOU3dL?=
 =?utf-8?B?U3FNQStQbldXb0NoajhzdXNqZTBMRGdmOVR5YWkzbEFqclpuTkMreS9mT0RJ?=
 =?utf-8?B?MVc2Ulp2ZGhnRDFPQlBHVmkzR0VTdnJxcmFKRWZrbVV3QjcvTEU5Mko4cTRa?=
 =?utf-8?B?aHNMNDQ5eHltQW1nQk05eHR6MEhocXhGZWxBTE5nRTN0OWVEVXZMa1ovelM3?=
 =?utf-8?B?WlhGQllaSkRiYzNQdzUwSDUwalJxcEo4NnZxWXRwY2E5NmVxN1U4T2J6RTRk?=
 =?utf-8?Q?J4Gzhi3H1fpMCOM5k2lXPxJP/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdea50ef-9515-433e-858c-08dce8d88c7b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 03:06:35.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbEq0M6VE7W5aKNk7hHdTGqsitiPGyjr6/RTio2oPBCwypfqVjrYUp7LyxFIdyABM+T7Kov7wW/QKDH/FBto6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6159
X-OriginatorOrg: intel.com

On 10/10/2024 3:49 AM, Ira Weiny wrote:
> Li, Ming4 wrote:
>> On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:
>>> From: Navneet Singh <navneet.singh@intel.com>
>>>
[snip]
>>> +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
>>> +				struct xarray *extent_array, int cnt)
>>> +{
>>> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>>> +	struct cxl_mbox_dc_response *p;
>>> +	struct cxl_mbox_cmd mbox_cmd;
>>> +	struct cxl_extent *extent;
>>> +	unsigned long index;
>>> +	u32 pl_index;
>>> +	int rc;
>>> +
>>> +	size_t pl_size = struct_size(p, extent_list, cnt);
>>> +	u32 max_extents = cnt;
>>> +
>>> +	/* May have to use more bit on response. */
>>> +	if (pl_size > cxl_mbox->payload_size) {
>>> +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
>>> +			      sizeof(struct updated_extent_list);
>>> +		pl_size = struct_size(p, extent_list, max_extents);
>>> +	}
>>> +
>>> +	struct cxl_mbox_dc_response *response __free(kfree) =
>>> +						kzalloc(pl_size, GFP_KERNEL);
>>> +	if (!response)
>>> +		return -ENOMEM;
>>> +
>>> +	pl_index = 0;
>>> +	xa_for_each(extent_array, index, extent) {
>>> +
>>> +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
>>> +		response->extent_list[pl_index].length = extent->length;
>>> +		pl_index++;
>>> +		response->extent_list_size = cpu_to_le32(pl_index);
>>> +
>>> +		if (pl_index == max_extents) {
>>> +			mbox_cmd = (struct cxl_mbox_cmd) {
>>> +				.opcode = opcode,
>>> +				.size_in = struct_size(response, extent_list,
>>> +						       pl_index),
>>> +				.payload_in = response,
>>> +			};
>>> +
>>> +			response->flags = 0;
>>> +			if (pl_index < cnt)
>>> +				response->flags &= CXL_DCD_EVENT_MORE;
>> It should be 'response->flags |= CXL_DCD_EVENT_MORE' here.
> Ah yea.  Good catch.
>
>> Another issue is if 'cnt' is N times bigger than 'max_extents'(e,g. cnt=20, max_extents=10). all responses will be sent in this xa_for_each(), and CXL_DCD_EVENT_MORE will be set in the last response but it should not be set in these cases.
>>
> Ah yes.  cnt must be decremented.  As I looked at the patch just now the
>
> 	if (cnt == 0 || pl_index)
>
> ... seemed very wrong to me.  That change masked this bug.
>
> This should fix it:
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d66beec687a0..99200274dea8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1119,10 +1119,11 @@ static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
>                         if (rc)
>                                 return rc;
>                         pl_index = 0;
> +                       cnt -= pl_index;

should update cnt before pl_index is reset to 0.

the cnt is a one of parameters of cxl_send_dc_response(), that means the caller gives the value of cnt, is that possible if the size of extent_array is larger than cnt? Should skip remain extents in extent_array when cnt is equal to 0?

>                 }
>         }
>  
> -       if (cnt == 0 || pl_index) {
> +       if (pl_index) {
>                 mbox_cmd = (struct cxl_mbox_cmd) {
>                         .opcode = opcode,
>                         .size_in = struct_size(response, extent_list,
>
>
> Thank you, and sorry again for missing your feedback.
>
> Ira
>
> [snip]



