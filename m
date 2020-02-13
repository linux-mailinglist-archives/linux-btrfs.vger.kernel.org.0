Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5741A15C996
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBMRkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 12:40:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMRkf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 12:40:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A77EFAD3B;
        Thu, 13 Feb 2020 17:40:33 +0000 (UTC)
Message-ID: <bb10a5f324f11d599ba2b9639576f21ed6ad1c0c.camel@suse.de>
Subject: Re: [PATCH] btrfs: Don't free tree_root when exiting
 btrfs_ioctl_get_subvol_info()
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Date:   Thu, 13 Feb 2020 14:43:32 -0300
In-Reply-To: <20200213130157.39230-1-wqu@suse.com>
References: <20200213130157.39230-1-wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2020-02-13 at 21:01 +0800, Qu Wenruo wrote:
> [BUG]
> When calling BTRF_IOC_GET_SUBVOL_INFO ioctl, we can easily hit the
> following backtrace:
>   BUG: kernel NULL pointer dereference, address: 0000000000000024
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP PTI
>   CPU: 0 PID: 27421 Comm: python3 Not tainted 5.6.0-rc1+ #539
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-
> 1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>   RIP: 0010:btrfs_root_node+0x7/0x30 [btrfs]
>   Call Trace:
>    btrfs_read_lock_root_node+0x1f/0x40 [btrfs]
>    btrfs_search_slot+0x60f/0xa40 [btrfs]
>    btrfs_ioctl+0x11f7/0x30b0 [btrfs]
>    ksys_ioctl+0x82/0xc0
>    __x64_sys_ioctl+0x11/0x20
>    do_syscall_64+0x43/0x130
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7fcb78d43387
>   ---[ end trace 1c21a7c6c0523b8c ]---
> 
> [CAUSE]
> We're abusing local @root, it's originally a subvolume root, but in
> root backref search, it's re-assigned to tree_root.
> 
> Then we call "btrfs_put_root(root);" when exiting.
> If that @root is reassgined to tree-root, we freed the most important
> tree, and cause use-after-free.
> 
> [FIX]
> Don't re-assgiend @root, use fs_info->tree_root directly.
> 
> Reported-by: Marcos Paulo de Souza <mpdesouza@suse.de>
> Fixes: 8c319b625e0a ("btrfs: hold a ref on the root in
> btrfs_ioctl_get_subvol_info")
> [To David: please fold the fix into that commit]
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This patch fixed the issue, thanks Qu.

Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>

> ---
>  fs/btrfs/ioctl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index e6b7cf45a066..43195970f70c 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2696,17 +2696,16 @@ static int btrfs_ioctl_get_subvol_info(struct
> file *file, void __user *argp)
>  	subvol_info->rtime.nsec = btrfs_stack_timespec_nsec(&root_item-
> >rtime);
>  
>  	if (key.objectid != BTRFS_FS_TREE_OBJECTID) {
> -		/* Search root tree for ROOT_BACKREF of this subvolume
> */
> -		root = fs_info->tree_root;
> -
>  		key.type = BTRFS_ROOT_BACKREF_KEY;
>  		key.offset = 0;
> -		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +
> +		/* Search root tree for ROOT_BACKREF of this subvolume
> */
> +		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
> path, 0, 0);
>  		if (ret < 0) {
>  			goto out;
>  		} else if (path->slots[0] >=
>  			   btrfs_header_nritems(path->nodes[0])) {
> -			ret = btrfs_next_leaf(root, path);
> +			ret = btrfs_next_leaf(fs_info->tree_root,
> path);
>  			if (ret < 0) {
>  				goto out;
>  			} else if (ret > 0) {

