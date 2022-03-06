Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC254CEE8E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 00:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiCFXfc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 18:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCFXfb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 18:35:31 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56BD12A84
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 15:34:37 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 317BF238D01; Sun,  6 Mar 2022 18:34:32 -0500 (EST)
Date:   Sun, 6 Mar 2022 18:34:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1
Message-ID: <YiVFCO5KPGkdQAyA@hungrycats.org>
References: <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
 <YbrPkZVC/MazdQdc@hungrycats.org>
 <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
 <Ybu4tuzqpaiast5H@localhost.localdomain>
 <Ybz4JI+Kl2J7Py3z@hungrycats.org>
 <YdiG6xYbY0tZ21j9@hungrycats.org>
 <bc677ef0-ea1c-5f8f-f225-4d3f4f3d3459@leemhuis.info>
 <Yen+CTCm+wbdJnJk@hungrycats.org>
 <7ccf001b-b249-7d6c-fa86-f25d2b5e55a5@leemhuis.info>
 <ecb5cd7c-d261-c75b-3b66-4b7e0bc228ab@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb5cd7c-d261-c75b-3b66-4b7e0bc228ab@leemhuis.info>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 11:31:05AM +0100, Thorsten Leemhuis wrote:
> [Adding Chris and David to the list of recipients]
> 
> Hi, this is your Linux kernel regression tracker again.
> 
> @Btrfs-Maintainers: is anyone addressing this regression that got
> bisected many weeks ago? It from here looks like things are stuck: Libor
> asked for a status update 24 days ago, I did the same 15 days ago, but
> neither of us got a answer. Is there some good reason for this? Or did
> the discussion continue somewhere else?

TL;DR it's not a regression and the bisection is invalid.  I apologize
for using the word "regression" too early.  This is a pre-existing bug
that doesn't require special attention.

After multiple bisection test runs and multiple brute-force linear tests
of every btrfs commit between 5.10 and 5.11, and similar event reports
observed in production fleet, I now believe the original bisection
results are an artifact of the git bisection algorithm and a bug with
unusual behavior.

Every commit in the range eventually locks up with the same symptoms.
Commits seem to randomly fall into the "minutes to reproduce" or "weeks
to reproduce" buckets, i.e. there's no single point in the commit history
where everything before the point is good and everything after the point
is bad.  The fact that bad commits are interleaved with good ones points
to an issue elsewhere, far away from the commit that bisect happened to
land on.

This bug is now at the top of my "reasons why btrfs crashes" list,
but that is because 1) every worse bug on that list has now been fixed
(including some other much more urgent regressions from the past few
kernel cycles) and 2) I'm pushing hard on specific parts of btrfs that
only a few people are using at the moment.  Most of the bugs I've hit
in btrfs turned out to be more than 5 years old at the time, and this
"new" bug could easily fall into that category.

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
> #regzbot poke
> 
> On 18.02.22 15:46, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker speaking. Top-posting
> > for once, to make this easy accessible to everyone.
> > 
> > What's up here? Can anyone (Zygo? Josef?) please provide a status
> > update? Yes, it took quite a while till this regression got found, but
> > nevertheless this looks to take awfully long to get resolved for a
> > regression was bisected weeks ago.
> > 
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > 
> > P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> > reports on my table. I can only look briefly into most of them and lack
> > knowledge about most of the areas they concern. I thus unfortunately
> > will sometimes get things wrong or miss something important. I hope
> > that's not the case here; if you think it is, don't hesitate to tell me
> > in a public reply, it's in everyone's interest to set the public record
> > straight.
> > 
> > 
> > On 21.01.22 01:27, Zygo Blaxell wrote:
> >> On Thu, Jan 20, 2022 at 03:04:19PM +0100, Thorsten Leemhuis wrote:
> >>> Hi, this is your Linux kernel regression tracker speaking.
> >>>
> >>> On 07.01.22 19:31, Zygo Blaxell wrote:
> >>>> On Fri, Dec 17, 2021 at 03:50:44PM -0500, Zygo Blaxell wrote:
> >>>> I left my VM running tests for a few weeks and got some more information.
> >>>> Or at least more data, I'm not feeling particularly informed by it.  :-P
> >>>>
> >>>> 1.  It's not a regression.  5.10 has the same symptoms, but about 100x
> >>>> less often (once a week under these test conditions, compared to once
> >>>> every 90 minutes or so on 5.11-rc1).
> >>>
> >>> Well, I'd still call it a regression, as it's now happening way more
> >>> often and thus will likely hit more users. It's thus a bit like a
> >>> problem that leads to higher energy consumption: things still work, but
> >>> worse than before -- nevertheless it's considered a regression. Anway:
> >>>
> >>> What's the status here? Are you still investigating the issue? Are any
> >>> developers looking out for the root cause?
> >>
> >> I think Josef's plan (start inside the logical_ino ioctl with bpftrace
> >> and work upwards to see where the looping is getting stuck) is a good plan,
> >> but due to conflicting priorities I haven't found the time to act on it.
> >>
> >> I can take experimental patches and throw them at my repro setup if
> >> anyone would like to supply some.
> >>
> >>> Ciao, Thorsten
> >>>
> >>> P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
> >>> on my table. I can only look briefly into most of them. Unfortunately
> >>> therefore I sometimes will get things wrong or miss something important.
> >>> I hope that's not the case here; if you think it is, don't hesitate to
> >>> tell me about it in a public reply, that's in everyone's interest.
> >>>
> >>> BTW, I have no personal interest in this issue, which is tracked using
> >>> regzbot, my Linux kernel regression tracking bot
> >>> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
> >>> this mail to get things rolling again and hence don't need to be CC on
> >>> all further activities wrt to this regression.
> >>>
> >>> #regzbot poke
> >>>
> >>>> 2.  Bisection doesn't work, because there are patches that are repeatably
> >>>> good and bad mixed together, so the bisect algorithm (even with stochastic
> >>>> enhancement) repeatably picks the wrong commits and converges with
> >>>> high confidence on nonsense.  Instead of bisecting, I picked commits
> >>>> semi-randomly from 5.11-rc1's patch set, and got these results:
> >>>>
> >>>>    124  3a160a933111 btrfs: drop never met disk total bytes check in verify_one_dev_extent
> >>>> 	1x hang, 2x slower
> >>>>    125  bacce86ae8a7 btrfs: drop unused argument step from btrfs_free_extra_devids
> >>>> 	1x pass (fast)
> >>>>    126  2766ff61762c btrfs: update the number of bytes used by an inode atomically
> >>>> 	1x hang (<20 minutes)
> >>>>    127  7f458a3873ae btrfs: fix race when defragmenting leads to unnecessary IO
> >>>> 	1x hang, runs 3x slower
> >>>>    128  5893dfb98f25 btrfs: refactor btrfs_drop_extents() to make it easier to extend
> >>>> 	2x hang (<20 minutes)
> >>>>    129  e114c545bb69 btrfs: set the lockdep class for extent buffers on creation
> >>>> 	2x pass (but runs 2x slower, both times)
> >>>>    130  3fbaf25817f7 btrfs: pass the owner_root and level to alloc_extent_buffer
> >>>> 	1x pass
> >>>>    131  5d81230baa90 btrfs: pass the root owner and level around for readahead
> >>>> 	1x pass
> >>>>    132  1b7ec85ef490 btrfs: pass root owner to read_tree_block
> >>>> 	1x pass
> >>>>    133  182c79fcb857 btrfs: use btrfs_read_node_slot in btrfs_qgroup_trace_subtree
> >>>>    134  3acfbd6a990c btrfs: use btrfs_read_node_slot in qgroup_trace_new_subtree_blocks
> >>>> 	1x hang
> >>>>    135  6b2cb7cb959a btrfs: use btrfs_read_node_slot in qgroup_trace_extent_swap
> >>>>    136  c990ada2a0bb btrfs: use btrfs_read_node_slot in walk_down_tree
> >>>> 	1x hang
> >>>>    137  6b3426be27de btrfs: use btrfs_read_node_slot in replace_path
> >>>> 	1x hang, 1x pass
> >>>>    138  c975253682e0 btrfs: use btrfs_read_node_slot in do_relocation
> >>>> 	1x hang
> >>>>    139  8ef385bbf099 btrfs: use btrfs_read_node_slot in walk_down_reloc_tree
> >>>> 	1x hang, 1x pass
> >>>>    140  206983b72a36 btrfs: use btrfs_read_node_slot in btrfs_realloc_node
> >>>> 	1x pass
> >>>>    141  bfb484d922a3 btrfs: cleanup extent buffer readahead
> >>>> 	1x pass
> >>>>    142  416e3445ef80 btrfs: remove lockdep classes for the fs tree
> >>>>    143  3e48d8d2540d btrfs: discard: reschedule work after sysfs param update
> >>>>    144  df903e5d294f btrfs: don't miss async discards after scheduled work override
> >>>>    145  6e88f116bd4c btrfs: discard: store async discard delay as ns not as jiffies
> >>>> 	2x hang
> >>>>    146  e50404a8a699 btrfs: discard: speed up async discard up to iops_limit
> >>>>
> >>>>    [snip]
> >>>>
> >>>>    155  0d01e247a06b btrfs: assert page mapping lock in attach_extent_buffer_page
> >>>> 	1x hang, 1x pass
> >>>>    156  bbb86a371791 btrfs: protect fs_info->caching_block_groups by block_group_cache_lock
> >>>> 	1x hang
> >>>>    157  e747853cae3a btrfs: load free space cache asynchronously
> >>>> 	1x pass
> >>>>    158  4d7240f0abda btrfs: load the free space cache inode extents from commit root
> >>>> 	1x hang
> >>>>    159  cd79909bc7cd btrfs: load free space cache into a temporary ctl
> >>>> 	2x pass
> >>>>    160  66b53bae46c8 btrfs: cleanup btrfs_discard_update_discardable usage
> >>>> 	2x hang, 1x pass
> >>>>    161  2ca08c56e813 btrfs: explicitly protect ->last_byte_to_unpin in unpin_extent_range
> >>>> 	2x pass
> >>>>    162  27d56e62e474 btrfs: update last_byte_to_unpin in switch_commit_roots
> >>>> 	2x pass
> >>>>    163  9076dbd5ee83 btrfs: do not shorten unpin len for caching block groups
> >>>>    164  dc5161648693 btrfs: reorder extent buffer members for better packing
> >>>> 	2x pass
> >>>>    165  b9729ce014f6 btrfs: locking: rip out path->leave_spinning
> >>>>    166  ac5887c8e013 btrfs: locking: remove all the blocking helpers
> >>>>    167  2ae0c2d80d25 btrfs: scrub: remove local copy of csum_size from context
> >>>>    168  419b791ce760 btrfs: check integrity: remove local copy of csum_size
> >>>> 	1x hang, 1x pass
> >>>>    169  713cebfb9891 btrfs: remove unnecessary local variables for checksum size
> >>>>    170  223486c27b36 btrfs: switch cached fs_info::csum_size from u16 to u32
> >>>>    171  55fc29bed8dd btrfs: use cached value of fs_info::csum_size everywhere
> >>>>    172  fe5ecbe818de btrfs: precalculate checksums per leaf once
> >>>>    173  22b6331d9617 btrfs: store precalculated csum_size in fs_info
> >>>>    174  265fdfa6ce0a btrfs: replace s_blocksize_bits with fs_info::sectorsize_bits
> >>>>    175  098e63082b9b btrfs: replace div_u64 by shift in free_space_bitmap_size
> >>>> 	2x pass
> >>>>    176  ab108d992b12 btrfs: use precalculated sectorsize_bits from fs_info
> >>>>
> >>>>    [snip]
> >>>>
> >>>>    200  5e8b9ef30392 btrfs: move pos increment and pagecache extension to btrfs_buffered_write
> >>>> 	1x pass
> >>>>    201  4e4cabece9f9 btrfs: split btrfs_direct_IO to read and write
> >>>>
> >>>>    [snip]
> >>>>
> >>>>    215  d70bf7484f72 btrfs: unify the ro checking for mount options
> >>>> 	1x pass
> >>>>    216  a6889caf6ec6 btrfs: do not start readahead for csum tree when scrubbing non-data block groups
> >>>>    217  a57ad681f12e btrfs: assert we are holding the reada_lock when releasing a readahead zone
> >>>>    218  aa8c1a41a1e6 btrfs: set EXTENT_NORESERVE bits side btrfs_dirty_pages()
> >>>>    219  13f0dd8f7861 btrfs: use round_down while calculating start position in btrfs_dirty_pages()
> >>>>    220  949b32732eab btrfs: use iosize while reading compressed pages
> >>>>    221  eefa45f59379 btrfs: calculate num_pages, reserve_bytes once in btrfs_buffered_write
> >>>>    222  fb8a7e941b1b btrfs: calculate more accurate remaining time to sleep in transaction_kthread
> >>>> 	1x pass
> >>>>
> >>>> There is some repeatability in these results--some commits have a much
> >>>> lower failure rate than others--but I don't see a reason why the bad
> >>>> commits are bad or the good commits are good.  There are some commits with
> >>>> locking and concurrency implications, but they're as likely to produce
> >>>> good as bad results in test.  Sometimes there's a consistent change in
> >>>> test result after a commit that only rearranges function arguments on
> >>>> the stack.
> >>>>
> >>>> Maybe what we're looking at is a subtle race that is popping up due
> >>>> to unrelated changes in the kernel, and disappearing just as often,
> >>>> and 5.11-rc1 in particular did something innocent that aggravates
> >>>> it somehow, so all later kernels hit the problem more often than
> >>>> 5.10 did.
> >>>>
> >>>> 3.  Somewhere around "7f458a3873ae btrfs: fix race when defragmenting
> >>>> leads to unnecessary IO" bees starts running about 3x slower than on
> >>>> earlier kernels.  bees is a nightmare of nondeterministically racing
> >>>> worker threads, so I'm not sure how important this observation is,
> >>>> but it keeps showing up in the data.
> >>>>
> >>>> 4.  I had one machine on 5.10.84 (not a test VM) with a shell process
> >>>> that got stuck spinning 100% CPU in the kernel on sys_write.  bees was
> >>>> also running, but its threads were all stuck waiting for the shell to
> >>>> release the transaction.  Other crashes on 5.10.8x kernels look more
> >>>> like the one in this thread, with a logical_ino spinning.
> >>>>
> >>>>>> If it's not looping there, it may be looping higher up, but I don't see where it
> >>>>>> would be doing that.  Lets start here and work our way up if we need to.
> >>>>>> Thanks,
> >>>
> > 
> 
