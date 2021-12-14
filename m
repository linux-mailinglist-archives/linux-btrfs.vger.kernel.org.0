Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01D474C47
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 20:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhLNTuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 14 Dec 2021 14:50:39 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:42154 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234594AbhLNTui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 14:50:38 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 84C63E1130; Tue, 14 Dec 2021 14:50:37 -0500 (EST)
Date:   Tue, 14 Dec 2021 14:50:37 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10
 vfs: verify source area in vfs_dedupe_file_range_one()
Message-ID: <Ybj1jVYu3MrUzVTD@hungrycats.org>
References: <20211210183456.GP17148@hungrycats.org>
 <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
 <YbfTYFQVGCU0Whce@hungrycats.org>
 <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 01:11:24PM +0200, Nikolay Borisov wrote:
> 
> 
> On 14.12.21 г. 1:12, Zygo Blaxell wrote:
> > On Mon, Dec 13, 2021 at 03:28:26PM +0200, Nikolay Borisov wrote:
> >> On 10.12.21 г. 20:34, Zygo Blaxell wrote:
> >>> I've been getting deadlocks in dedupe on btrfs since kernel 5.11, and
> >>> some bees users have reported it as well.  I bisected to this commit:
> >>>
> >>> 	3078d85c9a10 vfs: verify source area in vfs_dedupe_file_range_one()
> >>>
> >>> These kernels work for at least 18 hours:
> >>>
> >>> 	5.10.83 (months)
> >>> 	5.11.22 with 3078d85c9a10 reverted (36 hours)
> >>> 	btrfs misc-next 66dc4de326b0 with 3078d85c9a10 reverted
> >>>
> >>> These kernels lock up in 3 hours or less:
> >>>
> >>> 	5.11.22
> >>> 	5.12.19
> >>> 	5.14.21
> >>> 	5.15.6
> >>> 	btrfs for-next 279373dee83e
> >>>
> >>> All of the failing kernels include this commit, none of the non-failing
> >>> kernels include the commit.
> >>>
> >>> Kernel logs from the lockup:
> >>>
> >>> 	[19647.696042][ T3721] sysrq: Show Blocked State
> >>> 	[19647.697024][ T3721] task:btrfs-transacti state:D stack:    0 pid: 6161 ppid:     2 flags:0x00004000
> >>> 	[19647.698203][ T3721] Call Trace:
> >>> 	[19647.698608][ T3721]  __schedule+0x388/0xaf0
> >>> 	[19647.699125][ T3721]  schedule+0x68/0xe0
> >>> 	[19647.699615][ T3721]  btrfs_commit_transaction+0x97c/0xbf0
> >>
> >> Can you run this through symbolize script as I'd like to understand
> >> where in transaction commit the sleep is happening. 
> > 
> > 	btrfs_commit_transaction+0x97c/0xbf0:
> > 
> > 	btrfs_commit_transaction at fs/btrfs/transaction.c:2159 (discriminator 9)
> > 	 2154
> > 	 2155           ret = btrfs_run_delayed_items(trans);
> > 	 2156           if (ret)
> > 	 2157                   goto cleanup_transaction;
> > 	 2158
> > 	>2159<          wait_event(cur_trans->writer_wait,
> > 	 2160                      extwriter_counter_read(cur_trans) == 0);
> > 	 2161
> > 	 2162           /* some pending stuffs might be added after the previous flush. */
> > 	 2163           ret = btrfs_run_delayed_items(trans);
> > 	 2164           if (ret)
> > 
> 
> So it seems there is an open transaction handle thus commit can't
> continue and everything is stalled behind. Would you be able to run the
> attached python script on a host which is stuck. It requires you having
> debug symbols for the kernel installed as well as
> https://github.com/osandov/drgn/ which is a scriptable debugger. The
> easiest way would to follow the instructions at
> https://drgn.readthedocs.io/en/latest/installation.html and just get it
> via pip.
> 
> 
> Once you have it installed run it by doing:
> 
> "sudo drgn get-num-extwriters.py 310dd372-0fd1-4496-a232-0fb46ca4afd6"
> 
> Where 310dd372-0fd1-4496-a232-0fb46ca4afd6 is the fsid as taken from
> 'blkid' which corresponds to the wedged fs.

[drum roll noises...]

	[f79c1081-d81d-4abc-8b47-3b15bf2f93c5] num_extwriters is: 1

> <snip>

> #!/bin/python3
> 
> import uuid, sys
> from drgn.helpers.linux import list_for_each_entry
> 
> if len(sys.argv) != 2:
>     print("Run with 'sudo drgn {} UUID'".format(sys.argv[0]))
>     exit()
> 
> fsid = sys.argv[1]
> found = False
> 
> btrfs_fs = prog['fs_uuids']
> for fs in list_for_each_entry("struct btrfs_fs_devices", btrfs_fs.address_of_(), "fs_list"):
>     current_fsid = uuid.UUID(bytes=fs.fsid.string_())
>     user_fsid = uuid.UUID(fsid)
>     if current_fsid.int == user_fsid.int:
>         transaction = fs.fs_info.running_transaction
>         found = True
>         print("[{}] num_extwriters is: {}".format(fsid, transaction.num_extwriters.value_()["counter"]));
> 
> if found == False:
>     print("Couldn't find matching UUID belonging to a BTRFS filesystem")

