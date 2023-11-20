Return-Path: <linux-btrfs+bounces-195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779BE7F1145
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BED3281A54
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0771C134DA;
	Mon, 20 Nov 2023 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sp5o9nfw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ECC9D;
	Mon, 20 Nov 2023 03:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478305; x=1732014305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jCN1ZXjJQAjwPakA/BMyE0wF8PHfwDwgb/JQxyLX2N0=;
  b=Sp5o9nfwu4S8bGycFuQ9oHYr7MVfN7CPxpoSWCk9OCMaOwd0TBUIW+kG
   dbyPNYQ/5oFn6knr4hGyR31FL/YSUxV+MC41w4XHPRu4RhG075f868RNy
   beuKx7YJP4Bh5gan/5de23/Pl+ZWv2YTDIjJ5r2wXDNi6mYpuVM1qAEv4
   KDdznKQ+yTjQteEQyEYkNDgTCPGFEg2iId+lYLIdZ69/Q3JYfkiL1WGFj
   LX9CbLrR9BYQmV7ZDEHEn/MbiYbjXsGfx8XJ3LL/YazbGEpO7kvM9bZq2
   RcdBoJvzdCUy6/6oBUhmVFiLtZ/c7QrBjOr9Ka5v+ffy2A95nRWq5Qr+W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="370941677"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="370941677"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="889890339"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="889890339"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 03:05:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 03:05:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 03:05:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 03:05:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 03:05:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMh1D4j9DcUTo8khhbwOioV0lqRFYKrFm/4LM1yZfmQmIcjWkCDQAJtdz+XAFQ+BFF2NcER8EFEpOmO62k39aKW0L5QJHCsZqrwYoFR7W8U1+B9SbxibucATj0uyQcx5Gq7V02U5H8HJdp6WvUuv4vUlF10JlbnjMiYXXQkwtRw0gOqBV7UX1UepXVVNzjILA+yP7QyxnOJadGBZaMGP5F4eT9pcAjcJdEFMsI+7ntFvqfJ2omAZplmJlzDGXktbEWGdgbO11BiSkGkWCrB/vMzyj7qGNvoudHrKXqYcYRAx+88IrMMDh+zsLzaR9f1fzfxviv7gS9ZaNOR2wbMLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATxkAaxdXMkNshJVIdS0/At9NJ785iyeXfrpVbtaLPs=;
 b=lx08z8NMZAcJLf85uJa6gkuGR+gA9RYoawU4eUY3So4BYIEqmlxUpDYQJrOk/LvNHBa6IuSzAPuUeAScwCSsqGTJCKM4AJRgOgH0y4VBbxdwtiov0vIejqDiiHsS/1Sh88O47rIcvfAcN7WgLnyIfKG9/LiwGSfKtD5Q7RRZsGlDfJuT4uPe9HXRs5816EWpf8IssphmZKWCI9NF7HlhFTaSkggP2sFKrJvPItN+0WBl0Qk709T4RwpLPtUE2Nr1rwBwdXmE4OEYJjNXp10F0aY7L7JF3WS9vGQmoC+YII2s6pKw3aAt6IEgusUuqTzUfaP4vHE6Lazp9TL49ATXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 11:05:01 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 11:05:01 +0000
Message-ID: <76fe4252-dc61-4d1f-891e-e1cf47da728d@intel.com>
Date: Mon, 20 Nov 2023 12:04:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] bitmap: prereqs for ip_tunnel flags conversion
To: Yury Norov <yury.norov@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Alexander Potapenko <glider@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<netdev@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<dm-devel@redhat.com>, <ntfs3@lists.linux.dev>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231113173717.927056-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA0PR11MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 852a48f3-34a8-4c51-ed96-08dbe9b88ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gz/aJiZznd3fO5splqG3E+rqttm7p3xnTgEnOAxKuoey6T3IZngA3G5ydAqUSWnV8K2UsnUAh/r/00vEqwnhxzyrhUWdGG3L82bsrb9sjAK/zwTPsxPQImoBLAowTgTPVsnfr1VPznNAmH2YfVU9UgxLtwy/BWjzqQoF5I4AGhj7rAGu/NmOV8lg4eFP45NPARLWGVHUl4EAJzwH5JE5gkG26QbSDaa6Kf00q9HVaZwG6D+aKhSmVfV3BHgiza3UtxyArNs+oV9MTA/oBgcCFsXDIm9KCIZ/kJsfZ5W7JXZMRS3BXYjJpRIG82E9+voDRqOsbQw/e4Ahn5fHF3o71Qo7P4wAWoRNTMTA/aMVmeODAJ57CRaqu3GOSIc2y3zJariSH+ySM50faROOzQKAtBs9ImaXooWrYUIdNqLsEiB0N5Kd9BNsPFgXG3IfZtSWyLeFacSf15cxflQ/CIyMG0ow5Rj8pPaWR2rGlH/ALiMwTFmE7XzwcHvqIumxljru4RN++94+0KwEPfDUyhffWfqEdSJoTT0Vrbo9den0XlNzoUgQiEDAByNGzA9UkRQA3ojBgpRcLOVthu+mCfmPRWIDPtuHvMlmNVpBwvnKJIvt/TOPKXaNk/40mAI+U48rjoT9U9f6xmr5sQPRvGAykxq/ROzen6HmhABS4b95C7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6916009)(316002)(66556008)(66476007)(26005)(2616005)(41300700001)(54906003)(66946007)(478600001)(6506007)(6512007)(6486002)(966005)(31686004)(6666004)(8936002)(8676002)(4326008)(7416002)(4744005)(2906002)(5660300002)(36756003)(38100700002)(86362001)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdTcUhKMEI4bm1CSkk0MG0zOVM2RVlQWWdCRENEYm9ycVhDQTZwdG5DeXJz?=
 =?utf-8?B?anJmYUhjVGh6Y09WcGdxUFczWmJRWUhrT1VtMExDT1czR0N6QXc5OVFjYzVB?=
 =?utf-8?B?SDQzWURwN3RENWszdjdQZVJybUtRcU1mcWVzK3JnclhmZ1FUa0NlSTVHcis3?=
 =?utf-8?B?a3JjbnIwcHg3WXkzWWd2L0x3OFNYbDBOZzdSQnl6QXhYMG9PS1ZNQ1hadENq?=
 =?utf-8?B?cTZzVjY0bXZCemdSZVlJMjYzbGxTSXhYVjZNNi9VbURGYXNvNHNUTXM2YW0r?=
 =?utf-8?B?RURMSmRrZWRlUGN5bXI1ZFU3UFFteENkNzBWd1dhRnloN3FWTm5NdTRPQU9k?=
 =?utf-8?B?RlROb29ZUzU5eElZdERZN0RoYmdibGpXaDBMdDZjTkVUK2NGZTVzZVpBWWxL?=
 =?utf-8?B?dUl5UnRLTDJ5TEs1eCtsVWEzRmpxMGlaQVNHd09xa21WdVI0RnMydTJlVnU3?=
 =?utf-8?B?dnA3OHFTMXZMaVVnNFp6MGh3aVBDU0NReEtjd2g5NG9jcGxTRjFPY2FMbURl?=
 =?utf-8?B?bVhZazI2UFduaE1JVkw0S2svNHVKSmFCRXVWZ0NWS3Z4RkZ6amJFZEdUM3Ft?=
 =?utf-8?B?ZFFwd2VEVGNpaDkxbVJ3dDR5Nk9Qb1BVdmxvcTgzZU03NDFMMHBLWThFK0Na?=
 =?utf-8?B?UEYvdG5CY3FUR3hlVWZOTUNoQ2NQYlBCQXFSUnhJYnNSSmJ3emdQQjNCNnQ1?=
 =?utf-8?B?VUZqdzkwZVhUZVBjblhKbGtVazhjWXBtYVB5T0xwS2E3bWJtZnJBK0poMkhs?=
 =?utf-8?B?VXBtcCtLd3Z5akc1QzBGSlNNOEsvL0F0cDRGWnQzaDRKQWp0WEVYOG5QcG15?=
 =?utf-8?B?ZnQraE1Mblp5djc1bjZyYzd6TmFtTE1YLzhXOXpmaDRtTnFNbUR0YzVHVzVj?=
 =?utf-8?B?NHhaNlRlYkdnWngwbE1jSDA3MzYwQ2xxeS9hMTlwZWQ5dnkxUXdsYVNiQzJa?=
 =?utf-8?B?azltd1M1dzdKd0FKUWZxYzYvZjdnV1BCRUozUE9vZWZUQlU5MnVUV3hWQUFp?=
 =?utf-8?B?ckU0aDRlS1lvakExTE5BemdjdVZncGgvMTV0Znc2Q29NeTE3M0liL3dvekxM?=
 =?utf-8?B?dVIrcWNrVlFRcHRXSGNXMnVPZ2J0QUJ3ZzFOaFlYUnZGZUJPQVVsOE5JOEhW?=
 =?utf-8?B?Y0IvVHBrRVdNR0pZT3dER25CWEgva080d1A5TVdPQkxhWXozMkUybVhIcTB0?=
 =?utf-8?B?MXlyWGFJK2drNWJyRkc3MTlhN21pSldkSXF5ZWh5VUV1VTd6UjV4Rld1dGxF?=
 =?utf-8?B?QXhKMlFVMVNwMzZueXJRRlBGV3VXbmx2eDJHcXQ5c0JZQ2o2RUhwTEVtSHN2?=
 =?utf-8?B?VjQ4S2ZtaHgzNXdyTW11MXpzL2Jsb3VTcy9qTzVONi8vOUFWcWN1d2JFQkd6?=
 =?utf-8?B?VjRiN3RCMmtBenorMjh5UndmQ3I1eE04R01IS3FzVHUyZHYrd0Z6QVVUeDE1?=
 =?utf-8?B?Wkp4Z3JPaTQvL3JFaXJlaTJPaHM1RUpDd0pjOHBwT2d5N1hDeWwwYnpWZVkx?=
 =?utf-8?B?aTA3WExtcWptOVJ2dWZLbEtnZ0JJbGdpNE85UzU4T1hmVjNyTWlhc3Z1dE1V?=
 =?utf-8?B?V1A3WW9leGlyTjlnVUJJcjQyTVlXbGdCOWprOVdzeEsySUcxSWNCT21oTkto?=
 =?utf-8?B?NkxQUnlwby9uUjR3eDJGb2NZdWRwbkI1RXM2TXV2T2xXajFubDN0RUNsbzI5?=
 =?utf-8?B?NUVyVDRmR3Bkb3NudWtrVGhhNFBGWEVPUFllbm85L2pCWkVqOVMrK215bmxO?=
 =?utf-8?B?MjhTNWhlcVRVYytJaGUxMWZYczVPd3RYT2FqOTJUdTJqem96NW9vekJMSVpQ?=
 =?utf-8?B?blRHUjJEeHlRQjhkcGVqZ2dQK2JjSkVOb0lKamVuYmoyYmp2aHM5cjI1WjJl?=
 =?utf-8?B?Z3BtQXN6R1gwdXNUekxGeDJ2cjJQME9reHliS3FYTkg3MURLTEJMM28vc3Fz?=
 =?utf-8?B?ckkvSDA5aTdUTlNjWThQU1p2VDJRdXBORFY4amRaM2ZkREk5NGsyU2lITjZV?=
 =?utf-8?B?RWxYaXg0YWRuYTlIc04wcVdzUFpVTHdyMjVvUW5TQjduQ2huWTdrUjMvbDlH?=
 =?utf-8?B?S3NvOVNpNVhkbEZYZFVQRzFJNlZsR0VaNERtSzFGMFFjcWlZcTh5REVkQTdL?=
 =?utf-8?B?bll0azJFUUlsWlRYdmVCMXBpc1RCZ2xwYTNGayt1ZHRmQmJCeGhTTG01TU9M?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 852a48f3-34a8-4c51-ed96-08dbe9b88ab1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 11:05:01.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As5phAT786M5k1Cc7ASxib41UI1XiCOoQl1bPpn8SnixG5hQu8gZEVtl9oQmtabbwEJocqYi1kOYlN8aYHAo4dWyrx5QnytRIk1fmcpJ9rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8419
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Mon, 13 Nov 2023 18:37:06 +0100

> Based on top of "lib/bitmap: add bitmap_{read,write}()"[0] from Alexander
> Potapenko as it uses those new bitmap_{read,write}() functions to not
> introduce another pair of similar ones.
> 
> Derived from the PFCP support series[1] as this grew bigger (2 -> 13
> commits in v2) and involved more core bitmap changes, finally transforming
> into a pure bitmap series. The actual mentioned ip_tunnel flags conversion
> from `__be16` to bitmaps will be submitted bundled with the PFCP set after
> this one lands.
> 
> Little breakdown:
>  * #1, #8, #10: misc cleanups;
>  * #2, #5, #6, #7: symbol scope, name collisions;
>  * #3, #4, #9, #11: compile-time optimizations.

Ping?

> 
> [0] https://lore.kernel.org/lkml/20231109151106.2385155-1-glider@google.com
> [1] https://lore.kernel.org/netdev/20230721071532.613888-1-marcin.szycik@linux.intel.com
[...]

Thanks,
Olek

