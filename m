Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4B64AE47
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 04:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiLMDfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 22:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiLMDe6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 22:34:58 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3CF1B9CF
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 19:34:56 -0800 (PST)
Subject: Re: [PATCH 3/3] btrfs: add snapshot_lock to new_fs_root_args
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670902494; bh=gavi6xY9EyojPDB7qzL+LiCuDuQ3zl2c1AmkoDbS/as=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PqIhGni62RWkJaRMZGF1N6f3jTVV1kzfFd5NGl7zsIReYNz0r/Bz5JSr/GabtbYZh
         2VJiyfubtexoc78IrtC8HzJc6om967A0MUiu8jbuNAj67Y0K1hY1YlEQJQwxbShZbw
         IZ22XO0rfpfd+V/uAch9I8JRT85BfLb7NbdrHuJQ=
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20221205095122.17011-1-robbieko@synology.com>
 <20221205095122.17011-4-robbieko@synology.com>
 <CAL3q7H5aMnihK3rDWweFgzDYsDjigDxR8xitCG2vVjYQu55MEA@mail.gmail.com>
From:   robbieko <robbieko@synology.com>
Message-ID: <07d54d9f-10b4-1acf-1360-21f8ef063c4d@synology.com>
Date:   Tue, 13 Dec 2022 11:34:53 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5aMnihK3rDWweFgzDYsDjigDxR8xitCG2vVjYQu55MEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Filipe Manana 於 2022/12/13 上午1:06 寫道:
> On Mon, Dec 5, 2022 at 10:36 AM robbieko <robbieko@synology.com> wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> Add snapshot_lock into new_fs_root_args to prevent
>> percpu_counter_init enter unexpected -ENOMEM when
>> calling btrfs_init_fs_root.
> You could be more detailed here and mention that all this is to
> prevent transaction aborts in case percpu_counter_init() fails to
> allocate memory.
>
> Interpreting literally what you wrote, it gives the idea that after
> this patch the memory allocation can never fail, which isn't true.
> The goal is just to allocate the snapshot lock before holding a
> transaction handle, so that we can use GFP_KERNEL, which reduces the
> chances of memory allocation failing and, above all, avoid aborting a
> transaction and turn the fs to RO mode.

Okay. I will fix the commit message to provide a more detailed description.

Thanks.

>
>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>>   fs/btrfs/disk-io.c | 44 +++++++++++++++++++++++++++++++-------------
>>   fs/btrfs/disk-io.h |  2 ++
>>   2 files changed, 33 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 5760c2b1a100..5704c8f5873c 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1437,6 +1437,16 @@ struct btrfs_new_fs_root_args *btrfs_new_fs_root_args_prepare(gfp_t gfp_mask)
>>          if (err)
>>                  goto error;
>>
>> +       args->snapshot_lock = kzalloc(sizeof(*args->snapshot_lock), gfp_mask);
>> +       if (!args->snapshot_lock) {
>> +               err = -ENOMEM;
>> +               goto error;
>> +       }
>> +       ASSERT((gfp_mask & GFP_KERNEL) == GFP_KERNEL);
> As commented for patch 1/3, we could get away with the argument and
> directly use GFP_KERNEL above, and let lockdep warn us (which makes
> fstests fail).
Okay.
>
>> +       err = btrfs_drew_lock_init(args->snapshot_lock);
>> +       if (err)
>> +               goto error;
>> +
>>          return args;
>>
>>   error:
>> @@ -1448,6 +1458,9 @@ void btrfs_new_fs_root_args_destroy(struct btrfs_new_fs_root_args *args)
>>   {
>>          if (!args)
>>                  return;
>> +       if (args->snapshot_lock)
>> +               btrfs_drew_lock_destroy(args->snapshot_lock);
>> +       kfree(args->snapshot_lock);
> You could combine the kfree of the lock inside the if statement,
> making it more clear imo.
Okay.
>
>>          if (args->anon_dev)
>>                  free_anon_bdev(args->anon_dev);
>>          kfree(args);
>> @@ -1464,20 +1477,25 @@ static int btrfs_init_fs_root(struct btrfs_root *root,
>>          int ret;
>>          unsigned int nofs_flag;
>>
>> -       root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
>> -       if (!root->snapshot_lock) {
>> -               ret = -ENOMEM;
>> -               goto fail;
>> +       if (new_fs_root_args && new_fs_root_args->snapshot_lock) {
>> +               root->snapshot_lock = new_fs_root_args->snapshot_lock;
>> +               new_fs_root_args->snapshot_lock = NULL;
>> +       } else {
>> +               root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
>> +               if (!root->snapshot_lock) {
>> +                       ret = -ENOMEM;
>> +                       goto fail;
>> +               }
>> +               /*
>> +                * We might be called under a transaction (e.g. indirect backref
>> +                * resolution) which could deadlock if it triggers memory reclaim
> While here, we could end the sentence with punctuation (.).
Okay.
> Thanks.
>
>> +                */
>> +               nofs_flag = memalloc_nofs_save();
>> +               ret = btrfs_drew_lock_init(root->snapshot_lock);
>> +               memalloc_nofs_restore(nofs_flag);
>> +               if (ret)
>> +                       goto fail;
>>          }
>> -       /*
>> -        * We might be called under a transaction (e.g. indirect backref
>> -        * resolution) which could deadlock if it triggers memory reclaim
>> -        */
>> -       nofs_flag = memalloc_nofs_save();
>> -       ret = btrfs_drew_lock_init(root->snapshot_lock);
>> -       memalloc_nofs_restore(nofs_flag);
>> -       if (ret)
>> -               goto fail;
>>
>>          if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
>>              !btrfs_is_data_reloc_root(root)) {
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index a7c91bfb0c16..0e84927859ce 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -28,6 +28,8 @@ static inline u64 btrfs_sb_offset(int mirror)
>>   struct btrfs_new_fs_root_args {
>>          /* Preallocated anonymous block device number */
>>          dev_t anon_dev;
>> +       /* Preallocated snapshot lock */
>> +       struct btrfs_drew_lock *snapshot_lock;
>>   };
>>
>>   struct btrfs_device;
>> --
>> 2.17.1
>>
