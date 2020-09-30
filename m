Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E321127F368
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgI3Uif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:38:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:39816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Uif (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:38:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D79DB2CD;
        Wed, 30 Sep 2020 20:38:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AAD2DA781; Wed, 30 Sep 2020 22:37:13 +0200 (CEST)
Date:   Wed, 30 Sep 2020 22:37:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: cleanup cow block on error
Message-ID: <20200930203712.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 08:53:54AM -0400, Josef Bacik wrote:
> With my automated fstest runs I noticed one of my workers didn't report
> results.  Turns out it was hung trying to write back inodes, and the
> write back thread was stuck trying to lock an extent buffer

Which test was that?

> [root@xfstests2 xfstests-dev]# cat /proc/2143497/stack
> [<0>] __btrfs_tree_lock+0x108/0x250
> [<0>] lock_extent_buffer_for_io+0x35e/0x3a0
> [<0>] btree_write_cache_pages+0x15a/0x3b0
> [<0>] do_writepages+0x28/0xb0
> [<0>] __writeback_single_inode+0x54/0x5c0
> [<0>] writeback_sb_inodes+0x1e8/0x510
> [<0>] wb_writeback+0xcc/0x440
> [<0>] wb_workfn+0xd7/0x650
> [<0>] process_one_work+0x236/0x560
> [<0>] worker_thread+0x55/0x3c0
> [<0>] kthread+0x13a/0x150
> [<0>] ret_from_fork+0x1f/0x30
> 
> This is because we got an error while cow'ing a block, specifically here
> 
>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
>                 ret = btrfs_reloc_cow_block(trans, root, buf, cow);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
>                         return ret;
>                 }
>         }
> 
> The problem here is that as soon as we allocate the new block it is
> locked and marked dirty in the btree inode.  This means that we could
> attempt to writeback this block and need to lock the extent buffer.
> However we're not unlocking it here and thus we deadlock.
> 
> Fix this by unlocking the cow block if we have any errors inside of
> __btrfs_cow_block, and also free it so we do not leak it.
> 
> Fixes: 65b51a009e29 ("btrfs_search_slot: reduce lock contention by cowing in two stages")

This is a commit from 2008, though it has some overlap with the fixed
code, there have been many changes meanwhile and I don't see a clear
logic that would point to that. The functions with missing free after
failure are nowhere in that commit.

The patch is applicable to all the stable trees so that's not a problem,
but the Fixes: tag should be a close match, though it's not always easy
and in this case I'd rather leave it out.
