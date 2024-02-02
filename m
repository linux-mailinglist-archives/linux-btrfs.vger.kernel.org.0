Return-Path: <linux-btrfs+bounces-2061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22FF846F1A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F5D1C21F8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1D13E202;
	Fri,  2 Feb 2024 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+trUOcr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331B13D506;
	Fri,  2 Feb 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873892; cv=fail; b=crrQ02uMLhmgNGpB3svvYBcy9EWeOHm8pTo9m6a7yZqD6w45syk9iYj8Dr/L/xTsip98B5fHu1hevwH1Uuz1tawCgfy8rX/fUDzl4Bda+lcH3JBnHe/Utb6l6n56d7w3bA/lezSasciK+1TYZ34Cz/x6vFGNdkgmqJt9OupApZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873892; c=relaxed/simple;
	bh=cZioGB2HtDrsXgG5wz4fFN840drduEIUgNpk7rQWJg8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DzXEDkoDsIjVtK7++sWu9mZl2JyBfKttPyj2snGM9v4kIfHAUFJw5b75YN7FIsx4KFA60LCew9vX//MKgLF1OupSOFlSMJU2vef/BKAI4d6AyFdldl+pP9Z4Dhd2HObFF/4WCODe6d54eZ+atTXkHRCrydontfSouxSsLkSZp6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+trUOcr; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706873890; x=1738409890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cZioGB2HtDrsXgG5wz4fFN840drduEIUgNpk7rQWJg8=;
  b=B+trUOcrVqmTihgPdv+bP4WfTo5jEK88PtkRh77nh8GyEzpRrD8/CkHC
   OBsCIJmJcwkZcStVRkxWInX4U0D4esUemjI0exUSRuOG5Euqy1B6Tg7SY
   lX3WuvAnP7QFfRyXl27E5xO8hDeAiNGJ/szyYoKVD8efq6XEaJ41IIi9n
   QBMkXjDruI1h3DJi6g6/cWzNkizFdeFpCFbYmQOKep+z78aTSOj2jIJCV
   XJ59Kva3WSxlbZkTb+H+ooNPQNb2NRMPTPxp7gdYAFYyE2Nh06Pgus22n
   n2UtX6mu+UtTcR+yapc4zyhZ6Ov03RY+ZD85/olHPUMNcZQT2hzf16t8U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10793588"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="10793588"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="45142"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 03:38:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 03:38:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 03:38:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 03:38:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 03:38:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAfMfP+pVx7CN7xJvt341/fSgTugNAVyU0mYBm4K6T0n+0lxiRsrsv/koZVfeCgwhgXBk9f1RnI2sdb+L2Qman9vHjRTMdSTQgRiotzATfUln5pIuI6yE5ty9EC/4WMSO+VwXbWs8CvW+7lVAxsgVtnNOuK2PJTRs3Cf+qVe8ueFcAd+D69KkTQF5z1Cy/Jq9bhNgT8bQlZNzd9+057HRdbK0pFprXhWSWuYnLFEPlGflXQrGwcXzeDtCl7vfXXpDrC9Q88MJmsmfLvyQgW5hfI5jdARypKkyd/x4w9FKhwLqtDJxMRmG77fOPJO6QErN6i9kdxfPJUXZHhN7/Pe1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M584L8oCKrEJ2Rt2VGppr/AiDCbSayeL6c/cGgHNpHA=;
 b=OuorxP84oRk3Lh7+SI/4pDNkadZqmIX52ga/qs50q0mRy+LJg5NbUx5sxCprB4e/gJx8ctPetEmfg4pbSwKZwySoC7OoJlSo2O6kyxy4ERokt/Np2s++3e8Li7Xgpf9b5tT8rZrVMmEyiPkNbHKAgP0Z9bdssu5eLjGkeLoY5t96SaE0ePacm0McrP62O8EYDYUBezJ2/IHJE3mK5IR4wkpzVGkL43v0sE9wzEvwBrdqhjatobKSOlhXTN/i5fKHm77dSWYq47PZO7LL+GXf39v1yU0RBAXONnVRGVwsELEPnelCZYnCoPa6xqLxn1jBa44dNYcd87ov2L/Ms3cImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 11:38:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 11:38:04 +0000
Message-ID: <694382da-8d3e-4092-8a52-1982f655aca1@intel.com>
Date: Fri, 2 Feb 2024 12:37:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 11/21] tools: move alignment-related macros to
 new <linux/align.h>
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andy@kernel.org>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Alexander Potapenko
	<glider@google.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel
	<idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <dm-devel@redhat.com>,
	<ntfs3@lists.linux.dev>, <linux-s390@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-12-aleksander.lobakin@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240201122216.2634007-12-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fa2ed5-fe72-4ad0-885a-08dc23e36b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1jgBuhuOLBMfiGqailvrlKvqgT+O0JEpP/Xm99tRhcSpkOc/nkzYhjUIe0MKnBkiAfXqCeZw3YOoQRouXhpvH3bEOaXZlVjOu9UCeoIVtzaLkeDm+X42/l93OLcFP8Kkv/anpIFkUoeNNWl+9ZI9iVLNyQEiwXXy3r82D35VR+yx1+U5VfyKpzi0ArXecqnOtp2aFLOpAnjRk99Nb70eqt3Eclr6dEeN9KwFUycb1xkgG5zEQ+574Rn+E78iYkRNzDcGWXzVWHBUZmAnUiv9UMWTydXkgu0ume/m1uxrmwl+cuhGyFqzyFq3hQ68XX8Wpuv3Suw7EXg/lhfGCTbmbr6uAPq1gvXDA7z7zokqLhhW/LotGBus4Mn7N5oB4GqtC+lCRawhm6ys/TXolY1jnsVeAX8toJU4rHM2R/UvJ3UPixF+5/lTliZq5dBAPhBNszWyypmEXZP5ZUUmAM1rY8q24tAZdOIQ6wHtUfq5zHPj20588ynXhzEpi7nRctZ8Vazm9fCj9p4Dgs7+n/z93PjQr43e3tySZkXSkOslP0RiTPaQElqrjTf1W59lBt6PhKz9Oso8HqN2feGufy/vusEIttsQoYCVm9+PZrxR/6cZucQ39cTKAUKzokNHkiWIFlxQTkMjJtgvbCwvbzP7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(26005)(41300700001)(2616005)(54906003)(82960400001)(8936002)(38100700002)(110136005)(66946007)(8676002)(316002)(66556008)(4326008)(66476007)(5660300002)(4744005)(7416002)(2906002)(6666004)(6506007)(6486002)(6512007)(478600001)(53546011)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hrTW04YmJYNElOY1Ixc052dW9MQkFNelhjVHUrZjJWSisxZk9PU3ljRDRl?=
 =?utf-8?B?S3AyUk5KTHQ0dEpKbDhlWEJjTFhEZU9mMitMYmdoZFpGNmtCRDlXMEdkMEhV?=
 =?utf-8?B?K0ZoZEs3dE81QSs3WGJtdE9qK083dWhtelk3WnFsTWM5bFg5TlRYYkthNzUw?=
 =?utf-8?B?UjJrcTBlRTJnQ2RrL3NkNFhZV0N0cHl0c3I0djZLdndKWkduaG5oZk5kbkRP?=
 =?utf-8?B?ZW5UQkxWTm5waExjVnpaNDBZbkRKclFJaUFNUVJRdkdGSURmV21ya29ZRFQx?=
 =?utf-8?B?SXFKZy82MTdyMDE0ZUpad3lUVG5VVndNc1BJc1htaGJCK0NMM3YwRXN2djVq?=
 =?utf-8?B?b3F2TEliWUdXSCtWdnZuOVZRZkloK2ZYVkljdGYyOUl0VUwwOHg1ZmRmcEE2?=
 =?utf-8?B?eXRLUVRmNXFETmtFMTZxb0xWNUhYLy9BdU5OUVRTeXg4SjQ3OWViWmxORkl3?=
 =?utf-8?B?aC81MVZRODRDMTZBWExNaVA1NGs3K2I0dGkxRWlzOTIzbWZMY1hrRW9Dd1hz?=
 =?utf-8?B?SGl3Zk1Gb1g5aVhOR3RNVUVIVzF0Vi9sZHB0YlFKZEVzZHZ1eGRyQkxOK205?=
 =?utf-8?B?TFh4SExJUnN2M05QcU0xbVZpMTljcnhpTVBvTU51TjU1NkdhVlVqY0dpREkz?=
 =?utf-8?B?MjZxbUNKZU9RS0g3dkhaajdUaWk3d211MXl4dzUwdlc2NHFXMnRoTTd6SXRH?=
 =?utf-8?B?dzdldDNFMS9BOUhPR0JZblNCelBrMWgxUEJKMXFTRGR3eDZZakNtQUtSSXJo?=
 =?utf-8?B?RkZwSkZidkJ5MGMrbHRUeHNDeUU2V3d4aThtakI3YUdQM2gyVm9IQ2l0eS91?=
 =?utf-8?B?cDMvS0hselJyeGJKQkRNa2gwL3ovVzRsTVNZNlcwRGRnd21PRjRIQ29kT0Zu?=
 =?utf-8?B?QjlvbTVOalhzdTlzZExEV2drQU1tOEoyd0VxUWpSUGxTcTBwOG1XYktDZC9h?=
 =?utf-8?B?eHFxTEhpZWRQYnB0WnFEU0R5OU9ERGtwSS81Rm9PQ0tjRHBiNUgveUhCY1pw?=
 =?utf-8?B?YnlGT214bktJR0xyQkh4QjAzMDJuOE44ZFBpbHlsTGkwOW0yWU9OWUhGcDMz?=
 =?utf-8?B?Rm9EcytsUGJPOGVlRDJ1RVZUYm5rang5cDFiZVB1aWhjSGtwUlh6RG8waDl2?=
 =?utf-8?B?bjYycXZxVldsWUg4cGtNMUYzSVY3R2hTYml1Vzd6T2dLUzU5a3ZwdSs5NEYr?=
 =?utf-8?B?c0hjcU1zZDRET1RNZEpWYy96Nys1aEFnZ0NYRGl1aEp0ZmcxdGNHTHZYb1k5?=
 =?utf-8?B?QmRIb1J6TTFBRkdEejNSMytZcHhzOC9aNTI4R2JEbTRkSEFnZjZuOGIvcGh2?=
 =?utf-8?B?M0dGRGpUM1AyWlVqOTkwWE05enVYaVRvSC9QQnRaQURuN2k0aEhGQjBRR2dT?=
 =?utf-8?B?K1l2NTJkRDRzMEU1VFkyTDZaV3h1NTRKOGxqMkZwSnU5UG5BZDNSQVVsNVEw?=
 =?utf-8?B?Q09nLzdKbm5NQko5NkF5UkNmOVFycTBDZ3gyYzR3eUpYVVBiSEprTWN4Y2Vm?=
 =?utf-8?B?WDAzelhoamJoMzVJTXZtOUkzN0lrRHBPZTBMQWljVGRMOTU1MEk2bCszMzY4?=
 =?utf-8?B?cExmNzdsdFVpOHlsU2NNSVpTSTV5dkhDQlM3S2JURThUSXVHRitKMm01aHFJ?=
 =?utf-8?B?cGtxRmRKUWNEYmNGdlhnMU4xVGJPTTMyeWZZWERxMEE3WjhDSW9RM1IrVmV6?=
 =?utf-8?B?UnhNME9mZmdBZU13TlhBZFBudXlOQkszbHQraUZvT0FwMFRLS0JmNU5tZG1L?=
 =?utf-8?B?cmViOC8wRUZpS3VwRS9hQ29BbGJ6WmNxVW9ZQThuZ3NGVlBZYkV2OFlLbjN5?=
 =?utf-8?B?cGQ5cVVKL0FlWHdSZVcvRzFuc0lpYXBGTjV1TlQ5eWc5RG50YmxMQVlDSUNm?=
 =?utf-8?B?ZkRmdzB1blc5VXZsUUJWU2FPZEVCc0xDYTlXd3k4SDBTZXZ3UWJJK2xSNnhE?=
 =?utf-8?B?K1g5NHpaWE1KOEM0b25WdXBhREF3TTd4YS9zZnZqdGVTakIya2drTnpFQmph?=
 =?utf-8?B?MVpzWnBZOXFidWQ0cFZ0c2JhVVZvN2VIN2NVRmJtZ09wN1JjR3Z5L0x4ekhq?=
 =?utf-8?B?R2hZSDBGOVkwa0luTHlqcTdQNUlTUnJXTS9MV250aDhmKzUvNjBsYjJlWitv?=
 =?utf-8?B?TWxtc2dibGE0ZndWbC94bGxvTVo5Tkxpb280SG9yMCtSc292SE9SYUMrNVFI?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fa2ed5-fe72-4ad0-885a-08dc23e36b2b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:38:04.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VWa99jho0GVibwLN2kSkXbVoe0JbG4QizQGg2o9zixWert2WkY1RhFpFvsExM0Q1fB13XVrR9MwvvAduzVBj5i3ouJ4YGblQWor7PY273c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com

On 2/1/24 13:22, Alexander Lobakin wrote:
> Currently, tools have *ALIGN*() macros scattered across the unrelated
> headers, as there are only 3 of them and they were added separately
> each time on an as-needed basis.
> Anyway, let's make it more consistent with the kernel headers and allow
> using those macros outside of the mentioned headers. Create
> <linux/align.h> inside the tools/ folder and include it where needed.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   tools/include/linux/align.h  | 12 ++++++++++++
>   tools/include/linux/bitmap.h |  2 +-
>   tools/include/linux/mm.h     |  5 +----
>   3 files changed, 14 insertions(+), 5 deletions(-)
>   create mode 100644 tools/include/linux/align.h
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

