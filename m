Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83D6A7B80
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 07:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCBGtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 01:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBGtN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 01:49:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339B1A969
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 22:49:11 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1qD1FP1krG-00fPfU; Thu, 02
 Mar 2023 07:49:06 +0100
Message-ID: <b435b22b-10fa-e212-7167-fd023efef07f@gmx.com>
Date:   Thu, 2 Mar 2023 14:49:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
 <057a597a-d4df-3b76-1d72-8b60fd683a7f@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <057a597a-d4df-3b76-1d72-8b60fd683a7f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oEHFPZJkTtWpiBoZ68w7O3ZJ6+a+XBH4xAAU0NSkHE7kVZdxUf0
 DfQ0THSiNx8cvLI07Sh02d2C4DQwO8c8z4promJmg496X6b0zZVwx7qWSzPMwqY66/hYFjB
 zQe20LKbRzDRdHscprVpb2jkY1dpKeGvv4nFoeCNCKvn2zE4momDkwDcxrIAspIJO74VsSi
 6cU0TcHe9/mX7j78YjEjg==
UI-OutboundReport: notjunk:1;M01:P0:IJwgV4tt8zo=;Yf11izfRh0F807sbnwMSWpLQYRJ
 xV8B5luiO1dY5Jck2CDmdHH//cimtJEdM+ZDlAJl4H3e9sBNXWV4ozoNPQ6l0VrSuRt/oKMHD
 rtbrW9ELPBX19aUyzfLOSH2ptXKkIa2JFUczUvGtEcWIQpzOJSRqoOI24H+kup5gD3nE0A3r7
 KkgAi//2co7GeGryPTWgVnQduPx5kgH3Tsv5EdRH2gkpl7UWzRrfz16THnHG0TOQZF9FKS492
 yqZAOppSEMPstAb71r1LRDslwJev7x+7ZwNLR19vGnYV4bMLiNmiIrfEWlLWS8g5Z1WZgm0x4
 URMhYb65QO4ZVxeTr1DYsAo4AqnD3cL+n/d1WwcV5NDEd12TEbZOpCdtafk/TJshiG+cffMuo
 AiCuXwn9N4gfDZujq5MXZG/YiZhHQisWrNcwIIi2ZoMu6f+EOuyOSPci6oGgBbSt6lSj4zfSc
 lnxWoSYfVvW3Yd6xgWKeqIlwvk7fkhnIKICL28CzqajcQaRxciow9GRASedCF892HsNgcQ7Y6
 t5t3H9JrusKSjP9DYDftMRbL8pRfgFqw4nBmYuuve6/Aw+MrUZyiaQiPItq3szWMT9EArlJDQ
 gaSsgawgQH4d50MjIVhWegZE4jPJhenX+mgKUleWhstUAgfwzgKdlTSHP7Rq37avfo4mPkofp
 z6I3HdZW/tj2pS6FW6qz4Pmi3ucLYaNmA+B4bDnQoSG3NA5twDVkLB7S6QZVm7xqXB+fFuxIt
 aQb+fQyg8w+oDGR9C/VkLCpoUoPe8FjzTTMz72UFxHNwxWH1NUYHev5nBaoZG61e06LWFVtVt
 Z/SzG0MZnaqYXn0vPR33YDy9R9w25ADDv3FjJX6rh5+Xl3kfhxxQjDvtsQes5K/rWSpOJlYOC
 V/GlNNrZRpbJiXLCCjrh/jC4QeY4E1cNWIkFCp4fq3tugY2JUr8vm9fZ/srv5kbp86pnhsH5O
 AOqwngogKV3a0SJoLkEHjpIdG34=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/2 14:12, Anand Jain wrote:
> On 3/2/23 09:54, Qu Wenruo wrote:
>> [BUG]
>> During my scrub rework, I did a stupid thing like this:
>>
>>          bio->bi_iter.bi_sector = stripe->logical;
>>          btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
>>
>> Above bi_sector assignment is using logical address directly, which
>> lacks ">> SECTOR_SHIFT".
>>
>> This results a read on a range which has no chunk mapping.
>>
>> This results the following crash:
>>
>>   BTRFS critical (device dm-1): unable to find logical 11274289152 
>> length 65536
>>   assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>>   ------------[ cut here ]------------
>>
>> Sure this is all my fault, but this shows a possible problem in real
>> world, that some bitflip in file extents/tree block can point to
>> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
>> is not configured, cause invalid pointer.
>>
>> [PROBLEMS]
>> In above call chain, we just don't handle the possible error from
>> btrfs_get_chunk_map() inside __btrfs_map_block().
>>
>> [FIX]
>> The fix is pretty straightforward, just replace the ASSERT() with proper
>> error handling.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Rebased to latest misc-next
>>    The error path in bio.c is already fixed, thus only need to replace
>>    the ASSERT() in __btrfs_map_block().
>> ---
>>   fs/btrfs/volumes.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 4d479ac233a4..93bc45001e68 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info 
>> *fs_info, enum btrfs_map_op op,
>>           return -EINVAL;
>>       em = btrfs_get_chunk_map(fs_info, logical, *length);
>> -    ASSERT(!IS_ERR(em));
>> +    if (IS_ERR(em))
>> +        return PTR_ERR(em);
> 
> 
> Consider adding btrfs_err_rl() here.
> Except for scrub_find_good_copy(), the other functions do not report
> such errors.
> Furthermore, scrub_find_good_copy() lack sufficient details for
> effective debugging in the event of an issue.

Function btrfs_get_chunk_map() would already output an error message.

Thanks,
Qu
> 
> 
>>       map = em->map_lookup;
>>       data_stripes = nr_data_stripes(map);
> 
> 
> 
> 
> 
> 
