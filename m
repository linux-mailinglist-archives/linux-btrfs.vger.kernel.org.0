Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1C52ED8B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350012AbiETNwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349998AbiETNwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 09:52:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795E5E745
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 06:52:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9563A1FAB7;
        Fri, 20 May 2022 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653054754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gpIECTSDkD/YeoKQvO9nTqh3jCcmnaZ/+4XQGLJNj0A=;
        b=salwKFe7r7vEQ2ROTXwnByvbFzBhFUD5PbzdGYE/VBt0UAm0JgzqkYpJsgJMDHazKOEl4o
        xI3sYjASeGrp3q/8Bm61oa37gBu865r4FIZqnULInnpwJlvFugu61RWgGPGvLlsPD/oqLb
        U0OHTiYbW1oYPQHAvkvGePeVzSqzuBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653054754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gpIECTSDkD/YeoKQvO9nTqh3jCcmnaZ/+4XQGLJNj0A=;
        b=FiPX9onqeMJ6E2RX+9F5uGfsgxXN5dcDh3M1b6fb7tOGNV3W2/lOog0yVvxi46J0Jnl0Z/
        pWCFdBdTTWYNAOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C55713A5F;
        Fri, 20 May 2022 13:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UvNMGSKdh2IKbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 20 May 2022 13:52:34 +0000
Date:   Fri, 20 May 2022 15:48:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix hang during unmount when block group reclaim
 task is running
Message-ID: <20220520134814.GP18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <92362f3e34e6d742d25bd878fd4868e033f21d74.1652866724.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92362f3e34e6d742d25bd878fd4868e033f21d74.1652866724.git.fdmanana@suse.com>
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

On Wed, May 18, 2022 at 10:41:48AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we start an unmount, at close_ctree(), if we have the reclaim task
> running and in the middle of a data block group relocation, we can trigger
> a deadlock when stopping an async reclaim task, producing a trace like the
> following:
> 
> [629724.498185] task:kworker/u16:7   state:D stack:    0 pid:681170 ppid:     2 flags:0x00004000
> [629724.499760] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
> [629724.501267] Call Trace:
> [629724.501759]  <TASK>
> [629724.502174]  __schedule+0x3cb/0xed0
> [629724.502842]  schedule+0x4e/0xb0
> [629724.503447]  btrfs_wait_on_delayed_iputs+0x7c/0xc0 [btrfs]
> [629724.504534]  ? prepare_to_wait_exclusive+0xc0/0xc0
> [629724.505442]  flush_space+0x423/0x630 [btrfs]
> [629724.506296]  ? rcu_read_unlock_trace_special+0x20/0x50
> [629724.507259]  ? lock_release+0x220/0x4a0
> [629724.507932]  ? btrfs_get_alloc_profile+0xb3/0x290 [btrfs]
> [629724.508940]  ? do_raw_spin_unlock+0x4b/0xa0
> [629724.509688]  btrfs_async_reclaim_metadata_space+0x139/0x320 [btrfs]
> [629724.510922]  process_one_work+0x252/0x5a0
> [629724.511694]  ? process_one_work+0x5a0/0x5a0
> [629724.512508]  worker_thread+0x52/0x3b0
> [629724.513220]  ? process_one_work+0x5a0/0x5a0
> [629724.514021]  kthread+0xf2/0x120
> [629724.514627]  ? kthread_complete_and_exit+0x20/0x20
> [629724.515526]  ret_from_fork+0x22/0x30
> [629724.516236]  </TASK>
> [629724.516694] task:umount          state:D stack:    0 pid:719055 ppid:695412 flags:0x00004000
> [629724.518269] Call Trace:
> [629724.518746]  <TASK>
> [629724.519160]  __schedule+0x3cb/0xed0
> [629724.519835]  schedule+0x4e/0xb0
> [629724.520467]  schedule_timeout+0xed/0x130
> [629724.521221]  ? lock_release+0x220/0x4a0
> [629724.521946]  ? lock_acquired+0x19c/0x420
> [629724.522662]  ? trace_hardirqs_on+0x1b/0xe0
> [629724.523411]  __wait_for_common+0xaf/0x1f0
> [629724.524189]  ? usleep_range_state+0xb0/0xb0
> [629724.524997]  __flush_work+0x26d/0x530
> [629724.525698]  ? flush_workqueue_prep_pwqs+0x140/0x140
> [629724.526580]  ? lock_acquire+0x1a0/0x310
> [629724.527324]  __cancel_work_timer+0x137/0x1c0
> [629724.528190]  close_ctree+0xfd/0x531 [btrfs]
> [629724.529000]  ? evict_inodes+0x166/0x1c0
> [629724.529510]  generic_shutdown_super+0x74/0x120
> [629724.530103]  kill_anon_super+0x14/0x30
> [629724.530611]  btrfs_kill_super+0x12/0x20 [btrfs]
> [629724.531246]  deactivate_locked_super+0x31/0xa0
> [629724.531817]  cleanup_mnt+0x147/0x1c0
> [629724.532319]  task_work_run+0x5c/0xa0
> [629724.532984]  exit_to_user_mode_prepare+0x1a6/0x1b0
> [629724.533598]  syscall_exit_to_user_mode+0x16/0x40
> [629724.534200]  do_syscall_64+0x48/0x90
> [629724.534667]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [629724.535318] RIP: 0033:0x7fa2b90437a7
> [629724.535804] RSP: 002b:00007ffe0b7e4458 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [629724.536912] RAX: 0000000000000000 RBX: 00007fa2b9182264 RCX: 00007fa2b90437a7
> [629724.538156] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000555d6cf20dd0
> [629724.539053] RBP: 0000555d6cf20ba0 R08: 0000000000000000 R09: 00007ffe0b7e3200
> [629724.539956] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [629724.540883] R13: 0000555d6cf20dd0 R14: 0000555d6cf20cb0 R15: 0000000000000000
> [629724.541796]  </TASK>
> 
> This happens because:
> 
> 1) Before entering close_ctree() we have the async block group reclaim
>    task running and relocating a data block group;
> 
> 2) There's an async metadata (or data) space reclaim task running;
> 
> 3) We enter close_ctree() and park the cleaner kthread;
> 
> 4) The async space reclaim task is at flush_space() and runs all the
>    existing delayed iputs;
> 
> 5) Before the async space reclaim task calls
>    btrfs_wait_on_delayed_iputs(), the block group reclaim task which is
>    doing the data block group relocation, creates a delayed iput at
>    replace_file_extents() (called when COWing leaves that have file extent
>    items pointing to relocated data extents, during the merging phase
>    of relocation roots);
> 
> 6) The async reclaim space reclaim task blocks at
>    btrfs_wait_on_delayed_iputs(), since we have a new delayed iput;
> 
> 7) The task at close_ctree() then calls cancel_work_sync() to stop the
>    async space reclaim task, but it blocks since that task is waiting for
>    the delayed iput to be run;
> 
> 8) The delayed iput is never run because the cleaner kthread is parked,
>    and no one else runs delayed iputs, resulting in a hang.
> 
> So fix this by stopping the async block group reclaim task before we
> park the cleaner kthread.
> 
> Fixes: 18bb8bbf13c183 ("btrfs: zoned: automatically reclaim zones")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
