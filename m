Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259032C349
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfE1JaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 05:30:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfE1JaX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 05:30:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2EC5B021;
        Tue, 28 May 2019 09:30:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9F6FDA85E; Tue, 28 May 2019 11:31:17 +0200 (CEST)
Date:   Tue, 28 May 2019 11:31:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Juan Erbes <jerbes@gmail.com>
Subject: Re: [PATCH v1.1] btrfs: qgroup: Check if @bg is NULL to avoid NULL
 pointer dereference
Message-ID: <20190528093117.GQ15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Juan Erbes <jerbes@gmail.com>
References: <20190521112808.28728-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521112808.28728-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21, 2019 at 07:28:08PM +0800, Qu Wenruo wrote:
> [BUG]
> When mounting a fs with reloc tree and has qgroup enabled, it can cause
> NULL pointer dereference at mount time:
>   BUG: kernel NULL pointer dereference, address: 00000000000000a8
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   RIP: 0010:btrfs_qgroup_add_swapped_blocks+0x186/0x300 [btrfs]
>   Call Trace:
>    replace_path.isra.23+0x685/0x900 [btrfs]
>    merge_reloc_root+0x26e/0x5f0 [btrfs]
>    merge_reloc_roots+0x10a/0x1a0 [btrfs]
>    btrfs_recover_relocation+0x3cd/0x420 [btrfs]
>    open_ctree+0x1bc8/0x1ed0 [btrfs]
>    btrfs_mount_root+0x544/0x680 [btrfs]
>    legacy_get_tree+0x34/0x60
>    vfs_get_tree+0x2d/0xf0
>    fc_mount+0x12/0x40
>    vfs_kern_mount.part.12+0x61/0xa0
>    vfs_kern_mount+0x13/0x20
>    btrfs_mount+0x16f/0x860 [btrfs]
>    legacy_get_tree+0x34/0x60
>    vfs_get_tree+0x2d/0xf0
>    do_mount+0x81f/0xac0
>    ksys_mount+0xbf/0xe0
>    __x64_sys_mount+0x25/0x30
>    do_syscall_64+0x65/0x240
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [CAUSE]
> In btrfs_recover_relocation(), we don't have enough info to determine
> which block group we're relocating, but only to merge existing reloc
> trees.
> 
> Thus in btrfs_recover_relocation(), rc->block_group is NULL.
> btrfs_qgroup_add_swapped_blocks() hasn't take this into consideration,
> and causes NULL pointer dereference.
> 
> The bug is introduced by commit 3d0174f78e72 ("btrfs: qgroup: Only trace
> data extents in leaves if we're relocating data block group"), and
> later qgroup refactor still keeps this optimization.
> 
> [FIX]
> Thankfully in the context of btrfs_recover_relocation(), there is no
> other progress can modify tree blocks, thus those swapped tree blocks
> pair will never affect qgroup numbers, no matter whatever we set for
> block->trace_leaf.
> 
> So we only need to check if @bg is NULL before accessing @bg->flags.
> 
> Reported-by: Juan Erbes <jerbes@gmail.com>
> Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1134806
> Fixes: 3d0174f78e72 ("btrfs: qgroup: Only trace data extents in leaves if we're relocating data block group")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I've changed the subject to "btrfs: qgroup: Check bg while resuming
relocation to avoid NULL pointer dereference", patch is going to 5.2-rc
and will be tagged for stable.
