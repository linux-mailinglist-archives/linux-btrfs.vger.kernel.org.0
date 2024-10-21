Return-Path: <linux-btrfs+bounces-9044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7263D9A91E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 23:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790381C22C65
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B01E25FC;
	Mon, 21 Oct 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acJw7sNr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE51E0DBF;
	Mon, 21 Oct 2024 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545427; cv=fail; b=Ifg5t856iVEyjyIOMUJu8NtrSpzPaE0gQs7eRsCs7BibeEYGV5X+pfcF/oafway8D1CAeu6Z8bK0q3x27xWd3Dj1bVmuhZoQ2AvH286COcnTjwaGgAIfIHU5J4HB0Nd7/SirmxiB+qrTEoZ/e8NOd1BloCXvbt2+Ihaw8chfSaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545427; c=relaxed/simple;
	bh=UQqfuWbM8jIAO/a5sBK9nuFo6CtdJVzjnbjc6uu+uFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tNTE/z7lNGphGz2AE5+dD8CdxLut3RMJSQw310fKuI/z2dqU21H4cgEOhbu80f0ULQaaorUrWaaqaohfjVYA2E3cvShsOa4nKI1R1aapL0aj0wV0i2vsgZj8muXNblKkpjwD8Kj4YtjEUGiZ4aqvWrxWsSmLMCeWwnGBthj8Bmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acJw7sNr; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729545425; x=1761081425;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UQqfuWbM8jIAO/a5sBK9nuFo6CtdJVzjnbjc6uu+uFU=;
  b=acJw7sNrsIZfvIU4wBZsNv4V5n1STthZj3JcnQlq7AlhREw1B/XvuwF5
   FVz5PVpExt87ZF8OeGopEhGBM+HKd23uwVOsG+SJQZcQLiI94QrP/bkzs
   stIILUvkBmYfaaZh4PnVfMbGQoTYp9oshKTNhDHyDyFg9Y0PpskhxElPa
   RAGPCU6HwcGIF/4VngPEf8Kfdv3G2zTfb82duOvPnhL4VrzMBv3hAbddh
   m9YTZddDQRY5kUgfKXo/WCzfsjNli+JqGz6AfekfANPev2XFAbb6N2BoL
   nB7z3105SffJFnDiwfyDrTaSbTOYXKqwDgGB8PU9qkO0kOBQ8Nbe9Ae2U
   A==;
X-CSE-ConnectionGUID: 9/BDR0YeRb2woIXile1JBg==
X-CSE-MsgGUID: Vmso2No6TfWcnot7kiP9ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40417231"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="40417231"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 14:17:04 -0700
X-CSE-ConnectionGUID: vpW5hQYITomhcc8gwJhGZg==
X-CSE-MsgGUID: 8E2NUKu8TLeAjIZVGkLlZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79733999"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 14:17:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 14:17:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 14:17:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 14:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM3S+iRnZgZg0g1fO/faRJaXSlfuGS7I4arE/fq3OGdhwE1twKtBauo6xZOG5cbUM8XKM9TOYk3IN/Ltg4YyOWwux5YXlFIR8N01Fsyk47Y8qtZGUkI6cUnnCPCGPdwnOpEgzFm9WX/DZnqwAb3Vf/XcSHuCNfOcZIoIWlYeP/F6QZvBIUxhXYnQvptOJtEFf6IgAh9EK3/hZog9d5LkABIORWQH4rAZDnTMVQbbyE8KCsOInWNeydpbl82VjhdckZ1tLnZAY/LK+9NaPamO17ZFGL66qgMdRRoCZHAMb9o1Nk2IXLZ58I4IYY21y/hEnDZB/Z0POUEZM31lTqRRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NugaxJLC/zeAfULO5JmMEQ9a62LEbuL1Q9BqMWuPsC4=;
 b=jhFX8j7f1Se4+XMEb+FgdGHEAFpMCNsFHeCqXs1LgjjKf0h2knkc4AW4+sfoZSyFULniKCTDAYFtsWvt7BGk4SoU/iYziGMDEv56ilY0OEuVdLzrhT7/lCEZcvCSo6IYxZBkf2IIuc+WGiVtQJQWsASuMEKyoOQ2zam0a0fyhlE5u4DObOcT4EZX31/6RQO9EPH+2tpHFxvHLnaBgzOov5DYa+lymq5VUoHSmdxbwV29K+pGVkudGPG3acKAk/feNKnROOAcWAmTp2M2cif74fgoYlM5ZdBftrqrSxf+Gy+bzmmguHpZLOY107FztVc2s2Z/V6b8PgOQ2NPLTPzrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB8010.namprd11.prod.outlook.com (2603:10b6:510:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Mon, 21 Oct
 2024 21:16:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 21:16:58 +0000
Date: Mon, 21 Oct 2024 16:16:51 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 23/28] dax/bus: Factor out dev dax resize logic
Message-ID: <6716c4c333033_7253d29447@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-23-c261ee6eeded@intel.com>
 <20241010160649.00007941@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010160649.00007941@Huawei.com>
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 8409b88d-b772-432d-cbdc-08dcf215b284
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rqyu+q3PqGIJvzpCsEvC6BAmlb3d5lZvdw881taTlWgbdLTrimyvR/wkGtej?=
 =?us-ascii?Q?D/WM5TDILX/H/24oDQGyjzQvuYRvZplv9tLQKZPEeatPSThyXCllYqP2yJvH?=
 =?us-ascii?Q?k3+uF63c/BHwEwLVohM/wxMw+mNWdsDYXp/DYXyc9LyFCGpSot3TjLkLCo1y?=
 =?us-ascii?Q?fLer2H14sdWzLtp5FQ/vnYCk2d/b4Wz0vx7U50N6faTZqyjl3+93s/i+8F6d?=
 =?us-ascii?Q?l3Zq8zdJZxWaHP6WhHpuudfDHUfL+YcbkbJ0Ffs0xWMF16TFUtSxtgzD7Lqa?=
 =?us-ascii?Q?PcKap9L0MTW+vWSNmlQo4OisSnGecnAJCCMaMUPmNf0HpyMe8qnjdM2NwGPn?=
 =?us-ascii?Q?cqh9MBThGZP0oI0sYkBNxtWSSABcICiK/e8w8y1PCvxAxPwITX0dDs3b/tvU?=
 =?us-ascii?Q?xpxiJD3Npb3h3PUbcvjHplgn6NY33IaHbor+lU/1VLFWVVzhdgCv0X5+YzaJ?=
 =?us-ascii?Q?6QpFYme2syAdKIlmsW54FIp7FAxVVDKssH5yaTnzc+OAc0Fcd88BNCuqk9d+?=
 =?us-ascii?Q?cKqFVC+eNZSkQQBYf426T4ODRwiiZtdyaamfxcpBk/4LG8nJevePXB1v46S1?=
 =?us-ascii?Q?jQB+fFD/fgEIHMqUxq02xitER9WdmSWoq8Rpxr+CaxGt3ShY8UbvA8RcoKC8?=
 =?us-ascii?Q?5PC50XZ53zzXBh4rQJy+ewODkOC1Ve+PcXN5oXDptg+EoV5SWuKLdUqmse9e?=
 =?us-ascii?Q?fsad9Y4EcOAsY/jfPkywvuu726wjSW1rAJPHSQJBWP1/379Nc8NV+ri3ssoH?=
 =?us-ascii?Q?sgPX7aaQBTH5KmwqkWrU1cu5beiFtgILMbhX6HbM/4Ffgf45mOJLRP7LlL3g?=
 =?us-ascii?Q?joSvdrtQms/iAZyeWIMXxDlcFaer4VdFibX+dVB5eV5IZqZNGILfmkdTlM7a?=
 =?us-ascii?Q?lDZ1hp9m2pg7Zs4OAFADkTC6Jc0PjeBL9/tZfz1LxK2xOJFOxJcMjWj2FV1L?=
 =?us-ascii?Q?F6cDeFN/rOgoSuRTyePKhnuiVP68J5LrfXekC6+GL1ASpnk8dGW9F1h89e7q?=
 =?us-ascii?Q?7ZzTVRK6jvcxzlSMyPAC32cmih/oc0++DbWV7OA2CfHRfyMhWcD2udLGI5zH?=
 =?us-ascii?Q?lRyh5cs5KV9DnQt/dEoN4bkQR14AiJsUQe7qt6O/0Yhm7wqGyyMTwKq7KGuB?=
 =?us-ascii?Q?kqcbLd9Q+BREIUq9AbztmF9K5nHkuM9ovXfz+FuKAi9SPotB9LzAEbx6ItwN?=
 =?us-ascii?Q?iyxwuwz53l19fyllCOeYV69ZpcU8X4wc/sDQjQ2d0yc4DWi9Q05BWR8borAy?=
 =?us-ascii?Q?gbwQmpG4yoFMLjIFTyoqVl9R9C7CqhyhSVGcMOnh69yyht9iAvSDqfRyFMrv?=
 =?us-ascii?Q?6AE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUqzMpJmnH/K9eSzWAcIWsI9Rci0+N8UMq4D1J+FbPdR9eWu2gbNspMevnfI?=
 =?us-ascii?Q?2I54wdx9WhoD+ncc/zZXtdmAA2fC83yXMCj3cRuOJ7aLYYsE4IxIA/uVQ4A4?=
 =?us-ascii?Q?9/bmCWOrKTXCKbr9jNvnvfVIOOd2u0+O2fyzQSPzGwINSGjN4ezxtoL7/waQ?=
 =?us-ascii?Q?xZIMXGZlZkuR4jkMQ6yw7+hezFTqfx+rPAOglPj0BV7kULRg2CCq9xT1oZ3q?=
 =?us-ascii?Q?8Eoli1QRp6ZZug2eQAcI2DFEgXtK4OnkpbK6M8M7SVHLQaZRbk27aXWxMoBY?=
 =?us-ascii?Q?Hjxe0fcrX+30M0re0OW2CVQqQ0MpVPAXUQrU7A/z+fnRG5Xt/UUC0TiHHt2/?=
 =?us-ascii?Q?FPPpTPPcJ9KmA0WL5xt6Hll/voGPK9npCFUSxhaTT13D39SefPVkgVKlUH8H?=
 =?us-ascii?Q?Dbf0iKnrz36zRIs2wdWXAH71+4yBKhB1crpzGuR1FYwA5fibHSmXIo0+VoAr?=
 =?us-ascii?Q?+FTjL7wYNel8jOiZzOmqPOthZNnAdo1i7lif401UYaPjWeng7pAQ9Sd4haht?=
 =?us-ascii?Q?7YD/cuWLik6E9/EJWkemyCO/23h7absscbFdJs7kmJEd43kbVO9SOoMIraAD?=
 =?us-ascii?Q?OdVQn+RDlidz1l65UC/WbmdjTl+pXnSIgOXYaVIv/krbTgXE7cvJEkDTXK1J?=
 =?us-ascii?Q?99XbqxKCDIheIrgm9nGPQM3mvTI7Nws+rPN/EXUDuJ5QnAR8c1ytc6MNXdbm?=
 =?us-ascii?Q?NbNmEu0eN4gqAq8acwn2kEHS7kG4m0YKy+gLEEX55OFdjyD3uP5ER/s0m7Yl?=
 =?us-ascii?Q?O2rt5fndJTiXnkxGbg3/HAjD1A6g7/KxFqapkaMhhlzzacQqmLv6Vy6mezUG?=
 =?us-ascii?Q?bGne0mhrLjJrbnVQg+Q1GoTRuUzMagPdZh/dS+YFnPOrpTejGHnmIvNQ/9xw?=
 =?us-ascii?Q?Tq9SJr4YShtUxJ4tsvE8+PSmFystdg3tccml7OvjMCtDS05Oa3VYCaxfp94T?=
 =?us-ascii?Q?mRi1KHb0txCMWgNULXDBtBgUgy26fPmcD4k9nEgjLWeEaWg1Z4phbXvDhyaz?=
 =?us-ascii?Q?9aVsEgSgWWbK4i0GYTgwzecCbcFIgKUM8JK+FO3DQeS3Hk6JKdwHuiajLIYL?=
 =?us-ascii?Q?n3lFGp0GTO2sM+LsGhyqXgjIVj+/mgMw/MBjEPo5ElzD8w6pIHGWBqrYU4UR?=
 =?us-ascii?Q?gGS5+m9/58ZyxP10P+eLo8RujuB8jG0/j39q47PQrclFJ0vLMhgh1i4TSjcp?=
 =?us-ascii?Q?9x1n43oRkOtE3E3UhU0/YEHCuWi0xOmDpqpbqGpel5M8iAURXJJYpVft8JaY?=
 =?us-ascii?Q?C9z5EAEy48adVVWPWiVISk78Gj9U6X8fG126efSMIT51GaOayYRiWDasPAnx?=
 =?us-ascii?Q?/iLO9bKvW39nzPrKgbCN5MIGYtF01Zxb1fNSp9OZ07iVSLEumEGyB1eSoXyI?=
 =?us-ascii?Q?96fDCv1VvNRBfvU6LTOX+lFcgZdexTxKn1eJrvhAyzM+FNIsuXRBJM+ROfCg?=
 =?us-ascii?Q?mc9yg5WF/gGY6PHRp7qmjb0rPo9jLqSggbgIPtDK6qJssu7JF/U2Zpv6MNh+?=
 =?us-ascii?Q?LnSGxw13HWmVTRGwQXw8rGCS52LymMq6uHViGQRas0sRhI3tC2IuAG8A5GlT?=
 =?us-ascii?Q?Sr2fTDmrZyoeClj3RGZLfjxdSUEZqc1k/6pzALBo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409b88d-b772-432d-cbdc-08dcf215b284
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:16:58.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axZQNdwzKjjRfvS145egWc3Wbajo3yx4Ch7AR1Q9RHXVbe0OiXxZ3m++S3riVPKuWZDAOnSsvk5tDfUZGBOdcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8010
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:29 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:

[snip]

> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> > Changes:
> > [Jonathan: Fix handling of alloc]
> 
> Trivial comments inline.
> Not an area I know much about, so treat this one as a 'smells ok'
> type of tag.

NP

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

Thanks

> 
> > +
> > +static ssize_t dev_dax_resize(struct dax_region *dax_region,
> > +		struct dev_dax *dev_dax, resource_size_t size)
> > +{
> > +	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> 	resource_size_t to_alloc;
> 
> on it's own line.  That was hard to spot all the way over there.
> Obviously this was in original code, but maybe slip a tidy up in whilst
> you are moving it?

Yea fixed up.
Ira

