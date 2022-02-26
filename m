Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B74C568F
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Feb 2022 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiBZPHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Feb 2022 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiBZPHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Feb 2022 10:07:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101BB1DC9BE
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Feb 2022 07:06:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so7427536pjb.3
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Feb 2022 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dc0e5zeCX2htEpTY0xv/vZ8ugLB+XqV8GJkk4kOuSLg=;
        b=WPYhBR8D4nqHjxBf50xtPdO0oNiQHNoj9s3iB2Zd4Hm06IRJQs/OsbsgFYZ8nW9Fn8
         CwZyhAUmCVp2EEsLnoo9z0zQpLvX6asH8O45rkjpeJfupGf2nmh/as8fh+v3HNrHEMm2
         0nUggLwfvRMRYAb9ush2w19AYSVAklPs2E05aR0W/ZR6ljlQ7FGf4conFLAeb+/yV1va
         FOUt7mhDJO7AgABr2JgVHgY/33QLgYvfEM0aVdSaHED8SfZJ0lNVDkmRCfBPaqpOky/I
         AI7geXrRhDegln76T1XiQrtafGoLr62v81a5MB6aX6kp9wysvdR1RGOltQ4dgZ8oupEd
         JzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dc0e5zeCX2htEpTY0xv/vZ8ugLB+XqV8GJkk4kOuSLg=;
        b=ycF1nqI9nGIBqYE7QIVq+kgqqnywPnBFJZ4MljAWuVSZVedW6b6AUJnIlznxT/tH6Z
         AOYR7AIDu9FIaPk7xmVL3v9CIT1V0oOX1khV6041/OTgsL0MmDXLl6iO4TkHPy3/c45E
         kP5RYz5nsKJLbeop7rS185iiVsiIfRa9J3jh7W7ho7Zhb447enFAafUQeuCrjky3d4a/
         JPXeMmQqxBrFsEqz5uS0cXU6ibl1wrhGfWunWCFd18CrZfiHqSzyP6uAfdsY5ZmkDVeV
         QaBcd66DsoOz5AcmG0dZZFfi2/6oBje3ymhndxPSJb6E+QhPAyLSbRDcCOy6K1stSE77
         uYhg==
X-Gm-Message-State: AOAM533CL64Q/6O3JUV635ApVwWNY2ZvZ8IqcifogWJF9bHV+UHDvZR7
        KrrocqWrXBhLXsMzUv6Zyjk=
X-Google-Smtp-Source: ABdhPJxBe3ICMGj6IO1YPuVqEtfG+ggHhHkidgN00DOpJBBbG+4rQ2qu2CYz6XvpQoF/Dn8EaMvhrg==
X-Received: by 2002:a17:90a:4b0d:b0:1bc:f9da:f334 with SMTP id g13-20020a17090a4b0d00b001bcf9daf334mr7026615pjh.75.1645888014365;
        Sat, 26 Feb 2022 07:06:54 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00088200b004ce1838b223sm7753960pfj.94.2022.02.26.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 07:06:53 -0800 (PST)
Date:   Sat, 26 Feb 2022 15:06:49 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Message-ID: <20220226150649.GB16065@realwakka>
References: <20220226102539.16585-1-realwakka@gmail.com>
 <YhohATiWw3e8hWSG@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhohATiWw3e8hWSG@debian9.Home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 26, 2022 at 12:45:53PM +0000, Filipe Manana wrote:

Hi, Filipe.
Thanks so much for review!

> On Sat, Feb 26, 2022 at 10:25:39AM +0000, Sidong Yang wrote:
> > The patch e804861bd4e6 by Kawasaki resolves deadlock between quota
> 
> The convention to refer to commits in a changelog, is like this:
> 
> ... commit e804861bd4e6 ("btrfs: fix deadlock between quota disable and qgroup rescan worker") ...

Thanks, It should be like that.
> 
> You can run the script at scripts/checkpatch.pl inside the kernel source
> directory against a patch file, it will give you warnings about things
> like these, and also for the several typos you have in the changelog.

Yeah, I should have checked with scripts/checkpatch.pl. It can make me
less mistake.
> 
> > disable and qgroup rescan worker. but also there is a deadlock case like
> > it. It's about enabling or disabling quota and creating or removing
> > qgroup. It can be reproduced in simple script below.
> > 
> > for i in {1..100}
> > do
> >     btrfs quota enable /mnt &
> >     btrfs qgroup create 1/0 /mnt &
> >     btrfs qgroup destroy 1/0 /mnt &
> >     btrfs quota disable /mnt &
> > done
> > 
> > This script simply enables quota and creates/destroies qgroup and disables
> > qgroup 100 times. Enabling quota starts rescan worker and it commits
> > transaction and wait in wait_for_commit(). transaction_kthread would
> > wakup for the commit and try to attach trasaction but there would be
> > another current transaction. The transaction was from another command
> > that destroy qgroup. but destroying qgroup could be blocked by
> > qgroup_ioctl_lock which locked by the thread disabling quota.
> 
> I can't understand this paragraph. To me it does not explain how the deadlock
> happens, why it happens and how is the qgroup_ioctl_lock mutex related to it.
> See below.
> 
> > 
> > An example report of the deadlock:
> > 
> > [  363.661448] INFO: task kworker/u16:4:295 blocked for more than 120 seconds.
> > [  363.661582]       Not tainted 5.17.0-rc4+ #16
> > [  363.661659] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  363.661744] task:kworker/u16:4   state:D stack:    0 pid:  295 ppid:     2 flags:0x00004000
> > [  363.661762] Workqueue: btrfs-qgroup-rescan btrfs_work_helper [btrfs]
> > [  363.661936] Call Trace:
> > [  363.661949]  <TASK>
> > [  363.661958]  __schedule+0x2e5/0xbb0
> > [  363.662002]  ? btrfs_free_path+0x27/0x30 [btrfs]
> > [  363.662094]  ? mutex_lock+0x13/0x40
> > [  363.662106]  schedule+0x58/0xd0
> > [  363.662116]  btrfs_commit_transaction+0x2dc/0xb40 [btrfs]
> > [  363.662250]  ? wait_woken+0x60/0x60
> > [  363.662271]  btrfs_qgroup_rescan_worker+0x3cb/0x600 [btrfs]
> > [  363.662419]  btrfs_work_helper+0xc8/0x330 [btrfs]
> > [  363.662551]  process_one_work+0x21a/0x3f0
> > [  363.662588]  worker_thread+0x4a/0x3b0
> > [  363.662600]  ? process_one_work+0x3f0/0x3f0
> > [  363.662609]  kthread+0xfd/0x130
> > [  363.662618]  ? kthread_complete_and_exit+0x20/0x20
> > [  363.662628]  ret_from_fork+0x1f/0x30
> > [  363.662659]  </TASK>
> > [  363.662691] INFO: task btrfs-transacti:1158 blocked for more than 120 seconds.
> > [  363.662765]       Not tainted 5.17.0-rc4+ #16
> > [  363.662809] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  363.662880] task:btrfs-transacti state:D stack:    0 pid: 1158 ppid:     2 flags:0x00004000
> > [  363.662889] Call Trace:
> > [  363.662892]  <TASK>
> > [  363.662896]  __schedule+0x2e5/0xbb0
> > [  363.662906]  ? _raw_spin_lock_irqsave+0x2a/0x60
> > [  363.662925]  schedule+0x58/0xd0
> > [  363.662942]  wait_current_trans+0xd2/0x130 [btrfs]
> > [  363.663046]  ? wait_woken+0x60/0x60
> > [  363.663055]  start_transaction+0x33c/0x600 [btrfs]
> > [  363.663159]  btrfs_attach_transaction+0x1d/0x20 [btrfs]
> > [  363.663268]  transaction_kthread+0xb5/0x1b0 [btrfs]
> > [  363.663368]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
> > [  363.663465]  kthread+0xfd/0x130
> > [  363.663475]  ? kthread_complete_and_exit+0x20/0x20
> > [  363.663484]  ret_from_fork+0x1f/0x30
> > [  363.663498]  </TASK>
> > [  363.663503] INFO: task btrfs:81196 blocked for more than 120 seconds.
> > [  363.663568]       Not tainted 5.17.0-rc4+ #16
> > [  363.663612] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  363.663693] task:btrfs           state:D stack:    0 pid:81196 ppid:     1 flags:0x00000000
> > [  363.663702] Call Trace:
> > [  363.663705]  <TASK>
> > [  363.663709]  __schedule+0x2e5/0xbb0
> > [  363.663721]  schedule+0x58/0xd0
> > [  363.663729]  rwsem_down_write_slowpath+0x310/0x5b0
> > [  363.663748]  ? __check_object_size+0x130/0x150
> > [  363.663770]  down_write+0x41/0x50
> > [  363.663780]  btrfs_ioctl+0x20e6/0x2f40 [btrfs]
> > [  363.663918]  ? debug_smp_processor_id+0x17/0x20
> > [  363.663932]  ? fpregs_assert_state_consistent+0x23/0x50
> > [  363.663963]  __x64_sys_ioctl+0x8e/0xc0
> > [  363.663981]  ? __x64_sys_ioctl+0x8e/0xc0
> > [  363.663990]  do_syscall_64+0x38/0xc0
> > [  363.663998]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  363.664006] RIP: 0033:0x7f1082add50b
> > [  363.664014] RSP: 002b:00007fffbfd1ba98 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> > [  363.664022] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1082add50b
> > [  363.664028] RDX: 00007fffbfd1bab0 RSI: 00000000c0109428 RDI: 0000000000000003
> > [  363.664032] RBP: 0000000000000003 R08: 000055e4263142a0 R09: 000000000000007c
> > [  363.664036] R10: 00007f1082bb1be0 R11: 0000000000000206 R12: 00007fffbfd1c723
> > [  363.664040] R13: 0000000000000001 R14: 000055e42615408d R15: 00007fffbfd1bc68
> > [  363.664049]  </TASK>
> > [  363.664053] INFO: task btrfs:81197 blocked for more than 120 seconds.
> > [  363.664117]       Not tainted 5.17.0-rc4+ #16
> > [  363.664160] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  363.664231] task:btrfs           state:D stack:    0 pid:81197 ppid:     1 flags:0x00000000
> > [  363.664239] Call Trace:
> > [  363.664241]  <TASK>
> > [  363.664245]  __schedule+0x2e5/0xbb0
> > [  363.664257]  schedule+0x58/0xd0
> > [  363.664265]  rwsem_down_write_slowpath+0x310/0x5b0
> > [  363.664274]  ? __check_object_size+0x130/0x150
> > [  363.664282]  down_write+0x41/0x50
> > [  363.664292]  btrfs_ioctl+0x20e6/0x2f40 [btrfs]
> > [  363.664430]  ? debug_smp_processor_id+0x17/0x20
> > [  363.664442]  ? fpregs_assert_state_consistent+0x23/0x50
> > [  363.664453]  __x64_sys_ioctl+0x8e/0xc0
> > [  363.664462]  ? __x64_sys_ioctl+0x8e/0xc0
> > [  363.664470]  do_syscall_64+0x38/0xc0
> > [  363.664478]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  363.664484] RIP: 0033:0x7ff1752ac50b
> > [  363.664489] RSP: 002b:00007ffc0cb56eb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> > [  363.664495] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff1752ac50b
> > [  363.664500] RDX: 00007ffc0cb56ed0 RSI: 00000000c0109428 RDI: 0000000000000003
> > [  363.664503] RBP: 0000000000000003 R08: 000055d0dcf182a0 R09: 000000000000007c
> > [  363.664507] R10: 00007ff175380be0 R11: 0000000000000206 R12: 00007ffc0cb58723
> > [  363.664520] R13: 0000000000000001 R14: 000055d0db04708d R15: 00007ffc0cb57088
> > [  363.664528]  </TASK>
> > [  363.664532] INFO: task btrfs:81204 blocked for more than 120 seconds.
> > [  363.664596]       Not tainted 5.17.0-rc4+ #16
> > [  363.664639] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  363.664710] task:btrfs           state:D stack:    0 pid:81204 ppid:     1 flags:0x00004000
> > [  363.664717] Call Trace:
> > [  363.664720]  <TASK>
> > [  363.664723]  __schedule+0x2e5/0xbb0
> > [  363.664735]  schedule+0x58/0xd0
> > [  363.664743]  schedule_timeout+0x1f3/0x290
> > [  363.664754]  ? __mutex_lock.isra.0+0x8f/0x4c0
> > [  363.664765]  wait_for_completion+0x8b/0xf0
> > [  363.664776]  btrfs_qgroup_wait_for_completion+0x62/0x70 [btrfs]
> > [  363.664995]  btrfs_quota_disable+0x51/0x320 [btrfs]
> > [  363.665136]  btrfs_ioctl+0x2106/0x2f40 [btrfs]
> > [  363.665385]  ? debug_smp_processor_id+0x17/0x20
> > [  363.665402]  ? fpregs_assert_state_consistent+0x23/0x50
> > [  363.665417]  __x64_sys_ioctl+0x8e/0xc0
> > [  363.665428]  ? __x64_sys_ioctl+0x8e/0xc0
> > [  363.665439]  do_syscall_64+0x38/0xc0
> > [  363.665450]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  363.665459] RIP: 0033:0x7f9d7462050b
> > [  363.665466] RSP: 002b:00007ffc1de68558 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> > [  363.665475] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9d7462050b
> > [  363.665480] RDX: 00007ffc1de68570 RSI: 00000000c0109428 RDI: 0000000000000003
> > [  363.665486] RBP: 0000000000000003 R08: 00005629e953b2a0 R09: 000000000000007c
> > [  363.665492] R10: 00007f9d746f4be0 R11: 0000000000000206 R12: 00007ffc1de69723
> > [  363.665498] R13: 0000000000000001 R14: 00005629e8e5708d R15: 00007ffc1de68728
> > [  363.665510]  </TASK>
> 
> So these stack traces don't show any task blocked on the qgroup_ioctl_lock mutex.
> And that makes it a stronger argument for getting an explanation on why the deadlock
> happens and why we need to wait for the rescan task without holding the mutex.
> 
> Here's why the deadlock happens:
> 
> 1) The quota rescan task is running;
> 
> 2) Task A calls btrfs_quota_disable(), locks the qgroup_ioctl_lock mutex,
>    and then calls btrfs_qgroup_wait_for_completion(), to wait for the quota
>    rescan task to complete;
> 
> 3) Task B calls btrfs_remove_qgroup() and it blocks when trying to lock
>    the qgroup_ioctl_lock mutex, because it's being held by task A. At that
>    point task B is holding a transaction handle for the current transaction;
> 
> 4) The quota rescan task calls btrfs_commit_transaction(). This results in
>    it waiting for all other tasks to release their handles on the transaction,
>    but task B is blocked on the qgroup_ioctl_lock mutex while holding a handle
>    on the transaction, and that mutex is being held by task A, which is waiting
>    for the quota rescan task to complete, resulting in a deadlock between these
>    3 tasks.
> 

I agree. This long stack trace doesn't help to understand this problem.
It proves that there is a real deadlock and I tried. I think that your
description would be better than this stack trace. It's enough to
describe what's going on.

> > 
> > To resolve this issue, The thread disabling quota should unlock
> > qgroup_ioctl_lock before waiting rescan completion. This patch moves
> > btrfs_qgroup_wait_for_completion() after qgroup_ioctl_lock().
> > 
> > Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> > qgroup rescan worker")
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2: add comments, move locking before clear_bit.
> > ---
> >  fs/btrfs/qgroup.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 2c0dd6b8a80c..ea50cfe30926 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1213,6 +1213,12 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
> >  	if (!fs_info->quota_root)
> >  		goto out;
> >  
> > +	/*
> > +	 * qgruop_ioctl_lock should be unlocked before waiting rescan completion
> 
> qgruop_ioctl_lock -> qgroup_ioctl_lock

Oops.
> 
> > +	 * for avoiding deadlock with other qgroup command like remove_qgroup.
> > +	 */
> 
> Instead of mentioning "remove_qgroup", please use "btrfs_remove_qgroup()" instead,
> it's the actual full name and the use of () makes it clear that it's a function we
> are referring to.
> 
> Perhaps something like this:
> 
> /*
>  * Unlock the qgroup_ioctl_lock mutex before waiting for the rescan worker to
>  * complete. Otherwise we can deadlock because btrfs_remove_qgroup() needs
>  * to lock that mutex while holding a transaction handle and the rescan
>  * worker needs to commit a transaction.
>  */
> 
Thanks. I understood.

> Otherwise it looks good. Great work!

Thanks so much. I think I'm too excited for this, so I forgot to make a
good patch.
> 
> With those things fixed, you can add:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Can you also turn the test script you pasted before into a test case for fstests?

Sure! It's gonna be my pleasure.

Thanks,
Sidong

> 
> Thanks.
> 
> > +	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> > +
> >  	/*
> >  	 * Request qgroup rescan worker to complete and wait for it. This wait
> >  	 * must be done before transaction start for quota disable since it may
> > @@ -1220,7 +1226,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
> >  	 */
> >  	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> >  	btrfs_qgroup_wait_for_completion(fs_info, false);
> > -	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> >  
> >  	/*
> >  	 * 1 For the root item
> > -- 
> > 2.25.1
> > 
