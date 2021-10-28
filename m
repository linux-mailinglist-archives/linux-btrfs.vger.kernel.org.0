Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AF43E7E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhJ1SDD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 14:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhJ1SBc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D05E16108F
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635443944;
        bh=DOD/4gwwQFKhRWMM7z+RInvp3bTzjAwkfLIlcppc9NM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ukXo4cee5HnMS/LKiyab6fdgLXp3V3VQFj9bHghLocSLIGG7AEJvQ/3KU7fwZsfrw
         OIF/EHcnbjOzbNtm7KNRjuv7ESXzr7orelyI7uLxFhgRzjFIPWjSGFTT7CWEZnlqgr
         O/RBHrl7jPfVQTLxaXaY3on7G6X6HxvtqVjcqZJmXYCIVY9Bw//LuwPVTr58GJzpMO
         6b7B8BONCaapuBt99zU4Tr8XJ1mcg3WCtsNpPxOLK6gtUkS9zxLgWdv7Diw2uQ6f1M
         X43Z/6adMU/SraUGGEWB5h1x633BUGMl2QiGkfzG54Zr2CpXinIvQ4SV97GrEknPlg
         aqMJT904yLi/Q==
Received: by mail-qk1-f174.google.com with SMTP id i9so6169415qki.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 10:59:04 -0700 (PDT)
X-Gm-Message-State: AOAM531lZUnxCzbD/AL3GxPnzT1YOn7ovm7gZPSSdVcXLW0Avxt4fVD4
        bzID3Rv81QqoYWMWbzOq7ECbIHmUjx3qhPQwYxE=
X-Google-Smtp-Source: ABdhPJx7K0cSNEvrBIHX/VMhv6xqWkt0A2n5GMuvfcXHT4v6BzLVxJFLQkjz7AqeLLvomI0TqEdtIXl92FmUZYQIVpo=
X-Received: by 2002:a05:620a:e06:: with SMTP id y6mr4859978qkm.163.1635443943961;
 Thu, 28 Oct 2021 10:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <42b432f82ad45a829a9712a15e1684f2e85c82ea.1635433374.git.fdmanana@suse.com>
 <YXra9hVsx8+EGol4@localhost.localdomain>
In-Reply-To: <YXra9hVsx8+EGol4@localhost.localdomain>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 28 Oct 2021 18:58:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5P5A52guSvVUo5rnMP8Y6TGYFdkpB-gNQaRY_Udvt_uA@mail.gmail.com>
Message-ID: <CAL3q7H5P5A52guSvVUo5rnMP8Y6TGYFdkpB-gNQaRY_Udvt_uA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix ENOSPC failure when attempting direct IO write
 into NOCOW range
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 6:16 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Thu, Oct 28, 2021 at 04:03:41PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When doing a direct IO write against a file range that either has
> > preallocated extents in that range or has regular extents and the file
> > has the NOCOW attribute set, the write fails with -ENOSPC when all of
> > the following conditions are met:
> >
> > 1) There are no data blocks groups with enough free space matching
> >    the size of the write;
> >
> > 2) There's not enough unallocated space for allocating a new data block
> >    group;
> >
> > 3) The extents in the target file range are not shared, neither through
> >    snapshots nor through reflinks.
> >
> > This is wrong because a NOCOW write can be done in such case, and in fact
> > it's possible to do it using a buffered IO write, since when failing to
> > allocate data space, the buffered IO path checks if a NOCOW write is
> > possible.
> >
> > The failure in direct IO write path comes from the fact that early on,
> > at btrfs_dio_iomap_begin(), we try to allocate data space for the write
> > and if it that fails we return the error and stop - we never check if we
> > can do NOCOW. But later, at btrfs_get_blocks_direct_write(), we check
> > if we can do a NOCOW write into the range, or a subset of the range, and
> > then release the previously reserved data space.
> >
> > Fix this by doing the data reservation only if needed, when we must COW,
> > at btrfs_get_blocks_direct_write() instead of doing it at
> > btrfs_dio_iomap_begin(). This also simplifies a bit the logic and removes
> > the inneficiency of doing unnecessary data reservations.
> >
> > The following example test script reproduces the problem:
> >
> >   $ cat dio-nocow-enospc.sh
> >   #!/bin/bash
> >
> >   DEV=/dev/sdj
> >   MNT=/mnt/sdj
> >
> >   # Use a small fixed size (1G) filesystem so that it's quick to fill
> >   # it up.
> >   # Make sure the mixed block groups feature is not enabled because we
> >   # later want to not have more space available for allocating data
> >   # extents but still have enough metadata space free for the file writes.
> >   mkfs.btrfs -f -b $((1024 * 1024 * 1024)) -O ^mixed-bg $DEV
> >   mount $DEV $MNT
> >
> >   # Create our test file with the NOCOW attribute set.
> >   touch $MNT/foobar
> >   chattr +C $MNT/foobar
> >
> >   # Now fill in all unallocated space with data for our test file.
> >   # This will allocate a data block group that will be full and leave
> >   # no (or a very small amount of) unallocated space in the device, so
> >   # that it will not be possible to allocate a new block group later.
> >   echo
> >   echo "Creating test file with initial data..."
> >   xfs_io -c "pwrite -S 0xab -b 1M 0 900M" $MNT/foobar
> >
> >   # Now try a direct IO write against file range [0, 10M[.
> >   # This should succeed since this is a NOCOW file and an extent for the
> >   # range was previously allocated.
> >   echo
> >   echo "Trying direct IO write over allocated space..."
> >   xfs_io -d -c "pwrite -S 0xcd -b 10M 0 10M" $MNT/foobar
> >
> >   umount $MNT
> >
> > When running the test:
> >
> >   $ ./dio-nocow-enospc.sh
> >   (...)
> >
> >   Creating test file with initial data...
> >   wrote 943718400/943718400 bytes at offset 0
> >   900 MiB, 900 ops; 0:00:01.43 (625.526 MiB/sec and 625.5265 ops/sec)
> >
> >   Trying direct IO write over allocated space...
> >   pwrite: No space left on device
> >
> > A test case for fstests will follow, testing both this direct IO write
> > scenario as well as the buffered IO write scenario to make it less likely
> > to get future regressions on the buffered IO case.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> This makes me nervous because now we're holding the extent lock while doing
> space reservations.  It's safe here because we make sure there's no pagecache
> after we've locked the range, so I can't imagine a scenario where we would

Right. I thought about that, but we flushed anything within the range,
and no one
can dirty pages there before we unlock it.

> deadlock, but my lack of imagination doesn't keep problems from happening.  As
> it stands I have no strong objections, but it would make me feel better if you
> hammered on this a bunch to make sure there's no dark corner we're missing.

3 days hammered with fio using a mix of buffered, direct io and mmap,
besides fstests.

>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
