Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97A45B9768
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIOJ1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIOJ1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:27:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892880F70
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqWogKoqThzebhgkVgp+FyDUtUTh+Fm8SW6WoXJBkwwMJuIvH7p6xGmNBmZCr1iJXM+d1oauIGg7W76J9WGNXuuJnGb8q8+kZvClbRp3G7OLb2hEMWZiowt0J7eR8TE793mvyLWFOrQ4+NlTPPPCKRAvFl5FboUvLFxcpVuvgXQKnt05/JrY0jn8sXBwHoH1KIoicE34F075pVBWnOPgYW/f8M2JZ58A/UbFiMumCrGBMhJmwi99xzMChZcmdXsBm6c6vcS6XZ5zumR8+xjGhjNTZCUaQBtk20qaKMPvWYxqM5rz398gwrgLq+b0zqWXLrN1iWHK8KgqymacSgoo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qwQGM+zzI/XyjpEsQop4SQH4hcPFJ4qfkZAumRlAbU=;
 b=Jbcd0fjvP6orAJC802909fRJOk5X1DZqYf+XVUCUAA2zttjJ780RKRu7sncrkaOydrHVmMxQPv+WR7Gqd0NFXHnzFeleuc+rKB2KxMQwZunVojEeHp/FlCW0n2Hyc94KkgJigNkZHtMklvTviffTryeM3JUSWmvZVNy499ecfvrPdfiXkjwKgMibrvfoGIUfr+hfR7LlaUUlwxvukThn1oXqFJDRaI36BFxByp5zzBP4Ae4MUQCrzT496bn5chibVzqwUssqWX8vs/elRNepeRNQi+Am0fw6reLmm9VMGypW5/56zbNXu1LgQ4eC9l7FDpcZxbRMbjspLUB6vKEHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qwQGM+zzI/XyjpEsQop4SQH4hcPFJ4qfkZAumRlAbU=;
 b=SFHayy7n/ko4VmaoyGK2iJNJBzPh1IXiWgLW29BvTD2cSDa8YdeOP2R436G24jccwjl0v3ZHolSAs6k3/sjIpndskd/W/izrmcfqR4W4OckAPLSwGULXm2D22OrUZQ71MmOT51eYOZ2SjvOsDqANhxODPjYMGRvl80kmbkdux6F48xmOCaMapPlJFVm7Ya994yopiymaoQaPrASSY77BETJlvMJ6OwAhU+6SIq9RTd4jfPmHXs9hfn3KX9bRu9Tk9Rj/lnBEf3I3HMNyNezEs68jSrfnRtMUDrN1sh9AeaYHPvoB3YvILR+Fn27vVz4B+r15O7VhQBO6Hsmb0F8vNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:27:32 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:27:32 +0000
Message-ID: <7e16c889-0667-31b2-dd6c-5dd724fc3b26@suse.com>
Date:   Thu, 15 Sep 2022 17:27:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 14/17] btrfs: move btrfs_path_cachep out of ctree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <c52053467e423a650b9fd0edbf789d62fb7df87a.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <c52053467e423a650b9fd0edbf789d62fb7df87a.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 3963c18f-5ab2-4cae-66e7-08da96fc8489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiPzi7T32vdkGy3MxMeDjx/WW3jli+Duof6Vcbs/7r90Zrb6c8X55Rxs6I9BNBopq9txJSqsW4FTJcTeY5tKjO1cVrRohWIe/f3EQEtGDy+KJu2Z+1M+EOPzZdaLK+a0ZSzZaSftucv9+dvy2qhvlj5Q3GoS2b6vPZ5aX5mH5+qdPBfcTYU9fOWqe6Jg7EG6+aqlJwtPmh/V/0dPAQckg7OSDt3ixSp0NqpjyjYmPpyPx2m1AouoUvAo6kGZKq91kA+hsy26lp+HyEHI/xs64KmFIC2nd8O9CiY/JZNEVcM5D3OnebkIXxirp8HZ8Luf00GkQCbXPhGSBzMLdc9CT4wvrkNCDFsh1MXQdacY15kV1BRoeqsipQABsFysafawAJsTV7OVX1vnboPfAJDawqjnVS4bkP/XYcMQICU+MQGsWkpxySotLXaH/O97yW2zqWzxbInIMZiky9soHzBZ8is+pj5nukAgY6ovJx6rUMm9h/zUl4TTBwW3SGEXssz3eY1400h6V2T+61pC8ECTjHn8wDjDIY69c/M19hfGh7AWZG/Hmqz2M2ub1o9qTWyRBlNAAS5bK07ZxjMZpGkeY+r5eJDZH8oANzivi6PvO2Q2ARx8Oqwm2WjguvnHEMXeOnSXvqDCC7aDswzIJK7iEJJgqHfhDiZw2XDccD/hd3a2WOmTIp7CKd5wHKlS7eZ3M/Zx5bHEKF+thHxQalxKFztNpV6A4j+anggqqKN+R8OaaoOrBCTZpL6JLVtERrjZD+N2hxex1aNcX2d2c/DQa1xnMKSshoYi/v5RXYxxNOXwDXUwrqahNwcp4Yor7EE+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(31686004)(86362001)(31696002)(36756003)(2616005)(38100700002)(186003)(478600001)(6486002)(53546011)(66946007)(6506007)(66556008)(66476007)(316002)(6512007)(6666004)(41300700001)(8936002)(8676002)(2906002)(5660300002)(522954003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZYVG9LNWl3eE9zd3BxTEJwcVUzUmJuVjZwTDlUSDZaTGdac002Wng3bnN4?=
 =?utf-8?B?MTVvNmxxdUhFTXBsbXNDOXFnc0dEZG0xT2NjOFg3aGRKZWF3OHQ3RmQ2Y0o0?=
 =?utf-8?B?V3BINU9DaDZlR3gxbmtPSnROQ3hCTkNJTmxjTFVra0Z1dUxZYlZpREtLZ2dC?=
 =?utf-8?B?OG5KK3BrKytadVVmb0c5RGRrbXVOMWVXRklmYy9mNEpoUFlFTGxYYkpCYXJD?=
 =?utf-8?B?VkdhV0RpV2pwV2pYRWFnd3NMQ1NJV0tETFhsNTdQRkVuM1RiZDdzdTBHbVNh?=
 =?utf-8?B?TDE4dUR3WVprci9DQTF4YUJwaks2MCtNZDd6QjhTVy9vWVVJZEtNVnNhU1k3?=
 =?utf-8?B?anFhUmh0RGtIeTJaK0RPWEQyVXJkc1hOQU9oMWltUCtSeFFaNjVCcnBnb3lT?=
 =?utf-8?B?VzBBZ1l0RXBGTGpsellqbk5ucWNHSk43ajlZZWtYNjB6VStGWUUyK1ZpVHVD?=
 =?utf-8?B?bkllZ0NVcWpzYTU1SGdHeXBWUmI3cTlXNDJrTTZWaEw3RXk1T2JiYndvZlEx?=
 =?utf-8?B?Vi9iMXk3Zm9NMHlwOGdQazYzV1A4UkxJNXhzUXBrd2tEYnYwUExJbXR2RlBy?=
 =?utf-8?B?Smw4dnJidlAvVW90N1lOakNRb2J4NHREbHVvUnZzWXlKSTJjUW9mZm43ZnZp?=
 =?utf-8?B?dzBtMEJ6WlpDMS9Hd2ppckxVcUpaVXdrL1ZXMW91K0JuNEpDaW1aZ0FuNi80?=
 =?utf-8?B?VU54dUZEeDVjK05HZUdZd1BlT3hrWXdqRWpxUFBweVh5MDJtMUdoenVtZDAw?=
 =?utf-8?B?VU9zZVJYVi9LUmNQUW5kV3cwbGpqcGhlRVVhc3B4dDBxL08xYjh3M3Q5aDlW?=
 =?utf-8?B?TFFYZlQ4UWxUaDNId2pUcDUwL1lNQVFPcU9BMGhLU2ZGTVBoc3RrbS9sVkpE?=
 =?utf-8?B?Q0tubGx6T0FCdTVRVzBJanhPK3Jxd0dDc0svU0VyVzBsUXMyMkh6eGZEWE5V?=
 =?utf-8?B?akx1aGhhZVFMWWU1dDRQZy9zOGJjbkJYMFd3Vm0rbnlWcEdQaUx1ajk4bFNS?=
 =?utf-8?B?TDAwaitPTmZMdVlDRlFrdFdwRWF0SEViKzlIWkQ1cjdncHBzM1o0ay9hTEpE?=
 =?utf-8?B?T2xQKzljTW4rUjZJdnlsMWdKcldDVlM1ZEVTSmxLZGVvdzZWSVpydzJFQks3?=
 =?utf-8?B?WEF2SXRuYzFHdGErWW5WWjh1N2VSOGVRZVp3YUdvbTFZN2Q0VHdjdWZDQ1cy?=
 =?utf-8?B?dlR6UzlucEpFaTVNMndQbGY4WmV5RHF5dk1SOGpIMnZKaXUvWjBialM2ZnR0?=
 =?utf-8?B?NDR6STNmb0ZBTjFjS1liNVBSQ0lJbEo5R21KNHFVUmNKWWl0d1dFTU84S1lM?=
 =?utf-8?B?UG5NVFFkV3pVTVgxejE4a3dZUWNoaDkrQ1pTZ09ZTWRIWjBGNHZPcjl0NHVk?=
 =?utf-8?B?cXdYS2hQNURxeFdza0hkQll1S0diQUtSVE1jWDVyWWRGMVo2bFdlMFpMeSsr?=
 =?utf-8?B?Y3JLVFlEeUkwbWdac2Qvam12UTQrVEoySlkyQld3dHUwUTJmdnUyTDFhc0tY?=
 =?utf-8?B?YjFoLy9tV2pkbm51S1NLMUw4ZUN0d2x0eUt5QzFpN2pmdFkwNFBTUG03dEZ4?=
 =?utf-8?B?R1lBTnNpQXN2elYxSHhndmdiNENDSmlqdWpkUkl1L2pNZHp6U2hzUlkvR2NC?=
 =?utf-8?B?cENvVW5ZaTlMblVkTnJPeEZnVkVnR3VIUWpXUUVod1NIUFVpNlZFL09QdTZw?=
 =?utf-8?B?b3UvRlpUa25HNFU4QWFrVDI0SmMyKzlXSHJjRUVSZTdpMEtkZ0JSMXIxMG44?=
 =?utf-8?B?NzYrYzVVQnBHdytCaHFJMFpIc25QUFpBc3R3MkdtNThXUmxqTjQyNjk0S2R2?=
 =?utf-8?B?K0dLRVAxUWhpRll2UnlnbXRWTzhuZGphK3JFWmM0S1orOEF2UnJCQTNxVXhH?=
 =?utf-8?B?WXJVVGtRempCUDNMb2dQSU9JaDlJS2dzL1ZQR2N4dXc1eHBWRVJGRGgvNDcy?=
 =?utf-8?B?NlFhdjk3K0Ixd1BET2YreTI4aXJhZXJFaFFOMU1NL0xVakVqQXdLeWprQ1F6?=
 =?utf-8?B?bVJ0MEFSQWQ1dENvS2lZQUJ5azROM3FLMmUwNjZ3V1NUUm9kRlZGaElTNkRk?=
 =?utf-8?B?b1FyL1Jvc3Y3UzFXeDBZTW9Md2Ivc1V6ZExSajU5MFBzY3RrOHZjcCtiZ3R3?=
 =?utf-8?B?S2ZsNjB0c0x2emZ2RVFRTjUyRVM2b2RRV2Y0SXk2dzllUFRVYVJqN05qM0JW?=
 =?utf-8?Q?NcSKRkJ+eINVDjFL05jgVws=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3963c18f-5ab2-4cae-66e7-08da96fc8489
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:27:32.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYYaihmIacEQN6M0A+ftMxH4YE7P8HastrIFrYMSfqAWk3BEfqZbAY19+dUJmHDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917
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
> This is local to the ctree code, remove it from ctree.h and inode.c,
> create new init/exit functions for the cachep, and move it locally to
> ctree.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But one thing mentioned below.

[...]
> @@ -2813,6 +2817,8 @@ static int __init init_btrfs_fs(void)
>   	extent_buffer_free_cachep();
>   free_extent_cachep:
>   	extent_state_free_cachep();
> +free_ctree:
> +	btrfs_ctree_exit();

The tags will grow larger and larger.

Can we make a new cleanup to make all those _exit() function to be 
unconditional? (e.g. check the cachep and only free them if initialized)

That already happened for open_ctree() which has some incorrect error 
handling.

Thus a new small series cleaning up those tags would be a good idea.

Thanks,
Qu

>   free_transaction:
>   	btrfs_transaction_exit();
>   free_cachep:
> @@ -2826,6 +2832,7 @@ static int __init init_btrfs_fs(void)
>   
>   static void __exit exit_btrfs_fs(void)
>   {
> +	btrfs_ctree_exit();
>   	btrfs_transaction_exit();
>   	btrfs_destroy_cachep();
>   	btrfs_delayed_ref_exit();
