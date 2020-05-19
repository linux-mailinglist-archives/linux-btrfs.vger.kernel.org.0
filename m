Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842541D98DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgESOFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 10:05:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:51938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgESOFL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 10:05:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E285AD17;
        Tue, 19 May 2020 14:05:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D184DA7AD; Tue, 19 May 2020 16:04:15 +0200 (CEST)
Date:   Tue, 19 May 2020 16:04:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: relocation: Fix reloc root leakage and the NULL
 pointer reference caused by the leakage
Message-ID: <20200519140414.GD18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200519021320.13979-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519021320.13979-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 19, 2020 at 10:13:20AM +0800, Qu Wenruo wrote:
> [BUG]
> When balance is canceled, there is a pretty high chance that unmounting
> the fs can lead to lead the NULL pointer dereference:
> 
>   BTRFS warning (device dm-3): page private not zero on page 223158272
>   ...
>   BTRFS warning (device dm-3): page private not zero on page 223162368
>   BTRFS error (device dm-3): leaked root 18446744073709551608-304 refcount 1
>   BUG: kernel NULL pointer dereference, address: 0000000000000168
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 2 PID: 5793 Comm: umount Tainted: G           O      5.7.0-rc5-custom+ #53
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:__lock_acquire+0x5dc/0x24c0
>   Call Trace:
>    lock_acquire+0xab/0x390
>    _raw_spin_lock+0x39/0x80
>    btrfs_release_extent_buffer_pages+0xd7/0x200 [btrfs]
>    release_extent_buffer+0xb2/0x170 [btrfs]
>    free_extent_buffer+0x66/0xb0 [btrfs]
>    btrfs_put_root+0x8e/0x130 [btrfs]
>    btrfs_check_leaked_roots.cold+0x5/0x5d [btrfs]
>    btrfs_free_fs_info+0xe5/0x120 [btrfs]
>    btrfs_kill_super+0x1f/0x30 [btrfs]
>    deactivate_locked_super+0x3b/0x80
>    deactivate_super+0x3e/0x50
>    cleanup_mnt+0x109/0x160
>    __cleanup_mnt+0x12/0x20
>    task_work_run+0x67/0xa0
>    exit_to_usermode_loop+0xc5/0xd0
>    syscall_return_slowpath+0x205/0x360
>    do_syscall_64+0x6e/0xb0
>    entry_SYSCALL_64_after_hwframe+0x49/0xb3
>   RIP: 0033:0x7fd028ef740b
> 
> [CAUSE]
> When balance is canceled, all reloc roots are marked orphan, and orphan
> reloc roots are going to be cleaned up.
> 
> However for orphan reloc roots and merged reloc roots, their lifespan
> are quite different:
> 	Merged reloc roots	|	Orphan reloc roots by cancel
> --------------------------------------------------------------------
> create_reloc_root()		| create_reloc_root()
> |- refs == 1			| |- refs == 1
> 				|
> btrfs_grab_root(reloc_root);	| btrfs_grab_root(reloc_root);
> |- refs == 2			| |- refs == 2
> 				|
> root->reloc_root = reloc_root;	| root->reloc_root = reloc_root;
> 		>>> No difference so far <<<
> 				|
> prepare_to_merge()		| prepare_to_merge()
> |- btrfs_set_root_refs(item, 1);| |- if (!err) (err == -EINTR)
> 				|
> merge_reloc_roots()		| merge_reloc_roots()
> |- merge_reloc_root()		| |- Doing nothing to put reloc root
>    |- insert_dirty_subvol()	| |- refs == 2
>       |- __del_reloc_root()	|
>          |- btrfs_put_root()	|
>             |- refs == 1	|
> 		>>> Now orphan reloc roots still have refs 2 <<<
> 				|
> clean_dirty_subvols()		| clean_dirty_subvols()
> |- btrfs_drop_snapshot()	| |- btrfS_drop_snapshot()
>    |- reloc_root get freed	|    |- reloc_root still has refs 2
> 				|	related ebs get freed, but
> 				|	reloc_root still recorded in
> 				|	allocated_roots
> btrfs_check_leaked_roots()	| btrfs_check_leaked_roots()
> |- No leaked roots		| |- Leaked reloc_roots detected
> 				| |- btrfs_put_root()
> 				|    |- free_extent_buffer(root->node);
> 				|       |- eb already freed, caused NULL
> 				|	   pointer dereference
> 
> [FIX]
> The fix is to clear fs_root->reloc_root and put it at
> merge_reloc_roots() time, so that we won't leak reloc roots.
> 
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")

Thanks. I've applied it before my cleanups (read_fs_root) but the fix
still depends on the refcounted root trees so it's no applicable to any
older stable trees.
