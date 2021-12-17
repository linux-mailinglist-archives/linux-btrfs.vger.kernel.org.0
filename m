Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517C74795C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 21:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhLQUup convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 17 Dec 2021 15:50:45 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:42008 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234577AbhLQUup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 15:50:45 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id B6184FCCAE; Fri, 17 Dec 2021 15:50:44 -0500 (EST)
Date:   Fri, 17 Dec 2021 15:50:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10
 vfs: verify source area in vfs_dedupe_file_range_one()
Message-ID: <Ybz4JI+Kl2J7Py3z@hungrycats.org>
References: <20211210183456.GP17148@hungrycats.org>
 <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
 <YbfTYFQVGCU0Whce@hungrycats.org>
 <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
 <Ybj1jVYu3MrUzVTD@hungrycats.org>
 <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
 <YbrPkZVC/MazdQdc@hungrycats.org>
 <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
 <Ybu4tuzqpaiast5H@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Ybu4tuzqpaiast5H@localhost.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 05:07:50PM -0500, Josef Bacik wrote:
> On Thu, Dec 16, 2021 at 11:29:06PM +0200, Nikolay Borisov wrote:
> > 
> > 
> > On 16.12.21 г. 7:33, Zygo Blaxell wrote:
> > > On Wed, Dec 15, 2021 at 12:25:04AM +0200, Nikolay Borisov wrote:
> > >> Huhz, this means there is an open transaction handle somewhere o_O. I
> > >> checked back the stacktraces in your original email but couldn't see
> > >> where that might be coming from. I.e all processes are waiting on
> > >> wait_current_trans and this happens _before_ the transaction handle is
> > >> opened, hence num_extwriters can't have been incremented by them.
> > >>
> > >> When an fs wedges, and you get again num_extwriters can you provde the
> > >> output of "echo w > /proc/sysrq-trigger"
> > > 
> > > Here you go...
> > 
> > <snip>
> > 
> > > 
> > > Again we have "3 locks held" but no list of locks.  WTF is 10883 doing?
> > > Well, first of all it's using 100% CPU in the kernel.  Some samples of
> > > kernel stacks:
> > > 
> > > 	# cat /proc/*/task/10883/stack
> > > 	[<0>] down_read_nested+0x32/0x140
> > > 	[<0>] __btrfs_tree_read_lock+0x2d/0x110
> > > 	[<0>] btrfs_tree_read_lock+0x10/0x20
> > > 	[<0>] btrfs_search_old_slot+0x627/0x8a0
> > > 	[<0>] btrfs_next_old_leaf+0xcb/0x340
> > > 	[<0>] find_parent_nodes+0xcd7/0x1c40
> > > 	[<0>] btrfs_find_all_leafs+0x63/0xb0
> > > 	[<0>] iterate_extent_inodes+0xc8/0x270
> > > 	[<0>] iterate_inodes_from_logical+0x9f/0xe0
> > 
> > That's the real culprit, in this case we are not searching the commit
> > root hence we've attached to the transaction. So we are doing backref
> > resolution which either:
> > 
> > a) Hits some pathological case and loops for very long time, backref
> > resolution is known to take a lot of time.
> > 
> > b) We hit a bug in backref resolution and loop forever which again
> > results in the transaction being kept open.
> > 
> > Now I wonder why you were able to bisect this to the seemingly unrelated
> > commit in the vfs code.
> > 
> > Josef any ideas how to proceed further to debug why backref resolution
> > takes a long time and if it's just an infinite loop?
> > 
> 
> It's probably an infinite loop, I'd just start with something like this
> 
> bpftrace -e 'tracepoint:btrfs:btrfs_prelim_ref_insert { printf("bytenr is %llu", args->bytenr); }'
> 
> and see if it's spitting out the same shit over and over again.  If it is can I
> get a btrfs inspect-internal dump-tree -e on the device along with the bytenr
> it's hung up on so I can figure out wtf it's tripping over?

That bpftrace command doesn't output anything after the hang.  Before the
hang, it's thousands and thousands of values changing as bees moves around
the filesystem.

> If it's not looping there, it may be looping higher up, but I don't see where it
> would be doing that.  Lets start here and work our way up if we need to.
> Thanks,
> 
> Josef
