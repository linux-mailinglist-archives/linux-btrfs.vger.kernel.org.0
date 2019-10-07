Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24098CE732
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfJGPSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 11:18:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728493AbfJGPSf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 11:18:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0574FAC26;
        Mon,  7 Oct 2019 15:18:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41022DA7FB; Mon,  7 Oct 2019 17:18:48 +0200 (CEST)
Date:   Mon, 7 Oct 2019 17:18:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Mark Fasheh <mfasheh@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Relocation/backref cache cleanups
Message-ID: <20191007151847.GB2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Mark Fasheh <mfasheh@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190906171533.618-1-mfasheh@suse.com>
 <20191002125855.GM2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002125855.GM2751@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 02:58:55PM +0200, David Sterba wrote:
> On Fri, Sep 06, 2019 at 10:15:30AM -0700, Mark Fasheh wrote:
> > Hi,
> > 
> > Relocation caches extent backrefs in an rbtree (the 'backref cache').  The
> > following patches move the backref cache code out of relocation.c and into
> > it's own file.  We then do a straight-forward cleanup the main backref cache
> > function, build_backref_tree().  No functionality is changed in these
> > patches.
> > 
> > These patches are part of a larger series I have, which speeds up qgroup
> > accounting by using the same backref cache facility.  That series is not
> > quite ready, however I wanted to see about getting these cleanup patches
> > upstreamed as they are nicely self contained and benefit the readability of
> > the code.
> 
> Patches 1-3 moved to misc-next.

And removed again. There's an assertion hit in at least 2 fstests
(btrfs/061, btrfs/063, btrfs/187). I tried the verbatim patches from the
mailinglist and the version I applied with some minor edits, both
reproduce that.

[ 6466.460371] assertion failed: !node || !node->detached, in fs/btrfs/backref-cache.c:890
[ 6466.462933] ------------[ cut here ]------------
[ 6466.464419] kernel BUG at fs/btrfs/ctree.h:3119!
[ 6466.465950] invalid opcode: 0000 [#1] SMP
[ 6466.467281] CPU: 3 PID: 23411 Comm: btrfs Tainted: G        W         5.4.0-rc1-default+ #743
[ 6466.470089] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 6466.473501] RIP: 0010:assfail.constprop.0+0x18/0x26 [btrfs]
[ 6466.479151] RSP: 0000:ffffaca387a13950 EFLAGS: 00010246
[ 6466.479965] RAX: 000000000000004b RBX: ffff97d4777aacb8 RCX: 0000000000000001
[ 6466.481011] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffbd1044c0
[ 6466.482059] RBP: dead000000000122 R08: 0000000000000000 R09: 0000000000000000
[ 6466.483114] R10: 0000000000000000 R11: 0000000000000000 R12: dead000000000100
[ 6466.484163] R13: ffff97d46d38f508 R14: ffff97d490a74b90 R15: ffff97d4777aace8
[ 6466.485236] FS:  00007f5ca43fb8c0(0000) GS:ffff97d4bdc00000(0000) knlGS:0000000000000000
[ 6466.486508] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6466.487888] CR2: 000055c2028b0018 CR3: 000000003abfe000 CR4: 00000000000006e0
[ 6466.489924] Call Trace:
[ 6466.490728]  build_backref_tree.cold+0xcc/0xdd [btrfs]
[ 6466.492400]  relocate_tree_blocks+0x19c/0x6f0 [btrfs]
[ 6466.493989]  ? kmem_cache_alloc_trace+0x1d3/0x260
[ 6466.495405]  relocate_block_group+0x218/0x5b0 [btrfs]
[ 6466.496884]  btrfs_relocate_block_group+0x154/0x300 [btrfs]
[ 6466.498478]  btrfs_relocate_chunk+0x32/0xd0 [btrfs]
[ 6466.499768]  __btrfs_balance+0x41c/0xc90 [btrfs]
[ 6466.501306]  btrfs_balance+0x57d/0xa60 [btrfs]
[ 6466.502663]  ? btrfs_ioctl_balance+0x21c/0x350 [btrfs]
[ 6466.504183]  ? kmem_cache_alloc_trace+0x1d3/0x260
[ 6466.505578]  btrfs_ioctl_balance+0x298/0x350 [btrfs]
[ 6466.506819]  btrfs_ioctl+0x2d3/0x2550 [btrfs]
[ 6466.507964]  ? __handle_mm_fault+0x60b/0x6e0
[ 6466.508883]  ? _raw_spin_unlock+0x24/0x30
[ 6466.509678]  ? do_vfs_ioctl+0x405/0x730
[ 6466.510390]  do_vfs_ioctl+0x405/0x730
[ 6466.511056]  ksys_ioctl+0x3a/0x70
[ 6466.511834]  ? trace_hardirqs_off_thunk+0x1a/0x20
[ 6466.512715]  __x64_sys_ioctl+0x16/0x20
[ 6466.513351]  do_syscall_64+0x50/0x1f0
[ 6466.513978]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 6466.514790] RIP: 0033:0x7f5ca4620387
[ 6466.518949] RSP: 002b:00007ffe004aeb78 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[ 6466.521066] RAX: ffffffffffffffda RBX: 00007ffe004aec20 RCX: 00007f5ca4620387
[ 6466.523018] RDX: 00007ffe004aec20 RSI: 00000000c4009420 RDI: 0000000000000003
[ 6466.524988] RBP: 0000000000000003 R08: 000055683637c2a0 R09: 0000000000000231
[ 6466.526966] R10: fffffffffffff206 R11: 0000000000000206 R12: 0000000000000001
[ 6466.528936] R13: 00007ffe004b0167 R14: 0000000000000001 R15: 0000000000000000
[ 6466.533252] Modules linked in: dm_flakey dm_mod dax btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop
[ 6466.535241] ---[ end trace a30d87f8f65c9956 ]---
[ 6466.536313] RIP: 0010:assfail.constprop.0+0x18/0x26 [btrfs]
[ 6466.540357] RSP: 0000:ffffaca387a13950 EFLAGS: 00010246
[ 6466.541358] RAX: 000000000000004b RBX: ffff97d4777aacb8 RCX: 0000000000000001
[ 6466.542609] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffbd1044c0
[ 6466.545863] RBP: dead000000000122 R08: 0000000000000000 R09: 0000000000000000
[ 6466.548036] R10: 0000000000000000 R11: 0000000000000000 R12: dead000000000100
[ 6466.549618] R13: ffff97d46d38f508 R14: ffff97d490a74b90 R15: ffff97d4777aace8
[ 6466.551137] FS:  00007f5ca43fb8c0(0000) GS:ffff97d4bdc00000(0000) knlGS:0000000000000000
[ 6466.552858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6466.553844] CR2: 000055c2028b0018 CR3: 000000003abfe000 CR4: 00000000000006e0
[ 6467.928233] ------------[ cut here ]------------
