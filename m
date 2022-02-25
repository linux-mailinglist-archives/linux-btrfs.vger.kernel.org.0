Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EC4C4198
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 10:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiBYJhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 04:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiBYJhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 04:37:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7BB240A8;
        Fri, 25 Feb 2022 01:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645781808; x=1677317808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v5fKezqv7jLVafDfkxdB+NGZjYqZZgN9H2l501aWShc=;
  b=lL+vizqoI9B1fqC7OhXsxJJRZ4LhMCJ7O+9485wLNDNca0IDcOlR698e
   ZSTDlLLneivAm/05wkas5YD7kZAw4U7PF3i7enlBJ6PNjz2MbBpfiUBHx
   N5MZTbg/vxTtmahBNVhFyEHRdDbqR/5thlxMDVzN+OQpsNky+MYyJy7iq
   v6/FtqZq2VUAOSMn6pcUIJ6rYR1MnZwb78WSQyqp+I+nwDzRFukw15JcO
   z93nxUTRrIOS9FzPwmbKr0KLlUjVLsz9Kg2ayhipShpwMk4ekgT5cRBZV
   dsN8KUcKs9MdcZUxvE93NAuGxA4yxqiZYggMx25Jl2lHCvowuoM8COBEV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338900298"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="338900298"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 01:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549198324"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 01:36:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 01:36:47 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 01:36:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 25 Feb 2022 01:36:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 25 Feb 2022 01:36:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5N6/9cHYZQNDfSGDTD/fbr+jpqg/Fh9XSgzujjDxUJ1S65PMWJJU/ARLvjMAZZrfmhJ6HRGt5rkpS/uzIeR5Z0DpT4ma8eJpoWYM+znMiaQcem6L5WqgpK+4auxIIvPYQkxSnBrGsNSAKJsHliNAdJ11Tc4BBFhMZPbJJ2NIoHqQrcJVGQk56YyVaC5xSH2QRRXG4WjyoOuXuVMfhCl/gNkUhzrl8LV63RlNReqla2+h79qnEdV5HoEdagxSd31uQInlZlkPA2Cbyo/WI7jE/1yOpuOe/34af2GDKVbdkdFGAlUr1nipvjYuNmUa+orh/98f+NMQjKITA4m23adRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eldAsgI97+oGFYBCLFanHKzv23On7jAAJVZraPHC6+M=;
 b=W6xze2P9pw4kuN+7qm+2qVlBjYE6MWe7bTbQcln+wYtEprAaxaiyGfFFeI+KSFyIaup7KfhQEO3VFFcRrNMV4n2wFYVQjSY6MUXCkKaOPaC8+u/cy4e4UbhRs3c468QA6GtwLISu2IWJfCngAnWscgjZ7iRKx1g12Oz7QbGTijTTr9M8wtpYkWITJN4+nkcetJOUG85xu9CpnVPAO4WmbHPV1QbBOhAFIK8jzrL4L7Vl32D5PMj2FRSTS7mydUIQ3F3IIMVDM1A16fjaI8bvw0MFdXOrfLpA/NUGmUgRz12XTLpdC4qcqX40jOiqMFGAXsoSB9gn1NxYc94KKfnX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 09:35:50 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 09:35:50 +0000
Message-ID: <28c71b3c-2f96-9962-22fd-eb707346a3c4@intel.com>
Date:   Fri, 25 Feb 2022 17:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        <dsterba@suse.com>, <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220220144606.5695-1-jrdr.linux@gmail.com>
 <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
 <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
 <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
 <205e5941-6ae0-0482-b083-874daf0e5a46@gmx.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <205e5941-6ae0-0482-b083-874daf0e5a46@gmx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba70e094-f666-4541-e270-08d9f8423599
X-MS-TrafficTypeDiagnostic: MW3PR11MB4618:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW3PR11MB461849BC047111C8E8F2A818FB3E9@MW3PR11MB4618.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzLiDyIw7tV1ZqiJvYeSTCPO8m9eHGdEEbZPuQDBjl4F5ITLHew2rbh5naMnBcZLo6KRbC48K+Ozauv0EaaAmqzux2lWrDw8IJXkVpEd05R2t6lHM4vf8IXaYdJ44MPNG/JKJIsgZrUQAKJcG7bb6CXqQ5v7lqnTSoakzRPbjV32hDpkLkT0SGzJEHZU4HIXc5+rFRbPNv0sgVicDFsblb/6JVrrnSkTWm/4T+JjPZH/z/gYs+y/1IdOPhahs2N1Eqy+Ijjm2F4s81SaX2Ph/++n5PGJsXJpCxGfv7jK3wNuBaGt13CbeaIFN0mTYqUd8MirbXiVVT4eDrJkdlwD7NyumrkSIa/RsV3ABXgT1/GkgYCfsDGry4Yf7EdeAzjOFir9wEcsgVVIu+I5Bb9MZXhSea939ItepahX0sBgVF+/wVUImRs+T6gYK0bfunCj6XRUVwDGvJ+PH4cvQU/gTaxiLdHgmchAxt2XGEi973wx/Dh37zWiWYv2dCR4zN2mqgjHzpSJDJ0G91vA4xJsXinWXFrWn2rrTllTTN7W3cVR1qoXrWDp8YWvZoL618sMcAPBDJUxUlECS9rMDDZYx92gPdFZVrsgi8HfvyEOuV7aRe6Fjuu4YSOKxAkS0LxRZwLFKaJtR7FaUhbtyepZvsl5VKs0r6SLY44pX+WKmg90nYyodbclGV4Tq9gD1yCDhsapItlOFewbjRfZJxRO7RPtvlaXXxqbDhiIVp7rdA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(53546011)(6666004)(31686004)(38100700002)(82960400001)(36756003)(6506007)(2616005)(6512007)(54906003)(107886003)(7416002)(508600001)(186003)(6486002)(110136005)(44832011)(26005)(8676002)(83380400001)(4326008)(66946007)(66556008)(5660300002)(66476007)(2906002)(8936002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2V5Q1ZKS1ZMc0loV1Z6NU5zczdrdGFOMEc3c01YVXd2Nmt6b3Q2RnVhVUZH?=
 =?utf-8?B?VTF6MUJzTzl4N3lwQzd6TkFaUmxOL3VDUnRoa2N3bTQ2ZG1PRDhpMGJlR2V5?=
 =?utf-8?B?alpzcm03SXdkRlowSVpPSVBBUFgxYU1oRXJ0R1ZJZWh4Z21tMUxocDkwcGxl?=
 =?utf-8?B?S0xyNEFxZkNyYU1GeVNFU1o2Wk1CS0NtQ2tEVzQ5RDUrNG9kcUJCLzY5czQ4?=
 =?utf-8?B?cldwbFl6Ny9Ia0YzNjViNEdZNjVXMjJEaTJvWS9PaDlGMzFNNzlqNkZselN0?=
 =?utf-8?B?K3p2WHJ2QXNvM0ZWOGVZRnNpT3EyWnhwcDFuUWNVQ2l1L3VWeThTU2NZVU1s?=
 =?utf-8?B?b3c3S3VSOVpUZ1hBMzlpRUJjK29XU2x3SHEvNDdxTWpZczBoVnZDMldKV0Vz?=
 =?utf-8?B?dEo0SXZYenVpb3h1R3FMbXA4MG53YzVHa2Jub2JjcThBazdlVExadG5DM2lC?=
 =?utf-8?B?dTQ1MS9VSVVMNm1Mei81OXRramFEZENIeEVTSHZLS1ZyWDhWUUJFYjRna0dC?=
 =?utf-8?B?MnFwSHhCWlFZTndBT3ErRlpOSmxRa1B3QWdkZlREajlyK0Zja21VblZYZEUr?=
 =?utf-8?B?SmlJUjdhemVqc3BFc1YvNGJMVC9Fc083TjdpcFoxK2xJbEQ3dm1ZTHM2Y1d4?=
 =?utf-8?B?a1BEdjZWV0xqa3JaTXJjRHpvbFhOMWlzNnVkVGxCOGNMSUM5RDdGV1RUaHkx?=
 =?utf-8?B?ZGpOS0JndjAwbDQxa1hCdVM2MWFEaFF3UUlDMW80MUdHWWtadyt4YVdWMnhC?=
 =?utf-8?B?dTJna1FseVU3QlV6QjZ1UnVsUC9MNDhFYzE4elBVQUZ5SC82bWI2T29GVXFM?=
 =?utf-8?B?Q245L2QxVk12d3JmMlEwYlpwdjlsVENtSFhDM2oyWmFyem9LUVhzVEJNWGhW?=
 =?utf-8?B?ditLUW4vV3VvVXFnWlplWkFQeWtJQkhuSEZvb1hjb1hhbnVHblVpNlNXWjRu?=
 =?utf-8?B?L3QwZUovU2hWbFUyUU5ULy9FYTI0eE1lblFhY1lzak0wMStQZjRnd0RDM3I1?=
 =?utf-8?B?Ni8wdjl5a05YRWdtaEZzYlN2QVorV0tMM3kxWFgrQ1ZpTmRCYkVLd3VNYWdV?=
 =?utf-8?B?YWJyeXdxZXZtWmRQbkpxelpwNHh2VlJJdXR1UWJrMitsWFBIRDVQQU90ZDZw?=
 =?utf-8?B?MWpqWHV2THMrUlBYYkhnSW5zQUI3NGVvanltSmlDcy9pcEVaRW0wQ3ByY0RI?=
 =?utf-8?B?ZG1UOUxXUE01Z0k0SDZPUGp1bkxGZ081bXdGcVhsUkRRaDhrQUxNMWlYQ3BC?=
 =?utf-8?B?OW83WTJxZFdSYWp5bDF6RVpwRjVKY09kNUpsakczYXI5UWxpb2pTTmVCZmZl?=
 =?utf-8?B?V0w5L09OWk84WWM5V1lIY29LZzFmN1hobXBBSlB4SWtNNTVkNnlJWXVhV2d4?=
 =?utf-8?B?d1hmR2pidDB4MUZKWkxIdTFzKyt2RTIrRzAyR3NLeXIvL2hiRTUxZWQ0ME15?=
 =?utf-8?B?MGZNcWNzN0hxKzBYR2k5NXB2Yk9xdGZkekR5RWtmZGtUaXJtU2FhNldQSjh4?=
 =?utf-8?B?eGYwdkM2a3QrTVErdFZIOXpqVUFWc3NURjRxTFJmSkZjRlhjNkVDdS9TYXFF?=
 =?utf-8?B?Y3gyQzFVV1BvMEpuM3VLbkF3TWVrblJwYUx1U2llcnV3Nlp5ZGpPUkpSTGwv?=
 =?utf-8?B?OWNRZ1pzc3JraWFzMHFiVjhHb24wVjVBTDM1MDBaayt5U2NoNzVIeGtmNURa?=
 =?utf-8?B?QThHL05vVXVkK1lqbEVoaFZuUjN0Vm1CYVpQWkt2VVFqR043Mkx3REUxekJm?=
 =?utf-8?B?aTgvY2IycVdPZEFycHcxN3BRNVFhc1lWOTRKUkk1bUw3VUt6NmJYZDlyNlBV?=
 =?utf-8?B?NWEyeTRta2NmeXdWdERDUlBRWmtKUmdXcEZ4eEJBaXFQMFBPYjZYQjRlTERU?=
 =?utf-8?B?OGVENnFzSEQxd0VZY2hQNXUwaGJqWU9QYitFVFdqa1JrL0dKWVhiUy9LWEdr?=
 =?utf-8?B?RVc3TFJ1bkY3U1dsU2U2Y2hhTGVjZW44WjQrbEhKTDlyT0kvU1QyZy9OdUJu?=
 =?utf-8?B?K1NFUktxSDZLcWNxQUhRSnRkME1sM3VxbWsvRUI4WWxVbFUvSnl4U0l3b0x6?=
 =?utf-8?B?UzVubTlHbWtJTTlvWEZmck56dzlCTmlpeThvMmluWGdxWFFEaXhmSVF4NTdW?=
 =?utf-8?B?enZ2Y2xWZEd5QnI1cFNINUVnb1AyYzd0UTNKY2c5Tll0clBJdVNCejhLYzlR?=
 =?utf-8?Q?cW3rKlZtEYOcSpDfMprVukg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba70e094-f666-4541-e270-08d9f8423599
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 09:35:50.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgfcS7XLi9S+xdKBkKcgiTPAZE3XS3F2D0Vtt1hJ1PLuG2GN+AH2v0qf6v9J4ci1AH2f2b7kNOIxsenTvmE4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On 2/24/2022 17:56, Qu Wenruo wrote:
>>
>> For clang analyzer reports, usually we do internal check firstly. We'll
>> send out the
>> report only when we think that it is highly possible to be a true alert.
> 
> BTW, do performance benchmarks also go through the same procedure?
> Yes, runtime reports(including boot test, performance benchmarks,
etc.) also go through internal check procedure, but compared with
build issues, sometimes we are not that confident about performance
regressions.

> Although your bots are awesome at detect compiling warning/errors,
> sometimes it's not that straightforward to reproduce the same
> performance regressions.
> 
> So it may be worthy some extra steps to verify certain performance
> regressions.
> 
Runtime issues are much complicated than build issues, the
performance may fluctuate depending on different software and
hardware environment, so not that straightforward to reproduce.

Please feel free to contact LKP folks if found any false reports of
regressions or any issues in reproducing steps. We can learn more
experience from user feedback and keep optimizing our work flow to
improve the accuracy of catching real regressions.

Thanks,
Yujie
