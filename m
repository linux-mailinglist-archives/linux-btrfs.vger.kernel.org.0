Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34E659E4F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiHWON0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbiHWONE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 10:13:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DAF264E35;
        Tue, 23 Aug 2022 04:24:29 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBmYM4bVnznThm;
        Tue, 23 Aug 2022 19:03:19 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 19:05:37 +0800
Subject: Re: [PATCH -next] btrfs: fix use-after-free in btrfs_get_global_root
To:     Filipe Manana <fdmanana@kernel.org>
References: <20220823015931.421355-1-yebin10@huawei.com>
 <20220823090657.GB3171944@falcondesktop>
CC:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <6304B481.9010505@huawei.com>
Date:   Tue, 23 Aug 2022 19:05:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220823090657.GB3171944@falcondesktop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/23 17:06, Filipe Manana wrote:
> On Tue, Aug 23, 2022 at 09:59:31AM +0800, Ye Bin wrote:
>> Syzkaller reported UAF as follows:
>> ==================================================================
>> BUG: KASAN: use-after-free in btrfs_get_global_root+0x663/0xa10
>> Read of size 4 at addr ffff88811ddbb3c0 by task kworker/u16:1/11
>>
>> CPU: 4 PID: 11 Comm: kworker/u16:1 Not tainted 6.0.0-rc1-next-20220822+ #2
>> Workqueue: btrfs-qgroup-rescan btrfs_work_helper
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x6e/0x91
>>   print_report.cold+0xb2/0x6bb
>>   kasan_report+0xa8/0x130
>>   kasan_check_range+0x13f/0x1d0
>>   btrfs_get_global_root+0x663/0xa10
>>   btrfs_get_fs_root_commit_root+0xa5/0x150
>>   find_parent_nodes+0x92f/0x2990
>>   btrfs_find_all_roots_safe+0x12d/0x220
>>   btrfs_find_all_roots+0xbb/0xd0
>>   btrfs_qgroup_rescan_worker+0x600/0xc30
>>   btrfs_work_helper+0xff/0x750
>>   process_one_work+0x52c/0x930
>>   worker_thread+0x352/0x8c0
>>   kthread+0x1b9/0x200
>>   ret_from_fork+0x22/0x30
>>   </TASK>
>>
>> Allocated by task 1895:
>>   kasan_save_stack+0x1e/0x40
>>   __kasan_kmalloc+0xa9/0xe0
>>   btrfs_alloc_root+0x40/0x820
>>   btrfs_create_tree+0xf8/0x500
>>   btrfs_quota_enable+0x30a/0x1120
>>   btrfs_ioctl+0x50a3/0x59f0
>>   __x64_sys_ioctl+0x130/0x170
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Freed by task 1895:
>>   kasan_save_stack+0x1e/0x40
>>   kasan_set_track+0x21/0x30
>>   kasan_set_free_info+0x20/0x40
>>   __kasan_slab_free+0x127/0x1c0
>>   kfree+0xa8/0x2d0
>>   btrfs_put_root+0x1ca/0x230
>>   btrfs_quota_enable+0x87c/0x1120
>>   btrfs_ioctl+0x50a3/0x59f0
>>   __x64_sys_ioctl+0x130/0x170
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> ==================================================================
>>
>> Above issue may happens as follows:
>>            p1                                  p2
>> btrfs_quota_enable
>>    spin_lock(&fs_info->qgroup_lock);
>>    fs_info->quota_root = quota_root;
>>    spin_unlock(&fs_info->qgroup_lock);
>>
>>    ret = qgroup_rescan_init -> return error
>>    if (ret)
>>      btrfs_put_root(quota_root);
>>       kfree(root);
>>
>>    if (ret) {
>>     ulist_free(fs_info->qgroup_ulist);
>>     fs_info->qgroup_ulist = NULL;
>>     btrfs_sysfs_del_qgroups(fs_info);
>>    }                                btrfs_qgroup_rescan_worker
>>                                       btrfs_find_all_roots
>> 				       btrfs_find_all_roots_safe
>> 				         find_parent_nodes
>> 					   btrfs_get_fs_root_commit_root
>> 					     btrfs_grab_root(fs_info->quota_root)
>> 	                                  -> quota_root already freed
I have described the process of the issue here. I can write it in more 
detail.
>> Syzkaller also reported another issue:
>> ==================================================================
>> BUG: KASAN: use-after-free in ulist_release+0x30/0xb3
>> Read of size 8 at addr ffff88811413d048 by task rep/2921
>>
>> CPU: 3 PID: 2921 Comm: rep Not tainted 6.0.0-rc1-next-20220822+ #3
>> rep[2921] cmdline: ./rep
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x6e/0x91
>>   print_report.cold+0xb2/0x6bb
>>   kasan_report+0xa8/0x130
>>   ulist_release+0x30/0xb3
>>   ulist_reinit+0x16/0x56
>>   btrfs_qgroup_free_refroot+0x288/0x3f0
>>   btrfs_qgroup_free_meta_all_pertrans+0xed/0x1e0
>>   commit_fs_roots+0x28c/0x430
>>   btrfs_commit_transaction+0x9a6/0x1b40
>>   btrfs_qgroup_rescan+0x7e/0x130
>>   btrfs_ioctl+0x48ed/0x59f0
>>   __x64_sys_ioctl+0x130/0x170
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>   </TASK>
>>
>> Allocated by task 2900:
>>   kasan_save_stack+0x1e/0x40
>>   __kasan_kmalloc+0xa9/0xe0
>>   ulist_alloc+0x5c/0xe0
>>   btrfs_quota_enable+0x1b2/0x1160
>>   btrfs_ioctl+0x50a3/0x59f0
>>   __x64_sys_ioctl+0x130/0x170
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Freed by task 2900:
>>   kasan_save_stack+0x1e/0x40
>>   kasan_set_track+0x21/0x30
>>   kasan_set_free_info+0x20/0x40
>>   __kasan_slab_free+0x127/0x1c0
>>   kfree+0xa8/0x2d0
>>   ulist_free.cold+0x15/0x1a
>>   btrfs_quota_enable+0x8bf/0x1160
>>   btrfs_ioctl+0x50a3/0x59f0
>>   __x64_sys_ioctl+0x130/0x170
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> ==================================================================
>>
>> To solve above issues just set 'fs_info->quota_root' after qgroup_rescan_init
>> return success.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/btrfs/qgroup.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index db723c0026bd..16f0b038295a 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -1158,18 +1158,18 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>   	if (ret)
>>   		goto out_free_path;
>>   
>> -	/*
>> -	 * Set quota enabled flag after committing the transaction, to avoid
>> -	 * deadlocks on fs_info->qgroup_ioctl_lock with concurrent snapshot
>> -	 * creation.
>> -	 */
>> -	spin_lock(&fs_info->qgroup_lock);
>> -	fs_info->quota_root = quota_root;
>> -	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
>> -	spin_unlock(&fs_info->qgroup_lock);
>> -
>>   	ret = qgroup_rescan_init(fs_info, 0, 1);
>>   	if (!ret) {
>> +		/*
>> +		 * Set quota enabled flag after committing the transaction, to
>> +		 * avoid deadlocks on fs_info->qgroup_ioctl_lock with concurrent
>> +		 * snapshot creation.
>> +		 */
>> +		spin_lock(&fs_info->qgroup_lock);
>> +		fs_info->quota_root = quota_root;
>> +		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
>> +		spin_unlock(&fs_info->qgroup_lock);
>> +
> But how can the race happen? The changelog should explain that.
>
> To me this suggests that after we set BTRFS_FS_QUOTA_ENABLED and set the
> quota root, but before we called qgroup_rescan_init() at btrfs_quota_enable(),
> some other task started the rescan worker first - I can only think of
> someone else calling the ioctl to start the rescan worker (btrfs_ioctl_quota_rescan()).
Yes,  rescan worker is triggered by ioctl(btrfs_ioctl_quota_rescan()).
> In that case we get "ret == -EINPROGRESS" at btrfs_quota_enable().
>
> So please provide a detailed explanation in the log of how the race can
> happen.
>
> This solution is also buggy. Because in case of an error, we will leave the
> quota tree created, the qgroup relation, etc. That is, we don't undo
> what btrfs_create_tree(), add_qgroup_item(), add_qgroup_rb(), etc did
> Which means a future btrfs_quota_enable() call would fail, and calling
> btrfs_quota_disable() to undo all those things will not work either,
> because fs_info->quota_root is NULL.
As 'ret' is non-zero will release resources which you mentioned.
  btrfs_quota_enable
...
  out_free_path:
          btrfs_free_path(path);
  out_free_root:
          if (ret)
                  btrfs_put_root(quota_root);
  out:
          if (ret) {
                  ulist_free(fs_info->qgroup_ulist);
                  fs_info->qgroup_ulist = NULL;
                  btrfs_sysfs_del_qgroups(fs_info);
          }
          mutex_unlock(&fs_info->qgroup_ioctl_lock);
          if (ret && trans)
                  btrfs_end_transaction(trans);
          else if (trans)
                  ret = btrfs_end_transaction(trans);
          ulist_free(ulist);
...
>
> I would suggest ignoring the error of qgroup_rescan_init() if it's
> -EINPROGRESS, and ASSERT if it's anything different from 0 or
> -EINPROGRESS. Also add a comment mentioning we can get -EINPROGRESS
> because someone may have called the qgroup rescan ioctl.
>
> Thanks.
>
>
>
>
>>   	        qgroup_rescan_zero_tracking(fs_info);
>>   		fs_info->qgroup_rescan_running = true;
>>   	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
>> -- 
>> 2.31.1
>>
> .
>

