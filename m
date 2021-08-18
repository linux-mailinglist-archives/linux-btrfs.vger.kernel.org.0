Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9F3F01FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhHRKtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 06:49:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42348 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhHRKtj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 06:49:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 73AEB1FFB2;
        Wed, 18 Aug 2021 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629283744;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yStd+SNXEO+Vk9ZVmZD4/qGvHvfosXgcoii2/k/ZuOE=;
        b=FvaL1PAFZl1Z43ABumhGlOCiMEwqBT7qKWNHe9KrltQKqcd4h46O2dqRQfrE4Xit9dB+i1
        6YHdi2IvAjcmriyew+eE7TWtnia8Zi+PVrBdnbH9W+Q91921xVO56v1FTfXgpLSEauQ1ze
        TDruHWsYVNYBqmbZjnnoiMSfxAcubC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629283744;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yStd+SNXEO+Vk9ZVmZD4/qGvHvfosXgcoii2/k/ZuOE=;
        b=FkGG5LO4EtGD5Wb6ARGwN4tYraazLuWDzOhyFX4rTdrfuX7fOaMAivs6XrTiMmx7HVy8LD
        I6lstmR8TJdOdLBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6B2D0A3B96;
        Wed, 18 Aug 2021 10:49:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9755DA72C; Wed, 18 Aug 2021 12:46:07 +0200 (CEST)
Date:   Wed, 18 Aug 2021 12:46:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wentao_Liang <Wentao_Liang_g@163.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a potential double put bug and some related
 use-after-free bugs
Message-ID: <20210818104607.GT5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wentao_Liang <Wentao_Liang_g@163.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210818091518.4825-1-Wentao_Liang_g@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818091518.4825-1-Wentao_Liang_g@163.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 05:15:18PM +0800, Wentao_Liang wrote:
> In line 2955 (#1), "btrfs_put_block_group(cache);" drops the reference to
> cache and may cause the cache to be released. However, in line 3014, the
> cache is dropped again by the same put function (#4). Double putting the
> cache can lead to an incorrect reference count.
> 
> Furthermore, according to the definition of btrfs_put_block_group() in fs/
> btrfs/block-group.c, if the reference count of the cache is one at the
> first put, it will be freed by kfree(). Using it again may result in the
> use-after-free flaw. In fact, after the first put (line 2955), the cache
> is also accessed in a few places (#2, #3), e.g., lines 2967, 2973, 2974,
> ….
> 
> We believe that the first put of the cache is unnecessary (#1).
> We can fix the above bugs by removing the redundant
> "btrfs_put_block_group(cache);" in line 2955 (#1).
> 
> 2951         if (!list_empty(&cache->io_list)) {
> ...
> 2955             btrfs_put_block_group(cache);
> 				 //#1 the first drop to cache (unnecessary)
> ...
> 2957         }
> ...
> 2967         cache_save_setup(cache, trans, path); //#2 use the cache
> ...
> 2972          //#3 use the cache several times
> 
> 2973         if (!ret && cache->disk_cache_state == BTRFS_DC_SETUP) {
> 2974             cache->io_ctl.inode = NULL;
> 2975             ret = btrfs_write_out_cache(trans, cache, path);
> 2976             if (ret == 0 && cache->io_ctl.inode) {
> 2977                 num_started++;
> 2978                 should_put = 0;
> 2979                 list_add_tail(&cache->io_list, io);
> 2980             } else {
> ...
> 2985                 ret = 0;
> 2986             }
> 2987         }
> 2988         if (!ret) {
> 2989             ret = update_block_group_item(trans, path, cache);
> ...
> 3003             if (ret == -ENOENT) {
> ...
> 3006                 ret = update_block_group_item(trans, path, cache);
> 3007             }
> ...
> 3010         }
> 3011
> ...
> 3013         if (should_put)
> 3014             btrfs_put_block_group(cache);
> 				//#4 the second drop to cache
> 
> Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>

Have you tested the patch? It hits and assertion in the first test
btrfs/001:

3856                 btrfs_remove_free_space_cache(block_group);
3857                 ASSERT(block_group->cached != BTRFS_CACHE_STARTED);
3858                 ASSERT(list_empty(&block_group->dirty_list));
3859                 ASSERT(list_empty(&block_group->io_list));
3860                 ASSERT(list_empty(&block_group->bg_list));
3861                 ASSERT(refcount_read(&block_group->refs) == 1);

[   23.884253] BTRFS: device fsid e3a2f9ca-8015-49d5-a97b-efe96f575b17 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (410)
[   23.934083] BTRFS info (device vdb): disk space caching is enabled
[   23.936108] BTRFS info (device vdb): has skinny extents
[   23.937813] BTRFS info (device vdb): flagging fs with big metadata feature
[   23.946471] BTRFS info (device vdb): checking UUID tree
[   23.971424] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:3861
[   23.974909] ------------[ cut here ]------------
[   23.976185] kernel BUG at fs/btrfs/ctree.h:3451!
[   23.977357] invalid opcode: 0000 [#1] PREEMPT SMP
[   23.978532] CPU: 2 PID: 440 Comm: umount Not tainted 5.14.0-rc6-default+ #1544
[   23.980270] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[   23.982832] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
[   23.984353] Code: 24 08 44 8b 14 24 45 8b b0 a0 23 00 00 e9 d6 90 fd ff 89 f1 48 c7 c2 a7 b1 56 c0 48 89 fe 48 c7 c7 08 8d 57 c0 e8 7b 70 22 de <0f> 0b be a1 00 00 00 48 c7 c7 cf b1 56 c0 e8 d5 ff ff ff ba 9d 0a
[   23.988793] RSP: 0018:ffffb66f80cd7dc0 EFLAGS: 00010246
[   23.990122] RAX: 0000000000000058 RBX: ffff95f195660000 RCX: 0000000000000000
[   23.991810] RDX: 0000000000000000 RSI: ffffffff9eee124c RDI: 00000000ffffffff
[   23.993402] RBP: ffff95f19890a800 R08: 0000000000000001 R09: 0000000000000001
[   23.995056] R10: 0000000000000000 R11: 0000000000000001 R12: ffff95f195660110
[   23.996627] R13: ffff95f195660160 R14: ffff95f19890a988 R15: dead000000000100
[   23.998232] FS:  00007f7b47a70800(0000) GS:ffff95f1fda00000(0000) knlGS:0000000000000000
[   23.999968] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.001233] CR2: 00007f7b47bff000 CR3: 00000000188f8004 CR4: 0000000000170ea0
[   24.002830] Call Trace:
[   24.003485]  btrfs_free_block_groups.cold+0x33/0x66 [btrfs]
[   24.004762]  close_ctree+0x319/0x35a [btrfs]
[   24.005756]  ? fsnotify_destroy_marks+0x24/0x130
[   24.006859]  generic_shutdown_super+0x69/0x100
[   24.008030]  kill_anon_super+0x14/0x30
[   24.008943]  btrfs_kill_super+0x12/0x20 [btrfs]
[   24.009978]  deactivate_locked_super+0x2c/0xa0
[   24.010971]  cleanup_mnt+0x144/0x1b0
[   24.011816]  task_work_run+0x59/0xa0
[   24.012618]  exit_to_user_mode_loop+0xe7/0xf0
[   24.013640]  exit_to_user_mode_prepare+0xaf/0xf0
[   24.014682]  syscall_exit_to_user_mode+0x19/0x50
[   24.015762]  do_syscall_64+0x4a/0x90
[   24.016649]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   24.017793] RIP: 0033:0x7f7b47c934db
[   24.018634] Code: 29 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 61 29 0c 00 f7 d8
[   24.022729] RSP: 002b:00007ffde0d8a208 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   24.024435] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7b47c934db
[   24.026067] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055c86a6b4b90
[   24.027681] RBP: 000055c86a6b4960 R08: 0000000000000000 R09: 00007ffde0d88f90
[   24.029220] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   24.030744] R13: 000055c86a6b4b90 R14: 000055c86a6b4a70 R15: 000055c86a6b4960
[   24.032314] Modules linked in: btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[   24.035509] ---[ end trace 92be60e092599330 ]---
[   24.036528] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
[   24.037856] Code: 24 08 44 8b 14 24 45 8b b0 a0 23 00 00 e9 d6 90 fd ff 89 f1 48 c7 c2 a7 b1 56 c0 48 89 fe 48 c7 c7 08 8d 57 c0 e8 7b 70 22 de <0f> 0b be a1 00 00 00 48 c7 c7 cf b1 56 c0 e8 d5 ff ff ff ba 9d 0a
[   24.042025] RSP: 0018:ffffb66f80cd7dc0 EFLAGS: 00010246
[   24.043239] RAX: 0000000000000058 RBX: ffff95f195660000 RCX: 0000000000000000
[   24.044797] RDX: 0000000000000000 RSI: ffffffff9eee124c RDI: 00000000ffffffff
[   24.046335] RBP: ffff95f19890a800 R08: 0000000000000001 R09: 0000000000000001
[   24.047877] R10: 0000000000000000 R11: 0000000000000001 R12: ffff95f195660110
[   24.049318] R13: ffff95f195660160 R14: ffff95f19890a988 R15: dead000000000100
[   24.050829] FS:  00007f7b47a70800(0000) GS:ffff95f1fda00000(0000) knlGS:0000000000000000
[   24.052660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.053956] CR2: 00007f7b47bff000 CR3: 00000000188f8004 CR4: 0000000000170ea0

> ---
>  fs/btrfs/block-group.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9e7d9d0c763d..c510c821b1be 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2953,7 +2953,6 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
>  			spin_unlock(&cur_trans->dirty_bgs_lock);
>  			list_del_init(&cache->io_list);
>  			btrfs_wait_cache_io(trans, cache, path);
> -			btrfs_put_block_group(cache);
>  			spin_lock(&cur_trans->dirty_bgs_lock);
>  		}
>  
> -- 
> 2.25.1
