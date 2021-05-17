Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4B382C52
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 14:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhEQMiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 08:38:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237044AbhEQMiS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 08:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 896FEAED6;
        Mon, 17 May 2021 12:37:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D379DB228; Mon, 17 May 2021 14:34:29 +0200 (CEST)
Date:   Mon, 17 May 2021 14:34:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not BUG_ON(ret) in link_to_fixup_dir
Message-ID: <20210517123428.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <b181013f36147fa92801c0073fe307df44272f2f.1621004165.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b181013f36147fa92801c0073fe307df44272f2f.1621004165.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 10:56:16AM -0400, Josef Bacik wrote:
> While doing error injection testing I got the following panic
> 
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/tree-log.c:1862!
> invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 1 PID: 7836 Comm: mount Not tainted 5.13.0-rc1+ #305
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> RIP: 0010:link_to_fixup_dir+0xd5/0xe0
> RSP: 0018:ffffb5800180fa30 EFLAGS: 00010216
> RAX: fffffffffffffffb RBX: 00000000fffffffb RCX: ffff8f595287faf0
> RDX: ffffb5800180fa37 RSI: ffff8f5954978800 RDI: 0000000000000000
> RBP: ffff8f5953af9450 R08: 0000000000000019 R09: 0000000000000001
> R10: 000151f408682970 R11: 0000000120021001 R12: ffff8f5954978800
> R13: ffff8f595287faf0 R14: ffff8f5953c77dd0 R15: 0000000000000065
> FS:  00007fc5284c8c40(0000) GS:ffff8f59bbd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc5287f47c0 CR3: 000000011275e002 CR4: 0000000000370ee0
> Call Trace:
>  replay_one_buffer+0x409/0x470
>  ? btree_read_extent_buffer_pages+0xd0/0x110
>  walk_up_log_tree+0x157/0x1e0
>  walk_log_tree+0xa6/0x1d0
>  btrfs_recover_log_trees+0x1da/0x360
>  ? replay_one_extent+0x7b0/0x7b0
>  open_ctree+0x1486/0x1720
>  btrfs_mount_root.cold+0x12/0xea
>  ? __kmalloc_track_caller+0x12f/0x240
>  legacy_get_tree+0x24/0x40
>  vfs_get_tree+0x22/0xb0
>  vfs_kern_mount.part.0+0x71/0xb0
>  btrfs_mount+0x10d/0x380
>  ? vfs_parse_fs_string+0x4d/0x90
>  legacy_get_tree+0x24/0x40
>  vfs_get_tree+0x22/0xb0
>  path_mount+0x433/0xa10
>  __x64_sys_mount+0xe3/0x120
>  do_syscall_64+0x3d/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> We can get -EIO or any number of legitimate errors from
> btrfs_search_slot(), panicing here is not the appropriate response.  The
> error path for this code handles errors properly, simply return the
> error.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added do misc-next, thanks.
