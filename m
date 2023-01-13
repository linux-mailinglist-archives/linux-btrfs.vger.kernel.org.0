Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07F4669C96
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 16:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjAMPjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 10:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjAMPij (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 10:38:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A1C68A6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 07:30:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06EE14DCA5;
        Fri, 13 Jan 2023 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673623844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbHjsMs5rK/Mc84GiMvUS3cu/9kYFTTTtF3zB/t2LaQ=;
        b=sDy01uaSNzjEU270AOw8VN6CxI+Bqf1L07iUX15jp6c9fOM1SDekNopi2+EM3KoxRur5tz
        gWCYxlmTPEaAYPANAQYACdyiFpDlvp3NWnFgqFrw2A0P3NJWXtPlfHd8eSgTptbJGi/A90
        NTkZAr7PZ12PNAYBcSP7W07MpD4/HjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673623844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbHjsMs5rK/Mc84GiMvUS3cu/9kYFTTTtF3zB/t2LaQ=;
        b=QKmp+J1jEDQIp+rn+8T6suW+qt7FrrjoQlAdGA/6/e83BcGtQb3kwo55K4HTxO6YBtza9Z
        wk8xixIGYNhFqpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D792813913;
        Fri, 13 Jan 2023 15:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dmuSMyN5wWMsOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Jan 2023 15:30:43 +0000
Date:   Fri, 13 Jan 2023 16:25:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix race between quota rescan and disable
 leading to NULL pointer deref
Message-ID: <20230113152507.GW11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ce2f76dc44aff2e00051eaf174f3da65b896c2ef.1673540838.git.fdmanana@suse.com>
 <ca82b2fed3254259f5814e30d888cc48e453e24e.1673546940.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca82b2fed3254259f5814e30d888cc48e453e24e.1673546940.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 12, 2023 at 06:13:17PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we have one task trying to start the quota rescan worker while another
> one is trying to disable quotas, we can end up hitting a race that results
> in the quota rescan worker doing a NULL pointer dereference. The steps for
> this are the following:
> 
> 1) Quotas are enabled;
> 
> 2) Task A calls the quota rescan ioctl and enters btrfs_qgroup_rescan().
>    It calls qgroup_rescan_init() which returns 0 (success) and then joins a
>    transaction and commits it;
> 
> 3) Task B calls the quota disable ioctl and enters btrfs_quota_disable().
>    It clears the bit BTRFS_FS_QUOTA_ENABLED from fs_info->flags and calls
>    btrfs_qgroup_wait_for_completion(), which returns immediately since the
>    rescan worker is not yet running.
>    Then it starts a transaction and locks fs_info->qgroup_ioctl_lock;
> 
> 4) Task A queues the rescan worker, by calling btrfs_queue_work();
> 
> 5) The rescan worker starts, and calls rescan_should_stop() at the start
>    of its while loop, which results in 0 iterations of the loop, since
>    the flag BTRFS_FS_QUOTA_ENABLED was cleared from fs_info->flags by
>    task B at step 3);
> 
> 6) Task B sets fs_info->quota_root to NULL;
> 
> 7) The rescan worker tries to start a transaction and uses
>    fs_info->quota_root as the root argument for btrfs_start_transaction().
>    This results in a NULL pointer dereference down the call chain of
>    btrfs_start_transaction(). The stack trace is something like the one
>    reported in Link tag below:
> 
>    general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] PREEMPT SMP KASAN
>    KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
>    CPU: 1 PID: 34 Comm: kworker/u4:2 Not tainted 6.1.0-syzkaller-13872-gb6bb9676f216 #0
>    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
>    Workqueue: btrfs-qgroup-rescan btrfs_work_helper
>    RIP: 0010:start_transaction+0x48/0x10f0 fs/btrfs/transaction.c:564
>    Code: 48 89 fb 48 (...)
>    RSP: 0018:ffffc90000ab7ab0 EFLAGS: 00010206
>    RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff88801779ba80
>    RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
>    RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff52000156f5d
>    R10: fffff52000156f5d R11: 1ffff92000156f5c R12: 0000000000000000
>    R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000003
>    FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f2bea75b718 CR3: 000000001d0cc000 CR4: 00000000003506e0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     <TASK>
>     btrfs_qgroup_rescan_worker+0x3bb/0x6a0 fs/btrfs/qgroup.c:3402
>     btrfs_work_helper+0x312/0x850 fs/btrfs/async-thread.c:280
>     process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
>     worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>     kthread+0x266/0x300 kernel/kthread.c:376
>     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>     </TASK>
>    Modules linked in:
>    ---[ end trace 0000000000000000 ]---
> 
> So fix this by having the rescan worker function not attempt to start a
> transaction if it didn't do any rescan work.
> 
> Reported-by: syzbot+96977faa68092ad382c4@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000e5454b05f065a803@google.com/
> Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and qgroup rescan worker")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Add missing assignment of NULL to 'trans' in case no leaf rescans
>     were performed.

Updated in misc-next, thanks.
