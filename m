Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3695B4DD295
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Mar 2022 02:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiCRB4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 21:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiCRB41 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 21:56:27 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F1228D3C;
        Thu, 17 Mar 2022 18:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647568507; x=1679104507;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8TRY9LVpe7pZAvLy1ao7VlvQgV9gvFTqQKaP4dD5HPs=;
  b=J9nRdi1Lgw/rfVJcr1zPS2g0bkwwzUeCWjnt5ecY3dBdsxLw3hJWB/0H
   zdjZBGpPPQCFqHR6UutgfcUeXAE+yqPNIY0DWQ6bi9aswbwq6Di7TtAX8
   eU4TsAhAqLRCjYaHdmsViDvUOVLQqFhqj5FDcJFEOAzr0NRpEtN+b+Vsw
   R6WTLGApk7+2N4rOqS/ovea78/Treffog9BXDrNFixY6zgidr2WI70jwd
   GJHN2w5Ybdz0kJD63HpRRymthV4vtVY3VYCCy4vifMXb01DmPnm8aI4aF
   sKWYy6JB9/s3zCj++AcBO4zNteAeG88L0hFocK+5WPBs5rI79YWp1L+Dr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="317743481"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="317743481"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 18:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="647269624"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 18:55:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 18:55:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 18:55:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 18:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1OpThhiJfp87LrRYYVdaMjTI63k1JHsAj+omDApbpjSyXHlB5lw+V4G+GHwfH/GSb+FmubqSnS3RRCZ0JOLF7Bh24ZUWbnKcJINVPnbgFJBxN1fYmwG4vwY1l5B9OxBlNp+A6MA272rvHY1bbWrXJuZXBJtJStyMAdbme5x647bYojxjZRS8k8p2nEDDGs+xqH17Hh+zS/G3qGEHyorscGXcByTwtAprU/l2srYBxkQXm1R8LnWai0dpKc4pFvQFH7AcF5iSdmYJvCUIzIlrjal78GIvPE9ZlsyJKQiLTCRoBMlXBKs3vIgoQMaBxnYgqaNukccSVRftMky/IBW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUC050iKf9yhpjypJWmR3FMU4U6xtq7dlqnanAIAetQ=;
 b=iJSo24rlsvuHLkoX40l++t5i9vRHkVly88s3ptmKzP3m2IhrG0jQfVRTU9nSEgDfVW9ya20LlbjRVppsAonT/oRBXmsFScLeSdcSxAIMW9yvFfGq4eJSAkhQaDF2DMMG0I3b8yAknOplA/UztIV70qltlgxnmhZQaR/mKRk56Kbc+Xidp+WBnwhDXHCfmpLQYyWEcOPDmA+/17HbLlVmVEM20+ZoNVtmcLw5LJxbg2jAXGml5Bpz6wuJOZfMVsG59dPGyni7jnJ+VjOfuZkv4Soh65m085I7ENDTriFFE41skxW2x8wG9YRO6kgz8BMca3AxFbTOfkJl2xIRA1jS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SN6PR11MB3135.namprd11.prod.outlook.com (2603:10b6:805:d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Fri, 18 Mar
 2022 01:54:58 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94%8]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 01:54:58 +0000
Message-ID: <e56b49f6-2a45-f522-ba57-292ca5ede2d1@intel.com>
Date:   Fri, 18 Mar 2022 09:54:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
From:   Yujie Liu <yujie.liu@intel.com>
Subject: Re: [btrfs] 3626a285f8: divide_error:#[##]
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
 <57656d0d-d4d4-4d68-de82-e29093d19d3e@intel.com>
 <bdf807ac-8e8e-c64e-4454-264e10857d18@gmx.com>
Content-Language: en-US
In-Reply-To: <bdf807ac-8e8e-c64e-4454-264e10857d18@gmx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfe18700-4eb4-4eae-46f9-08da08824e33
X-MS-TrafficTypeDiagnostic: SN6PR11MB3135:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB31353B410F48367A0ACEBEC2FB139@SN6PR11MB3135.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub6X3V8H+dt6s/8l/+mBHFGH0Alm1JIciWsmTzRohDhs86DdsOulrH02bl//h61k+SeHufAFwuIsv1HHFscP4p9sC6xMwX+UDb8yulQjqRkHKuEjJYCmoHppkuqp67OJNsPbLkSruZRjS+npCLXgj01bxsUAo1+gbU3veXJlNqx2pRkCWqi0x93jWA1+/TfHEDeG3QPCmDkLC2dBBP7LCT1HaZTsC7VpBDCLoI8tgJs6Sg6NJ4EB/eW3bKFGmCwoCfoYiq2UjTNbIrvdTocKgsH4okvsDoGTigfxeu1O8KGVMnmtQmU19h2Exsg4ujn2YzvVCS5+2nu+FkYtZ8nxraxoihiLBOdfkRkUGFOoTe8VQmdZbIVR3TEVQiEfXHEoh/xm009rNC917/x5VH2MrNEwsOWXWXH0iLylnpb8Q/vpXLzkc2JVxDRbIzA+plWYXD9h5HDZ7W2CpQ6I82mVcfKI7aUlNh4RDLsDdu5BFWw6A22/7IV+U5KAmsiCcz4ocLBxeLsJqvyPPUf5JJzVVTGavgsozrpwgjzKeH5eo57y9JIU/nIaaDN+VCpdJ+uAtuHIb+70c8JxVV62sOwt2f0JUv8ThH/jE0pxD9ZEUW7zUPNZnpy//Xeq/5+6EsPwOE/E28S5+MlkR6ddPdHB2MLHIeP0N/PfzBCpCz02x/z885BtxZgvn3735ZtyPsNHUNaM1e0cULRvrdgtIQpRNJwbmZLfaRK4bCWUZgQ2kO79ukjZ+gvTPNPrwzUmnmRSXlAk46Y49ME8SCcYNRZbVDAIztgJDi0CDktaW+bPkQp+5QOQCXNaUkYEjjxQlCVXcomlt1YgIeUEii8KxN0s3gVMGP1U4Gqoa+Py61F2H5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(45080400002)(82960400001)(66946007)(66556008)(66476007)(53546011)(6506007)(86362001)(6512007)(316002)(6666004)(31696002)(54906003)(508600001)(6916009)(6486002)(966005)(26005)(107886003)(4326008)(186003)(83380400001)(38100700002)(8936002)(44832011)(30864003)(5660300002)(36756003)(31686004)(2906002)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1VbXVWdEFCbUtCTEdvaE1HcEFWWlhpQ2x4dkM5YldOdkludm5BTUVwd1M0?=
 =?utf-8?B?alJzQWdObENGS1RhdnJZV3dNQTlsdG10T3JUU0ZDak9QMk0wNkdOZnlGQVBM?=
 =?utf-8?B?WHpkSFJIRU1FWC9OWndiOStFeTlXMFJxbk9LVlU3cXBVYitHVTBpck5wNlBj?=
 =?utf-8?B?TkNCYThQWFJIRzY1bFhUdDYvOGEzMEl2RzRQWSt3TEhtTW5sN0thUmpYd2dv?=
 =?utf-8?B?ZGs3ekQvd0t1MmZrWEJIVzJmMEc2aEhKbDNUMWxsU09RVDA2bG9vQnQ0SWdG?=
 =?utf-8?B?czlSdzh6cDB5MDIzY3dJQlpJbVQ5THJacnBpMXpLUTFBb0VTczVabTlhSk9Y?=
 =?utf-8?B?Q1Jrdys4elhVK1RqUkJkaW5xTlcwR0pROFo2M2F5ZGIySWMycXE3V2pDbHE0?=
 =?utf-8?B?R0dzdDF0S3p5aHJMeFhxdFJjeW5nRG1YRHZVOGJCcWdhM05kaEtiVFkzN0g0?=
 =?utf-8?B?M2tXaTBrTUJzOXBFZVVaaE42WmF2K3NlV2JIMXc4c0dVUFRlRitCeThuemxa?=
 =?utf-8?B?dnlCaGdvNVVsMXRBd1lvbm5lL1hkM2tFSlMxQ1dPS2JGdWZKS0V1N3NlL2tD?=
 =?utf-8?B?RUR4T2JHbUpXSDQrZktTdjlRRGF1MURUVU1tSGhMWnRRWDJnRE9ERXpOZm01?=
 =?utf-8?B?MEEyZjk4RTJLK243UVYvRUVhamtFNGFGaFRpVWNGZTg3L3M5a0xMUWRxeUw4?=
 =?utf-8?B?ajNFSi9hS3Z5enBUNE8zWVU3SWphdFM1dVFzZVBSN2V3U3RXT3RDa2tKWGxq?=
 =?utf-8?B?YlFidGFIbzBLdTE2TUVQOVRtYWl1Y2tncWdyaGFsR2JaU1NUazJYcUJ3TFpk?=
 =?utf-8?B?VUxDZmZXZTVQVGtYKythb0FQampvQW56VDVxVEw0VnVCMTh0Qk5GcmNURnk2?=
 =?utf-8?B?ekVGb3BEejRTUXJ4WVBtSmNlcU1tYTRMNERjSHFVcEdKMHI1UG92djhjUXZX?=
 =?utf-8?B?bDQ1NkhwMklSNnVoRWJ5VStTT1UyL0RBeWI4YnB2cTlmT0Z0TkJmd205emx5?=
 =?utf-8?B?RjQ0OEZJZTIrUEVTTTFubmlXbjgrYzVpNnpma3ZWZGwzZG56UG03WG9odEtT?=
 =?utf-8?B?dzdQYitzYWh1QWxuSVFmcWRvR0RGYWQvTGJ6aTc3SlcydUV5dG91K25QeHFj?=
 =?utf-8?B?cFdjdnlVVjJ2U29yRElrUWpqaUhFQmJQeTg5NlowUjArZmJocUJEOFJTa2k3?=
 =?utf-8?B?SHZXNjlzN2srMzNtV3djOEk1Mk9DN1IrMXc2YW0ySG5Iam81VXVYNDRBVm5q?=
 =?utf-8?B?eGQ3aWNmTHNWcFRvZUZhd1VFcUh2QVQvS2pkd2NxaDBhRnVJb0FVZktFcFJ0?=
 =?utf-8?B?cExyRXlWMTZHQTJCTzUwdGQ2anI5RVl6Y3UzZFRUWkRxWjIzaFBRbHJEMTRF?=
 =?utf-8?B?d1JNSGUrSjFVWmR1cnNOU3FZUml2N0lsWjlLY3c3Nm9rbGNEazdPdUJmUXA5?=
 =?utf-8?B?YjlWTVlXUEpaSXYxM0xMcTl1eFYyVUF4bnN3bWI3ODZ4d0ZiR2ZDMzF0ZlMv?=
 =?utf-8?B?S0pDQTE5SjQ5V1R1YWRSR1FOZEZmSUQ4Q2hYWlRNYnh1cm5ueGtpUmN4RzVr?=
 =?utf-8?B?ZEJvR1JFcm5Mb1ZhSlNpNk5YcEFSb295a0pDcWZkMVNZdE1PNEFYOGpTQ2tO?=
 =?utf-8?B?S0s1b3ZHZUhvNXdzMldOVFdLRFlrN2ZLT2NyRGhnM25SU01PMmM4MmpUVko4?=
 =?utf-8?B?Uk02dms4b1dYZzQ3V242VnRFZ3dqa2R5WE9LZ2ljbDBMWUsyb25YcEVoMlVs?=
 =?utf-8?B?RHQ2bUtaTVBseGhuaTNYVmVScGlYKytmSDZaUlVpY2h5dStteUpaYktCVVgz?=
 =?utf-8?B?MW9vNEoycVVrbVlJTkhmd0wzYXpBRkEydzlxblp0d0czWDNTalBYdGx4K2VJ?=
 =?utf-8?B?U1BhQ2ZPZ1dzTDAvTk9uQzFNWGt0VkZIZjhNTWllRkFndkNwN1pGYnBjZEFm?=
 =?utf-8?Q?FO1NakYTczBtBmbZL8Gesac2jUzuH/FP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe18700-4eb4-4eae-46f9-08da08824e33
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 01:54:58.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y0XW6zNS/84WmfKVH3kx5FeKQ8qSgERIIxyCn0+4/rygwHgHi+sBF75akJfWULAJv3qE05Ns8oSUxcJLcrX8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On 3/17/2022 13:25, Qu Wenruo wrote:
> 
> 
> On 2022/3/17 12:37, Yujie Liu wrote:
>> Hi Qu,
>>
>> On 3/14/2022 10:24, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/3/14 10:05, Oliver Sang wrote:
>>>> Hi Qu,
>>>>
>>>> On Wed, Mar 09, 2022 at 04:42:41PM +0800, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/3/9 15:49, Oliver Sang wrote:
>>>>>> Hi Qu,
>>>>>>
>>>>>> On Fri, Mar 04, 2022 at 03:26:19PM +0800, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2022/3/2 16:44, Oliver Sang wrote:
>>>>>>>> Hi Qu,
>>>>>>>>
>>>>>>>> On Tue, Mar 01, 2022 at 03:47:38PM +0800, Qu Wenruo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is weird, the code is from simple_stripe_full_stripe_len(),
>>>>>>>>> which
>>>>>>>>> means the chunk map must be RAID0 or RAID10.
>>>>>>>>>
>>>>>>>>> In that case, their sub_stripes should be either 1 or 2, why we
>>>>>>>>> got 0 there?
>>>>>>>>>
>>>>>>>>> In fact, from volumes.c, all sub_stripes is from
>>>>>>>>> btrfs_raid_array[],
>>>>>>>>> which all have either 1 or 2 sub_stripes.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Although the code is old, not the latest version, it should
>>>>>>>>> still not
>>>>>>>>> cause such problem.
>>>>>>>>>
>>>>>>>>> Mind to retest with my branch to see if it can be reproduced?
>>>>>>>>> https://github.com/adam900710/linux/tree/refactor_scrub
>>>>>>>>
>>>>>>>> we tested head of this branch:
>>>>>>>>      d6e3a8c42f2fad btrfs: scrub: rename scrub_bio::pagev and
>>>>>>>> related members
>>>>>>>> and:
>>>>>>>>      fdad4a9615f180 btrfs: introduce dedicated helper to scrub
>>>>>>>> simple-stripe based range
>>>>>>>> on this branch.
>>>>>>>>
>>>>>>>> by attached config.
>>>>>>>>
>>>>>>>> still reproduce the same issue.
>>>>>>>>
>>>>>>>> attached dmesgs FYI.
>>>>>>>
>>>>>>> Still failed to reproduce here.
>>>>>>>
>>>>>>> Those btrfs/07[0123] tests are already in scrub/replace group, thus I
>>>>>>> ran them almost hourly during the development.
>>>>>>>
>>>>>>>
>>>>>>> Although there are some ASSERT()s doing extra sanity checks, they
>>>>>>> should
>>>>>>> not affect the result anyway.
>>>>>>>
>>>>>>> Thus I pushed a branch with more explicit BUG_ON()s to catch the
>>>>>>> possible divide by zero bugs.
>>>>>>> (https://github.com/adam900710/linux/tree/refactor_scrub_testing)
>>>>>>>
>>>>>>> Mind to give it a try?
>>>>>>
>>>>>>
>>>>>> in our tests, it seems one BUG_ON you added is triggered
>>>>>> (full dmesg attached):
>>>>>
>>>>> What the heck...
>>>>>
>>>>> It's indeed some weird extent mapping has its sub-stripes as 0...
>>>>>
>>>>> I must be insane or there is something fundamental wrong.
>>>>>
>>>>> Mind to try that branch again? I have updated the branch, now it will
>>>>> trigger BUG_ON() as soon as it finds a chunk mapping with
>>>>> sub_stripes == 0.
>>>>>
>>>>> I'm wondering if it's old btrfs-progs involved (which may not properly
>>>>> initialize btrfs_chunk::sub_stripes) now.
>>>>
>>>> below BUG print was caught by your new patch (detail dmesg attached):
>>>
>>> Thank you very much for the detailed report!
>>>
>>> The triggered BUG_ON() means, we're getting sub_stripes == 0, for
>>> unrelated chunks (in this case, it's DUP from sys chunk array, from the
>>> full dmesg).
>>>
>>> And from the code context, it's from super-block, thus there must be
>>> something wrong with the mkfs.btrfs.
>>>
>>> But unfortunately, I re-compiled my btrfs-progs v5.15.1, retried, and
>>> still no reproduce.
>>>
>>> Mind to share the result of "btrfs ins dump-tree -t chunk /dev/sdb2" and
>>> "btrfs ins dump-super -f /dev/sdb2" just after the mkfs.btrfs call of it?
>>>
>>> As the BUG_ON() mostly means, the result from mkfs.btrfs is not correct.
>>
>>
>> We have added the "btrfs ins dump" commands after mkfs btrfs call, and
>> got below log:
>> (full dmesg attached)
>>
> [...]
>> [   94.332728][  T337]  item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM
>> 13631488) itemoff 16105 itemsize 80
>> [   94.332733][  T337]
>> [   94.344629][  T337]          length 8388608 owner 2 stripe_len 65536
>> type DATA
>> [   94.344635][  T337]
>> [   94.354342][  T337]          io_align 65536 io_width 65536
>> sector_size 4096
>> [   94.354348][  T337]
>> [   94.363469][  T337]          num_stripes 1 sub_stripes 1
> 
> Correct value.
> 
>> [   94.420718][  T337]          num_stripes 2 sub_stripes 1
> 
> Correct value too.
> 
> [...]
>> [   94.454066][  T337]
>> [   94.463995][  T337]  item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM
>> 30408704) itemoff 15881 itemsize 112
>> [   94.464001][  T337]
>> [   94.476279][  T337]          length 1073741824 owner 2 stripe_len
>> 65536 type METADATA|DUP
>> [   94.476288][  T337]
>> [   94.486957][  T337]          io_align 65536 io_width 65536
>> sector_size 4096
>> [   94.486963][  T337]
>> [   94.496023][  T337]          num_stripes 2 sub_stripes 1
> 
> All the sub_stripes values are correct.
> So the on-disk values are correct, not something wrong in btrfs-progs.
>> [  238.576361][ T2052] ------------[ cut here ]------------
>> [  238.581694][ T2052] kernel BUG at fs/btrfs/volumes.c:7157!
> 
> But we still got a sub_stripes value as 0, from the super block
> sys_chunk_array.
> 
> I have no idea why this could even happen.
> 
> There used to be some bug in misc-next, that makes extent buffer read to
> always return 0.
> But I don't think that's still in my tree.
> 
> 
> Anyway, I have updated the refactor_scrub_testing branch, with one new
> RFC patch, and rebased its base.
> (Of course, I tested it locally using the scrub and replace group
> without crash)
> 
> Mind to give it a try?
> 
> This branch will no longer trust the sub_stripe value from on-disk data,
> and the branch base is much newer, definitely without the old possible
> read extent buffer value bug.
> 

we have tested the new head of refactor_scrub_testing branch
(55a862df9ec6af btrfs: don't trust sub_stripes from disk)
and found the issue is gone.

=========================================================================================
compiler/disk/fs/kconfig/rootfs/test/testcase/ucode:
   gcc-9/6HDD/btrfs/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/btrfs-group-07/xfstests/0x28

commit:
   3626a285f87d (btrfs: introduce dedicated helper to scrub simple-stripe based range)
   55a862df9ec6 (btrfs: don't trust sub_stripes from disk)

3626a285f87dceb4 55a862df9ec6af825501b7550ca
---------------- ---------------------------
        fail:runs  %reproduction    fail:runs
            |             |             |
           6:7          -86%            :12    dmesg.RIP:scrub_stripe[btrfs]
           6:7          -86%            :12    dmesg.divide_error:#[##]


=========================================================================================
compiler/disk/fs/kconfig/rootfs/test/testcase/ucode:
   gcc-9/6HDD/btrfs/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/btrfs-group-07/xfstests/0x28

commit:
   7f159e82828e (btrfs: debug the divide error)
   55a862df9ec6 (btrfs: don't trust sub_stripes from disk)

7f159e82828e70d3 55a862df9ec6af825501b7550ca
---------------- ---------------------------
        fail:runs  %reproduction    fail:runs
            |             |             |
          10:11         -91%            :6     dmesg.kernel_BUG_at_fs/btrfs/volumes.c


> Although the debugging BUG_ON()s are removed, if the divide error still
> happens, I really need to check my sanity then...
> 
> Thanks,
> Qu
> 
> 
> 
>> [  238.587222][ T2052] invalid opcode: 0000 [#1] SMP KASAN PTI
>> [  238.592808][ T2052] CPU: 5 PID: 2052 Comm: mount Not tainted
>> 5.17.0-rc4-00095-g7f159e82828e #1
>> [  238.601424][ T2052] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN,
>> BIOS A05 12/05/2013
>> [  238.609347][ T2052] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
>> [  238.615411][ T2052] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03
>> 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85
>> 19 fb ff ff <0f> 0b 4c 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b
>> 7c 24 78
>> [  238.634889][ T2052] RSP: 0018:ffffc900033cf6c8 EFLAGS: 00010246
>> [  238.640817][ T2052] RAX: ffff8881028b2980 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [  238.648652][ T2052] RDX: 0000000000000000 RSI: 0000000000000008 RDI:
>> fffff52000679e75
>> [  238.656487][ T2052] RBP: 000000000000033c R08: 000000000000005e R09:
>> ffffed1034dd6791
>> [  238.661055][  T339] 512+0 records in
>> [  238.664320][ T2052] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 R12:
>> ffff88812830c500
>> [  238.664322][ T2052] R13: ffff8881028b2998 R14: ffff8881028b299c R15:
>> 0000000000000022
>> [  238.664323][ T2052] FS:  00007f66fb9b4100(0000)
>> GS:ffff8881a6e80000(0000) knlGS:0000000000000000
>> [  238.664325][ T2052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  238.664327][ T2052] CR2: 000055f0bbc19d40 CR3: 0000000209c0a005 CR4:
>> 00000000001706e0
>> [  238.667935][  T339]
>> [  238.675758][ T2052] Call Trace:
>> [  238.675761][ T2052]  <TASK>
>> [  238.675762][ T2052]  ? _raw_spin_lock+0x81/0x100
>> [  238.719432][ T2052]  ? _raw_spin_lock_bh+0x100/0x100
>> [  238.724404][ T2052]  ?
>> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>> [  238.731635][ T2052]  ? add_missing_dev+0x3c0/0x3c0 [btrfs]
>> [  238.731805][  T339] 512+0 records out
>> [  238.737188][  T339]
>> [  238.737177][ T2052]  ? btrfs_get_token_64+0x700/0x700 [btrfs]
>> [  238.748791][ T2052]  ? memcpy+0x39/0x80
>> [  238.752632][ T2052]  ? write_extent_buffer+0x192/0x240 [btrfs]
>> [  238.758510][ T2052]  btrfs_read_sys_array+0x2c7/0x380 [btrfs]
>> [  238.764301][ T2052]  ? read_one_dev+0x13c0/0x13c0 [btrfs]
>> [  238.769742][ T2052]  ? mutex_lock+0x80/0x100
>> [  238.774016][ T2052]  ? __mutex_lock_slowpath+0x40/0x40
>> [  238.779169][ T2052]  ? btrfs_init_workqueues+0x4c1/0x7ba [btrfs]
>> [  238.785244][ T2052]  open_ctree+0x16ac/0x2656 [btrfs]
>> [  238.790345][ T2052]  btrfs_mount_root.cold+0x13/0x192 [btrfs]
>> [  238.796139][ T2052]  ? arch_stack_walk+0x9e/0x100
>> [  238.800848][ T2052]  ? parse_rescue_options+0x300/0x300 [btrfs]
>> [  238.806803][ T2052]  ? vfs_parse_fs_param_source+0x3b/0x1c0
>> [  238.812382][ T2052]  ? legacy_parse_param+0x6a/0x7c0
>> [  238.817352][ T2052]  ? parse_rescue_options+0x300/0x300 [btrfs]
>> [  238.823313][ T2052]  legacy_get_tree+0xef/0x200
>> [  238.827848][ T2052]  vfs_get_tree+0x84/0x2c0
>> [  238.832122][ T2052]  fc_mount+0xf/0x80
>> [  238.835879][ T2052]  vfs_kern_mount+0x71/0xc0
>> [  238.840852][ T2052]  btrfs_mount+0x1fc/0xa40 [btrfs]
>> [  238.845864][ T2052]  ? kasan_save_stack+0x1e/0x40
>> [  238.850573][ T2052]  ? kasan_set_track+0x21/0x40
>> [  238.855202][ T2052]  ? kasan_set_free_info+0x20/0x40
>> [  238.860181][ T2052]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
>> [  238.865988][ T2052]  ? __x64_sys_mount+0x12c/0x1c0
>> [  238.870784][ T2052]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  238.876709][ T2052]  ? terminate_walk+0x203/0x4c0
>> [  238.881415][ T2052]  ? vfs_parse_fs_param_source+0x3b/0x1c0
>> [  238.886993][ T2052]  ? legacy_parse_param+0x6a/0x7c0
>> [  238.891963][ T2052]  ? vfs_parse_fs_string+0xd7/0x140
>> [  238.897021][ T2052]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
>> [  238.902809][ T2052]  ? legacy_get_tree+0xef/0x200
>> [  238.907519][ T2052]  legacy_get_tree+0xef/0x200
>> [  238.912051][ T2052]  ? security_capable+0x56/0xc0
>> [  238.916761][ T2052]  vfs_get_tree+0x84/0x2c0
>> [  238.921036][ T2052]  ? ns_capable_common+0x57/0x100
>> [  238.925921][ T2052]  path_mount+0x7fc/0x1a40
>> [  238.930205][ T2052]  ? kasan_set_track+0x21/0x40
>> [  238.934838][ T2052]  ? finish_automount+0x600/0x600
>> [  238.939722][ T2052]  ? kmem_cache_free+0xa1/0x400
>> [  238.944434][ T2052]  do_mount+0xca/0x100
>> [  238.948362][ T2052]  ? path_mount+0x1a40/0x1a40
>> [  238.952900][ T2052]  ? _copy_from_user+0x94/0x100
>> [  238.957609][ T2052]  ? memdup_user+0x4e/0x80
>> [  238.961886][ T2052]  __x64_sys_mount+0x12c/0x1c0
>> [  238.966510][ T2052]  do_syscall_64+0x3b/0xc0
>> [  238.970791][ T2052]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  238.976554][ T2052] RIP: 0033:0x7f66fbbb2fea
>> [  238.980840][ T2052] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83
>> c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 534513d9f513c4b9a622b34c8fb11281d9ee5a0644 00 00 49 89 ca b8 a5 00
>> 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64
>> 89 01 48
>> [  239.000318][ T2052] RSP: 002b:00007fffa196f178 EFLAGS: 00000246
>> ORIG_RAX: 00000000000000a5
>> [  239.008593][ T2052] RAX: ffffffffffffffda RBX: 0000562feab9a970 RCX:
>> 00007f66fbbb2fea
>> [  239.016430][ T2052] RDX: 0000562feab9ab80 RSI: 0000562feab9abc0 RDI:
>> 0000562feab9aba0
>> [  239.024264][ T2052] RBP: 00007f66fbf001c4 R08: 0000000000000000 R09:
>> 0000562feab9d890
>> [  239.032108][ T2052] R10: 0000000000000000 R11: 0000000000000246 R12:
>> 0000000000000000
>> [  239.039946][ T2052] R13: 0000000000000000 R14: 0000562feab9aba0 R15:
>> 0000562feab9ab80
>> [  239.047783][ T2052]  </TASK>
>> [  239.050664][ T2052] Modules linked in: dm_mod btrfs blake2b_generic
>> xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi sg ipmi_devintf
>> ata_generic ipmi_msghandler intel_rapl_msr intel_rapl_common
>> x86_pkg_temp_thermal intel_powerclamp coretemp i915 kvm_intel kvm
>> intel_gtt ttm drm_kms_helper irqbypass crct10dif_pclmul crc32_pclmul
>> crc32c_intel syscopyarea ghash_clmulni_intel sysfillrect mei_wdt
>> sysimgblt fb_sys_fops ata_piix rapl intel_cstate mei_me drm libata mei
>> intel_uncore video ip_tables
>> [  239.094228][ T2052] ---[ end trace 0000000000000000 ]---
>> [  239.099560][ T2052] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
>> [  239.105641][ T2052] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03
>> 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85
>> 19 fb ff ff <0f> 0b 4c 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b
>> 7c 24 78
>> [  239.125151][ T2052] RSP: 0018:ffffc900033cf6c8 EFLAGS: 00010246
>> [  239.131117][ T2052] RAX: ffff8881028b2980 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [  239.138981][ T2052] RDX: 0000000000000000 RSI: 0000000000000008 RDI:
>> fffff52000679e75
>> [  239.146847][ T2052] RBP: 000000000000033c R08: 000000000000005e R09:
>> ffffed1034dd6791
>> [  239.154710][ T2052] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 R12:
>> ffff88812830c500
>> [  239.162579][ T2052] R13: ffff8881028b2998 R14: ffff8881028b299c R15:
>> 0000000000000022
>> [  239.170443][ T2052] FS:  00007f66fb9b4100(0000)
>> GS:ffff8881a6e80000(0000) knlGS:0000000000000000
>> [  239.179267][ T2052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  239.185742][ T2052] CR2: 000055f0bbc19d40 CR3: 0000000209c0a005 CR4:
>> 00000000001706e0
>> [  239.193607][ T2052] Kernel panic - not syncing: Fatal exception
>> [  239.199567][ T2052] Kernel Offset: disabled
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> [   44.577527][ T1980] ------------[ cut here ]------------
>>>> [   44.583552][  T335]
>>>> [   44.583990][  T337] 512+0 records out
>>>> [   44.583997][  T337]
>>>> [   44.593932][ T1980] kernel BUG at fs/btrfs/volumes.c:7157!
>>>> [   44.593940][ T1980] invalid opcode: 0000 [#1] SMP KASAN PTI
>>>> [   44.598832][  T335]   Data:             single            8.00MiB
>>>> [   44.603293][ T1980] CPU: 5 PID: 1980 Comm: mount Not tainted
>>>> 5.17.0-rc4-00095-g7f159e82828e #1
>>>> [   44.603297][ T1980] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN,
>>>> BIOS A05 12/05/2013
>>>> [   44.603299][ T1980] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
>>>> [   44.605509][  T335]
>>>> [   44.609168][ T1980] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0
>>>> 03 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2
>>>> 0f 85 19 fb ff ff <0f> 0b 4c
>>>> 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b 7c 24 78
>>>> [   44.609171][ T1980] RSP: 0018:ffffc90002be76c8 EFLAGS: 00010246
>>>> [   44.609175][ T1980] RAX: ffff888102c98e00 RBX: 0000000000000000
>>>> RCX: 0000000000000000
>>>> [   44.609178][ T1980] RDX: 0000000000000000 RSI: 0000000000000008
>>>> RDI: fffff5200057ce75
>>>> [   44.612227][  T335]   Metadata:         DUP               1.00GiB
>>>> [   44.616871][ T1980] RBP: 000000000000033c R08: 000000000000005e
>>>> R09: ffffed1034dd6791
>>>> [   44.616873][ T1980] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790
>>>> R12: ffff888214586b40
>>>> [   44.616874][ T1980] R13: ffff888102c98e18 R14: ffff888102c98e1c
>>>> R15: 0000000000000022
>>>> [   44.616876][ T1980] FS:  00007fad1bd12100(0000)
>>>> GS:ffff8881a6e80000(0000) knlGS:0000000000000000
>>>> [   44.622475][  T335]
>>>> [   44.628578][ T1980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   44.628580][ T1980] CR2: 00007fff9d90df68 CR3: 00000001407fc003
>>>> CR4: 00000000001706e0
>>>> [   44.628583][ T1980] DR0: 0000000000000000 DR1: 0000000000000000
>>>> DR2: 0000000000000000
>>>> [   44.628585][ T1980] DR3: 0000000000000000 DR6: 00000000fffe0ff0
>>>> DR7: 0000000000000400
>>>> [   44.628588][ T1980] Call Trace:
>>>> [   44.638095][  T335]   System:           DUP               8.00MiB
>>>> [   44.645166][ T1980]  <TASK>
>>>> [   44.645168][ T1980]  ? _raw_spin_lock+0x81/0x100
>>>> [   44.651206][  T335]
>>>> [   44.653388][ T1980]  ? _raw_spin_lock_bh+0x100/0x100
>>>> [   44.653395][ T1980]  ?
>>>> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>>>> [   44.673370][  T335] SSD detected:       no
>>>> [   44.678876][ T1980]  ? add_missing_dev+0x3c0/0x3c0 [btrfs]
>>>> [   44.686756][  T335]
>>>> [   44.694598][ T1980]  ? btrfs_get_token_64+0x700/0x700 [btrfs]
>>>> [   44.701187][  T335] Zoned device:       no
>>>> [   44.708574][ T1980]  ? memcpy+0x39/0x80
>>>> [   44.708581][ T1980]  ? write_extent_buffer+0x192/0x240 [btrfs]
>>>> [   44.716449][  T335]
>>>> [   44.724294][ T1980]  btrfs_read_sys_array+0x2c7/0x380 [btrfs]
>>>> [   44.734138][  T335] Incompat features:  extref, skinny-metadata,
>>>> no-holes
>>>> [   44.735313][ T1980]  ? read_one_dev+0x13c0/0x13c0 [btrfs]
>>>> [   44.741786][  T335]
>>>> [   44.749628][ T1980]  ? mutex_lock+0x80/0x100
>>>> [   44.749634][ T1980]  ? __mutex_lock_slowpath+0x40/0x40
>>>> [   44.758164][  T335] Runtime features:   free-space-tree
>>>> [   44.765352][ T1980]  ? btrfs_init_workqueues+0x4c1/0x7ba [btrfs]
>>>> [   44.768515][  T335]
>>>> [   44.774620][ T1980]  open_ctree+0x16ac/0x2656 [btrfs]
>>>> [   44.777966][  T335] Checksum:           crc32c
>>>> [   44.782064][ T1980]  btrfs_mount_root.cold+0x13/0x192 [btrfs]
>>>> [   44.784268][  T335]
>>>> [   44.789241][ T1980]  ? arch_stack_walk+0x9e/0x100
>>>> [   44.789247][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
>>>> [   44.796977][  T335] Number of devices:  1
>>>> [   44.800614][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
>>>> [   44.806131][  T335]
>>>> [   44.808314][ T1980]  ? legacy_parse_param+0x6a/0x7c0
>>>> [   44.808320][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
>>>> [   44.814273][  T335] Devices:
>>>> [   44.818205][ T1980]  legacy_get_tree+0xef/0x200
>>>> [   44.818210][ T1980]  vfs_get_tree+0x84/0x2c0
>>>> [   44.822077][  T335]
>>>> [   44.827928][ T1980]  fc_mount+0xf/0x80
>>>> [   44.827934][ T1980]  vfs_kern_mount+0x71/0xc0
>>>> [   44.830557][  T335]    ID        SIZE  PATH
>>>> [   44.835890][ T1980]  btrfs_mount+0x1fc/0xa40 [btrfs]
>>>> [   44.842730][  T335]
>>>> [   44.848134][ T1980]  ? kasan_save_stack+0x1e/0x40
>>>> [   44.848149][ T1980]  ? kasan_set_track+0x21/0x40
>>>> [   44.850862][  T335]     1   300.00GiB  /dev/sdb4
>>>> [   44.854618][ T1980]  ? kasan_set_free_info+0x20/0x40
>>>> [   44.854624][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
>>>> [   44.859803][  T335]
>>>> [   44.865032][ T1980]  ? __x64_sys_mount+0x12c/0x1c0
>>>> [   44.865036][ T1980]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [   44.871101][  T335]
>>>> [   44.873263][ T1980]  ? terminate_walk+0x203/0x4c0
>>>> [   44.873268][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
>>>> [   44.878354][  T335]
>>>> [   44.882803][ T1980]  ? legacy_parse_param+0x6a/0x7c0
>>>> [   44.882808][ T1980]  ? vfs_parse_fs_string+0xd7/0x140
>>>> [   44.889280][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb1
>>>> [   44.890770][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
>>>> [   44.895501][  T335]
>>>> [   44.901430][ T1980]  ? legacy_get_tree+0xef/0x200
>>>> [   44.901435][ T1980]  legacy_get_tree+0xef/0x200
>>>> [   44.901448][ T1980]  ? security_capable+0x56/0xc0
>>>> [   44.905612][  T335]  btrfs
>>>> [   44.911057][ T1980]  vfs_get_tree+0x84/0x2c0
>>>> [   44.911062][ T1980]  ? ns_capable_common+0x57/0x100
>>>> [   44.913278][  T335]
>>>> [   44.918247][ T1980]  path_mount+0x7fc/0x1a40
>>>> [   44.918252][ T1980]  ? kasan_set_track+0x21/0x40
>>>> [   44.925201][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb1
>>>> /fs/sdb1
>>>> [   44.927087][ T1980]  ? finish_automount+0x600/0x600
>>>> [   44.927092][ T1980]  ? kmem_cache_free+0xa1/0x400
>>>> [   44.931642][  T335]
>>>> [   44.935926][ T1980]  do_mount+0xca/0x100
>>>> [   44.935931][ T1980]  ? path_mount+0x1a40/0x1a40
>>>> [   44.935933][ T1980]  ? _copy_from_user+0x94/0x100
>>>> [   44.938799][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb2
>>>> [   44.941885][ T1980]  ? memdup_user+0x4e/0x80
>>>> [   44.941890][ T1980]  __x64_sys_mount+0x12c/0x1c0
>>>> [   44.941893][ T1980]  do_syscall_64+0x3b/0xc0
>>>> [   44.946884][  T335]
>>>> [   44.951068][ T1980]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [   44.951074][ T1980] RIP: 0033:0x7fad1bf10fea
>>>> [   44.951077][ T1980] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48
>>>> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8
>>>> a5 00 00 00 0f 05 <48> 3d 01
>>>> f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
>>>> [   44.956197][  T335]  btrfs
>>>> [   44.958245][ T1980] RSP: 002b:00007fff9d90f878 EFLAGS: 00000246
>>>> ORIG_RAX: 00000000000000a5
>>>> [   44.958249][ T1980] RAX: ffffffffffffffda RBX: 00005628efc57970
>>>> RCX: 00007fad1bf10fea
>>>> [   44.958251][ T1980] RDX: 00005628efc57b80 RSI: 00005628efc57bc0
>>>> RDI: 00005628efc57ba0
>>>> [   44.958263][ T1980] RBP: 00007fad1c25e1c4 R08: 0000000000000000
>>>> R09: 00005628efc5a890
>>>> [   44.958264][ T1980] R10: 0000000000000000 R11: 0000000000000246
>>>> R12: 0000000000000000
>>>> [   44.962993][  T335]
>>>> [   44.967613][ T1980] R13: 0000000000000000 R14: 00005628efc57ba0
>>>> R15: 00005628efc57b80
>>>> [   44.967616][ T1980]  </TASK>
>>>> [   44.967617][ T1980] Modules linked in: dm_mod btrfs
>>>> blake2b_generic xor raid6_pq
>>>> [   44.973257][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb2
>>>> /fs/sdb2
>>>> [   44.977243][ T1980]  zstd_compress libcrc32c sd_mod t10_pi sg
>>>> [   44.983019][  T335]
>>>> [   44.985203][ T1980]  ipmi_devintf ata_generic ipmi_msghandler
>>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
>>>> intel_powerclamp coretemp kvm_intel
>>>> [   44.990720][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb3
>>>> [   44.995962][ T1980]  i915 kvm intel_gtt ttm drm_kms_helper
>>>> irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
>>>> ghash_clmulni_intel syscopyarea sysfillrect
>>>> [   44.998174][  T335]
>>>> [   45.002882][ T1980]  sysimgblt rapl mei_wdt fb_sys_fops ata_piix
>>>> intel_cstate libata drm mei_me mei intel_uncore video ip_tables
>>>> [   45.002919][ T1980] ---[ end trace 0000000000000000 ]---
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>>
>>>>>> [   75.279958][ T3602] ------------[ cut here ]------------
>>>>>> [   75.285221][ T3602] kernel BUG at fs/btrfs/scrub.c:3387!
>>>>>> [   75.290490][ T3602] invalid opcode: 0000 [#1] SMP KASAN PTI
>>>>>> [   75.296010][ T3602] CPU: 2 PID: 3602 Comm: btrfs Not tainted
>>>>>> 5.17.0-rc4-00095-g6b837d4c40d5 #1
>>>>>> [   75.304521][ T3602] Hardware name: Dell Inc. OptiPlex
>>>>>> 9020/0DNKMN, BIOS A05 12/05/2013
>>>>>> [   75.312344][ T3602] RIP: 0010:scrub_stripe+0xed3/0x1340 [btrfs]
>>>>>> [   75.318250][ T3602] Code: 90 00 00 00 e8 0e f9 96 c0 e9 98 f3 ff
>>>>>> ff e8 c4 f9 96 c0 e9 26 f3 ff ff 48 8b bc 24 80 00 00 00 e8 f2 f8
>>>>>> 96 c0 e9 3b f4 ff ff <0f> 0b 0f
>>>>>> 0b 4c 8d a4 24 b8 01 00 00 31 f6 4c 8d bd 20 02 00 00 4c
>>>>>> [   75.337480][ T3602] RSP: 0018:ffffc9000b47f550 EFLAGS: 00010246
>>>>>> [   75.343340][ T3602] RAX: 0000000000000007 RBX: ffff88810231d600
>>>>>> RCX: ffff88810231d61c
>>>>>> [   75.351074][ T3602] RDX: 0000000000000000 RSI: 0000000000000004
>>>>>> RDI: ffff8881023a2458
>>>>>> [   75.358807][ T3602] RBP: ffff8881097ad800 R08: 0000000000000001
>>>>>> R09: ffffed102828100d
>>>>>> [   75.366550][ T3602] R10: ffff888141408063 R11: ffffed102828100c
>>>>>> R12: 0000000000000000
>>>>>> [   75.374282][ T3602] R13: 0000000000100000 R14: ffff888141408000
>>>>>> R15: ffff888129c9c000
>>>>>> [   75.382016][ T3602] FS:  00007f94c24ec8c0(0000)
>>>>>> GS:ffff8881a6d00000(0000) knlGS:0000000000000000
>>>>>> [   75.390691][ T3602] CS:  0010 DS: 0000 ES: 0000 CR0:
>>>>>> 0000000080050033
>>>>>> [   75.397054][ T3602] CR2: 00007ffe454aa8e8 CR3: 000000020a796004
>>>>>> CR4: 00000000001706e0
>>>>>> [   75.404785][ T3602] Call Trace:
>>>>>> [   75.407886][ T3602]  <TASK>
>>>>>> [   75.410645][ T3602]  ? btrfs_wait_ordered_extents+0x9a1/0xe40
>>>>>> [btrfs]
>>>>>> [   75.417049][ T3602]  ? scrub_raid56_parity+0x5c0/0x5c0 [btrfs]
>>>>>> [   75.422853][ T3602]  ? btrfs_remove_ordered_extent+0xbc0/0xbc0
>>>>>> [btrfs]
>>>>>> [   75.429341][ T3602]  ? mutex_unlock+0x80/0x100
>>>>>> [   75.433733][ T3602]  ? __wake_up_common_lock+0xe3/0x140
>>>>>> [   75.438897][ T3602]  ? __lookup_extent_mapping+0x215/0x300 [btrfs]
>>>>>> [   75.445037][ T3602]  scrub_chunk+0x294/0x480 [btrfs]
>>>>>> [   75.449984][ T3602]  scrub_enumerate_chunks+0x643/0x1340 [btrfs]
>>>>>> [   75.455962][ T3602]  ? scrub_chunk+0x480/0x480 [btrfs]
>>>>>> [   75.461083][ T3602]  ? __scrub_blocked_if_needed+0xb9/0x200 [btrfs]
>>>>>> [   75.467317][ T3602]  ? scrub_checksum_data+0x4c0/0x4c0 [btrfs]
>>>>>> [   75.473121][ T3602]  ? down_read+0x137/0x240
>>>>>> [   75.477339][ T3602]  ? mutex_unlock+0x80/0x100
>>>>>> [   75.481726][ T3602]  ? __mutex_unlock_slowpath+0x300/0x300
>>>>>> [   75.487743][ T3602]  ? btrfs_find_device+0xac/0x240 [btrfs]
>>>>>> [   75.493285][ T3602]  btrfs_scrub_dev+0x535/0xc00 [btrfs]
>>>>>> [   75.498578][ T3602]  ? scrub_enumerate_chunks+0x1340/0x1340 [btrfs]
>>>>>> [   75.504812][ T3602]  ? btrfs_apply_pending_changes+0x80/0x80
>>>>>> [btrfs]
>>>>>> [   75.511120][ T3602]  ? btrfs_record_root_in_trans+0x4d/0x180
>>>>>> [btrfs]
>>>>>> [   75.517428][ T3602]  ? finish_wait+0x280/0x280
>>>>>> [   75.521819][ T3602]  btrfs_dev_replace_by_ioctl.cold+0x62c/0x720
>>>>>> [btrfs]
>>>>>> [   75.528483][ T3602]  ?
>>>>>> btrfs_finish_block_group_to_copy+0x3c0/0x3c0 [btrfs]
>>>>>> [   75.535440][ T3602]  ?
>>>>>> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>>>>>> [   75.542575][ T3602]  btrfs_ioctl+0x37ee/0x51c0 [btrfs]
>>>>>> [   75.547691][ T3602]  ? fput_many+0xaa/0x140
>>>>>> [   75.551823][ T3602]  ? filp_close+0xef/0x140
>>>>>> [   75.556041][ T3602]  ? __x64_sys_close+0x2d/0x80
>>>>>> [   75.560600][ T3602]  ? do_syscall_64+0x3b/0xc0
>>>>>> [   75.564991][ T3602]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>> [   75.570838][ T3602]  ?
>>>>>> btrfs_ioctl_get_supported_features+0x40/0x40 [btrfs]
>>>>>> [   75.577756][ T3602]  ? _raw_spin_lock_irq+0x82/0xd2
>>>>>> [   75.582572][ T3602]  ? _raw_spin_lock+0x100/0x100
>>>>>> [   75.587218][ T3602]  ? fiemap_prep+0x200/0x200
>>>>>> [   75.591607][ T3602]  ? lockref_put_or_lock+0xc4/0x1c0
>>>>>> [   75.596600][ T3602]  ? do_sigaction+0x4b3/0x840
>>>>>> [   75.601075][ T3602]  ? __x64_sys_pidfd_send_signal+0x600/0x600
>>>>>> [   75.606837][ T3602]  ? __might_fault+0x4d/0x80
>>>>>> [   75.611226][ T3602]  ? __x64_sys_rt_sigaction+0x1d0/0x240
>>>>>> [   75.616558][ T3602]  ? __ia32_sys_signal+0x140/0x140
>>>>>> [   75.621461][ T3602]  ? __fget_light+0x57/0x540
>>>>>> [   75.625854][ T3602]  __x64_sys_ioctl+0x127/0x1c0
>>>>>> [   75.630414][ T3602]  do_syscall_64+0x3b/0xc0
>>>>>> [   75.634633][ T3602]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>> [   75.640307][ T3602] RIP: 0033:0x7f94c25df427
>>>>>> [   75.644533][ T3602] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00
>>>>>> 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00
>>>>>> b8 10 00 00 00 0f 05 <48> 3d 01
>>>>>> f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
>>>>>> [   75.663771][ T3602] RSP: 002b:00007ffd06a4acc8 EFLAGS: 00000246
>>>>>> ORIG_RAX: 0000000000000010
>>>>>> [   75.671937][ T3602] RAX: ffffffffffffffda RBX: 000055d51e9f72a0
>>>>>> RCX: 00007f94c25df427
>>>>>> [   75.679671][ T3602] RDX: 00007ffd06a4b108 RSI: 00000000ca289435
>>>>>> RDI: 0000000000000004
>>>>>> [   75.687404][ T3602] RBP: 00000000ffffffff R08: 0000000000000000
>>>>>> R09: 000055d51e9fa580
>>>>>> [   75.695137][ T3602] R10: 0000000000000008 R11: 0000000000000246
>>>>>> R12: 00007ffd06a4e97a
>>>>>> [   75.702868][ T3602] R13: 0000000000000004 R14: 0000000000000000
>>>>>> R15: 0000000000000005
>>>>>> [   75.710600][ T3602]  </TASK>
>>>>>> [   75.713445][ T3602] Modules linked in: dm_mod btrfs
>>>>>> blake2b_generic xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi
>>>>>> sg ata_generic ipmi_devintf ipmi_msghandler
>>>>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
>>>>>> intel_powerclamp coretemp i915 kvm_intel kvm intel_gtt ttm
>>>>>> irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
>>>>>> ghash_clmulni_intel drm_kms_helper syscopyarea sysfillrect
>>>>>> sysimgblt fb_sys_fops rapl ata_piix mei_wdt intel_cstate drm libata
>>>>>> mei_me intel_uncore mei video ip_tables
>>>>>> [   75.756460][ T3602] ---[ end trace 0000000000000000 ]---
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>> _______________________________________________
>>> LKP mailing list -- lkp@lists.01.org
>>> To unsubscribe send an email to lkp-leave@lists.01.org
