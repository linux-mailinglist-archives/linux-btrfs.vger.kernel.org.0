Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8543AB98BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2019 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfITVBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Sep 2019 17:01:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43491 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbfITVBU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Sep 2019 17:01:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so8689072qke.10
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2019 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RnzsQjCkUTZrNu0vKLnt8TQbGayLK3W6189TBshe4ms=;
        b=yxu76GN4yyNZgjxW7exImYr9jhxVJl/ntYO0rdXxwrdYVhvdxg2WS52vzpk8Rzol3k
         7TJX1xJOcTSszfbg9cL+eowJyY0I9RN4kKCLoPtvRggqTaUZkD+g4Gt+X97w60UOIJR7
         XUSnwN9iOyNHRV3tLqUi9yItfdORUXeMFYduiCZbriEtEwVaOrd8cwoDpn6mKhGrAkSX
         v2RT3e/TE9GXkrauw5VdCJ0Wq+UX4ZIEh2X1cDNmHUWJZEKRlGdIRyNKyZbvgofP+9xD
         zR1KC8PbjUsIlOyTpwFMQxwuHq+MfGKzvKU00a3huobLOV90hCP0UK8O1sfShkERn8A6
         LA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnzsQjCkUTZrNu0vKLnt8TQbGayLK3W6189TBshe4ms=;
        b=alRt8UhU1PuVwpMOBwZ7yH1KMRuMvUNoZXsSMFaqA0Fh3TwKme5yvgmq8mCiLuzbea
         b/JV40+Nv0mAAPNYGwGcIjOJjjI+U1mgi2aeJF/dWmbQO9CHLhVhoJ4AOkWGxJWEk7sX
         nmw9KDWe97ZI6rRY+RQKiM+mWRQVmWl4cQUhXAEmqfCF3RXINgRpV1OuUUweL9byXQpQ
         yga6S/Tk4OgedJsIS9CHOt85FOSaizOnfr8ScekEDZVqEuGuPaUazG91mbhO070pQinx
         UfDWGoWpbaLz6plvOot5L6FpRE4HneC2OOiknXDGvmNiFNUNLnv2x1SeM7fEowhqmbJ5
         0swQ==
X-Gm-Message-State: APjAAAWUszUPChbp4KrJDvMIIog02mqNZ/26BpDTdwnuxAevHPJvFRGR
        faJoXaa53Bxgv+o47zqEoweVVA==
X-Google-Smtp-Source: APXvYqyqLQ3bTYOjr4LcsCdPrvEtqrpaJFGMoFizHAQfEw1Bv9n0HsR9gzcJkOllh/l1ddL1zOOiRQ==
X-Received: by 2002:a37:b41:: with SMTP id 62mr5769583qkl.451.1569013276843;
        Fri, 20 Sep 2019 14:01:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1a79])
        by smtp.gmail.com with ESMTPSA id 194sm1342717qkm.62.2019.09.20.14.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 14:01:15 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:01:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Cebtenzzre <cebtenzzre@gmail.com>
Subject: Re: [PATCH] btrfs: relocation: Fix KASAN report about use-after-free
 due to dead reloc tree cleanup race
Message-ID: <20190920210113.f4o5fxmfxewpb5lu@macbook-pro-91.dhcp.thefacebook.com>
References: <20190920024150.17911-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920024150.17911-1-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 20, 2019 at 10:41:50AM +0800, Qu Wenruo wrote:
> [BUG]
> One user reported a reproduciable KASAN report about use-after-free:
>   BTRFS info (device sdi1): balance: start -dvrange=1256811659264..1256811659265
>   BTRFS info (device sdi1): relocating block group 1256811659264 flags data|raid0
>   ==================================================================
>   BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>   Write of size 8 at addr ffff88856f671710 by task kworker/u24:10/261579
> 
>   CPU: 2 PID: 261579 Comm: kworker/u24:10 Tainted: P           OE     5.2.11-arch1-1-kasan #4
>   Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X99 Extreme4, BIOS P3.80 04/06/2018
>   Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
>   Call Trace:
>    dump_stack+0x7b/0xba
>    print_address_description+0x6c/0x22e
>    ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>    __kasan_report.cold+0x1b/0x3b
>    ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>    kasan_report+0x12/0x17
>    __asan_report_store8_noabort+0x17/0x20
>    btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>    record_root_in_trans+0x2a0/0x370 [btrfs]
>    btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
>    start_transaction+0x1ab/0xe90 [btrfs]
>    btrfs_join_transaction+0x1d/0x20 [btrfs]
>    btrfs_finish_ordered_io+0x7bf/0x18a0 [btrfs]
>    ? lock_repin_lock+0x400/0x400
>    ? __kmem_cache_shutdown.cold+0x140/0x1ad
>    ? btrfs_unlink_subvol+0x9b0/0x9b0 [btrfs]
>    finish_ordered_fn+0x15/0x20 [btrfs]
>    normal_work_helper+0x1bd/0xca0 [btrfs]
>    ? process_one_work+0x819/0x1720
>    ? kasan_check_read+0x11/0x20
>    btrfs_endio_write_helper+0x12/0x20 [btrfs]
>    process_one_work+0x8c9/0x1720
>    ? pwq_dec_nr_in_flight+0x2f0/0x2f0
>    ? worker_thread+0x1d9/0x1030
>    worker_thread+0x98/0x1030
>    kthread+0x2bb/0x3b0
>    ? process_one_work+0x1720/0x1720
>    ? kthread_park+0x120/0x120
>    ret_from_fork+0x35/0x40
> 
>   Allocated by task 369692:
>    __kasan_kmalloc.part.0+0x44/0xc0
>    __kasan_kmalloc.constprop.0+0xba/0xc0
>    kasan_kmalloc+0x9/0x10
>    kmem_cache_alloc_trace+0x138/0x260
>    btrfs_read_tree_root+0x92/0x360 [btrfs]
>    btrfs_read_fs_root+0x10/0xb0 [btrfs]
>    create_reloc_root+0x47d/0xa10 [btrfs]
>    btrfs_init_reloc_root+0x1e2/0x340 [btrfs]
>    record_root_in_trans+0x2a0/0x370 [btrfs]
>    btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
>    start_transaction+0x1ab/0xe90 [btrfs]
>    btrfs_start_transaction+0x1e/0x20 [btrfs]
>    __btrfs_prealloc_file_range+0x1c2/0xa00 [btrfs]
>    btrfs_prealloc_file_range+0x13/0x20 [btrfs]
>    prealloc_file_extent_cluster+0x29f/0x570 [btrfs]
>    relocate_file_extent_cluster+0x193/0xc30 [btrfs]
>    relocate_data_extent+0x1f8/0x490 [btrfs]
>    relocate_block_group+0x600/0x1060 [btrfs]
>    btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
>    btrfs_relocate_chunk+0x9e/0x180 [btrfs]
>    btrfs_balance+0x14e4/0x2fc0 [btrfs]
>    btrfs_ioctl_balance+0x47f/0x640 [btrfs]
>    btrfs_ioctl+0x119d/0x8380 [btrfs]
>    do_vfs_ioctl+0x9f5/0x1060
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x73/0xb0
>    do_syscall_64+0xa5/0x370
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>   Freed by task 369692:
>    __kasan_slab_free+0x14f/0x210
>    kasan_slab_free+0xe/0x10
>    kfree+0xd8/0x270
>    btrfs_drop_snapshot+0x154c/0x1eb0 [btrfs]
>    clean_dirty_subvols+0x227/0x340 [btrfs]
>    relocate_block_group+0x972/0x1060 [btrfs]
>    btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
>    btrfs_relocate_chunk+0x9e/0x180 [btrfs]
>    btrfs_balance+0x14e4/0x2fc0 [btrfs]
>    btrfs_ioctl_balance+0x47f/0x640 [btrfs]
>    btrfs_ioctl+0x119d/0x8380 [btrfs]
>    do_vfs_ioctl+0x9f5/0x1060
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x73/0xb0
>    do_syscall_64+0xa5/0x370
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>   The buggy address belongs to the object at ffff88856f671100
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 1552 bytes inside of
>    4096-byte region [ffff88856f671100, ffff88856f672100)
>   The buggy address belongs to the page:
>   page:ffffea0015bd9c00 refcount:1 mapcount:0 mapping:ffff88864400e600 index:0x0 compound_mapcount: 0
>   flags: 0x2ffff0000010200(slab|head)
>   raw: 02ffff0000010200 dead000000000100 dead000000000200 ffff88864400e600
>   raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
>   page dumped because: kasan: bad access detected
> 
>   Memory state around the buggy address:
>    ffff88856f671600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>    ffff88856f671680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   >ffff88856f671700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                            ^
>    ffff88856f671780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>    ffff88856f671800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ==================================================================
>   BTRFS info (device sdi1): 1 enospc errors during balance
>   BTRFS info (device sdi1): balance: ended with status: -28
> 
> [CAUSE]
> The problem happens when finish_ordered_io() get called with balance
> still running, while the reloc root of that subvolume is already dead.
> (tree swap already done, but tree not yet deleted for possible qgroup
> usage)
> 
> That means root->reloc_root still exists, but that reloc_root can be
> under btrfs_drop_snapshot(), thus we shouldn't access it.
> 
> The following race could cause the use-after-free problem:
> 
>                 CPU1              |                CPU2
> --------------------------------------------------------------------------
>                                   | relocate_block_group()
>                                   | |- unset_reloc_control(rc)
>                                   | |- btrfs_commit_transaction()
> btrfs_finish_ordered_io()         | |- clean_dirty_subvols()
> |- btrfs_join_transaction()       |    |
>    |- record_root_in_trans()      |    |
>       |- btrfs_init_reloc_root()  |    |
>          |- if (root->reloc_root) |    |
>          |                        |    |- root->reloc_root = NULL
>          |                        |    |- btrfs_drop_snapshot(reloc_root);
>          |- reloc_root->last_trans|
>                  = trans->transid |
> 	    ^^^^^^^^^^^^^^^^^^^^^^
>             Use after free
> 
> It looks like the race window is pretty small so that it's not that easy
> to trigger without the extra validation overhead introduced by KASAN.
> 
> [FIX]
> Fix it by the following modifications:
> - Test if the root has dead reloc tree before accessing root->reloc_root
>   If the root has BTRFS_ROOT_DEAD_RELOC_TREE, then we don't need to
>   create or update root->reloc_tree
> 
> - Clear the BTRFS_ROOT_DEAD_RELOC_TREE flag until we have fully dropped
>   reloc tree
>   To co-operate with above modification, so as long as
>   BTRFS_ROOT_DEAD_RELOC_TREE is still set, we won't try to re-create
>   reloc tree at record_root_in_trans().
> 
> Reported-by: Cebtenzzre <cebtenzzre@gmail.com>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 7f219851fa23..d60993a8b2ae 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1434,16 +1434,19 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
>  	int clear_rsv = 0;
>  	int ret;
>  
> -	if (root->reloc_root) {
> +	if (!test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) &&
> +	    root->reloc_root) {
>  		reloc_root = root->reloc_root;
>  		reloc_root->last_trans = trans->transid;
>  		return 0;
>  	}
>  
>  	if (!rc || !rc->create_reloc_tree ||
> -	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
> +	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
> +	    test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>  		return 0;

Just move this bit above the root->reloc_root check, and drop the extra test_bit
in the above check.

>  
> +

Random newline.  The rest seems fine.  Thanks,

Josef
