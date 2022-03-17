Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0399D4DBDE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 05:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiCQE5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 00:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiCQE5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 00:57:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2E11C7F7;
        Wed, 16 Mar 2022 21:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647491975; x=1679027975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=lGbA2igbgVNBw/dDX1elDeAgw7yfhYE+K0dDUkMdLjM=;
  b=PZJ/XRpCq+K+U5szL3t4eCjCvFI06vKZ1dMg5Zec3d/Z0cfsiBDvO2eX
   bbzXSHeGthq+lzkLSIMAVJo6LHSEU2ZUggCu7Ug6DLb8dcvzItBcTq6QW
   2NvtckQ10BKj4QT02euuihTmgRQZ9WpQEwoQscjVzMGZFFabFp3qjl+am
   K5zBcksDwwLLxSZnD8wm36Pu8IbOg4GygQY2sDSGZ58+lAMgZKfvOCy7z
   8EAs5gkHUSGWyX02cff0gAmHj46x2LyNc7RA9FxGVoBAUGi/KghIOC3tW
   g4PK3ZkHWZgUsoB3HoeUbUcgJRky3bhBl4nuyXEPjF+WkbPZKdVUGSdhJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244232632"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="xz'?scan'208";a="244232632"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 21:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="xz'?scan'208";a="783719779"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2022 21:38:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 21:38:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 21:38:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 21:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfa2idUjxK9JbzMmsTEMhSe3EatEVhaokbWx4K5hBpyw2vKDD2mTS8j5eTFwgCqvMkjAkXpcGtK7j6dLJ0m+NfOPNlUGN2Jr6cyXfBfyzuCI/Y922koVhs9zj+yblx44AUyCNh2HRGVbfQ6h86b8iLUxuQeAvG71AGxkAoYGppF2pefYjXQu21QBnx8L0rAY4TU/TmN1H14urnXc55N9aJGsGSzMKcEXknDVLwlcBfsYI4NU+x2jwIAbZuVsgDuuJJ6MfQyRd0bKMdarl8IkBnuFDHsl6PPRdObXnf6PDrNvpoVVGAGOTmPGcv0BaPaNYEhC+ylwV2I1plzzNz8GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOincgMlH/1Ps6T9b+Zg803e/U4Mu8QNO9XEvl4BZe8=;
 b=krSs3p3wbWsIprBeMNe4PPZN2swBBSbsDOkB/1AHwh/nGPFImauntZLxEVbZReK/fJcYxZjO0y9XRCJi9cVHViPVsZu4m1mnQE6KV/vlAZbVSe63+P+ri/Jo5+TsgBq/tqVigKmcrOo1iPrE2lrHsF6Go5H0BfdzvLC3ZAs/WvH3FZ6BnENosNofTFNhGK6NPP1eaB1SphAHuJ9Ek3cxnQktKeUuQrZYrZR/5wXMsvwSei+2gaND73UwRXJVdFjvQL9hZdtdnY9ht/Vhkfnxeyzs8oK/w4RZMKQwa/sPudbzdXCL3nDs6sAuqxWK6i7IUOnJZvdePr5WIHTrq8CkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13)
 by MN2PR11MB4206.namprd11.prod.outlook.com (2603:10b6:208:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 04:37:59 +0000
Received: from CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::d5ab:9ec0:b0c7:7bcb]) by CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::d5ab:9ec0:b0c7:7bcb%2]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 04:37:59 +0000
Content-Type: multipart/mixed;
        boundary="------------hg040YMm9rBk0jTdd00U37UN"
Message-ID: <57656d0d-d4d4-4d68-de82-e29093d19d3e@intel.com>
Date:   Thu, 17 Mar 2022 12:37:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [LKP] Re: [btrfs] 3626a285f8: divide_error:#[##]
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <lkp@lists.01.org>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
        Oliver Sang <oliver.sang@intel.com>
References: <20220301063026.GB13547@xsang-OptiPlex-9020>
 <e55fb58e-bb3a-ce51-b485-6302415b34e4@gmx.com>
 <20220302084435.GA28137@xsang-OptiPlex-9020>
 <dbc84dd2-7e6d-95b0-d7bc-373f897a7063@gmx.com>
 <20220309074954.GB22223@xsang-OptiPlex-9020>
 <c28efa5a-e2ae-486b-6a51-5e063086937c@gmx.com>
 <20220314020549.GA24245@xsang-OptiPlex-9020>
 <eb6f9763-5bc1-5ac0-0b82-0ee7994e85c6@gmx.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <eb6f9763-5bc1-5ac0-0b82-0ee7994e85c6@gmx.com>
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To CO6PR11MB5587.namprd11.prod.outlook.com
 (2603:10b6:303:139::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a6d65f-66f1-4fa4-d141-08da07cfe9ed
X-MS-TrafficTypeDiagnostic: MN2PR11MB4206:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB42066AC9C97BE5F626A3DD2DFB129@MN2PR11MB4206.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyNqTDkw1InybuQwQXU2WDATRLjYLD4otfcGbqi4CDZNNXhr7cgwX8ysVHLHeDEGt0Kpi0ztAPTgIPLJHEY0N4SoaIPtGs4ELb2KDFhFy/06jEcHwnZpArocs2ibBvTCIb5NzWkMkehSX4o/O/mTjX7qJO3CFjgVY3G+5iJfMcDA34QXlURy8kAABpctX4zUqEL5JT086Ddro7YMBcETWNZCbCAe5ys2JfEVZKkIlfwEry/GRFkyevveXTeaCtksJbxlPN++f5RnvHudtbKC65IB4WiXIXp99f6upk8bR8NlVOypo5K4O0HNHXb4y3q33WehUWFpzJJJx2K6cuXGCaQJYP8cFGb7pqxNCN+nn709a7s1pxHBM6PMMeEQVUJrlE7VQtmWH+fRwliRe5GOGdDc7gdMREryL/59M/YeZkf0F8MHI0efjVOgCHC+Bc6ZVZcK4l/Np/QvW2XggY/9KYrdlAaUHis2ln4U7e1ifun08L5gNbacr0+y5jaw+dvDsCk5REZ8TLkQjdjmjn9kbuj10LnIjaSB0PTb8uEMOivt5olhL6uV61Ma/kNRu3lvWuLTExepue7LnXDMMIHDSk1XcBTKHmyOLn+NZdru76JUYf55Ov7iGDqxZA+FnNMQNnVSlM57mM3HYgv1lt9i/oExZ0yxWMsNcpLTkpBPL2P522IofZVBNpR+0LlnbiDmL33xsarNVqHuHEBcBY1Ud7Zob16rA9CnAHixRRaKvKgUQoPU20pBrcJeC0E/1doJvoI1dQNPaQSRFTJYaOHOD0m0EncdM4JUGnXtP8qBYKVe/uqJuopRCNNvUu/unWKN7aVmiIqUyVl4O1fO0GXev7j32NI+zi4iOkIq2Qmhj/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(4326008)(6666004)(83380400001)(30864003)(508600001)(82960400001)(45080400002)(5660300002)(38100700002)(6512007)(235185007)(33964004)(6506007)(966005)(6486002)(53546011)(8936002)(107886003)(2906002)(316002)(2616005)(26005)(6916009)(54906003)(186003)(86362001)(31696002)(31686004)(8676002)(66946007)(66556008)(66476007)(36756003)(45980500001)(43740500002)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHF1RE9kWWtoaGFOSENhbTJ1R1MwWUN4ODl2dW1SUExVRXJaNWtzYWNCSnpr?=
 =?utf-8?B?ZnhjcW5YbnRGWFBsS3V0M3F5LzJBUnU3ZlBkQXo4MFZEaEpmNjhJTmxCZGd4?=
 =?utf-8?B?aUsvM2g5Nm5wd2pYSWRoeTN0THgyc3U3WWh4aHBvdWg5UTRiNXVjNU1UelA1?=
 =?utf-8?B?ZTVtbHB5c3JzWkdjcVZNU0NoSjdqU0NuUlh4aUxxNjFZNXNDSmhDWXl5TGdR?=
 =?utf-8?B?cVFIbFB4R2ZzUmdWSHpvQUoxemxBUjljeDRkakNMU2x1cklNODBPbFFESWhX?=
 =?utf-8?B?Y253Wk1rUG5tUWRCTThVNmkvNGhSclpmU1NkQU9TaCtxc0NWSGNLTUpWbU1F?=
 =?utf-8?B?cVNNNlNONDA5VndXZ1lETzRkM3NhS2hldEMydXpRSXVNZXJGVDlpQ0QrOU0v?=
 =?utf-8?B?WWUvUGpmcEZ5YSttSmRxbzZnbzRMeVp2TUtJelpFMThRbytFL1NyTFQxQll2?=
 =?utf-8?B?SGxMbDN4RkVZenhUcVl3UW0wY3VXYUg3UmxOemRJWEdGZXhQTjZ2OUNzWHdQ?=
 =?utf-8?B?V3ZpejZuaDFMNDZGcXNwM0tHZkFXWHEvV25lZlFGcGZLWS9nM3gvVGRhSWNs?=
 =?utf-8?B?Tm13UnEwZkRPeWJFclJKNHY0V1VKRHBrY0xtVzdkVTZuQ3QrQ0REZkplVjls?=
 =?utf-8?B?RnlxSHRDajhPQ0RTeHlXUnBIYlpJbW45b3VYRVA0d2hnckVNc1IySXhxQ1da?=
 =?utf-8?B?d2NYQ2V3NWFONlF4MU4wY21VdEdBS3FjbFRyaUQ2Zk5mMHhocjNwVU13NHVI?=
 =?utf-8?B?clhoVDlnNVpUSm5wWktmNUVHaEp5RDBqSnk4UjJlL1pDeUhhcWVZSS84VlNw?=
 =?utf-8?B?alFTVkk3bWsyRmlJTUNYSU5lSWh2aHJtazVaUk91UFY3aURNVnFxaDh6cGZW?=
 =?utf-8?B?TmJTLytHdUM2NnlvODFXaHROK2FkaWl2ZHFJREpCN3dpSk5scVZhSUZXc0xp?=
 =?utf-8?B?ZzNxQzRWNWM5SU1ZVGo3dTZrYy9adnRtMER0SDhTcVF0cE1BdFNuSGVqUkJM?=
 =?utf-8?B?R0dJWUEwWG94WHg2ZU45T2p4NStFYVpiMUtXR3ZzSDdzc29vVU9zVnoxTTBZ?=
 =?utf-8?B?emZ2Q2dzVDhlZlV6YUpxcVV2bUN3ZW55R2RkWVA5bTlOWTN1eWJ5WFNCT205?=
 =?utf-8?B?anNCN25xb2NkRk9lOURkUWNDT1BqVUx3d1ZPbWpSSmFYNHplM3hpR3l6UWtj?=
 =?utf-8?B?OWlTaUp4NW9peDB3RG5mY2tnejQwTWFJdm1Ha2lrV0VJaFNyWncwQmVhYzBH?=
 =?utf-8?B?cm9IQU9NMDF3YVFwMUFnbmthRDVtWlRpZVFYZlloSHBTK3ZQVUp4a3R4TEpO?=
 =?utf-8?B?cnhxTjVSUElhQURHVEc3bnNoaHhLVkw1MHpKL3lUVkpMVjdxZDdhbE8wWnV2?=
 =?utf-8?B?SkNFQ1NHdlZXbVFuR2s3ZjNKeFg3ZTNZeHBONUpVL283OHFDbFJBbkV5bFpU?=
 =?utf-8?B?ZjgrcUJyemgvSDJ3ZUltcFJjZUFlOTMveHYzYWpaTDVZU3lUbkw2eXE5bXpi?=
 =?utf-8?B?TXpxa2oyVlRGMDRIRkVqdVZrRjBJbG9jZTVFNUpNYnk5cW90VEhDczl4UGsz?=
 =?utf-8?B?eUJDWlFZY3FSSUtYc2FTQU0vdUlDcWZxb2Jpd2VZT25sVUxwTmpIcnF2NnFn?=
 =?utf-8?B?VkVsOURTMWVwNW51VHUxWWFXN01BeXFIQXY5VnNVTks4WE1yZis4ZERzSTFo?=
 =?utf-8?B?R0dZZ1l6RGJIbGk3OVdmdG1VMEl4QmNsZldCZWprVUthZTlIVGF1TUQzaTRJ?=
 =?utf-8?B?eUZEYzlVVjBwNitYQnZuQkxGWVRXVTJJbmYvYmoxd1RlOFg4WDdnRFpUbGU1?=
 =?utf-8?B?WkxjdEZPbmhhQk82QjNMVkFWWXEwZ3BrR1M0aG02czNHK3RkSTJMRDNCd3Fu?=
 =?utf-8?B?elY4dUtnclk5ZW43aUFBY01ZVmc0K1kxdnZ6cUdOaHowaFdab0Y4Y2prSzBa?=
 =?utf-8?Q?kBUXZjhEcppEpw+og5K23pX579c0VUjI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a6d65f-66f1-4fa4-d141-08da07cfe9ed
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 04:37:59.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /v1qEB7xtXO9tDAMg4mOW4I0l3AiaIL1M7QjsZbUrz6C5FXn9zWEu6xn6sJC0xT6Ln5IY26tvSNQArB1bYerUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------hg040YMm9rBk0jTdd00U37UN
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Qu,

On 3/14/2022 10:24, Qu Wenruo wrote:
> 
> 
> On 2022/3/14 10:05, Oliver Sang wrote:
>> Hi Qu,
>>
>> On Wed, Mar 09, 2022 at 04:42:41PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/3/9 15:49, Oliver Sang wrote:
>>>> Hi Qu,
>>>>
>>>> On Fri, Mar 04, 2022 at 03:26:19PM +0800, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/3/2 16:44, Oliver Sang wrote:
>>>>>> Hi Qu,
>>>>>>
>>>>>> On Tue, Mar 01, 2022 at 03:47:38PM +0800, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> This is weird, the code is from simple_stripe_full_stripe_len(), which
>>>>>>> means the chunk map must be RAID0 or RAID10.
>>>>>>>
>>>>>>> In that case, their sub_stripes should be either 1 or 2, why we got 0 there?
>>>>>>>
>>>>>>> In fact, from volumes.c, all sub_stripes is from btrfs_raid_array[],
>>>>>>> which all have either 1 or 2 sub_stripes.
>>>>>>>
>>>>>>>
>>>>>>> Although the code is old, not the latest version, it should still not
>>>>>>> cause such problem.
>>>>>>>
>>>>>>> Mind to retest with my branch to see if it can be reproduced?
>>>>>>> https://github.com/adam900710/linux/tree/refactor_scrub
>>>>>>
>>>>>> we tested head of this branch:
>>>>>>      d6e3a8c42f2fad btrfs: scrub: rename scrub_bio::pagev and related members
>>>>>> and:
>>>>>>      fdad4a9615f180 btrfs: introduce dedicated helper to scrub simple-stripe based range
>>>>>> on this branch.
>>>>>>
>>>>>> by attached config.
>>>>>>
>>>>>> still reproduce the same issue.
>>>>>>
>>>>>> attached dmesgs FYI.
>>>>>
>>>>> Still failed to reproduce here.
>>>>>
>>>>> Those btrfs/07[0123] tests are already in scrub/replace group, thus I
>>>>> ran them almost hourly during the development.
>>>>>
>>>>>
>>>>> Although there are some ASSERT()s doing extra sanity checks, they should
>>>>> not affect the result anyway.
>>>>>
>>>>> Thus I pushed a branch with more explicit BUG_ON()s to catch the
>>>>> possible divide by zero bugs.
>>>>> (https://github.com/adam900710/linux/tree/refactor_scrub_testing)
>>>>>
>>>>> Mind to give it a try?
>>>>
>>>>
>>>> in our tests, it seems one BUG_ON you added is triggered
>>>> (full dmesg attached):
>>>
>>> What the heck...
>>>
>>> It's indeed some weird extent mapping has its sub-stripes as 0...
>>>
>>> I must be insane or there is something fundamental wrong.
>>>
>>> Mind to try that branch again? I have updated the branch, now it will
>>> trigger BUG_ON() as soon as it finds a chunk mapping with sub_stripes == 0.
>>>
>>> I'm wondering if it's old btrfs-progs involved (which may not properly
>>> initialize btrfs_chunk::sub_stripes) now.
>>
>> below BUG print was caught by your new patch (detail dmesg attached):
> 
> Thank you very much for the detailed report!
> 
> The triggered BUG_ON() means, we're getting sub_stripes == 0, for
> unrelated chunks (in this case, it's DUP from sys chunk array, from the
> full dmesg).
> 
> And from the code context, it's from super-block, thus there must be
> something wrong with the mkfs.btrfs.
> 
> But unfortunately, I re-compiled my btrfs-progs v5.15.1, retried, and
> still no reproduce.
> 
> Mind to share the result of "btrfs ins dump-tree -t chunk /dev/sdb2" and
> "btrfs ins dump-super -f /dev/sdb2" just after the mkfs.btrfs call of it?
> 
> As the BUG_ON() mostly means, the result from mkfs.btrfs is not correct.


We have added the "btrfs ins dump" commands after mkfs btrfs call, and got below log:
(full dmesg attached)

[   83.859614][  T337] 2022-03-17 03:28:07 ~~~~~~~~~~~~~~ /dev/sdb2 start ~~~~~~~~~~~~~~
[   83.859620][  T337]
[   83.870522][  T337] 2022-03-17 03:28:07 mkfs -t btrfs /dev/sdb2
[   83.870528][  T337]
[   84.160841][ T1446] BTRFS: device fsid 3f698242-c4db-4b90-9aef-804b56f2bb6e devid 1 transid 6 /dev/sdb2 scanned by mkfs.btrfs (1446)
[   84.173707][  T337] btrfs-progs v5.15.1
[   84.173714][  T337]
[   84.180774][  T337] See http://btrfs.wiki.kernel.org for more information.
[   84.180781][  T337]
[   84.189916][  T337]
[   84.189930][  T337]
[   84.195706][  T337] NOTE: several default settings have changed in version 5.15, please make sure
[   84.195712][  T337]
[   84.207588][  T337]       this does not affect your deployments:
[   84.207594][  T337]
[   84.216415][  T337]       - DUP for metadata (-m dup)
[   84.216420][  T337]
[   84.224369][  T337]       - enabled no-holes (-O no-holes)
[   84.224374][  T337]
[   84.233011][  T337]       - enabled free-space-tree (-R free-space-tree)
[   84.233017][  T337]
[   84.241956][  T337]
[   84.241961][  T337]
[   84.246811][  T337] Label:              (null)
[   84.246817][  T337]
[   84.254487][  T337] UUID:               3f698242-c4db-4b90-9aef-804b56f2bb6e
[   84.254493][  T337]
[   84.264219][  T337] Node size:          16384
[   84.264224][  T337]
[   84.271244][  T337] Sector size:        4096
[   84.271250][  T337]
[   84.278261][  T337] Filesystem size:    300.00GiB
[   84.278266][  T337]
[   84.285545][  T337] Block group profiles:
[   84.285551][  T337]
[   84.292560][  T337]   Data:             single            8.00MiB
[   84.292566][  T337]
[   84.301673][  T337]   Metadata:         DUP               1.00GiB
[   84.301678][  T337]
[   84.310792][  T337]   System:           DUP               8.00MiB
[   84.310798][  T337]
[   84.319517][  T337] SSD detected:       no
[   84.319523][  T337]
[   84.326270][  T337] Zoned device:       no
[   84.326275][  T337]
[   84.333495][  T337] Incompat features:  extref, skinny-metadata, no-holes
[   84.333500][  T337]
[   84.343101][  T337] Runtime features:   free-space-tree
[   84.343107][  T337]
[   84.350971][  T337] Checksum:           crc32c
[   84.350977][  T337]
[   84.357993][  T337] Number of devices:  1
[   84.357998][  T337]
[   84.364376][  T337] Devices:
[   84.364381][  T337]
[   84.369859][  T337]    ID        SIZE  PATH
[   84.369864][  T337]
[   84.376746][  T337]     1   300.00GiB  /dev/sdb2
[   84.376752][  T337]
[   84.383603][  T337]
[   84.383608][  T337]
[   84.388521][  T337] 2022-03-17 03:28:08 sleep 10
[   84.388526][  T337]
[   94.181546][  T337] 2022-03-17 03:28:18 btrfs ins dump-tree -t chunk /dev/sdb2
[   94.181556][  T337]
[   94.215558][  T337] btrfs-progs v4.20.1
[   94.215568][  T337]
[   94.221902][  T337] chunk tree
[   94.221908][  T337]
[   94.228420][  T337] leaf 22036480 items 4 free space 15781 generation 6 owner CHUNK_TREE
[   94.228425][  T337]
[   94.239630][  T337] leaf 22036480 flags 0x1(WRITTEN) backref revision 1
[   94.239636][  T337]
[   94.249280][  T337] fs uuid 3f698242-c4db-4b90-9aef-804b56f2bb6e
[   94.249286][  T337]
[   94.258358][  T337] chunk uuid a7c33201-4d1f-44e0-8491-d386f70f1ac7
[   94.258363][  T337]
[   94.267903][  T337]  item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
[   94.267909][  T337]
[   94.278519][  T337]          devid 1 total_bytes 322122547200 bytes_used 2172649472
[   94.278524][  T337]
[   94.288713][  T337]          io_align 4096 io_width 4096 sector_size 4096 type 0
[   94.288718][  T337]
[   94.298450][  T337]          generation 0 start_offset 0 dev_group 0
[   94.298455][  T337]
[   94.306862][  T337]          seek_speed 0 bandwidth 0
[   94.306868][  T337]
[   94.314295][  T337]          uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[   94.314300][  T337]
[   94.323221][  T337]          fsid 3f698242-c4db-4b90-9aef-804b56f2bb6e
[   94.323235][  T337]
[   94.332728][  T337]  item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
[   94.332733][  T337]
[   94.344629][  T337]          length 8388608 owner 2 stripe_len 65536 type DATA
[   94.344635][  T337]
[   94.354342][  T337]          io_align 65536 io_width 65536 sector_size 4096
[   94.354348][  T337]
[   94.363469][  T337]          num_stripes 1 sub_stripes 1
[   94.363475][  T337]
[   94.370987][  T337]                  stripe 0 devid 1 offset 13631488
[   94.370993][  T337]
[   94.379293][  T337]                  dev_uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[   94.379298][  T337]
[   94.389332][  T337]  item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 itemsize 112
[   94.389337][  T337]
[   94.401456][  T337]          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
[   94.401461][  T337]
[   94.411651][  T337]          io_align 65536 io_width 65536 sector_size 4096
[   94.411657][  T337]
[   94.420718][  T337]          num_stripes 2 sub_stripes 1
[   94.420723][  T337]
[   94.428297][  T337]                  stripe 0 devid 1 offset 22020096
[   94.428302][  T337]
[   94.436583][  T337]                  dev_uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[   94.436588][  T337]
[   94.445784][  T337]                  stripe 1 devid 1 offset 30408704
[   94.445789][  T337]
[   94.454060][  T337]                  dev_uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[   94.454066][  T337]
[   94.463995][  T337]  item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 itemsize 112
[   94.464001][  T337]
[   94.476279][  T337]          length 1073741824 owner 2 stripe_len 65536 type METADATA|DUP
[   94.476288][  T337]
[   94.486957][  T337]          io_align 65536 io_width 65536 sector_size 4096
[   94.486963][  T337]
[   94.496023][  T337]          num_stripes 2 sub_stripes 1
[   94.496029][  T337]
[   94.503588][  T337]                  stripe 0 devid 1 offset 38797312
[   94.503594][  T337]
[   94.511891][  T337]                  dev_uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[   94.511897][  T337]
[   94.521097][  T337]                  stripe 1 devid 1 offset 1112539136
[   94.521102][  T337]
[   94.529560][  T337]                  dev_uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[   94.529566][  T337]
[   94.538649][  T337] 2022-03-17 03:28:18 sleep 10
[   94.538654][  T337]
[  104.223120][  T337] 2022-03-17 03:28:28 btrfs ins dump-super -f /dev/sdb2
[  104.223129][  T337]
[  104.232956][  T337] superblock: bytenr=65536, device=/dev/sdb2
[  104.232962][  T337]
[  104.242015][  T337] ---------------------------------------------------------
[  104.242021][  T337]
[  104.251907][  T337] csum_type                0 (crc32c)
[  104.251912][  T337]
[  104.258378][  T337] csum_size                4
[  104.258383][  T337]
[  104.264296][  T337] csum                     0xe574a9d1 [match]
[  104.264300][  T337]
[  104.271125][  T337] bytenr                   65536
[  104.271130][  T337]
[  104.276917][  T337] flags                    0x1
[  104.276922][  T337]
[  104.282504][  T337]                  ( WRITTEN )
[  104.282509][  T337]
[  104.288568][  T337] magic                    _BHRfS_M [match]
[  104.288573][  T337]
[  104.295818][  T337] fsid                     3f698242-c4db-4b90-9aef-804b56f2bb6e
[  104.295823][  T337]
[  104.304849][  T337] metadata_uuid            3f698242-c4db-4b90-9aef-804b56f2bb6e
[  104.304854][  T337]
[  104.313828][  T337] label
[  104.313833][  T337]
[  104.319132][  T337] generation               6
[  104.319136][  T337]
[  104.324922][  T337] root                     30654464
[  104.324927][  T337]
[  104.330926][  T337] sys_array_size           129
[  104.330931][  T337]
[  104.337401][  T337] chunk_root_generation    6
[  104.337406][  T337]
[  104.344026][  T337] root_level               0
[  104.344031][  T337]
[  104.349877][  T337] chunk_root               22036480
[  104.349882][  T337]
[  104.356346][  T337] chunk_root_level 0
[  104.356351][  T337]
[  104.362501][  T337] log_root         0
[  104.362506][  T337]
[  104.368192][  T337] log_root_transid 0
[  104.368197][  T337]
[  104.374462][  T337] log_root_level           0
[  104.374467][  T337]
[  104.380741][  T337] total_bytes              322122547200
[  104.380746][  T337]
[  104.387601][  T337] bytes_used               196608
[  104.387606][  T337]
[  104.393820][  T337] sectorsize               4096
[  104.393825][  T337]
[  104.399864][  T337] nodesize         16384
[  104.399869][  T337]
[  104.406022][  T337] leafsize (deprecated)            16384
[  104.406027][  T337]
[  104.413112][  T337] stripesize               4096
[  104.413117][  T337]
[  104.419095][  T337] root_dir         6
[  104.419099][  T337]
[  104.424681][  T337] num_devices              1
[  104.424686][  T337]
[  104.430566][  T337] compat_flags             0x0
[  104.430571][  T337]
[  104.436779][  T337] compat_ro_flags          0x3
[  104.436784][  T337]
[  104.443332][  T337]                  ( FREE_SPACE_TREE |
[  104.443337][  T337]
[  104.450096][  T337]                    FREE_SPACE_TREE_VALID )
[  104.450101][  T337]
[  104.457309][  T337] incompat_flags           0x341
[  104.457314][  T337]
[  104.463873][  T337]                  ( MIXED_BACKREF |
[  104.463878][  T337]
[  104.470372][  T337]                    EXTENDED_IREF |
[  104.470377][  T337]
[  104.476866][  T337]                    SKINNY_METADATA |
[  104.476871][  T337]
[  104.483439][  T337]                    NO_HOLES )
[  104.483444][  T337]
[  104.489482][  T337] cache_generation 0
[  104.489487][  T337]
[  104.495818][  T337] uuid_tree_generation     0
[  104.495823][  T337]
[  104.503027][  T337] dev_item.uuid            2acf3fb5-c521-4863-99c0-2cccde7f72af
[  104.503032][  T337]
[  104.512859][  T337] dev_item.fsid            3f698242-c4db-4b90-9aef-804b56f2bb6e [match]
[  104.512864][  T337]
[  104.522669][  T337] dev_item.type            0
[  104.522674][  T337]
[  104.529015][  T337] dev_item.total_bytes     322122547200
[  104.529020][  T337]
[  104.536786][  T337] dev_item.bytes_used      2172649472
[  104.536791][  T337]
[  104.544214][  T337] dev_item.io_align        4096
[  104.544227][  T337]
[  104.550886][  T337] dev_item.io_width        4096
[  104.550890][  T337]
[  104.557600][  T337] dev_item.sector_size     4096
[  104.557605][  T337]
[  104.564490][  T337] dev_item.devid           1
[  104.564495][  T337]
[  104.570702][  T337] dev_item.dev_group       0
[  104.570707][  T337]
[  104.577224][  T337] dev_item.seek_speed      0
[  104.577229][  T337]
[  104.583769][  T337] dev_item.bandwidth       0
[  104.583774][  T337]
[  104.590288][  T337] dev_item.generation      0
[  104.590293][  T337]
[  104.596867][  T337] sys_chunk_array[2048]:
[  104.596872][  T337]
[  104.604027][  T337]  item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
[  104.604032][  T337]
[  104.613761][  T337]          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
[  104.613766][  T337]
[  104.623962][  T337]          io_align 65536 io_width 65536 sector_size 4096
[  104.623967][  T337]
[  104.633004][  T337]          num_stripes 2 sub_stripes 1
[  104.633008][  T337]
[  104.640526][  T337]                  stripe 0 devid 1 offset 22020096
[  104.640531][  T337]
[  104.648803][  T337]                  dev_uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[  104.648808][  T337]
[  104.657956][  T337]                  stripe 1 devid 1 offset 30408704
[  104.657961][  T337]
[  104.666236][  T337]                  dev_uuid 2acf3fb5-c521-4863-99c0-2cccde7f72af
[  104.666241][  T337]
[  104.675067][  T337] backup_roots[4]:
[  104.675072][  T337]
[  104.681035][  T337]  backup 0:
[  104.681040][  T337]
[  104.687028][  T337]          backup_tree_root:       30490624        gen: 5  level: 0
[  104.687033][  T337]
[  104.696005][  T337]          backup_chunk_root:      22020096        gen: 5  level: 0
[  104.696010][  T337]
[  104.705091][  T337]          backup_extent_root:     30507008        gen: 5  level: 0
[  104.705096][  T337]
[  104.714236][  T337]          backup_fs_root:         30474240        gen: 5  level: 0
[  104.714241][  T337]
[  104.723079][  T337]          backup_dev_root:        30523392        gen: 5  level: 0
[  104.723084][  T337]
[  104.731944][  T337]          backup_csum_root:       30539776        gen: 5  level: 0
[  104.731949][  T337]
[  104.740749][  T337]          backup_total_bytes:     322122547200
[  104.740754][  T337]
[  104.748608][  T337]          backup_bytes_used:      196608
[  104.748613][  T337]
[  104.755736][  T337]          backup_num_devices:     1
[  104.755741][  T337]
[  104.762131][  T337]
[  104.762135][  T337]
[  104.766687][  T337]  backup 1:
[  104.766692][  T337]
[  104.772697][  T337]          backup_tree_root:       30654464        gen: 6  level: 0
[  104.772702][  T337]
[  104.781702][  T337]          backup_chunk_root:      22036480        gen: 6  level: 0
[  104.781707][  T337]
[  104.790822][  T337]          backup_extent_root:     30408704        gen: 6  level: 0
[  104.790827][  T337]
[  104.799929][  T337]          backup_fs_root:         30474240        gen: 5  level: 0
[  104.799934][  T337]
[  104.808842][  T337]          backup_dev_root:        30425088        gen: 6  level: 0
[  104.808847][  T337]
[  104.817759][  T337]          backup_csum_root:       30539776        gen: 5  level: 0
[  104.817764][  T337]
[  104.826590][  T337]          backup_total_bytes:     322122547200
[  104.826595][  T337]
[  104.834424][  T337]          backup_bytes_used:      196608
[  104.834429][  T337]
[  104.841566][  T337]          backup_num_devices:     1
[  104.841571][  T337]
[  104.847961][  T337]
[  104.847965][  T337]
[  104.852537][  T337]  backup 2:
[  104.852542][  T337]
[  104.858545][  T337]          backup_tree_root:       5308416 gen: 3  level: 0
[  104.858550][  T337]
[  104.867455][  T337]          backup_chunk_root:      1048576 gen: 3  level: 0
[  104.867460][  T337]
[  104.876485][  T337]          backup_extent_root:     5275648 gen: 3  level: 0
[  104.876490][  T337]
[  104.885519][  T337]          backup_fs_root:         5324800 gen: 3  level: 0
[  104.885523][  T337]
[  104.894298][  T337]          backup_dev_root:        5259264 gen: 3  level: 0
[  104.894303][  T337]
[  104.903075][  T337]          backup_csum_root:       1130496 gen: 1  level: 0
[  104.903080][  T337]
[  104.911786][  T337]          backup_total_bytes:     322122547200
[  104.911791][  T337]
[  104.919634][  T337]          backup_bytes_used:      114688
[  104.919639][  T337]
[  104.926750][  T337]          backup_num_devices:     1
[  104.926755][  T337]
[  104.933181][  T337]
[  104.933194][  T337]
[  104.937748][  T337]  backup 3:
[  104.937753][  T337]
[  104.943802][  T337]          backup_tree_root:       30457856        gen: 4  level: 0
[  104.943807][  T337]
[  104.952813][  T337]          backup_chunk_root:      1064960 gen: 4  level: 0
[  104.952818][  T337]
[  104.961824][  T337]          backup_extent_root:     5341184 gen: 4  level: 0
[  104.961829][  T337]
[  104.970886][  T337]          backup_fs_root:         5324800 gen: 3  level: 0
[  104.970891][  T337]
[  104.979687][  T337]          backup_dev_root:        5242880 gen: 4  level: 0
[  104.979692][  T337]
[  104.988495][  T337]          backup_csum_root:       1130496 gen: 1  level: 0
[  104.988500][  T337]
[  104.997229][  T337]          backup_total_bytes:     322122547200
[  104.997234][  T337]
[  105.005037][  T337]          backup_bytes_used:      163840
[  105.005042][  T337]
[  105.012209][  T337]          backup_num_devices:     1
[  105.012214][  T337]
[  105.018623][  T337]
[  105.018627][  T337]
[  105.023017][  T337]
[  105.023022][  T337]
[  105.027867][  T337] 2022-03-17 03:28:28 sleep 10
[  105.027872][  T337]
[  114.237911][  T337] 2022-03-17 03:28:38 ~~~~~~~~~~~~~~ /dev/sdb2 end ~~~~~~~~~~~~~~
......

[  237.925789][  T337] 2022-03-17 03:30:41 export TEST_DIR=/fs/sdb1
[  237.925803][  T337]
[  237.936048][  T337] 2022-03-17 03:30:41 export TEST_DEV=/dev/sdb1
[  237.936060][  T337]
[  237.945651][  T337] 2022-03-17 03:30:42 export FSTYP=btrfs
[  237.945662][  T337]
[  237.954997][  T337] 2022-03-17 03:30:42 export SCRATCH_MNT=/fs/scratch
[  237.955008][  T337]
[  237.965136][  T337] 2022-03-17 03:30:42 mkdir /fs/scratch -p
[  237.965147][  T337]
[  237.976340][  T337] 2022-03-17 03:30:42 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
[  237.976352][  T337]
[  237.990723][  T337] 2022-03-17 03:30:42 sed "s:^:btrfs/:" //lkp/benchmarks/xfstests/tests/btrfs-group-07
[  237.990730][  T337]
[  238.005026][  T337] 2022-03-17 03:30:42 ./check btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074 btrfs/075 btrfs/076 btrfs/077 btrfs/078 btrfs/079
[  238.005036][  T337]
[  238.131570][ T1922] BTRFS info (device sdb1): flagging fs with big metadata feature
[  238.139579][ T1922] BTRFS info (device sdb1): using free space tree
[  238.145869][ T1922] BTRFS info (device sdb1): has skinny extents
[  238.394777][  T337] FSTYP         -- btrfs
[  238.394787][  T337]
[  238.407841][  T337] PLATFORM      -- Linux/x86_64 lkp-hsw-d01 5.17.0-rc4-00095-g7f159e82828e #1 SMP Fri Mar 11 09:25:41 CST 2022
[  238.407849][  T337]
[  238.422205][  T337] MKFS_OPTIONS  -- /dev/sdb2
[  238.422213][  T337]
[  238.429812][  T337] MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
[  238.429820][  T337]
[  238.437551][  T337]
[  238.437556][  T337]
[  238.509573][ T2041] BTRFS: device fsid 00974d0e-c70a-4d86-a40a-ad3675406027 devid 1 transid 5 /dev/sdb2 scanned by mkfs.btrfs (2041)
[  238.543241][ T2052] BTRFS info (device sdb2): flagging fs with big metadata feature
[  238.550999][ T2052] BTRFS info (device sdb2): disk space caching is enabled
[  238.557986][ T2052] BTRFS info (device sdb2): has skinny extents
[  238.565970][ T2052] BTRFS info (device sdb2): leaf 65536 gen 30556160 total ptrs 0 free space 16283 owner 22036480
[  238.576361][ T2052] ------------[ cut here ]------------
[  238.581694][ T2052] kernel BUG at fs/btrfs/volumes.c:7157!
[  238.587222][ T2052] invalid opcode: 0000 [#1] SMP KASAN PTI
[  238.592808][ T2052] CPU: 5 PID: 2052 Comm: mount Not tainted 5.17.0-rc4-00095-g7f159e82828e #1
[  238.601424][ T2052] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[  238.609347][ T2052] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
[  238.615411][ T2052] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85 19 fb ff ff <0f> 0b 4c 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b 7c 24 78
[  238.634889][ T2052] RSP: 0018:ffffc900033cf6c8 EFLAGS: 00010246
[  238.640817][ T2052] RAX: ffff8881028b2980 RBX: 0000000000000000 RCX: 0000000000000000
[  238.648652][ T2052] RDX: 0000000000000000 RSI: 0000000000000008 RDI: fffff52000679e75
[  238.656487][ T2052] RBP: 000000000000033c R08: 000000000000005e R09: ffffed1034dd6791
[  238.661055][  T339] 512+0 records in
[  238.664320][ T2052] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 R12: ffff88812830c500
[  238.664322][ T2052] R13: ffff8881028b2998 R14: ffff8881028b299c R15: 0000000000000022
[  238.664323][ T2052] FS:  00007f66fb9b4100(0000) GS:ffff8881a6e80000(0000) knlGS:0000000000000000
[  238.664325][ T2052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  238.664327][ T2052] CR2: 000055f0bbc19d40 CR3: 0000000209c0a005 CR4: 00000000001706e0
[  238.667935][  T339]
[  238.675758][ T2052] Call Trace:
[  238.675761][ T2052]  <TASK>
[  238.675762][ T2052]  ? _raw_spin_lock+0x81/0x100
[  238.719432][ T2052]  ? _raw_spin_lock_bh+0x100/0x100
[  238.724404][ T2052]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
[  238.731635][ T2052]  ? add_missing_dev+0x3c0/0x3c0 [btrfs]
[  238.731805][  T339] 512+0 records out
[  238.737188][  T339]
[  238.737177][ T2052]  ? btrfs_get_token_64+0x700/0x700 [btrfs]
[  238.748791][ T2052]  ? memcpy+0x39/0x80
[  238.752632][ T2052]  ? write_extent_buffer+0x192/0x240 [btrfs]
[  238.758510][ T2052]  btrfs_read_sys_array+0x2c7/0x380 [btrfs]
[  238.764301][ T2052]  ? read_one_dev+0x13c0/0x13c0 [btrfs]
[  238.769742][ T2052]  ? mutex_lock+0x80/0x100
[  238.774016][ T2052]  ? __mutex_lock_slowpath+0x40/0x40
[  238.779169][ T2052]  ? btrfs_init_workqueues+0x4c1/0x7ba [btrfs]
[  238.785244][ T2052]  open_ctree+0x16ac/0x2656 [btrfs]
[  238.790345][ T2052]  btrfs_mount_root.cold+0x13/0x192 [btrfs]
[  238.796139][ T2052]  ? arch_stack_walk+0x9e/0x100
[  238.800848][ T2052]  ? parse_rescue_options+0x300/0x300 [btrfs]
[  238.806803][ T2052]  ? vfs_parse_fs_param_source+0x3b/0x1c0
[  238.812382][ T2052]  ? legacy_parse_param+0x6a/0x7c0
[  238.817352][ T2052]  ? parse_rescue_options+0x300/0x300 [btrfs]
[  238.823313][ T2052]  legacy_get_tree+0xef/0x200
[  238.827848][ T2052]  vfs_get_tree+0x84/0x2c0
[  238.832122][ T2052]  fc_mount+0xf/0x80
[  238.835879][ T2052]  vfs_kern_mount+0x71/0xc0
[  238.840852][ T2052]  btrfs_mount+0x1fc/0xa40 [btrfs]
[  238.845864][ T2052]  ? kasan_save_stack+0x1e/0x40
[  238.850573][ T2052]  ? kasan_set_track+0x21/0x40
[  238.855202][ T2052]  ? kasan_set_free_info+0x20/0x40
[  238.860181][ T2052]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
[  238.865988][ T2052]  ? __x64_sys_mount+0x12c/0x1c0
[  238.870784][ T2052]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[  238.876709][ T2052]  ? terminate_walk+0x203/0x4c0
[  238.881415][ T2052]  ? vfs_parse_fs_param_source+0x3b/0x1c0
[  238.886993][ T2052]  ? legacy_parse_param+0x6a/0x7c0
[  238.891963][ T2052]  ? vfs_parse_fs_string+0xd7/0x140
[  238.897021][ T2052]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
[  238.902809][ T2052]  ? legacy_get_tree+0xef/0x200
[  238.907519][ T2052]  legacy_get_tree+0xef/0x200
[  238.912051][ T2052]  ? security_capable+0x56/0xc0
[  238.916761][ T2052]  vfs_get_tree+0x84/0x2c0
[  238.921036][ T2052]  ? ns_capable_common+0x57/0x100
[  238.925921][ T2052]  path_mount+0x7fc/0x1a40
[  238.930205][ T2052]  ? kasan_set_track+0x21/0x40
[  238.934838][ T2052]  ? finish_automount+0x600/0x600
[  238.939722][ T2052]  ? kmem_cache_free+0xa1/0x400
[  238.944434][ T2052]  do_mount+0xca/0x100
[  238.948362][ T2052]  ? path_mount+0x1a40/0x1a40
[  238.952900][ T2052]  ? _copy_from_user+0x94/0x100
[  238.957609][ T2052]  ? memdup_user+0x4e/0x80
[  238.961886][ T2052]  __x64_sys_mount+0x12c/0x1c0
[  238.966510][ T2052]  do_syscall_64+0x3b/0xc0
[  238.970791][ T2052]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  238.976554][ T2052] RIP: 0033:0x7f66fbbb2fea
[  238.980840][ T2052] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
[  239.000318][ T2052] RSP: 002b:00007fffa196f178 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  239.008593][ T2052] RAX: ffffffffffffffda RBX: 0000562feab9a970 RCX: 00007f66fbbb2fea
[  239.016430][ T2052] RDX: 0000562feab9ab80 RSI: 0000562feab9abc0 RDI: 0000562feab9aba0
[  239.024264][ T2052] RBP: 00007f66fbf001c4 R08: 0000000000000000 R09: 0000562feab9d890
[  239.032108][ T2052] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  239.039946][ T2052] R13: 0000000000000000 R14: 0000562feab9aba0 R15: 0000562feab9ab80
[  239.047783][ T2052]  </TASK>
[  239.050664][ T2052] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi sg ipmi_devintf ata_generic ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp i915 kvm_intel kvm intel_gtt ttm drm_kms_helper irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel syscopyarea ghash_clmulni_intel sysfillrect mei_wdt sysimgblt fb_sys_fops ata_piix rapl intel_cstate mei_me drm libata mei intel_uncore video ip_tables
[  239.094228][ T2052] ---[ end trace 0000000000000000 ]---
[  239.099560][ T2052] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
[  239.105641][ T2052] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85 19 fb ff ff <0f> 0b 4c 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b 7c 24 78
[  239.125151][ T2052] RSP: 0018:ffffc900033cf6c8 EFLAGS: 00010246
[  239.131117][ T2052] RAX: ffff8881028b2980 RBX: 0000000000000000 RCX: 0000000000000000
[  239.138981][ T2052] RDX: 0000000000000000 RSI: 0000000000000008 RDI: fffff52000679e75
[  239.146847][ T2052] RBP: 000000000000033c R08: 000000000000005e R09: ffffed1034dd6791
[  239.154710][ T2052] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 R12: ffff88812830c500
[  239.162579][ T2052] R13: ffff8881028b2998 R14: ffff8881028b299c R15: 0000000000000022
[  239.170443][ T2052] FS:  00007f66fb9b4100(0000) GS:ffff8881a6e80000(0000) knlGS:0000000000000000
[  239.179267][ T2052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  239.185742][ T2052] CR2: 000055f0bbc19d40 CR3: 0000000209c0a005 CR4: 00000000001706e0
[  239.193607][ T2052] Kernel panic - not syncing: Fatal exception
[  239.199567][ T2052] Kernel Offset: disabled

> 
> Thanks,
> Qu
>>
>> [   44.577527][ T1980] ------------[ cut here ]------------
>> [   44.583552][  T335]
>> [   44.583990][  T337] 512+0 records out
>> [   44.583997][  T337]
>> [   44.593932][ T1980] kernel BUG at fs/btrfs/volumes.c:7157!
>> [   44.593940][ T1980] invalid opcode: 0000 [#1] SMP KASAN PTI
>> [   44.598832][  T335]   Data:             single            8.00MiB
>> [   44.603293][ T1980] CPU: 5 PID: 1980 Comm: mount Not tainted 5.17.0-rc4-00095-g7f159e82828e #1
>> [   44.603297][ T1980] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
>> [   44.603299][ T1980] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
>> [   44.605509][  T335]
>> [   44.609168][ T1980] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85 19 fb ff ff <0f> 0b 4c
>> 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b 7c 24 78
>> [   44.609171][ T1980] RSP: 0018:ffffc90002be76c8 EFLAGS: 00010246
>> [   44.609175][ T1980] RAX: ffff888102c98e00 RBX: 0000000000000000 RCX: 0000000000000000
>> [   44.609178][ T1980] RDX: 0000000000000000 RSI: 0000000000000008 RDI: fffff5200057ce75
>> [   44.612227][  T335]   Metadata:         DUP               1.00GiB
>> [   44.616871][ T1980] RBP: 000000000000033c R08: 000000000000005e R09: ffffed1034dd6791
>> [   44.616873][ T1980] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 R12: ffff888214586b40
>> [   44.616874][ T1980] R13: ffff888102c98e18 R14: ffff888102c98e1c R15: 0000000000000022
>> [   44.616876][ T1980] FS:  00007fad1bd12100(0000) GS:ffff8881a6e80000(0000) knlGS:0000000000000000
>> [   44.622475][  T335]
>> [   44.628578][ T1980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   44.628580][ T1980] CR2: 00007fff9d90df68 CR3: 00000001407fc003 CR4: 00000000001706e0
>> [   44.628583][ T1980] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   44.628585][ T1980] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   44.628588][ T1980] Call Trace:
>> [   44.638095][  T335]   System:           DUP               8.00MiB
>> [   44.645166][ T1980]  <TASK>
>> [   44.645168][ T1980]  ? _raw_spin_lock+0x81/0x100
>> [   44.651206][  T335]
>> [   44.653388][ T1980]  ? _raw_spin_lock_bh+0x100/0x100
>> [   44.653395][ T1980]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>> [   44.673370][  T335] SSD detected:       no
>> [   44.678876][ T1980]  ? add_missing_dev+0x3c0/0x3c0 [btrfs]
>> [   44.686756][  T335]
>> [   44.694598][ T1980]  ? btrfs_get_token_64+0x700/0x700 [btrfs]
>> [   44.701187][  T335] Zoned device:       no
>> [   44.708574][ T1980]  ? memcpy+0x39/0x80
>> [   44.708581][ T1980]  ? write_extent_buffer+0x192/0x240 [btrfs]
>> [   44.716449][  T335]
>> [   44.724294][ T1980]  btrfs_read_sys_array+0x2c7/0x380 [btrfs]
>> [   44.734138][  T335] Incompat features:  extref, skinny-metadata, no-holes
>> [   44.735313][ T1980]  ? read_one_dev+0x13c0/0x13c0 [btrfs]
>> [   44.741786][  T335]
>> [   44.749628][ T1980]  ? mutex_lock+0x80/0x100
>> [   44.749634][ T1980]  ? __mutex_lock_slowpath+0x40/0x40
>> [   44.758164][  T335] Runtime features:   free-space-tree
>> [   44.765352][ T1980]  ? btrfs_init_workqueues+0x4c1/0x7ba [btrfs]
>> [   44.768515][  T335]
>> [   44.774620][ T1980]  open_ctree+0x16ac/0x2656 [btrfs]
>> [   44.777966][  T335] Checksum:           crc32c
>> [   44.782064][ T1980]  btrfs_mount_root.cold+0x13/0x192 [btrfs]
>> [   44.784268][  T335]
>> [   44.789241][ T1980]  ? arch_stack_walk+0x9e/0x100
>> [   44.789247][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
>> [   44.796977][  T335] Number of devices:  1
>> [   44.800614][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
>> [   44.806131][  T335]
>> [   44.808314][ T1980]  ? legacy_parse_param+0x6a/0x7c0
>> [   44.808320][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
>> [   44.814273][  T335] Devices:
>> [   44.818205][ T1980]  legacy_get_tree+0xef/0x200
>> [   44.818210][ T1980]  vfs_get_tree+0x84/0x2c0
>> [   44.822077][  T335]
>> [   44.827928][ T1980]  fc_mount+0xf/0x80
>> [   44.827934][ T1980]  vfs_kern_mount+0x71/0xc0
>> [   44.830557][  T335]    ID        SIZE  PATH
>> [   44.835890][ T1980]  btrfs_mount+0x1fc/0xa40 [btrfs]
>> [   44.842730][  T335]
>> [   44.848134][ T1980]  ? kasan_save_stack+0x1e/0x40
>> [   44.848149][ T1980]  ? kasan_set_track+0x21/0x40
>> [   44.850862][  T335]     1   300.00GiB  /dev/sdb4
>> [   44.854618][ T1980]  ? kasan_set_free_info+0x20/0x40
>> [   44.854624][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
>> [   44.859803][  T335]
>> [   44.865032][ T1980]  ? __x64_sys_mount+0x12c/0x1c0
>> [   44.865036][ T1980]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [   44.871101][  T335]
>> [   44.873263][ T1980]  ? terminate_walk+0x203/0x4c0
>> [   44.873268][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
>> [   44.878354][  T335]
>> [   44.882803][ T1980]  ? legacy_parse_param+0x6a/0x7c0
>> [   44.882808][ T1980]  ? vfs_parse_fs_string+0xd7/0x140
>> [   44.889280][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb1
>> [   44.890770][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
>> [   44.895501][  T335]
>> [   44.901430][ T1980]  ? legacy_get_tree+0xef/0x200
>> [   44.901435][ T1980]  legacy_get_tree+0xef/0x200
>> [   44.901448][ T1980]  ? security_capable+0x56/0xc0
>> [   44.905612][  T335]  btrfs
>> [   44.911057][ T1980]  vfs_get_tree+0x84/0x2c0
>> [   44.911062][ T1980]  ? ns_capable_common+0x57/0x100
>> [   44.913278][  T335]
>> [   44.918247][ T1980]  path_mount+0x7fc/0x1a40
>> [   44.918252][ T1980]  ? kasan_set_track+0x21/0x40
>> [   44.925201][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb1 /fs/sdb1
>> [   44.927087][ T1980]  ? finish_automount+0x600/0x600
>> [   44.927092][ T1980]  ? kmem_cache_free+0xa1/0x400
>> [   44.931642][  T335]
>> [   44.935926][ T1980]  do_mount+0xca/0x100
>> [   44.935931][ T1980]  ? path_mount+0x1a40/0x1a40
>> [   44.935933][ T1980]  ? _copy_from_user+0x94/0x100
>> [   44.938799][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb2
>> [   44.941885][ T1980]  ? memdup_user+0x4e/0x80
>> [   44.941890][ T1980]  __x64_sys_mount+0x12c/0x1c0
>> [   44.941893][ T1980]  do_syscall_64+0x3b/0xc0
>> [   44.946884][  T335]
>> [   44.951068][ T1980]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [   44.951074][ T1980] RIP: 0033:0x7fad1bf10fea
>> [   44.951077][ T1980] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
>> f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
>> [   44.956197][  T335]  btrfs
>> [   44.958245][ T1980] RSP: 002b:00007fff9d90f878 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
>> [   44.958249][ T1980] RAX: ffffffffffffffda RBX: 00005628efc57970 RCX: 00007fad1bf10fea
>> [   44.958251][ T1980] RDX: 00005628efc57b80 RSI: 00005628efc57bc0 RDI: 00005628efc57ba0
>> [   44.958263][ T1980] RBP: 00007fad1c25e1c4 R08: 0000000000000000 R09: 00005628efc5a890
>> [   44.958264][ T1980] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> [   44.962993][  T335]
>> [   44.967613][ T1980] R13: 0000000000000000 R14: 00005628efc57ba0 R15: 00005628efc57b80
>> [   44.967616][ T1980]  </TASK>
>> [   44.967617][ T1980] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq
>> [   44.973257][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb2 /fs/sdb2
>> [   44.977243][ T1980]  zstd_compress libcrc32c sd_mod t10_pi sg
>> [   44.983019][  T335]
>> [   44.985203][ T1980]  ipmi_devintf ata_generic ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
>> [   44.990720][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb3
>> [   44.995962][ T1980]  i915 kvm intel_gtt ttm drm_kms_helper irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel syscopyarea sysfillrect
>> [   44.998174][  T335]
>> [   45.002882][ T1980]  sysimgblt rapl mei_wdt fb_sys_fops ata_piix intel_cstate libata drm mei_me mei intel_uncore video ip_tables
>> [   45.002919][ T1980] ---[ end trace 0000000000000000 ]---
>>
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>
>>>> [   75.279958][ T3602] ------------[ cut here ]------------
>>>> [   75.285221][ T3602] kernel BUG at fs/btrfs/scrub.c:3387!
>>>> [   75.290490][ T3602] invalid opcode: 0000 [#1] SMP KASAN PTI
>>>> [   75.296010][ T3602] CPU: 2 PID: 3602 Comm: btrfs Not tainted 5.17.0-rc4-00095-g6b837d4c40d5 #1
>>>> [   75.304521][ T3602] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
>>>> [   75.312344][ T3602] RIP: 0010:scrub_stripe+0xed3/0x1340 [btrfs]
>>>> [   75.318250][ T3602] Code: 90 00 00 00 e8 0e f9 96 c0 e9 98 f3 ff ff e8 c4 f9 96 c0 e9 26 f3 ff ff 48 8b bc 24 80 00 00 00 e8 f2 f8 96 c0 e9 3b f4 ff ff <0f> 0b 0f
>>>> 0b 4c 8d a4 24 b8 01 00 00 31 f6 4c 8d bd 20 02 00 00 4c
>>>> [   75.337480][ T3602] RSP: 0018:ffffc9000b47f550 EFLAGS: 00010246
>>>> [   75.343340][ T3602] RAX: 0000000000000007 RBX: ffff88810231d600 RCX: ffff88810231d61c
>>>> [   75.351074][ T3602] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881023a2458
>>>> [   75.358807][ T3602] RBP: ffff8881097ad800 R08: 0000000000000001 R09: ffffed102828100d
>>>> [   75.366550][ T3602] R10: ffff888141408063 R11: ffffed102828100c R12: 0000000000000000
>>>> [   75.374282][ T3602] R13: 0000000000100000 R14: ffff888141408000 R15: ffff888129c9c000
>>>> [   75.382016][ T3602] FS:  00007f94c24ec8c0(0000) GS:ffff8881a6d00000(0000) knlGS:0000000000000000
>>>> [   75.390691][ T3602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   75.397054][ T3602] CR2: 00007ffe454aa8e8 CR3: 000000020a796004 CR4: 00000000001706e0
>>>> [   75.404785][ T3602] Call Trace:
>>>> [   75.407886][ T3602]  <TASK>
>>>> [   75.410645][ T3602]  ? btrfs_wait_ordered_extents+0x9a1/0xe40 [btrfs]
>>>> [   75.417049][ T3602]  ? scrub_raid56_parity+0x5c0/0x5c0 [btrfs]
>>>> [   75.422853][ T3602]  ? btrfs_remove_ordered_extent+0xbc0/0xbc0 [btrfs]
>>>> [   75.429341][ T3602]  ? mutex_unlock+0x80/0x100
>>>> [   75.433733][ T3602]  ? __wake_up_common_lock+0xe3/0x140
>>>> [   75.438897][ T3602]  ? __lookup_extent_mapping+0x215/0x300 [btrfs]
>>>> [   75.445037][ T3602]  scrub_chunk+0x294/0x480 [btrfs]
>>>> [   75.449984][ T3602]  scrub_enumerate_chunks+0x643/0x1340 [btrfs]
>>>> [   75.455962][ T3602]  ? scrub_chunk+0x480/0x480 [btrfs]
>>>> [   75.461083][ T3602]  ? __scrub_blocked_if_needed+0xb9/0x200 [btrfs]
>>>> [   75.467317][ T3602]  ? scrub_checksum_data+0x4c0/0x4c0 [btrfs]
>>>> [   75.473121][ T3602]  ? down_read+0x137/0x240
>>>> [   75.477339][ T3602]  ? mutex_unlock+0x80/0x100
>>>> [   75.481726][ T3602]  ? __mutex_unlock_slowpath+0x300/0x300
>>>> [   75.487743][ T3602]  ? btrfs_find_device+0xac/0x240 [btrfs]
>>>> [   75.493285][ T3602]  btrfs_scrub_dev+0x535/0xc00 [btrfs]
>>>> [   75.498578][ T3602]  ? scrub_enumerate_chunks+0x1340/0x1340 [btrfs]
>>>> [   75.504812][ T3602]  ? btrfs_apply_pending_changes+0x80/0x80 [btrfs]
>>>> [   75.511120][ T3602]  ? btrfs_record_root_in_trans+0x4d/0x180 [btrfs]
>>>> [   75.517428][ T3602]  ? finish_wait+0x280/0x280
>>>> [   75.521819][ T3602]  btrfs_dev_replace_by_ioctl.cold+0x62c/0x720 [btrfs]
>>>> [   75.528483][ T3602]  ? btrfs_finish_block_group_to_copy+0x3c0/0x3c0 [btrfs]
>>>> [   75.535440][ T3602]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>>>> [   75.542575][ T3602]  btrfs_ioctl+0x37ee/0x51c0 [btrfs]
>>>> [   75.547691][ T3602]  ? fput_many+0xaa/0x140
>>>> [   75.551823][ T3602]  ? filp_close+0xef/0x140
>>>> [   75.556041][ T3602]  ? __x64_sys_close+0x2d/0x80
>>>> [   75.560600][ T3602]  ? do_syscall_64+0x3b/0xc0
>>>> [   75.564991][ T3602]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [   75.570838][ T3602]  ? btrfs_ioctl_get_supported_features+0x40/0x40 [btrfs]
>>>> [   75.577756][ T3602]  ? _raw_spin_lock_irq+0x82/0xd2
>>>> [   75.582572][ T3602]  ? _raw_spin_lock+0x100/0x100
>>>> [   75.587218][ T3602]  ? fiemap_prep+0x200/0x200
>>>> [   75.591607][ T3602]  ? lockref_put_or_lock+0xc4/0x1c0
>>>> [   75.596600][ T3602]  ? do_sigaction+0x4b3/0x840
>>>> [   75.601075][ T3602]  ? __x64_sys_pidfd_send_signal+0x600/0x600
>>>> [   75.606837][ T3602]  ? __might_fault+0x4d/0x80
>>>> [   75.611226][ T3602]  ? __x64_sys_rt_sigaction+0x1d0/0x240
>>>> [   75.616558][ T3602]  ? __ia32_sys_signal+0x140/0x140
>>>> [   75.621461][ T3602]  ? __fget_light+0x57/0x540
>>>> [   75.625854][ T3602]  __x64_sys_ioctl+0x127/0x1c0
>>>> [   75.630414][ T3602]  do_syscall_64+0x3b/0xc0
>>>> [   75.634633][ T3602]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [   75.640307][ T3602] RIP: 0033:0x7f94c25df427
>>>> [   75.644533][ T3602] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01
>>>> f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
>>>> [   75.663771][ T3602] RSP: 002b:00007ffd06a4acc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>>> [   75.671937][ T3602] RAX: ffffffffffffffda RBX: 000055d51e9f72a0 RCX: 00007f94c25df427
>>>> [   75.679671][ T3602] RDX: 00007ffd06a4b108 RSI: 00000000ca289435 RDI: 0000000000000004
>>>> [   75.687404][ T3602] RBP: 00000000ffffffff R08: 0000000000000000 R09: 000055d51e9fa580
>>>> [   75.695137][ T3602] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffd06a4e97a
>>>> [   75.702868][ T3602] R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000005
>>>> [   75.710600][ T3602]  </TASK>
>>>> [   75.713445][ T3602] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi sg ata_generic ipmi_devintf ipmi_msghandler
>>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp i915 kvm_intel kvm intel_gtt ttm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
>>>> ghash_clmulni_intel drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops rapl ata_piix mei_wdt intel_cstate drm libata mei_me intel_uncore mei video ip_tables
>>>> [   75.756460][ T3602] ---[ end trace 0000000000000000 ]---
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
--------------hg040YMm9rBk0jTdd00U37UN
Content-Type: application/octet-stream; name="dmesg.xz"
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--------------hg040YMm9rBk0jTdd00U37UN--
