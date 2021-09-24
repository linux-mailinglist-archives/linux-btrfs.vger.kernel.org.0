Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9E417752
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbhIXPSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 11:18:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347036AbhIXPSB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 11:18:01 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9D117223D7;
        Fri, 24 Sep 2021 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632496587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLfQh0P3AXcZ2z9Abd54q/4US5yio0Yktkl0bIt6F8s=;
        b=iglzam/K1jwHtN1TwGxg3w8rgxC6bwQPqPkVLTT4YJNOPSpYP5AS1hFZLDLL9QAxc7Sv2f
        9S7kvmncB9RvvfiD05kCmfMGrrCzND+KTjWKqVQRfPTwKmb/UJHx4LuNJiMqjoZOhXgqcT
        YSu09F6KGRytRYYrO4lZrUg5kpSxybc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632496587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLfQh0P3AXcZ2z9Abd54q/4US5yio0Yktkl0bIt6F8s=;
        b=LzmbFoSbiAZFEHdbQkgsmLHvhUipQgW9dox2KtbYbvh0swq+AdhSQqeGcuZdpbky+BH6jv
        E0HLOWkv9nQuyrCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 710B525D4D;
        Fri, 24 Sep 2021 15:16:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73803DA799; Fri, 24 Sep 2021 17:16:13 +0200 (CEST)
Date:   Fri, 24 Sep 2021 17:16:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG in __clear_extent_bit
Message-ID: <20210924151612.GC9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hao Sun <sunhao.th@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACkBjsYjkubyQBvBy7aaQStk_i1UuCu7oPNYXhZhvhWvBCM3ag@mail.gmail.com>
 <145029f0-5bc5-73fd-14ee-75b5829a3334@gmx.com>
 <CACkBjsauCShYkOdNU2snmJyLNSmdMvK7C0HbtMfKhoEXuUOSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsauCShYkOdNU2snmJyLNSmdMvK7C0HbtMfKhoEXuUOSJg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 10:24:51AM +0800, Hao Sun wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> 于2021年9月15日周三 下午1:33写道：
> >
> >
> >
> > On 2021/9/15 上午10:20, Hao Sun wrote:
> > > Hello,
> > >
> > > When using Healer to fuzz the latest Linux kernel, the following crash
> > > was triggered.
> > >
> > > HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> > > git tree: upstream
> > > console output:
> > > https://drive.google.com/file/d/1-9wwV6-OmBcJvHGCbMbP5_uCVvrUdTp3/view?usp=sharing
> > > kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
> > > C reproducer: https://drive.google.com/file/d/1eXePTqMQ5ZA0TWtgpTX50Ez4q9ZKm_HE/view?usp=sharing
> > > Syzlang reproducer:
> > > https://drive.google.com/file/d/11s13louoKZ7Uz0mdywM2jmE9B1JEIt8U/view?usp=sharing
> > >
> > > If you fix this issue, please add the following tag to the commit:
> > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > >
> > > loop1: detected capacity change from 0 to 32768
> > > BTRFS info (device loop1): disk space caching is enabled
> > > BTRFS info (device loop1): has skinny extents
> > > BTRFS info (device loop1): enabling ssd optimizations
> > > FAULT_INJECTION: forcing a failure.
> > > name failslab, interval 1, probability 0, space 0, times 0
> > > CPU: 1 PID: 25852 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:88 [inline]
> > >   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
> > >   fail_dump lib/fault-inject.c:52 [inline]
> > >   should_fail+0x13c/0x160 lib/fault-inject.c:146
> > >   should_failslab+0x5/0x10 mm/slab_common.c:1328
> > >   slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
> > >   slab_alloc_node mm/slub.c:3120 [inline]
> > >   slab_alloc mm/slub.c:3214 [inline]
> > >   kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
> > >   alloc_extent_state+0x1e/0x1c0 fs/btrfs/extent_io.c:340
> >
> > This is the one of the core systems btrfs uses, and we really don't want
> > that to fail.
> >
> > Thus in fact it does some preallocation to prevent failure.
> >
> > But for error injection case, we can still hit BUG_ON() which is used to
> > catch ENOMEM.
> >
> 
> Hello,
> 
> Fuzzer triggered following crashes repeatedly when the `fault
> injection` was enabled.
> 
> HEAD commit: 92477dd1faa6 Merge tag 's390-5.15-ebpf-jit-fixes'
> git tree: upstream
> kernel config: https://drive.google.com/file/d/1KgvcM8i_3hQiOL3fUh3JFpYNQM4itvV4/view?usp=sharing
> [1] kernel BUG in btrfs_free_tree_block (fs/btrfs/extent-tree.c:3297):
> https://paste.ubuntu.com/p/ZtzVKWbcGm/
> [2] kernel BUG in clear_state_bit (fs/btrfs/extent_io.c:658!):
> https://paste.ubuntu.com/p/hps2wXPG2b/
> [3] kernel BUG in set_extent_bit (fs/btrfs/extent_io.c:1021):
> https://paste.ubuntu.com/p/dcptjYYxgd/
> [4] kernel BUG in set_state_bits (fs/btrfs/extent_io.c:939):
> https://paste.ubuntu.com/p/NV9qtKB4KZ/
> 
> All the above crashes were triggered directly by the `BUG_ON()` macro
> in the corresponding location.
> Most `BUG_ON()` was hit due to `ENOMEM` when fault injected.
> Would it be better for btrfs to handle the `ENOMEM` error, e.g.,
> gracefully return, rather than panic the kernel?

If it would be so easy we would have done it already. Unfortunatelly in
some deep call chains or under locks or from contexts where the whole
operation is split accross subsystems or threads it's not always
possible to roll back. Some tricks like preallocation can bail out early
but we can't preallocate everything. The allocations are done under
GFP_NOFS that still has the no-fail semantics. The error you report do
not normally happen because allocator tries hard to return some memory.
