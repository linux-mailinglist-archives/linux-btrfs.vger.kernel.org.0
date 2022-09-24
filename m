Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042B35E8A80
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiIXJGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Sep 2022 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIXJF7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Sep 2022 05:05:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B79F2749
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Sep 2022 02:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d08OlgpKRCoSEwDpDkTe7ZH/h84kU7xupzUxgnUzyfXY9Ym+hJJc5YdpX/gNgZOiurZuwDggMoVgUEeapQpFvX8OG7c5Xgmxxz11GQWQV/cxVW80F5yt+4yCLnfeQhc4uDY9fuBdEBwNv4LU2r9053EoHE+Zjgq6P5U62or5YlmSZZJ3GvAvJhJY1+UHXwRnkoknDk/NJOtqGUI0BgTZHlAwSGpnCQSZ4F6sbHn815Sz9KTjLdubFOx2r3n7zlclzjYAnU96b+HbGjJ9VjX0yjsO4i+yI50zB8HrXMyQNB3b/tcnSzEH5cxBLFInoNTtaXPAX4WSavbitwcUvnr0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQwtxUhlq0ZvlMOSbLWbUmmJ68kbquAkBKtT7Kl3Yl8=;
 b=UTOpT1/MzFDVvkAD0c+opF8HsbBtp3KrL7F2erOcpkVSI8Y++GzV1d0DT9oAFtnAwVSX+KanFtXEqcefYyrafAfVVSeCC2RuI1s1tttDyVD1kFnmm2aQ6XNqCv0dZVAKWyiQaYAqhJc63PjozfRv7nH4K9IinUE/uBzQHuiFRu01glSPbXFHWmD4l5APAGcGmVC9LX9mOnOl2lkdusB+k/Y2TJJxWOgJmciYRNAeYFYTh6TN/JzZeWd6xSAPu4wZOvCzJln1c3j+VPOFJsH6L/odLau/h6JiGYbre3tn469/MYfN4Ze5qohC4FQeyBUcGkmdLdwI5Cg2pnBzBT/D5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=damenly.org; dmarc=pass action=none header.from=damenly.org;
 dkim=pass header.d=damenly.org; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=damenly.org;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB5805.apcprd02.prod.outlook.com (2603:1096:101:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Sat, 24 Sep
 2022 09:05:55 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::3d4a:1dd9:f59f:7e6]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::3d4a:1dd9:f59f:7e6%7]) with mapi id 15.20.5654.022; Sat, 24 Sep 2022
 09:05:54 +0000
References: <20220924120727.C245.409509F4@e16-tech.com>
 <a80263f7-9ff7-4f1b-d863-8d092cbb9a7a@gmx.com>
 <20220924144106.E3BE.409509F4@e16-tech.com>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Su Yue <l@damenly.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: fstests btrfs/042 triggle 'qgroup reserved space leaked'
Date:   Sat, 24 Sep 2022 17:02:11 +0800
In-reply-to: <20220924144106.E3BE.409509F4@e16-tech.com>
Message-ID: <v8pd2lch.fsf@damenly.org>
Content-Type: text/plain; format=flowed
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: d537bb43-5487-459c-8004-08da9e0bfc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FsyaAkwDrrerdLOJjWdzVE2WqIBMcY1vGQbGle4mLNT2CcBOT69vsKUmTL2F84HdUBnXtbwb4a6rFHm3KkfOTYU2X9mG46iK5C/TQveZcf3IYmhFF5JLDVhHxN7FArF1IK0gwdwEgyuxdHlxQ16kMHRshYUkknzcENoqlbUuENeaWyYjhsCFmR3rtFgUdcVf6+x37I+8BOBZsjcX526z58pVZSuverXY1/3CGqtBxDrL17X5w3uvog10ufCfuy3oNT6zw4v7j+RbIS5+4HZW7wUg/mPe/mdvBCTKNb27IazGuYSX+8IKk1bnkTz+f6kyj2ocxNlyVjKNH1UDR82flCa/vuYuAAHeNIjZNWfcyRRYEnwVy2bFAGpdwyO/9kNRf/4ds+lm8yAcbT92U1QmfTeMPznaPtNjCefukl/irbeAlJ94LmaM3y2VNzubgE8NrUhYf6dZJNRFlpLPC2stN4iY3lD7qQjkQyIsqS9ljCgXIx8PecrV4I2brIBIgbQnmpe9LINudypXcmVKYIVyHA7kxsnoe56kwa7IjfTP0/sGBzWs5VpuUk3j5qAmjaqCw32Zq0AZHbpZDla9f3edgkngbGHONxw0Uiy8VqqA5AkzLOI4CjD0nPhlIhEDFOvNygiPc8Tok6DMarlN+LD5aLn1/4xpU6kbGQQCxO5WgYGuphaFXiQraI0+Sk+4qRVGvkzyO71bAwKh1A9QOvT0Am/WxLvxzsC1NpSctApfstZPaeFGxDHBKCSBQcEu3IF6u2DSH/TsXc5lDuIDD7/0CXRYcFjEZdwtczCb5+O5GYDTG1HScn19XQc3zTyOnGr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(34036004)(346002)(136003)(366004)(39830400003)(396003)(451199015)(26005)(186003)(316002)(2906002)(4326008)(36756003)(83380400001)(66946007)(66476007)(38350700002)(66556008)(86362001)(41320700001)(8676002)(508600001)(966005)(38100700002)(6486002)(52116002)(6916009)(53546011)(6512007)(6666004)(8936002)(5660300002)(2616005)(6506007)(41300700001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UfXNe9fX1UAvG2fl+XYXiDdGwHbCtajeyQe5dRZPh/L9HD5cbXoNB1mps5gz?=
 =?us-ascii?Q?IAxFMbE97WQ5M0yRV5wF2XyQXxRUrEQEC6Ca8hnDINHKMzNmwYCxY9k39Gtm?=
 =?us-ascii?Q?9KPhiu3Zoqr3Z+nytjjp1CNNHNnCZK4d/Wz4jgQ4PEmEIAfFGVtIYz1WEy30?=
 =?us-ascii?Q?Nb2XN454PY1lRtIeKeV5PQemCtFL1iu+cahRmwBViXRK0IICkpLHA34P4puO?=
 =?us-ascii?Q?bCPaX8nK+AGfJVrS86hCneUmVx/h7Jopt0ifwCBaI2+aGAwYVBdgQhoEMDwA?=
 =?us-ascii?Q?WycXpVSC/MVw1jgRBa8lULcja/Sn+IW9iFbA3cHtGcb2wgAg8t8sufkjwiwx?=
 =?us-ascii?Q?zr+IWUA/ApzjasUL/WmjO0z82SqPs0WpzY88Y6NzlYCODSUjAUBC7veDgt3G?=
 =?us-ascii?Q?m31XQwSgtoWrL0Z/H7J3+vKRCKHFPpuN6P3DDsY2Ir4QZ2/1RcXwg+0oo3ae?=
 =?us-ascii?Q?8bj8iIOEoX2O+Diskm5oDlnLnkPV3xgdZQloHNQMn2LddQq/rCF/0Ct0elYe?=
 =?us-ascii?Q?OBm7xPrR3ajFuR3sA79hf9q52RYO50kSzlTvEFw0AeQogUGYaIgiFuTvQgZl?=
 =?us-ascii?Q?eYMSzjC78wiiteARWG5P+m92WLw1kpfn7wmeHhxmzeY7tByUpblyB4P7aKek?=
 =?us-ascii?Q?031cg3qJBZOmP0fmEYVZE5YzLLAAGfQ3Pqri9yDXUwLocBBT7zGRkHBwBQzB?=
 =?us-ascii?Q?EsJRuNsvrgvmPix7OuLuJgGYap1736UqMgvS50iWwFvGWfmGAm0t/F4XWj3W?=
 =?us-ascii?Q?BW/rv0ui3kNkKs1n6V/ZSBuNhFvWs1JR6augO+6FgE8Tjz25dbdf6r8h5SLY?=
 =?us-ascii?Q?3LijmEehGATzAj5cC6rcbXTFf2B4APrUSx8bVPJPjDz3Q5BtmborHm70m+jb?=
 =?us-ascii?Q?ztp+lX6zfJ7jtksVMNYFe0euNlT1v4qMjQsBgyYozQSWIsnfRsaWHCM3/grz?=
 =?us-ascii?Q?/NNJr4Bb6wR4w1RVfGdmUs8Wl7fksQ3DTnEHFOx2qj/3OGsOlLw0aQdytvCN?=
 =?us-ascii?Q?3JWsF1dJ/3zmMjaZrH7JtsVf5LCeMEY4Q4Ka7+yDX6+a0CSMJylXU0RKwb9c?=
 =?us-ascii?Q?7RNz8TP5lRoXJ4+WhTLHXaGCEEGSkwkBibBlQreqqB5Wq1OD/UuFX7el6A6/?=
 =?us-ascii?Q?A8q1rePUcTbiUz+nqR4OHkDqx5KVWKonpGXAv/20cO1M6DlNGuYItoeyGdJh?=
 =?us-ascii?Q?VevVyi4i+0EEmo9U7MB5wdJPe1QPaGm4W1XcQCa1qQpp58XQRwF1hQ8Pkxp8?=
 =?us-ascii?Q?TC/iHtlVk5eFIAIUiKH+tYUfagDzQB+0YwIFX8xJXIHa7rAV7/0D3gJ6EM55?=
 =?us-ascii?Q?eGTwxzu5erShP0bb+DlsnVn4/hAj7c3OvxghXmMcCo6f4g6fbsG5A/PY+BFI?=
 =?us-ascii?Q?vmrLXMK1CX5SXBWk5WpUh9nC9Skxhnu5qdCwxNluifTjvpAyk5WEnYE9tF/o?=
 =?us-ascii?Q?36Bx4ScJS3RRvdqDX1kfVivI0bQBb3NJu/f44ocJDsd25DJEmM2/Jj+1WOxC?=
 =?us-ascii?Q?gcROL2fLiwoCIKkWbzV+nBu/HQAANEhNu7FwyaqZ0mCac9BfjB+A6rfmGDUs?=
 =?us-ascii?Q?RBr3TYjfP9NKZJ//mQM=3D?=
X-OriginatorOrg: damenly.org
X-MS-Exchange-CrossTenant-Network-Message-Id: d537bb43-5487-459c-8004-08da9e0bfc90
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2022 09:05:54.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9b63ded7-95a0-4379-9afc-fbbce95c751b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1IXCTmaO7lULH/wKXAmJqCx4FLVjQebiJ8vXaQZE3jQluEZZtLtrnq7JVJbQRtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5805
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 24 Sep 2022 at 14:41, Wang Yugui <wangyugui@e16-tech.com> 
wrote:

> Hi,
>
>>
>> On 2022/9/24 12:07, Wang Yugui wrote:
>> > Hi,
>> >
>> >> On 2022/9/24 10:11, Wang Yugui wrote:
>> >>> Hi,
>> >>>
>> >>>>
>> >>>> On 2022/9/24 07:43, Wang Yugui wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> fstests btrfs/042 triggle 'qgroup reserved space leaked'
>> >>>>>
>> >>>>> kernel source: btrfs misc-next
>> >>>>
>> >>>> Which commit HEAD?
>> >>>>
>> >>>> As I can not reproduce using a somewhat older misc-next.
>> >>>>
>> >>>> The HEAD I'm on is 
>> >>>> 2d1aef6504bf8bdd7b6ca9fa4c0c5ab32f4da2a8 ("btrfs: stop 
>> >>>> tracking failed reads in the I/O tree").
>> >>>>
>> >>>> If it's a regression it can be much easier to pin down.
>> >>>>
>> >>>>> kernel config:
>> >>>>> 	memory debug: CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
>> >>>>> 	lock debug: CONFIG_PROVE_LOCKING/...
>> >>>>
>> >>>> And any reproducibility? 16 runs no reproduce.
>> >>>
>> >>> btrfs source version: misc-next: bf940dd88f48,
>> >>> 	plus some minor local patch(no qgroup related)
>> >>> kernel: 6.0-rc6
>> >>>
>> >>> reproduce rate:
>> >>> 1) 100%(3/3) when local debug config **1
>> >>> 2)  0% (0/3) when local release config
>> >>>
>> >>> **1:local debug config, about 100x slow than release config
>> >>> a) memory debug
>> >>> 	CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
>> >>> b) lockdep debug
>> >>> 	CONFIG_PROVE_LOCKING/...
>> >>> c) btrfs debug
>> >>> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
>> >>> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
>> >>> CONFIG_BTRFS_DEBUG=y
>> >>> CONFIG_BTRFS_ASSERT=y
>> >>> CONFIG_BTRFS_FS_REF_VERIFY=y
>> >>
>> >> I always run with all btrfs features enabled.
>> >>
>> >> So is the lockdep.
>> >>
>> >> KASAN is known to be slow, thus that is only enabled when 
>> >> there is suspision on memory corruption caused by some wild 
>> >> pointer.
>> >>
>> >>>
>> >>>
>> >>>   From source:
>> >>> fs/btrfs/disk-io.c:4668
>> >>>       if (btrfs_check_quota_leak(fs_info)) {
>> >>> L4668        WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> >>>           btrfs_err(fs_info, "qgroup reserved space 
>> >>>           leaked");
>> >>>       }
>> >>>
>> >>> This problem will triggle fstests btrfs/042 to failure only 
>> >>> when
>> >>> CONFIG_BTRFS_DEBUG=y ?
>> >>>
>> >>>
>> >>> maybe related issue:
>> >>> when lockdep debug is enabled, the following issue become 
>> >>> very easy to
>> >>> reproduce too.
>> >>> https://lore.kernel.org/linux-nfs/3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com/
>> >>> so there maybe some lockdep debug related , but not btrfs 
>> >>> related
>> >>> problem in kernel 6.0.
>> >>>
>> >>>
>> >>> more test(remove some minor local patch(no qgroup related)) 
>> >>> will be done,
>> >>> and then I will report the result.
>> >>
>> >> Better to provide the patches, as I just finished a 16 runs 
>> >> of btrfs/042, no reproduce.
>> >>
>> >> Thus I'm starting to suspect the off-tree patches.
>> >
>> > This problem happen on linux 6.0-rc6+ (master a63f2e7cb110, 
>> > without
>> > btrfs misc-next patch, without local off-tree patch)
>>
>> Same base, still nope.
>>
>> > so this problem is not related to the patches still in btrfs 
>> > misc-next.
>> >
>> > reproduce rate:
>> > 100%(3/3) when local debug config
>> > and the whole config file is attached.
>> >
>>
>> I don't think the config makes much difference, as the main 
>> difference
>> is in KASAN and KMEMLEAK, which should not impact the test 
>> result.
>>
>> And are you running just that test, or with the full auto 
>> group?
>
> For 6.0-rc6 with btrfs misc-next, I tried to run  full auto 
> group.
> btrfs/042 failed, others(btrfs/001 ~ btrfs/157) are OK, and then 
> I
> rebooted the test machine.
>
> for 6.0-rc6 without btrfs misc-next, I tested btrfs/042 and 
> btrfs/001 on
> the same machine.
>
May I ask if "6.0-rc6 without btrfs misc-next" is 6.0-rc6 *without 
any other changes*?
It looks so weird cause I can't reproduce the issue either.

--
Su
> then I tested 6.0-rc6 without btrfs misc-next on another 2 
> servers.
>
> reproduce rate:
> server1	3/3
> server2	2/3
> server3	3/3
> total rate: 8/9
>
> all 3 servers are in good status(ECC memory status and SSD 
> status).
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/24
