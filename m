Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C98627268
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 21:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiKMUFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 15:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiKMUFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 15:05:13 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B1464F2
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 12:05:10 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 795D55FF2A9; Sun, 13 Nov 2022 15:05:08 -0500 (EST)
Date:   Sun, 13 Nov 2022 15:05:08 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: infinite looping in logical_ino ioctl
Message-ID: <Y3FN9JNVkgtv34P0@hungrycats.org>
References: <Y28XvZmK0bAS4Ht/@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y28XvZmK0bAS4Ht/@hungrycats.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 11, 2022 at 10:49:17PM -0500, Zygo Blaxell wrote:
> I've been chasing an infinite loop in the logical_ino ioctl that appears
> when dedupe and logical_ino are used together on the same filesystem.
[...]
> add_all_parents:

I added a simple loop counter to make it easier to get gdb to stop
at the right place:

	size_t loop_count = 0;

>     462         while (!ret && count < ref->count) {

			if (loop_count++ == 999999) {
				printk(KERN_ERR "loop_count exceeded, break here\n");
			}

Then I set a breakpoint there, and had the debugger set count = 1
to force logical_ino out of the loop in add_all_parents.  Almost
immediately, the same thread goes right back into add_all_parents
with a different search key:

	(gdb) commands 6
	>set var count=1
	>c
	>end
	(gdb) continue

	Thread 3 hit Breakpoint 6, add_all_parents (ignore_offset=<optimized out>, extent_item_pos=0xffffc90008897be8, time_seq=11943, level=<optimized out>, ref=0xffff8881dca3a210, preftrees=0xffffc90008897ac0, parents=0xffff88842c9920a0, path=0xffff88815d347460, root=<optimized out>) at fs/btrfs/backref.c:466
	466                             printk(KERN_ERR "loop_count exceeded, break here\n");
	1: key = {objectid = 304, type = 108 'l', offset = 318775296}
	2: count = 0
	3: *key_for_search = {objectid = 304, type = 108 'l', offset = 721883136}
	4: ref->count = 1

	Thread 3 hit Breakpoint 6, add_all_parents (ignore_offset=<optimized out>, extent_item_pos=0xffffc90008897be8, time_seq=11943, level=<optimized out>, ref=0xffff88842f8a9630, preftrees=0xffffc90008897ac0, parents=0xffff88842c9920a0, path=0xffff88815d347460, root=<optimized out>) at fs/btrfs/backref.c:466
	466                             printk(KERN_ERR "loop_count exceeded, break here\n");
	1: key = {objectid = 304, type = 108 'l', offset = 318775296}
	2: count = 0
	3: *key_for_search = {objectid = 304, type = 108 'l', offset = 721879040}
	4: ref->count = 1

	Thread 3 hit Breakpoint 6, add_all_parents (ignore_offset=<optimized out>, extent_item_pos=0xffffc90008897be8, time_seq=11943, level=<optimized out>, ref=0xffff8881a5a86478, preftrees=0xffffc90008897ac0, parents=0xffff88842c9920a0, path=0xffff88815d347460, root=<optimized out>) at fs/btrfs/backref.c:466
	466                             printk(KERN_ERR "loop_count exceeded, break here\n");
	1: key = {objectid = 304, type = 108 'l', offset = 318775296}
	2: count = 0
	3: *key_for_search = {objectid = 304, type = 108 'l', offset = 721874944}
	4: ref->count = 2

	Thread 3 hit Breakpoint 6, add_all_parents (ignore_offset=<optimized out>, extent_item_pos=0xffffc90008897be8, time_seq=11943, level=<optimized out>, ref=0xffff8881a03d1f20, preftrees=0xffffc90008897ac0, parents=0xffff88842c9920a0, path=0xffff88815d347460, root=<optimized out>) at fs/btrfs/backref.c:466
	466                             printk(KERN_ERR "loop_count exceeded, break here\n");
	1: key = {objectid = 304, type = 108 'l', offset = 318775296}
	2: count = 0
	3: *key_for_search = {objectid = 304, type = 108 'l', offset = 721850368}
	4: ref->count = 1

	Thread 3 hit Breakpoint 6, add_all_parents (ignore_offset=<optimized out>, extent_item_pos=0xffffc90008897be8, time_seq=11943, level=<optimized out>, ref=0xffff88816b340c60, preftrees=0xffffc90008897ac0, parents=0xffff88842c9920a0, path=0xffff88815d347460, root=<optimized out>) at fs/btrfs/backref.c:466
	466                             printk(KERN_ERR "loop_count exceeded, break here\n");
	1: key = {objectid = 304, type = 108 'l', offset = 318775296}
	2: count = 0
	3: *key_for_search = {objectid = 304, type = 108 'l', offset = 721829888}
	4: ref->count = 1

That did get logical_ino to eventually give up and return to userspace,
which ends my debugging session for today.  Next time it gets stuck,
I'll put some breakpoints further up the call stack to see what the
caller's state looks like.

I'm not sure how to debug btrfs_next_old_item(), as gdb has some real
problems controlling execution in that function, and examining varibles
in there is a great way to find the bugs in gdb itself.

Is there a GDB trick to get the kernel to dump out the eb contents
from gdb?  Calling btrfs_print_leaf(eb) from the debugger seems to make
the kernel splat.  I suppose I could call it when loop_count hits 999999.

This part was wrong in my earlier post:

> When I tried to probe more deeply what btrfs_next_old_item was doing,
> I found that the code is somehow executing btrfs_next_item on line 519,
> despite time_seq having the value 3722 at the time.  Iteration over the
> items in views at two different points in time sounds like it could
> result in infinite looping, but I wasn't able to confirm that before
> the gdb session died.  I'm now waiting for my test VM to repro again.

This is just an artifact of inline function optimization.  The assembly
code for that if statement is full of jumps that don't correspond neatly
to source lines.  If the pc is pointing anywhere near that block, gdb
thinks it's on line 519.
