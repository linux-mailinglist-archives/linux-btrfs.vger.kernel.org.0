Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663B9736B90
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 14:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjFTMGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 08:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFTMG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 08:06:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D41709
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 05:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmWftRLhaWH3CaU2UeLWXlXecqtfHX7Cb/RFuJ7PneKITi0YBfN6feoskWDn2gYkzbg5sgMH/R+9gnMOgA2hf2KAwdEgXoCrpiOq8Dsx/hZBvwYa1x3/XJkDDQmb4vUGXf4K8jCG7TExpYmKnwzXUDNDYCRD8KXFQQiY//VgSFeSIjWHYF3fOdh6yEagxaGU8/3QzMZZ7BVe7DOyPdyDtiBT1ITQFCwJ7H7pzkQcKt0JDQ7N9TH4HfOf7PlJhnw7AyGjtimgS4D0FTE62Uvs/8gPnXoW5Djy6imdANskZinnIQnbiYZGM8+iW1PV++BKc63bk3PnOh3iBqWPtpPpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7R5J62WfRvCRPEVYYJ52HjplWfUuCnjnPVWPoChgOw=;
 b=nlpjDDgsgGsoMdmwL2/hjcuc+sVwUz3Xx+KEBLyZRtlA681aqQmR7ue9x4ArReatNr/R0k7J+cqPDgHw2NFUnXhafyPowwnEZ9jIbBw10k1xiCxNfqjaBwzLysVB8Diyhna4tYdxiaww4ll1NAwd6okwt7awkiD/L9KiAr9MkoadwR0Z3kWA1ynD+BakoBxF+f8i8whDm/Jjkm/En222+5HGGRXE7dn/Y8t1N1GM1mJ2DsS6zbQNT6szhXP2dONFIqjbWMfhBNdAlhO+fQmIRaGPRLIsdkg9DMori0fkeS7gReruhhxE2fT0aBuqYnO+L4yqrKvmmFOgm1qfX9eruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7R5J62WfRvCRPEVYYJ52HjplWfUuCnjnPVWPoChgOw=;
 b=KorygtYkNP6RuQEytfgynRzfFYUgHNUJ6dAhTKFHfs9ZkHclMCMocXjDx/GWkz/sELKSsS7fpnsQ+tF8yHGoT4ZD1hz4e8yr4EmE806DM8u11GwVA2ik025O1vI+ciLzvO8IVlQFKBovIe4MKxB3PtzXrmE65b/Nai1gx91M6Y6zCZZNlC6K43nkyshRVgGy6r3oVc2aiZVuxAc6hLsaWsx2GnGHpXwlA3doSVI/VIyOgI3SN4X41J0UfVSHHw2/e/2sAddxf7hDkDyyKHlF5f0rjhQj8021zmh68ANgVuQnykpvbr3L+SHgobWmUTm7xc5D5lgVqSNPsbXoDKUfwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 12:06:10 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:06:08 +0000
Message-ID: <c9b1c74c-e5af-5c70-8939-64d0360a452b@suse.com>
Date:   Tue, 20 Jun 2023 20:05:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] btrfs: fix u32 overflows when left shifting @stripe_nr
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <1974782b207e7011a859a45115cf4875475204dc.1687254779.git.wqu@suse.com>
 <20230620102743.GI16168@twin.jikos.cz>
 <fd37dee1-0597-ef23-67b0-9cd0b3c2f780@gmx.com>
 <20230620115641.GJ16168@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230620115641.GJ16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::11) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: a34bbd35-a19c-44ee-48d8-08db7186bb0d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlbLqgRRkwz9eMmJDmm77Em0KA62XAuTJ3wef5lQoyVuqwmgYwxAs3qdc45q+z1bkHZOrWc8tI9kHhMPgy3PkzyvIx0xVuhFLcGZq2jWkiKvrG8njSUZsak4A7wvDC5A8+WJLHuv764nDHTuejUktLXIjE9yMIPWhTf4yY/RiMouID/xctk6AZoWZ7iTunEnBaS/hfzAEq5QJ8sQgerXLPy7rCoDkDK8MSQ1arzUQ5qlCnX2haj5a9nfhzAXImTNy0T+FqpAEw0BM3qTxN9Lg7spf19gpwrgA/cLgtvibhk2KOJjiVdlLiL1NQkOGhVVPYDCd9RGMLbl+rKZJnIssjjZWgPDJ1CSFzomg/+jSyXdzmFZp+PON/4bwbbZYpc3aQ9hJXYBTkaClIEOq94JKSXucbXR4FGSYC3mnD97/8anxlpaLda7s3WamxXM0IRvGJ3IOgTB8rboC8+6HcBWw6WNupmrOxKWdiR3hBbH0ryKJawnrAKd39WauTam66afTSP8R6lYx8A3NFU11Pfer2clDspdeytuxizPBcKygmUFtB9lFY29uD52OrwgtfaUTb+hBYfod8tM2zhW46xSPDPTaVY1Ss9gbOnPzetw6VlWYcOtf/zwqmIPNHhRq6tQlz5FhDIaw0+PnqPOhM2QtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(86362001)(31696002)(36756003)(38100700002)(478600001)(6486002)(6666004)(107886003)(8676002)(8936002)(5660300002)(4326008)(6916009)(66556008)(66946007)(66476007)(316002)(2906002)(41300700001)(31686004)(2616005)(6512007)(186003)(6506007)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW14eEpibTI5K3c4UU1wVmZiNUN2b0xKaEgzQm1NaFBreVRrQURXdU01aGhv?=
 =?utf-8?B?R0l4SWZrOGpoMHJGT2x5bGxWN1lJdUJYSURxdUFPZE8xYmpia2VPK2tJRXFU?=
 =?utf-8?B?R2kvNlF0M1NYT2NJam9GMGI5RW9nYW5NWGYrSyt5UTFKRVk4aEJ3NkRhZGll?=
 =?utf-8?B?UEE1NGJSMDdNNmcwTWZXT2F6ZUVYWG1yelhIUHdyaDhmL0NRaUNUaFc2ZTZD?=
 =?utf-8?B?TTkyYVZmanNLMUVtN3pxb1ZQRi9XOWNtNHFrQTZkd2NEMEc5ZDBxN0NlM0Mw?=
 =?utf-8?B?dGRNVFM0ZVF6a0JBZmxuLzAvQkJLNHA1cDgvM0llMnJlcVY0MWZZWHhuZk92?=
 =?utf-8?B?MkN0MERoZWp1UmVhYkZmRDVkSlZZM0h4SXp1aG14MWw0YkZadFp3b0FVZEhH?=
 =?utf-8?B?cEJEcjQ1KzJUTzZZOGtxQ1JsMGFZZVdRVmJZbDV3QkswTDVOSFZQNkI1bnNl?=
 =?utf-8?B?emRuekN6WmloZGU0T3ZpNGh2L0xzZ0JHM2FMSXk0amRwL2FkdDhqb0VPWlN2?=
 =?utf-8?B?Wm9IcFhvSnVNeU4ya1d6MHJmRm9yb2Z3YWdmaGdQbG10M0hOUVdnT0U1VWlL?=
 =?utf-8?B?VTYrSitjZHJPRVEzUjZneE9vTzZodGZoaGtQMGwzT3pBVWp4SlBQY0xYYXpN?=
 =?utf-8?B?Mzh1dXVOajgzR0lBK29PazFKWXJ0eWpCNGVJNWlhZENNY2gzL1pBeWh2OUNO?=
 =?utf-8?B?eGRLcGRhYVpYa0FvbzZTTnNndHNFT08wZ29hNDRUQTRSWWRUN01yYUpWdWVp?=
 =?utf-8?B?TUUzNThKUTBYL0k4eVhPR1p5Ymw3VTVuMWdhd05iSG1VbjhVNS9QU1dpYVQv?=
 =?utf-8?B?ZnBjRm9ZWThob3hHQllMYWVnelZHWkVWcDRwRUtmUU9oYnNPeDRPYXpzcEcv?=
 =?utf-8?B?Y1lmV0tTdktNWVJmaXZuNUx0cVJWVG90OW9OT1VWVHhOdmRsanZuV1dzSlpT?=
 =?utf-8?B?QThFVHoxc09BSDhGdGN6SUtTR3pnc1ZxU08xbXhJQVZhQngwSUpRbXYwUnlq?=
 =?utf-8?B?QkJCQXU5blA4UngrdXJjWjdTclQ2TFFZcUtYd3BMMG9SemoyTFA0Q015TmNp?=
 =?utf-8?B?anZrTnFkYmY2MUw4VVF6TFlVQU5xZmh2S1c5ckh2UURSaXYzKzFSZjAzbVhT?=
 =?utf-8?B?elFBTkJwRXk5TDFNWldVS1F6NTBjWDVXQjBDSzVCWkhYV0ZpdTNPMWIrYkJz?=
 =?utf-8?B?K3hDVmpSM2VzVVl2VCtDZUVWTTFCTVlhcEFyWWdpZHNZb2dqcXc0VjRtRmZE?=
 =?utf-8?B?SmJFT053MHgvcHpOajZxUVJ1a0JySzNnbHdoTWRNMUZQVFN0Y1c2bGtIUHBG?=
 =?utf-8?B?TUhEVWw4dFF2dDIzalNEdkxneVA3eGRYcTgvYktPdHVpa25wdklwMkVTZVVF?=
 =?utf-8?B?RlVRZUY0T1ZXWUtrY0dPVlhHTlcwREJneW1OZVhwbkdGeUNMOHMzcU9HL0ZM?=
 =?utf-8?B?aWRmQTU1VFVSWDlUbTdJSWFGbUJkcytOaTN0dlpUdVR5WXpLdHExeURBelVp?=
 =?utf-8?B?aE54WmpDdVpjdkdZUmdzYXZwWmp1T0VOT1hmZTdscmFQZnZxYXp3QWZROU51?=
 =?utf-8?B?Tzk2UmdOZVFFSk9ubDh3b3RjUTltR04zNW1uRnV4RkZOSHd1Z3d3ZkNSSFFQ?=
 =?utf-8?B?Y1RpeU1BdERrUlUwSFdyWDJ6WDJGTFhvNHIvR3BGUWxqWmJySW9vZkYwd3Zy?=
 =?utf-8?B?dFlXR2FYWWZtbVYrN3ZmejA5WFl2enVFS1BOTjFoa0lMQ051WGxDWC9CSHlm?=
 =?utf-8?B?ZmtyZklVSldUY2ZIK0QxUTJlaHl0YWRBTE1ldStPNXhydEcwTDVQM1lmNnJG?=
 =?utf-8?B?bmUwQXRCc3dCVGFwWjhPa0Jla09ackNIUnVUb0JkeGVkZDRsMmpiSzVndEpD?=
 =?utf-8?B?VG1sN1lFNDBtRUVxS1JsRUR1Ynk4TGh4SVM4TDRhc1N0SDRiSVViRE93TFdP?=
 =?utf-8?B?a0FTR1BMZXp2ZHhJVzYycGRzQkM0WTk2a0lIMnErRXRIRkJEWk1IeGJ4MjRv?=
 =?utf-8?B?SEdlUFpVN1NoeU5Rdy9JY3d3cGlMOW5PM3ZVR3E0WGhXMVhBbDZHa0NiRGJq?=
 =?utf-8?B?cGJER25ZeUtIVk5oaFFockdxUGp6QUZlVmcrU3JmQmpPRWdxVzk1Nno3bE5j?=
 =?utf-8?Q?zqlgmcNIKgX8jPf4h0rnI4R8K?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34bbd35-a19c-44ee-48d8-08db7186bb0d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 12:06:08.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: layYOidPRalrE6PGi1etOiKbGdiPIVeyweQO8OalafhEcrHMwI8Z8ufUWbd0A6Bt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/20 19:56, David Sterba wrote:
> On Tue, Jun 20, 2023 at 07:24:24PM +0800, Qu Wenruo wrote:
>> On 2023/6/20 18:27, David Sterba wrote:
>>> On Tue, Jun 20, 2023 at 05:57:31PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> David reported an ASSERT() get triggered during certain fio load.
>>>>
>>>> The ASSERT() is from rbio_add_bio() of raid56.c:
>>>>
>>>> 	ASSERT(orig_logical >= full_stripe_start &&
>>>> 	       orig_logical + orig_len <= full_stripe_start +
>>>> 	       rbio->nr_data * BTRFS_STRIPE_LEN);
>>>>
>>>> Which is checking if the target rbio is crossing the full stripe
>>>> boundary.
>>>>
>>>> [CAUSE]
>>>> Commit a97699d1d610 ("btrfs: replace map_lookup->stripe_len by
>>>> BTRFS_STRIPE_LEN") changes how we calculate the map length, to reduce
>>>> u64 division.
>>>>
>>>> Function btrfs_max_io_len() is to get the length to the stripe boundary.
>>>>
>>>> It calculates the full stripe start offset (inside the chunk) by the
>>>> following command:
>>>>
>>>> 		*full_stripe_start =
>>>> 			rounddown(*stripe_nr, nr_data_stripes(map)) <<
>>>> 			BTRFS_STRIPE_LEN_SHIFT;
>>>>
>>>> The calculation itself is fine, but the value returned by rounddown() is
>>>> dependent on both @stripe_nr (which is u32) and nr_data_stripes() (which
>>>> returned int).
>>>>
>>>> Thus the result is also u32, then we do the left shift, which can
>>>> overflow u32.
>>>>
>>>> If such overflow happens, @full_stripe_start will be a value way smaller
>>>> than @offset, causing later "full_stripe_len - (offset -
>>>> *full_stripe_start)" to underflow, thus make later length calculation to
>>>> have no stripe boundary limit, resulting a write bio to exceed stripe
>>>> boundary.
>>>>
>>>> There are some other locations like this, with a u32 @stripe_nr got left
>>>> shift, which can lead to a similar overflow.
>>>>
>>>> [FIX]
>>>> Fix all @stripe_nr with left shift with a type cast to u64 before the
>>>> left shift.
>>>>
>>>> Those involved @stripe_nr or similar variables are recording the stripe
>>>> number inside the chunk, which is small enough to be contained by u32,
>>>> but their offset inside the chunk can not fit into u32.
>>>>
>>>> Thus for those specific left shifts, a type cast to u64 is necessary.
>>>>
>>>> Reported-by: David Sterba <dsterba@suse.com>
>>>> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Fix all @stripe_nr with left shift
>>>> - Apply the ASSERT() on full stripe checks for all RAID56 IOs.
>>>> ---
>>>>    fs/btrfs/volumes.c | 15 +++++++++------
>>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index b8540af6e136..ed3765d21cb0 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -5985,12 +5985,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>>>>    	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
>>>>
>>>>    	/* stripe_offset is the offset of this block in its stripe */
>>>> -	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>>>> +	stripe_offset = offset - ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>>>
>>> This needs a helper, mandating a type cast for correctness in so many
>>> places is a bad pattern.
>>
>> The problem is, we still need to manually determine if we need a cast or
>> not.
>>
>> For a lot of cases like "for (int i = 0; i < nr_data_stripes; i++) { do
>> with i << BTRFS_STRIPE_LEN_SHIFT;}", it's safe to go with 32 bit and
>> left shift.
> 
> The helper is supposed to avoid deciding if the cast is needed or not,
> so the raw "<< BTRFS_STRIPE_LEN_SHIFT" should be abstracted away
> everywhere and any uncommented occurece considered for closer
> inspection. If you have a specific example where this would not work
> please point to the code.

E.g. for the code inside RAID56 utilizing the left shift, they are all 
safe and no need to do a u64 cast.

Yes, I got your point, but for the bug fix, can we split them into two 
patches?
The first one introduce the helper and fix the 5 call sites, this should 
be very small and easy to backport.

Then the second patch to convert the remaining ones no matter if it's 
safe or not.

Would this be a reasonable solution?

Thanks,
Qu
