Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225C4C8094
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 02:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiCAB4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 20:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiCAB4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 20:56:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3872E5C;
        Mon, 28 Feb 2022 17:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646099723; x=1677635723;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QCgaYV3BElPL2ZrwLtvXSdO0Vu/pOnA41/FcfPv3cew=;
  b=NT8clk2Zz/SEL4ee5Jkcvxavn8ExEApNGP2sfCRR0NiO/5PTICLEOvII
   Gc4LhYXkK/z+rusPanMkCkcx6j7yjLw7gSV1bbWpZpMqPOCh8OOJetGcU
   +7W3hEVz9V0yKHh3MVXbAZz/RFI45DP0hL2dNgYZ+rcx35VGcYORyLeYv
   PRmjU2Av623KcX8y0+XlNfa7cwf0nu4+YyeMrp8KNITTy1UnOTYoIB/Y7
   uX1X+uoAQKyHTwnZFqjcbNACvl/4AQ+cM9J3E2dxBtWP3KAOrOaReMbax
   oGdH0lHn3NS5+iZEAGMmaRbNPPympjdQlg2DExGFnFFHDd7mv563gNg0M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="240444521"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="240444521"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 17:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="629849961"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2022 17:55:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 17:55:21 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 17:55:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 17:55:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 17:55:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/KJxLtbv7eaVpehDQREQkAud1KW+BJF6i9Qf7yHw8QAxDTq5fRG2MPtyshBP/EhbSO1D8vm+KedX9yYk2LVybzocYsDjXg1zCBt4ryJtZ5xL6ax9CcLj6Kqs4pOpO2CtrQ0CbthG1ZtlDTWy0xDPwiUG2Sgl4VcJ6IURsUG3t2+YNoa7R+1YSHk89ZXaBLYvtcK+DImluvEkIF3HcKE/KqAYgB2bhm0dHZh0J2DOst2suzvu8+pSx8w+jXaCp5vMH3UDA9nXepm5vKgDUjibNAGCbpsSOTsVpCUcLiiSXQGflID+4UzJICKBPV5Hkvlz38aJntDsvpWjHCNhVDV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1RIIExXLOmy2s/9ioXPQL6nO84DM7OGNQgkOaWuoSw=;
 b=IQC9uG32YVdkWGNFKGn8b5dTDSYKDBAOTFZiMoCefzml9KZxoZ8UhfQmnhD8TeyHsIVXeSfzYTAj12VmwfRNqTnWwHxtoeqpK1x1OmxOJzdMlh2png06lEx+QQBgQfCtxPMFFISI5nbrL4qpv0kwGPD3ZULNTRkwolDEg5HABxF4CliEzfa3tuj7mW83rWLyTAWF+ahgfugJQOGwnjLDg8tIv1g1ELY0S6yc6dJ9WxUObpIr0Xa0Y2GeFrdR7b3bOxE3oAEE2wDVaFeEfbVh749JVZyVG2AvWA/5Ih08hb4HaeCi/C2lK2Zf+oqzMWa/sV20HmEJQQ1h4Ciz5BYppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 01:55:14 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 01:55:14 +0000
Message-ID: <1ebaefbc-ef9e-3060-3572-5ee560b7c4de@intel.com>
Date:   Tue, 1 Mar 2022 09:55:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
Content-Language: en-US
From:   Yujie Liu <yujie.liu@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, <dsterba@suse.com>,
        <nathan@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, kernel test robot <lkp@intel.com>
References: <20220220144606.5695-1-jrdr.linux@gmail.com>
 <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
 <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
 <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
 <CAFqt6zbCootaOTU3hGXZ0cBcMHoiNtXynzzG8oGw8R6fO4muhg@mail.gmail.com>
 <e94b337b-38ea-8705-4dd7-c09ac6b98ec0@intel.com>
In-Reply-To: <e94b337b-38ea-8705-4dd7-c09ac6b98ec0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e462a0f5-0154-48de-1af0-08d9fb2686b9
X-MS-TrafficTypeDiagnostic: SA2PR11MB4876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB487658BB0B3AE4FA0D617BD5FB029@SA2PR11MB4876.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fyhmbGaXeyCmZ8VwZIgktw3NNod5isV5ldC0AxHGqNmPv+wtpVqsO4eQIMEv4eyClx6NSxr/pYM94D7JlVC2FFHeFlQZD8DtM/zlluO9bxEigIlayUtKX4cpInsopE3nbFBGGzyD+rHS25pB8JkKyVzCmCWxGSbQCWWbPvc9OdOOLEnwN1nEV7HD1eEpGdIWdLY6UOWfBInfIBM9NFawlg6YH3kc48qPDoi621W/NfcqI2K4EB6sPX+XPXe84GvZduem8DnWTjjom5F6SeAOpIDlcGc+hSCC2K0+8LGl7SoHlZEiUHwF1SdyAnEYYXj6sxu5s6HAUDNp/8YTMnXA6qJEfsMFvetWppcKQo4Bz9RiPO3QvNRA2itP0QSyDOKS4hPd1hGBaftKiyid/XSsRdQ8zRnhxtaOOvada866qLXdiSfZOF23VtL3JQ52IbPImMEGOTxXRrj4qsxK5dS2s8F+uGHmcVhA/N7Qkk471dn6nGEZjHkCs/cVm2SQqr23X+gur1xlqMl13w4dlK3ePcJxKl/0qMxAgFXwTm8sNoWaT5K3VbTN3Iza0gXgU8SUkxpiwE6tLfj8cxgcYnY7DRrzYOumjD7KLDU6dju7VG45OddHYDPsACz/IW/Uvc5v4ZzHaqmoCtuh0MYJDpY/gt9oZHAKsoTKIkbgwGQd8AiAAdwQauXKbYSiH95ImVHvu0EzBsmLlqllkXmbnbMyoIF81XfZGZvdtQ+EgR2AKsiB/IxUAt4kM7YeQvMB7oQMr6K7PvDF8cZhPD4yhiMt4hyUcA2VP6ZCDlRtniOYNDIvvR86d/UQZ7NbQ+kIdN+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(7416002)(5660300002)(4744005)(44832011)(82960400001)(86362001)(31696002)(66556008)(38100700002)(6666004)(6506007)(508600001)(8676002)(4326008)(2616005)(6512007)(53546011)(66476007)(316002)(66946007)(31686004)(6486002)(966005)(6916009)(54906003)(83380400001)(107886003)(26005)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURYT1h1a2NBU2IzZ1RlRVRkbkJueFFiY2tDbjBzQS9rMGJQZ0xWcHZBOTFR?=
 =?utf-8?B?dkhOaTVJdFVOdWk5emJyK1dyb1Z3dCtxME5Wc0h1NHpxdFkyRnoraHRPb1Qy?=
 =?utf-8?B?Wm5EQ1BjdHJGYzFlNW8xdUw0NllGNVJnQUlSWHVTNlRMTXpyc3lvcHJoS0Vn?=
 =?utf-8?B?Y0xaSjB4czQ5cUJ3SCtUSTNncFU2cDM4bjNtY1hDUG1sZTFHYUp3RkpNYllh?=
 =?utf-8?B?OURZRkllekV3eFBlOUpabXVsWU5kL0VsMXlYMkU3RXJ3bkdOQnNFNkJYMTR0?=
 =?utf-8?B?ZDY0OGNCaEpCbGFkR3hrbzBabW0yb2lvdk9WT0NyQUxTdHdEK2NnOEpScExz?=
 =?utf-8?B?YjNGaTkzQmFHajg5UGJCM3NkOVpRWDZSd3UrdWlpa0QxNUdQVWdOSHlYRDk1?=
 =?utf-8?B?TXljUjR6aElteGhPUFBSWUx5K1pjNHM5KzRyWjk2cjI3Ry96RGkyVFZzVk1h?=
 =?utf-8?B?YXUrM3FLVmYzK3RJTEJkeEVLMzBBN1poK2czY3ZXdE1ibmlZZmdXU0k2YUt0?=
 =?utf-8?B?SkZodVMvRGlYeDByOXFmVUpScStYN2ltNnZTeVB3azh3Sk5Jdk5HbzRwaDNE?=
 =?utf-8?B?bHBHeG4xaDVtZ054SzRqa0xFU1EwNTdZMjUyVXNPRmRJTWc2M3FnRWcxazZ6?=
 =?utf-8?B?WkEzd1NRNk1lT3M1S253QWMzWkVoTHRncEIrNnJtNnhndCs5Q1drY0VEck9L?=
 =?utf-8?B?OFl5K3VUN2MyL3hnZzY5SmtXb08wWldwUEZWbForSnRDQkpqY1JuSzA2Z25p?=
 =?utf-8?B?Qk95TDBOZk1tWW5QdGU5QXlGYzFsa0J2ek4rc0tFa3dCZGxvSWsvWTlSMUlH?=
 =?utf-8?B?ZDVGcWdWYWpPOG13dUs4V2ZFWWlWNkc3RENyYWpCYjBMT2ZzZWZOV0o2Y3pW?=
 =?utf-8?B?VUJiRG9Jc3VLcXhiU1Z3TEZJNTl1aFFVZnlaM2JhWUowa1IxT0tGL1dkeW1m?=
 =?utf-8?B?NjRQSXh6bUozaEE3RkhkQnJVZDlwLytKWkJrU0NPMDBpMnNnUGJoVTRFS2Fx?=
 =?utf-8?B?bzY0bVlJN1FHNFVwTzZvb0ZwWFYyem9XNkljb21teXIzSHpZT1lrekplT2dr?=
 =?utf-8?B?dzdFTVJITEluWFMyNGJFdlIxc3hkMDJwMDJvbDFUMitGdHRNc1JjSzlmQlpM?=
 =?utf-8?B?aTYyTUlXTWJyUlpQWEVkeHVJSjlVNzJTOTB3NkdqVFVJOXIxSHFCWHpzZHgv?=
 =?utf-8?B?RFFZVzViZXg0bmZrVldHV3hKMU9xVXkvelpGUFM2NkxoaDB6MjVEMTlPelVH?=
 =?utf-8?B?MUlPMXJtUmZhUmsxeHVFc3VjLy9CMUd0bm9wY1RvUENQSjNBaEpzeHJTU3Jn?=
 =?utf-8?B?MFNIZ1huR1o3NDh3ckMwTXlhNFR6bDJiMVhzYm1pdXorTEhZL2JETVh2cHNh?=
 =?utf-8?B?VUpHZjBjN2lPOWFQYnBOZnZwK1czci9UM1MrWU9QWHBZMlN4alpkcXovQk9o?=
 =?utf-8?B?dTc4dTNSajdQSTQ5a0ZuazRXUWVzdFc5L0pRUWZPYjZVQTdDam80SXpibDM1?=
 =?utf-8?B?QmJMR1RwU1RRcXRWakg3SHpSTS9HOE1oYUNJN250T0MyU2JlR29tYkxUb0lw?=
 =?utf-8?B?Y1A1N25QR2luRThRMGo5WE9yZkhHMDJIdExzeHQ5MVZVdmJGMWpQczY1b0pJ?=
 =?utf-8?B?bWF4TzhxZElheW00R2k5enFHQlRZMTNyMERuSCsxMlVJNU9XV0Y5NHI5NFcx?=
 =?utf-8?B?WW9EMEJZZU1MMkxuaWUxWjRCNmFkcmFkUDVDemZrTjZXMWtDT28waDNaOGJQ?=
 =?utf-8?B?VG56R21pdnBXQTJFV2YvbVE0ZkNtZU1CcW50a2JlMFhxMXhxWHg4RmpyWCtx?=
 =?utf-8?B?d0JQRGp1NE5Ra1RTWGM1citSZWo3ZWtwWHpTQnNaZlpIWEFZcXBtZlNYNTll?=
 =?utf-8?B?RFY5OFlQTVlTYmkyQ0dhZVNUVTZESWhSNnkrejFod1pSNE9pYm82am1qRTU5?=
 =?utf-8?B?RUdmVDRvOXpBeFNONUFnaFZEaklZcDVUUTBRckF1ZFM3amJIb2NURjZmY3pT?=
 =?utf-8?B?Wm0venZTRWVQSCs3RzFQUklFSUhPdjlCQXRrM2NGZVRaN0l0WWUwUXBHbkhs?=
 =?utf-8?B?amxpbGxVb2ZvRW5HVjFXWlFFWHcvRkYwRVd3OWhycWRmREhNcWpFQThVT21U?=
 =?utf-8?B?bGlMMWdvRjlGTXhpdndGRGxYeDVTMlFKdjBRSTcrcGQwVWh3KzRnekViRWox?=
 =?utf-8?Q?7Mmz6Zrq6kXDxmBgodlERdw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e462a0f5-0154-48de-1af0-08d9fb2686b9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 01:55:14.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EaUtmXFgU6u/WiyfLhy2Im6NSYxQLipo9I2TxmM+QICmd0NRRA226+7KA3s2cz6aTB7B8SguIcx7RdZmfpEEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Souptick,

On 2/25/2022 18:02, Yujie Liu wrote:
> Hi Souptick,
> 
> On 2/25/2022 13:16, Souptick Joarder wrote:
>> On Thu, Feb 24, 2022 at 3:18 PM Yujie Liu <yujie.liu@intel.com> wrote:
>>>
>>> Souptick, could you help to provide the original report by link or attachment?
>>
>> https://marc.info/?l=linux-mm&m=164487037605771&w=2
>>
> 
> this link is a notification mail of build status, but not a formal report,
> so there may be many false alerts in this mail, please ignore them.
> 

Sorry, previous info was not accurate, here are some updates:

In a build notification mail(such as above link https://marc.info/?l=linux-mm&m=164487037605771&w=2),
there is a hint line like:

   possible Error/Warning in current branch (please contact us if interested):

the errors/warnings in this section are not fully verified like the ones generated
by static analysis tools.

We will make this line clearer to mention that they could be false positives.

Thanks,
Yujie
