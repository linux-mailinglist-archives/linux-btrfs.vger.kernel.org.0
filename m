Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD44C287C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiBXJtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 04:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiBXJs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 04:48:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B8F15F0B8;
        Thu, 24 Feb 2022 01:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645696110; x=1677232110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2U8XEaw59NKYLUtgay0V3/FQE+8AXMeNRhvTz/yuHBY=;
  b=JuQfuJ3ayxMe91UJH8zxaBGfseYB3VeJCGrWXLXMwOYI/NARJxifZHlz
   hQHgRJCEXdAv2pcVW7AtVfFvwpwVD+BjWK9qGF2xNuhq/Yw8F+ZBMYlLC
   APhdoJ6ju6+sVdQtxetg7ib3evljX+tTv9vuaijkIfThRiKrPuZPOBobk
   dgdIWYukocNjpZJ8irajC6SMLdcgUYv1KManv6yqEDkTdIv17ZTkG3tu1
   cWiSNa5z0gA5DaLILYV5DWj4UvophWt2/ZsESruWzOoPGmzLjyzkcUYx6
   NkwcmMAjfdia4eVVx6AG21/k6rUR+J8AwfgH0TatbA5Eweia4T5GTqYPQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235703067"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="235703067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 01:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="684221924"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 01:48:29 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 01:48:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 24 Feb 2022 01:48:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 24 Feb 2022 01:48:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJdRYJTUBEXRiYLdAnAoQU7BQBm0+7ni8pfG9u7TG38GYkL4sQhUxzqerlyQmnsek1yYthfkNDWeDzfKRpZvgZ278XgkTwpUo8qFgk15dHJJQjCY+kTuvDABwXD6T2jrAE3Uxy04rOYUDTurU6mqvqsXm2RGKUEAh5U7rmS2T0MvDP9O7tGe7a+vYqRk4pKlELaB6hmj9Hljn0OWMz6P5BFz67XsLpAfI4Fu4FglucNhruQ4CPepVxXzfHFrpABAQKIPPU6wM3nSm2u7nviW95LGRiNJ6u2VgjDfF891fHiG1GrZtR7YB/E7ULs2CRDoqx+5CDVPD0PQ21UdpPDUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUeJPrelVrGQcb+msfrISmBoNhCIisIjb7lFgAXPGHA=;
 b=TaDU+0S3Qqg93ObC0yhGxUNY4EXPcNYnKHDhNi27tzQVl3F45QzRMRbl7W3+1JfL2lBPuBlowA6ra3p+2jyBnKmu43bwU1f30JG6fOcifce9VKdq9exmf9INRcNPW3IdD5Juq/1S5VdeqnnqweFKihVDiOGYSkcAjppT3Zo6hG/f9qJfV79962HHDktz62dB3JRA4ZSPetYfz2VVtt3l4a0bGz2py0H3d3cICqq3VCvqouXXBsOD7CUTvqnJuijsrk/Zmu0wZ7KPH2zg5nj+U9J6CrLlMmzifPsO2MFG917vuNLA9IaFc7oSvSfy2nBEbm1wyjwIXQTcy9sbZSSTlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by MN2PR11MB4031.namprd11.prod.outlook.com (2603:10b6:208:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 09:48:25 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 09:48:25 +0000
Message-ID: <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
Date:   Thu, 24 Feb 2022 17:48:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Souptick Joarder <jrdr.linux@gmail.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        <dsterba@suse.com>, <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, kernel test robot <lkp@intel.com>
References: <20220220144606.5695-1-jrdr.linux@gmail.com>
 <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
 <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da14db25-df76-413f-08dd-08d9f77acd43
X-MS-TrafficTypeDiagnostic: MN2PR11MB4031:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB40315E2EBCC1B8B574BDFE7CFB3D9@MN2PR11MB4031.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiwdIRWfyo8f/RDqcRGTVOXBrJeT/ePu9hU2kF/Z/0A5k5YC8KGG9O78p1jnWqXjdA1W5VGjf8shLeM/ANO1BGtsNIxFpE6vYeP0ut4ncBKBZ7GzMI0OXMECEcOP2xFSkBAA3T9N7KuDntVRc78EDhWbONk0RTL3pjJRXONjO6ZlPNPBjhpwYdaQXefh8LHIO/AZ8ts2EpxsoO1JcTf33Q+LOkDs13qnBl7Jm4QHHEucEGOgBWDEcb+HARw9D7M1loki3au7ggXZArG6tyxObXzkTZCXIb9WNmmeL+QgKylrboF1J6dXHhDy09nn1Yi6qp3Z1SGFCFETY17+3ljd9qLNl3J/m8vK6toxqv2aoNhfz1r3Bl98e/xtnHwDh6nz0Jv2/Gw90wQVzj2+CNzGceSQjukk3u9bcQFuwUKSbhXcclWDzVgPjdb0uCuqtM1jFiU/jy7eeJ4xU9owGmyxTNZ022r0HHiDy8nzb3AbVBgkucf2LqC5QncSUuoTYla5J3ohGZ5WNcWW2DR9GVZ3T6vkMPf6ffZuySlHWihaI91tiTqIvx4WvUQFFuNp3DwRb3nQalAeuaALDf1yVGbBgp/Gn5401CSvoxmkxUkn4kLgc0UDcEF1XjqkEvQ2r1KC9V9Z3O8WJuG1OSYOx55NE7RiI5MOCQUwb+qt29sQGqGz7ci2jncUp8o7K0qOxhY922XL0yXR9Zdwd+ylqqwBUbbLUD/6/2hqk1jgWuGrGu/HgQpNMBw7TVrBPtRhHL3eKOswALk3+woFKkj6Nu+lIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31686004)(8936002)(110136005)(26005)(2616005)(107886003)(86362001)(2906002)(38100700002)(31696002)(6512007)(7416002)(44832011)(5660300002)(54906003)(508600001)(316002)(6666004)(53546011)(36756003)(82960400001)(186003)(4326008)(8676002)(66946007)(83380400001)(66476007)(66556008)(6506007)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3d6aWR1RWRlZWh3UE9YUTlnenpSNmxSNmxjUU9TNDg2WFVCSlNScDhOeUtR?=
 =?utf-8?B?YWdtUjh5ZVQ1N1pidmtKZ0ZxbjdsNGI0aU5yazl6bjllM0R0S3JMZjRmNU5M?=
 =?utf-8?B?TWV4a0E1VUxRKzZtem9mV3NsdlFHbFk5b2ZRaU1TR2dvUWNQMHZsTHpRSlNO?=
 =?utf-8?B?VzJIbE9pY3hKWmRRR3ViRVVDUUQ1VENkVlRQVFlxcmUxSWlNcHNqS0p4UXJL?=
 =?utf-8?B?dW4wQXNHaUNudEdrY0NKQ3U5ZHV5OGJzSmFDQzdRYlk0VjJkb2V5WmRtSkZU?=
 =?utf-8?B?eTlyaVh5cmhvSHUvcllSN0RBbVNBM0dsWUNkbWdQRnN4OVNZT0dWQWpCYnJI?=
 =?utf-8?B?Y093NHYxNnZ1T0dTK01USko2OTlCR056S1FSQVdQZzdJZ3RhRVNpZWdPRStI?=
 =?utf-8?B?dFhPN25Ld0daOUdZbVJiU25URTdRVGpyWDVlZThob1gvbXRIMVVscUZDaDMv?=
 =?utf-8?B?UFh6VGdYUkUySEYyV3dxek4wOFphSkFub2dQaFJSRGNqUEg4TDIvRjFRYU51?=
 =?utf-8?B?aTNsbENkMDRsZmxCQWV6NURmaWY5eFJNalN2ak44UmZUR1dwalNxRDh1cXgv?=
 =?utf-8?B?QlUzQWRTYkN4cmlVYWxhSlhrcENuT2FIdmVaTThVWWcrZDczaVlqMWZ3ZXhX?=
 =?utf-8?B?bElsa0g5NEZKb0VKaG9aKzdNRFQzd1FxSElBaW84MDFZb1RYZ0ZBUUlqZXZR?=
 =?utf-8?B?bGd0Nk9PSUI5TThzZHpkZktjRVY3c1dOdkIyZUFmQUY1eHE5MzRSSGVCMS9N?=
 =?utf-8?B?aWo3djNPYm9CNHhGQ0Y1VUR6Q2lkMWsrNVh1V0czZkROSHJ4N3EvdFRPenNN?=
 =?utf-8?B?ditmeVdKRW5SVUhweFZ0NVJJSXcxeXIwYmxCNGQ5Nk96c243UXVBMmV3cW9n?=
 =?utf-8?B?NTN5WDNPZUZraVB1L2JzOUhVWlBLcDkvQ3l0b1FFbFpDWkloSFpVZjhmYldJ?=
 =?utf-8?B?L0k4WmZUSUc0cDAzZ1VGZHZ1KzVmSDhKWGw3Q2tldlo4anZLM1J3TXRQdUIw?=
 =?utf-8?B?NGkvblFyTTFTMU5ncWhEc1RNWmtvTXZFaWJhNzVMb2I1UWtuT1dGcWxyem9X?=
 =?utf-8?B?RGFUOXZhS041S3hrRmhHM2xuNCt2STdXd0paa2dTV2oxQmNBcFk4QzlnaG1t?=
 =?utf-8?B?ZjhDeVFFQkRlbkxUdm5kci92Sll5L3Fqb0F2SVQ5aVdjSFF0cmxDdEZ2QllT?=
 =?utf-8?B?ZnVoblNWU09DQThsTjc5WXcyN09XTDZnQWlHSHVaS2ovR3V5WnFYb0dpMXFu?=
 =?utf-8?B?amNBa3dlQ1JjbkFCNXV5WUI2Tkt2czFqRm50LzhyOVV4VURkWEc3NVZ3WVU1?=
 =?utf-8?B?SUdTK1EvREFtZTJLUmtCejR5bjFteDJ2R05uUVNXY0NwVUVyOVIvcnIrN3FB?=
 =?utf-8?B?L3lXVGQwbnRwTWJMSzVNaTdFQ2E0R3AvWktTTzBJdlBqU1c5SHBrT25XNExs?=
 =?utf-8?B?YzJsUEhLbkZNbXhrNTN1Uk8wZSswZHp5MlZiOWhJTEdlT3Bnd3A5Z3VOMXVl?=
 =?utf-8?B?Mk9BaVVMVnVMWDU4b0EyTnAxSXVWQ2pNSG9tbWlNdE5xbGdlOG52V3ZQclJq?=
 =?utf-8?B?L0NmVWI0MXFrN3RXTDA2dGdqeFlydXhRc0pjMnRHdkhVL1Jqa0ZsS2hDOEJL?=
 =?utf-8?B?OFdPdzh1U3lETVpWSTFNWDh6MzBDR0lOdWUzR2xxM2pUdkNUK013djhBSjIx?=
 =?utf-8?B?aHdKaG1TQWhiQjJ1UTRYQzFKd3ByZWhEd094U2lIeXEzVm42dlBpdW1VcXRz?=
 =?utf-8?B?MkdpamJiK0JzNStEczRoTlFJZ3JObGFkK1Y1bWNUKzBOT3o0anZQbDBES0NP?=
 =?utf-8?B?WnFmR3JhUnNlSkJXM0hvSGdHNWgxN0JjakZaRU5RZ3RqL25JYXByTnQzai9l?=
 =?utf-8?B?VXVyQzJ1QVlLNGlGTWhyaVZzc205WlVnam53UG1RQjRDTjdHdDAyTEFXZk9V?=
 =?utf-8?B?MVo4aHJkOEJzYnZNcWdjYWwvaEQ4TlNFdE83bEh0YjB6UDRuRjc1blZMOWI5?=
 =?utf-8?B?cFZOTzc5YktNZWpxY3d3L1E5cjNIRjZRQXZ4dEpBaVA1dlpJMGV4dkRCalh6?=
 =?utf-8?B?WHJpeHZTdGZYR0VJK1Fpa2lSLzk3UCtxVnUxMGZYcSt4TVRSbzg1eGh2bnhz?=
 =?utf-8?B?a1FnMmNKdGthcytlVnU3WVorc1lhSFh6MUN0ZGpTR1VYaEM0MFpTdE9UcFda?=
 =?utf-8?Q?ubfXtM0IR96vCNdDBpiq9iU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da14db25-df76-413f-08dd-08d9f77acd43
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 09:48:25.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baGSbOD7I0MgSyCZ+ULSvLuBYNZEO7nGNUgXcLQkvGonVcsVIeqOJSsn8YWrHTlKqRc/2Vj6KTuscmnpVZG3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4031
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Sorry for the noise of this false alert.

For clang analyzer reports, usually we do internal check firstly. We'll send out the
report only when we think that it is highly possible to be a true alert.

We scanned our report history and found this report was produced on 1/26, but it was
still in the internal check domain and was not likely to be sent to Qu or mailing lists,
so we are kind of confusing about this consequence.

Souptick, could you help to provide the original report by link or attachment?
Then we can do some check to figure out whether we have any flaw in our process.

Thanks,
Yujie

On 2/22/2022 16:04, Qu Wenruo wrote:
> 
> 
> On 2022/2/22 15:50, Souptick Joarder wrote:
>> On Mon, Feb 21, 2022 at 5:46 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>>
>>> On 2022/2/20 22:46, Souptick Joarder wrote:
>>>> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>>>>
>>>> Kernel test robot reported below warning ->
>>>> fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
>>>> returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
>>>>
>>>> Initialize ret to 0.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
>>>
>>> Although the patch is not yet merged, but I have to say, it's a false alert.
>>
>> Yes, I agree it is a false positive but this patch will at least keep
>> kernel test robot happy :)
> 
> I'd say we should enhance the compiler to fix the false alert.
> 
> Thus adding LLVM list here is correct.
> 
> 
> To me, the root problem is that, we lack the hint to allow clang to know that, @logical_length passed in would not cause u64 overflow.
> 
> Unfortunately the sanity check to prevent overflow is hidden far away inside tree-checker.c.
> 
> Maybe some ASSERT() for overflow check would help LLVM to know that?
> 
> Thanks,
> Qu
> 
>>>
>>> Firstly, the while loop will always get at least one run.
>>>
>>> Secondly, in that loop, we either set ret to some error value and break,
>>> or after at least one find_first_extent_item() and scrub_extent() call,
>>> we increase cur_logical and reached the limit of the while loop and exit.
>>>
>>> So there is no possible routine to leave @ret uninitialized and returned
>>> to caller.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> ---
>>>>    fs/btrfs/scrub.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>>> index 4baa8e43d585..5ca7e5ffbc96 100644
>>>> --- a/fs/btrfs/scrub.c
>>>> +++ b/fs/btrfs/scrub.c
>>>> @@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>>>>        const u32 max_length = SZ_64K;
>>>>        struct btrfs_path path = {};
>>>>        u64 cur_logical = logical_start;
>>>> -     int ret;
>>>> +     int ret = 0;
>>>>
>>>>        /* The range must be inside the bg */
>>>>        ASSERT(logical_start >= bg->start &&
>>
> 
