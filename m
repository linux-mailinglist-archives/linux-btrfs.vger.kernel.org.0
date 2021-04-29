Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA936E2E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 03:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhD2BRv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 21:17:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17405 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD2BRu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 21:17:50 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FVyGV6HzrzlZvN;
        Thu, 29 Apr 2021 09:14:58 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Apr 2021
 09:16:53 +0800
Subject: Re: [PATCH] btrfs: delete unneeded assignments in btrfs_defrag_file
To:     <dsterba@suse.cz>, Tian Tao <tiantao6@hisilicon.com>, <clm@fb.com>,
        <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>
References: <1619488221-29490-1-git-send-email-tiantao6@hisilicon.com>
 <20210428180243.GS7604@twin.jikos.cz>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <0c116d82-3334-ed4e-fb69-76c1c6c8343a@huawei.com>
Date:   Thu, 29 Apr 2021 09:16:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210428180243.GS7604@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


在 2021/4/29 2:02, David Sterba 写道:
> On Tue, Apr 27, 2021 at 09:50:21AM +0800, Tian Tao wrote:
>> ret is assigned -EAGAIN at line 1455 and then reassigned defrag_count
>> at line 1547 after exiting the while loop, but the btrfs_defrag_file
>> function returns a negative number indicating that the execution failed
>> because it does not make sense to reassign defrag_count to ret, so
>> delete it.
> The line references are fragile, so the 1455 is after defrag is
> cancelled.
>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   fs/btrfs/ioctl.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index ee1dbab..2b3b228 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1544,8 +1544,6 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>>   		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
>>   	}
>>   
>> -	ret = defrag_count;
> But this would change semantics of the whole function, after deleting
> this line any stale value of 'ret' would be returned, it's used for some
> intermediate return values in the whole while loop.
>
> 1597                 if (btrfs_defrag_cancelled(fs_info)) {
> 1598                         btrfs_debug(fs_info, "defrag_file cancelled");
> 1599                         ret = -EAGAIN;
> 1600                         break;
> 1601                 }
>
> Jumping to the 'out_ra' label looks like a candidate fix but that also
> jumps around all the incompat bit setting, so that could in some cases
> miss to set them properly. And actually this is a problem with all the
> other error cases.
>
> I'm not yet sure what's the proper fix, but the errors from within the
> while loop should be returned and incompat bits set.

How does the following change look?

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ee1dbab..b8e496e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1453,7 +1453,7 @@ int btrfs_defrag_file(struct inode *inode, struct 
file *file,
                 if (btrfs_defrag_cancelled(fs_info)) {
                         btrfs_debug(fs_info, "defrag_file cancelled");
                         ret = -EAGAIN;
-                       break;
+                      goto error;
                 }

                 if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
@@ -1531,6 +1531,9 @@ int btrfs_defrag_file(struct inode *inode, struct 
file *file,
                 }
         }

+       ret = defrag_count;
+
+error:
         if ((range->flags & BTRFS_DEFRAG_RANGE_START_IO)) {
                 filemap_flush(inode->i_mapping);
                 if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
@@ -1544,8 +1547,6 @@ int btrfs_defrag_file(struct inode *inode, struct 
file *file,
                 btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
         }

-       ret = defrag_count;
-
  out_ra:
         if (do_compress) {
                 btrfs_inode_lock(inode, 0);

> .
>

