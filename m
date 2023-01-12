Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE5667E6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 19:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbjALSvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 13:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjALSvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 13:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1535D84082
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 10:22:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 625EBB81FBE
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 18:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA80C433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673547756;
        bh=jmpllkYwrD+glG1bDM6IhrFpdaBC+lzXTR9eNjuMC/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ehVeWgP2GbG14CqsggBz5u8COg8ZmYolp1k+5x/2qDwUWzps/uvkKDnCiPabQLqy6
         Ji+E/OIUN9i08deYCOPdugxs65p8q+uhGSMyXkDYi2rRoCIi9r2ccRTNnnzO6VRKrd
         KFf7Lmgqec7RqygtwERGKtZbAkc7HL2XJteIPQv6jlCcpF4PAqvTmgIz6NqV5W56B0
         Xg8Z3ZGk75Y4XX1ZxjG/iak6IE1e2kWu/32dSatdVArZa5HRbh83424+QNQuuYwU+q
         DnKOegqnmRm/cz72NXNjOwv8dlPHlJpRjtFsvGbNQxasBcYwUTOVENvZo7mhy/n/jN
         TtY61Ws6yTamQ==
Received: by mail-ot1-f46.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so11030105otp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 10:22:36 -0800 (PST)
X-Gm-Message-State: AFqh2kpVnrIgIQDsTgU2pQBHTIBPBcGk4bzjMn0W7Bd7ikWOeAZqrlGb
        a3fuKHmqIa3CR63z+P//XP65cM3SB19yHqHILvk=
X-Google-Smtp-Source: AMrXdXuloHWK7hZJ5QqnRLJNS8vqCZc92VE+aXwBVOrcV9Z3JQeWrKVtsTLoVsr3iEA0aHU5c/gCHcbiXS7U0cq5YV4=
X-Received: by 2002:a05:6830:110c:b0:670:6d81:d44d with SMTP id
 w12-20020a056830110c00b006706d81d44dmr4450892otq.345.1673547755191; Thu, 12
 Jan 2023 10:22:35 -0800 (PST)
MIME-Version: 1.0
References: <ce2f76dc44aff2e00051eaf174f3da65b896c2ef.1673540838.git.fdmanana@suse.com>
 <20230112175806.GQ11562@twin.jikos.cz>
In-Reply-To: <20230112175806.GQ11562@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 12 Jan 2023 18:21:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H72MKHynZDRP5x6oFoBwzUphhdK4NktBJMO6918XY-rGw@mail.gmail.com>
Message-ID: <CAL3q7H72MKHynZDRP5x6oFoBwzUphhdK4NktBJMO6918XY-rGw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix race between quota rescan and disable leading
 to NULL pointer deref
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 12, 2023 at 6:03 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jan 12, 2023 at 04:31:08PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we have one task trying to start the quota rescan worker while another
> > one is trying to disable quotas, we can end up hitting a race that results
> > in the quota rescan worker doing a NULL pointer dereference. The steps for
> > this are the following:
> >
> > 1) Quotas are enabled;
> >
> > 2) Task A calls the quota rescan ioctl and enters btrfs_qgroup_rescan().
> >    It calls qgroup_rescan_init() which returns 0 (success) and then joins a
> >    transaction and commits it;
> >
> > 3) Task B calls the quota disable ioctl and enters btrfs_quota_disable().
> >    It clears the bit BTRFS_FS_QUOTA_ENABLED from fs_info->flags and calls
> >    btrfs_qgroup_wait_for_completion(), which returns immediately since the
> >    rescan worker is not yet running.
> >    Then it starts a transaction and locks fs_info->qgroup_ioctl_lock;
> >
> > 4) Task A queues the rescan worker, by calling btrfs_queue_work();
> >
> > 5) The rescan worker starts, and calls rescan_should_stop() at the start
> >    of its while loop, which results in 0 iterations of the loop, since
> >    the flag BTRFS_FS_QUOTA_ENABLED was cleared from fs_info->flags by
> >    task B at step 3);
> >
> > 6) Task B sets fs_info->quota_root to NULL;
> >
> > 7) The rescan worker tries to start a transaction and uses
> >    fs_info->quota_root as the root argument for btrfs_start_transaction().
> >    This results in a NULL pointer dereference down the call chain of
> >    btrfs_start_transaction(). The stack trace is something like the one
> >    reported in Link tag below:
> >
> >    general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] PREEMPT SMP KASAN
> >    KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
> >    CPU: 1 PID: 34 Comm: kworker/u4:2 Not tainted 6.1.0-syzkaller-13872-gb6bb9676f216 #0
> >    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> >    Workqueue: btrfs-qgroup-rescan btrfs_work_helper
> >    RIP: 0010:start_transaction+0x48/0x10f0 fs/btrfs/transaction.c:564
> >    Code: 48 89 fb 48 (...)
> >    RSP: 0018:ffffc90000ab7ab0 EFLAGS: 00010206
> >    RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff88801779ba80
> >    RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> >    RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff52000156f5d
> >    R10: fffff52000156f5d R11: 1ffff92000156f5c R12: 0000000000000000
> >    R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
> >    FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    CR2: 00007f2bea75b718 CR3: 000000001d0cc000 CR4: 00000000003506e0
> >    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >    Call Trace:
> >     <TASK>
> >     btrfs_qgroup_rescan_worker+0x3bb/0x6a0 fs/btrfs/qgroup.c:3402
> >     btrfs_work_helper+0x312/0x850 fs/btrfs/async-thread.c:280
> >     process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
> >     worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
> >     kthread+0x266/0x300 kernel/kthread.c:376
> >     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >     </TASK>
> >    Modules linked in:
> >    ---[ end trace 0000000000000000 ]---
> >
> > So fix this by having the rescan worker function not attempt to start a
> > transaction if it didn't do any rescan work.
> >
> > Reported-by: syzbot+96977faa68092ad382c4@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/linux-btrfs/000000000000e5454b05f065a803@google.com/
> > Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and qgroup rescan worker")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Added to misc-next, thanks.

Oh btw, I have just sent a v2 some minutes ago.
Thanks.
