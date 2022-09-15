Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195375B96EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIOJDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIOJDd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:03:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF798773
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9woOoR8c9/7ZL6UXB8U4OXNKd4oZVjfWuDDPdcje4DofxgiVFQ2ICHLJwjfL/ZzPIOsYvMxV+g1kGLMSiLM4Xhl9q9T/dOPRV+Zdk1p9lwoa9nO29ybODK+KjDZpNS+F2w+KgLwNiO68bDt1XrKVDCC/ylMmzMsUfPpUIuO4BVl0+UvuVjedYxjDaCh3SJFlAygOdCRsiK9M8HYgUKuCRCd0ybTJZozzGCGz4mYLLa9uPEyqZ+r4OS6X2MFKgQ6unKPE0ne+3c8EWDCioMkP89jRS9Oth0gZY34jetAgrBqOBULneY4ONuihPO1AFt+dcY3ZsOuyuqozGs3aELWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fblLHhHiFMiTGOdbaWm8cUIwevK2eFG2GZEXeLumKUQ=;
 b=m1jx2cyU2evYzjcJoZcqcfjYPijhSZruSPBVpFkFnI2Qhxng9lOusW5VpS2mnSrTX4Hwlgo8d74sXJtKzxuGEkUwMqNBNZcmcRi/P/kZYduoVALag70BalV/oeTlFQRF9U3FzI2YEURnL6LZbW65Xi8Ak0n64qjeihWjLhPTcYi4ikUkYmlKKOcrJMzjAgS7Wl+t5nFw+no9q/QZuV7URsihSIT2Rk7YExFVsf1YYU0rOwoZNNNOpzfhAjw0K1vR+RPLcs6/U2/raHcqSxa08/qMLztpG9yG8UAg7ZuMhbBDSN9OePVS9mWVPLTq5HJy9J+jGqx0zkIjg6ELDBQObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fblLHhHiFMiTGOdbaWm8cUIwevK2eFG2GZEXeLumKUQ=;
 b=gs1WU6C/nGyeqw5TcQdJmW64U1M2iFLqWJtvSVYt0nw3+2effu1l54cNMV3roELhy+7nCd5ObXpZqEpJznqSvHLfvCdkSlZesEaIbh9h3TaollKiY43rE2uInLQTYKQCtH5j47l+oVQiyr9A0RTDRl8NhRhJDZSQDKE1+a5G/5+XSOdhu3wO1h9yYVSm8hwzrbgHcT1MkVUSuUkB9brXRVh2ygPfXO1XCRgj8hjP3P/xzD89H/9wUoBUd9hBKPzQ0xTMh0c4jBa+/6nGH2Tyqabq5zYp57T+LPXmJzfzfrKgMa5D45aNhX93ihd1SzHk6xbmEP1J3EY2xI6MYIR5mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:03:24 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:03:24 +0000
Message-ID: <619b97f5-4fec-4712-a7ad-b34f0456ef23@suse.com>
Date:   Thu, 15 Sep 2022 17:03:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 02/17] btrfs: remove BTRFS_TOTAL_BYTES_PINNED_BATCH
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <e17fc6ac382df50bdc88a688274ac98dccd3144e.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <e17fc6ac382df50bdc88a688274ac98dccd3144e.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:408:ec::34) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 120574ea-5df0-41f6-9873-08da96f9253e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04hnLD0ij6CITp+obEY9hjZ6iOkt8jkHXc2T6q98kqdaDkcKMHi6ouWIvUfkeIy/ORfBE0zCHQBeoXhzfi6I07W+MLIOCEBYV39seRqLrZf9yOBnlGBkTyFfvV46yzSHRmWIwAjq+fnhaxRheMMBUPfEi59SXi37UtpAK2r1ihemxkZyPsPGscXseJb6FXvPbCpzew/FTATGJTKLqaiA70SUScA+5w/ByK/8GHNQn6edvNuWKXNB5VqWf0eaFyj/v9ocBEBU78ngiZVYkVLOTjitBT4mvqN51TcY95qZc98ASMc9nFIjpdz2r5PdEWOb/HaODlQZeY2Oo6NVwRLnInC2fuIolzyzAyyuQaVcMIIXwR3u7QgBwQQxTDJ4++Yc1izKkth5moR3ZfqXYJJKFM0tChpeuFaZP2T5ypMBP6hevzZsABEnHIaZxbZG7tEYzJd5HT2p5zsFb9pMuA+BsKOtdNrsR7On4+7BbnO3xGwncGO2WeiKde1ugQPxOvCdQPTpC6t/SywVcSHahbQanh0y5G6NEUsanFe+R7+wIO/UdTb2CDHlC7mcPrJbLryw1LS/S2jsTL8qshqYXnZHibi4JTnKQjIU+HKedgKDiY5jD2keHg5BuRxEcpEYMKh+zsC1yi1v26oO1WbQNkTZEVeqUgL4niICBeQkaxot5OY5ph0Jyt/nHoQgF2wD7T9jjKWM/2QB49GS5tjR9B6MPsssUQRc4mn+wdmO7U3+sMRI7hXlJMF9ivpn/Z0XUbUC/PyxQjkBf4TXwT7LIPcxMHTSPY/QcRNHmlq5TmTrWKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(6512007)(6666004)(6506007)(53546011)(41300700001)(31686004)(36756003)(38100700002)(8676002)(66476007)(66946007)(66556008)(86362001)(31696002)(2616005)(478600001)(83380400001)(186003)(6486002)(316002)(8936002)(5660300002)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmR5V2pmb1VvQ25mdlRVR2ZVOEdBTHdTYVlmNThmeXdFa2o3eGxGVmw3Q2Yw?=
 =?utf-8?B?WVVZaGpCaGdUY1JESTJOWUx3RlV6ZU1Sa1lsUXQwTEFMMDVXMFljcEVsQ1FR?=
 =?utf-8?B?eWdEeXBmVVloNmtpTGl3RExhb2dUUGFwdmNrSE1sbXovR3BtdHcxKzJSVm0x?=
 =?utf-8?B?NTRyUjAxTWNuZmpNb1l4ZnRWcWdvQlZNZUVpa0NqenBodXVUM2g1b1NnRTh0?=
 =?utf-8?B?Uy8xbmtQcVliZ1YvSEI4K0ZaaXpQVWlSdjBKSHpOK3dTQXBCOHBxOU1GM3N6?=
 =?utf-8?B?eTA4ckRKb0NndCtwcXVoZWFHQnRrZzg0VkFsWTFTNkg1YmtSVGFnUSt3SkU3?=
 =?utf-8?B?MitabWpKMkEzT1NncjFNN3pNTU9hZkFhR2NMelp3RVVQQUpCWHlzVjdqV1pW?=
 =?utf-8?B?eDY0WitPNzg1NEY0Q3h4eGo0QmVKMUFrbDdxb0M1UHVjeTRuazh1cll3VURV?=
 =?utf-8?B?ODJQdFpGVkJGY210VDdBa2picWVQYnBjMFJuVnpMNFAwTW1vcHJyb2toOXZs?=
 =?utf-8?B?OCtva1I1ZStRMEx5SVA4ejRneitqeXF1K3NYb29rclY4WmxRZUkwSk5wWVJ6?=
 =?utf-8?B?VGN1UzlmUjBwV1VYVjlTTC9ReU9vZG5LMTZIWE9mUzNXWmpndkl4MHVxbUN6?=
 =?utf-8?B?V3F2QWk3NTBEbGhTOFFuNG5iWHhFZjZxZVVPYzJXTDdyWG5sQ0EyQXg3NnRO?=
 =?utf-8?B?Z0FyU3BPemlUaDZtcWZzdFg5YmE4VEp0RHMxMm1FL05mckg2MTFtVkRrVGM5?=
 =?utf-8?B?TnlJd3lCZElxWTdzM1NyWHdBU0RrWUVrMkVuaFRSTTRwVlhYVUdoditXbUxG?=
 =?utf-8?B?Q01OYnBNUWxNbkVybndMWkFmcEJ5eXFEd0dLcWlaUGFKblFuNTJ1Z3N4NFg1?=
 =?utf-8?B?K0pMbHhUeDlOTUZ2ODdMUTYrbVhjVWVxSmcrL1V3K2lFVm54QisxbkMxaTNR?=
 =?utf-8?B?ejY0M3lMS3dlZHM1UVI0Tkg3WFllSzB6dWJ4YjlnTmhCZVBtaDNMbFI4Q2Rj?=
 =?utf-8?B?T3RrU2hPZjUyc29waGdnQnBXcFJVcHNjK1VUcHZkdVAzcFNSYTBRTTg4dmtv?=
 =?utf-8?B?a2RVOHdhekhGTUxoS2kySjNyenBndThsS1IybFNVcUhTQW53REdMVHFqaWcz?=
 =?utf-8?B?eDBPU3hIelQrTDdmZ2EwazlPam1aZGpUQnJULzBtZndhUjdjK2JldWxDSTN1?=
 =?utf-8?B?a1MwcDV4QmJPLzRnN0s0Wm5jdUJtTlJwVVl4VVVyajJpci9nM0twb3BCSXJH?=
 =?utf-8?B?aktPWW01MGNaRENUd0t6dmhMSWtseFRDYWJscm1FdHBOcE9ONTZobVhUMG5h?=
 =?utf-8?B?UmdFem9ncmxUeXFmZDkwc1ZRclRLb1U4TTg5MFJ6aXVzR0ZGRDVuRy8vYStk?=
 =?utf-8?B?cUhUYjAvV3VMSWhnTEx6K2pMMy8wdTM2K3RoRGpxOVU4aEtRUk5JZm40TFZN?=
 =?utf-8?B?cjRscXo4VzZFNFZCY0FsVE1MTUs3V1d0a2R6WElaaTZyOFlTZCt4cldPYkx2?=
 =?utf-8?B?eEI5aDllRGFJVzZhRjBseGZ3UUVLNk1ZNU1pcHJOd1czamsrNktQMklOODVM?=
 =?utf-8?B?TkdlaGJ0RkszTjhKakYyZ3VCaVQ0a3c4aklsakJlZno2YTVoOFVSam5rTVNk?=
 =?utf-8?B?Vnk2V1VIMThuQVkrcU5zQzQzUTd2WG41ZFpnSE8rZFJ0Y3dmMEtSV3JSWk9j?=
 =?utf-8?B?U3ZPb2tjUFlNUEpDazh3MWR0WmxsL1pBZ1Ruem5tbmMwZDVEdFpKRFpRTTI1?=
 =?utf-8?B?VURrVnUvd3ZndEFzK0lkWmlkU3N6ZW1mNFc4T1VGK2JVSmE1U2xSM2d6djhO?=
 =?utf-8?B?bitqSm9OWEdwRytxcUVCZVB2RktTV1VaR1M1OEU3MCt3bnJyMC9Ud0hVK0FF?=
 =?utf-8?B?bFljRDFycmo0NlF0cVZYZUlZcys0Z2NXMU1kQjhPaVdodDkwN2VNT3Z3Y3ly?=
 =?utf-8?B?Tlp3d08zQzcydS9OYmRXNDlxVlZtNS8vamJLZDcvWENXMVBXbHJIUXdlRWkw?=
 =?utf-8?B?cmlBNlEvVWcyTFdlbDFBTk5jYjF0ZzlLWXd2M0tITGw3UGFYbzNZckV2cmNJ?=
 =?utf-8?B?RU54Qm5xbVhKR012ZDZsdzRXVk1jQ3RjVy9RWkRLbTVocGxhYUozUlBIa2JE?=
 =?utf-8?B?SlBGZTRxSEgwOGo1YkkrTlB2djUrU3pwcDV6RmQwdnBHMDJvWk5ycmhtcG9h?=
 =?utf-8?Q?u/hEUnizupWUvRh3EYo6C4g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120574ea-5df0-41f6-9873-08da96f9253e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:03:24.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/jgcKoLTCqWnI4a54eH0pytlYeFeWRvx+/y/t1HxX/DZowPNbFvpAADbanm+X3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> This hasn't been used since
> 
> 138a12d86574 ("btrfs: rip out btrfs_space_info::total_bytes_pinned")
> 
> so it is safe to remove.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0003ba925d93..3936bb95331d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -87,14 +87,6 @@ struct btrfs_ioctl_encoded_io_args;
>   
>   #define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
>   
> -/*
> - * Use large batch size to reduce overhead of metadata updates.  On the reader
> - * side, we only read it when we are close to ENOSPC and the read overhead is
> - * mostly related to the number of CPUs, so it is OK to use arbitrary large
> - * value here.
> - */
> -#define BTRFS_TOTAL_BYTES_PINNED_BATCH	SZ_128M
> -
>   #define BTRFS_MAX_EXTENT_SIZE SZ_128M
>   
>   /*
