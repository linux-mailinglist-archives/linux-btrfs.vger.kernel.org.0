Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1BB1F7C72
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 19:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFLRYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 13:24:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLRYV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 13:24:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B91E8AF01;
        Fri, 12 Jun 2020 17:24:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C66A9DA7C3; Fri, 12 Jun 2020 19:24:13 +0200 (CEST)
Date:   Fri, 12 Jun 2020 19:24:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
Subject: Re: [PATCH] btrfs: Share the same anonymous block device for the
 whole filesystem
Message-ID: <20200612172413.GX27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200612064237.13439-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612064237.13439-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 12, 2020 at 02:42:37PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report about transaction abort due to -EMFILE error.
> 
>   ------------[ cut here ]------------
>   BTRFS: Transaction aborted (error -24)
>   WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10 [btrfs]
>   RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
>   Call Trace:
>    create_pending_snapshots+0x82/0xa0 [btrfs]
>    btrfs_commit_transaction+0x275/0x8c0 [btrfs]
>    btrfs_mksubvol+0x4b9/0x500 [btrfs]
>    btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
>    btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
>    btrfs_ioctl+0x11a4/0x2da0 [btrfs]
>    do_vfs_ioctl+0xa9/0x640
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x1a/0x20
>    do_syscall_64+0x5a/0x110
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ---[ end trace 33f2f83f3d5250e9 ]---
>   BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=-24 unknown
>   BTRFS info (device sda1): forced readonly
>   BTRFS warning (device sda1): Skipping commit of aborted transaction.
>   BTRFS: error (device sda1) in cleanup_transaction:1831: errno=-24 unknown
> 
> The workload involves creating and deleting a lot of snapshots in a
> short period.

The ids get returned to the IDA range once the last reference to the
root object is reached, but there's no distinction between a regular
subvolume and a deleted one.

I think we could call free_anon_bdev once the subvolume is deleted in
btrfs_delete_subvolume and not wait until it gets processed by
btrfs_clean_one_deleted_snapshot . This should be save, as once the
subvolume disappears from the file hierarchy, the bdev cannot be queried
by users.
