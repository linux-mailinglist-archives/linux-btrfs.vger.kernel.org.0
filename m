Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A381C7C4BD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 09:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbjJKHaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 03:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345473AbjJKH37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 03:29:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B03EF2;
        Wed, 11 Oct 2023 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697009397; x=1728545397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PpjKqiPewWd1M7jRda9AlAzDsGBG0aMdQNFyxZgH7W4=;
  b=EPh/phU60wSJXEwrk6T9H3srlZvP6UC+tbl6iODarbOJ9nnW+xzPWfLb
   i9xPoAX4sZVCTk08bq1ZzptBDl0UK3snqNtRN/rk/91wypTYqHfmyGA6w
   gvXV0JgJwSEACg3NFRT7qm2FWFoP4eGwY9fXJwy4ctQn44K26d1eWyvpv
   8B+1N5laxrwJOPYkNUBmX+Dyv7SK1LHk0lgQmKrB98iLnsMpb3qmuMUgx
   3Pqu9xPpActLgnbQbu4vh/qEJjB1WssJQNeqDbX9FQ3PwopuwmM4TzXGl
   ysC4/k4as75RbQw4NVhw16gam6M4Tx/o86rmpOIkgHvXrumIrX8yUmb3Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3192076"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3192076"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877569348"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877569348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 00:29:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 00:29:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 00:29:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 00:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKk2swd+a4tsnSKHIKc7od4dJmoNvubJbzYTi3WBgnhskgyKzGiLvpDSj+XGzSMkWsdk0uwecXUYSsKI8F3HE0Q5CCxJrKvjqABxSWUu0Y4Z1W6rVvA9zLzn5A+UNSW0nXpKWOpYCyl1+U1df+I6fBMAm5YAG3z2uTWRk8GXVCuC9e1QNLRmrw0OhvqlYaTITS9nd54FzGXl7/UhIALu0I+nrsCiuVQOvoEO1owKrhyBqChREqmz/8VVG97NUQ/ECbCEK4WStaHOXwQ7YFjKVABsCa3/2H1QB3NYEbk8UUQvmae1uo7SZRZf3L1/3i+7DkUbjnEstXfnjZUHUS+bXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDvW9J/o1JafaDK9BEN2Hx4OAkTOZBkwObZwmH0OTZI=;
 b=Tw2wBTaut71avin4zfnd77+0Rgpe4RUDlEUxV8cTzoNXjv5QvYNl8YD0buO/0iqx0bTlxeNxU1iqzeAcqMmIvbroGK35R/WYRsBQBzarPEHPWzeiKy6tYvlzd3buRyOpX0FMGoMnhkgwp+QmCMATjI8/m3SGsid5dPRqFSrIJF4gAInfhRKtnbbp6E9qviUMoG7RoU270H5ve40mafl0kWEUm/csyzBkzmMyO+VoNZAO6jeCYKAvVhCE2z/azJeQwGKFEIj+l03WlMp8l1RvDXZv4UkB6/a3N4pzTg/jSUK2GN3UQYMW9hNycvLFYGYvNJmGfVOcgZKJ3ohSUUc90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 07:29:53 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:29:53 +0000
Message-ID: <bb7e8b2f-b586-4985-930b-018035e86bcc@intel.com>
Date:   Wed, 11 Oct 2023 09:28:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] s390/cio: rename bitmap_size() ->
 idset_bitmap_size()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "Simon Horman" <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <dm-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-6-aleksander.lobakin@intel.com>
 <ZSQryML6+uySSQ55@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZSQryML6+uySSQ55@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb156fc-ace1-4de7-3b86-08dbca2bdc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NIFOxxt3UyucsnsFoUJDsCebBRPcphbNIcBC353VFqXpfsGbf3VwgCVgPuthc0qnAbxCHdv9o/WD4wvR5Q38cg5cXXinuXgz1UmBJW5Dyb0YqbWuIEK3yqN5haa6ajWva3MO5YldAfyDg+qR0ZjJvLdxsasNbTMkAONcot349M8Za51jR0cJZjak97N6Tllth2xnfUMO+eOmJbJuXyp5UT6Eqjiq/QyL8NwsiJdmsi5CHlJzUNzCGnliGFHiQrDqDvb6OtwUTDs6Q7AvlKO/crwBzsRCBl2GGrot3aq3EAEQTJPo9QzrZ4amQw+ULrsrdsMDiwa++ZTgwYbAH7yboqvLoFLxC/3nUiSXHWcDN0gQVF/+x1iPYHiVnQ+INuza96tXB2DLcpjtti39q/UqOBVTz1o1bIV/p1c2Yx8cf8fRxpPC1mRfyulMFeRUBByV7RUAPyMhHLxtNG35tPIBPZhLx+VEmjseRYkZk/wlmNQfgYTEM0qAqE8+SNiEQXtO20ZQ/ba73hlUx+KN4/LJckpM0TRv8q3IpjPxV9URmdpH20mFkpufaDh6ubjKKeOyKv4j/b1MXimeKOP2Q/wBSCLbi8YSYLaQgpxDKgT/UhdebKVwPdkeHTWjhMA8qA2CvnuANgRSIeOI66yKxBL1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(2616005)(26005)(66476007)(7416002)(316002)(54906003)(66946007)(6916009)(4744005)(41300700001)(66556008)(38100700002)(8936002)(8676002)(4326008)(82960400001)(5660300002)(2906002)(6666004)(86362001)(31696002)(6512007)(6506007)(36756003)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUN2TjZyeFlSLzlab1FvaVhBeWdrTnUvamtzWDhBWlh5Qmh3R0c1eW5mVTlZ?=
 =?utf-8?B?K3hGVG9zNEN5S1pkMitvWUQyam9PaXZ4SldndUpSSk1ySUs4aVgvVzROSm0v?=
 =?utf-8?B?RkRUcmZYajJSbTRmZU9xcnE2YWd1UWZvNmNnV3Y0L2pqL2hPVWVyOXVwSS9r?=
 =?utf-8?B?Qk5uSndDUjFPbGNuQzI3VzdjZ0Y5Q2VEQ2FjOEJwaEsxTWVGOUFRYktpc3ht?=
 =?utf-8?B?K3BTRDRQYWFJSDZjekFraWJSTmk4L0d1a0wzRkhqZnhacU5GN0pmaG15S083?=
 =?utf-8?B?Y0NocUIwU1YycnA5bXNwUnNkM2o5Uk9mUFdSRGdoY2pydkF2UjRiKzVlNi9i?=
 =?utf-8?B?aURTbUFhOVlnOHBHSGxVdW9PMFhGZVVDR2kvZUlYRnFMZjJVMmFZZ1hKcW9i?=
 =?utf-8?B?MisxVTNLV2lKY2NUb1JvUytwUnVFQUZyQzQ1VEpqUDF4b3o4Nnp3d3BFMnhL?=
 =?utf-8?B?bFNDREdlSHAvM1pYTS9Ld2xjemRSanVwZitKRnozY1RhOU9Nc0NVTUFJcm5C?=
 =?utf-8?B?WVNjSFZ4Qm9TTVRqSE5IS2ZtNUQyeEI3aWhBVE12QXBRT2g5UHpCMExFankx?=
 =?utf-8?B?S3VDZVBia25YUDhYOHdWZ1lHQXIvd05VYW9seXA4bWxZY1hvSkRZSDRkVmJr?=
 =?utf-8?B?eVVZTzM4azV2cytZa2pVQlJHUUhMTnVmTWNaU2g1cVdFNGV3OWNJbXFKR1pm?=
 =?utf-8?B?MVpmV2V6bHEyMHNmUm0rL0syZ1VvZVpZMnRWVGVlZ0dQajlEWDB6SlI1Y255?=
 =?utf-8?B?NFdaZStGQXZiNW1iQWptYkJ3SVZtNzhySzlIQVpkWjJRdzN4cG85M1F0bDVl?=
 =?utf-8?B?NWwvbmY3VEVlWG5GRUNhSkJnWHlJaDJBTGR2M3FSSjVXSXNLbEE4YWViSTBO?=
 =?utf-8?B?Uy9yNXhmZXZtaitSeVpRVFVaVUpCcndlSXlzTDl5WVFpb1N6eWV0aVA0RW1S?=
 =?utf-8?B?WCtyS2lwMVYraW54aW1sRFR4S1BoVDNKTTh5Ti96dG8zWDNpTlYrYWl6TkRX?=
 =?utf-8?B?dk9Yb0ZndnUyYklYUFB6Qklqalh2eHUrYTl2RDlXYWJnd21iRXVVSzQwczlq?=
 =?utf-8?B?Y21sZHZuZlJ3ekpwdktKS3c1QSt5TjFMQTJibyttMktkb3lBZWJSS1ZPY21P?=
 =?utf-8?B?Y0FaNk93alA4bnZLZjdkclphU1hsTzBvanIyMWxrbHJxcjloOWU2RUROU3Y3?=
 =?utf-8?B?MWY4QmpZTitwdXlMZ2NnelYyODV5SzNLemtodXhCSFhIUDBlV0FwUmM3cXoz?=
 =?utf-8?B?RCsycEt3TGV2ekVZWG4rd1dDZHh3alQvUlhjRGxyZVF5RDd5SndQNDZqVGhm?=
 =?utf-8?B?bWxoK1JDWEJMTzN3QTRzeDNOb3czaXJCZ0pCWmVNM1VlOXk0bFF5ZjdVZFAw?=
 =?utf-8?B?STR2REZKMkpKd1dkNzZyQ1JBS01wNmh6RzdlTzlaNmFSTFRoY21vYi9hNVRr?=
 =?utf-8?B?OXBvb1poMTZRNVF1NUlMQ0VlOHdMd0t2end5U0VHVk9uQnJGOHAzQUJYRE9n?=
 =?utf-8?B?bmwvV1VwRlA1UHJ6amxobzhDNFpUUlF4d3QwYmYrMkZwV2lVbGFPMXZiSGsz?=
 =?utf-8?B?VmZtTGdLQmRyTnFOVjZRRE9zNEdmTXVuVmx4UGtyNW9vaXRkM25BMmVUUmVw?=
 =?utf-8?B?KytnbzJCcHpUYS9IRk5JKy9iS1l4dFA1aGpCOExSZ2JhTWdMV1dUc2dRTTdU?=
 =?utf-8?B?QzFlVGxhbkdZZlVFUTIzSExpVmhSWTNNWTZwQW53NjZGeEtrZ3RlcVRtLzFV?=
 =?utf-8?B?QXBnWHZLZnVJNFdBcGZvR3F1OVo0NmNwalVES2I1czArcmNmcTd4b2lHK0Vx?=
 =?utf-8?B?ZWNKVUtSUnJGM1cyMjhBMDFpZG1zNEtCaG1iOVhNalhpejFvOGYycy84RmV2?=
 =?utf-8?B?V0p0OWlDZTV3Q3lyOEN1ME4rWjBJSjduSkdKc2RGVTFFQmJFNi81aHdmTkFS?=
 =?utf-8?B?d1k1dklUS1I3US9WQkZvbEdUclhMSGpyWVB5RzhrK2JJT0dkY25YK1hnZEJk?=
 =?utf-8?B?SENIZXdwZVVMaXBxbDZtazZyMkZwMUxSbUxiVE5aY1ZVYlFXZ1pzRUNYRHFx?=
 =?utf-8?B?ajJVclRBZlpkdm1Yam1iRGd0eCtHL01HNzV6aGx0T3pMYnFqWjdnVmlHS3Rk?=
 =?utf-8?B?MGtFeEpraUg2SFRJZVNUTDV4cjZVUzA3WTlYZzIwdkFNVzMrZDhhSkM4VnRR?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb156fc-ace1-4de7-3b86-08dbca2bdc51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:29:53.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErwyNnvMbgseIdw2Vq9IIxRdQC90noy/pLT4pLhYMMQgJDCa9kLjiBFTpRTGQTPN1HY5wHsSR82dtiK/J9f5SKnXQPyvy3HGnu3mHtY9XjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6489
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 9 Oct 2023 09:35:20 -0700

> On Mon, Oct 09, 2023 at 05:10:17PM +0200, Alexander Lobakin wrote:
>> bitmap_size() is a pretty generic name and one may want to use it for
>> a generic bitmap API function. At the same time, its logic is not
>> "generic", i.e. it's not just `nbits -> size of bitmap in bytes`
>> converter as it would be expected from its name.
>> Add the prefix 'idset_' used throughout the file where the function
>> resides.
> 
> At the first glance, this custom implementation just duplicates the
> generic one that you introduce in the following patch. If so, why
> don't you switch idset to just use generic bitmap_size()?

I didn't want to introduce any semantic changes, but good point, why not.

> 
>>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

[...]

Thanks,
Olek
