Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710BB6ECA92
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Apr 2023 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjDXKsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Apr 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDXKsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Apr 2023 06:48:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053F3B7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 03:48:11 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Rm-1pZlUo18oQ-00LT0p; Mon, 24
 Apr 2023 12:48:04 +0200
Message-ID: <19523655-234f-a36e-02d7-672554ed427c@gmx.com>
Date:   Mon, 24 Apr 2023 18:48:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef0c22ce3cf2f7941634ed1cb2ca718f04ce675d.1682296794.git.wqu@suse.com>
 <CAL3q7H6vXB9up96vvW2ODccWTWUD5_yqkDip4FWfzz-dGrnXDQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] btrfs: make dev-scrub as an exclusive operation
In-Reply-To: <CAL3q7H6vXB9up96vvW2ODccWTWUD5_yqkDip4FWfzz-dGrnXDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KD+V7XtuD1LLk44JAFiaO63fBLU3AfJ/itdt0Ynokst6XHIlTeC
 2F+iYk8rsoRoV2G9+Y6SUeaWwpxX7gYjPj4GwQu/UBi11IlPdU2K5GLkKIvQEKQMUyVzYpa
 j5Jcps+8C0hdJ2LfB/JCs07C+MQbKerLqXpf37+aPiskfCxObgBZsISemnJqVx67/kQg80u
 t5j28ERfjcov8sjvKDExg==
UI-OutboundReport: notjunk:1;M01:P0:vp9mrPIPvJs=;tZcIVid8DuXi6X8uteyddKIs9eU
 CDwWYOcNPJq4Sgx0MBGHGQgy5iuWR1HTSV3+Q+XFrg3K9Glb6bff9WFdfQkyB1NPPNZuv21J2
 wyO2VFO+A8awnL14Pb4gawH/wV6JwqgkK6fznOOP4EokQAIzc0FUGCmBFiF08JV7KUqoOt6qU
 YTDU8TFWXVI65CxfBPqorIbNpc4r1blGtLUuvSEMvAksQkQGg9Tr/F8EpPMES81p4wCWG6jLf
 Iz0+EXAu8jIT5x6VlljbL9/l7ZU6/v5JFYPcTNOybVMl3nM2I+No8DiGVue9anrSVc6pntBAu
 mF4KxwCTGRWY9XsH19rOQyBLxrjW/rMbcSWBkILzrZ2pDrSFUSr3TSvcZmUDiM2Hib9wLr9iO
 joTwKZpeT0ZSSsffa2PwhM6G3ERY5PXIWLOg13cLPjaoWGzcO66orjyBBHKulvaWAkYIdGo2y
 mXisqy0RysUYz2S3I+a/IxGnuXno3xC79cVg6UJltMbjTFb/z14chWIvHYnjz95xqyfei1g8I
 KigsdCv3dY0cmqOE2YFQToGI/wdgv47WmwqqLT1bOmknfVC1fHjuUv0LGVdlZUfBpCr9Xnr69
 pZka2qvUAAIOLQAQFZNtVlgM+VliZ6UW8I2FRPGARGw729/B0ZKaatXWI1Touue5rp1WTyXlU
 EiTauQzxMW/p3xl5syRCG34rLvS17j2tW+KZli+ZjUvY7E5ys4zbF4nZC6nU+jN3vAQ1j68py
 0a+JRwmIZ6htKdZ/BUXARJPyUQXc/IGUOEIOPwwYS6jc+xGojBOVh09VoYp8oiN6be7TiSsy+
 FMXXA+XW21ln3GqT3jzVvH/0GMYrqqdIgWdOktDQzH2Wrb6bNXE0iZI5oGRsmCAIIV2FdIifJ
 fpak1JQAdWowqrhCyk8Zbmfzt6zcLwp0vQUeRjWRC6wAFP7eJ8gf7x3lQlgyz4qHOwTfT+Izo
 RSBdMu1FDTzBzrCbpnzPufSURA4=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/24 18:14, Filipe Manana wrote:
> On Mon, Apr 24, 2023 at 2:48 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [PROBLEMS]
>> Currently dev-scrub is not an exclusive operation, thus it's possible to
>> run scrub with balance at the same time.
>>
>> But there are possible several problems when such concurrency is
>> involved:
>>
>> - Scrub can lead to false alerts due to removed block groups
>>    When balance is finished, it would delete the source block group
>>    and may even do an discard.
> 
> So, I haven't taken a look at scrub after the recent rewrite you made.
> But some comments on this.
> 
> Scrub has to deal with block groups getting removed anyway, due to the
> automatic removal of empty block groups. The balance case is no different...
> 
> You seem to have missed the fact that  before balance relocates a block group,
> it pauses scrub, and then after finishing the relocation, it allows
> scrub to resume.
> The pausing happens at btrfs_relocate_chunk().
> It only removes the block group  when it's empty...
> 
> Furthermore, transaction commits pause scrub, do the commit root switches with
> scrub paused, and scrub uses (or it used) commit roots to search for
> allocated extents.
> 
> Also, how is that discard problem possible?

The whole case is described by this syzbot report:

https://lore.kernel.org/lkml/00000000000041d47405f9f56290@google.com/

Where we have balance and scrub hitting the problem.

The ASSERT() itself is going to be removed by the scrub rework, but if 
the old code can lead to that ASSERT(), the reworked code should still 
lead to the same situation, as the scrub/balance exclusion code is still 
kept as is.

And in that dmesg, we got quite some tree block bytenr mismatch, which 
indicates the tree block is already zeroed out.

> 
> If a block group is deleted, the discard only happens after the
> corresponding transaction
> is committed, and again, the transaction commit pauses scrub, the
> discard happens while
> scrub is paused (at btrfs_finish_extent_commit()), and scrub uses commit roots.
> 
> At least this used to be true before the recent scrub rewrite...

The syzbot report is before my scrub rework, and the scrub pause code is 
untouched during the rework.

Although I did see your point, a deeper look into the existing scrub 
pause code indeed shows transaction commit would pause scrub before 
switch commit roots.

Allow me to dig deeper to find out why this syzbot can happen.

Thanks,
Qu

> 
> I would like to see a corrected changelog or at least updated to detail exactly
> how these issues can happen.
> 
>>
>>    In that case if a scrub is still running for that block group, we
>>    can lead to false alerts on bad checksum.
>>
>> - Balance is already checking the checksum
>>    Thus we're doing double checksum verification, under most cases it's
>>    just a waste of IO and CPU time.
> 
> So what? If they're done sequentially, it's the same thing...
> Multiple reads can also trigger checksum verification, both direct IO
> and buffered IO.
> 
> Thanks.
> 
>>
>> - Extra chance of unnecessary -ENOSPC
>>    Both balance and scrub would try to mark the target block group
>>    read-only.
>>    With more block groups marked read-only, we have higher chance to
>>    hit early -ENOSPC.
>>
>> [ENHANCEMENT]
>> Let's make dev-scrub as an exclusive operation, but unlike regular
>> exclusive operations, we need to allow multiple dev-scrub to run
>> concurrently.
>>
>> Thus we introduce a new member, fs_info::exclusive_dev_scrubs, to record
>> how many dev scrubs are running.
>> And only set fs_info::exclusive_operation back to NONE when no more
>> dev-scrub is running.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> This change is a change to the dev-scrub behavior, now we have extra
>> error patterns.
>>
>> And some existing test cases would be invalid, as they expect
>> concurrent scrub and balance as a background stress.
>>
>> Although this makes later logical bytenr based scrub much easier to
>> implement (needs to be exclusive with dev-scrub).
>> ---
>>   fs/btrfs/disk-io.c |  1 +
>>   fs/btrfs/fs.h      |  5 ++++-
>>   fs/btrfs/ioctl.c   | 29 ++++++++++++++++++++++++++++-
>>   3 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 59ea049fe7ee..c6323750be18 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2957,6 +2957,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>          atomic_set(&fs_info->async_delalloc_pages, 0);
>>          atomic_set(&fs_info->defrag_running, 0);
>>          atomic_set(&fs_info->nr_delayed_iputs, 0);
>> +       atomic_set(&fs_info->exclusive_dev_scrubs, 0);
>>          atomic64_set(&fs_info->tree_mod_seq, 0);
>>          fs_info->global_root_tree = RB_ROOT;
>>          fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 0d98fc5f6f44..ff7c0c1fb145 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -335,7 +335,7 @@ struct btrfs_discard_ctl {
>>   };
>>
>>   /*
>> - * Exclusive operations (device replace, resize, device add/remove, balance)
>> + * Exclusive operations (device replace, resize, device add/remove, balance, scrub)
>>    */
>>   enum btrfs_exclusive_operation {
>>          BTRFS_EXCLOP_NONE,
>> @@ -344,6 +344,7 @@ enum btrfs_exclusive_operation {
>>          BTRFS_EXCLOP_DEV_ADD,
>>          BTRFS_EXCLOP_DEV_REMOVE,
>>          BTRFS_EXCLOP_DEV_REPLACE,
>> +       BTRFS_EXCLOP_DEV_SCRUB,
>>          BTRFS_EXCLOP_RESIZE,
>>          BTRFS_EXCLOP_SWAP_ACTIVATE,
>>   };
>> @@ -744,6 +745,8 @@ struct btrfs_fs_info {
>>
>>          /* Type of exclusive operation running, protected by super_lock */
>>          enum btrfs_exclusive_operation exclusive_operation;
>> +       /* Number of running dev_scrubs for exclusive operations. */
>> +       atomic_t exclusive_dev_scrubs;
>>
>>          /*
>>           * Zone size > 0 when in ZONED mode, otherwise it's used for a check
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 25833b4eeaf5..4be89198baed 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -403,6 +403,20 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
>>          spin_lock(&fs_info->super_lock);
>>          if (fs_info->exclusive_operation == BTRFS_EXCLOP_NONE) {
>>                  fs_info->exclusive_operation = type;
>> +               if (type == BTRFS_EXCLOP_DEV_SCRUB)
>> +                       atomic_inc(&fs_info->exclusive_dev_scrubs);
>> +               ret = true;
>> +               spin_unlock(&fs_info->super_lock);
>> +               return ret;
>> +       }
>> +
>> +       /*
>> +        * For dev-scrub, we allow multiple scrubs to be run concurrently
>> +        * as it's a per-device operation.
>> +        */
>> +       if (type == BTRFS_EXCLOP_DEV_SCRUB &&
>> +           fs_info->exclusive_operation == type) {
>> +               atomic_inc(&fs_info->exclusive_dev_scrubs);
>>                  ret = true;
>>          }
>>          spin_unlock(&fs_info->super_lock);
>> @@ -442,7 +456,12 @@ void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info)
>>   void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
>>   {
>>          spin_lock(&fs_info->super_lock);
>> -       WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
>> +       if (fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_SCRUB) {
>> +               if (atomic_dec_and_test(&fs_info->exclusive_dev_scrubs))
>> +                       WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
>> +       } else {
>> +               WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
>> +       }
>>          spin_unlock(&fs_info->super_lock);
>>          sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
>>   }
>> @@ -3172,9 +3191,17 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
>>                          goto out;
>>          }
>>
>> +       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_SCRUB)) {
>> +               ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
>> +               if (!(sa->flags & BTRFS_SCRUB_READONLY))
>> +                       mnt_drop_write_file(file);
>> +               goto out;
>> +       }
>> +
>>          ret = btrfs_scrub_dev(fs_info, sa->devid, sa->start, sa->end,
>>                                &sa->progress, sa->flags & BTRFS_SCRUB_READONLY,
>>                                0);
>> +       btrfs_exclop_finish(fs_info);
>>
>>          /*
>>           * Copy scrub args to user space even if btrfs_scrub_dev() returned an
>> --
>> 2.39.2
>>
