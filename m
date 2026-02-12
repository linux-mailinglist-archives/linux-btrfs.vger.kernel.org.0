Return-Path: <linux-btrfs+bounces-21647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBNmJ7XwjWlw8wAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21647-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 16:24:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1584812EE1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 16:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE39B30338B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FCD225416;
	Thu, 12 Feb 2026 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWA5MtOJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE53EBF30;
	Thu, 12 Feb 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909874; cv=fail; b=JLJWcDFLoSm6aOJ3sU/YleiE3p37qVIhp1u/FtNn/GvTcwPruHUwTvC1ODZ7VRVozk5cfsPbkCgg7wXtJ246h9jvVigYjluhsgHMXrSo4GBtSUJprWAcft8VLySq6cFgnBVvr47HwKwzdBr8AvCnQeV29rCggYsnIe0UxbZNkGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909874; c=relaxed/simple;
	bh=rCV2jci4yRUYafupeSYEWz+xFZhEpZ0zEOIUXg1g9sw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YHLQCYovyANLbWkjzUqRcpAI7WoSXyzuuqhexhXUJ4KH4/HUQjnYrUqtNSUSHHXGN+MVFFSCxXBCOQ3VbObm2cVPH4kc1BKvbl9iPMy5P2aeq8Vm2K2pFBtSAn9uEDvZYYLlocUD03c7L7HtPjHmCoqYxSeLUBiESx5wZd9ffSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWA5MtOJ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770909873; x=1802445873;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=rCV2jci4yRUYafupeSYEWz+xFZhEpZ0zEOIUXg1g9sw=;
  b=QWA5MtOJtrm9HJq+ex1I1C9kN7hDJpNtJUODvHNtJGreB+eWRojQwE1+
   76f8KYaXNHjfOGIx1uU46q7yW+TboFwL7gHPiq0MHwRn2HYfcXrSht8Rd
   f+tSsOZBqS8fD7X6Nn6jdDHjydfVDlI9wPerP6IGSXAnHyUalVWI4NDrX
   PGJ4jF9jqrIaRXgmAJ8A/SbYJU+Tfxoz9GwADzDMRS+y9bxboHf4xIc07
   2aPwxmoC7nMABA17nScTUmkjKxK1gG9bSV+PFujB/7tIgeUYbhrSya5Yl
   v7CiaFKDDqcQQADPiG3/fc74L55RPWC8rM2yX6NN0bRKWs0/dFj4kWD7L
   g==;
X-CSE-ConnectionGUID: IDrdErbSSV6mhX5D7+W43w==
X-CSE-MsgGUID: YoEMNNkfQ6O7FDGv2ZQN6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72129615"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="72129615"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 07:24:32 -0800
X-CSE-ConnectionGUID: qaCZWMPbTSyLeTuH0zD61Q==
X-CSE-MsgGUID: r/o6hFCmRWWY13MJ+41RcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="235610221"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 07:24:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 07:24:31 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 07:24:31 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 07:24:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtzxePXCQexNgzGFvPdlMvD8+LraqXAEt9KF6NWn2lIA31ajvI3tSjhFllJlWYYWy8clA0/On1xaMEmg9zZQW01SziF3n7PXvk5khCvZLwt1DbR5h/PanXq9X8mkv/RZ41WPV7I73IWxQcIp0mUr5XQamYHqiXPBePbCxXRPJgaoG02KxwEyUYYL9IHOhkcJkwajw4keiuIPewI5T2tIym3NPsk3IsfP1iHSkzy83nr3D8C8nZnejsJhFlpOxKDkva5e6xnovfGu5LKTYM2EJf5qVjHfokmTHGrLHXrKeWVBVneZDRG698hRJie/SzzHAq80WLe8E8gT6ITOkuNGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEz20eAZQtf74IN1ok92e6327g0z2m3t4VvoMqOQVyg=;
 b=v58mEu2bHidapAC3Yty7PZ0dAcOJK5ZlUCH2NLuIvGKB0V7/9k4UrZp80r1ytA6096ZWoVQXC7RmV5z+8uVMMgdtQF1fCcGtktV9SuzEvoT4JNobKr/7KMskwtKUPvYDTo9Knape2dfbFgsTU11k2ctbb4/SOW7JOOXrSPp9FHroNaGU9UtXpH7iyDHYUs2VTdgLE7fWSBQlqXwUnWWzPCs++bWCR5qfM1HNXwZXdLQfklYclh6WKMgfSgZljX5ttZqWemGMktyPt61wocs0ooKOYCS9HGjfaw6QB8Lr5A/tZ2YoY6bplSPizowLOlP+3ELpdNVpsd4caZEZ2Vnfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7799.namprd11.prod.outlook.com (2603:10b6:930:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 15:24:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 15:24:27 +0000
Date: Thu, 12 Feb 2026 23:24:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>, Boris Burkov
	<boris@bur.io>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  4e159150a9:  fio.write_iops 6.5% regression
Message-ID: <202602122319.d71b793c-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c16d260-2c34-4a58-3a8d-08de6a4acfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?sZELMR4ahsXZKrO4NfuOxKAgqnRd3cvpZhMeWZ7t4jJJKAoCcYtQM0268O?=
 =?iso-8859-1?Q?wIh9MWv+RCb0V63xqfC4HaUJT7EqJiaR5ya/ISDJVOPCbicgm+P7ttpdaD?=
 =?iso-8859-1?Q?THa7GNllGfBZBMEXCUMel8eEBAdGLiZ9vJtwwHE5ESI+ljoCJivaPGZXAM?=
 =?iso-8859-1?Q?JXkokrH5rDdorOGrX/F2xr8y4gnc+y4/DOnNMGf6jOeuhTdT7oQH11lr+p?=
 =?iso-8859-1?Q?rWzJ9VlkIJQTYf1OnKk1IPrRtjVH+vl8Gj+3Mn45yQMVEpNAVEY38uy6le?=
 =?iso-8859-1?Q?6A6JashUoIcwVD7G5yFhfh2hqevAwMHOZYteb1zX+E3L0M8vE/a3H7pmdm?=
 =?iso-8859-1?Q?3NVprnE5YH3k8FjDqq1XKf5rslHLQfeTpwuOVnodexS9zQDkwQQIhRFhwy?=
 =?iso-8859-1?Q?1Y6zXzIwXShwpcvIv5YDAYohGWC1Y6BMv1HLH3IF6xuDGQjlc85OfrZkft?=
 =?iso-8859-1?Q?vVgoObaY2aAKAZiLxELqhoaA0kHauFYijjtIs2QH6XCk//UldPz1Q8uhWb?=
 =?iso-8859-1?Q?o3GIereyHv3JmvQXuK1g7+eeWU4+QnAi94aj4i+MYlgnk0uQHu4IfOw5TR?=
 =?iso-8859-1?Q?ODfEtAVdbRpS5Lc6qGFFDAKbsjJO5vIQYMVC8iN76p50tht204GWzFKMCs?=
 =?iso-8859-1?Q?awChyfhMzfPaWyUReGklSjwcmO7ZJ1i8Y+Tm+x2BCyRFWG2BOMWk0CwlZC?=
 =?iso-8859-1?Q?DELtXkxVXl1f0Nj8cYy2QfoIlTqLKcmKKbUwo1hkWvG18myJdS1RHPAYaC?=
 =?iso-8859-1?Q?DnpO0tpYq54LWfr4tpxRdW/FdyQo6ZS7w4QyPHtUVORqlQ/8JG1QSq9V8b?=
 =?iso-8859-1?Q?6kqLquRvwv4jh0S5STp88T1SccHvuLBdvAc5zpBg6IkiTABlKgoxgLD1UI?=
 =?iso-8859-1?Q?2VB+eBjdPuoNPkb9TTBDh1MeJ8qtn4Z7ifetTaBe5ei+VFxUVj6q6REaIF?=
 =?iso-8859-1?Q?5AnyPtr8XvAqQygY18gCkobbTPoJdPbVNqXbpEf5Guk1c4mQvexKa31vYP?=
 =?iso-8859-1?Q?xzLciQTY4g/C3xbUf+rHP0XGFWPahtC49DK1Y04aaeZR8tYLdYV2TlbySV?=
 =?iso-8859-1?Q?XGs0XGwnrRW1O1eBGHrorlxv3hsMuzQWlUkl6tbEf40IfHbDrgU+Slqvyi?=
 =?iso-8859-1?Q?p5TykDyPhnn6TFNCNzkWaZaubDQCE9T7BP6zM9hBH8bAVXZ9EULLZMkJFu?=
 =?iso-8859-1?Q?5IKXHkqV0shPQhNwucMPC+wS0dze1ItOGuPbkqgVxVQA54hEpuZOtrpJiF?=
 =?iso-8859-1?Q?MkGmBZ8l6VM7N/bM4t5RKbv/TA07VaaXo89IC0d5n/pouS2JTOj5HA2AE0?=
 =?iso-8859-1?Q?nGfbcsVj5woYCamKPXgMfFwOSlVU7NB8iZCl6Q5M7RyueUGE4uCOaU+trH?=
 =?iso-8859-1?Q?uCVIvEfNGSDPxNZJevx5UjOMQQCsyuB0sj2trc2/o4DS5lnAeVx48Ex0DT?=
 =?iso-8859-1?Q?y6kS6kP7ni56XrqzDhaGD/iWFh8lOiDoWxgTaVavWdbP5lRp0n95dWDkt/?=
 =?iso-8859-1?Q?gJWh8XIApt5elulau7sz/Oi0zZsN1yPUAsp3MCH8ObO9US+7JcIAtkVvqd?=
 =?iso-8859-1?Q?TRpie333TlLvjB4G6jsn9i9omu+qbQMCqbiMlYbk0e0ipHyxA6UAr+EaiU?=
 =?iso-8859-1?Q?qn/9YSSNDBkbeMFULcVINq43K7v69W6OFL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+Z4FE5oXu9CzbiEgH/WjcAzZMgAda2KmcEasOqr2IzfcKEiSWCwWuiDkwq?=
 =?iso-8859-1?Q?RjSmNUO6nEUixsaiXVirVPRvVmafHMtbttHLjCHT5INmvtly7/Vi01Qc2u?=
 =?iso-8859-1?Q?ObKY0vS66mVXAQK/I/QPpNaSLnol9ZvfnkWmUXqCvXPqQJd4+hNutYWLGx?=
 =?iso-8859-1?Q?jLt+OZp5273W8KxAB2fWkEmbj4VS5qWQLyLsXhbruVwrW0ATEM+2S83zo5?=
 =?iso-8859-1?Q?qRPsAD+0FTdzRUu0QjzaWCX4p2fXm+5fLnNoyM490icFbtQ/3M/iXbMyOO?=
 =?iso-8859-1?Q?UgS4AFTtPJPKh9CcZvBmGEwSPktxQpCwNJhUjEcFk3PwUYOG1ltSH089yY?=
 =?iso-8859-1?Q?u9/8Vu5iAy9ZD4oJG12OOv3IGzQRDG3+YWoAgsrK0wbRX6Ir4jUWg29Mvi?=
 =?iso-8859-1?Q?eLcZiwKtf7Yto/eU/wPYk8FnnW+O7waSKyNihTUjMa6NpxGHxhJz3ZaFgY?=
 =?iso-8859-1?Q?a6ttSmmUYA/FfAfqbG1I2f19sHelI06NvNhedODehY0hcIPHCxaYZhcgIR?=
 =?iso-8859-1?Q?RCy4bej1CvT5hovF/0SkCkM9hKDK2CB8/LHUCmoK8NGrwSxIAKg8nBjHGC?=
 =?iso-8859-1?Q?1Yw2vepq00Fy/64896WFNuSHqxEDwOVmml3Y5RhhnpzAOTM6+1O8zOqcAQ?=
 =?iso-8859-1?Q?hZZN4/rkkuwBjCLhkq2bmgHgFs7Ib2BlHuli4wPhf71C2yK/i/F5BNifo0?=
 =?iso-8859-1?Q?ecDoW5Vw08zGxy1l7s4z29KMuPK1AGRmqbRBuKZTvYyFT87G1FbK/ovyOb?=
 =?iso-8859-1?Q?rnFvvBC7YA+GPEPprGUY2qCaa2RpoGWePRGaxt4m/GkDoy2OxbFjPtWrs8?=
 =?iso-8859-1?Q?ukvrP/l4GUqMlN/6CV789JAOe8wW5HVlHlqofXSjZqTuIqWNIO0rQ+V2iK?=
 =?iso-8859-1?Q?QbroygvODG7OHziglgMwOTpkShYqdCAgw+pEmLjma6lVjn5v/WtTVOQQ1u?=
 =?iso-8859-1?Q?c4iU1jZgcyD1+jew8hpfMLyxbyGmeNej6WIKcjJdMj975VzGvS6WnDNGT+?=
 =?iso-8859-1?Q?gGVTOteZru60IHoOEOw0v9ZrCiQYnme6oc+kQzpvX3rhxoslhmI/QF37QT?=
 =?iso-8859-1?Q?38j0JGWXxvMW9Mly3EQd/+t7CGFT/kLzaCjmtlj4+G3ZYWpZG2zKxixeRc?=
 =?iso-8859-1?Q?+jQscBLG5XnZ+lGUF5g/i4TZh+DE60n/hg4yzBPMes6AeadZ5N64tU6Ymy?=
 =?iso-8859-1?Q?APK6YaeKO4+IT83Ik0j6mNSA46yTZ7YHUtyW4qwPBPKFPOkoxpSjv9bunS?=
 =?iso-8859-1?Q?eJPy1WuZo1BYGUNJPhdIVCRlkFTlwJJO9EN+e4+u4XiOJIiEa2bOrsw1fx?=
 =?iso-8859-1?Q?yxnMpV79xbKqauFafDJF+4KeKHIw0osNs/eL1cRo5lVnZSHxMbyitUSBz9?=
 =?iso-8859-1?Q?qwSmI48zhqaqauuejfJok1rDE5OehaQtPCwqKUeYwhn544sB5R3By+J9nk?=
 =?iso-8859-1?Q?AnjyPck3ZDJMeRRSydiy0T+xwF+oPvpulfDtR1+31L+gPEke+UeAVN1ulo?=
 =?iso-8859-1?Q?WCPEcwdav04biBLPIYwBp35TupFYl7zxu2XDQVdQVSRZJyWB9BO4rMH54W?=
 =?iso-8859-1?Q?fxlIyuorCKeHrCa3S/WZpd3003oIXG8Pr7O8PDyd2ozr6WChVy8iBjyM6D?=
 =?iso-8859-1?Q?jI8U3mp1k1hbRMgCPS42IzkQfsSO9N8mmDBXFftp3K7teTsEA6WhBRWrIA?=
 =?iso-8859-1?Q?XqnR/cR5uHsi5iF3vK+q2mg8OHCXYTbaOYBHvePLP2/oK5Y9NOynY7bMj1?=
 =?iso-8859-1?Q?EXycbWQBx9saL/HyFP6133FNLx6Rj2K1fuCapEw0ocsq5pR033Od81Tnbi?=
 =?iso-8859-1?Q?3NxsNoIm2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c16d260-2c34-4a58-3a8d-08de6a4acfab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:24:27.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8TevhoOiKEhe1u0jkCpLS9MmnYeZUuZLcJClpZwNqebluJdQ1VfBdzswg6qo6TdLJJ0CUzF4hLVFNyOyEGUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7799
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,system.in:url];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21647-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 1584812EE1F
X-Rspamd-Action: no action



Hello,

kernel test robot noticed a 6.5% regression of fio.write_iops on:


commit: 4e159150a9a56d66d247f4b5510bed46fe58aa1c ("btrfs: do not strictly require dirty metadata threshold for metadata writepages")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      6589b3d76db2d6adbf8f2084c303fb24252a0dc6]
[still regression on linux-next/master fd9678829d6dd0c10fde080b536abf4b1121c346]

testcase: fio-basic
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	disk: 1HDD
	fs: btrfs
	nr_task: 1
	test_size: 128G
	rw: write
	bs: 4k
	ioengine: pvsync2
	cpufreq_governor: performance


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602122319.d71b793c-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260212/202602122319.d71b793c-lkp@intel.com

=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
  4k/gcc-14/performance/1HDD/btrfs/pvsync2/x86_64-rhel-9.4/1/debian-13-x86_64-20250902.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic

commit: 
  3430818739 ("btrfs: add extra device item checks at mount")
  4e159150a9 ("btrfs: do not strictly require dirty metadata threshold for metadata writepages")

34308187395ff01f 4e159150a9a56d66d247f4b5510 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  25998829            -6.1%   24422371        cpuidle..usage
      1.06            +3.2%       1.09        iostat.cpu.iowait
      1215 ±  3%     -10.1%       1093 ±  3%  meminfo.Dirty
     80085            -6.5%      74897        vmstat.io.bo
    121741            -6.4%     113948        vmstat.system.cs
     87339            -6.0%      82083        vmstat.system.in
     15.13 ± 50%     +75.9%      26.62 ± 22%  sched_debug.cfs_rq:/.removed.load_avg.avg
    287273            -5.8%     270535        sched_debug.cpu.nr_switches.avg
   1713834 ± 11%     -19.8%    1374291 ± 11%  sched_debug.cpu.nr_switches.max
    418676 ±  7%     -18.5%     341334 ± 11%  sched_debug.cpu.nr_switches.stddev
     47.67            -5.6%      45.00        turbostat.Avg_MHz
      1.32            -0.1        1.26        turbostat.Busy%
  32589252            -6.1%   30597064        turbostat.IRQ
     94552            -5.0%      89817        turbostat.NMI
   6080930            -6.5%    5686530        proc-vmstat.nr_dirtied
    121315            -3.5%     117069        proc-vmstat.nr_slab_unreclaimable
   6080407            -6.5%    5686054        proc-vmstat.nr_written
   7057391            -5.6%    6658839        proc-vmstat.numa_hit
   6991110            -5.7%    6592460        proc-vmstat.numa_local
   7583554            -5.0%    7205949        proc-vmstat.pgalloc_normal
   7342680            -5.0%    6976953        proc-vmstat.pgfree
  24345737            -6.5%   22768702        proc-vmstat.pgpgout
      0.01            +0.0        0.02 ± 12%  fio.latency_1000us%
      0.01 ± 19%      +0.1        0.09 ± 22%  fio.latency_2ms%
      0.02 ± 23%      +0.1        0.10 ± 21%  fio.latency_4ms%
  48595970            -6.5%   45440610        fio.time.file_system_outputs
     25.67            -7.1%      23.83        fio.time.percent_of_cpu_this_job_got
     71.70            -7.2%      66.52        fio.time.system_time
   6108254            -6.5%    5713199        fio.time.voluntary_context_switches
   6074496            -6.5%    5680076        fio.workload
     79.09            -6.5%      73.96        fio.write_bw_MBps
     48958            +7.0%      52394        fio.write_clat_mean_ns
    250398 ±  2%     +31.1%     328384        fio.write_clat_stddev
     20248            -6.5%      18933        fio.write_iops
 5.513e+08            -4.8%  5.247e+08        perf-stat.i.branch-instructions
  21121264            -5.5%   19957666 ±  2%  perf-stat.i.cache-references
    122833            -6.4%     114967        perf-stat.i.context-switches
 3.438e+09            -4.9%  3.269e+09        perf-stat.i.cpu-cycles
 2.651e+09            -4.8%  2.523e+09        perf-stat.i.instructions
      1.92            -6.4%       1.80        perf-stat.i.metric.K/sec
      1.63            +0.1        1.71        perf-stat.overall.branch-miss-rate%
    131286            +1.8%     133654        perf-stat.overall.path-length
 5.496e+08            -4.8%  5.231e+08        perf-stat.ps.branch-instructions
  21055046            -5.5%   19895494 ±  2%  perf-stat.ps.cache-references
    122422            -6.4%     114585        perf-stat.ps.context-switches
 3.429e+09            -4.9%  3.261e+09        perf-stat.ps.cpu-cycles
 2.643e+09            -4.8%  2.516e+09        perf-stat.ps.instructions
 7.975e+11            -4.8%  7.592e+11        perf-stat.total.instructions
      0.61 ±  6%      +0.1        0.70 ±  5%  perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.io_schedule.folio_wait_bit_common
      0.68 ±  6%      +0.1        0.78 ±  8%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt
      0.65 ±  6%      +0.1        0.75 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt
      0.49 ± 45%      +0.2        0.66 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.io_schedule
      1.29 ±  5%      +0.2        1.49 ±  8%  perf-profile.calltrace.cycles-pp.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range.filemap_fdatawait_range
      1.24 ±  6%      +0.2        1.44 ±  8%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.46 ± 45%      +0.3        0.80 ± 29%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      0.20 ±  6%      -0.0        0.16 ± 12%  perf-profile.children.cycles-pp.fio_gettime
      0.08 ± 16%      +0.0        0.11 ± 11%  perf-profile.children.cycles-pp.rmqueue_pcplist
      0.32 ±  6%      +0.0        0.36 ± 10%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.74 ±  5%      +0.1        0.83 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.29 ±  5%      +0.2        1.49 ±  8%  perf-profile.children.cycles-pp.io_schedule
      0.20 ±  6%      -0.0        0.16 ± 14%  perf-profile.self.cycles-pp.fio_gettime
      0.12 ± 24%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.check_delayed_ref
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.btrfs_csum_file_blocks




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


