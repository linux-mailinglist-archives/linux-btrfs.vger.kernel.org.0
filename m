Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7294C350E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiBXSw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 13:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBXSwY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 13:52:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E587C18DAA0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 10:51:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A019B210DF;
        Thu, 24 Feb 2022 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645728712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz6WreNXK0lwyBKwoVl2EvvY45CcF2UbMLNaxNz7EUo=;
        b=Jl0muDH588Hz1AuyULbCW7PGp/CmEfiyAcpNC4w6XXXMUQ3cptWye/3OJU4gF0xqoSlVYK
        G4vZMNvn3fd2ARmvU+EBaCRt0O1NCayX46PNKveAH6QRIYq08WYVHNshMyYS65OJULZW9H
        rasvjTWM1YHoPxY5SX+faFdGq9LmDGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645728712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz6WreNXK0lwyBKwoVl2EvvY45CcF2UbMLNaxNz7EUo=;
        b=XXhRBcsV4mvYQ20G+FX5kR4R6zm8VRel0ic0qtPfdpreOe7MXmRzaJOWCzzEldJNMve04/
        fZSkLotMth84ZdDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6C7E0A3B87;
        Thu, 24 Feb 2022 18:51:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 863B7DA818; Thu, 24 Feb 2022 19:48:03 +0100 (CET)
Date:   Thu, 24 Feb 2022 19:48:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [RFC PATCH] btrfs: qgroup: fix deadlock between rescan worker
 and remove qgroup
Message-ID: <20220224184803.GA12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org, shinichiro.kawasaki@wdc.com
References: <20220223095112.10880-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223095112.10880-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 23, 2022 at 09:51:13AM +0000, Sidong Yang wrote:
> The patch e804861bd4e6 by Kawasaki

Added to CC

> resolves deadlock between quota
> disable and qgroup rescan worker. but also there is a deadlock case like
> it. It's about enabling or disabling quota and creating or removing
> qgroup. It can be reproduced in simple script below.
> 
> for i in {1..100}
> do
>     btrfs quota enable /mnt &
>     btrfs qgroup create 1/0 /mnt &
>     btrfs qgroup destroy 1/0 /mnt &
>     btrfs quota disable /mnt &
> done
> 
> This script simply enables quota and creates/destroies qgroup and disables
> qgroup 100 times. Enabling quota starts rescan worker and it commits
> transaction and wait in wait_for_commit(). transaction_kthread would
> wakup for the commit and try to attach trasaction but there would be
> another current transaction. The transaction was from another command
> that destroy qgroup. but destroying qgroup could be blocked by
> qgroup_ioctl_lock which locked by the thread disabling quota.

That looks like the cause.

> An example report of the deadlock:
> 
> [  363.661448] INFO: task kworker/u16:4:295 blocked for more than 120 seconds.
> [  363.661582]       Not tainted 5.17.0-rc4+ #16
> [  363.661659] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.661744] task:kworker/u16:4   state:D stack:    0 pid:  295 ppid:     2 flags:0x00004000
> [  363.661762] Workqueue: btrfs-qgroup-rescan btrfs_work_helper [btrfs]
> [  363.661936] Call Trace:
> [  363.661949]  <TASK>
> [  363.661958]  __schedule+0x2e5/0xbb0
> [  363.662002]  ? btrfs_free_path+0x27/0x30 [btrfs]
> [  363.662094]  ? mutex_lock+0x13/0x40
> [  363.662106]  schedule+0x58/0xd0
> [  363.662116]  btrfs_commit_transaction+0x2dc/0xb40 [btrfs]
> [  363.662250]  ? wait_woken+0x60/0x60
> [  363.662271]  btrfs_qgroup_rescan_worker+0x3cb/0x600 [btrfs]
> [  363.662419]  btrfs_work_helper+0xc8/0x330 [btrfs]
> [  363.662551]  process_one_work+0x21a/0x3f0
> [  363.662588]  worker_thread+0x4a/0x3b0
> [  363.662600]  ? process_one_work+0x3f0/0x3f0
> [  363.662609]  kthread+0xfd/0x130
> [  363.662618]  ? kthread_complete_and_exit+0x20/0x20
> [  363.662628]  ret_from_fork+0x1f/0x30
> [  363.662659]  </TASK>
> [  363.662691] INFO: task btrfs-transacti:1158 blocked for more than 120 seconds.
> [  363.662765]       Not tainted 5.17.0-rc4+ #16
> [  363.662809] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.662880] task:btrfs-transacti state:D stack:    0 pid: 1158 ppid:     2 flags:0x00004000
> [  363.662889] Call Trace:
> [  363.662892]  <TASK>
> [  363.662896]  __schedule+0x2e5/0xbb0
> [  363.662906]  ? _raw_spin_lock_irqsave+0x2a/0x60
> [  363.662925]  schedule+0x58/0xd0
> [  363.662942]  wait_current_trans+0xd2/0x130 [btrfs]
> [  363.663046]  ? wait_woken+0x60/0x60
> [  363.663055]  start_transaction+0x33c/0x600 [btrfs]
> [  363.663159]  btrfs_attach_transaction+0x1d/0x20 [btrfs]
> [  363.663268]  transaction_kthread+0xb5/0x1b0 [btrfs]
> [  363.663368]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
> [  363.663465]  kthread+0xfd/0x130
> [  363.663475]  ? kthread_complete_and_exit+0x20/0x20
> [  363.663484]  ret_from_fork+0x1f/0x30
> [  363.663498]  </TASK>
> [  363.663503] INFO: task btrfs:81196 blocked for more than 120 seconds.
> [  363.663568]       Not tainted 5.17.0-rc4+ #16
> [  363.663612] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.663693] task:btrfs           state:D stack:    0 pid:81196 ppid:     1 flags:0x00000000
> [  363.663702] Call Trace:
> [  363.663705]  <TASK>
> [  363.663709]  __schedule+0x2e5/0xbb0
> [  363.663721]  schedule+0x58/0xd0
> [  363.663729]  rwsem_down_write_slowpath+0x310/0x5b0
> [  363.663748]  ? __check_object_size+0x130/0x150
> [  363.663770]  down_write+0x41/0x50
> [  363.663780]  btrfs_ioctl+0x20e6/0x2f40 [btrfs]
> [  363.663918]  ? debug_smp_processor_id+0x17/0x20
> [  363.663932]  ? fpregs_assert_state_consistent+0x23/0x50
> [  363.663963]  __x64_sys_ioctl+0x8e/0xc0
> [  363.663981]  ? __x64_sys_ioctl+0x8e/0xc0
> [  363.663990]  do_syscall_64+0x38/0xc0
> [  363.663998]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  363.664006] RIP: 0033:0x7f1082add50b
> [  363.664014] RSP: 002b:00007fffbfd1ba98 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  363.664022] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1082add50b
> [  363.664028] RDX: 00007fffbfd1bab0 RSI: 00000000c0109428 RDI: 0000000000000003
> [  363.664032] RBP: 0000000000000003 R08: 000055e4263142a0 R09: 000000000000007c
> [  363.664036] R10: 00007f1082bb1be0 R11: 0000000000000206 R12: 00007fffbfd1c723
> [  363.664040] R13: 0000000000000001 R14: 000055e42615408d R15: 00007fffbfd1bc68
> [  363.664049]  </TASK>
> [  363.664053] INFO: task btrfs:81197 blocked for more than 120 seconds.
> [  363.664117]       Not tainted 5.17.0-rc4+ #16
> [  363.664160] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.664231] task:btrfs           state:D stack:    0 pid:81197 ppid:     1 flags:0x00000000
> [  363.664239] Call Trace:
> [  363.664241]  <TASK>
> [  363.664245]  __schedule+0x2e5/0xbb0
> [  363.664257]  schedule+0x58/0xd0
> [  363.664265]  rwsem_down_write_slowpath+0x310/0x5b0
> [  363.664274]  ? __check_object_size+0x130/0x150
> [  363.664282]  down_write+0x41/0x50
> [  363.664292]  btrfs_ioctl+0x20e6/0x2f40 [btrfs]
> [  363.664430]  ? debug_smp_processor_id+0x17/0x20
> [  363.664442]  ? fpregs_assert_state_consistent+0x23/0x50
> [  363.664453]  __x64_sys_ioctl+0x8e/0xc0
> [  363.664462]  ? __x64_sys_ioctl+0x8e/0xc0
> [  363.664470]  do_syscall_64+0x38/0xc0
> [  363.664478]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  363.664484] RIP: 0033:0x7ff1752ac50b
> [  363.664489] RSP: 002b:00007ffc0cb56eb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  363.664495] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff1752ac50b
> [  363.664500] RDX: 00007ffc0cb56ed0 RSI: 00000000c0109428 RDI: 0000000000000003
> [  363.664503] RBP: 0000000000000003 R08: 000055d0dcf182a0 R09: 000000000000007c
> [  363.664507] R10: 00007ff175380be0 R11: 0000000000000206 R12: 00007ffc0cb58723
> [  363.664520] R13: 0000000000000001 R14: 000055d0db04708d R15: 00007ffc0cb57088
> [  363.664528]  </TASK>
> [  363.664532] INFO: task btrfs:81204 blocked for more than 120 seconds.
> [  363.664596]       Not tainted 5.17.0-rc4+ #16
> [  363.664639] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.664710] task:btrfs           state:D stack:    0 pid:81204 ppid:     1 flags:0x00004000
> [  363.664717] Call Trace:
> [  363.664720]  <TASK>
> [  363.664723]  __schedule+0x2e5/0xbb0
> [  363.664735]  schedule+0x58/0xd0
> [  363.664743]  schedule_timeout+0x1f3/0x290
> [  363.664754]  ? __mutex_lock.isra.0+0x8f/0x4c0
> [  363.664765]  wait_for_completion+0x8b/0xf0
> [  363.664776]  btrfs_qgroup_wait_for_completion+0x62/0x70 [btrfs]
> [  363.664995]  btrfs_quota_disable+0x51/0x320 [btrfs]
> [  363.665136]  btrfs_ioctl+0x2106/0x2f40 [btrfs]
> [  363.665385]  ? debug_smp_processor_id+0x17/0x20
> [  363.665402]  ? fpregs_assert_state_consistent+0x23/0x50
> [  363.665417]  __x64_sys_ioctl+0x8e/0xc0
> [  363.665428]  ? __x64_sys_ioctl+0x8e/0xc0
> [  363.665439]  do_syscall_64+0x38/0xc0
> [  363.665450]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  363.665459] RIP: 0033:0x7f9d7462050b
> [  363.665466] RSP: 002b:00007ffc1de68558 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  363.665475] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9d7462050b
> [  363.665480] RDX: 00007ffc1de68570 RSI: 00000000c0109428 RDI: 0000000000000003
> [  363.665486] RBP: 0000000000000003 R08: 00005629e953b2a0 R09: 000000000000007c
> [  363.665492] R10: 00007f9d746f4be0 R11: 0000000000000206 R12: 00007ffc1de69723
> [  363.665498] R13: 0000000000000001 R14: 00005629e8e5708d R15: 00007ffc1de68728
> [  363.665510]  </TASK>
> 
> To resolve this issue, The thread disabling quota should unlock
> qgroup_ioctl_lock before waiting rescan completion. This patch moves
> btrfs_qgroup_wait_for_completion() after qgroup_ioctl_lock().
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> Hi, I found some deadlock bug with testing a simple script.
> With this patch, it seems that it resolves it. but I don't know much about how
> transaction works. and I'm afraid that it has other side effects.

I had a quick look and did not see anything obvious, the qgroup waiting
is done in onther contexts without any apparent conditions or other
restrictions.

> ---
>  fs/btrfs/qgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2c0dd6b8a80c..85e5b3572dda 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1219,8 +1219,8 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>  	 * deadlock with transaction by the qgroup rescan worker.
>  	 */
>  	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> -	btrfs_qgroup_wait_for_completion(fs_info, false);
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> +	btrfs_qgroup_wait_for_completion(fs_info, false);

Yeah waiting with a mutex held can lead to problems unless the locks are
compatible in that way.
