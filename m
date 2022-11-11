Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05CC624FEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 02:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiKKBup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 20:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiKKBuo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 20:50:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6BE11C0E;
        Thu, 10 Nov 2022 17:50:42 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7hQV34YlzqSJ3;
        Fri, 11 Nov 2022 09:46:58 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 09:50:40 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 09:50:39 +0800
Message-ID: <3dfb3cf4-6b6d-31bb-236e-6234ded94b03@huawei.com>
Date:   Fri, 11 Nov 2022 09:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, <clm@fb.com>,
        <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
 <335ddbf7-ea4b-157f-be77-a729d798fd03@gmx.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <335ddbf7-ea4b-157f-be77-a729d798fd03@gmx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes, at least two places will sleep in btrfs_search_slot():

   update_qgroup_limit_item
     btrfs_search_slot
       setup_nodes_for_search
         reada_for_balance
           btrfs_readahead_node_child
             btrfs_readahead_tree_block
               btrfs_find_create_tree_block
                 alloc_extent_buffer
                   kmem_cache_zalloc
                     /* will sleep */
                     kmem_cache_alloc(GFP_NOFS|__GFP_NOFAIL|__GFP_ZERO)
               read_extent_buffer_pages
                 submit_extent_page
                   submit_one_bio /* disk IO, will sleep */

在 2022/11/11 6:58, Qu Wenruo 写道:
> 
> 
> On 2022/11/10 22:13, ChenXiaoSong wrote:
>> Syzkaller reported BUG as follows:
>>
>>    BUG: sleeping function called from invalid context at
>>         include/linux/sched/mm.h:274
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0xcd/0x134
>>     __might_resched.cold+0x222/0x26b
>>     kmem_cache_alloc+0x2e7/0x3c0
>>     update_qgroup_limit_item+0xe1/0x390
>>     btrfs_qgroup_inherit+0x147b/0x1ee0
>>     create_subvol+0x4eb/0x1710
>>     btrfs_mksubvol+0xfe5/0x13f0
>>     __btrfs_ioctl_snap_create+0x2b0/0x430
>>     btrfs_ioctl_snap_create_v2+0x25a/0x520
>>     btrfs_ioctl+0x2a1c/0x5ce0
>>     __x64_sys_ioctl+0x193/0x200
>>     do_syscall_64+0x35/0x80
>>
>> Fix this by introducing __update_qgroup_limit_item() helper, allocate
>> memory outside of the spin lock.
>>
>> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> 
> Unfortunately, __update_qgroup_limit_item() can still sleep.
> 
> As it calls btrfs_search_slot(), which can lead to disk IO if the qgroup 
> tree is not cached.
> 
> 
> I believe the proper way is to either unlock the spinlock inside 
> btrfs_qgroup_inherit() (which needs extra scrutiny on the qgroup lock), 
> or delayed the limit item updates until we have unlocked the spinlock.
> 
> To me, the latter one seems more reasonable, as it's just one qgroup 
> (@dstgroup), and we're doing the same delayed work for sysfs interface 
> creation.
> 
> Thanks,
> Qu
> 
>> ---
>>   fs/btrfs/qgroup.c | 35 ++++++++++++++++++++++++++---------
>>   1 file changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 9334c3157c22..99a61cc04b68 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -768,11 +768,11 @@ static int del_qgroup_item(struct 
>> btrfs_trans_handle *trans, u64 qgroupid)
>>       return ret;
>>   }
>> -static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
>> -                    struct btrfs_qgroup *qgroup)
>> +static int __update_qgroup_limit_item(struct btrfs_trans_handle *trans,
>> +                      struct btrfs_qgroup *qgroup,
>> +                      struct btrfs_path *path) >   {
>>       struct btrfs_root *quota_root = trans->fs_info->quota_root;
>> -    struct btrfs_path *path;
>>       struct btrfs_key key;
>>       struct extent_buffer *l;
>>       struct btrfs_qgroup_limit_item *qgroup_limit;
>> @@ -783,10 +783,6 @@ static int update_qgroup_limit_item(struct 
>> btrfs_trans_handle *trans,
>>       key.type = BTRFS_QGROUP_LIMIT_KEY;
>>       key.offset = qgroup->qgroupid;
>> -    path = btrfs_alloc_path();
>> -    if (!path)
>> -        return -ENOMEM;
>> -
>>       ret = btrfs_search_slot(trans, quota_root, &key, path, 0, 1);
>>       if (ret > 0)
>>           ret = -ENOENT;
>> @@ -806,6 +802,21 @@ static int update_qgroup_limit_item(struct 
>> btrfs_trans_handle *trans,
>>       btrfs_mark_buffer_dirty(l);
>>   out:
>> +    return ret;
>> +}
>> +
>> +static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
>> +                    struct btrfs_qgroup *qgroup)
>> +{
>> +    struct btrfs_path *path;
>> +    int ret;
>> +
>> +    path = btrfs_alloc_path();
>> +    if (!path)
>> +        return -ENOMEM;
>> +
>> +    ret = __update_qgroup_limit_item(trans, qgroup, path);
>> +
>>       btrfs_free_path(path);
>>       return ret;
>>   }
>> @@ -2860,6 +2871,7 @@ int btrfs_qgroup_inherit(struct 
>> btrfs_trans_handle *trans, u64 srcid,
>>       bool need_rescan = false;
>>       u32 level_size = 0;
>>       u64 nums;
>> +    struct btrfs_path *path;
>>       /*
>>        * There are only two callers of this function.
>> @@ -2935,6 +2947,11 @@ int btrfs_qgroup_inherit(struct 
>> btrfs_trans_handle *trans, u64 srcid,
>>           ret = 0;
>>       }
>> +    path = btrfs_alloc_path();
>> +    if (!path) {
>> +        ret = -ENOMEM;
>> +        goto out;
>> +    }
>>       spin_lock(&fs_info->qgroup_lock);
>> @@ -2950,8 +2967,7 @@ int btrfs_qgroup_inherit(struct 
>> btrfs_trans_handle *trans, u64 srcid,
>>           dstgroup->max_excl = inherit->lim.max_excl;
>>           dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
>>           dstgroup->rsv_excl = inherit->lim.rsv_excl;
>> -
>> -        ret = update_qgroup_limit_item(trans, dstgroup);
>> +        ret = __update_qgroup_limit_item(trans, dstgroup, path);
>>           if (ret) {
>>               qgroup_mark_inconsistent(fs_info);
>>               btrfs_info(fs_info,
>> @@ -3053,6 +3069,7 @@ int btrfs_qgroup_inherit(struct 
>> btrfs_trans_handle *trans, u64 srcid,
>>   unlock:
>>       spin_unlock(&fs_info->qgroup_lock);
>> +    btrfs_free_path(path);
>>       if (!ret)
>>           ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
>>   out:
> 
> .
