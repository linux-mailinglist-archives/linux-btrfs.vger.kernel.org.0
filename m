Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0EC5A5BE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 08:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiH3Gca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 02:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiH3GcX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 02:32:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8D9BBA46;
        Mon, 29 Aug 2022 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661841141; x=1693377141;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jkfvH1YJ1oPjSnSC6xMNxi1ekjWyMsUlr9xZfkIeDI8=;
  b=k4o99Cd1PzVLSNdDLgIPlbVgdOggr6Y615uKA7CFlT81js5HO1L2dB8Z
   mr/0qhrl4RPJn1jPFPNYGbJ0ltzLt159QqqWJRKo8OifTH4x76yLPpZE/
   L259pmSM/2lazj7V7JV2WR24MkLALvzexRHxPHBX6j73PjFc8IakatZQq
   huwq+ONjcGAJzGMMsq/7VKyum/byRcj0kdEy52+pFKxBw052ilz96+WHW
   Yqt+fUNOuQKZUKQ5AVkrD+ZwNPw9cBpP+0Me/b2Im1Xe2Djb5bWjL6Mlc
   q8j2yL8KLpzS3gzTOMj83nH5Px3TOrppNUqwsaGAcAmVmSfRw9S1BScTY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="359059042"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="359059042"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 23:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="787384345"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2022 23:32:21 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 23:32:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 23:32:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 23:32:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 23:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3Z0ZCmhIuxS1P7S9tZ00jkzje3971OefX6l2UNLSS7MiVRPiXbll1FlnglZdsQg0rG3A84n/Bn0BtKv87NNS0fCJjnvMv8vErfu2W3iWjMiXdir6uEI/f0/jCUANrXF2EqzHdU8eveHkJLOOR5t+XASFe805b9SAlDsxE9M+SiKgoqZk5kDbRbFw8cYzgGqF/gUDstUe7cHDhxqaIAerlUzPJSEU+5qua0ZLPvo9mxoeBrJiPYveOX7u3tg5V3XIsWIowXjw48iMTkqXf3GvpbeJrL2wckjAVWgQJclVK1vQhtWwR/MNVg3aDadblbJPbpnr/CBA4tIbohwLRPzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAV37bbeGvpzS1MdYWqK2bp+nziJGdn2VMfXfxAD/B8=;
 b=fBBBwoIA9AC8LKXyYhCGKETgvY7H0emLsYomTPKY+Ltnlnv1itTVbsa3VEMwrrD5Sbw6ooaZdgswxF8CYzq3dCYlziWp/EiCtpNDaXamdYdQjNQfBCRNFTc9wat5fv8otM+x+3ERoryMbWrNQqbaeUYbBbHEFdqmg2Tzi+4x8uVNNgg7UCJKWmTq70NQPEPnT5JYj1ST6P7sx0winH5Y7ZEAz9lVWn3v0UxfjvHlK4FkhdksvOnHqqFJNXMngfgbTrHGuQUj2W4fpI5Nt8h2J8DszA8yi1Mu0Q4ZNLaXb/H9lYZWQ3CAhi/B88NTeH8EF+oVm3SttNeAP5uToq2eZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by DM6PR11MB3210.namprd11.prod.outlook.com (2603:10b6:5:e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Tue, 30 Aug 2022 06:32:18 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::5d19:fbdf:562:ac80]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::5d19:fbdf:562:ac80%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 06:32:18 +0000
Message-ID: <4b5d1c96-44c5-e8bb-01d8-9f9c72621d0d@intel.com>
Date:   Tue, 30 Aug 2022 14:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [LKP] [btrfs] ca6dee6b79:
 fxmark.ssd_btrfs_MWRM_72_bufferedio.works/sec -8.4% regression
Content-Language: en-US
From:   Yujie Liu <yujie.liu@intel.com>
To:     Filipe Manana <fdmanana@suse.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <fengwei.yin@intel.com>, <regressions@lists.linux.dev>
References: <20220830030032.GA2884@inn2.lkp.intel.com>
 <eb352106-5a3c-63fe-2409-494cf0a31bfc@intel.com>
In-Reply-To: <eb352106-5a3c-63fe-2409-494cf0a31bfc@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0459ab58-a240-4462-841f-08da8a5162f4
X-MS-TrafficTypeDiagnostic: DM6PR11MB3210:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUU1OUUuye99o250H1JpRFa1FfpMbiY/0KEaQc0zgoVP3KbRk0zR5RrjZ39G20w/HS3JHU6+GqtxKYcVe0eKdVjQMoP7EpNXvQ3MpW0pAb614YEYUiDCzeIEI2yiQJgM9pXatvBVirZ77Fi39K/GuL7fdXqzrNGfT/b927cnq42F874CGz7UW2rvzI62MkUM3sscdpad2r773Do4Gp4EksPSpXNwCcIab3KHeiPH7CpceZWSqIHb9im2Pai0FLSRDdKl2J0wczzSsXP0a2lqc4/7eFSV9+e3RzKSjror6+L9wXgIxjG6DeFHJGIlknY2BwaV5QuwE2yil//ON5NrSqMIz0XhiuMgY+kWwjVuYQTzr4tv2GoWhHdr/k/qVMA2xBSb9FBh4GZkQ/kKam97HWh7Vdjt/lI2HawRso+eNZvfknyQHBx9paEXrz+3GZ3O0rcYLSI/KH3xTShWPCYSkLJLvppYZW43DO/9JNC7zxR/nhC8/jno3usk0MlxaJ6LFSwyX/tVcX4xa/iRffiPn8S8ltRzhIbPAoPNqJfj+g+JuTMuh6BLYLTedGCFAHQps0tYowKk+kIz9AYT3Kt9nVIUr9YwcdxaSNA+iVUYtvGyjuSJk4B6fdzWjXihUYGZE/vn+n6KVpzHoyR5VhRYb/9FH0YRbaO3Ub/GRatYv3EVMwZNL5JBHRZYAnG+DHjQ7CF/aFXAU9QEE21QbC2vwqJfQnz4Dcc/2wQxll7tPckyjt39FhXGn+IARxxNEvM2b9efn3E4kCYi4pdb2ylFxB7SQ753Iof2JARSFrj0eT0mJRB+qArp/bVyyoFeZ1Cq8avF7o/7zshdjwmob9mLo7AORPa/5cYgUJ1jwchH2Q9/9Yh+uoZQNBenw4PavpZM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(136003)(396003)(6666004)(6512007)(82960400001)(86362001)(53546011)(26005)(6506007)(36756003)(186003)(83380400001)(2616005)(41300700001)(31686004)(478600001)(966005)(6486002)(31696002)(6916009)(66946007)(8676002)(316002)(44832011)(54906003)(4326008)(66476007)(66556008)(8936002)(2906002)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9nZUlBY2hjUjkyOTdoU0VOV0F1azJyaHJzTGdsNlhEdWZveXllRStUaDJG?=
 =?utf-8?B?TWhrUVVTWTBZREVRYkhNbjd0NExucDNacjd6SGRkdTZnYW9mbW5QTXBEVDZl?=
 =?utf-8?B?eHhGOENpOE9YaHhhUVEreXc0cXpKYU1jODN6OGtTaElhb2NkRStQRkRaZ0pN?=
 =?utf-8?B?b0l6NHZZM2pLQmRrRVNTdGpvRmhVYk9GUkJYOWEzWVJXT2YydytnOUtoaEE0?=
 =?utf-8?B?V3A3bEpUMWVWVWVDZzhCZTc3TWJtSlpRTGlRRkxJZXlnaS9FdzJ2azA4Qmp3?=
 =?utf-8?B?WHd2bmJ4Z0x4NTRSMCtGWGtpeFQwTmhsU3RwQThaMFZZdGdJNW5aZG5BMHBN?=
 =?utf-8?B?aUdpc1RhTWJkTlBvdFZJaHE1TDk1anB1Tk15cks2K3ZJUVZIN2ZsQ1dJYW5l?=
 =?utf-8?B?NWdpVk05SlRQMkkrcVNFUVZGcUNndG5NcFpPZzdyRko4SG1JUXFQWlphQlBB?=
 =?utf-8?B?VllaeWVDeUNaUFVXWVlhYmx2T3BSRWtqMFNKTEk1TXJ1VlA4RVVXK3NlSjJX?=
 =?utf-8?B?TW1hSDhONkh0UVY5R1lBc3ZMcXltbFNqVjU3aDVvendPSXM3YVY2c2JUL1hV?=
 =?utf-8?B?M2pXV0orVHY3dFJKTGJVcmFhaEU3aGsrdVNTTlJPRFRtVTVQT1MzSXJzTlVh?=
 =?utf-8?B?alJ4S0pEUkZSaExobTREQndzSWRIdFpPRWVaU2lTMDc0S3k2ZEMzbTdUUzRV?=
 =?utf-8?B?NUZBV3VhL0V1aUErZFNmc0R5NzNzdk5DVUNkUDNqZG1sYmZPdGNmZDgwcUJU?=
 =?utf-8?B?WHBRb003ZThXaEFZZ2d3aEh5ZjNyMGFHR2kwV3BUQW03S3hIdld3K0tqSW44?=
 =?utf-8?B?djBZRjR5TGpNUEV1WWVuMFNPTHZURnJaUWtDa1Z4RzNpWlljK0gyem9iQzZH?=
 =?utf-8?B?ZU8xM2hnTy9ZaytFdEExZDFNa0xrcVMwc3ZQRFhUSE5RcEdoalRFN0NXSGNr?=
 =?utf-8?B?MkoxdXpsVHZFMW1yMmgzZzJJeVpvMnVySVpYOVphblVkbVdXWXZJR1FGZFc2?=
 =?utf-8?B?ZGVTRHZVRnJXVW12bWd6dCtJSFBNZzJiUGhyeUpnTnFBakwrSzJObFBxYU03?=
 =?utf-8?B?aElteHdhSTlpTEZQakxGeUVnTDdQU2ZTbWZzUmR2VEFpSzM0eCsyd2MwUWw2?=
 =?utf-8?B?bXpGdmwxTXZtTy9SQUY3eXFoYjZrOEIxZldtcjVSZGp1TEpwVUdYTC91T1dk?=
 =?utf-8?B?cDlXZDZ2TFpvUHhZaklSZVdzN3pqWXlPZ1Y0aWJHMzhWdjFXeGV1OGNMMmNh?=
 =?utf-8?B?RWZ3QXJmVE5mM0VsTm55NUhBNWR5Tlh6ME9yRTBCK2JwZWZoeHBDN1lLbEI5?=
 =?utf-8?B?QWJoYjBRTGZVZXRUQXh1SFhYUm5FNWlWclVBMEd2S1ZLUFhFV3VrTGFGSXJS?=
 =?utf-8?B?eGZJcE40aWt6aGFLS3F4a3d4Y210Ry9WN2I5UVArSEM5OVQxL2RCZENERmFw?=
 =?utf-8?B?bG1jcTgxc2kzY0xoaks1TUVHeVZZdloxVG16ZndRTmxiUGNPV0pkMHB4a29X?=
 =?utf-8?B?MUxYVFpXSWkyU2kwOVNkQjFCUXFkc214Ni9vYUdrTncvcTZhelhheGFseGEw?=
 =?utf-8?B?WlNoTUh1ck4yWFdUaDVPR0wzS3lpWlBHK00vb2Y0Q2ZDQXZGRm8zbmpyVndO?=
 =?utf-8?B?anFuUFBJS3M3TUdDaHVRQ2liR09GcVNueC9mRWswT0l2eG9wNmNyZ1RVaXVX?=
 =?utf-8?B?eVB0aXZxME1jZWZMM1NqSUFjbmpRYjkwZ1ZZNW9NdTNZb1p0eTh4SUNZMDgy?=
 =?utf-8?B?YUszQlllZytrNEErNm9nMzRYSitVRnlYc2lpbjZXTjhlRnlNeTNQMkJWaHQ1?=
 =?utf-8?B?LzRHc3VWWHpWeVN5Zm1ucEdtYmNYMzIrcXBzdi9Sd3k1M204KzdLQ1FiWDdP?=
 =?utf-8?B?TjhzWUdFTmozVGtXUXR3dXpQM2xJYjhvMDFydkZrbWRuMkMxQytPR09lYnFL?=
 =?utf-8?B?amR5VmtIZ3ZTelpkU1ZZbnBVNWFqSXpVRHpSd0tRbzdLMm9ZRjVpbHZVdm1F?=
 =?utf-8?B?eWtqQ2hLejBMd2FtOHkxclRWd3JTV1VCNHpaekZxN0dlS2lUWGlaUHlDUXNK?=
 =?utf-8?B?OXorMzBVU0g1ZUo3V1kyY3FmQ3JkeHBwWlZ3Ykxobk5FYVNKd2FORjBYeXhx?=
 =?utf-8?Q?zih0dyrrw2ezl0MZsk0MwtSY+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0459ab58-a240-4462-841f-08da8a5162f4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 06:32:18.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVoMKNzomBf1N+5rIStveqKlmypyKwnQjlWQbsESCUDcdeZZCIjlK4mJw8R+p7+ljWpMkJK9LhUB8m/w4FOFWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3210
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

Hi Filipe,

We noticed that this case was reported when the patch was in linux-next.
Thanks for your comment that it is an expected result due to heavy rename.

https://lore.kernel.org/all/Ysb4T7Z8hKgdvPRk@xsang-OptiPlex-9020/

This report is due to the patch being merged into mainline, if it is still
the same case, please ignore this duplicate report. Sorry for the inconvenience.

--
Thanks,
Yujie

On 8/30/2022 11:17, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -8.4% regression of fxmark.ssd_btrfs_MWRM_72_bufferedio.works/sec due to commit:
> 
> 
> commit: ca6dee6b7946794fa340a7290ca399a50b61705f ("btrfs: balance btree dirty pages and delayed items after a rename")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: fxmark
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> with following parameters:
> 
>      disk: 1SSD
>      media: ssd
>      test: MWRM
>      fstype: btrfs
>      directio: bufferedio
>      cpufreq_governor: performance
>      ucode: 0xd000363
> 
> test-description: FxMark is a filesystem benchmark that test multicore scalability.
> test-url: https://github.com/sslab-gatech/fxmark
> 
> 
> =========================================================================================
> compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
>    gcc-11/performance/bufferedio/1SSD/btrfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/MWRM/fxmark/0xd000363
> 
> commit:
>    b8bea09a45 ("btrfs: add trace event for submitted RAID56 bio")
>    ca6dee6b79 ("btrfs: balance btree dirty pages and delayed items after a rename")
> 
> b8bea09a456fc31a ca6dee6b7946794fa340a7290ca
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>     1821853           -13.9%    1568247 ±  3%  fxmark.ssd_btrfs_MWRM_36_bufferedio.works
>       36436           -13.9%      31362 ±  3%  fxmark.ssd_btrfs_MWRM_36_bufferedio.works/sec
>     1675102           -14.0%    1439994 ±  7%  fxmark.ssd_btrfs_MWRM_54_bufferedio.works
>       33497           -14.0%      28796 ±  7%  fxmark.ssd_btrfs_MWRM_54_bufferedio.works/sec
>     1572332            -8.4%    1440600 ±  6%  fxmark.ssd_btrfs_MWRM_72_bufferedio.works
>       31445            -8.4%      28809 ±  6%  fxmark.ssd_btrfs_MWRM_72_bufferedio.works/sec
>      356010           +80.0%     640832        fxmark.time.involuntary_context_switches
>       68.50           -24.1%      52.00        fxmark.time.percent_of_cpu_this_job_got
>      630.47           -24.0%     479.23        fxmark.time.system_time
>   1.335e+10           +49.8%      2e+10        cpuidle..time
>        1045 ±  4%     +11.8%       1168        uptime.idle
>       31.54           +50.2%      47.37        iostat.cpu.idle
>       64.16           -24.7%      48.29        iostat.cpu.system
>       31.17           +50.3%      46.83        vmstat.cpu.id
>       12.83 ±  5%     -55.8%       5.67 ±  8%  vmstat.procs.r
>       32.13           +15.8       47.95        mpstat.cpu.all.idle%
>        0.47 ±  7%      +0.1        0.53 ±  3%  mpstat.cpu.all.iowait%
>       63.37           -16.1       47.31        mpstat.cpu.all.sys%
>       10.04 ±  3%     +13.5%      11.39 ±  3%  perf-stat.i.metric.K/sec
>      869.81 ± 10%     -16.2%     728.74 ± 15%  perf-stat.i.node-loads
>      871.23 ± 10%     -16.2%     730.49 ± 15%  perf-stat.ps.node-loads
>        3004 ±  8%     -52.1%       1440 ±  6%  numa-meminfo.node0.Active(anon)
>     1218568           -10.8%    1086453        numa-meminfo.node0.Inactive
>      351812 ±  3%     -29.0%     249640 ± 12%  numa-meminfo.node0.Inactive(anon)
>      120150           -79.3%      24861 ±  3%  numa-meminfo.node0.Shmem
>        3489 ±  8%     -45.0%       1919 ±  2%  meminfo.Active(anon)
>      492107           -19.0%     398809        meminfo.Committed_AS
>      382253           -24.6%     288151        meminfo.Inactive(anon)
>      124727           -76.8%      28886 ±  2%  meminfo.Shmem
>        2050 ±  4%     -10.5%       1834 ±  5%  meminfo.Writeback
>      750.83 ±  8%     -52.1%     360.00 ±  6%  numa-vmstat.node0.nr_active_anon
>       87951 ±  3%     -29.0%      62408 ± 12%  numa-vmstat.node0.nr_inactive_anon
>       30038           -79.3%       6216 ±  3%  numa-vmstat.node0.nr_shmem
>      750.83 ±  8%     -52.1%     360.00 ±  6%  numa-vmstat.node0.nr_zone_active_anon
>       87951 ±  3%     -29.0%      62408 ± 12%  numa-vmstat.node0.nr_zone_inactive_anon
>     7554028 ±  3%     -71.2%    2174126 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
>     7640393 ±  3%     -70.5%    2254050 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
>     7291209 ±  3%     -73.6%    1926973 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
>      873.62 ±  7%     -19.2%     705.68 ± 10%  sched_debug.cfs_rq:/.runnable_avg.avg
>      790.32 ±  7%     -21.4%     621.34 ± 12%  sched_debug.cfs_rq:/.runnable_avg.min
>      747.11 ±  3%     -22.7%     577.37 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
>      670.92 ±  5%     -25.2%     501.70 ±  2%  sched_debug.cfs_rq:/.util_avg.min
>      409.44 ±  9%     -35.1%     265.80 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>      789.44 ±  3%     -20.1%     630.53 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.max
>        0.00 ± 13%     -67.3%       0.00 ± 22%  sched_debug.cpu.next_balance.stddev
>      872.67 ±  8%     -45.0%     479.83 ±  2%  proc-vmstat.nr_active_anon
>     1801345            -1.7%    1771330        proc-vmstat.nr_file_pages
>       95550           -24.6%      72037        proc-vmstat.nr_inactive_anon
>        8752            -3.7%       8426        proc-vmstat.nr_mapped
>       31169           -76.8%       7221 ±  2%  proc-vmstat.nr_shmem
>      872.67 ±  8%     -45.0%     479.83 ±  2%  proc-vmstat.nr_zone_active_anon
>       95550           -24.6%      72037        proc-vmstat.nr_zone_inactive_anon
>        9553 ± 10%     -16.8%       7950 ±  3%  proc-vmstat.numa_hint_faults
>    18886391            -3.6%   18207624        proc-vmstat.numa_hit
>    18770999            -3.6%   18091363        proc-vmstat.numa_local
>     7398756            -4.0%    7105675        proc-vmstat.pgactivate
>    18885154            -3.6%   18206666        proc-vmstat.pgalloc_normal
>     7248262            -4.3%    6933915 ±  2%  proc-vmstat.pgdeactivate
>    18894473            -3.4%   18243898        proc-vmstat.pgfree
>     7829962            -3.0%    7596447 ±  2%  proc-vmstat.pgrotated
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> #regzbot introduced: ca6dee6b79
> 
> 
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
