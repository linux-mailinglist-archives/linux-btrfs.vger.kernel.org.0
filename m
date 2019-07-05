Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D9C602E8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfGEJJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 05:09:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:51782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfGEJJg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 05:09:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78346AE89;
        Fri,  5 Jul 2019 09:09:34 +0000 (UTC)
Subject: Re: [PATCH 1/5] Btrfs: fix hang when loading existing inode cache off
 disk
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190704152409.20665-1-fdmanana@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <324ad8e5-c6f6-f31f-c7b4-8673326d076b@suse.com>
Date:   Fri, 5 Jul 2019 12:09:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704152409.20665-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.07.19 г. 18:24 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we are able to load an existing inode cache off disk, we set the state
> of the cache to BTRFS_CACHE_FINISHED, but we don't wake up any one waiting
> for the cache to be available. This means that anyone waiting for the
> cache to be available, waiting on the condition that either its state is
> BTRFS_CACHE_FINISHED or its available free space is greather than zero,
> can hang forever.
> 
> This could be observed running fstests with MOUNT_OPTIONS="-o inode_cache",
> in particular test case generic/161 triggered it very frequently for me,
> producing a trace like the following:
> 
>   [63795.739712] BTRFS info (device sdc): enabling inode map caching
>   [63795.739714] BTRFS info (device sdc): disk space caching is enabled
>   [63795.739716] BTRFS info (device sdc): has skinny extents
>   [64036.653886] INFO: task btrfs-transacti:3917 blocked for more than 120 seconds.
>   [64036.654079]       Not tainted 5.2.0-rc4-btrfs-next-50 #1
>   [64036.654143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   [64036.654232] btrfs-transacti D    0  3917      2 0x80004000
>   [64036.654239] Call Trace:
>   [64036.654258]  ? __schedule+0x3ae/0x7b0
>   [64036.654271]  schedule+0x3a/0xb0
>   [64036.654325]  btrfs_commit_transaction+0x978/0xae0 [btrfs]
>   [64036.654339]  ? remove_wait_queue+0x60/0x60
>   [64036.654395]  transaction_kthread+0x146/0x180 [btrfs]
>   [64036.654450]  ? btrfs_cleanup_transaction+0x620/0x620 [btrfs]
>   [64036.654456]  kthread+0x103/0x140
>   [64036.654464]  ? kthread_create_worker_on_cpu+0x70/0x70
>   [64036.654476]  ret_from_fork+0x3a/0x50
>   [64036.654504] INFO: task xfs_io:3919 blocked for more than 120 seconds.
>   [64036.654568]       Not tainted 5.2.0-rc4-btrfs-next-50 #1
>   [64036.654617] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   [64036.654685] xfs_io          D    0  3919   3633 0x00000000
>   [64036.654691] Call Trace:
>   [64036.654703]  ? __schedule+0x3ae/0x7b0
>   [64036.654716]  schedule+0x3a/0xb0
>   [64036.654756]  btrfs_find_free_ino+0xa9/0x120 [btrfs]
>   [64036.654764]  ? remove_wait_queue+0x60/0x60
>   [64036.654809]  btrfs_create+0x72/0x1f0 [btrfs]
>   [64036.654822]  lookup_open+0x6bc/0x790
>   [64036.654849]  path_openat+0x3bc/0xc00
>   [64036.654854]  ? __lock_acquire+0x331/0x1cb0
>   [64036.654869]  do_filp_open+0x99/0x110
>   [64036.654884]  ? __alloc_fd+0xee/0x200
>   [64036.654895]  ? do_raw_spin_unlock+0x49/0xc0
>   [64036.654909]  ? do_sys_open+0x132/0x220
>   [64036.654913]  do_sys_open+0x132/0x220
>   [64036.654926]  do_syscall_64+0x60/0x1d0
>   [64036.654933]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Fix this by adding a wake_up() call right after setting the cache state to
> BTRFS_CACHE_FINISHED, at start_caching(), when we are able to load the
> cache from disk.
> 
> Fixes: 82d5902d9c681b ("Btrfs: Support reading/writing on disk free ino cache")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/inode-map.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
> index ffca2abf13d0..4a5882665f8a 100644
> --- a/fs/btrfs/inode-map.c
> +++ b/fs/btrfs/inode-map.c
> @@ -145,6 +145,7 @@ static void start_caching(struct btrfs_root *root)
>  		spin_lock(&root->ino_cache_lock);
>  		root->ino_cache_state = BTRFS_CACHE_FINISHED;
>  		spin_unlock(&root->ino_cache_lock);
> +		wake_up(&root->ino_cache_wait);

One of the two callers of start_caching doesn't actually wait for the
cache to load - btrfs_return_ino. Is this expected or is it also a bug?

The presence of such a glaring omission of the wake up means this code
hasn't been tested much.

>  		return;
>  	}
>  
> 
