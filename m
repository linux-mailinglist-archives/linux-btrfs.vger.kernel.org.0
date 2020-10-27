Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4929A704
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 09:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895132AbgJ0IxU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 04:53:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895130AbgJ0IxU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 04:53:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603788798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UDVHZPrv5nnjW+blnnqE/XMqoM6flptJxe9Lzg2FCbg=;
        b=Fr0tfPEN0qZk2MReEQ9jsAHdKsRCuFMuql6xkhWeSIyDGAs3+lAgr8rwuMIdoV3VI4TqAW
        nzb83ROrka6HMcIQHNKXSbnxp4yOfgKyvmHw/5HSmCRRmccHAcCYq3lSXQYObHTLvdc9Kx
        +i3dOPPzONrcCbYXL6Ud+U540HWW0L0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17F97ACE6;
        Tue, 27 Oct 2020 08:53:18 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] btrfs: fix min reserved size calculation in
 merge_reloc_root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1603745723.git.josef@toxicpanda.com>
 <617eb7b3560d2319b8362209331fa4bc3ec03cc5.1603745723.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c4aaf781-49b8-6f83-8e1a-9ae003a9e80e@suse.com>
Date:   Tue, 27 Oct 2020 10:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <617eb7b3560d2319b8362209331fa4bc3ec03cc5.1603745723.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.10.20 г. 22:57 ч., Josef Bacik wrote:
> The minimum reserve size was adjusted to take into account the height of
> the tree we are merging, however we can have a root with a level == 0.
> What we want is root_level + 1 to get the number of nodes we may have to
> cow.  This fixes the enospc_debug warning pops with btrfs/101.
> 
> 44d354abf33e ("btrfs: relocation: review the call sites which can be interrupted by signal")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

FWIW this fixes failures on btrfs/060 btrfs/062 btrfs/063 and btrfs/195 That I was seeing, the call trace was: 

[ 3680.515564] ------------[ cut here ]------------
[ 3680.515566] BTRFS: block rsv returned -28
[ 3680.515585] WARNING: CPU: 2 PID: 8339 at fs/btrfs/block-rsv.c:521 btrfs_use_block_rsv+0x162/0x180
[ 3680.515587] Modules linked in:
[ 3680.515591] CPU: 2 PID: 8339 Comm: btrfs Tainted: G        W         5.9.0-rc8-default #95
[ 3680.515593] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[ 3680.515595] RIP: 0010:btrfs_use_block_rsv+0x162/0x180
[ 3680.515600] RSP: 0018:ffffa01ac9753910 EFLAGS: 00010282
[ 3680.515602] RAX: 0000000000000000 RBX: ffff984b34200000 RCX: 0000000000000027
[ 3680.515604] RDX: 0000000000000027 RSI: 0000000000000000 RDI: ffff984b3bd19e28
[ 3680.515606] RBP: 0000000000004000 R08: ffff984b3bd19e20 R09: 0000000000000001
[ 3680.515608] R10: 0000000000000004 R11: 0000000000000046 R12: ffff984b264fdc00
[ 3680.515609] R13: ffff984b13149000 R14: 00000000ffffffe4 R15: ffff984b34200000
[ 3680.515613] FS:  00007f4e2912b8c0(0000) GS:ffff984b3bd00000(0000) knlGS:0000000000000000
[ 3680.515615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3680.515617] CR2: 00007fab87122150 CR3: 0000000118e42000 CR4: 00000000000006e0
[ 3680.515620] Call Trace:
[ 3680.515627]  btrfs_alloc_tree_block+0x8b/0x340
[ 3680.515633]  ? __lock_acquire+0x51a/0xac0
[ 3680.515646]  alloc_tree_block_no_bg_flush+0x4f/0x60
[ 3680.515651]  __btrfs_cow_block+0x14e/0x7e0
[ 3680.515662]  btrfs_cow_block+0x144/0x2c0
[ 3680.515670]  merge_reloc_root+0x4d4/0x610
[ 3680.515675]  ? btrfs_lookup_fs_root+0x78/0x90
[ 3680.515686]  merge_reloc_roots+0xee/0x280
[ 3680.515695]  relocate_block_group+0x2ce/0x5e0
[ 3680.515704]  btrfs_relocate_block_group+0x16e/0x310
[ 3680.515711]  btrfs_relocate_chunk+0x38/0xf0
[ 3680.515716]  btrfs_shrink_device+0x200/0x560
[ 3680.515728]  btrfs_rm_device+0x1ae/0x6a6
[ 3680.515744]  ? _copy_from_user+0x6e/0xb0
[ 3680.515750]  btrfs_ioctl+0x1afe/0x28c0
[ 3680.515755]  ? find_held_lock+0x2b/0x80
[ 3680.515760]  ? do_user_addr_fault+0x1f8/0x418
[ 3680.515773]  ? __x64_sys_ioctl+0x77/0xb0
[ 3680.515775]  __x64_sys_ioctl+0x77/0xb0
[ 3680.515781]  do_syscall_64+0x31/0x70
[ 3680.515785]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>


> ---
>  fs/btrfs/relocation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3602806d71bd..9ba92d86da0b 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1648,6 +1648,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
>  	struct btrfs_root_item *root_item;
>  	struct btrfs_path *path;
>  	struct extent_buffer *leaf;
> +	int reserve_level;
>  	int level;
>  	int max_level;
>  	int replaced = 0;
> @@ -1696,7 +1697,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
>  	 * Thus the needed metadata size is at most root_level * nodesize,
>  	 * and * 2 since we have two trees to COW.
>  	 */
> -	min_reserved = fs_info->nodesize * btrfs_root_level(root_item) * 2;
> +	reserve_level = max_t(int, 1, btrfs_root_level(root_item));
> +	min_reserved = fs_info->nodesize * reserve_level * 2;
>  	memset(&next_key, 0, sizeof(next_key));
>  
>  	while (1) {
> 
