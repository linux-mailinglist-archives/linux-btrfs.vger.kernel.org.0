Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5057240B92
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHJREW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 13:04:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:40160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgHJREV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 13:04:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9AFDBAE8C;
        Mon, 10 Aug 2020 17:04:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7ADE3DA7D5; Mon, 10 Aug 2020 19:02:55 +0200 (CEST)
Date:   Mon, 10 Aug 2020 19:02:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: fix NULL pointer dereference at
 btrfs_sysfs_del_qgroups()
Message-ID: <20200810170255.GF2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200803062011.17291-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803062011.17291-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 03, 2020 at 02:20:11PM +0800, Qu Wenruo wrote:
> [BUG]
> With next-20200731 tag (079ad2fb4bf9eba8a0aaab014b49705cd7f07c66),

I don't think linux-next commit ids are useful, even the tags get
removed after a month so the exact commit causing the crash is what we
want.

> unmounting a btrfs with quota disabled will cause the following NULL
> pointer dereference:
> 
>   BTRFS info (device dm-5): has skinny extents
>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   CPU: 7 PID: 637 Comm: umount Not tainted 5.8.0-rc7-next-20200731-custom #76
>   RIP: 0010:kobject_del+0x6/0x20
>   Call Trace:
>    btrfs_sysfs_del_qgroups+0xac/0xf0 [btrfs]
>    btrfs_free_qgroup_config+0x63/0x70 [btrfs]
>    close_ctree+0x1f5/0x323 [btrfs]
>    btrfs_put_super+0x15/0x17 [btrfs]
>    generic_shutdown_super+0x72/0x110
>    kill_anon_super+0x18/0x30
>    btrfs_kill_super+0x17/0x30 [btrfs]
>    deactivate_locked_super+0x3b/0xa0
>    deactivate_super+0x40/0x50
>    cleanup_mnt+0x135/0x190
>    __cleanup_mnt+0x12/0x20
>    task_work_run+0x64/0xb0
>    exit_to_user_mode_prepare+0x18a/0x190
>    syscall_exit_to_user_mode+0x4f/0x270
>    do_syscall_64+0x45/0x50
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ---[ end trace 37b7adca5c1d5c5d ]---
> 
> [CAUSE]
> Commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
> kobject_cleanup()") changed kobject_del() that it no longer accepts NULL
> pointer.

That commit reference should be sufficient.

> Before that commit, kobject_del() and kobject_put() all accept NULL
> pointers and just ignore such NULL pointers.
> 
> But that mentioned commit needs to access the parent node, killing the
> old NULL pointer behavior.
> 
> Unfortunately btrfs is relying on that hidden feature thus we will
> trigger such NULL pointer dereference.
> 
> [FIX]
> Instead of just saving several lines, do proper fs_info->qgroups_kobj
> check before calling kobject_del() and kobject_put().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
