Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2347B0707
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjI0OgG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjI0OgG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 10:36:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B33F4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 07:36:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D37531F385;
        Wed, 27 Sep 2023 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695825361;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AztZJLJ5IgM54wRsjcNXflepRwkjxISpkgy2H02d7CU=;
        b=PKfJ6s+TY7Ehw7lG1haQoVnjOOxuEGsKpWa9og440hL2HhNj/1GhAqVyFcveNYihTqzkJS
        QHNC4+6d0ZoiJYYD82KR2LzVWIsDMLZUPLMmF6biKvTt9UTECATkv4MfUV4jUBUwiELl/L
        IOlMGF0v0nCHnn/bYzfa34lYXQSdYTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695825361;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AztZJLJ5IgM54wRsjcNXflepRwkjxISpkgy2H02d7CU=;
        b=4hcYbRAqyHUiV9krxoWdckst1tSCfeKsBWuTKmi1cxRz3VlxTlXQWm18gtpiqNt+hiVrbQ
        32pywC51O6fWLhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9745A1338F;
        Wed, 27 Sep 2023 14:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RBbkI9E9FGU7SQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Sep 2023 14:36:01 +0000
Date:   Wed, 27 Sep 2023 16:29:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Siwtch to on-stack variables for block reserves
Message-ID: <20230927142923.GX13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695408280.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695408280.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 09:10:22PM +0200, David Sterba wrote:
> The block reserve structure is small enough to fit on stack so do that
> in a few functions and avoid allocation. This in turn allows to remove
> the alloc/free wrappers.
> 
> David Sterba (5):
>   btrfs: use on-stack variable for block reserve in btrfs_evict_inode
>   btrfs: use on-stack variable for block reserve in btrfs_truncate
>   btrfs: use on-stack variable for block reserve in btrfs_replace_file_extents
>   btrfs: relocation: embed block reserve to struct reloc_control
>   btrfs: remove unused alloc and free helpers for block group reserves

There's a reproducible crash in btrfs/190,

[ 7055.938851] BTRFS: device fsid 9673d357-6c33-44dd-ad15-97e5d65db453 devid 1 transid 12 /dev/vdb scanned by mount (19369)
[ 7055.941209] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum algorithm
[ 7055.941998] BTRFS info (device vdb): using free space tree
[ 7055.951786] BTRFS info (device vdb): auto enabling async discard
[ 7055.977444] INFO: trying to register non-static key.
[ 7055.978023] The code is fine but needs lockdep annotation, or maybe
[ 7055.978621] you didn't initialize this object before use?
[ 7055.979150] turning off the locking correctness validator.
[ 7055.979696] CPU: 5 PID: 19369 Comm: mount Not tainted 6.6.0-rc3-default+ #194
[ 7055.980384] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 7055.981435] Call Trace:
[ 7055.981748]  <TASK>
[ 7055.982026]  dump_stack_lvl+0x46/0x70
[ 7055.982483]  register_lock_class+0xaa3/0xb70
[ 7055.983015]  ? kasan_save_stack+0x3f/0x50
[ 7055.983533]  ? kasan_save_stack+0x2f/0x50
[ 7055.984048]  ? is_dynamic_key+0x1a0/0x1a0
[ 7055.984565]  ? merge_reloc_root+0x125/0xd80 [btrfs]
[ 7055.985227]  ? merge_reloc_roots+0x183/0x480 [btrfs]
[ 7055.985902]  ? btrfs_recover_relocation+0x909/0xa40 [btrfs]
[ 7055.986628]  ? btrfs_start_pre_rw_mount+0x56c/0x810 [btrfs]
[ 7055.987363]  ? open_ctree+0xda6/0x14d0 [btrfs]
[ 7055.987998]  ? legacy_get_tree+0x7b/0xc0
[ 7055.992021]  ? vfs_get_tree+0x3e/0x130
[ 7055.992515]  ? vfs_kern_mount.part.0+0x6e/0xc0
[ 7055.993000]  ? btrfs_mount+0x1b4/0x340 [btrfs]
[ 7055.993616]  ? legacy_get_tree+0x7b/0xc0
[ 7055.994107]  ? vfs_get_tree+0x3e/0x130
[ 7055.994574]  __lock_acquire+0x70/0xfd0
[ 7055.995055]  lock_acquire+0x146/0x3a0
[ 7055.995516]  ? btrfs_block_rsv_refill+0x2f/0xb0 [btrfs]
[ 7055.996231]  ? lock_sync+0xd0/0xd0
[ 7055.996673]  _raw_spin_lock+0x2b/0x70
[ 7055.997150]  ? btrfs_block_rsv_refill+0x2f/0xb0 [btrfs]
[ 7055.997841]  btrfs_block_rsv_refill+0x2f/0xb0 [btrfs]
[ 7055.998510]  merge_reloc_root+0x315/0xd80 [btrfs]
[ 7055.999154]  ? prepare_to_merge+0x970/0x970 [btrfs]
[ 7055.999811]  ? _raw_spin_unlock+0x1a/0x30
[ 7056.000302]  ? btrfs_get_root_ref+0x1e9/0x5a0 [btrfs]
[ 7056.000977]  ? btrfs_init_root_free_objectid+0x160/0x1e0 [btrfs]
[ 7056.001745]  merge_reloc_roots+0x183/0x480 [btrfs]
[ 7056.002305]  ? merge_reloc_root+0xd80/0xd80 [btrfs]
[ 7056.002902]  ? __add_reloc_root+0x1e6/0x250 [btrfs]
[ 7056.003547]  btrfs_recover_relocation+0x909/0xa40 [btrfs]
[ 7056.004269]  ? btrfs_relocate_block_group+0x600/0x600 [btrfs]
[ 7056.005016]  ? __up_write+0x2c0/0x2f0
[ 7056.005486]  ? btrfs_start_pre_rw_mount+0x55a/0x810 [btrfs]
[ 7056.006209]  btrfs_start_pre_rw_mount+0x56c/0x810 [btrfs]
[ 7056.006952]  ? btrfs_clear_oneshot_options+0x20/0x20 [btrfs]
[ 7056.007652]  ? open_ctree+0xcdf/0x14d0 [btrfs]
[ 7056.008186]  open_ctree+0xda6/0x14d0 [btrfs]
[ 7056.008778]  ? init_tree_roots+0x520/0x520 [btrfs]
[ 7056.009423]  btrfs_mount_root+0x571/0x680 [btrfs]
[ 7056.010075]  ? perf_trace_btrfs_sleep_tree_lock+0x4a0/0x4a0 [btrfs]
[ 7056.010854]  ? legacy_parse_param+0x43/0x3b0
[ 7056.011298]  ? strcmp+0x2e/0x50
[ 7056.011668]  ? kfree+0x117/0x150
[ 7056.012050]  ? vfs_parse_fs_string+0xcf/0x120
[ 7056.012506]  ? vfs_parse_fs_param+0x180/0x180
[ 7056.012959]  ? kasan_set_track+0x21/0x30
[ 7056.013375]  ? __kasan_kmalloc+0x83/0x90
[ 7056.013792]  ? perf_trace_btrfs_sleep_tree_lock+0x4a0/0x4a0 [btrfs]
[ 7056.014469]  legacy_get_tree+0x7b/0xc0
[ 7056.014883]  vfs_get_tree+0x3e/0x130
[ 7056.015273]  vfs_kern_mount.part.0+0x6e/0xc0
[ 7056.015723]  btrfs_mount+0x1b4/0x340 [btrfs]
[ 7056.016248]  ? mount_subvol+0x350/0x350 [btrfs]
[ 7056.016908]  ? strcmp+0x2e/0x50
[ 7056.017401]  ? vfs_parse_fs_string+0xcf/0x120
[ 7056.018068]  ? vfs_parse_fs_param+0x180/0x180
[ 7056.018740]  ? kasan_set_track+0x21/0x30
[ 7056.019362]  ? mount_subvol+0x350/0x350 [btrfs]
[ 7056.020188]  legacy_get_tree+0x7b/0xc0
[ 7056.020758]  vfs_get_tree+0x3e/0x130
[ 7056.021295]  do_new_mount+0x1ee/0x3d0
[ 7056.021830]  ? do_add_mount+0x140/0x140
[ 7056.022391]  ? cap_capable+0x9f/0xe0
[ 7056.022937]  path_mount+0x21e/0xc30
[ 7056.023457]  ? kasan_quarantine_put+0xad/0x1b0
[ 7056.024091]  ? finish_automount+0x4d0/0x4d0
[ 7056.024690]  ? user_path_at_empty+0x3b/0x50
[ 7056.025288]  ? kmem_cache_free+0xfc/0x3c0
[ 7056.025869]  __x64_sys_mount+0x25c/0x2d0
[ 7056.026440]  ? copy_mnt_ns+0x5d0/0x5d0
[ 7056.026993]  ? mark_held_locks+0x1a/0x80
[ 7056.027557]  ? lockdep_hardirqs_on_prepare.part.0+0xf1/0x1c0
[ 7056.028323]  do_syscall_64+0x2c/0x50
[ 7056.028863]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 7056.029564] RIP: 0033:0x7f2e5b00db5e
[ 7056.032306] RSP: 002b:00007ffff9f8a9c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 7056.033291] RAX: ffffffffffffffda RBX: 0000565018c489f0 RCX: 00007f2e5b00db5e
[ 7056.034226] RDX: 0000565018c48c20 RSI: 0000565018c48c60 RDI: 0000565018c48c40
[ 7056.035134] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[ 7056.036053] R10: 0000000000000000 R11: 0000000000000246 R12: 0000565018c48c40
[ 7056.036967] R13: 0000565018c48c20 R14: 00000000ffffffff R15: 00007f2e5b156076
[ 7056.037878]  </TASK>
[ 7056.038274] ==================================================================
[ 7056.039222] BUG: KASAN: null-ptr-deref in do_raw_spin_trylock+0x60/0x110
[ 7056.040111] Read of size 4 at addr 0000000000000000 by task mount/19369
[ 7056.041000] 
[ 7056.041283] CPU: 5 PID: 19369 Comm: mount Not tainted 6.6.0-rc3-default+ #194
[ 7056.042219] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 7056.043633] Call Trace:
[ 7056.044035]  <TASK>
[ 7056.044394]  dump_stack_lvl+0x46/0x70
[ 7056.044946]  kasan_report+0xd4/0x110
[ 7056.045492]  ? do_raw_spin_trylock+0x60/0x110
[ 7056.046115]  ? do_raw_spin_trylock+0x60/0x110
[ 7056.046738]  kasan_check_range+0xec/0x190
[ 7056.047326]  do_raw_spin_trylock+0x60/0x110
[ 7056.047942]  ? do_raw_spin_lock+0x1a0/0x1a0
[ 7056.048562]  ? legacy_get_tree+0x7b/0xc0
[ 7056.049134]  ? vfs_get_tree+0x3e/0x130
[ 7056.049694]  ? vfs_kern_mount.part.0+0x6e/0xc0
[ 7056.050331]  _raw_spin_lock+0x33/0x70
[ 7056.050857]  ? __reserve_bytes+0xef/0x8c0 [btrfs]
[ 7056.051643]  __reserve_bytes+0xef/0x8c0 [btrfs]
[ 7056.052488]  ? handle_reserve_ticket+0x430/0x430 [btrfs]
[ 7056.053419]  ? do_raw_spin_trylock+0xc8/0x110
[ 7056.054061]  ? do_raw_spin_lock+0x1a0/0x1a0
[ 7056.054698]  btrfs_reserve_metadata_bytes+0x36/0x1a0 [btrfs]
[ 7056.055644]  btrfs_block_rsv_refill+0x71/0xb0 [btrfs]
[ 7056.056474]  merge_reloc_root+0x315/0xd80 [btrfs]
[ 7056.057328]  ? prepare_to_merge+0x970/0x970 [btrfs]
[ 7056.058154]  ? _raw_spin_unlock+0x1a/0x30
[ 7056.058778]  ? btrfs_get_root_ref+0x1e9/0x5a0 [btrfs]
[ 7056.059640]  ? btrfs_init_root_free_objectid+0x160/0x1e0 [btrfs]
[ 7056.060575]  merge_reloc_roots+0x183/0x480 [btrfs]
[ 7056.061440]  ? merge_reloc_root+0xd80/0xd80 [btrfs]
[ 7056.062305]  ? __add_reloc_root+0x1e6/0x250 [btrfs]
[ 7056.063149]  btrfs_recover_relocation+0x909/0xa40 [btrfs]
[ 7056.064080]  ? btrfs_relocate_block_group+0x600/0x600 [btrfs]
[ 7056.065046]  ? __up_write+0x2c0/0x2f0
[ 7056.065625]  ? btrfs_start_pre_rw_mount+0x55a/0x810 [btrfs]
[ 7056.066636]  btrfs_start_pre_rw_mount+0x56c/0x810 [btrfs]
[ 7056.067453]  ? btrfs_clear_oneshot_options+0x20/0x20 [btrfs]
[ 7056.068341]  ? open_ctree+0xcdf/0x14d0 [btrfs]
[ 7056.069130]  open_ctree+0xda6/0x14d0 [btrfs]
[ 7056.069855]  ? init_tree_roots+0x520/0x520 [btrfs]
[ 7056.070711]  btrfs_mount_root+0x571/0x680 [btrfs]
[ 7056.071560]  ? perf_trace_btrfs_sleep_tree_lock+0x4a0/0x4a0 [btrfs]
[ 7056.072539]  ? legacy_parse_param+0x43/0x3b0
[ 7056.073190]  ? strcmp+0x2e/0x50
[ 7056.073716]  ? kfree+0x117/0x150
[ 7056.074246]  ? vfs_parse_fs_string+0xcf/0x120
[ 7056.074913]  ? vfs_parse_fs_param+0x180/0x180
[ 7056.075575]  ? kasan_set_track+0x21/0x30
[ 7056.076187]  ? __kasan_kmalloc+0x83/0x90
[ 7056.076790]  ? perf_trace_btrfs_sleep_tree_lock+0x4a0/0x4a0 [btrfs]
[ 7056.077759]  legacy_get_tree+0x7b/0xc0
[ 7056.078327]  vfs_get_tree+0x3e/0x130
[ 7056.078884]  vfs_kern_mount.part.0+0x6e/0xc0
[ 7056.079512]  btrfs_mount+0x1b4/0x340 [btrfs]
[ 7056.080220]  ? mount_subvol+0x350/0x350 [btrfs]
[ 7056.080977]  ? strcmp+0x2e/0x50
[ 7056.081496]  ? vfs_parse_fs_string+0xcf/0x120
[ 7056.082160]  ? vfs_parse_fs_param+0x180/0x180
[ 7056.082830]  ? kasan_set_track+0x21/0x30
[ 7056.083448]  ? mount_subvol+0x350/0x350 [btrfs]
[ 7056.084283]  legacy_get_tree+0x7b/0xc0
[ 7056.084850]  vfs_get_tree+0x3e/0x130
[ 7056.085393]  do_new_mount+0x1ee/0x3d0
[ 7056.085948]  ? do_add_mount+0x140/0x140
[ 7056.086527]  ? cap_capable+0x9f/0xe0
[ 7056.087072]  path_mount+0x21e/0xc30
[ 7056.087619]  ? kasan_quarantine_put+0xad/0x1b0
[ 7056.088256]  ? finish_automount+0x4d0/0x4d0
[ 7056.088864]  ? user_path_at_empty+0x3b/0x50
[ 7056.089507]  ? kmem_cache_free+0xfc/0x3c0
[ 7056.090127]  __x64_sys_mount+0x25c/0x2d0
[ 7056.090735]  ? copy_mnt_ns+0x5d0/0x5d0
[ 7056.091331]  ? mark_held_locks+0x1a/0x80
[ 7056.091960]  ? lockdep_hardirqs_on_prepare.part.0+0xf1/0x1c0
[ 7056.092751]  do_syscall_64+0x2c/0x50
[ 7056.093313]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 7056.094059] RIP: 0033:0x7f2e5b00db5e
[ 7056.097060] RSP: 002b:00007ffff9f8a9c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 7056.098143] RAX: ffffffffffffffda RBX: 0000565018c489f0 RCX: 00007f2e5b00db5e
[ 7056.099132] RDX: 0000565018c48c20 RSI: 0000565018c48c60 RDI: 0000565018c48c40
[ 7056.100129] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[ 7056.101118] R10: 0000000000000000 R11: 0000000000000246 R12: 0000565018c48c40
[ 7056.102079] R13: 0000565018c48c20 R14: 00000000ffffffff R15: 00007f2e5b156076
[ 7056.103037]  </TASK>
[ 7056.103421] ==================================================================
[ 7056.104423] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 7056.105426] #PF: supervisor read access in kernel mode
[ 7056.106196] #PF: error_code(0x0000) - not-present page
[ 7056.106958] PGD 0 P4D 0 
[ 7056.107416] Oops: 0000 [#1] PREEMPT SMP KASAN
[ 7056.108093] CPU: 5 PID: 19369 Comm: mount Tainted: G    B              6.6.0-rc3-default+ #194
[ 7056.109314] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 7056.114226] RIP: 0010:do_raw_spin_trylock+0x68/0x110
[ 7056.117457] RSP: 0018:ffff88810f947178 EFLAGS: 00010292
[ 7056.118184] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 7056.119168] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88810f947140
[ 7056.120172] RBP: 1ffff11021f28e2f R08: 0000000000000001 R09: fffffbfff58a50b0
[ 7056.121176] R10: ffffffffac528587 R11: 3d3d3d3d3d3d3d3d R12: ffff888110310040
[ 7056.122170] R13: 0000000000008000 R14: ffff88810ce10000 R15: 0000000000008000
[ 7056.123135] FS:  00007f2e5ae14800(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
[ 7056.124285] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7056.125087] CR2: 0000000000000000 CR3: 000000010b270005 CR4: 00000000003706a0
[ 7056.126076] Call Trace:
[ 7056.126498]  <TASK>
[ 7056.126876]  ? __die+0x1a/0x60
[ 7056.127356]  ? page_fault_oops+0x6c/0xa0
[ 7056.127942]  ? exc_page_fault+0x54/0xa0
[ 7056.128544]  ? asm_exc_page_fault+0x22/0x30
[ 7056.129189]  ? do_raw_spin_trylock+0x68/0x110
[ 7056.129841]  ? do_raw_spin_trylock+0x68/0x110
[ 7056.130502]  ? do_raw_spin_lock+0x1a0/0x1a0
[ 7056.131153]  ? legacy_get_tree+0x7b/0xc0
[ 7056.131777]  ? vfs_get_tree+0x3e/0x130
[ 7056.132375]  ? vfs_kern_mount.part.0+0x6e/0xc0
[ 7056.133057]  _raw_spin_lock+0x33/0x70
[ 7056.133648]  ? __reserve_bytes+0xef/0x8c0 [btrfs]
[ 7056.134510]  __reserve_bytes+0xef/0x8c0 [btrfs]
[ 7056.135278]  ? handle_reserve_ticket+0x430/0x430 [btrfs]
[ 7056.136142]  ? do_raw_spin_trylock+0xc8/0x110
[ 7056.136806]  ? do_raw_spin_lock+0x1a0/0x1a0
[ 7056.137427]  btrfs_reserve_metadata_bytes+0x36/0x1a0 [btrfs]
[ 7056.138314]  btrfs_block_rsv_refill+0x71/0xb0 [btrfs]
[ 7056.139215]  merge_reloc_root+0x315/0xd80 [btrfs]
[ 7056.140017]  ? prepare_to_merge+0x970/0x970 [btrfs]
[ 7056.140811]  ? _raw_spin_unlock+0x1a/0x30
[ 7056.141444]  ? btrfs_get_root_ref+0x1e9/0x5a0 [btrfs]
[ 7056.142304]  ? btrfs_init_root_free_objectid+0x160/0x1e0 [btrfs]
[ 7056.143226]  merge_reloc_roots+0x183/0x480 [btrfs]
[ 7056.144095]  ? merge_reloc_root+0xd80/0xd80 [btrfs]
[ 7056.144914]  ? __add_reloc_root+0x1e6/0x250 [btrfs]
[ 7056.145710]  btrfs_recover_relocation+0x909/0xa40 [btrfs]
[ 7056.146633]  ? btrfs_relocate_block_group+0x600/0x600 [btrfs]
[ 7056.147602]  ? __up_write+0x2c0/0x2f0
[ 7056.148188]  ? btrfs_start_pre_rw_mount+0x55a/0x810 [btrfs]
[ 7056.149106]  btrfs_start_pre_rw_mount+0x56c/0x810 [btrfs]
[ 7056.149959]  ? btrfs_clear_oneshot_options+0x20/0x20 [btrfs]
[ 7056.150885]  ? open_ctree+0xcdf/0x14d0 [btrfs]
[ 7056.151616]  open_ctree+0xda6/0x14d0 [btrfs]
[ 7056.152333]  ? init_tree_roots+0x520/0x520 [btrfs]
[ 7056.153122]  btrfs_mount_root+0x571/0x680 [btrfs]
[ 7056.153950]  ? perf_trace_btrfs_sleep_tree_lock+0x4a0/0x4a0 [btrfs]
[ 7056.154905]  ? legacy_parse_param+0x43/0x3b0
[ 7056.155538]  ? strcmp+0x2e/0x50
[ 7056.156062]  ? kfree+0x117/0x150
[ 7056.156596]  ? vfs_parse_fs_string+0xcf/0x120
[ 7056.157272]  ? vfs_parse_fs_param+0x180/0x180
[ 7056.157944]  ? kasan_set_track+0x21/0x30
[ 7056.158560]  ? __kasan_kmalloc+0x83/0x90
[ 7056.159175]  ? perf_trace_btrfs_sleep_tree_lock+0x4a0/0x4a0 [btrfs]
[ 7056.160186]  legacy_get_tree+0x7b/0xc0
[ 7056.160752]  vfs_get_tree+0x3e/0x130
[ 7056.161315]  vfs_kern_mount.part.0+0x6e/0xc0
[ 7056.161965]  btrfs_mount+0x1b4/0x340 [btrfs]
[ 7056.162756]  ? mount_subvol+0x350/0x350 [btrfs]
[ 7056.163558]  ? strcmp+0x2e/0x50
[ 7056.164060]  ? vfs_parse_fs_string+0xcf/0x120
[ 7056.164724]  ? vfs_parse_fs_param+0x180/0x180
[ 7056.165396]  ? kasan_set_track+0x21/0x30
[ 7056.166009]  ? mount_subvol+0x350/0x350 [btrfs]
[ 7056.166806]  legacy_get_tree+0x7b/0xc0
[ 7056.167366]  vfs_get_tree+0x3e/0x130
[ 7056.167937]  do_new_mount+0x1ee/0x3d0
[ 7056.168523]  ? do_add_mount+0x140/0x140
[ 7056.169129]  ? cap_capable+0x9f/0xe0
[ 7056.169669]  path_mount+0x21e/0xc30
[ 7056.170205]  ? kasan_quarantine_put+0xad/0x1b0
[ 7056.170870]  ? finish_automount+0x4d0/0x4d0
[ 7056.171510]  ? user_path_at_empty+0x3b/0x50
[ 7056.172161]  ? kmem_cache_free+0xfc/0x3c0
[ 7056.172784]  __x64_sys_mount+0x25c/0x2d0
[ 7056.173397]  ? copy_mnt_ns+0x5d0/0x5d0
[ 7056.173970]  ? mark_held_locks+0x1a/0x80
[ 7056.174579]  ? lockdep_hardirqs_on_prepare.part.0+0xf1/0x1c0
[ 7056.175398]  do_syscall_64+0x2c/0x50
[ 7056.175960]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 7056.176702] RIP: 0033:0x7f2e5b00db5e
[ 7056.179769] RSP: 002b:00007ffff9f8a9c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 7056.180797] RAX: ffffffffffffffda RBX: 0000565018c489f0 RCX: 00007f2e5b00db5e
[ 7056.181789] RDX: 0000565018c48c20 RSI: 0000565018c48c60 RDI: 0000565018c48c40
[ 7056.182778] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[ 7056.183775] R10: 0000000000000000 R11: 0000000000000246 R12: 0000565018c48c40
[ 7056.184766] R13: 0000565018c48c20 R14: 00000000ffffffff R15: 00007f2e5b156076
[ 7056.185752]  </TASK>
[ 7056.188538] CR2: 0000000000000000
[ 7056.189081] ---[ end trace 0000000000000000 ]---
[ 7056.189777] RIP: 0010:do_raw_spin_trylock+0x68/0x110
[ 7056.192980] RSP: 0018:ffff88810f947178 EFLAGS: 00010292
[ 7056.193743] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 7056.194737] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88810f947140
[ 7056.195730] RBP: 1ffff11021f28e2f R08: 0000000000000001 R09: fffffbfff58a50b0
[ 7056.196722] R10: ffffffffac528587 R11: 3d3d3d3d3d3d3d3d R12: ffff888110310040
[ 7056.197717] R13: 0000000000008000 R14: ffff88810ce10000 R15: 0000000000008000
[ 7056.198712] FS:  00007f2e5ae14800(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
[ 7056.199866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7056.200701] CR2: 0000000000000000 CR3: 000000010b270005 CR4: 00000000003706a0
[ 7056.201722] note: mount[19369] exited with irqs disabled
[ 7056.202529] note: mount[19369] exited with preempt_count 1
[failed, exit status 1]_check_dmesg: something found in dmesg (see /tmp/fstests/results//btrfs/190.dmesg)
 [14:21:44]10s - output mismatch (see /tmp/fstests/results//btrfs/190.out.bad)
    --- tests/btrfs/190.out	2020-01-14 21:19:45.483403633 +0000
    +++ /tmp/fstests/results//btrfs/190.out.bad	2023-09-27 14:21:44.439960880 +0000
    @@ -1,2 +1,4 @@
     QA output created by 190
    -Silence is golden
    +./common/rc: line 130: 19369 Killed                  $MOUNT_PROG $*
    +mount /dev/vdb /tmp/scratch failed
    +(see /tmp/fstests/results//btrfs/190.full for details)
    ...
    (Run 'diff -u /tmp/fstests/tests/btrfs/190.out /tmp/fstests/results//btrfs/190.out.bad'  to see the entire diff)
