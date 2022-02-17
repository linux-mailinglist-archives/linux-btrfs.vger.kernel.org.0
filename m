Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE74BA10F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 14:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbiBQN0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 08:26:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiBQN0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 08:26:00 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4A2D224F
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 05:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1645104343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FcyKGztbOylVvB7Oqow+w0O9URiY6U5lb8nVMQYwLU=;
        b=CJnxFXEW3qgrqBpOhVxLF89Udtk4B2EP66SwcmJG272v+UJuxM/9/eGwjymicQCt/gYd5G
        WdgNu9hFDxLmrTpCP6kYWzTkO9lw3K3B3onaRwhP6S9dyvu7w3+Z86oeMmPV891ST569lK
        56TJYu3TjxMGg46bylQ6NM1gNPAy8ic=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-ELzAgDSANkeRfHp7eqXv4Q-1; Thu, 17 Feb 2022 14:25:42 +0100
X-MC-Unique: ELzAgDSANkeRfHp7eqXv4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWNILUvqpyDkPB/28kLsWe1WFKtXNRtUnRyhoW8pnRHENHlfcfboimYHUSPmAUHbniGSZmMDsph1X9uU4ms/tPC9n5SWzIdmH8DhcVMF9NQK6lz6ZlCkT/5xnpHVMdKHPErHkRFIZNr6ab2iBcxnX1qZomhJKbwiylMKTpc4SLHH/8+511CF66r3vnm1hikFhof+MK/vaD0Rd7QxC0rHFEuU3xD8d8rVn0OVh2xAA1M+jpGLPVmXXRfsnPr1Oi55k7a29T/F4DH0F1LDoLF3Jg/QPgwC9WUPBHV4aOgEFN9/MgoZfJpRcLnQbfO2ZaAkDxreTkUcjgIPHBKzmjOk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FcyKGztbOylVvB7Oqow+w0O9URiY6U5lb8nVMQYwLU=;
 b=O7aY/wJ/XeJp8eGRYn9smQ6CGHeBhsSm9txz6oTHIRrYvSnxGblqU4REJ8wpGVjO48us+DNlBBq4PvnZAZlQaNAkSm+fKVMPgP/CRgCG2YVptw65FRC5qe/6yg/dxt4wGue8LkOzPBlBMrjwK3ep6o7vjc0eGhf7KhePWJxDIIbj1q3BdUqbFtEYAKjQ4zpFW/7q5zeuQv4yAyUZaR3gAlNlSZF8SF2fimmNj35NgnN3IFERzuCbmCUTFm5tNNbzWhFCFdzckBtsx5G5qMaJyRc0+2mtk6hKz8ZcqqW9AjenNI0sIWcZPYusB41Rm6YKJf7Zf71ceDaSH8jHuuobIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 13:25:39 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 13:25:39 +0000
Message-ID: <cb3b778b-b619-23cf-7b07-3e7aa1c02caf@suse.com>
Date:   Thu, 17 Feb 2022 21:25:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] btrfs: remove an ASSERT() which can cause false alert
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Su Yue <l@damenly.su>
References: <f0d4a789788e8e63041dc6d91408f40234daa329.1645091180.git.wqu@suse.com>
 <Yg4uFd40/Y5pQWt2@debian9.Home>
 <908e62ce-6b4c-b98c-8737-32111ddd7f96@gmx.com>
 <CAL3q7H6pbLvN80YjEZ4mXA7f6o=8oMZ2Drv_3gM0PmB-a9pb3A@mail.gmail.com>
 <9e08c09b-5190-8c77-90c0-b372ae294517@gmx.com>
 <CAL3q7H6bZLPqGboFN9KDs717puFBXZ9Q-UknWxJ-sD9NZ9TpGw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAL3q7H6bZLPqGboFN9KDs717puFBXZ9Q-UknWxJ-sD9NZ9TpGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79e16d9a-0c57-405c-9565-08d9f218fd07
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB53444900F81EF1A9A928FDFDD6369@VI1PR04MB5344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgPtie10RsPnwwDkx2UG5Zn1Tg4mZL8B5ZA2RKUnTgkvOAXednPF6aNMkUKsIN7M/3pZBTMe3kV2jMKGQMz/xQ44wgybcjkm/YlI3bxOySNTZhsItUy/Iu1Nir3TMKSnW/hxX/sQqJHZqzCKBPI8W16edHQ/YNSdY7n+22spY7kbYyyu04+AcGjH3me1G8ZuRtW/Vj2nIqr4Cq2ZxCwSMolYKOLESBL81Aj9Sa9PZZrZxAfYDh9QS4g/OlSQ7T//VoYh9rP7JVWcSfROwX3WX8g8Rzb+8XarfZueBr/uqPe5nB6AUrhMat50CI4EaaiKgAyqr1EFt4qo4KPiIkrpCuOTkr/UmAOFHCnoKoRF0JAsp66gQYk4jAsKs/eOaMYBXdJiL3p4yGCv1xZsIJYtpHRq+PabynF2nfz/YV/zntGOZ7h74k/X4eCt7dEJR7ZO9O6AGIDvm2oqQmcMyW1JhKxA9Z6+m2+hrnp2vyzKj2KnLCjb9Qc0p7DeIKKvXOXlBqbp7TeL5YYEY5PdZfuMQEyDn34AyIu2xQkcsatdAXDuyeeJfC/YWb1j0h6qe0q7Hr9niNkGT+WTnrcqfuIb77xExWklM/RIi/pnJUkGC9NOhATT3eZ3yUkXq7BY+di8I1TNsimZpaRhRpzC5msadqzAhmDsUaGW0tms2TyVpCQ7oWryDNY757NRCxVLygnbQeFI7eNNjRhHP0NRnuBNaRHomJmTF2Prhhkc/u/mCyUl50lvJKQPQPJt1iOZ7elXw8B5AF9+GZd1UG/0zHyOVn/2zebPnc3xUyOxffRqRDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66946007)(66556008)(66476007)(38100700002)(6486002)(8676002)(4326008)(31696002)(186003)(26005)(508600001)(15650500001)(83380400001)(6512007)(36756003)(6666004)(5660300002)(6506007)(316002)(2616005)(86362001)(31686004)(110136005)(54906003)(2906002)(53546011)(46800400005)(518174003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXA3K05Qa3NuTzlrdVdkQUZkNUduOXJlcW5CV0dwWlNFbkFYZmhwNWJYVTBX?=
 =?utf-8?B?Ty91bDZEY3ZOanZyUGhoZ2JjSFVsZVQya0ZFRkpDNVRtanF1U09lazlrSHVD?=
 =?utf-8?B?UFRnYUdoUDVGR29IYjVaZ0IzcWRzUHhoRDZqV2svQnpURmVqc3U0YTUrLzNq?=
 =?utf-8?B?R0UyZm9wem4wVjZhNWhBNmxVUC83NUVjWHhyNnc2dmszcjFtQzdKdlBYaDJ3?=
 =?utf-8?B?SG0zRVhmZWI5emJNNmQveERYQkJQWEdMQXhEVGlvcFlja0VVaXJCc24vL0JI?=
 =?utf-8?B?YWFaRml0TlJJWjB3ajI5YzI2RWFaU3BIYUNneGdRdTlHOXNIcnlPdVZoMEd5?=
 =?utf-8?B?OUN4cTQxZnM4WUh1aTNsTW03MTBOLzJvUTV5ejRKc2w3bVlpM3JlUFZKZThZ?=
 =?utf-8?B?M3JIOW9HWGFJSi8yNEIrR0dIS2RJZDIwZXd3ZHF6MFh5S0RVeFBFK0FORWFj?=
 =?utf-8?B?aVU0MFJ0ME10VkJtclByRDBDRkU1dlRRSkh0OU9yOWFuNzJwZVNVdTZvbWF0?=
 =?utf-8?B?c09zelduN2tMMUFvdGNFYW9PQUdqTXVzdGptamJYWFptNnF2UUk1TXZwcTZj?=
 =?utf-8?B?ZU1abUFPOG90cUxvLzgveHZWeGFSUGdjT0xldFZiSW03bktmMjQvZm5NKzFZ?=
 =?utf-8?B?ZWVNMEI5bDhveVVhVlNmNmpkRWJ2TGpvVkFENlJJRzNldkM3ejIxQjdka0k1?=
 =?utf-8?B?WXJBVW5RV3JpaGNpK0FpQ1J6UHFPZ0djOWU4QWNvUWF6UVMxMTFSU2N4YTda?=
 =?utf-8?B?UVJURExkTXp0VW03eVRlYWdYd2tEdnZ5Q1hCemttZVZGd2xnb3dVbU9IMHlr?=
 =?utf-8?B?bXoxN29QWXp1TzZreWxaTVlhSmYvSXhYYTBCbXJnczIrdzFJNDZEak0xYzdt?=
 =?utf-8?B?ejhXeUdncEtLNjFzK0p1TEpYOHoxTDN3N0d4SEY5ZkUzcTZ3TEhibnY5aDBS?=
 =?utf-8?B?OTFJdkVSUkxSNUcyWE5uYXRmYVd5dUQ2SzdOZFlMbDUxc2oxTjFWS0tCZ29i?=
 =?utf-8?B?UWl1WWJVall5RnJVNjJBR2Zpb3NXT2FiOGdvRHFOQzBzbi9MOFh6c1RvM1ZZ?=
 =?utf-8?B?bkFqa1N4RHRRVC9LbHN0a2tHbXpKMnBJT0YxVnM2R1lnaEhZQnhzcmYwK1Bv?=
 =?utf-8?B?VGhndkpQM0tMVVl1ZTRsV0tpOFZFNUdBRnFoWisvUVdNaTZ0bkptSldxdmhl?=
 =?utf-8?B?N0RTV2JyYXFBbG5yRSs2V1ZCNncvSXozUXEveDVRTVNNNWYwblRiQlhtSjlU?=
 =?utf-8?B?Sm9pVVRVaElUT1E3V25vSUVFdTJpbXhoZW4vbUFMc245b29UWk9XZTg4Ymll?=
 =?utf-8?B?YWhTOEx2WWJtbEVLYzAzUDNCNHU0VGpLdGU3WEwzOTNIQU5NWE1OajNvWkV2?=
 =?utf-8?B?NWRUQTJENGwrY1BaOTc2WjZ6c1RNVGdxZ295QUhXUjIzcVZrZTA1UmlxV0FB?=
 =?utf-8?B?L0tnSmlDa2dWeFZlbE5JOSs3NmJEZFRVQTZnVmNUdjFNNDdaakxKQ1FtdDM0?=
 =?utf-8?B?MXd6V0pWc1AyVno4Um9pQzdUTVdUNWdFRDllQUJQNit2ZmpUSEtGYVRJUERS?=
 =?utf-8?B?clpBYi9uMHdnVXkwUFN2T013ZzVIT0pBaDRDUGg2bjY4c24zenBGWXdSWnNK?=
 =?utf-8?B?YVppUVZGUHhIRDFxTmd3VDZrMlU2ZForNGhpRG9YTFJZN055NWNubWRLZENC?=
 =?utf-8?B?d0dFVHNPQ1NUK0xRYitRekRYR0FDMDRzdDBDNlQzTUdYNDNYOHZSYnlpeHdY?=
 =?utf-8?B?Q3dKMUwzNFdyWGtudjFLOU1hMEdMZzlZVUd2bnkrK3pROXlJTGtMZ3hWa204?=
 =?utf-8?B?UUpURUxYbEYxSU1aTi9rMVVnTm84TlFsSGc0eExoN2dnUXpsQUEzOEtvZmMy?=
 =?utf-8?B?L2tHODREc2FoVEJpTEV5YWxwUVl6emRPWXQzUG1WeElhWUdsR3B6ZjZ4VFVh?=
 =?utf-8?B?WE1lRW5qSVN4Nk9Qa05DYnJnRmFBd3BKeUd0Uyt2Nk9FQnY2SnNQQlNxZVcr?=
 =?utf-8?B?cnh4TUtrVFQvWlFBUnArVzlyY1lJY3pIRklmbVQ3b1J6V0h1VmtWZTNyYzds?=
 =?utf-8?B?UVY1WG1vY0tBMzlJS0VkSzl4d01pVmN2MGVpMHZJeFhRT004RElRdVpPT05a?=
 =?utf-8?Q?pZRU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e16d9a-0c57-405c-9565-08d9f218fd07
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:25:39.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOwSr27VWUJeB+j88EFyhrEhYrE9zkrh9o2ay1/++UZcCJtRPrqSawbS8E0/K7W4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5344
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/17 21:02, Filipe Manana wrote:
> On Thu, Feb 17, 2022 at 1:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/2/17 20:32, Filipe Manana wrote:
>>> On Thu, Feb 17, 2022 at 11:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/2/17 19:14, Filipe Manana wrote:
>>>>> On Thu, Feb 17, 2022 at 05:49:34PM +0800, Qu Wenruo wrote:
>>>>>> [BUG]
>>>>>> Su reported that with his VM running on an M1 mac, it has a high chance
>>>>>> to trigger the following ASSERT() with scrub and balance test cases:
>>>>>>
>>>>>>                ASSERT(cache->start == chunk_offset);
>>>>>>                ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
>>>>>>                                  dev_extent_len);
>>>>>>
>>>>>> [CAUSE]
>>>>>> The ASSERT() is making sure that the block group cache (@cache) and the
>>>>>> chunk offset from the device extent match.
>>>>>>
>>>>>> But the truth is, block group caches and dev extent items are deleted at
>>>>>> different timing.
>>>>>>
>>>>>> For block group caches and items, after btrfs_remove_block_group() they
>>>>>> will be marked deleted, but the device extent and the chunk item is
>>>>>> still in dev tree and chunk tree respectively.
>>>>>
>>>>> This is not correct, what happens is:
>>>>>
>>>>> 1) btrfs_remove_chunk() will remove the device extent items and the chunk
>>>>>       item;
>>>>>
>>>>> 2) It then calls btrfs_remove_block_group(). This will not remove the
>>>>>       extent map if the block group was frozen (due to trim, and scrub
>>>>>       itself). But it will remove the block group (struct btrfs_block_group)
>>>>>       from the red black tree of block groups, and mark the block group
>>>>>       as deleted (set struct btrfs_block_group::removed to 1).
>>>>>
>>>>>       If the extent map was not removed, meaning the block group is frozen,
>>>>>       then no one will be able to create a new block group with the same logical
>>>>>       address before the block group is unfrozen (by someone who is holding
>>>>>       a reference on it). So a lookup on the red black tree will return NULL
>>>>>       for the logical address until the block group is unfrozen and its
>>>>>       logical address is reused for a new block group.
>>>>>
>>>>> So the ordering of what you are saying is reversed - the device extent
>>>>> and chunk items are removed before marking the block group as deleted.
>>>>>
>>>>>>
>>>>>> The device extents and chunk items are only deleted in
>>>>>> btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs()
>>>>>> or btrfs_relocate_chunk().
>>>>>
>>>>> This is also confusing because it gives a wrong idea of the ordering.
>>>>> The device extents and chunk items are removed by btrfs_remove_chunk(),
>>>>> which happens before marking a block group as deleted.
>>>>>
>>>>>>
>>>>>> This timing difference leaves a window where we can have a mismatch
>>>>>> between block group cache and device extent tree, and triggering the
>>>>>> ASSERT().
>>>>>
>>>>> I would like to see more details on this. The sequence of steps between
>>>>> two tasks that result in this assertion being triggered.
>>>>>
>>>>>>
>>>>>> [FIX]
>>>>>>
>>>>>> - Remove the ASSERT()
>>>>>>
>>>>>> - Add a quick exit if our found bg doesn't match @chunk_offset
>>>>>
>>>>> This shouldn't happen. I would like to know the sequence of steps
>>>>> between 2 (or more) tasks that leads to that.
>>>>>
>>>>> We are getting the block group with btrfs_lookup_block_group() at
>>>>> scrub_enumerate_chunks(), that calls block_group_cache_tree_search()
>>>>> with the "contains" argument set to 1, meaning it can return a
>>>>> block group that contains the given bytenr but does not start at
>>>>> that bytenr necessarily.
>>>>>
>>>>> This gives me the idea a small block group was deleted and then a
>>>>> new one was allocated which starts at a lower logical offset and
>>>>> includes "chunk_offset" (ends beyond that).
>>>>>
>>>>> We should probably be using btrfs_lookup_first_block_group() at
>>>>> scrub_enumerate_chunks(), so it looks for a block group that starts
>>>>> exactly at the given logical address.
>>>>>
>>>>> But anyway, as I read this and see the patch's diff, this feels a lot
>>>>> like a "bail out if something unexpected happens but we don't know
>>>>> exactly why/how that is possible".
>>>>
>>>> You're completely correct.
>>>>
>>>> Unfortunately I have no way to reproduce the bug on x86_64 VMs, and all
>>>> my ARM VMs are too slow to reproduce.
>>>>
>>>> Furthermore, due to some unrelated bugs, v5.17-rc based kernels all
>>>> failed to boot inside the VMs on Apple M1.
>>>>
>>>> So unfortunately I don't have extra details for now.
>>>>
>>>> Will find a way to reproduce first, then update the patch with better
>>>> comments.
>>>
>>> Was it triggered with some specific test case from fstests?
>>
>> Yes, from a regular run on fstests.
> 
> Ok, but which specific test(s)?

No mention, but I guess it's inside scrub + replace group.

> 
>>
>> But that was on an older branch (some older misc-next, which has the
>> patch but still based on v5.16).
>>
>> The v5.17-rc based branch will not boot inside the ARM vm at all, and no
>> early boot messages after the EFI routine.
>>
>> Will attack the boot problem first.
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>>
>>>>>> - Add a comment on the existing checks in scrub_chunk()
>>>>>>      This is the ultimate safenet, as it will iterate through all the stripes
>>>>>>      of the found chunk.
>>>>>>      And only scrub the stripe if it matches both device and physical
>>>>>>      offset.
>>>>>>
>>>>>>      So even by some how we got a dev extent which is no longer owned
>>>>>>      by the target chunk, we will just skip this chunk completely, without
>>>>>>      any consequence.
>>>>>>
>>>>>> Reported-by: Su Yue <l@damenly.su>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>> Changelog:
>>>>>> v2:
>>>>>> - Add a new quick exit with extra comments
>>>>>>
>>>>>> - Add a new comment in the existing safenet in scrub_chunk()
>>>>>> ---
>>>>>>     fs/btrfs/scrub.c | 21 ++++++++++++++++++++-
>>>>>>     1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>>>>> index 11089568b287..1c3ed4720ddd 100644
>>>>>> --- a/fs/btrfs/scrub.c
>>>>>> +++ b/fs/btrfs/scrub.c
>>>>>> @@ -3578,6 +3578,14 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
>>>>>>                goto out;
>>>>>>
>>>>>>        map = em->map_lookup;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Due to the delayed modification of device tree, this chunk
>>>>>> +     * may not own this dev extent.
>>>>>
>>>>> This is confusing. What delayed modification, what do you mean by it
>>>>> exactly? Same below, with more details.
>>>>>
>>>>>> +     *
>>>>>> +     * So we need to iterate through all stripes, and only scrub
>>>>>> +     * the stripe which matches both device and physical offset.
>>>>>> +     */
>>>>>>        for (i = 0; i < map->num_stripes; ++i) {
>>>>>>                if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
>>>>>>                    map->stripes[i].physical == dev_offset) {
>>>>>> @@ -3699,6 +3707,18 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>>>>>>                if (!cache)
>>>>>>                        goto skip;
>>>>>>
>>>>>> +            /*
>>>>>> +             * Since dev extents modification is delayed, it's possible
>>>>>> +             * we got a bg which doesn't really own this dev extent.
>>>>>
>>>>> Same as before. Too confusing, what is delayed dev extent modification?
>>>>>
>>>>> Once added, device extents can only be deleted, they are never modified.
>>>>> I think you are referring to the deletions and the fact we use the commit
>>>>> roots to find extents, but that should be a more clear comment, without
>>>>> such level of ambiguity.
>>>>>
>>>>> Thanks.
>>>>>
>>>>>> +             *
>>>>>> +             * Here just do a quick skip, scrub_chunk() has a more
>>>>>> +             * comprehensive check in it.
>>>>>> +             */
>>>>>> +            if (cache->start != chunk_offset) {
>>>>>> +                    btrfs_put_block_group(cache);
>>>>>> +                    goto skip;
>>>>>> +            }
>>>>>> +
>>>>>>                if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
>>>>>>                        spin_lock(&cache->lock);
>>>>>>                        if (!cache->to_copy) {
>>>>>> @@ -3822,7 +3842,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>>>>>>                dev_replace->item_needs_writeback = 1;
>>>>>>                up_write(&dev_replace->rwsem);
>>>>>>
>>>>>> -            ASSERT(cache->start == chunk_offset);
>>>>>>                ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
>>>>>>                                  dev_extent_len);
>>>>>>
>>>>>> --
>>>>>> 2.35.1
>>>>>>
> 

