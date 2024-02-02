Return-Path: <linux-btrfs+bounces-2062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19457846F2F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C565F289D88
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143301419B6;
	Fri,  2 Feb 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgZN88Vj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE4140799;
	Fri,  2 Feb 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873966; cv=fail; b=OQa46ZCif7/qDvV0euuxqxHKV5HRc85OJhqK0RsnuI4g+lE5MaDCmsFodHGv8ZbuDYPbDHCsularyBbCzRT72dGkkYD/atMowwQJ038sE/lD/t3Z1PvdkU4zssX0f/Q5F0cKqYdWpqAFIJlQxUwQ2B9f7GVYW3K2emc8lIx5WS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873966; c=relaxed/simple;
	bh=xkRf+LBm8U5DEanN/lZV3DQwOVae4xDfjQDOjqaI/ao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ch++FQ9/qxQJT7FTk14Ex72phDkxKi8JTI1IebMo+WyUZ7THHvwJd0JCc0U6pDZXLXs55wAk1cx4GebiME1FwjbU+XcwQHP6a1OZD7zQH9aacxhpE0tLjg1hMCdzuATx67Oocmxo+bHCRNh8f8spFXTQE0OEkwpOXwHtV5iKSEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgZN88Vj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706873964; x=1738409964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xkRf+LBm8U5DEanN/lZV3DQwOVae4xDfjQDOjqaI/ao=;
  b=MgZN88Vjso0HeaDxmHADPAZyZqZwWsR6T8cfCoTsISBSW6XcQMzTx2HD
   rXpdRTS/B33ZJEQyWlWSaEMvzI7tkqka0aiRQs8M2qcGjbDVpV1G/jpyq
   gw4R9jsDZ3gjwlOvvOcXvX84GIIRPLrG0Zmm6VNLcmUIRjZWYz6H/Pgf2
   P7d8s7Sqizc/hJwe7wwTddkllp1TJ3QQgNZSIDOSS06XCmHmHSNnRfqzf
   oWbaki6+3r8XdSEwTQRb3IPYsuAu7o/R1KNpU+ablZtVroBRSZCbgSwx9
   s9RGtYalFbgii9zc+vg9tqUnkrNCVtBmSZVbOG+s6gCBPShy+yj/bxVpc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17669972"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17669972"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:39:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4809814"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 03:39:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 03:39:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 03:39:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 03:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmSFvVNnVeQHtavRwKt2xg1A5zeOK+UczFE6XqoFjYas7deyMZPmZT7SjAkbTLSdeXPnqTCc3Kk7d3IjSXCSEeeOI9NC8hA0DXjOLS9HEEr41OMeCSveYaABrBIuY9SCK8vusAUciKO385MCESmJKqM5vTHK0Oe6zmHRd0WLKfY5b07D5pRITqeaI1tj1rFdt/nmza/MI1pvYQJGPZRKUJ9ppvUsYdp3oZNopig0sut3szdGe8C/4nDkT3oEA9/JljPytYaZdt2nF6H6ulGHyfZzRpJ75UZ0AnFyQuX+zJCgl5gQW9JMyzXnx3fbA+srh+Kxitoxb39t1XRy4d2UTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi4MUfAEBzT+yrIX5ELl+hDWxei4TQFm65P8IE06RFo=;
 b=Jxes1CRFRHzZeheE3DC9mvswx5vzCZkYXLwYyAHLsw2eBM07609OKlo0LuN+jlDA8oNB3QxRcAdfWW6Z7EFxPUvrlVebzmC0fUaqdiYc4a9M8G+mWp+mcwmm7G2t6rJo33aaWs0UQx1nBdR9JsiZYx9z8W1EQxAY/zxU5BRMw6pINW/F2QmJ5ct+Ag/G6kTuKmv4zuJ80JjfIAhiIy2zkfQokj8aRJX8nrpKrU1JmfuzCLQXrb7WTubN0XwSRqcmTb6toaGgiJOMEHmpzT084CS6QAsrvMNztHTRhzATzGY6QY5bS1SjYvsuV3S76IIndQMSkeNG79NcO4ZDAqQTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 11:39:19 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 11:39:19 +0000
Message-ID: <b6b16208-4dd0-4c34-b377-3bdf5bbdfeb4@intel.com>
Date: Fri, 2 Feb 2024 12:39:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/21] bitmap: make bitmap_{get,set}_value8()
 use bitmap_{read,write}()
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
 <20240201122216.2634007-14-aleksander.lobakin@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240201122216.2634007-14-aleksander.lobakin@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fca6fda-f59b-487c-a1b2-08dc23e39828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORk0m+9eu95yKvcd2sujVW9SnkNtOl1wnGIdN6B4S3pEWIqTamo9LC8uvz2JYTw7uDqiQWO42M4dp9/u3/iKo480A/+WGchutcIA74ejpjwMUyXGN7+RY1J2x1YUeAWpZcpU0UYKpxD9Rzodsw3yMm86JBpQfMO1WAM8X7p0JZdN/yRQwS54agmfBMvbskRpo9aTh7N3YUYAb8HYEmBanub6CFJTFzT8cvkTHXSi5Txs5Xe4v3tbDHKuVUKVr1Gwe8LUkeCghWNZ0YQNV/SOuhNb3r2XfwuxTCk9hZ/7TnmjiA1iTCE6cSM181SW5ma2ZfxeEhHIMZD5rf7P7hCnmkiIGR2f3iNIl9/ABi+YO7LDKpPXhq3hHdmVN5FJcqRthZ379tw3Z3HKzhjkqRUXKfRNXk5mQ6QvDIkcA8f13BObYfcPMqZwRv4AWKFRo9FeYhocuQ06hYLT3HXnGo2Lds2b7q7TeLmSZo+QtoLeri815BIEHwJUnnV0pGTYbOQZL5hpAs3ZAACqfC9cC9a4oopp7tgiUn4bR2nBRDXeo6AZ0LrH29gZEMYts802V5+lX49xRRTFwJoeQFwaX7Qh4tAmJXcmFtC58PNOK8XPDHW/tUKZn4AMpyAFogULHNs1MKKn8NBSWHCh+PwbeWtPwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(26005)(41300700001)(2616005)(54906003)(82960400001)(8936002)(38100700002)(110136005)(66946007)(8676002)(316002)(66556008)(4326008)(66476007)(5660300002)(4744005)(7416002)(2906002)(6666004)(6506007)(6486002)(6512007)(478600001)(53546011)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBFakY3NE5aUFozaVpvMWJiendFMWRGeHV5cHhvdFltamhKdDA3NDBIbGNu?=
 =?utf-8?B?YjdpblZYVG9TSDlraG5oWnZkWDlpYzNiMC9Sbk9VTDNqN1dRWW5CL1pCTG5C?=
 =?utf-8?B?WUwxVEY0TXZNOW9zYjBJdUlmcUxmWDM0VkR4MWVnaEhCM3BsdXRvRFcvdmNp?=
 =?utf-8?B?U0dKeW9uUjh3SE94ajgxK1l3NTF5emZxVkJaUGtOdVpUMmtFTkhNamY1NnlX?=
 =?utf-8?B?WkRTeW9lVVdVWGNiVGFpVUJjLzNBQkpvRjdoZVNpL0JTNGRDYzVod3o2T1Fv?=
 =?utf-8?B?MWhpYWMzQ05GNm1sS2Z1ZXNWZ1hDWk5IK1M1RTgvbytCQWRZQlVkUUhDM2hy?=
 =?utf-8?B?YVUvLzFlRmFwRVBoK2x1WjFEbzh5dUswN0Fyd0RINkZaSnhMMGg0aXpMZkxC?=
 =?utf-8?B?akRMQjBOWitxaWtJbGxBRXJWbkwvTy9oSXUwYjhFcC9vK2tRTnBHUEVIZldv?=
 =?utf-8?B?Q0hta1RCTHdSZ3l1U3E4dXcwV0RoYnRtTVJZZU9tTEd3RUVLTC9xVWxaUzMw?=
 =?utf-8?B?V0FsTXRyQ3dLaEY0VnVuNVJkQllsZFVSdnpWL21NdmRXTzBndjdrN3NObm5E?=
 =?utf-8?B?N1BzaDRDMGM3MnBydWpNV3hkeGYrdWY3ZmF2RTZNVzdpK1oxaEhHV3FYWmlB?=
 =?utf-8?B?SmMrV2Npc1hxb2V5RVlMQXBRNHlYcGJBWkJXNnhJTnBDRXN0dXdocHg0RWpZ?=
 =?utf-8?B?SHRsUHJla2tlWlVDdVFWck9FMDQvYlJvTWlWWTAyT05WYW5RSzNYZDhnQ2xW?=
 =?utf-8?B?SW01TDdLQ3o4TmVyWjU2QlVSVllLekF3eUp4UnRYeG1lNlFqMGtBaEd0U1V1?=
 =?utf-8?B?TTF6clNOdkJ3T2tGdDJQYWZCcllWQmFnZDIvTUNIZVE0cjVqTXhqSWs4bVZK?=
 =?utf-8?B?c1YyYko4K1daNDQzOUZ0VU81UlA4UkgxcWRTK0VhcjJENGhzRVhlVTBId0Ri?=
 =?utf-8?B?UGJWS0VOeGF5R3FweTNuKzE4VTU4S2xqVTJ4b0tYa0ZoejVFL3p0Tk1OZmFv?=
 =?utf-8?B?eE9lUnp6UUQyWHlESkdKdVEyNlNWMk9jRGR2L2VXNG1kQmtpMllYMDh2czJB?=
 =?utf-8?B?VXVKZVBVSmNiemU0dWJtdjVVYkhxWkIzS1o5RTA1bXVNeXpoc1FyN3FudzVX?=
 =?utf-8?B?YVR0N2srN3ZVSXpLREpmaG5panVBbCtabmxQQmZZUW1NdTE3cXBTVjJCSlBi?=
 =?utf-8?B?VlhHbFFJM1BkODZPZ3d6UVVjWk1lMUkycUJnbFh0eXVPK2ZIS3BIMGxiTGNG?=
 =?utf-8?B?cWJVRWVJR0pGU0JIU1BUV2cxQVp2T3RiVmdkRjd1MUt6LzRtSXVXdm90WGt4?=
 =?utf-8?B?VDVKbkJ4V01mNjFIM0NtUk42T1E2SlNmdkRiWDllTDN0Q1JCWktGeC9IZFZM?=
 =?utf-8?B?VmZvM0lDRld6b2dBTFF5TFBIK2VZd0ZacnJHMTQrRmd6L1pXdlNDejhwUEVG?=
 =?utf-8?B?aUtRblU3SlFrUWUvZmRYYUpTeGxocEUxYStXOHQvUmlMMUR6R1ZWOHBOZ3BZ?=
 =?utf-8?B?MURlTjVkd3VYZjBzcXZjbUNGQXZkQllCTjNZN1VFUWsrOU94eitOcTZsU3lr?=
 =?utf-8?B?RFc2T0poYXZjVzlVdnR0cldRMnM4blZhenpsU3hRa2REbWNndll0UzlyN2o5?=
 =?utf-8?B?a3B6aThjdG8wQ1ErREc4a1VYUzhlNWdWVWdXYXRQaGtpRTJtNGx6UkUyaUR3?=
 =?utf-8?B?N296bjFzNloxRlFMUU1LOXV1cGZkR3F5S3pEb1R1VDhWeXNuTFFoSFg5NFJR?=
 =?utf-8?B?cGozU2xDb0RuTUdwNEdpTDJHOHYyWlBnZ1Y4eThsU21kanhMNVk3TWJNckpn?=
 =?utf-8?B?bkNubFJLSmVwTWlhUWN6S3JsTFVubkF4N0tVc0cwNkIxSzhVZmN4Y2MzRFBW?=
 =?utf-8?B?b210MjY2bVNjWWpMNDNBT0dlVVJGUkhhWUZVZUkyVHZFc2RtaWpnRlJoV040?=
 =?utf-8?B?WVprQjZnZTdIZ0hmdHNDRlYxUEwxNWlPMFBaNi9nb3hUTitCTEhtRHM1WW1s?=
 =?utf-8?B?cGFTZEdYZTVqK1hGY2lrVFJ3ZWZBS0tlNllVa2l1M0Y1MExxZ1VjSXdLbFJr?=
 =?utf-8?B?MWFHYm9FNGZQaFJvbnBVREpqNkZSMXM0dW12RXhzaGJ2bGFpbUZtNWJTQTZH?=
 =?utf-8?B?dzNVUW8wc2htYmxuTno0aHdDOEkrYXhDN2RQUnF5QWxGOU9RNU03OW9oeE13?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fca6fda-f59b-487c-a1b2-08dc23e39828
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:39:19.8069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcyHDi9ANWfe4tpz2OsFerogpgZISJJEWzdICXR452ROKg5LgNvcui26uMhqYPNoFdVPQAFTeeuQpyfIdzJNQNtNHeMC/SGl+d/K2pIx5JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com

On 2/1/24 13:22, Alexander Lobakin wrote:
> Now that we have generic bitmap_read() and bitmap_write(), which are
> inline and try to take care of non-bound-crossing and aligned cases
> to keep them optimized, collapse bitmap_{get,set}_value8() into
> simple wrappers around the former ones.
> bloat-o-meter shows no difference in vmlinux and -2 bytes for
> gpio-pca953x.ko, which says the optimization didn't suffer due to
> that change. The converted helpers have the value width embedded
> and always compile-time constant and that helps a lot.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/linux/bitmap.h | 38 +++++---------------------------------
>   1 file changed, 5 insertions(+), 33 deletions(-)
> 

Hah, nice!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

