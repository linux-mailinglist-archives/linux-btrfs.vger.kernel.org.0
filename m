Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B211345D0
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 16:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgAHPI4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 10:08:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:60356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbgAHPIz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 10:08:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B1F93AE35;
        Wed,  8 Jan 2020 15:08:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D89DDA791; Wed,  8 Jan 2020 16:08:42 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:08:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
Message-ID: <20200108150841.GH3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 08, 2020 at 05:03:35PM +0200, Nikolay Borisov wrote:
> 
> 
> On 8.01.20 г. 16:55 ч., Josef Bacik wrote:
> > On 1/8/20 12:12 AM, Qu Wenruo wrote:
> >> [BUG]
> >> There are several different KASAN reports for balance + snapshot
> >> workloads.
> >> Involved call paths include:
> >>
> >>     should_ignore_root+0x54/0xb0 [btrfs]
> >>     build_backref_tree+0x11af/0x2280 [btrfs]
> >>     relocate_tree_blocks+0x391/0xb80 [btrfs]
> >>     relocate_block_group+0x3e5/0xa00 [btrfs]
> >>     btrfs_relocate_block_group+0x240/0x4d0 [btrfs]
> >>     btrfs_relocate_chunk+0x53/0xf0 [btrfs]
> >>     btrfs_balance+0xc91/0x1840 [btrfs]
> >>     btrfs_ioctl_balance+0x416/0x4e0 [btrfs]
> >>     btrfs_ioctl+0x8af/0x3e60 [btrfs]
> >>     do_vfs_ioctl+0x831/0xb10
> >>     ksys_ioctl+0x67/0x90
> >>     __x64_sys_ioctl+0x43/0x50
> >>     do_syscall_64+0x79/0xe0
> >>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>
> >>     create_reloc_root+0x9f/0x460 [btrfs]
> >>     btrfs_reloc_post_snapshot+0xff/0x6c0 [btrfs]
> >>     create_pending_snapshot+0xa9b/0x15f0 [btrfs]
> >>     create_pending_snapshots+0x111/0x140 [btrfs]
> >>     btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
> >>     btrfs_mksubvol+0x915/0x960 [btrfs]
> >>     btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
> >>     btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
> >>     btrfs_ioctl+0x241b/0x3e60 [btrfs]
> >>     do_vfs_ioctl+0x831/0xb10
> >>     ksys_ioctl+0x67/0x90
> >>     __x64_sys_ioctl+0x43/0x50
> >>     do_syscall_64+0x79/0xe0
> >>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>
> >>     btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
> >>     create_pending_snapshot+0x209/0x15f0 [btrfs]
> >>     create_pending_snapshots+0x111/0x140 [btrfs]
> >>     btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
> >>     btrfs_mksubvol+0x915/0x960 [btrfs]
> >>     btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
> >>     btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
> >>     btrfs_ioctl+0x241b/0x3e60 [btrfs]
> >>     do_vfs_ioctl+0x831/0xb10
> >>     ksys_ioctl+0x67/0x90
> >>     __x64_sys_ioctl+0x43/0x50
> >>     do_syscall_64+0x79/0xe0
> >>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>
> >> [CAUSE]
> >> All these call sites are only relying on root->reloc_root, which can
> >> undergo btrfs_drop_snapshot(), and since we don't have real refcount
> >> based protection to reloc roots, we can reach already dropped reloc
> >> root, triggering KASAN.
> >>
> >> [FIX]
> >> To avoid such access to unstable root->reloc_root, we should check
> >> BTRFS_ROOT_DEAD_RELOC_TREE bit first.
> >>
> >> This patch introduces a new wrapper, have_reloc_root(), to do the proper
> >> check for most callers who don't distinguish merged reloc tree and no
> >> reloc tree.
> >>
> >> The only exception is should_ignore_root(), as merged reloc tree can be
> >> ignored, while no reloc tree shouldn't.
> >>
> >> [CRITICAL SECTION ANALYSE]
> >> Although test_bit()/set_bit()/clear_bit() doesn't imply a barrier, the
> >> DEAD_RELOC_TREE bit has extra help from transaction as a higher level
> >> barrier, the lifespan of root::reloc_root and DEAD_RELOC_TREE bit are:
> >>
> >>     NULL: reloc_root is NULL    PTR: reloc_root is not NULL
> >>     0: DEAD_RELOC_ROOT bit not set    DEAD: DEAD_RELOC_ROOT bit set
> >>
> >>     (NULL, 0)    Initial state         __
> >>       |                     /\ Section A
> >>          btrfs_init_reloc_root()             \/
> >>       |                      __
> >>     (PTR, 0)     reloc_root initialized      /\
> >>            |                     |
> >>     btrfs_update_reloc_root()         |  Section B
> >>            |                     |
> >>     (PTR, DEAD)  reloc_root has been merged  \/
> >>            |                     __
> >>     === btrfs_commit_transaction() ====================
> >>       |                     /\
> >>     clean_dirty_subvols()             |
> >>       |                     |  Section C
> >>     (NULL, DEAD) reloc_root cleanup starts   \/
> >>            |                     __
> >>     btrfs_drop_snapshot()             /\
> >>       |                     |  Section D
> >>     (NULL, 0)    Back to initial state     \/
> >>
> >> Very have_reloc_root() or test_bit(DEAD_RELOC_ROOT) caller has hold a
> >> transaction handler, so none of such caller can cross transaction
> >> boundary.
> >>
> >> In Section A, every caller just found no DEAD bit, and grab reloc_root.
> >>
> >> In the cross section A-B, caller may get no DEAD bit, but since
> >> reloc_root is still completely valid thus accessing reloc_root is
> >> completely safe.
> >>
> >> No test_bit() caller can cross the boundary of Section B and Section C.
> >>
> >> In Section C, every caller found the DEAD bit, so no one will access
> >> reloc_root.
> >>
> >> In the cross section C-D, either caller gets the DEAD bit set, avoiding
> >> access reloc_root no matter if it's safe or not.
> >> Or caller get the DEAD bit cleared, then access reloc_root, which is
> >> already NULL, nothing will be wrong.
> >>
> >> Here we need extra memory barrier in cross section C-D, to ensure
> >> proper memory order between reloc_root and clear_bit().
> >>
> >> In Section D, since no DEAD bit and no reloc_root, it's back to initial
> >> state.
> >>
> >> With this lifespan, it should be clear only one memory barrier is
> >> needed, between setting reloc_root to NULL and clearing DEAD_RELOC_ROOT
> >> bit.
> >>
> >> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> >> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion
> >> after merge_reloc_roots")
> >> Suggested-by: David Sterba <dsterba@suse.com>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Add the [CRITICAL SECTION ANALYSE] part
> >>    This gets me into the rabbit hole of memory ordering, but thanks for
> >>    the help from David (initially mentioning the mb hell) and Nikolay
> >>    (for the proper doc), finally I could explain clearly why only
> >>    one mb is needed.
> >> - Add comment for the only needed memory barrier.
> >> ---
> >>   fs/btrfs/relocation.c | 32 ++++++++++++++++++++++++++++----
> >>   1 file changed, 28 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> >> index d897a8e5e430..17a2484f76a5 100644
> >> --- a/fs/btrfs/relocation.c
> >> +++ b/fs/btrfs/relocation.c
> >> @@ -517,6 +517,22 @@ static int update_backref_cache(struct
> >> btrfs_trans_handle *trans,
> >>       return 1;
> >>   }
> >>   +/*
> >> + * Check if this subvolume tree has valid reloc(*) tree.
> >> + *
> >> + * *: Reloc tree after swap is considered dead, thus not considered
> >> as valid.
> >> + *    This is enough for most callers, as they don't distinguish dead
> >> reloc
> >> + *    root from no reloc root.
> >> + *    But should_ignore_root() below is a special case.
> >> + */
> >> +static bool have_reloc_root(struct btrfs_root *root)
> >> +{
> >> +    if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> >> +        return false;
> > 
> > You still need a smp_mb__after_atomic() here, test_bit is unordered. 
> 
> Nope, that won't do anything, since smp_mb__(After|before)_atomic only
> orders RMW operations and test_bit is not an RMW operation. From
> atomic_bitops.txt:
> 
> 
> Non-RMW ops:
> 
> 
> 
>   test_bit()
> 
> Furthermore from atomic_t.txt:
> 
> The barriers:
> 
> 
> 
>   smp_mb__{before,after}_atomic()
> 
> 
> 
> only apply to the RMW atomic ops and can be used to augment/upgrade the
> 
> ordering inherent to the op.

The way I read it is more like smp_rmb/smp_wmb, but for bits in this
case, so the smp_mb__before/after_atomic was only a syntactic sugar to
match that it's atomic bitops. I realize this could have caused some
confusion, however I still think that some sort of barrier is needed.
