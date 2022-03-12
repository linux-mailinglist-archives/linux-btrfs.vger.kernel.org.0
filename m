Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622D94D6C2D
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 04:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiCLDIj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 22:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLDIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 22:08:37 -0500
X-Greylist: delayed 1451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 19:07:33 PST
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB492713C7
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 19:07:32 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 69010250280; Fri, 11 Mar 2022 21:43:18 -0500 (EST)
Date:   Fri, 11 Mar 2022 21:43:18 -0500
From:   Zygo Blaxell <zblaxell@furryterror.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YiwIxnCMjsl8BPPA@hungrycats.org>
References: <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
 <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
 <e7df8c6e-5185-4bea-2863-211214968153@gmx.com>
 <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 12, 2022 at 12:28:10AM +0100, Jan Ziak wrote:
> On Sat, Mar 12, 2022 at 12:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > As stated before, autodefrag is not really that useful for database.
> 
> Do you realize that you are claiming that btrfs autodefrag should not
> - by design - be effective in the case of high-fragmentation files? If
> it isn't supposed to be useful for high-fragmentation files then where
> is it supposed to be useful? Low-fragmentation files?

IMHO it's best to deprecate the in-kernel autodefrag option, and start
over with a better approach.  The kernel is the wrong place to solve
this problem, and the undesirable and unfixable things in autodefrag
are a consequence of that early design error.

As far as I can tell, in-kernel autodefrag's only purpose is to provide
exposure to new and exciting bugs on each kernel release, and a lot of
uncontrolled IO demands even when it's working perfectly.  Inevitably,
re-reading old fragments that are no longer in memory will consume RAM
and iops during writeback activity, when memory and IO bandwidth is least
available.  If we avoid expensive re-reading of extents, then we don't
get a useful rate of reduction of fragmentation, because we can't coalesce
small new exists with small existing ones.  If we try to fix these issues
one at a time, the feature would inevitably grow a lot of complicated
and brittle configuration knobs to turn it off selectively, because it's
so awful without extensive filtering.

All the above criticism applies to abstract ideal in-kernel autodefrag,
_before_ considering whether a concrete implementation might have
limitations or bugs which make it worse than the already-bad best case.
5.16 happened to have a lot of examples of these, but fixing the
regressions can only restore autodefrag's relative harmlessness, not
add utility within the constraints the kernel is under.

The right place to do autodefrag is userspace.  Interfaces already
exist for userspace to 1) discover new extents and their neighbors,
quickly and safely, across the entire filesystem; 2) invoke defrag_range
on file extent ranges found in step 1; and 3) run a while (true)
loop that periodically performs steps 1 and 2.  Indeed, the existing
kernel autodefrag implementation is already using the same back-end
infrastructure for parts 1 and 2, so all that would be required for
userspace is to reimplement (and start improving upon) part 3.

A command-line utility or daemon can locate new extents immediately with
tree_search queries, either at filesystem-wide scales, or directed at
user-chosen file subsets.  Tools can quickly assess whether new extents
are good candidates for defrag, then coalesce them with their neighbors.

The user can choose between different tools to decide basic policy
questions like: whether to run once in a batch job or continuously in
the background, what amounts of IO bandwidth and memory to consume,
whether to recompress data with a more aggressive algorithm/level, which
reference to a snapshot-shared extent should be preferred for defrag,
file-type-specific layout optimizations to apply, or any custom or
experimental selection, scheduling, or optimization logic desired.

Implementations can be kept simple because it's not necessary for
userspace tools to pile every possible option into a single implementation,
and support every released option forever (as required for the kernel).
A specialist implementation can discard existing code with impunity or
start from scratch with an experimental algorithm, and spend its life
in a fork of the main userspace autodefrag project with niche users
who never have to cope with generic users' use cases and vice versa.
This efficiently distributes development and maintenance costs.

Userspace autodefrag can be implemented today in any programming language
with btrfs ioctl support, and run on any kernel released in the last
6 years.  Alas, I don't know of anybody who's released a userspace
autodefrag tool yet, and it hasn't been important enough to me to build
one myself (other than a few proof-of-concept prototypes).

For now, I do defrag mostly ad-hoc with 'btrfs fi defrag' on the most
severely fragmented files (top N list of files with the highest extent
counts on the filesystem), and ignore fragmentation everywhere else.


> -Jan
