Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD34748031
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 10:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGEIyl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 04:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGEIyi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 04:54:38 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290A172B
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 01:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9NplYzG9WH4KoYmrYDXzt4ShZi9abyFvXrnBX1i8L6NSPL9VXnc69lQ/Q0RbBVJR0yyMGz/eeNZWxxH+nL6P3IjAQdi55WeVjpNK8QuDlCeF0/4gX/OXZ59TiI4D1VYaTQ953di6S0Jh3aeFS2GdS1XUVKbSdkzOhqPVsz3TuA6QP+UmAfIt2OT5O38EWjomzHWcGZPvyfof3n0RAxrzHGqcJfKeHoTf4CoQwDTVJy4LtMcc+Zqw3O9djrhUft6pAVbpPkCTItBJTO1pd9M+cY01WZnhVXTNWqC93QilgykRIEJT1a5nCEavnKHi8T9Q9TJOQN05TmpLaf41H+FyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUZTDMnBKU+x88U/nRznkbh7EqcEuwI+//0TK+74BY0=;
 b=EqOlG+dohA5VqTRuXkb2wj77x5ztXEnAk+KLUZ6xukP/IsV7CaEoal/nFx6VylQ99FpJ2WgqXZjkQ126Mg35a+hPvDNgaS7F446IumHlfwSCVmUnj8w0eALhjfiW0nHqzvfpNs3cXO3u8oqxkDYJTTryjkzreJEihlybbtZN3L05BBwqYiGtNGZ5tO8Q/MVkkK+yp9KInmc4ywYcsdhxMu+iv8d9Qn0dYNu5h3asYWVWXu5Ze1/0RT8nRDX9/1F1wt9HBjtMMF4qu+tWYQ76M5FPJFzLJqMt9WOwLAZGI/ZhZ0sXo8Z1ibOwmWeF5L3lbW+P/deye3WNcLTtMfvKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUZTDMnBKU+x88U/nRznkbh7EqcEuwI+//0TK+74BY0=;
 b=nexFNGGGjxKLDD1abKeDzZW4K9RoZJF/DnFJCQwWoyaHHKZTp51SopMCeuzbheDwBS7RsvBocyb/LhlO8n1gcCQbOdjMDXxLMaElQmWVbwQr8uc5sHDB8x7ia1dk0nRcIG1ECKdbBPKkCroJlk5AMLlgZ0cJ4KUG2Quq/XWVDBIg5czZ+VLJe147njg+DPVT9tCopxMzybpvHl1SPkKcR8znDhMDrt3nlZJ+AC6xLPBUYddM5dJiTCvi7d772EvpzD8vuUdWue3MYtJokThnjxxnvZ08hd1XU35fR7Q/osr/LSwOql+eWye/f1Cq+12TJcVKEgsgcva8oOYCdMFYBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:54:32 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:54:32 +0000
Message-ID: <a7433314-802a-f713-2519-1baf627ad153@suse.com>
Date:   Wed, 5 Jul 2023 16:54:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
 <1449f988-b5f6-3a21-eea0-44298ed7dd42@gmx.com>
 <96a5d8e6-8905-231a-b55a-876919c60694@wdc.com>
 <1513dfe3-8d58-a511-5279-c6bf1ecd0e0e@gmx.com>
 <76b099ac-ea2d-2237-fd06-72418c1f2492@wdc.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
In-Reply-To: <76b099ac-ea2d-2237-fd06-72418c1f2492@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfe66b2-813b-4955-4e68-08db7d357342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RwOBpMFPjieqnoNDep0mPrO5z1aGe0MCw1vRqyCHteNwaU+jrsGEXyc+83RMAudRE2kAlA2RnugdXZIMwuuOSiNcYr0vR0U4BvNT27Z4Yj9o3E0QGnTk+iRQdU56CqQlL5GrLIXdvo5aY6WwwrjPpr94tIgx9e4CO6V8hWNvI80KVfFDQa0QF7y7hK4VYtfrejKsHBaP65+i0+EXka73we2sLuyG7skBRijYjaR4vAzlPGR4iw6eEcvncWTTCQZR2S1qqjT93mFqLWSXoSBAREDIag1uD9yESjGbqEaYx3M3FRrN+nqvmLiWSw78jrFYgRm3f6EFREUXd/dza3MaBf7w0+AEDHsD/iZd86tRtvYwhTzNreq12bw8yGhqjkKUUe8ai5ywdYn4Uzcao8JzP/qzWbc2eZC4lIS5LTlXSKKIgT8CCKe6KeHbTFlJys8xTIqD6LTnHMo2zWpJtfxclQwib1rrGW7JC/J/Drv4v61ZieH2BZhAxiPPKPYekoxGqKRFz0n1CNY/IJYMknE3kHiV3nsnMDfWaO+KMPRSZ/pwHyZQcNDiKTUvUSzOzuY2GK1mJ5EVR5uJJDiSt1+ODDZ6F0sBluU+tXc6FtggBcIoqDAcb2PZd4CJEAi8JJ4ktueMgX63sz+OibcM8eXgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(6512007)(6506007)(53546011)(66476007)(316002)(38100700002)(66946007)(66556008)(2616005)(83380400001)(186003)(478600001)(110136005)(2906002)(31686004)(8936002)(8676002)(36756003)(31696002)(5660300002)(6666004)(86362001)(6486002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZTRmpVdG1HWGp6SE04STZzSW1ENktwVndDU29OVHVUcFlmNzRuM0tKMzhL?=
 =?utf-8?B?QVhCMm9kcnM0WDd4TXVEc21aT0pxZW5INU1wQlpyMGJMQUhHRTE3K3lRZGx1?=
 =?utf-8?B?SmlXenZEb2Rqa0xOM01YdHFjaGhJVVJBK0gyWTlQWlBmQkF2ZkJDMmROZEp4?=
 =?utf-8?B?NW9IQlkrVHN0TS8xVktQN0w1bEZCZWZ1eklMVktZS1Y2Y3FXT0NGVlVRaXdB?=
 =?utf-8?B?ZS9VbFlNQ3dCUG10Z2tKK2ZBZ2lpNVZZUjVaRk5MWWxjbU13d2hKTGpjU3dV?=
 =?utf-8?B?WXNQQXlDeHk1N21SM2hPQ1IxSXNVZEZLTyszS3JDdElTZFV6STV6ZGRHWWl2?=
 =?utf-8?B?UnBLc1Ywd3crWm1INHRWNEVEems5bGFDc1JGalNDNVB6WEdPZUJrenhRa1h2?=
 =?utf-8?B?d0lZUkhLVE9BNU45bEkrKzRrRS9nRGxrbnAzdXFPNmRVcTFzd1Z5VzEyZXZN?=
 =?utf-8?B?M3lsb1NlSEsrQjFlMHlINFEwcmJONXNIaDZnRWhjUTFDOXlxdkN6Y0VVYlo4?=
 =?utf-8?B?by9Sa1dXcE9JRlZRd3RPa1dMeC9oVVB3NWI4eHJ5L0pvakZjQi9rL3pNNXkv?=
 =?utf-8?B?MGw1ZXRWVnQ1dS9MNFdETk1MTHJzVVJZWkxFcXRjanhHRFdpc1NYN1Rjc2hU?=
 =?utf-8?B?VVk2dWhhWlRvVVp3RG1yQjZVejhuNXhYR2d0Tmw0Y0YrSGhZWUtBOU5jZWk0?=
 =?utf-8?B?YldwMjJJMU5IeVNkNlFrRUx1SFpzS2N0U2FnQWRnTHVaem1KUlllZjhVQWM3?=
 =?utf-8?B?TjY2bmpRQ1dubkh5VVJLMFNhVFJxeTNHbkVFT2VEOU5VdFhveWp3OXVIei9p?=
 =?utf-8?B?a2JLMzUwc2lwUHF3c0g4RUhaT0VnWHlPTEljazRoblBIZW1iNWxXOWt2MWFC?=
 =?utf-8?B?WWZYb0NaeGxTcktONHNGQmlPbXpmZEFleFdnMnZ6b3pLbFdRcU9OR3VQSkVs?=
 =?utf-8?B?VmNTVWpoYVBlZWVhb3I4Y3JhMGtuK2pjb3dIcHA2ZEhaL3Z3a3FMTEprd3J5?=
 =?utf-8?B?OWNJQytmUnhZcGl1ajE0UWtSaEtNdWF3WTA4dmY3ZTJmMEU0T2kyVllWeWdn?=
 =?utf-8?B?eVE5TkFTYkM0MDJOTFpBUW4ya0hqajhlWllYWDVNTWlOeS9JdmIxS3FBZnlQ?=
 =?utf-8?B?R3d2RTBvbUZGOTlWNUl5Z0RFQ0JSTVRsdzZWdXJ5MzM2N1NXaWE0ZURsYlBN?=
 =?utf-8?B?TnZ3R3RkeU9LeDZnMGI2Z0ZaL081SG5qUXQ2cHJML09NMHpjSUF4UStrUmN4?=
 =?utf-8?B?SEFneGZ1OEhFLy9TRjBwaGprSTcxRWtGbjNKajJJd3pLQmZRbEFKdEFoOUJH?=
 =?utf-8?B?cWhaZjJyWnNTS0dwUzJHRlRiMEUra2h3UGRHekFqVWdxTXBGTHJaZGdyTUQ4?=
 =?utf-8?B?MDFGK2JWOVkvQ3ZRd2JxSXc2MHM1cldnUEdxamxYUjdWbkNGOVAxRnVLU05U?=
 =?utf-8?B?SDNlYUp1N252MExzNVlkaGF4Wk00ZjlBK3E1d3hpVDJ0TmdiRjVleU1Za0FV?=
 =?utf-8?B?cTM3aHNCVUsydGNBVkIrcnZwUWwzTDhUOW1iNXRhUG5rZFVBVTNUR2lhcGpk?=
 =?utf-8?B?S3VLSGlaNTJKQ2RDOXNkWWt0UXVoQSt0bU81T2cyU3Q2MDNQV0RZWlNSelRQ?=
 =?utf-8?B?OW1OYUNBRUFCU2lQaVplTDlFVjhXOVlWZ3VnOW5RL3o1ZXdPQ21Vc1Vibk80?=
 =?utf-8?B?YUtaenRjZjMxTE1ZdEdOSGtRRTVaT0hIbm82T1ByeGtWa0picWI4cUZjclp4?=
 =?utf-8?B?aW16SDVMeE9CK3dZUjRiTWNHRnlpU2xzN2JTRlN0bjFqa0daUHdJbHZET3VB?=
 =?utf-8?B?MSt0eE94cXdsWGJIcWh2UzdiOEpFZlJKNTRvMzNHVkc3cWFSd3RUUGJVWTU4?=
 =?utf-8?B?cTZjNjRDb2NlaTFjSVpTTkNiM3phblZIRzJXWDhSeWJTRmg3MUhIZDErNk9B?=
 =?utf-8?B?UitxajNJM0FUYytUSzMvczluTnRFZjFhdzQwNzRGRUZodUJ3RjlkcmRjbzAr?=
 =?utf-8?B?MFZ1OE5SWnhBeUFDQmIrR0FCWk1SeEZvRzU0UG5KUXJtM1V6bEYyK1lsQzhZ?=
 =?utf-8?B?cTF2TE00MDJWaTNsVE9jdlR1N00vYmtmSkVmTlpQaCszZDJpOG5zRUo0cGdO?=
 =?utf-8?Q?Us5U134QAXTWrTPnpuXFJ0u/W?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfe66b2-813b-4955-4e68-08db7d357342
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:54:32.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU7bAjLKUrKS59UB6TIL8ShLbY0RJS0QJx5kelcQENU4ZkG5RIQqfD+xIFDCjto0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/5 16:42, Johannes Thumshirn wrote:
> On 04.07.23 00:41, Qu Wenruo wrote:
[...]
>>
>> I can craft an RFC for the use case soon.
> 
> Did you envision sth. like this (untested and needs cleanup of ASSERT and
> btrfs_chunk_map() call but I think you get the point):

Yes, that's exactly the idea.

Just some hidden traps in my head:

[...]
> +static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
> +                                           struct scrub_stripe *stripe)
> +{
> +       struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> +       struct btrfs_bio *bbio = NULL;
> +       int mirror = stripe->mirror_num;
> +       int i;
> +
Unlike the initial read which should only have one bio flying, this time 
we can have a race where the first bio we submitted finished before we 
even submit the next bio.

This can lead to the delayed work to be queued immaturely (and even 
queued multiple times).

So here we should increase the atomic before we enter the loop, to 
ensure any bio ended before we exit the loop won't queue the work.

> +       for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
> +               struct page *page;
> +               int pgoff;
> +
> +               page = scrub_stripe_get_page(stripe, i);
> +               pgoff = scrub_stripe_get_page_offset(stripe, i);
> +
> +               /* The current sector cannot be merged, submit the bio. */
> +               if (bbio &&
> +                   ((i > 0 && !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
> +                    bbio->bio.bi_iter.bi_size >= BTRFS_STRIPE_LEN)) {
> +                       ASSERT(bbio->bio.bi_iter.bi_size);
> +                       atomic_inc(&stripe->pending_io); > +                       btrfs_submit_bio(bbio, mirror);
> +                       bbio = NULL;
> +               }
> +
> +               if (!bbio) {
> +                       bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
> +                               fs_info, scrub_read_endio, stripe);
> +                       bbio->bio.bi_iter.bi_sector = (stripe->logical +
> +                               (i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
> +               }
> +
> +               __bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> +       }
> +       if (bbio) {
> +               ASSERT(bbio->bio.bi_iter.bi_size);
> +               atomic_inc(&stripe->pending_io);
> +               btrfs_submit_bio(bbio, mirror);
> +       }

And after we have submitted the last bbio, we should decrease the 
pending_io and check if we need to queue the work:

	if (atomic_dec_and_test(&stripe->pending_io)) {
		INIT_WORK();
		queue_work();
	}

> +}
> +
>   static void scrub_submit_initial_read(struct scrub_ctx *sctx,
>                                        struct scrub_stripe *stripe)
>   {
> @@ -1604,6 +1646,21 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
>          ASSERT(stripe->mirror_num > 0);
>          ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
>   
> +       /* FIXME: cache map->type in stripe */
> +       if (fs_info->stripe_root) {
> +               struct extent_map *em;
> +               u64 map_type;
> +
> +               em = btrfs_get_chunk_map(fs_info, stripe->logical,
> +                                        BTRFS_STRIPE_LEN);
> +               ASSERT(em);
> +               map_type = em->map_lookup->type;

IIRC we have stripe->bg to grab the type.

Thanks,
Qu
> +               free_extent_map(em);
> +
> +               if (btrfs_need_stripe_tree_update(fs_info, map_type))
> +                       return scrub_submit_extent_sector_read(sctx, stripe);
> +       }
> +
>          bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
>                                 scrub_read_endio, stripe);
> 
