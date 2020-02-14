Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35C215D8A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgBNNib (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 08:38:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:55922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgBNNib (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 08:38:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14BE8AB95;
        Fri, 14 Feb 2020 13:38:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80EC8DA703; Fri, 14 Feb 2020 14:38:15 +0100 (CET)
Date:   Fri, 14 Feb 2020 14:38:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.de>
Subject: Re: [PATCH] btrfs: Don't free tree_root when exiting
 btrfs_ioctl_get_subvol_info()
Message-ID: <20200214133815.GU2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.de>
References: <20200213130157.39230-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213130157.39230-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 13, 2020 at 09:01:57PM +0800, Qu Wenruo wrote:
> [BUG]
> When calling BTRF_IOC_GET_SUBVOL_INFO ioctl, we can easily hit the
> following backtrace:
>   BUG: kernel NULL pointer dereference, address: 0000000000000024
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP PTI
>   CPU: 0 PID: 27421 Comm: python3 Not tainted 5.6.0-rc1+ #539
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
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
> Fixes: 8c319b625e0a ("btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info")
> [To David: please fold the fix into that commit]

Folded, thanks for the report and fix.
