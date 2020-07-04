Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0ED2148F5
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jul 2020 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGDVpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jul 2020 17:45:41 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.155]:15387 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgGDVpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Jul 2020 17:45:41 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id B828E4038C599
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Jul 2020 16:45:38 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id rpycjyofyzOaurpycj6Rrq; Sat, 04 Jul 2020 16:45:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yGM/hFRvjYyRzcfWKpW4s6ezoC1xA5b2b3W3UCBGLx4=; b=CNBRU3A7x5AeaVgDFi8x7XAQvQ
        GL/lNGOy6kv/goV7TgNjLuMJh7o2YX5L6jSBGSay0SfFa1r++9D4VVbK5m7d10+zOsoOmOZYqFhSv
        4HnTJrgI/wEvANJg4Cd7Iz67wiJmY5uS21Mm2sJSpfnTZvkbqr68iObPwluSXky3YJdX3yWxfHf8v
        rXkjXGDdU6+r0Q1XXOr00eoR8lOVxnZOisJPzFiIpGy7WGa/9v7S0AgRGsuyY2grc39NcrXqmB0PY
        RTj9rD6sxzcYq87rPTeR3C9Dqbqm8PceoxcSQktanpHDBpqqCkIeaYiLRkOtqUJx1T7+KSZTCJsfh
        Vv7L6x3Q==;
Received: from 200.146.49.70.dynamic.dialup.gvt.net.br ([200.146.49.70]:56990 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jrpyc-000uis-7z; Sat, 04 Jul 2020 18:45:38 -0300
Message-ID: <cd672e2150871f9b495400ba2beea7d864da0265.camel@mpdesouza.com>
Subject: Re: [PATCH] btrfs: discard: reduce the block group ref when
 grabbing from unused block group list
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Date:   Sat, 04 Jul 2020 18:45:34 -0300
In-Reply-To: <20200703070550.39299-1-wqu@suse.com>
References: <20200703070550.39299-1-wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.49.70
X-Source-L: No
X-Exim-ID: 1jrpyc-000uis-7z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.49.70.dynamic.dialup.gvt.net.br ([192.168.0.172]) [200.146.49.70]:56990
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 1
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-07-03 at 15:05 +0800, Qu Wenruo wrote:
> [BUG]
> The following small test script can trigger ASSERT() at unmount time:
> 
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   mount -o remount,discard=async $mnt
>   umount $mnt
> 
> The call trace:
>   assertion failed: atomic_read(&block_group->count) == 1, in
> fs/btrfs/block-group.c:3431
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/ctree.h:3204!
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 4 PID: 10389 Comm: umount Tainted: G           O      5.8.0-
> rc3-custom+ #68
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0
> 02/06/2015
>   Call Trace:
>    btrfs_free_block_groups.cold+0x22/0x55 [btrfs]
>    close_ctree+0x2cb/0x323 [btrfs]
>    btrfs_put_super+0x15/0x17 [btrfs]
>    generic_shutdown_super+0x72/0x110
>    kill_anon_super+0x18/0x30
>    btrfs_kill_super+0x17/0x30 [btrfs]
>    deactivate_locked_super+0x3b/0xa0
>    deactivate_super+0x40/0x50
>    cleanup_mnt+0x135/0x190
>    __cleanup_mnt+0x12/0x20
>    task_work_run+0x64/0xb0
>    __prepare_exit_to_usermode+0x1bc/0x1c0
>    __syscall_return_slowpath+0x47/0x230
>    do_syscall_64+0x64/0xb0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The code:
>                 ASSERT(atomic_read(&block_group->count) == 1);
>                 btrfs_put_block_group(block_group);
> 
> [CAUSE]
> Obviously it's some btrfs_get_block_group() call doesn't get its put
> call.
> 
> The offending btrfs_get_block_group() happens here:
> 
>   void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>   {
>   	if (list_empty(&bg->bg_list)) {
>   		btrfs_get_block_group(bg);
> 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
>   	}
>   }
> 
> So every call sites removing the block group from unused_bgs list
> should
> reduce the ref count of that block group.
> 
> However for async discard, it didn't follow the call convention:
> 
>   void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info
> *fs_info)
>   {
>   	list_for_each_entry_safe(block_group, next, &fs_info-
> >unused_bgs,
>   				 bg_list) {
>   		list_del_init(&block_group->bg_list);
>   		btrfs_discard_queue_work(&fs_info->discard_ctl,
> block_group);
>   	}
>   }
> 
> And in btrfs_discard_queue_work(), it doesn't call
> btrfs_put_block_group() either.
> 
> [FIX]
> Fix the problem by reducing the reference count when we grab the
> block
> group from unused_bgs list.

xfstests is happy about the change.

Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>

> 
> Reported-by: Marcos Paulo de Souza <marcos@mpdesouza.com>
> Fixes: 6e80d4f8c422 ("btrfs: handle empty block_group removal for
> async discard")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/discard.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 5615320fa659..741c7e19c32f 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -619,6 +619,7 @@ void btrfs_discard_punt_unused_bgs_list(struct
> btrfs_fs_info *fs_info)
>  	list_for_each_entry_safe(block_group, next, &fs_info-
> >unused_bgs,
>  				 bg_list) {
>  		list_del_init(&block_group->bg_list);
> +		btrfs_put_block_group(block_group);
>  		btrfs_discard_queue_work(&fs_info->discard_ctl,
> block_group);
>  	}
>  	spin_unlock(&fs_info->unused_bgs_lock);

