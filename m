Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC495EEC59
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 05:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiI2DNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 23:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiI2DNn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 23:13:43 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00070.outbound.protection.outlook.com [40.107.0.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA45127549;
        Wed, 28 Sep 2022 20:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJJedoc7b9tEqEGf1gr9fw5CRBpWe3RGCWoiuyhBw8tObjjoC0bu02FvGMVcDef8B3zhB4xNfvsmExvRsFJF1Uin/kvj5PYfp9RHmQFVPBYYwppCTslQ+NFjmkjQVKfSwQNqQDNitbN665vRVQvlQHpVxX84s79crjnHBfeZFaYyiTmvxcVkWpMbyX/ws2bNncZ6MdhC/kx8L5VlluTGbjagVtKW/riq6q29DVKztBQb9dewXvWUVBg+cvjA0YHFgS2Py72lSPyc8+rFRWd9aeA93EMrbmBBAjp7Gw0qRv0JnqwW6GEMkt+MefkDif12NmwDe7e7NQ9ZGVHeQ/17Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmmTBNX/LM9ruv6Ar9rOGhJ+QlAug4/fObhcPTRdjhQ=;
 b=J/QcaFj30FpsUN25yyPfhF8Nt9oIH4WcbWXfWxjqLAekCAE/nvC6InXvA1+UeAJtbpt8ImaOLpY2YEu96uMhhFqxN/M9yJpg0a3VkPaHnIawUUb3ntjkeScwhMN1NBSBMJZRfDewtY7JkQ6Wp1pptXYXVJf9lpomB49DE+ojjgx+bPKmmQK0ZRFdgPUcz8ytOP5hPkWDd2TDFC0Mm3xYZKRXwLrkATyfSv+20FLOha6V66oaa3QzQhhkxPIiAvQcf3TmW2S8aymu3XB8l0Sf16n8hA5KUcHzcjCoSG90Eqn67xXiMA9ZBetrzIBfeyuMxheXRz8cxjwy/PF5NF7QZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmmTBNX/LM9ruv6Ar9rOGhJ+QlAug4/fObhcPTRdjhQ=;
 b=mN2H2YrOzFICSOs+rBxWzeiMstl/8xOb9zWvPbwavyrJRLJoy9kxk1P5lyAchHkhais00KJeU0jr7zYhj8FNhUdXoAq5W2iUaz3mxWPROyLjB1Eh2WdjtNfF8ovLhP5y6derxS9uDxXIbURRE7zZjdKuf3l9KM8TogUFBN08yHtEV7Ef2QDdyNEmjy88U8JfeDvunBFZHPW5EeRC3aR5AWxjKaltnssD4uWycTzM+Zw4RTyXy6ZpyoTphOmt+RECZtnPR/VcD+5jSJhB3ef2MWVXJw9uj3V3QBNJhGAnBrYbRk9r4Po+ARaMr93XCoeR4MaU17U0EshVSutV5DbexQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 03:13:36 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 03:13:36 +0000
Message-ID: <18acd4e0-9d3d-77a7-a1de-b805bc259bcf@suse.com>
Date:   Thu, 29 Sep 2022 11:13:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs:remove redundant index_rbio_pages in
 raid56_rmw_stripe
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     stringbox8@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929014402.2450-1-hmsjwzb@zoho.com>
 <c4293742-06ba-8720-e2eb-d4d3bc4da044@suse.com>
In-Reply-To: <c4293742-06ba-8720-e2eb-d4d3bc4da044@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a5e1a9-fe8f-4e8d-2763-08daa1c89964
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7ZSkXv5YeTgm25p078tdI3gbHjAfolZbvoW++nGwgz8cDULpfpqDlToAAe+pXXs0viOR3h/1NMmKRp7IrkwaQZuGTCj7CTEdrh+UJ795vnEfg8UII1hw1RuBXtvHSmhgMJLLgme13naI3MPonSL+38sWI+WdGEPorX+7fW46NFR/jQipZv5zgv9GPmowNmup3axcYyXGXWTxfICwaKqfecRn2xaHaZaQQSqNYQtIA9mnWCx16NmfR7c0vgFJgzARwdYjT6wkF/QXbeA/tAowQk9CgSUM6lGOme1zcIHbg7AHXnx+8gGV/EydM2gTSDJAEdmgvzeo83kWaInQ9sQnh55mbVT7tfEGrrn0QtCBNTA3XO4iUW97J+pywo0WB13R1qHRX754zwdkbZL87QoQdBE5QiSyRy20Hpi36ggGoLfnL4SUD6Kvj9AaanVaqBDB4xhoSjFJ2a7+Wi39yobjf8nWa/EZ2OfuEQnj+Klv0SkddiUYXZ9jhMgElEPVzJ11gKewdmKq82CRiXgSO8U2F8ObeUyRyVGPDPN2qh9QsZfAFCvSiDq6G8+3oj74F7fA+0HWqPJeI7Oa//wFXuROnLxJ3US47MIiqhIqW4Hnwd3/RgEgCiFi1mi1UmvOblffiRsTlSPBRTjy6t+888RESzpIG42M/JlFeD/yHTXwmYOTKHhle44XwcfCVawYE/01QUDGZ7TLSxsF58rxNk/JX1trRnPp6OMyoR9BX8ZY/xS/RRe0ICOh/h+gwv+gIihsUDBrzimxtQqOMKIvPGGh3Rm1TVjnJC/ZTeqoFtjj2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(86362001)(36756003)(31696002)(2906002)(8936002)(5660300002)(186003)(316002)(2616005)(6916009)(54906003)(6486002)(6666004)(478600001)(6512007)(66946007)(53546011)(6506007)(8676002)(66476007)(66556008)(4326008)(41300700001)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09VUzNJQm5GeUd0Z2E0dCsrRTdGRENqQU1mR0RlYktkSk1uV1Nwd08vVGNa?=
 =?utf-8?B?YlVrQjlKMlpkdDBMbjZ5WCtvSGpyUkxXRk9XZTVwSndrOVVtMndWOTVrTHN0?=
 =?utf-8?B?ZU5FZ1gyT2todXFLaXpxdjVBZ0lPZ3Z1Q1NnVS9JMm5NSUpCNkVRRFRFYmR3?=
 =?utf-8?B?blJCendnNGlVRGxIeTRtN2dLMGs3YWk3TGhBVjFpcnQ2NTkwN0pVUTNYMVA5?=
 =?utf-8?B?czJwSGVtTDBDODJRbGpMNHRZZmVYenQ4cEFTbW8wUzViNnF3NUFkTVRicGFx?=
 =?utf-8?B?REtDQ1g5RitZMHlub0xpVEhUSWF1TTFBUkdmT3k0RWgzU1I4Qmlma0lvb1p0?=
 =?utf-8?B?UGltTjVrWkZVdGhrQ21obExvYTMyWit6WGREK0FNZXFQV2dnZGdjUzgrWjBt?=
 =?utf-8?B?aGlDMENlQkhTUXNUUFhVdEl4cFZTUVJRZ1pFdHBGemdWOW9GSnIyRWpXY25B?=
 =?utf-8?B?SmlpdmpqcGhCc3ZHMUZnMnE4UW8zbkltd1JvLzROTUZ6c2c1NFRMMzV3aXVj?=
 =?utf-8?B?ZUNrVitUWk1BYitCU3hoekcvcng0d0xhcXc3cnZZTUVyWitib3ZNZ1RiZVRp?=
 =?utf-8?B?Y1lsVFozemNHWkgxdW50ZU9CZFF1SEg4MmdzcUF6dVV3ZURaQnU3MXhQSmRC?=
 =?utf-8?B?WXZrVEdDZmFKelQxbGlML2E4aHc2VkpNQW9iZ1BaRkcrblowYVhkVkt4S1hW?=
 =?utf-8?B?VENBUG1DKzFXcEl1UGM2L0J1MVBxKzFEdStaMVVQTTJXUzRYMERKUENjWDhR?=
 =?utf-8?B?eGI2MnJhUTI1SWtFelZ6dTBoVXlHUWd5OW4xVjYyZlhPT09PL3RwSGdmS25k?=
 =?utf-8?B?NFB5N1dTZ0JnbDNlU0lINnc3cFJJNmlGWDREZjNYTm80OC9PVVorQWsyemtD?=
 =?utf-8?B?TG9rWitkYTlGTy8xOE0vTE1acm83RVdnc1ZpUmZHektsVDhyYzY1WnRvd1VT?=
 =?utf-8?B?NnI4U0JQYU5xSmN1MmZ3ZC8vd1FMN1BwS0RYUnhYc1RIU1lDL05kbFRhUTlH?=
 =?utf-8?B?Z2ZTWkZsM3JhQ01MSUJoT0ZNZ2RZc2VpSjFOWE5hbVp3aHFHTEcvRmhSL2tY?=
 =?utf-8?B?RzZzN0VZQ2haSDVNTE5Eb09USEQ1STRLdzd2UWJrRUdzOVpPV1c2ZE1nZUhw?=
 =?utf-8?B?WVFKUTBkNk9VRmJKeXlOQy9hMUwrUHVVT1pTSVlTYjU0TmJHdElXY2pyRWxW?=
 =?utf-8?B?RlFLMjFVYXdJWm1BbldYQ3VidW1QclFEL05FUkNzSFpWQ0FUMk5TVFpQTzVF?=
 =?utf-8?B?c0RiQm9taXZZR1k5bVVoUWFvZ0NWZGgwZ1l1M2kxQnE1NVBNUEpLOE16TGdN?=
 =?utf-8?B?RTdBekdJa0YvZWdodkU1MzlRYVF3R1paRGNtcUpZNTUzcmlRSkQrdVdtOGM5?=
 =?utf-8?B?Q1pEOXRIUkMwSW56RjZUQTZUd1dzMDYzbzlZdUR6Y2ZlYzJTMHZXZ01vSnFT?=
 =?utf-8?B?eTBrWGJpTzFwSkZGUHVlaC82SmZHd1pTbG1vdXo0bVI4QXp4YWhlZ003bm5F?=
 =?utf-8?B?ZjlJNzMreSsxM0NpcGhpc2dyU2pUZld2Nkt3eGZ1NG01Zm93SndkQ2MralhJ?=
 =?utf-8?B?ZDUwZUo2Vzh2ck1RTEdFQVV4SXBkT1RPZmZiYjNnL2FlWmU1cmlwNmRXUUly?=
 =?utf-8?B?TmVlYzBIYTRHSXdES056TFlhTWlTWk9lMjRZR1duT2gzUHc3Q3VPdHdxd3lh?=
 =?utf-8?B?SlhhWXBFYmpIbmE1NTVPTHRTV0ZveTUxZEdTVWdpb0tHYjVjVTlKSlFHKzkv?=
 =?utf-8?B?VjVkOWlkSEFubW1pa3p2TUZBWXJzZ1RPNm00TTBjNGs3UUp5WFZmbDZBejhN?=
 =?utf-8?B?a3VFYjhMbXZFT2F5ay9JK3hBb0NnSU5pNnRhZDJSTjBvSzBGUWRYTVdheUl5?=
 =?utf-8?B?ckNBRWdQa2MrWnB1TDhETHplZ0dnOWZaY2ljYkdvQlJaanczZzdvYXY3T0lC?=
 =?utf-8?B?R3dtYjdzK0gvc0tLbDBramtTUGoxQko1T0hvOHFnRVY5eUR3QkFwWTNxVVZN?=
 =?utf-8?B?a3Aya210U1NUelZPN0FqYyt3eFVNR1dZNTRhbWV0TnZNTytZREZLREVja243?=
 =?utf-8?B?eTc3WWR0ZzY3MjcrVEI4K3ZVN2RyaHZCc0dEUlVvTzJtYkFsMU5pZkFHRDIz?=
 =?utf-8?B?Njcya0FmNXdOdVdNSmNaU0pqczAwbmYvejByRm0rTTZhVGhOVEpHR3JRWlpz?=
 =?utf-8?Q?YVbl5ZFpvjAd0yX7G4lqtKA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a5e1a9-fe8f-4e8d-2763-08daa1c89964
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 03:13:36.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqDHWhe7Egs4NooU6T3nPk69QwmcNVmeG79RtvTNs6VMhiTvLh7t9PJuvYHyRxRn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/29 11:08, Qu Wenruo wrote:
> 
> 
> On 2022/9/29 09:44, Flint.Wang wrote:
>>    The index_rbio_pages in raid56_rmw_stripe is redundant.
> 
> index_rbio_pages() is to populate the rbio->bio_sectors array.
> 
> In raid56_rmw_stripe() we later calls sector_in_rbio(), which will check 
> if a sector is belonging to bio_lists.
> 
> If not called, all sector will be returned using the sectors in 
> rbio->bio_sectors, not using the sectors in bio lists.
> 
> Have you tried your patch with fstests runs?

Well, for raid56_rmw_stripe() it's fine, as without the 
index_rbio_pages() call, we just read all the sectors from the disk.

This would include the new pages from bio lists.

It would only cause extra IO, but since they can all be merged into one 
64K stripe, it should not cause performance problem.

Furthermore it would read all old sectors from disk, allowing us later 
to do the verification before doing the writes.

But it should really contain a more detailed explanation.

Thanks,
Qu
> 
> IMHO it should fail a lot of very basic writes in RAID56.
> 
> Thanks,
> Qu
> 
>>    It is invoked in finish_rmw anyway.
>>
>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>> ---
>>   fs/btrfs/raid56.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index f6395e8288d69..44266b2c5b86e 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -1546,8 +1546,6 @@ static int raid56_rmw_stripe(struct 
>> btrfs_raid_bio *rbio)
>>       if (ret)
>>           goto cleanup;
>> -    index_rbio_pages(rbio);
>> -
>>       atomic_set(&rbio->error, 0);
>>       /* Build a list of bios to read all the missing data sectors. */
>>       for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
