Return-Path: <linux-btrfs+bounces-2154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B184B589
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 13:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA41F220B5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414612F399;
	Tue,  6 Feb 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpTNUGVG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A012D157;
	Tue,  6 Feb 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223623; cv=fail; b=AehFPyRllAXzdrkdRES0RjXnZSVAs3GGqofpA2gKl7zYmongLhS2UDDKE6VscfJMa2ggQewOljMGgRGQV0SPXZJR1tr5X8zs9cOM7bBctK3j4mQmtrsuaVDXByvfDHoOmxd/frl1x7VYvNvvn5GHZ8idtsvwxgBc3ElJmCeOMa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223623; c=relaxed/simple;
	bh=uxFPBpWxM7A5lwa/aiZaZ6ZTJ6NXMa9W3DLSiSzCC9A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mJSTMjJrBKlw3cKTLUSsMqoiUEPK/v84PgI70YFyAfBDwijPAHFPWH8DSrev92O8q/uDnm+PSi7b4QMGNir56JEvNnywgpRaCRnmaI7FV5aXQmda2I2sNAtPv9GJI1PIQ/hMIM4aCtei3idgXVbmPyRlWNPkslk9R0vZcU+jYig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpTNUGVG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707223621; x=1738759621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uxFPBpWxM7A5lwa/aiZaZ6ZTJ6NXMa9W3DLSiSzCC9A=;
  b=YpTNUGVGPDAoRstY+NU8oKRp32eZE7/L9uYBm9RzBZWONSTPZ3oYQbAE
   jqJ07oR+1E+x4FCBC4yWTS9vKYclC2q7Hsyb07ow9kdL1j05j7UxwfJoJ
   9WmaCCiDK0DHFowuhOfeVJxQXrg6XLncJTcJPSGCNpwIarT/PIi4jmjbO
   2myV7rnmBuLLwYC8bSE4Fs4ph3tSTCEwWkfMMSN5eGk8PMbw7WI60R2ax
   OwIEhZngtNvG/me2qT1ZG8FmXlVUoIT+ULydCQTaUctxC9dCYOD9DBKrP
   iyDr0vMB8B5fzJZg8ctMp528CCc2mdgyo0rLon18rm74wVuRH4wcDfyo9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11474155"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="11474155"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1356264"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 04:46:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 04:46:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 04:46:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 04:46:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQsH6iWnefw33p7WI75HSDU4kPof2sXEoTsFZQxfhO3V/lORZuVJUBDBMZZzv0e/oLL7EESP+gWOJrh7GfvlyYdDuhM4mQPRkyRYpGa7ONiX3V+lHOd6rCxBGMhoFN/S2gfK+c4idZpcZQCN0puFTUuIki8Oi7yOrjKZkmBa4yEFzMAod/DbO4x4jd4yFDQjf5dm3Ntq9se7aIsew9QJik5IDvwsl7IQ7wRasqVl3cA8MXMHwzIMpphiBOrmv2LPRxW3ou4ueXIQapJ4pPsgmtffXGJ/eX6CQwA/wUO3hw1HCArRJu+RzhN3N9Kmk/dr/65hXk5azbh61B3ynXKK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxFPBpWxM7A5lwa/aiZaZ6ZTJ6NXMa9W3DLSiSzCC9A=;
 b=Ao+CFdwz+lQdc7fzGEPQHZ8dVGAGwh/ATkWBH08ok9WkvOJbTPeLZENCKKVjIyL9NkmOdmVVPKsgl/TzJkO4Vt6r2qSeO1ig3VLsAsA9pywwubhvjjmA/vRImlvRCAFhBZRDBGKSZVvnZ+N0m1h8piSlYGPAWr5vErBKUkGd3/SEtfUzA7nC8TJkgYm92jrtDWEG1cVBn/vwbdrXAismUSs7udFLjNgzl3cVM4IDIFbXUP6RHCKCA6DqzoG8ojiBOHlYF8yazFEmIA89UYrObe1nu80B6PXc+cJjKsZT0RlROroKQRkvxaCUehCQcG1mYS9k7Q7Ieu2Ru6fIXKt92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 12:46:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 12:46:56 +0000
Message-ID: <c90e7c78-47e9-46d0-a4e5-cb4aca737d11@intel.com>
Date: Tue, 6 Feb 2024 13:46:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/21] ice: add PFCP filter support
Content-Language: en-US
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andy@kernel.org>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Alexander Potapenko
	<glider@google.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel
	<idosch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Simon
 Horman" <horms@kernel.org>, <linux-btrfs@vger.kernel.org>,
	<dm-devel@redhat.com>, <ntfs3@lists.linux.dev>, <linux-s390@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN2PR11MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1212af-c25c-4bfc-1be2-08dc2711b364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hywuDbWEIgQHvW7KU35u2N+k/UIk0xKMviXnEVVLzhU7aWnb7FdLDCFmxfMxU9ZVfs1VGpdMQzGh7acM1GrLXJK4i/ic3MOApG/HixtFOSMZb+BU062MmCeCQu46YjoeXgi6oB6U1U1lqJvJrcrf4pMho22RwIaVJj/Nm5Ojzi6GFXjm9z+rPalebUPXyUhU699Ro/RrpBUz9WFfBgnEKjpEeHf4hNjHgqMxNlv/wpU9SZlL9ZcX0oAAF1Fax7sh5/Hgxv/j0km/LAGz70+7HxuwcODzRAASZro+/xofuMs7B2zlT6N4tNwoJIJMPWq9W8xcO9RsHjZHJX2HbMVdNtpDil6LLatmiHZDdt9wByLXZqGvn6sxXUUHeZ1u2BTxHKFM3F+vrye8rbqyszayT9sLb+/Icpe8qLFlxiKSmGgznbAzjqMYrIy3t70aqTrbgMayVrjT6kfQgv1ANP5Xuni/uISqmq6D1aM68lnaV7dKzKv9sfNfEEP6B7O/6V1WqFxAgygR3Qv577cikiY4oEZsYx4qFGVVVRlKvKSVPPkgJu+vYJ/ZknMfrQftRRaUe4Ujr5Bp1A4cHNm+6AVZQq/Yj7u9bxSFN9AH/Dx8kGtn9lQiMx4nOSgpksh3s7fVlDdjSkbltAuWcpE0/I+1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(2616005)(41300700001)(6512007)(31696002)(7416002)(5660300002)(6486002)(4744005)(2906002)(110136005)(316002)(66476007)(66556008)(66946007)(478600001)(54906003)(8676002)(4326008)(36756003)(26005)(8936002)(6506007)(6666004)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhYRE9hVzBPRWQxV2d3L3dRMzlBa082UmdlWFFDdFdDbVdnS1hIMnBCdE1I?=
 =?utf-8?B?cExMSWE0dzJrVDZKWEtadHRDOU1NSDJuT2hZaTkrUThTZUtPUjRKQlVrWWsx?=
 =?utf-8?B?K2dHUHBBdFlUelBrbTFTY2l6SWJiV3pwNy9SeWVSMWNGbnhPd3FRZ0REWmZS?=
 =?utf-8?B?NDNldUpOeUVSbnhlUHlrbE5mY0Q4ZEozbGtNM2ZCOXRpNVhCK00vbDltVGRr?=
 =?utf-8?B?aDl4RFYzTU1SdmgvVS9WSmcxbjZsUDRyeUV6NnhtVVVSTDNwNGtmSkJmU0Iy?=
 =?utf-8?B?djNOSzJSZzA1cmFkL1VQbWJkNnI3VmNiZEZjKzFxc1NkK2VtTlVBMzBKUy8z?=
 =?utf-8?B?TVliM1pyTXI4UGNCZ0lBU1JTMzVEUjAyQzhOV3VEcDVGaHVtR2c5WnRtS0JZ?=
 =?utf-8?B?Q0c3Mko3UHdDZDV1aG8zbDVLNlcveHRiWlBEY09JOVJwRjA0R1FZM2V5eWlx?=
 =?utf-8?B?ZEhVQXExYzF2MEs3OU1SR0MwSFcxdGJPTVBsNjhlZE5BWTI2TDQ1ekJLWkNu?=
 =?utf-8?B?YjFlcFFTcVZpWThYd21zREM1enBGQTRKOU8zc3AzOVNRT0dIRWpPdlA5SnZs?=
 =?utf-8?B?VnhhdEU5L1pzODMvYmxWUjR4S1UxOHJlT1IzUkZhRXJtS1lVeFcvMGNKZVNF?=
 =?utf-8?B?NzZrblE3T3lYeUUzYVJESDFaUHkxRjh6QzF0NFk5SlFhNit1YTJ3dlBBczRq?=
 =?utf-8?B?ZHZRUjV6ZWp3U2t2dnBoc3pXSUYyTlJaNzR1cVgvL3JoZUl6c1V4aW01OWk3?=
 =?utf-8?B?WTFHL1RxMm83dTVhbCtQcjNsb1dSU0ZyWmp4Uk5IckpXSHVJSkl5VkE5WHB6?=
 =?utf-8?B?N0kxd1pGdzJRb1V4cjV4ZkpZK0QyZUM2S09ESUV5S2VoZUVvOFIzT0ZMejBy?=
 =?utf-8?B?QkdEY3N3anVHdldsYmg5M2JDbXV5a3MxaFkzZ3RqYmszUWMwcWliOGxzejM3?=
 =?utf-8?B?UGJ1OHBoRXo3aWJuSEYraDluZ29zQWdkQ2U4YXMxdHZDZW5TbUJuWjNIUU5H?=
 =?utf-8?B?VVU1ck5KQ3BkdFJoMDRKT3VmT3l1ZnVXK2NobmRIUUx2dDY0U3lPYWdyaVB1?=
 =?utf-8?B?c0g1L1FPVXhMeVBJWk10NnRnOW9qSXRyVUI4eHdEM0ppUkU3V1RabHVXc1Zs?=
 =?utf-8?B?U05NekNuYlBIR0gzbWVTd0pNK0FzbHZxWlRnWmxwblpOdmJYdk5GSU11MVFJ?=
 =?utf-8?B?MnhRWWNTd3NMTGxhdGJzT3dJWmQzNWh2L2hjNFRSS21nM0lMVENTckN6blJ4?=
 =?utf-8?B?RG1Qc2JBQ2x2OEk5RE5kd3JwdWJONmZpOXE4Q0svaTRsbklLcnBNNk1Oeis3?=
 =?utf-8?B?RkdMc2lEQXpTR2Y4Q053eEFmQkdGUTNoUG44SmN5QnhIMGtNd0oyVWg1L3hC?=
 =?utf-8?B?WmFqenIzZ1o1bUxsODh2SEFVM1dlM3RIZ1o0RnFxbEoyWlUvZFQveUJMc1RQ?=
 =?utf-8?B?ODlvNE9rbEVDdkFrVStzZVZITWZKbFJ2dGxWdkw5RkJJSnhobXVNTVZiR21m?=
 =?utf-8?B?S0hjTjFxMWJDcG5mMnM0UzVESlZZZy9JYWNGWmRYd21NakhJa2w3WEg1OVlh?=
 =?utf-8?B?OS9SeG9IZVQrblY0N210S2YybG4xdHBISGwvTWVBWjVyTHRuLzhBMGZ5MXVo?=
 =?utf-8?B?NzBRR01jOE9UbGFRNm02Y2JCcG4zcERhNS9lcXgvRE55KzlWakU2RFdBbmlU?=
 =?utf-8?B?RG9JaU1Lam9xMTR0UnJXMWxjZUNIM3UrTE1uWFpKb3ZPdEZDcjRqeldZcVhV?=
 =?utf-8?B?YWVWNlpoUjF2REdnR1dPZzhmdDlmekErTUtTL2M5b3FTcERRQjV0MFJrajRX?=
 =?utf-8?B?V2N0dVZlYWJaUnYrWVBSV0J6cVU3SThJU2gwazQxVW12MjRDRnlGM1BOcnpJ?=
 =?utf-8?B?Q0JDUDNmMllGY3NaSUR2T1FVMDFLQTc4NHVKVDU5R3R1Uzc4OWhISXZlT2RY?=
 =?utf-8?B?ZDBGYldXYTY3Z0hySytrUWplQlhFRWdySVZnWTRFZms1NnkwNGJDWW4wWFkw?=
 =?utf-8?B?SnhnbmpnYWUwNS9DeEROcnVOaGlZeFVOYXVSSG1oVm1NSm1jeEh1cDd6RzAv?=
 =?utf-8?B?V2ZiU3U3ZVBNc0Z3T2JUcE5UVExwVjFUZFFURWRKUnZ1bWd4Qytsa0lUZUNO?=
 =?utf-8?B?blZzSEJVY3o3T3A1Y25tTldNRHlUeTh4YXZmQnhFYlpyRU5XWkR4UDhJOGhH?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1212af-c25c-4bfc-1be2-08dc2711b364
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:46:55.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgT+fdy1dlMJ4RzSVJ7MQzoHtxVGDGL2lnW4wfKSmciKK0rGAk4MUQ2gadBBVSZBXnrFJHp3uBHq/ztmxGmaVxmr+odOYDv6Vy7QjooEl78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4741
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 1 Feb 2024 13:21:55 +0100

> Add support for creating PFCP filters in switchdev mode. Add pfcp module
> that allows to create a PFCP-type netdev. The netdev then can be passed to
> tc when creating a filter to indicate that PFCP filter should be created.

I believe folks agreed that bitmap_{read,write}() should stay inline,
ping then?

[...]

Thanks,
Olek

