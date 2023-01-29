Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DEB67FBF9
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jan 2023 01:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjA2Akp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Jan 2023 19:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjA2Akn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Jan 2023 19:40:43 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11DE521A2F
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 16:40:41 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 8FD9271493C; Sat, 28 Jan 2023 19:40:39 -0500 (EST)
Date:   Sat, 28 Jan 2023 19:40:39 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Will Btrfs have an official command to "uncow" existing files?
Message-ID: <Y9XAh5NuPoRwUCBe@hungrycats.org>
References: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
 <Y840neK7y/u8Dpn2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y840neK7y/u8Dpn2@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 22, 2023 at 11:17:49PM -0800, Christoph Hellwig wrote:
> On Sun, Jan 22, 2023 at 02:41:22PM +0300, Cerem Cem ASLAN wrote:
> > Original post is here: https://www.spinics.net/lists/linux-btrfs/msg58055.html
> > 
> > The problem with the "chattr +C ..., move back and forth" approach is
> > that the VM folder is about 300GB and I have ~100GB of free space,
> > plus, I have multiple copies which will require that 300GB to
> > re-transfer after deleting all previous snapshots (because there is no
> > enough free space on those backup hard disks).
> > 
> > So, we really need to set the NoCow attribute for the existing files.
> > 
> > Should we currently use a separate partition for VMs and mount it with
> > nodatacow option to avoid that issue?
> 
> So, Linux for a while now has the FALLOC_FL_UNSHARE_RANGE flag to
> fallocate to unshare previously shared extents.  It still lacks an
> implementation for btrfs, but it seems to be the interface that you
> want.

Users can already get unshared extents with the btrfs DEFRAG_RANGE ioctl,
but in a datacow file, the result is an unshared copy-on-write extent,
not a write-in-place extent.  If this solved the original problem,
it would be in a FAQ somewhere.

The btrfs datacow attribute is in the inode, not the extent.  Extents in
a datacow file are copy-on-write regardless of extent sharing (ZERO_RANGE
allocations are a temporary exception, but eventually revert back to
copy-on-write).  Extents in a nodatacow file are copy-on-write if the
extents are shared at write time; otherwise, they are write-in-place.

If btrfs is changed to move the nodatacow status into the extent
reference, it would allow individual extents to have independently
settable datacow/nodatacow bits, and the inode attribute would be
merely a hint for what value to use when creating new extents.  If that
was done, UNSHARE_RANGE could have the expected effect on allocation,
but an unexpected side-effect of disabling data csums at the same time
(datasum relies on datacow, setting nodatacow also sets nodatasum).

Better to not implement UNSHARE_RANGE at all than to have an
implementation with unexpected and unpleasant side-effects.  Or add an
extra flag to the fallocate interface to indicate whether a downgrade in
data integrity is intended and permitted, so it won't happen unexpectedly.

The experience of ZERO_RANGE on btrfs can be informative.  Most of the
above can also be said about btrfs support for ZERO_RANGE on datacow
files too (ZERO_RANGE on nodatacow files is sane, but OP's problem is how
to make an existing datacow file become nodatacow).  ZERO_RANGE is also
an inode attribute on btrfs (called PREALLOC), and for datacow files it
causes more problems than ZERO_RANGE was ever intended to solve, while
not implementing the allocation guarantees promised in the ZERO_RANGE
documentation (ENOSPC is still possible, and potentially more likely,
after fallocate with ZERO_RANGE on a datacow file).  As a bonus feature,
ZERO_RANGE cannot be turned off in an inode once it is set, disrupting
other features like compression.  With per-extent datacow attributes,
at least the damage can be limited to the offset and length arguments
of fallocate(2), instead of tainting the entire inode forever.

So I guess that makes two btrfs problems that can be solved by the same
modification of btrfs on-disk structures.
