Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0E742BB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 20:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjF2SGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2SGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 14:06:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B401FF9
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 11:06:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD93E1F8D5;
        Thu, 29 Jun 2023 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688062009;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnHlLM06087g7FUV8dFfVilXcIt+Zdk8ta6jQyCXZXw=;
        b=aY/DNAyYWYXa2BGa5Swl1CDxxTdJK2p6zOFkNU3utmbfqdQevArXhoBhftVgnMc0o6ZaU7
        aezlrYFC/yHPuy03eS7AaGWQ8ddGBO/eFpryhjN+VjWeHyHAIvn6KDpnVkmeWMEZNzKY3I
        Jgd3ULtZAsNKS6oabQnTRkw1iwA0uxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688062009;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnHlLM06087g7FUV8dFfVilXcIt+Zdk8ta6jQyCXZXw=;
        b=3Lwk/XSpSEZy/fWgnPVVjdm5u+YZtgUiX1Rcr/98m2yqqaV4l7kJkOXE58bj7PIwYRoHiF
        f2peqVzqolflrnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C759139FF;
        Thu, 29 Jun 2023 18:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k41vHTnInWSIAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 18:06:49 +0000
Date:   Thu, 29 Jun 2023 20:00:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix use-after-free of new block group that became
 unused
Message-ID: <20230629180021.GU16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a21dc3572d3e3655861f4076a8805cc0babb92bb.1687968622.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21dc3572d3e3655861f4076a8805cc0babb92bb.1687968622.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 05:13:37PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If a task creates a new block group and that block group becomes unused
> before we finish its creation, at btrfs_create_pending_block_groups(),
> then when btrfs_mark_bg_unused() is called against the block group, we
> assume that the block group is currently in the list of block groups to
> reclaim, and we move it out of the list of new block groups and into the
> list of unused block groups. This has two consequences:
> 
> 1) We move it out of the list of new block groups associated to the
>    current transaction. So the block group creation is not finished and
>    if we attempt to delete the bg because it's unused, we will not find
>    the block group item in the extent tree (or the new block group tree),
>    its device extent items in the device tree etc, resulting in the
>    deletion to fail due to the missing items;
> 
> 2) We don't increment the reference count on the block group when we
>    move it to the list of unused block groups, because we assumed the
>    block group was on the list of block groups to reclaim, and in that
>    case it already has the correct reference count. However the block
>    group was on the list of new block groups, in which case no extra
>    reference was taken because it's local to the current task. This
>    later results in doing an extra reference count decrement when
>    removing the block group from the unused list, eventually leading the
>    referecence count to 0.
> 
> This second case was caught when running generic/297 from fstests, which
> produced the following assertion failure and stack trace:
> 
>    [457589.559668] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4299
>    [457589.559931] ------------[ cut here ]------------
>    [457589.559932] kernel BUG at fs/btrfs/block-group.c:4299!
>    [457589.560168] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>    [457589.560381] CPU: 8 PID: 2819134 Comm: umount Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
>    [457589.560630] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>    [457589.560871] RIP: 0010:btrfs_free_block_groups+0x449/0x4a0 [btrfs]
>    [457589.561181] Code: 68 62 da c0 (...)
>    [457589.561711] RSP: 0018:ffffa55a8c3b3d98 EFLAGS: 00010246
>    [457589.561957] RAX: 0000000000000058 RBX: ffff8f030d7f2000 RCX: 0000000000000000
>    [457589.562202] RDX: 0000000000000000 RSI: ffffffff953f0878 RDI: 00000000ffffffff
>    [457589.562442] RBP: ffff8f030d7f2088 R08: 0000000000000000 R09: ffffa55a8c3b3c50
>    [457589.562680] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8f05850b4c00
>    [457589.562921] R13: ffff8f030d7f2090 R14: ffff8f05850b4cd8 R15: dead000000000100
>    [457589.563167] FS:  00007f497fd2e840(0000) GS:ffff8f09dfc00000(0000) knlGS:0000000000000000
>    [457589.563419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [457589.563673] CR2: 00007f497ff8ec10 CR3: 0000000271472006 CR4: 0000000000370ee0
>    [457589.563934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [457589.564196] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [457589.564460] Call Trace:
>    [457589.564771]  <TASK>
>    [457589.565032]  ? __die_body+0x1b/0x60
>    [457589.565290]  ? die+0x39/0x60
>    [457589.565571]  ? do_trap+0xeb/0x110
>    [457589.565818]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
>    [457589.566109]  ? do_error_trap+0x6a/0x90
>    [457589.566347]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
>    [457589.566623]  ? exc_invalid_op+0x4e/0x70
>    [457589.566854]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
>    [457589.567122]  ? asm_exc_invalid_op+0x16/0x20
>    [457589.567352]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
>    [457589.567624]  ? btrfs_free_block_groups+0x449/0x4a0 [btrfs]
>    [457589.567895]  close_ctree+0x35d/0x560 [btrfs]
>    [457589.568164]  ? fsnotify_sb_delete+0x13e/0x1d0
>    [457589.568401]  ? dispose_list+0x3a/0x50
>    [457589.568671]  ? evict_inodes+0x151/0x1a0
>    [457589.568897]  generic_shutdown_super+0x73/0x1a0
>    [457589.569128]  kill_anon_super+0x14/0x30
>    [457589.569358]  btrfs_kill_super+0x12/0x20 [btrfs]
>    [457589.569673]  deactivate_locked_super+0x2e/0x70
>    [457589.569901]  cleanup_mnt+0x104/0x160
>    [457589.570156]  task_work_run+0x56/0x90
>    [457589.570500]  exit_to_user_mode_prepare+0x160/0x170
>    [457589.570750]  syscall_exit_to_user_mode+0x22/0x50
>    [457589.570971]  ? __x64_sys_umount+0x12/0x20
>    [457589.571190]  do_syscall_64+0x48/0x90
>    [457589.571412]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [457589.571639] RIP: 0033:0x7f497ff0a567
>    [457589.571865] Code: af 98 0e (...)
>    [457589.572348] RSP: 002b:00007ffc98347358 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>    [457589.572641] RAX: 0000000000000000 RBX: 00007f49800b8264 RCX: 00007f497ff0a567
>    [457589.572883] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000557f558abfa0
>    [457589.573124] RBP: 0000557f558a6ba0 R08: 0000000000000000 R09: 00007ffc98346100
>    [457589.573359] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>    [457589.573628] R13: 0000557f558abfa0 R14: 0000557f558a6cb0 R15: 0000557f558a6dd0
>    [457589.573853]  </TASK>
>    [457589.574064] Modules linked in: dm_snapshot dm_thin_pool (...)
>    [457589.576327] ---[ end trace 0000000000000000 ]---
> 
> Fix this by adding a runtime flag to the block group to tell that the
> block group is still in the list of new block groups, and therefore it
> should not be moved to the list of unused block groups, at
> btrfs_mark_bg_unused(), until the flag is cleared, when we finish the
> creation of the block group at btrfs_create_pending_block_groups().
> 
> Fixes: a9f189716cf1 ("btrfs: move out now unused BG from the reclaim list")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
