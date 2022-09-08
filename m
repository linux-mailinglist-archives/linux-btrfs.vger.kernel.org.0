Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEE5B1BBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiIHLlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIHLlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 07:41:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F611CD4A
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662637267;
        bh=ItCzICiS1yANo51PaK8/wPH3ThieSh4f61E1wxDSsVs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=lgGknLS0Ox9tjxC7FzlOY33z2BZDDGGGf/UvjkYNUIEp8BHMMFIWliRqGP3alWOCW
         lW9LD/ojzpY6XM+CZRUhvtqpSJlw7J5ApVP3p42uOVMQlbobBiJyuqWJUlPv+JHdOh
         r9GzQ2t7Q81SvEWm1EwA5v1N8KW4yoSHLRbqry7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1ols9B3K8Z-00KkJ0; Thu, 08
 Sep 2022 13:41:07 +0200
Message-ID: <d5c982b6-b89e-dae0-2aee-dbc7a4e43c1a@gmx.com>
Date:   Thu, 8 Sep 2022 19:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
 <CAL3q7H5d1mkMwfR-mfT8DydHbfys7_2kMg_xxS5yyrnTPvRHyA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: don't update the block group item if used bytes
 are the same
In-Reply-To: <CAL3q7H5d1mkMwfR-mfT8DydHbfys7_2kMg_xxS5yyrnTPvRHyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iEzyzkyTF9+jGSONkQKZGYHyLPCMyAR5/5CZIGuuSKMq+JACLYM
 0fR+HtbDxyFQpLW2xMvab0kcLFCNgwC2+PFQhQwKCutHqswwxilWAeTC9ZF6m8bcUXU0ayi
 dv8pim6Y55toDsraeQGAUdf/cbYqVkxKQc4mhZod6aFJk0viddqeOVqlnrPs92g7BIwlXZs
 v+e4Cckz19Cdql47Xt77Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ZZ6DPj4xSI=:j3VjpXQIQ8AdseSaC1kOfm
 o98LYkumf3DwEc0vTC2brqwmly/AvVvyvEk6OvZJnezo5mj8JzSyl0ShiUG7I8mCTgARIBKrU
 1/vfSaOwmIw/9mNfF1AFej6Q2GyeHyty6nZBnnFY4/BWy3luqZJMilXscwE2sLaDr6zSifIRF
 dh28jFOiyANNi+cUliDRsjCwaZJxEij8kfssF0AE2tv1YzuQ1TwzYs9Ehzr9Zp4burObyBD/8
 VbZf/RNoZCJDJqlb0XiwEQjNPRgEMhBkXXvInpNMv08UuS1u5YbYvNfoRYE1pc4YwCcak/Z7X
 1rWTJ5el7au1OXnkVhsK9++gYruZZx2e54BIkbwKWCISMQ1laO7FPuBtqKDxkBCk1aOU5h0HI
 tXQzlTpi7hSjtIGf3/9KjW8Iw+EEAwgbfPi0a8P+S3LvnUJb+8/ql0PBw6zzeiRP0E1g7Bwau
 Ph6AdNQBORUDmGQBJ7PJZoSw4XLJjNCDLRitW1rX4HjyeFF5kH4DrsbGkIVPWY8hQHKOfhJWi
 2LOXzvIEQGXx/biuqg7vJeLvqyTGFkTCM4GOdYk+M7AqvT9JwlssCt5snhxtXvvlDUBdfHBk9
 9WOnoRq9tNtlRzmdiRmVwdBUQnzoA6L/w08P603JCaSkXgLfM1ApL4Out+z7FgkKGOvtiQ2s4
 SZRUT0GMBz86BlxQ9/T5ty49a+Oriz/FoEi8JoPbEhZ5o48p1od8X1tQDdEYW5NMbfSJbcOb6
 TnHrZuUP2luwfjCroG0FQOVTgNWRWDY206BuD6itjMetH10OGXf4lG+c8DjDW8Hy/xa607dTU
 KnoQBLoIWe/FPnVaP4NmnQUt5DiK83LKS0G8E1bnltqUFfODLaAgZHVKnhDugiS/YJ59COdI5
 Q1CBxLuICXgKa6qetCUBeVZpGEChb6bCamGo6Eq/Gq9BPvB1f0tFeeNlLc/9D4wI2z4K98/7U
 N7tj6Khb5Su4lstPyvkolQbfQxjybXsiG+3SBZAYmnihEZ3YkSMQiQVe+RoH0+CB+FpO+83A+
 3sSgomhxnJf37CYxydanKZK9yYhoq1AtY/6DjA711faPiD5LGfuiTFLJ+JxffK5o4Mi6qXh1K
 8mXeIh899J8ePGBeGDMw5bo7PQCL9Z/VYj0SuwXgdQGfpWi4vHDA4npHnOF9lxxAIAmuNMYpv
 dM1lyI8aQrM/coTbUPUPQx4gKQ
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/8 18:31, Filipe Manana wrote:
> On Thu, Sep 8, 2022 at 7:40 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BACKGROUND]
>>
>> When committing a transaction, we will update block group items for all
>> dirty block groups.
>>
>> But in fact, dirty block groups don't always need to update their block
>> group items.
>> It's pretty common to have a metadata block group which experienced
>> several CoW operations, but still have the same amount of used bytes.
>>
>> In that case, we may unnecessarily CoW a tree block doing nothing.
>>
>> [ENHANCEMENT]
>>
>> This patch will introduce btrfs_block_group::commit_used member to
>> remember the last used bytes, and use that new member to skip
>> unnecessary block group item update.
>>
>> This would be more common for large fs, which metadata block group can
>> be as large as 1GiB, containing at most 64K metadata items.
>>
>> In that case, if CoW added and the deleted one metadata item near the e=
nd
>> of the block group, then it's completely possible we don't need to touc=
h
>> the block group item at all.
>>
>> [BENCHMARK]
>>
>> To properly benchmark how many block group items we skipped the update,
>> I added some members into btrfs_tranaction to record how many times
>> update_block_group_item() is called, and how many of them are skipped.
>>
>> Then with a single line fio to trigger the workload on a newly created
>> btrfs:
>>
>>    fio --filename=3D$mnt/file --size=3D4G --rw=3Drandrw --bs=3D32k --io=
engine=3Dlibaio \
>>        --direct=3D1 --iodepth=3D64 --runtime=3D120 --numjobs=3D4 --name=
=3Drandom_rw \
>>        --fallocate=3Dposix
>
> And did this improve fio's numbers? Throughput, latency?
> It's odd to paste a test here and not mention its results. I suppose
> it didn't make
> a difference, but even if not, it should be explicitly stated.

Unfortunately that test is run with my extra debugging patch (to show if
the patch works).
Thus I didn't take the fio numbers too seriously.

And if I'm going to do a real tests, I'd remove the fallocate, decrease
the blocksize, and do more loops, and other VM tunings to get a more
performance orient tests.

Just for reference, here is the script I slightly modified:

fio --filename=3D$mnt/file --size=3D2G --rw=3Drandwrite --bs=3D4k
=2D-ioengine=3Dlibaio --iodepth=3D64 --runtime=3D300 --numjobs=3D4
=2D-name=3Drandom_write --fallocate=3Dnone

And with my VM tuned for perf tests (no heavy debug config, dedicated
SATA SSD, none cache mode, less memory, larger file size).

[BEFORE]
   WRITE: bw=3D32.3MiB/s (33.9MB/s), 8269KiB/s-8315KiB/s
(8468kB/s-8515kB/s), io=3D8192MiB (8590MB), run=3D252210-253603msec

[AFTER]
WRITE: bw=3D31.7MiB/s (33.3MB/s), 8124KiB/s-8184KiB/s (8319kB/s-8380kB/s),
io=3D8192MiB (8590MB), run=3D256257-258135msec

So in fact it's even worse performance, which I can not explain at all...

>
> In this case, less extent tree updates can result in better
> concurrency for the nocow checks,
> which need to check the extent tree.
>
>>
>> Then I got 101 transaction committed during that fio command, and a
>> total of 2062 update_block_group_item() calls, in which 1241 can be
>> skipped.
>>
>> This is already a good 60% got skipped.
>>
>> The full analyse can be found here:
>> https://docs.google.com/spreadsheets/d/e/2PACX-1vTbjhqqqxoebnQM_ZJzSM1r=
F7EY7I1IRbAzZjv19imcDHsVDA7qeA_-MzXxltFZ0kHBjxMA15s2CSH8/pubhtml
>
> Not sure if keeping an url to an external source that is not
> guaranteed to be available "forever" is a good practice.
> It also doesn't seem to provide any substantial value, as you have
> already mentioned above some numbers.
>
>>
>> Furthermore, since I have per-trans accounting, it shows that initially
>> we have a very low percentage of skipped block group item update.
>>
>> This is expected since we're inserting a lot of new file extents
>> initially, thus the metadata usage is going to increase.
>>
>> But after the initial 3 transactions, all later transactions are have a
>
> "are have" -> "have"
>
>> very stable 40~80% skip rate, mostly proving the patch is working.
>>
>> Although such high skip rate is not always a huge win, as for
>> our later block group tree feature, we will have a much higher chance t=
o
>> have a block group item already COWed, thus can skip some COW work.
>>
>> But still, skipping a full COW search on extent tree is always a good
>> thing, especially when the benefit almost comes from thin-air.
>
> Agreed, it's a good thing.
>
> Were there other benefits observed, like for example less IO due to less=
 COW?
> Or transaction commits taking less time?

I can definitely do that, but just from fio numbers, it doesn't seem to
help at all?

Thanks,
Qu
>
> Thanks.
>
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> [Josef pinned down the race and provided a fix]
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/block-group.c | 20 +++++++++++++++++++-
>>   fs/btrfs/block-group.h |  6 ++++++
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index e7b5a54c8258..0df4d98df278 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_i=
nfo *info,
>>
>>          cache->length =3D key->offset;
>>          cache->used =3D btrfs_stack_block_group_used(bgi);
>> +       cache->commit_used =3D cache->used;
>>          cache->flags =3D btrfs_stack_block_group_flags(bgi);
>>          cache->global_root_id =3D btrfs_stack_block_group_chunk_object=
id(bgi);
>>
>> @@ -2693,6 +2694,22 @@ static int update_block_group_item(struct btrfs_=
trans_handle *trans,
>>          struct extent_buffer *leaf;
>>          struct btrfs_block_group_item bgi;
>>          struct btrfs_key key;
>> +       u64 used;
>> +
>> +       /*
>> +        * Block group items update can be triggered out of commit tran=
saction
>> +        * critical section, thus we need a consistent view of used byt=
es.
>> +        * We can not direct use cache->used out of the spin lock, as i=
t
>> +        * may be changed.
>> +        */
>> +       spin_lock(&cache->lock);
>> +       used =3D cache->used;
>> +       /* No change in used bytes, can safely skip it. */
>> +       if (cache->commit_used =3D=3D used) {
>> +               spin_unlock(&cache->lock);
>> +               return 0;
>> +       }
>> +       spin_unlock(&cache->lock);
>>
>>          key.objectid =3D cache->start;
>>          key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>> @@ -2707,12 +2724,13 @@ static int update_block_group_item(struct btrfs=
_trans_handle *trans,
>>
>>          leaf =3D path->nodes[0];
>>          bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
>> -       btrfs_set_stack_block_group_used(&bgi, cache->used);
>> +       btrfs_set_stack_block_group_used(&bgi, used);
>>          btrfs_set_stack_block_group_chunk_objectid(&bgi,
>>                                                     cache->global_root_=
id);
>>          btrfs_set_stack_block_group_flags(&bgi, cache->flags);
>>          write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>>          btrfs_mark_buffer_dirty(leaf);
>> +       cache->commit_used =3D used;
>>   fail:
>>          btrfs_release_path(path);
>>          return ret;
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index f48db81d1d56..b57718020104 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -84,6 +84,12 @@ struct btrfs_block_group {
>>          u64 cache_generation;
>>          u64 global_root_id;
>>
>> +       /*
>> +        * The last committed used bytes of this block group, if above =
@used
>> +        * is still the same as @commit_used, we don't need to update b=
lock
>> +        * group item of this block group.
>> +        */
>> +       u64 commit_used;
>>          /*
>>           * If the free space extent count exceeds this number, convert=
 the block
>>           * group to bitmaps.
>> --
>> 2.37.3
>>
>
>
