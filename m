Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F131009C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBDXZa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 18:25:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46504 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBDXZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 18:25:26 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7E0E796E34F; Thu,  4 Feb 2021 18:24:45 -0500 (EST)
Date:   Thu, 4 Feb 2021 18:24:45 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 5/5] btrfs: add allocator_hint mode
Message-ID: <20210204232445.GC32440@hungrycats.org>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-6-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201212820.64381-6-kreijack@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 01, 2021 at 10:28:20PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When this mode is enabled, the chunk allocation policy is modified as follow.
> 
> Each disk may have a different tag:
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> 
> Where:
> - ALLOCATION_PREFERRED_X means that it is preferred to use this disk for the
> X chunk type (the other type may be allowed when the space is low)
> - ALLOCATION_X_ONLY means that it is used *only* for the X chunk type. This
> means also that it is a preferred choice.
> 
> Each time the allocator allocates a chunk of type X , first it takes the disks
> tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space is not
> enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY; if the space
> is not enough, it uses also the other disks, with the exception of the one
> marked as ALLOCATION_PREFERRED_Y, where Y the other type of chunk (i.e. not X).
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/volumes.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.h |  1 +
>  2 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 68b346c5465d..57ee3e2fdac0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4806,13 +4806,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>  }
>  
>  /*
> - * sort the devices in descending order by max_avail, total_avail
> + * sort the devices in descending order by alloc_hint,
> + * max_avail, total_avail
>   */
>  static int btrfs_cmp_device_info(const void *a, const void *b)
>  {
>  	const struct btrfs_device_info *di_a = a;
>  	const struct btrfs_device_info *di_b = b;
>  
> +	if (di_a->alloc_hint > di_b->alloc_hint)
> +		return -1;
> +	if (di_a->alloc_hint < di_b->alloc_hint)
> +		return 1;
>  	if (di_a->max_avail > di_b->max_avail)
>  		return -1;
>  	if (di_a->max_avail < di_b->max_avail)
> @@ -4939,6 +4944,15 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  	int ndevs = 0;
>  	u64 max_avail;
>  	u64 dev_offset;
> +	int hint;
> +
> +	static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
> +		[BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
> +		[BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
> +		[BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 1,
> +		[BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 2
> +		/* the other values are set to 0 */
> +	};
>  
>  	/*
>  	 * in the first pass through the devices list, we gather information
> @@ -4991,16 +5005,81 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  		devices_info[ndevs].max_avail = max_avail;
>  		devices_info[ndevs].total_avail = total_avail;
>  		devices_info[ndevs].dev = device;
> +
> +		if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
> +		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
> +		    info->allocation_hint_mode == 
> +		     BTRFS_ALLOCATION_HINT_DISABLED) {

Well, I guess if you're going to keep putting the mount option in each
new patch version, then I'm going to keep saying "please remove the
mount option" from each new patch version.

The right side of this || can be deleted, and the entire patch 4/5
(which adds the mount option).


> +			/*
> +			 * if mixed bg or the allocator hint is
> +			 * disable, set all the alloc_hint
> +			 * fields to the same value, so the sorting
> +			 * is not affected
> +			 */
> +			devices_info[ndevs].alloc_hint = 0;
> +		} else if(ctl->type & BTRFS_BLOCK_GROUP_DATA) {
> +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_METADATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_METADATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,
> +			 * sort also by hint (data disk
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
> +		} else { /* BTRFS_BLOCK_GROUP_METADATA */
> +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_DATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_DATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,
> +			 * sort also by hint (metadata hint
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
> +		}
> +
>  		++ndevs;
>  	}
>  	ctl->ndevs = ndevs;
>  
> +	/*
> +	 * no devices available
> +	 */
> +	if (!ndevs)
> +		return 0;
> +
>  	/*
>  	 * now sort the devices by hole size / available space
>  	 */
>  	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>  	     btrfs_cmp_device_info, NULL);
>  
> +	/*
> +	 * select the minimum set of disks grouped by hint that
> +	 * can host the chunk
> +	 */
> +	ndevs = 0;
> +	while (ndevs < ctl->ndevs) {
> +		hint = devices_info[ndevs++].alloc_hint;
> +		while (devices_info[ndevs].alloc_hint == hint &&
> +		       ndevs < ctl->ndevs)
> +				ndevs++;

So I ripped out the unnecessary line and patch 4 and started running it,
and hit the following pretty quickly:

	[Thu Feb  4 18:13:14 2021] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[Thu Feb  4 18:13:14 2021] ==================================================================
	[Thu Feb  4 18:13:14 2021] BUG: KASAN: slab-out-of-bounds in btrfs_alloc_chunk+0x74b/0x1320
	[Thu Feb  4 18:13:14 2021] Read of size 4 at addr ffff88812e1a7100 by task btrfs/7605

	[Thu Feb  4 18:13:14 2021] CPU: 1 PID: 7605 Comm: btrfs Tainted: G        W         5.10.9-acdf531fae43+ #4
	[Thu Feb  4 18:13:14 2021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[Thu Feb  4 18:13:14 2021] Call Trace:
	[Thu Feb  4 18:13:14 2021]  dump_stack+0xbc/0xf9
	[Thu Feb  4 18:13:14 2021]  ? btrfs_alloc_chunk+0x74b/0x1320
	[Thu Feb  4 18:13:14 2021]  print_address_description.constprop.8+0x21/0x210
	[Thu Feb  4 18:13:14 2021]  ? record_print_text.cold.34+0x11/0x11
	[Thu Feb  4 18:13:14 2021]  ? btrfs_alloc_chunk+0x74b/0x1320
	[Thu Feb  4 18:13:14 2021]  ? btrfs_alloc_chunk+0x74b/0x1320
	[Thu Feb  4 18:13:14 2021]  kasan_report.cold.10+0x20/0x37
	[Thu Feb  4 18:13:14 2021]  ? update_dev_time+0x30/0x40
	[Thu Feb  4 18:13:14 2021]  ? btrfs_alloc_chunk+0x74b/0x1320
	[Thu Feb  4 18:13:14 2021]  __asan_load4+0x69/0x90
	[Thu Feb  4 18:13:14 2021]  btrfs_alloc_chunk+0x74b/0x1320
	[Thu Feb  4 18:13:14 2021]  ? btrfs_shrink_device+0x8f0/0x8f0
	[Thu Feb  4 18:13:14 2021]  ? _raw_spin_unlock+0x22/0x30
	[Thu Feb  4 18:13:14 2021]  ? btrfs_block_rsv_add_bytes+0x53/0x80
	[Thu Feb  4 18:13:14 2021]  ? btrfs_block_rsv_add+0x43/0x50
	[Thu Feb  4 18:13:14 2021]  ? check_system_chunk+0x1ac/0x1e0
	[Thu Feb  4 18:13:14 2021]  btrfs_chunk_alloc+0x2aa/0x430
	[Thu Feb  4 18:13:14 2021]  find_free_extent+0x1159/0x18a0
	[Thu Feb  4 18:13:14 2021]  ? unpin_extent_range+0xb60/0xb60
	[Thu Feb  4 18:13:14 2021]  ? do_raw_spin_lock+0x1e0/0x1e0
	[Thu Feb  4 18:13:14 2021]  ? _raw_spin_unlock+0x22/0x30
	[Thu Feb  4 18:13:14 2021]  ? btrfs_get_alloc_profile+0x1d1/0x340
	[Thu Feb  4 18:13:14 2021]  btrfs_reserve_extent+0xe0/0x200
	[Thu Feb  4 18:13:14 2021]  btrfs_alloc_tree_block+0x1ab/0x850
	[Thu Feb  4 18:13:14 2021]  ? is_bpf_text_address+0x86/0xf0
	[Thu Feb  4 18:13:14 2021]  ? btrfs_alloc_logged_file_extent+0x1d0/0x1d0
	[Thu Feb  4 18:13:14 2021]  ? kmem_cache_free+0x13/0x20
	[Thu Feb  4 18:13:14 2021]  ? stack_trace_save+0x87/0xb0
	[Thu Feb  4 18:13:14 2021]  ? stack_trace_consume_entry+0x90/0x90
	[Thu Feb  4 18:13:14 2021]  alloc_tree_block_no_bg_flush+0xca/0xf0
	[Thu Feb  4 18:13:14 2021]  __btrfs_cow_block+0x274/0x950
	[Thu Feb  4 18:13:14 2021]  ? lock_downgrade+0x3d0/0x3f0
	[Thu Feb  4 18:13:14 2021]  ? update_ref_for_cow+0x550/0x550
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_read+0x11/0x20
	[Thu Feb  4 18:13:14 2021]  btrfs_cow_block+0x1b9/0x370
	[Thu Feb  4 18:13:14 2021]  btrfs_search_slot+0x97a/0xfc0
	[Thu Feb  4 18:13:14 2021]  ? kmem_cache_free.part.56+0x114/0x180
	[Thu Feb  4 18:13:14 2021]  ? split_leaf+0x9a0/0x9a0
	[Thu Feb  4 18:13:14 2021]  ? btrfs_drop_extent_cache+0x201/0x7a0
	[Thu Feb  4 18:13:14 2021]  ? __kasan_kmalloc.constprop.18+0xbe/0xd0
	[Thu Feb  4 18:13:14 2021]  ? btrfs_buffered_write.isra.30+0xaa0/0xaa0
	[Thu Feb  4 18:13:14 2021]  ? kmem_cache_free+0x13/0x20
	[Thu Feb  4 18:13:14 2021]  btrfs_truncate_inode_items+0x339/0x1570
	[Thu Feb  4 18:13:14 2021]  ? ___might_sleep+0x10f/0x1e0
	[Thu Feb  4 18:13:14 2021]  ? __might_sleep+0x71/0xe0
	[Thu Feb  4 18:13:14 2021]  ? btrfs_rmdir+0x290/0x290
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_write+0x14/0x20
	[Thu Feb  4 18:13:14 2021]  ? unmap_mapping_pages+0xb7/0x1d0
	[Thu Feb  4 18:13:14 2021]  ? do_wp_page+0x4f0/0x4f0
	[Thu Feb  4 18:13:14 2021]  ? trace_hardirqs_on+0x55/0x120
	[Thu Feb  4 18:13:14 2021]  btrfs_truncate_free_space_cache+0x1ef/0x320
	[Thu Feb  4 18:13:14 2021]  delete_block_group_cache+0x80/0xd0
	[Thu Feb  4 18:13:14 2021]  btrfs_relocate_block_group+0x1a3/0x4c0
	[Thu Feb  4 18:13:14 2021]  ? block_group_cache_tree_search+0x156/0x190
	[Thu Feb  4 18:13:14 2021]  btrfs_relocate_chunk+0x52/0x120
	[Thu Feb  4 18:13:14 2021]  btrfs_balance+0xe09/0x18e0
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_read+0x11/0x20
	[Thu Feb  4 18:13:14 2021]  ? lock_acquire+0xd0/0x550
	[Thu Feb  4 18:13:14 2021]  ? btrfs_relocate_chunk+0x120/0x120
	[Thu Feb  4 18:13:14 2021]  ? kasan_free_pages+0x4f/0x60
	[Thu Feb  4 18:13:14 2021]  ? kmem_cache_alloc_trace+0x74b/0xca0
	[Thu Feb  4 18:13:14 2021]  ? _copy_from_user+0x83/0xc0
	[Thu Feb  4 18:13:14 2021]  btrfs_ioctl_balance+0x3a7/0x460
	[Thu Feb  4 18:13:14 2021]  btrfs_ioctl+0x3197/0x3fa0
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_read+0x11/0x20
	[Thu Feb  4 18:13:14 2021]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_read+0x11/0x20
	[Thu Feb  4 18:13:14 2021]  ? lock_release+0xc8/0x640
	[Thu Feb  4 18:13:14 2021]  ? check_flags+0x30/0x30
	[Thu Feb  4 18:13:14 2021]  ? handle_mm_fault+0x168d/0x2150
	[Thu Feb  4 18:13:14 2021]  ? lock_downgrade+0x3f0/0x3f0
	[Thu Feb  4 18:13:14 2021]  ? handle_mm_fault+0x159e/0x2150
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_read+0x11/0x20
	[Thu Feb  4 18:13:14 2021]  ? lock_release+0xc8/0x640
	[Thu Feb  4 18:13:14 2021]  ? do_user_addr_fault+0x299/0x5a0
	[Thu Feb  4 18:13:14 2021]  ? do_raw_spin_unlock+0xa8/0x140
	[Thu Feb  4 18:13:14 2021]  ? lock_downgrade+0x3f0/0x3f0
	[Thu Feb  4 18:13:14 2021]  ? _raw_spin_unlock+0x22/0x30
	[Thu Feb  4 18:13:14 2021]  ? handle_mm_fault+0xad6/0x2150
	[Thu Feb  4 18:13:14 2021]  ? do_vfs_ioctl+0xfc/0x9d0
	[Thu Feb  4 18:13:14 2021]  ? ioctl_file_clone+0xe0/0xe0
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_write+0x14/0x20
	[Thu Feb  4 18:13:14 2021]  ? up_read+0x176/0x4f0
	[Thu Feb  4 18:13:14 2021]  ? down_read_killable_nested+0x4e0/0x4e0
	[Thu Feb  4 18:13:14 2021]  ? vmacache_find+0xc9/0x120
	[Thu Feb  4 18:13:14 2021]  ? __kasan_check_read+0x11/0x20
	[Thu Feb  4 18:13:14 2021]  ? __fget_light+0xae/0x110
	[Thu Feb  4 18:13:14 2021]  __x64_sys_ioctl+0xc3/0x100
	[Thu Feb  4 18:13:14 2021]  do_syscall_64+0x37/0x80
	[Thu Feb  4 18:13:14 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[Thu Feb  4 18:13:14 2021] RIP: 0033:0x7fc6f9b97427
	[Thu Feb  4 18:13:14 2021] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[Thu Feb  4 18:13:14 2021] RSP: 002b:00007ffe8166f088 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
	[Thu Feb  4 18:13:14 2021] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc6f9b97427
	[Thu Feb  4 18:13:14 2021] RDX: 00007ffe8166f110 RSI: 00000000c4009420 RDI: 0000000000000003
	[Thu Feb  4 18:13:14 2021] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[Thu Feb  4 18:13:14 2021] R10: fffffffffffff6ed R11: 0000000000000206 R12: 00007ffe81671a3c
	[Thu Feb  4 18:13:14 2021] R13: 00007ffe8166f110 R14: 0000000000000001 R15: 0000000000000000

	[Thu Feb  4 18:13:14 2021] Allocated by task 7605:
	[Thu Feb  4 18:13:14 2021]  kasan_save_stack+0x21/0x50
	[Thu Feb  4 18:13:14 2021]  __kasan_kmalloc.constprop.18+0xbe/0xd0
	[Thu Feb  4 18:13:14 2021]  kasan_kmalloc+0x9/0x10
	[Thu Feb  4 18:13:14 2021]  __kmalloc+0x4af/0xcc0
	[Thu Feb  4 18:13:14 2021]  btrfs_alloc_chunk+0x3b4/0x1320
	[Thu Feb  4 18:13:14 2021]  btrfs_chunk_alloc+0x2aa/0x430
	[Thu Feb  4 18:13:14 2021]  find_free_extent+0x1159/0x18a0
	[Thu Feb  4 18:13:14 2021]  btrfs_reserve_extent+0xe0/0x200
	[Thu Feb  4 18:13:14 2021]  btrfs_alloc_tree_block+0x1ab/0x850
	[Thu Feb  4 18:13:14 2021]  alloc_tree_block_no_bg_flush+0xca/0xf0
	[Thu Feb  4 18:13:14 2021]  __btrfs_cow_block+0x274/0x950
	[Thu Feb  4 18:13:14 2021]  btrfs_cow_block+0x1b9/0x370
	[Thu Feb  4 18:13:14 2021]  btrfs_search_slot+0x97a/0xfc0
	[Thu Feb  4 18:13:14 2021]  btrfs_truncate_inode_items+0x339/0x1570
	[Thu Feb  4 18:13:14 2021]  btrfs_truncate_free_space_cache+0x1ef/0x320
	[Thu Feb  4 18:13:14 2021]  delete_block_group_cache+0x80/0xd0
	[Thu Feb  4 18:13:14 2021]  btrfs_relocate_block_group+0x1a3/0x4c0
	[Thu Feb  4 18:13:14 2021]  btrfs_relocate_chunk+0x52/0x120
	[Thu Feb  4 18:13:14 2021]  btrfs_balance+0xe09/0x18e0
	[Thu Feb  4 18:13:14 2021]  btrfs_ioctl_balance+0x3a7/0x460
	[Thu Feb  4 18:13:14 2021]  btrfs_ioctl+0x3197/0x3fa0
	[Thu Feb  4 18:13:14 2021]  __x64_sys_ioctl+0xc3/0x100
	[Thu Feb  4 18:13:14 2021]  do_syscall_64+0x37/0x80
	[Thu Feb  4 18:13:14 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

	[Thu Feb  4 18:13:14 2021] The buggy address belongs to the object at ffff88812e1a7040
				    which belongs to the cache kmalloc-192 of size 192
	[Thu Feb  4 18:13:14 2021] The buggy address is located 0 bytes to the right of
				    192-byte region [ffff88812e1a7040, ffff88812e1a7100)
	[Thu Feb  4 18:13:14 2021] The buggy address belongs to the page:
	[Thu Feb  4 18:13:14 2021] page:00000000210b7c03 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88812e1a7ff1 pfn:0x12e1a7
	[Thu Feb  4 18:13:14 2021] flags: 0x17ffe0000000200(slab)
	[Thu Feb  4 18:13:14 2021] raw: 017ffe0000000200 ffffea000696d108 ffffea0006ba3ec8 ffff888100040b40
	[Thu Feb  4 18:13:14 2021] raw: ffff88812e1a7ff1 ffff88812e1a7040 000000010000000d 0000000000000000
	[Thu Feb  4 18:13:14 2021] page dumped because: kasan: bad access detected

	[Thu Feb  4 18:13:14 2021] Memory state around the buggy address:
	[Thu Feb  4 18:13:14 2021]  ffff88812e1a7000: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
	[Thu Feb  4 18:13:14 2021]  ffff88812e1a7080: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
	[Thu Feb  4 18:13:14 2021] >ffff88812e1a7100: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
	[Thu Feb  4 18:13:14 2021]                    ^
	[Thu Feb  4 18:13:14 2021]  ffff88812e1a7180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	[Thu Feb  4 18:13:14 2021]  ffff88812e1a7200: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
	[Thu Feb  4 18:13:14 2021] ==================================================================

	(gdb) l *(btrfs_alloc_chunk+0x74b)
	0xffffffff8190c3ab is in btrfs_alloc_chunk (fs/btrfs/volumes.c:5047).
	5042            ndevs = 0;
	5043            while (ndevs < ctl->ndevs) {
	5044                    hint = devices_info[ndevs++].alloc_hint;
	5045                    while (devices_info[ndevs].alloc_hint == hint &&
	5046                           ndevs < ctl->ndevs)
	5047                                    ndevs++;
	5048                    if (ndevs >= ctl->devs_min)
	5049                            break;
	5050            }
	5051

> +		if (ndevs >= ctl->devs_min)
> +			break;
> +	}
> +
> +	BUG_ON(ndevs > ctl->ndevs);
> +	ctl->ndevs = ndevs;
> +
>  	return 0;
>  }
>  
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index d776b7f55d56..31a3e4cf93b5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -364,6 +364,7 @@ struct btrfs_device_info {
>  	u64 dev_offset;
>  	u64 max_avail;
>  	u64 total_avail;
> +	int alloc_hint;
>  };
>  
>  struct btrfs_raid_attr {
> -- 
> 2.30.0
> 
