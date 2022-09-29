Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF45EEC51
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 05:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiI2DI2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 23:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiI2DIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 23:08:25 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00041.outbound.protection.outlook.com [40.107.0.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98412125D87;
        Wed, 28 Sep 2022 20:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MONY5Gzu1qp5N5A45GC6Ls7vT6f6GI5oUZORj4+eBQkvon0zvVqhfOrdrXrUkW3ndCSaJkFFhL51RPVprgkEh0tjj0/L2LpRugfMoavIFyDbgYp/vuG5aYnGFHFAO+6hxutOy5SvqWM2tz2pnp47Am0nhGE51A81RovGEjKXf3F1I4QJQpsAUv4RJ+v+OTmSQvkFNwNbOGUemeOsNksX67b639T5onAOmq4jPOoDh0zF1+R8pD28rdw9juV8MfTNpYX//ZmceJvPdyWpIQBAS4WKT4SwxDCOAmLgkSYTg3mZsjWYiRRwjKGp4QHt7Vv0QbVznsv2mtrZA31sI6RAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMGHAgMM8iAKW07mzBx1oj8TIN+JjkrG8xYHi4iClh8=;
 b=Z3dR3DFLCC42EcMYqyCbJU6+k5qcCVKhl1e56AdyUEGRefWTWu/3jzOtWDGg0ftekOp5JKTSkGFmgTAUKZFYajPNiYvdyp77K/9UlKXb9VJqCirKNzSDvbR4n/dzKOpVdvhn6kUGOGkZp81SaIbti8mKjvLFTJs+EgG/y5blij8Vd5G+OY9Tu1EtAA5o163/mo02gAiop8abJYY+XcB1qvHOoP4XIQoV0Wd6CApsB5inO28Q/4Swme/H4JRZedrF5gVKGrEcWFIFYNUgQq4VBsMCcEY0bQUhdmv/GlYldoWYe+CrtHzTNVIw2bk4lOLv57xYboZRDCnDiNjfbaPe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMGHAgMM8iAKW07mzBx1oj8TIN+JjkrG8xYHi4iClh8=;
 b=EKPGpf5iIBBBb4jHQB6gWaxRfq8J0kiqM4PHDHnDSw5Ge0urslVvvWOm5+mXi5i5aUbbpo5LAsjeZtvuSVGLdlKdHYNAdubH1vAmsU1S3BVXE0CdQttNk4TxrTq141/vKHkxwGFiUk2NXE0455jhuI3AmwkdJ8domNyZyXbHlxMd9BImqS+LsQiIy3JknSQMg7bSJgDywrHFYbUAwoFSW0LWIytY5mBnFj4e/6dvcv8YF5m9DclVVOCxtWpdoTiSO87sSTqXyZWOvDQL8darWZmbUl0FaC74Ce4aWuL09RsViEH6PZrL1a8FECAbZYoEGpZT14/rzqguOcSBewjVZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7984.eurprd04.prod.outlook.com (2603:10a6:102:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 03:08:20 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 03:08:20 +0000
Message-ID: <c4293742-06ba-8720-e2eb-d4d3bc4da044@suse.com>
Date:   Thu, 29 Sep 2022 11:08:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     stringbox8@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929014402.2450-1-hmsjwzb@zoho.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs:remove redundant index_rbio_pages in
 raid56_rmw_stripe
In-Reply-To: <20220929014402.2450-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7d167e-96e9-491d-890d-08daa1c7dd05
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+LZ8yQHXVRC9S+9m3MMwRzNZ/G2ojWNqZIQAkLS9zFvH9nynWnAKM5DrSAPJfXahwxKMlgvPhvegBDAeyHKr2eplRHfezzG13dEHJ+sBwMSf1irgci2ZKd0nS+cZQ7Z7zKwk/Ik8BaXhO9IQbkErDFa+vX9DB5Y0WWgx74UPkAKjqrHX3wuFE+rTYTlMkUbZVo9pgNbFQEEe2+C0HR15NMn6GuWH7JLZV/bBO885I+GMwjVU0rCcvpUuTBR8NNvQsI9/gGwid/UEVLvmwMH+1yBNxE1IPopRQprUYA1y3RZQTYrfg0XAyHIbbff0RIggjd4mE0Ku5eoNH44vlD5HouFg3pfwAiF3mWhKw5tXsDNuHCF7CSkKqe6i4kcG4rRxA8GTtAR3hkkaqmIl115KvI7iy5y8utf7ZIww5DgcvgbXT3sg6P1EMfqYjWaXKQP6WGMd49O8gV4FN0PA2W84dF4yftGfnPxf3FA3NQ1EmJBsSsfLkKYK4zeFVbiWc/tEKFNltHdG+eNe6m24ks0couD0zhb4jCW4z3RVKuAcooC0ep05ooQpOqlwI50hK6f4bfT99d5f/Y1meXaOo6joaNFjiVaFkFPM2l4H+ZVtHnL0hxdi9fMmguUk/31RdIkr7xuEySOVaxoFuwZNqfR0y/Bs2WAFrMfSGRqog32jT5aoqtJrY2Q8jg/gticfZbGT+7bIBuFTkLOebOFUtteJFjKhNmWebBjoPRYltAabSKaupRA7TRWgir9lgFBzvJWYsI/slHPEOugGcZLgL3a1ihPrTJZ40w6aqYfG3src00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(54906003)(186003)(83380400001)(2616005)(38100700002)(53546011)(5660300002)(41300700001)(2906002)(6486002)(6666004)(478600001)(6512007)(66946007)(8936002)(66556008)(66476007)(6506007)(8676002)(4326008)(316002)(6916009)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZFaDkrMmNLWjhpM1E1NnZRVnZteVRlQ3ZrTUc5QlEwNUNJQlQ2eTdQNXRp?=
 =?utf-8?B?MGpVcTNDNGlEV0xJcHE3SzdtdS91VVU5V29WZHJHL1RVYU5JeDB5aGFMMko5?=
 =?utf-8?B?L0JzQlhQOXIzSnE5RURVZ2xCd1dNUStUSDZvamxPZUdsMG9ES1RON0ViZzZ1?=
 =?utf-8?B?ZTlXOW9scDNFVGp5VHBPVmdmZW9HYmw0YWx2OHh2bGcyUEdqQUZEaG1tNmwx?=
 =?utf-8?B?ZlZ2KzhJdm5hdVdBMXRONHp2MGgzRGNJQ2RSdlVPWDJ4SEYzUGoxZTVhV3Zr?=
 =?utf-8?B?YXV2dnB6bzFBcTZWd2hFemNxb3RqV2hvalI4RTFNNWFDSnAzRDh6UnhqUzVQ?=
 =?utf-8?B?TWFVR0x4YXlwcnVwMDBnNnZBVUZhdmtTUHJ5R3FKL2FjZHZ6MU50N1FPdFdD?=
 =?utf-8?B?ZDJaYXJOZkVLU3pkNWtsd2ZXQTdDNVVDbC94SkU3dVdSY1RZalRjN1d6MEw1?=
 =?utf-8?B?YjYzcTRyRXNTdHJ6R0JrbXorTE9BYXBTL1Y2MnNUL1owUmRTZXA1U2w0K3B2?=
 =?utf-8?B?VTNLUitMbEI0b3lEcnJZeUtVckJWQllkNXZoT1J3aC9zVVNVd0Q1RTE4VnlN?=
 =?utf-8?B?VUFSVGlNS1gzYk43U0ROcS9jVlA4WGZKODdKNEVsVE5NR0FaRnU4OFFxcG03?=
 =?utf-8?B?cFU1MnFMMCtwa1Rxd2cyLzNBb05ZYm96NEZIT1IyZHovd1JTRDE3UHNXN1F0?=
 =?utf-8?B?Q0tES3B3OUM2clk0eEVsSzlsc1luYjFwTnZvRktvU2VjV1c4eEptaGdBczVF?=
 =?utf-8?B?UW9jZzF2UXhub2NvWFo0VFUvNDZ6TGFjMVlkcmJjbjVrVE1EODQrcWNwM1VK?=
 =?utf-8?B?QjdZNVVRWTBwU1UvWiszR1NORm9BMVRMR2hOOElERUphcFVZVGNNSDVETC9O?=
 =?utf-8?B?dVlacWFIUmcwSWRqZkMzVXBYM2NYSDBKZVB4Tndhc2xYaHhaSlBBbEhKN29V?=
 =?utf-8?B?elRoU3dnb3htOHpwRTN1c3cxN1dnQzlhZm9ZV3BuWFk4Yy9FSkkxOGlJaWhq?=
 =?utf-8?B?ZkcwaVZzTkg5YmgzZStpVzhBZm9Ob0REblN3TjFpT3lXQ2RnZkplSzNpWjY5?=
 =?utf-8?B?Y3YzSldqd3g0SGVlekdJM3ZuQmtjVXZIdk41RzZhTGk0WFJFaS9pYi9jVmJm?=
 =?utf-8?B?aGdTNUpvUVFDU0ZQM3Jscm1KcWxDZzBRajFGdEJTVTdqNHNLTDFjT0FQSEdl?=
 =?utf-8?B?YlY0bU5ubW1mbW45R296ZDRSOG5kMHdDRG5NYmJkTkszSnFHSVRSVEYyNHhS?=
 =?utf-8?B?SUR3eE1GaU5DY29HTFpmQjNTM2dZMGdLbnJ6TDVoMWQ4L09FRFJnN0RSRThQ?=
 =?utf-8?B?cXc4ZVJqaGF6M1A3eXVBTjNwK1Z4eExEWlRmRVBjbSt6S2lndzZJNERDaFA3?=
 =?utf-8?B?aWF3dWN3djNKTmxEY2J0amRETThTdUhIYXhYNnQrbWE2YTV2bnprajZoa2hy?=
 =?utf-8?B?L2xrdGhFRjRKRHlOVHo1N2ZLMjdRU3o5R3NSR21TbXhaOGdCVncyL0dSQVNh?=
 =?utf-8?B?RTZyVElETzU1TXI5TVh4OWwrbzlVRXJKWXpLZlY0MEpHckxkNzRyMEo2eVlz?=
 =?utf-8?B?UDBSREVLTEcybHU1QmJOdzZZYzJxVnNDcmFHSDA2bVhDMVZUUUFEMXV1K0xS?=
 =?utf-8?B?OE5xbm5HVGhCdzI2ZitBMW4xNjlWQXFUZlNFVXBwakw5T3U0bE90ZFNxMWJQ?=
 =?utf-8?B?R05LVVNKN0wzenZuL3F4Y29YUGtRbFhoOHU5UTY1UlE0RU9TSWozb0x1MTFP?=
 =?utf-8?B?YkhWUHNON2JXdzB6YW52bkl6WWt5SFBHMmpxamFWNmUrUStuZjdOSVZITWl4?=
 =?utf-8?B?c3VjNHZCWDY3VWtkWXdXZHZ0TjBMam5KeGtCWEhsQjB1ZEFHVFVGYU4rMzVa?=
 =?utf-8?B?Nk9MY2dxSjBRNExHcnl5U3UxdFlwSjdTeFNMM251a3FOSzR0RHB2alNXdG1p?=
 =?utf-8?B?Sm5kdFA0YnQ3Rkx2TTdYcmJlemYzWTFVUDZnWGtHU0tlVG9IL3RFUVkxNjZx?=
 =?utf-8?B?eDNtWWhmTVE5MWVNVEdWSDg1bEJtK0JtTS9rWmNEVXE4SkRqS1dSb0tiUmJ3?=
 =?utf-8?B?NEFrbnpibmlOVGxDOVgzTllMeSthc3p0d1FIaHc5eStxMERtOVh4aGtVRllX?=
 =?utf-8?B?Ymd4QkphVzl4UWczZms0cTFIRnVyMmxkS1p4TlZUL3M2N1cxdUQ2RUdhb1lO?=
 =?utf-8?Q?yoBvtYWy+pPuzr/krTQeLSg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7d167e-96e9-491d-890d-08daa1c7dd05
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 03:08:20.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Uxan5Cba4HJ0jT70fHmyPAIhdW1ecuSvTWuarr4zWms57HfX0urBc/pZ2890dcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7984
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/29 09:44, Flint.Wang wrote:
>    The index_rbio_pages in raid56_rmw_stripe is redundant.

index_rbio_pages() is to populate the rbio->bio_sectors array.

In raid56_rmw_stripe() we later calls sector_in_rbio(), which will check 
if a sector is belonging to bio_lists.

If not called, all sector will be returned using the sectors in 
rbio->bio_sectors, not using the sectors in bio lists.

Have you tried your patch with fstests runs?

IMHO it should fail a lot of very basic writes in RAID56.

Thanks,
Qu

>    It is invoked in finish_rmw anyway.
> 
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> ---
>   fs/btrfs/raid56.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index f6395e8288d69..44266b2c5b86e 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1546,8 +1546,6 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
>   	if (ret)
>   		goto cleanup;
>   
> -	index_rbio_pages(rbio);
> -
>   	atomic_set(&rbio->error, 0);
>   	/* Build a list of bios to read all the missing data sectors. */
>   	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
