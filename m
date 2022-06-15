Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB6A54C164
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 07:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiFOFrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 01:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiFOFrh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 01:47:37 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20089.outbound.protection.outlook.com [40.107.2.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0F21B3
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3oSqk7x7nS+AoF7MrZabY5QJMyR72MaiRYtrQfTI7Z8ahVLfqxmZxFiItJhUnOkkdLZfE3RqcvIGyaKyy/+oxQnl4tFofMlkRW+GR/Sqq/MJGfaQXJ+z4PximiVEzlgCF9GfOgAYZoj+UjAiV2Y8Hyrfmp9et3dMyrhcK9319184ahZ1Ul5Of/mh/gqLHI9C7YOmTeyYewraWVfRlnOl23BvPJzMjVBwdm8iXcOAMFgxn1tK+JdSK2793HjO33yJQAfUxjKn639YIEqweRBiXjVBgDdYejz+T43FJAic3pgtWSBJMit99UTHHILBsLLezyCWL1PrqQOvmxiiwH19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrWdfqhm8Gzk/2yPa5Iy6v15RG1dnMnnbpXIHYq6ZXo=;
 b=Wc9SbOD0p774+bkPAb6zQUKq7yVLJNl1Uxr4GxecrZ7oCZDllHOfc36ziiuvzwU6vh0MaBGr7LlVWQAWGwcM5oxGB7b5euO3/fjIMRhtRrV2PbexgS6YMRDNQ07ASqt8PBacIv3CKp1+29sjE1mbXXkGlPkykGAEtF/ydzqiUZzLadAucDhV22GoYFUIDe2CG6vkONK3KSj5sTRqaMFXAv+5merFjcyWTaUBzMVi/zyiEk4XB5XA/NjSIUheUnPRBo4SVREO2cQ0oaP0fM+hYHwvayIZWYTdlWCE62OP/8v6YAAo6C55w78Spfy3S5jfQmHgcx83ro2SoozmUvgpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrWdfqhm8Gzk/2yPa5Iy6v15RG1dnMnnbpXIHYq6ZXo=;
 b=QKfcp2IX8L3rMVClHlfyMwBGJMgh04VmeIlYoI1hONFpvFcyUthN25y5ZO0i89PfjNl3ipmL4fV0j4031mAghjmUQMRjhMam3eZc2MQ9Bmu3h2iUBGSDNCjIC86ObACmteIVom0fXg7NE3mIsO6GQYu9z3CgTV0WZX2Vof18UEHbqmf4ORR6HZMUI/wnhCs8h4k1iDlWXOmqX5zrGdQliw+e+yE4GBsqJa9oneCC3QtSuhEAqZ6bwV2w4CNE1eYqB51N47jnuToO9RAaDMmBo88UMArA9GHBV3EiPLpAQECPYKDO7iVzTmJJo8rkqESEm8zNoMnx7/dbqneLga85BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Wed, 15 Jun
 2022 05:47:31 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::4dea:1a09:c0d9:8fc8]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::4dea:1a09:c0d9:8fc8%6]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 05:47:31 +0000
Message-ID: <aacc0112-1554-5c88-6f72-57669805392a@suse.com>
Date:   Wed, 15 Jun 2022 13:47:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: don't trust any cached sector in
 __raid56_parity_recover()
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com>
 <20220608094751.GA3603651@falcondesktop>
 <b4a9889a-2c9d-8f74-985b-f0b7b176a1fa@suse.com>
 <CAL3q7H6emgApw9saZ3k7Eb7PDx46=-nLKTRBcYvqXCQ3d=0BVQ@mail.gmail.com>
 <4919754e-045d-9061-27dd-dea61e9e4cef@gmx.com>
 <20220614140053.GL20633@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220614140053.GL20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:a03:54::47) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cbc5e6c-e9f0-43f2-c4ff-08da4e9289b2
X-MS-TrafficTypeDiagnostic: VI1PR04MB7072:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB70729B107BA5F85E58C744F5D6AD9@VI1PR04MB7072.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xL6c9mf6SchQ0H6gcgyTBgzlMkDI93S2QX9xc3ePxXsFmeZMp194uXnehfxUGk1HK7qPwFbjbejn/1mV5rME638UIuB2kV86bj/DB8mE5Bwr0a7jb5luF7hG47fnKXQG327qpkQeHChnHw+z1mBTQd03m7B5jf2yqBdumW5x8Ay4iBnjSCmGWHoXWGzaWJlGzfArdHdfDGiIy23mS9ZUaxCIHm4FtwrEC4TMviQbZTwh4mXwS844ZGM0lSm38PdZA0oCumnYpWZf7jd+Tvx10JbLDIj3RHk2Sib2NJLnq7+yYqaY5PoX0reQgLS1xXzr68TRsHoS8ny8czTRJ/sxTjDBPwQreeBNdnTZ1UcUw1z3A5K2p0VFPZK3B2E4gGRjIl0YhDRr7ypEtu/O4ppMZUy4n8RyfvWa6iJrRyD6IIruPdfK6r1YhrJilmT8fEIrhQ/WBWrnRDzACigXXljtsHTUhWNtDIeCf3+ZwaQxQWZq3pe85ub0DOQmNJSh1SvawM8OX6t8eoHMJeIuNfqR99nfmfF6hvK0ySlUD4tAqCky8I826PafMXsSe6D5DxU7f5ZUoJfqN1MuAWmplpobTEUkPhREkUlLP0YEJzr3JvnCw5w3g8WK8pby44WQ+Tz70KSqQqleEjS5vSy1ZcCdmAAL8qGWftSKQz8d1aObl8nmqrqABfkHTuaDjc2TWCdevJg9RxFPHYCQeb7H62/kvj8JDWNXREICIiwSl0y/pkAfBN5xKnpgq3MJ421iQM+k+jkIss8CRoj51GV3rRif1iPg1s07KZuJ02BWZ8dVC5b8aa5teOKE2QWRXS4isvFW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(2906002)(508600001)(86362001)(6506007)(83380400001)(5660300002)(966005)(6512007)(6486002)(31686004)(8676002)(8936002)(6666004)(38100700002)(66946007)(66476007)(66556008)(36756003)(31696002)(110136005)(316002)(2616005)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpORVQwSTV5SVcvV0NBQ0lkQTdwWnVuUDZRT3dRTjVqQWRjcXk5ZGtGVkNB?=
 =?utf-8?B?YlNTMHpoMEhCb2R2SWlvbiswaVNpbDJwNUFFWlZyMlpRRUxSbUc4a2szd1JN?=
 =?utf-8?B?dFo4UXFrMTBldGRwQXJZR0h0U1BCeTNGT1VhUGNEbEhuQ3kzdHdLVU9YbVBt?=
 =?utf-8?B?ZWNCMVBsMzZjUVhNR0Q3SGV2WUx2WGgzbWxDZmwvSDV2eUk3REwxYm1pSGln?=
 =?utf-8?B?dXJ1QXgwencyNEY1U3ZJTnpzU3M3Vkk0MjFpSDhoaHFOQmh0QVhHM29wVlEv?=
 =?utf-8?B?a1FxNEJEQnROVURXZ1RkU2tvUkpOeEhER0Uxb0J3R1ZJM3ExMnZXK2h3MVNT?=
 =?utf-8?B?TmpiT2pwQlZ5WGJuZ2w4aXFzY2VUZHRKVlI2ZHhyb1c1UjhlYU55Mk1lRHZi?=
 =?utf-8?B?Tk8wb00ycko1OXBSSTVodHY2dHdKRTFxb1V6TlZCNTBXSkdqTFRCeXhSUGxI?=
 =?utf-8?B?WDB1ZnpuUVBqS3BQN1p3VWJnaE1nV0FYcVc2NUNlc3hoenQrUFk3UTBtZ3Jh?=
 =?utf-8?B?Mk9ZeEM4cm51VFI2TUE4TnBaMFpDNWtoc1Y3NzlVcm5heVJyZ2dYUG8yZ05w?=
 =?utf-8?B?V3d4bVVTN3dkL1ZHUHRocTFmbnJVdDBWcVdNMXdPRDFsZXNMSGJpdDh1QlNN?=
 =?utf-8?B?ckNnQlFXaS9Ha01oSmd3elJRSXNubzJRc1plNkVUNjVnUzNVUTdzcDk1bHZL?=
 =?utf-8?B?NW9MVFg4T0xZdVI0c0ZTbVVWZVprZEgwSjNCM2FjRktIakZtWTdzRG1pcmZv?=
 =?utf-8?B?WWJORG0vSzFKc1FWUjBFd01WUElhNlEwbTZVUGRNUlVkQlZYdmNGZlVoVm8y?=
 =?utf-8?B?aXZLZmJaTEs4ODFpS0tjbHV3NWZFanVMTno0VDhTblNrQm9sRzdocWpLMzhS?=
 =?utf-8?B?VGt4cSt1V0ZXRHpQMFFSMTF3UlZLakNaQVBPcUYzalFXT281Y09FNEh1Vlpp?=
 =?utf-8?B?c0VOOFdHSGxzbEhjWXMyQ3h1WmMrRnhpY1VKYWxTSDl6dHduUG9kdlZpaG40?=
 =?utf-8?B?NkdCbnZvRFBmcXQ1K0JYZ21VM0FCTHhnaTA5SmVDZW9NNHpmcGpLTm5RNjd2?=
 =?utf-8?B?a09JMmxqbEpWb2hNcnFLWExFd01YN3NnUng2VkdzMllmUG1BNWpjbUlxbXBu?=
 =?utf-8?B?UmF6RTBhd0hFb3kvdEw4eFBPVk9rOW1xKzV0elE0Q2R2RCs4L0lxbmpQKy9T?=
 =?utf-8?B?aVczTXZRdVRZdm50bXJNUCtaUGNhUCtBVmU1SHlnQUlSYTZSVFQ5QlVNWjd2?=
 =?utf-8?B?RnFRa0QxQ1dhaXkwQXp4U1RhU3lZV2o1MTUyUG1RSjNOMWtmTndaWUI2Wm1h?=
 =?utf-8?B?elNvS3FiL2cxTFVSZ3ZVdHBaMjNpQ3l4bGRzSUFwYS81citZblpuUk1pL21o?=
 =?utf-8?B?Ryt6RFd4bm50RUFCNlg0REdqNmJRVERRZnZ6SVEvMEJmRXF5ZVJOWkxvRGhw?=
 =?utf-8?B?NG9tNXBteEorYlh5QXBwczdGSXZrSjZVSVB2WlJJTlh2VXlwL1psTFBvRlQz?=
 =?utf-8?B?VWNySWp5U3dnMkcvYnNCT1dmL1R2YXdFOWFhQkx3TkU4TjZGSDNUbTBhQjdK?=
 =?utf-8?B?NnlLQitnUDJlMVlxZlB5Ty9ldldPR083Zlk1akYycHlOREtXeEVnRGpSMWZ6?=
 =?utf-8?B?YVhjakNEQW5xMmREcWFuZm1ES2VwMFVmdHdwWEVRWlJPRzhYejNOdDVGc1dt?=
 =?utf-8?B?R0tNYUVmZlVoMmtHMGoxSjNuUGQ1QURmcWxwaFl5Q3Zxd0tUMGNVTE9uNi9D?=
 =?utf-8?B?NGtlcXNvdXVTUjhVcFF4L1RFR1I4dk9hNFZheWUyZ1U5Y3U1N3dHSmtSemFH?=
 =?utf-8?B?TDViYkxLVkEyQmo5cVZwekZoemx0RFJ1ekRNd3NWMmttcGxzbXlwd2JYam0y?=
 =?utf-8?B?S204YnFPckpkSWt4OHVVTnZJb0t4a2xGUG1MWWRUVXFGNTdVazUzOGJhQnc3?=
 =?utf-8?B?aXBtaFd3ay9kTlN1RDVybVV4NGZBTkZkK1ZHaUpSNmxGM0U5dU1VYllqN0Ew?=
 =?utf-8?B?bUpIU0xYQ3plRHRPNXhlR1F0VHg0VWpRZkxuaTNJQ0F3eHF5UjVYQ1BpMjd4?=
 =?utf-8?B?Y1poN3hoZllOUkFZcUZyWU9YT2lZMnFkcWtBc2pJWVNUUUdDdkg3dmNFUkdE?=
 =?utf-8?B?Y2VRY3RVTjlJMExqRjBORG9UNHFiSXYzZXA5NlF2YnNIVnRBbEFBMHBWRWlF?=
 =?utf-8?B?WFNVUnlrZHloaTYranRHZENTUmcrRWpCUkZVZnVhcy80eURtSGl6L2o4UzdV?=
 =?utf-8?B?TVFLaXZmQXR5ZU9NaWZTOGtpbTZYQTAvemc1UzlZZ2trTzY4WWRJU2RqbENM?=
 =?utf-8?B?akNtNlR4VFg3b0R0K0pReXVkY2RlVXdUMHZHTjVYOThJbEJwSytKUC9nMnVV?=
 =?utf-8?Q?VAs84V55C6kObaapaLBsg9F/jd0YcLzklPl1q?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbc5e6c-e9f0-43f2-c4ff-08da4e9289b2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 05:47:31.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN+jPn2NZD2q4S0nLF3Lyhm1/SUYFgN2RGydpPE5g34WRT2BVOsyvsXJch98tHPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/14 22:00, David Sterba wrote:
> On Thu, Jun 09, 2022 at 05:54:31AM +0800, Qu Wenruo wrote:
>>>>       incidentally make it possible.
>>>>
>>>>       But later patch "btrfs: update stripe_sectors::uptodate in
>>>>       steal_rbio" will revert it.
>>>>
>>>> 2) No full P/Q stripe write for partial write
>>>>       This is done by patch "btrfs: only write the sectors in the vertical
>>>>       stripe which has data stripes".
>>>>
>>>>
>>>> So in misc-next tree, the window is super small, just between patch
>>>> "btrfs: only write the sectors in the vertical stripe which has data
>>>> stripes" and "btrfs: update stripe_sectors::uptodate in steal_rbio".
>>>>
>>>> Which there is only one commit between them.
>>>>
>>>> To properly test that case, I have uploaded my branch for testing:
>>>> https://github.com/adam900710/linux/tree/testing
>>>
>>> With that branch, it seems to work, it ran 108 times here and it never failed.
>>> So only the changelog needs to be updated to mention all the patches that
>>> are needed.
>>
>> And a new problem is, would I need to push all of those patches to
>> stable kernels?
>> Especially there is a patch that doesn't make sense for stable (part of
>> subpage support for RAID56)
> 
> If a fix makes sense for an older stable but the code diverges too much,
> it should be OK to do a special version as long as it's reasonable
> (size or what code is touched). Also it does not need to be for all
> stable kernels, if it's eg. 5.15 or 5.10 that's IMO good enough.

Considering the test case btrfs/125 is one of the most easily triggered 
destructive RMW, even we can not yet fully solve it, it's still way 
better to reduce the possible corruption caused by unnecessary RMW.

I'd like to backport the involved patches (all mentioned in the v2 
patch) to all stable kernels, as I'm pretty sure there are still BTRFS 
raid56 users, mostly due to cost reasons.

Thanks,
Qu
