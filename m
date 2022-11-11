Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5C6256EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiKKJg0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 04:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKKJgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 04:36:25 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DEC63C1;
        Fri, 11 Nov 2022 01:36:24 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7tqq2PNzz15MYX;
        Fri, 11 Nov 2022 17:36:07 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 17:36:22 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 17:36:21 +0800
Message-ID: <c7d5700d-8080-7588-8e1f-398cc2943523@huawei.com>
Date:   Fri, 11 Nov 2022 17:36:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, <clm@fb.com>,
        <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangxiaoxu5@huawei.com>
References: <20221111090212.2266807-1-chenxiaosong2@huawei.com>
 <df7ede88-86a2-1c6d-0343-c97a851b9bdf@gmx.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <df7ede88-86a2-1c6d-0343-c97a851b9bdf@gmx.com>
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

Thanks for your suggestions, I will try to send a new version patch.

在 2022/11/11 17:09, Qu Wenruo 写道:
> 
> 
> On 2022/11/11 17:02, ChenXiaoSong wrote:
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
>> Fix this by delaying the limit item updates until unlock the spin lock.
> 
> The overall idea is way better now.
> 
> But sorry that I didn't immediately find out the best solution at the 
> first glance.
> 
> In fact, your v2 path just lets me remember what is the correct way to 
> handle such situation.
> 
>>
>> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
>> ---
>>   fs/btrfs/qgroup.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 9334c3157c22..2792d63c0da4 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
> [...]
>> @@ -2985,6 +2978,7 @@ int btrfs_qgroup_inherit(struct 
>> btrfs_trans_handle *trans, u64 srcid,
>>           dstgroup->max_excl = srcgroup->max_excl;
>>           dstgroup->rsv_rfer = srcgroup->rsv_rfer;
>>           dstgroup->rsv_excl = srcgroup->rsv_excl;
>> +        update_limit = true;
>>           qgroup_dirty(fs_info, dstgroup);
>>           qgroup_dirty(fs_info, srcgroup);
> 
> You caught the "if (srcid)" branch, which also changed the 
> limit/rfer/excl numbers of the destination qgroup, but didn't call 
> update_qgroup_limit_item().
> 
> 
> But if you check the function qgroup_dirty() a little deeper, you can 
> find out that, qgroup_dirty() will move the target qgroup into 
> fs_info->dirty_qgroups list.
> 
> And later at btrfs_run_qgroups() (which is called during 
> btrfs_commit_transaction(), and also after create_pending_snapshots()), 
> we will update the quota tree to reflect the result.
> 
> So this means, all you need is just call qgroup_dirty() on @dstqgroup, 
> and call it a day.
> Everything else will be properly handled.
> 
> Sorry I didn't notice this earlier...
> 
> Thanks,
> Qu
> 
>> @@ -3053,6 +3047,12 @@ int btrfs_qgroup_inherit(struct 
>> btrfs_trans_handle *trans, u64 srcid,
>>   unlock:
>>       spin_unlock(&fs_info->qgroup_lock);
>> +    if (update_limit && update_qgroup_limit_item(trans, dstgroup)) {
>> +        qgroup_mark_inconsistent(fs_info);
>> +        btrfs_info(fs_info,
>> +               "unable to update quota limit for %llu",
>> +               dstgroup->qgroupid);
>> +    }
>>       if (!ret)
>>           ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
>>   out:
> 
> .
