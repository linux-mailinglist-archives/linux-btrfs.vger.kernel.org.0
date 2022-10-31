Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00761613150
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 08:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJaHkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJaHkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 03:40:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4695224
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 00:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Drn0iCz6WjN4SNWWu2A4Xgc4XuVhllPF4bmVbYtj9GxfMtuVKQWBBLnKK5X4naopdo7/zWK4N4eJto5w+x41KQGuwMFk1aLi45TugWhttVPvodpyYg9rvdTMpcDQnQn773HQKuNrW4DGpr5Hq+H8laVZ6kLcDJSDLQiEclJ1mjOk081GTXCAVcMI9InoUVyjUmqT5CMx7VRfXr5+2vyfzG6vO8VOxFnuOKOrV3Zk9jB/aQS6kBDJa0hFJrBwlFvk2vB1a6obg9sH2WvnNyAJNs1HBeT7rgFmaRz93Myi8FAPXmHEMSdNr2CM8AQaISY6q6eVikxQXuM+9bXQqp1EZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rok6qCczH5IBDuZ+Rmj3h2ivaS8GLntWUtWklCD7J4=;
 b=DRw3nuds73I8Ymm+HN+DXbDKvhdSzJSLRmEy9B/H5SQ6cbnSufm4bbjW8kFo4giDGZ231bvQKoRjUQ5DuJmUTOuH+PgKskeMplsHjg89dkr3PyWkTy0ljjqPuAQZ38Xtadj3E7+maV2v7WqedbrwfXIfnu30H6xZ/8qGGBseqQr7nnN+mHNo2NdLMPOAfYxK54XjJFvrXeQ8nP7L2fi84aWNwu1amg7MidGjjN++mV9ChunDOLCaWRIpEQOmr2tRnUgWDY0j9XYAxtWg2z98zy985XSESL9VDhbtXUtM4X5sQ30mbhrutAAIajyuZ4ZBPlgxNSGt22rH4RSuxGJWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rok6qCczH5IBDuZ+Rmj3h2ivaS8GLntWUtWklCD7J4=;
 b=DO9h4uOqqmrl9iE97ZygeiR8Iptpb7Nva/Gt75K5iujy4YTEtyT6/raWJT4UkdCtKOtPENcoCvjPb9NRZuuvtGBKjrVilXDcBtd+hxYwE7RERR1sGOMrK0fphDowqx8KUWue2AJ7DCV2u2FL8jZiZ/b0Ti4wUBw1U2OV3sq6c+jZHTVcG0Se6LefN74rqTyrzNUpwPH6xLW+aRWnx2mtmNfvEm18mDfeD6tpGJTfBTHTvh7TBUqasrSw/lUWSEMTnxOnnuqd6IWs95NWrwS0fkjx/2sOb+YlLZmsgUbDZBQZ10z9OW+gS5Ncg1tIZpS8M8qyfCu2p0vWhEk3ywbJWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8298.eurprd04.prod.outlook.com (2603:10a6:10:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Mon, 31 Oct
 2022 07:40:02 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 07:40:02 +0000
Message-ID: <8408a2f8-fc33-7465-49de-bb2c6b26fdb7@suse.com>
Date:   Mon, 31 Oct 2022 15:39:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/8] btrfs: raid56: use submit-and-wait method to handle
 raid56 writes
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1666760699.git.wqu@suse.com>
In-Reply-To: <cover.1666760699.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cbaf67-cebb-4e93-499c-08dabb131e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THqElkgauFJXQgrxbp8mCsMM6Z/+OPlIQPkFOvJB2ppOl/as7ZeBFP7OQ0j9AWgSliYfqI5f/SDgrdcxmBuS5te1QITxBfbfapGquE8RfiayqoY4ChY9+2itOkdvUV5x+C53V1K2qdKyV9acDM0/vacyQuKc3M6bh3OY4GQh7yHid8IWaCC4efTzmMErYuu8eNyFWgfQ7zEJmoXk3+ZEaIrfMFuq4fFQSz1nR4ouIYQ1YI8PYzbdLsdLyauyS+r33MGelu/ybLR9pZlAZtqqkFXOxU7s/Pw64ZZf0Hg09tuRjSSScSEA5dw/LNsup2dhbNDUsELBiE9DG4OaaD8ga14H6eTLVvuBbewE+y0AETbzRQDfurBV4zK0msYf0u/4AgQFDQT6jfjTpbiO2b+O7V9kT1r60HngdrmiDpiOqOeXUxjgNTtLSer79Y+iokk63xXhmdQUjZ2BoEtttqNWovd1Yk+FMVOAT0bVUYXdtZfINvS76IMvAzKO6VAUD+f+llobFzNb1wenc4uw5ZRohZrabVqCi+1HmElOm1dgz4vqueE1QcXfp3vu2qaTCqCYsIEP0MSgDDm7zKXm3wRz+c5xjG6161eMPhONIKQ0tBq8wdcCNBdGG/zrsU6IGaH70K2HxKlXXtNQQwQ5SrqbX1d9Kpx9UPfOFT+2lQrC+bykhyZUBTYMpc98pBXisP2N/K8Tti58kezLkgYCEQauPXvhqk7WzY9PoO1F587EehddbdQ4pgzEATj6BrXkDpb+IHsREMHEmB6a4V09jBQPsOGwQj5FXVYyzgOpvUg84xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(6916009)(316002)(53546011)(6506007)(6666004)(2616005)(6512007)(478600001)(6486002)(36756003)(8936002)(41300700001)(8676002)(66556008)(66476007)(66946007)(2906002)(5660300002)(38100700002)(31696002)(86362001)(31686004)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akg4d0lhTVY0YVJLRHRCZ1ZHZkNXRlExaXNqY2RHd3d2cUFhT2g5K21yWTBG?=
 =?utf-8?B?Y0FBYmVDRW53akJOa2tsUDF3V0dMWEtqVUlPRVBJTFBrVlJBdEFrOXhKYkhS?=
 =?utf-8?B?aityakgwZ1ZoWlpOTGZIRE9PYmlzMXNrZXpvWlRMeUxUQ00xcExzODVGRHI3?=
 =?utf-8?B?SlBZWUQ5QzVyZm1hbU1nOXBKS3dvWW1aSEhLNjVWa1R4TUEzbHB5Uzk4UFlw?=
 =?utf-8?B?R1RISkFhYWIrWkYra2F3Q052dkZaNE4vZUMzTHlxbUlPZjZjYWVyZG5RUUFj?=
 =?utf-8?B?WjhnbTJyS09BQzVwZzNJZCtFSDgzRFI0aFROVCtQenBNZmFxM21tMFFRb2M3?=
 =?utf-8?B?SkFjNXV0eHQzMHZVWVlkNVhiSmhpVzRndndmQlJxSlZyVWVYQTNINlhlRGVZ?=
 =?utf-8?B?NUExZjJTVDd2V3M3T3dxZEZHRTdZTnZFVGdmR1pjYyt2cUJhd1pLcy83cFBG?=
 =?utf-8?B?eDZmdzAvT0hSMWhNMHlDbm1WNFZiSUVOeU1sLzJ5SnB6ejA5RWRuM1M1QnBK?=
 =?utf-8?B?cnpQV081WjlYSjk5dngvMVRrQVFZTUdDcUxjcTlPczVjRmo4VnV2TjFFK1Q5?=
 =?utf-8?B?RVhLREZaU1pKdm1PQlVQdndZdHRTTzNkdWhmQWd0UnFjQi94bVdtMXFGeTNJ?=
 =?utf-8?B?VzlOSzBMR202Z0tZVGlabjZXMkFwQWxxZkhtTG9HZERFcGhvUUhldElYajhJ?=
 =?utf-8?B?UXZUOGJXajhDeTNST2E4eDdvSk1QSGNHYU1CVUFsSnR6TWp4VjhoL1E0cXdp?=
 =?utf-8?B?bTVsREs0bG00SU9GaFN2ei9HZDVIWENnR05SSXJFN0xqZ0JmYnNkZ1lZcWpm?=
 =?utf-8?B?R1JGeE1RQTJDZnZtL2I3SHdjRzlwVXE4QWl6QnZLbEloaktCa09CemFIaEVp?=
 =?utf-8?B?QUliTjM2OVpWeDNLN2FWa01Xdk9aTW14UEJ5TnlIdjU3amR3dHZvV2tEQ1pN?=
 =?utf-8?B?akJkZ0k2M3BqUXlGSDlXV1pxV1d3WUw2Z1lxN1MvTXZwazZEZVJwVE4zN3Zw?=
 =?utf-8?B?R0g3VFl6azNBVEtKRDhqQ0dxRTFCb0MvakROTU55WE4rMkxVNFR3NU96djVl?=
 =?utf-8?B?WTA2MWZweDFjK1diU0xPczVaN3ZJMFNXQ3ZEQkQ3UnBWeXBOVWF0b0F0eEw2?=
 =?utf-8?B?RHA1cE1tSWlUVDl1bTBUR25uQ1NNREFiVnI3aTBPNWNRNmFLSklxRENoQVBk?=
 =?utf-8?B?T2xpeTVuUlVoMk9MWXlaeFFXeE5GM3FhZzhlaDhGcDlZaEZPVFhxZnEreE96?=
 =?utf-8?B?QzIyaDRRMjkwbU5OY1MvTzFTMWcwVVFyN2ZTcXFjRkI2ZjNiYy9OWE9odVVR?=
 =?utf-8?B?YzUyUkdHY1Y2ZmkrVFBXNjdIeml1RkRSeVVkNjZwVEtaSlFxOHZEaGlydTFo?=
 =?utf-8?B?M1ZtN25CZjFPdGh2V3Z3OUZlMkJORFNTYkJ6b3h6Qll3SldVVVNGVVIvdllZ?=
 =?utf-8?B?K0NuVE8vMXlaeTZtOXpWSE4yOXhaM1RSWnRPT2I5cUdNZzJObE5NeEdtdlc1?=
 =?utf-8?B?dFF1RVVJYUNoRlVqTC9rZlZTV2M0NWIrYXhNczJXd0JMc2hxZUdOUlYwV0d1?=
 =?utf-8?B?VmIrWURjbEhpR0llTDUyVlhZMTZGbzM3NzNRcjBVQ284MnM2MGtLeHN4VEpi?=
 =?utf-8?B?cnBpU0JHRzdSYjlpWlNaWktDWVExdmVzQUJmTEd4V29aL2FFVzdUNEpaVitH?=
 =?utf-8?B?dGVEYmJGMyt2K0FlOGQ0Y2NHL2hpbGNHQlNhYmc0SWczSUkwTUlpR2xJOFFI?=
 =?utf-8?B?dFZEY3FrOHNmaGVIdURiYm9WWnJRa0dXNEkwaXZiNVpvL0YyTVI4eGJKSjNx?=
 =?utf-8?B?QUVFYm55a2NscVNNMVVlM0lnZFY4V29Gcnp0cnQrUURCK1lzRnpiTjlBVWpx?=
 =?utf-8?B?UkI2RUlOZ1dTRkUxUWVNSDhmalNLYURTSExUblZTTGlocGhqdjBuZS9iSW5k?=
 =?utf-8?B?R0ZqajdjZnJLLzYvMlYxeWlEVkZVeUFNNkR1cVp0MHlTTjUwVDA0ckZLTlRI?=
 =?utf-8?B?QlorRUdhVGM4YlFMdVc0YkxCblBLMVczMzFDVi9uOEE3YkdPMUZiMUFBMXY4?=
 =?utf-8?B?WnNvVjR3c0p4eXZGeWc3SHBVOWg4Y3lFUXcxU2Q3TkVPR0dFWmFsZGRKdkgr?=
 =?utf-8?B?TDNxYnF6c1VhU1oyUnE1WXlnd3owYncwT0JvdjRWd0l3T1ArTUUrY25RRnhB?=
 =?utf-8?Q?juNO91NqgXHY5pE8pMLqzo8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cbaf67-cebb-4e93-499c-08dabb131e90
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 07:40:02.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKfpD05i8BzmkqOfc1c9xq/ycaQ0yW3lXvcPdsSN9wcx6U4hgXcVAnnTBr9pHZ25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8298
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/26 13:06, Qu Wenruo wrote:
> Currently btrfs raid56 is have many and very chaotic function entrances:
> 
> - full_stripe_write()
>    For full stripe write, will try to lock the full stripe and then do
>    the write.
> 
> - finish_rmw()
>    For rbio which holds the full stripe lock, only do the writes, for
>    either full stripe write, or sub-stripe write with cached rbio.
> 
> - raid56_rmw_stripe()
>    For sub-stripe write which owns the full stripe lock.
> 
> Furthermore we are using endio functions to go the next stage of the
> work, it's really hard to properly follow the workflow.

The patchset can be used for testing, but there will be some updates 
mostly related to cosmetic changes (function names, comments) and 
further expansion to cover recovery and scrub.

Thus please don't merge it as is for now.

Thanks,
Qu

> 
> 
> The truth is, full-stripe is just a subset of a full RMW cycle, there
> really not that much difference to treat full-stripe that differently
> (except skip the plug).
> 
> 
> This patchset will rework the raid56 write path (recover and scrub path
> is not touched yet) by:
> 
> - Introduce a main function for raid56 writes
>    The main function will be called run_one_write_rbio(), and it always
>    executed in rmw_worker workqueue.
> 
> - Unified handling for all writes (full/sub-stripe, cached/non-cached,
>    degraded or not)
>    For full stripe write, it skips the read, and go into write part
>    directly.
> 
>    For sub-stripe write, we will try to read the missing sectors first,
>    and wait for it (we may not read anything if it's cached).
> 
>    Then check if we have some missing devices for the above read.
>    If so, do recovery first.
> 
>    Finally we have everything needed, can submit the write bios, and wait
>    for the write to finish.
> 
> - No more need for end_io_work
>    Since we don't rely on endio functions to jump to the next step.
> 
>    Unfortunately rbio::end_io_work can only be removed when recovery
>    and scrub path are also migrated to the new single main thread way.
> 
> By this, we have unified entrance for all raid56 writes, and no extra
> jumping/workqueue mess to interrupt the workflow.
> 
> This would make later destructive RMW fix much easier to add, as the
> timing of each step in RMW cycle should be very easy to grasp.
> 
> Thus I hope this series can be merged before the previous RFC series of
> destructive RMW fix.
> 
> 
> Qu Wenruo (8):
>    btrfs: raid56: extract the vertical stripe recovery code into
>      recover_vertical()
>    btrfs: raid56: extract the pq generation code into a helper
>    btrfs: raid56: introduce a new framework for RAID56 writes
>    btrfs: raid56: implement the read part for run_one_write_rbio()
>    btrfs: raid56: implement the degraded write for run_one_write_rbio()
>    btrfs: raid56: implement the write submission part for
>      run_one_write_bio()
>    btrfs: raid56: implement raid56_parity_write_v2()
>    btrfs: raid56: switch to the new run_one_write_rbio()
> 
>   fs/btrfs/raid56.c | 1199 +++++++++++++++++++++++++++------------------
>   fs/btrfs/raid56.h |    4 +
>   2 files changed, 727 insertions(+), 476 deletions(-)
> 
