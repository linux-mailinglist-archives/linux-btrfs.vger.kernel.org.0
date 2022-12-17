Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0AD64F6F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 03:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLQCKh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 21:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQCKf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 21:10:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B720183
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 18:10:33 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGRp-1pG4uU2oJB-00PfQY; Sat, 17
 Dec 2022 03:10:28 +0100
Message-ID: <6f22220e-f660-92d2-5241-fb9a353090ac@gmx.com>
Date:   Sat, 17 Dec 2022 10:10:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1670451918.git.josef@toxicpanda.com>
 <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
 <0507a942-2a82-f086-2be5-a9ac64e4c1d3@gmx.com>
Subject: Re: [PATCH 2/8] btrfs: do not check header generation in
 btrfs_clean_tree_block
In-Reply-To: <0507a942-2a82-f086-2be5-a9ac64e4c1d3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l58ebM2c+8dFt3pvBKPQBE+VJCf2N/PiPO9WNj3y1Y7m62NxDtX
 SulcSsiGc67IjqhOh6RfB1/+UKH3EZXW3WeDLryWpsRAX/B3nmrSlMBNa57kJVmylzNU/Og
 cDdVyV2xaCWdPioSXWEiUhDIVoxKG+NWm0ryPf93iOUn243ANzwkJBKt3yvrRvflDjp5f9u
 xQ8U6OlomkmSdgpwABieg==
UI-OutboundReport: notjunk:1;M01:P0:maB8ZGzTeL8=;RuoOuIt0rtI6X2W4lS/lC8Cob24
 xKdn9DjZpqa7AfNmJLNssuwdBSOBu1NNlIepSNYSh8CDcvrXkX8XT3vv8Qp58gYXwKbYAVaWi
 772j4mOdn2ahSHNVEcZ6RLn2rG2O+J2yMTSXZBneAqFDH4Wop6CXOJEBYIWvAb+plCzBWggqO
 u5IliKu0BW/uvlpVvSBxh8r3u+Lr8762bkZx8RMFGKN7rNeLD0TBAmuVOgwWqmZghapxE7MUE
 cBDimx5lUQ4m50GGWeO/YUvG+ocrdu4gEZ8aTaHUdrVZ09dnjvZ3SEO7fvx8p+qfzMEijhkP2
 CfjtiBOmycAUYFCpHPRfqMITTd6xOlps6OaAS50/VS9Mc9zcSdGi1L5BsvBhpnjXzJ8JkNu3w
 DX0p77KwEUMQWG4PqggiqXVYc0SPS/rYJJMpEdSJ411pnmYxedZwpmjPEFgZMRFnbYCKVUdaF
 w0YCgkBovcpryN2vWZtx3EtY794ROkh4zgqJ9d2oY2REzd1M47zE2XJ+CJQd43vh1eaTL2ZPY
 qPwSDB9HQcH8uDurlkUXeYvkZujvLenEUSVKcO16m9pM7IpXZ85kZNXx1GgxGHvwhs8Kb1kf5
 b3hqhGhCc8ASMKATUp9c6O3YcGN/ASKRGTYANySbDKqOx00NWlsVwWmgAhJKp6cWD9PPe3umH
 wuKnNiZO+ufANW9JEw8faUsm1p8koXpqdeaMLoOgKP8xhTMMZSqvqCFZmpDD85PnnoV8UHi/W
 S14AzGuxcK6yFhdp3cT4L/+4h5M51c91Nrr6cdB3yDCAco4C1pIrL44EwOUfdrJJ3JftJHdsM
 Dt524/m4SVT6p0EGViTl/m2kUwTsC/Jf4bhQeMTp/6QtcIijlgJ7Rx4LFPQSsEcytPGICUfc8
 X+8z5+93G8s0n/u8QqJICm2P6VX5/J0DQ5rp47YjyncBKOKQ+ofnUsVBm/zgLDfiojWcVlzZV
 eos4fTEmBxyigACmrnB3XLjLLNw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/16 13:32, Qu Wenruo wrote:
> 
> 
> On 2022/12/8 06:28, Josef Bacik wrote:
>> This check is from an era where we didn't have a per-extent buffer dirty
>> flag, we just messed with the page bits.  All the places we call this
>> function are when we have a transaction open, so just skip this check
>> and rely on the dirty flag.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> This patch is failing a lot of test cases, mostly scrub related 
> (btrfs/072, btrfs/074).
> 
> Now we will report all kinds of errors during scrub.
> Which seems weird, as scrub doesn't use the regular extent buffer 
> helpers at all...
> 
> Maybe it's related to the generation we got during the extent tree search?
> As all the failures points to generation mismatch during scrub.

I got some extra digging, and it turns out that, if we unconditionally 
clear the EXTENT_BUFFER_DIRTY flags, we can miss some tree blocks 
writeback for commit root.

Here is some trace for one extent buffer:

     btrfs_init_new_buffer: eb 7110656 set generation 13
     btrfs_clean_tree_block: eb 7110656 gen 13 dirty 0 running trans 13
     __btrfs_cow_block: eb 7110656 set generation 13

Above 3 lines are where the eb 7110656 got created as a cowed tree block.

     update_ref_for_cow: root 1 buf 6930432 gen 12 cow 7110656 gen 13

The eb 7110656 is cowed from 6930432, and that's created at transid 13.

     update_ref_for_cow: root 1 buf 7110656 gen 13 cow 7192576 gen 14

But that eb 7110656 got CoWed again in transaction 14. Which means, eb 
7110656 is no longer referred in transid 14, but is still referred in 
transid 13.

     btrfs_clean_tree_block: eb 7110656 gen 13 dirty 1 running trans 14

Here inside update_ref_for_cow(), we clear the dirty flag for eb 7110656.

This has a consequence that, the tree block 7110656 will not be written 
back, even it's still referred in transid 13.

This is where the problem is, previously we will continue writing back 
eb 7110656, as its transid is not the running transid, meaning some 
commit root still needs it.

Especially note that, I have added trace output for any tree block write 
back (in btree_csum_one_bio()).
But there is no such trace, meaning the tree block is never properly 
written back.

This also exposed another problem, if we didn't properly writeback tree 
blocks in commit root, we break COW, thus no proper transactional 
protection for our metadata.

     scrub_simple_mirror: tree 7110656 mirror 1 wanted generation 13
                          running trans 14
     scrub_checksum_tree_block: tree generation mismatch, tree 7110656
                                mirror 1 running trans 14, has 15 want 13
     scrub_checksum_tree_block: tree generation mismatch, tree 7110656
                                mirror 0 running trans 14, has 15 want 13

The above lines just shows the scrub failure for it.
As the tree block is not properly written back, we just read out some 
garbage.

And unfortunately our scrub code only checks bytenr, then generation, 
not even checking the fsid, thus we got the generation mismatch error.

     ...
     btree_csum_one_bio: eb 7110656 gen 26

There is an example to prove that, I have added tree block writeback 
trace event.

Thus I'd prefer to have at least a comment explaining why we can not 
just clean the dirty bit for a dirty eb which is not dirtied during the 
current running transaction.

Thanks,
Qu


> 
> Thanks,
> Qu
> 
>> ---
>>   fs/btrfs/disk-io.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index d0ed52cab304..267163e546a5 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -968,16 +968,13 @@ struct extent_buffer *read_tree_block(struct 
>> btrfs_fs_info *fs_info, u64 bytenr,
>>   void btrfs_clean_tree_block(struct extent_buffer *buf)
>>   {
>>       struct btrfs_fs_info *fs_info = buf->fs_info;
>> -    if (btrfs_header_generation(buf) ==
>> -        fs_info->running_transaction->transid) {
>> -        btrfs_assert_tree_write_locked(buf);
>> +    btrfs_assert_tree_write_locked(buf);
>> -        if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
>> -            percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
>> -                         -buf->len,
>> -                         fs_info->dirty_metadata_batch);
>> -            clear_extent_buffer_dirty(buf);
>> -        }
>> +    if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
>> +        percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
>> +                     -buf->len,
>> +                     fs_info->dirty_metadata_batch);
>> +        clear_extent_buffer_dirty(buf);
>>       }
>>   }
