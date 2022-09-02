Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621FE5AAB81
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiIBJfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiIBJfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:35:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F18A140F6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 02:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWTRPYpCqBmLWeoP1uWMnchdpnJPCdQalR9vTJFpSgyF1Z4U9jM7Uk4tWQC5S21kvkFdor1bxm/L4NQcGmypovJ4a6XM14sclKHVEMfFaf6ZvPxfTD69jNzu6X03qtlwJx2PMN3XSry0ZH4q+fPNePpLTiZlVz82HvvLQr4TxQlBMXgsdI7IM8JH06WCyw6IA4IJ3PGHtQjiWSNf/2virnaDdV5lIARx6h6Yi/dMVfAfB2EfqJoicURzcAcfaaR70HrMXangcvMVc+9SfieHUNdCQxxblikkKc6+i0qIxQXAA1gNzf7TktbMx8ggonM+GDX3ZVwI+RFElaFEsvAbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unKpsyaHHFeNJd+5VgBaPkvNeRi/TC93/c29VG9bVns=;
 b=PPWs2dDmO2HLc/htibnoGWPSiUgBoNGUO6OkzoK25vxGMw9mAbcr28VkmpKxIgVeA5SlZ6SrLKjcsrNWqOPGqQTYmQO60mnRjvOzSdDuJa2lQ3WzlPkjVlWUNBNFV53vHJfYdnuKiWbHByCxTI2qPRsSATgYTiAHZQpC+zskjoBCUIMClBlqW2sMK3ngCDJTiQnh8BVf0a5S7tv0gU5di/MrYo9Nir0onADvYWSlCnbAXC1wu72PsYsuKsZZVHxU0TOE4ku07apzhf5yLa0yyfujmKXbvgNPZebk/d8XKKedsOGPOv1tRFsYYefw6BvU0DAjZttFXpMAP9hZP0ilrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unKpsyaHHFeNJd+5VgBaPkvNeRi/TC93/c29VG9bVns=;
 b=nc3KaYn16OZPJn2xZuf49Y/NX/2MbxK4qk+laXP6J/JMZT585A/dZv41uD/wVbt+r/cryK366BIygLczBrVvMAgpijk9WhwF0kHuQ8Nk4KYEPYSr0z7dd/ox5oCdhRbpMCoq3CE+bii3fnXuH4sV8jB8G6K+KttKML6yrrA3YnEQdLzJtKdvtYeBO7Dtt197Lp6/seO1bF1qJ6sJoRNEDxqACEfOP5blfMBfMScVME20ZDGqNo2I0CtftxofaTLhAxod7XeUf385Sjy8LDAvRvRio3dEpbaZaKApIK+QOytHSZ8mvw7rb7pAjOt0vVdvxaqX/1BvZGH8orouVClcwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7756.eurprd04.prod.outlook.com (2603:10a6:10:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 09:34:58 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab%5]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 09:34:58 +0000
Message-ID: <ff62ceaf-ce3c-5b83-7131-f6b6c1d93ea1@suse.com>
Date:   Fri, 2 Sep 2022 17:34:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <afad772c28ed5fc236785df6f3c43282d5c12534.1662022922.git.fdmanana@suse.com>
 <5ccad791-2978-d300-2f82-9cccea4f4c3a@gmx.com>
 <CAL3q7H5QHYgBBAQp8fiVN8j5iTwRoKgSJ7fFXS7x_Rej1x7=GQ@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 10/10] btrfs: make fiemap more efficient and accurate
 reporting extent sharedness
In-Reply-To: <CAL3q7H5QHYgBBAQp8fiVN8j5iTwRoKgSJ7fFXS7x_Rej1x7=GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c99528-5012-4b80-5957-08da8cc66674
X-MS-TrafficTypeDiagnostic: DBBPR04MB7756:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15z2gDZlj7H+2KAgmyz051H8z5127F4z7URtFKxeO6ACnLUt3MrCcrZAUXPpQecZ2FxUKQpWykbnxPfmEGyhWrKVST0oHdRVrrYKzDhj1j006tCbpiTbRimxUP/jtbZuQ4FEHpf1x5tctlaTNlWj2e0YgTZ7LZnikjp+/2wlT6mTR0q5aOkui9vAuEfFEeHZR/IdY5EM8PKi4A5x4iXnFPX72gmRQ1+S3DhC0H2afSUW0ffhPQLQ7PtuK5ptAd5KMUtYk/uRdySed/AztPaYNjZO3c5P+LisGHHs6xW4dsiKmLGB+drkShX3Y8JJ39+v7IiW1QAk56TwebICg0MXdZB+zFi9zcoGyvY9UFoiHM+GGSZrd9mpdVEAbSfvCZptaRWL+kaDCI5VhjVdjBMOXoYMyhpVyt60XmvJdUbkznp+8XqJFOP6v9fXswaohHa9SzdxtGkFhOKvxksepm301xrhZ1B6c3VKp4llqmkjdmbqC9FEUQm9dcWsNydVI/x9JOA+1fGJN+AXhm4Nyb57yANTDt5yluB9m21U10hdHaHS0+ja0djg9YNEUzmOHEubYIB1RQlYS/WrfiqLIhkSFztkB8p2D97Fqq1oTIqKI43Mf+fLCUDIZdhbbOajPnf0NA/v21hgMabcEu6duBzugioGjJgOp8Yce+6/5qEmPHny2WaNXVKXVU4TwBHbTTkXpSLPHrUwKro0Bpy0T/T2k3TY2Edcqs3a2LaHfxL4jlavZ131aXb8FxRRHRKT6D2PHDlokqdhpU91qiD+JZAMvVqSY/Tx4lWpaVzWK8ijeGM+BuBeLtg6XanGKqtNEUET
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(346002)(366004)(376002)(53546011)(2616005)(186003)(30864003)(8936002)(478600001)(6506007)(5660300002)(6512007)(36756003)(31686004)(6666004)(41300700001)(6486002)(86362001)(83380400001)(31696002)(316002)(2906002)(110136005)(38100700002)(66946007)(66476007)(66556008)(4326008)(8676002)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEorNDk0dGlDUTlRMUlKUDI3L29CYzNzRVdUcWF6azExS3ZHNk5scnN6cE5O?=
 =?utf-8?B?eExwdkFEOGhaZGlaaWRObjBaM2FVcEJhbGFzdVZwcTNOTnh2czZkWGFDNisr?=
 =?utf-8?B?MmJpWUpGYWR0V05NZjg1dDdtZ0FjZnkxamhkb1pWQU1ralJMRHJuVml2U0F5?=
 =?utf-8?B?bUlYY0ZrNkdWdGZ0N0NSaEhMdEtSclFiZG1hY2FkTmFWdmhLN3d5enpPY1Iz?=
 =?utf-8?B?UUJ2VTdaT2FRd1kzRi9oeUNKVUUwWWNHVFA5MmpGdmIzdFZuejhNdkJPbnpl?=
 =?utf-8?B?VWFKa0hsOUkvWUowamRmNnUvb21HazJoU3NqMG1MNFlaeE96cHE2cDlCMkt6?=
 =?utf-8?B?NnJGL1dwN1dEa0F5L2xqcDJ2SUxxZ0xYL2drKzlzOFJqR2ZEMVRIeGtLc21B?=
 =?utf-8?B?OE00enhvbmt5N3hCY3Yzby9vNGtoN3Irb2xzZGYxQk5CRFllOHQ5M2hNQjhR?=
 =?utf-8?B?MmY3THlXRzlmcUpjbVdoNk03QUdiaFcwZUZJRGZzdE9WRTFWdWJpa1dkcy80?=
 =?utf-8?B?Qzh3T2FOUEFncmdKMGgrQ1JscHl3WmFadVcwR2tsTWZDYlRTK3F3eHhTdytV?=
 =?utf-8?B?UThTYkhNVng2UjVhcWswNFJ0REFOa1RqbW5VZFRzWnh5ZndKaEhjT3d3TTEw?=
 =?utf-8?B?MmE5S0N4UnQ1WDUyOWVQUWJ0c2pwYUhhNGFvNVJhS3dTTjRwakhkeEI2c2FR?=
 =?utf-8?B?K2NsZUNIOXB3aVF5QWdJS0JhNm50MmRManpmejJDVU0zZmltNTI4ODFvWERV?=
 =?utf-8?B?MEhOeEtZbjNIWmk0QVJBbXV4TkZIQnlKcVI4cG4xV1NmcEZCMVFXYjVIZmdj?=
 =?utf-8?B?VUdRaStEbGlSU0NhVmppNktoZHM0M1ZJM080UWdmbXdYQkx4VlV4K09hYnZN?=
 =?utf-8?B?ODZ4UlhiTGI3TEM3cENUQkNneVpYSVFtMlhoRHVQUjk4UWJndWY0Mnlqdmky?=
 =?utf-8?B?dW1pRUpNZU5ObzdCY0UzMXd4ZnBXYlBKRHpBM2dDaUhKZC84R2JUamlQUzJ5?=
 =?utf-8?B?aWlIQXZnbFc0L0xYZ3ExTXZxdU5PK0NiT0hjU1h6REllMjJyeU1IVjhHUElV?=
 =?utf-8?B?R0J1ai9oa2hXeDVCRjc2SXJLRkNsZ3MxMG5nQUw0NEZLek5BSjczNDRiWnlN?=
 =?utf-8?B?dnF3cGhQU1ZLQTBLUTJrY1A3TWlQZHlQbU5NU1EweWhUSHQxcTR0bkVCdzN3?=
 =?utf-8?B?aXJUTC9CZkJpNVJlT2ZQVmNNbzdUUDUxZnExT1BpTnMvaWpGMEpHQnYxWlU4?=
 =?utf-8?B?U1M2bjBwUDQwRldwWnVPVWsxSkZMVGVjdmdSaVhoQWhXS3JmdjBrVDA2a3di?=
 =?utf-8?B?clcvS0ZsZldVRmlVaGxjQjIwcUNLaDltd3krcWZ6OTRHRjBUOVBBd3hnRTh0?=
 =?utf-8?B?VHppYTJvM3RuNFZVQWNvQmtkQ2VEK1R2YXV3Y2hkS3Q3OFE4ZExXbmRjZTNN?=
 =?utf-8?B?bUxYbHpGZmpKZGFxaGZaSWVmVzhWTzFVaUs1em0vZTNINkpPU1ZVNDBMS3ZT?=
 =?utf-8?B?S2hyMUpVR0VrVFJqYjkrMkpkRUQ4VVFrM3lsaUZEdU96OVRvWFhyeEQrOVJW?=
 =?utf-8?B?M3o2M3hkeHBmemhaYnhmMmlMYTBTdUNwWEh3c25FUFd0RUMrM2t0eVZQN2xh?=
 =?utf-8?B?RG9RNEgzUVNBQ2FLRG1rNmc4czZiQTRjZTF1dmlKL0hISzZJMS9nQ09UbGZT?=
 =?utf-8?B?aVprYlBzbVZoQVUzZUdhRlRZalZlWDFIRXoyRkdUekJ3bG5GdmFsditxcE11?=
 =?utf-8?B?cmVCb0VXQTN5eHlJQXN0Nk9rcmx3dnB4SnRqdW9kQVUwZGZsZTFVMkYxd0xt?=
 =?utf-8?B?akFqL05ZNThwMFJHeUxOTUdaOGh4QndQRXZaV0NKUnNqZjd4Ny9TeGVmUEVX?=
 =?utf-8?B?R2FjN21UYTBZRkpraHBqRnBTS1JDSGN0aTJ2cnBheG5KLzJuVzhyREpaUWlS?=
 =?utf-8?B?ekxlUXdSbm41L0lxaVZUY3NkdXNQek5pNkFNRW5jM0wvaUNJRGZyWjN0RExn?=
 =?utf-8?B?RjQ0U2RyNURKN2RtbWZUczc5N1hRWnNBWDhReTl6ODJ3RXBZYWJGeGtlY0JD?=
 =?utf-8?B?SlRGMlA5dVJuQzRkMjI2Y3RHYkxEdlJqSlZRYnBxSWthbk5ZblNXenRkWlVI?=
 =?utf-8?B?c29WWDNHT2ZGdEtsaUNvOHhrUUFWaHpGVUVTMXk5c2tTQ2xUdTc4NUR2S0xh?=
 =?utf-8?Q?6qo8lAn7YlGjrte8y5B8jZc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c99528-5012-4b80-5957-08da8cc66674
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 09:34:58.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXifLMYUxVNOTv+mR8xMbvMECNh6wv5aU6cBduYofglQqptkPxHoxXrADN+5o7mJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/2 16:59, Filipe Manana wrote:
> On Fri, Sep 2, 2022 at 12:27 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
[...]
>>
>> Is there any other major usage for extent map now?
> 
> For fsync at least is very important.

OK, forgot that fsync is relying on that to determine if an extent needs 
to be logged.

> Also for reads it's nice to not have to go to the b+tree.
> If someone reads several pages of an extent, being able to get it directly
> from the extent map tree is faster than having to go to the btree for
> every read.
> Extent map trees are per inode, but subvolume b+trees can have a lot of
> concurrent write and read access.
> 
>>
>> I can only think of read, which uses extent map to grab the logical
>> bytenr of the real extent.
>>
>> In that case, the SHARED flag doesn't make much sense anyway, can we do
>> a cleanup for those flags? Since fiemap/lseek no longer relies on extent
>> map anymore.
> 
> I don't get it. What SHARED flag are talking about? And which "flags", where?
> We have nothing specific for lseek/fiemap in the extent maps, so I
> don't understand.

Nevermind, I got confused and think there would be one SHARED flag for 
extent map, but that's totally wrong...

> 
>>
[...]
>>
>> Although this is correct, it still looks a little tricky.
>>
>> We rely on btrfs_release_path() to release all tree blocks in the
>> subvolume tree, including unlocking the tree blocks, thus path->locks[0]
>> is also 0, meaning next time we call btrfs_release_path() we won't try
>> to unlock the cloned eb.
> 
> We're not taking any lock on the cloned extent buffer. It's not
> needed, it's private
> to the task.

Yep, that's completely fine, just looks a little tricky since we're 
going to release that path twice, and that's expected.

> 
>>
>> But I'd say it's still pretty tricky, and unfortunately I don't have any
>> better alternative.
>>
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/*
>>> + * Process a range which is a hole or a prealloc extent in the inode's subvolume
>>> + * btree. If @disk_bytenr is 0, we are dealing with a hole, otherwise a prealloc
>>> + * extent. The end offset (@end) is inclusive.
>>> + */
>>> +static int fiemap_process_hole(struct btrfs_inode *inode,
>>
>> Does the name still make sense as we're handling both hole and prealloc
>> range?
> 
> I chose that name because hole and prealloc are treated the same way.
> Sure, I could name it fiemap_process_hole_or_prealloc() or something
> like that, but
> I decided to keep the name shorter, make them explicit in the comments and code.
> 
> The old code did the same, get_extent_skip_holes() skipped holes and
> prealloc extents without delalloc.
> 
>>
>>
>> And I always find the delalloc search a big pain during lseek/fiemap.
>>
>> I guess except using certain flags, there is some hard requirement for
>> delalloc range reporting?
> 
> Yes. Delalloc is not meant to be flushed for fiemap unless
> FIEMAP_FLAG_SYNC is given by the user.

Would it be possible to let btrfs always flush the delalloc range, no 
matter if FIEMAP_FLAG_SYNC is specified or not?

I really want to avoid the whole delalloc search thing if possible.

Although I'd guess such behavior would be against the fiemap 
requirement, and the extra writeback may greatly slow down the fiemap 
itself for large files with tons of delalloc, so not really expect this 
to happen.

> For lseek it's just not needed, but that was already mentioned /
> discussed in patch 2/10.
> 
[...]
>>> +     /*
>>> +      * Lookup the last file extent. We're not using i_size here because
>>> +      * there might be preallocation past i_size.
>>> +      */
>>
>> I'm wondering how could this happen?
> 
> You can fallocate an extent at or after i_size.
> 
>>
>> Normally if we're truncating an inode, the extents starting after
>> round_up(i_size, sectorsize) should be dropped.
> 
> It has nothing to do with truncate, just fallocate.
> 
>>
>> Or if we later enlarge the inode, we may hit old extents and read out
>> some stale data other than expected zeros.
>>
>> Thus searching using round_up(i_size, sectorsize) should still let us to
>> reach the slot after the last file extent.
>>
>> Or did I miss something?
> 
> Yes, it's about prealloc extents at or after i_size.

Did you mean falloc using keep_size flag?

Then that explains the whole reason.

Thanks,
Qu

> 
> Thanks.
> 
>>
>> Thanks,
>> Qu
>>
>>> +     ret = btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
>>> +     /* There can't be a file extent item at offset (u64)-1 */
>>> +     ASSERT(ret != 0);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     /*
>>> +      * For a non-existing key, btrfs_search_slot() always leaves us at a
>>> +      * slot > 0, except if the btree is empty, which is impossible because
>>> +      * at least it has the inode item for this inode and all the items for
>>> +      * the root inode 256.
>>> +      */
>>> +     ASSERT(path->slots[0] > 0);
>>> +     path->slots[0]--;
>>> +     leaf = path->nodes[0];
>>> +     btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>>> +     if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
>>> +             /* No file extent items in the subvolume tree. */
>>> +             *last_extent_end_ret = 0;
>>> +             return 0;
>>>        }
>>> -     btrfs_release_path(path);
>>>
>>>        /*
>>> -      * we might have some extents allocated but more delalloc past those
>>> -      * extents.  so, we trust isize unless the start of the last extent is
>>> -      * beyond isize
>>> +      * For an inline extent, the disk_bytenr is where inline data starts at,
>>> +      * so first check if we have an inline extent item before checking if we
>>> +      * have an implicit hole (disk_bytenr == 0).
>>>         */
>>> -     if (last < isize) {
>>> -             last = (u64)-1;
>>> -             last_for_get_extent = isize;
>>> +     ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
>>> +     if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
>>> +             *last_extent_end_ret = btrfs_file_extent_end(path);
>>> +             return 0;
>>>        }
>>>
>>> -     lock_extent_bits(&inode->io_tree, start, start + len - 1,
>>> -                      &cached_state);
>>> +     /*
>>> +      * Find the last file extent item that is not a hole (when NO_HOLES is
>>> +      * not enabled). This should take at most 2 iterations in the worst
>>> +      * case: we have one hole file extent item at slot 0 of a leaf and
>>> +      * another hole file extent item as the last item in the previous leaf.
>>> +      * This is because we merge file extent items that represent holes.
>>> +      */
>>> +     disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
>>> +     while (disk_bytenr == 0) {
>>> +             ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
>>> +             if (ret < 0) {
>>> +                     return ret;
>>> +             } else if (ret > 0) {
>>> +                     /* No file extent items that are not holes. */
>>> +                     *last_extent_end_ret = 0;
>>> +                     return 0;
>>> +             }
>>> +             leaf = path->nodes[0];
>>> +             ei = btrfs_item_ptr(leaf, path->slots[0],
>>> +                                 struct btrfs_file_extent_item);
>>> +             disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
>>> +     }
>>>
>>> -     em = get_extent_skip_holes(inode, start, last_for_get_extent);
>>> -     if (!em)
>>> -             goto out;
>>> -     if (IS_ERR(em)) {
>>> -             ret = PTR_ERR(em);
>>> +     *last_extent_end_ret = btrfs_file_extent_end(path);
>>> +     return 0;
>>> +}
>>> +
>>> +int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>>> +               u64 start, u64 len)
>>> +{
>>> +     const u64 ino = btrfs_ino(inode);
>>> +     struct extent_state *cached_state = NULL;
>>> +     struct btrfs_path *path;
>>> +     struct btrfs_root *root = inode->root;
>>> +     struct fiemap_cache cache = { 0 };
>>> +     struct btrfs_backref_shared_cache *backref_cache;
>>> +     struct ulist *roots;
>>> +     struct ulist *tmp_ulist;
>>> +     u64 last_extent_end;
>>> +     u64 prev_extent_end;
>>> +     u64 lockstart;
>>> +     u64 lockend;
>>> +     bool stopped = false;
>>> +     int ret;
>>> +
>>> +     backref_cache = kzalloc(sizeof(*backref_cache), GFP_KERNEL);
>>> +     path = btrfs_alloc_path();
>>> +     roots = ulist_alloc(GFP_KERNEL);
>>> +     tmp_ulist = ulist_alloc(GFP_KERNEL);
>>> +     if (!backref_cache || !path || !roots || !tmp_ulist) {
>>> +             ret = -ENOMEM;
>>>                goto out;
>>>        }
>>>
>>> -     while (!end) {
>>> -             u64 offset_in_extent = 0;
>>> +     lockstart = round_down(start, btrfs_inode_sectorsize(inode));
>>> +     lockend = round_up(start + len, btrfs_inode_sectorsize(inode));
>>> +     prev_extent_end = lockstart;
>>>
>>> -             /* break if the extent we found is outside the range */
>>> -             if (em->start >= max || extent_map_end(em) < off)
>>> -                     break;
>>> +     lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
>>>
>>> -             /*
>>> -              * get_extent may return an extent that starts before our
>>> -              * requested range.  We have to make sure the ranges
>>> -              * we return to fiemap always move forward and don't
>>> -              * overlap, so adjust the offsets here
>>> -              */
>>> -             em_start = max(em->start, off);
>>> +     ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
>>> +     if (ret < 0)
>>> +             goto out_unlock;
>>> +     btrfs_release_path(path);
>>>
>>> +     path->reada = READA_FORWARD;
>>> +     ret = fiemap_search_slot(inode, path, lockstart);
>>> +     if (ret < 0) {
>>> +             goto out_unlock;
>>> +     } else if (ret > 0) {
>>>                /*
>>> -              * record the offset from the start of the extent
>>> -              * for adjusting the disk offset below.  Only do this if the
>>> -              * extent isn't compressed since our in ram offset may be past
>>> -              * what we have actually allocated on disk.
>>> +              * No file extent item found, but we may have delalloc between
>>> +              * the current offset and i_size. So check for that.
>>>                 */
>>> -             if (!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
>>> -                     offset_in_extent = em_start - em->start;
>>> -             em_end = extent_map_end(em);
>>> -             em_len = em_end - em_start;
>>> -             flags = 0;
>>> -             if (em->block_start < EXTENT_MAP_LAST_BYTE)
>>> -                     disko = em->block_start + offset_in_extent;
>>> -             else
>>> -                     disko = 0;
>>> +             ret = 0;
>>> +             goto check_eof_delalloc;
>>> +     }
>>> +
>>> +     while (prev_extent_end < lockend) {
>>> +             struct extent_buffer *leaf = path->nodes[0];
>>> +             struct btrfs_file_extent_item *ei;
>>> +             struct btrfs_key key;
>>> +             u64 extent_end;
>>> +             u64 extent_len;
>>> +             u64 extent_offset = 0;
>>> +             u64 extent_gen;
>>> +             u64 disk_bytenr = 0;
>>> +             u64 flags = 0;
>>> +             int extent_type;
>>> +             u8 compression;
>>> +
>>> +             btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>>> +             if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
>>> +                     break;
>>> +
>>> +             extent_end = btrfs_file_extent_end(path);
>>>
>>>                /*
>>> -              * bump off for our next call to get_extent
>>> +              * The first iteration can leave us at an extent item that ends
>>> +              * before our range's start. Move to the next item.
>>>                 */
>>> -             off = extent_map_end(em);
>>> -             if (off >= max)
>>> -                     end = 1;
>>> -
>>> -             if (em->block_start == EXTENT_MAP_INLINE) {
>>> -                     flags |= (FIEMAP_EXTENT_DATA_INLINE |
>>> -                               FIEMAP_EXTENT_NOT_ALIGNED);
>>> -             } else if (em->block_start == EXTENT_MAP_DELALLOC) {
>>> -                     flags |= (FIEMAP_EXTENT_DELALLOC |
>>> -                               FIEMAP_EXTENT_UNKNOWN);
>>> -             } else if (fieinfo->fi_extents_max) {
>>> -                     u64 extent_gen;
>>> -                     u64 bytenr = em->block_start -
>>> -                             (em->start - em->orig_start);
>>> +             if (extent_end <= lockstart)
>>> +                     goto next_item;
>>>
>>> -                     /*
>>> -                      * If two extent maps are merged, then their generation
>>> -                      * is set to the maximum between their generations.
>>> -                      * Otherwise its generation matches the one we have in
>>> -                      * corresponding file extent item. If we have a merged
>>> -                      * extent map, don't use its generation to speedup the
>>> -                      * sharedness check below.
>>> -                      */
>>> -                     if (test_bit(EXTENT_FLAG_MERGED, &em->flags))
>>> -                             extent_gen = 0;
>>> -                     else
>>> -                             extent_gen = em->generation;
>>> +             /* We have in implicit hole (NO_HOLES feature enabled). */
>>> +             if (prev_extent_end < key.offset) {
>>> +                     const u64 range_end = min(key.offset, lockend) - 1;
>>>
>>> -                     /*
>>> -                      * As btrfs supports shared space, this information
>>> -                      * can be exported to userspace tools via
>>> -                      * flag FIEMAP_EXTENT_SHARED.  If fi_extents_max == 0
>>> -                      * then we're just getting a count and we can skip the
>>> -                      * lookup stuff.
>>> -                      */
>>> -                     ret = btrfs_is_data_extent_shared(root, btrfs_ino(inode),
>>> -                                                       bytenr, extent_gen,
>>> -                                                       roots, tmp_ulist,
>>> -                                                       backref_cache);
>>> -                     if (ret < 0)
>>> -                             goto out_free;
>>> -                     if (ret)
>>> -                             flags |= FIEMAP_EXTENT_SHARED;
>>> -                     ret = 0;
>>> -             }
>>> -             if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
>>> -                     flags |= FIEMAP_EXTENT_ENCODED;
>>> -             if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>>> -                     flags |= FIEMAP_EXTENT_UNWRITTEN;
>>> +                     ret = fiemap_process_hole(inode, fieinfo, &cache,
>>> +                                               backref_cache, 0, 0, 0,
>>> +                                               roots, tmp_ulist,
>>> +                                               prev_extent_end, range_end);
>>> +                     if (ret < 0) {
>>> +                             goto out_unlock;
>>> +                     } else if (ret > 0) {
>>> +                             /* fiemap_fill_next_extent() told us to stop. */
>>> +                             stopped = true;
>>> +                             break;
>>> +                     }
>>>
>>> -             free_extent_map(em);
>>> -             em = NULL;
>>> -             if ((em_start >= last) || em_len == (u64)-1 ||
>>> -                (last == (u64)-1 && isize <= em_end)) {
>>> -                     flags |= FIEMAP_EXTENT_LAST;
>>> -                     end = 1;
>>> +                     /* We've reached the end of the fiemap range, stop. */
>>> +                     if (key.offset >= lockend) {
>>> +                             stopped = true;
>>> +                             break;
>>> +                     }
>>>                }
>>>
>>> -             /* now scan forward to see if this is really the last extent. */
>>> -             em = get_extent_skip_holes(inode, off, last_for_get_extent);
>>> -             if (IS_ERR(em)) {
>>> -                     ret = PTR_ERR(em);
>>> -                     goto out;
>>> +             extent_len = extent_end - key.offset;
>>> +             ei = btrfs_item_ptr(leaf, path->slots[0],
>>> +                                 struct btrfs_file_extent_item);
>>> +             compression = btrfs_file_extent_compression(leaf, ei);
>>> +             extent_type = btrfs_file_extent_type(leaf, ei);
>>> +             extent_gen = btrfs_file_extent_generation(leaf, ei);
>>> +
>>> +             if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
>>> +                     disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
>>> +                     if (compression == BTRFS_COMPRESS_NONE)
>>> +                             extent_offset = btrfs_file_extent_offset(leaf, ei);
>>>                }
>>> -             if (!em) {
>>> -                     flags |= FIEMAP_EXTENT_LAST;
>>> -                     end = 1;
>>> +
>>> +             if (compression != BTRFS_COMPRESS_NONE)
>>> +                     flags |= FIEMAP_EXTENT_ENCODED;
>>> +
>>> +             if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>>> +                     flags |= FIEMAP_EXTENT_DATA_INLINE;
>>> +                     flags |= FIEMAP_EXTENT_NOT_ALIGNED;
>>> +                     ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
>>> +                                              extent_len, flags);
>>> +             } else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
>>> +                     ret = fiemap_process_hole(inode, fieinfo, &cache,
>>> +                                               backref_cache,
>>> +                                               disk_bytenr, extent_offset,
>>> +                                               extent_gen, roots, tmp_ulist,
>>> +                                               key.offset, extent_end - 1);
>>> +             } else if (disk_bytenr == 0) {
>>> +                     /* We have an explicit hole. */
>>> +                     ret = fiemap_process_hole(inode, fieinfo, &cache,
>>> +                                               backref_cache, 0, 0, 0,
>>> +                                               roots, tmp_ulist,
>>> +                                               key.offset, extent_end - 1);
>>> +             } else {
>>> +                     /* We have a regular extent. */
>>> +                     if (fieinfo->fi_extents_max) {
>>> +                             ret = btrfs_is_data_extent_shared(root, ino,
>>> +                                                               disk_bytenr,
>>> +                                                               extent_gen,
>>> +                                                               roots,
>>> +                                                               tmp_ulist,
>>> +                                                               backref_cache);
>>> +                             if (ret < 0)
>>> +                                     goto out_unlock;
>>> +                             else if (ret > 0)
>>> +                                     flags |= FIEMAP_EXTENT_SHARED;
>>> +                     }
>>> +
>>> +                     ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
>>> +                                              disk_bytenr + extent_offset,
>>> +                                              extent_len, flags);
>>>                }
>>> -             ret = emit_fiemap_extent(fieinfo, &cache, em_start, disko,
>>> -                                        em_len, flags);
>>> -             if (ret) {
>>> -                     if (ret == 1)
>>> -                             ret = 0;
>>> -                     goto out_free;
>>> +
>>> +             if (ret < 0) {
>>> +                     goto out_unlock;
>>> +             } else if (ret > 0) {
>>> +                     /* fiemap_fill_next_extent() told us to stop. */
>>> +                     stopped = true;
>>> +                     break;
>>>                }
>>>
>>> +             prev_extent_end = extent_end;
>>> +next_item:
>>>                if (fatal_signal_pending(current)) {
>>>                        ret = -EINTR;
>>> -                     goto out_free;
>>> +                     goto out_unlock;
>>>                }
>>> +
>>> +             ret = fiemap_next_leaf_item(inode, path);
>>> +             if (ret < 0) {
>>> +                     goto out_unlock;
>>> +             } else if (ret > 0) {
>>> +                     /* No more file extent items for this inode. */
>>> +                     break;
>>> +             }
>>> +             cond_resched();
>>>        }
>>> -out_free:
>>> -     if (!ret)
>>> -             ret = emit_last_fiemap_cache(fieinfo, &cache);
>>> -     free_extent_map(em);
>>> -out:
>>> -     unlock_extent_cached(&inode->io_tree, start, start + len - 1,
>>> -                          &cached_state);
>>>
>>> -out_free_ulist:
>>> +check_eof_delalloc:
>>> +     /*
>>> +      * Release (and free) the path before emitting any final entries to
>>> +      * fiemap_fill_next_extent() to keep lockdep happy. This is because
>>> +      * once we find no more file extent items exist, we may have a
>>> +      * non-cloned leaf, and fiemap_fill_next_extent() can trigger page
>>> +      * faults when copying data to the user space buffer.
>>> +      */
>>> +     btrfs_free_path(path);
>>> +     path = NULL;
>>> +
>>> +     if (!stopped && prev_extent_end < lockend) {
>>> +             ret = fiemap_process_hole(inode, fieinfo, &cache, backref_cache,
>>> +                                       0, 0, 0, roots, tmp_ulist,
>>> +                                       prev_extent_end, lockend - 1);
>>> +             if (ret < 0)
>>> +                     goto out_unlock;
>>> +             prev_extent_end = lockend;
>>> +     }
>>> +
>>> +     if (cache.cached && cache.offset + cache.len >= last_extent_end) {
>>> +             const u64 i_size = i_size_read(&inode->vfs_inode);
>>> +
>>> +             if (prev_extent_end < i_size) {
>>> +                     u64 delalloc_start;
>>> +                     u64 delalloc_end;
>>> +                     bool delalloc;
>>> +
>>> +                     delalloc = btrfs_find_delalloc_in_range(inode,
>>> +                                                             prev_extent_end,
>>> +                                                             i_size - 1,
>>> +                                                             &delalloc_start,
>>> +                                                             &delalloc_end);
>>> +                     if (!delalloc)
>>> +                             cache.flags |= FIEMAP_EXTENT_LAST;
>>> +             } else {
>>> +                     cache.flags |= FIEMAP_EXTENT_LAST;
>>> +             }
>>> +     }
>>> +
>>> +     ret = emit_last_fiemap_cache(fieinfo, &cache);
>>> +
>>> +out_unlock:
>>> +     unlock_extent_cached(&inode->io_tree, lockstart, lockend, &cached_state);
>>> +out:
>>>        kfree(backref_cache);
>>>        btrfs_free_path(path);
>>>        ulist_free(roots);
>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>> index b292a8ada3a4..636b3ec46184 100644
>>> --- a/fs/btrfs/file.c
>>> +++ b/fs/btrfs/file.c
>>> @@ -3602,10 +3602,10 @@ static long btrfs_fallocate(struct file *file, int mode,
>>>    }
>>>
>>>    /*
>>> - * Helper for have_delalloc_in_range(). Find a subrange in a given range that
>>> - * has unflushed and/or flushing delalloc. There might be other adjacent
>>> - * subranges after the one it found, so have_delalloc_in_range() keeps looping
>>> - * while it gets adjacent subranges, and merging them together.
>>> + * Helper for btrfs_find_delalloc_in_range(). Find a subrange in a given range
>>> + * that has unflushed and/or flushing delalloc. There might be other adjacent
>>> + * subranges after the one it found, so btrfs_find_delalloc_in_range() keeps
>>> + * looping while it gets adjacent subranges, and merging them together.
>>>     */
>>>    static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end,
>>>                                   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
>>> @@ -3740,8 +3740,8 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
>>>     * if so it sets @delalloc_start_ret and @delalloc_end_ret with the start and
>>>     * end offsets of the subrange.
>>>     */
>>> -static bool have_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
>>> -                                u64 *delalloc_start_ret, u64 *delalloc_end_ret)
>>> +bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
>>> +                               u64 *delalloc_start_ret, u64 *delalloc_end_ret)
>>>    {
>>>        u64 cur_offset = round_down(start, inode->root->fs_info->sectorsize);
>>>        u64 prev_delalloc_end = 0;
>>> @@ -3804,8 +3804,8 @@ static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
>>>        u64 delalloc_end;
>>>        bool delalloc;
>>>
>>> -     delalloc = have_delalloc_in_range(inode, start, end, &delalloc_start,
>>> -                                       &delalloc_end);
>>> +     delalloc = btrfs_find_delalloc_in_range(inode, start, end,
>>> +                                             &delalloc_start, &delalloc_end);
>>>        if (delalloc && whence == SEEK_DATA) {
>>>                *start_ret = delalloc_start;
>>>                return true;
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 2c7d31990777..8be1e021513a 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -7064,133 +7064,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
>>>        return em;
>>>    }
>>>
>>> -struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
>>> -                                        u64 start, u64 len)
>>> -{
>>> -     struct extent_map *em;
>>> -     struct extent_map *hole_em = NULL;
>>> -     u64 delalloc_start = start;
>>> -     u64 end;
>>> -     u64 delalloc_len;
>>> -     u64 delalloc_end;
>>> -     int err = 0;
>>> -
>>> -     em = btrfs_get_extent(inode, NULL, 0, start, len);
>>> -     if (IS_ERR(em))
>>> -             return em;
>>> -     /*
>>> -      * If our em maps to:
>>> -      * - a hole or
>>> -      * - a pre-alloc extent,
>>> -      * there might actually be delalloc bytes behind it.
>>> -      */
>>> -     if (em->block_start != EXTENT_MAP_HOLE &&
>>> -         !test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>>> -             return em;
>>> -     else
>>> -             hole_em = em;
>>> -
>>> -     /* check to see if we've wrapped (len == -1 or similar) */
>>> -     end = start + len;
>>> -     if (end < start)
>>> -             end = (u64)-1;
>>> -     else
>>> -             end -= 1;
>>> -
>>> -     em = NULL;
>>> -
>>> -     /* ok, we didn't find anything, lets look for delalloc */
>>> -     delalloc_len = count_range_bits(&inode->io_tree, &delalloc_start,
>>> -                              end, len, EXTENT_DELALLOC, 1);
>>> -     delalloc_end = delalloc_start + delalloc_len;
>>> -     if (delalloc_end < delalloc_start)
>>> -             delalloc_end = (u64)-1;
>>> -
>>> -     /*
>>> -      * We didn't find anything useful, return the original results from
>>> -      * get_extent()
>>> -      */
>>> -     if (delalloc_start > end || delalloc_end <= start) {
>>> -             em = hole_em;
>>> -             hole_em = NULL;
>>> -             goto out;
>>> -     }
>>> -
>>> -     /*
>>> -      * Adjust the delalloc_start to make sure it doesn't go backwards from
>>> -      * the start they passed in
>>> -      */
>>> -     delalloc_start = max(start, delalloc_start);
>>> -     delalloc_len = delalloc_end - delalloc_start;
>>> -
>>> -     if (delalloc_len > 0) {
>>> -             u64 hole_start;
>>> -             u64 hole_len;
>>> -             const u64 hole_end = extent_map_end(hole_em);
>>> -
>>> -             em = alloc_extent_map();
>>> -             if (!em) {
>>> -                     err = -ENOMEM;
>>> -                     goto out;
>>> -             }
>>> -
>>> -             ASSERT(hole_em);
>>> -             /*
>>> -              * When btrfs_get_extent can't find anything it returns one
>>> -              * huge hole
>>> -              *
>>> -              * Make sure what it found really fits our range, and adjust to
>>> -              * make sure it is based on the start from the caller
>>> -              */
>>> -             if (hole_end <= start || hole_em->start > end) {
>>> -                    free_extent_map(hole_em);
>>> -                    hole_em = NULL;
>>> -             } else {
>>> -                    hole_start = max(hole_em->start, start);
>>> -                    hole_len = hole_end - hole_start;
>>> -             }
>>> -
>>> -             if (hole_em && delalloc_start > hole_start) {
>>> -                     /*
>>> -                      * Our hole starts before our delalloc, so we have to
>>> -                      * return just the parts of the hole that go until the
>>> -                      * delalloc starts
>>> -                      */
>>> -                     em->len = min(hole_len, delalloc_start - hole_start);
>>> -                     em->start = hole_start;
>>> -                     em->orig_start = hole_start;
>>> -                     /*
>>> -                      * Don't adjust block start at all, it is fixed at
>>> -                      * EXTENT_MAP_HOLE
>>> -                      */
>>> -                     em->block_start = hole_em->block_start;
>>> -                     em->block_len = hole_len;
>>> -                     if (test_bit(EXTENT_FLAG_PREALLOC, &hole_em->flags))
>>> -                             set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
>>> -             } else {
>>> -                     /*
>>> -                      * Hole is out of passed range or it starts after
>>> -                      * delalloc range
>>> -                      */
>>> -                     em->start = delalloc_start;
>>> -                     em->len = delalloc_len;
>>> -                     em->orig_start = delalloc_start;
>>> -                     em->block_start = EXTENT_MAP_DELALLOC;
>>> -                     em->block_len = delalloc_len;
>>> -             }
>>> -     } else {
>>> -             return hole_em;
>>> -     }
>>> -out:
>>> -
>>> -     free_extent_map(hole_em);
>>> -     if (err) {
>>> -             free_extent_map(em);
>>> -             return ERR_PTR(err);
>>> -     }
>>> -     return em;
>>> -}
>>> -
>>>    static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
>>>                                                  const u64 start,
>>>                                                  const u64 len,
>>> @@ -8265,15 +8138,14 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>         * in the compression of data (in an async thread) and will return
>>>         * before the compression is done and writeback is started. A second
>>>         * filemap_fdatawrite_range() is needed to wait for the compression to
>>> -      * complete and writeback to start. Without this, our user is very
>>> -      * likely to get stale results, because the extents and extent maps for
>>> -      * delalloc regions are only allocated when writeback starts.
>>> +      * complete and writeback to start. We also need to wait for ordered
>>> +      * extents to complete, because our fiemap implementation uses mainly
>>> +      * file extent items to list the extents, searching for extent maps
>>> +      * only for file ranges with holes or prealloc extents to figure out
>>> +      * if we have delalloc in those ranges.
>>>         */
>>>        if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
>>> -             ret = btrfs_fdatawrite_range(inode, 0, LLONG_MAX);
>>> -             if (ret)
>>> -                     return ret;
>>> -             ret = filemap_fdatawait_range(inode->i_mapping, 0, LLONG_MAX);
>>> +             ret = btrfs_wait_ordered_range(inode, 0, LLONG_MAX);
>>>                if (ret)
>>>                        return ret;
>>>        }
