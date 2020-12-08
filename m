Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB42D2D6D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgLHOp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 09:45:29 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41430 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHOp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 09:45:29 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BA0688E7FBE; Tue,  8 Dec 2020 09:44:47 -0500 (EST)
Date:   Tue, 8 Dec 2020 09:44:46 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v5 13/52] btrfs: handle errors from select_reloc_root()
Message-ID: <20201208144446.GH31381@hungrycats.org>
References: <cover.1607349281.git.josef@toxicpanda.com>
 <5daa486a9ce06876bdef92a50f1a11d4eee9da67.1607349282.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5daa486a9ce06876bdef92a50f1a11d4eee9da67.1607349282.git.josef@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 08:57:05AM -0500, Josef Bacik wrote:
> Currently select_reloc_root() doesn't return an error, but followup
> patches will make it possible for it to return an error.  We do have
> proper error recovery in do_relocation however, so handle the
> possibility of select_reloc_root() having an error properly instead of
> BUG_ON(!root).  I've also adjusted select_reloc_root() to return
> ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
> error case easier to deal with.  I've replaced the BUG_ON(!root) with an
> ASSERT(ret != -ENOENT), as this indicates we messed up the backref
> walking code, but could indicate corruption so we do not want to have a
> BUG_ON() here.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4333ee329290..66515ccc04fe 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2027,7 +2027,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
>  			break;
>  	}
>  	if (!root)
> -		return NULL;
> +		return ERR_PTR(-ENOENT);
>  
>  	next = node;
>  	/* setup backref node path for btrfs_reloc_cow_block */
> @@ -2198,7 +2198,18 @@ static int do_relocation(struct btrfs_trans_handle *trans,
>  
>  		upper = edge->node[UPPER];
>  		root = select_reloc_root(trans, rc, upper, edges);
> -		BUG_ON(!root);
> +		if (IS_ERR(root)) {
> +			ret = PTR_ERR(root);
> +
> +			/*
> +			 * This can happen if there's fs corruption, but if we
> +			 * have ASSERT()'s on then we're developers and we
> +			 * likely made a logic mistake in the backref code, so
> +			 * check for this error condition.
> +			 */
> +			ASSERT(ret != -ENOENT);

Hit this once last night.  Test VM kept going after a reboot.

	[17579.428311][T10916] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[17579.773705][T10916] BTRFS info (device dm-0): relocating block group 3262427168768 flags metadata|raid1
	[17581.153861][T10916] assertion failed: ret != -ENOENT, in fs/btrfs/relocation.c:2369
	[17581.157815][T10916] ------------[ cut here ]------------
	[17581.161214][T10916] kernel BUG at fs/btrfs/ctree.h:3368!
	[17581.162817][T10916] invalid opcode: 0000 [#1] SMP KASAN PTI
	[17581.167786][T10916] CPU: 3 PID: 10916 Comm: btrfs Tainted: G        W         5.10.0-69dfffde3fb6-for-next+ #22
	[17581.174638][T10916] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[17581.177226][T10916] RIP: 0010:assertfail+0x18/0x1a
	[17581.178622][T10916] Code: a0 46 aa fe 48 8b 3d a9 bd fd 02 e8 94 46 aa fe 5d c3 55 89 d1 48 89 f2 48 89 fe 48 c7 c7 00 20 24 96 48 89 e5 e8 74 36 fe ff <0f> 0b 48 89 df e8 00 2b b4 fe 48 8b 85 98 fe ff ff 44 89 ea 48 c7
	[17581.187531][T10916] RSP: 0018:ffffc90001757400 EFLAGS: 00010286
	[17581.189711][T10916] RAX: 000000000000003f RBX: ffff888012dabf00 RCX: ffffffff94265ba2
	[17581.192629][T10916] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881f5fff28c
	[17581.195411][T10916] RBP: ffffc90001757400 R08: ffffed103ec015b5 R09: ffffed103ec015b5
	[17581.198061][T10916] R10: ffff8881f600ada7 R11: ffffed103ec015b4 R12: ffff888012dab668
	[17581.201387][T10916] R13: 0000000000000004 R14: 00000000fffffffe R15: ffff888005f18f00
	[17581.203965][T10916] FS:  00007f55e295b8c0(0000) GS:ffff8881f5e00000(0000) knlGS:0000000000000000
	[17581.207716][T10916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[17581.209584][T10916] CR2: 0000560ee9649da4 CR3: 00000000720d4005 CR4: 0000000000170ee0
	[17581.214157][T10916] Call Trace:
	[17581.215835][T10916]  do_relocation.cold.55+0x9c/0xb9
	[17581.218719][T10916]  ? select_reloc_root+0x6e0/0x6e0
	[17581.221899][T10916]  ? walk_up_backref+0x91/0xd0
	[17581.224508][T10916]  ? __asan_loadN+0xf/0x20
	[17581.234986][T10916]  ? memcpy+0x4d/0x60
	[17581.242655][T10916]  ? read_extent_buffer+0xd1/0x100
	[17581.250560][T10916]  relocate_tree_blocks+0xa70/0xb90
	[17581.253642][T10916]  ? do_relocation+0xc10/0xc10
	[17581.256300][T10916]  ? kmem_cache_alloc_trace+0x6a3/0xcb0
	[17581.259164][T10916]  ? free_extent_buffer.part.52+0xd7/0x140
	[17581.265002][T10916]  ? rb_insert_color+0x342/0x360
	[17581.267469][T10916]  relocate_block_group+0x2eb/0x780
	[17581.271941][T10916]  ? merge_reloc_roots+0x4a0/0x4a0
	[17581.273800][T10916]  btrfs_relocate_block_group+0x26e/0x4c0
	[17581.276285][T10916]  btrfs_relocate_chunk+0x52/0x120
	[17581.280022][T10916]  btrfs_balance+0xe2e/0x1900
	[17581.284864][T10916]  ? __kasan_check_read+0x11/0x20
	[17581.288259][T10916]  ? lock_acquire+0xd0/0x550
	[17581.291309][T10916]  ? btrfs_relocate_chunk+0x120/0x120
	[17581.295542][T10916]  ? kasan_unpoison_shadow+0x40/0x50
	[17581.298465][T10916]  ? kmem_cache_alloc_trace+0x6a3/0xcb0
	[17581.301092][T10916]  ? _copy_from_user+0x83/0xc0
	[17581.303427][T10916]  btrfs_ioctl_balance+0x3a7/0x460
	[17581.305850][T10916]  btrfs_ioctl+0x24c8/0x4360
	[17581.307699][T10916]  ? __kasan_check_read+0x11/0x20
	[17581.310098][T10916]  ? lock_release+0xc8/0x640
	[17581.312712][T10916]  ? lru_cache_add+0x178/0x250
	[17581.314991][T10916]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[17581.318654][T10916]  ? lock_downgrade+0x3f0/0x3f0
	[17581.320972][T10916]  ? handle_mm_fault+0x159e/0x2150
	[17581.323839][T10916]  ? __kasan_check_read+0x11/0x20
	[17581.326814][T10916]  ? lock_release+0xc8/0x640
	[17581.329251][T10916]  ? do_user_addr_fault+0x299/0x5a0
	[17581.332161][T10916]  ? do_raw_spin_unlock+0xa8/0x140
	[17581.334825][T10916]  ? lock_downgrade+0x3f0/0x3f0
	[17581.337282][T10916]  ? _raw_spin_unlock+0x22/0x30
	[17581.339972][T10916]  ? handle_mm_fault+0xad6/0x2150
	[17581.342585][T10916]  ? do_vfs_ioctl+0xfc/0x9d0
	[17581.345189][T10916]  ? ioctl_file_clone+0xe0/0xe0
	[17581.348274][T10916]  ? __kasan_check_write+0x14/0x20
	[17581.350976][T10916]  ? up_read+0x176/0x4f0
	[17581.353281][T10916]  ? down_write_nested+0x2d0/0x2d0
	[17581.356263][T10916]  ? vmacache_find+0xc9/0x120
	[17581.358822][T10916]  ? __kasan_check_read+0x11/0x20
	[17581.361699][T10916]  ? __fget_light+0xae/0x110
	[17581.364329][T10916]  __x64_sys_ioctl+0xc3/0x100
	[17581.367294][T10916]  do_syscall_64+0x37/0x80
	[17581.370340][T10916]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[17581.373984][T10916] RIP: 0033:0x7f55e2a4e427
	[17581.376697][T10916] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[17581.388513][T10916] RSP: 002b:00007ffdb30a1438 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
	[17581.393564][T10916] RAX: ffffffffffffffda RBX: 00007ffdb30a14d8 RCX: 00007f55e2a4e427
	[17581.398315][T10916] RDX: 00007ffdb30a14d8 RSI: 00000000c4009420 RDI: 0000000000000003
	[17581.402711][T10916] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[17581.407348][T10916] R10: fffffffffffff59d R11: 0000000000000202 R12: 0000000000000001
	[17581.412074][T10916] R13: 0000000000000000 R14: 00007ffdb30a3a34 R15: 0000000000000001
	[17581.417008][T10916] Modules linked in:
	[17581.420470][T10916] ---[ end trace 2aee413c08ff01b0 ]---
	[17581.424847][T10916] RIP: 0010:assertfail+0x18/0x1a
	[17581.428219][T10916] Code: a0 46 aa fe 48 8b 3d a9 bd fd 02 e8 94 46 aa fe 5d c3 55 89 d1 48 89 f2 48 89 fe 48 c7 c7 00 20 24 96 48 89 e5 e8 74 36 fe ff <0f> 0b 48 89 df e8 00 2b b4 fe 48 8b 85 98 fe ff ff 44 89 ea 48 c7
	[17581.441219][T10916] RSP: 0018:ffffc90001757400 EFLAGS: 00010286
	[17581.445067][T10916] RAX: 000000000000003f RBX: ffff888012dabf00 RCX: ffffffff94265ba2
	[17581.448863][T10916] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881f5fff28c
	[17581.454668][T10916] RBP: ffffc90001757400 R08: ffffed103ec015b5 R09: ffffed103ec015b5
	[17581.459261][T10916] R10: ffff8881f600ada7 R11: ffffed103ec015b4 R12: ffff888012dab668
	[17581.464851][T10916] R13: 0000000000000004 R14: 00000000fffffffe R15: ffff888005f18f00
	[17581.468591][T10916] FS:  00007f55e295b8c0(0000) GS:ffff8881f5e00000(0000) knlGS:0000000000000000
	[17581.473633][T10916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17581.477009][T10916] CR2: 0000560ee9649da4 CR3: 00000000720d4005 CR4: 0000000000170ee0

> +			goto next;
> +		}
>  
>  		if (upper->eb && !upper->locked) {
>  			if (!lowest) {
> -- 
> 2.26.2
> 
