Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A39612E84
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 02:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJaBIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Oct 2022 21:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJaBH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Oct 2022 21:07:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261389FF2
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Oct 2022 18:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpefv0pds47tIQDWaaTu2Ley5dsXvLLAdcvecKfFcwwQMKj6IZdlkZ9Whkn/SIfqvi2txGZdnZpfYVDNDidz15in/gd2rVkfLQCcjwqleuJOWpx8k+Uza9DF6ubBqiYlqE8UJHsU7C/MbxfYQlcLEaGs+3hTNRcqQtKH7C5AUBvfQCAmsgKkkY+26DXV4MgQb70AA+kBcpXkQvBjrHzJvUDKPnzYwUtoJhF4uKZh3NcG+TPiIBfh3uMf3vo2wdNv99vNIGfuF5QBA6Oo5KtcYBjyiM81EipT2mn5OCR1Jvu5XYLWH5Ml0G5TjZFS3KINkeJq+h4Snlaov0aLiFkk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjXSlXERqcaElDYp9PwlhVahw/GpR+6eDKY4DWrEAGk=;
 b=mq3ccwgEnBrQs7uHbf+LrenTJbGeCmSnRsj0VEOucU5o5jpeJ7OIjEe5H50537e+TWRFqhTA0WCfjY4c4/gvbSpGvlJGLmIpaZ+L0PHrR8RE7RzDkiJXx3ogGaJ5kf62MBoZAsI8wY1S9kyC60FGtvoUgoCFDra8xbjUOW6APb76XG7lKql9kIgc7l/QggavQ/m+/gxuE5z90sHvUH1BpLUtO7kDS62qXqFgzsELC7KoUwoJB2Hpruz4Wd1q5XckQDb5T9+8I4L50hZcbjYLsxO7hMVuZ8xklSFVFlUTGq9phqi4bQcWDd+B30sR4G76G8tegJO/7DOLg4zSTySYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjXSlXERqcaElDYp9PwlhVahw/GpR+6eDKY4DWrEAGk=;
 b=HwmhN0uyR1+Q7nBPKvD6L1+MGTS7qLdGnGk1nzBBAeMlwECwvfwUs4bGvtHjfvkUF9Ih5l/SmrymT8wUf7P8jLpH+GZdTZ46QjpkBYapSWZedpBrL/AnWATlZJn+hCHwW4Z9LxtrrJITnrARq9nAbraNfNef34ZZFPa6S3swfOj1Iwe8UnQlZwdtSoiu/BpB4dBLNgTdwelvL345D1Zr1vMMERngBT9p88WRZ/9cd72JWqPyO0icYcDXhuE20kjHWJXCSnIspXuvUFIF+2u3hUFjvKD0YW/vbvlZmCYTZ1ExmWRVcX5klMYu5hwaGMtuF91IeQ1ZJyJCG6LC5WhJeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 01:07:19 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 01:07:12 +0000
Message-ID: <19e98ab7-949d-3c19-15c3-7b83ac428967@suse.com>
Date:   Mon, 31 Oct 2022 09:07:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 8/8] btrfs: raid56: switch to the new run_one_write_rbio()
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1666760699.git.wqu@suse.com>
 <7dca624de976e872abb869885b009713eddca061.1666760699.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <7dca624de976e872abb869885b009713eddca061.1666760699.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: a5888115-3433-49cb-9f25-08dabadc3dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qdt9ykLA0oH1UwZpCSSxfsLDquMwnH9w+VatpV4RZ6EDSYMtH+WLqg3mZkoxvT61XifrV4R23OJXWcFpsLujDOeAObwTRssJUw4MveaGVZCp/2lj0kLZhZ96SIOakZyM4oC7NLFcgghBP9keByURualAvwv+NrmGQuoz+S2X0w5eOdO8nycapB4TUKjx1AjdfyClCV6xThy58O7WmT8+12jRNTPlwJh9R7zjKlI4y7TjitqyGr4MXvcshdA1wuWHvm2110OgNCzoX0zLH2DqMz9EoirSoGLDyfg7WHgT+cpVCAhCky9oR9O25IQh/v1bIHAfIa0MkL2g1wLbJzm70VDFUFLXEgCVNp328r0lmhypJKP5nee9+76jxKUG6K9ZnoXP/RgopiwzEXqAZwDybXQv8dkIXSq3hjLc21o5zaVkqHTUiGfuwntRf28xduPyVaShxHC8XxmgngDdfX/gaTUjUM05YNVayjABVdVleDEHb5+k07ds2d3vKd3liWmvejw3ZGE/9VkiDuEbse6j9gXzYeho4uXZBdcftqUxESB+HsXRU5ZKFhhGfLEugtBbd5Tg631/madELrowgEC3fMIzh3D4nXTO0fb6uv8LGoHs9BkN2KVWtyw62BzGIkZGlyK5Xkfcv7jTwxRJNzbsiDEgvxmis4Ff8AoCYgY19SA20pLMm27L8YHQ06JbyriX11jI7D3NetH+TzUX4sGDTP/eY/kXsKaDI0dhlcJxQ5qecqcnBjD6LKKHw2m5emk/YbNaKA/nTljNUG814dOStl44LLNjy98bne+SaZhAxCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(2616005)(186003)(8676002)(66946007)(66556008)(66476007)(316002)(6666004)(6916009)(36756003)(6512007)(8936002)(5660300002)(86362001)(31696002)(6506007)(53546011)(41300700001)(6486002)(31686004)(83380400001)(478600001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bllLQXorMmErSWVCV29WRWkwcDQzNElhZUc5M2Y4dVZFa0p5N2NnOS9ERmhU?=
 =?utf-8?B?YlVuYkhIS1EzNXd0NHlyTkNNQ2FseFYvNWhCQWRmcE1xdG9EUmNVUTdDdzFz?=
 =?utf-8?B?T3loaUNMckhDQjVuU1ZFdFF2MWo3cUxwNnVaMTVma3J5dzY1RkJEK3NOMFRt?=
 =?utf-8?B?TnNNRnllRXBPRnRQQkI0Q3hydUd2VEEwQTZNZVhVV2ZSbDRabGlLQnpON3I1?=
 =?utf-8?B?V09abW1yMVhtWERRM0tGOVdzZTMxYThxMDlYK3lzRktlWVpzK3FKb3JoL2dr?=
 =?utf-8?B?bjN5RlpSUFMxSEJJbjZBMnk2UVNLMDBJSVlGZXRIQ2ErTE01T2kzWllCVEhL?=
 =?utf-8?B?NnBKRmkzUVhjZmcwbjZsVjRZSjFCcWhCOGs0ODNQMVF0ZDFVd2ZYaUhIeFo2?=
 =?utf-8?B?S2UxWlN4U3JIY0x2TlRVN1Rlb3hoY1RKcm1FSHJWQWwwbDZwQ3k5ZVh1bHk2?=
 =?utf-8?B?V0RSQ2s0WGJzTXowUkV4UzZIaXBMa2VZK2pnWWR6TEkrSWFzUVQ1cTBkakdM?=
 =?utf-8?B?ZFU0YXJlbHFxZ1BSMHNnRHNQUGg3cUR2VWZES3M3Qno2aktDdnpNdGFEV1VL?=
 =?utf-8?B?L2c1YzM2SVo4Ti9JWEpVekFFMG1CQnJiQVR5ZjVaOEVVU3Y5dGR6cDhUeVdy?=
 =?utf-8?B?Y2lOamNkMWhYNVd6dS92Rkl0aEhYbHExeGFwZWZUWmZ4dlVVWElmeUVhTSsx?=
 =?utf-8?B?bjRTYlVPV1haVTBMMVh5SFdKb2VtZlk2RmJqSWoyYlVDckVmK0NLTE5wV3c3?=
 =?utf-8?B?MVVLTzZqSFpXckZETVJJbU4vZ2V3cERLdjE4MFBVemp3SWNqN3VFS25sTGU2?=
 =?utf-8?B?WEQ1MkQ2cnhIUEFoM1hMeDRodjFLZjJKbGhldTNzeFZKdkNrTDNXbllpTFcy?=
 =?utf-8?B?d2FxM3NUNFEvdDFGdTlCK2tNdWJYTEFFRGhUSk9KdmRQaTVNa0g0VVdwQkxv?=
 =?utf-8?B?Tzk2dVQyTWhtQTE1TmxmWTU4OUttejlTWVRaTmFNVkd6U29BcEpqRnBzeDVY?=
 =?utf-8?B?enhQWXZHWFJEMTc1LzFsek9tZVBEYlVoa3pDNXlmUmp1eEhxMTErd1NMNk9X?=
 =?utf-8?B?T3B6SGtUR2hRaUw1aFlJOXhkcU5xQ29Bejl5cjVpcWEzQjhMaUpQV3R6dXNn?=
 =?utf-8?B?am1UdnZXbmw4MXd0aGdkeGtoYjhGRDIvZ1dGd2NhYUlUUitpQnZka1hpWmdQ?=
 =?utf-8?B?RTRrZnZwVFhtRzJoYVBIc0NyY2ltZWNRdStmR1Q4aTRIUlh4LzdoNnZFelJS?=
 =?utf-8?B?K3dOdWJSVGZjbnJJRUdVaU5xL241S3dtdkFvbGJ0QlQvMWZxeUJWN21Tb08r?=
 =?utf-8?B?eXpzUHB2OTFza1hWcEkxTHBnTnFxUEg0a0NjWGltK2FpcXA0aTRGOW44cE5u?=
 =?utf-8?B?T2E4UUd6M3hTa0N1VW51Q2pFK3IvQjR6ajMxa0JpZlA1VllHMTlaR0NYNW9N?=
 =?utf-8?B?SytBdWx1RGRhMkR1YlZ4Y0h5Wm1hRTJFcWUyZDl0R3V5QXNGM08xL01VY1dZ?=
 =?utf-8?B?OThTcGlZalMrckV4c2lnL0puS3ptdnZJcmdaMXJDVTNyNGRFTkF2ZTlJMk5M?=
 =?utf-8?B?VCtYRUpHaFppK2RlRVc0a0g4OE1meDNwcjVqZDVsb3lPcEhLM0RMOWc2TUFt?=
 =?utf-8?B?SUNGL3pGY3c0K0Z4OVdVNUpCYWxVd3dzQ3RmamJHc1hEL3pKaytEQ1VZTjlZ?=
 =?utf-8?B?UUhhMGdBVHN4bi9NSUJCNVQvNEkyZzFBeVVUQTVkRjg2aXRPVHVTTmR3Ykw3?=
 =?utf-8?B?aXFNQzAzK0s1UHhiTGFaa21iaEZ1M3FrNVBRdWt6Q0R5elNXdkcvM25rNDFO?=
 =?utf-8?B?Q2I3djBDSUtubHVqSXJTOVg1V2oyZDV0RVdsRjFDMEw1MytqNXFsWHlnRFVQ?=
 =?utf-8?B?ZUcxQ1pkZ241Q3RpWXZCYjBRWUVvTHB6ZXp5akRlMmUydEx0L3VUcERDVlZw?=
 =?utf-8?B?Y2xKMG9BV2c3dThmZUYycVJoS0RRbVdUOHFrbHJmbTM4L1NZK0RXSnhHMElZ?=
 =?utf-8?B?SkFKREUrQVptOTRndnhUeDR4ZXI5Y0V2RDRXSnF4VG11cTZsNlNGWlNXcm13?=
 =?utf-8?B?S0kyUGV0UlBCT1dyTTk0N0I1ZjBuU0tSTXN4THp0R1pBWW03cTc4MVJ6dUE3?=
 =?utf-8?B?LzNIbXdFVnpnKzNKaVdCV2VtTEhKUnVrbnFnYWt5Z2lMTUo1alNkVmVUdHAw?=
 =?utf-8?Q?RRBz6Ao0A3q5zPyuX2BMQ7Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5888115-3433-49cb-9f25-08dabadc3dba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 01:07:12.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgELAyglrK70U09pRWjTwo9rvJqo2VoUQTxooyjFWbdbGQMUqBjwUU7cAVZ75Mx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673
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
> This includes:
> 
> - Remove the functions only utilized by the old interface
> 
> - Make unlock_stripe() to queue run_one_write_rbio_work_lock()
>    As at unlock_stripe(), the next rbio is the one holding the full
>    stripe lock, thus it can not use the existing
>    run_one_write_rbio_work(), or the rbio may not be executed forever.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/raid56.c | 351 ++++------------------------------------------
>   fs/btrfs/raid56.h |   1 -
>   2 files changed, 27 insertions(+), 325 deletions(-)
> 
[...]
> @@ -3284,16 +2987,16 @@ static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
>   				free_raid_bio(cur);
>   				continue;
>   			}
> -			queue_write_rbio(cur);
> +			queue_write_rbio(last);
>   		}
>   		last = cur;
>   	}
>   	if (last)
> -		queue_write_rbio(cur);
> +		queue_write_rbio(last);
>   	kfree(plug);
>   }

This part is in fact a bug fix which should go into previous patch, or 
it can break bisection.

This is already fix in my github repo, will update the series with some 
extra polish, like remove the raid56_parity_write_v2() definition, and 
make recovery path to follow the same idea.

Thanks,
Qu
